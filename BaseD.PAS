{
 Comunicação com a Base de Dados e Tabelas em InterBase
}
unit BaseD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBQuery, IBDatabase, Db, IBCustomDataSet, IBTable, IniFiles, Provider,
  DBClient, FileCtrl, SynHighlighterSQL, SynHighlighterCAC,
  SynHighlighterCpp, SynHighlighterDfm, SynEditHighlighter,
  SynHighlighterPas, stdctrls, SynEdit, SynEditAutoComplete,
  SynHighlighterFoxpro, SynHighlighterInno, SynHighlighterHtml,
  SynHighlighterXML, SynHighlighterJScript, SynHighlighterPHP,
  SynHighlighterJava, SynHighlighterIni, SynHighlighterVB,
  SynHighlighterBat, SynExportRTF, SynEditExport, SynExportHTML,
  SynHighlighterCss, SynHighlighterVBScript;

type
  TBaseDados = class(TDataModule)
    {10-Início do Bloco Modular. Modificações não serão preservadas}
    BD_Base_Projeto: TIBDataBase;
    TRS_BD_Base_Projeto: TIBTransaction;
    BD_Base_Dicionario: TIBDataBase;
    TRS_BD_Base_Dicionario: TIBTransaction;
    SynPasSyn1: TSynPasSyn;
    SynDfmSyn1: TSynDfmSyn;
    SynCppSyn1: TSynCppSyn;
    SynCACSyn1: TSynCACSyn;
    SynSQLSyn1: TSynSQLSyn;
    SynVBScriptSyn1: TSynVBScriptSyn;
    SynCssSyn1: TSynCssSyn;
    SynExporterHTML1: TSynExporterHTML;
    SynExporterRTF1: TSynExporterRTF;
    SynBatSyn1: TSynBatSyn;
    SynVBSyn1: TSynVBSyn;
    SynIniSyn1: TSynIniSyn;
    SynJavaSyn1: TSynJavaSyn;
    SynPHPSyn1: TSynPHPSyn;
    SynJScriptSyn1: TSynJScriptSyn;
    SynXMLSyn1: TSynXMLSyn;
    SynHTMLSyn1: TSynHTMLSyn;
    SynInnoSyn1: TSynInnoSyn;
    SynFoxproSyn1: TSynFoxproSyn;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ListaBaseDados : TStringList;
    ListaBaseDadosArq: TStringList;
    ListaNomeTabelas: TStringList;
    procedure ConectaBase(Arquivo: String; Numero: Integer);
    procedure FechaBase;
    function AplicarAtualizacao(DataSet: TDataSet; Apply: Boolean): Boolean;
    procedure Atribui_Instrucao(Editor: TSynEdit; S: String);
    procedure GetHighlighters(AOwner: TComponent; AHighlighters: TStringList;
       AppendToList: boolean);
    function GetHighlightersFilter(AHighlighters: TStringList): string;
    function GetHighlighterFromFileExt(AHighlighters: TStringList;
      Extension: string): TSynCustomHighlighter;
  end;

var
  BaseDados: TBaseDados;

implementation

{$R *.DFM}

uses Rotinas, Princ;

procedure TBaseDados.DataModuleCreate(Sender: TObject);
begin
  ListaBaseDados    := TStringList.Create;
  ListaBaseDadosArq := TStringList.Create;
  ListaNomeTabelas  := TStringList.Create;
  BD_Base_Projeto.LoginPrompt := False;

  ListaBaseDadosArq.Add('');
  ListaBaseDadosArq.Add('');

  ListaBaseDados.Add('BD_Base_Projeto');
  ListaBaseDados.Add('BD_Base_Dicionario');
  ListaNomeTabelas.Add('DPROJETO');
  ListaNomeTabelas.Add('DFORMULARIO');
  ListaNomeTabelas.Add('DMENU');
  ListaNomeTabelas.Add('DBDADOS');
  ListaNomeTabelas.Add('DTABELAS');
  ListaNomeTabelas.Add('DCAMPOST');
  ListaNomeTabelas.Add('DINDICEST');
  ListaNomeTabelas.Add('DCALCULADOS');
  ListaNomeTabelas.Add('DCASCATAT');
  ListaNomeTabelas.Add('DRESTRITAT');
  ListaNomeTabelas.Add('DRELATORIO');
  ListaNomeTabelas.Add('DRELACIONA');
end;

procedure TBaseDados.ConectaBase(Arquivo: String; Numero: Integer);
begin
  if Numero = 0 then
  begin
    if Trim(Projeto.Servidor_Pro) <> '' then
    begin
      if Trim(Projeto.Pasta_projeto) <> '' then
        Arquivo := Trim(Projeto.Servidor_Pro) + ':' + Trim(Projeto.Pasta_projeto) + 'Projeto.Pro'
      else
        Arquivo := Trim(Projeto.Servidor_Pro) + ':' + Arquivo;
    end;
    BaseDados.BD_Base_Projeto.LoginPrompt := False;
    BaseDados.BD_Base_Projeto.DataBaseName := Arquivo;
    if DirectoryExists(ExtractFilePath(Arquivo)) then
      if not FileExists(Arquivo) then
      begin
        BaseDados.BD_Base_Projeto.Params.Clear;
        BaseDados.BD_Base_Projeto.Params.Add('USER '+#39+Projeto.usr_firebird+#39);  // 'SYSDBA'
        BaseDados.BD_Base_Projeto.Params.Add('PASSWORD '+#39+Projeto.pwd_firebird+#39); // 'masterkey'
        BaseDados.BD_Base_Projeto.CreateDatabase;
        BaseDados.BD_Base_Projeto.Close;
      end;
    BaseDados.BD_Base_Projeto.Params.Clear;
    BaseDados.BD_Base_Projeto.Params.Add('USER_NAME='+Projeto.usr_firebird);     // SYSDBA
    BaseDados.BD_Base_Projeto.Params.Add('PASSWORD='+Projeto.pwd_firebird);   // masterkey
    BaseDados.BD_Base_Projeto.Open;
    BaseDados.TRS_BD_Base_Projeto.StartTransaction;
  end
  else if Numero = 1 then
  begin
    if Trim(Projeto.Servidor_Dic) <> '' then
      Arquivo := Trim(Projeto.Servidor_Dic) + ':' + Arquivo;
    BaseDados.BD_Base_Dicionario.LoginPrompt := False;
    BaseDados.BD_Base_Dicionario.DataBaseName := Arquivo;
    if DirectoryExists(ExtractFilePath(Arquivo)) then
      if not FileExists(Arquivo) then
      begin
        BaseDados.BD_Base_Dicionario.Params.Clear;
        BaseDados.BD_Base_Dicionario.Params.Add('USER '+#39+Projeto.usr_firebird+#39);
        BaseDados.BD_Base_Dicionario.Params.Add('PASSWORD '+#39+Projeto.pwd_firebird+#39);
        BaseDados.BD_Base_Dicionario.CreateDatabase;
        BaseDados.BD_Base_Dicionario.Close;
      end;
    BaseDados.BD_Base_Dicionario.Params.Clear;
    BaseDados.BD_Base_Dicionario.Params.Add('USER_NAME='+Projeto.usr_firebird);
    BaseDados.BD_Base_Dicionario.Params.Add('PASSWORD='+Projeto.pwd_firebird);
    BaseDados.BD_Base_Dicionario.Open;
    BaseDados.TRS_BD_Base_Dicionario.StartTransaction;
  end;
end;

procedure TBaseDados.FechaBase;
Var
  I: Integer;
begin
  for I := 0 to BaseDados.ListaBaseDados.Count-1 do
    TIBDataBase(BaseDados.FindComponent(BaseDados.ListaBaseDados[I])).Close;
end;

procedure TBaseDados.DataModuleDestroy(Sender: TObject);
begin
  ListaBaseDados.Free;
  ListaBaseDadosArq.Free;
  ListaNomeTabelas.Free;
end;

function TBaseDados.AplicarAtualizacao(DataSet: TDataSet; Apply: Boolean): Boolean;
begin
  Result := True;
  with TIBCustomDataSet(DataSet) do
  begin
    if (State in dsEditModes) or UpdatesPending then
    begin
      if Apply then
      begin
        Database.ApplyUpdates([DataSet as TIBCustomDataSet]);
        Transaction.CommitRetaining;
       { Always call CancelUpdates to remove any discard changes }
        CancelUpdates;
      end
      else
        CancelUpdates;
    end;
  end;
end;

procedure TBaseDados.Atribui_Instrucao(Editor: TSynEdit; S: String);
var
  SynAutoComplete1: TSynAutoComplete;
begin
   SynAutoComplete1 := TSynAutoComplete.Create(Self);
   try
     if FileExists(Projeto.PastaGerador + 'Instrucoes.Lst') then
       SynAutoComplete1.AutoCompleteList.LoadFromFile(Projeto.PastaGerador + 'Instrucoes.Lst');
     SynAutoComplete1.Editor := Editor;
     SynAutoComplete1.ExecuteCompletion(S,Editor);
   Finally
     SynAutoComplete1.Free;
   end;
end;

procedure TBaseDados.GetHighlighters(AOwner: TComponent; AHighlighters: TStringList;
  AppendToList: boolean);
var
  i: integer;
  Highlighter: TSynCustomHighlighter;
begin
  if Assigned(AOwner) and Assigned(AHighlighters) then begin
    if not AppendToList then
      AHighlighters.Clear;
    for i := AOwner.ComponentCount - 1 downto 0 do begin
      if not (AOwner.Components[i] is TSynCustomHighlighter) then
        continue;
      Highlighter := AOwner.Components[i] as TSynCustomHighlighter;
      // only one highlighter for each language
      if AHighlighters.IndexOf(Highlighter.GetLanguageName) = -1 then
        AHighlighters.AddObject(Highlighter.GetLanguageName, Highlighter);
    end;
    AHighlighters.Sort;
  end;
end;

function TBaseDados.GetHighlightersFilter(AHighlighters: TStringList): string;
var
  i: integer;
  Highlighter: TSynCustomHighlighter;
begin
  Result := '';
  if Assigned(AHighlighters) then
    for i := 0 to AHighlighters.Count - 1 do begin
      if not (AHighlighters.Objects[i] is TSynCustomHighlighter) then
        continue;
      Highlighter := TSynCustomHighlighter(AHighlighters.Objects[i]);
      if Highlighter.DefaultFilter = '' then
        continue;
      Result := Result + Highlighter.DefaultFilter;
      if Result[Length(Result)] <> '|' then
        Result := Result + '|';
    end;
end;

function TBaseDados.GetHighlighterFromFileExt(AHighlighters: TStringList;
  Extension: string): TSynCustomHighlighter;
var
  ExtLen: integer;
  i, j: integer;
  Highlighter: TSynCustomHighlighter;
  Filter: string;
begin
  Extension := LowerCase(Extension);
  ExtLen := Length(Extension);
  if Assigned(AHighlighters) and (ExtLen > 0) then begin
    for i := 0 to AHighlighters.Count - 1 do begin
      if not (AHighlighters.Objects[i] is TSynCustomHighlighter) then
        continue;
      Highlighter := TSynCustomHighlighter(AHighlighters.Objects[i]);
      Filter := LowerCase(Highlighter.DefaultFilter);
      j := Pos('|', Filter);
      if j > 0 then begin
        Delete(Filter, 1, j);
        j := Pos(Extension, Filter);
        if (j > 0) and
           ((j + ExtLen > Length(Filter)) or (Filter[j + ExtLen] = ';'))
        then begin
          Result := Highlighter;
          exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

end.
