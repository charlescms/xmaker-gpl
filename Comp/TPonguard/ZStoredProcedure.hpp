// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZStoredProcedure.pas' rev: 5.00

#ifndef ZStoredProcedureHPP
#define ZStoredProcedureHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZAbstractRODataset.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZAbstractDataset.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <ZConnection.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zstoredprocedure
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZStoredProc;
class PASCALIMPLEMENTATION TZStoredProc : public Zabstractdataset::TZAbstractDataset 
{
	typedef Zabstractdataset::TZAbstractDataset inherited;
	
private:
	void __fastcall RetrieveParamValues(void);
	AnsiString __fastcall GetStoredProcName();
	void __fastcall SetStoredProcName(const AnsiString Value);
	
protected:
	virtual Zdbcintfs::_di_IZPreparedStatement __fastcall CreateStatement(AnsiString SQL, Classes::TStrings* 
		Properties);
	virtual void __fastcall SetStatementParams(Zdbcintfs::_di_IZPreparedStatement Statement, Zcompatibility::TStringDynArray 
		ParamNames, Db::TParams* Params, Db::TDataLink* DataLink);
	virtual void __fastcall InternalOpen(void);
	virtual void __fastcall InternalClose(void);
	
public:
	virtual void __fastcall ExecProc(void);
	
__published:
	__property Active ;
	__property ParamCheck ;
	__property Params ;
	__property ShowRecordTypes ;
	__property Options ;
	__property AnsiString StoredProcName = {read=GetStoredProcName, write=SetStoredProcName};
public:
	#pragma option push -w-inl
	/* TZAbstractDataset.Create */ inline __fastcall virtual TZStoredProc(Classes::TComponent* AOwner) : 
		Zabstractdataset::TZAbstractDataset(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractDataset.Destroy */ inline __fastcall virtual ~TZStoredProc(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zstoredprocedure */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zstoredprocedure;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZStoredProcedure
