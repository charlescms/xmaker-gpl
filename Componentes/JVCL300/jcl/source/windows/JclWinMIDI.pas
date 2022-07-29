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
{ The Original Code is JclWinMidi.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Robert Rossmair                                    }
{ Portions created by Robert Rossmair are Copyright (C) Robert Rossmair. All Rights Reserved.      }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Robert Rossmair                                                                                }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ MIDI functions for MS Windows platform                                                           }
{                                                                                                  }
{ Unit owner: Robert Rossmair                                                                      }
{                                                                                                  }
{**************************************************************************************************}

// Last modified: $Date: 2005/02/25 07:20:16 $
// For history see end of file

unit JclWinMidi;

{$I jcl.inc}
{$I windowsonly.inc}

interface

uses
  SysUtils, Classes, Windows, MMSystem,
  JclMIDI;

type
  TStereoChannel = (scLeft, scRight);
  
  // MIDI Out
  IJclWinMidiOut = interface(IJclMidiOut)
    ['{F3FCE71C-B924-462C-BA0D-8C2DC118DADB}']
    // property access methods
    function GetChannelVolume(Channel: TStereoChannel): Word;
    procedure SetChannelVolume(Channel: TStereoChannel; const Value: Word);
    function GetVolume: Word;
    procedure SetVolume(const Value: Word);
    // properties
    property ChannelVolume[Channel: TStereoChannel]: Word read GetChannelVolume write SetChannelVolume;
    property Volume: Word read GetVolume write SetVolume;
  end;

function MidiOut(DeviceID: Cardinal): IJclWinMidiOut;
procedure GetMidiOutputs(const List: TStrings);
procedure MidiOutCheck(Code: MMResult);

// MIDI In
procedure MidiInCheck(Code: MMResult);

implementation

uses
  JclResources, JclStrings;

var
  FMidiOutputs: TStringList = nil;

function MidiOutputs: TStrings;
var
  I: Integer;
  Caps: MIDIOUTCAPS;
begin
  if FMidiOutputs = nil then
  begin
    FMidiOutputs := TStringList.Create;
    for I := 0 to midiOutGetNumDevs - 1 do
    begin
      if (midiOutGetDevCaps(I, @Caps, SizeOf(Caps)) = MMSYSERR_NOERROR) then
        FMidiOutputs.Add(Caps.szPName);
    end;
  end;
  Result := FMidiOutputs;
end;

procedure GetMidiOutputs(const List: TStrings);
begin
  List.Assign(MidiOutputs);
end;

function GetMidiInErrorMessage(const ErrorCode: MMRESULT): string;
begin
  SetLength(Result, MAXERRORLENGTH-1);
  if midiInGetErrorText(ErrorCode, @Result[1], MAXERRORLENGTH) = MMSYSERR_NOERROR then
    StrResetLength(Result)
  else
    Result := Format(RsMidiInUnknownError, [ErrorCode]);
end;

function GetMidiOutErrorMessage(const ErrorCode: MMRESULT): string;
begin
  SetLength(Result, MAXERRORLENGTH-1);
  if midiOutGetErrorText(ErrorCode, @Result[1], MAXERRORLENGTH) = MMSYSERR_NOERROR then
    StrResetLength(Result)
  else
    Result := Format(RsMidiOutUnknownError, [ErrorCode]);
end;

procedure MidiInCheck(Code: MMResult);
begin
  if Code <> MMSYSERR_NOERROR then
    raise EJclMidiError.Create(GetMidiInErrorMessage(Code));
end;

procedure MidiOutCheck(Code: MMResult);
begin
  if Code <> MMSYSERR_NOERROR then
    raise EJclMidiError.Create(GetMidiOutErrorMessage(Code));
end;

//=== { TMidiOut } ===========================================================

type
  TMidiOut = class(TJclMidiOut, IJclWinMidiOut)
  private
    FHandle: HMIDIOUT;
    FDeviceID: Cardinal;
    FDeviceCaps: MIDIOUTCAPS;
    FVolume: DWord;
    function GetChannelVolume(Channel: TStereoChannel): Word;
    procedure SetChannelVolume(Channel: TStereoChannel; const Value: Word);
    function GetVolume: Word;
    procedure SetVolume(const Value: Word);
    procedure SetLRVolume(const LeftValue, RightValue: Word);
  protected
    function GetName: string; override;
    procedure LongMessage(const Data: array of Byte);
    procedure DoSendMessage(const Data: array of Byte); override;
  public
    constructor Create(ADeviceID: Cardinal);
    destructor Destroy; override;
    property DeviceID: Cardinal read FDeviceID;
    property Name: string read GetName;
    property ChannelVolume[Channel: TStereoChannel]: Word read GetChannelVolume write SetChannelVolume;
    property Volume: Word read GetVolume write SetVolume;
  end;

var
  MidiMapperDeviceID: Cardinal = MIDI_MAPPER;

function MidiOut(DeviceID: Cardinal): IJclWinMidiOut;
var
  Device: TMidiOut;
begin
  if DeviceID = MIDI_MAPPER then
    DeviceID := MidiMapperDeviceID;
  Device := nil;
  if DeviceID <> MIDI_MAPPER then
    Device := TMidiOut(MidiOutputs.Objects[DeviceID]);
  // make instance a singleton for a given device ID
  if not Assigned(Device) then
  begin
    Device := TMidiOut.Create(DeviceID);
    if DeviceID = MIDI_MAPPER then
      MidiMapperDeviceID := Device.DeviceID;
    // cannot use DeviceID argument as index here, since it might be MIDI_MAPPER
    MidiOutputs.Objects[Device.DeviceID] := Device;
  end;
  Result := Device;
end;

constructor TMidiOut.Create(ADeviceID: Cardinal);
begin
  inherited Create;
  FVolume := $FFFFFFFF; // max. volume, in case Get/SetChannelVolume not supported
  MidiOutCheck(midiOutGetDevCaps(ADeviceID, @FDeviceCaps, SizeOf(FDeviceCaps)));
  MidiOutCheck(midiOutOpen(@FHandle, ADeviceID, 0, 0, 0));
  MidiOutCheck(midiOutGetID(FHandle, @FDeviceID));
end;

destructor TMidiOut.Destroy;
begin
  inherited Destroy;
  midiOutClose(FHandle);
  MidiOutputs.Objects[FDeviceID] := nil;
end;

function TMidiOut.GetName: string;
begin
  Result := FDeviceCaps.szPName;
end;

procedure TMidiOut.LongMessage(const Data: array of Byte);
var
  Hdr: MIDIHDR;
begin
  FillChar(Hdr, SizeOf(Hdr), 0);
  Hdr.dwBufferLength := High(Data) - Low(Data) + 1;;
  Hdr.dwBytesRecorded := Hdr.dwBufferLength;
  Hdr.lpData := @Data;
  Hdr.dwFlags := 0;
  MidiOutCheck(midiOutPrepareHeader(FHandle, @Hdr, SizeOf(Hdr)));
  MidiOutCheck(midiOutLongMsg(FHandle, @Hdr, SizeOf(Hdr)));
  repeat until (Hdr.dwFlags and MHDR_DONE) <> 0;
end;

procedure TMidiOut.DoSendMessage(const Data: array of Byte);
var
  I: Integer;
  Msg: packed record
  case Integer of
    0:
      (Bytes: array [0..2] of Byte);
    1:
      (DWord: LongWord);
  end;
begin
  if High(Data) < 3 then
  begin
    for I := 0 to High(Data) do
      Msg.Bytes[I] := Data[I];
    MidiOutCheck(midiOutShortMsg(FHandle, Msg.DWord));
  end
  else LongMessage(Data);
end;

function TMidiOut.GetChannelVolume(Channel: TStereoChannel): Word;
begin
  midiOutGetVolume(FHandle, @FVolume);
  Result := FVolume;
end;

procedure TMidiOut.SetChannelVolume(Channel: TStereoChannel; const Value: Word);
begin
  if Channel = scLeft then
    SetLRVolume(Value, ChannelVolume[scRight])
  else
    SetLRVolume(ChannelVolume[scLeft], Value);
end;

function TMidiOut.GetVolume: Word;
begin
  Result := GetChannelVolume(scLeft);
end;

procedure TMidiOut.SetVolume(const Value: Word);
begin
  SetLRVolume(Value, Value);
end;

procedure TMidiOut.SetLRVolume(const LeftValue, RightValue: Word);
var
  Value: DWord;
begin
  with LongRec(Value) do
  begin
    Lo := LeftValue;
    Hi := RightValue;
  end;
  if Value <> FVolume then
  begin
    if (MIDICAPS_VOLUME and FDeviceCaps.dwSupport) <> 0 then
      MidiOutCheck(midiOutSetVolume(FHandle, Value));
    FVolume := Value;
  end;
end;

initialization

finalization
  FreeAndNil(FMidiOutputs);
  
// History:

// $Log: JclWinMIDI.pas,v $
// Revision 1.13  2005/02/25 07:20:16  marquardt
// add section lines
//
// Revision 1.12  2005/02/24 16:34:53  marquardt
// remove divider lines, add section lines (unfinished)
//
// Revision 1.11  2004/10/17 21:00:16  mthoma
// cleaning
//
// Revision 1.10  2004/07/31 06:21:03  marquardt
// fixing TStringLists, adding BeginUpdate/EndUpdate, finalization improved
//
// Revision 1.9  2004/07/28 18:00:55  marquardt
// various style cleanings, some minor fixes
//
// Revision 1.8  2004/06/16 07:30:31  marquardt
// added tilde to all IFNDEF ENDIFs, inherited qualified
//
// Revision 1.7  2004/06/14 11:05:53  marquardt
// symbols added to all ENDIFs and some other minor style changes like removing IFOPT
//
// Revision 1.6  2004/05/05 07:33:49  rrossmair
// header updated according to new policy: initial developers & contributors listed
//
// Revision 1.5  2004/04/06 04:55:18  
// adapt compiler conditions, add log entry
//

end.
