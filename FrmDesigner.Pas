unit FrmDesigner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, TypInfo, PopupLb, Menus, SynEdit, ComCtrls,
  ToolWin, DEntrada, FAvulso;

type
  TFormDesigner = class;

  TMyForm_DEntrada = class(TFormEntradaDados);

  TMyForm_Avulso = class(TFormAvulso);

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

  TFormDesigner = class(TForm)
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    PopDesigner: TPopupMenu;
    MnuPaginas: TMenuItem;
    RodapeMnt: TMenuItem;
    RodapeCns: TMenuItem;
    ControlBar2: TControlBar;
    ToolBar2: TToolBar;
    BtnCampo: TToolButton;
    BtnFormFilho: TToolButton;
    BtnFormatar: TToolButton;
    ToolBar1: TToolBar;
    BtnFonte: TToolButton;
    BtnOrdemTab: TToolButton;
    BtnPaginas: TToolButton;
    ToolButton3: TToolButton;
    BtnDesigner: TToolButton;
    PopFormStyle: TPopupMenu;
    dsg_Normal: TMenuItem;
    dsg_Maximizada: TMenuItem;
    dsg_Minimizada: TMenuItem;
    BtnStyle: TToolButton;
    BtnSalvar: TToolButton;
    PnFundo_L: TPanel;
    Splitter_D_J: TSplitter;
    PnFundo: TPanel;
    PageControl_Forms: TPageControl;
    PnInferior: TPanel;
    ListView_nao_visuais: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Splitter_L: TSplitter;
    PnFundo_L_I: TPanel;
    Pn_Barra_I_00: TPanel;
    Btn_I_F: TSpeedButton;
    Pn_Barra_I_01: TPanel;
    Pn_Barra_I_02: TPanel;
    PageControl_ObjInsp: TPageControl;
    TabSheet_Object: TTabSheet;
    Box: TScrollBox;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    EditPanel: TPanel;
    EditBtn: TSpeedButton;
    ComboPanel: TPanel;
    ComboBtn: TSpeedButton;
    CB1: TComboBox;
    PnFundo_L_S: TPanel;
    Pn_Barra_S_00: TPanel;
    Btn_S_F: TSpeedButton;
    Pn_Barra_S_01: TPanel;
    Pn_Barra_S_02: TPanel;
    PageControl_Objetos: TPageControl;
    TabSheet_Comp: TTabSheet;
    TreeView_Objetos: TTreeView;
    BtnForms: TToolButton;
    BtnUnits: TToolButton;
    BtnNewForm: TToolButton;
    PnSuperior: TPanel;
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
    procedure BtnFormatarClick(Sender: TObject);
    procedure BtnIncrementoClick(Sender: TObject);
    procedure BtnFormFilhoClick(Sender: TObject);
    procedure BtnCampoClick(Sender: TObject);
    procedure MnuPaginasClick(Sender: TObject);
    procedure RodapeMntClick(Sender: TObject);
    procedure RodapeCnsClick(Sender: TObject);
    procedure BtnFonteClick(Sender: TObject);
    procedure CB1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPaginasClick(Sender: TObject);
    procedure BtnOrdemTabClick(Sender: TObject);
    procedure BtnDesignerClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnStyleClick(Sender: TObject);
    procedure dsg_NormalClick(Sender: TObject);
    procedure dsg_MaximizadaClick(Sender: TObject);
    procedure dsg_MinimizadaClick(Sender: TObject);
    procedure Btn_S_FClick(Sender: TObject);
    procedure Btn_I_FClick(Sender: TObject);
    procedure Splitter_LMoved(Sender: TObject);
    procedure PnFundo_LResize(Sender: TObject);
    procedure BtnFormsClick(Sender: TObject);
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
    function GetForm_DEntrada(Index: integer): TMyForm_DEntrada;
    function GetForm_Avulso(Index: integer): TMyForm_Avulso;
  public
    { Public declarations }
    CurObject: TObject;
    ObjectName: String;
    HideProperties: Boolean;
    HostScroll: TScrollBox;
    procedure Atribui(Sender: TObject; Tudo: Boolean);
    //procedure CreateParams(var Params: TCreateParams); override;
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

    property Form_DEntrada[Index: Integer]: TMyForm_DEntrada read GetForm_DEntrada;
    property Form_Avulso[index: Integer]: TMyForm_Avulso read GetForm_Avulso;
    function CurrentForm_DEntrada: TMyForm_DEntrada;
    function CurrentForm_Avulso: TMyForm_Avulso;
    function CurrentTipo_Form: Integer;
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
  FormDesigner: TFormDesigner;
  PropInspector: TPropertyInspector;

const
  Comum = 'Left;Top;Width;Height;';

implementation

{$R *.DFM}

uses PicEdit, StrEdit, Rotinas, MiniEditor, Formular, Abertura, FormsProj;

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
                Conteudo := FormDesigner.GetPropAsString(TObject(GetOrdProp(Sender, Info)),PropList[I],True);
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
          Conteudo := FormDesigner.GetPropAsString(Comp,PropInfo,False);
          if UpperCase(Trim(PropList^[I].Name)) = 'VISIBLE' then
            case FormDesigner.CurrentTipo_Form of
              0: if FormDesigner.CurrentForm_DEntrada.ListaInvisivel.IndexOf(UpperCase(Comp.Name)) > -1 then
                   Conteudo := 'False';
              1: if FormDesigner.CurrentForm_Avulso.ListaInvisivel.IndexOf(UpperCase(Comp.Name)) > -1 then
                   Conteudo := 'False';
            end;
          if UpperCase(Trim(PropList^[I].Name)) = 'ENABLED' then
            case FormDesigner.CurrentTipo_Form of
              0: if FormDesigner.CurrentForm_DEntrada.ListaDesabilitado.IndexOf(UpperCase(Comp.Name)) > -1 then
                   Conteudo := 'False';
              1: if FormDesigner.CurrentForm_Avulso.ListaDesabilitado.IndexOf(UpperCase(Comp.Name)) > -1 then
                   Conteudo := 'False';
            end;
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
        case FormDesigner.CurrentTipo_Form of
          0: Y := FormDesigner.CurrentForm_DEntrada.ListaEventos.IndexOf(Comp.Name + ':' + StrEvento);
          1: Y := FormDesigner.CurrentForm_Avulso.ListaEventos.IndexOf(Comp.Name + ':' + StrEvento);
        end;
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
  case FormDesigner.CurrentTipo_Form of
    0: if FormDesigner.CurrentForm_DEntrada.ListaSelecionados.Count = 1 then
         GetEvent(TControl(Sender),listaProp);
    1: if FormDesigner.CurrentForm_Avulso.ListaSelecionados.Count = 1 then
         GetEvent(TControl(Sender),listaProp);
  end;
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
//procedure TFormDesigner.CreateParams(var Params: TCreateParams);
//begin
//  inherited;
  //Params.WndParent := frDesigner.Handle;
//end;

function TFormDesigner.GetForm_DEntrada(Index: integer): TMyForm_DEntrada;
var
  I,Y : integer;
begin
  Result := nil;
  for I := 0 to PageControl_Forms.Pages[Index].ControlCount-1 do
    if PageControl_Forms.Pages[Index].Controls[I] is TScrollBox then
      for Y := 0 to (PageControl_Forms.Pages[Index].Controls[I] as TScrollBox).ControlCount-1 do
        if (PageControl_Forms.Pages[Index].Controls[I] as TScrollBox).Controls[Y] is TMyForm_DEntrada then
        begin
          Result := (PageControl_Forms.Pages[Index].Controls[I] as TScrollBox).Controls[Y] as TMyForm_DEntrada;
          break;
        end;
end;

function TFormDesigner.GetForm_Avulso(Index: integer): TMyForm_Avulso;
var
  I,Y : integer;
begin
  Result := nil;
  for I := 0 to PageControl_Forms.Pages[Index].ControlCount-1 do
    if PageControl_Forms.Pages[Index].Controls[I] is TScrollBox then
      for Y := 0 to (PageControl_Forms.Pages[Index].Controls[I] as TScrollBox).ControlCount-1 do
        if (PageControl_Forms.Pages[Index].Controls[I] as TScrollBox).Controls[Y] is TMyForm_Avulso then
        begin
          Result := (PageControl_Forms.Pages[Index].Controls[I] as TScrollBox).Controls[Y] as TMyForm_Avulso;
          break;
        end;
end;

function TFormDesigner.CurrentForm_DEntrada: TMyForm_DEntrada;
begin
  Result := Form_DEntrada[PageControl_Forms.ActivePage.PageIndex];
end;

function TFormDesigner.CurrentForm_Avulso: TMyForm_Avulso;
begin
  Result := Form_Avulso[PageControl_Forms.ActivePage.PageIndex];
end;

function TFormDesigner.CurrentTipo_Form: Integer;
begin
  Result := PageControl_Forms.Pages[PageControl_Forms.ActivePage.PageIndex].Tag;
end;

function TFormDesigner.GetPropValue(Index: Integer): Variant;
begin
  Result := TProp(FItems.Objects[Index]).Value;
end;

procedure TFormDesigner.SetPropValue(Index: Integer; Value: Variant);
begin
  TProp(FItems.Objects[Index]).Value := Value;
end;

procedure TFormDesigner.ClearProperties(Tudo: Boolean);
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

procedure TFormDesigner.Inicializa(Sender: TObject);
begin
  PropInspector.Update(Sender);
end;

procedure TFormDesigner.AddProperty(PropName: String; PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant;
  PropEditor: TNotifyEvent);
begin
  FItems.AddObject('   ' + PropName, TProp.Create(PropValue, PropEnum,
    PropEnumValues, PropEditor));
end;

procedure TFormDesigner.InsertProperty(Index: Integer; PropName: String; PropValue: Variant;
  PropEnum: TStringList; PropEnumValues: Variant;
  PropEditor: TNotifyEvent);
begin
  FItems.InsertObject(Index, '   ' + PropName, TProp.Create(PropValue, PropEnum,
    PropEnumValues, PropEditor));
end;

function TFormDesigner.CurItem: TProp;
begin
  Result := nil;
  if (FItemIndex <> -1) and (Count > 0) then
    Result := TProp(FItems.Objects[FItemIndex]);
end;

procedure TFormDesigner.SetItems(Value: TStringList);
begin
  FItems.Assign(Value);
  FItemIndex := -1;
  PaintBox1.Repaint;
  ItemIndex := 0;
end;

procedure TFormDesigner.SetItemValue(Value: String);
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
      case CurrentTipo_Form of
        0: y := CurrentForm_DEntrada.ListaInvisivel.IndexOf(UpperCase(PropInspector.VControl.Name));
        1: y := CurrentForm_Avulso.ListaInvisivel.IndexOf(UpperCase(PropInspector.VControl.Name));
      end;
      if UpperCase(Trim(Edit1.Text)) = 'TRUE' then
      begin
        if y > -1 then
          case CurrentTipo_Form of
            0: CurrentForm_DEntrada.ListaInvisivel.Delete(y);
            1: CurrentForm_Avulso.ListaInvisivel.Delete(y);
          end;  
      end
      else
      begin
        if y < 0 then
          case CurrentTipo_Form of
            0: CurrentForm_DEntrada.ListaInvisivel.Add(UpperCase(PropInspector.VControl.Name));
            1: CurrentForm_Avulso.ListaInvisivel.Add(UpperCase(PropInspector.VControl.Name));
          end;  
      end;
    end
    else if (UpperCase(Trim(Nome)) = 'ENABLED') and (UpperCase(Copy(FItems[FItemIndex],01,04)) = '   E') then
    begin
      case CurrentTipo_Form of
        0: y := CurrentForm_DEntrada.ListaDesabilitado.IndexOf(UpperCase(PropInspector.VControl.Name));
        1: y := CurrentForm_Avulso.ListaDesabilitado.IndexOf(UpperCase(PropInspector.VControl.Name));
      end;
      if UpperCase(Trim(Edit1.Text)) = 'TRUE' then
      begin
        if y > -1 then
          case CurrentTipo_Form of
            0: CurrentForm_DEntrada.ListaDesabilitado.Delete(y);
            1: CurrentForm_Avulso.ListaDesabilitado.Delete(y);
          end;
      end
      else
      begin
        if y < 0 then
          case CurrentTipo_Form of
            0: CurrentForm_DEntrada.ListaDesabilitado.Add(UpperCase(PropInspector.VControl.Name));
            1: CurrentForm_Avulso.ListaDesabilitado.Add(UpperCase(PropInspector.VControl.Name));
          end;
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
  case CurrentTipo_Form of
    0: CurrentForm_DEntrada.DsnRegister.DsnStage.UpdateControl;
    1: CurrentForm_Avulso.DsnRegister.DsnStage.UpdateControl;
  end;
end;

function TFormDesigner.GetItemValue(i: Integer): String;
var
  p: TProp;
begin
  Result := '';
  p := TProp(FItems.Objects[i]);
  if p = nil then Exit;
  Result := p.Text;
end;

procedure TFormDesigner.SetItemIndex(Value: Integer);
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

function TFormDesigner.GetCount: Integer;
begin
  Result := FItems.Count;
end;

procedure TFormDesigner.ItemsChanged;
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

procedure TFormDesigner.DrawOneLine(i: Integer; a: Boolean);
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

procedure TFormDesigner.PaintBox1Paint(Sender: TObject);
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
    case CurrentTipo_Form of
      0: CurrentForm_DEntrada.Thread_ok := True;
      1: CurrentForm_Avulso.Thread_ok := True;
    end;
  end;
end;

procedure TFormDesigner.FormCreate(Sender: TObject);
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
  DefHeight := TabSheet_Object.Height; //Height;
  FormResize(nil);
end;

procedure TFormDesigner.FormDestroy(Sender: TObject);
var
  I,Y,Z: Integer;
begin
  for Z := 0 to PageControl_Forms.PageCount-1 do
    for I := 0 to PageControl_Forms.Pages[Z].ControlCount-1 do
      if PageControl_Forms.Pages[Z].Controls[I] is TScrollBox then
      begin
        for Y := 0 to (PageControl_Forms.Pages[Z].Controls[I] as TScrollBox).ControlCount-1 do
        begin
          if (PageControl_Forms.Pages[Z].Controls[I] as TScrollBox).Controls[Y] is TMyForm_DEntrada then
            TMyForm_DEntrada((PageControl_Forms.Pages[Z].Controls[I] as TScrollBox).Controls[Y]).Close
          else
            if (PageControl_Forms.Pages[Z].Controls[I] as TScrollBox).Controls[Y] is TMyForm_Avulso then
              TMyForm_Avulso((PageControl_Forms.Pages[Z].Controls[I] as TScrollBox).Controls[Y]).Close;
        end;
        (PageControl_Forms.Pages[Z].Controls[I] as TScrollBox).Destroy;
      end;
  b.Free;
  LB1.Free;
  ClearProperties(False);
  FItems.Free;
end;

procedure TFormDesigner.FormActivate(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: if CurrentForm_DEntrada.ExcluiComp then
         CurrentForm_DEntrada.AtualizaLista_CB;
    1: if CurrentForm_Avulso.ExcluiComp then
         CurrentForm_Avulso.AtualizaLista_CB;
  end;
  if Edit1.Enabled and Edit1.Visible then
    Edit1.SetFocus;
end;

procedure TFormDesigner.FormDeactivate(Sender: TObject);
begin
  if BusyFlag then Exit;
  LB1.Hide;
  if CurItem = nil then Exit;
end;

procedure TFormDesigner.FormShow(Sender: TObject);
var
  Page : TTabSheet;
  Formulario : TMyForm_DEntrada;
  Avulso: TMyForm_Avulso;
  ScrollBox : TScrollBox;
begin
  Page := TTabSheet.Create(self);
  try
    Page.PageControl := PageControl_Forms;
    Page.Caption     := 'Formulário';
    Page.Name        := 'TabSheet_'+IntToStr(PageControl_Forms.PageCount + 1);
    ScrollBox := TScrollBox.Create(Page);
    with ScrollBox do
    begin
      Parent      := Page;
      Align       := alClient;
      BorderStyle := bsNone;
      Color       := clWindow;
      HorzScrollBar.Style := ssHotTrack;
      VertScrollBar.Style := ssHotTrack;
      Name        := 'ScrollBox_'+IntToStr(PageControl_Forms.PageCount + 1);
    end;
    HostScroll  := ScrollBox;
    if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 5) or
       (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 6) then
    begin
      Avulso := TMyForm_Avulso.Create(Page);
      with Avulso do
      begin
        Caption  := FormFormularios.EdTitulo.Text + ' ( Avulso )';
        NomeForm := FormFormularios.EdNome.Text;
        NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
        NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
        Page.Caption := NomeForm;
        Page.Tag := 1; // Avulso
        Show;
      end;
    end
    else
    begin
      Formulario := TMyForm_DEntrada.Create(Page);
      with Formulario do
      begin
        Caption  := FormFormularios.EdTitulo.Text + ' ( Entrada de Dados )';
        NomeForm := FormFormularios.EdNome.Text;
        NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
        NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
        Page.Caption := NomeForm;
        Page.Tag := 0; // Entrada de Dados
        Show;
      end;
    end;
  except
    on exception do
    begin
      if Assigned(ScrollBox) then
        ScrollBox.Free;
      if Assigned(Formulario) then
        Formulario.Free;
      if Assigned(Avulso) then
        Avulso.Free;
      Page.Free;
      Close;
    end;
  end;
  SplitterPos := 75;
  Posicao_Unit := 0;
  if TabSheet_Object.ClientHeight < 20 then
    CB1.Hide;
end;

procedure TFormDesigner.WMNCLButtonDblClk(var Message: TMessage);
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

procedure TFormDesigner.FormResize(Sender: TObject);
begin
  Box.Width := TabSheet_Object.ClientWidth;
  Box.Height := TabSheet_Object.ClientHeight - CB1.Height - 7; //- ControlBar2.Height;
  CB1.Width := TabSheet_Object.ClientWidth;

  PanelObj.Height := Items.Count * FRowHeight;
  PanelObj.Width := Box.ClientWidth;

  w := PaintBox1.Width;
  SetItemIndex(FItemIndex);
end;

procedure TFormDesigner.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TFormDesigner.Edit1KeyDown(Sender: TObject; var Key: Word;
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

procedure TFormDesigner.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Edit1.Modified then SetItemValue(Edit1.Text);
    Edit1.Modified := False;
    Edit1.SelectAll;
    Key := #0;
  end;
end;

procedure TFormDesigner.EditBtnClick(Sender: TObject);
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
      case FormDesigner.CurrentTipo_Form of
        0: Pesquisa := 'procedure TForm' + CurrentForm_DEntrada.NomeForm + '.' + StrEvento + ';';
        1: Pesquisa := 'procedure TForm' + CurrentForm_Avulso.NomeForm + '.' + StrEvento + ';';
      end;
      FormMiniEditor.E_Cabecalho.Lines.Text := Pesquisa;
      FormMiniEditor.Validar_Bloco := True;
      Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
      FormMiniEditor.E_Metodo.Lines.Clear;
      case FormDesigner.CurrentTipo_Form of
        0: begin
             //CurrentForm_DEntrada.TextoPAS.CaretX := 1;
             //CurrentForm_DEntrada.TextoPAS.CaretY := 1;
           end;
        1: begin
             //CurrentForm_Avulso.TextoPAS.CaretX := 1;
             //CurrentForm_Avulso.TextoPAS.CaretY := 1;
           end;
      end;
      InicioEvento := 0;
      //case FormDesigner.CurrentTipo_Form of
      //  0: CurrentForm_DEntrada.TextoPAS.SearchReplace(Pesquisa, '', CurrentForm_DEntrada.SearchOptionsPd );
      //  1: CurrentForm_Avulso.TextoPAS.SearchReplace(Pesquisa, '', CurrentForm_Avulso.SearchOptionsPd );
      //end;
      case FormDesigner.CurrentTipo_Form of
        0: begin
             if true then//CurrentForm_DEntrada.TextoPAS.CaretY > 1 then
             begin
               Qtd_Begin := 0;
               Qtd_End := 0;
               Qtd_I_Coment := 0;
               Qtd_F_Coment := 0;
               {with CurrentForm_DEntrada.TextoPAS do
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
                     FormMiniEditor.E_Metodo.Lines.Add(LineText);
                   CaretY := CaretY + 01;
                   Pesquisa := Trim(UpperCase(LineText));
                   if (Copy(Pesquisa,01,04) = 'END.') or
                      (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORM' + UpperCase(CurrentForm_DEntrada.NomeForm) + '.' ) or
                      (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORM' + UpperCase(CurrentForm_DEntrada.NomeForm) + '.' ) then
                     Fim := True;
                 end;
               end;}
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
           end;
        1: begin
             if true then //CurrentForm_Avulso.TextoPAS.CaretY > 1 then
             begin
               Qtd_Begin := 0;
               Qtd_End := 0;
               Qtd_I_Coment := 0;
               Qtd_F_Coment := 0;
               {with CurrentForm_Avulso.TextoPAS do
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
                     FormMiniEditor.E_Metodo.Lines.Add(LineText);
                   CaretY := CaretY + 01;
                   Pesquisa := Trim(UpperCase(LineText));
                   if (Copy(Pesquisa,01,04) = 'END.') or
                      (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'PROCEDURE TFORM' + UpperCase(CurrentForm_Avulso.NomeForm) + '.' ) or
                      (Copy(Pesquisa,01,Pos('.',Pesquisa)) = 'FUNCTION TFORM' + UpperCase(CurrentForm_Avulso.NomeForm) + '.' ) then
                     Fim := True;
                 end;
               end;}
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
           end;
      end;
      if FormMiniEditor.ShowModal = mrOk then
      begin
        if FormMiniEditor.ExcluirEvento.Checked then
        begin
          Pesquisa := 'procedure ' + StrEvento + ';';
          Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
          case FormDesigner.CurrentTipo_Form of
            0: begin
                 {urrentForm_DEntrada.TextoPAS.CaretX := 1;
                 CurrentForm_DEntrada.TextoPAS.CaretY := 1;
                 CurrentForm_DEntrada.TextoPAS.SearchReplace(Pesquisa, '', CurrentForm_DEntrada.SearchOptionsPd );
                 if CurrentForm_DEntrada.TextoPAS.CaretY > 1 then
                 begin
                   P := CurrentForm_DEntrada.TextoPAS.CaretY - 1;
                   Fim := false;
                   IntVal := 0;
                   while not Fim do
                   begin
                     if Pos(');',RetiraBrancos(CurrentForm_DEntrada.TextoPas.Lines[P])) > 0 then Fim := True;
                     CurrentForm_DEntrada.TextoPAS.Lines.Delete(P);
                     Inc(IntVal);
                  end;
                 end;
                 CurrentForm_DEntrada.TextoPAS.CaretY := InicioEvento;
                 P := CurrentForm_DEntrada.TextoPAS.CaretY - IntVal ;
                 for I:=0 to Qtd_Linhas_Original+InicioBloco-InicioEvento+1 do
                   CurrentForm_DEntrada.TextoPas.Lines.Delete(P - 1);
                 P := CurrentForm_DEntrada.ListaEventos.IndexOf(TControl(PropInspector.VControl).Name + ':' + Copy(StrEvento,01,Pos('(',StrEvento)-1));
                 if P > -1 then
                 begin
                   CurrentForm_DEntrada.ListaEventos.Delete(P);
                   Edit1.Text := '';
                   Prop := TProp(FItems.Objects[FItemIndex]);
                   Prop.Text := Edit1.Text;
                   PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
                 end;}
               end;
            1: begin
                 {CurrentForm_Avulso.TextoPAS.CaretX := 1;
                 CurrentForm_Avulso.TextoPAS.CaretY := 1;
                 CurrentForm_Avulso.TextoPAS.SearchReplace(Pesquisa, '', CurrentForm_Avulso.SearchOptionsPd );
                 if CurrentForm_Avulso.TextoPAS.CaretY > 1 then
                 begin
                   P := CurrentForm_Avulso.TextoPAS.CaretY - 1;
                   Fim := false;
                   IntVal := 0;
                   while not Fim do
                   begin
                     if Pos(');',RetiraBrancos(CurrentForm_Avulso.TextoPas.Lines[P])) > 0 then Fim := True;
                     CurrentForm_Avulso.TextoPAS.Lines.Delete(P);
                     Inc(IntVal);
                  end;
                 end;
                 CurrentForm_Avulso.TextoPAS.CaretY := InicioEvento;
                 P := CurrentForm_Avulso.TextoPAS.CaretY - IntVal ;
                 for I:=0 to Qtd_Linhas_Original+InicioBloco-InicioEvento+1 do
                   CurrentForm_Avulso.TextoPas.Lines.Delete(P - 1);
                 P := CurrentForm_Avulso.ListaEventos.IndexOf(TControl(PropInspector.VControl).Name + ':' + Copy(StrEvento,01,Pos('(',StrEvento)-1));
                 if P > -1 then
                 begin
                   CurrentForm_Avulso.ListaEventos.Delete(P);
                   Edit1.Text := '';
                   Prop := TProp(FItems.Objects[FItemIndex]);
                   Prop.Text := Edit1.Text;
                   PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
                 end;}
               end;
          end;
        end
        else
        begin
          case FormDesigner.CurrentTipo_Form of
            0: begin
                 CurrentForm_DEntrada.ListaEventos.Add(TControl(PropInspector.VControl).Name + ':' + Copy(StrEvento,01,Pos('(',StrEvento)-1));
                 Edit1.Text := TControl(PropInspector.VControl).Name + Copy(PropName,03,40);
                 Prop := TProp(FItems.Objects[FItemIndex]);
                 Prop.Text := Edit1.Text;
                 PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
                 if InicioBloco > 0 then
                 begin
                   {urrentForm_DEntrada.TextoPAS.CaretY := InicioBloco;
                   for I:=0 to Qtd_Linhas_Original do
                     CurrentForm_DEntrada.TextoPas.Lines.Delete(CurrentForm_DEntrada.TextoPAS.CaretY);
                   for I:=0 to FormMiniEditor.E_Metodo.Lines.Count-1 do
                   begin
                     CurrentForm_DEntrada.TextoPas.Lines.Insert(InicioBloco,FormMiniEditor.E_Metodo.Lines[I]);
                     Inc(InicioBloco);
                   end;}
                 end
                 else
                 begin
                   Pesquisa := 'procedure TForm' + CurrentForm_DEntrada.NomeForm + '.' + StrEvento + ';';
                   Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
                   CurrentForm_DEntrada.AbrirEditor(Projeto.Pasta + CurrentForm_DEntrada.NomeForm + '.PAS',Pesquisa,False,'',StrParametros+';',FormMiniEditor.E_Metodo.Lines);
                 end;
               end;
            1: begin
                 CurrentForm_Avulso.ListaEventos.Add(TControl(PropInspector.VControl).Name + ':' + Copy(StrEvento,01,Pos('(',StrEvento)-1));
                 Edit1.Text := TControl(PropInspector.VControl).Name + Copy(PropName,03,40);
                 Prop := TProp(FItems.Objects[FItemIndex]);
                 Prop.Text := Edit1.Text;
                 PropInspector.ListaProp[FItemIndex] := Copy(PropInspector.ListaProp[FItemIndex],01,Pos(':',PropInspector.ListaProp[FItemIndex])+1) + Edit1.Text;
                 if InicioBloco > 0 then
                 begin
                   {CurrentForm_Avulso.TextoPAS.CaretY := InicioBloco;
                   for I:=0 to Qtd_Linhas_Original do
                     CurrentForm_Avulso.TextoPas.Lines.Delete(CurrentForm_Avulso.TextoPAS.CaretY);
                   for I:=0 to FormMiniEditor.E_Metodo.Lines.Count-1 do
                   begin
                     CurrentForm_Avulso.TextoPas.Lines.Insert(InicioBloco,FormMiniEditor.E_Metodo.Lines[I]);
                     Inc(InicioBloco);
                   end;}
                 end
                 else
                 begin
                   Pesquisa := 'procedure TForm' + CurrentForm_Avulso.NomeForm + '.' + StrEvento + ';';
                   Pesquisa := Copy(Pesquisa,01,Pos('(',Pesquisa));
                   CurrentForm_Avulso.AbrirEditor(Projeto.Pasta + CurrentForm_Avulso.NomeForm + '.PAS',Pesquisa,False,'',StrParametros+';',FormMiniEditor.E_Metodo.Lines);
                 end;
               end;
          end;
        end;
        {ase FormDesigner.CurrentTipo_Form of
          0: CurrentForm_DEntrada.TextoPAS.Modified := True;
          1: CurrentForm_Avulso.TextoPAS.Modified := True;
        end;}
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

procedure TFormDesigner.Edit1DblClick(Sender: TObject);
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

procedure TFormDesigner.CB1Click(Sender: TObject);
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
    case FormDesigner.CurrentTipo_Form of
      0: while I <= CurrentForm_DEntrada.ComponentCount-1 do
         begin
           if CurrentForm_DEntrada.Components[I].Name = NomeComp then
           begin
             Componente := CurrentForm_DEntrada.Components[I];
             I := 9999;
           end;
           Inc(I);
         end;
      1: while I <= CurrentForm_Avulso.ComponentCount-1 do
         begin
           if CurrentForm_Avulso.Components[I].Name = NomeComp then
           begin
             Componente := CurrentForm_Avulso.Components[I];
             I := 9999;
           end;
           Inc(I);
         end;
    end;
    if Componente <> nil then
    begin
      Control := TControl(Componente);
      case FormDesigner.CurrentTipo_Form of
        0: begin
             if not CurrentForm_DEntrada.VamosGravar then
             begin
               if Copy(Control.Parent.Name,01,08) = 'DsnStage' then
               begin
                 NrPg := StrToIntDef(Trim(Copy(Control.Parent.Name,09,02)),0);
                 if (NrPg > -1) and (NrPg < CurrentForm_DEntrada.TabPaginas.Tabs.Count) then
                 begin
                   CurrentForm_DEntrada.NoManutencao.PageIndex := NrPg;
                   CurrentForm_DEntrada.TabPaginas.TabIndex    := NrPg;
                 end;
               end;
             end;
             CurrentForm_DEntrada.ObjetoAtual := Control;
             if not CurrentForm_DEntrada.VamosGravar then
               CurrentForm_DEntrada.DsnSelect.Select(Control)
             else
               Atribui(Control, True);
           end;
        1: begin
             if not CurrentForm_Avulso.VamosGravar then
             begin
               if Copy(Control.Parent.Name,01,08) = 'DsnStage' then
               begin
                 NrPg := StrToIntDef(Trim(Copy(Control.Parent.Name,09,02)),0);
                 //if (NrPg > -1) and (NrPg < CurrentForm_Avulso.TabPaginas.Tabs.Count) then
                 //begin
                 //  CurrentForm_Avulso.NoManutencao.PageIndex := NrPg;
                 //  CurrentForm_Avulso.TabPaginas.TabIndex    := NrPg;
                 //end;
               end;
             end;
             CurrentForm_Avulso.ObjetoAtual := Control;
             if not CurrentForm_Avulso.VamosGravar then
               CurrentForm_Avulso.DsnSelect.Select(Control)
             else
               Atribui(Control, True);
           end;
      end;
    end;
    if Edit1.Visible then Edit1.SetFocus;
  end;
end;

function TFormDesigner.GetClassName(ObjName: String): String;
begin
  if CurObject <> nil then
    Result := CurObject.ClassName else
    Result := '';
end;

procedure TFormDesigner.ComboBtnClick(Sender: TObject);
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

procedure TFormDesigner.LB1Click(Sender: TObject);
begin
  Edit1.Text := LB1.ListBox.Items[LB1.ListBox.ItemIndex];
  LB1.Hide;
  Edit1.SetFocus;
  Edit1.ReadOnly := False;
  SetItemValue(Edit1.Text);
  Edit1.ReadOnly := True;
end;

{$WARNINGS OFF}
procedure TFormDesigner.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if GetTickCount - FTickCount < GetDoubleClickTime then
    Edit1DblClick(nil);
end;
{$WARNINGS ON}

procedure TFormDesigner.Grow;
begin
  Show;
  if TabSheet_Object.ClientHeight < 20 then
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

procedure TFormDesigner.PaintBox1MouseMove(Sender: TObject;
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

procedure TFormDesigner.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := False;
end;

procedure TFormDesigner.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Resposta: Integer;
begin
  if (CurrentForm_DEntrada <> nil) then
  begin
    {f (CurrentForm_DEntrada.TextoPas.Modified or
       CurrentForm_DEntrada.TextoDfm.Modified) and not MsgSalvar then
    begin
      MsgSalvar := True;
      Resposta := Mensagem('Salvar Formulário ?',ModConfirmacao,[ModSim, ModNao, ModCancela]);
      if Resposta = mrYes then
        CurrentForm_DEntrada.SalvarFormulario
      else if Resposta = mrCancel then
      begin
        Action := caNone;
        MsgSalvar := False;
        exit;
      end;
    end;}
    CurrentForm_DEntrada.DsnRegister.Designing := False;
  end;
  if (CurrentForm_Avulso <> nil) then
  begin
    {if (CurrentForm_Avulso.TextoPas.Modified or
       CurrentForm_Avulso.TextoDfm.Modified) and not MsgSalvar then
    begin
      MsgSalvar := True;
      Resposta := Mensagem('Salvar Formulário ?',ModConfirmacao,[ModSim, ModNao, ModCancela]);
      if Resposta = mrYes then
        CurrentForm_Avulso.SalvarFormulario
      else if Resposta = mrCancel then
      begin
        Action := caNone;
        MsgSalvar := False;
        exit;
      end;
    end;}
    CurrentForm_Avulso.DsnRegister.Designing := False;
  end;
  PropInspector.Free;
  Action := Cafree;
  FormDesigner := Nil;
end;

procedure TFormDesigner.PaintBox1DblClick(Sender: TObject);
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

procedure TFormDesigner.Atribui(Sender: TObject; Tudo: Boolean);
var
  I,Y: Integer;
begin
  case FormDesigner.CurrentTipo_Form of
    0: if CurrentForm_DEntrada.ExcluiComp then
         CurrentForm_DEntrada.AtualizaLista_CB;
    1: if CurrentForm_Avulso.ExcluiComp then
         CurrentForm_Avulso.AtualizaLista_CB;
  end;
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

procedure TFormDesigner.Edit1Change(Sender: TObject);
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

procedure TFormDesigner.BtnFormatarClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.AutoFormatar;
  end;  
end;

procedure TFormDesigner.BtnIncrementoClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.AutoIncremento;
  end;  
end;

procedure TFormDesigner.BtnFormFilhoClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.Cria_Grid_Relacionamento;
  end;  
end;

procedure TFormDesigner.BtnCampoClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.InserirCamposDB;
  end;
end;

procedure TFormDesigner.MnuPaginasClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: begin
         if CurrentForm_DEntrada.ListaSelecionados <> Nil then
           CurrentForm_DEntrada.ListaSelecionados.Clear;
         CurrentForm_DEntrada.DsnRegister.ClearSelect;
         Atribui(Nil,True);
         MnuPaginas.Checked := True;
         RodapeMnt.Checked  := False;
         RodapeCns.Checked  := False;
         CurrentForm_DEntrada.PagePrincipal.ActivePageIndex := 0;
         CurrentForm_DEntrada.TabPaginasClick(Self);
       end;
  end;
end;

procedure TFormDesigner.RodapeMntClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: begin
         if CurrentForm_DEntrada.ListaSelecionados <> Nil then
           CurrentForm_DEntrada.ListaSelecionados.Clear;
         CurrentForm_DEntrada.DsnRegister.ClearSelect;
         Atribui(Nil,True);
         RodapeMnt.Checked  := True;
         MnuPaginas.Checked := False;
         RodapeCns.Checked  := False;
         CurrentForm_DEntrada.PagePrincipal.ActivePageIndex := 0;
         CurrentForm_DEntrada.DsnRegister.Designing := False;
         CurrentForm_DEntrada.DsnRegister.DsnStage  := CurrentForm_DEntrada.DsnStage_Mnt;
         CurrentForm_DEntrada.DsnRegister.Designing := True;
       end;
  end;
end;

procedure TFormDesigner.RodapeCnsClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: begin
         if CurrentForm_DEntrada.ListaSelecionados <> Nil then
           CurrentForm_DEntrada.ListaSelecionados.Clear;
         CurrentForm_DEntrada.DsnRegister.ClearSelect;
         Atribui(Nil,True);
         RodapeCns.Checked  := True;
         RodapeMnt.Checked  := False;
         MnuPaginas.Checked := False;
         CurrentForm_DEntrada.PagePrincipal.ActivePageIndex := 1;
         CurrentForm_DEntrada.DsnRegister.Designing := False;
         CurrentForm_DEntrada.DsnRegister.DsnStage  := CurrentForm_DEntrada.DsnStage_Cnt;
         CurrentForm_DEntrada.DsnRegister.Designing := True;
       end;
  end;     
end;

procedure TFormDesigner.BtnFonteClick(Sender: TObject);
begin
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.Divisao.Visible := False;
    FormMiniEditor.ExcluirEvento.Visible := False;
    FormMiniEditor.E_Cabecalho.Visible := False;
    FormMiniEditor.E_Metodo.Lines.Clear;
    {ase FormDesigner.CurrentTipo_Form of
      0: FormMiniEditor.E_Metodo.Lines := CurrentForm_DEntrada.TextoPas.Lines;
      1: FormMiniEditor.E_Metodo.Lines := CurrentForm_Avulso.TextoPas.Lines;
    end;}
    FormMiniEditor.E_Metodo.Modified := False;
    FormMiniEditor.Posicao_Y := Posicao_Unit;
    if FormMiniEditor.ShowModal = mrOk then
    begin
      {Case FormDesigner.CurrentTipo_Form of
        0: begin
             CurrentForm_DEntrada.TextoPAS.Lines := FormMiniEditor.E_Metodo.Lines;
             CurrentForm_DEntrada.TextoPAS.Modified := True;
           end;
        1: begin
             CurrentForm_Avulso.TextoPAS.Lines := FormMiniEditor.E_Metodo.Lines;
             CurrentForm_Avulso.TextoPAS.Modified := True;
           end
      end;}
    end;
  Finally
    Posicao_Unit := FormMiniEditor.E_Metodo.CaretY;
    FormMiniEditor.Free;
  end;
end;

procedure TFormDesigner.CB1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then CB1Click(Self);
end;

procedure TFormDesigner.BtnPaginasClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.EditarPaginas;
  end;
end;

procedure TFormDesigner.BtnOrdemTabClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.Define_TabOrder;
  end;  
end;

function TFormDesigner.GetPropAsString(Obj: TObject; Info: PPropInfo; SubItem: Boolean): string;
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

procedure TFormDesigner.BtnDesignerClick(Sender: TObject);
begin
  BtnDesigner.CheckMenuDropdown;
end;

procedure TFormDesigner.BtnSalvarClick(Sender: TObject);
begin
  case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.SalvarFormulario;
    1: CurrentForm_Avulso.SalvarFormulario;
  end;
end;

procedure TFormDesigner.BtnStyleClick(Sender: TObject);
begin
  BtnStyle.CheckMenuDropdown;
end;

procedure TFormDesigner.dsg_NormalClick(Sender: TObject);
begin
  dsg_Normal.Checked     := True;
  dsg_Maximizada.Checked := False;
  dsg_Minimizada.Checked := False;
  {case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.TextoPAS.Modified := True;
    1: CurrentForm_Avulso.TextoPAS.Modified := True;
  end;}
end;

procedure TFormDesigner.dsg_MaximizadaClick(Sender: TObject);
begin
  dsg_Normal.Checked     := False;
  dsg_Maximizada.Checked := True;
  dsg_Minimizada.Checked := False;
  {case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.TextoPAS.Modified := True;
    1: CurrentForm_Avulso.TextoPAS.Modified := True;
  end;}
end;

procedure TFormDesigner.dsg_MinimizadaClick(Sender: TObject);
begin
  dsg_Normal.Checked     := False;
  dsg_Maximizada.Checked := False;
  dsg_Minimizada.Checked := True;
  {case FormDesigner.CurrentTipo_Form of
    0: CurrentForm_DEntrada.TextoPAS.Modified := True;
    1: CurrentForm_Avulso.TextoPAS.Modified := True;
  end;}
end;

procedure TFormDesigner.Btn_S_FClick(Sender: TObject);
begin
  PnFundo_L_S.Visible := False;
  Splitter_D_J.Visible := False;

  if (not PnFundo_L_S.Visible) and (not PnFundo_L_I.Visible) then
  begin
    PnFundo_L.Visible := False;
    Splitter_L.Visible := False;
  end;
  FormResize(nil);
end;

procedure TFormDesigner.Btn_I_FClick(Sender: TObject);
begin
  PnFundo_L_I.Visible := False;

  if (not PnFundo_L_S.Visible) and (not PnFundo_L_I.Visible) then
  begin
    PnFundo_L.Visible := False;
    Splitter_L.Visible := False;
  end;
  FormResize(nil);
end;

procedure TFormDesigner.Splitter_LMoved(Sender: TObject);
begin
  FormResize(nil);
end;

procedure TFormDesigner.PnFundo_LResize(Sender: TObject);
begin
  Btn_S_F.Left        := Pn_Barra_S_00.Width - 12;
  Pn_Barra_S_01.Width := Pn_Barra_S_00.Width - 15;
  Pn_Barra_S_02.Width := Pn_Barra_S_00.Width - 15;

  Btn_I_F.Left        := Pn_Barra_I_00.Width - 12;
  Pn_Barra_I_01.Width := Pn_Barra_I_00.Width - 15;
  Pn_Barra_I_02.Width := Pn_Barra_I_00.Width - 15;
end;

procedure TFormDesigner.BtnFormsClick(Sender: TObject);
var
  Page : TTabSheet;
  Formulario : TMyForm_DEntrada;
  Avulso: TMyForm_Avulso;
  ScrollBox : TScrollBox;
  x_nome: String;
begin
  FormsProjeto := TFormsProjeto.Create(Application);
  Try
    if (FormsProjeto.ShowModal = mrOk) and (FormsProjeto.Lista.ItemIndex > -1) and
       (Trim(FormsProjeto.EdPesquisa.Text) <> '') then
    begin
      x_nome := FormsProjeto.Lista.Items[FormsProjeto.Lista.ItemIndex];
      Page := TTabSheet.Create(self);
      try
        Page.PageControl := PageControl_Forms;
        Page.Caption     := 'Formulário';
        Page.Name        := 'TabSheet_'+IntToStr(PageControl_Forms.PageCount + 1);
        ScrollBox := TScrollBox.Create(Page);
        with ScrollBox do
        begin
          Parent      := Page;
          Align       := alClient;
          BorderStyle := bsNone;
          Color       := clWindow;
          HorzScrollBar.Style := ssHotTrack;
          VertScrollBar.Style := ssHotTrack;
          Name        := 'ScrollBox_'+IntToStr(PageControl_Forms.PageCount + 1);
        end;
        HostScroll  := ScrollBox;
        Avulso := TMyForm_Avulso.Create(Page);
        with Avulso do
        begin
          Caption  := x_nome;
          NomeForm := x_nome;
          NomeTab  := '';
          NrTabela := '';
          Page.Caption := NomeForm;
          Page.Tag := 1; // Avulso
          Show;
        end;
      except
        on exception do
        begin
          if Assigned(ScrollBox) then
            ScrollBox.Free;
          if Assigned(Formulario) then
            Formulario.Free;
          if Assigned(Avulso) then
            Avulso.Free;
          Page.Free;
          Close;
        end;
      end;
      PageControl_Forms.ActivePageIndex := PageControl_Forms.PageCount-1;
      CurrentForm_Avulso.Refresh;
    end;
  Finally
    FormsProjeto.Free;
  end;
end;

end.
