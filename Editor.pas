unit Editor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Tabnotbk, Menus, IniFiles, SynEdit,
  SynEditHighlighter, SynEditTypes, Extras, BaseD;

type
  TMyMwCustomEdit = class(TSynEdit)
  public
    Filename : string;
  end;

  TFormEditor = class(TForm)
    StatusBar: TStatusBar;
    PageEditor: TPageControl;
    PopMenu: TPopupMenu;
    PopFechar: TMenuItem;
    N1: TMenuItem;
    PopRecortar: TMenuItem;
    PopCopiar: TMenuItem;
    PopColar: TMenuItem;
    PopSelecionarTudo: TMenuItem;
    N2: TMenuItem;
    PopPropriedades: TMenuItem;
    PopImprimir: TMenuItem;
    cbxHighlighter: TComboBox;
    PopDataHora: TMenuItem;
    Inserir1: TMenuItem;
    BlocodeComentario: TMenuItem;
    ListaErros: TListBox;
    N3: TMenuItem;
    PopComentar: TMenuItem;
    PopDescomentar: TMenuItem;
    procedure mwCustomEdit1StatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure mwCustomEdit1DropFiles(Sender: TObject; X, Y: Integer;
      Files: TStrings);
    procedure EditFindExecute(Sender: TObject);
    procedure EditFindUpdate(Sender: TObject);
    procedure EditSearchAgainUpdate(Sender: TObject);
    procedure EditSearchAgainExecute(Sender: TObject);
    procedure SelectionChange(Sender: TObject);
    procedure ShowHintEditor(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TextoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageEditorChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PopFecharClick(Sender: TObject);
    procedure PopRecortarClick(Sender: TObject);
    procedure PopCopiarClick(Sender: TObject);
    procedure PopColarClick(Sender: TObject);
    procedure PopSelecionarTudoClick(Sender: TObject);
    procedure PopPropriedadesClick(Sender: TObject);
    procedure PopImprimirClick(Sender: TObject);
    procedure mwCustomEdit1ReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure PopDataHoraClick(Sender: TObject);
    procedure BlocodeComentarioClick(Sender: TObject);
    procedure SynEditSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure ListaErrosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PopComentarClick(Sender: TObject);
    procedure PopDescomentarClick(Sender: TObject);
  private
    { Private declarations }
    SearchOptions: TSynSearchOptions;
    function GetEditor(Index: integer): TMyMwCustomEdit;
    function GetEditorCount : integer;
    function FormatAttrib(Attrib : TSynHighLighterAttributes) : string;
    procedure ParseAttr(Value : string; Attrib : TSynHighLighterAttributes);
  public
    { Public declarations }
    LinhaErro : Integer;
    procedure AbrirArquivo( aFileName : string; Posicao: Integer );
    function CurrentEdit : TMyMwCustomEdit;

    procedure StoreSettings;
    procedure LoadSettings;
    property Editor[Index:integer] : TMyMwCustomEdit read GetEditor;
    property EditorCount : integer read GetEditorCount;

    procedure SalvarnaSaida(Todos: Boolean);
    procedure SalvarnaSaidaQuery(Edit: TMyMwCustomEdit);
    procedure SalvarcomonaSaida;
    procedure CheckFileSave(Direto: Boolean);
    procedure EditorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

var
  FormEditor: TFormEditor;
  CodeCompletionList: TStringList;

implementation

{$R *.DFM}

uses ShellAPI, Princ, Rotinas, env_opt, find, Replace, DEntrada, ObjInsp;

procedure TFormEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.OnHint := FormPrincipal.Showhint;
  FormPrincipal.Botoes(False);
  Action := Cafree;
  FormEditor := Nil;
  if not FormPrincipal.BtnFecharProjeto.Enabled then
    FormPrincipal.BarraHistorico.Visible := FormPrincipal.S_Barra_Hist;
end;

procedure TFormEditor.AbrirArquivo(aFileName: string; Posicao: Integer);
var
  Page : TTabSheet;
  Edit : TMyMwCustomEdit;
  Linguagem: TSynCustomHighLighter;
  NewLine: Integer;

  procedure LoadFile(const FileName: string);
  (* This bit is stolen from EditU2.pas *)
    function MatchesExtension(ext: string; light: TSynCustomHighLighter): boolean;
      var
      fext  : string;
//      idx   : integer;
      ucext : string;
      filter: string;
      p     : integer;
    begin
      Result := false;
      ucext := UpperCase(ext);
      p := Pos('.',ucext);
      if p > 0 then ucext := Copy(ucext,p+1,Length(ucext)-p);
      p := Pos('|',light.DefaultFilter);
      if p > 0 then begin
        filter := Copy(light.DefaultFilter,p+1,Length(light.DefaultFilter)-p);
        while filter <> '' do begin
          p := Pos(';',filter);
          if p = 0 then p := Length(filter)+1;
          fext := Copy(filter,1,p-1);
          filter := Copy(filter,p+1,Length(filter)-p);
          p := Pos('.',fext);
          if p > 0 then fext := Copy(fext,p+1,Length(fext)-p);
          if UpperCase(fext) = ucext then begin
(*
            idx := cbxHighlighterSelect.Items.IndexOf(light.LanguageName);
            if idx >= 0 then cbxHighlighterSelect.ItemIndex := idx;
            cbxHighlighterSelectChange(Self);
*)
            Edit.Highlighter := light;
            Result := true;
          end;
        end; //while
      end
    end; { MatchesExtension }

  var
    i  : integer;
    ext: string;
    bWasText: boolean;                                                            //mh 1999-10-04
    backCursor: TCursor;
  begin
    backCursor := Cursor;
    try
      Cursor := crHourGlass;
      Windows.SetCursor(Screen.Cursors[crHourGlass]);
      ext := UpperCase(ExtractFileExt(aFileName));
      for i := 0 to BaseDados.ComponentCount-1 do
        if BaseDados.Components[i] is TSynCustomHighLighter then begin
          if MatchesExtension(ext,BaseDados.Components[i] as TSynCustomHighLighter) then break;
        end;
      //if Edit.HighLighter = dmDfmSyn1 then
      //  LoadDFMFile2Strings(aFileName, Edit.Lines, bWasText)                        //mh 1999-10-04
      //else
        Edit.Lines.LoadFromFile(aFileName);
    finally
      Cursor := backCursor;
    end;
  end;

begin
  Page := TTabSheet.Create(self);
  try
    Page.PageControl := PageEditor;
    Edit := TMyMwCustomEdit.Create(Page);
    Edit.TabWidth := 4;
    Edit.Parent := Page;
    Edit.Align  := alClient;
    Edit.MaxUndo := 1024;
    Edit.OnSpecialLineColors := SynEditSpecialLineColors;
    if Projeto.Tabs <= 0 then Projeto.Tabs := 2;
    Edit.TabWidth := Projeto.Tabs;
    Edit.WantTabs := True;
    if (aFileName<>'') then begin
      Page.Caption := ExtractFileName(aFileName);
      Edit.FileName := aFileName;
      LoadFile( aFileName );
      //Projeto.Nome := aFileName;
      //FormPrincipal.GravaProjetosAbertos;
    end
    else
    begin
      Page.Caption := 'Novo...';
      Edit.Highlighter := cbxHighlighter.Items.Objects[cbxHighlighter.Items.IndexOf('ObjectPascal')] as TSynCustomHighLighter;
    end;
    PageEditor.ActivePage := Page;
    Edit.Modified := false;
    Edit.ClearUndo;
    Edit.Options := Edit.Options - [eoShowScrollHint];
    Edit.Options := Edit.Options - [eoSmartTabDelete];
    frmEnvOpts.cbSmartTabs.Checked := False;
    if Projeto.Tabs <= 0 then Projeto.Tabs := 2;
    frmEnvOpts.T_Tabs.Value := Projeto.Tabs;
    frmEnvOpts.AssignOptions(Edit);

    Edit.OnStatusChange := mwCustomEdit1StatusChange;
    Edit.OnDropFiles    := mwCustomEdit1DropFiles;
    Edit.OnKeyUp        := EditorKeyUp;
    Edit.PopupMenu      := PopMenu;
    Edit.OnReplaceText  := mwCustomEdit1ReplaceText;
    mwCustomEdit1StatusChange( Edit, [] );

    Edit.SetFocus;
    if Posicao > 0 then
    begin
      NewLine:=StrToIntDef(IntToStr(Posicao),0);
      Edit.CaretY:= NewLine;
      LinhaErro := NewLine;
    end;
    PageEditorChange(self);
  except
    on exception do
      Page.Free;
  end;
end;

procedure TFormEditor.mwCustomEdit1StatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  with Sender as TSynEdit do begin
    StatusBar.Panels[0].Text := Format('%d:%d', [CaretY, CaretX]);
    if Modified then
      StatusBar.Panels[1].Text := 'Modificado'
    else
      StatusBar.Panels[1].Text := '';
    if InsertMode then
      StatusBar.Panels[2].Text := 'Inserção'
    else
      StatusBar.Panels[2].Text := 'Subscrever'; {OverWrite}
  end;
end;

function TFormEditor.CurrentEdit: TMyMwCustomEdit;
begin
  Result := Editor[PageEditor.ActivePage.PageIndex];
end;

procedure TFormEditor.StoreSettings;
var
  INI : TINIFile;
  I,J : integer;
  ArqIni: String;
begin
  ArqIni  := Projeto.PastaGerador;
  Ini := TInifile.Create(ArqIni + 'XMAKER.INI');
  try
    {for i := 0 to ComponentCount-1 do
      if Components[i] is TSynCustomHighLighter then
        with Components[i] as TSynCustomHighLighter do
          for J := 0 to AttrCount-1 do
             INI.WriteString( LanguageName, Attribute[J].Name,
               FormatAttrib( Attribute[J] ));}
    INI.WriteBool( 'Editor', 'AutoIndent', frmEnvOpts.cbAutoIndent.Checked );
    INI.WriteBool( 'Editor', 'DragDropEditing', frmEnvOpts.cbDragDropEditing.Checked );
    INI.WriteBool( 'Editor', 'DropFiles', frmEnvOpts.cbDropFiles.Checked );
    INI.WriteBool( 'Editor', 'HalfPageScroll', frmEnvOpts.cbHalfPageScroll.Checked );
    INI.WriteBool( 'Editor', 'ScrollPastEol', frmEnvOpts.cbScrollPastEol.Checked );
    INI.WriteBool( 'Editor', 'TabsToSpaces', frmEnvOpts.cbTabsToSpaces.Checked );
    INI.WriteBool( 'Editor', 'SmartTabs', frmEnvOpts.cbSmartTabs.Checked );

    INI.WriteBool( 'Gutter', 'ShowLineNumbers', frmEnvOpts.cbShowLineNumbers.Checked );
  finally
    INI.Free;
  end;
end;

procedure TFormEditor.LoadSettings;
var
  INI : TINIFile;
  I,J : integer;
  Attr,ArqIni: string;
begin
  ArqIni  := Projeto.PastaGerador; //DiretorioComBarra(DirWindows);
  Ini := TInifile.Create(ArqIni + 'XMAKER.INI');
  try
    {for i := 0 to ComponentCount-1 do
      if Components[i] is TSynCustomHighLighter then
        with Components[i] as TSynCustomHighLighter do
          for J := 0 to AttrCount-1 do begin
             Attr := INI.ReadString( LanguageName, Attribute[J].Name,
               FormatAttrib( Attribute[J] ));
             ParseAttr( Attr, Attribute[J] );
          end;}
    frmEnvOpts.cbAutoIndent.Checked := INI.ReadBool( 'Editor', 'AutoIndent', true );
    frmEnvOpts.cbDragDropEditing.Checked := INI.ReadBool( 'Editor', 'DragDropEditing', true );
    frmEnvOpts.cbDropFiles.Checked := INI.ReadBool( 'Editor', 'DropFiles', false );
    frmEnvOpts.cbHalfPageScroll.Checked := INI.ReadBool( 'Editor', 'HalfPageScroll', false );
    frmEnvOpts.cbScrollPastEol.Checked := INI.ReadBool( 'Editor', 'ScrollPastEol', true );
    frmEnvOpts.cbTabsToSpaces.Checked := INI.ReadBool( 'Editor', 'TabsToSpaces', true );
    frmEnvOpts.cbSmartTabs.Checked := INI.ReadBool( 'Editor', 'SmartTabs', true );

    frmEnvOpts.cbShowLineNumbers.Checked := INI.ReadBool( 'Gutter', 'ShowLineNumbers', true );
    frmEnvOpts.cbGutterVisible.Checked := boolean(strtoint('30'));
  finally
    INI.Free;
  end;
end;

function TFormEditor.FormatAttrib(Attrib : TSynHighLighterAttributes) : string;
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

procedure TFormEditor.ParseAttr(Value : string; Attrib : TSynHighLighterAttributes);
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

function TFormEditor.GetEditor(Index: integer): TMyMwCustomEdit;
var
  I    : integer;
begin
  Result := nil;
  for I := 0 to PageEditor.Pages[Index].ControlCount-1 do
    if PageEditor.Pages[Index].Controls[I] is TMyMwCustomEdit then begin
      Result := PageEditor.Pages[Index].Controls[I] as TMyMwCustomEdit;
      break;
    end;
end;

function TFormEditor.GetEditorCount : integer;
begin
  Result := PageEditor.PageCount;
end;

procedure TFormEditor.mwCustomEdit1DropFiles(Sender: TObject; X, Y: Integer;
  Files: TStrings);
var
  I : integer;
begin
  for I := 0 to Files.Count-1 do
    AbrirArquivo(Files[I],0);
end;

procedure TFormEditor.FormResize(Sender: TObject);
begin
  {SetEditRect;
  SelectionChange(Sender);}
end;

procedure TFormEditor.FormPaint(Sender: TObject);
begin
  {SetEditRect;}
end;

{procedure TFormEditor.SetEditRect;
var
  R: TRect;
  I: Integer;
begin
  for I := 0 to PageEditor.PageCount-1 do
  begin
    with Texto[I] do
    begin
      R := Rect(GutterWid, 0, ClientWidth-GutterWid, ClientHeight);
      SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
    end;
  end;
end;}

procedure TFormEditor.SelectionChange(Sender: TObject);
begin
  {with Texto[PageEditor.ActivePage.TabIndex].Paragraph do
  try
    FUpdating := True;
    UpdateCursorPos;
  finally
    FUpdating := False;
  end;}
end;

procedure TFormEditor.ShowHintEditor(Sender: TObject);
begin
  if Length(FormEditor.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := FormEditor.Hint;
  end
  else StatusBar.SimplePanel := False;
end;

procedure TFormEditor.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHintEditor;
  FrmFind := TFrmFind.Create(Application);
  frmEnvOpts := TfrmEnvOpts.Create(Application);
  FrmReplace := TFrmReplace.Create(Application);
end;

procedure TFormEditor.TextoChange(Sender: TObject);
begin
  {SetModified(Texto[PageEditor.ActivePage.TabIndex].Modified);}
end;

procedure TFormEditor.FormShow(Sender: TObject);
var
  i: integer;
  f, s: string;
begin
  LoadSettings;
  cbxHighlighter.Items.Clear;
  cbxHighlighter.Items.Add( 'None' );
  for i := 0 to BaseDados.ComponentCount-1 do
    if BaseDados.Components[i] is TSynCustomHighLighter then begin
      if (BaseDados.Components[i] as TSynCustomHighLighter).DefaultFilter <> '' then begin
        cbxHighlighter.Items.AddObject((BaseDados.Components[i] as TSynCustomHighLighter).LanguageName,
         BaseDados.Components[i]);
        f := (BaseDados.Components[i] as TSynCustomHighLighter).DefaultFilter;
        s := s + copy(f, pos('|',f)+1, length(f)) + ';';
      end;
    end;
  cbxHighlighter.ItemIndex := 1;
  CodeCompletionList:= TStringList.Create;
  LinhaErro := -1;
end;

procedure TFormEditor.FormDestroy(Sender: TObject);
var
  QtdTexto : Integer;
begin
  QtdTexto := 0;
  while QtdTexto <= ComponentCount - 1 do
  begin
    if (Components[QtdTexto] is TRichEdit) or
       (Components[QtdTexto] is TTabSheet) or
       (Components[QtdTexto] is TBevel)    then
      Components[QtdTexto].Destroy
    else
      Inc(QtdTexto);
  end;
end;

{procedure TFormEditor.Inicializa;
begin
  SelectionChange(Self);
  UpdateCursorPos;
  TextoChange(nil);
  PageEditor.ActivePageIndex := PageEditor.PageCount - 1;
  Texto[PageEditor.ActivePage.TabIndex].SetFocus;
end;}

procedure TFormEditor.PageEditorChange(Sender: TObject);
var
  Idx : integer;
  Edit : TMyMwCustomEdit;
begin
  Caption := CurrentEdit.FileName;
  Edit := CurrentEdit;
  Idx := 0;
  mwCustomEdit1StatusChange( Edit, [] );
end;

procedure TFormEditor.EditFindExecute(Sender: TObject);
var
  OldBlockBegin: TPoint;
  OldBlockEnd: TPoint;
begin
  with CurrentEdit do begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd   := BlockEnd;
    SetSelWord;
    frmFind.cbFindText.Text := SelText;
    BlockBegin := OldBlockBegin;
    BlockEnd   := OldBlockEnd;
    if frmFind.ShowModal=mrOk then begin
      SearchOptions := [];
      if frmFind.cbMatchCase.Checked then
        include( SearchOptions, ssoMatchCase );
      if frmFind.cbWholeWord.Checked then
        include( SearchOptions, ssoWholeWord );
      if frmFind.rbBackward.Checked then
        include( SearchOptions, ssoBackwards );
      if frmFind.rbSelectedOnly.Checked then
        include( SearchOptions, ssoSelectedOnly );
      if frmFind.rbEntireScope.Checked then
        include( SearchOptions, ssoEntireScope );

      SearchReplace(frmFind.cbFindText.Text, '', SearchOptions );
    end;
  end;
end;

procedure TFormEditor.EditFindUpdate(Sender: TObject);
begin
  {EditFind.Enabled := CurrentEdit<>nil;}
end;

procedure TFormEditor.EditSearchAgainUpdate(Sender: TObject);
begin
  {EditSearchAgain.Enabled := frmFind.cbFindText.Text <> '';}
end;

procedure TFormEditor.EditSearchAgainExecute(Sender: TObject);
begin
  exclude( SearchOptions, ssoEntireScope );
  CurrentEdit.SearchReplace(frmFind.cbFindText.Text, '', SearchOptions );
end;

procedure TFormEditor.CheckFileSave(Direto: Boolean);
var
  SaveResp: Integer;
  I : Integer;
  Edit : TMyMwCustomEdit;
begin
  Edit := CurrentEdit;
  if assigned(Edit) and Edit.Modified then
    case Mensagem('Salvar Arquivo '+Edit.Filename+'?', modConfirmacao,
      [ModSim, ModNao, ModCancela]) of
      mrYes : SalvarnaSaida(False);
      mrNo  : ;
      mrCancel : exit;
    end;
  PageEditor.ActivePage.Free;
  if PageEditor.PageCount <> 0 then
  begin
    if PageEditor.ActivePage.PageIndex = 0 then
      PageEditor.ActivePage := PageEditor.Pages[PageEditor.PageCount-1];
    PageEditorChange(self);
  end
  else
  begin
    FormPrincipal.FecharForm := True;
    Close;
  end;
end;

procedure TFormEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  I : integer;
begin
  if not FormPrincipal.FecharForm then
  begin
    //Mensagem('Feche todos os Projetos abertos !',ModInformacao,[ModOk]);
    CanClose := False;
    //FormPrincipal.BtnFecharTodosClick(Self);
    FormPrincipal.FecharForm := True;
    Close;
    exit;
  end;
  FormPrincipal.FecharForm := False;
  CanClose := true;
  for I := 0 to EditorCount-1 do
    if Editor[I].Modified then
      case Mensagem('Salvar Arquivo '+Editor[I].Filename+'?', ModConfirmacao,
        [ModSim, ModNao, ModCancela]) of
        mrYes : SalvarnaSaidaQuery(Editor[I]);
        mrNo  : ;
        mrCancel : begin
                     CanClose := false;
                     exit;
                   end;
      end;
  FrmFind.Free;
  FrmEnvOpts.Free;
  FrmReplace.Free;
end;

procedure TFormEditor.SalvarnaSaidaQuery(Edit: TMyMwCustomEdit);
begin
  if assigned(Edit) then begin
    if Edit.Filename = '' then
      SalvarComonaSaida
    else begin
      Edit.Lines.SaveToFile( Edit.FileName );
      Edit.Modified := false;
      PageEditorChange(self);
    end;
  end;
end;

procedure TFormEditor.SalvarnaSaida(Todos: Boolean);
var
  Edit : TMyMwCustomEdit;
  I : integer;
begin
  if not Todos then
  begin
    Edit := CurrentEdit;
    if assigned(Edit) then
    begin
      if Edit.Filename = '' then
        SalvarComonaSaida
      else begin
        Edit.Lines.SaveToFile( Edit.FileName );
        Edit.Modified := false;
        PageEditorChange(self);
        //ProjetoNome := Edit.FileName;
        //FormPrincipal.GravaProjetosAbertos;
      end;
      //ProjetoNome := Edit.FileName;
      //FormPrincipal.GravaProjetosAbertos;
    end;
  end
  else
  begin
    for I := 0 to EditorCount-1 do
      if Editor[I].Modified then
      begin
        if Editor[I].Filename = '' then
          SalvarComonaSaida
        else begin
          Editor[I].Lines.SaveToFile( Editor[I].FileName );
          Editor[I].Modified := false;
          PageEditorChange(self);
          //ProjetoNome := Editor[I].FileName;
          //FormPrincipal.GravaProjetosAbertos;
        end;
      end;
  end;
end;

procedure TFormEditor.SalvarcomonaSaida;
var
  Edit : TMyMwCustomEdit;
begin
  Edit := CurrentEdit;
  //FormPrincipal.ExtensaoPadrao;
  FormPrincipal.DialogSalvarProjeto.DefaultExt := '';
  FormPrincipal.DialogSalvarProjeto.Filter := 'Fontes Delphi (*.pas;*.dpr;*.dfm)|*.pas; *.dpr; *.dfm|'+
                                              'Arquivo Texto (*.txt)|*.txt|'+
                                              'Todos Arquivos (*.*)|*.*';
  if FormPrincipal.DialogSalvarProjeto.Execute then
    if assigned(Edit) then begin
      Edit.FileName := FormPrincipal.DialogSalvarProjeto.FileName;
      (Edit.Parent as TTabSheet).Caption := ExtractFileName(Edit.FileName);
    end;
    SalvarnaSaida(False);
end;

procedure TFormEditor.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {showMessage(IntToStr(Key));}
  //if (Key = 113) or
  //   ((Shift = ([ssCtrl])) and (Key = 83)) then { F2 }
  //  FormPrincipal.BtnSalvarArquivoClick(Self)
  //else if (Key = 114) or
  //  ((Shift = ([ssCtrl])) and (Key = 70)) then { F3 }
  //  FormPrincipal.LocalizarClick(Self)
  //else if (Key = 115) or
  // ((Shift = ([ssCtrl])) and (Key = 76)) then { F4 }
  //  FormPrincipal.ProximoClick(Self)
  //else if (Key = 116) or
  //  ((Shift = ([ssCtrl])) and (Key = 82)) then { F5 }
  //  FormPrincipal.SubstituirClick(Self)
  //else if (Key = 117) or
  //  ((Shift = ([ssAlt])) and (Key = 71)) then { F6 }
  //  FormPrincipal.PosicionarClick(Self)
  //else if (Shift = [ssCtrl]) and
  //        (Key = 74) then                     { Ctrl + J }
  //begin
  //  if CurrentEdit.SelectionMode = smNormal then
  //    CurrentEdit.SelectionMode := smColumn
  //  else if CurrentEdit.SelectionMode = smColumn then
  //    CurrentEdit.SelectionMode := smLine
  //  else if CurrentEdit.SelectionMode = smLine then
  //    CurrentEdit.SelectionMode := smNormal;
  //end
  //else if (Shift = [ssAlt]) and
  //        (Key = 65) then                     { Alt + A }
  //  FormPrincipal.BtnMArquivo.CheckMenuDropdown
  //else if (Shift = [ssAlt]) and
  //        (Key = 69) then                     { Alt + E }
  //  FormPrincipal.BtnMEditar.CheckMenuDropdown
  //else if (Shift = [ssAlt]) and
  //        (Key = 88) then                     { Alt + X }
  //  FormPrincipal.BtnMExibir.CheckMenuDropdown
  //else if (Shift = [ssAlt]) and
  //        (Key = 67) then                     { Alt + C }
  //  FormPrincipal.BtnMConfiguracao.CheckMenuDropdown
  //else if (Shift = [ssAlt]) and
  //        (Key = 74) then                     { Alt + J }
  //  FormPrincipal.BtnMAjuda.CheckMenuDropdown;
end;

procedure TFormEditor.PopFecharClick(Sender: TObject);
begin
  FormPrincipal.BtnFecharArquivoClick(Self);
end;

procedure TFormEditor.PopRecortarClick(Sender: TObject);
begin
  FormPrincipal.RecortarClick(Self);
end;

procedure TFormEditor.PopCopiarClick(Sender: TObject);
begin
  FormPrincipal.CopiarClick(Self);
end;

procedure TFormEditor.PopColarClick(Sender: TObject);
begin
  FormPrincipal.ColarClick(Self);
end;

procedure TFormEditor.PopSelecionarTudoClick(Sender: TObject);
begin
  FormPrincipal.SelecionarTudoClick(Self);
end;

procedure TFormEditor.PopPropriedadesClick(Sender: TObject);
begin
  FormPrincipal.CorEditorClick(Self);
end;

procedure TFormEditor.PopImprimirClick(Sender: TObject);
begin
  FormPrincipal.ImprimirClick(Self);
end;

procedure TFormEditor.mwCustomEdit1ReplaceText(Sender: TObject;
  const ASearch, AReplace: String; Line, Column: Integer;
  var Action: TSynReplaceAction);
var
  Resposta : Integer;
begin
  Resposta := Mensagem('Substituir a ocorrência por '+#39+AReplace+#39+' ?',ModConfirmacao,[ModSim,ModNao,ModCancela,ModTodos]);
  if Resposta = mrYes then
    Action := raReplace
  else if Resposta = mrNo then
    Action := raSkip
  else if Resposta = mrCancel then
    Action := raCancel
  else if Resposta = 10 then
    Action := raReplaceAll;
end;

procedure TFormEditor.PopDataHoraClick(Sender: TObject);
begin
  CurrentEdit.SelText := DateToStr(Date) + ', ' +TimeToStr(Time);
end;

procedure TFormEditor.BlocodeComentarioClick(Sender: TObject);
begin
  CurrentEdit.SelText := '{' + ^M + ^M + '}';
  CurrentEdit.CaretY  := CurrentEdit.CaretY - 1;
end;

procedure TFormEditor.SynEditSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  if Line = LinhaErro then
  begin
    Special := TRUE;
    FG := clWhite;
    BG := clRed
  end;
end;

procedure TFormEditor.ListaErrosClick(Sender: TObject);
var
  Pos1, Pos2, LhError : Integer;
  LinhaError: String;
begin
  if (ListaErros.ItemIndex > -1) and (FormPrincipal.BtnSalvarArquivo.Enabled) then
  begin
    LinhaError := ListaErros.Items[ListaErros.ItemIndex];
    Pos1 := Pos('(',LinhaError)+1;
    Pos2 := Pos(')',LinhaError);
    LhError := StrToInt(Copy(LinhaError,Pos1,Pos2-Pos1));
    if LhError > 0 then
      CurrentEdit.CaretY:= LhError;
    CurrentEdit.SetFocus;
  end;
end;

procedure TFormEditor.FormActivate(Sender: TObject);
begin
  FormPrincipal.Recortar.Enabled       := True;
  FormPrincipal.Colar.Enabled          := True;
  FormPrincipal.Copiar.Enabled         := True;
  FormPrincipal.SelecionarTudo.Enabled := True;

  FormPrincipal.Divisao_Form.Visible   := False;
  FormPrincipal.Tamanho.Visible        := False;
  FormPrincipal.Alinhamento.Visible    := False;
  FormPrincipal.EnviarParaFrente.visible := False;
  FormPrincipal.EnviarParaTras.Visible   := False;
  FormPrincipal.TabOrder.Visible         := False;

  FormPrincipal.Recortar.OnClick       := FormPrincipal.RecortarClick;
  FormPrincipal.Colar.OnClick          := FormPrincipal.ColarClick;
  FormPrincipal.Copiar.OnClick         := FormPrincipal.CopiarClick;
  FormPrincipal.SelecionarTudo.OnClick := FormPrincipal.SelecionarTudoClick;

  if FormEntradaDados <> nil then
    FormEntradaDados.WindowState := wsMinimized;
  if FormObjInsp <> nil then
    FormObjInsp.WindowState := wsMinimized;
end;

procedure TFormEditor.PopComentarClick(Sender: TObject);
begin
  FormPrincipal.ComentarClick(Self);
end;

procedure TFormEditor.PopDescomentarClick(Sender: TObject);
begin
  FormPrincipal.DescomentarClick(Self);
end;

end.
