{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudickar att oratool dott de]
All Rights Reserved.

Contributor(s):
Jens Fudickar [jens dott fudickar att oratool dott de]

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvDynControlEngineDevExpCx.pas,v 1.14 2005/03/09 07:24:57 marquardt Exp $

unit JvDynControlEngineDevExpCx;

{$I jvcl.inc}

interface

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes, Controls, StdCtrls, ExtCtrls, ComCtrls, Mask, Forms, Graphics,
  Buttons, Dialogs, FileCtrl, ActnList, ImgList,
  cxLookAndFeels, cxMaskEdit, cxLabel, cxButtons, cxListBox, cxDropDownEdit,
  cxButtonEdit, cxCalendar, cxCheckBox, cxMemo, cxRadioGroup, cxImage, cxTreeView,
  cxEdit, cxCalc, cxSpinEdit, cxTimeEdit, cxCheckListBox, cxGroupBox, cxRichEdit,
  JvDynControlEngine, JvDynControlEngineIntf;

type

  TCxDynControlWrapper = class(TPersistent)
  private
    FLookAndFeel: TcxLookAndFeel;
    FStyleController: TcxEditStyleController;
  protected
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure SetStyleController(Value: TcxEditStyleController);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
    property StyleController: TcxEditStyleController read FStyleController write SetStyleController;
  end;

  IJvDynControlDevExpCx = interface
    ['{13F812FE-9F75-4529-8452-45F2D9DE5A91}']
    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxMaskEdit = class(TcxMaskEdit, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlDevExpCx, IJvDynControlReadOnly, IJvDynControlEdit)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    //IJvDynControlEdit
    procedure ControlSetPasswordChar(Value: Char);
    procedure ControlSetEditMask(const Value: string);
  end;

  TJvDynControlCxButtonEdit = class(TcxButtonEdit, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlDevExpCx, IJvDynControlReadOnly, IJvDynControlEdit, IJvDynControlButtonEdit,
    IJvDynControlButton)
  private
    FIntOnButtonClick: TNotifyEvent;
  protected
    procedure IntOnButtonClick(Sender: TObject; AButtonIndex: Integer);
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    //IJvDynControlEdit
    procedure ControlSetPasswordChar(Value: Char);
    procedure ControlSetEditMask(const Value: string);

    //IJvDynControlButtonEdit
    procedure ControlSetOnButtonClick(Value: TNotifyEvent);
    procedure ControlSetButtonCaption(const Value: string);

    //IJvDynControlButton
    procedure ControlSetGlyph(Value: TBitmap);
    procedure ControlSetNumGlyphs(Value: Integer);
    procedure ControlSetLayout(Value: TButtonLayout);
    procedure ControlSetDefault(Value: Boolean);
    procedure ControlSetCancel(Value: Boolean);
  end;

  TJvDynControlCxCalcEdit = class(TcxCalcEdit, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlDevExpCx, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxSpinEdit = class(TcxSpinEdit, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlDevExpCx, IJvDynControlSpin, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    // IJvDynControlSpin
    procedure ControlSetIncrement(Value: Integer);
    procedure ControlSetMinValue(Value: double);
    procedure ControlSetMaxValue(Value: double);
    procedure ControlSetUseForInteger(Value: Boolean);
  end;

  TJvDynControlCxFileNameEdit = class(TcxButtonEdit, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlDevExpCx, IJvDynControlFileName, IJvDynControlReadOnly)
  private
    FInitialDir: string;
    FFilterIndex: Integer;
    FFilter: string;
    FDialogOptions: TOpenOptions;
    FDialogKind: TJvDynControlFileNameDialogKind;
    FDialogTitle: string;
    FDefaultExt: string;
  public
    procedure DefaultOnButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    // IJvDynControlFileName
    procedure ControlSetInitialDir(const Value: string);
    procedure ControlSetDefaultExt(const Value: string);
    procedure ControlSetDialogTitle(const Value: string);
    procedure ControlSetDialogOptions(Value: TOpenOptions);
    procedure ControlSetFilter(const Value: string);
    procedure ControlSetFilterIndex(Value: Integer);
    procedure ControlSetDialogKind(Value: TJvDynControlFileNameDialogKind);
  end;

  TJvDynControlCxDirectoryEdit = class(TcxButtonEdit, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlDevExpCx, IJvDynControlDirectory, IJvDynControlReadOnly)
  private
    FInitialDir: string;
    FDialogOptions: TSelectDirOpts;
    FDialogTitle: string;
  public
    procedure DefaultOnButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    // IJvDynControlDirectory
    procedure ControlSetInitialDir(const Value: string);
    procedure ControlSetDialogTitle(const Value: string);
    procedure ControlSetDialogOptions(Value: TSelectDirOpts);
  end;

  TJvDynControlCxDateTimeEdit = class(TcxDateEdit, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlDevExpCx, IJvDynControlDate, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    // IJvDynControlDate
    procedure ControlSetMinDate(Value: TDateTime);
    procedure ControlSetMaxDate(Value: TDateTime);
    procedure ControlSetFormat(const Value: string);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxDateEdit = class(TcxDateEdit, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlDevExpCx, IJvDynControlDate, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    // IJvDynControlDate
    procedure ControlSetMinDate(Value: TDateTime);
    procedure ControlSetMaxDate(Value: TDateTime);
    procedure ControlSetFormat(const Value: string);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxTimeEdit = class(TcxTimeEdit, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlDevExpCx, IJvDynControlTime, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    procedure ControlSetFormat(const Value: string);
  end;

  TJvDynControlCxCheckBox = class(TcxCheckBox, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlDevExpCx, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxMemo = class(TcxMemo, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlItems, IJvDynControlMemo, IJvDynControlDevExpCx, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetSorted(Value: Boolean);
    procedure ControlSetItems(Value: TStrings);
    function ControlGetItems: TStrings;

    procedure ControlSetWantTabs(Value: Boolean);
    procedure ControlSetWantReturns(Value: Boolean);
    procedure ControlSetWordWrap(Value: Boolean);
    procedure ControlSetScrollBars(Value: TScrollStyle);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxRichEdit = class(TcxRichEdit, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlItems, IJvDynControlMemo, IJvDynControlDevExpCx, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetSorted(Value: Boolean);
    procedure ControlSetItems(Value: TStrings);
    function ControlGetItems: TStrings;

    procedure ControlSetWantTabs(Value: Boolean);
    procedure ControlSetWantReturns(Value: Boolean);
    procedure ControlSetWordWrap(Value: Boolean);
    procedure ControlSetScrollBars(Value: TScrollStyle);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxRadioGroup = class(TcxRadioGroup, IUnknown, IJvDynControl,
    IJvDynControlData, IJvDynControlItems, IJvDynControlDevExpCx,
    IJvDynControlRadioGroup, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetSorted(Value: Boolean);
    procedure ControlSetItems(Value: TStrings);
    function ControlGetItems: TStrings;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    procedure ControlSetColumns(Value: Integer);
  end;

  TJvDynControlCxListBox = class(TcxListBox, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlItems, IJvDynControlDblClick, IJvDynControlDevExpCx, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetSorted(Value: Boolean);
    procedure ControlSetItems(Value: TStrings);
    function ControlGetItems: TStrings;

    procedure ControlSetOnDblClick(Value: TNotifyEvent);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxCheckListBox = class(TcxCheckListBox, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlItems, IJvDynControlDblClick, IJvDynControlDevExpCx, IJvDynControlReadOnly,
    IJvDynControlCheckListBox)
  private
    FIntItems: TStrings;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetSorted(Value: Boolean);
    procedure ControlSetItems(Value: TStrings);
    function ControlGetItems: TStrings;

    procedure ControlSetOnDblClick(Value: TNotifyEvent);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    //IJvDynControlCheckListBox = interface
    procedure ControlSetAllowGrayed(Value: Boolean);
    procedure ControlSetChecked(Index: Integer; Value: Boolean);
    procedure ControlSetItemEnabled(Index: Integer; Value: Boolean);
    procedure ControlSetHeader(Index: Integer; Value: Boolean);
    procedure ControlSetState(Index: Integer; Value: TCheckBoxState);
    function ControlGetChecked(Index: Integer): Boolean;
    function ControlGetItemEnabled(Index: Integer): Boolean;
    function ControlGetHeader(Index: Integer): Boolean;
    function ControlGetState(Index: Integer): TCheckBoxState;
  end;

  TJvDynControlCxComboBox = class(TcxComboBox, IUnknown, IJvDynControl, IJvDynControlData,
    IJvDynControlItems, IJvDynControlDevExpCx, IJvDynControlComboBox, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetReadOnly(Value: Boolean);
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    procedure ControlSetSorted(Value: Boolean);
    procedure ControlSetItems(Value: TStrings);
    function ControlGetItems: TStrings;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);

    procedure ControlSetNewEntriesAllowed(Value: Boolean);
  end;

  TJvDynControlCxGroupBox = class(TcxGroupBox, IUnknown, IJvDynControl)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);
  end;

  TJvDynControlCxPanel = class(TPanel, IUnknown, IJvDynControl, IJvDynControlPanel)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetBorder(ABevelInner: TPanelBevel; ABevelOuter: TPanelBevel; ABevelWidth: Integer; ABorderStyle: TBorderStyle; ABorderWidth: Integer);
  end;

  TJvDynControlCxImage = class(TcxImage, IUnknown, IJvDynControl,
    IJvDynControlImage, IJvDynControlDevExpCx)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetAutoSize(Value: Boolean);
    procedure ControlSetIncrementalDisplay(Value: Boolean);
    procedure ControlSetCenter(Value: Boolean);
    procedure ControlSetProportional(Value: Boolean);
    procedure ControlSetStretch(Value: Boolean);
    procedure ControlSetTransparent(Value: Boolean);
    procedure ControlSetPicture(Value: TPicture);
    procedure ControlSetGraphic(Value: TGraphic);
    function ControlGetPicture: TPicture;

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  // (rom) TScrollBox or TcxScrollBox?
  TJvDynControlCxScrollBox = class(TScrollBox, IJvDynControl)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);
  end;

  // (rom) TLabel or TcxLabel?
  TJvDynControlCxLabel = class(TcxLabel, IUnknown, IJvDynControl, IJvDynControlLabel,
    IJvDynControlDevExpCx)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetFocusControl(Value: TWinControl);
    procedure ControlSetWordWrap(Value: Boolean);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  // (rom) Warning! TStaticText and TLabel are very different.
  TJvDynControlCxStaticText = class(TcxLabel, IUnknown, IJvDynControl, IJvDynControlDevExpCx)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxButton = class(TcxButton, IUnknown, IJvDynControl, IJvDynControlButton,
    IJvDynControlDevExpCx, IJvDynControlAction)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    procedure ControlSetGlyph(Value: TBitmap);
    procedure ControlSetNumGlyphs(Value: Integer);
    procedure ControlSetLayout(Value: TButtonLayout);
    procedure ControlSetDefault(Value: Boolean);
    procedure ControlSetCancel(Value: Boolean);

    // IJvDynControlAction
    procedure ControlSetAction(Value: TCustomAction);

    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxRadioButton = class(TCxRadioButton, IUnknown,
    IJvDynControl, IJvDynControlData, IJvDynControlDevExpCx)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    // IJvDynControlData
    procedure ControlSetOnChange(Value: TNotifyEvent);
    procedure ControlSetValue(Value: Variant);
    function ControlGetValue: Variant;

    // IJvDynControlDevExpCx
    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlCxTreeView = class(TcxTreeView, IUnknown,
    IJvDynControl, IJvDynControlTreeView,
    IJvDynControlDevExpCx, IJvDynControlReadOnly)
  public
    procedure ControlSetDefaultProperties;
    procedure ControlSetCaption(const Value: string);
    procedure ControlSetTabOrder(Value: Integer);

    procedure ControlSetOnEnter(Value: TNotifyEvent);
    procedure ControlSetOnExit(Value: TNotifyEvent);
    procedure ControlSetOnClick(Value: TNotifyEvent);
    procedure ControlSetHint(const Value: string);

    // IJvDynControlReadOnly
    procedure ControlSetReadOnly(Value: Boolean);

    // IJvDynControlTreeView
    procedure ControlSetAutoExpand(Value: Boolean);
    procedure ControlSetHotTrack(Value: Boolean);
    procedure ControlSetShowHint(Value: Boolean);
    procedure ControlSetShowLines(Value: Boolean);
    procedure ControlSetShowRoot(Value: Boolean);
    procedure ControlSetToolTips(Value: Boolean);
    procedure ControlSetItems(Value: TTreeNodes);
    function ControlGetItems: TTreeNodes;
    procedure ControlSetImages(Value: TCustomImageList);
    procedure ControlSetStateImages(Value: TCustomImageList);
    function ControlGetSelected: TTreeNode;
    procedure ControlSetOnChange(Value: TTVChangedEvent);
    procedure ControlSetSortType(Value: TSortType);

    // IJvDynControlDevExpCx
    procedure ControlSetCxProperties(Value: TCxDynControlWrapper);
  end;

  TJvDynControlEngineDevExpCx = class(TJvDynControlEngine)
  private
    FCxProperties: TCxDynControlWrapper;
  protected
    procedure SetcxProperties(Value: TCxDynControlWrapper);
    procedure RegisterControls; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function CreateControlClass(AControlClass: TControlClass; AOwner: TComponent; AParentControl: TWinControl; AControlName: string): TControl; override;
  published
    property CxProperties: TCxDynControlWrapper read FCxProperties write FCxProperties;
  end;

procedure SetDynControlEngineDevExpCxDefault;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}

function DynControlEngineDevExpCx: TJvDynControlEngineDevExpCx;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvDynControlEngineDevExpCx.pas,v $';
    Revision: '$Revision: 1.14 $';
    Date: '$Date: 2005/03/09 07:24:57 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

{$IFDEF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}

uses
  SysUtils, ExtDlgs,
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  cxTextEdit, cxControls,
  JvDynControlEngineVCL, 
  JvJclUtils, JvBrowseFolder, JvDynControlEngineTools;

var
  IntDynControlEngineDevExpCx: TJvDynControlEngineDevExpCx = nil;

//=== { TCxDynControlWrapper } ===============================================

constructor TCxDynControlWrapper.Create;
begin
  inherited Create;
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FStyleController := TcxEditStyleController.Create(nil);
end;

destructor TCxDynControlWrapper.Destroy;
begin
  FreeAndNil(FStyleController);
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TCxDynControlWrapper.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  FLookAndFeel.Assign(Value);
end;

procedure TCxDynControlWrapper.SetStyleController(Value: TcxEditStyleController);
begin
  FStyleController := Value;
end;

//=== { TJvDynControlCxMaskEdit } ============================================

procedure TJvDynControlCxMaskEdit.ControlSetDefaultProperties;
begin
  Properties.MaskKind := emkStandard;
end;

procedure TJvDynControlCxMaskEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxMaskEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxMaskEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxMaskEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxMaskEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxMaskEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxMaskEdit.ControlSetOnClick(Value: TNotifyEvent);
begin

end;

procedure TJvDynControlCxMaskEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxMaskEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxMaskEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxMaskEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxMaskEdit.ControlSetPasswordChar(Value: Char);
begin
  if Value <> #0 then
    Properties.EchoMode := eemPassword
  else
    Properties.EchoMode := eemNormal;
end;

procedure TJvDynControlCxMaskEdit.ControlSetEditMask(const Value: string);
begin
  Properties.EditMask := Value;
  Properties.MaskKind := emkStandard;
end;

//=== { TJvDynControlCxButtonEdit } ==========================================

procedure TJvDynControlCxButtonEdit.ControlSetDefaultProperties;
begin
  Properties.OnButtonClick := IntOnButtonClick;
  Properties.MaskKind := emkStandard;
end;

procedure TJvDynControlCxButtonEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxButtonEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetOnClick(Value: TNotifyEvent);
begin

end;

procedure TJvDynControlCxButtonEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxButtonEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxButtonEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxButtonEdit.ControlSetPasswordChar(Value: Char);
begin
  if Value <> #0 then
    Properties.EchoMode := eemPassword
  else
    Properties.EchoMode := eemNormal;
end;

procedure TJvDynControlCxButtonEdit.ControlSetEditMask(const Value: string);
begin
  Properties.EditMask := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetOnButtonClick(Value: TNotifyEvent);
begin
  FIntOnButtonClick := Value;;
end;

procedure TJvDynControlCxButtonEdit.ControlSetButtonCaption(const Value: string);
begin
  Properties.Buttons[0].DisplayName := Value;
end;

procedure TJvDynControlCxButtonEdit.ControlSetGlyph(Value: TBitmap);
begin
  Properties.Buttons[0].Glyph.Assign(Value);
end;

procedure TJvDynControlCxButtonEdit.ControlSetNumGlyphs(Value: Integer);
begin
end;

procedure TJvDynControlCxButtonEdit.ControlSetLayout(Value: TButtonLayout);
begin
end;

procedure TJvDynControlCxButtonEdit.ControlSetDefault(Value: Boolean);
begin
end;

procedure TJvDynControlCxButtonEdit.ControlSetCancel(Value: Boolean);
begin
end;


procedure TJvDynControlCxButtonEdit.IntOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Assigned(FIntOnButtonClick) then
    FIntOnButtonClick(Sender);
end;

//=== { TJvDynControlCxCalcEdit } ============================================

procedure TJvDynControlCxCalcEdit.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxCalcEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxCalcEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxCalcEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxCalcEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxCalcEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxCalcEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxCalcEdit.ControlSetOnClick(Value: TNotifyEvent);
begin

end;

procedure TJvDynControlCxCalcEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxCalcEdit.ControlSetValue(Value: Variant);
begin
  Self.Value := Value;
end;

function TJvDynControlCxCalcEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxCalcEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxSpinEdit } ============================================

procedure TJvDynControlCxSpinEdit.ControlSetDefaultProperties;
begin
  Text := '0';
end;

procedure TJvDynControlCxSpinEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxSpinEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetOnClick(Value: TNotifyEvent);
begin

end;

procedure TJvDynControlCxSpinEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetValue(Value: Variant);
begin
  Self.Value := Value;
end;

function TJvDynControlCxSpinEdit.ControlGetValue: Variant;
begin
  Result := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetIncrement(Value: Integer);
begin
  Properties.Increment := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetMinValue(Value: double);
begin
  Properties.MinValue := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetMaxValue(Value: double);
begin
  Properties.MaxValue := Value;
end;

procedure TJvDynControlCxSpinEdit.ControlSetUseForInteger(Value: Boolean);
begin
  if Value then
    Properties.ValueType := vtInt
  else
    Properties.ValueType := vtFloat;
end;

procedure TJvDynControlCxSpinEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxFileNameEdit } ========================================

procedure TJvDynControlCxFileNameEdit.DefaultOnButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if not Properties.ReadOnly then
  begin
    case FDialogKind of
      jdkOpen:
        with TOpenDialog.Create(Self) do
          try
            Options := FDialogOptions;
            Title := FDialogTitle;
            Filter := FFilter;
            FilterIndex := FFilterIndex;
            InitialDir := FInitialDir;
            DefaultExt := FDefaultExt;
            FileName := ControlGetValue;
            if Execute then
              ControlSetValue(FileName);
          finally
            Free;
          end;
      jdkOpenPicture:
        with TOpenPictureDialog.Create(Self) do
          try
            Options := FDialogOptions;
            Title := FDialogTitle;
            Filter := FFilter;
            FilterIndex := FFilterIndex;
            InitialDir := FInitialDir;
            DefaultExt := FDefaultExt;
            FileName := ControlGetValue;
            if Execute then
              ControlSetValue(FileName);
          finally
            Free;
          end;
      jdkSave:
        with TSaveDialog.Create(Self) do
          try
            Options := FDialogOptions;
            Title := FDialogTitle;
            Filter := FFilter;
            FilterIndex := FFilterIndex;
            InitialDir := FInitialDir;
            DefaultExt := FDefaultExt;
            FileName := ControlGetValue;
            if Execute then
              ControlSetValue(FileName);
          finally
            Free;
          end;
      jdkSavePicture:
        with TSavePictureDialog.Create(Self) do
          try
            Options := FDialogOptions;
            Title := FDialogTitle;
            Filter := FFilter;
            FilterIndex := FFilterIndex;
            InitialDir := FInitialDir;
            DefaultExt := FDefaultExt;
            FileName := ControlGetValue;
            if Execute then
              ControlSetValue(FileName);
          finally
            Free;
          end;
    end;
    if CanFocus then
      SetFocus;
  end;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetDefaultProperties;
begin
  Properties.OnButtonClick := DefaultOnButtonClick;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetCaption(const Value: string);
begin

end;

procedure TJvDynControlCxFileNameEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxFileNameEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxFileNameEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetInitialDir(const Value: string);
begin
  FInitialDir := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetDefaultExt(const Value: string);
begin
  FDefaultExt := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetDialogTitle(const Value: string);
begin
  FDialogTitle := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetDialogOptions(Value: TOpenOptions);
begin
  FDialogOptions := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetFilter(const Value: string);
begin
  FFilter := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetFilterIndex(Value: Integer);
begin
  FFilterIndex := Value;
end;

procedure TJvDynControlCxFileNameEdit.ControlSetDialogKind(Value: TJvDynControlFileNameDialogKind);
begin
  FDialogKind := Value;
end;

//=== { TJvDynControlCxDirectoryEdit } =======================================

procedure TJvDynControlCxDirectoryEdit.DefaultOnButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  Dir: string;
begin
  if not Properties.ReadOnly then
  begin
    Dir := ControlGetValue;
    if Dir = '' then
    begin
      if FInitialDir <> '' then
        Dir := FInitialDir
      else
        Dir := '\';
    end;
    if not DirectoryExists(Dir) then
      Dir := '\';
    if BrowseForFolder('', True, Dir, HelpContext) then
//    if SelectDirectory(Dir, FDialogOptions, HelpContext) then
      ControlSetValue(Dir);
    if CanFocus then
      SetFocus;
  end;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetDefaultProperties;
begin
  Properties.OnButtonClick := DefaultOnButtonClick;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxDirectoryEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetInitialDir(const Value: string);
begin
  FInitialDir := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetDialogTitle(const Value: string);
begin
  FDialogTitle := Value;
end;

procedure TJvDynControlCxDirectoryEdit.ControlSetDialogOptions(Value: TSelectDirOpts);
begin
  FDialogOptions := Value;
end;

//=== { TJvDynControlCxDateTimeEdit } ========================================

procedure TJvDynControlCxDateTimeEdit.ControlSetDefaultProperties;
begin
  Properties.ShowTime  := True;
  Properties.SaveTime  := False;
  Properties.InputKind := ikStandard;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxDateTimeEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

// IJvDynControlDate
procedure TJvDynControlCxDateTimeEdit.ControlSetMinDate(Value: TDateTime);
begin
  Properties.MinDate := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetMaxDate(Value: TDateTime);
begin
  Properties.MaxDate := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetFormat(const Value: string);
begin
//  Format := Value;
end;

procedure TJvDynControlCxDateTimeEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxDateEdit } ============================================

procedure TJvDynControlCxDateEdit.ControlSetDefaultProperties;
begin
  Properties.ShowTime  := False;
  Properties.SaveTime  := False;
  Properties.InputKind := ikStandard;
end;

procedure TJvDynControlCxDateEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxDateEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxDateEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxDateEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

// IJvDynControlDate
procedure TJvDynControlCxDateEdit.ControlSetMinDate(Value: TDateTime);
begin
  Properties.MinDate := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetMaxDate(Value: TDateTime);
begin
  Properties.MaxDate := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetFormat(const Value: string);
begin
//  Format := Value;
end;

procedure TJvDynControlCxDateEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxTimeEdit } ============================================

procedure TJvDynControlCxTimeEdit.ControlSetDefaultProperties;
begin
  Properties.ShowDate := False;
  Properties.UseCtrlIncrement := True;
end;

procedure TJvDynControlCxTimeEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxTimeEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxTimeEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxTimeEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxTimeEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxTimeEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxTimeEdit.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxTimeEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxTimeEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxTimeEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxTimeEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxTimeEdit.ControlSetFormat(const Value: string);
begin
//  Properties.Format := Value;
  Properties.Use24HourFormat := (Pos('H', Value) > 0);
  if (Pos('s', Value) > 0) then
    Properties.TimeFormat := tfHourMinSec
  else
  if (Pos('m', Value) > 0) then
    Properties.TimeFormat := tfHourMin
  else
    Properties.TimeFormat := tfHour;
end;

//=== { TJvDynControlCxCheckBox } ============================================

procedure TJvDynControlCxCheckBox.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxCheckBox.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetCaption(const Value: string);
begin
  Properties.Caption := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxCheckBox.ControlSetValue(Value: Variant);
begin
  Checked := JvDynControlVariantToBoolean(Value);
end;

function TJvDynControlCxCheckBox.ControlGetValue: Variant;
begin
  Result := Checked;
end;

procedure TJvDynControlCxCheckBox.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxMemo } ================================================

procedure TJvDynControlCxMemo.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxMemo.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxMemo.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxMemo.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxMemo.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxMemo.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxMemo.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxMemo.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxMemo.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxMemo.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxMemo.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxMemo.ControlSetSorted(Value: Boolean);
begin
end;

procedure TJvDynControlCxMemo.ControlSetItems(Value: TStrings);
begin
  Lines.Assign(Value);
end;

function TJvDynControlCxMemo.ControlGetItems: TStrings;
begin
  Result := Lines;
end;

procedure TJvDynControlCxMemo.ControlSetWantTabs(Value: Boolean);
begin
  Properties.WantTabs := Value;
end;

procedure TJvDynControlCxMemo.ControlSetWantReturns(Value: Boolean);
begin
  Properties.WantReturns := Value;
end;

procedure TJvDynControlCxMemo.ControlSetWordWrap(Value: Boolean);
begin
  Properties.WordWrap := Value;
end;

procedure TJvDynControlCxMemo.ControlSetScrollBars(Value: TScrollStyle);
begin
  Properties.ScrollBars := Value;
end;

procedure TJvDynControlCxMemo.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxRichEdit } ============================================

procedure TJvDynControlCxRichEdit.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxRichEdit.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxRichEdit.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxRichEdit.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxRichEdit.ControlSetSorted(Value: Boolean);
begin
end;

procedure TJvDynControlCxRichEdit.ControlSetItems(Value: TStrings);
begin
  Lines.Assign(Value);
end;

function TJvDynControlCxRichEdit.ControlGetItems: TStrings;
begin
  Result := Lines;
end;

procedure TJvDynControlCxRichEdit.ControlSetWantTabs(Value: Boolean);
begin
  Properties.WantTabs := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetWantReturns(Value: Boolean);
begin
  Properties.WantReturns := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetWordWrap(Value: Boolean);
begin
  Properties.WordWrap := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetScrollBars(Value: TScrollStyle);
begin
  Properties.ScrollBars := Value;
end;

procedure TJvDynControlCxRichEdit.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxRadioGroup } ==========================================

procedure TJvDynControlCxRadioGroup.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxRadioGroup.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxRadioGroup.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxRadioGroup.ControlSetValue(Value: Variant);
var
  I: Integer;
begin
  if VarIsInt(Value) then
    ItemIndex := Value
  else
  begin
    ItemIndex := -1;
    for I := 0 to Properties.Items.Count - 1 do
      if TcxRadioGroupItem(Properties.Items[I]).Caption = Value then
      begin
        ItemIndex := I;
        Break;
      end;
  end;
end;

function TJvDynControlCxRadioGroup.ControlGetValue: Variant;
begin
  Result := ItemIndex;
end;

procedure TJvDynControlCxRadioGroup.ControlSetSorted(Value: Boolean);
begin
end;

procedure TJvDynControlCxRadioGroup.ControlSetItems(Value: TStrings);
var
  I: Integer;
  Item: TcxRadioGroupItem;
begin
  Properties.Items.Clear;
  for I := 0 to Value.Count - 1 do
  begin
    Item := TcxRadioGroupItem(Properties.Items.Add);
    Item.Caption := Value[I];
  end;
end;

function TJvDynControlCxRadioGroup.ControlGetItems: TStrings;
begin
//  Result := TStrings(Properties.Items);
  Result := nil;
end;

procedure TJvDynControlCxRadioGroup.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxRadioGroup.ControlSetColumns(Value: Integer);
begin
  Properties.Columns := Value;
end;

//=== { TJvDynControlCxListBox } =============================================

procedure TJvDynControlCxListBox.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxListBox.ControlSetReadOnly(Value: Boolean);
begin
  ReadOnly := Value;
end;

procedure TJvDynControlCxListBox.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxListBox.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxListBox.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxListBox.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxListBox.ControlSetOnChange(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxListBox.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxListBox.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxListBox.ControlSetValue(Value: Variant);
begin
  if VarIsInt(Value) then
    ItemIndex := Value
  else
    ItemIndex := Items.IndexOf(Value);
end;

function TJvDynControlCxListBox.ControlGetValue: Variant;
begin
  Result := ItemIndex;
end;

procedure TJvDynControlCxListBox.ControlSetSorted(Value: Boolean);
begin
  Sorted := Value;
end;

procedure TJvDynControlCxListBox.ControlSetItems(Value: TStrings);
begin
  Items.Assign(Value);
end;

function TJvDynControlCxListBox.ControlGetItems: TStrings;
begin
  Result := Items;
end;

procedure TJvDynControlCxListBox.ControlSetOnDblClick(Value: TNotifyEvent);
begin
  OnDblClick := Value;
end;

procedure TJvDynControlCxListBox.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxCheckListBox } ========================================

constructor TJvDynControlCxCheckListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIntItems := TStringList.Create;
end;

