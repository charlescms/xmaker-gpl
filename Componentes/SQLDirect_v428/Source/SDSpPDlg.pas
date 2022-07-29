
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       StoredProc Parameter Dialog    			}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}

unit SDSpPDlg;

interface

{$I SqlDir.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, TypInfo,
{$IFDEF SD_VCL6}
  Variants,
{$ENDIF}
  SDConsts, SDCommon, SDEngine;

type
  TSDStoredProcParamDlg = class(TForm)
    gbxParameters: TGroupBox;
    lbParamName: TListBox;
    cbParamType: TComboBox;
    cbParamDataType: TComboBox;
    edParamValue: TEdit;
    cbNullValue: TCheckBox;
    lblParamName: TLabel;
    lblParamType: TLabel;
    lblParamDataType: TLabel;
    lblParamValue: TLabel;
    btOk: TButton;
    btCancel: TButton;
    btHelp: TButton;
    btAdd: TButton;
    btDelete: TButton;
    btClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ParamNameClick(Sender: TObject);
    procedure ParamTypeChange(Sender: TObject);
    procedure ParamDataTypeChange(Sender: TObject);
    procedure ParamDataTypeExit(Sender: TObject);
    procedure NullValueChanged(Sender: TObject);
    procedure ParamValueExit(Sender: TObject);
    procedure AddParamClick(Sender: TObject);
    procedure DeleteParamClick(Sender: TObject);
    procedure ParamsClearClick(Sender: TObject);
  private
    { Private declarations }
    FParams: TSDHelperParams;
    procedure CheckParamCount;
    procedure CheckParamType(AParamType: TSDHelperParamType);
    procedure LoadParamType;
    procedure LoadParamDataType;
    procedure SetParams(AParams: TSDHelperParams);
    procedure SetParamDescAvailable(Value: Boolean);
  public
    { Public declarations }
    property Params: TSDHelperParams write SetParams;
    property ParamDescAvailable: Boolean write SetParamDescAvailable;
  end;

var
  SDStoredProcParamDlg: TSDStoredProcParamDlg;

function EditStoredProcParams(StoredProc: TSDStoredProc; AList: TSDHelperParams): Boolean;

implementation

{$R *.DFM}

const
  ParamTypeNames: array[TSDHelperParamType] of string = (
  	'Unknown', 'Input', 'Output', 'Input/Output', 'Result');
	// Convert: TSDParamType -> index(Integer)
  ParamTypeIndex: array[TSDHelperParamType] of Integer = (
  	0, 		1, 	3, 	2, 		4);
	// Convert: index(Integer) -> TSDParamType
  ParamTypeFromIndex: array[Ord(ptUnknown)..Ord(ptResult)] of TSDHelperParamType = (
  	ptUnknown, ptInput, ptInputOutput, ptOutput, ptResult);


function EditStoredProcParams(StoredProc: TSDStoredProc; AList: TSDHelperParams): Boolean;
var
  Dlg: TSDStoredProcParamDlg;
begin
  Result := False;
  Dlg := TSDStoredProcParamDlg.Create(Application);
  try
    if (StoredProc.Owner is TForm) then
      Dlg.Caption := Format(SParamEditor, [(StoredProc.Owner as TForm).Name, StoredProc.Name]);

    Dlg.ParamDescAvailable := StoredProc.DescriptionsAvailable;
    Dlg.Params := AList;
    if Dlg.ShowModal = mrOk then
      Result := True;
  finally
    Dlg.Free;
  end;
end;


{ TSDSPParamDlg }
procedure TSDStoredProcParamDlg.CheckParamCount;
begin
  cbParamType.Enabled	:= lbParamName.Items.Count > 0;
  if not cbParamType.Enabled then
    cbParamType.ItemIndex	:= -1;
  cbParamDataType.Enabled:= lbParamName.Items.Count > 0;
  if not cbParamDataType.Enabled then
    cbParamDataType.ItemIndex	:= -1;
  edParamValue.Enabled	:= lbParamName.Items.Count > 0;
  if not edParamValue.Enabled then
    edParamValue.Clear;
  cbNullValue.Enabled	:= lbParamName.Items.Count > 0;
  if not cbNullValue.Enabled then
    cbNullValue.Checked	:= False;
end;

procedure TSDStoredProcParamDlg.CheckParamType(AParamType: TSDHelperParamType);
begin
  if AParamType in [ptOutput, ptResult] then begin
    edParamValue.Text	:= '';
    edParamValue.Enabled:= False;
    cbNullValue.Checked := False;
    cbNullValue.Enabled := False;
  end else begin
    edParamValue.Enabled:= True;
    cbNullValue.Enabled	:= True;
  end;
end;

procedure TSDStoredProcParamDlg.LoadParamType;
var
  i: Integer;
begin
  for i := Low(ParamTypeFromIndex) to High(ParamTypeFromIndex) do
    cbParamType.Items.Add( ParamTypeNames[ ParamTypeFromIndex[i] ] );
end;

procedure TSDStoredProcParamDlg.LoadParamDataType;
var
  i, Ind: Integer;
  s: string;
begin
  for i := Ord(ftUnknown)+1 to Ord(ftGraphic) do begin
    s := GetEnumName(TypeInfo(TFieldType), i);
    Ind := cbParamDataType.Items.Add( Copy(s, 3, Length(s)-2) );
    SendMessage( cbParamDataType.Handle, CB_SETITEMDATA, Ind, i );
  end;
end;

procedure TSDStoredProcParamDlg.SetParams(AParams: TSDHelperParams);
var
  i: Integer;
begin
  for i:=0 to AParams.Count-1 do
    lbParamName.Items.Add( AParams[i].Name );
  FParams := AParams;
  CheckParamCount;
  if lbParamName.Items.Count > 0 then begin
    lbParamName.ItemIndex := 0;
    ParamNameClick(Self);
  end;
end;

procedure TSDStoredProcParamDlg.SetParamDescAvailable(Value: Boolean);
begin
  btAdd.Enabled		:= not Value;
  btDelete.Enabled	:= not Value;
  btClear.Enabled	:= not Value;
end;

procedure TSDStoredProcParamDlg.FormCreate(Sender: TObject);
begin
  CheckParamCount;

  LoadParamType;
  LoadParamDataType;
end;

procedure TSDStoredProcParamDlg.ParamNameClick(Sender: TObject);
var
  s: string;
  Idx: Integer;
begin
  Idx := lbParamName.ItemIndex;
  if (Idx < 0) or (FParams = nil) then
    Exit;
  cbParamType.ItemIndex		:= ParamTypeIndex[FParams[Idx].ParamType];

  s := GetEnumName( TypeInfo(TFieldType), Ord(FParams[Idx].DataType) );
  cbParamDataType.ItemIndex	:= SendMessage( cbParamDataType.Handle, CB_FINDSTRING, -1, LPARAM(PChar(Copy(s, 3, Length(s)-2))) );

  cbNullValue.Checked	:= FParams[Idx].IsNull;
  if cbNullValue.Checked then
    edParamValue.Text	:= ''
  else
    edParamValue.Text	:= FParams[Idx].AsString;

  CheckParamType(FParams[Idx].ParamType);
end;

procedure TSDStoredProcParamDlg.ParamTypeChange(Sender: TObject);
begin
  FParams[lbParamName.ItemIndex].ParamType := ParamTypeFromIndex[cbParamType.ItemIndex];

  CheckParamType(FParams[lbParamName.ItemIndex].ParamType);
end;

procedure TSDStoredProcParamDlg.ParamDataTypeChange(Sender: TObject);
begin
  edParamValue.Clear;
end;

procedure TSDStoredProcParamDlg.ParamDataTypeExit(Sender: TObject);
begin
  if (cbParamDataType.ItemIndex > -1) and (lbParamName.ItemIndex > -1) then
    FParams[lbParamName.ItemIndex].DataType :=
    	TFieldType( SendMessage( cbParamDataType.Handle, CB_GETITEMDATA, cbParamDataType.ItemIndex, 0 ) );
end;

procedure TSDStoredProcParamDlg.ParamValueExit(Sender: TObject);
var
  V: Variant;
  vtype: Integer;
begin
  if (cbParamType.ItemIndex > -1) and (lbParamName.ItemIndex > -1) then begin
    case FParams[lbParamName.ItemIndex].DataType of
      ftSmallInt: vtype := varSmallint;
      ftWord,
      ftInteger:  vtype := varInteger;
      ftBCD:      vtype := varCurrency;
      ftFloat:    vtype := varDouble;
      ftDate,
      ftTime,
      ftDateTime: vtype := varDate;
      ftBoolean:  vtype := varBoolean;
      ftString:   vtype := varString;
    else
      vtype := varUnknown;
    end;

    try
      cbNullValue.Checked := edParamValue.Text = '';
      if not cbNullValue.Checked then begin
        V := VarAsType(edParamValue.Text, vtype);
        FParams[lbParamName.ItemIndex].Value := V;
      end;
    except
      on EVariantError do begin
        edParamValue.SetFocus;
        raise;
      end;
    end;
  end;
end;

procedure TSDStoredProcParamDlg.NullValueChanged(Sender: TObject);
begin
  if cbNullValue.Checked then begin
    FParams[lbParamName.ItemIndex].Clear;
    if edParamValue.Text <> '' then
      edParamValue.Text := '';
  end;
end;

procedure TSDStoredProcParamDlg.AddParamClick(Sender: TObject);
var
  sParamName: string;
begin
  if not InputQuery('Define Parameter', '&Parameter name:', sParamName) then
    Exit;
  FParams.CreateParam(ftUnknown, sParamName, ptUnknown);

  lbParamName.ItemIndex := lbParamName.Items.Add(sParamName);
  CheckParamCount;
  ParamNameClick(Self);
end;

procedure TSDStoredProcParamDlg.DeleteParamClick(Sender: TObject);
var
  p: TSDHelperParam;
  Idx: Integer;
begin
  if lbParamName.Items.Count = 0 then
    Exit;

  Idx := lbParamName.ItemIndex;
  p := FParams[Idx];
  FParams.RemoveParam(p);
  p.Free;
  lbParamName.Items.Delete(Idx);

  if lbParamName.Items.Count = 0 then
    Idx := -1
  else if Idx >= lbParamName.Items.Count then
    Idx := lbParamName.Items.Count - 1;
  if Idx >= 0 then
    lbParamName.ItemIndex := Idx;

  CheckParamCount;
  ParamNameClick(Self);
end;

procedure TSDStoredProcParamDlg.ParamsClearClick(Sender: TObject);
begin
  FParams.Clear;

  lbParamName.Items.Clear;
  CheckParamCount;
end;

end.
