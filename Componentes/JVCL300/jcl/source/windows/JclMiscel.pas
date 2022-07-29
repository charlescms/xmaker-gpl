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
{ The Original Code is JclMiscel.pas.                                                              }
{                                                                                                  }
{ The Initial Developers of the Original Code are Members of Team JCL. Portions created by these   }
{ individuals are Copyright (C) of these individuals. All Rights Reserved                          }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Jeroen Speldekamp                                                                              }
{   Peter Friese                                                                                   }
{   Marcel van Brakel                                                                              }
{   Robert Marquardt (marquardt)                                                                   }
{   John C Molyneux                                                                                }
{   Matthias Thoma (mthoma)                                                                        }
{   Petr Vones (pvones)                                                                            }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Various miscellanuous routines that do not (yet) fit nicely into other units                     }
{                                                                                                  }
{**************************************************************************************************}

// Last modified: $Date: 2005/03/08 08:33:22 $
// For history see end of file

unit JclMiscel;

{$I jcl.inc}

interface

uses
  Windows,
  JclBase;

// StrLstLoadSave
function SetDisplayResolution(const XRes, YRes: DWORD): Longint;

function CreateDOSProcessRedirected(const CommandLine, InputFile, OutputFile: string): Boolean;
function WinExec32(const Cmd: string; const CmdShow: Integer): Boolean;
function WinExec32AndWait(const Cmd: string; const CmdShow: Integer): Cardinal;
function WinExec32AndRedirectOutput(const Cmd: string; var Output: string; RawOutput: Boolean = False): Cardinal;

function ExitWindows(ExitCode: Cardinal): Boolean;
function LogOffOS: Boolean;
function PowerOffOS: Boolean;
function ShutDownOS: Boolean;
function RebootOS: Boolean;

// CreateProcAsUser
type
  EJclCreateProcessError = class(EJclWin32Error);

procedure CreateProcAsUser(const UserDomain, UserName, PassWord, CommandLine: string);
procedure CreateProcAsUserEx(const UserDomain, UserName, Password, CommandLine: string;
  const Environment: PChar);

{$IFDEF SUPPORTS_EXTSYM}
{$EXTERNALSYM ExitWindows}
{$ENDIF SUPPORTS_EXTSYM}

implementation

uses
  SysUtils,
  JclResources, JclSecurity, JclStrings, JclSysUtils, JclWin32;

function CreateDOSProcessRedirected(const CommandLine, InputFile, OutputFile: string): Boolean;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  SecAtrrs: TSecurityAttributes;
  hInputFile, hOutputFile: THandle;
begin
  Result := False;
  hInputFile := CreateFile(PChar(InputFile), GENERIC_READ, FILE_SHARE_READ,
    CreateInheritable(SecAtrrs), OPEN_EXISTING, FILE_ATTRIBUTE_TEMPORARY, 0);
  if hInputFile <> INVALID_HANDLE_VALUE then
  begin
    hOutputFile := CreateFile(PChar(OutPutFile), GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ, CreateInheritable(SecAtrrs), CREATE_ALWAYS,
      FILE_ATTRIBUTE_TEMPORARY, 0);
    if hOutputFile <> INVALID_HANDLE_VALUE then
    begin
      FillChar(StartupInfo, SizeOf(StartupInfo), #0);
      StartupInfo.cb := SizeOf(StartupInfo);
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      StartupInfo.wShowWindow := SW_HIDE;
      StartupInfo.hStdOutput := hOutputFile;
      StartupInfo.hStdInput := hInputFile;
      Result := CreateProcess(nil, PChar(CommandLine), nil, nil, True,
        CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo,
        ProcessInfo);
      if Result then
      begin
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
      end;
      CloseHandle(hOutputFile);
    end;
    CloseHandle(hInputFile);
  end;
end;

function WinExec32(const Cmd: string; const CmdShow: Integer): Boolean;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := CmdShow;
  Result := CreateProcess(nil, PChar(Cmd), nil, nil, False,
    NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo);
  if Result then
  begin
    WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end;
end;

function WinExec32AndWait(const Cmd: string; const CmdShow: Integer): Cardinal;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result := Cardinal($FFFFFFFF);
  FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := CmdShow;
  if CreateProcess(nil, PChar(Cmd), nil, nil, False, NORMAL_PRIORITY_CLASS,
    nil, nil, StartupInfo, ProcessInfo) then
  begin
    WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
    if WaitForSingleObject(ProcessInfo.hProcess, INFINITE) = WAIT_OBJECT_0 then
    begin
      if not GetExitCodeProcess(ProcessInfo.hProcess, Result) then
        Result := Cardinal($FFFFFFFF);
    end;
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end;
end;

function WinExec32AndRedirectOutput(const Cmd: string; var Output: string; RawOutput: Boolean): Cardinal;
begin
  Result := Execute(Cmd, Output, RawOutput);
end;

function LogOffOS: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := JclMiscel.ExitWindows(EWX_LOGOFF);
  {$ENDIF MSWINDOWS}
  { TODO : implement at least LINUX variants throwing an exception }
end;

function PowerOffOS: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := JclMiscel.ExitWindows(EWX_POWEROFF);
  {$ENDIF MSWINDOWS}
end;

function ShutDownOS: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := JclMiscel.ExitWindows(EWX_SHUTDOWN);
  {$ENDIF MSWINDOWS}
end;

function RebootOS: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := JclMiscel.ExitWindows(EWX_Reboot);
  {$ENDIF MSWINDOWS}
end;

function ExitWindows(ExitCode: Cardinal): Boolean;
begin
  { TODO -cTest : Check for Win9x }
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and not EnableProcessPrivilege(True, SE_SHUTDOWN_NAME) then
    Result := False
  else
    Result := ExitWindowsEx(ExitCode, SHTDN_REASON_MAJOR_APPLICATION or SHTDN_REASON_MINOR_OTHER);
end;

function SetDisplayResolution(const XRes, YRes: DWORD): Longint;
var
  DevMode: TDeviceMode;
begin
  Result := DISP_CHANGE_FAILED;
  FillChar(DevMode, SizeOf(DevMode), #0);
  DevMode.dmSize := SizeOf(DevMode);
  if EnumDisplaySettings(nil, 0, DevMode) then
  begin
    DevMode.dmFields := DM_PELSWIDTH or DM_PELSHEIGHT;
    DevMode.dmPelsWidth := XRes;
    DevMode.dmPelsHeight := YRes;
    Result := ChangeDisplaySettings(DevMode, 0);
  end;
end;

procedure CheckOSVersion;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    raise EJclError.CreateRes(@RsCreateProcNTRequiredError);
  if Win32BuildNumber < 1057 then
    raise EJclError.CreateRes(@RsCreateProcBuild1057Error);
end;

procedure CreateProcAsUser(const UserDomain, UserName, PassWord, CommandLine: string);
begin
  CreateProcAsUserEx(UserDomain, UserName, Password, CommandLine, nil);
end;

{ TODO -cTest : Check for Win9x }
procedure CreateProcAsUserEx(const UserDomain, UserName, Password, CommandLine: string;
  const Environment: PChar);
const
  // default values for window stations and desktops
  CreateProcDEFWINSTATION = 'WinSta0';
  CreateProcDEFDESKTOP    = 'Default';
  CreateProcDOMUSERSEP    = '\';
var
  ConsoleTitle: string;
  Help: string;
  WinStaName: string;
  DesktopName: string;
  hUserToken: THandle;
  hWindowStation: HWINSTA;
  hDesktop: HDESK;
  StartUpInfo: TStartUpInfo;
  ProcInfo: TProcessInformation;
begin

  // Step 1: check for the correct OS version
  CheckOSVersion;

  // Step 2: logon as the specified user
  if not LogonUser(PChar(UserName), PChar(UserDomain), PChar(Password),
    LOGON32_LOGON_INTERACTIVE, LOGON32_PROVIDER_DEFAULT, hUserToken) then
  begin
    case GetLastError of
      ERROR_PRIVILEGE_NOT_HELD:
        raise EJclCreateProcessError.CreateResFmt(@RsCreateProcPrivilegeMissing,
          [GetPrivilegeDisplayName(SE_TCB_NAME), SE_TCB_NAME]);
      ERROR_LOGON_FAILURE:
        raise EJclCreateProcessError.CreateRes(@RsCreateProcLogonUserError);
      ERROR_ACCESS_DENIED:
        raise EJclCreateProcessError.CreateRes(@RsCreateProcAccessDenied);
    else
      raise EJclCreateProcessError.CreateRes(@RsCreateProcLogonFailed);
    end;
  end;

  // Step 3: give the new user access to the current WindowStation and Desktop
  hWindowStation:= GetProcessWindowStation;
  WinStaName := GetUserObjectName(hWindowStation);
  if WinStaName = '' then
    WinStaName := CreateProcDEFWINSTATION;

  if not SetUserObjectFullAccess(hWindowStation) then
  begin
    CloseHandle(hUserToken);
    raise EJclCreateProcessError.CreateResFmt(@RsCreateProcSetStationSecurityError, [WinStaName]);
  end;

  hDesktop := GetThreadDesktop(GetCurrentThreadId);
  DesktopName := GetUserObjectName(hDesktop);
  if DesktopName = '' then
    DesktopName := CreateProcDEFDESKTOP;

  if not SetUserObjectFullAccess(hDesktop) then
  begin
    CloseHandle(hUserToken);
    raise EJclCreateProcessError.CreateResFmt(@RsCreateProcSetDesktopSecurityError, [DesktopName]);
  end;

  // Step 4: set the startup info for the new process
  ConsoleTitle := UserDomain + UserName;
  FillChar(StartUpInfo, SizeOf(StartUpInfo), #0);
  with StartUpInfo do
  begin
    cb:= SizeOf(StartUpInfo);
    lpTitle:= PChar(ConsoleTitle);
    Help := WinStaName + '\' + DeskTopName;
    lpDesktop:= PChar(Help);
  end;

  // Step 5: create the child process
  if not CreateProcessAsUser(hUserToken, nil, PChar(CommandLine), nil, nil,
    False, CREATE_NEW_CONSOLE or CREATE_NEW_PROCESS_GROUP, Environment, nil,
    {$IFDEF FPC}
    @StartUpInfo, @ProcInfo) then
    {$ELSE}
    StartUpInfo, ProcInfo) then
    {$ENDIF FPC}
  begin
    case GetLastError of
      ERROR_PRIVILEGE_NOT_HELD:
        raise EJclCreateProcessError.CreateResFmt(@RsCreateProcPrivilegesMissing,
          [GetPrivilegeDisplayName(SE_ASSIGNPRIMARYTOKEN_NAME), SE_ASSIGNPRIMARYTOKEN_NAME,
           GetPrivilegeDisplayName(SE_INCREASE_QUOTA_NAME), SE_INCREASE_QUOTA_NAME]);
      ERROR_FILE_NOT_FOUND:
        raise EJclCreateProcessError.CreateResFmt(@RsCreateProcCommandNotFound, [CommandLine]);
      else
        raise EJclCreateProcessError.CreateRes(@RsCreateProcFailed);
    end;
  end;

  // clean up
  CloseWindowStation(hWindowStation);
  CloseDesktop(hDesktop);
  CloseHandle(hUserToken);

  // if this code should be called although there has
  // been an exception during invocation of CreateProcessAsUser,
  // it will quite surely fail. you should make sure this doesn't happen.
  // (it shouldn't happen due to the use of exceptions in the above lines)
  CloseHandle(ProcInfo.hThread);
  CloseHandle(ProcInfo.hProcess);
end;

// History:

// $Log: JclMiscel.pas,v $
// Revision 1.13  2005/03/08 08:33:22  marquardt
// overhaul of exceptions and resourcestrings, minor style cleaning
//
// Revision 1.12  2005/02/24 16:34:52  marquardt
// remove divider lines, add section lines (unfinished)
//
// Revision 1.11  2004/10/25 06:58:44  rrossmair
// - fixed bug #0002065
// - outsourced JclMiscel.Win32ExecAndRedirectOutput() + JclBorlandTools.ExecAndRedirectOutput() code into JclSysUtils.Execute()
// - refactored this code
// - added overload to supply callback capability per line of output
//
// Revision 1.10  2004/10/21 06:38:52  marquardt
// style clenaing, bugfixes, improvements
//
// Revision 1.9  2004/10/17 21:00:15  mthoma
// cleaning
//
// Revision 1.8  2004/07/28 18:00:53  marquardt
// various style cleanings, some minor fixes
//
// Revision 1.7  2004/06/14 11:05:53  marquardt
// symbols added to all ENDIFs and some other minor style changes like removing IFOPT
//
// Revision 1.6  2004/05/05 07:33:49  rrossmair
// header updated according to new policy: initial developers & contributors listed
//
// Revision 1.5  2004/04/06 04:55:17
// adapt compiler conditions, add log entry
//

end.
