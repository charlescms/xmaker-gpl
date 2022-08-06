// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZStreamBlob.pas' rev: 5.00

#ifndef ZStreamBlobHPP
#define ZStreamBlobHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Db.hpp>	// Pascal unit
#include <ZDbcIntfs.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zstreamblob
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZBlobStream;
class PASCALIMPLEMENTATION TZBlobStream : public Classes::TMemoryStream 
{
	typedef Classes::TMemoryStream inherited;
	
private:
	Db::TBlobField* FField;
	Zdbcintfs::_di_IZBlob FBlob;
	Db::TBlobStreamMode FMode;
	
protected:
	__property Zdbcintfs::_di_IZBlob Blob = {read=FBlob, write=FBlob};
	__property Db::TBlobStreamMode Mode = {read=FMode, write=FMode, nodefault};
	
public:
	__fastcall TZBlobStream(Db::TBlobField* Field, Zdbcintfs::_di_IZBlob Blob, Db::TBlobStreamMode Mode
		);
	__fastcall virtual ~TZBlobStream(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zstreamblob */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zstreamblob;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZStreamBlob
