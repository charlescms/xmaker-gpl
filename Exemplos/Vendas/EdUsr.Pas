{
   Programa.: EdUsr.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit EdUsr;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, DB;

type
  TFormEdUsr = class(TForm)
    BtnCancelar: TBitBtn;
    BtnGravar: TBitBtn;
    EdConfirme: TEdit;
    EdGrupo: TComboBox;
    EdMaster: TCheckBox;
    EdNome: TEdit;
    EdSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PageUsuario: TPageControl;
    PagUsr: TTabSheet;
    PanelInf: TPanel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    NovoUsuario: Boolean;
  end;

{$IFNDEF SENHA_DB}
Type
  TUsuario = record                   // Tabela de Usuários
             Usuario  : String[20];
             Pass     : String[10];
             Master   : Boolean;
             Grupo    : String[04];
             Ativo    : Boolean;
  end;
Type
  TGrupo = record                     // Tabela de Grupos
           Grupo      : String[04];
           Descricao  : String[20];
           Ativo      : Boolean;
  end;
{$ENDIF}

var
  FormEdUsr: TFormEdUsr;
  Posicao: Integer;
  {$IFNDEF SENHA_DB}
  TabUsuario : file of TUsuario;
  TabGrupo   : file of TGrupo;
  CmpUsuario : TUsuario;
  CmpGrupo   : TGrupo;
  {$ENDIF}
  Gravou     : Boolean;

implementation

{$R *.DFM}

uses Rotinas, Publicas, Senhas, Abertura ;

procedure TFormEdUsr.FormShow(Sender: TObject);
Var I: Integer;
begin
  EdGrupo.Items.Clear;
  Gravou := False;
  {$IFDEF SENHA_DB}
  TabGlobal.DUSER_GRUPOS.AtualizaSql;
  while not TabGlobal.DUSER_GRUPOS.Eof do
  begin
    if (Trim(TabGlobal.DUSER_GRUPOS.Grupo.Conteudo) <> '') then
      EdGrupo.Items.Add(PadR(TabGlobal.DUSER_GRUPOS.Grupo.Conteudo,04) + ' - ' + TabGlobal.DUSER_GRUPOS.Descricao.Conteudo);
    TabGlobal.DUSER_GRUPOS.Next;
  end;
  EdNome.Text       := Decript(TabGlobal.DUSER_NOMES.Usuario.Conteudo);
  EdSenha.Text      := Decript(TabGlobal.DUSER_NOMES.Senha.Conteudo);
  EdConfirme.Text   := EdSenha.Text;
  if TabGlobal.DUSER_NOMES.Master.Conteudo = 'S' then
    EdMaster.Checked:= True
  else
    EdMaster.Checked:= False;
  for I:=0 to EdGrupo.Items.Count-1 do
    if Trim(Copy(EdGrupo.Items[I],01,04)) = Trim(TabGlobal.DUSER_NOMES.Grupo.Conteudo) then
      EdGrupo.ItemIndex := I;
  {$ELSE}
  {$I-}
  assignFile(TabGrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Grupos
  reset(TabGrupo);
  Posicao := 0;
  seek(TabGrupo,Posicao);
  while not Eof(TabGrupo) do
  Begin
    Read(TabGrupo,CmpGrupo);
    if (Trim(CmpGrupo.Grupo) <> '') and
       (CmpGrupo.Ativo) then
      EdGrupo.Items.Add(PadR(CmpGrupo.Grupo,04) + ' - ' +CmpGrupo.Descricao);
    Inc(Posicao);
    seek(TabGrupo,Posicao);
  End;
  closefile(TabGrupo);

  Posicao := StrToInt(FormSenhas.PosicaoUsr[FormSenhas.lbUsuarios.ItemIndex]);
  assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT'); // Usuários
  reset(TabUsuario);
  seek(TabUsuario,Posicao);
  Read(TabUsuario,CmpUsuario);
  EdNome.Text       := Decript(CmpUsuario.Usuario);
  EdSenha.Text      := Decript(CmpUsuario.Pass);
  EdConfirme.Text   := EdSenha.Text;
  EdMaster.Checked  := CmpUsuario.Master;
  for I:=0 to EdGrupo.Items.Count-1 do
    if Trim(Copy(EdGrupo.Items[I],01,04)) = Trim(CmpUsuario.Grupo) then
      EdGrupo.ItemIndex := I;
  closefile(TabUsuario);
  {$I+}
  {$ENDIF}
  EdNome.SelectAll;
  EdNome.SetFocus;
end;

procedure TFormEdUsr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (NovoUsuario) and (not Gravou) then
  begin
    {$IFDEF SENHA_DB}
    TabGlobal.DUSER_NOMES.Modifica;
    TabGlobal.DUSER_NOMES.Usuario.Conteudo := Encript(UpperCase(Trim(EdNome.Text)));
    TabGlobal.DUSER_NOMES.Senha.Conteudo   := Encript(Trim(EdSenha.Text));
    if EdMaster.Checked then
      TabGlobal.DUSER_NOMES.Master.Conteudo := 'S'
    else
      TabGlobal.DUSER_NOMES.Master.Conteudo := 'N';
    TabGlobal.DUSER_NOMES.Grupo.Conteudo := UpperCase(Copy(EdGrupo.Text,01,04));
    TabGlobal.DUSER_NOMES.Salva;
    {$ELSE}
    {$I-}
    assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT'); // Usuários
    reset(TabUsuario);
    seek(TabUsuario,Posicao);
    Read(TabUsuario,CmpUsuario);
    CmpUsuario.Usuario := Encript(UpperCase(Trim(EdNome.Text)));
    CmpUsuario.Pass    := Encript(UpperCase(Trim(EdSenha.Text)));
    CmpUsuario.Master  := EdMaster.Checked;
    CmpUsuario.Grupo   := UpperCase(Copy(EdGrupo.Text,01,04));
    CmpUsuario.Ativo   := False;
    seek(TabUsuario,Posicao);
    write(TabUsuario,CmpUsuario);
    closefile(TabUsuario);
    {$I+}
    {$ENDIF}
  end;
end;

procedure TFormEdUsr.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end
  else if Key = Chr(27) then
    Close;
end;

procedure TFormEdUsr.BtnGravarClick(Sender: TObject);
Var
  Ok: Boolean;
  I: Integer;
begin
  if Trim(EdNome.Text) = '' then
  begin
    MessageDlg('Necessário informar NOME !',mtError,[mbOk],0);
    EdNome.SelectAll;
    EdNome.SetFocus;
    exit;
  end;
  Ok := True;
  For I := 0 to FormSenhas.ListaNomesUsr.Count-1 do
    if I <> FormSenhas.lbUsuarios.ItemIndex then
      if EdNome.Text = FormSenhas.ListaNomesUsr[I] then
        Ok := False;
  if not Ok then
  begin
    MessageDlg('Usuário já cadastrado !',mtError,[mbOk],0);
    EdNome.SelectAll;
    EdNome.SetFocus;
    exit;
  end;
  if EdSenha.Text <> EdConfirme.Text then
  begin
    MessageDlg('Senha não confere !',mtError,[mbOk],0);
    EdSenha.SelectAll;
    EdSenha.SetFocus;
    exit;
  end;
  {$IFDEF SENHA_DB}
  TabGlobal.DUSER_NOMES.Modifica;
  TabGlobal.DUSER_NOMES.Usuario.Conteudo := Encript(UpperCase(Trim(EdNome.Text)));
  TabGlobal.DUSER_NOMES.Senha.Conteudo   := Encript(Trim(EdSenha.Text));
  if EdMaster.Checked then
    TabGlobal.DUSER_NOMES.Master.Conteudo := 'S'
  else
    TabGlobal.DUSER_NOMES.Master.Conteudo := 'N';
  TabGlobal.DUSER_NOMES.Grupo.Conteudo := UpperCase(Copy(EdGrupo.Text,01,04));
  TabGlobal.DUSER_NOMES.Salva;
  {$ELSE}
  {$I-}
  assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT'); // Usuários
  reset(TabUsuario);
  seek(TabUsuario,Posicao);
  Read(TabUsuario,CmpUsuario);
  CmpUsuario.Usuario := Encript(UpperCase(Trim(EdNome.Text)));
  CmpUsuario.Pass    := Encript(UpperCase(Trim(EdSenha.Text)));
  CmpUsuario.Master  := EdMaster.Checked;
  CmpUsuario.Grupo   := UpperCase(Copy(EdGrupo.Text,01,04));
  CmpUsuario.Ativo   := True;
  seek(TabUsuario,Posicao);
  write(TabUsuario,CmpUsuario);
  closefile(TabUsuario);
  {$I+}
  {$ENDIF}
  Gravou := True;
  Close;
end;

end.
