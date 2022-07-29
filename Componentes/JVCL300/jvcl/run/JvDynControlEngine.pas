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
// $Id: JvDynControlEngine.pas,v 1.32 2005/03/09 07:24:57 marquardt Exp $

unit JvDynControlEngine;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes, Controls, Forms, StdCtrls, Graphics, Buttons,
  JvDynControlEngineIntf;

type
  TJvDynControlType = string;

const
  jctLabel = TJvDynControlType('Label');
  jctStaticText = TJvDynControlType('StaticText');
  jctPanel = TJvDynControlType('Panel');
  jctScrollBox = TJvDynControlType('ScrollBox');
  jctEdit = TJvDynControlType('Edit');
  jctCheckBox = TJvDynControlType('CheckBox');
  jctComboBox = TJvDynControlType('ComboBox');
  jctGroupBox = TJvDynControlType('GroupBox');
  jctImage = TJvDynControlType('Image');
  jctRadioGroup = TJvDynControlType('RadioGroup');
  jctRadioButton = TJvDynControlType('RadioButton');
  jctMemo = TJvDynControlType('Memo');
  jctRichEdit = TJvDynControlType('RichEdit');
  jctListBox = TJvDynControlType('ListBox');
  jctCheckListBox = TJvDynControlType('CheckListBox');
  jctDateTimeEdit = TJvDynControlType('DateTimeEdit');
  jctDateEdit = TJvDynControlType('DateEdit');
  jctTimeEdit = TJvDynControlType('TimeEdit');
  jctCalculateEdit = TJvDynControlType('CalculateEdit');
  jctSpinEdit = TJvDynControlType('SpinEdit');
  jctDirectoryEdit = TJvDynControlType('DirectoryEdit');
  jctFileNameEdit = TJvDynControlType('FileNameEdit');
  jctButton = TJvDynControlType('Button');
  jctButtonEdit = TJvDynControlType('ButtonEdit');
  jctTreeView = TJvDynControlType('TreeView');
  jctForm = TJvDynControlType('Form');

type
  TControlClass = class of TControl;

  TJvControlClassObject = class(TObject)
  private
    FControlClass: TControlClass;
  public
    property ControlClass: TControlClass read FControlClass write FControlClass;
  end;

  TJvAfterCreateControl = procedure(AControl: TControl) of object;

  TJvCustomDynControlEngine = class(TPersistent)
  private
    //FRegisteredControlTypes: array [TJvDynControlType] of TControlClass;
    FRegisteredControlTypes: TStringList;
    FRegisterControlsExecuted: Boolean;
    FAfterCreateControl: TJvAfterCreateControl;
    function GetPropName(Instance: TPersistent; Index: Integer): string;
    function GetPropCount(Instance: TPersistent): Integer;
  protected
    procedure SetPropertyValue(const APersistent: TPersistent; const APropertyName: string; const AValue: Variant);
    function GetPropertyValue(const APersistent: TPersistent; const APropertyName: string): Variant;
    procedure AfterCreateControl(AControl: TControl); virtual;
    procedure NeedRegisterControls;
    procedure RegisterControls; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function GetRegisteredControlClass(AControlType: TJvDynControlType): TControlClass;

    function CreateControl(AControlType: TJvDynControlType; AOwner: TComponent;
      AParentControl: TWinControl; AControlName: string): TControl; virtual;
    function CreateControlClass(AControlClass: TControlClass; AOwner: TComponent;
      AParentControl: TWinControl; AControlName: string): TControl; virtual;

    function IsControlTypeRegistered(const ADynControlType: TJvDynControlType): Boolean;

    function IsControlTypeValid(const ADynControlType: TJvDynControlType;
      AControlClass: TControlClass): Boolean; virtual;
    procedure RegisterControlType(const ADynControlType: TJvDynControlType;
      AControlClass: TControlClass); virtual;

    procedure SetControlCaption(AControl: IJvDynControl; const Value: string);
    procedure SetControlTabOrder(AControl: IJvDynControl; Value: Integer);

    procedure SetControlOnEnter(AControl: IJvDynControl; Value: TNotifyEvent);
    procedure SetControlOnExit(AControl: IJvDynControl; Value: TNotifyEvent);
    procedure SetControlOnClick(AControl: IJvDynControl; Value: TNotifyEvent);
  published
    property OnAfterCreateControl: TJvAfterCreateControl read FAfterCreateControl write FAfterCreateControl;
  end;

  TJvDynControlEngine = class(TJvCustomDynControlEngine)
  private
    FDistanceBetweenLabelAndControlHorz: Integer;
    FDistanceBetweenLabelAndControlVert: Integer;
  public
    constructor Create; override;
    function CreateLabelControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string; AFocusControl: TWinControl): TControl; virtual;
    function CreateStaticTextControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string): TWinControl; virtual;
    function CreatePanelControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string; AAlign: TAlign): TWinControl; virtual;
    function CreateScrollBoxControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateEditControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateCheckboxControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string): TWinControl; virtual;
    function CreateComboBoxControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string; AItems: TStrings): TWinControl; virtual;
    function CreateGroupBoxControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string): TWinControl; virtual;
    function CreateImageControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateRadioGroupControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string; AItems: TStrings;
      AItemIndex: Integer = 0): TWinControl; virtual;
    function CreateMemoControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateRichEditControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateListBoxControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string; AItems: TStrings): TWinControl; virtual;
    function CreateCheckListBoxControl(AOwner: TComponent;
      AParentControl: TWinControl; const AControlName: string; AItems: TStrings): TWinControl;
    function CreateDateTimeControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateDateControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateTimeControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateCalculateControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateSpinControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateDirectoryControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateFileNameControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateTreeViewControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string): TWinControl; virtual;
    function CreateButton(AOwner: TComponent; AParentControl: TWinControl;
      const AButtonName, ACaption, AHint: string;
      AOnClick: TNotifyEvent; ADefault: Boolean = False;
      ACancel: Boolean = False): TButton; virtual;
    function CreateRadioButton(AOwner: TComponent; AParentControl: TWinControl;
      const ARadioButtonName, ACaption: string): TWinControl; virtual;
    function CreateButtonEditControl(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName: string; AOnButtonClick: TNotifyEvent): TWinControl; virtual;
    function CreateForm(const ACaption, AHint: string): TCustomForm; virtual;

    function CreateLabelControlPanel(AOwner: TComponent; AParentControl: TWinControl;
      const AControlName, ACaption: string; AFocusControl: TWinControl;
      ALabelOnTop: Boolean = True; ALabelDefaultWidth: Integer = 0): TWinControl; virtual;
  published
    property DistanceBetweenLabelAndControlHorz: Integer read FDistanceBetweenLabelAndControlHorz write FDistanceBetweenLabelAndControlHorz default 4;
    property DistanceBetweenLabelAndControlVert: Integer read FDistanceBetweenLabelAndControlVert write FDistanceBetweenLabelAndControlVert default 1;
  end;

{$IFDEF COMPILER5}
function Supports(Instance: TObject; const Intf: TGUID): Boolean; overload;
function Supports(AClass: TClass; const Intf: TGUID): Boolean; overload;
{$ENDIF COMPILER5}

function IntfCast(Instance: TObject; const Intf: TGUID): IUnknown;

procedure SetDefaultDynControlEngine(AEngine: TJvDynControlEngine);
function DefaultDynControlEngine: TJvDynControlEngine;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvDynControlEngine.pas,v $';
    Revision: '$Revision: 1.32 $';
    Date: '$Date: 2005/03/09 07:24:57 $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  SysUtils, TypInfo,
  JvResources, JvTypes, JvDynControlEngineVCL;

var
  GlobalDefaultDynControlEngine: TJvDynControlEngine = nil;

{$IFDEF COMPILER5}

function Supports(Instance: TObject; const Intf: TGUID): Boolean;
begin
  Result := Instance.GetInterfaceEntry(Intf) <> nil;
end;

function Supports(AClass: TClass; const Intf: TGUID): Boolean;
begin
  Result := AClass.GetInterfaceEntry(Intf) <> nil;
end;

{$ENDIF COMPILER5}

function IntfCast(Instance: TObject; const Intf: TGUID): IUnknown;
begin
  if not Supports(Instance, Intf, Result) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
end;

//=== { TJvCustomDynControlEngine } ==========================================

constructor TJvCustomDynControlEngine.Create;
begin
  inherited Create;
  FRegisteredControlTypes := TStringList.Create;
end;

destructor TJvCustomDynControlEngine.Destroy;
var
  Ind: Integer;
begin
  for Ind := 0 to FRegisteredControlTypes.Count - 1 do
    if Assigned(FRegisteredControlTypes.Objects[Ind]) then
      FRegisteredControlTypes.Objects[Ind].Free;
  FRegisteredControlTypes.Free;
  inherited Destroy;
end;

function TJvCustomDynControlEngine.IsControlTypeRegistered(const ADynControlType: TJvDynControlType): Boolean;
var
  Ind: Integer;
begin
  NeedRegisterControls;
  Ind := FRegisteredControlTypes.IndexOf(ADynControlType);
  if Ind >= 0 then
    Result := Assigned(FRegisteredControlTypes.Objects[Ind])
  else
    Result := False;
end;

function TJvCustomDynControlEngine.IsControlTypeValid(const ADynControlType: TJvDynControlType;
  AControlClass: TControlClass): Boolean;
var
  Valid: Boolean;
begin
  Valid := Supports(AControlClass, IJvDynControl);
  if ADynControlType = jctButton then
    Valid := Valid and Supports(AControlClass, IJvDynControlButton)
  else
  if ADynControlType = jctButtonEdit then
    Valid := Valid and Supports(AControlClass, IJvDynControlButton) and
      Supports(AControlClass, IJvDynControlData)
  else
  if ADynControlType = jctPanel then
    Valid := Valid and Supports(AControlClass, IJvDynControlPanel)
  else
  if ADynControlType = jctLabel then
    Valid := Valid and Supports(AControlClass, IJvDynControlLabel)
  else
  if ADynControlType = jctMemo then
    Valid := Valid and
      Supports(AControlClass, IJvDynControlItems) and
      Supports(AControlClass, IJvDynControlData) and
      Supports(AControlClass, IJvDynControlMemo)
  else
  if (ADynControlType = jctRadioGroup) or
    (ADynControlType = jctComboBox) then
    Valid := Valid and
      Supports(AControlClass, IJvDynControlItems) and
      Supports(AControlClass, IJvDynControlData)
  else
  if (ADynControlType = jctEdit) or
    (ADynControlType = jctCalculateEdit) or
    (ADynControlType = jctSpinEdit) or
    (ADynControlType = jctFileNameEdit) or
    (ADynControlType = jctDirectoryEdit) or
    (ADynControlType = jctCheckBox) or
    (ADynControlType = jctDateTimeEdit) or
    (ADynControlType = jctDateEdit) or
    (ADynControlType = jctTimeEdit) then
    Valid := Valid and Supports(AControlClass, IJvDynControlData);
  Result := Valid;
end;

procedure TJvCustomDynControlEngine.RegisterControlType(const ADynControlType: TJvDynControlType;
  AControlClass: TControlClass);
var
  Ind: Integer;
  ControlClassObject: TJvControlClassObject;
begin
  NeedRegisterControls;
  Ind := FRegisteredControlTypes.IndexOf(ADynControlType);
  if Ind >= 0 then
  begin
    ControlClassObject := TJvControlClassObject(FRegisteredControlTypes.Objects[Ind]);
    if Assigned(ControlClassObject) then
      ControlClassObject.Free;
    FRegisteredControlTypes.Delete(Ind);
  end;
  if IsControlTypeValid(ADynControlType, AControlClass) then
  begin
    ControlClassObject := TJvControlClassObject.Create;
    ControlClassObject.ControlClass := AControlClass;
    FRegisteredControlTypes.AddObject(ADynControlType, ControlClassObject);
  end
  else
    raise EJVCLException.CreateResFmt(@RsEUnsupportedControlClass, [ADynControlType]);
end;

function TJvCustomDynControlEngine.GetPropCount(Instance: TPersistent): Integer;
var
  Data: PTypeData;
begin
  Data := GetTypeData(Instance.ClassInfo);
  Result := Data^.PropCount;
end;

function TJvCustomDynControlEngine.GetPropName(Instance: TPersistent; Index: Integer): string;
var
  PropList: PPropList;
  PropInfo: PPropInfo;
  Data: PTypeData;
begin
  Result := '';
  Data := GetTypeData(Instance.ClassInfo);
  GetMem(PropList, Data^.PropCount * SizeOf(PPropInfo));
  try
    GetPropInfos(Instance.ClassInfo, PropList);
    PropInfo := PropList^[Index];
    Result := PropInfo^.Name;
  finally
    FreeMem(PropList, Data^.PropCount * SizeOf(PPropInfo));
  end;
end;

procedure TJvCustomDynControlEngine.SetPropertyValue(const APersistent: TPersistent;
  const APropertyName: string; const AValue: Variant);
var
  Index: Integer;
  PropName: string;
  SubObj: TObject;
  P: Integer;
  SearchName: string;
  LastName: string;
begin
  SearchName := Trim(APropertyName);
  P := Pos('.', SearchName);
  if P > 0 then
  begin
    LastName := Trim(Copy(SearchName, P + 1, Length(SearchName) - P));
    SearchName := Trim(Copy(SearchName, 1, P - 1));
  end
  else
    LastName := '';
  for Index := 0 to GetPropCount(APersistent) - 1 do
  begin
    PropName := UpperCase(GetPropName(APersistent, Index));
    if UpperCase(SearchName) = PropName then
      case PropType(APersistent, PropName) of
        tkLString, tkWString, tkString:
          SetStrProp(APersistent, PropName, VarToStr(AValue));
        tkEnumeration, tkSet, tkChar, tkInteger:
          SetOrdProp(APersistent, PropName, AValue);
//        tkInt64:
//          SetInt64Prop(APersistent, PropName, AValue);
        tkFloat:
          SetFloatProp(APersistent, PropName, AValue);
        tkClass:
          begin
            SubObj := GetObjectProp(APersistent, PropName);
            if SubObj is TStrings then
              TStrings(SubObj).Text := AValue
            else
            if (SubObj is TPersistent) and (LastName <> '') then
              SetPropertyValue(TPersistent(SubObj), LastName, AValue);
          end;
      end;
  end;
end;

function TJvCustomDynControlEngine.GetPropertyValue(const APersistent: TPersistent;
  const APropertyName: string): Variant;
var
  Index: Integer;
  PropName: string;
  SubObj: TObject;
  P: Integer;
  SearchName: string;
  LastName: string;
begin
  SearchName := Trim(APropertyName);
  P := Pos('.', SearchName);
  if P > 0 then
  begin
    LastName := Trim(Copy(SearchName, P + 1, Length(SearchName) - P));
    SearchName := Trim(Copy(SearchName, 1, P - 1));
  end
  else
    LastName := '';
  for Index := 0 to GetPropCount(APersistent) - 1 do
  begin
    PropName := UpperCase(GetPropName(APersistent, Index));
    if UpperCase(SearchName) = PropName then
      case PropType(APersistent, PropName) of
        tkLString, tkWString, tkString:
          Result := GetStrProp(APersistent, PropName);
        tkEnumeration, tkSet, tkChar, tkInteger:
          Result := GetOrdProp(APersistent, PropName);
        tkInt64:
          {$IFDEF COMPILER6_UP}
          Result := GetInt64Prop(APersistent, PropName);
          {$ELSE}
          Result := Null;
          {$ENDIF COMPILER6_UP}
        tkFloat:
          Result := GetFloatProp(APersistent, PropName);
        tkClass:
          begin
            SubObj := GetObjectProp(APersistent, PropName);
            if SubObj is TStrings then
              Result := TStrings(SubObj).Text
            else
            if (SubObj is TPersistent) and (LastName <> '') then
              Result := GetPropertyValue(TPersistent(SubObj), LastName);
          end;
      end;
  end;
