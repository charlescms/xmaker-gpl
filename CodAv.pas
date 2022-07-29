unit CodAv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, StdCtrls, Menus, IniFiles, ExtCtrls, Buttons, ToolWin,
  SynEdit, SynEditHighlighter, SynEditTypes, SynHighlighterPas, db, ShellApi;

type
  TFormCodAv = class(TForm)
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnGravar: TBitBtn;
    mwCodificacao: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadSettings;
    function FormatAttrib(Attrib : TSynHighLighterAttributes) : string;
    procedure ParseAttr(Value : string; Attrib : TSynHighLighterAttributes);
  public
    { Public declarations }
    Modificou: Boolean;
    Tipo: Integer;
  end;

var
  FormCodAv: TFormCodAv;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01, Abertura;

procedure TFormCodAv.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCodAv.LoadSettings;
var
  INI : TINIFile;
  I,J : integer;
  Attr,ArqIni: string;
begin
  {ArqIni  := DiretorioComBarra(DirWindows);
  Ini := TInifile.Create(ArqIni + 'XMAKER.INI');
  try
    for i := 0 to ComponentCount-1 do
      if Components[i] is TSynCustomHighLighter then
        with Components[i] as TSynCustomHighLighter do
          for J := 0 to AttrCount-1 do begin
             Attr := INI.ReadString( LanguageName, Attribute[J].Name,
               FormatAttrib( Attribute[J] ));
             ParseAttr( Attr, Attribute[J] );
          end;
  finally
    INI.Free;
  end;}
end;

function TFormCodAv.FormatAttrib(Attrib : TSynHighLighterAttributes) : string;
begin
  Result := IntToHex( Attrib.Background, 8 ) + ':' +
            IntToHex( Attrib.Foreground, 8 ) + ':';
  if (fsBold in Attrib.Style) then
    Result := Result + '1:'
  else
    Result := Result + '0:';

  if (fsItalic in Attrib.Style) then
    Result := Result + '1:'
  else
    Result := Result + '0:';

  if (fsUnderline in Attrib.Style) then
    Result := Result + '1:'
  else
    Result := Result + '0:';

  if (fsStrikeOut in Attrib.Style) then
    Result := Result + '1'
  else
    Result := Result + '0';
end;

procedure TFormCodAv.ParseAttr(Value : string; Attrib : TSynHighLighterAttributes);
var
  P : integer;
begin
  P := pos(':', Value );
  if P > 0 then
    Attrib.Background := strtointdef('$' + copy (Value, 1, P-1 ), clWindow);
  delete( Value, 1, P );

  P := pos(':', Value );
  if P > 0 then
    Attrib.Foreground := strtointdef('$' + copy (Value, 1, P-1 ), clWindowText);
  delete( Value, 1, P );

  Attrib.Style := [];
  P := pos(':', Value );
  if P > 0 then
    if (strtointdef('$' + copy (Value, 1, P-1 ), 0)>0) then
      Attrib.Style := Attrib.Style + [fsBold];
  delete( Value, 1, P );

  P := pos(':', Value );
  if P > 0 then
    if (strtointdef('$' + copy (Value, 1, P-1 ), 0)>0) then
      Attrib.Style := Attrib.Style + [fsItalic];
  delete( Value, 1, P );

  P := pos(':', Value );
  if P > 0 then
    if (strtointdef('$' + copy (Value, 1, P-1 ), 0)>0) then
      Attrib.Style := Attrib.Style + [fsUnderline];
  delete( Value, 1, P );

  P := pos(':', Value );
  if P > 0 then
    if (strtointdef('$' + copy (Value, 1, P-1 ), 0)>0) then
      Attrib.Style := Attrib.Style + [fsStrikeOut];
  delete( Value, 1, P );
end;

procedure TFormCodAv.FormShow(Sender: TObject);
begin
  LoadSettings;
  mwCodificacao.Lines.Clear;
  if Tipo = 0 then
    mwCodificacao.Lines.AddStrings(TabGlobal_i.DMENU.AVULSO.Conteudo)
  else
    mwCodificacao.Lines.AddStrings(TabGlobal_i.DMENUSUP.AVULSO.Conteudo);
  if mwCodificacao.Lines.Count = 0 then
  begin
    mwCodificacao.Lines.Add('// declaração de variáveis');
    mwCodificacao.Lines.Add('');
    mwCodificacao.Lines.Add('begin  // ínicio do bloco não remova esta linha');
    mwCodificacao.Lines.Add('  if not LiberaAcesso(Opcao) then  // usuário possui acesso ?');
    mwCodificacao.Lines.Add('    Abort;  // acesso negado, retorna ...');
    mwCodificacao.Lines.Add('  ');
    mwCodificacao.Lines.Add('end;   // final do bloco não remova esta linha');
    mwCodificacao.CaretY   := 06;
    mwCodificacao.CaretX   := 03;
    mwCodificacao.Modified := True;
  end;
  mwCodificacao.SetFocus;
end;

procedure TFormCodAv.BtnGravarClick(Sender: TObject);
begin
  if Tipo = 0 then
  begin
    TabGlobal_i.DMENU.AVULSO.Conteudo.Clear;
    TBlobField(TabGlobal_i.DMENU.FieldByName('AVULSO')).AsString := mwCodificacao.Lines.Text;
  end
  else
  begin
    TabGlobal_i.DMENUSUP.AVULSO.Conteudo.Clear;
    TBlobField(TabGlobal_i.DMENUSUP.FieldByName('AVULSO')).AsString := mwCodificacao.Lines.Text;
  end;
  mwCodificacao.Modified := False;
  Close;
end;

procedure TFormCodAv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if mwCodificacao.Modified then
    if Mensagem('Salvar Modificações ?',modConfirmacao,[modSim,modNao]) = mrYes then
    begin
      if Tipo = 0 then
      begin
        TabGlobal_i.DMENU.AVULSO.Conteudo.Clear;
        TBlobField(TabGlobal_i.DMENU.FieldByName('AVULSO')).AsString := mwCodificacao.Lines.Text;
      end
      else
      begin
        TabGlobal_i.DMENUSUP.AVULSO.Conteudo.Clear;
        TBlobField(TabGlobal_i.DMENUSUP.FieldByName('AVULSO')).AsString := mwCodificacao.Lines.Text;
      end;
    end;
end;

procedure TFormCodAv.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;
end;

end.
