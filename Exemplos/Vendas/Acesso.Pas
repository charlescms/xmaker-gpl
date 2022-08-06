{
   Programa.: Acesso.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Acesso;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Menus, Comctrls, jpeg, Tabela, DB, Atributo,
  IBUpdateSQL, XBanner;

type
  TFormAcesso = class(TForm)
    BtnCancela: TBitBtn;
    BtnOk: TBitBtn;
    LbMensagem: TLabel;
    LbSenha: TLabel;
    LbUsuario: TLabel;
    Senha: TEdit;
    Usuario: TEdit;
    Panel1: TPanel;
    Image1: TImage;
    LbTitulo1: TLabel;
    LbTitulo2: TLabel;
    Panel2: TPanel;
    BtnSobre: TSpeedButton;
    LbTroca: TLabel;
    LbNova: TLabel;
    NovaSenha: TEdit;
    BtnCancelaNovaSenha: TBitBtn;
    LbConfirma: TLabel;
    ConfirmaSenha: TEdit;
    procedure UsuarioChange(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SenhaExit(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure BtnSobreClick(Sender: TObject);
    procedure LbTrocaClick(Sender: TObject);
    procedure BtnCancelaNovaSenhaClick(Sender: TObject);
    procedure ConfirmaSenhaExit(Sender: TObject);
  private
    { Private declarations }
    procedure Mensagem(Texto: String; Cor: TColor; Pausa: Boolean = False);
  public
    { Public declarations }
    SenhaInicial: string;
    Tentativas: Integer;
    QtdTentativas: Integer;
    Liberacao: Boolean;
    procedure VerificaTabelas;
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
Type
  TOpcao = record                     // Tabela de Opções de Acesso
           Opcao      : Integer;
           Grupo      : String[04];
           PorSenha   : Boolean;
           Ativo      : Boolean;
  end;
Type
  TOpcao1= record                     // Tabela de Opções de Acesso
           Opcao      : Integer;
           Grupo      : String[04];
           PorSenha   : Boolean;
           Invisivel  : Boolean;
           Ativo      : Boolean;
  end;
Type
  TTabelaGrp = record                     // Tabela de Acesso a Tabelas
           Tabela     : String[20];
           Grupo      : String[04];
           Cerceado   : String[10];
           Ativo      : Boolean;
  end;
{$ENDIF}

var
  FormAcesso: TFormAcesso;
  {$IFNDEF SENHA_DB}
  TabUsuario : file of TUsuario;
  TabGrupo   : file of TGrupo;
  TabOpcao   : file of TOpcao;
  TabTabela  : file of TTabelaGrp;
  TabMenuSup : file of TOpcao1;
  TabBarra   : file of TOpcao1;
  CmpUsuario : TUsuario;
  CmpGrupo   : TGrupo;
  CmpOpcao   : TOpcao;
  CmpTabela  : TTabelaGrp;
  CmpMenuSup : TOpcao1;
  CmpBarra   : TOpcao1;
  {$ENDIF}

implementation

{$R *.DFM}

uses Rotinas, Publicas, Princ, Abertura, Interno;

procedure TFormAcesso.UsuarioChange(Sender: TObject);
begin
  if Usuario.Text = '' then
    BtnOk.Enabled := False
  else
    BtnOk.Enabled := True;
end;

procedure TFormAcesso.BtnOkClick(Sender: TObject);
Var
  UsrOk,PassOk: Boolean;
  PosDat,PosDat2: Integer;

  procedure OpcoesNaoVisiveis;
  var
    I,Z: Integer;
    Botao: TToolButton;
    Menu: TMenuItem;

    procedure SubNivel(Opcao: TMenuItem);
    var
      I: Integer;
    begin
      Opcao.Visible := True;
      if not Sistema.Master then
        if Sistema.OpcoesAcessoMn.IndexOf('I'+IntToStr(Opcao.Tag)) <> -1 then
          Opcao.Visible := False;
      for I:=0 to Opcao.Count-1 do
        SubNivel(Opcao[I]);
    end;

  begin
    for I:=0 to FormPrincipal.BarraFerramentas.ButtonCount-1 do
    begin
      Botao := FormPrincipal.BarraFerramentas.Buttons[I];
      Botao.Visible := True;
      if not Sistema.Master then
        if Sistema.OpcoesAcessoBr.IndexOf('I'+IntToStr(Botao.Tag)) <> -1 then
          Botao.Visible := False;
    end;

    for I:=0 to FormPrincipal.MenuPrincipal.Items.Count-1 do
    begin
      Menu := FormPrincipal.MenuPrincipal.Items[I];
      Menu.Visible := True;
      if not Sistema.Master then
        if Sistema.OpcoesAcessoMn.IndexOf('I'+IntToStr(Menu.Tag)) <> -1 then
          Menu.Visible := False;
      for Z:=0 to Menu.Count-1 do
        SubNivel(Menu[Z]);
    end;
  end;

begin
  Screen.Cursor := crHourGlass;
  Mensagem('Aguarde, Autenticando usuário...', clBlue);
  {$IFDEF SENHA_DB}
  if NovaSenha.Visible then
  begin
    if Trim(NovaSenha.Text) = '' then
    begin
      Screen.Cursor := crDefault;
      Mensagem('', clBlue);
      MessageDlg('Necessário informar a "Nova Senha"!', mtWarning, [mbOk], 0);
      NovaSenha.SelectAll;
      NovaSenha.SetFocus;
      exit;
    end;
    if NovaSenha.Text <> ConfirmaSenha.Text then
    begin
      Screen.Cursor := crDefault;
      Mensagem('', clBlue);
      MessageDlg('"Nova Senha" não confere!', mtWarning, [mbOk], 0);
      NovaSenha.SelectAll;
      NovaSenha.SetFocus;
      exit;
    end;
    TabGlobal.DUSER_NOMES.Filtro.Clear;
    TabGlobal.DUSER_NOMES.Filtro.Add('usuario = '+#39+Encript(UpperCase(Usuario.Text))+#39);
    TabGlobal.DUSER_NOMES.Filtro.Add('and senha = '+#39+Encript(UpperCase(Senha.Text))+#39);
    TabGlobal.DUSER_NOMES.AtualizaSql;
    if not TabGlobal.DUSER_NOMES.Eof then
    begin
      Mensagem('', clBlue);
      if MessageDlg('Confirma a troca de senha?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        TabGlobal.DUSER_NOMES.Modifica;
        TabGlobal.DUSER_NOMES.Senha.Conteudo := Encript(UpperCase(NovaSenha.Text));
        TabGlobal.DUSER_NOMES.Salva;
        Senha.Text := NovaSenha.Text;
        MessageDlg('Troca de senha foi realizada com sucesso!', mtInformation, [mbOk], 0);
      end;
      BtnCancelaNovaSenhaClick(Self);
    end
    else
    begin
      Mensagem('', clBlue);
      MessageDlg('Usuário/Senha inválido!', mtError, [mbOk], 0);
      Usuario.SelectAll;
      Usuario.SetFocus;
    end;
    Screen.Cursor := crDefault;
    exit;
  end;
  TabGlobal.DUSER_NOMES.Filtro.Clear;
  TabGlobal.DUSER_NOMES.AtualizaSql;
  if TabGlobal.DUSER_NOMES.Eof then
  begin
    TabGlobal.DUSER_NOMES.Inclui(Nil);
    TabGlobal.DUSER_NOMES.Usuario.Conteudo := Encript(UpperCase('Master'));
    TabGlobal.DUSER_NOMES.Senha.Conteudo   := Encript(UpperCase(Sistema.SenhaInicial));
    TabGlobal.DUSER_NOMES.Master.Conteudo  := 'S';
    TabGlobal.DUSER_NOMES.Grupo.Conteudo   := '';
    TabGlobal.DUSER_NOMES.Salva;
  end;
  // Atribui o nome de todos usuários para lista
  Sistema.ListaUsuarios.Clear;
  while not TabGlobal.DUSER_NOMES.Eof do
  Begin
    Sistema.ListaUsuarios.Add(Decript(TabGlobal.DUSER_NOMES.Usuario.Conteudo));
    TabGlobal.DUSER_NOMES.Next;
  End;
  Sistema.ListaUsuarios.Sorted := True;

  TabGlobal.DUSER_NOMES.Filtro.Clear;
  TabGlobal.DUSER_NOMES.Filtro.Add('usuario = '+#39+Encript(UpperCase(Usuario.Text))+#39);
  TabGlobal.DUSER_NOMES.Filtro.Add('and senha = '+#39+Encript(UpperCase(Senha.Text))+#39);
  TabGlobal.DUSER_NOMES.AtualizaSql;
  if not TabGlobal.DUSER_NOMES.Eof then
  begin
    UsrOk := True;
    PassOk := True;
    if (Liberacao) and (not (TabGlobal.DUSER_NOMES.Master.Conteudo = 'S')) then
    begin
      Mensagem('Acesso Negado, '+Usuario.Text, clRed, True);
      QtdTentativas  := 0;
      ModalResult := mrCancel;
    end
    else
    begin
      Mensagem('Bom Trabalho, '+Usuario.Text, clBlue);
      QtdTentativas  := 0;
      ModalResult    := mrOk;
      if not Liberacao then
      begin
        Sistema.OpcoesAcesso.Clear;
        Sistema.OpcoesAcessoMn.Clear;
        Sistema.OpcoesAcessoBr.Clear;
        Sistema.OpcoesTabela.Clear;
        TabGlobal.DUSER_MENU_LATERAL.Filtro.Text := 'Grupo = '+#39+TabGlobal.DUSER_NOMES.Grupo.Conteudo+#39;
        TabGlobal.DUSER_MENU_LATERAL.AtualizaSql;
        while not TabGlobal.DUSER_MENU_LATERAL.Eof do
        begin
          if TabGlobal.DUSER_MENU_LATERAL.PorSenha.Conteudo = 'S' then
            Sistema.OpcoesAcesso.Add('S'+IntToStr(TabGlobal.DUSER_MENU_LATERAL.Opcao.Conteudo))
          else
            Sistema.OpcoesAcesso.Add('N'+IntToStr(TabGlobal.DUSER_MENU_LATERAL.Opcao.Conteudo));
          TabGlobal.DUSER_MENU_LATERAL.Next;
        end;

        TabGlobal.DUSER_MENU_SUPERIOR.Filtro.Text := 'Grupo = '+#39+TabGlobal.DUSER_NOMES.Grupo.Conteudo+#39;
        TabGlobal.DUSER_MENU_SUPERIOR.AtualizaSql;
        while not TabGlobal.DUSER_MENU_SUPERIOR.Eof do
        begin
          if TabGlobal.DUSER_MENU_SUPERIOR.Invisivel.Conteudo = 'S' then
            Sistema.OpcoesAcessoMn.Add('I'+IntToStr(TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo))
          else
            if TabGlobal.DUSER_MENU_SUPERIOR.PorSenha.Conteudo = 'S' then
              Sistema.OpcoesAcessoMn.Add('S'+IntToStr(TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo))
            else
              Sistema.OpcoesAcessoMn.Add('N'+IntToStr(TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo));
          TabGlobal.DUSER_MENU_SUPERIOR.Next;
        end;

        TabGlobal.DUSER_BARRA_F.Filtro.Text := 'Grupo = '+#39+TabGlobal.DUSER_NOMES.Grupo.Conteudo+#39;
        TabGlobal.DUSER_BARRA_F.AtualizaSql;
        while not TabGlobal.DUSER_BARRA_F.Eof do
        begin
          if TabGlobal.DUSER_BARRA_F.Invisivel.Conteudo = 'S' then
            Sistema.OpcoesAcessoBr.Add('I'+IntToStr(TabGlobal.DUSER_BARRA_F.Opcao.Conteudo))
          else
            if TabGlobal.DUSER_BARRA_F.PorSenha.Conteudo = 'S' then
              Sistema.OpcoesAcessoBr.Add('S'+IntToStr(TabGlobal.DUSER_BARRA_F.Opcao.Conteudo))
            else
              Sistema.OpcoesAcessoBr.Add('N'+IntToStr(TabGlobal.DUSER_BARRA_F.Opcao.Conteudo));
          TabGlobal.DUSER_BARRA_F.Next;
        end;

        TabGlobal.DUSER_TABELAS.Filtro.Text := 'Grupo = '+#39+TabGlobal.DUSER_NOMES.Grupo.Conteudo+#39;
        TabGlobal.DUSER_TABELAS.AtualizaSql;
        while not TabGlobal.DUSER_TABELAS.Eof do
        begin
          Sistema.OpcoesTabela.Add(PadR(TabGlobal.DUSER_TABELAS.Tabela_Obj.Conteudo,20)+TabGlobal.DUSER_TABELAS.Cerceado.Conteudo);
          TabGlobal.DUSER_TABELAS.Next;
        end;

        Sistema.Usuario := Decript(TabGlobal.DUSER_NOMES.Usuario.Conteudo);
        Sistema.Senha   := Decript(TabGlobal.DUSER_NOMES.Senha.Conteudo);
        if TabGlobal.DUSER_NOMES.Master.Conteudo = 'S' then
          Sistema.Master:= True
        else
          Sistema.Master:= False;
        Sistema.Grupo   := TabGlobal.DUSER_NOMES.Grupo.Conteudo;
        OpcoesNaoVisiveis;
        Atualiza_Status;
      end;
    end;
  end
  else
    UsrOk := False;
  {$ELSE}
  {$I-}
  assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT');
  reset(TabUsuario);
  PosDat := 0;
  seek(TabUsuario,PosDat);
  if Eof(TabUsuario) then
  begin
    with CmpUsuario do
    Begin
      Usuario := Encript(UpperCase('Master'));
      Pass    := Encript(UpperCase(Sistema.SenhaInicial));
      Master  := True;
      Grupo   := '';
      Ativo   := True;
    End;
    //rewrite(TabUsuario);
    seek(TabUsuario,0);
    write(TabUsuario,CmpUsuario);
  end;

  // Atribui o nome de todos usuários para lista
  Sistema.ListaUsuarios.Clear;
  seek(TabUsuario,PosDat);
  while not Eof(TabUsuario) do
  Begin
    Read(TabUsuario,CmpUsuario);
    Sistema.ListaUsuarios.Add(Decript(CmpUsuario.Usuario));
    Inc(PosDat);
    seek(TabUsuario,PosDat);
  End;
  Sistema.ListaUsuarios.Sorted := True;

  PosDat := 0;
  UsrOk  := False;
  PassOk := False;
  seek(TabUsuario,PosDat);
  while not Eof(TabUsuario) do
  Begin
    Read(TabUsuario,CmpUsuario);
    if (CmpUsuario.Usuario = Encript(UpperCase(Usuario.Text))) and
       (CmpUsuario.Ativo) then
    Begin
      UsrOk := True;
      if CmpUsuario.Pass = Encript(UpperCase(Senha.Text)) then
      Begin
        PassOk := True;
        if (Liberacao) and (not CmpUsuario.Master) then
        begin
          Mensagem('Acesso Negado, '+Usuario.Text, clRed, True);
          QtdTentativas  := 0;
          PosDat         := 99999;
          ModalResult := mrCancel;
        end
        else
        begin
          Mensagem('Bom Trabalho, '+Usuario.Text, clBlue);
          QtdTentativas  := 0;
          PosDat         := 99999;
          ModalResult    := mrOk;
          if not Liberacao then
          begin
            Sistema.OpcoesAcesso.Clear;
            Sistema.OpcoesAcessoMn.Clear;
            Sistema.OpcoesAcessoBr.Clear;
            Sistema.OpcoesTabela.Clear;

            assignFile(TabOpcao,Sistema.Pasta + 'SYSOPC.DAT');
            reset(TabOpcao);
            PosDat2 := 0;
            seek(TabOpcao,PosDat2);
            while not Eof(TabOpcao) do
            Begin
              Read(TabOpcao,CmpOpcao);
              if (Trim(CmpOpcao.Grupo) = Trim(CmpUsuario.Grupo)) and
                 (CmpOpcao.Ativo) then
              begin
                if CmpOpcao.PorSenha then
                  Sistema.OpcoesAcesso.Add('S'+IntToStr(CmpOpcao.Opcao))
                else
                  Sistema.OpcoesAcesso.Add('N'+IntToStr(CmpOpcao.Opcao));
              end;
              Inc(PosDat2);
              seek(TabOpcao,PosDat2);
            End;
            CloseFile(TabOpcao);

            assignFile(TabMenuSup,Sistema.Pasta + 'SYSMNU.DAT');
            reset(TabMenuSup);
            PosDat2 := 0;
            seek(TabMenuSup,PosDat2);
            while not Eof(TabMenuSup) do
            Begin
              Read(TabMenuSup,CmpMenuSup);
              if (Trim(CmpMenuSup.Grupo) = Trim(CmpUsuario.Grupo)) and
                 (CmpMenuSup.Ativo) then
              begin
                if CmpMenuSup.Invisivel then
                  Sistema.OpcoesAcessoMn.Add('I'+IntToStr(CmpMenuSup.Opcao))
                else
                  if CmpMenuSup.PorSenha then
                    Sistema.OpcoesAcessoMn.Add('S'+IntToStr(CmpMenuSup.Opcao))
                  else
                    Sistema.OpcoesAcessoMn.Add('N'+IntToStr(CmpMenuSup.Opcao));
              end;
              Inc(PosDat2);
              seek(TabMenuSup,PosDat2);
            End;
            CloseFile(TabMenuSup);

            assignFile(TabBarra,Sistema.Pasta + 'SYSBAR.DAT');
            reset(TabBarra);
            PosDat2 := 0;
            seek(TabBarra,PosDat2);
            while not Eof(TabBarra) do
            Begin
              Read(TabBarra,CmpBarra);
              if (Trim(CmpBarra.Grupo) = Trim(CmpUsuario.Grupo)) and
                 (CmpBarra.Ativo) then
              begin
                if CmpBarra.Invisivel then
                  Sistema.OpcoesAcessoBr.Add('I'+IntToStr(CmpBarra.Opcao))
                else
                  if CmpBarra.PorSenha then
                    Sistema.OpcoesAcessoBr.Add('S'+IntToStr(CmpBarra.Opcao))
                  else
                    Sistema.OpcoesAcessoBr.Add('N'+IntToStr(CmpBarra.Opcao));
              end;
              Inc(PosDat2);
              seek(TabBarra,PosDat2);
            End;
            CloseFile(TabBarra);

            assignFile(TabTabela,Sistema.Pasta + 'SYSTAB.DAT');
            reset(TabTabela);
            PosDat2 := 0;
            seek(TabTabela,PosDat2);
            while not Eof(TabTabela) do
            Begin
              Read(TabTabela,CmpTabela);
              if (Trim(CmpTabela.Grupo) = Trim(CmpUsuario.Grupo)) and
                 (CmpTabela.Ativo) then
                Sistema.OpcoesTabela.Add(PadR(CmpTabela.Tabela,20)+CmpTabela.Cerceado);
              Inc(PosDat2);
              seek(TabTabela,PosDat2);
            End;
            CloseFile(TabTabela);

            Sistema.Usuario := Decript(CmpUsuario.Usuario);
            Sistema.Senha   := Decript(CmpUsuario.Pass);
            Sistema.Master  := CmpUsuario.Master;
            Sistema.Grupo   := CmpUsuario.Grupo;
            OpcoesNaoVisiveis;
            Atualiza_Status;
          End;
        End;
      End;
    End;
    Inc(PosDat);
    seek(TabUsuario,PosDat);
  End;
  closefile(TabUsuario);
  {$I+}
  {$ENDIF}
  if Not UsrOk then
  Begin
    Inc(QtdTentativas);
    Mensagem('', clBlue);
    MessageDlg('Usuário não Cadastrado !', mtError, [mbOk], 0);
    ModalResult := mrNone;
    Usuario.SetFocus;
  End;
  if (UsrOk) and (not PassOk) then
  Begin
    Inc(QtdTentativas);
    Mensagem('', clBlue);
    MessageDlg('Senha Inválida !', mtError, [mbOk], 0);
    ModalResult := mrNone;
    Senha.SetFocus;
  End;
  if QtdTentativas > Tentativas then
  begin
    Mensagem('Usuário não autorizado !', clRed, True);
    ModalResult := mrCancel;
  end;
  Screen.Cursor := crDefault;
end;

procedure TFormAcesso.VerificaTabelas;
var
  io : integer;
begin
  {$IFNDEF SENHA_DB}
  {$I-}
  assignFile(TabUsuario,Sistema.Pasta + 'SYSUSR.DAT');
  repeat
    reset(TabUsuario);
    io:=ioresult;
    if io=2 then
    Begin
      with CmpUsuario do
      Begin
        Usuario := Encript(UpperCase('Master'));
        Pass    := Encript(UpperCase(Sistema.SenhaInicial));
        Master  := True;
        Grupo   := '';
        Ativo   := True;
      End;
      rewrite(TabUsuario);
      seek(TabUsuario,0);
      write(TabUsuario,CmpUsuario);
    End;
  until (io=0);
  closefile(TabUsuario);
  {$I+}

  {$I-}
  assignFile(TabGrupo,Sistema.Pasta + 'SYSGRP.DAT');
  repeat
    reset(TabGrupo);
    io:=ioresult;
    if io=2 then
    Begin
      with CmpGrupo do
      Begin
        Grupo     := '';
        Descricao := '';
        Ativo     := True;
      End;
      rewrite(TabGrupo);
      seek(TabGrupo,0);
      write(TabGrupo,CmpGrupo);
    End;
  until (io=0);
  closefile(TabGrupo);
  {$I+}

  {$I-}
  assignFile(TabOpcao,Sistema.Pasta + 'SYSOPC.DAT');
  repeat
    reset(TabOpcao);
    io:=ioresult;
    if io=2 then
    Begin
      with CmpOpcao do
      Begin
        Opcao     := -1;
        Grupo     := '';
        PorSenha  := False;
        Ativo     := True;
      End;
      rewrite(TabOpcao);
      seek(TabOpcao,0);
      write(TabOpcao,CmpOpcao);
    End;
  until (io=0);
  closefile(TabOpcao);
  {$I+}

  {$I-}
  assignFile(TabMenuSup,Sistema.Pasta + 'SYSMNU.DAT');
  repeat
    reset(TabMenuSup);
    io:=ioresult;
    if io=2 then
    Begin
      with CmpMenuSup do
      Begin
        Opcao     := -1;
        Grupo     := '';
        PorSenha  := False;
        Ativo     := True;
      End;
      rewrite(TabMenuSup);
      seek(TabMenuSup,0);
      write(TabMenuSup,CmpMenuSup);
    End;
  until (io=0);
  closefile(TabMenuSup);
  {$I+}

  {$I-}
  assignFile(TabBarra,Sistema.Pasta + 'SYSBAR.DAT');
  repeat
    reset(TabBarra);
    io:=ioresult;
    if io=2 then
    Begin
      with CmpBarra do
      Begin
        Opcao     := -1;
        Grupo     := '';
        PorSenha  := False;
        Ativo     := True;
      End;
      rewrite(TabBarra);
      seek(TabBarra,0);
      write(TabBarra,CmpBarra);
    End;
  until (io=0);
  closefile(TabBarra);
  {$I+}

  {$I-}
  assignFile(TabTabela,Sistema.Pasta + 'SYSTAB.DAT');
  repeat
    reset(TabTabela);
    io:=ioresult;
    if io=2 then
    Begin
      with CmpTabela do
      Begin
        Tabela := '';
        Grupo  := '';
        Ativo  := True;
      End;
      rewrite(TabTabela);
      seek(TabTabela,0);
      write(TabTabela,CmpTabela);
    End;
  until (io=0);
  closefile(TabTabela);
  {$I+}
  {$ENDIF}
end;

procedure TFormAcesso.BtnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAcesso.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end
  else if Key = Chr(27) then
    Close;
end;

procedure TFormAcesso.SenhaExit(Sender: TObject);
begin
  if (ActiveControl <> BtnCancela) and (ActiveControl <> Usuario) and
     (ActiveControl <> NovaSenha) and (ActiveControl <> ConfirmaSenha) then
    BtnOkClick(Self);
end;

procedure TFormAcesso.Mensagem(Texto: String; Cor: TColor; Pausa: Boolean = False);
Begin
  LbMensagem.Visible    := True;
  LbMensagem.Font.Color := Cor;
  LbMensagem.Caption    := Texto;
  Application.ProcessMessages;
  if Pausa then
    Sleep(1000);
End;

procedure TFormAcesso.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If button = mbleft then
  begin
    releasecapture;
    FormAcesso.perform (WM_syscommand, $F012, 0);
  end;
end;

procedure TFormAcesso.FormShow(Sender: TObject);

  function Nome_Projeto: String;
  begin
    Result := ExtractFileName(Application.ExeName);
    if Pos('.', Result) > 1 then
      Result := Copy(Result, 01, Pos('.', Result)-1);
  end;

begin
  BtnCancelaNovaSenhaClick(Self);
  LbTitulo1.Caption := Nome_Projeto + ' - Versão: ' + Sistema.Versao;
  LbTitulo2.Caption := Sistema.Titulo;

  {$IFDEF SENHA_DB}
  LbTroca.Visible := True;
  {$ELSE}
  LbTroca.Visible := False;
  {$ENDIF}
end;

procedure TFormAcesso.BtnSobreClick(Sender: TObject);
begin
  Interno119;
end;

procedure TFormAcesso.LbTrocaClick(Sender: TObject);
begin
  LbSenha.Caption := '&Senha Atual:';
  LbNova.Visible := True;
  LbConfirma.Visible := True;
  NovaSenha.Visible := True;
  ConfirmaSenha.Visible := True;
  BtnCancelaNovaSenha.Visible := True;
  LbUsuario.Top := LbUsuario.Top - 10;
  Usuario.Top   := Usuario.Top - 10;
  LbSenha.Top   := LbSenha.Top - 10;
  Senha.Top     := Senha.Top - 10;
  LbTroca.Top   := LbTroca.Top - 10;
  Usuario.SelectAll;
  Usuario.SetFocus;
end;

procedure TFormAcesso.BtnCancelaNovaSenhaClick(Sender: TObject);
begin
  LbSenha.Caption := '&Senha:';
  LbNova.Visible := False;
  LbConfirma.Visible := False;
  NovaSenha.Visible := False;
  ConfirmaSenha.Visible := False;
  BtnCancelaNovaSenha.Visible := False;
  LbUsuario.Top := LbUsuario.Top + 10;
  Usuario.Top   := Usuario.Top + 10;
  LbSenha.Top   := LbSenha.Top + 10;
  Senha.Top     := Senha.Top + 10;
  LbTroca.Top   := LbTroca.Top + 10;
  Usuario.SelectAll;
  Usuario.SetFocus;
end;

procedure TFormAcesso.ConfirmaSenhaExit(Sender: TObject);
begin
  if (ActiveControl <> BtnCancela) and (ActiveControl <> Usuario) and
     (ActiveControl <> Senha) and (ActiveControl <> NovaSenha ) and
     (ActiveControl <> BtnCancelaNovaSenha) then
    BtnOkClick(Self);
end;

end.
