{$I XSqlDir.inc}
unit XSDb2 {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, SyncObjs,
{$IFDEF XSQL_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  XSConsts, XSCommon, XSOdbc;



{******************************************************************************
 *
 * Source File Name = sqlcli.h
 *
 * Function = Include File defining:
 *              DB2 CLI Interface - Constants
 *              DB2 CLI Interface - Data Structures
 *              DB2 CLI Interface - Function Prototypes
 *
 * Operating System = Common C Include File
 *
 *****************************************************************************}


const
// generally useful constants
  SQL_MAX_MESSAGE_LENGTH	= 1024; // message buffer size
  SQL_MAX_ID_LENGTH        	= 18;   // maximum identifier name size, e.g. cursor names

(* test for SQL_SUCCESS or SQL_SUCCESS_WITH_INFO
#define SQL_SUCCEEDED(rc) (((rc)&(~1))==0)
*)


// SQL extended data types
  SQL_GRAPHIC           = -95;
  SQL_VARGRAPHIC        = -96;
  SQL_LONGVARGRAPHIC    = -97;
  SQL_BLOB              = -98;
  SQL_CLOB              = -99;
  SQL_DBCLOB            = -350;

// C data type to SQL data type mapping
  SQL_C_DBCHAR        	= SQL_DBCLOB;
  SQL_C_DECIMAL_IBM   	= SQL_DECIMAL;

// locator type identifier
  SQL_BLOB_LOCATOR      = 31;
  SQL_CLOB_LOCATOR      = 41;
  SQL_DBCLOB_LOCATOR    = -351;

// C Data Type for the LOB locator types
  SQL_C_BLOB_LOCATOR    = SQL_BLOB_LOCATOR;
  SQL_C_CLOB_LOCATOR    = SQL_CLOB_LOCATOR;
  SQL_C_DBCLOB_LOCATOR  = SQL_DBCLOB_LOCATOR;

// SQLColAttributes defines
  SQL_COLUMN_SCHEMA_NAME     	= 16;
  SQL_COLUMN_CATALOG_NAME    	= 17;
  SQL_COLUMN_DISTINCT_TYPE   	= 1250;
  SQL_DESC_DISTINCT_TYPE     	= SQL_COLUMN_DISTINCT_TYPE;

// SQLColAttribute defines for SQL_COLUMN_UPDATABLE condition
  SQL_UPDT_READONLY           	= 0;
  SQL_UPDT_WRITE              	= 1;
  SQL_UPDT_READWRITE_UNKNOWN  	= 2;

// SQL_DIAG_ROW_NUMBER values
  SQL_ROW_NO_ROW_NUMBER 	= (-1);
  SQL_ROW_NUMBER_UNKNOWN        = (-2);

// SQL_DIAG_COLUMN_NUMBER values
  SQL_COLUMN_NO_COLUMN_NUMBER   = (-1);
  SQL_COLUMN_NUMBER_UNKNOWN     = (-2);

// internal representation of numeric data type
const
  SQL_MAX_NUMERIC_LEN	= 16;
type
  TSQL_NUMERIC_STRUCT	= record
    precision:	SQLCHAR;
    scale:	SQLSCHAR;
    sign:	SQLCHAR;	// 1 if positive, 0 if negative
    val:	array[0..SQL_MAX_NUMERIC_LEN-1] of SQLCHAR;
  end;


{******************************************************************************
 *
 * Source File Name = sqlcli1.h
 *
 * Function = Include File defining:
 *              DB2 CLI Interface - Constants
 *              DB2 CLI Interface - Function Prototypes
 *
 * Operating System = Common C Include File
 *
 *****************************************************************************}

const

// SQLGetFunction defines  - supported functions
  SQL_API_SQLBINDFILETOCOL     	= 1250;
  SQL_API_SQLBINDFILETOPARAM   	= 1251;
  SQL_API_SQLSETCOLATTRIBUTES  	= 1252;
  SQL_API_SQLGETSQLCA          	= 1253;

  SQL_API_SQLGETLENGTH         	= 1022;
  SQL_API_SQLGETPOSITION       	= 1023;
  SQL_API_SQLGETSUBSTRING      	= 1024;

  SQL_API_SQLSETCONNECTION     	= 1254;

// SQL_FETCH_DIRECTION masks
  SQL_FD_FETCH_RESUME         	= $00000040;

// SQL_TXN_ISOLATION_OPTION masks
  SQL_TXN_NOCOMMIT             	= $00000020;
  SQL_TRANSACTION_NOCOMMIT     	= SQL_TXN_NOCOMMIT;

// Options for SQLGetStmtOption/SQLSetStmtOption extensions
  SQL_CURSOR_HOLD             	= 1250;
  SQL_ATTR_CURSOR_HOLD        	= 1250;
  SQL_NODESCRIBE_OUTPUT       	= 1251;
  SQL_ATTR_NODESCRIBE_OUTPUT  	= 1251;

  SQL_NODESCRIBE_INPUT        	= 1264;
  SQL_ATTR_NODESCRIBE_INPUT   	= 1264;
  SQL_NODESCRIBE              	= SQL_NODESCRIBE_OUTPUT;
  SQL_ATTR_NODESCRIBE         	= SQL_NODESCRIBE_OUTPUT;
  SQL_CLOSE_BEHAVIOR          	= 1257;
  SQL_ATTR_CLOSE_BEHAVIOR     	= 1257;
  SQL_ATTR_CLOSEOPEN          	= 1265;
  SQL_ATTR_CURRENT_PACKAGE_SET	= 1276;
  SQL_ATTR_DEFERRED_PREPARE   	= 1277;
  SQL_ATTR_EARLYCLOSE         	= 1268;
  SQL_ATTR_PROCESSCTL         	= 1278;

// SQL_CLOSE_BEHAVIOR values.
  SQL_CC_NO_RELEASE            	= 0;
  SQL_CC_RELEASE               	= 1;
  SQL_CC_DEFAULT               	= SQL_CC_NO_RELEASE;

// SQL_ATTR_DEFERRED_PREPARE values
  SQL_DEFERRED_PREPARE_ON      	= 1;
  SQL_DEFERRED_PREPARE_OFF     	= 0;
  SQL_DEFERRED_PREPARE_DEFAULT 	= SQL_DEFERRED_PREPARE_ON;

// SQL_ATTR_EARLYCLOSE values
  SQL_EARLYCLOSE_ON            	= 1;
  SQL_EARLYCLOSE_OFF           	= 0;
  SQL_EARLYCLOSE_DEFAULT       	= SQL_EARLYCLOSE_ON;

// SQL_ATTR_PROCESSCTL masks
  SQL_PROCESSCTL_NOTHREAD      	= $00000001;
  SQL_PROCESSCTL_NOFORK        	= $00000002;

// Options for SQL_CURSOR_HOLD
  SQL_CURSOR_HOLD_ON       	= 1;
  SQL_CURSOR_HOLD_OFF      	= 0;
  SQL_CURSOR_HOLD_DEFAULT  	= SQL_CURSOR_HOLD_ON;


// Options for SQL_NODESCRIBE_INPUT/SQL_NODESCRIBE_OUTPUT
  SQL_NODESCRIBE_ON         	= 1;
  SQL_NODESCRIBE_OFF        	= 0;
  SQL_NODESCRIBE_DEFAULT    	= SQL_NODESCRIBE_OFF;


// Options for SQLGetConnectOption/SQLSetConnectOption extensions
  SQL_WCHARTYPE               	= 1252;
  SQL_LONGDATA_COMPAT         	= 1253;
  SQL_CURRENT_SCHEMA          	= 1254;
  SQL_DB2EXPLAIN              	= 1258;
  SQL_DB2ESTIMATE             	= 1259;
  SQL_PARAMOPT_ATOMIC         	= 1260;
  SQL_STMTTXN_ISOLATION       	= 1261;
  SQL_MAXCONN                 	= 1262;

  SQL_ATTR_WCHARTYPE         	= SQL_WCHARTYPE;
  SQL_ATTR_LONGDATA_COMPAT   	= SQL_LONGDATA_COMPAT;
  SQL_ATTR_CURRENT_SCHEMA    	= SQL_CURRENT_SCHEMA;
  SQL_ATTR_DB2EXPLAIN        	= SQL_DB2EXPLAIN;
  SQL_ATTR_DB2ESTIMATE       	= SQL_DB2ESTIMATE;
  SQL_ATTR_PARAMOPT_ATOMIC   	= SQL_PARAMOPT_ATOMIC;
  SQL_ATTR_STMTTXN_ISOLATION 	= SQL_STMTTXN_ISOLATION;
  SQL_ATTR_MAXCONN           	= SQL_MAXCONN;

// Options for SQLSetConnectOption, SQLSetEnvAttr
  SQL_CONNECTTYPE             	= 1255;
  SQL_SYNC_POINT              	= 1256;
  SQL_MINMEMORY_USAGE         	= 1263;
  SQL_CONN_CONTEXT            	= 1269;
  SQL_ATTR_INHERIT_NULL_CONNECT	= 1270;
  SQL_ATTR_FORCE_CONVERSION_ON_CLIENT	= 1275;

  SQL_ATTR_CONNECTTYPE        	= SQL_CONNECTTYPE;
  SQL_ATTR_SYNC_POINT         	= SQL_SYNC_POINT;
  SQL_ATTR_MINMEMORY_USAGE    	= SQL_MINMEMORY_USAGE;
  SQL_ATTR_CONN_CONTEXT       	= SQL_CONN_CONTEXT;

// Options for SQL_LONGDATA_COMPAT
  SQL_LD_COMPAT_YES           	= 1;
  SQL_LD_COMPAT_NO            	= 0;
  SQL_LD_COMPAT_DEFAULT       	= SQL_LD_COMPAT_NO;

// Options for SQL_PARAMOPT_ATOMIC
  SQL_ATOMIC_YES              	= 1;
  SQL_ATOMIC_NO               	= 0;
  SQL_ATOMIC_DEFAULT          	= SQL_ATOMIC_YES;

// Options for SQL_CONNECT_TYPE
  SQL_CONCURRENT_TRANS        	= 1;
  SQL_COORDINATED_TRANS       	= 2;
  SQL_CONNECTTYPE_DEFAULT     	= SQL_CONCURRENT_TRANS;

// Options for SQL_SYNCPOINT
  SQL_ONEPHASE                	= 1;
  SQL_TWOPHASE                	= 2;
  SQL_SYNCPOINT_DEFAULT       	= SQL_ONEPHASE;

// Options for SQL_DB2ESTIMATE
  SQL_DB2ESTIMATE_ON          	= 1;
  SQL_DB2ESTIMATE_OFF         	= 0;
  SQL_DB2ESTIMATE_DEFAULT     	= SQL_DB2ESTIMATE_OFF;

// Options for SQL_DB2EXPLAIN
  SQL_DB2EXPLAIN_OFF            = $00000000;
  SQL_DB2EXPLAIN_SNAPSHOT_ON   	= $00000001;
  SQL_DB2EXPLAIN_MODE_ON       	= $00000002;
  SQL_DB2EXPLAIN_SNAPSHOT_MODE_ON= SQL_DB2EXPLAIN_SNAPSHOT_ON+SQL_DB2EXPLAIN_MODE_ON;
  SQL_DB2EXPLAIN_ON            	= SQL_DB2EXPLAIN_SNAPSHOT_ON;
  SQL_DB2EXPLAIN_DEFAULT       	= SQL_DB2EXPLAIN_OFF;

{/* Options for SQL_WCHARTYPE
 * Note that you can only specify SQL_WCHARTYPE_CONVERT if you have an
 * external compile flag SQL_WCHART_CONVERT defined
 */
#ifdef SQL_WCHART_CONVERT
#define SQL_WCHARTYPE_CONVERT        1
#endif
#define SQL_WCHARTYPE_NOCONVERT      0
#define SQL_WCHARTYPE_DEFAULT        SQL_WCHARTYPE_NOCONVERT
}

//  LOB file reference options
  SQL_FILE_READ      	=  2;	// Input file to read from
  SQL_FILE_CREATE    	=  8;	// Output file - new file to be created
  SQL_FILE_OVERWRITE 	= 16;  	// Output file - overwrite existing file or create a new file if it doesn't exist
  SQL_FILE_APPEND    	= 32;	// Output file - append to an existing file or create a new file if it doesn't exist

// Source of string for SQLGetLength(), SQLGetPosition(),
// and SQLGetSubstring().
  SQL_FROM_LOCATOR     	= 2;
  SQL_FROM_LITERAL     	= 3;


type
  ESDDb2Error = class(ESDOdbcError);

{ TDB2Functions }
{*******************************************************************************
 * DB2 specific CLI APIs (sqlcli1.h)
 ******************************************************************************}
  TSQLBindFileToCol =
  		function  (hStmt: SQLHSTMT; icol: SQLUSMALLINT;
                   FileName: TSDCharPtr; var FileNameLength: SQLSMALLINT;
                   var  FileOptions: SQLUINTEGER; MaxFileNameLength: SQLSMALLINT;
                   var StringLength, IndicatorValue: SQLINTEGER): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}
  TSQLBindFileToParam =
  		function (hStmt: SQLHSTMT; ipar: SQLUSMALLINT; fSqlType: SQLSMALLINT;
                   FileName: TSDCharPtr; var FileNameLength: SQLSMALLINT;
                   var  FileOptions: SQLUINTEGER; MaxFileNameLength: SQLSMALLINT;
                   var IndicatorValue: SQLINTEGER): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}
  TSQLGetLength =
  		function (hStmt: SQLHSTMT; LocatorCType: SQLSMALLINT; Locator: SQLINTEGER;
                   var StringLength, IndicatorValue: SQLINTEGER): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}
  TSQLGetPosition =
  		function (hStmt: SQLHSTMT; LocatorCType: SQLSMALLINT;
                   SourceLocator, SearchLocator: SQLINTEGER;
                   SearchLiteral: TSDCharPtr; SearchLiteralLength: SQLINTEGER;
                   FromPosition: SQLUINTEGER; var LocatedAt: SQLUINTEGER;
                   var IndicatorValue: SQLINTEGER): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}
  TSQLGetSubString =
  		function (hStmt: SQLHSTMT; LocatorCType: SQLSMALLINT;
                   SourceLocator: SQLINTEGER; FromPosition, ForLength: SQLUINTEGER;
                   TargetCType: SQLSMALLINT; rgbValue: SQLPOINTER;
                   cbValueMax: SQLINTEGER; var StringLength, IndicatorValue: SQLINTEGER): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}
  TSQLSetColAttributes =
  		function (hStmt: SQLHSTMT; icol: SQLUSMALLINT;
                   szColName: TSDCharPtr; cbColName, fSQLType: SQLSMALLINT;
                   cbColDef: SQLUINTEGER; ibScale, fNullable: SQLSMALLINT): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}

{*******************************************************************************
 * APIs defined only by X/Open CLI (sqlcli1.h)
 ******************************************************************************}
  TSQLBindParam =
    		function(hStmt: SQLHSTMT; ParameterNumber: SQLUSMALLINT;
                     ValueType, ParameterType: SQLSMALLINT; LengthPrecision: SQLUINTEGER;
                     ParameterScale: SQLSMALLINT; ParameterValue: SQLPOINTER;
                     var StrLen_or_Ind: SQLINTEGER): SQLRETURN;{$IFNDEF XSQL_CLR} stdcall; {$ENDIF}
                     
	// adding DB2 specific CLI APIs
  TDB2Functions = class(TOdbcFunctions)
  private
    FSQLBindFileToCol:	TSQLBindFileToCol;
    FSQLBindFileToParam:TSQLBindFileToParam;
    FSQLGetLength:	TSQLGetLength;
    FSQLGetPosition:	TSQLGetPosition;
    FSQLGetSubString:	TSQLGetSubString;
    FSQLSetColAttributes:TSQLSetColAttributes;
    FSQLBindParam:	TSQLBindParam;
  public
    procedure SetApiCalls(ASqlLibModule: THandle); override;
    procedure ClearApiCalls; override;

    property SQLBindFileToCol:	TSQLBindFileToCol 	read FSQLBindFileToCol;
    property SQLBindFileToParam:TSQLBindFileToParam	read FSQLBindFileToParam;
    property SQLGetLength:	TSQLGetLength		read FSQLGetLength;
    property SQLGetPosition:	TSQLGetPosition		read FSQLGetPosition;
    property SQLGetSubString:	TSQLGetSubString	read FSQLGetSubString;
    property SQLSetColAttributes:TSQLSetColAttributes	read FSQLSetColAttributes;
    property SQLBindParam:	TSQLBindParam		read FSQLBindParam;
  end;

{ TIDB2Database }
  TIDB2Database = class(TICustomOdbcDatabase)
  private
    function GetCalls: TDB2Functions;
  protected
    procedure FreeSqlLib; override;
    procedure LoadSqlLib; override;
    procedure RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string); override;
  public
    function CreateSqlCommand: TISqlCommand; override;
    function GetAutoIncSQL: string; override;
    property Calls: TDB2Functions read GetCalls;
  end;

{ TIDB2Command }
  TIDB2Command = class(TICustomOdbcCommand)
  private
    function GetSqlDatabase: TIDB2Database;
  protected
    procedure Connect; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function SqlDataType(FieldType: TFieldType): Integer; override;
    
    property SqlDatabase: TIDB2Database read GetSqlDatabase;
  end;

const
  DefSqlApiDLL	= 'DB2CLI.DLL';

var
  SqlApiDLL: string;
  DB2Calls: TDB2Functions;

{$IFDEF XSQL_CLR}

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
                    pcbValue: SQLPOINTER): SQLRETURN; external;
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

//******* 		DB2 specific CLI APIs (sqlcli1.h)		********
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindFileToCol')]
function SQLBindFileToCol(hStmt: SQLHSTMT; icol: SQLUSMALLINT;
                FileName: TSDCharPtr; var FileNameLength: SQLSMALLINT;
                var  FileOptions: SQLUINTEGER; MaxFileNameLength: SQLSMALLINT;
                var StringLength, IndicatorValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindFileToParam')]
function SQLBindFileToParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; fSqlType: SQLSMALLINT;
                FileName: TSDCharPtr; var FileNameLength: SQLSMALLINT;
                var  FileOptions: SQLUINTEGER; MaxFileNameLength: SQLSMALLINT;
                var IndicatorValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetLength')]
function SQLGetLength(hStmt: SQLHSTMT; LocatorCType: SQLSMALLINT; Locator: SQLINTEGER;
                var StringLength, IndicatorValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetPosition')]
function SQLGetPosition(hStmt: SQLHSTMT; LocatorCType: SQLSMALLINT;
                SourceLocator, SearchLocator: SQLINTEGER;
                SearchLiteral: TSDCharPtr; SearchLiteralLength: SQLINTEGER;
                FromPosition: SQLUINTEGER; var LocatedAt: SQLUINTEGER;
                var IndicatorValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetSubString')]
function SQLGetSubString(hStmt: SQLHSTMT; LocatorCType: SQLSMALLINT;
                SourceLocator: SQLINTEGER; FromPosition, ForLength: SQLUINTEGER;
                TargetCType: SQLSMALLINT; rgbValue: SQLPOINTER;
                cbValueMax: SQLINTEGER; var StringLength, IndicatorValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetColAttributes')]
function SQLSetColAttributes(hStmt: SQLHSTMT; icol: SQLUSMALLINT;
                szColName: TSDCharPtr; cbColName, fSQLType: SQLSMALLINT;
                cbColDef: SQLUINTEGER; ibScale, fNullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindParam')]
function SQLBindParam(hStmt: SQLHSTMT; ParameterNumber: SQLUSMALLINT;
                     ValueType, ParameterType: SQLSMALLINT; LengthPrecision: SQLUINTEGER;
                     ParameterScale: SQLSMALLINT; ParameterValue: SQLPOINTER;
                     var StrLen_or_Ind: SQLINTEGER): SQLRETURN; external;
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

var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istDB2) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIDb2Database.Create( ADbParams );
end;

{ TDB2Functions }
procedure TDB2Functions.SetApiCalls(ASqlLibModule: THandle);
begin
  FLibHandle := ASqlLibModule;
{$IFDEF XSQL_CLR}
	// there are used functions, which imported in the current unit
  FSQLAllocConnect    	:= SDDb2.SQLAllocConnect;
  FSQLAllocEnv        	:= SDDb2.SQLAllocEnv;
  FSQLAllocHandle     	:= SDDb2.SQLAllocHandle;
  FSQLAllocStmt       	:= SDDb2.SQLAllocStmt;
  FSQLBindCol         	:= SDDb2.SQLBindCol;
  FSQLCancel          	:= SDDb2.SQLCancel;
  FSQLCloseCursor     	:= SDDb2.SQLCloseCursor;
  FSQLColAttribute    	:= SDDb2.SQLColAttribute;
  FSQLColumns         	:= SDDb2.SQLColumns;
  FSQLConnect         	:= SDDb2.SQLConnect;
  FSQLCopyDesc        	:= SDDb2.SQLCopyDesc;
  FSQLDataSources     	:= SDDb2.SQLDataSources;
  FSQLDescribeCol     	:= SDDb2.SQLDescribeCol;
  FSQLDisconnect      	:= SDDb2.SQLDisconnect;
  FSQLEndTran         	:= SDDb2.SQLEndTran;
  FSQLError           	:= SDDb2.SQLError;
  FSQLExecDirect      	:= SDDb2.SQLExecDirect;
  FSQLExecute         	:= SDDb2.SQLExecute;
  FSQLFetch           	:= SDDb2.SQLFetch;
  FSQLFetchScroll     	:= SDDb2.SQLFetchScroll;
  FSQLFreeConnect     	:= SDDb2.SQLFreeConnect;
  FSQLFreeEnv         	:= SDDb2.SQLFreeEnv;
  FSQLFreeHandle      	:= SDDb2.SQLFreeHandle;
  FSQLFreeStmt        	:= SDDb2.SQLFreeStmt;
  FSQLGetConnectAttr  	:= SDDb2.SQLGetConnectAttr;
  FSQLGetConnectOption	:= SDDb2.SQLGetConnectOption;
  FSQLGetCursorName   	:= SDDb2.SQLGetCursorName;
  FSQLGetData         	:= SDDb2.SQLGetData;
  FSQLGetDescField    	:= SDDb2.SQLGetDescField;
  FSQLGetDescRec      	:= SDDb2.SQLGetDescRec;
  FSQLGetDiagField    	:= SDDb2.SQLGetDiagField;
  FSQLGetDiagRec      	:= SDDb2.SQLGetDiagRec;
  FSQLGetEnvAttr      	:= SDDb2.SQLGetEnvAttr;
  FSQLGetFunctions    	:= SDDb2.SQLGetFunctions;
  FSQLGetInfo         	:= SDDb2.SQLGetInfo;
  FSQLGetStmtAttr     	:= SDDb2.SQLGetStmtAttr;
  FSQLGetStmtOption   	:= SDDb2.SQLGetStmtOption;
  FSQLGetTypeInfo     	:= SDDb2.SQLGetTypeInfo;
  FSQLNumResultCols   	:= SDDb2.SQLNumResultCols;
  FSQLParamData       	:= SDDb2.SQLParamData;
  FSQLPrepare         	:= SDDb2.SQLPrepare;
  FSQLPutData         	:= SDDb2.SQLPutData;
  FSQLRowCount        	:= SDDb2.SQLRowCount;
  FSQLSetConnectAttr  	:= SDDb2.SQLSetConnectAttr;
  FSQLSetConnectOption	:= SDDb2.SQLSetConnectOption;
  FSQLSetCursorName   	:= SDDb2.SQLSetCursorName;
  FSQLSetDescField    	:= SDDb2.SQLSetDescField;
  FSQLSetDescRec      	:= SDDb2.SQLSetDescRec;
  FSQLSetEnvAttr      	:= SDDb2.SQLSetEnvAttr;
  FSQLSetParam        	:= SDDb2.SQLSetParam;
  FSQLSetStmtAttr     	:= SDDb2.SQLSetStmtAttr;
  FSQLSetStmtOption   	:= SDDb2.SQLSetStmtOption;
  FSQLSpecialColumns  	:= SDDb2.SQLSpecialColumns;
  FSQLStatistics      	:= SDDb2.SQLStatistics;
  FSQLTables          	:= SDDb2.SQLTables;
  FSQLTransact        	:= SDDb2.SQLTransact;

  FSQLBrowseConnect   	:= SDDb2.SQLBrowseConnect;
  FSQLBulkOperations  	:= SDDb2.SQLBulkOperations;
  FSQLColAttributes   	:= SDDb2.SQLColAttributes;
  FSQLColumnPrivileges	:= SDDb2.SQLColumnPrivileges;
  FSQLDescribeParam   	:= SDDb2.SQLDescribeParam;
  FSQLExtendedFetch   	:= SDDb2.SQLExtendedFetch;
  FSQLForeignKeys   	:= SDDb2.SQLForeignKeys;
  FSQLMoreResults     	:= SDDb2.SQLMoreResults;
  FSQLNativeSql       	:= SDDb2.SQLNativeSql;
  FSQLNumParams       	:= SDDb2.SQLNumParams;
  FSQLParamOptions    	:= SDDb2.SQLParamOptions;
  FSQLPrimaryKeys     	:= SDDb2.SQLPrimaryKeys;
  FSQLProcedureColumns	:= SDDb2.SQLProcedureColumns;
  FSQLProcedures      	:= SDDb2.SQLProcedures;
  FSQLSetPos  		:= SDDb2.SQLSetPos;
  FSQLTablePrivileges 	:= SDDb2.SQLTablePrivileges;
  FSQLDrivers 		:= SDDb2.SQLDrivers;
  FSQLBindParameter   	:= SDDb2.SQLBindParameter;
  FSQLDriverConnect   	:= SDDb2.SQLDriverConnect;
		// DB2 specific CLI APIs (sqlcli1.h)
  FSQLBindFileToCol  	:= SDDb2.SQLBindFileToCol;
  FSQLBindFileToParam	:= SDDb2.SQLBindFileToParam;
  FSQLGetLength      	:= SDDb2.SQLGetLength;
  FSQLGetPosition    	:= SDDb2.SQLGetPosition;
  FSQLGetSubString   	:= SDDb2.SQLGetSubString;
  FSQLSetColAttributes	:= SDDb2.SQLSetColAttributes;
  FSQLBindParam       	:= SDDb2.SQLBindParam;
{$ELSE}
  inherited SetApiCalls( hSqlLibModule );
		// DB2 specific CLI APIs (sqlcli1.h)
  @FSQLBindFileToCol  	:= GetProcAddress(hSqlLibModule, 'SQLBindFileToCol');
  @FSQLBindFileToParam	:= GetProcAddress(hSqlLibModule, 'SQLBindFileToParam');
  @FSQLGetLength      	:= GetProcAddress(hSqlLibModule, 'SQLGetLength');
  @FSQLGetPosition    	:= GetProcAddress(hSqlLibModule, 'SQLGetPosition');
  @FSQLGetSubString   	:= GetProcAddress(hSqlLibModule, 'SQLGetSubString');
  @FSQLSetColAttributes	:= GetProcAddress(hSqlLibModule, 'SQLSetColAttributes');
		// APIs defined only by X/Open CLI (sqlcli1.h)
  @FSQLBindParam       := GetProcAddress(hSqlLibModule, 'SQLBindParam');
{$ENDIF}
end;

procedure TDB2Functions.ClearApiCalls;
begin
  inherited ClearApiCalls;
		// DB2 specific CLI APIs (sqlcli1.h)
  @FSQLBindFileToCol  	:= nil;
  @FSQLBindFileToParam	:= nil;
  @FSQLGetLength      	:= nil;
  @FSQLGetPosition    	:= nil;
  @FSQLGetSubString   	:= nil;
  @FSQLSetColAttributes:= nil;
		// APIs defined only by X/Open CLI (sqlcli1.h)
  @FSQLBindParam      	:= nil;
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
      DB2Calls.SetApiCalls( hSqlLibModule );
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
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDLL ]);
      Dec(SqlLibRefCount);
      DB2Calls.ClearApiCalls;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

{ TIDB2Database }
function TIDB2Database.CreateSqlCommand: TISqlCommand;
begin
  Result := TIDB2Command.Create( Self );
end;

function TIDB2Database.GetCalls: TDB2Functions;
begin
  Result := FCalls as TDB2Functions;
end;

procedure TIDB2Database.FreeSqlLib;
begin
  XSDb2.FreeSqlLib;
end;

procedure TIDB2Database.LoadSqlLib;
begin
  XSDb2.LoadSqlLib;

  FCalls := DB2Calls;
end;

procedure TIDB2Database.RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string);
begin
  raise ESDDb2Error.CreateWithSqlState(AErrorCode, ANativeError, AMsg, ASqlState);
end;

function TIDB2Database.GetAutoIncSQL: string;
begin
  Result := DB2_SelectAutoIncField;
end;


{ TIDB2Command }
function TIDB2Command.GetSqlDatabase: TIDB2Database;
begin
  Result := (inherited SqlDatabase) as TIDB2Database;
end;

procedure TIDB2Command.Connect;
begin
  inherited;

	// specifies the number of values for each parameter (DB2 CLI v5)
  Check( SqlDatabase.OdbcSetStmtAttr( Handle, SQL_ATTR_PARAMSET_SIZE, SQLPOINTER( 1 ), 0 ) );
	// (DB2 CLI v5)
  Check( SqlDatabase.OdbcSetStmtAttr( Handle, SQL_ATTR_USE_BOOKMARKS, SQLPOINTER( SQL_UB_OFF ), 0 ) );

	// Note: This option is an IBM extension
  Check(
  	SqlDatabase.OdbcSetStmtAttr( Handle, SQL_ATTR_CURSOR_HOLD,
        	SQLPOINTER( SQL_CURSOR_HOLD_ON ), 0 )
        );
	// Note: This is an IBM defined extension. (DB2 CLI v5)
  Check(
  	SqlDatabase.OdbcSetStmtAttr( Handle, SQL_ATTR_DEFERRED_PREPARE,
        	SQLPOINTER( SQL_DEFERRED_PREPARE_OFF ), 0 )
        );
end;

function TIDB2Command.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
	// DB2 data types
    SQL_GRAPHIC,
    SQL_VARGRAPHIC:	Result := ftVarBytes;
    SQL_LONGVARGRAPHIC,
    SQL_BLOB:		Result := ftBlob;
    SQL_CLOB,
    SQL_DBCLOB:		Result := ftMemo;
  else
    Result := inherited FieldDataType( ExtDataType );
  end;
end;

function TIDB2Command.SqlDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to SQL Data Type(DB2) }
  Db2SqlDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	SQL_CHAR, SQL_SMALLINT, SQL_INTEGER, SQL_INTEGER, SQL_SMALLINT,
	// ftFloat, ftCurrency, ftBCD, 	ftDate, 	ftTime
        SQL_DOUBLE, SQL_DOUBLE, 0, SQL_TYPE_DATE, SQL_TYPE_TIME,
        // ftDateTime, 		ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SQL_TYPE_TIMESTAMP, SQL_BINARY, SQL_BINARY, SQL_INTEGER, SQL_BLOB,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SQL_CLOB, SQL_BLOB, SQL_CLOB, 	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	SQL_BIGINT,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
{$IFDEF XSQL_VCL10},
        0,      0,      0,      0
{$ENDIF}
        );
begin
  Result := Db2SqlDataTypeMap[FieldType];
end;


initialization
  hSqlLibModule	:= 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;  
  DB2Calls 	:= TDB2Functions.Create;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
  DB2Calls.Free;
end.
