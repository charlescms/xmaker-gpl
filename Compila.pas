unit Compila;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Gauges, XBanner, ShellApi;

type
  TFormCompilar = class(TForm)
    XBanner: TXBanner;
    Panel2: TPanel;
    Bevel1: TBevel;
    CheckTodos: TCheckBox;
    CheckExecutar: TCheckBox;
    BtnCompilar: TBitBtn;
    BtnExecutar: TBitBtn;
    BtnAdapter: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCompilarClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAdapterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Achou: Boolean;
    LinhaError: String;
    CodErro: Integer;
  end;

var
  FormCompilar: TFormCompilar;

implementation

{$R *.DFM}

uses Rotinas, Gera_01, Princ, FrmCompile, Abertura, FDesigner;

  function HasText(Text: string; const Values: array of string): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    Text := AnsiLowerCase(Text);
    for i := 0 to High(Values) do
      if Pos(Values[i], Text) > 0 then
        Exit;
    Result := False;
  end;

  procedure Analisa_Log(Comando: String);
  var
    FLog: TStringList;
    I: Integer;
    Pos1, Pos2, LhError: Integer;
    ArqErro, Conj_Erro: String;
  begin
    if not FileExists(Projeto.Pasta + 'compiler.log') then
      exit;
    try
      FLog := TStringList.Create;
      FLog.LoadFromFile(Projeto.Pasta + 'compiler.log');
      for I:=0 to FLog.Count-1 do
      begin
        if Pos('(', FLog[I]) > 0 then
          Conj_Erro := FLog[I];
        if Pos(')', FLog[I]) > 0 then
          if Conj_Erro <> FLog[I] then
            Conj_Erro := Conj_Erro + FLog[I];
        if HasText(FLog[I], ['fatal: ', 'error: ', 'fehler: ', 'erreur: ', 'error]', 'fatal]', 'fatal ', 'erreur]', 'fehler]', 'fehler ']) then
        begin
          FormCompilar.LinhaError := Trim(Conj_Erro);
          ArqErro := Copy(FormCompilar.LinhaError,01,Pos('(',FormCompilar.LinhaError)-1);
          Pos1 := Pos('(',FormCompilar.LinhaError)+1;
          Pos2 := Pos(')',FormCompilar.LinhaError);
          LhError := StrToIntDef(Copy(FormCompilar.LinhaError,Pos1,Pos2-Pos1),1);
        end;
        if Trim(FormCompilar.LinhaError) <> '' then
        begin
          if FLog[I] <> FormCompilar.LinhaError then
            FormCompilar.LinhaError := FLog[I] + ' ' + FormCompilar.LinhaError;
          if I+1 <= FLog.Count-1 then
            FormCompilar.LinhaError := FormCompilar.LinhaError + ' ' + FLog[I+1];
          if FileExists(Projeto.Pasta + ArqErro) then
            if Pos('.pas', LowerCase(ArqErro)) > 0 then
              begin
                if FormDesigner_Net = Nil then
                  ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
                FormDesigner_Net.AbreForm(Copy(ArqErro, 01, Pos('.', ArqErro)-1), 5, True, LhError, FormCompilar.LinhaError);
                FormCompilar.Close;
              end;
          Break;
        end;
      end;
      FLog.Insert(0, Comando);
      FLog.SaveToFile(Projeto.Pasta + 'compiler.log');
      FLog.Clear;
      if FormCompilar.CodErro = 0 then
        if FormCompilar.CheckExecutar.Checked then
        begin
          FormCompile.Close;
          FormCompilar.Close;
          FormCompilar.BtnExecutarClick(FormCompilar);
        end;
    finally
      FLog.Free;
    end;
  end;

  procedure Analisa_Retorno(Comando: String);
  var
    I: Integer;
    Pos1, Pos2, LhError: Integer;
    ArqErro, Conj_Erro: String;
  begin
    for I:=0 to FormCompile.FRetorno.Count-1 do
    begin
      if Pos('(', FormCompile.FRetorno[I]) > 0 then
        Conj_Erro := FormCompile.FRetorno[I];
      if Pos(')', FormCompile.FRetorno[I]) > 0 then
        if Conj_Erro <> FormCompile.FRetorno[I] then
          Conj_Erro := Conj_Erro + FormCompile.FRetorno[I];
      if HasText(FormCompile.FRetorno[I], ['fatal: ', 'error: ', 'fehler: ', 'erreur: ']) then
      begin
        FormCompilar.LinhaError := Trim(Conj_Erro);
        ArqErro := Copy(FormCompilar.LinhaError,01,Pos('(',FormCompilar.LinhaError)-1);
        Pos1 := Pos('(',FormCompilar.LinhaError)+1;
        Pos2 := Pos(')',FormCompilar.LinhaError);
        LhError := StrToIntDef(Copy(FormCompilar.LinhaError,Pos1,Pos2-Pos1),1);
      end;
      if Trim(FormCompilar.LinhaError) <> '' then
      begin
        if FormCompile.FRetorno[I] <> FormCompilar.LinhaError then
          FormCompilar.LinhaError := FormCompile.FRetorno[I] + ' ' + FormCompilar.LinhaError;
        if I+1 <= FormCompile.FRetorno.Count-1 then
          FormCompilar.LinhaError := FormCompilar.LinhaError + ' ' + FormCompile.FRetorno[I+1];
        if FileExists(Projeto.Pasta + ArqErro) then
          if Pos('.pas', LowerCase(ArqErro)) > 0 then
            begin
              if FormDesigner_Net = Nil then
                ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
              FormDesigner_Net.AbreForm(Copy(ArqErro, 01, Pos('.', ArqErro)-1), 5, True, LhError, FormCompilar.LinhaError);
              FormCompilar.Close;
            end;
        Break;
      end;
    end;
    FormCompile.FRetorno.Insert(0, Comando);
    FormCompile.FRetorno.SaveToFile(Projeto.Pasta + 'compiler.log');
    FormCompile.FRetorno.Clear;
    if FormCompilar.CodErro = 0 then
      if FormCompilar.CheckExecutar.Checked then
      begin
        FormCompile.Close;
        FormCompilar.Close;
        FormCompilar.BtnExecutarClick(FormCompilar);
      end;
  end;


procedure TFormCompilar.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCompilar.BtnCompilarClick(Sender: TObject);
var
  Comando : String;
  Executavel: String;
  FRetorno, versao_d: String;
begin
  if C_CRACK then
  begin
    Mensagem(MSG_CRACK,ModErro,[ModOk]);
    exit;
  end;
  if not Achou then
    exit;
  Projeto.Adapter := False;
  FormCompilar.Refresh;
  if not FileExists(Projeto.Compilador) then
  begin
    case TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo of
      1: versao_d := '5.0';
      2: versao_d := '6.0';
      3: versao_d := '7.0';
      4: versao_d := '2005';
      5: versao_d := '2006';
      6: versao_d := 'Turbo Delphi 2006';
    end;
    Mensagem('Compilador não Encontrado !' + ^M +^M + 'O projeto está configurado para utilizar o Delphi '+Versao_d + ^M + 'Altere em Assistente -> Propriedades ou Configuração -> Delphi',ModAdvertencia,[ModOk]);
    exit;
  end;
  if not FileExists(Projeto.ArquivoProj) then
  begin
    Mensagem(Projeto.ArquivoProj + ^M + 'não Encontrado !',ModAdvertencia,[ModOk]);
    exit;
  end;
  Executavel := Projeto.Pasta + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-3) + 'Exe';
  if fileExists(Executavel) then
    DeleteFile(Executavel);
  BtnExecutar.SetFocus;
  LinhaError := '';
  CodErro := 0;
  FormCompile.Init(Projeto.ArquivoProj, True);
  FormCompile.Show;
  if TabGlobal_i.DPROJETO.Linguagem.Conteudo = 6 then  // Turbo Delphi 2006
  begin
    if FileExists(Projeto.Pasta + 'compiler.log') then
      DeleteFile(Projeto.Pasta + 'compiler.log');
    Comando := '"'+Projeto.Compilador + '" ' + Projeto.Parametro + ' -o' + Projeto.Pasta + 'compiler.log' + ' ' + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-4);
    CodErro := GetDosOutput(Pchar(Comando), Projeto.Pasta, SW_HIDE, FRetorno, True);
    Analisa_Log(Comando);
  end
  else
  begin
    if CheckTodos.Checked then
      Comando := '"'+Projeto.Compilador + '" ' + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-4)+ ' -B '+Projeto.Parametro
    else
      Comando := '"'+Projeto.Compilador + '" ' + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-4)+ ' '+Projeto.Parametro;
    Application.ProcessMessages;
    CodErro := GetDosOutput(Pchar(Comando), Projeto.Pasta, SW_HIDE, FRetorno, True);
    Analisa_Retorno(Comando);
  end;
  FormCompile.Done(LinhaError, not FormCompilar.CheckExecutar.Checked);
end;

procedure TFormCompilar.BtnExecutarClick(Sender: TObject);
begin
  if not Achou then
    exit;
  FormPrincipal.BtnExecutarClick(Self);
end;

procedure TFormCompilar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormCompilar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not Achou then
    Action := caNone;
  Projeto.Adapter := False;
  FormPrincipal.Texto.Lines.Clear;
  if Assigned(FormCompile) then
    FormCompile.Free;
end;

procedure TFormCompilar.BtnAdapterClick(Sender: TObject);
var
  Comando: String;
  Executavel: String;
  Versao_d: String;
  FRetorno: String;
begin
  if C_CRACK then
  begin
    Mensagem(MSG_CRACK,ModErro,[ModOk]);
    exit;
  end;
  if not Achou then
    exit;
  CheckTodos.Checked := True;  
  Projeto.Adapter := True;
  if not FileExists(Projeto.Compilador) then
  begin
    case TabGlobal_i.DPROJETO.LINGUAGEM.Conteudo of
      1: versao_d := '5.0';
      2: versao_d := '6.0';
      3: versao_d := '7.0';
      4: versao_d := '2005';
      5: versao_d := '2006';
      6: versao_d := 'Turbo Delphi 2006';
    end;
    Mensagem('Compilador não Encontrado !' + ^M +^M + 'O projeto está configurado para utilizar o Delphi '+Versao_d + ^M + 'Altere em Assistente -> Propriedades ou Configuração -> Delphi',ModAdvertencia,[ModOk]);
    exit;
  end;
  if not FileExists(Projeto.Pasta + 'Adapter.dpr') then
  begin
    Mensagem(Projeto.Pasta + 'Adapter.dpr' + ^M + 'não Encontrado !',ModAdvertencia,[ModOk]);
    exit;
  end;
  Executavel := Projeto.Pasta + 'Adapter.Exe';
  if fileExists(Executavel) then
    DeleteFile(Executavel);
  BtnExecutar.SetFocus;
  LinhaError := '';
  CodErro := 0;
  FormCompile.Init(Projeto.Pasta + 'Adapter.dpr', True);
  FormCompile.Show;
  Application.ProcessMessages;
  if CheckTodos.Checked then
    Comando := '"'+Projeto.Compilador + '" ' + 'Adapter' + ' -B '+Projeto.Parametro
  else
    Comando := '"'+Projeto.Compilador + '" ' + 'Adapter' + ' '+Projeto.Parametro;
  CodErro := GetDosOutput(Pchar(Comando), Projeto.Pasta, SW_HIDE, FRetorno, True);
  Analisa_Retorno(Comando);
  FormCompile.Done(LinhaError, not FormCompilar.CheckExecutar.Checked);
end;

procedure TFormCompilar.FormShow(Sender: TObject);
begin
  Achou := True;
  Projeto.Adapter := False;
  BtnCompilar.SetFocus;
end;

procedure TFormCompilar.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

procedure TFormCompilar.FormCreate(Sender: TObject);
begin
  FormCompile := TFormCompile.Create(Self);
  FormCompile.Hide;
end;

end.
