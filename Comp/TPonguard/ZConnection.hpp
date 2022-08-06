// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZConnection.pas' rev: 5.00

#ifndef ZConnectionHPP
#define ZConnectionHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZDbcInterbase6.hpp>	// Pascal unit
#include <ZDbcPostgreSql.hpp>	// Pascal unit
#include <ZDbcMySql.hpp>	// Pascal unit
#include <ZDbcAdo.hpp>	// Pascal unit
#include <ZDbcDbLib.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zconnection
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZConnection;
class PASCALIMPLEMENTATION TZConnection : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	AnsiString FProtocol;
	AnsiString FHostName;
	int FPort;
	AnsiString FDatabase;
	AnsiString FUser;
	AnsiString FPassword;
	AnsiString FCatalog;
	Classes::TStrings* FProperties;
	bool FAutoCommit;
	bool FReadOnly;
	Zdbcintfs::TZTransactIsolationLevel FTransactIsolationLevel;
	Zdbcintfs::_di_IZConnection FConnection;
	Classes::TList* FDatasets;
	bool FLoginPrompt;
	bool FStreamedConnected;
	int FExplicitTransactionCounter;
	bool FSQLHourGlass;
	Classes::TNotifyEvent FBeforeConnect;
	Classes::TNotifyEvent FBeforeDisconnect;
	Classes::TNotifyEvent FAfterDisconnect;
	Classes::TNotifyEvent FAfterConnect;
	Classes::TNotifyEvent FOnCommit;
	Classes::TNotifyEvent FOnRollback;
	Zcompatibility::TLoginEvent FOnLogin;
	bool __fastcall GetConnected(void);
	void __fastcall SetConnected(bool Value);
	void __fastcall SetProperties(Classes::TStrings* Value);
	void __fastcall SetTransactIsolationLevel(Zdbcintfs::TZTransactIsolationLevel Value);
	void __fastcall SetAutoCommit(bool Value);
	void __fastcall DoBeforeConnect(void);
	void __fastcall DoAfterConnect(void);
	void __fastcall DoBeforeDisconnect(void);
	void __fastcall DoAfterDisconnect(void);
	void __fastcall DoCommit(void);
	void __fastcall DoRollback(void);
	void __fastcall CloseAllDataSets(void);
	void __fastcall UnregisterAllDataSets(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Loaded(void);
	__property bool StreamedConnected = {read=FStreamedConnected, write=FStreamedConnected, nodefault};
		
	
public:
	__fastcall virtual TZConnection(Classes::TComponent* AOwner);
	__fastcall virtual ~TZConnection(void);
	virtual void __fastcall Connect(void);
	virtual void __fastcall Disconnect(void);
	virtual void __fastcall StartTransaction(void);
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	void __fastcall RegisterDataSet(Db::TDataSet* DataSet);
	void __fastcall UnregisterDataSet(Db::TDataSet* DataSet);
	__property Zdbcintfs::_di_IZConnection DbcConnection = {read=FConnection};
	void __fastcall ShowSQLHourGlass(void);
	void __fastcall HideSQLHourGlass(void);
	
__published:
	__property AnsiString Protocol = {read=FProtocol, write=FProtocol};
	__property AnsiString HostName = {read=FHostName, write=FHostName};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property AnsiString Database = {read=FDatabase, write=FDatabase};
	__property AnsiString User = {read=FUser, write=FUser};
	__property AnsiString Password = {read=FPassword, write=FPassword};
	__property AnsiString Catalog = {read=FCatalog, write=FCatalog};
	__property Classes::TStrings* Properties = {read=FProperties, write=SetProperties};
	__property bool AutoCommit = {read=FAutoCommit, write=SetAutoCommit, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property Zdbcintfs::TZTransactIsolationLevel TransactIsolationLevel = {read=FTransactIsolationLevel
		, write=SetTransactIsolationLevel, nodefault};
	__property bool Connected = {read=GetConnected, write=SetConnected, nodefault};
	__property bool LoginPrompt = {read=FLoginPrompt, write=FLoginPrompt, default=0};
	__property Classes::TNotifyEvent BeforeConnect = {read=FBeforeConnect, write=FBeforeConnect};
	__property Classes::TNotifyEvent AfterConnect = {read=FAfterConnect, write=FAfterConnect};
	__property Classes::TNotifyEvent BeforeDisconnect = {read=FBeforeDisconnect, write=FBeforeDisconnect
		};
	__property Classes::TNotifyEvent AfterDisconnect = {read=FAfterDisconnect, write=FAfterDisconnect};
		
	__property bool SQLHourGlass = {read=FSQLHourGlass, write=FSQLHourGlass, nodefault};
	__property Classes::TNotifyEvent OnCommit = {read=FOnCommit, write=FOnCommit};
	__property Classes::TNotifyEvent OnRollback = {read=FOnRollback, write=FOnRollback};
	__property Zcompatibility::TLoginEvent OnLogin = {read=FOnLogin, write=FOnLogin};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zconnection */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zconnection;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZConnection
