
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{	MySQL API Interface Unit			}
{       MySQL API ver.3.23.36 (Date: 23.03.2001)        }
{       MySQL API ver.4.00.12 (Date: 15.03.2003)        }
{       MySQL API ver.4.1.7   (Date: 25.10.2004)        }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDMySql {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, Registry, SyncObjs,
{$IFDEF SD_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  SDConsts, SDCommon;

{*******************************************************************************
*	mysql_com.h - Common definition between mysql server & client          *
*******************************************************************************}

const
  NAME_LEN		= 64;		// Field/table name length
  HOSTNAME_LENGTH  	= 60;
  USERNAME_LENGTH	= 16;
  SERVER_VERSION_LENGTH = 60;

  LOCAL_HOST		= 'localhost';
  LOCAL_HOST_NAMEDPIPE 	= '.';

  MYSQL_NAMEDPIPE     	= 'MySQL';
  MYSQL_SERVICENAME	= 'MySql';

type
  TMyBool	= Char;
  TMySocket	= Integer;
  TGPtr		= TSDCharPtr;
  PCHARSET_INFO	= TSDCharPtr;

  UInt                 	= Cardinal;   	{ 32 bit unsigned }
  ULong                	= Cardinal;   	{ 32 bit unsigned }

  TServerCommand	= (
  	COM_SLEEP,COM_QUIT,COM_INIT_DB,COM_QUERY,
        COM_FIELD_LIST,COM_CREATE_DB,COM_DROP_DB,COM_REFRESH,
        COM_SHUTDOWN,COM_STATISTICS,
        COM_PROCESS_INFO,COM_CONNECT,COM_PROCESS_KILL,
        COM_DEBUG,COM_PING,COM_TIME,COM_DELAYED_INSERT,
        COM_CHANGE_USER, COM_BINLOG_DUMP,
        COM_TABLE_DUMP, COM_CONNECT_OUT, COM_REGISTER_SLAVE,
        COM_END
  );

const
  NOT_NULL_FLAG		= 1;		// Field can't be NULL
  PRI_KEY_FLAG		= 2;		// Field is part of a primary key
  UNIQUE_KEY_FLAG	= 4;		// Field is part of a unique key
  MULTIPLE_KEY_FLAG	= 8;		// Field is part of a key
  BLOB_FLAG    		= 16;		// Field is a blob
  UNSIGNED_FLAG		= 32;		// Field is unsigned
  ZEROFILL_FLAG		= 64;		// Field is zerofill
  BINARY_FLAG  		= 128;
	// The following are only sent to new clients
  ENUM_FLAG    		= 256;		// field is an enum
  AUTO_INCREMENT_FLAG	= 512;		// field is a autoincrement field
  TIMESTAMP_FLAG 	= 1024;		// Field is a timestamp
  SET_FLAG    		= 2048;		// field is a set
  NUM_FLAG    		= 32768;	// Field is num (for clients)
  PART_KEY_FLAG		= 16384;	// Intern; Part of some key
  GROUP_FLAG   		= 32768;	// Intern: Group field
  UNIQUE_FLAG  		= 65536;	// Intern: Used by sql_yacc

  REFRESH_GRANT		= 1;		// Refresh grant tables
  REFRESH_LOG  		= 2;		// Start on new log file
  REFRESH_TABLES	= 4;		// close all tables
  REFRESH_HOSTS		= 8;		// Flush host cache
  REFRESH_STATUS	= 16;		// Flush status variables
  REFRESH_THREADS	= 32;		// Flush status variables
  REFRESH_SLAVE         = 64;     	// Reset master info and restart slave thread
  REFRESH_MASTER        = 128;     	// Remove all bin logs in the index and truncate the index

	// The following can't be set with mysql_refresh()
  REFRESH_READ_LOCK	= 16384;	// Lock tables for read
  REFRESH_FAST	       	= 32768;	// Intern flag

	// RESET (remove all queries) from query cache
  REFRESH_QUERY_CACHE	= 65536;
  REFRESH_QUERY_CACHE_FREE= $20000; // pack query cache
  REFRESH_DES_KEY_FILE	= $40000;
  REFRESH_USER_RESOURCES= $80000;

  CLIENT_LONG_PASSWORD	= 1;		// new more secure passwords
  CLIENT_FOUND_ROWS	= 2;		// Found instead of affected rows
  CLIENT_LONG_FLAG	= 4;		// Get all column flags
  CLIENT_CONNECT_WITH_DB= 8;		// One can specify db on connect
  CLIENT_NO_SCHEMA	= 16;		// Don't allow database.table.column
  CLIENT_COMPRESS	= 32;		// Can use compression protocol
  CLIENT_ODBC		= 64;		// Odbc client
  CLIENT_LOCAL_FILES	= 128;		// Can use LOAD DATA LOCAL
  CLIENT_IGNORE_SPACE	= 256;		// Ignore spaces before '('
  CLIENT_CHANGE_USER	= 512;		// Support the mysql_change_user()
  CLIENT_INTERACTIVE	= 1024;		// This is an interactive client
  CLIENT_SSL            = 2048; 	// Switch to SSL after handshake
  CLIENT_IGNORE_SIGPIPE = 4096; 	// IGNORE sigpipes
  CLIENT_TRANSACTIONS	= 8192;		// Client knows about transactions

  SERVER_STATUS_IN_TRANS  = 1;		// Transaction has started
  SERVER_STATUS_AUTOCOMMIT= 2;		// Server in auto_commit mode

  MYSQL_ERRMSG_SIZE	= 200;
  NET_READ_TIMEOUT	= 30;		// Timeout on read
  NET_WRITE_TIMEOUT	= 60;		// Timeout on write
  NET_WAIT_TIMEOUT	= 8*60*60;	// Wait for new query

  MAX_CHAR_WIDTH	= 255;		// Max length for a CHAR colum
  MAX_BLOB_WIDTH	= 8192;		// Default width for blob

type
  TNET = packed record
    vio:           TSDPtr;
    fd:            TMySocket;
    fcntl:         Integer;		// For Perl DBI/dbd
    buff:          TSDCharPtr;
    buff_end:      TSDCharPtr;
    write_pos:     TSDCharPtr;
    read_pos:      TSDCharPtr;
    last_error:    array[0..MYSQL_ERRMSG_SIZE] of Char;
    last_errno:    Integer;
    max_packet:    Integer;
    timeout:       Integer;
    pkt_nr:        Integer;
    error:         Char;
    return_errno:  TMyBool;
    compress:      TMyBool;
    no_send_ok:    TMyBool;	// needed if we are doing several queries in one command ( as in LOAD TABLE ... FROM MASTER ),
   				// and do not want to confuse the client with OK at the wrong time
    remain_in_buf: LongInt;
    length:        LongInt;
    buf_length:    LongInt;
    where_b:       LongInt;
    return_status: PInteger;
    reading_or_writing: Char;
    save_char:     Char;
  end;

const
	// Enum Field Types
  FIELD_TYPE_DECIMAL   = 0;
  FIELD_TYPE_TINY      = 1;
  FIELD_TYPE_SHORT     = 2;
  FIELD_TYPE_LONG      = 3;
  FIELD_TYPE_FLOAT     = 4;
  FIELD_TYPE_DOUBLE    = 5;
  FIELD_TYPE_NULL      = 6;
  FIELD_TYPE_TIMESTAMP = 7;
  FIELD_TYPE_LONGLONG  = 8;
  FIELD_TYPE_INT24     = 9;
  FIELD_TYPE_DATE      = 10;
  FIELD_TYPE_TIME      = 11;
  FIELD_TYPE_DATETIME  = 12;
  FIELD_TYPE_YEAR      = 13;
  FIELD_TYPE_NEWDATE   = 14;
  FIELD_TYPE_ENUM      = 247;
  FIELD_TYPE_SET       = 248;
  FIELD_TYPE_TINY_BLOB = 249;
  FIELD_TYPE_MEDIUM_BLOB = 250;
  FIELD_TYPE_LONG_BLOB = 251;
  FIELD_TYPE_BLOB      = 252;
  FIELD_TYPE_VAR_STRING= 253;
  FIELD_TYPE_STRING    = 254;
  FIELD_TYPE_GEOMETRY  = 255;

	// For Compatibility
  FIELD_TYPE_CHAR      = FIELD_TYPE_TINY;
  FIELD_TYPE_INTERVAL  = FIELD_TYPE_ENUM;


{*******************************************************************************
*	mysql.h - defines for the libmysql library                             *
*******************************************************************************}

type
  TOnMyErrorProc = procedure;
{$IFDEF SD_CLR}
  PULong	= TSDPtr;
  PUSED_MEM	= TSDPtr;
  PMEM_ROOT 	= TSDPtr;
  POnMyErrorProc= TSDPtr;
{$ELSE}
  PULong	= ^ULong;
  PUSED_MEM	= ^TUSED_MEM;
  PMEM_ROOT 	= ^TMEM_ROOT;
  POnMyErrorProc = ^TOnMyErrorProc;
{$ENDIF}

  TUSED_MEM	= packed record		// struct for once_alloc
    next:       PUSED_MEM;              // Next block in use
    left:       Integer;                // memory left in block
    size:       Integer;                // size of block
  end;

  TMEM_ROOT 	= packed record
    free:          PUSED_MEM;
    used:          PUSED_MEM;
    pre_alloc:     PUSED_MEM;
    min_malloc:    Integer;
    block_size:    Integer;
    error_handler: POnMyErrorProc;
  end;


(*
// extern unsigned int mysql_port;
// extern char *mysql_unix_port;

 #define IS_PRI_KEY(n)	((n) & PRI_KEY_FLAG)
 #define IS_NOT_NULL(n)	((n) & NOT_NULL_FLAG)
 #define IS_BLOB(n)	((n) & BLOB_FLAG)
 #define IS_NUM(t)	((t) <= FIELD_TYPE_INT24 || (t) == FIELD_TYPE_YEAR)
 #define IS_NUM_FIELD(f)	 ((f)->flags & NUM_FLAG)
 #define INTERNAL_NUM_FIELD(f) (((f)->type <= FIELD_TYPE_INT24 && ((f)->type != FIELD_TYPE_TIMESTAMP || (f)->length == 14 || (f)->length == 8)) || (f)->type == FIELD_TYPE_YEAR)
*)

  TMYSQL_FIELD_V3 = record
    name:       TSDCharPtr;		// Name of column
    table:      TSDCharPtr;          // Table of column if column was a field
    def:        TSDCharPtr;          // Default value (set by mysql_list_fields)
    ftype:      Byte;           // Type of field. Se mysql_com.h for types
    length:     Integer;        // Width of column
    max_length: Integer;        // Max width of selected set
    flags:      Integer;        // Div flags
    decimals:   Integer;        // Number of decimals in field
  end;

  TMYSQL_FIELD_V4 = record
    name:       TSDCharPtr;		// Name of column
    table:      TSDCharPtr;          // Table of column if column was a field
    org_table:	TSDCharPtr;		// Org table name if table was an alias
    db:		TSDCharPtr;		// Database for table
    def:        TSDCharPtr;          // Default value (set by mysql_list_fields)
    length:     ULong;        	// Width of column
    max_length: ULong;        	// Max width of selected set
    flags:      UInt;        	// Div flags
    decimals:   UInt;        	// Number of decimals in field
    ftype:      Byte;           // Type(enum in C decl.) of field. Se mysql_com.h for types
  end;

  TMYSQL_FIELD_V41 = record
    name:	TSDCharPtr;             // Name of column
    org_name:	TSDCharPtr;             // Original column name, if an alias
    table:	TSDCharPtr;             // Table of column if column was a field
    org_table:	TSDCharPtr;             // Org table name, if table was an alias
    db:	        TSDCharPtr;             // Database for table
    catalog:	TSDCharPtr;	        // Catalog for table
    def:	TSDCharPtr;             // Default value (set by mysql_list_fields)
    length:     ULong;                  // Width of column (create length)
    max_length: ULong;                  // Max width for selected set
    name_length:        UInt;
    org_name_length:    UInt;
    table_length:       UInt;
    org_table_length:   UInt;
    db_length:          UInt;
    catalog_length:     UInt;
    def_length:         UInt;
    flags:              UInt;           // Div flags
    decimals:           UInt;           // Number of decimals in field
    charsetnr:          UInt;           // Character set
    ftype:      Byte;                   // Type of field. See mysql_com.h for types
  end;

{$IFDEF SD_CLR}
  PMYSQL_V3 	= TSDPtr;
  PMYSQL_V4 	= TSDPtr;
  PMYSQL_FIELD_V3 = TSDPtr;
  PMYSQL_FIELD_V4 = TSDPtr;
  PMYSQL_ROW 	= TSDPtr;
{$ELSE}
  PMYSQL_V3 	= ^TMYSQL_V3;
  PMYSQL_V4 	= ^TMYSQL_V4;
  PMYSQL_FIELD_V3 = ^TMYSQL_FIELD_V3;
  PMYSQL_FIELD_V4 = ^TMYSQL_FIELD_V4;
  PMYSQL_ROW 	= ^TMYSQL_ROW;
{$ENDIF}

  PMYSQL_FIELD	= TSDPtr;

  TMYSQL_ROW = array[00..$FF] of TSDCharPtr;	// return data as array of pointers to strings
  TMYSQL_FIELD_OFFSET = UInt;	// offset to current field


(*
 #if defined(NO_CLIENT_LONG_LONG)
 typedef unsigned long my_ulonglong;
 #elif defined (__WIN__)
 typedef unsigned __int64 my_ulonglong;
 #else
 typedef unsigned long long my_ulonglong;
 #endif
 #define MYSQL_COUNT_ERROR (~(my_ulonglong) 0)
*)

  TMyInt64 = TInt64;
{$IFDEF SD_CLR}
  PMYSQL_ROWS = TSDPtr;
  PMYSQL_DATA = TSDPtr;
{$ELSE}
  PMYSQL_ROWS = ^TMYSQL_ROWS;
  PMYSQL_DATA = ^TMYSQL_DATA;
{$ENDIF}

  TMYSQL_ROWS = record
    next:       PMYSQL_ROWS;		// list of rows
    data:       TMYSQL_ROW;
  end;

  TMYSQL_ROW_OFFSET = PMYSQL_ROWS;	// offset to current row

  TMYSQL_DATA = record
    Rows:       TMyInt64;
    Fields:     UInt;
    Data:       PMYSQL_ROWS;
    Alloc:      TMEM_ROOT;
  end;

  TMYSQL_OPTIONS_V3 = record
    connect_timeout, client_flag:     	UInt;
    compress, named_pipe:      		TMyBool;
    port: 				Integer;
    host, init_command, user, password,
    unix_socket, db,
    my_cnf_file, my_cnf_group,
    charset_dir, charset_name:    	TSDCharPtr;
    use_ssl:         TMyBool;		// if to use SSL or not
    ssl_key,                            // PEM key file
    ssl_cert,                           // PEM cert file
    ssl_ca,                             // PEM CA file
    ssl_capath:      TSDCharPtr;             // PEM directory of CA-s?
  end;
  PMYSQL_OPTIONS_V3 = ^TMYSQL_OPTIONS_V3;

  TMYSQL_OPTIONS_V4 = record
    connect_timeout, client_flag, port:	UInt;
    host, init_command, user, password,
    unix_socket, db,
    my_cnf_file, my_cnf_group,
    charset_dir, charset_name:    	TSDCharPtr;
    ssl_key,                            // PEM key file
    ssl_cert,                           // PEM cert file
    ssl_ca,                             // PEM CA file
    ssl_capath,                   	// PEM directory of CA-s?
    ssl_cipher:	     TSDCharPtr;     	// cipher to use
    use_ssl:         TMyBool;		// if to use SSL or not
    compress, named_pipe:      		TMyBool;
    rpl_probe,           		// On connect, find out the replication role of the server, and establish connections to all the peers
    rpl_parse,                          // Each call to mysql_real_query() will parse it to tell if it is a read or a write, and direct it to the slave or the master
    no_master_reads: TMyBool;           // If set, never read from a master,only from slave, when doing a read that is replication-aware
  end;
  PMYSQL_OPTIONS_V4 = ^TMYSQL_OPTIONS_V4;
  PMYSQL_OPTIONS = Pointer;

  TMySqlOption = (
    MYSQL_OPT_CONNECT_TIMEOUT,
    MYSQL_OPT_COMPRESS,
    MYSQL_OPT_NAMED_PIPE,
    MYSQL_INIT_COMMAND,
    MYSQL_READ_DEFAULT_FILE,
    MYSQL_READ_DEFAULT_GROUP,
    MYSQL_SET_CHARSET_DIR,
    MYSQL_SET_CHARSET_NAME,
    MYSQL_OPT_LOCAL_INFILE
  );

  TMySqlStatus = (
    MYSQL_STATUS_READY,
    MYSQL_STATUS_GET_RESULT,
    MYSQL_STATUS_USE_RESULT
  );

  { There are three types of queries - the ones that have to go to
  the master, the ones that go to a slave, and the adminstrative
  type which must happen on the pivot connectioin }
  TMySqlRplType = (
    MYSQL_RPL_MASTER,
    MYSQL_RPL_SLAVE,
    MYSQL_RPL_ADMIN
  );

  TMYSQL_V3 = record
    net:            	TNET;		// Communication parameters
    connector_fd:    	TGPtr;          // ConnectorFd for SSL
    host,
    user,
    passwd,
    unix_socket,
    server_version,
    host_info,
    info,
    db:             	TSDCharPtr;
    port,
    client_flag,
    server_capabilities:Integer;
    protocol_version: 	Integer;
    field_count:     	Integer;
    server_status:   	Integer;
    thread_id:       	LongInt;	// Id for connection in server
    affected_rows,
    insert_id,                          // id if insert on table with NEXTNR
    extra_info:      	TMyInt64;       // Used by mysqlshow
    packet_length:   	LongInt;
    status:          	TMySqlStatus;
    fields:          	PMYSQL_FIELD_V3;
    field_alloc:     	TMEM_ROOT;
    free_me,				// If free in mysql_close
    reconnect: 		TMyBool;	// set to 1 if automatic reconnect
    options:         	TMYSQL_OPTIONS_V3;
    scramble_buff:   	array[0..8] of Char;
    charset:         	PCHARSET_INFO;
    server_language: 	Integer;
  end;

  TMYSQL_V4 = record
    net:            	TNET;		// Communication parameters
    connector_fd:    	TGPtr;          // ConnectorFd for SSL
    host, user, passwd,
    unix_socket,
    server_version,
    host_info, info, db:TSDCharPtr;
    charset:         	PCHARSET_INFO;
    fields:          	PMYSQL_FIELD_V4;
    field_alloc:     	TMEM_ROOT;
    affected_rows,
    insert_id,                          // id if insert on table with NEXTNR
    extra_info:      	TMyInt64;       // Used by mysqlshow
    thread_id:       	ULong;		// Id for connection in server
    packet_length:   	ULong;
    port,
    client_flag,
    server_capabilities:UInt;
    protocol_version: 	UInt;
    field_count:     	UInt;
    server_status:   	UInt;
    server_language: 	UInt;
    options:         	TMYSQL_OPTIONS_V4;
    status:          	TMySqlStatus;
    free_me,				// If free in mysql_close
    reconnect: 		TMyBool;	// set to 1 if automatic reconnect
    scramble_buff:   	array[0..8] of Char;
    rpl_pivot:		TMyBool;    	// Set if this is the original connection, not a master or a slave we have added though mysql_rpl_probe() or mysql_set_master()/ mysql_add_slave()
    master, next_slave: PMYSQL_V4;   	// Pointers to the master, and the next slave connections, points to itself if lone connection
    last_used_slave: 	PMYSQL_V4; 	// needed for round-robin slave pick
    last_used_con: 	PMYSQL_V4;	// needed for send/read/store/use result to work correctly with replication
  end;

  PMYSQL    = TSDPtr;

  TMYSQL_RES_V3 = packed record
    row_count:       TMyInt64;
    field_count,
    current_field:   Integer;
    fields:          PMYSQL_FIELD_V3;
    data:            PMYSQL_DATA;
    data_cursor:     PMYSQL_ROWS;
    field_alloc:     TMEM_ROOT;
    row:             TMYSQL_ROW;	// If unbuffered read
    current_row:     TMYSQL_ROW;        // buffer to current row
    lengths:         PLongInt;          // column lengths of current row
    handle:          PMYSQL;            // for unbuffered reads
    eof:             TMyBool;           // Used my mysql_fetch_row
  end;
  PMYSQL_RES_V3 = ^TMYSQL_RES_V3;

  TMYSQL_RES_V4 = packed record
    row_count:       TMyInt64;
    fields:          PMYSQL_FIELD_V4;
    data:            PMYSQL_DATA;
    data_cursor:     PMYSQL_ROWS;
    lengths:         PULong;          	// column lengths of current row
    handle:          PMYSQL_V4;         // for unbuffered reads
    field_alloc:     TMEM_ROOT;
    field_count,
    current_field:   UInt;
    row:             TMYSQL_ROW;	// If unbuffered read
    current_row:     TMYSQL_ROW;        // buffer to current row
    eof:             TMyBool;           // Used my mysql_fetch_row
  end;
  PMYSQL_RES_V4 = ^TMYSQL_RES_V4;

  PMYSQL_RES	= TSDPtr;

{
 Functions to get information from the MYSQL and MYSQL_RES structures
 Should definitely be used if one uses shared libraries
}
{$IFNDEF SD_CLR}
var
  mysql_num_rows:
  	function(res: PMYSQL_RES): TMyInt64; stdcall;
  mysql_num_fields:
  	function(res: PMYSQL_RES): Integer; stdcall;
  mysql_eof:
  	function(res: PMYSQL_RES): TMyBool; stdcall;
  mysql_fetch_field_direct:
  	function(res: PMYSQL_RES; fieldnr: Integer): PMYSQL_FIELD; stdcall;
  mysql_fetch_fields:
  	function(res: PMYSQL_RES): PMYSQL_FIELD; stdcall;
  mysql_row_tell:
  	function(res: PMYSQL_RES): PMYSQL_ROWS; stdcall;
  mysql_field_tell:
  	function(res: PMYSQL_RES): Integer; stdcall;
  mysql_field_count:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_affected_rows:
  	function(mysql: PMYSQL): TMyInt64; stdcall;
  mysql_insert_id:
  	function(mysql: PMYSQL): TMyInt64; stdcall;
  mysql_errno:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_error:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_info:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_thread_id:
  	function(mysql: PMYSQL): LongInt; stdcall;
  mysql_character_set_name:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_init:
  	function(mysql: PMYSQL): PMYSQL; stdcall;

  mysql_ssl_set:
  	function(mysql: PMYSQL;
        	 const key, cert, ca, capath: TSDCharPtr): Integer; stdcall;
  mysql_ssl_cipher:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_ssl_clear:
  	function(mysql: PMYSQL): Integer; stdcall;

  mysql_connect:
  	function(mysql: PMYSQL; const host, user, passwd: TSDCharPtr): PMYSQL; stdcall;
  mysql_change_user:
  	function(mysql: PMYSQL; const user, passwd, db: TSDCharPtr): TMyBool; stdcall;

  mysql_real_connect:
  	function(mysql: PMYSQL; const host, user, passwd, db: TSDCharPtr;
		port: Integer; const unix_socket: TSDCharPtr;
		clientflag: Integer): PMYSQL; stdcall;
  mysql_close:
  	procedure(sock: PMYSQL); stdcall;
  mysql_select_db:
  	function(mysql: PMYSQL; const db: TSDCharPtr): Integer; stdcall;
  mysql_query:
  	function(mysql: PMYSQL; const q: TSDCharPtr): Integer; stdcall;
  mysql_send_query:
  	function(mysql: PMYSQL; const q: TSDCharPtr; length: Integer): Integer; stdcall;
  mysql_read_query_result:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_real_query:
  	function(mysql: PMYSQL; const q: TSDCharPtr; length: Integer): Integer; stdcall;
  mysql_create_db:
  	function(mysql: PMYSQL; const DB: TSDCharPtr): Integer; stdcall;
  mysql_drop_db:
  	function(mysql: PMYSQL; const DB: TSDCharPtr): Integer; stdcall;
  mysql_shutdown:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_dump_debug_info:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_refresh:
  	function(mysql: PMYSQL; refresh_options: Integer): Integer; stdcall;
  mysql_kill:
  	function(mysql: PMYSQL; pid: Integer): Integer; stdcall;
  mysql_ping:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_stat:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_get_server_info:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_get_client_info:
  	function: TSDCharPtr; stdcall;
  mysql_get_host_info:
  	function(mysql: PMYSQL): TSDCharPtr; stdcall;
  mysql_get_proto_info:
  	function(mysql: PMYSQL): Integer; stdcall;
  mysql_list_dbs:
  	function(mysql: PMYSQL; const wild: TSDCharPtr): PMYSQL_RES; stdcall;
  mysql_list_tables:
  	function(mysql: PMYSQL; const wild: TSDCharPtr): PMYSQL_RES; stdcall;
  mysql_list_fields:
  	function(mysql: PMYSQL; const table, wild: TSDCharPtr): PMYSQL_RES; stdcall;
  mysql_list_processes:
  	function(mysql: PMYSQL): PMYSQL_RES; stdcall;
  mysql_store_result:
  	function(mysql: PMYSQL): PMYSQL_RES; stdcall;
  mysql_use_result:
  	function(mysql: PMYSQL): PMYSQL_RES; stdcall;
  mysql_options:
  	function(mysql: PMYSQL; option: TMySqlOption; const arg: TSDCharPtr): Integer; stdcall;
  mysql_free_result:
  	procedure(res: PMYSQL_RES); stdcall;
  mysql_data_seek:
  	procedure(res: PMYSQL_RES; offset: TMyInt64); stdcall;
  mysql_row_seek:
  	function(res: PMYSQL_RES; Row: TMYSQL_ROW_OFFSET): TMYSQL_ROW_OFFSET; stdcall;
  mysql_field_seek:
  	function(res: PMYSQL_RES; offset: TMYSQL_FIELD_OFFSET): TMYSQL_FIELD_OFFSET; stdcall;
  mysql_fetch_row:
  	function(res: PMYSQL_RES): PMYSQL_ROW; stdcall;
  mysql_fetch_lengths:
  	function(res: PMYSQL_RES): PLongInt; stdcall;
  mysql_fetch_field:
  	function(res: PMYSQL_RES): PMYSQL_FIELD_V3; stdcall;
  mysql_escape_string:
  	function(szTo: TSDCharPtr; const szFrom: TSDCharPtr; from_length: LongInt): LongInt; stdcall;
  mysql_real_escape_string:
  	function(mysql: PMYSQL; szTo: TSDCharPtr; const szFrom: TSDCharPtr;
		 length: LongInt): LongInt; stdcall;
  mysql_debug:
  	procedure(const debug: TSDCharPtr); stdcall;

{
  mysql_odbc_escape_string:
  	function(MYSQL *mysql, char *to, unsigned long to_length,
		 const char *from, unsigned long from_length,
		 void *param,
                 char *(*extend_buffer) (void *, char *to, unsigned long *length)
                 ): TSDCharPtr; stdcall;
}

  myodbc_remove_escape:
  	procedure(mysql: PMYSQL; name: TSDCharPtr); stdcall;
  mysql_thread_safe:
  	function: Integer; stdcall;

//  Set up and bring down the server; to ensure that applications will
//  work when linked against either the standard client library or the
//  embedded server library, these functions should be called.
  mysql_server_init:
    	function(argc: Integer; argv, groups: Pointer): Integer; stdcall;
  mysql_server_end:
    	procedure; stdcall;
//  Set up and bring down a thread; these function should be called
//  for each thread in an application which opens at least one MySQL
//  connection.  All uses of the connection(s) should be between these function calls.
  mysql_thread_init:
    	function: TMyBool; stdcall;
  mysql_thread_end:
    	procedure; stdcall;
{$ENDIF}

{
    NOTE, TMYSQL_V?, TMYSQL_RES_V?, TMYSQL_OPTIONS_V?, TMYSQL_FIELD_V? have
  different versions for MySQL versions 3 and 4
}

type
  ESDMySQLError = class(ESDEngineError);

{ TIMyDatabase }
  TIMyConnInfo= packed record
    ServerType: Byte;
    MySQLPtr:	PMYSQL;			// pointer to TMYSQL structure for communication with the MySQL
  end;

  TIMyDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;
    FIsEnableMoney: Boolean;
    FIsClientVer3: Boolean;

    procedure Check(mysql: PMYSQL);
    procedure AllocHandle;
    procedure FreeHandle;
    procedure ExecCmd(const SQL: string; CheckRslt: Boolean);
    function GetMySQLPtr: PMYSQL;
    procedure SetDefaultOptions;
  protected
    function GetHandle: TSDPtr; override;

    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;
    
    procedure SetAutoCommitOption(Value: Boolean); override;
    procedure SetHandle(AHandle: TSDPtr); override;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;
    function CreateSqlCommand: TISqlCommand; override;

    function GetAutoIncSQL: string; override;    
    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function TestConnected: Boolean; override;    

    property MySQLPtr: PMYSQL read GetMySQLPtr;
    property IsClientVer3: Boolean read FIsClientVer3;
    property IsEnableMoney: Boolean read FIsEnableMoney;
  end;

{ TIMyCommand }
  TIMyCommand = class(TISqlCommand)
  private
    FHandle: PSDCursor;
    FRow: PMYSQL_ROW;		// current row
    FFieldLens: PLongInt;	// field lengths of the current row

    FStmt,			// w/o bind data
    FBindStmt: string;		// with bind parameter data, it's used to check whether the statement was executed
    FRowsAffected: TMyInt64;	// number of rows affected by the last query
    FAutoIncID: TMyInt64;       // AutoInc primary key from Insert query
    FFirstCalcFieldIdx: Integer;// first field, which is not bound. The following fields are not corresponded actual database fields

    function GetIsOpened: Boolean;
    function GetSqlDatabase: TIMyDatabase;
    function CnvtDateTime2SqlString(Value: TDateTime): string;
    function CnvtFloat2SqlString(Value: Double): string;
    function CnvtVarBytes2EscapeString(Value: string): string;
    function GetFieldValue(Index: Integer): TSDCharPtr;
    procedure InternalQBindParams;
    procedure InternalQExecute;
  protected
    procedure Check(Status: TSDEResult);

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    procedure DoPrepare(Value: string); override;
    procedure DoExecDirect(Value: string); override;
    procedure DoExecute; override;
    procedure BindParamsBuffer; override;
    function GetHandle: PSDCursor; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    procedure InitParamList; override;
    procedure SetFieldsBuffer; override;

    property IsOpened: Boolean read GetIsOpened;
    property SqlDatabase: TIMyDatabase read GetSqlDatabase;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
 	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    function GetAutoIncValue: Integer; override;
    function GetRowsAffected: Integer; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;    
  end;

{ TIMyCommandShowTables }
  TIMyCommandShowTables = class(TIMyCommand)
  private
    FTableNames: string;
    FIsSysTables: Boolean;
    FCatNameFieldIdx,
    FSchNameFieldIdx,
    FTblTypeFieldIdx: Integer;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property TableNames: string read FTableNames write FTableNames;
    property IsSysTables: Boolean read FIsSysTables write FIsSysTables;
  end;

{ TIMyCommandShowColumns }
  TIMyCommandShowColumns = class(TIMyCommand)
  private
    FTableName: string;
    FCatNameFieldIdx,
    FSchNameFieldIdx,
    FTblNameFieldIdx,
    FColLenFieldIdx,
    FColPrecFieldIdx,
    FColScaleFieldIdx,
    FColNullFieldIdx: Integer;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property TableName: string read FTableName write FTableName;
  end;

{ TIMyCommandShowIndexes }
  TIMyCommandShowIndexes = class(TIMyCommand)
  private
    FTableName: string;
    FCatNameFieldIdx,
    FSchNameFieldIdx,
    FIdxTypeFieldIdx,
    FIdxFilterFieldIdx: Integer;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property TableName: string read FTableName write FTableName;
  end;

const
  DefSqlApiDLL	= 'libmysql.dll';

var
  SqlApiDLL: string;

{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

{$IFDEF SD_CLR}

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_num_rows')]
function mysql_num_rows(res: PMYSQL_RES): TMyInt64; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_num_fields')]
function mysql_num_fields(res: PMYSQL_RES): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_eof')]
function mysql_eof(res: PMYSQL_RES): TMyBool; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_fetch_field_direct')]
function mysql_fetch_field_direct(res: PMYSQL_RES; fieldnr: Integer): PMYSQL_FIELD; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_fetch_fields')]
function mysql_fetch_fields(res: PMYSQL_RES): PMYSQL_FIELD_V3; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_row_tell')]
function mysql_row_tell(res: PMYSQL_RES): PMYSQL_ROWS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_field_tell')]
function mysql_field_tell(res: PMYSQL_RES): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_field_count')]
function mysql_field_count(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_affected_rows')]
function mysql_affected_rows(mysql: PMYSQL): TMyInt64; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_insert_id')]
function mysql_insert_id(mysql: PMYSQL): TMyInt64; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_errno')]
function mysql_errno(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_error')]
function mysql_error(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_info')]
function mysql_info(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_thread_id')]
function mysql_thread_id(mysql: PMYSQL): LongInt; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_character_set_name')]
function mysql_character_set_name(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_init')]
function mysql_init(mysql: PMYSQL): PMYSQL; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_ssl_set')]
function mysql_ssl_set(mysql: PMYSQL; const key, cert, ca, capath: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_ssl_cipher')]
function mysql_ssl_cipher(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_ssl_clear')]
function mysql_ssl_clear(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_connect')]
function mysql_connect(mysql: PMYSQL; const host, user, passwd: TSDCharPtr): PMYSQL; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_change_user')]
function mysql_change_user(mysql: PMYSQL; const user, passwd, db: TSDCharPtr): TMyBool; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_real_connect')]
function mysql_real_connect(mysql: PMYSQL; const host, user, passwd, db: TSDCharPtr;
		port: Integer; const unix_socket: TSDCharPtr; clientflag: Integer): PMYSQL; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_close')]
procedure mysql_close(sock: PMYSQL); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_select_db')]
function mysql_select_db(mysql: PMYSQL; const db: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_query')]
function mysql_query(mysql: PMYSQL; const q: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_send_query')]
function mysql_send_query(mysql: PMYSQL; const q: TSDCharPtr; length: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_read_query_result')]
function mysql_read_query_result(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_real_query')]
function mysql_real_query(mysql: PMYSQL; const q: TSDCharPtr; length: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_create_db')]
function mysql_create_db(mysql: PMYSQL; const DB: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_drop_db')]
function mysql_drop_db(mysql: PMYSQL; const DB: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_shutdown')]
function mysql_shutdown(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_dump_debug_info')]
function mysql_dump_debug_info(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_refresh')]
function mysql_refresh(mysql: PMYSQL; refresh_options: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_kill')]
function mysql_kill(mysql: PMYSQL; pid: Integer): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_ping')]
function mysql_ping(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_stat')]
function mysql_stat(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_get_server_info')]
function mysql_get_server_info(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_get_client_info')]
function mysql_get_client_info: TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_get_host_info')]
function mysql_get_host_info(mysql: PMYSQL): TSDCharPtr; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_get_proto_info')]
function mysql_get_proto_info(mysql: PMYSQL): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_list_dbs')]
function mysql_list_dbs(mysql: PMYSQL; const wild: TSDCharPtr): PMYSQL_RES; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_list_tables')]
function mysql_list_tables(mysql: PMYSQL; const wild: TSDCharPtr): PMYSQL_RES; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_list_fields')]
function mysql_list_fields(mysql: PMYSQL; const table, wild: TSDCharPtr): PMYSQL_RES; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_list_processes')]
function mysql_list_processes(mysql: PMYSQL): PMYSQL_RES; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_store_result')]
function mysql_store_result(mysql: PMYSQL): PMYSQL_RES; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_use_result')]
function mysql_use_result(mysql: PMYSQL): PMYSQL_RES; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_options')]
function mysql_options(mysql: PMYSQL; option: TMySqlOption; const arg: TSDCharPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_free_result')]
procedure mysql_free_result(res: PMYSQL_RES); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_data_seek')]
procedure mysql_data_seek(res: PMYSQL_RES; offset: TMyInt64); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_row_seek')]
function mysql_row_seek(res: PMYSQL_RES; Row: TMYSQL_ROW_OFFSET): TMYSQL_ROW_OFFSET; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_field_seek')]
function mysql_field_seek(res: PMYSQL_RES; offset: TMYSQL_FIELD_OFFSET): TMYSQL_FIELD_OFFSET; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_fetch_row')]
function mysql_fetch_row(res: PMYSQL_RES): PMYSQL_ROW; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_fetch_lengths')]
function mysql_fetch_lengths(res: PMYSQL_RES): PLongInt; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_fetch_field')]
function mysql_fetch_field(res: PMYSQL_RES): PMYSQL_FIELD_V3; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_escape_string')]
function mysql_escape_string(szTo: TSDCharPtr; const szFrom: TSDCharPtr; from_length: LongInt): LongInt; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_real_escape_string')]
function mysql_real_escape_string(mysql: PMYSQL; szTo: TSDCharPtr; const szFrom: TSDCharPtr; length: LongInt): LongInt; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_debug')]
procedure mysql_debug(const debug: TSDCharPtr); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'myodbc_remove_escape')]
procedure myodbc_remove_escape(mysql: PMYSQL; name: TSDCharPtr); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_thread_safe')]
function mysql_thread_safe: Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_server_init')]
function mysql_server_init(argc: Integer; argv, groups: TSDPtr): Integer; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_server_end')]
procedure mysql_server_end; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_thread_init')]
function mysql_thread_init: TMyBool; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'mysql_thread_end')]
procedure mysql_thread_end; external;
{$ENDIF}

implementation

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrFuncNotFound	= 'Function ''%s'' not found in MySQL library';

const
  SQueryMySqlStoredProcNamesFmt = '';
  SQueryMySqlTableNames = 'SHOW TABLES';
  SQueryMySqlTableFieldNamesFmt = 'SHOW COLUMNS FROM %s';
  SQueryMySqlIndexNamesFmt = 'SHOW INDEX FROM %s';

  IdentNameLen	= 50;

var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istMySQL) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIMyDatabase.Create( ADbParams );
end;

function IsAvailFunc(AName: string): Boolean;
begin
  Result := Assigned( GetProcAddress(hSqlLibModule, {$IFDEF SD_CLR}AName{$ELSE}PChar(AName){$ENDIF}) );
end;

(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure SetProcAddresses;
begin
{$IFNDEF SD_CLR}
  @mysql_num_rows		:= GetProcAddress(hSqlLibModule, 'mysql_num_rows');  		ASSERT( @mysql_num_rows		<>nil, Format(SErrFuncNotFound, ['mysql_num_rows']) );
  @mysql_num_fields		:= GetProcAddress(hSqlLibModule, 'mysql_num_fields');  		ASSERT( @mysql_num_fields	<>nil, Format(SErrFuncNotFound, ['mysql_num_fields']) );
  @mysql_eof			:= GetProcAddress(hSqlLibModule, 'mysql_eof');  		ASSERT( @mysql_eof	    	<>nil, Format(SErrFuncNotFound, ['mysql_eof']) );
  @mysql_fetch_field_direct	:= GetProcAddress(hSqlLibModule, 'mysql_fetch_field_direct');  	ASSERT( @mysql_fetch_field_direct<>nil, Format(SErrFuncNotFound,['mysql_fetch_field_direct']) );
  @mysql_fetch_fields		:= GetProcAddress(hSqlLibModule, 'mysql_fetch_fields');  	ASSERT( @mysql_fetch_fields   	<>nil, Format(SErrFuncNotFound, ['mysql_fetch_fields']) );
  @mysql_row_tell		:= GetProcAddress(hSqlLibModule, 'mysql_row_tell');  		ASSERT( @mysql_row_tell	       	<>nil, Format(SErrFuncNotFound, ['mysql_row_tell']) );
  @mysql_field_tell		:= GetProcAddress(hSqlLibModule, 'mysql_field_tell');  		ASSERT( @mysql_field_tell	<>nil, Format(SErrFuncNotFound, ['mysql_field_tell']) );
  @mysql_field_count		:= GetProcAddress(hSqlLibModule, 'mysql_field_count');  	ASSERT( @mysql_field_count     	<>nil, Format(SErrFuncNotFound, ['mysql_field_count']) );
  @mysql_affected_rows		:= GetProcAddress(hSqlLibModule, 'mysql_affected_rows');  	ASSERT( @mysql_affected_rows   	<>nil, Format(SErrFuncNotFound, ['mysql_affected_rows']) );
  @mysql_insert_id		:= GetProcAddress(hSqlLibModule, 'mysql_insert_id');  		ASSERT( @mysql_insert_id       	<>nil, Format(SErrFuncNotFound, ['mysql_insert_id']) );
  @mysql_errno			:= GetProcAddress(hSqlLibModule, 'mysql_errno');  		ASSERT( @mysql_errno	       	<>nil, Format(SErrFuncNotFound, ['mysql_errno']) );
  @mysql_error			:= GetProcAddress(hSqlLibModule, 'mysql_error');  		ASSERT( @mysql_error	       	<>nil, Format(SErrFuncNotFound, ['mysql_error']) );
  @mysql_info			:= GetProcAddress(hSqlLibModule, 'mysql_info');  		ASSERT( @mysql_info	       	<>nil, Format(SErrFuncNotFound, ['mysql_info']) );
  @mysql_thread_id		:= GetProcAddress(hSqlLibModule, 'mysql_thread_id');  		ASSERT( @mysql_thread_id       	<>nil, Format(SErrFuncNotFound, ['mysql_thread_id']) );
  @mysql_character_set_name	:= GetProcAddress(hSqlLibModule, 'mysql_character_set_name');
  @mysql_init			:= GetProcAddress(hSqlLibModule, 'mysql_init');  		ASSERT( @mysql_init	      	<>nil, Format(SErrFuncNotFound, ['mysql_init']) );
  @mysql_ssl_set		:= GetProcAddress(hSqlLibModule, 'mysql_ssl_set');
  @mysql_ssl_cipher		:= GetProcAddress(hSqlLibModule, 'mysql_ssl_cipher');
  @mysql_ssl_clear		:= GetProcAddress(hSqlLibModule, 'mysql_ssl_clear');
  @mysql_connect		:= GetProcAddress(hSqlLibModule, 'mysql_connect');  		
  @mysql_change_user		:= GetProcAddress(hSqlLibModule, 'mysql_change_user');
  @mysql_real_connect		:= GetProcAddress(hSqlLibModule, 'mysql_real_connect');  	ASSERT( @mysql_real_connect	<>nil, Format(SErrFuncNotFound, ['mysql_real_connect']) );
  @mysql_close			:= GetProcAddress(hSqlLibModule, 'mysql_close');  		ASSERT( @mysql_close	       	<>nil, Format(SErrFuncNotFound, ['mysql_close']) );
  @mysql_select_db		:= GetProcAddress(hSqlLibModule, 'mysql_select_db');  		ASSERT( @mysql_select_db	<>nil, Format(SErrFuncNotFound, ['mysql_select_db']) );
  @mysql_query			:= GetProcAddress(hSqlLibModule, 'mysql_query');  		ASSERT( @mysql_query		<>nil, Format(SErrFuncNotFound, ['mysql_query']) );
  @mysql_send_query		:= GetProcAddress(hSqlLibModule, 'mysql_send_query');
  @mysql_read_query_result	:= GetProcAddress(hSqlLibModule, 'mysql_read_query_result');
  @mysql_real_query		:= GetProcAddress(hSqlLibModule, 'mysql_real_query');  		ASSERT( @mysql_real_query	<>nil, Format(SErrFuncNotFound, ['mysql_real_query']) );
  @mysql_create_db		:= GetProcAddress(hSqlLibModule, 'mysql_create_db');
  @mysql_drop_db		:= GetProcAddress(hSqlLibModule, 'mysql_drop_db');
  @mysql_shutdown		:= GetProcAddress(hSqlLibModule, 'mysql_shutdown');  		ASSERT( @mysql_shutdown	       	<>nil, Format(SErrFuncNotFound, ['mysql_shutdown']) );
  @mysql_dump_debug_info	:= GetProcAddress(hSqlLibModule, 'mysql_dump_debug_info');  	ASSERT( @mysql_dump_debug_info  <>nil, Format(SErrFuncNotFound, ['mysql_dump_debug_info']) );
  @mysql_refresh		:= GetProcAddress(hSqlLibModule, 'mysql_refresh');  		ASSERT( @mysql_refresh	       	<>nil, Format(SErrFuncNotFound, ['mysql_refresh']) );
  @mysql_kill			:= GetProcAddress(hSqlLibModule, 'mysql_kill');  		ASSERT( @mysql_kill	       	<>nil, Format(SErrFuncNotFound, ['mysql_kill']) );
  @mysql_ping			:= GetProcAddress(hSqlLibModule, 'mysql_ping');  		ASSERT( @mysql_ping	       	<>nil, Format(SErrFuncNotFound, ['mysql_ping']) );
  @mysql_stat			:= GetProcAddress(hSqlLibModule, 'mysql_stat');  		ASSERT( @mysql_stat	       	<>nil, Format(SErrFuncNotFound, ['mysql_stat']) );
  @mysql_get_server_info	:= GetProcAddress(hSqlLibModule, 'mysql_get_server_info');  	ASSERT( @mysql_get_server_info 	<>nil, Format(SErrFuncNotFound, ['mysql_get_server_info']) );
  @mysql_get_client_info	:= GetProcAddress(hSqlLibModule, 'mysql_get_client_info');  	ASSERT( @mysql_get_client_info 	<>nil, Format(SErrFuncNotFound, ['mysql_get_client_info']) );
  @mysql_get_host_info		:= GetProcAddress(hSqlLibModule, 'mysql_get_host_info');  	ASSERT( @mysql_get_host_info   	<>nil, Format(SErrFuncNotFound, ['mysql_get_host_info']) );
  @mysql_get_proto_info		:= GetProcAddress(hSqlLibModule, 'mysql_get_proto_info');  	ASSERT( @mysql_get_proto_info  	<>nil, Format(SErrFuncNotFound, ['mysql_get_proto_info']) );
  @mysql_list_dbs		:= GetProcAddress(hSqlLibModule, 'mysql_list_dbs');  		ASSERT( @mysql_list_dbs	       	<>nil, Format(SErrFuncNotFound, ['mysql_list_dbs']) );
  @mysql_list_tables		:= GetProcAddress(hSqlLibModule, 'mysql_list_tables');  	ASSERT( @mysql_list_tables     	<>nil, Format(SErrFuncNotFound, ['mysql_list_tables']) );
  @mysql_list_fields		:= GetProcAddress(hSqlLibModule, 'mysql_list_fields');  	ASSERT( @mysql_list_fields     	<>nil, Format(SErrFuncNotFound, ['mysql_list_fields']) );
  @mysql_list_processes		:= GetProcAddress(hSqlLibModule, 'mysql_list_processes');  	ASSERT( @mysql_list_processes  	<>nil, Format(SErrFuncNotFound, ['mysql_list_processes']) );
  @mysql_store_result		:= GetProcAddress(hSqlLibModule, 'mysql_store_result');  	ASSERT( @mysql_store_result    	<>nil, Format(SErrFuncNotFound, ['mysql_store_result']) );
  @mysql_use_result		:= GetProcAddress(hSqlLibModule, 'mysql_use_result');  		ASSERT( @mysql_use_result      	<>nil, Format(SErrFuncNotFound, ['mysql_use_result']) );
  @mysql_options		:= GetProcAddress(hSqlLibModule, 'mysql_options');  		ASSERT( @mysql_options	       	<>nil, Format(SErrFuncNotFound, ['mysql_options']) );
  @mysql_free_result		:= GetProcAddress(hSqlLibModule, 'mysql_free_result');  	ASSERT( @mysql_free_result	<>nil, Format(SErrFuncNotFound, ['mysql_free_result']) );
  @mysql_data_seek		:= GetProcAddress(hSqlLibModule, 'mysql_data_seek');  		ASSERT( @mysql_data_seek	<>nil, Format(SErrFuncNotFound, ['mysql_data_seek']) );
  @mysql_row_seek		:= GetProcAddress(hSqlLibModule, 'mysql_row_seek');  		ASSERT( @mysql_row_seek	       	<>nil, Format(SErrFuncNotFound, ['mysql_row_seek']) );
  @mysql_field_seek		:= GetProcAddress(hSqlLibModule, 'mysql_field_seek');  		ASSERT( @mysql_field_seek      	<>nil, Format(SErrFuncNotFound, ['mysql_field_seek']) );
  @mysql_fetch_row		:= GetProcAddress(hSqlLibModule, 'mysql_fetch_row');  		ASSERT( @mysql_fetch_row       	<>nil, Format(SErrFuncNotFound, ['mysql_fetch_row']) );
  @mysql_fetch_lengths		:= GetProcAddress(hSqlLibModule, 'mysql_fetch_lengths');  	ASSERT( @mysql_fetch_lengths   	<>nil, Format(SErrFuncNotFound, ['mysql_fetch_lengths']) );
  @mysql_fetch_field		:= GetProcAddress(hSqlLibModule, 'mysql_fetch_field');  	ASSERT( @mysql_fetch_field     	<>nil, Format(SErrFuncNotFound, ['mysql_fetch_field']) );
  @mysql_escape_string		:= GetProcAddress(hSqlLibModule, 'mysql_escape_string');  	ASSERT( @mysql_escape_string   	<>nil, Format(SErrFuncNotFound, ['mysql_escape_string']) );
  @mysql_real_escape_string    	:= GetProcAddress(hSqlLibModule, 'mysql_real_escape_string');
  @mysql_debug			:= GetProcAddress(hSqlLibModule, 'mysql_debug');  		ASSERT( @mysql_debug	       	<>nil, Format(SErrFuncNotFound, ['mysql_debug']) );
  @myodbc_remove_escape		:= GetProcAddress(hSqlLibModule, 'myodbc_remove_escape');  	ASSERT( @myodbc_remove_escape  	<>nil, Format(SErrFuncNotFound, ['myodbc_remove_escape']) );
  @mysql_thread_safe		:= GetProcAddress(hSqlLibModule, 'mysql_thread_safe');  	ASSERT( @mysql_thread_safe     	<>nil, Format(SErrFuncNotFound, ['mysql_thread_safe']) );

  @mysql_server_init   	 	:= GetProcAddress(hSqlLibModule, 'mysql_server_init');
  @mysql_server_end    		:= GetProcAddress(hSqlLibModule, 'mysql_server_end');
  @mysql_thread_init   		:= GetProcAddress(hSqlLibModule, 'mysql_thread_init');
  @mysql_thread_end    		:= GetProcAddress(hSqlLibModule, 'mysql_thread_end');
{$ENDIF}
end;

procedure ResetProcAddresses;
begin
{$IFNDEF SD_CLR}
  @mysql_num_rows		:= nil;
  @mysql_num_fields		:= nil;
  @mysql_eof			:= nil;
  @mysql_fetch_field_direct	:= nil;
  @mysql_fetch_fields		:= nil;
  @mysql_row_tell		:= nil;
  @mysql_field_tell		:= nil;
  @mysql_field_count		:= nil;
  @mysql_affected_rows		:= nil;
  @mysql_insert_id		:= nil;
  @mysql_errno			:= nil;
  @mysql_error			:= nil;
  @mysql_info			:= nil;
  @mysql_thread_id		:= nil;
  @mysql_character_set_name	:= nil;
  @mysql_init			:= nil;
  @mysql_ssl_set		:= nil;
  @mysql_ssl_cipher		:= nil;
  @mysql_ssl_clear		:= nil;
  @mysql_connect		:= nil;
  @mysql_change_user		:= nil;
  @mysql_real_connect		:= nil;
  @mysql_close			:= nil;
  @mysql_select_db		:= nil;
  @mysql_query			:= nil;
  @mysql_send_query		:= nil;
  @mysql_read_query_result	:= nil;
  @mysql_real_query		:= nil;
  @mysql_create_db		:= nil;
  @mysql_drop_db		:= nil;
  @mysql_shutdown		:= nil;
  @mysql_dump_debug_info	:= nil;
  @mysql_refresh		:= nil;
  @mysql_kill			:= nil;
  @mysql_ping			:= nil;
  @mysql_stat			:= nil;
  @mysql_get_server_info	:= nil;
  @mysql_get_client_info	:= nil;
  @mysql_get_host_info		:= nil;
  @mysql_get_proto_info		:= nil;
  @mysql_list_dbs		:= nil;
  @mysql_list_tables		:= nil;
  @mysql_list_fields		:= nil;
  @mysql_list_processes		:= nil;
  @mysql_store_result		:= nil;
  @mysql_use_result		:= nil;
  @mysql_options		:= nil;
  @mysql_free_result		:= nil;
  @mysql_data_seek		:= nil;
  @mysql_row_seek		:= nil;
  @mysql_field_seek		:= nil;
  @mysql_fetch_row		:= nil;
  @mysql_fetch_lengths		:= nil;
  @mysql_fetch_field		:= nil;
  @mysql_escape_string		:= nil;
  @mysql_real_escape_string    	:= nil;
  @mysql_debug			:= nil;
  @myodbc_remove_escape		:= nil;
  @mysql_thread_safe		:= nil;

  @mysql_server_init   	 	:= nil;
  @mysql_server_end    		:= nil;
  @mysql_thread_init   		:= nil;
  @mysql_thread_end    		:= nil;
{$ENDIF}
end;

procedure LoadSqlLib;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      hSqlLibModule := HelperLoadLibrary( SqlApiDLL );
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [ SqlApiDLL ]);
      Inc(SqlLibRefCount);
      SetProcAddresses;
	// It starts up the embedded server and initialises any subsystems
      if IsAvailFunc('mysql_server_init') then begin
        // embedded MySQL 4.0.12 produces "External exception C0000008" in the this call
        mysql_server_init(0, nil, nil);
      end;
    end else
      Inc(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

procedure FreeSqlLib;
begin
  if SqlLibRefCount = 0 then
    Exit;

  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 1) then begin
	// It shuts down the embedded server
      if IsAvailFunc('mysql_server_end') then
        mysql_server_end;

      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDLL ]);
      Dec(SqlLibRefCount);
      ResetProcAddresses;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{ TIMyDatabase }
constructor TIMyDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);
  FHandle	:= nil;
  FIsClientVer3 := False;
	// by default IsEnableMoney = False
  FIsEnableMoney := UpperCase( Trim( Params.Values[szENABLEMONEY] ) ) = STrueString;
end;

destructor TIMyDatabase.Destroy;
begin
  inherited;
end;

function TIMyDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIMyCommand.Create( Self );
end;

procedure TIMyDatabase.Check(mysql: PMYSQL);
var
  E: ESDMySQLError;
  szErrMsg: TSDCharPtr;
  ErrNo: Integer;
  sMsg: string;
begin
  ResetIdleTimeOut;

  if Assigned( mysql ) then
    Exit;
  ResetBusyState;

  ErrNo := mysql_errno( MySQLPtr );
  szErrMsg := mysql_error( MySQLPtr );
  sMsg := HelperPtrToString(szErrMsg);

  E := ESDMySQLError.Create(ErrNo, ErrNo, sMsg, 0);
  raise E;
end;

function TIMyDatabase.GetAutoIncSQL: string;
begin
  Result := MySql_SelectAutoIncField;	// MySQL 4 returns as largeint (64-bit)
end;

function TIMyDatabase.GetClientVersion: LongInt;
var
  szVer: TSDCharPtr;
begin
  szVer := mysql_get_client_info;
  Result := VersionStringToDWORD( HelperPtrToString(szVer) );
end;

function TIMyDatabase.GetServerVersion: LongInt;
var
  szVer: TSDCharPtr;
begin
  szVer := mysql_get_server_info( MySQLPtr );
  Result := VersionStringToDWORD( HelperPtrToString(szVer) );
end;

function TIMyDatabase.GetVersionString: string;
var
  szSrv, szHost: TSDCharPtr;
begin
  szSrv := mysql_get_server_info( MySQLPtr );
  szHost := mysql_get_host_info( MySQLPtr );
  Result := HelperPtrToString(szSrv) + '/' + HelperPtrToString(szHost);
end;

function TIMyDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

procedure TIMyDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF SD_CLR}
var
  r1, r2: TIMyConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;

{$IFDEF SD_CLR}
  r1 := TIMyConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMyConnInfo) ) );
  r2 := TIMyConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIMyConnInfo) ) );
  r1.MySQLPtr := r2.MySQLPtr;
  Marshal.StructureToPtr( r1, FHandle, False );
{$ELSE}
  TIMyConnInfo(FHandle^).MySQLPtr := TIMyConnInfo(AHandle^).MySQLPtr;
{$ENDIF}
end;

function TIMyDatabase.GetMySQLPtr: PMYSQL;
begin
  ASSERT( Assigned(FHandle), 'TIMyDatabase.GetMySQLPtr' );
{$IFDEF SD_CLR}
  Result := TIMyConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMyConnInfo) ) ).MySQLPtr;
{$ELSE}
  Result := TIMyConnInfo(FHandle^).MySQLPtr;
{$ENDIF}
end;

procedure TIMyDatabase.AllocHandle;
var
  rec: TIMyConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TIMyDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.ServerType := Ord( istMySQL );

{$IFDEF SD_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIMyConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TIMyDatabase.FreeHandle;
begin
  if Assigned(FHandle) then
    FHandle := SafeReallocMem( FHandle, 0 );
end;

procedure TIMyDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
{$IFDEF SD_CLR}
  rec: TIMyConnInfo;
  ptr: TSDPtr;
{$ENDIF}
  sSrvName, sDbName: string;
  szSrv, szDb, szUseDb, szUser, szPwd: TSDCharPtr;
  IntValue, ConnFlags: Integer;
begin
  LoadSqlLib;

  AllocHandle;

  sSrvName := ExtractServerName(sRemoteDatabase);
  sDbName := ExtractDatabaseName(sRemoteDatabase);
  try
{$IFDEF SD_CLR}
    rec := TIMyConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMyConnInfo) ) );
    rec.MySQLPtr := mysql_init( nil );
    Marshal.StructureToPtr( rec, FHandle, False );
    szSrv := Marshal.StringToHGlobalAnsi( sSrvName );
    szDb  := Marshal.StringToHGlobalAnsi( sDbName );
    szUser:= Marshal.StringToHGlobalAnsi( sUserName );
    szPwd := Marshal.StringToHGlobalAnsi( sPassword );
{$ELSE}
    TIMyConnInfo(FHandle^).MySQLPtr := mysql_init( nil );
    szSrv := TSDCharPtr( sSrvName );
    szDb  := TSDCharPtr( sDbName );
    szUser:= TSDCharPtr( sUserName );
    szPwd := TSDCharPtr( sPassword );
{$ENDIF}
  	// set login timeout before connect
    if Trim( Params.Values[szLOGINTIMEOUT] ) <> '' then begin
      IntValue := StrToIntDef( Trim( Params.Values[szLOGINTIMEOUT] ), 0 );
{$IFDEF SD_CLR}
      ptr := SafeReallocMem(nil, SizeOf(IntValue));
      try
        HelperMemWriteInt32(ptr, 0, IntValue);
        mysql_options( MySQLPtr, MYSQL_OPT_CONNECT_TIMEOUT, ptr);
      finally
        SafeReallocMem(ptr, 0);
      end;
{$ELSE}
      mysql_options( MySQLPtr, MYSQL_OPT_CONNECT_TIMEOUT, @IntValue);
{$ENDIF}
    end;
    	// set compressed protocol if it is not turn off
    if Trim( Params.Values[szCOMPRESSEDPROT] ) <> SFalseString then
      mysql_options( MySQLPtr, MYSQL_OPT_COMPRESS, nil);

	// gets the custom server port
    IntValue := StrToIntDef( Params.Values[szSERVERPORT], 0 );

    if IsAvailFunc('mysql_real_connect') then begin
      ConnFlags := CLIENT_FOUND_ROWS;
      if sDbName <> '' then
        ConnFlags := ConnFlags or CLIENT_CONNECT_WITH_DB;
      Check( mysql_real_connect( MySQLPtr, szSrv, szUser, szPwd, szDb, IntValue, nil, ConnFlags ) )
    end else begin
      ASSERT( IsAvailFunc('mysql_connect') ); // mysql_connect is not supported since MySQL v.4.0.x
      Check( mysql_connect( MySQLPtr, szSrv, szUser, szPwd ) );
      if sDbName <> '' then begin
        sDbName := 'use ' + sDbName;
{$IFDEF SD_CLR}
        szUseDb := Marshal.StringToHGlobalAnsi( sDbName );
{$ELSE}
        szUseDb := TSDCharPtr( sDbName );
{$ENDIF}
        if mysql_query( MySQLPtr, szUseDb ) <> 0 then
          Check( MySQLPtr );
      end;
    end;
  finally
{$IFDEF SD_CLR}
    if Assigned( szSrv ) then
      Marshal.FreeHGlobal( szSrv );
    if Assigned( szDb ) then
      Marshal.FreeHGlobal( szDb );
    if Assigned( szUser ) then
      Marshal.FreeHGlobal( szUser );
    if Assigned( szPwd ) then
      Marshal.FreeHGlobal( szPwd );
    if Assigned( szUseDb ) then
      Marshal.FreeHGlobal( szUseDb );
{$ENDIF}
  end;
  FIsClientVer3 := GetMajorVer( GetClientVersion ) <= 3;

  SetDefaultOptions;
end;

procedure TIMyDatabase.DoDisconnect(Force: Boolean);
{$IFDEF SD_CLR}
var
  rec: TIMyConnInfo;
{$ENDIF}
begin
  if Assigned(FHandle) and Assigned( MySQLPtr ) then begin
    if InTransaction then
      ExecCmd( 'ROLLBACK', False );
    mysql_close( MySQLPtr );
{$IFDEF SD_CLR}
    rec := TIMyConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMyConnInfo) ) );
    rec.MySQLPtr := nil;
    Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
    TIMyConnInfo(FHandle^).MySQLPtr := nil;
{$ENDIF}
  end;

  FreeHandle;
  FreeSqlLib;
end;

procedure TIMyDatabase.ExecCmd(const SQL: string; CheckRslt: Boolean);
var
  szCmd: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( SQL );
{$ELSE}
  szCmd := TSDCharPtr( SQL );
{$ENDIF}
  try
    if (mysql_query( MySQLPtr, szCmd ) <> 0) and CheckRslt then
      Check( nil );
  finally
{$IFDEF SD_CLR}
    if Assigned( szCmd ) then
      Marshal.FreeHGlobal( szCmd );
{$ENDIF}
  end;
end;

procedure TIMyDatabase.SetAutoCommitOption(Value: Boolean);
begin
end;

procedure TIMyDatabase.SetDefaultOptions;
var
  sValue: string;
begin
  if not AutoCommitDef then begin
    sValue := 'SET AUTOCOMMIT = ';
    if AutoCommit
    then sValue := sValue + '1'
    else sValue := sValue + '0';

    ExecCmd( sValue, True );
  end
end;

procedure TIMyDatabase.DoStartTransaction;
begin
  ExecCmd( 'BEGIN', True );
end;

procedure TIMyDatabase.DoCommit;
begin
  ExecCmd( 'COMMIT', True );
end;

procedure TIMyDatabase.DoRollback;
begin
  ExecCmd( 'ROLLBACK', True );
end;

procedure TIMyDatabase.SetTransIsolation(Value: TISqlTransIsolation);
const
	// there's SERIALIZABLE level also
  TransIsolLevels: array[TISqlTransIsolation] of string = ('READ UNCOMMITTED', 'READ COMMITTED', 'REPEATABLE READ');
begin
  ExecCmd( 'SET SESSION TRANSACTION ISOLATION LEVEL ' + TransIsolLevels[Value], True );
end;

function TIMyDatabase.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  Result := False;
  cmd := GetSchemaInfo(stSysTables, 'DUMMY');
  if Assigned(cmd) then begin
    Result := True;
    cmd.Free;
  end;
end;

function TIMyDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
var
  cmd: TISqlCommand;
begin
  cmd := nil;
  case ASchemaType of
    stTables,
    stSysTables:
      begin
        cmd := TIMyCommandShowTables.Create(Self);
        if AObjectName <> '' then
          TIMyCommandShowTables(cmd).TableNames := AObjectName;
        TIMyCommandShowTables(cmd).IsSysTables := ASchemaType = stSysTables;
      end;
    stColumns:
      begin
        cmd := TIMyCommandShowColumns.Create(Self);
        TIMyCommandShowColumns(cmd).TableName := AObjectName;
      end;
    stIndexes:
      begin
        cmd := TIMyCommandShowIndexes.Create(Self);
        TIMyCommandShowIndexes(cmd).TableName := AObjectName;
      end;
  end;

  if Assigned(cmd) then
  try
    cmd.ExecDirect('');
  except
    cmd.Free;
    raise;
  end;

  Result := cmd;
end;


{ TIMyCommand }
constructor TIMyCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FStmt		:= '';
  FBindStmt	:= '';
  FRowsAffected := -1;
  FAutoIncID    := 0;   // GetAutoIncValue is supported

  FHandle 	:= nil;
  FRow		:= nil;
  FFieldLens	:= nil;
end;

destructor TIMyCommand.Destroy;
begin
  Disconnect(False);

  inherited Destroy;
end;

function TIMyCommand.GetIsOpened: Boolean;
begin
	// FHandle is assigned to a handle of the result set, when it's activated
  Result := Assigned( FHandle );
end;

function TIMyCommand.GetHandle: PSDCursor;
begin
  Result := FHandle;
end;

function TIMyCommand.GetSqlDatabase: TIMyDatabase;
begin
  Result := (inherited SqlDatabase) as TIMyDatabase;
end;

procedure TIMyCommand.Check(Status: TSDEResult);
begin
	// if success
  if Status = 0 then
    SqlDatabase.Check( SqlDatabase.MySQLPtr )
  else
    SqlDatabase.Check( nil )
end;

procedure TIMyCommand.Disconnect(Force: Boolean);
begin
  // nothing
end;

function TIMyCommand.ResultSetExists: Boolean;
begin
  Result := True;
end;

procedure TIMyCommand.SetFieldsBuffer;
begin
  // nothing
end;

procedure TIMyCommand.BindParamsBuffer;
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);

  // nothing
end;

procedure TIMyCommand.DoPrepare(Value: string);
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);
  FStmt		:= Value;
  FBindStmt	:= '';
        // it's possible for TIMyCommandShow...
  if CommandText = '' then
    SetCommandText(Value);
end;

procedure TIMyCommand.DoExecDirect(Value: string);
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);
  FStmt		:= Value;
  FBindStmt	:= '';

  InternalQExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if IsOpened and (FieldDescs.Count = 0) then
    InitFieldDescs;

  SetNativeCommand(FBindStmt);
end;

procedure TIMyCommand.DoExecute;
begin
  if CommandType = ctStoredProc then
    DatabaseError(SNoCapability);
	// to exclude repeated execution after execution in GetFieldDescs (result set is opened)
  if not IsOpened then
    InternalQExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if IsOpened and (FieldDescs.Count = 0) then begin
    InitFieldDescs;
    AllocFieldsBuffer;
    SetFieldsBuffer;
  end;

  SetNativeCommand(FBindStmt);
end;

procedure TIMyCommand.InternalQExecute;
var
  szCmd: TSDCharPtr;
begin
  FRowsAffected := -1;
  FAutoIncID    := 0;
	// set parameter's values
  InternalQBindParams;
{$IFDEF SD_CLR}
  szCmd := Marshal.StringToHGlobalAnsi(FBindStmt);
{$ELSE}
  szCmd := TSDCharPtr(FBindStmt);
{$ENDIF}
  try
    Check( mysql_real_query( SqlDatabase.MySQLPtr, szCmd, Length(FBindStmt) ) );
    FHandle := mysql_store_result( SqlDatabase.MySQLPtr );
        // if the statement does not generate a result set, for example: UPDATE, DELETE or etc.
    if FHandle = nil then begin
      FRowsAffected := mysql_affected_rows( SqlDatabase.MySQLPtr );
         // mysql_insert_id has to returns 0, if the statement does not generate autoincrement value
      FAutoIncID := mysql_insert_id( SqlDatabase.MySQLPtr );
    end;
  finally
{$IFDEF SD_CLR}
    Marshal.FreeHGlobal(szCmd);
{$ENDIF}
  end;
end;

procedure TIMyCommand.GetFieldDescs(Descs: TSDFieldDescList);
const
  MAX_MONEY_FIELD_SCALE	= 4;
var
  ft: TFieldType;
  Col, NumCols, HVer, LVer: Integer;
  FldPtr: PMYSQL_FIELD;
  Fld_V3: TMYSQL_FIELD_V3;
  Fld_V4: TMYSQL_FIELD_V4;
  Fld_V41:TMYSQL_FIELD_V41;
  sFName: string;
  ilength, iflags, idecimals, iftype:     ULong;
begin
  if not IsOpened then
    InternalQExecute;
	// the statement can't return a result set
  if not Assigned(FHandle) then
    Exit;
  HVer := SqlDatabase.GetClientVersion;
  LVer := GetMinorVer(HVer);
  HVer := GetMajorVer(HVer);
  NumCols := mysql_num_fields( FHandle );
  for Col:=0 to NumCols-1 do begin
    FldPtr := mysql_fetch_field_direct( FHandle, Col );

    if HVer < 4 then begin
{$IFDEF SD_CLR}
      Fld_V3	:= TMYSQL_FIELD_V3( Marshal.PtrToStructure( FldPtr, TypeOf(TMYSQL_FIELD_V3) ) );
{$ELSE}
      Fld_V3	:= TMYSQL_FIELD_V3( FldPtr^ );
{$ENDIF}
      sFName	:= HelperPtrToString( Fld_V3.name );
      iftype	:= Fld_V3.ftype;
      ilength	:= Fld_V3.length;
      iflags	:= Fld_V3.flags;
      idecimals	:= Fld_V3.decimals;
    end else if (HVer = 4) and (LVer < 1) then begin // ver < 4.1
{$IFDEF SD_CLR}
      Fld_V4	:= TMYSQL_FIELD_V4( Marshal.PtrToStructure( FldPtr, TypeOf(TMYSQL_FIELD_V4) ) );
{$ELSE}
      Fld_V4	:= TMYSQL_FIELD_V4( FldPtr^ );
{$ENDIF}
      sFName	:= HelperPtrToString( Fld_V4.name );
      iftype	:= Fld_V4.ftype;
      ilength	:= Fld_V4.length;// off 28
      iflags	:= Fld_V4.flags;
      idecimals	:= Fld_V4.decimals;
    end else begin                              // ver >= 4.1
{$IFDEF SD_CLR}
      Fld_V41	:= TMYSQL_FIELD_V41( Marshal.PtrToStructure( FldPtr, TypeOf(TMYSQL_FIELD_V41) ) );
{$ELSE}
      Fld_V41	:= TMYSQL_FIELD_V41( FldPtr^ );
{$ENDIF}
      sFName	:= HelperPtrToString( Fld_V41.name );
      iftype	:= Fld_V41.ftype;
      ilength	:= Fld_V41.length;// off 28
      iflags	:= Fld_V41.flags;
      idecimals	:= Fld_V41.decimals;
    end;

    ft := FieldDataType(iftype);
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [sFName] );
      	// add space for zero-terminator
    if ft = ftString then
      Inc(ilength);
      // if autoincrement field
    if IsNumericType(ft) and ((iflags and AUTO_INCREMENT_FLAG) <> 0) then
      ft := ftAutoInc;
      	// use Currency field ?
    if (ft = ftFloat) and SqlDatabase.IsEnableMoney and
       (idecimals > 0) and (idecimals <= MAX_MONEY_FIELD_SCALE)
    then
      ft := ftCurrency;
	// if the current blob field is not binary
    if (ft = ftBlob) and ((iflags and BINARY_FLAG) = 0) then
      ft := ftMemo;
    if IsBlobType(ft) then
      ilength := 0;     // MySQL returns max blob size, which is not used by TIMyCommand

    with Descs.AddFieldDesc do begin
      FieldName	:= sFName;
      FieldNo	:= Col+1;
      FieldType	:= ft;
      DataType  := iftype;
      DataSize	:= ilength;
      Precision	:= idecimals;
  	// null values are not permitted for the column (Required = True)
      Required	:= (iflags and NOT_NULL_FLAG) <> 0;
    end;
  end;
  FFirstCalcFieldIdx := Descs.Count;
end;

{ Returns a pointer to field data }
function TIMyCommand.GetFieldValue(Index: Integer): TSDCharPtr;
begin
{$IFDEF SD_CLR}
  Result := Marshal.ReadIntPtr( FRow, Index * SizeOf(Result) );
{$ELSE}
  Result := FRow[Index];
{$ENDIF}
end;

{ BufSize is not used for all datatypes now }
function TIMyCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf, InData, OutData: TSDPtr;
  FieldInfo: TSDFieldInfo;
  FieldLenPtr: PLongInt;
  nSize: LongInt;
  sValue: string;
  dtValue: TDateTime;
  dtRec: TDateTimeRec;
begin
  Result := False;
  if AFieldDesc.FieldNo >= (FFirstCalcFieldIdx+1) then begin
    InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);
    FieldInfo := GetFieldInfoStruct( InBuf, 0 );
    nSize := FieldInfo.DataSize;
    if nSize > 0 then begin
      InData	:= IncPtr( InBuf, SizeOf(TSDFieldInfo) );
      OutData	:= Buffer;
      SafeCopyMem( InData, OutData, nSize );
      if AFieldDesc.FieldType = ftString then
        HelperMemWriteByte( OutData, nSize, 0 );
      Result := True;
    end;
    Exit;
  end;

  FieldLenPtr := IncPtr( FFieldLens, (AFieldDesc.FieldNo-1)*SizeOf(nSize{FieldLenPtr^}) );
  nSize := HelperMemReadInt32( FieldLenPtr, 0 );
  Result := nSize > 0;
  if not Result then begin
     //Required fields can not be null
    Result := (nSize <= 0) and (AFieldDesc.FieldType = ftString) and AFieldDesc.Required;
    Exit;
  end;

  OutData := Buffer;
  if RequiredCnvtFieldType(AFieldDesc.FieldType) then begin
    sValue := HelperPtrToString( GetFieldValue(AFieldDesc.FieldNo-1), nSize );
    case AFieldDesc.FieldType of
{$IFDEF SD_VCL4}
    ftLargeInt:
        HelperMemWriteInt64( OutData, 0, StrToInt64Def( sValue, 0 ) );
{$ENDIF}
    ftInteger, ftSmallInt, ftAutoInc:
        HelperMemWriteInt32( OutData, 0, StrToIntDef( sValue, 0 ) );
    ftFloat, ftCurrency:
        HelperMemWriteDouble( OutData, 0, SqlStrToFloatDef( sValue, 0 ) );
    ftTime:
      begin
        dtValue := SqlTimeToDateTime(sValue);
        dtRec.Time := DateTimeToTimeStamp( dtValue ).Time;
        HelperMemWriteDateTimeRec( OutData, 0, dtRec );
      end;
    ftDate, ftDateTime:
      begin
        dtValue := SqlDateToDateTime(sValue);
        if AFieldDesc.FieldType in [ftDate] then
          dtRec.Date := DateTimeToTimeStamp(dtValue).Date
        else
          dtRec.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtValue) );
        HelperMemWriteDateTimeRec( OutData, 0, dtRec );
      end;
    end;	// end of case
  end else begin
    if IsBlobType(AFieldDesc.FieldType) then begin
      Result := False;
      Exit;
    end;
    if AFieldDesc.FieldType = ftString then begin
    	// sometimes MySQL can return more data than it was described for this field
      if nSize > AFieldDesc.DataSize then
        nSize := AFieldDesc.DataSize;
    end;
    if nSize > BufSize then
      nSize := BufSize;
    SafeCopyMem( GetFieldValue(AFieldDesc.FieldNo-1), OutData, nSize );
    if AFieldDesc.FieldType = ftString then begin
      if nSize > (BufSize-1) then
        Dec(nSize);
      HelperMemWriteByte( OutData, nSize, 0 );
    end;
  end;
end;

function TIMyCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  FieldLenPtr: PLongInt;
  BlobSize: LongInt;
  DataPtr: TSDCharPtr;
begin
  DataPtr := nil;
  FieldLenPtr := IncPtr( FFieldLens, (AFieldDesc.FieldNo-1) * SizeOf(BlobSize) );

  BlobSize := HelperMemReadInt32( FieldLenPtr, 0 );
  if BlobSize > 0 then
    DataPtr := GetFieldValue( AFieldDesc.FieldNo-1 );
  if (BlobSize > 0) and Assigned(DataPtr) then begin
    SetLength(BlobData, BlobSize);
{$IFDEF SD_CLR}
    Marshal.Copy( DataPtr, BlobData, 0, BlobSize );
{$ELSE}
    System.Move(DataPtr^, TSDCharPtr(BlobData)^, BlobSize);
{$ENDIF}
  end;

  Result := BlobSize;
end;

function TIMyCommand.FetchNextRow: Boolean;
begin
  Result := False;
	// the statement can't return a result set
  if not Assigned(FHandle) then
    Exit;
    
  FRow := mysql_fetch_row( FHandle );

  SqlDatabase.ResetIdleTimeOut;

  Result := Assigned( FRow );
  if Result then
    FFieldLens := mysql_fetch_lengths( FHandle );
  if Result and (BlobFieldCount > 0) then
    FetchBlobFields;
