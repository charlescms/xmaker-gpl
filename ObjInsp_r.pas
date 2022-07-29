unit ObjInsp_r;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, TypInfo, PopupLb, Menus, SynEdit, ComCtrls,
  ToolWin, Variants;

type
  TFormObjInsp_Rel = class;

  TProp = class(TObject)
  private
    procedure SetValue(Value: Variant);
    function GetValue: Variant;
    function IsEnumNull: Boolean;
  public
    Text: String;
    Editor: TNotifyEvent;
    Enum: TStringList;
    EnumValues: Variant;
    constructor Create(PropValue: Variant;
      PropEnum: TStringList; PropEnumValues: Variant; PropEditor: TNotifyEvent); virtual;
    destructor Destroy; override;
    property Value: Variant read GetValue write SetValue;
  end;

  TFormObjInsp_Rel = class(TForm)
    Box: TScrollBox;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    EditPanel: TPanel;
    ComboPanel: TPanel;
    EditBtn: TSpeedButton;
    ComboBtn: TSpeedButton;
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    CB1: TComboBox;
    ControlBar2: TControlBar;
    ToolBar1: TToolBar;
    BtnFonte: TToolButton;
    BtnOrdemTab: TToolButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBtnClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CB1Click(Sender: TObject);
    procedure ComboBtnClick(Sender: TObject);
    procedure LB1Click(Sender: TObject);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BtnFonteClick(Sender: TObject);
    procedure CB1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPaginasClick(Sender: TObject);
    procedure BtnOrdemTabClick(Sender: TObject);
  private
    { Private declarations }
    FItems: TStringList;
    FItemIndex: Integer;
    FRowHeight: Integer;
    w, w1: Integer;
    b: TBitmap;
    BusyFlag, BusyFlag1: Boolean;
    DefHeight: Integer;
    EditRect : TRect;
    LB1: TPopupListBox;
    FTickCount: Integer;
    PanelObj: TPanel;
    FOnHeightChanged: TNotifyEvent;
    FDown: Boolean;
    LastProp: String;
    Posicao_Unit: Integer;
    procedure SetItems(Value: TStringList);
    procedure SetItemIndex(Value: Integer);
    function GetCount: Integer;
    procedure DrawOneLine(i: Integer; a: Boolean);
    procedure SetItemValue(Value: String);
    function GetItemValue(i: Integer): String;
    function CurItem: TProp;
    procedure WMNCLButtonDblClk(var Message: TMessage); message WM_NCLBUTTONDBLCLK;
    function GetPropValue(Index: Integer): Variant;
    procedure SetPropValue(Index: Integer; Value: Variant);
    function GetClassName(ObjName: String): String;
  public
    { Public declarations }
    CurObject: TObject;
    ObjectName: String;
    HideProperties: Boolean;
    procedure Atribui(Sender: TObject; Tudo: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ClearProperties(Tudo: Boolean);
    procedure Inicializa(Sender: TObject);
    procedure AddProperty(PropName: String; PropValue: Variant;
     PropEnum: TStringList; PropEnumValues: Variant;
     PropEditor: TNotifyEvent);
    procedure InsertProperty(Index: Integer; PropName: String; PropValue: Variant;
     PropEnum: TStringList; PropEnumValues: Variant;
     PropEditor: TNotifyEvent);
    procedure ItemsChanged;
    procedure Grow;
    property PropValue[Index: Integer]: Variant read GetPropValue write SetPropValue;
    property Items: TStringList read FItems write SetItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Count: Integer read GetCount;
    property SplitterPos: Integer read w1 write w1;
    function GetPropAsString(Obj: TObject; Info: PPropInfo; SubItem: Boolean): string;
  end;

  TPropertyInspector = class(TComponent)
  private
    FEventos: Integer;
    ListaProp: TStringList;
    ListaTipos: TStringList;
    ListaValor: TStringList;
    ListaPosicao: TStringList;
    ListaObject: TList;
    VControl: TControl;
    PosicaoIndex: Integer;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update(Sender: TObject);
  published

  end;

  TParamFlag = (pfVar, pfConst, pfArray);
  TParamFlags = set of TParamFlag;
  PParamString = PShortString;
  TParamInfo = record
    Flags: TParamFlags;
    ParamName: PParamString;
    ParamType: PParamString;
  end;
  TParamList = array[0..255] of TParamInfo;
  PParamList = ^TParamList;

var
  FormObjInsp_Rel: TFormObjInsp_Rel;
  PropInspector: TPropertyInspector;

const
  Comum = 'Left;Top;Width;Height;';

implementation

{$R *.DFM}

uses PicEdit, StrEdit, Rotinas, MiniEditor, Form_Rel, Relator;

const
  tkProps = [tkUnknown,tkInteger,tkChar,tkEnumeration,tkFloat,tkString,tkSet,
             tkClass,tkMethod,tkWChar,tkLString,tkWString,tkVariant];

  frColors: Array[0..41] of TColor =
    (clWhite, clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal,
     clGray, clSilver, clRed, clLime, clYellow, clBlue, clFuchsia,
     clAqua, clNone,
     clScrollBar, clBackground, clActiveCaption, clInactiveCaption,
     clMenu, clWindow, clWindowFrame, clMenuText, clWindowText,
     clCaptionText, clActiveBorder, clInactiveBorder, clAppWorkSpace,
     clHighlight, clHighlightText, clBtnFace, clBtnShadow, clGrayText,
     clBtnText, clInactiveCaptionText, clBtnHighlight, cl3DDkShadow,
     cl3DLight, clInfoText, clInfoBk);

  frColorNames: Array[0..41] of String =
    ('clWhite', 'clBlack', 'clMaroon', 'clGreen', 'clOlive', 'clNavy',
     'clPurple', 'clTeal', 'clGray', 'clSilver', 'clRed', 'clLime',
     'clYellow', 'clBlue', 'clFuchsia', 'clAqua', 'clTransparent',
     'clScrollBar', 'clBackground', 'clActiveCaption', 'clInactiveCaption',
     'clMenu', 'clWindow', 'clWindowFrame', 'clMenuText', 'clWindowText',
     'clCaptionText', 'clActiveBorder', 'clInactiveBorder', 'clAppWorkSpace',
     'clHighlight', 'clHighlightText', 'clBtnFace', 'clBtnShadow', 'clGrayText',
     'clBtnText', 'clInactiveCaptionText', 'clBtnHighlight', 'cl3DDkShadow',
     'cl3DLight', 'clInfoText', 'clInfoBk');

type
  TInspPanel = class(TPanel)
  protected
    procedure WMEraseBackground(var Message: TMessage); message WM_ERASEBKGND;
    procedure Paint; override;
  end;

procedure TInspPanel.WMEraseBackground(var Message: TMessage);
begin
end;

procedure TInspPanel.Paint;
begin
end;

{----------------------------------------------------------------------------}
procedure GetParamInfo(Data: PTypeData; var Params: TParamList;
                       var ReturnType: PParamString);
var
  I: Integer;
  Ptr: PByte;
begin
  with Data^ do
  begin
    Ptr := PByte(@ParamList);
    for I := 0 to ParamCount-1 do
      with Params[I] do
      begin
        Flags := TParamFlags(Ptr^);
        Inc(Ptr);
        ParamName := PParamString(Ptr);
        Inc(Ptr, Length(ParamName^) + 1);
        ParamType := PParamString(Ptr);
        Inc(Ptr, Length(ParamType^) + 1);
      end;
    if MethodKind = mkFunction then
      ReturnType := PParamString(Ptr);
  end;
end;

function WriteMethodData(Data: PTypeData):string;
var
  I: Integer;
  Params: PParamList;
  Return: PParamString;
  MethodPara:string;
begin
  with Data^ do
  begin
    { Allocate memory to hold all the parameter information }
    GetMem(Params, ParamCount * SizeOf(TParamInfo));
    try
      GetParamInfo(Data, Params^, Return);
      { Write each parameter: }
      for I := 0 to ParamCount-1 do
        with Params^[I] do
        begin
          if pfVar in Flags then
            MethodPara:=MethodPara+'var ';
          if pfConst in Flags then
            MethodPara:=MethodPara+'const ';
          MethodPara:=MethodPara+ParamName^+ ': ';
          if pfArray in Flags then
            MethodPara:=MethodPara+'array of ';
          MethodPara:=MethodPara+ParamType^+';';
        end;
    finally
      FreeMem(Params, ParamCount * SizeOf(TParamInfo));
    end;
  end;
  if MethodPara[Length(MethodPara)]=';' then
     MethodPara:=Copy(MethodPara,1,Length(MethodPara)-1);
  Result:=MethodPara;
end;

function EnumName(Value: LongInt; Info: PTypeInfo): string;
var
  Data: PTypeData;
begin
  Data:=GetTypeData(Info);
  if (Value < Data^.MinValue) or (Value > Data^.MaxValue) then
    Value:=Data^.MinValue;
  Result:=GetEnumName(Info,Value);
end;

function EnumValue(Value: LongInt; Info: PTypeInfo; Name: String): integer;
var
  Data: PTypeData;
begin
  Data:=GetTypeData(Info);
  if (Value < Data^.MinValue) or (Value > Data^.MaxValue) then
    Value:=Data^.MinValue;
  Result:=GetEnumValue(Info,Name);
end;

function SetToString(const SetValue; Info: PTypeInfo): string;
var
  MaskValue,I: LongInt;
  Data,CompData: PTypeData;
  CompInfo: PTypeInfo;
begin
  Data:=GetTypeData(Info);
  CompInfo:=Data^.CompType^;
  CompData:=GetTypeData(CompInfo);
  MaskValue:=LongInt(SetValue);
  Result:='[';
  for I:=CompData^.MinValue to CompData^.MaxValue do
  begin
    if (MaskValue and 1) <> 0 then Result:=Result + EnumName(I,CompInfo) + ',';
    MaskValue:=MaskValue shr 1;
  end;
  if Result[Length(Result)] = ',' then Delete(Result,Length(Result),1);
  Result:=Result + ']';
end;

function IsA(PI : PTypeInfo; S : String) : Boolean;
var PTD : PTypeData;
    PTI : PTypeInfo;
    Found : Boolean;
begin
  Found := False;
  S := UpperCase(S);
  PTI := PI;
  While (Not Found) and (UpperCase(PTI^.Name) <> 'TOBJECT') do Begin
    Found := UpperCase(PTI^.Name) = S;
    PTD := GetTypeData(PTI);
    PTI := PTD^.ParentInfo^;
  End;
  IsA := Found;
end;

function GetPropAsTipo(Obj: TObject; Info: PPropInfo; Tipo: Integer): string;
var
  Count,I: Integer;
  IntVal: LongInt;
  PropList: PPropList;
  Data: PTypeData;
  MethodValue: TMethod;
begin
  Result:='';
  Count:=GetPropList(Obj.ClassInfo,tkProps,nil);
  if Count < 1 then Exit;
  if Info^.PropType^.Kind=tkMethod then
  begin
    MethodValue:= GetMethodProp(Obj, Info);
    if (MethodValue.Code <> nil) then
      Result := Info^.Name
    else
      Result:= '';
  end
  else
  begin
    GetMem(PropList,Count * SizeOf(PPropInfo));
    try
      GetPropList(Obj.ClassInfo,tkProps,PropList);
      for I:=0 to Pred(Count) do with PropList^[I]^ do
      begin
        if (Info = nil) or (UpperCase(Name) = UpperCase(Info^.Name)) then
        begin
          case PropType^.Kind of
            tkUnknown     : begin
                              if Tipo = 1 then
                                Result:='Panel'
                              else
                                Result:='String';
                            end;
            tkInteger     : begin
                              if Tipo = 1 then
                              begin
                                if (PropType^.Name = 'TColor') then
                                   Result := 'Color'
                                else
                                  if (PropType^.Name = 'TCursor') then
                                    Result := 'Cursor'
                                  else
                                    Result:='Edit';
                              end
                              else
                                Result := 'Integer';
                            end;
            tkChar        : begin
                              if Tipo = 1 then
                                Result:='Edit'
                              else
                                Result:='Char';
                            end;
            tkEnumeration : begin
                              if Tipo = 1 then
                              begin
                                if (PropType^.Name = 'Boolean') then
                                  Result:='Boolean'
                                else
                                  Result:='Combo';
                              end
                              else
                                Result:='Set';
                            end;
            tkFloat       : begin
                              if Tipo = 1 then
                                Result:='Edit'
                              else
                                Result:='Float'
                            end;
            tkString,tkLString : begin
                                   if tipo = 1 then
                                     Result :='Edit'
                                   else
                                     Result:='String'
                                 end;
            tkSet         : begin
                              if Tipo = 1 then
                                Result:='Edit_R'
                              else
                                Result:='Set';
                            end;
            tkClass       : begin
                              if Tipo = 1 then
                              begin
                                Data:=GetTypeData(Info^.PropType^);
                                if Data^.PropCount>0 then
                                begin
                                  if (PropType^.Name = 'TFont') then
                                    Result:='Font'
                                  else
                                    Result:='Edit_R'
                                end
                                else if (PropType^.Name = 'TBitmap') then
                                  Result:='Bitmap'
                                else if (PropType^.Name = 'TPicture') then
                                  Result:='Picture'
                                else if (PropType^.Name = 'TStrings') then
                                  Result:='StringList';
                              end
                              else
                                Result:='String';
                            end;
            end;
        end;
      end;
    finally
      FreeMem(PropList,Count * SizeOf(PPropInfo));
    end;
  end;
end;

function InsertPropInfo(Info:PPropInfo;Sender:TObject;Index:Integer): Integer;
var
   PropName, Conteudo:string;
   Data:PTypeData;
   P, I, Count, IntVal:Integer;
   TypeInfo:PTypeInfo;
   PropList:PPropList;
   CompData: PTypeData;
   CompInfo: PTypeInfo;
   S: TIntegerSet;
   ob: TObject;
begin
   if Info = nil then Exit;
   if Sender<>nil then
   begin
      case Info^.PropType^.Kind of
          tkClass:
          begin
            TypeInfo:= Info^.PropType^;
            Count:=GetPropList(TypeInfo,tkProperties,nil);
            GetMem(PropList, Count*SizeOf(PPropInfo));
            GetPropInfos(TypeInfo, PropList);
            Data:=GetTypeData(Info^.PropType^);
            P := Index;
            InsertPropInfo := Data^.PropCount;
            for I:=0 to Data^.PropCount - 1 do
            begin
              if PropList[I]^.Proptype^.Kind <> tkMethod then
              begin
                PropName:= '    ' + PropList^[I].Name;
                Conteudo := FormObjInsp_Rel.GetPropAsString(TObject(GetOrdProp(Sender, Info)),PropList[I],True);
                inc(P);
                if Copy(Conteudo,01,01) <> '+' then
                  PropInspector.ListaProp.Insert(P, PropName + ': ' + Conteudo)
                else
                  PropInspector.ListaProp.Insert(P,'+' +PropName + ': ' + Copy(Conteudo,02,250));
                PropInspector.ListaTipos.Insert(P, GetPropAsTipo(TObject(GetOrdProp(Sender, Info)),PropList[I],1));
                PropInspector.ListaValor.Insert(P, GetPropAsTipo(TObject(GetOrdProp(Sender, Info)),PropList[I],2));
                PropInspector.ListaPosicao.Insert(P, IntToStr(I));
                PropInspector.ListaObject.Insert(P,TObject(GetOrdProp(Sender, Info)));
              end;
            end;
          end;
          tkSet:
          begin
            Count:=GetPropList(Sender.ClassInfo,tkProps,nil);
            GetMem(PropList, Count*SizeOf(PPropInfo));
            Data:=GetTypeData(Info^.PropType^);
            CompInfo:=Data^.CompType^;
            CompData:=GetTypeData(CompInfo);
            P :=Index;
            InsertPropInfo := (CompData^.MaxValue - CompData^.MinValue) + 1;
            for I:=CompData^.MinValue to CompData^.MaxValue do
            begin
              inc(P);
              PropName := EnumName(I,CompInfo);
              ob := TObject(PropInspector.VControl);
              Integer(S) := GetOrdProp(ob, Info);
              if EnumValue(I,CompInfo,PropName) in S then
                Conteudo := 'True'
              else
                Conteudo := 'False';
              PropInspector.ListaProp.Insert(P, '    ' + PropName + ': ' + Conteudo);
              PropInspector.ListaValor.Insert(P, 'SetElement');
              PropInspector.ListaTipos.Insert(P, 'Boolean');
              PropInspector.ListaPosicao.Insert(P, IntToStr(I));
              PropInspector.ListaObject.Insert(P, TObject(GetOrdProp(ob, Info)));
            end;
          end;
      end;
      FreeMem(PropList, Count*SizeOf(PPropInfo));
   end;
end;

function DeletePropInfo(Info:PPropInfo;Sender:TObject;Index:Integer): Integer;
var
   Data:PTypeData;
   P, I,MinVal,MaxVal:Integer;
   TypeInfo:PTypeInfo;
begin
   if Info = nil then Exit;
   if Sender<>nil then begin
      case Info^.PropType^.Kind of
          tkClass: begin
              Data:=GetTypeData(Info^.PropType^);
              DeletePropInfo := Data^.PropCount;
              for I:=Data^.PropCount - 1 downto 0 do
              begin
                P :=Index + I + 1;
                PropInspector.ListaProp.Delete(P);
                PropInspector.ListaTipos.Delete(P);
                PropInspector.ListaValor.Delete(P);
                PropInspector.ListaPosicao.Delete(P);
                PropInspector.ListaObject.Delete(P);
              end;
          end;
          tkSet: begin
              Data:=GetTypeData(Info^.PropType^);
              TypeInfo:=Data^.CompType^;
              Data:=GetTypeData(TypeInfo);
              MinVal:=Data^.MinValue;
              MaxVal:=Data^.MaxValue;
              DeletePropInfo := (MaxVal-MinVal) + 1;
              for I:=MaxVal-MinVal  downto 0 do
              begin
                P :=Index + I + 1;
                PropInspector.ListaProp.Delete(P);
                PropInspector.ListaTipos.Delete(P);
                PropInspector.ListaValor.Delete(P);
                PropInspector.ListaPosicao.Delete(P);
                PropInspector.ListaObject.Delete(P);
              end;
          end;
      end;
   end;
end;

procedure GetProperties(Comp: TComponent; List: TStrings);
var
  I,PropItems: Integer;
  PropList: PPropList;
  PropInfo: PPropInfo;
  Conteudo: String;
begin
  if not Assigned(Comp) or not Assigned(List) then Exit;
  List.Clear;
  try
    PropItems:=GetPropList(Comp.ClassInfo,tkProperties,nil);
    for I:=0 to PropItems-1 do
    begin
      List.Add(' ');
      PropInspector.ListaTipos.Add('');
      PropInspector.ListaValor.Add('');
      PropInspector.ListaPosicao.Add('');
    end;
    if PropItems = 0 then Exit;
    GetMem(PropList,PropItems * SizeOf(PPropInfo));
    try
      GetPropList(Comp.ClassInfo,tkProperties,PropList);
      for I:=0 to PropItems-1 do
      begin
        PropInfo:=GetPropInfo(Comp.ClassInfo,PropList^[I]^.Name);
        if I < List.Count then
        begin
          Conteudo := FormObjInsp_Rel.GetPropAsString(Comp,PropInfo,False);
          if UpperCase(Trim(PropList^[I].Name)) = 'VISIBLE' then
            if FormDialogo_Rel.ListaInvisivel.IndexOf(UpperCase(Comp.Name)) > -1 then
              Conteudo := 'False';
          if UpperCase(Trim(PropList^[I].Name)) = 'ENABLED' then
            if FormDialogo_Rel.ListaDesabilitado.IndexOf(UpperCase(Comp.Name)) > -1 then
              Conteudo := 'False';
          if Copy(Conteudo,01,01) <> '+' then
            List[I]:=PropList^[I]^.Name + ': ' + Conteudo
          else
            List[I]:= '+' +PropList^[I]^.Name + ': ' + Copy(Conteudo,02,250);
          PropInspector.ListaTipos[I] := GetPropAsTipo(Comp,PropInfo,1);
          PropInspector.ListaValor[I] := GetPropAsTipo(Comp,PropInfo,2);
          PropInspector.ListaPosicao[I] := '0';
          PropInspector.ListaObject.Add(TObject(Comp));
        end;
      end;
    finally
      FreeMem(PropList,PropItems * SizeOf(PPropInfo));
    end;
  finally
  end;
end;

procedure GetEvent(Comp: TComponent; List: TStrings);
var
  I,P,Y,PropItems: Integer;
  PropList: PPropList;
  PropInfo: PPropInfo;
  StrParametros, StrEvento: String;
begin
  if not Assigned(Comp) or not Assigned(List) then Exit;
  P := List.Count;
  PropInspector.FEventos := P;
  try
    PropItems:=GetPropList(Comp.ClassInfo,tkMethodS,nil);
    for I:=0 to PropItems-1 do List.Add(' ');
    if PropItems = 0 then Exit;
    GetMem(PropList,PropItems * SizeOf(PPropInfo));
    try
      GetPropList(Comp.ClassInfo,tkMethodS,PropList);
      for I:=0 to PropItems-1 do
      begin
        PropInfo:=GetPropInfo(Comp.ClassInfo,PropList^[I]^.Name);
        StrParametros := WriteMethodData(GetTypeData(PropInfo^.PropType^))+')';
        //StrEvento := Comp.Name + Copy(PropList^[I]^.Name,03,40) + '(' + StrParametros;
        StrEvento := Comp.Name + Copy(PropList^[I]^.Name,03,40);
        Y := FormDialogo_Rel.ListaEventos.IndexOf(Comp.Name + ':' + StrEvento);
        if Y < 0 then
          StrEvento := '';
        if I < List.Count then
          List[I+P]:=PropList^[I]^.Name + ': ' + StrEvento;
          //List[I+P]:=PropList^[I]^.Name + ': ' + GetPropAsString(Comp,PropInfo,False);
      end;
    finally
      FreeMem(PropList,PropItems * SizeOf(PPropInfo));
    end;
  finally
  end;
end;

constructor TPropertyInspector.Create(AOwner: TComponent);
begin
  inherited;
  ListaProp := TStringList.Create;
  ListaTipos := TStringList.Create;
  ListaValor := TStringList.Create;
  ListaPosicao := TStringList.Create;
  ListaObject := TList.Create;
  PosicaoIndex := 0;
  PropInspector:=Self;
end;

destructor TPropertyInspector.Destroy;
begin
  ListaProp.Free;
  ListaTipos.Free;
  ListaValor.Free;
  ListaPosicao.Free;
  ListaObject.Free;
  inherited;
end;

procedure TPropertyInspector.Update(Sender: TObject);
begin
  GetProperties(TControl(Sender),listaProp);
  if FormDialogo_Rel.ListaSelecionados.Count = 1 then
    GetEvent(TControl(Sender),listaProp);
  VControl := TControl(Sender);
end;

{----------------------------------------------------------------------------}
constructor TProp.Create(PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant; PropEditor: TNotifyEvent);
begin
  inherited Create;
  Editor := PropEditor;
  Enum := PropEnum;
  EnumValues := PropEnumValues;
  Value := PropValue;
end;

destructor TProp.Destroy;
begin
  EnumValues := 0;
  inherited Destroy;
end;

function TProp.IsEnumNull: Boolean;
begin
  Result := TVarData(EnumValues).VType < varArray;
end;

procedure TProp.SetValue(Value: Variant);
begin
  Text := Value;
end;

function TProp.GetValue: Variant;
begin
  Result := Null;
end;

{----------------------------------------------------------------------------}
procedure TFormObjInsp_Rel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.WndParent := frDesigner.Handle;
end;

function TFormObjInsp_Rel.GetPropValue(Index: Integer): Variant;
begin
  Result := TProp(FItems.Objects[Index]).Value;
end;

procedure TFormObjInsp_Rel.SetPropValue(Index: Integer; Value: Variant);
begin
  TProp(FItems.Objects[Index]).Value := Value;
end;

procedure TFormObjInsp_Rel.ClearProperties(Tudo: Boolean);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TProp(FItems.Objects[i]).Free;
  FItems.Clear;
  if Tudo then
  begin
    PropInspector.ListaProp.Clear;
    PropInspector.ListaTipos.Clear;
    PropInspector.ListaValor.Clear;
    PropInspector.ListaPosicao.Clear;
    PropInspector.ListaObject.Clear;
  end;
end;

procedure TFormObjInsp_Rel.Inicializa(Sender: TObject);
begin
  PropInspector.Update(Sender);
end;

procedure TFormObjInsp_Rel.AddProperty(PropName: String; PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant;
  PropEditor: TNotifyEvent);
begin
  FItems.AddObject('   ' + PropName, TProp.Create(PropValue, PropEnum,
    PropEnumValues, PropEditor));
end;

procedure TFormObjInsp_Rel.InsertProperty(Index: Integer; PropName: String; PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant;
  PropEditor: TNotifyEvent);
begin
  FItems.InsertObject(Index, '   ' + PropName, TProp.Create(PropValue, PropEnum,
    PropEnumValues, PropEditor));
end;

function TFormObjInsp_Rel.CurItem: TProp;
begin
  Result := nil;
  if (FItemIndex <> -1) and (Count > 0) then
    Result := TProp(FItems.Objects[FItemIndex]);
end;

procedure TFormObjInsp_Rel.SetItems(Value: TStringList);
begin
  FItems.Assign(Value);
  FItemIndex := -1;
  PaintBox1.Repaint;
  ItemIndex := 0;
end;

procedure TFormObjInsp_Rel.SetItemValue(Value: String);
var
  p: TProp;
  Tipo, Nome: String;
  PValue,i, y, Posicao: Integer;
  ob: TObject;
  PropInfo:PPropInfo;
  S: TIntegerSet;
  achou: boolean;
begin
  if Edit1.ReadOnly then
    exit;
  if FItemIndex < 0 then
    exit;
  Tipo := PropInspector.ListaValor[FItemIndex];
  Posicao := StrToIntDef(PropInspector.ListaPosicao[FItemIndex],0);
  Nome:=Trim(FItems[FItemIndex]);
  ob := TObject(PropInspector.ListaObject[FItemIndex]);
  if Tipo = 'String' then
    SetStrProp(ob,Nome,Edit1.Text)
  else if Tipo = 'Char' then
    SetOrdProp(ob,Nome,Ord(StrToIntDef(Edit1.Text,0)))
  else if Tipo = 'Integer' then
  begin
    if PropInspector.ListaTipos[FItemIndex] = 'Color' then
      SetOrdProp(ob,Nome,StringToColor(Edit1.Text))
    else if PropInspector.ListaTipos[FItemIndex] = 'Cursor' then
      SetOrdProp(ob,Nome,StringToCursor(Edit1.Text))
    else
      SetOrdProp(ob,Nome,StrToIntDef(Edit1.Text,0));
  end
  else if Tipo = 'Float' then
    SetFloatProp(ob,Nome,StrToFloat(Edit1.Text))
  else if Tipo = 'Boolean' then
  begin
    if Trim(UpperCase(Edit1.Text)) = 'TRUE' then
    begin
      PValue:=Ord(True);
      Edit1.Text := 'True';
    end
    else
    begin
      PValue:=Ord(False);
      Edit1.Text := 'False';
    end;
    SetOrdProp(ob,Nome,PValue);
  end
  else if Tipo = 'Set' then
  begin
    if (UpperCase(Trim(Nome)) = 'VISIBLE') and (UpperCase(Copy(FItems[FItemIndex],01,04)) = '   V') then
    begin
      y := FormDialogo_Rel.ListaInvisivel.IndexOf(UpperCase(PropInspector.VControl.Name));
      if UpperCase(Trim(Edit1.Text)) = 'TRUE' then
      begin
        if y > -1 then
          FormDialogo_Rel.ListaInvisivel.Delete(y);
      end
      else
      begin
        if y < 0 then
          FormDialogo_Rel.ListaInvisivel.Add(UpperCase(PropInspector.VControl.Name));
      end;
    end
    else if (UpperCase(Trim(Nome)) = 'ENABLED') and (UpperCase(Copy(FItems[FItemIndex],01,04)) = '   E') then
    begin
      y := FormDialogo_Rel.ListaDesabilitado.IndexOf(UpperCase(PropInspector.VControl.Name));
      if UpperCase(Trim(Edit1.Text)) = 'TRUE' then
      begin
        if y > -1 then
          FormDialogo_Rel.ListaDesabilitado.Delete(y);
      end
      else
      begin
        if y < 0 then
          FormDialogo_Rel.ListaDesabilitado.Add(UpperCase(PropInspector.VControl.Name));
      end;
    end
    else
    begin
      PropInfo:= GetPropInfo(ob.ClassInfo, Nome);
      SetOrdProp(ob,Nome,GetEnumValue(PropInfo^.PropType^,Edit1.Text));
    end;
  end
  else if Tipo = 'SetElement' then
  begin
    if Copy(FItems[FItemIndex],01,02) = '  ' then
    begin
      achou := false;
      i := 0;
      while not achou do
      begin
        inc(i);
        Nome := Trim(FItems[FItemIndex-I]);
        if Copy(Nome,01,01) = '-' then
        begin
          Nome := Copy(Nome,02,200);
          achou := True;
        end;
      end;
    end;
    ob := TObject(PropInspector.VControl);
    PropInfo:= GetPropInfo(ob.ClassInfo, Nome);
    Integer(S) := GetOrdProp(ob, PropInfo);
    if Trim(UpperCase(Edit1.Text)) = 'TRUE' then
     Include(S, Posicao)
    else
      Exclude(S, Posicao);
    SetOrdProp(ob,Nome,Integer(S));
  end;
  p := TProp(FItems.Objects[FItemIndex]);
  p.Text := Edit1.Text;
  PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
  FormDialogo_Rel.DsnRegister.DsnStage.UpdateControl;
end;

function TFormObjInsp_Rel.GetItemValue(i: Integer): String;
var
  p: TProp;
begin
  Result := '';
  p := TProp(FItems.Objects[i]);
  if p = nil then Exit;
  Result := p.Text;
end;

procedure TFormObjInsp_Rel.SetItemIndex(Value: Integer);
var
  ww, y: Integer;
  b1, b2: Boolean;
begin
  if BusyFlag1 then Exit;
  if Value > Count - 1 then
    Value := Count - 1;
  Edit1.Visible := (Count > 0) and not HideProperties;
  if Count = 0 then Exit;
  if FItemIndex <> -1 then
    if Edit1.Modified then
      SetItemValue(Edit1.Text);
  FItemIndex := Value;
  ComboPanel.Visible := False;
  EditPanel.Visible := False;
  if (FItemIndex > -1) and (FItemIndex <= PropInspector.ListaTipos.Count-1) then
  begin
    Edit1.ReadOnly := False;
    if (PropInspector.ListaTipos[FItemIndex] = 'Edit') then
    else if (PropInspector.ListaTipos[FItemIndex] = 'Edit_R') then
      Edit1.ReadOnly := True
    else if (PropInspector.ListaTipos[FItemIndex] = 'Color') or
            (PropInspector.ListaTipos[FItemIndex] = 'Cursor') or
            (PropInspector.ListaTipos[FItemIndex] = 'Boolean') or
            (PropInspector.ListaTipos[FItemIndex] = 'Combo') then
      ComboPanel.Visible := True
    else
      EditPanel.Visible := True;
    if (PropInspector.ListaTipos[FItemIndex] = 'Font') or
       (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') or
       (PropInspector.ListaTipos[FItemIndex] = 'Picture') or
       (PropInspector.ListaTipos[FItemIndex] = 'StringList') then
      Edit1.ReadOnly := True;
  end
  else
    Edit1.ReadOnly := True;
  if (ComboPanel.Visible) then
    Edit1.ReadOnly := True;
  if (FItemIndex > PropInspector.ListaTipos.Count-1) then
    EditPanel.Visible := True;
  LB1.Visible := False;
  ww := w - w1 - 2;
  y := FItemIndex * FRowHeight + 1;
  if EditPanel.Visible then
  begin
    EditPanel.SetBounds(w - 14, y, 14, FRowHeight - 2);
    EditBtn.SetBounds(0, 0, EditPanel.Width, EditPanel.Height);
    Dec(ww, 15);
  end;
  if FItemIndex > -1 then
    Edit1.Text := GetItemValue(FItemIndex);
  if ComboPanel.Visible then
  begin
    ComboPanel.SetBounds(w - 14, y, 14, FRowHeight - 2);
    ComboBtn.SetBounds(0, 0, ComboPanel.Width, ComboPanel.Height);
    Dec(ww, 15);
  end;
  Edit1.SetBounds(w1 + 2, y, ww, FRowHeight - 2);
  Edit1.SelectAll;
  Edit1.Modified := False;

  if y + FRowHeight > Box.VertScrollBar.Position + Box.ClientHeight then
    Box.VertScrollBar.Position := y - Box.ClientHeight + FRowHeight;
  if y < Box.VertScrollBar.Position then
    Box.VertScrollBar.Position := y - 1;

  if FItemIndex > -1 then
    LastProp := FItems[FItemIndex];
  PaintBox1Paint(nil);
end;

function TFormObjInsp_Rel.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TFormObjInsp_Rel.ItemsChanged;
var
  LastIndex: Integer;
begin
  FItemIndex := -1;
  BusyFlag := True;
  PanelObj.Height := Items.Count * FRowHeight;
  PanelObj.Width := Box.ClientWidth;
  w := PaintBox1.Width;
  BusyFlag := False;

  LastIndex := FItems.IndexOf(LastProp);
  if LastIndex = -1 then
    LastIndex := 0;
  ItemIndex := LastIndex;
  if not HideProperties then
  begin
    if not ((CB1.ItemIndex <> -1) and (CB1.Items[CB1.ItemIndex] = ObjectName)) then
      CB1.ItemIndex := CB1.Items.IndexOf(ObjectName);
  end
  else
    CB1.ItemIndex := -1;
end;

procedure TFormObjInsp_Rel.DrawOneLine(i: Integer; a: Boolean);
var
  R, R1: TRect;

  procedure Line(x, y, dx, dy: Integer);
  begin
    b.Canvas.MoveTo(x, y);
    b.Canvas.LineTo(x + dx, y + dy);
  end;

  function GetPropName(Index: Integer): String;
  var
    i: Integer;
  begin
    Result := FItems[Index];
    if (Trim(Result)[1] = '+') or (Trim(Result)[1] = '-') then
      Result := '   ' +Copy(Trim(Result),02,200);
  end;

begin
  if Count > 0 then
  with b.Canvas do
  begin
    Brush.Color := clwindow;
    Pen.Color := clBtnFace; //clBtnShadow;
    Font.Name := 'MS Sans Serif';
    Font.Size := 8;
    Font.Style := [];
    Font.Color := clBlack;
    R := Rect(5, i * FRowHeight + 1, w1 - 2, i * FRowHeight + FRowHeight - 1);
    R1 := Rect(0, i * FRowHeight, w1 - 1, i * FRowHeight + FRowHeight - 1);
    if a then
    begin
      Pen.Color := clBtnFace; //clBtnShadow;
      //Line(0, -2 + i * FRowHeight, w, 0);
      Line(w1 - 1, 0 + i * FRowHeight, 0, FRowHeight);
      Line(1, FRowHeight + -1 + i * FRowHeight, w - 1, 0);

      //Pen.Color := clBlack;
      //Line(0, -1 + i * FRowHeight, w, 0);
      //Line(0, -1 + i * FRowHeight, 0, FRowHeight + 1);
      //Pen.Color := clBtnHighlight;
      //Line(1, FRowHeight + -1 + i * FRowHeight, w - 1, 0);
      //Line(Edit1.Left, 0 + i * FRowHeight, Edit1.Width, 0);
      //Line(w1, 0 + i * FRowHeight, 0, FRowHeight);
      //Line(w1 + 1, 0 + i * FRowHeight, 0, FRowHeight);
      if i >= PropInspector.FEventos then
        Font.Color := clMaroon
      else
        Font.Color := clBlack;
      Brush.Color := clBtnFace;
      TextRect(R1, 0, 1 + i * FRowHeight, '');
      TextRect(R, 5, 1 + i * FRowHeight, GetPropName(i));
    end
    else
    begin
      Line(0, FRowHeight + -1 + i * FRowHeight, w, 0);
      Line(w1 - 1, 0 + i * FRowHeight, 0, FRowHeight);
      Pen.Color := clBtnHighlight;
      Line(w1, 0 + i * FRowHeight, 0, FRowHeight);
      if i >= PropInspector.FEventos then
        Font.Color := clMaroon
      else
        Font.Color := clBlack;
      TextRect(R, 5, 1 + i * FRowHeight, GetPropName(i));
      if i >= PropInspector.FEventos then
        Font.Style := [fsBold]
      else
        Font.Style := [];
      Font.Color := clNavy;
      TextOut(w1 + 2, 1 + i * FRowHeight, GetItemValue(i));
    end;
    if (Trim(FItems[i])[1] = '+') or (Trim(FItems[i])[1] = '-') then
    begin
      EditRect.Left   := R.Left-3;
      EditRect.Top    := R.Top+2;
      EditRect.Right  := R.Left+06;
      EditRect.Bottom := R.Top+11;
      Brush.Color := clWindow;
      Brush.Style := bsSolid;
      Pen.Style := psSolid;
      pen.Color := clBlack;
      Rectangle(R.Left-3, R.Top+2, R.Left+06, R.Top+11);
      Brush.Color := clwindow;
      Rectangle(R.Left-1, R.Top+6, R.Left+4, R.Top+7);
      if (Trim(FItems[i])[1] = '+') then
        Rectangle(R.Left+1, R.Top+4, R.Left+2, R.Top+9);
    end;
  end;
end;

procedure TFormObjInsp_Rel.PaintBox1Paint(Sender: TObject);
var
  i: Integer;
  r: TRect;
begin
  if BusyFlag then Exit;
  try
    LB1.Hide;
    r := PaintBox1.BoundsRect;
    b.Width := PaintBox1.Width;
    b.Height := PaintBox1.Height;
    b.Canvas.Brush.Color := clwindow;
    b.Canvas.FillRect(r);
    if not HideProperties then
    begin
      for i := 0 to Count - 1 do
        if i <> FItemIndex then
          DrawOneLine(i, False);
      if FItemIndex <> -1 then DrawOneLine(FItemIndex, True);
    end;
    PaintBox1.Canvas.Draw(0, 0, b);
  finally
    FormDialogo_Rel.Thread_ok := True;
  end;
end;

procedure TFormObjInsp_Rel.FormCreate(Sender: TObject);
begin
  PropInspector := TPropertyInspector.Create(Self);
  PanelObj := TInspPanel.Create(Self);
  PanelObj.Parent := Box;
  PanelObj.BevelInner := bvNone;
  PanelObj.BevelOuter := bvNone;
  PaintBox1.Parent := PanelObj;
  ComboPanel.Parent := PanelObj;
  EditPanel.Parent := PanelObj;
  Edit1.Parent := PanelObj;
  w := PaintBox1.Width;
  b := TBitmap.Create;
  FItemIndex := -1;
  FItems := TStringList.Create;
  FRowHeight := Canvas.TextHeight('Wg') + 3;//-Font.Height + 5;
  Box.VertScrollBar.Increment := FRowHeight;
  Box.VertScrollBar.Tracking := True;
  LB1 := TPopupListBox.Create(nil);
  LB1.ListBox.OnClick := LB1Click;
  DefHeight := Height;
  FormResize(nil);
end;

procedure TFormObjInsp_Rel.FormDestroy(Sender: TObject);
begin
  b.Free;
  LB1.Free;
  ClearProperties(False);
  FItems.Free;
end;

procedure TFormObjInsp_Rel.FormActivate(Sender: TObject);
begin
  if FormDialogo_Rel.ExcluiComp then
    FormDialogo_Rel.AtualizaLista_CB;
  if Edit1.Enabled and Edit1.Visible then
    Edit1.SetFocus;
end;

procedure TFormObjInsp_Rel.FormDeactivate(Sender: TObject);
begin
  if BusyFlag then Exit;
  LB1.Hide;
  if CurItem = nil then Exit;
end;

procedure TFormObjInsp_Rel.FormShow(Sender: TObject);
begin
  Posicao_Unit := 0;
  if ClientHeight < 20 then
    CB1.Hide;
end;

procedure TFormObjInsp_Rel.WMNCLButtonDblClk(var Message: TMessage);
begin
  if Height > 30 then
  begin
    ClientHeight := 0;
    CB1.Hide;
  end
  else
  begin
    Height := DefHeight;
    CB1.Show;
    ItemsChanged;
    Edit1.SelText := Edit1.Text;
    Edit1.Modified := False;
  end;
  if Assigned(FOnHeightChanged) then
    FOnHeightChanged(Self);
end;

procedure TFormObjInsp_Rel.FormResize(Sender: TObject);
begin
  Box.Width := ClientWidth;
  Box.Height := ClientHeight - CB1.Height - 7 - ControlBar2.Height;
  CB1.Width := ClientWidth;

  PanelObj.Height := Items.Count * FRowHeight;
  PanelObj.Width := Box.ClientWidth;

  w := PaintBox1.Width;
  SetItemIndex(FItemIndex);
end;

procedure TFormObjInsp_Rel.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if HideProperties then Exit;
  if PaintBox1.Cursor = crHSplit then
    FDown := True
  else
  begin
    ItemIndex := y div FRowHeight;
    Edit1.SetFocus;
    FTickCount := GetTickCount;
    if (X >= EditRect.left) and (X <= EditRect.Right) and
       (y >= EditRect.Top) and (Y <= EditRect.Bottom) then
      PaintBox1DblClick(Self);
  end;
end;

procedure TFormObjInsp_Rel.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if HideProperties then Exit;
  if Key = vk_Escape then
  begin
    Edit1.Perform(EM_UNDO, 0, 0);
    Edit1.Modified := False;
  end;
  if Key = vk_Up then
  begin
    if ItemIndex > 0 then
      ItemIndex := ItemIndex - 1;
    Key := 0;
  end
  else if Key = vk_Down then
  begin
    if ItemIndex < Count - 1 then
      ItemIndex := ItemIndex + 1;
    Key := 0;
  end;
end;

procedure TFormObjInsp_Rel.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Edit1.Modified then SetItemValue(Edit1.Text);
    Edit1.Modified := False;
    Edit1.SelectAll;
    Key := #0;
  end;
end;

procedure TFormObjInsp_Rel.EditBtnClick(Sender: TObject);
var
  Prop: TProp;
  ob: TObject;
  PropName, StrEvento, StrParametros: String;
  PropInfo: PPropInfo;
  Data:PTypeData;
  I, Count, P, IntVal:Integer;
  TypeInfo:PTypeInfo;
  PropList:PPropList;
  Pesquisa: String;
  Fim, Inicio: Boolean;
  Qtd_Begin, Qtd_End: Integer;
  Qtd_I_Coment, Qtd_F_Coment, InicioBloco, InicioEvento, Qtd_Linhas_Original: Integer;
begin
  if HideProperties then Exit;
  if (FItemIndex > PropInspector.ListaTipos.Count-1) then
  begin
    PropName := Trim(FItems[FItemIndex]);
    PropInfo:= GetPropInfo(TObject(PropInspector.VControl).ClassInfo, PropName);
    StrParametros := WriteMethodData(GetTypeData(PropInfo^.PropType^))+')';
    StrEvento := TControl(PropInspector.VControl).Name + Copy(PropName,03,40) + '(' + StrParametros;
    InicioBloco := 0;
    FormMiniEditor := TFormMiniEditor.Create(Application);
    Try
      Pesquisa := 'procedure TForm' + FormDialogo_Rel.NomeForm + '.' + StrEvento + ';';
      FormMiniEditor.E_Cabecalho.Lines.Text := Pesquisa;
      FormMiniEditor.Validar_Bloco := True;
      Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
      FormMiniEditor.E_Metodo.Lines.Clear;
      FormRelatorio.TextoPAS.CaretX := 1;
      FormRelatorio.TextoPAS.CaretY := 1;
      InicioEvento := 0;
      FormRelatorio.TextoPAS.SearchReplace(Pesquisa, '', FormDialogo_Rel.SearchOptionsPd );
      if FormRelatorio.TextoPAS.CaretY > 1 then
      begin
        Qtd_Begin := 0;
        Qtd_End := 0;
        Qtd_I_Coment := 0;
        Qtd_F_Coment := 0;
        with FormRelatorio.TextoPAS do
        begin
          InicioEvento := CaretY;
          Fim := False;
          Inicio := False;
          while (not Fim) and (CaretY < Lines.Count-1) do
          begin
            if not Inicio then
              if Pos(');',RetiraBrancos(LineText)) > 0 then
              begin
                Inicio := True;
                InicioBloco := CaretY;
                CaretY := CaretY + 01;
              end;
            if Inicio then
            begin
              FormMiniEditor.E_Metodo.Lines.Add(LineText);
              //Pesquisa := Trim(UpperCase(LineText));
              //Qtd_I_Coment := Qtd_I_Coment + ContaOcorrencia('{',Pesquisa);
              //Qtd_F_Coment := Qtd_F_Coment + ContaOcorrencia('}',Pesquisa);
              //if (Qtd_I_Coment = Qtd_F_Coment) then
              //begin
              //  if (((Copy(Pesquisa,01,05) = 'BEGIN') or (Copy(Pesquisa,01,03) = 'TRY') or (Copy(Pesquisa,01,04) = 'CASE'))) and
              //     ((Pesquisa[6] = ' ') or (Pesquisa[6] = '/') or (Pesquisa[6] = '') or (Pesquisa[6] = '{')) then
              //    inc(Qtd_Begin);
              //  if (Copy(Pesquisa,01,03) = 'END') and
              //    ((Pesquisa[4] = ' ') or (Pesquisa[4] = '/') or (Pesquisa[4] = '') or (Pesquisa[4] = ';') or (Pesquisa[4] = '}')) then
              //    inc(Qtd_End);
              //end;
              //FormMiniEditor.E_Metodo.Lines.Add(LineText);
              //if (Qtd_Begin = Qtd_End) and (Qtd_Begin > 0) then
              //begin
              //  Fim := True;
              //  FormMiniEditor.Posicao_Y := FormMiniEditor.E_Metodo.Lines.Count-1;
              //end
            end;
            CaretY := CaretY + 01;
            Pesquisa := Trim(UpperCase(LineText));
            if (Copy(Pesquisa,01,04) = 'END.') or
               (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORM' + UpperCase(FormDialogo_Rel.NomeForm) + '.' ) or
               (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORM' + UpperCase(FormDialogo_Rel.NomeForm) + '.' ) then
              Fim := True;
          end;
        end;
        FormMiniEditor.Posicao_X := 3;
        Qtd_Linhas_Original := FormMiniEditor.E_Metodo.Lines.Count-1;
        FormMiniEditor.ExcluirEvento.Visible := True;
      end
      else
      begin
        FormMiniEditor.ExcluirEvento.Visible := False;
        FormMiniEditor.E_Metodo.Lines.Add('{utilize o "var" para declarar variáveis}');
        FormMiniEditor.E_Metodo.Lines.Add('begin');
        FormMiniEditor.E_Metodo.Lines.Add('  {codificação...}');
        FormMiniEditor.E_Metodo.Lines.Add('');
        FormMiniEditor.E_Metodo.Lines.Add('end;');
        FormMiniEditor.Posicao_Y := 4;
        FormMiniEditor.Posicao_X := 3;
      end;
      if FormMiniEditor.ShowModal = mrOk then
      begin
        if FormMiniEditor.ExcluirEvento.Checked then
        begin
          Pesquisa := 'procedure ' + StrEvento + ';';
          Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
          FormRelatorio.TextoPAS.CaretX := 1;
          FormRelatorio.TextoPAS.CaretY := 1;
          FormRelatorio.TextoPAS.SearchReplace(Pesquisa, '', FormDialogo_Rel.SearchOptionsPd );
          if FormRelatorio.TextoPAS.CaretY > 1 then
          begin
            P := FormRelatorio.TextoPAS.CaretY - 1;
            Fim := false;
            IntVal := 0;
            while not Fim do
            begin
              if Pos(');',RetiraBrancos(FormRelatorio.TextoPAS.Lines[P])) > 0 then Fim := True;
              FormRelatorio.TextoPAS.Lines.Delete(P);
              Inc(IntVal);
            end;
          end;
          FormRelatorio.TextoPAS.CaretY := InicioEvento;
          P := FormRelatorio.TextoPAS.CaretY - IntVal ;
          for I:=0 to Qtd_Linhas_Original+InicioBloco-InicioEvento+1 do
            FormRelatorio.TextoPAS.Lines.Delete(P - 1);
          P := FormDialogo_Rel.ListaEventos.IndexOf(TControl(PropInspector.VControl).Name + ':' + Copy(StrEvento,01,Pos('(',StrEvento)-1));
          if P > -1 then
          begin
            FormDialogo_Rel.ListaEventos.Delete(P);
            Edit1.Text := '';
            Prop := TProp(FItems.Objects[FItemIndex]);
            Prop.Text := Edit1.Text;
            PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
          end;
        end
        else
        begin
          FormDialogo_Rel.ListaEventos.Add(TControl(PropInspector.VControl).Name + ':' + Copy(StrEvento,01,Pos('(',StrEvento)-1));
          Edit1.Text := TControl(PropInspector.VControl).Name + Copy(PropName,03,40);
          Prop := TProp(FItems.Objects[FItemIndex]);
          Prop.Text := Edit1.Text;
          PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
          if InicioBloco > 0 then
          begin
            FormRelatorio.TextoPAS.CaretY := InicioBloco;
            for I:=0 to Qtd_Linhas_Original do
              FormRelatorio.TextoPAS.Lines.Delete(FormRelatorio.TextoPAS.CaretY);
            for I:=0 to FormMiniEditor.E_Metodo.Lines.Count-1 do
            begin
              FormRelatorio.TextoPAS.Lines.Insert(InicioBloco,FormMiniEditor.E_Metodo.Lines[I]);
              Inc(InicioBloco);
            end;
          end
          else
          begin
            Pesquisa := 'procedure TForm' + FormDialogo_Rel.NomeForm + '.' + StrEvento + ';';
            Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
            FormDialogo_Rel.AbrirEditor(Projeto.Pasta + FormDialogo_Rel.NomeForm + '.PAS',Pesquisa,False,'',StrParametros+';',FormMiniEditor.E_Metodo.Lines);
          end;
        end;
        FormRelatorio.TextoPAS.Modified := True;
      end;
    Finally
      FormMiniEditor.Free;
    end;
    exit;
  end;
  if PropInspector.ListaTipos[FItemIndex] = 'Font' then
  begin
    ob := TObject(PropInspector.ListaObject[FItemIndex]);
    PropName:=Trim(FItems[FItemIndex]);
    PropName:=Copy(PropName,02,20);
    PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
    FontDialog.Font := TFont(GetOrdProp(ob, PropInfo));
    if FontDialog.Execute then
    begin
      TypeInfo:= PropInfo^.PropType^;
      Count:=GetPropList(TypeInfo,tkProperties,nil);
      GetMem(PropList, Count*SizeOf(PPropInfo));
      GetPropInfos(TypeInfo, PropList);
      Data:=GetTypeData(PropInfo^.PropType^);
      for I:=0 to Data^.PropCount - 1 do
        SetOrdProp(ob, PropInfo, Longint(FontDialog.Font));
      FreeMem(PropList, Count*SizeOf(PPropInfo));
      if FItems[FItemIndex][1] = '-' then
        PaintBox1DblClick(Self);
      SetFocus;
    end;
  end
  else if (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') or
          (PropInspector.ListaTipos[FItemIndex] = 'Picture') then
  begin
    with TPictureEditorDlg.Create(nil) do
    begin
      try
        ob := TObject(PropInspector.ListaObject[FItemIndex]);
        PropName:=Trim(FItems[FItemIndex]);
        PropName:=Copy(PropName,01,200);
        PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
        Pic.Assign(TPicture(GetOrdProp(ob, PropInfo)));
        ImagePaintBox.Invalidate;
        Save.Enabled := (Pic.Graphic <> nil) and not Pic.Graphic.Empty;
        Clear.Enabled := (Pic.Graphic <> nil) and not Pic.Graphic.Empty;
        if (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') then
          OpenDialog.Filter := 'Bitmap (*.bmp)|*.bmp'
        else
          OpenDialog.Filter := 'All (*.bmp;*.jpg;*.ico;*.emf;*.wmf)|*.bmp;*.jpg;*.ico;*.emf;*.wmf|Bitmaps (*.bmp)|*.bmp|Jpeg (*.jpg)|*.jpg|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
        OpenDialog.InitialDir := Projeto.PastaGerador + 'Imagem';
        SaveDialog.InitialDir := Projeto.PastaGerador + 'Imagem';
        if ShowModal=mrOK then
        begin
          if (PropInspector.ListaTipos[FItemIndex] = 'Bitmap') then
            SetOrdProp(ob, PropInfo, LongInt(Pic.Bitmap))
          else
            SetOrdProp(ob, PropInfo, LongInt(Pic.Graphic));
        end;
      finally
        Free;
      end;
    end;
  end
  else if PropInspector.ListaTipos[FItemIndex] = 'StringList' then
  begin
    with TStrEditDlg.Create(nil) do
    begin
      try
        ob := TObject(PropInspector.ListaObject[FItemIndex]);
        PropName:=Trim(FItems[FItemIndex]);
        PropName:=Copy(PropName,01,200);
        PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
        Memo.Lines := TStrings(GetOrdProp(ob, PropInfo));
        if ShowModal=mrOK then
          SetOrdProp(ob, PropInfo, LongInt(Memo.Lines));
      finally
        Free;
      end;
    end;
  end;
  Edit1.SelectAll;
end;

procedure TFormObjInsp_Rel.Edit1DblClick(Sender: TObject);
var
  p: TProp;

  function IndexOf(arr: Variant; val: Variant): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to varArrayHighBound(arr, 1) do
      if arr[i] = val then
      begin
        Result := i;
        break;
      end;
  end;

begin
  p := CurItem;
  if (FItemIndex > PropInspector.ListaTipos.Count-1) then
  begin
    EditBtnClick(Self);
    exit;
  end;
  if PropInspector.ListaTipos[FItemIndex] = 'Color' then
  begin
    ColorDialog.Color := StringToColor(Trim(Edit1.Text));
    if ColorDialog.Execute then
    begin
      Edit1.Text := ColorToString(ColorDialog.Color);
      Edit1.ReadOnly := False;
      Edit1.SelectAll;
      SetItemValue(Edit1.Text);
      Edit1.ReadOnly := True;
    end;
  end
  else if PropInspector.ListaTipos[FItemIndex] = 'Boolean' then
  begin
    if UpperCase(Trim(Edit1.Text)) = 'TRUE' then
      Edit1.Text := 'False'
    else
      Edit1.Text := 'True';
    Edit1.ReadOnly := False;
    Edit1.SelectAll;
    SetItemValue(Edit1.Text);
    Edit1.ReadOnly := True;
  end
  else if PropInspector.ListaTipos[FItemIndex] = 'Font' then
    EditBtnClick(Self);
end;

procedure TFormObjInsp_Rel.CB1Click(Sender: TObject);
var
  Componente: TComponent;
  Control : TControl;
  NomeComp: String;
  NrPg,I: Integer;
begin
  if CB1.ItemIndex = 0 then
    Atribui(Nil,True)
  else
  begin
    NomeComp := Copy(CB1.Text,01,Pos(':',CB1.Text)-1);
    I := 0;
    while I <= FormDialogo_Rel.ComponentCount-1 do
    begin
      if FormDialogo_Rel.Components[I].Name = NomeComp then
      begin
        Componente := FormDialogo_Rel.Components[I];
        I := 9999;
      end;
      Inc(I);
    end;
    if Componente <> nil then
    begin
      Control := TControl(Componente);
      FormDialogo_Rel.ObjetoAtual := Control;
      if not FormDialogo_Rel.VamosGravar then
        FormDialogo_Rel.DsnSelect.Select(Control)
      else
        Atribui(Control, True);
    end;
    if Edit1.Visible then Edit1.SetFocus;
  end;
end;

function TFormObjInsp_Rel.GetClassName(ObjName: String): String;
begin
  if CurObject <> nil then
    Result := CurObject.ClassName else
    Result := '';
end;

procedure TFormObjInsp_Rel.ComboBtnClick(Sender: TObject);
var
  i, x, wItems, nItems: Integer;
  p: TPoint;
  PropName: String;
  PropInfo: PPropInfo;
  ob: TObject;
  PTD : PTypeData;
begin
  BusyFlag := True;
  if LB1.Visible then
  begin
    LB1.Hide;
    Edit1.SetFocus;
  end
  else with LB1.ListBox do
  begin
    LB1.Cores := False;
    Style := lbStandard;
    Items.Clear;
    Sorted := False;
    if PropInspector.ListaTipos[FItemIndex] = 'Boolean' then
    begin
      Items.Add('False');
      Items.Add('True');
    end
    else if PropInspector.ListaTipos[FItemIndex] = 'Color' then
    begin
      Style := lbOwnerDrawVariable;
      LB1.Cores := True;
      for i := 0 to 41 do
        Items.Add(frColorNames[i])
    end
    else if PropInspector.ListaTipos[FItemIndex] = 'Cursor' then
    begin
      Items.Add('crAppStart');
      Items.Add('crArrow');
      Items.Add('crCross');
      Items.Add('crDefault');
      Items.Add('crDrag');
      Items.Add('crHandPoint');
      Items.Add('crHelp');
      Items.Add('crHourGlass');
      Items.Add('crHSplit');
      Items.Add('crIBeam');
      Items.Add('crMultiDrag');
      Items.Add('crNo');
      Items.Add('crNoDrop');
      Items.Add('crSizeAll');
      Items.Add('crSizeNESW');
      Items.Add('crSizeNS');
      Items.Add('crSizeNWSE');
      Items.Add('crSizeWE');
      Items.Add('crSQLWait');
      Items.Add('crUpArrow');
      Items.Add('crVSplit');
    end
    else
    begin
      ob := TObject(PropInspector.ListaObject[FItemIndex]);
      PropName := Trim(FItems[FItemIndex]);
      PropInfo:= GetPropInfo(ob.ClassInfo, PropName);
      PTD := GetTypeData(PropInfo^.PropType^);
      for x := PTD^.MinValue to PTD^.maxValue do
        Items.Add(GetEnumname(PropInfo^.PropType^, X));
    end;

    if Items.Count > 0 then
    begin
      ItemIndex := Items.IndexOf(CurItem.Text);
      wItems := 0;
      for i := 0 to Items.Count - 1 do
      begin
        if Canvas.TextWidth(Items[i]) > wItems then
          wItems := Canvas.TextWidth(Items[i]);
      end;

      Inc(wItems, 8);
      nItems := Items.Count;
      if nItems > 8 then
      begin
        nItems := 8;
        Inc(wItems, 16);
      end;

      p := Edit1.ClientToScreen(Point(0, Edit1.Height));

      if wItems < w1 then
        LB1.SetBounds(w1 + 1, p.Y,
                  w - w1 + 1, nItems * (ItemHeight + 1) + 2)
      else
        LB1.SetBounds(w - wItems + 2, p.Y,
                  wItems, nItems * (ItemHeight + 1) + 2);

      Width := LB1.ClientWidth;
      Height := LB1.ClientHeight;
      LB1.Height := Height;
      p := Self.ClientToScreen(Point(0, 0));
      Inc(p.X, LB1.Left);
      if p.X < 0 then p.X := 0;
      LB1.Left := p.X;
      LB1.Show;
    end;
  end;
  BusyFlag := False;
end;

procedure TFormObjInsp_Rel.LB1Click(Sender: TObject);
begin
  Edit1.Text := LB1.ListBox.Items[LB1.ListBox.ItemIndex];
  LB1.Hide;
  Edit1.SetFocus;
  Edit1.ReadOnly := False;
  SetItemValue(Edit1.Text);
  Edit1.ReadOnly := True;
end;

{$WARNINGS OFF}
procedure TFormObjInsp_Rel.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if GetTickCount - FTickCount < GetDoubleClickTime then
    Edit1DblClick(nil);
end;
{$WARNINGS ON}

procedure TFormObjInsp_Rel.Grow;
begin
  Show;
  if ClientHeight < 20 then
  begin
    Height := DefHeight;
    CB1.Show;
    ItemsChanged;
    Edit1.SelText := Edit1.Text;
    Edit1.Modified := False;
    if Assigned(FOnHeightChanged) then
      FOnHeightChanged(Self);
  end;
end;

procedure TFormObjInsp_Rel.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FDown then
    if (X > w1 - 2) and (X < w1 + 2) then
      PaintBox1.Cursor := crHSplit else
      PaintBox1.Cursor := crDefault
  else
  begin
    if x > 5 then
      w1 := X;
    FormResize(nil);
  end;
end;

procedure TFormObjInsp_Rel.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := False;
end;

procedure TFormObjInsp_Rel.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Resposta: Integer;
begin
  FormObjInsp_Rel := Nil;
  PropInspector.Free;
  if FormDialogo_Rel <> Nil then
    FormDialogo_Rel.Close;
  Destroy;
end;

procedure TFormObjInsp_Rel.PaintBox1DblClick(Sender: TObject);
var
  PropName:string;
  PropInfo:PPropInfo;
  I:Integer;
begin
  if (Trim(FItems[FItemIndex])[1] = '+') then
  begin
    PropInspector.ListaProp[FItemIndex] := '-'+Copy(PropInspector.ListaProp[FItemIndex],02,200);
    PropName:=Copy(Trim(FItems[FItemIndex]),02,200);
    PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
    Inc(PropInspector.FEventos,InsertPropInfo(PropInfo,PropInspector.VControl,FItemIndex));
    Atribui(PropInspector.VControl,False);
  end
  else if (Trim(FItems[FItemIndex])[1] = '-') then
  begin
    PropInspector.ListaProp[FItemIndex] := '+'+Copy(PropInspector.ListaProp[FItemIndex],02,200);
    PropName:=Copy(Trim(FItems[FItemIndex]),02,200);
    PropInfo:= GetPropInfo(PropInspector.VControl.ClassInfo, PropName);
    Dec(PropInspector.FEventos,DeletePropInfo(PropInfo,PropInspector.VControl,FItemIndex));
    Atribui(PropInspector.VControl,False);
  end;
end;

procedure TFormObjInsp_Rel.Atribui(Sender: TObject; Tudo: Boolean);
var
  I,Y: Integer;
begin
  if FormDialogo_Rel.ExcluiComp then
    FormDialogo_Rel.AtualizaLista_CB;
  PropInspector.VControl := TControl(Sender);
  ClearProperties(Tudo);
  Y := FItemIndex;
  FItemIndex := 0;
  if Sender <> Nil then
  begin
    if Tudo then
      PropInspector.Update(Sender);
    for I:=0 to PropInspector.ListaProp.Count-1 do
      AddProperty(Copy(PropInspector.ListaProp[I],1,Pos(':',PropInspector.ListaProp[I])-1),Copy(PropInspector.ListaProp[I],Pos(':',PropInspector.ListaProp[I])+2,200), nil, Null, nil);
    if Y > FItems.Count-1 then
      FItemIndex := FItems.Count-1
    else
      FItemIndex := Y;
    if FItemIndex > -1 then
      Edit1.Text := GetItemValue(FItemIndex);
    CB1.ItemIndex := CB1.Items.IndexOf(TControl(Sender).Name + ': ' + TControl(Sender).ClassName);
  end
  else
    CB1.ItemIndex := -1;
  FormResize(Self);
end;

procedure TFormObjInsp_Rel.Edit1Change(Sender: TObject);
var
  Tipo: String;
  ob: TObject;
  Nome: String;
begin
  if (Edit1.ReadOnly) or (not Edit1.Modified) or (FItemIndex < 0) or (ComboPanel.Visible) then
    exit;
  Tipo := PropInspector.ListaValor[FItemIndex];
  ob := TObject(PropInspector.ListaObject[FItemIndex]);
  Nome := Trim(FItems[FItemIndex]);
  if Tipo = 'String' then
    SetItemValue(Edit1.Text);
end;

procedure TFormObjInsp_Rel.BtnFonteClick(Sender: TObject);
begin
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.Divisao.Visible := False;
    FormMiniEditor.ExcluirEvento.Visible := False;
    FormMiniEditor.E_Cabecalho.Visible := False;
    FormMiniEditor.E_Metodo.Lines.Clear;
    FormMiniEditor.E_Metodo.Lines := FormRelatorio.TextoPAS.Lines;
    FormMiniEditor.E_Metodo.Modified := False;
    FormMiniEditor.Posicao_Y := Posicao_Unit;
    if FormMiniEditor.ShowModal = mrOk then
    begin
      FormRelatorio.TextoPAS.Lines := FormMiniEditor.E_Metodo.Lines;
      FormRelatorio.TextoPAS.Modified := True;
    end;
  Finally
    Posicao_Unit := FormMiniEditor.E_Metodo.CaretY;
    FormMiniEditor.Free;
  end;
end;

procedure TFormObjInsp_Rel.CB1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then CB1Click(Self);
end;

procedure TFormObjInsp_Rel.BtnPaginasClick(Sender: TObject);
begin
  //FormDialogo_Rel.EditarPaginas;
end;

procedure TFormObjInsp_Rel.BtnOrdemTabClick(Sender: TObject);
begin
  FormDialogo_Rel.Define_TabOrder;
end;

function TFormObjInsp_Rel.GetPropAsString(Obj: TObject; Info: PPropInfo; SubItem: Boolean): string;
var
  Count,I: Integer;
  IntVal: LongInt;
  PropList: PPropList;
  Data: PTypeData;
  MethodValue: TMethod;
begin
  Result:='';
  Count:=GetPropList(Obj.ClassInfo,tkProps,nil);
  if Count < 1 then Exit;
  if Info^.PropType^.Kind=tkMethod then
  begin
    MethodValue:= GetMethodProp(Obj, Info);
    if (MethodValue.Code <> nil) then
      Result := Info^.Name
    else
      Result:= '';
  end
  else
  begin
    GetMem(PropList,Count * SizeOf(PPropInfo));
    try
      GetPropList(Obj.ClassInfo,tkProps,PropList);
      for I:=0 to Pred(Count) do with PropList^[I]^ do
      begin
        if (Info = nil) or (UpperCase(Name) = UpperCase(Info^.Name)) then
        begin
          case PropType^.Kind of
            tkUnknown     : Result:='';
            tkInteger     : begin
                              IntVal:=LongInt(GetOrdProp(Obj,PropList^[I]));
                              if (PropType^.Name = 'TColor') and
                                 ColorToIdent(IntVal,Result) then
                              else
                                if (PropType^.Name = 'TCursor') and
                                   CursorToIdent(IntVal,Result) then
                                else Result:=IntToStr(IntVal);
                            end;
            tkChar        : Result:=Chr(GetOrdProp(Obj,PropList^[I]));
            tkEnumeration : begin
                              IntVal:=LongInt(GetOrdProp(Obj,PropList^[I]));
                              if (PropType^.Name = 'Boolean') then
                                if IntVal = 1 then
                                  Result:='True'
                                else Result:='False'
                              else
                                Result:=EnumName(IntVal,PropList^[I]^.PropType^);
                            end;
            tkFloat       : Result:=FloatToStr(GetFloatProp(Obj,PropList^[I]));
            tkString,tkLString : Result:=GetStrProp(Obj,PropList^[I]);
            tkSet         : begin
                              IntVal:=LongInt(GetOrdProp(Obj,PropList^[I]));
                              if SubItem then
                                Result:=SetToString(IntVal,PropList^[I]^.PropType^)
                              else
                                Result:='+'+SetToString(IntVal,PropList^[I]^.PropType^);
                            end;
            tkClass       : begin
                              Data:=GetTypeData(Info^.PropType^);
                              if Data^.PropCount>0 then
                              begin
                                if IsA(Info^.PropType^, 'TCOMPONENT') then
                                  Result:='('+Data^.ClassType.ClassName+')'
                                else
                                  Result:='+('+Data^.ClassType.ClassName+')'
                              end
                              else if (Info^.PropType^.Name = 'TBitmap') then
                                Result:='(TBitmap)'
                              else if (Info^.PropType^.Name = 'TPicture') then
                                Result:='(TPicture)'
                              else if (Info^.PropType^.Name = 'TStrings') then
                                Result:='(TStrings)';
                            end;
            end;
        end;
      end;
    finally
      FreeMem(PropList,Count * SizeOf(PPropInfo));
    end;
  end;
end;

end.
