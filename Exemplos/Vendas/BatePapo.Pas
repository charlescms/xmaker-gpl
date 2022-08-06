{
   Programa.: BatePapo.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit BatePapo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, Extras, StdCtrls, ComCtrls;

type
  TFormBatePapo = class(TForm)
    PnSup: TPanel;
    ShapeSup: TShape;
    BtnAjuda: TSpeedButton;
    BtnFechar: TSpeedButton;
    LbTituloForm: TLabel;
    PnInferior: TPanel;
    MemoMensagem: TRichEdit;
    PnDivisao: TPanel;
    EdTexto: TEdit;
    Label1: TLabel;
    BtnEnviar: TButton;
    CbDestino: TComboBox;
    Label2: TLabel;
    EdApelido: TEdit;
    Label3: TLabel;
    CheckTodos: TCheckBox;
    BtnFinalizar: TButton;
    Label5: TLabel;
    LbEstacao: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure LbTituloFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnEnviarClick(Sender: TObject);
    procedure EdApelidoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    entrada: Boolean;
  public
    { Public declarations }
    procedure ICQmsgError(Sender: TObject; ErrorMsg: String);
    procedure ICQmsgNewLine(Sender: TObject; Origin, Time, Line: String);
    procedure ICQmsgNewMemo(Sender: TObject; Origin, Time: String;
      MsgLines: TStrings);
    procedure ICQmsgUserListChange(Sender: TObject; UserList: TStrings);
  end;

var
  FormBatePapo: TFormBatePapo;
  ICQmsg: TMessenger;

implementation

{$R *.DFM}

uses Publicas, Princ, Rotinas;

procedure TFormBatePapo.FormShow(Sender: TObject);
begin
  FormPrincipal.PnImagemFundo.Visible := False;
  Sistema.JanelasMDI := Sistema.JanelasMDI + 01;
  if Sistema.JanelasMDI < 1 then   // Pouco provável + ...
    Sistema.JanelasMDI := 1;
  MemoMensagem.Lines.Clear;
  EdApelido.Text    := Sistema.Usuario;
  LbEstacao.Caption := ICQmsg.Computer;
  Entrada := True;
  EdApelido.SelectAll;
  EdApelido.SetFocus;
end;

procedure TFormBatePapo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DesabilitaFuncoesEd;
  CheckTodos.Checked  := True;
  CbDestino.ItemIndex := 0;
  Entrada             := True;
  EdTexto.Text        := 'sai do bate papo...';
  BtnEnviarClick(Self);
  Action := caFree;
  FormBatePapo := nil;
end;

procedure TFormBatePapo.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBatePapo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormBatePapo.FormResize(Sender: TObject);
begin
  BtnAjuda.Left  := ShapeSup.Width - 37;
  BtnFechar.Left := ShapeSup.Width - 19;
end;

procedure TFormBatePapo.LbTituloFormClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBatePapo.FormCreate(Sender: TObject);
begin
  ICQmsg := TMessenger.Create(Self);
  with ICQmsg do
  begin
    Interval         := 1000;
    BoxName          := 'BATEPAPO';
    OnError          := ICQmsgError;
    OnNewLine        := ICQmsgNewLine;
    OnNewMemo        := ICQmsgNewMemo;
    OnUserListChange := ICQmsgUserListChange;
  end;
end;

procedure TFormBatePapo.FormDestroy(Sender: TObject);
begin
  ICQmsg.Destroy;
end;

procedure TFormBatePapo.ICQmsgError(Sender: TObject; ErrorMsg: String);
begin
  MessageDlg('Erro: '+ErrorMsg,mtError,[mbOk],0);
end;

procedure TFormBatePapo.ICQmsgNewLine(Sender: TObject; Origin, Time,
  Line: String);
begin
  with MemoMensagem.SelAttributes do
  begin
    Style := Style + [fsBold];
    Size  := 9;
  end;
  MemoMensagem.Lines.Add('('+Time+') '+Copy(Line,1,Pos(':',Line)));
  with MemoMensagem.SelAttributes do
  begin
    Style := Style - [fsBold];
    Size  := 10;
  end;
  MemoMensagem.Lines.Add('              ' + Copy(Line,Pos(':',Line)+1,Length(Line)));
  MemoMensagem.Lines.Add('');
end;

procedure TFormBatePapo.ICQmsgNewMemo(Sender: TObject; Origin, Time: String;
  MsgLines: TStrings);
begin
  MemoMensagem.Lines.Add('('+Time+') '+Origin+': ');
  MemoMensagem.Lines.AddStrings(MsgLines);
  MemoMensagem.Lines.Add('');
end;

procedure TFormBatePapo.ICQmsgUserListChange(Sender: TObject; UserList: TStrings);
begin
  CbDestino.Items := UserList;
end;

procedure TFormBatePapo.BtnEnviarClick(Sender: TObject);
Var
  Texto: String;
begin
  if (CbDestino.ItemIndex = -1) and (not CheckTodos.Checked) then
  begin
    MessageDlg('Usuário não selecionado !',mtInformation,[mbOk],0);
    CbDestino.SetFocus;
    exit;
  end;
  if CheckTodos.Checked then
  begin
    if Entrada then
      Texto := Trim(EdApelido.Text)+': '+EdTexto.Text
    else
      Texto := Trim(EdApelido.Text)+' fala para TODOS: '+EdTexto.Text;
    ICQmsg.Broadcast(Texto);
  end
  else
  begin
    Texto := Trim(EdApelido.Text)+' fala para '+cbDestino.Items.Strings[cbDestino.ItemIndex]+': '+EdTexto.Text;
    ICQmsg.SendLine(cbDestino.Items.Strings[cbDestino.ItemIndex], Texto);
    ICQmsgNewLine(ICQmsg,'',TimeToStr(Time), Texto);
  end;
  EdTexto.Text := '';
  EdTexto.SetFocus;
end;

procedure TFormBatePapo.EdApelidoExit(Sender: TObject);
begin
  if Entrada then
  begin
    CheckTodos.Checked  := True;
    CbDestino.ItemIndex := 0;
    EdTexto.Text        := 'entra no bate papo...';
    BtnEnviarClick(Self);
    CheckTodos.Checked  := False;
    EdTexto.Text        := '';
    Entrada := False;
  end;
  CbDestino.SetFocus;
end;

procedure TFormBatePapo.FormActivate(Sender: TObject);
begin
  ICQmsg.Activate;
end;

end.
