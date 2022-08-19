// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDbcConnection.pas' rev: 5.00

#ifndef ZDbcConnectionHPP
#define ZDbcConnectionHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZTokenizer.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdbcconnection
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZAbstractDriver;
class PASCALIMPLEMENTATION TZAbstractDriver : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
public:
	__fastcall TZAbstractDriver(void);
	__fastcall virtual ~TZAbstractDriver(void);
	virtual Zcompatibility::TStringDynArray __fastcall GetSupportedProtocols(void) = 0 ;
	virtual Zdbcintfs::_di_IZConnection __fastcall Connect(AnsiString Url, Classes::TStrings* Info);
	virtual bool __fastcall AcceptsURL(AnsiString Url);
	virtual Classes::TStrings* __fastcall GetPropertyInfo(AnsiString Url, Classes::TStrings* Info);
	virtual int __fastcall GetMajorVersion(void);
	virtual int __fastcall GetMinorVersion(void);
private:
	void *__IZDriver;	/* Zdbcintfs::IZDriver */
	
public:
	operator IZDriver*(void) { return (IZDriver*)&__IZDriver; }
	
};


class DELPHICLASS TZAbstractConnection;
class PASCALIMPLEMENTATION TZAbstractConnection : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FHostName;
	int FPort;
	AnsiString FDatabase;
	AnsiString FUser;
	AnsiString FPassword;
	Classes::TStrings* FInfo;
	bool FAutoCommit;
	bool FReadOnly;
	Zdbcintfs::TZTransactIsolationLevel FTransactIsolationLevel;
	bool FClosed;
	Comobj::TContainedObject* FMetadata;
	
protected:
	__fastcall TZAbstractConnection(AnsiString Url, AnsiString HostName, int Port, AnsiString Database, 
		AnsiString User, AnsiString Password, Classes::TStrings* Info, Comobj::TContainedObject* Metadata)
		;
	void __fastcall RaiseUnsupportedException(void);
	virtual Zdbcintfs::_di_IZStatement __fastcall CreateRegularStatement(Classes::TStrings* Info);
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreatePreparedStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual Zdbcintfs::_di_IZCallableStatement __fastcall CreateCallableStatement(AnsiString SQL, Classes::TStrings* 
		Info);
	__property AnsiString HostName = {read=FHostName, write=FHostName};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property AnsiString Database = {read=FDatabase, write=FDatabase};
	__property AnsiString User = {read=FUser, write=FUser};
	__property AnsiString Password = {read=FPassword, write=FPassword};
	__property Classes::TStrings* Info = {read=FInfo};
	__property bool AutoCommit = {read=FAutoCommit, write=FAutoCommit, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property Zdbcintfs::TZTransactIsolationLevel TransactIsolationLevel = {read=FTransactIsolationLevel
		, write=FTransactIsolationLevel, nodefault};
	__property bool Closed = {read=FClosed, write=FClosed, nodefault};
	
public:
	__fastcall virtual ~TZAbstractConnection(void);
	Zdbcintfs::_di_IZStatement __fastcall CreateStatement();
	Zdbcintfs::_di_IZPreparedStatement __fastcall PrepareStatement(AnsiString SQL);
	Zdbcintfs::_di_IZCallableStatement __fastcall PrepareCall(AnsiString SQL);
	Zdbcintfs::_di_IZStatement __fastcall CreateStatementWithParams(Classes::TStrings* Info);
	Zdbcintfs::_di_IZPreparedStatement __fastcall PrepareStatementWithParams(AnsiString SQL, Classes::TStrings* 
		Info);
	Zdbcintfs::_di_IZCallableStatement __fastcall PrepareCallWithParams(AnsiString SQL, Classes::TStrings* 
		Info);
	virtual Zdbcintfs::_di_IZNotification __fastcall CreateNotification(AnsiString Event);
	virtual Zdbcintfs::_di_IZSequence __fastcall CreateSequence(AnsiString Sequence, int BlockSize);
	virtual AnsiString __fastcall NativeSQL(AnsiString SQL);
	virtual void __fastcall SetAutoCommit(bool AutoCommit);
	virtual bool __fastcall GetAutoCommit(void);
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall IsClosed(void);
	Zdbcintfs::_di_IZDatabaseMetadata __fastcall GetMetadata();
	Classes::TStrings* __fastcall GetParameters(void);
	virtual void __fastcall SetReadOnly(bool ReadOnly);
	virtual bool __fastcall IsReadOnly(void);
	virtual void __fastcall SetCatalog(AnsiString Catalog);
	virtual AnsiString __fastcall GetCatalog();
	virtual void __fastcall SetTransactionIsolation(Zdbcintfs::TZTransactIsolationLevel Level);
	virtual Zdbcintfs::TZTransactIsolationLevel __fastcall GetTransactionIsolation(void);
	virtual Zdbcintfs::EZSQLWarning* __fastcall GetWarnings(void);
	virtual void __fastcall ClearWarnings(void);
private:
	void *__IZConnection;	/* Zdbcintfs::IZConnection */
	
public:
	operator IZConnection*(void) { return (IZConnection*)&__IZConnection; }
	
};


class DELPHICLASS TZAbstractNotification;
class PASCALIMPLEMENTATION TZAbstractNotification : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FEventName;
	Zdbcintfs::_di_IZConnection FConnection;
	
protected:
	__fastcall TZAbstractNotification(Zdbcintfs::_di_IZConnection Connection, AnsiString EventName);
	__property AnsiString EventName = {read=FEventName, write=FEventName};
	__property Zdbcintfs::_di_IZConnection Connection = {read=FConnection, write=FConnection};
	
public:
	AnsiString __fastcall GetEvent();
	virtual void __fastcall Listen(void);
	virtual void __fastcall Unlisten(void);
	virtual void __fastcall DoNotify(void);
	virtual AnsiString __fastcall CheckEvents();
	virtual Zdbcintfs::_di_IZConnection __fastcall GetConnection();
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAbstractNotification(void) { }
	#pragma option pop
	
private:
	void *__IZNotification;	/* Zdbcintfs::IZNotification */
	
public:
	operator IZNotification*(void) { return (IZNotification*)&__IZNotification; }
	
};


class DELPHICLASS TZAbstractSequence;
class PASCALIMPLEMENTATION TZAbstractSequence : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FName;
	int FBlockSize;
	Zdbcintfs::_di_IZConnection FConnection;
	
protected:
	__fastcall TZAbstractSequence(Zdbcintfs::_di_IZConnection Connection, AnsiString Name, int BlockSize
		);
	__property AnsiString Name = {read=FName, write=FName};
	__property int BlockSize = {read=FBlockSize, write=FBlockSize, nodefault};
	__property Zdbcintfs::_di_IZConnection Connection = {read=FConnection, write=FConnection};
	
public:
	virtual AnsiString __fastcall GetName();
	virtual int __fastcall GetBlockSize(void);
	virtual __int64 __fastcall GetNextValue(void);
	virtual Zdbcintfs::_di_IZConnection __fastcall GetConnection();
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZAbstractSequence(void) { }
	#pragma option pop
	
private:
	void *__IZSequence;	/* Zdbcintfs::IZSequence */
	
public:
	operator IZSequence*(void) { return (IZSequence*)&__IZSequence; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdbcconnection */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdbcconnection;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDbcConnection
