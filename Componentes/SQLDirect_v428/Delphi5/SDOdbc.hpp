// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDOdbc.pas' rev: 5.00

#ifndef SDOdbcHPP
#define SDOdbcHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdodbc
{
//-- type declarations -------------------------------------------------------
typedef Byte UCHAR;

typedef unsigned ULONG;

typedef Word USHORT;

typedef char SCHAR;

typedef int SDWORD;

typedef short SWORD;

typedef unsigned UDWORD;

typedef Word UWORD;

typedef double SDOUBLE;

typedef float SFLOAT;

typedef int SLONG;

typedef short SSHORT;

typedef Extended LDOUBLE;

typedef void *PTR;

typedef Byte SQLCHAR;

typedef char SQLSCHAR;

typedef Byte SQLDATE;

typedef Byte SQLDECIMAL;

typedef double SQLDOUBLE;

typedef double SQLFLOAT;

typedef int SQLINTEGER;

typedef unsigned SQLUINTEGER;

typedef Byte SQLNUMERIC;

typedef void *SQLPOINTER;

typedef float SQLREAL;

typedef short SQLSMALLINT;

typedef Word SQLUSMALLINT;

typedef Byte SQLTIME;

typedef Byte SQLTIMESTAMP;

typedef Byte SQLVARCHAR;

typedef short SQLRETURN;

typedef void *SQLHANDLE;

typedef void *SQLHENV;

typedef void *SQLHDBC;

typedef void *SQLHSTMT;

typedef void *SQLHDESC;

typedef void * *PSQLHANDLE;

typedef void * *PSQLHENV;

typedef void * *PSQLHDBC;

typedef void * *PSQLHSTMT;

typedef short RETCODE;

typedef int *PSQLINTEGER;

typedef short *PSQLSMALLINT;

typedef Word *PSQLUSMALLINT;

typedef unsigned *PSQLUINTEGER;

typedef void * *PSQLPOINTER;

typedef HWND SQLHWND;

struct TSQL_DATE_STRUCT
{
	short year;
	Word month;
	Word day;
} ;

struct TSQL_TIME_STRUCT
{
	Word hour;
	Word minute;
	Word second;
} ;

struct TSQL_TIMESTAMP_STRUCT
{
	short year;
	Word month;
	Word day;
	Word hour;
	Word minute;
	Word second;
	unsigned fraction;
} ;

typedef Byte SQLINTERVAL;

struct TSQL_YEAR_MONTH_STRUCT
{
	unsigned year;
	unsigned month;
} ;

struct TSQL_DAY_SECOND_STRUCT
{
	unsigned day;
	unsigned hour;
	unsigned minute;
	unsigned second;
	unsigned fraction;
} ;

struct TSQL_INTERVAL_YM_STRUCT
{
	Byte interval_type;
	Byte dummy1;
	Byte dummy2;
	Byte dummy3;
	short interval_sign;
	Word dummy4;
	TSQL_YEAR_MONTH_STRUCT year_month;
} ;

struct TSQL_INTERVAL_DS_STRUCT
{
	Byte interval_type;
	Byte dummy1;
	Byte dummy2;
	Byte dummy3;
	short interval_sign;
	Word dummy4;
	TSQL_DAY_SECOND_STRUCT day_second;
} ;

typedef unsigned TSQL_BOOKMARK;

typedef short __stdcall (*TSQLAllocConnect)(void * henv, void * &hdbc);

typedef short __stdcall (*TSQLAllocEnv)(void * &henv);

typedef short __stdcall (*TSQLAllocHandle)(short fHandleType, void * hInput, void * &hOutput);

typedef short __stdcall (*TSQLAllocStmt)(void * hdbc, void * &hstmt);

typedef short __stdcall (*TSQLBindCol)(void * hstmt, Word icol, short fCType, void * rgbValue, int cbValueMax
	, void * pcbValue);

typedef short __stdcall (*TSQLCancel)(void * hstmt);

typedef short __stdcall (*TSQLCloseCursor)(void * hStmt);

typedef short __stdcall (*TSQLColAttribute)(void * hstmt, Word icol, Word fDescType, void * rgbDesc, 
	short cbDescMax, void * pcbDesc, void * pfDesc);

typedef short __stdcall (*TSQLColumns)(void * hStmt, char * szCatalogName, short cbCatalogName, char * 
	szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, char * szColumnName, short 
	cbColumnName);

typedef short __stdcall (*TSQLConnect)(void * hdbc, char * szDSN, short cbDSN, char * szUID, short cbUID
	, char * szAuthStr, short cbAuthStr);

typedef short __stdcall (*TSQLCopyDesc)(void * hDescSource, void * hDescTarget);

typedef short __stdcall (*TSQLDataSources)(void * hEnv, Word fDirection, char * szDSN, short cbDSNMax
	, short &cbDSN, char * szDescription, short cbDescriptionMax, short &cbDescription);

typedef short __stdcall (*TSQLDescribeCol)(void * hstmt, Word icol, char * szColName, short cbColNameMax
	, short &cbColName, short &fSqlType, unsigned &cbColDef, short &ibScale, short &fNullable);

typedef short __stdcall (*TSQLDisconnect)(void * hdbc);

typedef short __stdcall (*TSQLEndTran)(short fHandleType, void * hHandle, short fType);

typedef short __stdcall (*TSQLError)(void * henv, void * hdbc, void * hstmt, char * szSqlState, int 
	&fNativeError, char * szErrorMsg, short cbErrorMsgMax, short &cbErrorMsg);

typedef short __stdcall (*TSQLExecDirect)(void * hstmt, char * szSqlStr, int cbSqlStr);

typedef short __stdcall (*TSQLExecute)(void * hstmt);

typedef short __stdcall (*TSQLFetch)(void * hstmt);

typedef short __stdcall (*TSQLFetchScroll)(void * hStmt, short FetchOrientation, int FetchOffset);

typedef short __stdcall (*TSQLFreeConnect)(void * hdbc);

typedef short __stdcall (*TSQLFreeEnv)(void * henv);

typedef short __stdcall (*TSQLFreeHandle)(short fHandleType, void * hHandle);

typedef short __stdcall (*TSQLFreeStmt)(void * hstmt, Word fOption);

typedef short __stdcall (*TSQLGetConnectAttr)(void * hDbc, int Attribute, void * Value, int BufferLength
	, void * pStringLength);

typedef short __stdcall (*TSQLGetConnectOption)(void * hDbc, Word fOption, void * pvParam);

typedef short __stdcall (*TSQLGetCursorName)(void * hStmt, char * szCursor, short cbCursorMax, short 
	&cbCursor);

typedef short __stdcall (*TSQLGetData)(void * hStmt, Word icol, short fCType, void * rgbValue, int cbValueMax
	, int &cbValue);

typedef short __stdcall (*TSQLGetDescField)(void * DescriptorHandle, short RecNumber, short FieldIdentifier
	, void * Value, int BufferLength, int &StringLength);

typedef short __stdcall (*TSQLGetDescRec)(void * DescriptorHandle, short RecNumber, char * Name, short 
	BufferLength, short &StringLength, short &RecType, short &RecSubType, int &Length, short &Precision
	, short &Scale, short &Nullable);

typedef short __stdcall (*TSQLGetDiagField)(short fHandleType, void * hHandle, short iRecNumber, short 
	fDiagIdentifier, int &cbDiagInfo, short cbDiagInfoMax, void * pcbDiagInfo);

typedef short __stdcall (*TSQLGetDiagRec)(short fHandleType, void * hHandle, short iRecNumber, char * 
	szSqlState, int &fNativeError, char * szErrorMsg, short cbErrorMsgMax, short &cbErrorMsg);

typedef short __stdcall (*TSQLGetEnvAttr)(void * hEnv, int Attr, void * Value, int BufLen, int &StringLength
	);

typedef short __stdcall (*TSQLGetFunctions)(void * hDbc, Word fFunction, Word &fExists);

typedef short __stdcall (*TSQLGetInfo)(void * hDbc, Word fInfoType, void * rgbInfoValue, short cbInfoValueMax
	, short &cbInfoValue);

typedef short __stdcall (*TSQLGetStmtAttr)(void * hStmt, int Attribute, void * Value, int BufferLength
	, int &StringLength);

typedef short __stdcall (*TSQLGetStmtOption)(void * hStmt, Word fOption, void * pvParam);

typedef short __stdcall (*TSQLGetTypeInfo)(void * hStmt, short fSqlType);

typedef short __stdcall (*TSQLNumResultCols)(void * hStmt, short &ccol);

typedef short __stdcall (*TSQLParamData)(void * hStmt, void * &gbValue);

typedef short __stdcall (*TSQLPrepare)(void * hStmt, char * szSqlStr, int cbSqlStr);

typedef short __stdcall (*TSQLPutData)(void * hStmt, void * rgbValue, int cbValue);

typedef short __stdcall (*TSQLRowCount)(void * hStmt, int &crow);

typedef short __stdcall (*TSQLSetConnectAttr)(void * hDbc, int fOption, void * pvParam, int fStrLen)
	;

typedef short __stdcall (*TSQLSetConnectOption)(void * hDbc, Word fOption, unsigned vParam);

typedef short __stdcall (*TSQLSetCursorName)(void * hStmt, char * szCursor, short cbCursor);

typedef short __stdcall (*TSQLSetDescField)(void * DescriptorHandle, short RecNumber, short FieldIdentifier
	, void * Value, int BufferLength);

typedef short __stdcall (*TSQLSetDescRec)(void * DescriptorHandle, short RecNumber, short RecType, short 
	RecSubType, int Length, short Precision, short Scale, void * Data, int &StringLength, int &Indicator
	);

typedef short __stdcall (*TSQLSetEnvAttr)(void * hEnv, int Attr, void * Value, int StringLength);

typedef short __stdcall (*TSQLSetParam)(void * hStmt, Word ipar, short fCType, short fSqlType, unsigned 
	cbParamDef, short ibScale, void * rgbValue, int &cbValue);

typedef short __stdcall (*TSQLSetStmtAttr)(void * hStmt, int fOption, void * pvParam, int fStrLen);

typedef short __stdcall (*TSQLSetStmtOption)(void * hStmt, Word fOption, unsigned vParam);

typedef short __stdcall (*TSQLSpecialColumns)(void * hStmt, Word fColType, char * szCatalogName, short 
	cbCatalogName, char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, Word 
	fScope, Word fNullable);

typedef short __stdcall (*TSQLStatistics)(void * hStmt, char * szCatalogName, short cbCatalogName, char * 
	szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, Word fUnique, Word fAccuracy
	);

typedef short __stdcall (*TSQLTables)(void * hStmt, char * szCatalogName, short cbCatalogName, char * 
	szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, char * szTableType, short 
	cbTableType);

typedef short __stdcall (*TSQLTransact)(void * hEnv, void * hDbc, Word fType);

typedef short __stdcall (*TSQLBrowseConnect)(void * hDbc, char * szConnStrIn, short cbConnStrIn, char * 
	szConnStrOut, short cbConnStrOutMax, short &cbConnStrOut);

typedef short __stdcall (*TSQLBulkOperations)(void * hStmt, short Operation);

typedef short __stdcall (*TSQLColAttributes)(void * hStmt, Word icol, Word fDescType, void * rgbDesc
	, short cbDescMax, short &cbDesc, int &fDesc);

typedef short __stdcall (*TSQLColumnPrivileges)(void * hStmt, char * szCatalogName, short cbCatalogName
	, char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, char * szColumnName
	, short cbColumnName);

typedef short __stdcall (*TSQLDescribeParam)(void * hStmt, Word ipar, void * pfSqlType, unsigned &cbParamDef
	, void * pibScale, void * pfNullable);

typedef short __stdcall (*TSQLExtendedFetch)(void * hStmt, Word fFetchType, int irow, unsigned &crow
	, Word &gfRowStatus);

typedef short __stdcall (*TSQLForeignKeys)(void * hStmt, char * szPkCatalogName, short cbPkCatalogName
	, char * szPkSchemaName, short cbPkSchemaName, char * szPkTableName, short cbPkTableName, char * szFkCatalogName
	, short cbFkCatalogName, char * szFkSchemaName, short cbFkSchemaName, char * szFkTableName, short cbFkTableName
	);

typedef short __stdcall (*TSQLMoreResults)(void * hStmt);

typedef short __stdcall (*TSQLNativeSql)(void * hDbc, char * szSqlStrIn, int cbSqlStrIn, char * szSqlStr
	, int cbSqlStrMax, int &cbSqlStr);

typedef short __stdcall (*TSQLNumParams)(void * hStmt, short &cpar);

typedef short __stdcall (*TSQLParamOptions)(void * hStmt, unsigned crow, unsigned &irow);

typedef short __stdcall (*TSQLPrimaryKeys)(void * hStmt, char * szCatalogName, short cbCatalogName, 
	char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName);

typedef short __stdcall (*TSQLProcedureColumns)(void * hStmt, char * szCatalogName, short cbCatalogName
	, char * szSchemaName, short cbSchemaName, char * szProcName, short cbProcName, char * szColumnName
	, short cbColumnName);

typedef short __stdcall (*TSQLProcedures)(void * hStmt, char * szCatalogName, short cbCatalogName, char * 
	szSchemaName, short cbSchemaName, char * szProcName, short cbProcName);

typedef short __stdcall (*TSQLSetPos)(void * hStmt, Word irow, Word fOption, Word fLock);

typedef short __stdcall (*TSQLTablePrivileges)(void * hStmt, char * szCatalogName, short cbCatalogName
	, char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName);

typedef short __stdcall (*TSQLDrivers)(void * hEnv, Word fDirection, char * szDriverDesc, short cbDriverDescMax
	, short &cbDriverDesc, char * szDriverAttributes, short cbDrvrAttrMax, short &cbDrvrAttr);

typedef short __stdcall (*TSQLBindParameter)(void * hStmt, Word ipar, short fParamType, short fCType
	, short fSqlType, unsigned cbColDef, short ibScale, void * rgbValue, int cbValueMax, void * pcbValue
	);

typedef short __stdcall (*TSQLDriverConnect)(void * hDbc, HWND hWnd, char * szConnStrIn, short cbConnStrIn
	, char * szConnStrOut, short cbConnStrOutMax, short &cbConnStrOut, Word fDriverCompletion);

class DELPHICLASS TOdbcFunctions;
class PASCALIMPLEMENTATION TOdbcFunctions : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	unsigned FLibHandle;
	TSQLAllocConnect FSQLAllocConnect;
	TSQLAllocEnv FSQLAllocEnv;
	TSQLAllocHandle FSQLAllocHandle;
	TSQLAllocStmt FSQLAllocStmt;
	TSQLBindCol FSQLBindCol;
	TSQLCancel FSQLCancel;
	TSQLCloseCursor FSQLCloseCursor;
	TSQLColAttribute FSQLColAttribute;
	TSQLColumns FSQLColumns;
	TSQLConnect FSQLConnect;
	TSQLCopyDesc FSQLCopyDesc;
	TSQLDataSources FSQLDataSources;
	TSQLDescribeCol FSQLDescribeCol;
	TSQLDisconnect FSQLDisconnect;
	TSQLEndTran FSQLEndTran;
	TSQLError FSQLError;
	TSQLExecDirect FSQLExecDirect;
	TSQLExecute FSQLExecute;
	TSQLFetch FSQLFetch;
	TSQLFetchScroll FSQLFetchScroll;
	TSQLFreeConnect FSQLFreeConnect;
	TSQLFreeEnv FSQLFreeEnv;
	TSQLFreeHandle FSQLFreeHandle;
	TSQLFreeStmt FSQLFreeStmt;
	TSQLGetConnectAttr FSQLGetConnectAttr;
	TSQLGetConnectOption FSQLGetConnectOption;
	TSQLGetCursorName FSQLGetCursorName;
	TSQLGetData FSQLGetData;
	TSQLGetDescField FSQLGetDescField;
	TSQLGetDescRec FSQLGetDescRec;
	TSQLGetDiagField FSQLGetDiagField;
	TSQLGetDiagRec FSQLGetDiagRec;
	TSQLGetEnvAttr FSQLGetEnvAttr;
	TSQLGetFunctions FSQLGetFunctions;
	TSQLGetInfo FSQLGetInfo;
	TSQLGetStmtAttr FSQLGetStmtAttr;
	TSQLGetStmtOption FSQLGetStmtOption;
	TSQLGetTypeInfo FSQLGetTypeInfo;
	TSQLNumResultCols FSQLNumResultCols;
	TSQLParamData FSQLParamData;
	TSQLPrepare FSQLPrepare;
	TSQLPutData FSQLPutData;
	TSQLRowCount FSQLRowCount;
	TSQLSetConnectAttr FSQLSetConnectAttr;
	TSQLSetConnectOption FSQLSetConnectOption;
	TSQLSetCursorName FSQLSetCursorName;
	TSQLSetDescField FSQLSetDescField;
	TSQLSetDescRec FSQLSetDescRec;
	TSQLSetEnvAttr FSQLSetEnvAttr;
	TSQLSetParam FSQLSetParam;
	TSQLSetStmtAttr FSQLSetStmtAttr;
	TSQLSetStmtOption FSQLSetStmtOption;
	TSQLSpecialColumns FSQLSpecialColumns;
	TSQLStatistics FSQLStatistics;
	TSQLTables FSQLTables;
	TSQLTransact FSQLTransact;
	TSQLBrowseConnect FSQLBrowseConnect;
	TSQLBulkOperations FSQLBulkOperations;
	TSQLColAttributes FSQLColAttributes;
	TSQLColumnPrivileges FSQLColumnPrivileges;
	TSQLDescribeParam FSQLDescribeParam;
	TSQLExtendedFetch FSQLExtendedFetch;
	TSQLForeignKeys FSQLForeignKeys;
	TSQLMoreResults FSQLMoreResults;
	TSQLNativeSql FSQLNativeSql;
	TSQLNumParams FSQLNumParams;
	TSQLParamOptions FSQLParamOptions;
	TSQLPrimaryKeys FSQLPrimaryKeys;
	TSQLProcedureColumns FSQLProcedureColumns;
	TSQLProcedures FSQLProcedures;
	TSQLSetPos FSQLSetPos;
	TSQLTablePrivileges FSQLTablePrivileges;
	TSQLDrivers FSQLDrivers;
	TSQLBindParameter FSQLBindParameter;
	TSQLDriverConnect FSQLDriverConnect;
	
public:
	virtual void __fastcall SetApiCalls(unsigned ASqlLibModule);
	virtual void __fastcall ClearApiCalls(void);
	bool __fastcall IsAvailFunc(AnsiString AName);
	__property TSQLAllocConnect SQLAllocConnect = {read=FSQLAllocConnect};
	__property TSQLAllocEnv SQLAllocEnv = {read=FSQLAllocEnv};
	__property TSQLAllocHandle SQLAllocHandle = {read=FSQLAllocHandle};
	__property TSQLAllocStmt SQLAllocStmt = {read=FSQLAllocStmt};
	__property TSQLBindCol SQLBindCol = {read=FSQLBindCol};
	__property TSQLCancel SQLCancel = {read=FSQLCancel};
	__property TSQLCloseCursor SQLCloseCursor = {read=FSQLCloseCursor};
	__property TSQLColAttribute SQLColAttribute = {read=FSQLColAttribute};
	__property TSQLColumns SQLColumns = {read=FSQLColumns};
	__property TSQLConnect SQLConnect = {read=FSQLConnect};
	__property TSQLCopyDesc SQLCopyDesc = {read=FSQLCopyDesc};
	__property TSQLDataSources SQLDataSources = {read=FSQLDataSources};
	__property TSQLDescribeCol SQLDescribeCol = {read=FSQLDescribeCol};
	__property TSQLDisconnect SQLDisconnect = {read=FSQLDisconnect};
	__property TSQLEndTran SQLEndTran = {read=FSQLEndTran};
	__property TSQLError SQLError = {read=FSQLError};
	__property TSQLExecDirect SQLExecDirect = {read=FSQLExecDirect};
	__property TSQLExecute SQLExecute = {read=FSQLExecute};
	__property TSQLFetch SQLFetch = {read=FSQLFetch};
	__property TSQLFetchScroll SQLFetchScroll = {read=FSQLFetchScroll};
	__property TSQLFreeConnect SQLFreeConnect = {read=FSQLFreeConnect};
	__property TSQLFreeEnv SQLFreeEnv = {read=FSQLFreeEnv};
	__property TSQLFreeHandle SQLFreeHandle = {read=FSQLFreeHandle};
	__property TSQLFreeStmt SQLFreeStmt = {read=FSQLFreeStmt};
	__property TSQLGetConnectAttr SQLGetConnectAttr = {read=FSQLGetConnectAttr};
	__property TSQLGetConnectOption SQLGetConnectOption = {read=FSQLGetConnectOption};
	__property TSQLGetCursorName SQLGetCursorName = {read=FSQLGetCursorName};
	__property TSQLGetData SQLGetData = {read=FSQLGetData};
	__property TSQLGetDescField SQLGetDescField = {read=FSQLGetDescField};
	__property TSQLGetDescRec SQLGetDescRec = {read=FSQLGetDescRec};
	__property TSQLGetDiagField SQLGetDiagField = {read=FSQLGetDiagField};
	__property TSQLGetDiagRec SQLGetDiagRec = {read=FSQLGetDiagRec};
	__property TSQLGetEnvAttr SQLGetEnvAttr = {read=FSQLGetEnvAttr};
	__property TSQLGetFunctions SQLGetFunctions = {read=FSQLGetFunctions};
	__property TSQLGetInfo SQLGetInfo = {read=FSQLGetInfo};
	__property TSQLGetStmtAttr SQLGetStmtAttr = {read=FSQLGetStmtAttr};
	__property TSQLGetStmtOption SQLGetStmtOption = {read=FSQLGetStmtOption};
	__property TSQLGetTypeInfo SQLGetTypeInfo = {read=FSQLGetTypeInfo};
	__property TSQLNumResultCols SQLNumResultCols = {read=FSQLNumResultCols};
	__property TSQLParamData SQLParamData = {read=FSQLParamData};
	__property TSQLPrepare SQLPrepare = {read=FSQLPrepare};
	__property TSQLPutData SQLPutData = {read=FSQLPutData};
	__property TSQLRowCount SQLRowCount = {read=FSQLRowCount};
	__property TSQLSetConnectAttr SQLSetConnectAttr = {read=FSQLSetConnectAttr};
	__property TSQLSetConnectOption SQLSetConnectOption = {read=FSQLSetConnectOption};
	__property TSQLSetCursorName SQLSetCursorName = {read=FSQLSetCursorName};
	__property TSQLSetDescField SQLSetDescField = {read=FSQLSetDescField};
	__property TSQLSetDescRec SQLSetDescRec = {read=FSQLSetDescRec};
	__property TSQLSetEnvAttr SQLSetEnvAttr = {read=FSQLSetEnvAttr};
	__property TSQLSetParam SQLSetParam = {read=FSQLSetParam};
	__property TSQLSetStmtAttr SQLSetStmtAttr = {read=FSQLSetStmtAttr};
	__property TSQLSetStmtOption SQLSetStmtOption = {read=FSQLSetStmtOption};
	__property TSQLSpecialColumns SQLSpecialColumns = {read=FSQLSpecialColumns};
	__property TSQLStatistics SQLStatistics = {read=FSQLStatistics};
	__property TSQLTables SQLTables = {read=FSQLTables};
	__property TSQLTransact SQLTransact = {read=FSQLTransact};
	__property TSQLBrowseConnect SQLBrowseConnect = {read=FSQLBrowseConnect};
	__property TSQLBulkOperations SQLBulkOperations = {read=FSQLBulkOperations};
	__property TSQLColAttributes SQLColAttributes = {read=FSQLColAttributes};
	__property TSQLColumnPrivileges SQLColumnPrivileges = {read=FSQLColumnPrivileges};
	__property TSQLDescribeParam SQLDescribeParam = {read=FSQLDescribeParam};
	__property TSQLExtendedFetch SQLExtendedFetch = {read=FSQLExtendedFetch};
	__property TSQLForeignKeys SQLForeignKeys = {read=FSQLForeignKeys};
	__property TSQLMoreResults SQLMoreResults = {read=FSQLMoreResults};
	__property TSQLNativeSql SQLNativeSql = {read=FSQLNativeSql};
	__property TSQLNumParams SQLNumParams = {read=FSQLNumParams};
	__property TSQLParamOptions SQLParamOptions = {read=FSQLParamOptions};
	__property TSQLPrimaryKeys SQLPrimaryKeys = {read=FSQLPrimaryKeys};
	__property TSQLProcedureColumns SQLProcedureColumns = {read=FSQLProcedureColumns};
	__property TSQLProcedures SQLProcedures = {read=FSQLProcedures};
	__property TSQLSetPos SQLSetPos = {read=FSQLSetPos};
	__property TSQLTablePrivileges SQLTablePrivileges = {read=FSQLTablePrivileges};
	__property TSQLDrivers SQLDrivers = {read=FSQLDrivers};
	__property TSQLBindParameter SQLBindParameter = {read=FSQLBindParameter};
	__property TSQLDriverConnect SQLDriverConnect = {read=FSQLDriverConnect};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TOdbcFunctions(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TOdbcFunctions(void) { }
	#pragma option pop
	
};


class DELPHICLASS ESDOdbcError;
class PASCALIMPLEMENTATION ESDOdbcError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
private:
	AnsiString FSqlState;
	
public:
	__fastcall ESDOdbcError(short AErrorCode, short ANativeError, const AnsiString AMsg, const AnsiString 
		ASqlState);
	__property AnsiString SqlState = {read=FSqlState};
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDOdbcError(int AErrorCode, int ANativeError, const 
		AnsiString Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDOdbcError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDOdbcError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDOdbcError(int Ident)/* overload */ : Sdcommon::ESDEngineError(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDOdbcError(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDOdbcError(const AnsiString Msg, int AHelpContext) : 
		Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDOdbcError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDOdbcError(int Ident, int AHelpContext)/* overload */
		 : Sdcommon::ESDEngineError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDOdbcError(System::PResStringRec ResStringRec, 
		const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDOdbcError(void) { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TIOdbcConnInfo
{
	Byte ServerType;
	void *hEnv;
	void *hDbc;
} ;
#pragma pack(pop)

class DELPHICLASS TICustomOdbcDatabase;
class PASCALIMPLEMENTATION TICustomOdbcDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	int FDriverOdbcVer;
	bool FIsTransSupported;
	AnsiString FDBMSVer;
	bool FGetDataAnyColumn;
	Sdcommon::TISqlCommand* FCurSqlCmd;
	TOdbcFunctions* __fastcall GetCalls(void);
	int __fastcall GetDriverOdbcVersion(void);
	Word __fastcall GetDriverOdbcMajor(void);
	Word __fastcall GetDriverOdbcMinor(void);
	bool __fastcall GetIsNeedLongDataLen(void);
	void * __fastcall GetEnvHandle(void);
	void * __fastcall GetDbcHandle(void);
	bool __fastcall GetAutoCommitOption(void);
	
protected:
	TOdbcFunctions* FCalls;
	void __fastcall AllocHandle(void);
	void __fastcall AllocOdbcHandles(void);
	void __fastcall FreeHandle(void);
	void __fastcall FreeOdbcHandles(void);
	void __fastcall SetDefaultOptions(void);
	short __fastcall OdbcAllocHandle(short fHandleType, void * hInput, void * &hOutput);
	short __fastcall OdbcFreeHandle(short fHandleType, void * hHandle);
	unsigned __fastcall OdbcGetConnectAttrInt32(void * hDbc, int fOption);
	short __fastcall OdbcSetConnectAttr(void * hDbc, int fOption, void * pvParam, int fStrLen);
	short __fastcall OdbcSetStmtAttr(void * hStmt, int fOption, void * pvParam, int fStrLen);
	short __fastcall OdbcTransact(short fEndType);
	Word __fastcall OdbcGetInfoInt16(int InfoType);
	unsigned __fastcall OdbcGetInfoInt32(int InfoType);
	AnsiString __fastcall OdbcGetInfoString(int InfoType);
	Word __fastcall OdbcGetMaxCatalogNameLen(void);
	Word __fastcall OdbcGetMaxFieldNameLen(void);
	Word __fastcall OdbcGetMaxProcNameLen(void);
	Word __fastcall OdbcGetMaxSchemaNameLen(void);
	Word __fastcall OdbcGetMaxTableNameLen(void);
	void __fastcall CheckHandle(short AHandleType, void * AHandle, short AStatus);
	void __fastcall CheckHDBC(void * AHandle, short Status);
	void __fastcall CheckHSTMT(void * AHandle, short Status);
	void __fastcall Check(short Status);
	virtual void __fastcall FreeSqlLib(void) = 0 ;
	virtual void __fastcall LoadSqlLib(void) = 0 ;
	virtual void __fastcall RaiseSDEngineError(short AErrorCode, short ANativeError, const AnsiString AMsg
		, const AnsiString ASqlState) = 0 ;
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const 
		AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	
public:
	__fastcall virtual TICustomOdbcDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TICustomOdbcDatabase(void);
	virtual AnsiString __fastcall GetAutoIncSQL(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString(void);
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString 
		AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
	void __fastcall ReleaseDBHandle(Sdcommon::TISqlCommand* ASqlCmd, bool IsFetchAll);
	__property Sdcommon::TISqlCommand* CurSqlCmd = {read=FCurSqlCmd};
	__property TOdbcFunctions* Calls = {read=GetCalls};
	__property void * EnvHandle = {read=GetEnvHandle};
	__property void * DbcHandle = {read=GetDbcHandle};
	__property Word DriverOdbcMajor = {read=GetDriverOdbcMajor, nodefault};
	__property Word DriverOdbcMinor = {read=GetDriverOdbcMinor, nodefault};
	__property bool IsNeedLongDataLen = {read=GetIsNeedLongDataLen, nodefault};
};


class DELPHICLASS TICustomOdbcCommand;
class PASCALIMPLEMENTATION TICustomOdbcCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void *FHandle;
	bool FNextResults;
	bool FIsSingleConn;
	bool FInfoExecuted;
	bool FNoMoreResult;
	bool FIsSrvCursor;
	bool FExecDirect;
	bool FNoDataExecuted;
	int FFirstCalcFieldIdx;
	bool FPrefetchMode;
	int FPrefetchRows;
	void *FRowsFetchedPtr;
	void *FRowStatusValues;
	int FCurrRow;
	int FRowSize;
	int FBlobPieceSize;
	int FMaxBlobSize;
	TOdbcFunctions* __fastcall GetCalls(void);
	HIDESBASE TICustomOdbcDatabase* __fastcall GetSqlDatabase(void);
	bool __fastcall GetIsCallStmt(void);
	bool __fastcall GetIsExecDirect(void);
	short __fastcall GetNumResultCols(void);
	Db::TDateTimeRec __fastcall CnvtDBDateTime2DateTimeRec(Db::TFieldType ADataType, char * Buffer, int 
		BufSize);
	bool __fastcall CnvtDBData(int ExtDataType, Db::TFieldType ADataType, void * InBuf, void * Buffer, 
		int BufSize);
	AnsiString __fastcall CreateCommandText(AnsiString Value);
	void __fastcall InternalPrepare(AnsiString AStmt);
	void __fastcall InternalQExecute(bool InfoQuery);
	void __fastcall InternalSpExecute(bool InfoQuery);
	void __fastcall InternalSpGetParams(void);
	void __fastcall QBindParamsBuffer(void);
	void __fastcall SpBindParamsBuffer(void);
	void __fastcall SpExecute(void);
	bool __fastcall IsInterval(Sdcommon::TSDFieldDesc* FieldDesc);
	bool __fastcall IsIntervalType(int ExtDataType);
	bool __fastcall IsPseudoBlob(Sdcommon::TSDFieldDesc* FieldDesc);
	unsigned __fastcall OdbcGetColAttrInt32(void * hStmt, Word iCol, Word AttrType);
	
protected:
	void __fastcall AcquireDBHandle(void);
	void __fastcall ReleaseDBHandle(void);
	void __fastcall Check(short Status);
	void __fastcall CheckPrepared(void);
	virtual void __fastcall Connect(void);
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * 
		Buffer, int BufSize);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall AllocParamsBuffer(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void __fastcall InitParamList(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual int __fastcall SqlDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void * __fastcall GetHandle(void);
	virtual char * __fastcall GetFieldsBuffer(void);
	virtual int __fastcall GetFieldsBufferSize(void);
	virtual void __fastcall FreeFieldsBuffer(void);
	virtual void __fastcall SetFieldsBuffer(void);
	
public:
	__fastcall virtual TICustomOdbcCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TICustomOdbcCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall NextResultSet(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize
		);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	virtual int __fastcall WriteBlob(int FieldNo, const char * Buffer, int Count);
	__property TOdbcFunctions* Calls = {read=GetCalls};
	__property bool IsCallStmt = {read=GetIsCallStmt, nodefault};
	__property bool IsExecDirect = {read=GetIsExecDirect, nodefault};
	__property bool IsSrvCursor = {read=FIsSrvCursor, nodefault};
	__property TICustomOdbcDatabase* SqlDatabase = {read=GetSqlDatabase};
};


class DELPHICLASS TICustomOdbcCall;
class PASCALIMPLEMENTATION TICustomOdbcCall : public TICustomOdbcCommand 
{
	typedef TICustomOdbcCommand inherited;
	
protected:
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoPrepare(AnsiString Value);
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Create */ inline __fastcall virtual TICustomOdbcCall(Sdcommon::TISqlDatabase* 
		ASqlDatabase) : TICustomOdbcCommand(ASqlDatabase) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TICustomOdbcCall(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcCallProcs;
class PASCALIMPLEMENTATION TIOdbcCallProcs : public TICustomOdbcCall 
{
	typedef TICustomOdbcCall inherited;
	
private:
	AnsiString FProcNames;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOdbcCallProcs(Sdcommon::TISqlDatabase* ASqlDatabase);
	__property AnsiString ProcNames = {read=FProcNames, write=FProcNames};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIOdbcCallProcs(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcCallProcParams;
class PASCALIMPLEMENTATION TIOdbcCallProcParams : public TICustomOdbcCall 
{
	typedef TICustomOdbcCall inherited;
	
private:
	AnsiString FProcName;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOdbcCallProcParams(Sdcommon::TISqlDatabase* ASqlDatabase);
	__property AnsiString ProcName = {read=FProcName, write=FProcName};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIOdbcCallProcParams(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcCallTables;
class PASCALIMPLEMENTATION TIOdbcCallTables : public TICustomOdbcCall 
{
	typedef TICustomOdbcCall inherited;
	
private:
	AnsiString FTableNames;
	AnsiString FTableTypes;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOdbcCallTables(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property AnsiString TableNames = {read=FTableNames, write=FTableNames};
	__property AnsiString TableTypes = {read=FTableTypes, write=FTableTypes};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIOdbcCallTables(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcCallColumns;
class PASCALIMPLEMENTATION TIOdbcCallColumns : public TICustomOdbcCall 
{
	typedef TICustomOdbcCall inherited;
	
private:
	AnsiString FTableName;
	int FColTypeFieldIdx;
	int FColPrecFieldIdx;
	int FColPosV2FieldIdx;
	int FColDefV2FieldIdx;
	bool __fastcall GetIsODBC_3(void);
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOdbcCallColumns(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property bool IsODBC_3 = {read=GetIsODBC_3, nodefault};
	__property AnsiString TableName = {read=FTableName, write=FTableName};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIOdbcCallColumns(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcCallIndexes;
class PASCALIMPLEMENTATION TIOdbcCallIndexes : public TICustomOdbcCall 
{
	typedef TICustomOdbcCall inherited;
	
private:
	AnsiString FTableName;
	
protected:
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOdbcCallIndexes(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property AnsiString TableName = {read=FTableName, write=FTableName};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIOdbcCallIndexes(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcDatabase;
class PASCALIMPLEMENTATION TIOdbcDatabase : public TICustomOdbcDatabase 
{
	typedef TICustomOdbcDatabase inherited;
	
protected:
	virtual void __fastcall FreeSqlLib(void);
	virtual void __fastcall LoadSqlLib(void);
	virtual void __fastcall RaiseSDEngineError(short AErrorCode, short ANativeError, const AnsiString AMsg
		, const AnsiString ASqlState);
	
public:
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
public:
	#pragma option push -w-inl
	/* TICustomOdbcDatabase.Create */ inline __fastcall virtual TIOdbcDatabase(Classes::TStrings* ADbParams
		) : TICustomOdbcDatabase(ADbParams) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcDatabase.Destroy */ inline __fastcall virtual ~TIOdbcDatabase(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOdbcCommand;
class PASCALIMPLEMENTATION TIOdbcCommand : public TICustomOdbcCommand 
{
	typedef TICustomOdbcCommand inherited;
	
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Create */ inline __fastcall virtual TIOdbcCommand(Sdcommon::TISqlDatabase* ASqlDatabase
		) : TICustomOdbcCommand(ASqlDatabase) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIOdbcCommand(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#define ODBC_TBL_SCH_NAME_FIELD "TABLE_SCHEM"
#define ODBC_TBL_NAME_FIELD "TABLE_NAME"
#define ODBC_TBL_TYPE_NAME_FIELD "TABLE_TYPE"
#define ODBC_COL_NAME_FIELD "COLUMN_NAME"
#define ODBC_PROC_NAME_FIELD "PROCEDURE_NAME"
#define ODBC_PROC_SCH_NAME_FIELD "PROCEDURE_SCHEM"
static const Shortint SQL_VALUE_DATA = 0x0;
static const Shortint SQL_NULL_DATA = 0xffffffff;
static const Shortint SQL_DATA_AT_EXEC = 0xfffffffe;
static const Shortint SQL_SUCCESS = 0x0;
static const Shortint SQL_SUCCESS_WITH_INFO = 0x1;
static const Shortint SQL_STILL_EXECUTING = 0x2;
static const Shortint SQL_NEED_DATA = 0x63;
static const Shortint SQL_NO_DATA = 0x64;
static const Shortint SQL_NO_DATA_FOUND = 0x64;
static const Shortint SQL_ERROR = 0xffffffff;
static const Shortint SQL_INVALID_HANDLE = 0xfffffffe;
static const Shortint SQL_NTS = 0xfffffffd;
static const int SQL_NTSL = 0xfffffffd;
static const Word SQL_MAX_MESSAGE_LENGTH = 0x200;
static const Shortint SQL_DATE_LEN = 0xa;
static const Shortint SQL_TIME_LEN = 0x8;
static const Shortint SQL_TIMESTAMP_LEN = 0x13;
static const Shortint SQL_HANDLE_ENV = 0x1;
static const Shortint SQL_HANDLE_DBC = 0x2;
static const Shortint SQL_HANDLE_STMT = 0x3;
static const Shortint SQL_HANDLE_DESC = 0x4;
static const Word SQL_ATTR_OUTPUT_NTS = 0x2711;
static const Word SQL_ATTR_AUTO_IPD = 0x2711;
static const Word SQL_ATTR_METADATA_ID = 0x271e;
static const Word SQL_ATTR_APP_ROW_DESC = 0x271a;
static const Word SQL_ATTR_APP_PARAM_DESC = 0x271b;
static const Word SQL_ATTR_IMP_ROW_DESC = 0x271c;
static const Word SQL_ATTR_IMP_PARAM_DESC = 0x271d;
static const Shortint SQL_ATTR_CURSOR_SCROLLABLE = 0xffffffff;
static const Shortint SQL_ATTR_CURSOR_SENSITIVITY = 0xfffffffe;
static const Shortint SQL_NONSCROLLABLE = 0x0;
static const Shortint SQL_SCROLLABLE = 0x1;
static const Word SQL_DESC_COUNT = 0x3e9;
static const Word SQL_DESC_TYPE = 0x3ea;
static const Word SQL_DESC_LENGTH = 0x3eb;
static const Word SQL_DESC_OCTET_LENGTH_PTR = 0x3ec;
static const Word SQL_DESC_PRECISION = 0x3ed;
static const Word SQL_DESC_SCALE = 0x3ee;
static const Word SQL_DESC_DATETIME_INTERVAL_CODE = 0x3ef;
static const Word SQL_DESC_NULLABLE = 0x3f0;
static const Word SQL_DESC_INDICATOR_PTR = 0x3f1;
static const Word SQL_DESC_DATA_PTR = 0x3f2;
static const Word SQL_DESC_NAME = 0x3f3;
static const Word SQL_DESC_UNNAMED = 0x3f4;
static const Word SQL_DESC_OCTET_LENGTH = 0x3f5;
static const Word SQL_DESC_ALLOC_TYPE = 0x44b;
static const Shortint SQL_DIAG_RETURNCODE = 0x1;
static const Shortint SQL_DIAG_NUMBER = 0x2;
static const Shortint SQL_DIAG_ROW_COUNT = 0x3;
static const Shortint SQL_DIAG_SQLSTATE = 0x4;
static const Shortint SQL_DIAG_NATIVE = 0x5;
static const Shortint SQL_DIAG_MESSAGE_TEXT = 0x6;
static const Shortint SQL_DIAG_DYNAMIC_FUNCTION = 0x7;
static const Shortint SQL_DIAG_CLASS_ORIGIN = 0x8;
static const Shortint SQL_DIAG_SUBCLASS_ORIGIN = 0x9;
static const Shortint SQL_DIAG_CONNECTION_NAME = 0xa;
static const Shortint SQL_DIAG_SERVER_NAME = 0xb;
static const Shortint SQL_DIAG_DYNAMIC_FUNCTION_CODE = 0xc;
static const Shortint SQL_DIAG_ALTER_DOMAIN = 0x3;
static const Shortint SQL_DIAG_ALTER_TABLE = 0x4;
static const Shortint SQL_DIAG_CALL = 0x7;
static const Shortint SQL_DIAG_CREATE_ASSERTION = 0x6;
static const Shortint SQL_DIAG_CREATE_CHARACTER_SET = 0x8;
static const Shortint SQL_DIAG_CREATE_COLLATION = 0xa;
static const Shortint SQL_DIAG_CREATE_DOMAIN = 0x17;
static const Shortint SQL_DIAG_CREATE_SCHEMA = 0x40;
static const Shortint SQL_DIAG_CREATE_INDEX = 0xffffffff;
static const Shortint SQL_DIAG_CREATE_TABLE = 0x4d;
static const Shortint SQL_DIAG_CREATE_TRANSLATION = 0x4f;
static const Shortint SQL_DIAG_CREATE_VIEW = 0x54;
static const Shortint SQL_DIAG_DELETE_WHERE = 0x13;
static const Shortint SQL_DIAG_DROP_ASSERTION = 0x18;
static const Shortint SQL_DIAG_DROP_CHARACTER_SET = 0x19;
static const Shortint SQL_DIAG_DROP_COLLATION = 0x1a;
static const Shortint SQL_DIAG_DROP_DOMAIN = 0x1b;
static const Shortint SQL_DIAG_DROP_INDEX = 0xfffffffe;
static const Shortint SQL_DIAG_DROP_SCHEMA = 0x1f;
static const Shortint SQL_DIAG_DROP_TABLE = 0x20;
static const Shortint SQL_DIAG_DROP_TRANSLATION = 0x21;
static const Shortint SQL_DIAG_DROP_VIEW = 0x24;
static const Shortint SQL_DIAG_DYNAMIC_DELETE_CURSOR = 0x26;
static const Shortint SQL_DIAG_DYNAMIC_UPDATE_CURSOR = 0x51;
static const Shortint SQL_DIAG_GRANT = 0x30;
static const Shortint SQL_DIAG_INSERT = 0x32;
static const Shortint SQL_DIAG_REVOKE = 0x3b;
static const Shortint SQL_DIAG_SELECT_CURSOR = 0x55;
static const Shortint SQL_DIAG_UNKNOWN_STATEMENT = 0x0;
static const Shortint SQL_DIAG_UPDATE_WHERE = 0x52;
static const Shortint SQL_UNKNOWN_TYPE = 0x0;
static const Shortint SQL_CHAR = 0x1;
static const Shortint SQL_NUMERIC = 0x2;
static const Shortint SQL_DECIMAL = 0x3;
static const Shortint SQL_INTEGER = 0x4;
static const Shortint SQL_SMALLINT = 0x5;
static const Shortint SQL_FLOAT = 0x6;
static const Shortint SQL_REAL = 0x7;
static const Shortint SQL_DOUBLE = 0x8;
static const Shortint SQL_DATETIME = 0x9;
static const Shortint SQL_VARCHAR = 0xc;
static const Shortint SQL_TYPE_DATE = 0x5b;
static const Shortint SQL_TYPE_TIME = 0x5c;
static const Shortint SQL_TYPE_TIMESTAMP = 0x5d;
static const Shortint SQL_UNSPECIFIED = 0x0;
static const Shortint SQL_INSENSITIVE = 0x1;
static const Shortint SQL_SENSITIVE = 0x2;
static const Shortint SQL_ALL_TYPES = 0x0;
static const Shortint SQL_DEFAULT = 0x63;
static const Shortint SQL_ARD_TYPE = 0xffffff9d;
static const Shortint SQL_CODE_DATE = 0x1;
static const Shortint SQL_CODE_TIME = 0x2;
static const Shortint SQL_CODE_TIMESTAMP = 0x3;
static const Shortint SQL_FALSE = 0x0;
static const Shortint SQL_TRUE = 0x1;
static const Shortint SQL_NO_NULLS = 0x0;
static const Shortint SQL_NULLABLE = 0x1;
static const Shortint SQL_NULLABLE_UNKNOWN = 0x2;
static const Shortint SQL_PRED_NONE = 0x0;
static const Shortint SQL_PRED_CHAR = 0x1;
static const Shortint SQL_PRED_BASIC = 0x2;
static const Shortint SQL_NAMED = 0x0;
static const Shortint SQL_UNNAMED = 0x1;
static const Shortint SQL_DESC_ALLOC_AUTO = 0x1;
static const Shortint SQL_DESC_ALLOC_USER = 0x2;
static const Shortint SQL_CLOSE = 0x0;
static const Shortint SQL_DROP = 0x1;
static const Shortint SQL_UNBIND = 0x2;
static const Shortint SQL_RESET_PARAMS = 0x3;
static const Shortint SQL_FETCH_NEXT = 0x1;
static const Shortint SQL_FETCH_FIRST = 0x2;
static const Shortint SQL_FETCH_LAST = 0x3;
static const Shortint SQL_FETCH_PRIOR = 0x4;
static const Shortint SQL_FETCH_ABSOLUTE = 0x5;
static const Shortint SQL_FETCH_RELATIVE = 0x6;
static const Shortint SQL_COMMIT = 0x0;
static const Shortint SQL_ROLLBACK = 0x1;
static const Shortint SQL_NULL_HENV = 0x0;
static const Shortint SQL_NULL_HDBC = 0x0;
static const Shortint SQL_NULL_HSTMT = 0x0;
static const Shortint SQL_NULL_HDESC = 0x0;
static const Shortint SQL_NULL_HANDLE = 0x0;
static const Shortint SQL_SCOPE_CURROW = 0x0;
static const Shortint SQL_SCOPE_TRANSACTION = 0x1;
static const Shortint SQL_SCOPE_SESSION = 0x2;
static const Shortint SQL_PC_UNKNOWN = 0x0;
static const Shortint SQL_PC_NON_PSEUDO = 0x1;
static const Shortint SQL_PC_PSEUDO = 0x2;
static const Shortint SQL_ROW_IDENTIFIER = 0x1;
static const Shortint SQL_INDEX_UNIQUE = 0x0;
static const Shortint SQL_INDEX_ALL = 0x1;
static const Shortint SQL_INDEX_CLUSTERED = 0x1;
static const Shortint SQL_INDEX_HASHED = 0x2;
static const Shortint SQL_INDEX_OTHER = 0x3;
static const Shortint SQL_API_SQLALLOCCONNECT = 0x1;
static const Shortint SQL_API_SQLALLOCENV = 0x2;
static const Word SQL_API_SQLALLOCHANDLE = 0x3e9;
static const Shortint SQL_API_SQLALLOCSTMT = 0x3;
static const Shortint SQL_API_SQLBINDCOL = 0x4;
static const Word SQL_API_SQLBINDPARAM = 0x3ea;
static const Shortint SQL_API_SQLCANCEL = 0x5;
static const Word SQL_API_SQLCLOSECURSOR = 0x3eb;
static const Shortint SQL_API_SQLCOLATTRIBUTE = 0x6;
static const Shortint SQL_API_SQLCOLUMNS = 0x28;
static const Shortint SQL_API_SQLCONNECT = 0x7;
static const Word SQL_API_SQLCOPYDESC = 0x3ec;
static const Shortint SQL_API_SQLDATASOURCES = 0x39;
static const Shortint SQL_API_SQLDESCRIBECOL = 0x8;
static const Shortint SQL_API_SQLDISCONNECT = 0x9;
static const Word SQL_API_SQLENDTRAN = 0x3ed;
static const Shortint SQL_API_SQLERROR = 0xa;
static const Shortint SQL_API_SQLEXECDIRECT = 0xb;
static const Shortint SQL_API_SQLEXECUTE = 0xc;
static const Shortint SQL_API_SQLFETCH = 0xd;
static const Word SQL_API_SQLFETCHSCROLL = 0x3fd;
static const Shortint SQL_API_SQLFREECONNECT = 0xe;
static const Shortint SQL_API_SQLFREEENV = 0xf;
static const Word SQL_API_SQLFREEHANDLE = 0x3ee;
static const Shortint SQL_API_SQLFREESTMT = 0x10;
static const Word SQL_API_SQLGETCONNECTATTR = 0x3ef;
static const Shortint SQL_API_SQLGETCONNECTOPTION = 0x2a;
static const Shortint SQL_API_SQLGETCURSORNAME = 0x11;
static const Shortint SQL_API_SQLGETDATA = 0x2b;
static const Word SQL_API_SQLGETDESCFIELD = 0x3f0;
static const Word SQL_API_SQLGETDESCREC = 0x3f1;
static const Word SQL_API_SQLGETDIAGFIELD = 0x3f2;
static const Word SQL_API_SQLGETDIAGREC = 0x3f3;
static const Word SQL_API_SQLGETENVATTR = 0x3f4;
static const Shortint SQL_API_SQLGETFUNCTIONS = 0x2c;
static const Shortint SQL_API_SQLGETINFO = 0x2d;
static const Word SQL_API_SQLGETSTMTATTR = 0x3f6;
static const Shortint SQL_API_SQLGETSTMTOPTION = 0x2e;
static const Shortint SQL_API_SQLGETTYPEINFO = 0x2f;
static const Shortint SQL_API_SQLNUMRESULTCOLS = 0x12;
static const Shortint SQL_API_SQLPARAMDATA = 0x30;
static const Shortint SQL_API_SQLPREPARE = 0x13;
static const Shortint SQL_API_SQLPUTDATA = 0x31;
static const Shortint SQL_API_SQLROWCOUNT = 0x14;
static const Word SQL_API_SQLSETCONNECTATTR = 0x3f8;
static const Shortint SQL_API_SQLSETCONNECTOPTION = 0x32;
static const Shortint SQL_API_SQLSETCURSORNAME = 0x15;
static const Word SQL_API_SQLSETDESCFIELD = 0x3f9;
static const Word SQL_API_SQLSETDESCREC = 0x3fa;
static const Word SQL_API_SQLSETENVATTR = 0x3fb;
static const Shortint SQL_API_SQLSETPARAM = 0x16;
static const Word SQL_API_SQLSETSTMTATTR = 0x3fc;
static const Shortint SQL_API_SQLSETSTMTOPTION = 0x33;
static const Shortint SQL_API_SQLSPECIALCOLUMNS = 0x34;
static const Shortint SQL_API_SQLSTATISTICS = 0x35;
static const Shortint SQL_API_SQLTABLES = 0x36;
static const Shortint SQL_API_SQLTRANSACT = 0x17;
static const Shortint SQL_MAX_DRIVER_CONNECTIONS = 0x0;
static const Shortint SQL_MAXIMUM_DRIVER_CONNECTIONS = 0x0;
static const Shortint SQL_MAX_CONCURRENT_ACTIVITIES = 0x1;
static const Shortint SQL_MAXIMUM_CONCURRENT_ACTIVITIES = 0x1;
static const Shortint SQL_DATA_SOURCE_NAME = 0x2;
static const Shortint SQL_FETCH_DIRECTION = 0x8;
static const Shortint SQL_SERVER_NAME = 0xd;
static const Shortint SQL_SEARCH_PATTERN_ESCAPE = 0xe;
static const Shortint SQL_DBMS_NAME = 0x11;
static const Shortint SQL_DBMS_VER = 0x12;
static const Shortint SQL_ACCESSIBLE_TABLES = 0x13;
static const Shortint SQL_ACCESSIBLE_PROCEDURES = 0x14;
static const Shortint SQL_CURSOR_COMMIT_BEHAVIOR = 0x17;
static const Shortint SQL_DATA_SOURCE_READ_ONLY = 0x19;
static const Shortint SQL_DEFAULT_TXN_ISOLATION = 0x1a;
static const Shortint SQL_IDENTIFIER_CASE = 0x1c;
static const Shortint SQL_IDENTIFIER_QUOTE_CHAR = 0x1d;
static const Shortint SQL_MAX_COLUMN_NAME_LEN = 0x1e;
static const Shortint SQL_MAXIMUM_COLUMN_NAME_LENGTH = 0x1e;
static const Shortint SQL_MAX_CURSOR_NAME_LEN = 0x1f;
static const Shortint SQL_MAXIMUM_CURSOR_NAME_LENGTH = 0x1f;
static const Shortint SQL_MAX_SCHEMA_NAME_LEN = 0x20;
static const Shortint SQL_MAXIMUM_SCHEMA_NAME_LENGTH = 0x20;
static const Shortint SQL_MAX_CATALOG_NAME_LEN = 0x22;
static const Shortint SQL_MAXIMUM_CATALOG_NAME_LENGTH = 0x22;
static const Shortint SQL_MAX_TABLE_NAME_LEN = 0x23;
static const Shortint SQL_SCROLL_CONCURRENCY = 0x2b;
static const Shortint SQL_TXN_CAPABLE = 0x2e;
static const Shortint SQL_TRANSACTION_CAPABLE = 0x2e;
static const Shortint SQL_USER_NAME = 0x2f;
static const Shortint SQL_TXN_ISOLATION_OPTION = 0x48;
static const Shortint SQL_TRANSACTION_ISOLATION_OPTION = 0x48;
static const Shortint SQL_INTEGRITY = 0x49;
static const Shortint SQL_GETDATA_EXTENSIONS = 0x51;
static const Shortint SQL_NULL_COLLATION = 0x55;
static const Shortint SQL_ALTER_TABLE = 0x56;
static const Shortint SQL_ORDER_BY_COLUMNS_IN_SELECT = 0x5a;
static const Shortint SQL_SPECIAL_CHARACTERS = 0x5e;
static const Shortint SQL_MAX_COLUMNS_IN_GROUP_BY = 0x61;
static const Shortint SQL_MAXIMUM_COLUMNS_IN_GROUP_BY = 0x61;
static const Shortint SQL_MAX_COLUMNS_IN_INDEX = 0x62;
static const Shortint SQL_MAXIMUM_COLUMNS_IN_INDEX = 0x62;
static const Shortint SQL_MAX_COLUMNS_IN_ORDER_BY = 0x63;
static const Shortint SQL_MAXIMUM_COLUMNS_IN_ORDER_BY = 0x63;
static const Shortint SQL_MAX_COLUMNS_IN_SELECT = 0x64;
static const Shortint SQL_MAXIMUM_COLUMNS_IN_SELECT = 0x64;
static const Shortint SQL_MAX_COLUMNS_IN_TABLE = 0x65;
static const Shortint SQL_MAX_INDEX_SIZE = 0x66;
static const Shortint SQL_MAXIMUM_INDEX_SIZE = 0x66;
static const Shortint SQL_MAX_ROW_SIZE = 0x68;
static const Shortint SQL_MAXIMUM_ROW_SIZE = 0x68;
static const Shortint SQL_MAX_STATEMENT_LEN = 0x69;
static const Shortint SQL_MAXIMUM_STATEMENT_LENGTH = 0x69;
static const Shortint SQL_MAX_TABLES_IN_SELECT = 0x6a;
static const Shortint SQL_MAXIMUM_TABLES_IN_SELECT = 0x6a;
static const Shortint SQL_MAX_USER_NAME_LEN = 0x6b;
static const Shortint SQL_MAXIMUM_USER_NAME_LENGTH = 0x6b;
static const Shortint SQL_OJ_CAPABILITIES = 0x73;
static const Shortint SQL_OUTER_JOIN_CAPABILITIES = 0x73;
static const Word SQL_XOPEN_CLI_YEAR = 0x2710;
static const Word SQL_CURSOR_SENSITIVITY = 0x2711;
static const Word SQL_DESCRIBE_PARAMETER = 0x2712;
static const Word SQL_CATALOG_NAME = 0x2713;
static const Word SQL_COLLATION_SEQ = 0x2714;
static const Word SQL_MAX_IDENTIFIER_LEN = 0x2715;
static const Word SQL_MAXIMUM_IDENTIFIER_LENGTH = 0x2715;
static const Shortint SQL_AT_ADD_COLUMN = 0x1;
static const Shortint SQL_AT_DROP_COLUMN = 0x2;
static const Shortint SQL_AT_ADD_CONSTRAINT = 0x8;
static const Shortint SQL_AM_NONE = 0x0;
static const Shortint SQL_AM_CONNECTION = 0x1;
static const Shortint SQL_AM_STATEMENT = 0x2;
static const Shortint SQL_CB_DELETE = 0x0;
static const Shortint SQL_CB_CLOSE = 0x1;
static const Shortint SQL_CB_PRESERVE = 0x2;
static const Shortint SQL_FD_FETCH_NEXT = 0x1;
static const Shortint SQL_FD_FETCH_FIRST = 0x2;
static const Shortint SQL_FD_FETCH_LAST = 0x4;
static const Shortint SQL_FD_FETCH_PRIOR = 0x8;
static const Shortint SQL_FD_FETCH_ABSOLUTE = 0x10;
static const Shortint SQL_FD_FETCH_RELATIVE = 0x20;
static const Shortint SQL_GD_ANY_COLUMN = 0x1;
static const Shortint SQL_GD_ANY_ORDER = 0x2;
static const Shortint SQL_IC_UPPER = 0x1;
static const Shortint SQL_IC_LOWER = 0x2;
static const Shortint SQL_IC_SENSITIVE = 0x3;
static const Shortint SQL_IC_MIXED = 0x4;
static const Shortint SQL_OJ_LEFT = 0x1;
static const Shortint SQL_OJ_RIGHT = 0x2;
static const Shortint SQL_OJ_FULL = 0x4;
static const Shortint SQL_OJ_NESTED = 0x8;
static const Shortint SQL_OJ_NOT_ORDERED = 0x10;
static const Shortint SQL_OJ_INNER = 0x20;
static const Shortint SQL_OJ_ALL_COMPARISON_OPS = 0x40;
static const Shortint SQL_SCCO_READ_ONLY = 0x1;
static const Shortint SQL_SCCO_LOCK = 0x2;
static const Shortint SQL_SCCO_OPT_ROWVER = 0x4;
static const Shortint SQL_SCCO_OPT_VALUES = 0x8;
static const Shortint SQL_TC_NONE = 0x0;
static const Shortint SQL_TC_DML = 0x1;
static const Shortint SQL_TC_ALL = 0x2;
static const Shortint SQL_TC_DDL_COMMIT = 0x3;
static const Shortint SQL_TC_DDL_IGNORE = 0x4;
static const Shortint SQL_TXN_READ_UNCOMMITTED = 0x1;
static const Shortint SQL_TRANSACTION_READ_UNCOMMITTED = 0x1;
static const Shortint SQL_TXN_READ_COMMITTED = 0x2;
static const Shortint SQL_TRANSACTION_READ_COMMITTED = 0x2;
static const Shortint SQL_TXN_REPEATABLE_READ = 0x4;
static const Shortint SQL_TRANSACTION_REPEATABLE_READ = 0x4;
static const Shortint SQL_TXN_SERIALIZABLE = 0x8;
static const Shortint SQL_TRANSACTION_SERIALIZABLE = 0x8;
static const Shortint SQL_NC_HIGH = 0x0;
static const Shortint SQL_NC_LOW = 0x1;
static const Shortint SQL_IS_YEAR = 0x1;
static const Shortint SQL_IS_MONTH = 0x2;
static const Shortint SQL_IS_DAY = 0x3;
static const Shortint SQL_IS_HOUR = 0x4;
static const Shortint SQL_IS_MINUTE = 0x5;
static const Shortint SQL_IS_SECOND = 0x6;
static const Shortint SQL_IS_YEAR_TO_MONTH = 0x7;
static const Shortint SQL_IS_DAY_TO_HOUR = 0x8;
static const Shortint SQL_IS_DAY_TO_MINUTE = 0x9;
static const Shortint SQL_IS_DAY_TO_SECOND = 0xa;
static const Shortint SQL_IS_HOUR_TO_MINUTE = 0xb;
static const Shortint SQL_IS_HOUR_TO_SECOND = 0xc;
static const Shortint SQL_IS_MINUTE_TO_SECOND = 0xd;
static const Shortint SQL_SQLSTATE_SIZE = 0x5;
static const Shortint SQL_MAX_DSN_LENGTH = 0x20;
static const Word SQL_MAX_OPTION_STRING_LENGTH = 0x100;
static const Shortint SQL_HANDLE_SENV = 0x5;
static const Byte SQL_ATTR_ODBC_VERSION = 0xc8;
static const Byte SQL_ATTR_CONNECTION_POOLING = 0xc9;
static const Byte SQL_ATTR_CP_MATCH = 0xca;
static const Shortint SQL_CP_OFF = 0x0;
static const Shortint SQL_CP_ONE_PER_DRIVER = 0x1;
static const Shortint SQL_CP_ONE_PER_HENV = 0x2;
static const Shortint SQL_CP_DEFAULT = 0x0;
static const Shortint SQL_CP_STRICT_MATCH = 0x0;
static const Shortint SQL_CP_RELAXED_MATCH = 0x1;
static const Shortint SQL_CP_MATCH_DEFAULT = 0x0;
static const Shortint SQL_OV_ODBC2 = 0x2;
static const Shortint SQL_OV_ODBC3 = 0x3;
static const Shortint SQL_ACCESS_MODE = 0x65;
static const Shortint SQL_AUTOCOMMIT = 0x66;
static const Shortint SQL_LOGIN_TIMEOUT = 0x67;
static const Shortint SQL_OPT_TRACE = 0x68;
static const Shortint SQL_OPT_TRACEFILE = 0x69;
static const Shortint SQL_TRANSLATE_DLL = 0x6a;
static const Shortint SQL_TRANSLATE_OPTION = 0x6b;
static const Shortint SQL_TXN_ISOLATION = 0x6c;
static const Shortint SQL_CURRENT_QUALIFIER = 0x6d;
static const Shortint SQL_ODBC_CURSORS = 0x6e;
static const Shortint SQL_QUIET_MODE = 0x6f;
static const Shortint SQL_PACKET_SIZE = 0x70;
static const Shortint SQL_ATTR_ACCESS_MODE = 0x65;
static const Shortint SQL_ATTR_AUTOCOMMIT = 0x66;
static const Shortint SQL_ATTR_CONNECTION_TIMEOUT = 0x71;
static const Shortint SQL_ATTR_CURRENT_CATALOG = 0x6d;
static const Shortint SQL_ATTR_DISCONNECT_BEHAVIOR = 0x72;
static const Word SQL_ATTR_ENLIST_IN_DTC = 0x4b7;
static const Word SQL_ATTR_ENLIST_IN_XA = 0x4b8;
static const Shortint SQL_ATTR_LOGIN_TIMEOUT = 0x67;
static const Shortint SQL_ATTR_ODBC_CURSORS = 0x6e;
static const Shortint SQL_ATTR_PACKET_SIZE = 0x70;
static const Shortint SQL_ATTR_QUIET_MODE = 0x6f;
static const Shortint SQL_ATTR_TRACE = 0x68;
static const Shortint SQL_ATTR_TRACEFILE = 0x69;
static const Shortint SQL_ATTR_TRANSLATE_LIB = 0x6a;
static const Shortint SQL_ATTR_TRANSLATE_OPTION = 0x6b;
static const Shortint SQL_ATTR_TXN_ISOLATION = 0x6c;
static const Word SQL_ATTR_CONNECTION_DEAD = 0x4b9;
static const Word SQL_CONNECT_OPT_DRVR_START = 0x3e8;
static const Shortint SQL_CONN_OPT_MAX = 0x70;
static const Shortint SQL_CONN_OPT_MIN = 0x65;
static const Shortint SQL_MODE_READ_WRITE = 0x0;
static const Shortint SQL_MODE_READ_ONLY = 0x1;
static const Shortint SQL_MODE_DEFAULT = 0x0;
static const Shortint SQL_AUTOCOMMIT_OFF = 0x0;
static const Shortint SQL_AUTOCOMMIT_ON = 0x1;
static const Shortint SQL_AUTOCOMMIT_DEFAULT = 0x1;
static const Shortint SQL_LOGIN_TIMEOUT_DEFAULT = 0xf;
static const Shortint SQL_OPT_TRACE_OFF = 0x0;
static const Shortint SQL_OPT_TRACE_ON = 0x1;
static const Shortint SQL_OPT_TRACE_DEFAULT = 0x0;
#define SQL_OPT_TRACE_FILE_DEFAULT "\\SQL.LOG"
static const Shortint SQL_CUR_USE_IF_NEEDED = 0x0;
static const Shortint SQL_CUR_USE_ODBC = 0x1;
static const Shortint SQL_CUR_USE_DRIVER = 0x2;
static const Shortint SQL_CUR_DEFAULT = 0x2;
static const Shortint SQL_DB_RETURN_TO_POOL = 0x0;
static const Shortint SQL_DB_DISCONNECT = 0x1;
static const Shortint SQL_DB_DEFAULT = 0x0;
static const Shortint SQL_DTC_DONE = 0x0;
static const Shortint SQL_CD_TRUE = 0x1;
static const Shortint SQL_CD_FALSE = 0x0;
static const Shortint SQL_QUERY_TIMEOUT = 0x0;
static const Shortint SQL_MAX_ROWS = 0x1;
static const Shortint SQL_NOSCAN = 0x2;
static const Shortint SQL_MAX_LENGTH = 0x3;
static const Shortint SQL_ASYNC_ENABLE = 0x4;
static const Shortint SQL_BIND_TYPE = 0x5;
static const Shortint SQL_CURSOR_TYPE = 0x6;
static const Shortint SQL_CONCURRENCY = 0x7;
static const Shortint SQL_KEYSET_SIZE = 0x8;
static const Shortint SQL_ROWSET_SIZE = 0x9;
static const Shortint SQL_SIMULATE_CURSOR = 0xa;
static const Shortint SQL_RETRIEVE_DATA = 0xb;
static const Shortint SQL_USE_BOOKMARKS = 0xc;
static const Shortint SQL_GET_BOOKMARK = 0xd;
static const Shortint SQL_ROW_NUMBER = 0xe;
static const Shortint SQL_ATTR_ASYNC_ENABLE = 0x4;
static const Shortint SQL_ATTR_CONCURRENCY = 0x7;
static const Shortint SQL_ATTR_CURSOR_TYPE = 0x6;
static const Shortint SQL_ATTR_ENABLE_AUTO_IPD = 0xf;
static const Shortint SQL_ATTR_FETCH_BOOKMARK_PTR = 0x10;
static const Shortint SQL_ATTR_KEYSET_SIZE = 0x8;
static const Shortint SQL_ATTR_MAX_LENGTH = 0x3;
static const Shortint SQL_ATTR_MAX_ROWS = 0x1;
static const Shortint SQL_ATTR_NOSCAN = 0x2;
static const Shortint SQL_ATTR_PARAM_BIND_OFFSET_PTR = 0x11;
static const Shortint SQL_ATTR_PARAM_BIND_TYPE = 0x12;
static const Shortint SQL_ATTR_PARAM_OPERATION_PTR = 0x13;
static const Shortint SQL_ATTR_PARAM_STATUS_PTR = 0x14;
static const Shortint SQL_ATTR_PARAMS_PROCESSED_PTR = 0x15;
static const Shortint SQL_ATTR_PARAMSET_SIZE = 0x16;
static const Shortint SQL_ATTR_QUERY_TIMEOUT = 0x0;
static const Shortint SQL_ATTR_RETRIEVE_DATA = 0xb;
static const Shortint SQL_ATTR_ROW_BIND_OFFSET_PTR = 0x17;
static const Shortint SQL_ATTR_ROW_BIND_TYPE = 0x5;
static const Shortint SQL_ATTR_ROW_NUMBER = 0xe;
static const Shortint SQL_ATTR_ROW_OPERATION_PTR = 0x18;
static const Shortint SQL_ATTR_ROW_STATUS_PTR = 0x19;
static const Shortint SQL_ATTR_ROWS_FETCHED_PTR = 0x1a;
static const Shortint SQL_ATTR_ROW_ARRAY_SIZE = 0x1b;
static const Shortint SQL_ATTR_SIMULATE_CURSOR = 0xa;
static const Shortint SQL_ATTR_USE_BOOKMARKS = 0xc;
static const Shortint SQL_STMT_OPT_MAX = 0xe;
static const Shortint SQL_STMT_OPT_MIN = 0x0;
static const Shortint SQL_IS_POINTER = 0xfffffffc;
static const Shortint SQL_IS_UINTEGER = 0xfffffffb;
static const Shortint SQL_IS_INTEGER = 0xfffffffa;
static const Shortint SQL_IS_USMALLINT = 0xfffffff9;
static const Shortint SQL_IS_SMALLINT = 0xfffffff8;
static const Shortint SQL_PARAM_BIND_BY_COLUMN = 0x0;
static const Shortint SQL_PARAM_BIND_TYPE_DEFAULT = 0x0;
static const Shortint SQL_QUERY_TIMEOUT_DEFAULT = 0x0;
static const Shortint SQL_MAX_ROWS_DEFAULT = 0x0;
static const Shortint SQL_NOSCAN_OFF = 0x0;
static const Shortint SQL_NOSCAN_ON = 0x1;
static const Shortint SQL_NOSCAN_DEFAULT = 0x0;
static const Shortint SQL_MAX_LENGTH_DEFAULT = 0x0;
static const Shortint SQL_ASYNC_ENABLE_OFF = 0x0;
static const Shortint SQL_ASYNC_ENABLE_ON = 0x1;
static const Shortint SQL_ASYNC_ENABLE_DEFAULT = 0x0;
static const Shortint SQL_BIND_BY_COLUMN = 0x0;
static const Shortint SQL_BIND_TYPE_DEFAULT = 0x0;
static const Shortint SQL_CONCUR_READ_ONLY = 0x1;
static const Shortint SQL_CONCUR_LOCK = 0x2;
static const Shortint SQL_CONCUR_ROWVER = 0x3;
static const Shortint SQL_CONCUR_VALUES = 0x4;
static const Shortint SQL_CONCUR_DEFAULT = 0x1;
static const Shortint SQL_CURSOR_FORWARD_ONLY = 0x0;
static const Shortint SQL_CURSOR_KEYSET_DRIVEN = 0x1;
static const Shortint SQL_CURSOR_DYNAMIC = 0x2;
static const Shortint SQL_CURSOR_STATIC = 0x3;
static const Shortint SQL_CURSOR_TYPE_DEFAULT = 0x0;
static const Shortint SQL_ROWSET_SIZE_DEFAULT = 0x1;
static const Shortint SQL_KEYSET_SIZE_DEFAULT = 0x0;
static const Shortint SQL_SC_NON_UNIQUE = 0x0;
static const Shortint SQL_SC_TRY_UNIQUE = 0x1;
static const Shortint SQL_SC_UNIQUE = 0x2;
static const Shortint SQL_RD_OFF = 0x0;
static const Shortint SQL_RD_ON = 0x1;
static const Shortint SQL_RD_DEFAULT = 0x1;
static const Shortint SQL_UB_OFF = 0x0;
static const Shortint SQL_UB_ON = 0x1;
static const Shortint SQL_UB_DEFAULT = 0x0;
static const Shortint SQL_UB_FIXED = 0x1;
static const Shortint SQL_UB_VARIABLE = 0x2;
static const Shortint SQL_DATE = 0x9;
static const Shortint SQL_INTERVAL = 0xa;
static const Shortint SQL_TIME = 0xa;
static const Shortint SQL_TIMESTAMP = 0xb;
static const Shortint SQL_LONGVARCHAR = 0xffffffff;
static const Shortint SQL_BINARY = 0xfffffffe;
static const Shortint SQL_VARBINARY = 0xfffffffd;
static const Shortint SQL_LONGVARBINARY = 0xfffffffc;
static const Shortint SQL_BIGINT = 0xfffffffb;
static const Shortint SQL_TINYINT = 0xfffffffa;
static const Shortint SQL_BIT = 0xfffffff9;
static const Shortint SQL_GUID = 0xfffffff5;
static const Shortint SQL_CODE_YEAR = 0x1;
static const Shortint SQL_CODE_MONTH = 0x2;
static const Shortint SQL_CODE_DAY = 0x3;
static const Shortint SQL_CODE_HOUR = 0x4;
static const Shortint SQL_CODE_MINUTE = 0x5;
static const Shortint SQL_CODE_SECOND = 0x6;
static const Shortint SQL_CODE_YEAR_TO_MONTH = 0x7;
static const Shortint SQL_CODE_DAY_TO_HOUR = 0x8;
static const Shortint SQL_CODE_DAY_TO_MINUTE = 0x9;
static const Shortint SQL_CODE_DAY_TO_SECOND = 0xa;
static const Shortint SQL_CODE_HOUR_TO_MINUTE = 0xb;
static const Shortint SQL_CODE_HOUR_TO_SECOND = 0xc;
static const Shortint SQL_CODE_MINUTE_TO_SECOND = 0xd;
static const Shortint SQL_INTERVAL_YEAR = 0x65;
static const Shortint SQL_INTERVAL_MONTH = 0x66;
static const Shortint SQL_INTERVAL_DAY = 0x67;
static const Shortint SQL_INTERVAL_HOUR = 0x68;
static const Shortint SQL_INTERVAL_MINUTE = 0x69;
static const Shortint SQL_INTERVAL_SECOND = 0x6a;
static const Shortint SQL_INTERVAL_YEAR_TO_MONTH = 0x6b;
static const Shortint SQL_INTERVAL_DAY_TO_HOUR = 0x6c;
static const Shortint SQL_INTERVAL_DAY_TO_MINUTE = 0x6d;
static const Shortint SQL_INTERVAL_DAY_TO_SECOND = 0x6e;
static const Shortint SQL_INTERVAL_HOUR_TO_MINUTE = 0x6f;
static const Shortint SQL_INTERVAL_HOUR_TO_SECOND = 0x70;
static const Shortint SQL_INTERVAL_MINUTE_TO_SECOND = 0x71;
static const Shortint SQL_UNICODE = 0xffffffa1;
static const Shortint SQL_UNICODE_VARCHAR = 0xffffffa0;
static const Shortint SQL_UNICODE_LONGVARCHAR = 0xffffff9f;
static const Shortint SQL_UNICODE_CHAR = 0xffffffa1;
static const Shortint SQL_TYPE_DRIVER_START = 0x65;
static const Shortint SQL_TYPE_DRIVER_END = 0xffffff9f;
static const Shortint SQL_C_CHAR = 0x1;
static const Shortint SQL_C_LONG = 0x4;
static const Shortint SQL_C_SHORT = 0x5;
static const Shortint SQL_C_FLOAT = 0x7;
static const Shortint SQL_C_DOUBLE = 0x8;
static const Shortint SQL_C_NUMERIC = 0x2;
static const Shortint SQL_C_DEFAULT = 0x63;
static const Shortint SQL_SIGNED_OFFSET = 0xffffffec;
static const Shortint SQL_UNSIGNED_OFFSET = 0xffffffea;
static const Shortint SQL_C_DATE = 0x9;
static const Shortint SQL_C_TIME = 0xa;
static const Shortint SQL_C_TIMESTAMP = 0xb;
static const Shortint SQL_C_TYPE_DATE = 0x5b;
static const Shortint SQL_C_TYPE_TIME = 0x5c;
static const Shortint SQL_C_TYPE_TIMESTAMP = 0x5d;
static const Shortint SQL_C_INTERVAL_YEAR = 0x65;
static const Shortint SQL_C_INTERVAL_MONTH = 0x66;
static const Shortint SQL_C_INTERVAL_DAY = 0x67;
static const Shortint SQL_C_INTERVAL_HOUR = 0x68;
static const Shortint SQL_C_INTERVAL_MINUTE = 0x69;
static const Shortint SQL_C_INTERVAL_SECOND = 0x6a;
static const Shortint SQL_C_INTERVAL_YEAR_TO_MONTH = 0x6b;
static const Shortint SQL_C_INTERVAL_DAY_TO_HOUR = 0x6c;
static const Shortint SQL_C_INTERVAL_DAY_TO_MINUTE = 0x6d;
static const Shortint SQL_C_INTERVAL_DAY_TO_SECOND = 0x6e;
static const Shortint SQL_C_INTERVAL_HOUR_TO_MINUTE = 0x6f;
static const Shortint SQL_C_INTERVAL_HOUR_TO_SECOND = 0x70;
static const Shortint SQL_C_INTERVAL_MINUTE_TO_SECOND = 0x71;
static const Shortint SQL_C_BINARY = 0xfffffffe;
static const Shortint SQL_C_BIT = 0xfffffff9;
static const Shortint SQL_C_SBIGINT = 0xffffffe7;
static const Shortint SQL_C_UBIGINT = 0xffffffe5;
static const Shortint SQL_C_TINYINT = 0xfffffffa;
static const Shortint SQL_C_SLONG = 0xfffffff0;
static const Shortint SQL_C_SSHORT = 0xfffffff1;
static const Shortint SQL_C_STINYINT = 0xffffffe6;
static const Shortint SQL_C_ULONG = 0xffffffee;
static const Shortint SQL_C_USHORT = 0xffffffef;
static const Shortint SQL_C_UTINYINT = 0xffffffe4;
static const Shortint SQL_C_BOOKMARK = 0xffffffee;
static const Shortint SQL_C_GUID = 0xfffffff5;
static const Shortint SQL_TYPE_NULL = 0x0;
static const Shortint SQL_TYPE_MIN = 0xfffffff9;
static const Shortint SQL_TYPE_MAX = 0xc;
static const Shortint SQL_C_VARBOOKMARK = 0xfffffffe;
static const Shortint SQL_NO_ROW_NUMBER = 0xffffffff;
static const Shortint SQL_NO_COLUMN_NUMBER = 0xffffffff;
static const Shortint SQL_ROW_NUMBER_UNKNOWN = 0xfffffffe;
static const Shortint SQL_COLUMN_NUMBER_UNKNOWN = 0xfffffffe;
static const Shortint SQL_DEFAULT_PARAM = 0xfffffffb;
static const Shortint SQL_IGNORE = 0xfffffffa;
static const Shortint SQL_COLUMN_IGNORE = 0xfffffffa;
static const Shortint SQL_LEN_DATA_AT_EXEC_OFFSET = 0xffffff9c;
static const Shortint SQL_LEN_BINARY_ATTR_OFFSET = 0xffffff9c;
static const Shortint SQL_SETPARAM_VALUE_MAX = 0xffffffff;
static const Shortint SQL_COLUMN_COUNT = 0x0;
static const Shortint SQL_COLUMN_NAME = 0x1;
static const Shortint SQL_COLUMN_TYPE = 0x2;
static const Shortint SQL_COLUMN_LENGTH = 0x3;
static const Shortint SQL_COLUMN_PRECISION = 0x4;
static const Shortint SQL_COLUMN_SCALE = 0x5;
static const Shortint SQL_COLUMN_DISPLAY_SIZE = 0x6;
static const Shortint SQL_COLUMN_NULLABLE = 0x7;
static const Shortint SQL_COLUMN_UNSIGNED = 0x8;
static const Shortint SQL_COLUMN_MONEY = 0x9;
static const Shortint SQL_COLUMN_UPDATABLE = 0xa;
static const Shortint SQL_COLUMN_AUTO_INCREMENT = 0xb;
static const Shortint SQL_COLUMN_CASE_SENSITIVE = 0xc;
static const Shortint SQL_COLUMN_SEARCHABLE = 0xd;
static const Shortint SQL_COLUMN_TYPE_NAME = 0xe;
static const Shortint SQL_COLUMN_TABLE_NAME = 0xf;
static const Shortint SQL_COLUMN_OWNER_NAME = 0x10;
static const Shortint SQL_COLUMN_QUALIFIER_NAME = 0x11;
static const Shortint SQL_COLUMN_LABEL = 0x12;
static const Shortint SQL_COLATT_OPT_MAX = 0x12;
static const Word SQL_COLUMN_DRIVER_START = 0x3e8;
static const Shortint SQL_COLATT_OPT_MIN = 0x0;
static const Shortint SQL_ATTR_READONLY = 0x0;
static const Shortint SQL_ATTR_WRITE = 0x1;
static const Shortint SQL_ATTR_READWRITE_UNKNOWN = 0x2;
static const Shortint SQL_UNSEARCHABLE = 0x0;
static const Shortint SQL_LIKE_ONLY = 0x1;
static const Shortint SQL_ALL_EXCEPT_LIKE = 0x2;
static const Shortint SQL_SEARCHABLE = 0x3;
static const Shortint SQL_PRED_SEARCHABLE = 0x3;
static const Shortint SQL_NO_TOTAL = 0xfffffffc;
static const Shortint SQL_COL_PRED_CHAR = 0x1;
static const Shortint SQL_COL_PRED_BASIC = 0x2;
static const Shortint SQL_DESC_ARRAY_SIZE = 0x14;
static const Shortint SQL_DESC_ARRAY_STATUS_PTR = 0x15;
static const Shortint SQL_DESC_AUTO_UNIQUE_VALUE = 0xb;
static const Shortint SQL_DESC_BASE_COLUMN_NAME = 0x16;
static const Shortint SQL_DESC_BASE_TABLE_NAME = 0x17;
static const Shortint SQL_DESC_BIND_OFFSET_PTR = 0x18;
static const Shortint SQL_DESC_BIND_TYPE = 0x19;
static const Shortint SQL_DESC_CASE_SENSITIVE = 0xc;
static const Shortint SQL_DESC_CATALOG_NAME = 0x11;
static const Shortint SQL_DESC_CONCISE_TYPE = 0x2;
static const Shortint SQL_DESC_DATETIME_INTERVAL_PRECISION = 0x1a;
static const Shortint SQL_DESC_DISPLAY_SIZE = 0x6;
static const Shortint SQL_DESC_FIXED_PREC_SCALE = 0x9;
static const Shortint SQL_DESC_LABEL = 0x12;
static const Shortint SQL_DESC_LITERAL_PREFIX = 0x1b;
static const Shortint SQL_DESC_LITERAL_SUFFIX = 0x1c;
static const Shortint SQL_DESC_LOCAL_TYPE_NAME = 0x1d;
static const Shortint SQL_DESC_MAXIMUM_SCALE = 0x1e;
static const Shortint SQL_DESC_MINIMUM_SCALE = 0x1f;
static const Shortint SQL_DESC_NUM_PREC_RADIX = 0x20;
static const Shortint SQL_DESC_PARAMETER_TYPE = 0x21;
static const Shortint SQL_DESC_ROWS_PROCESSED_PTR = 0x22;
static const Shortint SQL_DESC_ROWVER = 0x23;
static const Shortint SQL_DESC_SCHEMA_NAME = 0x10;
static const Shortint SQL_DESC_SEARCHABLE = 0xd;
static const Shortint SQL_DESC_TYPE_NAME = 0xe;
static const Shortint SQL_DESC_TABLE_NAME = 0xf;
static const Shortint SQL_DESC_UNSIGNED = 0x8;
static const Shortint SQL_DESC_UPDATABLE = 0xa;
static const short SQL_DIAG_CURSOR_ROW_COUNT = 0xfffffb1f;
static const short SQL_DIAG_ROW_NUMBER = 0xfffffb20;
static const short SQL_DIAG_COLUMN_NUMBER = 0xfffffb21;
static const Shortint SQL_API_SQLALLOCHANDLESTD = 0x49;
static const Shortint SQL_API_SQLBULKOPERATIONS = 0x18;
static const Shortint SQL_API_SQLBINDPARAMETER = 0x48;
static const Shortint SQL_API_SQLBROWSECONNECT = 0x37;
static const Shortint SQL_API_SQLCOLATTRIBUTES = 0x6;
static const Shortint SQL_API_SQLCOLUMNPRIVILEGES = 0x38;
static const Shortint SQL_API_SQLDESCRIBEPARAM = 0x3a;
static const Shortint SQL_API_SQLDRIVERCONNECT = 0x29;
static const Shortint SQL_API_SQLDRIVERS = 0x47;
static const Shortint SQL_API_SQLEXTENDEDFETCH = 0x3b;
static const Shortint SQL_API_SQLFOREIGNKEYS = 0x3c;
static const Shortint SQL_API_SQLMORERESULTS = 0x3d;
static const Shortint SQL_API_SQLNATIVESQL = 0x3e;
static const Shortint SQL_API_SQLNUMPARAMS = 0x3f;
static const Shortint SQL_API_SQLPARAMOPTIONS = 0x40;
static const Shortint SQL_API_SQLPRIMARYKEYS = 0x41;
static const Shortint SQL_API_SQLPROCEDURECOLUMNS = 0x42;
static const Shortint SQL_API_SQLPROCEDURES = 0x43;
static const Shortint SQL_API_SQLSETPOS = 0x44;
static const Shortint SQL_API_SQLSETSCROLLOPTIONS = 0x45;
static const Shortint SQL_API_SQLTABLEPRIVILEGES = 0x46;
static const Shortint SQL_EXT_API_LAST = 0x48;
static const Shortint SQL_NUM_FUNCTIONS = 0x17;
static const Shortint SQL_EXT_API_START = 0x28;
static const Shortint SQL_NUM_EXTENSIONS = 0x21;
static const Shortint SQL_API_ALL_FUNCTIONS = 0x0;
static const Byte SQL_API_LOADBYORDINAL = 0xc7;
static const Word SQL_API_ODBC3_ALL_FUNCTIONS = 0x3e7;
static const Byte SQL_API_ODBC3_ALL_FUNCTIONS_SIZE = 0xfa;
static const Shortint SQL_INFO_FIRST = 0x0;
static const Shortint SQL_ACTIVE_CONNECTIONS = 0x0;
static const Shortint SQL_ACTIVE_STATEMENTS = 0x1;
static const Shortint SQL_DRIVER_HDBC = 0x3;
static const Shortint SQL_DRIVER_HENV = 0x4;
static const Shortint SQL_DRIVER_HSTMT = 0x5;
static const Shortint SQL_DRIVER_NAME = 0x6;
static const Shortint SQL_DRIVER_VER = 0x7;
static const Shortint SQL_ODBC_API_CONFORMANCE = 0x9;
static const Shortint SQL_ODBC_VER = 0xa;
static const Shortint SQL_ROW_UPDATES = 0xb;
static const Shortint SQL_ODBC_SAG_CLI_CONFORMANCE = 0xc;
static const Shortint SQL_ODBC_SQL_CONFORMANCE = 0xf;
static const Shortint SQL_PROCEDURES = 0x15;
static const Shortint SQL_CONCAT_NULL_BEHAVIOR = 0x16;
static const Shortint SQL_CURSOR_ROLLBACK_BEHAVIOR = 0x18;
static const Shortint SQL_EXPRESSIONS_IN_ORDERBY = 0x1b;
static const Shortint SQL_MAX_OWNER_NAME_LEN = 0x20;
static const Shortint SQL_MAX_PROCEDURE_NAME_LEN = 0x21;
static const Shortint SQL_MAX_QUALIFIER_NAME_LEN = 0x22;
static const Shortint SQL_MULT_RESULT_SETS = 0x24;
static const Shortint SQL_MULTIPLE_ACTIVE_TXN = 0x25;
static const Shortint SQL_OUTER_JOINS = 0x26;
static const Shortint SQL_OWNER_TERM = 0x27;
static const Shortint SQL_PROCEDURE_TERM = 0x28;
static const Shortint SQL_QUALIFIER_NAME_SEPARATOR = 0x29;
static const Shortint SQL_QUALIFIER_TERM = 0x2a;
static const Shortint SQL_SCROLL_OPTIONS = 0x2c;
static const Shortint SQL_TABLE_TERM = 0x2d;
static const Shortint SQL_CONVERT_FUNCTIONS = 0x30;
static const Shortint SQL_NUMERIC_FUNCTIONS = 0x31;
static const Shortint SQL_STRING_FUNCTIONS = 0x32;
static const Shortint SQL_SYSTEM_FUNCTIONS = 0x33;
static const Shortint SQL_TIMEDATE_FUNCTIONS = 0x34;
static const Shortint SQL_CONVERT_BIGINT = 0x35;
static const Shortint SQL_CONVERT_BINARY = 0x36;
static const Shortint SQL_CONVERT_BIT = 0x37;
static const Shortint SQL_CONVERT_CHAR = 0x38;
static const Shortint SQL_CONVERT_DATE = 0x39;
static const Shortint SQL_CONVERT_DECIMAL = 0x3a;
static const Shortint SQL_CONVERT_DOUBLE = 0x3b;
static const Shortint SQL_CONVERT_FLOAT = 0x3c;
static const Shortint SQL_CONVERT_INTEGER = 0x3d;
static const Shortint SQL_CONVERT_LONGVARCHAR = 0x3e;
static const Shortint SQL_CONVERT_NUMERIC = 0x3f;
static const Shortint SQL_CONVERT_REAL = 0x40;
static const Shortint SQL_CONVERT_SMALLINT = 0x41;
static const Shortint SQL_CONVERT_TIME = 0x42;
static const Shortint SQL_CONVERT_TIMESTAMP = 0x43;
static const Shortint SQL_CONVERT_TINYINT = 0x44;
static const Shortint SQL_CONVERT_VARBINARY = 0x45;
static const Shortint SQL_CONVERT_VARCHAR = 0x46;
static const Shortint SQL_CONVERT_LONGVARBINARY = 0x47;
static const Shortint SQL_ODBC_SQL_OPT_IEF = 0x49;
static const Shortint SQL_CORRELATION_NAME = 0x4a;
static const Shortint SQL_NON_NULLABLE_COLUMNS = 0x4b;
static const Shortint SQL_DRIVER_HLIB = 0x4c;
static const Shortint SQL_DRIVER_ODBC_VER = 0x4d;
static const Shortint SQL_LOCK_TYPES = 0x4e;
static const Shortint SQL_POS_OPERATIONS = 0x4f;
static const Shortint SQL_POSITIONED_STATEMENTS = 0x50;
static const Shortint SQL_BOOKMARK_PERSISTENCE = 0x52;
static const Shortint SQL_STATIC_SENSITIVITY = 0x53;
static const Shortint SQL_FILE_USAGE = 0x54;
static const Shortint SQL_COLUMN_ALIAS = 0x57;
static const Shortint SQL_GROUP_BY = 0x58;
static const Shortint SQL_KEYWORDS = 0x59;
static const Shortint SQL_OWNER_USAGE = 0x5b;
static const Shortint SQL_QUALIFIER_USAGE = 0x5c;
static const Shortint SQL_QUOTED_IDENTIFIER_CASE = 0x5d;
static const Shortint SQL_SUBQUERIES = 0x5f;
static const Shortint SQL_UNION = 0x60;
static const Shortint SQL_MAX_ROW_SIZE_INCLUDES_LONG = 0x67;
static const Shortint SQL_MAX_CHAR_LITERAL_LEN = 0x6c;
static const Shortint SQL_TIMEDATE_ADD_INTERVALS = 0x6d;
static const Shortint SQL_TIMEDATE_DIFF_INTERVALS = 0x6e;
static const Shortint SQL_NEED_LONG_DATA_LEN = 0x6f;
static const Shortint SQL_MAX_BINARY_LITERAL_LEN = 0x70;
static const Shortint SQL_LIKE_ESCAPE_CLAUSE = 0x71;
static const Shortint SQL_QUALIFIER_LOCATION = 0x72;
static const Shortint SQL_BRC_PROCEDURES = 0x1;
static const Shortint SQL_BRC_EXPLICIT = 0x2;
static const Shortint SQL_BRC_ROLLED_UP = 0x4;
static const Shortint SQL_BS_SELECT_EXPLICIT = 0x1;
static const Shortint SQL_BS_ROW_COUNT_EXPLICIT = 0x2;
static const Shortint SQL_BS_SELECT_PROC = 0x4;
static const Shortint SQL_BS_ROW_COUNT_PROC = 0x8;
static const Shortint SQL_PARC_BATCH = 0x1;
static const Shortint SQL_PARC_NO_BATCH = 0x2;
static const Shortint SQL_PAS_BATCH = 0x1;
static const Shortint SQL_PAS_NO_BATCH = 0x2;
static const Shortint SQL_PAS_NO_SELECT = 0x3;
static const Shortint SQL_IK_NONE = 0x0;
static const Shortint SQL_IK_ASC = 0x1;
static const Shortint SQL_IK_DESC = 0x2;
static const Shortint SQL_IK_ALL = 0x3;
static const Shortint SQL_INFO_LAST = 0x72;
static const Word SQL_INFO_DRIVER_START = 0x3e8;
static const Shortint SQL_ACTIVE_ENVIRONMENTS = 0x74;
static const Shortint SQL_ALTER_DOMAIN = 0x75;
static const Shortint SQL_SQL_CONFORMANCE = 0x76;
static const Shortint SQL_DATETIME_LITERALS = 0x77;
static const Word SQL_ASYNC_MODE = 0x2725;
static const Shortint SQL_BATCH_ROW_COUNT = 0x78;
static const Shortint SQL_BATCH_SUPPORT = 0x79;
static const Shortint SQL_GD_BLOCK = 0x4;
static const Shortint SQL_GD_BOUND = 0x8;
static const Shortint SQL_PARAM_TYPE_UNKNOWN = 0x0;
static const Shortint SQL_PARAM_INPUT = 0x1;
static const Shortint SQL_PARAM_INPUT_OUTPUT = 0x2;
static const Shortint SQL_RESULT_COL = 0x3;
static const Shortint SQL_PARAM_OUTPUT = 0x4;
static const Shortint SQL_RETURN_VALUE = 0x5;
static const Shortint SQL_PT_UNKNOWN = 0x0;
static const Shortint SQL_PT_PROCEDURE = 0x1;
static const Shortint SQL_PT_FUNCTION = 0x2;
static const Shortint SQL_BEST_ROWID = 0x1;
static const Shortint SQL_ROWVER = 0x2;
static const Shortint SQL_PC_NOT_PSEUDO = 0x1;
static const Shortint SQL_QUICK = 0x0;
static const Shortint SQL_ENSURE = 0x1;
static const Shortint SQL_TABLE_STAT = 0x0;
static const char SQL_ALL_CATALOGS = '\x25';
static const char SQL_ALL_SCHEMAS = '\x25';
static const char SQL_ALL_TABLE_TYPES = '\x25';
static const Shortint SQL_DRIVER_NOPROMPT = 0x0;
static const Shortint SQL_DRIVER_COMPLETE = 0x1;
static const Shortint SQL_DRIVER_PROMPT = 0x2;
static const Shortint SQL_DRIVER_COMPLETE_REQUIRED = 0x3;
static const Shortint SQL_FETCH_BOOKMARK = 0x8;
static const Shortint SQL_ROW_SUCCESS = 0x0;
static const Shortint SQL_ROW_DELETED = 0x1;
static const Shortint SQL_ROW_UPDATED = 0x2;
static const Shortint SQL_ROW_NOROW = 0x3;
static const Shortint SQL_ROW_ADDED = 0x4;
static const Shortint SQL_ROW_ERROR = 0x5;
static const Shortint SQL_ROW_SUCCESS_WITH_INFO = 0x6;
static const Shortint SQL_ROW_PROCEED = 0x0;
static const Shortint SQL_ROW_IGNORE = 0x1;
static const Shortint SQL_PARAM_SUCCESS = 0x0;
static const Shortint SQL_PARAM_SUCCESS_WITH_INFO = 0x6;
static const Shortint SQL_PARAM_ERROR = 0x5;
static const Shortint SQL_PARAM_UNUSED = 0x7;
static const Shortint SQL_PARAM_DIAG_UNAVAILABLE = 0x1;
static const Shortint SQL_PARAM_PROCEED = 0x0;
static const Shortint SQL_PARAM_IGNORE = 0x1;
static const Shortint SQL_CASCADE = 0x0;
static const Shortint SQL_RESTRICT = 0x1;
static const Shortint SQL_SET_NULL = 0x2;
static const Shortint SQL_NO_ACTION = 0x3;
static const Shortint SQL_SET_DEFAULT = 0x4;
static const Shortint SQL_INITIALLY_DEFERRED = 0x5;
static const Shortint SQL_INITIALLY_IMMEDIATE = 0x6;
static const Shortint SQL_NOT_DEFERRABLE = 0x7;
static const Shortint SQL_WCHAR = 0xfffffff8;
static const Shortint SQL_WVARCHAR = 0xfffffff7;
static const Shortint SQL_WLONGVARCHAR = 0xfffffff6;
static const Shortint SQL_C_WCHAR = 0xfffffff8;
static const Shortint SQL_C_TCHAR = 0xfffffff8;
static const Shortint SQL_SQLSTATE_SIZEW = 0xa;
#define DefSqlApiDLL "ODBC32.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE TOdbcFunctions* OdbCalls;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE int __fastcall SQL_LEN_DATA_AT_EXEC(int ALength);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdodbc */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdodbc;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDOdbc
