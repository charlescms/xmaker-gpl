// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZDataset.pas' rev: 5.00

#ifndef ZDatasetHPP
#define ZDatasetHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <ZAbstractTable.hpp>	// Pascal unit
#include <ZAbstractDataset.hpp>	// Pascal unit
#include <ZAbstractRODataset.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zdataset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZReadOnlyQuery;
class PASCALIMPLEMENTATION TZReadOnlyQuery : public Zabstractrodataset::TZAbstractRODataset 
{
	typedef Zabstractrodataset::TZAbstractRODataset inherited;
	
__published:
	__property Active ;
	__property SQL ;
	__property ParamCheck ;
	__property Params ;
	__property Properties ;
	__property DataSource ;
	__property MasterFields ;
	__property MasterSource ;
	__property IndexFieldNames ;
	__property Options ;
public:
	#pragma option push -w-inl
	/* TZAbstractRODataset.Create */ inline __fastcall virtual TZReadOnlyQuery(Classes::TComponent* AOwner
		) : Zabstractrodataset::TZAbstractRODataset(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractRODataset.Destroy */ inline __fastcall virtual ~TZReadOnlyQuery(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZQuery;
class PASCALIMPLEMENTATION TZQuery : public Zabstractdataset::TZAbstractDataset 
{
	typedef Zabstractdataset::TZAbstractDataset inherited;
	
__published:
	__property Active ;
	__property SQL ;
	__property ParamCheck ;
	__property Params ;
	__property ShowRecordTypes ;
	__property Properties ;
	__property DataSource ;
	__property MasterFields ;
	__property MasterSource ;
	__property IndexFieldNames ;
	__property UpdateMode ;
	__property WhereMode ;
	__property Options ;
public:
	#pragma option push -w-inl
	/* TZAbstractDataset.Create */ inline __fastcall virtual TZQuery(Classes::TComponent* AOwner) : Zabstractdataset::TZAbstractDataset(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractDataset.Destroy */ inline __fastcall virtual ~TZQuery(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZTable;
class PASCALIMPLEMENTATION TZTable : public Zabstracttable::TZAbstractTable 
{
	typedef Zabstracttable::TZAbstractTable inherited;
	
__published:
	__property Active ;
	__property TableName ;
	__property ShowRecordTypes ;
	__property Properties ;
	__property MasterFields ;
	__property MasterSource ;
	__property IndexFieldNames ;
	__property UpdateMode ;
	__property WhereMode ;
	__property Options ;
public:
	#pragma option push -w-inl
	/* TZAbstractDataset.Create */ inline __fastcall virtual TZTable(Classes::TComponent* AOwner) : Zabstracttable::TZAbstractTable(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZAbstractDataset.Destroy */ inline __fastcall virtual ~TZTable(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zdataset */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zdataset;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZDataset
