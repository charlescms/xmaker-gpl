unit Estrutura_Bd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, XBanner, Db,
  DBCtrls, ToolEdit, RXDBCtrl, Mask, XLookUp, Commctrl, Tabs, ShellApi;

type
  TFormEstruturas = class(TForm)
    XBanner: TXBanner;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PnTabelas: TPanel;
    PnCampos: TPanel;
    PnIndices: TPanel;
    PnIntegridade: TPanel;
    BtnFechar: TBitBtn;
    BthAjudaTabela: TBitBtn;
    PageControl2: TPageControl;
    Pagina2: TTabSheet;
    Pagina3: TTabSheet;
    Pagina4: TTabSheet;
    Pagina5: TTabSheet;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    BtnAcima: TSpeedButton;
    BtnABaixo: TSpeedButton;
    Label17: TLabel;
    ID_EDTITULO: TDBEdit;
    ID_EdCrescente: TDBCheckBox;
    Label21: TLabel;
    CamposOrigem: TListBox;
    BtnInserirCmp: TSpeedButton;
    BtnExcluirCmp: TSpeedButton;
    Label22: TLabel;
    CamposIndices: TListBox;
    BtnMoveParaCima: TSpeedButton;
    BtnMoveParaBaixo: TSpeedButton;
    TabSet1: TTabSet;
    NoPrincipal: TNotebook;
    Panel1: TPanel;
    BtnSalvar: TBitBtn;
    BtnCancela: TBitBtn;
    BtnNovo: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnHerdar: TSpeedButton;
    BtnCalculo: TSpeedButton;
    BtnChEst: TSpeedButton;
    GridIntegridade: TListBox;
    GridTabela: TListBox;
    GridCampos: TListBox;
    GridIndices: TListBox;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    BtnIndex: TSpeedButton;
    Pagina0: TScrollBox;
    Label1: TLabel;
    CP_EdNome: TRxDBComboEdit;
    Label5: TLabel;
    CP_EdTipo: TDBComboBox;
    CP_EdChave: TDBCheckBox;
    Label6: TLabel;
    CP_EdTamanho: TDBEdit;
    Label15: TLabel;
    CP_EdSequencia: TDBEdit;
    Label7: TLabel;
    CP_EdEdicao: TDBComboBox;
    CP_EdCalculado: TDBCheckBox;
    Label8: TLabel;
    CP_EdMascara: TRxDBComboEdit;
    Label9: TLabel;
    CP_EdTitulo: TDBEdit;
    Label19: TLabel;
    CP_EdIndice: TDBEdit;
    CP_EdInvisivel: TDBCheckBox;
    Label10: TLabel;
    CP_EdAjuda: TDBEdit;
    Label11: TLabel;
    CP_EdPadrao: TDBEdit;
    Pagina1: TScrollBox;
    Label12: TLabel;
    CP_EdPreValidacao: TRxDBComboEdit;
    Label18: TLabel;
    CP_EdTipoPre: TDBComboBox;
    CP_EdLimparCampo: TDBCheckBox;
    Label13: TLabel;
    CP_EdValidacao: TDBComboBox;
    Label14: TLabel;
    CP_EdValidos: TRxDBComboEdit;
    Label16: TLabel;
    CP_EdMsgErro: TDBEdit;
    BtnImportar: TSpeedButton;
    PgIntegridade: TScrollBox;
    Label24: TLabel;
    IT_EdTitulo_i: TDBEdit;
    Label26: TLabel;
    IT_EdTipo: TDBComboBox;
    Label25: TLabel;
    IT_EdTab_Estrangeira: TRxDBComboEdit;
    Gr_Compat: TPanel;
    Panel3: TPanel;
    Label27: TLabel;
    CS_EdCodificacao: TComboEdit;
    Label28: TLabel;
    RS_EdCodificacao: TComboEdit;
    CP_EdSempreAtribui: TDBCheckBox;
    BtnCamposExtra: TSpeedButton;
    Image4: TImage;
    PnExtra: TPanel;
    CP_EdTab_Pesquisa: TDBComboBox;
    Label29: TLabel;
    PnProcessos: TPanel;
    GridProcessos: TListBox;
    Pagina6: TTabSheet;
    DataSource6: TDataSource;
    PgProcessos: TScrollBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    PR_EdTitulo_i: TDBEdit;
    PR_EdTipo: TDBComboBox;
    PR_EdTab_Alvo: TRxDBComboEdit;
    Regerar: TCheckBox;
    Pagina_Tabela: TScrollBox;
    Label2: TLabel;
    TB_EdNome: TDBEdit;
    TB_EdGlobal: TDBCheckBox;
    TB_EdNome_Interno: TDBComboBox;
    Label34: TLabel;
    Label3: TLabel;
    TB_EdTitulo: TDBEdit;
    Label4: TLabel;
    TB_EdBanco: TXDBLookUp;
    BtnBancoDados: TSpeedButton;
    Label20: TLabel;
    TB_EdFiltroInicial: TComboEdit;
    Label23: TLabel;
    TB_EdFiltroMestre: TComboEdit;
    Label33: TLabel;
    TB_EdOrdemInicial: TComboEdit;
    TB_EdAbrir: TDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CP_EdTipoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CP_EdEdicaoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CP_EdTipoPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BtnExcluirClick(Sender: TObject);
    procedure TB_EdNomeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CP_EdNomeButtonClick(Sender: TObject);
    procedure CP_EdChaveExit(Sender: TObject);
    procedure CP_EdValidacaoEnter(Sender: TObject);
    procedure CP_EdPadraoEnter(Sender: TObject);
    procedure CP_EdMascaraButtonClick(Sender: TObject);
    procedure BtnAcimaClick(Sender: TObject);
    procedure BtnABaixoClick(Sender: TObject);
    procedure BtnCalculoClick(Sender: TObject);
    procedure BtnHerdarClick(Sender: TObject);
    procedure CP_EdEdicaoExit(Sender: TObject);
    procedure BtnChEstClick(Sender: TObject);
    procedure CP_EdNomeExit(Sender: TObject);
    procedure ID_EDTITULOExit(Sender: TObject);
    procedure BtnInserirCmpClick(Sender: TObject);
    procedure BtnExcluirCmpClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure CP_EdValidosButtonClick(Sender: TObject);
    procedure CP_EdPreValidacaoButtonClick(Sender: TObject);
    procedure BtnBancoDadosClick(Sender: TObject);
    procedure TabSet1Click(Sender: TObject);
    procedure CP_EdPadraoExit(Sender: TObject);
    procedure GridTabelaClick(Sender: TObject);
    procedure GridCamposClick(Sender: TObject);
    procedure GridIndicesClick(Sender: TObject);
    procedure GridIntegridadeClick(Sender: TObject);
    procedure GridTabelaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridTabelaDblClick(Sender: TObject);
    procedure GridCamposDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnIndexClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TB_EdFiltroInicialButtonClick(Sender: TObject);
    procedure TB_EdFiltroMestreButtonClick(Sender: TObject);
    procedure TB_EdNomeChange(Sender: TObject);
    procedure IT_EdTipoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure IT_EdTab_EstrangeiraButtonClick(Sender: TObject);
    procedure IT_EdTitulo_iExit(Sender: TObject);
    procedure IT_EdTipoExit(Sender: TObject);
    procedure CS_EdCodificacaoButtonClick(Sender: TObject);
    procedure RS_EdCodificacaoButtonClick(Sender: TObject);
    procedure IT_EdTab_EstrangeiraExit(Sender: TObject);
    procedure CP_EdSequenciaExit(Sender: TObject);
    procedure CP_EdSempreAtribuiExit(Sender: TObject);
    procedure BtnCamposExtraClick(Sender: TObject);
    procedure PnProcessosClick(Sender: TObject);
    procedure PR_EdTipoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure PR_EdTitulo_iExit(Sender: TObject);
    procedure PR_EdTipoExit(Sender: TObject);
    procedure PR_EdTab_AlvoExit(Sender: TObject);
    procedure PR_EdTab_AlvoButtonClick(Sender: TObject);
    procedure TB_EdOrdemInicialButtonClick(Sender: TObject);
    procedure CamposOrigemDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BthAjudaTabelaClick(Sender: TObject);
    procedure CP_EdTamanhoExit(Sender: TObject);
    procedure CP_EdAjudaEnter(Sender: TObject);
  private
    { Private declarations }
    Escolha_Atual: Integer;
    Campos_Chave: TStringList;
    Nome_Original_Tab: String;
    procedure Habilita_Escolha(P: Integer);
    procedure Habilita_Campos(L: Boolean);
    procedure PreencheListaIndice;
    procedure AtualizaLista(P: Integer);
    procedure Atualiza_Integridade;
    procedure Atualiza_Nome_Tabela;
  public
    { Public declarations }
    Modificou: Boolean;
    function ValidaNomeCampo(S: String; Posicao: Integer = -1; Tabela: Boolean = False): Boolean;
  end;

const
  TTS_BALLOON = $40;
  TTM_SETTITLE = (WM_USER + 32);

var
  FormEstruturas: TFormEstruturas;
  hTooltip: Cardinal;
  ti: TToolInfo;
  buffer : array[0..255] of char;

implementation

{$R *.DFM}

uses Rotinas, Princ, Selecao, Gera_01, Abertura, MiniEditor, CamposProj, Tabela,
  ChaveEst, VValidos, Expressao, BancoD, Aguarde, TabOrdem, EdFiltro,
  Relacion, ImpEstr, EdProcessos, EdLanctos, EdOrdenacao;

procedure CreateToolTips(hWnd: Cardinal; Form: TForm);
var
  I: Integer;
  procedure AddToolTip(hwnd: dword; lpti: PToolInfo; IconType: Integer; Text, Title: PChar);
  var
    Item: THandle;
    Rect: TRect;
  begin
    Item := hWnd;
    if (Item <> 0) AND (GetClientRect(Item, Rect)) then
    begin
      lpti.hwnd := Item;
      lpti.Rect := Rect;
      lpti.lpszText := Text;
      SendMessage(hToolTip, TTM_ADDTOOL, 0, Integer(lpti));
      FillChar(buffer, sizeof(buffer), #0);
      lstrcpy(buffer, Title);
      if (IconType > 3) or (IconType < 0) then IconType := 0;
        SendMessage(hToolTip, TTM_SETTITLE, IconType, Integer(@buffer));
    end;
  end;

  procedure AddHintEspecial(T: THandle; Msg,Titulo: String; Tipo: Integer = 1);
  begin
    if Trim(Titulo) = '' then
      case Tipo of
        0: Titulo := '';
        1: Titulo := 'Informação ...';
        2: Titulo := 'Aviso !';
        3: Titulo := 'Erro !!!';
      end;
    AddToolTip(T, @ti, Tipo, PChar(Msg), PChar(Titulo));
  end;

  procedure HintEspecial(Control: TWinControl; Titulo: String = ''; Tipo: Integer = 1);
  begin
    if Trim(Control.Hint) <> '' then
    begin
      Control.ShowHint := False;
      AddHintEspecial(Control.Handle, Control.Hint, Titulo, Tipo);
    end;
  end;

begin
  hToolTip := CreateWindowEx(0, 'Tooltips_Class32', nil, TTS_ALWAYSTIP or TTS_BALLOON,
    Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),Integer(CW_USEDEFAULT),
    Integer(CW_USEDEFAULT), hWnd, 0, hInstance, nil);
  if hToolTip <> 0 then
  begin
    SetWindowPos(hToolTip, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE or SWP_NOACTIVATE);
    ti.cbSize := SizeOf(TToolInfo);
    ti.uFlags := TTF_SUBCLASS;
    ti.hInst := hInstance;
  end;
  for I:=0 to Form.ComponentCount -1 do
    if Form.Components[i] is TWinControl then
      HintEspecial(TWinControl(Form.Components[i]));
end;

procedure TFormEstruturas.AtualizaLista(P: Integer);
begin
  case P of
    1: begin
         TabGlobal_i.DTABELAS.DisableControls;
         GridTabela.Items.Clear;
         TabGlobal_i.DTABELAS.AtualizaSql;
         TabGlobal_i.DTABELAS.First;
         while not TabGlobal_i.DTABELAS.Eof do
         begin
           GridTabela.Items.AddObject(TabGlobal_i.DTABELAS.NOME.Conteudo,TObject(TabGlobal_i.DTABELAS.NUMERO.Conteudo));
           TabGlobal_i.DTABELAS.Next;
         end;
         TB_EdNome_Interno.Items.Clear;
         TB_EdNome_Interno.Items.Add('');
         TB_EdNome_Interno.Items.AddStrings(GridTabela.Items);
         TabGlobal_i.DTABELAS.First;
         TabGlobal_i.DTABELAS.EnableControls;
       end;
    2: begin
         TabGlobal_i.DCAMPOST.DisableControls;
         GridCampos.Items.Clear;
         Campos_Chave.Clear;
         TabGlobal_i.DCAMPOST.AtualizaSql;
         TabGlobal_i.DCAMPOST.First;
         while not TabGlobal_i.DCAMPOST.Eof do
         begin
           GridCampos.Items.AddObject(TabGlobal_i.DCAMPOST.NOME.Conteudo,TObject(TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo));
           if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 0 then
           begin
             if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
               Campos_Chave.Add('2')
             else
               Campos_Chave.Add('0');
           end
           else
             Campos_Chave.Add('1');
           TabGlobal_i.DCAMPOST.Next;
         end;
         TabGlobal_i.DCAMPOST.First;
         TabGlobal_i.DCAMPOST.EnableControls;
       end;
    3: begin
         TabGlobal_i.DINDICEST.DisableControls;
         GridIndices.Items.Clear;
         TabGlobal_i.DINDICEST.AtualizaSql;
         TabGlobal_i.DINDICEST.First;
         while not TabGlobal_i.DINDICEST.Eof do
         begin
           GridIndices.Items.AddObject(TabGlobal_i.DINDICEST.TITULO_I.Conteudo,TObject(TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo));
           TabGlobal_i.DINDICEST.Next;
         end;
         TabGlobal_i.DINDICEST.First;
         TabGlobal_i.DINDICEST.EnableControls;
       end;
    4: begin
         TabGlobal_i.DRELACIONA.DisableControls;
         GridIntegridade.Items.Clear;
         TabGlobal_i.DRELACIONA.AtualizaSql;
         TabGlobal_i.DRELACIONA.First;
         CP_EdTab_Pesquisa.Clear;
         CP_EdTab_Pesquisa.Items.Add('');
         while not TabGlobal_i.DRELACIONA.Eof do
         begin
           GridIntegridade.Items.AddObject(TabGlobal_i.DRELACIONA.TITULO_I.Conteudo,TObject(TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo));
           CP_EdTab_Pesquisa.Items.Add(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
           TabGlobal_i.DRELACIONA.Next;
         end;
         TabGlobal_i.DRELACIONA.First;
         TabGlobal_i.DRELACIONA.EnableControls;
       end;
    5: begin
         TabGlobal_i.DPROCESSOS.DisableControls;
         GridProcessos.Items.Clear;
         TabGlobal_i.DPROCESSOS.AtualizaSql;
         TabGlobal_i.DPROCESSOS.First;
         while not TabGlobal_i.DPROCESSOS.Eof do
         begin
           GridProcessos.Items.AddObject(TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo,TObject(TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo));
           TabGlobal_i.DPROCESSOS.Next;
         end;
         TabGlobal_i.DPROCESSOS.First;
         TabGlobal_i.DPROCESSOS.EnableControls;
       end;
  end;
end;

procedure TFormEstruturas.Habilita_Escolha(P: Integer);
begin
  if Escolha_Atual = P then exit;

  BtnSalvar.Enabled  := False;
  BtnCancela.Enabled := False;
  BtnExcluir.Enabled := False;
  BtnNovo.Enabled    := True;

  PnTabelas.Color      := clBtnFace;
  PnTabelas.Font.Color := clWindowText;
  PnTabelas.BevelOuter := bvNone;
  GridTabela.Color     := clBtnFace;

  PnCampos.Color      := clBtnFace;
  PnCampos.Font.Color := clWindowText;
  PnCampos.BevelOuter := bvNone;
  GridCampos.Color    := clBtnFace;

  PnIndices.Color      := clBtnFace;
  PnIndices.Font.Color := clWindowText;
  PnIndices.BevelOuter := bvNone;
  GridIndices.Color    := clBtnFace;

  PnIntegridade.Color      := clBtnFace;
  PnIntegridade.Font.Color := clWindowText;
  PnIntegridade.BevelOuter := bvNone;
  GridIntegridade.Color    := clBtnFace;

  PnProcessos.Color        := clBtnFace;
  PnProcessos.Font.Color   := clWindowText;
  PnProcessos.BevelOuter   := bvNone;
  GridProcessos.Color      := clBtnFace;

  Pagina2.TabVisible := False;
  Pagina3.TabVisible := False;
  Pagina4.TabVisible := False;
  Pagina5.TabVisible := False;
  Pagina6.TabVisible := False;
  BtnHerdar.Enabled  := False;
  BtnImportar.Enabled:= False;
  BtnIndex.Enabled   := False;
  BtnCamposExtra.Enabled := False;
  BtnACima.Enabled  := False;
  BtnABaixo.Enabled := False;

  case P of
    1: Begin
         GridTabela.Color := clWindow;
         GridTabela.SetFocus;
         if Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '' then
           BtnExcluir.Enabled := True;
         Pagina2.TabVisible := True;
         PnTabelas.Color := clSilver;
         PnTabelas.Font.Color := clBlue;
         PnTabelas.BevelOuter := bvLowered;
         BtnHerdar.Enabled := True;
         BtnImportar.Enabled := True;
         BtnIndex.Enabled  := True;
         BtnCamposExtra.Enabled := True;
         BtnCalculo.Enabled := False;
         BtnChEst.Enabled := False;
       end;
    2: Begin
         GridCampos.Color := clWindow;
         GridCampos.SetFocus;
         if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
           BtnExcluir.Enabled := True;
         Pagina3.TabVisible := True;
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover campo para cima';
         BtnAbaixo.Hint := 'Mover campo para baixo';
         PnCampos.Color := clSilver;
         PnCampos.Font.Color := clBlue;
         PnCampos.BevelOuter := bvLowered;
         BtnHerdar.Enabled := True;
         BtnImportar.Enabled := True;
         BtnIndex.Enabled  := True;
         BtnCamposExtra.Enabled := True;
       end;
    3: Begin
         PreencheListaIndice;
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover índice para cima';
         BtnAbaixo.Hint := 'Mover índice para baixo';
         BtnExcluir.Enabled := True;
         GridIndices.Color := clWindow;
         GridIndices.SetFocus;
         if Trim(TabGlobal_i.DINDICEST.CAMPOST.Conteudo) <> '' then
           BtnExcluir.Enabled := True;
         Pagina4.TabVisible := True;
         PnIndices.Color := clSilver;
         PnIndices.Font.Color := clBlue;
         PnIndices.BevelOuter := bvLowered;
       end;
    4: Begin
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover relacionamento para cima';
         BtnAbaixo.Hint := 'Mover relacionamento para baixo';
         BtnExcluir.Enabled := True;
         GridIntegridade.Color := clWindow;
         GridIntegridade.SetFocus;
         Pagina5.TabVisible := True;
         PnIntegridade.Color := clSilver;
         PnIntegridade.Font.Color := clBlue;
         PnIntegridade.BevelOuter := bvLowered;
       end;
    5: Begin
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover processo para cima';
         BtnAbaixo.Hint := 'Mover processo para baixo';
         BtnExcluir.Enabled := True;
         GridProcessos.Color := clWindow;
         GridProcessos.SetFocus;
         Pagina6.TabVisible := True;
         PnProcessos.Color := clSilver;
         PnProcessos.Font.Color := clBlue;
         PnProcessos.BevelOuter := bvLowered;
       end;
  end;
  Escolha_Atual := P;
end;

procedure TFormEstruturas.Habilita_Campos(L: Boolean);
var
  Cor: TColor;
begin
  L := not L;
  BtnSalvar.Enabled  := not L;
  BtnCancela.Enabled := not L;
  BtnNovo.Enabled    := L;
  BtnExcluir.Enabled := L;

  GridTabela.Enabled      := L;
  BtnHerdar.Enabled       := L;
  BtnImportar.Enabled     := L;
  BtnIndex.Enabled        := L;
  BtnCamposExtra.Enabled  := L;
  GridCampos.Enabled      := L;
  GridIndices.Enabled     := L;
  GridIntegridade.Enabled := L;
  GridProcessos.Enabled   := L;
  PnTabelas.Enabled       := L;
  PnCampos.Enabled        := L;
  PnIndices.Enabled       := L;
  PnIntegridade.Enabled   := L;
  PnProcessos.Enabled     := L;
  if L then
    Cor := clBtnFace
  else
    Cor := clWindow;

  case Escolha_Atual of
    1: begin
         Pagina_Tabela.Enabled := not L;
         TB_EdNome.Color   := Cor;
         TB_EdNome_Interno.Color := Cor;
         TB_EdTitulo.Color := Cor;
         TB_EdBanco.Color  := Cor;
         TB_EdFiltroInicial.Color := Cor;
         TB_EdFiltroMestre.Color := Cor;
         TB_EdOrdemInicial.Color := Cor;
         TB_EdNome.ReadOnly   := L;
         TB_EdGlobal.ReadOnly := L;
         TB_EdAbrir.ReadOnly := L;
         TB_EdNome_Interno.ReadOnly := L;
         TB_EdTitulo.ReadOnly := L;
         TB_EdBanco.ReadOnly  := L;
         TB_EdFiltroInicial.ReadOnly := L;
         TB_EdFiltroMestre.ReadOnly := L;
         TB_EdOrdemInicial.ReadOnly := L;
         if Pagina_Tabela.Enabled then
         begin
           TB_EdNome.SelectAll;
           TB_EdNome.SetFocus;
         end;  
       end;
    2: begin
         TabSet1.TabIndex := 0;
         NoPrincipal.PageIndex   := TabSet1.TabIndex;
         BtnAcima.Enabled        := False;
         BtnAbaixo.Enabled       := False;
         CP_EdNome.Color         := Cor;
         if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 0 then
         begin
           CP_EdTipo.Color         := Cor;
           CP_EdTamanho.Color      := Cor;
           CP_EdEdicao.Color       := Cor;
           CP_EdMascara.Color      := Cor;
           CP_EdAjuda.Color        := Cor;
           CP_EdPadrao.Color       := Cor;
           CP_EdValidacao.Color    := Cor;
           CP_EdValidos.Color      := Cor;
           CP_EdSequencia.Color    := Cor;
           CP_EdMsgErro.Color      := Cor;
           CP_EdTab_Pesquisa.Color := Cor;
           CP_EdPreValidacao.Color := Cor;
           CP_EdTipoPre.Color      := Cor;
         end;
         CP_EdTitulo.Color       := Cor;
         CP_EdIndice.Color       := Cor;
         Pagina0.Enabled         := not L;
         Pagina1.Enabled         := not L;
         CP_EdNome.ReadOnly      := L;
         if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 0 then
         begin
           CP_EdTipo.Enabled         := True;
           CP_EdChave.Enabled        := True;
           CP_EdTamanho.Enabled      := True;
           CP_EdCalculado.Enabled    := True;
           CP_EdEdicao.Enabled       := True;
           CP_EdMascara.Enabled      := True;
           CP_EdAjuda.Enabled        := True;
           CP_EdPadrao.Enabled       := True;
           CP_EdValidacao.Enabled    := True;
           CP_EdValidos.Enabled      := True;
           CP_EdSequencia.Enabled    := True;
           CP_EdSempreAtribui.Enabled:= True;
           CP_EdMsgErro.Enabled      := True;
           CP_EdTab_Pesquisa.Enabled := True;
           CP_EdPreValidacao.Enabled := True;
           CP_EdTipoPre.Enabled      := True;
           CP_EdLimparCampo.Enabled  := True;

           CP_EdChaveExit(Self);
           CP_EdEdicaoExit(Self);
           CP_EdSequenciaExit(Self);

           CP_EdTipo.ReadOnly         := L;
           CP_EdChave.ReadOnly        := L;
           CP_EdTamanho.ReadOnly      := L;
           CP_EdCalculado.ReadOnly    := L;
           CP_EdEdicao.ReadOnly       := L;
           CP_EdMascara.ReadOnly      := L;
           CP_EdAjuda.ReadOnly        := L;
           CP_EdPadrao.ReadOnly       := L;
           CP_EdValidacao.ReadOnly    := L;
           CP_EdValidos.ReadOnly      := L;
           CP_EdSequencia.ReadOnly    := L;
           CP_EdSempreAtribui.ReadOnly:= L;
           CP_EdMsgErro.ReadOnly      := L;
           CP_EdTab_Pesquisa.ReadOnly := L;
           CP_EdPreValidacao.ReadOnly := L;
           CP_EdTipoPre.ReadOnly      := L;
           CP_EdLimparCampo.ReadOnly  := L;
         end
         else
         begin
           CP_EdTipo.Enabled         := False;
           CP_EdChave.Enabled        := False;
           CP_EdTamanho.Enabled      := False;
           CP_EdCalculado.Enabled    := False;
           CP_EdEdicao.Enabled       := False;
           CP_EdMascara.Enabled      := False;
           CP_EdAjuda.Enabled        := False;
           CP_EdPadrao.Enabled       := False;
           CP_EdValidacao.Enabled    := False;
           CP_EdValidos.Enabled      := False;
           CP_EdSequencia.Enabled    := False;
           CP_EdSempreAtribui.Enabled:= False;
           CP_EdMsgErro.Enabled      := False;
           CP_EdTab_Pesquisa.Enabled := False;
           CP_EdPreValidacao.Enabled := False;
           CP_EdTipoPre.Enabled      := False;
           CP_EdLimparCampo.Enabled  := False;
         end;
         CP_EdTitulo.ReadOnly       := L;
         CP_EdIndice.ReadOnly       := L;
         CP_EdInvisivel.ReadOnly    := L;
         if Pagina0.Enabled then
         begin
           CP_EdNome.SelectAll;
           CP_EdNome.SetFocus;
         end;
       end;
    3: begin
         BtnInserirCmp.Enabled   := not L;
         BtnExcluirCmp.Enabled   := not L;
         BtnMoveParaCima.Enabled := not L;
         BtnMoveParaBaixo.Enabled:= not L;
         ID_EdTitulo.Color := Cor;
         CamposOrigem.Color := Cor;
         CamposIndices.Color := Cor;
         ID_EdTitulo.ReadOnly    := L;
         ID_EdCrescente.ReadOnly := L;
         ID_EdTitulo.SelectAll;
         ID_EdTitulo.SetFocus;
       end;
    4: begin
         PgIntegridade.Enabled := not L;
         IT_EdTitulo_i.Color := Cor;
         IT_EdTipo.Color := Cor;
         IT_EdTab_Estrangeira.Color := Cor;
         IT_EdTitulo_i.ReadOnly := L;
         IT_EdTipo.ReadOnly := L;
         IT_EdTab_Estrangeira.ReadOnly := L;
         if PgIntegridade.Enabled then
         begin
           IT_EdTitulo_i.SelectAll;
           IT_EdTitulo_i.SetFocus;
         end;
       end;
    5: begin
         PgProcessos.Enabled := not L;
         PR_EdTitulo_i.Color := Cor;
         PR_EdTipo.Color := Cor;
         PR_EdTab_Alvo.Color := Cor;
         PR_EdTitulo_i.ReadOnly := L;
         PR_EdTipo.ReadOnly := L;
         PR_EdTab_Alvo.ReadOnly := L;
         if PgProcessos.Enabled then
         begin
           PR_EdTitulo_i.SelectAll;
           PR_EdTitulo_i.SetFocus;
         end;
       end;
  end;
end;

procedure TFormEstruturas.FormShow(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
  Modificou := False;
  Campos_Chave := TStringList.Create;
  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.ChaveIndice := 'nome';

  TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
  TabGlobal_i.DCAMPOST.ChaveIndice := 'NUMERO,SEQUENCIA';

  TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DCASCATAT.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DRESTRITAT.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DBDADOS.First;
  TabGlobal_i.DTABELAS.First;
  TabGlobal_i.DCAMPOST.First;
  TabGlobal_i.DINDICEST.First;
  TabGlobal_i.DRELACIONA.First;
  TabGlobal_i.DCASCATAT.First;
  TabGlobal_i.DRESTRITAT.First;
  TabGlobal_i.DPROCESSOS.First;

  Gr_Compat.Visible := False;

  DataSource2.DataSet := TabGlobal_i.DTABELAS;
  DataSource3.DataSet := TabGlobal_i.DCAMPOST;
  DataSource4.DataSet := TabGlobal_i.DINDICEST;
  DataSource5.DataSet := TabGlobal_i.DRELACIONA;
  DataSource6.DataSet := TabGlobal_i.DPROCESSOS;

  TabGlobal_i.DBDADOS.AssociaChaveEstrangeira(TB_EdBanco, TabGlobal_i.DBDADOS.NUMERO.Nome,
                                  [TabGlobal_i.DBDADOS.NOME.Nome]);

  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Clear;
  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Add('Alfanumérico');
  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Add('Número Inteiro');
  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Add('Número Fracionário');
  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Add('Data');
  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Add('Memo');
  TabGlobal_i.DCAMPOST.TIPO.DescValorValido.Add('Imagem');

  TabGlobal_i.DCAMPOST.EDICAO.DescValorValido.Clear;
  TabGlobal_i.DCAMPOST.EDICAO.DescValorValido.Add('Edição Padrão ( Edit )');
  TabGlobal_i.DCAMPOST.EDICAO.DescValorValido.Add('Lista Interna ( Combo Drop )');
  TabGlobal_i.DCAMPOST.EDICAO.DescValorValido.Add('Optativo ( Rádio Buttom )');
  TabGlobal_i.DCAMPOST.EDICAO.DescValorValido.Add('Conferência ( Check Box )');
  TabGlobal_i.DCAMPOST.EDICAO.DescValorValido.Add('Lista Externa ( Estrangeira )');

  TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.DescValorValido.Clear;
  TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.DescValorValido.Add('Invisível');
  TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.DescValorValido.Add('Não editável');

  TabGlobal_i.DRELACIONA.TIPO.DescValorValido.Clear;
  TabGlobal_i.DRELACIONA.TIPO.DescValorValido.Add('Relacionamento');
  TabGlobal_i.DRELACIONA.TIPO.DescValorValido.Add('Exclusão Restrita');
  TabGlobal_i.DRELACIONA.TIPO.DescValorValido.Add('Exclusão em Cascata');

  TabGlobal_i.DPROCESSOS.TIPO.DescValorValido.Clear;
  TabGlobal_i.DPROCESSOS.TIPO.DescValorValido.Add('Processo Direto/Inverso');
  TabGlobal_i.DPROCESSOS.TIPO.DescValorValido.Add('Lançamentos');
  TabGlobal_i.DPROCESSOS.TIPO.DescValorValido.Add('Processo Avulso/Direto');
  TabGlobal_i.DPROCESSOS.TIPO.DescValorValido.Add('Processo Avulso/Inverso');
  TabGlobal_i.DPROCESSOS.TIPO.DescValorValido.Add('Lançamentos Avulso');

  TB_EdGlobal.ValueUnchecked := '0';
  TB_EdGlobal.ValueChecked   := '1';

  TB_EdAbrir.ValueUnchecked := '0';
  TB_EdAbrir.ValueChecked   := '1';

  CP_EdChave.ValueUnchecked := '0';
  CP_EdChave.ValueChecked   := '1';

  CP_EdCalculado.ValueUnchecked := '0';
  CP_EdCalculado.ValueChecked   := '1';

  CP_EdInvisivel.ValueUnchecked := '0';
  CP_EdInvisivel.ValueChecked   := '1';

  CP_EdLimparCampo.ValueUnchecked := '0';
  CP_EdLimparCampo.ValueChecked   := '1';

  ID_EdCrescente.ValueUnchecked := '0';
  ID_EdCrescente.ValueChecked   := '1';

  CP_EdSempreAtribui.ValueUnchecked := '0';
  CP_EdSempreAtribui.ValueChecked   := '1';

  TabSet1.TabIndex := 0;
  NoPrincipal.PageIndex := TabSet1.TabIndex;

  if FileExists(Projeto.PastaGerador + 'Validacao.Lst') then
    CP_EdValidacao.Items.LoadFromFile(Projeto.PastaGerador + 'Validacao.Lst');

  Escolha_Atual := 0;
  AtualizaLista(1);
  Habilita_Escolha(1);
  GridTabelaClick(GridTabela);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormEstruturas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    {Atua como a tecla TAB}
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormEstruturas.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormEstruturas.BtnNovoClick(Sender: TObject);
Var
  Seq, Seq2, I: Integer;
  ListaCmp: TStringList;
begin
  if not BtnNovo.Enabled then exit;
  Modificou := True;
  case Escolha_Atual of
    1: begin
         if FREDT then
           if GridTabela.Items.Count >= 12 then
           begin
             Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de 12 '+^M+'Tabelas ...',modAdvertencia,[ModOk]);
             GridTabela.SetFocus;
             exit;
           end;
         TabGlobal_i.DTABELAS.DisableControls;
         TabGlobal_i.DTABELAS.Filtro := '';
         TabGlobal_i.DTABELAS.ChaveIndice := 'numero';
         TabGlobal_i.DTABELAS.AtualizaSql;
         TabGlobal_i.DTABELAS.Last;
         Seq := TabGlobal_i.DTABELAS.NUMERO.Conteudo + 1;
         TabGlobal_i.DTABELAS.ChaveIndice := 'nome';
         TabGlobal_i.DTABELAS.AtualizaSql;
         TabGlobal_i.DTABELAS.EnableControls;
         Nome_Original_Tab := '';
         TabGlobal_i.DTABELAS.Inclui(Nil);
         TabGlobal_i.DTABELAS.NUMERO.Conteudo := Seq;
         TabGlobal_i.DTABELAS.GLOBAL.Conteudo := 1;
         TabGlobal_i.DTABELAS.ABRIR_TABELA.Conteudo := 1;
         GridTabela.Items.Add('');
         GridTabela.ItemIndex := GridTabela.Items.Count-1;
         Habilita_Campos(True);
       end;
    2: begin
         TabSet1.TabIndex := 0;
         NoPrincipal.PageIndex := TabSet1.TabIndex;
         TabGlobal_i.DCAMPOST.DisableControls;
         TabGlobal_i.DCAMPOST.Last;
         Seq := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo + 1;
         TabGlobal_i.DCAMPOST.First;
         if TabGlobal_i.DCAMPOST.Eof then
           Seq2 := 0
         else
           Seq2 := RetornaAutoIncremento(TabGlobal_i.DCAMPOST,'INDICE_CONSULTA','NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo));
         TabGlobal_i.DCAMPOST.EnableControls;
         TabGlobal_i.DCAMPOST.Inclui(Nil);
         TabGlobal_i.DCAMPOST.NUMERO.Conteudo             := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
         TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo          := Seq;
         TabGlobal_i.DCAMPOST.TIPO.Conteudo               := 1;
         TabGlobal_i.DCAMPOST.EDICAO.Conteudo             := 1;
         TabGlobal_i.DCAMPOST.CHAVE.Conteudo              := 0;
         TabGlobal_i.DCAMPOST.CALCULADO.Conteudo          := 0;
         TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo     := 0;
         TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo     := 0;
         TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo          := 0;
         TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := 1;
         TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo       := 0;
         TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo    := Seq2;
         TabGlobal_i.DCAMPOST.EXTRA.Conteudo              := 0;
         GridCampos.Items.Add('');
         Campos_Chave.Add('0');
         GridCampos.ItemIndex := GridCampos.Items.Count-1;
         Habilita_Campos(True);
       end;
    3: begin
         TabGlobal_i.DINDICEST.DisableControls;
         TabGlobal_i.DINDICEST.Last;
         Seq := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo + 1;
         TabGlobal_i.DINDICEST.EnableControls;
         TabGlobal_i.DINDICEST.Inclui(Nil);
         TabGlobal_i.DINDICEST.NUMERO.Conteudo     := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
         TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo  := Seq;
         TabGlobal_i.DINDICEST.CRESCENTE.Conteudo  := 1;
         CamposIndices.Items.Clear;
         ListaCmp := TStringList.Create;
         StringToArray(TabGlobal_i.DINDICEST.CAMPOST.Conteudo,';',ListaCmp);
         for I:=0 to ListaCmp.Count-1 do
           CamposIndices.Items.AddObject(ListaCmp[I],TObject(1));
         ListaCmp.Free;
         GridIndices.Items.Add('');
         GridIndices.ItemIndex := GridIndices.Items.Count-1;
         Habilita_Campos(True);
       end;
    4: begin
         if FREDT then
           if GridIntegridade.Items.Count >= 03 then
           begin
             Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de 03 '+^M+'Integridades/Relacionamentos ...',modAdvertencia,[ModOk]);
             GridIntegridade.SetFocus;
             exit;
           end;
         TabGlobal_i.DRELACIONA.DisableControls;
         TabGlobal_i.DRELACIONA.Last;
         Seq := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo + 1;
         TabGlobal_i.DRELACIONA.EnableControls;
         TabGlobal_i.DRELACIONA.Inclui(Nil);
         TabGlobal_i.DRELACIONA.NUMERO.Conteudo     := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
         TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo  := Seq;
         GridIntegridade.Items.Add('');
         GridIntegridade.ItemIndex := GridIntegridade.Items.Count-1;
         Habilita_Campos(True);
       end;
    5: begin
         if FREDT then
           if GridProcessos.Items.Count >= 02 then
           begin
             Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de 02 '+^M+'Processos/Lançamentos ...',modAdvertencia,[ModOk]);
             GridProcessos.SetFocus;
             exit;
           end;
         TabGlobal_i.DPROCESSOS.DisableControls;
         TabGlobal_i.DPROCESSOS.Last;
         Seq := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo + 1;
         TabGlobal_i.DPROCESSOS.EnableControls;
         TabGlobal_i.DPROCESSOS.Inclui(Nil);
         TabGlobal_i.DPROCESSOS.NUMERO.Conteudo     := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
         TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo  := Seq;
         GridProcessos.Items.Add('');
         GridProcessos.ItemIndex := GridProcessos.Items.Count-1;
         Habilita_Campos(True);
       end;
  end;
end;

procedure TFormEstruturas.Atualiza_Nome_Tabela;
var
  Nome_Atual: String;
begin
  Nome_Atual := Trim(TabGlobal_i.DTABELAS.NOME.Conteudo);
  if Trim(Nome_Original_Tab) = '' then exit;
  if Trim(Nome_Original_Tab) = Nome_Atual then exit;
  TabGlobal_i.DCAMPOST.Filtro := '';
  TabGlobal_i.DCAMPOST.AtualizaSql;
  TabGlobal_i.DRELACIONA.Filtro := '';
  TabGlobal_i.DRELACIONA.AtualizaSql;
  TabGlobal_i.DPROCESSOS.Filtro := '';
  TabGlobal_i.DPROCESSOS.AtualizaSql;

  TabGlobal_i.DCAMPOST.First;
  while not TabGlobal_i.DCAMPOST.Eof do
  begin
    if (UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo)) = UpperCase(Trim(Nome_Original_Tab))) then
    begin
      TabGlobal_i.DCAMPOST.Modifica;
      TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo := Nome_Atual;
      TabGlobal_i.DCAMPOST.Salva;
    end;
    if (UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)) = UpperCase(Trim(Nome_Original_Tab))) then
    begin
      TabGlobal_i.DCAMPOST.Modifica;
      TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo := Nome_Atual;
      TabGlobal_i.DCAMPOST.Salva;
    end;
    if (UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo)) = UpperCase(Trim(Nome_Original_Tab))) then
    begin
      TabGlobal_i.DCAMPOST.Modifica;
      TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo := Nome_Atual;
      TabGlobal_i.DCAMPOST.Salva;
    end;
    TabGlobal_i.DCAMPOST.Next;
  end;

  TabGlobal_i.DRELACIONA.First;
  while not TabGlobal_i.DRELACIONA.Eof do
  begin
    if (UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)) = UpperCase(Trim(Nome_Original_Tab))) then
    begin
      TabGlobal_i.DRELACIONA.Modifica;
      TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo := Nome_Atual;
      TabGlobal_i.DRELACIONA.Salva;
    end;
    TabGlobal_i.DRELACIONA.Next;
  end;

  TabGlobal_i.DPROCESSOS.First;
  while not TabGlobal_i.DPROCESSOS.Eof do
  begin
    if (UpperCase(Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)) = UpperCase(Trim(Nome_Original_Tab))) then
    begin
      TabGlobal_i.DPROCESSOS.Modifica;
      TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo := Nome_Atual;
      TabGlobal_i.DPROCESSOS.Salva;
    end;
    TabGlobal_i.DPROCESSOS.Next;
  end;

  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (UpperCase(Trim(TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo)) = UpperCase(Trim(Nome_Original_Tab))) then
    begin
      TabGlobal_i.DTABELAS.Modifica;
      TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo := Nome_Atual;
      TabGlobal_i.DTABELAS.Salva;
    end;
    TabGlobal_i.DTABELAS.Next;
  end;
end;

procedure TFormEstruturas.BtnSalvarClick(Sender: TObject);
var
  Pesquisa: String;
  Qtd1, Qtd2: Integer;
  xtipo, xedicao, xtamanho: Integer;
  xmascara, xajuda, xvalidos, xdescricao: string;
begin
  Modificou := True;
  case Escolha_Atual of
    1: begin
         Pesquisa := TabGlobal_i.DTABELAS.NOME.Conteudo;
         if TControl(Sender).Tag = 10 then
         begin
           if (Trim(TB_EdNome.Text) = '') then
           begin
              Mensagem('Necessário informar Nome !',ModAdvertencia,[ModOk]);
              TB_EdNome.SetFocus;
              exit;
           end;
           if (PTabela(TabGlobal_i.DTABELAS,['<>NUMERO','UPPER(NOME)'],[TabGlobal_i.DTABELAS.NUMERO.Conteudo,UpperCase(TabGlobal_i.DTABELAS.NOME.Conteudo)])) then
           begin
             Mensagem('Nome já cadastrado !',ModAdvertencia,[ModOk]);
             TB_EdNome.SetFocus;
             exit;
           end;
           if (TB_EdBanco.Text = '') then
           begin
             Mensagem('Necessário informar Banco de Dados !',ModAdvertencia,[ModOk]);
             TB_EdBanco.SetFocus;
             Exit;
           end;
           if UpperCase(Trim(TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo)) = UpperCase(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)) then
             TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo := '';
           TabGlobal_i.DTABELAS.Salva;
           Atualiza_Nome_Tabela;
         end
         else
         begin
           if TabGlobal_i.DTABELAS.Inclusao then Pesquisa := '#';
           TabGlobal_i.DTABELAS.Cancela;
         end;
         AtualizaLista(Escolha_Atual);
         if Pesquisa <> '#' then
           TabGlobal_i.DTABELAS.Locate('NOME',Pesquisa,[loCaseInsensitive, loPartialKey]);
         GridTabela.ItemIndex := GridTabela.Items.IndexOf(TabGlobal_i.DTABELAS.NOME.Conteudo);
         Habilita_Campos(False);
         GridTabelaClick(GridTabela);
         GridTabela.SetFocus;
         TB_EdNomeChange(Self);
       end;
    2: begin
         TabSet1.TabIndex := 0;
         NoPrincipal.PageIndex := TabSet1.TabIndex;
         Pesquisa := TabGlobal_i.DCAMPOST.NOME.Conteudo;
         if TControl(Sender).Tag = 10 then
         begin
           if not ValidaNomeCampo(TabGlobal_i.DCAMPOST.NOME.Conteudo, TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo) then
           begin
             CP_EdNome.SelectAll;
             CP_EdNome.SetFocus;
             exit;
           end;
           if TabGlobal_i.DCAMPOST.TAMANHO.Conteudo < 1 then
           begin
             Mensagem('Necessário informar Tamanho !',ModAdvertencia,[ModOk]);
             CP_EdTamanho.SetFocus;
             Exit;
           end;
           if (TabGlobal_i.DCAMPOST.EDICAO.Conteudo > 1) and (TabGlobal_i.DCAMPOST.EDICAO.Conteudo < 5) then
           begin
             Qtd1 := ContaOcorrencia(';',TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text);
             Qtd2 := ContaOcorrencia(';',TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text);
             if TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 4 then
             begin
               if not ((Qtd1 = 1) and (Qtd2 = 1)) then
               begin
                 Mensagem('Informe 2 (dois) "Valores Válidos" !',ModAdvertencia,[ModOk]);
                 TabSet1.TabIndex := 1;
                 NoPrincipal.PageIndex := TabSet1.TabIndex;
                 CP_EdValidos.SetFocus;
                 Exit;
               end;
             end
             else
             begin
               if (Qtd1 <> Qtd2) or (Trim(TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text) = '') then
               begin
                 Mensagem('Quantidade de "Valores Válidos" está incorreta !',ModAdvertencia,[ModOk]);
                 TabSet1.TabIndex := 1;
                 NoPrincipal.PageIndex := TabSet1.TabIndex;
                 CP_EdValidos.SetFocus;
                 Exit;
               end;
             end;
           end;
           if TabGlobal_i.DPROJETO.BDADOS.Conteudo <= 04 then
             if (TabGlobal_i.DCAMPOST.TAMANHO.Conteudo >= 10) and
                (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2) then
             begin
               TabGlobal_i.DCAMPOST.TIPO.Conteudo := 3;
               Mensagem('Tamanho não suportado para campo do tipo "Inteiro" !'+^M+^M+'O Campo foi alterado de "Inteiro" -> "Fracionário" ...',modAdvertencia,[modOk]);
             end;
           if (TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 1) or
              (TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 5) then
           begin
             TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text := '';
             TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text := '';
           end;
           TabGlobal_i.DCAMPOST.Salva;
           TabGlobal_i.DCAMPOST.DisableControls;
           xtipo := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
           xtamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
           xedicao := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
           xmascara := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
           xajuda := TabGlobal_i.DCAMPOST.AJUDA.Conteudo;
           xvalidos := TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text;
           xdescricao := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text;
           TabGlobal_i.DCAMPOST.Filtro := 'EXTRA = 1 AND TAB_EXTRA = '+#39+TabGlobal_i.DTABELAS.NOME.Conteudo+#39+' AND CAMPO_EXTRA = '+#39+TabGlobal_i.DCAMPOST.NOME.Conteudo+#39;
           TabGlobal_i.DCAMPOST.AtualizaSql;
           TabGlobal_i.DCAMPOST.First;
           while not TabGlobal_i.DCAMPOST.Eof do
           begin
             TabGlobal_i.DCAMPOST.Modifica;
             TabGlobal_i.DCAMPOST.TIPO.Conteudo      := xtipo;
             TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := xtamanho;
             TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := xedicao;
             TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := xmascara;
             TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := xajuda;
             TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text   := xvalidos;
             TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text := xdescricao;
             TabGlobal_i.DCAMPOST.Salva;
             TabGlobal_i.DCAMPOST.Next;
           end;
           TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
           TabGlobal_i.DCAMPOST.AtualizaSql;
           TabGlobal_i.DCAMPOST.EnableControls;
         end
         else
         begin
           if TabGlobal_i.DCAMPOST.Inclusao then Pesquisa := '#';
           TabGlobal_i.DCAMPOST.Cancela;
         end;
         AtualizaLista(Escolha_Atual);
         if Pesquisa <> '#' then
           TabGlobal_i.DCAMPOST.Locate('NOME',Pesquisa,[loCaseInsensitive, loPartialKey]);
         GridCampos.ItemIndex := GridCampos.Items.IndexOf(TabGlobal_i.DCAMPOST.NOME.Conteudo);
         Habilita_Campos(False);
         if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
         begin
           CP_EdChave.Enabled := True;

         end;
         GridCampos.SetFocus;
         BtnAcima.Enabled   := True;
         BtnAbaixo.Enabled  := True;
         BtnAcima.Hint := 'Mover campo para cima';
         BtnAbaixo.Hint := 'Mover campo para baixo';
       end;
    3: begin
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover índice para cima';
         BtnAbaixo.Hint := 'Mover índice para baixo';
         Pesquisa := TabGlobal_i.DINDICEST.TITULO_I.Conteudo;
         if TControl(Sender).Tag = 10 then
           TabGlobal_i.DINDICEST.Salva
         else
         begin
           if TabGlobal_i.DINDICEST.Inclusao then Pesquisa := '#';
           TabGlobal_i.DINDICEST.Cancela;
         end;
         AtualizaLista(Escolha_Atual);
         if Pesquisa <> '#' then
           TabGlobal_i.DINDICEST.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
         GridIndices.ItemIndex := GridIndices.Items.IndexOf(TabGlobal_i.DINDICEST.TITULO_I.Conteudo);
         Habilita_Campos(False);
         GridIndices.SetFocus;
       end;
    4: begin
         Pesquisa := TabGlobal_i.DRELACIONA.TITULO_I.Conteudo;
         if TControl(Sender).Tag = 10 then
         begin
           if (TabGlobal_i.DRELACIONA.TIPO.Conteudo < 1) then
           begin
             Mensagem('Necessário informar Tipo !',ModAdvertencia,[ModOk]);
             IT_EdTipo.SetFocus;
             exit;
           end;
           if (Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo) = '') then
           begin
             Mensagem('Necessário informar Relacionamento !',ModAdvertencia,[ModOk]);
             IT_EdTab_Estrangeira.SetFocus;
             exit;
           end;
           TabGlobal_i.DRELACIONA.Salva;
         end
         else
         begin
           if TabGlobal_i.DRELACIONA.Inclusao then Pesquisa := '#';
           TabGlobal_i.DRELACIONA.Cancela;
         end;
         AtualizaLista(Escolha_Atual);
         if Pesquisa <> '#' then
           TabGlobal_i.DRELACIONA.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
         GridIntegridade.ItemIndex := GridIntegridade.Items.IndexOf(TabGlobal_i.DRELACIONA.TITULO_I.Conteudo);
         Habilita_Campos(False);
         GridIntegridade.SetFocus;
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover relacionamento para cima';
         BtnAbaixo.Hint := 'Mover relacionamento para baixo';
       end;
    5: begin
         Pesquisa := TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo;
         if TControl(Sender).Tag = 10 then
         begin
           if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo < 1) then
           begin
             Mensagem('Necessário informar Tipo !',ModAdvertencia,[ModOk]);
             PR_EdTipo.SetFocus;
             exit;
           end;
           if (Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo) = '') then
           begin
             Mensagem('Necessário informar Processo/Lançamento !',ModAdvertencia,[ModOk]);
             PR_EdTab_Alvo.SetFocus;
             exit;
           end;
           TabGlobal_i.DPROCESSOS.Salva;
         end
         else
         begin
           if TabGlobal_i.DPROCESSOS.Inclusao then Pesquisa := '#';
           TabGlobal_i.DPROCESSOS.Cancela;
         end;
         AtualizaLista(Escolha_Atual);
         if Pesquisa <> '#' then
           TabGlobal_i.DPROCESSOS.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
         GridProcessos.ItemIndex := GridProcessos.Items.IndexOf(TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo);
         Habilita_Campos(False);
         GridProcessos.SetFocus;
         BtnACima.Enabled  := True;
         BtnABaixo.Enabled := True;
         BtnAcima.Hint := 'Mover processo para cima';
         BtnAbaixo.Hint := 'Mover processo para baixo';
       end;
  end;
end;

procedure TFormEstruturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Achou, Achou1: Boolean;
  Pesquisa: String;
begin
  if BtnSalvar.Enabled then
  begin
    Mensagem('Atributos está em modo de edição !',ModInformacao,[modOk]);
    PageControl2.SetFocus;
    Action := caNone;
  end
  else
  begin
    if FREDT then
      if GridTabela.Items.Count > 12 then
      begin
        Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de 12 '+^M+'Tabelas ...',modAdvertencia,[ModOk]);
        exit;
      end;
    if C_CRACK then
    begin
      Mensagem(MSG_CRACK,ModErro,[ModOk]);
      exit;
    end;
    if (Modificou = False) and (Regerar.Checked) then
      Modificou := True;
    if Modificou then
    begin
      TabGlobal_i.DBDADOS.DisableControls;
      TabGlobal_i.DTABELAS.DisableControls;
      TabGlobal_i.DCAMPOST.DisableControls;
      TabGlobal_i.DINDICEST.DisableControls;
      TabGlobal_i.DRELACIONA.DisableControls;
      TabGlobal_i.DRESTRITAT.DisableControls;
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Analisando tabelas ...';
      FormAguarde.Show;
      FormAguarde.GaugeProcesso.Min := 0;
      if GridTabela.Items.Count-1 > 0 then
        FormAguarde.GaugeProcesso.Max := GridTabela.Items.Count-1
      else
        FormAguarde.GaugeProcesso.Max := 0;
      FormAguarde.GaugeProcesso.Position := 0;
      try
        TabGlobal_i.DTABELAS.DisableControls;
        TabGlobal_i.DTABELAS.First;
        Achou1 := False;
        while (not TabGlobal_i.DTABELAS.Eof) and (not Achou1) do
        begin
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          achou := False;
          while (not TabGlobal_i.DCAMPOST.Eof) and (not Achou) do
          begin
            if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then Achou := True;
            TabGlobal_i.DCAMPOST.Next;
          end;
          if not Achou then
          begin
            Mensagem('Tabela: "'+TabGlobal_i.DTABELAS.NOME.Conteudo + '" está sem chave primária definida !',ModAdvertencia,[modOk]);
            if not Achou1 then
              Pesquisa := TabGlobal_i.DTABELAS.NOME.Conteudo;
            Achou1 := True;
          end;
          FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
          TabGlobal_i.DTABELAS.Next;
        end;
      finally
        TabGlobal_i.DTABELAS.EnableControls;
        FormAguarde.Free;
      end;
      TabGlobal_i.DBDADOS.EnableControls;
      TabGlobal_i.DTABELAS.EnableControls;
      TabGlobal_i.DCAMPOST.EnableControls;
      TabGlobal_i.DINDICEST.EnableControls;
      TabGlobal_i.DRELACIONA.EnableControls;
      TabGlobal_i.DRESTRITAT.EnableControls;
      if Achou1 then
      begin
        Action := caNone;
        GridTabela.ItemIndex := GridTabela.Items.IndexOf(Pesquisa);
        GridTabelaClick(GridTabela);
        GridTabela.SetFocus;
        exit;
      end;
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Gerando fontes ...';
      FormAguarde.Show;
      FormAguarde.GaugeProcesso.Min := 0;
      FormAguarde.GaugeProcesso.Max := 5;
      FormAguarde.GaugeProcesso.Position := 0;
      try
        TabGlobal_i.DBDADOS.DisableControls;
        TabGlobal_i.DTABELAS.DisableControls;
        TabGlobal_i.DCAMPOST.DisableControls;
        TabGlobal_i.DINDICEST.DisableControls;
        TabGlobal_i.DRELACIONA.DisableControls;
        TabGlobal_i.DRESTRITAT.DisableControls;
        Gera_BaseDados;
        FormAguarde.GaugeProcesso.Position := 1;
        Gera_CTabelas(True);
        FormAguarde.GaugeProcesso.Position := 2;
        Gera_CCalculos;
        FormAguarde.GaugeProcesso.Position := 3;
        Gera_Abertura;
        FormAguarde.GaugeProcesso.Position := 4;
        Gera_Adapter;
        FormAguarde.GaugeProcesso.Position := 5;
      finally
        FormAguarde.Free;
        TabGlobal_i.DBDADOS.EnableControls;
        TabGlobal_i.DTABELAS.EnableControls;
        TabGlobal_i.DCAMPOST.EnableControls;
        TabGlobal_i.DINDICEST.EnableControls;
        TabGlobal_i.DRELACIONA.EnableControls;
        TabGlobal_i.DRESTRITAT.EnableControls;
      end;
    end;
    Campos_Chave.Free;
  end;
end;

procedure TFormEstruturas.CP_EdTipoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
begin
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if TabGlobal_i.DCAMPOST.TIPO.DescValorValido[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DCAMPOST.TIPO.ValorValido[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DCAMPOST.TIPO.DescValorValido[Index]));
end;

procedure TFormEstruturas.CP_EdEdicaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
begin
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if TabGlobal_i.DCAMPOST.EDICAO.DescValorValido[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DCAMPOST.EDICAO.ValorValido[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DCAMPOST.EDICAO.DescValorValido[Index]));
end;

procedure TFormEstruturas.CP_EdTipoPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
begin
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.DescValorValido[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.ValorValido[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.DescValorValido[Index]));
end;

procedure TFormEstruturas.BtnExcluirClick(Sender: TObject);
var
  P: Integer;
begin
  if not BtnExcluir.Enabled then exit;
  Modificou := True;
  case Escolha_Atual of
    1: begin
         if not TabGlobal_i.DTABELAS.Eof then
           if Mensagem('Excluir Tabela ?'+^M+^M+TabGlobal_i.DTABELAS.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
           begin
             P := GridTabela.ItemIndex - 1;
             TabGlobal_i.DTABELAS.Exclui;
             AtualizaLista(Escolha_Atual);
             if (P < 0) or (P > GridTabela.Items.Count) then
               P := 0;
             GridTabela.ItemIndex := P;
             GridTabelaClick(GridTabela);
           end;
       end;
    2: begin
         if not TabGlobal_i.DCAMPOST.Eof then
           if Mensagem('Excluir Campo ?'+^M+^M+TabGlobal_i.DCAMPOST.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
           begin
             P := GridCampos.ItemIndex - 1;
             TabGlobal_i.DCAMPOST.Exclui;
             AtualizaLista(Escolha_Atual);
             if (P < 0) or (P > GridCampos.Items.Count) then
               P := 0;
             GridCampos.ItemIndex := P;
             GridCamposClick(GridCampos);
           end;
       end;
    3: begin
         if not TabGlobal_i.DINDICEST.Eof then
           if Mensagem('Excluir Índice ?'+^M+^M+TabGlobal_i.DINDICEST.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
           begin
             P := GridIndices.ItemIndex - 1;
             TabGlobal_i.DINDICEST.Exclui;
             AtualizaLista(Escolha_Atual);
             if (P < 0) or (P > GridIndices.Items.Count) then
               P := 0;
             GridIndices.ItemIndex := P;
             GridIndicesClick(GridIndices);
           end;
       end;
    4: begin
         if not TabGlobal_i.DRELACIONA.Eof then
           if Mensagem('Excluir Integridade/Relacionamento ?'+^M+^M+TabGlobal_i.DRELACIONA.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
           begin
             P := GridIntegridade.ItemIndex - 1;
             TabGlobal_i.DRELACIONA.Exclui;
             AtualizaLista(Escolha_Atual);
             if (P < 0) or (P > GridIntegridade.Items.Count) then
               P := 0;
             GridIntegridade.ItemIndex := P;
             GridIntegridadeClick(GridIntegridade);
           end;
       end;
    5: begin
         if not TabGlobal_i.DPROCESSOS.Eof then
           if Mensagem('Excluir Processo/Lançamento ?'+^M+^M+TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mryes then
           begin
             P := GridProcessos.ItemIndex - 1;
             TabGlobal_i.DPROCESSOS.Exclui;
             AtualizaLista(Escolha_Atual);
             if (P < 0) or (P > GridProcessos.Items.Count) then
               P := 0;
             GridProcessos.ItemIndex := P;
             PnProcessosClick(GridProcessos);
           end;
       end;
  end;
end;

procedure TFormEstruturas.TB_EdNomeExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  //if (not TB_EdNome.ReadOnly) and (Trim(TB_EdNome.Text) = '') then
  //begin
  //  Mensagem('Necessário informar Nome !',ModAdvertencia,[ModOk]);
  //  TB_EdNome.SetFocus;
  //  exit;
  //end;
  if (not TB_EdNome.ReadOnly) and (not ValidaNomeCampo(TB_EdNome.Text,TabGlobal_i.DTABELAS.NUMERO.Conteudo,True)) then
  begin
    TB_EdNome.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.FormCreate(Sender: TObject);
begin
  //CreateToolTips(Handle, Self);
end;

procedure TFormEstruturas.CP_EdNomeButtonClick(Sender: TObject);
var I,NrSel,QtLinhas: Integer;
    Titulo,Titulo2,Valor: String;
begin
  FormPrincipal.Texto.Lines.LoadFromFile(Projeto.PastaGerador + 'Campos.Tpl');
  FormListaEscolha := TFormListaEscolha.Create(Application);
  Try
    FormListaEscolha.ListaSelecao.Items.Clear;
    I := 0;
    QtLinhas := FormPrincipal.Texto.Lines.Count-1;
    while I <= QtLinhas do
    begin
     if Copy(FormPrincipal.Texto.Lines[I],01,06) = 'Numero' then
     begin
       Titulo := Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1])));
       Titulo2:= Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2])));
       FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[Titulo])+Titulo2);
     end;
     I := I + 12;
    end;
    FormListaEscolha.ShowModal;
  Finally
    NrSel := FormListaEscolha.NumeroSelecao;
    FormListaEscolha.Free;
  end;
  if NrSel <> -1 then
  begin
    I := NrSel;
    I := 11 * I +  I;
    TabGlobal_i.DCAMPOST.NOME.Conteudo      := Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1])));
    Valor := Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2])));
    if Valor = 'Alfanumérico' then
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 1
    else if Valor = 'Número Inteiro' then
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 2
    else if Valor = 'Número Fracionário' then
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 3
    else if Valor = 'Data' then
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 4
    else if Valor = 'Memo' then
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 5
    else if Valor = 'Imagem' then
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 6
    else
      TabGlobal_i.DCAMPOST.TIPO.Conteudo := 1;
    TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := StrToIntDef(Trim(Copy(FormPrincipal.Texto.Lines[I+3],Pos('=',FormPrincipal.Texto.Lines[I+3])+2,Length(FormPrincipal.Texto.Lines[I+3]))),0);
    Valor := Trim(Copy(FormPrincipal.Texto.Lines[I+4],Pos('=',FormPrincipal.Texto.Lines[I+4])+2,Length(FormPrincipal.Texto.Lines[I+4])));
    if Valor = 'Edição Padrão ( Edit )' then
      TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 1
    else if Valor = 'Lista Interna ( Combo Drop )' then
      TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 2
    else if Valor = 'Optativo ( Rádio Buttom )' then
      TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 3
    else if Valor = 'Conferência ( Check Box )' then
      TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 4
    else
      TabGlobal_i.DCAMPOST.EDICAO.Conteudo := 1;
    TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := Trim(Copy(FormPrincipal.Texto.Lines[I+5],Pos('=',FormPrincipal.Texto.Lines[I+5])+2,Length(FormPrincipal.Texto.Lines[I+5])));
    TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := Trim(Copy(FormPrincipal.Texto.Lines[I+6],Pos('=',FormPrincipal.Texto.Lines[I+6])+2,Length(FormPrincipal.Texto.Lines[I+6])));
    TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := Trim(Copy(FormPrincipal.Texto.Lines[I+7],Pos('=',FormPrincipal.Texto.Lines[I+7])+2,Length(FormPrincipal.Texto.Lines[I+7])));
    TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := Trim(Copy(FormPrincipal.Texto.Lines[I+8],Pos('=',FormPrincipal.Texto.Lines[I+8])+2,Length(FormPrincipal.Texto.Lines[I+8])));
    TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := Trim(Copy(FormPrincipal.Texto.Lines[I+9],Pos('=',FormPrincipal.Texto.Lines[I+9])+2,Length(FormPrincipal.Texto.Lines[I+9])));
    TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text   := Trim(Copy(FormPrincipal.Texto.Lines[I+10],Pos('=',FormPrincipal.Texto.Lines[I+10])+2,Length(FormPrincipal.Texto.Lines[I+10])));
    TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text := Trim(Copy(FormPrincipal.Texto.Lines[I+11],Pos('=',FormPrincipal.Texto.Lines[I+11])+2,Length(FormPrincipal.Texto.Lines[I+11])));
  end;
  FormPrincipal.Texto.Lines.Clear;
  CP_EdNome.SetFocus;
end;

procedure TFormEstruturas.CP_EdChaveExit(Sender: TObject);
begin
  if (TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1) or (TabGlobal_i.DCAMPOST.TIPO.Conteudo > 4) or
     (TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 5) then
  begin
    if TabGlobal_i.DCAMPOST.Modificacao or TabGlobal_i.DCAMPOST.Inclusao then
      TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := 0;
    CP_EdCalculado.Enabled := False;
  end
  else
    CP_EdCalculado.Enabled := True;
  BtnCalculo.Enabled := CP_EdCalculado.Checked;
  if (TabGlobal_i.DCAMPOST.TIPO.Conteudo > 1) and (TabGlobal_i.DCAMPOST.TIPO.Conteudo < 5) then
    CP_EdSequencia.Enabled := True
  else
  begin
    CP_EdSequencia.Enabled := False;
    if TabGlobal_i.DCAMPOST.Modificacao or TabGlobal_i.DCAMPOST.Inclusao then
    begin
      TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo := 0;
      TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo := 0;
    end;
  end;
  if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
  begin
    PnExtra.Caption := TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo + ' -> ' + TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo;
    PnExtra.Visible := True;
  end
  else
    PnExtra.Visible := False;
end;

procedure TFormEstruturas.CP_EdValidacaoEnter(Sender: TObject);
begin
  if (not CP_EdValidacao.ReadOnly) and
     (TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1) and
     (TabGlobal_i.DCAMPOST.Inclusao) and
     (Trim(TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo) = '') then
    TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := 'VALORNULO';
end;

procedure TFormEstruturas.CP_EdPadraoEnter(Sender: TObject);
begin
  if (not CP_EdPadrao.ReadOnly) and
     (TabGlobal_i.DCAMPOST.Inclusao) and
     (Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) = '') then
  begin
    if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
      TabGlobal_i.DCAMPOST.PADRAO.Conteudo := 'DataAtual'
    else if TabGlobal_i.DCAMPOST.MASCARA.Conteudo = '99:99:99' then
      TabGlobal_i.DCAMPOST.PADRAO.Conteudo := 'HoraAtual';
  end;
end;

procedure TFormEstruturas.CP_EdMascaraButtonClick(Sender: TObject);
Var
  Tamanho, I, qt_parcial, YI, TY, Maximo: Integer;
  rel_pict,rel_espelho,rel_xpict,xdecimal,rel_001,rel_002,Xrel_001: String;
  laco: Boolean;
begin
  Tamanho := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
  FormListaEscolha := TFormListaEscolha.Create(Application);
  Try
    FormListaEscolha.ListaSelecao.Items.Clear;
    if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
    begin
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['X*'])+'Aceita todos carac. maiúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['x*'])+'Aceita todos carac. minúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['A*'])+'Somente letras em maiúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['a*'])+'Somente letras em minúsculo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['9*'])+'Somente números (0 a 9)');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99:99:99'])+'HORA');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99999-999'])+'CEP');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['999.999.999-99'])+'CPF');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99.999.999/9999-99'])+'CNPJ');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['AAA-9999'])+'Placa de Veículo');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['(Z999)Z999-9999'])+'Telefone');
    end
    else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
    begin
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[ConstStr('9',Tamanho)])+'Zeros a esquerda visíveis');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[ConstStr('Z',Tamanho-1)+'9'])+'Zeros a esquerda não visíveis');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+ConstStr('9',Tamanho)])+'Zeros a esquerda visíveis');
      FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+ConstStr('Z',Tamanho-1)+'9'])+'Zeros a esquerda não visíveis');
    end
    else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3 then
    begin
      if tamanho = 1 then
      begin
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['Z'])+'Fracionário positivo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-Z'])+'Fracionário negativo');
      end
      else if tamanho = 2 then
      begin
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['9,9'])+'Fracionário positivo');
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-9,9'])+'Fracionário negativo');
      end
      else
      begin
        for Ty := 1 to 2 do
        begin
          rel_xpict  :=ConstStr('Z',tamanho-2)+'99';
          rel_espelho:='';
          maximo     := 1;
          for I:=1 to tamanho do
            if (Length(Copy(rel_xpict,1,tamanho-I)) > 0) and
               (maximo <= 4) then
            begin
              inc(maximo);
              rel_espelho:=Copy(rel_xpict,1,tamanho-I)+','+Copy(rel_xpict,tamanho-I+1,255);
              laco := True;
              while laco do
                if Pos(',Z',rel_espelho) > 0 then
                  rel_espelho:=TrocaString(rel_espelho,',Z',',9',[rfReplaceAll])
                else
                  laco := False;
              xdecimal   :=Copy(rel_espelho,Pos(',',rel_espelho),255);
              xdecimal   :=TrocaString(xdecimal,'Z','9',[rfReplaceAll]);
              rel_espelho:=Copy(rel_espelho,01,Pos(',',rel_espelho)-1)+xdecimal;
              rel_002    :=Copy(rel_espelho,01,Pos(',',rel_espelho)-1);
              rel_001    :='';
              qt_parcial :=0;
              for YI:=Length(rel_002) downto 1 do
              begin
                rel_001 := rel_001 + Copy(rel_002,YI,01);
                Inc(qt_parcial);
                if qt_parcial = 3 then
                begin
                  rel_001    := rel_001 + '.';
                  qt_parcial := 0;
                end;
              end;
              Xrel_001 := '';
              for YI:=Length(rel_001) downto 1 do
                Xrel_001 := Xrel_001 + Copy(rel_001,YI,01);
              rel_001 := Xrel_001;
              if rel_001[1] = '.' then
                rel_001 := Copy(rel_001,02,255);
              if copy(rel_001,Length(rel_001),01) = 'Z' then
                rel_001 := copy(rel_001,01,Length(rel_001)-1) + '9';
              rel_espelho:=rel_001+xdecimal;
              if TY = 1 then
                FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',[rel_espelho])+'Fracionário positivo')
              else
                FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['-'+rel_espelho])+'Fracionário negativo');
            end;
        end;
      end;
    end
    else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
    begin
      if TabGlobal_i.DPROJETO.FORMATODATA.Conteudo = 1 then
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99/99/9999'])+'Formato século ativo')
      else
        FormListaEscolha.ListaSelecao.Items.Add(Format('%-40s',['99/99/99'])+'Formato século não ativo');
    end
    else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 5 then
    begin
    end
    else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 6 then
    begin
    end;
    FormListaEscolha.ShowModal;
  Finally
    if FormListaEscolha.NumeroSelecao >= 0 then
      TabGlobal_i.DCAMPOST.MASCARA.Conteudo := Trim(Copy(FormListaEscolha.ListaSelecao.Items[FormListaEscolha.NumeroSelecao],01,20));
    FormListaEscolha.Free;
  end;
end;

procedure TFormEstruturas.BtnAcimaClick(Sender: TObject);
var
  Atual,Anterior: Integer;
  Pesquisa: String;
  Tem_Calculo: Boolean;
begin
  if Escolha_Atual = 2 then
  begin
    if TabGlobal_i.DCAMPOST.Eof then exit;
    Modificou := True;
    BtnAcima.Enabled := False;
    TabGlobal_i.DCAMPOST.DisableControls;
    Pesquisa := TabGlobal_i.DCAMPOST.NOME.Conteudo;
    Atual := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
    TabGlobal_i.DCAMPOST.Modifica;
    TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DCAMPOST.Salva;

    TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = '+IntToStr(Atual);
    TabGlobal_i.DCALCULADOS.AtualizaSql;
    TabGlobal_i.DCALCULADOS.First;
    Tem_Calculo := False;
    if not TabGlobal_i.DCALCULADOS.Eof then
    begin
      TabGlobal_i.DCALCULADOS.Modifica;
      TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := 9999;
      TabGlobal_i.DCALCULADOS.Salva;
      Tem_Calculo := True;
    end;

    TabGlobal_i.DCAMPOST.Prior;
    if not TabGlobal_i.DCAMPOST.Bof then
      Anterior := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DCAMPOST.Last;
      Anterior := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DCAMPOST.Modifica;
    TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DCAMPOST.Salva;

    TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = '+IntToStr(Anterior);
    TabGlobal_i.DCALCULADOS.AtualizaSql;
    TabGlobal_i.DCALCULADOS.First;
    if not TabGlobal_i.DCALCULADOS.Eof then
    begin
      TabGlobal_i.DCALCULADOS.Modifica;
      TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := Atual;
      TabGlobal_i.DCALCULADOS.Salva;
    end;

    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DCAMPOST.AtualizaSql;
    if not TabGlobal_i.DCAMPOST.Eof then
    begin
      TabGlobal_i.DCAMPOST.Modifica;
      TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Anterior;
      TabGlobal_i.DCAMPOST.Salva;
    end;

    if Tem_Calculo then
    begin
      TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
      TabGlobal_i.DCALCULADOS.AtualizaSql;
      TabGlobal_i.DCALCULADOS.First;
      if not TabGlobal_i.DCALCULADOS.Eof then
      begin
        TabGlobal_i.DCALCULADOS.Modifica;
        TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := Anterior;
        TabGlobal_i.DCALCULADOS.Salva;
      end;
    end;

    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.Locate('NOME',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DCAMPOST.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridCampos.ItemIndex := GridCampos.Items.IndexOf(Pesquisa);
    GridCamposClick(GridCampos);
    BtnAcima.Enabled := True;
  end
  else if Escolha_Atual = 3 then
  begin
    if TabGlobal_i.DINDICEST.Eof then exit;
    Modificou := True;
    BtnAcima.Enabled := False;
    TabGlobal_i.DINDICEST.DisableControls;
    Pesquisa := TabGlobal_i.DINDICEST.TITULO_I.Conteudo;
    Atual := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo;
    TabGlobal_i.DINDICEST.Modifica;
    TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DINDICEST.Salva;

    TabGlobal_i.DINDICEST.Prior;
    if not TabGlobal_i.DINDICEST.Bof then
      Anterior := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DINDICEST.Last;
      Anterior := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DINDICEST.Modifica;
    TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DINDICEST.Salva;

    TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DINDICEST.AtualizaSql;
    if not TabGlobal_i.DINDICEST.Eof then
    begin
      TabGlobal_i.DINDICEST.Modifica;
      TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := Anterior;
      TabGlobal_i.DINDICEST.Salva;
    end;

    TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DINDICEST.AtualizaSql;
    TabGlobal_i.DINDICEST.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DINDICEST.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridIndices.ItemIndex := GridIndices.Items.IndexOf(Pesquisa);
    GridIndicesClick(GridIndices);
    BtnAcima.Enabled := True;
  end
  else if Escolha_Atual = 4 then
  begin
    if TabGlobal_i.DRELACIONA.Eof then exit;
    Modificou := True;
    BtnAcima.Enabled := False;
    TabGlobal_i.DRELACIONA.DisableControls;
    Pesquisa := TabGlobal_i.DRELACIONA.TITULO_I.Conteudo;
    Atual := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo;
    TabGlobal_i.DRELACIONA.Modifica;
    TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DRELACIONA.Salva;

    TabGlobal_i.DRELACIONA.Prior;
    if not TabGlobal_i.DRELACIONA.Bof then
      Anterior := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DRELACIONA.Last;
      Anterior := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DRELACIONA.Modifica;
    TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DRELACIONA.Salva;

    TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DRELACIONA.AtualizaSql;
    if not TabGlobal_i.DRELACIONA.Eof then
    begin
      TabGlobal_i.DRELACIONA.Modifica;
      TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := Anterior;
      TabGlobal_i.DRELACIONA.Salva;
    end;

    TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DRELACIONA.AtualizaSql;
    TabGlobal_i.DRELACIONA.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DRELACIONA.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridIntegridade.ItemIndex := GridIntegridade.Items.IndexOf(Pesquisa);
    GridIntegridadeClick(GridIntegridade);
    BtnAcima.Enabled := True;
  end
  else if Escolha_Atual = 5 then
  begin
    if TabGlobal_i.DPROCESSOS.Eof then exit;
    Modificou := True;
    BtnAcima.Enabled := False;
    TabGlobal_i.DPROCESSOS.DisableControls;
    Pesquisa := TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo;
    Atual := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo;
    TabGlobal_i.DPROCESSOS.Modifica;
    TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DPROCESSOS.Salva;

    TabGlobal_i.DPROCESSOS.Prior;
    if not TabGlobal_i.DPROCESSOS.Bof then
      Anterior := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DPROCESSOS.Last;
      Anterior := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DPROCESSOS.Modifica;
    TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DPROCESSOS.Salva;

    TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DPROCESSOS.AtualizaSql;
    if not TabGlobal_i.DPROCESSOS.Eof then
    begin
      TabGlobal_i.DPROCESSOS.Modifica;
      TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := Anterior;
      TabGlobal_i.DPROCESSOS.Salva;
    end;

    TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DPROCESSOS.AtualizaSql;
    TabGlobal_i.DPROCESSOS.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DPROCESSOS.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridProcessos.ItemIndex := GridProcessos.Items.IndexOf(Pesquisa);
    PnProcessosClick(GridProcessos);
    BtnAcima.Enabled := True;
  end;
end;

procedure TFormEstruturas.BtnABaixoClick(Sender: TObject);
var
  Atual,Proximo: Integer;
  Pesquisa: String;
  Tem_Calculo: Boolean;
begin
  if Escolha_Atual = 2 then
  begin
    if TabGlobal_i.DCAMPOST.Eof then exit;
    Modificou := True;
    BtnAbaixo.Enabled := False;
    TabGlobal_i.DCAMPOST.DisableControls;
    Pesquisa := TabGlobal_i.DCAMPOST.NOME.Conteudo;
    Atual := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
    TabGlobal_i.DCAMPOST.Modifica;
    TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DCAMPOST.Salva;

    TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = '+IntToStr(Atual);
    TabGlobal_i.DCALCULADOS.AtualizaSql;
    TabGlobal_i.DCALCULADOS.First;
    Tem_Calculo := False;
    if not TabGlobal_i.DCALCULADOS.Eof then
    begin
      TabGlobal_i.DCALCULADOS.Modifica;
      TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := 9999;
      TabGlobal_i.DCALCULADOS.Salva;
      Tem_Calculo := True;
    end;

    TabGlobal_i.DCAMPOST.Next;
    if not TabGlobal_i.DCAMPOST.Eof then
      Proximo := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DCAMPOST.First;
      Proximo := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DCAMPOST.Modifica;
    TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DCAMPOST.Salva;

    TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = '+IntToStr(Proximo);
    TabGlobal_i.DCALCULADOS.AtualizaSql;
    TabGlobal_i.DCALCULADOS.First;
    if not TabGlobal_i.DCALCULADOS.Eof then
    begin
      TabGlobal_i.DCALCULADOS.Modifica;
      TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := Atual;
      TabGlobal_i.DCALCULADOS.Salva;
    end;

    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DCAMPOST.AtualizaSql;
    if not TabGlobal_i.DCAMPOST.Eof then
    begin
      TabGlobal_i.DCAMPOST.Modifica;
      TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Proximo;
      TabGlobal_i.DCAMPOST.Salva;
    end;

    if Tem_Calculo then
    begin
      TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
      TabGlobal_i.DCALCULADOS.AtualizaSql;
      TabGlobal_i.DCALCULADOS.First;
      if not TabGlobal_i.DCALCULADOS.Eof then
      begin
        TabGlobal_i.DCALCULADOS.Modifica;
        TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := Proximo;
        TabGlobal_i.DCALCULADOS.Salva;
      end;
    end;

    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.Locate('NOME',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DCAMPOST.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridCampos.ItemIndex := GridCampos.Items.IndexOf(Pesquisa);
    GridCamposClick(GridCampos);
    BtnAbaixo.Enabled := True;
  end
  else if Escolha_Atual = 3 then
  begin
    if TabGlobal_i.DINDICEST.Eof then exit;
    Modificou := True;
    BtnAbaixo.Enabled := False;
    TabGlobal_i.DINDICEST.DisableControls;
    Pesquisa := TabGlobal_i.DINDICEST.TITULO_I.Conteudo;
    Atual := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo;
    TabGlobal_i.DINDICEST.Modifica;
    TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DINDICEST.Salva;

    TabGlobal_i.DINDICEST.Next;
    if not TabGlobal_i.DINDICEST.Eof then
      Proximo := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DINDICEST.First;
      Proximo := TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DINDICEST.Modifica;
    TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DINDICEST.Salva;

    TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DINDICEST.AtualizaSql;
    if not TabGlobal_i.DINDICEST.Eof then
    begin
      TabGlobal_i.DINDICEST.Modifica;
      TabGlobal_i.DINDICEST.SEQUENCIA.Conteudo := Proximo;
      TabGlobal_i.DINDICEST.Salva;
    end;

    TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DINDICEST.AtualizaSql;
    TabGlobal_i.DINDICEST.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DINDICEST.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridIndices.ItemIndex := GridIndices.Items.IndexOf(Pesquisa);
    GridIndicesClick(GridIndices);
    BtnAbaixo.Enabled := True;
  end
  else if Escolha_Atual = 4 then
  begin
    if TabGlobal_i.DRELACIONA.Eof then exit;
    Modificou := True;
    BtnAbaixo.Enabled := False;
    TabGlobal_i.DRELACIONA.DisableControls;
    Pesquisa := TabGlobal_i.DRELACIONA.TITULO_I.Conteudo;
    Atual := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo;
    TabGlobal_i.DRELACIONA.Modifica;
    TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DRELACIONA.Salva;

    TabGlobal_i.DRELACIONA.Next;
    if not TabGlobal_i.DRELACIONA.Eof then
      Proximo := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DRELACIONA.First;
      Proximo := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DRELACIONA.Modifica;
    TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DRELACIONA.Salva;

    TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DRELACIONA.AtualizaSql;
    if not TabGlobal_i.DRELACIONA.Eof then
    begin
      TabGlobal_i.DRELACIONA.Modifica;
      TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo := Proximo;
      TabGlobal_i.DRELACIONA.Salva;
    end;

    TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DRELACIONA.AtualizaSql;
    TabGlobal_i.DRELACIONA.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DRELACIONA.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridIntegridade.ItemIndex := GridIntegridade.Items.IndexOf(Pesquisa);
    GridIntegridadeClick(GridIntegridade);
    BtnAbaixo.Enabled := True;
  end
  else if Escolha_Atual = 5 then
  begin
    if TabGlobal_i.DPROCESSOS.Eof then exit;
    Modificou := True;
    BtnAbaixo.Enabled := False;
    TabGlobal_i.DPROCESSOS.DisableControls;
    Pesquisa := TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo;
    Atual := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo;
    TabGlobal_i.DPROCESSOS.Modifica;
    TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := 9999;
    TabGlobal_i.DPROCESSOS.Salva;

    TabGlobal_i.DPROCESSOS.Next;
    if not TabGlobal_i.DPROCESSOS.Eof then
      Proximo := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo
    else
    begin
      TabGlobal_i.DPROCESSOS.First;
      Proximo := TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo;
    end;
    TabGlobal_i.DPROCESSOS.Modifica;
    TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := Atual;
    TabGlobal_i.DPROCESSOS.Salva;

    TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = 9999';
    TabGlobal_i.DPROCESSOS.AtualizaSql;
    if not TabGlobal_i.DPROCESSOS.Eof then
    begin
      TabGlobal_i.DPROCESSOS.Modifica;
      TabGlobal_i.DPROCESSOS.SEQUENCIA.Conteudo := Proximo;
      TabGlobal_i.DPROCESSOS.Salva;
    end;

    TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DPROCESSOS.AtualizaSql;
    TabGlobal_i.DPROCESSOS.Locate('TITULO_I',Pesquisa,[loCaseInsensitive, loPartialKey]);
    TabGlobal_i.DPROCESSOS.EnableControls;
    AtualizaLista(Escolha_Atual);
    GridProcessos.ItemIndex := GridProcessos.Items.IndexOf(Pesquisa);
    PnProcessosClick(GridProcessos);
    BtnAbaixo.Enabled := True;
  end;
end;

procedure TFormEstruturas.BtnCalculoClick(Sender: TObject);
var
  P: Integer;
  Grava: Boolean;
  exp_exemplo, exp_exemplo1: String;
begin
  TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND SEQUENCIA = '+IntToStr(TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo);
  TabGlobal_i.DCALCULADOS.AtualizaSql;
  TabGlobal_i.DCALCULADOS.First;
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.E_Cabecalho.ReadOnly := False;
    FormMiniEditor.EdVirtual.Visible    := True;
    if TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1 then
      FormMiniEditor.EdVirtual.Checked := true
    else
      FormMiniEditor.EdVirtual.Checked := false;
    P := 1;
    if TabGlobal_i.DCALCULADOS.Eof then
    begin
      exp_exemplo := '';
      exp_exemplo1 := '';
      case TabGlobal_i.DCAMPOST.TIPO.Conteudo of
        1: begin exp_exemplo := 'I: String'; exp_exemplo1 := '+ '+#39 + 'ABC' + #39 end;
        2: begin exp_exemplo := 'I: Integer'; exp_exemplo1 := '+ 100' end;
        3: begin exp_exemplo := 'I: Double'; exp_exemplo1 := '/ 100' end;
        4: begin exp_exemplo := 'I: TDate'; exp_exemplo1 := '- Date' end;
      end;
      FormMiniEditor.E_Cabecalho.Lines.Clear;
      FormMiniEditor.E_Metodo.Lines.Clear;
      FormMiniEditor.E_Cabecalho.Lines.Add('// variáveis locais, exemplo: '+exp_exemplo+';');
      FormMiniEditor.E_Cabecalho.Lines.Add('');
      FormMiniEditor.E_Metodo.Lines.Add('{ a variável "Result" deverá conter o resultado, exemplo:');
      FormMiniEditor.E_Metodo.Lines.Add('  I := TabGlobal.D'+TabGlobal_i.DTABELAS.NOME.Conteudo+'.'+TabGlobal_i.DCAMPOST.NOME.Conteudo + '.Conteudo '+exp_exemplo1+';');
      FormMiniEditor.E_Metodo.Lines.Add('  Result := I; }');
      FormMiniEditor.E_Metodo.Lines.Add('');
      P := 4;
    end
    else
    begin
      FormMiniEditor.E_Cabecalho.Lines.AddStrings(TabGlobal_i.DCALCULADOS.VARIAVEIS.Conteudo);
      FormMiniEditor.E_Metodo.Lines.AddStrings(TabGlobal_i.DCALCULADOS.CODIFICACAO.Conteudo);
    end;
    FormMiniEditor.ExcluirEvento.Visible := False;
    FormMiniEditor.Posicao_Y := P;
    if FormMiniEditor.ShowModal = mrOk then
    begin
      if TabGlobal_i.DCALCULADOS.Eof then
      begin
        TabGlobal_i.DCALCULADOS.Inclui(Nil);
        TabGlobal_i.DCALCULADOS.NUMERO.Conteudo    := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
        TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
      end
      else
        TabGlobal_i.DCALCULADOS.Modifica;
      TabGlobal_i.DCALCULADOS.VARIAVEIS.Conteudo.Clear;
      TBlobField(TabGlobal_i.DCALCULADOS.FieldByName('VARIAVEIS')).AsString := FormMiniEditor.E_Cabecalho.Lines.Text;
      TabGlobal_i.DCALCULADOS.CODIFICACAO.Conteudo.Clear;
      TBlobField(TabGlobal_i.DCALCULADOS.FieldByName('CODIFICACAO')).AsString := FormMiniEditor.E_Metodo.Lines.Text;
      TabGlobal_i.DCALCULADOS.Salva;
      Grava := False;
      if (not TabGlobal_i.DCAMPOST.Modificacao) and (not TabGlobal_i.DCAMPOST.Inclusao) then
      begin
        TabGlobal_i.DCAMPOST.Modifica;
        Grava := True;
      end;
      if FormMiniEditor.EdVirtual.Checked then
        TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo := 1
      else
        TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo := 0;
      if Grava then
        TabGlobal_i.DCAMPOST.Salva;
      Modificou := True;
    end;
  Finally
    FormMiniEditor.Free;
  end;
end;

procedure TFormEstruturas.BtnHerdarClick(Sender: TObject);
Var
  I, Seq: Integer;
  Herdou: Boolean;
  xnome, xmascara, xtitulo_c, xajuda, xpadrao, xvalidacao, xvalidos, xdescricao,
  xprevalidacao, xmsgerro, xtabestrangeira, xcampochave, xcamposvisuais: String;
  xtipo, xtamanho, xedicao, xchave, xcalculado, xautoincremento, xinvisivel,
  xtipoprevalidacao, xlimparcampo, xseq, xsempreatribui, xindiceconsulta,xestilochave: integer;
  xvariaveis, xcodificacao: TStringList;
begin
  TabGlobal_i.DCAMPOST.DisableControls;
  TabGlobal_i.DCAMPOST.Last;
  Seq := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo + 1;
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    FormCamposProj.Tipo := 1;
    FormCamposProj.Escolha := True;
    if FormCamposProj.ShowModal = mrOk then
    begin
      for I:=0 to FormCamposProj.FieldsLB_S.Items.Count-1 do
        if FormCamposProj.FieldsLB_S.Checked[I] then
        begin
          Modificou := True;
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+FormCamposProj.Retorno+ 'AND SEQUENCIA = '+IntToStr(Integer(FormCamposProj.FieldsLB_S.Items.Objects[I]));
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          if not TabGlobal_i.DCAMPOST.Eof then
          begin
            xseq       := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
            xnome      := TabGlobal_i.DCAMPOST.NOME.Conteudo;
            xtipo      := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
            xtamanho   := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
            xedicao    := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
            xmascara   := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
            xtitulo_c  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
            xajuda     := TabGlobal_i.DCAMPOST.AJUDA.Conteudo;
            xpadrao    := TabGlobal_i.DCAMPOST.PADRAO.Conteudo;
            xvalidacao := TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo;
            xvalidos   := TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text;
            xdescricao := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text;
            xchave     := TabGlobal_i.DCAMPOST.CHAVE.Conteudo;
            xcalculado := TabGlobal_i.DCAMPOST.CALCULADO.Conteudo;
            xautoincremento   := TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo;
            xsempreatribui    := TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo;
            xinvisivel        := TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo;
            xprevalidacao     := TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo;
            xtipoprevalidacao := TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo;
            xlimparcampo      := TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo;
            xmsgerro          := TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo;
            xtabestrangeira   := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            xcampochave       := TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo;
            xcamposvisuais    := TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo;
            xestilochave      := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
            xindiceconsulta   := TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo;
            herdou := False;
            while not Herdou do
            begin
              TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND NOME = '+#39+xnome+#39;
              TabGlobal_i.DCAMPOST.AtualizaSql;
              if (TabGlobal_i.DCAMPOST.Eof) and (ValidaNomeCampo(xNome)) then
                Herdou := True
              else
              begin
                InputQuery('Duplicidade !', 'Nome já existente, informe outro nome ...', xnome);
                xnome := UpperCase(xnome);
              end;
            end;
            TabGlobal_i.DCAMPOST.Inclui(Nil);
            TabGlobal_i.DCAMPOST.NUMERO.Conteudo    := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
            TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Seq;
            TabGlobal_i.DCAMPOST.NOME.Conteudo      := xnome;
            TabGlobal_i.DCAMPOST.TIPO.Conteudo      := xtipo;
            TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := xtamanho;
            TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := xedicao;
            TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := xmascara;
            TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := xtitulo_c;
            TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := xajuda;
            TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := xpadrao;
            TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := xvalidacao;
            TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text   := xvalidos;
            TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text := xdescricao;
            TabGlobal_i.DCAMPOST.CHAVE.Conteudo     := xchave;
            TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := xcalculado;
            TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo     := xautoincremento;
            TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo     := xsempreatribui;
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo          := xinvisivel;
            TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo      := xprevalidacao;
            TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := xtipoprevalidacao;
            TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo       := xlimparcampo;
            TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo           := xmsgerro;
            TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo    := xtabestrangeira;
            TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo        := xcampochave;
            TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo     := xcamposvisuais;
            TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo       := xestilochave;
            TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo    := Seq;
            TabGlobal_i.DCAMPOST.EXTRA.Conteudo              := 0;
            TabGlobal_i.DCAMPOST.Salva;
            if xcalculado = 1 then
            begin
              TabGlobal_i.DCALCULADOS.Filtro := 'NUMERO = '+FormCamposProj.Retorno+ ' AND SEQUENCIA = '+IntToStr(xseq);
              TabGlobal_i.DCALCULADOS.AtualizaSql;
              TabGlobal_i.DCALCULADOS.First;
              if not TabGlobal_i.DCALCULADOS.Eof then
              begin
                xvariaveis := TStringList.Create;
                xcodificacao := TStringList.Create;
                xvariaveis.AddStrings(TabGlobal_i.DCALCULADOS.VARIAVEIS.Conteudo);
                xcodificacao.AddStrings(TabGlobal_i.DCALCULADOS.CODIFICACAO.Conteudo);
                if PTabela(TabGlobal_i.DCALCULADOS,['NUMERO','SEQUENCIA'],[TabGlobal_i.DTABELAS.NUMERO.Conteudo,Seq]) then
                  TabGlobal_i.DCALCULADOS.Modifica
                else
                begin
                  TabGlobal_i.DCALCULADOS.Inclui(Nil);
                  TabGlobal_i.DCALCULADOS.NUMERO.Conteudo := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
                  TabGlobal_i.DCALCULADOS.SEQUENCIA.Conteudo := Seq;
                end;
                TBlobField(TabGlobal_i.DCALCULADOS.FieldByName('VARIAVEIS')).AsString := xvariaveis.Text;
                TBlobField(TabGlobal_i.DCALCULADOS.FieldByName('CODIFICACAO')).AsString := xcodificacao.Text;
                TabGlobal_i.DCALCULADOS.Salva;
                xvariaveis.Free;
                xcodificacao.Free;
              end;
            end;
            Inc(Seq);
          end;
        end;
      GridTabelaClick(GridTabela);
      GridCamposClick(GridCampos);
    end;
  Finally
    FormCamposProj.Free;
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    TabGlobal_i.DCAMPOST.EnableControls;
  end;
end;

function TFormEstruturas.ValidaNomeCampo(S: String; Posicao: Integer = -1; Tabela: Boolean = False): Boolean;
var Caracter,TipoChar : String;
    I,PosAt: Integer;
    CharInvalido : Boolean;
begin
  Result := True;
  S := UpperCase(S);
  if Trim(S) = '' then Result := False;
  if Pos(S+'|',FormPrincipal.LNomesReservados2) > 0 then
  begin
    if Tabela then
      Mensagem('Nome da Tabela Inválido !'+^M+^M+S+' ( Reservado ) ...',modErro,[modOk])
    else
      Mensagem('Nome de Campo Inválido !'+^M+^M+S+' ( Reservado ) ...',modErro,[modOk]);
    Result := False;
    exit;
  end;
  CharInvalido := False;
  for I := 1 to Length(S) do
  begin
    Caracter := UpperCase(Copy(S,I,01));
    if not ((Caracter[1] in ['A'..'Z']) or (Caracter[1] in ['0'..'9']) or
            (Caracter = '_')) then
    begin
      CharInvalido := True;
      tipoChar := Caracter;
    end;
  end;
  Caracter := UpperCase(Copy(S,1,01));
  if Caracter[1] in ['0'..'9'] then
  begin
    CharInvalido := True;
    tipoChar := Caracter;
  end;
  if CharInvalido then
  begin
    Mensagem('Caracter Inválido no Nome: '+ #39 + TipoChar + #39,ModAdvertencia,[ModOk]);
    Result := False;
    exit;
  end;
  if Tabela then
  begin
    if PTabela(TabGlobal_i.DTABELAS,['<>NUMERO','UPPER(NOME)'],[Posicao,UpperCase(S)]) then
    begin
      Mensagem('Tabela já existente !!!',ModAdvertencia,[ModOk]);
      Result := False;
      exit;
    end;
  end
  else
  begin
    if PTabela(TabGlobal_i.DCAMPOST,['NUMERO','<>SEQUENCIA','NOME'],[TabGlobal_i.DTABELAS.NUMERO.Conteudo,Posicao,S]) then
    begin
      Mensagem('Campo já existente !!!',ModAdvertencia,[ModOk]);
      Result := False;
      exit;
    end;
  end;
end;

procedure TFormEstruturas.CP_EdEdicaoExit(Sender: TObject);
begin
  CP_EdChaveExit(Self);
  if TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 5 then
    BtnChEst.Enabled := True
  else
    BtnChEst.Enabled := False;
  if (TabGlobal_i.DCAMPOST.EDICAO.Conteudo > 1) and (TabGlobal_i.DCAMPOST.EDICAO.Conteudo < 5) then
    CP_EdValidos.Enabled := True
  else
    CP_EdValidos.Enabled := False;
  if (not CP_EdCalculado.Enabled) and (not CP_EdMascara.ReadOnly) then
  begin
    if ((ActiveControl = BtnCancela) or
       (ActiveControl = BtnSalvar)) then exit;
    if CP_EdMascara.Enabled and Pagina0.Enabled then
      CP_EdMascara.SetFocus;
  end;
end;

procedure TFormEstruturas.BtnChEstClick(Sender: TObject);
var
  xtabestrangeira, xcampochave, xcamposvisuais, xtitulo: String;
  i, seq: integer;
  salvar, Lancar: Boolean;
begin
  FormChaveEst := TFormChaveEst.Create(Application);
  Try
    if Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo) = '' then
      Lancar := True;
    FormChaveEst.EdTabela.Text      := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' + TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
    FormChaveEst.CamposEdTabela.Items.Text := TabGlobal_i.DCAMPOST.NOME.Conteudo;
    FormChaveEst.Tab_Estrangeira    := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
    FormChaveEst.Campo_Chave        := TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo;
    FormChaveEst.Campos_Visuais     := TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo;
    FormChaveEst.EdEstilo.ItemIndex := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
    FormChaveEst.EdAcao.ItemIndex   := TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Conteudo;
    FormChaveEst.Filtro_Mestre.AddStrings(TabGlobal_i.DCAMPOST.FILTRO_MESTRE.Conteudo);
    FormChaveEst.EdEstiloChange(Self);
    if FormChaveEst.ShowModal = mrOk then
    begin
      xtabestrangeira := FormChaveEst.ComboTab.Text;
      xcampochave := FormChaveEst.CamposRelacionados.Items[0];
      xcamposvisuais := '';
      for I:=0 to FormChaveEst.CamposMostrados.Items.Count-1 do
        xcamposvisuais := xcamposvisuais + FormChaveEst.CamposMostrados.Items[I]+',';
      if Copy(xcamposvisuais,Length(xcamposvisuais),01) = ',' then
        xcamposvisuais := Copy(xcamposvisuais,01,Length(xcamposvisuais)-1);
      salvar := not (TabGlobal_i.DCAMPOST.Inclusao or TabGlobal_i.DCAMPOST.Modificacao);
      if salvar then
        TabGlobal_i.DCAMPOST.Modifica;
      TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo:= xtabestrangeira;
      TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo    := xcampochave;
      TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo := xcamposvisuais;
      TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo   := FormChaveEst.EdEstilo.ItemIndex;
      TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Conteudo  := FormChaveEst.EdAcao.ItemIndex;
      if FormChaveEst.EdEstilo.ItemIndex = 0 then
        TBlobField(TabGlobal_i.DCAMPOST.FieldByName('FILTRO_MESTRE')).AsString := ''
      else
        TBlobField(TabGlobal_i.DCAMPOST.FieldByName('FILTRO_MESTRE')).AsString := FormChaveEst.Filtro_Mestre.Text;
      if salvar then
        TabGlobal_i.DCAMPOST.Salva;
      if (Lancar) and (Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo) <> '') then
      begin
        TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND UPPER(TAB_ESTRANGEIRA) = '+#39+UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo))+#39;
        TabGlobal_i.DRELACIONA.AtualizaSql;
        if TabGlobal_i.DRELACIONA.Eof then
          if Mensagem('Criar Relacionamento em "Integridades && Relacionamentos" ?',modConfirmacao,[modSim,modNao]) = mrYes then
          begin
            xtitulo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            InputQuery('Relacionamento !', 'Informe o título ...', xtitulo);
            if Trim(xtitulo) = '' then
              xtitulo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            TabGlobal_i.DRELACIONA.DisableControls;
            TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
            TabGlobal_i.DRELACIONA.AtualizaSql;
            TabGlobal_i.DRELACIONA.Last;
            Seq := TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo + 1;
            TabGlobal_i.DRELACIONA.EnableControls;
            TabGlobal_i.DRELACIONA.Inclui(Nil);
            TabGlobal_i.DRELACIONA.NUMERO.Conteudo     := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
            TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo  := Seq;
            TabGlobal_i.DRELACIONA.TITULO_I.Conteudo   := xtitulo;
            TabGlobal_i.DRELACIONA.TIPO.Conteudo       := 1;
            TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo := TabGlobal_i.DCAMPOST.NOME.Conteudo;
            TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo := xcampochave;
            TabGlobal_i.DRELACIONA.Salva;
            if salvar then
              TabGlobal_i.DCAMPOST.Modifica;
            CP_EdTab_Pesquisa.DataSource := Nil;
            TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            if salvar then
              TabGlobal_i.DCAMPOST.Salva;
            TabGlobal_i.DRELACIONA.First;
            GridIntegridade.Items.Clear;
            CP_EdTab_Pesquisa.Clear;
            CP_EdTab_Pesquisa.Items.Add('');
            while not TabGlobal_i.DRELACIONA.Eof do
            begin
              GridIntegridade.Items.AddObject(TabGlobal_i.DRELACIONA.TITULO_I.Conteudo,TObject(TabGlobal_i.DRELACIONA.SEQUENCIA.Conteudo));
              CP_EdTab_Pesquisa.Items.Add(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
              TabGlobal_i.DRELACIONA.Next;
            end;
            CP_EdTab_Pesquisa.DataSource := DataSource3;
          end;
        TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        TabGlobal_i.DRELACIONA.AtualizaSql;
      end;
      Modificou := True;
    end;
  Finally
    FormChaveEst.Free;
  end;
end;

procedure TFormEstruturas.CP_EdNomeExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not CP_EdNome.ReadOnly) and (not ValidaNomeCampo(TabGlobal_i.DCAMPOST.NOME.Conteudo, TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo)) then
  begin
    CP_EdNome.SelectAll;
    CP_EdNome.SetFocus;
  end;
end;

procedure TFormEstruturas.PreencheListaIndice;
begin
  CamposOrigem.Items.Clear;
  TabGlobal_i.DCAMPOST.DisableControls;
  TabGlobal_i.DCAMPOST.First;
  while not TabGlobal_i.DCAMPOST.Eof do
  begin
    if (TabGlobal_i.DCAMPOST.TIPO.Conteudo < 5) and
       (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) then
    begin
      if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
        CamposOrigem.Items.AddObject(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo) + '.' + Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo),TObject(1))
      else
      begin
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          CamposOrigem.Items.AddObject(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) + '.' + Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo),TObject(0))
        else
          CamposOrigem.Items.AddObject(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) + '.' + Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo),TObject(1));
      end;
    end;
    TabGlobal_i.DCAMPOST.Next;
  end;
  TabGlobal_i.DCAMPOST.First;
  TabGlobal_i.DCAMPOST.EnableControls;
end;

procedure TFormEstruturas.ID_EDTITULOExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not ID_EDTITULO.ReadOnly) and (Trim(ID_EDTITULO.Text) = '') then
  begin
    Mensagem('Necessário informar Título !',ModAdvertencia,[ModOk]);
    ID_EDTITULO.SetFocus;
  end;
end;

procedure TFormEstruturas.BtnInserirCmpClick(Sender: TObject);
Var
  I: Integer;
begin
  if not BtnInserirCmp.Enabled then exit;
  if (CamposOrigem.ItemIndex > -1) and (CamposIndices.Enabled) then
  begin
    CamposIndices.Items.Add(CamposOrigem.Items[CamposOrigem.ItemIndex]);
    CamposIndices.ItemIndex := CamposIndices.Items.Count-1;
    TabGlobal_i.DINDICEST.CAMPOST.Conteudo := '';
    for I:=0 to CamposIndices.Items.Count-1 do
      if I = CamposIndices.Items.Count-1 then
        TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I]
      else
        TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I] + ';';
  end;
end;

procedure TFormEstruturas.BtnExcluirCmpClick(Sender: TObject);
Var
  I, P: Integer;
begin
  if not BtnExcluirCmp.Enabled then exit;
  if (CamposIndices.ItemIndex > -1) and (CamposIndices.Enabled) then
  begin
    P := CamposIndices.ItemIndex;
    CamposIndices.Items.Delete(CamposIndices.ItemIndex);
    TabGlobal_i.DINDICEST.CAMPOST.Conteudo := '';
    for I:=0 to CamposIndices.Items.Count-1 do
      if I = CamposIndices.Items.Count-1 then
        TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I]
      else
        TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I] + ';';
    if P-1 >= 0 then
      CamposIndices.ItemIndex := P-1
    else
      CamposIndices.ItemIndex := 0;
  end;
end;

procedure TFormEstruturas.BtnMoveParaCimaClick(Sender: TObject);
Var
  Atual, Anterior: String;
  I: Integer;
begin
  if not BtnMoveParaCima.Enabled then exit;
  if (CamposIndices.ItemIndex > -1) and (CamposIndices.Enabled) then
    if CamposIndices.ItemIndex - 1 >= 0 then
    begin
      Atual    := CamposIndices.Items[CamposIndices.ItemIndex];
      Anterior := CamposIndices.Items[CamposIndices.ItemIndex-1];
      CamposIndices.Items[CamposIndices.ItemIndex]   := Anterior;
      CamposIndices.Items[CamposIndices.ItemIndex-1] := Atual;
      CamposIndices.ItemIndex := CamposIndices.ItemIndex-1;
      TabGlobal_i.DINDICEST.CAMPOST.Conteudo := '';
      for I:=0 to CamposIndices.Items.Count-1 do
        if I = CamposIndices.Items.Count-1 then
          TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I]
        else
          TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I] + ';';
    end;
end;

procedure TFormEstruturas.BtnMoveParaBaixoClick(Sender: TObject);
Var
  Atual,Proximo: String;
  I: Integer;
begin
  if not BtnMoveParaBaixo.Enabled then exit;
  if (CamposIndices.ItemIndex > -1) and (CamposIndices.Enabled) then
    if CamposIndices.ItemIndex + 1 <= CamposIndices.Items.Count-1 then
    begin
      Atual   := CamposIndices.Items[CamposIndices.ItemIndex];
      Proximo := CamposIndices.Items[CamposIndices.ItemIndex+1];
      CamposIndices.Items[CamposIndices.ItemIndex]   := Proximo;
      CamposIndices.Items[CamposIndices.ItemIndex+1] := Atual;
      CamposIndices.ItemIndex := CamposIndices.ItemIndex+1;
      TabGlobal_i.DINDICEST.CAMPOST.Conteudo := '';
      for I:=0 to CamposIndices.Items.Count-1 do
        if I = CamposIndices.Items.Count-1 then
          TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I]
        else
          TabGlobal_i.DINDICEST.CAMPOST.Conteudo := TabGlobal_i.DINDICEST.CAMPOST.Conteudo + CamposIndices.Items[I] + ';';
    end;
end;

procedure TFormEstruturas.CP_EdValidosButtonClick(Sender: TObject);
Var
  ListaValidos, ListaDescricao: TStringList;
  I: Integer;
begin
  ListaValidos  := TStringList.Create;
  ListaDescricao:= TStringList.Create;
  StringToArray(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text,';',ListaValidos);
  StringToArray(TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text,';',ListaDescricao);
  FormVlValidos := TFormVlValidos.Create(Application);
  Try
    FormVlValidos.ListaSelecao.Items.Clear;
    FormVlValidos.TamanhoCmp := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
    for I:=0 to ListaValidos.Count-1 do
    begin
      if I > ListaDescricao.Count-1 then
        ListaDescricao.Add(ListaValidos[I]);
      FormVlValidos.ListaSelecao.Items.Add(Format('%-'+IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+'s',[ListaValidos[I]])+ListaDescricao[I]);
    end;
    FormVlValidos.ShowModal;
  Finally
    if FormVlValidos.Atualizar then
    begin
      TabGlobal_i.DCAMPOST.Validos.Conteudo.Text   := '';
      TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text := '';
      for I:=0 to FormVlValidos.ListaSelecao.Items.Count-1 do
      begin
        TabGlobal_i.DCAMPOST.Validos.Conteudo.Text   := TabGlobal_i.DCAMPOST.Validos.Conteudo.Text + Copy(FormVlValidos.ListaSelecao.Items[I],01,FormVlValidos.TamanhoCmp) + ';';
        TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text := TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text + Copy(FormVlValidos.ListaSelecao.Items[I],FormVlValidos.TamanhoCmp+01,255) + ';';
      end;
      if Trim(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text) <> '' then
      begin
        TabGlobal_i.DCAMPOST.Validos.Conteudo.Text   := Copy(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text,01,Length(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text)-1);
        TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text := Copy(TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text,01,Length(TabGlobal_i.DCAMPOST.Descricao.Conteudo.Text)-1);
      end;
      if Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) = '' then
        if Pos(';',TabGlobal_i.DCAMPOST.Validos.Conteudo.Text) > 0 then
          TabGlobal_i.DCAMPOST.PADRAO.Conteudo := Copy(TabGlobal_i.DCAMPOST.Validos.Conteudo.Text,01,Pos(';',TabGlobal_i.DCAMPOST.Validos.Conteudo.Text)-1)
        else
          TabGlobal_i.DCAMPOST.PADRAO.Conteudo := TabGlobal_i.DCAMPOST.Validos.Conteudo.Text;
    end;
    FormVlValidos.Free;
    ListaValidos.Free;
    ListaDescricao.Free;
  end;
end;

procedure TFormEstruturas.CP_EdPreValidacaoButtonClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    FormExpressao.ExprMemo.Text := TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo;
    if FormExpressao.ShowModal = mrOk then
    begin
      TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo := FormExpressao.ExprMemo.Text;
      CP_EdPreValidacao.SetFocus;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

procedure TFormEstruturas.BtnBancoDadosClick(Sender: TObject);
begin
  FormBancoDados := TFormBancoDados.Create(Application);
  Try
    FormBancoDados.ShowModal;
  Finally
    FormBancoDados.Free;
  end;
  TB_EdBanco.SetFocus;
end;

procedure TFormEstruturas.TabSet1Click(Sender: TObject);
begin
  NoPrincipal.SetFocus;
  NoPrincipal.PageIndex := TabSet1.TabIndex;
end;

procedure TFormEstruturas.CP_EdPadraoExit(Sender: TObject);
begin
  if not CP_EdSempreAtribui.Enabled then
    NoPrincipal.SetFocus;
  if (ActiveControl = BtnCancela) or (ActiveControl = BtnSalvar) then exit;
  if not CP_EdSempreAtribui.Enabled then
  begin
    TabSet1.TabIndex := 1;
    TabSet1Click(Self);
    CP_EdPreValidacao.SelectAll;
    CP_EdPreValidacao.SetFocus;
  end;
end;

procedure TFormEstruturas.Atualiza_Integridade;
begin
  Gr_Compat.Visible := False;
  CS_EdCodificacao.ReadOnly := True;
  CS_EdCodificacao.Color := clBtnFace;
  RS_EdCodificacao.ReadOnly := True;
  RS_EdCodificacao.Color := clBtnFace;
  CS_EdCodificacao.Text := '';
  RS_EdCodificacao.Text := '';

  TabGlobal_i.DCASCATAT.First;
  if not TabGlobal_i.DCASCATAT.Eof then
    if Trim(TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo.Text) <> '' then
    begin
      Gr_Compat.Visible := True;
      CS_EdCodificacao.ReadOnly := False;
      CS_EdCodificacao.Color := clWindow;
      CS_EdCodificacao.Text := Trim(TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo.Text);
    end;

  TabGlobal_i.DRESTRITAT.First;
  if not TabGlobal_i.DRESTRITAT.Eof then
    if Trim(TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo.Text) <> '' then
    begin
      Gr_Compat.Visible := True;
      RS_EdCodificacao.ReadOnly := False;
      RS_EdCodificacao.Color := clWindow;
      RS_EdCodificacao.Text := Trim(TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo.Text);
    end;
end;

procedure TFormEstruturas.GridTabelaClick(Sender: TObject);
begin
  if GridTabela.ItemIndex > -1 then
    TabGlobal_i.DTABELAS.Locate('NUMERO',Integer(GridTabela.Items.Objects[GridTabela.ItemIndex]),[]);

  TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);

  TabGlobal_i.DCASCATAT.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
  TabGlobal_i.DCASCATAT.AtualizaSql;

  TabGlobal_i.DRESTRITAT.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
  TabGlobal_i.DRESTRITAT.AtualizaSql;

  Atualiza_Integridade;

  Habilita_Escolha(TControl(Sender).Tag);

  if (GridTabela.ItemIndex < 0) then
    if GridTabela.Items.Count > 0 then
      GridTabela.ItemIndex := 0;

  BtnCalculo.Enabled := False;
  BtnChEst.Enabled := False;
  AtualizaLista(2);
  AtualizaLista(3);
  AtualizaLista(4);
  AtualizaLista(5);
end;

procedure TFormEstruturas.GridCamposClick(Sender: TObject);
begin
  if (GridCampos.ItemIndex < 0) then
    if GridCampos.Items.Count > 0 then
      GridCampos.ItemIndex := 0;
  if GridCampos.ItemIndex > -1 then
    TabGlobal_i.DCAMPOST.Locate('SEQUENCIA',Integer(GridCampos.Items.Objects[GridCampos.ItemIndex]),[]);

  CP_EdChaveExit(Self);
  CP_EdEdicaoExit(Self);
  CP_EdSequenciaExit(Self);

  Habilita_Escolha(TControl(Sender).Tag);
end;

procedure TFormEstruturas.GridIndicesClick(Sender: TObject);
Var
  ListaCmp: TStringList;
  I: Integer;
begin
  if (GridIndices.ItemIndex < 0) then
    if GridIndices.Items.Count > 0 then
      GridIndices.ItemIndex := 0;
  if GridIndices.ItemIndex > -1 then
    TabGlobal_i.DINDICEST.Locate('SEQUENCIA',Integer(GridIndices.Items.Objects[GridIndices.ItemIndex]),[]);

  BtnCalculo.Enabled := False;
  BtnChEst.Enabled := False;
  CamposIndices.Items.Clear;
  ListaCmp := TStringList.Create;
  StringToArray(TabGlobal_i.DINDICEST.CAMPOST.Conteudo,';',ListaCmp);
  for I:=0 to ListaCmp.Count-1 do
    CamposIndices.Items.Add(ListaCmp[I]);
  ListaCmp.Free;
  Habilita_Escolha(TControl(Sender).Tag);
end;

procedure TFormEstruturas.GridIntegridadeClick(Sender: TObject);
begin
  if (GridIntegridade.ItemIndex < 0) then
    if GridIntegridade.Items.Count > 0 then
      GridIntegridade.ItemIndex := 0;
  if GridIntegridade.ItemIndex > -1 then
    TabGlobal_i.DRELACIONA.Locate('SEQUENCIA',Integer(GridIntegridade.Items.Objects[GridIntegridade.ItemIndex]),[]);
  BtnCalculo.Enabled := False;
  BtnChEst.Enabled := False;
  Habilita_Escolha(TControl(Sender).Tag);
end;

procedure TFormEstruturas.GridTabelaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then
    GridTabelaDblClick(Self)
  else if key = VK_INSERT then
    BtnNovoClick(Self)
  else if Key = VK_DELETE then
    BtnExcluirClick(Self);
end;

procedure TFormEstruturas.GridTabelaDblClick(Sender: TObject);
begin
  case Escolha_Atual of
    1: begin
         if TabGlobal_i.DTABELAS.Eof then
         begin
           Nome_Original_Tab := '';
           BtnNovoClick(Self);
         end
         else
         begin
           Nome_Original_Tab := Trim(TabGlobal_i.DTABELAS.NOME.Conteudo);
           TabGlobal_i.DTABELAS.Modifica;
           Habilita_Campos(True);
         end;
       end;
    2: begin
         if TabGlobal_i.DCAMPOST.Eof then
           BtnNovoClick(Self)
         else
         begin
           TabGlobal_i.DCAMPOST.Modifica;
           Habilita_Campos(True);
         end;
       end;
    3: begin
         if TabGlobal_i.DINDICEST.Eof then
           BtnNovoClick(Self)
         else
         begin
           TabGlobal_i.DINDICEST.Modifica;
           Habilita_Campos(True);
         end;
       end;
    4: begin
         if TabGlobal_i.DRELACIONA.Eof then
           BtnNovoClick(Self)
         else
         begin
           TabGlobal_i.DRELACIONA.Modifica;
           Habilita_Campos(True);
         end;
       end;
    5: begin
         if TabGlobal_i.DPROCESSOS.Eof then
           BtnNovoClick(Self)
         else
         begin
           TabGlobal_i.DPROCESSOS.Modifica;
           Habilita_Campos(True);
         end;
       end;
  end;
end;

procedure TFormEstruturas.GridCamposDrawItem(Control: TWinControl;
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
      if Campos_Chave[Index] = '0' then
        Image := Image2
      else if Campos_Chave[Index] = '2' then
        Image := Image4
      else
        Image := Image3;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormEstruturas.BtnIndexClick(Sender: TObject);
var
  I, P, Y: Integer;

  function PCampo(S: String): Integer;
  var
    X: Integer;
    Linha: String;
  begin
    PCampo := -1;
    for X:=0 to FormTabOrdem.TabList1.Items.Count-1 do
    begin
      Linha := FormTabOrdem.TabList1.Items[X];
      Linha := Copy(Linha,Pos('-',Linha)+1,Length(Linha));
      Linha := Trim(Copy(Linha,01,Pos('(',Linha)-1));
      if Linha = S then
      begin
        PCampo := X;
        Break;
      end;
    end;
  end;

begin
  FormTabOrdem := TFormTabOrdem.Create(Application);
  try
    FormTabOrdem.TabList.Visible := False;
    FormTabOrdem.TabList1.Visible := True;
    FormTabOrdem.TabList1.Clear;
    FormTabOrdem.LbTitulo.Caption := 'Ordem de apresentação dos campos em "Consultas"';
    FormTabOrdem.Caption := 'Apresentação dos Campos';
    P := GridCampos.ItemIndex;
    TabGlobal_i.DCAMPOST.DisableControls;
    TabGlobal_i.DCAMPOST.First;
    FormTabOrdem.TabList1.Sorted := False;
    while not TabGlobal_i.DCAMPOST.Eof do
    begin
      if TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo < 0 then
        FormTabOrdem.TabList1.Items.Add(StrZero(0,4) + ' - ' +TabGlobal_i.DCAMPOST.NOME.Conteudo + ' ( ' + TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+' )')
      else
        FormTabOrdem.TabList1.Items.Add(StrZero(TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo,4) + ' - ' +TabGlobal_i.DCAMPOST.NOME.Conteudo + ' ( ' + TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+' )');
      if TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo = 0 then
        FormTabOrdem.TabList1.Checked[FormTabOrdem.TabList1.Items.Count-1] := True
      else
        FormTabOrdem.TabList1.Checked[FormTabOrdem.TabList1.Items.Count-1] := False;
      TabGlobal_i.DCAMPOST.Next;
    end;
    FormTabOrdem.TabList1.Sorted := True;
    TabGlobal_i.DCAMPOST.EnableControls;
    GridCampos.ItemIndex := P;
    GridCamposClick(GridCampos);
    if FormTabOrdem.TabList1.Items.Count > 0 then
      FormTabOrdem.TabList1.ItemIndex := 0;
    if FormTabOrdem.ShowModal = mrOk then
    begin
      FormAguarde := TFormAguarde.Create(Application);
      FormAguarde.Caption := 'Aguarde! Redefinindo índices ...';
      FormAguarde.Show;
      FormAguarde.GaugeProcesso.Min := 0;
      FormAguarde.GaugeProcesso.Max := GridCampos.Items.Count-1;
      FormAguarde.GaugeProcesso.Position := 0;
      Modificou := True;
      TabGlobal_i.DCAMPOST.DisableControls;
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        Y := PCampo(TabGlobal_i.DCAMPOST.NOME.Conteudo);
        if Y > -1 then
        begin
          TabGlobal_i.DCAMPOST.Modifica;
          TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo := Y;
          if FormTabOrdem.TabList1.Checked[Y] then
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo := 0
          else
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo := 1;
          FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
          TabGlobal_i.DCAMPOST.Salva;
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      TabGlobal_i.DCAMPOST.EnableControls;
      FormAguarde.Free;
      GridCampos.ItemIndex := P;
      GridCamposClick(GridCampos);
    end;
  Finally
    FormTabOrdem.Free;
  end;
end;

procedure TFormEstruturas.BtnImportarClick(Sender: TObject);
begin
  if FREDT then
    if GridTabela.Items.Count >= 12 then
    begin
      Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de 12 '+^M+'Tabelas ...',modAdvertencia,[ModOk]);
      GridTabela.SetFocus;
      exit;
    end;
  FormImpEstrutura := TFormImpEstrutura.Create(Application);
  try
    if FormImpEstrutura.ShowModal = mrOk then
    begin
      Modificou := True;
      AtualizaLista(1);
      GridTabela.ItemIndex := 0;
      GridTabelaClick(GridTabela);
      //GridTabelaDblClick(GridTabela);
    end;
  finally
    FormImpEstrutura.Free;
  end;
end;

procedure TFormEstruturas.FormKeyUp(Sender: TObject; var Key: Word;
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

procedure TFormEstruturas.TB_EdFiltroInicialButtonClick(Sender: TObject);
var
  FormFiltro: TFormFiltro;
begin
  if TB_EdBanco.ReadOnly then exit;
  FormFiltro := TFormFiltro.Create(Application);
  Try
    FormFiltro.ExprMemo.Lines.Clear;
    FormFiltro.ExprMemo.Lines.AddStrings(TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo);
    FormFiltro.TabFiltro := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
    FormFiltro.TabNome := TabGlobal_i.DTABELAS.NOME.Conteudo;
    if FormFiltro.ShowModal = mrOk then
    begin
      TBlobField(TabGlobal_i.DTABELAS.FieldByName('FILTRO_INICIAL')).AsString := FormFiltro.ExprMemo.Lines.Text;
      TB_EdFiltroInicial.SetFocus;
      TB_EdNomeChange(Self);
    end;
  Finally
    FormFiltro.Free;
  end;
end;

procedure TFormEstruturas.TB_EdFiltroMestreButtonClick(Sender: TObject);
var
  FormFiltro: TFormFiltro;
begin
  if TB_EdBanco.ReadOnly then exit;
  FormFiltro := TFormFiltro.Create(Application);
  Try
    FormFiltro.ExprMemo.Lines.Clear;
    FormFiltro.ExprMemo.Lines.AddStrings(TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo);
    FormFiltro.TabFiltro := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
    FormFiltro.TabNome := TabGlobal_i.DTABELAS.NOME.Conteudo;
    if FormFiltro.ShowModal = mrOk then
    begin
      TBlobField(TabGlobal_i.DTABELAS.FieldByName('FILTRO_MESTRE')).AsString := FormFiltro.ExprMemo.Lines.Text;
      TB_EdFiltroMestre.SetFocus;
      TB_EdNomeChange(Self);
    end;
  Finally
    FormFiltro.Free;
  end;
end;

procedure TFormEstruturas.TB_EdNomeChange(Sender: TObject);
begin
  if Trim(TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo.Text) <> '' then
    TB_EdFiltroInicial.Text := Trim(TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo.Text)
  else
    TB_EdFiltroInicial.Text := '';
  if Trim(TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo.Text) <> '' then
    TB_EdFiltroMestre.Text := Trim(TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo.Text)
  else
    TB_EdFiltroMestre.Text := '';
  if Trim(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo) <> '' then
    TB_EdOrdemInicial.Text := Trim(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo)
  else
    TB_EdOrdemInicial.Text := '';
end;

procedure TFormEstruturas.IT_EdTipoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
begin
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if TabGlobal_i.DRELACIONA.TIPO.DescValorValido[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DRELACIONA.TIPO.ValorValido[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DRELACIONA.TIPO.DescValorValido[Index]));
end;

procedure TFormEstruturas.IT_EdTab_EstrangeiraButtonClick(Sender: TObject);
var
  xtabestrangeira, xcampochave_1, xcampochave_2, parte: String;
  i: integer;
begin
  FormRelacionamento := TFormRelacionamento.Create(Application);
  Try
    FormRelacionamento.Tipo := TabGlobal_i.DRELACIONA.TIPO.Conteudo;
    case TabGlobal_i.DRELACIONA.TIPO.Conteudo of
      1: begin
           FormRelacionamento.Caption := 'Relacionamento';
           FormRelacionamento.CamposEdTabela.Items.AddStrings(GridCampos.Items);
         end;
      2: begin
           FormRelacionamento.Caption := 'Exclusão Restrita';
           FormRelacionamento.CamposEdTabela.Items.AddStrings(GridCampos.Items);
         end;
      3: begin
           TabGlobal_i.DCAMPOST.First;
           while not TabGlobal_i.DCAMPOST.Eof do
           begin
             if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
               FormRelacionamento.CamposEdTabela.Items.Add(TabGlobal_i.DCAMPOST.NOME.Conteudo);
             TabGlobal_i.DCAMPOST.Next;
           end;
           FormRelacionamento.Caption := 'Exclusão em Cascata';
         end;
    end;
    FormRelacionamento.EdTabela.Text   := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' + TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
    FormRelacionamento.Tab_Estrangeira := TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo;
    FormRelacionamento.Campo_Chave_1   := TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo;
    FormRelacionamento.Campo_Chave_2   := TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo;
    if FormRelacionamento.ShowModal = mrOk then
    begin
      xtabestrangeira := FormRelacionamento.ComboTab.Text;
      xcampochave_1 := '';
      xcampochave_2 := '';
      for I:=0 to FormRelacionamento.CamposRelacionados.Items.Count-1 do
      begin
        parte := FormRelacionamento.CamposRelacionados.Items[I];
        parte := Trim(Copy(parte,01,Pos('<',Parte)-1));
        xcampochave_1 := xcampochave_1 + parte + ';';
        parte := FormRelacionamento.CamposRelacionados.Items[I];
        parte := Trim(Copy(parte,Pos('>',Parte)+1,Length(Parte)));
        xcampochave_2 := xcampochave_2 + parte + ';';
      end;
      if Copy(xcampochave_1,Length(xcampochave_1),01) = ';' then
        xcampochave_1 := Copy(xcampochave_1,01,Length(xcampochave_1)-1);
      if Copy(xcampochave_2,Length(xcampochave_2),01) = ';' then
        xcampochave_2 := Copy(xcampochave_2,01,Length(xcampochave_2)-1);
      TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo := xtabestrangeira;
      TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo  := xcampochave_1;
      TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo  := xcampochave_2;
      Modificou := True;
    end;
  Finally
    FormRelacionamento.Free;
  end;
end;

procedure TFormEstruturas.IT_EdTitulo_iExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not IT_EdTitulo_i.ReadOnly) and (Trim(TabGlobal_i.DRELACIONA.TITULO_I.Conteudo) = '') then
  begin
    Mensagem('Necessário informar Título !',ModAdvertencia,[ModOk]);
    IT_EdTitulo_i.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.IT_EdTipoExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not IT_EdTipo.ReadOnly) and (TabGlobal_i.DRELACIONA.TIPO.Conteudo < 1) then
  begin
    Mensagem('Necessário informar Tipo !',ModAdvertencia,[ModOk]);
    IT_EdTipo.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.CS_EdCodificacaoButtonClick(Sender: TObject);
