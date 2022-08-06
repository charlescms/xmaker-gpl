// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainDb2Driver.pas' rev: 5.00

#ifndef ZPlainDb2DriverHPP
#define ZPlainDb2DriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDriver.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplaindb2driver
{
//-- type declarations -------------------------------------------------------
typedef char *PSQLCHAR;

typedef int SQLINTEGER;

typedef int *PSQLINTEGER;

typedef short SQLSMALLINT;

typedef short *PSQLSMALLINT;

typedef double SQLDOUBLE;

typedef double SQLFLOAT;

typedef float SQLREAL;

typedef short SQLRETURN;

typedef unsigned SQLUINTEGER;

typedef unsigned *PSQLUINTEGER;

typedef short SQLUSMALLINT;

typedef short *PSQLUSMALLINT;

typedef void *SQLPOINTER;

typedef int SQLHANDLE;

typedef int *PSQLHANDLE;

typedef int SQLHENV;

typedef int *PSQLHENV;

typedef int SQLHDBC;

typedef int *PSQLHDBC;

typedef int SQLHSTMT;

typedef int *PSQLHSTMT;

typedef int SQLHDESC;

typedef unsigned SQLLEN;

typedef unsigned SQLULEN;

typedef short SQLSETPOSIROW;

typedef HWND SQLHWND;

#pragma pack(push, 1)
struct SQLBIGINT
{
	unsigned dwLowWord;
	int dwHighWord;
} ;
#pragma pack(pop)

typedef SQLBIGINT *PSQLBIGINT;

#pragma pack(push, 1)
struct SQLUBIGINT
{
	unsigned dwLowWord;
	unsigned dwHighWord;
} ;
#pragma pack(pop)

typedef SQLUBIGINT *PSQLUBIGINT;

#pragma pack(push, 1)
struct SQL_DATE_STRUCT
{
	short year;
	short month;
	short day;
} ;
#pragma pack(pop)

typedef SQL_DATE_STRUCT *PSQL_DATE_STRUCT;

#pragma pack(push, 1)
struct SQL_TIME_STRUCT
{
	short hour;
	short minute;
	short second;
} ;
#pragma pack(pop)

typedef SQL_TIME_STRUCT *PSQL_TIME_STRUCT;

#pragma pack(push, 1)
struct SQL_TIMESTAMP_STRUCT
{
	short year;
	short month;
	short day;
	short hour;
	short minute;
	short second;
	unsigned fraction;
} ;
#pragma pack(pop)

typedef SQL_TIMESTAMP_STRUCT *PSQL_TIMESTAMP_STRUCT;

#pragma pack(push, 1)
struct SQL_YEAR_MONTH_STRUCT
{
	unsigned year;
	unsigned month;
} ;
#pragma pack(pop)

typedef SQL_YEAR_MONTH_STRUCT *PSQL_YEAR_MONTH_STRUCT;

#pragma pack(push, 1)
struct SQL_DAY_SECOND_STRUCT
{
	unsigned day;
	unsigned hour;
	unsigned minute;
	unsigned second;
	unsigned fraction;
} ;
#pragma pack(pop)

typedef SQL_DAY_SECOND_STRUCT *PSQL_DAY_SECOND_STRUCT;

#pragma option push -b-
enum SQLINTERVAL { SQL_IS_YEAR, SQL_IS_MONTH, SQL_IS_DAY, SQL_IS_HOUR, SQL_IS_MINUTE, SQL_IS_SECOND, 
	SQL_IS_YEAR_TO_MONTH, SQL_IS_DAY_TO_HOUR, SQL_IS_DAY_TO_MINUTE, SQL_IS_DAY_TO_SECOND, SQL_IS_HOUR_TO_MINUTE, 
	SQL_IS_HOUR_TO_SECOND, SQL_IS_MINUTE_TO_SECOND };
#pragma option pop

struct SQL_INTERVAL_STRUCT
{
	SQLINTERVAL interval_type;
	short interval_sign;
	SQL_YEAR_MONTH_STRUCT year_month;
	SQL_DAY_SECOND_STRUCT day_second;
} ;

typedef SQL_INTERVAL_STRUCT *PSQL_INTERVAL_STRUCT;

#pragma pack(push, 1)
struct SQL_NUMERIC_STRUCT
{
	Byte precision;
	Byte scale;
	Byte sign;
	char val[16];
} ;
#pragma pack(pop)

typedef SQL_NUMERIC_STRUCT  PSQL_NUMERIC_STRUCT;

__interface IZDb2PlainDriver;
typedef System::DelphiInterface<IZDb2PlainDriver> _di_IZDb2PlainDriver;
__interface INTERFACE_UUID("{57AA5614-800C-4543-B5E4-66FE0E12006A}") IZDb2PlainDriver  : public IZPlainDriver 
	
{
	
public:
	virtual short __stdcall SQLAllocConnect(int henv, PSQLHDBC phdbc) = 0 ;
	virtual short __stdcall SQLAllocEnv(PSQLHENV phenv) = 0 ;
	virtual short __stdcall SQLAllocStmt(int hdbc, PSQLHSTMT phstmt) = 0 ;
	virtual short __stdcall SQLAllocHandle(short fHandleType, int hInput, PSQLHANDLE phOutput) = 0 ;
	virtual short __stdcall SQLBindCol(int hstmt, short icol, short fCType, void * rgbValue, int cbValueMax
		, PSQLINTEGER pcbValue) = 0 ;
	virtual short __stdcall SQLCancel(int hstmt) = 0 ;
	virtual short __stdcall SQLColAttribute(int hstmt, short icol, short fDescType, void * rgbDesc, short 
		cbDescMax, PSQLSMALLINT pcbDesc, void * pfDesc) = 0 ;
	virtual short __stdcall SQLConnect(int hdbc, char * szDSN, short cbDSN, char * szUID, short cbUID, 
		char * szAuthStr, short cbAuthStr) = 0 ;
	virtual short __stdcall SQLDescribeCol(int hstmt, short icol, char * szColName, short cbColNameMax, 
		PSQLSMALLINT pcbColName, PSQLSMALLINT pfSqlType, PSQLUINTEGER pcbColDef, PSQLSMALLINT pibScale, PSQLSMALLINT 
		pfNullable) = 0 ;
	virtual short __stdcall SQLDisconnect(int hdbc) = 0 ;
	virtual short __stdcall SQLError(int henv, int hdbc, int hstmt, char * szSqlState, PSQLINTEGER pfNativeError
		, char * szErrorMsg, short cbErrorMsgMax, PSQLSMALLINT pcbErrorMsg) = 0 ;
	virtual short __stdcall SQLExecDirect(int hstmt, char * szSqlStr, int cbSqlStr) = 0 ;
	virtual short __stdcall SQLExecute(int hstmt) = 0 ;
	virtual short __stdcall SQLFetch(int hstmt) = 0 ;
	virtual short __stdcall SQLFreeConnect(int hdbc) = 0 ;
	virtual short __stdcall SQLFreeEnv(int henv) = 0 ;
	virtual short __stdcall SQLFreeStmt(int hstmt, short fOption) = 0 ;
	virtual short __stdcall SQLCloseCursor(int hStmt) = 0 ;
	virtual short __stdcall SQLGetCursorName(int hstmt, char * szCursor, short cbCursorMax, PSQLSMALLINT 
		pcbCursor) = 0 ;
	virtual short __stdcall SQLGetData(int hstmt, short icol, short fCType, void * rgbValue, int cbValueMax
		, PSQLINTEGER pcbValue) = 0 ;
	virtual short __stdcall SQLNumResultCols(int hstmt, PSQLSMALLINT pccol) = 0 ;
	virtual short __stdcall SQLPrepare(int hstmt, char * szSqlStr, int cbSqlStr) = 0 ;
	virtual short __stdcall SQLRowCount(int hstmt, PSQLINTEGER pcrow) = 0 ;
	virtual short __stdcall SQLSetCursorName(int hstmt, char * szCursor, short cbCursor) = 0 ;
	virtual short __stdcall SQLSetParam(int hstmt, short ipar, short fCType, short fSqlType, unsigned cbParamDef
		, short ibScale, void * rgbValue, PSQLINTEGER pcbValue) = 0 ;
	virtual short __stdcall SQLTransact(int henv, int hdbc, short fType) = 0 ;
	virtual short __stdcall SQLEndTran(short fHandleType, int hHandle, short fType) = 0 ;
	virtual short __stdcall SQLFreeHandle(short fHandleType, int hHandle) = 0 ;
	virtual short __stdcall SQLGetDiagRec(short fHandleType, int hHandle, short iRecNumber, char * pszSqlState
		, PSQLINTEGER pfNativeError, char * pszErrorMsg, short cbErrorMsgMax, PSQLSMALLINT pcbErrorMsg) = 0 
		;
	virtual short __stdcall SQLGetDiagField(short fHandleType, int hHandle, short iRecNumber, short fDiagIdentifier
		, void * pDiagInfo, short cbDiagInfoMax, PSQLSMALLINT pcbDiagInfo) = 0 ;
	virtual short __stdcall SQLCopyDesc(int hDescSource, int hDescTarget) = 0 ;
	virtual short __stdcall SQLGetDescField(int DescriptorHandle, short RecNumber, short FieldIdentifier
		, void * Value, int BufferLength, PSQLINTEGER StringLength) = 0 ;
	virtual short __stdcall SQLGetDescRec(int DescriptorHandle, short RecNumber, char * Name, short BufferLength
		, PSQLSMALLINT StringLength, PSQLSMALLINT _Type, PSQLSMALLINT SubType, PSQLINTEGER Length, PSQLSMALLINT 
		Precision, PSQLSMALLINT Scale, PSQLSMALLINT Nullable) = 0 ;
	virtual short __stdcall SQLSetDescField(int DescriptorHandle, short RecNumber, short FieldIdentifier
		, void * Value, int BufferLength) = 0 ;
	virtual short __stdcall SQLSetDescRec(int DescriptorHandle, short RecNumber, short _Type, short SubType
		, int Length, short Precision, short Scale, void * Data, PSQLINTEGER StringLength, PSQLINTEGER Indicator
		) = 0 ;
	virtual short __stdcall SQLSetConnectAttr(int hdbc, int fOption, void * pvParam, int fStrLen) = 0 ;
		
	virtual short __stdcall SQLSetConnectOption(int hdbc, short fOption, unsigned vParam) = 0 ;
	virtual short __stdcall SQLSetStmtAttr(int hstmt, int fOption, void * pvParam, int fStrLen) = 0 ;
	virtual short __stdcall SQLSetStmtOption(int hstmt, short fOption, unsigned vParam) = 0 ;
	virtual short __stdcall SQLGetSubString(int hstmt, short LocatorCType, int SourceLocator, unsigned 
		FromPosition, unsigned ForLength, short TargetCType, void * rgbValue, int cbValueMax, PSQLINTEGER 
		StringLength, PSQLINTEGER IndicatorValue) = 0 ;
	virtual short __stdcall SQLGetLength(int hstmt, short LocatorCType, int Locator, PSQLINTEGER StringLength
		, PSQLINTEGER IndicatorValue) = 0 ;
	virtual short __stdcall SQLGetPosition(int hstmt, short LocatorCType, int SourceLocator, int SearchLocator
		, char * SearchLiteral, int SearchLiteralLength, unsigned FromPosition, PSQLUINTEGER LocatedAt, PSQLINTEGER 
		IndicatorValue) = 0 ;
	virtual short __stdcall SQLBindParameter(int hstmt, short ipar, short fParamType, short fCType, short 
		fSqlType, unsigned cbColDef, short ibScale, void * rgbValue, int cbValueMax, PSQLINTEGER pcbValue)
		 = 0 ;
	virtual short __stdcall SQLParamData(int hstmt, void * prgbValue) = 0 ;
	virtual short __stdcall SQLPutData(int hstmt, void * rgbValue, int cbValue) = 0 ;
	virtual short __stdcall SQLColumns(int hstmt, char * szCatalogName, short cbCatalogName, char * szSchemaName
		, short cbSchemaName, char * szTableName, short cbTableName, char * szColumnName, short cbColumnName
		) = 0 ;
	virtual short __stdcall SQLDataSources(int henv, short fDirection, char * szDSN, short cbDSNMax, short 
		pcbDSN, char * szDescription, short cbDescriptionMax, PSQLSMALLINT pcbDescription) = 0 ;
	virtual short __stdcall SQLFetchScroll(int StatementHandle, short FetchOrientation, unsigned FetchOffset
		) = 0 ;
	virtual short __stdcall SQLGetFunctions(int hdbc, short fFunction, PSQLUSMALLINT pfExists) = 0 ;
	virtual short __stdcall SQLGetInfo(int hdbc, short fInfoType, void * rgbInfoValue, short cbInfoValueMax
		, PSQLSMALLINT pcbInfoValue) = 0 ;
	virtual short __stdcall SQLGetStmtAttr(int StatementHandle, int Attribute, void * Value, int BufferLength
		, int StringLength) = 0 ;
	virtual short __stdcall SQLGetStmtOption(int hstmt, short fOption, void * pvParam) = 0 ;
	virtual short __stdcall SQLGetTypeInfo(int hstmt, short fSqlType) = 0 ;
	virtual short __stdcall SQLSpecialColumns(int hstmt, short fColType, char * szCatalogName, short cbCatalogName
		, char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, short fScope, short 
		fNullable) = 0 ;
	virtual short __stdcall SQLStatistics(int hstmt, char * szCatalogName, short cbCatalogName, char * 
		szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, short fUnique, short fAccuracy
		) = 0 ;
	virtual short __stdcall SQLTables(int hstmt, char * szCatalogName, short cbCatalogName, char * szSchemaName
		, short cbSchemaName, char * szTableName, short cbTableName, short szTableType, short cbTableType)
		 = 0 ;
	virtual short __stdcall SQLNextResult(int hstmtSource, int hstmtTarget) = 0 ;
};

class DELPHICLASS TZDb2PlainDriver;
class PASCALIMPLEMENTATION TZDb2PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZDb2PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	short __stdcall SQLAllocConnect(int henv, PSQLHDBC phdbc);
	short __stdcall SQLAllocEnv(PSQLHENV phenv);
	short __stdcall SQLAllocStmt(int hdbc, PSQLHSTMT phstmt);
	short __stdcall SQLAllocHandle(short fHandleType, int hInput, PSQLHANDLE phOutput);
	short __stdcall SQLBindCol(int hstmt, short icol, short fCType, void * rgbValue, int cbValueMax, PSQLINTEGER 
		pcbValue);
	short __stdcall SQLCancel(int hstmt);
	short __stdcall SQLColAttribute(int hstmt, short icol, short fDescType, void * rgbDesc, short cbDescMax
		, PSQLSMALLINT pcbDesc, void * pfDesc);
	short __stdcall SQLConnect(int hdbc, char * szDSN, short cbDSN, char * szUID, short cbUID, char * szAuthStr
		, short cbAuthStr);
	short __stdcall SQLDescribeCol(int hstmt, short icol, char * szColName, short cbColNameMax, PSQLSMALLINT 
		pcbColName, PSQLSMALLINT pfSqlType, PSQLUINTEGER pcbColDef, PSQLSMALLINT pibScale, PSQLSMALLINT pfNullable
		);
	short __stdcall SQLDisconnect(int hdbc);
	short __stdcall SQLError(int henv, int hdbc, int hstmt, char * szSqlState, PSQLINTEGER pfNativeError
		, char * szErrorMsg, short cbErrorMsgMax, PSQLSMALLINT pcbErrorMsg);
	short __stdcall SQLExecDirect(int hstmt, char * szSqlStr, int cbSqlStr);
	short __stdcall SQLExecute(int hstmt);
	short __stdcall SQLFetch(int hstmt);
	short __stdcall SQLFreeConnect(int hdbc);
	short __stdcall SQLFreeEnv(int henv);
	short __stdcall SQLFreeStmt(int hstmt, short fOption);
	short __stdcall SQLCloseCursor(int hStmt);
	short __stdcall SQLGetCursorName(int hstmt, char * szCursor, short cbCursorMax, PSQLSMALLINT pcbCursor
		);
	short __stdcall SQLGetData(int hstmt, short icol, short fCType, void * rgbValue, int cbValueMax, PSQLINTEGER 
		pcbValue);
	short __stdcall SQLNumResultCols(int hstmt, PSQLSMALLINT pccol);
	short __stdcall SQLPrepare(int hstmt, char * szSqlStr, int cbSqlStr);
	short __stdcall SQLRowCount(int hstmt, PSQLINTEGER pcrow);
	short __stdcall SQLSetCursorName(int hstmt, char * szCursor, short cbCursor);
	short __stdcall SQLSetParam(int hstmt, short ipar, short fCType, short fSqlType, unsigned cbParamDef
		, short ibScale, void * rgbValue, PSQLINTEGER pcbValue);
	short __stdcall SQLTransact(int henv, int hdbc, short fType);
	short __stdcall SQLEndTran(short fHandleType, int hHandle, short fType);
	short __stdcall SQLFreeHandle(short fHandleType, int hHandle);
	short __stdcall SQLGetDiagRec(short fHandleType, int hHandle, short iRecNumber, char * pszSqlState, 
		PSQLINTEGER pfNativeError, char * pszErrorMsg, short cbErrorMsgMax, PSQLSMALLINT pcbErrorMsg);
	short __stdcall SQLGetDiagField(short fHandleType, int hHandle, short iRecNumber, short fDiagIdentifier
		, void * pDiagInfo, short cbDiagInfoMax, PSQLSMALLINT pcbDiagInfo);
	short __stdcall SQLCopyDesc(int hDescSource, int hDescTarget);
	short __stdcall SQLGetDescField(int DescriptorHandle, short RecNumber, short FieldIdentifier, void * 
		Value, int BufferLength, PSQLINTEGER StringLength);
	short __stdcall SQLGetDescRec(int DescriptorHandle, short RecNumber, char * Name, short BufferLength
		, PSQLSMALLINT StringLength, PSQLSMALLINT _Type, PSQLSMALLINT SubType, PSQLINTEGER Length, PSQLSMALLINT 
		Precision, PSQLSMALLINT Scale, PSQLSMALLINT Nullable);
	short __stdcall SQLSetDescField(int DescriptorHandle, short RecNumber, short FieldIdentifier, void * 
		Value, int BufferLength);
	short __stdcall SQLSetDescRec(int DescriptorHandle, short RecNumber, short _Type, short SubType, int 
		Length, short Precision, short Scale, void * Data, PSQLINTEGER StringLength, PSQLINTEGER Indicator
		);
	short __stdcall SQLSetConnectAttr(int hdbc, int fOption, void * pvParam, int fStrLen);
	short __stdcall SQLSetConnectOption(int hdbc, short fOption, unsigned vParam);
	short __stdcall SQLSetStmtAttr(int hstmt, int fOption, void * pvParam, int fStrLen);
	short __stdcall SQLSetStmtOption(int hstmt, short fOption, unsigned vParam);
	short __stdcall SQLGetSubString(int hstmt, short LocatorCType, int SourceLocator, unsigned FromPosition
		, unsigned ForLength, short TargetCType, void * rgbValue, int cbValueMax, PSQLINTEGER StringLength
		, PSQLINTEGER IndicatorValue);
	short __stdcall SQLGetLength(int hstmt, short LocatorCType, int Locator, PSQLINTEGER StringLength, 
		PSQLINTEGER IndicatorValue);
	short __stdcall SQLGetPosition(int hstmt, short LocatorCType, int SourceLocator, int SearchLocator, 
		char * SearchLiteral, int SearchLiteralLength, unsigned FromPosition, PSQLUINTEGER LocatedAt, PSQLINTEGER 
		IndicatorValue);
	short __stdcall SQLBindParameter(int hstmt, short ipar, short fParamType, short fCType, short fSqlType
		, unsigned cbColDef, short ibScale, void * rgbValue, int cbValueMax, PSQLINTEGER pcbValue);
	short __stdcall SQLParamData(int hstmt, void * prgbValue);
	short __stdcall SQLPutData(int hstmt, void * rgbValue, int cbValue);
	short __stdcall SQLColumns(int hstmt, char * szCatalogName, short cbCatalogName, char * szSchemaName
		, short cbSchemaName, char * szTableName, short cbTableName, char * szColumnName, short cbColumnName
		);
	short __stdcall SQLDataSources(int henv, short fDirection, char * szDSN, short cbDSNMax, short pcbDSN
		, char * szDescription, short cbDescriptionMax, PSQLSMALLINT pcbDescription);
	short __stdcall SQLFetchScroll(int StatementHandle, short FetchOrientation, unsigned FetchOffset);
	short __stdcall SQLGetFunctions(int hdbc, short fFunction, PSQLUSMALLINT pfExists);
	short __stdcall SQLGetInfo(int hdbc, short fInfoType, void * rgbInfoValue, short cbInfoValueMax, PSQLSMALLINT 
		pcbInfoValue);
	short __stdcall SQLGetStmtAttr(int StatementHandle, int Attribute, void * Value, int BufferLength, 
		int StringLength);
	short __stdcall SQLGetStmtOption(int hstmt, short fOption, void * pvParam);
	short __stdcall SQLGetTypeInfo(int hstmt, short fSqlType);
	short __stdcall SQLSpecialColumns(int hstmt, short fColType, char * szCatalogName, short cbCatalogName
		, char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, short fScope, short 
		fNullable);
	short __stdcall SQLStatistics(int hstmt, char * szCatalogName, short cbCatalogName, char * szSchemaName
		, short cbSchemaName, char * szTableName, short cbTableName, short fUnique, short fAccuracy);
	short __stdcall SQLTables(int hstmt, char * szCatalogName, short cbCatalogName, char * szSchemaName
		, short cbSchemaName, char * szTableName, short cbTableName, short szTableType, short cbTableType)
		;
	short __stdcall SQLNextResult(int hstmtSource, int hstmtTarget);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZDb2PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZDb2PlainDriver;	/* Zplaindb2driver::IZDb2PlainDriver */
	
public:
	operator IZDb2PlainDriver*(void) { return (IZDb2PlainDriver*)&__IZDb2PlainDriver; }
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZDb2PlainDriver; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word SQL_MAX_MESSAGE_LENGTH = 0x400;
static const Byte SQL_MAX_ID_LENGTH = 0x80;
static const Shortint SQL_DATE_LEN = 0xa;
static const Shortint SQL_TIME_LEN = 0x8;
static const Shortint SQL_TIMESTAMP_LEN = 0x13;
static const Shortint SQL_HANDLE_ENV = 0x1;
static const Shortint SQL_HANDLE_DBC = 0x2;
static const Shortint SQL_HANDLE_STMT = 0x3;
static const Shortint SQL_HANDLE_DESC = 0x4;
static const Shortint SQL_SUCCESS = 0x0;
static const Shortint SQL_SUCCESS_WITH_INFO = 0x1;
static const Shortint SQL_NEED_DATA = 0x63;
static const Shortint SQL_NO_DATA = 0x64;
static const Shortint SQL_STILL_EXECUTING = 0x2;
static const Shortint SQL_ERROR = 0xffffffff;
static const Shortint SQL_INVALID_HANDLE = 0xfffffffe;
static const Shortint SQL_CLOSE = 0x0;
static const Shortint SQL_DROP = 0x1;
static const Shortint SQL_UNBIND = 0x2;
static const Shortint SQL_RESET_PARAMS = 0x3;
static const Shortint SQL_COMMIT = 0x0;
static const Shortint SQL_ROLLBACK = 0x1;
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
static const Shortint SQL_LONGVARCHAR = 0xffffffff;
static const Shortint SQL_WCHAR = 0xfffffff8;
static const Shortint SQL_WVARCHAR = 0xfffffff7;
static const Shortint SQL_WLONGVARCHAR = 0xfffffff6;
static const Shortint SQL_BIGINT = 0xfffffffb;
static const Shortint SQL_BINARY = 0xfffffffe;
static const Shortint SQL_TYPE_DATE = 0x5b;
static const Shortint SQL_TYPE_TIME = 0x5c;
static const Shortint SQL_TYPE_TIMESTAMP = 0x5d;
static const Shortint SQL_UNSPECIFIED = 0x0;
static const Shortint SQL_INSENSITIVE = 0x1;
static const Shortint SQL_SENSITIVE = 0x2;
static const Shortint SQL_DEFAULT = 0x63;
static const Shortint SQL_ARD_TYPE = 0xffffff9d;
static const Shortint SQL_CODE_DATE = 0x1;
static const Shortint SQL_CODE_TIME = 0x2;
static const Shortint SQL_CODE_TIMESTAMP = 0x3;
static const Shortint SQL_GRAPHIC = 0xffffffa1;
static const Shortint SQL_VARGRAPHIC = 0xffffffa0;
static const Shortint SQL_LONGVARGRAPHIC = 0xffffff9f;
static const Shortint SQL_BLOB = 0xffffff9e;
static const Shortint SQL_CLOB = 0xffffff9d;
static const short SQL_DBCLOB = 0xfffffea2;
static const short SQL_DATALINK = 0xfffffe70;
static const short SQL_USER_DEFINED_TYPE = 0xfffffe3e;
static const short SQL_C_DBCHAR = 0xfffffea2;
static const Shortint SQL_C_DECIMAL_IBM = 0x3;
static const Word SQL_C_PTR = 0x99f;
static const Word SQL_C_DECIMAL_OLEDB = 0x9d2;
static const Shortint SQL_BLOB_LOCATOR = 0x1f;
static const Shortint SQL_CLOB_LOCATOR = 0x29;
static const short SQL_DBCLOB_LOCATOR = 0xfffffea1;
static const Shortint SQL_C_BLOB_LOCATOR = 0x1f;
static const Shortint SQL_C_CLOB_LOCATOR = 0x29;
static const short SQL_C_DBCLOB_LOCATOR = 0xfffffea1;
static const Shortint SQL_NO_NULLS = 0x0;
static const Shortint SQL_NULLABLE = 0x1;
static const Shortint SQL_NULLABLE_UNKNOWN = 0x2;
static const Shortint SQL_NAMED = 0x0;
static const Shortint SQL_UNNAMED = 0x1;
static const Shortint SQL_DESC_ALLOC_AUTO = 0x1;
static const Shortint SQL_DESC_ALLOC_USER = 0x2;
static const Shortint SQL_TYPE_BASE = 0x0;
static const Shortint SQL_TYPE_DISTINCT = 0x1;
static const Shortint SQL_TYPE_STRUCTURED = 0x2;
static const Shortint SQL_TYPE_REFERENCE = 0x3;
static const Shortint SQL_NULL_DATA = 0xffffffff;
static const Shortint SQL_DATA_AT_EXEC = 0xfffffffe;
static const Shortint SQL_NTS = 0xfffffffd;
static const Shortint SQL_NTSL = 0xfffffffd;
static const Shortint SQL_COLUMN_SCHEMA_NAME = 0x10;
static const Shortint SQL_COLUMN_CATALOG_NAME = 0x11;
static const Word SQL_COLUMN_DISTINCT_TYPE = 0x4e2;
static const Word SQL_DESC_DISTINCT_TYPE = 0x4e2;
static const Word SQL_COLUMN_REFERENCE_TYPE = 0x4e3;
static const Word SQL_DESC_REFERENCE_TYPE = 0x4e3;
static const Word SQL_DESC_STRUCTURED_TYPE = 0x4e4;
static const Word SQL_DESC_USER_TYPE = 0x4e5;
static const Word SQL_DESC_BASE_TYPE = 0x4e6;
static const Word SQL_DESC_KEY_TYPE = 0x4e7;
static const Word SQL_DESC_KEY_MEMBER = 0x4f2;
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
static const Word SQL_DESC_USER_DEFINED_TYPE_CODE = 0x44a;
static const Shortint SQL_KEYTYPE_NONE = 0x0;
static const Shortint SQL_KEYTYPE_PRIMARYKEY = 0x1;
static const Shortint SQL_KEYTYPE_UNIQUEINDEX = 0x2;
static const Shortint SQL_UPDT_READONLY = 0x0;
static const Shortint SQL_UPDT_WRITE = 0x1;
static const Shortint SQL_UPDT_READWRITE_UNKNOWN = 0x2;
static const Shortint SQL_PRED_NONE = 0x0;
static const Shortint SQL_PRED_CHAR = 0x1;
static const Shortint SQL_PRED_BASIC = 0x2;
static const Shortint SQL_NULL_HENV = 0x0;
static const Shortint SQL_NULL_HDBC = 0x0;
static const Shortint SQL_NULL_HSTMT = 0x0;
static const Shortint SQL_NULL_HDESC = 0x0;
static const Shortint SQL_NULL_HANDLE = 0x0;
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
static const Shortint SQL_DIAG_ALTER_TABLE = 0x4;
static const Shortint SQL_DIAG_CALL = 0x7;
static const Shortint SQL_DIAG_CREATE_INDEX = 0xffffffff;
static const Shortint SQL_DIAG_CREATE_TABLE = 0x4d;
static const Shortint SQL_DIAG_CREATE_VIEW = 0x54;
static const Shortint SQL_DIAG_DELETE_WHERE = 0x13;
static const Shortint SQL_DIAG_DROP_INDEX = 0xfffffffe;
static const Shortint SQL_DIAG_DROP_TABLE = 0x20;
static const Shortint SQL_DIAG_DROP_VIEW = 0x24;
static const Shortint SQL_DIAG_DYNAMIC_DELETE_CURSOR = 0x26;
static const Shortint SQL_DIAG_DYNAMIC_UPDATE_CURSOR = 0x51;
static const Shortint SQL_DIAG_GRANT = 0x30;
static const Shortint SQL_DIAG_INSERT = 0x32;
static const Shortint SQL_DIAG_REVOKE = 0x3b;
static const Shortint SQL_DIAG_SELECT_CURSOR = 0x55;
static const Shortint SQL_DIAG_UNKNOWN_STATEMENT = 0x0;
static const Shortint SQL_DIAG_UPDATE_WHERE = 0x52;
static const Word SQL_DIAG_DEFERRED_PREPARE_ERROR = 0x4ff;
static const Shortint SQL_ROW_NO_ROW_NUMBER = 0xffffffff;
static const Shortint SQL_ROW_NUMBER_UNKNOWN = 0xfffffffe;
static const Shortint SQL_COLUMN_NO_COLUMN_NUMBER = 0xffffffff;
static const Shortint SQL_COLUMN_NUMBER_UNKNOWN = 0xfffffffe;
static const Word SQL_WCHARTYPE = 0x4e4;
static const Word SQL_LONGDATA_COMPAT = 0x4e5;
static const Word SQL_CURRENT_SCHEMA = 0x4e6;
static const Word SQL_DB2EXPLAIN = 0x4ea;
static const Word SQL_DB2ESTIMATE = 0x4eb;
static const Word SQL_PARAMOPT_ATOMIC = 0x4ec;
static const Word SQL_STMTTXN_ISOLATION = 0x4ed;
static const Word SQL_MAXCONN = 0x4ee;
static const Word SQL_ATTR_CLISCHEMA = 0x500;
static const Word SQL_ATTR_INFO_USERID = 0x501;
static const Word SQL_ATTR_INFO_WRKSTNNAME = 0x502;
static const Word SQL_ATTR_INFO_APPLNAME = 0x503;
static const Word SQL_ATTR_INFO_ACCTSTR = 0x504;
static const Word SQL_ATTR_AUTOCOMMIT_NOCOMMIT = 0x99e;
static const Word SQL_ATTR_QUERY_PATROLLER = 0x9a2;
static const Word SQL_ATTR_CHAINING_BEGIN = 0x9a0;
static const Word SQL_ATTR_CHAINING_END = 0x9a1;
static const Word SQL_ATTR_WCHARTYPE = 0x4e4;
static const Word SQL_ATTR_LONGDATA_COMPAT = 0x4e5;
static const Word SQL_ATTR_CURRENT_SCHEMA = 0x4e6;
static const Word SQL_ATTR_DB2EXPLAIN = 0x4ea;
static const Word SQL_ATTR_DB2ESTIMATE = 0x4eb;
static const Word SQL_ATTR_PARAMOPT_ATOMIC = 0x4ec;
static const Word SQL_ATTR_STMTTXN_ISOLATION = 0x4ed;
static const Word SQL_ATTR_MAXCONN = 0x4ee;
static const Word SQL_CONNECTTYPE = 0x4e7;
static const Word SQL_SYNC_POINT = 0x4e8;
static const Word SQL_MINMEMORY_USAGE = 0x4ef;
static const Word SQL_CONN_CONTEXT = 0x4f5;
static const Word SQL_ATTR_INHERIT_NULL_CONNECT = 0x4f6;
static const Word SQL_ATTR_FORCE_CONVERSION_ON_CLIENT = 0x4fb;
static const Word SQL_ATTR_CONNECTTYPE = 0x4e7;
static const Word SQL_ATTR_SYNC_POINT = 0x4e8;
static const Word SQL_ATTR_MINMEMORY_USAGE = 0x4ef;
static const Word SQL_ATTR_CONN_CONTEXT = 0x4f5;
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
static const Shortint SQL_AUTOCOMMIT_OFF = 0x0;
static const Shortint SQL_AUTOCOMMIT_ON = 0x1;
static const Shortint SQL_AUTOCOMMIT_DEFAULT = 0x1;
static const char SQL_TXN_READ_UNCOMMITTED = '\x1';
static const char SQL_TRANSACTION_READ_UNCOMMITTED = '\x1';
static const char SQL_TXN_READ_COMMITTED = '\x2';
static const char SQL_TRANSACTION_READ_COMMITTED = '\x2';
static const char SQL_TXN_REPEATABLE_READ = '\x4';
static const char SQL_TRANSACTION_REPEATABLE_READ = '\x4';
static const char SQL_TXN_SERIALIZABLE = '\x8';
static const char SQL_TRANSACTION_SERIALIZABLE = '\x8';
static const char SQL_TXN_NOCOMMIT = '\x14';
static const char SQL_TRANSACTION_NOCOMMIT = '\x14';
static const Shortint SQL_PARAM_TYPE_UNKNOWN = 0x0;
static const Shortint SQL_PARAM_INPUT = 0x1;
static const Shortint SQL_PARAM_INPUT_OUTPUT = 0x2;
static const Shortint SQL_RESULT_COL = 0x3;
static const Shortint SQL_PARAM_OUTPUT = 0x4;
static const Shortint SQL_RETURN_VALUE = 0x5;
static const Shortint SQL_MAX_NUMERIC_LEN = 0x10;

}	/* namespace Zplaindb2driver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaindb2driver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainDb2Driver
