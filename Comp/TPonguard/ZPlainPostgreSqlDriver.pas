{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{           Native Plain Drivers for PostgreSQL           }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{            Written by Sergey Seroukhov                  }
{                                                         }
{*********************************************************}

{*********************************************************}
{ License Agreement:                                      }
{                                                         }
{ This library is free software; you can redistribute     }
{ it and/or modify it under the terms of the GNU Lesser   }
{ General Public License as published by the Free         }
{ Software Foundation; either version 2.1 of the License, }
{ or (at your option) any later version.                  }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ You should have received a copy of the GNU Lesser       }
{ General Public License along with this library; if not, }
{ write to the Free Software Foundation, Inc.,            }
{ 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA }
{                                                         }
{ The project web site is located on:                     }
{   http://www.sourceforge.net/projects/zeoslib.          }
{   http://www.zeoslib.sourceforge.net                    }
{                                                         }
{                                 Zeos Development Group. }
{*********************************************************}

unit ZPlainPostgreSqlDriver;

interface

{$I ZPlain.inc}

uses ZClasses, ZCompatibility, ZPlainDriver;

const
{ Type Lengths }
  NAMEDATALEN  = 32;

{ OIDNAMELEN should be set to NAMEDATALEN + sizeof(Oid) }
  OIDNAMELEN   = 36;

  INV_WRITE    = $00020000;
  INV_READ     = $00040000;

  BLOB_SEEK_SET     = 0;
  BLOB_SEEK_CUR     = 1;
  BLOB_SEEK_END     = 2;

type

{ Application-visible enum types }
  TZPostgreSQLConnectStatusType = (
    CONNECTION_OK,
    CONNECTION_BAD
  );

  TZPostgreSQLExecStatusType = (
    PGRES_EMPTY_QUERY,
    PGRES_COMMAND_OK,		{ a query command that doesn't return anything
				  was executed properly by the backend }
    PGRES_TUPLES_OK,		{ a query command that returns tuples
				  was executed properly by the backend,
				  PGresult contains the result tuples }
    PGRES_COPY_OUT,		{ Copy Out data transfer in progress }
    PGRES_COPY_IN,		{ Copy In data transfer in progress }
    PGRES_BAD_RESPONSE,		{ an unexpected response was recv'd from
				  the backend }
    PGRES_NONFATAL_ERROR,
    PGRES_FATAL_ERROR
  );

{ PGnotify represents the occurrence of a NOTIFY message.
  Ideally this would be an opaque typedef, but it's so simple that it's
  unlikely to change.
  NOTE: in Postgres 6.4 and later, the be_pid is the notifying backend's,
  whereas in earlier versions it was always your own backend's PID.
}
  TZPostgreSQLNotify = packed record
    relname: array [0..NAMEDATALEN-1] of Char; { name of relation containing data }
    be_pid:  Integer;			      { process id of backend }
  end;

  PZPostgreSQLNotify = ^TZPostgreSQLNotify;

{ PQnoticeProcessor is the function type for the notice-message callback. }

  TZPostgreSQLNoticeProcessor = procedure(arg: Pointer; message: PChar); cdecl;

{ Structure for the conninfo parameter definitions returned by PQconndefaults }

  TZPostgreSQLConnectInfoOption = packed record
    keyword:  PChar;	{ The keyword of the option }
    envvar:   PChar;	{ Fallback environment variable name }
    compiled: PChar;	{ Fallback compiled in default value  }
    val:      PChar;	{ Options value	}
    lab:      PChar;	{ Label for field in connect dialog }
    dispchar: PChar;	{ Character to display for this field
			  in a connect dialog. Values are:
			  ""	Display entered value as is
			  "*"	Password field - hide value
			  "D"	Debug options - don't
			  create a field by default }
    dispsize: Integer;	{ Field size in characters for dialog }
  end;

  PZPostgreSQLConnectInfoOption = ^TZPostgreSQLConnectInfoOption;

{ PQArgBlock -- structure for PQfn() arguments }

  TZPostgreSQLArgBlock = packed record
    len:     Integer;
    isint:   Integer;
    case u: Boolean of
      True:  (ptr: PInteger);	{ can't use void (dec compiler barfs)	 }
      False: (_int: Integer);
  end;

  PZPostgreSQLArgBlock = ^TZPostgreSQLArgBlock;

  PZPostgreSQLConnect = Pointer;
  PZPostgreSQLResult = Pointer;
  Oid = Integer;

type

  {** Represents a generic interface to PostgreSQL native API. }
  IZPostgreSQLPlainDriver = interface (IZPlainDriver)
    ['{03CD6345-2D7A-4FE2-B03D-3C5656789FEB}']

    function ConnectDatabase(ConnInfo: PChar): PZPostgreSQLConnect;
    function SetDatabaseLogin(Host, Port, Options, TTY, Db, User,
      Passwd: PChar): PZPostgreSQLConnect;
    function GetConnectDefaults: PZPostgreSQLConnectInfoOption;

    procedure Finish(Handle: PZPostgreSQLConnect);
    procedure Reset(Handle: PZPostgreSQLConnect);
    function RequestCancel(Handle: PZPostgreSQLConnect): Integer;
    function GetDatabase(Handle: PZPostgreSQLConnect): PChar;
    function GetUser(Handle: PZPostgreSQLConnect): PChar;
    function GetPassword(Handle: PZPostgreSQLConnect): PChar;
    function GetHost(Handle: PZPostgreSQLConnect): PChar;
    function GetPort(Handle: PZPostgreSQLConnect): PChar;
    function GetTTY(Handle: PZPostgreSQLConnect): PChar; cdecl;
    function GetOptions(Handle: PZPostgreSQLConnect): PChar;
    function GetStatus(Handle: PZPostgreSQLConnect):
      TZPostgreSQLConnectStatusType;

    function GetErrorMessage(Handle: PZPostgreSQLConnect): PChar;
    function GetSocket(Handle: PZPostgreSQLConnect): Integer;
    function GetBackendPID(Handle: PZPostgreSQLConnect): Integer;
    procedure Trace(Handle: PZPostgreSQLConnect; DebugPort: Pointer);
    procedure Untrace(Handle: PZPostgreSQLConnect);
    procedure SetNoticeProcessor(Handle: PZPostgreSQLConnect;
      Proc: TZPostgreSQLNoticeProcessor; Arg: Pointer);

    function ExecuteQuery(Handle: PZPostgreSQLConnect;
      Query: PChar): PZPostgreSQLResult;

    function Notifies(Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
    procedure FreeNotify(Handle: PZPostgreSQLNotify);

    function SendQuery(Handle: PZPostgreSQLConnect; Query: PChar): Integer;
    function GetResult(Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
    function IsBusy(Handle: PZPostgreSQLConnect): Integer;
    function ConsumeInput(Handle: PZPostgreSQLConnect): Integer;
    function GetLine(Handle: PZPostgreSQLConnect; Str: PChar;
      Length: Integer): Integer;
    function PutLine(Handle: PZPostgreSQLConnect; Str: PChar): Integer;
    function GetLineAsync(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;

    function PutBytes(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function EndCopy(Handle: PZPostgreSQLConnect): Integer;
    function ExecuteFunction(Handle: PZPostgreSQLConnect; fnid: Integer;
      result_buf, result_len: PInteger; result_is_int: Integer;
      args: PZPostgreSQLArgBlock; nargs: Integer): PZPostgreSQLResult;
    function GetResultStatus(Res: PZPostgreSQLResult):
      TZPostgreSQLExecStatusType;
    function GetResultErrorMessage(Res: PZPostgreSQLResult): PChar;

    function GetRowCount(Res: PZPostgreSQLResult): Integer;
    function GetFieldCount(Res: PZPostgreSQLResult): Integer;

    function GetBinaryTuples(Res: PZPostgreSQLResult): Integer;
    function GetFieldName(Res: PZPostgreSQLResult;
      FieldNum: Integer): PChar;
    function GetFieldNumber(Res: PZPostgreSQLResult;
      FieldName: PChar): Integer;
    function GetFieldType(Res: PZPostgreSQLResult;
      FieldNum: Integer): Oid;
    function GetFieldSize(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetFieldMode(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetCommandStatus(Res: PZPostgreSQLResult): PChar;
    function GetOidValue(Res: PZPostgreSQLResult): Oid;
    function GetOidStatus(Res: PZPostgreSQLResult): PChar;
    function GetCommandTuples(Res: PZPostgreSQLResult): PChar;

    function GetValue(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): PChar;
    function GetLength(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    function GetIsNull(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    procedure Clear(Res: PZPostgreSQLResult);

    function MakeEmptyResult(Handle: PZPostgreSQLConnect;
      Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;

    function OpenLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      Mode: Integer): Integer;
    function CloseLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function ReadLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function WriteLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function SeekLargeObject(Handle: PZPostgreSQLConnect;
      Fd, Offset, Whence: Integer): Integer;
    function CreateLargeObject(Handle: PZPostgreSQLConnect;
      Mode: Integer): Oid;
    function TellLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function UnlinkLargeObject(Handle: PZPostgreSQLConnect;
      ObjId: Oid): Integer;
    function ImportLargeObject(Handle: PZPostgreSQLConnect;
      FileName: PChar): Oid;
    function ExportLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      FileName: PChar): Integer;
  end;

  {** Implements a driver for PostgreSQL 6.5 }
  TZPostgreSQL65PlainDriver = class(TZAbstractObject, IZPlainDriver,
    IZPostgreSQLPlainDriver)
  public
    constructor Create;

    function GetProtocol: string;
    function GetDescription: string;
    procedure Initialize;

    function ConnectDatabase(ConnInfo: PChar): PZPostgreSQLConnect;
    function SetDatabaseLogin(Host, Port, Options, TTY, Db, User,
      Passwd: PChar): PZPostgreSQLConnect;
    function GetConnectDefaults: PZPostgreSQLConnectInfoOption;

    procedure Finish(Handle: PZPostgreSQLConnect);
    procedure Reset(Handle: PZPostgreSQLConnect);
    function RequestCancel(Handle: PZPostgreSQLConnect): Integer;
    function GetDatabase(Handle: PZPostgreSQLConnect): PChar;
    function GetUser(Handle: PZPostgreSQLConnect): PChar;
    function GetPassword(Handle: PZPostgreSQLConnect): PChar;
    function GetHost(Handle: PZPostgreSQLConnect): PChar;
    function GetPort(Handle: PZPostgreSQLConnect): PChar;
    function GetTTY(Handle: PZPostgreSQLConnect): PChar; cdecl;
    function GetOptions(Handle: PZPostgreSQLConnect): PChar;
    function GetStatus(Handle: PZPostgreSQLConnect):
      TZPostgreSQLConnectStatusType;

    function GetErrorMessage(Handle: PZPostgreSQLConnect): PChar;
    function GetSocket(Handle: PZPostgreSQLConnect): Integer;
    function GetBackendPID(Handle: PZPostgreSQLConnect): Integer;
    procedure Trace(Handle: PZPostgreSQLConnect; DebugPort: Pointer);
    procedure Untrace(Handle: PZPostgreSQLConnect);
    procedure SetNoticeProcessor(Handle: PZPostgreSQLConnect;
      Proc: TZPostgreSQLNoticeProcessor; Arg: Pointer);

    function ExecuteQuery(Handle: PZPostgreSQLConnect;
      Query: PChar): PZPostgreSQLResult;

    function Notifies(Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
    procedure FreeNotify(Handle: PZPostgreSQLNotify);

    function SendQuery(Handle: PZPostgreSQLConnect; Query: PChar): Integer;
    function GetResult(Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
    function IsBusy(Handle: PZPostgreSQLConnect): Integer;
    function ConsumeInput(Handle: PZPostgreSQLConnect): Integer;
    function GetLine(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function PutLine(Handle: PZPostgreSQLConnect; Buffer: PChar): Integer;
    function GetLineAsync(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;

    function PutBytes(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function EndCopy(Handle: PZPostgreSQLConnect): Integer;
    function ExecuteFunction(Handle: PZPostgreSQLConnect; fnid: Integer;
      result_buf, result_len: PInteger; result_is_int: Integer;
      args: PZPostgreSQLArgBlock; nargs: Integer): PZPostgreSQLResult;
    function GetResultStatus(Res: PZPostgreSQLResult):
      TZPostgreSQLExecStatusType;
    function GetResultErrorMessage(Res: PZPostgreSQLResult): PChar;

    function GetRowCount(Res: PZPostgreSQLResult): Integer;
    function GetFieldCount(Res: PZPostgreSQLResult): Integer;

    function GetBinaryTuples(Res: PZPostgreSQLResult): Integer;
    function GetFieldName(Res: PZPostgreSQLResult;
      FieldNum: Integer): PChar;
    function GetFieldNumber(Res: PZPostgreSQLResult;
      FieldName: PChar): Integer;
    function GetFieldType(Res: PZPostgreSQLResult;
      FieldNum: Integer): Oid;
    function GetFieldSize(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetFieldMode(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetCommandStatus(Res: PZPostgreSQLResult): PChar;
    function GetOidValue(Res: PZPostgreSQLResult): Oid;
    function GetOidStatus(Res: PZPostgreSQLResult): PChar;
    function GetCommandTuples(Res: PZPostgreSQLResult): PChar;

    function GetValue(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): PChar;
    function GetLength(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    function GetIsNull(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    procedure Clear(Res: PZPostgreSQLResult);

    function MakeEmptyResult(Handle: PZPostgreSQLConnect;
      Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;

    function OpenLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      Mode: Integer): Integer;
    function CloseLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function ReadLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function WriteLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function SeekLargeObject(Handle: PZPostgreSQLConnect;
      Fd, Offset, Whence: Integer): Integer;
    function CreateLargeObject(Handle: PZPostgreSQLConnect;
      Mode: Integer): Oid;
    function TellLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function UnlinkLargeObject(Handle: PZPostgreSQLConnect;
      ObjId: Oid): Integer;
    function ImportLargeObject(Handle: PZPostgreSQLConnect;
      FileName: PChar): Oid;
    function ExportLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      FileName: PChar): Integer;
  end;

  {** Implements a driver for PostgreSQL 7.2 }
  TZPostgreSQL72PlainDriver = class(TZAbstractObject, IZPlainDriver,
    IZPostgreSQLPlainDriver)
  public
    constructor Create;

    function GetProtocol: string;
    function GetDescription: string;
    procedure Initialize;

    function ConnectDatabase(ConnInfo: PChar): PZPostgreSQLConnect;
    function SetDatabaseLogin(Host, Port, Options, TTY, Db, User,
      Passwd: PChar): PZPostgreSQLConnect;
    function GetConnectDefaults: PZPostgreSQLConnectInfoOption;

    procedure Finish(Handle: PZPostgreSQLConnect);
    procedure Reset(Handle: PZPostgreSQLConnect);
    function RequestCancel(Handle: PZPostgreSQLConnect): Integer;
    function GetDatabase(Handle: PZPostgreSQLConnect): PChar;
    function GetUser(Handle: PZPostgreSQLConnect): PChar;
    function GetPassword(Handle: PZPostgreSQLConnect): PChar;
    function GetHost(Handle: PZPostgreSQLConnect): PChar;
    function GetPort(Handle: PZPostgreSQLConnect): PChar;
    function GetTTY(Handle: PZPostgreSQLConnect): PChar; cdecl;
    function GetOptions(Handle: PZPostgreSQLConnect): PChar;
    function GetStatus(Handle: PZPostgreSQLConnect):
      TZPostgreSQLConnectStatusType;

    function GetErrorMessage(Handle: PZPostgreSQLConnect): PChar;
    function GetSocket(Handle: PZPostgreSQLConnect): Integer;
    function GetBackendPID(Handle: PZPostgreSQLConnect): Integer;
    procedure Trace(Handle: PZPostgreSQLConnect; DebugPort: Pointer);
    procedure Untrace(Handle: PZPostgreSQLConnect);
    procedure SetNoticeProcessor(Handle: PZPostgreSQLConnect;
      Proc: TZPostgreSQLNoticeProcessor; Arg: Pointer);

    function ExecuteQuery(Handle: PZPostgreSQLConnect;
      Query: PChar): PZPostgreSQLResult;

    function Notifies(Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
    procedure FreeNotify(Handle: PZPostgreSQLNotify);

    function SendQuery(Handle: PZPostgreSQLConnect; Query: PChar): Integer;
    function GetResult(Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
    function IsBusy(Handle: PZPostgreSQLConnect): Integer;
    function ConsumeInput(Handle: PZPostgreSQLConnect): Integer;
    function GetLine(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function PutLine(Handle: PZPostgreSQLConnect; Buffer: PChar): Integer;
    function GetLineAsync(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;

    function PutBytes(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function EndCopy(Handle: PZPostgreSQLConnect): Integer;
    function ExecuteFunction(Handle: PZPostgreSQLConnect; fnid: Integer;
      result_buf, result_len: PInteger; result_is_int: Integer;
      args: PZPostgreSQLArgBlock; nargs: Integer): PZPostgreSQLResult;
    function GetResultStatus(Res: PZPostgreSQLResult):
      TZPostgreSQLExecStatusType;
    function GetResultErrorMessage(Res: PZPostgreSQLResult): PChar;

    function GetRowCount(Res: PZPostgreSQLResult): Integer;
    function GetFieldCount(Res: PZPostgreSQLResult): Integer;

    function GetBinaryTuples(Res: PZPostgreSQLResult): Integer;
    function GetFieldName(Res: PZPostgreSQLResult;
      FieldNum: Integer): PChar;
    function GetFieldNumber(Res: PZPostgreSQLResult;
      FieldName: PChar): Integer;
    function GetFieldType(Res: PZPostgreSQLResult;
      FieldNum: Integer): Oid;
    function GetFieldSize(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetFieldMode(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetCommandStatus(Res: PZPostgreSQLResult): PChar;
    function GetOidValue(Res: PZPostgreSQLResult): Oid;
    function GetOidStatus(Res: PZPostgreSQLResult): PChar;
    function GetCommandTuples(Res: PZPostgreSQLResult): PChar;

    function GetValue(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): PChar;
    function GetLength(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    function GetIsNull(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    procedure Clear(Res: PZPostgreSQLResult);

    function MakeEmptyResult(Handle: PZPostgreSQLConnect;
      Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;

    function OpenLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      Mode: Integer): Integer;
    function CloseLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function ReadLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function WriteLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function SeekLargeObject(Handle: PZPostgreSQLConnect;
      Fd, Offset, Whence: Integer): Integer;
    function CreateLargeObject(Handle: PZPostgreSQLConnect;
      Mode: Integer): Oid;
    function TellLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function UnlinkLargeObject(Handle: PZPostgreSQLConnect;
      ObjId: Oid): Integer;
    function ImportLargeObject(Handle: PZPostgreSQLConnect;
      FileName: PChar): Oid;
    function ExportLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      FileName: PChar): Integer;
  end;


{** Implements a driver for PostgreSQL 7.2 }
  TZPostgreSQL73PlainDriver = class(TZAbstractObject, IZPlainDriver,
    IZPostgreSQLPlainDriver)
  public
    constructor Create;

    function GetProtocol: string;
    function GetDescription: string;
    procedure Initialize;

    function ConnectDatabase(ConnInfo: PChar): PZPostgreSQLConnect;
    function SetDatabaseLogin(Host, Port, Options, TTY, Db, User,
      Passwd: PChar): PZPostgreSQLConnect;
    function GetConnectDefaults: PZPostgreSQLConnectInfoOption;

    procedure Finish(Handle: PZPostgreSQLConnect);
    procedure Reset(Handle: PZPostgreSQLConnect);
    function RequestCancel(Handle: PZPostgreSQLConnect): Integer;
    function GetDatabase(Handle: PZPostgreSQLConnect): PChar;
    function GetUser(Handle: PZPostgreSQLConnect): PChar;
    function GetPassword(Handle: PZPostgreSQLConnect): PChar;
    function GetHost(Handle: PZPostgreSQLConnect): PChar;
    function GetPort(Handle: PZPostgreSQLConnect): PChar;
    function GetTTY(Handle: PZPostgreSQLConnect): PChar; cdecl;
    function GetOptions(Handle: PZPostgreSQLConnect): PChar;
    function GetStatus(Handle: PZPostgreSQLConnect):
      TZPostgreSQLConnectStatusType;

    function GetErrorMessage(Handle: PZPostgreSQLConnect): PChar;
    function GetSocket(Handle: PZPostgreSQLConnect): Integer;
    function GetBackendPID(Handle: PZPostgreSQLConnect): Integer;
    procedure Trace(Handle: PZPostgreSQLConnect; DebugPort: Pointer);
    procedure Untrace(Handle: PZPostgreSQLConnect);
    procedure SetNoticeProcessor(Handle: PZPostgreSQLConnect;
      Proc: TZPostgreSQLNoticeProcessor; Arg: Pointer);

    function ExecuteQuery(Handle: PZPostgreSQLConnect;
      Query: PChar): PZPostgreSQLResult;

    function Notifies(Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
    procedure FreeNotify(Handle: PZPostgreSQLNotify);

    function SendQuery(Handle: PZPostgreSQLConnect; Query: PChar): Integer;
    function GetResult(Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
    function IsBusy(Handle: PZPostgreSQLConnect): Integer;
    function ConsumeInput(Handle: PZPostgreSQLConnect): Integer;
    function GetLine(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function PutLine(Handle: PZPostgreSQLConnect; Buffer: PChar): Integer;
    function GetLineAsync(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;

    function PutBytes(Handle: PZPostgreSQLConnect; Buffer: PChar;
      Length: Integer): Integer;
    function EndCopy(Handle: PZPostgreSQLConnect): Integer;
    function ExecuteFunction(Handle: PZPostgreSQLConnect; fnid: Integer;
      result_buf, result_len: PInteger; result_is_int: Integer;
      args: PZPostgreSQLArgBlock; nargs: Integer): PZPostgreSQLResult;
    function GetResultStatus(Res: PZPostgreSQLResult):
      TZPostgreSQLExecStatusType;
    function GetResultErrorMessage(Res: PZPostgreSQLResult): PChar;

    function GetRowCount(Res: PZPostgreSQLResult): Integer;
    function GetFieldCount(Res: PZPostgreSQLResult): Integer;

    function GetBinaryTuples(Res: PZPostgreSQLResult): Integer;
    function GetFieldName(Res: PZPostgreSQLResult;
      FieldNum: Integer): PChar;
    function GetFieldNumber(Res: PZPostgreSQLResult;
      FieldName: PChar): Integer;
    function GetFieldType(Res: PZPostgreSQLResult;
      FieldNum: Integer): Oid;
    function GetFieldSize(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetFieldMode(Res: PZPostgreSQLResult;
      FieldNum: Integer): Integer;
    function GetCommandStatus(Res: PZPostgreSQLResult): PChar;
    function GetOidValue(Res: PZPostgreSQLResult): Oid;
    function GetOidStatus(Res: PZPostgreSQLResult): PChar;
    function GetCommandTuples(Res: PZPostgreSQLResult): PChar;

    function GetValue(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): PChar;
    function GetLength(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    function GetIsNull(Res: PZPostgreSQLResult;
      TupNum, FieldNum: Integer): Integer;
    procedure Clear(Res: PZPostgreSQLResult);

    function MakeEmptyResult(Handle: PZPostgreSQLConnect;
      Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;

    function OpenLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      Mode: Integer): Integer;
    function CloseLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function ReadLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function WriteLargeObject(Handle: PZPostgreSQLConnect; Fd: Integer;
      Buffer: PChar; Length: Integer): Integer;
    function SeekLargeObject(Handle: PZPostgreSQLConnect;
      Fd, Offset, Whence: Integer): Integer;
    function CreateLargeObject(Handle: PZPostgreSQLConnect;
      Mode: Integer): Oid;
    function TellLargeObject(Handle: PZPostgreSQLConnect;
      Fd: Integer): Integer;
    function UnlinkLargeObject(Handle: PZPostgreSQLConnect;
      ObjId: Oid): Integer;
    function ImportLargeObject(Handle: PZPostgreSQLConnect;
      FileName: PChar): Oid;
    function ExportLargeObject(Handle: PZPostgreSQLConnect; ObjId: Oid;
      FileName: PChar): Integer;
  end;

implementation

uses SysUtils, ZPlainPostgreSql65, ZPlainPostgreSql72, ZPlainPostgreSql73;

{ TZPostgreSQL65PlainDriver }

constructor TZPostgreSQL65PlainDriver.Create;
begin
end;

function TZPostgreSQL65PlainDriver.GetProtocol: string;
begin
  Result := 'postgresql-6.5';
end;

function TZPostgreSQL65PlainDriver.GetDescription: string;
begin
  Result := 'Native Plain Driver for PostgreSQL 6.5+';
end;

procedure TZPostgreSQL65PlainDriver.Initialize;
begin
  ZPlainPostgreSql65.LibraryLoader.LoadIfNeeded;
end;

procedure TZPostgreSQL65PlainDriver.Clear(Res: PZPostgreSQLResult);
begin
  ZPlainPostgreSql65.PQclear(Res);
end;

function TZPostgreSQL65PlainDriver.CloseLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.lo_close(Handle, Fd);
end;

function TZPostgreSQL65PlainDriver.ConnectDatabase(
  ConnInfo: PChar): PZPostgreSQLConnect;
begin
  Result := ZPlainPostgreSql65.PQconnectdb(ConnInfo);
end;

function TZPostgreSQL65PlainDriver.ConsumeInput(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql65.PQconsumeInput(Handle);
end;

function TZPostgreSQL65PlainDriver.CreateLargeObject(
  Handle: PZPostgreSQLConnect; Mode: Integer): Oid;
begin
  Result := ZPlainPostgreSql65.lo_creat(Handle, Mode);
end;

function TZPostgreSQL65PlainDriver.EndCopy(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql65.PQendcopy(Handle);
end;

function TZPostgreSQL65PlainDriver.ExecuteFunction(
  Handle: PZPostgreSQLConnect; fnid: Integer; result_buf,
  result_len: PInteger; result_is_int: Integer; args: PZPostgreSQLArgBlock;
  nargs: Integer): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql65.PQfn(Handle, fnid, result_buf,
    result_len, result_is_int, ZPlainPostgreSql65.PPQArgBlock(args), nargs);
end;

function TZPostgreSQL65PlainDriver.ExecuteQuery(
  Handle: PZPostgreSQLConnect; Query: PChar): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql65.PQexec(Handle, Query);
end;

function TZPostgreSQL65PlainDriver.ExportLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid; FileName: PChar): Integer;
begin
  Result := ZPlainPostgreSql65.lo_export(Handle, ObjId, FileName);
end;

procedure TZPostgreSQL65PlainDriver.Finish(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql65.PQfinish(Handle);
end;

procedure TZPostgreSQL65PlainDriver.FreeNotify(Handle: PZPostgreSQLNotify);
begin
  ZPlainPostgreSql65.PQnotifyFree(ZPlainPostgreSql65.PPGnotify(Handle));
end;

function TZPostgreSQL65PlainDriver.GetBackendPID(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql65.PQbackendPID(Handle);
end;

function TZPostgreSQL65PlainDriver.GetBinaryTuples(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql65.PQbinaryTuples(Res);
end;

function TZPostgreSQL65PlainDriver.GetCommandStatus(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql65.PQcmdStatus(Res);
end;

function TZPostgreSQL65PlainDriver.GetCommandTuples(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql65.PQcmdTuples(Res);
end;

function TZPostgreSQL65PlainDriver.GetConnectDefaults:
  PZPostgreSQLConnectInfoOption;
begin
  Result := PZPostgreSQLConnectInfoOption(ZPlainPostgreSql65.PQconndefaults);
end;

function TZPostgreSQL65PlainDriver.GetDatabase(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQdb(Handle);
end;

function TZPostgreSQL65PlainDriver.GetErrorMessage(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQerrorMessage(Handle);
end;

function TZPostgreSQL65PlainDriver.GetFieldCount(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql65.PQnfields(Res);
end;

function TZPostgreSQL65PlainDriver.GetFieldMode(Res: PZPostgreSQLResult;
  FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQfmod(Res, FieldNum);
end;

function TZPostgreSQL65PlainDriver.GetFieldName(Res: PZPostgreSQLResult;
  FieldNum: Integer): PChar;
begin
  Result := ZPlainPostgreSql65.PQfname(Res, FieldNum);
end;

function TZPostgreSQL65PlainDriver.GetFieldNumber(
  Res: PZPostgreSQLResult; FieldName: PChar): Integer;
begin
  Result := ZPlainPostgreSql65.PQfnumber(Res, FieldName);
end;

function TZPostgreSQL65PlainDriver.GetFieldSize(Res: PZPostgreSQLResult;
  FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQfsize(Res, FieldNum);
end;

function TZPostgreSQL65PlainDriver.GetFieldType(Res: PZPostgreSQLResult;
  FieldNum: Integer): Oid;
begin
  Result := ZPlainPostgreSql65.PQftype(Res, FieldNum);
end;

function TZPostgreSQL65PlainDriver.GetHost(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQhost(Handle);
end;

function TZPostgreSQL65PlainDriver.GetIsNull(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQgetisnull(Res, TupNum, FieldNum);
end;

function TZPostgreSQL65PlainDriver.GetLength(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQgetlength(Res, TupNum, FieldNum);
end;

function TZPostgreSQL65PlainDriver.GetLine(Handle: PZPostgreSQLConnect;
  Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQgetline(Handle, Buffer, Length);
end;

function TZPostgreSQL65PlainDriver.GetLineAsync(
  Handle: PZPostgreSQLConnect; Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQgetlineAsync(Handle, Buffer, Length);
end;

function TZPostgreSQL65PlainDriver.GetOidStatus(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql65.PQoidStatus(Res);
end;

function TZPostgreSQL65PlainDriver.GetOidValue(
  Res: PZPostgreSQLResult): Oid;
begin
  Result := ZPlainPostgreSql65.PQoidValue(Res);
end;

function TZPostgreSQL65PlainDriver.GetOptions(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQoptions(Handle);
end;

function TZPostgreSQL65PlainDriver.GetPassword(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQpass(Handle);
end;

function TZPostgreSQL65PlainDriver.GetPort(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQport(Handle);
end;

function TZPostgreSQL65PlainDriver.GetResult(
  Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql65.PQgetResult(Handle);
end;

function TZPostgreSQL65PlainDriver.GetResultErrorMessage(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql65.PQresultErrorMessage(Res);
end;

function TZPostgreSQL65PlainDriver.GetResultStatus(
  Res: PZPostgreSQLResult): TZPostgreSQLExecStatusType;
begin
  Result := TZPostgreSQLExecStatusType(ZPlainPostgreSql65.PQresultStatus(Res));
end;

function TZPostgreSQL65PlainDriver.GetRowCount(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql65.PQntuples(Res);
end;

function TZPostgreSQL65PlainDriver.GetSocket(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql65.PQsocket(Handle);
end;

function TZPostgreSQL65PlainDriver.GetStatus(
  Handle: PZPostgreSQLConnect): TZPostgreSQLConnectStatusType;
begin
  Result := TZPostgreSQLConnectStatusType(ZPlainPostgreSql65.PQstatus(Handle));
end;

function TZPostgreSQL65PlainDriver.GetTTY(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQtty(Handle);
end;

function TZPostgreSQL65PlainDriver.GetUser(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql65.PQuser(Handle);
end;

function TZPostgreSQL65PlainDriver.GetValue(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): PChar;
begin
  Result := ZPlainPostgreSql65.PQgetvalue(Res, TupNum, FieldNum);
end;

function TZPostgreSQL65PlainDriver.ImportLargeObject(
  Handle: PZPostgreSQLConnect; FileName: PChar): Oid;
begin
  Result := ZPlainPostgreSql65.lo_import(Handle, FileName);
end;

function TZPostgreSQL65PlainDriver.IsBusy(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql65.PQisBusy(Handle);
end;

function TZPostgreSQL65PlainDriver.MakeEmptyResult(
  Handle: PZPostgreSQLConnect;
  Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql65.PQmakeEmptyPGresult(Handle,
    ZPlainPostgreSql65.ExecStatusType(Status));
end;

function TZPostgreSQL65PlainDriver.Notifies(
  Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
begin
  Result := PZPostgreSQLNotify(ZPlainPostgreSql65.PQnotifies(Handle));
end;

function TZPostgreSQL65PlainDriver.OpenLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid; Mode: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.lo_open(Handle, ObjId, Mode);
end;

function TZPostgreSQL65PlainDriver.PutBytes(Handle: PZPostgreSQLConnect;
  Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.PQputnbytes(Handle, Buffer, Length);
end;

function TZPostgreSQL65PlainDriver.PutLine(Handle: PZPostgreSQLConnect;
  Buffer: PChar): Integer;
begin
  Result := ZPlainPostgreSql65.PQputline(Handle, Buffer);
end;

function TZPostgreSQL65PlainDriver.ReadLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer; Buffer: PChar;
  Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.lo_read(Handle, Fd, Buffer, Length);
end;

function TZPostgreSQL65PlainDriver.RequestCancel(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql65.PQrequestCancel(Handle);
end;

procedure TZPostgreSQL65PlainDriver.Reset(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql65.PQreset(Handle);
end;

function TZPostgreSQL65PlainDriver.SeekLargeObject(
  Handle: PZPostgreSQLConnect; Fd, Offset, Whence: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.lo_lseek(Handle, Fd, Offset, Whence);
end;

function TZPostgreSQL65PlainDriver.SendQuery(Handle: PZPostgreSQLConnect;
  Query: PChar): Integer;
begin
  Result := ZPlainPostgreSql65.PQsendQuery(Handle, Query);
end;

function TZPostgreSQL65PlainDriver.SetDatabaseLogin(Host, Port, Options,
  TTY, Db, User, Passwd: PChar): PZPostgreSQLConnect;
begin
  Result := ZPlainPostgreSql65.PQsetdbLogin(Host, Port, Options, TTY, Db,
    User, Passwd);
end;

procedure TZPostgreSQL65PlainDriver.SetNoticeProcessor(
  Handle: PZPostgreSQLConnect; Proc: TZPostgreSQLNoticeProcessor;
  Arg: Pointer);
begin
  ZPlainPostgreSql65.PQsetNoticeProcessor(Handle, Proc, Arg);
end;

function TZPostgreSQL65PlainDriver.TellLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.lo_tell(Handle, Fd);
end;

procedure TZPostgreSQL65PlainDriver.Trace(Handle: PZPostgreSQLConnect;
  DebugPort: Pointer);
begin
  ZPlainPostgreSql65.PQtrace(Handle, DebugPort);
end;

function TZPostgreSQL65PlainDriver.UnlinkLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid): Integer;
begin
  Result := ZPlainPostgreSql65.lo_unlink(Handle, ObjId);
end;

procedure TZPostgreSQL65PlainDriver.Untrace(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql65.PQuntrace(Handle);
end;

function TZPostgreSQL65PlainDriver.WriteLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer; Buffer: PChar;
  Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql65.lo_write(Handle, Fd, Buffer, Length);
end;

{ TZPostgreSQL72PlainDriver }

constructor TZPostgreSQL72PlainDriver.Create;
begin
end;

function TZPostgreSQL72PlainDriver.GetProtocol: string;
begin
  Result := 'postgresql-7.2';
end;

function TZPostgreSQL72PlainDriver.GetDescription: string;
begin
  Result := 'Native Plain Driver for PostgreSQL 7.2+';
end;

procedure TZPostgreSQL72PlainDriver.Initialize;
begin
  ZPlainPostgreSql72.LibraryLoader.LoadIfNeeded;
end;

procedure TZPostgreSQL72PlainDriver.Clear(Res: PZPostgreSQLResult);
begin
  ZPlainPostgreSql72.PQclear(Res);
end;

function TZPostgreSQL72PlainDriver.CloseLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.lo_close(Handle, Fd);
end;

function TZPostgreSQL72PlainDriver.ConnectDatabase(
  ConnInfo: PChar): PZPostgreSQLConnect;
begin
  Result := ZPlainPostgreSql72.PQconnectdb(ConnInfo);
end;

function TZPostgreSQL72PlainDriver.ConsumeInput(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql72.PQconsumeInput(Handle);
end;

function TZPostgreSQL72PlainDriver.CreateLargeObject(
  Handle: PZPostgreSQLConnect; Mode: Integer): Oid;
begin
  Result := ZPlainPostgreSql72.lo_creat(Handle, Mode);
end;

function TZPostgreSQL72PlainDriver.EndCopy(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql72.PQendcopy(Handle);
end;

function TZPostgreSQL72PlainDriver.ExecuteFunction(
  Handle: PZPostgreSQLConnect; fnid: Integer; result_buf,
  result_len: PInteger; result_is_int: Integer; args: PZPostgreSQLArgBlock;
  nargs: Integer): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql72.PQfn(Handle, fnid, result_buf,
    result_len, result_is_int, ZPlainPostgreSql72.PPQArgBlock(args), nargs);
end;

function TZPostgreSQL72PlainDriver.ExecuteQuery(
  Handle: PZPostgreSQLConnect; Query: PChar): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql72.PQexec(Handle, Query);
end;

function TZPostgreSQL72PlainDriver.ExportLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid; FileName: PChar): Integer;
begin
  Result := ZPlainPostgreSql72.lo_export(Handle, ObjId, FileName);
end;

procedure TZPostgreSQL72PlainDriver.Finish(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql72.PQfinish(Handle);
end;

procedure TZPostgreSQL72PlainDriver.FreeNotify(Handle: PZPostgreSQLNotify);
begin
  ZPlainPostgreSql72.PQfreeNotify(ZPlainPostgreSql72.PPGnotify(Handle));
end;

function TZPostgreSQL72PlainDriver.GetBackendPID(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql72.PQbackendPID(Handle);
end;

function TZPostgreSQL72PlainDriver.GetBinaryTuples(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql72.PQbinaryTuples(Res);
end;

function TZPostgreSQL72PlainDriver.GetCommandStatus(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql72.PQcmdStatus(Res);
end;

function TZPostgreSQL72PlainDriver.GetCommandTuples(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql72.PQcmdTuples(Res);
end;

function TZPostgreSQL72PlainDriver.GetConnectDefaults:
  PZPostgreSQLConnectInfoOption;
begin
  Result := PZPostgreSQLConnectInfoOption(ZPlainPostgreSql72.PQconndefaults);
end;

function TZPostgreSQL72PlainDriver.GetDatabase(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQdb(Handle);
end;

function TZPostgreSQL72PlainDriver.GetErrorMessage(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQerrorMessage(Handle);
end;

function TZPostgreSQL72PlainDriver.GetFieldCount(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql72.PQnfields(Res);
end;

function TZPostgreSQL72PlainDriver.GetFieldMode(Res: PZPostgreSQLResult;
  FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQfmod(Res, FieldNum);
end;

function TZPostgreSQL72PlainDriver.GetFieldName(Res: PZPostgreSQLResult;
  FieldNum: Integer): PChar;
begin
  Result := ZPlainPostgreSql72.PQfname(Res, FieldNum);
end;

function TZPostgreSQL72PlainDriver.GetFieldNumber(
  Res: PZPostgreSQLResult; FieldName: PChar): Integer;
begin
  Result := ZPlainPostgreSql72.PQfnumber(Res, FieldName);
end;

function TZPostgreSQL72PlainDriver.GetFieldSize(Res: PZPostgreSQLResult;
  FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQfsize(Res, FieldNum);
end;

function TZPostgreSQL72PlainDriver.GetFieldType(Res: PZPostgreSQLResult;
  FieldNum: Integer): Oid;
begin
  Result := ZPlainPostgreSql72.PQftype(Res, FieldNum);
end;

function TZPostgreSQL72PlainDriver.GetHost(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQhost(Handle);
end;

function TZPostgreSQL72PlainDriver.GetIsNull(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQgetisnull(Res, TupNum, FieldNum);
end;

function TZPostgreSQL72PlainDriver.GetLength(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQgetlength(Res, TupNum, FieldNum);
end;

function TZPostgreSQL72PlainDriver.GetLine(Handle: PZPostgreSQLConnect;
  Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQgetline(Handle, Buffer, Length);
end;

function TZPostgreSQL72PlainDriver.GetLineAsync(
  Handle: PZPostgreSQLConnect; Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQgetlineAsync(Handle, Buffer, Length);
end;

function TZPostgreSQL72PlainDriver.GetOidStatus(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql72.PQoidStatus(Res);
end;

function TZPostgreSQL72PlainDriver.GetOidValue(
  Res: PZPostgreSQLResult): Oid;
begin
  Result := ZPlainPostgreSql72.PQoidValue(Res);
end;

function TZPostgreSQL72PlainDriver.GetOptions(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQoptions(Handle);
end;

function TZPostgreSQL72PlainDriver.GetPassword(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQpass(Handle);
end;

function TZPostgreSQL72PlainDriver.GetPort(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQport(Handle);
end;

function TZPostgreSQL72PlainDriver.GetResult(
  Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql72.PQgetResult(Handle);
end;

function TZPostgreSQL72PlainDriver.GetResultErrorMessage(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql72.PQresultErrorMessage(Res);
end;

function TZPostgreSQL72PlainDriver.GetResultStatus(
  Res: PZPostgreSQLResult): TZPostgreSQLExecStatusType;
begin
  Result := TZPostgreSQLExecStatusType(ZPlainPostgreSql72.PQresultStatus(Res));
end;

function TZPostgreSQL72PlainDriver.GetRowCount(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql72.PQntuples(Res);
end;

function TZPostgreSQL72PlainDriver.GetSocket(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql72.PQsocket(Handle);
end;

function TZPostgreSQL72PlainDriver.GetStatus(
  Handle: PZPostgreSQLConnect): TZPostgreSQLConnectStatusType;
begin
  Result := TZPostgreSQLConnectStatusType(ZPlainPostgreSql72.PQstatus(Handle));
end;

function TZPostgreSQL72PlainDriver.GetTTY(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQtty(Handle);
end;

function TZPostgreSQL72PlainDriver.GetUser(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql72.PQuser(Handle);
end;

function TZPostgreSQL72PlainDriver.GetValue(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): PChar;
begin
  Result := ZPlainPostgreSql72.PQgetvalue(Res, TupNum, FieldNum);
end;

function TZPostgreSQL72PlainDriver.ImportLargeObject(
  Handle: PZPostgreSQLConnect; FileName: PChar): Oid;
begin
  Result := ZPlainPostgreSql72.lo_import(Handle, FileName);
end;

function TZPostgreSQL72PlainDriver.IsBusy(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql72.PQisBusy(Handle);
end;

function TZPostgreSQL72PlainDriver.MakeEmptyResult(
  Handle: PZPostgreSQLConnect;
  Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql72.PQmakeEmptyPGresult(Handle,
    ZPlainPostgreSql72.ExecStatusType(Status));
end;

function TZPostgreSQL72PlainDriver.Notifies(
  Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
begin
  Result := PZPostgreSQLNotify(ZPlainPostgreSql72.PQnotifies(Handle));
end;

function TZPostgreSQL72PlainDriver.OpenLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid; Mode: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.lo_open(Handle, ObjId, Mode);
end;

function TZPostgreSQL72PlainDriver.PutBytes(Handle: PZPostgreSQLConnect;
  Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.PQputnbytes(Handle, Buffer, Length);
end;

function TZPostgreSQL72PlainDriver.PutLine(Handle: PZPostgreSQLConnect;
  Buffer: PChar): Integer;
begin
  Result := ZPlainPostgreSql72.PQputline(Handle, Buffer);
end;

function TZPostgreSQL72PlainDriver.ReadLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer; Buffer: PChar;
  Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.lo_read(Handle, Fd, Buffer, Length);
end;

function TZPostgreSQL72PlainDriver.RequestCancel(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql72.PQrequestCancel(Handle);
end;

procedure TZPostgreSQL72PlainDriver.Reset(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql72.PQreset(Handle);
end;

function TZPostgreSQL72PlainDriver.SeekLargeObject(
  Handle: PZPostgreSQLConnect; Fd, Offset, Whence: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.lo_lseek(Handle, Fd, Offset, Whence);
end;

function TZPostgreSQL72PlainDriver.SendQuery(Handle: PZPostgreSQLConnect;
  Query: PChar): Integer;
begin
  Result := ZPlainPostgreSql72.PQsendQuery(Handle, Query);
end;

function TZPostgreSQL72PlainDriver.SetDatabaseLogin(Host, Port, Options,
  TTY, Db, User, Passwd: PChar): PZPostgreSQLConnect;
begin
  Result := ZPlainPostgreSql72.PQsetdbLogin(Host, Port, Options, TTY, Db,
    User, Passwd);
end;

procedure TZPostgreSQL72PlainDriver.SetNoticeProcessor(
  Handle: PZPostgreSQLConnect; Proc: TZPostgreSQLNoticeProcessor;
  Arg: Pointer);
begin
  ZPlainPostgreSql72.PQsetNoticeProcessor(Handle, Proc, Arg);
end;

function TZPostgreSQL72PlainDriver.TellLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.lo_tell(Handle, Fd);
end;

procedure TZPostgreSQL72PlainDriver.Trace(Handle: PZPostgreSQLConnect;
  DebugPort: Pointer);
begin
  ZPlainPostgreSql72.PQtrace(Handle, DebugPort);
end;

function TZPostgreSQL72PlainDriver.UnlinkLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid): Integer;
begin
  Result := ZPlainPostgreSql72.lo_unlink(Handle, ObjId);
end;

procedure TZPostgreSQL72PlainDriver.Untrace(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql72.PQuntrace(Handle);
end;

function TZPostgreSQL72PlainDriver.WriteLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer; Buffer: PChar;
  Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql72.lo_write(Handle, Fd, Buffer, Length);
end;

{ TZPostgreSQL73PlainDriver }

constructor TZPostgreSQL73PlainDriver.Create;
begin
end;

function TZPostgreSQL73PlainDriver.GetProtocol: string;
begin
  Result := 'postgresql-7.3';
end;

function TZPostgreSQL73PlainDriver.GetDescription: string;
begin
  Result := 'Native Plain Driver for PostgreSQL 7.3+';
end;

procedure TZPostgreSQL73PlainDriver.Initialize;
begin
  ZPlainPostgreSql73.LibraryLoader.LoadIfNeeded;
end;

procedure TZPostgreSQL73PlainDriver.Clear(Res: PZPostgreSQLResult);
begin
  ZPlainPostgreSql73.PQclear(Res);
end;

function TZPostgreSQL73PlainDriver.CloseLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.lo_close(Handle, Fd);
end;

function TZPostgreSQL73PlainDriver.ConnectDatabase(
  ConnInfo: PChar): PZPostgreSQLConnect;
begin
  Result := ZPlainPostgreSql73.PQconnectdb(ConnInfo);
end;

function TZPostgreSQL73PlainDriver.ConsumeInput(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql73.PQconsumeInput(Handle);
end;

function TZPostgreSQL73PlainDriver.CreateLargeObject(
  Handle: PZPostgreSQLConnect; Mode: Integer): Oid;
begin
  Result := ZPlainPostgreSql73.lo_creat(Handle, Mode);
end;

function TZPostgreSQL73PlainDriver.EndCopy(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql73.PQendcopy(Handle);
end;

function TZPostgreSQL73PlainDriver.ExecuteFunction(
  Handle: PZPostgreSQLConnect; fnid: Integer; result_buf,
  result_len: PInteger; result_is_int: Integer; args: PZPostgreSQLArgBlock;
  nargs: Integer): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql73.PQfn(Handle, fnid, result_buf,
    result_len, result_is_int, ZPlainPostgreSql73.PPQArgBlock(args), nargs);
end;

function TZPostgreSQL73PlainDriver.ExecuteQuery(
  Handle: PZPostgreSQLConnect; Query: PChar): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql73.PQexec(Handle, Query);
end;

function TZPostgreSQL73PlainDriver.ExportLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid; FileName: PChar): Integer;
begin
  Result := ZPlainPostgreSql73.lo_export(Handle, ObjId, FileName);
end;

procedure TZPostgreSQL73PlainDriver.Finish(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql73.PQfinish(Handle);
end;

procedure TZPostgreSQL73PlainDriver.FreeNotify(Handle: PZPostgreSQLNotify);
begin
  ZPlainPostgreSql73.PQfreeNotify(ZPlainPostgreSql73.PPGnotify(Handle));
end;

function TZPostgreSQL73PlainDriver.GetBackendPID(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql73.PQbackendPID(Handle);
end;

function TZPostgreSQL73PlainDriver.GetBinaryTuples(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql73.PQbinaryTuples(Res);
end;

function TZPostgreSQL73PlainDriver.GetCommandStatus(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql73.PQcmdStatus(Res);
end;

function TZPostgreSQL73PlainDriver.GetCommandTuples(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql73.PQcmdTuples(Res);
end;

function TZPostgreSQL73PlainDriver.GetConnectDefaults:
  PZPostgreSQLConnectInfoOption;
begin
  Result := PZPostgreSQLConnectInfoOption(ZPlainPostgreSql73.PQconndefaults);
end;

function TZPostgreSQL73PlainDriver.GetDatabase(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQdb(Handle);
end;

function TZPostgreSQL73PlainDriver.GetErrorMessage(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQerrorMessage(Handle);
end;

function TZPostgreSQL73PlainDriver.GetFieldCount(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql73.PQnfields(Res);
end;

function TZPostgreSQL73PlainDriver.GetFieldMode(Res: PZPostgreSQLResult;
  FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQfmod(Res, FieldNum);
end;

function TZPostgreSQL73PlainDriver.GetFieldName(Res: PZPostgreSQLResult;
  FieldNum: Integer): PChar;
begin
  Result := ZPlainPostgreSql73.PQfname(Res, FieldNum);
end;

function TZPostgreSQL73PlainDriver.GetFieldNumber(
  Res: PZPostgreSQLResult; FieldName: PChar): Integer;
begin
  Result := ZPlainPostgreSql73.PQfnumber(Res, FieldName);
end;

function TZPostgreSQL73PlainDriver.GetFieldSize(Res: PZPostgreSQLResult;
  FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQfsize(Res, FieldNum);
end;

function TZPostgreSQL73PlainDriver.GetFieldType(Res: PZPostgreSQLResult;
  FieldNum: Integer): Oid;
begin
  Result := ZPlainPostgreSql73.PQftype(Res, FieldNum);
end;

function TZPostgreSQL73PlainDriver.GetHost(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQhost(Handle);
end;

function TZPostgreSQL73PlainDriver.GetIsNull(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQgetisnull(Res, TupNum, FieldNum);
end;

function TZPostgreSQL73PlainDriver.GetLength(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQgetlength(Res, TupNum, FieldNum);
end;

function TZPostgreSQL73PlainDriver.GetLine(Handle: PZPostgreSQLConnect;
  Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQgetline(Handle, Buffer, Length);
end;

function TZPostgreSQL73PlainDriver.GetLineAsync(
  Handle: PZPostgreSQLConnect; Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQgetlineAsync(Handle, Buffer, Length);
end;

function TZPostgreSQL73PlainDriver.GetOidStatus(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql73.PQoidStatus(Res);
end;

function TZPostgreSQL73PlainDriver.GetOidValue(
  Res: PZPostgreSQLResult): Oid;
begin
  Result := ZPlainPostgreSql73.PQoidValue(Res);
end;

function TZPostgreSQL73PlainDriver.GetOptions(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQoptions(Handle);
end;

function TZPostgreSQL73PlainDriver.GetPassword(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQpass(Handle);
end;

function TZPostgreSQL73PlainDriver.GetPort(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQport(Handle);
end;

function TZPostgreSQL73PlainDriver.GetResult(
  Handle: PZPostgreSQLConnect): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql73.PQgetResult(Handle);
end;

function TZPostgreSQL73PlainDriver.GetResultErrorMessage(
  Res: PZPostgreSQLResult): PChar;
begin
  Result := ZPlainPostgreSql73.PQresultErrorMessage(Res);
end;

function TZPostgreSQL73PlainDriver.GetResultStatus(
  Res: PZPostgreSQLResult): TZPostgreSQLExecStatusType;
begin
  Result := TZPostgreSQLExecStatusType(ZPlainPostgreSql73.PQresultStatus(Res));
end;

function TZPostgreSQL73PlainDriver.GetRowCount(
  Res: PZPostgreSQLResult): Integer;
begin
  Result := ZPlainPostgreSql73.PQntuples(Res);
end;

function TZPostgreSQL73PlainDriver.GetSocket(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql73.PQsocket(Handle);
end;

function TZPostgreSQL73PlainDriver.GetStatus(
  Handle: PZPostgreSQLConnect): TZPostgreSQLConnectStatusType;
begin
  Result := TZPostgreSQLConnectStatusType(ZPlainPostgreSql73.PQstatus(Handle));
end;

function TZPostgreSQL73PlainDriver.GetTTY(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQtty(Handle);
end;

function TZPostgreSQL73PlainDriver.GetUser(
  Handle: PZPostgreSQLConnect): PChar;
begin
  Result := ZPlainPostgreSql73.PQuser(Handle);
end;

function TZPostgreSQL73PlainDriver.GetValue(Res: PZPostgreSQLResult;
  TupNum, FieldNum: Integer): PChar;
begin
  Result := ZPlainPostgreSql73.PQgetvalue(Res, TupNum, FieldNum);
end;

function TZPostgreSQL73PlainDriver.ImportLargeObject(
  Handle: PZPostgreSQLConnect; FileName: PChar): Oid;
begin
  Result := ZPlainPostgreSql73.lo_import(Handle, FileName);
end;

function TZPostgreSQL73PlainDriver.IsBusy(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql73.PQisBusy(Handle);
end;

function TZPostgreSQL73PlainDriver.MakeEmptyResult(
  Handle: PZPostgreSQLConnect;
  Status: TZPostgreSQLExecStatusType): PZPostgreSQLResult;
begin
  Result := ZPlainPostgreSql73.PQmakeEmptyPGresult(Handle,
    ZPlainPostgreSql73.ExecStatusType(Status));
end;

function TZPostgreSQL73PlainDriver.Notifies(
  Handle: PZPostgreSQLConnect): PZPostgreSQLNotify;
begin
  Result := PZPostgreSQLNotify(ZPlainPostgreSql73.PQnotifies(Handle));
end;

function TZPostgreSQL73PlainDriver.OpenLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid; Mode: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.lo_open(Handle, ObjId, Mode);
end;

function TZPostgreSQL73PlainDriver.PutBytes(Handle: PZPostgreSQLConnect;
  Buffer: PChar; Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.PQputnbytes(Handle, Buffer, Length);
end;

function TZPostgreSQL73PlainDriver.PutLine(Handle: PZPostgreSQLConnect;
  Buffer: PChar): Integer;
begin
  Result := ZPlainPostgreSql73.PQputline(Handle, Buffer);
end;

function TZPostgreSQL73PlainDriver.ReadLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer; Buffer: PChar;
  Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.lo_read(Handle, Fd, Buffer, Length);
end;

function TZPostgreSQL73PlainDriver.RequestCancel(
  Handle: PZPostgreSQLConnect): Integer;
begin
  Result := ZPlainPostgreSql73.PQrequestCancel(Handle);
end;

procedure TZPostgreSQL73PlainDriver.Reset(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql73.PQreset(Handle);
end;

function TZPostgreSQL73PlainDriver.SeekLargeObject(
  Handle: PZPostgreSQLConnect; Fd, Offset, Whence: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.lo_lseek(Handle, Fd, Offset, Whence);
end;

function TZPostgreSQL73PlainDriver.SendQuery(Handle: PZPostgreSQLConnect;
  Query: PChar): Integer;
begin
  Result := ZPlainPostgreSql73.PQsendQuery(Handle, Query);
end;

function TZPostgreSQL73PlainDriver.SetDatabaseLogin(Host, Port, Options,
  TTY, Db, User, Passwd: PChar): PZPostgreSQLConnect;
begin
  Result := ZPlainPostgreSql73.PQsetdbLogin(Host, Port, Options, TTY, Db,
    User, Passwd);
end;

procedure TZPostgreSQL73PlainDriver.SetNoticeProcessor(
  Handle: PZPostgreSQLConnect; Proc: TZPostgreSQLNoticeProcessor;
  Arg: Pointer);
begin
  ZPlainPostgreSql73.PQsetNoticeProcessor(Handle, Proc, Arg);
end;

function TZPostgreSQL73PlainDriver.TellLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.lo_tell(Handle, Fd);
end;

procedure TZPostgreSQL73PlainDriver.Trace(Handle: PZPostgreSQLConnect;
  DebugPort: Pointer);
begin
  ZPlainPostgreSql73.PQtrace(Handle, DebugPort);
end;

function TZPostgreSQL73PlainDriver.UnlinkLargeObject(
  Handle: PZPostgreSQLConnect; ObjId: Oid): Integer;
begin
  Result := ZPlainPostgreSql73.lo_unlink(Handle, ObjId);
end;

procedure TZPostgreSQL73PlainDriver.Untrace(Handle: PZPostgreSQLConnect);
begin
  ZPlainPostgreSql73.PQuntrace(Handle);
end;

function TZPostgreSQL73PlainDriver.WriteLargeObject(
  Handle: PZPostgreSQLConnect; Fd: Integer; Buffer: PChar;
  Length: Integer): Integer;
begin
  Result := ZPlainPostgreSql73.lo_write(Handle, Fd, Buffer, Length);
end;


end.

