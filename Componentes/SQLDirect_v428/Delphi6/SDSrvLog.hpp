// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDSrvLog.pas' rev: 6.00

#ifndef SDSrvLogHPP
#define SDSrvLogHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
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

namespace Sdsrvlog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSDSrvLoginDlg;
class PASCALIMPLEMENTATION TSDSrvLoginDlg : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* pnlInput;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* lblServerName;
	Stdctrls::TLabel* ServerName;
	Extctrls::TBevel* Bevel;
	Stdctrls::TEdit* Password;
	Stdctrls::TButton* btOk;
	Stdctrls::TButton* btCancel;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TSDSrvLoginDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSDSrvLoginDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSDSrvLoginDlg(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TSDSrvLoginDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TSDSrvLoginDlg* SDSrvLoginDlg;
extern PACKAGE bool __fastcall SrvLoginDialog(const AnsiString AServerName, AnsiString &APassword);

}	/* namespace Sdsrvlog */
using namespace Sdsrvlog;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDSrvLog
