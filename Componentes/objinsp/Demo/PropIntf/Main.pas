(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PropList, PropIntf, StdCtrls, ExtCtrls, TypInfo;

type
  TfrmMain = class(TForm)
    cmbComponents: TComboBox;
    lsbProperties: TListBox;
    cmpPropertyInterface: TPropertyInterface;
    rgrMode: TRadioGroup;
    memInfo: TMemo;
    lblValue: TLabel;
    btnValue: TButton;
    cmbValue: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ChangePropertyList(Sender: TObject);
    procedure lsbPropertiesClick(Sender: TObject);
    procedure SetValue(Sender: TObject);
  private
    { Private declarations }
    procedure ListProperties;
    procedure RetreiveInformation;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.ListProperties;
var
  i: Integer;

  procedure ListProperty(P: TProperty; Strings: TStrings);
  var
    i: Integer;

    function Indent: string;
    var
      i: Integer;
    begin
      Result:='';
      for i:=1 to P.Level do Result:=Result+'    ';
    end;

  begin
    with P do
    begin
      with rgrMode do
        if (ItemIndex=0) or
          ((ItemIndex=1) and (P.TypeKind<>tkMethod)) or
          ((ItemIndex=2) and (P.TypeKind=tkMethod)) then Strings.AddObject(Indent+P.Name,P);
      for i:=0 to Pred(Properties.Count) do ListProperty(Properties[i],Strings);
    end;
  end;

begin
  with lsbProperties,Items do
  begin
    BeginUpdate;
    try
      Clear;
      for i:=0 to Pred(cmpPropertyInterface.Count) do
        ListProperty(cmpPropertyInterface.Properties[i],Items);
      if Count>0 then ItemIndex:=0;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmMain.RetreiveInformation;
var
  i: Integer;
  P: TProperty;

  procedure AddInfo(Capt,Data: string);
  const
    CaptLen = 20;
  var
    i: Integer;
  begin
    for i:=Succ(Length(Capt)) to CaptLen do Capt:=Capt+' ';
    memInfo.Lines.Add(Capt+#9+Data);
  end;

begin
  with memInfo.Lines do
  begin
    BeginUpdate;
    try
      Clear;
      with lsbProperties,Items do
        if ItemIndex>-1 then
        begin
          P:=TProperty(Objects[ItemIndex]);
          with P do
          begin
            AddInfo('Name',Name);
            AddInfo('FullName',FullName);
            AddInfo('TypeName',TypeName);
            AddInfo('TypeKind',GetEnumName(TypeInfo(TTypeKind),Integer(TypeKind)));
            if Emulated then AddInfo('Emulated','Yes')
            else
            begin
              AddInfo('Emulated','No');
              case TypeKind of
                tkInteger,tkChar,tkEnumeration,tkSet,tkWChar:
                begin
                  AddInfo('OrdType',GetEnumName(TypeInfo(TOrdType),Integer(OrdType)));
                  case TypeKind of
                    tkInteger,tkChar,tkEnumeration,tkWChar:
                    begin
                      AddInfo('MinValue',IntToStr(MinValue));
                      AddInfo('MaxValue',IntToStr(MaxValue));
                      if TypeKind=tkEnumeration then
                      begin
                        AddInfo('BaseType',BaseType.Name);
                        AddInfo('Names',Names[MinValue]);
                        for i:=Succ(MinValue) to MaxValue do AddInfo('',Names[i]);
                      end;
                    end;
                    tkSet: AddInfo('CompType',CompType.Name);
                  end;
                end;
                tkFloat: AddInfo('FloatType',GetEnumName(TypeInfo(TFloatType),Integer(FloatType)));
                tkString: AddInfo('MaxLength',IntToStr(MaxLength));
                tkClass:
                begin
                  AddInfo('ParentClass',ParentInfo.Name);
                  AddInfo('UnitName',UnitName);
                end;
                tkMethod: AddInfo('Declaration',MethodDeclaration);
              end;
            end;
            with cmbValue do
            begin
              ValuesList(Items);
              Text:=P.AsString;
              SelectAll;
            end;
          end;
        end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to Pred(ComponentCount) do
    with Components[i] do
      cmbComponents.Items.AddObject(Name+': '+ClassName,Self.Components[i]);
  cmbComponents.ItemIndex:=cmbComponents.Items.AddObject(Name+': '+ClassName,Self);
  ListProperties;
  ActiveControl:=cmbComponents;
  RetreiveInformation;
end;

procedure TfrmMain.ChangePropertyList(Sender: TObject);
begin
  with cmbComponents do
    cmpPropertyInterface.Instance:=TComponent(Items.Objects[ItemIndex]);
  ListProperties;
  RetreiveInformation;
end;

procedure TfrmMain.lsbPropertiesClick(Sender: TObject);
begin
  RetreiveInformation;
end;

procedure TfrmMain.SetValue(Sender: TObject);
begin
  try
    with lsbProperties,Items do
      if ItemIndex>-1 then
        TProperty(Objects[ItemIndex]).AsString:=cmbValue.Text;
  except
    ShowMessage('Invalid property value');
  end;
  RetreiveInformation;
end;

end.
