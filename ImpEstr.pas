unit ImpEstr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBQuery, IBDatabase, Db, IBCustomDataSet, IBTable, DBTables, StdCtrls,
  FileCtrl, SynEdit, Buttons, Grids, ExtCtrls, IniFiles, CheckLst, Menus, SDEngine;

type
  Estrutura_Tab = record
    Campo: String;
    Campo_Fisico: String;
    Tipo: Integer;
    Tipo_Fisico: Integer;
    Tamanho: Integer;
    Chave: Integer;
    Edicao: Integer;
    Mascara: String;
    Titulo_c: String;
    Ajuda: String;
    Padrao: String;
    Validacao: String;
    Validos: String;
    Descricao: String;
    Calculado: Integer;
    Autoincremento: Integer;
    Sempre_atribui: Integer;
    Invisivel: Integer;
    Pre_validacao: String;
    Tipo_pre_validacao: Integer;
    Limpar_campo: Integer;
    Msg_erro: String;
    Tab_estrangeira: String;
    Campo_chave: String;
    Campos_visuais: String;
    Estilo_chave: Integer;
    Filtro_Mestre: String;
    Indice_consulta: Integer;
    Extra: Integer;
    Tab_Extra: String;
    Campo_Extra: String;
    Tab_Pesquisa: String;
    Nao_Virtual: Integer;
    sql_extra: String;
    sem_insert: Integer;
    valida_onexit: Integer;
    sql_extra_insert: String;
    Variaveis: String;
    Codificacao: String;
  end;

type
  Tabelas_DB = record
    Numero: Integer;
    Nome: String;
    Titulo_t: String;
    Base: Integer;
    Filtro_Inicial: String;
    Filtro_Mestre: String;
    Ordem_Inicial: String;
    Ordem_Decrescente: Integer;
    Global: Integer;
    Abrir: Integer;
    Generator: Integer;
    Qtde_Campos: Integer;
    Estrutura: Array[0..200] of Estrutura_Tab;
  end;

type
  TFormImpEstrutura = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BtnExecutar: TSpeedButton;
    BtnLocaliza: TSpeedButton;
    Label4: TLabel;
    LstCampos: TStringGrid;
    BtnImportar: TBitBtn;
    BtnCancelar: TBitBtn;
    Texto: TSynEdit;
    LstTabelas_2: TFileListBox;
    LstTabelas: TCheckListBox;
    EdLocalizacao: TEdit;
    EdBaseName: TEdit;
    Table: TTable;
    IBDatabase: TIBDatabase;
    IBTransaction: TIBTransaction;
    IBQuery: TIBQuery;
    BaseDados: TComboBox;
    Label5: TLabel;
    IBQuery1: TIBQuery;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    Marcartodas1: TMenuItem;
    Desmarcartodas1: TMenuItem;
    IBQuery2: TIBQuery;
    SDDatabase: TSDDatabase;
    SDQuery: TSDQuery;
    OpenDialog: TOpenDialog;
    procedure BtnImportarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnExecutarClick(Sender: TObject);
    procedure BaseDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LstTabelasClick(Sender: TObject);
    procedure BtnLocalizaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstTabelasDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Marcartodas1Click(Sender: TObject);
    procedure Desmarcartodas1Click(Sender: TObject);
  private
    { Private declarations }
    ArqIni: String;
    Tabelas: Array[0..200] of Tabelas_DB;
  public
    { Public declarations }
  end;

var
  FormImpEstrutura: TFormImpEstrutura;
  IniFile : TIniFile;

implementation

{$R *.DFM}

uses Rotinas, Senha, Estrutura_Bd, Abertura, Tabela, Aguarde;

procedure TFormImpEstrutura.BtnImportarClick(Sender: TObject);
var
  I,P,SeqT,Seq: Integer;
  NomeTab, NomeCmp, Temp: String;
  Sequencia: Variant;
begin
  try
  if Mensagem('Importar Estrutura(s) ?',modConfirmacao,[ModSim,ModNao]) = mrNo then
  begin
    LstTabelas.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  for P:=0 to LstTabelas.Items.Count-1 do
  begin
    if LstTabelas.Checked[P] then
    begin
      if FREDT then
      begin
        PTabela(TabGlobal_i.DTABELAS, ['Count(NUMERO)'], '', Sequencia);
        if Sequencia[0] >= 20 then
        begin
          Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente 20 '+^M+'Tabelas.',modAdvertencia,[ModOk]);
          exit;
        end;
      end;
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Importando "'+Tabelas[P].Nome+'" ...';
      FormAguarde.Show;
      Application.ProcessMessages;
      FormAguarde.GaugeProcesso.Min := 0;
      FormAguarde.GaugeProcesso.Max := Tabelas[P].Qtde_Campos;
      FormAguarde.GaugeProcesso.Position := 0;
      try
      NomeTab := Tabelas[P].Nome;
      while not FormEstruturas.ValidaNomeCampo(NomeTab,-1,True) do
        NomeTab := InputBox('Nome Inválido', 'Informe outro nome para a Tabela', NomeTab);
      TabGlobal_i.DBDADOS.First;
      TabGlobal_i.DTABELAS.DisableControls;
      TabGlobal_i.DTABELAS.Filtro := '';
      TabGlobal_i.DTABELAS.ChaveIndice := 'numero';
      TabGlobal_i.DTABELAS.AtualizaSql;
      TabGlobal_i.DTABELAS.Last;
      SeqT := TabGlobal_i.DTABELAS.NUMERO.Conteudo + 1;
      TabGlobal_i.DTABELAS.ChaveIndice := 'nome';
      TabGlobal_i.DTABELAS.AtualizaSql;
      TabGlobal_i.DTABELAS.EnableControls;
      TabGlobal_i.DTABELAS.Inclui(Nil);
      TabGlobal_i.DTABELAS.NUMERO.Conteudo   := SeqT;
      TabGlobal_i.DTABELAS.NOME.Conteudo     := NomeTab;
      TabGlobal_i.DTABELAS.TITULO_T.Conteudo := Tabelas[P].Titulo_T;
      if not PTabela(TabGlobal_i.DBDADOS,['NUMERO'],[Tabelas[P].Base]) then
        TabGlobal_i.DTABELAS.BASE.Conteudo     := TabGlobal_i.DBDADOS.NUMERO.Conteudo
      else
        TabGlobal_i.DTABELAS.BASE.Conteudo     := Tabelas[P].Base;
      TBlobField(TabGlobal_i.DTABELAS.FieldByName('FILTRO_INICIAL')).AsString := Tabelas[P].Filtro_Inicial;
      TBlobField(TabGlobal_i.DTABELAS.FieldByName('FILTRO_MESTRE')).AsString := Tabelas[P].Filtro_Mestre;
      TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo     := Tabelas[P].Ordem_Inicial;
      TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo := Tabelas[P].Ordem_Decrescente;
      TabGlobal_i.DTABELAS.GLOBAL.Conteudo            := Tabelas[P].Global;
      TabGlobal_i.DTABELAS.ABRIR_TABELA.Conteudo      := Tabelas[P].Abrir;
      TabGlobal_i.DTABELAS.USE_GENERATOR.Conteudo     := Tabelas[P].Generator;
      TabGlobal_i.DTABELAS.Salva;
      if BaseDados.ItemIndex = 0 then
      begin
        IBQuery2.Sql.Text := 'Select * From IndicesT Where Numero = '+IntToStr(Tabelas[P].Numero);
        IBQuery2.Open;
        IBQuery2.First;
        Seq := 1;
        while not IBQuery2.Eof do
        begin
          if not PTabela(TabGlobal_i.DINDICEST,['NUMERO','SEQUENCIA'],[SeqT,Seq]) then
          begin
            TabGlobal_i.DINDICEST.Inclui(Nil);
            TabGlobal_i.DINDICEST.NUMERO.Conteudo    := SeqT;
            TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := Seq;
            TabGlobal_i.DINDICEST.CAMPOST.Conteudo   := IBQuery2.FieldByName('CAMPOST').AsString;
            TabGlobal_i.DINDICEST.TITULO_I.Conteudo  := IBQuery2.FieldByName('TITULO_I').AsString;
            TabGlobal_i.DINDICEST.CRESCENTE.Conteudo := IBQuery2.FieldByName('CRESCENTE').AsInteger;
            TabGlobal_i.DINDICEST.Salva;
          end;
          Inc(Seq);
          IBQuery2.Next;
        end;
        IBQuery2.Close;

        IBQuery2.Sql.Text := 'Select * From Relaciona Where Numero = '+IntToStr(Tabelas[P].Numero)+ ' order by sequencia';
        IBQuery2.Open;
        IBQuery2.First;
        Seq := 1;
        while not IBQuery2.Eof do
        begin
          if not PTabela(TabGlobal_i.DRELACIONA,['NUMERO','SEQUENCIA'],[SeqT,Seq]) then
          begin
            TabGlobal_i.DRELACIONA.Inclui(Nil);
            TabGlobal_i.DRELACIONA.NUMERO.Conteudo    := SeqT;
            TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := Seq;
            TabGlobal_i.DRELACIONA.TITULO_I.Conteudo  := IBQuery2.FieldByName('TITULO_I').AsString;
            TabGlobal_i.DRELACIONA.TIPO.Conteudo      := IBQuery2.FieldByName('TIPO').AsInteger;
            TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo := IBQuery2.FieldByName('CAMPOS_CHAVE_1').AsString;
            TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo:= IBQuery2.FieldByName('TAB_ESTRANGEIRA').AsString;
            TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo := IBQuery2.FieldByName('CAMPOS_CHAVE_2').AsString;
            TabGlobal_i.DRELACIONA.CAMPOS_VISUAIS.Conteudo := IBQuery2.FieldByName('CAMPOS_VISUAIS').AsString;
            TabGlobal_i.DRELACIONA.EDICAO_DIRETA.Conteudo  := IBQuery2.FieldByName('EDICAO_DIRETA').AsInteger;
            TabGlobal_i.DRELACIONA.FORMULARIO.Conteudo     := IBQuery2.FieldByName('FORMULARIO').AsString;
            TabGlobal_i.DRELACIONA.ATALHO.Conteudo         := IBQuery2.FieldByName('ATALHO').AsInteger;
            if IBQuery2.FindField('ATIVO') <> Nil then
              TabGlobal_i.DRELACIONA.ATIVO.Conteudo := IBQuery2.FieldByName('ATIVO').AsInteger
            else
              TabGlobal_i.DRELACIONA.ATIVO.Conteudo := 1;
            if IBQuery2.FindField('KEY_SQL') <> Nil then
              TabGlobal_i.DRELACIONA.KEY_SQL.Conteudo := IBQuery2.FieldByName('KEY_SQL').AsInteger
            else
              TabGlobal_i.DRELACIONA.KEY_SQL.Conteudo := 0;
            TabGlobal_i.DRELACIONA.Salva;
          end;
          Inc(Seq);
          IBQuery2.Next;
        end;
        IBQuery2.Close;

        IBQuery2.Sql.Text := 'Select * From Processos Where Numero = '+IntToStr(Tabelas[P].Numero)+ ' order by sequencia';
        IBQuery2.Open;
        IBQuery2.First;
        Seq := 1;
        while not IBQuery2.Eof do
        begin
          if not PTabela(TabGlobal_i.DPROCESSOS,['NUMERO','SEQUENCIA'],[SeqT,Seq]) then
          begin
            TabGlobal_i.DPROCESSOS.Inclui(Nil);
            TabGlobal_i.DPROCESSOS.NUMERO.Conteudo    := SeqT;
            TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := Seq;
            TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo  := IBQuery2.FieldByName('TITULO_I').AsString;
            TabGlobal_i.DPROCESSOS.TIPO.Conteudo      := IBQuery2.FieldByName('TIPO').AsInteger;
            TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo  := IBQuery2.FieldByName('TAB_ALVO').AsString;
            TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo:= IBQuery2.FieldByName('CAMPO_ALVO').AsString;
            TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo  := IBQuery2.FieldByName('CONDICAO').AsString;
            TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo:= IBQuery2.FieldByName('FORMULA_DIRETA').AsString;
            TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo:= IBQuery2.FieldByName('FORMULA_INVERSA').AsString;
            TabGlobal_i.DPROCESSOS.QUANTIDADE.Conteudo:= IBQuery2.FieldByName('QUANTIDADE').AsInteger;
            TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Conteudo:= IBQuery2.FieldByName('CONDICAO_INCLUSAO').AsString;
            TabGlobal_i.DPROCESSOS.CONDICAO_EXCLUSAO.Conteudo:= IBQuery2.FieldByName('CONDICAO_EXCLUSAO').AsString;
            Temp := TBlobField(IBQuery2.FieldByName('CAMPOS_ALVO')).AsString;
            TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_ALVO')).AsString := Temp;
            Temp := TBlobField(IBQuery2.FieldByName('CAMPOS_VALOR')).AsString;
            TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_VALOR')).AsString := Temp;
            if IBQuery2.FindField('ATIVO') <> Nil then
              TabGlobal_i.DPROCESSOS.ATIVO.Conteudo := IBQuery2.FieldByName('ATIVO').AsInteger
            else
              TabGlobal_i.DPROCESSOS.ATIVO.Conteudo := 1;
            if IBQuery2.FindField('AVULSO') <> Nil then
            begin
              Temp := TBlobField(IBQuery2.FieldByName('AVULSO')).AsString;
              TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('AVULSO')).AsString := Temp;
            end;
            if IBQuery2.FindField('AVULSO_VAR') <> Nil then
            begin
              Temp := TBlobField(IBQuery2.FieldByName('AVULSO_VAR')).AsString;
              TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('AVULSO_VAR')).AsString := Temp;
            end;
            TabGlobal_i.DPROCESSOS.Salva;
          end;
          Inc(Seq);
          IBQuery2.Next;
        end;
        IBQuery2.Close;

        IBQuery2.Sql.Text :=
          'Select USER from RDB$RELATIONS where RDB$RELATION_NAME = ' +
          '''' +
          'TRIGGER_I' + '''';
        IBQuery2.Open;
        IBQuery2.First;
        if not IBQuery2.Eof then
        begin
          IBQuery2.Close;
          IBQuery2.Sql.Text := 'Select * From Trigger_I Where Numero = '+IntToStr(Tabelas[P].Numero)+ ' order by sequencia';
          IBQuery2.Open;
          IBQuery2.First;
          Seq := 1;
          while not IBQuery2.Eof do
          begin
            if not PTabela(TabGlobal_i.DTRIGGER,['NUMERO','SEQUENCIA'],[SeqT,Seq]) then
            begin
              TabGlobal_i.DTRIGGER.Inclui(Nil);
              TabGlobal_i.DTRIGGER.NUMERO.Conteudo    := SeqT;
              TabGlobal_i.DTRIGGER.SEQUENCIA.Conteudo := Seq;
              TabGlobal_i.DTRIGGER.ATIVO.Conteudo     := IBQuery2.FieldByName('ATIVO').AsInteger;
              TabGlobal_i.DTRIGGER.NOME.Conteudo      := IBQuery2.FieldByName('NOME').AsString;
              TabGlobal_i.DTRIGGER.INSTANTE_ATIVACAO.Conteudo := IBQuery2.FieldByName('INSTANTE_ATIVACAO').AsInteger;
              TabGlobal_i.DTRIGGER.DISPARAR.Conteudo  := IBQuery2.FieldByName('DISPARAR').AsInteger;
              Temp := TBlobField(IBQuery2.FieldByName('BLOCO_SQL')).AsString;
              TBlobField(TabGlobal_i.DTRIGGER.FieldByName('BLOCO_SQL')).AsString := Temp;
              Temp := TBlobField(IBQuery2.FieldByName('DESCRICAO')).AsString;
              TBlobField(TabGlobal_i.DTRIGGER.FieldByName('DESCRICAO')).AsString := Temp;
              TabGlobal_i.DTRIGGER.Salva;
            end;
            Inc(Seq);
            IBQuery2.Next;
          end;
        end;
        IBQuery2.Close;
      end;
      Seq := 1;
      for I:=0 to Tabelas[P].Qtde_Campos do
        with Tabelas[P].Estrutura[I] do
          if Campo <> '**NAO SUPORTADO**' then
          begin
            FormAguarde.GaugeProcesso.Position := I;
            NomeCmp := Trim(Campo);
            while not FormEstruturas.ValidaNomeCampo(NomeCmp,-1) do
              NomeCmp:= InputBox('Nome Inválido', 'Informe outro nome para o Campo', NomeCmp);
            //NomeCmp := UpperCase(NomeCmp);
            TabGlobal_i.DCAMPOST.Inclui(Nil);
            TabGlobal_i.DCAMPOST.NUMERO.Conteudo    := SeqT;
            TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Seq;
            TabGlobal_i.DCAMPOST.NOME.Conteudo      := NomeCmp;
            TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo := Campo_Fisico;
            TabGlobal_i.DCAMPOST.TIPO.Conteudo      := Tipo;
            TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo := Tipo_Fisico;
            TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := Tamanho;
            TabGlobal_i.DCAMPOST.CHAVE.Conteudo     := Chave;
            TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := Edicao;
            TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := Mascara;
            TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := Titulo_C;
            TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := Ajuda;
            TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := Padrao;
            TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := Validacao;
            TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VALIDOS')).AsString := Validos;
            TBlobField(TabGlobal_i.DCAMPOST.FieldByName('DESCRICAO')).AsString := Descricao;
            TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := Calculado;
            TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo := AutoIncremento;
            TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo := Sempre_Atribui;
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo      := Invisivel;
            TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo  := Pre_Validacao;
            TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := Tipo_Pre_Validacao;
            TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo   := Limpar_Campo;
            TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo       := Msg_Erro;
            TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo:= Tab_Estrangeira;
            TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo    := Campo_Chave;
            TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo := Campos_Visuais;
            TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo   := Estilo_Chave;
            TBlobField(TabGlobal_i.DCAMPOST.FieldByName('FILTRO_MESTRE')).AsString := Filtro_Mestre;
            TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo:= Indice_Consulta;
            TabGlobal_i.DCAMPOST.EXTRA.Conteudo          := Extra;
            TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo      := Tab_Extra;
            TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo    := Campo_Extra;
            TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo   := Tab_Pesquisa;
            TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo    := Nao_Virtual;
            TabGlobal_i.DCAMPOST.SQL_EXTRA.Conteudo      := sql_extra;
            TabGlobal_i.DCAMPOST.SEM_INSERT.Conteudo     := sem_insert;
            TabGlobal_i.DCAMPOST.VALIDA_ONEXIT.Conteudo  := valida_onexit;
            TabGlobal_i.DCAMPOST.SQL_EXTRA.Conteudo      := sql_extra_insert;
            if Calculado = 1 then
            begin
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('VARIAVEIS')).AsString := Variaveis;
              TBlobField(TabGlobal_i.DCAMPOST.FieldByName('CODIFICACAO')).AsString := Codificacao;
            end;
            TabGlobal_i.DCAMPOST.Salva;
            Inc(Seq);
          end;
      finally
        FormAguarde.Free;
      end;
    end;
  end;
  IniFile.WriteString('IMPORTACAO', 'Base', IntToStr(BaseDados.ItemIndex));
  IniFile.WriteString('IMPORTACAO', 'Localizacao', EdLocalizacao.Text);
  IniFile.WriteString('IMPORTACAO', 'BaseName', EdBaseName.Text);
  except
    on Erro: Exception do
    begin
      Mensagem('Erro: '+Erro.Message, modErro, [modOk]);
    end;
  end;
end;

procedure TFormImpEstrutura.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormImpEstrutura.BtnExecutarClick(Sender: TObject);
var
  I,Y: Integer;
begin
  try
  LstTabelas.Items.Clear;
  LstCampos.RowCount := 2;
  LstCampos.FixedRows := 1;
  LstCampos.Cells[0,0] := 'Nome';
  LstCampos.Cells[1,0] := 'Tipo';
  LstCampos.Cells[2,0] := 'Tamanho';
  LstCampos.Cells[3,0] := 'Chave';
  LstCampos.Cells[0,1] := '';
  LstCampos.Cells[1,1] := '';
  LstCampos.Cells[2,1] := '';
  LstCampos.Cells[3,1] := '';
  if BaseDados.ItemIndex < 3 then
    if (EdLocalizacao.Text = '') then
    begin
      Mensagem('Necessário informar a pasta de localização !',modAdvertencia,[modOk]);
      EdLocalizacao.SetFocus;
      exit;
    end;
  if BaseDados.ItemIndex > 2 then
    if (EdBaseName.Text = '') then
    begin
      Mensagem('Necessário informar DataBase !',modAdvertencia,[modOk]);
      EdBaseName.SetFocus;
      exit;
    end;
  if BaseDados.ItemIndex < 3 then
    EdLocalizacao.Text := DiretorioCombarra(EdLocalizacao.Text);
  if (BaseDados.ItemIndex = 0) then
  begin
    if not FileExists(EdLocalizacao.Text + 'Dicionar.Dic') then
    begin
      Mensagem('Dicionário de dados não foi Localizado ...',modAdvertencia,[modOk]);
      EdLocalizacao.SetFocus;
      exit;
    end;
    IBDatabase.DatabaseName := EdLocalizacao.Text + 'Dicionar.Dic';
    IBDatabase.Params.Clear;
    IBDatabase.Params.Add('USER_NAME='+Projeto.usr_firebird);
    IBDatabase.Params.Add('PASSWORD='+Projeto.pwd_firebird);
    IBDatabase.LoginPrompt := False;
    IBDatabase.Connected := True;
    if IBDatabase.TestConnected then
    begin
      IBQuery.SQL.Text := 'Select * From Tabelas order By Nome';
      IBQuery.Open;
      IBQuery.First;
      LstTabelas.Items.Clear;
      I:=0;
      while not IBQuery.Eof do
      begin
        if IBQuery.FieldByName('NOME').AsString <> '' then
        begin
          Y := 0;
          LstTabelas.Items.Add(IBQuery.FieldByName('NOME').AsString);
          IBQuery1.SQL.Text := 'Select * From CAMPOST Where Numero = '+IBQuery.FieldByName('NUMERO').AsString + ' order by sequencia';
          IBQuery1.Open;
          IBQuery1.First;
          while not IBQuery1.Eof do
          begin
            if (IBQuery1.FieldByName('NOME').AsString <> '') then
              inc(Y);
            IBQuery1.Next;
          end;
          with Tabelas[I] do
          begin
            Numero            := IBQuery.FieldByName('NUMERO').AsInteger;
            Nome              := IBQuery.FieldByName('NOME').AsString;
            Titulo_t          := IBQuery.FieldByName('TITULO_T').AsString;
            Base              := IBQuery.FieldByName('BASE').AsInteger;
            Filtro_Inicial    := TBlobField(IBQuery.FieldByName('FILTRO_INICIAL')).AsString;
            Filtro_Mestre     := TBlobField(IBQuery.FieldByName('FILTRO_MESTRE')).AsString;
            Ordem_Inicial     := IBQuery.FieldByName('ORDEM_INICIAL').AsString;
            Ordem_Decrescente := IBQuery.FieldByName('ORDEM_DECRESCENTE').AsInteger;
            if IBQuery.FindField('GLOBAL') = Nil then
              Global := 1
            else
              Global := IBQuery.FieldByName('GLOBAL').AsInteger;
            if IBQuery.FindField('ABRIR_TABELA') = Nil then
              Abrir := 1
            else
              Abrir := IBQuery.FieldByName('ABRIR_TABELA').AsInteger;
            if IBQuery.FindField('USE_GENERATOR') = Nil then
              Generator := 1
            else
              Generator := IBQuery.FieldByName('USE_GENERATOR').AsInteger;
            Qtde_Campos       := Y - 1;
          end;
          Y:=0;
          IBQuery1.First;
          while not IBQuery1.Eof do
          begin
            if (IBQuery1.FieldByName('NOME').AsString <> '') then
            begin
              with Tabelas[I].Estrutura[Y] do
              begin
                Tipo              := IBQuery1.FieldByName('TIPO').AsInteger;
                Campo             := IBQuery1.FieldByName('NOME').AsString;
                if IBQuery1.FindField('NOME_FISICO') <> Nil then
                  Campo_Fisico    := IBQuery1.FieldByName('NOME_FISICO').AsString;
                if IBQuery1.FindField('TIPO_FISICO') <> Nil then
                  Tipo_Fisico     := IBQuery1.FieldByName('TIPO_FISICO').AsInteger
                else
                  Tipo_Fisico     := 1;  
                Tamanho           := IBQuery1.FieldByName('TAMANHO').AsInteger;
                Chave             := IBQuery1.FieldByName('CHAVE').AsInteger;
                Edicao            := IBQuery1.FieldByName('EDICAO').AsInteger;
                Mascara           := IBQuery1.FieldByName('MASCARA').AsString;
                Titulo_c          := IBQuery1.FieldByName('TITULO_C').AsString;
                Ajuda             := IBQuery1.FieldByName('AJUDA').AsString;
                Padrao            := IBQuery1.FieldByName('PADRAO').AsString;
                Validacao         := IBQuery1.FieldByName('VALIDACAO').AsString;
                Validos           := IBQuery1.FieldByName('VALIDOS').AsString;
                Descricao         := IBQuery1.FieldByName('DESCRICAO').AsString;
                Calculado         := IBQuery1.FieldByName('CALCULADO').AsInteger;
                Autoincremento    := IBQuery1.FieldByName('AUTOINCREMENTO').AsInteger;
                Sempre_atribui    := IBQuery1.FieldByName('SEMPRE_ATRIBUI').AsInteger;
                Invisivel         := IBQuery1.FieldByName('INVISIVEL').AsInteger;
                Pre_validacao     := IBQuery1.FieldByName('PRE_VALIDACAO').AsString;
                Tipo_pre_validacao:= IBQuery1.FieldByName('TIPO_PRE_VALIDACAO').AsInteger;
                Limpar_campo      := IBQuery1.FieldByName('LIMPAR_CAMPO').AsInteger;
                Msg_erro          := IBQuery1.FieldByName('MSG_ERRO').AsString;
                Tab_estrangeira   := IBQuery1.FieldByName('TAB_ESTRANGEIRA').AsString;
                Campo_chave       := IBQuery1.FieldByName('CAMPO_CHAVE').AsString;
                Campos_visuais    := IBQuery1.FieldByName('CAMPOS_VISUAIS').AsString;
                Estilo_chave      := IBQuery1.FieldByName('ESTILO_CHAVE').AsInteger;
                if IBQuery1.FindField('FILTRO_MESTRE') <> Nil then
                  Filtro_Mestre   := IBQuery1.FieldByName('FILTRO_MESTRE').AsString;
                Indice_consulta   := IBQuery1.FieldByName('INDICE_CONSULTA').AsInteger;
                Extra             := IBQuery1.FieldByName('EXTRA').AsInteger;
                Tab_Extra         := IBQuery1.FieldByName('TAB_EXTRA').AsString;
                Campo_Extra       := IBQuery1.FieldByName('CAMPO_EXTRA').AsString;
                Tab_Pesquisa      := IBQuery1.FieldByName('TAB_PESQUISA').AsString;
                Nao_Virtual       := IBQuery1.FieldByName('NAO_VIRTUAL').AsInteger;
                if IBQuery1.FindField('SQL_EXTRA') <> Nil then
                  sql_extra       := IBQuery1.FieldByName('SQL_EXTRA').AsString;
                if IBQuery1.FindField('SEM_INSERT') <> Nil then
                  sem_insert      := IBQuery1.FieldByName('SEM_INSERT').AsInteger;
                if IBQuery1.FindField('VALIDA_ONEXIT') <> Nil then
                  valida_onexit   := IBQuery1.FieldByName('VALIDA_ONEXIT').AsInteger;
                if IBQuery1.FindField('SQL_EXTRA_INSERT') <> Nil then
                  sql_extra_insert:= IBQuery1.FieldByName('SQL_EXTRA_INSERT').AsString;
                if Calculado = 1 then
                begin
                  if IBQuery1.FindField('VARIAVEIS') = Nil then
                  begin
                    IBQuery2.SQL.Text := 'Select * From CALCULADOS Where Numero = '+IBQuery.Fields[0].AsString + ' AND SEQUENCIA = '+IBQuery1.FieldByName('SEQUENCIA').AsString;
                    IBQuery2.Open;
                    IBQuery2.First;
                    if not IBQuery2.Eof then
                    begin
                      Variaveis := TBlobField(IBQuery2.FieldByName('VARIAVEIS')).AsString;
                      Codificacao := TBlobField(IBQuery2.FieldByName('CODIFICACAO')).AsString;
                    end;
                    IBQuery2.Close;
                  end
                  else
                  begin
                    Variaveis := TBlobField(IBQuery1.FieldByName('VARIAVEIS')).AsString;
                    Codificacao := TBlobField(IBQuery1.FieldByName('CODIFICACAO')).AsString;
                  end;
                end;
              end;
              inc(Y);
            end;
            IBQuery1.Next;
          end;
          IBQuery1.Close;
          Inc(I);
        end;
        IBQuery.Next;
      end;
      IBQuery.Close;
      IBDatabase.Connected := False;
    end;
  end
  else if (BaseDados.ItemIndex = 1) or (BaseDados.ItemIndex = 2) then
  begin
    if BaseDados.ItemIndex = 1 then
      LstTabelas_2.Mask := '*.dbf'
    else if BaseDados.ItemIndex = 2 then
      LstTabelas_2.Mask := '*.db';
    LstTabelas_2.ApplyFilePath(EdLocalizacao.Text);
    LstTabelas.Items := LstTabelas_2.Items;
    Table.DatabaseName := EdLocalizacao.Text;
    if LstTabelas.Items.Count = 0 then
      Mensagem('Nenhuma tabela encontrada!', modAdvertencia, [modOk]);
    for I:=0 to LstTabelas.Items.Count-1 do
    begin
      if I <= 200 then
      begin
        Table.TableName := LstTabelas.Items[I];
        if Pos('.',LstTabelas.Items[I]) > 0 then
        begin
          Tabelas[I].Nome := Copy(LstTabelas.Items[I],01,Pos('.',LstTabelas.Items[I])-1);
          Tabelas[I].Titulo_t := Tabelas[I].Nome;
        end
        else
        begin
          Tabelas[I].Nome := LstTabelas.Items[I];
          Tabelas[I].Titulo_t := LstTabelas.Items[I];
        end;
        Table.Open;
        Tabelas[I].Base := 0;
        Tabelas[I].Global := 1;
        Tabelas[I].Abrir  := 0;
        Tabelas[I].Generator := 1;
        Tabelas[I].Qtde_Campos := Table.FieldCount - 1;
        for Y := 0 to Table.FieldCount - 1 do
        begin
          if Y <= 200 then
          begin
            Tabelas[I].Estrutura[Y].Tipo := P_DataType(Table.FieldDefs[Y].DataType);
            Tabelas[I].Estrutura[Y].Tipo_Fisico := 1;
            if Tabelas[I].Estrutura[Y].Tipo > -1 then
              Tabelas[I].Estrutura[Y].Campo := Table.FieldDefs[Y].Name
            else
              Tabelas[I].Estrutura[Y].Campo := '**NAO SUPORTADO**';
            if Table.FieldDefs[Y].Size = 0 then
            begin
              if Tabelas[I].Estrutura[Y].Tipo = 1 then
                Tabelas[I].Estrutura[Y].Tamanho := 1
              else if Tabelas[I].Estrutura[Y].Tipo = 2 then
                Tabelas[I].Estrutura[Y].Tamanho := 10
              else if Tabelas[I].Estrutura[Y].Tipo = 3 then
                Tabelas[I].Estrutura[Y].Tamanho := 10
              else if Tabelas[I].Estrutura[Y].Tipo = 4 then
                Tabelas[I].Estrutura[Y].Tamanho := 8
              else if Tabelas[I].Estrutura[Y].Tipo = 5 then
                Tabelas[I].Estrutura[Y].Tamanho := 10
              else if Tabelas[I].Estrutura[Y].Tipo = 6 then
                Tabelas[I].Estrutura[Y].Tamanho := 10;
            end
            else
              Tabelas[I].Estrutura[Y].Tamanho := Table.FieldDefs[Y].Size;
            if (Table.FieldDefs[Y].Size > 500) and
               (Tabelas[I].Estrutura[Y].Tipo = 1) then
            begin
              Tabelas[I].Estrutura[Y].Tipo    := 5;
              Tabelas[I].Estrutura[Y].Tamanho := 10;
            end;
            Tabelas[I].Estrutura[Y].Chave := 0;
            Tabelas[I].Estrutura[Y].Titulo_c := Table.FieldDefs[Y].Name;
            Tabelas[I].Estrutura[Y].Edicao := 1;
            Tabelas[I].Estrutura[Y].Calculado := 0;
            Tabelas[I].Estrutura[Y].Autoincremento := 0;
            Tabelas[I].Estrutura[Y].Sempre_atribui := 0;
            Tabelas[I].Estrutura[Y].Invisivel := 0;
            Tabelas[I].Estrutura[Y].Tipo_pre_validacao := 1;
            Tabelas[I].Estrutura[Y].Limpar_campo := 0;
            Tabelas[I].Estrutura[Y].Estilo_chave := 1;
            Tabelas[I].Estrutura[Y].Filtro_Mestre:= '';
            Tabelas[I].Estrutura[Y].Indice_consulta := Y;
            Tabelas[I].Estrutura[Y].Extra := 0;
            Tabelas[I].Estrutura[Y].nao_virtual := 0;
          end;
        end;
        Table.Close;
      end;
    end;
  end
  else
  begin
    if Trim(EdLocalizacao.Text) <> '' then
      SDDatabase.RemoteDatabase := EdLocalizacao.Text + ':' + EdBaseName.Text
    else
      SDDatabase.RemoteDatabase := EdBaseName.Text;
    case BaseDados.ItemIndex of
      3: SDDatabase.ServerType := stInterbase;
      4: SDDatabase.ServerType := stFirebird;
      5: SDDatabase.ServerType := stSQLBase;
      6: SDDatabase.ServerType := stOracle;
      7: SDDatabase.ServerType := stSQLServer;
      8: SDDatabase.ServerType := stSybase;
      9: SDDatabase.ServerType := stDB2;
     10: SDDatabase.ServerType := stInformix;
     11: SDDatabase.ServerType := stODBC;
     12: SDDatabase.ServerType := stMySQL;
     13: SDDatabase.ServerType := stPostgreSQL;
     14: SDDatabase.ServerType := stOLEDB;
    end;
    Acesso := TAcesso.Create(Application);
    Try
      Acesso.ShowModal;
    Finally
      SDDatabase.Params.Clear;
      SDDatabase.Params.Add('USER NAME='+Acesso.EdUsuario.Text);
      SDDatabase.Params.Add('PASSWORD='+Acesso.EdSenha.Text);
      if (BaseDados.ItemIndex = 3) or
         (BaseDados.ItemIndex = 4) then
        SDDatabase.Params.Add('SQL DIALECT=3');
      Acesso.Free;
    end;
    SDDatabase.Connected := True;
    SDDatabase.GetTableNames('', False, LstTabelas.Items);
    for I:=0 to LstTabelas.Items.Count-1 do
    begin
      if Pos('.',LstTabelas.Items[I]) > 0 then
        LstTabelas.Items[I] := Copy(LstTabelas.Items[I], Pos('.',LstTabelas.Items[I])+1, Length(LstTabelas.Items[I]));
      if I <= 200 then
      begin
        SDQuery.SQL.Text := 'Select * From '+LstTabelas.Items[I];
        Tabelas[I].Nome := LstTabelas.Items[I];
        SDQuery.Open;
        Tabelas[I].Base := 0;
        Tabelas[I].Global := 1;
        Tabelas[I].Abrir  := 0;
        Tabelas[I].Generator := 1;
        Tabelas[I].Qtde_Campos := SDQuery.FieldCount - 1;
        for Y := 0 to SDQuery.FieldCount - 1 do
        begin
          if Y <= 200 then
          begin
            Tabelas[I].Estrutura[Y].Tipo := P_DataType(SDQuery.FieldDefs[Y].DataType);
            Tabelas[I].Estrutura[Y].Tipo_Fisico := 1;
            if Tabelas[I].Estrutura[Y].Tipo > -1 then
              Tabelas[I].Estrutura[Y].Campo := SDQuery.FieldDefs[Y].Name
            else
              Tabelas[I].Estrutura[Y].Campo := '**NAO SUPORTADO**';
            if SDQuery.FieldDefs[Y].Size = 0 then
            begin
              if Tabelas[I].Estrutura[Y].Tipo = 1 then
                Tabelas[I].Estrutura[Y].Tamanho := 1
              else if Tabelas[I].Estrutura[Y].Tipo = 2 then
                Tabelas[I].Estrutura[Y].Tamanho := 10
              else if Tabelas[I].Estrutura[Y].Tipo = 3 then
                Tabelas[I].Estrutura[Y].Tamanho := 10
              else if Tabelas[I].Estrutura[Y].Tipo = 4 then
                Tabelas[I].Estrutura[Y].Tamanho := 8
              else if Tabelas[I].Estrutura[Y].Tipo = 5 then
                Tabelas[I].Estrutura[Y].Tamanho := 10
              else if Tabelas[I].Estrutura[Y].Tipo = 6 then
                Tabelas[I].Estrutura[Y].Tamanho := 10;
            end
            else
              Tabelas[I].Estrutura[Y].Tamanho := SDQuery.FieldDefs[Y].Size;
            if (SDQuery.FieldDefs[Y].Size > 500) and
               (Tabelas[I].Estrutura[Y].Tipo = 1) then
            begin
              Tabelas[I].Estrutura[Y].Tipo    := 5;
              Tabelas[I].Estrutura[Y].Tamanho := 10;
            end;
            Tabelas[I].Estrutura[Y].Chave := 0;
            Tabelas[I].Estrutura[Y].Titulo_c := SDQuery.FieldDefs[Y].Name;
            Tabelas[I].Estrutura[Y].Edicao := 1;
            Tabelas[I].Estrutura[Y].Calculado := 0;
            Tabelas[I].Estrutura[Y].Autoincremento := 0;
            Tabelas[I].Estrutura[Y].Sempre_atribui := 0;
            Tabelas[I].Estrutura[Y].Invisivel := 0;
            Tabelas[I].Estrutura[Y].Tipo_pre_validacao := 1;
            Tabelas[I].Estrutura[Y].Limpar_campo := 0;
            Tabelas[I].Estrutura[Y].Estilo_chave := 1;
            Tabelas[I].Estrutura[Y].Filtro_Mestre:= '';
            Tabelas[I].Estrutura[Y].Indice_consulta := Y;
            Tabelas[I].Estrutura[Y].Extra := 0;
            Tabelas[I].Estrutura[Y].nao_virtual := 0;
          end;  
        end;
        SDQuery.Close;
      end;
      SDDatabase.Connected := False;
    end;
  end;
  if LstTabelas.Items.Count > 0 then
    LstTabelas.ItemIndex := 0;
  LstTabelasClick(Self);
  except
    on Erro: Exception do
    begin
      Mensagem('Erro: '+Erro.Message, modErro, [modOk]);
    end;
  end;
end;

procedure TFormImpEstrutura.BaseDadosClick(Sender: TObject);
begin
  LstTabelas.Items.Clear;
  LstCampos.RowCount := 2;
  LstCampos.FixedRows := 1;
  LstCampos.Cells[0,0] := 'Nome';
  LstCampos.Cells[1,0] := 'Tipo';
  LstCampos.Cells[2,0] := 'Tamanho';
  LstCampos.Cells[3,0] := 'Chave';
  LstCampos.Cells[0,1] := '';
  LstCampos.Cells[1,1] := '';
  LstCampos.Cells[2,1] := '';
  LstCampos.Cells[3,1] := '';
  if BaseDados.ItemIndex > 2 then
  begin
    Label1.Caption := 'HostName';
    if (BaseDados.ItemIndex = 3) or
       (BaseDados.ItemIndex = 4) then
      BtnLocaliza.Enabled := True
    else
      BtnLocaliza.Enabled := False;
    EdLocalizacao.Width := 232;
    Label4.Visible := True;
    EdBaseName.Visible := True;
  end
  else
  begin
    Label1.Caption := 'Pasta de Localização:';
    BtnLocaliza.Enabled := True;
    EdLocalizacao.Width := 398;
    Label4.Visible := False;
    EdBaseName.Visible := False;
  end;
end;

procedure TFormImpEstrutura.FormShow(Sender: TObject);
var
  PosBase: Integer;
begin
  BaseDados.ItemIndex := StrToIntDef(IniFile.ReadString('IMPORTACAO', 'Base', ''),0);
  EdLocalizacao.Text := IniFile.ReadString('IMPORTACAO', 'Localizacao', '');
  EdBaseName.Text := IniFile.ReadString('IMPORTACAO', 'BaseName', '');
  BaseDadosClick(Self);
end;

procedure TFormImpEstrutura.LstTabelasClick(Sender: TObject);
var
  I,P: Integer;
begin
  P := LstTabelas.ItemIndex;
  if P < 0 then exit;
  LstCampos.RowCount := Tabelas[P].Qtde_Campos + 2;
  LstCampos.FixedRows := 1;
  LstCampos.Cells[0,0] := 'Nome';
  LstCampos.Cells[1,0] := 'Tipo';
  LstCampos.Cells[2,0] := 'Tamanho';
  LstCampos.Cells[3,0] := 'Chave';
  for I:=0 to Tabelas[P].Qtde_Campos + 2 do
  begin
    LstCampos.Cells[0,I+1] := Tabelas[P].Estrutura[I].Campo;
    {case Tabelas[P].Estrutura[I].Tipo of
      1: LstCampos.Cells[1,I+1] := 'Alfanumérico';
      2: LstCampos.Cells[1,I+1] := 'Inteiro';
      3: LstCampos.Cells[1,I+1] := 'Fracionário';
      4: LstCampos.Cells[1,I+1] := 'Data';
      5: LstCampos.Cells[1,I+1] := 'Memo';
      6: LstCampos.Cells[1,I+1] := 'Imagem';
    end;}
    if (Tabelas[P].Estrutura[I].Tipo > 0) and
       (Tabelas[P].Estrutura[I].Tipo <= Length(Tipos_Suportados)) then
      LstCampos.Cells[1,I+1] := Tipos_Suportados[Tabelas[P].Estrutura[I].Tipo];
    LstCampos.Cells[2,I+1] := IntToStr(Tabelas[P].Estrutura[I].Tamanho);
    if Tabelas[P].Estrutura[I].Chave = 1 then
      LstCampos.Cells[3,I+1] := 'Sim'
    else
      LstCampos.Cells[3,I+1] := 'Não';
  end;
