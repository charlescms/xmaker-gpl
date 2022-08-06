{
   Programa.: Senhas.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Senhas;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Tabela, IBUpdateSQL, DB, RxGIF,
  jpeg;

type
  TFormSenhas = class(TForm)
    BtnEditar_Grp: TBitBtn;
    BtnEditar_Usr: TBitBtn;
    BtnExcluir_Grp: TBitBtn;
    BtnExcluir_Usr: TBitBtn;
    BtnIncluir_Grp: TBitBtn;
    BtnIncluir_Usr: TBitBtn;
    BtnOk: TBitBtn;
    Label1: TLabel;
    lbGrupos: TListBox;
    lbUsuarios: TListBox;
    PageSenhas: TPageControl;
    PagGrupo: TTabSheet;
    PagUsr: TTabSheet;
    PanelInf: TPanel;
    Image2: TImage;
    Image1: TImage;
    BtnLog: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PageSenhasChange(Sender: TObject);
    procedure BtnIncluir_UsrClick(Sender: TObject);
    procedure BtnEditar_UsrClick(Sender: TObject);
    procedure BtnExcluir_UsrClick(Sender: TObject);
    procedure BtnIncluir_GrpClick(Sender: TObject);
    procedure BtnEditar_GrpClick(Sender: TObject);
    procedure BtnExcluir_GrpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbUsuariosDblClick(Sender: TObject);
    procedure lbGruposDblClick(Sender: TObject);
    procedure lbUsuariosDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BtnLogClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaUsuarios;
  public
    { Public declarations }
    ListaNomesUsr,ListaNomesGrp : TStringList;
    PosicaoUsr, PosicaoGrp: TStringList;
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
  FormSenhas: TFormSenhas;
  {$IFNDEF SENHA_DB}
  TabUsuario : file of TUsuario;
  TabGrupo   : file of TGrupo;
  CmpUsuario : TUsuario;
  CmpGrupo   : TGrupo;
  {$ENDIF}
  ProximoUsr : Integer;
  ProximoGrp : Integer;
  NovoGrupo  : Boolean;
  NovoUsuario: Boolean;

implementation

{$R *.DFM}

uses Rotinas, Publicas, EdUsr, EdGrp, Abertura, Interno;

procedure TFormSenhas.FormShow(Sender: TObject);
begin
  ListaNomesUsr := TStringList.Create;
  ListaNomesGrp := TStringList.Create;
  PosicaoUsr    := TStringList.Create;
  PosicaoGrp    := TStringList.Create;
  PageSenhas.ActivePageIndex := 0;
  AtualizaUsuarios;
end;

procedure TFormSenhas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF SENHA_DB}
  TabGlobal.DUSER_MENU_LATERAL.Close;
  TabGlobal.DUSER_MENU_SUPERIOR.Close;
  TabGlobal.DUSER_BARRA_F.Close;
  TabGlobal.DUSER_TABELAS.Close;
  TabGlobal.DUSER_NOMES.Close;
  TabGlobal.DUSER_GRUPOS.Close;
  {$ENDIF}
  ListaNomesUsr.Free;
  ListaNomesGrp.Free;
  PosicaoUsr.Free;
  PosicaoGrp.Free;
end;

procedure TFormSenhas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = chr(27) then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormSenhas.AtualizaUsuarios;
Var
  PosDat, I: Integer;
  PosUsrAt,PosGrpAt: Integer;
begin
  if lbUsuarios.ItemIndex > 0 then
    PosUsrAt := lbUsuarios.ItemIndex
  else
    PosUsrAt := 0;
  if lbGrupos.ItemIndex > 0 then
    PosGrpAt := lbGrupos.ItemIndex
  else
    PosGrpAt := 0;
  lbUsuarios.Items.Clear;
  lbGrupos.Items.Clear;
  ListaNomesUsr.Clear;
  ListaNomesGrp.Clear;
  PosicaoUsr.Clear;
  PosicaoGrp.Clear;
  {$IFDEF SENHA_DB}
  TabGlobal.DUSER_NOMES.Filtro.Clear;
  TabGlobal.DUSER_NOMES.AtualizaSql;
  while not TabGlobal.DUSER_NOMES.Eof do
  begin
    if TabGlobal.DUSER_NOMES.Master.Conteudo = 'S' then
      lbUsuarios.Items.AddObject(Decript(TabGlobal.DUSER_NOMES.Usuario.Conteudo), TObject(1))
    else
      lbUsuarios.Items.AddObject(Decript(TabGlobal.DUSER_NOMES.Usuario.Conteudo), TObject(0));
    TabGlobal.DUSER_NOMES.Next;
  end;
  for I:=0 to lbUsuarios.Items.Count-1 do
    ListaNomesUsr.Add(lbUsuarios.Items[I]);

  TabGlobal.DUSER_GRUPOS.Filtro.Clear;
  TabGlobal.DUSER_GRUPOS.AtualizaSql;
  while not TabGlobal.DUSER_GRUPOS.Eof do
  begin
    if (Trim(TabGlobal.DUSER_GRUPOS.Grupo.Conteudo) <> '') then
    begin
      ListaNomesGrp.Add(TabGlobal.DUSER_GRUPOS.Grupo.Conteudo);
      lbGrupos.Items.Add(PadR(TabGlobal.DUSER_GRUPOS.Grupo.Conteudo,04) + ' - ' + TabGlobal.DUSER_GRUPOS.Descricao.Conteudo);
    end;
    TabGlobal.DUSER_GRUPOS.Next;
  end;
  {$ELSE}
  {$I-}
  assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT'); // Usuários
  reset(TabUsuario);
  PosDat  := 0;
  seek(TabUsuario,PosDat);
  while not Eof(TabUsuario) do
  Begin
    Read(TabUsuario,CmpUsuario);
    if (Trim(CmpUsuario.Usuario) <> '') and
       (CmpUsuario.Ativo) then
    begin
      PosicaoUsr.Add(IntToStr(PosDat));
      if CmpUsuario.Master then
        lbUsuarios.Items.AddObject(Decript(CmpUsuario.Usuario), TObject(1))
      else
        lbUsuarios.Items.AddObject(Decript(CmpUsuario.Usuario), TObject(0));
    end;
    Inc(PosDat);
    seek(TabUsuario,PosDat);
  End;
  closefile(TabUsuario);
  ProximoUsr := PosDat;
  for I:=0 to lbUsuarios.Items.Count-1 do
    ListaNomesUsr.Add(lbUsuarios.Items[I]);

  assignFile(TabGrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Grupos
  reset(TabGrupo);
  PosDat := 0;
  seek(TabGrupo,PosDat);
  while not Eof(TabGrupo) do
  Begin
    Read(TabGrupo,CmpGrupo);
    if (Trim(CmpGrupo.Grupo) <> '') and
       (CmpGrupo.Ativo)  then
    begin
      ListaNomesGrp.Add(CmpGrupo.Grupo);
      PosicaoGrp.Add(IntToStr(PosDat));
      lbGrupos.Items.Add(PadR(CmpGrupo.Grupo,04) + ' - ' + CmpGrupo.Descricao);
    end;
    Inc(PosDat);
    seek(TabGrupo,PosDat);
  End;
  closefile(TabGrupo);
  ProximoGrp := PosDat;
  {$I+}
  {$ENDIF}

  if lbUsuarios.Items.Count > 0 then
    if PosUsrAt <= lbUsuarios.Items.Count-1 then
      lbUsuarios.ItemIndex := PosUsrAt
    else
      lbUsuarios.ItemIndex := 0;
  if lbGrupos.Items.Count > 0 then
    if PosGrpAt <= lbGrupos.Items.Count-1 then
      lbGrupos.ItemIndex := PosGrpAt
    else
      lbGrupos.ItemIndex := 0;
end;

procedure TFormSenhas.PageSenhasChange(Sender: TObject);
begin
  if PageSenhas.ActivePageIndex = 0 then
    lbUsuarios.SetFocus
  else
    lbGrupos.SetFocus;
end;

procedure TFormSenhas.BtnIncluir_UsrClick(Sender: TObject);
begin
  {$IFDEF SENHA_DB}
  TabGlobal.DUSER_NOMES.Inclui(Nil);
  TabGlobal.DUSER_NOMES.Usuario.Conteudo := Encript(UpperCase('Novo'));
  TabGlobal.DUSER_NOMES.Senha.Conteudo   := Encript('');
  TabGlobal.DUSER_NOMES.Master.Conteudo  := 'N';
  TabGlobal.DUSER_NOMES.Grupo.Conteudo   := '';
  TabGlobal.DUSER_NOMES.Salva;
  {$ELSE}
  {$I-}
  assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT'); // Usuários
  reset(TabUsuario);
  seek(TabUsuario,ProximoUsr);
  Read(TabUsuario,CmpUsuario);
  CmpUsuario.Usuario := Encript(UpperCase(Trim('Novo')));
  CmpUsuario.Pass    := Encript('');
  CmpUsuario.Master  := False;
  CmpUsuario.Grupo   := '';
  CmpUsuario.Ativo   := True;
  seek(TabUsuario,ProximoUsr);
  write(TabUsuario,CmpUsuario);
  closefile(TabUsuario);
  {$I+}
  {$ENDIF}
  AtualizaUsuarios;
  lbUsuarios.ItemIndex := lbUsuarios.Items.IndexOf('NOVO');
  NovoUsuario := True;
  BtnEditar_UsrClick(Self);
end;

procedure TFormSenhas.BtnEditar_UsrClick(Sender: TObject);
begin
  if lbUsuarios.ItemIndex < 0 then
  begin
    MessageDlg('Usuário não selecionado !',mtInformation,[mbOk],0);
    exit;
  end;
  FormEdUsr := TFormEdUsr.Create(Application);
  Try
    {$IFDEF SENHA_DB}
    TabGlobal.DUSER_NOMES.First;
    TabGlobal.DUSER_NOMES.Locate('usuario', Encript(ListaNomesUsr[lbUsuarios.ItemIndex]), [loCaseInsensitive]);
    {$ENDIF}
    FormEdUsr.NovoUsuario := NovoUsuario;
    FormEdUsr.ShowModal;
  Finally
    FormEdUsr.Free;
  end;
  NovoUsuario := False;
  AtualizaUsuarios;
  lbUsuarios.SetFocus;
end;

procedure TFormSenhas.BtnExcluir_UsrClick(Sender: TObject);
begin
  if lbUsuarios.ItemIndex < 0 then
  begin
    MessageDlg('Usuário não selecionado !',mtInformation,[mbOk],0);
    exit;
  end;
  if lbUsuarios.Items.Count > 1 then
  begin
    if MessageDlg('Excluir Usuário: '+lbUsuarios.Items[lbUsuarios.ItemIndex]+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      {$IFDEF SENHA_DB}
      TabGlobal.DUSER_NOMES.First;
      TabGlobal.DUSER_NOMES.Locate('usuario', Encript(ListaNomesUsr[lbUsuarios.ItemIndex]), [loCaseInsensitive]);
      TabGlobal.DUSER_NOMES.Exclui;
      {$ELSE}
      {$I-}
      assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT'); // Usuários
      reset(TabUsuario);
      seek(TabUsuario,StrToInt(PosicaoUsr[lbUsuarios.ItemIndex]));
      if not Eof(TabUsuario) then
      Begin
        Read(TabUsuario,CmpUsuario);
        CmpUsuario.Ativo := False;
        seek(TabUsuario,StrToInt(PosicaoUsr[lbUsuarios.ItemIndex]));
        write(TabUsuario,CmpUsuario);
      End;
      closefile(TabUsuario);
      {$I+}
      {$ENDIF}
      AtualizaUsuarios;
      lbUsuarios.SetFocus;
    end;
  end
  else
    MessageDlg('Lista de usuários não pode ser vazia !',mtInformation,[mbOk],0);
end;

procedure TFormSenhas.BtnIncluir_GrpClick(Sender: TObject);
var
  I: Integer;
  Grupo: String;
begin
  Grupo := 'NOVO';
  {$IFDEF SENHA_DB}
  for I:=1 to 9999 do
    if not PTabela(TabGlobal.DUSER_GRUPOS, ['GRUPO'], [StrZero(I, 04)]) then
    begin
      Grupo := StrZero(I, 04);
      break;
    end;
  TabGlobal.DUSER_GRUPOS.Inclui(Nil);
  TabGlobal.DUSER_GRUPOS.Grupo.Conteudo     := Grupo;
  TabGlobal.DUSER_GRUPOS.Descricao.Conteudo := 'Novo Grupo';
  TabGlobal.DUSER_GRUPOS.Salva;
  {$ELSE}
  {$I-}
  assignFile(TabGrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Grupos
  reset(TabGrupo);
  seek(TabGrupo,ProximoGrp);
  Read(TabGrupo,CmpGrupo);
  CmpGrupo.Grupo     := Grupo;
  CmpGrupo.Descricao := 'Novo Grupo';
  CmpGrupo.Ativo     := True;
  seek(TabGrupo,ProximoGrp);
  write(TabGrupo,CmpGrupo);
  closefile(TabGrupo);
  {$I+}
  {$ENDIF}
  AtualizaUsuarios;
  lbGrupos.ItemIndex := lbGrupos.Items.IndexOf(Grupo+' - Novo Grupo');
  NovoGrupo := True;
  BtnEditar_GrpClick(Self);
end;

procedure TFormSenhas.BtnEditar_GrpClick(Sender: TObject);
begin
  if lbGrupos.ItemIndex < 0 then
  begin
    MessageDlg('Grupo não selecionado !',mtInformation,[mbOk],0);
    exit;
  end;
  FormEdGrp := TFormEdGrp.Create(Application);
  Try
    {$IFDEF SENHA_DB}
    TabGlobal.DUSER_GRUPOS.First;
    TabGlobal.DUSER_GRUPOS.Locate('grupo', ListaNomesGrp[lbGrupos.ItemIndex], [loCaseInsensitive]);
    {$ENDIF}
    FormEdGrp.NovoGrupo := NovoGrupo;
    FormEdGrp.ShowModal;
  Finally
    FormEdGrp.Free;
  end;
  NovoGrupo := False;
  AtualizaUsuarios;
  lbGrupos.SetFocus;
end;

procedure TFormSenhas.BtnExcluir_GrpClick(Sender: TObject);
begin
  if lbGrupos.ItemIndex < 0 then
  begin
    MessageDlg('Grupo não selecionado !',mtInformation,[mbOk],0);
    exit;
  end;
  if lbGrupos.ItemIndex >= 0 then
  begin
    if MessageDlg('Excluir Grupo: '+lbGrupos.Items[lbGrupos.ItemIndex]+' ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      {$IFDEF SENHA_DB}
      TabGlobal.DUSER_GRUPOS.First;
      TabGlobal.DUSER_GRUPOS.Locate('grupo', ListaNomesGrp[lbGrupos.ItemIndex], [loCaseInsensitive]);
      TabGlobal.DUSER_GRUPOS.Exclui;
      {$ELSE}
      {$I-}
      assignFile(TabGrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Usuários
      reset(TabGrupo);
      seek(TabGrupo,StrToInt(PosicaoGrp[lbGrupos.ItemIndex]));
      if not Eof(TabGrupo) then
      Begin
        Read(TabGrupo,CmpGrupo);
        CmpGrupo.Ativo := False;
        seek(TabGrupo,StrToInt(PosicaoGrp[lbGrupos.ItemIndex]));
        write(TabGrupo,CmpGrupo);
      End;
      closefile(TabGrupo);
      {$I+}
      {$ENDIF}
      AtualizaUsuarios;
      lbGrupos.SetFocus;
    end;
  end;
end;

procedure TFormSenhas.lbUsuariosDblClick(Sender: TObject);
begin
  BTNEDITAR_USRclick(Self);
end;

procedure TFormSenhas.lbGruposDblClick(Sender: TObject);
begin
  BTNEDITAR_GRPclick(Self);
end;

procedure TFormSenhas.lbUsuariosDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  Image: TImage;
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    if Integer(Items.Objects[Index]) = 1 then
      Image := Image1
    else
      Image := Image2;
    Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormSenhas.BtnLogClick(Sender: TObject);
begin
  Interno122;
end;

end.
