// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDOleDb.pas' rev: 5.00

#ifndef SDOleDbHPP
#define SDOleDbHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SD_OLEDB_D5.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdoledb
{
//-- type declarations -------------------------------------------------------
__interface IErrorRecords;
typedef System::DelphiInterface<IErrorRecords> _di_IErrorRecords;
__interface INTERFACE_UUID("{0C733A67-2A1C-11CE-ADE5-00AA0044773D}") IErrorRecords  : public IUnknown 
	
{
	
public:
	virtual HRESULT __stdcall AddErrorRecord(Sd_oledb_d5::PErrorInfo pErrorInfo, unsigned dwLookupID, Activex::PDispParams 
		pdispparams, const _di_IUnknown punkCustomError, unsigned dwDynamicErrorID) = 0 ;
	virtual HRESULT __stdcall GetBasicErrorInfo(unsigned ulRecordNum, Sd_oledb_d5::PErrorInfo pErrorInfo
		) = 0 ;
	virtual HRESULT __stdcall GetCustomErrorObject(unsigned ulRecordNum, const GUID &riid, /* out */ _di_IUnknown 
		&ppObject) = 0 ;
	virtual HRESULT __stdcall GetErrorInfo(unsigned ulRecordNum, unsigned lcid, /* out */ _di_IErrorInfo 
		&ppErrorInfo) = 0 ;
	virtual HRESULT __stdcall GetErrorParameters(unsigned ulRecordNum, Activex::PDispParams pdispparams
		) = 0 ;
	virtual HRESULT __stdcall GetRecordCount(/* out */ unsigned &pcRecords) = 0 ;
};

__interface IErrorRecordsSC;
typedef System::DelphiInterface<IErrorRecordsSC> _di_IErrorRecordsSC;
__interface INTERFACE_UUID("{0C733A67-2A1C-11CE-ADE5-00AA0044773D}") IErrorRecordsSC  : public IUnknown 
	
{
	
public:
	virtual HRESULT __safecall AddErrorRecord(Sd_oledb_d5::PErrorInfo pErrorInfo, unsigned dwLookupID, 
		Activex::PDispParams pdispparams, const _di_IUnknown punkCustomError, unsigned dwDynamicErrorID, HRESULT &AddErrorRecord_result
		) = 0 ;
	virtual HRESULT __safecall GetBasicErrorInfo(unsigned ulRecordNum, Sd_oledb_d5::PErrorInfo pErrorInfo
		, HRESULT &GetBasicErrorInfo_result) = 0 ;
	virtual HRESULT __safecall GetCustomErrorObject(unsigned ulRecordNum, const GUID &riid, /* out */ _di_IUnknown 
		&ppObject, HRESULT &GetCustomErrorObject_result) = 0 ;
	virtual HRESULT __safecall GetErrorInfo(unsigned ulRecordNum, unsigned lcid, /* out */ _di_IErrorInfo 
		&ppErrorInfo, HRESULT &GetErrorInfo_result) = 0 ;
	virtual HRESULT __safecall GetErrorParameters(unsigned ulRecordNum, Activex::PDispParams pdispparams
		, HRESULT &GetErrorParameters_result) = 0 ;
	virtual HRESULT __safecall GetRecordCount(/* out */ unsigned &pcRecords, HRESULT &GetRecordCount_result
		) = 0 ;
};

__interface IDBSchemaRowset;
typedef System::DelphiInterface<IDBSchemaRowset> _di_IDBSchemaRowset;
__interface INTERFACE_UUID("{0C733A7B-2A1C-11CE-ADE5-00AA0044773D}") IDBSchemaRowset  : public IUnknown 
	
{
	
public:
	virtual HRESULT __stdcall GetRowset(const _di_IUnknown pUnkOuter, const GUID &rguidSchema, unsigned 
		cRestrictions, Activex::PVariantArg rgRestrictions, const GUID &riid, unsigned cPropertySets, Sd_oledb_d5::PDBPropSetArray 
		rgPropertySets, /* out */ _di_IUnknown &pRowset) = 0 ;
	virtual HRESULT __stdcall GetSchemas(unsigned &cSchemas, /* out */ System::PGUID &prgSchemas, /* out */ 
		PULONG &prgRestrictionSupport) = 0 ;
};

__interface IDBSchemaRowsetSC;
typedef System::DelphiInterface<IDBSchemaRowsetSC> _di_IDBSchemaRowsetSC;
__interface INTERFACE_UUID("{0C733A7B-2A1C-11CE-ADE5-00AA0044773D}") IDBSchemaRowsetSC  : public IUnknown 
	
{
	
public:
	virtual HRESULT __safecall GetRowset(const _di_IUnknown pUnkOuter, const GUID &rguidSchema, unsigned 
		cRestrictions, Activex::PVariantArg rgRestrictions, const GUID &riid, unsigned cPropertySets, Sd_oledb_d5::PDBPropSetArray 
		rgPropertySets, /* out */ _di_IUnknown &pRowset, HRESULT &GetRowset_result) = 0 ;
	virtual HRESULT __safecall GetSchemas(unsigned &cSchemas, /* out */ System::PGUID &prgSchemas, /* out */ 
		PULONG &prgRestrictionSupport, HRESULT &GetSchemas_result) = 0 ;
};

struct TSSErrorInfo;
typedef TSSErrorInfo *PSSErrorInfo;

struct TSSErrorInfo
{
	wchar_t *pwszMessage;
	wchar_t *pwszServer;
	wchar_t *pwszProcedure;
	unsigned lNative;
	Byte bState;
	Byte bClass;
	Word wLineNumber;
} ;

__interface ISQLServerErrorInfo;
typedef System::DelphiInterface<ISQLServerErrorInfo> _di_ISQLServerErrorInfo;
__interface INTERFACE_UUID("{5CF4CA12-EF21-11D0-97E7-00C04FC2AD98}") ISQLServerErrorInfo  : public IUnknown 
	
{
	
public:
	virtual HRESULT __stdcall GetErrorInfo(/* out */ PSSErrorInfo &ppErrorInfo, /* out */ wchar_t * &ppStringsBuffer
		) = 0 ;
};

__interface ISQLServerErrorInfoSC;
typedef System::DelphiInterface<ISQLServerErrorInfoSC> _di_ISQLServerErrorInfoSC;
__interface INTERFACE_UUID("{5CF4CA12-EF21-11D0-97E7-00C04FC2AD98}") ISQLServerErrorInfoSC  : public IUnknown 
	
{
	
public:
	virtual HRESULT __safecall GetErrorInfo(/* out */ PSSErrorInfo &ppErrorInfo, /* out */ wchar_t * &ppStringsBuffer
		, HRESULT &GetErrorInfo_result) = 0 ;
};

class DELPHICLASS ESDOleDbError;
class PASCALIMPLEMENTATION ESDOleDbError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDOleDbError(int AErrorCode, int ANativeError, const 
		AnsiString Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDOleDbError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDOleDbError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDOleDbError(int Ident)/* overload */ : Sdcommon::ESDEngineError(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDOleDbError(int Ident, const System::TVarRec * Args
		, const int Args_Size)/* overload */ : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDOleDbError(const AnsiString Msg, int AHelpContext) : 
		Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDOleDbError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDOleDbError(int Ident, int AHelpContext)/* overload */
		 : Sdcommon::ESDEngineError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDOleDbError(System::PResStringRec ResStringRec
		, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDOleDbError(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOleDbDatabase;
class PASCALIMPLEMENTATION TIOleDbDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	Sd_oledb_d5::_di_IDBInitialize FIDBInitialize;
	Sd_oledb_d5::_di_IDBCreateSession FIDBCreateSession;
	Sd_oledb_d5::_di_IDBCreateCommand FIDBCreateCommand;
	Sd_oledb_d5::_di_ITransactionLocal FITransaction;
	bool FMultResultsSupported;
	int FOutputParamsReturned;
	bool FIsMSSQLProv;
	Sdcommon::TISqlCommand* FCurSqlCmd;
	AnsiString __fastcall OleDbGetDBPropValue(const unsigned * APropIDs, const int APropIDs_Size);
	void __fastcall SetDBInitProps(bool bInitPropSet, bool bIntegratedAuth);
	
protected:
	void __fastcall Check(HRESULT Status);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const 
		AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	
public:
	__fastcall virtual TIOleDbDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TIOleDbDatabase(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString(void);
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString 
		AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
	void __fastcall ReleaseDBHandle(Sdcommon::TISqlCommand* ASqlCmd, bool IsFetchAll);
	__property Sdcommon::TISqlCommand* CurSqlCmd = {read=FCurSqlCmd};
	__property Sd_oledb_d5::_di_IDBCreateCommand DBCreateCommand = {read=FIDBCreateCommand};
	__property bool IsMSSQLProv = {read=FIsMSSQLProv, nodefault};
	__property bool MultResultsSupported = {read=FMultResultsSupported, nodefault};
	__property int OutputParamsReturned = {read=FOutputParamsReturned, nodefault};
};


class DELPHICLASS TIOleDbCommand;
class PASCALIMPLEMENTATION TIOleDbCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	Sd_oledb_d5::_di_ICommandText FICommandText;
	Sd_oledb_d5::_di_IMultipleResults FIMultipleResults;
	Sd_oledb_d5::_di_IAccessor FIRowAccessor;
	Sd_oledb_d5::_di_IAccessor FIParamAccessor;
	unsigned FHRowAccessor;
	unsigned FHParamAccessor;
	DBBINDING *FRowBindPtr;
	DBBINDING *FParamBindPtr;
	unsigned *FHRows;
	unsigned FCurrRow;
	unsigned FFetchedRows;
	int FPrefetchRows;
	int FRowsAffected;
	bool FIsSingleConn;
	bool FIsSrvCursor;
	bool FNextResults;
	int FBlobParamsBufferOff;
	int FFirstCalcFieldIdx;
	HIDESBASE TIOleDbDatabase* __fastcall GetSqlDatabase(void);
	bool __fastcall CnvtDBData(AnsiString AFieldName, Db::TFieldType ADataType, void * InBuf, void * Buffer
		, int BufSize);
	Db::TDateTimeRec __fastcall CnvtDBDateTime2DateTimeRec(Db::TFieldType ADataType, void * Buffer, int 
		BufSize);
	void __fastcall InternalExecute(bool bFieldDescribe);
	void __fastcall InternalSpGetParams(void);
	void __fastcall ReleaseRowSet(void);
	void __fastcall ReleaseHRows(void);
	void __fastcall SetICommandProps(void);
	void __fastcall SetICommandText(AnsiString Value);
	void __fastcall SetICmdParameterInfo(void);
	AnsiString __fastcall OleDbDataSourceType(Db::TFieldType FieldType);
	
protected:
	Sd_oledb_d5::_di_IRowset FIRowset;
	void __fastcall AcquireDBHandle(void);
	void __fastcall ReleaseDBHandle(void);
	void __fastcall Check(HRESULT Status);
	virtual void __fastcall Connect(void);
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * 
		Buffer, int BufSize);
	virtual void __fastcall AllocFieldsBuffer(void);
	virtual void __fastcall AllocParamsBuffer(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall FreeFieldsBuffer(void);
	virtual void __fastcall FreeParamsBuffer(void);
	virtual void __fastcall SetFieldsBuffer(void);
	virtual int __fastcall GetFieldsBufferSize(void);
	virtual int __fastcall GetParamsBufferSize(void);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall DoExecDirect(AnsiString ACommandValue);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void __fastcall InitParamList(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void * __fastcall GetHandle(void);
	
public:
	__fastcall virtual TIOleDbCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual void __fastcall Execute(void);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall NextResultSet(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize
		);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	__property bool IsSrvCursor = {read=FIsSrvCursor, nodefault};
	__property TIOleDbDatabase* SqlDatabase = {read=GetSqlDatabase};
public:
	#pragma option push -w-inl
	/* TISqlCommand.Destroy */ inline __fastcall virtual ~TIOleDbCommand(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOleDbSchemaCommand;
class PASCALIMPLEMENTATION TIOleDbSchemaCommand : public TIOleDbCommand 
{
	typedef TIOleDbCommand inherited;
	
protected:
	AnsiString FObjPattern;
	#pragma pack(push, 1)
	GUID FSchemaRowsetGUID;
	#pragma pack(pop)
	
	tagVARIANT *FRestrictions;
	int FRestrictCount;
	virtual void __fastcall CreateRestrictions(void) = 0 ;
	void __fastcall DestroyRestrictions(void);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoPrepare(AnsiString Value);
	
public:
	__fastcall virtual TIOleDbSchemaCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TIOleDbSchemaCommand(void);
	__property AnsiString ObjPattern = {read=FObjPattern, write=FObjPattern};
	__property GUID SchemaRowsetGUID = {read=FSchemaRowsetGUID};
};


class DELPHICLASS TIOleDbSchemaTables;
class PASCALIMPLEMENTATION TIOleDbSchemaTables : public TIOleDbSchemaCommand 
{
	typedef TIOleDbSchemaCommand inherited;
	
private:
	bool FSysTables;
	AnsiString FSchName;
	AnsiString FTblName;
	
protected:
	virtual void __fastcall CreateRestrictions(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOleDbSchemaTables(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
	__property bool SysTables = {read=FSysTables, write=FSysTables, nodefault};
public:
	#pragma option push -w-inl
	/* TIOleDbSchemaCommand.Destroy */ inline __fastcall virtual ~TIOleDbSchemaTables(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOleDbSchemaColumns;
class PASCALIMPLEMENTATION TIOleDbSchemaColumns : public TIOleDbSchemaCommand 
{
	typedef TIOleDbSchemaCommand inherited;
	
private:
	int FColTypeFieldIdx;
	int FColTypeNameLen;
	int FColTypeNameFieldIdx;
	AnsiString __fastcall GetDataTypeName(const int TypeInd);
	
protected:
	virtual void __fastcall CreateRestrictions(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOleDbSchemaColumns(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
public:
	#pragma option push -w-inl
	/* TIOleDbSchemaCommand.Destroy */ inline __fastcall virtual ~TIOleDbSchemaColumns(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOleDbSchemaIndexes;
class PASCALIMPLEMENTATION TIOleDbSchemaIndexes : public TIOleDbSchemaCommand 
{
	typedef TIOleDbSchemaCommand inherited;
	
private:
	int FIdxTypeFieldIdx;
	int FIdxSortFieldIdx;
	
protected:
	virtual void __fastcall CreateRestrictions(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOleDbSchemaIndexes(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
public:
	#pragma option push -w-inl
	/* TIOleDbSchemaCommand.Destroy */ inline __fastcall virtual ~TIOleDbSchemaIndexes(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOleDbSchemaProcs;
class PASCALIMPLEMENTATION TIOleDbSchemaProcs : public TIOleDbSchemaCommand 
{
	typedef TIOleDbSchemaCommand inherited;
	
private:
	int FInParamsFieldIdx;
	int FOutParamsFieldIdx;
	
protected:
	virtual void __fastcall CreateRestrictions(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	
public:
	__fastcall virtual TIOleDbSchemaProcs(Sdcommon::TISqlDatabase* ASqlDatabase);
	virtual bool __fastcall FetchNextRow(void);
public:
	#pragma option push -w-inl
	/* TIOleDbSchemaCommand.Destroy */ inline __fastcall virtual ~TIOleDbSchemaProcs(void) { }
	#pragma option pop
	
};


class DELPHICLASS TIOleDbSchemaProcParams;
class PASCALIMPLEMENTATION TIOleDbSchemaProcParams : public TIOleDbSchemaCommand 
{
	typedef TIOleDbSchemaCommand inherited;
	
protected:
	virtual void __fastcall CreateRestrictions(void);
	
public:
	__fastcall virtual TIOleDbSchemaProcParams(Sdcommon::TISqlDatabase* ASqlDatabase);
public:
	#pragma option push -w-inl
	/* TIOleDbSchemaCommand.Destroy */ inline __fastcall virtual ~TIOleDbSchemaProcParams(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word DBPROP_SKIPROWCOUNTRESULTS = 0x123;
extern PACKAGE GUID IID_IErrorRecords;
extern PACKAGE GUID IID_ISequentialStream;
extern PACKAGE GUID IID_IStream;
extern PACKAGE GUID IID_IStorage;
extern PACKAGE GUID IID_ILockBytes;
extern PACKAGE GUID IID_IDBSchemaRowset;
#define ProgID_SQLOLEDB "SQLOLEDB"
extern PACKAGE GUID CLSID_SQLOLEDB;
extern PACKAGE GUID CLSID_SQLOLEDB_ERROR;
extern PACKAGE GUID CLSID_SQLOLEDB_ENUMERATOR;
extern PACKAGE GUID IID_ISQLServerErrorInfo;
extern PACKAGE GUID IID_IRowsetFastLoad;
extern PACKAGE GUID IID_IUMSInitialize;
extern PACKAGE GUID IID_ISchemaLock;
extern PACKAGE GUID DBGUID_MSSQLXML;
extern PACKAGE GUID DBGUID_XPATH;
extern PACKAGE GUID IID_ICommandStream;
extern PACKAGE GUID IID_ISQLXMLHelper;
extern PACKAGE GUID DBSCHEMA_LINKEDSERVERS;
static const Shortint CRESTRICTIONS_DBSCHEMA_LINKEDSERVERS = 0x1;
extern PACKAGE GUID DBPROPSET_SQLSERVERDATASOURCE;
extern PACKAGE GUID DBPROPSET_SQLSERVERDATASOURCEINFO;
extern PACKAGE GUID DBPROPSET_SQLSERVERDBINIT;
extern PACKAGE GUID DBPROPSET_SQLSERVERROWSET;
extern PACKAGE GUID DBPROPSET_SQLSERVERSESSION;
extern PACKAGE GUID DBPROPSET_SQLSERVERCOLUMN;
extern PACKAGE GUID DBPROPSET_SQLSERVERSTREAM;
static const Word DBPROP_INIT_GENERALTIMEOUT = 0x11c;
static const Shortint SSPROP_ENABLEFASTLOAD = 0x2;
static const Shortint SSPROP_UNICODELCID = 0x2;
static const Shortint SSPROP_UNICODECOMPARISONSTYLE = 0x3;
static const Shortint SSPROP_COLUMNLEVELCOLLATION = 0x4;
static const Shortint SSPROP_CHARACTERSET = 0x5;
static const Shortint SSPROP_SORTORDER = 0x6;
static const Shortint SSPROP_CURRENTCOLLATION = 0x7;
static const Shortint SSPROP_INIT_CURRENTLANGUAGE = 0x4;
static const Shortint SSPROP_INIT_NETWORKADDRESS = 0x5;
static const Shortint SSPROP_INIT_NETWORKLIBRARY = 0x6;
static const Shortint SSPROP_INIT_USEPROCFORPREP = 0x7;
static const Shortint SSPROP_INIT_AUTOTRANSLATE = 0x8;
static const Shortint SSPROP_INIT_PACKETSIZE = 0x9;
static const Shortint SSPROP_INIT_APPNAME = 0xa;
static const Shortint SSPROP_INIT_WSID = 0xb;
static const Shortint SSPROP_INIT_FILENAME = 0xc;
static const Shortint SSPROP_INIT_ENCRYPT = 0xd;
static const Shortint SSPROP_AUTH_REPL_SERVER_NAME = 0xe;
static const Shortint SSPROP_INIT_TAGCOLUMNCOLLATION = 0xf;
static const Shortint SSPROPVAL_USEPROCFORPREP_OFF = 0x0;
static const Shortint SSPROPVAL_USEPROCFORPREP_ON = 0x1;
static const Shortint SSPROPVAL_USEPROCFORPREP_ON_DROP = 0x2;
static const Shortint SSPROP_QUOTEDCATALOGNAMES = 0x2;
static const Shortint SSPROP_ALLOWNATIVEVARIANT = 0x3;
static const Shortint SSPROP_SQLXMLXPROGID = 0x4;
static const Shortint SSPROP_MAXBLOBLENGTH = 0x8;
static const Shortint SSPROP_FASTLOADOPTIONS = 0x9;
static const Shortint SSPROP_FASTLOADKEEPNULLS = 0xa;
static const Shortint SSPROP_FASTLOADKEEPIDENTITY = 0xb;
static const Shortint SSPROP_CURSORAUTOFETCH = 0xc;
static const Shortint SSPROP_DEFERPREPARE = 0xd;
static const Shortint SSPROP_IRowsetFastLoad = 0xe;
static const Shortint SSPROP_COL_COLLATIONNAME = 0xe;
static const Shortint SSPROP_STREAM_MAPPINGSCHEMA = 0xf;
static const Shortint SSPROP_STREAM_XSL = 0x10;
static const Shortint SSPROP_STREAM_BASEPATH = 0x11;
static const Shortint SSPROP_STREAM_COMMANDTYPE = 0x12;
static const Shortint SSPROP_STREAM_XMLROOT = 0x13;
static const Shortint SSPROP_STREAM_FLAGS = 0x14;
static const Shortint SSPROP_STREAM_CONTENTTYPE = 0x17;
static const Shortint STREAM_FLAGS_DISALLOW_URL = 0x1;
static const Shortint STREAM_FLAGS_DISALLOW_ABSOLUTE_PATH = 0x2;
static const Shortint STREAM_FLAGS_DISALLOW_QUERY = 0x4;
static const Shortint STREAM_FLAGS_DONTCACHEMAPPINGSCHEMA = 0x8;
static const Shortint STREAM_FLAGS_DONTCACHETEMPLATE = 0x10;
static const Shortint STREAM_FLAGS_DONTCACHEXSL = 0x20;
static const unsigned STREAM_FLAGS_RESERVED = 0xffff0000;
static const Shortint SSPROPVAL_COMMANDTYPE_REGULAR = 0x15;
static const Shortint SSPROPVAL_COMMANDTYPE_BULKLOAD = 0x16;
static const Byte DBTYPE_SQLVARIANT = 0x90;
#define DefSqlApiDLL ""
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdoledb */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdoledb;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDOleDb
