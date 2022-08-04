// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDCsbSrv.pas' rev: 4.00

#ifndef SDCsbSrvHPP
#define SDCsbSrvHPP

#pragma delphiheader begin
#pragma option push -w-
#include <SDSrvLog.hpp>	// Pascal unit
#include <SDCSb.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SDEngine.hpp>	// Pascal unit
#include <SDCommon.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdcsbsrv
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSDSQLBaseServer;
typedef void __fastcall (__closure *TSDSrvLoginEvent)(TSDSQLBaseServer* Server, Classes::TStrings* LoginParams
	);

#pragma pack(push, 4)
class PASCALIMPLEMENTATION TSDSQLBaseServer : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	void *FHandle;
	bool FLoginPrompt;
	AnsiString FServerName;
	bool FStreamedConnected;
	Classes::TStrings* FParams;
	TSDSrvLoginEvent FOnLogin;
	void __fastcall CheckActive(void);
	void __fastcall CheckInactive(void);
	void __fastcall CheckServerName(void);
	void __fastcall Login(Classes::TStrings* LoginParams);
	bool __fastcall GetConnected(void);
	Word __fastcall GetSrvHandle(void);
	void __fastcall SetConnected(bool Value);
	void __fastcall SetParams(Classes::TStrings* Value);
	void __fastcall SetServerName(const AnsiString Value);
	
protected:
	void __fastcall ICsbCheck(short Status);
	void __fastcall ICsbLoadLib(void);
	void __fastcall ICsbFreeLib(void);
	void __fastcall ICsbAbortProcess(int ProcessNo);
	void __fastcall ICsbCancelRequest(int CursorNo);
	void __fastcall ICsbConnect(const AnsiString AServerName, const AnsiString APassword);
	void __fastcall ICsbCreateDatabase(const AnsiString DBName);
	void __fastcall ICsbDeleteDatabase(const AnsiString DBName);
	void __fastcall ICsbDisconnect(void);
	void __fastcall ICsbGetDatabaseNames(Classes::TStrings* DBNames);
	void __fastcall ICsbInstallDatabase(const AnsiString DBName);
	void __fastcall ICsbDeinstallDatabase(const AnsiString DBName);
	void __fastcall ICsbServerShutdown(void);
	void __fastcall ICsbServerTerminate(void);
	void __fastcall ICsbBackupDatabase(const AnsiString DBName, const AnsiString BackupDir, bool Over);
		
	void __fastcall ICsbRestoreDatabase(const AnsiString DBName, const AnsiString BackupDir, bool Over)
		;
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TSDSQLBaseServer(Classes::TComponent* AOwner);
	__fastcall virtual ~TSDSQLBaseServer(void);
	void __fastcall AbortProcess(int ProcessNo);
	void __fastcall BackupDatabase(const AnsiString DBName, const AnsiString BackupDir, bool Over);
	void __fastcall CancelRequest(int CursorNo);
	void __fastcall Close(void);
	void __fastcall CreateDatabase(const AnsiString DBName);
	void __fastcall DeinstallDatabase(const AnsiString DBName);
	void __fastcall DeleteDatabase(const AnsiString DBName);
	void __fastcall GetDatabaseNames(Classes::TStrings* DBNames);
	void __fastcall InstallDatabase(const AnsiString DBName);
	void __fastcall Open(void);
	void __fastcall RestoreDatabase(const AnsiString DBName, const AnsiString BackupDir, bool Over);
	void __fastcall Shutdown(void);
	void __fastcall Terminate(void);
	__property Word SrvHandle = {read=GetSrvHandle, nodefault};
	
__published:
	__property bool Connected = {read=GetConnected, write=SetConnected, default=0};
	__property bool LoginPrompt = {read=FLoginPrompt, write=FLoginPrompt, default=1};
	__property Classes::TStrings* Params = {read=FParams, write=SetParams};
	__property AnsiString ServerName = {read=FServerName, write=SetServerName};
	__property TSDSrvLoginEvent OnLogin = {read=FOnLogin, write=FOnLogin};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sdcsbsrv */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdcsbsrv;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDCsbSrv
