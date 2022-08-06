{
   Programa.: Publicas.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Publicas;

interface

uses Classes, ComCtrls, Sysutils, IniFiles, forms;

type
  TTipoDado = (tpAlfanumerico, tpInteiro, tpFracionario,
               tpData, tpMemo, tpImagem,
               tpString, tpSmallint, tpInteger,
               tpWord, tpBoolean, tpFloat,
               tpCurrency, tpDate, tpTime,
               tpDateTime, tpBytes, tpAutoInc,
               tpBlob, tpGraphic, tpWideString,
               tpLargeInt, tpVariant, tpBCD);

  TTipoEdicao = (tpEdit, tpSpinEdit, tpComboDrop, tpRadioButton, tpCheckBox);

procedure Inicializa;  // Inicializa variáveis públicas
procedure InicializaAmbiente;  // Inicializa ambiente de trabalho

Type
  TSistema = Record
    Titulo        : String;
    Versao        : String;
    Analista      : String;
    Programador   : String;
    Projetista    : String;
    EstiloData    : String;
    ConfirmaSaida : Boolean;
    ControleAcesso: Boolean;
    SenhaInicial  : String;
    HintBalao     : Boolean;
    MenuXP        : Boolean;
    Pasta         : String;
    Usuario       : String;
    Senha         : String;
    Master        : Boolean;
    Grupo         : String;
    ListaUsuarios : TStringList;
    Menu          : TTreeView;
    SelecionaUsr  : Boolean;
    NumeroUsr     : Integer;
    EmpresaUsr    : String;
    EnderecoUsr   : String;
    BairroUsr     : String;
    CidadeUsr     : String;
    UfUsr         : String;
    CEPUsr        : String;
    CNPJUsr       : String;
    IEUsr         : String;
    FonesUsr      : String;
    LogoUsr       : String;
    JanelasMDI    : Integer;
    Sql           : Integer;
    Rede          : Boolean;
    Log           : Boolean;
    Integridade   : Boolean;
    MenuVertical  : Boolean;
    BannerVertical: Boolean;
    BarraF        : Boolean;
    OpcoesAcesso  : TStringList;
    OpcoesAcessoMn: TStringList;
    OpcoesAcessoBr: TStringList;
    OpcoesTabela  : TStringList;
    BancoDados    : String;
    ErroFatal     : Boolean;
    Conexao_i     : TDateTime;
    Conexao_f     : TDateTime;
    Estacao       : String;
end;

Var
  Sistema : TSistema;

implementation

uses Rotinas, Princ, Extras;

procedure Inicializa;  // Inicializa variáveis públicas
var
  ICQmsg: TMessenger;
Begin
  {10-Início do Bloco Modular. Modificações não serão preservadas}
  with Sistema Do
  Begin
    Titulo         := 'Projeto Exemplo de Vendas';
    Versao         := '1.1';
    Analista       := 'Alberto Henrique';
    Programador    := '';
    Projetista     := 'Modular Software';
    EstiloData     := 'dd/mm/yy';
    ConfirmaSaida  := True;
    ControleAcesso := True;
    SenhaInicial   := '';
    HintBalao      := False;
    MenuXP         := True;
    Pasta          := '';
    Usuario        := '';
    Senha          := '';
    Master         := True;
    Grupo          := '';
    ListaUsuarios  := TStringList.Create;
    SelecionaUsr   := False;
    NumeroUsr      := 0;
    EmpresaUsr     := '';
    EnderecoUsr    := '';
    BairroUsr      := '';
    CidadeUsr      := '';
    UfUsr          := '';
    CEPUsr         := '';
    CNPJUsr        := '';
    IEUsr          := '';
    FonesUsr       := '';
    LogoUsr        := '';
    JanelasMDI     := 0;
    Sql            := 3;
    Rede           := True;
    Log            := True;
    Integridade    := True;
    MenuVertical   := True;
    BarraF         := True;
    BannerVertical := True;
    ErroFatal      := False;
    OpcoesAcesso   := TStringList.Create;
    OpcoesAcessoMn := TStringList.Create;
    OpcoesAcessoBr := TStringList.Create;
    OpcoesTabela   := TStringList.Create;
    OpcoesAcesso.Clear;
    OpcoesAcessoMn.Clear;
    OpcoesAcessoBr.Clear;
    OpcoesTabela.Clear;
  End;
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  ICQmsg := TMessenger.Create(Application);
  try
    Sistema.Estacao := ICQmsg.Computer;
  finally
    ICQmsg.Free;
  end;
End;

procedure InicializaAmbiente;
Var
  ArqIni: TIniFile;
begin
  ArqIni := TInifile.Create(DiretorioComBarra(ExtractFilePath(Application.ExeName))+
            ChangeFileExt(ExtractFileName(Application.ExeName), '.ini'));
  if Trim(ArqIni.readstring('AMBIENTE', 'Rede', '')) = '' then
    if Sistema.Rede then
      ArqIni.WriteString('AMBIENTE', 'Rede', '1')
    else
      ArqIni.WriteString('AMBIENTE', 'Rede', '0');
  if Trim(ArqIni.readstring('AMBIENTE', 'Integridade', '')) = '' then
    if Sistema.Integridade then
      ArqIni.WriteString('AMBIENTE', 'Integridade', '1')
    else
      ArqIni.WriteString('AMBIENTE', 'Integridade', '0');
  if Trim(ArqIni.readstring('AMBIENTE', 'ConfirmaSaida', '')) = '' then
    if Sistema.ConfirmaSaida then
      ArqIni.WriteString('AMBIENTE', 'ConfirmaSaida', '1')
    else
      ArqIni.WriteString('AMBIENTE', 'ConfirmaSaida', '0');
  if Trim(ArqIni.readstring('AMBIENTE', 'EstiloBalao', '')) = '' then
    if Sistema.HintBalao then
      ArqIni.WriteString('AMBIENTE', 'EstiloBalao', '1')
    else
      ArqIni.WriteString('AMBIENTE', 'EstiloBalao', '0');
  if Trim(ArqIni.readstring('AMBIENTE', 'MenuXP', '')) = '' then
    if Sistema.MenuXP then
      ArqIni.WriteString('AMBIENTE', 'MenuXP', '1')
    else
      ArqIni.WriteString('AMBIENTE', 'MenuXP', '0');
  if Trim(ArqIni.readstring('AMBIENTE', 'SelecionarEmpresa', '')) = '' then
    if Sistema.SelecionaUsr then
      ArqIni.WriteString('AMBIENTE', 'SelecionarEmpresa', '1')
    else
      ArqIni.WriteString('AMBIENTE', 'SelecionarEmpresa', '0');
  if Trim(ArqIni.readstring('AMBIENTE', 'PapelParede', '')) = '' then
    ArqIni.WriteString('AMBIENTE', 'PapelParede', '1');
  if Assigned(FormPrincipal) then
    if Trim(ArqIni.readstring('AMBIENTE', 'Ajustada', '')) = '' then
      if FormPrincipal.ImagemFundo.Stretch then
        ArqIni.WriteString('AMBIENTE', 'Ajustada', '1')
      else
        ArqIni.WriteString('AMBIENTE', 'Ajustada', '0');
  Sistema.Pasta       := Trim(ArqIni.ReadString('AMBIENTE', 'PastaBasica', ''));
  if Sistema.Pasta = '' then
    Sistema.Pasta     := ExtractFilePath(Application.ExeName);
  Sistema.Pasta       := DiretorioComBarra(Sistema.Pasta);
  if ArqIni.ReadString('AMBIENTE', 'Rede', '') = '1' then
    Sistema.Rede := True
  else
    Sistema.Rede := False;
  if ArqIni.ReadString('AMBIENTE', 'Integridade', '') = '1' then
    Sistema.Integridade := True
  else
    Sistema.Integridade := False;
  if ArqIni.ReadString('AMBIENTE', 'ConfirmaSaida', '') = '1' then
    Sistema.ConfirmaSaida := True
  else
    Sistema.ConfirmaSaida := False;
  if ArqIni.readstring('AMBIENTE', 'EstiloBalao', '') = '1' then
    Sistema.HintBalao := True
  else
    Sistema.HintBalao := False;
  if ArqIni.readstring('AMBIENTE', 'MenuXP', '') = '1' then
    Sistema.MenuXP := True
  else
    Sistema.MenuXP := False;
  if ArqIni.readstring('AMBIENTE', 'SelecionarEmpresa', '') = '1' then
    Sistema.SelecionaUsr := True
  else
    Sistema.SelecionaUsr := False;
  if Assigned(FormPrincipal) then
  begin
    if ArqIni.readstring('AMBIENTE', 'PapelParede', '') = '1' then
      FormPrincipal.ImagemFundo.Visible := True
    else
      FormPrincipal.ImagemFundo.Visible := False;
    if FileExists(ArqIni.readstring('AMBIENTE', 'Imagem', '')) then
      FormPrincipal.ImagemFundo.Picture.LoadFromFile(ArqIni.readstring('AMBIENTE', 'Imagem', ''));
    if ArqIni.readstring('AMBIENTE', 'Ajustada', '') = '1' then
      FormPrincipal.ImagemFundo.Stretch := True
    else
      FormPrincipal.ImagemFundo.Stretch := False;
  end;    
  ArqIni.Free;
end;

end.
