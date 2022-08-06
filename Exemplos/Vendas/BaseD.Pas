{
   Programa.: BaseD.PAS
   Copyright: Modular Software 2004
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit BaseD;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IBDatabase,
  {$IFDEF IBX}
  IBCustomDataSet,
  {$ELSE}
  XSEngine,
  {$ENDIF}
  Db, IniFiles, FileCtrl, FR_E_HTM, FR_E_CSV, FR_E_RTF, FR_E_TXT, FR_Desgn,
  FR_Shape, FR_Rich, FR_OLE, FR_ChBox, FR_RRect, FR_Chart, FR_BarC;

type
  TBaseDados = class(TDataModule)
    frTextExport: TfrTextExport;
    frRTFExport: TfrRTFExport;
    frCSVExport: TfrCSVExport;
    frHTMExport: TfrHTMExport;
    frDesigner1: TfrDesigner;
    frBarCodeObject: TfrBarCodeObject;
    frChartObject: TfrChartObject;
    frRoundRectObject: TfrRoundRectObject;
    frCheckBoxObject: TfrCheckBoxObject;
    frOLEObject: TfrOLEObject;
    frRichObject: TfrRichObject;
    frShapeObject: TfrShapeObject;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    {10-Início do Bloco Modular. Modificações não serão preservadas}
    BD_Base_Dados: TIBDataBase;
    TRS_BD_Base_Dados: TIBTransaction;
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    ListaBaseDados : TStringList;
    ListaBaseDadosArq: TStringList;
    ListaBaseDadosHost: TStringList;
    ListaNomeTabelas: TStringList;
    ListaNomeTabelas_DB: TStringList;
    Criou_BD: Boolean;
    function AplicarAtualizacao(DataSet: TDataSet; Apply: Boolean): Boolean;
  end;

var
  BaseDados: TBaseDados;

implementation

{$R *.DFM}

uses Rotinas, Publicas;

procedure TBaseDados.DataModuleCreate(Sender: TObject);
Var
  DataFile, Host, Usuario, Senha: String;
  Servidor: Integer;
  ArqIni: TIniFile;
begin
  try
    Inicializa;
    InicializaAmbiente;
    ArqIni              := TInifile.Create( Sistema.Pasta + 'SYSEMP.DAT');
    ListaBaseDados      := TStringList.Create;
    ListaBaseDadosArq   := TStringList.Create;
    ListaBaseDadosHost  := TStringList.Create;
    ListaNomeTabelas    := TStringList.Create;
    ListaNomeTabelas_DB := TStringList.Create;
    {20-Início do Bloco Modular. Modificações não serão preservadas}
    TRS_BD_Base_Dados:= TIBTransaction.Create(Self);
    with TRS_BD_Base_Dados do
    begin
      Active := False;
      DefaultDatabase := BD_Base_Dados;
      Params.Add('read_committed');
      Params.Add('rec_version');
      Params.Add('nowait');
      Name := 'TRS_BD_Base_Dados';
    end;
    BD_Base_Dados := TIBDatabase.Create(Self);
    with BD_Base_Dados do
    begin
      DefaultTransaction := TRS_BD_Base_Dados;
      IdleTimer := 0;
      SQLDialect := 3;
      TraceFlags := [];
      Name := 'BD_Base_Dados';
    end;
    DataFile := ArqIni.ReadString('EMPRESA 00', 'Base 0000', '');
    Host     := ArqIni.ReadString('EMPRESA 00', 'Host 0000', '');
    Usuario  := ArqIni.ReadString('EMPRESA 00', 'Usuario 0000', '');
    Senha    := Decript(ArqIni.ReadString('EMPRESA 00', 'Senha 0000', ''));
    Servidor := StrToIntDef(ArqIni.ReadString('EMPRESA 00', 'Servidor 0000', ''), -1);
    if Trim(DataFile) = '' then
      DataFile := Sistema.Pasta + 'BASE.GDB';
    if Trim(Host) = '' then
      Host := '';
    BD_Base_Dados.LoginPrompt    := False;
    if Trim(Host) <> '' then
      BD_Base_Dados.DataBaseName := Host + ':' + DataFile
    else
      BD_Base_Dados.DataBaseName := DataFile;
    if DirectoryExists(ExtractFilePath(DataFile)) then
      if not FileExists(DataFile) then
      begin
        if MessageDlg('Base de Dados não encontrada: '+^M+^M+DataFile+^M+^M'Deseja Criá-la ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
        begin
          BD_Base_Dados.Params.Clear;
          BD_Base_Dados.Params.Add('USER '+#39+'sysdba'+#39);
          BD_Base_Dados.Params.Add('PASSWORD '+#39+'masterkey'+#39);
          DB_LoginConexao(BD_Base_Dados.Params, Usuario, Senha);
          BD_Base_Dados.CreateDatabase;
          Criou_BD := True;
          BD_Base_Dados.Close;
        end;
      end;
    ListaBaseDadosArq.Add(DataFile);
    ListaBaseDadosHost.Add(Host);
    BD_Base_Dados.Params.Clear;
    BD_Base_Dados.Params.Add('USER_NAME=sysdba');
    BD_Base_Dados.Params.Add('PASSWORD=masterkey');
    DB_LoginConexao(BD_Base_Dados.Params, Usuario, Senha);
    BD_Base_Dados.Open;
    TRS_BD_Base_Dados.StartTransaction;
    Sistema.BancoDados := 'Firebird';

    ListaBaseDados.AddObject('BD_Base_Dados', BD_Base_Dados);
    ListaNomeTabelas.Add('DAtividades');
    ListaNomeTabelas.Add('DClientes');
    ListaNomeTabelas.Add('DConsulta_Itens_Venda');
    ListaNomeTabelas.Add('DFornecedores');
    ListaNomeTabelas.Add('DFornecedores_2');
    ListaNomeTabelas.Add('DItens_Venda');
    ListaNomeTabelas.Add('DProdutos');
    ListaNomeTabelas.Add('DUSER_AGENDA');
    ListaNomeTabelas.Add('DUSER_BARRA_F');
    ListaNomeTabelas.Add('DUSER_GRUPOS');
    ListaNomeTabelas.Add('DUSER_LOG');
    ListaNomeTabelas.Add('DUSER_MENU_LATERAL');
    ListaNomeTabelas.Add('DUSER_MENU_SUPERIOR');
    ListaNomeTabelas.Add('DUSER_NOMES');
    ListaNomeTabelas.Add('DUSER_TABELAS');
    ListaNomeTabelas.Add('DVendas');
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    ArqIni.Free;
  except
    on Erro: Exception do
    begin
      MessageDlg('Erro de Inicialização!' + ^M+^M + Erro.Message, mtError, [mbOk], 0);
      Sistema.ErroFatal := True;
      if Assigned(ArqIni) then
        ArqIni.Free;
    end;
  end;
end;

procedure TBaseDados.DataModuleDestroy(Sender: TObject);
begin
  try
    {30-Início do Bloco Modular. Modificações não serão preservadas}
    if BD_Base_Dados.TestConnected then
      BD_Base_Dados.Connected := False;
    BD_Base_Dados.Free;
    TRS_BD_Base_Dados.Free;
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    ListaBaseDados.Free;
    ListaBaseDadosArq.Free;
    ListaBaseDadosHost.Free;
    ListaNomeTabelas.Free;
    ListaNomeTabelas_DB.Free;
  except
    on Erro: Exception do
    begin
      MessageDlg('Erro: ' + Erro.Message, mtError, [mbOk], 0);
    end;
  end;
end;

function TBaseDados.AplicarAtualizacao(DataSet: TDataSet; Apply: Boolean): Boolean;
begin
  Result := True;
  {$IFDEF IBX}
  with TIBCustomDataSet(DataSet) do
  begin
    if (State in dsEditModes) or UpdatesPending then
    begin
      if Apply then
      begin
        Database.ApplyUpdates([DataSet as TIBCustomDataSet]);
        Transaction.CommitRetaining;
       { Always call CancelUpdates to remove any discard changes }
        CancelUpdates;
      end
      else
        CancelUpdates;
    end;
  end;
  {$ENDIF}
end;

end.
