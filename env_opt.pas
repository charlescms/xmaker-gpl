unit env_opt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ColorGrd, IniFiles, Buttons, Spin, SynEdit,
  SynEditHighlighter, SynHighlighterPas;

type
  TfrmEnvOpts = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    PageControl1: TPageControl;
    tsEditor: TTabSheet;
    tsCor: TTabSheet;
    lbLanguage: TListBox;
    GroupBox1: TGroupBox;
    lbElement: TListBox;
    ColorGrid: TColorGrid;
    cbBold: TCheckBox;
    cbItalic: TCheckBox;
    cbUnderline: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    cbStrikeOut: TCheckBox;
    GroupBox2: TGroupBox;
    cbAutoIndent: TCheckBox;
    cbDragDropEditing: TCheckBox;
    cbDropFiles: TCheckBox;
    cbHalfPageScroll: TCheckBox;
    cbScrollPastEol: TCheckBox;
    cbTabsToSpaces: TCheckBox;
    cbSmartTabs: TCheckBox;
    GroupBox3: TGroupBox;
    cbGutterVisible: TCheckBox;
    cbShowLineNumbers: TCheckBox;
    T_Tabs: TSpinEdit;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lbLanguageClick(Sender: TObject);
    procedure lbElementClick(Sender: TObject);
    procedure ElementChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
  public
    procedure GetCurrentSettings;
    procedure ApplyCurrentSettings;
    procedure EnumerateHighlighters;
    procedure AssignOptions( Edit : TSynEdit );
  end;

var
  frmEnvOpts: TfrmEnvOpts;

implementation

uses rotinas, Princ, BaseD, FDesigner;

{$R *.DFM}

procedure TfrmEnvOpts.EnumerateHighlighters;
var
  I : integer;
begin
  lbLanguage.Items.Clear;
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSynCustomHighLighter then
    begin
      lbLanguage.Items.AddObject(
        (Components[i] as TSynCustomHighLighter).LanguageName,
         Components[i]);
    end;
  lbLanguage.ItemIndex := 0;
  lbLanguageClick(self);
end;

procedure TfrmEnvOpts.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  EnumerateHighlighters;
  GetCurrentSettings;
  T_Tabs.Value := Projeto.Tabs;
end;

procedure TfrmEnvOpts.lbLanguageClick(Sender: TObject);
var
  i: integer;
  h: TSynCustomHighLighter;
begin
  if lbLanguage.ItemIndex >= 0 then begin
    h := lbLanguage.Items.Objects[lbLanguage.ItemIndex] as TSynCustomHighLighter;
    lbElement.Items.Clear;
    for i := 0 to h.AttrCount - 1 do
      lbElement.Items.Add(h.Attribute[i].Name);
    lbElement.ItemIndex := 0;
  end;
  lbElementClick(Self);
end;

procedure TfrmEnvOpts.lbElementClick(Sender: TObject);
var
  h: TSynCustomHighLighter;
  Attr: TSynHighLighterAttributes;
begin
  if lbLanguage.ItemIndex >= 0 then begin
    h := lbLanguage.Items.Objects[lbLanguage.ItemIndex] as TSynCustomHighLighter;
    Attr := TSynHighLighterAttributes.Create('');
    try
      Attr.Assign(h.Attribute[lbElement.ItemIndex]);
      ColorGrid.ForegroundIndex := ColorGrid.ColorToIndex(Attr.Foreground);
      ColorGrid.BackgroundIndex := ColorGrid.ColorToIndex(Attr.Background);

      cbBold.Checked := (fsBold in Attr.Style);
      cbItalic.Checked := (fsItalic in Attr.Style);
      cbUnderLine.Checked := (fsUnderline in Attr.Style);
      cbStrikeOut.Checked := (fsStrikeOut in Attr.Style);
    finally
      Attr.Free;
    end;
  end;
end;

procedure TfrmEnvOpts.ElementChange(Sender: TObject);
var
  h: TSynCustomHighLighter;
  Attr: TSynHighLighterAttributes;
  AttrStyle: TFontStyles;
begin
  if lbLanguage.ItemIndex >= 0 then begin
    h := lbLanguage.Items.Objects[lbLanguage.ItemIndex] as TSynCustomHighLighter;
    Attr := TSynHighLighterAttributes.Create(lbElement.Items[lbElement.ItemIndex]);
    try
       AttrStyle := [];
       Attr.Foreground := ColorGrid.ForegroundColor;
       Attr.Background := ColorGrid.BackgroundColor;
       if cbBold.Checked then
         Include(AttrStyle, fsBold);
       if cbItalic.Checked then
         Include(AttrStyle, fsItalic);
       if cbUnderLine.Checked then
         Include(AttrStyle, fsUnderline);
       if cbStrikeOut.Checked then
         Include(AttrStyle, fsStrikeOut);
       Attr.Style := AttrStyle;
       h.Attribute[lbElement.ItemIndex].Assign(Attr);
    finally
      Attr.Free;
    end;
  end;
end;

procedure TfrmEnvOpts.GetCurrentSettings;
  procedure AssignAttrs( FromHL, ToHL : TSynCustomHighLighter );
  var
    I : integer;
  begin
    for I := 0 to FromHL.AttrCount-1 do
      ToHL.Attribute[I].Assign( FromHL.Attribute[I] );
  end;
var
  I : integer;
  Idx : integer;
  Edit : TSynEdit;
begin
  for i := 0 to BaseDados.ComponentCount-1 do
    if BaseDados.Components[i] is TSynCustomHighLighter then begin
      Idx := lbLanguage.Items.IndexOf(
        (BaseDados.Components[i] as TSynCustomHighLighter).LanguageName );
      if Idx >= 0 then
        AssignAttrs( BaseDados.Components[i] as TSynCustomHighLighter,
          lbLanguage.Items.Objects[Idx] as TSynCustomHighLighter );
    end;
  Edit := FormDesigner_Net.CurrentEdit;

  cbAutoIndent.Checked := eoAutoIndent in Edit.Options;
  cbDragDropEditing.Checked := eoDragDropEditing in Edit.Options;
  cbDropFiles.Checked := eoDropFiles in Edit.Options;
  cbHalfPageScroll.Checked := eoHalfPageScroll in Edit.Options;
  cbScrollPastEol.Checked := eoScrollPastEol in Edit.Options;
  cbTabsToSpaces.Checked := eoTabsToSpaces in Edit.Options;
  cbSmartTabs.Checked := eoSmartTabs in Edit.Options;

  cbGutterVisible.Checked := Edit.Gutter.Width > 0;
  cbShowLineNumbers.Checked := Edit.Gutter.ShowLineNumbers;
end;

procedure TfrmEnvOpts.AssignOptions( Edit : TSynEdit );
begin
  cbSmartTabs.Checked := False;
  if cbAutoIndent.Checked then
    Edit.Options := Edit.Options + [eoAutoIndent]
  else
    Edit.Options := Edit.Options - [eoAutoIndent];

  if cbDragDropEditing.Checked then
    Edit.Options := Edit.Options + [eoDragDropEditing]
  else
    Edit.Options := Edit.Options - [eoDragDropEditing];

  if cbDropFiles.Checked then
    Edit.Options := Edit.Options + [eoDropFiles]
  else
    Edit.Options := Edit.Options - [eoDropFiles];

  if cbHalfPageScroll.Checked then
    Edit.Options := Edit.Options + [eoHalfPageScroll]
  else
    Edit.Options := Edit.Options - [eoHalfPageScroll];

  if cbScrollPastEol.Checked then
    Edit.Options := Edit.Options + [eoScrollPastEol]
  else
    Edit.Options := Edit.Options - [eoScrollPastEol];

  if cbTabsToSpaces.Checked then
    Edit.Options := Edit.Options + [eoTabsToSpaces]
  else
    Edit.Options := Edit.Options - [eoTabsToSpaces];

  if cbSmartTabs.Checked then
    Edit.Options := Edit.Options + [eoSmartTabs]
  else
    Edit.Options := Edit.Options - [eoSmartTabs];

  if not cbGutterVisible.Checked then
    Edit.Gutter.Width := 0
  else begin
    Edit.Gutter.ShowLineNumbers := cbShowLineNumbers.Checked;
    Edit.Gutter.Width := 30;
  end;
  Edit.TabWidth := T_Tabs.Value;
end;

procedure TfrmEnvOpts.ApplyCurrentSettings;
  procedure AssignAttrs( FromHL, ToHL : TSynCustomHighLighter );
  var
    I : integer;
  begin
    for I := 0 to FromHL.AttrCount-1 do
      ToHL.Attribute[I].Assign( FromHL.Attribute[I] );
  end;

var
  I : integer;
  Idx : integer;
begin
  for i := 0 to BaseDados.ComponentCount-1 do
    if BaseDados.Components[i] is TSynCustomHighLighter then begin
      Idx := lbLanguage.Items.IndexOf(
        (BaseDados.Components[i] as TSynCustomHighLighter).LanguageName );
      if Idx >= 0 then
        AssignAttrs( lbLanguage.Items.Objects[Idx] as TSynCustomHighLighter,
          BaseDados.Components[i] as TSynCustomHighLighter );
    end;
  //for I := 0 to FormDesigner_Net.EditorCount-1 do
  //  AssignOptions(FormDesigner_Net.Editor[I]);
end;

procedure TfrmEnvOpts.btnOkClick(Sender: TObject);
begin
  //ApplyCurrentSettings;
  Projeto.Tabs := T_Tabs.Value;
end;

end.
