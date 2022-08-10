{
   Programa.: Abertura.PAS
   Copyright: X-Maker
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Abertura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$I LTab.pas}
  Tabela, db;

type
  TTabGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CamposCalculados;
  public
    { Public declarations }
    {01-Início do Bloco X-Maker. Modificações não serão preservadas}
    {99-Final do Bloco X-Maker. Modificações não serão preservadas}
    procedure AbrirTabelas;
    procedure FecharTabelas(Finalizar: Boolean);
    procedure Executa_Scripts_Criacao_BD;
    procedure Executa_Scripts_Inicializacao;
    procedure Executa_Scripts_Finalizacao;
  end;

var
  TabGlobal: TTabGlobal;

implementation

{$R *.DFM}

uses Splash, BaseD, Atributo, Calculos, SelEmp, Princ, Publicas;

procedure TTabGlobal.AbrirTabelas;
var
  I, Y: Integer;
  Tabela: TTabela;
  Indexar_Tab: TList;
begin
  try
    Sistema.Conexao_i := Time;
    FormSplash := TFormSplash.Create(Application);
    FormSplash.Caption := 'Aguarde!, Inicializando Sistema...';
    FormSplash.GaugeProcesso.Min := 0;
    FormSplash.GaugeProcesso.Max := BaseDados.ListaNomeTabelas.Count;
    FormSplash.Show;
    Indexar_Tab := TList.Create;
    BaseDados.ListaNomeTabelas_DB.Clear;
    for I := 0 to Lst_Tabelas.Count - 1 do
    begin
      Tabela := TTabela(Lst_Tabelas[I]);
      FormSplash.LbTitulo.Caption := 'Verificando: ' + Tabela.Titulo;
      Application.ProcessMessages;
      if (Tabela.Owner = Self) and (not Tabela.Existe) then
      begin
        FormSplash.LbTitulo.Caption := 'Criando tabela: ' + Tabela.Titulo;
        Application.ProcessMessages;
        Tabela.CriaTabela(False);
        Indexar_Tab.Add(Tabela);
      end;
      FormSplash.GaugeProcesso.Position := FormSplash.GaugeProcesso.Position + 1;
    end;
    FormSplash.GaugeProcesso.Position := 0;
    if Indexar_Tab.Count > 0 then
      BaseDados.ListaNomeTabelas_DB.Clear;
    for I := 0 to Indexar_Tab.Count - 1 do
    begin
      FormSplash.LbTitulo.Caption := 'Criando índices: ' + Tabela.Titulo;
      Application.ProcessMessages;
      TTabela(Indexar_Tab[I]).Indexar;
      FormSplash.GaugeProcesso.Position := FormSplash.GaugeProcesso.Position + 1;
    end;
    Indexar_Tab.Free;
    FormSplash.GaugeProcesso.Position := 0;
    for I := 0 to Lst_Tabelas.Count - 1 do
    begin
      Tabela := TTabela(Lst_Tabelas[I]);
      FormSplash.LbTitulo.Caption := 'Abrindo: ' + Tabela.Titulo;
      Application.ProcessMessages;
      if (Tabela.Owner = Self) and (Tabela.Existe) then
      begin
        if Tabela.Open_Begin then
          Tabela.Abrir;
        for Y := 0 to Tabela.Campos.Count -1 do
          TAtributo(Tabela.Campos[Y]).ConfiguraMascara;
      end;
      FormSplash.GaugeProcesso.Position := FormSplash.GaugeProcesso.Position + 1;
    end;
    FormSplash.GaugeProcesso.Position := 0;
    FormSplash.GaugeProcesso.Min := 0;
    FormSplash.GaugeProcesso.Max := Lst_Procedures.Count;
    for I := 0 to Lst_Procedures.Count - 1 do
    begin
      with TSQLProcedure(Lst_Procedures[I]) do
      begin
        FormSplash.LbTitulo.Caption := 'Procedimento: ' + NomeProcedure;
        Application.ProcessMessages;
        Criar;
        FormSplash.GaugeProcesso.Position := FormSplash.GaugeProcesso.Position + 1;
      end;
    end;
    FormSplash.GaugeProcesso.Position := 0;
    FormSplash.GaugeProcesso.Min := 0;
    FormSplash.GaugeProcesso.Max := Lst_Triggers.Count;
    for I := 0 to Lst_Triggers.Count - 1 do
    begin
      with TSQLScript(Lst_Triggers[I]) do
      begin
        FormSplash.LbTitulo.Caption := 'Processos: ' + NomeTrigger;
        Application.ProcessMessages;
        Criar_Trigger;
        FormSplash.GaugeProcesso.Position := FormSplash.GaugeProcesso.Position + 1;
      end;
    end;
    Executa_Scripts_Inicializacao;
    FormSplash.Free;
    Sistema.Conexao_f := Time;
  except
    on Erro: Exception do
    begin
      if Assigned(FormSplash) then
        FormSplash.Free;
      MessageDlg('Erro de Inicialização!' + ^M+^M + Erro.Message, mtError, [mbOk], 0);
      Sistema.ErroFatal := True;
    end;
  end;
end;

procedure TTabGlobal.DataModuleCreate(Sender: TObject);
var
  I: Integer;
  Tabela: TTabela;
  Master: Boolean;
begin
  Lst_Procedures := TList.Create;
  Lst_Triggers   := TList.Create;
  {02-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
  if not FormPrincipal.ErronoSistema then
  begin
    CamposCalculados;
    if I = 0 then
      AbrirTabelas;
    if BaseDados.Criou_BD then
      Executa_Scripts_Criacao_BD;
  end;
end;

procedure TTabGlobal.DataModuleDestroy(Sender: TObject);
begin
  Lst_Procedures.Free;
  Lst_Triggers.Free;
  FecharTabelas(True);
end;

procedure TTabGlobal.FecharTabelas(Finalizar: Boolean);
var
  I: Integer;
  Tabela: TTabela;
begin
  try
    Executa_Scripts_Finalizacao;
    if Lst_Tabelas = Nil then
      exit;
    for I := (Lst_Tabelas.Count - 1) downto 0 do
    begin
      Tabela := TTabela(Lst_Tabelas[I]);
      if Tabela.Owner = Self then
      begin
        if Tabela.Active then
          Tabela.Close;
        if Finalizar then
          Tabela.Free;
      end;
    end;
    if Finalizar and (Lst_Tabelas.Count = 0) then
    begin
      Lst_Tabelas.Free;
      Lst_Tabelas := nil;
    end;
  except
    on Erro: Exception do
    begin
      MessageDlg('Erro: ' + Erro.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TTabGlobal.Executa_Scripts_Criacao_BD;
var
  I: Integer;
begin
  {05-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
  for I:=0 to Lst_Tabelas.Count-1 do
    if TTabela(Lst_Tabelas[I]).TableType = ttTable then
      TTabela(Lst_Tabelas[I]).CriaForeignKeys;
end;

procedure TTabGlobal.Executa_Scripts_Inicializacao;
begin
  {06-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
end;

procedure TTabGlobal.Executa_Scripts_Finalizacao;
begin
  {07-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
end;

procedure TTabGlobal.CamposCalculados;
begin
  {03-Início do Bloco X-Maker. Modificações não serão preservadas}
  {99-Final do Bloco X-Maker. Modificações não serão preservadas}
end;

{04-Início do Bloco X-Maker. Modificações não serão preservadas}
{99-Final do Bloco X-Maker. Modificações não serão preservadas}

end.
