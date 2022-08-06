{
   Programa.: SelEmp.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit SelEmp;

interface

{$I Princ.inc}

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  {$IFDEF IBX}
  IBDatabase,
  {$ELSE}
  XSEngine,
  {$ENDIF}
  IniFiles, ComCtrls;

type
  TFormSelecionaEmpresa = class(TForm)
    Panel2: TPanel;
    BtnCancela: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnOk: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lbEmpresas: TListBox;
    BtnIncluir: TBitBtn;
    BtnEditar: TBitBtn;
    BtnExcluir: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure lbEmpresasClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    ArqIni: TIniFile;
    ListaNr: TStringList;
    Ok: Boolean;
    procedure Atualizar;
    procedure AtivarEmpresa;
  public
    { Public declarations }
  end;

var
  FormSelecionaEmpresa: TFormSelecionaEmpresa;
  NovaEmpresa: Boolean;

implementation

uses Rotinas, Publicas, CfgEmp, Princ, BaseD, Abertura;

{$R *.DFM}

procedure TFormSelecionaEmpresa.FormShow(Sender: TObject);
begin
  ArqIni  := TInifile.Create(Sistema.Pasta + 'SYSEMP.DAT');
  ListaNr := TStringList.Create;
  if not Sistema.Master then
  begin
    BtnIncluir.Enabled := False;
    BtnEditar.Enabled  := False;
    BtnExcluir.Enabled := False;
  end;
  Ok := False;
  Atualizar;
  NovaEmpresa := False;
  BtnOk.SetFocus;
end;

procedure TFormSelecionaEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ArqIni.Free;
  ListaNr.Free;
  if Ok then
    ModalResult := mrOk;
end;

procedure TFormSelecionaEmpresa.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(27) then
    Close;
end;

procedure TFormSelecionaEmpresa.Atualizar;
Var I,Qtd : Integer;
    Nome: String;
begin
  lbEmpresas.Items.Clear;
  ListaNr.Clear;
  Nome := ArqIni.ReadString('EMPRESA 00', 'Nome', '');
  if Trim(Nome) = '' then
    ArqIni.WriteString('EMPRESA 00', 'Nome', 'Empresa Usuária');
  For I:=0 to 99 do
  begin
    Nome := ArqIni.ReadString('EMPRESA '+StrZero(I,02), 'Nome', '');
    if Trim(Nome) <> '' then
    begin
      ListaNr.Add(StrZero(I,02));
      LbEmpresas.Items.Add(StrZero(I,02)+ ' - ' +Nome);
    end;
  end;
  lbEmpresas.ItemIndex   := 0;
  lbEmpresasClick(Self);
  lbEmpresas.SetFocus;
end;

procedure TFormSelecionaEmpresa.BtnOkClick(Sender: TObject);
begin
  try
    AtivarEmpresa;
    Ok := True;
    Close;
  except
    on Erro: Exception do
    begin
      Screen.Cursor := crDefault;
      MessageDlg('Erro: ' + ^M + ^M + Erro.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TFormSelecionaEmpresa.AtivarEmpresa;
Var
   I, Y, P: Integer;
   DataFile, Servidor, Usuario, Senha: String;
begin
  Screen.Cursor := crHourGlass;
  Sistema.NumeroUsr   := StrToIntDef(ListaNr[lbEmpresas.ItemIndex],0);
  Sistema.EmpresaUsr  := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Nome', '');
  Sistema.EnderecoUsr := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Endereco', '');
  Sistema.BairroUsr   := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Bairro', '');
  Sistema.CidadeUsr   := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Cidade', '');
  Sistema.UfUsr       := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'UF', '');
  Sistema.CEPUsr      := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'CEP', '');
  Sistema.CNPJUsr     := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'CNPJ', '');
  Sistema.IEUsr       := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Inscricao', '');
  Sistema.FonesUsr    := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Fones', '');
  Sistema.LogoUsr     := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Logo', '');
  Atualiza_Status;
  Y := -1;
  TabGlobal.FecharTabelas(False);
  for I := 0 to BaseDados.ListaBaseDados.Count-1 do
  begin
    {$IFDEF IBX}
    TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Close;
    {$ELSE}
    TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Connected := False;
    {$ENDIF}
    Inc(Y);
    DataFile := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Base '+StrZero(Y,04), '');
    Servidor := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Host '+StrZero(Y,04), '');
    Usuario  := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Usuario '+StrZero(Y,04), '');
    Senha    := Decript(ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Senha '+StrZero(Y,04), ''));
    if Trim(DataFile) = '' then
      DataFile := BaseDados.ListaBaseDadosArq[I];
    if Trim(Servidor) = '' then
      Servidor := BaseDados.ListaBaseDadosHost[I];
    {$IFDEF IBX}
    if Trim(Servidor) <> '' then
      DataFile := Servidor + ':' + DataFile;
    DB_LoginConexao(TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params, Usuario, Senha);
    TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).DataBaseName := DataFile;
    TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Open;
    TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).DefaultTransaction.StartTransaction;
    Sistema.BancoDados := DB_User(1);
    {$ELSE}
    P := StrToIntDef(ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Servidor '+StrZero(Y,04), '-1'), -1);
    case P of
      0: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stInterbase;
      1: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stFirebird;
      2: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stSQLBase;
      3: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stOracle;
      4: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stSQLServer;
      5: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stSybase;
      6: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stDB2;
      7: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stInformix;
      8: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stODBC;
      9: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stMySQL;
      10: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stPostgreSQL;
      11: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stOLEDB;
    end;
    DB_LoginConexao(TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Params, Usuario, Senha);
    if Trim(Servidor) <> '' then
      TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).RemoteDatabase := Servidor + ':' + DataFile
    else
      TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).RemoteDatabase := DataFile;
    TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Connected := True;
    Sistema.BancoDados := DB_User(P) + ': ' + TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Version;
    {$ENDIF}
  end;
  Atualiza_Status;
  TabGlobal.AbrirTabelas;
  Screen.Cursor := crDefault;
end;

procedure TFormSelecionaEmpresa.BtnIncluirClick(Sender: TObject);
Var Proxima: String;
begin
  Proxima := StrZero(StrToIntDef(ListaNr[ListaNr.Count-1],0) + 1,02);
  ArqIni.WriteString('EMPRESA '+Proxima, 'Nome', 'Nova Empresa');
  Atualizar;
  lbEmpresas.ItemIndex := lbEmpresas.Items.Count -1;
  NovaEmpresa := True;
  BtnEditarClick(Self);
end;

procedure TFormSelecionaEmpresa.BtnEditarClick(Sender: TObject);
begin
  if lbEmpresas.ItemIndex >= 0 then
  begin
    if not NovaEmpresa then
    begin
      try
        AtivarEmpresa;
      except
        on Erro: Exception do
        begin
          Screen.Cursor := crDefault;
          MessageDlg('Erro: ' + ^M + ^M + Erro.Message, mtError, [mbOk], 0);
          exit;
        end;
     end;
    end;
    FormConfiguraEmpresa := TFormConfiguraEmpresa.Create(Application);
    FormConfiguraEmpresa.NrEmpresa := ListaNr[LbEmpresas.ItemIndex];
    Try
      FormConfiguraEmpresa.NovaEmpresa := NovaEmpresa;
      FormConfiguraEmpresa.ShowModal;
    Finally
      FormConfiguraEmpresa.Free;
    end;
    NovaEmpresa := False;
    Atualizar;
  end
  else
    MessageDlg('Empresa não selecionada !',mtInformation,[mbOk],0);
end;

procedure TFormSelecionaEmpresa.BtnExcluirClick(Sender: TObject);
begin
  if lbEmpresas.ItemIndex >= 0 then
  begin
    if MessageDlg('Confirma exclusão da Empresa: '+ ^M + ^M +lbEmpresas.Items[lbEmpresas.ItemIndex]+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      ArqIni.EraseSection('EMPRESA '+ListaNr[lbEmpresas.ItemIndex]);
      Atualizar;
    end;
  end
  else
    MessageDlg('Empresa não selecionada !',mtInformation,[mbOk],0);
end;

procedure TFormSelecionaEmpresa.lbEmpresasClick(Sender: TObject);
begin
  if lbEmpresas.ItemIndex <= 0 then
    BtnExcluir.Enabled := False
  else
    if Sistema.Master then
      BtnExcluir.Enabled := True;
end;

end.
