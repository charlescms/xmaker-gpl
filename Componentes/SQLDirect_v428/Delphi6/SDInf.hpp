// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDInf.pas' rev: 6.00

#ifndef SDInfHPP
#define SDInfHPP

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

namespace Sdinf
{
//-- type declarations -------------------------------------------------------
typedef void *HINFX_RC;

class DELPHICLASS TInfFunctions;
class PASCALIMPLEMENTATION TInfFunctions : public Sdodbc::TOdbcFunctions 
{
	typedef Sdodbc::TOdbcFunctions inherited;
	
public:
	virtual void __fastcall SetApiCalls(unsigned ASqlLibModule);
	virtual void __fastcall ClearApiCalls(void);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TInfFunctions(void) : Sdodbc::TOdbcFunctions() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TInfFunctions(void) { }
	#pragma option pop
	
};


class DELPHICLASS ESDInfError;
class PASCALIMPLEMENTATION ESDInfError : public Sdodbc::ESDOdbcError 
{
	typedef Sdodbc::ESDOdbcError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDOdbcError.CreateWithSqlState */ inline __fastcall ESDInfError(short AErrorCode, short ANativeError, const AnsiString AMsg, const AnsiString ASqlState) : Sdodbc::ESDOdbcError(AErrorCode, ANativeError, AMsg, ASqlState) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDInfError(int AErrorCode, int ANativeError, const AnsiString Msg, int AErrorPos) : Sdodbc::ESDOdbcError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDInfError(int AErrorCode, int ANativeError, const AnsiString Msg) : Sdodbc::ESDOdbcError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDInfError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sdodbc::ESDOdbcError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDInfError(int Ident)/* overload */ : Sdodbc::ESDOdbcError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDInfError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sdodbc::ESDOdbcError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDInfError(const AnsiString Msg, int AHelpContext) : Sdodbc::ESDOdbcError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDInfError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sdodbc::ESDOdbcError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDInfError(int Ident, int AHelpContext)/* overload */ : Sdodbc::ESDOdbcError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDInfError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdodbc::ESDOdbcError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDInfError(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIInfDatabase;
class PASCALIMPLEMENTATION TIInfDatabase : public Sdodbc::TICustomOdbcDatabase 
{
	typedef Sdodbc::TICustomOdbcDatabase inherited;
	
private:
	HIDESBASE TInfFunctions* __fastcall GetCalls(void);
	
protected:
	virtual void __fastcall FreeSqlLib(void);
	virtual void __fastcall LoadSqlLib(void);
	virtual void __fastcall RaiseSDEngineError(short AErrorCode, short ANativeError, const AnsiString AMsg, const AnsiString ASqlState);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const AnsiString sPassword);
	
public:
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	__property TInfFunctions* Calls = {read=GetCalls};
public:
	#pragma option push -w-inl
	/* TICustomOdbcDatabase.Create */ inline __fastcall virtual TIInfDatabase(Classes::TStrings* ADbParams) : Sdodbc::TICustomOdbcDatabase(ADbParams) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcDatabase.Destroy */ inline __fastcall virtual ~TIInfDatabase(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIInfCommand;
class PASCALIMPLEMENTATION TIInfCommand : public Sdodbc::TICustomOdbcCommand 
{
	typedef Sdodbc::TICustomOdbcCommand inherited;
	
private:
	HIDESBASE TIInfDatabase* __fastcall GetSqlDatabase(void);
	
protected:
	__property TIInfDatabase* SqlDatabase = {read=GetSqlDatabase};
public:
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Create */ inline __fastcall virtual TIInfCommand(Sdcommon::TISqlDatabase* ASqlDatabase) : Sdodbc::TICustomOdbcCommand(ASqlDatabase) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomOdbcCommand.Destroy */ inline __fastcall virtual ~TIInfCommand(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint SQL_DIAG_ISAM_ERROR = 0xd;
static const Shortint SQL_DIAG_XA_ERROR = 0xe;
static const Word SQL_STMTOPT_START = 0x410;
static const Word SQL_GET_ROWID = 0x418;
static const Word SQL_GET_SERIAL_VALUE = 0x419;
static const Shortint FDNULLABLE = 0x1;
static const Shortint FDDISTINCT = 0x2;
static const Shortint FDDISTLVARCHAR = 0x4;
static const Shortint FDDISTBOOLEAN = 0x8;
static const Shortint FDDISTSIMP = 0x10;
static const Shortint FDCSTTYPE = 0x20;
static const Shortint FDNAMED = 0x40;
static const Shortint SQL_INFX_UDT_FIXED = 0xffffff9c;
static const Shortint SQL_INFX_UDT_VARYING = 0xffffff9b;
static const Shortint SQL_INFX_UDT_BLOB = 0xffffff9a;
static const Shortint SQL_INFX_UDT_CLOB = 0xffffff99;
static const Shortint SQL_INFX_UDT_LVARCHAR = 0xffffff98;
static const Shortint SQL_INFX_RC_ROW = 0xffffff97;
static const Shortint SQL_INFX_RC_COLLECTION = 0xffffff96;
static const Shortint SQL_INFX_RC_LIST = 0xffffff95;
static const Shortint SQL_INFX_RC_SET = 0xffffff94;
static const Shortint SQL_INFX_RC_MULTISET = 0xffffff93;
static const Shortint SQL_INFX_UNSUPPORTED = 0xffffff92;
static const Word SQL_OPT_LONGID = 0x8cb;
static const Word SQL_INFX_ATTR_LONGID = 0x8cb;
static const Word SQL_INFX_ATTR_LEAVE_TRAILING_SPACES = 0x8cc;
static const Word SQL_INFX_ATTR_DEFAULT_UDT_FETCH_TYPE = 0x8cd;
static const Word SQL_INFX_ATTR_ENABLE_SCROLL_CURSORS = 0x8ce;
static const Word SQL_ENABLE_INSERT_CURSOR = 0x8cf;
static const Word SQL_INFX_ATTR_ENABLE_INSERT_CURSORS = 0x8cf;
static const Word SQL_INFX_ATTR_OPTIMIZE_AUTOCOMMIT = 0x8d0;
static const Word SQL_INFX_ATTR_ODBC_TYPES_ONLY = 0x8d1;
static const Word SQL_INFX_ATTR_FLAGS = 0x76c;
static const Word SQL_INFX_ATTR_EXTENDED_TYPE_CODE = 0x76d;
static const Word SQL_INFX_ATTR_EXTENDED_TYPE_NAME = 0x76e;
static const Word SQL_INFX_ATTR_EXTENDED_TYPE_OWNER = 0x76f;
static const Word SQL_INFX_ATTR_EXTENDED_TYPE_ALIGNMENT = 0x770;
static const Word SQL_INFX_ATTR_SOURCE_TYPE_CODE = 0x771;
static const Word SQL_VMB_CHAR_LEN = 0x915;
static const Word SQL_INFX_ATTR_VMB_CHAR_LEN = 0x915;
static const Shortint SQL_VMB_CHAR_EXACT = 0x0;
static const Shortint SQL_VMB_CHAR_ESTIMATE = 0x1;
static const Shortint SQL_INFX_RC_NEXT = 0x1;
static const Shortint SQL_INFX_RC_PRIOR = 0x2;
static const Shortint SQL_INFX_RC_FIRST = 0x3;
static const Shortint SQL_INFX_RC_LAST = 0x4;
static const Shortint SQL_INFX_RC_ABSOLUTE = 0x5;
static const Shortint SQL_INFX_RC_RELATIVE = 0x6;
static const Shortint SQL_INFX_RC_CURRENT = 0x7;
static const Word SQL_INFX_LO_SPEC_LENGTH = 0x8ca;
static const Word SQL_INFX_LO_PTR_LENGTH = 0x8cb;
static const Word SQL_INFX_LO_STAT_LENGTH = 0x8cc;
static const Shortint LO_APPEND = 0x1;
static const Shortint LO_WRONLY = 0x2;
static const Shortint LO_RDONLY = 0x4;
static const Shortint LO_RDWR = 0x8;
static const Shortint LO_RANDOM = 0x20;
static const Shortint LO_SEQUENTIAL = 0x40;
static const Byte LO_FORWARD = 0x80;
static const Word LO_REVERSE = 0x100;
static const Word LO_BUFFER = 0x200;
static const Word LO_NOBUFFER = 0x400;
static const Shortint LO_DIRTY_READ = 0x10;
static const Word LO_NODIRTY_READ = 0x800;
static const Shortint LO_ATTR_LOG = 0x1;
static const Shortint LO_ATTR_NOLOG = 0x2;
static const Shortint LO_ATTR_DELAY_LOG = 0x4;
static const Shortint LO_ATTR_KEEP_LASTACCESS_TIME = 0x8;
static const Shortint LO_ATTR_NOKEEP_LASTACCESS_TIME = 0x10;
static const Shortint LO_ATTR_HIGH_INTEG = 0x20;
static const Shortint LO_ATTR_MODERATE_INTEG = 0x40;
static const Shortint LO_SEEK_SET = 0x0;
static const Shortint LO_SEEK_CUR = 0x1;
static const Shortint LO_SEEK_END = 0x2;
static const Word SQL_RESERVED_WORDS = 0x3f3;
static const Word SQL_PSEUDO_COLUMNS = 0x3f4;
static const Word SQL_FROM_RESERVED_WORDS = 0x3f5;
static const Word SQL_WHERE_CLAUSE_TERMINATORS = 0x3f6;
static const Word SQL_COLUMN_FIRST_CHARS = 0x3f7;
static const Word SQL_COLUMN_MIDDLE_CHARS = 0x3f8;
static const Word SQL_TABLE_FIRST_CHARS = 0x3fa;
static const Word SQL_TABLE_MIDDLE_CHARS = 0x3fb;
static const Word SQL_FAST_SPECIAL_COLUMNS = 0x3fd;
static const Word SQL_ACCESS_CONFLICTS = 0x3fe;
static const Word SQL_LOCKING_SYNTAX = 0x3ff;
static const Word SQL_LOCKING_DURATION = 0x400;
static const Word SQL_RECORD_OPERATIONS = 0x401;
static const Word SQL_QUALIFIER_SYNTAX = 0x402;
#define DefSqlApiDLL_A "ICLIT09A.DLL"
#define DefSqlApiDLL_B "ICLIT09B.DLL"
#define DefSqlApiDLL "ICLIT09B.DLL;ICLIT09A.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE TInfFunctions* InfCalls;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdinf */
using namespace Sdinf;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDInf
