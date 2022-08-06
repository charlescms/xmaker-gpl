{
   Programa.: Restaura.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Restaura;

interface

{$I Princ.inc}

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, ComCtrls, FileCtrl,
  {$IFDEF IBX}
  IBDatabase,
  {$ELSE}
  XSEngine,
  {$ENDIF}
  CabSTComps, CabIntf;

type
  TFormRestaura = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnCancela: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnOk: TBitBtn;
    EdOrigem: TEdit;
    Label2: TLabel;
    BtnPastaOrigem: TSpeedButton;
    Label1: TLabel;
    EdDestino: TEdit;
    BtnPastaDestino: TSpeedButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPastaOrigemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPastaDestinoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NextCab(Sender: TSTCabReader;
      const aCabName, aDiskName: String;
      var aCabPath: String;
      anError: TFDIERROR;
      var anAbort: Boolean);
  end;

var
  FormRestaura: TFormRestaura;
  IniFile : TIniFile;
  Abortar: Boolean;

implementation

uses Rotinas, Publicas, BaseD, Abertura;

{$R *.DFM}

procedure TFormRestaura.FormShow(Sender: TObject);
Var
  I: Integer;
begin
  TabGlobal.FecharTabelas(False);
  for I:=0 to BaseDados.ListaBaseDados.Count-1 do
    {$IFDEF IBX}
    TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Close;
    {$ELSE}
    TXSQLDatabase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Connected := False;
    {$ENDIF}

  IniFile := TInifile.Create(Sistema.Pasta +
             ChangeFileExt(ExtractFileName(Application.ExeName), '.ini'));
  EdOrigem.Text  := IniFile.ReadString('AMBIENTE', 'DestinoBackup', '');
  EdDestino.Text := Sistema.Pasta;
  Abortar := False;
end;

procedure TFormRestaura.BtnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRestaura.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end
  else if Key = Chr(27) then
    Close;
end;

procedure TFormRestaura.BtnOkClick(Sender: TObject);
Var
  I: Integer;
  aCabWr: TSTCabReader;
begin
  EdOrigem.Text  := DiretorioComBarra(EdOrigem.Text);
  if not FileExists(EdOrigem.Text + 'Copia.Cab') then
  begin
    MessageDlg('Cópia de Segurança não Encontrada !',mtError,[mbOk],0);
    EdOrigem.SelectAll;
    EdOrigem.SetFocus;
    exit;
  end;
  if not DirectoryExists(EdDestino.Text) then
  begin
    MessageDlg('Pasta de Destino não Encontrada !',mtError,[mbOk],0);
    EdDestino.SelectAll;
    EdDestino.SetFocus;
    exit;
  end;
  if MessageDlg('Processar Restauração da Cópia de Segurança ?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
  begin
    EdOrigem.SelectAll;
    EdOrigem.SetFocus;
    exit;
  end;
  Abortar := False;
  aCabWr := TSTCabReader.Create(nil);
  try
    Screen.Cursor := crHourGlass;
    aCabWr.OnNextCabinet := NextCab;
    aCabWr.ExtractFiles(EdOrigem.Text + 'Copia.Cab', EdDestino.Text);
  finally
    aCabWr.Free;
    Screen.Cursor := crDefault;
    if not Abortar then
      MessageDlg('Restauração Concluída !',mtInformation,[mbOk],0)
    else
      MessageDlg('Restauração Cancelada !',mtError,[mbOk],0);
    BtnCancela.SetFocus;
  end;
end;

procedure TFormRestaura.NextCab(Sender: TSTCabReader;
  const aCabName, aDiskName: String;
  var aCabPath: String;
  anError: TFDIERROR;
  var anAbort: Boolean);
begin
  if MessageDlg('Insira o disco '+#39+ aDiskName +#39+' na unidade de cópia !',mtInformation,[mbOk,mbCancel],0) <> mrOk then
  begin
    anAbort := True;
    Abortar := True;
  end;
end;

procedure TFormRestaura.BtnPastaOrigemClick(Sender: TObject);
Var
  S: String;
begin
  if (EdOrigem.Text <> '') and (DirectoryExists(EdOrigem.Text)) then
    S := EdOrigem.Text
  else
    S := '';
  if SelectDirectory('Selecione a Pasta - [Origem]', '', S) then
    EdOrigem.Text := S;
  EdOrigem.SelectAll;
  EdOrigem.SetFocus;
end;

procedure TFormRestaura.BtnPastaDestinoClick(Sender: TObject);
Var
  S: String;
begin
  if (EdDestino.Text <> '') and (DirectoryExists(EdDestino.Text)) then
    S := EdDestino.Text
  else
    S := '';
  if SelectDirectory('Selecione a Pasta - [Destino]', '', S) then
    EdDestino.Text := S;
  EdDestino.SelectAll;
  EdDestino.SetFocus;
end;

procedure TFormRestaura.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  I: Integer;
begin
  for I:=0 to BaseDados.ListaBaseDados.Count-1 do
   {$IFDEF IBX}
   TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Open;
   {$ELSE}
   TXSQLDatabase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Connected := False;
   {$ENDIF}
  TabGlobal.AbrirTabelas;

  IniFile.Free;
end;

end.