end;

procedure TFormImpEstrutura.BtnLocalizaClick(Sender: TObject);
Var S: String;
begin
  if (BaseDados.ItemIndex = 3) or
     (BaseDados.ItemIndex = 4) then
  begin
    if OpenDialog.Execute then
      EdBaseName.Text := OpenDialog.FileName;
  end
  else
  begin
    S := '';
    if SelectDirectory('Selecione a Pasta', '', S) then
      EdLocalizacao.Text := DiretorioCombarra(S);
  end;
end;

procedure TFormImpEstrutura.FormDestroy(Sender: TObject);
begin
  IniFile.Free;
end;

procedure TFormImpEstrutura.FormCreate(Sender: TObject);
begin
  ArqIni := Projeto.Pasta;
  ArqIni := DiretoriocomBarra(ArqIni);
  ArqIni := ArqIni + 'ImpEstr.ini';
  IniFile := TInifile.Create(ArqIni);
end;

procedure TFormImpEstrutura.LstTabelasDrawItem(Control: TWinControl;
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
    Image := Image1;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormImpEstrutura.Marcartodas1Click(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to LstTabelas.Items.Count-1 do
    LstTabelas.Checked[I] := True;
end;

procedure TFormImpEstrutura.Desmarcartodas1Click(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to LstTabelas.Items.Count-1 do
    LstTabelas.Checked[I] := False;
end;

end.
