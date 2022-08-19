// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainDb2.pas' rev: 5.00

#ifndef ZPlainDb2HPP
#define ZPlainDb2HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainLoader.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <ZPlainDb2Driver.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplaindb2
{
//-- type declarations -------------------------------------------------------
typedef short __stdcall (*TSQLAllocConnect)(int henv, Zplaindb2driver::PSQLHDBC phdbc);

typedef short __stdcall (*TSQLAllocEnv)(Zplaindb2driver::PSQLHENV phenv);

typedef short __stdcall (*TSQLAllocStmt)(int hdbc, Zplaindb2driver::PSQLHSTMT phstmt);

typedef short __stdcall (*TSQLAllocHandle)(short fHandleType, int hInput, Zplaindb2driver::PSQLHANDLE 
	phOutput);

typedef short __stdcall (*TSQLBindCol)(int hstmt, short icol, short fCType, void * rgbValue, int cbValueMax
	, Zplaindb2driver::PSQLINTEGER pcbValue);

typedef short __stdcall (*TSQLCancel)(int hstmt);

typedef short __stdcall (*TSQLColAttribute)(int hstmt, short icol, short fDescType, void * rgbDesc, 
	short cbDescMax, Zplaindb2driver::PSQLSMALLINT pcbDesc, void * pfDesc);

typedef short __stdcall (*TSQLConnect)(int hdbc, char * szDSN, short cbDSN, char * szUID, short cbUID
	, char * szAuthStr, short cbAuthStr);

typedef short __stdcall (*TSQLDescribeCol)(int hstmt, short icol, char * szColName, short cbColNameMax
	, Zplaindb2driver::PSQLSMALLINT pcbColName, Zplaindb2driver::PSQLSMALLINT pfSqlType, Zplaindb2driver::PSQLUINTEGER 
	pcbColDef, Zplaindb2driver::PSQLSMALLINT pibScale, Zplaindb2driver::PSQLSMALLINT pfNullable);

typedef short __stdcall (*TSQLDisconnect)(int hdbc);

typedef short __stdcall (*TSQLError)(int henv, int hdbc, int hstmt, char * szSqlState, Zplaindb2driver::PSQLINTEGER 
	pfNativeError, char * szErrorMsg, short cbErrorMsgMax, Zplaindb2driver::PSQLSMALLINT pcbErrorMsg);

typedef short __stdcall (*TSQLExecDirect)(int hstmt, char * szSqlStr, int cbSqlStr);

typedef short __stdcall (*TSQLExecute)(int hstmt);

typedef short __stdcall (*TSQLFetch)(int hstmt);

typedef short __stdcall (*TSQLFreeConnect)(int hdbc);

typedef short __stdcall (*TSQLFreeEnv)(int henv);

typedef short __stdcall (*TSQLFreeStmt)(int hstmt, short fOption);

typedef short __stdcall (*TSQLCloseCursor)(int hStmt);

typedef short __stdcall (*TSQLGetCursorName)(int hstmt, char * szCursor, short cbCursorMax, Zplaindb2driver::PSQLSMALLINT 
	pcbCursor);

typedef short __stdcall (*TSQLGetData)(int hstmt, short icol, short fCType, void * rgbValue, int cbValueMax
	, Zplaindb2driver::PSQLINTEGER pcbValue);

typedef short __stdcall (*TSQLNumResultCols)(int hstmt, Zplaindb2driver::PSQLSMALLINT pccol);

typedef short __stdcall (*TSQLPrepare)(int hstmt, char * szSqlStr, int cbSqlStr);

typedef short __stdcall (*TSQLRowCount)(int hstmt, Zplaindb2driver::PSQLINTEGER pcrow);

typedef short __stdcall (*TSQLSetCursorName)(int hstmt, char * szCursor, short cbCursor);

typedef short __stdcall (*TSQLSetParam)(int hstmt, short ipar, short fCType, short fSqlType, unsigned 
	cbParamDef, short ibScale, void * rgbValue, Zplaindb2driver::PSQLINTEGER pcbValue);

typedef short __stdcall (*TSQLTransact)(int henv, int hdbc, short fType);

typedef short __stdcall (*TSQLEndTran)(short fHandleType, int hHandle, short fType);

typedef short __stdcall (*TSQLFreeHandle)(short fHandleType, int hHandle);

typedef short __stdcall (*TSQLGetDiagRec)(short fHandleType, int hHandle, short iRecNumber, char * pszSqlState
	, Zplaindb2driver::PSQLINTEGER pfNativeError, char * pszErrorMsg, short cbErrorMsgMax, Zplaindb2driver::PSQLSMALLINT 
	pcbErrorMsg);

typedef short __stdcall (*TSQLGetDiagField)(short fHandleType, int hHandle, short iRecNumber, short 
	fDiagIdentifier, void * pDiagInfo, short cbDiagInfoMax, Zplaindb2driver::PSQLSMALLINT pcbDiagInfo);
	

typedef short __stdcall (*TSQLCopyDesc)(int hDescSource, int hDescTarget);

typedef short __stdcall (*TSQLGetDescField)(int DescriptorHandle, short RecNumber, short FieldIdentifier
	, void * Value, int BufferLength, Zplaindb2driver::PSQLINTEGER StringLength);

typedef short __stdcall (*TSQLGetDescRec)(int DescriptorHandle, short RecNumber, char * Name, short 
	BufferLength, Zplaindb2driver::PSQLSMALLINT StringLength, Zplaindb2driver::PSQLSMALLINT _Type, Zplaindb2driver::PSQLSMALLINT 
	SubType, Zplaindb2driver::PSQLINTEGER Length, Zplaindb2driver::PSQLSMALLINT Precision, Zplaindb2driver::PSQLSMALLINT 
	Scale, Zplaindb2driver::PSQLSMALLINT Nullable);

typedef short __stdcall (*TSQLSetDescField)(int DescriptorHandle, short RecNumber, short FieldIdentifier
	, void * Value, int BufferLength);

typedef short __stdcall (*TSQLSetDescRec)(int DescriptorHandle, short RecNumber, short _Type, short 
	SubType, int Length, short Precision, short Scale, void * Data, Zplaindb2driver::PSQLINTEGER StringLength
	, Zplaindb2driver::PSQLINTEGER Indicator);

typedef short __stdcall (*TSQLSetConnectAttr)(int hdbc, int fOption, void * pvParam, int fStrLen);

typedef short __stdcall (*TSQLSetConnectOption)(int hdbc, short fOption, unsigned vParam);

typedef short __stdcall (*TSQLSetStmtAttr)(int hstmt, int fOption, void * pvParam, int fStrLen);

typedef short __stdcall (*TSQLSetStmtOption)(int hstmt, short fOption, unsigned vParam);

typedef short __stdcall (*TSQLGetSubString)(int hstmt, short LocatorCType, int SourceLocator, unsigned 
	FromPosition, unsigned ForLength, short TargetCType, void * rgbValue, int cbValueMax, Zplaindb2driver::PSQLINTEGER 
	StringLength, Zplaindb2driver::PSQLINTEGER IndicatorValue);

typedef short __stdcall (*TSQLGetLength)(int hstmt, short LocatorCType, int Locator, Zplaindb2driver::PSQLINTEGER 
	StringLength, Zplaindb2driver::PSQLINTEGER IndicatorValue);

typedef short __stdcall (*TSQLGetPosition)(int hstmt, short LocatorCType, int SourceLocator, int SearchLocator
	, char * SearchLiteral, int SearchLiteralLength, unsigned FromPosition, Zplaindb2driver::PSQLUINTEGER 
	LocatedAt, Zplaindb2driver::PSQLINTEGER IndicatorValue);

typedef short __stdcall (*TSQLBindParameter)(int hstmt, short ipar, short fParamType, short fCType, 
	short fSqlType, unsigned cbColDef, short ibScale, void * rgbValue, int cbValueMax, Zplaindb2driver::PSQLINTEGER 
	pcbValue);

typedef short __stdcall (*TSQLParamData)(int hstmt, void * prgbValue);

typedef short __stdcall (*TSQLPutData)(int hstmt, void * rgbValue, int cbValue);

typedef short __stdcall (*TSQLColumns)(int hstmt, char * szCatalogName, short cbCatalogName, char * 
	szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, char * szColumnName, short 
	cbColumnName);

typedef short __stdcall (*TSQLDataSources)(int henv, short fDirection, char * szDSN, short cbDSNMax, 
	short pcbDSN, char * szDescription, short cbDescriptionMax, Zplaindb2driver::PSQLSMALLINT pcbDescription
	);

typedef short __stdcall (*TSQLFetchScroll)(int StatementHandle, short FetchOrientation, unsigned FetchOffset
	);

typedef short __stdcall (*TSQLGetFunctions)(int hdbc, short fFunction, Zplaindb2driver::PSQLUSMALLINT 
	pfExists);

typedef short __stdcall (*TSQLGetInfo)(int hdbc, short fInfoType, void * rgbInfoValue, short cbInfoValueMax
	, Zplaindb2driver::PSQLSMALLINT pcbInfoValue);

typedef short __stdcall (*TSQLGetStmtAttr)(int StatementHandle, int Attribute, void * Value, int BufferLength
	, int StringLength);

typedef short __stdcall (*TSQLGetStmtOption)(int hstmt, short fOption, void * pvParam);

typedef short __stdcall (*TSQLGetTypeInfo)(int hstmt, short fSqlType);

typedef short __stdcall (*TSQLSpecialColumns)(int hstmt, short fColType, char * szCatalogName, short 
	cbCatalogName, char * szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, short 
	fScope, short fNullable);

typedef short __stdcall (*TSQLStatistics)(int hstmt, char * szCatalogName, short cbCatalogName, char * 
	szSchemaName, short cbSchemaName, char * szTableName, short cbTableName, short fUnique, short fAccuracy
	);

typedef short __stdcall (*TSQLTables)(int hstmt, char * szCatalogName, short cbCatalogName, char * szSchemaName
	, short cbSchemaName, char * szTableName, short cbTableName, short szTableType, short cbTableType);
	

typedef short __stdcall (*TSQLNextResult)(int hstmtSource, int hstmtTarget);

//-- var, const, procedure ---------------------------------------------------
#define WINDOWS_DLL_LOCATION "db2cli.dll"
#define LINUX_DLL_LOCATION "db2cli.so"
extern PACKAGE TSQLAllocConnect SQLAllocConnect;
extern PACKAGE TSQLAllocEnv SQLAllocEnv;
extern PACKAGE TSQLAllocStmt SQLAllocStmt;
extern PACKAGE TSQLAllocHandle SQLAllocHandle;
extern PACKAGE TSQLBindCol SQLBindCol;
extern PACKAGE TSQLCancel SQLCancel;
extern PACKAGE TSQLColAttribute SQLColAttribute;
extern PACKAGE TSQLConnect SQLConnect;
extern PACKAGE TSQLDescribeCol SQLDescribeCol;
extern PACKAGE TSQLDisconnect SQLDisconnect;
extern PACKAGE TSQLError SQLError;
extern PACKAGE TSQLExecDirect SQLExecDirect;
extern PACKAGE TSQLExecute SQLExecute;
extern PACKAGE TSQLFetch SQLFetch;
extern PACKAGE TSQLFreeConnect SQLFreeConnect;
extern PACKAGE TSQLFreeEnv SQLFreeEnv;
extern PACKAGE TSQLFreeStmt SQLFreeStmt;
extern PACKAGE TSQLCloseCursor SQLCloseCursor;
extern PACKAGE TSQLGetCursorName SQLGetCursorName;
extern PACKAGE TSQLGetData SQLGetData;
extern PACKAGE TSQLNumResultCols SQLNumResultCols;
extern PACKAGE TSQLPrepare SQLPrepare;
extern PACKAGE TSQLRowCount SQLRowCount;
extern PACKAGE TSQLSetCursorName SQLSetCursorName;
extern PACKAGE TSQLSetParam SQLSetParam;
extern PACKAGE TSQLTransact SQLTransact;
extern PACKAGE TSQLEndTran SQLEndTran;
extern PACKAGE TSQLFreeHandle SQLFreeHandle;
extern PACKAGE TSQLGetDiagRec SQLGetDiagRec;
extern PACKAGE TSQLGetDiagField SQLGetDiagField;
extern PACKAGE TSQLCopyDesc SQLCopyDesc;
extern PACKAGE TSQLGetDescField SQLGetDescField;
extern PACKAGE TSQLGetDescRec SQLGetDescRec;
extern PACKAGE TSQLSetDescField SQLSetDescField;
extern PACKAGE TSQLSetDescRec SQLSetDescRec;
extern PACKAGE TSQLSetConnectAttr SQLSetConnectAttr;
extern PACKAGE TSQLSetConnectOption SQLSetConnectOption;
extern PACKAGE TSQLSetStmtAttr SQLSetStmtAttr;
extern PACKAGE TSQLSetStmtOption SQLSetStmtOption;
extern PACKAGE TSQLGetSubString SQLGetSubString;
extern PACKAGE TSQLGetLength SQLGetLength;
extern PACKAGE TSQLGetPosition SQLGetPosition;
extern PACKAGE TSQLBindParameter SQLBindParameter;
extern PACKAGE TSQLParamData SQLParamData;
extern PACKAGE TSQLPutData SQLPutData;
extern PACKAGE TSQLColumns SQLColumns;
extern PACKAGE TSQLDataSources SQLDataSources;
extern PACKAGE TSQLFetchScroll SQLFetchScroll;
extern PACKAGE TSQLGetFunctions SQLGetFunctions;
extern PACKAGE TSQLGetInfo SQLGetInfo;
extern PACKAGE TSQLGetStmtAttr SQLGetStmtAttr;
extern PACKAGE TSQLGetStmtOption SQLGetStmtOption;
extern PACKAGE TSQLGetTypeInfo SQLGetTypeInfo;
extern PACKAGE TSQLSpecialColumns SQLSpecialColumns;
extern PACKAGE TSQLStatistics SQLStatistics;
extern PACKAGE TSQLTables SQLTables;
extern PACKAGE TSQLNextResult SQLNextResult;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;

}	/* namespace Zplaindb2 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaindb2;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainDb2
