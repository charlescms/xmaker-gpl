
{**********************************************************}
{							   }
{       Delphi SQLDirect Component Library		   }
{	ODBC 3.0 Interface Unit		 		   }
{                                                          }
{       Copyright (c) 1997,2005 by Yuri Sheino		   }
{                                                          }
{**********************************************************}
{$I SqlDir.inc}
unit SDOdbc {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, SyncObjs,
{$IFDEF SD_VCL5}
  ComObj,
{$ENDIF}
{$IFDEF SD_VCL6}
  Variants,
{$ENDIF}
{$IFDEF SD_CLR}
  System.Text, System.Runtime.InteropServices,
{$ENDIF}
  SDConsts, SDCommon;

const
	{ column names for ODBC metadata functions(SQLTables and other) }
  ODBC_TBL_SCH_NAME_FIELD 	= 'TABLE_SCHEM';
  ODBC_TBL_NAME_FIELD 	= 'TABLE_NAME';
  ODBC_TBL_TYPE_NAME_FIELD 	= 'TABLE_TYPE';
  ODBC_COL_NAME_FIELD 	= 'COLUMN_NAME';
  ODBC_PROC_NAME_FIELD 	= 'PROCEDURE_NAME';
  ODBC_PROC_SCH_NAME_FIELD 	= 'PROCEDURE_SCHEM';


{********************************************************************
** SQL.H - This is the the main include for ODBC Core functions.
**
**      Updated 5/12/93 for 2.00 specification
**      Updated 5/23/94 for 2.01 specification
**      Updated 11/10/94 for 2.10 specification
**      Updated 04/10/95 for 2.50 specification
**      Updated 6/6/95  for 3.00 specification
*********************************************************************}
const
// special length/indicator values
  SQL_VALUE_DATA	=  0;
  SQL_NULL_DATA       	= -1;
  SQL_DATA_AT_EXEC    	= -2;

// return values from functions - RETCODE values
  SQL_SUCCESS           = 0;
  SQL_SUCCESS_WITH_INFO = 1;
  SQL_STILL_EXECUTING   = 2;
  SQL_NEED_DATA         = 99;
  SQL_NO_DATA           = 100;
  SQL_NO_DATA_FOUND    	= SQL_NO_DATA;
  SQL_ERROR             = -1;
  SQL_INVALID_HANDLE    = -2;

// flags for null-terminated string
  SQL_NTS             	= -3;      	// NTS = Null Terminated String
  SQL_NTSL            	= Longint(-3);	// NTS = Null Terminated String

// maximum message length
  SQL_MAX_MESSAGE_LENGTH= 512;

// date/time length constants
  SQL_DATE_LEN          = 10;
  SQL_TIME_LEN          = 8;  	// add P+1 if precision is nonzero
  SQL_TIMESTAMP_LEN	= 19;	// add P+1 if precision is nonzero

// handle type identifiers
  SQL_HANDLE_ENV        = 1;
  SQL_HANDLE_DBC        = 2;
  SQL_HANDLE_STMT       = 3;
  SQL_HANDLE_DESC       = 4;

// Environment attributes; note SQL_CONNECTTYPE, SQL_SYNC_POINT are also
// environment attributes that are settable at the connection level
  SQL_ATTR_OUTPUT_NTS  	= 10001;

// connection attributes
  SQL_ATTR_AUTO_IPD            	= 10001;
  SQL_ATTR_METADATA_ID         	= 10014;

// statement attributes for SQLGetStmtOption/SQLSetStmtOption
  SQL_ATTR_APP_ROW_DESC        	= 10010;
  SQL_ATTR_APP_PARAM_DESC      	= 10011;
  SQL_ATTR_IMP_ROW_DESC        	= 10012;
  SQL_ATTR_IMP_PARAM_DESC      	= 10013;
  SQL_ATTR_CURSOR_SCROLLABLE   	= (-1);
  SQL_ATTR_CURSOR_SENSITIVITY  	= (-2);

// SQL_ATTR_CURSOR_SCROLLABLE values
  SQL_NONSCROLLABLE            	= 0;
  SQL_SCROLLABLE               	= 1;

// identifiers of fields in the SQL descriptor
  SQL_DESC_COUNT                = 1001;
  SQL_DESC_TYPE                 = 1002;
  SQL_DESC_LENGTH               = 1003;
  SQL_DESC_OCTET_LENGTH_PTR     = 1004;
  SQL_DESC_PRECISION            = 1005;
  SQL_DESC_SCALE                = 1006;
  SQL_DESC_DATETIME_INTERVAL_CODE=1007;
  SQL_DESC_NULLABLE             = 1008;
  SQL_DESC_INDICATOR_PTR        = 1009;
  SQL_DESC_DATA_PTR             = 1010;
  SQL_DESC_NAME                 = 1011;
  SQL_DESC_UNNAMED              = 1012;
  SQL_DESC_OCTET_LENGTH         = 1013;
  SQL_DESC_ALLOC_TYPE           = 1099;

// identifiers of fields in the diagnostics area
  SQL_DIAG_RETURNCODE       	= 1;
  SQL_DIAG_NUMBER           	= 2;
  SQL_DIAG_ROW_COUNT        	= 3;
  SQL_DIAG_SQLSTATE         	= 4;
  SQL_DIAG_NATIVE           	= 5;
  SQL_DIAG_MESSAGE_TEXT     	= 6;
  SQL_DIAG_DYNAMIC_FUNCTION 	= 7;
  SQL_DIAG_CLASS_ORIGIN     	= 8;
  SQL_DIAG_SUBCLASS_ORIGIN  	= 9;
  SQL_DIAG_CONNECTION_NAME  	= 10;
  SQL_DIAG_SERVER_NAME     	= 11;
  SQL_DIAG_DYNAMIC_FUNCTION_CODE= 12;

// dynamic function codes
  SQL_DIAG_ALTER_DOMAIN		=  3;
  SQL_DIAG_ALTER_TABLE         	=  4;
  SQL_DIAG_CALL			=  7;
  SQL_DIAG_CREATE_ASSERTION	=  6;
  SQL_DIAG_CREATE_CHARACTER_SET	=  8;
  SQL_DIAG_CREATE_COLLATION	= 10;
  SQL_DIAG_CREATE_DOMAIN 	= 23;
  SQL_DIAG_CREATE_SCHEMA 	= 64;
  SQL_DIAG_CREATE_INDEX        	= -1;
  SQL_DIAG_CREATE_TABLE        	= 77;
  SQL_DIAG_CREATE_TRANSLATION 	= 79;
  SQL_DIAG_CREATE_VIEW         	= 84;
  SQL_DIAG_DELETE_WHERE        	= 19;
  SQL_DIAG_DROP_ASSERTION 	= 24;
  SQL_DIAG_DROP_CHARACTER_SET 	= 25;
  SQL_DIAG_DROP_COLLATION      	= 26;
  SQL_DIAG_DROP_DOMAIN		= 27;
  SQL_DIAG_DROP_INDEX          	= -2;
  SQL_DIAG_DROP_SCHEMA	    	= 31;
  SQL_DIAG_DROP_TABLE          	= 32;
  SQL_DIAG_DROP_TRANSLATION     = 33;
  SQL_DIAG_DROP_VIEW           	= 36;
  SQL_DIAG_DYNAMIC_DELETE_CURSOR= 38;
  SQL_DIAG_DYNAMIC_UPDATE_CURSOR= 81;
  SQL_DIAG_GRANT               	= 48;
  SQL_DIAG_INSERT              	= 50;
  SQL_DIAG_REVOKE              	= 59;
  SQL_DIAG_SELECT_CURSOR       	= 85;
  SQL_DIAG_UNKNOWN_STATEMENT   	=  0;
  SQL_DIAG_UPDATE_WHERE        	= 82;

// Standard SQL data type codes
  SQL_UNKNOWN_TYPE     	= 0;
  SQL_CHAR             	= 1;
  SQL_NUMERIC          	= 2;
  SQL_DECIMAL          	= 3;
  SQL_INTEGER          	= 4;
  SQL_SMALLINT         	= 5;
  SQL_FLOAT            	= 6;
  SQL_REAL             	= 7;
  SQL_DOUBLE           	= 8;
  SQL_DATETIME         	= 9;
  SQL_VARCHAR          	=12;

// One-parameter shortcuts for date/time data types
  SQL_TYPE_DATE     	= 91;
  SQL_TYPE_TIME     	= 92;
  SQL_TYPE_TIMESTAMP	= 93;

// Statement attribute values for cursor sensitivity
  SQL_UNSPECIFIED    	= 0;
  SQL_INSENSITIVE    	= 1;
  SQL_SENSITIVE      	= 2;

// SQLGetTypeInfo() request for all data types
  SQL_ALL_TYPES        	= 0;

// Default conversion code for SQLBindCol(), SQLBindParam() and SQLGetData()
  SQL_DEFAULT       	= 99;

// SQLGetData() code indicating that the application row descriptor specifies the data type
  SQL_ARD_TYPE      	= (-99);

// SQL date/time type subcodes
  SQL_CODE_DATE      	= 1;
  SQL_CODE_TIME      	= 2;
  SQL_CODE_TIMESTAMP 	= 3;

// CLI attribute/option values
  SQL_FALSE            	= 0;
  SQL_TRUE             	= 1;

// values of NULLABLE field in descriptor
  SQL_NO_NULLS        	= 0;
  SQL_NULLABLE        	= 1;

// NULL status defines; these are used in SQLColAttributes, SQLDescribeCol,
// to describe the nullability of a column in a table.
  SQL_NULLABLE_UNKNOWN	= 2;

// Values returned by SQLGetTypeInfo() to show WHERE clause supported
  SQL_PRED_NONE  	= 0;
  SQL_PRED_CHAR        	= 1;
  SQL_PRED_BASIC       	= 2;

// values of UNNAMED field in descriptor used in SQLColAttribute
  SQL_NAMED            	= 0;
  SQL_UNNAMED          	= 1;

// values of ALLOC_TYPE field in descriptor
  SQL_DESC_ALLOC_AUTO	= 1;
  SQL_DESC_ALLOC_USER	= 2;

// SQLFreeStmt option values
  SQL_CLOSE            	= 0;
  SQL_DROP             	= 1;
  SQL_UNBIND           	= 2;
  SQL_RESET_PARAMS     	= 3;

// Codes used for FetchOrientation in SQLFetchScroll(), and in SQLDataSources()
  SQL_FETCH_NEXT       	= 1;
  SQL_FETCH_FIRST      	= 2;

// Other codes used for FetchOrientation in SQLFetchScroll()
  SQL_FETCH_LAST     	= 3;
  SQL_FETCH_PRIOR    	= 4;
  SQL_FETCH_ABSOLUTE 	= 5;
  SQL_FETCH_RELATIVE 	= 6;

// SQLEndTran() and SQLTransact() option values
  SQL_COMMIT           	= 0;
  SQL_ROLLBACK         	= 1;

// null handles returned by SQLAllocHandle()
  SQL_NULL_HENV      	= 0;
  SQL_NULL_HDBC      	= 0;
  SQL_NULL_HSTMT     	= 0;
  SQL_NULL_HDESC     	= 0;

// null handle used in place of parent handle when allocating HENV
  SQL_NULL_HANDLE	= 0;

// Values that may appear in the result set of SQLSpecialColumns()
  SQL_SCOPE_CURROW     	= 0;
  SQL_SCOPE_TRANSACTION	= 1;
  SQL_SCOPE_SESSION    	= 2;

// Defines for SQLSpecialColumns (returned in the result set)
  SQL_PC_UNKNOWN       	= 0;
  SQL_PC_NON_PSEUDO    	= 1;
  SQL_PC_PSEUDO        	= 2;

// Reserved value for the IdentifierType argument of SQLSpecialColumns()
  SQL_ROW_IDENTIFIER 	= 1;

// Reserved values for UNIQUE argument of SQLStatistics()
  SQL_INDEX_UNIQUE     	= 0;
  SQL_INDEX_ALL        	= 1;

// Values that may appear in the result set of SQLStatistics()
  SQL_INDEX_CLUSTERED  	= 1;
  SQL_INDEX_HASHED     	= 2;
  SQL_INDEX_OTHER      	= 3;

// SQLGetFunctions() values to identify ODBC APIs - supported functions
  SQL_API_SQLALLOCCONNECT	=  1;
  SQL_API_SQLALLOCENV          	=  2;
  SQL_API_SQLALLOCHANDLE       	= 1001;
  SQL_API_SQLALLOCSTMT         	=  3;
  SQL_API_SQLBINDCOL           	=  4;
  SQL_API_SQLBINDPARAM         	=  1002;
  SQL_API_SQLCANCEL            	=  5;
  SQL_API_SQLCLOSECURSOR       	= 1003;
  SQL_API_SQLCOLATTRIBUTE      	= 6;
  SQL_API_SQLCOLUMNS           	= 40;
  SQL_API_SQLCONNECT           	=  7;
  SQL_API_SQLCOPYDESC          	=  1004;
  SQL_API_SQLDATASOURCES       	= 57;
  SQL_API_SQLDESCRIBECOL       	=  8;
  SQL_API_SQLDISCONNECT        	=  9;
  SQL_API_SQLENDTRAN           	= 1005;
  SQL_API_SQLERROR             	= 10;
  SQL_API_SQLEXECDIRECT        	= 11;
  SQL_API_SQLEXECUTE           	= 12;
  SQL_API_SQLFETCH             	= 13;
  SQL_API_SQLFETCHSCROLL       	= 1021;
  SQL_API_SQLFREECONNECT       	= 14;
  SQL_API_SQLFREEENV           	= 15;
  SQL_API_SQLFREEHANDLE        	= 1006;
  SQL_API_SQLFREESTMT          	= 16;
  SQL_API_SQLGETCONNECTATTR    	= 1007;
  SQL_API_SQLGETCONNECTOPTION  	= 42;
  SQL_API_SQLGETCURSORNAME     	= 17;
  SQL_API_SQLGETDATA           	= 43;
  SQL_API_SQLGETDESCFIELD      	= 1008;
  SQL_API_SQLGETDESCREC        	= 1009;
  SQL_API_SQLGETDIAGFIELD      	= 1010;
  SQL_API_SQLGETDIAGREC        	= 1011;
  SQL_API_SQLGETENVATTR        	= 1012;
  SQL_API_SQLGETFUNCTIONS      	= 44;
  SQL_API_SQLGETINFO           	= 45;
  SQL_API_SQLGETSTMTATTR       	= 1014;
  SQL_API_SQLGETSTMTOPTION     	= 46;
  SQL_API_SQLGETTYPEINFO       	= 47;
  SQL_API_SQLNUMRESULTCOLS     	= 18;
  SQL_API_SQLPARAMDATA         	= 48;
  SQL_API_SQLPREPARE           	= 19;
  SQL_API_SQLPUTDATA           	= 49;
  SQL_API_SQLROWCOUNT          	= 20;
  SQL_API_SQLSETCONNECTATTR    	= 1016;
  SQL_API_SQLSETCONNECTOPTION  	= 50;
  SQL_API_SQLSETCURSORNAME     	= 21;
  SQL_API_SQLSETDESCFIELD      	= 1017;
  SQL_API_SQLSETDESCREC        	= 1018;
  SQL_API_SQLSETENVATTR        	= 1019;
  SQL_API_SQLSETPARAM          	= 22;
  SQL_API_SQLSETSTMTATTR       	= 1020;
  SQL_API_SQLSETSTMTOPTION     	= 51;
  SQL_API_SQLSPECIALCOLUMNS    	= 52;
  SQL_API_SQLSTATISTICS        	= 53;
  SQL_API_SQLTABLES            	= 54;
  SQL_API_SQLTRANSACT          	= 23;

// Information requested by SQLGetInfo()
  SQL_MAX_DRIVER_CONNECTIONS    	= 0;
  SQL_MAXIMUM_DRIVER_CONNECTIONS       	= SQL_MAX_DRIVER_CONNECTIONS;
  SQL_MAX_CONCURRENT_ACTIVITIES       	= 1;
  SQL_MAXIMUM_CONCURRENT_ACTIVITIES    	= SQL_MAX_CONCURRENT_ACTIVITIES;
  SQL_DATA_SOURCE_NAME              	=  2;
  SQL_FETCH_DIRECTION                  	=  8;
  SQL_SERVER_NAME                      	= 13;
  SQL_SEARCH_PATTERN_ESCAPE            	= 14;
  SQL_DBMS_NAME                        	= 17;
  SQL_DBMS_VER                         	= 18;
  SQL_ACCESSIBLE_TABLES                	= 19;
  SQL_ACCESSIBLE_PROCEDURES            	= 20;
  SQL_CURSOR_COMMIT_BEHAVIOR           	= 23;
  SQL_DATA_SOURCE_READ_ONLY            	= 25;
  SQL_DEFAULT_TXN_ISOLATION            	= 26;
  SQL_IDENTIFIER_CASE                  	= 28;
  SQL_IDENTIFIER_QUOTE_CHAR            	= 29;
  SQL_MAX_COLUMN_NAME_LEN              	= 30;
  SQL_MAXIMUM_COLUMN_NAME_LENGTH       	= SQL_MAX_COLUMN_NAME_LEN;
  SQL_MAX_CURSOR_NAME_LEN              	= 31;
  SQL_MAXIMUM_CURSOR_NAME_LENGTH       	= SQL_MAX_CURSOR_NAME_LEN;
  SQL_MAX_SCHEMA_NAME_LEN        	= 32;
  SQL_MAXIMUM_SCHEMA_NAME_LENGTH	= SQL_MAX_SCHEMA_NAME_LEN;
  SQL_MAX_CATALOG_NAME_LEN           	= 34;
  SQL_MAXIMUM_CATALOG_NAME_LENGTH	= SQL_MAX_CATALOG_NAME_LEN;
  SQL_MAX_TABLE_NAME_LEN               	= 35;
  SQL_SCROLL_CONCURRENCY               	= 43;
  SQL_TXN_CAPABLE                      	= 46;
  SQL_TRANSACTION_CAPABLE              	= SQL_TXN_CAPABLE;
  SQL_USER_NAME                        	= 47;
  SQL_TXN_ISOLATION_OPTION             	= 72;
  SQL_TRANSACTION_ISOLATION_OPTION     	= SQL_TXN_ISOLATION_OPTION;
  SQL_INTEGRITY                      	= 73;
  SQL_GETDATA_EXTENSIONS               	= 81;
  SQL_NULL_COLLATION                   	= 85;
  SQL_ALTER_TABLE                      	= 86;
  SQL_ORDER_BY_COLUMNS_IN_SELECT       	= 90;
  SQL_SPECIAL_CHARACTERS               	= 94;
  SQL_MAX_COLUMNS_IN_GROUP_BY          	= 97;
  SQL_MAXIMUM_COLUMNS_IN_GROUP_BY      	= SQL_MAX_COLUMNS_IN_GROUP_BY;
  SQL_MAX_COLUMNS_IN_INDEX             	= 98;
  SQL_MAXIMUM_COLUMNS_IN_INDEX         	= SQL_MAX_COLUMNS_IN_INDEX;
  SQL_MAX_COLUMNS_IN_ORDER_BY          	= 99;
  SQL_MAXIMUM_COLUMNS_IN_ORDER_BY      	= SQL_MAX_COLUMNS_IN_ORDER_BY;
  SQL_MAX_COLUMNS_IN_SELECT           	= 100;
  SQL_MAXIMUM_COLUMNS_IN_SELECT       	= SQL_MAX_COLUMNS_IN_SELECT;
  SQL_MAX_COLUMNS_IN_TABLE            	= 101;
  SQL_MAX_INDEX_SIZE                  	= 102;
  SQL_MAXIMUM_INDEX_SIZE              	= SQL_MAX_INDEX_SIZE;
  SQL_MAX_ROW_SIZE                    	= 104;
  SQL_MAXIMUM_ROW_SIZE                	= SQL_MAX_ROW_SIZE;
  SQL_MAX_STATEMENT_LEN               	= 105;
  SQL_MAXIMUM_STATEMENT_LENGTH        	= SQL_MAX_STATEMENT_LEN;
  SQL_MAX_TABLES_IN_SELECT            	= 106;
  SQL_MAXIMUM_TABLES_IN_SELECT        	= SQL_MAX_TABLES_IN_SELECT;
  SQL_MAX_USER_NAME_LEN               	= 107;
  SQL_MAXIMUM_USER_NAME_LENGTH        	= SQL_MAX_USER_NAME_LEN;

  SQL_OJ_CAPABILITIES                	= 115;
  SQL_OUTER_JOIN_CAPABILITIES        	= SQL_OJ_CAPABILITIES;

  SQL_XOPEN_CLI_YEAR               	= 10000;
  SQL_CURSOR_SENSITIVITY           	= 10001;
  SQL_DESCRIBE_PARAMETER           	= 10002;
  SQL_CATALOG_NAME                 	= 10003;
  SQL_COLLATION_SEQ                	= 10004;
  SQL_MAX_IDENTIFIER_LEN           	= 10005;
  SQL_MAXIMUM_IDENTIFIER_LENGTH    	= SQL_MAX_IDENTIFIER_LEN;

// SQL_ALTER_TABLE bitmasks
  SQL_AT_ADD_COLUMN           	= $00000001;
  SQL_AT_DROP_COLUMN           	= $00000002;
  SQL_AT_ADD_CONSTRAINT        	= $00000008;

// SQL_ASYNC_MODE values
  SQL_AM_NONE       	= 0;
  SQL_AM_CONNECTION	= 1;
  SQL_AM_STATEMENT 	= 2;

// SQL_CURSOR_COMMIT_BEHAVIOR and SQL_CURSOR_ROLLBACK_BEHAVIOR values
  SQL_CB_DELETE                	= $0000;
  SQL_CB_CLOSE                 	= $0001;
  SQL_CB_PRESERVE              	= $0002;

// SQL_FETCH_DIRECTION bitmasks

// SQL_FETCH_DIRECTION masks
  SQL_FD_FETCH_NEXT           	= $00000001;
  SQL_FD_FETCH_FIRST          	= $00000002;
  SQL_FD_FETCH_LAST           	= $00000004;
  SQL_FD_FETCH_PRIOR          	= $00000008;
  SQL_FD_FETCH_ABSOLUTE       	= $00000010;
  SQL_FD_FETCH_RELATIVE       	= $00000020;

// SQL_GETDATA_EXTENSIONS bitmasks
  SQL_GD_ANY_COLUMN            	= $00000001;
  SQL_GD_ANY_ORDER             	= $00000002;

// SQL_IDENTIFIER_CASE values
  SQL_IC_UPPER       	 	= $0001;
  SQL_IC_LOWER        		= $0002;
  SQL_IC_SENSITIVE    		= $0003;
  SQL_IC_MIXED        		= $0004;

// SQL_OJ_CAPABILITIES bitmasks. NB: this means 'outer join', not what  you may be thinking
  SQL_OJ_LEFT                  	= $00000001;
  SQL_OJ_RIGHT                 	= $00000002;
  SQL_OJ_FULL                  	= $00000004;
  SQL_OJ_NESTED                	= $00000008;
  SQL_OJ_NOT_ORDERED           	= $00000010;
  SQL_OJ_INNER                 	= $00000020;
  SQL_OJ_ALL_COMPARISON_OPS    	= $00000040;

// SQL_SCROLL_CONCURRENCY bitmasks
  SQL_SCCO_READ_ONLY           	= $00000001;
  SQL_SCCO_LOCK                	= $00000002;
  SQL_SCCO_OPT_ROWVER          	= $00000004;
  SQL_SCCO_OPT_VALUES          	= $00000008;

// SQL_TXN_CAPABLE values
  SQL_TC_NONE                  	= $0000;
  SQL_TC_DML                   	= $0001;
  SQL_TC_ALL                   	= $0002;
  SQL_TC_DDL_COMMIT            	= $0003;
  SQL_TC_DDL_IGNORE            	= $0004;

// SQL_TXN_ISOLATION_OPTION bitmasks
  SQL_TXN_READ_UNCOMMITTED        	= $00000001;
  SQL_TRANSACTION_READ_UNCOMMITTED	= SQL_TXN_READ_UNCOMMITTED;
  SQL_TXN_READ_COMMITTED          	= $00000002;
  SQL_TRANSACTION_READ_COMMITTED  	= SQL_TXN_READ_COMMITTED;
  SQL_TXN_REPEATABLE_READ         	= $00000004;
  SQL_TRANSACTION_REPEATABLE_READ 	= SQL_TXN_REPEATABLE_READ;
  SQL_TXN_SERIALIZABLE            	= $00000008;
  SQL_TRANSACTION_SERIALIZABLE    	= SQL_TXN_SERIALIZABLE;

// SQL_NULL_COLLATION values
  SQL_NC_HIGH                 	= 0;
  SQL_NC_LOW                  	= 1;


{*****************************************************************
** SQLTYPES.H - This file defines the types used in ODBC
**
**		Created 04/10/95 for 2.50 specification
**		Updated 12/11/95 for 3.00 specification
*********************************************************************}
type
  UCHAR		= Byte;
  ULONG		= DWORD;
  USHORT	= Word;

  SCHAR		= Char;
  SDWORD	= Longint;
  SWORD		= Smallint;
  UDWORD	= DWORD;
  UWORD		= Word;
  SDOUBLE	= Double;
  SFLOAT	= Single;
  SLONG		= Longint;
  SSHORT	= Smallint;
  LDOUBLE	= Extended;

  PTR		= TSDPtr;

type
// API declaration data types
  SQLCHAR	= UCHAR;
  SQLSCHAR	= SCHAR;
  SQLDATE	= Byte;		//C type: unsigned char
  SQLDECIMAL	= Byte;		//C type: unsigned char
  SQLDOUBLE	= SDOUBLE;
  SQLFLOAT	= SDOUBLE;
  SQLINTEGER	= SDWORD;
  SQLUINTEGER	= UDWORD;
  SQLNUMERIC	= SQLDECIMAL;
  SQLPOINTER	= PTR;
  SQLREAL	= SFLOAT;
  SQLSMALLINT	= SWORD;
  SQLUSMALLINT	= UWORD;
  SQLTIME	= SQLDATE;
  SQLTIMESTAMP	= SQLDATE;
  SQLVARCHAR	= UCHAR;


// function return type
  SQLRETURN	= SQLSMALLINT;

// generic data structures
  SQLHANDLE	= TSDPtr;

  SQLHENV	= SQLHANDLE;
  SQLHDBC	= SQLHANDLE;
  SQLHSTMT	= SQLHANDLE;
  SQLHDESC	= SQLHANDLE;

  PSQLHANDLE	= ^SQLHANDLE;
  PSQLHENV	= ^SQLHENV;
  PSQLHDBC	= ^SQLHDBC;
  PSQLHSTMT	= ^SQLHSTMT;


  RETCODE	= Smallint;

  PSQLINTEGER	= ^SQLINTEGER;
  PSQLSMALLINT	= ^SQLSMALLINT;
  PSQLUSMALLINT	= ^SQLUSMALLINT;
  PSQLUINTEGER	= ^SQLUINTEGER;
  PSQLPOINTER	= ^SQLPOINTER;

  SQLHWND	= HWND;

// transfer types for DATE, TIME, TIMESTAMP
  TSQL_DATE_STRUCT	= record
    year:	SQLSMALLINT;
    month:	SQLUSMALLINT;
    day:	SQLUSMALLINT;
  end;

  TSQL_TIME_STRUCT	= record
    hour:	SQLUSMALLINT;
    minute:	SQLUSMALLINT;
    second:	SQLUSMALLINT;
  end;

  TSQL_TIMESTAMP_STRUCT = record
    year:	SQLSMALLINT;
    month:	SQLUSMALLINT;
    day:	SQLUSMALLINT;
    hour:	SQLUSMALLINT;
    minute:	SQLUSMALLINT;
    second:	SQLUSMALLINT;
    fraction:	SQLUINTEGER;	// fraction of a second
  end;

// * enumerations for DATETIME_INTERVAL_SUBCODE values for interval data types
// * these values are from SQL-92
//#if (ODBCVER >= 0x0300)
//typedef enum {
const
  SQL_IS_YEAR		= 1;
  SQL_IS_MONTH		= 2;
  SQL_IS_DAY		= 3;
  SQL_IS_HOUR		= 4;
  SQL_IS_MINUTE		= 5;
  SQL_IS_SECOND		= 6;
  SQL_IS_YEAR_TO_MONTH	= 7;
  SQL_IS_DAY_TO_HOUR   	= 8;
  SQL_IS_DAY_TO_MINUTE	= 9;
  SQL_IS_DAY_TO_SECOND	= 10;
  SQL_IS_HOUR_TO_MINUTE	= 11;
  SQL_IS_HOUR_TO_SECOND	= 12;
  SQL_IS_MINUTE_TO_SECOND=13;
//} SQLINTERVAL;
//#endif  /* ODBCVER >= 0x0300 */

type
  SQLINTERVAL = SQLDECIMAL;   // BYTE

  TSQL_YEAR_MONTH_STRUCT = record
    year:	SQLUINTEGER;
    month:	SQLUINTEGER;
  end;

  TSQL_DAY_SECOND_STRUCT = record
    day:	SQLUINTEGER;
    hour:	SQLUINTEGER;
    minute:	SQLUINTEGER;
    second:	SQLUINTEGER;
    fraction:	SQLUINTEGER;
  end;

  TSQL_INTERVAL_YM_STRUCT = record
    interval_type: SQLINTERVAL;
    dummy1, dummy2, dummy3: Byte;       // to align fields on 4-byte boundaries
    interval_sign: SQLSMALLINT;
    dummy4: Word;
    year_month: TSQL_YEAR_MONTH_STRUCT;
  end;

  TSQL_INTERVAL_DS_STRUCT = record
    interval_type: SQLINTERVAL;
    dummy1, dummy2, dummy3: Byte;
    interval_sign: SQLSMALLINT;
    dummy4: Word;
    day_second: TSQL_DAY_SECOND_STRUCT;
  end;

  TSQL_BOOKMARK	= SQLUINTEGER;

{*******************************************************************************
** SQLEXT.H - This is the include for applications using
**             the Microsoft SQL Extensions
**
**		Updated 07/25/95 for 3.00 specification
**		Updated 01/12/96 for 3.00 preliminary release
** 		Updated 09/16/96 for 3.00 SDK release
**		Updated 11/21/96 for bug #4436
********************************************************************************}
const
  SQL_SQLSTATE_SIZE	= 5;	// size of SQLSTATE
  SQL_MAX_DSN_LENGTH	= 32;	// maximum data source name size

  SQL_MAX_OPTION_STRING_LENGTH	= 256;

//#if (ODBCVER >= 0x0300)
	// an end handle type
  SQL_HANDLE_SENV	= 5;

	// env attribute
  SQL_ATTR_ODBC_VERSION		= 200;
  SQL_ATTR_CONNECTION_POOLING	= 201;
  SQL_ATTR_CP_MATCH		= 202;

	// values for SQL_ATTR_CONNECTION_POOLING
 SQL_CP_OFF	      	= 0;
 SQL_CP_ONE_PER_DRIVER	= 1;
 SQL_CP_ONE_PER_HENV  	= 2;
 SQL_CP_DEFAULT	      	= SQL_CP_OFF;

	// values for SQL_ATTR_CP_MATCH
 SQL_CP_STRICT_MATCH 	= 0;
 SQL_CP_RELAXED_MATCH	= 1;
 SQL_CP_MATCH_DEFAULT	= SQL_CP_STRICT_MATCH;

	// values for SQL_ATTR_ODBC_VERSION
 SQL_OV_ODBC2	= 2;
 SQL_OV_ODBC3	= 3;
//#endif  /* ODBCVER >= 0x0300 */

	// connection attributes
  SQL_ACCESS_MODE              	= 101;
  SQL_AUTOCOMMIT               	= 102;
  SQL_LOGIN_TIMEOUT            	= 103;
  SQL_OPT_TRACE                	= 104;
  SQL_OPT_TRACEFILE            	= 105;
  SQL_TRANSLATE_DLL            	= 106;
  SQL_TRANSLATE_OPTION         	= 107;
  SQL_TXN_ISOLATION            	= 108;
  SQL_CURRENT_QUALIFIER        	= 109;
  SQL_ODBC_CURSORS             	= 110;
  SQL_QUIET_MODE               	= 111;
  SQL_PACKET_SIZE              	= 112;

//#if (ODBCVER >= 0x0300)
	// connection attributes with new names
  SQL_ATTR_ACCESS_MODE         	= SQL_ACCESS_MODE;
  SQL_ATTR_AUTOCOMMIT          	= SQL_AUTOCOMMIT;
  SQL_ATTR_CONNECTION_TIMEOUT	= 113;
  SQL_ATTR_CURRENT_CATALOG     	= SQL_CURRENT_QUALIFIER;
  SQL_ATTR_DISCONNECT_BEHAVIOR 	= 114;
  SQL_ATTR_ENLIST_IN_DTC       	= 1207;
  SQL_ATTR_ENLIST_IN_XA        	= 1208;
  SQL_ATTR_LOGIN_TIMEOUT       	= SQL_LOGIN_TIMEOUT;
  SQL_ATTR_ODBC_CURSORS        	= SQL_ODBC_CURSORS;
  SQL_ATTR_PACKET_SIZE         	= SQL_PACKET_SIZE;
  SQL_ATTR_QUIET_MODE          	= SQL_QUIET_MODE;
  SQL_ATTR_TRACE               	= SQL_OPT_TRACE;
  SQL_ATTR_TRACEFILE           	= SQL_OPT_TRACEFILE;
  SQL_ATTR_TRANSLATE_LIB       	= SQL_TRANSLATE_DLL;
  SQL_ATTR_TRANSLATE_OPTION    	= SQL_TRANSLATE_OPTION;
  SQL_ATTR_TXN_ISOLATION       	= SQL_TXN_ISOLATION;
//#endif  /* ODBCVER >= 0x0300 */

  SQL_ATTR_CONNECTION_DEAD      = 1209;	// GetConnectAttr only

	// SQL_CONNECT_OPT_DRVR_START is not meaningful for 3.0 driver
//#if (ODBCVER < 0x0300)
  SQL_CONNECT_OPT_DRVR_START 	= 1000;
//#endif  /* ODBCVER < 0x0300 */

//#if (ODBCVER < 0x0300)
  SQL_CONN_OPT_MAX             	= SQL_PACKET_SIZE;
  SQL_CONN_OPT_MIN             	= SQL_ACCESS_MODE;
//#endif /* ODBCVER < 0x0300 */

	// SQL_ACCESS_MODE options
  SQL_MODE_READ_WRITE          	= 0;
  SQL_MODE_READ_ONLY           	= 1;
  SQL_MODE_DEFAULT             	= SQL_MODE_READ_WRITE;

	// SQL_AUTOCOMMIT options
  SQL_AUTOCOMMIT_OFF           	= 0;
  SQL_AUTOCOMMIT_ON            	= 1;
  SQL_AUTOCOMMIT_DEFAULT       	= SQL_AUTOCOMMIT_ON;

	// SQL_LOGIN_TIMEOUT options
  SQL_LOGIN_TIMEOUT_DEFAULT    	= 15;

	// SQL_OPT_TRACE options
  SQL_OPT_TRACE_OFF            	= 0;
  SQL_OPT_TRACE_ON             	= 1;
  SQL_OPT_TRACE_DEFAULT        	= SQL_OPT_TRACE_OFF;
  SQL_OPT_TRACE_FILE_DEFAULT   	= '\SQL.LOG';

	// SQL_ODBC_CURSORS options
  SQL_CUR_USE_IF_NEEDED        	= 0;
  SQL_CUR_USE_ODBC             	= 1;
  SQL_CUR_USE_DRIVER           	= 2;
  SQL_CUR_DEFAULT              	= SQL_CUR_USE_DRIVER;

//#if (ODBCVER >= 0x0300)
	// values for SQL_ATTR_DISCONNECT_BEHAVIOR
  SQL_DB_RETURN_TO_POOL        	= 0;
  SQL_DB_DISCONNECT            	= 1;
  SQL_DB_DEFAULT               	= SQL_DB_RETURN_TO_POOL;

	// values for SQL_ATTR_ENLIST_IN_DTC
  SQL_DTC_DONE                 	= 0;
//#endif  /* ODBCVER >= 0x0300 */

        // values for SQL_ATTR_CONNECTION_DEAD
  SQL_CD_TRUE			= 1;		// Connection is closed/dead
  SQL_CD_FALSE			= 0;		// Connection is open/available


	// statement attributes
  SQL_QUERY_TIMEOUT            	= 0;
  SQL_MAX_ROWS                 	= 1;
  SQL_NOSCAN                   	= 2;
  SQL_MAX_LENGTH               	= 3;
  SQL_ASYNC_ENABLE             	= 4;       // same as SQL_ATTR_ASYNC_ENABLE
  SQL_BIND_TYPE                	= 5;
  SQL_CURSOR_TYPE              	= 6;
  SQL_CONCURRENCY              	= 7;
  SQL_KEYSET_SIZE              	= 8;
  SQL_ROWSET_SIZE              	= 9;
  SQL_SIMULATE_CURSOR          	= 10;
  SQL_RETRIEVE_DATA            	= 11;
  SQL_USE_BOOKMARKS            	= 12;
  SQL_GET_BOOKMARK             	= 13;      // GetStmtOption Only
  SQL_ROW_NUMBER               	= 14;      // GetStmtOption Only

//#if (ODBCVER >= 0x0300)
	// statement attributes for ODBC 3.0
  SQL_ATTR_ASYNC_ENABLE        	= 4;
  SQL_ATTR_CONCURRENCY         	= SQL_CONCURRENCY;
  SQL_ATTR_CURSOR_TYPE         	= SQL_CURSOR_TYPE;
  SQL_ATTR_ENABLE_AUTO_IPD     	= 15;
  SQL_ATTR_FETCH_BOOKMARK_PTR  	= 16;
  SQL_ATTR_KEYSET_SIZE         	= SQL_KEYSET_SIZE;
  SQL_ATTR_MAX_LENGTH          	= SQL_MAX_LENGTH;
  SQL_ATTR_MAX_ROWS            	= SQL_MAX_ROWS;
  SQL_ATTR_NOSCAN              	= SQL_NOSCAN;
  SQL_ATTR_PARAM_BIND_OFFSET_PTR= 17;
  SQL_ATTR_PARAM_BIND_TYPE     	= 18;
  SQL_ATTR_PARAM_OPERATION_PTR 	= 19;
  SQL_ATTR_PARAM_STATUS_PTR    	= 20;
  SQL_ATTR_PARAMS_PROCESSED_PTR	= 21;
  SQL_ATTR_PARAMSET_SIZE       	= 22;
  SQL_ATTR_QUERY_TIMEOUT       	= SQL_QUERY_TIMEOUT;
  SQL_ATTR_RETRIEVE_DATA       	= SQL_RETRIEVE_DATA;
  SQL_ATTR_ROW_BIND_OFFSET_PTR 	= 23;
  SQL_ATTR_ROW_BIND_TYPE       	= SQL_BIND_TYPE;
  SQL_ATTR_ROW_NUMBER          	= SQL_ROW_NUMBER;	// GetStmtAttr
  SQL_ATTR_ROW_OPERATION_PTR   	= 24;
  SQL_ATTR_ROW_STATUS_PTR      	= 25;
  SQL_ATTR_ROWS_FETCHED_PTR    	= 26;
  SQL_ATTR_ROW_ARRAY_SIZE      	= 27;
  SQL_ATTR_SIMULATE_CURSOR     	= SQL_SIMULATE_CURSOR;
  SQL_ATTR_USE_BOOKMARKS       	= SQL_USE_BOOKMARKS;
//#endif  /* ODBCVER >= 0x0300 */

//#if (ODBCVER < 0x0300)
  SQL_STMT_OPT_MAX             	= SQL_ROW_NUMBER;
  SQL_STMT_OPT_MIN       	= SQL_QUERY_TIMEOUT;
//#endif    	/* ODBCVER < 0x0300 */

//#if (ODBCVER >= 0x0300)
	// whether an attribute is a pointer or not
  SQL_IS_POINTER	= (-4);
  SQL_IS_UINTEGER  	= (-5);
  SQL_IS_INTEGER  	= (-6);
  SQL_IS_USMALLINT	= (-7);
  SQL_IS_SMALLINT 	= (-8);

	// the value of SQL_ATTR_PARAM_BIND_TYPE
  SQL_PARAM_BIND_BY_COLUMN	= 0;
  SQL_PARAM_BIND_TYPE_DEFAULT	= SQL_PARAM_BIND_BY_COLUMN;
//#endif  /* ODBCVER >= 0x0300 */

	// SQL_QUERY_TIMEOUT options
  SQL_QUERY_TIMEOUT_DEFAULT    	= 0;

	// SQL_MAX_ROWS options
  SQL_MAX_ROWS_DEFAULT         	= 0;

	// SQL_NOSCAN options
  SQL_NOSCAN_OFF               	= 0;     //      1.0 FALSE
  SQL_NOSCAN_ON                	= 1;     //      1.0 TRUE
  SQL_NOSCAN_DEFAULT           	= SQL_NOSCAN_OFF;

	// SQL_MAX_LENGTH options
  SQL_MAX_LENGTH_DEFAULT      	= 0;

	// values for SQL_ATTR_ASYNC_ENABLE
  SQL_ASYNC_ENABLE_OFF         	= 0;
  SQL_ASYNC_ENABLE_ON          	= 1;
  SQL_ASYNC_ENABLE_DEFAULT     	= SQL_ASYNC_ENABLE_OFF;

	// SQL_BIND_TYPE options
  SQL_BIND_BY_COLUMN           	= 0;
  SQL_BIND_TYPE_DEFAULT        	= SQL_BIND_BY_COLUMN;  // Default value

	// SQL_CONCURRENCY options
  SQL_CONCUR_READ_ONLY         	= 1;
  SQL_CONCUR_LOCK              	= 2;
  SQL_CONCUR_ROWVER            	= 3;
  SQL_CONCUR_VALUES            	= 4;
  SQL_CONCUR_DEFAULT           	= SQL_CONCUR_READ_ONLY; // Default value

	// SQL_CURSOR_TYPE options
  SQL_CURSOR_FORWARD_ONLY      	= 0;
  SQL_CURSOR_KEYSET_DRIVEN     	= 1;
  SQL_CURSOR_DYNAMIC           	= 2;
  SQL_CURSOR_STATIC            	= 3;
  SQL_CURSOR_TYPE_DEFAULT      	= SQL_CURSOR_FORWARD_ONLY; // Default value

	// SQL_ROWSET_SIZE options
  SQL_ROWSET_SIZE_DEFAULT     	= 1;

	// SQL_KEYSET_SIZE options
  SQL_KEYSET_SIZE_DEFAULT      	= 0;

	// SQL_SIMULATE_CURSOR options
  SQL_SC_NON_UNIQUE            	= 0;
  SQL_SC_TRY_UNIQUE            	= 1;
  SQL_SC_UNIQUE                	= 2;

	// SQL_RETRIEVE_DATA options
  SQL_RD_OFF                  	= 0;
  SQL_RD_ON                   	= 1;
  SQL_RD_DEFAULT              	= SQL_RD_ON;

	// SQL_USE_BOOKMARKS options
  SQL_UB_OFF                   	= 0;
  SQL_UB_ON                    	= 1;
  SQL_UB_DEFAULT               	= SQL_UB_OFF;

//#if (ODBCVER >= 0x0300)
	// New values for SQL_USE_BOOKMARKS attribute
  SQL_UB_FIXED               	= SQL_UB_ON;
  SQL_UB_VARIABLE            	= 2;
//#endif  /* ODBCVER >= 0x0300 */

	// SQL extended datatypes
  SQL_DATE                    	= 9;
//#if (ODBCVER >= 0x0300)
  SQL_INTERVAL                	= 10;
//#endif  /* ODBCVER >= 0x0300 */
  SQL_TIME                    	= 10;
  SQL_TIMESTAMP               	= 11;
  SQL_LONGVARCHAR             	= (-1);
  SQL_BINARY                  	= (-2);
  SQL_VARBINARY               	= (-3);
  SQL_LONGVARBINARY           	= (-4);
  SQL_BIGINT                  	= (-5);
  SQL_TINYINT                 	= (-6);
  SQL_BIT                     	= (-7);
//#if (ODBCVER >= 0x0350)
  SQL_GUID                      = (-11);
//#endif  /* ODBCVER >= 0x0350 */

//#if (ODBCVER >= 0x0300)
	// interval code
  SQL_CODE_YEAR               	= 1;
  SQL_CODE_MONTH              	= 2;
  SQL_CODE_DAY                	= 3;
  SQL_CODE_HOUR               	= 4;
  SQL_CODE_MINUTE             	= 5;
  SQL_CODE_SECOND             	= 6;
  SQL_CODE_YEAR_TO_MONTH      	= 7;
  SQL_CODE_DAY_TO_HOUR        	= 8;
  SQL_CODE_DAY_TO_MINUTE      	= 9;
  SQL_CODE_DAY_TO_SECOND      	= 10;
  SQL_CODE_HOUR_TO_MINUTE     	= 11;
  SQL_CODE_HOUR_TO_SECOND     	= 12;
  SQL_CODE_MINUTE_TO_SECOND   	= 13;

  SQL_INTERVAL_YEAR           	= (100 + SQL_CODE_YEAR);
  SQL_INTERVAL_MONTH          	= (100 + SQL_CODE_MONTH);
  SQL_INTERVAL_DAY            	= (100 + SQL_CODE_DAY);
  SQL_INTERVAL_HOUR           	= (100 + SQL_CODE_HOUR);
  SQL_INTERVAL_MINUTE         	= (100 + SQL_CODE_MINUTE);
  SQL_INTERVAL_SECOND         	= (100 + SQL_CODE_SECOND);
  SQL_INTERVAL_YEAR_TO_MONTH  	= (100 + SQL_CODE_YEAR_TO_MONTH);
  SQL_INTERVAL_DAY_TO_HOUR    	= (100 + SQL_CODE_DAY_TO_HOUR);
  SQL_INTERVAL_DAY_TO_MINUTE  	= (100 + SQL_CODE_DAY_TO_MINUTE);
  SQL_INTERVAL_DAY_TO_SECOND  	= (100 + SQL_CODE_DAY_TO_SECOND);
  SQL_INTERVAL_HOUR_TO_MINUTE 	= (100 + SQL_CODE_HOUR_TO_MINUTE);
  SQL_INTERVAL_HOUR_TO_SECOND 	= (100 + SQL_CODE_HOUR_TO_SECOND);
  SQL_INTERVAL_MINUTE_TO_SECOND	= (100 + SQL_CODE_MINUTE_TO_SECOND);

{#else
#define SQL_INTERVAL_YEAR                       (-80)
#define SQL_INTERVAL_MONTH                      (-81)
#define SQL_INTERVAL_YEAR_TO_MONTH              (-82)
#define SQL_INTERVAL_DAY                        (-83)
#define SQL_INTERVAL_HOUR                       (-84)
#define SQL_INTERVAL_MINUTE                     (-85)
#define SQL_INTERVAL_SECOND                     (-86)
#define SQL_INTERVAL_DAY_TO_HOUR                (-87)
#define SQL_INTERVAL_DAY_TO_MINUTE              (-88)
#define SQL_INTERVAL_DAY_TO_SECOND              (-89)
#define SQL_INTERVAL_HOUR_TO_MINUTE             (-90)
#define SQL_INTERVAL_HOUR_TO_SECOND             (-91)
#define SQL_INTERVAL_MINUTE_TO_SECOND           (-92)
}

//#endif  /* ODBCVER >= 0x0300 */


  SQL_UNICODE                  	= (-95);
  SQL_UNICODE_VARCHAR          	= (-96);
  SQL_UNICODE_LONGVARCHAR      	= (-97);
  SQL_UNICODE_CHAR             	= SQL_UNICODE;

//#if (ODBCVER < 0x0300)
  SQL_TYPE_DRIVER_START        	= SQL_INTERVAL_YEAR;
  SQL_TYPE_DRIVER_END          	= SQL_UNICODE_LONGVARCHAR;
//#endif  /* ODBCVER < 0x0300 */

	// C datatype to SQL datatype mapping      	SQL types
  SQL_C_CHAR   		= SQL_CHAR;             // CHAR, VARCHAR, DECIMAL, NUMERIC
  SQL_C_LONG 	  	= SQL_INTEGER;          // INTEGER
  SQL_C_SHORT  		= SQL_SMALLINT;         // SMALLINT
  SQL_C_FLOAT  		= SQL_REAL;             // REAL
  SQL_C_DOUBLE 		= SQL_DOUBLE;           // FLOAT, DOUBLE
//#if (ODBCVER >= 0x0300)
  SQL_C_NUMERIC		= SQL_NUMERIC;
//#endif  /* ODBCVER >= 0x0300 */
  SQL_C_DEFAULT	= 99;

  SQL_SIGNED_OFFSET   	= (-20);
  SQL_UNSIGNED_OFFSET 	= (-22);

	// C datatype to SQL datatype mapping
  SQL_C_DATE     	=  SQL_DATE;
  SQL_C_TIME     	=  SQL_TIME;
  SQL_C_TIMESTAMP	=  SQL_TIMESTAMP;
//#if (ODBCVER >= 0x0300)
  SQL_C_TYPE_DATE              	= SQL_TYPE_DATE;
  SQL_C_TYPE_TIME              	= SQL_TYPE_TIME;
  SQL_C_TYPE_TIMESTAMP         	= SQL_TYPE_TIMESTAMP;
  SQL_C_INTERVAL_YEAR          	= SQL_INTERVAL_YEAR;
  SQL_C_INTERVAL_MONTH         	= SQL_INTERVAL_MONTH;
  SQL_C_INTERVAL_DAY           	= SQL_INTERVAL_DAY;
  SQL_C_INTERVAL_HOUR          	= SQL_INTERVAL_HOUR;
  SQL_C_INTERVAL_MINUTE        	= SQL_INTERVAL_MINUTE;
  SQL_C_INTERVAL_SECOND        	= SQL_INTERVAL_SECOND;
  SQL_C_INTERVAL_YEAR_TO_MONTH 	= SQL_INTERVAL_YEAR_TO_MONTH;
  SQL_C_INTERVAL_DAY_TO_HOUR   	= SQL_INTERVAL_DAY_TO_HOUR;
  SQL_C_INTERVAL_DAY_TO_MINUTE 	= SQL_INTERVAL_DAY_TO_MINUTE;
  SQL_C_INTERVAL_DAY_TO_SECOND 	= SQL_INTERVAL_DAY_TO_SECOND;
  SQL_C_INTERVAL_HOUR_TO_MINUTE	= SQL_INTERVAL_HOUR_TO_MINUTE;
  SQL_C_INTERVAL_HOUR_TO_SECOND	= SQL_INTERVAL_HOUR_TO_SECOND;
  SQL_C_INTERVAL_MINUTE_TO_SECOND= SQL_INTERVAL_MINUTE_TO_SECOND;
//#endif  /* ODBCVER >= 0x0300 */

  SQL_C_BINARY    	= SQL_BINARY;
  SQL_C_BIT       	= SQL_BIT;

//#if (ODBCVER >= 0x0300)
  SQL_C_SBIGINT   	= (SQL_BIGINT+SQL_SIGNED_OFFSET);     	// SIGNED BIGINT
  SQL_C_UBIGINT  	= (SQL_BIGINT+SQL_UNSIGNED_OFFSET);   	// UNSIGNED BIGINT
//#endif  /* ODBCVER >= 0x0300 */

  SQL_C_TINYINT   	= SQL_TINYINT;
  SQL_C_SLONG     	= (SQL_C_LONG+SQL_SIGNED_OFFSET);    	// SIGNED INTEGER
  SQL_C_SSHORT    	= (SQL_C_SHORT+SQL_SIGNED_OFFSET);   	// SIGNED SMALLINT
  SQL_C_STINYINT  	= (SQL_TINYINT+SQL_SIGNED_OFFSET);   	// SIGNED TINYINT
  SQL_C_ULONG     	= (SQL_C_LONG+SQL_UNSIGNED_OFFSET);  	// UNSIGNED INTEGER
  SQL_C_USHORT    	= (SQL_C_SHORT+SQL_UNSIGNED_OFFSET); 	// UNSIGNED SMALLINT
  SQL_C_UTINYINT  	= (SQL_TINYINT+SQL_UNSIGNED_OFFSET); 	// UNSIGNED TINYINT
  SQL_C_BOOKMARK  	= SQL_C_ULONG;                       	// BOOKMARK

//#if (ODBCVER >= 0x0350)
  SQL_C_GUID            = SQL_GUID;
//#endif  /* ODBCVER >= 0x0350 */

  SQL_TYPE_NULL   	= 0;

//#if (ODBCVER < 0x0300)
  SQL_TYPE_MIN 		= SQL_BIT;
  SQL_TYPE_MAX 		= SQL_VARCHAR;
//#endif

//#if (ODBCVER >= 0x0300)
  SQL_C_VARBOOKMARK 	= SQL_C_BINARY;
//#endif  /* ODBCVER >= 0x0300 */

	// define for SQL_DIAG_ROW_NUMBER and SQL_DIAG_COLUMN_NUMBER
//#if (ODBCVER >= 0x0300)
  SQL_NO_ROW_NUMBER       	= (-1);
  SQL_NO_COLUMN_NUMBER    	= (-1);
  SQL_ROW_NUMBER_UNKNOWN	= (-2);
  SQL_COLUMN_NUMBER_UNKNOWN	= (-2);
//#endif  /* ODBCVER >= 0x0300 */

	// SQLBindParameter extensions
  SQL_DEFAULT_PARAM           	= (-5);
  SQL_IGNORE                  	= (-6);
//#if (ODBCVER >= 0x0300)
  SQL_COLUMN_IGNORE           	= SQL_IGNORE;
//#endif  /* ODBCVER >= 0x0300 */
  SQL_LEN_DATA_AT_EXEC_OFFSET 	= (-100);
//  SQL_LEN_DATA_AT_EXEC(length)	= (-(length)+SQL_LEN_DATA_AT_EXEC_OFFSET);
function SQL_LEN_DATA_AT_EXEC(ALength: SQLINTEGER): SQLINTEGER;

const
	// binary length for driver specific attributes
  SQL_LEN_BINARY_ATTR_OFFSET   	= (-100);
//  SQL_LEN_BINARY_ATTR(length)  	= (-(length)+SQL_LEN_BINARY_ATTR_OFFSET);

	// Defines used by Driver Manager when mapping SQLSetParam to SQLBindParameter
{  SQL_PARAM_TYPE_DEFAULT      	= SQL_PARAM_INPUT_OUTPUT; }
  SQL_SETPARAM_VALUE_MAX       	= (-1);

	// SQLColAttributes defines
  SQL_COLUMN_COUNT             	= 0;
  SQL_COLUMN_NAME              	= 1;
  SQL_COLUMN_TYPE              	= 2;
  SQL_COLUMN_LENGTH            	= 3;
  SQL_COLUMN_PRECISION         	= 4;
  SQL_COLUMN_SCALE             	= 5;
  SQL_COLUMN_DISPLAY_SIZE      	= 6;
  SQL_COLUMN_NULLABLE          	= 7;
  SQL_COLUMN_UNSIGNED          	= 8;
  SQL_COLUMN_MONEY             	= 9;
  SQL_COLUMN_UPDATABLE         	= 10;
  SQL_COLUMN_AUTO_INCREMENT    	= 11;
  SQL_COLUMN_CASE_SENSITIVE    	= 12;
  SQL_COLUMN_SEARCHABLE        	= 13;
  SQL_COLUMN_TYPE_NAME         	= 14;
  SQL_COLUMN_TABLE_NAME        	= 15;
  SQL_COLUMN_OWNER_NAME        	= 16;
  SQL_COLUMN_QUALIFIER_NAME    	= 17;
  SQL_COLUMN_LABEL             	= 18;
  SQL_COLATT_OPT_MAX           	= SQL_COLUMN_LABEL;
//#if (ODBCVER < 0x0300)
  SQL_COLUMN_DRIVER_START      	= 1000;
//#endif  /* ODBCVER < 0x0300 */

  SQL_COLATT_OPT_MIN           	= SQL_COLUMN_COUNT;

	// SQLColAttributes subdefines for SQL_COLUMN_UPDATABLE
  SQL_ATTR_READONLY            	= 0;
  SQL_ATTR_WRITE               	= 1;
  SQL_ATTR_READWRITE_UNKNOWN   	= 2;

// SQLColAttributes subdefines for SQL_COLUMN_SEARCHABLE
// These are also used by SQLGetInfo
  SQL_UNSEARCHABLE             	= 0;
  SQL_LIKE_ONLY                	= 1;
  SQL_ALL_EXCEPT_LIKE          	= 2;
  SQL_SEARCHABLE               	= 3;
  SQL_PRED_SEARCHABLE          	= SQL_SEARCHABLE;

// Special return values for SQLGetData
  SQL_NO_TOTAL                	= (-4);

	// New defines for SEARCHABLE column in SQLGetTypeInfo
//#if (ODBCVER >= 0x0300)
  SQL_COL_PRED_CHAR		= SQL_LIKE_ONLY;
  SQL_COL_PRED_BASIC		= SQL_ALL_EXCEPT_LIKE;
//#endif /* ODBCVER >= 0x0300 */

//#if (ODBCVER >= 0x0300)
	// extended descriptor field
  SQL_DESC_ARRAY_SIZE          	= 20;
  SQL_DESC_ARRAY_STATUS_PTR    	= 21;
  SQL_DESC_AUTO_UNIQUE_VALUE   	= SQL_COLUMN_AUTO_INCREMENT;
  SQL_DESC_BASE_COLUMN_NAME    	= 22;
  SQL_DESC_BASE_TABLE_NAME     	= 23;
  SQL_DESC_BIND_OFFSET_PTR     	= 24;
  SQL_DESC_BIND_TYPE           	= 25;
  SQL_DESC_CASE_SENSITIVE      	= SQL_COLUMN_CASE_SENSITIVE;
  SQL_DESC_CATALOG_NAME        	= SQL_COLUMN_QUALIFIER_NAME;
  SQL_DESC_CONCISE_TYPE        	= SQL_COLUMN_TYPE;
  SQL_DESC_DATETIME_INTERVAL_PRECISION = 26;
  SQL_DESC_DISPLAY_SIZE        	= SQL_COLUMN_DISPLAY_SIZE;
  SQL_DESC_FIXED_PREC_SCALE    	= SQL_COLUMN_MONEY;
  SQL_DESC_LABEL               	= SQL_COLUMN_LABEL;
  SQL_DESC_LITERAL_PREFIX      	= 27;
  SQL_DESC_LITERAL_SUFFIX      	= 28;
  SQL_DESC_LOCAL_TYPE_NAME     	= 29;
  SQL_DESC_MAXIMUM_SCALE       	= 30;
  SQL_DESC_MINIMUM_SCALE       	= 31;
  SQL_DESC_NUM_PREC_RADIX      	= 32;
  SQL_DESC_PARAMETER_TYPE      	= 33;
  SQL_DESC_ROWS_PROCESSED_PTR  	= 34;
//#if (ODBCVER >= 0x0350)
  SQL_DESC_ROWVER               = 35;
//#endif /* ODBCVER >= 0x0350 */
  SQL_DESC_SCHEMA_NAME         	= SQL_COLUMN_OWNER_NAME;
  SQL_DESC_SEARCHABLE          	= SQL_COLUMN_SEARCHABLE;
  SQL_DESC_TYPE_NAME           	= SQL_COLUMN_TYPE_NAME;
  SQL_DESC_TABLE_NAME          	= SQL_COLUMN_TABLE_NAME;
  SQL_DESC_UNSIGNED            	= SQL_COLUMN_UNSIGNED;
  SQL_DESC_UPDATABLE           	= SQL_COLUMN_UPDATABLE;

	// defines for diagnostics fields
  SQL_DIAG_CURSOR_ROW_COUNT    	= (-1249);
  SQL_DIAG_ROW_NUMBER          	= (-1248);
  SQL_DIAG_COLUMN_NUMBER       	= (-1247);

//#endif /* ODBCVER >= 0x0300 */


{********************************************
 * SQLGetFunctions: additional values for   *
 * fFunction to represent functions that    *
 * are not in the X/Open spec.		    *
 ********************************************}
//#if (ODBCVER >= 0x0300)
  SQL_API_SQLALLOCHANDLESTD	= 73;
  SQL_API_SQLBULKOPERATIONS    	= 24;
//#endif /* ODBCVER >= 0x0300 */
  SQL_API_SQLBINDPARAMETER   	= 72;
  SQL_API_SQLBROWSECONNECT   	= 55;
  SQL_API_SQLCOLATTRIBUTES   	=  6;
  SQL_API_SQLCOLUMNPRIVILEGES	= 56;
  SQL_API_SQLDESCRIBEPARAM   	= 58;
  SQL_API_SQLDRIVERCONNECT   	= 41;
  SQL_API_SQLDRIVERS         	= 71;
  SQL_API_SQLEXTENDEDFETCH   	= 59;
  SQL_API_SQLFOREIGNKEYS     	= 60;
  SQL_API_SQLMORERESULTS     	= 61;
  SQL_API_SQLNATIVESQL       	= 62;
  SQL_API_SQLNUMPARAMS       	= 63;
  SQL_API_SQLPARAMOPTIONS    	= 64;
  SQL_API_SQLPRIMARYKEYS     	= 65;
  SQL_API_SQLPROCEDURECOLUMNS	= 66;
  SQL_API_SQLPROCEDURES      	= 67;
  SQL_API_SQLSETPOS          	= 68;
  SQL_API_SQLSETSCROLLOPTIONS	= 69;
  SQL_API_SQLTABLEPRIVILEGES 	= 70;

{*-------------------------------------------*
 * SQL_EXT_API_LAST is not useful with ODBC  *
 * version 3.0 because some of the values    *
 * from X/Open are in the 10000 range.       *
 *-------------------------------------------*}
//#if (ODBCVER < 0x0300)
  SQL_EXT_API_LAST           	= SQL_API_SQLBINDPARAMETER;
  SQL_NUM_FUNCTIONS          	= 23;
  SQL_EXT_API_START          	= 40;
  SQL_NUM_EXTENSIONS 		= (SQL_EXT_API_LAST-SQL_EXT_API_START+1);
//#endif

{*--------------------------------------------*
 * SQL_API_ALL_FUNCTIONS returns an array     *
 * of 'booleans' representing whether a       *
 * function is implemented by the driver.     *
 *                                            *
 * CAUTION: Only functions defined in ODBC    *
 * version 2.0 and earlier are returned, the  *
 * new high-range function numbers defined by *
 * X/Open break this scheme.   See the new    *
 * method -- SQL_API_ODBC3_ALL_FUNCTIONS      *
 *--------------------------------------------*}

  SQL_API_ALL_FUNCTIONS   	= 0;	// See CAUTION above

{*----------------------------------------------*
 * 2.X drivers export a dummy function with  	*
 * ordinal number SQL_API_LOADBYORDINAL to speed*
 * loading under the windows operating system.  *
 * 						*
 * CAUTION: Loading by ordinal is not supported *
 * for 3.0 and above drivers.			*
 *----------------------------------------------*}

  SQL_API_LOADBYORDINAL		= 199;	// See CAUTION above	

{*----------------------------------------------*
 * SQL_API_ODBC3_ALL_FUNCTIONS                  *
 * This returns a bitmap, which allows us to    *
 * handle the higher-valued function numbers.   *
 * Use  SQL_FUNC_EXISTS(bitmap,function_number) *
 * to determine if the function exists.         *
 *----------------------------------------------*}

//#if (ODBCVER >= 0x0300)
  SQL_API_ODBC3_ALL_FUNCTIONS		= 999;
  SQL_API_ODBC3_ALL_FUNCTIONS_SIZE	= 250;	// array of 250 words

{#define SQL_FUNC_EXISTS(pfExists, uwAPI) \
				((*(((UWORD*) (pfExists)) + ((uwAPI) >> 4)) \
					& (1 << ((uwAPI) & 0x000F)) \
 				 ) ? SQL_TRUE : SQL_FALSE \
				)
}
//#endif  /* ODBCVER >= 0x0300 */

{************************************************/
/* Extended definitions for SQLGetInfo          */
/************************************************}

	// Values in ODBC 2.0 that are not in the X/Open spec
  SQL_INFO_FIRST        	=  0;
  SQL_ACTIVE_CONNECTIONS       	=  0;  		// MAX_DRIVER_CONNECTIONS
  SQL_ACTIVE_STATEMENTS        	=  1;  		// MAX_CONCURRENT_ACTIVITIES
  SQL_DRIVER_HDBC              	=  3;
  SQL_DRIVER_HENV              	=  4;
  SQL_DRIVER_HSTMT             	=  5;
  SQL_DRIVER_NAME              	=  6;
  SQL_DRIVER_VER               	=  7;
  SQL_ODBC_API_CONFORMANCE     	=  9;
  SQL_ODBC_VER                 	= 10;
  SQL_ROW_UPDATES              	= 11;
  SQL_ODBC_SAG_CLI_CONFORMANCE 	= 12;
  SQL_ODBC_SQL_CONFORMANCE     	= 15;
  SQL_PROCEDURES               	= 21;
  SQL_CONCAT_NULL_BEHAVIOR     	= 22;
  SQL_CURSOR_ROLLBACK_BEHAVIOR 	= 24;
  SQL_EXPRESSIONS_IN_ORDERBY   	= 27;
  SQL_MAX_OWNER_NAME_LEN       	= 32;		// MAX_SCHEMA_NAME_LEN
  SQL_MAX_PROCEDURE_NAME_LEN   	= 33;
  SQL_MAX_QUALIFIER_NAME_LEN   	= 34;  		// MAX_CATALOG_NAME_LEN
  SQL_MULT_RESULT_SETS         	= 36;
  SQL_MULTIPLE_ACTIVE_TXN      	= 37;
  SQL_OUTER_JOINS              	= 38;
  SQL_OWNER_TERM               	= 39;
  SQL_PROCEDURE_TERM           	= 40;
  SQL_QUALIFIER_NAME_SEPARATOR 	= 41;
  SQL_QUALIFIER_TERM           	= 42;
  SQL_SCROLL_OPTIONS           	= 44;
  SQL_TABLE_TERM               	= 45;
  SQL_CONVERT_FUNCTIONS        	= 48;
  SQL_NUMERIC_FUNCTIONS        	= 49;
  SQL_STRING_FUNCTIONS         	= 50;
  SQL_SYSTEM_FUNCTIONS         	= 51;
  SQL_TIMEDATE_FUNCTIONS       	= 52;
  SQL_CONVERT_BIGINT           	= 53;
  SQL_CONVERT_BINARY           	= 54;
  SQL_CONVERT_BIT              	= 55;
  SQL_CONVERT_CHAR             	= 56;
  SQL_CONVERT_DATE             	= 57;
  SQL_CONVERT_DECIMAL          	= 58;
  SQL_CONVERT_DOUBLE           	= 59;
  SQL_CONVERT_FLOAT            	= 60;
  SQL_CONVERT_INTEGER          	= 61;
  SQL_CONVERT_LONGVARCHAR      	= 62;
  SQL_CONVERT_NUMERIC          	= 63;
  SQL_CONVERT_REAL             	= 64;
  SQL_CONVERT_SMALLINT         	= 65;
  SQL_CONVERT_TIME             	= 66;
  SQL_CONVERT_TIMESTAMP        	= 67;
  SQL_CONVERT_TINYINT          	= 68;
  SQL_CONVERT_VARBINARY        	= 69;
  SQL_CONVERT_VARCHAR          	= 70;
  SQL_CONVERT_LONGVARBINARY    	= 71;
  SQL_ODBC_SQL_OPT_IEF         	= 73;		// SQL_INTEGRITY
  SQL_CORRELATION_NAME         	= 74;
  SQL_NON_NULLABLE_COLUMNS     	= 75;
  SQL_DRIVER_HLIB              	= 76;
  SQL_DRIVER_ODBC_VER          	= 77;
  SQL_LOCK_TYPES               	= 78;
  SQL_POS_OPERATIONS           	= 79;
  SQL_POSITIONED_STATEMENTS    	= 80;
  SQL_BOOKMARK_PERSISTENCE     	= 82;
  SQL_STATIC_SENSITIVITY       	= 83;
  SQL_FILE_USAGE               	= 84;
  SQL_COLUMN_ALIAS             	= 87;
  SQL_GROUP_BY                 	= 88;
  SQL_KEYWORDS                 	= 89;
  SQL_OWNER_USAGE              	= 91;
  SQL_QUALIFIER_USAGE          	= 92;
  SQL_QUOTED_IDENTIFIER_CASE   	= 93;
  SQL_SUBQUERIES               	= 95;
  SQL_UNION                    	= 96;
  SQL_MAX_ROW_SIZE_INCLUDES_LONG= 103;
  SQL_MAX_CHAR_LITERAL_LEN     	= 108;
  SQL_TIMEDATE_ADD_INTERVALS   	= 109;
  SQL_TIMEDATE_DIFF_INTERVALS  	= 110;
  SQL_NEED_LONG_DATA_LEN       	= 111;
  SQL_MAX_BINARY_LITERAL_LEN   	= 112;
  SQL_LIKE_ESCAPE_CLAUSE       	= 113;
  SQL_QUALIFIER_LOCATION       	= 114;

	// values for SQL_BATCH_ROW_COUNT
  SQL_BRC_PROCEDURES		= 1;
  SQL_BRC_EXPLICIT		= 2;
  SQL_BRC_ROLLED_UP		= 4;

	// bitmasks for SQL_BATCH_SUPPORT
  SQL_BS_SELECT_EXPLICIT   	= 1;
  SQL_BS_ROW_COUNT_EXPLICIT	= 2;
  SQL_BS_SELECT_PROC	   	= 4;
  SQL_BS_ROW_COUNT_PROC	   	= 8;

	// Values for SQL_PARAM_ARRAY_ROW_COUNTS getinfo
  SQL_PARC_BATCH		= 1;
  SQL_PARC_NO_BATCH		= 2;

	// values for SQL_PARAM_ARRAY_SELECT_BATCH
  SQL_PAS_BATCH	  		= 1;
  SQL_PAS_NO_BATCH		= 2;
  SQL_PAS_NO_SELECT		= 3;

	// Bitmasks for SQL_INDEX_KEYWORDS
  SQL_IK_NONE			= 0;
  SQL_IK_ASC 			= 1;
  SQL_IK_DESC			= 2;
  SQL_IK_ALL 			= (1 or 2);


{
#if (ODBCVER >= 0x0201 && ODBCVER < 0x0300)
#define SQL_OJ_CAPABILITIES         65003  /* Temp value until ODBC 3.0 */
#endif  /* ODBCVER >= 0x0201 && ODBCVER < 0x0300 */
}

{*----------------------------------------------*
 * SQL_INFO_LAST and SQL_INFO_DRIVER_START are  *
 * not useful anymore, because  X/Open has      *
 * values in the 10000 range.   You  		*
 * must contact X/Open directly to get a range	*
 * of numbers for driver-specific values.	*
 *----------------------------------------------*}

//#if (ODBCVER < 0x0300)
  SQL_INFO_LAST			= SQL_QUALIFIER_LOCATION;
  SQL_INFO_DRIVER_START		= 1000;
//#endif /* ODBCVER < 0x0300 */


{*-----------------------------------------------*
 * ODBC 3.0 SQLGetInfo values that are not part  *
 * of the X/Open standard at this time.   X/Open *
 * standard values are in sql.h.		 *
 *-----------------------------------------------*}
//#if (ODBCVER >= 0x0300)
  SQL_ACTIVE_ENVIRONMENTS      		= 116;
  SQL_ALTER_DOMAIN	       		= 117;

  SQL_SQL_CONFORMANCE	       		= 118;
  SQL_DATETIME_LITERALS	       		= 119;

  SQL_ASYNC_MODE      			= 10021;	// new X/Open spec
  SQL_BATCH_ROW_COUNT 			= 120;
  SQL_BATCH_SUPPORT   			= 121;
(* translate the following later :
#define SQL_CATALOG_LOCATION					SQL_QUALIFIER_LOCATION
#define SQL_CATALOG_NAME_SEPARATOR				SQL_QUALIFIER_NAME_SEPARATOR
#define SQL_CATALOG_TERM						SQL_QUALIFIER_TERM
#define SQL_CATALOG_USAGE						SQL_QUALIFIER_USAGE
#define	SQL_CONVERT_WCHAR						122
#define SQL_CONVERT_INTERVAL_DAY_TIME			123
#define SQL_CONVERT_INTERVAL_YEAR_MONTH			124
#define	SQL_CONVERT_WLONGVARCHAR				125
#define	SQL_CONVERT_WVARCHAR					126
#define	SQL_CREATE_ASSERTION					127
#define	SQL_CREATE_CHARACTER_SET				128
#define	SQL_CREATE_COLLATION					129
#define	SQL_CREATE_DOMAIN						130
#define	SQL_CREATE_SCHEMA						131
#define	SQL_CREATE_TABLE						132
#define	SQL_CREATE_TRANSLATION					133
#define	SQL_CREATE_VIEW							134
#define SQL_DRIVER_HDESC						135
#define	SQL_DROP_ASSERTION						136
#define	SQL_DROP_CHARACTER_SET					137
#define	SQL_DROP_COLLATION						138
#define	SQL_DROP_DOMAIN							139
#define	SQL_DROP_SCHEMA							140
#define	SQL_DROP_TABLE							141
#define	SQL_DROP_TRANSLATION					142
#define	SQL_DROP_VIEW							143
#define SQL_DYNAMIC_CURSOR_ATTRIBUTES1			144
#define SQL_DYNAMIC_CURSOR_ATTRIBUTES2			145
#define SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1		146
#define SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2		147
#define SQL_INDEX_KEYWORDS						148
#define SQL_INFO_SCHEMA_VIEWS					149
#define SQL_KEYSET_CURSOR_ATTRIBUTES1			150
#define SQL_KEYSET_CURSOR_ATTRIBUTES2			151
#define	SQL_MAX_ASYNC_CONCURRENT_STATEMENTS		10022	/* new X/Open spec */
#define SQL_ODBC_INTERFACE_CONFORMANCE			152
#define SQL_PARAM_ARRAY_ROW_COUNTS     			153
#define SQL_PARAM_ARRAY_SELECTS     			154
#define SQL_SCHEMA_TERM							SQL_OWNER_TERM
#define SQL_SCHEMA_USAGE						SQL_OWNER_USAGE
#define SQL_SQL92_DATETIME_FUNCTIONS			155
#define SQL_SQL92_FOREIGN_KEY_DELETE_RULE		156		
#define SQL_SQL92_FOREIGN_KEY_UPDATE_RULE		157		
#define SQL_SQL92_GRANT							158
#define SQL_SQL92_NUMERIC_VALUE_FUNCTIONS		159
#define SQL_SQL92_PREDICATES					160
#define SQL_SQL92_RELATIONAL_JOIN_OPERATORS		161
#define SQL_SQL92_REVOKE						162
#define SQL_SQL92_ROW_VALUE_CONSTRUCTOR			163
#define SQL_SQL92_STRING_FUNCTIONS				164
#define SQL_SQL92_VALUE_EXPRESSIONS				165
#define SQL_STANDARD_CLI_CONFORMANCE			166
#define SQL_STATIC_CURSOR_ATTRIBUTES1			167	
#define SQL_STATIC_CURSOR_ATTRIBUTES2			168

#define SQL_AGGREGATE_FUNCTIONS					169
#define SQL_DDL_INDEX							170
#define SQL_DM_VER								171
#define SQL_INSERT_STATEMENT					172
#define	SQL_CONVERT_GUID						173
#define SQL_UNION_STATEMENT						SQL_UNION
#endif  /* ODBCVER >= 0x0300 */
*)

// SQL_GETDATA_EXTENSIONS values
  SQL_GD_BLOCK                  = 4;
  SQL_GD_BOUND                  = 8;

// Defines for SQLBindParameter and SQLProcedureColumns (returned in the result set)
  SQL_PARAM_TYPE_UNKNOWN       	= 0;
  SQL_PARAM_INPUT              	= 1;
  SQL_PARAM_INPUT_OUTPUT       	= 2;
  SQL_RESULT_COL               	= 3;
  SQL_PARAM_OUTPUT             	= 4;
  SQL_RETURN_VALUE             	= 5;

// Defines for SQLProcedures (returned in the result set)
  SQL_PT_UNKNOWN	       	= 0;
  SQL_PT_PROCEDURE      	= 1;
  SQL_PT_FUNCTION              	= 2;

// Column types and scopes in SQLSpecialColumns
  SQL_BEST_ROWID                = 1;
  SQL_ROWVER                    = 2;

// Defines for SQLSpecialColumns (returned in the result set)
//   SQL_PC_UNKNOWN and SQL_PC_PSEUDO are defined in sql.h
  SQL_PC_NOT_PSEUDO             = 1;
  
// Defines for SQLStatistics
  SQL_QUICK                     = 0;
  SQL_ENSURE                    = 1;

// Defines for SQLStatistics (returned in the result set)
//   SQL_INDEX_CLUSTERED, SQL_INDEX_HASHED, and SQL_INDEX_OTHER are defined in sql.h
  SQL_TABLE_STAT                = 0;


	// Defines for SQLTables
//#if (ODBCVER >= 0x0300)
  SQL_ALL_CATALOGS	= '%';
  SQL_ALL_SCHEMAS	= '%';
  SQL_ALL_TABLE_TYPES	= '%';
//#endif  /* ODBCVER >= 0x0300 */

	// Options for SQLDriverConnect
  SQL_DRIVER_NOPROMPT   	= 0;
  SQL_DRIVER_COMPLETE         	= 1;
  SQL_DRIVER_PROMPT            	= 2;
  SQL_DRIVER_COMPLETE_REQUIRED 	= 3;


	// SQLExtendedFetch "fFetchType" values
  SQL_FETCH_BOOKMARK 	= 8;

	// SQLExtendedFetch "rgfRowStatus" element values
  SQL_ROW_SUCCESS             	= 0;
  SQL_ROW_DELETED             	= 1;
  SQL_ROW_UPDATED             	= 2;
  SQL_ROW_NOROW               	= 3;
  SQL_ROW_ADDED               	= 4;
  SQL_ROW_ERROR               	= 5;
//#if (ODBCVER >= 0x0300)
  SQL_ROW_SUCCESS_WITH_INFO   	= 6;
  SQL_ROW_PROCEED	      	= 0;
  SQL_ROW_IGNORE	      	= 1;
//#endif

	// value for SQL_DESC_ARRAY_STATUS_PTR
//#if (ODBCVER >= 0x0300)
  SQL_PARAM_SUCCESS	       	= 0;
  SQL_PARAM_SUCCESS_WITH_INFO  	= 6;
  SQL_PARAM_ERROR	    	= 5;
  SQL_PARAM_UNUSED	    	= 7;
  SQL_PARAM_DIAG_UNAVAILABLE   	= 1;

  SQL_PARAM_PROCEED	   	= 0;
  SQL_PARAM_IGNORE	   	= 1;
//#endif  /* ODBCVER >= 0x0300 */

	// Defines for SQLForeignKeys (UPDATE_RULE and DELETE_RULE)
  SQL_CASCADE             	= 0;
  SQL_RESTRICT            	= 1;
  SQL_SET_NULL            	= 2;
//#if (ODBCVER >= 0x0250)
  SQL_NO_ACTION		  	= 3;
  SQL_SET_DEFAULT	  	= 4;
//#endif  /* ODBCVER >= 0x0250 */

//#if (ODBCVER >= 0x0300)
	// Note that the following are in a different column of SQLForeignKeys than
	// the previous #defines.   These are for DEFERRABILITY.
  SQL_INITIALLY_DEFERRED  	= 5;
  SQL_INITIALLY_IMMEDIATE 	= 6;
  SQL_NOT_DEFERRABLE	  	= 7;
//#endif  /* ODBCVER >= 0x0300 */

{********************************************************************
** SQLUCODE.H - This is the the unicode include for ODBC Core functions.
**
**		Created 6/20 for 3.00 specification
*********************************************************************}
const
  SQL_WCHAR		= (-8);
  SQL_WVARCHAR		= (-9);
  SQL_WLONGVARCHAR	= (-10);
  SQL_C_WCHAR		= SQL_WCHAR;

  SQL_C_TCHAR		= SQL_C_WCHAR;

  SQL_SQLSTATE_SIZEW	= 10;		// size of SQLSTATE for unicode

  
type
  TSQLAllocConnect=
	  	function (henv :SQLHENV; var hdbc: SQLHDBC): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLAllocEnv=
  		function (var henv: SQLHENV): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLAllocHandle=
  		function(fHandleType: SQLSMALLINT; hInput: SQLHANDLE;
                    var hOutput: SQLHANDLE): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLAllocStmt=
  		function (hdbc: SQLHDBC; var hstmt: SQLHSTMT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLBindCol=	function (hstmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
                    rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                    pcbValue: SQLPOINTER{PSQLINTEGER}): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLCancel=	function (hstmt: SQLHSTMT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLCloseCursor=
  		function(hStmt: SQLHSTMT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLColAttribute=
  		function (hstmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT;
                    rgbDesc: SQLPOINTER; cbDescMax: SQLSMALLINT;
                    pcbDesc: SQLPOINTER; pfDesc: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLColumns=	function (hStmt: SQLHSTMT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLConnect=	function (hdbc: SQLHDBC; szDSN: TSDCharPtr; cbDSN: SQLSMALLINT;
                    szUID: TSDCharPtr; cbUID: SQLSMALLINT;
                    szAuthStr: TSDCharPtr; cbAuthStr: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLCopyDesc=
  		function (hDescSource: SQLHDESC; hDescTarget: SQLHDESC): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLDataSources =
  		function (hEnv: SQLHENV; fDirection: SQLUSMALLINT;
                    szDSN: TSDCharPtr; cbDSNMax: SQLSMALLINT; var cbDSN: SQLSMALLINT;
                    szDescription: TSDCharPtr; cbDescriptionMax: SQLSMALLINT;
                    var cbDescription: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLDescribeCol =
  		function (hstmt: SQLHSTMT; icol: SQLUSMALLINT;
                    szColName: TSDCharPtr; cbColNameMax: SQLSMALLINT; var cbColName, fSqlType: SQLSMALLINT;
                    var cbColDef: SQLUINTEGER; var ibScale, fNullable: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLDisconnect =
  		function (hdbc: SQLHDBC): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLEndTran =	function (fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; fType: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLError =	function (henv: SQLHENV; hdbc: SQLHDBC; hstmt: SQLHSTMT;
                    szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
                    szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
                    var cbErrorMsg: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLExecDirect =
  		function (hstmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLExecute =	function (hstmt: SQLHSTMT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLFetch =	function (hstmt: SQLHSTMT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLFetchScroll =
  		function (hStmt: SQLHSTMT;
  		    FetchOrientation: SQLSMALLINT; FetchOffset: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLFreeConnect =
  		function (hdbc: SQLHDBC): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLFreeEnv =	function (henv: SQLHENV): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLFreeHandle =
  		function (fHandleType: SQLSMALLINT; hHandle: SQLHANDLE): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLFreeStmt =
  		function (hstmt: SQLHSTMT; fOption: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetConnectAttr =
  		function (hDbc: SQLHDBC; Attribute: SQLINTEGER; Value: SQLPOINTER;
                    BufferLength: SQLINTEGER; pStringLength: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetConnectOption =
  		function (hDbc: SQLHDBC; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetCursorName =
  		function (hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursorMax: SQLSMALLINT;
                    var cbCursor: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetData =	function (hStmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
                    rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                    var cbValue: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetDescField =
  		function (DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
                    Value: SQLPOINTER; BufferLength: SQLINTEGER;
                    var StringLength: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetDescRec =
  		function (DescriptorHandle: SQLHDESC; RecNumber: SQLSMALLINT;
                    Name: TSDCharPtr; BufferLength: SQLSMALLINT; var StringLength, RecType, RecSubType: SQLSMALLINT;
                    var Length: SQLINTEGER; var Precision, Scale, Nullable: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetDiagField =
  		function (fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
                    fDiagIdentifier: SQLSMALLINT; var cbDiagInfo: SQLINTEGER;
                    cbDiagInfoMax: SQLSMALLINT; pcbDiagInfo: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetDiagRec =
  		function (fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
                    szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
                    szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
                    var cbErrorMsg: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetEnvAttr =
  		function(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
         		BufLen: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetFunctions =
  		function (hDbc: SQLHDBC; fFunction: SQLUSMALLINT; var fExists: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetInfo =	function (hDbc: SQLHDBC; fInfoType: SQLUSMALLINT; rgbInfoValue: SQLPOINTER;
                    cbInfoValueMax: SQLSMALLINT; var cbInfoValue: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetStmtAttr =
  		function (hStmt: SQLHSTMT; Attribute: SQLINTEGER; Value: SQLPOINTER;
                    BufferLength: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetStmtOption =
  		function (hStmt: SQLHSTMT; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLGetTypeInfo =
  		function (hStmt: SQLHSTMT; fSqlType: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLNumResultCols =
  		function (hStmt: SQLHSTMT; var ccol: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLParamData =
  		function (hStmt: SQLHSTMT; var gbValue: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLPrepare =	function (hStmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLPutData =	function (hStmt: SQLHSTMT; rgbValue: SQLPOINTER; cbValue: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLRowCount =
  		function (hStmt: SQLHSTMT; var crow: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetConnectAttr =
  		function (hDbc: SQLHDBC; fOption: SQLINTEGER;
                    pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetConnectOption =
  		function (hDbc: SQLHDBC; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetCursorName =
  		function (hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursor: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetDescField =
  		function (DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
                    Value: SQLPOINTER; BufferLength: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetDescRec =
  		function (DescriptorHandle: SQLHDESC; RecNumber, RecType, RecSubType: SQLSMALLINT;
                    Length: SQLINTEGER; Precision, Scale: SQLSMALLINT;
                    Data: SQLPOINTER; var StringLength, Indicator: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetEnvAttr =
  		function(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
         		StringLength: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetParam =function (hStmt: SQLHSTMT; ipar: SQLUSMALLINT; fCType, fSqlType: SQLSMALLINT;
                    cbParamDef: SQLUINTEGER; ibScale: SQLSMALLINT;
                    rgbValue: SQLPOINTER; var cbValue: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetStmtAttr =
  		function (hStmt: SQLHSTMT; fOption: SQLINTEGER;
                    pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetStmtOption =
  		function (hStmt: SQLHSTMT; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSpecialColumns =
  		function (hStmt: SQLHSTMT; fColType: SQLUSMALLINT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    fScope, fNullable: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLStatistics =
  		function (hStmt: SQLHSTMT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    fUnique, fAccuracy: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLTables =	function (hStmt: SQLHSTMT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    szTableType: TSDCharPtr; cbTableType: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLTransact =function (hEnv: SQLHENV; hDbc: SQLHDBC; fType: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

{*******************************************************************************
** SQLEXT.H - This is the include for applications using
**             the Microsoft SQL Extensions
**
**		Updated 07/25/95 for 3.00 specification
**		Updated 01/12/96 for 3.00 preliminary release
** 		Updated 09/16/96 for 3.00 SDK release
**		Updated 11/21/96 for bug #4436
********************************************************************************}
  TSQLBrowseConnect =
  		function(hDbc: SQLHDBC; szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
              		szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                      	var cbConnStrOut: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLBulkOperations =
  		function(hStmt: SQLHSTMT; Operation: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLColAttributes =
  		function(hStmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT; rgbDesc: SQLPOINTER;
              		cbDescMax: SQLSMALLINT; var cbDesc: SQLSMALLINT; var fDesc: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLColumnPrivileges =
  		function(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
              	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                      szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                      szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLDescribeParam =
  		function(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; pfSqlType: SQLPOINTER;
              		var cbParamDef: SQLUINTEGER; pibScale, pfNullable: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLExtendedFetch =
  		function(hStmt: SQLHSTMT; fFetchType: SQLUSMALLINT; irow: SQLINTEGER;
              		var crow: SQLUINTEGER; var gfRowStatus: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLForeignKeys =
  		function(hStmt: SQLHSTMT; szPkCatalogName: TSDCharPtr; cbPkCatalogName: SQLSMALLINT;
              	szPkSchemaName: TSDCharPtr; cbPkSchemaName: SQLSMALLINT;
                      szPkTableName: TSDCharPtr; cbPkTableName: SQLSMALLINT;
                      szFkCatalogName: TSDCharPtr; cbFkCatalogName: SQLSMALLINT;
                      szFkSchemaName: TSDCharPtr; cbFkSchemaName: SQLSMALLINT;
                      szFkTableName: TSDCharPtr; cbFkTableName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLMoreResults =
  		function(hStmt: SQLHSTMT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLNativeSql =
  		function(hDbc: SQLHDBC; szSqlStrIn: TSDCharPtr; cbSqlStrIn: SQLINTEGER;
  			szSqlStr: TSDCharPtr; cbSqlStrMax: SQLINTEGER; var cbSqlStr: SQLINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLNumParams =
  		function(hStmt: SQLHSTMT; var cpar: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLParamOptions =
  		function(hStmt: SQLHSTMT; crow: SQLUINTEGER; var irow: SQLUINTEGER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLPrimaryKeys =
  		function(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
  			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
  			szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLProcedureColumns =
  		function(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
  			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                      szProcName: TSDCharPtr; cbProcName: SQLSMALLINT;
  			szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLProcedures =
  		function(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
  			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
  			szProcName: TSDCharPtr; cbProcName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLSetPos =
  		function(hStmt: SQLHSTMT; irow, fOption, fLock: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLTablePrivileges =
  		function(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
              	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                      szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLDrivers =
  		function(hEnv: SQLHENV; fDirection: SQLUSMALLINT; szDriverDesc: TSDCharPtr;
              		cbDriverDescMax: SQLSMALLINT; var cbDriverDesc: SQLSMALLINT;
                      	szDriverAttributes: TSDCharPtr; cbDrvrAttrMax: SQLSMALLINT; var cbDrvrAttr: SQLSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLBindParameter =
  		function(hStmt: SQLHSTMT; ipar: SQLUSMALLINT;
  			fParamType, fCType, fSqlType: SQLSMALLINT;
  			cbColDef: SQLUINTEGER; ibScale: SQLSMALLINT;
  			rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                        pcbValue: SQLPOINTER): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  TSQLDriverConnect =
  		function(hDbc: SQLHDBC; hWnd: SQLHWND;
                	szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
                        szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                        var cbConnStrOut: SQLSMALLINT; fDriverCompletion: SQLUSMALLINT): SQLRETURN; {$IFNDEF SD_CLR} stdcall; {$ENDIF}


{ TOdbcFunctions }
  TOdbcFunctions = class
  protected
    FLibHandle: THandle;

    FSQLAllocConnect:	TSQLAllocConnect;
    FSQLAllocEnv:	TSQLAllocEnv;
    FSQLAllocHandle:	TSQLAllocHandle;
    FSQLAllocStmt:	TSQLAllocStmt;
    FSQLBindCol:	TSQLBindCol;
    FSQLCancel:		TSQLCancel;
    FSQLCloseCursor:	TSQLCloseCursor;
    FSQLColAttribute:	TSQLColAttribute;
    FSQLColumns:	TSQLColumns;
    FSQLConnect:	TSQLConnect;
    FSQLCopyDesc:	TSQLCopyDesc;
    FSQLDataSources:	TSQLDataSources;
    FSQLDescribeCol:	TSQLDescribeCol;
    FSQLDisconnect:	TSQLDisconnect;
    FSQLEndTran:	TSQLEndTran;
    FSQLError:		TSQLError;
    FSQLExecDirect:	TSQLExecDirect;
    FSQLExecute:	TSQLExecute;
    FSQLFetch:		TSQLFetch;
    FSQLFetchScroll:	TSQLFetchScroll;
    FSQLFreeConnect:	TSQLFreeConnect;
    FSQLFreeEnv:	TSQLFreeEnv;
    FSQLFreeHandle:	TSQLFreeHandle;
    FSQLFreeStmt:	TSQLFreeStmt;
    FSQLGetConnectAttr:	TSQLGetConnectAttr;
    FSQLGetConnectOption:TSQLGetConnectOption;
    FSQLGetCursorName:	TSQLGetCursorName;
    FSQLGetData:	TSQLGetData;
    FSQLGetDescField:	TSQLGetDescField;
    FSQLGetDescRec:	TSQLGetDescRec;
    FSQLGetDiagField:	TSQLGetDiagField;
    FSQLGetDiagRec:	TSQLGetDiagRec;
    FSQLGetEnvAttr:	TSQLGetEnvAttr;
    FSQLGetFunctions:	TSQLGetFunctions;
    FSQLGetInfo:	TSQLGetInfo;
    FSQLGetStmtAttr:	TSQLGetStmtAttr;
    FSQLGetStmtOption:	TSQLGetStmtOption;
    FSQLGetTypeInfo:	TSQLGetTypeInfo;
    FSQLNumResultCols:	TSQLNumResultCols;
    FSQLParamData:	TSQLParamData;
    FSQLPrepare:	TSQLPrepare;
    FSQLPutData:	TSQLPutData;
    FSQLRowCount:	TSQLRowCount;
    FSQLSetConnectAttr:	TSQLSetConnectAttr;
    FSQLSetConnectOption:TSQLSetConnectOption;
    FSQLSetCursorName:	TSQLSetCursorName;
    FSQLSetDescField:	TSQLSetDescField;
    FSQLSetDescRec:	TSQLSetDescRec;
    FSQLSetEnvAttr:	TSQLSetEnvAttr;
    FSQLSetParam:	TSQLSetParam;
    FSQLSetStmtAttr:	TSQLSetStmtAttr;
    FSQLSetStmtOption:	TSQLSetStmtOption;
    FSQLSpecialColumns:	TSQLSpecialColumns;
    FSQLStatistics:	TSQLStatistics;
    FSQLTables:		TSQLTables;
    FSQLTransact:	TSQLTransact;
	// from SQLEXT.H
    FSQLBrowseConnect:	TSQLBrowseConnect;
    FSQLBulkOperations:	TSQLBulkOperations;
    FSQLColAttributes:	TSQLColAttributes;
    FSQLColumnPrivileges:TSQLColumnPrivileges;
    FSQLDescribeParam:	TSQLDescribeParam;
    FSQLExtendedFetch:	TSQLExtendedFetch;
    FSQLForeignKeys:	TSQLForeignKeys;
    FSQLMoreResults:	TSQLMoreResults;
    FSQLNativeSql:	TSQLNativeSql;
    FSQLNumParams:	TSQLNumParams;
    FSQLParamOptions:	TSQLParamOptions;
    FSQLPrimaryKeys:	TSQLPrimaryKeys;
    FSQLProcedureColumns:TSQLProcedureColumns;
    FSQLProcedures:	TSQLProcedures;
    FSQLSetPos:		TSQLSetPos;
    FSQLTablePrivileges:TSQLTablePrivileges;
    FSQLDrivers:     	TSQLDrivers;
    FSQLBindParameter:	TSQLBindParameter;
    FSQLDriverConnect:	TSQLDriverConnect;
  public
    procedure SetApiCalls(ASqlLibModule: THandle); virtual;
    procedure ClearApiCalls; virtual;
    function IsAvailFunc(AName: string): Boolean;
    property SQLAllocConnect:	TSQLAllocConnect 	read FSQLAllocConnect;
    property SQLAllocEnv:	TSQLAllocEnv		read FSQLAllocEnv;
    property SQLAllocHandle:	TSQLAllocHandle		read FSQLAllocHandle;
    property SQLAllocStmt:	TSQLAllocStmt		read FSQLAllocStmt;
    property SQLBindCol:	TSQLBindCol		read FSQLBindCol;
    property SQLCancel:		TSQLCancel		read FSQLCancel;
    property SQLCloseCursor:	TSQLCloseCursor		read FSQLCloseCursor;
    property SQLColAttribute:	TSQLColAttribute	read FSQLColAttribute;
    property SQLColumns:	TSQLColumns		read FSQLColumns;
    property SQLConnect:	TSQLConnect		read FSQLConnect;
    property SQLCopyDesc:	TSQLCopyDesc		read FSQLCopyDesc;
    property SQLDataSources:	TSQLDataSources		read FSQLDataSources;
    property SQLDescribeCol:	TSQLDescribeCol		read FSQLDescribeCol;
    property SQLDisconnect:	TSQLDisconnect		read FSQLDisconnect;
    property SQLEndTran:	TSQLEndTran		read FSQLEndTran;
    property SQLError:		TSQLError		read FSQLError;
    property SQLExecDirect:	TSQLExecDirect		read FSQLExecDirect;
    property SQLExecute:	TSQLExecute		read FSQLExecute;
    property SQLFetch:		TSQLFetch		read FSQLFetch;
    property SQLFetchScroll:	TSQLFetchScroll		read FSQLFetchScroll;
    property SQLFreeConnect:	TSQLFreeConnect		read FSQLFreeConnect;
    property SQLFreeEnv:	TSQLFreeEnv		read FSQLFreeEnv;
    property SQLFreeHandle:	TSQLFreeHandle		read FSQLFreeHandle;
    property SQLFreeStmt:	TSQLFreeStmt		read FSQLFreeStmt;
    property SQLGetConnectAttr:	TSQLGetConnectAttr    	read FSQLGetConnectAttr;
    property SQLGetConnectOption:TSQLGetConnectOption 	read FSQLGetConnectOption;
    property SQLGetCursorName:	TSQLGetCursorName     	read FSQLGetCursorName;
    property SQLGetData:	TSQLGetData		read FSQLGetData;
    property SQLGetDescField:	TSQLGetDescField      	read FSQLGetDescField;
    property SQLGetDescRec:	TSQLGetDescRec		read FSQLGetDescRec;
    property SQLGetDiagField:	TSQLGetDiagField      	read FSQLGetDiagField;
    property SQLGetDiagRec:	TSQLGetDiagRec		read FSQLGetDiagRec;
    property SQLGetEnvAttr:	TSQLGetEnvAttr		read FSQLGetEnvAttr;
    property SQLGetFunctions:	TSQLGetFunctions      	read FSQLGetFunctions;
    property SQLGetInfo:	TSQLGetInfo		read FSQLGetInfo;
    property SQLGetStmtAttr:	TSQLGetStmtAttr		read FSQLGetStmtAttr;
    property SQLGetStmtOption:	TSQLGetStmtOption     	read FSQLGetStmtOption;
    property SQLGetTypeInfo:	TSQLGetTypeInfo		read FSQLGetTypeInfo;
    property SQLNumResultCols:	TSQLNumResultCols     	read FSQLNumResultCols;
    property SQLParamData:	TSQLParamData		read FSQLParamData;
    property SQLPrepare:	TSQLPrepare		read FSQLPrepare;
    property SQLPutData:	TSQLPutData		read FSQLPutData;
    property SQLRowCount:	TSQLRowCount		read FSQLRowCount;
    property SQLSetConnectAttr:	TSQLSetConnectAttr    	read FSQLSetConnectAttr;
    property SQLSetConnectOption:TSQLSetConnectOption	read FSQLSetConnectOption;
    property SQLSetCursorName:	TSQLSetCursorName  	read FSQLSetCursorName;
    property SQLSetDescField:	TSQLSetDescField   	read FSQLSetDescField;
    property SQLSetDescRec:	TSQLSetDescRec		read FSQLSetDescRec;
    property SQLSetEnvAttr:	TSQLSetEnvAttr		read FSQLSetEnvAttr;
    property SQLSetParam:	TSQLSetParam		read FSQLSetParam;
    property SQLSetStmtAttr:	TSQLSetStmtAttr		read FSQLSetStmtAttr;
    property SQLSetStmtOption:	TSQLSetStmtOption  	read FSQLSetStmtOption;
    property SQLSpecialColumns:	TSQLSpecialColumns 	read FSQLSpecialColumns;
    property SQLStatistics:	TSQLStatistics		read FSQLStatistics;
    property SQLTables:		TSQLTables		read FSQLTables;
    property SQLTransact:	TSQLTransact		read FSQLTransact;
	// from SQLEXT.H
    property SQLBrowseConnect:	TSQLBrowseConnect    	read FSQLBrowseConnect;
    property SQLBulkOperations:	TSQLBulkOperations   	read FSQLBulkOperations;
    property SQLColAttributes:	TSQLColAttributes    	read FSQLColAttributes;
    property SQLColumnPrivileges:TSQLColumnPrivileges	read FSQLColumnPrivileges;
    property SQLDescribeParam:	TSQLDescribeParam    	read FSQLDescribeParam;
    property SQLExtendedFetch:	TSQLExtendedFetch    	read FSQLExtendedFetch;
    property SQLForeignKeys:	TSQLForeignKeys		read FSQLForeignKeys;
    property SQLMoreResults:	TSQLMoreResults		read FSQLMoreResults;
    property SQLNativeSql:	TSQLNativeSql		read FSQLNativeSql;
    property SQLNumParams:	TSQLNumParams		read FSQLNumParams;
    property SQLParamOptions:	TSQLParamOptions     	read FSQLParamOptions;
    property SQLPrimaryKeys:	TSQLPrimaryKeys		read FSQLPrimaryKeys;
    property SQLProcedureColumns:TSQLProcedureColumns	read FSQLProcedureColumns;
    property SQLProcedures:	TSQLProcedures		read FSQLProcedures;
    property SQLSetPos:		TSQLSetPos		read FSQLSetPos;
    property SQLTablePrivileges:TSQLTablePrivileges	read FSQLTablePrivileges;
    property SQLDrivers:	TSQLDrivers		read FSQLDrivers;
    property SQLBindParameter:	TSQLBindParameter	read FSQLBindParameter;
    property SQLDriverConnect:	TSQLDriverConnect	read FSQLDriverConnect;
  end;

  ESDOdbcError = class(ESDEngineError)
  private
    FSqlState: string;
  public
    constructor CreateWithSqlState(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string);
    property SqlState: string read FSqlState;
  end;

{ TICustomOdbcDatabase }
  TIOdbcConnInfo= packed record
    ServerType: Byte;
    hEnv: SQLHENV;		// environment handle
    hDbc: SQLHDBC;   		// connection handle
  end;

  TICustomOdbcDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;
    FDriverOdbcVer: LongInt;		// version of ODBC that driver supports
    FIsTransSupported: Boolean;		// Is transaction supported for ODBC datasource ?
    FDBMSVer: string;
    FGetDataAnyColumn: Boolean;         // SQLGetData can be called for any unbound column, including those before the last bound column

    FCurSqlCmd: TISqlCommand;		// a command, which uses a database handle currently (when FIsSingleConn is True)

    function GetCalls: TOdbcFunctions;
    function GetDriverOdbcVersion: LongInt;
    function GetDriverOdbcMajor: Word;
    function GetDriverOdbcMinor: Word;
    function GetIsNeedLongDataLen: Boolean;
    function GetEnvHandle: SQLHENV;
    function GetDbcHandle: SQLHDBC;
    function GetAutoCommitOption: Boolean;
  protected
    FCalls: TOdbcFunctions;

    procedure AllocHandle;
    procedure AllocOdbcHandles;
    procedure FreeHandle;
    procedure FreeOdbcHandles;
    procedure SetDefaultOptions;

    function OdbcAllocHandle(fHandleType: SQLSMALLINT; hInput: SQLHANDLE; var hOutput: SQLHANDLE): SQLRETURN;
    function OdbcFreeHandle(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE): SQLRETURN;
    function OdbcGetConnectAttrInt32(hDbc: SQLHDBC; fOption: SQLINTEGER): SQLUINTEGER;
    function OdbcSetConnectAttr(hDbc: SQLHDBC; fOption: SQLINTEGER; pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN;
    function OdbcSetStmtAttr(hStmt: SQLHSTMT; fOption: SQLINTEGER; pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN;
    function OdbcTransact(fEndType: SQLSMALLINT): SQLRETURN;
    function OdbcGetInfoInt16(InfoType: Integer): SQLUSMALLINT;
    function OdbcGetInfoInt32(InfoType: Integer): SQLUINTEGER;
    function OdbcGetInfoString(InfoType: Integer): string;
    function OdbcGetMaxCatalogNameLen: SQLUSMALLINT;
    function OdbcGetMaxFieldNameLen: SQLUSMALLINT;
    function OdbcGetMaxProcNameLen: SQLUSMALLINT;
    function OdbcGetMaxSchemaNameLen: SQLUSMALLINT;
    function OdbcGetMaxTableNameLen: SQLUSMALLINT;

    procedure CheckHandle(AHandleType: SQLSMALLINT; AHandle: SQLHANDLE; AStatus: TSDEResult);
    procedure CheckHDBC(AHandle: SQLHDBC; Status: TSDEResult);
    procedure CheckHSTMT(AHandle: SQLHSTMT; Status: TSDEResult);
    procedure Check(Status: TSDEResult);
    procedure FreeSqlLib; virtual; abstract;
    procedure LoadSqlLib; virtual; abstract;
    procedure RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string); virtual; abstract;

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

    function GetAutoIncSQL: string; override;
    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;

    procedure ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll: Boolean);
    property CurSqlCmd: TISqlCommand read FCurSqlCmd;
    property Calls: TOdbcFunctions read GetCalls;
    property EnvHandle: SQLHENV read GetEnvHandle;
    property DbcHandle: SQLHDBC read GetDbcHandle;
    property DriverOdbcMajor: Word read GetDriverOdbcMajor;
    property DriverOdbcMinor: Word read GetDriverOdbcMinor;
    property IsNeedLongDataLen: Boolean read GetIsNeedLongDataLen;
  end;

{ TICustomOdbcCommand }
  TICustomOdbcCommand = class(TISqlCommand)
  private
    FHandle: SQLHSTMT;		// statement handle
    FNextResults: Boolean;	// if one of multiple result sets processing
    FIsSingleConn: Boolean;	// True, if it's required to use a database handle always
    FInfoExecuted: Boolean;	// a statement was executed in GetFieldDesc method
    FNoMoreResult: Boolean;     // True, if SQLMoreResults was called and a result don't exist
    FIsSrvCursor: Boolean;      // if server cursor is used
    FExecDirect: Boolean;       // if a statement was executed directly already (set&reset in DoExecDirect)
    FNoDataExecuted: Boolean;	// a statement was executed with SQL_NO_DATA return code
    FFirstCalcFieldIdx: Integer;// first field, which is not bound. The following fields are not corresponded actual database fields
{$IFDEF SD_VCL4}
    FPrefetchMode: Boolean;	// if multirow fetch is used
    FPrefetchRows: Integer;	// number of rows returned by each call to SQLFetch (this feature is supported for ODBC 3.0)
    FRowsFetchedPtr: TSDPtr;      // pointer(PSQLUINTEGER) to number of rows fetched after a call to SQLFetch
    FRowStatusValues: TSDPtr;     // array of SQLUSMALLINT;
{$ENDIF}
    FCurrRow: SQLINTEGER;	// current row in a row array
    FRowSize: SQLINTEGER;	// row size
    FBlobPieceSize,
    FMaxBlobSize: Integer;

    function GetCalls: TOdbcFunctions;
    function GetSqlDatabase: TICustomOdbcDatabase;
    function GetIsCallStmt: Boolean;
    function GetIsExecDirect: Boolean;
    function GetNumResultCols: SQLSMALLINT;

    function CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDValueBuffer; BufSize: Integer): TDateTimeRec;
    function CnvtDBData(ExtDataType: Integer; ADataType: TFieldType; InBuf, Buffer: TSDPtr; BufSize: Integer): Boolean;
    function CreateCommandText(Value: string): string;
    procedure InternalPrepare(AStmt: string);
    procedure InternalQExecute(InfoQuery: Boolean);
    procedure InternalSpExecute(InfoQuery: Boolean);
    procedure InternalSpGetParams;
    procedure QBindParamsBuffer;
    procedure SpBindParamsBuffer;
    procedure SpExecute;
    function IsInterval(FieldDesc: TSDFieldDesc): Boolean;
    function IsIntervalType(ExtDataType: Integer): Boolean;
    function IsPseudoBlob(FieldDesc: TSDFieldDesc): Boolean;
    function OdbcGetColAttrInt32(hStmt: SQLHSTMT; iCol, AttrType: SQLUSMALLINT): SQLUINTEGER;
  protected
    procedure AcquireDBHandle;
    procedure ReleaseDBHandle;

    procedure Check(Status: TSDEResult);
    procedure CheckPrepared;
    procedure Connect; virtual;
    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; override;
    procedure DoExecute; override;
    procedure DoExecDirect(Value: string); override;
    procedure DoPrepare(Value: string); override;

    procedure AllocParamsBuffer; override;
    procedure BindParamsBuffer; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    procedure InitParamList; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function SqlDataType(FieldType: TFieldType): Integer; virtual;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    function GetHandle: PSDCursor; override;
    function GetFieldsBuffer: TSDRecordBuffer; override;
    function GetFieldsBufferSize: Integer; override;
    procedure FreeFieldsBuffer; override;
    procedure SetFieldsBuffer; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    function GetRowsAffected: Integer; override;
    function NextResultSet: Boolean; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;
    function WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: LongInt): Longint; override;

    property Calls: TOdbcFunctions read GetCalls;
    property IsCallStmt: Boolean read GetIsCallStmt;
    property IsExecDirect: Boolean read GetIsExecDirect;
    property IsSrvCursor: Boolean read FIsSrvCursor;    
    property SqlDatabase: TICustomOdbcDatabase read GetSqlDatabase;
  end;

{ TICustomOdbcCall to process ODBC calls with a result set (SQLTables, SQLColumns..)}
  TICustomOdbcCall = class(TICustomOdbcCommand)
  protected
    procedure DoExecute; override;
    procedure DoExecDirect(Value: string); override;
    procedure DoPrepare(Value: string); override;
  end;

{ TIOdbcCallProcs }
  TIOdbcCallProcs = class(TICustomOdbcCall)
  private
    FProcNames: string;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    property ProcNames: string read FProcNames write FProcNames;
  end;

{ TIOdbcCallProcParams }
  TIOdbcCallProcParams = class(TICustomOdbcCall)
  private
    FProcName: string;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    property ProcName: string read FProcName write FProcName;
  end;

{ TIOdbcCallTables }
  TIOdbcCallTables = class(TICustomOdbcCall)
  private
    FTableNames: string;
    FTableTypes: string;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property TableNames: string read FTableNames write FTableNames;
    property TableTypes: string read FTableTypes write FTableTypes;
  end;

{ TIOdbcCallColumns }
  TIOdbcCallColumns = class(TICustomOdbcCall)
  private
    FTableName: string;
    FColTypeFieldIdx,
    FColPrecFieldIdx,
    FColPosV2FieldIdx,
    FColDefV2FieldIdx: Integer;
    function GetIsODBC_3: Boolean;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property IsODBC_3: Boolean read GetIsODBC_3;
    property TableName: string read FTableName write FTableName;
  end;

{ TIOdbcCallIndexes }
  TIOdbcCallIndexes = class(TICustomOdbcCall)
  private
    FTableName: string;
  protected
    procedure DoExecDirect(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    function FetchNextRow: Boolean; override;
    property TableName: string read FTableName write FTableName;
  end;

{ TIOdbcDatabase }
  TIOdbcDatabase = class(TICustomOdbcDatabase)
  protected
    procedure FreeSqlLib; override;
    procedure LoadSqlLib; override;
    procedure RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string); override;
  public
    function CreateSqlCommand: TISqlCommand; override;
  end;

{ TIOdbcCommand }
  TIOdbcCommand = class(TICustomOdbcCommand)
  end;

const
  DefSqlApiDLL	= 'ODBC32.DLL';

var
  SqlApiDLL: string;
  OdbCalls: TOdbcFunctions;

{$IFDEF SD_CLR}

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocConnect')]
function SQLAllocConnect(henv :SQLHENV; var hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocEnv')]
function SQLAllocEnv(var henv: SQLHENV): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocHandle')]
function SQLAllocHandle(fHandleType: SQLSMALLINT; hInput: SQLHANDLE;
    var hOutput: SQLHANDLE): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocStmt')]
function SQLAllocStmt(hdbc: SQLHDBC; var hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindCol')]
function SQLBindCol(hstmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
                    rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                    pcbValue: SQLPOINTER{PSQLINTEGER}): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCancel')]
function SQLCancel(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCloseCursor')]
function SQLCloseCursor(hStmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColAttribute')]
function SQLColAttribute(hstmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT;
                    rgbDesc: SQLPOINTER; cbDescMax: SQLSMALLINT;
                    pcbDesc: SQLPOINTER; pfDesc: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColumns')]
function SQLColumns(hStmt: SQLHSTMT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLConnect')]
function SQLConnect(hdbc: SQLHDBC; szDSN: TSDCharPtr; cbDSN: SQLSMALLINT;
                    szUID: TSDCharPtr; cbUID: SQLSMALLINT;
                    szAuthStr: TSDCharPtr; cbAuthStr: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCopyDesc')]
function SQLCopyDesc(hDescSource: SQLHDESC; hDescTarget: SQLHDESC): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDataSources')]
function SQLDataSources(hEnv: SQLHENV; fDirection: SQLUSMALLINT;
                    szDSN: TSDCharPtr; cbDSNMax: SQLSMALLINT; var cbDSN: SQLSMALLINT;
                    szDescription: TSDCharPtr; cbDescriptionMax: SQLSMALLINT;
                    var cbDescription: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDescribeCol')]
function SQLDescribeCol(hstmt: SQLHSTMT; icol: SQLUSMALLINT;
                    szColName: TSDCharPtr; cbColNameMax: SQLSMALLINT; var cbColName, fSqlType: SQLSMALLINT;
                    var cbColDef: SQLUINTEGER; var ibScale, fNullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDisconnect')]
function SQLDisconnect(hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLEndTran')]
function SQLEndTran(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; fType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLError')]
function SQLError(henv: SQLHENV; hdbc: SQLHDBC; hstmt: SQLHSTMT;
            szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
            szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
            var cbErrorMsg: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExecDirect')]
function SQLExecDirect(hstmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExecute')]
function SQLExecute(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFetch')]
function SQLFetch(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFetchScroll')]
function SQLFetchScroll(hStmt: SQLHSTMT;
	    FetchOrientation: SQLSMALLINT; FetchOffset: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeConnect')]
function SQLFreeConnect(hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeEnv')]
function SQLFreeEnv(henv: SQLHENV): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeHandle')]
function SQLFreeHandle(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeStmt')]
function SQLFreeStmt(hstmt: SQLHSTMT; fOption: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetConnectAttr')]
function SQLGetConnectAttr(hDbc: SQLHDBC; Attribute: SQLINTEGER; Value: SQLPOINTER;
            BufferLength: SQLINTEGER; pStringLength: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetConnectOption')]
function SQLGetConnectOption(hDbc: SQLHDBC; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetCursorName')]
function SQLGetCursorName(hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursorMax: SQLSMALLINT;
            var cbCursor: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetData')]
function SQLGetData(hStmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
            rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
            var cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDescField')]
function SQLGetDescField(DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
            Value: SQLPOINTER; BufferLength: SQLINTEGER;
            var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDescRec')]
function SQLGetDescRec(DescriptorHandle: SQLHDESC; RecNumber: SQLSMALLINT;
            Name: TSDCharPtr; BufferLength: SQLSMALLINT; var StringLength, RecType, RecSubType: SQLSMALLINT;
            var Length: SQLINTEGER; var Precision, Scale, Nullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDiagField')]
function SQLGetDiagField(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
            fDiagIdentifier: SQLSMALLINT; var cbDiagInfo: SQLINTEGER;
            cbDiagInfoMax: SQLSMALLINT; pcbDiagInfo: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDiagRec')]
function SQLGetDiagRec(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
               szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
               szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
               var cbErrorMsg: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetEnvAttr')]
function SQLGetEnvAttr(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
    		BufLen: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetFunctions')]
function SQLGetFunctions(hDbc: SQLHDBC; fFunction: SQLUSMALLINT; var fExists: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetInfo')]
function SQLGetInfo(hDbc: SQLHDBC; fInfoType: SQLUSMALLINT; rgbInfoValue: SQLPOINTER;
               cbInfoValueMax: SQLSMALLINT; var cbInfoValue: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetStmtAttr')]
function SQLGetStmtAttr(hStmt: SQLHSTMT; Attribute: SQLINTEGER; Value: SQLPOINTER;
               BufferLength: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetStmtOption')]
function SQLGetStmtOption(hStmt: SQLHSTMT; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetTypeInfo')]
function SQLGetTypeInfo(hStmt: SQLHSTMT; fSqlType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNumResultCols')]
function SQLNumResultCols(hStmt: SQLHSTMT; var ccol: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLParamData')]
function SQLParamData(hStmt: SQLHSTMT; var gbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPrepare')]
function SQLPrepare(hStmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPutData')]
function SQLPutData(hStmt: SQLHSTMT; rgbValue: SQLPOINTER; cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLRowCount')]
function SQLRowCount(hStmt: SQLHSTMT; var crow: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetConnectAttr')]
function SQLSetConnectAttr(hDbc: SQLHDBC; fOption: SQLINTEGER;
        pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetConnectOption')]
function SQLSetConnectOption(hDbc: SQLHDBC; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetCursorName')]
function SQLSetCursorName(hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursor: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetDescField')]
function SQLSetDescField(DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
        Value: SQLPOINTER; BufferLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetDescRec')]
function SQLSetDescRec(DescriptorHandle: SQLHDESC; RecNumber, RecType, RecSubType: SQLSMALLINT;
        Length: SQLINTEGER; Precision, Scale: SQLSMALLINT;
        Data: SQLPOINTER; var StringLength, Indicator: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetEnvAttr')]
function SQLSetEnvAttr(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
	StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetParam')]
function SQLSetParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; fCType, fSqlType: SQLSMALLINT;
               cbParamDef: SQLUINTEGER; ibScale: SQLSMALLINT;
               rgbValue: SQLPOINTER; var cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetStmtAttr')]
function SQLSetStmtAttr(hStmt: SQLHSTMT; fOption: SQLINTEGER;
        pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetStmtOption')]
function SQLSetStmtOption(hStmt: SQLHSTMT; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSpecialColumns')]
function SQLSpecialColumns(hStmt: SQLHSTMT; fColType: SQLUSMALLINT;
        szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
        szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
        szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
        fScope, fNullable: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLStatistics')]
function SQLStatistics(hStmt: SQLHSTMT;
        szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
        szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
        szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
        fUnique, fAccuracy: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTables')]
function SQLTables(hStmt: SQLHSTMT;
               szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
               szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
               szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
               szTableType: TSDCharPtr; cbTableType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTransact')]
function SQLTransact(hEnv: SQLHENV; hDbc: SQLHDBC; fType: SQLUSMALLINT): SQLRETURN; external;

{*******************************************************************************
** from SQLEXT.H
********************************************************************************}
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBrowseConnect')]
function SQLBrowseConnect(hDbc: SQLHDBC; szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
           	szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                var cbConnStrOut: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBulkOperations')]
function SQLBulkOperations(hStmt: SQLHSTMT; Operation: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColAttributes')]
function SQLColAttributes(hStmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT; rgbDesc: SQLPOINTER;
           	cbDescMax: SQLSMALLINT; var cbDesc: SQLSMALLINT; var fDesc: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColumnPrivileges')]
function SQLColumnPrivileges(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
           	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDescribeParam')]
function SQLDescribeParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; pfSqlType: SQLPOINTER;
           	var cbParamDef: SQLUINTEGER; pibScale, pfNullable: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExtendedFetch')]
function SQLExtendedFetch(hStmt: SQLHSTMT; fFetchType: SQLUSMALLINT; irow: SQLINTEGER;
           	var crow: SQLUINTEGER; var gfRowStatus: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLForeignKeys')]
function SQLForeignKeys(hStmt: SQLHSTMT; szPkCatalogName: TSDCharPtr; cbPkCatalogName: SQLSMALLINT;
           	szPkSchemaName: TSDCharPtr; cbPkSchemaName: SQLSMALLINT;
                szPkTableName: TSDCharPtr; cbPkTableName: SQLSMALLINT;
                szFkCatalogName: TSDCharPtr; cbFkCatalogName: SQLSMALLINT;
                szFkSchemaName: TSDCharPtr; cbFkSchemaName: SQLSMALLINT;
                szFkTableName: TSDCharPtr; cbFkTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLMoreResults')]
function SQLMoreResults(hStmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNativeSql')]
function SQLNativeSql(hDbc: SQLHDBC; szSqlStrIn: TSDCharPtr; cbSqlStrIn: SQLINTEGER;
			szSqlStr: TSDCharPtr; cbSqlStrMax: SQLINTEGER; var cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNumParams')]
function SQLNumParams(hStmt: SQLHSTMT; var cpar: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLParamOptions')]
function SQLParamOptions(hStmt: SQLHSTMT; crow: SQLUINTEGER; var irow: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPrimaryKeys')]
function SQLPrimaryKeys(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
			szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLProcedureColumns')]
function SQLProcedureColumns(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                        szProcName: TSDCharPtr; cbProcName: SQLSMALLINT;
			szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLProcedures')]
function SQLProcedures(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
			szProcName: TSDCharPtr; cbProcName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetPos')]
function SQLSetPos(hStmt: SQLHSTMT; irow, fOption, fLock: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTablePrivileges')]
function SQLTablePrivileges(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
           	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDrivers')]
function SQLDrivers(hEnv: SQLHENV; fDirection: SQLUSMALLINT; szDriverDesc: TSDCharPtr;
           	cbDriverDescMax: SQLSMALLINT; var cbDriverDesc: SQLSMALLINT;
                   szDriverAttributes: TSDCharPtr; cbDrvrAttrMax: SQLSMALLINT; var cbDrvrAttr: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindParameter')]
function SQLBindParameter(hStmt: SQLHSTMT; ipar: SQLUSMALLINT;
			fParamType, fCType, fSqlType: SQLSMALLINT;
			cbColDef: SQLUINTEGER; ibScale: SQLSMALLINT;
			rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                        pcbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDriverConnect')]
function SQLDriverConnect(hDbc: SQLHDBC; hWnd: SQLHWND;
             	        szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
                        szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                        var cbConnStrOut: SQLSMALLINT; fDriverCompletion: SQLUSMALLINT): SQLRETURN; external;
{$ENDIF}

(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

implementation


resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';

const
  ParamMarker	= '?';
  CT_USERID1    = 'UID=';
  CT_USERID2    = 'USERID=';
  CT_PASSWORD1  = 'PWD=';
  CT_PASSWORD2  = 'PASSWORD=';

var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istODBC) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIOdbcDatabase.Create( ADbParams );
end;

{ Whether the specified connection tags are present }
function CT_UserIDExists(const ConnStr: string): Boolean;
var
  s: string;
begin
  s := UpperCase(ConnStr);
  Result := Pos(CT_USERID1, s) > 0;
        // check the second form
  if not Result then
    Result := Pos(CT_USERID2, s) > 0;
end;

function CT_PasswordExists(const ConnStr: string): Boolean;
var
  s: string;
begin
  s := UpperCase(ConnStr);
  Result := Pos(CT_PASSWORD1, s) > 0;
        // check the second form
  if not Result then
    Result := Pos(CT_PASSWORD2, s) > 0;
end;

// implementation of SQL_LEN_DATA_AT_EXEC macro
function SQL_LEN_DATA_AT_EXEC(ALength: SQLINTEGER): SQLINTEGER;
begin
  Result := (-(ALength)+SQL_LEN_DATA_AT_EXEC_OFFSET);
end;

{ TOdbcFunctions }
function TOdbcFunctions.IsAvailFunc(AName: string): Boolean;
begin
  Result := Assigned( GetProcAddress(FLibHandle, {$IFDEF SD_CLR}AName{$ELSE}PChar(AName){$ENDIF}) );
end;

procedure TOdbcFunctions.SetApiCalls(ASqlLibModule: THandle);
begin
  FLibHandle := ASqlLibModule;
{$IFDEF SD_CLR}
  FSQLAllocConnect    	:= SDOdbc.SQLAllocConnect;
  FSQLAllocEnv        	:= SDOdbc.SQLAllocEnv;
  FSQLAllocHandle     	:= SDOdbc.SQLAllocHandle;
  FSQLAllocStmt       	:= SDOdbc.SQLAllocStmt;
  FSQLBindCol         	:= SDOdbc.SQLBindCol;
  FSQLCancel          	:= SDOdbc.SQLCancel;
  FSQLCloseCursor     	:= SDOdbc.SQLCloseCursor;
  FSQLColAttribute    	:= SDOdbc.SQLColAttribute;
  FSQLColumns         	:= SDOdbc.SQLColumns;
  FSQLConnect         	:= SDOdbc.SQLConnect;
  FSQLCopyDesc        	:= SDOdbc.SQLCopyDesc;
  FSQLDataSources     	:= SDOdbc.SQLDataSources;
  FSQLDescribeCol     	:= SDOdbc.SQLDescribeCol;
  FSQLDisconnect      	:= SDOdbc.SQLDisconnect;
  FSQLEndTran         	:= SDOdbc.SQLEndTran;
  FSQLError           	:= SDOdbc.SQLError;
  FSQLExecDirect      	:= SDOdbc.SQLExecDirect;
  FSQLExecute         	:= SDOdbc.SQLExecute;
  FSQLFetch           	:= SDOdbc.SQLFetch;
  FSQLFetchScroll     	:= SDOdbc.SQLFetchScroll;
  FSQLFreeConnect     	:= SDOdbc.SQLFreeConnect;
  FSQLFreeEnv         	:= SDOdbc.SQLFreeEnv;
  FSQLFreeHandle      	:= SDOdbc.SQLFreeHandle;
  FSQLFreeStmt        	:= SDOdbc.SQLFreeStmt;
  FSQLGetConnectAttr  	:= SDOdbc.SQLGetConnectAttr;
  FSQLGetConnectOption	:= SDOdbc.SQLGetConnectOption;
  FSQLGetCursorName   	:= SDOdbc.SQLGetCursorName;
  FSQLGetData         	:= SDOdbc.SQLGetData;
  FSQLGetDescField    	:= SDOdbc.SQLGetDescField;
  FSQLGetDescRec      	:= SDOdbc.SQLGetDescRec;
  FSQLGetDiagField    	:= SDOdbc.SQLGetDiagField;
  FSQLGetDiagRec      	:= SDOdbc.SQLGetDiagRec;
  FSQLGetEnvAttr      	:= SDOdbc.SQLGetEnvAttr;
  FSQLGetFunctions    	:= SDOdbc.SQLGetFunctions;
  FSQLGetInfo         	:= SDOdbc.SQLGetInfo;
  FSQLGetStmtAttr     	:= SDOdbc.SQLGetStmtAttr;
  FSQLGetStmtOption   	:= SDOdbc.SQLGetStmtOption;
  FSQLGetTypeInfo     	:= SDOdbc.SQLGetTypeInfo;
  FSQLNumResultCols   	:= SDOdbc.SQLNumResultCols;
  FSQLParamData       	:= SDOdbc.SQLParamData;
  FSQLPrepare         	:= SDOdbc.SQLPrepare;
  FSQLPutData         	:= SDOdbc.SQLPutData;
  FSQLRowCount        	:= SDOdbc.SQLRowCount;
  FSQLSetConnectAttr  	:= SDOdbc.SQLSetConnectAttr;
  FSQLSetConnectOption	:= SDOdbc.SQLSetConnectOption;
  FSQLSetCursorName   	:= SDOdbc.SQLSetCursorName;
  FSQLSetDescField    	:= SDOdbc.SQLSetDescField;
  FSQLSetDescRec      	:= SDOdbc.SQLSetDescRec;
  FSQLSetEnvAttr      	:= SDOdbc.SQLSetEnvAttr;
  FSQLSetParam        	:= SDOdbc.SQLSetParam;
  FSQLSetStmtAttr     	:= SDOdbc.SQLSetStmtAttr;
  FSQLSetStmtOption   	:= SDOdbc.SQLSetStmtOption;
  FSQLSpecialColumns  	:= SDOdbc.SQLSpecialColumns;
  FSQLStatistics      	:= SDOdbc.SQLStatistics;
  FSQLTables          	:= SDOdbc.SQLTables;
  FSQLTransact        	:= SDOdbc.SQLTransact;

  FSQLBrowseConnect   	:= SDOdbc.SQLBrowseConnect;
  FSQLBulkOperations  	:= SDOdbc.SQLBulkOperations;
  FSQLColAttributes   	:= SDOdbc.SQLColAttributes;
  FSQLColumnPrivileges	:= SDOdbc.SQLColumnPrivileges;
  FSQLDescribeParam   	:= SDOdbc.SQLDescribeParam;
  FSQLExtendedFetch   	:= SDOdbc.SQLExtendedFetch;
  FSQLForeignKeys   	:= SDOdbc.SQLForeignKeys;
  FSQLMoreResults     	:= SDOdbc.SQLMoreResults;
  FSQLNativeSql       	:= SDOdbc.SQLNativeSql;
  FSQLNumParams       	:= SDOdbc.SQLNumParams;
  FSQLParamOptions    	:= SDOdbc.SQLParamOptions;
  FSQLPrimaryKeys     	:= SDOdbc.SQLPrimaryKeys;
  FSQLProcedureColumns	:= SDOdbc.SQLProcedureColumns;
  FSQLProcedures      	:= SDOdbc.SQLProcedures;
  FSQLSetPos   		:= SDOdbc.SQLSetPos;
  FSQLTablePrivileges 	:= SDOdbc.SQLTablePrivileges;
  FSQLDrivers  		:= SDOdbc.SQLDrivers;
  FSQLBindParameter   	:= SDOdbc.SQLBindParameter;
  FSQLDriverConnect   	:= SDOdbc.SQLDriverConnect;
{$ELSE}
  @FSQLAllocConnect    	:= GetProcAddress(ASqlLibModule, 'SQLAllocConnect');
  @FSQLAllocEnv        	:= GetProcAddress(ASqlLibModule, 'SQLAllocEnv');
  @FSQLAllocHandle     	:= GetProcAddress(ASqlLibModule, 'SQLAllocHandle');
  @FSQLAllocStmt       	:= GetProcAddress(ASqlLibModule, 'SQLAllocStmt');
  @FSQLBindCol         	:= GetProcAddress(ASqlLibModule, 'SQLBindCol');
  @FSQLCancel          	:= GetProcAddress(ASqlLibModule, 'SQLCancel');
  @FSQLCloseCursor     	:= GetProcAddress(ASqlLibModule, 'SQLCloseCursor');
  @FSQLColAttribute    	:= GetProcAddress(ASqlLibModule, 'SQLColAttribute');
  @FSQLColumns         	:= GetProcAddress(ASqlLibModule, 'SQLColumns');
  @FSQLConnect         	:= GetProcAddress(ASqlLibModule, 'SQLConnect');
  @FSQLCopyDesc        	:= GetProcAddress(ASqlLibModule, 'SQLCopyDesc');
  @FSQLDataSources     	:= GetProcAddress(ASqlLibModule, 'SQLDataSources');
  @FSQLDescribeCol     	:= GetProcAddress(ASqlLibModule, 'SQLDescribeCol');
  @FSQLDisconnect      	:= GetProcAddress(ASqlLibModule, 'SQLDisconnect');
  @FSQLEndTran         	:= GetProcAddress(ASqlLibModule, 'SQLEndTran');
  @FSQLError           	:= GetProcAddress(ASqlLibModule, 'SQLError');
  @FSQLExecDirect      	:= GetProcAddress(ASqlLibModule, 'SQLExecDirect');
  @FSQLExecute         	:= GetProcAddress(ASqlLibModule, 'SQLExecute');
  @FSQLFetch           	:= GetProcAddress(ASqlLibModule, 'SQLFetch');
  @FSQLFetchScroll     	:= GetProcAddress(ASqlLibModule, 'SQLFetchScroll');
  @FSQLFreeConnect     	:= GetProcAddress(ASqlLibModule, 'SQLFreeConnect');
  @FSQLFreeEnv         	:= GetProcAddress(ASqlLibModule, 'SQLFreeEnv');
  @FSQLFreeHandle      	:= GetProcAddress(ASqlLibModule, 'SQLFreeHandle');
  @FSQLFreeStmt        	:= GetProcAddress(ASqlLibModule, 'SQLFreeStmt');
  @FSQLGetConnectAttr  	:= GetProcAddress(ASqlLibModule, 'SQLGetConnectAttr');
  @FSQLGetConnectOption	:= GetProcAddress(ASqlLibModule, 'SQLGetConnectOption');
  @FSQLGetCursorName   	:= GetProcAddress(ASqlLibModule, 'SQLGetCursorName');
  @FSQLGetData         	:= GetProcAddress(ASqlLibModule, 'SQLGetData');
  @FSQLGetDescField    	:= GetProcAddress(ASqlLibModule, 'SQLGetDescField');
  @FSQLGetDescRec      	:= GetProcAddress(ASqlLibModule, 'SQLGetDescRec');
  @FSQLGetDiagField    	:= GetProcAddress(ASqlLibModule, 'SQLGetDiagField');
  @FSQLGetDiagRec      	:= GetProcAddress(ASqlLibModule, 'SQLGetDiagRec');
  @FSQLGetEnvAttr      	:= GetProcAddress(ASqlLibModule, 'SQLGetEnvAttr');
  @FSQLGetFunctions    	:= GetProcAddress(ASqlLibModule, 'SQLGetFunctions');
  @FSQLGetInfo         	:= GetProcAddress(ASqlLibModule, 'SQLGetInfo');
  @FSQLGetStmtAttr     	:= GetProcAddress(ASqlLibModule, 'SQLGetStmtAttr');
  @FSQLGetStmtOption   	:= GetProcAddress(ASqlLibModule, 'SQLGetStmtOption');
  @FSQLGetTypeInfo     	:= GetProcAddress(ASqlLibModule, 'SQLGetTypeInfo');
  @FSQLNumResultCols   	:= GetProcAddress(ASqlLibModule, 'SQLNumResultCols');
  @FSQLParamData       	:= GetProcAddress(ASqlLibModule, 'SQLParamData');
  @FSQLPrepare         	:= GetProcAddress(ASqlLibModule, 'SQLPrepare');
  @FSQLPutData         	:= GetProcAddress(ASqlLibModule, 'SQLPutData');
  @FSQLRowCount        	:= GetProcAddress(ASqlLibModule, 'SQLRowCount');
  @FSQLSetConnectAttr  	:= GetProcAddress(ASqlLibModule, 'SQLSetConnectAttr');
  @FSQLSetConnectOption	:= GetProcAddress(ASqlLibModule, 'SQLSetConnectOption');
  @FSQLSetCursorName   	:= GetProcAddress(ASqlLibModule, 'SQLSetCursorName');
  @FSQLSetDescField    	:= GetProcAddress(ASqlLibModule, 'SQLSetDescField');
  @FSQLSetDescRec      	:= GetProcAddress(ASqlLibModule, 'SQLSetDescRec');
  @FSQLSetEnvAttr      	:= GetProcAddress(ASqlLibModule, 'SQLSetEnvAttr');
  @FSQLSetParam        	:= GetProcAddress(ASqlLibModule, 'SQLSetParam');
  @FSQLSetStmtAttr     	:= GetProcAddress(ASqlLibModule, 'SQLSetStmtAttr');
  @FSQLSetStmtOption   	:= GetProcAddress(ASqlLibModule, 'SQLSetStmtOption');
  @FSQLSpecialColumns  	:= GetProcAddress(ASqlLibModule, 'SQLSpecialColumns');
  @FSQLStatistics      	:= GetProcAddress(ASqlLibModule, 'SQLStatistics');
  @FSQLTables          	:= GetProcAddress(ASqlLibModule, 'SQLTables');
  @FSQLTransact        	:= GetProcAddress(ASqlLibModule, 'SQLTransact');
		// Function definitions of APIs in both X/Open CLI and ODBC ((sqlcli1.h))
		// APIs defined only by Microsoft SQL Extensions (sqlext.h)
  @FSQLBrowseConnect   	:= GetProcAddress(ASqlLibModule, 'SQLBrowseConnect');
  @FSQLBulkOperations  	:= GetProcAddress(ASqlLibModule, 'SQLBulkOperations');
  @FSQLColAttributes   	:= GetProcAddress(ASqlLibModule, 'SQLColAttributes');
  @FSQLColumnPrivileges	:= GetProcAddress(ASqlLibModule, 'SQLColumnPrivileges');
  @FSQLDescribeParam   	:= GetProcAddress(ASqlLibModule, 'SQLDescribeParam');
  @FSQLExtendedFetch   	:= GetProcAddress(ASqlLibModule, 'SQLExtendedFetch');
  @FSQLForeignKeys   	:= GetProcAddress(ASqlLibModule, 'SQLForeignKeys');
  @FSQLMoreResults     	:= GetProcAddress(ASqlLibModule, 'SQLMoreResults');
  @FSQLNativeSql       	:= GetProcAddress(ASqlLibModule, 'SQLNativeSql');
  @FSQLNumParams       	:= GetProcAddress(ASqlLibModule, 'SQLNumParams');
  @FSQLParamOptions    	:= GetProcAddress(ASqlLibModule, 'SQLParamOptions');
  @FSQLPrimaryKeys     	:= GetProcAddress(ASqlLibModule, 'SQLPrimaryKeys');
  @FSQLProcedureColumns	:= GetProcAddress(ASqlLibModule, 'SQLProcedureColumns');
  @FSQLProcedures      	:= GetProcAddress(ASqlLibModule, 'SQLProcedures');
  @FSQLSetPos  		:= GetProcAddress(ASqlLibModule, 'SQLSetPos');
  @FSQLTablePrivileges 	:= GetProcAddress(ASqlLibModule, 'SQLTablePrivileges');
  @FSQLDrivers 		:= GetProcAddress(ASqlLibModule, 'SQLDrivers');
  @FSQLBindParameter   	:= GetProcAddress(ASqlLibModule, 'SQLBindParameter');
  @FSQLDriverConnect   	:= GetProcAddress(ASqlLibModule, 'SQLDriverConnect');
{$ENDIF}
end;

procedure TOdbcFunctions.ClearApiCalls;
begin
  FLibHandle := 0;
  
  @FSQLAllocConnect    	:= nil;
  @FSQLAllocEnv        	:= nil;
  @FSQLAllocHandle     	:= nil;
  @FSQLAllocStmt       	:= nil;
  @FSQLBindCol         	:= nil;
  @FSQLCancel          	:= nil;
  @FSQLCloseCursor     	:= nil;
  @FSQLColAttribute    	:= nil;
  @FSQLColumns         	:= nil;
  @FSQLConnect         	:= nil;
  @FSQLCopyDesc        	:= nil;
  @FSQLDataSources     	:= nil;
  @FSQLDescribeCol     	:= nil;
  @FSQLDisconnect      	:= nil;
  @FSQLEndTran         	:= nil;
  @FSQLError           	:= nil;
  @FSQLExecDirect      	:= nil;
  @FSQLExecute         	:= nil;
  @FSQLFetch           	:= nil;
  @FSQLFetchScroll     	:= nil;
  @FSQLFreeConnect     	:= nil;
  @FSQLFreeEnv         	:= nil;
  @FSQLFreeHandle      	:= nil;
  @FSQLFreeStmt        	:= nil;
  @FSQLGetConnectAttr  	:= nil;
  @FSQLGetConnectOption	:= nil;
  @FSQLGetCursorName   	:= nil;
  @FSQLGetData         	:= nil;
  @FSQLGetDescField    	:= nil;
  @FSQLGetDescRec      	:= nil;
  @FSQLGetDiagField    	:= nil;
  @FSQLGetDiagRec      	:= nil;
  @FSQLGetEnvAttr      	:= nil;
  @FSQLGetFunctions    	:= nil;
  @FSQLGetInfo         	:= nil;
  @FSQLGetStmtAttr     	:= nil;
  @FSQLGetStmtOption   	:= nil;
  @FSQLGetTypeInfo     	:= nil;
  @FSQLNumResultCols   	:= nil;
  @FSQLParamData       	:= nil;
  @FSQLPrepare         	:= nil;
  @FSQLPutData         	:= nil;
  @FSQLRowCount        	:= nil;
  @FSQLSetConnectAttr  	:= nil;
  @FSQLSetConnectOption	:= nil;
  @FSQLSetCursorName   	:= nil;
  @FSQLSetDescField    	:= nil;
  @FSQLSetDescRec      	:= nil;
  @FSQLSetEnvAttr      	:= nil;
  @FSQLSetParam        	:= nil;
  @FSQLSetStmtAttr     	:= nil;
  @FSQLSetStmtOption   	:= nil;
  @FSQLSpecialColumns  	:= nil;
  @FSQLStatistics      	:= nil;
  @FSQLTables          	:= nil;
  @FSQLTransact        	:= nil;
		// APIs defined only by Microsoft SQL Extensions (sqlext.h)
  @FSQLBrowseConnect   	:= nil;
  @FSQLBulkOperations  	:= nil;
  @FSQLColAttributes   	:= nil;
  @FSQLColumnPrivileges	:= nil;
  @FSQLDescribeParam   	:= nil;
  @FSQLExtendedFetch   	:= nil;
  @FSQLForeignKeys     	:= nil;
  @FSQLMoreResults     	:= nil;
  @FSQLNativeSql       	:= nil;
  @FSQLNumParams       	:= nil;
  @FSQLParamOptions    	:= nil;
  @FSQLPrimaryKeys     	:= nil;
  @FSQLProcedureColumns	:= nil;
  @FSQLProcedures      	:= nil;
  @FSQLSetPos          	:= nil;
  @FSQLTablePrivileges 	:= nil;
  @FSQLDrivers         	:= nil;
  @FSQLBindParameter   	:= nil;
  @FSQLDriverConnect   	:= nil;
end;

procedure LoadSqlLib;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      hSqlLibModule := HelperLoadLibrary( SqlApiDll );
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [ SqlApiDll ]);
      Inc(SqlLibRefCount);
      OdbCalls.SetApiCalls( hSqlLibModule );
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
      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDll ]);
      Dec(SqlLibRefCount);
      OdbCalls.ClearApiCalls;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{ ESDOdbcError }
constructor ESDOdbcError.CreateWithSqlState(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string);
begin
  inherited CreateDefPos(AErrorCode, ANativeError, AMsg);
  FSqlState	:= ASqlState;
end;

{ TICustomOdbcDatabase }
constructor TICustomOdbcDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle 	:= nil;
  FDriverOdbcVer:= 0;
  FDBMSVer 	:= '';
  FIsTransSupported	:= False;
  
  FCurSqlCmd	:= nil;
  FCalls	:= nil;
end;

destructor TICustomOdbcDatabase.Destroy;
begin
  FreeHandle;

  if AcquiredHandle then
    FreeSqlLib;

  inherited Destroy;
end;

function TICustomOdbcDatabase.GetCalls: TOdbcFunctions;
begin
  Result := FCalls;
end;

procedure TICustomOdbcDatabase.CheckHDBC(AHandle: SQLHDBC; Status: TSDEResult);
begin
  CheckHandle( SQL_HANDLE_DBC, SQLHANDLE(AHandle), Status );
end;

procedure TICustomOdbcDatabase.CheckHSTMT(AHandle: SQLHSTMT; Status: TSDEResult);
begin
  CheckHandle( SQL_HANDLE_STMT, SQLHANDLE(AHandle), Status );
end;

procedure TICustomOdbcDatabase.Check(Status: TSDEResult);
begin
  CheckHDBC( DbcHandle, Status );
end;

procedure TICustomOdbcDatabase.CheckHandle(AHandleType: SQLSMALLINT; AHandle: SQLHANDLE; AStatus: TSDEResult);
const
  MAXERRMSG = 1000;
  SQLSTATESIZE = 5;
var
  rcd: RETCODE;
  Msg, sqlstate: string;
  szMsg, szSqlState: TSDCharPtr;
  ErrCode: SQLINTEGER;
  MsgLen: SQLSMALLINT;
begin
  ResetIdleTimeOut;

  if (AStatus = SQL_SUCCESS) or
     (AStatus = SQL_NO_DATA)
  then
    Exit;

  ErrCode := -1;
  szMsg := SafeReallocMem( nil, MAXERRMSG + 1 );
  SafeInitMem( szMsg, MAXERRMSG + 1, 0 );
  szSqlState := SafeReallocMem( nil, SQLSTATESIZE + 1 );
  SafeInitMem( szSqlState, SQLSTATESIZE + 1, 0 );
  try
    if Calls.IsAvailFunc( 'SQLGetDiagRec' ) then
      rcd := Calls.SQLGetDiagRec( AHandleType, AHandle, 1, szSqlState, ErrCode, szMsg, MAXERRMSG, MsgLen )
    else begin
      if AHandleType = SQL_HANDLE_STMT then
        rcd := Calls.SQLError( EnvHandle, DbcHandle, AHandle, szSqlState, ErrCode, szMsg, MAXERRMSG, MsgLen )
      else
        rcd := Calls.SQLError( EnvHandle, AHandle, SQLHSTMT(SQL_NULL_HSTMT), szSqlState, ErrCode, szMsg, MAXERRMSG, MsgLen );
    end;
    Msg := HelperPtrToString( szMsg );
    sqlstate := HelperPtrToString( szSqlState );
  finally
    SafeReallocMem( szMsg, 0 );
    SafeReallocMem( szSqlState, 0 );
  end;
  
  if rcd = SQL_INVALID_HANDLE then begin
    Msg := '';
    case AHandleType of
      SQL_HANDLE_ENV: Msg := 'environment';
      SQL_HANDLE_DBC: Msg := 'database';
      SQL_HANDLE_STMT:Msg := 'statement';
    end;
    Msg := Format('Invalid %s handle in TICustomOdbcDatabase.CheckHandle', [Msg]);
    Msg := Format( SFatalError, [Msg] );
  end else if rcd = SQL_NO_DATA then
    Msg := Format( SFatalError, ['No diagnostic data in TICustomOdbcDatabase.CheckHandle'] );

  ResetBusyState;
  	// class values(first two chars) of SQLSTATE other than '01' and 'IM' indicate an error
        // exception can be generated even for SQL_SUCCESS_WITH_INFO, for example, in case of user-defined error in procedure (RAISEERROR in MSSQL)
  if (AStatus = SQL_SUCCESS_WITH_INFO) and
     (
       ((sqlstate[1] = '0') and (sqlstate[2] = '1')) or
       ((sqlstate[1] = 'I') and (sqlstate[2] = 'M'))
     )
  then
    Exit;

  RaiseSDEngineError( ErrCode, ErrCode, Msg, SqlState );
end;

function TICustomOdbcDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

function TICustomOdbcDatabase.GetEnvHandle: SQLHENV;
begin
  ASSERT( Assigned(FHandle), 'TICustomOdbcDatabase.GetEnvHandle' );
{$IFDEF SD_CLR}
  Result := TIOdbcConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOdbcConnInfo) ) ).hEnv;
{$ELSE}
  Result := TIOdbcConnInfo(FHandle^).hEnv;
{$ENDIF}
end;

function TICustomOdbcDatabase.GetDbcHandle: SQLHDBC;
begin
  ASSERT( Assigned(FHandle), 'TICustomOdbcDatabase.GetDbcHandle' );
{$IFDEF SD_CLR}
  Result := TIOdbcConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOdbcConnInfo) ) ).hDbc;
{$ELSE}
  Result := TIOdbcConnInfo(FHandle^).hDbc;
{$ENDIF}
end;

procedure TICustomOdbcDatabase.AllocHandle;
var
  rec: TIOdbcConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TIOdbcDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.ServerType := Ord( istODBC );
  rec.hEnv      := nil;
  rec.hDbc      := nil;

{$IFDEF SD_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIOdbcConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TICustomOdbcDatabase.FreeHandle;
begin
  if Assigned(FHandle) then
    FHandle := SafeReallocMem( FHandle, 0 );
end;

procedure TICustomOdbcDatabase.AllocOdbcHandles;
var
  rec: TIOdbcConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TICustomOdbcDatabase.AllocHandles' );

  AllocHandle;

{$IFDEF SD_CLR}
  rec := TIOdbcConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOdbcConnInfo) ) );
{$ELSE}
  rec := TIOdbcConnInfo(FHandle^);
{$ENDIF}
  OdbcAllocHandle( SQL_HANDLE_ENV, SQLHANDLE(SQL_NULL_HANDLE), rec.hEnv );
	// Declaring the application's ODBC version, it's necessary after environment handle allocating
  if Calls.IsAvailFunc( 'SQLSetEnvAttr' ) then
    Calls.SQLSetEnvAttr( rec.hEnv, SQL_ATTR_ODBC_VERSION, SQLPOINTER(SQL_OV_ODBC3), 0 );

  CheckHandle( SQL_HANDLE_ENV, rec.hEnv,
  	OdbcAllocHandle( SQL_HANDLE_DBC, SQLHANDLE(rec.hEnv), rec.hDbc )
  );

{$IFDEF SD_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIOdbcConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TICustomOdbcDatabase.FreeOdbcHandles;
var
  r: TIOdbcConnInfo;
begin
  if Assigned(FHandle) then begin
{$IFDEF SD_CLR}
    r := TIOdbcConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOdbcConnInfo) ) );
{$ELSE}
    r := TIOdbcConnInfo(FHandle^);
{$ENDIF}

    if Assigned( r.hDbc ) then
      OdbcFreeHandle( SQL_HANDLE_DBC, SQLHANDLE(r.hDbc) );
    r.hDbc := nil;

    if Assigned( r.hEnv ) then
      OdbcFreeHandle( SQL_HANDLE_ENV, SQLHANDLE(r.hEnv) );
    r.hEnv := nil;
{$IFDEF SD_CLR}
    Marshal.StructureToPtr( r, FHandle, False );
{$ELSE}
    TIOdbcConnInfo(FHandle^) := r;
{$ENDIF}
  end;
  FreeHandle;
end;

procedure TICustomOdbcDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF SD_CLR}
var
  r1, r2: TIOdbcConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;

{$IFDEF SD_CLR}
  r1 := TIOdbcConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOdbcConnInfo) ) );
  r2 := TIOdbcConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIOdbcConnInfo) ) );
  r1.hEnv := r2.hEnv;
  r1.hDbc := r2.hDbc;
  Marshal.StructureToPtr( r1, FHandle, False );
{$ELSE}
  TIOdbcConnInfo(FHandle^).hEnv	:= TIOdbcConnInfo(AHandle^).hEnv;
  TIOdbcConnInfo(FHandle^).hDbc	:= TIOdbcConnInfo(AHandle^).hDbc;
{$ENDIF}
end;

function TICustomOdbcDatabase.OdbcAllocHandle(fHandleType: SQLSMALLINT; hInput: SQLHANDLE; var hOutput: SQLHANDLE): SQLRETURN;
begin
  with Calls do begin
    if IsAvailFunc('SQLAllocHandle') then
      Result := FSQLAllocHandle(fHandleType, hInput, hOutput)
    else begin
      case fHandleType of
        SQL_HANDLE_ENV:	Result := FSQLAllocEnv(SQLHENV(hOutput));
        SQL_HANDLE_DBC:	Result := FSQLAllocConnect(hInput, SQLHDBC(hOutput));
        SQL_HANDLE_STMT:Result := FSQLAllocStmt(hInput, SQLHSTMT(hOutput));
      else
        Result := SQL_INVALID_HANDLE;
      end;
    end;
  end;
end;

function TICustomOdbcDatabase.OdbcFreeHandle(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE): SQLRETURN;
begin
  with Calls do begin
    if IsAvailFunc( 'SQLFreeHandle' ) then
      Result := FSQLFreeHandle(fHandleType, hHandle)
    else begin
      case fHandleType of
        SQL_HANDLE_ENV:	Result := FSQLFreeEnv(hHandle);
        SQL_HANDLE_DBC:	Result := FSQLFreeConnect(hHandle);
        SQL_HANDLE_STMT:Result := FSQLFreeStmt(hHandle, SQL_DROP);
      else
        Result := SQL_INVALID_HANDLE;
      end;
    end;
  end;
end;

function TICustomOdbcDatabase.OdbcGetInfoInt16(InfoType: Integer): SQLUSMALLINT;
var
  RetBytes: SQLSMALLINT;
  ptr: TSDValueBuffer;
begin
{$IFDEF SD_CLR}
  ptr := SafeReallocMem(nil, SizeOf(Result));
  try
{$ELSE}
  ptr := @Result;
{$ENDIF}
    RetBytes := 0;
    if Calls.SQLGetInfo( DbcHandle, InfoType, ptr, SizeOf(Result), RetBytes ) <> SQL_SUCCESS then
      HelperMemWriteInt16( ptr, 0, 0 );
{$IFDEF SD_CLR}
    Result := HelperMemReadInt16( ptr, 0 );
  finally
    SafeReallocMem(ptr, 0);
  end;
{$ENDIF}
end;

function TICustomOdbcDatabase.OdbcGetInfoInt32(InfoType: Integer): SQLUINTEGER;
var
  RetBytes: SQLSMALLINT;
  ptr: TSDValueBuffer;
begin
{$IFDEF SD_CLR}
  ptr := SafeReallocMem(nil, SizeOf(Result));
  try
{$ELSE}
  ptr := @Result;
{$ENDIF}
    RetBytes := 0;
    if Calls.SQLGetInfo( DbcHandle, InfoType, ptr, SizeOf(Result), RetBytes ) <> SQL_SUCCESS then
      HelperMemWriteInt32( ptr, 0, 0 );
{$IFDEF SD_CLR}
    Result := HelperMemReadInt32( ptr, 0 );
  finally
    SafeReallocMem(ptr, 0);
  end;
{$ENDIF}
end;

function TICustomOdbcDatabase.OdbcGetInfoString(InfoType: Integer): string;
const
  MaxLen = 512;
var
  szValue: TSDCharPtr;
  RetBytes: SQLSMALLINT;
begin
  RetBytes := 0;
  szValue := SafeReallocMem( nil, MaxLen );
  try
    SafeInitMem( szValue, MaxLen, 0 );
	// get parameter value
    Check( Calls.SQLGetInfo(DbcHandle, InfoType, szValue, MaxLen, RetBytes) );
    Result := HelperPtrToString( szValue );
  finally
    SafeReallocMem( szValue, 0 );
  end;
end;

function TICustomOdbcDatabase.OdbcGetConnectAttrInt32(hDbc: SQLHDBC; fOption: SQLINTEGER): SQLUINTEGER;
var
  fExists: SQLUSMALLINT;
  ptr: TSDValueBuffer;
begin
  with Calls do begin
    fExists := SQL_FALSE;
    if IsAvailFunc( 'SQLGetFunctions' ) then
      Check( FSQLGetFunctions(hDbc, SQL_API_SQLSETCONNECTATTR, fExists) );
    if (fExists = SQL_FALSE) and (DriverOdbcMajor > 2) then
      fExists := SQL_TRUE;

{$IFDEF SD_CLR}
    ptr := SafeReallocMem(nil, SizeOf(Result));
    SafeInitMem(ptr, SizeOf(Result), 0);
    try
{$ELSE}
    Result := 0;
    ptr := @Result;
{$ENDIF}
      if (fExists = SQL_TRUE) and IsAvailFunc( 'SQLGetConnectAttr' ) then
        FSQLGetConnectAttr(hDbc, fOption, ptr, SQL_IS_UINTEGER, nil)
      else
        FSQLGetConnectOption(hDbc, fOption, ptr);
{$IFDEF SD_CLR}
      Result := HelperMemReadInt32( ptr, 0 );
    finally
      SafeReallocMem(ptr, 0);
    end;
{$ENDIF}
  end;
end;

function TICustomOdbcDatabase.OdbcSetConnectAttr(hDbc: SQLHDBC; fOption: SQLINTEGER; pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN;
var
  fExists: SQLUSMALLINT;
begin
  with Calls do begin
    fExists := SQL_FALSE;
    if IsAvailFunc( 'SQLGetFunctions' ) then
      Check( FSQLGetFunctions(hDbc, SQL_API_SQLSETCONNECTATTR, fExists) );
    if (fExists = SQL_FALSE) and (DriverOdbcMajor > 2) then
      fExists := SQL_TRUE;

    if (fExists = SQL_TRUE) and IsAvailFunc( 'SQLSetConnectAttr' ) then
      Result := FSQLSetConnectAttr(hDbc, fOption, pvParam, fStrLen)
    else
      Result := FSQLSetConnectOption(hDbc, fOption, SQLUINTEGER(pvParam));
  end;
end;

function TICustomOdbcDatabase.OdbcSetStmtAttr(hStmt: SQLHSTMT; fOption: SQLINTEGER; pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN;
begin
  with Calls do begin
    if IsAvailFunc( 'SQLSetStmtAttr' ) then
      Result := FSQLSetStmtAttr(hStmt, fOption, pvParam, fStrLen)
    else
      Result := FSQLSetStmtOption(hStmt, fOption, SQLUINTEGER(pvParam));
  end;
end;

function TICustomOdbcDatabase.OdbcGetMaxCatalogNameLen: SQLUSMALLINT;
begin
  Result := OdbcGetInfoInt16( SQL_MAX_CATALOG_NAME_LEN );
end;

function TICustomOdbcDatabase.OdbcGetMaxSchemaNameLen: SQLUSMALLINT;
begin
  Result := OdbcGetInfoInt16( SQL_MAX_SCHEMA_NAME_LEN );
end;

function TICustomOdbcDatabase.OdbcGetMaxTableNameLen: SQLUSMALLINT;
begin
  Result := OdbcGetInfoInt16( SQL_MAX_TABLE_NAME_LEN );
end;

function TICustomOdbcDatabase.OdbcGetMaxFieldNameLen: SQLUSMALLINT;
begin
  Result := OdbcGetInfoInt16( SQL_MAX_COLUMN_NAME_LEN );
end;

function TICustomOdbcDatabase.OdbcGetMaxProcNameLen: SQLUSMALLINT;
begin
  Result := OdbcGetInfoInt16( SQL_MAX_PROCEDURE_NAME_LEN );
end;

function TICustomOdbcDatabase.OdbcTransact(fEndType: SQLSMALLINT): SQLRETURN;
begin
  with Calls do begin
    if IsAvailFunc( 'SQLEndTran' ) then
      Result := FSQLEndTran(SQL_HANDLE_DBC, DbcHandle, fEndType)
    else
      Result := FSQLTransact(EnvHandle, DbcHandle, fEndType)
  end;
end;

function TICustomOdbcDatabase.GetAutoIncSQL: string;
begin
  if FDBMSVer = '' then
    FDBMSVer := GetVersionString;
  if Pos('DB2', FDBMSVer) > 0 then
    Result := DB2_SelectAutoIncField
  else if Pos('Informix', FDBMSVer) > 0 then
    Result := Inf_SelectAutoIncField
  else if (Pos('Microsoft SQL Server', FDBMSVer) > 0) or
  	  (Pos('Anywhere', FDBMSVer) > 0) or
          (Pos('SQL Server', FDBMSVer) > 0)
  then
    Result := SS_SelectAutoIncField
  else if Pos('MySQL', FDBMSVer) > 0 then
    Result := MySql_SelectAutoIncField
  else
    Result := '';  
end;

function TICustomOdbcDatabase.GetDriverOdbcMajor: Word;
begin
  if FDriverOdbcVer <= 0 then
    FDriverOdbcVer := GetDriverODBCVersion;

  Result := HiWord( FDriverOdbcVer );
end;

function TICustomOdbcDatabase.GetDriverOdbcMinor: Word;
begin
  if FDriverOdbcVer <= 0 then
    FDriverOdbcVer := GetDriverODBCVersion;

  Result := LoWord( FDriverOdbcVer );
end;

function TICustomOdbcDatabase.GetDriverOdbcVersion: LongInt;
begin
	// get SQL_DRIVER_ODBC_VER parameter
  Result := VersionStringToDWORD( OdbcGetInfoString( SQL_DRIVER_ODBC_VER ) );
end;

function TICustomOdbcDatabase.GetClientVersion: LongInt;
begin
	// get SQL_DRIVER_VER parameter
  Result := VersionStringToDWORD( OdbcGetInfoString( SQL_DRIVER_VER ) );
end;

function TICustomOdbcDatabase.GetServerVersion: LongInt;
begin
	// get SQL_DBMS_VER parameter
  Result := VersionStringToDWORD( OdbcGetInfoString( SQL_DBMS_VER ) );
end;

function TICustomOdbcDatabase.GetVersionString: string;
var
  dwVer: DWORD;
begin
  dwVer := GetServerVersion;
	// get SQL_DBMS_NAME parameter
  Result := OdbcGetInfoString( SQL_DBMS_NAME );
  Result := Format('%s Release %d.%d', [Result, GetMajorVer(dwVer), GetMinorVer(dwVer)]);
end;

function TICustomOdbcDatabase.GetIsNeedLongDataLen: Boolean;
var
  s: string;
begin
	// get SQL_NEED_LONG_DATA_LEN parameter
  s := OdbcGetInfoString( SQL_NEED_LONG_DATA_LEN );
  Result := (Length(s) > 0) and (s[1] = 'Y');
end;

function TICustomOdbcDatabase.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  Result := False;
        // Note. Value of SQL_ATTR_CONNECTION_DEAD attribute does not show a correct state, when a server is down.
  cmd := GetSchemaInfo(stSysTables, 'X.DUMMY');
  if Assigned(cmd) then begin
    Result := True;
    cmd.Free;
  end;
end;

procedure TICustomOdbcDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
const
  MaxConnStrOut = 1024;
  function AddTagSep(const CStr: string): string;
  var
    i: Integer;
  begin
    Result := '';
    for i:=Length(CStr) downto 1 do
      if CStr[i] <> ' ' then begin
        if CStr[i] <> ';' then
          Result := ';';
        Break;
      end;
  end;
var
  LoginTimeout: Integer;
  szConnStrOut, szDb, szUser, szPwd: TSDCharPtr;
  ConnStrOut: SQLSMALLINT;
  ConnStr: string;
begin
  szConnStrOut := nil;
  try
    LoadSqlLib;
    AllocOdbcHandles;

	// set login timeout before connect
    if Trim( Params.Values[szLOGINTIMEOUT] ) <> '' then begin
      LoginTimeout := StrToIntDef( Trim( Params.Values[szLOGINTIMEOUT] ), 0 );
	// Sequence error on call OdbcSetConnectAttr now
      if Calls.IsAvailFunc( 'SQLSetConnectAttr' ) then
        Check( Calls.SQLSetConnectAttr(DbcHandle, SQL_ATTR_LOGIN_TIMEOUT, SQLPOINTER(LoginTimeout), 0) )
      else
        Check( Calls.SQLSetConnectOption(DbcHandle, SQL_ATTR_LOGIN_TIMEOUT, LoginTimeout) );
    end;

    	// if DSN string with options
    if Pos('=', sRemoteDatabase) > 0 then begin
      ConnStr := sRemoteDatabase;
        // if connection string does not contain username parameter
      if not CT_UserIDExists(ConnStr) and (sUserName <> '') then
        ConnStr := ConnStr + AddTagSep(ConnStr) + CT_USERID1 + sUserName;
        // if connection string does not contain password parameter
      if not CT_PasswordExists(ConnStr) and (sPassword <> '') then
        ConnStr := ConnStr + AddTagSep(ConnStr) + CT_PASSWORD1 + sPassword;
      ConnStrOut := 0;
      szConnStrOut := SafeReallocMem( nil, MaxConnStrOut+1 );
      SafeInitMem( szConnStrOut, MaxConnStrOut+1, 0 );
{$IFDEF SD_CLR}
      szDb := Marshal.StringToHGlobalAnsi( ConnStr );
{$ELSE}
      szDb := TSDCharPtr( ConnStr );
{$ENDIF}
      Check( Calls.SQLDriverConnect( DbcHandle, 0, szDb, SQL_NTS,
      			szConnStrOut, MaxConnStrOut, ConnStrOut, SQL_DRIVER_NOPROMPT )
      )
    end else begin	// if sRemoteDatabase contains one word, which is datasource name (from ODBC config)
{$IFDEF SD_CLR}
      szDb := Marshal.StringToHGlobalAnsi( sRemoteDatabase );
      szUser:=Marshal.StringToHGlobalAnsi( sUserName );
      szPwd:= Marshal.StringToHGlobalAnsi( sPassword );
{$ELSE}
      szDb := TSDCharPtr( sRemoteDatabase );
      szUser:=TSDCharPtr( sUserName );
      szPwd:= TSDCharPtr( sPassword );
{$ENDIF}
      Check( Calls.SQLConnect( DbcHandle, szDb, SQL_NTS, szUser, SQL_NTS, szPwd, SQL_NTS ) );
    end;

      	// get and save(in private field) ODBC version, which is supported by driver
    GetDriverOdbcMajor;

    SetDefaultOptions;
  finally
    if Assigned( szConnStrOut ) then
      SafeReallocMem( szConnStrOut, 0 );
{$IFDEF SD_CLR}
    if Assigned( szDb ) then
      Marshal.FreeHGlobal( szDb );
    if Assigned( szUser ) then
      Marshal.FreeHGlobal( szUser );
    if Assigned( szPwd ) then
      Marshal.FreeHGlobal( szPwd );
{$ENDIF}
  end;
end;

procedure TICustomOdbcDatabase.DoDisconnect(Force: Boolean);
begin
  if not Assigned(FHandle) then
    Exit;
	// commit in case of successful disconnect, else SQLDisconnect returns SQLSTATE=25000 sometimes(noted for DB2 v6.1)
  if FIsTransSupported then
    if InTransaction then
      OdbcTransact( SQL_ROLLBACK )
    else
      OdbcTransact( SQL_COMMIT );
  Calls.SQLDisconnect( DbcHandle );

  FreeOdbcHandles;
  FreeSqlLib;

  FDriverOdbcVer:= 0;
  FDBMSVer := '';
end;

procedure TICustomOdbcDatabase.ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll: Boolean);
var
  ds: TISqlCommand;
begin
  if Assigned(FCurSqlCmd) and (ASqlCmd <> FCurSqlCmd) then begin
    ds := FCurSqlCmd;
    FCurSqlCmd := nil;
    try
      if IsFetchAll then
        ds.SaveResults;
    except
      FCurSqlCmd := ds;
      raise;
    end;
  end;
  FCurSqlCmd := ASqlCmd;
end;

procedure TICustomOdbcDatabase.DoStartTransaction;
begin
  // nothing
end;

procedure TICustomOdbcDatabase.DoCommit;
begin
  Check( OdbcTransact( SQL_COMMIT ) );
end;

procedure TICustomOdbcDatabase.DoRollback;
begin
  Check( OdbcTransact( SQL_ROLLBACK ) );
end;

function TICustomOdbcDatabase.GetAutoCommitOption: Boolean;
var
  vParam: SQLUINTEGER;
begin
  Result := True;	// by default, autocommit is on
  if not FIsTransSupported then
    Exit;

  vParam := OdbcGetConnectAttrInt32( DbcHandle, SQL_ATTR_AUTOCOMMIT );

  if vParam = SQL_AUTOCOMMIT_OFF then
    Result := False;
end;

procedure TICustomOdbcDatabase.SetAutoCommitOption(Value: Boolean);
begin
  if not FIsTransSupported then
    Exit;

  if Value then
    Check( OdbcSetConnectAttr( DbcHandle, SQL_ATTR_AUTOCOMMIT , SQLPOINTER(SQL_AUTOCOMMIT_ON), 0 ) )
  else
    Check( OdbcSetConnectAttr( DbcHandle, SQL_ATTR_AUTOCOMMIT , SQLPOINTER(SQL_AUTOCOMMIT_OFF), 0 ) );
end;

procedure TICustomOdbcDatabase.SetDefaultOptions;
var
  sValue: string;
  iV: SQLUINTEGER;
  TxnProp, DescValue: SQLUSMALLINT;
begin
  with Calls do begin
    DescValue := OdbcGetInfoInt16( SQL_CURSOR_COMMIT_BEHAVIOR );
    FCursorPreservedOnCommit := DescValue = SQL_CB_PRESERVE;
    DescValue := OdbcGetInfoInt16( SQL_CURSOR_ROLLBACK_BEHAVIOR );
    FCursorPreservedOnRollback := DescValue = SQL_CB_PRESERVE;

    iV := OdbcGetInfoInt32( SQL_GETDATA_EXTENSIONS );
    FGetDataAnyColumn := (iV and SQL_GD_ANY_COLUMN) <> 0;
    	// SQL_BATCH_SUPPORT is supported for ODBC v.3
    if DriverOdbcMajor >= 3 then begin
      iV := OdbcGetInfoInt32( SQL_BATCH_SUPPORT );
      FProcSupportsCursors := (iV and SQL_BS_SELECT_PROC) <> 0;
    end;
	// set command timeout value, if it's set
    sValue := Trim( Params.Values[szCMDTIMEOUT] );
    if sValue <> '' then begin
      iV := StrToIntDef( sValue, 0 );
      	// Set timeout for a situation not associated with query execution or login
	// Exclude Check call, because the feature isn't supported for MS Access, for example
      OdbcSetConnectAttr( DbcHandle, SQL_ATTR_CONNECTION_TIMEOUT, SQLPOINTER( iV ), SQL_IS_UINTEGER );
    end;

    TxnProp := OdbcGetInfoInt16( SQL_TXN_CAPABLE );
    FIsTransSupported := TxnProp <> SQL_TC_NONE;
    	// if driver supports transactions
    if FIsTransSupported then begin
    	// process an autocommit option
      if not AutoCommitDef then
        SetAutoCommitOption( AutoCommit )
      else	// store an autocommit option from ODBC driver
        FAutoCommit := GetAutoCommitOption;

	// set default isolation level
      SetTransIsolation(TransIsolation);
    end;
  end;
end;

procedure TICustomOdbcDatabase.SetTransIsolation(Value: TISqlTransIsolation);
const
  IsolLevel: array[TISqlTransIsolation] of SQLINTEGER =
  	(SQL_TXN_READ_UNCOMMITTED,
         SQL_TXN_READ_COMMITTED,
         SQL_TXN_REPEATABLE_READ
        );
begin
  Check( OdbcSetConnectAttr( DbcHandle, SQL_ATTR_TXN_ISOLATION, SQLPOINTER(IsolLevel[Value]), 0 ) );
end;

function TICustomOdbcDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;

function TICustomOdbcDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
var
  cmd: TISqlCommand;
begin
  cmd := nil;
  case ASchemaType of
    stTables,
    stSysTables:
      begin
        cmd := TIOdbcCallTables.Create(Self);
        if AObjectName <> '' then
          TIOdbcCallTables(cmd).TableNames := AObjectName;
        if ASchemaType = stSysTables then
          TIOdbcCallTables(cmd).TableTypes := 'SYSTEM TABLE'
        else
          TIOdbcCallTables(cmd).TableTypes := 'TABLE,VIEW';
      end;
    stColumns:
      begin
        cmd := TIOdbcCallColumns.Create(Self);
        TIOdbcCallColumns(cmd).TableName := AObjectName;
      end;
    stIndexes:
      begin
        cmd := TIOdbcCallIndexes.Create(Self);
        TIOdbcCallIndexes(cmd).TableName := AObjectName;
      end;
    stProcedures:
      begin
        cmd := TIOdbcCallProcs.Create(Self);
        TIOdbcCallProcs(cmd).ProcNames := AObjectName;
      end;
    stProcedureParams:
      begin
        cmd := TIOdbcCallProcParams.Create(Self);
        TIOdbcCallProcParams(cmd).ProcName := AObjectName;
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

{ TICustomOdbcCommand }
constructor TICustomOdbcCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FHandle := nil;
  FNextResults := False;
  FInfoExecuted:= False;
  FExecDirect   := False;
  FNoMoreResult := False;
  FFirstCalcFieldIdx := 0;

  FIsSingleConn := SqlDatabase.IsSingleConn;
  FBlobPieceSize:= SqlDatabase.BlobPieceSize;
	// by default IsSrvCursor = False
  FIsSrvCursor  := UpperCase( Trim( SqlDatabase.Params.Values[szSERVERCURSOR] ) ) = STrueString;
  FMaxBlobSize  := StrToIntDef( Trim( SqlDatabase.Params.Values[szMAXBLOBSIZE] ), MaxInt );
{$IFDEF SD_VCL4}
  FPrefetchMode := False;
  FPrefetchRows := 1;
  FRowStatusValues := nil;
  FRowsFetchedPtr  := nil;  
{$ENDIF}
  FCurrRow := 0;
  FRowSize := 0;
end;

destructor TICustomOdbcCommand.Destroy;
begin
  Disconnect(False);

  inherited;
end;

function TICustomOdbcCommand.GetCalls: TOdbcFunctions;
begin
  Result := SqlDatabase.FCalls;
end;

function TICustomOdbcCommand.GetSqlDatabase: TICustomOdbcDatabase;
begin
  Result := (inherited SqlDatabase) as TICustomOdbcDatabase;
end;

function TICustomOdbcCommand.GetHandle: PSDCursor;
begin
  Result := FHandle;
end;

{ Marks a database handle as used by the current dataset }
procedure TICustomOdbcCommand.AcquireDBHandle;
begin
  if FIsSingleConn then
    SqlDatabase.ReleaseDBHandle(Self, True);
end;

{ Releases a database handle, which was used by the current dataset }
procedure TICustomOdbcCommand.ReleaseDBHandle;
begin
  if SqlDatabase.CurSqlCmd = Self then
    SqlDatabase.ReleaseDBHandle(nil, False);
end;

procedure TICustomOdbcCommand.Check(Status: TSDEResult);
begin
  SqlDatabase.CheckHSTMT( FHandle, Status );
end;

procedure TICustomOdbcCommand.Connect;
var
  sValue: string;
  V: SQLUINTEGER;
begin
  try
    Check(
    	SqlDatabase.OdbcAllocHandle( SQL_HANDLE_STMT, SQLHANDLE(SqlDatabase.DbcHandle), FHandle )
        );
    if IsSrvCursor then
      Check(
  	SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_CURSOR_TYPE,
        	SQLPOINTER( SQL_CURSOR_STATIC ), 0 )
      )
    else
      Check(
  	SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_CURSOR_TYPE,
        	SQLPOINTER( SQL_CURSOR_FORWARD_ONLY ), 0 )
        );

	// default value for SQL_ATTR_MAX_ROWS is zero: the driver returs all rows
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_MAX_ROWS, SQLPOINTER( 0 ), 0 ) );

	// set command timeout value, if it's set
    sValue := Trim( SqlDatabase.Params.Values[szCMDTIMEOUT] );
    if sValue <> '' then begin
      V := StrToIntDef( sValue, 0 );
      	// Set timeout to the number of seconds to wait for an SQL statement to execute before returning to the application
      SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER( V ), SQL_IS_UINTEGER );
    end;

  except
    if FHandle <> nil then
      SqlDatabase.OdbcFreeHandle( SQL_HANDLE_STMT, SQLHANDLE(FHandle) );
    FHandle := nil;

    raise;
  end;
end;

procedure TICustomOdbcCommand.Disconnect(Force: Boolean);
begin
  if FieldsBuffer <> nil then
    FreeFieldsBuffer;

  ReleaseDBHandle;

  if FHandle = nil then Exit;

  if FHandle <> nil then begin
    Calls.SQLFreeStmt( FHandle, SQL_CLOSE );
    SqlDatabase.OdbcFreeHandle( SQL_HANDLE_STMT, SQLHANDLE(FHandle) );
  end;
  FHandle := nil;
end;

procedure TICustomOdbcCommand.CloseResultSet;
begin
  FNoMoreResult := False;
  if FNextResults then begin
    ClearFieldDescs;
    Exit;
  end;
        // reset prefetch variables
  if FPrefetchMode then begin
    FCurrRow := 0;
    HelperMemWriteInt32(FRowsFetchedPtr, 0,0);
  end;

  if Assigned(FHandle) then
    Calls.SQLFreeStmt( FHandle, SQL_CLOSE );    // it's equal Calls.SQLCloseCursor( FHandle ) for ODBC v.3

	// it's need in case of close a result set without full fetch
  ReleaseDBHandle;
end;

procedure TICustomOdbcCommand.CheckPrepared;
begin
  if Assigned( FHandle ) then
    Exit;

  if NativeCommand <> '' then
    InternalPrepare(NativeCommand);
end;

//This function checks various scenarios,
//like not FInfoExecuted or a void resultset of MSSQL procedure (for example, ...begin select * into T from ..; select * from T; end)
function TICustomOdbcCommand.GetNumResultCols: SQLSMALLINT;
var
  rcd: Integer;
begin
  Check( Calls.SQLNumResultCols( Handle, Result ) );
  if (CommandType = ctStoredProc) or ((CommandType = ctQuery) and IsCallStmt) then begin
    while Result = 0 do begin
      if not FExecDirect and not FInfoExecuted and not FNextResults then begin
        BindParamsBuffer;
        rcd := Calls.SQLExecute( Handle ) ;
        FInfoExecuted := True;
        Check(rcd);
      end else begin
        rcd := Calls.SQLMoreResults( Handle );
        FNoMoreResult := rcd = SQL_NO_DATA_FOUND;
      end;
      if rcd = SQL_NO_DATA_FOUND then
        Break;
      Check( Calls.SQLNumResultCols( Handle, Result ) );
    end;
  end;
end;

function TICustomOdbcCommand.ResultSetExists: Boolean;
var
  ColNum: SQLSMALLINT;
begin
  if CommandType = ctQuery then begin
    AcquireDBHandle;
    CheckPrepared;

    ColNum := GetNumResultCols;
    Result := ColNum > 0;
  end else      // SQLNumResultCols will raise an error, when procedure parameters are not set
    Result := True;
end;

// Returns True if field type required converting from internal database format
function TICustomOdbcCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := IsDateTimeType( FieldType ) {$IFDEF SD_VCL5} or (FieldType = ftGuid) {$ENDIF};
end;

function TICustomOdbcCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
	// Standard SQL data types
    SQL_CHAR:		Result := ftString;
    SQL_NUMERIC,
    SQL_DECIMAL:	Result := ftFloat;
    SQL_INTEGER:	Result := ftInteger;
    SQL_SMALLINT:	Result := ftSmallInt;
    SQL_FLOAT,
    SQL_REAL,
    SQL_DOUBLE:		Result := ftFloat;
    SQL_VARCHAR:	Result := ftString;
	// One-parameter shortcuts for date/time data types
    SQL_TYPE_DATE:	Result := ftDate;
    SQL_TIME,
    SQL_TYPE_TIME:	Result := ftTime;
    SQL_DATETIME,
    SQL_TIMESTAMP,
    SQL_TYPE_TIMESTAMP:	Result := ftDateTime;
        // intervals
    SQL_INTERVAL_YEAR_TO_MONTH,
    SQL_INTERVAL_DAY_TO_HOUR,
    SQL_INTERVAL_DAY_TO_MINUTE,
    SQL_INTERVAL_DAY_TO_SECOND,
    SQL_INTERVAL_HOUR_TO_MINUTE,
    SQL_INTERVAL_HOUR_TO_SECOND,
    SQL_INTERVAL_MINUTE_TO_SECOND:
                        Result := ftBCD;
	// SQL extended data types
    SQL_BIGINT: 	Result := {$IFDEF SD_VCL4} ftLargeInt {$ELSE} ftInteger {$ENDIF};
    SQL_TINYINT:	Result := ftSmallInt;
    SQL_BIT:		Result := ftBoolean;
    SQL_BINARY:		Result := ftBytes;
    SQL_VARBINARY:	Result := ftVarBytes;
    SQL_LONGVARBINARY:	Result := ftBlob;
    SQL_LONGVARCHAR:	Result := ftMemo;
    	// unicode data types
    SQL_WCHAR,
    SQL_WVARCHAR:	Result := ftString;
    SQL_WLONGVARCHAR:	Result := ftMemo;
{$IFDEF SD_VCL5}
    SQL_GUID:           Result := ftGuid;
{$ENDIF}
  else
    Result := ftUnknown;
  end;
end;

function TICustomOdbcCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  { Converting from TFieldType to Program Data Type(ODBC) }
  OdbcDataSizeMap: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, 	ftWord, 	ftBoolean
	0, SizeOf(SQLSMALLINT), SizeOf(SQLINTEGER), SizeOf(SQLINTEGER), SizeOf(SQLSMALLINT),
	// ftFloat, 	ftCurrency, 		ftBCD, ftDate,	ftTime
        SizeOf(SQLDOUBLE), SizeOf(SQLDOUBLE),	0, 	0, 	0,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        0, 		0, 	0, 	SizeOf(SQLINTEGER), 0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,	0,	0,   	0,	0,
        // ftTypedBinary, ftCursor
        0, 	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	SizeOf(TInt64),
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	SizeOfGuidBinary
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
	// Delphi 8 do not support: const A = SizeOf( structure );
  case FieldType of
    ftDate: 	Result := SizeOf(TSQL_DATE_STRUCT);
    ftTime: 	Result := SizeOf(TSQL_TIME_STRUCT);
    ftDateTime:	Result := SizeOf(TSQL_TIMESTAMP_STRUCT);
  else
    Result := OdbcDataSizeMap[FieldType];
  end;
end;

{ ftString is returned as SQL_C_CHAR, which is space padded. }
function TICustomOdbcCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to C(Program) Data Type(ODBC) }
  OdbcDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean (TBooleanField.GetDataSize = 2)
	SQL_C_CHAR, SQL_C_SHORT, SQL_C_LONG, SQL_C_LONG, SQL_C_SHORT,
	// ftFloat, ftCurrency,   ftBCD, 	ftDate, 	ftTime
        SQL_C_DOUBLE, SQL_C_DOUBLE, 0, SQL_C_TYPE_DATE, SQL_C_TYPE_TIME,
        // ftDateTime, 		ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SQL_C_TYPE_TIMESTAMP, SQL_C_BINARY, SQL_C_BINARY, SQL_C_LONG, SQL_C_BINARY,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SQL_C_CHAR, SQL_C_BINARY, SQL_C_CHAR,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	SQL_C_SBIGINT,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	SQL_C_GUID
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  Result := OdbcDataTypeMap[FieldType];
  if SqlDatabase.DriverOdbcMajor < 3 then
    case FieldType of
      ftDate:		Result := SQL_C_DATE;
      ftTime:		Result := SQL_C_TIME;
      ftDateTime:	Result := SQL_C_TIMESTAMP;
    end;
end;

// It's used in SQLBindParameter
function TICustomOdbcCommand.SqlDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to SQL Data Type(ODBC) }
  OdbcSqlDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	SQL_VARCHAR, SQL_SMALLINT, SQL_INTEGER, SQL_INTEGER, SQL_SMALLINT,
	// ftFloat, ftCurrency, ftBCD, 	ftDate, 	ftTime
        SQL_DOUBLE, SQL_DOUBLE, 0, SQL_TYPE_DATE, SQL_TYPE_TIME,
        // ftDateTime, 		ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SQL_TYPE_TIMESTAMP, SQL_BINARY, SQL_VARBINARY, SQL_INTEGER, SQL_LONGVARBINARY,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SQL_LONGVARCHAR, SQL_LONGVARBINARY, SQL_LONGVARCHAR, 	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	SQL_BIGINT,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	SQL_GUID
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  Result := OdbcSqlDataTypeMap[FieldType];
  if SqlDatabase.DriverOdbcMajor < 3 then
    case FieldType of
      ftDate:		Result := SQL_DATE;
      ftTime:		Result := SQL_TIME;
      ftDateTime:	Result := SQL_TIMESTAMP;
    end;
end;

function TICustomOdbcCommand.IsInterval(FieldDesc: TSDFieldDesc): Boolean;
begin
        // For info, Informix OLEDB provider returns interval data as TBCDField.
        //TBCDField has up 4 digits after decimal point. However fraction of seconds could be more then 4 digits (up 6 for Informix).
        //TFloatField can not display numbers, like xxxx*10^8 (up 12 significant digits before decimal place and 6 decimal places).
  Result := (FieldDesc.FieldType = ftBCD) and IsIntervalType(FieldDesc.DataType);
end;

function TICustomOdbcCommand.IsIntervalType(ExtDataType: Integer): Boolean;
var
  dt: Integer;
begin
  dt := Abs(ExtDataType);
  Result :=
        (dt = SQL_TIMEDATE_DIFF_INTERVALS) or
        ((dt >= SQL_INTERVAL_YEAR) and (dt <= SQL_INTERVAL_MINUTE_TO_SECOND));
end;

{ Pseudo-Blob field has ftBlob/ftMemo fieldtype, however actually
it's ftString/ftByte with size more then MAXFIELDSTRINGSIZE (that's checked GetFieldDescs) }
function TICustomOdbcCommand.IsPseudoBlob(FieldDesc: TSDFieldDesc): Boolean;
begin
  Result := IsBlobType(FieldDesc.FieldType) and
        not IsBlobType(FieldDataType(FieldDesc.DataType));
end;

function TICustomOdbcCommand.OdbcGetColAttrInt32(hStmt: SQLHSTMT; iCol, AttrType: SQLUSMALLINT): SQLUINTEGER;
var
  ptr: TSDValueBuffer;
begin
  Result := 0;
  if Calls.IsAvailFunc( 'SQLColAttribute' ) then begin
{$IFDEF SD_CLR}
    ptr := SafeReallocMem( nil, SizeOf(Result) );
    try
{$ELSE}
    ptr := @Result;
{$ENDIF}
      Check( Calls.SQLColAttribute(hStmt, iCol, AttrType, nil, 0, nil, ptr) );
{$IFDEF SD_CLR}
      Result := HelperMemReadInt32( ptr, 0 );
    finally
      SafeReallocMem( ptr, 0 );
    end;
{$ENDIF}
  end;
end;

procedure TICustomOdbcCommand.GetFieldDescs(Descs: TSDFieldDescList);
const
  MaxColName	= 255;
var
  FieldDesc: TSDFieldDesc;
  ft: TFieldType;
  Col, NumCols: SQLSMALLINT;
  szColName: TSDCharPtr;
  ColNameLen, ColType, ColScale, ColNullable: SQLSMALLINT;
  ColSize: SQLUINTEGER;
  ColAutoInc: SQLINTEGER;
begin
  if FNoMoreResult then
    Exit;
  NumCols := 0;
  CheckPrepared;
	// at least, MSSQL ODBC driver requires to set parameters and SQLExecute before SQLNumResultCols
        //to process correctly some result sets of a procedure
    	// MS SQLServer returns a valid value of NumCols only after execution of a query with a parameter like
        //'select (select COUNT(*) from TABLE where F = :p) from TABLE'
  if (CommandType = ctStoredProc) and not FNextResults and not FExecDirect then
    InternalSpExecute(True);
	// it raises error after prepare and before executing a procedure
  Check( Calls.SQLNumResultCols( Handle, NumCols ) );
  if NumCols = 0 then begin
    if (CommandType = ctQuery) and (IsCallStmt or (LocateText('select', CommandText) = 1)) then
      InternalQExecute(True);
    NumCols := GetNumResultCols;
  end;

  if NumCols = 0 then
    Exit;
  szColName := SafeReallocMem( nil, MaxColName );
  try
    for Col:=1 to NumCols do begin

      Check( Calls.SQLDescribeCol( Handle, Col, szColName, MaxColName, ColNameLen,
    		ColType, ColSize, ColScale, ColNullable )
      );
      HelperMemWriteByte( szColName, ColNameLen, 0 );

      ft := FieldDataType(ColType);
      if ft = ftUnknown then
        DatabaseErrorFmt( SBadFieldType, [szColName] );
      	// check autoincrement property for a number column with precision 0
      if IsNumericType(ft) then begin
        ColAutoInc := OdbcGetColAttrInt32( Handle, Col, SQL_DESC_AUTO_UNIQUE_VALUE );
        if ColAutoInc = SQL_TRUE then
          ft := ftAutoInc;
      end;
	// include space for null termination byte for character data
      if ft = ftString then
        Inc(ColSize);
	// That's applied for a column with size more then 255 (for example: char(30000) or varbinary(10000))
        // DWORD is applied to prevent a compiler warning. ColSize includes a space null-terminator
      if (ft = ftString) and (ColSize > DWORD(SqlDatabase.MaxStringSize+1)) then
        ft := ftMemo;
      if (ft in [ftBytes, ftVarBytes]) and (ColSize > DWORD(SqlDatabase.MaxStringSize+1)) then
        ft := ftBlob;

      FieldDesc := Descs.AddFieldDesc;
      with FieldDesc do begin
        FieldName	:= HelperPtrToString( szColName );
        FieldNo		:= Col;
        FieldType	:= ft;
        DataType	:= ColType;
       	// it's necessary to save ColSize for varying string/byte and pseudo-blob fields
        if IsRequiredSizeTypes( ft ) or IsPseudoBlob( FieldDesc )
        then DataSize	:= ColSize
        else DataSize	:= NativeDataSize(FieldType);	// for SQL_INTEGER ColSize = 10 (instead of 4) (for MSSQL ODBC driver)
        Precision	:= ColScale;
    	// if NullOk = 0 then null values are not permitted for the column (Required = True)
        Required	:= ColNullable = SQL_NO_NULLS;
      end;
      if IsInterval(FieldDesc) then
        FieldDesc.DataSize := SizeOf(TSQL_INTERVAL_DS_STRUCT);  // max size of TSQL_INTERVAL_YM/DS_STRUCT
    end;
    FFirstCalcFieldIdx := Descs.Count;
  finally
    SafeReallocMem( szColName, 0 );
  end;
end;

function TICustomOdbcCommand.GetFieldsBufferSize: Integer;
var
{$IFDEF SD_VCL4}
  nPrefetchRows, nBufSize,
{$ENDIF}
  nRowSize: Integer;
begin
  nRowSize := inherited GetFieldsBufferSize;
{$IFDEF SD_VCL4}
  if (BlobFieldCount = 0) and (SqlDatabase.PrefetchRows > 1) then begin
    nPrefetchRows := SqlDatabase.PrefetchRows;
    nBufSize := nPrefetchRows * nRowSize;
    FCurrRow := 0;
    FRowStatusValues := SafeReallocMem( nil, nPrefetchRows * SizeOf(SQLUSMALLINT) );
    FRowsFetchedPtr  := SafeReallocMem( nil, SizeOf(SQLUINTEGER));
    SafeInitMem( FRowsFetchedPtr, SizeOf(SQLUINTEGER), 0 );    
   	// set row-wise binding
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROW_BIND_TYPE, SQLPointer(nRowSize), 0) );
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROW_ARRAY_SIZE, SQLPointer(nPrefetchRows), 0) );
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROW_STATUS_PTR, FRowStatusValues, 0) );
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROWS_FETCHED_PTR, FRowsFetchedPtr, 0) );

    FPrefetchRows := nPrefetchRows;
    FRowSize := nRowSize;
    FPrefetchMode := True;

    Result := nBufSize;
  end else
{$ENDIF}
    Result := nRowSize;
    	// DWORD alignment for buffer
  Result := (Result + 3) and $FFFFFFFC;
end;

function TICustomOdbcCommand.GetFieldsBuffer: TSDRecordBuffer;
begin
  Result := inherited GetFieldsBuffer;
  if Assigned(Result) then
    Result := IncPtr( Result, FCurrRow * FRowSize );
end;

procedure TICustomOdbcCommand.FreeFieldsBuffer;
begin
	// unbound all columns. It's important, when more than one result set returned by the current command
  Check( Calls.SQLFreeStmt( FHandle, SQL_UNBIND ) );
  FCurrRow := 0;
  FRowSize := 0;
{$IFDEF SD_VCL4}
	// reset values of attributes, which was used for multi-row fetching
  if FPrefetchRows > 1 then begin
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROW_BIND_TYPE, SQLPointer(SQL_BIND_TYPE_DEFAULT), 0) );
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROW_ARRAY_SIZE, SQLPointer(1), 0) );
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROW_STATUS_PTR, nil, 0) );
    Check( SqlDatabase.OdbcSetStmtAttr( FHandle, SQL_ATTR_ROWS_FETCHED_PTR, nil, 0) );
  end;
  FPrefetchMode := False;
  FPrefetchRows := 1;
  FRowsFetchedPtr  := SafeReallocMem( FRowsFetchedPtr, 0 );  
  FRowStatusValues := SafeReallocMem( FRowStatusValues, 0 );
{$ENDIF}
  inherited FreeFieldsBuffer;
end;

{ Setting buffers for data, which selected from database }
procedure TICustomOdbcCommand.SetFieldsBuffer;
var
  i, nOffset: Integer;
  BindDataSize: SQLINTEGER;
  BindDataType: SQLSMALLINT;
  BindDataBuffer: TSDCharPtr;
begin
  nOffset := 0;		// pointer to the TSDFieldInfo

  for i:=0 to FieldDescs.Count-1 do begin
    if FieldDescs[i].FieldNo <= 0 then
      Continue;
      	// it's necessary to bind pseudo-blob fields too
    if IsPseudoBlob(FieldDescs[i]) then
      BindDataType := NativeDataType( FieldDataType( FieldDescs[i].DataType ) )
    else
      BindDataType := NativeDataType( FieldDescs[i].FieldType );
    if IsInterval( FieldDescs[i] ) then
      BindDataType := FieldDescs[i].DataType;   // SQL_INTERVAL_xxx;
    if BindDataType = 0 then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );
	// .DataSize could be 0 for blob (not pseudo-blob) fields only
    BindDataSize := FieldDescs[i].DataSize;
    BindDataBuffer := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );

    if i < FFirstCalcFieldIdx then begin
      if not IsBlobType(FieldDescs[i].FieldType) or IsPseudoBlob(FieldDescs[i]) then
        Check( Calls.SQLBindCol( Handle, FieldDescs[i].FieldNo, BindDataType,
      		SQLPOINTER(BindDataBuffer), BindDataSize,
              	IncPtr( BindDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff ) )    // @TSDFieldInfo.DataSize
        )
      else
        // bind blob to nil; it is required for SProc that returns multiple result sets (ASA5)
        Check( Calls.SQLBindCol( Handle, FieldDescs[i].FieldNo, BindDataType,
                nil, 0,
                IncPtr( BindDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff ) )   // @TSDFieldInfo.DataSize
        );
    end;
    Inc(nOffset, SizeOf(TSDFieldInfo) + BindDataSize);
  end;
end;

procedure TICustomOdbcCommand.InternalPrepare(AStmt: string);
var
  szCmd: TSDCharPtr;
begin
  if not IsExecDirect then begin
    AcquireDBHandle;
{$IFDEF SD_CLR}
    szCmd := Marshal.StringToHGlobalAnsi( AStmt );
{$ELSE}
    szCmd := PChar( AStmt );
{$ENDIF}
    try
      Check( Calls.SQLPrepare( FHandle, szCmd, SQL_NTS ) );
    finally
{$IFDEF SD_CLR}
      Marshal.FreeHGlobal( szCmd );
{$ENDIF}
    end;
  end;
end;

function TICustomOdbcCommand.CreateCommandText(Value: string): string;
begin
  if CommandType = ctStoredProc then begin
    if Assigned(Params) and (Params.Count = 0) then
      InitParamList;

    Result := CreateProcedureCallCommand( Value, Params,
                Pos('Microsoft SQL Server', SqlDatabase.GetVersionString) = 0 );
  end else	// ctQuery
    Result := ReplaceParamMarkers( Value, Params );
end;

procedure TICustomOdbcCommand.DoPrepare(Value: string);
var
  sStmt: string;
begin
  if FHandle = nil then Connect;

  sStmt := CreateCommandText(Value);

  InternalPrepare(sStmt);
  SetNativeCommand(sStmt);
	// it's required after parameter's setting
  if CommandType <> ctStoredProc then
    InitFieldDescs;
end;

procedure TICustomOdbcCommand.DoExecDirect(Value: string);
var
  sStmt: string;
begin
  AcquireDBHandle;
  if FHandle = nil then Connect;

  sStmt := CreateCommandText(Value);

  AllocParamsBuffer;
  BindParamsBuffer;

  SetNativeCommand(sStmt);

  FExecDirect := True;
  try
    if CommandType = ctQuery then
      InternalQExecute(False)
    else
      SpExecute;

    if FieldDescs.Count = 0 then
      InitFieldDescs;
  finally
    FExecDirect := False;
  end;
end;

procedure TICustomOdbcCommand.DoExecute;
begin
  AcquireDBHandle;
  CheckPrepared;

  if CommandType = ctQuery then
    InternalQExecute(False)
  else if CommandType = ctStoredProc then
    SpExecute
  else
    Check( Calls.SQLExecute( Handle ) );
end;

function TICustomOdbcCommand.FetchNextRow: Boolean;
var
  rcd: SQLRETURN;
begin
  Result := False;
  SqlDatabase.ResetIdleTimeOut;
        // to avoid an error, when TDataSet.Open is called and the statement do not return result set
  if FieldDescs.Count = 0 then
    Exit;
{$IFDEF SD_VCL4}
  if FPrefetchMode then begin
    while (FCurrRow + 1) < HelperMemReadInt32(FRowsFetchedPtr, 0) do begin
      Inc(FCurrRow);
      rcd := HelperMemReadInt16( FRowStatusValues, FCurrRow );  // = FRowStatusValues[FCurrRow]
      if (rcd = SQL_ROW_SUCCESS) or (rcd = SQL_ROW_SUCCESS_WITH_INFO) or (rcd = SQL_ROW_NOROW) then begin
        Result := rcd <> SQL_ROW_NOROW;
        Break;
      end;
    end;

    if not Result and ((FCurrRow + 1) >= HelperMemReadInt32(FRowsFetchedPtr, 0)) then begin
      rcd := Calls.SQLFetch( Handle );
      FCurrRow := 0;
      if (rcd = SQL_SUCCESS) or (rcd = SQL_SUCCESS_WITH_INFO) or (rcd = SQL_NO_DATA_FOUND) then
        Result := rcd <> SQL_NO_DATA_FOUND
      else
        Check( rcd );
    end;
  end else begin
{$ENDIF}
    rcd := Calls.SQLFetch( Handle );

    if (rcd = SQL_SUCCESS) or (rcd = SQL_SUCCESS_WITH_INFO) or (rcd = SQL_NO_DATA_FOUND) then
      Result := rcd <> SQL_NO_DATA_FOUND
    else
      Check( rcd );
{$IFDEF SD_VCL4}
  end;
{$ENDIF}

  if Result then begin
    if BlobFieldCount > 0 then
      FetchBlobFields;
  end else
    ReleaseDBHandle;
end;

function TICustomOdbcCommand.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  ptr: TSDPtr;
  t: TSQL_TIME_STRUCT;
  d: TSQL_DATE_STRUCT;
  ts:TSQL_TIMESTAMP_STRUCT;
begin
  Result := 0;

  if NativeDataSize(ADataType) > BufSize then
    DatabaseError(SInsufficientIDateTimeBufSize);
	// it's necessary for ftDate
  Hour	:= 0;
  Min	:= 0;
  Sec	:= 0;

  if ADataType in [ftTime, ftDateTime] then
    DecodeTime(Value, Hour, Min, Sec, MSec);
  if ADataType in [ftDate, ftDateTime] then
    DecodeDate(Value, Year, Month, Day);

  ptr := Buffer;
  case ADataType of
    ftTime:
      begin
      	t.hour	:= Hour;
        t.minute:= Min;
        t.second:= Sec;
{$IFDEF SD_CLR}
        Marshal.StructureToPtr( t, ptr, False );
{$ELSE}
        TSQL_TIME_STRUCT(ptr^)	:= t;
{$ENDIF}
        Result := SizeOf(TSQL_TIME_STRUCT);
      end;
    ftDate:
      begin
        d.year	:= Year;
        d.month	:= Month;
        d.day	:= Day;
{$IFDEF SD_CLR}
        Marshal.StructureToPtr( d, ptr, False );
{$ELSE}
        TSQL_DATE_STRUCT(ptr^)	:= d;
{$ENDIF}
        Result := SizeOf(TSQL_DATE_STRUCT);
      end;
    ftDateTime:
      begin
        ts.hour		:= Hour;
        ts.minute	:= Min;
        ts.second	:= Sec;
        ts.fraction	:= MSec*1000*1000;
        ts.year		:= Year;
        ts.month	:= Month;
        ts.day		:= Day;
{$IFDEF SD_CLR}
        Marshal.StructureToPtr( ts, ptr, False );
{$ELSE}
        TSQL_TIMESTAMP_STRUCT(ptr^) := ts;
{$ENDIF}
        Result := SizeOf(TSQL_TIMESTAMP_STRUCT);
      end
  end;
end;

function TICustomOdbcCommand.CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDValueBuffer; BufSize: Integer): TDateTimeRec;
var
  dtDate, dtTime: TDateTime;
  t: TSQL_TIME_STRUCT;
  d: TSQL_DATE_STRUCT;
  ts:TSQL_TIMESTAMP_STRUCT;
begin
  case ADataType of
    ftTime:
      begin
{$IFDEF SD_CLR}
        t := TSQL_TIME_STRUCT( Marshal.PtrToStructure( Buffer, TypeOf(TSQL_TIME_STRUCT) ) );
{$ELSE}
        t := TSQL_TIME_STRUCT( Pointer(Buffer)^ );
{$ENDIF}
        dtTime := EncodeTime( t.hour, t.minute, t.second, 0 );
        Result.Time := DateTimeToTimeStamp(dtTime).Time;
      end;
    ftDate:
      begin
{$IFDEF SD_CLR}
        d := TSQL_DATE_STRUCT( Marshal.PtrToStructure( Buffer, TypeOf(TSQL_DATE_STRUCT) ) );
{$ELSE}
        d := TSQL_DATE_STRUCT( Pointer(Buffer)^ );
{$ENDIF}
        dtDate := EncodeDate( d.year, d.month, d.day );
        Result.Date := DateTimeToTimeStamp(dtDate).Date;
      end;
    ftDateTime:
      begin
{$IFDEF SD_CLR}
        ts := TSQL_TIMESTAMP_STRUCT( Marshal.PtrToStructure( Buffer, TypeOf(TSQL_TIMESTAMP_STRUCT) ) );
{$ELSE}
        ts := TSQL_TIMESTAMP_STRUCT( Pointer(Buffer)^ );
{$ENDIF}
        dtTime := EncodeTime( ts.hour, ts.minute, ts.second, 0 );
    	dtDate := EncodeDate( ts.year, ts.month, ts.day );
        Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) ) +
        			ts.fraction div 1000000;	// plus milliseconds
      end
  else
    Result.DateTime := 0.0;
  end;
end;

{  Converts data from database to application format, which is used by Delphi.
InBuf - pointer to TSDFieldInfo, which is preceded a data buffer;
Buffer - where the converted data is placed (w/o TSDFieldInfo structure);
Result - is equal True, if data is NOT NULL.
  BufSize is not used for all datatypes now. }
function TICustomOdbcCommand.CnvtDBData(ExtDataType: Integer; ADataType: TFieldType; InBuf, Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InData, OutData: TSDValueBuffer;
  dtDateTime: TDateTimeRec;
  nSize: Integer;
  FieldInfo: TSDFieldInfo;
  int_ym: TSQL_INTERVAL_YM_STRUCT;
  int_ds: TSQL_INTERVAL_DS_STRUCT;
  Curr: Currency;
begin
  FieldInfo := GetFieldInfoStruct(InBuf, 0);
  nSize := FieldInfo.DataSize;
  Result := nSize <> SQL_NULL_DATA;

  if not Result then
    Exit;

  InData	:= IncPtr( InBuf, SizeOf(TSDFieldInfo) );
  OutData	:= Buffer;
  	// DateTime fields
  if RequiredCnvtFieldType(ADataType) then begin
    if IsDateTimeType(ADataType) then begin
      Result := nSize > 0;	// DataSize = 0, when datetime parameter is NULL
      if Result then begin
        dtDateTime := CnvtDBDateTime2DateTimeRec(ADataType, InData, FieldInfo.DataSize);
        HelperMemWriteDateTimeRec(OutData, 0, dtDateTime);	// buffer size is SizeOf(TDateTimeRec)
      end;
{$IFDEF SD_VCL5}
    end else if ADataType = ftGuid then begin
        // GUID in binary format requires 16 bytes, in string format - 38 bytes
      GuidToCharBuffer(InData, FieldInfo.DataSize, OutData, BufSize);
{$ENDIF}      
    end else
      ASSERT( False, SFieldTypeNotConverted + FieldTypeNames[ADataType] );
  end else if (ADataType = ftBCD) and IsIntervalType(ExtDataType) then begin
    if ExtDataType = SQL_INTERVAL_YEAR_TO_MONTH then begin
{$IFDEF SD_CLR}
      int_ym := TSQL_INTERVAL_YM_STRUCT( Marshal.PtrToStructure(InData, TypeOf(TSQL_INTERVAL_YM_STRUCT)) );
{$ELSE}
      int_ym := TSQL_INTERVAL_YM_STRUCT( TSDPtr(InData)^ );
{$ENDIF}
      Curr := (int_ym.year_month.month + int_ym.year_month.year * 100);
      Curr := Curr * 100000000;
    end else begin
{$IFDEF SD_CLR}
      int_ds := TSQL_INTERVAL_DS_STRUCT( Marshal.PtrToStructure(InData, TypeOf(TSQL_INTERVAL_DS_STRUCT)) );
{$ELSE}
      int_ds := TSQL_INTERVAL_DS_STRUCT( TSDPtr(InData)^ );
{$ENDIF}
      Curr := int_ds.day_second.day*1000000 + int_ds.day_second.hour*10000 + int_ds.day_second.minute*100 + int_ds.day_second.second;
        // Currency type contains 4 decimal places only. Fraction can contains up 6 digits
      Curr := Curr + int_ds.day_second.fraction / 1000000;
    end;
    HelperCurrToBCD( curr, OutData, 32, 4 );
  end else begin
    if nSize > BufSize then
      nSize := BufSize;
    SafeCopyMem( InData, OutData, nSize );
    if ADataType = ftString then begin
      if nSize = BufSize then
        Dec(nSize);
      	// PSDFieldInfo(InBuf)^.DataSize does not include zero-termination byte (checked with MSSQL & DB2 ODBC drivers)
      HelperMemWriteByte(OutData, nSize, 0);		// = PChar(OutData)[nSize] := #0;
      if SqlDatabase.IsRTrimChar then
        StrRTrim( OutData );
    end;
  end;
end;

function TICustomOdbcCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf: TSDPtr;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);

  Result := CnvtDBData(AFieldDesc.DataType, AFieldDesc.FieldType, InBuf, Buffer, BufSize);
end;

function TICustomOdbcCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
  function IsLongCharType(AFieldType: TFieldType): Boolean;
  begin
    Result := AFieldType in [ftMemo, ftFmtMemo];
  end;
var
  ft: TFieldType;
  CurPtr, FldBuf, PiecePtr: TSDValueBuffer;
  FldInfo: TSDFieldInfo;
  BlobSize, Len, Idx: SQLINTEGER;
  rcd: SQLRETURN;
begin
  if IsPseudoBlob(AFieldDesc) then begin
    Len := AFieldDesc.DataSize;
{$IFDEF SD_CLR}
    PiecePtr := SafeReallocMem(nil, Len);
    try
{$ELSE}
    SetLength(BlobData, Len);   // it is max size
    PiecePtr := PChar(BlobData);
{$ENDIF}
    if GetCnvtFieldData(AFieldDesc, PiecePtr, Len) then begin
    	// get actual data size, which was returned
      FldBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);
      FldInfo := GetFieldInfoStruct(FldBuf, 0);
      Result := FldInfo.DataSize;
    end else
      Result := 0;
    SetLength(BlobData, Result);        // set actual size
{$IFDEF SD_CLR}
      Marshal.Copy( PiecePtr, BlobData, 0, Result );
    finally
      SafeReallocMem(PiecePtr, 0);
    end;
{$ENDIF}
    Exit;
  end;  // if IsPseudoBlob(...)
  ft := AFieldDesc.FieldType;
	// get data size
  PiecePtr := nil;
  Len := 0;
  BlobSize := 1;	// BlobSize has to be more then 0, for some driver (for example, Informix 2.8 with Informix 7.30 for Linux)
  	// it's necessary a byte for zero-terminator at the end of char data
  if IsLongCharType(ft) then
    Inc(BlobSize);
  if BlobSize > 0 then
    SetLength(BlobData, BlobSize);

  try   // ..finally
  try   // ..except
{$IFDEF SD_CLR}
    PiecePtr := SafeReallocMem(nil, BlobSize);
    CurPtr := PiecePtr;
{$ELSE}
    CurPtr := @BlobData[0];	// CurPtr must have a valid pointer
{$ENDIF}
    	// read the first data byte and get an actual data length (if it's possible)
    rcd := Calls.SQLGetData( Handle, AFieldDesc.FieldNo,
      		NativeDataType( ft ),
                  CurPtr, BlobSize, Len );
    if (rcd <> SQL_SUCCESS) and (rcd <> SQL_SUCCESS_WITH_INFO) and
       (rcd <> SQL_NO_DATA)
    then
      Check( rcd );
    // In case of success (error do not happen), SQLGetData returns the following codes:
    // rcd = SQL_SUCCESS (0) -   if Data was read completely or the Data is NULL (Len = SQL_NULL_DATA)
    // rcd = SQL_SUCCESS_WITH_INFO (1) - if Data truncated (when SQLSTATE 01004 only)
    // rcd = SQL_NO_DATA (100) - if no Data for read

	// if all column data was returned or data is NULL
    if (rcd = SQL_NO_DATA) or ((rcd = SQL_SUCCESS) and (Len = SQL_NULL_DATA)) then
      SetLength(BlobData, 0)
    else if rcd = SQL_SUCCESS then begin
      SetLength(BlobData, Len);
{$IFDEF SD_CLR}
      BlobData[0] := HelperMemReadByte(PiecePtr, 0);  // copy the first read byte
{$ENDIF}
    end else begin	// if rcd = SQL_SUCCESS_WITH_INFO
        // Len = SQL_NO_TOTAL value (if a server can not define the number of bytes of long data still available to return), for example, Oracle ODBC driver v.8.00
      if Len = SQL_NO_TOTAL then begin
	// exclude a null-terminator in the first piece
        if IsLongCharType(ft) and (BlobSize > 0) then
          SetLength(BlobData, BlobSize-1);
{$IFDEF SD_CLR}
        BlobData[0] := HelperMemReadByte(PiecePtr, 0);  // copy the first read byte
{$ENDIF}
        BlobSize := FBlobPieceSize;
        PiecePtr := SafeReallocMem(PiecePtr, BlobSize);
        CurPtr := PiecePtr;
        repeat
          Len := 0;
          rcd := Calls.SQLGetData( Handle, AFieldDesc.FieldNo,
        		NativeDataType( ft ), CurPtr, BlobSize, Len );
          if (rcd <> SQL_SUCCESS) and (rcd <> SQL_NO_DATA) then
            Check( rcd );		// Check do not raise an error when SQL_SUCCESS_WITH_INFO with a warning, for example, 'Data truncated'
          // 12.02.2005: fixed driver's(unknown now) bug with big blobs - reads BlobSize bytes, but moves Len variable more than BlobSize (at general, it is impossible, when driver returns SQL_NO_TOTAL)
          if (Len = SQL_NO_TOTAL) or (Len > BlobSize) then
            Len := BlobSize;
	    // Each part is null-terminated; the application must remove the null-termination character if concatenating the parts.
          if Len > 0 then begin
            if IsLongCharType(ft) and (rcd <> SQL_SUCCESS) then	// if it is not the last call
              Dec(Len);
            SetLength( BlobData, Length(BlobData) + Len );
            Idx := Length(BlobData) - Len;              // take into accout: the first byte was read before
{$IFDEF SD_CLR}
            Marshal.Copy( PiecePtr, BlobData, Idx, Len );	// ??? check offset
{$ELSE}
            SafeCopyMem( PiecePtr, TSDPtr(@BlobData[Idx]), Len );
{$ENDIF}
          end;
        until (rcd = SQL_SUCCESS) or (rcd = SQL_NO_DATA);
      end else begin
	// get all data at one call
        BlobSize := Len;
        if IsLongCharType(ft) then
          Inc(BlobSize);
        SetLength(BlobData, BlobSize);
        Dec(BlobSize);		// the first byte was read before
{$IFDEF SD_CLR}
        BlobData[0] := HelperMemReadByte(PiecePtr, 0);  // copy the first read byte
        PiecePtr := SafeReallocMem(PiecePtr, BlobSize);
        CurPtr := PiecePtr;
{$ELSE}
        CurPtr := @BlobData[1];
{$ENDIF}
        rcd := Calls.SQLGetData( Handle, AFieldDesc.FieldNo,
          		NativeDataType( ft ),
                      CurPtr, BlobSize, Len );
        if (rcd <> SQL_SUCCESS) and (rcd <> SQL_NO_DATA) then
          Check( rcd );
{$IFDEF SD_CLR}
        Marshal.Copy( PiecePtr, BlobData, 1, Len );
{$ENDIF}
	// set(shrink) really Blob size - without null-terminator for text fields
        if IsLongCharType(ft) then begin
          BlobSize := Length(BlobData)-1;
          SetLength(BlobData, BlobSize);
        end;
      end;
    end;
  except
    SetLength(BlobData, 0);
    raise;
  end;
  finally
    if Assigned(PiecePtr) then
      SafeReallocMem(PiecePtr, 0);
  end;
  Result := Length(BlobData);
end;

function TICustomOdbcCommand.WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: LongInt): Longint;
var
  Len: Word;
  Buf: TSDValueBuffer;
begin
  Result := 0;

  Buf := Buffer;
  while Count > 0 do begin
    if Count > FBlobPieceSize
    then Len := FBlobPieceSize
    else Len := Count;
    Check( Calls.SQLPutData( Handle, SQLPOINTER(Buf), Len) );
    Inc(Result, Len);
    Dec(Count, Len);
    Buf := IncPtr(Buf, Len);
  end;
end;

		{ Query methods }

procedure TICustomOdbcCommand.QBindParamsBuffer;
var
  CurPtr, DataPtr: TSDValueBuffer;
  i: Integer;
  DataLen: SQLINTEGER;
  ColSize: SQLUINTEGER;
  FieldInfo: TSDFieldInfo;
begin
  if not Assigned( Params ) or ( Params.Count = 0 ) then
    Exit;

  if not Assigned( ParamsBuffer ) then
    AllocParamsBuffer;

  CurPtr := ParamsBuffer;

  CheckPrepared;

  for i:=0 to Params.Count-1 do begin
    FieldInfo := GetFieldInfoStruct(CurPtr, 0);
    FieldInfo.DataSize := 0;
    DataLen := NativeParamSize( Params[i] );
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );

    if Params[i].IsNull then
      FieldInfo.FetchStatus := SQL_NULL_DATA
    else
      if Params[i].DataType = ftString then
        FieldInfo.FetchStatus := SQL_NTS
      else
        FieldInfo.FetchStatus := DataLen;

    case Params[i].DataType of
      ftString:
        begin
          if DataLen > 0 then begin
            HelperMemWriteString( DataPtr, 0, Params[i].AsString, DataLen-1 );
            HelperMemWriteByte( DataPtr, DataLen-1, 0 );
          end;
        end;
{$IFDEF SD_VCL5}
      ftGuid:
        if DataLen > 0 then begin
          if Params[i].AsString <> '' then
            HelperMemWriteGuid(DataPtr, 0, StringToGuid( Params[i].AsString ))
          else
            FieldInfo.FetchStatus := SQL_NULL_DATA;
        end;
{$ENDIF}
      ftBytes,
      ftVarBytes:
        if DataLen > 0 then begin
          SafeInitMem( DataPtr, DataLen, 0 );
          Params[i].GetData( DataPtr );
        end;
      ftBoolean:
        if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, Ord( Params[i].AsBoolean ) );
      ftInteger,
      ftAutoInc:
        if DataLen > 0 then HelperMemWriteInt32( DataPtr, 0, Params[i].AsInteger );
      ftSmallInt:
        if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, Params[i].AsInteger );
{$IFDEF SD_VCL4}
      ftLargeInt:
        if DataLen > 0 then HelperMemWriteInt64( DataPtr, 0, Params[i].AsInteger );
{$ENDIF}
      ftDate, ftTime, ftDateTime:
        if DataLen > 0 then CnvtDateTime2DBDateTime(Params[i].DataType, Params[i].AsDateTime, DataPtr, NativeDataSize(Params[i].DataType));
      ftCurrency,
      ftFloat:
        if DataLen > 0 then HelperMemWriteDouble( DataPtr, 0, Params[i].AsFloat );
      else
        if not IsSupportedBlobTypes(Params[i].DataType) then
          raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
    end;

    if IsBlobType(Params[i].DataType) then begin
        // try to avoid VarAsType(Null, varString) -> Invalid variant conversion
      if (not Params[i].IsNull) and (VarType(Params[i].Value) <> varString) then
        VarAsType(Params[i].Value, varString);
        // Params[i].IsNull, VarIsEmpty() and VarIsNull() always return False (in D5-D7)
      if {$IFDEF SD_CLR}Params[i].Value = ''{$ELSE}PChar(TVarData(Params[i].Value).VString) = nil{$ENDIF} then
        FieldInfo.FetchStatus := SQL_NULL_DATA
      else
        if SqlDatabase.IsNeedLongDataLen
        then FieldInfo.FetchStatus := SQL_LEN_DATA_AT_EXEC( Length(Params[i].AsBlob) )
        else FieldInfo.FetchStatus := SQL_DATA_AT_EXEC;
      SetFieldInfoStruct( CurPtr, 0, FieldInfo );
      Check( Calls.SQLBindParameter( Handle, i+1, SQL_PARAM_INPUT,
    			NativeDataType(Params[i].DataType),
    			SqlDataType(Params[i].DataType),
    			FMaxBlobSize, 0, TSDCharPtr(i), 0,
                      IncPtr(CurPtr, GetFieldInfoFetchStatusOff) ) );
    end else begin
      ColSize := DataLen;
      if Params[i].DataType in [ftDateTime] then begin
              // max display string size, which can differs from DataLen, for example, for date/time columns
        if not Assigned( @Calls.SQLDescribeParam ) or
           (Calls.SQLDescribeParam(Handle, i+1, nil, ColSize, nil, nil) <> SQL_SUCCESS)
        then	// in case of error, for example: <Invalid descriptor index> when datetime parameter is not the first parameter
          ColSize := Length( DateTimeToStr(Params[i].AsDateTime) );
      end;
      SetFieldInfoStruct( CurPtr, 0, FieldInfo );
      Check( Calls.SQLBindParameter( Handle, i+1, SQL_PARAM_INPUT,
    			NativeDataType(Params[i].DataType),
    			SqlDataType(Params[i].DataType),
    			ColSize, 0, DataPtr, DataLen,
                      IncPtr(CurPtr, GetFieldInfoFetchStatusOff) ) );
    end;

    CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

{ Check whether the statement contains CALL procedure
 Some ODBC function returns info only after SQLExecute call, for example:
 SQLGetDiagField (for SQL_DIAG_DYNAMIC_FUNCTION),
 SQLNumResultCols for DB2 (not for MSSQL)) }
function TICustomOdbcCommand.GetIsCallStmt: Boolean;
var
  i: Integer;
  fc: SQLINTEGER;
begin
  if Calls.IsAvailFunc( 'SQLGetDiagField' ) and
     (Calls.SQLGetDiagField( SQL_HANDLE_STMT, Handle, 1,
    		SQL_DIAG_DYNAMIC_FUNCTION_CODE, fc, SQL_IS_INTEGER, nil ) = SQL_SUCCESS)
  then
    Result := fc = SQL_DIAG_CALL
  else begin
    i := Pos( 'CALL ', UpperCase(NativeCommand) );
    Result := (i = 1) or ( (i > 1) and (AnsiChar(NativeCommand[i-1]) in [#$20, '{', '=']) );
  end;
end;

// the command has to be executed directly without prepare
function TICustomOdbcCommand.GetIsExecDirect: Boolean;
begin
  Result := FExecDirect;
end;

procedure TICustomOdbcCommand.BindParamsBuffer;
begin
  if CommandType = ctQuery then
    QBindParamsBuffer
  else if CommandType = ctStoredProc then
    SpBindParamsBuffer
  else
    DatabaseError(SNoCapability);
end;

procedure TICustomOdbcCommand.InternalQExecute(InfoQuery: Boolean);
var
  rcd: SQLRETURN;
  pValue: SQLPOINTER;
  sBlob: string;
  szCmd: TSDCharPtr;
begin
  FNoDataExecuted := False;
  FNoMoreResult := False;

  if InfoQuery then
    BindParamsBuffer;

  if not FInfoExecuted then begin
    if not IsExecDirect then
      rcd := Calls.SQLExecute( Handle )
    else begin
{$IFDEF SD_CLR}
      szCmd := Marshal.StringToHGlobalAnsi(NativeCommand);
      try
{$ELSE}
      szCmd := PChar(NativeCommand);
{$ENDIF}
      rcd := Calls.SQLExecDirect( Handle, szCmd, SQL_NTS );
{$IFDEF SD_CLR}
      finally
        Marshal.FreeHGlobal(szCmd);
      end;
{$ENDIF}
    end;
    if rcd = SQL_NEED_DATA then begin
      rcd := Calls.SQLParamData( Handle, pValue );
      while rcd = SQL_NEED_DATA do
        with Params[Integer(pValue)] do begin
          sBlob := AsBlob;
          WriteBlob( Integer(pValue), {$IFDEF SD_CLR}BufList.StringToPtr(sBlob){$ELSE}PChar(sBlob){$ENDIF}, Length(sBlob) );

          rcd := Calls.SQLParamData( Handle, pValue );
        end;
      Check( rcd );
    end else
      Check( rcd );

	// nothing was updated/deleted
    FNoDataExecuted := rcd = SQL_NO_DATA;
  end;

  FInfoExecuted := InfoQuery;
end;

function TICustomOdbcCommand.GetRowsAffected: Integer;
begin
  if FNoDataExecuted then
    Result := 0
  else
    Check( Calls.SQLRowCount( Handle, Result ) );
end;

	{ StoredProc methods }

procedure TICustomOdbcCommand.AllocParamsBuffer;
begin
        // do not dispose bind buffer, when the statement was executed risht now (in GetFieldDescs)
        //or when multiple results are processed
  if (CommandType = ctStoredProc) and (FInfoExecuted or FNextResults) then
    Exit;

  inherited;  // Free old buffer and allocate new one
end;

procedure TICustomOdbcCommand.SpBindParamsBuffer;
var
  CurPtr, DataPtr: TSDValueBuffer;
  i: Integer;
  DataLen: SQLINTEGER;
  InputOutputType: SQLSMALLINT;
  FieldInfo: TSDFieldInfo;
begin
        // if FInfoExecuted is True, then a procedure was bound and executed
  if FInfoExecuted or FNextResults or not Assigned( Params ) then
    Exit;
  if not Assigned(ParamsBuffer) then
    AllocParamsBuffer;
  CurPtr := ParamsBuffer;

  CheckPrepared;

  for i:=0 to Params.Count-1 do begin
    FieldInfo := GetFieldInfoStruct(CurPtr, 0);
    FieldInfo.DataSize := 0;
    DataLen := NativeParamSize( Params[i] );
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );

    if Params[i].IsNull then
      FieldInfo.FetchStatus := SQL_NULL_DATA
    else
      if Params[i].DataType = ftString then
        FieldInfo.FetchStatus := SQL_NTS
      else
        FieldInfo.FetchStatus := DataLen;

    case Params[i].ParamType of
      ptInput:
        InputOutputType := SQL_PARAM_INPUT;
      ptInputOutput:
        InputOutputType := SQL_PARAM_INPUT_OUTPUT;
      ptOutput,
      ptResult:
        InputOutputType := SQL_PARAM_OUTPUT;
    else
      InputOutputType := SQL_PARAM_TYPE_UNKNOWN;
    end;

    case Params[i].DataType of
      ftString:
        if not Params[i].IsNull then begin
        	// DataLen (buffer size) is always equal 255(including '\0'), but string length may be less or more then 255
          HelperMemWriteString( DataPtr, 0, Params[i].AsString, MinIntValue(DataLen, Length(Params[i].AsString)+1) );
          HelperMemWriteByte( DataPtr, DataLen-1, 0 );	// DataLen is buffer size including zero-terminator
        end;
{$IFDEF SD_VCL5}
      ftGuid:
        if DataLen > 0 then begin
          if Params[i].AsString <> '' then
            HelperMemWriteGuid(DataPtr, 0, StringToGuid( Params[i].AsString ))
          else
            FieldInfo.FetchStatus := SQL_NULL_DATA;
        end;
{$ENDIF}
      ftInteger,
      ftAutoInc:
        if not Params[i].IsNull then HelperMemWriteInt32( DataPtr, 0, Params[i].AsInteger );
      ftSmallInt:
        if not Params[i].IsNull then HelperMemWriteInt16( DataPtr, 0, Params[i].AsInteger );
      ftDate, ftTime, ftDateTime:
        if not Params[i].IsNull then
          CnvtDateTime2DBDateTime(Params[i].DataType, Params[i].AsDateTime, DataPtr, NativeDataSize(Params[i].DataType));
      ftCurrency,
      ftFloat:
        if not Params[i].IsNull then HelperMemWriteDouble( DataPtr, 0, Params[i].AsFloat );
      else
        if not IsSupportedBlobTypes(Params[i].DataType) then
          raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
    end;

    if IsBlobType(Params[i].DataType) then begin
        // try to avoid VarAsType(Null, varString) -> Invalid variant conversion
      if (not Params[i].IsNull) and (VarType(Params[i].Value) <> varString) then
        VarAsType(Params[i].Value, varString);
      if {$IFDEF SD_CLR}Params[i].Value = ''{$ELSE}PChar(TVarData(Params[i].Value).VString) = nil{$ENDIF} then
        FieldInfo.FetchStatus := SQL_NULL_DATA
      else
        FieldInfo.FetchStatus := SQL_DATA_AT_EXEC;
      SetFieldInfoStruct( CurPtr, 0, FieldInfo );
      Check( Calls.SQLBindParameter( Handle, i+1, InputOutputType,
    			NativeDataType(Params[i].DataType),
    			SqlDataType(Params[i].DataType),
    			0, 0, TSDCharPtr(i), 0,
          		IncPtr(CurPtr, GetFieldInfoFetchStatusOff) ) );
    end else begin
      SetFieldInfoStruct( CurPtr, 0, FieldInfo );
      Check( Calls.SQLBindParameter( Handle, i+1, InputOutputType,
    			NativeDataType(Params[i].DataType),
    			SqlDataType(Params[i].DataType),
    			DataLen, 0, DataPtr, DataLen,
          		IncPtr(CurPtr, GetFieldInfoFetchStatusOff) ) );
    end;

    CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

procedure TICustomOdbcCommand.InitParamList;
const
  MaxColName	= 128;
  MaxIdentName  = 255;
var
  hStmt: SQLHSTMT;
  rcd: SQLRETURN;
  i: Integer;
  pColName, pCatName, pSchName, pPrcName, pColType, pColDataType: TSDValueBuffer;
  szSch, szPrc: TSDCharPtr;
  ColType, ColDataType: SQLSMALLINT;
  iColName: SQLINTEGER;
  ft: TFieldType;
  pt: TSDHelperParamType;
  sParamName, sPrcName, sSchName: string;
begin
  hStmt := nil;
  pt := ptUnknown;
        // first 4 byte - size of fetched data
  pColType := SafeReallocMem( nil, SizeOf(SQLINTEGER) + SizeOf(SQLSMALLINT) );
  pColDataType:= SafeReallocMem( nil, SizeOf(SQLINTEGER) + SizeOf(SQLSMALLINT) );
  pColName := SafeReallocMem( nil, SizeOf(SQLINTEGER) + MaxColName + 1 );
  pCatName := SafeReallocMem( nil, SizeOf(SQLINTEGER) + MaxIdentName + 1 );
  pSchName := SafeReallocMem( nil, SizeOf(SQLINTEGER) + MaxIdentName + 1 );
  pPrcName := SafeReallocMem( nil, SizeOf(SQLINTEGER) + MaxIdentName + 1 );
  with SqlDatabase, Calls do try
    rcd := OdbcAllocHandle( SQL_HANDLE_STMT, SQLHANDLE(SqlDatabase.DbcHandle), hStmt );
    CheckHSTMT( hStmt, rcd );
    	// get required result set
    sPrcName := CommandText;
    i := Pos('.', sPrcName);
    if (i > 0) and (i < Length(sPrcName)) then begin
      sSchName := Copy(sPrcName, 1, i-1);	// get owner name
      sPrcName := Copy(sPrcName, i+1, Length(sPrcName)-i);
    end else
      sSchName := SQL_ALL_SCHEMAS;
{$IFDEF SD_CLR}
    szSch := Marshal.StringToHGlobalAnsi(sSchName);
    szPrc := Marshal.StringToHGlobalAnsi(sPrcName);
{$ELSE}
    szSch := PChar(sSchName);
    szPrc := PChar(sPrcName);
{$ENDIF}
{ !!! NOTE: if szColumnName = '', then Informix v.2.80 returns only columns with empty name }
    rcd := SQLProcedureColumns( hStmt, nil, 0, szSch, SQL_NTS,
  		szPrc, SQL_NTS, nil, SQL_NTS );

    CheckHSTMT( hStmt, rcd );
	// bind the required columns
	// bind 4 - COLUMN_NAME
    rcd := SQLBindCol( hStmt, 4, SQL_C_CHAR, IncPtr(pColName, SizeOf(SQLINTEGER)), MaxColName+1, pColName );
    CheckHSTMT( hStmt, rcd );
    	// bind 5 - COLUMN_TYPE
    rcd := SQLBindCol( hStmt, 5, SQL_C_SSHORT, IncPtr(pColType, SizeOf(SQLINTEGER)), 0, pColType);
    CheckHSTMT( hStmt, rcd );
	// bind 6 - DATA_TYPE
    rcd := SQLBindCol( hStmt, 6, SQL_C_SSHORT, IncPtr(pColDataType, SizeOf(SQLINTEGER)), 0, pColDataType);
    CheckHSTMT( hStmt, rcd );
	// it's necessary to bind all(or almost all) columns for some(it seems old) drivers
    rcd := Calls.SQLBindCol( hStmt, 1, SQL_C_CHAR, IncPtr(pCatName, SizeOf(SQLINTEGER)), MaxIdentName+1, pCatName );
    CheckHSTMT( hStmt, rcd );
    rcd := Calls.SQLBindCol( hStmt, 2, SQL_C_CHAR, IncPtr(pSchName, SizeOf(SQLINTEGER)), MaxIdentName+1, pSchName );
    CheckHSTMT( hStmt, rcd );
    rcd := Calls.SQLBindCol( hStmt, 3, SQL_C_CHAR, IncPtr(pPrcName, SizeOf(SQLINTEGER)), MaxIdentName+1, pPrcName );
    CheckHSTMT( hStmt, rcd );

    repeat
	// fetch
      rcd := SQLFetch( hStmt );
      if rcd = SQL_ERROR then
        CheckHSTMT( hStmt, rcd )
      else if rcd = SQL_NO_DATA then
        Break;
      iColName := HelperMemReadInt32(pColName, 0);
      ColType  := HelperMemReadInt16(pColType, SizeOf(SQLINTEGER));
      ColDataType:=HelperMemReadInt16(pColDataType, SizeOf(SQLINTEGER));
      if iColName <> SQL_NULL_DATA
      then sParamName := Copy( HelperPtrToString(IncPtr(pColName, SizeOf(SQLINTEGER))), 1, iColName )
      else sParamName := '';
      ft := FieldDataType( ColDataType );
      if ft = ftUnknown then
        DatabaseErrorFmt( SBadFieldType, [sParamName] );
      case ColType of
        SQL_PARAM_INPUT:
          pt := ptInput;
        SQL_PARAM_INPUT_OUTPUT:
          pt := ptInputOutput;
        SQL_PARAM_OUTPUT:
          pt := ptOutput;
        SQL_RESULT_COL:
          Continue;		// it is field of a result set (not parameter)
        SQL_RETURN_VALUE:
          pt := ptResult; 	// this is not returned
      else
        DatabaseErrorFmt( SBadParameterType, [sParamName] );
      end;
      if ((iColName = 0) or (iColName = SQL_NULL_DATA)) and (pt = ptOutput) then
        pt := ptResult;
      if pt = ptResult then
        sParamName := SResultName;

      AddParam( sParamName, ft, pt );
    until rcd = SQL_NO_DATA;

  finally
    SafeReallocMem( pColName, 0 );
    SafeReallocMem( pCatName, 0 );
    SafeReallocMem( pSchName, 0 );
    SafeReallocMem( pPrcName, 0 );
    SafeReallocMem( pColType, 0 );
    SafeReallocMem( pColDataType, 0 );

    if hStmt <> nil then
      OdbcFreeHandle( SQL_HANDLE_STMT, SQLHANDLE(hStmt) );
{$IFDEF SD_CLR}
    Marshal.FreeHGlobal(szSch);
    Marshal.FreeHGlobal(szPrc);
{$ENDIF}
  end;
end;

{ InfoQuery is True, when GetFieldDescs is called.
 It's necessary to avoid to call SQLExecute more once.
 InternalSpExecute can be called before SpExecute(Open) or after(ExecProc), in the last case SQLExecute has to be called always. }
procedure TICustomOdbcCommand.InternalSpExecute(InfoQuery: Boolean);
var
  szCmd: TSDCharPtr;
begin
  if InfoQuery then
    BindParamsBuffer;
  if not FInfoExecuted then begin
    FNoMoreResult := False;
    if not IsExecDirect then
      Check( Calls.SQLExecute( Handle ) )
    else begin
{$IFDEF SD_CLR}
      szCmd := Marshal.StringToHGlobalAnsi(NativeCommand);
      try
{$ELSE}
      szCmd := PChar(NativeCommand);
{$ENDIF}
      Check( Calls.SQLExecDirect( Handle, szCmd, SQL_NTS ) );
{$IFDEF SD_CLR}
      finally
        Marshal.FreeHGlobal(szCmd);
      end;
{$ENDIF}
    end;
  end;
  FInfoExecuted := InfoQuery;
end;

procedure TICustomOdbcCommand.SpExecute;
begin
  if not FNextResults then
    InternalSpExecute(False);
end;

procedure TICustomOdbcCommand.GetOutputParams;
begin
	// fetch all rows for the current result set
  SaveResults;
	// output buffers are not guaranteed to be set until all result sets/row counts have been processed
  while NextResultSet do
    ;

  InternalSpGetParams;

  ReleaseDBHandle;
end;

{ NOTE from ODBC Reference:
  For some drivers(for example, MSSQL), output parameters and return values are not available
until all result sets and row counts have been processed. For such drivers,
output parameters and return values become available when the first SQLMoreResults call returns SQL_NO_DATA.}
procedure TICustomOdbcCommand.InternalSpGetParams;
var
  i, MaxParamSize: Integer;
  FldBuf, OutData: TSDValueBuffer;
  bIsNull: Boolean;
  FieldInfo: TSDFieldInfo;
begin
  if ParamsBuffer = nil then Exit;
	// Alloc buffer for parameter of max size, which could be bigger 255 byte
  MaxParamSize := MaxCharParamSize+1;
  OutData := SafeReallocMem(nil, MaxParamSize);

  try
    FldBuf := ParamsBuffer;
    for i := 0 to Params.Count - 1 do with Params[i] do begin
      if ParamType in [ptResult, ptInputOutput, ptOutput] then begin
        FieldInfo := GetFieldInfoStruct(FldBuf, 0);
                // FieldInfo.DataSize is not assigned, because FieldInfo.FetchStatus is bound as indicator and data length variable
        if FieldInfo.FetchStatus <> SQL_NULL_DATA then
          FieldInfo.DataSize := NativeParamSize(Params[i]);
          // DataSize has to contain length w/o null-terminator in in GetCnvtFieldData method
        if DataType = ftString then
          Dec( FieldInfo.DataSize );
        SetFieldInfoStruct(FldBuf, 0, FieldInfo);
        bIsNull := not CnvtDBData(SQL_UNKNOWN_TYPE, DataType, FldBuf, OutData, MaxParamSize);

        if bIsNull then
          Params[i].Clear
        else
          Params[i].SetData(OutData);
      end;
      FldBuf := IncPtr( FldBuf, NativeParamSize(Params[i]) + SizeOf(TSDFieldInfo) );
    end;
  finally
    SafeReallocMem(OutData, 0);
  end;
end;

function TICustomOdbcCommand.NextResultSet: Boolean;
var
  rcd: SQLRETURN;
begin
  Result := False;
        // avoid to call SQLMoreResults repeatedly, when no more results, to exclude a loss of output parameters
  if FNoMoreResult then
    Exit;
  rcd := Calls.SQLMoreResults( Handle );
  if rcd = SQL_NO_DATA_FOUND then begin
    FNoMoreResult := True;
    Exit;
  end;
  Check( rcd );

  FreeFieldsBuffer;
  FNextResults := True;
  Result := True;
end;


{ TICustomOdbcCall }
procedure TICustomOdbcCall.DoPrepare(Value: string);
begin
  DoExecDirect(Value);
end;

procedure TICustomOdbcCall.DoExecDirect(Value: string);
begin
  if FHandle = nil then Connect;
        // descendants has to continue 
end;

procedure TICustomOdbcCall.DoExecute;
begin
  { empty }
end;

{ TIOdbcCallProcs }
constructor TIOdbcCallProcs.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FProcNames := '';
end;

procedure TIOdbcCallProcs.DoExecDirect(Value: string);
var
  rcd: SQLRETURN;
  sSchName, sPrcNames: string;
  szSchName, szPrcNames: TSDCharPtr;
begin
  inherited DoExecDirect(Value);

  AcquireDBHandle;

  ExtractOwnerObjNames(ProcNames, sSchName, sPrcNames);
  if sSchName = '' then sSchName := SQL_ALL_SCHEMAS;
  if sPrcNames = '' then sPrcNames := '%';
{$IFDEF SD_CLR}
  szSchName := Marshal.StringToHGlobalAnsi(sSchName);
  szPrcNames:= Marshal.StringToHGlobalAnsi(sPrcNames);
  try
{$ELSE}
  szSchName := PChar(sSchName);
  szPrcNames:= PChar(sPrcNames);
{$ENDIF}
    	// get required result set
	// it's necessary to bind all columns for some(it seems old) drivers
  rcd := Calls.SQLProcedures( Handle, nil, 0, szSchName, SQL_NTS, szPrcNames, SQL_NTS );
	// Error 'Option feature not implemented'
        // driver(MS Access) can't support catalog, schema or string pattern
  if rcd <> SQL_SUCCESS then
    rcd := Calls.SQLProcedures( Handle, nil, 0, nil, 0, szPrcNames, SQL_NTS );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal(szSchName);
    Marshal.FreeHGlobal(szPrcNames);
  end;
{$ENDIF}

  Check( rcd );

  SetNativeCommand('ODBC Call: SQLProcedures');

  InitFieldDescs;
end;

procedure TIOdbcCallProcs.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := PROC_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := PROC_IN_PARAMS;
      5: Descs.FieldDescs[i].FieldName := PROC_OUT_PARAMS;
      8: Descs.FieldDescs[i].FieldName := PROC_TYPE_FIELD;
    end;
  end;
end;

{ TIOdbcCallProcParams }

constructor TIOdbcCallProcParams.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FProcName := '';
end;

procedure TIOdbcCallProcParams.DoExecDirect(Value: string);
var
  sSchName, sPrcName: string;
  szSchName, szPrcName: TSDCharPtr;
begin
  inherited DoExecDirect(Value);

  AcquireDBHandle;

  ExtractOwnerObjNames(ProcName, sSchName, sPrcName);
  if sSchName = '' then sSchName := SQL_ALL_SCHEMAS;
  if sPrcName = '' then sPrcName := '%';
{$IFDEF SD_CLR}
  szSchName := Marshal.StringToHGlobalAnsi(sSchName);
  szPrcName := Marshal.StringToHGlobalAnsi(sPrcName);
  try
{$ELSE}
  szSchName := PChar(sSchName);
  szPrcName := PChar(sPrcName);
{$ENDIF}

{ !!! NOTE: if szColumnName = '', then Informix v.2.80 returns only columns with empty name }
    Check( Calls.SQLProcedureColumns( Handle, nil, 0, szSchName, SQL_NTS,
    		szPrcName, SQL_NTS, nil, SQL_NTS ) );

{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal(szSchName);
    Marshal.FreeHGlobal(szPrcName);
  end;
{$ENDIF}

  SetNativeCommand('ODBC Call: SQLProcedureColumns');

  InitFieldDescs;
end;

procedure TIOdbcCallProcParams.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := PROC_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := PARAM_NAME_FIELD;
      5: Descs.FieldDescs[i].FieldName := PARAM_TYPE_FIELD;
      6: Descs.FieldDescs[i].FieldName := PARAM_DATATYPE_FIELD;
      7: Descs.FieldDescs[i].FieldName := PARAM_TYPENAME_FIELD;
      9: Descs.FieldDescs[i].FieldName := PARAM_LENGTH_FIELD;
      10:Descs.FieldDescs[i].FieldName := PARAM_SCALE_FIELD;
      11:Descs.FieldDescs[i].FieldName := PARAM_PREC_FIELD;
      12:Descs.FieldDescs[i].FieldName := PARAM_NULLABLE_FIELD;
      18:Descs.FieldDescs[i].FieldName := PARAM_POS_FIELD;      
    end;
  end;
end;

{ TIOdbcCallTables }
constructor TIOdbcCallTables.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FTableNames := '';
  FTableTypes := SQL_ALL_TABLE_TYPES;
end;

procedure TIOdbcCallTables.DoExecDirect(Value: string);
var
  rcd: SQLRETURN;
  sSchName, sTblNames, sTblTypes, sDBMSName: string;
  szSchName, szTblNames, szTblTypes: TSDCharPtr;
begin
  inherited DoExecDirect(Value);

  AcquireDBHandle;

    	// get required result set
  ExtractOwnerObjNames(TableNames, sSchName, sTblNames);
  if sSchName = '' then sSchName := SQL_ALL_SCHEMAS;
  if sTblNames = '' then sTblNames := '%';
	// it's necessary to define a separate variable for avoid AV for some drivers(for example: Informix CLI v2.8)
  sTblTypes := Trim(FTableTypes);
  if sTblTypes = '' then sTblTypes := SQL_ALL_TABLE_TYPES;
{$IFDEF SD_CLR}
  szSchName := Marshal.StringToHGlobalAnsi(sSchName);
  szTblNames:= Marshal.StringToHGlobalAnsi(sTblNames);
  szTblTypes:= Marshal.StringToHGlobalAnsi(sTblTypes);
  try
{$ELSE}
  szSchName := PChar(sSchName);
  szTblNames:= PChar(sTblNames);
  szTblTypes:= PChar(sTblTypes);
{$ENDIF}
  rcd := Calls.SQLTables( Handle, nil, 0, szSchName, SQL_NTS, szTblNames, SQL_NTS, szTblTypes, SQL_NTS );
	// Error 'Option feature not implemented',
        // if a driver(MS Access, Excel) don't support catalog, schema or string pattern. It's probably SQL_ODBC_VERSION = SQL_OV_ODBC2
  if rcd <> SQL_SUCCESS then begin
    sDBMSName := SqlDatabase.OdbcGetInfoString( SQL_DBMS_NAME );
        // MS Excel driver (4.00.6200)returns non-empty result set, when szTblTypes=nil only    
    if UpperCase(sDBMSName) = 'EXCEL' then
      rcd := Calls.SQLTables( Handle, nil, 0, nil, 0, szTblNames, SQL_NTS, nil, 0 )
    else
      rcd := Calls.SQLTables( Handle, nil, 0, nil, 0, szTblNames, SQL_NTS, szTblTypes, SQL_NTS );
  end;
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal(szSchName);
    Marshal.FreeHGlobal(szTblNames);
    Marshal.FreeHGlobal(szTblTypes);
  end;
{$ENDIF}
  Check( rcd );

  SetNativeCommand('ODBC Call: SQLTables');

  InitFieldDescs;
end;

procedure TIOdbcCallTables.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := OLD_FIELD_PREFIX + TBL_TYPE_FIELD;
    end;
  end;

  with Descs.AddFieldDesc do begin
    FieldName	:= TBL_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
end;

function TIOdbcCallTables.FetchNextRow: Boolean;
const
  InCnvtFieldNo = 3;
var
  OutBuf: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  s: string;
  v: Integer;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;
	// set value for TBL_TYPE_FIELD field from OLD_FIELD_PREFIX + TBL_TYPE_FIELD field
  if not GetFieldAsString(FieldDescs[InCnvtFieldNo].FieldNo, s) then
    Exit;
  OutBuf := GetFieldBuffer(FieldDescs[FFirstCalcFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(OutBuf, 0);
  FieldInfo.FetchStatus := SQL_VALUE_DATA;
  FieldInfo.DataSize := FieldDescs[FFirstCalcFieldIdx].DataSize;
  SetFieldInfoStruct(OutBuf, 0, FieldInfo);

  v := 0;
  if s = 'TABLE' then
    v := v or $1;
  if s = 'VIEW' then
    v := v or $2;
  if s = 'SYSTEM TABLE' then
    v := v or $4;

  HelperMemWriteInt32( OutBuf, SizeOf(TSDFieldInfo), v );
end;

{ TIOdbcCallColumns }
constructor TIOdbcCallColumns.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FTableName := '';
  FColTypeFieldIdx := 0;
  FColPrecFieldIdx := 0;
  FColPosV2FieldIdx:= 0;
  FColDefV2FieldIdx:= 0;
end;

procedure TIOdbcCallColumns.DoExecDirect(Value: string);
var
  rcd: SQLRETURN;
  sSchName, sTblName: string;
  szSchName, szTblName: TSDCharPtr;
begin
  inherited DoExecDirect(Value);

  AcquireDBHandle;
    	// get required result set
	// it's necessary to bind all columns for some(it seems old) drivers
  ExtractOwnerObjNames(TableName, sSchName, sTblName);
  if sSchName = '' then
    sSchName := SQL_ALL_SCHEMAS;
{$IFDEF SD_CLR}
  szSchName := Marshal.StringToHGlobalAnsi(sSchName);
  szTblName := Marshal.StringToHGlobalAnsi(sTblName);
  try
{$ELSE}
  szSchName := PChar(sSchName);
  szTblName := PChar(sTblName);
{$ENDIF}
  rcd := Calls.SQLColumns( Handle, nil, 0, szSchName, SQL_NTS, szTblName, SQL_NTS, nil, 0 );
	// Error 'Option feature not implemented'
      // driver(MS Access) does not support catalog, schema or string pattern
  if rcd <> SQL_SUCCESS then
    rcd := Calls.SQLColumns( Handle, nil, 0, nil, 0, szTblName, SQL_NTS, nil, 0 );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal(szSchName);
    Marshal.FreeHGlobal(szTblName);
  end;
{$ENDIF}
  Check( rcd );

  SetNativeCommand('ODBC Call: SQLColumns');

  InitFieldDescs;
end;

function TIOdbcCallColumns.GetIsODBC_3: Boolean;
begin
  Result := (FFirstCalcFieldIdx-1) > 12;	// SQLColumns returns 12 columns in ODBC version < 3.0
end;

procedure TIOdbcCallColumns.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := COL_NAME_FIELD;
      6: Descs.FieldDescs[i].FieldName := COL_TYPENAME_FIELD;
      8: Descs.FieldDescs[i].FieldName := COL_LENGTH_FIELD;
      9: Descs.FieldDescs[i].FieldName := COL_SCALE_FIELD;
      11:Descs.FieldDescs[i].FieldName := COL_NULLABLE_FIELD;
      13:Descs.FieldDescs[i].FieldName := COL_DEFAULT_FIELD;
      17:Descs.FieldDescs[i].FieldName := COL_POS_FIELD;
    end;
  end;
	// add COL_TYPE_FIELD, COL_PREC_FIELD fields
  with Descs.AddFieldDesc do begin
    FieldName	:= COL_TYPE_FIELD;
    FieldNo	:= Descs.Count;
    FieldType	:= ftInteger;
    DataType	:= NativeDataType(FieldType);
    DataSize	:= NativeDataSize(FieldType);
    Precision	:= 0;
    Required	:= True;
  end;
  FColTypeFieldIdx := Descs.Count-1;
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

    	// add empty COL_DEFAULT_FIELD, COL_POS_FIELD fields
  if not IsODBC_3 then begin
    with Descs.AddFieldDesc do begin
      FieldName	:= COL_POS_FIELD;
      FieldNo	:= Descs.Count;
      FieldType	:= ftInteger;
      DataType	:= NativeDataType(FieldType);
      DataSize	:= NativeDataSize(FieldType);
      Precision	:= 0;
      Required	:= False;
    end;
    FColPosV2FieldIdx := Descs.Count-1;
    with Descs.AddFieldDesc do begin
      FieldName	:= COL_DEFAULT_FIELD;
      FieldNo	:= Descs.Count;
      FieldType	:= ftString;
      DataType	:= NativeDataType(FieldType);
      DataSize	:= 10;
      Precision	:= 0;
      Required	:= False;
    end;
    FColDefV2FieldIdx := Descs.Count-1;
  end;
end;

function TIOdbcCallColumns.FetchNextRow: Boolean;
const
  ColSizeFieldNo = 7;
  DecDigitsFieldNo = 9;
  NumPrecRadixFieldNo = 10;
var
  FldBuf, DataPtr: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  ColSize, DecDigits: Integer;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;
	// at present COL_TYPE field is equal 0
  FldBuf := GetFieldBuffer(FieldDescs[FColTypeFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  FieldInfo.FetchStatus := SQL_VALUE_DATA;
  FieldInfo.DataSize := SizeOf(Integer);
  SetFieldInfoStruct(FldBuf, 0, FieldInfo);
  HelperMemWriteInt32(FldBuf, SizeOf(TSDFieldInfo), 0);
	// get NUM_PREC_RADIX value and set COL_PREC_FIELD value
  FldBuf := GetFieldBuffer(FieldDescs[FColPrecFieldIdx].FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(FldBuf, 0);
  DataPtr := SafeReallocMem(nil, SizeOf(ColSize));
  try
    HelperMemWriteInt32(DataPtr, 0, 0);	// prevent garbage, when smallint value is returned
    	// if NUM_PREC_RADIX value = 10
    if CnvtDBData(SQL_UNKNOWN_TYPE, FieldDescs[NumPrecRadixFieldNo-1].FieldType,
    		  GetFieldBuffer(NumPrecRadixFieldNo, FieldsBuffer), DataPtr, SizeOf(ColSize)
       ) and (HelperMemReadInt32(DataPtr, 0) = 10)
    then begin
      HelperMemWriteInt32(DataPtr, 0, 0);
      if CnvtDBData(SQL_UNKNOWN_TYPE, FieldDescs[ColSizeFieldNo-1].FieldType , GetFieldBuffer(ColSizeFieldNo, FieldsBuffer), DataPtr, SizeOf(ColSize))
      then ColSize := HelperMemReadInt32(DataPtr, 0)
      else ColSize := 0;
      HelperMemWriteInt32(DataPtr, 0, 0);
      if CnvtDBData(SQL_UNKNOWN_TYPE, FieldDescs[DecDigitsFieldNo-1].FieldType , GetFieldBuffer(DecDigitsFieldNo, FieldsBuffer), DataPtr, SizeOf(DecDigits))
      then DecDigits := HelperMemReadInt32(DataPtr, 0)
      else DecDigits := 0;
      FieldInfo.FetchStatus := SQL_VALUE_DATA;
      FieldInfo.DataSize := FieldDescs[FColPrecFieldIdx].DataSize;
      HelperMemWriteInt32(FldBuf, SizeOf(TSDFieldInfo), ColSize + DecDigits);
    end else begin
      FieldInfo.FetchStatus := SQL_NULL_DATA;
      FieldInfo.DataSize := SQL_NULL_DATA;
    end;
    SetFieldInfoStruct(FldBuf, 0, FieldInfo);
  finally
    SafeReallocMem(DataPtr, 0);
  end;
    	// add empty COL_POS_FIELD, COL_DEFAULT_FIELD fields for ODBC driver version < 3.0
  if not IsODBC_3 then begin
    FldBuf := GetFieldBuffer(FieldDescs[FColPosV2FieldIdx].FieldNo, FieldsBuffer);
    FieldInfo := GetFieldInfoStruct(FldBuf, 0);
    FieldInfo.FetchStatus := SQL_NULL_DATA;
    FieldInfo.DataSize := SQL_NULL_DATA;
    SetFieldInfoStruct(FldBuf, 0, FieldInfo);
    FldBuf := GetFieldBuffer(FieldDescs[FColDefV2FieldIdx].FieldNo, FieldsBuffer);
    FieldInfo := GetFieldInfoStruct(FldBuf, 0);
    FieldInfo.FetchStatus := SQL_NULL_DATA;
    FieldInfo.DataSize := SQL_NULL_DATA;
    SetFieldInfoStruct(FldBuf, 0, FieldInfo);
  end;
end;

{ TIOdbcCallIndexes }
constructor TIOdbcCallIndexes.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FTableName := '';
end;

procedure TIOdbcCallIndexes.DoExecDirect(Value: string);
var
  rcd: SQLRETURN;
  sSchName, sTblName: string;
  szSchName, szTblName: TSDCharPtr;
  iSchName: Integer;
begin
  inherited DoExecDirect(Value);

  AcquireDBHandle;
    	// get required result set
	// it's necessary to bind all columns for some(it seems old) drivers
  ExtractOwnerObjNames(TableName, sSchName, sTblName);
  	// SQLStatistics don't support search patterns for SchemaName and TableName parameters
  if sSchName = '%' then begin
    sSchName := '';
    iSchName := 0;
  end else
    iSchName := SQL_NTS;
  szSchName := nil;
{$IFDEF SD_CLR}
  if iSchName = SQL_NTS then
    szSchName := Marshal.StringToHGlobalAnsi(sSchName);
  szTblName := Marshal.StringToHGlobalAnsi(sTblName);
  try
{$ELSE}
  if iSchName = SQL_NTS then
    szSchName := PChar(sSchName);
  szTblName := PChar(sTblName);
{$ENDIF}
  rcd := Calls.SQLStatistics( Handle, nil, 0, szSchName, iSchName, szTblName, SQL_NTS, SQL_INDEX_ALL, SQL_QUICK );
	// Error 'Option feature not implemented'
      // driver(MS Access) does not support catalog, schema or string pattern
  if rcd <> SQL_SUCCESS then
    rcd := Calls.SQLStatistics( Handle, nil, 0, nil, 0, szTblName, SQL_NTS, SQL_INDEX_ALL, SQL_QUICK );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal(szSchName);
    Marshal.FreeHGlobal(szTblName);
  end;
{$ENDIF}

  Check( rcd );

  SetNativeCommand('ODBC Call: SQLStatistics');

  InitFieldDescs;
end;

procedure TIOdbcCallIndexes.GetFieldDescs(Descs: TSDFieldDescList);
var
  i: Integer;
begin
  inherited GetFieldDescs(Descs);

  for i:=0 to Descs.Count-1 do begin
    case Descs[i].FieldNo of
      1: Descs.FieldDescs[i].FieldName := CAT_NAME_FIELD;
      2: Descs.FieldDescs[i].FieldName := SCH_NAME_FIELD;
      3: Descs.FieldDescs[i].FieldName := TBL_NAME_FIELD;
      4: Descs.FieldDescs[i].FieldName := IDX_TYPE_FIELD;
      6: Descs.FieldDescs[i].FieldName := IDX_NAME_FIELD;
      8: Descs.FieldDescs[i].FieldName := IDX_COL_POS_FIELD;
      9: Descs.FieldDescs[i].FieldName := IDX_COL_NAME_FIELD;
      10:Descs.FieldDescs[i].FieldName := IDX_SORT_FIELD;
      13:Descs.FieldDescs[i].FieldName := IDX_FILTER_FIELD;
    end;
  end;
end;

function TIOdbcCallIndexes.FetchNextRow: Boolean;
const
  IdxTypeFieldNo = 4;
var
  FldBuf, DataPtr: TSDValueBuffer;
  v: SmallInt;
begin
  Result := inherited FetchNextRow;
  if not Result then
    Exit;

  DataPtr := SafeReallocMem(nil, SizeOf(v));
  try
    HelperMemWriteInt16(DataPtr, 0, 0);
    	// IDX_TYPE_FIELD value is returned as SmallInt (2 byte)
    FldBuf := GetFieldBuffer(IdxTypeFieldNo, FieldsBuffer);
    if CnvtDBData(SQL_UNKNOWN_TYPE, FieldDescs[IdxTypeFieldNo-1].FieldType, FldBuf, DataPtr, SizeOf(v)) then begin
      v := HelperMemReadInt16(DataPtr, 0);
    	// if unique index
      if v = SQL_FALSE then
        v := UniqueIndexType
      else
        v := NonUniqueIndexType;
        // assign converted value
      HelperMemWriteInt16(FldBuf, SizeOf(TSDFieldInfo), v);
    end;
  finally
    SafeReallocMem(DataPtr, 0);
  end;
end;


{ TIODBCDatabase }
function TIOdbcDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIOdbcCommand.Create( Self );
end;

procedure TIOdbcDatabase.FreeSqlLib;
begin
  SDOdbc.FreeSqlLib;
end;

procedure TIOdbcDatabase.LoadSqlLib;
begin
  SDOdbc.LoadSqlLib;

  FCalls := OdbCalls;
end;

procedure TIOdbcDatabase.RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string);
begin
  raise ESDOdbcError.CreateWithSqlState(AErrorCode, ANativeError, AMsg, ASqlState);
end;


initialization
  hSqlLibModule	:= 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  OdbCalls 	:= TOdbcFunctions.Create;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
  OdbCalls.Free;
end.
