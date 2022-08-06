// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcInterbase6ResultSet.pas' rev: 5.00

#ifndef ZDbcInterbase6ResultSetHPP
#define ZDbcInterbase6ResultSetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZMessages.hpp>	// Pascal unit
#include <ZDbcInterbase6Utils.hpp>	// Pascal unit
#include <ZDbcResultSetMetadata.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ZPlainInterbaseDriver.hpp>	// Pascal unit
#include <ZDbcInterbase6.hpp>	// Pascal unit
#include <ZDbcResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZCollections.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcinterbase6resultset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZInterbase6ResultSet;
class PASCALIMPLEMENTATION TZInterbase6ResultSet : public Zdbcresultset::TZAbstractResultSet 
{
	typedef Zdbcresultset::TZAbstractResultSet inherited;
	
private:
	bool FCachedBlob;
	int FFetchStat;
	AnsiString FCursorName;
	void *FStmtHandle;
	Zdbcinterbase6utils::_di_IZResultSQLDA FSqlData;
	Zdbcinterbase6utils::_di_IZParamsSQLDA FParamsSqlData;
	Zdbcinterbase6::_di_IZInterbase6Connection FIBConnection;
	
protected:
	virtual void __fastcall Open(void);
	Variant __fastcall GetFieldValue(int ColumnIndex);
	
public:
	__fastcall TZInterbase6ResultSet(Zdbcintfs::_di_IZStatement Statement, AnsiString SQL, void * &StatementHandle
		, AnsiString CursorName, Zdbcinterbase6utils::_di_IZResultSQLDA SqlData, Zdbcinterbase6utils::_di_IZParamsSQLDA 
		ParamsSqlData, bool CachedBlob);
	__fastcall virtual ~TZInterbase6ResultSet(void);
	virtual void __fastcall Close(void);
	virtual AnsiString __fastcall GetCursorName();
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
	virtual bool __fastcall Next(void);
};


class DELPHICLASS TZInterbase6Blob;
class PASCALIMPLEMENTATION TZInterbase6Blob : public Zdbcresultset::TZAbstractBlob 
{
	typedef Zdbcresultset::TZAbstractBlob inherited;
	
private:
	Zplaininterbasedriver::TGDS_QUAD FBlobId;
	bool FBlobRead;
	Zdbcinterbase6::_di_IZInterbase6Connection FIBConnection;
	
protected:
	void __fastcall ReadBlob(void);
	
public:
	__fastcall TZInterbase6Blob(Zdbcinterbase6::_di_IZInterbase6Connection IBConnection, Zplaininterbasedriver::TGDS_QUAD 
		&BlobId);
	virtual bool __fastcall IsEmpty(void);
	virtual Zdbcintfs::_di_IZBlob __fastcall Clone();
	virtual Classes::TStream* __fastcall GetStream(void);
	virtual AnsiString __fastcall GetString();
	virtual WideString __fastcall GetUnicodeString();
	virtual Zcompatibility::TByteDynArray __fastcall GetBytes();
public:
	#pragma option push -w-inl
	/* TZAbstractBlob.CreateWithStream */ inline __fastcall TZInterbase6Blob(Classes::TStream* Stream) : 
		Zdbcresultset::TZAbstractBlob(Stream) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractBlob.CreateWithData */ inline __fastcall TZInterbase6Blob(void * Data, int Size) : Zdbcresultset::TZAbstractBlob(
		Data, Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractBlob.Destroy */ inline __fastcall virtual ~TZInterbase6Blob(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcinterbase6resultset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcinterbase6resultset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcInterbase6ResultSet
