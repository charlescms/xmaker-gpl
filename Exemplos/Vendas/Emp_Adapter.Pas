{
   Programa.: Emp_Adapter.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Emp_Adapter;

interface

{$I Princ.inc}

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
  {$IFDEF IBX}
  IBDatabase,
  {$ELSE}
  XSEngine, XSCommon,
  {$ENDIF}
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles;

type
  TFormEmpresa_Adapter = class(TForm)
    Panel1: TPanel;
    lbEmpresas: TListBox;
    Panel2: TPanel;
    BtnCancela: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnOk: TBitBtn;
    Label1: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
    ArqIni: TIniFile;
    ListaNr: TStringList;
    procedure Atualizar;
    procedure AtivarEmpresa;
  public
    { Public declarations }
  end;

var
  FormEmpresa_Adapter: TFormEmpresa_Adapter;
  NovaEmpresa: Boolean;

implementation

uses Rotinas, Publicas, BaseD, Princ_Adapter;

{$R *.DFM}

procedure TFormEmpresa_Adapter.FormShow(Sender: TObject);
begin
  Sistema.Pasta := ExtractFilePath(Application.ExeName);
  Sistema.Pasta := DiretorioComBarra(Sistema.Pasta);
  ArqIni  := TInifile.Create(Sistema.Pasta + 'SYSEMP.DAT');
  ListaNr := TStringList.Create;
  Atualizar;
  NovaEmpresa := False;
end;

procedure TFormEmpresa_Adapter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ArqIni.Free;
  ListaNr.Free;
end;

procedure TFormEmpresa_Adapter.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(27) then
    Close;
end;

procedure TFormEmpresa_Adapter.Atualizar;
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
  lbEmpresas.ItemIndex := 0;
  lbEmpresas.SetFocus;
end;

procedure TFormEmpresa_Adapter.BtnOkClick(Sender: TObject);
begin
  AtivarEmpresa;
  FormAdapter.Iniciar;
  Close;
end;

procedure TFormEmpresa_Adapter.AtivarEmpresa;
Var I,Y: Integer;
    DataFile, Host: String;
begin
  Screen.Cursor := crHourGlass;
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
  Y := -1;
  for I := 0 to BaseDados.ListaBaseDados.Count-1 do
  begin
    {$IFDEF IBX}
    TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Close;
    {$ELSE}
    TXSQLDatabase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Connected := True;
    {$ENDIF}
    Inc(Y);
    DataFile := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Base '+StrZero(Y,04), '');
    Host := ArqIni.ReadString('EMPRESA '+ListaNr[lbEmpresas.ItemIndex], 'Host '+StrZero(Y,04), '');
    if Trim(DataFile) = '' then
      DataFile := BaseDados.ListaBaseDadosArq[I];
    if Trim(Host) = '' then
      Host := String(BaseDados.ListaBaseDadosArq.Objects[I]);
    if Trim(DataFile) <> '' then
    begin
      {$IFDEF IBX}
      if Trim(Host) <> '' then
        TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).DataBaseName := Host + ':' + DataFile
      else
        TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).DataBaseName := DataFile;
      TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Open;
      TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).DefaultTransaction.StartTransaction;
      {$ELSE}
      if Trim(Host) <> '' then
        TXSQLDatabase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).RemoteDatabase := Host + ':' + DataFile
      else
        TXSQLDatabase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).RemoteDatabase := DataFile;
      TXSQLDatabase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Connected := True;
      {$ENDIF}
    end;
  end;
  Screen.Cursor := crDefault;
end;

end.
