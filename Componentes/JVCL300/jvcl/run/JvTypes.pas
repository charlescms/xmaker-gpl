{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvTypes.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse att buypin dott com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].
                Peter Thornqvist
                Oliver Giesen
                Gustavo Bianconi

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvTypes.pas,v 1.87 2005/03/09 14:57:32 marquardt Exp $

unit JvTypes;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes,
  Windows, Messages, Controls, Forms, Graphics,
  {$IFDEF VisualCLX}
  Qt, JclWideStrings,
  {$ENDIF VisualCLX}
  JvConsts, JvResources;

const
  MaxPixelCount = 32767;

{$HPPEMIT '#ifndef TDate'}
{$IFDEF VCL}
{$HPPEMIT '#define TDate Controls::TDate'}
{$HPPEMIT '#define TTime Controls::TTime'}
{$ENDIF VCL}
{$IFDEF VisualCLX}
{$HPPEMIT '#define TDate TDateTime'}
{$HPPEMIT '#define TTime TDateTime'}
type
  TDate = type TDateTime;
  {$EXTERNALSYM TDate}
  TTime = type TDateTime;
  {$EXTERNALSYM TTime}
{$ENDIF VisualCLX}
{$HPPEMIT '#endif'}

{$IFDEF VCL}
type
  PCaptionChar = PChar;

  // used in JvSpeedButton, JvArrowButton, JvButton CM_JVBUTTONPRESSED
  // asn: can also be used with CM_BUTTONPRESSED
  TCMButtonPressed = packed record
    Msg: Cardinal;
    Index: Integer;     { clx has Index and Control switched }
    Control: TControl;
    Result: Longint;
  end;

  THintString = string;
  THintStringList = TStringList;

  { JvExVCL classes }
  TInputKey = (ikAll, ikArrows, ikChars, ikButton, ikTabs, ikEdit, ikNative{, ikNav, ikEsc});
  TInputKeys = set of TInputKey;

  TJvRGBTriple = packed record
    rgbBlue: Byte;
    rgbGreen: Byte;
    rgbRed: Byte;
  end;

  TTimerProc = procedure(hwnd: HWND; Msg: Cardinal; idEvent: Cardinal; dwTime: Cardinal);

const
  NullHandle = 0;
  // (rom) deleted fbs constants. They are already in JvConsts.pas.
{$ENDIF VCL}

{$IFDEF VisualCLX}
type
  // used in JvSpeedButton, JvArrowButton, JvButton CM_BUTTONPRESSED
  // can be used with (VisualCLX) CM_BUTTONPRESSED
  TCMButtonPressed = packed record
    Msg: Cardinal;
    Control: TControl;  { with VCL Control & Indez are switched }
    Index: Integer;
    Result: Longint;    { QButtons.TCMButtonPressed has no Result }
  end;

  PCaptionChar = PWideChar;
  THintString = WideString;
  THintStringList = TWideStringList;
  TJvRGBTriple = TRGBQuad; { VisualCLX does not support pf24bit }

const
  NullHandle = nil; { clx uses typed pointers ! }
  ikButton = ikReturns;
{$ENDIF VisualCLX}

type
  {$IFDEF COMPILER5}
  EOSError = class(EWin32Error);
  IInterface = IUnknown;
  {$M+}
  IInvokable = interface(IInterface)
  end;
  {$M-}
  {$ENDIF COMPILER5}

  // Base class for persistent properties that can show events.
  // By default, Delphi and BCB don't show the events of a class
  // derived from TPersistent unless it also derives from
  // TComponent. However, up until version 5, you couldn't have
  // a Component as a Sub Component of another one, thus preventing
  // from having events for a sub property.
  // The design time editor associated with TJvPersistent will display
  // the events, thus mimicking a Sub Component.
  {$IFDEF COMPILER6_UP}
  TJvPersistent = class(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  {$ELSE}
  TJvPersistent = class(TPersistent)
  end;
  {$ENDIF COMPILER6_UP}

  TJvRegKey = (hkClassesRoot, hkCurrentUser, hkLocalMachine, hkUsers,
    hkPerformanceData, hkCurrentConfig, hkDynData);
  TJvRegKeys = set of TJvRegKey;

  // base JVCL Exception class to derive from
  EJVCLException = class(Exception);

  TJvLinkClickEvent = procedure(Sender: TObject; Link: string) of object;
  //  TOnRegistryChangeKey = procedure(Sender: TObject; RootKey: HKEY; Path: string) of object;
  //  TAngle = 0..360;
  TJvOutputMode = (omFile, omStream);
  //  TLabelDirection = (sdLeftToRight, sdRightToLeft); // JvScrollingLabel

  TJvDoneFileEvent = procedure(Sender: TObject; FileName: string; FileSize: Integer; Url: string) of object;
  TJvDoneStreamEvent = procedure(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string) of object;
  TJvHTTPProgressEvent = procedure(Sender: TObject; UserData, Position: Integer; TotalSize: Integer; Url: string; var Continue: Boolean) of object;
  TJvFTPProgressEvent = procedure(Sender: TObject; Position: Integer; Url: string) of object;

  // from JvComponent.pas
  TJvClipboardCommand = (caCopy, caCut, caPaste, caClear, caUndo);
  TJvClipboardCommands = set of TJvClipboardCommand;

  // used in JvButton
  TCMForceSize = record
    Msg: Cardinal;
    NewSize: TSmallPoint;
    Sender: TControl;
    Result: Longint;
  end;

  PJvRGBArray = ^TJvRGBArray;
  TJvRGBArray = array [0..MaxPixelCount] of TJvRGBTriple;
  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array [0..MaxPixelCount] of TRGBQuad;
  PRGBPalette = ^TRGBPalette;
  TRGBPalette = array [Byte] of TRGBQuad;

  { (rom) unused
  TJvPoint = class(TPersistent)
  protected
    FX: Integer;
    FY: Integer;
  published
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
  end;
  }

  TJvErrorEvent = procedure(Sender: TObject; ErrorMsg: string) of object;
  TJvWaveLocation = (frFile, frResource, frRAM);

  TJvPopupPosition = (ppNone, ppForm, ppApplication);
  //  TJvDirMask = (dmFileNameChange, dmDirnameChange, dmAttributesChange, dmSizeChange, dmLastWriteChange, dmSecurityChange); //JvDirectorySpy
  //  TJvDirMasks = set of TJvDirMask;
  //  EJvDirectoryError = class(EJVCLException); // JvDirectorySpy
  //  TListEvent = procedure(Sender: TObject; Title: string; Handle: THandle) of object; // JvWindowsTitle

  TJvProgressEvent = procedure(Sender: TObject; Current, Total: Integer) of object;
  TJvNextPageEvent = procedure(Sender: TObject; PageNumber: Integer) of object;
  TJvBitmapStyle = (bsNormal, bsCentered, bsStretched);

  //  TOnOpened = procedure(Sender: TObject; Value: string) of object; // archive
  //  TOnOpenCanceled = procedure(Sender: TObject) of object; // archive

  {$IFDEF COMPILER5}
  { TStream seek origins }
  TSeekOrigin = (soBeginning, soCurrent, soEnd);
  {$ENDIF COMPILER5}

  TJvGradientStyle = (grFilled, grEllipse, grHorizontal, grVertical, grPyramid, grMount);
  //  TOnDelete = procedure(Sender: TObject; Path: string) of object;
  TJvParentEvent = procedure(Sender: TObject; ParentWindow: THandle) of object;
  //  TOnImage = procedure(Sender: TObject; Image: TBitmap) of object; // JvClipboardViewer
  //  TOnText = procedure(Sender: TObject; Text: string) of object;
  //  TJvRestart = (rsLogoff, rsShutdown, rsReboot, rsRestart, rsRebootSystem, rsExitAndExecApp);
  //  TJvRunOption = (roNoBrowse, roNoDefault, roCalcDirectory, roNoLabel, roNoSeparateMem); // JvRunDlg
  //  TJvRunOptions = set of TJvRunOption; // JvRunDlg
  //  TJvFileKind = (ftFile, ftPrinter); // JvObjectPropertiesDlg

  //  TSHFormatDrive = function(Handle: HWND; Drive, ID, Options: Word): LongInt; stdcall; // JvFormatDrive
  //  TFormatOption = (shQuickFormat, shFull, shSystemFilesOnly); // JvFormatDrive
  //  TButtonStyle = (bsAbortRetryIgnore, bsOk, bsOkCancel, bsRetryCancel, bsYesNo, bsYesNoCancel); // JvMessageBox
  //  TButtonDisplay = (bdIconExclamation, bdIconWarning, bdIconInformation, bdIconAsterisk, bdIconQuestion, bdIconStop, bdIconError, bdIconHand); // JvMessageBox

  //  TDefault = (dbButton1, dbButton2, dbButton3, dbButton4); // JvMessageBox
  //  TModality = (bmApplModal, bmSystemModal, bmTaskModal); // JvMessageBox
  //  TButtonOption = (boDefaultDesktopOnly, boHelp, boRight, boRtlReading, boSetForeground, boTopMost); // JvMessageBox
  //  TButtonOptions = set of TButtonOption; // JvMessageBox
  //  TButtonResult = (brAbort, brCancel, brIgnore, brNo, brOk, brRetry, brYes); // JvMessageBox
  //  TMsgStyle = (msBeep, msIconAsterisk, msIconExclamation, msIconHand, msIconQuestion, msOk); // JvMessageBeep
  TJvDiskRes = (dsSuccess, dsCancel, dsSkipfile, dsError);
  TJvDiskStyle = (idfCheckFirst, idfNoBeep, idfNoBrowse, idfNoCompressed, idfNoDetails,
    idfNoForeground, idfNoSkip, idfOemDisk, idfWarnIfSkip);
  TJvDiskStyles = set of TJvDiskStyle;
  TJvDeleteStyle = (idNoBeep, idNoForeground);
  TJvDeleteStyles = set of TJvDeleteStyle;
  //   TOnOk = procedure(Sender: TObject; Password: string; var Accept: Boolean) of object; // JvPasswordForm

  //  TCoordChanged = procedure(Sender: TObject; Coord: string) of object;
  TJvNotifyParamsEvent = procedure(Sender: TObject; Params: Pointer) of object;

  {$IFDEF VCL}
  TJvFileInfoRec = record
    Attributes: DWORD;
    DisplayName: string;
    ExeType: Integer;
    Icon: HICON;
    Location: string;
    TypeName: string;
    SysIconIndex: Integer;
  end;
  {$ENDIF VCL}

  TJvAnimation = (anLeftRight, anRightLeft, anRightAndLeft, anLeftVumeter, anRightVumeter);
  TJvAnimations = set of TJvAnimation;
  //   TOnFound = procedure(Sender: TObject; Path: string) of object; // JvSearchFile
  //  TOnChangedDir = procedure(Sender: TObject; Directory: string) of object; // JvSearchFile
  //  TOnAlarm = procedure(Sender: TObject; Keyword: string) of object; // JvAlarm
  {  TAlarm = record
      Keyword: string;
      DateTime: TDateTime;
    end;
  } // JvAlarm

  // Bianconi - Moved from JvAlarms.pas
  TJvTriggerKind =
    (tkOneShot, tkEachSecond, tkEachMinute, tkEachHour, tkEachDay, tkEachMonth, tkEachYear);
  // End of Bianconi

  TJvFourCC = array [0..3] of Char;
  PJvAniTag = ^TJvAniTag;
  TJvAniTag = packed record
    ckID: TJvFourCC;
    ckSize: Longint;
  end;

  TJvAniHeader = packed record
    dwSizeof: Longint;
    dwFrames: Longint;
    dwSteps: Longint;
    dwCX: Longint;
    dwCY: Longint;
    dwBitCount: Longint;
    dwPlanes: Longint;
    dwJIFRate: Longint;
    dwFlags: Longint;
  end;

  TJvChangeColorEvent = procedure(Sender: TObject; Foreground, Background: TColor) of object;

  TJvLayout = (lTop, lCenter, lBottom);
  TJvBevelStyle = (bsShape, bsLowered, bsRaised);

  {for OnLoseFocus the AFocusControl argument will point at the control that
   receives focus while for OnGetFocus it is the control that lost the focus}
  TJvFocusChangeEvent = procedure(const ASender: TObject;
    const AFocusControl: TWinControl) of object;

  // JvJCLUtils
  TTickCount = Cardinal;

  {**** string handling routines}
  TSetOfChar = TSysCharSet;
  TCharSet = TSysCharSet;

  TDateOrder = (doMDY, doDMY, doYMD);
  TDayOfWeekName = (Sun, Mon, Tue, Wed, Thu, Fri, Sat);
  TDaysOfWeek = set of TDayOfWeekName;

const
  DefaultDateOrder = doDMY;

  CenturyOffset: Byte = 60;
  NullDate: TDateTime = 0; {-693594}

type
  // JvDriveCtrls / JvLookOut
  TJvImageSize = (isSmall, isLarge);
  TJvImageAlign = (iaLeft, iaCentered);

  TJvDriveType = (dtUnknown, dtRemovable, dtFixed, dtRemote, dtCDROM, dtRamDisk);
  TJvDriveTypes = set of TJvDriveType;

  // Defines how a property (like a HotTrackFont) follows changes in the component's normal Font
  TJvTrackFontOption = (
    hoFollowFont,  // makes HotTrackFont follow changes to the normal Font
    hoPreserveCharSet,  // don't change HotTrackFont.Charset
    hoPreserveColor,    // don't change HotTrackFont.Color
    hoPreserveHeight,   // don't change HotTrackFont.Height (affects Size as well)
    hoPreserveName,     // don't change HotTrackFont.Name
    hoPreservePitch,    // don't change HotTrackFont.Pitch
    hoPreserveStyle);   // don't change HotTrackFont.Style
  TJvTrackFontOptions = set of TJvTrackFontOption;

const
  DefaultTrackFontOptions = [hoFollowFont, hoPreserveColor, hoPreserveStyle];


type
  // from JvListView.pas
  TJvSortMethod = (smAutomatic, smAlphabetic, smNonCaseSensitive, smNumeric, smDate, smTime, smDateTime, smCurrency);
  TJvListViewColumnSortEvent = procedure(Sender: TObject; Column: Integer; var AMethod: TJvSortMethod) of object;

  // from JvColorProvider.pas
  TColorType = (ctStandard, ctSystem, ctCustom);

  TDefColorItem = record
    Value: TColor;
    Constant: string;
    Description: string;
  end;

const
  ColCount = 20;
  {$IFDEF VCL}
  SysColCount = 25;
  {$ENDIF VCL}
  {$IFDEF VisualCLX}
  SysColCount = 42;
  {$ENDIF VisualCLX}
  ColorValues: array [0 .. ColCount - 1] of TDefColorItem = (
    (Value: clBlack;      Constant: 'clBlack';      Description: RsClBlack),
    (Value: clMaroon;     Constant: 'clMaroon';     Description: RsClMaroon),
    (Value: clGreen;      Constant: 'clGreen';      Description: RsClGreen),
    (Value: clOlive;      Constant: 'clOlive';      Description: RsClOlive),
    (Value: clNavy;       Constant: 'clNavy';       Description: RsClNavy),
    (Value: clPurple;     Constant: 'clPurple';     Description: RsClPurple),
    (Value: clTeal;       Constant: 'clTeal';       Description: RsClTeal),
    (Value: clGray;       Constant: 'clGray';       Description: RsClGray),
    (Value: clSilver;     Constant: 'clSilver';     Description: RsClSilver),
    (Value: clRed;        Constant: 'clRed';        Description: RsClRed),
    (Value: clLime;       Constant: 'clLime';       Description: RsClLime),
    (Value: clYellow;     Constant: 'clYellow';     Description: RsClYellow),
    (Value: clBlue;       Constant: 'clBlue';       Description: RsClBlue),
    (Value: clFuchsia;    Constant: 'clFuchsia';    Description: RsClFuchsia),
    (Value: clAqua;       Constant: 'clAqua';       Description: RsClAqua),
    (Value: clWhite;      Constant: 'clWhite';      Description: RsClWhite),
    (Value: clMoneyGreen; Constant: 'clMoneyGreen'; Description: RsClMoneyGreen),
    (Value: clSkyBlue;    Constant: 'clSkyBlue';    Description: RsClSkyBlue),
    (Value: clCream;      Constant: 'clCream';      Description: RsClCream),
    (Value: clMedGray;    Constant: 'clMedGray';    Description: RsClMedGray)
  );

  SysColorValues: array [0 .. SysColCount - 1] of TDefColorItem = (
    {$IFDEF VCL}
    (Value: clScrollBar;           Constant: 'clScrollBar';           Description: RsClScrollBar),
    (Value: clBackground;          Constant: 'clBackground';          Description: RsClBackground),
    (Value: clActiveCaption;       Constant: 'clActiveCaption';       Description: RsClActiveCaption),
    (Value: clInactiveCaption;     Constant: 'clInactiveCaption';     Description: RsClInactiveCaption),
    (Value: clMenu;                Constant: 'clMenu';                Description: RsClMenu),
    (Value: clWindow;              Constant: 'clWindow';              Description: RsClWindow),
    (Value: clWindowFrame;         Constant: 'clWindowFrame';         Description: RsClWindowFrame),
    (Value: clMenuText;            Constant: 'clMenuText';            Description: RsClMenuText),
    (Value: clWindowText;          Constant: 'clWindowText';          Description: RsClWindowText),
    (Value: clCaptionText;         Constant: 'clCaptionText';         Description: RsClCaptionText),
    (Value: clActiveBorder;        Constant: 'clActiveBorder';        Description: RsClActiveBorder),
    (Value: clInactiveBorder;      Constant: 'clInactiveBorder';      Description: RsClInactiveBorder),
    (Value: clAppWorkSpace;        Constant: 'clAppWorkSpace';        Description: RsClAppWorkSpace),
    (Value: clHighlight;           Constant: 'clHighlight';           Description: RsClHighlight),
    (Value: clHighlightText;       Constant: 'clHighlightText';       Description: RsClHighlightText),
    (Value: clBtnFace;             Constant: 'clBtnFace';             Description: RsClBtnFace),
    (Value: clBtnShadow;           Constant: 'clBtnShadow';           Description: RsClBtnShadow),
    (Value: clGrayText;            Constant: 'clGrayText';            Description: RsClGrayText),
    (Value: clBtnText;             Constant: 'clBtnText';             Description: RsClBtnText),
    (Value: clInactiveCaptionText; Constant: 'clInactiveCaptionText'; Description: RsClInactiveCaptionText),
    (Value: clBtnHighlight;        Constant: 'clBtnHighlight';        Description: RsClBtnHighlight),
    (Value: cl3DDkShadow;          Constant: 'cl3DDkShadow';          Description: RsCl3DDkShadow),
    (Value: cl3DLight;             Constant: 'cl3DLight';             Description: RsCl3DLight),
    (Value: clInfoText;            Constant: 'clInfoText';            Description: RsClInfoText),
    (Value: clInfoBk;              Constant: 'clInfoBk';              Description: RsClInfoBk)
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    (Value: clNormalForeground;        Constant: 'clNormalForeground';        Description: RsClNormalForeground),
    (Value: clNormalButton;            Constant: 'clNormalButton';            Description: RsClNormalButton),
    (Value: clNormalLight;             Constant: 'clNormalLight';             Description: RsClNormalLight),
    (Value: clNormalMidlight;          Constant: 'clNormalMidlight';          Description: RsClNormalMidlight),
    (Value: clNormalDark;              Constant: 'clNormalDark';              Description: RsClNormalDark),
    (Value: clNormalMid;               Constant: 'clNormalMid';               Description: RsClNormalMid),
    (Value: clNormalText;              Constant: 'clNormalText';              Description: RsClNormalText),
    (Value: clNormalBrightText;        Constant: 'clNormalBrightText';        Description: RsClNormalBrightText),
    (Value: clNormalButtonText;        Constant: 'clNormalButtonText';        Description: RsClNormalButtonText),
    (Value: clNormalBase;              Constant: 'clNormalBase';              Description: RsClNormalBase),
    (Value: clNormalBackground;        Constant: 'clNormalBackground';        Description: RsClNormalBackground),
    (Value: clNormalShadow;            Constant: 'clNormalShadow';            Description: RsClNormalShadow),
    (Value: clNormalHighlight;         Constant: 'clNormalHighlight';         Description: RsClNormalHighlight),
    (Value: clNormalHighlightedText;   Constant: 'clNormalHighlightedText';   Description: RsClNormalHighlightedText),

    (Value: clActiveForeground;        Constant: 'clActiveForeground';        Description: RsClActiveForeground),
    (Value: clActiveButton;            Constant: 'clActiveButton';            Description: RsClActiveButton),
    (Value: clActiveLight;             Constant: 'clActiveLight';             Description: RsClActiveLight),
    (Value: clActiveMidlight;          Constant: 'clActiveMidlight';          Description: RsClActiveMidlight),
    (Value: clActiveDark;              Constant: 'clActiveDark';              Description: RsClActiveDark),
    (Value: clActiveMid;               Constant: 'clActiveMid';               Description: RsClActiveMid),
    (Value: clActiveText;              Constant: 'clActiveText';              Description: RsClActiveText),
    (Value: clActiveBrightText;        Constant: 'clActiveBrightText';        Description: RsClActiveBrightText),
    (Value: clActiveButtonText;        Constant: 'clActiveButtonText';        Description: RsClActiveButtonText),
    (Value: clActiveBase;              Constant: 'clActiveBase';              Description: RsClActiveBase),
    (Value: clActiveBackground;        Constant: 'clActiveBackground';        Description: RsClActiveBackground),
    (Value: clActiveShadow;            Constant: 'clActiveShadow';            Description: RsClActiveShadow),
    (Value: clActiveHighlight;         Constant: 'clActiveHighlight';         Description: RsClActiveHighlight),
    (Value: clActiveHighlightedText;   Constant: 'clActiveHighlightedText';   Description: RsClActiveHighlightedText),

    (Value: clDisabledForeground;      Constant: 'clDisabledForeground';      Description: RsClDisabledForeground),
    (Value: clDisabledButton;          Constant: 'clDisabledButton';          Description: RsClDisabledButton),
    (Value: clDisabledLight;           Constant: 'clDisabledLight';           Description: RsClDisabledLight),
    (Value: clDisabledMidlight;        Constant: 'clDisabledMidlight';        Description: RsClDisabledMidlight),
    (Value: clDisabledDark;            Constant: 'clDisabledDark';            Description: RsClDisabledDark),
    (Value: clDisabledMid;             Constant: 'clDisabledMid';             Description: RsClDisabledMid),
    (Value: clDisabledText;            Constant: 'clDisabledText';            Description: RsClDisabledText),
    (Value: clDisabledBrightText;      Constant: 'clDisabledBrightText';      Description: RsClDisabledBrightText),
    (Value: clDisabledButtonText;      Constant: 'clDisabledButtonText';      Description: RsClDisabledButtonText),
    (Value: clDisabledBase;            Constant: 'clDisabledBase';            Description: RsClDisabledBase),
    (Value: clDisabledBackground;      Constant: 'clDisabledBackground';      Description: RsClDisabledBackground),
    (Value: clDisabledShadow;          Constant: 'clDisabledShadow';          Description: RsClDisabledShadow),
    (Value: clDisabledHighlight;       Constant: 'clDisabledHighlight';       Description: RsClDisabledHighlight),
    (Value: clDisabledHighlightedText; Constant: 'clDisabledHighlightedText'; Description: RsClDisabledHighlightedText)
    {$ENDIF VisualCLX}
  );

type
  TJvSizeRect = packed record
    Top: Integer;
    Left: Integer;
    Width: Integer;
    Height: Integer;
  end;

  TJvMessage = packed record
    Msg: Integer;
    case Integer of
    0:
     (
      WParam: Integer;
      LParam: Integer;
      Result: Integer;
     );
    1:
     (
      WParamLo: Word;
      WParamHi: Word;
      LParamLo: Word;
      LParamHi: Word;
      ResultLo: Word;
      ResultHi: Word;
     );
    2:
     ( // WM_NOPARAMS
      Unused: array[0..3] of Word;
      Handled: LongBool;  // "Result"
     );
    3:
     ( // WM_SCROLL
      Pos: Integer;         // WParam
      ScrollCode: Integer;  // LParam
     );
    4:
     ( // WM_TIMER
      TimerID: Integer;     // WParam
      TimerProc: TTimerProc;// LParam
     );
    5:
     ( // WM_MOUSEACTIVATE
      TopLevel: HWND;       // WParam
      HitTestCode: Word;    // LParamLo
      MouseMsg: Word;       // LParamHi
     );
    6:
     ( // WM_MOUSE(WHEEL) | WM_MOVE
      case Integer of
      0:
       ( // WM_MOUSE
        Keys: Integer;     // WParam
        // LParam: Pos | (XPos, YPos)
        case Integer of
        0:
         (
          Position: TSmallPoint;
         );
        1:
         (
          XPos: Smallint;
          YPos: Smallint;
         )
       );
      1:
       ( // WM_MOUSEWHEEL
        WheelDelta: Integer; // WParam
       );
     );
    7:
     ( // WM_ACTIVATE
      Active: Word; { WA_INACTIVE, WA_ACTIVE, WA_CLICKACTIVE } // WParamLo
      Minimized: WordBool;  // WParamHi
      ActiveWindow: HWND;   // LParam
     );

    8:
     ( // WM_COMMAND
      ItemID: Word;         // WParamLo
      NotifyCode: Word;     // WParamHi
      Ctl: HWND;            // LParam
     );
    9:
     ( // WM_GETICON
      BigIcon: LongBool;
     );
    10:
     ( // CM_(FOCUS|CONTROL)CHANGED  | CM_HINTSHOW
      Reserved: Integer;      // WParam
      case Integer of
        0:
         ( // CM_(CONTROL)CHANGED
          Child: TControl;    // LParam
         );
        1:
         ( // CM_FOCUSCHANGED | CM_FORCESIZE }
          Sender: TControl;   // LParam
         );
        2:
         ( //CM_HINTSHOW
          HintInfo: PHintInfo;
         )
     );
    11:
     ( // CM_CONTROLLISTCHANGE | CM_(CONTROL)CHANGED (| CM_BUTTONPRESSED for clx)
      Control: TControl;    // WParam
      case Integer of
        0:
         ( // CM_(CONTROL)CHANGED
          Inserting: LongBool;    // LParam
         );
        1: // CM_BUTTONPRESSED (clx)
         (
          Index: Integer;
         )
     );
    12:
     ( // CM_HINTSHOWPAUSE
      WasActive: LongBool;
      Pause: PInteger;
     );
    13:
     ( // WM_KEY
      CharCode: Word;
      NotUsed: Word;
      KeyData: Integer;
     );
    14:
     ( // WM_GETTEXT
      TextMax: Integer;
      Text: PChar
     );
    15:
     ( // WM_ERASEBKGND | WM_PAINT
      DC: HDC;
     );
    16:
     ( // WM_KILLFOCUS
      FocusedWnd: HWND;
     );
    17:
     (
      NewSize: TSmallPoint; //CM_FORCESIZE wParam
     );
    {$IFDEF VCL}
    18:
     ( { alternative naming for VCL CM_BUTTONPRESSED }
      GroupIndex: Integer;
      Button: TControl;
     );
    {$ENDIF VCL}
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvTypes.pas,v $';
    Revision: '$Revision: 1.87 $';
    Date: '$Date: 2005/03/09 14:57:32 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

{$IFDEF COMPILER6_UP}
constructor TJvPersistent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  SetSubComponent(True);
  Name := 'SubComponent';
end;
{$ENDIF COMPILER6_UP}

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

