{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvgMailSlots.PAS, released on 2003-01-15.

The Initial Developer of the Original Code is Andrey V. Chudin,  [chudin att yandex dott ru]
Portions created by Andrey V. Chudin are Copyright (C) 2003 Andrey V. Chudin.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].
Burov Dmitry, translation of russian text.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvgMailSlots.pas,v 1.26 2005/02/17 10:21:21 marquardt Exp $

unit JvgMailSlots;

{$I jvcl.inc}

interface

uses
  {$IFDEF USEJVCL}
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$ENDIF USEJVCL}
  Windows, Messages, SysUtils, Classes, Graphics,
  {$IFDEF USEJVCL}
  Controls, Forms, Dialogs, ExtCtrls,
  JvComponent;
  {$ELSE}
  Controls, Forms, Dialogs, ExtCtrls;
  {$ENDIF USEJVCL}

type
  TOnNewMessage = procedure(Sender: TObject; MessageText: string) of object;

  {$IFDEF USEJVCL}
  TJvgMailSlotServer = class(TJvComponent)
  {$ELSE}
  TJvgMailSlotServer = class(TComponent)
  {$ENDIF USEJVCL}
  private
    FMailSlotName: string;
    FLastMessage: string;
    FOnNewMessage: TOnNewMessage;
    FTimer: TTimer;
    FHandle: THandle;
    FEnabled: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Open;
    procedure Close;
  protected
    procedure Loaded; override;
    procedure OnTimer(Sender: TObject);
  published
    property MailSlotName: string read FMailSlotName write FMailSlotName;
    property OnNewMessage: TOnNewMessage read FOnNewMessage write
      FOnNewMessage;
  end;

  {$IFDEF USEJVCL}
  TJvgMailSlotClient = class(TJvComponent)
  {$ELSE}
  TJvgMailSlotClient = class(TComponent)
  {$ENDIF USEJVCL}
  private
    FMailSlotName: string;
    FServerName: string;
    FOnNewMessage: TOnNewMessage;
  public
    constructor Create(AOwner: TComponent); override;
    function Send(const Str: string): Boolean;
  protected
    procedure Loaded; override;
    procedure ErrorCatch(Sender: TObject; Exc: Exception);
  published
    property ServerName: string read FServerName write FServerName;
    property MailSlotName: string read FMailSlotName write FMailSlotName;
    property OnNewMessage: TOnNewMessage read FOnNewMessage write FOnNewMessage;
  end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvgMailSlots.pas,v $';
    Revision: '$Revision: 1.26 $';
    Date: '$Date: 2005/02/17 10:21:21 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

implementation

uses
  {$IFDEF USEJVCL}
  JvResources, JvConsts,
  {$ENDIF USEJVCL}
  JvgUtils, JvgTypes;

{$IFNDEF USEJVCL}
resourcestring
  RsETJvgMailSlotServerErrorCreatingChan = 'TJvgMailSlotServer: Error creating channel!';
  RsETJvgMailSlotServerErrorGatheringInf = 'TJvgMailSlotServer: Error gathering information!';
  RsETJvgMailSlotServerErrorReadingMessa = 'TJvgMailSlotServer: Error reading message!';
{$ENDIF !USEJVCL}

constructor TJvgMailSlotServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FMailSlotName := 'MailSlot';
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;
end;

destructor TJvgMailSlotServer.Destroy;
begin
  FTimer.Free;
  // �������� ������
  { Closing channel [translated] }
  Close;
  inherited Destroy;
end;

procedure TJvgMailSlotServer.Loaded;
begin
  inherited Loaded;
  Open;
end;

procedure TJvgMailSlotServer.Open;
begin
  //  if not FEnabled then exit;
  // �������� ������ � ������ MailSlotName - �� ����� ����� � ����
  // ����� ���������� �������
  { Creating channel named MailSlotName - that is the name clients will use to
    access the channel [translated] }
  FHandle := CreateMailSlot(PChar('\\.\mailslot\' + MailSlotName), 0,
    MAILSLOT_WAIT_FOREVER, nil);
  //FHandle:=CreateMailSlot('\\.\mailslot\MailSlot',0,MAILSLOT_WAIT_FOREVER,nil);

  if FHandle = INVALID_HANDLE_VALUE then
    raise Exception.CreateRes(@RsETJvgMailSlotServerErrorCreatingChan);
  FTimer.Enabled := True;
end;

procedure TJvgMailSlotServer.Close;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
  FHandle := 0;
end;

procedure TJvgMailSlotServer.OnTimer(Sender: TObject);
var
  MsgSize: DWORD;
  MsgNumber: DWORD;
  Read: DWORD;
  MessageText: string;
  Buffer: PChar;
begin
  //  if not FEnabled then exit;

  MessageText := '';
  // ����������� ������� ��������� � ������
  { Determining if there's message in channel [translated] }
  if not GetMailSlotInfo(FHandle, nil, MsgSize, @MsgNumber, nil) then
    raise Exception.CreateRes(@RsETJvgMailSlotServerErrorGatheringInf);
  if MsgSize <> MAILSLOT_NO_MESSAGE then
  begin
    // (rom) deactivated  annoying
    // Beep;

    // Allocate memory for the message
    GetMem(Buffer, MsgSize);
    try
      // ������ ��������� �� ������ � ���������� � ����� ���������
      { Reading message from channel and adding it to text of log }
      if ReadFile(FHandle, Buffer, MsgSize, Read, nil) then
        MessageText := Buffer
      else
        raise Exception.CreateRes(@RsETJvgMailSlotServerErrorReadingMessa);
    finally
      FreeMem(Buffer);
    end;
  end;

  if (MessageText <> '') and Assigned(FOnNewMessage) then
    FOnNewMessage(Self, MessageText);

  FLastMessage := MessageText;
end;
//------------------------------------------------------------------------------

constructor TJvgMailSlotClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMailSlotName := 'MailSlot';
  FServerName := '';
end;

procedure TJvgMailSlotClient.Loaded;
begin
  inherited Loaded;
  // (rom) this is not a good idea
  Application.OnException := ErrorCatch;
end;

procedure TJvgMailSlotClient.ErrorCatch(Sender: TObject; Exc: Exception);
var
  UserName: PChar;
  Size: DWORD;
begin
  // ��������� ����� ������������
  { Querying user name [translated] }
  // First query with a buffer too small, to get the required size
  Size := 0;
  UserName := nil;
  GetUserName(UserName, Size);

  // then allocate some memory for the user name
  GetMem(UserName, Size);
  try
    GetUserName(UserName, Size);

    Send('/' + UserName + '/' + FormatDateTime('hh:mm', Time) + '/' +
      Exc.Message);
  finally
    FreeMem(UserName);
  end;

  // ����� ��������� �� ������ ������������
  { Showing message about error to user [translated] }
  Application.ShowException(Exc);
end;

function TJvgMailSlotClient.Send(const Str: string): Boolean;
var
  Buffer: PChar;
  FHandle: THandle;
  Written: DWORD;
begin
  // �������� ������ : MyServer - ��� �������
  // (\\.\\mailslot\xxx - ������� �������� �� ���� �� ��)
  // xxx - ��� ������
  { Opening channel: MyServer - name of server
    (\\.\\mailslot\xxx - monitor is working on the same PC
    xxx is the name of channel [translated]
  }
  if FServerName = '' then
    FServerName := '.\';
  FHandle := CreateFile(PChar('\\' + FServerName + '\mailslot\' + FMailSlotName),
    GENERIC_WRITE, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  if FHandle <> INVALID_HANDLE_VALUE then
  begin
    GetMem(Buffer, Length(Str)+1);
    try
      StrCopy(Buffer, PChar(Str));
      // �������� ������ ������ (������ � ����� � �������� ������)
      { Transmitting text of error (putting into channel and closing channel) [translated] }
      WriteFile(FHandle, Buffer, Length(Str) + 1, Written, nil);
    finally
      CloseHandle(FHandle);
      FreeMem(Buffer);
    end;
  end;
  Result := FHandle <> INVALID_HANDLE_VALUE;
end;

{$IFDEF USEJVCL}
{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}
{$ENDIF USEJVCL}

end.

