(*  GREATIS FORM EXTRACTOR for                *)
(*  GREATIS FORM DESIGNER                     *)
(*  Copyright (C) 2002-2004 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm        *)
(*  b-team@greatis.com                        *)

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus, Procs, Objs, ToolWin, About, Registry,
  Common, FileCtrl, ShlObj, ComObj, ActiveX;

type
  TfrmMain = class(TForm)
    lsbForms: TListBox;
    splMain: TSplitter;
    pgcMain: TPageControl;
    tshForm: TTabSheet;
    tshDFM: TTabSheet;
    tshPAS: TTabSheet;
    sbxForm: TScrollBox;
    tbrMain: TToolBar;
    stbMain: TStatusBar;
    mmnMain: TMainMenu;
    mniFile: TMenuItem;
    redDFM: TRichEdit;
    redPAS: TRichEdit;
    mniFileOpen: TMenuItem;
    mniFileExitSep: TMenuItem;
    mniFileExit: TMenuItem;
    opdMain: TOpenDialog;
    lblExp: TLabel;
    tshInfo: TTabSheet;
    redInfo: TRichEdit;
    mniHelp: TMenuItem;
    mniHelpAbout: TMenuItem;
    mniFileSave: TMenuItem;
    mniFileSaveAll: TMenuItem;
    mniFileReopen: TMenuItem;
    imlMain: TImageList;
    tbtFileOpen: TToolButton;
    tbtFileSave: TToolButton;
    tbtFileSaveAll: TToolButton;
    mniSearch: TMenuItem;
    mniSearchFind: TMenuItem;
    mniSearchFindNext: TMenuItem;
    tbtEditSep: TToolButton;
    tbtEditCopy: TToolButton;
    tbtEditSelectAll: TToolButton;
    tbtSearchSep: TToolButton;
    tbtSearchFind: TToolButton;
    mniEdit: TMenuItem;
    mniEditCopy: TMenuItem;
    mniEditSelectAll: TMenuItem;
    tbtSearchFindNext: TToolButton;
    tbtAboutSep: TToolButton;
    tbtAbout: TToolButton;
    mniOptions: TMenuItem;
    svdMain: TSaveDialog;
    mniOptionsTextDFM: TMenuItem;
    mniOptionsSavePAS: TMenuItem;
    fidMain: TFindDialog;
    procedure mniFileOpenClick(Sender: TObject);
    procedure mniFileExitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lsbFormsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mniHelpAboutClick(Sender: TObject);
    procedure mniFileReopenClick(Sender: TObject);
    procedure mniCheckClick(Sender: TObject);
    procedure mniFileSaveClick(Sender: TObject);
    procedure mniFileSaveAllClick(Sender: TObject);
    procedure mniSearchFindClick(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure fidMainFind(Sender: TObject);
    procedure mniSearchFindNextClick(Sender: TObject);
    procedure redSelectionChange(Sender: TObject);
    procedure mniEditSelectAllClick(Sender: TObject);
    procedure mniEditCopyClick(Sender: TObject);
  private
    { Private declarations }
    FormPanel: TFormPanel;
    SourceFile: string;
    SaveAllDir: string;
    procedure ClearList;
    procedure ApplicationHint(Sender: TObject);
    function GetFormStreams(Index: Integer; BIN,TXT,PAS: TMemoryStream): Integer;
    procedure GetForm;
    procedure ClearForm;
    procedure OpenFile(FileName: string);
    procedure SaveForm(Index: Integer; FileName: string; var MR: TModalResult);
    function ActiveEditor: TRichEdit;
    procedure EnableActions;
    procedure FindText;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}
{$R XP.RES}

function EnumFunc(Handle: HModule; ResType,ResName: PChar; Strings: TStrings): BOOL; stdcall;
const
  FileSignature: array[1..4] of Char = 'TPF0';
var
  RS: TResourceStream;
  MS: TMemoryStream;
  Signature: Longint;
  FormType,FormName: ShortString;
begin
  Result:=True;
  RS:=TResourceStream.Create(Handle,ResName,ResType);
  try
    RS.Read(Signature,SizeOf(Signature));
    if Signature=Longint(FileSignature) then
    begin
      MS:=TMemoryStream.Create;
      RS.ReadBuffer(FormType[0],SizeOf(FormType[0]));
      if Ord(FormType[0])=$F1 then RS.ReadBuffer(FormType[0],SizeOf(FormType[0]));
      RS.ReadBuffer(FormType[1],Ord(FormType[0]));
      RS.ReadBuffer(FormName[0],SizeOf(FormName[0]));
      RS.ReadBuffer(FormName[1],Ord(FormName[0]));
      RS.Seek(0,soFromBeginning);
      MS.CopyFrom(RS,RS.Size);
      MS.Seek(0,soFromBeginning);
      Strings.AddObject(FormName,MS);
    end;
  finally
    RS.Free;
  end;
end;

procedure TfrmMain.mniFileOpenClick(Sender: TObject);
begin
  with opdMain do
    if Execute then OpenFile(FileName);
end;

procedure TfrmMain.mniFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.ClearList;
var
  i: Integer;
begin
  with lsbForms.Items do
  begin
    for i:=0 to Pred(Count) do
      if Assigned(Objects[i]) then Objects[i].Free;
    Clear;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  ClearList;
  with TRegIniFile.Create(RegSection) do
  begin
    EraseSection(ReopenSection);
    with mniFileReopen do
    begin
      WriteInteger(ReopenSection,'Count',mniFileReopen.Count);
      for i:=0 to Pred(Count) do
        WriteString(ReopenSection,IntToStr(i),Items[i].Hint);
    end;
    EraseSection(FrmSection);
    WriteInteger(FrmSection,'State',Integer(WindowState));
    if WindowState=wsNormal then
    begin
      WriteInteger(FrmSection,'Left',Left);
      WriteInteger(FrmSection,'Top',Top);
      WriteInteger(FrmSection,'Width',Width);
      WriteInteger(FrmSection,'Height',Height);
    end;
    WriteInteger(FrmSection,'Split',lsbForms.Width);
    WriteBool(OptSection,'TextDFM',mniOptionsTextDFM.Checked);
    WriteBool(OptSection,'SavePAS',mniOptionsSavePAS.Checked);
  end;
end;

procedure TfrmMain.lsbFormsClick(Sender: TObject);
begin
  GetForm;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
  MI: TMenuItem;
begin
  Application.OnHint:=ApplicationHint;
  FormPanel:=TFormPanel.Create(Self);
  with TRegIniFile.Create(RegSection) do
  begin
    WriteString(AppSection,'@Name','Form Extractor');
    WriteString(AppSection,'@Path',ParamStr(0));
    WriteString(AppSection,'@Version','1.0');
    WindowState:=TWindowState(ReadInteger(FrmSection,'State',Integer(wsNormal)));
    if WindowState=wsNormal then
    begin
      Left:=ReadInteger(FrmSection,'Left',Left);
      Top:=ReadInteger(FrmSection,'Top',Top);
      Width:=ReadInteger(FrmSection,'Width',Width);
      Height:=ReadInteger(FrmSection,'Height',Height);
    end;
    with lsbForms do Width:=ReadInteger(FrmSection,'Split',Width);
    for i:=0 to Pred(ReadInteger(ReopenSection,'Count',0)) do
    begin
      MI:=TMenuItem.Create(Self);
      with MI do
      begin
        Hint:=ReadString(ReopenSection,IntToStr(i),'');
        OnClick:=mniFileReopenClick;
        Caption:=Format('&%d   %s',[i,Hint]);
        mniFileReopen.Add(MI);
      end;
    end;
    with mniFileReopen do Visible:=Count>0;
    mniOptionsTextDFM.Checked:=ReadBool(OptSection,'TextDFM',True);
    mniOptionsSavePAS.Checked:=ReadBool(OptSection,'SavePAS',True);
  end;
  pgcMain.ActivePage:=tshForm;
  EnableActions;
end;

procedure TfrmMain.ApplicationHint(Sender: TObject);
begin
  with Application do stbMain.SimpleText:=GetLongHint(Hint);
end;

function TfrmMain.GetFormStreams(Index: Integer; BIN,TXT,PAS: TMemoryStream): Integer;
var
  L: Integer;
  S,First: string;
  Source: TStream;
  PASList: TStringList;
begin
  Result:=0;
  // getting resource stream
  with lsbForms,Items do Source:=TStream(Objects[ItemIndex]);
  Source.Seek(0,soFromBeginning);
  // translating binary resource to text DFM
  TXT.Clear;
  ObjectBinaryToText(Source,TXT);
  // deleting all unresolvable declarations
  TXT.Seek(0,soFromBeginning);
  with TStringList.Create do
  try
    BeginUpdate;
    LoadFromStream(TXT);
    L:=0;
    while L<Count do
    begin
      S:=TrimLeft(Strings[L]);
      if (LineType(S)<>ltObject) and (Length(S)>6) and (Copy(S,1,2)='On') then Delete(L)
      else Inc(L);
    end;
    TXT.Clear;
    EndUpdate;
    SaveToStream(TXT);
  finally
    Free;
  end;
  // converting cleared text DFM to binary DFM
  TXT.Seek(0,soFromBeginning);
  BIN.Clear;
  ObjectTextToResource(TXT,BIN);
  TXT.Seek(0,soFromBeginning);
  // creaing PAS text
  with TStringList.Create do
  try
    LoadFromStream(TXT);
    PASList:=TStringList.Create;
    try
      PASList.BeginUpdate;
      First:=TrimLeft(Strings[0]);
      PASList.Add(Format(Header,[ObjectVar(First),ObjectType(First)]));
      for L:=1 to Pred(Count) do
      begin
        S:=TrimLeft(Strings[L]);
        if LineType(S)=ltObject then
        begin
          PASList.Add('    '+LineObject(S)+';');
          Inc(Result);
        end;
      end;
      PASList.Add(Format(Footer,[ObjectVar(First),ObjectType(First)]));
      PASList.EndUpdate;
      PAS.Clear;
      PASList.SaveToStream(PAS);
    finally
      PASList.Free;
    end;
  finally
    Free;
  end;
  BIN.Seek(0,soFromBeginning);
  TXT.Seek(0,soFromBeginning);
  PAS.Seek(0,soFromBeginning);
end;

procedure TfrmMain.GetForm;
var
  Source: TStream;
  BIN,TXT,PAS: TMemoryStream;
  BinSize,CompCount: Integer;
begin
  Screen.Cursor:=crHourGlass;
  try
    // creating streams
    BIN:=TMemoryStream.Create;
    TXT:=TMemoryStream.Create;
    PAS:=TMemoryStream.Create;
    try
      // retreiving the form information
      CompCount:=GetFormStreams(lsbForms.ItemIndex,BIN,TXT,PAS);
      BinSize:=BIN.Size;
      // copying information to rich edits
      redDFM.Lines.LoadFromStream(TXT);
      redPAS.Lines.LoadFromStream(PAS);
      // creating preview of the form
      FormPanel.Parent:=nil;
      CreatePreview(redDFM.Lines,FormPanel);
      FormPanel.Parent:=sbxForm;
    finally
      // destroying the streams
      BIN.Free;
      TXT.Free;
      PAS.Free;
    end;
    // retreiving source binary stream
    with lsbForms,Items do Source:=TStream(Objects[ItemIndex]);
    // getting file and form information
    with redInfo.Lines do
    begin
      BeginUpdate;
      Clear;
      try
        Add('FILE');
        Add('Location   '#9+SourceFile);
        Add('Forms      '#9+IntToStr(lsbForms.Items.Count)+#13#10);
        Add('RESOURCE');
        Add('Bytes      '#9+IntToStr(Source.Size)+#13#10);
        Add('FORM');
        Add('Name       '#9+ObjectVar(redDFM.Lines[0]));
        Add('Type       '#9+ObjectType(redDFM.Lines[0]));
        Add('Components '#9+IntToStr(CompCount)+#13#10);
        Add('BINARY DFM');
        Add('Bytes      '#9+IntToStr(BinSize)+#13#10);
        Add('TEXT DFM');
        Add('Bytes      '#9+IntToStr(Length(redDFM.Lines.Text)));
        Add('Lines      '#9+IntToStr(redDFM.Lines.Count)+#13#10);
        Add('PAS FILE');
        Add('Bytes      '#9+IntToStr(Length(redPAS.Lines.Text)));
        Add('Lines      '#9+IntToStr(redPAS.Lines.Count));
      finally
        EndUpdate;
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfrmMain.ClearForm;
begin
  with FormPanel do
  begin
    DestroyComponents;
    Parent:=nil;
  end;
  redDFM.Lines.Clear;
  redPAS.Lines.Clear;
  with redInfo.Lines do
  begin
    BeginUpdate;
    Clear;
    try
      Add('FILE');
      Add('Location   '#9+SourceFile);
      Add('Forms       0');
    finally
      EndUpdate;
    end;
  end;
  pgcMain.ActivePage:=tshInfo;
end;

procedure TfrmMain.OpenFile(FileName: string);
var
  HM: HModule;
  MI: TMenuItem;
  i: Integer;
begin
  Screen.Cursor:=crHourGlass;
  try
    SetCurrentDir(ExtractFilePath(FileName));
    HM:=LoadLibrary(PChar(FileName));
    try
      ClearList;
      if HM<>0 then
      begin
        with lsbForms,Items do
        begin
          BeginUpdate;
          try
            EnumResourceNames(HM,RT_RCDATA,@EnumFunc,Integer(Items));
          finally
            EndUpdate;
          end;
        end;
        Caption:=FileName+' - '+Application.Title;
        SourceFile:=FileName;
        with lsbForms,Items do
          if Count>0 then
          begin
            ItemIndex:=0;
            GetForm;
          end
          else ClearForm;
        with mniFileReopen do
        begin
          MI:=nil;
          for i:=0 to Pred(Count) do
            if AnsiUpperCase(Items[i].Hint)=AnsiUpperCase(SourceFile) then
            begin
              MI:=Items[i];
              Remove(MI);
              Insert(0,MI);
            end;
          if not Assigned(MI) then
          begin
            while Count>9 do Remove(Items[Pred(Count)]);
            MI:=TMenuItem.Create(Self);
            with MI do
            begin
              Hint:=SourceFile;
              OnClick:=mniFileReopenClick;
              mniFileReopen.Insert(0,MI);
            end;
          end;
          Visible:=Count>0;
          for i:=0 to Pred(Count) do
            with Items[i] do
              if Visible then Caption:=Format('&%d   %s',[i,Hint]);
        end;
      end
      else ShowError;
    finally
      FreeLibrary(HM);
    end;
    EnableActions;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfrmMain.mniHelpAboutClick(Sender: TObject);
begin
  with TfrmAbout.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmMain.mniFileReopenClick(Sender: TObject);
begin
  OpenFile((Sender as TMenuItem).Hint);
end;

procedure TfrmMain.SaveForm(Index: Integer; FileName: string; var MR: TModalResult);
var
  BIN,TXT,PAS: TMemoryStream;
  S: string;
  C: Char;
begin
  // creating streams
  BIN:=TMemoryStream.Create;
  TXT:=TMemoryStream.Create;
  PAS:=TMemoryStream.Create;
  try
    // retreiving the form information
    GetFormStreams(Index,BIN,TXT,PAS);
    if FileExists(FileName) and (MR<>mrAll) then MR:=MessageDlg('File "'+FileName+'" already exists.'#13'Overwrite?',mtConfirmation,[mbYes,mbNo,mbCancel,mbAll],0);
    if MR in [mrYes,mrAll] then
    begin
      with TFileStream.Create(FileName,fmCreate) do
      try
        if mniOptionsTextDFM.Checked then CopyFrom(TXT,TXT.Size)
        else CopyFrom(BIN,BIN.Size);
      finally
        Free;
      end;
      if mniOptionsSavePas.Checked then
      begin
        S:=ChangeFileExt(FileName,'.pas');
        if FileExists(S) and (MR<>mrAll) then MR:=MessageDlg('File "'+S+'" already exists.'#13'Overwrite?',mtConfirmation,[mbYes,mbNo,mbCancel,mbAll],0);
        if MR in [mrYes,mrAll] then
          with TFileStream.Create(S,fmCreate) do
          try
            S:=ExtractFileName(FileName);
            S:='unit '+Copy(S,1,Length(S)-Length(ExtractFileExt(S)))+';'#13#10;
            Write(S[1],Length(S));
            repeat
              PAS.Read(C,SizeOf(C));
            until C=#10;
            CopyFrom(PAS,PAS.Size-PAS.Position);
          finally
            Free;
          end;
      end;
    end;
  finally
    // destroying the streams
    BIN.Free;
    TXT.Free;
    PAS.Free;
  end;
end;

procedure TfrmMain.mniCheckClick(Sender: TObject);
begin
  with (Sender as TMenuItem) do Checked:=not Checked;
end;

procedure TfrmMain.mniFileSaveClick(Sender: TObject);
var
  MR: TModalResult;
begin
  MR:=mrYes;
  with svdMain do
    if Execute then
      with lsbForms do
        if ItemIndex>-1 then SaveForm(ItemIndex,FileName,MR);
end;

function BrowseProc(Handle: HWND; Msg: UINT; L,Data: LPARAM): Integer; stdcall;
begin
  Result:=0;
  if Msg=BFFM_INITIALIZED then
    SendMessage(Handle,BFFM_SETSELECTION,1,Data);
end;

procedure TfrmMain.mniFileSaveAllClick(Sender: TObject);
var
  MR: TModalResult;
var
  i: Integer;
  BI: TBrowseInfo;
  Result: PItemIDList;
  Temp: array[0..MAX_PATH] of Char;
  Dir: string;

  procedure DisposePIDL(ID: PItemIDList);
  var
    Malloc: IMalloc;
  begin
    if Assigned(ID) and (Integer(ID)<>-1) then
    try
      OLECheck(SHGetMalloc(Malloc));
      Malloc.Free(ID);
    except
    end;
  end;

begin
  MR:=mrYes;
  FillChar(BI,SizeOf(BI),0);
  with BI do
  begin
    hwndOwner:=Handle;
    lpszTitle:='Specify target folder for DFM and PAS files';
    ulFlags:=BIF_RETURNONLYFSDIRS or BIF_RETURNFSANCESTORS;
    lpfn:=@BrowseProc;
    lParam:=Integer(PChar(SaveAllDir));
    Result:=SHBrowseForFolder(BI);
    if Assigned(Result) then
    begin
      SHGetPathFromIDList(Result,Temp);
      SaveAllDir:=Temp;
      DisposePIDL(Result);
      Dir:=SaveAllDir;
      if Dir[Length(Dir)]<>'\' then Dir:=Dir+'\';
      with lsbForms,Items do
        for i:=0 to Pred(Count) do
        begin
          SaveForm(i,Dir+Items[i]+'Unit.dfm',MR);
          if MR=mrCancel then Exit;
        end;
    end;
  end;
end;

function TfrmMain.ActiveEditor: TRichEdit;
begin
  if (pgcMain.ActivePage.PageIndex>0) then
  try
    Result:=pgcMain.ActivePage.Controls[0] as TRichEdit;
  except
    Result:=nil;
  end
  else Result:=nil;
end;

procedure TfrmMain.EnableActions;
var
  FormsOK,TextOK,SelectOK,FindOK: Boolean;
  RE: TRichEdit;
begin
  RE:=ActiveEditor;
  FormsOK:=lsbForms.ItemIndex>-1;
  TextOK:=FormsOK and Assigned(RE) and (RE.Lines.Count>0);
  SelectOK:=TextOK and Assigned(RE) and (RE.SelLength>0);
  FindOK:=TextOK and (fidMain.FindText<>'');
  mniFileSave.Enabled:=FormsOK;
  tbtFileSave.Enabled:=FormsOK;
  mniFileSaveAll.Enabled:=FormsOK;
  tbtFileSaveAll.Enabled:=FormsOK;
  mniEditCopy.Enabled:=SelectOK;
  tbtEditCopy.Enabled:=SelectOK;
  mniEditSelectAll.Enabled:=TextOK;
  tbtEditSelectAll.Enabled:=TextOK;
  mniSearchFind.Enabled:=TextOK;
  tbtSearchFind.Enabled:=TextOK;
  mniSearchFindNext.Enabled:=FindOK;
  tbtSearchFindNext.Enabled:=FindOK;
end;

procedure TfrmMain.mniSearchFindClick(Sender: TObject);
begin
  with fidMain do
    if Execute then;
end;

procedure TfrmMain.pgcMainChange(Sender: TObject);
begin
  EnableActions;
end;

procedure TfrmMain.fidMainFind(Sender: TObject);
begin
  fidMain.CloseDialog;
  EnableActions;
  FindText;
end;

procedure TfrmMain.FindText;
var
  RE: TRichEdit;
  Start,Find: Integer;
  S,T: string;
begin
  RE:=ActiveEditor;
  if Assigned(RE) then
    with RE,Lines do
    begin
      RE.SetFocus;
      S:=AnsiUpperCase(fidMain.FindText);
      Start:=Succ(SelStart)+SelLength;
      T:=AnsiUpperCase(Copy(Text,Start,Length(Text)));
      Find:=Pos(S,T);
      if Find<>0 then
      begin
        SelStart:=Start+Find-2;
        SelLength:=Length(S);
      end
      else MessageDlg('Cannot find "'+fidMain.FindText+'"',mtInformation,[mbOK],0);
    end;
end;

procedure TfrmMain.mniSearchFindNextClick(Sender: TObject);
begin
  FindText;
end;

procedure TfrmMain.redSelectionChange(Sender: TObject);
begin
  EnableActions;
end;

procedure TfrmMain.mniEditSelectAllClick(Sender: TObject);
var
  RE: TRichEdit;
begin
  RE:=ActiveEditor;
  if Assigned(RE) then RE.SelectAll;
end;

procedure TfrmMain.mniEditCopyClick(Sender: TObject);
var
  RE: TRichEdit;
begin
  RE:=ActiveEditor;
  if Assigned(RE) then RE.CopyToClipboard;
end;

end.