begin
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.E_Cabecalho.Visible := False;
    FormMiniEditor.ExcluirEvento.Visible := False;
    FormMiniEditor.Posicao_Y := 1;
    FormMiniEditor.E_Metodo.Lines.AddStrings(TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo);
    if FormMiniEditor.ShowModal = mrOk then
    begin
      TabGlobal_i.DCASCATAT.Modifica;
      TBlobField(TabGlobal_i.DCASCATAT.FieldByName('CODIFICACAO')).AsString := FormMiniEditor.E_Metodo.Lines.Text;
      TabGlobal_i.DCASCATAT.Salva;
      Atualiza_Integridade;
      if not Gr_Compat.Visible then
        if GridIntegridade.Enabled then
          GridIntegridade.SetFocus
        else
          if PgIntegridade.Enabled then
            IT_EdTitulo_i.SetFocus;
      Modificou := True;
    end;
  Finally
    FormMiniEditor.Free;
  end;
end;

procedure TFormEstruturas.RS_EdCodificacaoButtonClick(Sender: TObject);
begin
  FormMiniEditor := TFormMiniEditor.Create(Application);
  Try
    FormMiniEditor.E_Cabecalho.Visible := False;
    FormMiniEditor.ExcluirEvento.Visible := False;
    FormMiniEditor.Posicao_Y := 1;
    FormMiniEditor.E_Metodo.Lines.AddStrings(TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo);
    if FormMiniEditor.ShowModal = mrOk then
    begin
      TabGlobal_i.DRESTRITAT.Modifica;
      TBlobField(TabGlobal_i.DRESTRITAT.FieldByName('CODIFICACAO')).AsString := FormMiniEditor.E_Metodo.Lines.Text;
      TabGlobal_i.DRESTRITAT.Salva;
      Atualiza_Integridade;
      if not Gr_Compat.Visible then
        if GridIntegridade.Enabled then
          GridIntegridade.SetFocus
        else
          if PgIntegridade.Enabled then
            IT_EdTitulo_i.SetFocus;
      Modificou := True;
    end;
  Finally
    FormMiniEditor.Free;
  end;
end;

procedure TFormEstruturas.IT_EdTab_EstrangeiraExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not IT_EdTab_Estrangeira.ReadOnly) and (Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo) = '') then
  begin
    Mensagem('Necessário informar Relacionamento !',ModAdvertencia,[ModOk]);
    IT_EdTab_Estrangeira.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.CP_EdSequenciaExit(Sender: TObject);
begin
  if TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo <> 0 then
  begin
    CP_EdSempreAtribui.Enabled := True;
    if (TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1) and (TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo > 1) and
       (TabGlobal_i.DCAMPOST.Modificacao or TabGlobal_i.DCAMPOST.Inclusao) then
      TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo := 1;
  end
  else
  begin
    if (TabGlobal_i.DCAMPOST.Modificacao or TabGlobal_i.DCAMPOST.Inclusao) then
      TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo := 0;
    CP_EdSempreAtribui.Enabled := False;
  end;
end;

procedure TFormEstruturas.CP_EdSempreAtribuiExit(Sender: TObject);
begin
  NoPrincipal.SetFocus;
  if (ActiveControl = BtnCancela) or (ActiveControl = BtnSalvar) then exit;
  TabSet1.TabIndex := 1;
  TabSet1Click(Self);
  CP_EdPreValidacao.SelectAll;
  CP_EdPreValidacao.SetFocus;
end;

procedure TFormEstruturas.BtnCamposExtraClick(Sender: TObject);
Var
  I, Seq: Integer;
  Herdou: Boolean;
  xnome, xmascara, xtitulo_c, xajuda, xpadrao, xvalidacao, xvalidos, xdescricao,
  xprevalidacao, xmsgerro, xtabestrangeira, xcampochave, xcamposvisuais, xtab_extra, xcampoextra: String;
  xtipo, xtamanho, xedicao, xchave, xcalculado, xautoincremento, xinvisivel,
  xtipoprevalidacao, xlimparcampo, xseq, xsempreatribui, xindiceconsulta, xestilochave: integer;
  xvariaveis, xcodificacao: TStringList;
begin
  if GridTabela.ItemIndex < 0 then
  begin
    Mensagem('Tabela não selecionada !',modAdvertencia,[modOk]);
    if GridTabela.Enabled then
      GridTabela.SetFocus;
    exit;
  end;
  TabGlobal_i.DCAMPOST.DisableControls;
  TabGlobal_i.DCAMPOST.Last;
  Seq := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo + 1;
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    TabGlobal_i.DRELACIONA.DisableControls;
    TabGlobal_i.DRELACIONA.First;
    FormCamposProj.Ver_Extras := True;
    FormCamposProj.not_Ver_Relacionados := True;
    FormCamposProj.Extras := '';
    while not TabGlobal_i.DRELACIONA.Eof do
    begin
      if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
        FormCamposProj.Extras := FormCamposProj.Extras + TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo+';';
      TabGlobal_i.DRELACIONA.Next;
    end;
    TabGlobal_i.DRELACIONA.EnableControls;
    FormCamposProj.Tipo := 1;
    FormCamposProj.Escolha := True;
    if FormCamposProj.ShowModal = mrOk then
    begin
      for I:=0 to FormCamposProj.FieldsLB_S.Items.Count-1 do
        if FormCamposProj.FieldsLB_S.Checked[I] then
        begin
          Modificou := True;
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+FormCamposProj.Retorno+ 'AND SEQUENCIA = '+IntToStr(Integer(FormCamposProj.FieldsLB_S.Items.Objects[I]));
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          if (not TabGlobal_i.DCAMPOST.Eof) then
          begin
            xseq       := TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo;
            xnome      := TabGlobal_i.DCAMPOST.NOME.Conteudo;
            xcampoextra:= TabGlobal_i.DCAMPOST.NOME.Conteudo;
            xtipo      := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
            xtamanho   := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
            xedicao    := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
            xmascara   := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
            xtitulo_c  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
            xajuda     := TabGlobal_i.DCAMPOST.AJUDA.Conteudo;
            xpadrao    := TabGlobal_i.DCAMPOST.PADRAO.Conteudo;
            xvalidacao := TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo;
            xvalidos   := TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text;
            xdescricao := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text;
            //xchave     := TabGlobal_i.DCAMPOST.CHAVE.Conteudo;
            xchave := 0;
            xcalculado := TabGlobal_i.DCAMPOST.CALCULADO.Conteudo;
            //xautoincremento   := TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo;
            xautoincremento   := 0;
            xinvisivel        := TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo;
            //xprevalidacao     := TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo;
            xprevalidacao     := '';
            xtipoprevalidacao := TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo;
            //xlimparcampo      := TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo;
            xlimparcampo      := 0;
            xmsgerro          := TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo;
            xtabestrangeira   := TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo;
            xcampochave       := TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo;
            xcamposvisuais    := TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo;
            xindiceconsulta   := TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo;
            xestilochave      := TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo;
            xtab_extra        := FormCamposProj.Retorno1;
            xsempreatribui    := 0;

            herdou := False;
            while not Herdou do
            begin
              TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND NOME = '+#39+xnome+#39;
              TabGlobal_i.DCAMPOST.AtualizaSql;
              if (TabGlobal_i.DCAMPOST.Eof) and (ValidaNomeCampo(xNome)) then
                Herdou := True
              else
              begin
                InputQuery('Duplicidade !', 'Nome já existente, informe outro nome ...', xnome);
                xnome := UpperCase(xnome);
              end;
            end;
            TabGlobal_i.DCAMPOST.Inclui(Nil);
            TabGlobal_i.DCAMPOST.NUMERO.Conteudo    := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
            TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Seq;
            TabGlobal_i.DCAMPOST.NOME.Conteudo      := xnome;
            TabGlobal_i.DCAMPOST.TIPO.Conteudo      := xtipo;
            TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := xtamanho;
            TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := xedicao;
            TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := xmascara;
            TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := xtitulo_c;
            TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := xajuda;
            TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := '';
            TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := '';
            TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text   := xvalidos;
            TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text := xdescricao;
            TabGlobal_i.DCAMPOST.CHAVE.Conteudo     := xchave;
            TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := xcalculado;
            TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo     := xautoincremento;
            TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo     := xsempreatribui;
            TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo          := xinvisivel;
            TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo      := xprevalidacao;
            TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo := xtipoprevalidacao;
            TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo       := xlimparcampo;
            TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo           := xmsgerro;
            TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo    := xtabestrangeira;
            TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo        := xcampochave;
            TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo     := xcamposvisuais;
            TabGlobal_i.DCAMPOST.EXTRA.Conteudo              := 1;
            TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo          := xtab_extra;
            TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo        := xcampoextra;
            TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo    := Seq;
            TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo       := xestilochave;
            TabGlobal_i.DCAMPOST.Salva;
            Inc(Seq);
          end;
        end;
      GridTabelaClick(GridTabela);
      GridCamposClick(GridCampos);
    end;
  Finally
    FormCamposProj.Free;
    TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
    TabGlobal_i.DCAMPOST.AtualizaSql;
    TabGlobal_i.DCAMPOST.First;
    TabGlobal_i.DCAMPOST.EnableControls;
  end;
end;

procedure TFormEstruturas.PnProcessosClick(Sender: TObject);
begin
  if (GridProcessos.ItemIndex < 0) then
    if GridProcessos.Items.Count > 0 then
      GridProcessos.ItemIndex := 0;
  if GridProcessos.ItemIndex > -1 then
    TabGlobal_i.DPROCESSOS.Locate('SEQUENCIA',Integer(GridProcessos.Items.Objects[GridProcessos.ItemIndex]),[]);
  BtnCalculo.Enabled := False;
  BtnChEst.Enabled := False;
  Habilita_Escolha(TControl(Sender).Tag);
end;

procedure TFormEstruturas.PR_EdTipoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
begin
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if TabGlobal_i.DPROCESSOS.TIPO.DescValorValido[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DPROCESSOS.TIPO.ValorValido[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DPROCESSOS.TIPO.DescValorValido[Index]));
end;

procedure TFormEstruturas.PR_EdTitulo_iExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not PR_EdTitulo_i.ReadOnly) and (Trim(TabGlobal_i.DPROCESSOS.TITULO_I.Conteudo) = '') then
  begin
    Mensagem('Necessário informar Título !',ModAdvertencia,[ModOk]);
    PR_EdTitulo_i.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.PR_EdTipoExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not PR_EdTipo.ReadOnly) and (TabGlobal_i.DPROCESSOS.TIPO.Conteudo < 1) then
  begin
    Mensagem('Necessário informar Tipo !',ModAdvertencia,[ModOk]);
    PR_EdTipo.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.PR_EdTab_AlvoExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not PR_EdTab_Alvo.ReadOnly) and (Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo) = '') then
  begin
    Mensagem('Necessário informar Processo/Lançamento !',ModAdvertencia,[ModOk]);
    PR_EdTab_Alvo.SetFocus;
    exit;
  end;
end;

procedure TFormEstruturas.PR_EdTab_AlvoButtonClick(Sender: TObject);
var
  I: Integer;
  Lst_1, Lst_2: TStringList;
begin
  if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 1 then
  begin
    FormProcessos := TFormProcessos.Create(Application);
    try
      FormProcessos.PR_EdTab_alvo.DataSource := Nil;
      FormProcessos.PR_EdTab_alvo.Items.Clear;
      FormProcessos.PR_EdTab_alvo.Items.AddStrings(CP_EdTab_Pesquisa.Items);
      FormProcessos.PR_EdTab_alvo.DataSource := DataSource6;
      FormProcessos.PR_EdTab_alvoExit(Self);
      if FormProcessos.ShowModal = mrOk then
      begin
        Modificou := True;
      end;
    Finally
      FormProcessos.Free;
    end;
  end
  else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 2 then
  begin
    FormLanctos := TFormLanctos.Create(Application);
    try
      FormLanctos.PR_EdTab_alvo.DataSource := Nil;
      FormLanctos.PR_EdTab_alvo.Items.Clear;
      FormLanctos.PR_EdTab_alvo.Items.AddStrings(GridTabela.Items);
      FormLanctos.PR_EdTab_alvo.DataSource := DataSource6;
      FormLanctos.PR_EdTab_alvoExit(Self);
      if FormLanctos.ShowModal = mrOk then
      begin
        Lst_1 := TStringList.Create;
        Lst_2 := TStringList.Create;
        for I:=0 to FormLanctos.GridCampos.Items.Count-1 do
        begin
          Lst_1.Add(FormLanctos.GridCampos.Items[I]);
          Lst_2.Add(FormLanctos.GridValores.Items[I]);
        end;
        TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_ALVO')).AsString := Lst_1.Text;
        TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('CAMPOS_VALOR')).AsString := Lst_2.Text;
        Lst_1.Free;
        Lst_2.Free;
        Modificou := True;
      end;
    Finally
      FormLanctos.Free;
    end;
  end
  else if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo >= 3) and
          (TabGlobal_i.DPROCESSOS.TIPO.Conteudo <= 5) then
  begin
    FormMiniEditor := TFormMiniEditor.Create(Application);
    Try
      FormMiniEditor.E_Cabecalho.Visible := True;
      FormMiniEditor.E_Cabecalho.ReadOnly := False;
      FormMiniEditor.ExcluirEvento.Visible := False;
      FormMiniEditor.Posicao_Y := 1;
      FormMiniEditor.E_Cabecalho.Lines.AddStrings(TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo);
      FormMiniEditor.E_Metodo.Lines.AddStrings(TabGlobal_i.DPROCESSOS.AVULSO.Conteudo);
      if Trim(FormMiniEditor.E_Cabecalho.Lines.Text) = '' then
      begin
        FormMiniEditor.E_Cabecalho.Lines.Clear;
        FormMiniEditor.E_Cabecalho.Lines.Add('// Variáveis Locais');
        FormMiniEditor.E_Cabecalho.Lines.Add('');
      end;
      if FormMiniEditor.ShowModal = mrOk then
      begin
        TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('AVULSO')).AsString := FormMiniEditor.E_Metodo.Lines.Text;
        TBlobField(TabGlobal_i.DPROCESSOS.FieldByName('AVULSO_VAR')).AsString := FormMiniEditor.E_Cabecalho.Lines.Text;
        TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo := 'Avulso';
        Modificou := True;
      end;
    Finally
      FormMiniEditor.Free;
    end;
  end;
end;

procedure TFormEstruturas.TB_EdOrdemInicialButtonClick(Sender: TObject);
var
  FormFiltro: TFormFiltro;
  ListaCmp: TStringList;
  I: Integer;
begin
  if TB_EdBanco.ReadOnly then exit;
  FormOrdenacao := TFormOrdenacao.Create(Application);
  Try
    if TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo = 1 then
      FormOrdenacao.EdDecrescente.Checked := True
    else
      FormOrdenacao.EdDecrescente.Checked := False;
    FormOrdenacao.TabFiltro := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
    FormOrdenacao.TabNome := TabGlobal_i.DTABELAS.NOME.Conteudo;
    ListaCmp := TStringList.Create;
    StringToArray(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo,',',ListaCmp);
    for I:=0 to ListaCmp.Count-1 do
      FormOrdenacao.CamposIndices.Items.Add(ListaCmp[I]);
    ListaCmp.Free;
    if FormOrdenacao.ShowModal = mrOk then
    begin
      TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo := '';
      for I:=0 to FormOrdenacao.CamposIndices.Items.Count-1 do
        TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo := TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo + FormOrdenacao.CamposIndices.Items[I] + ',';
      if Copy(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo,Length(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo),01) = ',' then
        TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo := Copy(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo,01,Length(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo)-1);
      if FormOrdenacao.EdDecrescente.Checked then
        TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo := 1
      else
        TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo := 0;
      TB_EdOrdemInicial.SetFocus;
      TB_EdNomeChange(Self);
    end;
  Finally
    FormOrdenacao.Free;
  end;
end;

procedure TFormEstruturas.CamposOrigemDrawItem(Control: TWinControl;
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
    if Tag = 100  then
      Image := Image2
    else
    begin
      if Integer(Items.Objects[Index]) = 0 then
        Image := Image3
      else
        Image := Image2;
    end;
    if Image <> nil then
      Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
        Image.Picture.Bitmap.TransparentColor);
     Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormEstruturas.BthAjudaTabelaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

procedure TFormEstruturas.CP_EdTamanhoExit(Sender: TObject);
begin
  if (ActiveControl = BtnCancela) then exit;
  if (not CP_EdTamanho.ReadOnly) and (TabGlobal_i.DCAMPOST.TAMANHO.Conteudo <= 0) then
  begin
    Mensagem('Necessário informar Tamanho !',ModAdvertencia,[ModOk]);
    CP_EdTamanho.SelectAll;
    CP_EdTamanho.SetFocus;
  end;
end;

procedure TFormEstruturas.CP_EdAjudaEnter(Sender: TObject);
begin
  if (Trim(TabGlobal_i.DCAMPOST.AJUDA.Conteudo) = '') and
     (TabGlobal_i.DCAMPOST.Inclusao) then
  begin
    if TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 5 then
      TabGlobal_i.DCAMPOST.AJUDA.Conteudo := 'Informe o ' + Trim(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo) + '  (F8) = Consulta'
    else
      TabGlobal_i.DCAMPOST.AJUDA.Conteudo := 'Informe o ' + Trim(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo);
  end;
end;

end.
