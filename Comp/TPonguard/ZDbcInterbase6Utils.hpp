// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcInterbase6Utils.pas' rev: 5.00

#ifndef ZDbcInterbase6UtilsHPP
#define ZDbcInterbase6UtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZVariant.hpp>	// Pascal unit
#include <ZMessages.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZPlainInterbaseDriver.hpp>	// Pascal unit
#include <ZDbcConnection.hpp>	// Pascal unit
#include <ZDbcStatement.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcinterbase6utils
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZIbSqlStatementType { stUnknown, stSelect, stInsert, stUpdate, stDelete, stDDL, stGetSegment, 
	stPutSegment, stExecProc, stStartTrans, stCommit, stRollback, stSelectForUpdate, stSetGenerator };
#pragma option pop

class DELPHICLASS EZIBConvertError;
class PASCALIMPLEMENTATION EZIBConvertError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EZIBConvertError(const AnsiString Msg) : Sysutils::Exception(
		Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EZIBConvertError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EZIBConvertError(int Ident)/* overload */ : Sysutils::Exception(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EZIBConvertError(int Ident, const System::TVarRec * 
		Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EZIBConvertError(const AnsiString Msg, int AHelpContext
		) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EZIBConvertError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EZIBConvertError(int Ident, int AHelpContext)/* overload */
		 : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EZIBConvertError(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EZIBConvertError(void) { }
	#pragma option pop
	
};


struct TZIbParam
{
	AnsiString Name;
	Word Number;
} ;

typedef TZIbParam *PZIbParam;

struct TIbBlobInfo
{
	short NumSegments;
	short MaxSegmentSize;
	short BlobType;
	int TotalSize;
} ;

__interface IZSQLDA;
typedef System::DelphiInterface<IZSQLDA> _di_IZSQLDA;
__interface INTERFACE_UUID("{2D0D6029-B31C-4E39-89DC-D86D20437C35}") IZSQLDA  : public IUnknown 
{
	
public:
	virtual void __fastcall InitFields(bool Parameters) = 0 ;
	virtual void __fastcall AllocateSQLDA(void) = 0 ;
	virtual void __fastcall FreeParamtersValues(void) = 0 ;
	virtual Zplaininterbasedriver::PXSQLDA __fastcall GetData(void) = 0 ;
	virtual bool __fastcall IsBlob(const Word Index) = 0 ;
	virtual bool __fastcall IsNullable(const Word Index) = 0 ;
	virtual int __fastcall GetFieldCount(void) = 0 ;
	virtual AnsiString __fastcall GetFieldSqlName(const Word Index) = 0 ;
	virtual AnsiString __fastcall GetFieldRelationName(const Word Index) = 0 ;
	virtual AnsiString __fastcall GetFieldOwnerName(const Word Index) = 0 ;
	virtual AnsiString __fastcall GetFieldAliasName(const Word Index) = 0 ;
	virtual Word __fastcall GetFieldIndex(const AnsiString Name) = 0 ;
	virtual int __fastcall GetFieldScale(const Word Index) = 0 ;
	virtual Zdbcintfs::TZSQLType __fastcall GetFieldSqlType(const Word Index) = 0 ;
	virtual short __fastcall GetFieldLength(const Word Index) = 0 ;
	virtual short __fastcall GetIbSqlType(const Word Index) = 0 ;
	virtual short __fastcall GetIbSqlSubType(const Word Index) = 0 ;
	virtual short __fastcall GetIbSqlLen(const Word Index) = 0 ;
};

__interface IZParamsSQLDA;
typedef System::DelphiInterface<IZParamsSQLDA> _di_IZParamsSQLDA;
__interface INTERFACE_UUID("{D2C3D5E1-F3A6-4223-9A6E-3048B99A06C4}") IZParamsSQLDA  : public IZSQLDA 
	
{
	
public:
	virtual void __fastcall WriteBlob(const int Index, Classes::TStream* Stream) = 0 ;
	virtual void __fastcall UpdateNull(const int Index, bool Value) = 0 ;
	virtual void __fastcall UpdateBoolean(const int Index, bool Value) = 0 ;
	virtual void __fastcall UpdateByte(const int Index, Shortint Value) = 0 ;
	virtual void __fastcall UpdateShort(const int Index, short Value) = 0 ;
	virtual void __fastcall UpdateInt(const int Index, int Value) = 0 ;
	virtual void __fastcall UpdateLong(const int Index, __int64 Value) = 0 ;
	virtual void __fastcall UpdateFloat(const int Index, float Value) = 0 ;
	virtual void __fastcall UpdateDouble(const int Index, double Value) = 0 ;
	virtual void __fastcall UpdateBigDecimal(const int Index, Extended Value) = 0 ;
	virtual void __fastcall UpdatePChar(const int Index, char * Value) = 0 ;
	virtual void __fastcall UpdateString(const int Index, AnsiString Value) = 0 ;
	virtual void __fastcall UpdateBytes(const int Index, Zcompatibility::TByteDynArray Value) = 0 ;
	virtual void __fastcall UpdateDate(const int Index, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateTime(const int Index, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateTimestamp(const int Index, System::TDateTime Value) = 0 ;
	virtual void __fastcall UpdateQuad(const Word Index, const Zplaininterbasedriver::TGDS_QUAD &Value)
		 = 0 ;
};

__interface IZResultSQLDA;
typedef System::DelphiInterface<IZResultSQLDA> _di_IZResultSQLDA;
__interface INTERFACE_UUID("{D2C3D5E1-F3A6-4223-9A6E-3048B99A06C4}") IZResultSQLDA  : public IZSQLDA 
	
{
	
public:
	virtual void __fastcall ReadBlobFromStream(const Word Index, Classes::TStream* Stream) = 0 ;
	virtual void __fastcall ReadBlobFromString(const Word Index, AnsiString &str) = 0 ;
	virtual void __fastcall ReadBlobFromVariant(const Word Index, Variant &Value) = 0 ;
	virtual bool __fastcall IsNull(const int Index) = 0 ;
	virtual char * __fastcall GetPChar(const int Index) = 0 ;
	virtual AnsiString __fastcall GetString(const int Index) = 0 ;
	virtual bool __fastcall GetBoolean(const int Index) = 0 ;
	virtual Shortint __fastcall GetByte(const int Index) = 0 ;
	virtual short __fastcall GetShort(const int Index) = 0 ;
	virtual int __fastcall GetInt(const int Index) = 0 ;
	virtual __int64 __fastcall GetLong(const int Index) = 0 ;
	virtual float __fastcall GetFloat(const int Index) = 0 ;
	virtual double __fastcall GetDouble(const int Index) = 0 ;
	virtual Extended __fastcall GetBigDecimal(const int Index) = 0 ;
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(const int Index) = 0 ;
	virtual System::TDateTime __fastcall GetDate(const int Index) = 0 ;
	virtual System::TDateTime __fastcall GetTime(const int Index) = 0 ;
	virtual System::TDateTime __fastcall GetTimestamp(const int Index) = 0 ;
	virtual Variant __fastcall GetValue(const Word Index) = 0 ;
	virtual Zplaininterbasedriver::TGDS_QUAD __fastcall GetQuad(const int Index) = 0 ;
};

class DELPHICLASS TZSQLDA;
class PASCALIMPLEMENTATION TZSQLDA : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Zplaininterbasedriver::TXSQLDA *FXSQLDA;
	Zplaininterbasedriver::_di_IZInterbasePlainDriver FPlainDriver;
	void __fastcall CheckRange(const Word Index);
	void __fastcall IbReAlloc(void *P, int OldSize, int NewSize);
	
public:
	void __fastcall InitFields(bool Parameters);
	virtual void __fastcall AllocateSQLDA(void);
	void __fastcall FreeParamtersValues(void);
	bool __fastcall IsBlob(const Word Index);
	bool __fastcall IsNullable(const Word Index);
	int __fastcall GetFieldCount(void);
	AnsiString __fastcall GetFieldSqlName(const Word Index);
	AnsiString __fastcall GetFieldOwnerName(const Word Index);
	AnsiString __fastcall GetFieldRelationName(const Word Index);
	AnsiString __fastcall GetFieldAliasName(const Word Index);
	Word __fastcall GetFieldIndex(const AnsiString Name);
	int __fastcall GetFieldScale(const Word Index);
	Zdbcintfs::TZSQLType __fastcall GetFieldSqlType(const Word Index);
	short __fastcall GetFieldLength(const Word Index);
	Zplaininterbasedriver::PXSQLDA __fastcall GetData(void);
	short __fastcall GetIbSqlType(const Word Index);
	short __fastcall GetIbSqlSubType(const Word Index);
	short __fastcall GetIbSqlLen(const Word Index);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZSQLDA(void) : System::TInterfacedObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZSQLDA(void) { }
	#pragma option pop
	
private:
	void *__IZSQLDA;	/* Zdbcinterbase6utils::IZSQLDA */
	
public:
	operator IZSQLDA*(void) { return (IZSQLDA*)&__IZSQLDA; }
	
};


class DELPHICLASS TZParamsSQLDA;
class PASCALIMPLEMENTATION TZParamsSQLDA : public TZSQLDA 
{
	typedef TZSQLDA inherited;
	
protected:
	void * *FHandle;
	void * *FTransactionHandle;
	
private:
	void __fastcall EncodeString(short Code, const Word Index, const AnsiString Str);
	
public:
	__fastcall TZParamsSQLDA(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE 
		Handle, Zplaininterbasedriver::PISC_TR_HANDLE TransactionHandle);
	__fastcall virtual ~TZParamsSQLDA(void);
	void __fastcall WriteBlob(const int Index, Classes::TStream* Stream);
	void __fastcall UpdateNull(const int Index, bool Value);
	void __fastcall UpdateBoolean(const int Index, bool Value);
	void __fastcall UpdateByte(const int Index, Shortint Value);
	void __fastcall UpdateShort(const int Index, short Value);
	void __fastcall UpdateInt(const int Index, int Value);
	void __fastcall UpdateLong(const int Index, __int64 Value);
	void __fastcall UpdateFloat(const int Index, float Value);
	void __fastcall UpdateDouble(const int Index, double Value);
	void __fastcall UpdateBigDecimal(const int Index, Extended Value);
	void __fastcall UpdatePChar(const int Index, char * Value);
	void __fastcall UpdateString(const int Index, AnsiString Value);
	void __fastcall UpdateBytes(const int Index, Zcompatibility::TByteDynArray Value);
	void __fastcall UpdateDate(const int Index, System::TDateTime Value);
	void __fastcall UpdateTime(const int Index, System::TDateTime Value);
	void __fastcall UpdateTimestamp(const int Index, System::TDateTime Value);
	void __fastcall UpdateQuad(const Word Index, const Zplaininterbasedriver::TGDS_QUAD &Value);
private:
		
	void *__IZParamsSQLDA;	/* Zdbcinterbase6utils::IZParamsSQLDA */
	
public:
	operator IZParamsSQLDA*(void) { return (IZParamsSQLDA*)&__IZParamsSQLDA; }
	
};


typedef DynamicArray<Variant >  ZDbcInterbase6Utils__5;

class DELPHICLASS TZResultSQLDA;
class PASCALIMPLEMENTATION TZResultSQLDA : public TZSQLDA 
{
	typedef TZSQLDA inherited;
	
protected:
	DynamicArray<Variant >  FDefaults;
	void * *FHandle;
	void * *FTransactionHandle;
	
private:
	AnsiString __fastcall DecodeString(const short Code, const Word Index);
	void __fastcall DecodeString2(const short Code, const Word Index, /* out */ AnsiString &Str);
	
public:
	__fastcall TZResultSQLDA(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE 
		Handle, Zplaininterbasedriver::PISC_TR_HANDLE TransactionHandle);
	__fastcall virtual ~TZResultSQLDA(void);
	virtual void __fastcall AllocateSQLDA(void);
	void __fastcall ReadBlobFromStream(const Word Index, Classes::TStream* Stream);
	void __fastcall ReadBlobFromString(const Word Index, AnsiString &str);
	void __fastcall ReadBlobFromVariant(const Word Index, Variant &Value);
	bool __fastcall IsNull(const int Index);
	char * __fastcall GetPChar(const int Index);
	AnsiString __fastcall GetString(const int Index);
	bool __fastcall GetBoolean(const int Index);
	Shortint __fastcall GetByte(const int Index);
	short __fastcall GetShort(const int Index);
	int __fastcall GetInt(const int Index);
	__int64 __fastcall GetLong(const int Index);
	float __fastcall GetFloat(const int Index);
	double __fastcall GetDouble(const int Index);
	Extended __fastcall GetBigDecimal(const int Index);
	Zcompatibility::TByteDynArray __fastcall GetBytes(const int Index);
	System::TDateTime __fastcall GetDate(const int Index);
	System::TDateTime __fastcall GetTime(const int Index);
	System::TDateTime __fastcall GetTimestamp(const int Index);
	Variant __fastcall GetValue(const Word Index);
	Zplaininterbasedriver::TGDS_QUAD __fastcall GetQuad(const int Index);
private:
	void *__IZResultSQLDA;	/* Zdbcinterbase6utils::IZResultSQLDA */
	
public:
	operator IZResultSQLDA*(void) { return (IZResultSQLDA*)&__IZResultSQLDA; }
	
};


typedef TZIbParam ZDbcInterbase6Utils__6[68];

typedef TZIbParam ZDbcInterbase6Utils__7[17];

//-- var, const, procedure ---------------------------------------------------
static const Word DefaultBlobSegmentSize = 0x4000;
extern PACKAGE __int64 IBScaleDivisor[15];
static const Shortint MAX_DPB_PARAMS = 0x43;
#define BPBPrefix "isc_dpb_"
extern PACKAGE TZIbParam DatabaseParams[68];
static const Shortint MAX_TPB_PARAMS = 0x10;
#define TPBPrefix "isc_tpb_"
extern PACKAGE TZIbParam TransactionParams[17];
extern PACKAGE AnsiString __fastcall RandomString(int Len);
extern PACKAGE Zdbcintfs::_di_IZResultSet __fastcall GetCachedResultSet(AnsiString SQL, Zdbcintfs::_di_IZStatement 
	Statement, Zdbcintfs::_di_IZResultSet NativeResultSet);
extern PACKAGE char * __fastcall GenerateDPB(Classes::TStrings* Info, Word &FDPBLength, Word &Dialect
	);
extern PACKAGE Zplaininterbasedriver::PISC_TEB __fastcall GenerateTPB(Classes::TStrings* Params, void * 
	&Handle);
extern PACKAGE Word __fastcall GetInterbase6DatabaseParamNumber(const AnsiString Value);
extern PACKAGE Word __fastcall GetInterbase6TransactionParamNumber(const AnsiString Value);
extern PACKAGE Zdbcintfs::TZSQLType __fastcall ConvertInterbase6ToSqlType(int SqlType, int SqlSubType
	);
extern PACKAGE AnsiString __fastcall GetNameSqlType(Word Value);
extern PACKAGE void __fastcall CheckInterbase6Error(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, const int * StatusVector, Zdbclogging::TZLoggingCategory LoggingCategory, AnsiString SQL
	);
extern PACKAGE TZIbSqlStatementType __fastcall PrepareStatement(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE Handle, Zplaininterbasedriver::PISC_TR_HANDLE TrHandle
	, Word Dialect, AnsiString SQL, void * &StmtHandle);
extern PACKAGE void __fastcall PrepareResultSqlData(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE Handle, Word Dialect, AnsiString SQL, void * &StmtHandle
	, _di_IZResultSQLDA SqlData);
extern PACKAGE TZIbSqlStatementType __fastcall GetStatementType(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, void * StmtHandle);
extern PACKAGE void __fastcall FreeStatement(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, void * StatementHandle);
extern PACKAGE int __fastcall GetAffectedRows(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, void * StmtHandle, TZIbSqlStatementType StatementType);
extern PACKAGE void __fastcall PrepareParameters(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, AnsiString SQL, Zvariant::TZVariantDynArray InParamValues, Zdbcstatement::TZSQLTypeArray InParamTypes
	, int InParamCount, Word Dialect, void * &StmtHandle, _di_IZParamsSQLDA ParamSqlData);
extern PACKAGE void __fastcall GetBlobInfo(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, void * BlobHandle, TIbBlobInfo &BlobInfo);
extern PACKAGE void __fastcall ReadBlobBufer(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, Zplaininterbasedriver::PISC_DB_HANDLE Handle, Zplaininterbasedriver::PISC_TR_HANDLE TransactionHandle
	, const Zplaininterbasedriver::TGDS_QUAD &BlobId, int &Size, void * &Buffer);
extern PACKAGE AnsiString __fastcall GetVerion(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, Zplaininterbasedriver::PISC_DB_HANDLE Handle);
extern PACKAGE int __fastcall GetDBImplementationNo(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE Handle);
extern PACKAGE int __fastcall GetDBImplementationClass(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE Handle);
extern PACKAGE int __fastcall GetLongDbInfo(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, Zplaininterbasedriver::PISC_DB_HANDLE Handle, int DatabaseInfoCommand);
extern PACKAGE AnsiString __fastcall GetStringDbInfo(Zplaininterbasedriver::_di_IZInterbasePlainDriver 
	PlainDriver, Zplaininterbasedriver::PISC_DB_HANDLE Handle, int DatabaseInfoCommand);
extern PACKAGE int __fastcall GetDBSQLDialect(Zplaininterbasedriver::_di_IZInterbasePlainDriver PlainDriver
	, Zplaininterbasedriver::PISC_DB_HANDLE Handle);

}	/* namespace Zdbcinterbase6utils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcinterbase6utils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcInterbase6Utils
