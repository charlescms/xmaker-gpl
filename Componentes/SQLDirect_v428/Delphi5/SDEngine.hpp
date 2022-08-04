// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDEngine.pas' rev: 5.00

#ifndef SDEngineHPP
#define SDEngineHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <DBCommon.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdengine
{
//-- type declarations -------------------------------------------------------
#pragma option push -b
enum TSDServerType { stSQLBase, stOracle, stSQLServer, stSybase, stDB2, stInformix, stODBC, stInterbase, 
	stFirebird, stMySQL, stPostgreSQL, stOLEDB };
#pragma option pop

class DELPHICLASS ESDNoResultSet;
class PASCALIMPLEMENTATION ESDNoResultSet : public Db::EDatabaseError 
{
	typedef Db::EDatabaseError inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESDNoResultSet(const AnsiString Msg) : Db::EDatabaseError(
		Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDNoResultSet(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Db::EDatabaseError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDNoResultSet(int Ident)/* overload */ : Db::EDatabaseError(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDNoResultSet(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : Db::EDatabaseError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDNoResultSet(const AnsiString Msg, int AHelpContext)
		 : Db::EDatabaseError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDNoResultSet(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Db::EDatabaseError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDNoResultSet(int Ident, int AHelpContext)/* overload */
		 : Db::EDatabaseError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDNoResultSet(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Db::EDatabaseError(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDNoResultSet(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSDSessionList;
class DELPHICLASS TSDSession;
class DELPHICLASS TSDDatabase;
class PASCALIMPLEMENTATION TSDSessionList : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TThreadList* FSessions;
	Classes::TBits* FSessionNumbers;
	void __fastcall AddSession(TSDSession* ASession);
	void __fastcall CloseAll(void);
	int __fastcall GetCount(void);
	TSDSession* __fastcall GetSession(int Index);
	TSDSession* __fastcall GetSessionByName(const AnsiString SessionName);
	
public:
	__fastcall TSDSessionList(void);
	__fastcall virtual ~TSDSessionList(void);
	TSDDatabase* __fastcall FindDatabase(const AnsiString DatabaseName);
	TSDSession* __fastcall FindSession(const AnsiString SessionName);
	void __fastcall GetSessionNames(Classes::TStrings* List);
	TSDSession* __fastcall OpenSession(const AnsiString SessionName);
	__property int Count = {read=GetCount, nodefault};
	__property TSDSession* List[AnsiString SessionName] = {read=GetSessionByName};
	__property TSDSession* Sessions[int Index] = {read=GetSession/*, default*/};
};


class PASCALIMPLEMENTATION TSDSession : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TList* FDatabases;
	bool FDefault;
	bool FKeepConnections;
	Classes::TList* FDBParams;
	bool FAutoSessionName;
	bool FUpdatingAutoSessionName;
	AnsiString FSessionName;
	int FSessionNumber;
	int FLockCount;
	bool FActive;
	bool FStreamedActive;
	bool FSQLHourGlass;
	Controls::TCursor FSQLWaitCursor;
	void __fastcall AddDatabase(TSDDatabase* Value);
	void __fastcall CheckInactive(void);
	void __fastcall ClearDBParams(void);
	TSDDatabase* __fastcall DoFindDatabase(const AnsiString DatabaseName, Classes::TComponent* AOwner);
		
	TSDDatabase* __fastcall DoOpenDatabase(const AnsiString DatabaseName, Classes::TComponent* AOwner);
		
	bool __fastcall GetActive(void);
	TSDDatabase* __fastcall GetDatabase(int Index);
	int __fastcall GetDatabaseCount(void);
	void __fastcall LockSession(void);
	void __fastcall MakeCurrent(void);
	void __fastcall RemoveDatabase(TSDDatabase* Value);
	bool __fastcall SessionNameStored(void);
	void __fastcall SetActive(bool Value);
	void __fastcall SetAutoSessionName(bool Value);
	void __fastcall SetSessionName(const AnsiString Value);
	void __fastcall SetSessionNames(void);
	void __fastcall StartSession(bool Value);
	void __fastcall UnlockSession(void);
	void __fastcall InternalAddDatabase(const AnsiString ARemoteDatabase, TSDServerType AServerType, Classes::TStrings* 
		List);
	void __fastcall UpdateAutoSessionName(void);
	void __fastcall ValidateAutoSession(Classes::TComponent* AOwner, bool AllSessions);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall SetName(const AnsiString NewName);
	
public:
	__fastcall virtual TSDSession(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDSession(void);
	void __fastcall Close(void);
	void __fastcall CloseDatabase(TSDDatabase* Database);
	TSDDatabase* __fastcall FindDatabase(const AnsiString DatabaseName);
	void __fastcall GetDatabaseNames(Classes::TStrings* List);
	void __fastcall GetDatabaseParams(const AnsiString ARemoteDatabase, TSDServerType AServerType, Classes::TStrings* 
		List);
	void __fastcall GetStoredProcNames(const AnsiString DatabaseName, Classes::TStrings* List);
	void __fastcall GetFieldNames(const AnsiString DatabaseName, const AnsiString TableName, Classes::TStrings* 
		List);
	void __fastcall GetTableNames(const AnsiString DatabaseName, const AnsiString Pattern, bool SystemTables
		, Classes::TStrings* List);
	void __fastcall Open(void);
	TSDDatabase* __fastcall OpenDatabase(const AnsiString DatabaseName);
	__property int DatabaseCount = {read=GetDatabaseCount, nodefault};
	__property TSDDatabase* Databases[int Index] = {read=GetDatabase};
	__property Controls::TCursor SQLWaitCursor = {read=FSQLWaitCursor, write=FSQLWaitCursor, nodefault}
		;
	
__published:
	__property bool Active = {read=GetActive, write=SetActive, default=0};
	__property bool AutoSessionName = {read=FAutoSessionName, write=SetAutoSessionName, default=0};
	__property bool KeepConnections = {read=FKeepConnections, write=FKeepConnections, default=1};
	__property AnsiString SessionName = {read=FSessionName, write=SetSessionName, stored=SessionNameStored
		};
	__property bool SQLHourGlass = {read=FSQLHourGlass, write=FSQLHourGlass, default=1};
};


#pragma option push -b
enum TSDTransIsolation { tiDirtyRead, tiReadCommitted, tiRepeatableRead };
#pragma option pop

#pragma option push -b
enum TSDDesignDBOption { ddoIsDefaultDatabase, ddoStoreConnected };
#pragma option pop

typedef Set<TSDDesignDBOption, ddoIsDefaultDatabase, ddoStoreConnected>  TSDDesignDBOptions;

typedef void __fastcall (__closure *TSDLoginEvent)(TSDDatabase* Database, Classes::TStrings* LoginParams
	);

class DELPHICLASS TSDCustomDatabase;
class PASCALIMPLEMENTATION TSDCustomDatabase : public Db::TCustomConnection 
{
	typedef Db::TCustomConnection inherited;
	
public:
	#pragma option push -w-inl
	/* TCustomConnection.Create */ inline __fastcall virtual TSDCustomDatabase(Classes::TComponent* AOwner
		) : Db::TCustomConnection(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomConnection.Destroy */ inline __fastcall virtual ~TSDCustomDatabase(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSDThreadTimer;
class PASCALIMPLEMENTATION TSDThreadTimer : public Classes::TThread 
{
	typedef Classes::TThread inherited;
	
private:
	TSDDatabase* FDatabase;
	int FInterval;
	Classes::TNotifyEvent FOnTimer;
	void __fastcall SetInterval(int Value);
	void __fastcall SetOnTimer(Classes::TNotifyEvent Value);
	
protected:
	DYNAMIC void __fastcall Timer(void);
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TSDThreadTimer(TSDDatabase* ADatabase, bool CreateSuspended);
	__fastcall virtual ~TSDThreadTimer(void);
	__property int Interval = {read=FInterval, write=SetInterval, default=1000};
	__property Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=SetOnTimer};
};


class DELPHICLASS TSDDataSet;
class PASCALIMPLEMENTATION TSDDatabase : public TSDCustomDatabase 
{
	typedef TSDCustomDatabase inherited;
	
private:
	TSDTransIsolation FTransIsolation;
	bool FKeepConnection;
	bool FTemporary;
	bool FAcquiredHandle;
	Classes::TStrings* FParams;
	int FRefCount;
	TSDSession* FSession;
	AnsiString FSessionName;
	AnsiString FDatabaseName;
	AnsiString FRemoteDatabase;
	TSDServerType FServerType;
	Sdcommon::TISqlDatabase* FSqlDatabase;
	TSDDesignDBOptions FDesignOptions;
	int FIdleTimeOut;
	TSDThreadTimer* FTimer;
	bool FIdleTimeoutStarted;
	bool FIsConnectionBusy;
	int FClientVersion;
	int FServerVersion;
	AnsiString FVersion;
	TSDLoginEvent FOnLogin;
	void __fastcall CheckActive(void);
	void __fastcall CheckInactive(void);
	void __fastcall CheckInTransaction(void);
	void __fastcall CheckNotInTransaction(void);
	void __fastcall CheckDatabaseName(void);
	void __fastcall CheckRemoteDatabase(AnsiString &Password);
	void __fastcall CheckSessionName(bool Required);
	bool __fastcall ConnectedStored(void);
	void * __fastcall GetHandle(void);
	int __fastcall GetIdleTimeOut(void);
	bool __fastcall GetIsSQLBased(void);
	bool __fastcall GetInTransaction(void);
	AnsiString __fastcall GetVersion(void);
	Word __fastcall GetServerMajor(void);
	Word __fastcall GetServerMinor(void);
	Word __fastcall GetClientMajor(void);
	Word __fastcall GetClientMinor(void);
	void __fastcall IdleTimerHandler(System::TObject* Sender);
	void __fastcall Login(Classes::TStrings* LoginParams);
	void __fastcall BusyStateReset(System::TObject* Sender);
	void __fastcall IdleTimeOutReset(System::TObject* Sender);
	void __fastcall ResetServerInfo(void);
	void __fastcall SetDatabaseName(const AnsiString Value);
	void __fastcall SetDesignOptions(TSDDesignDBOptions Value);
	void __fastcall SetHandle(void * Value);
	void __fastcall SetIdleTimeOut(int Value);
	void __fastcall SetKeepConnection(bool Value);
	void __fastcall SetParams(Classes::TStrings* Value);
	void __fastcall SetRemoteDatabase(const AnsiString Value);
	void __fastcall SetServerType(TSDServerType Value);
	void __fastcall SetSessionName(const AnsiString Value);
	void __fastcall SetTransIsolation(TSDTransIsolation Value);
	void __fastcall UpdateTimer(int NewTimeout);
	
protected:
	__property Sdcommon::TISqlDatabase* SqlDatabase = {read=FSqlDatabase};
	__property bool AcquiredHandle = {read=FAcquiredHandle, nodefault};
	void __fastcall InitSqlDatabase(const AnsiString ADatabaseName, const AnsiString AUserName, const AnsiString 
		APassword, void * AHandle);
	void __fastcall DoneSqlDatabase(void);
	void __fastcall InternalClose(bool Force);
	void __fastcall ISqlGetStoredProcNames(Classes::TStrings* List);
	void __fastcall ISqlGetTableNames(AnsiString Pattern, bool SystemTables, Classes::TStrings* List);
	void __fastcall ISqlGetFieldNames(const AnsiString TableName, Classes::TStrings* List);
	int __fastcall ISqlParamValue(Sdcommon::TSDDatabaseParam Value);
	virtual void __fastcall DoConnect(void);
	virtual void __fastcall DoDisconnect(void);
	virtual bool __fastcall GetConnected(void);
	virtual Db::TDataSet* __fastcall GetDataSet(int Index);
	virtual TSDDataSet* __fastcall GetSDDataSet(int Index);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall RegisterClient(System::TObject* Client, Db::TConnectChangeEvent Event);
	virtual void __fastcall UnRegisterClient(System::TObject* Client);
	
public:
	__fastcall virtual TSDDatabase(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDDatabase(void);
	void __fastcall ApplyUpdates(TSDDataSet* const * DataSets, const int DataSets_Size);
	void __fastcall CloseDataSets(void);
	void __fastcall Commit(void);
	void __fastcall ForceClose(void);
	void __fastcall GetFieldNames(const AnsiString TableName, Classes::TStrings* List);
	void __fastcall GetTableNames(const AnsiString Pattern, bool SystemTables, Classes::TStrings* List)
		;
	Db::TDataSet* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString AObjectName)
		;
	void __fastcall Rollback(void);
	void __fastcall StartTransaction(void);
	bool __fastcall TestConnected(void);
	void __fastcall ValidateName(const AnsiString Name);
	__property TSDDataSet* DataSets[int Index] = {read=GetSDDataSet};
	__property void * Handle = {read=GetHandle, write=SetHandle};
	__property bool InTransaction = {read=GetInTransaction, nodefault};
	__property bool IsSQLBased = {read=GetIsSQLBased, nodefault};
	__property TSDSession* Session = {read=FSession};
	__property bool Temporary = {read=FTemporary, write=FTemporary, nodefault};
	__property Word ClientMajor = {read=GetClientMajor, nodefault};
	__property Word ClientMinor = {read=GetClientMinor, nodefault};
	__property Word ServerMajor = {read=GetServerMajor, nodefault};
	__property Word ServerMinor = {read=GetServerMinor, nodefault};
	__property AnsiString Version = {read=GetVersion};
	
__published:
	__property Connected  = {stored=ConnectedStored, default=0};
	__property LoginPrompt ;
	__property AnsiString DatabaseName = {read=FDatabaseName, write=SetDatabaseName};
	__property TSDDesignDBOptions DesignOptions = {read=FDesignOptions, write=SetDesignOptions, default=2
		};
	__property int IdleTimeOut = {read=GetIdleTimeOut, write=SetIdleTimeOut, nodefault};
	__property bool KeepConnection = {read=FKeepConnection, write=SetKeepConnection, default=1};
	__property Classes::TStrings* Params = {read=FParams, write=SetParams};
	__property AnsiString RemoteDatabase = {read=FRemoteDatabase, write=SetRemoteDatabase};
	__property TSDServerType ServerType = {read=FServerType, write=SetServerType, default=0};
	__property AnsiString SessionName = {read=FSessionName, write=SetSessionName};
	__property TSDTransIsolation TransIsolation = {read=FTransIsolation, write=SetTransIsolation, default=1
		};
	__property AfterConnect ;
	__property AfterDisconnect ;
	__property BeforeConnect ;
	__property BeforeDisconnect ;
	__property TSDLoginEvent OnLogin = {read=FOnLogin, write=FOnLogin};
};


struct TCacheRecInfo;
typedef TCacheRecInfo *PCacheRecInfo;

struct TCacheRecInfo
{
	bool Applied;
	char *CurRec;
	char *OldRec;
} ;

class DELPHICLASS TSDResultSet;
class PASCALIMPLEMENTATION TSDResultSet : public Classes::TList 
{
	typedef Classes::TList inherited;
	
private:
	TSDDataSet* FDataSet;
	bool FIsBlobs;
	int FPosition;
	int FDeletedCount;
	bool FAllInCache;
	bool __fastcall GetAppliedRecords(int Index);
	TCacheRecInfo __fastcall GetCacheItem(int Index);
	char * __fastcall GetCurRecords(int Index);
	char * __fastcall GetOldRecords(int Index);
	Db::TUpdateStatus __fastcall GetUpdateStatusRecords(int Index);
	bool __fastcall GetFilterActivated(void);
	int __fastcall GetRecordCount(void);
	int __fastcall GetIndexOfRecord(int ARecNumber);
	int __fastcall GetNewRecordNumber(int AInsertedRecIndex);
	void __fastcall SetAppliedRecords(int Index, bool Value);
	void __fastcall SetCacheItem(int Index, const TCacheRecInfo &Value);
	void __fastcall SetCurRecords(int Index, char * Value);
	void __fastcall SetOldRecords(int Index, char * Value);
	void __fastcall SetUpdateStatusRecords(int Index, Db::TUpdateStatus Value);
	int __fastcall AddRecord(char * RecBuf);
	void __fastcall CopyRecBuf(const char * Source, const char * Dest);
	void __fastcall ClearCacheItem(int Index);
	void __fastcall DeleteCacheItem(int Index);
	bool __fastcall FetchRecord(void);
	bool __fastcall GetCurrRecord(void);
	bool __fastcall GetNextRecord(void);
	bool __fastcall GetPriorRecord(void);
	bool __fastcall GetRecord(char * Buffer, Db::TGetMode GetMode);
	bool __fastcall GotoNextRecord(void);
	bool __fastcall IsVisibleRecord(int Index);
	int __fastcall DeleteRecord(char * RecBuf);
	bool __fastcall IsInsertedRecord(int Index);
	int __fastcall InsertRecord(char * RecBuf, bool Append, bool SetCurrent);
	void __fastcall ModifyRecord(char * RecBuf);
	void __fastcall ModifyBlobData(Db::TField* Field, char * RecBuf, const Sdcommon::TBytes Value);
	bool __fastcall RecordFilter(char * RecBuf);
	int __fastcall UpdatesCancel(void);
	int __fastcall UpdatesCancelCurrent(void);
	int __fastcall UpdatesCommit(void);
	int __fastcall UpdatesPrepare(void);
	int __fastcall UpdatesRollback(void);
	
public:
	__fastcall TSDResultSet(TSDDataSet* ADataSet, bool IsBlobs);
	__fastcall virtual ~TSDResultSet(void);
	virtual void __fastcall Clear(void);
	bool __fastcall UpdatesCommitRecord(int Index);
	void __fastcall ExchangeRecords(int Index1, int Index2);
	void __fastcall FetchAll(void);
	bool __fastcall FindNextRecord(void);
	bool __fastcall FindPriorRecord(void);
	void __fastcall SetToBegin(void);
	void __fastcall SetToEnd(void);
	int __fastcall IndexOfRecord(char * RecBuf);
	__property bool AllInCache = {read=FAllInCache, nodefault};
	__property bool AppliedRecords[int Index] = {read=GetAppliedRecords, write=SetAppliedRecords};
	__property TCacheRecInfo CacheItems[int Index] = {read=GetCacheItem, write=SetCacheItem};
	__property char * CurRecords[int Index] = {read=GetCurRecords, write=SetCurRecords/*, default*/};
	__property char * OldRecords[int Index] = {read=GetOldRecords, write=SetOldRecords};
	__property TSDDataSet* DataSet = {read=FDataSet};
	__property Db::TUpdateStatus UpdateStatusRecords[int Index] = {read=GetUpdateStatusRecords, write=SetUpdateStatusRecords
		};
	__property int CurrentIndex = {read=FPosition, write=FPosition, nodefault};
	__property int RecordCount = {read=GetRecordCount, nodefault};
	__property bool FilterActivated = {read=GetFilterActivated, nodefault};
};


#pragma pack(push, 1)
struct TSDRecInfo
{
	int RecordNumber;
	Db::TUpdateStatus UpdateStatus;
	Db::TBookmarkFlag BookmarkFlag;
} ;
#pragma pack(pop)

typedef TSDRecInfo *PSDRecInfo;

typedef bool TFieldIsNotNull;

typedef bool *PFieldIsNotNull;

#pragma option push -b
enum TDelayedUpdCmd { DelayedUpdCommit, DelayedUpdCancel, DelayedUpdCancelCurrent, DelayedUpdPrepare, 
	DelayedUpdRollback };
#pragma option pop

typedef Set<Shortint, 0, 15>  TDSFlags;

typedef Set<Db::TUpdateKind, ukModify, ukDelete>  TUpdateKinds;

#pragma option push -b
enum SDEngine__8 { rtModified, rtInserted, rtDeleted, rtUnmodified };
#pragma option pop

typedef Set<SDEngine__8, rtModified, rtUnmodified>  TUpdateRecordTypes;

typedef void __fastcall (__closure *TUpdateErrorEvent)(Db::TDataSet* DataSet, Db::EDatabaseError* E, 
	Db::TUpdateKind UpdateKind, Db::TUpdateAction &UpdateAction);

typedef void __fastcall (__closure *TUpdateRecordEvent)(Db::TDataSet* DataSet, Db::TUpdateKind UpdateKind
	, Db::TUpdateAction &UpdateAction);

class DELPHICLASS TSDDataSetUpdateObject;
class PASCALIMPLEMENTATION TSDDataSetUpdateObject : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	virtual TSDDataSet* __fastcall GetDataSet(void) = 0 ;
	virtual void __fastcall SetDataSet(TSDDataSet* ADataSet) = 0 ;
	
public:
	virtual void __fastcall Apply(Db::TUpdateKind UpdateKind) = 0 ;
	__property TSDDataSet* DataSet = {read=GetDataSet, write=SetDataSet};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TSDDataSetUpdateObject(Classes::TComponent* AOwner
		) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TSDDataSetUpdateObject(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TSDDataSet : public Db::TDataSet 
{
	typedef Db::TDataSet inherited;
	
private:
	bool FAutoRefresh;
	TDSFlags FDSFlags;
	TSDDatabase* FDatabase;
	AnsiString FDatabaseName;
	AnsiString FSessionName;
	Sdcommon::TISqlCommand* FSqlCmd;
	TSDResultSet* FRecCache;
	DynamicArray<int >  FFieldBufOffs;
	bool FClearFieldDefsOnClose;
	bool FCachedUpdates;
	bool FCacheBlobs;
	bool FUniDirectional;
	bool FDetachOnFetchAll;
	char *FFilterBuffer;
	bool FForceClosing;
	bool FGetNextResultSet;
	int FRecordSize;
	int FRecBufSize;
	int FBlobCacheOffs;
	int FRecInfoOffs;
	int FBookmarkOffs;
	TUpdateKinds FEnableUpdateKinds;
	Db::TUpdateMode FUpdateMode;
	TSDDataSetUpdateObject* FUpdateObject;
	TUpdateRecordTypes FUpdateRecordTypes;
	TUpdateErrorEvent FOnUpdateError;
	TUpdateRecordEvent FOnUpdateRecord;
	void __fastcall CheckDBSessionName(void);
	void __fastcall ClearBlobCache(char * RecBuf);
	HIDESBASE void __fastcall DoInternalOpen(bool IsExec);
	void __fastcall InitBlobCache(char * RecBuf);
	bool __fastcall FieldIsNull(void * FieldBuf);
	void __fastcall FieldSetNull(void * FieldBuf, bool bNull);
	bool __fastcall GetActiveRecBuf(char * &RecBuf);
	Sdcommon::TBytes __fastcall GetBlobData(Db::TField* Field, char * Buffer);
	int __fastcall GetBlobDataSize(Db::TField* Field, char * Buffer);
	void * __fastcall GetHandle(void);
	char * __fastcall GetOldRecord(void);
	TSDServerType __fastcall GetServerType(void);
	TSDSession* __fastcall GetDBSession(void);
	TUpdateKinds __fastcall GetEnableUpdateKinds(void);
	bool __fastcall GetUpdatesPending(void);
	TUpdateRecordTypes __fastcall GetUpdateRecordSet(void);
	void __fastcall InitBufferPointers(void);
	bool __fastcall RecordFilter(char * RecBuf);
	void __fastcall SetAutoRefresh(const bool Value);
	void __fastcall SetBlobData(Db::TField* Field, char * Buffer, Sdcommon::TBytes Value);
	void __fastcall SetDatabaseName(const AnsiString Value);
	void __fastcall SetDetachOnFetchAll(bool Value);
	void __fastcall SetSessionName(const AnsiString Value);
	void __fastcall SetEnableUpdateKinds(TUpdateKinds Value);
	void __fastcall SetUniDirectional(const bool Value);
	virtual void __fastcall SetUpdateMode(const Db::TUpdateMode Value);
	void __fastcall SetUpdateRecordSet(TUpdateRecordTypes RecordTypes);
	void __fastcall SetUpdateObject(TSDDataSetUpdateObject* Value);
	
protected:
	__property TSDResultSet* RecCache = {read=FRecCache};
	__property Sdcommon::TISqlCommand* SqlCmd = {read=FSqlCmd};
	virtual Sdcommon::TISqlCommand* __fastcall ISqlCmdCreate(void);
	void __fastcall ISqlCloseResultSet(void);
	void __fastcall ISqlCnvtFieldData(Sdcommon::TISqlCommand* ASqlCmd, Sdcommon::TSDFieldDesc* AFieldDesc
		, char * Buffer, Db::TField* AField);
	void __fastcall ISqlCnvtFieldsBuffer(char * Buffer);
	bool __fastcall ISqlConnected(void);
	void __fastcall ISqlDetach(void);
	void __fastcall ISqlExecDirect(AnsiString Value);
	void __fastcall ISqlExecute(void);
	bool __fastcall ISqlFetch(void);
	void __fastcall ISqlInitFieldDefs(void);
	void __fastcall ISqlPrepare(AnsiString Value);
	bool __fastcall ISqlPrepared(void);
	int __fastcall ISqlGetRowsAffected(void);
	int __fastcall ISqlWriteBlob(int FieldNo, const char * Buffer, int Count);
	int __fastcall ISqlWriteBlobByName(AnsiString Name, const char * Buffer, int Count);
	
private:
	void __fastcall CacheInit(void);
	void __fastcall CacheDone(void);
	char * __fastcall CacheTempBuffer(void);
	
protected:
	Sdcommon::TSDExprParser* FExprFilter;
	Sdcommon::TSDExprParser* __fastcall CreateExprFilter(const AnsiString Text, Db::TFilterOptions Options
		);
	virtual void __fastcall PSEndTransaction(bool Commit);
	virtual int __fastcall PSExecuteStatement(const AnsiString ASQL, Db::TParams* AParams, void * ResultSet
		);
	virtual AnsiString __fastcall PSGetQuoteChar(void);
	virtual Db::EUpdateError* __fastcall PSGetUpdateException(Sysutils::Exception* E, Db::EUpdateError* 
		Prev);
	virtual bool __fastcall PSInTransaction(void);
	virtual bool __fastcall PSIsSQLBased(void);
	virtual bool __fastcall PSIsSQLSupported(void);
	virtual void __fastcall PSReset(void);
	virtual void __fastcall PSStartTransaction(void);
	virtual bool __fastcall PSUpdateRecord(Db::TUpdateKind UpdateKind, Db::TDataSet* Delta);
	virtual char * __fastcall AllocRecordBuffer(void);
	void __fastcall DestroySqlCommand(bool Force);
	void __fastcall ForceClose(void);
	virtual void __fastcall FreeRecordBuffer(char * &Buffer);
	void __fastcall CheckCachedUpdateMode(void);
	HIDESBASE void __fastcall CheckCanModify(void);
	void __fastcall CheckDatabaseName(void);
	virtual void __fastcall ClearCalcFields(char * Buffer);
	virtual void __fastcall CloseCursor(void);
	void __fastcall ClearFieldDefs(void);
	virtual void __fastcall CreateHandle(void) = 0 ;
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	virtual void __fastcall DestroyHandle(void);
	virtual bool __fastcall FindRecord(bool Restart, bool GoForward);
	virtual void __fastcall GetBookmarkData(char * Buffer, void * Data);
	virtual Db::TBookmarkFlag __fastcall GetBookmarkFlag(char * Buffer);
	int __fastcall GetBufferCount(void);
	virtual bool __fastcall GetCanModify(void);
	char * __fastcall GetFieldBuffer(int AFieldNo, char * RecBuf);
	int __fastcall GetFieldDataSize(Db::TField* Field);
	virtual int __fastcall GetRecNo(void);
	virtual Db::TGetResult __fastcall GetRecord(char * Buffer, Db::TGetMode GetMode, bool DoCheck);
	virtual int __fastcall GetRecordCount(void);
	virtual Word __fastcall GetRecordSize(void);
	Db::TUpdateStatus __fastcall GetRecordUpdateStatus(void);
	void __fastcall SetRecordUpdateStatus(Db::TUpdateStatus Value);
	virtual void __fastcall InitRecord(char * Buffer);
	void __fastcall InitResultSet(void);
	virtual void __fastcall InternalAddRecord(void * Buffer, bool Append);
	virtual void __fastcall InternalClose(void);
	virtual void __fastcall InternalDelete(void);
	virtual void __fastcall InternalFirst(void);
	virtual void __fastcall InternalGotoBookmark(void * Bookmark);
	virtual void __fastcall InternalHandleException(void);
	virtual void __fastcall InternalInitFieldDefs(void);
	virtual void __fastcall InternalInitRecord(char * Buffer);
	virtual void __fastcall InternalLast(void);
	virtual void __fastcall InternalOpen(void);
	virtual void __fastcall InternalPost(void);
	virtual void __fastcall InternalRefresh(void);
	virtual void __fastcall InternalSetToRecord(char * Buffer);
	virtual bool __fastcall IsCursorOpen(void);
	void __fastcall DoneResultSet(void);
	int __fastcall DoLocateRecord(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions 
		Options, bool SyncCursor, bool NextLocate);
	virtual void __fastcall DoRefreshRecord(const AnsiString ARefreshSQL);
	virtual void __fastcall DoSortRecords(const int * AFields, const int AFields_Size, const bool * AscOrder
		, const int AscOrder_Size, const bool * CaseSensitive, const int CaseSensitive_Size);
	void __fastcall LiveApplyRecord(Db::TUpdateStatus OpMode, const AnsiString ASQL, const AnsiString ATableName
		, const AnsiString ARefreshSQL);
	void __fastcall LiveInternalPost(bool IsDelete, const AnsiString ASQL, const AnsiString ATableName)
		;
	bool __fastcall MapsToIndex(Classes::TList* Fields, bool CaseInsensitive);
	void __fastcall SetConnectionState(bool IsBusy);
	virtual void __fastcall SetBookmarkData(char * Buffer, void * Data);
	virtual void __fastcall SetBookmarkFlag(char * Buffer, Db::TBookmarkFlag Value);
	virtual void __fastcall BlockReadNext(void);
	virtual void __fastcall SetBlockReadSize(int Value);
	virtual void __fastcall SetFieldData(Db::TField* Field, void * Buffer)/* overload */;
	void __fastcall SetFilterData(const AnsiString Text, Db::TFilterOptions Options);
	virtual void __fastcall SetFiltered(bool Value);
	virtual void __fastcall SetFilterOptions(Db::TFilterOptions Value);
	virtual void __fastcall SetFilterText(const AnsiString Value);
	virtual void __fastcall SetRecNo(int Value);
	virtual void __fastcall OpenCursor(bool InfoQuery);
	virtual void __fastcall ExecuteCursor(void);
	int __fastcall ProcessUpdates(TDelayedUpdCmd UpdCmd);
	virtual bool __fastcall SetDSFlag(int Flag, bool Value);
	virtual void __fastcall SetOnFilterRecord(const Db::TFilterRecordEvent Value);
	__property bool CachedUpdates = {read=FCachedUpdates, write=FCachedUpdates, nodefault};
	__property TDSFlags DSFlags = {read=FDSFlags, nodefault};
	__property TSDServerType ServerType = {read=GetServerType, nodefault};
	__property Db::TUpdateMode UpdateMode = {read=FUpdateMode, write=SetUpdateMode, default=0};
	
public:
	__fastcall virtual TSDDataSet(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDDataSet(void);
	virtual void __fastcall Disconnect(void);
	void __fastcall ApplyUpdates(void);
	void __fastcall CancelUpdates(void);
	void __fastcall CommitUpdates(void);
	void __fastcall RollbackUpdates(void);
	virtual bool __fastcall BookmarkValid(void * Bookmark);
	virtual int __fastcall CompareBookmarks(void * Bookmark1, void * Bookmark2);
	virtual Classes::TStream* __fastcall CreateBlobStream(Db::TField* Field, Db::TBlobStreamMode Mode);
		
	void __fastcall Detach(void);
	void __fastcall FetchAll(void);
	void __fastcall OpenEmpty(void);
	TSDDatabase* __fastcall OpenDatabase(void);
	void __fastcall CloseDatabase(TSDDatabase* Database);
	void __fastcall GetFieldInfoFromSQL(const AnsiString ASQL, Classes::TStrings* FldInfo, Classes::TStrings* 
		TblInfo);
	virtual bool __fastcall GetCurrentRecord(char * Buffer);
	virtual bool __fastcall GetFieldData(Db::TField* Field, void * Buffer)/* overload */;
	virtual bool __fastcall IsSequenced(void);
	virtual bool __fastcall Locate(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions 
		Options);
	bool __fastcall LocateNext(const AnsiString KeyFields, const Variant &KeyValues, Db::TLocateOptions 
		Options);
	virtual Variant __fastcall Lookup(const AnsiString KeyFields, const Variant &KeyValues, const AnsiString 
		ResultFields);
	virtual void __fastcall RefreshRecord(void);
	virtual void __fastcall RefreshRecordEx(const AnsiString ARefreshSQL);
	void __fastcall RevertRecord(void);
	void __fastcall SortRecords(const System::TVarRec * AFields, const int AFields_Size, const bool * AscOrder
		, const int AscOrder_Size, const bool * ACaseSensitive, const int ACaseSensitive_Size)/* overload */
		;
	void __fastcall SortRecords(const AnsiString AFields, const AnsiString AscOrder, const AnsiString ACaseSensitive
		)/* overload */;
	virtual Db::TUpdateStatus __fastcall UpdateStatus(void);
	__property bool CacheBlobs = {read=FCacheBlobs, write=FCacheBlobs, default=1};
	__property TSDDatabase* Database = {read=FDatabase};
	__property TSDSession* DBSession = {read=GetDBSession};
	__property TUpdateKinds EnableUpdateKinds = {read=GetEnableUpdateKinds, write=SetEnableUpdateKinds, 
		nodefault};
	__property void * Handle = {read=GetHandle};
	__property bool UniDirectional = {read=FUniDirectional, write=SetUniDirectional, default=0};
	__property TSDDataSetUpdateObject* UpdateObject = {read=FUpdateObject, write=SetUpdateObject};
	__property bool UpdatesPending = {read=GetUpdatesPending, nodefault};
	__property TUpdateRecordTypes UpdateRecordTypes = {read=GetUpdateRecordSet, write=SetUpdateRecordSet
		, nodefault};
	
__published:
	__property bool AutoRefresh = {read=FAutoRefresh, write=SetAutoRefresh, default=0};
	__property AnsiString DatabaseName = {read=FDatabaseName, write=SetDatabaseName};
	__property bool DetachOnFetchAll = {read=FDetachOnFetchAll, write=SetDetachOnFetchAll, default=0};
	__property AnsiString SessionName = {read=FSessionName, write=SetSessionName};
	__property TUpdateErrorEvent OnUpdateError = {read=FOnUpdateError, write=FOnUpdateError};
	__property TUpdateRecordEvent OnUpdateRecord = {read=FOnUpdateRecord, write=FOnUpdateRecord};
	__property Active ;
	__property AutoCalcFields ;
	__property Filter ;
	__property Filtered ;
	__property FilterOptions ;
	__property BeforeOpen ;
	__property AfterOpen ;
	__property BeforeClose ;
	__property AfterClose ;
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
	__property BeforeScroll ;
	__property AfterScroll ;
	__property OnCalcFields ;
	__property OnDeleteError ;
	__property OnEditError ;
	__property OnFilterRecord ;
	__property OnNewRecord ;
	__property OnPostError ;
};


class DELPHICLASS TSDQuery;
class PASCALIMPLEMENTATION TSDQuery : public TSDDataSet 
{
	typedef TSDDataSet inherited;
	
private:
	Db::TDataLink* FDataLink;
	Db::TParams* FParams;
	bool FPrepared;
	bool FExecCmd;
	Classes::TStrings* FSQL;
	AnsiString FText;
	bool FParamCheck;
	int FRowsAffected;
	bool FRequestLive;
	AnsiString FTableName;
	Classes::TStrings* FIndexFields;
	int __fastcall GetRowsAffected(void);
	void __fastcall QueryChanged(System::TObject* Sender);
	void __fastcall ReleaseHandle(bool SaveRes);
	void __fastcall RefreshParams(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetParamsFromCursor(void);
	void __fastcall SetParamsList(Db::TParams* Value);
	void __fastcall SetPrepareCmd(bool Value, bool GenCursor);
	void __fastcall SetPrepared(bool Value);
	void __fastcall SetRequestLive(bool Value);
	virtual void __fastcall SetUpdateMode(const Db::TUpdateMode Value);
	void __fastcall ReadParamData(Classes::TReader* Reader);
	void __fastcall WriteParamData(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual Sdcommon::TISqlCommand* __fastcall ISqlCmdCreate(void);
	virtual void __fastcall PSExecute(void);
	virtual Db::TParams* __fastcall PSGetParams(void);
	virtual AnsiString __fastcall PSGetTableName(void);
	virtual void __fastcall PSSetCommandText(const AnsiString CommandText);
	virtual void __fastcall PSSetParams(Db::TParams* AParams);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DoBeforeOpen(void);
	virtual bool __fastcall GetCanModify(void);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	virtual bool __fastcall GetIsIndexField(Db::TField* Field);
	Word __fastcall GetParamsCount(void);
	virtual void __fastcall InternalDelete(void);
	virtual void __fastcall InternalOpen(void);
	virtual void __fastcall InternalPost(void);
	bool __fastcall IsExecDirect(void);
	virtual void __fastcall ExecuteCursor(void);
	virtual bool __fastcall SetDSFlag(int Flag, bool Value);
	virtual void __fastcall SetQuery(Classes::TStrings* Value);
	void __fastcall UpdateUniqueIndexInfo(void);
	void __fastcall SetSqlCmd(Sdcommon::TISqlCommand* Value);
	
public:
	__fastcall virtual TSDQuery(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDQuery(void);
	virtual void __fastcall Disconnect(void);
	void __fastcall ExecSQL(void);
	virtual void __fastcall GetDetailLinkFields(Classes::TList* MasterFields, Classes::TList* DetailFields
		);
	Db::TParam* __fastcall ParamByName(const AnsiString Value);
	void __fastcall Prepare(void);
	void __fastcall UnPrepare(void);
	virtual void __fastcall RefreshRecord(void);
	__property bool Prepared = {read=FPrepared, write=SetPrepared, nodefault};
	__property Word ParamCount = {read=GetParamsCount, nodefault};
	__property AnsiString Text = {read=FText};
	__property int RowsAffected = {read=GetRowsAffected, nodefault};
	
__published:
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ParamCheck = {read=FParamCheck, write=FParamCheck, default=1};
	__property Db::TParams* Params = {read=FParams, write=SetParamsList, stored=false};
	__property bool RequestLive = {read=FRequestLive, write=SetRequestLive, default=0};
	__property Classes::TStrings* SQL = {read=FSQL, write=SetQuery};
	__property UniDirectional ;
	__property UpdateMode ;
	__property UpdateObject ;
};


class DELPHICLASS TSDMacroQuery;
class PASCALIMPLEMENTATION TSDMacroQuery : public TSDQuery 
{
	typedef TSDQuery inherited;
	
private:
	char FMacroChar;
	Db::TParams* FMacros;
	bool FMacrosExpanding;
	Classes::TStrings* FSQLPattern;
	Classes::TNotifyEvent FSaveQueryChanged;
	Db::TParams* __fastcall GetMacros(void);
	Word __fastcall GetMacroCount(void);
	void __fastcall PatternChanged(System::TObject* Sender);
	HIDESBASE void __fastcall QueryChanged(System::TObject* Sender);
	void __fastcall CreateMacros(void);
	void __fastcall SetMacroChar(const char Value);
	void __fastcall SetMacros(const Db::TParams* Value);
	void __fastcall ReadMacroData(Classes::TReader* Reader);
	void __fastcall WriteMacroData(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual bool __fastcall SetDSFlag(int Flag, bool Value);
	virtual void __fastcall SetQuery(Classes::TStrings* Value);
	
public:
	__fastcall virtual TSDMacroQuery(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDMacroQuery(void);
	void __fastcall ExpandMacros(void);
	Db::TParam* __fastcall MacroByName(const AnsiString MacroName);
	
__published:
	__property char MacroChar = {read=FMacroChar, write=SetMacroChar, default=37};
	__property Word MacroCount = {read=GetMacroCount, nodefault};
	__property Db::TParams* Macros = {read=GetMacros, write=SetMacros, stored=false};
	__property Classes::TStrings* SQL = {read=FSQLPattern, write=SetQuery};
};


class DELPHICLASS TSDUpdateSQL;
class PASCALIMPLEMENTATION TSDUpdateSQL : public TSDDataSetUpdateObject 
{
	typedef TSDDataSetUpdateObject inherited;
	
private:
	TSDDataSet* FDataSet;
	TSDQuery* FQueries[4];
	Classes::TStrings* FSQLText[4];
	Classes::TStrings* __fastcall GetSQL(Db::TUpdateStatus StmtKind);
	Classes::TStrings* __fastcall GetSQLIndex(int Index);
	void __fastcall SetSQL(Db::TUpdateStatus StmtKind, Classes::TStrings* Value);
	void __fastcall SetSQLIndex(int Index, Classes::TStrings* Value);
	
protected:
	virtual TSDDataSet* __fastcall GetDataSet(void);
	TSDQuery* __fastcall GetQuery(Db::TUpdateKind UpdateKind);
	virtual TSDQuery* __fastcall GetQueryEx(Db::TUpdateStatus StmtKind);
	virtual void __fastcall SetDataSet(TSDDataSet* ADataSet);
	void __fastcall SQLChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TSDUpdateSQL(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDUpdateSQL(void);
	virtual void __fastcall Apply(Db::TUpdateKind UpdateKind);
	void __fastcall ExecSQL(Db::TUpdateKind UpdateKind);
	void __fastcall SetParams(Db::TUpdateKind UpdateKind);
	__property DataSet ;
	__property TSDQuery* Query[Db::TUpdateKind UpdateKind] = {read=GetQuery};
	__property Classes::TStrings* SQL[Db::TUpdateStatus StmtKind] = {read=GetSQL, write=SetSQL};
	__property TSDQuery* QueryEx[Db::TUpdateStatus StmtKind] = {read=GetQueryEx};
	
__published:
	__property Classes::TStrings* RefreshSQL = {read=GetSQLIndex, write=SetSQLIndex, index=0};
	__property Classes::TStrings* ModifySQL = {read=GetSQLIndex, write=SetSQLIndex, index=1};
	__property Classes::TStrings* InsertSQL = {read=GetSQLIndex, write=SetSQLIndex, index=2};
	__property Classes::TStrings* DeleteSQL = {read=GetSQLIndex, write=SetSQLIndex, index=3};
};


class DELPHICLASS TSDBlobStream;
class PASCALIMPLEMENTATION TSDBlobStream : public Classes::TStream 
{
	typedef Classes::TStream inherited;
	
private:
	Db::TBlobField* FField;
	TSDDataSet* FDataSet;
	char *FBuffer;
	Db::TBlobStreamMode FMode;
	int FFieldNo;
	bool FOpened;
	bool FModified;
	int FPosition;
	DynamicArray<Byte >  FBlobData;
	int FBlobSize;
	bool FCached;
	int FCacheSize;
	int __fastcall GetBlobSize(void);
	
protected:
	virtual void __fastcall SetSize(int NewSize);
	
public:
	__fastcall TSDBlobStream(Db::TBlobField* Field, Db::TBlobStreamMode Mode);
	__fastcall virtual ~TSDBlobStream(void);
	virtual int __fastcall Read(void *Buffer, int Count);
	virtual int __fastcall Write(const void *Buffer, int Count);
	virtual int __fastcall Seek(int Offset, Word Origin);
	void __fastcall Truncate(void);
};


class DELPHICLASS TSDStoredProc;
class PASCALIMPLEMENTATION TSDStoredProc : public TSDDataSet 
{
	typedef TSDDataSet inherited;
	
private:
	AnsiString FProcName;
	Db::TParams* FParams;
	Word FOverLoad;
	bool FPrepared;
	bool FQueryMode;
	bool FExecCmd;
	void __fastcall ReleaseHandle(bool SaveRes);
	void __fastcall SetParamsList(Db::TParams* Value);
	void __fastcall ReadParamData(Classes::TReader* Reader);
	void __fastcall WriteParamData(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall PSExecute(void);
	virtual AnsiString __fastcall PSGetTableName(void);
	virtual Db::TParams* __fastcall PSGetParams(void);
	virtual void __fastcall PSSetCommandText(const AnsiString CommandText);
	virtual void __fastcall PSSetParams(Db::TParams* AParams);
	void __fastcall BindParams(void);
	virtual void __fastcall CreateHandle(void);
	void __fastcall CreateParamDesc(void);
	virtual void __fastcall CloseCursor(void);
	virtual void __fastcall ExecuteCursor(void);
	virtual void __fastcall InternalOpen(void);
	bool __fastcall IsExecDirect(void);
	Word __fastcall GetParamsCount(void);
	virtual bool __fastcall SetDSFlag(int Flag, bool Value);
	void __fastcall SetOverLoad(Word Value);
	void __fastcall SetProcName(const AnsiString Value);
	void __fastcall SetPrepared(bool Value);
	void __fastcall SetPrepareCmd(bool Value, bool GenCursor);
	virtual Sdcommon::TISqlCommand* __fastcall ISqlCmdCreate(void);
	bool __fastcall ISqlDescriptionsAvailable(void);
	bool __fastcall ISqlNextResultSet(void);
	void __fastcall ISqlPrepareProc(void);
	void __fastcall ISqlExecProc(void);
	void __fastcall ISqlExecProcDirect(void);
	void __fastcall ISqlGetResults(void);
	
public:
	__fastcall virtual TSDStoredProc(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDStoredProc(void);
	virtual void __fastcall Disconnect(void);
	void __fastcall CopyParams(Db::TParams* Value);
	bool __fastcall DescriptionsAvailable(void);
	void __fastcall ExecProc(void);
	void __fastcall GetResults(void);
	bool __fastcall NextResultSet(void);
	Db::TParam* __fastcall ParamByName(const AnsiString Value);
	void __fastcall Prepare(void);
	void __fastcall UnPrepare(void);
	__property Word ParamCount = {read=GetParamsCount, nodefault};
	__property bool Prepared = {read=FPrepared, write=SetPrepared, nodefault};
	
__published:
	__property AnsiString StoredProcName = {read=FProcName, write=SetProcName};
	__property Word Overload = {read=FOverLoad, write=SetOverLoad, default=0};
	__property Db::TParams* Params = {read=FParams, write=SetParamsList, stored=false};
	__property UpdateObject ;
};


struct TIndexDesc
{
	AnsiString Name;
	AnsiString Fields;
	AnsiString DescFields;
	Word iFldsInKey;
	Word bPrimary;
	Word bUnique;
} ;

typedef DynamicArray<TIndexDesc >  TIndexDescArray;

typedef DynamicArray<int >  SDEngine__71;

class DELPHICLASS TSDTable;
class PASCALIMPLEMENTATION TSDTable : public TSDDataSet 
{
	typedef TSDDataSet inherited;
	
private:
	AnsiString FTableName;
	AnsiString FOrderByFields;
	AnsiString FWhereText;
	bool FFieldsIndex;
	bool FDefaultIndex;
	Db::TIndexDefs* FIndexDefs;
	Db::TMasterDataLink* FMasterLink;
	AnsiString FIndexName;
	DynamicArray<TIndexDesc >  FIndexDescs;
	DynamicArray<int >  FIndexFieldMap;
	int FIndexFieldCount;
	bool FStoreDefs;
	bool FReadOnly;
	Db::TParams* FParams;
	bool FQuoteIdent;
	void __fastcall CheckMasterRange(void);
	bool __fastcall FieldDefsStored(void);
	bool __fastcall GetExists(void);
	AnsiString __fastcall GetIndexFieldNames(void);
	AnsiString __fastcall GetIndexName(void);
	AnsiString __fastcall GetFieldListWithDesc(const AnsiString AFields, const AnsiString ADescFields);
		
	AnsiString __fastcall GetMasterFields(void);
	AnsiString __fastcall ReplaceSemicolon2Comma(const AnsiString AStr);
	bool __fastcall IndexDefsStored(void);
	void __fastcall MasterChanged(System::TObject* Sender);
	void __fastcall MasterDisabled(System::TObject* Sender);
	void __fastcall RefreshParams(void);
	void __fastcall ReleaseHandle(bool SaveRes);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetIndexField(int Index, Db::TField* Value);
	void __fastcall SetIndexDefs(Db::TIndexDefs* Value);
	void __fastcall SetIndexFieldNames(const AnsiString Value);
	void __fastcall SetIndex(const AnsiString Value, bool FieldsIndex);
	void __fastcall SetIndexName(const AnsiString Value);
	void __fastcall SetMasterFields(const AnsiString Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetTableName(const AnsiString Value);
	void __fastcall SetLinkRanges(Classes::TList* MasterFields);
	void __fastcall SetParamsFromMasterDataSet(void);
	void __fastcall ApplyRange(void);
	void __fastcall CancelRange(void);
	void __fastcall UpdateRange(void);
	
protected:
	virtual Sdcommon::TISqlCommand* __fastcall ISqlCmdCreate(void);
	void __fastcall ISqlDeleteTable(void);
	void __fastcall ISqlEmptyTable(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall ExecuteCursor(void);
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	virtual void __fastcall DoOnNewRecord(void);
	AnsiString __fastcall GenOrderBy(void);
	virtual bool __fastcall GetCanModify(void);
	int __fastcall GetCurrentIndex(void);
	virtual Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetIndexField(int Index);
	int __fastcall GetIndexFieldCount(void);
	virtual bool __fastcall GetIsIndexField(Db::TField* Field);
	AnsiString __fastcall GetSQLText(void);
	virtual void __fastcall InternalClose(void);
	virtual void __fastcall InternalDelete(void);
	virtual void __fastcall InternalPost(void);
	virtual void __fastcall InternalOpen(void);
	void __fastcall SwitchToIndex(void);
	void __fastcall ClearIndexDescs(void);
	void __fastcall UpdateIndexDescs(void);
	virtual void __fastcall UpdateIndexDefs(void);
	__property Db::TMasterDataLink* MasterLink = {read=FMasterLink};
	
public:
	__fastcall virtual TSDTable(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDTable(void);
	void __fastcall CreateTable(void);
	void __fastcall DeleteTable(void);
	void __fastcall EmptyTable(void);
	void __fastcall GetIndexNames(Classes::TStrings* List);
	__property bool Exists = {read=GetExists, nodefault};
	__property int IndexFieldCount = {read=GetIndexFieldCount, nodefault};
	__property Db::TField* IndexFields[int Index] = {read=GetIndexField, write=SetIndexField};
	
__published:
	__property bool DefaultIndex = {read=FDefaultIndex, write=FDefaultIndex, default=1};
	__property FieldDefs  = {stored=FieldDefsStored};
	__property Db::TIndexDefs* IndexDefs = {read=FIndexDefs, write=SetIndexDefs, stored=IndexDefsStored
		};
	__property AnsiString IndexFieldNames = {read=GetIndexFieldNames, write=SetIndexFieldNames};
	__property AnsiString IndexName = {read=GetIndexName, write=SetIndexName};
	__property AnsiString MasterFields = {read=GetMasterFields, write=SetMasterFields};
	__property Db::TDataSource* MasterSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property bool StoreDefs = {read=FStoreDefs, write=FStoreDefs, default=0};
	__property AnsiString TableName = {read=FTableName, write=SetTableName};
	__property UpdateMode ;
	__property UpdateObject ;
};


class DELPHICLASS TSDScript;
class PASCALIMPLEMENTATION TSDScript : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStrings* FSQL;
	Classes::TStrings* FSQLPattern;
	bool FParamCheck;
	Db::TParams* FParams;
	TSDQuery* FQuery;
	bool FIgnoreParams;
	char FTermChar;
	char FMacroChar;
	Db::TParams* FMacros;
	bool FMacroCheck;
	bool FTransaction;
	Classes::TNotifyEvent FBeforeExecute;
	Classes::TNotifyEvent FAfterExecute;
	TSDDatabase* __fastcall GetDatabase(void);
	AnsiString __fastcall GetDatabaseName(void);
	Db::TParams* __fastcall GetMacros(void);
	Word __fastcall GetMacroCount(void);
	int __fastcall GetParamsCount(void);
	TSDSession* __fastcall GetDBSession(void);
	AnsiString __fastcall GetSessionName(void);
	AnsiString __fastcall GetText(void);
	void __fastcall CreateMacros(void);
	void __fastcall PatternChanged(System::TObject* Sender);
	void __fastcall SetDatabaseName(const AnsiString Value);
	void __fastcall SetMacroChar(const char Value);
	void __fastcall SetMacros(const Db::TParams* Value);
	void __fastcall SetParamsList(const Db::TParams* Value);
	void __fastcall SetQuery(const Classes::TStrings* Value);
	void __fastcall SetSessionName(const AnsiString Value);
	void __fastcall ReadParamData(Classes::TReader* Reader);
	void __fastcall WriteParamData(Classes::TWriter* Writer);
	void __fastcall ReadMacroData(Classes::TReader* Reader);
	void __fastcall WriteMacroData(Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall CheckExecQuery(int LineNo, int StatementNo);
	virtual void __fastcall ExecuteScript(int StatementNo);
	
public:
	__fastcall virtual TSDScript(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDScript(void);
	void __fastcall ExecSQL(void);
	void __fastcall ExpandMacros(void);
	Db::TParam* __fastcall MacroByName(const AnsiString MacroName);
	Db::TParam* __fastcall ParamByName(const AnsiString Value);
	__property TSDSession* DBSession = {read=GetDBSession};
	__property TSDDatabase* Database = {read=GetDatabase};
	__property int ParamCount = {read=GetParamsCount, nodefault};
	__property AnsiString Text = {read=GetText};
	
__published:
	__property AnsiString DatabaseName = {read=GetDatabaseName, write=SetDatabaseName};
	__property bool IgnoreParams = {read=FIgnoreParams, write=FIgnoreParams, default=0};
	__property char MacroChar = {read=FMacroChar, write=SetMacroChar, default=37};
	__property bool MacroCheck = {read=FMacroCheck, write=FMacroCheck, default=1};
	__property Word MacroCount = {read=GetMacroCount, nodefault};
	__property Db::TParams* Macros = {read=GetMacros, write=SetMacros, stored=false};
	__property char TermChar = {read=FTermChar, write=FTermChar, default=59};
	__property AnsiString SessionName = {read=GetSessionName, write=SetSessionName};
	__property Classes::TStrings* SQL = {read=FSQLPattern, write=SetQuery};
	__property bool ParamCheck = {read=FParamCheck, write=FParamCheck, default=1};
	__property Db::TParams* Params = {read=FParams, write=SetParamsList, stored=false};
	__property bool Transaction = {read=FTransaction, write=FTransaction, nodefault};
	__property Classes::TNotifyEvent BeforeExecute = {read=FBeforeExecute, write=FBeforeExecute};
	__property Classes::TNotifyEvent AfterExecute = {read=FAfterExecute, write=FAfterExecute};
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint SDE_ERR_NONE = 0x0;
static const Shortint SDE_ERR_UPDATEABORT = 0xffffffff;
static const Shortint dsfOpened = 0x0;
static const Shortint dsfPrepared = 0x1;
static const Shortint dsfExecSQL = 0x2;
static const Shortint dsfTable = 0x3;
static const Shortint dsfFieldList = 0x4;
static const Shortint dsfIndexList = 0x5;
static const Shortint dsfStoredProc = 0x6;
static const Shortint dsfExecProc = 0x7;
static const Shortint dsfProcDesc = 0x8;
static const Shortint dsfProvider = 0xa;
extern PACKAGE TSDDatabase* DefDatabase;
extern PACKAGE TSDSession* Session;
extern PACKAGE TSDSessionList* Sessions;
extern PACKAGE Sdcommon::TInitSqlDatabaseProc InitSqlDatabaseProcs[12];
extern PACKAGE void __fastcall SetBusyState(void);
extern PACKAGE void __fastcall ResetBusyState(void);
extern PACKAGE Db::TUpdateStatus __fastcall UpdateKindToStatus(Db::TUpdateKind UpdateKind);
extern PACKAGE void __fastcall SDEError(short ErrorCode);
extern PACKAGE void __fastcall SDECheck(short Status);

}	/* namespace Sdengine */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdengine;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDEngine
