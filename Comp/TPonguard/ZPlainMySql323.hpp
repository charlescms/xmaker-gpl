// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainMySql323.pas' rev: 5.00

#ifndef ZPlainMySql323HPP
#define ZPlainMySql323HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainLoader.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainmysql323
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TClientCapabilities { CLIENT_LONG_PASSWORD, CLIENT_FOUND_ROWS, CLIENT_LONG_FLAG, CLIENT_CONNECT_WITH_DB, 
	CLIENT_NO_SCHEMA, CLIENT_COMPRESS, CLIENT_ODBC, CLIENT_LOCAL_FILES, CLIENT_IGNORE_SPACE };
#pragma option pop

typedef Set<TClientCapabilities, CLIENT_LONG_PASSWORD, CLIENT_IGNORE_SPACE>  TSetClientCapabilities;
	

#pragma option push -b-
enum TRefreshOptions { _REFRESH_GRANT, _REFRESH_LOG, _REFRESH_TABLES, _REFRESH_HOSTS, _REFRESH_FAST 
	};
#pragma option pop

typedef Set<TRefreshOptions, _REFRESH_GRANT, _REFRESH_FAST>  TSetRefreshOptions;

#pragma option push -b-
enum mysql_status { MYSQL_STATUS_READY, MYSQL_STATUS_GET_RESULT, MYSQL_STATUS_USE_RESULT };
#pragma option pop

#pragma option push -b-
enum mysql_option { MYSQL_OPT_CONNECT_TIMEOUT, MYSQL_OPT_COMPRESS, MYSQL_OPT_NAMED_PIPE, MYSQL_INIT_COMMAND, 
	MYSQL_READ_DEFAULT_FILE, MYSQL_READ_DEFAULT_GROUP, MYSQL_SET_CHARSET_DIR, MYSQL_SET_CHARSET_NAME };
	
#pragma option pop

struct USED_MEM;
typedef USED_MEM *PUSED_MEM;

#pragma pack(push, 1)
struct USED_MEM
{
	USED_MEM *next;
	int left;
	int size;
} ;
#pragma pack(pop)

typedef void __fastcall (*ERR_PROC)(void);

typedef ERR_PROC *PERR_PROC;

struct MEM_ROOT;
typedef MEM_ROOT *PMEM_ROOT;

#pragma pack(push, 1)
struct MEM_ROOT
{
	USED_MEM *free;
	USED_MEM *used;
	USED_MEM *pre_alloc;
	int min_malloc;
	int block_size;
	ERR_PROC *error_handler;
} ;
#pragma pack(pop)

#pragma pack(push, 1)
struct NET
{
	void *hPipe;
	int fd;
	int fcntl;
	char *buff;
	char *buff_end;
	char *write_pos;
	char *read_pos;
	char last_error[200];
	int last_errno;
	int max_packet;
	int timeout;
	int pkt_nr;
	char error;
	Byte return_errno;
	Byte compress;
	Byte no_send_ok;
	int remain_in_buf;
	int length;
	int buf_length;
	int where_b;
	void *return_status;
	char reading_or_writing;
	char save_char;
} ;
#pragma pack(pop)

struct MYSQL_FIELD
{
	char *name;
	char *table;
	char *def;
	Byte _type;
	int length;
	int max_length;
	int flags;
	int decimals;
} ;

typedef MYSQL_FIELD *PMYSQL_FIELD;

typedef unsigned MYSQL_FIELD_OFFSET;

typedef char *MYSQL_ROW[256];

typedef char * *PMYSQL_ROW;

struct MYSQL_ROWS;
typedef MYSQL_ROWS *PMYSQL_ROWS;

struct MYSQL_ROWS
{
	MYSQL_ROWS *next;
	char * *data;
} ;

typedef MYSQL_ROWS *MYSQL_ROW_OFFSET;

struct MYSQL_DATA
{
	__int64 Rows;
	unsigned Fields;
	MYSQL_ROWS *Data;
	MEM_ROOT Alloc;
} ;

typedef MYSQL_DATA *PMYSQL_DATA;

struct _MYSQL_OPTIONS
{
	int connect_timeout;
	int clientFlag;
	Byte compress;
	Byte named_pipe;
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
	Byte use_ssl;
	char *ssl_key;
	char *ssl_cert;
	char *ssl_ca;
	char *ssl_capath;
} ;

typedef _MYSQL_OPTIONS *PMYSQL_OPTIONS;

struct MYSQL
{
	NET _net;
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
	mysql_status status;
	MYSQL_FIELD *fields;
	MEM_ROOT field_alloc;
	Byte free_me;
	Byte reconnect;
	_MYSQL_OPTIONS options;
	char scramble_buff[9];
	char *charset;
	int server_language;
} ;

typedef MYSQL *PMYSQL;

#pragma pack(push, 1)
struct MYSQL_RES
{
	__int64 row_count;
	int field_count;
	int current_field;
	MYSQL_FIELD *fields;
	MYSQL_DATA *data;
	MYSQL_ROWS *data_cursor;
	MEM_ROOT field_alloc;
	char * *row;
	char * *current_row;
	int *lengths;
	MYSQL *handle;
	Byte eof;
} ;
#pragma pack(pop)

typedef MYSQL_RES *PMYSQL_RES;

#pragma option push -b-
enum TModifyType { MODIFY_INSERT, MODIFY_UPDATE, MODIFY_DELETE };
#pragma option pop

#pragma option push -b-
enum TQuoteOptions { QUOTE_STRIP_CR, QUOTE_STRIP_LF };
#pragma option pop

typedef Set<TQuoteOptions, QUOTE_STRIP_CR, QUOTE_STRIP_LF>  TQuoteOptionsSet;

typedef void __fastcall (*Tmysql_debug)(char * Debug);

typedef int __fastcall (*Tmysql_dump_debug_info)(PMYSQL Handle);

typedef PMYSQL __stdcall (*Tmysql_init)(PMYSQL Handle);

typedef PMYSQL __stdcall (*Tmysql_connect)(PMYSQL Handle, const char * Host, const char * User, const 
	char * Passwd);

typedef PMYSQL __stdcall (*Tmysql_real_connect)(PMYSQL Handle, const char * Host, const char * User, 
	const char * Passwd, const char * Db, unsigned Port, char * unix_socket, unsigned clientflag);

typedef void __stdcall (*Tmysql_close)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_query)(PMYSQL Handle, const char * Query);

typedef int __stdcall (*Tmysql_real_query)(PMYSQL Handle, const char * Query, int len);

typedef int __stdcall (*Tmysql_select_db)(PMYSQL Handle, const char * Db);

typedef int __stdcall (*Tmysql_create_db)(PMYSQL Handle, const char * Db);

typedef int __stdcall (*Tmysql_drop_db)(PMYSQL Handle, const char * Db);

typedef int __stdcall (*Tmysql_shutdown)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_refresh)(PMYSQL Handle, unsigned Options);

typedef int __stdcall (*Tmysql_kill)(PMYSQL Handle, int Pid);

typedef int __stdcall (*Tmysql_ping)(PMYSQL Handle);

typedef char * __stdcall (*Tmysql_stat)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_options)(PMYSQL Handle, mysql_option Option, const char * Arg);

typedef unsigned __stdcall (*Tmysql_escape_string)(char * PTo, char * PFrom, unsigned Len);

typedef char * __stdcall (*Tmysql_get_server_info)(PMYSQL Handle);

typedef char * __stdcall (*Tmysql_get_client_info)(void);

typedef char * __stdcall (*Tmysql_get_host_info)(PMYSQL Handle);

typedef unsigned __stdcall (*Tmysql_get_proto_info)(PMYSQL Handle);

typedef PMYSQL_RES __stdcall (*Tmysql_list_dbs)(PMYSQL Handle, char * Wild);

typedef PMYSQL_RES __stdcall (*Tmysql_list_tables)(PMYSQL Handle, const char * Wild);

typedef PMYSQL_RES __stdcall (*Tmysql_list_fields)(PMYSQL Handle, const char * Table, const char * Wild
	);

typedef PMYSQL_RES __stdcall (*Tmysql_list_processes)(PMYSQL Handle);

typedef PMYSQL_RES __stdcall (*Tmysql_store_result)(PMYSQL Handle);

typedef PMYSQL_RES __stdcall (*Tmysql_use_result)(PMYSQL Handle);

typedef void __stdcall (*Tmysql_free_result)(PMYSQL_RES Result);

typedef PMYSQL_ROW __stdcall (*Tmysql_fetch_row)(PMYSQL_RES Result);

typedef Zcompatibility::PLongInt __stdcall (*Tmysql_fetch_lengths)(PMYSQL_RES Result);

typedef PMYSQL_FIELD __stdcall (*Tmysql_fetch_field)(PMYSQL_RES Result);

typedef void __stdcall (*Tmysql_data_seek)(PMYSQL_RES Result, __int64 Offset);

typedef PMYSQL_ROWS __stdcall (*Tmysql_row_seek)(PMYSQL_RES Result, PMYSQL_ROWS Row);

typedef unsigned __stdcall (*Tmysql_field_seek)(PMYSQL_RES Result, unsigned Offset);

//-- var, const, procedure ---------------------------------------------------
#define WINDOWS1_DLL_LOCATION "libmysql323.dll"
#define LINUX_DLL_LOCATION "libmysqlclient.so"
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
static const Shortint NET_TYPE_TCPIP = 0x0;
static const Shortint NET_TYPE_SOCKET = 0x1;
static const Shortint NET_TYPE_NAMEDPIPE = 0x2;
extern PACKAGE Tmysql_debug mysql_debug;
extern PACKAGE Tmysql_dump_debug_info mysql_dump_debug_info;
extern PACKAGE Tmysql_init mysql_init;
extern PACKAGE Tmysql_connect mysql_connect;
extern PACKAGE Tmysql_real_connect mysql_real_connect;
extern PACKAGE Tmysql_close mysql_close;
extern PACKAGE Tmysql_select_db mysql_select_db;
extern PACKAGE Tmysql_create_db mysql_create_db;
extern PACKAGE Tmysql_drop_db mysql_drop_db;
extern PACKAGE Tmysql_query mysql_query;
extern PACKAGE Tmysql_query mysql_real_query;
extern PACKAGE Tmysql_shutdown mysql_shutdown;
extern PACKAGE Tmysql_refresh mysql_refresh;
extern PACKAGE Tmysql_kill mysql_kill;
extern PACKAGE Tmysql_ping mysql_ping;
extern PACKAGE Tmysql_stat mysql_stat;
extern PACKAGE Tmysql_options mysql_options;
extern PACKAGE Tmysql_escape_string mysql_escape_string;
extern PACKAGE Tmysql_get_server_info mysql_get_server_info;
extern PACKAGE Tmysql_get_client_info mysql_get_client_info;
extern PACKAGE Tmysql_get_host_info mysql_get_host_info;
extern PACKAGE Tmysql_get_proto_info mysql_get_proto_info;
extern PACKAGE Tmysql_list_dbs mysql_list_dbs;
extern PACKAGE Tmysql_list_tables mysql_list_tables;
extern PACKAGE Tmysql_list_fields mysql_list_fields;
extern PACKAGE Tmysql_list_processes mysql_list_processes;
extern PACKAGE Tmysql_data_seek mysql_data_seek;
extern PACKAGE Tmysql_row_seek mysql_row_seek;
extern PACKAGE Tmysql_field_seek mysql_field_seek;
extern PACKAGE Tmysql_fetch_row mysql_fetch_row;
extern PACKAGE Tmysql_fetch_lengths mysql_fetch_lengths;
extern PACKAGE Tmysql_fetch_field mysql_fetch_field;
extern PACKAGE Tmysql_store_result mysql_store_result;
extern PACKAGE Tmysql_use_result mysql_use_result;
extern PACKAGE Tmysql_free_result mysql_free_result;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;
extern PACKAGE unsigned __fastcall mysql_affected_rows(PMYSQL Handle);
extern PACKAGE unsigned __fastcall mysql_thread_id(PMYSQL Handle);

}	/* namespace Zplainmysql323 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainmysql323;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainMySql323
