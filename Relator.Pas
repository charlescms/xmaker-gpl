unit Relator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ToolWin, FR_Desgn, FR_E_HTM, FR_E_CSV, FR_E_RTF,
  FR_E_TXT, FR_RRect, FR_Chart, FR_BarC, FR_Shape, FR_ChBox, FR_Rich,
  FR_OLE, FR_DSet, FR_Class, ComCtrls, 
  ExtCtrls, IBQuery, Db, IBCustomDataSet, FR_DBSet, IB, IBSQL, FileCtrl, ShellApi,
  DsnUnit, SynEdit, CheckLst, Menus, JvExControls, JvComponent,
  JvArrowButton, Variants;

type
  TFormRelatorio = class(TForm)
    PageControl: TPageControl;
    TabPrincipal: TTabSheet;
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
    Label5: TLabel;
    Ed_TabPrincipal: TEdit;
    Bevel1: TBevel;
    frReport_2: TfrReport;
    frDBDataSet: TfrDBDataSet;
    frReport_3: TfrReport;
    DsnStage0: TDsnStage;
    TextoDFM: TSynEdit;
    PnTabelas: TPanel;
    GridTabela: TCheckListBox;
    PnCampos: TPanel;
    GridCampos: TListBox;
    BtnFiltro: TBitBtn;
    BtnOrdem: TBitBtn;
    BtnLayout: TBitBtn;
    BtnFonte: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    TextoPAS: TSynEdit;
    BitBtn1: TBitBtn;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaCamposRelDblClick(Sender: TObject);
    procedure BtnLayoutClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnFonteClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFiltroClick(Sender: TObject);
    procedure BtnOrdemClick(Sender: TObject);
    procedure GridTabelaClick(Sender: TObject);
    procedure GridTabelaDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure GridTabelaClickCheck(Sender: TObject);
    procedure Tabelas1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    ListaCampoFil, ListaCampoInd, ListaSQL: TStringList;
    Posicao_Unit: Integer;
    SQL_Ativo: Integer;
    SearchOptions: TSynSearchOptions;
    procedure AtualizaTabCampos(Tipo: Integer);
    function Salvar: Boolean;
    function RetornaTipoCampo(NomeT, NomeC: String; Tipo: Integer): Integer;
    function RetornaNumeroInterno(NomeT, NomeC: String; Tipo: Integer): Integer;
    function RetornaTituloCampo(NomeT, NomeC: String): String;
    procedure InicializaVariaveis;
  public
    { Public declarations }
    Modificou: Boolean;
    NrFormulario: Integer;
    NomeForm: String;
    NomeTab: String;
    NrTabela: String;
    TipoRel: Integer;
    function Retorna_Definicao(Tabela, Campo, Tipo: Integer): String;
    procedure GeraRel(Tela: Boolean = False);
  end;

var
  FormRelatorio: TFormRelatorio;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01, Abertura, Aguarde, MiniEditor, Tabela,
  EdFiltro, EdOrdenacao, Form_Rel, Estrutura_Bd, DRELACIONA, EditorSQL;

procedure TFormRelatorio.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFormRelatorio.FormShow(Sender: TObject);
var
  FileRel: String;
  FS , FS2:TStream;
  FinalFluxo: TValueType;
  FinalBloco, InicioBloco: Boolean;
  I,Y : Integer;
  Comp: TComponent;

  procedure CriaDinamicamente;
  begin
    if FileExists(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp') then
      DeleteFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp');
    if FileExists(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt') then
      DeleteFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt');
    FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt');
    try
      FS2 := TFileStream.Create(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp', fmCreate);
      FinalBloco := False;
      FormPrincipal.Texto.Lines.Clear;
      while not FinalBloco do
      begin
        FS := TFileStream.Create(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt', fmOpenRead);
        ObjectTextToBinary(FS, FS2);
        FS.Free;

        FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt');
        InicioBloco := False;
        FormPrincipal.Texto.Lines.Delete(0);
        while not InicioBloco do
        begin
          if (UpperCase(Copy(FormPrincipal.Texto.Lines[0],01,07)) = 'OBJECT ') or (FormPrincipal.Texto.Lines.Count = 0) then
            InicioBloco := True
          else
            FormPrincipal.Texto.Lines.Delete(0);
          end;
          FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt');
          if FormPrincipal.Texto.Lines.Count < 3 then
            FinalBloco := True;
          FormPrincipal.Texto.Lines.Clear;
      end;
    finally
      FinalFluxo := vaNull;
      FS2.Write(FinalFluxo, SizeOf(FinalFluxo));
      FS2.Free;
    end;
    if FileExists(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp') then
      DsnStage0.LoadFromFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp');
    if FileExists(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp') then
      DeleteFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Tmp');
    if FileExists(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt') then
      DeleteFile(Projeto.Pasta + Trim(Ed_Formulario.Text) + '.Txt');
  end;

begin
  Screen.Cursor := crHourGlass;
  try
  Posicao_Unit := 1;
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  Modificou := False;
  PageControl.ActivePageIndex := 0;
  ListaCampoFil := TStringList.Create;
  ListaCampoInd := TStringList.Create;
  ListaSQL := TStringList.Create;

  TextoDFM.Lines.Clear;
  FormPrincipal.Texto.Lines.Clear;

  if FileExists(Projeto.Pasta + NomeForm + '.Dfm') then
    TextoDFM.Lines.LoadFromFile(Projeto.Pasta + NomeForm + '.Dfm');
  TextoDFM.CaretX := 1;
  TextoDFM.CaretY := 1;
  TextoDFM.SearchReplace('object frReport: TfrReport','', SearchOptions);
  Y := TextoDFM.CaretY - 1;
  if Y > 5 then
    FinalBloco := False
  else
    FinalBloco := True;
  while not FinalBloco do
  begin
    if (UpperCase(TrimRight(TextoDFM.Lines[Y])) = '  END') or
       (Y > TextoDFM.Lines.Count) then
    begin
      FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
      FinalBloco := True;
    end
    else
      FormPrincipal.Texto.Lines.Add(Copy(TextoDFM.Lines[Y],03,Length(TextoDFM.Lines[Y])));
    inc(Y);
  end;
  CriaDinamicamente;
  TextoDFM.Lines.Clear;
  FormPrincipal.Texto.Lines.Clear;

  Comp := FindComponent('frReport');
  if Comp <> Nil then
  begin
    if TipoRel = 1 then
      frReport_1 := TFrReport(Comp)
    else if TipoRel = 2 then
      frReport_2 := TFrReport(Comp)
    else if TipoRel = 3 then
      frReport_3 := TFrReport(Comp);
  end;
  TabGlobal_i.DRELATORIO.Filtro := 'Numero = '+IntToStr(NrFormulario);
  TabGlobal_i.DRELATORIO.AtualizaSql;
  TabGlobal_i.DRELATORIO.First;

  AtualizaTabCampos(1);
  GridTabela.ItemIndex := 0;
  AtualizaTabCampos(2);

  while not TabGlobal_i.DRELATORIO.Eof do
  begin
    if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 2 then
    begin
      Y := GridTabela.Items.IndexOf(Trim(TabGlobal_i.DRELATORIO.Expressao.Conteudo));
      if Y > -1 then
        GridTabela.Checked[Y] := True;
    end
    else if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 3 then
      ListaCampoFil.Add(TabGlobal_i.DRELATORIO.Expressao.Conteudo)
    else if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 4 then
      ListaCampoInd.Add(TabGlobal_i.DRELATORIO.Expressao.Conteudo)
    else if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 5 then
    begin
      ListaSQL.AddStrings(TabGlobal_i.DRELATORIO.SQL_P.Conteudo);
      SQL_Ativo := TabGlobal_i.DRELATORIO.SQL_ATIVO.Conteudo;
    end;
    TabGlobal_i.DRELATORIO.Next;
  end;

  TextoDFM.Lines.Clear;
  TextoPAS.Lines.Clear;
  if FileExists(Projeto.Pasta + NomeForm + '.Dfm') then
    TextoDFM.Lines.LoadFromFile(Projeto.Pasta + NomeForm + '.Dfm');
  if FileExists(Projeto.Pasta + NomeForm + '.Pas') then
    TextoPAS.Lines.LoadFromFile(Projeto.Pasta + NomeForm + '.Pas');
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormRelatorio.AtualizaTabCampos(Tipo: Integer);
var
  iNumero: Integer;
  NumeroTabChave: Variant;

  procedure SubDetalhe;
  var
    Tmp_DRELACIONA: TDRELACIONA;
  begin
    Tmp_DRELACIONA := TDRELACIONA.Create(Self);
    Tmp_DRELACIONA.Name := 'tmp_nome_'+IntToStr(iNumero);
    Tmp_DRELACIONA.DataSource.Name := 'ds_tmp_nome_'+IntToStr(iNumero);
    Tmp_DRELACIONA.UpdateSql.Name := 'UpdSql_RELACIONA_'+IntToStr(iNumero);
    try
      Tmp_DRELACIONA.Filtro := 'Numero = '+IntToStr(iNumero);
      Tmp_DRELACIONA.AtualizaSql;
      while not Tmp_DRELACIONA.Eof do
      begin
        if Tmp_DRELACIONA.TIPO.Conteudo = 3 then
        begin
          PTabela(TabGlobal_i.DTABELAS,['UPPER(NOME)'],[UpperCase(Trim(Tmp_DRELACIONA.TAB_ESTRANGEIRA.Conteudo))],['NUMERO'],NumeroTabChave);
          if NumeroTabChave[0] <> Null then
          begin
            iNumero := NumeroTabChave[0];
            GridTabela.Items.AddObject('D'+Trim(Tmp_DRELACIONA.TAB_ESTRANGEIRA.Conteudo),TObject(iNumero));
            SubDetalhe;
          end;
        end;
        Tmp_DRELACIONA.Next;
      end;
    finally
      Tmp_DRELACIONA.Free;
    end;
  end;

begin
  if Tipo = 1 then
  begin
    GridTabela.Items.Clear;
    GridTabela.Items.AddObject('D' + NomeTab,TObject(StrToInt(NrTabela)));
    GridTabela.Checked[0] := True;
    TabGlobal_i.DRELACIONA.Filtro := 'Numero = '+NrTabela;
    TabGlobal_i.DRELACIONA.AtualizaSql;
    while not TabGlobal_i.DRELACIONA.Eof do
    begin
      if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 3 then
      begin
        PTabela(TabGlobal_i.DTABELAS,['UPPER(NOME)'],[UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))],['NUMERO'],NumeroTabChave);
        if NumeroTabChave[0] <> Null then
        begin
          iNumero := NumeroTabChave[0];
          GridTabela.Items.AddObject('D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo),TObject(iNumero));
          SubDetalhe;
        end;
      end;
      TabGlobal_i.DRELACIONA.Next;
    end;
  end
  else
  begin
    if GridTabela.ItemIndex < 0 then
      exit;
    GridCampos.Items.Clear;
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]));
    TabGlobal_i.DCAMPOST.AtualizaSql;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
      begin
        if Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo) = '' then
          GridCampos.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(0))
        else
          GridCampos.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(1));
      end;
      TabGlobal_i.DCAMPOST.Next;
    end;
    if GridCampos.Items.Count > 0 then
      GridCampos.ItemIndex := 0;
  end;
end;

procedure TFormRelatorio.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelatorio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Modificou then
    if Mensagem('Salvar Relatório ?',ModConfirmacao,[ModSim,ModNao]) = mrYes then
      if not Salvar then
      begin
        Action := caNone;
        exit;
      end;
  ListaCampoFil.Free;
  ListaCampoInd.Free;
  ListaSQL.Free;
end;

procedure TFormRelatorio.ListaCamposRelDblClick(Sender: TObject);
var
  I: Integer;
begin
end;

function FormatIdentifier(Versao: Integer; Value: String): String;
begin
  Value := AnsiUpperCase(RetiraBrancos(Value));
  Result := Value;
end;

procedure TFormRelatorio.BtnLayoutClick(Sender: TObject);
begin
  InicializaVariaveis;
  Modificou := True;

  if TipoRel = 1 then
    frReport_1.DesignReport
  else if TipoRel = 2 then
    frReport_2.DesignReport
  else if TipoRel = 3 then
    frReport_3.DesignReport;
end;

function TFormRelatorio.RetornaTipoCampo(NomeT, NomeC: String; Tipo: Integer): Integer;
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

function TFormRelatorio.RetornaNumeroInterno(NomeT, NomeC: String; Tipo: Integer): Integer;
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

function TFormRelatorio.RetornaTituloCampo(NomeT, NomeC: String): String;
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

procedure TFormRelatorio.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

function TFormRelatorio.Salvar: Boolean;
Var
  QueryP: TIBQuery;
  I: Integer;
  FileRel: String;
  FilePas, FileDfm, Tmp_FilePas, Tmp_FileDfm: String;
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
  TBlobField(TabGlobal_i.DRELATORIO.FieldByName('SQL')).AsString := ListaSQL.Text;
  TabGlobal_i.DRELATORIO.SQL_ATIVO.Conteudo := SQL_Ativo;
  TabGlobal_i.DRELATORIO.Salva;
  DeleteFile(FileRel);

  for I:=1 to GridTabela.Items.Count-1 do  // Filhos
  begin
    if GridTabela.Checked[I] then
    begin
      TabGlobal_i.DRELATORIO.Inclui(Nil);
      TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
      TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 2;
      TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I;
      TabGlobal_i.DRELATORIO.Expressao.Conteudo := Trim(GridTabela.Items[I]);
      TabGlobal_i.DRELATORIO.Salva;
    end;
  end;

  for I:=0 to ListaCampoFil.Count-1 do  // Filtragem
  begin
    TabGlobal_i.DRELATORIO.Inclui(Nil);
    TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
    TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 3;
    TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I + 1;
    TabGlobal_i.DRELATORIO.Expressao.Conteudo := ListaCampoFil[I];
    TabGlobal_i.DRELATORIO.Salva;
  end;

  for I:=0 to ListaCampoInd.Count-1 do  // Ordenação
  begin
    TabGlobal_i.DRELATORIO.Inclui(Nil);
    TabGlobal_i.DRELATORIO.Numero.Conteudo    := NrFormulario;
    TabGlobal_i.DRELATORIO.Tipo.Conteudo      := 4;
    TabGlobal_i.DRELATORIO.Sequencia.Conteudo := I + 1;
    TabGlobal_i.DRELATORIO.Expressao.Conteudo := ListaCampoInd[I];
    TabGlobal_i.DRELATORIO.Salva;
  end;

  GeraRel;
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
  TextoDFM.Lines.SaveToFile(Projeto.Pasta + NomeForm + '.Dfm');
  TextoPAS.Lines.SaveToFile(Projeto.Pasta + NomeForm + '.Pas');
  Modificou := False;
end;

procedure TFormRelatorio.GeraRel(Tela: Boolean = False);
var
  FilePas, FileDfm, Tmp_FilePas, Tmp_FileDfm, ExpFiltro: String;
  I,Y,T,W,NrC,Tamanho_c,iNumero: Integer;
  Bloco, Bloco_01, Inicio, Inseriu_F, ComIF, BlocoDB, Script, Crescente: Boolean;
  CompStr,CompDfm,NomeT,NomeC,Nome_Tab_S: String;
  TabUsadas: TStringList;
  Complemento, ChaveInd: String;
  Tipo: Integer;
  Campos_Chave_1, Campos_Chave_2, TabelasExtras: TStringList;
  NomeTabChave: Variant;
  NomeFisico, NomeFisico_2: String;
begin
  TabUsadas := TStringList.Create;
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.texto.Lines.AddStrings(TextoPAS.Lines);
  Bloco  := False;
  Bloco_01 := False;
  Inicio := True;
  for I := 0 to FormPrincipal.texto.Lines.Count-1 do
  begin
    if Pos('{01-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      NrC := 0;
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y:=1 to GridTabela.Items.Count-1 do
        if GridTabela.Checked[Y] then
          FormPrincipal.Texto2.Lines.Add('    frDBDataSet_'+Trim(GridTabela.Items[Y])+': TfrDBDataSet;');
      Bloco := True;
      Bloco_01 := True;
    End;
    if Pos('{02-Início',FormPrincipal.texto.Lines[I]) > 0 then
    begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y:=0 to GridTabela.Items.Count-1 do
        if GridTabela.Checked[Y] then
          FormPrincipal.Texto2.Lines.Add('    '+Trim(GridTabela.Items[Y])+': T'+Trim(GridTabela.Items[Y])+';');
      for Y:=0 to GridTabela.Items.Count-1 do
      begin
        if GridTabela.Checked[Y] then
        begin
          FormPrincipal.Texto2.Lines.Add('    procedure Calculos'+Trim(GridTabela.Items[Y])+'(DataSet: TDataSet);');
          FormPrincipal.Texto2.Lines.Add('    procedure AtualizaDetalhe_'+Trim(GridTabela.Items[Y])+'(Sender: TObject; Field: TField);');
        end;
      end;
      Bloco := True;
      Bloco_01 := False;
    end;
    if Pos('{04-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      ChaveInd := ''; Crescente := True;
      Nome_Tab_S := NomeTab;
      if SQL_Ativo = 1 then
      begin
        FormPrincipal.Texto2.Lines.Add('  for I:=0 to D'+NomeTab+'.Campos.Count-1 do');
        FormPrincipal.Texto2.Lines.Add('    TAtributo(D'+NomeTab+'.Campos[I]).Valor.DataSet := Nil;');
        FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.FiltroExtra.Clear;');
        FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.ChaveIndice := '+#39+#39+';');
        FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.Filtro.Clear;');
        FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.SQLPrincipal.Clear;');
        for Y:=0 to ListaSQL.Count-1 do
        begin
          if Copy(Trim(ListaSQL[Y]),01,02) = '>>' then
            FormPrincipal.Texto2.Lines.Add(' '+Copy(TrimLeft(ListaSQL[Y]), 03, Length(TrimLeft(ListaSQL[Y]))))
          else
            FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.SQLPrincipal.Add('+#39+ListaSQL[Y]+#39');');
        end;
        for Y:=0 to GridTabela.Items.Count-1 do
          if GridTabela.Checked[Y] then
            if Y = 0 then
            begin
              FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.AtualizaSql(False);');
              FormPrincipal.Texto2.Lines.Add('  Parametros('+Trim(GridTabela.Items[Y])+');');
              FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.Open;');
            end;
        FormPrincipal.Texto2.Lines.Add('  frDBDataSet.DataSet := D'+NomeTab+';');
        for Y:=1 to GridTabela.Items.Count-1 do
          if GridTabela.Checked[Y] then
            FormPrincipal.Texto2.Lines.Add('  frDBDataSet_'+Trim(GridTabela.Items[Y])+'.DataSet := '+Trim(GridTabela.Items[Y])+';');
        FormPrincipal.Texto2.Lines.Add('  exit;');
        FormPrincipal.Texto2.Lines.Add('  // SQL Personalizado');
        FormPrincipal.Texto2.Lines.Add('');
      end;
      for Y:=0 to ListaCampoInd.Count-1 do
      begin
        if Copy(ListaCampoInd[Y],01,13) = '//INICIOBLOCO' then
        begin
          if Trim(ChaveInd) <> '' then
          begin
            if Copy(ChaveInd,Length(ChaveInd),01) = ',' then
              ChaveInd := Copy(ChaveInd,01,Length(ChaveInd)-1);
            if not Crescente then
              ChaveInd := ChaveInd + ' DESC';
            FormPrincipal.Texto2.Lines.Add('  D'+Nome_Tab_S+'.ChaveIndice := '+#39+ChaveInd+#39+';');
            ChaveInd := '';
          end;
          Nome_Tab_S := '';
          for T:=0 to GridTabela.Items.count-1 do
            if Integer(GridTabela.Items.Objects[T]) = StrToIntDef(Copy(ListaCampoInd[Y],14,04),0) then
              Nome_Tab_S := Trim(Copy(Trim(GridTabela.Items[T]),02,Length(Trim(GridTabela.Items[T]))));
        end;
        if (Copy(ListaCampoInd[Y],01,13) <> '//INICIOBLOCO') and
           (Copy(ListaCampoInd[Y],01,12) <> '//FINALBLOCO') and
           (Trim(ListaCampoInd[Y]) <> '[s]') and
           (Trim(ListaCampoInd[Y]) <> '[\s]') and
           (Trim(Nome_Tab_S) <> '') then
        begin
          if Trim(ListaCampoInd[Y]) = 'S' then
            Crescente := False
          else
          begin
            if (Trim(ListaCampoInd[Y]) <> 'N') and (Trim(ListaCampoInd[Y]) <> '') then
              ChaveInd := ChaveInd + ListaCampoInd[Y] + ',';
            if (Trim(ListaCampoInd[Y]) = 'N') or (Trim(ListaCampoInd[Y]) = '') then
              Crescente := True;
          end;
        end;
      end;
      if Trim(ChaveInd) <> '' then
      begin
        if Copy(ChaveInd,Length(ChaveInd),01) = ',' then
          ChaveInd := Copy(ChaveInd,01,Length(ChaveInd)-1);
        if not Crescente then
          ChaveInd := ChaveInd + ' DESC';
        FormPrincipal.Texto2.Lines.Add('  D'+Nome_Tab_S+'.ChaveIndice := '+#39+ChaveInd+#39+';');
      end;
      FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.Filtro.Clear;');
      script := False;
      Nome_Tab_S := NomeTab;
      for Y:=0 to ListaCampoFil.Count-1 do
      begin
        if Trim(ListaCampoFil[Y]) = '[s]' then
          script := True;
        if Trim(ListaCampoFil[Y]) = '[\s]' then
          script := False;
        if script then
        begin
          if (Copy(ListaCampoFil[Y],01,13) <> '//INICIOBLOCO') and
             (Copy(ListaCampoFil[Y],01,12) <> '//FINALBLOCO') and
             (Trim(ListaCampoFil[Y]) <> '[s]') and
             (Trim(ListaCampoFil[Y]) <> '[\s]') then
            if Copy(Trim(ListaCampoFil[Y]),01,02) = '>>' then
              FormPrincipal.Texto2.Lines.Add(' '+Copy(TrimLeft(ListaCampoFil[Y]), 03, Length(TrimLeft(ListaCampoFil[Y]))))
            else
              FormPrincipal.Texto2.Lines.Add('  ' + ListaCampoFil[Y]);
        end
        else
        begin
          if Copy(ListaCampoFil[Y],01,13) = '//INICIOBLOCO' then
          begin
            Nome_Tab_S := '';
            for T:=0 to GridTabela.Items.count-1 do
              if Integer(GridTabela.Items.Objects[T]) = StrToIntDef(Copy(ListaCampoFil[Y],14,04),0) then
              begin
                Nome_Tab_S := Trim(Copy(Trim(GridTabela.Items[T]),02,Length(Trim(GridTabela.Items[T]))));
                FormPrincipal.Texto2.Lines.Add('  D'+Nome_Tab_S+'.FiltroFixo.Clear;');
              end;
          end;
          if (Copy(ListaCampoFil[Y],01,13) <> '//INICIOBLOCO') and
             (Copy(ListaCampoFil[Y],01,12) <> '//FINALBLOCO') and
             (Trim(ListaCampoFil[Y]) <> '[s]') and
             (Trim(ListaCampoFil[Y]) <> '[\s]') and
             (Trim(Nome_Tab_S) <> '') then
          begin
            if Trim(ListaCampoFil[Y]) <> '' then
            begin
              if Copy(Trim(ListaCampoFil[Y]),01,02) = '>>' then
                FormPrincipal.Texto2.Lines.Add(' '+Copy(TrimLeft(ListaCampoFil[Y]), 03, Length(TrimLeft(ListaCampoFil[Y]))))
              else
              begin
                if Nome_Tab_S <> NomeTab then
                  FormPrincipal.Texto2.Lines.Add('  D'+Nome_Tab_S+'.FiltroFixo.Add('+#39+ListaCampoFil[Y]+#39+');')
                else
                  FormPrincipal.Texto2.Lines.Add('  D'+Nome_Tab_S+'.Filtro.Add('+#39+ListaCampoFil[Y]+#39+');');
              end;
            end;
          end;
        end;
      end;
      {ChaveInd := '';
      for Y:=1 to ListaCampoInd.Count-1 do
        ChaveInd := ChaveInd + ListaCampoInd[Y] + ',';
      if Copy(ChaveInd,Length(ChaveInd),01) = ',' then
        ChaveInd := Copy(ChaveInd,01,Length(ChaveInd)-1);
      if ListaCampoInd.Count > 0 then
        if (Trim(ListaCampoInd[0]) = 'S') and (Trim(ChaveInd) <> '')then
          ChaveInd := ChaveInd + ' DESC';
      if Trim(ChaveInd) <> '' then
        FormPrincipal.Texto2.Lines.Add('  D'+NomeTab+'.ChaveIndice := '+#39+ChaveInd+#39+';');}
      for Y:=0 to GridTabela.Items.Count-1 do
        if GridTabela.Checked[Y] then
          if Y = 0 then
          begin
            FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.AtualizaSql(False);');
            FormPrincipal.Texto2.Lines.Add('  Parametros('+Trim(GridTabela.Items[Y])+');');
            FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.Open;');
          end;
          //else
          //  FormPrincipal.Texto2.Lines.Add('  '+GridTabela.Items[Y]+'.Abrir;');
      FormPrincipal.Texto2.Lines.Add('  frDBDataSet.DataSet := D'+NomeTab+';');
      for Y:=1 to GridTabela.Items.Count-1 do
        if GridTabela.Checked[Y] then
          FormPrincipal.Texto2.Lines.Add('  frDBDataSet_'+Trim(GridTabela.Items[Y])+'.DataSet := '+Trim(GridTabela.Items[Y])+';');
      Bloco := True;
      Bloco_01 := False;
    end;
    if Pos('{06-Início',FormPrincipal.texto.Lines[I]) > 0 then
    begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y:=0 to GridTabela.Items.Count-1 do
      begin
        if GridTabela.Checked[Y] then
        begin
          FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+' := T'+Trim(GridTabela.Items[Y])+'.Create(Self);');
          FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.OnCalcFields := Calculos'+Trim(GridTabela.Items[Y])+';');
          //if Y = 0 then
          FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.DataSource.OnDataChange := AtualizaDetalhe_'+Trim(GridTabela.Items[Y])+';');
        end;
      end;
      FormPrincipal.Texto2.Lines.Add('  QyRelatorio := D'+NomeTab+';');
      Bloco := True;
      Bloco_01 := False;
    end;
    if Pos('{07-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y:=0 to GridTabela.Items.Count-1 do
      begin
        if GridTabela.Checked[Y] then
          FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[Y])+'.Free;');
      end;
      Bloco := True;
      Bloco_01 := False;
    end;
    if Pos('{08-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      for Y:=0 to GridTabela.Items.Count-1 do
      begin
        if GridTabela.Checked[Y] then
        begin
          FormPrincipal.Texto2.Lines.Add('procedure T'+Trim(Ed_Formulario.Text)+'.Calculos'+Trim(GridTabela.Items[Y])+'(DataSet: TDataSet);');
          FormPrincipal.Texto2.Lines.Add('begin');
          TabGlobal_i.DTABELAS.Filtro := 'Upper(Nome) = '+#39+UpperCase(Trim(Copy(Trim(GridTabela.Items[Y]),02,Length(Trim(GridTabela.Items[Y])))))+#39;
          TabGlobal_i.DTABELAS.AtualizaSql;
          if not TabGlobal_i.DTABELAS.Eof then
          begin
            TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.Numero.Conteudo);
            TabGlobal_i.DCAMPOST.AtualizaSql;
            TabGlobal_i.DCAMPOST.First;
            while not TabGlobal_i.DCAMPOST.Eof do
            begin
              if (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo <> 1) and
                 (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) then
                FormPrincipal.texto2.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'.Conteudo := CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'_Rel'+'(Self);');
              TabGlobal_i.DCAMPOST.Next;
            end;
          end;
          FormPrincipal.Texto2.Lines.Add('end;');
          FormPrincipal.Texto2.Lines.Add('');
        end;
      end;
      for Y:=0 to GridTabela.Items.Count-1 do
      begin
        if GridTabela.Checked[Y] then
        begin
          FormPrincipal.Texto2.Lines.Add('procedure T'+Trim(Ed_Formulario.Text)+'.AtualizaDetalhe_'+Trim(GridTabela.Items[Y])+'(Sender: TObject;');
          FormPrincipal.Texto2.Lines.Add('  Field: TField);');
          FormPrincipal.Texto2.Lines.Add('begin');
          iNumero := Integer(GridTabela.Items.Objects[Y]);
          for W:=1 to GridTabela.Items.Count-1 do
          begin
            if (GridTabela.Checked[W]) then
            begin
              TabGlobal_i.DRELACIONA.Filtro := 'Numero = '+IntToStr(iNumero) + ' AND Upper(Tab_Estrangeira) = '+#39+UpperCase(Trim(Copy(GridTabela.Items[W],02,Length(GridTabela.Items[W]))))+#39;
              TabGlobal_i.DRELACIONA.AtualizaSql;
              if not TabGlobal_i.DRELACIONA.Eof then
              begin
                FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[W])+'.AtribuiFiltroMestre(True, False);');
                FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[W])+'.AtualizaSql(False);');
                FormPrincipal.Texto2.Lines.Add('  Parametros('+Trim(GridTabela.Items[W])+');');
                FormPrincipal.Texto2.Lines.Add('  '+Trim(GridTabela.Items[W])+'.Open;');
                FormPrincipal.Texto2.Lines.Add('');
              end;
            end;
          end;
          FormPrincipal.Texto2.Lines.Add('end;');
          if Y < GridTabela.Items.Count-1 then
            FormPrincipal.Texto2.Lines.Add('');
        end;
      end;
      TabGlobal_i.DRELACIONA.Filtro := '';
      TabGlobal_i.DRELACIONA.AtualizaSql;
      Bloco := True;
      Bloco_01 := False;
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
    end
    else
      if Bloco_01 then
        if (Copy(Trim(FormPrincipal.texto.Lines[I]),01,12) <> 'frDBDataSet_') and
           (Copy(Trim(FormPrincipal.texto.Lines[I]),01,10) <> '{01-Início') then
          FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
  end;
  TextoPAS.Lines.Clear;
  TextoPAS.Lines.AddStrings(FormPrincipal.Texto2.Lines);
  //FormPrincipal.texto2.Lines.SaveToFile(FilePas);

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  Bloco  := False;
  BlocoDB := False;
  Inicio := True;
  FormPrincipal.texto.Lines.AddStrings(TextoDFM.Lines);
  for I := 0 to FormPrincipal.texto.Lines.Count-1 do
  begin
    if Tela then
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
        for Y:=0 to FormDialogo_Rel.Texto_Tela.Lines.Count-1 do
          FormPrincipal.texto2.Lines.Add(FormDialogo_Rel.Texto_Tela.Lines[Y]);
        FormDialogo_Rel.Texto_Tela.Lines.Clear;  
        NrC := 0;
        Bloco := True;
      end;
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
    if Pos('object frDBDataSet_D',FormPrincipal.texto.Lines[I]) > 0 then
    begin
      Bloco := True;
      BlocoDB := True;
    end;
    if UpperCase(TrimRight(FormPrincipal.texto.Lines[I])) = '  END' then
      Bloco := False;
    if Not Bloco then
      if inicio then
        FormPrincipal.texto2.Lines[0] := FormPrincipal.texto.Lines[I]
      else
      begin
        if not BlocoDB then
          FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
        if BlocoDB then
          BlocoDB := False;
      end;
      Inicio := False;
  end;
  FormPrincipal.texto2.Lines.Delete(FormPrincipal.texto2.Lines.Count-1);
  for Y:=1 to GridTabela.Items.Count-1 do
    if GridTabela.Checked[Y] then
    begin
      FormPrincipal.texto2.Lines.Add('  object frDBDataSet_'+Trim(GridTabela.Items[Y])+': TfrDBDataSet');
      FormPrincipal.texto2.Lines.Add('    Left = 33');
      FormPrincipal.texto2.Lines.Add('    Top = 277');
      FormPrincipal.texto2.Lines.Add('  end');
    end;
  FormPrincipal.texto2.Lines.Add('end');
  TextoDFM.Lines.Clear;
  TextoDFM.Lines.AddStrings(FormPrincipal.Texto2.Lines);
  //FormPrincipal.texto2.Lines.SaveToFile(FileDfm);

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
  TabUsadas.Free;
end;

procedure TFormRelatorio.BtnGravarClick(Sender: TObject);
begin
  if not Salvar then
    exit;
  Close;
end;

procedure TFormRelatorio.BtnFonteClick(Sender: TObject);
begin
  GeraRel;
  FormDialogo_Rel := TFormDialogo_Rel.Create(Application);
  Try
    FormDialogo_Rel.NomeForm := NomeForm;
    FormDialogo_Rel.ShowModal;
  Finally
    FormDialogo_Rel.Free;
  end;
  Modificou := True;
end;

procedure TFormRelatorio.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;
end;

procedure TFormRelatorio.InicializaVariaveis;
//var
  //I,J,N: Integer;
  //Lista, L: TStringList;
  //frReport: TfrReport;
  //NomeC, MascaraC: String;
  //Tipo, TamanhoC: Integer;
begin
  frVariables['Titulo']       := TabGlobal_i.DPROJETO.TITULO_P.Conteudo;
  frVariables['Versao']       := TabGlobal_i.DPROJETO.VERSAO_P.Conteudo;
  frVariables['Analista']     := TabGlobal_i.DPROJETO.ANALISTA.Conteudo;
  frVariables['Programador']  := TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo;
  frVariables['Projetista']   := TabGlobal_i.DPROJETO.EMPRESA.Conteudo;
  frVariables['EstiloData']   := '';
  frVariables['SenhaInicial'] := TabGlobal_i.DPROJETO.SENHA.Conteudo;
  frVariables['Pasta']        := Projeto.Pasta;
  frVariables['Usuario']      := 'MASTER';
  frVariables['Senha']        := TabGlobal_i.DPROJETO.SENHA.Conteudo;
  frVariables['Master']       := True;
  frVariables['Grupo']        := '';
  frVariables['NumeroUsr']    := 0;
  frVariables['EmpresaUsr']   := 'Empresa Usuária';
  frVariables['EnderecoUsr']  := 'Endereço';
  frVariables['BairroUsr']    := 'Bairro';
  frVariables['CidadeUsr']    := 'Cidade';
  frVariables['UfUsr']        := 'UF';
  frVariables['CEPUsr']       := 'CEP';
  frVariables['CNPJUsr']      := 'CNPJ';
  frVariables['IEUsr']        := 'IE';
  frVariables['FonesUsr']     := 'Telefone(s)';
  frVariables['LogoUsr']      := '';
  frVariables['Titulo_1']     := Ed_Titulo.Text;
  frVariables['Titulo_2']     := '';


  {if TipoRel = 1 then
    frReport := frReport_1
  else if TipoRel = 2 then
    frReport := frReport_2
  else if TipoRel = 3 then
    frReport := frReport_3;

  Lista := TStringList.Create;
  l := TStringList.Create;

  for I:=0 to frReport.Variables.Count-1 do
  begin
    if Pos('.',frReport.Variables[I]) > 0 then
    begin
      if Trim(UpperCase(Copy(frReport.Variables[I],01,Pos('.',frReport.Variables[I])-1))) <> UpperCase(NomeTab) then
        Lista.Add(frReport.Variables[I]);
    end
    else
      if UpperCase(frReport.Variables[I]) <> UpperCase(NomeTab) then
        Lista.Add(frReport.Variables[I]);
  end;
  frReport.Variables.Assign(Lista);
  with frReport.Values do
    for i := Items.Count-1 downto 0 do
      if frReport.FindVariable(Items[i]) = -1 then
      begin
        Objects[i].Free;
        Items.Delete(i);
      end;
  frReport.GetCategoryList(l);
  n := l.Count;
  for i := 0 to n-1 do
  begin
    frReport.GetVarList(i, l);
    for j := 0 to l.Count-1 do
      with frReport.Values do
      if FindVariable(l[j]) = nil then
        Items[AddValue] := l[j];
  end;
  frReport.Variables.Add(NomeTab);
  for I:=0 to ListaCamposRel.Items.Count-1 do
  begin
    frReport.Variables.Add(' '+ListaCamposRel.Items[I]);
    frReport.Values.Items[frReport.Values.AddValue] := ListaCamposRel.Items[I];
    with frReport.Values.FindVariable(ListaCamposRel.Items[I]) do
    begin
      NomeC := UpperCase(Trim(Copy(ListaCamposRel.Items[I],Pos('.',ListaCamposRel.Items[I])+1,50)));
      Tipo := RetornaTipoCampo(NomeTab,NomeC,1);
      MascaraC := Retorna_Tit_Masc_Campo(I,3);
      TamanhoC := StrToIntDef(Retorna_Tit_Masc_Campo(I,4),0);
      if Trim(MascaraC) <> '' then
        if TrimRight(MascaraC[Length(TrimRight(MascaraC))]) = '*' then
          MascaraC := ConstStr(Copy(TrimRight(MascaraC),Length(TrimRight(MascaraC))-1,01),TamanhoC)
        else
          MascaraC := TrimRight(MascaraC);
      if (Tipo = 1) and (Trim(MascaraC) <> '') then
      begin
        Typ := vtOther;
        OtherKind := 1;
        Field := '[MascTexto([QyRelatorio."'+NomeC+'"], '+#39+MascaraC+#39+')]';
      end
      else
      begin
        Typ := vtDBField;
        DataSet := 'QyRelatorio';
        Field := UpperCase(Trim(Copy(ListaCamposRel.Items[I],Pos('.',ListaCamposRel.Items[I])+1,50)));
        OtherKind := 0;
      end;

      //Typ := vtOther;
      //OtherKind := 1;
      //NomeC := UpperCase(Trim(Copy(ListaCamposRel.Items[I],Pos('.',ListaCamposRel.Items[I])+1,50)));
      //Tipo := RetornaTipoCampo(NomeTab,NomeC,1);
      //MascaraC := Retorna_Tit_Masc_Campo(I,2);
      ////MascaraC := Copy(MascaraC,01,Length(MascaraC)-04);
      //MascaraC1 := Retorna_Tit_Masc_Campo(I,3);
      //if Trim(MascaraC) = '' then
      //  Field := '[QyRelatorio."'+NomeC+'"]'
      //else
      //  case Tipo of
      //    1: Field := '[MascTexto([QyRelatorio."'+NomeC+'"],'+#39+MascaraC+#39+')]';
      //    2..3: Field := '[MascValor([QyRelatorio."'+NomeC+'"],'+#39+MascaraC1+#39+')]';
      //    else
      //      Field := '[QyRelatorio."'+NomeC+'"]';
      //  end;
      //Typ := vtDBField;
      //DataSet := 'QyRelatorio';
      //Field := UpperCase(Trim(Copy(ListaCamposRel.Items[I],Pos('.',ListaCamposRel.Items[I])+1,50)));
      //OtherKind := 0;
    end;
  end;
  Lista.Free;
  L.Free;}
end;

procedure TFormRelatorio.BtnFiltroClick(Sender: TObject);
var
  I: Integer;
  Ok, Bloco, Achou: Boolean;
  Lista_tmp: TStringList;
begin
  if GridTabela.ItemIndex < 0 then
  begin
    Mensagem('Tabela não selecionada !',ModAdvertencia,[ModOk]);
    exit;
  end;
  FormFiltro := TFormFiltro.Create(Application);
  Try
    FormFiltro.ExprMemo.Lines.Clear;
    Ok := False;
    for I:=0 to ListaCampoFil.Count-1 do
    begin
      if GridTabela.ItemIndex = 0 then
      begin
        if Copy(ListaCampoFil[I],01,13) = '//INICIOBLOCO' then
          break
        else
          FormFiltro.ExprMemo.Lines.Add(ListaCampoFil[I]);
      end
      else
      begin
        if Copy(ListaCampoFil[I],01,17) = '//INICIOBLOCO'+StrZero(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),04) then
          Ok := True;
        if ok and (Copy(ListaCampoFil[I],01,12) = '//FINALBLOCO') then
          break
        else
          if Ok then
            if Copy(ListaCampoFil[I],01,13) <> '//INICIOBLOCO' then
              FormFiltro.ExprMemo.Lines.Add(ListaCampoFil[I]);
      end;
    end;
    FormFiltro.TabFiltro := Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]);
    FormFiltro.TabNome := Copy(Trim(GridTabela.Items[GridTabela.ItemIndex]),02,60);
    FormFiltro.AceitaScript := True;
    if FormFiltro.ShowModal = mrOk then
    begin
      //ListaCampoFil.Clear;
      Lista_Tmp := TStringList.Create;
      if GridTabela.ItemIndex = 0 then
      begin
        Lista_Tmp.AddStrings(FormFiltro.ExprMemo.Lines);
        Ok := False;
        for I:=0 to ListaCampoFil.Count-1 do
        begin
          if Copy(ListaCampoFil[I],01,13) = '//INICIOBLOCO' then
            Ok := True;
          if Ok then
            Lista_Tmp.Add(ListaCampoFil[I]);
        end;
      end
      else
      begin
        Ok := False;
        Bloco := False;
        Achou := False;
        for I:=0 to ListaCampoFil.Count-1 do
        begin
          if Copy(ListaCampoFil[I],01,17) = '//INICIOBLOCO'+StrZero(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),04) then
          begin
            Achou := True;
            Ok := True;
            Bloco := True;
          end;
          if Copy(ListaCampoFil[I],01,12) = '//FINALBLOCO' then
            Bloco := False;
          if Ok then
          begin
            Lista_Tmp.Add(ListaCampoFil[I]);
            Lista_Tmp.AddStrings(FormFiltro.ExprMemo.Lines);
            Lista_Tmp.Add('//FINALBLOCO');
            Ok := False;
          end
          else
            if not Bloco then
            begin
              if Lista_Tmp.Count-1 > -1 then
              begin
                if not ((ListaCampoFil[I] = '//FINALBLOCO') and (Lista_Tmp[Lista_Tmp.Count-1] = '//FINALBLOCO')) then
                  Lista_Tmp.Add(ListaCampoFil[I]);
              end
              else
                Lista_Tmp.Add(ListaCampoFil[I]);
            end;
        end;
        if not Achou then
        begin
          //Lista_Tmp.AddStrings(ListaCampoFil);
          Lista_Tmp.Add('//INICIOBLOCO'+StrZero(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),04));
          Lista_Tmp.AddStrings(FormFiltro.ExprMemo.Lines);
          Lista_Tmp.Add('//FINALBLOCO');
        end;
      end;
      ListaCampoFil.Clear;
      ListaCampoFil.AddStrings(Lista_Tmp);
      Modificou := True;
      Lista_Tmp.Free;
    end;
  Finally
    FormFiltro.Free;
  end;
  //Memo1.Lines.Clear;
  //Memo1.Lines.AddStrings(ListaCampoFil);
end;

procedure TFormRelatorio.BtnOrdemClick(Sender: TObject);
var
  I: Integer;
  Ok, Bloco, Achou, Primeira: Boolean;
  Lista_tmp: TStringList;
begin
  FormOrdenacao := TFormOrdenacao.Create(Application);
  Try
    FormOrdenacao.TabFiltro := Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]);
    FormOrdenacao.TabNome := Copy(Trim(GridTabela.Items[GridTabela.ItemIndex]),02,60);
    //FormOrdenacao.TabFiltro := StrToInt(NrTabela);
    //FormOrdenacao.TabNome := NomeTab;
    FormOrdenacao.CamposIndices.Items.Clear;
    Ok := False;
    Primeira := True;
    for I:=0 to ListaCampoInd.Count-1 do
    begin
      if GridTabela.ItemIndex = 0 then
      begin
        if Copy(ListaCampoInd[I],01,13) = '//INICIOBLOCO' then
          break
        else
        begin
          if Primeira then
          begin
            Primeira := False;
            if Trim(ListaCampoInd[I]) = 'S' then
              FormOrdenacao.EdDecrescente.Checked := True
            else
              FormOrdenacao.EdDecrescente.Checked := False;
          end
          else
            FormOrdenacao.CamposIndices.Items.Add(ListaCampoInd[I]);
        end;
      end
      else
      begin
        if Copy(ListaCampoInd[I],01,17) = '//INICIOBLOCO'+StrZero(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),04) then
          Ok := True;
        if ok and (Copy(ListaCampoInd[I],01,12) = '//FINALBLOCO') then
          break
        else
          if Ok then
            if Copy(ListaCampoInd[I],01,13) <> '//INICIOBLOCO' then
            begin
              if Primeira then
              begin
                Primeira := False;
                if Trim(ListaCampoInd[I]) = 'S' then
                  FormOrdenacao.EdDecrescente.Checked := True
                else
                  FormOrdenacao.EdDecrescente.Checked := False;
              end
              else
                FormOrdenacao.CamposIndices.Items.Add(ListaCampoInd[I]);
            end;
      end;
    end;
    if FormOrdenacao.ShowModal = mrOk then
    begin
      Lista_Tmp := TStringList.Create;
      if GridTabela.ItemIndex = 0 then
      begin
        if FormOrdenacao.EdDecrescente.Checked then
          Lista_Tmp.Add('S')
        else
          Lista_Tmp.Add('N');
        Lista_Tmp.AddStrings(FormOrdenacao.CamposIndices.Items);
        Ok := False;
        for I:=0 to ListaCampoInd.Count-1 do
        begin
          if Copy(ListaCampoInd[I],01,13) = '//INICIOBLOCO' then
            Ok := True;
          if Ok then
            Lista_Tmp.Add(ListaCampoInd[I]);
        end;
      end
      else
      begin
        Ok := False;
        Bloco := False;
        Achou := False;
        for I:=0 to ListaCampoInd.Count-1 do
        begin
          if Copy(ListaCampoInd[I],01,17) = '//INICIOBLOCO'+StrZero(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),04) then
          begin
            Achou := True;
            Ok := True;
            Bloco := True;
          end;
          if Copy(ListaCampoInd[I],01,12) = '//FINALBLOCO' then
            Bloco := False;
          if Ok then
          begin
            Lista_Tmp.Add(ListaCampoInd[I]);
            if FormOrdenacao.EdDecrescente.Checked then
              Lista_Tmp.Add('S')
            else
              Lista_Tmp.Add('N');
            Lista_Tmp.AddStrings(FormOrdenacao.CamposIndices.Items);
            Lista_Tmp.Add('//FINALBLOCO');
            Ok := False;
          end
          else
            if not Bloco then
            begin
              if Lista_Tmp.Count-1 > -1 then
              begin
                if not ((ListaCampoInd[I] = '//FINALBLOCO') and (Lista_Tmp[Lista_Tmp.Count-1] = '//FINALBLOCO')) then
                  Lista_Tmp.Add(ListaCampoInd[I]);
              end
              else
                Lista_Tmp.Add(ListaCampoInd[I]);
            end;
        end;
        if not Achou then
        begin
          //Lista_Tmp.AddStrings(ListaCampoFil);
          Lista_Tmp.Add('//INICIOBLOCO'+StrZero(Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),04));
          Lista_Tmp.AddStrings(FormOrdenacao.CamposIndices.Items);
          Lista_Tmp.Add('//FINALBLOCO');
        end;
      end;
      ListaCampoInd.Clear;
      ListaCampoInd.AddStrings(Lista_Tmp);
      Modificou := True;
      Lista_Tmp.Free;
    end;
  Finally
    FormOrdenacao.Free;
  end;
  //Memo1.Lines.Clear;
  //Memo1.Lines.AddStrings(ListaCampoInd);