end;

procedure TJvCustomDynControlEngine.AfterCreateControl(AControl: TControl);
begin
  if Assigned(FAfterCreateControl) then
    FAfterCreateControl(AControl);
end;

function TJvCustomDynControlEngine.GetRegisteredControlClass(AControlType: TJvDynControlType): TControlClass;
var
  Ind: Integer;
begin
  NeedRegisterControls;
  Result := nil;
  Ind := FRegisteredControlTypes.IndexOf(AControlType);
  if Ind >= 0 then
    if Assigned(FRegisteredControlTypes.Objects[Ind]) and
      (FRegisteredControlTypes.Objects[Ind] is TJvControlClassObject) then
      Result := TJvControlClassObject(FRegisteredControlTypes.Objects[Ind]).ControlClass;
end;

function TJvCustomDynControlEngine.CreateControl(AControlType: TJvDynControlType;
  AOwner: TComponent; AParentControl: TWinControl; AControlName: string): TControl;
begin
  NeedRegisterControls;
  if Assigned(GetRegisteredControlClass(AControlType)) then
    Result := CreateControlClass(GetRegisteredControlClass(AControlType), AOwner,
      AParentControl, AControlName)
  else
  if AControlType = jctForm then
  begin
    Result := TControl(TForm.Create(AOwner));
    if AControlName <> '' then
      Result.Name := AControlName;
  end
  else
    Result := nil;
  if Result = nil then
    raise EJVCLException.CreateResFmt(@RsENoRegisteredControlClass, [AControlType]);
  AfterCreateControl(Result);
end;

function TJvCustomDynControlEngine.CreateControlClass(AControlClass: TControlClass;
  AOwner: TComponent; AParentControl: TWinControl; AControlName: string): TControl;
var
  DynCtrl: IJvDynControl;
begin
  Result := TControl(AControlClass.Create(AOwner));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetDefaultProperties;
  if Assigned(AParentControl) then
    Result.Parent := AParentControl;
  if AControlName <> '' then
    Result.Name := AControlName;
end;

procedure TJvCustomDynControlEngine.SetControlCaption(AControl: IJvDynControl; const Value: string);
begin
end;

procedure TJvCustomDynControlEngine.SetControlTabOrder(AControl: IJvDynControl; Value: Integer);
begin
end;

procedure TJvCustomDynControlEngine.SetControlOnEnter(AControl: IJvDynControl; Value: TNotifyEvent);
begin
end;

procedure TJvCustomDynControlEngine.SetControlOnExit(AControl: IJvDynControl; Value: TNotifyEvent);
begin
end;

procedure TJvCustomDynControlEngine.SetControlOnClick(AControl: IJvDynControl; Value: TNotifyEvent);
begin
end;

procedure TJvCustomDynControlEngine.NeedRegisterControls;
begin
  if not FRegisterControlsExecuted then
  begin
    FRegisterControlsExecuted := True;
    RegisterControls;
  end;
end;

procedure TJvCustomDynControlEngine.RegisterControls;
begin
  // no registration
end;

//=== { TJvDynControlEngine } ================================================

constructor TJvDynControlEngine.Create;
begin
  inherited Create;
  FDistanceBetweenLabelAndControlHorz := 4;
  FDistanceBetweenLabelAndControlVert := 1;
end;

function TJvDynControlEngine.CreateLabelControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string;
  AFocusControl: TWinControl): TControl;