destructor TJvDynControlCxCheckListBox.Destroy;
begin
  FIntItems.Free;
  Inherited Destroy;
end;

procedure TJvDynControlCxCheckListBox.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxCheckListBox.ControlSetReadOnly(Value: Boolean);
begin
  ReadOnly := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxCheckListBox.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetOnChange(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxCheckListBox.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetValue(Value: Variant);
begin
  if VarIsInt(Value) then
    ItemIndex := Value
  else
    ItemIndex := Items.IndexOf(Value);
end;

function TJvDynControlCxCheckListBox.ControlGetValue: Variant;
begin
  Result := ItemIndex;
end;

procedure TJvDynControlCxCheckListBox.ControlSetSorted(Value: Boolean);
begin
  Sorted := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetItems(Value: TStrings);
var
  I: Integer;
begin
  FIntItems.Assign(Value);
  Items.Clear;
  for I := 0 to FIntItems.Count-1 do
    with Items.Add do
      Text := FIntItems[I];
end;

function TJvDynControlCxCheckListBox.ControlGetItems: TStrings;
var
  I: Integer;
begin
  FIntItems.Clear;
  for I := 0 to Items.Count-1 do
    FIntItems.Add(Items[I].Text);
  Result.Assign(FIntItems);
end;

procedure TJvDynControlCxCheckListBox.ControlSetOnDblClick(Value: TNotifyEvent);
begin
  OnDblClick := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//IJvDynControlCheckListBox = interface
procedure TJvDynControlCxCheckListBox.ControlSetAllowGrayed(Value: Boolean);
begin
  AllowGrayed := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetChecked(Index: Integer; Value: Boolean);
begin
  Items[Index].Checked := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetItemEnabled(Index: Integer; Value: Boolean);
begin
  Items[Index].Enabled := Value;
end;

procedure TJvDynControlCxCheckListBox.ControlSetHeader(Index: Integer; Value: Boolean);
begin
end;

procedure TJvDynControlCxCheckListBox.ControlSetState(Index: Integer; Value: TCheckBoxState);
begin
  case Value of
    cbUnchecked:
      Items[Index].State := cbsUnchecked;
    cbChecked:
      Items[Index].State := cbsChecked;
    cbGrayed:
      Items[Index].State := cbsGrayed;
  end;
end;

function TJvDynControlCxCheckListBox.ControlGetChecked(Index: Integer): Boolean;
begin
  Result := Items[Index].Checked;
end;

function TJvDynControlCxCheckListBox.ControlGetItemEnabled(Index: Integer): Boolean;
begin
  Result := Items[Index].Enabled;
end;

function TJvDynControlCxCheckListBox.ControlGetHeader(Index: Integer): Boolean;
begin
  Result := False;
end;

function TJvDynControlCxCheckListBox.ControlGetState(Index: Integer): TCheckBoxState;
begin
  case Items[Index].State of
    cbsUnchecked:
      Result := cbUnchecked;
    cbsChecked:
      Result := cbChecked;
  else
    Result := cbGrayed;
  end;
end;

//=== { TJvDynControlCxComboBox } ============================================

procedure TJvDynControlCxComboBox.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxComboBox.ControlSetReadOnly(Value: Boolean);
begin
  Properties.ReadOnly := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetCaption(const Value: string);
begin
end;

procedure TJvDynControlCxComboBox.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetOnChange(Value: TNotifyEvent);
begin
  Properties.OnChange := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetValue(Value: Variant);
begin
  Text := Value;
end;

function TJvDynControlCxComboBox.ControlGetValue: Variant;
begin
  Result := Text;
end;

procedure TJvDynControlCxComboBox.ControlSetSorted(Value: Boolean);
begin
  Properties.Sorted := Value;
end;

procedure TJvDynControlCxComboBox.ControlSetItems(Value: TStrings);
begin
  Properties.Items.Assign(Value);
end;

function TJvDynControlCxComboBox.ControlGetItems: TStrings;
begin
  Result := Properties.Items;
end;

procedure TJvDynControlCxComboBox.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

procedure TJvDynControlCxComboBox.ControlSetNewEntriesAllowed(Value: Boolean);
begin
  if Value then
    Properties.DropDownListStyle := lsEditList
  else
    Properties.DropDownListStyle := lsEditFixedList;
end;

//=== { TJvDynControlCxGroupBox } ============================================

procedure TJvDynControlCxGroupBox.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxGroupBox.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxGroupBox.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxGroupBox.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxGroupBox.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxGroupBox.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxGroupBox.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

//=== { TJvDynControlCxPanel } ===============================================

procedure TJvDynControlCxPanel.ControlSetDefaultProperties;
begin
  BevelInner := bvNone;
  BevelOuter := bvNone;
end;

procedure TJvDynControlCxPanel.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxPanel.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxPanel.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxPanel.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxPanel.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxPanel.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxPanel.ControlSetBorder(ABevelInner: TPanelBevel; ABevelOuter: TPanelBevel; ABevelWidth: Integer; ABorderStyle: TBorderStyle; ABorderWidth: Integer);
begin
  BorderWidth := ABorderWidth;
  BorderStyle := ABorderStyle;
  BevelInner  := ABevelInner;
  BevelOuter  := ABevelOuter;
  BevelWidth  := ABevelWidth;
end;

//=== { TJvDynControlCxImage } ===============================================

procedure TJvDynControlCxImage.ControlSetDefaultProperties;
begin
  //Properties.GraphicTransparency := gtOpaque;
  ParentColor := True;
end;

procedure TJvDynControlCxImage.ControlSetCaption(const Value: string);
begin
  Properties.Caption := Value;
end;

procedure TJvDynControlCxImage.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxImage.ControlSetOnEnter(Value: TNotifyEvent);
begin
//  OnEnter := Value;
end;

procedure TJvDynControlCxImage.ControlSetOnExit(Value: TNotifyEvent);
begin
//  OnExit := Value;
end;

procedure TJvDynControlCxImage.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxImage.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxImage.ControlSetAutoSize(Value: Boolean);
begin
  AutoSize := Value;
end;

procedure TJvDynControlCxImage.ControlSetIncrementalDisplay(Value: Boolean);
begin
//  Properties.IncrementalDisplay := Value;
end;

procedure TJvDynControlCxImage.ControlSetCenter(Value: Boolean);
begin
  Properties.Center := Value;
end;

procedure TJvDynControlCxImage.ControlSetProportional(Value: Boolean);
begin
//  Properties.Proportional := Value;
end;

procedure TJvDynControlCxImage.ControlSetStretch(Value: Boolean);
begin
  Properties.Stretch := Value;
end;

procedure TJvDynControlCxImage.ControlSetTransparent(Value: Boolean);
begin
  if Value then
    Properties.GraphicTransparency := gtDefault
  else
    Properties.GraphicTransparency := gtTransparent;
end;

procedure TJvDynControlCxImage.ControlSetPicture(Value: TPicture);
begin
  Picture.Assign(Value);
end;

procedure TJvDynControlCxImage.ControlSetGraphic(Value: TGraphic);
begin
  Picture.Assign(Value);
end;

function TJvDynControlCxImage.ControlGetPicture: TPicture;
begin
  Result := Picture;
end;

procedure TJvDynControlCxImage.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  if Assigned(Style.StyleController) then
  begin
    Style.StyleController := Value.StyleController;
    Style.StyleController.Style.BorderStyle := ebsNone;
  end;
end;

//=== { TJvDynControlCxScrollBox } ===========================================

procedure TJvDynControlCxScrollBox.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxScrollBox.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxScrollBox.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxScrollBox.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxScrollBox.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxScrollBox.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxScrollBox.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

//=== { TJvDynControlCxLabel } ===============================================

procedure TJvDynControlCxLabel.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxLabel.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxLabel.ControlSetTabOrder(Value: Integer);
begin
end;

procedure TJvDynControlCxLabel.ControlSetOnEnter(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxLabel.ControlSetOnExit(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxLabel.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxLabel.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxLabel.ControlSetFocusControl(Value: TWinControl);
begin
  FocusControl := Value;
end;

procedure TJvDynControlCxLabel.ControlSetWordWrap(Value: Boolean);
begin
  Properties.WordWrap := Value;
end;

procedure TJvDynControlCxLabel.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxStaticText } ==========================================

procedure TJvDynControlCxStaticText.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxStaticText.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxStaticText.ControlSetTabOrder(Value: Integer);
begin
end;

procedure TJvDynControlCxStaticText.ControlSetOnEnter(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxStaticText.ControlSetOnExit(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxStaticText.ControlSetOnClick(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxStaticText.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxStaticText.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  Style.LookAndFeel.Assign(Value.LookAndFeel);
  Style.StyleController := Value.StyleController;
end;

//=== { TJvDynControlCxButton } ==============================================

procedure TJvDynControlCxButton.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxButton.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxButton.ControlSetTabOrder(Value: Integer);
begin
end;

procedure TJvDynControlCxButton.ControlSetOnEnter(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxButton.ControlSetOnExit(Value: TNotifyEvent);
begin
end;

procedure TJvDynControlCxButton.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxButton.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxButton.ControlSetGlyph(Value: TBitmap);
begin
  Glyph.Assign(Value);
end;

procedure TJvDynControlCxButton.ControlSetNumGlyphs(Value: Integer);
begin
  NumGlyphs := Value;
end;

procedure TJvDynControlCxButton.ControlSetLayout(Value: TButtonLayout);
begin
  Layout := Value;
end;

procedure TJvDynControlCxButton.ControlSetDefault(Value: Boolean);
begin
  Default := Value;
end;

procedure TJvDynControlCxButton.ControlSetCancel(Value: Boolean);
begin
  Cancel := Value;
end;

procedure TJvDynControlCxButton.ControlSetAction(Value: TCustomAction);
begin
  Action := Value;
end;


procedure TJvDynControlCxButton.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  LookAndFeel.Assign(Value.LookAndFeel);
end;

//=== { TJvDynControlCxTreeView } =========================================

procedure TJvDynControlCxTreeView.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxTreeView.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetReadOnly(Value: Boolean);
begin
  ReadOnly := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetAutoExpand(Value: Boolean);
begin
  AutoExpand := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetHotTrack(Value: Boolean);
begin
  HotTrack := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetShowHint(Value: Boolean);
begin
  ShowHint := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetShowLines(Value: Boolean);
begin
  ShowLines := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetShowRoot(Value: Boolean);
begin
  ShowRoot := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetToolTips(Value: Boolean);
begin
  ToolTips := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetItems(Value: TTreeNodes);
begin
//  Items.Assign(Value);
  Items := Value;
end;

function TJvDynControlCxTreeView.ControlGetItems: TTreeNodes;
begin
  Result := Items;
end;

procedure TJvDynControlCxTreeView.ControlSetImages(Value: TCustomImageList);
begin
  Images.Assign(Value);
end;

procedure TJvDynControlCxTreeView.ControlSetStateImages(Value: TCustomImageList);
begin
  StateImages.Assign(Value);
end;

function TJvDynControlCxTreeView.ControlGetSelected: TTreeNode;
begin
  Result := Selected;
end;

procedure TJvDynControlCxTreeView.ControlSetOnChange(Value: TTVChangedEvent);
begin
  OnChange := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetSortType(Value: TSortType);
begin
  SortType := Value;
end;

procedure TJvDynControlCxTreeView.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  LookAndFeel.Assign(Value.LookAndFeel);
end;

//=== { TJvDynControlCxRadioButton } =========================================

procedure TJvDynControlCxRadioButton.ControlSetDefaultProperties;
begin
end;

procedure TJvDynControlCxRadioButton.ControlSetCaption(const Value: string);
begin
  Caption := Value;
end;

procedure TJvDynControlCxRadioButton.ControlSetTabOrder(Value: Integer);
begin
  TabOrder := Value;
end;

procedure TJvDynControlCxRadioButton.ControlSetOnEnter(Value: TNotifyEvent);
begin
  OnEnter := Value;
end;

procedure TJvDynControlCxRadioButton.ControlSetOnExit(Value: TNotifyEvent);
begin
  OnExit := Value;
end;

procedure TJvDynControlCxRadioButton.ControlSetOnClick(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxRadioButton.ControlSetHint(const Value: string);
begin
  Hint := Value;
end;

// IJvDynControlData
procedure TJvDynControlCxRadioButton.ControlSetOnChange(Value: TNotifyEvent);
begin
  OnClick := Value;
end;

procedure TJvDynControlCxRadioButton.ControlSetValue(Value: Variant);
begin
  Checked := JvDynControlVariantToBoolean(Value);
end;

function TJvDynControlCxRadioButton.ControlGetValue: Variant;
begin
  Result := Checked;
end;

procedure TJvDynControlCxRadioButton.ControlSetCxProperties(Value: TCxDynControlWrapper);
begin
  LookAndFeel.Assign(Value.LookAndFeel);
end;

//=== { TJvDynControlEngineDevExpCx } ========================================

constructor TJvDynControlEngineDevExpCx.Create;
begin
  inherited Create;
  FCxProperties := TCxDynControlWrapper.Create;
end;

destructor TJvDynControlEngineDevExpCx.Destroy;
begin
  FreeAndNil(FCxProperties);
  inherited Destroy;
end;

procedure TJvDynControlEngineDevExpCx.SetcxProperties(Value: TCxDynControlWrapper);
begin
  if Value is TCxDynControlWrapper then
  begin
    FCxProperties.LookAndFeel := Value.LookAndFeel;
    FCxProperties.StyleController := Value.StyleController;
  end;
end;

procedure TJvDynControlEngineDevExpCx.RegisterControls;
begin
  RegisterControlType(jctLabel, TJvDynControlCxLabel);
  RegisterControlType(jctStaticText, TJvDynControlCxStaticText);
  RegisterControlType(jctButton, TJvDynControlCxButton);
  RegisterControlType(jctRadioButton, TJvDynControlCxRadioButton);
  RegisterControlType(jctScrollBox, TJvDynControlCxScrollBox);
  RegisterControlType(jctGroupBox, TJvDynControlCxGroupBox);
  RegisterControlType(jctPanel, TJvDynControlCxPanel);
  RegisterControlType(jctImage, TJvDynControlCxImage);
  RegisterControlType(jctCheckBox, TJvDynControlCxCheckBox);
  RegisterControlType(jctComboBox, TJvDynControlCxComboBox);
  RegisterControlType(jctListBox, TJvDynControlCxListBox);
  RegisterControlType(jctCheckListBox, TJvDynControlCxCheckListBox);
  RegisterControlType(jctRadioGroup, TJvDynControlCxRadioGroup);
  RegisterControlType(jctDateTimeEdit, TJvDynControlCxDateTimeEdit);
  RegisterControlType(jctTimeEdit, TJvDynControlCxTimeEdit);
  RegisterControlType(jctDateEdit, TJvDynControlCxDateEdit);
  RegisterControlType(jctEdit, TJvDynControlCxMaskEdit);
  RegisterControlType(jctCalculateEdit, TJvDynControlCxCalcEdit);
  RegisterControlType(jctSpinEdit, TJvDynControlCxSpinEdit);
  RegisterControlType(jctDirectoryEdit, TJvDynControlCxDirectoryEdit);
  RegisterControlType(jctFileNameEdit, TJvDynControlCxFileNameEdit);
  RegisterControlType(jctMemo, TJvDynControlCxMemo);
  RegisterControlType(jctRichEdit, TJvDynControlCxRichEdit);
  RegisterControlType(jctButtonEdit, TJvDynControlCxButtonEdit);
  RegisterControlType(jctTreeVIew, TJvDynControlCxTreeView);
end;

function TJvDynControlEngineDevExpCx.CreateControlClass(AControlClass: TControlClass; AOwner: TComponent; AParentControl: TWinControl; AControlName: string): TControl;
var
  Control: TControl;
begin
  Control := inherited CreateControlClass(AControlClass, AOwner, AParentControl, AControlName);
  if Supports(Control, IJvDynControlDevExpCx) then
    with Control as IJvDynControlDevExpCx do
      ControlSetCxProperties(cxProperties);
  Result := Control;
end;

//=== { DynControlEngineDevExpCx } ===========================================

procedure SetDynControlEngineDevExpCxDefault;
begin
  SetDefaultDynControlEngine(IntDynControlEngineDevExpCx);
end;

{$ENDIF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}

function DynControlEngineDevExpCx: TJvDynControlEngineDevExpCx;
begin
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}
  Result := IntDynControlEngineDevExpCx;
  {$ELSE}
  Result := nil;
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}
end;

initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}
  IntDynControlEngineDevExpCx := TJvDynControlEngineDevExpCx.Create;
  SetDefaultDynControlEngine(IntDynControlEngineDevExpCx);
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}

finalization
  {$IFDEF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}
  FreeAndNil(IntDynControlEngineDevExpCx);
  {$ENDIF USE_3RDPARTY_DEVEXPRESS_CXEDITOR}
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.
