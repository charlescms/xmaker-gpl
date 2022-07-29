unit ThCompila;

interface

uses
  Classes, Windows, Sysutils;

type
  TCompilacao = class(TThread)
  private
    { Private declarations }
    procedure Atualiza;
  protected
    procedure Execute; override;
  end;

implementation

uses Compila, Rotinas, Princ, Editor;

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TCompilacao.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TCompilacao }

procedure TCompilacao.Execute;
var
  I,T: Integer;
  Comando : String;
begin
  { Place thread code here }
  T:=0;
  while not (FormCompilar.Achou) and (T < 3) do
  begin
    if FormCompilar.Progresso.Position + 1 < 100000 then
      Synchronize(Atualiza)
    else
    begin
      FormCompilar.Progresso.Position := 0;
      Inc(T);
    end;
    if fileExists(Projeto.Pasta + 'Linker0.Txt') then
    begin
      FormCompilar.LbStatus.Caption := 'Verificando Erros de Compilação';
      FormCompilar.Refresh;
      FormCompilar.Achou := True;
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines.LoadFromFile(Projeto.Pasta + 'Linker.Txt');
      FormCompilar.LinhaError := '';
      for I := 0 to FormPrincipal.Texto.Lines.Count-1 do
      begin
        if FormCompilar.LinhaError = '' then
        begin
          if (Pos('Fatal',FormPrincipal.Texto.Lines[I]) > 0) or
             (Pos('Error',FormPrincipal.Texto.Lines[I]) > 0) then
            FormCompilar.LinhaError := Trim(FormPrincipal.Texto.Lines[I]);
        end;
      end;
    end;
  end;
  if (T >= 3) and (not FormCompilar.Achou) then
  begin
    FormCompilar.Achou := True;
    FormCompilar.LbStatus.Caption := 'Compilação Cancelada !!!';
    FormCompilar.Refresh;
    FormCompilar.TempoCompilacao.Enabled := False;
  end
  else
    if Trim(FormCompilar.LinhaError) = '' then
    begin
      FormCompilar.LbStatus.Caption := 'Executável Gerado com Sucesso !!!';
      FormCompilar.Refresh;
      if Projeto.Adapter then
        comando := Projeto.Pasta + 'Adapter.Exe'
      else
        comando := Projeto.Pasta + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-3) + 'Exe';
      FormCompilar.Progresso.Position := 100000;
      if FormCompilar.CheckExecutar.Checked then
        if fileExists(Comando) then
        begin
          if Projeto.Adapter then
            WinExec(Pchar(Comando), SW_NORMAL)  // SW_SHOW
          else
            WinExec(Pchar(Comando), SW_MAXIMIZE); // SW_SHOW
        end;
    end;
end;

procedure TCompilacao.Atualiza;
begin
  FormCompilar.Progresso.Position := FormCompilar.Progresso.Position + 1;
end;

end.
