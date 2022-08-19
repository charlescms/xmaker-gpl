// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZSelectSchema.pas' rev: 5.00

#ifndef ZSelectSchemaHPP
#define ZSelectSchemaHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zselectschema
{
//-- type declarations -------------------------------------------------------
__interface IZIdentifierConvertor;
typedef System::DelphiInterface<IZIdentifierConvertor> _di_IZIdentifierConvertor;
__interface INTERFACE_UUID("{2EB07B9B-1E96-4A42-8084-6F98D9140B27}") IZIdentifierConvertor  : public IUnknown 
	
{
	
public:
	virtual bool __fastcall IsCaseSensitive(AnsiString Value) = 0 ;
	virtual bool __fastcall IsQuoted(AnsiString Value) = 0 ;
	virtual AnsiString __fastcall Quote(AnsiString Value) = 0 ;
	virtual AnsiString __fastcall ExtractQuote(AnsiString Value) = 0 ;
};

class DELPHICLASS TZTableRef;
class PASCALIMPLEMENTATION TZTableRef : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString FCatalog;
	AnsiString FSchema;
	AnsiString FTable;
	AnsiString FAlias;
	
public:
	__fastcall TZTableRef(AnsiString Catalog, AnsiString Schema, AnsiString Table, AnsiString Alias);
	AnsiString __fastcall FullName();
	__property AnsiString Catalog = {read=FCatalog, write=FCatalog};
	__property AnsiString Schema = {read=FSchema, write=FSchema};
	__property AnsiString Table = {read=FTable, write=FTable};
	__property AnsiString Alias = {read=FAlias, write=FAlias};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZTableRef(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZFieldRef;
class PASCALIMPLEMENTATION TZFieldRef : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	bool FIsField;
	AnsiString FCatalog;
	AnsiString FSchema;
	AnsiString FTable;
	AnsiString FField;
	AnsiString FAlias;
	TZTableRef* FTableRef;
	bool FLinked;
	
public:
	__fastcall TZFieldRef(bool IsField, AnsiString Catalog, AnsiString Schema, AnsiString Table, AnsiString 
		Field, AnsiString Alias, TZTableRef* TableRef);
	__property bool IsField = {read=FIsField, write=FIsField, nodefault};
	__property AnsiString Catalog = {read=FCatalog, write=FCatalog};
	__property AnsiString Schema = {read=FSchema, write=FSchema};
	__property AnsiString Table = {read=FTable, write=FTable};
	__property AnsiString Field = {read=FField, write=FField};
	__property AnsiString Alias = {read=FAlias, write=FAlias};
	__property TZTableRef* TableRef = {read=FTableRef, write=FTableRef};
	__property bool Linked = {read=FLinked, write=FLinked, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZFieldRef(void) { }
	#pragma option pop
	
};


__interface IZSelectSchema;
typedef System::DelphiInterface<IZSelectSchema> _di_IZSelectSchema;
__interface INTERFACE_UUID("{3B892975-57E9-4EB7-8DB1-BDDED91E7FBC}") IZSelectSchema  : public IUnknown 
	
{
	
public:
	virtual void __fastcall AddField(TZFieldRef* FieldRef) = 0 ;
	virtual void __fastcall InsertField(int Index, TZFieldRef* FieldRef) = 0 ;
	virtual void __fastcall DeleteField(TZFieldRef* FieldRef) = 0 ;
	virtual void __fastcall AddTable(TZTableRef* TableRef) = 0 ;
	virtual void __fastcall LinkReferences(_di_IZIdentifierConvertor Convertor) = 0 ;
	virtual TZTableRef* __fastcall FindTableByFullName(AnsiString Catalog, AnsiString Schema, AnsiString 
		Table) = 0 ;
	virtual TZTableRef* __fastcall FindTableByShortName(AnsiString Table) = 0 ;
	virtual TZFieldRef* __fastcall FindFieldByShortName(AnsiString Field) = 0 ;
	virtual TZFieldRef* __fastcall LinkFieldByIndexAndShortName(int ColumnIndex, AnsiString Field) = 0 
		;
	virtual int __fastcall GetFieldCount(void) = 0 ;
	virtual int __fastcall GetTableCount(void) = 0 ;
	virtual TZFieldRef* __fastcall GetField(int Index) = 0 ;
	virtual TZTableRef* __fastcall GetTable(int Index) = 0 ;
	__property int FieldCount = {read=GetFieldCount};
	__property TZFieldRef* Fields[int Index] = {read=GetField};
	__property int TableCount = {read=GetTableCount};
	__property TZTableRef* Tables[int Index] = {read=GetTable};
};

class DELPHICLASS TZSelectSchema;
class PASCALIMPLEMENTATION TZSelectSchema : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	Contnrs::TObjectList* FFields;
	Contnrs::TObjectList* FTables;
	void __fastcall ConvertIdentifiers(_di_IZIdentifierConvertor Convertor);
	
public:
	__fastcall TZSelectSchema(void);
	__fastcall virtual ~TZSelectSchema(void);
	void __fastcall AddField(TZFieldRef* FieldRef);
	void __fastcall InsertField(int Index, TZFieldRef* FieldRef);
	void __fastcall DeleteField(TZFieldRef* FieldRef);
	void __fastcall AddTable(TZTableRef* TableRef);
	void __fastcall LinkReferences(_di_IZIdentifierConvertor Convertor);
	TZTableRef* __fastcall FindTableByFullName(AnsiString Catalog, AnsiString Schema, AnsiString Table)
		;
	TZTableRef* __fastcall FindTableByShortName(AnsiString Table);
	TZFieldRef* __fastcall FindFieldByShortName(AnsiString Field);
	TZFieldRef* __fastcall LinkFieldByIndexAndShortName(int ColumnIndex, AnsiString Field);
	int __fastcall GetFieldCount(void);
	int __fastcall GetTableCount(void);
	TZFieldRef* __fastcall GetField(int Index);
	TZTableRef* __fastcall GetTable(int Index);
	__property int FieldCount = {read=GetFieldCount, nodefault};
	__property TZFieldRef* Fields[int Index] = {read=GetField};
	__property int TableCount = {read=GetTableCount, nodefault};
	__property TZTableRef* Tables[int Index] = {read=GetTable};
private:
	void *__IZSelectSchema;	/* Zselectschema::IZSelectSchema */
	
public:
	operator IZSelectSchema*(void) { return (IZSelectSchema*)&__IZSelectSchema; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Zselectschema */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zselectschema;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZSelectSchema
