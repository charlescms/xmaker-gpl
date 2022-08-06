{
   Programa.: AgEdit.PAS
   Copyright: Modular Software 2005
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit AgEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Db, DBCtrls, Mask;

type
  TFormAgEdit = class(TForm)
    PanelEdit: TPanel;
    BtnGravar: TBitBtn;
    BtnDesistir: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBNome: TDBEdit;
    DBTelefone: TDBEdit;
    DBObs: TDBMemo;
    DataSource1: TDataSource;
    DBCheckBox1: TDBCheckBox;
    procedure DBNomeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnDesistirClick(Sender: TObject);
    procedure DBObsEnter(Sender: TObject);
    procedure DBObsExit(Sender: TObject);
    procedure DBTelefoneExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    gravou: Boolean;
  public
    { Public declarations }
    Novo: Boolean;
  end;

var
  FormAgEdit: TFormAgEdit;

implementation

{$R *.DFM}

uses Rotinas, Validar, Agenda, Publicas, Abertura;

procedure TFormAgEdit.DBNomeExit(Sender: TObject);
begin
  if ActiveControl = BtnDesistir then
  begin
    BtnDesistirClick(Self);
    Abort;
  end;
  TabGlobal.DUSER_AGENDA.Nome.Conteudo := UpperCase(Copy(TabGlobal.DUSER_AGENDA.Nome.Conteudo, 01, 01)) + Copy(TabGlobal.DUSER_AGENDA.Nome.Conteudo, 02, Length(TabGlobal.DUSER_AGENDA.Nome.Conteudo));
  if UpperCase(Copy(DBNome.Text,01,01)) <> FormAgenda.LetraAtual then
  begin
    MessageDlg('Nome Inválido !',mtInformation,[mbOk],0);
    DBNome.SelectAll;
    DBNome.SetFocus;
  end;
end;

procedure TFormAgEdit.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(27) then
  begin
    Key := #0;
    Close;
  end;
  if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormAgEdit.BtnGravarClick(Sender: TObject);
begin
  if UpperCase(Copy(DBNome.Text,01,01)) <> FormAgenda.LetraAtual then
  begin
    MessageDlg('Nome Inválido !',mtInformation,[mbOk],0);
    DBNome.SelectAll;
    DBNome.SetFocus;
    Abort;
  end;
  if DBTelefone.Text = '' then
  begin
    MessageDlg('Telefone Inválido !',mtInformation,[mbOk],0);
    DBTelefone.SelectAll;
    DBTelefone.SetFocus;
    Abort;
  end;
  TabGlobal.DUSER_AGENDA.Salva;
  Gravou := True;
  Close;
end;

procedure TFormAgEdit.BtnDesistirClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAgEdit.DBObsEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TFormAgEdit.DBObsExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TFormAgEdit.DBTelefoneExit(Sender: TObject);
begin
  if ActiveControl = BtnDesistir then
  begin
    BtnDesistirClick(Self);
    Abort;
  end;
  if DBTelefone.Text = '' then
  begin
    MessageDlg('Telefone Inválido !',mtInformation,[mbOk],0);
    DBTelefone.SelectAll;
    DBTelefone.SetFocus;
  end;
end;

procedure TFormAgEdit.FormShow(Sender: TObject);
begin
  DataSource1.DataSet := TabGlobal.DUSER_AGENDA;
  if Novo then
  begin
    TabGlobal.DUSER_AGENDA.Inclui(Nil);
    TabGlobal.DUSER_AGENDA.Usuario.Conteudo       := Sistema.Usuario;
    TabGlobal.DUSER_AGENDA.Compartilhado.Conteudo := 0;
  end
  else
    TabGlobal.DUSER_AGENDA.Modifica;
end;

procedure TFormAgEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Gravou then
    TabGlobal.DUSER_AGENDA.Cancela;
end;

end.
