
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       Query Parameter Dialog   			}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}

unit SDQPDlg;

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
  { TSDQryParamDlg }
  TSDQueryParamDlg = class(TForm)
    gbxParameters: TGroupBox;
    cbParamType: TComboBox;
    edParamValue: TEdit;
    lbParamName: TListBox;
    cbNullValue: TCheckBox;
    lblParamName: TLabel;
    lblParamType: TLabel;
    lblParamValue: TLabel;
    btOk: TButton;
    btCancel: TButton;
    btHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ParamNameClick(Sender: TObject);
    procedure ParamTypeChange(Sender: TObject);
    procedure ParamTypeExit(Sender: TObject);
    procedure ParamValueExit(Sender: TObject);
    procedure NullValueChanged(Sender: TObject);
  private
    { Private declarations }
    FParams: TSDHelperParams;
    procedure CheckParamCount;
    procedure LoadParamDataType;
    procedure SetParams(AParams: TSDHelperParams);
  public
    { Public declarations }
    property Params: TSDHelperParams write SetParams;
  end;

var
  SDQueryParamDlg: TSDQueryParamDlg;

function EditQueryParams(AQuery: TSDQuery; AList: TSDHelperParams): Boolean;

implementation

{$R *.DFM}


function EditQueryParams(AQuery: TSDQuery; AList: TSDHelperParams): Boolean;
var
  Dlg: TSDQueryParamDlg;
begin
  Result := False;
  Dlg := TSDQueryParamDlg.Create(Application);
  try
    if (AQuery.Owner is TForm) then
      Dlg.Caption := Format(SParamEditor, [(AQuery.Owner as TForm).Name, AQuery.Name]);

    Dlg.Params := AList;
    if Dlg.ShowModal = mrOk then
      Result := True;
  finally
    Dlg.Free;
  end;
end;

{ TSDQryParamDlg }
procedure TSDQueryParamDlg.CheckParamCount;
begin
  cbParamType.Enabled	:= lbParamName.Items.Count > 0;
  edParamValue.Enabled	:= lbParamName.Items.Count > 0;
  cbNullValue.Enabled	:= lbParamName.Items.Count > 0;
end;

procedure TSDQueryParamDlg.LoadParamDataType;
var
  i, Ind: Integer;
  s: string;
begin
  for i:=Ord(ftUnknown)+1 to Ord(ftGraphic) do begin
    s := GetEnumName(TypeInfo(TFieldType), i);
    Ind := cbParamType.Items.Add( Copy(s, 3, Length(s)-2) );
    SendMessage( cbParamType.Handle, CB_SETITEMDATA, Ind, i );
  end;
end;

procedure TSDQueryParamDlg.SetParams(AParams: TSDHelperParams);
var
  i: Integer;
begin
  for i:=0 to AParams.Count-1 do
    if lbParamName.Items.IndexOf(AParams[i].Name) < 0 then
      lbParamName.Items.Add(AParams[i].Name);
  FParams := AParams;
  CheckParamCount;
  if lbParamName.Items.Count > 0 then begin
    lbParamName.ItemIndex := 0;
    ParamNameClick(Self);
  end;
end;

procedure TSDQueryParamDlg.FormCreate(Sender: TObject);
begin
  CheckParamCount;

  LoadParamDataType;
end;

procedure TSDQueryParamDlg.ParamNameClick(Sender: TObject);
var
  s: string;
begin
  if lbParamName.ItemIndex < 0 then
    Exit;
  s := GetEnumName( TypeInfo(TFieldType), Ord(FParams[lbParamName.ItemIndex].DataType) );
  cbParamType.ItemIndex	:= SendMessage( cbParamType.Handle, CB_FINDSTRING, -1, LPARAM(PChar(Copy(s, 3, Length(s)-2))) );
  cbNullValue.Checked	:= FParams[lbParamName.ItemIndex].IsNull;
  if cbNullValue.Checked then
    edParamValue.Text	:= ''
  else
    edParamValue.Text	:= FParams[lbParamName.ItemIndex].AsString
end;

procedure TSDQueryParamDlg.ParamTypeChange(Sender: TObject);
begin
  edParamValue.Clear;
end;

procedure TSDQueryParamDlg.ParamTypeExit(Sender: TObject);
begin
  if (cbParamType.ItemIndex > -1) and (lbParamName.ItemIndex > -1) then
    FParams[lbParamName.ItemIndex].DataType :=
    	TFieldType( SendMessage( cbParamType.Handle, CB_GETITEMDATA, cbParamType.ItemIndex, 0 ) );
end;

procedure TSDQueryParamDlg.ParamValueExit(Sender: TObject);
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

procedure TSDQueryParamDlg.NullValueChanged(Sender: TObject);
begin
  if cbNullValue.Checked then begin
    FParams[lbParamName.ItemIndex].Clear;
    if edParamValue.Text <> '' then
      edParamValue.Text := '';
  end;
end;

end.
