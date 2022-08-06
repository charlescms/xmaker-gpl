unit CabSTComps;

(*
 *  Copyright (c) Ravil Batyrshin, 2001-2002
 *  All Rights Reserved
 *  Version 1.20
 *  Aravil Software
 *  web site: aravilsoft.tripod.com
 *  e-mail: aravilsoft@bigfoot.com, wizeman@mail.ru
 *)

{$IFNDEF VER130}
	{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}
{$RANGECHECKS OFF}
{$BOOLEVAL OFF}

interface

uses
	Windows, ShellApi, SysUtils, Classes, CabIntf
	{$IFDEF VER130}, FileCtrl {$ENDIF};

type
	TSTCabCompressionType = (
		cctNone,
		cctMsZip,
		cctLzx
	);

	TSTCabLzxLevel = 15..21;

const
	DefCabCompressionType = cctLzx;
	DefCabLzxLevel = 21;

type
	TSTCabWriter = class;
	TSTCabReader = class;

	TSTCabAddFileOption = (
		cafoExecuteOnExtract
	);

	TSTCabAddFileOptions = set of TSTCabAddFileOption;

	TSTCabAddFilesOption = (
		cafsoRecurseSubdirs
	);

	TSTCabAddFilesOptions = set of TSTCabAddFilesOption;

	TSTCabExtractFilesOption = (
		cefsoProcessOnlyOneVolume
	);

	TSTCabExtractFilesOptions = set of TSTCabExtractFilesOption;

	ESTCabinet = class(Exception)
	private
		FCabError: Integer; // FCI/FDI error code
		FWinError: DWORD; // Optional Win32 error code
		FErrorPresent: Boolean;
		FIsCompressing: Boolean;
	public
		constructor Create(const anERF: TERF; anIsCompressing: Boolean);

		property CabError: Integer read FCabError;
		property WinError: DWORD read FWinError;
		property ErrorPresent: Boolean read FErrorPresent;
		property IsCompressing: Boolean read FIsCompressing;
	end;

	TSTCabWriterFilePlacedEvent = procedure(Sender: TSTCabWriter;
		const aCCab: TCCAB; const aFileName: String; aFileSize: Longint;
		aContinuation: Boolean; var anAbort: Boolean) of object;
	TSTCabWriterGetNextCabinetEvent = procedure(Sender: TSTCabWriter;
		var aCCab: TCCAB; aPrevCabSize: ULONG; var anAbort: Boolean) of object;
	TSTCabWriterFileStatusEvent = procedure(Sender: TSTCabWriter;
		aCompressedBlockSize, anUncompressedBlockSize: ULONG; var anAbort: Boolean) of object;
	TSTCabWriterFolderStatusEvent = procedure(Sender: TSTCabWriter;
		aCopiedSize, aTotalSize: ULONG; var anAbort: Boolean) of object;
	TSTCabWriterCabinetStatusEvent = procedure(Sender: TSTCabWriter;
		aPrevEstimatedSize, anActualSize: ULONG; var aDesiredSize: ULONG;
		var anAbort: Boolean) of object;
	TSTCabWriterProgressEvent = procedure(Sender: TSTCabWriter;
		var anAbort: Boolean) of object;
	TSTCabWriterBeforeFileAddEvent = procedure(Sender: TSTCabWriter;
		const aFileName: String; var aSkip: Boolean) of object;

	TSTCabWriter = class(TComponent)
	private
		FHandle: HFCI;
		FFileName: String;
		FCabinetSizeThreshold: ULONG;
		FCabinetFileCountThreshold: ULONG;
		FFolderSizeThreshold: ULONG;
		FFolderFileCountThreshold: ULONG;
		FReservePerCabinetSize: UINT;
		FReservePerFolderSize: UINT;
		FReservePerDataSize: UINT;
		FSetID: USHORT;
		FCabinetNameTemplate: String;
		FCabinetPathTemplate: String;
		FDiskLabelTemplate: String;
		FCompressionType: TSTCabCompressionType;
		FCompressionLzxLevel: TSTCabLzxLevel;

		FOnFilePlaced: TSTCabWriterFilePlacedEvent;
		FOnGetNextCabinet: TSTCabWriterGetNextCabinetEvent;
		FOnFileStatus: TSTCabWriterFileStatusEvent;
		FOnFolderStatus: TSTCabWriterFolderStatusEvent;
		FOnCabinetStatus: TSTCabWriterCabinetStatusEvent;
		FOnProgress: TSTCabWriterProgressEvent;
		FOnBeforeFileAdd: TSTCabWriterBeforeFileAddEvent;

		procedure SetCompressionType(aValue: TSTCabCompressionType);
		procedure SetCompressionLzxLevel(aValue: TSTCabLzxLevel);
	protected
		FCabComp: TCOMP;
		FERF: TERF;
		FOriginalCCAB: TCCAB;
		FFileCountPerCabinet: ULONG;
		FFileCountPerFolder: ULONG;
		FProgressCount: Integer;

		procedure CabCheck(aResult: Boolean);
		function GetCabinetName(aCabNo: Integer): String;
		function GetCabinetPath(aDiskNo: Integer): String;
		function GetDiskLabel(aDiskNo: Integer): String;
		procedure SyncCabComp;
		procedure FlushCabinet(aGetNextCab: Boolean);
		// Callbacks
		function DoFilePlaced(pccab: PCCAB; pszFile: PAnsiChar;
			cbFile: Longint; fContinuation: WIN_BOOL): Boolean;
		function DoGetNextCabinet(pccab: PCCAB; cbPrevCab: ULONG): Boolean;
		function DoStatus(typeStatus: UINT; cb1: ULONG; cb2: ULONG): Longint;
	public
		constructor Create(aOwner: TComponent); override;
		destructor Destroy; override;

		procedure Open(const aFileName: String);
		procedure Close(aFlushCab: Boolean = True);
		procedure AddFile(const aSrcFileName, aDstFileName: String;
			anOptions: TSTCabAddFileOptions = []);
		procedure AddFiles(const aSrcPath, aDstPath: String;
			anOptions: TSTCabAddFilesOptions = []);
		procedure StartNewCabinet;
		procedure StartNewFolder;

		property Handle: HFCI read FHandle;
		property FileName: String read FFileName;
	published
		property CabinetSizeThreshold: ULONG read FCabinetSizeThreshold write FCabinetSizeThreshold default 0;
		property CabinetFileCountThreshold: ULONG read FCabinetFileCountThreshold write FCabinetFileCountThreshold default 0;
		property FolderSizeThreshold: ULONG read FFolderSizeThreshold write FFolderSizeThreshold default 0;
		property FolderFileCountThreshold: ULONG read FFolderFileCountThreshold write FFolderFileCountThreshold default 0;
		property ReservePerCabinetSize: UINT read FReservePerCabinetSize write FReservePerCabinetSize default 0;
		property ReservePerFolderSize: UINT read FReservePerFolderSize write FReservePerFolderSize default 0;
		property ReservePerDataSize: UINT read FReservePerDataSize write FReservePerDataSize default 0;
		property SetID: USHORT read FSetID write FSetID default 0;
		property CabinetNameTemplate: String read FCabinetNameTemplate write FCabinetNameTemplate;
		property CabinetPathTemplate: String read FCabinetPathTemplate write FCabinetPathTemplate;
		property DiskLabelTemplate: String read FDiskLabelTemplate write FDiskLabelTemplate;
		property CompressionType: TSTCabCompressionType read FCompressionType write SetCompressionType default DefCabCompressionType;
		property CompressionLzxLevel: TSTCabLzxLevel read FCompressionLzxLevel write SetCompressionLzxLevel default DefCabLzxLevel;

		property OnFilePlaced: TSTCabWriterFilePlacedEvent read FOnFilePlaced write FOnFilePlaced;
		property OnGetNextCabinet: TSTCabWriterGetNextCabinetEvent read FOnGetNextCabinet write FOnGetNextCabinet;
		property OnFileStatus: TSTCabWriterFileStatusEvent read FOnFileStatus write FOnFileStatus;
		property OnFolderStatus: TSTCabWriterFolderStatusEvent read FOnFolderStatus write FOnFolderStatus;
		property OnCabinetStatus: TSTCabWriterCabinetStatusEvent read FOnCabinetStatus write FOnCabinetStatus;
		property OnProgress: TSTCabWriterProgressEvent read FOnProgress write FOnProgress;
		property OnBeforeFileAdd: TSTCabWriterBeforeFileAddEvent read FOnBeforeFileAdd write FOnBeforeFileAdd;
	end;

	TSTCabReaderOption = (
		croExecuteOnExtract,
		croDontOverwriteReadOnlyFiles
	);

	TSTCabReaderOptions = set of TSTCabReaderOption;

	TSTCabReaderCabinetInfoEvent = procedure(Sender: TSTCabReader;
		const aNextCabName, aNextDiskName, aCabPath: String;
		aSetID, aCabNo: USHORT; var anAbort: Boolean) of object;
	TSTCabReaderCopyFileEvent = procedure(Sender: TSTCabReader;
		const aSrcFileName: String; anUncompressedSize: Longint;
		aDate, aTime, anAttrs, aFolderNo: USHORT; var aDstFullFileName: String;
		var anAbort: Boolean) of object;
	TSTCabReaderCopyPartialFileEvent = procedure(Sender: TSTCabReader;
		const aSrcFileName, aStartCabName, aStartDiskName, aDstFullFileName: String;
		var anAbort: Boolean) of object;
	TSTCabReaderCloseFileEvent = procedure(Sender: TSTCabReader;
		const aSrcFileName: String; aDate, aTime, anAttrs, aFolderNo: USHORT;
		var anExec: Boolean; const aDstFullFileName: String; var anAbort: Boolean) of object;
	TSTCabReaderNextCabinetEvent = procedure(Sender: TSTCabReader;
		const aCabName, aDiskName: String; var aCabPath: String;
		anError: TFDIERROR; var anAbort: Boolean) of object;
	TSTCabReaderUnrecognizedNotifyEvent = procedure(Sender: TSTCabReader;
		aNotifyType: TFDINOTIFICATIONTYPE; var aNotify: TFDINOTIFICATION;
		var aResult: Integer) of object;

	TSTCabReaderEnumFilesEntriesEvent = procedure(Sender: TSTCabReader;
		const aFileName: String; anUncompressedSize: UINT4; aFlags: UINT2;
		aDate, aTime, anAttrs: UINT2; var anAbort: Boolean) of object;

	TSTCabReader = class(TComponent)
	private
		FHandle: HFDI;
		FFileName: String;
		FDstPath: String;
		FOptions: TSTCabReaderOptions;

		FOnCabinetInfo: TSTCabReaderCabinetInfoEvent;
		FOnCopyFile: TSTCabReaderCopyFileEvent;
		FOnCopyPartialFile: TSTCabReaderCopyPartialFileEvent;
		FOnCloseFile: TSTCabReaderCloseFileEvent;
		FOnNextCabinet: TSTCabReaderNextCabinetEvent;
		FOnUnrecognizedNotify: TSTCabReaderUnrecognizedNotifyEvent;

		function GetHandle: HFDI;
	protected
		FNextFileName: String;
		FNextDiskName: String;
		FCurrentFileName: String;
		FCurrentFileName2: String;
		FIsOnPartialFile: Boolean;
		FERF: TERF;
		FSrcFileNames: TStringList;
		FDstFileNames: TStringList;

		procedure CabCheck(aResult: Boolean);
		procedure HandleNeeded;
		procedure DestroyHandle;
		// Callbacks
		function DoNotify(fdint: TFDINOTIFICATIONTYPE; pfdin: PFDINOTIFICATION): Integer;
	public
		constructor Create(aOwner: TComponent); override;
		destructor Destroy; override;

		function IsCabinet(const aFileName: String; var aCabInfo: TFDICABINETINFO): Boolean;
		procedure ExtractFiles(const aFileName, aDstPath: String;
			anOptions: TSTCabExtractFilesOptions = []);
		function EnumFilesEntries(const aFileName: String;
			aCallback: TSTCabReaderEnumFilesEntriesEvent): Boolean;

		property Handle: HFDI read GetHandle;
		property FileName: String read FFileName;
		property DstPath: String read FDstPath;
		property NextFileName: String read FNextFileName;
		property NextDiskName: String read FNextDiskName;
		property CurrentFileName: String read FCurrentFileName;
		property IsOnPartialFile: Boolean read FIsOnPartialFile;
	published
		property Options: TSTCabReaderOptions read FOptions write FOptions default [];

		property OnCabinetInfo: TSTCabReaderCabinetInfoEvent read FOnCabinetInfo write FOnCabinetInfo;
		property OnCopyFile: TSTCabReaderCopyFileEvent read FOnCopyFile write FOnCopyFile;
		property OnCopyPartialFile: TSTCabReaderCopyPartialFileEvent read FOnCopyPartialFile write FOnCopyPartialFile;
		property OnCloseFile: TSTCabReaderCloseFileEvent read FOnCloseFile write FOnCloseFile;
		property OnNextCabinet: TSTCabReaderNextCabinetEvent read FOnNextCabinet write FOnNextCabinet;
		property OnUnrecognizedNotify: TSTCabReaderUnrecognizedNotifyEvent read FOnUnrecognizedNotify write FOnUnrecognizedNotify;
	end;

implementation

uses
	CabSTConsts;

{ From fcntl.h }
const
	_O_RDONLY =      $0000; //open for reading only
	_O_WRONLY =      $0001; //open for writing only
	_O_RDWR =        $0002; //open for reading and writing
	_O_APPEND =      $0008; //writes done at eof

	_O_CREAT =       $0100; //create and open file
	_O_TRUNC =       $0200; //open and truncate
	_O_EXCL =        $0400; //open only if file doesn't already exist

	_O_TEXT =        $4000; //file mode is text (translated)
	_O_BINARY =      $8000; //file mode is binary (untranslated)

	_O_RAW =         _O_BINARY;
	_O_NOINHERIT =   $0080; //child process doesn't inherit file
	_O_TEMPORARY =   $0040; //temporary file bit
	_O_SHORT_LIVED = $1000; //temporary storage file, try not to flush

	_O_SEQUENTIAL =  $0020; //file access is primarily sequential
	_O_RANDOM =      $0010; //file access is primarily random

{ From sys\stat.h }
const
	_S_IREAD =       $0100; // read permission, owner
	_S_IWRITE =      $0080; // write permission, owner


var
	LastFdiError: Integer = 0;

{$IFDEF VER130}

function IncludeTrailingPathDelimiter(const s: String): String;
var
	aLen: Integer;
begin
	Result := s;
	aLen := Length(Result);
	if (aLen > 0) and (Result[aLen] <> '\') then
		Result := Result + '\';
end;

procedure RaiseLastOSError;
begin
	RaiseLastWin32Error;
end;

{$ENDIF}

function MakePath(const aParts: array of String): String;
var
	i, len: Integer;
begin
	Result := '';
	for i := Low(aParts) to High(aParts) do begin
		if Length(aParts[i]) = 0 then
			continue;
		len := Length(Result);
		if len = 0 then begin
			Result := aParts[i];
			continue;
		end;
		if Result[len] = '\' then begin
			if aParts[i][1] = '\' then
				SetLength(Result, len - 1);
			Result := Result + aParts[i];
		end
		else begin
			if aParts[i][1] <> '\' then
				Result := Result + '\';
			Result := Result + aParts[i];
		end;
	end;
end;

function ExcludeLeadingPathDelimiter(const s: String): String;
begin
	Result := s;
	if (Length(Result) > 0) and (Result[1] = '\') then
		Delete(Result, 1, 1);
end;

function OFlagToFileDesiredAccess(oflag: Integer): DWORD;
begin
	case (oflag and 3) of
		_O_RDONLY: Result := GENERIC_READ;
		_O_WRONLY: Result := GENERIC_WRITE;
		else Result := GENERIC_READ or GENERIC_WRITE;
	end;
end;

function OFlagToFileShareMode(oflag: Integer): DWORD;
begin
	Result := FILE_SHARE_READ;
end;

function OFlagToFileCreationDisposition(oflag: Integer): DWORD;
begin
	if ((oflag and _O_EXCL) <> 0) and ((oflag and _O_CREAT) <> 0) then
		Result := CREATE_NEW
	else if (oflag and _O_TRUNC) <> 0 then
		if (oflag and _O_CREAT) <> 0 then
			Result := CREATE_ALWAYS
		else
			Result := TRUNCATE_EXISTING
	else if (oflag and _O_CREAT) <> 0 then
		Result := OPEN_ALWAYS
	else
		Result := OPEN_EXISTING;
end;

function OFlagToFileFlagsAndAttributes(oflag: Integer): DWORD;
begin
	if ((oflag and _O_SHORT_LIVED) <> 0) and ((oflag and _O_CREAT) <> 0) then
		Result := FILE_ATTRIBUTE_TEMPORARY
	else
		Result := FILE_ATTRIBUTE_NORMAL;

	if (oflag and _O_RANDOM) <> 0 then
		Result := Result or FILE_FLAG_RANDOM_ACCESS;
	if (oflag and _O_SEQUENTIAL) <> 0 then
		Result := Result or FILE_FLAG_SEQUENTIAL_SCAN;
	if ((oflag and _O_TEMPORARY) <> 0) and ((oflag and _O_CREAT) <> 0) then
		Result := Result or FILE_FLAG_DELETE_ON_CLOSE;
end;

function StdFileOpen(pszFile: PAnsiChar; oflag: Integer; pmode: Integer;
	err: PInteger): Integer;
var
	aHandle: THandle;
begin
	aHandle := CreateFile(pszFile, OFlagToFileDesiredAccess(oflag),
		OFlagToFileShareMode(oflag), nil, OFlagToFileCreationDisposition(oflag),
		OFlagToFileFlagsAndAttributes(oflag), 0);
	if aHandle = INVALID_HANDLE_VALUE then begin
		err^ := Integer(GetLastError);
		Result := -1;
	end
	else if ((oflag and _O_APPEND) <> 0) and
			(SetFilePointer(aHandle, 0, nil, FILE_END) = $FFFFFFFF) then begin
		err^ := Integer(GetLastError);
		Result := -1;
		CloseHandle(aHandle);
	end
	else
		Result := Integer(aHandle);
end;

function StdFileRead(hf: Integer; memory: PVoid; cb: UINT;
	err: PInteger): UINT;
begin
	if not ReadFile(THandle(hf), memory^, cb, Result, nil) then begin
		err^ := Integer(GetLastError);
		Result := UINT(-1);
	end;
end;

function StdFileWrite(hf: Integer; memory: PVoid; cb: UINT;
	err: PInteger): UINT;
begin
	if not WriteFile(THandle(hf), memory^, cb, Result, nil) then begin
		err^ := Integer(GetLastError);
		Result := UINT(-1);
	end;
end;

function StdFileClose(hf: Integer; err: PInteger): Integer;
begin
	if CloseHandle(THandle(hf)) then
		Result := 0
	else begin
		err^ := Integer(GetLastError);
		Result := -1;
	end;
end;

function StdFileSeek(hf: Integer; dist: Longint; seektype: Integer;
	err: PInteger): Longint;
var
	aPos: DWORD;
begin
	aPos := SetFilePointer(THandle(hf), dist, nil, DWORD(seektype));
	if aPos = $FFFFFFFF then begin
		err^ := Integer(GetLastError);
		Result := -1;
	end
	else
		Result := Longint(aPos);
end;

function StdFileDelete(pszFile: PAnsiChar; err: PInteger): Integer;
begin
	if Windows.DeleteFile(pszFile) then
		Result := 0
	else begin
		err^ := Integer(GetLastError);
		Result := -1;
	end;
end;

function StdFileGetOpenInfo(pszName: PAnsiChar; pdate: PUSHORT;
	ptime: PUSHORT; pattribs: PUSHORT; err: PInteger): Integer;
var
	aHandle: THandle;
	aFileInfo: BY_HANDLE_FILE_INFORMATION;
	aFileTime: TFileTime;
begin
	aHandle := CreateFile(pszName, GENERIC_READ, FILE_SHARE_READ, nil,
		OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);
	if aHandle = INVALID_HANDLE_VALUE then begin
		err^ := Integer(GetLastError);
		Result := -1;
	end
	else if not GetFileInformationByHandle(aHandle, aFileInfo) then begin
		err^ := Integer(GetLastError);
		Result := -1;
		CloseHandle(aHandle);
	end
	else begin
		FileTimeToLocalFileTime(aFileInfo.ftLastWriteTime, aFileTime);
		FileTimeToDosDateTime(aFileTime, pdate^, ptime^);
		pattribs^ := USHORT(aFileInfo.dwFileAttributes and
			(FILE_ATTRIBUTE_READONLY or FILE_ATTRIBUTE_HIDDEN or
			FILE_ATTRIBUTE_SYSTEM or FILE_ATTRIBUTE_ARCHIVE));
		CloseHandle(aHandle);
		Result := StdFileOpen(pszName, _O_RDONLY or _O_BINARY, 0, err);
	end;
end;

function StdFileSetInfo(pszName: PAnsiChar; aDate, aTime, anAttrs: USHORT;
	err: PInteger): WIN_BOOL;
var
	aHandle: THandle;
	aLocalFileTime, aFileTime: TFileTime;
begin
	aHandle := CreateFile(pszName, GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ,
		nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);
	if aHandle = INVALID_HANDLE_VALUE then begin
		err^ := Integer(GetLastError);
		Result := WIN_FALSE;
	end
	else begin
		if DosDateTimeToFileTime(aDate, aTime, aLocalFileTime) and
				LocalFileTimeToFileTime(aLocalFileTime, aFileTime) then
			SetFileTime(aHandle, @aFileTime, nil, @aFileTime);
		CloseHandle(aHandle);
		SetFileAttributes(pszName, anAttrs and
			(FILE_ATTRIBUTE_READONLY or FILE_ATTRIBUTE_HIDDEN or
			FILE_ATTRIBUTE_SYSTEM or FILE_ATTRIBUTE_ARCHIVE));
		Result := WIN_TRUE;
	end;
end;

function StdGetTempFile(pszTempName: PAnsiChar; cbTempName: Integer): WIN_BOOL;
var
	aResult: Boolean;
	aPath: array [0..MAX_PATH] of AnsiChar;
	aName: array [0..MAX_PATH] of AnsiChar;
begin
	aResult := (GetTempPath(MAX_PATH, aPath) <> 0) and
		(GetTempFileName(aPath, 'stc', 0, aName) <> 0) and
		(Integer(StrLen(aName)) < cbTempName);
	if aResult then begin
		StrCopy(pszTempName, aName);
		// Delete temp file, cause MS don't expect file existing
		Windows.DeleteFile(pszTempName);
	end;
	Result := BooleanToWinBool[aResult];
end;

{ FCI & FDI memory callbacks }

function FnAlloc(cb: ULONG): PVoid; cdecl;
begin
	GetMem(Result, cb);
end;

procedure FnFree(memory: PVoid); cdecl;
begin
	FreeMem(memory);
end;

{ FCI callbacks }

function FnFciOpen(pszFile: PAnsiChar; oflag: Integer; pmode: Integer;
	err: PInteger; pv: PVoid): Integer; cdecl;
begin
	Result := StdFileOpen(pszFile, oflag, pmode, err);
end;

function FnFciRead(hf: Integer; memory: PVoid; cb: UINT;
	err: PInteger; pv: PVoid): UINT; cdecl;
begin
	Result := StdFileRead(hf, memory, cb, err);
end;

function FnFciWrite(hf: Integer; memory: PVoid; cb: UINT;
	err: PInteger; pv: PVoid): UINT; cdecl;
begin
	Result := StdFileWrite(hf, memory, cb, err);
end;

function FnFciClose(hf: Integer; err: PInteger; pv: PVoid): Integer; cdecl;
begin
	Result := StdFileClose(hf, err);
end;

function FnFciSeek(hf: Integer; dist: Longint; seektype: Integer;
	err: PInteger; pv: PVoid): Longint; cdecl;
begin
	Result := StdFileSeek(hf, dist, seektype, err);
end;

function FnFciDelete(pszFile: PAnsiChar; err: PInteger; pv: PVoid): Integer; cdecl;
begin
	Result := StdFileDelete(pszFile, err);
end;

function FnFciGetOpenInfo(pszName: PAnsiChar; pdate: PUSHORT;
	ptime: PUSHORT; pattribs: PUSHORT; err: PInteger; pv: PVoid): Integer; cdecl;
begin
	Result := StdFileGetOpenInfo(pszName, pdate, ptime, pattribs, err);
end;

function FnFciGetTempFile(pszTempName: PAnsiChar; cbTempName: Integer;
	pv: PVoid): WIN_BOOL; cdecl;
begin
	Result := StdGetTempFile(pszTempName, cbTempName);
end;

function FnFciFilePlaced(pccab: PCCAB; pszFile: PAnsiChar;
	cbFile: Longint; fContinuation: WIN_BOOL; pv: PVoid): Integer; cdecl;
begin
	if TSTCabWriter(pv).DoFilePlaced(pccab, pszFile, cbFile, fContinuation) then
		Result := 0
	else
		Result := -1;
end;

function FnFciGetNextCabinet(pccab: PCCAB; cbPrevCab: ULONG; pv: PVoid): WIN_BOOL; cdecl;
begin
	Result := BooleanToWinBool[TSTCabWriter(pv).DoGetNextCabinet(pccab, cbPrevCab)];
end;

function FnFciStatus(typeStatus: UINT; cb1: ULONG; cb2: ULONG; pv: PVoid): Longint; cdecl;
begin
	Result := TSTCabWriter(pv).DoStatus(typeStatus, cb1, cb2);
end;

{ FDI callbacks }

function FnFdiOpen(pszFile: PAnsiChar; oflag: Integer; pmode: Integer): Integer; cdecl;
var
	err: Integer;
begin
	err := 0;
	Result := StdFileOpen(pszFile, oflag, pmode, @err);
	if err <> 0 then
		LastFdiError := err;
end;

function FnFdiRead(hf: Integer; pv: PVoid; cb: UINT): UINT; cdecl;
var
	err: Integer;
begin
	err := 0;
	Result := StdFileRead(hf, pv, cb, @err);
	if err <> 0 then
		LastFdiError := err;
end;

function FnFdiWrite(hf: Integer; pv: PVoid; cb: UINT): UINT; cdecl;
var
	err: Integer;
begin
	err := 0;
	Result := StdFileWrite(hf, pv, cb, @err);
	if err <> 0 then
		LastFdiError := err;
end;

function FnFdiClose(hf: Integer): Integer; cdecl;
var
	err: Integer;
begin
	err := 0;
	Result := StdFileClose(hf, @err);
	if err <> 0 then
		LastFdiError := err;
end;

function FnFdiSeek(hf: Integer; dist: Longint; seektype: Integer): Longint; cdecl;
var
	err: Integer;
begin
	err := 0;
	Result := StdFileSeek(hf, dist, seektype, @err);
	if err <> 0 then
		LastFdiError := err;
end;

function FnFdiNotify(fdint: TFDINOTIFICATIONTYPE; pfdin: PFDINOTIFICATION): Integer; cdecl;
begin
	Result := TSTCabReader(pfdin^.pv).DoNotify(fdint, pfdin);
end;

{ Error translation functions }

function GetFciErrorMessage(anErrCode: Integer): String;
begin
	case anErrCode of
		Integer(FCIERR_NONE): Result := SFciErrNone;
		Integer(FCIERR_OPEN_SRC): Result := SFciErrOpenSrc;
		Integer(FCIERR_READ_SRC): Result := SFciErrReadSrc;
		Integer(FCIERR_ALLOC_FAIL): Result := SFciErrAllocFail;
		Integer(FCIERR_TEMP_FILE): Result := SFciErrTempFile;
		Integer(FCIERR_BAD_COMPR_TYPE): Result := SFciErrBadComprType;
		Integer(FCIERR_CAB_FILE): Result := SFciErrCabFile;
		Integer(FCIERR_USER_ABORT): Result := SFciErrUserAbort;
		Integer(FCIERR_MCI_FAIL): Result := SFciErrMciFail;
		else Result := SFciErrUnknown;
	end;
end;

function GetFdiErrorMessage(anErrCode: Integer): String;
begin
	case anErrCode of
		Integer(FDIERROR_NONE): Result := SFdiErrNone;
		Integer(FDIERROR_CABINET_NOT_FOUND): Result := SFdiErrCabinetNotFound;
		Integer(FDIERROR_NOT_A_CABINET): Result := SFdiErrNotACabinet;
		Integer(FDIERROR_UNKNOWN_CABINET_VERSION): Result := SFdiErrUnknownCabinetVersion;
		Integer(FDIERROR_CORRUPT_CABINET): Result := SFdiErrCorruptCabinet;
		Integer(FDIERROR_ALLOC_FAIL): Result := SFdiErrAllocFail;
		Integer(FDIERROR_BAD_COMPR_TYPE): Result := SFdiErrBadComprType;
		Integer(FDIERROR_MDI_FAIL): Result := SFdiErrMdiFail;
		Integer(FDIERROR_TARGET_FILE): Result := SFdiErrTargetFile;
		Integer(FDIERROR_RESERVE_MISMATCH): Result := SFdiErrReserveMismatch;
		Integer(FDIERROR_WRONG_CABINET): Result := SFdiErrWrongCabinet;
		Integer(FDIERROR_USER_ABORT): Result := SFdiErrUserAbort;
		else Result := SFdiErrUnknown;
	end;
end;

{ ESTCabinet }

constructor ESTCabinet.Create(const anERF: TERF; anIsCompressing: Boolean);
var
	s: String;
begin
	FCabError := anERF.erfOper;
	FWinError := DWORD(anERF.erfType);
	FErrorPresent := anERF.fError <> WIN_FALSE;
	FIsCompressing := anIsCompressing;
	if IsCompressing then begin
		if ErrorPresent then
			s := GetFciErrorMessage(CabError) + ' [0x' + IntToHex(CabError, 4) + ']'
		else
			s := SFciErrUnknown;
	end
	else begin
		if ErrorPresent then
			s := GetFdiErrorMessage(CabError) + ' [0x' + IntToHex(CabError, 4) + ']'
		else
			s := SFdiErrUnknown;
	end;
	if ErrorPresent and (WinError <> 0) then
		s := s + '.'#13#10 + SysErrorMessage(Integer(WinError)) +
			' [0x' + IntToHex(Integer(WinError), 4) + '].';
	inherited Create(s);
end;

{ TSTCabWriter }

constructor TSTCabWriter.Create(aOwner: TComponent);
begin
	inherited Create(aOwner);
	FCompressionType := DefCabCompressionType;
	FCompressionLzxLevel := DefCabLzxLevel;
	SyncCabComp;
end;

destructor TSTCabWriter.Destroy;
begin
	Close(False);
	inherited Destroy;
end;

procedure TSTCabWriter.SetCompressionType(aValue: TSTCabCompressionType);
begin
	FCompressionType := aValue;
	SyncCabComp;
end;

procedure TSTCabWriter.SetCompressionLzxLevel(aValue: TSTCabLzxLevel);
begin
	FCompressionLzxLevel := aValue;
	SyncCabComp;
end;

procedure TSTCabWriter.CabCheck(aResult: Boolean);
begin
	if not aResult then
		raise ESTCabinet.Create(FERF, True);
end;

function TSTCabWriter.GetCabinetName(aCabNo: Integer): String;
var
	aPos: Integer;
begin
	Result := CabinetNameTemplate;
	if Result = '' then begin
		Result := ExtractFileName(FileName);
		aPos := LastDelimiter('.', Result);
		if aPos = 0 then
			Result := Result + '*'
		else
			Insert('*', Result, aPos);
	end;
	Result := StringReplace(Result, '*', IntToStr(aCabNo), [rfReplaceAll]);
end;

function TSTCabWriter.GetCabinetPath(aDiskNo: Integer): String;
begin
	Result := CabinetPathTemplate;
	if Result = '' then
		Result := ExtractFilePath(FileName);
	Result := StringReplace(Result, '*', IntToStr(aDiskNo), [rfReplaceAll]);
	Result := IncludeTrailingPathDelimiter(Result);
end;

function TSTCabWriter.GetDiskLabel(aDiskNo: Integer): String;
begin
	Result := DiskLabelTemplate;
	if Result = '' then
		Result := SDiskLabelTemplateDef;
	Result := StringReplace(Result, '*', IntToStr(aDiskNo), [rfReplaceAll]);
end;

procedure TSTCabWriter.SyncCabComp;
begin
	case CompressionType of
		cctNone: FCabComp := tcompTYPE_NONE;
		cctMsZip: FCabComp := tcompTYPE_MSZIP;
		cctLzx: FCabComp := TCOMPfromLZXWindow(CompressionLzxLevel);
		else FCabComp := tcompBAD;
	end;
end;

function TSTCabWriter.DoFilePlaced(pccab: PCCAB; pszFile: PAnsiChar;
	cbFile: Longint; fContinuation: WIN_BOOL): Boolean;
var
	anAbort: Boolean;
begin
	anAbort := False;
	if Assigned(OnFilePlaced) then
		OnFilePlaced(Self, pccab^, pszFile, cbFile, fContinuation <> WIN_FALSE, anAbort);
	Result := not anAbort;
end;

function TSTCabWriter.DoGetNextCabinet(pccab: PCCAB; cbPrevCab: ULONG): Boolean;
var
	anAbort: Boolean;
begin
	anAbort := False;
	Inc(pccab^.iDisk);
	StrPCopy(pccab^.szDisk, GetDiskLabel(pccab^.iDisk));
	StrPCopy(pccab^.szCab, GetCabinetName(pccab^.iCab));
	StrPCopy(pccab^.szCabPath, GetCabinetPath(pccab^.iDisk));
	if Assigned(OnGetNextCabinet) then
		OnGetNextCabinet(Self, pccab^, cbPrevCab, anAbort);
	if not anAbort then begin
		ForceDirectories(pccab^.szCabPath);
		Windows.DeleteFile(PChar(
			MakePath([String(pccab^.szCabPath), String(pccab^.szCab)])));
	end;

	FFileCountPerCabinet := 0;
	FFileCountPerFolder := 0;
	Result := not anAbort;
end;

function TSTCabWriter.DoStatus(typeStatus: UINT; cb1: ULONG; cb2: ULONG): Longint;
var
	anAbort: Boolean;
	aDesiredSize: ULONG;
begin
	anAbort := False;
	Result := 0;
	case typeStatus of
		statusFile: begin
			if Assigned(OnFileStatus) then
				OnFileStatus(Self, cb1, cb2, anAbort);
			if (FProgressCount < 0) and Assigned(OnProgress) and not anAbort then begin
				OnProgress(Self, anAbort);
				FProgressCount := 8;
			end;
			Dec(FProgressCount);
		end;
		statusFolder: begin
			if Assigned(OnFolderStatus) then
				OnFolderStatus(Self, cb1, cb2, anAbort);
			FFileCountPerFolder := 0;
		end;
		statusCabinet: begin
			aDesiredSize := 0;
			if Assigned(OnCabinetStatus) then
				OnCabinetStatus(Self, cb1, cb2, aDesiredSize, anAbort);
			Result := Longint(aDesiredSize);
			FFileCountPerCabinet := 0;
			FFileCountPerFolder := 0;
		end;
	end;
	if anAbort then
		Result := -1;
end;

procedure TSTCabWriter.Open(const aFileName: String);
var
	anAbort: Boolean;
begin
	Close(False);
	FFileName := ExpandFileName(aFileName);
	FillChar(FERF, SizeOf(FERF), 0);
	FillChar(FOriginalCCAB, SizeOf(FOriginalCCAB), 0);
	if CabinetSizeThreshold = 0 then
		FOriginalCCAB.cb := CB_MAX_DISK
	else
		FOriginalCCAB.cb := CabinetSizeThreshold;
	if FolderSizeThreshold = 0 then
		FOriginalCCAB.cbFolderThresh := CB_MAX_DISK //???
	else
		FOriginalCCAB.cbFolderThresh := FolderSizeThreshold;
	FOriginalCCAB.cbReserveCFHeader := ReservePerCabinetSize;
	FOriginalCCAB.cbReserveCFFolder := ReservePerFolderSize;
	FOriginalCCAB.cbReserveCFData := ReservePerDataSize;
	FOriginalCCAB.iDisk := 1;
	FOriginalCCAB.setID := SetID;
	StrPCopy(FOriginalCCAB.szDisk, GetDiskLabel(FOriginalCCAB.iDisk));
	StrPCopy(FOriginalCCAB.szCab, ExtractFileName(FileName));
	StrPCopy(FOriginalCCAB.szCabPath, ExtractFilePath(FileName));
	anAbort := False;
	if Assigned(OnGetNextCabinet) then begin
		OnGetNextCabinet(Self, FOriginalCCAB, 0, anAbort);
		if anAbort then
			exit;
	end;
	StrPCopy(FOriginalCCAB.szCabPath, IncludeTrailingPathDelimiter(FOriginalCCAB.szCabPath));
	ForceDirectories(FOriginalCCAB.szCabPath);
	Windows.DeleteFile(PChar(
		MakePath([String(FOriginalCCAB.szCabPath), String(FOriginalCCAB.szCab)])));

	FFileCountPerCabinet := 0;
	FFileCountPerFolder := 0;
	FProgressCount := 0;

	FHandle := FCICreate(@FERF, @FnFciFilePlaced, @FnAlloc, @FnFree,
		@FnFciOpen, @FnFciRead, @FnFciWrite, @FnFciClose, @FnFciSeek,
		@FnFciDelete, @FnFciGetTempFile, @FOriginalCCAB, Self);
	CabCheck(FHandle <> nil);
end;

procedure TSTCabWriter.Close(aFlushCab: Boolean = True);
begin
	if FHandle <> nil then begin
		if aFlushCab then
			FlushCabinet(False);
		try
			CabCheck(FCIDestroy(FHandle) <> WIN_FALSE);
		finally
			FHandle := nil;
		end;
	end;
end;

procedure TSTCabWriter.AddFile(const aSrcFileName, aDstFileName: String;
	anOptions: TSTCabAddFileOptions = []);
var
	aSkip: Boolean;
	anExec: WIN_BOOL;
begin
	if Assigned(OnBeforeFileAdd) then begin
		aSkip := False;
		OnBeforeFileAdd(Self, aSrcFileName, aSkip);
		if aSkip then
			exit;
	end;
	if (CabinetFileCountThreshold <> 0) and
			(FFileCountPerCabinet >= CabinetFileCountThreshold) then
		StartNewCabinet
	else if (FolderFileCountThreshold <> 0) and
			(FFileCountPerFolder >= FolderFileCountThreshold) then
		StartNewFolder;
	anExec := BooleanToWinBool[cafoExecuteOnExtract in anOptions];
	CabCheck(FCIAddFile(Handle, PAnsiChar(aSrcFileName),
		PAnsiChar(ExcludeLeadingPathDelimiter(aDstFileName)),
		anExec, @FnFciGetNextCabinet, @FnFciStatus, @FnFciGetOpenInfo,
		FCabComp) <> WIN_FALSE);
	Inc(FFileCountPerCabinet);
	Inc(FFileCountPerFolder);
end;

procedure TSTCabWriter.AddFiles(const aSrcPath, aDstPath: String;
	anOptions: TSTCabAddFilesOptions = []);

	procedure ProcessFolder(const aPath, aMask, aCabPath: String);
	var
		aFindPath, aFileName: String;
		aFindData: TWin32FindData;
		hFind: THandle;
		aFolders: TStringList;
		i: Integer;
	begin
		// Process files
		aFindPath := MakePath([aPath, aMask]);
		hFind := Windows.FindFirstFile(PChar(aFindPath), aFindData);
		if hFind = INVALID_HANDLE_VALUE then begin
			if GetLastError <> ERROR_FILE_NOT_FOUND then
				RaiseLastOSError;
		end
		else begin
			try
				repeat
					aFileName := aFindData.cFileName;
					if (aFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
						AddFile(MakePath([aPath, aFileName]), MakePath([aCabPath, aFileName]), []);
				until not Windows.FindNextFile(hFind, aFindData);
				if GetLastError <> ERROR_NO_MORE_FILES then
					RaiseLastOSError;
			finally
				Windows.FindClose(hFind);
			end;
		end;

		if cafsoRecurseSubdirs in anOptions then begin
			// Process subfolders
			aFolders := TStringList.Create;
			try
				aFindPath := MakePath([aPath, '*']);
				hFind := Windows.FindFirstFile(PChar(aFindPath), aFindData);
				if hFind = INVALID_HANDLE_VALUE then begin
					if GetLastError <> ERROR_FILE_NOT_FOUND then
						RaiseLastOSError;
				end
				else begin
					try
						repeat
							aFileName := aFindData.cFileName;
							if ((aFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) and
									(aFileName <> '.') and (aFileName <> '..') then
								aFolders.Add(aFileName);
						until not Windows.FindNextFile(hFind, aFindData);
						if GetLastError <> ERROR_NO_MORE_FILES then
							RaiseLastOSError;
					finally
						Windows.FindClose(hFind);
					end;
					for i := 0 to aFolders.Count - 1 do
						ProcessFolder(MakePath([aPath, aFolders[i]]), aMask,
							MakePath([aCabPath, aFolders[i]]));
				end;
			finally
				aFolders.Free;
			end;
		end;
	end;

begin
	ProcessFolder(ExtractFilePath(aSrcPath), ExtractFileName(aSrcPath), aDstPath);
end;

procedure TSTCabWriter.FlushCabinet(aGetNextCab: Boolean);
begin
	CabCheck(FCIFlushCabinet(Handle, BooleanToWinBool[aGetNextCab],
		@FnFciGetNextCabinet, @FnFciStatus) <> WIN_FALSE);

	FFileCountPerCabinet := 0;
	FFileCountPerFolder := 0;
end;

procedure TSTCabWriter.StartNewCabinet;
begin
	FlushCabinet(True);
end;

procedure TSTCabWriter.StartNewFolder;
begin
	CabCheck(FCIFlushFolder(Handle, @FnFciGetNextCabinet, @FnFciStatus) <> WIN_FALSE);

	FFileCountPerFolder := 0;
end;

{ TSTCabReader }

constructor TSTCabReader.Create(aOwner: TComponent);
begin
	inherited Create(aOwner);
	FSrcFileNames := TStringList.Create;
	FDstFileNames := TStringList.Create;
	FOptions := [];
end;

destructor TSTCabReader.Destroy;
begin
	DestroyHandle;
	FSrcFileNames.Free;
	FDstFileNames.Free;
	inherited Destroy;
end;

function TSTCabReader.GetHandle: HFDI;
begin
	HandleNeeded;
	Result := FHandle;
end;

procedure TSTCabReader.CabCheck(aResult: Boolean);
begin
	if not aResult then begin
		FERF.erfType := LastFdiError;
		raise ESTCabinet.Create(FERF, False);
	end;
end;

procedure TSTCabReader.HandleNeeded;
begin
	if FHandle = nil then begin
		FillChar(FERF, SizeOf(FERF), 0);
		FHandle := FDICreate(@FnAlloc, @FnFree, @FnFdiOpen, @FnFdiRead, @FnFdiWrite,
			@FnFdiClose, @FnFdiSeek, cpuUNKNOWN, @FERF);
		CabCheck(FHandle <> nil);
	end;
end;

procedure TSTCabReader.DestroyHandle;
begin
	if FHandle <> nil then begin
		try
			CabCheck(FDIDestroy(FHandle) <> WIN_FALSE);
		finally
			FHandle := nil;
		end;
	end;
end;

function TSTCabReader.DoNotify(fdint: TFDINOTIFICATIONTYPE; pfdin: PFDINOTIFICATION): Integer;
var
	aFileName, aFilePath: String;
	err, anIndex, aFileAttrs: Integer;
	anExec, anAbort: Boolean;
begin
	LastFdiError := 0;
	anAbort := False;
	case fdint of
		fdintCABINET_INFO: begin
			if FCurrentFileName2 <> '' then
				FCurrentFileName := FCurrentFileName2;
			FNextFileName := pfdin^.psz1;
			if FNextFileName <> '' then
				FNextFileName := MakePath([String(pfdin^.psz3), FNextFileName]);
			FNextDiskName := pfdin^.psz2;
			if Assigned(OnCabinetInfo) then
				OnCabinetInfo(Self, pfdin^.psz1, pfdin^.psz2, pfdin^.psz3,
					pfdin^.setID, pfdin^.iCabinet, anAbort);
			if anAbort then
				Result := -1
			else
				Result := 0;
		end;
		fdintPARTIAL_FILE: begin
			anIndex := FSrcFileNames.IndexOf(pfdin^.psz1);
			if anIndex >= 0 then
				aFileName := FDstFileNames[anIndex]
			else
				aFileName := '';
			if Assigned(OnCopyPartialFile) then
				OnCopyPartialFile(Self, pfdin^.psz1, pfdin^.psz2, pfdin^.psz3, aFileName, anAbort);
			if anAbort then
				Result := -1
			else
				Result := 0;
		end;
		fdintCOPY_FILE: begin
			aFileName := MakePath([DstPath, String(pfdin^.psz1)]);
			if Assigned(OnCopyFile) then
				OnCopyFile(Self, pfdin^.psz1, pfdin^.cb, pfdin^.date, pfdin^.time,
					pfdin^.attribs, pfdin^.iFolder, aFileName, anAbort);
			if anAbort then
				Result := -1
			else if aFileName = '' then
				Result := 0
			else begin
				ForceDirectories(ExtractFilePath(aFileName));
				if FileExists(aFileName) then begin
					aFileAttrs := FileGetAttr(aFileName);
					if (aFileAttrs and faReadOnly) <> 0 then begin
						if croDontOverwriteReadOnlyFiles in Options then begin
							Result := 0;
							exit;
						end;
						FileSetAttr(aFileName, aFileAttrs and not faReadOnly);
					end;
				end;
				err := 0;
				Result := StdFileOpen(PAnsiChar(aFileName), _O_BINARY or _O_CREAT or
					_O_WRONLY or _O_SEQUENTIAL, _S_IREAD or _S_IWRITE, @err);
				if err <> 0 then
					LastFdiError := err;
				if Result <> -1 then begin
					FSrcFileNames.Add(pfdin^.psz1);
					FDstFileNames.Add(aFileName);
				end;
			end;
		end;
		fdintCLOSE_FILE_INFO: begin
			err := 0;
			StdFileClose(pfdin^.hf, @err);
			anIndex := FSrcFileNames.IndexOf(pfdin^.psz1);
			if anIndex >= 0 then begin
				aFileName := FDstFileNames[anIndex];
				FSrcFileNames.Delete(anIndex);
				FDstFileNames.Delete(anIndex);
				StdFileSetInfo(PAnsiChar(aFileName), pfdin^.date, pfdin^.time,
					pfdin^.attribs, @err);
			end
			else
				aFileName := '';
			anExec := (pfdin^.cb and 1) = 1;
			if Assigned(OnCloseFile) then
				OnCloseFile(Self, pfdin^.psz1, pfdin^.date, pfdin^.time, pfdin^.attribs,
					pfdin^.iFolder, anExec, aFileName, anAbort);
			if anAbort then
				Result := -1
			else begin
				if anExec and (croExecuteOnExtract in Options) and (aFileName <> '') then
					ShellExecute(0, 'open', PChar(aFileName), nil, nil, SW_SHOWNORMAL);
				Result := WIN_TRUE;
			end;
		end;
		fdintNEXT_CABINET: begin
			if Assigned(OnNextCabinet) then begin
				aFilePath := pfdin^.psz3;
				OnNextCabinet(Self, pfdin^.psz1, pfdin^.psz2, aFilePath, pfdin^.fdie, anAbort);
				if anAbort then
					Result := -1
				else begin
					StrPCopy(pfdin^.psz3, IncludeTrailingPathDelimiter(aFilePath));
					Result := 0;
				end;
			end
			else if pfdin^.fdie = FDIERROR_NONE then
				Result := 0
			else
				Result := -1;
			FCurrentFileName2 := MakePath([String(pfdin^.psz3), String(pfdin^.psz1)]);
			FIsOnPartialFile := True;
		end;
		fdintENUMERATE: begin
			Result := 0;
			if Assigned(OnUnrecognizedNotify) then
				OnUnrecognizedNotify(Self, fdint, pfdin^, Result);
		end;
		else begin
			Result := 0;
			if Assigned(OnUnrecognizedNotify) then
				OnUnrecognizedNotify(Self, fdint, pfdin^, Result);
		end;
	end;
end;

function TSTCabReader.IsCabinet(const aFileName: String; var aCabInfo: TFDICABINETINFO): Boolean;
var
	hf, err: Integer;
begin
	err := 0;
	hf := StdFileOpen(PAnsiChar(aFileName), _O_RDONLY or _O_BINARY, 0, @err);
	if hf = -1 then
		RaiseLastOSError;
	try
		Result := FDIIsCabinet(Handle, hf, @aCabInfo) <> WIN_FALSE;
	finally
		StdFileClose(hf, @err);
	end;
end;

procedure TSTCabReader.ExtractFiles(const aFileName, aDstPath: String;
	anOptions: TSTCabExtractFilesOptions = []);
var
	s: String;
begin
	FFileName := ExpandFileName(aFileName);
	FDstPath := IncludeTrailingPathDelimiter(aDstPath);
	FSrcFileNames.Clear;
	FDstFileNames.Clear;
	s := FileName;
	while s <> '' do begin
		FNextFileName := '';
		FNextDiskName := '';
		FCurrentFileName := s;
		FCurrentFileName2 := '';
		FIsOnPartialFile := False;
		CabCheck(FDICopy(Handle, PAnsiChar(ExtractFileName(s)),
			PAnsiChar(ExtractFilePath(s)), 0, @FnFdiNotify, nil, Self) <> WIN_FALSE);
		if IsOnPartialFile then
			s := FCurrentFileName2
		else if AnsiCompareText(s, NextFileName) = 0 then
			s := ''
		else
			s := NextFileName;
		if (cefsoProcessOnlyOneVolume in anOptions) or
				((s <> '') and not FileExists(s)) then
			s := '';
	end;
end;

function TSTCabReader.EnumFilesEntries(const aFileName: String;
	aCallback: TSTCabReaderEnumFilesEntriesEvent): Boolean;

	procedure StmSetPosition(aStm: TFileStream; aPos: Longint);
	begin
		aStm.Position := aPos;
		if aStm.Position <> aPos then
			raise Exception.Create(SCabErrSetPosition);
	end;

	function StmReadSzFileName(aStm: TFileStream): String;
	var
		aBuf: array[0..MAX_PATH * 3] of AnsiChar;
		aPtr: PAnsiChar;
	begin
		aPtr := @aBuf;
		while True do begin
			aStm.ReadBuffer(aPtr^, SizeOf(AnsiChar));
			if aPtr^ = #0 then
				break;
			Inc(aPtr);
		end;
		Result := aBuf;
	end;

var
	aCabInfo: TFDICABINETINFO;
	aStm: TFileStream;
	aHeaderEntry: TCFHEADER;
	aFileEntry: TCFFILE;
	anAbort: Boolean;
	aName: String;
	i: Integer;
begin
	Result := IsCabinet(aFileName, aCabInfo);
	if not Result then
		exit;
	aStm := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
	try
		aStm.ReadBuffer(aHeaderEntry, SizeOf(TCFHEADER));
		if aHeaderEntry.signature <> cfhdrSIGNATURE then
			raise Exception.Create(SFdiErrNotACabinet);
		StmSetPosition(aStm, aHeaderEntry.coffFiles);
		anAbort := False;
		for i := 0 to aHeaderEntry.cFiles - 1 do begin
			aStm.ReadBuffer(aFileEntry, SizeOf(TCFFILE));
			aName := StmReadSzFileName(aStm);
			aCallback(Self, aName, aFileEntry.cbFile, aFileEntry.iFolder,
				aFileEntry.date, aFileEntry.time, aFileEntry.attribs, anAbort);
			if anAbort then
				break;
		end;
	finally
		aStm.Free;
	end;
end;

end.