end;

procedure TFormRelatorio.GridTabelaClick(Sender: TObject);
begin
  AtualizaTabCampos(2);
end;

procedure TFormRelatorio.GridTabelaDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  Image: TImage;
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    if Tag = 1 then
      Image := Image1
    else
    begin
      if Integer(Items.Objects[Index]) = 0 then
        Image := Image2
      else
        Image := Image3;
    end;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

function TFormRelatorio.Retorna_Definicao(Tabela, Campo, Tipo: Integer): String;
var
  Tamanho: Integer;

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
  TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(Integer(GridTabela.Items.Objects[Tabela]));
  TabGlobal_i.DCAMPOST.AtualizaSql;
  while not TabGlobal_i.DCAMPOST.Eof do
  begin
    if UpperCase(Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)) = UpperCase(Trim(GridCampos.Items[Campo])) then
    begin
      case Tipo of
        1: Retorna_Definicao := IntToStr(TabGlobal_i.DCAMPOST.TIPO.Conteudo);
        2: begin
             if TabGlobal_i.DCAMPOST.TAMANHO.Conteudo < Length(TabGlobal_i.DCAMPOST.MASCARA.Conteudo) then
               Tamanho := Length(TabGlobal_i.DCAMPOST.MASCARA.Conteudo)
             else
               Tamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
             if Length(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo) > Tamanho then
               Tamanho := Length(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo);
             Retorna_Definicao := IntToStr(Tamanho);
           end;
        3: Retorna_Definicao := converteMascara(TabGlobal_i.DCAMPOST.MASCARA.Conteudo, TabGlobal_i.DCAMPOST.TIPO.Conteudo);
        4: Retorna_Definicao := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
        5: Retorna_Definicao := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
      end;
      Break;
    end;
    TabGlobal_i.DCAMPOST.Next;
  end;
