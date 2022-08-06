// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainMySqlDriver.pas' rev: 5.00

#ifndef ZPlainMySqlDriverHPP
#define ZPlainMySqlDriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainmysqldriver
{
//-- type declarations -------------------------------------------------------
typedef void *PZMySQLConnect;

typedef void *PZMySQLResult;

typedef void *PZMySQLRow;

typedef void *PZMySQLField;

typedef void *PZMySQLRowOffset;

#pragma option push -b-
enum TZMySQLOption { MYSQL_OPT_CONNECT_TIMEOUT, MYSQL_OPT_COMPRESS, MYSQL_OPT_NAMED_PIPE, MYSQL_INIT_COMMAND, 
	MYSQL_READ_DEFAULT_FILE, MYSQL_READ_DEFAULT_GROUP, MYSQL_SET_CHARSET_DIR, MYSQL_SET_CHARSET_NAME };
	
#pragma option pop

#pragma option push -b-
enum TZMySQLStatus { MYSQL_STATUS_READY, MYSQL_STATUS_GET_RESULT, MYSQL_STATUS_USE_RESULT };
#pragma option pop

__interface IZMySQLPlainDriver;
typedef System::DelphiInterface<IZMySQLPlainDriver> _di_IZMySQLPlainDriver;
__interface INTERFACE_UUID("{D1CB3F6C-72A1-4125-873F-791202ACC5F0}") IZMySQLPlainDriver  : public IZPlainDriver 
	
{
	
public:
	virtual void __fastcall Debug(char * Debug) = 0 ;
	virtual int __fastcall DumpDebugInfo(void * Handle) = 0 ;
	virtual char * __fastcall GetLastError(void * Handle) = 0 ;
	virtual int __fastcall GetLastErrorCode(void * Handle) = 0 ;
	virtual void * __fastcall Init(void * &Handle) = 0 ;
	virtual void __fastcall Despose(void * &Handle) = 0 ;
	virtual void * __fastcall Connect(void * Handle, const char * Host, const char * User, const char * 
		Password) = 0 ;
	virtual void * __fastcall RealConnect(void * Handle, const char * Host, const char * User, const char * 
		Password, const char * Db, unsigned Port, char * UnixSocket, unsigned ClientFlag) = 0 ;
	virtual void __fastcall Close(void * Handle) = 0 ;
	virtual int __fastcall ExecQuery(void * Handle, const char * Query) = 0 ;
	virtual int __fastcall ExecRealQuery(void * Handle, const char * Query, int Length) = 0 ;
	virtual int __fastcall SelectDatabase(void * Handle, const char * Database) = 0 ;
	virtual int __fastcall CreateDatabase(void * Handle, const char * Database) = 0 ;
	virtual int __fastcall DropDatabase(void * Handle, const char * Database) = 0 ;
	virtual int __fastcall Shutdown(void * Handle) = 0 ;
	virtual int __fastcall Refresh(void * Handle, unsigned Options) = 0 ;
	virtual int __fastcall Kill(void * Handle, int Pid) = 0 ;
	virtual int __fastcall Ping(void * Handle) = 0 ;
	virtual char * __fastcall GetStatInfo(void * Handle) = 0 ;
	virtual int __fastcall SetOptions(void * Handle, TZMySQLOption Option, const char * Arg) = 0 ;
	virtual unsigned __fastcall GetEscapeString(char * StrTo, char * StrFrom, unsigned Length) = 0 ;
	virtual char * __fastcall GetServerInfo(void * Handle) = 0 ;
	virtual char * __fastcall GetClientInfo(void) = 0 ;
	virtual char * __fastcall GetHostInfo(void * Handle) = 0 ;
	virtual unsigned __fastcall GetProtoInfo(void * Handle) = 0 ;
	virtual unsigned __fastcall GetThreadId(void * Handle) = 0 ;
	virtual void * __fastcall GetListDatabases(void * Handle, char * Wild) = 0 ;
	virtual void * __fastcall GetListTables(void * Handle, const char * Wild) = 0 ;
	virtual void * __fastcall GetListFields(void * Handle, const char * Table, const char * Wild) = 0 ;
		
	virtual void * __fastcall GetListProcesses(void * Handle) = 0 ;
	virtual void * __fastcall StoreResult(void * Handle) = 0 ;
	virtual void * __fastcall UseResult(void * Handle) = 0 ;
	virtual void __fastcall FreeResult(void * Res) = 0 ;
	virtual unsigned __fastcall GetAffectedRows(void * Handle) = 0 ;
	virtual void * __fastcall FetchRow(void * Res) = 0 ;
	virtual Zcompatibility::PLongInt __fastcall FetchLengths(void * Res) = 0 ;
	virtual void * __fastcall FetchField(void * Res) = 0 ;
	virtual void __fastcall SeekData(void * Res, unsigned Offset) = 0 ;
	virtual void * __fastcall SeekRow(void * Res, void * Row) = 0 ;
	virtual unsigned __fastcall SeekField(void * Res, unsigned Offset) = 0 ;
	virtual Byte __fastcall GetFieldType(void * Field) = 0 ;
	virtual int __fastcall GetFieldFlags(void * Field) = 0 ;
	virtual TZMySQLStatus __fastcall GetStatus(void * Handle) = 0 ;
	virtual __int64 __fastcall GetRowCount(void * Res) = 0 ;
	virtual int __fastcall GetFieldCount(void * Res) = 0 ;
	virtual char * __fastcall GetFieldName(void * Field) = 0 ;
	virtual char * __fastcall GetFieldTable(void * Field) = 0 ;
	virtual int __fastcall GetFieldLength(void * Field) = 0 ;
	virtual int __fastcall GetFieldMaxLength(void * Field) = 0 ;
	virtual int __fastcall GetFieldDecimals(void * Field) = 0 ;
	virtual char * __fastcall GetFieldData(void * Row, unsigned Offset) = 0 ;
};

class DELPHICLASS TZMySQL320PlainDriver;
class PASCALIMPLEMENTATION TZMySQL320PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZMySQL320PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void __fastcall Debug(char * Debug);
	int __fastcall DumpDebugInfo(void * Handle);
	char * __fastcall GetLastError(void * Handle);
	int __fastcall GetLastErrorCode(void * Handle);
	void * __fastcall Init(void * &Handle);
	void __fastcall Despose(void * &Handle);
	void * __fastcall Connect(void * Handle, const char * Host, const char * User, const char * Password
		);
	void * __fastcall RealConnect(void * Handle, const char * Host, const char * User, const char * Password
		, const char * Db, unsigned Port, char * UnixSocket, unsigned ClientFlag);
	void __fastcall Close(void * Handle);
	int __fastcall ExecQuery(void * Handle, const char * Query);
	int __fastcall ExecRealQuery(void * Handle, const char * Query, int Length);
	int __fastcall SelectDatabase(void * Handle, const char * Database);
	int __fastcall CreateDatabase(void * Handle, const char * Database);
	int __fastcall DropDatabase(void * Handle, const char * Database);
	int __fastcall Shutdown(void * Handle);
	int __fastcall Refresh(void * Handle, unsigned Options);
	int __fastcall Kill(void * Handle, int Pid);
	int __fastcall Ping(void * Handle);
	char * __fastcall GetStatInfo(void * Handle);
	int __fastcall SetOptions(void * Handle, TZMySQLOption Option, const char * Arg);
	unsigned __fastcall GetEscapeString(char * StrTo, char * StrFrom, unsigned Length);
	char * __fastcall GetServerInfo(void * Handle);
	char * __fastcall GetClientInfo(void);
	char * __fastcall GetHostInfo(void * Handle);
	unsigned __fastcall GetProtoInfo(void * Handle);
	unsigned __fastcall GetThreadId(void * Handle);
	void * __fastcall GetListDatabases(void * Handle, char * Wild);
	void * __fastcall GetListTables(void * Handle, const char * Wild);
	void * __fastcall GetListFields(void * Handle, const char * Table, const char * Wild);
	void * __fastcall GetListProcesses(void * Handle);
	void * __fastcall StoreResult(void * Handle);
	void * __fastcall UseResult(void * Handle);
	void __fastcall FreeResult(void * Res);
	unsigned __fastcall GetAffectedRows(void * Handle);
	void * __fastcall FetchRow(void * Res);
	Zcompatibility::PLongInt __fastcall FetchLengths(void * Res);
	void * __fastcall FetchField(void * Res);
	void __fastcall SeekData(void * Res, unsigned Offset);
	void * __fastcall SeekRow(void * Res, void * Row);
	unsigned __fastcall SeekField(void * Res, unsigned Offset);
	Byte __fastcall GetFieldType(void * Field);
	int __fastcall GetFieldFlags(void * Field);
	TZMySQLStatus __fastcall GetStatus(void * Handle);
	__int64 __fastcall GetRowCount(void * Res);
	int __fastcall GetFieldCount(void * Res);
	char * __fastcall GetFieldName(void * Field);
	char * __fastcall GetFieldTable(void * Field);
	int __fastcall GetFieldLength(void * Field);
	int __fastcall GetFieldMaxLength(void * Field);
	int __fastcall GetFieldDecimals(void * Field);
	char * __fastcall GetFieldData(void * Row, unsigned Offset);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQL320PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZMySQLPlainDriver;	/* Zplainmysqldriver::IZMySQLPlainDriver */
	
public:
	operator IZMySQLPlainDriver*(void) { return (IZMySQLPlainDriver*)&__IZMySQLPlainDriver; }
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZMySQLPlainDriver; }
	
};


class DELPHICLASS TZMySQL323PlainDriver;
class PASCALIMPLEMENTATION TZMySQL323PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZMySQL323PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void __fastcall Debug(char * Debug);
	int __fastcall DumpDebugInfo(void * Handle);
	char * __fastcall GetLastError(void * Handle);
	int __fastcall GetLastErrorCode(void * Handle);
	void * __fastcall Init(void * &Handle);
	void __fastcall Despose(void * &Handle);
	void * __fastcall Connect(void * Handle, const char * Host, const char * User, const char * Password
		);
	void * __fastcall RealConnect(void * Handle, const char * Host, const char * User, const char * Password
		, const char * Db, unsigned Port, char * UnixSocket, unsigned ClientFlag);
	void __fastcall Close(void * Handle);
	int __fastcall ExecQuery(void * Handle, const char * Query);
	int __fastcall ExecRealQuery(void * Handle, const char * Query, int Length);
	int __fastcall SelectDatabase(void * Handle, const char * Database);
	int __fastcall CreateDatabase(void * Handle, const char * Database);
	int __fastcall DropDatabase(void * Handle, const char * Database);
	int __fastcall Shutdown(void * Handle);
	int __fastcall Refresh(void * Handle, unsigned Options);
	int __fastcall Kill(void * Handle, int Pid);
	int __fastcall Ping(void * Handle);
	char * __fastcall GetStatInfo(void * Handle);
	int __fastcall SetOptions(void * Handle, TZMySQLOption Option, const char * Arg);
	unsigned __fastcall GetEscapeString(char * StrTo, char * StrFrom, unsigned Length);
	char * __fastcall GetServerInfo(void * Handle);
	char * __fastcall GetClientInfo(void);
	char * __fastcall GetHostInfo(void * Handle);
	unsigned __fastcall GetProtoInfo(void * Handle);
	unsigned __fastcall GetThreadId(void * Handle);
	void * __fastcall GetListDatabases(void * Handle, char * Wild);
	void * __fastcall GetListTables(void * Handle, const char * Wild);
	void * __fastcall GetListFields(void * Handle, const char * Table, const char * Wild);
	void * __fastcall GetListProcesses(void * Handle);
	void * __fastcall StoreResult(void * Handle);
	void * __fastcall UseResult(void * Handle);
	void __fastcall FreeResult(void * Res);
	unsigned __fastcall GetAffectedRows(void * Handle);
	void * __fastcall FetchRow(void * Res);
	Zcompatibility::PLongInt __fastcall FetchLengths(void * Res);
	void * __fastcall FetchField(void * Res);
	void __fastcall SeekData(void * Res, unsigned Offset);
	void * __fastcall SeekRow(void * Res, void * Row);
	unsigned __fastcall SeekField(void * Res, unsigned Offset);
	Byte __fastcall GetFieldType(void * Field);
	int __fastcall GetFieldFlags(void * Field);
	TZMySQLStatus __fastcall GetStatus(void * Handle);
	__int64 __fastcall GetRowCount(void * Res);
	int __fastcall GetFieldCount(void * Res);
	char * __fastcall GetFieldName(void * Field);
	char * __fastcall GetFieldTable(void * Field);
	int __fastcall GetFieldLength(void * Field);
	int __fastcall GetFieldMaxLength(void * Field);
	int __fastcall GetFieldDecimals(void * Field);
	char * __fastcall GetFieldData(void * Row, unsigned Offset);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQL323PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZMySQLPlainDriver;	/* Zplainmysqldriver::IZMySQLPlainDriver */
	
public:
	operator IZMySQLPlainDriver*(void) { return (IZMySQLPlainDriver*)&__IZMySQLPlainDriver; }
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZMySQLPlainDriver; }
	
};


class DELPHICLASS TZMySQL40PlainDriver;
class PASCALIMPLEMENTATION TZMySQL40PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZMySQL40PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void __fastcall Debug(char * Debug);
	int __fastcall DumpDebugInfo(void * Handle);
	char * __fastcall GetLastError(void * Handle);
	int __fastcall GetLastErrorCode(void * Handle);
	void * __fastcall Init(void * &Handle);
	void __fastcall Despose(void * &Handle);
	void * __fastcall Connect(void * Handle, const char * Host, const char * User, const char * Password
		);
	void * __fastcall RealConnect(void * Handle, const char * Host, const char * User, const char * Password
		, const char * Db, unsigned Port, char * UnixSocket, unsigned ClientFlag);
	void __fastcall Close(void * Handle);
	int __fastcall ExecQuery(void * Handle, const char * Query);
	int __fastcall ExecRealQuery(void * Handle, const char * Query, int Length);
	int __fastcall SelectDatabase(void * Handle, const char * Database);
	int __fastcall CreateDatabase(void * Handle, const char * Database);
	int __fastcall DropDatabase(void * Handle, const char * Database);
	int __fastcall Shutdown(void * Handle);
	int __fastcall Refresh(void * Handle, unsigned Options);
	int __fastcall Kill(void * Handle, int Pid);
	int __fastcall Ping(void * Handle);
	char * __fastcall GetStatInfo(void * Handle);
	int __fastcall SetOptions(void * Handle, TZMySQLOption Option, const char * Arg);
	unsigned __fastcall GetEscapeString(char * StrTo, char * StrFrom, unsigned Length);
	char * __fastcall GetServerInfo(void * Handle);
	char * __fastcall GetClientInfo(void);
	char * __fastcall GetHostInfo(void * Handle);
	unsigned __fastcall GetProtoInfo(void * Handle);
	unsigned __fastcall GetThreadId(void * Handle);
	void * __fastcall GetListDatabases(void * Handle, char * Wild);
	void * __fastcall GetListTables(void * Handle, const char * Wild);
	void * __fastcall GetListFields(void * Handle, const char * Table, const char * Wild);
	void * __fastcall GetListProcesses(void * Handle);
	void * __fastcall StoreResult(void * Handle);
	void * __fastcall UseResult(void * Handle);
	void __fastcall FreeResult(void * Res);
	unsigned __fastcall GetAffectedRows(void * Handle);
	void * __fastcall FetchRow(void * Res);
	Zcompatibility::PLongInt __fastcall FetchLengths(void * Res);
	void * __fastcall FetchField(void * Res);
	void __fastcall SeekData(void * Res, unsigned Offset);
	void * __fastcall SeekRow(void * Res, void * Row);
	unsigned __fastcall SeekField(void * Res, unsigned Offset);
	Byte __fastcall GetFieldType(void * Field);
	int __fastcall GetFieldFlags(void * Field);
	TZMySQLStatus __fastcall GetStatus(void * Handle);
	__int64 __fastcall GetRowCount(void * Res);
	int __fastcall GetFieldCount(void * Res);
	char * __fastcall GetFieldName(void * Field);
	char * __fastcall GetFieldTable(void * Field);
	int __fastcall GetFieldLength(void * Field);
	int __fastcall GetFieldMaxLength(void * Field);
	int __fastcall GetFieldDecimals(void * Field);
	char * __fastcall GetFieldData(void * Row, unsigned Offset);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZMySQL40PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZMySQLPlainDriver;	/* Zplainmysqldriver::IZMySQLPlainDriver */
	
public:
	operator IZMySQLPlainDriver*(void) { return (IZMySQLPlainDriver*)&__IZMySQLPlainDriver; }
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZMySQLPlainDriver; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Byte MYSQL_ERRMSG_SIZE = 0xc8;
static const Word MYSQL_PORT = 0xcea;
#define LOCAL_HOST "localhost"
static const Shortint NAME_LEN = 0x40;
static const Shortint PROTOCOL_VERSION = 0xa;
static const Shortint FRM_VER = 0x6;
static const Shortint FIELD_TYPE_DECIMAL = 0x0;
static const Shortint FIELD_TYPE_TINY = 0x1;
static const Shortint FIELD_TYPE_SHORT = 0x2;
static const Shortint FIELD_TYPE_LONG = 0x3;
static const Shortint FIELD_TYPE_FLOAT = 0x4;
static const Shortint FIELD_TYPE_DOUBLE = 0x5;
static const Shortint FIELD_TYPE_NULL = 0x6;
static const Shortint FIELD_TYPE_TIMESTAMP = 0x7;
static const Shortint FIELD_TYPE_LONGLONG = 0x8;
static const Shortint FIELD_TYPE_INT24 = 0x9;
static const Shortint FIELD_TYPE_DATE = 0xa;
static const Shortint FIELD_TYPE_TIME = 0xb;
static const Shortint FIELD_TYPE_DATETIME = 0xc;
static const Shortint FIELD_TYPE_YEAR = 0xd;
static const Shortint FIELD_TYPE_NEWDATE = 0xe;
static const Byte FIELD_TYPE_ENUM = 0xf7;
static const Byte FIELD_TYPE_SET = 0xf8;
static const Byte FIELD_TYPE_TINY_BLOB = 0xf9;
static const Byte FIELD_TYPE_MEDIUM_BLOB = 0xfa;
static const Byte FIELD_TYPE_LONG_BLOB = 0xfb;
static const Byte FIELD_TYPE_BLOB = 0xfc;
static const Byte FIELD_TYPE_VAR_STRING = 0xfd;
static const Byte FIELD_TYPE_STRING = 0xfe;
static const Byte FIELD_TYPE_GEOMETRY = 0xff;
static const Shortint FIELD_TYPE_CHAR = 0x1;
static const Byte FIELD_TYPE_INTERVAL = 0xf7;
static const Shortint NOT_NULL_FLAG = 0x1;
static const Shortint PRI_KEY_FLAG = 0x2;
static const Shortint UNIQUE_KEY_FLAG = 0x4;
static const Shortint MULTIPLE_KEY_FLAG = 0x8;
static const Shortint BLOB_FLAG = 0x10;
static const Shortint UNSIGNED_FLAG = 0x20;
static const Shortint ZEROFILL_FLAG = 0x40;
static const Byte BINARY_FLAG = 0x80;
static const Word ENUM_FLAG = 0x100;
static const Word AUTO_INCREMENT_FLAG = 0x200;
static const Word TIMESTAMP_FLAG = 0x400;
static const Word SET_FLAG = 0x800;
static const Word NUM_FLAG = 0x8000;
static const Word PART_KEY_FLAG = 0x4000;
static const Word GROUP_FLAG = 0x8000;
static const int UNIQUE_FLAG = 0x10000;
static const Shortint REFRESH_GRANT = 0x1;
static const Shortint REFRESH_LOG = 0x2;
static const Shortint REFRESH_TABLES = 0x4;
static const Shortint REFRESH_HOSTS = 0x8;
static const Shortint REFRESH_STATUS = 0x10;
static const Shortint REFRESH_THREADS = 0x20;
static const Shortint REFRESH_SLAVE = 0x40;
static const Byte REFRESH_MASTER = 0x80;
static const Word REFRESH_READ_LOCK = 0x4000;
static const Word REFRESH_FAST = 0x8000;
static const Shortint _CLIENT_LONG_PASSWORD = 0x1;
static const Shortint _CLIENT_FOUND_ROWS = 0x2;
static const Shortint _CLIENT_LONG_FLAG = 0x4;
static const Shortint _CLIENT_CONNECT_WITH_DB = 0x8;
static const Shortint _CLIENT_NO_SCHEMA = 0x10;
static const Shortint _CLIENT_COMPRESS = 0x20;
static const Shortint _CLIENT_ODBC = 0x40;
static const Byte _CLIENT_LOCAL_FILES = 0x80;
static const Word _CLIENT_IGNORE_SPACE = 0x100;
static const Word _CLIENT_CHANGE_USER = 0x200;
static const Word _CLIENT_INTERACTIVE = 0x400;
static const Word _CLIENT_SSL = 0x800;
static const Word _CLIENT_IGNORE_SIGPIPE = 0x1000;
static const Word _CLIENT_TRANSACTIONS = 0x2004;

}	/* namespace Zplainmysqldriver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainmysqldriver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainMySqlDriver
