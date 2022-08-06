{
   Programa.: Interno.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Interno;

interface

uses Classes, IniFiles, Dialogs, Forms, ComCtrls, SysUtils, WinTypes,
     Messages, Princ, Rotinas, Publicas, Calend, Acesso, Windows, Graphics,
     Controls, Senhas, Sobre, SelEmp, Agenda, Ambiente, Calculad, BatePapo,
     Backup, Restaura, LogOperacoes;

procedure Interno101;  { Configuração de Senhas }
procedure Interno102;  { Empresa Usuária }
procedure Interno103;  { Cópia de Segurança - Backup }
procedure Interno104;  { Restaura Cópia de Segurança - Backup }
procedure Interno105;  { Configura Impressora }
procedure Interno106;  { Outro Usuário }
procedure Interno107;  { Finalizar Sistema }
procedure Interno108;  { Calendário }
procedure Interno109;  { Calculadora }
procedure Interno110;  { Agenda }
procedure Interno111;  { Assistente }
procedure Interno112;  { Janelas em Forma Cascata }
procedure Interno113;  { Janelas em Forma Horizontal }
procedure Interno114;  { Janelas em Forma Vertical }
procedure Interno115;  { Janelas em Forma Minimizada }
procedure Interno116;  { Organiza ícones }
procedure Interno117;  { Conteúdo da Ajuda }
procedure Interno118;  { Tópicos da Ajuda }
procedure Interno119;  { Sobre... }
procedure Interno120;  { Ambiente }
procedure Interno121;  { Bate Papo }
procedure Interno122;  { Log de Operações }
function LiberaAcesso(Opcao: Integer; TAcesso: Integer = 0): Boolean; { Libera acesso ao Módulo }

implementation

procedure Interno101;  { Configuração de Senhas }
begin
  if Sistema.Master then
  begin
    FormSenhas := TFormSenhas.Create(Application);
    Try
      FormSenhas.ShowModal;
    Finally
      FormSenhas.Free;
    end;
  end
  else
    MessageDlg(Sistema.Usuario+', acesso negado !',mtInformation,[mbOk],0);
end;

procedure Interno102;  { Empresa Usuária }
begin
  if FormPrincipal.MDIChildCount > 0 then
    MessageDlg('Feche todas as Janelas para Acesso !', mtInformation, [mbOK], 0)
  else
  begin
    FormSelecionaEmpresa := TFormSelecionaEmpresa.Create(Application);
    Try
      FormSelecionaEmpresa.ShowModal;
    Finally
      FormSelecionaEmpresa.Free;
    end;
  end;
end;

procedure Interno103;  { Cópia de Segurança - Backup }
begin
  if FormPrincipal.MDIChildCount > 0 then
    MessageDlg('Feche todas as Janelas para Acesso !', mtInformation, [mbOK], 0)
  else
  begin
    FormBackup := TFormBackup.Create(Application);
    Try
      FormBackup.ShowModal;
    Finally
      FormBackup.Free;
    end;
  end;
end;

procedure Interno104;  { Restaura Cópia de Segurança - Backup }
begin
  if FormPrincipal.MDIChildCount > 0 then
    MessageDlg('Feche todas as Janelas para Acesso !', mtInformation, [mbOK], 0)
  else
  begin
    if Sistema.Master then
    begin
      FormRestaura := TFormRestaura.Create(Application);
      Try
        FormRestaura.ShowModal;
      Finally
        FormRestaura.Free;
      end;
    end
    else
      MessageDlg(Sistema.Usuario+', acesso negado !',mtInformation,[mbOk],0);
  end;
end;

procedure Interno105;  { Configura Impressora }
begin
  {Localiza dinamicamente o Componente de Configuração de impressora}
  FormPrincipal.SetupImpressora := (FormPrincipal.FindComponent('SetupImpressora') as TPrinterSetupDialog);
  if FormPrincipal.SetupImpressora <> nil then
    FormPrincipal.SetupImpressora.Execute;
end;

procedure Interno106;  { Outro Usuário }
begin
  FormAcesso := TFormAcesso.Create(Application);
  try
    FormAcesso.SenhaInicial := Sistema.SenhaInicial;
    FormAcesso.Tentativas   := 03;
    FormAcesso.QtdTentativas:= 01;
    FormAcesso.Liberacao    := False;
    { Vamos Pedir o Nome e Senha do Usuário }
    FormAcesso.ShowModal;
  finally
    FormAcesso.Free;
  end;
end;

procedure Interno107;  { Finalizar Sistema }
begin
  FormPrincipal.Close;
end;

procedure Interno108;  { Calendário }
begin
  if FormCalendario = Nil then
  begin
    FormCalendario := TFormCalendario.Create(Application);
    Try
      FormCalendario.ShowModal;
    Finally
      FormCalendario.Free;
    end;
  end;
end;

procedure Interno109;  { Calculadora }
begin
  if FormCalculadora = Nil then
  begin
    FormCalculadora := TFormCalculadora.Create(Application);
    Try
      FormCalculadora.ShowModal;
    Finally
      FormCalculadora.Free;
    end;
  end;
end;

procedure Interno110;  { Agenda }
begin
  if FormAgenda = Nil then
  begin
    FormAgenda := TFormAgenda.Create(Application);
    try
      FormAgenda.ShowModal;
    finally
      FormAgenda.Free;
    end;
  end;
end;

procedure Interno111;  { Assistente }
begin

end;

procedure Interno112;  { Janelas em Forma Cascata }
begin
  FormPrincipal.Cascade;
end;

procedure Interno113;  { Janelas em Forma Horizontal }
begin
  FormPrincipal.TileMode := tbHorizontal;
  FormPrincipal.Tile;
end;

procedure Interno114;  { Janelas em Forma Vertical }
begin
  FormPrincipal.TileMode := tbVertical;
  FormPrincipal.Tile;
end;

procedure Interno115;  { Janelas em Forma Minimizada }
var
  I: Integer;
begin
  for I := FormPrincipal.MDIChildCount - 1 downto 0 do
    FormPrincipal.MDIChildren[I].WindowState := wsMinimized;
end;

procedure Interno116;  { Organiza ícones }
begin
  FormPrincipal.ArrangeIcons;
end;

procedure Interno117;  { Conteúdo da Ajuda }
begin
  application.helpcommand(Help_Finder,0);
end;

procedure Interno118;  { Tópicos da Ajuda }
var
  PForm: array[0..22] of Char;
  hWnd: THandle;
begin
  StrPCopy(PForm, 'TFormPrincipal');
  hWnd := FindWindow(PForm, nil);
  WinHelp(hWnd, '', HELP_HELPONHELP, 0);
end;

procedure Interno119;  { Sobre... }
begin
  FormSobre := TFormSobre.Create(Application);
  Try
    FormSobre.ShowModal;
  Finally
    FormSobre.Free;
  end;
end;

procedure Interno120;  { Ambiente }
begin
  if Sistema.Master then
  begin
    FormAmbiente := TFormAmbiente.Create(Application);
    Try
      FormAmbiente.ShowModal;
    Finally
      FormAmbiente.Free;
    end;
  end
  else
    MessageDlg(Sistema.Usuario+', acesso negado !',mtInformation,[mbOk],0);
end;

procedure Interno121;  { Bate Papo }
begin
  ExecutaForm(TFormBatePapo,FormBatePapo);
end;

procedure Interno122;  { Log de Operações }
begin
  if Sistema.Master then
  begin
    FormLogOperacoes := TFormLogOperacoes.Create(Application);
    Try
      FormLogOperacoes.ShowModal;
    Finally
      FormLogOperacoes.Free;
    end;
  end
  else
    MessageDlg(Sistema.Usuario+', acesso negado !',mtInformation,[mbOk],0);
end;

function LiberaAcesso(Opcao: Integer; TAcesso: Integer = 0): Boolean; { Libera acesso ao Módulo }
var
  P: Integer;
begin
  Result := True;
  if (Sistema.ControleAcesso) and (not Sistema.Master) then
  begin
    case TAcesso of
      0: P := Sistema.OpcoesAcesso.IndexOf('S'+IntToStr(Opcao));
      1: P := Sistema.OpcoesAcessoMn.IndexOf('S'+IntToStr(Opcao));
      2: P := Sistema.OpcoesAcessoBr.IndexOf('S'+IntToStr(Opcao));
    end;
    if P <> -1 then
    begin
      FormAcesso := TFormAcesso.Create(Application);
      try
        FormAcesso.SenhaInicial := Sistema.SenhaInicial;
        FormAcesso.Tentativas   := 03;
        FormAcesso.QtdTentativas:= 01;
        FormAcesso.Liberacao    := True;
        { Vamos Pedir o Nome e Senha do Usuário Master }
        if FormAcesso.ShowModal <> mrOk then
          Result := False;
      finally
        FormAcesso.Free;
      end;
    end;
  end;
end;

end.
