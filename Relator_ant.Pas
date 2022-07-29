unit Relator_ant;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ToolWin, FR_Desgn, FR_E_HTM, FR_E_CSV, FR_E_RTF,
  FR_E_TXT, FR_RRect, FR_Chart, FR_BarC, FR_Shape, FR_ChBox, FR_Rich,
  FR_OLE, FR_DSet, FR_Class, ComCtrls, 
  ExtCtrls, IBQuery, Db, IBCustomDataSet, FR_DBSet, IB, IBSQL, FileCtrl, ShellApi;

type
  TFormRelatorio_Ant = class(TForm)
    PageControl: TPageControl;
    TabPrincipal: TTabSheet;
    TabRelacionamento: TTabSheet;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    frReport_1: TfrReport;
    frOLEObject1: TfrOLEObject;
    frRichObject1: TfrRichObject;
    frCheckBoxObject1: TfrCheckBoxObject;
    frShapeObject1: TfrShapeObject;
    frBarCodeObject1: TfrBarCodeObject;
    frChartObject1: TfrChartObject;
    frRoundRectObject1: TfrRoundRectObject;
    frTextExport1: TfrTextExport;
    frRTFExport1: TfrRTFExport;
    frCSVExport1: TfrCSVExport;
    frHTMExport1: TfrHTMExport;
    frDesigner: TfrDesigner;
    Ed_Titulo: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Ed_Tipo: TEdit;
    Label4: TLabel;
    Ed_Formulario: TEdit;
    ListaCamposRel: TListBox;
    LbCampos: TLabel;
    BtnPBaixoIndice: TSpeedButton;
    BtnPCimaIndice: TSpeedButton;
    BtnInserirCmp: TSpeedButton;
    BtnExcluirCmp: TSpeedButton;
    Label2: TLabel;
    Label5: TLabel;
    Ed_TabPrincipal: TEdit;
    ListaCamposTab: TTreeView;
    BtnLayout: TBitBtn;
    Bevel1: TBevel;
    TabFiltragem: TTabSheet;
    BtnFonte: TBitBtn;
    Label6: TLabel;
    ListaCamposRel2: TListBox;
    Label7: TLabel;
    ListaCamposTab2: TTreeView;
    BtnInserir: TBitBtn;
    Bevel2: TBevel;
    ListaRelacionamentos: TListBox;
    Label8: TLabel;
    BtnExcluirR: TBitBtn;
    GroupBox2: TGroupBox;
    ListaCamposRel4: TListBox;
    Label9: TLabel;
    Operacao: TRadioGroup;
    Label10: TLabel;
    EdExpressao: TEdit;
    Composicao: TRadioGroup;
    BtnInserirFiltro: TBitBtn;
    Label11: TLabel;
    ListaCampoFil: TListBox;
    TabOrdenacao: TTabSheet;
    GroupBox1: TGroupBox;
    Label21: TLabel;
    BtnInserirInd: TSpeedButton;
    BtnDeleteInd: TSpeedButton;
    Label22: TLabel;
    BtnIndBaixo: TSpeedButton;
    BtnIndCima: TSpeedButton;
    ListaCamposRel3: TListBox;
    ListaCampoInd: TListBox;
    BtnExcluirFiltro: TBitBtn;
    Valorusuario: TCheckBox;
    BtnNegacao: TBitBtn;
    frReport_2: TfrReport;
    QyRelatorio: TIBQuery;
    frDBDataSet: TfrDBDataSet;
    frReport_3: TfrReport;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure ListaCamposTabDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaCamposRelDblClick(Sender: TObject);
    procedure BtnPBaixoIndiceClick(Sender: TObject);
    procedure BtnPCimaIndiceClick(Sender: TObject);
    procedure BtnLayoutClick(Sender: TObject);
    procedure BtnExcluirRClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnIndBaixoClick(Sender: TObject);
    procedure BtnIndCimaClick(Sender: TObject);
    procedure ListaCamposRel3DblClick(Sender: TObject);
    procedure ListaCampoIndDblClick(Sender: TObject);
    procedure BtnExcluirFiltroClick(Sender: TObject);
    procedure BtnInserirFiltroClick(Sender: TObject);
    procedure BtnNegacaoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ValorusuarioExit(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnFonteClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    ListaGeralCampos, ListaGeralCampos2: TStringList;
    Posicao_Unit: Integer;
    procedure AtualizaTabCampos(Tipo: Integer);
    function Salvar: Boolean;
    procedure GeraRel;
    function RetornaTipoCampo(NomeT, NomeC: String; Tipo: Integer): Integer;
    function RetornaNumeroInterno(NomeT, NomeC: String; Tipo: Integer): Integer;
    function RetornaTituloCampo(NomeT, NomeC: String): String;
    procedure CriaTabela;
    function Existe: Boolean;
    procedure DeletaTabela;
  public
    { Public declarations }
    Modificou: Boolean;
    NrFormulario: Integer;
    NomeForm: String;
    NomeTab: String;
    NrTabela: String;
    TipoRel: Integer;
    function Retorna_Tit_Masc_Campo(Posicao: Integer; Tipo: Integer): String;
  end;

var
  FormRelatorio_Ant: TFormRelatorio_Ant;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01, Abertura, Aguarde, MiniEditor;

procedure TFormRelatorio_Ant.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calendário
    FormPrincipal.CalendarioClick(Self)
  else if Key = VK_F6 then // Calculadora
    FormPrincipal.CalculadoraClick(Self)
  else if Key = VK_F7 then // Diário
    FormPrincipal.DiarioProjetoClick(Self)
  else if Key = VK_F1 then // Agenda
    FormPrincipal.ConteudoClick(Self);
end;

procedure TFormRelatorio_Ant.FormShow(Sender: TObject);
var
  FileRel: String;
begin
  Posicao_Unit := 1;
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  Modificou := False;
  PageControl.ActivePageIndex := 0;
  ListaGeralCampos := TStringList.Create;
  ListaGeralCampos2 := TStringList.Create;
  TabGlobal_i.DRELATORIO.Filtro := 'Numero = '+IntToStr(NrFormulario)+' and Tipo = 5';
  TabGlobal_i.DRELATORIO.AtualizaSql;
  TabGlobal_i.DRELATORIO.First;
  FileRel := Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp';
  if FileExists(FileRel) then
    DeleteFile(FileRel);
  if not TabGlobal_i.DRELATORIO.Eof then
    TBlobField(TabGlobal_i.DRELATORIO.FieldByName('ESPELHO_1')).SaveToFile(FileRel);

  if FileExists(FileRel) then
  begin
    if TipoRel = 1 then
      frReport_1.LoadFromFile(FileRel)
    else if TipoRel = 2 then
      frReport_2.LoadFromFile(FileRel)
    else if TipoRel = 3 then
      frReport_3.LoadFromFile(FileRel);
    DeleteFile(FileRel);
  end;

  TabGlobal_i.DRELATORIO.Filtro := 'Numero = '+IntToStr(NrFormulario);
  TabGlobal_i.DRELATORIO.AtualizaSql;
  TabGlobal_i.DRELATORIO.First;
  AtualizaTabCampos(1);
  AtualizaTabCampos(2);
end;

procedure TFormRelatorio_Ant.AtualizaTabCampos(Tipo: Integer);
var
  QueryP, QueryP2: TIBQuery;
  NodeM, NodeM2 : TTreeNode;
  Incluir, Incluir2, Atribui: Boolean;
begin
  if Tipo = 1 then
    ListaCamposRel.Items.Clear
  else if Tipo = 2 then
  begin
    ListaCamposTab.Items.Clear;
    ListaCamposTab2.Items.Clear;
    ListaGeralCampos.Clear;
    ListaGeralCampos2.Clear;
  end;

  if Tipo = 1 then
  begin
    TabGlobal_i.DRELATORIO.First;
    while not TabGlobal_i.DRELATORIO.Eof do
    begin
      if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 1 then
        ListaCamposRel.Items.Add(TabGlobal_i.DRELATORIO.Expressao.Conteudo)
      else if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 2 then
        ListaRelacionamentos.Items.Add(TabGlobal_i.DRELATORIO.Expressao.Conteudo)
      else if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 3 then
        ListaCampoFil.Items.Add(TabGlobal_i.DRELATORIO.Expressao.Conteudo)
      else if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 4 then
        ListaCampoInd.Items.Add(TabGlobal_i.DRELATORIO.Expressao.Conteudo);
      TabGlobal_i.DRELATORIO.Next;
    end;
  end;
  Atribui := ListaCamposRel.Items.Count = 0;

  QueryP := TIBQuery.Create(Self);
  QueryP2:= TIBQuery.Create(Self);
  QueryP.Database := TabGlobal_i.DTABELAS.DataBase;
  if Tipo = 1 then
    QueryP.Sql.Text := 'Select Nome, Titulo_T, Numero From Tabelas Where Numero = '+NrTabela+ ' Order By Nome'
  else if Tipo = 2 then
    QueryP.Sql.Text := 'Select Nome, Titulo_T, Numero From Tabelas Order By Nome';
  QueryP.Open;
  QueryP.First;
  while not QueryP.Eof do
  begin
    if Trim(QueryP.Fields[0].AsString) <> '' then
    begin
      QueryP2.Sql.Text := 'Select Sequencia, Nome, Calculado From Campost where numero = '+IntToStr(QueryP.Fields[2].AsInteger)+' order by numero, sequencia';
      QueryP2.Database := TabGlobal_i.DCAMPOST.DataBase;
      QueryP2.Open;
      QueryP2.First;
      Incluir := True;
      Incluir2 := True;
      while not QueryP2.Eof do
      begin
        if QueryP2.Fields[2].AsInteger <> 1 then
        begin
          if (Tipo = 1) and (Atribui) then
            ListaCamposRel.Items.Add(QueryP.Fields[0].AsString+'.'+LowerCase(QueryP2.Fields[1].AsString))
          else if Tipo = 2 then
          begin
            if ListaCamposRel.Items.IndexOf(QueryP.Fields[0].AsString+'.'+LowerCase(QueryP2.Fields[1].AsString)) < 0 then
            begin
              if Incluir then
              begin
                 NodeM := ListaCamposTab.Items.Add(Nil, QueryP.Fields[0].AsString);
                 ListaGeralCampos.Add(QueryP.Fields[0].AsString);
                 Incluir := False;
              end;
              ListaCamposTab.Items.AddChild(NodeM,LowerCase(QueryP2.Fields[1].AsString));
              ListaGeralCampos.Add(QueryP.Fields[0].AsString + '.' + LowerCase(QueryP2.Fields[1].AsString));
            end;
            if Incluir2 then
            begin
               NodeM2 := ListaCamposTab2.Items.Add(Nil, QueryP.Fields[0].AsString);
               ListaGeralCampos2.Add(QueryP.Fields[0].AsString);
               Incluir2 := False;
            end;
            ListaCamposTab2.Items.AddChild(NodeM2,LowerCase(QueryP2.Fields[1].AsString));
            ListaGeralCampos2.Add(QueryP.Fields[0].AsString + '.' + LowerCase(QueryP2.Fields[1].AsString));
          end;
        end;
        QueryP2.Next;
      end;
      QueryP2.Close;
    end;
    QueryP.Next;
  end;
  QueryP.Close;
  QueryP.Free;
  QueryP2.Free;
  ListaCamposRel2.Items := ListaCamposRel.Items;
  ListaCamposRel3.Items := ListaCamposRel.Items;
  ListaCamposRel4.Items := ListaCamposRel.Items;
end;

procedure TFormRelatorio_Ant.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelatorio_Ant.ListaCamposTabDblClick(Sender: TObject);
begin
  if ListaCamposTab.Selected = nil then
  begin
    Mensagem('Campo não selecionado !',ModAdvertencia, [ModOk]);
    exit;
  end;
  if ListaCamposTab.Selected.Level = 0 then
    exit;
  ListaCamposRel.Items.Add(ListaGeralCampos[ListaCamposTab.Selected.AbsoluteIndex]);
  ListaGeralCampos.Delete(ListaCamposTab.Selected.AbsoluteIndex);
  ListaCamposTab.Selected.Delete;
  ListaCamposRel.ItemIndex := ListaCamposRel.Items.Count - 1;
  ListaCamposRel2.Items := ListaCamposRel.Items;
  ListaCamposRel3.Items := ListaCamposRel.Items;
  ListaCamposRel4.Items := ListaCamposRel.Items;
  Modificou := True;
end;

procedure TFormRelatorio_Ant.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Modificou then
    if Mensagem('Salvar Relatório ?',ModConfirmacao,[ModSim,ModNao]) = mrYes then
      if not Salvar then
      begin
        Action := caNone;
        exit;
      end;
  ListaGeralCampos.Free;
  ListaGeralCampos2.Free;
end;

procedure TFormRelatorio_Ant.ListaCamposRelDblClick(Sender: TObject);
var
  I: Integer;
begin
  if ListaCamposRel.ItemIndex < 0 then
    exit;
  I := 0;
  while ListaCamposRel.SelCount > 0 do
  begin
    if ListaCamposRel.Selected[I] then
    begin
      ListaCamposRel.Items.Delete(I);
      Dec(I);
    end;
    Inc(I);
  end;
  AtualizaTabCampos(2);
  Modificou := True;
end;

procedure TFormRelatorio_Ant.BtnPBaixoIndiceClick(Sender: TObject);
Var
  Atual,Proximo: String;
  I: Integer;
begin
  if (ListaCamposRel.ItemIndex > -1) and (ListaCamposRel.Enabled) then
    if ListaCamposRel.ItemIndex + 1 <= ListaCamposRel.Items.Count-1 then
    begin
      Atual   := ListaCamposRel.Items[ListaCamposRel.ItemIndex];
      Proximo := ListaCamposRel.Items[ListaCamposRel.ItemIndex+1];
      ListaCamposRel.Items[ListaCamposRel.ItemIndex]   := Proximo;
      ListaCamposRel.Items[ListaCamposRel.ItemIndex+1] := Atual;
      ListaCamposRel.ItemIndex := ListaCamposRel.ItemIndex+1;
    end;
  ListaCamposRel2.Items := ListaCamposRel.Items;
  ListaCamposRel3.Items := ListaCamposRel.Items;
  ListaCamposRel4.Items := ListaCamposRel.Items;
  Modificou := True;
end;

procedure TFormRelatorio_Ant.BtnPCimaIndiceClick(Sender: TObject);
Var
  Atual, Anterior: String;
  I: Integer;
begin
  if (ListaCamposRel.ItemIndex > -1) and (ListaCamposRel.Enabled) then
    if ListaCamposRel.ItemIndex - 1 >= 0 then
    begin
      Atual    := ListaCamposRel.Items[ListaCamposRel.ItemIndex];
      Anterior := ListaCamposRel.Items[ListaCamposRel.ItemIndex-1];
      ListaCamposRel.Items[ListaCamposRel.ItemIndex]   := Anterior;
      ListaCamposRel.Items[ListaCamposRel.ItemIndex-1] := Atual;
      ListaCamposRel.ItemIndex := ListaCamposRel.ItemIndex-1;
    end;
  ListaCamposRel2.Items := ListaCamposRel.Items;
  ListaCamposRel3.Items := ListaCamposRel.Items;
  ListaCamposRel4.Items := ListaCamposRel.Items;
  Modificou := True;
end;

function FormatIdentifier(Versao: Integer; Value: String): String;
begin
  Value := AnsiUpperCase(RetiraBrancos(Value));
  Result := Value;
end;

function TFormRelatorio_Ant.Existe: Boolean;
var
  Query: TIBSQL;
begin
  Result := QyRelatorio.Active;
  if Result then Exit;
  QyRelatorio.Database.InternalTransaction.StartTransaction;
  Query := TIBSQL.Create(self);
  try
    Query.Database := QyRelatorio.DataBase;
    Query.Transaction := QyRelatorio.Database.InternalTransaction;
    Query.SQL.Text :=
    'Select USER from RDB$RELATIONS where RDB$RELATION_NAME = ' +
    '''' +
    FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, 'QyRelatorio') + '''';
    Query.Prepare;
    Query.ExecQuery;
    Result := not Query.EOF;
  finally
    Query.Free;
    QyRelatorio.Database.InternalTransaction.Commit;
  end;
end;

procedure TFormRelatorio_Ant.DeletaTabela;
var
  Query: TIBSQL;
begin
  //CheckInactive;
  Query := TIBSQL.Create(Self);
  try
    Query.Database := QyRelatorio.Database;
    Query.SQL.Add('drop table ' +
      FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, 'QyRelatorio'));
    Query.Prepare;
    Query.ExecQuery;
  finally
    Query.Free;
  end;
end;

procedure TFormRelatorio_Ant.CriaTabela;
var
  FieldList: string;

  function TipoCampo(Tipo, Tamanho: Integer): TFieldType;
  begin
    case Tipo of
      1:
      Result := ftString;
      2:
        if Tamanho < 5 then
          Result := ftSmallint
        else if Tamanho < 10 then
          Result := ftInteger
        else
          Result := ftFloat;
      3:
        Result := ftFloat;
      4:
        Result := ftDate;
      5:
        Result := ftMemo;
      6:
        Result := ftBlob;
      else
        Result := ftString;
    end;
  end;

  procedure InitFieldsList;
  var
    I, Tipo, Tamanho: Integer;
    NomeC, NomeT: String;
  begin
    for I := 0 to ListaCamposRel.Items.Count-1 do begin
      if (I > 0) then
        FieldList := FieldList + ', ';
      NomeT := ListaCamposRel.Items[I];
      NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
      NomeC := ListaCamposRel.Items[I];
      NomeC := UpperCase(Trim(Copy(NomeC,Pos('.',NomeC)+1,Length(NomeC))));
      Tipo := RetornaTipoCampo(NomeT, NomeC, 1);
      Tamanho := RetornaTipoCampo(NomeT, NomeC, 2);
      begin
        case TipoCampo(Tipo, Tamanho) of
          ftString:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' VARCHAR(' + IntToStr(Tamanho) + ')';
          ftFixedChar:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' CHAR(' + IntToStr(Tamanho) + ')';
          ftBoolean, ftSmallint, ftWord:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' SMALLINT';
          ftInteger:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' INTEGER';
          ftFloat, ftCurrency:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' DOUBLE PRECISION';
          ftTime:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' TIME';
          ftDate, ftDateTime:
            if (TabGlobal_i.DRELATORIO.Versao = 5) then
              FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) + ' DATE'
            else
              FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) + ' TIMESTAMP';
          ftLargeInt:
            if (TabGlobal_i.DRELATORIO.Versao = 5) then
              IBError(ibxeFieldUnsupportedType,[nil])
            else
              FieldList := FieldList +
                FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
                ' Numeric(18, 0)';
          ftBlob, ftMemo:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' BLOB SUB_TYPE 1';
          ftBytes, ftVarBytes, ftGraphic..ftTypedBinary:
            FieldList := FieldList +
              FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, NomeC) +
              ' BLOB SUB_TYPE 0';
          ftUnknown, ftADT, ftArray, ftReference, ftDataSet,
          ftCursor, ftWideString, ftAutoInc:
            IBError(ibxeFieldUnsupportedType,[nil]);
          else
            IBError(ibxeFieldUnsupportedType,[nil]);
        end;
      end;
    end;
  end;

  procedure InternalCreateTable;
  var
    I: Integer;
    Query: TIBSql;
  begin
    if (FieldList = '') then
      IBError(ibxeFieldUnsupportedType,[nil]);
    Query := TIBSql.Create(self);
    try
      Query.Database := TabGlobal_i.DRELATORIO.Database;
      Query.transaction := TabGlobal_i.DRELATORIO.Transaction;
      Query.SQL.Text := 'Create Table ' +
        FormatIdentifier(TabGlobal_i.DRELATORIO.Versao, 'QyRelatorio') +
        ' (' + FieldList;
      Query.SQL.Text := Query.SQL.Text + ')';
      Query.Prepare;
      Query.ExecQuery;
    finally
      Query.Free;
    end;
  end;

begin
  //CheckInactive;
  InitFieldsList;
  if Existe then
    DeletaTabela;
  InternalCreateTable;
end;

procedure TFormRelatorio_Ant.BtnLayoutClick(Sender: TObject);
Var
  I: Integer;
  NomeT, NomeC, Msg: String;
  Tipo, Tamanho: Integer;
begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Abrindo Layout...';
  FormAguarde.Show;
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := ListaCamposRel.Items.Count-1 + 2;
  QyRelatorio.Database    := TabGlobal_i.DRELATORIO.DataBase;
  QyRelatorio.Transaction := TabGlobal_i.DRELATORIO.Transaction;
  QyRelatorio.Sql.Clear;
  for I:=0 to ListaCamposRel.Items.Count-1 do
  begin
    if I = 0 then
      QyRelatorio.Sql.Add('Select ');
    NomeT := ListaCamposRel.Items[I];
    NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
    NomeC := ListaCamposRel.Items[I];
    NomeC := UpperCase(Trim(Copy(NomeC,Pos('.',NomeC)+1,Length(NomeC))));
    Tipo := RetornaTipoCampo(NomeT, NomeC, 1);
    Tamanho := RetornaTipoCampo(NomeT, NomeC, 2);
    if I < ListaCamposRel.Items.Count-1 then
      NomeC := NomeC + ',';
    QyRelatorio.Sql.Add(NomeC);
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  end;
  CriaTabela;
  QyRelatorio.Transaction.CommitRetaining;
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  QyRelatorio.Sql.Add('From QyRelatorio');
  {msg := '';
  for I:=0 to QyRelatorio.SQL.Count-1 do
    msg := msg + QyRelatorio.Sql[I] + ^M;
  showmessage(msg);}
  FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  QyRelatorio.Open;
  {QyRelatorio.Insert;
  for I:=0 to QyRelatorio.FieldCount-1 do
  begin
    case QyRelatorio.Fields[I].DataType of
       ftString:
         QyRelatorio.Fields[I].AsString := ConstStr('X',QyRelatorio.Fields[I].Size);
       ftFixedChar:
         QyRelatorio.Fields[I].AsString := 'X';
       ftSmallint, ftWord:
         QyRelatorio.Fields[I].AsInteger := 1;
       ftInteger:
         QyRelatorio.Fields[I].AsInteger := 1;
       ftFloat, ftCurrency:
         QyRelatorio.Fields[I].AsInteger := 1;
       ftTime:
         QyRelatorio.Fields[I].AsDateTime := Time;
       ftDate, ftDateTime:
         QyRelatorio.Fields[I].AsDateTime := Date;
       ftLargeInt:
         QyRelatorio.Fields[I].AsInteger := 1;
       ftBytes, ftVarBytes, ftGraphic..ftTypedBinary:
         QyRelatorio.Fields[I].AsInteger := 1;
    end;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  end;
  QyRelatorio.Post;}

  Modificou := True;
  FormAguarde.Free;
  if TipoRel = 1 then
    frReport_1.DesignReport
  else if TipoRel = 2 then
    frReport_2.DesignReport
  else if TipoRel = 3 then
    frReport_3.DesignReport;
  QyRelatorio.Close;
end;

procedure TFormRelatorio_Ant.BtnExcluirRClick(Sender: TObject);
begin
  if ListaRelacionamentos.ItemIndex < 0 then
  begin
    Mensagem('Relacionamento não selecionado !',ModAdvertencia, [ModOk]);
    ListaRelacionamentos.SetFocus;
    exit;
  end;
  if Mensagem('Excluir Relacionamento ?',ModConfirmacao,[ModSim, ModNao]) = mrYes then
  begin
    ListaRelacionamentos.Items.Delete(ListaRelacionamentos.ItemIndex);
    Modificou := True;
  end;
end;

procedure TFormRelatorio_Ant.BtnInserirClick(Sender: TObject);
begin
  if ListaCamposRel2.ItemIndex < 0 then
  begin
    Mensagem('Campo do Relatório não selecionado !',ModAdvertencia, [ModOk]);
    ListaCamposRel2.SetFocus;
    exit;
  end;
  if ListaCamposTab2.Selected = Nil then
  begin
    Mensagem('Campo da Tabela não selecionado !',ModAdvertencia, [ModOk]);
    ListaCamposTab2.SetFocus;
    exit;
  end;
  ListaRelacionamentos.Items.Add('('+ListaCamposRel2.Items[ListaCamposRel2.ItemIndex]+' = '+ListaGeralCampos2[ListaCamposTab2.Selected.AbsoluteIndex]+')');
  Modificou := True;
end;

procedure TFormRelatorio_Ant.BtnIndBaixoClick(Sender: TObject);
Var
  Atual,Proximo: String;
  I: Integer;
begin
  if (ListaCampoInd.ItemIndex > -1) and (ListaCampoInd.Enabled) then
    if ListaCampoInd.ItemIndex + 1 <= ListaCampoInd.Items.Count-1 then
    begin
      Atual   := ListaCampoInd.Items[ListaCampoInd.ItemIndex];
      Proximo := ListaCampoInd.Items[ListaCampoInd.ItemIndex+1];
      ListaCampoInd.Items[ListaCampoInd.ItemIndex]   := Proximo;
      ListaCampoInd.Items[ListaCampoInd.ItemIndex+1] := Atual;
      ListaCampoInd.ItemIndex := ListaCampoInd.ItemIndex+1;
      Modificou := True;
    end;
end;

procedure TFormRelatorio_Ant.BtnIndCimaClick(Sender: TObject);
Var
  Atual, Anterior: String;
  I: Integer;
begin
  if (ListaCampoInd.ItemIndex > -1) and (ListaCampoInd.Enabled) then
    if ListaCampoInd.ItemIndex - 1 >= 0 then
    begin
      Atual    := ListaCampoInd.Items[ListaCampoInd.ItemIndex];
      Anterior := ListaCampoInd.Items[ListaCampoInd.ItemIndex-1];
      ListaCampoInd.Items[ListaCampoInd.ItemIndex]   := Anterior;
      ListaCampoInd.Items[ListaCampoInd.ItemIndex-1] := Atual;
      ListaCampoInd.ItemIndex := ListaCampoInd.ItemIndex-1;
      Modificou := True;
    end;
end;

procedure TFormRelatorio_Ant.ListaCamposRel3DblClick(Sender: TObject);
begin
  if ListaCamposRel3.ItemIndex < 0 then
  begin
    Mensagem('Campo do Relatório não selecionado !',ModAdvertencia, [ModOk]);
    ListaCamposRel3.SetFocus;
    exit;
  end;
  if ListaCampoInd.Items.IndexOf(ListaCamposRel3.Items[ListaCamposRel3.ItemIndex]) < 0 then
  begin
    ListaCampoInd.Items.Add(ListaCamposRel3.Items[ListaCamposRel3.ItemIndex]);
    if ListaCamposRel3.ItemIndex + 1 <= ListaCamposRel3.Items.Count-1 then
      ListaCamposRel3.ItemIndex := ListaCamposRel3.ItemIndex + 1;
    Modificou := True;  
  end
  else
    Mensagem('Campo já pertence ao conjunto de ordenação !',ModAdvertencia,[ModOk]);
end;

procedure TFormRelatorio_Ant.ListaCampoIndDblClick(Sender: TObject);
begin
  if ListaCampoInd.ItemIndex < 0 then
    exit;
  ListaCampoInd.Items.Delete(ListaCampoInd.ItemIndex);
  if ListaCampoInd.ItemIndex + 1 <= ListaCampoInd.Items.Count-1 then
    ListaCampoInd.ItemIndex := ListaCampoInd.ItemIndex + 1;
  Modificou := True;  
end;

procedure TFormRelatorio_Ant.BtnExcluirFiltroClick(Sender: TObject);
begin
  if ListaCampoFil.ItemIndex < 0 then
  begin
    Mensagem('Expressão não selecionada !',ModAdvertencia, [ModOk]);
    ListaCampoFil.SetFocus;
    exit;
  end;
  if Mensagem('Excluir Expressão de Filtro ?',ModConfirmacao,[ModSim, ModNao]) = mrYes then
  begin
    ListaCampoFil.Items.Delete(ListaCampoFil.ItemIndex);
    if ListaCampoFil.Items.Count > 0 then
    begin
      if (Copy(ListaCampoFil.Items[0],01,05) = 'AND (') then
         ListaCampoFil.Items[0] := Copy(ListaCampoFil.Items[0],05,Length(ListaCampoFil.Items[0]))
      else if (Copy(ListaCampoFil.Items[0],01,04) = 'OR (') then
         ListaCampoFil.Items[0] := Copy(ListaCampoFil.Items[0],04,Length(ListaCampoFil.Items[0]))
      else if (Copy(ListaCampoFil.Items[0],01,09) = 'AND NOT (') then
         ListaCampoFil.Items[0] := Copy(ListaCampoFil.Items[0],05,Length(ListaCampoFil.Items[0]))
      else if (Copy(ListaCampoFil.Items[0],01,08) = 'OR NOT (') then
         ListaCampoFil.Items[0] := Copy(ListaCampoFil.Items[0],04,Length(ListaCampoFil.Items[0]));
      ListaCampoFil.ItemIndex := 0;
    end;
    Modificou := True;
  end;
end;

function TFormRelatorio_Ant.Retorna_Tit_Masc_Campo(Posicao: Integer; Tipo: Integer): String;
Var
  QueryP: TIBQuery;
  NumeroT: Integer;
  NomeT, NomeC: String;

  function ConverteMascara(Mascara: String; Tipo: Integer): String;
  var
    MascaraCmp: string;
    I: Integer;
  begin
    MascaraCmp := Mascara;
    if MascaraCmp <> '' then
    begin
      for I := 1 to Length(MascaraCmp) do
        case MascaraCmp[I] of
          '9': MascaraCmp[I] := '0';
          'Z': MascaraCmp[I] := '#';
          'X': MascaraCmp[I] := 'C';
          'x': MascaraCmp[I] := 'c';
          'A': MascaraCmp[I] := 'C';
          'a': MascaraCmp[I] := 'c';
          '-': if (Tipo = 2) or (Tipo = 3) then
                 MascaraCmp[I] := '#';
          '.': if (Tipo = 2) or (Tipo = 3) then
                 MascaraCmp[I] := ',';
          ',': if (Tipo = 2) or (Tipo = 3) then
                 MascaraCmp[I] := '.'
        end;
      if UpperCase(MascaraCmp) = ConstStr('C',Length(MascaraCmp)) then
        MascaraCmp := ''
      else
        MascaraCmp := MascaraCmp + ';0; ';
    end;
    ConverteMascara := MascaraCmp;
  end;

begin
  if (Posicao < 0) or (Posicao > ListaCamposRel.Items.Count-1) then
  begin
    Retorna_Tit_Masc_Campo := '';
    exit;
  end;
  NomeT := ListaCamposRel.Items[Posicao];
  NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
  NomeC := ListaCamposRel.Items[Posicao];
  NomeC := UpperCase(Trim(Copy(NomeC,Pos('.',NomeC)+1,Length(NomeC))));
  QueryP := TIBQuery.Create(Self);
  QueryP.Database := TabGlobal_i.DTABELAS.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome From Tabelas Where Nome = '+#39+NomeT+#39;
  QueryP.Open;
  QueryP.First;
  NumeroT := QueryP.Fields[0].AsInteger;
  QueryP.Close;

  QueryP.Database := TabGlobal_i.DCAMPOST.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome, Tipo, Tamanho, Titulo_C, Mascara From CamposT Where Numero = '+IntToStr(NumeroT)+' and Nome = '+#39+NomeC+#39;
  QueryP.Open;
  QueryP.First;
  if Tipo = 1 then
    Retorna_Tit_Masc_Campo := QueryP.Fields[4].AsString
  else if Tipo = 2 then
    Retorna_Tit_Masc_Campo := converteMascara(QueryP.Fields[5].AsString, QueryP.Fields[2].AsInteger);
  QueryP.Close;
  QueryP.Free;
end;

function TFormRelatorio_Ant.RetornaTipoCampo(NomeT, NomeC: String; Tipo: Integer): Integer;
Var
  QueryP: TIBQuery;
  NumeroT: Integer;
begin
  QueryP := TIBQuery.Create(Self);
  QueryP.Database := TabGlobal_i.DTABELAS.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome From Tabelas Where Nome = '+#39+NomeT+#39;
  QueryP.Open;
  QueryP.First;
  NumeroT := QueryP.Fields[0].AsInteger;
  QueryP.Close;

  QueryP.Database := TabGlobal_i.DCAMPOST.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome, Tipo, Tamanho, Calculado From CamposT Where Numero = '+IntToStr(NumeroT)+' and Nome = '+#39+NomeC+#39;
  QueryP.Open;
  QueryP.First;
  if Tipo = 1 then
    RetornaTipoCampo := QueryP.Fields[2].AsInteger
  else if Tipo = 2 then
    RetornaTipoCampo := QueryP.Fields[3].AsInteger
  else if Tipo = 3 then
    RetornaTipoCampo := QueryP.Fields[4].AsInteger;
  QueryP.Close;
  QueryP.Free;
end;

function TFormRelatorio_Ant.RetornaNumeroInterno(NomeT, NomeC: String; Tipo: Integer): Integer;
Var
  QueryP: TIBQuery;
  NumeroT: Integer;
begin
  QueryP := TIBQuery.Create(Self);
  QueryP.Database := TabGlobal_i.DTABELAS.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome From Tabelas Where Nome = '+#39+NomeT+#39;
  QueryP.Open;
  QueryP.First;
  NumeroT := QueryP.Fields[0].AsInteger;
  QueryP.Close;

  QueryP.Database := TabGlobal_i.DCAMPOST.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome, Tipo, Tamanho, Calculado, Sequencia From CamposT Where Numero = '+IntToStr(NumeroT)+' and Nome = '+#39+NomeC+#39;
  QueryP.Open;
  QueryP.First;
  if Tipo = 1 then
    RetornaNumeroInterno := NumeroT
  else if Tipo = 2 then
    RetornaNumeroInterno := QueryP.Fields[5].AsInteger;
  QueryP.Close;
  QueryP.Free;
end;

function TFormRelatorio_Ant.RetornaTituloCampo(NomeT, NomeC: String): String;
Var
  QueryP: TIBQuery;
  NumeroT: Integer;
begin
  QueryP := TIBQuery.Create(Self);
  QueryP.Database := TabGlobal_i.DTABELAS.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome From Tabelas Where Nome = '+#39+NomeT+#39;
  QueryP.Open;
  QueryP.First;
  NumeroT := QueryP.Fields[0].AsInteger;
  QueryP.Close;

  QueryP.Database := TabGlobal_i.DCAMPOST.DataBase;
  QueryP.Sql.Text := 'Select Numero, Nome, Tipo, Tamanho, Titulo_C From CamposT Where Numero = '+IntToStr(NumeroT)+' and Nome = '+#39+NomeC+#39;
  QueryP.Open;
  QueryP.First;
  RetornaTituloCampo := QueryP.Fields[4].AsString;
  QueryP.Close;
  QueryP.Free;
end;

procedure TFormRelatorio_Ant.BtnInserirFiltroClick(Sender: TObject);
Var
  Oper, Delimit_E,Delimit_D, Separador_E, Negacao: String;
  FormatoData: string;
  CmpF: Integer;
  Data: TDateTime;
  NumeroT: Integer;
  NomeT, NomeC: String;
begin
  if ListaCamposRel4.ItemIndex < 0 then
  begin
    Mensagem('Campo do relatório não selecionado !',ModAdvertencia, [ModOk]);
    ListaCamposRel4.SetFocus;
    exit;
  end;
  NomeT := ListaCamposRel4.Items[ListaCamposRel4.ItemIndex];
  NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
  NomeC := ListaCamposRel4.Items[ListaCamposRel4.ItemIndex];
  NomeC := UpperCase(Trim(Copy(NomeC,Pos('.',NomeC)+1,Length(NomeC))));

  CmpF := RetornaTipoCampo(NomeT, NomeC, 1);

  if (CmpF = 5) or (CmpF = 6) then
  begin
    Mensagem('Campo Memo ou Imagem não podem ser filtrados !',ModAdvertencia,[ModOk]);
    ListaCamposRel4.SetFocus;
    exit;
  end;
  if (CmpF <> 1) and (Operacao.ItemIndex = 6) then
  begin
    Mensagem('Operação ''Contém'' é somente válida para campos Alfanuméricos !',ModAdvertencia,[ModOk]);
    ListaCamposRel4.SetFocus;
    exit;
  end;
  if Valorusuario.Checked then
    if CmpF = 1 then
      EdExpressao.Text := '<_vusr_tx_>'  // Texto
    else if CmpF = 2 then
      EdExpressao.Text := '<_vusr_it_>'  // Inteiro
    else if CmpF = 3 then
      EdExpressao.Text := '<_vusr_fr_>'  // Fracionário
    else if CmpF = 4 then
      EdExpressao.Text := '<_vusr_dt_>'; // Data
  Delimit_E := '';
  Delimit_D := '';
  Oper      := '';
  Negacao   := '';
  if (CmpF = 1) or (CmpF = 4) then
  begin
    Delimit_E := #39;
    if (Operacao.ItemIndex <= 1) and (CmpF = 1) then
    begin
      Oper        := ' LIKE ';
      Delimit_E   := #39;
      Delimit_D   := '%'+#39;
    end
    else
      Delimit_D := #39;
  end;
  if Operacao.ItemIndex = 0 then
  begin
    if Trim(Oper) = '' then
      Oper := ' = ';
  end
  else if Operacao.ItemIndex = 1 then
  begin
    if Trim(Oper) = '' then
      Oper := ' <> '
    else
      Negacao := ' Not ';
  end
  else if Operacao.ItemIndex = 2 then
    Oper := ' < '
  else if Operacao.ItemIndex = 3 then
    Oper := ' <= '
  else if Operacao.ItemIndex = 4 then
    Oper := ' > '
  else if Operacao.ItemIndex = 5 then
    Oper := ' >= '
  else if Operacao.ItemIndex = 6 then
  begin
    Oper        := ' LIKE ';
    Delimit_E   := #39+'%';
    Delimit_D   := '%'+#39;
  end
  else if Operacao.ItemIndex = 7 then
  begin
    Oper             := ' IS NULL ';
    Delimit_E        := '';
    Delimit_D        := '';
    EdExpressao.Text := '';
  end;
  if (CmpF = 4) and (Operacao.ItemIndex <> 7) then
  begin
    if not Valorusuario.Checked then
      try
        FormatoData     := ShortDateFormat;
        ShortDateFormat := 'd/m/y';
        Data            := StrToDate(EdExpressao.Text);
        ShortDateFormat := 'mm/dd/yyyy';
        EdExpressao.Text:= DateToStr(Data);
        ShortDateFormat := FormatoData;
      except
        on EConvertError do
        begin
           ShortDateFormat := FormatoData;
           Mensagem('Data inválida !', modAdvertencia, [ModOk]);
           EdExpressao.SelectAll;
           EdExpressao.SetFocus;
           exit;
        end;
      end;
  end;
  Separador_E := Negacao + '(';
  if ListaCampoFil.Items.Count > 0 then
    if Composicao.ItemIndex = 0 then
      Separador_E := 'AND '+ Negacao + '('
    else
      Separador_E := 'OR '+Negacao + '(';
  ListaCampoFil.Items.Add(Separador_E + NomeT + '.' + NomeC + Oper + Delimit_E + EdExpressao.Text + Delimit_D + ')');
  EdExpressao.Text := '';
  ListaCampoFil.ItemIndex := ListaCampoFil.Items.Count-1;
  ListaCamposRel4.SetFocus;
  Modificou := True;
end;

procedure TFormRelatorio_Ant.BtnNegacaoClick(Sender: TObject);
Var
  I: Integer;
begin
  I := ListaCampoFil.ItemIndex;
  if I < 0 then
  begin
    Mensagem('Expressão não selecionada !',ModAdvertencia, [ModOk]);
    ListaCampoFil.SetFocus;
    exit;
  end;
  if I = 0 then
  begin
    if (Copy(ListaCampoFil.Items[0],01,05) = 'NOT (') then
      ListaCampoFil.Items[0] := TrocaString(ListaCampoFil.Items[0],'NOT (','(',[])
    else
      ListaCampoFil.Items[0] := TrocaString(ListaCampoFil.Items[0],'(','NOT (',[]);
  end
  else
  begin
    if (Copy(ListaCampoFil.Items[I],01,05) = 'AND (') then
      ListaCampoFil.Items[I] := TrocaString(ListaCampoFil.Items[I],'AND (','AND NOT (',[])
    else if (Copy(ListaCampoFil.Items[I],01,04) = 'OR (') then
      ListaCampoFil.Items[I] := TrocaString(ListaCampoFil.Items[I],'OR (','OR NOT (',[])
    else if (Copy(ListaCampoFil.Items[I],01,09) = 'AND NOT (') then
      ListaCampoFil.Items[I] := TrocaString(ListaCampoFil.Items[I],'AND NOT (','AND (',[])
    else if (Copy(ListaCampoFil.Items[I],01,08) = 'OR NOT (') then
      ListaCampoFil.Items[I] := TrocaString(ListaCampoFil.Items[I],'OR NOT (','OR (',[]);
  end;
  Modificou := True;
end;

procedure TFormRelatorio_Ant.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormRelatorio_Ant.ValorusuarioExit(Sender: TObject);
begin
  if ActiveControl = BtnInserirFiltro then
    exit;
  if Valorusuario.Checked then
  begin
    EdExpressao.Color := clBtnFace;
    EdExpressao.Enabled := False;
    Composicao.SetFocus;
  end
  else
  begin
    EdExpressao.Color := clWindow;
    EdExpressao.Enabled := True;
    EdExpressao.SelectAll;
    EdExpressao.SetFocus;
  end;
end;

function TFormRelatorio_Ant.Salvar: Boolean;
Var
  QueryP: TIBQuery;
  I: Integer;
  FileRel: String;
begin
  Salvar := True;
  FileRel := Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp';
  if TipoRel = 1 then
    frReport_1.SaveToFile(FileRel)
  else if TipoRel = 2 then
    frReport_2.SaveToFile(FileRel)
  else if TipoRel = 3 then
    frReport_3.SaveToFile(FileRel);
  if not FileExists(FileRel) then
  begin
    Mensagem('Não foi possível salvar Layout do Relatório !!!',ModErro,[ModOk]);
    Salvar := False;
    exit;
  end;

  QueryP := TIBQuery.Create(Self);
  // Exclusão em Cascata Tabela: DRELATORIO
  QueryP.DataBase := TabGlobal_i.DRELATORIO.DataBase;
  QueryP.Transaction := TabGlobal_i.DRELATORIO.Transaction;
  QueryP.Sql.Clear;
  QueryP.Sql.Add('Delete From RELATORIO');
  QueryP.Sql.Add('       Where ');
  QueryP.Sql.Add('(NUMERO = '+IntToStr(NrFormulario) +')');
  QueryP.ExecSql;
  QueryP.Close;
  QueryP.Free;

  TabGlobal_i.DRELATORIO.Inclui(Nil);
  TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
  TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 5;
  TabGlobal_i.DRELATORIO.Sequencia.Conteudo := 1;
  TabGlobal_i.DRELATORIO.Expressao.Conteudo := 'Layout';
  TBlobField(TabGlobal_i.DRELATORIO.FieldByName('ESPELHO_1')).LoadFromFile(FileRel);
  TabGlobal_i.DRELATORIO.Salva;
  DeleteFile(FileRel);

  for I:=0 to ListaCamposRel.Items.Count-1 do       // Campos
  begin
    TabGlobal_i.DRELATORIO.Inclui(Nil);
    TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
    TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 1;
    TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I + 1;
    TabGlobal_i.DRELATORIO.Expressao.Conteudo := ListaCamposRel.Items[I];
    TabGlobal_i.DRELATORIO.Salva;
  end;

  for I:=0 to ListaRelacionamentos.Items.Count-1 do  // Relacionamentos
  begin
    TabGlobal_i.DRELATORIO.Inclui(Nil);
    TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
    TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 2;
    TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I + 1;
    TabGlobal_i.DRELATORIO.Expressao.Conteudo := ListaRelacionamentos.Items[I];
    TabGlobal_i.DRELATORIO.Salva;
  end;

  for I:=0 to ListaCampoFil.Items.Count-1 do  // Filtragem
  begin
    TabGlobal_i.DRELATORIO.Inclui(Nil);
    TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
    TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 3;
    TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I + 1;
    TabGlobal_i.DRELATORIO.Expressao.Conteudo := ListaCampoFil.Items[I];
    TabGlobal_i.DRELATORIO.Salva;
  end;

  for I:=0 to ListaCampoInd.Items.Count-1 do  // Ordenação
  begin
    TabGlobal_i.DRELATORIO.Inclui(Nil);
    TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
    TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 4;
    TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I + 1;
    TabGlobal_i.DRELATORIO.Expressao.Conteudo := ListaCampoInd.Items[I];
    TabGlobal_i.DRELATORIO.Salva;
  end;
  GeraRel;
  Modificou := False;
end;

procedure TFormRelatorio_Ant.GeraRel;
var
  FilePas, FileDfm, Tmp_FilePas, Tmp_FileDfm, ExpFiltro: String;
  I,Y,NrC,Tamanho_c: Integer;
  Bloco, Inicio, Inseriu_F, ComIF: Boolean;
  CompStr,CompDfm,NomeT,NomeC: String;
  TabUsadas: TStringList;
  Complemento: String;
  Tipo: Integer;
begin
  TabUsadas := TStringList.Create;
  FilePas := Projeto.Pasta + NomeForm + '.Pas';
  FileDfm := Projeto.Pasta + NomeForm + '.Dfm';
  Tmp_FilePas := Projeto.Pasta + 'Copia\' + NomeForm + '.Pas';
  Tmp_FileDfm := Projeto.Pasta + 'Copia\' + NomeForm + '.Dfm';
  ForceDirectories(Projeto.Pasta+'Copia');
  ChDir(Projeto.Pasta);
  if FileExists(FilePas) then
    CopiaArquivo(FilePas, Tmp_FilePas);
  if FileExists(FileDfm) then
    CopiaArquivo(FileDfm, Tmp_FileDfm);
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.texto.Lines.LoadFromFile(FilePas);
  Bloco  := False;
  Inicio := True;
  for I := 0 to FormPrincipal.texto.Lines.Count-1 do
  begin
    if Pos('{01-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      NrC := 0;
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y:=0 to ListaCampoFil.Items.Count-1 do
      begin
        if Pos('<_vusr_tx_>',ListaCampoFil.Items[Y]) > 0 then
        begin
          inc(NrC);
          FormPrincipal.texto2.Lines.Add('    lb_vusr_'+IntToStr(NrC)+': TLabel;');
          FormPrincipal.texto2.Lines.Add('    vusr_'+IntToStr(NrC)+': TXEdit;');
        end;
        if Pos('<_vusr_it_>',ListaCampoFil.Items[Y]) > 0 then
        begin
          inc(NrC);
          FormPrincipal.texto2.Lines.Add('    lb_vusr_'+IntToStr(NrC)+': TLabel;');
          FormPrincipal.texto2.Lines.Add('    vusr_'+IntToStr(NrC)+': TXNumEdit;');
        end;
        if Pos('<_vusr_fr_>',ListaCampoFil.Items[Y]) > 0 then
        begin
          inc(NrC);
          FormPrincipal.texto2.Lines.Add('    lb_vusr_'+IntToStr(NrC)+': TLabel;');
          FormPrincipal.texto2.Lines.Add('    vusr_'+IntToStr(NrC)+': TXNumEdit;');
        end;
        if Pos('<_vusr_dt_>',ListaCampoFil.Items[Y]) > 0 then
        begin
          inc(NrC);
          FormPrincipal.texto2.Lines.Add('    lb_vusr_'+IntToStr(NrC)+': TLabel;');
          FormPrincipal.texto2.Lines.Add('    vusr_'+IntToStr(NrC)+': TXDateEdit;');
        end;
      end;
      Bloco := True;
    End;
    if Pos('{04-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      Inseriu_F := False;
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      FormPrincipal.texto2.Lines.Add('    DataBase := TabGlobal.D'+NomeTab+'.DataBase;');
      FormPrincipal.texto2.Lines.Add('    Transaction := TabGlobal.D'+NomeTab+'.Transaction;');
      FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'Select'+#39+');');
      TabUsadas.Clear;
      TabUsadas.Add(UpperCase(NomeTab));
      for Y:=0 to ListaCamposRel.Items.Count-1 do
      begin
        if Y < ListaCamposRel.Items.Count-1 then
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaCamposRel.Items[Y]+','+#39+');')
        else
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaCamposRel.Items[Y]+#39+');');
        NomeT := ListaCamposRel.Items[Y];
        NomeT := UpperCase(Copy(NomeT,01,Pos('.',NomeT)-1));
        if TabUsadas.IndexOf(NomeT) < 0 then
          TabUsadas.Add(NomeT);
      end;
      FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'From '+#39+');');
      for Y:=0 to TabUsadas.Count-1 do
        if Y < TabUsadas.Count-1 then
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+TabUsadas[Y]+','+#39+');')
        else
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+TabUsadas[Y]+#39+');');
      if ListaRelacionamentos.Items.Count > 0 then
      begin
        FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'Where'+#39+');');
        Inseriu_F := True;
      end;
      for Y:=0 to ListaRelacionamentos.Items.Count-1 do
        if Y < ListaRelacionamentos.Items.Count-1 then
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaRelacionamentos.Items[Y]+' AND '+#39+');')
        else
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaRelacionamentos.Items[Y]+#39+');');
          //if ListaCampoFil.Items.Count > 0 then
          //  FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaRelacionamentos.Items[Y]+' AND '+#39+');')
          //else
          //  FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaRelacionamentos.Items[Y]+#39+');');
      if (ListaCampoFil.Items.Count > 0) and (not Inseriu_F) then
      begin
        FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'Where'+#39+');');
        Inseriu_F := True;
      end;
      NrC := 0;
      for Y:=0 to ListaCampoFil.Items.Count-1 do
      begin
        ExpFiltro := ListaCampoFil.Items[Y];
        if (Y = 0) and (ListaRelacionamentos.Items.Count > 0) then
          ExpFiltro := 'AND '+ExpFiltro;
        ComIf := False;
        if Pos('<_vusr_tx_>',ExpFiltro) > 0 then
        begin
          inc(NrC);
          ExpFiltro := TrocaString(ExpFiltro,'<_vusr_tx_>','+#39+vusr_'+IntToStr(NrC)+'.Text+#39+',[rfReplaceAll]);
          FormPrincipal.texto2.Lines.Add('    if Trim(vusr_'+IntToStr(NrC)+'.Text) <> '+#39+#39+' then');
          ComIf := True;
        end;
        if Pos('<_vusr_it_>',ExpFiltro) > 0 then
        begin
          inc(NrC);
          ExpFiltro := TrocaString(ExpFiltro,'<_vusr_it_>',#39+'+FloatToStr(vusr_'+IntToStr(NrC)+'.Value)+'+#39,[rfReplaceAll]);
          FormPrincipal.texto2.Lines.Add('    if vusr_'+IntToStr(NrC)+'.Value <> 0 then');
          ComIf := True;
        end;
        if Pos('<_vusr_fr_>',ExpFiltro) > 0 then
        begin
          inc(NrC);
          ExpFiltro := TrocaString(ExpFiltro,'<_vusr_fr_>',#39+'+TrocaString(FloatToStr(vusr_'+IntToStr(NrC)+'.Value),'+#39+','+#39+','+#39+'.'+#39+',[])+'+#39,[rfReplaceAll]);
          FormPrincipal.texto2.Lines.Add('    if vusr_'+IntToStr(NrC)+'.Value <> 0 then');
          ComIf := True;
        end;
        if Pos('<_vusr_dt_>',ExpFiltro) > 0 then
        begin
          inc(NrC);
          ExpFiltro := TrocaString(ExpFiltro,'<_vusr_dt_>','+#39+DataSql(StrToDate(vusr_'+IntToStr(NrC)+'.Text))+#39+',[rfReplaceAll]);
          FormPrincipal.texto2.Lines.Add('    if Copy(vusr_'+IntToStr(NrC)+'.DateText,01,08) <> '+#39+'00/00/00'+#39+' then');
          ComIf := True;
        end;
        if Pos('+#39+%',ExpFiltro) > 0 then  // Resolve o problema da versão 1.2
          ExpFiltro := TrocaString(ExpFiltro,'+#39+%','+'+#39+'%'+#39+'+#39+',[rfReplaceAll]);
        if Pos(#39+'%+#39+',ExpFiltro) > 0 then
          ExpFiltro := TrocaString(ExpFiltro,#39+'%+#39+',#39+'+#39+'+#39+'%'+#39+'+',[rfReplaceAll]);
        if Pos('LIKE '+#39+'%',ExpFiltro) > 0 then
          ExpFiltro := TrocaString(ExpFiltro,'LIKE '+#39+'%','LIKE '+#39+'+#39+'+#39+'%',[rfReplaceAll]);
        if Pos('%'+#39+')',ExpFiltro) > 0 then
        begin
          ExpFiltro := TrocaString(ExpFiltro,'%'+#39+')','%'+#39+'+#39+'+#39+')',[rfReplaceAll]);
          if ContaOcorrencia('%',ExpFiltro) = 1 then
            if Pos('LIKE '+#39,ExpFiltro) > 0 then
              ExpFiltro := TrocaString(ExpFiltro,'LIKE '+#39,'LIKE '+#39+'+#39+'+#39,[rfReplaceAll]);
        end;
        if ComIf then
          FormPrincipal.texto2.Lines.Add('      SQL.Add('+#39+'  '+ExpFiltro+#39+');')
        else
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ExpFiltro+#39+');');
        //if Y < ListaCampoFil.Items.Count-1 then
        //  FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ExpFiltro+#39+');')
        //else
        //  FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ExpFiltro+#39+');');
      end;
      if ListaCampoInd.Items.Count > 0 then
        FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'Order By'+#39+');');
      for Y:=0 to ListaCampoInd.Items.Count-1 do
        if Y < ListaCampoInd.Items.Count-1 then
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaCampoInd.Items[Y]+','+#39+');')
        else
          FormPrincipal.texto2.Lines.Add('    SQL.Add('+#39+'  '+ListaCampoInd.Items[Y]+#39+');');
      Bloco := True;
    end;
    if Pos('{07-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y := 0 to ListaCamposRel.Items.Count-1 do
      begin
        NomeT := ListaCamposRel.Items[Y];
        NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
        NomeC := ListaCamposRel.Items[Y];
        NomeC := UpperCase(Trim(Copy(NomeC,Pos('.',NomeC)+1,Length(NomeC))));
        Tipo := RetornaTipoCampo(NomeT, NomeC, 3);
        if Tipo = 1 then
        begin
          TabGlobal_i.DCAMPOST.Filtro := 'Numero = '+IntToStr(RetornaNumeroInterno(NomeT,NomeC,1))+' AND SEQUENCIA = '+IntToStr(RetornaNumeroInterno(NomeT,NomeC,2));
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) then
            FormPrincipal.texto2.Lines.Add('  QyRelatorio.FieldByName('+#39+NomeC+#39+').AsVariant := CalculaD'+NomeT+'_'+NomeC+'(Self);');
          TabGlobal_i.DCAMPOST.Filtro := '';
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
        end;
      end;
      Bloco := True;
    end;
    if Pos('{99-Final',FormPrincipal.texto.Lines[I]) > 0 then
      Bloco := False;
    if Not Bloco then
    begin
      if inicio then
        FormPrincipal.texto2.Lines[0] := FormPrincipal.texto.Lines[I]
      else
        FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      Inicio := False;
    end;
  end;
  FormPrincipal.texto2.Lines.SaveToFile(FilePas);

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  Bloco  := False;
  Inicio := True;
  FormPrincipal.texto.Lines.LoadFromFile(FileDfm);
  for I := 0 to FormPrincipal.texto.Lines.Count-1 do
  begin
    if Pos('object Selecao_1: TScrollBox',FormPrincipal.texto.Lines[I]) > 0 then
    begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      FormPrincipal.texto2.Lines.Add('    Left = 0');
      FormPrincipal.texto2.Lines.Add('    Top = 20');
      FormPrincipal.texto2.Lines.Add('    Width = 457');
      FormPrincipal.texto2.Lines.Add('    Height = 233');
      FormPrincipal.texto2.Lines.Add('    Align = alClient');
      FormPrincipal.texto2.Lines.Add('    BorderStyle = bsNone');
      FormPrincipal.texto2.Lines.Add('    TabOrder = 0');
      NrC := 0;
      for Y:=0 to ListaCampoFil.Items.Count-1 do
      begin
        if Pos('<_vusr_tx_>',ListaCampoFil.Items[Y]) > 0 then
        begin
          inc(NrC);
          NomeT := Copy(ListaCampoFil.Items[Y],Pos('(',ListaCampoFil.Items[Y])+1,Length(ListaCampoFil.Items[Y]));
          NomeT := Copy(NomeT,01,Pos(' ',NomeT));
          NomeC := Trim(Copy(NomeT,Pos('.',NomeT)+1,Length(NomeT)));
          NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
          Tamanho_C := RetornaTipoCampo(NomeT,NomeC,2);
          if Tamanho_C > 0 then
            Tamanho_C := Tamanho_C * 7 + 14
          else
            Tamanho_C := 121;
          Complemento := '';
          if Pos(' = ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Igual a)'
          else if Pos(' <> ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Diferente de)'
          else if Pos(' < ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Menor que)'
          else if Pos(' <= ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Menor ou Igual que)'
          else if Pos(' > ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Maior que)'
          else if Pos(' >= ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Maior ou igual que)'
          else if Pos(' % ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Que Contém)'
          else if Pos(' ? ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Vazio)';
          FormPrincipal.texto2.Lines.Add('    object lb_vusr_'+IntToStr(NrC)+': TLabel');
          FormPrincipal.texto2.Lines.Add('      Left = 8');
          FormPrincipal.texto2.Lines.Add('      Top = '+IntToStr(24+(40*(NrC-1))-17));
          FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C));
          FormPrincipal.texto2.Lines.Add('      Height = 13');
          FormPrincipal.texto2.Lines.Add('      Caption = '+#39+RetornaTituloCampo(NomeT,NomeC)+Complemento+#39);
          FormPrincipal.texto2.Lines.Add('    end');
          FormPrincipal.texto2.Lines.Add('    object vusr_'+IntToStr(NrC)+': TXEdit');
          FormPrincipal.texto2.Lines.Add('      Left = 8');
          FormPrincipal.texto2.Lines.Add('      Top = '+IntToStr(24+(40*(NrC-1))));
          FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C));
          FormPrincipal.texto2.Lines.Add('      Height = 21');
          FormPrincipal.texto2.Lines.Add('      TabOrder = '+IntToStr(NrC-1));
          FormPrincipal.texto2.Lines.Add('      Text = '+#39+#39);
          FormPrincipal.texto2.Lines.Add('    end');
        end;
        if (Pos('<_vusr_it_>',ListaCampoFil.Items[Y]) > 0) or
           (Pos('<_vusr_fr_>',ListaCampoFil.Items[Y]) > 0) then
        begin
          inc(NrC);
          NomeT := Copy(ListaCampoFil.Items[Y],Pos('(',ListaCampoFil.Items[Y])+1,Length(ListaCampoFil.Items[Y]));
          NomeT := Copy(NomeT,01,Pos(' ',NomeT));
          NomeC := Trim(Copy(NomeT,Pos('.',NomeT)+1,Length(NomeT)));
          NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
          Tamanho_C := RetornaTipoCampo(NomeT,NomeC,2);
          if Tamanho_C > 0 then
            Tamanho_C := Tamanho_C * 7 + 14
          else
            Tamanho_C := 121;
          Complemento := '';
          if Pos(' = ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Igual a)'
          else if Pos(' <> ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Diferente de)'
          else if Pos(' < ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Menor que)'
          else if Pos(' <= ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Menor ou Igual que)'
          else if Pos(' > ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Maior que)'
          else if Pos(' >= ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Maior ou igual que)'
          else if Pos(' % ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Que Contém)'
          else if Pos(' ? ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Vazio)';
          FormPrincipal.texto2.Lines.Add('    object lb_vusr_'+IntToStr(NrC)+': TLabel');
          FormPrincipal.texto2.Lines.Add('      Left = 8');
          FormPrincipal.texto2.Lines.Add('      Top = '+IntToStr(24+(40*(NrC-1))-17));
          FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C));
          FormPrincipal.texto2.Lines.Add('      Height = 13');
          FormPrincipal.texto2.Lines.Add('      Caption = '+#39+RetornaTituloCampo(NomeT,NomeC)+Complemento+#39);
          FormPrincipal.texto2.Lines.Add('    end');
          FormPrincipal.texto2.Lines.Add('    object vusr_'+IntToStr(NrC)+': TXNumEdit');
          FormPrincipal.texto2.Lines.Add('      Left = 8');
          FormPrincipal.texto2.Lines.Add('      Top = '+IntToStr(24+(40*(NrC-1))));
          if (Pos('<_vusr_it_>',ListaCampoFil.Items[Y]) > 0) then
            FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C))
          else
            FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C + 17));
          FormPrincipal.texto2.Lines.Add('      Height = 21');
          if (Pos('<_vusr_it_>',ListaCampoFil.Items[Y]) > 0) then
            FormPrincipal.texto2.Lines.Add('      Decimals = 0');
          if (Pos('<_vusr_it_>',ListaCampoFil.Items[Y]) <= 0) then
            FormPrincipal.texto2.Lines.Add('      ShowButton = True');
          FormPrincipal.texto2.Lines.Add('      Glyph.Data = {');
          FormPrincipal.texto2.Lines.Add('        7E050000424D7E0500000000000036000000280000001A0000000D0000000100');
          FormPrincipal.texto2.Lines.Add('        2000000000004805000000000000000000000000000000000000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C0008040400080404000804040008040400080404000804040008040');
          FormPrincipal.texto2.Lines.Add('        4000804040008040400080404000FFC0C000FFC0C000FFC0C000FFFFFF008080');
          FormPrincipal.texto2.Lines.Add('        8000808080008080800080808000808080008080800080808000808080008080');
          FormPrincipal.texto2.Lines.Add('        8000FFC0C000FFC0C000FFC0C000FFC00000FF406000FF406000FF406000FF40');
          FormPrincipal.texto2.Lines.Add('        6000FF406000FF406000FF406000FF40600080404000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC00000FF406000FFC0');
          FormPrincipal.texto2.Lines.Add('        0000FFFFFF00FFC00000FFFFFF00FFC00000FFFFFF00FF40600080404000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFFFFF0080808000FFFF');
          FormPrincipal.texto2.Lines.Add('        FF0080808000FFFFFF00FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        0000FF406000FF406000FF406000FF406000FF406000FF406000FF406000FF40');
          FormPrincipal.texto2.Lines.Add('        600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C00080808000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC00000FF406000FFC00000FFFFFF00FFC00000FFFFFF00FFC0');
          FormPrincipal.texto2.Lines.Add('        0000FFFFFF00FF40600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0');
          FormPrincipal.texto2.Lines.Add('        C00080808000FFFFFF0080808000FFFFFF0080808000FFFFFF00FFC0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000FFC0C000FFC0C000FFC0C000FFC00000FF406000FF406000FF406000FF40');
          FormPrincipal.texto2.Lines.Add('        6000FF406000FF406000FF406000FF40600080404000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC00000FF4060004000');
          FormPrincipal.texto2.Lines.Add('        0000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FF40600080404000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFFFFF00FFFFFF00FFFF');
          FormPrincipal.texto2.Lines.Add('        FF00FFFFFF00FFFFFF00FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        0000FF40600040000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C000FF40');
          FormPrincipal.texto2.Lines.Add('        600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC00000FF406000400000004000000040000000400000004000');
          FormPrincipal.texto2.Lines.Add('        000040000000FF40600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0');
          FormPrincipal.texto2.Lines.Add('        C000808080008080800080808000808080008080800080808000FFC0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000FFC0C000FFC0C000FFC0C000FFC00000FF406000FF406000FF406000FF40');
          FormPrincipal.texto2.Lines.Add('        6000FF406000FF406000FF406000FF40600080404000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC00000FFC00000FFC0');
          FormPrincipal.texto2.Lines.Add('        0000FFC00000FFC00000FFC00000FFC00000FFC00000FFC0000080404000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF');
          FormPrincipal.texto2.Lines.Add('        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0');
          FormPrincipal.texto2.Lines.Add('        C000}');
          FormPrincipal.texto2.Lines.Add('      TabOrder = '+IntToStr(NrC-1));
          FormPrincipal.texto2.Lines.Add('    end');
        end;
        if Pos('<_vusr_dt_>',ListaCampoFil.Items[Y]) > 0 then
        begin
          inc(NrC);
          NomeT := Copy(ListaCampoFil.Items[Y],Pos('(',ListaCampoFil.Items[Y])+1,Length(ListaCampoFil.Items[Y]));
          NomeT := Copy(NomeT,01,Pos(' ',NomeT));
          NomeC := Trim(Copy(NomeT,Pos('.',NomeT)+1,Length(NomeT)));
          NomeT := Copy(NomeT,01,Pos('.',NomeT)-1);
          Tamanho_C := RetornaTipoCampo(NomeT,NomeC,2);
          if Tamanho_C > 0 then
            Tamanho_C := Tamanho_C * 7 + 14
          else
            Tamanho_C := 121;
          Complemento := '';
          if Pos(' = ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Igual a)'
          else if Pos(' <> ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Diferente de)'
          else if Pos(' < ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Menor que)'
          else if Pos(' <= ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Menor ou Igual que)'
          else if Pos(' > ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Maior que)'
          else if Pos(' >= ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Maior ou igual que)'
          else if Pos(' % ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Que Contém)'
          else if Pos(' ? ',ListaCampoFil.Items[Y]) > 0 then
            Complemento := ' (Vazio)';
          FormPrincipal.texto2.Lines.Add('    object lb_vusr_'+IntToStr(NrC)+': TLabel');
          FormPrincipal.texto2.Lines.Add('      Left = 8');
          FormPrincipal.texto2.Lines.Add('      Top = '+IntToStr(24+(40*(NrC-1))-17));
          FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C));
          FormPrincipal.texto2.Lines.Add('      Height = 13');
          FormPrincipal.texto2.Lines.Add('      Caption = '+#39+RetornaTituloCampo(NomeT,NomeC)+Complemento+#39);
          FormPrincipal.texto2.Lines.Add('    end');
          FormPrincipal.texto2.Lines.Add('    object vusr_'+IntToStr(NrC)+': TXDateEdit');
          FormPrincipal.texto2.Lines.Add('      Left = 8');
          FormPrincipal.texto2.Lines.Add('      Top = '+IntToStr(24+(40*(NrC-1))));
          FormPrincipal.texto2.Lines.Add('      Width = '+IntToStr(Tamanho_C + 17));
          FormPrincipal.texto2.Lines.Add('      Height = 21');
          if TabGlobal_i.DPROJETO.FORMATODATA.Conteudo = 1 then
            FormPrincipal.texto2.Lines.Add('      DateText = '+#39+'00/00/0000'+#39)
          else
          begin
            FormPrincipal.texto2.Lines.Add('      Century = False');
            FormPrincipal.texto2.Lines.Add('      DateText = '+#39+'00/00/00'+#39);
          end;
          FormPrincipal.texto2.Lines.Add('      DateValue = -693594');
          FormPrincipal.texto2.Lines.Add('      ShowButton = True');
          FormPrincipal.texto2.Lines.Add('      Glyph.Data = {');
          FormPrincipal.texto2.Lines.Add('        56060000424D560600000000000036000000280000001C0000000E0000000100');
          FormPrincipal.texto2.Lines.Add('        2000000000002006000000000000000000000000000000000000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000080');
          FormPrincipal.texto2.Lines.Add('        8000008080000080800000808000008080000080800000808000008080000080');
          FormPrincipal.texto2.Lines.Add('        80000080800000808000C0C0C000C0C0C000C0C0C00080808000808080008080');
          FormPrincipal.texto2.Lines.Add('        8000808080008080800080808000808080008080800080808000808080008080');
          FormPrincipal.texto2.Lines.Add('        8000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000000000FFFF');
          FormPrincipal.texto2.Lines.Add('        FF000000000000000000FFFFFF00000000000000000000808000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00080808000FFFFFF008080800080808000FFFFFF00808080008080');
          FormPrincipal.texto2.Lines.Add('        8000FFFFFF00808080008080800080808000C0C0C000C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00000808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000000000FFFF');
          FormPrincipal.texto2.Lines.Add('        FF000000FF000000FF00FFFFFF000000FF000000FF0000808000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00080808000FFFFFF008080800080808000FFFFFF00808080008080');
          FormPrincipal.texto2.Lines.Add('        8000FFFFFF00808080008080800080808000C0C0C000C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00000808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000000000FFFF');
          FormPrincipal.texto2.Lines.Add('        FF000000000000000000FFFFFF00000000000000000000808000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00080808000FFFFFF008080800080808000FFFFFF00808080008080');
          FormPrincipal.texto2.Lines.Add('        8000FFFFFF00808080008080800080808000C0C0C000C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00000808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000C0C0C000C0C0C000C0C0C00080808000FF000000FF000000FF000000FF00');
          FormPrincipal.texto2.Lines.Add('        0000FF000000FF000000FF000000FF000000FF00000000808000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF');
          FormPrincipal.texto2.Lines.Add('        FF00FF00000000808000C0C0C000C0C0C000C0C0C00080808000C0C0C000FFFF');
          FormPrincipal.texto2.Lines.Add('        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000C0C0C000C0C0C000C0C0C00080808000FF000000FF000000FF000000FF00');
          FormPrincipal.texto2.Lines.Add('        0000FF000000FF000000FF000000FF000000FF00000000808000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C0008080');
          FormPrincipal.texto2.Lines.Add('        8000808080008080800080808000808080008080800080808000808080008080');
          FormPrincipal.texto2.Lines.Add('        80008080800000808000C0C0C000C0C0C000C0C0C00080808000808080008080');
          FormPrincipal.texto2.Lines.Add('        8000808080008080800080808000808080008080800080808000808080008080');
          FormPrincipal.texto2.Lines.Add('        8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0');
          FormPrincipal.texto2.Lines.Add('        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}');
          FormPrincipal.texto2.Lines.Add('      TabOrder = '+IntToStr(NrC-1));
          FormPrincipal.texto2.Lines.Add('    end');
        end;
      end;
      Bloco := True;
    end;
    if Pos('object frReport: TfrReport',FormPrincipal.texto.Lines[I]) > 0 then
    begin
      if TipoRel = 1 then
        CompStr := ComponentToString(frReport_1)
      else if TipoRel = 2 then
        CompStr := ComponentToString(frReport_2)
      else if TipoRel = 3 then
        CompStr := ComponentToString(frReport_3);
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      FormPrincipal.texto2.Lines.Add('    Dataset = frDBDataSet');
      FormPrincipal.texto2.Lines.Add('    InitialZoom = pzDefault');
      FormPrincipal.texto2.Lines.Add('    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]');
      FormPrincipal.texto2.Lines.Add('    Left = 1');
      FormPrincipal.texto2.Lines.Add('    Top = 277');
      FormPrincipal.texto2.Lines.Add('    StoreInDFM = True');
      CompDfm := '';
      Inseriu_F := False;
      for Y:=1 to Length(compStr) do
      begin
        if (CompStr[Y] = '{') then
          Inseriu_F := True;
        if Inseriu_F then
          CompDfm := CompDfm + CompStr[Y];
        if CompStr[Y] = '}' then
          Inseriu_F := False;
      end;
      FormPrincipal.texto2.Lines.Add('    ReportForm = '+CompDfm);
      CompDfm := '';
      CompStr := '';
      Bloco := True;
    end;
    if UpperCase(TrimRight(FormPrincipal.texto.Lines[I])) = '  END' then
      Bloco := False;
    if Not Bloco then
      if inicio then
        FormPrincipal.texto2.Lines[0] := FormPrincipal.texto.Lines[I]
      else
        FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      Inicio := False;
  end;
  FormPrincipal.texto2.Lines.SaveToFile(FileDfm);

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
  TabUsadas.Free;
end;

procedure TFormRelatorio_Ant.BtnGravarClick(Sender: TObject);
begin
  if not Salvar then
    exit;
  Close;
end;

procedure TFormRelatorio_Ant.BtnFonteClick(Sender: TObject);
begin
  if Modificou then
    if Mensagem('Salvar Relatório ?',ModConfirmacao,[ModSim,ModNao]) = mrYes then
      Salvar;
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.Divisao.Visible := False;
    FormMiniEditor.ExcluirEvento.Visible := False;
    FormMiniEditor.E_Cabecalho.Visible := False;
    FormMiniEditor.E_Metodo.Lines.Clear;
    FormMiniEditor.E_Metodo.Lines.LoadFromFile(Projeto.Pasta + NomeForm + '.Pas');
    FormMiniEditor.E_Metodo.Modified := False;
    FormMiniEditor.Posicao_Y := Posicao_Unit;
    if FormMiniEditor.ShowModal = mrOk then
    begin
      FormMiniEditor.E_Metodo.Lines.SaveToFile(Projeto.Pasta + NomeForm + '.Pas');
    end;
  Finally
    Posicao_Unit := FormMiniEditor.E_Metodo.CaretY;
    FormMiniEditor.Free;
  end;
end;

procedure TFormRelatorio_Ant.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

end.
