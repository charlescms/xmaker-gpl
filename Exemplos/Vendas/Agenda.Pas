{
   Programa.: Agenda.PAS
   Copyright: Modular Software 2005
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Agenda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Buttons, Grids;

type
  TFormAgenda = class(TForm)
    PanelLt: TPanel;
    Aba0: TSpeedButton;
    Aba_A: TSpeedButton;
    Aba_B: TSpeedButton;
    Aba_C: TSpeedButton;
    Aba_D: TSpeedButton;
    Aba_E: TSpeedButton;
    Aba_F: TSpeedButton;
    Aba_G: TSpeedButton;
    Aba_H: TSpeedButton;
    Aba_I: TSpeedButton;
    Aba_J: TSpeedButton;
    Aba_K: TSpeedButton;
    Aba_L: TSpeedButton;
    Aba_M: TSpeedButton;
    Aba_N: TSpeedButton;
    Aba_O: TSpeedButton;
    Aba_P: TSpeedButton;
    Aba_Q: TSpeedButton;
    Aba_R: TSpeedButton;
    Aba_S: TSpeedButton;
    Aba_T: TSpeedButton;
    Aba_U: TSpeedButton;
    Aba_V: TSpeedButton;
    Aba_W: TSpeedButton;
    Aba_Y: TSpeedButton;
    Aba_Z: TSpeedButton;
    PanelP: TPanel;
    PanelD3: TPanel;
    PopupMenu: TPopupMenu;
    Novo: TMenuItem;
    Editar: TMenuItem;
    N1: TMenuItem;
    Excluir: TMenuItem;
    PanelS: TPanel;
    LbAgenda: TLabel;
    ListaFone: TStringGrid;
    Aba_X: TSpeedButton;
    PnSuperior: TPanel;
    btnnovo: TSpeedButton;
    btneditar: TSpeedButton;
    btnexcluir: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Aba0Click(Sender: TObject);
    procedure Aba_AClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NovoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ExcluirClick(Sender: TObject);
    procedure EditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListaFoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LetraAtual: String;
    procedure Atualiza;
  end;

var
  FormAgenda  : TFormAgenda;
  Cancelamento: Boolean;

implementation

{$R *.DFM}

uses Rotinas, Validar, Publicas, AgEdit, Interno, Abertura;

procedure TFormAgenda.FormShow(Sender: TObject);
begin
  ListaFone.Visible  := False;
  PnSuperior.Visible := False;
  Cancelamento      := False;
  LetraAtual        := '#';
  Atualiza;
end;

procedure TFormAgenda.Aba0Click(Sender: TObject);
begin
  Caption := 'Agenda ( '+TSpeedButton(Sender).Caption[2]+' )';
  TSpeedButton(Sender).Down := True;
  ListaFone.Visible  := False;
  PnSuperior.Visible := False;
  LbAgenda.Visible   := True;
  PanelS.Visible     := True;
  LetraAtual         := '#';
end;

procedure TFormAgenda.Aba_AClick(Sender: TObject);
Var I: Integer;
    Msg: String;
begin
  Caption := 'Agenda ( '+TSpeedButton(Sender).Caption[2]+' )';
  TSpeedButton(Sender).Down := True;
  ListaFone.Visible  := True;
  PnSuperior.Visible := True;
  LbAgenda.Visible   := False;
  PanelS.Visible     := False;
  ListaFone.SetFocus;
  LetraAtual         := TSpeedButton(Sender).Caption[2];
  Atualiza;
end;

procedure TFormAgenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormAgenda := Nil;
end;

procedure TFormAgenda.NovoClick(Sender: TObject);
begin
  FormAgEdit := TFormAgEdit.Create(Application);
  try
    FormAgEdit.Novo := True;
    FormAgEdit.ShowModal;
  finally
    FormAgEdit.Free;
  end;
  Atualiza;
end;

procedure TFormAgenda.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormAgenda.ExcluirClick(Sender: TObject);
Var
  PosDat: Integer;
begin
  if ListaFone.Row > 0 then
  begin
    ListaFoneClick(Self);
    if MessageDlg('Excluir  '+#39+ListaFone.Cells[0,ListaFone.Row]+#39+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      TabGlobal.DUSER_AGENDA.Exclui;
      Atualiza;
    end;
  end
  else
    MessageDlg('Registro não selecionado!', mtWarning, [mbOk], 0);
end;

procedure TFormAgenda.EditarClick(Sender: TObject);
Var
  SalvaP: Integer;
begin
  if ListaFone.Row > 0 then
  begin
    TabGlobal.DUSER_AGENDA.GotoBookmark(ListaFone.Objects[0, ListaFone.Row]);
    SalvaP := ListaFone.Row;
    FormAgEdit := TFormAgEdit.Create(Application);
    try
      FormAgEdit.Novo := False;
      FormAgEdit.ShowModal;
    finally
      FormAgEdit.Free;
    end;
    Atualiza;
    if SalvaP <= ListaFone.RowCount-1 then
      ListaFone.Row := SalvaP;
  end
  else
    MessageDlg('Registro não selecionado!', mtWarning, [mbOk], 0);
end;

procedure TFormAgenda.Atualiza;
var
  I: Integer;
begin
  ListaFone.ColCount := 02;
  ListaFone.RowCount := 01;
  ListaFone.Cells[0,0] := 'Nomes(s)';
  ListaFone.Cells[1,0] := 'Telefones(s)';
  TabGlobal.DUSER_AGENDA.Filtro.Clear;
  TabGlobal.DUSER_AGENDA.Filtro.Add('(USER_AGENDA.USUARIO = '+#39+Sistema.Usuario+#39);
  TabGlobal.DUSER_AGENDA.Filtro.Add('OR USER_AGENDA.COMPARTILHADO = 1)');
  TabGlobal.DUSER_AGENDA.Filtro.Add('AND USER_AGENDA.NOME LIKE '+#39+LetraAtual+'%'+#39);
  TabGlobal.DUSER_AGENDA.ChaveIndice := 'USER_AGENDA.NOME';
  TabGlobal.DUSER_AGENDA.AtualizaSql;
  I := 0;
  while not TabGlobal.DUSER_AGENDA.Eof do
  begin
    Inc(I);
    ListaFone.RowCount   := ListaFone.RowCount + 01;
    ListaFone.Cells[0,I] := TabGlobal.DUSER_AGENDA.Nome.Conteudo;
    ListaFone.Cells[1,I] := TabGlobal.DUSER_AGENDA.Telefone.Conteudo;
    ListaFone.Objects[0, I] := TabGlobal.DUSER_AGENDA.GetBookmark;
    TabGlobal.DUSER_AGENDA.Next;
  end;
  if ListaFone.RowCount > 1 then
    ListaFone.FixedRows := 1;
end;

procedure TFormAgenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calendário
    Interno108
  else if Key = VK_F6 then // Calculadora
    Interno109
end;

procedure TFormAgenda.ListaFoneClick(Sender: TObject);
begin
  if ListaFone.Row > 0 then
    TabGlobal.DUSER_AGENDA.GotoBookmark(ListaFone.Objects[0, ListaFone.Row]);
end;

end.
