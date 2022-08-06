// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSqlUpdate.pas' rev: 5.00

#ifndef ZSqlUpdateHPP
#define ZSqlUpdateHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZSqlStrings.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zsqlupdate
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZUpdateSQL;
class PASCALIMPLEMENTATION TZUpdateSQL : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Db::TDataSet* FDataSet;
	Zsqlstrings::TZSQLStrings* FDeleteSQL;
	Zsqlstrings::TZSQLStrings* FInsertSQL;
	Zsqlstrings::TZSQLStrings* FModifySQL;
	bool FParamCheck;
	Db::TParams* FParams;
	bool FMultiStatements;
	void __fastcall SetDataset(Db::TDataSet* Value);
	Classes::TStrings* __fastcall GetSQL(Db::TUpdateKind UpdateKind);
	void __fastcall SetSQL(Db::TUpdateKind UpdateKind, Classes::TStrings* Value);
	Word __fastcall GetParamsCount(void);
	void __fastcall SetParamsList(Db::TParams* Value);
	void __fastcall SetParamCheck(bool Value);
	void __fastcall SetMultiStatements(bool Value);
	Classes::TStrings* __fastcall GetDeleteSQL(void);
	void __fastcall SetDeleteSQL(Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetInsertSQL(void);
	void __fastcall SetInsertSQL(Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetModifySQL(void);
	void __fastcall SetModifySQL(Classes::TStrings* Value);
	void __fastcall ReadParamData(Classes::TReader* Reader);
	void __fastcall WriteParamData(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall CalculateDefaults(Zdbccachedresultset::_di_IZCachedResultSet Sender, Zdbccache::TZRowAccessor* 
		RowAccessor);
	void __fastcall PostUpdates(Zdbccachedresultset::_di_IZCachedResultSet Sender, Zdbccache::TZRowUpdateType 
		UpdateType, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* NewRowAccessor);
	void __fastcall Rebuild(Zsqlstrings::TZSQLStrings* SQLStrings);
	void __fastcall RebuildAll(void);
	void __fastcall FillStatement(Zdbccachedresultset::_di_IZCachedResultSet ResultSet, Zdbcintfs::_di_IZPreparedStatement 
		Statement, Zsqlstrings::TZSQLStatement* Config, Zdbccache::TZRowAccessor* OldRowAccessor, Zdbccache::TZRowAccessor* 
		NewRowAccessor);
	void __fastcall UpdateParams(System::TObject* Sender);
	
public:
	__fastcall virtual TZUpdateSQL(Classes::TComponent* AOwner);
	__fastcall virtual ~TZUpdateSQL(void);
	__property Classes::TStrings* SQL[Db::TUpdateKind UpdateKind] = {read=GetSQL, write=SetSQL};
	__property Word ParamCount = {read=GetParamsCount, nodefault};
	__property Db::TDataSet* DataSet = {read=FDataSet, write=SetDataset};
	
__published:
	__property Classes::TStrings* DeleteSQL = {read=GetDeleteSQL, write=SetDeleteSQL};
	__property Classes::TStrings* InsertSQL = {read=GetInsertSQL, write=SetInsertSQL};
	__property Classes::TStrings* ModifySQL = {read=GetModifySQL, write=SetModifySQL};
	__property Db::TParams* Params = {read=FParams, write=SetParamsList, stored=false};
	__property bool ParamCheck = {read=FParamCheck, write=SetParamCheck, default=1};
	__property bool MultiStatements = {read=FMultiStatements, write=SetMultiStatements, default=1};
private:
		
	void *__IZCachedResolver;	/* Zdbccachedresultset::IZCachedResolver */
	
public:
	operator IZCachedResolver*(void) { return (IZCachedResolver*)&__IZCachedResolver; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zsqlupdate */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zsqlupdate;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSqlUpdate
