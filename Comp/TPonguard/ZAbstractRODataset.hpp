// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZAbstractRODataset.pas' rev: 5.00

#ifndef ZAbstractRODatasetHPP
#define ZAbstractRODatasetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZExpression.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZDbcCachedResultSet.hpp>	// Pascal unit
#include <ZDbcCache.hpp>	// Pascal unit
#include <ZSqlStrings.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZConnection.hpp>	// Pascal unit
#include <ZSysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zabstractrodataset
{
//-- type declarations -------------------------------------------------------
typedef Zdbccache::TZRowUpdateType TZUpdateRecordType;

typedef Set<Zdbccache::TZRowUpdateType, utUnmodified, utDeleted>  TZUpdateRecordTypes;

#pragma option push -b-
enum TZDatasetOption { doOemTranslate, doCalcDefaults, doAlwaysDetailResync };
#pragma option pop

typedef Set<TZDatasetOption, doOemTranslate, doAlwaysDetailResync>  TZDatasetOptions;

class DELPHICLASS TZDataLink;
class DELPHICLASS TZAbstractRODataset;
class PASCALIMPLEMENTATION TZAbstractRODataset : public Db::TDataSet 
{
	typedef Db::TDataSet inherited;
	
private:
	bool FUniDirectional;
	int FCurrentRow;
	Zdbccache::TZRowAccessor* FRowAccessor;
	Zdbccache::TZRowBuffer *FOldRowBuffer;
	Zdbccache::TZRowBuffer *FNewRowBuffer;
	Zsysutils::TZSortedList* FCurrentRows;
	int FFetchCount;
	DynamicArray<int >  FFieldsLookupTable;
	bool FFilterEnabled;
	Zexpression::_di_IZExpression FFilterExpression;
	Zexpression::TZExecutionStack* FFilterStack;
	DynamicArray<System::TObject* >  FFilterFieldRefs;
	bool FInitFilterFields;
	bool FRequestLive;
	Zsqlstrings::TZSQLStrings* FSQL;
	bool FParamCheck;
	Db::TParams* FParams;
	TZUpdateRecordTypes FShowRecordTypes;
	TZDatasetOptions FOptions;
	Classes::TStrings* FProperties;
	Zconnection::TZConnection* FConnection;
	Zdbcintfs::_di_IZPreparedStatement FStatement;
	Zdbcintfs::_di_IZResultSet FResultSet;
	bool FRefreshInProgress;
	Db::TDataLink* FDataLink;
	Db::TMasterDataLink* FMasterLink;
	AnsiString FIndexFieldNames;
	Classes::TList* FIndexFields;
	AnsiString FSortedFields;
	DynamicArray<System::TObject* >  FSortedFieldRefs;
	DynamicArray<int >  FSortedFieldIndices;
	DynamicArray<bool >  FSortedFieldDirs;
	bool FSortedOnlyDataFields;
	Zdbccache::TZRowBuffer *FSortRowBuffer1;
	Zdbccache::TZRowBuffer *FSortRowBuffer2;
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(bool Value);
	Classes::TStrings* __fastcall GetSQL(void);
	void __fastcall SetSQL(Classes::TStrings* Value);
	bool __fastcall GetParamCheck(void);
	void __fastcall SetParamCheck(bool Value);
	void __fastcall SetParams(Db::TParams* Value);
	void __fastcall SetShowRecordTypes(TZUpdateRecordTypes Value);
	void __fastcall SetConnection(Zconnection::TZConnection* Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	AnsiString __fastcall GetMasterFields();
	void __fastcall SetMasterFields(AnsiString Value);
	Db::TDataSource* __fastcall GetMasterDataSource(void);
	void __fastcall SetMasterDataSource(Db::TDataSource* Value);
	AnsiString __fastcall GetIndexFieldNames();
	void __fastcall SetIndexFieldNames(AnsiString Value);
	void __fastcall SetOptions(TZDatasetOptions Value);
	void __fastcall SetSortedFields(AnsiString Value);
	void __fastcall SetProperties(const Classes::TStrings* Value);
	void __fastcall UpdateSQLStrings(System::TObject* Sender);
	void __fastcall ReadParamData(Classes::TReader* Reader);
	void __fastcall WriteParamData(Classes::TWriter* Writer);
	
protected:
	void __fastcall CheckConnected(void);
	void __fastcall CheckBiDirectional(void);
	void __fastcall CheckSQLQuery(void);
	void __fastcall RaiseReadOnlyError(void);
	bool __fastcall FetchOneRow(void);
	bool __fastcall FetchRows(int RowCount);
	bool __fastcall FilterRow(int RowNo);
	void __fastcall RereadRows(void);
	virtual void __fastcall SetStatementParams(Zdbcintfs::_di_IZPreparedStatement Statement, Zcompatibility::TStringDynArray 
		ParamNames, Db::TParams* Params, Db::TDataLink* DataLink);
	void __fastcall MasterChanged(System::TObject* Sender);
	void __fastcall MasterDisabled(System::TObject* Sender);
	virtual void __fastcall DoOnNewRecord(void);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	__property Zdbccache::TZRowAccessor* RowAccessor = {read=FRowAccessor, write=FRowAccessor};
	__property int CurrentRow = {read=FCurrentRow, write=FCurrentRow, nodefault};
	__property Zdbccache::PZRowBuffer OldRowBuffer = {read=FOldRowBuffer, write=FOldRowBuffer};
	__property Zdbccache::PZRowBuffer NewRowBuffer = {read=FNewRowBuffer, write=FNewRowBuffer};
	__property Zsysutils::TZSortedList* CurrentRows = {read=FCurrentRows, write=FCurrentRows};
	__property int FetchCount = {read=FFetchCount, write=FFetchCount, nodefault};
	__property Zcompatibility::TIntegerDynArray FieldsLookupTable = {read=FFieldsLookupTable, write=FFieldsLookupTable
		};
	__property bool FilterEnabled = {read=FFilterEnabled, write=FFilterEnabled, nodefault};
	__property Zexpression::_di_IZExpression FilterExpression = {read=FFilterExpression, write=FFilterExpression
		};
	__property Zexpression::TZExecutionStack* FilterStack = {read=FFilterStack, write=FFilterStack};
	__property Zcompatibility::TObjectDynArray FilterFieldRefs = {read=FFilterFieldRefs, write=FFilterFieldRefs
		};
	__property bool InitFilterFields = {read=FInitFilterFields, write=FInitFilterFields, nodefault};
	__property Zdbcintfs::_di_IZPreparedStatement Statement = {read=FStatement, write=FStatement};
	__property Zdbcintfs::_di_IZResultSet ResultSet = {read=FResultSet, write=FResultSet};
	__property Db::TDataLink* DataLink = {read=FDataLink};
	__property Db::TMasterDataLink* MasterLink = {read=FMasterLink};
	__property Classes::TList* IndexFields = {read=FIndexFields};
	__property bool RequestLive = {read=FRequestLive, write=FRequestLive, nodefault};
	__property Classes::TStrings* SQL = {read=GetSQL, write=SetSQL};
	__property bool ParamCheck = {read=GetParamCheck, write=SetParamCheck, nodefault};
	__property Db::TParams* Params = {read=FParams, write=SetParams};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, nodefault};
	__property TZUpdateRecordTypes ShowRecordTypes = {read=FShowRecordTypes, write=SetShowRecordTypes, 
		nodefault};
	__property bool IsUniDirectional = {read=FUniDirectional, write=FUniDirectional, nodefault};
	__property Classes::TStrings* Properties = {read=FProperties, write=SetProperties};
	__property TZDatasetOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property AnsiString MasterFields = {read=GetMasterFields, write=SetMasterFields};
	__property Db::TDataSource* MasterSource = {read=GetMasterDataSource, write=SetMasterDataSource};
	__property AnsiString IndexFieldNames = {read=GetIndexFieldNames, write=SetIndexFieldNames};
	virtual void __fastcall InternalAddRecord(void * Buffer, bool Append);
	virtual void __fastcall InternalDelete(void);
	virtual void __fastcall InternalPost(void);
	virtual void __fastcall SetFieldData(Db::TField* Field, void * Buffer, bool NativeFormat)/* overload */
		;
	virtual void __fastcall SetFieldData(Db::TField* Field, void * Buffer)/* overload */;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual Db::TGetResult __fastcall GetRecord(char * Buffer, Db::TGetMode GetMode, bool DoCheck);
	virtual Word __fastcall GetRecordSize(void);
	bool __fastcall GetActiveBuffer(Zdbccache::PZRowBuffer &RowBuffer);
	virtual char * __fastcall AllocRecordBuffer(void);
	virtual void __fastcall FreeRecordBuffer(char * &Buffer);
	virtual void __fastcall CloseBlob(Db::TField* Field);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreateStatement(AnsiString SQL, Classes::TStrings* 
		Properties);
	virtual Zdbcintfs::_di_IZResultSet __fastcall CreateResultSet(AnsiString SQL, int MaxRows);
	virtual void __fastcall InternalInitFieldDefs(void);
	virtual void __fastcall InternalOpen(void);
	virtual void __fastcall InternalClose(void);
	virtual void __fastcall InternalFirst(void);
	virtual void __fastcall InternalLast(void);
	virtual void __fastcall InternalInitRecord(char * Buffer);
	virtual void __fastcall InternalGotoBookmark(void * Bookmark);
	virtual void __fastcall InternalRefresh(void);
	virtual void __fastcall InternalHandleException(void);
	virtual void __fastcall InternalSetToRecord(char * Buffer);
	virtual void __fastcall GetBookmarkData(char * Buffer, void * Data);
	virtual Db::TBookmarkFlag __fastcall GetBookmarkFlag(char * Buffer);
	virtual void __fastcall SetBookmarkFlag(char * Buffer, Db::TBookmarkFlag Value);
	virtual void __fastcall SetBookmarkData(char * Buffer, void * Data);
	int __fastcall InternalLocate(AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions Options
		);
	virtual bool __fastcall FindRecord(bool Restart, bool GoForward);
	virtual void __fastcall SetFiltered(bool Value);
	virtual void __fastcall SetFilterText(const AnsiString Value);
	void __fastcall InternalSort(void);
	int __fastcall ClearSort(void * Item1, void * Item2);
	int __fastcall HighLevelSort(void * Item1, void * Item2);
	int __fastcall LowLevelSort(void * Item1, void * Item2);
	virtual bool __fastcall GetCanModify(void);
	virtual int __fastcall GetRecNo(void);
	virtual int __fastcall GetRecordCount(void);
	void __fastcall MoveRecNo(int Value);
	virtual void __fastcall SetRecNo(int Value);
	virtual bool __fastcall IsCursorOpen(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	void __fastcall RefreshParams(void);
	
public:
	__fastcall virtual TZAbstractRODataset(Classes::TComponent* AOwner);
	__fastcall virtual ~TZAbstractRODataset(void);
	virtual void __fastcall ExecSQL(void);
	int __fastcall RowsAffected(void);
	Db::TParam* __fastcall ParamByName(const AnsiString Value);
	virtual bool __fastcall Locate(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions 
		Options);
	virtual Variant __fastcall Lookup(const AnsiString KeyFields, const Variant &KeyValues, const AnsiString 
		ResultFields);
	virtual bool __fastcall IsSequenced(void);
	virtual int __fastcall CompareBookmarks(void * Bookmark1, void * Bookmark2);
	virtual bool __fastcall BookmarkValid(void * Bookmark);
	virtual bool __fastcall GetFieldData(Db::TField* Field, void * Buffer)/* overload */;
	virtual bool __fastcall GetFieldData(Db::TField* Field, void * Buffer, bool NativeFormat)/* overload */
		;
	virtual Classes::TStream* __fastcall CreateBlobStream(Db::TField* Field, Db::TBlobStreamMode Mode);
		
	virtual Db::TUpdateStatus __fastcall UpdateStatus(void);
	virtual int __fastcall Translate(char * Src, char * Dest, bool ToOem);
	__property Active ;
	__property FieldDefs  = {stored=false};
	__property Zdbcintfs::_di_IZPreparedStatement DbcStatement = {read=FStatement};
	__property Zdbcintfs::_di_IZResultSet DbcResultSet = {read=FResultSet};
	
__published:
	__property Zconnection::TZConnection* Connection = {read=FConnection, write=SetConnection};
	__property AnsiString SortedFields = {read=FSortedFields, write=SetSortedFields};
	__property AutoCalcFields ;
	__property BeforeOpen ;
	__property AfterOpen ;
	__property BeforeClose ;
	__property AfterClose ;
	__property BeforeRefresh ;
	__property AfterRefresh ;
	__property BeforeScroll ;
	__property AfterScroll ;
	__property OnCalcFields ;
	__property OnFilterRecord ;
	__property Filter ;
	__property Filtered ;
};


class PASCALIMPLEMENTATION TZDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TZAbstractRODataset* FDataset;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	
public:
	__fastcall TZDataLink(TZAbstractRODataset* ADataset);
public:
	#pragma option push -w-inl
	/* TDataLink.Destroy */ inline __fastcall virtual ~TZDataLink(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zabstractrodataset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zabstractrodataset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZAbstractRODataset
