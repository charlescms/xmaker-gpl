{$I XSqlDir.inc}
unit XSMss {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, SyncObjs,
{$IFDEF XSQL_VCL6}
  Variants,
{$ENDIF}
{$IFDEF XSQL_CLR}
  System.Text, System.Runtime.InteropServices,
{$ENDIF}
  XSConsts, XSCommon;

{*****************************************************************************
*                                                                            *
*     SQLFRONT.H - DB-Library header file for the Microsoft SQL Server.      *
*                                                                            *
* All constant and macro definitions for DB-Library applications programming *
* are contained in this file.  This file must be included before SQLDB.H and *
* one of the following #defines must be made, depending on the operating     *
* system: DBMSDOS, DBMSWIN or DBNTWIN32.                                     *
*                                                                            *
*****************************************************************************}

// call convention
// #define SQLAPI			cdecl

{*****************************************************************************
			Datatype definitions
*****************************************************************************}

type
  void 		= TSDPtr;

  INT		= Integer;
  LONG		= LongInt;
  USHORT	= Word;
  BOOL		= INT;
  LPINT		= ^INT;
  LPVOID	= ^void;
{$IFDEF XSQL_CLR}
  LPBYTE        = TSDCharPtr;
  LPCSTR        = TSDCharPtr;
  LPSTR         = TSDCharPtr;
{$ELSE}
  LPBYTE	= PChar;
{$ENDIF}

type

// DBPROCESS, LOGINREC and DBCURSOR
  PDBPROCESS	= TSDPtr;        // pointer to the dbprocess structure
  PLOGINREC	= TSDPtr;        // pointer to the login record
  PDBCURSOR	= TSDPtr;        // pointer to the cursor record
  PDBHANDLE	= TSDPtr;        // pointer to the generic handle

{#define PTR *
typedef int (SQLAPI *SQLFARPROC)();
#else
typedef long (far pascal *LGFARPROC)();  // Windows loadable driver fp
#endif}



{*****************************************************************************
		DB-Library datatype definitions
*****************************************************************************}
const
  DBMAXCHAR	= 256; // Max length of DBVARBINARY and DBVARCHAR, etc.

type
  RETCODE	= INT;
  STATUS	= INT;

// DB-Library datatypes
  DBCHAR	= CHAR;
  DBBINARY	= UCHAR;
  DBTINYINT	= BYTE;
  DBSMALLINT	= SHORT;
  DBUSMALLINT	= USHORT;
  DBINT 	= LONG;
  DBFLT8	= Double;
  DBBIT 	= BYTE;
  DBBOOL	= BYTE;
  DBFLT4	= Single;
  DBMONEY4	= LONG;

  DBREAL	= DBFLT4;
  DBUBOOL	= UINT;

  DBDATETIME4	= record	// 4-byte smalldatetime
    numdays: USHORT;        	// No of days since Jan-1-1900
    nummins: USHORT;        	// No. of minutes since midnight
  end;
  DBDATETIM4	= DBDATETIME4;

  DBVARYCHAR	= record
    len: DBSMALLINT;
    str: array [0..DBMAXCHAR-1] of DBCHAR;
  end;

  DBVARYBIN	= record
    len: DBSMALLINT;
    arr: array[0..DBMAXCHAR-1] of BYTE;
  end;

  DBMONEY	= record
    mnyhigh: DBINT;
    mnylow:  ULONG;
  end;

  DBDATETIME	= packed record	// 8-byte datetime
    dtdays: DBINT;		// Days since Jan 1, 1900
    dttime: ULONG;		// 300ths of a second since midnight
  end;

// DBDATEREC structure used by dbdatecrack
  DBDATEREC	= record
    year: 	INT;    // 1753 - 9999
    quarter: 	INT;    // 1 - 4
    month: 	INT;    // 1 - 12
    dayofyear: 	INT;    // 1 - 366
    day: 	INT;    // 1 - 31
    week: 	INT;    // 1 - 54 (for leap years)
    weekday: 	INT;    // 1 - 7  (Mon - Sun)
    hour: 	INT;    // 0 - 23
    minute: 	INT;    // 0 - 59
    second:	INT;    // 0 - 59
    millisecond:INT;  	// 0 - 999
  end;

const
  MAXNUMERICLEN		= 16;
  MAXNUMERICDIG 	= 38;

  DEFAULTPRECISION	= 18;
  DEFAULTSCALE    	=  0;

type
  DBNUMERIC     = record
    precision: 	BYTE;
    scale: 	BYTE;
    sign: 	BYTE; // 1 = Positive, 0 = Negative
    val: 	array[0..MAXNUMERICLEN-1] of BYTE;
  end;

  DBDECIMAL	= DBNUMERIC;


// Pack the following structures on a word boundary
{#ifdef __BORLANDC__
#pragma option -a+
#else
	#ifndef DBLIB_SKIP_PRAGMA_PACK   // Define this if your compiler does not support #pragma pack()
	#pragma pack(2)
	#endif
#endif}

const
  MAXCOLNAMELEN 	= 30;
  MAXTABLENAME 		= 30;

  MAXSERVERNAME		= 30;
  MAXNETLIBNAME		= 255;
  MAXNETLIBCONNSTR	= 255;

type
  TDBPROCINFO    = record
    SizeOfStruct:	DBINT;
    ServerType:		BYTE;
    ServerMajor: 	USHORT;
    ServerMinor: 	USHORT;
    ServerRevision: 	USHORT;
    ServerName:		array[0..MAXSERVERNAME] of CHAR;
    NetLibName: 	array[0..MAXNETLIBNAME] of CHAR;
    NetLibConnStr: 	array[0..MAXNETLIBCONNSTR] of CHAR;
  end;
  LPDBPROCINFO	= ^TDBPROCINFO;

  TDBCURSORINFO	= record
    SizeOfStruct: 	DBINT;	// Use sizeof(DBCURSORINFO)
    TotCols: 		ULONG;  // Total Columns in cursor
    TotRows: 		ULONG;  // Total Rows in cursor
    CurRow: 		ULONG;  // Current actual row in server
    TotRowsFetched: 	ULONG; 	// Total rows actually fetched
    CuMssSetErrHandlerrType:		ULONG;  // See CU_...
    Status: 		ULONG;  // See CU_...
  end;
  LPDBCURSORINFO	= ^TDBCURSORINFO;

const
  INVALID_UROWNUM	= ULONG(-1);

{*****************************************************************************
			Pointer Datatypes
*****************************************************************************}
type
  LPCINT 	= LPINT;
  LPCBYTE	= LPBYTE;
  LPUSHORT	= ^USHORT;
  LPCUSHORT	= LPUSHORT;
  LPDBINT	= ^DBINT;
  LPCDBINT 	= LPDBINT;
  LPDBBINARY	= ^DBBINARY;
  LPCDBBINARY	= LPDBBINARY;
  LPDBDATEREC	= ^DBDATEREC;
  LPCDBDATEREC	= LPDBDATEREC;
  LPDBDATETIME	= ^DBDATETIME;
  LPCDBDATETIME	= LPDBDATETIME;


{*****************************************************************************
			General #defines
*****************************************************************************}

const
  TIMEOUT_IGNORE	= ULONG(-1);
  TIMEOUT_INFINITE	= ULONG(0);
  TIMEOUT_MAXIMUM	= ULONG(1200);	// 20 minutes maximum timeout value

// Used for ServerType in dbgetprocinfo
  SERVTYPE_UNKNOWN	= 0;
  SERVTYPE_MICROSOFT	= 1;

// Used by dbcolinfo
//enum CI_TYPES { CI_REGULAR=1, CI_ALTERNATE=2, CI_CURSOR=3 };
  CI_REGULAR    = 1;
  CI_ALTERNATE  = 2;
  CI_CURSOR     = 3;

const
// Bulk Copy Definitions (bcp)
  DB_IN		= 1;         // Transfer from client to server
  DB_OUT	= 2;         // Transfer from server to client

  BCPMAXERRS	= 1;	// bcp_control parameter
  BCPFIRST	= 2;    // bcp_control parameter
  BCPLAST     	= 3;    // bcp_control parameter
  BCPBATCH    	= 4;    // bcp_control parameter
  BCPKEEPNULLS	= 5;    // bcp_control parameter
  BCPABORT    	= 6;    // bcp_control parameter

// redefine predefined constants
  DB_TRUE 	= 1;
  DB_FALSE 	= 0;

  TINYBIND		= 1;
  SMALLBIND		= 2;
  INTBIND  		= 3;
  CHARBIND 		= 4;
  BINARYBIND		= 5;
  BITBIND   		= 6;
  DATETIMEBIND		= 7;
  MONEYBIND   		= 8;
  FLT8BIND    		= 9;
  STRINGBIND  		= 10;
  NTBSTRINGBIND		= 11;
  VARYCHARBIND		= 12;
  VARYBINBIND 		= 13;
  FLT4BIND    		= 14;
  SMALLMONEYBIND 	= 15;
  SMALLDATETIBIND	= 16;
  DECIMALBIND 		= 17;
  NUMERICBIND 		= 18;
  SRCDECIMALBIND	= 19;
  SRCNUMERICBIND	= 20;
  MAXBIND       	= SRCNUMERICBIND;

  DBSAVE	= 1;
  DBNOSAVE      = 0;

  DBNOERR	= -1;
  DBFINDONE	= $04;  // Definately done
  DBMORE	= $10;  // Maybe more commands waiting
  DBMORE_ROWS	= $20;  // This command returned rows

  MAXNAME	= 31;


  DBTXTSLEN	= 8;     // Timestamp length

  DBTXPLEN	= 16;    // Text pointer length

// Error code returns
  INT_EXIT	= 0;
  INT_CONTINUE	= 1;
  INT_CANCEL	= 2;


// dboptions
  DBBUFFER      = 0;
  DBOFFSET      = 1;
  DBROWCOUNT    = 2;
  DBSTAT        = 3;
  DBTEXTLIMIT   = 4;
  DBTEXTSIZE    = 5;
  DBARITHABORT  = 6;
  DBARITHIGNORE = 7;
  DBNOAUTOFREE  = 8;
  DBNOCOUNT     = 9;
  DBNOEXEC      = 10;
  DBPARSEONLY   = 11;
  DBSHOWPLAN    = 12;
  DBSTORPROCID	= 13;

  DBANSItoOEM	= 14;
  DBOEMtoANSI	= 15;


  DBCLIENTCURSORS	= 16;
  DBSETTIME_OPT		= 17;
  DBQUOTEDIDENT 	= 18;


// Data Type Tokens
  SQLVOID       = $1f;
  SQLTEXT       = $23;
  SQLVARBINARY  = $25;
  SQLINTN       = $26;
  SQLVARCHAR    = $27;
  SQLBINARY     = $2d;
  SQLIMAGE      = $22;
  SQLCHAR       = $2f;
  SQLINT1       = $30;
  SQLBIT        = $32;
  SQLINT2       = $34;
  SQLINT4       = $38;
  SQLMONEY      = $3c;
  SQLDATETIME   = $3d;
  SQLFLT8       = $3e;
  SQLFLTN       = $6d;
  SQLMONEYN     = $6e;
  SQLDATETIMN   = $6f;
  SQLFLT4       = $3b;
  SQLMONEY4     = $7a;
  SQLDATETIM4   = $3a;
  SQLDECIMAL    = $6a;
  SQLNUMERIC    = $6c;

// Data stream tokens
  SQLCOLFMT     = $a1;
  OLD_SQLCOLFMT = $2a;
  SQLPROCID     = $7c;
  SQLCOLNAME    = $a0;
  SQLTABNAME    = $a4;
  SQLCOLINFO    = $a5;
  SQLALTNAME    = $a7;
  SQLALTFMT     = $a8;
  SQLERROR      = $aa;
  SQLINFO       = $ab;
  SQLRETURNVALUE= $ac;
  SQLRETURNSTATUS= $79;
  SQLRETURN     = $db;
  SQLCONTROL    = $ae;
  SQLALTCONTROL = $af;
  SQLROW        = $d1;
  SQLALTROW     = $d3;
  SQLDONE       = $fd;
  SQLDONEPROC   = $fe;
  SQLDONEINPROC = $ff;
  SQLOFFSET     = $78;
  SQLORDER      = $a9;
  SQLLOGINACK   = $ad; // NOTICE: change to real value

// Ag op tokens
  SQLAOPCNT	= $4b;
  SQLAOPSUM	= $4d;
  SQLAOPAVG	= $4f;
  SQLAOPMIN	= $51;
  SQLAOPMAX	= $52;
  SQLAOPANY	= $53;
  SQLAOPNOOP	= $56;

// Error numbers (dberrs) DB-Library error codes
  SQLEMEM	= 10000;
  SQLENULL	= 10001;
  SQLENLOG	= 10002;
  SQLEPWD 	= 10003;
  SQLECONN	= 10004;
  SQLEDDNE	= 10005;
  SQLENULLO	= 10006;
  SQLESMSG 	= 10007;
  SQLEBTOK 	= 10008;
  SQLENSPE 	= 10009;
  SQLEREAD 	= 10010;
  SQLECNOR 	= 10011;
  SQLETSIT 	= 10012;
  SQLEPARM 	= 10013;
  SQLEAUTN	= 10014;
  SQLECOFL	= 10015;
  SQLERDCN	= 10016;
  SQLEICN 	= 10017;
  SQLECLOS	= 10018;
  SQLENTXT	= 10019;
  SQLEDNTI	= 10020;
  SQLETMTD	= 10021;
  SQLEASEC	= 10022;
  SQLENTLL	= 10023;
  SQLETIME	= 10024;
  SQLEWRIT	= 10025;
  SQLEMODE	= 10026;
  SQLEOOB 	= 10027;
  SQLEITIM	= 10028;
  SQLEDBPS	= 10029;
  SQLEIOPT	= 10030;
  SQLEASNL	= 10031;
  SQLEASUL	= 10032;
  SQLENPRM	= 10033;
  SQLEDBOP	= 10034;
  SQLENSIP	= 10035;
  SQLECNULL	= 10036;
  SQLESEOF	= 10037;
  SQLERPND	= 10038;
  SQLECSYN	= 10039;
  SQLENONET	= 10040;
  SQLEBTYP	= 10041;
  SQLEABNC	= 10042;
  SQLEABMT	= 10043;
  SQLEABNP	= 10044;
  SQLEBNCR	= 10045;
  SQLEAAMT	= 10046;
  SQLENXID	= 10047;
  SQLEIFNB	= 10048;
  SQLEKBCO	= 10049;
  SQLEBBCI	= 10050;
  SQLEKBCI	= 10051;
  SQLEBCWE	= 10052;
  SQLEBCNN	= 10053;
  SQLEBCOR	= 10054;
  SQLEBCPI	= 10055;
  SQLEBCPN	= 10056;
  SQLEBCPB	= 10057;
  SQLEVDPT	= 10058;
  SQLEBIVI	= 10059;
  SQLEBCBC	= 10060;
  SQLEBCFO	= 10061;
  SQLEBCVH	= 10062;
  SQLEBCUO	= 10063;
  SQLEBUOE	= 10064;
  SQLEBWEF	= 10065;
  SQLEBTMT	= 10066;
  SQLEBEOF	= 10067;
  SQLEBCSI	= 10068;
  SQLEPNUL	= 10069;
  SQLEBSKERR	= 10070;
  SQLEBDIO	= 10071;
  SQLEBCNT	= 10072;
  SQLEMDBP	= 10073;
  SQLINIT	= 10074;
  SQLCRSINV	= 10075;
  SQLCRSCMD	= 10076;
  SQLCRSNOIND	= 10077;
  SQLCRSDIS	= 10078;
  SQLCRSAGR	= 10079;
  SQLCRSORD	= 10080;
  SQLCRSMEM	= 10081;
  SQLCRSBSKEY	= 10082;
  SQLCRSNORES	= 10083;
  SQLCRSVIEW	= 10084;
  SQLCRSBUFR	= 10085;
  SQLCRSFROWN	= 10086;
  SQLCRSBROL 	= 10087;
  SQLCRSFRAND	= 10088;
  SQLCRSFLAST	= 10089;
  SQLCRSRO   	= 10090;
  SQLCRSTAB  	= 10091;
  SQLCRSUPDTAB	= 10092;
  SQLCRSUPDNB	= 10093;
  SQLCRSVIIND	= 10094;
  SQLCRSNOUPD	= 10095;
  SQLCRSOS2	= 10096;
  SQLEBCSA 	= 10097;
  SQLEBCRO	= 10098;
  SQLEBCNE	= 10099;
  SQLEBCSK	= 10100;
  SQLEUVBF	= 10101;
  SQLEBIHC	= 10102;
  SQLEBWFF	= 10103;
  SQLNUMVAL	= 10104;
  SQLEOLDVR	= 10105;
  SQLEBCPS	= 10106;
  SQLEDTC 	= 10107;
  SQLENOTIMPL	= 10108;
  SQLENONFLOAT	= 10109;
  SQLECONNFB	= 10110;


// The severity levels are defined here
  EXINFO	= 1;	// Informational, non-error
  EXUSER	= 2;  	// User error
  EXNONFATAL	= 3;  	// Non-fatal error
  EXCONVERSION	= 4;  	// Error in DB-LIBRARY data conversion
  EXSERVER   	= 5;  	// The Server has returned an error flag
  EXTIME     	= 6;  	// We have exceeded our timeout period while
                     	// waiting for a response from the Server - the
                     	// DBPROCESS is still alive
  EXPROGRAM	= 7;  	// Coding error in user program
  EXRESOURCE	= 8;  	// Running out of resources - the DBPROCESS may be dead
  EXCOMM 	= 9;  	// Failure in communication with Server - the DBPROCESS is dead
  EXFATAL	= 10;	// Fatal error - the DBPROCESS is dead
  EXCONSISTENCY	= 11;	// Internal software error  - notify MS Technical Supprt

// Offset identifiers
  OFF_SELECT    = $16d;
  OFF_FROM      = $14f;
  OFF_ORDER     = $165;
  OFF_COMPUTE   = $139;
  OFF_TABLE     = $173;
  OFF_PROCEDURE = $16a;
  OFF_STATEMENT = $1cb;
  OFF_PARAM     = $1c4;
  OFF_EXEC      = $12c;

// Print lengths for certain fixed length data types
  PRINT4      = 11;
  PRINT2      = 6;
  PRINT1      = 3;
  PRFLT8      = 20;
  PRMONEY     = 26;
  PRBIT       = 3;
  PRDATETIME  = 27;
  PRDECIMAL   = (MAXNUMERICDIG + 2);
  PRNUMERIC   = (MAXNUMERICDIG + 2);

  SUCCEED 	= 1;
  FAIL    	= 0;
  SUCCEED_ABORT = 2;

  DBUNKNOWN 	= 2;

  MORE_ROWS    	= -1;
  NO_MORE_ROWS 	= -2;
  REG_ROW      	= MORE_ROWS;
  BUF_FULL     	= -3;

// Status code for dbresults(). Possible return values are SUCCEED, FAIL, and NO_MORE_RESULTS.
  NO_MORE_RESULTS	= 2;
  NO_MORE_RPC_RESULTS	= 3;

// Macros for dbsetlname()
  DBSETHOST	= 1;
  DBSETUSER	= 2;
  DBSETPWD 	= 3;
  DBSETAPP 	= 4;
  DBSETID  	= 5;
  DBSETLANG	= 6;
  DBSETSECURE	= 7;
  DBVER42 	= 8;
  DBVER60 	= 9;
  DBSETLOGINTIME_OPT= 10;
  DBSETFALLBACK = 12;

// Standard exit and error values
  STDEXIT 	= 0;
  ERREXIT 	= -1;

// dbrpcinit flags
  DBRPCRECOMPILE= $0001;
  DBRPCRESET    = $0004;
  DBRPCCURSOR   = $0008;

// dbrpcparam flags
  DBRPCRETURN   = $1;
  DBRPCDEFAULT  = $2;


{ 		Cursor related constants 		}

// Following flags are used in the concuropt parameter in the dbcursoropen function
  CUR_READONLY 	= 1;	// Read only cursor, no data modifications
  CUR_LOCKCC   	= 2; 	// Intent to update, all fetched data locked when
                 	// dbcursorfetch is called inside a transaction block
  CUR_OPTCC    	= 3;	// Optimistic concurrency control, data modifications
                 	// succeed only if the row hasn't been updated since
                 	// the last fetch.
  CUR_OPTCCVAL 	= 4; 	// Optimistic concurrency control based on selected column values

// Following flags are used in the scrollopt parameter in dbcursoropen
  CUR_FORWARD 	= 0;    // Forward only scrolling
  CUR_KEYSET  	= -1;   // Keyset driven scrolling
  CUR_DYNAMIC 	= 1;    // Fully dynamic
  CUR_INSENSITIVE= -2;	// Server-side cursors only

// Following flags define the fetchtype in the dbcursorfetch function
  FETCH_FIRST	= 1;	// Fetch first n rows
  FETCH_NEXT 	= 2;	// Fetch next n rows
  FETCH_PREV 	= 3;	// Fetch previous n rows
  FETCH_RANDOM	= 4;	// Fetch n rows beginning with given row #
  FETCH_RELATIVE= 5;	// Fetch relative to previous fetch row #
  FETCH_LAST 	= 6;	// Fetch the last n rows

// Following flags define the per row status as filled by dbcursorfetch and/or dbcursorfetchex
  FTC_EMPTY		= $00;  // No row available
  FTC_SUCCEED		= $01;  // Fetch succeeded, (failed if not set)
  FTC_MISSING		= $02;  // The row is missing
  FTC_ENDOFKEYSET 	= $04;  // End of the keyset reached
  FTC_ENDOFRESULTS	= $08;	// End of results set reached

// Following flags define the operator types for the dbcursor function
  CRS_UPDATE 	= 1;  	// Update operation
  CRS_DELETE 	= 2;  	// Delete operation
  CRS_INSERT 	= 3;  	// Insert operation
  CRS_REFRESH 	= 4;  	// Refetch given row
  CRS_LOCKCC 	= 5;	// Lock given row

// Following value can be passed to the dbcursorbind function for NOBIND type
  NOBIND 	= -2;	// Return length and pointer to data

// Following are values used by DBCURSORINFO's Type parameter
  CU_CLIENT     = $00000001;
  CU_SERVER     = $00000002;
  CU_KEYSET     = $00000004;
  CU_MIXED      = $00000008;
  CU_DYNAMIC    = $00000010;
  CU_FORWARD    = $00000020;
  CU_INSENSITIVE= $00000040;
  CU_READONLY   = $00000080;
  CU_LOCKCC     = $00000100;
  CU_OPTCC      = $00000200;
  CU_OPTCCVAL   = $00000400;

// Following are values used by DBCURSORINFO's Status parameter
  CU_FILLING    = $00000001;
  CU_FILLED     = $00000002;


// Following are values used by dbupdatetext's type parameter
  UT_TEXTPTR    = $0001;
  UT_TEXT       = $0002;
  UT_MORETEXT   = $0004;
  UT_DELETEONLY = $0008;
  UT_LOG        = $0010;


// The following values are passed to dbserverenum for searching criteria.
  NET_SEARCH 	= $0001;
  LOC_SEARCH 	= $0002;

// These constants are the possible return values from dbserverenum.
  ENUM_SUCCESS		= $0000;
  MORE_DATA   		= $0001;
  NET_NOT_AVAIL		= $0002;
  OUT_OF_MEMORY		= $0004;
  NOT_SUPPORTED		= $0008;
  ENUM_INVALID_PARAM	= $0010;


// Netlib Error problem codes.  ConnectionError() should return one of
// these as the dblib-mapped problem code, so the corresponding string
// is sent to the dblib app's error handler as dberrstr.  Return NE_E_NOMAP
// for a generic DB-Library error string (as in prior versions of dblib).

  NE_E_NOMAP      	= 0;   	// No string; uses dblib default.
  NE_E_NOMEMORY   	= 1;   	// Insufficient memory.
  NE_E_NOACCESS   	= 2;   	// Access denied.
  NE_E_CONNBUSY   	= 3;   	// Connection is busy.
  NE_E_CONNBROKEN 	= 4;   	// Connection broken.
  NE_E_TOOMANYCONN	= 5;   	// Connection limit exceeded.
  NE_E_SERVERNOTFOUND	= 6;   	// Specified SQL server not found.
  NE_E_NETNOTSTARTED 	= 7;   	// The network has not been started.
  NE_E_NORESOURCE	= 8;   	// Insufficient network resources.
  NE_E_NETBUSY    	= 9;   	// Network is busy.
  NE_E_NONETACCESS	= 10;  	// Network access denied.
  NE_E_GENERAL    	= 11;  	// General network error.  Check your documentation.
  NE_E_CONNMODE   	= 12;  	// Incorrect connection mode.
  NE_E_NAMENOTFOUND	= 13;  	// Name not found in directory service.
  NE_E_INVALIDCONN 	= 14;  	// Invalid connection.
  NE_E_NETDATAERR  	= 15;  	// Error reading or writing network data.
  NE_E_TOOMANYFILES	= 16;  	// Too many open file handles.
  NE_E_CANTCONNECT 	= 17;	// SQL Server does not exist or access denied.

  NE_MAX_NETERROR 	= 17;


{*****************************************************************************
*                                                                            *
*       SQLDB.H - DB-Library header file for the Microsoft SQL Server.       *
*                                                                            *
*****************************************************************************}


{// Macros for setting the PLOGINREC
#define DBSETLHOST(a,b)    dbsetlname   ((a), (b), DBSETHOST)
#define DBSETLUSER(a,b)    dbsetlname   ((a), (b), DBSETUSER)
#define DBSETLPWD(a,b)     dbsetlname   ((a), (b), DBSETPWD)
#define DBSETLAPP(a,b)     dbsetlname   ((a), (b), DBSETAPP)
#define BCP_SETL(a,b)      bcp_setl     ((a), (b))
#define DBSETLNATLANG(a,b) dbsetlname   ((a), (b), DBSETLANG)
#define DBSETLPACKET(a,b)  dbsetlpacket ((a), (b))
#define DBSETLSECURE(a)    dbsetlname   ((a), 0,   DBSETSECURE)
#define DBSETLVERSION(a,b) dbsetlname   ((a), 0,  (b))
#define DBSETLTIME(a,b)		dbsetlname    ((a), (LPCSTR)(ULONG)(b), DBSETLOGINTIME)
#define DBSETLFALLBACK(a,b) dbsetlname   ((a), (b),   DBSETFALLBACK)
}

{
/*****************************************************************************
* Windows 3.x and Non-Windows 3.x differences.                               *
*****************************************************************************/

#define dbwinexit()

#define DBLOCKLIB()
#define DBUNLOCKLIB()

typedef INT (SQLAPI *DBERRHANDLE_PROC)(PDBPROCESS, INT, INT, INT, LPCSTR, LPCSTR);
typedef INT (SQLAPI *DBMSGHANDLE_PROC)(PDBPROCESS, DBINT, INT, INT, LPCSTR, LPCSTR, LPCSTR, DBUSMALLINT);

extern DBERRHANDLE_PROC SQLAPI dberrhandle(DBERRHANDLE_PROC);
extern DBMSGHANDLE_PROC SQLAPI dbmsghandle(DBMSGHANDLE_PROC);

extern DBERRHANDLE_PROC SQLAPI dbprocerrhandle(PDBHANDLE, DBERRHANDLE_PROC);
extern DBMSGHANDLE_PROC SQLAPI dbprocmsghandle(PDBHANDLE, DBMSGHANDLE_PROC);
}
type
  TDBERRHANDLE_PROC =   function (dbproc: PDBPROCESS; severity, dberr, oserr: INT; dberrstr, oserrstr: TSDCharPtr): INT; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
  TDBMSGHANDLE_PROC =   function (dbproc: PDBPROCESS; msgno: DBINT; msgstate, severity: INT;
                                 msgtext, srvname, procname: TSDCharPtr; line: DBUSMALLINT): INT; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
  Tdberrhandle=  function (handler: TDBERRHANDLE_PROC): TDBERRHANDLE_PROC;
  Tdbmsghandle=  function (handler: TDBMSGHANDLE_PROC): TDBMSGHANDLE_PROC;


{*****************************************************************************
* Function Prototypes                                                        *
*****************************************************************************}

{// Functions macros
#define DBCMDROW(a)      dbcmdrow(a)
#define DBCOUNT(a)       dbcount (a)
#define DBCURCMD(a)      dbcurcmd(a)
#define DBCURROW(a)      dbcurrow(a)
#define DBDEAD(a)        dbdead(a)
#define DBFIRSTROW(a)    dbfirstrow(a)
#define DBGETTIME()      dbgettime()
#define DBISAVAIL(a)     dbisavail(a)
#define DBLASTROW(a)     dblastrow(a)
#define DBMORECMDS(a)    dbmorecmds(a)
#define DBNUMORDERS(a)   dbnumorders(a)
#define dbrbuf(a)        ((DBINT)dbdataready(a))
#define DBRBUF(a)        ((DBINT)dbdataready(a))
#define DBROWS(a)        dbrows (a)
#define DBROWTYPE(a)     dbrowtype (a)
}

{$IFDEF XSQL_CLR}
type
	// SizeOf(TDBCOL) = 122, alignment on word boundary
  [StructLayout(LayoutKind.Sequential)]
  TDBCOL		= packed record
    SizeOfStruct:	DBINT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = MAXCOLNAMELEN+1)]
    Name: 	        string;         // array[0..MAXCOLNAMELEN] of CHAR;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = MAXCOLNAMELEN+1)]
    ActualName:         string;         // array[0..MAXCOLNAMELEN] of CHAR;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = MAXTABLENAME+1)]
    TableName: 	        string;         // array[0..MAXTABLENAME] of CHAR;
    dummy1:		Byte;
    ColType:		SHORT;
    UserType: 		DBINT;
    MaxLength: 		DBINT;
    Precision: 		BYTE;
    Scale: 		BYTE;
    VarLength: 		BOOL;   // TRUE, FALSE
    Null: 		BYTE;   // TRUE, FALSE or DBUNKNOWN
    CaseSensitive: 	BYTE; 	// TRUE, FALSE or DBUNKNOWN
    Updatable:		BYTE;   // TRUE, FALSE or DBUNKNOWN
    dummy2:		Byte;
    Identity:		BOOL;   // TRUE, FALSE
  end;
{$ELSE}
	// SizeOf(TDBCOL) = 122, alignment on word boundary
  TDBCOL		= packed record
    SizeOfStruct:	DBINT;
    Name: 	array[0..MAXCOLNAMELEN] of CHAR;
    ActualName: array[0..MAXCOLNAMELEN] of CHAR;
    TableName: 	array[0..MAXTABLENAME] of CHAR;
    dummy1:		Byte;
    ColType:		SHORT;
    UserType: 		DBINT;
    MaxLength: 		DBINT;
    Precision: 		BYTE;
    Scale: 		BYTE;
    VarLength: 		BOOL;   // TRUE, FALSE
    Null: 		BYTE;   // TRUE, FALSE or DBUNKNOWN
    CaseSensitive: 	BYTE; 	// TRUE, FALSE or DBUNKNOWN
    Updatable:		BYTE;   // TRUE, FALSE or DBUNKNOWN
    dummy2:		Byte;
    Identity:		BOOL;   // TRUE, FALSE
  end;
  LPDBCOL		= ^TDBCOL;
{$ENDIF}

{$IFNDEF XSQL_CLR}
var
// Two-phase commit functions
  abort_xact:	function(connect: PDBPROCESS; CommId: DBINT): RETCODE; cdecl;
  build_xact_string: procedure (xact_name, service_name: LPCSTR; CommId: DBINT; sResult: LPSTR); cdecl;
  close_commit: procedure (connect: PDBPROCESS); cdecl;
  commit_xact:	function (connect: PDBPROCESS; commId: DBINT): RETCODE; cdecl;
  open_commit:	function (login: PLOGINREC; servername: LPCSTR): PDBPROCESS; cdecl;
  remove_xact:	function (connect: PDBPROCESS; commId: DBINT; n: INT): RETCODE; cdecl;
  scan_xact:	function (connect: PDBPROCESS; commId: DBINT): RETCODE; cdecl;
  start_xact:	function (connect: PDBPROCESS; application_name, xact_name: LPCSTR; site_count: INT): DBINT; cdecl;
  stat_xact:	function (connect: PDBPROCESS; commId: DBINT): INT; cdecl;

// BCP functions
  bcp_batch:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  bcp_bind:	function (dbproc: PDBPROCESS; varaddr: LPCBYTE;
  			prefixlen: INT; varlen: DBINT; terminator: LPCBYTE;
        		termlen, datatype, table_column: INT): RETCODE; cdecl;
  bcp_colfmt:	function (dbproc: PDBPROCESS; file_column: INT; file_type: BYTE;
  			file_prefixlen: INT; file_collen: DBINT; file_term: LPCBYTE;
        		file_termlen, table_column: INT): RETCODE; cdecl;
  bcp_collen:	function (dbproc: PDBPROCESS; varlen: DBINT; table_column: INT): RETCODE; cdecl;
  bcp_colptr:	function (dbproc: PDBPROCESS; colptr: LPCBYTE; table_column: INT): RETCODE; cdecl;
  bcp_columns:	function (dbproc: PDBPROCESS; file_colcount: INT): RETCODE; cdecl;
  bcp_control:	function (dbproc: PDBPROCESS; field: INT; value: DBINT): RETCODE; cdecl;
  bcp_done:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  bcp_exec:	function (dbproc: PDBPROCESS; rows_copied: LPDBINT): RETCODE; cdecl;
  bcp_init:	function (dbproc: PDBPROCESS; tblname, hfile, errfile: LPCSTR; direction: INT): RETCODE; cdecl;
  bcp_moretext:	function (dbproc: PDBPROCESS; size: DBINT; text: LPCBYTE): RETCODE; cdecl;
  bcp_readfmt:	function (dbproc: PDBPROCESS; filename: LPCSTR): RETCODE; cdecl;
  bcp_sendrow:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  bcp_setl:	function (loginrec: PLOGINREC; enable: BOOL): RETCODE; cdecl;
  bcp_writefmt:	function (dbproc: PDBPROCESS; filename: LPCSTR): RETCODE; cdecl;

// Standard DB-Library functions
  dbadata:	function (dbproc: PDBPROCESS; computeId, column: INT): LPCBYTE; cdecl;
  dbadlen:	function (dbproc: PDBPROCESS; computeId, column: INT): DBINT; cdecl;
  dbaltbind:	function (dbproc: PDBPROCESS; computeId, column, vartype: INT;
  			varlen: DBINT; varaddr: LPCBYTE): RETCODE; cdecl;
  dbaltcolid:	function (dbproc: PDBPROCESS; computeId, column: INT): INT; cdecl;
  dbaltlen:	function (dbproc: PDBPROCESS; computeId, column: INT): DBINT; cdecl;
  dbaltop:	function (dbproc: PDBPROCESS; computeId, column: INT): INT; cdecl;
  dbalttype:	function (dbproc: PDBPROCESS; computeId, column: INT): INT; cdecl;
  dbaltutype:	function (dbproc: PDBPROCESS; computeId, column: INT): DBINT; cdecl;
  dbanullbind:	function (dbproc: PDBPROCESS; computeId, column: INT; indicator: LPCDBINT): RETCODE; cdecl;
  dbbind:	function (dbproc: PDBPROCESS; column, vartype: INT; varlen: DBINT; varaddr: LPBYTE): RETCODE; cdecl;
  dbbylist:	function (dbproc: PDBPROCESS; computeId: INT; size: LPINT): LPCBYTE; cdecl;
  dbcancel:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbcanquery:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbchange:	function (dbproc: PDBPROCESS): LPCSTR; cdecl;
  dbclose:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbclrbuf: 	procedure (dbproc: PDBPROCESS; n: DBINT); cdecl;
  dbclropt:	function (dbproc: PDBPROCESS; option: INT; param: LPCSTR): RETCODE; cdecl;
  dbcmd:	function (dbproc: PDBPROCESS; cmdstring: LPCSTR): RETCODE; cdecl;
  dbcmdrow:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbcolbrowse:	function (dbproc: PDBPROCESS; colnum: INT): BOOL; cdecl;
  dbcolinfo:	function (dbHandle: PDBHANDLE; colinfo, column, computeId: INT; var DbCol: TDBCOL): RETCODE; cdecl;
  dbcollen:	function (dbproc: PDBPROCESS; column: INT): DBINT; cdecl;
  dbcolname:	function (dbproc: PDBPROCESS; column: INT): LPCSTR; cdecl;
  dbcolsource:	function (dbproc: PDBPROCESS; colnum: INT): LPCSTR; cdecl;
  dbcoltype:	function (dbproc: PDBPROCESS; column: INT): INT; cdecl;
  dbcolutype:	function (dbproc: PDBPROCESS; column: INT): DBINT; cdecl;
  dbconvert:	function (dbproc: PDBPROCESS; srctype: INT; src: LPCBYTE; srclen: DBINT;
  			desttype: INT; dest: LPBYTE; destlen: DBINT): INT; cdecl;
  dbcount:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  dbcurcmd:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbcurrow:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  dbcursor:	function (hc: PDBCURSOR; optype, row: INT; table, values: LPCSTR): RETCODE; cdecl;
  dbcursorbind:	function (hc: PDBCURSOR; col, vartype: INT; varlen: DBINT; poutlen: LPDBINT; pvaraddr: LPBYTE): RETCODE; cdecl;
  dbcursorclose:function (handle: PDBHANDLE): RETCODE; cdecl;
  dbcursorcolinfo:function (hcursor: PDBCURSOR; column: INT; colname: LPSTR;
  			coltype: LPINT; collen: LPDBINT; usertype: LPINT): RETCODE; cdecl;
  dbcursorfetch:function (hc: PDBCURSOR; fetchtype, rownum: INT): RETCODE; cdecl;
  dbcursorfetchex:function (hc: PDBCURSOR; fetchtype: INT; rownum, nfetchrows, reserved: DBINT): RETCODE; cdecl;
  dbcursorinfo:	function (hcursor: PDBCURSOR; ncols: LPINT; nrows: LPDBINT): RETCODE; cdecl;
  dbcursorinfoex:function (hc: PDBCURSOR; pdbcursorinfo: LPDBCURSORINFO): RETCODE; cdecl;
  dbcursoropen:	function (dbproc: PDBPROCESS; stmt: LPCSTR; scrollopt, concuropt: INT;
  			nrows: UINT; pstatus: LPDBINT): PDBCURSOR; cdecl;
  dbdata:	function (dbproc: PDBPROCESS; column: INT): LPCBYTE; cdecl;
  dbdataready:	function (dbproc: PDBPROCESS): BOOL; cdecl;
  dbdatecrack:	function (dbproc: PDBPROCESS; var dateinfo: DBDATEREC; datetime: TSDPtr{LPCDBDATETIME}): RETCODE; cdecl;
  dbdatlen:	function (dbproc: PDBPROCESS; column: INT): DBINT; cdecl;
  dbdead:	function (dbproc: PDBPROCESS): BOOL; cdecl;
  dbexit:	procedure ; cdecl;
  dbenlisttrans:function(dbproc: PDBPROCESS; pTransaction: LPVOID): RETCODE; cdecl;
  dbenlistxatrans:function(dbproc: PDBPROCESS; enlisttran: BOOL): RETCODE; cdecl;
//  dbfcmd:	function (PDBPROCESS, LPCSTR, ...): RETCODE; cdecl;
  dbfirstrow:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  dbfreebuf:	procedure (dbproc: PDBPROCESS); cdecl;
  dbfreelogin:	procedure (login: PLOGINREC); cdecl;
  dbfreequal:	procedure (ptr: LPCSTR); cdecl;
  dbgetchar:	function (dbproc: PDBPROCESS; n: INT): LPSTR; cdecl;
  dbgetmaxprocs:function : SHORT; cdecl;
  dbgetoff:	function (dbproc: PDBPROCESS; offtype: DBUSMALLINT; startfrom: INT): INT; cdecl;
  dbgetpacket:	function (dbproc: PDBPROCESS): UINT; cdecl;
  dbgetrow:	function (dbproc: PDBPROCESS; row: DBINT): STATUS; cdecl;
  dbgettime:	function : INT; cdecl;
  dbgetuserdata:function (dbproc: PDBPROCESS): LPVOID; cdecl;
  dbhasretstat:	function (dbproc: PDBPROCESS): DBBOOL; cdecl;
  dbinit:	function : LPCSTR; cdecl;
  dbisavail:	function (dbproc: PDBPROCESS): BOOL; cdecl;
  dbiscount:	function (dbproc: PDBPROCESS): BOOL; cdecl;
  dbisopt:	function (dbproc: PDBPROCESS; option: INT; param: LPCSTR): BOOL; cdecl;
  dblastrow:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  dblogin:	function : PLOGINREC; cdecl;
  dbmorecmds:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbmoretext:	function (dbproc: PDBPROCESS; size: DBINT; text: LPCBYTE): RETCODE; cdecl;
  dbname:	function (dbproc: PDBPROCESS): LPCSTR; cdecl;
  dbnextrow:	function (dbproc: PDBPROCESS): STATUS; cdecl;
  dbnullbind:	function (dbproc: PDBPROCESS; column: INT; indicator: LPCDBINT): RETCODE; cdecl;
  dbnumalts:	function (dbproc: PDBPROCESS; computeId: INT): INT; cdecl;
  dbnumcols:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbnumcompute:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbnumorders:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbnumrets:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbopen:	function (login: PLOGINREC; servername: LPCSTR): PDBPROCESS; cdecl;
  dbordercol:	function (dbproc: PDBPROCESS; order: INT): INT; cdecl;
  dbprocinfo:	function (dbproc: PDBPROCESS; var dbprcinfo: TDBPROCINFO): RETCODE; cdecl;
  dbprhead:	procedure (dbproc: PDBPROCESS); cdecl;
  dbprrow:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbprtype:	function (token: INT): LPCSTR; cdecl;
  dbqual:	function (dbproc: PDBPROCESS; tabnum: INT; tabname: LPCSTR): LPCSTR; cdecl;
//  dbreadpage:	function (dbproc: PDBPROCESS; LPCSTR, DBINT, LPBYTE): DBINT; cdecl;
  dbreadtext:	function (dbproc: PDBPROCESS; buf: LPVOID; bufsize: DBINT): DBINT; cdecl;
  dbresults:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbretdata:	function (dbproc: PDBPROCESS; retnum: INT): LPCBYTE; cdecl;
  dbretlen:	function (dbproc: PDBPROCESS; retnum: INT): DBINT; cdecl;
  dbretname:	function (dbproc: PDBPROCESS; retnum: INT): LPCSTR; cdecl;
  dbretstatus:	function (dbproc: PDBPROCESS): DBINT; cdecl;
  dbrettype:	function (dbproc: PDBPROCESS; retnum: INT): INT; cdecl;
  dbrows:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbrowtype:	function (dbproc: PDBPROCESS): STATUS; cdecl;
  dbrpcinit:	function (dbproc: PDBPROCESS; rpcname: LPCSTR; options: DBSMALLINT): RETCODE; cdecl;
  dbrpcparam:	function (dbproc: PDBPROCESS; paramname: LPCSTR; status: BYTE;
  			datatype: INT; maxlen, datalen: DBINT; value: LPCBYTE): RETCODE; cdecl;
  dbrpcsend:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbrpcexec:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
//  dbrpwclr:	procedure (PLOGINREC); cdecl;
//  dbrpwset:	function (PLOGINREC, LPCSTR, LPCSTR, INT): RETCODE; cdecl;
  dbserverenum:	function (searchmode: USHORT; servnamebuf: LPSTR; sizeservnamebuf: USHORT; numentries: LPUSHORT): INT; cdecl;
  dbsetavail:	procedure (dbproc: PDBPROCESS); cdecl;
  dbsetmaxprocs:function (maxprocs: SHORT): RETCODE; cdecl;
  dbsetlname:	function (login: PLOGINREC; value: LPCSTR; param: INT): RETCODE; cdecl;
  dbsetlogintime:function (seconds: INT): RETCODE; cdecl;
  dbsetlpacket:	function (login: PLOGINREC; packet_size: USHORT): RETCODE; cdecl;
  dbsetnull:	function (dbproc: PDBPROCESS; bindtype, bindlen: INT; bindval: LPCBYTE): RETCODE; cdecl;
  dbsetopt:	function (dbproc: PDBPROCESS; option: INT; param: LPCSTR): RETCODE; cdecl;
  dbsettime:	function (seconds: INT): RETCODE; cdecl;
  dbsetuserdata:procedure (dbproc: PDBPROCESS; ptr: LPVOID); cdecl;
  dbsqlexec:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbsqlok:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbsqlsend:	function (dbproc: PDBPROCESS): RETCODE; cdecl;
  dbstrcpy:	function (dbproc: PDBPROCESS; start, numbytes: INT; dest: LPSTR): RETCODE; cdecl;
  dbstrlen:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbtabbrowse:	function (dbproc: PDBPROCESS; tabnum: INT): BOOL; cdecl;
  dbtabcount:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbtabname:	function (dbproc: PDBPROCESS; tabnum: INT): LPCSTR; cdecl;
  dbtabsource:	function (dbproc: PDBPROCESS; colnum: INT; tabnum: LPINT): LPCSTR; cdecl;
  dbtsnewlen:	function (dbproc: PDBPROCESS): INT; cdecl;
  dbtsnewval:	function (dbproc: PDBPROCESS): LPCDBBINARY; cdecl;
  dbtsput:	function (dbproc: PDBPROCESS; newts: LPCDBBINARY; newtslen, tabnum: INT; tabname: LPCSTR): RETCODE; cdecl;
  dbtxptr:	function (dbproc: PDBPROCESS; column: INT): LPCDBBINARY; cdecl;
  dbtxtimestamp:function (dbproc: PDBPROCESS; column: INT): LPCDBBINARY; cdecl;
  dbtxtsnewval:	function (dbproc: PDBPROCESS): LPCDBBINARY; cdecl;
  dbtxtsput:	function (dbproc: PDBPROCESS; newtxts: LPCDBBINARY; colnum: INT): RETCODE; cdecl;
  dbuse:	function (dbproc: PDBPROCESS; dbname: LPCSTR): RETCODE; cdecl;
  dbvarylen:	function (dbproc: PDBPROCESS; column: INT): BOOL; cdecl;
  dbwillconvert:function (srctype, desttype: INT): BOOL; cdecl;
//  dbwritepage:	function (dbproc: PDBPROCESS; LPCSTR, DBINT, DBINT, LPBYTE): RETCODE; cdecl;
  dbwritetext:	function (dbproc: PDBPROCESS; objname: LPCSTR;
  			textptr: LPCDBBINARY; textptrlen: DBTINYINT; timestamp: LPCDBBINARY;
                        log: BOOL; size: DBINT; text: LPCBYTE): RETCODE; cdecl;
  dbupdatetext:	function (dbproc: PDBPROCESS; dest_object: LPCSTR; dest_textptr: LPCDBBINARY;
  			dest_timestamp: LPCDBBINARY; update_type: INT; insert_offset, delete_length: DBINT;
  			src_object: LPCSTR; src_size: DBINT; src_text: LPCDBBINARY): RETCODE; cdecl;

  dberrhandle:  function (handler: TDBERRHANDLE_PROC): TDBERRHANDLE_PROC; cdecl;
  dbmsghandle:  function (handler: TDBMSGHANDLE_PROC): TDBMSGHANDLE_PROC; cdecl;
  dbprocerrhandle:function (dbproc: PDBPROCESS; handler: TDBERRHANDLE_PROC): TDBERRHANDLE_PROC; cdecl;
  dbprocmsghandle:function (dbproc: PDBPROCESS; handler: TDBMSGHANDLE_PROC): TDBMSGHANDLE_PROC; cdecl;
{$ENDIF}

type
  ESDMssError = class(ESDEngineError)
  private
    FHProcess: PDBPROCESS;		// FDbProcess - pointer to DBPROCESS structure for communication with the SQLServer
    FSeverity: INT;
  public
    constructor Create(DbProc: PDBPROCESS; AErrorCode, ANativeError: TSDEResult;
      ASeverity: INT; const Msg: string; AErrorPos: LongInt);
    property HProcess: PDBPROCESS read FHProcess;
    property Severity: INT read FSeverity;
  end;

{ TIMssDatabase }
  TIMssConnInfo	= packed record
    ServerType:         Byte;
    DBProcPtr:		PDBPROCESS;	// pointer to DBPROCESS structure for communication with the SQLServer
    LoginRecPtr:	PLOGINREC;
    ServerNameStr: 	string;
  end;

  TIMssDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;

    FCurSqlCmd: TISqlCommand;		// a command, which uses a database handle currently (when FIsSingleConn is True)

    FByteAsGuid: Boolean;
    procedure Check(dbproc: PDBPROCESS);
    procedure AllocHandle;
    procedure FreeHandle;
    function GetDBProcPtr: PDBPROCESS;
    function GetLoginRecPtr: PLOGINREC;
    function GetServerName: string;
    procedure GetStmtResult(const Stmt: string; List: TStrings);
    procedure HandleExecCmd(AHandle: PDBPROCESS; const Stmt: string);
    procedure HandleSetAutoCommit(AHandle: PDBPROCESS);
    procedure HandleSetDefOptions(AHandle: PDBPROCESS);
    procedure HandleSetTransIsolation(AHandle: PDBPROCESS; Value: TISqlTransIsolation);
    procedure HandleReset(AHandle: PDBPROCESS);
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
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;

    procedure ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll, IsReset: Boolean);
    property CurSqlCmd: TISqlCommand read FCurSqlCmd;
    property DBProcPtr: PDBPROCESS read GetDBProcPtr;
    property LoginRecPtr: PLOGINREC read GetLoginRecPtr;
    property ServerName: string read GetServerName;
    property ByteAsGuid: Boolean read FByteAsGuid;
  end;

{ TIMssCommand }
  TIMssCommand = class(TISqlCommand)
  private
    FBindStmt: string;		// with bind parameter data, it's used to check whether the statement was executed
    FRowsAffected: DBINT;	// number of rows affected by the last Transact-SQL statement (DML)
    FHandle: PDBPROCESS;
    FIsSingleConn: Boolean;	// True, if it's required to use a database handle always
    FConnected: Boolean;	// True, when Connect method was called
    FNextResults: Boolean;	// if one of multiple result sets processing
    FEndResults: Boolean;	// if all results have been processed

    procedure Connect;
    function CanReturnRows: Boolean;
    function CnvtDateTimeToSQLVarChar(ADataType: TFieldType; Value: TDateTime): string;
    function CnvtDateTimeToSQLDateTime(Value: TDateTime): DBDATETIME;
    function CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDValueBuffer; BufSize: Integer): TDateTimeRec;
    function CnvtFloatToSQLVarChar(Value: Double): string;
    function CreateDBProcess: PDBPROCESS;
    procedure HandleCancel(AHandle: PDBPROCESS);
    procedure HandleCurReset(AHandle: PDBPROCESS);
    procedure HandleReset(AHandle: PDBPROCESS);
    procedure HandleSpInit(AHandle: PDBPROCESS; ARpcName: string);
    procedure HandleSpExec(AHandle: PDBPROCESS);
    function HandleSpResults(AHandle: PDBPROCESS): Boolean;
    function GetExecuted: Boolean;
    function GetSqlDatabase: TIMssDatabase;
    function GetDBHandleAcquired: Boolean;
    procedure InternalExecute;
    procedure InternalQBindParams;
    procedure InternalQExecute;
    procedure InternalSpBindParams;
    procedure InternalSpExecute;
    procedure InternalSpGetParams;
    procedure FetchDataSize;
  protected
    procedure Check;
    procedure AcquireDBHandle;
    procedure ReleaseDBHandle;
    procedure ReleaseDBHandleWOReset;

    procedure AllocParamsBuffer; override;
    procedure BindParamsBuffer; override;
    procedure FreeParamsBuffer; override;
    function GetParamsBufferSize: Integer; override;
    procedure DoExecute; override;
    procedure DoExecDirect(Value: string); override;
    procedure DoPrepare(Value: string); override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    function GetHandle: PSDCursor; override;
    procedure InitParamList; override;
    procedure SetFieldsBuffer; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    procedure Execute; override;
    function GetRowsAffected: Integer; override;
    function NextResultSet: Boolean; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;
    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;

    procedure ResetExecuted;
    property Executed: Boolean read GetExecuted;
    property DBHandleAcquired: Boolean read GetDBHandleAcquired;
    property SqlDatabase: TIMssDatabase read GetSqlDatabase;
  end;

const
  DefSqlApiDLL	= 'NTWDBLIB.DLL';

var
  SqlApiDLL: string;

{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

{$IFDEF XSQL_CLR}
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbbind')]
function dbbind(dbproc: PDBPROCESS; column, vartype: INT; varlen: DBINT; varaddr: LPBYTE): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcancel')]
function dbcancel(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcanquery')]
function dbcanquery(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbclose')]
function dbclose(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbclrbuf')]
procedure dbclrbuf(dbproc: PDBPROCESS; n: DBINT); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbclropt')]
function dbclropt(dbproc: PDBPROCESS; option: INT; param: LPCSTR): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcmd')]
function dbcmd(dbproc: PDBPROCESS; cmdstring: LPCSTR): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcmdrow')]
function dbcmdrow(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcolinfo')]
function dbcolinfo(dbHandle: PDBHANDLE; colinfo, column, computeId: INT; var DbCol: TDBCOL): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcollen')]
function dbcollen(dbproc: PDBPROCESS; column: INT): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcolname')]
function dbcolname(dbproc: PDBPROCESS; column: INT): LPCSTR; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcoltype')]
function dbcoltype(dbproc: PDBPROCESS; column: INT): INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbconvert')]
function dbconvert(dbproc: PDBPROCESS; srctype: INT; src: LPCBYTE; srclen: DBINT;
			desttype: INT; dest: LPBYTE; destlen: DBINT): INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbcount')]
function dbcount(dbproc: PDBPROCESS): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbdata')]
function dbdata(dbproc: PDBPROCESS; column: INT): LPCBYTE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbdatecrack')]
function dbdatecrack(dbproc: PDBPROCESS; var dateinfo: DBDATEREC; datetime: TSDValueBuffer): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbdatlen')]
function dbdatlen(dbproc: PDBPROCESS; column: INT): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbdead')]
function dbdead(dbproc: PDBPROCESS): BOOL; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbexit')]
procedure dbexit; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbfirstrow')]
function dbfirstrow(dbproc: PDBPROCESS): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbfreebuf')]
procedure dbfreebuf(dbproc: PDBPROCESS); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbfreelogin')]
procedure dbfreelogin(login: PLOGINREC); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbgetmaxprocs')]
function dbgetmaxprocs: SHORT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbgetpacket')]
function dbgetpacket(dbproc: PDBPROCESS): UINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbgetrow')]
function dbgetrow(dbproc: PDBPROCESS; row: DBINT): STATUS; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbgettime')]
function dbgettime: INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbhasretstat')]
function dbhasretstat(dbproc: PDBPROCESS): DBBOOL; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbinit')]
function dbinit: LPCSTR; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbisavail')]
function dbisavail(dbproc: PDBPROCESS): BOOL; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbiscount')]
function dbiscount(dbproc: PDBPROCESS): BOOL; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbisopt')]
function dbisopt(dbproc: PDBPROCESS; option: INT; param: LPCSTR): BOOL; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dblastrow')]
function dblastrow(dbproc: PDBPROCESS): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dblogin')]
function dblogin: PLOGINREC; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbmorecmds')]
function dbmorecmds(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbmoretext')]
function dbmoretext(dbproc: PDBPROCESS; size: DBINT; text: LPCBYTE): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbname')]
function dbname(dbproc: PDBPROCESS): LPCSTR; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbnextrow')]
function dbnextrow(dbproc: PDBPROCESS): STATUS; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbnumcols')]
function dbnumcols(dbproc: PDBPROCESS): INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbnumrets')]
function dbnumrets(dbproc: PDBPROCESS): INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbopen')]
function dbopen(login: PLOGINREC; servername: LPCSTR): PDBPROCESS; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbordercol')]
function dbordercol(dbproc: PDBPROCESS; order: INT): INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbprocinfo')]
function dbprocinfo(dbproc: PDBPROCESS; var dbprcinfo: TDBPROCINFO): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbresults')]
function dbresults(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbretdata')]
function dbretdata(dbproc: PDBPROCESS; retnum: INT): LPCBYTE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbretlen')]
function dbretlen(dbproc: PDBPROCESS; retnum: INT): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbretname')]
function dbretname(dbproc: PDBPROCESS; retnum: INT): LPCSTR; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbretstatus')]
function dbretstatus(dbproc: PDBPROCESS): DBINT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrettype')]
function dbrettype(dbproc: PDBPROCESS; retnum: INT): INT; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrows')]
function dbrows(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrowtype')]
function dbrowtype(dbproc: PDBPROCESS): STATUS; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrpcinit')]
function dbrpcinit(dbproc: PDBPROCESS; rpcname: LPCSTR; options: DBSMALLINT): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrpcparam')]
function dbrpcparam(dbproc: PDBPROCESS; paramname: LPCSTR; status: BYTE;
			datatype: INT; maxlen, datalen: DBINT; value: LPCBYTE): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrpcsend')]
function dbrpcsend(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbrpcexec')]
function dbrpcexec(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsetavail')]
procedure dbsetavail(dbproc: PDBPROCESS); external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsetmaxprocs')]
function dbsetmaxprocs(maxprocs: SHORT): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsetlname')]
function dbsetlname(login: PLOGINREC; value: LPCSTR; param: INT): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsetlogintime')]
function dbsetlogintime(seconds: INT): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsetlpacket')]
function dbsetlpacket(login: PLOGINREC; packet_size: USHORT): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsetnull')]
function dbsetnull(dbproc: PDBPROCESS; bindtype, bindlen: INT; bindval: LPCBYTE): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'dbsetopt')]
function dbsetopt(dbproc: PDBPROCESS; option: INT; param: LPCSTR): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsettime')]
function dbsettime(seconds: INT): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsqlexec')]
function dbsqlexec(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsqlok')]
function dbsqlok(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbsqlsend')]
function dbsqlsend(dbproc: PDBPROCESS): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbuse')]
function dbuse(dbproc: PDBPROCESS; dbname: LPCSTR): RETCODE; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbwillconvert')]
function dbwillconvert(srctype, desttype: INT): BOOL; external;

[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dberrhandle')]
function dberrhandle(handler: TDBERRHANDLE_PROC): TDBERRHANDLE_PROC; external;
[DllImport(DefSqlApiDLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'dbmsghandle')]
function dbmsghandle(handler: TDBMSGHANDLE_PROC): TDBMSGHANDLE_PROC; external;

        // it is necessary to convert stdcall callback to cdecl callback function, which is not supported by Delphi 8
[DllImport(CLRHelperDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'MssSetErrHandler')]
function MssSetErrHandler(const hLib: HModule; hErr: TDBERRHANDLE_PROC; hMsg: TDBMSGHANDLE_PROC): Integer; external;

{$ENDIF}

implementation

const
  APP_CONNECT_MAX	= 100;	// max connections permits

  IsolLevelCmd: array[TISqlTransIsolation] of string =
  	('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED',
         'SET TRANSACTION ISOLATION LEVEL READ COMMITTED',
         'SET TRANSACTION ISOLATION LEVEL REPEATABLE READ'
        );

  SDummySelect  = 'select 1 from sysobjects where 1=0';

  OPT_DBTEXTLIMIT	= '2147483647';
  OPT_DBTEXTSIZE	= OPT_DBTEXTLIMIT;

  CRLF = #$0D#$0A;

  QuoteChar	= '"';	// for surroundings of the parameter's name, which can include, for example, spaces

const
  { Converting from TFieldType to SQL Data Type(SQLServer) - used in stored procedure bind }
  SrvNativeDataTypes: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	SQLVARCHAR, 	SQLINT2, SQLINT4, SQLINT2, SQLINT2,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        SQLFLT8,	SQLFLT8,0, SQLDATETIME, SQLDATETIME,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SQLDATETIME, 	SQLBINARY, SQLBINARY,	0, 	SQLIMAGE,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SQLTEXT,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
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

var     // it is important in Delphi 8 for .NET
  RefErrHandler: TDBERRHANDLE_PROC;
  RefMsgHandler: TDBMSGHANDLE_PROC;

type
        // error list can contain errors for some dbprocesses (for example, in multithreaded application)
  TMssErrorList = class(TThreadList)
  private
    function GetError(Index: Integer): ESDMssError;
  public
    destructor Destroy; override;
    function Find(dbproc: PDBPROCESS; Remove: Boolean): ESDMssError;    
    property Errors[Index: Integer]: ESDMssError read GetError;
  end;

{ TMssErrorList }
destructor TMssErrorList.Destroy;
var
  i: Integer;
  L: TList;
begin
  L := LockList;
  try
    for i:=0 to L.Count-1 do
      ESDMssError( L[i] ).Free;
  finally
    UnlockList;
  end;

  inherited;
end;

function TMssErrorList.Find(dbproc: PDBPROCESS; Remove: Boolean): ESDMssError;
var
  i: Integer;
  L: TList;
  E: ESDMssError;
begin
  Result := nil;
  L := LockList;
  try
    for i := L.Count-1 downto 0 do begin
      E := ESDMssError( L[i] );
      // this is a bit weak - on dbopen() error we don't have dbproc, so pop last error
      if (E.HProcess = dbproc) or (dbproc = nil) then begin
        if Remove then
          L.Delete(i);
        Result := E;
        Break;
      end;
    end;
  finally
    UnlockList;
  end;
end;

function TMssErrorList.GetError(Index: Integer): ESDMssError;
var
  L: TList;
begin
  L := LockList;
  try
    Result := ESDMssError( L[Index] );
  finally
    UnlockList;
  end;
end;

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrLibInit		= 'Error initialization of DB-library';
  SErrFuncNotFound	= 'Function ''%s'' not found in MS SQLServer DB-library';
  SErrDBProcIsNull	= 'Unable to allocate DBPROCESS connection structure';

var
  DbErrorList: TMssErrorList;
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;
  dwLoadedDBLIB: LongInt;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istSQLServer) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIMssDatabase.Create( ADbParams );
end;

(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure SetProcAddresses;
begin
{$IFNDEF XSQL_CLR}
  @abort_xact           := GetProcAddress(hSqlLibModule, 'abort_xact');  	ASSERT( @abort_xact       <>nil, Format(SErrFuncNotFound, ['abort_xact       ']) );
  @build_xact_string    := GetProcAddress(hSqlLibModule, 'build_xact_string');  ASSERT( @build_xact_string<>nil, Format(SErrFuncNotFound, ['build_xact_string']) );
  @close_commit         := GetProcAddress(hSqlLibModule, 'close_commit');  	ASSERT( @close_commit     <>nil, Format(SErrFuncNotFound, ['close_commit     ']) );
  @commit_xact          := GetProcAddress(hSqlLibModule, 'commit_xact');  	ASSERT( @commit_xact      <>nil, Format(SErrFuncNotFound, ['commit_xact      ']) );
  @open_commit          := GetProcAddress(hSqlLibModule, 'open_commit');  	ASSERT( @open_commit      <>nil, Format(SErrFuncNotFound, ['open_commit      ']) );
  @remove_xact          := GetProcAddress(hSqlLibModule, 'remove_xact');  	ASSERT( @remove_xact      <>nil, Format(SErrFuncNotFound, ['remove_xact      ']) );
//  @scan_xact            := GetProcAddress(hSqlLibModule, 'scan_xact');  	ASSERT( @scan_xact        <>nil, Format(SErrFuncNotFound, ['scan_xact        ']) );
  @start_xact           := GetProcAddress(hSqlLibModule, 'start_xact');  	ASSERT( @start_xact       <>nil, Format(SErrFuncNotFound, ['start_xact       ']) );
  @stat_xact            := GetProcAddress(hSqlLibModule, 'stat_xact');  	ASSERT( @stat_xact        <>nil, Format(SErrFuncNotFound, ['stat_xact        ']) );
  @bcp_batch            := GetProcAddress(hSqlLibModule, 'bcp_batch');  	ASSERT( @bcp_batch        <>nil, Format(SErrFuncNotFound, ['bcp_batch        ']) );
  @bcp_bind             := GetProcAddress(hSqlLibModule, 'bcp_bind');  		ASSERT( @bcp_bind         <>nil, Format(SErrFuncNotFound, ['bcp_bind         ']) );
  @bcp_colfmt           := GetProcAddress(hSqlLibModule, 'bcp_colfmt');  	ASSERT( @bcp_colfmt       <>nil, Format(SErrFuncNotFound, ['bcp_colfmt       ']) );
  @bcp_collen           := GetProcAddress(hSqlLibModule, 'bcp_collen');  	ASSERT( @bcp_collen       <>nil, Format(SErrFuncNotFound, ['bcp_collen       ']) );
  @bcp_colptr           := GetProcAddress(hSqlLibModule, 'bcp_colptr');  	ASSERT( @bcp_colptr       <>nil, Format(SErrFuncNotFound, ['bcp_colptr       ']) );
  @bcp_columns          := GetProcAddress(hSqlLibModule, 'bcp_columns');  	ASSERT( @bcp_columns      <>nil, Format(SErrFuncNotFound, ['bcp_columns      ']) );
  @bcp_control          := GetProcAddress(hSqlLibModule, 'bcp_control');  	ASSERT( @bcp_control      <>nil, Format(SErrFuncNotFound, ['bcp_control      ']) );
  @bcp_done             := GetProcAddress(hSqlLibModule, 'bcp_done');  		ASSERT( @bcp_done         <>nil, Format(SErrFuncNotFound, ['bcp_done         ']) );
  @bcp_exec             := GetProcAddress(hSqlLibModule, 'bcp_exec');  		ASSERT( @bcp_exec         <>nil, Format(SErrFuncNotFound, ['bcp_exec         ']) );
  @bcp_init             := GetProcAddress(hSqlLibModule, 'bcp_init');  		ASSERT( @bcp_init         <>nil, Format(SErrFuncNotFound, ['bcp_init         ']) );
  @bcp_moretext         := GetProcAddress(hSqlLibModule, 'bcp_moretext');  	ASSERT( @bcp_moretext     <>nil, Format(SErrFuncNotFound, ['bcp_moretext     ']) );
  @bcp_readfmt          := GetProcAddress(hSqlLibModule, 'bcp_readfmt');  	ASSERT( @bcp_readfmt      <>nil, Format(SErrFuncNotFound, ['bcp_readfmt      ']) );
  @bcp_sendrow          := GetProcAddress(hSqlLibModule, 'bcp_sendrow');  	ASSERT( @bcp_sendrow      <>nil, Format(SErrFuncNotFound, ['bcp_sendrow      ']) );
  @bcp_setl             := GetProcAddress(hSqlLibModule, 'bcp_setl');  		ASSERT( @bcp_setl         <>nil, Format(SErrFuncNotFound, ['bcp_setl         ']) );
  @bcp_writefmt         := GetProcAddress(hSqlLibModule, 'bcp_writefmt');  	ASSERT( @bcp_writefmt     <>nil, Format(SErrFuncNotFound, ['bcp_writefmt     ']) );
  @dbadata              := GetProcAddress(hSqlLibModule, 'dbadata');  		ASSERT( @dbadata          <>nil, Format(SErrFuncNotFound, ['dbadata          ']) );
  @dbadlen              := GetProcAddress(hSqlLibModule, 'dbadlen');  		ASSERT( @dbadlen          <>nil, Format(SErrFuncNotFound, ['dbadlen          ']) );
  @dbaltbind            := GetProcAddress(hSqlLibModule, 'dbaltbind');  	ASSERT( @dbaltbind        <>nil, Format(SErrFuncNotFound, ['dbaltbind        ']) );
  @dbaltcolid           := GetProcAddress(hSqlLibModule, 'dbaltcolid');  	ASSERT( @dbaltcolid       <>nil, Format(SErrFuncNotFound, ['dbaltcolid       ']) );
  @dbaltlen             := GetProcAddress(hSqlLibModule, 'dbaltlen');  		ASSERT( @dbaltlen         <>nil, Format(SErrFuncNotFound, ['dbaltlen         ']) );
  @dbaltop              := GetProcAddress(hSqlLibModule, 'dbaltop');  		ASSERT( @dbaltop          <>nil, Format(SErrFuncNotFound, ['dbaltop          ']) );
  @dbalttype            := GetProcAddress(hSqlLibModule, 'dbalttype');  	ASSERT( @dbalttype        <>nil, Format(SErrFuncNotFound, ['dbalttype        ']) );
  @dbaltutype           := GetProcAddress(hSqlLibModule, 'dbaltutype');  	ASSERT( @dbaltutype       <>nil, Format(SErrFuncNotFound, ['dbaltutype       ']) );
  @dbanullbind          := GetProcAddress(hSqlLibModule, 'dbanullbind');  	ASSERT( @dbanullbind      <>nil, Format(SErrFuncNotFound, ['dbanullbind      ']) );
  @dbbind               := GetProcAddress(hSqlLibModule, 'dbbind');  		ASSERT( @dbbind           <>nil, Format(SErrFuncNotFound, ['dbbind           ']) );
  @dbbylist             := GetProcAddress(hSqlLibModule, 'dbbylist');  		ASSERT( @dbbylist         <>nil, Format(SErrFuncNotFound, ['dbbylist         ']) );
  @dbcancel             := GetProcAddress(hSqlLibModule, 'dbcancel');  		ASSERT( @dbcancel         <>nil, Format(SErrFuncNotFound, ['dbcancel         ']) );
  @dbcanquery           := GetProcAddress(hSqlLibModule, 'dbcanquery');  	ASSERT( @dbcanquery       <>nil, Format(SErrFuncNotFound, ['dbcanquery       ']) );
  @dbchange             := GetProcAddress(hSqlLibModule, 'dbchange');  		ASSERT( @dbchange         <>nil, Format(SErrFuncNotFound, ['dbchange         ']) );
  @dbclose              := GetProcAddress(hSqlLibModule, 'dbclose');  		ASSERT( @dbclose          <>nil, Format(SErrFuncNotFound, ['dbclose          ']) );
  @dbclrbuf             := GetProcAddress(hSqlLibModule, 'dbclrbuf');  		ASSERT( @dbclrbuf         <>nil, Format(SErrFuncNotFound, ['dbclrbuf         ']) );
  @dbclropt             := GetProcAddress(hSqlLibModule, 'dbclropt');  		ASSERT( @dbclropt         <>nil, Format(SErrFuncNotFound, ['dbclropt         ']) );
  @dbcmd                := GetProcAddress(hSqlLibModule, 'dbcmd');  		ASSERT( @dbcmd            <>nil, Format(SErrFuncNotFound, ['dbcmd            ']) );
  @dbcmdrow             := GetProcAddress(hSqlLibModule, 'dbcmdrow');  		ASSERT( @dbcmdrow         <>nil, Format(SErrFuncNotFound, ['dbcmdrow         ']) );
  @dbcolbrowse          := GetProcAddress(hSqlLibModule, 'dbcolbrowse');  	ASSERT( @dbcolbrowse      <>nil, Format(SErrFuncNotFound, ['dbcolbrowse      ']) );
  @dbcolinfo            := GetProcAddress(hSqlLibModule, 'dbcolinfo');  	ASSERT( @dbcolinfo        <>nil, Format(SErrFuncNotFound, ['dbcolinfo        ']) );
  @dbcollen             := GetProcAddress(hSqlLibModule, 'dbcollen');  		ASSERT( @dbcollen         <>nil, Format(SErrFuncNotFound, ['dbcollen         ']) );
  @dbcolname            := GetProcAddress(hSqlLibModule, 'dbcolname');  	ASSERT( @dbcolname        <>nil, Format(SErrFuncNotFound, ['dbcolname        ']) );
  @dbcolsource          := GetProcAddress(hSqlLibModule, 'dbcolsource');  	ASSERT( @dbcolsource      <>nil, Format(SErrFuncNotFound, ['dbcolsource      ']) );
  @dbcoltype            := GetProcAddress(hSqlLibModule, 'dbcoltype');  	ASSERT( @dbcoltype        <>nil, Format(SErrFuncNotFound, ['dbcoltype        ']) );
  @dbcolutype           := GetProcAddress(hSqlLibModule, 'dbcolutype');  	ASSERT( @dbcolutype       <>nil, Format(SErrFuncNotFound, ['dbcolutype       ']) );
  @dbconvert            := GetProcAddress(hSqlLibModule, 'dbconvert');  	ASSERT( @dbconvert        <>nil, Format(SErrFuncNotFound, ['dbconvert        ']) );
  @dbcount              := GetProcAddress(hSqlLibModule, 'dbcount');  		ASSERT( @dbcount          <>nil, Format(SErrFuncNotFound, ['dbcount          ']) );
  @dbcurcmd             := GetProcAddress(hSqlLibModule, 'dbcurcmd');  		ASSERT( @dbcurcmd         <>nil, Format(SErrFuncNotFound, ['dbcurcmd         ']) );
  @dbcurrow             := GetProcAddress(hSqlLibModule, 'dbcurrow');  		ASSERT( @dbcurrow         <>nil, Format(SErrFuncNotFound, ['dbcurrow         ']) );
  @dbcursor             := GetProcAddress(hSqlLibModule, 'dbcursor');  		ASSERT( @dbcursor         <>nil, Format(SErrFuncNotFound, ['dbcursor         ']) );
  @dbcursorbind         := GetProcAddress(hSqlLibModule, 'dbcursorbind');  	ASSERT( @dbcursorbind     <>nil, Format(SErrFuncNotFound, ['dbcursorbind     ']) );
  @dbcursorclose        := GetProcAddress(hSqlLibModule, 'dbcursorclose');  	ASSERT( @dbcursorclose    <>nil, Format(SErrFuncNotFound, ['dbcursorclose    ']) );
  @dbcursorcolinfo      := GetProcAddress(hSqlLibModule, 'dbcursorcolinfo');  	ASSERT( @dbcursorcolinfo  <>nil, Format(SErrFuncNotFound, ['dbcursorcolinfo  ']) );
  @dbcursorfetch        := GetProcAddress(hSqlLibModule, 'dbcursorfetch');  	ASSERT( @dbcursorfetch    <>nil, Format(SErrFuncNotFound, ['dbcursorfetch    ']) );
  @dbcursorfetchex      := GetProcAddress(hSqlLibModule, 'dbcursorfetchex');  	ASSERT( @dbcursorfetchex  <>nil, Format(SErrFuncNotFound, ['dbcursorfetchex  ']) );
  @dbcursorinfo         := GetProcAddress(hSqlLibModule, 'dbcursorinfo');  	ASSERT( @dbcursorinfo     <>nil, Format(SErrFuncNotFound, ['dbcursorinfo     ']) );
  @dbcursorinfoex       := GetProcAddress(hSqlLibModule, 'dbcursorinfoex');  	ASSERT( @dbcursorinfoex   <>nil, Format(SErrFuncNotFound, ['dbcursorinfoex   ']) );
  @dbcursoropen         := GetProcAddress(hSqlLibModule, 'dbcursoropen');  	ASSERT( @dbcursoropen     <>nil, Format(SErrFuncNotFound, ['dbcursoropen     ']) );
  @dbdata               := GetProcAddress(hSqlLibModule, 'dbdata');  		ASSERT( @dbdata           <>nil, Format(SErrFuncNotFound, ['dbdata           ']) );
  @dbdataready          := GetProcAddress(hSqlLibModule, 'dbdataready');  	ASSERT( @dbdataready      <>nil, Format(SErrFuncNotFound, ['dbdataready      ']) );
  @dbdatecrack          := GetProcAddress(hSqlLibModule, 'dbdatecrack');  	ASSERT( @dbdatecrack      <>nil, Format(SErrFuncNotFound, ['dbdatecrack      ']) );
  @dbdatlen             := GetProcAddress(hSqlLibModule, 'dbdatlen');  		ASSERT( @dbdatlen         <>nil, Format(SErrFuncNotFound, ['dbdatlen         ']) );
  @dbdead               := GetProcAddress(hSqlLibModule, 'dbdead');  		ASSERT( @dbdead           <>nil, Format(SErrFuncNotFound, ['dbdead           ']) );
  @dbexit               := GetProcAddress(hSqlLibModule, 'dbexit');  		ASSERT( @dbexit           <>nil, Format(SErrFuncNotFound, ['dbexit           ']) );
  @dbenlisttrans        := GetProcAddress(hSqlLibModule, 'dbenlisttrans');  	ASSERT( @dbenlisttrans    <>nil, Format(SErrFuncNotFound, ['dbenlisttrans    ']) );
  @dbenlistxatrans      := GetProcAddress(hSqlLibModule, 'dbenlistxatrans');  	ASSERT( @dbenlistxatrans  <>nil, Format(SErrFuncNotFound, ['dbenlistxatrans  ']) );
  @dbfirstrow           := GetProcAddress(hSqlLibModule, 'dbfirstrow');  	ASSERT( @dbfirstrow       <>nil, Format(SErrFuncNotFound, ['dbfirstrow       ']) );
  @dbfreebuf            := GetProcAddress(hSqlLibModule, 'dbfreebuf');  	ASSERT( @dbfreebuf        <>nil, Format(SErrFuncNotFound, ['dbfreebuf        ']) );
  @dbfreelogin          := GetProcAddress(hSqlLibModule, 'dbfreelogin');  	ASSERT( @dbfreelogin      <>nil, Format(SErrFuncNotFound, ['dbfreelogin      ']) );
  @dbfreequal           := GetProcAddress(hSqlLibModule, 'dbfreequal');  	ASSERT( @dbfreequal       <>nil, Format(SErrFuncNotFound, ['dbfreequal       ']) );
  @dbgetchar            := GetProcAddress(hSqlLibModule, 'dbgetchar');  	ASSERT( @dbgetchar        <>nil, Format(SErrFuncNotFound, ['dbgetchar        ']) );
  @dbgetmaxprocs        := GetProcAddress(hSqlLibModule, 'dbgetmaxprocs');  	ASSERT( @dbgetmaxprocs    <>nil, Format(SErrFuncNotFound, ['dbgetmaxprocs    ']) );
  @dbgetoff             := GetProcAddress(hSqlLibModule, 'dbgetoff');  		ASSERT( @dbgetoff         <>nil, Format(SErrFuncNotFound, ['dbgetoff         ']) );
  @dbgetpacket          := GetProcAddress(hSqlLibModule, 'dbgetpacket');  	ASSERT( @dbgetpacket      <>nil, Format(SErrFuncNotFound, ['dbgetpacket      ']) );
  @dbgetrow             := GetProcAddress(hSqlLibModule, 'dbgetrow');  		ASSERT( @dbgetrow         <>nil, Format(SErrFuncNotFound, ['dbgetrow         ']) );
  @dbgettime            := GetProcAddress(hSqlLibModule, 'dbgettime');  	ASSERT( @dbgettime        <>nil, Format(SErrFuncNotFound, ['dbgettime        ']) );
  @dbgetuserdata        := GetProcAddress(hSqlLibModule, 'dbgetuserdata');  	ASSERT( @dbgetuserdata    <>nil, Format(SErrFuncNotFound, ['dbgetuserdata    ']) );
  @dbhasretstat         := GetProcAddress(hSqlLibModule, 'dbhasretstat');  	ASSERT( @dbhasretstat     <>nil, Format(SErrFuncNotFound, ['dbhasretstat     ']) );
  @dbinit               := GetProcAddress(hSqlLibModule, 'dbinit');  		ASSERT( @dbinit           <>nil, Format(SErrFuncNotFound, ['dbinit           ']) );
  @dbisavail            := GetProcAddress(hSqlLibModule, 'dbisavail');  	ASSERT( @dbisavail        <>nil, Format(SErrFuncNotFound, ['dbisavail        ']) );
  @dbiscount            := GetProcAddress(hSqlLibModule, 'dbiscount');  	ASSERT( @dbiscount        <>nil, Format(SErrFuncNotFound, ['dbiscount        ']) );
  @dbisopt              := GetProcAddress(hSqlLibModule, 'dbisopt');  		ASSERT( @dbisopt          <>nil, Format(SErrFuncNotFound, ['dbisopt          ']) );
  @dblastrow            := GetProcAddress(hSqlLibModule, 'dblastrow');  	ASSERT( @dblastrow        <>nil, Format(SErrFuncNotFound, ['dblastrow        ']) );
  @dblogin              := GetProcAddress(hSqlLibModule, 'dblogin');  		ASSERT( @dblogin          <>nil, Format(SErrFuncNotFound, ['dblogin          ']) );
  @dbmorecmds           := GetProcAddress(hSqlLibModule, 'dbmorecmds');  	ASSERT( @dbmorecmds       <>nil, Format(SErrFuncNotFound, ['dbmorecmds       ']) );
  @dbmoretext           := GetProcAddress(hSqlLibModule, 'dbmoretext');  	ASSERT( @dbmoretext       <>nil, Format(SErrFuncNotFound, ['dbmoretext       ']) );
  @dbname               := GetProcAddress(hSqlLibModule, 'dbname');  		ASSERT( @dbname           <>nil, Format(SErrFuncNotFound, ['dbname           ']) );
  @dbnextrow            := GetProcAddress(hSqlLibModule, 'dbnextrow');  	ASSERT( @dbnextrow        <>nil, Format(SErrFuncNotFound, ['dbnextrow        ']) );
  @dbnullbind           := GetProcAddress(hSqlLibModule, 'dbnullbind');  	ASSERT( @dbnullbind       <>nil, Format(SErrFuncNotFound, ['dbnullbind       ']) );
  @dbnumalts            := GetProcAddress(hSqlLibModule, 'dbnumalts');  	ASSERT( @dbnumalts        <>nil, Format(SErrFuncNotFound, ['dbnumalts        ']) );
  @dbnumcols            := GetProcAddress(hSqlLibModule, 'dbnumcols');  	ASSERT( @dbnumcols        <>nil, Format(SErrFuncNotFound, ['dbnumcols        ']) );
  @dbnumcompute         := GetProcAddress(hSqlLibModule, 'dbnumcompute');  	ASSERT( @dbnumcompute     <>nil, Format(SErrFuncNotFound, ['dbnumcompute     ']) );
  @dbnumorders          := GetProcAddress(hSqlLibModule, 'dbnumorders');  	ASSERT( @dbnumorders      <>nil, Format(SErrFuncNotFound, ['dbnumorders      ']) );
  @dbnumrets            := GetProcAddress(hSqlLibModule, 'dbnumrets');  	ASSERT( @dbnumrets        <>nil, Format(SErrFuncNotFound, ['dbnumrets        ']) );
  @dbopen               := GetProcAddress(hSqlLibModule, 'dbopen');  		ASSERT( @dbopen           <>nil, Format(SErrFuncNotFound, ['dbopen           ']) );
  @dbordercol           := GetProcAddress(hSqlLibModule, 'dbordercol');  	ASSERT( @dbordercol       <>nil, Format(SErrFuncNotFound, ['dbordercol       ']) );
  @dbprocinfo           := GetProcAddress(hSqlLibModule, 'dbprocinfo');  	ASSERT( @dbprocinfo       <>nil, Format(SErrFuncNotFound, ['dbprocinfo       ']) );
  @dbprhead             := GetProcAddress(hSqlLibModule, 'dbprhead');  		ASSERT( @dbprhead         <>nil, Format(SErrFuncNotFound, ['dbprhead         ']) );
  @dbprrow              := GetProcAddress(hSqlLibModule, 'dbprrow');  		ASSERT( @dbprrow          <>nil, Format(SErrFuncNotFound, ['dbprrow          ']) );
  @dbprtype             := GetProcAddress(hSqlLibModule, 'dbprtype');  		ASSERT( @dbprtype         <>nil, Format(SErrFuncNotFound, ['dbprtype         ']) );
  @dbqual               := GetProcAddress(hSqlLibModule, 'dbqual');  		ASSERT( @dbqual           <>nil, Format(SErrFuncNotFound, ['dbqual           ']) );
  @dbreadtext           := GetProcAddress(hSqlLibModule, 'dbreadtext');  	ASSERT( @dbreadtext       <>nil, Format(SErrFuncNotFound, ['dbreadtext       ']) );
  @dbresults            := GetProcAddress(hSqlLibModule, 'dbresults');  	ASSERT( @dbresults        <>nil, Format(SErrFuncNotFound, ['dbresults        ']) );
  @dbretdata            := GetProcAddress(hSqlLibModule, 'dbretdata');  	ASSERT( @dbretdata        <>nil, Format(SErrFuncNotFound, ['dbretdata        ']) );
  @dbretlen             := GetProcAddress(hSqlLibModule, 'dbretlen');  		ASSERT( @dbretlen         <>nil, Format(SErrFuncNotFound, ['dbretlen         ']) );
  @dbretname            := GetProcAddress(hSqlLibModule, 'dbretname');  	ASSERT( @dbretname        <>nil, Format(SErrFuncNotFound, ['dbretname        ']) );
  @dbretstatus          := GetProcAddress(hSqlLibModule, 'dbretstatus');  	ASSERT( @dbretstatus      <>nil, Format(SErrFuncNotFound, ['dbretstatus      ']) );
  @dbrettype            := GetProcAddress(hSqlLibModule, 'dbrettype');  	ASSERT( @dbrettype        <>nil, Format(SErrFuncNotFound, ['dbrettype        ']) );
  @dbrows               := GetProcAddress(hSqlLibModule, 'dbrows');  		ASSERT( @dbrows           <>nil, Format(SErrFuncNotFound, ['dbrows           ']) );
  @dbrowtype            := GetProcAddress(hSqlLibModule, 'dbrowtype');  	ASSERT( @dbrowtype        <>nil, Format(SErrFuncNotFound, ['dbrowtype        ']) );
  @dbrpcinit            := GetProcAddress(hSqlLibModule, 'dbrpcinit');  	ASSERT( @dbrpcinit        <>nil, Format(SErrFuncNotFound, ['dbrpcinit        ']) );
  @dbrpcparam           := GetProcAddress(hSqlLibModule, 'dbrpcparam');  	ASSERT( @dbrpcparam       <>nil, Format(SErrFuncNotFound, ['dbrpcparam       ']) );
  @dbrpcsend            := GetProcAddress(hSqlLibModule, 'dbrpcsend');  	ASSERT( @dbrpcsend        <>nil, Format(SErrFuncNotFound, ['dbrpcsend        ']) );
  @dbrpcexec            := GetProcAddress(hSqlLibModule, 'dbrpcexec');  	ASSERT( @dbrpcexec        <>nil, Format(SErrFuncNotFound, ['dbrpcexec        ']) );
  @dbserverenum         := GetProcAddress(hSqlLibModule, 'dbserverenum');  	ASSERT( @dbserverenum     <>nil, Format(SErrFuncNotFound, ['dbserverenum     ']) );
  @dbsetavail           := GetProcAddress(hSqlLibModule, 'dbsetavail');  	ASSERT( @dbsetavail       <>nil, Format(SErrFuncNotFound, ['dbsetavail       ']) );
  @dbsetmaxprocs        := GetProcAddress(hSqlLibModule, 'dbsetmaxprocs');  	ASSERT( @dbsetmaxprocs    <>nil, Format(SErrFuncNotFound, ['dbsetmaxprocs    ']) );
  @dbsetlname           := GetProcAddress(hSqlLibModule, 'dbsetlname');  	ASSERT( @dbsetlname       <>nil, Format(SErrFuncNotFound, ['dbsetlname       ']) );
  @dbsetlogintime       := GetProcAddress(hSqlLibModule, 'dbsetlogintime');  	ASSERT( @dbsetlogintime   <>nil, Format(SErrFuncNotFound, ['dbsetlogintime   ']) );
  @dbsetlpacket         := GetProcAddress(hSqlLibModule, 'dbsetlpacket');  	ASSERT( @dbsetlpacket     <>nil, Format(SErrFuncNotFound, ['dbsetlpacket     ']) );
  @dbsetnull            := GetProcAddress(hSqlLibModule, 'dbsetnull');  	ASSERT( @dbsetnull        <>nil, Format(SErrFuncNotFound, ['dbsetnull        ']) );
  @dbsetopt             := GetProcAddress(hSqlLibModule, 'dbsetopt');  		ASSERT( @dbsetopt         <>nil, Format(SErrFuncNotFound, ['dbsetopt         ']) );
  @dbsettime            := GetProcAddress(hSqlLibModule, 'dbsettime');  	ASSERT( @dbsettime        <>nil, Format(SErrFuncNotFound, ['dbsettime        ']) );
  @dbsetuserdata        := GetProcAddress(hSqlLibModule, 'dbsetuserdata');  	ASSERT( @dbsetuserdata    <>nil, Format(SErrFuncNotFound, ['dbsetuserdata    ']) );
  @dbsqlexec            := GetProcAddress(hSqlLibModule, 'dbsqlexec');  	ASSERT( @dbsqlexec        <>nil, Format(SErrFuncNotFound, ['dbsqlexec        ']) );
  @dbsqlok              := GetProcAddress(hSqlLibModule, 'dbsqlok');  		ASSERT( @dbsqlok          <>nil, Format(SErrFuncNotFound, ['dbsqlok          ']) );
  @dbsqlsend            := GetProcAddress(hSqlLibModule, 'dbsqlsend');  	ASSERT( @dbsqlsend        <>nil, Format(SErrFuncNotFound, ['dbsqlsend        ']) );
  @dbstrcpy             := GetProcAddress(hSqlLibModule, 'dbstrcpy');  		ASSERT( @dbstrcpy         <>nil, Format(SErrFuncNotFound, ['dbstrcpy         ']) );
  @dbstrlen             := GetProcAddress(hSqlLibModule, 'dbstrlen');  		ASSERT( @dbstrlen         <>nil, Format(SErrFuncNotFound, ['dbstrlen         ']) );
  @dbtabbrowse          := GetProcAddress(hSqlLibModule, 'dbtabbrowse');  	ASSERT( @dbtabbrowse      <>nil, Format(SErrFuncNotFound, ['dbtabbrowse      ']) );
  @dbtabcount           := GetProcAddress(hSqlLibModule, 'dbtabcount');  	ASSERT( @dbtabcount       <>nil, Format(SErrFuncNotFound, ['dbtabcount       ']) );
  @dbtabname            := GetProcAddress(hSqlLibModule, 'dbtabname');  	ASSERT( @dbtabname        <>nil, Format(SErrFuncNotFound, ['dbtabname        ']) );
  @dbtabsource          := GetProcAddress(hSqlLibModule, 'dbtabsource');  	ASSERT( @dbtabsource      <>nil, Format(SErrFuncNotFound, ['dbtabsource      ']) );
  @dbtsnewlen           := GetProcAddress(hSqlLibModule, 'dbtsnewlen');  	ASSERT( @dbtsnewlen       <>nil, Format(SErrFuncNotFound, ['dbtsnewlen       ']) );
  @dbtsnewval           := GetProcAddress(hSqlLibModule, 'dbtsnewval');  	ASSERT( @dbtsnewval       <>nil, Format(SErrFuncNotFound, ['dbtsnewval       ']) );
  @dbtsput              := GetProcAddress(hSqlLibModule, 'dbtsput');  		ASSERT( @dbtsput          <>nil, Format(SErrFuncNotFound, ['dbtsput          ']) );
  @dbtxptr              := GetProcAddress(hSqlLibModule, 'dbtxptr');  		ASSERT( @dbtxptr          <>nil, Format(SErrFuncNotFound, ['dbtxptr          ']) );
  @dbtxtimestamp        := GetProcAddress(hSqlLibModule, 'dbtxtimestamp');  	ASSERT( @dbtxtimestamp    <>nil, Format(SErrFuncNotFound, ['dbtxtimestamp    ']) );
  @dbtxtsnewval         := GetProcAddress(hSqlLibModule, 'dbtxtsnewval');  	ASSERT( @dbtxtsnewval     <>nil, Format(SErrFuncNotFound, ['dbtxtsnewval     ']) );
  @dbtxtsput            := GetProcAddress(hSqlLibModule, 'dbtxtsput');  	ASSERT( @dbtxtsput        <>nil, Format(SErrFuncNotFound, ['dbtxtsput        ']) );
  @dbuse                := GetProcAddress(hSqlLibModule, 'dbuse');  		ASSERT( @dbuse            <>nil, Format(SErrFuncNotFound, ['dbuse            ']) );
  @dbvarylen            := GetProcAddress(hSqlLibModule, 'dbvarylen');  	ASSERT( @dbvarylen        <>nil, Format(SErrFuncNotFound, ['dbvarylen        ']) );
  @dbwillconvert        := GetProcAddress(hSqlLibModule, 'dbwillconvert');  	ASSERT( @dbwillconvert    <>nil, Format(SErrFuncNotFound, ['dbwillconvert    ']) );
  @dbwritetext          := GetProcAddress(hSqlLibModule, 'dbwritetext');  	ASSERT( @dbwritetext      <>nil, Format(SErrFuncNotFound, ['dbwritetext      ']) );
  @dbupdatetext         := GetProcAddress(hSqlLibModule, 'dbupdatetext');  	ASSERT( @dbupdatetext     <>nil, Format(SErrFuncNotFound, ['dbupdatetext     ']) );

  @dberrhandle         := GetProcAddress(hSqlLibModule, 'dberrhandle');  	ASSERT( @dberrhandle     <>nil, Format(SErrFuncNotFound, ['dberrhandle     ']) );
  @dbmsghandle         := GetProcAddress(hSqlLibModule, 'dbmsghandle');  	ASSERT( @dbmsghandle     <>nil, Format(SErrFuncNotFound, ['dbmsghandle     ']) );
  @dbprocerrhandle     := GetProcAddress(hSqlLibModule, 'dbprocerrhandle');  	ASSERT( @dbprocerrhandle <>nil, Format(SErrFuncNotFound, ['dbprocerrhandle     ']) );
  @dbprocmsghandle     := GetProcAddress(hSqlLibModule, 'dbprocmsghandle');  	ASSERT( @dbprocmsghandle <>nil, Format(SErrFuncNotFound, ['dbprocmsghandle     ']) );
{$ENDIF}
end;

procedure ResetProcAddresses;
begin
{$IFNDEF XSQL_CLR}
  @abort_xact           := nil;
  @build_xact_string    := nil;
  @close_commit         := nil;
  @commit_xact          := nil;
  @open_commit          := nil;
  @remove_xact          := nil;
  @scan_xact            := nil;
  @start_xact           := nil;
  @stat_xact            := nil;
  @bcp_batch            := nil;
  @bcp_bind             := nil;
  @bcp_colfmt           := nil;
  @bcp_collen           := nil;
  @bcp_colptr           := nil;
  @bcp_columns          := nil;
  @bcp_control          := nil;
  @bcp_done             := nil;
  @bcp_exec             := nil;
  @bcp_init             := nil;
  @bcp_moretext         := nil;
  @bcp_readfmt          := nil;
  @bcp_sendrow          := nil;
  @bcp_setl             := nil;
  @bcp_writefmt         := nil;
  @dbadata              := nil;
  @dbadlen              := nil;
  @dbaltbind            := nil;
  @dbaltcolid           := nil;
  @dbaltlen             := nil;
  @dbaltop              := nil;
  @dbalttype            := nil;
  @dbaltutype           := nil;
  @dbanullbind          := nil;
  @dbbind               := nil;
  @dbbylist             := nil;
  @dbcancel             := nil;
  @dbcanquery           := nil;
  @dbchange             := nil;
  @dbclose              := nil;
  @dbclrbuf             := nil;
  @dbclropt             := nil;
  @dbcmd                := nil;
  @dbcmdrow             := nil;
  @dbcolbrowse          := nil;
  @dbcolinfo            := nil;
  @dbcollen             := nil;
  @dbcolname            := nil;
  @dbcolsource          := nil;
  @dbcoltype            := nil;
  @dbcolutype           := nil;
  @dbconvert            := nil;
  @dbcount              := nil;
  @dbcurcmd             := nil;
  @dbcurrow             := nil;
  @dbcursor             := nil;
  @dbcursorbind         := nil;
  @dbcursorclose        := nil;
  @dbcursorcolinfo      := nil;
  @dbcursorfetch        := nil;
  @dbcursorfetchex      := nil;
  @dbcursorinfo         := nil;
  @dbcursorinfoex       := nil;
  @dbcursoropen         := nil;
  @dbdata               := nil;
  @dbdataready          := nil;
  @dbdatecrack          := nil;
  @dbdatlen             := nil;
  @dbdead               := nil;
  @dbexit               := nil;
  @dbenlisttrans        := nil;
  @dbenlistxatrans      := nil;
  @dbfirstrow           := nil;
  @dbfreebuf            := nil;
  @dbfreelogin          := nil;
  @dbfreequal           := nil;
  @dbgetchar            := nil;
  @dbgetmaxprocs        := nil;
  @dbgetoff             := nil;
  @dbgetpacket          := nil;
  @dbgetrow             := nil;
  @dbgettime            := nil;
  @dbgetuserdata        := nil;
  @dbhasretstat         := nil;
  @dbinit               := nil;
  @dbisavail            := nil;
  @dbiscount            := nil;
  @dbisopt              := nil;
  @dblastrow            := nil;
  @dblogin              := nil;
  @dbmorecmds           := nil;
  @dbmoretext           := nil;
  @dbname               := nil;
  @dbnextrow            := nil;
  @dbnullbind           := nil;
  @dbnumalts            := nil;
  @dbnumcols            := nil;
  @dbnumcompute         := nil;
  @dbnumorders          := nil;
  @dbnumrets            := nil;
  @dbopen               := nil;
  @dbordercol           := nil;
  @dbprocinfo           := nil;
  @dbprhead             := nil;
  @dbprrow              := nil;
  @dbprtype             := nil;
  @dbqual               := nil;
  @dbreadtext           := nil;
  @dbresults            := nil;
  @dbretdata            := nil;
  @dbretlen             := nil;
  @dbretname            := nil;
  @dbretstatus          := nil;
  @dbrettype            := nil;
  @dbrows               := nil;
  @dbrowtype            := nil;
  @dbrpcinit            := nil;
  @dbrpcparam           := nil;
  @dbrpcsend            := nil;
  @dbrpcexec            := nil;
  @dbserverenum         := nil;
  @dbsetavail           := nil;
  @dbsetmaxprocs        := nil;
  @dbsetlname           := nil;
  @dbsetlogintime       := nil;
  @dbsetlpacket         := nil;
  @dbsetnull            := nil;
  @dbsetopt             := nil;
  @dbsettime            := nil;
  @dbsetuserdata        := nil;
  @dbsqlexec            := nil;
  @dbsqlok              := nil;
  @dbsqlsend            := nil;
  @dbstrcpy             := nil;
  @dbstrlen             := nil;
  @dbtabbrowse          := nil;
  @dbtabcount           := nil;
  @dbtabname            := nil;
  @dbtabsource          := nil;
  @dbtsnewlen           := nil;
  @dbtsnewval           := nil;
  @dbtsput              := nil;
  @dbtxptr              := nil;
  @dbtxtimestamp        := nil;
  @dbtxtsnewval         := nil;
  @dbtxtsput            := nil;
  @dbuse                := nil;
  @dbvarylen            := nil;
  @dbwillconvert        := nil;
  @dbwritetext          := nil;
  @dbupdatetext         := nil;

  @dberrhandle          := nil;
  @dbmsghandle          := nil;
  @dbprocerrhandle      := nil;
  @dbprocmsghandle      := nil;
{$ENDIF}
end;

{ ESDMssError }
constructor ESDMssError.Create(DbProc: PDBPROCESS; AErrorCode, ANativeError: TSDEResult;
  ASeverity: INT; const Msg: string; AErrorPos: LongInt);
begin
  inherited Create(AErrorCode, ANativeError, Msg, AErrorPos);

  FHProcess	:= DbProc;
  FSeverity	:= ASeverity;
end;

procedure SaveError(dbproc: PDBPROCESS; errno, severity: INT; errstr: string; line: DBUSMALLINT);
var
  E: ESDMssError;
  ErrPos: LongInt;
begin
  E := DbErrorList.Find( dbProc, False );
  ErrPos := -1;
  if line > 0 then
    ErrPos := line;
        // add a new error or change existing one
  if E = nil then begin
    E := ESDMssError.Create(dbproc, errno, errno, severity, errstr, ErrPos);
    DbErrorList.Add( E );
  end
{$IFNDEF XSQL_CLR}
  else	// Exception.Message is read-only property
    E.Message := E.Message + CRLF + errstr;
{$ENDIF}
end;

procedure ClearErrors(dbproc: PDBPROCESS);
var
  E: ESDMssError;
begin
  repeat
    E := DbErrorList.Find(dbProc, True);
    if Assigned(E) then
      E.Free;
  until E = nil;
end;

function ErrHandler(dbproc: PDBPROCESS; severity, dberr, oserr: INT; dberrstr, oserrstr: TSDCharPtr): INT; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
var
  sStr: string;
begin
  sStr := Format('DB-Library error %d: %s'#$0A#$0D, [dberr, HelperPtrToString( dberrstr )]);

  if (severity = EXCOMM) and ((oserr <> DBNOERR) or (oserrstr <> nil)) then
    sStr := sStr + Format('Net-Lib error %d:  %s'#$0A#$0D, [oserr, HelperPtrToString(oserrstr)]);

  if oserr <> DBNOERR then
    sStr := sStr + Format('Operating-system error: %s'#$0A#$0D, [HelperPtrToString(oserrstr)]);

  Result := INT_CANCEL;
    // If the query returns nothing (10086(SQLCRSFROWN) - row fetched outside valid range)
  if dberr = SQLCRSFROWN then
    Exit;
  if severity > EXINFO then
    SaveError(dbproc, dberr, severity, sStr, 0);
end;

function MsgHandler(dbproc: PDBPROCESS; msgno: DBINT; msgstate, severity: INT;
                           msgtext, srvname, procname: TSDCharPtr; line: DBUSMALLINT): INT; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
var
  sStr, sMsg: string;
begin
  Result := 0;
  sStr := Format('SQL Server message %d:', [msgno]);
  sMsg := HelperPtrToString( msgtext );
  if sMsg <> '' then
    sStr := sStr + Format(' %s', [sMsg]);
  if line <> 0 then
    sStr := sStr + Format('(line %d)', [line]);

    	// invalid RowNum(0): end of result set
  if msgno = 16902 then
    Exit;
  if severity > EXINFO then
    SaveError(dbproc, msgno, severity, sStr, line);
end;

procedure LoadSqlLib;
var
  sVer: TSDCharPtr;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      hSqlLibModule := HelperLoadLibrary( SqlApiDll );
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [ SqlApiDll ]);
      Inc(SqlLibRefCount);
      SetProcAddresses;

      RefErrHandler := @ErrHandler;
      RefMsgHandler := @MsgHandler;
{$IFDEF XSQL_CLR}
      if MssSetErrHandler(hSqlLibModule, RefErrHandler, RefMsgHandler) = 0 then
        raise ESDMssError.Create( nil, 0, 0, 0, 'Error in ' + CLRHelperDLL, 0 );
{$ELSE}
      dberrhandle( RefErrHandler );
      dbmsghandle( RefMsgHandler );
{$ENDIF}
    	// if 1-st loading DB-library
      if SqlLibRefCount = 1 then begin
	// dbinit, dbexit have to be called one time per an application
        if not IsLibrary then begin
          sVer := dbinit;
          if sVer = nil then
            raise ESDMssError.Create(nil, 0, 0, 0, SErrLibInit, 0);
          // for example: sVer ~= 'DB-Library version 6.50.252'
          dwLoadedDBLIB := VersionStringToDWORD( HelperPtrToString(sVer) );
        end;
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
	// dbinit, dbexit have to be called one time per an application
      if not IsLibrary then
        dbexit;	// closes and frees  all DBPROCESS structure of the current application

{$IFDEF XSQL_CLR}
      MssSetErrHandler(0, nil, nil);
{$ENDIF}

      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDll ]);
      Dec(SqlLibRefCount);
      ResetProcAddresses;
      dwLoadedDBLIB := 0;
      RefErrHandler := nil;
      RefMsgHandler := nil;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{ TIMssDatabase }
constructor TIMssDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle	:= nil;
  FCurSqlCmd	:= nil;
	// a procedure can return one or more result sets
  FProcSupportsCursors := True;
        // Consider a binary(16) and GUID as TGuidField. Default, it is False
  FByteAsGuid := UpperCase( Trim( Params.Values[szBYTE16ASGUID] ) ) = STrueString;
end;

destructor TIMssDatabase.Destroy;
begin
  FreeHandle;

  if AcquiredHandle then
    FreeSqlLib;

  inherited Destroy;
end;

function TIMssDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIMssCommand.Create( Self );
end;

// TIMssCommand can have different dbprocess handle
procedure TIMssDatabase.Check(dbproc: PDBPROCESS);
var
  E: ESDMssError;
begin
  ResetIdleTimeOut;
	// raise last error message for the specified dbprocess
  E := DbErrorList.Find(dbproc, True);
  if Assigned( E ) then
    raise E;
end;

{ Acquire DB handle for the specified ASqlCmd (Dataset) }
procedure TIMssDatabase.ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll, IsReset: Boolean);
var
  ds: TISqlCommand;
begin
  if Assigned(FCurSqlCmd) and (ASqlCmd <> FCurSqlCmd) then begin
    ds := FCurSqlCmd;
    FCurSqlCmd := nil;  // to exclude recursion in ReleaseDBHandle call
    try
      if IsFetchAll then
        ds.SaveResults; // ds will be destroyed, if DetachOnFetchAll is True
        // if DetachOnFetchAll = True, then Handle will be equal nil after SaveResults
      if IsReset and Assigned(ds.Handle) then begin
        dbcancel( ds.Handle );	// cancel execution of the current batch and eliminate any pending results
        HandleReset( ds.Handle );
        (ds as TIMssCommand).ResetExecuted;        
      end;
    except
      FCurSqlCmd := ds;
      raise;
    end;
  end;
  FCurSqlCmd := ASqlCmd;
end;

procedure TIMssDatabase.SetAutoCommitOption(Value: Boolean);
begin
end;

function TIMssDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;

procedure TIMssDatabase.HandleExecCmd(AHandle: PDBPROCESS; const Stmt: string);
var
  rcd: RETCODE;
  CmdPtr: TSDCharPtr;
begin
  ReleaseDBHandle(nil, True, True);		// release an acquired handle
//  HandleReset( DBProcPtr );
{$IFDEF XSQL_CLR}
  CmdPtr := Marshal.StringToHGlobalAnsi( Stmt );
{$ELSE}
  CmdPtr := PChar( Stmt );
{$ENDIF}
  try
    dbcmd( AHandle, CmdPtr );
    if dbsqlexec( AHandle ) <> SUCCEED then
      Check( AHandle );
    repeat
      rcd := dbresults( AHandle );
      if rcd = FAIL then
        Check( AHandle );
    until rcd <> SUCCEED;       // break to prevent infinite loop on errors without exception in Check method
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal( CmdPtr );
{$ENDIF}
  end;
end;

procedure TIMssDatabase.DoStartTransaction;
begin
	// in case of IMPLICIT_TRANSACTION (AutoCommit=False) mode executing SELECT,INSERT statements
        //will increase @@TRANCOUNT and Commit could not release all locks, so it isn't necessary to call BEGIN TRAN
  if not(AutoCommitDef or AutoCommit) then
    Exit;
        // This excludes using of embedded transactions
  HandleExecCmd( DBProcPtr, 'IF @@TRANCOUNT = 0 BEGIN BEGIN TRAN END' );
end;

procedure TIMssDatabase.DoCommit;
begin
  HandleExecCmd( DBProcPtr, 'IF @@TRANCOUNT > 0 BEGIN COMMIT TRAN END' );
end;

procedure TIMssDatabase.DoRollback;
begin
  HandleExecCmd( DBProcPtr, 'IF @@TRANCOUNT > 0 BEGIN ROLLBACK TRAN END' );
end;

function TIMssDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

function TIMssDatabase.GetDBProcPtr: PDBPROCESS;
begin
  ASSERT( Assigned(FHandle), 'TIMssDatabase.GetDBProcPtr' );
{$IFDEF XSQL_CLR}
  Result := TIMssConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMssConnInfo) ) ).DBProcPtr;
{$ELSE}
  Result := TIMssConnInfo(FHandle^).DBProcPtr;
{$ENDIF}
end;

function TIMssDatabase.GetLoginRecPtr: PLOGINREC;
begin
  ASSERT( Assigned(FHandle), 'TIMssDatabase.GetLoginRecPtr' );
{$IFDEF XSQL_CLR}
  Result := TIMssConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMssConnInfo) ) ).LoginRecPtr;
{$ELSE}
  Result := TIMssConnInfo(FHandle^).LoginRecPtr;
{$ENDIF}
end;

function TIMssDatabase.GetServerName: string;
begin
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIMssConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMssConnInfo) ) ).ServerNameStr;
{$ELSE}
    Result := TIMssConnInfo(FHandle^).ServerNameStr;
{$ENDIF}
end;

procedure TIMssDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF XSQL_CLR}
var
  r1, r2: TIMssConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;

{$IFDEF XSQL_CLR}
  r1 := TIMssConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMssConnInfo) ) );
  r2 := TIMssConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIMssConnInfo) ) );
  r1.DBProcPtr          := r2.DBProcPtr;
  r1.LoginRecPtr        := r2.LoginRecPtr;
  r1.ServerNameStr      := r2.ServerNameStr;
  Marshal.StructureToPtr(r1, FHandle, False);
{$ELSE}
  TIMssConnInfo(FHandle^).DBProcPtr	:= TIMssConnInfo(AHandle^).DBProcPtr;
  TIMssConnInfo(FHandle^).LoginRecPtr	:= TIMssConnInfo(AHandle^).LoginRecPtr;
  TIMssConnInfo(FHandle^).ServerNameStr := TIMssConnInfo(AHandle^).ServerNameStr;
{$ENDIF}
end;

procedure TIMssDatabase.AllocHandle;
var
  rec: TIMssConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TIMssDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem(FHandle, SizeOf(rec), 0);

  rec.ServerType:= Ord( istSQLServer );
  rec.DBProcPtr := nil;
  rec.LoginRecPtr:=nil;
  rec.ServerNameStr := '';

{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIMssConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TIMssDatabase.FreeHandle;
begin
  if Assigned(FHandle) then begin
{$IFNDEF XSQL_CLR}
    TIMssConnInfo(FHandle^).ServerNameStr := '';
{$ENDIF}
    FHandle := SafeReallocMem( FHandle, 0 );
  end;
end;

procedure TIMssDatabase.GetStmtResult(const Stmt: string; List: TStrings);
var
  cmd: TISqlCommand;
  sVal: string;
begin
  ReleaseDBHandle(nil, True, True);	// release an acquired handle
//  HandleReset( DBProcPtr );

  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect(Stmt);
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(1, sVal);
      if sVal <> '' then
        List.Add( sVal );
    end;
  finally
    cmd.Free;
  end;
end;

function TIMssDatabase.GetAutoIncSQL: string;
begin
  Result := SS_SelectAutoIncField; 
end;

function TIMssDatabase.GetClientVersion: LongInt;
begin
  Result := dwLoadedDBLIB;
end;

function TIMssDatabase.GetServerVersion: LongInt;
var
  procinfo: TDBPROCINFO;
begin
  procinfo.SizeOfStruct := SizeOf(procinfo);
  if dbprocinfo( DBProcPtr, procinfo) <> SUCCEED then
    Check( DBProcPtr );

  Result := MakeLong( procinfo.ServerMinor, procinfo.ServerMajor );
end;

function TIMssDatabase.GetVersionString: string;
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    GetStmtResult( 'select @@version', List );
    if List.Count > 0 then
      Result := List.Strings[0];
  finally
    List.Free;
  end;
end;

function TIMssDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
const
	// ------ in case of using system procedures, it's impossible to change values in the result set of procedures ----
  SQueryMssTableNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+
        ', CASE so.type WHEN ''U'' THEN 1 WHEN ''V'' THEN 2 WHEN ''S'' THEN 4 END as '+TBL_TYPE_FIELD+
        ' from sysobjects so, sysusers su '+
        'where so.uid = su.uid %s order by su.name, so.name';
  SQueryMss6TableFieldNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+', sc.name as '+COL_NAME_FIELD+
        ', sc.colid as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', st.name as '+COL_TYPENAME_FIELD+', sc.length as '+COL_LENGTH_FIELD+
        ', sc.prec as '+COL_PREC_FIELD+', sc.scale as '+COL_SCALE_FIELD+
        ', CASE sc.status & 8 WHEN 0 THEN 0 ELSE 1 END as '+COL_NULLABLE_FIELD+
        ', sc.cdefault as '+COL_DEFAULT_FIELD+
        ' from sysobjects so, sysusers su, syscolumns sc, systypes st '+
        'where so.uid = su.uid and so.id = sc.id and sc.usertype = st.usertype and'+
        '  su.name like ''%s'' and so.name like ''%s'' order by su.name, so.name, sc.colid';
  SQueryMssTableFieldNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+', sc.name as '+COL_NAME_FIELD+
        ', sc.colid as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', st.name as '+COL_TYPENAME_FIELD+', sc.length as '+COL_LENGTH_FIELD+
        ', sc.prec as '+COL_PREC_FIELD+', sc.scale as '+COL_SCALE_FIELD+
        ', sc.isnullable as '+COL_NULLABLE_FIELD+
        ', sc.cdefault as '+COL_DEFAULT_FIELD+
        ' from sysobjects so, sysusers su, syscolumns sc, systypes st '+
        'where so.uid = su.uid and so.id = sc.id and sc.xusertype = st.xusertype and'+
        '  su.name like ''%s'' and so.name like ''%s'' order by su.name, so.name, sc.colid';
        	// for MSSQL v.6,7 < 8, which don't have INDEX_PROPERTY function and ASC/DESC in CREATE INDEX command
  SQueryMssIndexNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+', si.name as '+IDX_NAME_FIELD+
        ', sc.name as '+IDX_COL_NAME_FIELD+', sk.keyno as '+IDX_COL_POS_FIELD+
        ', CASE si.status & 2 WHEN 0 THEN 1 ELSE 2 END + CASE si.status & 2048 WHEN 0 THEN 0 ELSE 4 END as '+IDX_TYPE_FIELD+
        ', ''A'' as '+IDX_SORT_FIELD+
	', '''' as '+IDX_FILTER_FIELD+
        ' from sysobjects so, sysusers su, sysindexes si, sysindexkeys sk, syscolumns sc '+
        'where so.uid = su.uid and so.id = si.id and (si.indid > 0) and (si.indid < 255) and'+
        '  so.id = sk.id and si.indid = sk.indid and so.id = sc.id and sk.colid = sc.colid and'+
        '  su.name like ''%s'' and so.name like ''%s'' '+
        'order by su.name, so.name, si.name, sk.keyno';
        // union select with sysobjects.xtype='PK' is used to get a primary key constraint
        // si.indid < 255 - exclude rows with table with text/image data
        // sysindexes includes rows for default constraints, which are returned by the first SELECT 
  SQueryMss8IndexNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+', si.name as '+IDX_NAME_FIELD+
        ', sc.name as '+IDX_COL_NAME_FIELD+', sk.keyno as '+IDX_COL_POS_FIELD+
        ', CASE INDEXPROPERTY ( so.id , si.name , ''IsUnique'' ) WHEN 1 THEN 2 ELSE 0 END as '+IDX_TYPE_FIELD+
        ', CASE INDEXKEY_PROPERTY ( so.id , si.indid, sk.keyno, ''IsDescending'' ) WHEN 0 THEN CAST(''A'' as varchar(2)) ELSE CAST(''D'' as varchar(2)) END as '+IDX_SORT_FIELD+
	', '''' as '+IDX_FILTER_FIELD+
        ' from sysobjects so, sysusers su, sysindexes si, sysindexkeys sk, syscolumns sc '+
        'where so.uid = su.uid and so.id = si.id and (si.indid > 0) and (si.indid < 255) and'+
        '  so.id = sk.id and si.indid = sk.indid and so.id = sc.id and sk.colid = sc.colid and'+
        '  su.name like ''%s'' and so.name like ''%s'' '+
        'union select DB_NAME(), su.name, so.name, si.name, '''', -1, 4, '''', '''' '+
        'from sysobjects so, sysusers su, sysobjects si '+
        'where so.uid = su.uid and so.id = si.parent_obj and si.xtype=''PK'' and '+
        '  su.name like ''%s'' and so.name like ''%s'' '+
        'order by 2, 3, 4, 6';
        // so.id *= sc.id is used to return procedures without parameters
  SQueryMss6StoredProcNamesFmt =
  	'select distinct DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name + '';'' + CONVERT(varchar, sp.number) as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', 0 as '+PROC_IN_PARAMS+', 0 as '+ PROC_OUT_PARAMS+
  	' from sysobjects so, sysusers su, sysprocedures sp ' +
	'where so.type in (''P'', ''X'') and so.uid = su.uid and so.id = sp.id '+
        '%s order by su.name, so.name';
  SQueryMss7StoredProcNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name + '';'' + CONVERT(varchar, sp.number) as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', COUNT(sc.isoutparam) as '+PROC_IN_PARAMS+
        ', SUM(sc.isoutparam) as '+ PROC_OUT_PARAMS+
  	' from sysobjects so, sysusers su, syscomments sp, syscolumns sc ' +
	'where so.type in (''P'', ''X'') and sp.colid = 1 and so.uid = su.uid and so.id = sp.id and so.id *= sc.id '+
        '%s group by su.name, so.name, sp.number order by su.name, so.name';
  	// for MSSQL7: it's used st.type, because st.usertype is equal 0 for nchar, ntext datatypes
  SQueryMss7ProcParamsFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name + '';'' + CONVERT(varchar, sp.number) as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', sc.name as '+PARAM_NAME_FIELD+', sc.colid as '+PARAM_POS_FIELD+
        ', CONVERT( smallint, CASE sc.status & 64 WHEN 0 THEN 1 ELSE 3 END) as '+PARAM_TYPE_FIELD+
        ', st.type as '+PARAM_DATATYPE_FIELD+', st.name as '+PARAM_TYPENAME_FIELD+
        ', sc.prec as '+PARAM_PREC_FIELD+', sc.scale as '+PARAM_SCALE_FIELD+', sc.length as '+PARAM_LENGTH_FIELD+
        ', CONVERT( smallint, CASE sc.status & 8 WHEN 0 THEN 0 ELSE 1 END) as '+PARAM_NULLABLE_FIELD+
  	' from sysobjects so, sysusers su, syscomments sp, syscolumns sc, systypes st ' +
	'where so.type in (''P'', ''X'') and sp.colid = 1 and so.uid = su.uid and so.id = sp.id and so.id = sc.id and'+
        ' sc.usertype = st.usertype and sc.number = 1 %s '+
        'order by su.name, so.name, sc.colid';

var
  sStmt, sOwner, sObj: string;
  cmd: TISqlCommand;
begin
  sStmt := '';
  case ASchemaType of
    stTables,
    stSysTables:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        if sObj = '*' then
          sObj := '';
        if sOwner = '*' then
          sOwner := '';
        if sObj <> '' then
          if ContainsLikeWildcards(sObj)
          then sStmt := sStmt + Format(' and so.name like ''%s''', [sObj])
          else sStmt := sStmt + Format(' and so.name = ''%s''', [sObj]);
        if sOwner <> '' then
          if ContainsLikeWildcards(sOwner)
          then sStmt := sStmt + Format(' and su.name like ''%s''', [sOwner])
          else sStmt := sStmt + Format(' and su.name = ''%s''', [sOwner]);
        if ASchemaType = stSysTables then
          sStmt := sStmt + ' and so.type in (''S'')'
        else
          sStmt := sStmt + ' and so.type in (''U'', ''V'')';
        sStmt := Format(SQueryMssTableNamesFmt, [sStmt]);
      end;
    stColumns:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        if GetMajorVer( GetServerVersion ) >= 7 then
          sStmt := Format(SQueryMssTableFieldNamesFmt, [sOwner, sObj] )
        else
          sStmt := Format(SQueryMss6TableFieldNamesFmt, [sOwner, sObj] );
      end;
    stIndexes:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        if GetMajorVer( GetServerVersion ) >= 8 then
          sStmt := Format(SQueryMss8IndexNamesFmt, [sOwner, sObj, sOwner, sObj])
        else
          sStmt := Format(SQueryMssIndexNamesFmt, [sOwner, sObj])
      end;
    stProcedures:
      begin
        if AObjectName <> '' then
          sStmt := Format(' and so.name like ''%s''', [AObjectName]);
        if GetMajorVer( GetServerVersion ) >= 7 then
          sStmt := Format(SQueryMss7StoredProcNamesFmt, [sStmt])
        else
          sStmt := Format(SQueryMss6StoredProcNamesFmt, [sStmt]);
      end;
    stProcedureParams:
      begin
        if AObjectName <> '' then
          sStmt := Format(' and so.name like ''%s''', [AObjectName]);
        sStmt := Format(SQueryMss7ProcParamsFmt, [sStmt])
      end;
  end;

  ReleaseDBHandle(nil, True, True);	// release an acquired handle
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( sStmt );
  except
    cmd.Free;
    raise;
  end;

  Result := cmd;
end;

procedure TIMssDatabase.HandleReset(AHandle: PDBPROCESS);
var
  rcd: RETCODE;
begin
  dbfreebuf( AHandle );

  repeat
    rcd := dbresults( AHandle );
    if rcd = FAIL then
      Check( AHandle );
  until (rcd = NO_MORE_RESULTS) or (rcd = FAIL);

  if (rcd <> NO_MORE_RESULTS) and (rcd <> SUCCEED) then
    Check( AHandle );
end;

procedure TIMssDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
  dbproc: PDBPROCESS;
  pLogin: PLOGINREC;
  sAppName, sHostName, sSrvName, sDbName: string;
  szUser, szPwd, szAppNam, szHostNam, szSrvNam: TSDCharPtr;
  IntValue: Integer;
{$IFDEF XSQL_CLR}
  rec: TIMssConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;

  pLogin := dblogin;

  sAppName := Params.Values[szAPPNAME];
  sHostName := Params.Values[szHOSTNAME];

  if Length(Trim( sAppName )) = 0 then
    sAppName := GetAppName;
  if Length(Trim( sHostName )) = 0 then
    sHostName := GetHostName;
  	// Sets the maximum number of simultaneously open DBPROCESS structures, which has to be more then current value
  IntValue := StrToIntDef( Params.Values[szMAXCURSORS], 0 );
  if IntValue > dbgetmaxprocs then
    dbsetmaxprocs( IntValue );
  	// set login timeout before connect
  if Trim( Params.Values[szLOGINTIMEOUT] ) <> '' then begin
    IntValue := StrToIntDef( Trim( Params.Values[szLOGINTIMEOUT] ), 0 );
    dbsetlogintime(IntValue);
  end;
  try
	// Trying to exclude an error <SQL Server message 18452: Logon failed for user '(null)'. Reason: Not associated with a trusted SQL Server connection>
    if Trim(sUserName) <> '' then begin
{$IFDEF XSQL_CLR}
      szUser := Marshal.StringToHGlobalAnsi( sUserName );
      szPwd := Marshal.StringToHGlobalAnsi( sPassword );
{$ELSE}
      szUser := PChar( sUserName );
      szPwd := PChar( sPassword );
{$ENDIF}
      dbsetlname(pLogin, szUser, DBSETUSER);
      dbsetlname(pLogin, szPwd, DBSETPWD);
    end;
{$IFDEF XSQL_CLR}
    szAppNam := Marshal.StringToHGlobalAnsi( sAppName );
    szHostNam:= Marshal.StringToHGlobalAnsi( sHostName );
{$ELSE}
    szAppNam := PChar( sAppName );
    szHostNam:= PChar( sHostName );
{$ENDIF}
    dbsetlname(pLogin, szAppNam, DBSETAPP);
    dbsetlname(pLogin, szHostNam, DBSETHOST);
    dbsetlname(pLogin, nil, DBVER60);
  	// it's required to use NT Athentication for MSSQL client, which is started via DCOM
    if Trim(sUserName) = '' then
      dbsetlname((pLogin), nil, DBSETSECURE);

    sSrvName := ExtractServerName(sRemoteDatabase);
{$IFDEF XSQL_CLR}
    szSrvNam := Marshal.StringToHGlobalAnsi( sSrvName );
{$ELSE}
    szSrvNam := PChar( sSrvName );
{$ENDIF}
    dbproc := dbopen( pLogin, szSrvNam );
    if dbproc = nil then begin
      Check( dbproc );
        // Sometimes, Check function does not always raise an exception, because DBErrorList is empty (causing a null process exception in the following functions)
      DatabaseError(SErrDBProcIsNull);
    end;
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal( szUser );
    Marshal.FreeHGlobal( szPwd );
    Marshal.FreeHGlobal( szAppNam );
    Marshal.FreeHGlobal( szHostNam );
    Marshal.FreeHGlobal( szSrvNam );
{$ENDIF}
  end;

  	// enable the use of quoted identifiers if it's possible, else
      // dbuse will fail with a quoted database name and DBQUOTEDIDENT is False
  if dbisopt( dbproc, DBQUOTEDIDENT, nil ) = DB_TRUE then
    dbclropt( dbproc, DBQUOTEDIDENT, nil );
  if UpperCase( Trim( Params.Values[szQUOTEDIDENT] ) ) <> SFalseString then begin
    if (dbsetopt( dbproc, DBQUOTEDIDENT, nil ) <> SUCCEED) or
       (dbsqlexec( dbproc ) <> SUCCEED)
    then
      Check( dbproc );
  end;
  HandleReset( dbproc );

  sDbName := ExtractDatabaseName(sRemoteDatabase);
  if Length(sDbName) > 0 then
    HandleExecCmd( dbproc, 'use ' + sDbName );
  HandleReset( dbproc );

  if Assigned(pLogin) and Assigned(dbproc) then begin
{$IFDEF XSQL_CLR}
    rec := TIMssConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIMssConnInfo) ) );
    rec.LoginRecPtr     := pLogin;
    rec.DBProcPtr       := dbproc;
    rec.ServerNameStr   := sSrvName;
    Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
    TIMssConnInfo(FHandle^).LoginRecPtr := pLogin;
    TIMssConnInfo(FHandle^).DBProcPtr   := dbproc;
    TIMssConnInfo(FHandle^).ServerNameStr:= sSrvName;
{$ENDIF}
  end;

  SetDefaultOptions;
end;

procedure TIMssDatabase.DoDisconnect(Force: Boolean);
begin
  if Assigned(FHandle) and Assigned(DBProcPtr) then begin
    if (dbclose( DBProcPtr ) <> SUCCEED) and not Force then
      Check( DBProcPtr );
    ClearErrors( DBProcPtr );
  end;
  FreeHandle;

  FreeSqlLib;
end;

procedure TIMssDatabase.HandleSetDefOptions(AHandle: PDBPROCESS);
var
  sValue: string;
  szOpt1, szOpt2: TSDCharPtr;
begin
	// HandleSetAutoCommit("SET IMPLICIT_TRANSACTIONS" command) resets DBTEXTLIMIT option to 4096 value (tested with MSSQL7, MSSQL2K)
  if not AutoCommitDef then
    HandleSetAutoCommit( AHandle );
{$IFDEF XSQL_CLR}
  szOpt1 := Marshal.StringToHGlobalAnsi( OPT_DBTEXTLIMIT );
  szOpt2 := Marshal.StringToHGlobalAnsi( OPT_DBTEXTSIZE );
{$ELSE}
  szOpt1 := OPT_DBTEXTLIMIT;
  szOpt2 := OPT_DBTEXTSIZE;
{$ENDIF}
  try
	// Blob limit for DB-Library
    if dbsetopt( AHandle, DBTEXTLIMIT, szOpt1 ) <> SUCCEED then
      Check( AHandle );
  	// Blob limit for SQLServer
    if dbsetopt( AHandle, DBTEXTSIZE, szOpt2 ) <> SUCCEED then
      Check( AHandle );

	// set command timeout value, if it's set
    sValue := Trim( Params.Values[szCMDTIMEOUT] );
    if sValue <> '' then begin
      if dbsettime( StrToIntDef( sValue, 0 ) ) <> SUCCEED then
        Check( AHandle );
    end;
	// enable or disable the use of quoted identifiers
    if UpperCase( Trim( Params.Values[szQUOTEDIDENT] ) ) <> SFalseString then begin
      if dbsetopt( AHandle, DBQUOTEDIDENT, nil ) <> SUCCEED then
        Check( AHandle );
    end else begin
      if dbclropt( AHandle, DBQUOTEDIDENT, nil) <> SUCCEED then
        Check( AHandle );
    end;

    if dbsqlexec( AHandle ) <> SUCCEED then
      Check( AHandle );
    HandleReset( AHandle );
    HandleSetTransIsolation( AHandle, TransIsolation );

	// set ANSI_NULLS setting, if it is necessary
    sValue := Trim( Params.Values[szANSINULLS] );
    if sValue <> '' then begin
      if sValue <> SFalseString
      then sValue := 'SET ANSI_NULLS ON'
      else sValue := 'SET ANSI_NULLS OFF';
      HandleExecCmd( AHandle, sValue );
    end;
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal( szOpt1 );
    Marshal.FreeHGlobal( szOpt2 );
{$ENDIF}
  end;
end;

procedure TIMssDatabase.SetDefaultOptions;
begin
  HandleSetDefOptions( DBProcPtr );
end;

procedure TIMssDatabase.HandleSetAutoCommit(AHandle: PDBPROCESS);
var
  sStmt: string;
begin
	// when this mode is set on: executing SELECT, INSERT and other statement will start a transaction
        // 'dbcc useroptions' return a status
  sStmt := 'SET IMPLICIT_TRANSACTIONS ';
  if AutoCommit then
    sStmt := sStmt + 'OFF'
  else
    sStmt := sStmt + 'ON';
  HandleExecCmd( AHandle, sStmt );
end;

procedure TIMssDatabase.HandleSetTransIsolation(AHandle: PDBPROCESS; Value: TISqlTransIsolation);
begin
  HandleExecCmd( AHandle, IsolLevelCmd[Value] );
end;

procedure TIMssDatabase.SetTransIsolation(Value: TISqlTransIsolation);
begin
  HandleSetTransIsolation( DBProcPtr, Value );
end;

function TIMssDatabase.TestConnected: Boolean;
begin
  HandleExecCmd( DBProcPtr, SDummySelect );
  Result := True;
end;


{ TIMssCommand }
constructor TIMssCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FBindStmt	:= '';
  FRowsAffected := -1;
  FConnected	:= False;
  FNextResults	:= False;

  FHandle := nil;

  FIsSingleConn := SqlDatabase.IsSingleConn;
end;

destructor TIMssCommand.Destroy;
begin
  inherited Destroy;
end;

procedure TIMssCommand.Check;
begin
  SqlDatabase.Check( Handle );
end;

{ It's required to call explicitly in case of an incomplete fetch of the result set }
procedure TIMssCommand.CloseResultSet;
begin
  if FNextResults then begin
    ClearFieldDescs;
    Exit;
  end;
  ResetExecuted;
	// to avoid dropping of the current active result set(of other query) on the shared DBHandle, when this query is closing
  if not DBHandleAcquired then
    Exit;
	// drop procedure's result sets
  if (CommandType = ctStoredProc) and (not FEndResults) then begin
    repeat
      HandleCurReset( Handle );
    until not HandleSpResults( Handle );
  end;
	// for example, in case of empty statement(raise an exception), Handle is not created at all
  if Assigned(Handle) then begin
        // it is necessary, for example, in case of Refresh call with szSINGLECONN=FALSE
    if CommandType = ctQuery then
      HandleCancel( Handle );   // releases pending results
    HandleReset( Handle );
  end;
  	// it's need in case of close a result set without full fetch
  ReleaseDBHandle;
end;

procedure TIMssCommand.Connect;

  function IsQuery(const AStmt: string): Boolean;
  var
    SelPos, i: Integer;
  begin
    Result := ctStoredProc = CommandType;
    if Result then
      Exit;
    SelPos := LocateText('select', AStmt);
    if SelPos = 0 then
      Exit;
    Result := SelPos = 1;
    if Result then
      Exit;
    for i:=1 to SelPos-1 do
      if not (AnsiChar( AStmt[i] ) in [#$0A, #$0D, #$20]) then
        Exit;

    Result := True;
  end;

begin
  // if it is not need to use a single process or statement can return rows,
  //else it's using Process of SqlDatabase (without connecting private process)
  if (CommandType = ctQuery) and not FConnected and not FIsSingleConn and IsQuery(CommandText) then
    FHandle := CreateDBProcess;

  FConnected	:= True;
  FEndResults	:= False;
end;

procedure TIMssCommand.Disconnect(Force: Boolean);
begin
  if not FConnected then
    Exit;

        // it is required to release connection, even if ExecSQL was used (CloseResultSet was not used)
  if not FIsSingleConn or DBHandleAcquired then begin
    HandleCancel( Handle );
    HandleReset( Handle );

    ReleaseDBHandle;
  end;

  ResetExecuted;
  FConnected	:= False;

  if FHandle = nil then Exit;
	// if single connection mode is off
  if (dbclose( FHandle ) <> SUCCEED) and not Force then
    Check;

  FHandle := nil;
end;

procedure TIMssCommand.DoPrepare(Value: string);
begin
  ResetExecuted;

  Connect;
  if CommandType = ctStoredProc then begin
    if Assigned(Params) and (Params.Count = 0) then
      InitParamList;
  end;
end;

procedure TIMssCommand.DoExecDirect(Value: string);
begin
  ResetExecuted;

  Connect;

  AllocParamsBuffer;
  BindParamsBuffer;

  InternalExecute;
  if FieldDescs.Count = 0 then
    InitFieldDescs;

  SetNativeCommand(FBindStmt);
end;

procedure TIMssCommand.DoExecute;
begin
	// to process a prepared statement(w/o result set: UPDATE, INSERT..) repeatedly - ExecSQL/ExecProc w/o Prepare call.
  if not Executed or (FieldDescs.Count = 0) then
    InternalExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if FieldDescs.Count = 0 then
    InitFieldDescs;

  SetNativeCommand(FBindStmt);
end;

{ Overided, because field descriptions are accessible after executing only }
procedure TIMssCommand.Execute;
begin
  AllocParamsBuffer;
  BindParamsBuffer;

  DoExecute;

  if FieldsBuffer = nil then
    AllocFieldsBuffer;
	// it's required to set select buffer after executing of the statement    
  SetFieldsBuffer;
end;

function TIMssCommand.FetchNextRow: Boolean;
var
  rcd: RETCODE;
begin
  rcd := FAIL;
  try
    rcd := dbnextrow( Handle );
    SqlDatabase.ResetIdleTimeOut;
  finally
	//  rcd = NO_MORE_ROWS or FAIL when EOF
    Result := not ((rcd = NO_MORE_ROWS) or (rcd = FAIL));
  end;
        // check fetch errors
  Check;
  
  if Result then begin
    FetchDataSize;
    if BlobFieldCount > 0 then
      FetchBlobFields;
  end else
    ReleaseDBHandleWOReset;
end;

{ BufSize is not used for all datatypes now }
function TIMssCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf, InData, OutData: TSDPtr;
  dtDateTime: TDateTimeRec;
  nSize: Integer;
  FieldInfo: TSDFieldInfo;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(InBuf, 0);
  nSize := FieldInfo.DataSize;
  Result := nSize > 0;

  if Result then begin
    InData	:= TSDPtr( Longint(InBuf) + SizeOf(TSDFieldInfo) );
    OutData	:= Buffer;

    if RequiredCnvtFieldType(AFieldDesc.FieldType) then begin
        // DateTime fields
      if IsDateTimeType(AFieldDesc.FieldType) then begin
        dtDateTime := CnvtDBDateTime2DateTimeRec(AFieldDesc.FieldType, InData, FieldInfo.DataSize);
        HelperMemWriteDateTimeRec(OutData, 0, dtDateTime);      // buffer size is SizeOf(TDateTimeRec)
      end else if AFieldDesc.FieldType = ftBoolean then begin

    	// for ftBoolean (bit datatype) allocates 2 byte(as for ftSmallint), but returns only 1 byte of data
        if nSize <> NativeDataSize(AFieldDesc.FieldType) then
          nSize := NativeDataSize(AFieldDesc.FieldType);
        SafeCopyMem( InData, OutData, nSize );
{$IFDEF XSQL_VCL5}
      end else if AFieldDesc.FieldType = ftGuid then begin
        // GUID in binary format requires 16 bytes, in string format - 38 bytes
      GuidToCharBuffer(InData, FieldInfo.DataSize, OutData, BufSize);
{$ENDIF}
      end else begin

      	// for DECIMAL and NUMERIC datatypes (returns as double(8 bytes),
        //but PSDFieldInfo(InBuf)^.DataSize = 19, it's wrong)
        // for SMALLMONEY returns DataSize = 4 (it's need set to 8 byte)
        if (AFieldDesc.FieldType in [ftFloat, ftCurrency]) and
           (nSize <> NativeDataSize(AFieldDesc.FieldType))
        then
          nSize := NativeDataSize(AFieldDesc.FieldType);
        SafeCopyMem( InData, OutData, nSize );
      end;

    end else begin
    	// for ftSmallint (tinyint datatype) allocates 2 byte(as for ftSmallint), but returns only 1 byte of data
      if AFieldDesc.FieldType = ftSmallint then
        nSize := NativeDataSize(AFieldDesc.FieldType);
      if nSize > BufSize then
        nSize := BufSize;
      SafeCopyMem( InData, OutData, nSize );
      if AFieldDesc.FieldType = ftString then begin
        if nSize = BufSize then
          Dec(nSize);
        HelperMemWriteByte( OutData, nSize, $0 );       // = PChar(OutData)[nSize] := #$0;
      end;
    end;
  end;
end;

function TIMssCommand.CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDValueBuffer; BufSize: Integer): TDateTimeRec;
var
  dateinfo: DBDATEREC;
  dtDate, dtTime: TDateTime;
begin
  if dbdatecrack( FHandle, dateinfo, Buffer ) <> SUCCEED then
    Check;

  dtDate := EncodeDate(dateinfo.Year, dateinfo.Month, dateinfo.Day);
  dtTime := EncodeTime(dateinfo.hour, dateinfo.minute, dateinfo.second, 0);

  case (ADataType) of
    ftTime:
      Result.Time := DateTimeToTimeStamp(dtTime).Time + dateinfo.millisecond;
    ftDate:
      Result.Date := DateTimeToTimeStamp(dtDate).Date;
    ftDateTime:
      Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) ) + dateinfo.millisecond;
  else
    Result.DateTime := 0.0;
  end;
end;

function TIMssCommand.ResultSetExists: Boolean;
begin
  Result := True;
end;

function TIMssCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
	// Data Type Tokens
    SQLIMAGE:	//$22
      Result := ftBlob;
    SQLTEXT:	//$23
      Result := ftMemo;
    SQLVARBINARY://$25
      Result := ftVarBytes;
    SQLBINARY:	//$2d
      Result := ftBytes;
    SQLVARCHAR,	//$27
    SQLCHAR:	//$2f
      Result := ftString;
    SQLBIT:	//$32
      Result := ftBoolean;
    SQLINT1,	//$30
    SQLINT2:	//$34
      Result := ftSmallInt;
    SQLINT4,	//$38
    SQLINTN:	//$26
      Result := ftInteger;
    SQLDATETIM4,//$3a
    SQLDATETIME,//$3d
    SQLDATETIMN://$6f
      Result := ftDateTime;

    SQLFLT4,	//$3b
    SQLFLT8,	//$3e
    SQLFLTN:	//$6d
      Result := ftFloat;
    SQLDECIMAL,	//$6a
    SQLNUMERIC:	//$6c
      Result := ftFloat;
    SQLMONEY4,	//$7a
    SQLMONEY,	//$3c
    SQLMONEYN:	//$6e
      Result := ftCurrency;
  else
    Result := ftUnknown;
  end;
end;

function TIMssCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  SizeOfDBDATETIME = {$IFDEF XSQL_CLR} SizeOf(DBINT)+SizeOf(ULONG) {$ELSE} SizeOf(DBDATETIME) {$ENDIF};
  { Converting from TFieldType â Program Data Type(MSSQL) }
  MSSQLSrvDataSizeMap: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	0,	SizeOf(USHORT),	SizeOf(INT), SizeOf(USHORT), SizeOf(USHORT),
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        SizeOf(Double), SizeOf(Double),	0, SizeOfDBDATETIME, SizeOfDBDATETIME,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SizeOfDBDATETIME, 	0, 	0, SizeOf(INT), 	0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	SizeOfGuidBinary
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
  Result := MSSQLSrvDataSizeMap[FieldType];
end;

function TIMssCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType â bind Data Type(SQLServer) }
  MSSQLSrvDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	NTBSTRINGBIND, SMALLBIND, INTBIND, INTBIND, SMALLBIND,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        FLT8BIND, FLT8BIND, 	0, DATETIMEBIND, DATETIMEBIND,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        DATETIMEBIND, BINARYBIND, BINARYBIND, INTBIND, VARYBINBIND,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        VARYBINBIND,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	BINARYBIND
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
  Result := MSSQLSrvDataTypeMap[FieldType];
end;

function TIMssCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result :=
  	FieldType in [ftBoolean,
	         ftDate, ftTime, ftDateTime,
        	 ftCurrency, ftFloat {$IFDEF XSQL_VCL5} , ftGuid {$ENDIF}];
end;

procedure TIMssCommand.GetFieldDescs(Descs: TSDFieldDescList);
  procedure InitDbColStruct(var Col: TDBCOL);
  begin
    with Col do begin
      SizeOfStruct := 0;
      dummy1    := 0;
      ColType   := 0;
      UserType  := 0;
      MaxLength := 0;
      Precision := 0;
      Scale     := 0;
      VarLength := 0;
      Null      := 0;
      CaseSensitive := 0;
      Updatable := 0;
      dummy2    := 0;
      Identity  := 0;
    end;
  end;
var
  ft: TFieldType;
  Col, NumCols: INT;
  dbcol: TDBCOL;
begin
	// it's required to execute a command before describe of a result set
  if not Executed then
    InternalExecute;
	// find a command which can return rows and omit other (for example: DECLARE, SET commands)
  if CommandType = ctQuery then
    CanReturnRows;

  NumCols := dbnumcols( Handle );

  for Col:=1 to NumCols do begin
    InitDbColStruct(dbcol);
    dbcol.SizeOfStruct := {$IFDEF XSQL_CLR}Marshal.{$ENDIF}SizeOf(dbcol);
    if dbcolinfo( PDBHANDLE(Handle), CI_REGULAR, Col, 0, dbcol ) = FAIL then
      Check;

    ft := FieldDataType(dbcol.ColType);
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [dbcol.Name] );
      	// check autoincrement property for a number column
    if IsNumericType(ft) and (dbcol.Identity = DB_TRUE) then
      ft := ftAutoInc;
{$IFDEF XSQL_VCL5}
    if (ft = ftBytes) and (dbcol.MaxLength = SizeOfGuidBinary) and SqlDatabase.ByteAsGuid then
      ft := ftGuid;
{$ENDIF}
    with Descs.AddFieldDesc do begin
      FieldName	:= dbcol.Name;
      FieldNo	:= Col;
      FieldType	:= ft;
      DataType	:= dbcol.ColType;
      if IsRequiredSizeTypes(ft) then begin
        DataSize := dbcol.MaxLength;
	// increase buffer for null-terminator (ftString binds as NTBSTRINGBIND)
        if ft = ftString then
          Inc(DataSize);
      end else
        DataSize := NativeDataSize(ft);
      Precision	:= dbcol.Precision;
  	// if dbcol.Null <> 1 then null values are not permitted for the column (Required = True)
      Required	:= not(dbcol.Null = 1);
    end;
    dbcol.MaxLength := 0;
  end;
end;

procedure TIMssCommand.ResetExecuted;
begin
  FBindStmt := '';
end;

function TIMssCommand.GetExecuted: Boolean;
begin
  Result := Length(FBindStmt) > 0;
end;

function TIMssCommand.GetHandle: PSDCursor;
begin
  if CommandType = ctStoredProc then begin
    Result := SqlDatabase.DBProcPtr;
    Exit;
  end;
  if FConnected then begin
  	// if FHandle = nil then the statement can't return rows
    if FIsSingleConn or (FHandle = nil)
    then Result := SqlDatabase.DBProcPtr
    else Result := FHandle;
  end else
    Result := nil;
end;

function TIMssCommand.GetSqlDatabase: TIMssDatabase;
begin
  Result := (inherited SqlDatabase) as TIMssDatabase;
end;

{ Returns True, when the current command uses(acquired) a shared DBHandle in single connection mode. }
function TIMssCommand.GetDBHandleAcquired: Boolean;
begin
  Result := FIsSingleConn and (SqlDatabase.CurSqlCmd = Self);
end;

{ Marks a database handle as used by the current dataset }
procedure TIMssCommand.AcquireDBHandle;
begin
  if FIsSingleConn then
    SqlDatabase.ReleaseDBHandle(Self, True, False);
end;

{ Releases a database handle, which was used by the current dataset }
procedure TIMssCommand.ReleaseDBHandle;
begin
  if SqlDatabase.CurSqlCmd = Self then
    SqlDatabase.ReleaseDBHandle(nil, False, True);
end;

procedure TIMssCommand.ReleaseDBHandleWOReset;
begin
  if SqlDatabase.CurSqlCmd = Self then
    SqlDatabase.ReleaseDBHandle(nil, False, False);
end;

{ Setting returned data size after field fetch }
procedure TIMssCommand.FetchDataSize;
var
  i: Integer;
  InfoPtr: TSDPtr;
  FieldInfo: TSDFieldInfo;
begin
  for i:=0 to FieldDescs.Count-1 do begin
    with FieldDescs[i] do begin
    	// skips calculated and lookup fields
      if not(FieldNo > 0) then Continue;
	// get PSDFieldInfo pointer
      InfoPtr := TSDPtr( Longint(FieldsBuffer) + FieldBufOffs[FieldNo-1] );
	// set a data length for returned columns (excepting text/image columns)
      if not IsBlobType(FieldType) then begin
        FieldInfo := GetFieldInfoStruct( InfoPtr, 0 );
        FieldInfo.DataSize := dbdatlen( Handle, FieldNo );
        SetFieldInfoStruct( InfoPtr, 0, FieldInfo );
      end;
    end;
  end;
end;

{ finds a command which can return rows and omit other (for example: DECLARE, SET commands) }
function TIMssCommand.CanReturnRows: Boolean;
var
  rcd: RETCODE;
begin
  Result := False;
  if ctQuery = CommandType then begin
    while dbcmdrow( Handle ) <> SUCCEED do begin
      rcd := dbresults( Handle );
      if rcd = FAIL then
        Check;
        // prevent infinite loop on error without message (if Check does not raise an exception)
      if rcd <> SUCCEED then
        Exit;
    end;
    Result := True;
  end;
end;

{ Binds result column from select list }
procedure TIMssCommand.SetFieldsBuffer;
var
  i, nOffset: Integer;
  BindDataSize: Word;
  BindDataType: Word;
  BindDataBuffer: TSDValueBuffer;
begin
  if not Executed then
    InternalExecute;

  CanReturnRows;
  nOffset := 0;		// pointer to the TSDFieldInfo

  for i:=0 to FieldDescs.Count-1 do begin
    BindDataType := NativeDataType(FieldDescs[i].FieldType);
    if BindDataType = 0 then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );

    BindDataSize := FieldDescs[i].DataSize;
    BindDataBuffer := TSDValueBuffer( Longint(FieldsBuffer) + nOffset + SizeOf(TSDFieldInfo) );

    if not IsBlobType(FieldDescs[i].FieldType) then begin
      if dbbind( Handle, FieldDescs[i].FieldNo, BindDataType, BindDataSize, LPBYTE(BindDataBuffer) ) = FAIL then
        Check;
{ This code set indicator variable to get NULL status. But that does not help to get NULL value for BIT column.
  NULL value for other columns are read through FetchDataSize successfully.
      if dbnullbind( Handle, FieldDescs[i].FieldNo, IncPtr(FieldsBuffer, nOffset+GetFieldInfoFetchStatusOff)) <> SUCCEED then
        Check;
}
    end;

    Inc(nOffset, SizeOf(TSDFieldInfo) + BindDataSize);
  end;
end;

function TIMssCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  DataPtr: LPCBYTE;
  BlobSize: DBINT;
begin
  DataPtr := nil;

  BlobSize := dbdatlen( Handle, AFieldDesc.FieldNo);
  if BlobSize > 0 then
    DataPtr := dbdata( Handle, AFieldDesc.FieldNo );	// dbdata can return up 2GB
  if (BlobSize > 0) and Assigned(DataPtr) then begin
    SetLength(BlobData, BlobSize);
{$IFDEF XSQL_CLR}
    Marshal.Copy( DataPtr, BlobData, 0, BlobSize );
{$ELSE}
    System.Move(DataPtr^, PChar(BlobData)^, BlobSize);
{$ENDIF}
  end;

  Result := BlobSize;
end;

	// Query methods
procedure TIMssCommand.BindParamsBuffer;
begin
end;

function TIMssCommand.GetRowsAffected: Integer;
begin
  Result := FRowsAffected;
end;

// byte array -> '0x.....'
// to '19980131 14:28:53:880' = 'yyyymmdd hh:mi:ss:nnn'
function TIMssCommand.CnvtDateTimeToSQLVarChar(ADataType: TFieldType; Value: TDateTime): string;
const
  sDateFormat = 'yyyymmdd';
  sTimeFormat = 'hh":"nn":"ss';
var
  Hour, Min, Sec, MSec: Word;
begin
  if ADataType in [ftDateTime, ftDate] then
    Result := FormatDateTime(sDateFormat, Value);
  if ADataType in [ftDateTime, ftTime] then begin
    DecodeTime(Value, Hour, Min, Sec, MSec);
    if (Hour > 0) or (Min > 0) or (Sec > 0) or (MSec > 0) then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + FormatDateTime(sTimeFormat, Value);
      if MSec > 0 then
        Result := Format('%s:%.3d', [Result, MSec]);
    end;
  end;
  Result := Format('''%s''', [Result]);
end;

function TIMssCommand.CnvtDateTimeToSQLDateTime(Value: TDateTime): DBDATETIME;
var
  tstamp: TTimeStamp;
begin
	// TDateTime(0,....) = 30.12.1899
  tstamp := DateTimeToTimeStamp(Value);
	// (Days since 12/30/1899) - 2 = Days since Jan 1, 1900
  Result.dtdays := Trunc(Value) - 2;
      	// (Number of milliseconds(100ths of second(1s=1000)) since midnight) *3/10 = 300ths of a second since midnight (1s=300)
  Result.dttime := (tstamp.Time * 3)div 10;
end;

function TIMssCommand.CnvtFloatToSQLVarChar(Value: Double): string;
var
  Len: Integer;
  szStr, p: TSDCharPtr;
begin
  Result := '';
  szStr := SafeReallocMem(nil, DBMAXCHAR);
  p := SafeReallocMem(nil, SizeOf(Value));
  try
    HelperMemWriteDouble( p, 0, Value );
    Len := dbconvert( SqlDatabase.DBProcPtr, SQLFLT8, p, SizeOf(Value),
  			SQLCHAR, LPBYTE(szStr), -1 );
    if Len > 0 then
      Result := HelperPtrToString( szStr );
  finally
    SafeReallocMem(szStr, 0);
    SafeReallocMem(p, 0);
  end;
end;

procedure TIMssCommand.InternalQBindParams;
const
  ParamPrefix	= ':';
  SqlNullValue	= 'NULL';
var
  i: Integer;
  sFullParamName, sValue: string;
begin
  FBindStmt := CommandText;	// w/o bind data

  if not Assigned(Params) then
    Exit;

  for i:=Params.Count-1 downto 0 do begin
    	// set parameter value
    if Params[i].IsNull then begin
      sValue := SqlNullValue
    end else begin
      case Params[i].DataType of
{$IFDEF XSQL_VCL4}
        ftLargeInt,
{$ENDIF}
        ftAutoInc,
        ftInteger,
        ftSmallint,
        ftWord:	sValue := Params[i].AsString;
        ftBoolean:
          if Params[i].AsBoolean
          then sValue := '1' else sValue := '0';
        ftBytes,
        ftVarBytes,
        ftBlob:
          sValue := CnvtVarBytesToHexString(Params[i].Value);
        ftDate,
        ftTime,
        ftDateTime:	sValue := CnvtDateTimeToSQLVarChar(Params[i].DataType, Params[i].AsDateTime);
        ftCurrency,
        ftFloat:	sValue := CnvtFloatToSQLVarChar(Params[i].AsFloat);
      else
        sValue := Params[i].AsString;
        	// exclude zero-terminator from string (and string length), what happens after richedit stores data
        while (Length(sValue) > 0) and (sValue[Length(sValue)] = #0) do
          SetLength(sValue, Length(sValue)-1);

        sValue := Format('''%s''', [RepeatChar('''', sValue)]);
      end;	// end of case
    end;	// end of for
  	// change a parameter's name on a value of the parameter
    sFullParamName := ParamPrefix + Params[i].Name;
    if not ReplaceString( False, sFullParamName, sValue, FBindStmt ) then begin
    	// if parameter's name is enclosed in double quotation marks
      sFullParamName := Format( '%s%s%s%s', [ParamPrefix, QuoteChar, Params[i].Name, QuoteChar] );
      ReplaceString( False, sFullParamName, sValue, FBindStmt );
    end;
  end;
end;

procedure TIMssCommand.InternalQExecute;
var
  szCmd: TSDCharPtr;
begin
  FRowsAffected := -1;

  Connect;

  InternalQBindParams;
{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( FBindStmt );
{$ELSE}
  szCmd := PChar( FBindStmt );
{$ENDIF}
  try
    dbcmd( Handle, szCmd );
    if dbsqlexec( Handle ) <> SUCCEED then
      Check;
    if dbresults( Handle ) <> SUCCEED then
      Check;
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal( szCmd );
{$ENDIF}
  end;

  FRowsAffected := dbcount( Handle );
end;

function TIMssCommand.CreateDBProcess: PDBPROCESS;
var
  szDBName: TSDCharPtr;
  sDbName: string;
begin
{$IFDEF XSQL_CLR}
  szDBName := Marshal.StringToHGlobalAnsi( SqlDatabase.ServerName );
{$ELSE}
  szDBName := PChar( SqlDatabase.ServerName );
{$ENDIF}
  try
    Result := dbopen( SqlDatabase.LoginRecPtr, szDBName );
    if Result = nil then begin
      Check;
      // Sometimes, Check function does not always raise an exception, because DBErrorList is empty (causing a null process exception in the following functions)
      DatabaseError(SErrDBProcIsNull);
    end;
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal( szDBName );
{$ENDIF}
  end;
        // szQUOTEDIDENT has to be set before dbuse call
  SqlDatabase.HandleSetDefOptions( Result );
        // dbname function returns the current database name (not quoted) for database component,
        // which could be changed after login using USE statement
  szDBName := XSMss.dbname( SqlDatabase.DBProcPtr );
  sDbName := HelperPtrToString( szDBName);
        // it is need when a database name has spaces or other signs inside
  if (UpperCase( Trim( SqlDatabase.Params.Values[szQUOTEDIDENT] ) ) <> SFalseString) and (sDbName <> '') then
    sDBName := '"' + sDBName + '"';

  if sDbName <> '' then begin
    SqlDatabase.HandleExecCmd( Result, 'use ' + sDbName );
    HandleReset( Result );
  end;
end;

procedure TIMssCommand.InternalExecute;
begin
  AcquireDBHandle;

  if CommandType = ctStoredProc then
    InternalSpExecute
  else
    InternalQExecute;
end;

{ BindBuffer is used really only for modify result set with Blob fields }
function TIMssCommand.GetParamsBufferSize: Integer;
var
  i, NumBytes, DataLen: Integer;
begin
  Result := 0;
  if not Assigned(Params) then
    Exit;
  NumBytes := 0;

  if CommandType = ctQuery then begin	// ? it is not necessary for query: parameters are inserted in a command text. Embedded procedure ?
    for i := 0 to Params.Count - 1 do
      with Params[I] do begin
        if DataType = ftUnknown then
          DatabaseErrorFmt(SNoParameterValue, [Name]);
        if ParamType = ptUnknown then
          DatabaseErrorFmt(SNoParameterType, [Name]);
        if RequiredCnvtFieldType(DataType) then begin
          case DataType of
            ftCurrency, ftFloat:
              DataLen := Length( CnvtFloatToSQLVarChar(AsFloat) );
            ftBoolean:
              DataLen := NativeParamSize(Params[I]);
          else
            DataLen := SizeOf( DBDATETIME );
          end;
  		// for zero-terminator
          Inc(DataLen);
        end else
          DataLen := NativeParamSize(Params[I]);
        Inc(NumBytes, SizeOf(TSDFieldInfo) + DataLen);
      end;
  end else if CommandType = ctStoredProc then begin
    for i := 0 to Params.Count - 1 do
      with Params[I] do begin
        if DataType = ftUnknown then
          DatabaseErrorFmt(SNoParameterValue, [Name]);
        if ParamType = ptUnknown then
          DatabaseErrorFmt(SNoParameterType, [Name]);
        if RequiredCnvtFieldType(DataType) then begin
          if IsDateTimeType( DataType ) then
            DataLen := SizeOf( DBDATETIME )
          else
            DataLen := NativeParamSize(Params[I])
        end else
          DataLen := NativeParamSize(Params[I]);

        Inc(NumBytes, SizeOf(TSDFieldInfo) + DataLen);
      end;
  end else
    DatabaseErrorFmt( SFatalError, ['TIMssCommand.GetParamsBufferSize'] );
  Result := NumBytes;
end;

procedure TIMssCommand.HandleSpInit(AHandle: PDBPROCESS; ARpcName: string);
var
  szName: TSDCharPtr;
begin
{$IFDEF XSQL_CLR}
  szName := Marshal.StringToHGlobalAnsi( ARpcName );
{$ELSE}
  szName := PChar(ARpcName);
{$ENDIF}
  if dbrpcinit( AHandle, szName, 0 ) <> SUCCEED then
    Check;
end;

procedure TIMssCommand.HandleSpExec(AHandle: PDBPROCESS);
begin
  if dbrpcexec( AHandle ) <> SUCCEED then
    Check;
end;

// returns True, if it's need to process regular row result (CS_ROW_RESULT)
function TIMssCommand.HandleSpResults(AHandle: PDBPROCESS): Boolean;
var
  rcd: RETCODE;
begin
  Result := False;
  repeat
    rcd := dbresults( AHandle );

    case rcd of
      FAIL:
        begin
          Check;
          Break;	// if fails without exception
        end;
      SUCCEED:
        begin
          Result := True;
          Break;
        end;
      NO_MORE_RESULTS: InternalSpGetParams;
    end;
  until rcd = NO_MORE_RESULTS;

  FEndResults := (rcd = NO_MORE_RESULTS) or (rcd = FAIL);
end;

{ Cancels the most recently executed query in the command batch }
procedure TIMssCommand.HandleCurReset(AHandle: PDBPROCESS);
begin
  if dbcanquery( AHandle ) = FAIL then
    Check;
end;

procedure TIMssCommand.HandleReset(AHandle: PDBPROCESS);
begin
  SqlDatabase.HandleReset( AHandle );
end;

{ Cancels the current command batch (all command) and releases pending results }
procedure TIMssCommand.HandleCancel(AHandle: PDBPROCESS);
begin
  if dbcancel( AHandle ) = FAIL then
    Check;
end;

	// Stored procedure methods
procedure TIMssCommand.InitParamList;
var
  sSpName, sInfoStmt, sName: string;
  DataTyp, ColType: Integer;
  ft: TFieldType;
  pt: TSDHelperParamType;
  cmd: TISqlCommand;
begin
  AddParam( SResultName, ftInteger, ptResult );

  sSpName := ExtractStoredProcName( CommandText );
  if GetMajorVer( SqlDatabase.GetServerVersion ) >= 7 then
  	// this statement is not tested with MSSQL6
    sInfoStmt := 'select sc.name, type, sc.length, CONVERT(smallint, ((sc.status/64)&1)) ' +
  	       'from syscolumns sc ' +
	Format('where sc.id = OBJECT_ID(''%s'') and sc.number = 1', [sSpName])
  else	// for MSSQL7 st.usertype is equal 0 for nchar, ntext datatypes
    sInfoStmt := 'select sc.name, st.type, sc.length, CONVERT(smallint, ((sc.status/64)&1)) ' +
  	       'from syscolumns sc, systypes st ' +
	Format('where sc.usertype = st.usertype and sc.id = OBJECT_ID(''%s'') and sc.number = 1', [sSpName]);

  cmd := SqlDatabase.CreateSqlCommand;
  try
    cmd.Prepare( sInfoStmt );
    cmd.Execute;
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(1, sName);
      cmd.GetFieldAsInt32(2, DataTyp);          // ftInteger, ftSmallInt, ftTinyint has same DataTyp, but with differen sc.length (4, 2, 1)
      cmd.GetFieldAsInt32(4, ColType);

      ft := FieldDataType(DataTyp);
      if ColType <> 0
      then pt := ptInputOutput
      else pt := ptInput;

      AddParam( sName, ft, pt );
    end;
  finally
    cmd.Free;
  end;
end;

procedure TIMssCommand.AllocParamsBuffer;
begin
  if CommandType = ctStoredProc then begin
    if ParamsBuffer = nil then
      inherited AllocParamsBuffer;
  end else
    inherited AllocParamsBuffer;
end;

procedure TIMssCommand.FreeParamsBuffer;
begin
  if Assigned(BufList) then
    BufList.Clear;

  inherited;
end;

procedure TIMssCommand.InternalSpBindParams;
  procedure CopySqlDataTime( Ptr: TSDValueBuffer; Value: DBDATETIME);
  begin
  {$IFDEF XSQL_CLR}
    HelperMemWriteInt32( Ptr, 0, Value.dtdays );
    HelperMemWriteInt32( Ptr, SizeOf(Value.dtdays), Value.dttime );
  {$ELSE}
    StrMove( Ptr, @Value, SizeOf(Value) );
  {$ENDIF}
  end;
var
  DataPtr: TSDValueBuffer;
  i, DataLen, nOffset, MaxLen: Integer;
  szParamName: TSDCharPtr;
  dt: TFieldType;
  status: Byte;
  rcd: RETCODE;
  dtval: DBDATETIME;
begin
  if not Assigned(Params) then
    Exit;

  if ParamsBuffer = nil then
    AllocParamsBuffer;

  nOffset := 0;

  for i:=0 to Params.Count-1 do begin
    DataPtr := TSDValueBuffer( Longint(ParamsBuffer) + nOffset );
    if Params[i].IsNull
    then DataLen := 0
    else DataLen := NativeParamSize( Params[i] );
    if Params[i].ParamType <> ptResult then begin
      if Params[i].ParamType in [ptInputOutput, ptOutput]
      then status := DBRPCRETURN
      else status := 0;
      dt := Params[i].DataType;
      case dt of
        ftString:
          if not Params[i].IsNull then begin
        	// DataLen is always equal 255(with '\0'), but string length may be less or more then 255
            HelperMemWriteString( DataPtr, 0, Params[i].AsString, MinIntValue(DataLen, Length(Params[i].AsString)+1) );
            HelperMemWriteByte( DataPtr, DataLen-1, 0 );	// DataLen is buffer size including zero-terminator
          end;
        ftAutoInc,
        ftInteger:
          if DataLen > 0 then HelperMemWriteInt32( DataPtr, 0, Params[i].AsInteger );
        ftSmallInt:
          if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, Params[i].AsSmallInt );
        ftBoolean:
          if DataLen > 0 then
            if Params[i].AsBoolean
            then HelperMemWriteInt16( DataPtr, 0, 1 )
            else HelperMemWriteInt16( DataPtr, 0, 0 );
        ftBytes,
        ftVarBytes:
          if DataLen > 0 then begin
            SafeInitMem( DataPtr, DataLen, 0 );
            Params[i].GetData( DataPtr );
          end;
        ftDate,
        ftTime,
        ftDateTime:
          if DataLen > 0 then begin
            DataLen := SizeOf(DBDATETIME);
            dtval := CnvtDateTimeToSQLDateTime( Params[i].AsDateTime );
            CopySqlDataTime( DataPtr, dtval );
          end;
        ftCurrency,
        ftFloat:
          if DataLen > 0 then HelperMemWriteDouble( DataPtr, 0, Params[i].AsFloat );
        else
          if not IsSupportedBlobTypes(dt) then
            raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
      end;
      MaxLen := -1;			// for fixed length parameters
      if not(Params[i].ParamType in [ptInputOutput, ptOutput]) and
         Params[i].IsNull and (dt in [ftString, ftBytes, ftVarBytes])
      then
        MaxLen := 0;
{$IFDEF XSQL_CLR}
      szParamName := BufList.StringToPtr( Params[i].Name );
{$ELSE}
      szParamName := PChar( Params[i].Name );
{$ENDIF}
      if IsBlobType(dt) then begin
        if VarType( Params[i].Value ) <> varString then
          VarAsType( Params[i].Value, varString );
  		// if parameter is NULL
        if Length( VarToStr(Params[i].Value) ) = 0 then MaxLen := 0;

        rcd := dbrpcparam( Handle, szParamName, 0, SrvNativeDataTypes[dt], MaxLen,
{$IFDEF XSQL_CLR}
                        Length(Params[i].AsString),
                        LPBYTE(BufList.StringToPtr(Params[i].AsString) )
{$ELSE}
                        Length(VarToStr(Params[i].Value)),
                        LPBYTE(PChar(TVarData(Params[i].Value).VString))
{$ENDIF}
        );
      end else begin
        if DataLen = 0 then
          rcd := dbrpcparam( Handle, szParamName, status, SrvNativeDataTypes[dt],
        		MaxLen, DataLen, LPBYTE(DataPtr) )
        else if dt in [ftString] then
          rcd := dbrpcparam( Handle, szParamName, status, SrvNativeDataTypes[dt],
        		MaxLen, MinIntValue(DataLen, Length(Params[i].AsString)){StrLen(DataPtr)}, LPBYTE(DataPtr) )
        else if dt in [ftBytes, ftVarBytes] then
          rcd := dbrpcparam( Handle, szParamName, status, SrvNativeDataTypes[dt],
      		MaxLen, DataLen, LPBYTE(DataPtr) )
        else
          rcd := dbrpcparam( Handle, szParamName, status, SrvNativeDataTypes[dt],
        		MaxLen, -1, LPBYTE(DataPtr) );
      end;
      if rcd <> SUCCEED then
        Check;
    end;
    Inc( nOffset, DataLen );
  end;
end;

procedure TIMssCommand.InternalSpExecute;
begin
  FBindStmt := ExtractStoredProcName( CommandText );

  HandleSpInit( Handle, FBindStmt );

  InternalSpBindParams;

  HandleSpExec( Handle );

  FEndResults	:= False;

  HandleSpResults( Handle );
	// show an exception, which is raised by RAISEERROR statement
  Check;
end;

procedure TIMssCommand.InternalSpGetParams;

  function CnvtBytesToStr( Buffer: TSDValueBuffer; Size: Integer ): string;
{$IFDEF XSQL_CLR}
  var
    i: Integer;
{$ENDIF}
  begin
    SetLength(Result, Size);
{$IFDEF XSQL_CLR}
    for i:=0 to Size-1 do
      Result[i+1] := Char( HelperMemReadByte( Buffer, i ) );
{$ELSE}
    Move(Buffer^, PChar(Result)^, Size);
{$ENDIF}
  end;

var
  i: Integer;
  RetNum, DataLen: INT;
  DataPtr: TSDCharPtr;
  szRetName: TSDCharPtr;
  dtDateTime: TDateTimeRec;
begin
  if not Assigned(Params) then
    Exit;

  RetNum := 1;	// the current index of the returned parameter

  for i:=0 to Params.Count-1 do begin
    if Params[i].ParamType = ptResult then begin	// i must be equal 0
     	// gets return status number of the stored procedure
      if dbhasretstat( Handle ) = DB_TRUE then
        Params[i].AsInteger := dbretstatus( Handle );
    end else if Params[i].ParamType in [ptInputOutput, ptOutput] then begin
      szRetName	:= dbretname( Handle, RetNum );
      ASSERT( Params[i].Name = HelperPtrToString(szRetName), 'TIMssCommand.InternalSpGetParams' );
      DataPtr		:= dbretdata( Handle, RetNum );
      if DataPtr <> nil
      then DataLen	:= dbretlen( Handle, RetNum )
      else DataLen 	:= 0;

      if DataLen > 0 then begin	// not null value
  		// for datetime and float fields
        if RequiredCnvtFieldType(Params[i].DataType) then begin
      	// DateTime fields
          if IsDateTimeType( Params[i].DataType ) then begin
            dtDateTime := CnvtDBDateTime2DateTimeRec( Params[i].DataType, DataPtr, DataLen );
            HelperAssignParamValue( Params[i], dtDateTime );
          end else if Params[i].DataType = ftBoolean then
            Params[i].AsBoolean := HelperMemReadInt16( DataPtr, 0 ) <> 0
          else begin
          	// Float types
            Params[i].SetData( DataPtr );
          end
        end else begin
             	// for string datatype set
            if IsRequiredSizeTypes(Params[i].DataType) then
              HelperMemWriteByte( DataPtr, DataLen, $0 );

            if Params[i].DataType in [ftBytes, ftVarBytes] then begin
              Params[i].Value := CnvtBytesToStr( TSDValueBuffer(DataPtr), DataLen )
            end else
              Params[i].SetData( DataPtr );
        end;
      end;

      Inc(RetNum);
    end;
  end;	{ end of for ... }
end;

procedure TIMssCommand.GetOutputParams;
begin
  if FEndResults then
    Exit;
	// fetch all rows for the current result set
  SaveResults;
	// reset(without fetching) the rest result sets
  repeat
    HandleCurReset( Handle )
  until not HandleSpResults( Handle );

  ReleaseDBHandle;
	// show an exception, which is raised, for example,
        //by RAISEERROR statement after processing of result set (SELECT statement) 
  Check;
end;

function TIMssCommand.NextResultSet: Boolean;
begin
  Result := False;
  if FEndResults then
    Exit;

  HandleCurReset( Handle );

  if HandleSpResults( Handle ) then begin
	// set a flag of processing the next result set
    FNextResults := True;
    Result := True;

    FreeFieldsBuffer;
  end;
end;

initialization
  hSqlLibModule := 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;

  DbErrorList	:= TMssErrorList.Create;
finalization
  // must be: DbErrorList.Count = 0, else some errors isn't processed
  DbErrorList.Free;

  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.
