{
   Programa.: Backup.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Backup;

interface

{$I Princ.inc}

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, ComCtrls, FileCtrl,
  {$IFDEF IBX}
  IBDatabase,
  {$ELSE}
  XSEngine,
  {$ENDIF}
  CabSTComps, CabIntf, Menus;

type
  TFormBackup = class(TForm)
    Panel1: TPanel;
    LsPastas: TListBox;
    Panel2: TPanel;
    BtnCancela: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnOk: TBitBtn;
    EdOrigem: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdDestino: TEdit;
    BtnPastaOrigem: TSpeedButton;
    BtnPastaDestino: TSpeedButton;
    Status: TProgressBar;
    PopLista: TPopupMenu;
    Excluir1: TMenuItem;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LsPastasClick(Sender: TObject);
    procedure EdOrigemExit(Sender: TObject);
    procedure BtnPastaOrigemClick(Sender: TObject);
    procedure BtnPastaDestinoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LsPastasDblClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
  private
    { Private declarations }
    procedure FolderStatus(Sender: TSTCabWriter;
      aCopiedSize, aTotalSize: ULONG;
      var anAbort: Boolean);
  public
    { Public declarations }
  end;

var
  FormBackup: TFormBackup;
  Copiando,Abortar: Boolean;
  IniFile : TIniFile;

implementation

uses Rotinas, Publicas, BaseD, Abertura;

{$R *.DFM}

procedure TFormBackup.FormShow(Sender: TObject);
Var
  Qtd,I: Integer;
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
  Copiando := False;
  Abortar  := False;
  EdDestino.Text := IniFile.ReadString('AMBIENTE', 'DestinoBackup', '');
  Qtd := StrtoIntDef(IniFile.ReadString('AMBIENTE', 'Origem_Qtd', '-1'),-1);
  LsPastas.Items.Clear;
  for I:=0 to Qtd do
    LsPastas.Items.Add(Trim(IniFile.ReadString('AMBIENTE', 'OrigemBackup_'+IntToStr(I), '')));
  if LsPastas.Items.Count < 1 then
    LsPastas.Items.Add(Sistema.Pasta);
  LsPastas.ItemIndex := 0;
  LsPastas.OnClick(Self);
end;

procedure TFormBackup.BtnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBackup.FormKeyPress(Sender: TObject;
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

procedure TFormBackup.BtnOkClick(Sender: TObject);
Var
  I: Integer;
  Destino,PastaTmp: String;
  aCabWr: TSTCabWriter;
  Erro: Boolean;

  function CopiaCabs(Orig, Dest, Masc: string): Boolean;
  var
    DirInfo: TSearchRec;
    Qtd,NrDisco: Integer;
  begin
    Result := True;
    Qtd    := 0;
    NrDisco:= 0;
    if FindFirst(DiretorioComBarra(Orig) + Masc, faArchive, DirInfo) = 0 then
      repeat
        Inc(Qtd);
      until FindNext(DirInfo) <> 0;
    if FindFirst(DiretorioComBarra(Orig) + Masc, faArchive, DirInfo) = 0 then
      repeat
      begin
        Inc(NrDisco);
        if Result then
          if MessageDlg('Insira o disco '+IntToStr(Nrdisco)+'/'+IntToStr(Qtd)+' na unidade de cópia !',mtInformation,[mbOk,mbCancel],0) = mrOk then
            Result := CopiaArquivo(DiretorioComBarra(Orig) + DirInfo.Name, DiretorioComBarra(Dest) + DirInfo.Name)
          else
            Result := False;
      end;
      until (FindNext(DirInfo) <> 0);
  end;

begin
  if not DirectoryExists(EdDestino.Text) then
  begin
    MessageDlg('Pasta de Destino não Encontrada !',mtInformation,[mbOk],0);
    EdDestino.SelectAll;
    EdDestino.SetFocus;
    exit;
  end;
  Erro := False;
  for I:=0 to LsPastas.Items.Count-1 do
    if not DirectoryExists(LsPastas.Items[I]) then
    begin
      MessageDlg('Pasta Destino não Encontrada: '+^M+LsPastas.Items[I],mtInformation,[mbOk],0);
      Erro := True;
    end;
  if Erro then
  begin
    LsPastas.SetFocus;
    exit;
  end;
  Destino := DiretoriocomBarra(EdDestino.Text);
  if MessageDlg('Processar Cópia de Segurança ?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
  begin
    EdDestino.SelectAll;
    EdDestino.SetFocus;
    exit;
  end;
  PastaTmp := Sistema.Pasta + 'Backup';
  try
    ForceDirectories(PastaTmp);
  except
    MessageDlg('Pasta Destino '+^M+PastaTmp+^M+'não localizada !',mtError,[mbOk],0);
    EdDestino.SelectAll;
    EdDestino.SetFocus;
    exit;
  end;
  PastaTmp := DiretorioComBarra(PastaTmp);
  aCabWr := TSTCabWriter.Create(nil);
  try
    Screen.Cursor := crHourGlass;
    Copiando := True;
    Abortar  := False;
    aCabWr.CompressionType := cctMsZip;
    if UpperCase(Copy(Destino,01,02)) = 'A:' then
      aCabWr.CabinetSizeThreshold := 1457600;  // Unidade de disquete !
    aCabWr.OnFolderStatus := FolderStatus;
    aCabWr.Open(PastaTmp + 'Copia.Cab');
    For I:=0 to LsPastas.Items.Count-1 do
    begin
      aCabWr.AddFiles(DiretorioComBarra(LsPastas.Items[I])+'*.GDB', ''); // FireBird
      aCabWr.AddFiles(DiretorioComBarra(LsPastas.Items[I])+'*.DAT', ''); // Plano de Senhas
      aCabWr.AddFiles(DiretorioComBarra(LsPastas.Items[I])+'*.FRM', ''); // MySql
      aCabWr.AddFiles(DiretorioComBarra(LsPastas.Items[I])+'*.MY*', ''); // MySql
    end;
    aCabWr.Close;
  finally
    aCabWr.Free;
    Screen.Cursor := crDefault;
    Status.Position := 0;
    if not Abortar then
      if CopiaCabs(PastaTmp,Destino,'Copia*.Cab') then
        MessageDlg('Cópia de Segurança Concluída !',mtInformation,[mbOk],0)
      else
        Abortar := True;
    if Abortar then
      MessageDlg('Cópia de Segurança Cancelada !',mtError,[mbOk],0);
    Copiando := False;
    Abortar  := False;
    BtnCancela.SetFocus;
  end;
  IniFile.WriteString('AMBIENTE', 'DestinoBackup', EdDestino.Text);
  IniFile.WriteString('AMBIENTE', 'Origem_Qtd', IntToStr(LsPastas.Items.Count-1));
  for I:=0 to LsPastas.Items.Count-1 do
    IniFile.WriteString('AMBIENTE', 'OrigemBackup_'+IntToStr(I), LsPastas.Items[I]);
end;

procedure TFormBackup.FolderStatus(Sender: TSTCabWriter;
  aCopiedSize, aTotalSize: ULONG;
  var anAbort: Boolean);
begin
  Status.Max      := aTotalSize;
  Status.Position := aCopiedSize;
  Application.ProcessMessages;
end;

procedure TFormBackup.LsPastasClick(Sender: TObject);
begin
  if LsPastas.ItemIndex >= 0 then
    EdOrigem.Text := LsPastas.Items[LsPastas.ItemIndex]
  else
    EdOrigem.Text := '';
end;

procedure TFormBackup.EdOrigemExit(Sender: TObject);
Var
  I: Integer;
  Achou: Boolean;
begin
  if Trim(EdOrigem.Text) = '' then
    exit;
  Achou := False;
  for I:=0 to LsPastas.Items.Count-1 do
    if UpperCase(LsPastas.Items[I]) = UpperCase(EdOrigem.Text) then
      Achou := True;
  if Not Achou then
    LsPastas.Items.Add(Trim(EdOrigem.Text));
end;

procedure TFormBackup.BtnPastaOrigemClick(Sender: TObject);
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

procedure TFormBackup.BtnPastaDestinoClick(Sender: TObject);
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

procedure TFormBackup.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFormBackup.LsPastasDblClick(Sender: TObject);
begin
  if LsPastas.ItemIndex < 0 then
    exit;
  if MessageDlg('Excluir Pasta: '+LsPastas.Items[LsPastas.ItemIndex]+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    LsPastas.Items.Delete(LsPastas.ItemIndex);
end;

procedure TFormBackup.BtnAjudaClick(Sender: TObject);
begin
  application.helpcommand(Help_Finder,0);

end;

procedure TFormBackup.Excluir1Click(Sender: TObject);
begin
  if LsPastas.ItemIndex > -1 then
    if MessageDlg('Excluir Pasta de Origem:'+^M+^M+LsPastas.Items[LsPastas.ItemIndex]+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      LsPastas.Items.Delete(LsPastas.ItemIndex);
end;

end.
