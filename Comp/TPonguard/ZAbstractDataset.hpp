// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZAbstractDataset.pas' rev: 5.00

#ifndef ZAbstractDatasetHPP
#define ZAbstractDatasetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcGenericResolver.hpp>	// Pascal unit
#include <ZAbstractRODataset.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZSqlUpdate.hpp>	// Pascal unit
#include <ZConnection.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zabstractdataset
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TUpdateRecordEvent)(Db::TDataSet* DataSet, Db::TUpdateKind UpdateKind
	, Db::TUpdateAction &UpdateAction);

#pragma option push -b-
enum TZUpdateMode { umUpdateChanged, umUpdateAll };
#pragma option pop

#pragma option push -b-
enum TZWhereMode { wmWhereKeyOnly, wmWhereAll };
#pragma option pop

class DELPHICLASS TZAbstractDataset;
class PASCALIMPLEMENTATION TZAbstractDataset : public Zabstractrodataset::TZAbstractRODataset 
{
	typedef Zabstractrodataset::TZAbstractRODataset inherited;
	
private:
	bool FCachedUpdates;
	Zsqlupdate::TZUpdateSQL* FUpdateObject;
	Zdbccachedresultset::_di_IZCachedResultSet FCachedResultSet;
	Zdbccachedresultset::_di_IZCachedResolver FCachedResolver;
	Db::TDataSetErrorEvent FOnApplyUpdateError;
	TUpdateRecordEvent FOnUpdateRecord;
	TZUpdateMode FUpdateMode;
	TZWhereMode FWhereMode;
	bool __fastcall GetUpdatesPending(void);
	void __fastcall SetUpdateObject(Zsqlupdate::TZUpdateSQL* Value);
	void __fastcall SetCachedUpdates(bool Value);
	void __fastcall SetWhereMode(TZWhereMode Value);
	void __fastcall SetUpdateMode(TZUpdateMode Value);
	
protected:
	__property Zdbccachedresultset::_di_IZCachedResultSet CachedResultSet = {read=FCachedResultSet, write=
		FCachedResultSet};
	__property Zdbccachedresultset::_di_IZCachedResolver CachedResolver = {read=FCachedResolver, write=
		FCachedResolver};
	__property TZUpdateMode UpdateMode = {read=FUpdateMode, write=SetUpdateMode, nodefault};
	__property TZWhereMode WhereMode = {read=FWhereMode, write=SetWhereMode, nodefault};
	virtual void __fastcall InternalClose(void);
	virtual void __fastcall InternalEdit(void);
	virtual void __fastcall InternalAddRecord(void * Buffer, bool Append);
	virtual void __fastcall InternalPost(void);
	virtual void __fastcall InternalDelete(void);
	void __fastcall InternalUpdate(void);
	virtual void __fastcall InternalCancel(void);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreateStatement(AnsiString SQL, Classes::TStrings* 
		Properties);
	virtual Zdbcintfs::_di_IZResultSet __fastcall CreateResultSet(AnsiString SQL, int MaxRows);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TZAbstractDataset(Classes::TComponent* AOwner);
	__fastcall virtual ~TZAbstractDataset(void);
	void __fastcall ApplyUpdates(void);
	void __fastcall CommitUpdates(void);
	void __fastcall CancelUpdates(void);
	void __fastcall RevertRecord(void);
	__property bool UpdatesPending = {read=GetUpdatesPending, nodefault};
	
__published:
	__property RequestLive ;
	__property Zsqlupdate::TZUpdateSQL* UpdateObject = {read=FUpdateObject, write=SetUpdateObject};
	__property bool CachedUpdates = {read=FCachedUpdates, write=SetCachedUpdates, nodefault};
	__property Db::TDataSetErrorEvent OnApplyUpdateError = {read=FOnApplyUpdateError, write=FOnApplyUpdateError
		};
	__property TUpdateRecordEvent OnUpdateRecord = {read=FOnUpdateRecord, write=FOnUpdateRecord};
	__property BeforeInsert ;
	__property AfterInsert ;
	__property BeforeEdit ;
	__property AfterEdit ;
	__property BeforePost ;
	__property AfterPost ;
	__property BeforeCancel ;
	__property AfterCancel ;
	__property BeforeDelete ;
	__property AfterDelete ;
	__property OnDeleteError ;
	__property OnEditError ;
	__property OnPostError ;
	__property OnNewRecord ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zabstractdataset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zabstractdataset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZAbstractDataset
