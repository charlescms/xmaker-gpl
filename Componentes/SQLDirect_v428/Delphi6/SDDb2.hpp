// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDDb2.pas' rev: 6.00

#ifndef SDDb2HPP
#define SDDb2HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDOdbc.hpp>	// Pascal unit
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sddb2
{
//-- type declarations -------------------------------------------------------
#pragma pack(push, 1)
struct TSQL_NUMERIC_STRUCT
{
	Byte precision;
	char scale;
	Byte sign;
	Byte val[16];
} ;
#pragma pack(pop)

class DELPHICLASS ESDDb2Error;
class PASCALIMPLEMENTATION ESDDb2Error : public Sdodbc::ESDOdbcError 
{
	typedef Sdodbc::ESDOdbcError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDOdbcError.CreateWithSqlState */ inline __fastcall ESDDb2Error(short AErrorCode, short ANativeError, const AnsiString AMsg, const AnsiString ASqlState) : Sdodbc::ESDOdbcError(AErrorCode, ANativeError, AMsg, ASqlState) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDDb2Error(int AErrorCode, int ANativeError, const AnsiString Msg, int AErrorPos) : Sdodbc::ESDOdbcError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDDb2Error(int AErrorCode, int ANativeError, const AnsiString Msg) : Sdodbc::ESDOdbcError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDDb2Error(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sdodbc::ESDOdbcError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDDb2Error(int Ident)/* overload */ : Sdodbc::ESDOdbcError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDDb2Error(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sdodbc::ESDOdbcError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDDb2Error(const AnsiString Msg, int AHelpContext) : Sdodbc::ESDOdbcError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDDb2Error(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sdodbc::ESDOdbcError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDDb2Error(int Ident, int AHelpContext)/* overload */ : Sdodbc::ESDOdbcError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDDb2Error(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdodbc::ESDOdbcError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDDb2Error(void) { }
	#pragma option pop
	
};


typedef short __stdcall (*TSQLBindFileToCol)(void * hStmt, Word icol, char * FileName, short &FileNameLength, unsigned &FileOptions, short MaxFileNameLength, int &StringLength, int &IndicatorValue);

typedef short __stdcall (*TSQLBindFileToParam)(void * hStmt, Word ipar, short fSqlType, char * FileName, short &FileNameLength, unsigned &FileOptions, short MaxFileNameLength, int &IndicatorValue);

typedef short __stdcall (*TSQLGetLength)(void * hStmt, short LocatorCType, int Locator, int &StringLength, int &IndicatorValue);

typedef short __stdcall (*TSQLGetPosition)(void * hStmt, short LocatorCType, int SourceLocator, int SearchLocator, char * SearchLiteral, int SearchLiteralLength, unsigned FromPosition, unsigned &LocatedAt, int &IndicatorValue);

typedef short __stdcall (*TSQLGetSubString)(void * hStmt, short LocatorCType, int SourceLocator, unsigned FromPosition, unsigned ForLength, short TargetCType, void * rgbValue, int cbValueMax, int &StringLength, int &IndicatorValue);

typedef short __stdcall (*TSQLSetColAttributes)(void * hStmt, Word icol, char * szColName, short cbColName, short fSQLType, unsigned cbColDef, short ibScale, short fNullable);

typedef short __stdcall (*TSQLBindParam)(void * hStmt, Word ParameterNumber, short ValueType, short ParameterType, unsigned LengthPrecision, short ParameterScale, void * ParameterValue, int &StrLen_or_Ind);

class DELPHICLASS TDB2Functions;
class PASCALIMPLEMENTATION TDB2Functions : public Sdodbc::TOdbcFunctions 
{
	typedef Sdodbc::TOdbcFunctions inherited;
	
private:
	TSQLBindFileToCol FSQLBindFileToCol;
	TSQLBindFileToParam FSQLBindFileToParam;
	TSQLGetLength FSQLGetLength;
	TSQLGetPosition FSQLGetPosition;
	TSQLGetSubString FSQLGetSubString;
	TSQLSetColAttributes FSQLSetColAttributes;
	TSQLBindParam FSQLBindParam;
	
public:
	virtual void __fastcall SetApiCalls(unsigned ASqlLibModule);
	virtual void __fastcall ClearApiCalls(void);
	__property TSQLBindFileToCol SQLBindFileToCol = {read=FSQLBindFileToCol};
	__property TSQLBindFileToParam SQLBindFileToParam = {read=FSQLBindFileToParam};
	__property TSQLGetLength SQLGetLength = {read=FSQLGetLength};
	__property TSQLGetPosition SQLGetPosition = {read=FSQLGetPosition};
	__property TSQLGetSubString SQLGetSubString = {read=FSQLGetSubString};
	__property TSQLSetColAttributes SQLSetColAttributes = {read=FSQLSetColAttributes};
	__property TSQLBindParam SQLBindParam = {read=FSQLBindParam};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TDB2Functions(void) : Sdodbc::TOdbcFunctions() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDB2Functions(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIDB2Database;
class PASCALIMPLEMENTATION TIDB2Database : public Sdodbc::TICustomOdbcDatabase 
{
	typedef Sdodbc::TICustomOdbcDatabase inherited;
	
private:
	HIDESBASE TDB2Functions* __fastcall GetCalls(void);
	
protected:
	virtual void __fastcall FreeSqlLib(void);
	virtual void __fastcall LoadSqlLib(void);
	virtual void __fastcall RaiseSDEngineError(short AErrorCode, short ANativeError, const AnsiString AMsg, const AnsiString ASqlState);
	
public:
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual AnsiString __fastcall GetAutoIncSQL();
	__property TDB2Functions* Calls = {read=GetCalls};
public:
	#pragma option push -w-inl
	/* TICustomOdbcDatabase.Create */ inline __fastcall virtual TIDB2Database(Classes::TStrings* ADbParams) : Sdodbc::TICustomOdbcDatabase(ADbParams) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcDatabase.Destroy */ inline __fastcall virtual ~TIDB2Database(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIDB2Command;
class PASCALIMPLEMENTATION TIDB2Command : public Sdodbc::TICustomOdbcCommand 
{
	typedef Sdodbc::TICustomOdbcCommand inherited;
	
private:
	HIDESBASE TIDB2Database* __fastcall GetSqlDatabase(void);
	
protected:
	virtual void __fastcall Connect(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual int __fastcall SqlDataType(Db::TFieldType FieldType);
	__property TIDB2Database* SqlDatabase = {read=GetSqlDatabase};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Create */ inline __fastcall virtual TIDB2Command(Sdcommon::TISqlDatabase* ASqlDatabase) : Sdodbc::TICustomOdbcCommand(ASqlDatabase) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIDB2Command(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word SQL_MAX_MESSAGE_LENGTH = 0x400;
static const Shortint SQL_MAX_ID_LENGTH = 0x12;
static const Shortint SQL_GRAPHIC = 0xffffffa1;
static const Shortint SQL_VARGRAPHIC = 0xffffffa0;
static const Shortint SQL_LONGVARGRAPHIC = 0xffffff9f;
static const Shortint SQL_BLOB = 0xffffff9e;
static const Shortint SQL_CLOB = 0xffffff9d;
static const short SQL_DBCLOB = 0xfffffea2;
static const short SQL_C_DBCHAR = 0xfffffea2;
static const Shortint SQL_C_DECIMAL_IBM = 0x3;
static const Shortint SQL_BLOB_LOCATOR = 0x1f;
static const Shortint SQL_CLOB_LOCATOR = 0x29;
static const short SQL_DBCLOB_LOCATOR = 0xfffffea1;
static const Shortint SQL_C_BLOB_LOCATOR = 0x1f;
static const Shortint SQL_C_CLOB_LOCATOR = 0x29;
static const short SQL_C_DBCLOB_LOCATOR = 0xfffffea1;
static const Shortint SQL_COLUMN_SCHEMA_NAME = 0x10;
static const Shortint SQL_COLUMN_CATALOG_NAME = 0x11;
static const Word SQL_COLUMN_DISTINCT_TYPE = 0x4e2;
static const Word SQL_DESC_DISTINCT_TYPE = 0x4e2;
static const Shortint SQL_UPDT_READONLY = 0x0;
static const Shortint SQL_UPDT_WRITE = 0x1;
static const Shortint SQL_UPDT_READWRITE_UNKNOWN = 0x2;
static const Shortint SQL_ROW_NO_ROW_NUMBER = 0xffffffff;
static const Shortint SQL_ROW_NUMBER_UNKNOWN = 0xfffffffe;
static const Shortint SQL_COLUMN_NO_COLUMN_NUMBER = 0xffffffff;
static const Shortint SQL_COLUMN_NUMBER_UNKNOWN = 0xfffffffe;
static const Shortint SQL_MAX_NUMERIC_LEN = 0x10;
static const Word SQL_API_SQLBINDFILETOCOL = 0x4e2;
static const Word SQL_API_SQLBINDFILETOPARAM = 0x4e3;
static const Word SQL_API_SQLSETCOLATTRIBUTES = 0x4e4;
static const Word SQL_API_SQLGETSQLCA = 0x4e5;
static const Word SQL_API_SQLGETLENGTH = 0x3fe;
static const Word SQL_API_SQLGETPOSITION = 0x3ff;
static const Word SQL_API_SQLGETSUBSTRING = 0x400;
static const Word SQL_API_SQLSETCONNECTION = 0x4e6;
static const Shortint SQL_FD_FETCH_RESUME = 0x40;
static const Shortint SQL_TXN_NOCOMMIT = 0x20;
static const Shortint SQL_TRANSACTION_NOCOMMIT = 0x20;
static const Word SQL_CURSOR_HOLD = 0x4e2;
static const Word SQL_ATTR_CURSOR_HOLD = 0x4e2;
static const Word SQL_NODESCRIBE_OUTPUT = 0x4e3;
static const Word SQL_ATTR_NODESCRIBE_OUTPUT = 0x4e3;
static const Word SQL_NODESCRIBE_INPUT = 0x4f0;
static const Word SQL_ATTR_NODESCRIBE_INPUT = 0x4f0;
static const Word SQL_NODESCRIBE = 0x4e3;
static const Word SQL_ATTR_NODESCRIBE = 0x4e3;
static const Word SQL_CLOSE_BEHAVIOR = 0x4e9;
static const Word SQL_ATTR_CLOSE_BEHAVIOR = 0x4e9;
static const Word SQL_ATTR_CLOSEOPEN = 0x4f1;
static const Word SQL_ATTR_CURRENT_PACKAGE_SET = 0x4fc;
static const Word SQL_ATTR_DEFERRED_PREPARE = 0x4fd;
static const Word SQL_ATTR_EARLYCLOSE = 0x4f4;
static const Word SQL_ATTR_PROCESSCTL = 0x4fe;
static const Shortint SQL_CC_NO_RELEASE = 0x0;
static const Shortint SQL_CC_RELEASE = 0x1;
static const Shortint SQL_CC_DEFAULT = 0x0;
static const Shortint SQL_DEFERRED_PREPARE_ON = 0x1;
static const Shortint SQL_DEFERRED_PREPARE_OFF = 0x0;
static const Shortint SQL_DEFERRED_PREPARE_DEFAULT = 0x1;
static const Shortint SQL_EARLYCLOSE_ON = 0x1;
static const Shortint SQL_EARLYCLOSE_OFF = 0x0;
static const Shortint SQL_EARLYCLOSE_DEFAULT = 0x1;
static const Shortint SQL_PROCESSCTL_NOTHREAD = 0x1;
static const Shortint SQL_PROCESSCTL_NOFORK = 0x2;
static const Shortint SQL_CURSOR_HOLD_ON = 0x1;
static const Shortint SQL_CURSOR_HOLD_OFF = 0x0;
static const Shortint SQL_CURSOR_HOLD_DEFAULT = 0x1;
static const Shortint SQL_NODESCRIBE_ON = 0x1;
static const Shortint SQL_NODESCRIBE_OFF = 0x0;
static const Shortint SQL_NODESCRIBE_DEFAULT = 0x0;
static const Word SQL_WCHARTYPE = 0x4e4;
static const Word SQL_LONGDATA_COMPAT = 0x4e5;
static const Word SQL_CURRENT_SCHEMA = 0x4e6;
static const Word SQL_DB2EXPLAIN = 0x4ea;
static const Word SQL_DB2ESTIMATE = 0x4eb;
static const Word SQL_PARAMOPT_ATOMIC = 0x4ec;
static const Word SQL_STMTTXN_ISOLATION = 0x4ed;
static const Word SQL_MAXCONN = 0x4ee;
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
static const Shortint SQL_LD_COMPAT_YES = 0x1;
static const Shortint SQL_LD_COMPAT_NO = 0x0;
static const Shortint SQL_LD_COMPAT_DEFAULT = 0x0;
static const Shortint SQL_ATOMIC_YES = 0x1;
static const Shortint SQL_ATOMIC_NO = 0x0;
static const Shortint SQL_ATOMIC_DEFAULT = 0x1;
static const Shortint SQL_CONCURRENT_TRANS = 0x1;
static const Shortint SQL_COORDINATED_TRANS = 0x2;
static const Shortint SQL_CONNECTTYPE_DEFAULT = 0x1;
static const Shortint SQL_ONEPHASE = 0x1;
static const Shortint SQL_TWOPHASE = 0x2;
static const Shortint SQL_SYNCPOINT_DEFAULT = 0x1;
static const Shortint SQL_DB2ESTIMATE_ON = 0x1;
static const Shortint SQL_DB2ESTIMATE_OFF = 0x0;
static const Shortint SQL_DB2ESTIMATE_DEFAULT = 0x0;
static const Shortint SQL_DB2EXPLAIN_OFF = 0x0;
static const Shortint SQL_DB2EXPLAIN_SNAPSHOT_ON = 0x1;
static const Shortint SQL_DB2EXPLAIN_MODE_ON = 0x2;
static const Shortint SQL_DB2EXPLAIN_SNAPSHOT_MODE_ON = 0x3;
static const Shortint SQL_DB2EXPLAIN_ON = 0x1;
static const Shortint SQL_DB2EXPLAIN_DEFAULT = 0x0;
static const Shortint SQL_FILE_READ = 0x2;
static const Shortint SQL_FILE_CREATE = 0x8;
static const Shortint SQL_FILE_OVERWRITE = 0x10;
static const Shortint SQL_FILE_APPEND = 0x20;
static const Shortint SQL_FROM_LOCATOR = 0x2;
static const Shortint SQL_FROM_LITERAL = 0x3;
#define DefSqlApiDLL "DB2CLI.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE TDB2Functions* DB2Calls;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sddb2 */
using namespace Sddb2;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDDb2
