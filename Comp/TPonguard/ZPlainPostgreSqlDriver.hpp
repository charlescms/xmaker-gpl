// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainPostgreSqlDriver.pas' rev: 5.00

#ifndef ZPlainPostgreSqlDriverHPP
#define ZPlainPostgreSqlDriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainpostgresqldriver
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZPostgreSQLConnectStatusType { CONNECTION_OK, CONNECTION_BAD };
#pragma option pop

#pragma option push -b-
enum TZPostgreSQLExecStatusType { PGRES_EMPTY_QUERY, PGRES_COMMAND_OK, PGRES_TUPLES_OK, PGRES_COPY_OUT, 
	PGRES_COPY_IN, PGRES_BAD_RESPONSE, PGRES_NONFATAL_ERROR, PGRES_FATAL_ERROR };
#pragma option pop

#pragma pack(push, 1)
struct TZPostgreSQLNotify
{
	char relname[32];
	int be_pid;
} ;
#pragma pack(pop)

typedef TZPostgreSQLNotify *PZPostgreSQLNotify;

typedef void __cdecl (*TZPostgreSQLNoticeProcessor)(void * arg, char * message);

#pragma pack(push, 1)
struct TZPostgreSQLConnectInfoOption
{
	char *keyword;
	char *envvar;
	char *compiled;
	char *val;
	char *lab;
	char *dispchar;
	int dispsize;
} ;
#pragma pack(pop)

typedef TZPostgreSQLConnectInfoOption *PZPostgreSQLConnectInfoOption;

#pragma pack(push, 1)
struct TZPostgreSQLArgBlock
{
	int len;
	int isint;
	bool u;
	union
	{
		struct 
		{
			int _int;
			
		};
		struct 
		{
			int *ptr;
			
		};
		
	};
} ;
#pragma pack(pop)

typedef TZPostgreSQLArgBlock *PZPostgreSQLArgBlock;

typedef void *PZPostgreSQLConnect;

typedef void *PZPostgreSQLResult;

typedef int Oid;

__interface IZPostgreSQLPlainDriver;
typedef System::DelphiInterface<IZPostgreSQLPlainDriver> _di_IZPostgreSQLPlainDriver;
__interface INTERFACE_UUID("{03CD6345-2D7A-4FE2-B03D-3C5656789FEB}") IZPostgreSQLPlainDriver  : public IZPlainDriver 
	
{
	
public:
	virtual void * __fastcall ConnectDatabase(char * ConnInfo) = 0 ;
	virtual void * __fastcall SetDatabaseLogin(char * Host, char * Port, char * Options, char * TTY, char * 
		Db, char * User, char * Passwd) = 0 ;
	virtual PZPostgreSQLConnectInfoOption __fastcall GetConnectDefaults(void) = 0 ;
	virtual void __fastcall Finish(void * Handle) = 0 ;
	virtual void __fastcall Reset(void * Handle) = 0 ;
	virtual int __fastcall RequestCancel(void * Handle) = 0 ;
	virtual char * __fastcall GetDatabase(void * Handle) = 0 ;
	virtual char * __fastcall GetUser(void * Handle) = 0 ;
	virtual char * __fastcall GetPassword(void * Handle) = 0 ;
	virtual char * __fastcall GetHost(void * Handle) = 0 ;
	virtual char * __fastcall GetPort(void * Handle) = 0 ;
	virtual char * __cdecl GetTTY(void * Handle) = 0 ;
	virtual char * __fastcall GetOptions(void * Handle) = 0 ;
	virtual TZPostgreSQLConnectStatusType __fastcall GetStatus(void * Handle) = 0 ;
	virtual char * __fastcall GetErrorMessage(void * Handle) = 0 ;
	virtual int __fastcall GetSocket(void * Handle) = 0 ;
	virtual int __fastcall GetBackendPID(void * Handle) = 0 ;
	virtual void __fastcall Trace(void * Handle, void * DebugPort) = 0 ;
	virtual void __fastcall Untrace(void * Handle) = 0 ;
	virtual void __fastcall SetNoticeProcessor(void * Handle, TZPostgreSQLNoticeProcessor Proc, void * 
		Arg) = 0 ;
	virtual void * __fastcall ExecuteQuery(void * Handle, char * Query) = 0 ;
	virtual PZPostgreSQLNotify __fastcall Notifies(void * Handle) = 0 ;
	virtual void __fastcall FreeNotify(PZPostgreSQLNotify Handle) = 0 ;
	virtual int __fastcall SendQuery(void * Handle, char * Query) = 0 ;
	virtual void * __fastcall GetResult(void * Handle) = 0 ;
	virtual int __fastcall IsBusy(void * Handle) = 0 ;
	virtual int __fastcall ConsumeInput(void * Handle) = 0 ;
	virtual int __fastcall GetLine(void * Handle, char * Str, int Length) = 0 ;
	virtual int __fastcall PutLine(void * Handle, char * Str) = 0 ;
	virtual int __fastcall GetLineAsync(void * Handle, char * Buffer, int Length) = 0 ;
	virtual int __fastcall PutBytes(void * Handle, char * Buffer, int Length) = 0 ;
	virtual int __fastcall EndCopy(void * Handle) = 0 ;
	virtual void * __fastcall ExecuteFunction(void * Handle, int fnid, Zcompatibility::PInteger result_buf
		, Zcompatibility::PInteger result_len, int result_is_int, PZPostgreSQLArgBlock args, int nargs) = 0 
		;
	virtual TZPostgreSQLExecStatusType __fastcall GetResultStatus(void * Res) = 0 ;
	virtual char * __fastcall GetResultErrorMessage(void * Res) = 0 ;
	virtual int __fastcall GetRowCount(void * Res) = 0 ;
	virtual int __fastcall GetFieldCount(void * Res) = 0 ;
	virtual int __fastcall GetBinaryTuples(void * Res) = 0 ;
	virtual char * __fastcall GetFieldName(void * Res, int FieldNum) = 0 ;
	virtual int __fastcall GetFieldNumber(void * Res, char * FieldName) = 0 ;
	virtual int __fastcall GetFieldType(void * Res, int FieldNum) = 0 ;
	virtual int __fastcall GetFieldSize(void * Res, int FieldNum) = 0 ;
	virtual int __fastcall GetFieldMode(void * Res, int FieldNum) = 0 ;
	virtual char * __fastcall GetCommandStatus(void * Res) = 0 ;
	virtual int __fastcall GetOidValue(void * Res) = 0 ;
	virtual char * __fastcall GetOidStatus(void * Res) = 0 ;
	virtual char * __fastcall GetCommandTuples(void * Res) = 0 ;
	virtual char * __fastcall GetValue(void * Res, int TupNum, int FieldNum) = 0 ;
	virtual int __fastcall GetLength(void * Res, int TupNum, int FieldNum) = 0 ;
	virtual int __fastcall GetIsNull(void * Res, int TupNum, int FieldNum) = 0 ;
	virtual void __fastcall Clear(void * Res) = 0 ;
	virtual void * __fastcall MakeEmptyResult(void * Handle, TZPostgreSQLExecStatusType Status) = 0 ;
	virtual int __fastcall OpenLargeObject(void * Handle, int ObjId, int Mode) = 0 ;
	virtual int __fastcall CloseLargeObject(void * Handle, int Fd) = 0 ;
	virtual int __fastcall ReadLargeObject(void * Handle, int Fd, char * Buffer, int Length) = 0 ;
	virtual int __fastcall WriteLargeObject(void * Handle, int Fd, char * Buffer, int Length) = 0 ;
	virtual int __fastcall SeekLargeObject(void * Handle, int Fd, int Offset, int Whence) = 0 ;
	virtual int __fastcall CreateLargeObject(void * Handle, int Mode) = 0 ;
	virtual int __fastcall TellLargeObject(void * Handle, int Fd) = 0 ;
	virtual int __fastcall UnlinkLargeObject(void * Handle, int ObjId) = 0 ;
	virtual int __fastcall ImportLargeObject(void * Handle, char * FileName) = 0 ;
	virtual int __fastcall ExportLargeObject(void * Handle, int ObjId, char * FileName) = 0 ;
};

class DELPHICLASS TZPostgreSQL65PlainDriver;
class PASCALIMPLEMENTATION TZPostgreSQL65PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZPostgreSQL65PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void * __fastcall ConnectDatabase(char * ConnInfo);
	void * __fastcall SetDatabaseLogin(char * Host, char * Port, char * Options, char * TTY, char * Db, 
		char * User, char * Passwd);
	PZPostgreSQLConnectInfoOption __fastcall GetConnectDefaults(void);
	void __fastcall Finish(void * Handle);
	void __fastcall Reset(void * Handle);
	int __fastcall RequestCancel(void * Handle);
	char * __fastcall GetDatabase(void * Handle);
	char * __fastcall GetUser(void * Handle);
	char * __fastcall GetPassword(void * Handle);
	char * __fastcall GetHost(void * Handle);
	char * __fastcall GetPort(void * Handle);
	char * __cdecl GetTTY(void * Handle);
	char * __fastcall GetOptions(void * Handle);
	TZPostgreSQLConnectStatusType __fastcall GetStatus(void * Handle);
	char * __fastcall GetErrorMessage(void * Handle);
	int __fastcall GetSocket(void * Handle);
	int __fastcall GetBackendPID(void * Handle);
	void __fastcall Trace(void * Handle, void * DebugPort);
	void __fastcall Untrace(void * Handle);
	void __fastcall SetNoticeProcessor(void * Handle, TZPostgreSQLNoticeProcessor Proc, void * Arg);
	void * __fastcall ExecuteQuery(void * Handle, char * Query);
	PZPostgreSQLNotify __fastcall Notifies(void * Handle);
	void __fastcall FreeNotify(PZPostgreSQLNotify Handle);
	int __fastcall SendQuery(void * Handle, char * Query);
	void * __fastcall GetResult(void * Handle);
	int __fastcall IsBusy(void * Handle);
	int __fastcall ConsumeInput(void * Handle);
	int __fastcall GetLine(void * Handle, char * Buffer, int Length);
	int __fastcall PutLine(void * Handle, char * Buffer);
	int __fastcall GetLineAsync(void * Handle, char * Buffer, int Length);
	int __fastcall PutBytes(void * Handle, char * Buffer, int Length);
	int __fastcall EndCopy(void * Handle);
	void * __fastcall ExecuteFunction(void * Handle, int fnid, Zcompatibility::PInteger result_buf, Zcompatibility::PInteger 
		result_len, int result_is_int, PZPostgreSQLArgBlock args, int nargs);
	TZPostgreSQLExecStatusType __fastcall GetResultStatus(void * Res);
	char * __fastcall GetResultErrorMessage(void * Res);
	int __fastcall GetRowCount(void * Res);
	int __fastcall GetFieldCount(void * Res);
	int __fastcall GetBinaryTuples(void * Res);
	char * __fastcall GetFieldName(void * Res, int FieldNum);
	int __fastcall GetFieldNumber(void * Res, char * FieldName);
	int __fastcall GetFieldType(void * Res, int FieldNum);
	int __fastcall GetFieldSize(void * Res, int FieldNum);
	int __fastcall GetFieldMode(void * Res, int FieldNum);
	char * __fastcall GetCommandStatus(void * Res);
	int __fastcall GetOidValue(void * Res);
	char * __fastcall GetOidStatus(void * Res);
	char * __fastcall GetCommandTuples(void * Res);
	char * __fastcall GetValue(void * Res, int TupNum, int FieldNum);
	int __fastcall GetLength(void * Res, int TupNum, int FieldNum);
	int __fastcall GetIsNull(void * Res, int TupNum, int FieldNum);
	void __fastcall Clear(void * Res);
	void * __fastcall MakeEmptyResult(void * Handle, TZPostgreSQLExecStatusType Status);
	int __fastcall OpenLargeObject(void * Handle, int ObjId, int Mode);
	int __fastcall CloseLargeObject(void * Handle, int Fd);
	int __fastcall ReadLargeObject(void * Handle, int Fd, char * Buffer, int Length);
	int __fastcall WriteLargeObject(void * Handle, int Fd, char * Buffer, int Length);
	int __fastcall SeekLargeObject(void * Handle, int Fd, int Offset, int Whence);
	int __fastcall CreateLargeObject(void * Handle, int Mode);
	int __fastcall TellLargeObject(void * Handle, int Fd);
	int __fastcall UnlinkLargeObject(void * Handle, int ObjId);
	int __fastcall ImportLargeObject(void * Handle, char * FileName);
	int __fastcall ExportLargeObject(void * Handle, int ObjId, char * FileName);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQL65PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZPostgreSQLPlainDriver;	/* Zplainpostgresqldriver::IZPostgreSQLPlainDriver */
	
public:
	operator IZPostgreSQLPlainDriver*(void) { return (IZPostgreSQLPlainDriver*)&__IZPostgreSQLPlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZPostgreSQLPlainDriver; }
	
};


class DELPHICLASS TZPostgreSQL72PlainDriver;
class PASCALIMPLEMENTATION TZPostgreSQL72PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZPostgreSQL72PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void * __fastcall ConnectDatabase(char * ConnInfo);
	void * __fastcall SetDatabaseLogin(char * Host, char * Port, char * Options, char * TTY, char * Db, 
		char * User, char * Passwd);
	PZPostgreSQLConnectInfoOption __fastcall GetConnectDefaults(void);
	void __fastcall Finish(void * Handle);
	void __fastcall Reset(void * Handle);
	int __fastcall RequestCancel(void * Handle);
	char * __fastcall GetDatabase(void * Handle);
	char * __fastcall GetUser(void * Handle);
	char * __fastcall GetPassword(void * Handle);
	char * __fastcall GetHost(void * Handle);
	char * __fastcall GetPort(void * Handle);
	char * __cdecl GetTTY(void * Handle);
	char * __fastcall GetOptions(void * Handle);
	TZPostgreSQLConnectStatusType __fastcall GetStatus(void * Handle);
	char * __fastcall GetErrorMessage(void * Handle);
	int __fastcall GetSocket(void * Handle);
	int __fastcall GetBackendPID(void * Handle);
	void __fastcall Trace(void * Handle, void * DebugPort);
	void __fastcall Untrace(void * Handle);
	void __fastcall SetNoticeProcessor(void * Handle, TZPostgreSQLNoticeProcessor Proc, void * Arg);
	void * __fastcall ExecuteQuery(void * Handle, char * Query);
	PZPostgreSQLNotify __fastcall Notifies(void * Handle);
	void __fastcall FreeNotify(PZPostgreSQLNotify Handle);
	int __fastcall SendQuery(void * Handle, char * Query);
	void * __fastcall GetResult(void * Handle);
	int __fastcall IsBusy(void * Handle);
	int __fastcall ConsumeInput(void * Handle);
	int __fastcall GetLine(void * Handle, char * Buffer, int Length);
	int __fastcall PutLine(void * Handle, char * Buffer);
	int __fastcall GetLineAsync(void * Handle, char * Buffer, int Length);
	int __fastcall PutBytes(void * Handle, char * Buffer, int Length);
	int __fastcall EndCopy(void * Handle);
	void * __fastcall ExecuteFunction(void * Handle, int fnid, Zcompatibility::PInteger result_buf, Zcompatibility::PInteger 
		result_len, int result_is_int, PZPostgreSQLArgBlock args, int nargs);
	TZPostgreSQLExecStatusType __fastcall GetResultStatus(void * Res);
	char * __fastcall GetResultErrorMessage(void * Res);
	int __fastcall GetRowCount(void * Res);
	int __fastcall GetFieldCount(void * Res);
	int __fastcall GetBinaryTuples(void * Res);
	char * __fastcall GetFieldName(void * Res, int FieldNum);
	int __fastcall GetFieldNumber(void * Res, char * FieldName);
	int __fastcall GetFieldType(void * Res, int FieldNum);
	int __fastcall GetFieldSize(void * Res, int FieldNum);
	int __fastcall GetFieldMode(void * Res, int FieldNum);
	char * __fastcall GetCommandStatus(void * Res);
	int __fastcall GetOidValue(void * Res);
	char * __fastcall GetOidStatus(void * Res);
	char * __fastcall GetCommandTuples(void * Res);
	char * __fastcall GetValue(void * Res, int TupNum, int FieldNum);
	int __fastcall GetLength(void * Res, int TupNum, int FieldNum);
	int __fastcall GetIsNull(void * Res, int TupNum, int FieldNum);
	void __fastcall Clear(void * Res);
	void * __fastcall MakeEmptyResult(void * Handle, TZPostgreSQLExecStatusType Status);
	int __fastcall OpenLargeObject(void * Handle, int ObjId, int Mode);
	int __fastcall CloseLargeObject(void * Handle, int Fd);
	int __fastcall ReadLargeObject(void * Handle, int Fd, char * Buffer, int Length);
	int __fastcall WriteLargeObject(void * Handle, int Fd, char * Buffer, int Length);
	int __fastcall SeekLargeObject(void * Handle, int Fd, int Offset, int Whence);
	int __fastcall CreateLargeObject(void * Handle, int Mode);
	int __fastcall TellLargeObject(void * Handle, int Fd);
	int __fastcall UnlinkLargeObject(void * Handle, int ObjId);
	int __fastcall ImportLargeObject(void * Handle, char * FileName);
	int __fastcall ExportLargeObject(void * Handle, int ObjId, char * FileName);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQL72PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZPostgreSQLPlainDriver;	/* Zplainpostgresqldriver::IZPostgreSQLPlainDriver */
	
public:
	operator IZPostgreSQLPlainDriver*(void) { return (IZPostgreSQLPlainDriver*)&__IZPostgreSQLPlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZPostgreSQLPlainDriver; }
	
};


class DELPHICLASS TZPostgreSQL73PlainDriver;
class PASCALIMPLEMENTATION TZPostgreSQL73PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZPostgreSQL73PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void * __fastcall ConnectDatabase(char * ConnInfo);
	void * __fastcall SetDatabaseLogin(char * Host, char * Port, char * Options, char * TTY, char * Db, 
		char * User, char * Passwd);
	PZPostgreSQLConnectInfoOption __fastcall GetConnectDefaults(void);
	void __fastcall Finish(void * Handle);
	void __fastcall Reset(void * Handle);
	int __fastcall RequestCancel(void * Handle);
	char * __fastcall GetDatabase(void * Handle);
	char * __fastcall GetUser(void * Handle);
	char * __fastcall GetPassword(void * Handle);
	char * __fastcall GetHost(void * Handle);
	char * __fastcall GetPort(void * Handle);
	char * __cdecl GetTTY(void * Handle);
	char * __fastcall GetOptions(void * Handle);
	TZPostgreSQLConnectStatusType __fastcall GetStatus(void * Handle);
	char * __fastcall GetErrorMessage(void * Handle);
	int __fastcall GetSocket(void * Handle);
	int __fastcall GetBackendPID(void * Handle);
	void __fastcall Trace(void * Handle, void * DebugPort);
	void __fastcall Untrace(void * Handle);
	void __fastcall SetNoticeProcessor(void * Handle, TZPostgreSQLNoticeProcessor Proc, void * Arg);
	void * __fastcall ExecuteQuery(void * Handle, char * Query);
	PZPostgreSQLNotify __fastcall Notifies(void * Handle);
	void __fastcall FreeNotify(PZPostgreSQLNotify Handle);
	int __fastcall SendQuery(void * Handle, char * Query);
	void * __fastcall GetResult(void * Handle);
	int __fastcall IsBusy(void * Handle);
	int __fastcall ConsumeInput(void * Handle);
	int __fastcall GetLine(void * Handle, char * Buffer, int Length);
	int __fastcall PutLine(void * Handle, char * Buffer);
	int __fastcall GetLineAsync(void * Handle, char * Buffer, int Length);
	int __fastcall PutBytes(void * Handle, char * Buffer, int Length);
	int __fastcall EndCopy(void * Handle);
	void * __fastcall ExecuteFunction(void * Handle, int fnid, Zcompatibility::PInteger result_buf, Zcompatibility::PInteger 
		result_len, int result_is_int, PZPostgreSQLArgBlock args, int nargs);
	TZPostgreSQLExecStatusType __fastcall GetResultStatus(void * Res);
	char * __fastcall GetResultErrorMessage(void * Res);
	int __fastcall GetRowCount(void * Res);
	int __fastcall GetFieldCount(void * Res);
	int __fastcall GetBinaryTuples(void * Res);
	char * __fastcall GetFieldName(void * Res, int FieldNum);
	int __fastcall GetFieldNumber(void * Res, char * FieldName);
	int __fastcall GetFieldType(void * Res, int FieldNum);
	int __fastcall GetFieldSize(void * Res, int FieldNum);
	int __fastcall GetFieldMode(void * Res, int FieldNum);
	char * __fastcall GetCommandStatus(void * Res);
	int __fastcall GetOidValue(void * Res);
	char * __fastcall GetOidStatus(void * Res);
	char * __fastcall GetCommandTuples(void * Res);
	char * __fastcall GetValue(void * Res, int TupNum, int FieldNum);
	int __fastcall GetLength(void * Res, int TupNum, int FieldNum);
	int __fastcall GetIsNull(void * Res, int TupNum, int FieldNum);
	void __fastcall Clear(void * Res);
	void * __fastcall MakeEmptyResult(void * Handle, TZPostgreSQLExecStatusType Status);
	int __fastcall OpenLargeObject(void * Handle, int ObjId, int Mode);
	int __fastcall CloseLargeObject(void * Handle, int Fd);
	int __fastcall ReadLargeObject(void * Handle, int Fd, char * Buffer, int Length);
	int __fastcall WriteLargeObject(void * Handle, int Fd, char * Buffer, int Length);
	int __fastcall SeekLargeObject(void * Handle, int Fd, int Offset, int Whence);
	int __fastcall CreateLargeObject(void * Handle, int Mode);
	int __fastcall TellLargeObject(void * Handle, int Fd);
	int __fastcall UnlinkLargeObject(void * Handle, int ObjId);
	int __fastcall ImportLargeObject(void * Handle, char * FileName);
	int __fastcall ExportLargeObject(void * Handle, int ObjId, char * FileName);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZPostgreSQL73PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZPostgreSQLPlainDriver;	/* Zplainpostgresqldriver::IZPostgreSQLPlainDriver */
	
public:
	operator IZPostgreSQLPlainDriver*(void) { return (IZPostgreSQLPlainDriver*)&__IZPostgreSQLPlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZPostgreSQLPlainDriver; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint NAMEDATALEN = 0x20;
static const Shortint OIDNAMELEN = 0x24;
static const int INV_WRITE = 0x20000;
static const int INV_READ = 0x40000;
static const Shortint BLOB_SEEK_SET = 0x0;
static const Shortint BLOB_SEEK_CUR = 0x1;
static const Shortint BLOB_SEEK_END = 0x2;

}	/* namespace Zplainpostgresqldriver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainpostgresqldriver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainPostgreSqlDriver
