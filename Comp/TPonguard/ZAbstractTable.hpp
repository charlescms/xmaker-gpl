// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZAbstractTable.pas' rev: 5.00

#ifndef ZAbstractTableHPP
#define ZAbstractTableHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZAbstractRODataset.hpp>	// Pascal unit
#include <ZAbstractDataset.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zabstracttable
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZAbstractTable;
class PASCALIMPLEMENTATION TZAbstractTable : public Zabstractdataset::TZAbstractDataset 
{
	typedef Zabstractdataset::TZAbstractDataset inherited;
	
private:
	AnsiString FTableName;
	void __fastcall SetTableName(AnsiString Value);
	
protected:
	__property AnsiString TableName = {read=FTableName, write=SetTableName};
public:
	#pragma option push -w-inl
	/* TZAbstractDataset.Create */ inline __fastcall virtual TZAbstractTable(Classes::TComponent* AOwner
		) : Zabstractdataset::TZAbstractDataset(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractDataset.Destroy */ inline __fastcall virtual ~TZAbstractTable(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zabstracttable */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zabstracttable;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZAbstractTable
