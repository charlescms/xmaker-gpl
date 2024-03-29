{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvToolEdit.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 1997, 1998 Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 2001,2002 SGB Software
All Rights Reserved.

Contributers:
  Rob den Braasem [rbraasem att xs4all dott nl]
  Polaris Software
  rblaurindo
  Andreas Hausladen

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
  (rb) Move button related functionality from TJvCustomComboEdit to TJvEditButton
-----------------------------------------------------------------------------}
// $Id: JvToolEdit.pas,v 1.171 2005/03/06 23:04:10 remkobonte Exp $

unit JvToolEdit;

{$I jvcl.inc}
{$I crossplatform.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF MSWINDOWS}
  Windows, Messages,
  {$ENDIF MSWINDOWS}
  {$IFDEF VCL}
  ShlObj,
  {$ENDIF VCL}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Menus,
  Buttons, FileCtrl, Mask, ImgList, ActnList, ExtDlgs,
  {$IFDEF VisualCLX}
  Qt, QComboEdits, JvQExComboEdits, QWindows,
  {$ENDIF VisualCLX}
  JvExControls, JvSpeedButton, JvTypes, JvExMask, JvExForms, JvButton;

const
  scAltDown = scAlt + VK_DOWN;
  DefEditBtnWidth = 21;

  CM_POPUPCLOSEUP = CM_BASE + $0300; // arbitrary value

{$IFNDEF COMPILER7_UP}
// Autocomplete stuff for Delphi 5 and 6. (missing in ShlObj)
type
  IAutoComplete = interface(IUnknown)
    ['{00bb2762-6a77-11d0-a535-00c04fd7d062}']
    function Init(hwndEdit: HWND; punkACL: IUnknown;
      pwszRegKeyPath: LPCWSTR; pwszQuickComplete: LPCWSTR): HRESULT; stdcall;
    function Enable(fEnable: BOOL): HRESULT; stdcall;
  end;

const
  { IAutoComplete2 options }
  ACO_NONE = 0;
  ACO_AUTOSUGGEST = $1;
  ACO_AUTOAPPEND = $2;
  ACO_SEARCH = $4;
  ACO_FILTERPREFIXES = $8;
  ACO_USETAB = $10;
  ACO_UPDOWNKEYDROPSLIST = $20;
  ACO_RTLREADING = $40;

type
  IAutoComplete2 = interface(IAutoComplete)
    ['{EAC04BC0-3791-11d2-BB95-0060977B464C}']
    function SetOptions(dwFlag: DWORD): HRESULT; stdcall;
    function GetOptions(var dwFlag: DWORD): HRESULT; stdcall;
  end;

{$ENDIF !COMPILER7_UP}

type
  TFileExt = type string;

  TCloseUpEvent = procedure(Sender: TObject; Accept: Boolean) of object;
  TPopupAlign = (epaRight, epaLeft);

  {$IFDEF VisualCLX}
  TJvPopupWindow = class(TJvExCustomForm)
  {$ENDIF VisualCLX}
  {$IFDEF VCL}
  TJvPopupWindow = class(TJvExCustomControl)
  {$ENDIF VCL}
  private
    FEditor: TWinControl;
    FCloseUp: TCloseUpEvent;
    {$IFDEF VCL}
    procedure WMMouseActivate(var Msg: TMessage); message WM_MOUSEACTIVATE;
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    {$ENDIF VCL}
  protected
    FActiveControl: TWinControl;
    FIsFocusable: Boolean;
    {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    procedure SetParent(const Value: TWidgetControl); override;
    function WidgetFlags: Integer; override;
    {$ENDIF VisualCLX}
    function GetValue: Variant; virtual; abstract;
    procedure SetValue(const Value: Variant); virtual; abstract;
    procedure InvalidateEditor;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CloseUp(Accept: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function GetPopupText: string; virtual;
    procedure Hide;
    procedure Show(Origin: TPoint); virtual; // Polaris
    { Determines the ctrl that receives the keyboard input if the dropdown
      window is showing, but the combo edit still has focus }
    property ActiveControl: TWinControl read FActiveControl;
    { Determines whether the popup window may be activated }
    property IsFocusable: Boolean read FIsFocusable;
    property OnCloseUp: TCloseUpEvent read FCloseUp write FCloseUp;
  end;

  TJvEditButton = class(TJvImageSpeedButton)
  private
    FNoAction: Boolean;
    {$IFDEF VCL}
    procedure WMContextMenu(var Msg: TWMContextMenu); message WM_CONTEXTMENU;
    {$ENDIF VCL}
    function GetGlyph: TBitmap;
    function GetNumGlyphs: TJvNumGlyphs;
    function GetUseGlyph: Boolean;
    procedure SetGlyph(const Value: TBitmap);
    procedure SetNumGlyphs(Value: TJvNumGlyphs);
  protected
    {$IFDEF JVCLThemesEnabled}
    FDrawThemedDropDownBtn: Boolean;
    {$ENDIF JVCLThemesEnabled}
    FStandard: Boolean; // Polaris
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure PaintImage(Canvas: TCanvas; ARect: TRect; const Offset: TPoint;
      AState: TJvButtonState; DrawMark: Boolean); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;

    property UseGlyph: Boolean read GetUseGlyph;// write FDrawGlyph;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property NumGlyphs: TJvNumGlyphs read GetNumGlyphs write SetNumGlyphs;
  end;

  TGlyphKind = (gkCustom, gkDefault, gkDropDown, gkEllipsis);
  TJvImageKind = (ikCustom, ikDefault, ikDropDown, ikEllipsis);

  TJvCustomComboEdit = class;

  TJvCustomComboEditActionLink = class(TWinControlActionLink)
  protected
    function IsCaptionLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    procedure SetHint(const Value: THintString); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
    procedure SetShortCut(Value: TShortCut); override;
  end;

  TJvCustomComboEditActionLinkClass = class of TJvCustomComboEditActionLink;

  {$IFDEF VCL}
  TJvAutoCompleteOption = (acoAutoSuggest, acoAutoAppend, acoSearch,
    acoFilterPrefixes, acoUseTab, acoUpDownKeyDropsList, acoRTLReading);
  TJvAutoCompleteOptions = set of TJvAutoCompleteOption;
  TJvAutoCompleteFileOption = (acfFileSystem, acfFileSysDirs, acfURLHistory, acfURLMRU);
  TJvAutoCompleteFileOptions = set of TJvAutoCompleteFileOption;
  {$ENDIF VCL}

  {$IFDEF VCL}
  TJvCustomComboEdit = class(TJvExCustomMaskEdit)
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  TJvCustomComboEdit = class(TJvExCustomComboMaskEdit)
  {$ENDIF VisualCLX}
  private
    FOnButtonClick: TNotifyEvent;
    FOnPopupShown: TNotifyEvent;
    FOnPopupHidden: TNotifyEvent;
    FClickKey: TShortCut;
    FReadOnly: Boolean;
    FDirectInput: Boolean;
    FAlwaysEnableButton: Boolean;
    FAlwaysShowPopup: Boolean;
    FPopupAlign: TPopupAlign;
    FGroupIndex: Integer; // RDB
    FDisabledColor: TColor; // RDB
    FDisabledTextColor: TColor; // RDB
    FOnKeyDown: TKeyEvent; // RDB
    FImages: TCustomImageList;
    FImageIndex: TImageIndex;
    FImageKind: TJvImageKind;
    FNumGlyphs: Integer;
    FStreamedButtonWidth: Integer;
    FStreamedFixedWidth: Boolean;
    FOnEnabledChanged: TNotifyEvent;
    { We hide the button by setting its width to 0, thus we have to store the
      width the button should have when shown again in FSavedButtonWidth: }
    FSavedButtonWidth: Integer;
    {$IFDEF VCL}
    FAlignment: TAlignment;
    FAutoCompleteIntf: IAutoComplete;
    FAutoCompleteItems: TStrings;
    FAutoCompleteOptions: TJvAutoCompleteOptions;
    FAutoCompleteSource: IUnknown;
    procedure SetAutoCompleteItems(Strings: TStrings);
    procedure SetAutoCompleteOptions(const Value: TJvAutoCompleteOptions);
    procedure SetAlignment(Value: TAlignment);
    function GetFlat: Boolean;
    procedure ReadCtl3D(Reader: TReader);
    procedure SetFlat(const Value: Boolean);
    function IsFlatStored: Boolean;
    {$ENDIF VCL}
    function BtnWidthStored: Boolean;
    function GetButtonFlat: Boolean;
    function GetButtonHint: string;
    function GetButtonWidth: Integer;
    function GetDirectInput: Boolean;
    function GetGlyph: TBitmap;
    function GetGlyphKind: TGlyphKind;
    function GetMinHeight: Integer;
    function GetNumGlyphs: TNumGlyphs;
    function GetPopupVisible: Boolean;
    function GetShowButton: Boolean;
    function GetTextHeight: Integer;
    function IsImageIndexStored: Boolean;
    function IsCustomGlyph: Boolean;
    procedure EditButtonClick(Sender: TObject);
    procedure ReadGlyphKind(Reader: TReader);
    procedure RecreateGlyph;
    procedure SetButtonFlat(const Value: Boolean);
    procedure SetButtonHint(const Value: string);
    procedure SetButtonWidth(Value: Integer);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphKind(Value: TGlyphKind);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetImageKind(const Value: TJvImageKind);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetNumGlyphs(const Value: TNumGlyphs);
    procedure SetShowButton(const Value: Boolean);
    {$IFDEF COMPILER6_UP}
    procedure UpdateBtnBounds(var NewLeft, NewTop, NewWidth, NewHeight: Integer);
    {$ENDIF COMPILER6_UP}
    { (rb) renamed from UpdateEdit }
    procedure UpdateGroup; // RDB
    {$IFDEF VCL}
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CMBiDiModeChanged(var Msg: TMessage); message CM_BIDIMODECHANGED;
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Msg: TMessage); message CM_CTL3DCHANGED;
    procedure CNCtlColor(var Msg: TMessage); message CN_CTLCOLOREDIT;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT; // RDB
    procedure CMPopupCloseup(var Msg: TMessage); message CM_POPUPCLOSEUP;
    {$IFDEF JVCLThemesEnabled}
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    {$ENDIF JVCLThemesEnabled}
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    {$ENDIF VCL}
  protected
    FButton: TJvEditButton; // Polaris
    FBtnControl: TWinControl;
    FPopupVisible: Boolean; // Polaris
    FFocused: Boolean; // Polaris
    FPopup: TWinControl;
    {$IFDEF COMPILER6_UP}
    {$IFDEF VCL}
    procedure CustomAlignPosition(Control: TControl; var NewLeft, NewTop, NewWidth,
      NewHeight: Integer; var AlignRect: TRect; AlignInfo: TAlignInfo); override;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    procedure CustomAlignPosition(Control: TControl; var NewLeft,
      NewTop, NewWidth, NewHeight: Integer; var AlignRect: TRect); override;
    {$ENDIF VisualCLX}
    {$ENDIF COMPILER6_UP}
    {$IFDEF VCL}
    procedure WndProc(var Msg: TMessage); override;
    {$ENDIF VCL}
    procedure WMClear(var Msg: TMessage); message WM_CLEAR;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure AdjustSize; override;
    procedure FocusKilled(NextWnd: HWND); override;
    procedure FocusSet(PrevWnd: HWND); override;
    procedure EnabledChanged; override;
    procedure FontChanged; override;
    procedure DoEnter; override;
    procedure DoCtl3DChanged; virtual;
    function DoEraseBackground(Canvas: TCanvas; Param: Integer): Boolean; override;
    { Repositions the child controls; checkbox }
    procedure UpdateControls; virtual;
    { Updates the margins of the edit box }
    procedure UpdateMargins; dynamic;
    { Returns the margins of the edit box }
    procedure GetInternalMargins(var ALeft, ARight: Integer); virtual;
    procedure CreatePopup; virtual;
    procedure HidePopup; virtual; // (ahuser): WARNING: Do not release or free the component in HidePopup -> else AV in MouseUp
    procedure ShowPopup(Origin: TPoint); virtual;
    {$IFDEF VisualCLX}
    procedure DoFlatChanged; override;
    procedure Paint; override;
    {$ENDIF VisualCLX}
    function AcceptPopup(var Value: Variant): Boolean; virtual;
    function EditCanModify: Boolean; override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    function GetPopupValue: Variant; virtual;
    function GetReadOnly: Boolean; virtual;
    function GetSettingCursor: Boolean;
    procedure AcceptValue(const Value: Variant); virtual;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure AdjustHeight;
    procedure ButtonClick; dynamic;
    procedure Change; override;
    procedure CreateWnd; override;
    {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateAutoComplete; virtual;
    procedure UpdateAutoComplete; virtual;
    function GetAutoCompleteSource: IUnknown; virtual;
    {$ENDIF VCL}
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoChange; virtual; //virtual Polaris
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure LocalKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); // RDB
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PopupChange; virtual;
    procedure PopupCloseUp(Sender: TObject; Accept: Boolean); virtual; //virtual Polaris
    procedure AsyncPopupCloseUp(Accept: Boolean); virtual;
    procedure PopupDropDown(DisableEdit: Boolean); virtual;
    procedure SetClipboardCommands(const Value: TJvClipboardCommands); override; // RDB
    procedure SetDirectInput(Value: Boolean); // Polaris
    procedure SetDisabledColor(const Value: TColor); virtual; // RDB
    procedure SetDisabledTextColor(const Value: TColor); virtual; // RDB
    procedure SetGroupIndex(const Value: Integer); // RDB
    procedure SetPopupValue(const Value: Variant); virtual;
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetShowCaret; // Polaris
    procedure UpdatePopupVisible;
    {$IFDEF VCL}
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    property Alignment;
    {$ENDIF VisualCLX}
    property AlwaysEnableButton: Boolean read FAlwaysEnableButton write FAlwaysEnableButton default False;
    property AlwaysShowPopup: Boolean read FAlwaysShowPopup write FAlwaysShowPopup default False;
    {$IFDEF VCL}
    property AutoCompleteItems: TStrings read FAutoCompleteItems write SetAutoCompleteItems;
    property AutoCompleteOptions: TJvAutoCompleteOptions read FAutoCompleteOptions write SetAutoCompleteOptions default [];
    {$ENDIF VCL}
    property Button: TJvEditButton read FButton;
    property ButtonFlat: Boolean read GetButtonFlat write SetButtonFlat default False;
    property ButtonHint: string read GetButtonHint write SetButtonHint;
    property ButtonWidth: Integer read GetButtonWidth write SetButtonWidth stored BtnWidthStored;
    property ClickKey: TShortCut read FClickKey write FClickKey default scAltDown;
    property DirectInput: Boolean read GetDirectInput write SetDirectInput default True;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor default clWindow; // RDB
    property DisabledTextColor: TColor read FDisabledTextColor write SetDisabledTextColor default clGrayText; // RDB
    {$IFDEF VCL}
    property Flat: Boolean read GetFlat write SetFlat {$IFDEF VisualCLX}default False;{$ENDIF VisualCLX}{$IFDEF VCL}stored IsFlatStored;{$ENDIF VCL}
    {$ENDIF VCL}
    property Glyph: TBitmap read GetGlyph write SetGlyph stored IsCustomGlyph;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default -1;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored default -1;
    property ImageKind: TJvImageKind read FImageKind write SetImageKind default ikCustom;
    property Images: TCustomImageList read FImages write SetImages;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property PopupAlign: TPopupAlign read FPopupAlign write FPopupAlign default epaRight;
    property PopupVisible: Boolean read GetPopupVisible;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SettingCursor: Boolean read GetSettingCursor;
    property ShowButton: Boolean read GetShowButton write SetShowButton default True;
    property OnEnabledChanged: TNotifyEvent read FOnEnabledChanged write FOnEnabledChanged;
    property OnPopupShown: TNotifyEvent read FOnPopupShown write FOnPopupShown;
    property OnPopupHidden: TNotifyEvent read FOnPopupHidden write FOnPopupHidden;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function DefaultImageIndex: TImageIndex; virtual;
    class function DefaultImages: TCustomImageList; virtual;
    procedure DoClick;
    procedure SelectAll;
    {$IFDEF VisualCLX}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    {$ENDIF VisualCLX}
    { Backwards compatibility; moved to public&published; eventually remove }
    property GlyphKind: TGlyphKind read GetGlyphKind write SetGlyphKind;
    {$IFDEF VCL}
    property Ctl3D;
    {$ENDIF VCL}
  end;

  TJvComboEdit = class(TJvCustomComboEdit)
  public
    property Button;
  published
    //Polaris
    property Action;
    property Align;
    property Alignment;
    property AlwaysEnableButton;
    property AlwaysShowPopup;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    {$IFDEF VCL}
    property AutoCompleteItems;
    property AutoCompleteOptions;
    property BiDiMode;
    property DragCursor;
    property DragKind;
    property Flat;
    property ImeMode;
    property ImeName;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentCtl3D;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property BorderStyle;
    property ButtonFlat;
    property ButtonHint;
    property ButtonWidth;
    property CharCase;
    property ClickKey;
    property ClipboardCommands; // RDB
    property Color;
    property Constraints;
    property DirectInput;
    property DisabledColor; // RDB
    property DisabledTextColor; // RDB
    property DragMode;
    property EditMask;
    property Enabled;
    property Font;
    property Glyph;
    property HideSelection;
    property ImageIndex;
    property ImageKind;
    property Images;
    property MaxLength;
    property NumGlyphs;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowButton;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown; // RDB
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  { TJvFileDirEdit }
  { The common parent of TJvFilenameEdit and TJvDirectoryEdit      }
  { For internal use only; it's not intended to be used separately }

type
  TExecOpenDialogEvent = procedure(Sender: TObject; var Name: string;
    var Action: Boolean) of object;

  TJvFileDirEdit = class(TJvCustomComboEdit)
  private
    FErrMode: Cardinal;
    FMultipleDirs: Boolean;
    FOnDropFiles: TNotifyEvent;
    FOnBeforeDialog: TExecOpenDialogEvent;
    FOnAfterDialog: TExecOpenDialogEvent;
    {$IFDEF VCL}
    FAcceptFiles: Boolean;
    FMRUList: IUnknown;
    FHistoryList: IUnknown;
    FFileSystemList: IUnknown;
    FAutoCompleteFileOptions: TJvAutoCompleteFileOptions;
    FAutoCompleteSourceIntf: IUnknown;
    procedure SetAutoCompleteFileOptions(const Value: TJvAutoCompleteFileOptions);
    procedure SetDragAccept(Value: Boolean);
    procedure SetAcceptFiles(Value: Boolean);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    {$IFDEF JVCLThemesEnabled}
    procedure CMSysColorChange(var Msg: TMessage); message CM_SYSCOLORCHANGE;
    {$ENDIF JVCLThemesEnabled}
    {$ENDIF VCL}
  protected
    {$IFDEF VCL}
    procedure CreateHandle; override;
    procedure DestroyWindowHandle; override;
    procedure UpdateAutoComplete; override;
    function GetAutoCompleteSource: IUnknown; override;
    {$ENDIF VCL}
    function GetLongName: string; virtual; abstract;
    function GetShortName: string; virtual; abstract;
    procedure DoAfterDialog(var FileName: string; var Action: Boolean); dynamic;
    procedure DoBeforeDialog(var FileName: string; var Action: Boolean); dynamic;
    procedure ReceptFileDir(const AFileName: string); virtual; abstract;
    procedure ClearFileList; virtual;
    procedure Change; override;
    procedure DisableSysErrors;
    procedure EnableSysErrors;
    {$IFDEF VCL}
    property AutoCompleteFileOptions: TJvAutoCompleteFileOptions read FAutoCompleteFileOptions write
      SetAutoCompleteFileOptions;
    property AutoCompleteOptions default [acoAutoSuggest];
    {$ENDIF VCL}
    property ImageKind default ikDefault;
    property MaxLength;
  public
    constructor Create(AOwner: TComponent); override;
    property LongName: string read GetLongName;
    property ShortName: string read GetShortName;
  published
    {$IFDEF VCL}
    property AcceptFiles: Boolean read FAcceptFiles write SetAcceptFiles default True;
    {$ENDIF VCL}
    property OnBeforeDialog: TExecOpenDialogEvent read FOnBeforeDialog
      write FOnBeforeDialog;
    property OnAfterDialog: TExecOpenDialogEvent read FOnAfterDialog
      write FOnAfterDialog;
    property OnDropFiles: TNotifyEvent read FOnDropFiles write FOnDropFiles;
    property OnButtonClick;
    property ClipboardCommands; // RDB
    property DisabledTextColor; // RDB
    property DisabledColor; // RDB
  end;

  TFileDialogKind = (dkOpen, dkSave, dkOpenPicture, dkSavePicture);

  TJvFilenameEdit = class(TJvFileDirEdit)
  private
    FDialog: TOpenDialog;
    FDialogKind: TFileDialogKind;
    FAddQuotes: Boolean;
    procedure CreateEditDialog;
    function GetFileName: TFileName;
    function GetDefaultExt: TFileExt;
    {$IFDEF VCL}
    function GetFileEditStyle: TFileEditStyle;
    {$ENDIF VCL}
    function GetFilter: string;
    function GetFilterIndex: Integer;
    function GetInitialDir: string;
    function GetHistoryList: TStrings;
    function GetOptions: TOpenOptions;
    function GetDialogTitle: string;
    function GetDialogFiles: TStrings;
    procedure SetDialogKind(Value: TFileDialogKind);
    procedure SetFileName(const Value: TFileName);
    procedure SetDefaultExt(Value: TFileExt);
    {$IFDEF VCL}
    procedure SetFileEditStyle(Value: TFileEditStyle);
    {$ENDIF VCL}
    procedure SetFilter(const Value: string);
    procedure SetFilterIndex(Value: Integer);
    procedure SetInitialDir(const Value: string);
    procedure SetHistoryList(Value: TStrings);
    procedure SetOptions(Value: TOpenOptions);
    procedure SetDialogTitle(const Value: string);
    function IsCustomTitle: Boolean;
    function IsCustomFilter: Boolean;
  protected
    procedure PopupDropDown(DisableEdit: Boolean); override;
    procedure ReceptFileDir(const AFileName: string); override;
    procedure ClearFileList; override;
    function GetLongName: string; override;
    function GetShortName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function DefaultImageIndex: TImageIndex; override;
    property Dialog: TOpenDialog read FDialog;
    property DialogFiles: TStrings read GetDialogFiles;
  published
    //Polaris
    property Action;
    property Align;
    property AutoSize;
    property AddQuotes: Boolean read FAddQuotes write FAddQuotes default True;
    property DialogKind: TFileDialogKind read FDialogKind write SetDialogKind
      default dkOpen;
    property DefaultExt: TFileExt read GetDefaultExt write SetDefaultExt;
    {$IFDEF VCL}
    property AutoCompleteOptions;
    property AutoCompleteFileOptions default [acfFileSystem];
    property Flat;
    property ParentCtl3D;
    { (rb) Obsolete; added 'stored False', eventually remove }
    property FileEditStyle: TFileEditStyle read GetFileEditStyle write SetFileEditStyle stored False;
    {$ENDIF VCL}
    property FileName: TFileName read GetFileName write SetFileName stored False;
    property Filter: string read GetFilter write SetFilter stored IsCustomFilter;
    property FilterIndex: Integer read GetFilterIndex write SetFilterIndex default 1;
    property InitialDir: string read GetInitialDir write SetInitialDir;
    { (rb) Obsolete; added 'stored False', eventually remove }
    property HistoryList: TStrings read GetHistoryList write SetHistoryList stored False;
    property DialogOptions: TOpenOptions read GetOptions write SetOptions
      default [ofHideReadOnly];
    property DialogTitle: string read GetDialogTitle write SetDialogTitle
      stored IsCustomTitle;
    property AutoSelect;
    property ButtonHint;
    property ButtonFlat;
    property BorderStyle;
    property CharCase;
    property ClickKey;
    property Color;
    property DirectInput;
    {$IFDEF VCL}
    property DragCursor;
    property BiDiMode;
    property DragKind;
    property ParentBiDiMode;
    property ImeMode;
    property ImeName;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property DragMode;
    property EditMask;
    property Enabled;
    property Font;
    property Glyph;
    property GroupIndex;
    property ImageIndex;
    property Images;
    property ImageKind;
    property NumGlyphs;
    property ButtonWidth;
    property HideSelection;
    property Anchors;
    property Constraints;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowButton;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
  end;

  TDirDialogKind = (dkVCL, dkWin32);

  TJvDirectoryEdit = class(TJvFileDirEdit)
  private
    {$IFDEF VCL}
    FOptions: TSelectDirOpts;
    {$ENDIF VCL}
    FInitialDir: string;
    FDialogText: string;
    FDialogKind: TDirDialogKind;
  protected
    FMultipleDirs: Boolean; // Polaris (???)
    procedure PopupDropDown(DisableEdit: Boolean); override;
    procedure ReceptFileDir(const AFileName: string); override;
    function GetLongName: string; override;
    function GetShortName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function DefaultImageIndex: TImageIndex; override;
  published
    //Polaris
    property Action;
    property Align;
    property AutoSize;
    property DialogKind: TDirDialogKind read FDialogKind write FDialogKind default dkVCL;
    property DialogText: string read FDialogText write FDialogText;
    {$IFDEF VCL}
    property AutoCompleteOptions;
    property AutoCompleteFileOptions default [acfFileSystem, acfFileSysDirs];
    property Flat;
    property ParentCtl3D;
    property DialogOptions: TSelectDirOpts read FOptions write FOptions default [sdAllowCreate];
    {$ENDIF VCL}
    property InitialDir: string read FInitialDir write FInitialDir;
    property MultipleDirs: Boolean read FMultipleDirs write FMultipleDirs default False;
    property AutoSelect;
    property ButtonHint;
    property ButtonFlat;
    property BorderStyle;
    property CharCase;
    property ClickKey;
    property Color;
    property DirectInput;
    {$IFDEF VCL}
    property DragCursor;
    property BiDiMode;
    property ParentBiDiMode;
    property ImeMode;
    property ImeName;
    property DragKind;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property DragMode;
    property EditMask;
    property Enabled;
    property Font;
    property Glyph;
    property GroupIndex;
    property ImageIndex;
    property Images;
    property ImageKind;
    property NumGlyphs;
    property ButtonWidth;
    property HideSelection;
    property Anchors;
    property Constraints;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowButton;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
  end;

  TCalendarStyle = (csPopup, csDialog);
  TYearDigits = (dyDefault, dyFour, dyTwo);

const
  {$IFDEF DEFAULT_POPUP_CALENDAR}
  dcsDefault = csPopup;
  {$ELSE}
  dcsDefault = csDialog;
  {$ENDIF DEFAULT_POPUP_CALENDAR}

type
  TExecDateDialog = procedure(Sender: TObject; var ADate: TDateTime;
    var Action: Boolean) of object;
  TJvInvalidDateEvent = procedure(Sender: TObject; const DateString: string;
    var NewDate: TDateTime; var Accept: Boolean) of object;

  TJvCustomDateEdit = class(TJvCustomComboEdit)
  private
    FMinDate: TDateTime; // Polaris
    FMaxDate: TDateTime; // Polaris
    FTitle: string;
    FOnAcceptDate: TExecDateDialog;
    FOnInvalidDate: TJvInvalidDateEvent;
    FDefaultToday: Boolean;
    FPopupColor: TColor;
    FCheckOnExit: Boolean;
    FBlanksChar: Char;
    FCalendarHints: TStringList;
    FStartOfWeek: TDayOfWeekName;
    FWeekends: TDaysOfWeek;
    FWeekendColor: TColor;
    FYearDigits: TYearDigits;
    FDateFormat: string[10];
    FFormatting: Boolean;
    // Polaris
    procedure SetMinDate(Value: TDateTime);
    procedure SetMaxDate(Value: TDateTime);
    // Polaris
    function GetDate: TDateTime;
    procedure SetYearDigits(Value: TYearDigits);
    function GetPopupColor: TColor;
    procedure SetPopupColor(Value: TColor);
    function GetDialogTitle: string;
    procedure SetDialogTitle(const Value: string);
    function IsCustomTitle: Boolean;
    function IsDateStored: Boolean;
    function GetCalendarStyle: TCalendarStyle;
    procedure SetCalendarStyle(Value: TCalendarStyle);
    function GetCalendarHints: TStrings;
    procedure SetCalendarHints(Value: TStrings);
    procedure CalendarHintsChanged(Sender: TObject);
    procedure SetWeekendColor(Value: TColor);
    procedure SetWeekends(Value: TDaysOfWeek);
    procedure SetStartOfWeek(Value: TDayOfWeekName);
    procedure SetBlanksChar(Value: Char);
    function TextStored: Boolean;
    // Polaris
    function StoreMinDate: Boolean;
    function StoreMaxDate: Boolean;
    // Polaris
    function FourDigitYear: Boolean;
    {$IFDEF VCL}
    procedure WMContextMenu(var Msg: TWMContextMenu); message WM_CONTEXTMENU;
    {$ENDIF VCL}
  protected
    // Polaris
    FDateAutoBetween: Boolean;
    procedure SetDate(Value: TDateTime); virtual;
    function DoInvalidDate(const DateString: string; var ANewDate: TDateTime): Boolean; virtual;
    procedure SetDateAutoBetween(Value: Boolean); virtual;
    procedure TestDateBetween(var Value: TDateTime); virtual;
    // Polaris
    procedure DoExit; override;
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    {$IFDEF VCL}
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    procedure CreateWidget; override;
    {$ENDIF VisualCLX}
    function AcceptPopup(var Value: Variant): Boolean; override;
    procedure AcceptValue(const Value: Variant); override;
    procedure SetPopupValue(const Value: Variant); override;
    function GetDateFormat: string;
    procedure ApplyDate(Value: TDateTime); virtual;
    procedure UpdateFormat;
    procedure UpdatePopup;
    procedure PopupDropDown(DisableEdit: Boolean); override;
    property BlanksChar: Char read FBlanksChar write SetBlanksChar default ' ';
    property CalendarHints: TStrings read GetCalendarHints write SetCalendarHints;
    property CheckOnExit: Boolean read FCheckOnExit write FCheckOnExit default False;
    property DefaultToday: Boolean read FDefaultToday write FDefaultToday default False;
    property DialogTitle: string read GetDialogTitle write SetDialogTitle stored IsCustomTitle;
    property EditMask stored False;
    property Formatting: Boolean read FFormatting;
    property ImageKind default ikDefault;
    property PopupColor: TColor read GetPopupColor write SetPopupColor default clMenu;
    property CalendarStyle: TCalendarStyle read GetCalendarStyle
      write SetCalendarStyle default dcsDefault;
    property StartOfWeek: TDayOfWeekName read FStartOfWeek write SetStartOfWeek default Mon;
    property Weekends: TDaysOfWeek read FWeekends write SetWeekends default [Sun];
    property WeekendColor: TColor read FWeekendColor write SetWeekendColor default clRed;
    property YearDigits: TYearDigits read FYearDigits write SetYearDigits default dyDefault;
    property OnAcceptDate: TExecDateDialog read FOnAcceptDate write FOnAcceptDate;
    property OnInvalidDate: TJvInvalidDateEvent read FOnInvalidDate write FOnInvalidDate;
    property MaxLength stored False;
    { Text is already stored via Date property }
    property Text stored False;
  public
    // Polaris
    property DateAutoBetween: Boolean read FDateAutoBetween write SetDateAutoBetween default True;
    property MinDate: TDateTime read FMinDate write SetMinDate stored StoreMinDate;
    property MaxDate: TDateTime read FMaxDate write SetMaxDate stored StoreMaxDate;
    procedure ValidateEdit; override;
    // Polaris
    constructor Create(AOwner: TComponent); override;
    class function DefaultImageIndex: TImageIndex; override;
    destructor Destroy; override;
    procedure CheckValidDate;
    function GetDateMask: string;
    procedure UpdateMask; virtual;
    property Date: TDateTime read GetDate write SetDate stored IsDateStored;
    property PopupVisible;
  end;

  TJvDateEdit = class(TJvCustomDateEdit)
    // Polaris
  protected
    procedure SetDate(Value: TDateTime); override;
    // Polaris
  public
    constructor Create(AOwner: TComponent); override;
    property EditMask;
  published
    property Date;
    property DateAutoBetween; // Polaris
    property MinDate; // Polaris
    property MaxDate; // Polaris
    property Align; // Polaris
    property Action;
    property AutoSelect;
    property AutoSize;
    property BlanksChar;
    property BorderStyle;
    property ButtonHint;
    property ButtonFlat;
    property CalendarHints;
    property CheckOnExit;
    property ClickKey;
    property Color;
    property DefaultToday;
    property DialogTitle;
    property DirectInput;
    {$IFDEF VCL}
    property DragCursor;
    property BiDiMode;
    property DragKind;
    property Flat;
    property ParentBiDiMode;
    property ParentCtl3D;
    property ImeMode;
    property ImeName;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF VCL}
    property DragMode;
    property Enabled;
    property Font;
    property Glyph;
    property GroupIndex;
    property ImageIndex;
    property Images;
    property ImageKind;
    property NumGlyphs;
    property ButtonWidth;
    property HideSelection;
    property Anchors;
    property Constraints;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupAlign;
    property PopupColor;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowButton;
    property CalendarStyle;
    property StartOfWeek;
    property Weekends;
    property WeekendColor;
    property YearDigits;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnAcceptDate;
    property OnInvalidDate;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
    property ClipboardCommands; // RDB
    property DisabledTextColor; // RDB
    property DisabledColor; // RDB
    property OnKeyDown; // RDB
  end;

  EComboEditError = class(EJVCLException);

{ Utility routines }

procedure DateFormatChanged;

function EditorTextMargins(Editor: TCustomEdit): TPoint;
{$IFDEF VCL}
function PaintComboEdit(Editor: TJvCustomComboEdit; const AText: string;
  AAlignment: TAlignment; StandardPaint: Boolean;
  var ACanvas: TControlCanvas; var Msg: TWMPaint): Boolean;
function PaintEdit(Editor: TCustomEdit; const AText: string;
  AAlignment: TAlignment; PopupVisible: Boolean;
  DisabledTextColor: TColor; StandardPaint: Boolean;
  var ACanvas: TControlCanvas; var Msg: TWMPaint): Boolean;
{$ENDIF VCL}
{$IFDEF VisualCLX}
function PaintComboEdit(Editor: TJvCustomComboEdit; const AText: string;
  AAlignment: TAlignment; StandardPaint: Boolean; Flat: Boolean;
  ACanvas: TCanvas): Boolean;
{ PaintEdit (CLX) needs an implemented EM_GETRECT message handler or a
  TCustomComboEdit/TCustomComboMask class. If no EM_GETTEXT handler exists or
  the class is derived from another class, it uses the ClientRect of the edit
  control. }
function PaintEdit(Editor: TCustomEdit; const AText: WideString;
  AAlignment: TAlignment; PopupVisible: Boolean; 
  DisabledTextColor: TColor; StandardPaint: Boolean; Flat: Boolean;
  ACanvas: TCanvas): Boolean;
{$ENDIF VisualCLX}

{$IFDEF VisualCLX}
const
  OBM_COMBO = 1;
{$ENDIF VisualCLX}

function LoadDefaultBitmap(Bmp: TBitmap; Item: Integer): Boolean;

function IsInWordArray(Value: Word; const A: array of Word): Boolean;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvToolEdit.pas,v $';
    Revision: '$Revision: 1.171 $';
    Date: '$Date: 2005/03/06 23:04:10 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  {$IFDEF HAS_UNIT_RTLCONSTS}
  RTLConsts,
  {$ENDIF HAS_UNIT_RTLCONSTS}
  Math, Consts,
  {$IFDEF COMPILER6_UP}
  MaskUtils,
  {$ENDIF COMPILER6_UP}
  {$IFDEF MSWINDOWS}
  ShellAPI, ActiveX,
  {$ENDIF MSWINDOWS}
  {$IFDEF VCL}
  MultiMon,
  JvBrowseFolder,
  {$ENDIF VCL}
  JvPickDate, JvJCLUtils, JvJVCLUtils,
  JvThemes, JvResources, JvConsts;

{$IFDEF MSWINDOWS}
{$R ..\Resources\JvToolEdit.res}
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
{$R ../Resources/JvToolEdit.res}
{$ENDIF UNIX}

type
  TCustomEditAccessProtected = class(TCustomEdit);
  TCustomFormAccessProtected = class(TCustomForm);
  TWinControlAccessProtected = class(TWinControl);

  {$HINTS OFF}
  TCustomMaskEditAccessPrivate = class(TCustomEdit)
  private
    // Do not remove these fields, although they are not used.
    {$IFDEF COMPILER6_UP}
    FEditMask: TEditMask;
    {$ELSE}
    FEditMask: string;
    {$ENDIF COMPILER6_UP}
    FMaskBlank: Char;
    FMaxChars: Integer;
    FMaskSave: Boolean;
    FMaskState: TMaskedState;
    FCaretPos: Integer;
    FBtnDownX: Integer;
    FOldValue: string;
    FSettingCursor: Boolean;
  end;
  {$HINTS ON}

const
  sDirBmp = 'JvDirectoryEditGLYPH';    { Directory editor button glyph }
  sFileBmp = 'JvFilenameEditGLYPH';    { Filename editor button glyph }
  sDateBmp = 'JvCustomDateEditGLYPH';  { Date editor button glyph }

  {$IFDEF JVCLThemesEnabled}
  // (rb) should/can these be put in a separate resource file?
  sDirXPBmp = 'JvDirectoryEditXPGLYPH';
  sFileXPBmp = 'JvFilenameEditXPGLYPH';
  {$ENDIF JVCLThemesEnabled}

{$IFDEF VCL}

const
  ACLO_NONE            = 0;   // don't enumerate anything
  ACLO_CURRENTDIR      = 1;   // enumerate current directory
  ACLO_MYCOMPUTER      = 2;   // enumerate MyComputer
  ACLO_DESKTOP         = 4;   // enumerate Desktop Folder
  ACLO_FAVORITES       = 8;   // enumerate Favorites Folder
  ACLO_FILESYSONLY     = 16;  // enumerate only the file system
  ACLO_FILESYSDIRS     = 32;  // enumerate only the file system dirs, UNC shares, and UNC servers.

  //IID_IAutoCompList: TGUID = (D1:$00BB2760; D2:$6A77; D3:$11D0; D4:($A5, $35, $00, $C0, $4F, $D7, $D0, $62));
  //IID_IObjMgr: TGUID = (D1:$00BB2761; D2:$6A77; D3:$11D0; D4:($A5, $35, $00, $C0, $4F, $D7, $D0, $62));
  //IID_IACList: TGUID = (D1:$77A130B0; D2:$94FD; D3:$11D0; D4:($A5, $44, $00, $C0, $4F, $D7, $d0, $62));
  //IID_IACList2: TGUID = (D1:$470141a0; D2:$5186; D3:$11d2; D4:($bb, $b6, $00, $60, $97, $7b, $46, $4c));
  //IID_ICurrentWorkingDirectory: TGUID = (D1:$91956d21; D2:$9276; D3:$11d1; D4:($92, $1a, $00, $60, $97, $df, $5b, $d4));  // {91956D21-9276-11d1-921A-006097DF5BD));

  CLSID_AutoComplete: TGUID = (D1:$00BB2763; D2:$6A77; D3:$11D0; D4:($A5, $35, $00, $C0, $4F, $D7, $D0, $62));
  CLSID_ACLHistory: TGUID = (D1:$00BB2764; D2:$6A77; D3:$11D0; D4:($A5, $35, $00, $C0, $4F, $D7, $D0, $62));
  CLSID_ACListISF: TGUID = (D1:$03C036F1; D2:$A186; D3:$11D0; D4:($82, $4A, $00, $AA, $00, $5B, $43, $83));
  CLSID_ACLMRU: TGUID = (D1:$6756a641; D2:$de71; D3:$11d0; D4:($83, $1b, $0, $aa, $0, $5b, $43, $83));  // {6756A641-DE71-11d0-831B-00AA005B438));
  CLSID_ACLMulti: TGUID = (D1:$00BB2765; D2:$6A77; D3:$11D0; D4:($A5, $35, $00, $C0, $4F, $D7, $D0, $62));

  //#if (_WIN32_IE >= 0x0600)
  //CLSID_ACLCustomMRU: TGUID = (D1:$6935db93; D2:$21e8; D3:$4ccc; D4:($be, $b9, $9f, $e3, $c7, $7a, $29, $7a));
  //#endif

type
  IACList = interface(IUnknown)
    ['{77A130B0-94FD-11D0-A544-00C04FD7d062}']
    function Expand(pszExpand: POleStr): HRESULT; stdcall;
  end;

  IACList2 = interface(IACList)
    ['{470141a0-5186-11d2-bbb6-0060977b464c}']
    function SetOptions(dwFlag: DWORD): HRESULT; stdcall;
    function GetOptions(var pdwFlag: DWORD): HRESULT; stdcall;
  end;

  IObjMgr = interface(IUnknown)
    ['{00BB2761-6A77-11D0-a535-00c04fd7d062}']
    function Append(punk: IUnknown): HRESULT; stdcall;
    function Remove(punk: IUnknown): HRESULT; stdcall;
  end;

  TAutoCompleteSource = class(TInterfacedObject, IEnumString)
  private
    FComboEdit: TJvCustomComboEdit;
    FCurrentIndex: Integer;
  protected
    { IEnumString }
    function Next(celt: Longint; out elt;
      pceltFetched: PLongint): HRESULT; stdcall;
    function Skip(celt: Longint): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
    function Clone(out enm: IEnumString): HRESULT; stdcall;
  public
    constructor Create(AComboEdit: TJvCustomComboEdit; const StartIndex: Integer); virtual;
  end;

type
  { TDateHook is used to only have 1 hook per application for monitoring
    date changes;

    We can't use WM_WININICHANGE or CM_WININICHANGE in the controls
    itself, because it comes too early. (The Application object does the
    changing on receiving WM_WININICHANGE; The Application object receives it
    later than the forms, controls etc.
  }

  TDateHook = class(TObject)
  private
    FCount: Integer;
    FHooked: Boolean;
    FWinIniChangeReceived: Boolean;
  protected
    function FormatSettingsChange(var Msg: TMessage): Boolean;
    procedure Hook;
    procedure UnHook;
  public
    procedure Add;
    procedure Delete;
  end;

var
  GDateHook: TDateHook = nil;

{$ENDIF VCL}

var
  GDateImageIndex: TImageIndex = -1;
  GDefaultComboEditImagesList: TImageList = nil;
  GDirImageIndex: TImageIndex = -1;
  GFileImageIndex: TImageIndex = -1;
  {$IFDEF JVCLThemesEnabled}
  GDirImageIndexXP: TImageIndex = -1;
  GFileImageIndexXP: TImageIndex = -1;
  {$ENDIF JVCLThemesEnabled}

//=== Local procedures =======================================================

{$IFDEF VCL}

function FindMonitor(Handle: HMONITOR): TMonitor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[I].Handle = Handle then
    begin
      Result := Screen.Monitors[I];
      Break;
    end;
end;

function DateHook: TDateHook;
begin
  if GDateHook = nil then
    GDateHook := TDateHook.Create;
  Result := GDateHook;
end;

{$ENDIF VCL}

function ClipFilename(const FileName: string): string;
var
  Params: string;
begin
  if FileExists(FileName) then
    Result := FileName
  else
  if DirectoryExists(FileName) then
    Result := IncludeTrailingPathDelimiter(FileName)
  else
    SplitCommandLine(FileName, Result, Params);
end;

function ExtFilename(const FileName: string): string;
begin
  if (Pos(' ', FileName) > 0) and (FileName[1] <> '"') then
    Result := Format('"%s"', [FileName])
  else
    Result := FileName;
end;

function NvlDate(DateValue, DefaultValue: TDateTime): TDateTime;
begin
  if DateValue = NullDate then
    Result := DefaultValue
  else
    Result := DateValue;
end;

{$IFDEF VisualCLX}

procedure DrawSelectedText(Canvas: TCanvas; const R: TRect; X, Y: Integer;
  const Text: WideString; SelStart, SelLength: Integer;
  HighlightColor, HighlightTextColor: TColor);
var
  W, H, Width: Integer;
  S: WideString;
  SelectionRect: TRect;
  Brush: TBrushRecall;
  PenMode: TPenMode;
  FontColor: TColor;
begin
  W := R.Right - R.Left;
  H := R.Bottom - R.Top;
  if (W <= 0) or (H <= 0) then
    Exit;

  S := Copy(Text, 1, SelStart);
  if S <> '' then
  begin
    Canvas.TextRect(R, X, Y, S);
    Inc(X, Canvas.TextWidth(S));
  end;

  S := Copy(Text, SelStart + 1, SelLength);
  if S <> '' then
  begin
    Width := Canvas.TextWidth(S);
    Brush := TBrushRecall.Create(Canvas.Brush);
    PenMode := Canvas.Pen.Mode;
    try
      SelectionRect := Rect(Max(X, R.Left), R.Top,
        Min(X + Width, R.Right), R.Bottom);
      Canvas.Pen.Mode := pmCopy;
      Canvas.Brush.Color := HighlightColor;
      Canvas.FillRect(SelectionRect);
      FontColor := Canvas.Font.Color;
      Canvas.Font.Color := HighlightTextColor;
      Canvas.TextRect(R, X, Y, S);
      Canvas.Font.Color := FontColor;
    finally
      Canvas.Pen.Mode := PenMode;
      Brush.Free;
    end;
    Inc(X, Width);
  end;

  S := Copy(Text, SelStart + SelLength + 1, MaxInt);
  if S <> '' then
    Canvas.TextRect(R, X, Y, S);
end;

{$ENDIF VisualCLX}

function ParentFormVisible(AControl: TControl): Boolean;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(AControl);
  Result := Assigned(Form) and Form.Visible;
end;

//=== Global procedures ======================================================

procedure DateFormatChanged;
var
  I: Integer;

  procedure IterateControls(AControl: TWinControl);
  var
    I: Integer;
  begin
    with AControl do
      for I := 0 to ControlCount - 1 do
      begin
        if Controls[I] is TJvCustomDateEdit then
          TJvCustomDateEdit(Controls[I]).UpdateMask
        else
        if Controls[I] is TWinControl then
          IterateControls(TWinControl(Controls[I]));
      end;
  end;

begin
  if Screen <> nil then
    for I := 0 to Screen.FormCount - 1 do
      IterateControls(Screen.Forms[I]);
end;

{$IFDEF VisualCLX}
function EditorTextMargins(Editor: TCustomEdit): TPoint;
var
  I: Integer;
  ed: TCustomEditAccessProtected;
begin
  ed := TCustomEditAccessProtected(Editor);
  if ed.BorderStyle = bsNone then
    I := 0
  else
  if Supports(Editor, IComboEditHelper) then
  begin
    if (Editor as IComboEditHelper).GetFlat then
      I := 1
    else
      I := 2;
  end
  else
    I := 2;
  {if GetWindowLong(ed.Handle, GWL_STYLE) and ES_MULTILINE = 0 then
    Result.X := (SendMessage(ed.Handle, EM_GETMARGINS, 0, 0) and $0000FFFF) + I
  else}
    Result.X := I;
  Result.Y := I;
end;
{$ENDIF VisualCLX}

{$IFDEF VCL}
function EditorTextMargins(Editor: TCustomEdit): TPoint;
var
  DC: HDC;
  I: Integer;
  SaveFont: HFONT;
  SysMetrics, Metrics: TTextMetric;
  ed: TCustomEditAccessProtected;
begin
  ed := TCustomEditAccessProtected(Editor);
  if NewStyleControls then
  begin
    if ed.BorderStyle = bsNone then
      I := 0
    else
    if ed.Ctl3D then
      I := 1
    else
      I := 2;
    if GetWindowLong(ed.Handle, GWL_STYLE) and ES_MULTILINE = 0 then
      Result.X := (SendMessage(ed.Handle, EM_GETMARGINS, 0, 0) and $0000FFFF) + I
    else
      Result.X := I;
    Result.Y := I;
  end
  else
  begin
    if ed.BorderStyle = bsNone then
      I := 0
    else
    begin
      DC := GetDC(HWND_DESKTOP);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, ed.Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(HWND_DESKTOP, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then
        I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;
{$ENDIF VCL}

function IsInWordArray(Value: Word; const A: array of Word): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to High(A) do
    if A[I] = Value then
      Exit;
  Result := False;
end;

function LoadDefaultBitmap(Bmp: TBitmap; Item: Integer): Boolean;
begin
  {$IFDEF VCL}
  Bmp.Handle := LoadBitmap(0, PChar(Item));
  Result := Bmp.Handle <> 0;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  Result := True;
  case Item of
    OBM_COMBO:
      begin
        Bmp.Width := QStyle_sliderLength(Application.Style.Handle);
        Bmp.Height := Bmp.Width;
        Bmp.Canvas.Start;
        DrawFrameControl(Bmp.Canvas.Handle, Rect(0, 0, Bmp.Width, Bmp.Height),
          DFC_SCROLL, DFCS_SCROLLDOWN);
        Bmp.Canvas.Stop;
      end;
  else
    Bmp.Width := 0;
    Bmp.Height := 0;
    Result := False;
  end;
  {$ENDIF VisualCLX}
end;

{$IFDEF VCL}

function PaintComboEdit(Editor: TJvCustomComboEdit; const AText: string;
  AAlignment: TAlignment; StandardPaint: Boolean;
  var ACanvas: TControlCanvas; var Msg: TWMPaint): Boolean;
begin
  if not (csDestroying in Editor.ComponentState) then
  begin
    Result := PaintEdit(Editor, AText, AAlignment, Editor.PopupVisible,
      Editor.FDisabledTextColor, StandardPaint, ACanvas, Msg);
  end
  else
    Result := True;
end;

{$ENDIF VCL}

{$IFDEF VisualCLX}

function PaintComboEdit(Editor: TJvCustomComboEdit; const AText: string;
  AAlignment: TAlignment; StandardPaint: Boolean; Flat: Boolean;
  ACanvas: TCanvas): Boolean;
begin
  if not (csDestroying in Editor.ComponentState) then
  begin
    Result := PaintEdit(Editor, AText, AAlignment, Editor.PopupVisible,
      Editor.FDisabledTextColor, StandardPaint, Flat, ACanvas);
  end
  else
    Result := True;
end;

{$ENDIF VisualCLX}

{$IFDEF VCL}

function PaintEdit(Editor: TCustomEdit; const AText: string;
  AAlignment: TAlignment; PopupVisible: Boolean; 
  DisabledTextColor: TColor; StandardPaint: Boolean;
  var ACanvas: TControlCanvas; var Msg: TWMPaint): Boolean;
const
  AlignStyle: array [Boolean, TAlignment] of DWORD =
    ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  LTextWidth, X: Integer;
  EditRect: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  ExStyle: DWORD;
  ed: TCustomEditAccessProtected;
begin
  Result := True;
  if csDestroying in Editor.ComponentState then
    Exit;
  ed := TCustomEditAccessProtected(Editor);
  if ed.UseRightToLeftAlignment then
    ChangeBiDiModeAlignment(AAlignment);
  if StandardPaint and not (csPaintCopy in ed.ControlState) then
  begin
    if SysLocale.MiddleEast and ed.HandleAllocated and (ed.IsRightToLeft) then
    begin { This keeps the right aligned text, right aligned }
      ExStyle := DWORD(GetWindowLong(ed.Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
        (not WS_EX_RTLREADING) and (not WS_EX_LEFTSCROLLBAR);
      if ed.UseRightToLeftReading then
        ExStyle := ExStyle or WS_EX_RTLREADING;
      if ed.UseRightToLeftScrollBar then
        ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
      ExStyle := ExStyle or
        AlignStyle[ed.UseRightToLeftAlignment, AAlignment];
      if DWORD(GetWindowLong(ed.Handle, GWL_EXSTYLE)) <> ExStyle then
        SetWindowLong(ed.Handle, GWL_EXSTYLE, ExStyle);
    end;
    Result := False;
    { return false if we need to use standard paint handler }
    Exit;
  end;
  { Since edit controls do not handle justification unless multi-line (and
    then only poorly) we will draw right and center justify manually unless
    the edit has the focus. }
  if ACanvas = nil then
  begin
    ACanvas := TControlCanvas.Create;
    ACanvas.Control := Editor;
  end;
  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(ed.Handle, PS);
  ACanvas.Handle := DC;
  try
    ACanvas.Font := ed.Font;
    with ACanvas do
    begin
      SendMessage(Editor.Handle, EM_GETRECT, 0, Integer(@EditRect));
      if not (NewStyleControls and ed.Ctl3D) and (ed.BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(ed.ClientRect);
      end;
      S := AText;
      LTextWidth := TextWidth(S);
      if PopupVisible then
        X := EditRect.Left
      else
      begin
        case AAlignment of
          taLeftJustify:
            X := EditRect.Left;
          taRightJustify:
            X := EditRect.Right - LTextWidth;
        else
          X := (EditRect.Right + EditRect.Left - LTextWidth) div 2;
        end;
      end;
      if SysLocale.MiddleEast then
        UpdateTextFlags;
      if not ed.Enabled then
      begin
        // if PS.fErase then // (p3) fErase is not set to true when control is disabled
        ed.Perform(WM_ERASEBKGND, ACanvas.Handle, 0);

        SaveDC(ACanvas.Handle);
        try
          ACanvas.Brush.Style := bsClear;
          ACanvas.Font.Color := DisabledTextColor;
          ACanvas.TextRect(EditRect, X, EditRect.Top, S);
        finally
          RestoreDC(ACanvas.Handle, -1);
        end;
      end
      else
      begin
        Brush.Color := ed.Color;
        ACanvas.TextRect(EditRect, X, EditRect.Top, S);
      end;
    end;
  finally
    ACanvas.Handle := 0;
    if Msg.DC = 0 then
      EndPaint(ed.Handle, PS);
  end;
end;

{$ENDIF VCL}

{$IFDEF VisualCLX}

{ PaintEdit (CLX) needs an implemented EM_GETRECT message handler. If no
  EM_GETTEXT handler exists or the edit control does not implement
  IComboEditHelper, it uses the ClientRect of the edit control. }

function PaintEdit(Editor: TCustomEdit; const AText: WideString;
  AAlignment: TAlignment; PopupVisible: Boolean;
  DisabledTextColor: TColor; StandardPaint: Boolean; Flat: Boolean;
  ACanvas: TCanvas): Boolean;
var
  LTextWidth, X: Integer;
  EditRect: TRect;
  S: WideString;
  ed: TCustomEditAccessProtected;
  SavedFont: TFontRecall;
  SavedBrush: TBrushRecall;
  Offset: Integer;
  R: TRect;
  EditHelperIntf: IComboEditHelper;
begin
  Result := True;
  if csDestroying in Editor.ComponentState then
    Exit;
  ed := TCustomEditAccessProtected(Editor);
  if StandardPaint and not (csPaintCopy in ed.ControlState) then
  begin
    Result := False;
    { return false if we need to use standard paint handler }
    Exit;
  end;
  SavedFont := TFontRecall.Create(ACanvas.Font);
  SavedBrush := TBrushRecall.Create(ACanvas.Brush);
  try
    ACanvas.Font := ed.Font;

    // paint Border
    R := ed.ClientRect;
    Offset := 0;
    if (ed.BorderStyle = bsSingle) then
    begin
      ACanvas.Start;
      QStyle_drawPanel(QWidget_style(Editor.Handle), ACanvas.Handle,
        R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, QWidget_colorGroup(Editor.Handle),
        True, 2, nil);
      ACanvas.Stop;
      //QGraphics.DrawEdge(ACanvas, R, esLowered, esLowered, ebRect)
    end
    else
    begin
      if Flat then
        QGraphics.DrawEdge(ACanvas, R, esNone, esLowered, ebRect);
      Offset := 2;
    end;

    with ACanvas do
    begin
      if Supports(Editor, IComboEditHelper, EditHelperIntf) then
      begin
        EditRect := EditHelperIntf.GetEditorRect;
        EditHelperIntf := nil;
      end
      else
      begin
        EditRect := Rect(0, 0, 0, 0);
        SendMessage(Editor.Handle, EM_GETRECT, 0, Integer(@EditRect));
      end;
      if IsRectEmpty(EditRect) then
      begin
        EditRect := ed.ClientRect;
        if ed.BorderStyle = bsSingle then
          InflateRect(EditRect, -2, -2);
      end
      else
        InflateRect(EditRect, -Offset, -Offset);
      if Flat and (ed.BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(ACanvas, ed.ClientRect);
      end;
      S := AText;
      LTextWidth := TextWidth(S);
      if PopupVisible then
        X := EditRect.Left
      else
      begin
        case AAlignment of
          taLeftJustify:
            X := EditRect.Left;
          taRightJustify:
            X := EditRect.Right - LTextWidth;
        else
          X := (EditRect.Right + EditRect.Left - LTextWidth) div 2;
        end;
      end;
      if not ed.Enabled then
      begin
        if Supports(ed, IJvWinControlEvents) then
          (ed as IJvWinControlEvents).DoEraseBackground(ACanvas, 0);
        ACanvas.Brush.Style := bsClear;
        ACanvas.Font.Color := DisabledTextColor;
        ACanvas.TextRect(EditRect, X, EditRect.Top + 1, S);
      end
      else
      begin
        Brush.Color := ed.Color;
        DrawSelectedText(ACanvas, EditRect, X, EditRect.Top + 1, S,
          ed.SelStart, ed.SelLength,
          clHighlight, clHighlightText);
      end;
    end;
  finally
    SavedFont.Free;
    SavedBrush.Free;
  end;
end;
{$ENDIF VisualCLX}

{$IFDEF VCL}

//=== { TAutoCompleteSource } ================================================

constructor TAutoCompleteSource.Create(AComboEdit: TJvCustomComboEdit; const StartIndex: Integer);
begin
  inherited Create;
  FComboEdit := AComboEdit;
  FCurrentIndex := StartIndex;
end;

function TAutoCompleteSource.Clone(out enm: IEnumString): HRESULT;
begin
  { Save state }
  try
    enm := TAutoCompleteSource.Create(FComboEdit, FCurrentIndex);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TAutoCompleteSource.Next(celt: Integer; out elt;
  pceltFetched: PLongint): HRESULT;
var
  Fetched: Integer;
  S: string;
  Ptr: POleStr;
  Size: Integer;
begin
  if Pointer(elt) = nil then
  begin
    Result := E_FAIL;
    Exit;
  end;

  Fetched := 0;

  while (Fetched < celt) and (FCurrentIndex < FComboEdit.AutoCompleteItems.Count) do
  begin
    S := FComboEdit.AutoCompleteItems[FCurrentIndex];
    Size := (Length(S) + 1) * SizeOf(WideChar);
    Ptr := CoTaskMemAlloc(Size);
    if Ptr = nil then
    begin
      Result := E_OUTOFMEMORY;
      Exit;
    end;
    // StringToWideChar() available in D5..D7?
    StringToWideChar(S, Ptr, Size);
    //lstrcpyW(Ptr, PWideChar(@W[1]));

    TOleStrList(elt)[Fetched] := Ptr;

    Inc(FCurrentIndex);
    Inc(Fetched);
  end;

  if Assigned(pceltFetched) then
    pceltFetched^ := Fetched;

  if Fetched = celt then
    Result := S_OK
  else
    Result := S_FALSE;
end;

function TAutoCompleteSource.Reset: HRESULT;
begin
  FCurrentIndex := 0;
  Result := S_OK;
end;

function TAutoCompleteSource.Skip(celt: Integer): HRESULT;
begin
  Inc(FCurrentIndex, celt);
  if FCurrentIndex < FComboEdit.AutoCompleteItems.Count then
    Result := S_OK
  else
  begin
    Result := S_FALSE;
    FCurrentIndex := FComboEdit.AutoCompleteItems.Count;
  end;
end;

//=== { TDateHook } ==========================================================

procedure TDateHook.Add;
begin
  if FCount = 0 then
    Hook;
  Inc(FCount);
end;

procedure TDateHook.Delete;
begin
  if FCount > 0 then
    Dec(FCount);
  if FCount = 0 then
    UnHook;
end;

function TDateHook.FormatSettingsChange(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Msg.Msg = WM_WININICHANGE) and Application.UpdateFormatSettings then
  begin
    // Let the application obj do the changing; we receive the message
    // before the application obj, thus jump over it:
    PostMessage(Application.Handle, WM_NULL, 0, 0);
    FWinIniChangeReceived := True;
  end
  else
  if (Msg.Msg = WM_NULL) and FWinIniChangeReceived then
  begin
    FWinIniChangeReceived := False;
    DateFormatChanged;
  end;
end;

procedure TDateHook.Hook;
begin
  if FHooked then
    Exit;

  Application.HookMainWindow(FormatSettingsChange);
  FHooked := True;
end;

procedure TDateHook.UnHook;
begin
  if not FHooked then
    Exit;

  Application.UnhookMainWindow(FormatSettingsChange);
  FHooked := False;
end;

{$ENDIF VCL}

//=== { TJvCustomComboEdit } =================================================

constructor TJvCustomComboEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csCaptureMouse];
  //  AutoSize := False;   // Polaris
  Height := 21;
  FDirectInput := True;
  FClickKey := scAltDown;
  FPopupAlign := epaRight;
  FBtnControl := TWinControl.Create(Self);
  with FBtnControl do
    ControlStyle := ControlStyle + [csReplicatable];
  FBtnControl.Width := DefEditBtnWidth;
  FBtnControl.Height := 17;
  FBtnControl.Visible := True;
  {$IFDEF VCL}
  FBtnControl.Parent := Self;
  {$IFDEF COMPILER6_UP}
  FBtnControl.Align := alCustom;
  {$ELSE}
  FBtnControl.Align := alRight;
  {$ENDIF COMPILER6_UP}
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  FBtnControl.Parent := Self.ClientArea;
  FBtnControl.Left := Self.ClientArea.Width - DefEditBtnWidth;
  FBtnControl.Anchors := [akRight, akTop, akBottom];
  {$ENDIF VisualCLX}
  FButton := TJvEditButton.Create(Self);
  FButton.SetBounds(0, 0, FBtnControl.Width, FBtnControl.Height);
  FButton.Visible := True;
  FButton.Parent := FBtnControl;
  FButton.Align := alClient;
  TJvEditButton(FButton).OnClick := EditButtonClick;
  FAlwaysEnableButton := False;
  (* ++ RDB ++ *)
  FDisabledColor := clWindow;
  FDisabledTextColor := clGrayText;
  FGroupIndex := -1;
  FStreamedButtonWidth := -1;
  FImageKind := ikCustom;
  FImageIndex := -1;
  FNumGlyphs := 1;
  {$IFDEF VCL}
  FAutoCompleteItems := TStringList.Create;
  FAutoCompleteOptions := [];
  CoInitialize(nil);
  {$ENDIF VCL}
  inherited OnKeyDown := LocalKeyDown;
  (* -- RDB -- *)
end;

destructor TJvCustomComboEdit.Destroy;
begin
  PopupCloseUp(Self, False);
  FButton.OnClick := nil;
  {$IFDEF VCL}
  FAutoCompleteSource := nil;
  FAutoCompleteItems.Free;
  FAutoCompleteIntf := nil;
  {$ENDIF VCL}
  inherited Destroy;
  {$IFDEF VCL}
  // call after WM_DESTROY
  CoUninitialize;
  {$ENDIF VCL}
end;

function TJvCustomComboEdit.AcceptPopup(var Value: Variant): Boolean;
begin
  Result := True;
end;

procedure TJvCustomComboEdit.AcceptValue(const Value: Variant);
begin
  if Text <> VarToStr(Value) then
  begin
    Text := Value;
    Modified := True;
    UpdatePopupVisible;
    //DoChange; (ahuser) Text := Value triggers Change;
  end;
end;

procedure TJvCustomComboEdit.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or not Assigned(Self.Images) then
        Self.Images := ActionList.Images;
      if not CheckDefaults or Self.Enabled then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
      if not CheckDefaults or (Self.Hint = '') then
        Self.ButtonHint := Hint;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.ClickKey = scNone) then
        Self.ClickKey := ShortCut;
      if not CheckDefaults or Self.Visible then
        Self.Visible := Visible;
      if not CheckDefaults or not Assigned(Self.OnButtonClick) then
        Self.OnButtonClick := OnExecute;
    end;
end;

procedure TJvCustomComboEdit.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFONT;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(HWND_DESKTOP);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(HWND_DESKTOP, DC);
  if NewStyleControls then
  begin
    {$IFDEF VCL}
    if Ctl3D then
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    if not Flat then
    {$ENDIF VisualCLX}
      I := 8
    else
      I := 6;
    I := GetSystemMetrics(SM_CYBORDER) * I;
  end
  else
  begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then
      I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;
  if Height < Metrics.tmHeight + I then
    Height := Metrics.tmHeight + I;
end;

procedure TJvCustomComboEdit.AdjustSize;
var
  MinHeight: Integer;
begin
  inherited AdjustSize;
  if not (csLoading in ComponentState) then
  begin
    MinHeight := GetMinHeight;
    { text edit bug: if size to less than MinHeight, then edit ctrl does
      not display the text }
    if Height < MinHeight then
    begin
      Height := MinHeight;
      Exit;
    end;
  end
  else
  begin
    if (FPopup <> nil) and (csDesigning in ComponentState) then
      FPopup.SetBounds(0, Height + 1, 10, 10);
  end;
  UpdateControls;
  UpdateMargins;
end;

procedure TJvCustomComboEdit.AsyncPopupCloseUp(Accept: Boolean);
begin
  PostMessage(Handle, CM_POPUPCLOSEUP, Ord(Accept), 0);
end;

function TJvCustomComboEdit.BtnWidthStored: Boolean;
begin
  if (FImageKind = ikDefault) and (DefaultImages <> nil) and (DefaultImageIndex >= 0) then
    Result := ButtonWidth <> Max(DefaultImages.Width + 6, DefEditBtnWidth)
  else
  if FImageKind = ikDropDown then
    Result := ButtonWidth <> GetSystemMetrics(SM_CXVSCROLL)
  else
    Result := ButtonWidth <> DefEditBtnWidth;
end;

procedure TJvCustomComboEdit.ButtonClick;
begin
  if Assigned(FOnButtonClick) then
    FOnButtonClick(Self);

  if (FPopup <> nil) and FPopupVisible then
    PopupCloseUp(FPopup, True)
  else
    PopupDropDown(True);
end;

procedure TJvCustomComboEdit.Change;
begin
  if not PopupVisible then
    DoChange
  else
    PopupChange;
end;

{$IFDEF VCL}

procedure TJvCustomComboEdit.CMBiDiModeChanged(var Msg: TMessage);
begin
  inherited;
  if FPopup <> nil then
    FPopup.BiDiMode := BiDiMode;
end;

procedure TJvCustomComboEdit.CMCancelMode(var Msg: TCMCancelMode);
begin
  if (Msg.Sender <> Self) and (Msg.Sender <> FPopup) and
    (Msg.Sender <> FButton) and ((FPopup <> nil) and
    not FPopup.ContainsControl(Msg.Sender)) then
    PopupCloseUp(FPopup, False);
end;

procedure TJvCustomComboEdit.CMCtl3DChanged(var Msg: TMessage);
begin
  inherited;
  DoCtl3DChanged;
end;

procedure TJvCustomComboEdit.CMPopupCloseup(var Msg: TMessage);
begin
  PopupCloseUp(Self, Boolean(Msg.WParam));
end;

procedure TJvCustomComboEdit.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  inherited;
  { Ignore tabs when popup is visible }
  if PopupVisible and (Msg.CharCode = VK_TAB) then
    Msg.Result := 1;
end;

procedure TJvCustomComboEdit.CNCtlColor(var Msg: TMessage);
var
  TextColor: Longint;
begin
  inherited;
  if NewStyleControls then
  begin
    TextColor := ColorToRGB(Font.Color);
    if not Enabled and (ColorToRGB(Color) <> ColorToRGB(clGrayText)) then
      TextColor := ColorToRGB(clGrayText);
    SetTextColor(Msg.WParam, TextColor);
  end;
end;

procedure TJvCustomComboEdit.CreateAutoComplete;
begin
  if HandleAllocated and not (csDesigning in ComponentState) and
    {not Assigned(FAutoCompleteIntf) and} (AutoCompleteOptions <> []) then
  begin
    { Create the autocomplete object. }
    if Succeeded(CoCreateInstance(CLSID_AutoComplete, nil, CLSCTX_INPROC_SERVER,
      IAutoComplete, FAutoCompleteIntf)) then
    begin
      { Initialize the autocomplete object. }
      FAutoCompleteIntf.Init(Self.Handle, GetAutoCompleteSource, nil, nil);
    end
    else
      FAutoCompleteIntf := nil;
  end;
end;

procedure TJvCustomComboEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array [TAlignment] of LongWord = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or
    ES_MULTILINE or WS_CLIPCHILDREN or Alignments[FAlignment];
end;

{$ENDIF VCL}

procedure TJvCustomComboEdit.CreatePopup;
begin
  { Notification }
end;

procedure TJvCustomComboEdit.CreateWnd;
begin
  inherited CreateWnd;
  UpdateControls;
  UpdateMargins;
  {$IFDEF VCL}
  if AutoCompleteOptions <> [] then
  begin
    CreateAutoComplete;
    UpdateAutoComplete;
  end;
  {$ENDIF VCL}
end;

{$IFDEF COMPILER6_UP}
{$IFDEF VCL}
procedure TJvCustomComboEdit.CustomAlignPosition(Control: TControl;
  var NewLeft, NewTop, NewWidth, NewHeight: Integer;
  var AlignRect: TRect; AlignInfo: TAlignInfo);
{$ENDIF VCL}
{$IFDEF VisualCLX}
procedure TJvCustomComboEdit.CustomAlignPosition(Control: TControl; var NewLeft,
      NewTop, NewWidth, NewHeight: Integer; var AlignRect: TRect);
{$ENDIF VisualCLX}
begin
  if Control = FBtnControl then
    UpdateBtnBounds(NewLeft, NewTop, NewWidth, NewHeight);
end;
{$ENDIF COMPILER6_UP}

class function TJvCustomComboEdit.DefaultImageIndex: TImageIndex;
begin
  Result := -1;
end;

class function TJvCustomComboEdit.DefaultImages: TCustomImageList;
begin
  if GDefaultComboEditImagesList = nil then
    GDefaultComboEditImagesList := TImageList.CreateSize(14, 12);
  Result := GDefaultComboEditImagesList;
end;

procedure TJvCustomComboEdit.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('GlyphKind', ReadGlyphKind, nil, False);
  {$IFDEF VCL}
  Filer.DefineProperty('Ctl3D', ReadCtl3D, nil, False);
  {$ENDIF VCL}
end;

procedure TJvCustomComboEdit.DoChange;
begin
  inherited Change;
end;

procedure TJvCustomComboEdit.WMClear(var Msg: TMessage);
begin
  Text := '';
end;

procedure TJvCustomComboEdit.DoClick;
begin
  EditButtonClick(Self);
end;

procedure TJvCustomComboEdit.WMCut(var Msg: TMessage);
begin
  if FDirectInput and not ReadOnly then
    inherited;
end;

procedure TJvCustomComboEdit.WMPaste(var Msg: TMessage);
begin
  if FDirectInput and not ReadOnly then
    inherited;
  UpdateGroup;
end;

procedure TJvCustomComboEdit.DoCtl3DChanged;
begin
  UpdateMargins;
  UpdateControls;
end;

procedure TJvCustomComboEdit.DoEnter;
begin
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited DoEnter;
end;

{$IFDEF VisualCLX}
procedure TJvCustomComboEdit.DoFlatChanged;
begin
  inherited DoFlatChanged;
  UpdateControls;
  UpdateMargins;
end;
{$ENDIF VisualCLX}

procedure TJvCustomComboEdit.FocusKilled(NextWnd: HWND);
var
  Sender: TWinControl;
begin
  inherited FocusKilled(NextWnd);
  FFocused := False;

  Sender := FindControl(NextWnd);
  if (Sender <> Self) and (Sender <> FPopup) and
    {(Sender <> FButton)} ((FPopup <> nil) and
    not FPopup.ContainsControl(Sender)) then
  begin
    { MSDN : While processing this message (WM_KILLFOCUS), do not make any
             function calls that display or activate a window.
    }
    AsyncPopupCloseUp(False);
  end;
end;

function TJvCustomComboEdit.DoEraseBackground(Canvas: TCanvas; Param: Integer): Boolean;
begin
  Result := True;
  if csDestroying in ComponentState then
    { (rb) Implementation diffs; some return True other False }
    Exit;
  if Enabled then
    Result := inherited DoEraseBackground(Canvas, Param)
  else
  begin
    Canvas.Brush.Color := FDisabledColor;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(ClientRect);
  end;
end;

procedure TJvCustomComboEdit.FocusSet(PrevWnd: HWND);
begin
  inherited FocusSet(PrevWnd);
  FFocused := True;
  SetShowCaret;
end;

procedure TJvCustomComboEdit.EditButtonClick(Sender: TObject);
begin
  if (not FReadOnly) or AlwaysEnableButton then
    ButtonClick;
end;

function TJvCustomComboEdit.EditCanModify: Boolean;
begin
  Result := not FReadOnly;
end;

procedure TJvCustomComboEdit.EnabledChanged;
begin
  inherited EnabledChanged;
  Invalidate;
  FButton.Enabled := Enabled;
  if Assigned(FOnEnabledChanged) then
    FOnEnabledChanged(Self);
end;

procedure TJvCustomComboEdit.FontChanged;
begin
  inherited FontChanged;
  if HandleAllocated then
    UpdateMargins;
end;

function TJvCustomComboEdit.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TJvCustomComboEditActionLink;
end;

{$IFDEF VCL}
function TJvCustomComboEdit.GetAutoCompleteSource: IUnknown;
begin
  Result := TAutoCompleteSource.Create(Self, 0);
end;
{$ENDIF VCL}

function TJvCustomComboEdit.GetButtonFlat: Boolean;
begin
  Result := FButton.Flat;
end;

function TJvCustomComboEdit.GetButtonHint: string;
begin
  Result := FButton.Hint;
end;

function TJvCustomComboEdit.GetButtonWidth: Integer;
begin
  if ShowButton then
    Result := FButton.Width
  else
    Result := FSavedButtonWidth;
end;

function TJvCustomComboEdit.GetDirectInput: Boolean;
begin
  Result := FDirectInput;
end;

{$IFDEF VCL}
function TJvCustomComboEdit.GetFlat: Boolean;
begin
  Result := not Ctl3D;
end;
{$ENDIF VCL}

function TJvCustomComboEdit.GetGlyph: TBitmap;
begin
  Result := FButton.Glyph;
end;

function TJvCustomComboEdit.GetGlyphKind: TGlyphKind;
begin
  Result := TGlyphKind(FImageKind);
end;

procedure TJvCustomComboEdit.GetInternalMargins(var ALeft,
  ARight: Integer);
const
  CPixelsBetweenEditAndButton = 2;
begin
  ARight := ARight + FBtnControl.Width + CPixelsBetweenEditAndButton;
end;

function TJvCustomComboEdit.GetMinHeight: Integer;
var
  I: Integer;
begin
  I := GetTextHeight;
  if BorderStyle = bsSingle then
    I := I + GetSystemMetrics(SM_CYBORDER) * 4 + 1;
  Result := I;
end;

function TJvCustomComboEdit.GetNumGlyphs: TNumGlyphs;
begin
  if ImageKind <> ikCustom then
    Result := FNumGlyphs
  else
    Result := FButton.NumGlyphs;
end;

function TJvCustomComboEdit.GetPopupValue: Variant;
begin
  if FPopup is TJvPopupWindow then
    Result := TJvPopupWindow(FPopup).GetValue
  else
    Result := '';
end;

function TJvCustomComboEdit.GetPopupVisible: Boolean;
begin
  Result := (FPopup <> nil) and FPopupVisible;
end;

function TJvCustomComboEdit.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

function TJvCustomComboEdit.GetSettingCursor: Boolean;
begin
  Result := TCustomMaskEditAccessPrivate(Self).FSettingCursor;
end;

function TJvCustomComboEdit.GetShowButton: Boolean;
begin
  Result := FBtnControl.Visible;
end;

function TJvCustomComboEdit.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFONT;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(HWND_DESKTOP);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(HWND_DESKTOP, DC);
  end;
  //  Result := Min(SysMetrics.tmHeight, Metrics.tmHeight);  // Polaris
  Result := Metrics.tmHeight; // Polaris
end;

procedure TJvCustomComboEdit.HidePopup;
begin
  if FPopup is TJvPopupWindow then
  begin
    TJvPopupWindow(FPopup).Hide;
    if Assigned(FOnPopupHidden) then
      FOnPopupHidden(Self);
  end;
end;

function TJvCustomComboEdit.IsCustomGlyph: Boolean;
begin
  Result := Assigned(Glyph) and (ImageKind = ikCustom);
end;

{$IFDEF VCL}
function TJvCustomComboEdit.IsFlatStored: Boolean;
begin
  { Same as IsCtl3DStored }
  Result := not ParentCtl3D;
end;
{$ENDIF VCL}

function TJvCustomComboEdit.IsImageIndexStored: Boolean;
begin
  Result :=
    not (ActionLink is TJvCustomComboEditActionLink) or
    not (ActionLink as TJvCustomComboEditActionLink).IsImageIndexLinked;
end;

procedure TJvCustomComboEdit.KeyDown(var Key: Word; Shift: TShiftState);
//Polaris
var
  Form: TCustomForm;
begin
  UpdateGroup;

  //Polaris
  Form := GetParentForm(Self);
  if (ssCtrl in Shift) then
    case Key of
      VK_RETURN:
        if (Form <> nil) {and Form.KeyPreview} then
        begin
          TWinControlAccessProtected(Form).KeyDown(Key, Shift);
          Key := 0;
        end;
      VK_TAB:
        if (Form <> nil) {and Form.KeyPreview} then
        begin
          TWinControlAccessProtected(Form).KeyDown(Key, Shift);
          Key := 0;
        end;
    end;
  //Original
  inherited KeyDown(Key, Shift);
  if (FClickKey = ShortCut(Key, Shift)) and (ButtonWidth > 0) then
  begin
    EditButtonClick(Self);
    Key := 0;
  end;
end;

procedure TJvCustomComboEdit.KeyPress(var Key: Char);
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);

  //Polaris  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
//  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) or ((Key = #10) and PopupVisible) then
  if (Key = Cr) or (Key = Esc) or ((Key = Lf) and PopupVisible) then
  begin
    if PopupVisible then
    begin
      //Polaris      PopupCloseUp(FPopup, Key = Char(VK_RETURN));
      PopupCloseUp(FPopup, Key <> Esc);
      Key := #0;
    end
    else
    begin
      { must catch and remove this, since is actually multi-line }
      {$IFDEF VCL}
      GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
      {$ENDIF VCL}
      {$IFDEF VisualCLX}
      TCustomFormAccessProtected(GetParentForm(Self)).NeedKey(Integer(Key), [], WideChar(Key));
      {$ENDIF VisualCLX}
      if Key = Cr then
      begin
        inherited KeyPress(Key);
        Key := #0;
        Exit;
      end;
    end;
  end;
  //Polaris
  if Key in [Tab, Lf] then
  begin
    Key := #0;
    { (rb) Next code has no use because Key = #0? } 
    if (Form <> nil) {and Form.KeyPreview} then
      TWinControlAccessProtected(Form).KeyPress(Key);
  end;
  //Polaris
  inherited KeyPress(Key);
end;

procedure TJvCustomComboEdit.Loaded;
begin
  inherited Loaded;
  if FStreamedButtonWidth >= 0 then
  begin
    SetButtonWidth(FStreamedButtonWidth);
    if FStreamedFixedWidth then
      with FButton do
        ControlStyle := ControlStyle + [csFixedWidth];
  end;

  UpdateControls;
  UpdateMargins;
end;

procedure TJvCustomComboEdit.LocalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpdateGroup;
  if Assigned(FOnKeyDown) then
    FOnKeyDown(Sender, Key, Shift);
end;

procedure TJvCustomComboEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (FPopup <> nil) and (Button = mbLeft) then
  begin
    if CanFocus then
      SetFocus;
    if not FFocused then
      Exit;
    if FPopupVisible then
      PopupCloseUp(FPopup, False);
    {else
     if (not ReadOnly or AlwaysEnable) and (not DirectInput) then
       PopupDropDown(True);}
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TJvCustomComboEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImages) then
    Images := nil;
  if (Operation = opRemove) and (AComponent = FPopup) then
    FPopup := nil;
end;

{$IFDEF VisualCLX}
procedure TJvCustomComboEdit.Paint;
begin
  if Enabled then
    inherited Paint
  else
  begin
    if not PaintEdit(Self, Text, Alignment, PopupVisible,
      DisabledTextColor, Focused and not PopupVisible, {Flat:}False, Canvas) then
      inherited Paint;
  end;
end;
{$ENDIF VisualCLX}

procedure TJvCustomComboEdit.PopupChange;
begin
end;

procedure TJvCustomComboEdit.PopupCloseUp(Sender: TObject; Accept: Boolean);
var
  AValue: Variant;
begin
  if (FPopup <> nil) and FPopupVisible then
  begin
    {$IFDEF VCL}
    if GetCapture <> 0 then
      SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    if Mouse.Capture <> nil then
      Mouse.Capture := nil;
    {$ENDIF VisualCLX}
    AValue := GetPopupValue;
    HidePopup;
    try
      try
        if CanFocus and ParentFormVisible(Self) then
        begin
          SetFocus;
          if GetFocus = Handle then
            SetShowCaret;
        end;
      except
        { ignore exceptions }
      end;
      SetDirectInput(DirectInput);
      Invalidate;
      if Accept and AcceptPopup(AValue) and EditCanModify then
      begin
        AcceptValue(AValue);
        if FFocused then
          inherited SelectAll;
      end;
    finally
      FPopupVisible := False;
    end;
  end;
end;

procedure TJvCustomComboEdit.PopupDropDown(DisableEdit: Boolean);
var
  P: TPoint;
  Y: Integer;
  SR: TJvSizeRect;
  {$IFDEF VCL}
  Monitor: TMonitor;
  {$ENDIF VCL}
begin
  if not ((ReadOnly and not FAlwaysShowPopup) or FPopupVisible) then
  begin
    CreatePopup;
    if FPopup = nil then
      Exit;

    P := Parent.ClientToScreen(Point(Left, Top));
    {$IFDEF VCL}
    Monitor := FindMonitor(MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST));
    SR.Top := Monitor.Top;
    SR.Left := Monitor.Left;
    SR.Width := Monitor.Width;
    SR.Height := Monitor.Height;
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    SR.Top := Screen.Top;
    SR.Left := Screen.Left;
    SR.Width := Screen.Width;
    SR.Height := Screen.Height;
    {$ENDIF VisualCLX}
    Y := P.Y + Height;
    if Y + FPopup.Height > SR.Top + SR.Height then
      Y := P.Y - FPopup.Height;
    case FPopupAlign of
      epaRight:
        begin
          Dec(P.X, FPopup.Width - Width);
          if P.X < SR.Left then
            Inc(P.X, FPopup.Width - Width);
        end;
      epaLeft:
        if P.X + FPopup.Width > SR.Left + SR.Width then
          Dec(P.X, FPopup.Width - Width);
    end;
    if P.X < SR.Left then
      P.X := SR.Left
    else
    if P.X + FPopup.Width > SR.Left + SR.Width then
      P.X := SR.Left + SR.Width - FPopup.Width;
    if Text <> '' then
      SetPopupValue(Text)
    else
      SetPopupValue(Null);
    if CanFocus then
      SetFocus;
    ShowPopup(Point(P.X, Y));
    FPopupVisible := True;
    if DisableEdit then
    begin
      inherited ReadOnly := True;
      HideCaret(Handle);
    end;
  end;
end;

{$IFDEF VCL}
procedure TJvCustomComboEdit.ReadCtl3D(Reader: TReader);
begin
  Ctl3D := Reader.ReadBoolean;
end;
{$ENDIF VCL}

procedure TJvCustomComboEdit.ReadGlyphKind(Reader: TReader);
const
  sEnumValues: array [TGlyphKind] of PChar =
    ('gkCustom', 'gkDefault', 'gkDropDown', 'gkEllipsis');
var
  S: string;
  GlyphKind: TGlyphKind;
begin
  { No need to drag in TypInfo.pas }
  S := Reader.ReadIdent;
  for GlyphKind := Low(TGlyphKind) to High(TGlyphKind) do
    if SameText(S, sEnumValues[GlyphKind]) then
    begin
      ImageKind := TJvImageKind(GlyphKind);
      Break;
    end;
end;

procedure TJvCustomComboEdit.RecreateGlyph;
var
  NewGlyph: TBitmap;

  function CreateEllipsisGlyph: TBitmap;
  var
    W, g, I: Integer;
  begin
    Result := TBitmap.Create;
    with Result do
    try
      {$IFDEF VCL}
      Monochrome := True;
      {$ENDIF VCL}
      Width := Max(1, FButton.Width - 6);
      Height := 4;
      W := 2;
      g := (Result.Width - 3 * W) div 2;
      if g <= 0 then
        g := 1;
      if g > 3 then
        g := 3;
      I := (Width - 3 * W - 2 * g) div 2;
      {$IFDEF VisualCLX}
      Canvas.Start;
      {$ENDIF VisualCLX}
      PatBlt(Canvas.Handle, I, 1, W, W, BLACKNESS);
      PatBlt(Canvas.Handle, I + g + W, 1, W, W, BLACKNESS);
      PatBlt(Canvas.Handle, I + 2 * g + 2 * W, 1, W, W, BLACKNESS);
      {$IFDEF VisualCLX}
      Canvas.Stop;
      {$ENDIF VisualCLX}
    except
      Free;
      raise;
    end;
  end;

begin
  { Delay until button is shown }
  if not ShowButton then
    Exit;

  if FImageKind in [ikDropDown, ikEllipsis] then
  begin
    FButton.ImageIndex := -1;
    FButton.NumGlyphs := 1;
  end;
  {$IFDEF JVCLThemesEnabled}
  FButton.FDrawThemedDropDownBtn := FImageKind = ikDropDown;
  {$ENDIF JVCLThemesEnabled}

  case FImageKind of
    ikDropDown:
      begin
        {$IFDEF JVCLThemesEnabled}
        { When XP Themes are enabled, ButtonFlat = False, GlyphKind = gkDropDown then
          the glyph is the default themed dropdown button. When ButtonFlat = True, we
          can't use that default dropdown button (because we then use toolbar buttons,
          and there is no themed dropdown toolbar button) }
        FButton.FDrawThemedDropDownBtn :=
          ThemeServices.ThemesEnabled and not ButtonFlat;
        if FButton.FDrawThemedDropDownBtn then
        begin
          TJvxButtonGlyph(FButton.ButtonGlyph).Glyph := nil;
          FButton.Invalidate;
        end
        else
        {$ENDIF JVCLThemesEnabled}
        begin
          LoadDefaultBitmap(TJvxButtonGlyph(FButton.ButtonGlyph).Glyph, OBM_COMBO);
          FButton.Invalidate;
        end;
      end;
    ikEllipsis:
      begin
        NewGlyph := CreateEllipsisGlyph;
        try
          TJvxButtonGlyph(FButton.ButtonGlyph).Glyph := NewGlyph;
          FButton.Invalidate;
        finally
          NewGlyph.Destroy;
        end;
      end;
  else
//    TJvxButtonGlyph(FButton.ButtonGlyph).Glyph := nil;
    FButton.Invalidate;
  end;
end;

procedure TJvCustomComboEdit.SelectAll;
begin
  if DirectInput then
    inherited SelectAll;
end;

{$IFDEF VCL}

procedure TJvCustomComboEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomComboEdit.SetAutoCompleteItems(Strings: TStrings);
begin
  FAutoCompleteItems.Assign(Strings);
end;

procedure TJvCustomComboEdit.SetAutoCompleteOptions(const Value: TJvAutoCompleteOptions);
begin
  if Value <> FAutoCompleteOptions then
  begin
    FAutoCompleteOptions := Value;

    if not Assigned(FAutoCompleteIntf) then
      CreateAutoComplete;
    UpdateAutoComplete;
  end;
end;

{$ENDIF VCL}

{$IFDEF VisualCLX}
procedure TJvCustomComboEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  UpdateControls;
  UpdateMargins;
end;
{$ENDIF VisualCLX}

procedure TJvCustomComboEdit.SetButtonFlat(const Value: Boolean);
begin
  FButton.Flat := Value;
  {$IFDEF JVCLThemesEnabled}
  { When XP Themes are enabled, ButtonFlat = False, GlyphKind = gkDropDown then
    the glyph is the default themed dropdown button. When ButtonFlat = True, we
    can't use that default dropdown button, so we have to recreate the glyph
    in this special case }
  if ThemeServices.ThemesEnabled and (ImageKind = ikDropDown) then
    RecreateGlyph;
  {$ENDIF JVCLThemesEnabled}
end;

procedure TJvCustomComboEdit.SetButtonHint(const Value: string);
begin
  FButton.Hint := Value;
end;

procedure TJvCustomComboEdit.SetButtonWidth(Value: Integer);
begin
  if csLoading in ComponentState then
  begin
    FStreamedButtonWidth := Value;
    FStreamedFixedWidth := False;
  end
  else
  if not ShowButton then
    FSavedButtonWidth := Value
  else
  if (ButtonWidth <> Value) {or ((Value > 0) <> ShowButton)} then
  begin
    if Value > 1 then
      FBtnControl.Visible := True
    else
    begin
      FSavedButtonWidth := ButtonWidth;
      FBtnControl.Visible := False;
    end;
    if csCreating in ControlState then
    begin
      FBtnControl.Width := Value;
      FButton.Width := Value;
      with FButton do
        ControlStyle := ControlStyle - [csFixedWidth];
      { Some glyphs are size dependant (ellipses), thus recreate on size changes }
      RecreateGlyph;
    end
      //else
      //if (Value <> ButtonWidth) and (Value < ClientWidth) then begin
      //Polaris
    else
    if (Value <> ButtonWidth) and
      ((Assigned(Parent) and (Value < ClientWidth)) or
      (not Assigned(Parent) and (Value < Width))) then
    begin
      FBtnControl.SetBounds(FBtnControl.Left + FBtnControl.Width - Value,
        FBtnControl.Top, Value, FBtnControl.Height);
      FButton.Width := Value;
      with FButton do
        ControlStyle := ControlStyle - [csFixedWidth];
      if HandleAllocated then
        {$IFDEF VCL}
        RecreateWnd;
        {$ENDIF VCL}
        {$IFDEF VisualCLX}
        Invalidate;
        {$ENDIF VisualCLX}
      { Some glyphs are size dependant (ellipses), thus recreate on size changes }
      RecreateGlyph;
    end;
  end;
end;

procedure TJvCustomComboEdit.SetClipboardCommands(const Value: TJvClipboardCommands);
begin
  if ClipboardCommands <> Value then
  begin
    inherited SetClipboardCommands(Value);
    if ReadOnly and not (ClipboardCommands <= [caCopy]) then
      ClipboardCommands := [caCopy];
  end;
end;

procedure TJvCustomComboEdit.SetDirectInput(Value: Boolean);
begin
  inherited ReadOnly := not Value or FReadOnly;
  FDirectInput := Value;
end;

procedure TJvCustomComboEdit.SetDisabledColor(const Value: TColor);
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    if not Enabled then
      Invalidate;
  end;
end;

procedure TJvCustomComboEdit.SetDisabledTextColor(const Value: TColor);
begin
  if FDisabledTextColor <> Value then
  begin
    FDisabledTextColor := Value;
    if not Enabled then
      Invalidate;
  end;
end;

{$IFDEF VCL}
procedure TJvCustomComboEdit.SetFlat(const Value: Boolean);
begin
  Ctl3D := not Value;
end;
{$ENDIF VCL}

procedure TJvCustomComboEdit.SetGlyph(Value: TBitmap);
begin
  ImageKind := ikCustom;
  FButton.Glyph := Value;
  FNumGlyphs := FButton.NumGlyphs;
end;

procedure TJvCustomComboEdit.SetGlyphKind(Value: TGlyphKind);
begin
  ImageKind := TJvImageKind(Value);
end;

procedure TJvCustomComboEdit.SetGroupIndex(const Value: Integer);
begin
  FGroupIndex := Value;
  UpdateGroup;
end;

procedure TJvCustomComboEdit.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if FImageKind = ikCustom then
      FButton.ImageIndex := FImageIndex;
  end;
end;

procedure TJvCustomComboEdit.SetImageKind(const Value: TJvImageKind);
begin
  if FImageKind <> Value then
  begin
    FImageKind := Value;
    RecreateGlyph;
    case FImageKind of
      ikCustom:
        begin
          FButton.Images := FImages;
          FButton.ImageIndex := FImageIndex;
          FButton.NumGlyphs := FNumGlyphs;
        end;
      ikDefault:
        begin
          FButton.Images := DefaultImages;
          FButton.ImageIndex := DefaultImageIndex;
          { Default glyphs have a default width }
          if Assigned(FButton.Images) and (FButton.ImageIndex >= 0) then
            ButtonWidth := Max(FButton.Images.Width + 6, FButton.Width)
        end;
      ikDropDown:
        if csLoading in ComponentState then
        begin
          if (FStreamedButtonWidth < 0) or FStreamedFixedWidth then
          begin
            ButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
            { Setting ButtonWidth will set FStreamedFixedWidth to False, thus
              reapply it. }
            FStreamedFixedWidth := True;
          end;
        end
        else
        begin
          ButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
          { Setting ButtonWidth will remove the csFixedWidth flag, thus
            reapply it. }
          with FButton do
            ControlStyle := ControlStyle + [csFixedWidth];
        end;
      ikEllipsis: ;
    end;
  end;
end;

procedure TJvCustomComboEdit.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
  if FImages <> nil then
    FImages.FreeNotification(Self)
  else
    SetImageIndex(-1);
  if ImageKind = ikCustom then
  begin
    FButton.Images := FImages;
    FButton.ImageIndex := FImageIndex;
  end;
end;

procedure TJvCustomComboEdit.SetNumGlyphs(const Value: TNumGlyphs);
begin
  //if FGlyphKind in [gkDropDown, gkEllipsis] then
  //  FButton.NumGlyphs := 1
  //else
  //if FGlyphKind = gkDefault then
  //  FButton.NumGlyphs := FDefNumGlyphs
  //else
  FNumGlyphs := Value;
  if ImageKind = ikCustom then
    FButton.NumGlyphs := Value;
end;

procedure TJvCustomComboEdit.SetPopupValue(const Value: Variant);
begin
  if FPopup is TJvPopupWindow then
    TJvPopupWindow(FPopup).SetValue(Value);
end;

procedure TJvCustomComboEdit.SetReadOnly(Value: Boolean);
begin
  if Value <> FReadOnly then
  begin
    FReadOnly := Value;
    inherited ReadOnly := Value or not FDirectInput;
  end;
end;

procedure TJvCustomComboEdit.SetShowButton(const Value: Boolean);
begin
  if ShowButton <> Value then
  begin
    if Value then
    begin
      { FBtnControl needs to be visible first, otherwise only FSavedButtonWidth
        is changed when setting ButtonWidth }
      FBtnControl.Visible := True;
      ButtonWidth := FSavedButtonWidth
    end
    else
      ButtonWidth := 0;
  end;
end;

procedure TJvCustomComboEdit.SetShowCaret;
const
  CaretWidth: array [Boolean] of Byte = (1, 2);
begin
  CreateCaret(Handle, 0, CaretWidth[fsBold in Font.Style], GetTextHeight);
  ShowCaret(Handle);
end;

procedure TJvCustomComboEdit.ShowPopup(Origin: TPoint);
begin
  if FPopup is TJvPopupWindow then
  begin
    TJvPopupWindow(FPopup).Show(Origin);
    if Assigned(FOnPopupShown) then
      FOnPopupShown(Self);
  end;
end;

{$IFDEF VCL}
procedure TJvCustomComboEdit.UpdateAutoComplete;
const
  cAutoCompleteOptionValues: array [TJvAutoCompleteOption] of DWORD =
    (ACO_AUTOSUGGEST, ACO_AUTOAPPEND,
     ACO_SEARCH, ACO_FILTERPREFIXES, ACO_USETAB, ACO_UPDOWNKEYDROPSLIST,
     ACO_RTLREADING);
var
  Flags: DWORD;
  Option: TJvAutoCompleteOption;
  AutoComplete2: IAutoComplete2;
begin
  if HandleAllocated and not (csDesigning in ComponentState) then
  begin
    if Supports(FAutoCompleteIntf, IAutoComplete2, AutoComplete2) then
    begin
      { Set the options of the autocomplete object. }
      Flags := 0;
      for Option := Low(TJvAutoCompleteOption) to High(TJvAutoCompleteOption) do
        if Option in AutoCompleteOptions then
          Inc(Flags, cAutoCompleteOptionValues[Option]);

      AutoComplete2.SetOptions(Flags);
    end;
  end;
end;
{$ENDIF VCL}

{$IFDEF COMPILER6_UP}
procedure TJvCustomComboEdit.UpdateBtnBounds(var NewLeft, NewTop, NewWidth, NewHeight: Integer);
var
  BtnRect: TRect;
begin
  if NewStyleControls then
    {$IFDEF JVCLThemesEnabled}
    if ThemeServices.ThemesEnabled then
    begin
      if BorderStyle = bsSingle then
      begin
        if Ctl3D then
          BtnRect := Bounds(Width - FButton.Width - 2, 0,
            FButton.Width, Height - 2)
        else
          BtnRect := Bounds(Width - FButton.Width - 1, 1,
            FButton.Width, Height - 2);
      end
      else
        BtnRect := Bounds(Width - FButton.Width, 0,
          FButton.Width, Height);
    end
    else
    {$ENDIF JVCLThemesEnabled}
    begin
      if BorderStyle = bsSingle then
      begin
        {$IFDEF VCL}
        if Ctl3D then
        {$ENDIF VCL}
        {$IFDEF VisualCLX}
        if not Flat then
        {$ENDIF VisualCLX}
          BtnRect := Bounds(Width - FButton.Width - 4, 0,
            FButton.Width, Height - 4)
        else
          BtnRect := Bounds(Width - FButton.Width - 2, 2,
            FButton.Width, Height - 4)
      end
      else
        BtnRect := Bounds(Width - FButton.Width, 0,
          FButton.Width, Height);
    end
  else
    BtnRect := Bounds(Width - FButton.Width, 0, FButton.Width, Height);

  NewLeft := BtnRect.Left;
  NewTop := BtnRect.Top;
  NewWidth := BtnRect.Right - BtnRect.Left;
  NewHeight := BtnRect.Bottom - BtnRect.Top;
end;
{$ENDIF COMPILER6_UP}

procedure TJvCustomComboEdit.UpdateControls;
begin
  { Notification }
end;

procedure TJvCustomComboEdit.UpdateGroup;
var
  I: Integer;
begin
  if (FGroupIndex <> -1) and (Owner <> nil) then
    for I := 0 to Owner.ComponentCount - 1 do
      if Owner.Components[I] is TJvCustomComboEdit then
        with TJvCustomComboEdit(Owner.Components[I]) do
          if (Name <> Self.Name) and (FGroupIndex = Self.FGroupIndex) then
            Clear;
end;

procedure TJvCustomComboEdit.UpdateMargins;
var
  LLeft, LRight, LTop: Integer;
  Loc: TRect;
begin
  { Delay until Loaded and Handle is created }
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {UpdateMargins gets called whenever the layout of child controls changes.
   It uses GetInternalMargins to determine the left and right margins of the
   actual text area.}

  AdjustHeight;

  LTop := 0;
  LLeft := 0;
  LRight := 0;
  {$IFDEF JVCLThemesEnabled}
  { If flat and themes are enabled, move the left edge of the edit rectangle
    to the right, otherwise the theme edge paints over the border }
  { (rb) This was for a specific font/language; check if this is still necessary }
  if ThemeServices.ThemesEnabled then
  begin
    if BorderStyle = bsSingle then
    begin
      if not Ctl3D then
        LLeft := 3
      else
      begin
        LLeft := 1;
        LTop := 1;
      end;
    end;
  end;
  if ThemeServices.ThemesEnabled then
  begin
  if BorderStyle = bsSingle then
    if Ctl3D then
      LRight := 1
    else
      LRight := -1;
  end
  else
  {$ENDIF JVCLThemesEnabled}
  if (BorderStyle = bsSingle) and
    {$IFDEF VCL} Ctl3D {$ENDIF}{$IFDEF VisualCLX} not Flat {$ENDIF} then
    LTop := 2;

  GetInternalMargins(LLeft, LRight);

  {$IFDEF VCL}
  SetRect(Loc, LLeft, LTop, Width - LRight-3, ClientHeight - 1);
  SendMessage(Handle, EM_SETRECTNP, 0, Longint(@Loc));
  // (rb) EM_SETMARGINS necessary?
  //SendMessage(Handle, EM_SETMARGINS, EC_RIGHTMARGIN or EC_LEFTMARGIN, MakeLong(LLeft, LRight));
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  SetRect(Loc, LLeft, LTop, Width - LRight - LTop-2, Height - 2 * LTop);
  SetEditorRect(@Loc);
  FBtnControl.Left := Loc.Right + 2;
  FBtnControl.Height := Height - 2 * LTop;
  {$ENDIF VisualCLX}
end;

procedure TJvCustomComboEdit.UpdatePopupVisible;
begin
  FPopupVisible := (FPopup <> nil) and FPopup.Visible;
end;

{$IFDEF JVCLThemesEnabled}
procedure TJvCustomComboEdit.WMNCCalcSize(var Msg: TWMNCCalcSize);
begin
  if ThemeServices.ThemesEnabled and Ctl3D and (BorderStyle = bsSingle) then
    with Msg.CalcSize_Params^ do
      InflateRect(rgrc[0], 1, 1);
  inherited;
end;
{$ENDIF JVCLThemesEnabled}

{$IFDEF VCL}
procedure TJvCustomComboEdit.WMNCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
begin
  inherited;
  if (Msg.Result = HTCLIENT) and not (csDesigning in ComponentState) and ShowButton then
  begin
    P := Point(FBtnControl.Left, FBtnControl.Top);
    Windows.ClientToScreen(Handle, P);
    if Msg.XPos > P.X then
      Msg.Result := HTBORDER; {HTCAPTION;}
  end;
end;
{$ENDIF VCL}

{$IFDEF JVCLThemesEnabled}
procedure TJvCustomComboEdit.WMNCPaint(var Msg: TWMNCPaint);
var
  DC: HDC;
  DrawRect: TRect;
  Details: TThemedElementDetails;
begin
  if ThemeServices.ThemesEnabled and Ctl3D and (BorderStyle = bsSingle) then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, DrawRect);
      OffsetRect(DrawRect, -DrawRect.Left, -DrawRect.Top);
      with DrawRect do
        ExcludeClipRect(DC, Left + 1, Top + 1, Right - 1, Bottom - 1);

      Details := ThemeServices.GetElementDetails(teEditTextNormal);
      ThemeServices.DrawElement(DC, Details, DrawRect);
    finally
      ReleaseDC(Handle, DC);
    end;
    Msg.Result := 0;
  end
  else
    inherited;
end;
{$ENDIF JVCLThemesEnabled}

{$IFDEF VCL}
procedure TJvCustomComboEdit.WMPaint(var Msg: TWMPaint);
var
  Canvas: TControlCanvas;
begin
  if csDestroying in ComponentState then
    Exit;
  if Enabled then
    inherited
  else
  begin
    Canvas := nil;
    if not PaintEdit(Self, Text, FAlignment, PopupVisible,
      DisabledTextColor, Focused and not PopupVisible, Canvas, Msg) then
      inherited;
    Canvas.Free;
  end;
end;
{$ENDIF VCL}

{$IFDEF VCL}
procedure TJvCustomComboEdit.WndProc(var Msg: TMessage);
begin
  if (((Msg.Msg >= WM_KEYFIRST) and (Msg.Msg <= WM_KEYLAST)) or (Msg.Msg = WM_CONTEXTMENU)) and
     not SettingCursor and PopupVisible and
    (FPopup is TJvPopupWindow) and Assigned(TJvPopupWindow(FPopup).ActiveControl) then
  begin
    with Msg do
      Result := TJvPopupWindow(FPopup).ActiveControl.Perform(Msg, WParam, LParam);

    if Msg.Result = 0 then
      Exit;
  end;

  inherited WndProc(Msg)
end;
{$ENDIF VCL}

//=== { TJvCustomComboEditActionLink } =======================================

function TJvCustomComboEditActionLink.IsCaptionLinked: Boolean;
begin
  Result := False;
end;

function TJvCustomComboEditActionLink.IsHintLinked: Boolean;
begin
  Result := (Action is TCustomAction) and (FClient is TJvCustomComboEdit) and
    ((FClient as TJvCustomComboEdit).ButtonHint = (Action as TCustomAction).Hint);
end;

function TJvCustomComboEditActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and (FClient is TJvCustomComboEdit) and
    ((FClient as TJvCustomComboEdit).ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TJvCustomComboEditActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := (Action is TCustomAction) and (FClient is TJvCustomComboEdit) and
    (@(FClient as TJvCustomComboEdit).OnButtonClick = @Action.OnExecute);
end;

function TJvCustomComboEditActionLink.IsShortCutLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and (FClient is TJvCustomComboEdit) and
    ((FClient as TJvCustomComboEdit).ClickKey = (Action as TCustomAction).ShortCut);
end;

procedure TJvCustomComboEditActionLink.SetHint(const Value: THintString);
begin
  if IsHintLinked then
    (FClient as TJvCustomComboEdit).ButtonHint := Value;
end;

procedure TJvCustomComboEditActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    (FClient as TJvCustomComboEdit).ImageIndex := Value;
end;

procedure TJvCustomComboEditActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then
    (FClient as TJvCustomComboEdit).OnButtonClick := Value;
end;

procedure TJvCustomComboEditActionLink.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then
    (FClient as TJvCustomComboEdit).ClickKey := Value;
end;

//=== { TJvCustomDateEdit } ==================================================

constructor TJvCustomDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Polaris
  FDateAutoBetween := True;
  FMinDate := NullDate;
  FMaxDate := NullDate;

  FBlanksChar := ' ';
  FTitle := RsDateDlgCaption;
  {$IFDEF VCL}
  FPopupColor := clMenu;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  FPopupColor := clWindow;
  {$ENDIF VisualCLX}
  //  FDefNumGlyphs := 2;
  FStartOfWeek := Mon;
  FWeekends := [Sun];
  FWeekendColor := clRed;
  FYearDigits := dyDefault;
  FCalendarHints := TStringList.Create;
  FCalendarHints.OnChange := CalendarHintsChanged;
  {$IFDEF VCL}
  DateHook.Add;
  {$ENDIF VCL}

  ControlState := ControlState + [csCreating];
  try
    UpdateFormat;
    {$IFDEF DEFAULT_POPUP_CALENDAR}
    FPopup := TJvPopupWindow(CreatePopupCalendar(Self,
      {$IFDEF VCL} BiDiMode, {$ENDIF}{$IFDEF VisualCLX} bdLeftToRight, {$ENDIF}
      // Polaris
      FMinDate, FMaxDate));
    TJvPopupWindow(FPopup).OnCloseUp := PopupCloseUp;
    TJvPopupWindow(FPopup).Color := FPopupColor;
    {$ENDIF DEFAULT_POPUP_CALENDAR}
    ImageKind := ikDefault; { force update }
  finally
    ControlState := ControlState - [csCreating];
  end;
end;

destructor TJvCustomDateEdit.Destroy;
begin
  {$IFDEF VCL}
  DateHook.Delete;
  {$ENDIF VCL}

  if FPopup is TJvPopupWindow then
  begin
    TJvPopupWindow(FPopup).OnCloseUp := nil;
    FPopup.Parent := nil;
  end;
  FPopup.Free;
  FPopup := nil;
  FCalendarHints.OnChange := nil;
  FCalendarHints.Free;
  FCalendarHints := nil;
  inherited Destroy;
end;

function TJvCustomDateEdit.AcceptPopup(var Value: Variant): Boolean;
var
  D: TDateTime;
begin
  Result := True;
  if Assigned(FOnAcceptDate) then
  begin
    if VarIsNull(Value) or VarIsEmpty(Value) then
      D := NullDate
    else
    try
      D := VarToDateTime(Value);
    except
      if DefaultToday then
        D := SysUtils.Date
      else
        D := NullDate;
    end;
    FOnAcceptDate(Self, D, Result);
    if Result then
      Value := VarFromDateTime(D);
  end;
end;

procedure TJvCustomDateEdit.AcceptValue(const Value: Variant);
begin
  SetDate(VarToDateTime(Value));
  UpdatePopupVisible;
  if Modified then
    inherited Change;
end;

procedure TJvCustomDateEdit.ApplyDate(Value: TDateTime);
begin
  SetDate(Value);
  SelectAll;
end;

procedure TJvCustomDateEdit.CalendarHintsChanged(Sender: TObject);
begin
  FCalendarHints.OnChange := nil;
  try
    while CalendarHints.Count > 4 do
      CalendarHints.Delete(CalendarHints.Count - 1);
  finally
    FCalendarHints.OnChange := CalendarHintsChanged;
  end;
  if not (csDesigning in ComponentState) then
    UpdatePopup;
end;

procedure TJvCustomDateEdit.Change;
begin
  if not FFormatting then
    inherited Change;
end;

// Polaris

procedure TJvCustomDateEdit.CheckValidDate;
var
  ADate: TDateTime;
begin
  if TextStored then
  try
    FFormatting := True;
    try
      SetDate(StrToDateFmt(FDateFormat, Text));
    finally
      FFormatting := False;
    end;
  except
    if CanFocus then
      SetFocus;
    ADate := Self.Date;
    if DoInvalidDate(Text,ADate) then
      Self.Date := ADate
    else
      raise;
  end;
end;

{$IFDEF VisualCLX}
procedure TJvCustomDateEdit.CreateWidget;
begin
  inherited CreateWidget;
  if HandleAllocated then
    UpdateMask;
end;
{$ENDIF VisualCLX}

{$IFDEF VCL}
procedure TJvCustomDateEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  if Handle <> 0 then
    UpdateMask;
end;
{$ENDIF VCL}

class function TJvCustomDateEdit.DefaultImageIndex: TImageIndex;
var
  Bmp: TBitmap;
begin
  if GDateImageIndex < 0 then
  begin
    Bmp := TBitmap.Create;
    try
      Bmp.LoadFromResourceName(HInstance, sDateBmp);
      GDateImageIndex := DefaultImages.AddMasked(Bmp, clFuchsia);
    finally
      Bmp.Free;
    end;
  end;

  Result := GDateImageIndex;
end;

procedure TJvCustomDateEdit.DoExit;
begin
  if not (csDesigning in ComponentState) and CheckOnExit then
    CheckValidDate;
  inherited DoExit;
end;

function TJvCustomDateEdit.DoInvalidDate(const DateString: string;
  var ANewDate: TDateTime): Boolean;
begin
  Result := False;
  if Assigned(FOnInvalidDate) then
    FOnInvalidDate(Self, DateString, ANewDate, Result);
end;

function TJvCustomDateEdit.FourDigitYear: Boolean;
begin
  Result := (FYearDigits = dyFour) or ((FYearDigits = dyDefault) and
   IsFourDigitYear);
end;

function TJvCustomDateEdit.GetCalendarHints: TStrings;
begin
  Result := FCalendarHints;
end;

function TJvCustomDateEdit.GetCalendarStyle: TCalendarStyle;
begin
  if FPopup <> nil then
    Result := csPopup
  else
    Result := csDialog;
end;

function TJvCustomDateEdit.GetDate: TDateTime;
begin
  if DefaultToday then
    Result := SysUtils.Date
  else
    Result := NullDate;
  Result := StrToDateFmtDef(FDateFormat, Text, Result);
end;

function TJvCustomDateEdit.GetDateFormat: string;
begin
  Result := FDateFormat;
end;

function TJvCustomDateEdit.GetDateMask: string;
begin
  Result := DefDateMask(FBlanksChar, FourDigitYear);
end;

function TJvCustomDateEdit.GetDialogTitle: string;
begin
  Result := FTitle;
end;

function TJvCustomDateEdit.GetPopupColor: TColor;
begin
  if FPopup is TJvPopupWindow then
    Result := TJvPopupWindow(FPopup).Color
  else
    Result := FPopupColor;
end;

function TJvCustomDateEdit.IsCustomTitle: Boolean;
begin
  Result := (AnsiCompareStr(RsDateDlgCaption, DialogTitle) <> 0) and
    (DialogTitle <> ''); // Polaris
end;

function TJvCustomDateEdit.IsDateStored: Boolean;
begin
  Result := not DefaultToday;
end;

procedure TJvCustomDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsInWordArray(Key, [VK_PRIOR, VK_NEXT, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN,
    VK_ADD, VK_SUBTRACT, VK_RETURN]) and PopupVisible then
  begin
    if FPopup is TJvPopupWindow then
      TJvPopupWindow(FPopup).KeyDown(Key, Shift);
    Key := 0;
  end
  else
  if (Shift = []) and DirectInput then
  begin
    case Key of
      VK_ADD:
        begin
          ApplyDate(NvlDate(Date, Now) + 1);
          Key := 0;
        end;
      VK_SUBTRACT:
        begin
          ApplyDate(NvlDate(Date, Now) - 1);
          Key := 0;
        end;
    end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TJvCustomDateEdit.KeyPress(var Key: Char);
begin
  if (Key in ['T', 't', '+', '-']) and PopupVisible then
  begin
    if FPopup is TJvPopupWindow then
      TJvPopupWindow(FPopup).KeyPress(Key);
    Key := #0;
  end
  else
  if DirectInput then
    case Key of
      'T', 't':
        begin
          ApplyDate(Trunc(Now));
          Key := #0;
        end;
      '+', '-':
        Key := #0;
    end;
  inherited KeyPress(Key);
end;

procedure TJvCustomDateEdit.PopupDropDown(DisableEdit: Boolean);
var
  D: TDateTime;
  Action: Boolean;
begin
  if CalendarStyle = csDialog then
  begin
    D := Self.Date;
    Action := SelectDate(Self, D, DialogTitle, StartOfWeek, Weekends, // Polaris (Self added)
      WeekendColor, CalendarHints,
      MinDate, MaxDate); // Polaris
    if CanFocus then
      SetFocus;
    if Action then
    begin
      if Assigned(FOnAcceptDate) then
        FOnAcceptDate(Self, D, Action);
      if Action then
      begin
        Self.Date := D;
        if FFocused then
          inherited SelectAll;
      end;
    end;
  end
  else
    inherited PopupDropDown(DisableEdit);
end;

procedure TJvCustomDateEdit.SetBlanksChar(Value: Char);
begin
  if Value <> FBlanksChar then
  begin
    if Value < ' ' then
      Value := ' ';
    FBlanksChar := Value;
    UpdateMask;
  end;
end;

procedure TJvCustomDateEdit.SetCalendarHints(Value: TStrings);
begin
  FCalendarHints.Assign(Value);
end;

procedure TJvCustomDateEdit.SetCalendarStyle(Value: TCalendarStyle);
begin
  if Value <> CalendarStyle then
    case Value of
      csPopup:
        begin
          if FPopup = nil then
            FPopup := TJvPopupWindow(CreatePopupCalendar(Self,
              {$IFDEF VCL} BiDiMode, {$ENDIF}{$IFDEF VisualCLX} bdLeftToRight, {$ENDIF}
              FMinDate, FMaxDate)); // Polaris
          TJvPopupWindow(FPopup).OnCloseUp := PopupCloseUp;
          TJvPopupWindow(FPopup).Color := FPopupColor;
          UpdatePopup;
        end;
      csDialog:
        FreeAndNil(FPopup);
    end;
end;

// Polaris

procedure TJvCustomDateEdit.SetDate(Value: TDateTime);
var
  D: TDateTime;
begin
  if not ValidDate(Value) or (Value = NullDate) then
  begin
    if DefaultToday then
      Value := SysUtils.Date
    else
      Value := NullDate;
  end;
  D := Self.Date;
  TestDateBetween(Value); // Polaris
  if Value = NullDate then
    Text := ''
  else
    Text := FormatDateTime(FDateFormat, Value);
  Modified := D <> Self.Date;
end;

procedure TJvCustomDateEdit.SetDateAutoBetween(Value: Boolean);
var
  D: TDateTime;
begin
  if Value <> FDateAutoBetween then
  begin
    FDateAutoBetween := Value;
    if Value then
    begin
      D := Date;
      TestDateBetween(D);
      if D <> Date then
        Date := D;
    end;
    Invalidate;
  end;
end;

procedure TJvCustomDateEdit.SetDialogTitle(const Value: string);
begin
  FTitle := Value;
end;

procedure TJvCustomDateEdit.SetMaxDate(Value: TDateTime);
begin
  if Value <> FMaxDate then
  begin
    //Check unacceptable MaxDate < MinDate
    if (Value <> NullDate) and (FMinDate <> NullDate) and (Value < FMinDate) then
      if FDateAutoBetween then
        SetMinDate(Value)
      else
        raise EJVCLException.CreateResFmt(@RsEDateMaxLimit, [DateToStr(FMinDate)]);
    FMaxDate := Value;
    UpdatePopup;
    if FDateAutoBetween then
      SetDate(Date);
  end;
end;

procedure TJvCustomDateEdit.SetMinDate(Value: TDateTime);
begin
  if Value <> FMinDate then
  begin
    //!!!!! Necessarily check

    // Check unacceptable MinDate > MaxDate [Translated]
    if (Value <> NullDate) and (FMaxDate <> NullDate) and (Value > FMaxDate) then
      if FDateAutoBetween then
        SetMaxDate(Value)
      else
        raise EJVCLException.CreateResFmt(@RsEDateMinLimit, [DateToStr(FMaxDate)]);
    FMinDate := Value;
    UpdatePopup;
    if FDateAutoBetween then
      SetDate(Date);
  end;
end;

procedure TJvCustomDateEdit.SetPopupColor(Value: TColor);
begin
  if Value <> PopupColor then
  begin
    if FPopup is TJvPopupWindow then
      TJvPopupWindow(FPopup).Color := Value;
    FPopupColor := Value;
  end;
end;

procedure TJvCustomDateEdit.SetPopupValue(const Value: Variant);
begin
  inherited SetPopupValue(StrToDateFmtDef(FDateFormat, VarToStr(Value),
    SysUtils.Date));
end;

procedure TJvCustomDateEdit.SetStartOfWeek(Value: TDayOfWeekName);
begin
  if Value <> FStartOfWeek then
  begin
    FStartOfWeek := Value;
    UpdatePopup;
  end;
end;

procedure TJvCustomDateEdit.SetWeekendColor(Value: TColor);
begin
  if Value <> FWeekendColor then
  begin
    FWeekendColor := Value;
    UpdatePopup;
  end;
end;

procedure TJvCustomDateEdit.SetWeekends(Value: TDaysOfWeek);
begin
  if Value <> FWeekends then
  begin
    FWeekends := Value;
    UpdatePopup;
  end;
end;

procedure TJvCustomDateEdit.SetYearDigits(Value: TYearDigits);
begin
  if FYearDigits <> Value then
  begin
    FYearDigits := Value;
    UpdateMask;
  end;
end;

function TJvCustomDateEdit.StoreMaxDate: Boolean;
begin
  Result := FMaxDate <> NullDate;
end;

function TJvCustomDateEdit.StoreMinDate: Boolean;
begin
  Result := FMinDate <> NullDate;
end;

procedure TJvCustomDateEdit.TestDateBetween(var Value: TDateTime);
begin
  if FDateAutoBetween then
  begin
    if (FMinDate <> NullDate) and (Value <> NullDate) and (Value < FMinDate) then
      Value := FMinDate;
    if (FMaxDate <> NullDate) and (Value <> NullDate) and (Value > FMaxDate) then
      Value := FMaxDate;
  end;
end;

function TJvCustomDateEdit.TextStored: Boolean;
begin
  Result := not IsEmptyStr(Text, [#0, ' ', DateSeparator, FBlanksChar]);
end;

procedure TJvCustomDateEdit.UpdateFormat;
begin
  FDateFormat := DefDateFormat(FourDigitYear);
end;

procedure TJvCustomDateEdit.UpdateMask;
var
  DateValue: TDateTime;
  OldFormat: string[10];
begin
  DateValue := GetDate;
  OldFormat := FDateFormat;
  UpdateFormat;
  if (GetDateMask <> EditMask) or (OldFormat <> FDateFormat) then
  begin
    { force update }
    EditMask := '';
    EditMask := GetDateMask;
  end;
  UpdatePopup;
  SetDate(DateValue);
end;

procedure TJvCustomDateEdit.UpdatePopup;
begin
  if FPopup <> nil then
    SetupPopupCalendar(FPopup, StartOfWeek,
      Weekends, WeekendColor, CalendarHints, FourDigitYear,
      MinDate, MaxDate); // Polaris
end;

procedure TJvCustomDateEdit.ValidateEdit;
begin
  if TextStored then
    CheckValidDate;
end;

{$IFDEF VCL}
procedure TJvCustomDateEdit.WMContextMenu(var Msg: TWMContextMenu);
begin
  if not PopupVisible then
    inherited;
end;
{$ENDIF VCL}

//=== { TJvDateEdit } ========================================================

// (rom) unusual not to have it implemented in the Custom base class

constructor TJvDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  UpdateMask;
end;

procedure TJvDateEdit.SetDate(Value: TDateTime);
begin
  if not FDateAutoBetween then
    if Value <> NullDate then
    begin
      if ((FMinDate <> NullDate) and (FMaxDate <> NullDate) and
        ((Value < FMinDate) or (Value > FMaxDate))) then
        raise EJVCLException.CreateResFmt(@RsEDateOutOfRange, [FormatDateTime(FDateFormat, Value),
          FormatDateTime(FDateFormat, FMinDate), FormatDateTime(FDateFormat, FMaxDate)])
      else
      if (FMinDate <> NullDate) and (Value < FMinDate) then
        raise EJVCLException.CreateResFmt(@RsEDateOutOfMin, [FormatDateTime(FDateFormat, Value),
          FormatDateTime(FDateFormat, FMinDate)])
      else
      if (FMaxDate <> NullDate) and (Value > FMaxDate) then
        raise EJVCLException.CreateResFmt(@RsEDateOutOfMax, [FormatDateTime(FDateFormat, Value),
          FormatDateTime(FDateFormat, FMaxDate)]);
    end;
  inherited SetDate(Value);
end;

//=== { TJvDirectoryEdit } ===================================================

constructor TJvDirectoryEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF VCL}
  FOptions := [sdAllowCreate];
  FAutoCompleteFileOptions := [acfFileSystem, acfFileSysDirs];
  {$ENDIF VCL}
  FDialogKind := dkWin32;
end;

class function TJvDirectoryEdit.DefaultImageIndex: TImageIndex;
var
  Bmp: TBitmap;
begin
  {$IFDEF JVCLThemesEnabled}
  if ThemeServices.ThemesEnabled then
  begin
    if GDirImageIndexXP < 0 then
    begin
      Bmp := TBitmap.Create;
      try
        Bmp.LoadFromResourceName(HInstance, sDirXPBmp);
        GDirImageIndexXP := DefaultImages.AddMasked(Bmp, clFuchsia);
      finally
        Bmp.Free;
      end;
    end;
    Result := GDirImageIndexXP;
    Exit;
  end;
  {$ENDIF JVCLThemesEnabled}

  if GDirImageIndex < 0 then
  begin
    Bmp := TBitmap.Create;
    try
      Bmp.LoadFromResourceName(HInstance, sDirBmp);
      GDirImageIndex := DefaultImages.AddMasked(Bmp, clFuchsia);
    finally
      Bmp.Free;
    end;
  end;
  Result := GDirImageIndex;
end;

function TJvDirectoryEdit.GetLongName: string;
var
  Temp: string;
  Pos: Integer;
begin
  if not MultipleDirs then
    Result := ShortToLongPath(Text)
  else
  begin
    Result := '';
    Pos := 1;
    while Pos <= Length(Text) do
    begin
      Temp := ShortToLongPath(ExtractSubstr(Text, Pos, [PathSep]));
      if (Result <> '') and (Temp <> '') then
        Result := Result + PathSep;
      Result := Result + Temp;
    end;
  end;
end;

function TJvDirectoryEdit.GetShortName: string;
var
  Temp: string;
  Pos: Integer;
begin
  if not MultipleDirs then
    Result := LongToShortPath(Text)
  else
  begin
    Result := '';
    Pos := 1;
    while Pos <= Length(Text) do
    begin
      Temp := LongToShortPath(ExtractSubstr(Text, Pos, [PathSep]));
      if (Result <> '') and (Temp <> '') then
        Result := Result + PathSep;
      Result := Result + Temp;
    end;
  end;
end;

procedure TJvDirectoryEdit.PopupDropDown(DisableEdit: Boolean);
var
  Temp: string;
  {$IFDEF VisualCLX}
  TempW: WideString;
  {$ENDIF VisualCLX}
  Action: Boolean;
begin
  Temp := Text;
  Action := True;
  DoBeforeDialog(Temp, Action);
  if not Action then
    Exit;
  if Temp = '' then
  begin
    if InitialDir <> '' then
      Temp := InitialDir
    else
      Temp := PathDelim;
  end;
  if not DirectoryExists(Temp) then
    Temp := PathDelim;
  DisableSysErrors;
  try
    {$IFDEF VCL}
    if NewStyleControls and (DialogKind = dkWin32) then
      Action := BrowseForFolder(FDialogText, sdAllowCreate in DialogOptions, Temp, Self.HelpContext)
    else
      Action := SelectDirectory(Temp, FOptions, Self.HelpContext);
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    begin
      Action := SelectDirectory(FDialogText, Temp, TempW);
      Temp := TempW;
    end;
    {$ENDIF VisualCLX}
  finally
    EnableSysErrors;
  end;
  if CanFocus then
    SetFocus;
  DoAfterDialog(Temp, Action);
  if Action then
  begin
    SelText := '';
    if (Text = '') or not MultipleDirs then
      Text := Temp
    else
      Text := Text + PathSep + Temp;
    if (Temp <> '') and DirectoryExists(Temp) then
      InitialDir := Temp;
  end;
end;

procedure TJvDirectoryEdit.ReceptFileDir(const AFileName: string);
var
  Temp: string;
begin
  if FileExists(AFileName) then
    Temp := ExtractFilePath(AFileName)
  else
    Temp := AFileName;
  if (Text = '') or not MultipleDirs then
    Text := Temp
  else
    Text := Text + PathSep + Temp;
end;

//=== { TJvEditButton } ======================================================

constructor TJvEditButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStandard := True; // Polaris
  ControlStyle := ControlStyle + [csReplicatable];
  ParentShowHint := True;
end;

procedure TJvEditButton.Click;
begin
  if not FNoAction then
    inherited Click
  else
    FNoAction := False;
end;

function TJvEditButton.GetGlyph: TBitmap;
begin
  Result := TJvxButtonGlyph(ButtonGlyph).Glyph;
end;

function TJvEditButton.GetNumGlyphs: TJvNumGlyphs;
begin
  Result := TJvxButtonGlyph(ButtonGlyph).NumGlyphs;
end;

function TJvEditButton.GetUseGlyph: Boolean;
begin
  Result := not Assigned(Images) or (ImageIndex < 0);
end;

procedure TJvEditButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and (Owner <> nil) then
    with TJvCustomComboEdit(Owner) do
    begin
      FNoAction := (FPopup <> nil) and FPopupVisible;
      if not FPopupVisible then
      begin
        if TabStop and CanFocus and (GetFocus <> Handle) then
          SetFocus;
      end
      else
        PopupCloseUp(FPopup, FStandard); // Polaris
    end;
end;

procedure TJvEditButton.Paint;
{$IFDEF JVCLThemesEnabled}
var
  ThemedState: TThemedComboBox;
  Details: TThemedElementDetails;
  R: TRect;
{$ENDIF JVCLThemesEnabled}
begin
  {$IFDEF JVCLThemesEnabled}
  if ThemeServices.ThemesEnabled then
  begin
    if FDrawThemedDropDownBtn then
    begin
      if not Enabled then
        ThemedState := tcDropDownButtonDisabled
      else
      if FState in [rbsDown, rbsExclusive] then
        ThemedState := tcDropDownButtonPressed
      else
      if MouseOver or IsDragging then
        ThemedState := tcDropDownButtonHot
      else
        ThemedState := tcDropDownButtonNormal;
      R := ClientRect;
      Details := ThemeServices.GetElementDetails(ThemedState);
      ThemeServices.DrawElement(Canvas.Handle, Details, R);
    end
    else
      inherited Paint;
  end
  else
  {$ENDIF JVCLThemesEnabled}
  begin
    inherited Paint;
    if FState <> rbsDown then
      with Canvas do
      begin
        if NewStyleControls then
          Pen.Color := clBtnFace
        else
          Pen.Color := clBtnShadow;
        MoveTo(0, 0);
        LineTo(0, Self.Height - 1);
        Pen.Color := clBtnHighlight;
        MoveTo(1, 1);
        LineTo(1, Self.Height - 2);
      end;
  end;
end;

procedure TJvEditButton.PaintImage(Canvas: TCanvas; ARect: TRect;
  const Offset: TPoint; AState: TJvButtonState; DrawMark: Boolean);
begin
  if UseGlyph then
    TJvxButtonGlyph(ButtonGlyph).Draw(Canvas, ARect, Offset, '', Layout,
      Margin, Spacing, False, AState, 0)
  else
    inherited PaintImage(Canvas, ARect, Offset, AState, DrawMark);
end;

procedure TJvEditButton.SetGlyph(const Value: TBitmap);
begin
  TJvxButtonGlyph(ButtonGlyph).Glyph := Value;
  Invalidate;
end;

procedure TJvEditButton.SetNumGlyphs(Value: TJvNumGlyphs);
begin
  if Value < 0 then
    Value := 1
  else
  if Value > Ord(High(TJvButtonState)) + 1 then
    Value := Ord(High(TJvButtonState)) + 1;
  if Value <> TJvxButtonGlyph(ButtonGlyph).NumGlyphs then
  begin
    TJvxButtonGlyph(ButtonGlyph).NumGlyphs := Value;
    Invalidate;
  end;
end;

{$IFDEF VCL}
procedure TJvEditButton.WMContextMenu(var Msg: TWMContextMenu);
begin
  { (rb) Without this, we get 2 context menu's (1 from the form, another from
         the combo edit; don't know exactly what is causing this. (I guess
         it's related to FBtnControl being a TWinControl) }
  Msg.Result := 1;
end;
{$ENDIF VCL}

//=== { TJvFileDirEdit } =====================================================

constructor TJvFileDirEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF VCL}
  OEMConvert := True;
  FAcceptFiles := True;
  FAutoCompleteOptions := [acoAutoSuggest];
  {$ENDIF VCL}
  ControlState := ControlState + [csCreating];
  try
    ImageKind := ikDefault; { force update }
  finally
    ControlState := ControlState - [csCreating];
  end;
end;

procedure TJvFileDirEdit.Change;
var
  Ps: Integer;
begin
  // The control becomes confused when the Text property has a #10 or #13 in it.
  Ps := Pos(#10, Text);
  if Ps = 0 then
    Ps := Pos(#13, Text);
  if Ps > 0 then
    Text := Copy(Text, 1, Ps - 1)
  else
    inherited Change;
end;

procedure TJvFileDirEdit.ClearFileList;
begin
end;

{$IFDEF JVCLThemesEnabled}
procedure TJvFileDirEdit.CMSysColorChange(var Msg: TMessage);
begin
  inherited;
  // We use this event to respond to theme changes (no WM_THEMECHANGED are broadcasted
  // to the components)
  // Note that there is a bug in TApplication.WndProc, so the application will not
  // change from non-themed to themed.
  if ImageKind = ikDefault then
    Button.ImageIndex := DefaultImageIndex;
end;
{$ENDIF JVCLThemesEnabled}

{$IFDEF VCL}

procedure TJvFileDirEdit.CreateHandle;
begin
  inherited CreateHandle;

  if FAcceptFiles then
    SetDragAccept(True);
end;

procedure TJvFileDirEdit.DestroyWindowHandle;
begin
  SetDragAccept(False);
  inherited DestroyWindowHandle;
end;

{$ENDIF VCL}

procedure TJvFileDirEdit.DisableSysErrors;
begin
  {$IFDEF MSWINDOWS}
  FErrMode := SetErrorMode(SEM_NOOPENFILEERRORBOX or SEM_FAILCRITICALERRORS);
  {$ENDIF MSWINDOWS}
end;

procedure TJvFileDirEdit.DoAfterDialog(var FileName: string;
  var Action: Boolean);
begin
  if Assigned(FOnAfterDialog) then
    FOnAfterDialog(Self, FileName, Action);
end;

procedure TJvFileDirEdit.DoBeforeDialog(var FileName: string;
  var Action: Boolean);
begin
  if Assigned(FOnBeforeDialog) then
    FOnBeforeDialog(Self, FileName, Action);
end;

procedure TJvFileDirEdit.EnableSysErrors;
begin
  {$IFDEF MSWINDOWS}
  SetErrorMode(FErrMode);
  {$ENDIF MSWINDOWS}
  FErrMode := 0;
end;

{$IFDEF VCL}

function TJvFileDirEdit.GetAutoCompleteSource: IUnknown;
begin
  if Failed(CoCreateInstance(CLSID_ACLMulti, nil, CLSCTX_INPROC_SERVER, IUnknown, FAutoCompleteSourceIntf)) then
    FAutoCompleteSourceIntf := nil;
  Result := FAutoCompleteSourceIntf;
end;

procedure TJvFileDirEdit.SetAcceptFiles(Value: Boolean);
begin
  if FAcceptFiles <> Value then
  begin
    SetDragAccept(Value);
    FAcceptFiles := Value;
  end;
end;

procedure TJvFileDirEdit.SetAutoCompleteFileOptions(const Value: TJvAutoCompleteFileOptions);
begin
  if FAutoCompleteFileOptions <> Value then
  begin
    FAutoCompleteFileOptions := Value;

    if not (csDesigning in ComponentState) then
      UpdateAutoComplete;
  end;
end;

procedure TJvFileDirEdit.SetDragAccept(Value: Boolean);
begin
  if not (csDesigning in ComponentState) and (Handle <> 0) then
    DragAcceptFiles(Handle, Value);
end;

procedure TJvFileDirEdit.UpdateAutoComplete;
var
  ObjMgr: IObjMgr;
  List2: IACList2;
  Options: DWORD;
begin
  if Supports(FAutoCompleteSourceIntf, IObjMgr, ObjMgr) then
  begin
    if acfURLMRU in AutoCompleteFileOptions then
    begin
      if not Assigned(FMRUList) and
        Succeeded(CoCreateInstance(CLSID_ACLMRU, nil, CLSCTX_INPROC_SERVER, IUnknown, FMRUList)) then
      begin
        ObjMgr.Append(FMRUList);
      end
    end
    else
    if Assigned(FMRUList) then
    begin
      ObjMgr.Remove(FMRUList);
      FMRUList := nil;
    end;

    if acfURLHistory in AutoCompleteFileOptions then
    begin
      if not Assigned(FHistoryList) and
        Succeeded(CoCreateInstance(CLSID_ACLHistory, nil, CLSCTX_INPROC_SERVER, IUnknown, FHistoryList)) then
      begin
        ObjMgr.Append(FHistoryList);
      end;
    end
    else
    if Assigned(FHistoryList) then
    begin
      ObjMgr.Remove(FHistoryList);
      FHistoryList := nil;
    end;

    if [acfFileSystem, acfFileSysDirs] * AutoCompleteFileOptions <> [] then
    begin
      if not Assigned(FFileSystemList) and
        Succeeded(CoCreateInstance(CLSID_ACListISF, nil, CLSCTX_INPROC_SERVER, IUnknown, FFileSystemList)) then
      begin
        ObjMgr.Append(FFileSystemList);
      end;

      Options := ACLO_FILESYSONLY;
      if acfFileSysDirs in AutoCompleteFileOptions then
        Options := Options or ACLO_FILESYSDIRS;

      if Supports(FFileSystemList, IACList2, List2) then
        List2.SetOptions(Options);
    end
    else
    if Assigned(FFileSystemList) then
    begin
      ObjMgr.Remove(FFileSystemList);
      FFileSystemList := nil;
    end;
  end;

  inherited UpdateAutoComplete;
end;

procedure TJvFileDirEdit.WMDropFiles(var Msg: TWMDropFiles);
var
  AFileName: array [0..255] of Char;
  I, Num: Cardinal;
begin
  Msg.Result := 0;
  try
    Num := DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
    if Num > 0 then
    begin
      ClearFileList;
      for I := 0 to Num - 1 do
      begin
        DragQueryFile(Msg.Drop, I, PChar(@AFileName), Pred(SizeOf(AFileName)));
        ReceptFileDir(StrPas(AFileName));
        if not FMultipleDirs then
          Break;
      end;
      if Assigned(FOnDropFiles) then
        FOnDropFiles(Self);
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

{$ENDIF VCL}

//=== { TJvFilenameEdit } ====================================================

constructor TJvFilenameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAddQuotes := True;
  {$IFDEF VCL}
  FAutoCompleteFileOptions := [acfFileSystem];
  {$ENDIF VCL}
  CreateEditDialog;
end;

procedure TJvFilenameEdit.ClearFileList;
begin
  FDialog.Files.Clear;
end;

procedure TJvFilenameEdit.CreateEditDialog;
var
  NewDialog: TOpenDialog;
begin
  case FDialogKind of
    dkOpen:
      NewDialog := TOpenDialog.Create(Self);
    dkOpenPicture:
      NewDialog := TOpenPictureDialog.Create(Self);
    dkSavePicture:
      NewDialog := TSavePictureDialog.Create(Self);
  else { dkSave }
    NewDialog := TSaveDialog.Create(Self);
  end;
  try
    if FDialog <> nil then
    begin
      with NewDialog do
      begin
        DefaultExt := FDialog.DefaultExt;
        {$IFDEF VCL}
        FileEditStyle := FDialog.FileEditStyle;
        {$ENDIF VCL}
        FileName := FDialog.FileName;
        Filter := FDialog.Filter;
        FilterIndex := FDialog.FilterIndex;
        InitialDir := FDialog.InitialDir;
        HistoryList := FDialog.HistoryList;
        Files.Assign(FDialog.Files);
        Options := FDialog.Options;
        Title := FDialog.Title;
      end;
      FDialog.Free;
    end
    else
    begin
      NewDialog.Title := RsBrowseCaption;
      NewDialog.Filter := RsDefaultFilter;
      NewDialog.Options := [ofHideReadOnly];
    end;
  finally
    FDialog := NewDialog;
  end;
end;

class function TJvFilenameEdit.DefaultImageIndex: TImageIndex;
var
  Bmp: TBitmap;
begin
  {$IFDEF JVCLThemesEnabled}
  if ThemeServices.ThemesEnabled then
  begin
    if GFileImageIndexXP < 0 then
    begin
      Bmp := TBitmap.Create;
      try
        Bmp.LoadFromResourceName(HInstance, sFileXPBmp);
        GFileImageIndexXP := DefaultImages.AddMasked(Bmp, clFuchsia);
      finally
        Bmp.Free;
      end;
    end;
    Result := GFileImageIndexXP;
    Exit;
  end;
  {$ENDIF JVCLThemesEnabled}

  if GFileImageIndex < 0 then
  begin
    Bmp := TBitmap.Create;
    try
      Bmp.LoadFromResourceName(HInstance, sFileBmp);
      GFileImageIndex := DefaultImages.AddMasked(Bmp, clFuchsia);
    finally
      Bmp.Free;
    end;
  end;
  Result := GFileImageIndex;
end;

function TJvFilenameEdit.GetDefaultExt: TFileExt;
begin
  Result := FDialog.DefaultExt;
end;

function TJvFilenameEdit.GetDialogFiles: TStrings;
begin
  Result := FDialog.Files;
end;

function TJvFilenameEdit.GetDialogTitle: string;
begin
  Result := FDialog.Title;
end;

{$IFDEF VCL}
function TJvFilenameEdit.GetFileEditStyle: TFileEditStyle;
begin
  Result := FDialog.FileEditStyle;
end;
{$ENDIF VCL}

function TJvFilenameEdit.GetFileName: TFileName;
begin
  if AddQuotes then
    Result := ClipFilename(inherited Text)
  else
    Result := inherited Text;
end;

function TJvFilenameEdit.GetFilter: string;
begin
  Result := FDialog.Filter;
end;

function TJvFilenameEdit.GetFilterIndex: Integer;
begin
  Result := FDialog.FilterIndex;
end;

function TJvFilenameEdit.GetHistoryList: TStrings;
begin
  Result := FDialog.HistoryList;
end;

function TJvFilenameEdit.GetInitialDir: string;
begin
  Result := FDialog.InitialDir;
end;

function TJvFilenameEdit.GetLongName: string;
begin
  Result := ShortToLongFileName(FileName);
end;

function TJvFilenameEdit.GetOptions: TOpenOptions;
begin
  Result := FDialog.Options;
end;

function TJvFilenameEdit.GetShortName: string;
begin
  Result := LongToShortFileName(FileName);
end;

function TJvFilenameEdit.IsCustomFilter: Boolean;
begin
  Result := AnsiCompareStr(RsDefaultFilter, FDialog.Filter) <> 0;
end;

function TJvFilenameEdit.IsCustomTitle: Boolean;
begin
  Result := AnsiCompareStr(RsBrowseCaption, FDialog.Title) <> 0;
end;

procedure TJvFilenameEdit.PopupDropDown(DisableEdit: Boolean);
var
  Temp: string;
  Action: Boolean;
begin
  Temp := inherited Text;
  Action := True;
  Temp := ClipFilename(Temp);
  DoBeforeDialog(Temp, Action);
  if not Action then
    Exit;
  if ValidFileName(Temp) then
  try
    if DirectoryExists(ExtractFilePath(Temp)) then
      SetInitialDir(ExtractFilePath(Temp));
    if (ExtractFileName(Temp) = '') or
      not ValidFileName(ExtractFileName(Temp)) then
      Temp := '';
    FDialog.FileName := Temp;
  except
    { ignore any exceptions }
  end;
  FDialog.HelpContext := Self.HelpContext;
  DisableSysErrors;
  try
    Action := FDialog.Execute;
  finally
    EnableSysErrors;
  end;
  if Action then
    Temp := FDialog.FileName;
  if CanFocus then
    SetFocus;
  DoAfterDialog(Temp, Action);
  if Action then
  begin
    if AddQuotes then
      inherited Text := ExtFilename(Temp)
    else
      inherited Text := Temp;
    SetInitialDir(ExtractFilePath(FDialog.FileName));
  end;
end;

procedure TJvFilenameEdit.ReceptFileDir(const AFileName: string);
begin
  if FMultipleDirs then
  begin
    if FDialog.Files.Count = 0 then
      SetFileName(AFileName);
    FDialog.Files.Add(AFileName);
  end
  else
    SetFileName(AFileName);
end;

procedure TJvFilenameEdit.SetDefaultExt(Value: TFileExt);
begin
  FDialog.DefaultExt := Value;
end;

procedure TJvFilenameEdit.SetDialogKind(Value: TFileDialogKind);
begin
  if FDialogKind <> Value then
  begin
    FDialogKind := Value;
    CreateEditDialog;
  end;
end;

procedure TJvFilenameEdit.SetDialogTitle(const Value: string);
begin
  FDialog.Title := Value;
end;

{$IFDEF VCL}
procedure TJvFilenameEdit.SetFileEditStyle(Value: TFileEditStyle);
begin
  FDialog.FileEditStyle := Value;
end;
{$ENDIF VCL}

procedure TJvFilenameEdit.SetFileName(const Value: TFileName);
begin
  if (Value = '') or ValidFileName(ClipFilename(Value)) then
  begin
    if AddQuotes then
      inherited Text := ExtFilename(Value)
    else
      inherited Text := Value;
    ClearFileList;
  end
  else
    raise EComboEditError.CreateResFmt(@SInvalidFilename, [Value]);
end;

procedure TJvFilenameEdit.SetFilter(const Value: string);
begin
  FDialog.Filter := Value;
end;

procedure TJvFilenameEdit.SetFilterIndex(Value: Integer);
begin
  FDialog.FilterIndex := Value;
end;

procedure TJvFilenameEdit.SetHistoryList(Value: TStrings);
begin
  FDialog.HistoryList := Value;
end;

procedure TJvFilenameEdit.SetInitialDir(const Value: string);
begin
  FDialog.InitialDir := Value;
end;

procedure TJvFilenameEdit.SetOptions(Value: TOpenOptions);
begin
  if Value <> FDialog.Options then
  begin
    FDialog.Options := Value;
    FMultipleDirs := ofAllowMultiSelect in FDialog.Options;
    if not FMultipleDirs then
      ClearFileList;
  end;
end;

//=== { TJvPopupWindow } =====================================================

constructor TJvPopupWindow.Create(AOwner: TComponent);
begin
  {$IFDEF VisualCLX}
  // (p3) have to use CreateNew for VCL as well since there is no dfm
  inherited CreateNew(AOwner);
  {$ELSE}
  inherited Create(AOwner);
  {$ENDIF VisualCLX}

  FEditor := TWinControl(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable, csAcceptsControls];
  Visible := False;
  {$IFDEF VCL}
  Ctl3D := False;
  ParentCtl3D := False;
  Parent := FEditor;
  // use same size on small and large font:
  //Scaled := False;
  {$ENDIF VCL}
end;

procedure TJvPopupWindow.CloseUp(Accept: Boolean);
begin
  if Assigned(FCloseUp) then
    FCloseUp(Self, Accept);
end;

{$IFDEF VCL}
procedure TJvPopupWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER or WS_CLIPCHILDREN;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;
{$ENDIF VCL}

function TJvPopupWindow.GetPopupText: string;
begin
  Result := '';
end;

procedure TJvPopupWindow.Hide;
begin
  {$IFDEF VCL}
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  {$ENDIF VCL}
  Visible := False;
end;

procedure TJvPopupWindow.InvalidateEditor;
var
  R: TRect;
begin
  if FEditor is TJvCustomComboEdit then
    with TJvCustomComboEdit(FEditor) do
      SetRect(R, 0, 0, ClientWidth - FBtnControl.Width {Polaris - 2}, ClientHeight + 1)
  else
    R := FEditor.ClientRect;
  {$IFDEF VCL}
  InvalidateRect(FEditor.Handle, @R, False);
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  FEditor.InvalidateRect(R, False);
  {$ENDIF VisualCLX}
  UpdateWindow(FEditor.Handle);
end;

procedure TJvPopupWindow.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
    CloseUp(PtInRect(ClientRect, Point(X, Y)));
end;

{$IFDEF VisualCLX}
procedure TJvPopupWindow.SetParent(const Value: TWidgetControl);
var
  Pt: TPoint;
  R: TRect;
begin
  Pt := Point(Left, Top);
  R := BoundsRect;
  inherited SetParent(Value);
  if not (csDestroying in ComponentState) then
  begin
    QWidget_reparent(Handle, nil, 0, @Pt, Showing);
    BoundsRect := R;
  end;
end;
{$ENDIF VisualCLX}

procedure TJvPopupWindow.Show(Origin: TPoint);
begin
  SetBounds(Origin.X, Origin.Y, Width, Height);
  {$IFDEF VCL}
  SetWindowPos(Handle, HWND_TOP, Origin.X, Origin.Y, 0, 0,
    SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
  {$ENDIF VCL}
  Visible := True;
end;

{$IFDEF VisualCLX}
function TJvPopupWindow.WidgetFlags: Integer;
begin
  Result := Integer(WidgetFlags_WType_Popup) or // WS_POPUP
    Integer(WidgetFlags_WStyle_NormalBorder) or // WS_BORDER
    Integer(WidgetFlags_WStyle_Tool);  // WS_EX_TOOLWINDOW
end;
{$ENDIF VisualCLX}

{$IFDEF VCL}
procedure TJvPopupWindow.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  if Msg.Active = WA_INACTIVE then
  begin
    if FEditor is TJvCustomComboEdit then
      TJvCustomComboEdit(FEditor).AsyncPopupCloseUp(False)
    else
      CloseUp(False);
  end;
end;
{$ENDIF VCL}

{$IFDEF VCL}
procedure TJvPopupWindow.WMMouseActivate(var Msg: TMessage);
begin
  if FIsFocusable then
    inherited
  else
    Msg.Result := MA_NOACTIVATE;
end;
{$ENDIF VCL}

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}

finalization
  {$IFDEF VCL}
  FreeAndNil(GDateHook);
  {$ENDIF VCL}
  FreeAndNil(GDefaultComboEditImagesList);
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.
