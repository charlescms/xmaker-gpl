{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclAppInst.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) Petr Vones. All Rights Reserved.                                                   }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Marcel van Brakel                                                                              }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair)                                                                    }
{   Matthias Thoma (mthoma)                                                                        }
{   Petr Vones (pvones)                                                                            }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ This unit contains a class and support routines for controlling the number of concurrent         }
{ instances of your application that can exist at any time. In addition there is support for       }
{ simple interprocess communication between these instance including a notification mechanism.     }
{                                                                                                  }
{ Unit owner: Petr Vones                                                                           }
{                                                                                                  }
{**************************************************************************************************}

// Last modified: $Date: 2005/02/24 16:34:52 $
// For history see end of file

unit JclAppInst;

{$I jcl.inc}

interface

uses
  Windows, Classes, Messages,
  JclFileUtils, JclSynch;

// Message constants and types
type
  TJclAppInstDataKind = Integer;

const
  AI_INSTANCECREATED = $0001;
  AI_INSTANCEDESTROYED = $0002;
  AI_USERMSG = $0003;

  AppInstDataKindNoData = -1;
  AppInstCmdLineDataKind = 1;

// Application instances manager class
type
  TJclAppInstances = class(TObject)
  private
    FCPID: DWORD;
    FMapping: TJclSwapFileMapping;
    FMappingView: TJclFileMappingView;
    FMessageID: DWORD;
    FOptex: TJclOptex;
    function GetAppWnds(Index: Integer): HWND;
    function GetInstanceCount: Integer;
    function GetProcessIDs(Index: Integer): DWORD;
    function GetInstanceIndex(ProcessID: DWORD): Integer;
  protected
    procedure InitData;
    procedure NotifyInstances(const W, L: Longint);
    procedure RemoveInstance;
  public
    constructor Create;
    destructor Destroy; override;
    class function BringAppWindowToFront(const Wnd: HWND): Boolean;
    class function GetApplicationWnd(const ProcessID: DWORD): HWND;
    class procedure KillInstance;
    class function SetForegroundWindow98(const Wnd: HWND): Boolean;
    function CheckInstance(const MaxInstances: Word): Boolean;
    procedure CheckMultipleInstances(const MaxInstances: Word);
    procedure CheckSingleInstance;
    function SendCmdLineParams(const WindowClassName: string; const OriginatorWnd: HWND): Boolean;
    function SendData(const WindowClassName: string; const DataKind: TJclAppInstDataKind;
      Data: Pointer; const Size: Integer;
      OriginatorWnd: HWND): Boolean;
    function SendString(const WindowClassName: string; const DataKind: TJclAppInstDataKind;
      const S: string; OriginatorWnd: HWND): Boolean;
    function SendStrings(const WindowClassName: string; const DataKind: TJclAppInstDataKind;
      const Strings: TStrings; OriginatorWnd: HWND): Boolean;
    function SwitchTo(const Index: Integer): Boolean;
    procedure UserNotify(const Param: Longint);
    property AppWnds[Index: Integer]: HWND read GetAppWnds;
    property InstanceIndex[ProcessID: DWORD]: Integer read GetInstanceIndex;
    property InstanceCount: Integer read GetInstanceCount;
    property MessageID: DWORD read FMessageID;
    property ProcessIDs[Index: Integer]: DWORD read GetProcessIDs;
  end;

function JclAppInstances: TJclAppInstances; overload;
function JclAppInstances(const UniqueAppIdGuidStr: string): TJclAppInstances; overload;

// Interprocess communication routines
function ReadMessageCheck(var Message: TMessage; const IgnoredOriginatorWnd: HWND): TJclAppInstDataKind;
procedure ReadMessageData(const Message: TMessage; var Data: Pointer; var Size: Integer);
procedure ReadMessageString(const Message: TMessage; var S: string);
procedure ReadMessageStrings(const Message: TMessage; const Strings: TStrings);

implementation

uses
  SysUtils,
  JclStrings;

{$IFDEF FPC}  // missing declaration from unit Messages
type
  TWMCopyData = packed record
    Msg: Cardinal;
    From: HWND;
    CopyDataStruct: PCopyDataStruct;
    Result: Longint;
  end;
{$ENDIF FPC}

const
  { strings to form a unique name for file mapping and optex objects }
  JclAIPrefix = 'Jcl';
  JclAIOptex = '_Otx';
  JclAIMapping = '_Map';

  { window message used for communication between instances }
  JclAIMessage = '_Msg';

  { maximum number of instance that may exist at any time }
  JclAIMaxInstances = 256;

  { name of the application window class }
  ClassNameOfTApplication = 'TApplication';

type
  { management data to keep track of application instances. this data is shared amongst all instances
    and must be appropriately protected from concurrent access at all time }

  PJclAISharedData = ^TJclAISharedData;
  TJclAISharedData = packed record
    MaxInst: Word;
    Count: Word;
    ProcessIDs: array [0..JclAIMaxInstances] of DWORD;
  end;

var
  { the single global TJclAppInstance instance }
  AppInstances: TJclAppInstances;
  ExplicitUniqueAppId: string;

//=== { TJclAppInstances } ===================================================

constructor TJclAppInstances.Create;
begin
  inherited Create;
  FCPID := GetCurrentProcessId;
  InitData;
end;

destructor TJclAppInstances.Destroy;
begin
  if (FMapping <> nil) and (FOptex <> nil) then
    RemoveInstance;
  FreeAndNil(FMapping);
  FreeAndNil(FOptex);
  inherited Destroy;
end;

class function TJclAppInstances.BringAppWindowToFront(const Wnd: HWND): Boolean;
begin
  if IsIconic(Wnd) then
    SendMessage(Wnd, WM_SYSCOMMAND, SC_RESTORE, 0);
  Result := SetForegroundWindow98(Wnd);
end;

function TJclAppInstances.CheckInstance(const MaxInstances: Word): Boolean;
begin
  FOptex.Enter;
  try
    with PJclAISharedData(FMappingView.Memory)^ do
    begin
      if MaxInst = 0 then
        MaxInst := MaxInstances;
      Result := Count < MaxInst;
      ProcessIDs[Count] := GetCurrentProcessId;
      Inc(Count);
    end;
  finally
    FOptex.Leave;
  end;
  if Result then
    NotifyInstances(AI_INSTANCECREATED, Integer(FCPID));
end;

procedure TJclAppInstances.CheckMultipleInstances(const MaxInstances: Word);
begin
  if not CheckInstance(MaxInstances) then
  begin
    SwitchTo(0);
    KillInstance;
  end;
end;

procedure TJclAppInstances.CheckSingleInstance;
begin
  CheckMultipleInstances(1);
end;

class function TJclAppInstances.GetApplicationWnd(const ProcessID: DWORD): HWND;
type
  PTopLevelWnd = ^TTopLevelWnd;
  TTopLevelWnd = record
    ProcessID: DWORD;
    Wnd: HWND;
  end;
var
  TopLevelWnd: TTopLevelWnd;

  function EnumWinProc(Wnd: HWND; Param: PTopLevelWnd): BOOL; stdcall;
  var
    PID: DWORD;
    C: array [0..Length(ClassNameOfTApplication) + 1] of Char;
  begin
    GetWindowThreadProcessId(Wnd, @PID);
    if (PID = Param^.ProcessID) and (GetClassName(Wnd, C, SizeOf(C)) > 0) and
      (C = ClassNameOfTApplication) then
    begin
      Result := False;
      Param^.Wnd := Wnd;
    end
    else
      Result := True;
  end;

begin
  TopLevelWnd.ProcessID := ProcessID;
  TopLevelWnd.Wnd := 0;
  EnumWindows(@EnumWinProc, LPARAM(@TopLevelWnd));
  Result := TopLevelWnd.Wnd;
end;

function TJclAppInstances.GetAppWnds(Index: Integer): HWND;
begin
  Result := GetApplicationWnd(GetProcessIDs(Index));
end;

function TJclAppInstances.GetInstanceCount: Integer;
begin
  FOptex.Enter;
  try
    Result := PJclAISharedData(FMappingView.Memory)^.Count;
  finally
    FOptex.Leave;
  end;
end;

function TJclAppInstances.GetInstanceIndex(ProcessID: DWORD): Integer;
var
  I: Integer;
begin
  Result := -1;
  FOptex.Enter;
  try
    with PJclAISharedData(FMappingView.Memory)^ do
    begin
      for I := 0 to Count - 1 do
        if ProcessIDs[I] = ProcessID then
        begin
          Result := I;
          Break;
        end;
    end;
  finally
    FOptex.Leave;
  end;
end;

function TJclAppInstances.GetProcessIDs(Index: Integer): DWORD;
begin
  FOptex.Enter;
  try
    with PJclAISharedData(FMappingView.Memory)^ do
      if Index >= Count then
        Result := 0
      else
        Result := ProcessIDs[Index];
  finally
    FOptex.Leave;
  end;
end;

procedure TJclAppInstances.InitData;
var
  UniqueAppID: string;
begin
  if ExplicitUniqueAppId <> '' then
    UniqueAppID := JclAIPrefix + ExplicitUniqueAppId
  else
    UniqueAppID := AnsiUpperCase(JclAIPrefix + ParamStr(0));
  CharReplace(UniqueAppID, '\', '_');
  FOptex := TJclOptex.Create(UniqueAppID + JclAIOptex, 4000);
  FOptex.Enter;
  try
    FMapping := TJclSwapFileMapping.Create(UniqueAppID + JclAIMapping,
      PAGE_READWRITE, SizeOf(TJclAISharedData), nil);
    FMappingView := FMapping.Views[FMapping.Add(FILE_MAP_ALL_ACCESS, SizeOf(TJclAISharedData), 0)];
    if not FMapping.Existed then
      FillChar(FMappingView.Memory^, SizeOf(TJclAISharedData), #0);
  finally
    FOptex.Leave;
  end;
  FMessageID := RegisterWindowMessage(PChar(UniqueAppID + JclAIMessage));
end;

class procedure TJclAppInstances.KillInstance;
begin
  Halt(0);
end;

procedure TJclAppInstances.NotifyInstances(const W, L: Integer);
var
  I: Integer;
  Wnd: HWND;
  TID: DWORD;
  Msg: TMessage;

  function EnumWinProc(Wnd: HWND; Message: PMessage): BOOL; stdcall;
  begin 
    with Message^ do
      SendNotifyMessage(Wnd, Msg, WParam, LParam);
    Result := True;
  end;

begin
  FOptex.Enter;
  try
    with PJclAISharedData(FMappingView.Memory)^ do
      for I := 0 to Count - 1 do
      begin
        Wnd := GetApplicationWnd(ProcessIDs[I]);
        TID := GetWindowThreadProcessId(Wnd, nil);
        while Wnd <> 0 do
        begin // Send message to TApplication queue
          if PostThreadMessage(TID, FMessageID, W, L) or
            (GetLastError = ERROR_INVALID_THREAD_ID) then
            Break;
          Sleep(1);
        end;
        Msg.Msg := FMessageID;
        Msg.WParam := W;
        Msg.LParam := L;
        EnumThreadWindows(TID, @EnumWinProc, LPARAM(@Msg));
      end;
  finally
    FOptex.Leave;
  end;
end;

procedure TJclAppInstances.RemoveInstance;
var
  I: Integer;
begin
  FOptex.Enter;
  try
    with PJclAISharedData(FMappingView.Memory)^ do
      for I := 0 to Count - 1 do
        if ProcessIDs[I] = FCPID then
        begin
          ProcessIDs[I] := 0;
          Move(ProcessIDs[I + 1], ProcessIDs[I], (Count - I) * SizeOf(DWORD));
          Dec(Count);
          Break;
        end;
  finally
    FOptex.Leave;
  end;
  NotifyInstances(AI_INSTANCEDESTROYED, Integer(FCPID));
end;

function TJclAppInstances.SendCmdLineParams(const WindowClassName: string; const OriginatorWnd: HWND): Boolean;
var
  TempList: TStringList;
  I: Integer;
begin
  TempList := TStringList.Create;
  try
    for I := 1 to ParamCount do
      TempList.Add(ParamStr(I));
    Result := SendStrings(WindowClassName, AppInstCmdLineDataKind, TempList, OriginatorWnd);
  finally
    TempList.Free;
  end;
end;

function TJclAppInstances.SendData(const WindowClassName: string;
  const DataKind: TJclAppInstDataKind;
  Data: Pointer; const Size: Integer;
  OriginatorWnd: HWND): Boolean;
type
  PEnumWinRec = ^TEnumWinRec;
  TEnumWinRec = record
    WindowClassName: PChar;
    OriginatorWnd: HWND;
    CopyData: TCopyDataStruct;
    Self: TJclAppInstances;
  end;

var
  EnumWinRec: TEnumWinRec;

  function EnumWinProc(Wnd: HWND; Data: PEnumWinRec): BOOL; stdcall;
  var
    ClassName: array [0..200] of Char;
    I: Integer;
    PID: DWORD;
    Found: Boolean;
  begin
    if (GetClassName(Wnd, ClassName, SizeOf(ClassName)) > 0) and
      (StrComp(ClassName, Data.WindowClassName) = 0) then
    begin
      GetWindowThreadProcessId(Wnd, @PID);
      Found := False;
      Data.Self.FOptex.Enter;
      try
        with PJclAISharedData(Data.Self.FMappingView.Memory)^ do
          for I := 0 to Count - 1 do
            if ProcessIDs[I] = PID then
            begin
              Found := True;
              Break;
            end;
      finally
        Data.Self.FOptex.Leave;
      end;
      if Found then
        SendMessage(Wnd, WM_COPYDATA, Data.OriginatorWnd, LPARAM(@Data.CopyData));
    end;
    Result := True;
  end;

begin
  Assert(DataKind <> AppInstDataKindNoData);
  EnumWinRec.WindowClassName := PChar(WindowClassName);
  EnumWinRec.OriginatorWnd := OriginatorWnd;
  EnumWinRec.CopyData.dwData := DataKind;
  EnumWinRec.CopyData.cbData := Size;
  EnumWinRec.CopyData.lpData := Data;
  EnumWinRec.Self := Self;
  Result := EnumWindows(@EnumWinProc, Integer(@EnumWinRec));
end;

function TJclAppInstances.SendString(const WindowClassName: string;
  const DataKind: TJclAppInstDataKind; const S: string;
  OriginatorWnd: HWND): Boolean;
begin
  Result := SendData(WindowClassName, DataKind, PChar(S), Length(S) + 1,
    OriginatorWnd);
end;

function TJclAppInstances.SendStrings(const WindowClassName: string;
  const DataKind: TJclAppInstDataKind; const Strings: TStrings;
  OriginatorWnd: HWND): Boolean;
var
  S: string;
begin
  S := Strings.Text;
  Result := SendData(WindowClassName, DataKind, Pointer(S), Length(S), OriginatorWnd);
end;

class function TJclAppInstances.SetForegroundWindow98(const Wnd: HWND): Boolean;
var
  ForeThreadID, NewThreadID: DWORD;
begin
  if GetForegroundWindow <> Wnd then
  begin
    ForeThreadID := GetWindowThreadProcessId(GetForegroundWindow, nil);
    NewThreadID := GetWindowThreadProcessId(Wnd, nil);
    if ForeThreadID <> NewThreadID then
    begin
      AttachThreadInput(ForeThreadID, NewThreadID, True);
      Result := SetForegroundWindow(Wnd);
      AttachThreadInput(ForeThreadID, NewThreadID, False);
      if Result then
        Result := SetForegroundWindow(Wnd);
    end
    else
      Result := SetForegroundWindow(Wnd);
  end
  else
    Result := True;
end;

function TJclAppInstances.SwitchTo(const Index: Integer): Boolean;
begin
  Result := BringAppWindowToFront(AppWnds[Index]);
end;

procedure TJclAppInstances.UserNotify(const Param: Integer);
begin
  NotifyInstances(AI_USERMSG, Param);
end;

function JclAppInstances: TJclAppInstances;
begin
  if AppInstances = nil then
    AppInstances := TJclAppInstances.Create;
  Result := AppInstances;
end;

function JclAppInstances(const UniqueAppIdGuidStr: string): TJclAppInstances;
begin
  Assert(AppInstances = nil);
  ExplicitUniqueAppId := UniqueAppIdGuidStr;
  Result := JclAppInstances;
end;

// Interprocess communication routines
function ReadMessageCheck(var Message: TMessage; const IgnoredOriginatorWnd: HWND): TJclAppInstDataKind;
begin
  if (Message.Msg = WM_COPYDATA) and (TWMCopyData(Message).From <> IgnoredOriginatorWnd) then
  begin
    Message.Result := 1;
    Result := TJclAppInstDataKind(TWMCopyData(Message).CopyDataStruct^.dwData);
  end
  else
  begin
    Message.Result := 0;
    Result := AppInstDataKindNoData;
  end;
end;

procedure ReadMessageData(const Message: TMessage; var Data: Pointer; var Size: Integer);
begin
  with TWMCopyData(Message) do
    if Msg = WM_COPYDATA then
    begin
      Size := CopyDataStruct^.cbData;
      GetMem(Data, Size);
      Move(CopyDataStruct^.lpData^, Data^, Size);
    end;
end;

procedure ReadMessageString(const Message: TMessage; var S: string);
begin
  with TWMCopyData(Message) do
    if Msg = WM_COPYDATA then
      SetString(S, PChar(CopyDataStruct^.lpData), CopyDataStruct^.cbData);
end;

procedure ReadMessageStrings(const Message: TMessage; const Strings: TStrings);
var
  S: string;
begin
  with TWMCopyData(Message) do
    if Msg = WM_COPYDATA then
    begin
      SetString(S, PChar(CopyDataStruct^.lpData), CopyDataStruct^.cbData);
      Strings.Text := S;
    end;
end;

initialization

finalization
  FreeAndNil(AppInstances);

// History:

// $Log: JclAppInst.pas,v $
// Revision 1.13  2005/02/24 16:34:52  marquardt
// remove divider lines, add section lines (unfinished)
//
// Revision 1.12  2004/10/17 21:00:14  mthoma
// cleaning
//
// Revision 1.11  2004/09/22 20:38:49  obones
// Removed "const" specifiers that were triggering the well known HPP generation bug in C++ Builder
//
// Revision 1.10  2004/08/01 11:40:23  marquardt
// move constructors/destructors
//
// Revision 1.9  2004/07/28 18:00:52  marquardt
// various style cleanings, some minor fixes
//
// Revision 1.8  2004/06/16 07:30:30  marquardt
// added tilde to all IFNDEF ENDIFs, inherited qualified
//
// Revision 1.7  2004/06/14 11:05:52  marquardt
// symbols added to all ENDIFs and some other minor style changes like removing IFOPT
//
// Revision 1.6  2004/05/05 07:33:49  rrossmair
// header updated according to new policy: initial developers & contributors listed
//
// Revision 1.5  2004/04/06 04:55:17  
// adapt compiler conditions, add log entry
//

end.
