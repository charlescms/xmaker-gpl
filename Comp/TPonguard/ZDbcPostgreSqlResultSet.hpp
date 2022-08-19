// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcPostgreSqlResultSet.pas' rev: 5.00

#ifndef ZDbcPostgreSqlResultSetHPP
#define ZDbcPostgreSqlResultSetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcLogging.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZPlainPostgreSqlDriver.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcpostgresqlresultset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZPostgreSQLResultSet;
class PASCALIMPLEMENTATION TZPostgreSQLResultSet : public Zdbcresultset::TZAbstractResultSet 
{
	typedef Zdbcresultset::TZAbstractResultSet inherited;
	
private:
	void *FHandle;
	void *FQueryHandle;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPlainDriver;
	
protected:
	virtual void __fastcall Open(void);
	void __fastcall DefinePostgreSQLToSQLType(int ColumnIndex, Zdbcresultsetmetadata::TZColumnInfo* ColumnInfo
		, int TypeOid);
	
public:
	__fastcall TZPostgreSQLResultSet(Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver PlainDriver, Zdbcintfs::_di_IZStatement 
		Statement, AnsiString SQL, void * Handle, void * QueryHandle);
	__fastcall virtual ~TZPostgreSQLResultSet(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall IsNull(int ColumnIndex);
	virtual AnsiString __fastcall GetString(int ColumnIndex);
	virtual bool __fastcall GetBoolean(int ColumnIndex);
	virtual Shortint __fastcall GetByte(int ColumnIndex);
	virtual short __fastcall GetShort(int ColumnIndex);
	virtual int __fastcall GetInt(int ColumnIndex);
	virtual __int64 __fastcall GetLong(int ColumnIndex);
	virtual float __fastcall GetFloat(int ColumnIndex);
	virtual double __fastcall GetDouble(int ColumnIndex);
	virtual Extended __fastcall GetBigDecimal(int ColumnIndex);
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes(int ColumnIndex);
	virtual System::TDateTime __fastcall GetDate(int ColumnIndex);
	virtual System::TDateTime __fastcall GetTime(int ColumnIndex);
	virtual System::TDateTime __fastcall GetTimestamp(int ColumnIndex);
	virtual Zdbcintfs::_di_IZBlob __fastcall GetBlob(int ColumnIndex);
	virtual bool __fastcall MoveAbsolute(int Row);
};


__interface IZPostgreSQLBlob;
typedef System::DelphiInterface<IZPostgreSQLBlob> _di_IZPostgreSQLBlob;
__interface INTERFACE_UUID("{BDFB6B80-477D-4CB1-9508-9541FEA6CD72}") IZPostgreSQLBlob  : public IZBlob 
	
{
	
public:
	virtual int __fastcall GetBlobOid(void) = 0 ;
	virtual void __fastcall ReadBlob(void) = 0 ;
	virtual void __fastcall WriteBlob(void) = 0 ;
};

class DELPHICLASS TZPostgreSQLBlob;
class PASCALIMPLEMENTATION TZPostgreSQLBlob : public Zdbcresultset::TZAbstractBlob 
{
	typedef Zdbcresultset::TZAbstractBlob inherited;
	
private:
	void *FHandle;
	int FBlobOid;
	Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver FPlainDriver;
	
public:
	__fastcall TZPostgreSQLBlob(Zplainpostgresqldriver::_di_IZPostgreSQLPlainDriver PlainDriver, void * 
		Data, int Size, void * Handle, int BlobOid);
	__fastcall virtual ~TZPostgreSQLBlob(void);
	int __fastcall GetBlobOid(void);
	void __fastcall ReadBlob(void);
	void __fastcall WriteBlob(void);
	virtual bool __fastcall IsEmpty(void);
	virtual Zdbcintfs::_di_IZBlob __fastcall Clone();
	virtual Classes::TStream* __fastcall GetStream(void);
public:
	#pragma option push -w-inl
	/* TZAbstractBlob.CreateWithStream */ inline __fastcall TZPostgreSQLBlob(Classes::TStream* Stream) : 
		Zdbcresultset::TZAbstractBlob(Stream) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractBlob.CreateWithData */ inline __fastcall TZPostgreSQLBlob(void * Data, int Size) : Zdbcresultset::TZAbstractBlob(
		Data, Size) { }
	#pragma option pop
	
private:
	void *__IZPostgreSQLBlob;	/* Zdbcpostgresqlresultset::IZPostgreSQLBlob */
	
public:
	operator IZPostgreSQLBlob*(void) { return (IZPostgreSQLBlob*)&__IZPostgreSQLBlob; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcpostgresqlresultset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcpostgresqlresultset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcPostgreSqlResultSet
