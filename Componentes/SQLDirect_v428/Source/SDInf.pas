
{**********************************************************}
{							   }
{       Delphi SQLDirect Component Library		   }
{	Informix CLI v2.8 Interface Unit 		   }
{                                                          }
{       Copyright (c) 1997,2005 by Yuri Sheino		   }
{                                                          }
{**********************************************************}
{$I SqlDir.inc}
unit SDInf {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, SyncObjs,
{$IFDEF SD_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  SDConsts, SDCommon, SDOdbc;

{********************************************************************
** INFXCLI.H - This is the the main include for Informix-CLI
**             applications.
**
*********************************************************************}
const

	// For extended errors
  SQL_DIAG_ISAM_ERROR	= 13;
  SQL_DIAG_XA_ERROR  	= 14;

// START -- Q+E Software's SQLSetStmtOption extensions (1040 to 1139)
// defines here for backwards compatibility

  SQL_STMTOPT_START	= 1040;

	// Get the rowid for the last row inserted
  SQL_GET_ROWID		= (SQL_STMTOPT_START+8);

	// Get the value for the serial column in the last row inserted
  SQL_GET_SERIAL_VALUE	= (SQL_STMTOPT_START+9);

// END -- Q+E Software's SQLSetStmtOption extensions (1040 to 1139)

{*
**    Informix extensions
*}

	// Informix Column Attributes Flags Definitions
  FDNULLABLE	= $0001;	// null allowed in field
  FDDISTINCT   	= $0002;	// distinct of all
  FDDISTLVARCHAR= $0004;	// distinct of SQLLVARCHAR
  FDDISTBOOLEAN	= $0008;	// distinct of SQLBOOL
  FDDISTSIMP   	= $0010;	// distinct of simple type
  FDCSTTYPE    	= $0020;	// constructor type
  FDNAMED      	= $0040;	// named row type

{
#define ISNULLABLE( flags )       ( flags & FDNULLABLE ? 1 : 0)
#define ISDISTINCT( flags )       ( flags & FDDISTINCT ? 1 : 0)
}

	// Informix Type Estensions
  SQL_INFX_UDT_FIXED  		= -100;
  SQL_INFX_UDT_VARYING 		= -101;
  SQL_INFX_UDT_BLOB    		= -102;
  SQL_INFX_UDT_CLOB    		= -103;
  SQL_INFX_UDT_LVARCHAR		= -104;
  SQL_INFX_RC_ROW      		= -105;
  SQL_INFX_RC_COLLECTION	= -106;
  SQL_INFX_RC_LIST     		= -107;
  SQL_INFX_RC_SET      		= -108;
  SQL_INFX_RC_MULTISET 		= -109;
  SQL_INFX_UNSUPPORTED 		= -110;

	// Informix Connect Attributes Extensions
  SQL_OPT_LONGID                    	= 2251;
  SQL_INFX_ATTR_LONGID                 	= SQL_OPT_LONGID;
  SQL_INFX_ATTR_LEAVE_TRAILING_SPACES  	= 2252;
  SQL_INFX_ATTR_DEFAULT_UDT_FETCH_TYPE 	= 2253;
  SQL_INFX_ATTR_ENABLE_SCROLL_CURSORS  	= 2254;
  SQL_ENABLE_INSERT_CURSOR             	= 2255;
  SQL_INFX_ATTR_ENABLE_INSERT_CURSORS  	= SQL_ENABLE_INSERT_CURSOR;
  SQL_INFX_ATTR_OPTIMIZE_AUTOCOMMIT    	= 2256;
  SQL_INFX_ATTR_ODBC_TYPES_ONLY        	= 2257;

	// Informix Descriptor Extensions
  SQL_INFX_ATTR_FLAGS                  	= 1900; // UDWORD
  SQL_INFX_ATTR_EXTENDED_TYPE_CODE     	= 1901; // UDWORD
  SQL_INFX_ATTR_EXTENDED_TYPE_NAME     	= 1902; // UCHAR ptr
  SQL_INFX_ATTR_EXTENDED_TYPE_OWNER    	= 1903; // UCHAR ptr
  SQL_INFX_ATTR_EXTENDED_TYPE_ALIGNMENT	= 1904; // UDWORD
  SQL_INFX_ATTR_SOURCE_TYPE_CODE       	= 1905;	// UDWORD

	// Informix Statement Attributes Extensions
  SQL_VMB_CHAR_LEN		= 2325;
  SQL_INFX_ATTR_VMB_CHAR_LEN	= SQL_VMB_CHAR_LEN;

	// Informix fOption, SQL_VMB_CHAR_LEN vParam
  SQL_VMB_CHAR_EXACT     	= 0;
  SQL_VMB_CHAR_ESTIMATE        	= 1;

	// Informix row/collection traversal constants
  SQL_INFX_RC_NEXT  		= 1;
  SQL_INFX_RC_PRIOR 		= 2;
  SQL_INFX_RC_FIRST 		= 3;
  SQL_INFX_RC_LAST    		= 4;
  SQL_INFX_RC_ABSOLUTE		= 5;
  SQL_INFX_RC_RELATIVE		= 6;
  SQL_INFX_RC_CURRENT 		= 7;

{*******************************************************************************
 * Large Object (LO) related structures
 *
 * LO_SPEC: Large object spec structure
 * It is used for creating smartblobs. The user may examin and/or set certain
 * fields of LO_SPEC by using ifx_lo_spec[set|get]_* accessor functions.
 *
 * LO_PTR: Large object pointer structure
 * Identifies the LO and provides ancillary, security-related information.
 *
 * LO_STAT: Large object stat structure
 * It is used in querying attribtes of smartblobs. The user may examin fields
 * herein by using ifx_lo_stat[set|get]_* accessor functions.
 *
 * These structures are opaque to the user. Accessor functions are provided
 * for these structures.
 ******************************************************************************}

	// Informix GetInfo Extensions to obtain length of LO related structures
  SQL_INFX_LO_SPEC_LENGTH	= 2250; 	// UWORD
  SQL_INFX_LO_PTR_LENGTH       	= 2251; 	// UWORD
  SQL_INFX_LO_STAT_LENGTH      	= 2252; 	// UWORD

{******************************************************************************
 * LO Open flags: (see documentation for further explanation)
 *
 * LO_APPEND   - Positions the seek position to end-of-file + 1. By itself,
 *               it is equivalent to write only mode followed by a seek to the
 *               end of large object. Read opeartions will fail.
 *               You can OR the LO_APPEND flag with another access mode.
 * LO_WRONLY   - Only write operations are valid on the data.
 * LO_RDONLY   - Only read operations are valid on the data.
 * LO_RDWR     - Both read and write operations are valid on the data.
 *
 * LO_RANDOM   - If set overrides optimizer decision. Indicates that I/O is
 *               random and that the system should not read-ahead.
 * LO_SEQUENTIAL - If set overrides optimizer decision. Indicates that
 *               reads are sequential in either forward or reverse direction.
 *
 * LO_FORWARD  - Only used for sequential access. Indicates that the sequential
 *               access will be in a forward direction, i.e. from low offset
 *               to higher offset.
 * LO_REVERSE  - Only used for sequential access. Indicates that the sequential
 *               access will be in a reverse direction.
 *
 * LO_BUFFER   - If set overrides optimizer decision. I/O goes through the
 *               buffer pool.
 * LO_NOBUFFER - If set then I/O does not use the buffer pool.
 ******************************************************************************}

  LO_APPEND   		= $01;
  LO_WRONLY    		= $02;
  LO_RDONLY    		= $04;		// default
  LO_RDWR      		= $08;

  LO_RANDOM    		= $20;    	// default is determined by optimizer
  LO_SEQUENTIAL		= $40;    	// default is determined by optimizer

  LO_FORWARD   		= $080;    	// default
  LO_REVERSE   		= $100;

  LO_BUFFER    		= $200;   	// default is determined by optimizer
  LO_NOBUFFER  		= $400;   	// default is determined by optimizer

  LO_DIRTY_READ		= $010;
  LO_NODIRTY_READ	= $800;

{*******************************************************************************
 * LO create-time flags:
 *
 * Bitmask - Set/Get via ifx_lo_specset_flags() on LO_SPEC.
 ******************************************************************************}

  LO_ATTR_LOG                 	= $0001;
  LO_ATTR_NOLOG               	= $0002;
  LO_ATTR_DELAY_LOG           	= $0004;
  LO_ATTR_KEEP_LASTACCESS_TIME	= $0008;
  LO_ATTR_NOKEEP_LASTACCESS_TIME= $0010;
  LO_ATTR_HIGH_INTEG          	= $0020;
  LO_ATTR_MODERATE_INTEG      	= $0040;

{*******************************************************************************
 * Symbolic constants for the "lseek" routine
 ******************************************************************************}

  LO_SEEK_SET	= 0;	// Set curr. pos. to "offset"           
  LO_SEEK_CUR 	= 1;   	// Set curr. pos. to current + "offset" 
  LO_SEEK_END 	= 2;   	// Set curr. pos. to EOF + "offset"

{*******************************************************************************
 * Intersolv specific infoTypes for SQLGetInfo
 ******************************************************************************}

  SQL_RESERVED_WORDS		= 1011;
  SQL_PSEUDO_COLUMNS	       	= 1012;
  SQL_FROM_RESERVED_WORDS      	= 1013;
  SQL_WHERE_CLAUSE_TERMINATORS 	= 1014;
  SQL_COLUMN_FIRST_CHARS       	= 1015;
  SQL_COLUMN_MIDDLE_CHARS      	= 1016;
  SQL_TABLE_FIRST_CHARS	       	= 1018;
  SQL_TABLE_MIDDLE_CHARS       	= 1019;
  SQL_FAST_SPECIAL_COLUMNS     	= 1021;
  SQL_ACCESS_CONFLICTS	       	= 1022;
  SQL_LOCKING_SYNTAX	       	= 1023;
  SQL_LOCKING_DURATION	       	= 1024;
  SQL_RECORD_OPERATIONS	       	= 1025;
  SQL_QUALIFIER_SYNTAX	       	= 1026;

type
  HINFX_RC	= SQLPOINTER;		// row & collection handle

type
{ TInfFunctions }
  TInfFunctions = class(TOdbcFunctions)
  public
    procedure SetApiCalls(ASqlLibModule: THandle); override;
    procedure ClearApiCalls; override;
  end;

  ESDInfError = class(ESDOdbcError);

{ TIInfDatabase }
  TIInfDatabase = class(TICustomOdbcDatabase)
  private
    function GetCalls: TInfFunctions;
  protected
    procedure FreeSqlLib; override;
    procedure LoadSqlLib; override;
    procedure RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string); override;

    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
  public
    function CreateSqlCommand: TISqlCommand; override;
    property Calls: TInfFunctions read GetCalls;
  end;

{ TIInfCommand }
  TIInfCommand = class(TICustomOdbcCommand)
  private
    function GetSqlDatabase: TIInfDatabase;
  protected
    property SqlDatabase: TIInfDatabase read GetSqlDatabase;
  end;

const
  DefSqlApiDLL_A= 'ICLIT09A.DLL';
  DefSqlApiDLL_B= 'ICLIT09B.DLL';
  DefSqlApiDLL	= 'ICLIT09B.DLL;ICLIT09A.DLL';

var
  SqlApiDLL: string;
  InfCalls: TInfFunctions;

{$IFDEF SD_CLR}
// ===============    import functions from DefSqlApiDLL_A   ===================
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocConnect')]
function SQLAllocConnect(henv :SQLHENV; var hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocEnv')]
function SQLAllocEnv(var henv: SQLHENV): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocHandle')]
function SQLAllocHandle(fHandleType: SQLSMALLINT; hInput: SQLHANDLE;
    var hOutput: SQLHANDLE): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocStmt')]
function SQLAllocStmt(hdbc: SQLHDBC; var hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindCol')]
function SQLBindCol(hstmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
                    rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                    pcbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCancel')]
function SQLCancel(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCloseCursor')]
function SQLCloseCursor(hStmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColAttribute')]
function SQLColAttribute(hstmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT;
                    rgbDesc: SQLPOINTER; cbDescMax: SQLSMALLINT;
                    pcbDesc: SQLPOINTER; pfDesc: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColumns')]
function SQLColumns(hStmt: SQLHSTMT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLConnect')]
function SQLConnect(hdbc: SQLHDBC; szDSN: TSDCharPtr; cbDSN: SQLSMALLINT;
                    szUID: TSDCharPtr; cbUID: SQLSMALLINT;
                    szAuthStr: TSDCharPtr; cbAuthStr: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCopyDesc')]
function SQLCopyDesc(hDescSource: SQLHDESC; hDescTarget: SQLHDESC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDataSources')]
function SQLDataSources(hEnv: SQLHENV; fDirection: SQLUSMALLINT;
                    szDSN: TSDCharPtr; cbDSNMax: SQLSMALLINT; var cbDSN: SQLSMALLINT;
                    szDescription: TSDCharPtr; cbDescriptionMax: SQLSMALLINT;
                    var cbDescription: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDescribeCol')]
function SQLDescribeCol(hstmt: SQLHSTMT; icol: SQLUSMALLINT;
                    szColName: TSDCharPtr; cbColNameMax: SQLSMALLINT; var cbColName, fSqlType: SQLSMALLINT;
                    var cbColDef: SQLUINTEGER; var ibScale, fNullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDisconnect')]
function SQLDisconnect(hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLEndTran')]
function SQLEndTran(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; fType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLError')]
function SQLError(henv: SQLHENV; hdbc: SQLHDBC; hstmt: SQLHSTMT;
            szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
            szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
            var cbErrorMsg: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExecDirect')]
function SQLExecDirect(hstmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExecute')]
function SQLExecute(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFetch')]
function SQLFetch(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFetchScroll')]
function SQLFetchScroll(hStmt: SQLHSTMT;
	    FetchOrientation: SQLSMALLINT; FetchOffset: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeConnect')]
function SQLFreeConnect(hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeEnv')]
function SQLFreeEnv(henv: SQLHENV): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeHandle')]
function SQLFreeHandle(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeStmt')]
function SQLFreeStmt(hstmt: SQLHSTMT; fOption: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetConnectAttr')]
function SQLGetConnectAttr(hDbc: SQLHDBC; Attribute: SQLINTEGER; Value: SQLPOINTER;
            BufferLength: SQLINTEGER; pStringLength: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetConnectOption')]
function SQLGetConnectOption(hDbc: SQLHDBC; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetCursorName')]
function SQLGetCursorName(hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursorMax: SQLSMALLINT;
            var cbCursor: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetData')]
function SQLGetData(hStmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
            rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
            var cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDescField')]
function SQLGetDescField(DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
            Value: SQLPOINTER; BufferLength: SQLINTEGER;
            var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDescRec')]
function SQLGetDescRec(DescriptorHandle: SQLHDESC; RecNumber: SQLSMALLINT;
            Name: TSDCharPtr; BufferLength: SQLSMALLINT; var StringLength, RecType, RecSubType: SQLSMALLINT;
            var Length: SQLINTEGER; var Precision, Scale, Nullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDiagField')]
function SQLGetDiagField(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
            fDiagIdentifier: SQLSMALLINT; var cbDiagInfo: SQLINTEGER;
            cbDiagInfoMax: SQLSMALLINT; pcbDiagInfo: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDiagRec')]
function SQLGetDiagRec(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
               szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
               szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
               var cbErrorMsg: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetEnvAttr')]
function SQLGetEnvAttr(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
    		BufLen: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetFunctions')]
function SQLGetFunctions(hDbc: SQLHDBC; fFunction: SQLUSMALLINT; var fExists: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetInfo')]
function SQLGetInfo(hDbc: SQLHDBC; fInfoType: SQLUSMALLINT; rgbInfoValue: SQLPOINTER;
               cbInfoValueMax: SQLSMALLINT; var cbInfoValue: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetStmtAttr')]
function SQLGetStmtAttr(hStmt: SQLHSTMT; Attribute: SQLINTEGER; Value: SQLPOINTER;
               BufferLength: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetStmtOption')]
function SQLGetStmtOption(hStmt: SQLHSTMT; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetTypeInfo')]
function SQLGetTypeInfo(hStmt: SQLHSTMT; fSqlType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNumResultCols')]
function SQLNumResultCols(hStmt: SQLHSTMT; var ccol: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLParamData')]
function SQLParamData(hStmt: SQLHSTMT; var gbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPrepare')]
function SQLPrepare(hStmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPutData')]
function SQLPutData(hStmt: SQLHSTMT; rgbValue: SQLPOINTER; cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLRowCount')]
function SQLRowCount(hStmt: SQLHSTMT; var crow: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetConnectAttr')]
function SQLSetConnectAttr(hDbc: SQLHDBC; fOption: SQLINTEGER;
        pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetConnectOption')]
function SQLSetConnectOption(hDbc: SQLHDBC; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetCursorName')]
function SQLSetCursorName(hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursor: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetDescField')]
function SQLSetDescField(DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
        Value: SQLPOINTER; BufferLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetDescRec')]
function SQLSetDescRec(DescriptorHandle: SQLHDESC; RecNumber, RecType, RecSubType: SQLSMALLINT;
        Length: SQLINTEGER; Precision, Scale: SQLSMALLINT;
        Data: SQLPOINTER; var StringLength, Indicator: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetEnvAttr')]
function SQLSetEnvAttr(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
	StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetParam')]
function SQLSetParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; fCType, fSqlType: SQLSMALLINT;
               cbParamDef: SQLUINTEGER; ibScale: SQLSMALLINT;
               rgbValue: SQLPOINTER; var cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetStmtAttr')]
function SQLSetStmtAttr(hStmt: SQLHSTMT; fOption: SQLINTEGER;
        pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetStmtOption')]
function SQLSetStmtOption(hStmt: SQLHSTMT; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSpecialColumns')]
function SQLSpecialColumns(hStmt: SQLHSTMT; fColType: SQLUSMALLINT;
        szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
        szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
        szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
        fScope, fNullable: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLStatistics')]
function SQLStatistics(hStmt: SQLHSTMT;
        szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
        szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
        szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
        fUnique, fAccuracy: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTables')]
function SQLTables(hStmt: SQLHSTMT;
               szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
               szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
               szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
               szTableType: TSDCharPtr; cbTableType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTransact')]
function SQLTransact(hEnv: SQLHENV; hDbc: SQLHDBC; fType: SQLUSMALLINT): SQLRETURN; external;
// ------------------	from SQLEXT.H		--------------------------------
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBrowseConnect')]
function SQLBrowseConnect(hDbc: SQLHDBC; szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
           	szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                var cbConnStrOut: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBulkOperations')]
function SQLBulkOperations(hStmt: SQLHSTMT; Operation: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColAttributes')]
function SQLColAttributes(hStmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT; rgbDesc: SQLPOINTER;
           	cbDescMax: SQLSMALLINT; var cbDesc: SQLSMALLINT; var fDesc: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColumnPrivileges')]
function SQLColumnPrivileges(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
           	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDescribeParam')]
function SQLDescribeParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; pfSqlType: SQLPOINTER;
           	var cbParamDef: SQLUINTEGER; pibScale, pfNullable: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExtendedFetch')]
function SQLExtendedFetch(hStmt: SQLHSTMT; fFetchType: SQLUSMALLINT; irow: SQLINTEGER;
           	var crow: SQLUINTEGER; var gfRowStatus: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLForeignKeys')]
function SQLForeignKeys(hStmt: SQLHSTMT; szPkCatalogName: TSDCharPtr; cbPkCatalogName: SQLSMALLINT;
           	szPkSchemaName: TSDCharPtr; cbPkSchemaName: SQLSMALLINT;
                szPkTableName: TSDCharPtr; cbPkTableName: SQLSMALLINT;
                szFkCatalogName: TSDCharPtr; cbFkCatalogName: SQLSMALLINT;
                szFkSchemaName: TSDCharPtr; cbFkSchemaName: SQLSMALLINT;
                szFkTableName: TSDCharPtr; cbFkTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLMoreResults')]
function SQLMoreResults(hStmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNativeSql')]
function SQLNativeSql(hDbc: SQLHDBC; szSqlStrIn: TSDCharPtr; cbSqlStrIn: SQLINTEGER;
			szSqlStr: TSDCharPtr; cbSqlStrMax: SQLINTEGER; var cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNumParams')]
function SQLNumParams(hStmt: SQLHSTMT; var cpar: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLParamOptions')]
function SQLParamOptions(hStmt: SQLHSTMT; crow: SQLUINTEGER; var irow: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPrimaryKeys')]
function SQLPrimaryKeys(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
			szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLProcedureColumns')]
function SQLProcedureColumns(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                        szProcName: TSDCharPtr; cbProcName: SQLSMALLINT;
			szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLProcedures')]
function SQLProcedures(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
			szProcName: TSDCharPtr; cbProcName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetPos')]
function SQLSetPos(hStmt: SQLHSTMT; irow, fOption, fLock: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTablePrivileges')]
function SQLTablePrivileges(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
           	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDrivers')]
function SQLDrivers(hEnv: SQLHENV; fDirection: SQLUSMALLINT; szDriverDesc: TSDCharPtr;
           	cbDriverDescMax: SQLSMALLINT; var cbDriverDesc: SQLSMALLINT;
                   szDriverAttributes: TSDCharPtr; cbDrvrAttrMax: SQLSMALLINT; var cbDrvrAttr: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindParameter')]
function SQLBindParameter(hStmt: SQLHSTMT; ipar: SQLUSMALLINT;
			fParamType, fCType, fSqlType: SQLSMALLINT;
			cbColDef: SQLUINTEGER; ibScale: SQLSMALLINT;
			rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                        pcbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_A, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDriverConnect')]
function SQLDriverConnect(hDbc: SQLHDBC; hWnd: SQLHWND;
             	        szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
                        szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                        var cbConnStrOut: SQLSMALLINT; fDriverCompletion: SQLUSMALLINT): SQLRETURN; external;

// ===============    import functions from DefSqlApiDLL_B   ===================
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocConnect')]
function B_SQLAllocConnect(henv :SQLHENV; var hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocEnv')]
function B_SQLAllocEnv(var henv: SQLHENV): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocHandle')]
function B_SQLAllocHandle(fHandleType: SQLSMALLINT; hInput: SQLHANDLE;
    var hOutput: SQLHANDLE): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLAllocStmt')]
function B_SQLAllocStmt(hdbc: SQLHDBC; var hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindCol')]
function B_SQLBindCol(hstmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
                    rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                    pcbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCancel')]
function B_SQLCancel(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCloseCursor')]
function B_SQLCloseCursor(hStmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColAttribute')]
function B_SQLColAttribute(hstmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT;
                    rgbDesc: SQLPOINTER; cbDescMax: SQLSMALLINT;
                    pcbDesc: SQLPOINTER; pfDesc: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColumns')]
function B_SQLColumns(hStmt: SQLHSTMT;
                    szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
                    szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                    szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                    szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLConnect')]
function B_SQLConnect(hdbc: SQLHDBC; szDSN: TSDCharPtr; cbDSN: SQLSMALLINT;
                    szUID: TSDCharPtr; cbUID: SQLSMALLINT;
                    szAuthStr: TSDCharPtr; cbAuthStr: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLCopyDesc')]
function B_SQLCopyDesc(hDescSource: SQLHDESC; hDescTarget: SQLHDESC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDataSources')]
function B_SQLDataSources(hEnv: SQLHENV; fDirection: SQLUSMALLINT;
                    szDSN: TSDCharPtr; cbDSNMax: SQLSMALLINT; var cbDSN: SQLSMALLINT;
                    szDescription: TSDCharPtr; cbDescriptionMax: SQLSMALLINT;
                    var cbDescription: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDescribeCol')]
function B_SQLDescribeCol(hstmt: SQLHSTMT; icol: SQLUSMALLINT;
                    szColName: TSDCharPtr; cbColNameMax: SQLSMALLINT; var cbColName, fSqlType: SQLSMALLINT;
                    var cbColDef: SQLUINTEGER; var ibScale, fNullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDisconnect')]
function B_SQLDisconnect(hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLEndTran')]
function B_SQLEndTran(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; fType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLError')]
function B_SQLError(henv: SQLHENV; hdbc: SQLHDBC; hstmt: SQLHSTMT;
            szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
            szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
            var cbErrorMsg: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExecDirect')]
function B_SQLExecDirect(hstmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExecute')]
function B_SQLExecute(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFetch')]
function B_SQLFetch(hstmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFetchScroll')]
function B_SQLFetchScroll(hStmt: SQLHSTMT;
	    FetchOrientation: SQLSMALLINT; FetchOffset: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeConnect')]
function B_SQLFreeConnect(hdbc: SQLHDBC): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeEnv')]
function B_SQLFreeEnv(henv: SQLHENV): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeHandle')]
function B_SQLFreeHandle(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLFreeStmt')]
function B_SQLFreeStmt(hstmt: SQLHSTMT; fOption: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetConnectAttr')]
function B_SQLGetConnectAttr(hDbc: SQLHDBC; Attribute: SQLINTEGER; Value: SQLPOINTER;
            BufferLength: SQLINTEGER; pStringLength: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetConnectOption')]
function B_SQLGetConnectOption(hDbc: SQLHDBC; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetCursorName')]
function B_SQLGetCursorName(hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursorMax: SQLSMALLINT;
            var cbCursor: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetData')]
function B_SQLGetData(hStmt: SQLHSTMT; icol: SQLUSMALLINT; fCType: SQLSMALLINT;
            rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
            var cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDescField')]
function B_SQLGetDescField(DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
            Value: SQLPOINTER; BufferLength: SQLINTEGER;
            var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDescRec')]
function B_SQLGetDescRec(DescriptorHandle: SQLHDESC; RecNumber: SQLSMALLINT;
            Name: TSDCharPtr; BufferLength: SQLSMALLINT; var StringLength, RecType, RecSubType: SQLSMALLINT;
            var Length: SQLINTEGER; var Precision, Scale, Nullable: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDiagField')]
function B_SQLGetDiagField(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
            fDiagIdentifier: SQLSMALLINT; var cbDiagInfo: SQLINTEGER;
            cbDiagInfoMax: SQLSMALLINT; pcbDiagInfo: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetDiagRec')]
function B_SQLGetDiagRec(fHandleType: SQLSMALLINT; hHandle: SQLHANDLE; iRecNumber: SQLSMALLINT;
               szSqlState: TSDCharPtr; var fNativeError: SQLINTEGER;
               szErrorMsg: TSDCharPtr; cbErrorMsgMax: SQLSMALLINT;
               var cbErrorMsg: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetEnvAttr')]
function B_SQLGetEnvAttr(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
    		BufLen: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetFunctions')]
function B_SQLGetFunctions(hDbc: SQLHDBC; fFunction: SQLUSMALLINT; var fExists: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetInfo')]
function B_SQLGetInfo(hDbc: SQLHDBC; fInfoType: SQLUSMALLINT; rgbInfoValue: SQLPOINTER;
               cbInfoValueMax: SQLSMALLINT; var cbInfoValue: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetStmtAttr')]
function B_SQLGetStmtAttr(hStmt: SQLHSTMT; Attribute: SQLINTEGER; Value: SQLPOINTER;
               BufferLength: SQLINTEGER; var StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetStmtOption')]
function B_SQLGetStmtOption(hStmt: SQLHSTMT; fOption: SQLUSMALLINT; pvParam: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLGetTypeInfo')]
function B_SQLGetTypeInfo(hStmt: SQLHSTMT; fSqlType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNumResultCols')]
function B_SQLNumResultCols(hStmt: SQLHSTMT; var ccol: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLParamData')]
function B_SQLParamData(hStmt: SQLHSTMT; var gbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPrepare')]
function B_SQLPrepare(hStmt: SQLHSTMT; szSqlStr: TSDCharPtr; cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPutData')]
function B_SQLPutData(hStmt: SQLHSTMT; rgbValue: SQLPOINTER; cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLRowCount')]
function B_SQLRowCount(hStmt: SQLHSTMT; var crow: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetConnectAttr')]
function B_SQLSetConnectAttr(hDbc: SQLHDBC; fOption: SQLINTEGER;
        pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetConnectOption')]
function B_SQLSetConnectOption(hDbc: SQLHDBC; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetCursorName')]
function B_SQLSetCursorName(hStmt: SQLHSTMT; szCursor: TSDCharPtr; cbCursor: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetDescField')]
function B_SQLSetDescField(DescriptorHandle: SQLHDESC; RecNumber, FieldIdentifier: SQLSMALLINT;
        Value: SQLPOINTER; BufferLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetDescRec')]
function B_SQLSetDescRec(DescriptorHandle: SQLHDESC; RecNumber, RecType, RecSubType: SQLSMALLINT;
        Length: SQLINTEGER; Precision, Scale: SQLSMALLINT;
        Data: SQLPOINTER; var StringLength, Indicator: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetEnvAttr')]
function B_SQLSetEnvAttr(hEnv: SQLHENV; Attr: SQLINTEGER; Value: SQLPOINTER;
	StringLength: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetParam')]
function B_SQLSetParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; fCType, fSqlType: SQLSMALLINT;
               cbParamDef: SQLUINTEGER; ibScale: SQLSMALLINT;
               rgbValue: SQLPOINTER; var cbValue: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetStmtAttr')]
function B_SQLSetStmtAttr(hStmt: SQLHSTMT; fOption: SQLINTEGER;
        pvParam: SQLPOINTER; fStrLen: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetStmtOption')]
function B_SQLSetStmtOption(hStmt: SQLHSTMT; fOption: SQLUSMALLINT; vParam: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSpecialColumns')]
function B_SQLSpecialColumns(hStmt: SQLHSTMT; fColType: SQLUSMALLINT;
        szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
        szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
        szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
        fScope, fNullable: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLStatistics')]
function B_SQLStatistics(hStmt: SQLHSTMT;
        szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
        szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
        szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
        fUnique, fAccuracy: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTables')]
function B_SQLTables(hStmt: SQLHSTMT;
               szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
               szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
               szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
               szTableType: TSDCharPtr; cbTableType: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTransact')]
function B_SQLTransact(hEnv: SQLHENV; hDbc: SQLHDBC; fType: SQLUSMALLINT): SQLRETURN; external;
// ------------------	from SQLEXT.H		--------------------------------
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBrowseConnect')]
function B_SQLBrowseConnect(hDbc: SQLHDBC; szConnStrIn: TSDCharPtr; cbConnStrIn: SQLSMALLINT;
           	szConnStrOut: TSDCharPtr; cbConnStrOutMax: SQLSMALLINT;
                var cbConnStrOut: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBulkOperations')]
function B_SQLBulkOperations(hStmt: SQLHSTMT; Operation: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColAttributes')]
function B_SQLColAttributes(hStmt: SQLHSTMT; icol, fDescType: SQLUSMALLINT; rgbDesc: SQLPOINTER;
           	cbDescMax: SQLSMALLINT; var cbDesc: SQLSMALLINT; var fDesc: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLColumnPrivileges')]
function B_SQLColumnPrivileges(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
           	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                szTableName: TSDCharPtr; cbTableName: SQLSMALLINT;
                szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDescribeParam')]
function B_SQLDescribeParam(hStmt: SQLHSTMT; ipar: SQLUSMALLINT; pfSqlType: SQLPOINTER;
           	var cbParamDef: SQLUINTEGER; pibScale, pfNullable: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLExtendedFetch')]
function B_SQLExtendedFetch(hStmt: SQLHSTMT; fFetchType: SQLUSMALLINT; irow: SQLINTEGER;
           	var crow: SQLUINTEGER; var gfRowStatus: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLForeignKeys')]
function B_SQLForeignKeys(hStmt: SQLHSTMT; szPkCatalogName: TSDCharPtr; cbPkCatalogName: SQLSMALLINT;
           	szPkSchemaName: TSDCharPtr; cbPkSchemaName: SQLSMALLINT;
                szPkTableName: TSDCharPtr; cbPkTableName: SQLSMALLINT;
                szFkCatalogName: TSDCharPtr; cbFkCatalogName: SQLSMALLINT;
                szFkSchemaName: TSDCharPtr; cbFkSchemaName: SQLSMALLINT;
                szFkTableName: TSDCharPtr; cbFkTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLMoreResults')]
function B_SQLMoreResults(hStmt: SQLHSTMT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNativeSql')]
function B_SQLNativeSql(hDbc: SQLHDBC; szSqlStrIn: TSDCharPtr; cbSqlStrIn: SQLINTEGER;
			szSqlStr: TSDCharPtr; cbSqlStrMax: SQLINTEGER; var cbSqlStr: SQLINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLNumParams')]
function B_SQLNumParams(hStmt: SQLHSTMT; var cpar: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLParamOptions')]
function B_SQLParamOptions(hStmt: SQLHSTMT; crow: SQLUINTEGER; var irow: SQLUINTEGER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLPrimaryKeys')]
function B_SQLPrimaryKeys(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
			szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLProcedureColumns')]
function B_SQLProcedureColumns(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                        szProcName: TSDCharPtr; cbProcName: SQLSMALLINT;
			szColumnName: TSDCharPtr; cbColumnName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLProcedures')]
function B_SQLProcedures(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
			szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
			szProcName: TSDCharPtr; cbProcName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLSetPos')]
function B_SQLSetPos(hStmt: SQLHSTMT; irow, fOption, fLock: SQLUSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLTablePrivileges')]
function B_SQLTablePrivileges(hStmt: SQLHSTMT; szCatalogName: TSDCharPtr; cbCatalogName: SQLSMALLINT;
           	szSchemaName: TSDCharPtr; cbSchemaName: SQLSMALLINT;
                szTableName: TSDCharPtr; cbTableName: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDrivers')]
function B_SQLDrivers(hEnv: SQLHENV; fDirection: SQLUSMALLINT; szDriverDesc: TSDCharPtr;
           	cbDriverDescMax: SQLSMALLINT; var cbDriverDesc: SQLSMALLINT;
                   szDriverAttributes: TSDCharPtr; cbDrvrAttrMax: SQLSMALLINT; var cbDrvrAttr: SQLSMALLINT): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLBindParameter')]
function B_SQLBindParameter(hStmt: SQLHSTMT; ipar: SQLUSMALLINT;
			fParamType, fCType, fSqlType: SQLSMALLINT;
			cbColDef: SQLUINTEGER; ibScale: SQLSMALLINT;
			rgbValue: SQLPOINTER; cbValueMax: SQLINTEGER;
                        pcbValue: SQLPOINTER): SQLRETURN; external;
[DllImport(DefSqlApiDLL_B, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SQLDriverConnect')]
function B_SQLDriverConnect(hDbc: SQLHDBC; hWnd: SQLHWND;
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

var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istInformix) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIInfDatabase.Create( ADbParams );
end;


{ TInfFunctions }
procedure TInfFunctions.SetApiCalls(ASqlLibModule: THandle);
{$IFDEF SD_CLR}
var
  s: string;
begin
  FLibHandle := ASqlLibModule;
  s := GetModuleFileNameStr( FLibHandle );
  s := ExtractFileName( s );
	// there are used functions, which imported in the current unit
  if UpperCase(s) = DefSqlApiDLL_A then begin
    FSQLAllocConnect    	:= SDInf.SQLAllocConnect;
    FSQLAllocEnv        	:= SDInf.SQLAllocEnv;
    FSQLAllocStmt       	:= SDInf.SQLAllocStmt;
    FSQLBindCol         	:= SDInf.SQLBindCol;
    FSQLCancel          	:= SDInf.SQLCancel;
    FSQLCloseCursor     	:= SDInf.SQLCloseCursor;
    FSQLColAttribute    	:= SDInf.SQLColAttribute;
    FSQLColumns         	:= SDInf.SQLColumns;
    FSQLConnect         	:= SDInf.SQLConnect;
    FSQLCopyDesc        	:= SDInf.SQLCopyDesc;
    FSQLDataSources     	:= SDInf.SQLDataSources;
    FSQLDescribeCol     	:= SDInf.SQLDescribeCol;
    FSQLDisconnect      	:= SDInf.SQLDisconnect;
    FSQLEndTran         	:= SDInf.SQLEndTran;
    FSQLError           	:= SDInf.SQLError;
    FSQLExecDirect      	:= SDInf.SQLExecDirect;
    FSQLExecute         	:= SDInf.SQLExecute;
    FSQLFetch           	:= SDInf.SQLFetch;
    FSQLFetchScroll     	:= SDInf.SQLFetchScroll;
    FSQLFreeConnect     	:= SDInf.SQLFreeConnect;
    FSQLFreeEnv         	:= SDInf.SQLFreeEnv;
    FSQLFreeHandle      	:= SDInf.SQLFreeHandle;
    FSQLFreeStmt        	:= SDInf.SQLFreeStmt;
    FSQLGetConnectAttr  	:= SDInf.SQLGetConnectAttr;
    FSQLGetConnectOption	:= SDInf.SQLGetConnectOption;
    FSQLGetCursorName   	:= SDInf.SQLGetCursorName;
    FSQLGetData         	:= SDInf.SQLGetData;
    FSQLGetDescField    	:= SDInf.SQLGetDescField;
    FSQLGetDescRec      	:= SDInf.SQLGetDescRec;
    FSQLGetDiagField    	:= SDInf.SQLGetDiagField;
    FSQLGetDiagRec      	:= SDInf.SQLGetDiagRec;
    FSQLGetEnvAttr      	:= SDInf.SQLGetEnvAttr;
    FSQLGetFunctions    	:= SDInf.SQLGetFunctions;
    FSQLGetInfo         	:= SDInf.SQLGetInfo;
    FSQLGetStmtAttr     	:= SDInf.SQLGetStmtAttr;
    FSQLGetStmtOption   	:= SDInf.SQLGetStmtOption;
    FSQLGetTypeInfo     	:= SDInf.SQLGetTypeInfo;
    FSQLNumResultCols   	:= SDInf.SQLNumResultCols;
    FSQLParamData       	:= SDInf.SQLParamData;
    FSQLPrepare         	:= SDInf.SQLPrepare;
    FSQLPutData         	:= SDInf.SQLPutData;
    FSQLRowCount        	:= SDInf.SQLRowCount;
    FSQLSetConnectAttr  	:= SDInf.SQLSetConnectAttr;
    FSQLSetConnectOption	:= SDInf.SQLSetConnectOption;
    FSQLSetCursorName   	:= SDInf.SQLSetCursorName;
    FSQLSetDescField    	:= SDInf.SQLSetDescField;
    FSQLSetDescRec      	:= SDInf.SQLSetDescRec;
    FSQLSetEnvAttr      	:= SDInf.SQLSetEnvAttr;
    FSQLSetParam        	:= SDInf.SQLSetParam;
    FSQLSetStmtAttr     	:= SDInf.SQLSetStmtAttr;
    FSQLSetStmtOption   	:= SDInf.SQLSetStmtOption;
    FSQLSpecialColumns  	:= SDInf.SQLSpecialColumns;
    FSQLStatistics      	:= SDInf.SQLStatistics;
    FSQLTables          	:= SDInf.SQLTables;
    FSQLTransact        	:= SDInf.SQLTransact;
    FSQLBrowseConnect   	:= SDInf.SQLBrowseConnect;
    FSQLBulkOperations  	:= SDInf.SQLBulkOperations;
    FSQLColAttributes   	:= SDInf.SQLColAttributes;
    FSQLColumnPrivileges	:= SDInf.SQLColumnPrivileges;
    FSQLDescribeParam   	:= SDInf.SQLDescribeParam;
    FSQLExtendedFetch   	:= SDInf.SQLExtendedFetch;
    FSQLForeignKeys   		:= SDInf.SQLForeignKeys;
    FSQLMoreResults     	:= SDInf.SQLMoreResults;
    FSQLNativeSql       	:= SDInf.SQLNativeSql;
    FSQLNumParams       	:= SDInf.SQLNumParams;
    FSQLParamOptions    	:= SDInf.SQLParamOptions;
    FSQLPrimaryKeys     	:= SDInf.SQLPrimaryKeys;
    FSQLProcedureColumns	:= SDInf.SQLProcedureColumns;
    FSQLProcedures      	:= SDInf.SQLProcedures;
    FSQLSetPos  		:= SDInf.SQLSetPos;
    FSQLTablePrivileges 	:= SDInf.SQLTablePrivileges;
    FSQLDrivers 		:= SDInf.SQLDrivers;
    FSQLBindParameter   	:= SDInf.SQLBindParameter;
    FSQLDriverConnect   	:= SDInf.SQLDriverConnect;
    Exit;
  end;
  FSQLAllocConnect    	:= B_SQLAllocConnect;
  FSQLAllocEnv        	:= B_SQLAllocEnv;
  FSQLAllocHandle     	:= B_SQLAllocHandle;
  FSQLAllocStmt       	:= B_SQLAllocStmt;
  FSQLBindCol         	:= B_SQLBindCol;
  FSQLCancel          	:= B_SQLCancel;
  FSQLCloseCursor     	:= B_SQLCloseCursor;
  FSQLColAttribute    	:= B_SQLColAttribute;
  FSQLColumns         	:= B_SQLColumns;
  FSQLConnect         	:= B_SQLConnect;
  FSQLCopyDesc        	:= B_SQLCopyDesc;
  FSQLDataSources     	:= B_SQLDataSources;
  FSQLDescribeCol     	:= B_SQLDescribeCol;
  FSQLDisconnect      	:= B_SQLDisconnect;
  FSQLEndTran         	:= B_SQLEndTran;
  FSQLError           	:= B_SQLError;
  FSQLExecDirect      	:= B_SQLExecDirect;
  FSQLExecute         	:= B_SQLExecute;
  FSQLFetch           	:= B_SQLFetch;
  FSQLFetchScroll     	:= B_SQLFetchScroll;
  FSQLFreeConnect     	:= B_SQLFreeConnect;
  FSQLFreeEnv         	:= B_SQLFreeEnv;
  FSQLFreeHandle      	:= B_SQLFreeHandle;
  FSQLFreeStmt        	:= B_SQLFreeStmt;
  FSQLGetConnectAttr  	:= B_SQLGetConnectAttr;
  FSQLGetConnectOption	:= B_SQLGetConnectOption;
  FSQLGetCursorName   	:= B_SQLGetCursorName;
  FSQLGetData         	:= B_SQLGetData;
  FSQLGetDescField    	:= B_SQLGetDescField;
  FSQLGetDescRec      	:= B_SQLGetDescRec;
  FSQLGetDiagField    	:= B_SQLGetDiagField;
  FSQLGetDiagRec      	:= B_SQLGetDiagRec;
  FSQLGetEnvAttr      	:= B_SQLGetEnvAttr;
  FSQLGetFunctions    	:= B_SQLGetFunctions;
  FSQLGetInfo         	:= B_SQLGetInfo;
  FSQLGetStmtAttr     	:= B_SQLGetStmtAttr;
  FSQLGetStmtOption   	:= B_SQLGetStmtOption;
  FSQLGetTypeInfo     	:= B_SQLGetTypeInfo;
  FSQLNumResultCols   	:= B_SQLNumResultCols;
  FSQLParamData       	:= B_SQLParamData;
  FSQLPrepare         	:= B_SQLPrepare;
  FSQLPutData         	:= B_SQLPutData;
  FSQLRowCount        	:= B_SQLRowCount;
  FSQLSetConnectAttr  	:= B_SQLSetConnectAttr;
  FSQLSetConnectOption	:= B_SQLSetConnectOption;
  FSQLSetCursorName   	:= B_SQLSetCursorName;
  FSQLSetDescField    	:= B_SQLSetDescField;
  FSQLSetDescRec      	:= B_SQLSetDescRec;
  FSQLSetEnvAttr      	:= B_SQLSetEnvAttr;
  FSQLSetParam        	:= B_SQLSetParam;
  FSQLSetStmtAttr     	:= B_SQLSetStmtAttr;
  FSQLSetStmtOption   	:= B_SQLSetStmtOption;
  FSQLSpecialColumns  	:= B_SQLSpecialColumns;
  FSQLStatistics      	:= B_SQLStatistics;
  FSQLTables          	:= B_SQLTables;
  FSQLTransact        	:= B_SQLTransact;
  FSQLBrowseConnect   	:= B_SQLBrowseConnect;
  FSQLBulkOperations  	:= B_SQLBulkOperations;
  FSQLColAttributes   	:= B_SQLColAttributes;
  FSQLColumnPrivileges	:= B_SQLColumnPrivileges;
  FSQLDescribeParam   	:= B_SQLDescribeParam;
  FSQLExtendedFetch   	:= B_SQLExtendedFetch;
  FSQLForeignKeys   	:= B_SQLForeignKeys;
  FSQLMoreResults     	:= B_SQLMoreResults;
  FSQLNativeSql       	:= B_SQLNativeSql;
  FSQLNumParams       	:= B_SQLNumParams;
  FSQLParamOptions    	:= B_SQLParamOptions;
  FSQLPrimaryKeys     	:= B_SQLPrimaryKeys;
  FSQLProcedureColumns	:= B_SQLProcedureColumns;
  FSQLProcedures      	:= B_SQLProcedures;
  FSQLSetPos  		:= B_SQLSetPos;
  FSQLTablePrivileges 	:= B_SQLTablePrivileges;
  FSQLDrivers 		:= B_SQLDrivers;
  FSQLBindParameter   	:= B_SQLBindParameter;
  FSQLDriverConnect   	:= B_SQLDriverConnect;
{$ELSE}
begin
  inherited SetApiCalls( hSqlLibModule );
{$ENDIF}
end;

procedure TInfFunctions.ClearApiCalls;
begin
  inherited ClearApiCalls;
end;

procedure LoadSqlLib;
const
  SqlApiDLLSep	= ';';	// delimiters of API-library names
var
  sLibName, sSqlApiDLL: string;
  CurPos: Integer;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      sSqlApiDLL := SqlApiDLL;

      CurPos := 1;
      repeat
        sLibName := ExtractLibName(sSqlApiDLL, SqlApiDLLSep, CurPos);
        hSqlLibModule := HelperLoadLibrary( sLibName );
        if hSqlLibModule <> 0 then
          Break;
      until CurPos > Length(sSqlApiDLL);
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [SqlApiDLL]);

      Inc(SqlLibRefCount);
      InfCalls.SetApiCalls( hSqlLibModule );
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
        // sleep(1) to exclude AV, when application (under Linux with Wine)
        //disconnecting from Informix (from Thomas Dingermann)    
      Sleep(1);
      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ GetModuleFileNameStr(hSqlLibModule) ]);
      Dec(SqlLibRefCount);
      InfCalls.ClearApiCalls;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{ TIInfDatabase }
function TIInfDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIInfCommand.Create( Self );
end;

function TIInfDatabase.GetCalls: TInfFunctions;
begin
  Result := FCalls as TInfFunctions;
end;

procedure TIInfDatabase.FreeSqlLib;
begin
  SDInf.FreeSqlLib;
end;

procedure TIInfDatabase.LoadSqlLib;
begin
  SDInf.LoadSqlLib;

  FCalls := InfCalls;
end;

procedure TIInfDatabase.RaiseSDEngineError(AErrorCode, ANativeError: TSDEResult; const AMsg, ASqlState: string);
begin
  raise ESDInfError.CreateWithSqlState(AErrorCode, ANativeError, AMsg, ASqlState);
end;

procedure TIInfDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
  function ParseRemoteDatabase(Str, Delimiters: string; var sServer, sDatabase: string) :Boolean;
  var
    i: Integer;
  begin
    sServer := '';
    sDatabase := '';
    i := 1;
    while i <= Length(Str) do begin
      if IsDelimiter(Delimiters, Str, i) then
        Break;
      Inc(i);
    end;
    if i <= Length(Str) then begin
      sServer := Copy(Str, 1, i-1);
      while i <= Length(Str) do begin
        if not IsDelimiter(Delimiters, Str, i) then
          Break;
        Inc(i);
      end;
      sDatabase := Copy(Str, i, Length(Str)-i+1);
      Result := True;
    end else begin
      sServer := Str;
      Result := False;
    end;
  end;
var
  ConnStr, sSrv, sDb: string;
begin
        // if sRemoteDatabase contains server and database name, like srv:db1
  if ParseRemoteDatabase(sRemoteDatabase, ServerDelimiters, sSrv, sDb) then
    ConnStr := Format('SERVICE=%s;HOST=test;PROTOCOL=OLSOCTCP;SERVER=%s;DATABASE=%s;UID=%s;PWD=%s',
    			[sSrv, sSrv, sDb, sUserName, sPassword])
  else
    ConnStr := sRemoteDatabase;
  inherited DoConnect( ConnStr, sUserName, sPassword );
end;


{ TIInfCommand }
function TIInfCommand.GetSqlDatabase: TIInfDatabase;
begin
  Result := (inherited SqlDatabase) as TIInfDatabase;
end;


initialization
  hSqlLibModule	:= 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  InfCalls 	:= TInfFunctions.Create;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
  InfCalls.Free;
end.
