// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainMySql40.pas' rev: 5.00

#ifndef ZPlainMySql40HPP
#define ZPlainMySql40HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainLoader.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainmysql40
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
enum TMySqlStatus { MYSQL_STATUS_READY, MYSQL_STATUS_GET_RESULT, MYSQL_STATUS_USE_RESULT };
#pragma option pop

#pragma option push -b-
enum TMySqlOption { MYSQL_OPT_CONNECT_TIMEOUT, MYSQL_OPT_COMPRESS, MYSQL_OPT_NAMED_PIPE, MYSQL_INIT_COMMAND, 
	MYSQL_READ_DEFAULT_FILE, MYSQL_READ_DEFAULT_GROUP, MYSQL_SET_CHARSET_DIR, MYSQL_SET_CHARSET_NAME, MYSQL_OPT_LOCAL_INFILE 
	};
#pragma option pop

#pragma option push -b-
enum TMySqlRplType { MYSQL_RPL_MASTER, MYSQL_RPL_SLAVE, MYSQL_RPL_ADMIN };
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
	int block_num;
	int first_block_usage;
	ERR_PROC *error_handler;
} ;
#pragma pack(pop)

#pragma pack(push, 1)
struct NET
{
	void *hPipe;
	char *buff;
	char *buff_end;
	char *write_pos;
	char *read_pos;
	int fd;
	unsigned max_packet;
	unsigned max_packet_size;
	unsigned last_errno;
	unsigned pkt_nr;
	unsigned compress_pkt_nr;
	unsigned write_timeout;
	unsigned read_timeout;
	unsigned retry_count;
	int fcntl;
	char last_error[200];
	char error;
	Byte return_errno;
	Byte compress;
	int remain_in_buf;
	int length;
	int buf_length;
	int where_b;
	void *return_status;
	char reading_or_writing;
	char save_char;
	Byte no_send_ok;
	void *query_cache_query;
} ;
#pragma pack(pop)

struct MYSQL_FIELD
{
	char *name;
	char *table;
	char *org_table;
	char *db;
	char *def;
	int length;
	int max_length;
	int flags;
	int decimals;
	Byte _type;
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
	unsigned connect_timeout;
	unsigned clientFlag;
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
	int max_allowed_packet;
	Byte use_ssl;
	Byte compress;
	Byte named_pipe;
	Byte rpl_probe;
	Byte rpl_parse;
	Byte no_master_reads;
} ;

typedef _MYSQL_OPTIONS *PMYSQL_OPTIONS;

struct MYSQL;
typedef MYSQL *PMYSQL;

struct MYSQL
{
	NET _net;
	void *connector_fd;
	char *host;
	char *user;
	char *passwd;
	char *unix_socket;
	char *server_version;
	char *host_info;
	char *info;
	char *db;
	char *charset;
	MYSQL_FIELD *fields;
	MEM_ROOT field_alloc;
	__int64 affected_rows;
	__int64 insert_id;
	__int64 extra_info;
	int thread_id;
	int packet_length;
	unsigned port;
	unsigned client_flag;
	unsigned server_capabilities;
	unsigned protocol_version;
	unsigned field_count;
	unsigned server_status;
	unsigned server_language;
	_MYSQL_OPTIONS options;
	TMySqlStatus status;
	Byte free_me;
	Byte reconnect;
	char scramble_buff[9];
	Byte rpl_pivot;
	MYSQL *master;
	MYSQL *next_slave;
	MYSQL *last_used_slave;
	MYSQL *last_used_con;
} ;

#pragma pack(push, 1)
struct MYSQL_RES
{
	__int64 row_count;
	MYSQL_FIELD *fields;
	MYSQL_DATA *data;
	MYSQL_ROWS *data_cursor;
	int *lengths;
	MYSQL *handle;
	MEM_ROOT field_alloc;
	int field_count;
	int current_field;
	char * *row;
	char * *current_row;
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

struct MYSQL_MANAGER
{
	NET _net;
	char *host;
	char *user;
	char *passwd;
	unsigned port;
	Byte free_me;
	Byte eof;
	int cmd_status;
	int last_errno;
	char *net_buf;
	char *net_buf_pos;
	char *net_data_end;
	int net_buf_size;
	char last_error[256];
} ;

typedef MYSQL_MANAGER *PMYSQL_MANAGER;

typedef void __stdcall (*Tmysql_debug)(char * Debug);

typedef int __stdcall (*Tmysql_dump_debug_info)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_server_init)(unsigned Argc, void * Argv, void * Groups);

typedef void __stdcall (*Tmysql_server_end)(void);

typedef PMYSQL __stdcall (*Tmysql_init)(PMYSQL Handle);

typedef PMYSQL __stdcall (*Tmysql_connect)(PMYSQL Handle, const char * Host, const char * User, const 
	char * Passwd);

typedef PMYSQL __stdcall (*Tmysql_real_connect)(PMYSQL Handle, const char * Host, const char * User, 
	const char * Passwd, const char * Db, unsigned Port, char * UnixSocket, unsigned ClientFlag);

typedef void __stdcall (*Tmysql_close)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_query)(PMYSQL Handle, const char * Query);

typedef int __stdcall (*Tmysql_real_query)(PMYSQL Handle, const char * Query, int Len);

typedef int __stdcall (*Tmysql_select_db)(PMYSQL Handle, const char * Db);

typedef int __stdcall (*Tmysql_create_db)(PMYSQL Handle, const char * Db);

typedef int __stdcall (*Tmysql_drop_db)(PMYSQL Handle, const char * Db);

typedef int __stdcall (*Tmysql_shutdown)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_refresh)(PMYSQL Handle, unsigned Options);

typedef int __stdcall (*Tmysql_kill)(PMYSQL Handle, int Pid);

typedef int __stdcall (*Tmysql_ping)(PMYSQL Handle);

typedef char * __stdcall (*Tmysql_stat)(PMYSQL Handle);

typedef int __stdcall (*Tmysql_options)(PMYSQL Handle, TMySqlOption Option, const char * Arg);

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

typedef Byte __stdcall (*Tmysql_thread_init)(void);

typedef void __stdcall (*Tmysql_thread_end)(void);

typedef int __stdcall (*Tmysql_ssl_set)(PMYSQL mysql, const char * key, const char * cert, const char * 
	ca, const char * capath, const char * cipher);

typedef Byte __stdcall (*Tmysql_change_user)(PMYSQL mysql, const char * user, const char * passwd, const 
	char * db);

typedef int __stdcall (*Tmysql_send_query)(PMYSQL mysql, const char * query, unsigned length);

typedef int __stdcall (*Tmysql_read_query_result)(PMYSQL mysql);

typedef int __stdcall (*Tmysql_master_query)(PMYSQL mysql, const char * query, unsigned length);

typedef int __stdcall (*Tmysql_master_send_query)(PMYSQL mysql, const char * query, unsigned length)
	;

typedef int __stdcall (*Tmysql_slave_query)(PMYSQL mysql, const char * query, unsigned length);

typedef int __stdcall (*Tmysql_slave_send_query)(PMYSQL mysql, const char * query, unsigned length);
	

typedef void __stdcall (*Tmysql_enable_rpl_parse)(PMYSQL mysql);

typedef void __stdcall (*Tmysql_disable_rpl_parse)(PMYSQL mysql);

typedef int __stdcall (*Tmysql_rpl_parse_enabled)(PMYSQL mysql);

typedef void __stdcall (*Tmysql_enable_reads_from_master)(PMYSQL mysql);

typedef void __stdcall (*Tmysql_disable_reads_from_master)(PMYSQL mysql);

typedef int __stdcall (*Tmysql_reads_from_master_enabled)(PMYSQL mysql);

typedef TMySqlRplType __stdcall (*Tmysql_rpl_query_type)(const char * query, int len);

typedef int __stdcall (*Tmysql_rpl_probe)(PMYSQL mysql);

typedef int __stdcall (*Tmysql_set_master)(PMYSQL mysql, const char * host, unsigned port, const char * 
	user, const char * passwd);

typedef int __stdcall (*Tmysql_add_slave)(PMYSQL mysql, const char * host, unsigned port, const char * 
	user, const char * passwd);

typedef unsigned __stdcall (*Tmysql_real_escape_string)(PMYSQL mysql, char * toStr, const char * fromStr
	, unsigned length);

typedef unsigned __stdcall (*Tmysql_thread_safe)(void);

typedef PMYSQL_MANAGER __stdcall (*Tmysql_manager_init)(PMYSQL_MANAGER con);

typedef PMYSQL_MANAGER __stdcall (*Tmysql_manager_connect)(PMYSQL_MANAGER con, const char * host, const 
	char * user, const char * passwd, unsigned port);

typedef void __stdcall (*Tmysql_manager_close)(PMYSQL_MANAGER con);

typedef int __stdcall (*Tmysql_manager_command)(PMYSQL_MANAGER con, const char * cmd, int cmd_len);

typedef int __stdcall (*Tmysql_manager_fetch_line)(PMYSQL_MANAGER con, char * res_buf, int res_buf_size
	);

//-- var, const, procedure ---------------------------------------------------
#define WINDOWS1_DLL_LOCATION "libmysql40.dll"
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
static const int REFRESH_QUERY_CACHE = 0x10000;
static const int REFRESH_QUERY_CACHE_FREE = 0x20000;
static const int REFRESH_DES_KEY_FILE = 0x40000;
static const int REFRESH_USER_RESOURCES = 0x80000;
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
static const Word _CLIENT_TRANSACTIONS = 0x2000;
static const Shortint NET_TYPE_TCPIP = 0x0;
static const Shortint NET_TYPE_SOCKET = 0x1;
static const Shortint NET_TYPE_NAMEDPIPE = 0x2;
static const Word MAX_MYSQL_MANAGER_ERR = 0x100;
static const Word MAX_MYSQL_MANAGER_MSG = 0x100;
static const Byte MANAGER_OK = 0xc8;
static const Byte MANAGER_INFO = 0xfa;
static const Word MANAGER_ACCESS = 0x191;
static const Word MANAGER_CLIENT_ERR = 0x1c2;
static const Word MANAGER_INTERNAL_ERR = 0x1f4;
extern PACKAGE Tmysql_debug mysql_debug;
extern PACKAGE Tmysql_dump_debug_info mysql_dump_debug_info;
extern PACKAGE Tmysql_server_init mysql_server_init;
extern PACKAGE Tmysql_server_end mysql_server_end;
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
extern PACKAGE Tmysql_thread_init mysql_thread_init;
extern PACKAGE Tmysql_thread_end mysql_thread_end;
extern PACKAGE Tmysql_ssl_set mysql_ssl_set;
extern PACKAGE Tmysql_change_user mysql_change_user;
extern PACKAGE Tmysql_send_query mysql_send_query;
extern PACKAGE Tmysql_read_query_result mysql_read_query_result;
extern PACKAGE Tmysql_master_query mysql_master_query;
extern PACKAGE Tmysql_master_send_query mysql_master_send_query;
extern PACKAGE Tmysql_slave_query mysql_slave_query;
extern PACKAGE Tmysql_slave_send_query mysql_slave_send_query;
extern PACKAGE Tmysql_enable_rpl_parse mysql_enable_rpl_parse;
extern PACKAGE Tmysql_disable_rpl_parse mysql_disable_rpl_parse;
extern PACKAGE Tmysql_rpl_parse_enabled mysql_rpl_parse_enabled;
extern PACKAGE Tmysql_enable_reads_from_master mysql_enable_reads_from_master;
extern PACKAGE Tmysql_disable_reads_from_master mysql_disable_reads_from_master;
extern PACKAGE Tmysql_reads_from_master_enabled mysql_reads_from_master_enabled;
extern PACKAGE Tmysql_rpl_query_type mysql_rpl_query_type;
extern PACKAGE Tmysql_rpl_probe mysql_rpl_probe;
extern PACKAGE Tmysql_set_master mysql_set_master;
extern PACKAGE Tmysql_add_slave mysql_add_slave;
extern PACKAGE Tmysql_real_escape_string mysql_real_escape_string;
extern PACKAGE Tmysql_thread_safe mysql_thread_safe;
extern PACKAGE Tmysql_manager_init mysql_manager_init;
extern PACKAGE Tmysql_manager_connect mysql_manager_connect;
extern PACKAGE Tmysql_manager_close mysql_manager_close;
extern PACKAGE Tmysql_manager_command mysql_manager_command;
extern PACKAGE Tmysql_manager_fetch_line mysql_manager_fetch_line;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;
extern PACKAGE unsigned __fastcall mysql_affected_rows(PMYSQL Handle);
extern PACKAGE unsigned __fastcall mysql_thread_id(PMYSQL Handle);

}	/* namespace Zplainmysql40 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainmysql40;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainMySql40
