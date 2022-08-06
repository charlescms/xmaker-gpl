{
   Programa.: LogProcura.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit LogProcura;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Tabs, BaseD, Db, Grids, DBGrids,
  {$IFDEF DELPHI5}{$ELSE}Variants, MaskUtils,{$ENDIF}
  Atributo, dbctrls, Clipbrd, Tabela, Menus, IniFiles, Printers, Calculos,
  {$I LTab.pas}
  JPeg, XLookUp, XDBDate, Mask, XDBEdit, XDBNum, XEdit, XBanner, XDate, XNum;

type
  TFormLogProcura = class(TForm)
    Lista1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Lista2: TListBox;
    EdProcura: TEdit;
    Label3: TLabel;
    Button1: TButton;
    ListaExpressoes: TListBox;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    Excluirtodasasexpresses1: TMenuItem;
    Excluirlinhaselecionada1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Excluirtodasasexpresses1Click(Sender: TObject);
    procedure Lista1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Excluirlinhaselecionada1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogProcura: TFormLogProcura;

implementation

{$R *.DFM}

uses Publicas, Princ, Rotinas, Abertura, GridPesquisa, Interno;

procedure TFormLogProcura.FormShow(Sender: TObject);
var
  I: Integer;
begin
  {05-Início do Bloco Modular. Modificações não serão preservadas}
  Caption := 'Procura Especial';
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  for I:=0 to Lst_Tabelas.Count-1 do
    if TTabela(Lst_Tabelas[I]).TableType = ttTable then
      Lista1.Items.AddObject(TTabela(Lst_Tabelas[I]).Titulo, TObject(I));
  Lista1.ItemIndex := 0;
  Lista1Click(Lista1);
end;

procedure TFormLogProcura.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
    begin
      Key := #0;
      {Atua como a tecla TAB}
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFormLogProcura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then   // Calendário
    Interno108
  else if Key = VK_F6 then // Calculadora
    Interno109
  else if Key = VK_F7 then // Agenda
    Interno110;
end;

procedure TFormLogProcura.Button1Click(Sender: TObject);
begin
  if Lista1.ItemIndex = -1 then
  begin
    MessageDlg('Tabela não selecionada!', mtWarning, [mbOk], 0);
    Lista1.SetFocus;
    exit;
  end;
  if Lista2.ItemIndex = -1 then
  begin
    MessageDlg('Campo não selecionado!', mtWarning, [mbOk], 0);
    Lista2.SetFocus;
    exit;
  end;
  if Trim(EdProcura.Text) = '' then
  begin
    MessageDlg('Expressão não informada!', mtWarning, [mbOk], 0);
    EdProcura.SetFocus;
    exit;
  end;
  Lista1.Enabled := False;
  ListaExpressoes.Items.Add(Lista2.Items[Lista2.ItemIndex] + ' = ' + EdProcura.Text);
  Lista2.SetFocus;
  EdProcura.Clear;
end;

procedure TFormLogProcura.Excluirtodasasexpresses1Click(Sender: TObject);
begin
  if MessageDlg('Excluir todas as expressões?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Lista1.Enabled := True;
    ListaExpressoes.Items.Clear;
  end;
end;

procedure TFormLogProcura.Lista1Click(Sender: TObject);
var
  I: Integer;
begin
  Lista2.Items.Clear;
  if Lista1.ItemIndex = -1 then
    exit;
  with TTabela(Lst_Tabelas[Integer(Lista1.Items.Objects[Lista1.ItemIndex])]) do
    for I:=0 to Campos.Count-1 do
      Lista2.Items.Add(TAtributo(Campos[I]).Titulo);
end;

procedure TFormLogProcura.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  TabGlobal.DUSER_LOG.Filtro.Clear;
  TabGlobal.DUSER_LOG.Filtro.Add('Tabela_Obj = '+#39+Lista1.Items[Lista1.ItemIndex]+#39);
  for I:=0 to ListaExpressoes.Items.Count-1 do
  begin
    TabGlobal.DUSER_LOG.Filtro.Add('AND');
    TabGlobal.DUSER_LOG.Filtro.Add('Comando LIKE '+#39+'%' + ListaExpressoes.Items[I] + '%' + #39);
  end;
  TabGlobal.DUSER_LOG.AtualizaSql;
  Close;
end;

procedure TFormLogProcura.Excluirlinhaselecionada1Click(Sender: TObject);
begin
  if ListaExpressoes.ItemIndex > -1 then
    if MessageDlg('Excluir Linha selecionada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      ListaExpressoes.Items.Delete(ListaExpressoes.ItemIndex);
end;

end.
