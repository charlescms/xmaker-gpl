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
