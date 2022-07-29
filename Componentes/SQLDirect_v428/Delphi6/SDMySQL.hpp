// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDMySql.pas' rev: 6.00

#ifndef SDMySqlHPP
#define SDMySqlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdmysql
{
//-- type declarations -------------------------------------------------------
typedef char TMyBool;

typedef int TMySocket;

typedef char *TGPtr;

typedef char *PCHARSET_INFO;

typedef unsigned UInt;

typedef unsigned ULong;

#pragma option push -b
enum TServerCommand { COM_SLEEP, COM_QUIT, COM_INIT_DB, COM_QUERY, COM_FIELD_LIST, COM_CREATE_DB, COM_DROP_DB, COM_REFRESH, COM_SHUTDOWN, COM_STATISTICS, COM_PROCESS_INFO, COM_CONNECT, COM_PROCESS_KILL, COM_DEBUG, COM_PING, COM_TIME, COM_DELAYED_INSERT, COM_CHANGE_USER, COM_BINLOG_DUMP, COM_TABLE_DUMP, COM_CONNECT_OUT, COM_REGISTER_SLAVE, COM_END };
#pragma option pop

#pragma pack(push, 1)
struct TNET
{
	void *vio;
	int fd;
	int fcntl;
	char *buff;
	char *buff_end;
	char *write_pos;
	char *read_pos;
	char last_error[201];
	int last_errno;
	int max_packet;
	int timeout;
	int pkt_nr;
	char error;
	char return_errno;
	char compress;
	char no_send_ok;
	int remain_in_buf;
	int length;
	int buf_length;
	int where_b;
	int *return_status;
	char reading_or_writing;
	char save_char;
} ;
#pragma pack(pop)

typedef void __fastcall (*TOnMyErrorProc)(void);

typedef unsigned *PULong;

struct TUSED_MEM;
typedef TUSED_MEM *PUSED_MEM;

struct TMEM_ROOT;
typedef TMEM_ROOT *PMEM_ROOT;

typedef TOnMyErrorProc *POnMyErrorProc;

#pragma pack(push, 1)
struct TUSED_MEM
{
	TUSED_MEM *next;
	int left;
	int size;
} ;
#pragma pack(pop)

#pragma pack(push, 1)
struct TMEM_ROOT
{
	TUSED_MEM *free;
	TUSED_MEM *used;
	TUSED_MEM *pre_alloc;
	int min_malloc;
	int block_size;
	TOnMyErrorProc *error_handler;
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TMYSQL_FIELD_V3
{
	char *name;
	char *table;
	char *def;
	Byte ftype;
	int length;
	int max_length;
	int flags;
	int decimals;
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TMYSQL_FIELD_V4
{
	char *name;
	char *table;
	char *org_table;
	char *db;
	char *def;
	unsigned length;
	unsigned max_length;
	unsigned flags;
	unsigned decimals;
	Byte ftype;
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TMYSQL_FIELD_V41
{
	char *name;
	char *org_name;
	char *table;
	char *org_table;
	char *db;
	char *catalog;
	char *def;
	unsigned length;
	unsigned max_length;
	unsigned name_length;
	unsigned org_name_length;
	unsigned table_length;
	unsigned org_table_length;
	unsigned db_length;
	unsigned catalog_length;
	unsigned def_length;
	unsigned flags;
	unsigned decimals;
	unsigned charsetnr;
	Byte ftype;
} ;
#pragma pack(pop)

struct TMYSQL_V3;
typedef TMYSQL_V3 *PMYSQL_V3;

struct TMYSQL_V4;
typedef TMYSQL_V4 *PMYSQL_V4;

typedef TMYSQL_FIELD_V3 *PMYSQL_FIELD_V3;

typedef TMYSQL_FIELD_V4 *PMYSQL_FIELD_V4;

typedef char *TMYSQL_ROW[256];

typedef char * *PMYSQL_ROW;

typedef void *PMYSQL_FIELD;

typedef unsigned TMYSQL_FIELD_OFFSET;

typedef __int64 TMyInt64;

struct TMYSQL_ROWS;
typedef TMYSQL_ROWS *PMYSQL_ROWS;

struct TMYSQL_DATA;
typedef TMYSQL_DATA *PMYSQL_DATA;

#pragma pack(push, 4)
struct TMYSQL_ROWS
{
	TMYSQL_ROWS *next;
	char *data[256];
} ;
#pragma pack(pop)

typedef TMYSQL_ROWS *TMYSQL_ROW_OFFSET;

struct TMYSQL_DATA
{
	__int64 Rows;
	unsigned Fields;
	TMYSQL_ROWS *Data;
	TMEM_ROOT Alloc;
} ;

#pragma pack(push, 4)
struct TMYSQL_OPTIONS_V3
{
	unsigned connect_timeout;
	unsigned client_flag;
	char compress;
	char named_pipe;
	int port;
	char *host;
	char *init_command;
	char *user;
	char *password;
	char *unix_socket;
	char *db;
	char *my_cnf_file;
	char *my_cnf_group;
	char *charset_dir;
	char *charset_name;
	char use_ssl;
	char *ssl_key;
	char *ssl_cert;
	char *ssl_ca;
	char *ssl_capath;
} ;
#pragma pack(pop)

typedef TMYSQL_OPTIONS_V3 *PMYSQL_OPTIONS_V3;

#pragma pack(push, 4)
struct TMYSQL_OPTIONS_V4
{
	unsigned connect_timeout;
	unsigned client_flag;
	unsigned port;
	char *host;
	char *init_command;
	char *user;
	char *password;
	char *unix_socket;
	char *db;
	char *my_cnf_file;
	char *my_cnf_group;
	char *charset_dir;
	char *charset_name;
	char *ssl_key;
	char *ssl_cert;
	char *ssl_ca;
	char *ssl_capath;
	char *ssl_cipher;
	char use_ssl;
	char compress;
	char named_pipe;
	char rpl_probe;
	char rpl_parse;
	char no_master_reads;
} ;
#pragma pack(pop)

typedef TMYSQL_OPTIONS_V4 *PMYSQL_OPTIONS_V4;

typedef void *PMYSQL_OPTIONS;

#pragma option push -b
enum TMySqlOption { MYSQL_OPT_CONNECT_TIMEOUT, MYSQL_OPT_COMPRESS, MYSQL_OPT_NAMED_PIPE, MYSQL_INIT_COMMAND, MYSQL_READ_DEFAULT_FILE, MYSQL_READ_DEFAULT_GROUP, MYSQL_SET_CHARSET_DIR, MYSQL_SET_CHARSET_NAME, MYSQL_OPT_LOCAL_INFILE };
#pragma option pop

#pragma option push -b
enum TMySqlStatus { MYSQL_STATUS_READY, MYSQL_STATUS_GET_RESULT, MYSQL_STATUS_USE_RESULT };
#pragma option pop

#pragma option push -b
enum TMySqlRplType { MYSQL_RPL_MASTER, MYSQL_RPL_SLAVE, MYSQL_RPL_ADMIN };
#pragma option pop

struct TMYSQL_V3
{
	TNET net;
	char *connector_fd;
	char *host;
	char *user;
	char *passwd;
	char *unix_socket;
	char *server_version;
	char *host_info;
	char *info;
	char *db;
	int port;
	int client_flag;
	int server_capabilities;
	int protocol_version;
	int field_count;
	int server_status;
	int thread_id;
	__int64 affected_rows;
	__int64 insert_id;
	__int64 extra_info;
	int packet_length;
	TMySqlStatus status;
	TMYSQL_FIELD_V3 *fields;
	TMEM_ROOT field_alloc;
	char free_me;
	char reconnect;
	TMYSQL_OPTIONS_V3 options;
	char scramble_buff[9];
	char *charset;
	int server_language;
} ;

struct TMYSQL_V4
{
	TNET net;
	char *connector_fd;
	char *host;
	char *user;
	char *passwd;
	char *unix_socket;
	char *server_version;
	char *host_info;
	char *info;
	char *db;
	char *charset;
	TMYSQL_FIELD_V4 *fields;
	TMEM_ROOT field_alloc;
	__int64 affected_rows;
	__int64 insert_id;
	__int64 extra_info;
	unsigned thread_id;
	unsigned packet_length;
	unsigned port;
	unsigned client_flag;
	unsigned server_capabilities;
	unsigned protocol_version;
	unsigned field_count;
	unsigned server_status;
	unsigned server_language;
	TMYSQL_OPTIONS_V4 options;
	TMySqlStatus status;
	char free_me;
	char reconnect;
	char scramble_buff[9];
	char rpl_pivot;
	TMYSQL_V4 *master;
	TMYSQL_V4 *next_slave;
	TMYSQL_V4 *last_used_slave;
	TMYSQL_V4 *last_used_con;
} ;

typedef void *PMYSQL;

#pragma pack(push, 1)
struct TMYSQL_RES_V3
{
	__int64 row_count;
	int field_count;
	int current_field;
	TMYSQL_FIELD_V3 *fields;
	TMYSQL_DATA *data;
	TMYSQL_ROWS *data_cursor;
	TMEM_ROOT field_alloc;
	char *row[256];
	char *current_row[256];
	int *lengths;
	void *handle;
	char eof;
} ;
#pragma pack(pop)

typedef TMYSQL_RES_V3 *PMYSQL_RES_V3;

#pragma pack(push, 1)
struct TMYSQL_RES_V4
{
	__int64 row_count;
	TMYSQL_FIELD_V4 *fields;
	TMYSQL_DATA *data;
	TMYSQL_ROWS *data_cursor;
	unsigned *lengths;
	TMYSQL_V4 *handle;
	TMEM_ROOT field_alloc;
	unsigned field_count;
	unsigned current_field;
	char *row[256];
	char *current_row[256];
	char eof;
} ;
#pragma pack(pop)

typedef TMYSQL_RES_V4 *PMYSQL_RES_V4;

typedef void *PMYSQL_RES;

class DELPHICLASS ESDMySQLError;
class PASCALIMPLEMENTATION ESDMySQLError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDMySQLError(int AErrorCode, int ANativeError, const AnsiString Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDMySQLError(int AErrorCode, int ANativeError, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDMySQLError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDMySQLError(int Ident)/* overload */ : Sdcommon::ESDEngineError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDMySQLError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDMySQLError(const AnsiString Msg, int AHelpContext) : Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDMySQLError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDMySQLError(int Ident, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDMySQLError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDMySQLError(void) { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TIMyConnInfo
{
	Byte ServerType;
	void *MySQLPtr;
} ;
#pragma pack(pop)

class DELPHICLASS TIMyDatabase;
class PASCALIMPLEMENTATION TIMyDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	bool FIsEnableMoney;
	bool FIsClientVer3;
	void __fastcall Check(void * mysql);
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(void);
	void __fastcall ExecCmd(const AnsiString SQL, bool CheckRslt);
	void * __fastcall GetMySQLPtr(void);
	void __fastcall SetDefaultOptions(void);
	
protected:
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	
public:
	__fastcall virtual TIMyDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TIMyDatabase(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual AnsiString __fastcall GetAutoIncSQL();
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString();
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall TestConnected(void);
	__property void * MySQLPtr = {read=GetMySQLPtr};
	__property bool IsClientVer3 = {read=FIsClientVer3, nodefault};
	__property bool IsEnableMoney = {read=FIsEnableMoney, nodefault};
};


class DELPHICLASS TIMyCommand;
class PASCALIMPLEMENTATION TIMyCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void *FHandle;
	char * *FRow;
	int *FFieldLens;
	AnsiString FStmt;
	AnsiString FBindStmt;
	__int64 FRowsAffected;
	__int64 FAutoIncID;
	int FFirstCalcFieldIdx;
	bool __fastcall GetIsOpened(void);
	HIDESBASE TIMyDatabase* __fastcall GetSqlDatabase(void);
	AnsiString __fastcall CnvtDateTime2SqlString(System::TDateTime Value);
	AnsiString __fastcall CnvtFloat2SqlString(double Value);
	AnsiString __fastcall CnvtVarBytes2EscapeString(AnsiString Value);
	char * __fastcall GetFieldValue(int Index);
	void __fastcall InternalQBindParams(void);
	void __fastcall InternalQExecute(void);
	
protected:
	void __fastcall Check(short Status);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall SetFieldsBuffer(void);
	__property bool IsOpened = {read=GetIsOpened, nodefault};
	__property TIMyDatabase* SqlDatabase = {read=GetSqlDatabase};
	
public:
	__fastcall virtual TIMyCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TIMyCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual int __fastcall GetAutoIncValue(void);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
};


class DELPHICLASS TIMyCommandShowTables;
class PASCALIMPLEMENTATION TIMyCommandShowTables : public TIMyCommand 
{
	typedef TIMyCommand inherited;
	
private:
	AnsiString FTableNames;
	bool FIsSysTables;
	int FCatNameFieldIdx;
	int FSchNameFieldIdx;
	int FTblTypeFieldIdx;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIMyCommandShowTables(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property AnsiString TableNames = {read=FTableNames, write=FTableNames};
	__property bool IsSysTables = {read=FIsSysTables, write=FIsSysTables, nodefault};
public:
	#pragma option push -w-inl
	/* TIMyCommand.Destroy */ inline __fastcall virtual ~TIMyCommandShowTables(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIMyCommandShowColumns;
class PASCALIMPLEMENTATION TIMyCommandShowColumns : public TIMyCommand 
{
	typedef TIMyCommand inherited;
	
private:
	AnsiString FTableName;
	int FCatNameFieldIdx;
	int FSchNameFieldIdx;
	int FTblNameFieldIdx;
	int FColLenFieldIdx;
	int FColPrecFieldIdx;
	int FColScaleFieldIdx;
	int FColNullFieldIdx;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIMyCommandShowColumns(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property AnsiString TableName = {read=FTableName, write=FTableName};
public:
	#pragma option push -w-inl
	/* TIMyCommand.Destroy */ inline __fastcall virtual ~TIMyCommandShowColumns(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIMyCommandShowIndexes;
class PASCALIMPLEMENTATION TIMyCommandShowIndexes : public TIMyCommand 
{
	typedef TIMyCommand inherited;
	
private:
	AnsiString FTableName;
	int FCatNameFieldIdx;
	int FSchNameFieldIdx;
	int FIdxTypeFieldIdx;
	int FIdxFilterFieldIdx;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIMyCommandShowIndexes(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property AnsiString TableName = {read=FTableName, write=FTableName};
public:
	#pragma option push -w-inl
	/* TIMyCommand.Destroy */ inline __fastcall virtual ~TIMyCommandShowIndexes(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint NAME_LEN = 0x40;
static const Shortint HOSTNAME_LENGTH = 0x3c;
static const Shortint USERNAME_LENGTH = 0x10;
static const Shortint SERVER_VERSION_LENGTH = 0x3c;
#define LOCAL_HOST "localhost"
static const char LOCAL_HOST_NAMEDPIPE = '\x2e';
#define MYSQL_NAMEDPIPE "MySQL"
#define MYSQL_SERVICENAME "MySql"
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
static const int REFRESH_QUERY_CACHE = 0x10000;
static const int REFRESH_QUERY_CACHE_FREE = 0x20000;
static const int REFRESH_DES_KEY_FILE = 0x40000;
static const int REFRESH_USER_RESOURCES = 0x80000;
static const Shortint CLIENT_LONG_PASSWORD = 0x1;
static const Shortint CLIENT_FOUND_ROWS = 0x2;
static const Shortint CLIENT_LONG_FLAG = 0x4;
static const Shortint CLIENT_CONNECT_WITH_DB = 0x8;
static const Shortint CLIENT_NO_SCHEMA = 0x10;
static const Shortint CLIENT_COMPRESS = 0x20;
static const Shortint CLIENT_ODBC = 0x40;
static const Byte CLIENT_LOCAL_FILES = 0x80;
static const Word CLIENT_IGNORE_SPACE = 0x100;
static const Word CLIENT_CHANGE_USER = 0x200;
static const Word CLIENT_INTERACTIVE = 0x400;
static const Word CLIENT_SSL = 0x800;
static const Word CLIENT_IGNORE_SIGPIPE = 0x1000;
static const Word CLIENT_TRANSACTIONS = 0x2000;
static const Shortint SERVER_STATUS_IN_TRANS = 0x1;
static const Shortint SERVER_STATUS_AUTOCOMMIT = 0x2;
static const Byte MYSQL_ERRMSG_SIZE = 0xc8;
static const Shortint NET_READ_TIMEOUT = 0x1e;
static const Shortint NET_WRITE_TIMEOUT = 0x3c;
static const Word NET_WAIT_TIMEOUT = 0x7080;
static const Byte MAX_CHAR_WIDTH = 0xff;
static const Word MAX_BLOB_WIDTH = 0x2000;
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
extern PACKAGE __int64 __stdcall (*mysql_num_rows)(void * res);
extern PACKAGE int __stdcall (*mysql_num_fields)(void * res);
extern PACKAGE char __stdcall (*mysql_eof)(void * res);
extern PACKAGE void * __stdcall (*mysql_fetch_field_direct)(void * res, int fieldnr);
extern PACKAGE void * __stdcall (*mysql_fetch_fields)(void * res);
extern PACKAGE PMYSQL_ROWS __stdcall (*mysql_row_tell)(void * res);
extern PACKAGE int __stdcall (*mysql_field_tell)(void * res);
extern PACKAGE int __stdcall (*mysql_field_count)(void * mysql);
extern PACKAGE __int64 __stdcall (*mysql_affected_rows)(void * mysql);
extern PACKAGE __int64 __stdcall (*mysql_insert_id)(void * mysql);
extern PACKAGE int __stdcall (*mysql_errno)(void * mysql);
extern PACKAGE char * __stdcall (*mysql_error)(void * mysql);
extern PACKAGE char * __stdcall (*mysql_info)(void * mysql);
extern PACKAGE int __stdcall (*mysql_thread_id)(void * mysql);
extern PACKAGE char * __stdcall (*mysql_character_set_name)(void * mysql);
extern PACKAGE void * __stdcall (*mysql_init)(void * mysql);
extern PACKAGE int __stdcall (*mysql_ssl_set)(void * mysql, const char * key, const char * cert, const char * ca, const char * capath);
extern PACKAGE char * __stdcall (*mysql_ssl_cipher)(void * mysql);
extern PACKAGE int __stdcall (*mysql_ssl_clear)(void * mysql);
extern PACKAGE void * __stdcall (*mysql_connect)(void * mysql, const char * host, const char * user, const char * passwd);
extern PACKAGE char __stdcall (*mysql_change_user)(void * mysql, const char * user, const char * passwd, const char * db);
extern PACKAGE void * __stdcall (*mysql_real_connect)(void * mysql, const char * host, const char * user, const char * passwd, const char * db, int port, const char * unix_socket, int clientflag);
extern PACKAGE void __stdcall (*mysql_close)(void * sock);
extern PACKAGE int __stdcall (*mysql_select_db)(void * mysql, const char * db);
extern PACKAGE int __stdcall (*mysql_query)(void * mysql, const char * q);
extern PACKAGE int __stdcall (*mysql_send_query)(void * mysql, const char * q, int length);
extern PACKAGE int __stdcall (*mysql_read_query_result)(void * mysql);
extern PACKAGE int __stdcall (*mysql_real_query)(void * mysql, const char * q, int length);
extern PACKAGE int __stdcall (*mysql_create_db)(void * mysql, const char * DB);
extern PACKAGE int __stdcall (*mysql_drop_db)(void * mysql, const char * DB);
extern PACKAGE int __stdcall (*mysql_shutdown)(void * mysql);
extern PACKAGE int __stdcall (*mysql_dump_debug_info)(void * mysql);
extern PACKAGE int __stdcall (*mysql_refresh)(void * mysql, int refresh_options);
extern PACKAGE int __stdcall (*mysql_kill)(void * mysql, int pid);
extern PACKAGE int __stdcall (*mysql_ping)(void * mysql);
extern PACKAGE char * __stdcall (*mysql_stat)(void * mysql);
extern PACKAGE char * __stdcall (*mysql_get_server_info)(void * mysql);
extern PACKAGE char * __stdcall (*mysql_get_client_info)(void);
extern PACKAGE char * __stdcall (*mysql_get_host_info)(void * mysql);
extern PACKAGE int __stdcall (*mysql_get_proto_info)(void * mysql);
extern PACKAGE void * __stdcall (*mysql_list_dbs)(void * mysql, const char * wild);
extern PACKAGE void * __stdcall (*mysql_list_tables)(void * mysql, const char * wild);
extern PACKAGE void * __stdcall (*mysql_list_fields)(void * mysql, const char * table, const char * wild);
extern PACKAGE void * __stdcall (*mysql_list_processes)(void * mysql);
extern PACKAGE void * __stdcall (*mysql_store_result)(void * mysql);
extern PACKAGE void * __stdcall (*mysql_use_result)(void * mysql);
extern PACKAGE int __stdcall (*mysql_options)(void * mysql, TMySqlOption option, const char * arg);
extern PACKAGE void __stdcall (*mysql_free_result)(void * res);
extern PACKAGE void __stdcall (*mysql_data_seek)(void * res, __int64 offset);
extern PACKAGE PMYSQL_ROWS __stdcall (*mysql_row_seek)(void * res, PMYSQL_ROWS Row);
extern PACKAGE unsigned __stdcall (*mysql_field_seek)(void * res, unsigned offset);
extern PACKAGE PMYSQL_ROW __stdcall (*mysql_fetch_row)(void * res);
extern PACKAGE PLongint __stdcall (*mysql_fetch_lengths)(void * res);
extern PACKAGE PMYSQL_FIELD_V3 __stdcall (*mysql_fetch_field)(void * res);
extern PACKAGE int __stdcall (*mysql_escape_string)(char * szTo, const char * szFrom, int from_length);
extern PACKAGE int __stdcall (*mysql_real_escape_string)(void * mysql, char * szTo, const char * szFrom, int length);
extern PACKAGE void __stdcall (*mysql_debug)(const char * debug);
extern PACKAGE void __stdcall (*myodbc_remove_escape)(void * mysql, char * name);
extern PACKAGE int __stdcall (*mysql_thread_safe)(void);
extern PACKAGE int __stdcall (*mysql_server_init)(int argc, void * argv, void * groups);
extern PACKAGE void __stdcall (*mysql_server_end)(void);
extern PACKAGE char __stdcall (*mysql_thread_init)(void);
extern PACKAGE void __stdcall (*mysql_thread_end)(void);
#define DefSqlApiDLL "libmysql.dll"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdmysql */
using namespace Sdmysql;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDMySql
