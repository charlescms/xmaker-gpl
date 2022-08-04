{
   Programa.: XMakerModelo.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit XMakerModelo;

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
  TFormXMakerModelo = class(TForm)
    PnSup: TPanel;
    ShapeSup: TShape;
    LbTituloForm: TLabel;
    BtnAjuda: TSpeedButton;
    BtnFechar: TSpeedButton;
    {02-Início do Bloco Modular. Modificações não serão preservadas}
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    {03-Início do Bloco Modular. Modificações não serão preservadas}
    {99-Final do Bloco Modular. Modificações não serão preservadas}
    {04-Início do Bloco Modular. Modificações não serão preservadas}
    {99-Final do Bloco Modular. Modificações não serão preservadas}
  end;

var
  FormXMakerModelo: TFormXMakerModelo;

implementation

{$R *.DFM}

uses Publicas, Princ, Rotinas, Abertura, GridPesquisa;

procedure TFormXMakerModelo.FormShow(Sender: TObject);
Var
  I: Integer;
begin
  {05-Início do Bloco Modular. Modificações não serão preservadas}
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  FormPrincipal.PnImagemFundo.Visible := False;
  Sistema.JanelasMDI := Sistema.JanelasMDI + 01;
  if Sistema.JanelasMDI < 1 then   // Pouco provável + ...
    Sistema.JanelasMDI := 1;
  {06-Início do Bloco Modular. Modificações não serão preservadas}
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  FormResize(Self);
end;

procedure TFormXMakerModelo.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  I: Integer;
begin
  {
    Ajusta Janelas e Pano de Fundo
  }
  Sistema.JanelasMDI := Sistema.JanelasMDI - 01;
  if Sistema.JanelasMDI <= 0 then
    FormPrincipal.PnImagemFundo.Visible := True;
  Action := caFree;
  FormXMakerModelo := nil;
end;

procedure TFormXMakerModelo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
    begin
      Key := #0;
      {Atua como a tecla TAB}
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TFormXMakerModelo.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormXMakerModelo.FormResize(Sender: TObject);
begin
  BtnAjuda.Left  := ShapeSup.Width - 37;
  BtnFechar.Left := ShapeSup.Width - 19;
end;

procedure TFormXMakerModelo.BtnAjudaClick(Sender: TObject);
begin
  //
end;

end.