end;

procedure TFormRelatorio.GridTabelaClickCheck(Sender: TObject);
begin
  if GridTabela.ItemIndex = 0 then
    GridTabela.Checked[0] := True;
  Modificou := True;
end;

procedure TFormRelatorio.Tabelas1Click(Sender: TObject);
var
  Y: Integer;
begin
  FormEstruturas := TFormEstruturas.Create(Application);
  Try
    FormEstruturas.ShowModal;
  Finally
    FormEstruturas.Free;
    AtualizaTabCampos(1);
    GridTabela.ItemIndex := 0;
    AtualizaTabCampos(2);
    TabGlobal_i.DRELATORIO.First;
    while not TabGlobal_i.DRELATORIO.Eof do
    begin
      if TabGlobal_i.DRELATORIO.Tipo.Conteudo = 2 then
      begin
        Y := GridTabela.Items.IndexOf(Trim(TabGlobal_i.DRELATORIO.Expressao.Conteudo));
        if Y > -1 then
          GridTabela.Checked[Y] := True;
      end;
      TabGlobal_i.DRELATORIO.Next;
    end;
  end;
end;

procedure TFormRelatorio.BitBtn1Click(Sender: TObject);
begin
  FormEditorSQL := TFormEditorSQL.Create(Application);
  Try
    if SQL_Ativo = 1 then
      FormEditorSQL.Ativo.Checked := True
    else
      FormEditorSQL.Ativo.Checked := False;
    FormEditorSQL.Posicao_Y := 1;
    FormEditorSQL.E_Metodo.Lines.AddStrings(ListaSQL);
    if FormEditorSQL.ShowModal = mrOk then
    begin
      ListaSQL.Clear;
      ListaSQL.AddStrings(FormEditorSQL.E_Metodo.Lines);
      if FormEditorSQL.Ativo.Checked then
        SQL_Ativo := 1
      else
        SQL_Ativo := 0;
      Modificou := True;
    end;
  Finally
    FormEditorSQL.Free;
  end;
end;

end.