var
  DynCtrl: IJvDynControl;
  DynCtrlLabel: IJvDynControlLabel;
begin
  Result := CreateControl(jctLabel, AOwner, AParentControl, AControlName);
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
  if not Supports(Result, IJvDynControlLabel, DynCtrlLabel) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlLabel.ControlSetFocusControl(AFocusControl);
end;

function TJvDynControlEngine.CreateStaticTextControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string): TWinControl;
var
  DynCtrl: IJvDynControl;
begin
  Result := TWinControl(CreateControl(jctStaticText, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
end;

function TJvDynControlEngine.CreatePanelControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string;
  AAlign: TAlign): TWinControl;
var
  DynCtrl: IJvDynControl;
begin
  Result := TWinControl(CreateControl(jctPanel, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
  Result.Align := AAlign;
end;

function TJvDynControlEngine.CreateScrollBoxControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctScrollBox, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateEditControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
var
  DynCtrlEdit: IJvDynControlEdit;
begin
  Result := TWinControl(CreateControl(jctEdit, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControlEdit, DynCtrlEdit) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
end;

function TJvDynControlEngine.CreateCheckboxControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string): TWinControl;
var
  DynCtrl: IJvDynControl;
begin
  Result := TWinControl(CreateControl(jctCheckBox, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
end;

function TJvDynControlEngine.CreateComboBoxControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string; AItems: TStrings): TWinControl;
var
  DynCtrlItems: IJvDynControlItems;
begin
  Result := TWinControl(CreateControl(jctComboBox, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControlItems, DynCtrlItems) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlItems.ControlSetItems(AItems);
end;

function TJvDynControlEngine.CreateGroupBoxControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string): TWinControl;
var
  DynCtrl: IJvDynControl;
begin
  Result := TWinControl(CreateControl(jctGroupBox, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
end;

function TJvDynControlEngine.CreateImageControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctImage, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateRadioGroupControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string;
  AItems: TStrings; AItemIndex: Integer = 0): TWinControl;
var
  DynCtrl: IJvDynControl;
  DynCtrlItems: IJvDynControlItems;
  DynCtrlData: IJvDynControlData;
begin
  Result := TWinControl(CreateControl(jctRadioGroup, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
  if not Supports(Result, IJvDynControlItems, DynCtrlItems) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlItems.ControlSetItems(AItems);
  if not Supports(Result, IJvDynControlData, DynCtrlData) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlData.ControlValue := AItemIndex;
end;

function TJvDynControlEngine.CreateMemoControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctMemo, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateRichEditControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctRichEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateListBoxControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string; AItems: TStrings): TWinControl;
var
  DynCtrlItems: IJvDynControlItems;
begin
  Result := TWinControl(CreateControl(jctListBox, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControlItems, DynCtrlItems) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlItems.ControlSetItems(AItems);
end;

function TJvDynControlEngine.CreateCheckListBoxControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string; AItems: TStrings): TWinControl;
var
  DynCtrlItems: IJvDynControlItems;
begin
  Result := TWinControl(CreateControl(jctCheckListBox, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControlItems, DynCtrlItems) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlItems.ControlSetItems(AItems);
end;

function TJvDynControlEngine.CreateDateTimeControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctDateTimeEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateDateControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctDateEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateTimeControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctTimeEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateCalculateControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctCalculateEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateSpinControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctSpinEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateDirectoryControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctDirectoryEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateFileNameControl(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName: string): TWinControl;
begin
  Result := TWinControl(CreateControl(jctFileNameEdit, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateTreeViewControl(AOwner: TComponent; AParentControl: TWinControl;
  const AControlName: string): TWinControl; 
begin
  Result := TWinControl(CreateControl(jctTreeView, AOwner, AParentControl, AControlName));
end;

function TJvDynControlEngine.CreateButton(AOwner: TComponent;
  AParentControl: TWinControl; const AButtonName, ACaption, AHint: string;
  AOnClick: TNotifyEvent; ADefault: Boolean = False; ACancel: Boolean = False): TButton;
begin
  Result := TButton(CreateControl(jctButton, AOwner, AParentControl, AButtonName));
  Result.Hint := AHint;
  Result.Caption := ACaption;
  Result.Default := ADefault;
  Result.Cancel := ACancel;
  Result.OnClick := AOnClick;
end;

function TJvDynControlEngine.CreateRadioButton(AOwner: TComponent; AParentControl: TWinControl;
  const ARadioButtonName, ACaption: string): TWinControl;
var
  DynCtrl: IJvDynControl;
begin
  Result := TWinControl(CreateControl(jctRadioButton, AOwner, AParentControl, ARadioButtonName));
  if not Supports(Result, IJvDynControl, DynCtrl) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrl.ControlSetCaption(ACaption);
end;

function TJvDynControlEngine.CreateButtonEditControl(AOwner: TComponent; AParentControl: TWinControl;
  const AControlName: string; AOnButtonClick: TNotifyEvent): TWinControl;
var
  DynCtrlButtonEdit: IJvDynControlButtonEdit;
begin
  Result := TWinControl(CreateControl(jctButtonEdit, AOwner, AParentControl, AControlName));
  if not Supports(Result, IJvDynControlButtonEdit, DynCtrlButtonEdit) then
    raise EIntfCastError.CreateRes(@RsEIntfCastError);
  DynCtrlButtonEdit.ControlSetOnButtonClick(AOnButtonClick);
end;

function TJvDynControlEngine.CreateForm(const ACaption, AHint: string): TCustomForm;
begin
  Result := TCustomForm(CreateControl(jctForm, Application, nil, ''));
  Result.Caption := ACaption;
  Result.Hint := AHint;
end;

function TJvDynControlEngine.CreateLabelControlPanel(AOwner: TComponent;
  AParentControl: TWinControl; const AControlName, ACaption: string; AFocusControl: TWinControl;
  ALabelOnTop: Boolean = True; ALabelDefaultWidth: Integer = 0): TWinControl;
var
  Panel: TWinControl;
  LabelControl: TControl;
begin
  if not Assigned(AFocusControl) then
    raise EJVCLException.CreateRes(@RsENoFocusControl);
  Panel := CreatePanelControl(AOwner, AParentControl, '', '', alNone);
  LabelControl := CreateLabelControl(AOwner, Panel, '', ACaption, AFocusControl);
//  LabelControl.Width := panel.Canvas.
  AFocusControl.Parent := Panel;
  LabelControl.Top := 1;
  LabelControl.Left := 1;
  if ALabelOnTop then
  begin
    AFocusControl.Top := LabelControl.Height + DistanceBetweenLabelAndControlVert;
    AFocusControl.Left := 1;
    if LabelControl.Width > AFocusControl.Width then
      Panel.Width := LabelControl.Width
    else
      Panel.Width := AFocusControl.Width;
    Panel.Height := AFocusControl.Top + AFocusControl.Height;
  end
  else
  begin
    if ALabelDefaultWidth > 0 then
      LabelControl.Width := ALabelDefaultWidth;
    AFocusControl.Left := LabelControl.Width + DistanceBetweenLabelAndControlHorz;
    AFocusControl.Top := 1;
    if LabelControl.Height > AFocusControl.Height then
      Panel.Height := LabelControl.Height
    else
      Panel.Height := AFocusControl.Height;
    Panel.Width := AFocusControl.Width + AFocusControl.Left;
  end;
  Panel.Width := Panel.Width + 1;
  Panel.Height := Panel.Height + 1;
  Result := Panel;
end;

procedure SetDefaultDynControlEngine(AEngine: TJvDynControlEngine);
begin
  if AEngine is TJvDynControlEngine then
    GlobalDefaultDynControlEngine := AEngine;
end;

function DefaultDynControlEngine: TJvDynControlEngine;
begin
  Result := GlobalDefaultDynControlEngine;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

