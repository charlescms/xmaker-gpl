unit Tutorial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ShellAPI, OleCtrls, jpeg;

type
  TFormTutorial = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    LbVersao: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnOk: TButton;
    Label1: TLabel;
    LbTopico_1: TLabel;
    LbTopico_2: TLabel;
    LbTopico_3: TLabel;
    LbTopico_4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel9: TPanel;
    LbTopico_5: TLabel;
    LbTopico_6: TLabel;
    LbTopico_7: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    LbTopico_8: TLabel;
    LbTopico_9: TLabel;
    LbTopico_10: TLabel;
    Panel6: TPanel;
    LbTopico_11: TLabel;
    Panel7: TPanel;
    LbTopico_12: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure LbTopico_1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTutorial: TFormTutorial;

implementation

{$R *.DFM}

uses Rotinas;

procedure TFormTutorial.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TFormTutorial.Label6Click(Sender: TObject);
begin
  Label1.Font.Color := clBlue;
  Label6.Font.Color := clBlue;
  Label6.Font.Color := clGray;
  ShellExecute(0, nil, pchar('http://www.modularsoftware.com.br'), nil, nil, SW_MAXIMIZE);
end;

procedure TFormTutorial.Label1Click(Sender: TObject);
begin
  Label1.Font.Color := clBlue;
  Label6.Font.Color := clBlue;
  Label1.Font.Color := clGray;
  ShellExecute(0, nil, pchar('mailto:modular@modularsoftware.com.br'), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormTutorial.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;

end;

procedure TFormTutorial.FormShow(Sender: TObject);
begin
  if FREDT then
    lbVersao.Caption := 'Versão  '+Projeto.VersaoGerador + ' - FREE EDITION'
  else
    lbVersao.Caption := 'Versão  '+Projeto.VersaoGerador + ' - PROFESSIONAL';
end;

procedure TFormTutorial.LbTopico_1Click(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clGray;
  if TLabel(Sender).Tag = 1 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Novo Projeto.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 2 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Tabela de Atividades.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 3 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Tabela de Clientes.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 4 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Tabela de Contas.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 5 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Relacionamentos - Restrita e Cascata.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 6 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Formulário de Atividades.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 7 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Formulário de Clientes.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 8 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Formulário de Contas.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 9 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Formulário de Contas Filho.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 10 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Etiqueta de Clientes.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 11 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Gráficos de Contas.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 12 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Relatório de Contas.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 13 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Menu de Opções.Exe"'),SW_NORMAL)
  else if TLabel(Sender).Tag = 14 then
    WinExec(PChar('"'+Projeto.PastaGerador + 'Tutorial\XMaker - Compilando.Exe"'),SW_NORMAL);
end;

end.