end;

{ Convert TDateTime to string for SQL statement }
function TIMyCommand.CnvtDateTime2SqlString(Value: TDateTime): string;
  { Format date in ISO format 'yyyy-mm-dd' }
  function FormatSqlDate(Value: TDateTime): string;
  var
    Year, Month, Day: Word;
  begin
    DecodeDate(Value, Year, Month, Day);
    Result := Format('%.4d-%.2d-%.2d', [Year, Month, Day]);
  end;
  { Format time in ISO format 'hh:nn:ss' }
  function FormatSqlTime(Value: TDateTime): string;
  var
    Hour, Min, Sec, MSec: Word;
  begin
    DecodeTime(Value, Hour, Min, Sec, MSec);
    Result := Format('%.2d:%.2d:%.2d', [Hour, Min, Sec]);
  end;

begin
  if Trunc(Value) <> 0 then
    Result := FormatSqlDate(Value)
  else
    Result := '1899-12-30';

  if Frac(Value) <> 0 then begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + FormatSqlTime(Value);
  end;
  Result := '''' + Result + '''';
end;

{ Convert float value to string with '.' delimiter }
function TIMyCommand.CnvtFloat2SqlString(Value: Double): string;
var
  i: Integer;
begin
  Result := FloatToStr(Value);
  if DecimalSeparator <> '.' then begin
    i := Pos(DecimalSeparator,Result);
    if i <> 0 then Result[i] := '.';
  end;
end;

function TIMyCommand.CnvtVarBytes2EscapeString(Value: string): string;
var
  MaxSize: Integer;
  szVal, szRslt: TSDCharPtr;
begin
  MaxSize := 2*Length(Value) + 1;
{$IFDEF SD_CLR}
  szVal := Marshal.StringToHGlobalAnsi(Value);
{$ELSE}
  szVal := TSDCharPtr(Value);
{$ENDIF}
  szRslt := SafeReallocMem( nil, MaxSize );
  try
    if IsAvailFunc('mysql_real_escape_string') then
      MaxSize := mysql_real_escape_string(SqlDatabase.MySQLPtr, szRslt, szVal, Length(Value))
    else
      MaxSize := mysql_escape_string(szRslt, szVal, Length(Value));
    Result := HelperPtrToString( szRslt, MaxSize );	// set length without terminating null
    Result := '''' + Result + '''';
  finally
{$IFDEF SD_CLR}
    Marshal.FreeHGlobal(szVal);
{$ENDIF}
     SafeReallocMem(szRslt, 0);
  end;
end;

procedure TIMyCommand.InternalQBindParams;
const
  ParamPrefix	= ':';
  SqlNullValue	= 'NULL';
  QuoteChar	= '"';	// for surroundings of the parameter's name, which can include, for example, spaces
var
  i: Integer;
  sFullParamName, sValue: string;
begin
  FBindStmt := FStmt;
  if not Assigned(Params) then
    Exit;
    
  for i:=Params.Count-1 downto 0 do begin
    	// set parameter value
    if Params[i].IsNull then begin
      sValue := SqlNullValue
    end else begin
      case Params[i].DataType of
{$IFDEF SD_VCL4}
        ftLargeInt,
{$ENDIF}
        ftInteger,
        ftSmallint,
        ftWord,
        ftAutoInc:	sValue := Params[i].AsString;
        ftBoolean:
          if Params[i].AsBoolean
          then sValue := '1' else sValue := '0';
        ftBytes,
        ftVarBytes,
        ftBlob:
          sValue := CnvtVarBytes2EscapeString(Params[i].AsString);
        ftDate,
        ftTime,
        ftDateTime:	sValue := CnvtDateTime2SqlString(Params[i].AsDateTime);
        ftCurrency,
        ftFloat:	sValue := CnvtFloat2SqlString(Params[i].AsFloat);
      else
        sValue := CnvtVarBytes2EscapeString(Params[i].AsString);
      end;
    end;
	// change a parameter's name on a value of the parameter
    sFullParamName := ParamPrefix + Params[i].Name;
    if not ReplaceString( False, sFullParamName, sValue, FBindStmt ) then begin
    	// if parameter's name is enclosed in double quotation marks
      sFullParamName := Format( '%s%s%s%s', [ParamPrefix, QuoteChar, Params[i].Name, QuoteChar] );
      ReplaceString( False, sFullParamName, sValue, FBindStmt );
    end;
  end;
end;

procedure TIMyCommand.CloseResultSet;
begin
  if Assigned( FHandle ) then
    mysql_free_result(FHandle);
  FBindStmt := '';
  FHandle := nil;
end;

function TIMyCommand.GetAutoIncValue: Integer;
begin
 Result := {$IFDEF SD_D4} FAutoIncID {$ELSE} Trunc( FAutoIncID ) {$ENDIF};
end;

function TIMyCommand.GetRowsAffected: Integer;
begin
  Result := {$IFDEF SD_D4} FRowsAffected {$ELSE} Trunc( FRowsAffected ) {$ENDIF};
end;

procedure TIMyCommand.InitParamList;
begin
  DatabaseError(SNoCapability);
end;

procedure TIMyCommand.GetOutputParams;
begin
  DatabaseError(SNoCapability);
end;

function TIMyCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
    FIELD_TYPE_LONGLONG:
{$IFDEF SD_VCL4}
      Result := ftLargeInt;
{$ELSE}
      Result := ftInteger;
{$ENDIF}
    FIELD_TYPE_TINY, FIELD_TYPE_YEAR, FIELD_TYPE_LONG, FIELD_TYPE_SHORT,
    FIELD_TYPE_INT24:
      Result := ftInteger;
    FIELD_TYPE_DECIMAL, FIELD_TYPE_FLOAT, FIELD_TYPE_DOUBLE:
      Result := ftFloat;
    FIELD_TYPE_DATE, FIELD_TYPE_NEWDATE:
      Result := ftDate;
    FIELD_TYPE_TIME:
      Result := ftTime;
    FIELD_TYPE_DATETIME:
      Result := ftDateTime;
    FIELD_TYPE_TINY_BLOB, FIELD_TYPE_MEDIUM_BLOB, FIELD_TYPE_LONG_BLOB,
    FIELD_TYPE_BLOB:
      Result := ftBlob;
    else
      Result := ftString;
  end;
end;

function TIMyCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to C(Program) Data Type(ODBC) }
  MySqlDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	FIELD_TYPE_STRING, FIELD_TYPE_SHORT, FIELD_TYPE_LONG, FIELD_TYPE_SHORT, FIELD_TYPE_SHORT,
	// ftFloat, ftCurrency, ftBCD, 	ftDate, 	ftTime
        FIELD_TYPE_FLOAT, FIELD_TYPE_DECIMAL, 0, FIELD_TYPE_DATE, FIELD_TYPE_TIME,
        // ftDateTime, 		ftBytes, ftVarBytes, ftAutoInc, ftBlob
        FIELD_TYPE_DATETIME, 0, 0, FIELD_TYPE_LONG, FIELD_TYPE_LONG_BLOB,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        FIELD_TYPE_LONG_BLOB, FIELD_TYPE_LONG_BLOB, FIELD_TYPE_LONG_BLOB,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	FIELD_TYPE_LONGLONG,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  Result := MySqlDataTypeMap[FieldType];
end;

function TIMyCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  MySqlDataSizeMap: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	0,	2, 	SizeOf(Integer), 	2, 	2,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        SizeOf(Double), SizeOf(Double),	0, 0, 0,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        0, 	0, 	0, SizeOf(Integer), 	0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  case FieldType of
    ftDate,
    ftTime,
    ftDateTime:
      Result := SizeOf(TDateTimeRec);
  else
    Result := MySqlDataSizeMap[FieldType];
  end;
end;

function TIMyCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in
  	[ftInteger, {$IFDEF SD_VCL4}ftLargeInt,{$ENDIF} ftSmallInt, ftAutoInc,
         ftFloat, ftCurrency,
         ftDate, ftTime, ftDateTime];
end;


{ TIMyCommandShowTables }
constructor TIMyCommandShowTables.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);
  FTableNames 	:= '';
  FIsSysTables	:= False;
  FCatNameFieldIdx	:= 0;
  FSchNameFieldIdx	:= 0;
  FTblTypeFieldIdx	:= 0;
end;

procedure TIMyCommandShowTables.DoExecDirect(Value: string);
var
  sStmt: string;
begin
  if TableNames <> '' then
    sStmt := Format(' like ''%s''', [TableNames]);
  if IsSysTables then
    sStmt := ' FROM mysql' + sStmt;
  sStmt := SQueryMySqlTableNames + sStmt;

  inherited DoExecDirect(sStmt);
end;

procedure TIMyCommandShowTables.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
    end;

  with Descs.AddFieldDesc do begin
    FieldName	:= CAT_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FCatNameFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= SCH_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FSchNameFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= TBL_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
  FTblTypeFieldIdx := Descs.Count-1;
end;

function TIMyCommandShowTables.FetchNextRow: Boolean;
var
  FldBuf: TSDPtr;
  FieldInfo: TSDFieldInfo;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  FldBuf := GetFieldBuffer(FieldDescs[FCatNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  FldBuf := GetFieldBuffer(FieldDescs[FSchNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );

  FldBuf := GetFieldBuffer(FieldDescs[FTblTypeFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := FieldDescs[FTblTypeFieldIdx].DataSize;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), ttTable );	// set field data
end;

{ TIMyCommandShowColumns }
constructor TIMyCommandShowColumns.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);
  FTableName := '';
  FCatNameFieldIdx	:= 0;
  FSchNameFieldIdx	:= 0;
  FTblNameFieldIdx	:= 0;
  FColLenFieldIdx	:= 0;
  FColPrecFieldIdx	:= 0;
  FColScaleFieldIdx	:= 0;
  FColNullFieldIdx	:= 0;
end;

procedure TIMyCommandShowColumns.DoExecDirect(Value: string);
var
  sStmt: string;
begin
  sStmt := Format(SQueryMySqlTableFieldNamesFmt, [TableName]);
  inherited DoExecDirect(sStmt);
end;

procedure TIMyCommandShowColumns.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := COL_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := COL_TYPENAME_FIELD;
      5: Descs.FieldDescs[i].FieldName := COL_DEFAULT_FIELD;
    end;

  with Descs.AddFieldDesc do begin
    FieldName	:= CAT_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FCatNameFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= SCH_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FSchNameFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= TBL_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FTblNameFieldIdx := Descs.Count-1;

  with Descs.AddFieldDesc do begin
    FieldName	:= COL_LENGTH_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= False;
  end;
  FColLenFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= COL_PREC_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= False;
  end;
  FColPrecFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= COL_SCALE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= False;
  end;
  FColScaleFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= COL_NULLABLE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= False;
  end;
  FColNullFieldIdx := Descs.Count-1;
end;

function TIMyCommandShowColumns.FetchNextRow: Boolean;
const
  ColTypeFieldIdx = 1;
  ColOldNullFieldIdx = 2;
  function GetFieldLen(const ATypeName: string; AVarLen: Integer): Integer;
  begin
    Result := 0;
    if (Pos('int', ATypeName) = 1) or
       (Pos('tinyint', ATypeName) = 1) or
       (Pos('smallint', ATypeName) = 1) or
       (Pos('mediumint', ATypeName) = 1) or
       (Pos('bigint', ATypeName) = 1)
    then Result := NativeDataSize(ftInteger)
    else if (Pos('real', ATypeName) = 1) or (Pos('double', ATypeName) = 1) or
        (Pos('float', ATypeName) = 1) or (Pos('decimal', ATypeName) = 1) or
        (Pos('numeric', ATypeName) = 1)
    then Result := NativeDataSize(ftFloat)
    else if (Pos('char', ATypeName) >= 1) then
      Result := AVarLen
    else if (Pos('time', ATypeName) >= 1) or (Pos('date', ATypeName) >= 1)
    then Result := NativeDataSize(ftDateTime)
  end;
var
  FldBuf: TSDPtr;
  FieldInfo: TSDFieldInfo;
  FieldLenPtr: PLongInt;
  FieldLen: LongInt;
  sTypeName, sTypeSize: string;
  c: AnsiChar;
  i, Prec, Scale: Integer;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  Prec := 0;
  Scale := 0;
  c := #$0;

  FldBuf := GetFieldBuffer(FieldDescs[FCatNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  FldBuf := GetFieldBuffer(FieldDescs[FSchNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );

  FldBuf := GetFieldBuffer(FieldDescs[FTblNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := Length(TableName);
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  HelperMemWriteString( FldBuf, SizeOf(TSDFieldInfo), FTableName, Length(TableName) );
  HelperMemWriteByte( FldBuf, SizeOf(TSDFieldInfo) + Length(TableName), 0 );

  FieldLenPtr := IncPtr( FFieldLens, (FieldDescs[ColTypeFieldIdx].FieldNo-1)*SizeOf(FieldLen) );
  FieldLen := HelperMemReadInt32( FieldLenPtr, 0 );
  if FieldLen > 0 then begin
    sTypeName := HelperPtrToString( GetFieldValue(FieldDescs[ColTypeFieldIdx].FieldNo-1), FieldLen );
    i := Pos('(', sTypeName);
    if i > 0 then begin
      sTypeSize := Copy(sTypeName, i, Length(sTypeName)-i+1);
      	// remove brackets
      if sTypeSize[1] = '(' then
        sTypeSize := Copy(sTypeSize, 2, Length(sTypeSize)-1);
      if sTypeSize[Length(sTypeSize)] = ')' then
        SetLength(sTypeSize, Length(sTypeSize)-1);
      SetLength(sTypeName, i-1);
    end;

    i := Pos(',', sTypeSize);
    if i > 0 then begin
      Prec := StrToIntDef(Copy(sTypeSize, 1, i-1), 0);
      Scale := StrToIntDef(Copy(sTypeSize, i+1, Length(sTypeSize)-i), 0);
      Prec := Prec + Scale;
    end else
      Prec := StrToIntDef(sTypeSize, 0);
  end;

  FldBuf := GetFieldBuffer(FieldDescs[FColPrecFieldIdx].FieldNo, FieldsBuffer);
  if Prec > 0 then begin
    FieldInfo.FetchStatus := indVALUE;
    FieldInfo.DataSize := NativeDataSize(FieldDescs[FColPrecFieldIdx].FieldType);
    HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), Prec );
  end else begin
    FieldInfo.FetchStatus := indNULL;
    FieldInfo.DataSize := 0;
  end;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );

  FldBuf := GetFieldBuffer(FieldDescs[FColScaleFieldIdx].FieldNo, FieldsBuffer);
  if Scale > 0 then begin
    FieldInfo.FetchStatus := indVALUE;
    FieldInfo.DataSize := NativeDataSize(FieldDescs[FColScaleFieldIdx].FieldType);
    HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), Scale );
  end else begin
    FieldInfo.FetchStatus := indNULL;
    FieldInfo.DataSize := 0;
  end;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );

  FldBuf := GetFieldBuffer(FieldDescs[FColLenFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := NativeDataSize(FieldDescs[FColLenFieldIdx].FieldType);
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), GetFieldLen(sTypeName, Prec) );

  FieldLenPtr := IncPtr( FFieldLens, (FieldDescs[ColTypeFieldIdx].FieldNo-1) * SizeOf(FieldLen) );
  FieldLen := HelperMemReadInt32( FieldLenPtr, 0 );
  if FieldLen > 0 then
    c := AnsiChar( HelperMemReadByte( GetFieldValue( FieldDescs[ColOldNullFieldIdx].FieldNo-1 ), 0 ) );
  FldBuf := GetFieldBuffer(FieldDescs[FColNullFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := NativeDataSize(FieldDescs[FColNullFieldIdx].FieldType);
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  if c in ['Y', 'y'] then
    c := #$1;
  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), Ord(c) );
end;

{ TIMyCommandShowIndexes }

constructor TIMyCommandShowIndexes.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);
  FTableName := '';
  FCatNameFieldIdx	:= 0;
  FSchNameFieldIdx	:= 0;
  FIdxTypeFieldIdx	:= 0;
  FIdxFilterFieldIdx	:= 0;
end;

procedure TIMyCommandShowIndexes.DoExecDirect(Value: string);
var
  sStmt: string;
begin
  sStmt := Format(SQueryMySqlIndexNamesFmt, [TableName]);
  inherited DoExecDirect(sStmt);
end;

procedure TIMyCommandShowIndexes.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := IDX_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := IDX_COL_POS_FIELD;
      5: Descs.FieldDescs[i].FieldName := IDX_COL_NAME_FIELD;
      6: Descs.FieldDescs[i].FieldName := IDX_SORT_FIELD;
      11:Descs.FieldDescs[i].FieldName := OLD_FIELD_PREFIX + Descs.FieldDescs[i].FieldName;
    end;

  with Descs.AddFieldDesc do begin
    FieldName	:= CAT_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FCatNameFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= SCH_NAME_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FSchNameFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= IDX_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= False;
  end;
  FIdxTypeFieldIdx := Descs.Count-1;
  with Descs.AddFieldDesc do begin
    FieldName	:= IDX_FILTER_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftString;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= IdentNameLen;
    Precision	:= 0;
    Required	:= False;
  end;
  FIdxFilterFieldIdx := Descs.Count-1;
end;

function TIMyCommandShowIndexes.FetchNextRow: Boolean;
const
  IdxNonUniqueFieldIdx = 1;
var
  FldBuf: TSDPtr;
  FieldInfo: TSDFieldInfo;
  FieldLenPtr: PLongInt;
  FieldLen: LongInt;
  sVal: string;
  IdxType: Integer;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  FldBuf := GetFieldBuffer(FieldDescs[FCatNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  FldBuf := GetFieldBuffer(FieldDescs[FSchNameFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  FldBuf := GetFieldBuffer(FieldDescs[FIdxFilterFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indNULL;
  FieldInfo.DataSize := 0;
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );

  sVal := '';
  FieldLenPtr := IncPtr( FFieldLens, (FieldDescs[IdxNonUniqueFieldIdx].FieldNo-1) * SizeOf(FieldLen) );
  FieldLen := HelperMemReadInt32( FieldLenPtr, 0 );
  if FieldLen > 0 then
    sVal := HelperPtrToString( GetFieldValue(FieldDescs[IdxNonUniqueFieldIdx].FieldNo-1), FieldLen );
  IdxType := StrToIntDef(sVal, -1);
  if IdxType = 0 then
    IdxType := UniqueIndexType
  else if IdxType = 1 then
    IdxType := NonUniqueIndexType
  else
    IdxType := 0;
  FldBuf := GetFieldBuffer(FieldDescs[FIdxTypeFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo.FetchStatus := indVALUE;
  FieldInfo.DataSize := NativeDataSize(FieldDescs[FIdxTypeFieldIdx].FieldType);
  SetFieldInfoStruct( FldBuf, 0, FieldInfo );
  HelperMemWriteInt32( FldBuf, SizeOf(TSDFieldInfo), IdxType );
end;


initialization
  hSqlLibModule := 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.
