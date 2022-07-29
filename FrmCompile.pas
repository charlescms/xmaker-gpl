unit FrmCompile;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, Dialogs;

type
  TCompileLineType = (clText, clFileProgress, clHint, clWarning, clError, clFatal);

  ICompileMessages = interface
    ['{C932390B-8DB6-4CAE-89D0-7BAB8A2E640B}']
    procedure Clear;

    procedure AddHint(const Text: string);
    procedure AddWarning(const Text: string);
    procedure AddError(const Text: string);
    procedure AddFatal(const Text: string);
    procedure AddText(const Msg: string);

      { Text is the line that the compiler outputs. The ICompileMessages
        implementor must parse the line itself. }
  end;

  TFormCompile = class(TForm)
    PanelClient: TPanel;
    BtnOk: TButton;
    BevelProject: TBevel;
    BevelStatus: TBevel;
    BevelCurrentLine: TBevel;
    BevelHints: TBevel;
    LblProject: TLabel;
    LblStatusCaption: TLabel;
    BevelTotalLines: TBevel;
    LblCurrentLineCaption: TLabel;
    LblCurrentLine: TLabel;
    LblTotalLinesCaption: TLabel;
    LblTotalLines: TLabel;
    BevelWarnings: TBevel;
    BevelErrors: TBevel;
    LblHintsCaption: TLabel;
    LblHints: TLabel;
    LblWarningsCaption: TLabel;
    LblWarnings: TLabel;
    LblErrorsCaption: TLabel;
    LblErrors: TLabel;
    LblProjectCaption: TLabel;
    LblStatus: TLabel;
    LblErrorReason: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FHints: Cardinal;
    FWarnings: Cardinal;
    FErrors: Cardinal;
    FCurrentLine: Cardinal;
    FTotalLines: Cardinal;
    FCurFilename: string;
    FCompileMessages: ICompileMessages;
    FAutoClearCompileMessages: Boolean;
    procedure SetCurrentLine(Line: Cardinal);
    function IsCompileFileLine(const Line: string): Boolean;
  public
    FProject: String;
    FRetorno: TStringList;
    procedure Init(const ProjectName: string; Clear: Boolean = True);
    procedure Compiling(const Filename: string);
    procedure Linking(const Filename: string);
    procedure Done(const ErrorReason: string = ''; BtOk: Boolean = True);

    procedure HandleBuffer(const Buffer: string);
    function HandleLine(const Line: string): TCompileLineType;

    procedure IncHint;
    procedure IncWarning;
    procedure IncError;

    property Hints: Cardinal read FHints;
    property Warnings: Cardinal read FWarnings;
    property Errors: Cardinal read FErrors;
    property CurrentLine: Cardinal read FCurrentLine write SetCurrentLine;

    property AutoClearCompileMessages: Boolean read FAutoClearCompileMessages write FAutoClearCompileMessages default False;
    property CompileMessages: ICompileMessages read FCompileMessages write FCompileMessages;
  end;

var
  FormCompile: TFormCompile;

implementation

uses
  FileCtrl, Rotinas, Princ;

{$R *.dfm}

resourcestring
  RsPreparing = 'Preparando...';
  RsCompiling = 'Compilando';
  RsLinking = 'Linkando';
  RsDone = 'Pronto';
  RsThereAreErrors = 'Há erros.';
  RsThereAreWarnings = 'Há advertências.';
  RsThereAreHints = 'Há sugestões.';
  RsCompiled = 'Executável Gerado com Sucesso.';
  RsNotExe = 'Há erros! Executável não Gerado.';

{ TFormCompile }

procedure TFormCompile.BtnOkClick(Sender: TObject);
begin
  //if BtnOk.Caption = 'Cancelar' then
  //  FormPrincipal.PCompilar.Terminate;
  Tag := 1;
  Hide;
end;

procedure TFormCompile.HandleBuffer(const Buffer: string);
var
  line: String;
  I: Integer;
begin
  Line := '';
  for I:=1 to Length(Buffer) do
    if Buffer[I] = #13 then
    begin
      HandleLine(Line);
      Line := '';
    end
    else
    begin
      if Buffer[I] <> #10 then
        Line := Line + Buffer[I];
    end;
  HandleLine(Line);
end;

function TFormCompile.HandleLine(const Line: string): TCompileLineType;

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

begin
  Result := clText;
  if Line = '' then
    Exit;

  FRetorno.Add(Line);
  if IsCompileFileLine(Line) then
    Result := clFileProgress
  else
  if HasText(Line, ['hint: ', 'hinweis: ', 'suggestion: ']) then // do not localize
  begin
    Result := clHint;
    IncHint;
    if Assigned(FCompileMessages) then
      FCompileMessages.AddHint(Line);
  end
  else if HasText(Line, ['warning: ', 'warnung: ', 'avertissement: ']) then // do not localize
  begin
    Result := clWarning;
    IncWarning;
    if Assigned(FCompileMessages) then
      FCompileMessages.AddWarning(Line);
  end
  else if HasText(Line, ['error: ', 'fehler: ', 'erreur: ']) then // do not localize
  begin
    Result := clError;
    IncError;
    if Assigned(FCompileMessages) then
      FCompileMessages.AddError(Line);
  end
  else if HasText(Line, ['fatal: ']) then // do not localize
  begin
    Result := clFatal;
    IncError;
    if Assigned(FCompileMessages) then
      FCompileMessages.AddFatal(Line);
  end;

  if Pos('.dpr(', LowerCase(Line)) > 0 then
    Linking(FProject);
end;

function TFormCompile.IsCompileFileLine(const Line: string): Boolean;

  function PosLast(Ch: Char; const S: string): Integer;
  begin
    for Result := Length(S) downto 1 do
      if S[Result] = Ch then
        Exit;
    Result := 0;
  end;

var
  ps, psEnd, LineNum, Err: Integer;
  Filename: string;
begin
  Result := False;
  ps := PosLast('(', Line);
  if (ps > 0) and (Pos(': ', Line) = 0) and (Pos('.', Line) > 0) then
  begin
    psEnd := PosLast(')', Line);
    if psEnd < ps then
      Exit;

    Filename := Copy(Line, 1, ps - 1);
    if (Filename <> '') and (Filename[Length(Filename)] > #32) then
    begin
      Val(Copy(Line, ps + 1, psEnd - ps - 1), LineNum, Err);
      if Err = 0 then
      begin
        Compiling(Filename);
        CurrentLine := LineNum;
        Result := True;
      end;
    end;
  end;
end;


procedure TFormCompile.Init(const ProjectName: string; Clear: Boolean);
begin
  Tag := 0;
  FProject := ProjectName;
  LblProject.Caption := MinimizeName(ProjectName, LblProject.Canvas, LblProject.ClientWidth);

  LblStatusCaption.Font.Style := [];
  LblStatus.Font.Style := [];

  if Clear then
  begin
    if Assigned(FCompileMessages) and AutoClearCompileMessages then
      FCompileMessages.Clear;
    FHints := 0;
    FErrors := 0;
    FWarnings := 0;
    FTotalLines := 0;
  end;
  FCurrentLine := 0;
  FCurFilename := '';

  LblErrorReason.Caption := '';
  LblStatus.Font.Color := clWindowText;
  LblHints.Caption := IntToStr(FHints);
  LblWarnings.Caption := IntToStr(FWarnings);
  LblErrors.Caption := IntToStr(FErrors);
  LblCurrentLine.Caption := IntToStr(FCurrentLine);
  LblTotalLines.Caption := IntToStr(FTotalLines);
  LblStatusCaption.Caption := RsPreparing;
  LblStatus.Caption := '';
  FRetorno.Clear;

  //BtnOk.Caption := 'Cancelar';
  //BtnOk.Enabled := False;
  Show;
end;

procedure TFormCompile.Compiling(const Filename: string);
begin
  if Filename <> FCurFilename then
  begin
    FCurFilename := Filename;
    FTotalLines := FTotalLines + FCurrentLine;
    CurrentLine := 0; // updates total lines and current lines
    LblStatusCaption.Font.Style := [];
    LblStatus.Font.Style := [];
    LblStatusCaption.Caption := RsCompiling + ':';
    LblStatus.Caption := ExtractFileName(Filename);
    Application.ProcessMessages;
  end;
end;

procedure TFormCompile.Linking(const Filename: string);
begin
  FTotalLines := FTotalLines + FCurrentLine;
  CurrentLine := 0;

  LblStatusCaption.Font.Style := [];
  LblStatus.Font.Style := [];
  LblStatusCaption.Caption := RsLinking + ':';
  LblStatus.Caption := ExtractFileName(Filename);
  Application.ProcessMessages;
end;

procedure TFormCompile.Done(const ErrorReason: string = ''; BtOk: Boolean = True);
var
  Executavel: String;
begin
  BtnOk.Enabled := True;
  FCurFilename := '';
  FTotalLines := FTotalLines + FCurrentLine;
  CurrentLine := 0;

  LblErrorReason.Caption := ErrorReason;
  LblErrorReason.Hint    := ErrorReason;
  LblErrorReason.Visible := ErrorReason <> '';
  LblStatusCaption.Font.Style := [fsBold];
  LblStatus.Font.Style := [fsBold];
  LblStatusCaption.Caption := RsDone + ':';

  if Projeto.Adapter then
    Executavel := Projeto.Pasta + 'Adapter.Exe'
  else
    Executavel := Projeto.Pasta + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-3) + 'Exe';
  if fileExists(Executavel) then
  begin
    if FErrors > 0 then
    begin
      LblStatus.Caption := RsThereAreErrors;
      LblStatus.Font.Color := ClRed;
    end
    else if FWarnings > 0 then
      LblStatus.Caption := RsCompiled //RsThereAreWarnings
    else if FHints > 0 then
      LblStatus.Caption := RsCompiled //RsThereAreHints
    else
      LblStatus.Caption := RsCompiled;
  end
  else
  begin
    LblStatus.Caption := RsNotExe;
    LblStatus.Font.Color := ClRed;
    if Trim(LblErrorReason.Caption) = '' then
    begin
      LblErrorReason.Caption := 'Não foi possível identificar a origem do erro, compile novamente!';
      LblErrorReason.Hint    := 'Não foi possível identificar a origem do erro, compile novamente!';
      LblErrorReason.Visible := True;
    end;
  end;
  //BtnOk.Caption := 'Ok';
  //BtnOk.Enabled := BtOk;
  //BtnOk.Enabled := ErrorReason <> '';
  //if ErrorReason <> '' then
  //begin
  //  Hide;
  //  ShowModal;
  //end;
end;

procedure TFormCompile.IncError;
begin
  Inc(FErrors);
  LblErrors.Caption := IntToStr(FErrors);
  Application.ProcessMessages;
end;

procedure TFormCompile.IncHint;
begin
  Inc(FHints);
  LblHints.Caption := IntToStr(FHints);
  Application.ProcessMessages;
end;

procedure TFormCompile.IncWarning;
begin
  Inc(FWarnings);
  LblWarnings.Caption := IntToStr(FWarnings);
  Application.ProcessMessages;
end;

procedure TFormCompile.SetCurrentLine(Line: Cardinal);
begin
  FCurrentLine := Line;
  LblCurrentLine.Caption := IntToStr(Line);
  LblTotalLines.Caption := IntToStr(FTotalLines + FCurrentLine);
  Application.ProcessMessages;
end;

procedure TFormCompile.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := Tag = 1;
end;

procedure TFormCompile.FormCreate(Sender: TObject);
begin
  FRetorno := TStringList.Create;
end;

procedure TFormCompile.FormDestroy(Sender: TObject);
begin
  FRetorno.Free;
end;

end.
