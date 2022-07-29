// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDCommon.pas' rev: 6.00

#ifndef SDCommonHPP
#define SDCommonHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDConsts.hpp>	// Pascal unit
#include <StrUtils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <FMTBcd.hpp>	// Pascal unit
#include <DBCommon.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdcommon
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<Byte >  TBytes;

typedef TList TObjectList;
;

typedef void *TSDPtr;

typedef char *TSDCharPtr;

typedef void *TSDObjectPtr;

typedef char *TSDValueBuffer;

typedef char *TSDRecordBuffer;

typedef __int64 TInt64;

typedef Db::TDateTimeRec *PDateTimeRec;

typedef void *PSDCursor;

typedef short TSDEResult;

typedef DynamicArray<Byte >  TSDBlobData;

typedef DynamicArray<Byte >  TSDBlobDataArray[1];

typedef TBytes *PSDBlobDataArray;

#pragma option push -b
enum TISqlTransIsolation { itiDirtyRead, itiReadCommitted, itiRepeatableRead };
#pragma option pop

#pragma option push -b
enum TISqlServerType { istSQLBase, istOracle, istSQLServer, istSybase, istDB2, istInformix, istODBC, istInterbase, istFirebird, istMySQL, istPostgreSQL };
#pragma option pop

typedef AnsiString SDCommon__1[11];

class DELPHICLASS TISqlDatabase;
typedef TISqlDatabase* __fastcall (*TInitSqlDatabaseProc)(Classes::TStrings* ADbParams);

#pragma pack(push, 1)
struct TSDHandleRec
{
	Byte SrvType;
} ;
#pragma pack(pop)

typedef TSDHandleRec *PSDHandleRec;

#pragma option push -b
enum TSDSchemaType { stTables, stSysTables, stProcedures, stColumns, stProcedureParams, stIndexes, stPackages };
#pragma option pop

#pragma option push -b
enum TSDDatabaseParam { spMaxBindName, spMaxClientName, spMaxConnectString, spMaxDatabaseName, spMaxErrorMessage, spMaxErrorText, spMaxExtErrorMessage, spMaxJoinedTables, spLongIdentifiers, spShortIdentifiers, spMaxUserName, spMaxPasswordString, spMaxServerName, spMaxFieldName, spMaxTableName, spMaxSPName, spMaxFullTableName, spMaxFullSPName };
#pragma option pop

class DELPHICLASS ESDSqlLibError;
class PASCALIMPLEMENTATION ESDSqlLibError : public Db::EDatabaseError 
{
	typedef Db::EDatabaseError inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall ESDSqlLibError(const AnsiString Msg) : Db::EDatabaseError(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDSqlLibError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Db::EDatabaseError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDSqlLibError(int Ident)/* overload */ : Db::EDatabaseError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDSqlLibError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Db::EDatabaseError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDSqlLibError(const AnsiString Msg, int AHelpContext) : Db::EDatabaseError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDSqlLibError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Db::EDatabaseError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDSqlLibError(int Ident, int AHelpContext)/* overload */ : Db::EDatabaseError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDSqlLibError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Db::EDatabaseError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDSqlLibError(void) { }
	#pragma option pop
	
};


class DELPHICLASS ESDEngineError;
class PASCALIMPLEMENTATION ESDEngineError : public Db::EDatabaseError 
{
	typedef Db::EDatabaseError inherited;
	
private:
	int FNativeError;
	int FErrorCode;
	int FErrorPos;
	
public:
	__fastcall ESDEngineError(int AErrorCode, int ANativeError, const AnsiString Msg, int AErrorPos);
	__fastcall virtual ESDEngineError(int AErrorCode, int ANativeError, const AnsiString Msg);
	__property int ErrorCode = {read=FErrorCode, nodefault};
	__property int NativeError = {read=FNativeError, nodefault};
	__property int ErrorPos = {read=FErrorPos, nodefault};
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDEngineError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Db::EDatabaseError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDEngineError(int Ident)/* overload */ : Db::EDatabaseError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDEngineError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Db::EDatabaseError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDEngineError(const AnsiString Msg, int AHelpContext) : Db::EDatabaseError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDEngineError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Db::EDatabaseError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDEngineError(int Ident, int AHelpContext)/* overload */ : Db::EDatabaseError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDEngineError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Db::EDatabaseError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDEngineError(void) { }
	#pragma option pop
	
};


typedef TMetaClass*ESDEngineErrorClass;

typedef TMetaClass*TISqlCommandClass;

class DELPHICLASS TISqlCommand;
class PASCALIMPLEMENTATION TISqlDatabase : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	bool FAcquiredHandle;
	bool FIsEnableBCD;
	bool FIsRTrimChar;
	bool FIsSingleConn;
	int FMaxFieldNameLen;
	int FMaxStringSize;
	int FBlobPieceSize;
	int FPrefetchRows;
	Classes::TStrings* FDbParams;
	TISqlTransIsolation FTransIsolation;
	bool FInTransaction;
	Classes::TNotifyEvent FResetBusyState;
	Classes::TNotifyEvent FResetIdleTimeOut;
	
protected:
	bool FAutoCommitDef;
	bool FAutoCommit;
	bool FCursorPreservedOnCommit;
	bool FCursorPreservedOnRollback;
	bool FTransSupported;
	bool FProcSupportsCursor;
	bool FProcSupportsCursors;
	virtual void __fastcall DoResetBusyState(void);
	virtual void __fastcall DoResetIdleTimeOut(void);
	virtual void __fastcall DoConnect(const AnsiString sDatabaseName, const AnsiString sUserName, const AnsiString sPassword) = 0 ;
	virtual void __fastcall DoDisconnect(bool Force) = 0 ;
	virtual void __fastcall DoCommit(void) = 0 ;
	virtual void __fastcall DoRollback(void) = 0 ;
	virtual void __fastcall DoStartTransaction(void) = 0 ;
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	
public:
	__fastcall virtual TISqlDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TISqlDatabase(void);
	virtual TISqlCommand* __fastcall CreateSqlCommand(void) = 0 ;
	virtual AnsiString __fastcall GetAutoIncSQL();
	virtual int __fastcall GetClientVersion(void) = 0 ;
	virtual int __fastcall GetServerVersion(void) = 0 ;
	virtual AnsiString __fastcall GetVersionString(void) = 0 ;
	virtual void __fastcall GetStoredProcNames(Classes::TStrings* List);
	virtual void __fastcall GetTableNames(AnsiString Pattern, bool SystemTables, Classes::TStrings* List);
	virtual void __fastcall GetFieldNames(const AnsiString TableName, Classes::TStrings* List);
	virtual TISqlCommand* __fastcall GetSchemaInfo(TSDSchemaType ASchemaType, AnsiString AObjectName);
	virtual void __fastcall Connect(const AnsiString sDatabaseName, const AnsiString sUserName, const AnsiString sPassword);
	virtual void __fastcall Disconnect(bool Force);
	virtual bool __fastcall TestConnected(void) = 0 ;
	virtual void __fastcall Commit(void);
	virtual void __fastcall Rollback(void);
	virtual void __fastcall StartTransaction(void);
	virtual int __fastcall ParamValue(TSDDatabaseParam Value);
	virtual void __fastcall SetTransIsolation(TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	void __fastcall ResetBusyState(void);
	void __fastcall ResetIdleTimeOut(void);
	__property bool AcquiredHandle = {read=FAcquiredHandle, nodefault};
	__property bool AutoCommit = {read=FAutoCommit, nodefault};
	__property bool AutoCommitDef = {read=FAutoCommitDef, nodefault};
	__property bool IsEnableBCD = {read=FIsEnableBCD, nodefault};
	__property bool IsRTrimChar = {read=FIsRTrimChar, nodefault};
	__property bool IsSingleConn = {read=FIsSingleConn, nodefault};
	__property void * Handle = {read=GetHandle, write=SetHandle};
	__property int BlobPieceSize = {read=FBlobPieceSize, nodefault};
	__property bool CursorPreservedOnCommit = {read=FCursorPreservedOnCommit, nodefault};
	__property bool CursorPreservedOnRollback = {read=FCursorPreservedOnRollback, nodefault};
	__property bool InTransaction = {read=FInTransaction, nodefault};
	__property int MaxFieldNameLen = {read=FMaxFieldNameLen, nodefault};
	__property int MaxStringSize = {read=FMaxStringSize, nodefault};
	__property int PrefetchRows = {read=FPrefetchRows, nodefault};
	__property Classes::TStrings* Params = {read=FDbParams};
	__property bool ProcSupportsCursor = {read=FProcSupportsCursor, nodefault};
	__property bool ProcSupportsCursors = {read=FProcSupportsCursors, nodefault};
	__property TISqlTransIsolation TransIsolation = {read=FTransIsolation, write=FTransIsolation, nodefault};
	__property bool TransSupported = {read=FTransSupported, nodefault};
	__property Classes::TNotifyEvent OnResetBusyState = {read=FResetBusyState, write=FResetBusyState};
	__property Classes::TNotifyEvent OnResetIdleTimeOut = {read=FResetIdleTimeOut, write=FResetIdleTimeOut};
};


class DELPHICLASS TSDBufferList;
class PASCALIMPLEMENTATION TSDBufferList : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* FList;
	
public:
	__fastcall TSDBufferList(void);
	__fastcall virtual ~TSDBufferList(void);
	void __fastcall Clear(void);
	void * __fastcall StringToPtr(AnsiString S);
};


class DELPHICLASS TSDFieldDesc;
class PASCALIMPLEMENTATION TSDFieldDesc : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	System::SmallString<50>  FieldName;
	int FieldNo;
	Db::TFieldType FieldType;
	short DataType;
	int DataSize;
	int Offset;
	short Precision;
	short Scale;
	bool Required;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSDFieldDesc(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSDFieldDesc(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSDFieldDescList;
class PASCALIMPLEMENTATION TSDFieldDescList : public Classes::TList 
{
	typedef Classes::TList inherited;
	
public:
	TSDFieldDesc* operator[](int Index) { return FieldDescs[Index]; }
	
private:
	TSDFieldDesc* __fastcall GetFieldDescs(int Index);
	
public:
	__fastcall virtual ~TSDFieldDescList(void);
	virtual void __fastcall Clear(void);
	TSDFieldDesc* __fastcall AddFieldDesc(void);
	void __fastcall ArrangeFieldNames(void);
	TSDFieldDesc* __fastcall FieldDescByName(const AnsiString AFieldName);
	TSDFieldDesc* __fastcall FieldDescByNumber(int AFieldNo);
	__property TSDFieldDesc* FieldDescs[int Index] = {read=GetFieldDescs/*, default*/};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSDFieldDescList(void) : Classes::TList() { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TSDFieldInfo
{
	int FetchStatus;
	int DataSize;
} ;
#pragma pack(pop)

typedef TSDFieldInfo *PSDFieldInfo;

typedef DynamicArray<int >  TIntArray;

typedef TParam TSDHelperParam;
;

typedef TParams TSDHelperParams;
;

typedef Db::TParamType TSDHelperParamType;

#pragma option push -b
enum TSDCommandType { ctQuery, ctTable, ctStoredProc };
#pragma option pop

typedef void __fastcall (__closure *TSDReleaseHandleEvent)(bool SaveRes);

class PASCALIMPLEMENTATION TISqlCommand : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TSDCommandType FCommandType;
	AnsiString FCommandText;
	AnsiString FNativeCommand;
	int FBlobFieldCount;
	TSDFieldDescList* FFieldDescs;
	Db::TParams* FParamsRef;
	char *FParamsBuffer;
	char *FFieldsBuffer;
	int FBlobCacheOffs;
	DynamicArray<int >  FFieldBufOffs;
	int FMaxCharParamSize;
	TSDBufferList* FBufList;
	TISqlDatabase* FSqlDatabase;
	TSDReleaseHandleEvent FReleaseHandle;
	int __fastcall GetFieldBufOffs(int Index);
	bool __fastcall GetPrepared(void);
	TISqlDatabase* __fastcall GetSqlDatabase(void);
	void __fastcall SetParamsRef(Db::TParams* Value);
	
protected:
	void __fastcall AddParam(AnsiString AParamName, Db::TFieldType ADataType, Db::TParamType AParamType);
	void * __fastcall GetFieldBuffer(int AFieldNo, void * SelBuf);
	virtual void __fastcall DoReleaseHandle(bool SaveRes);
	virtual void __fastcall AllocParamsBuffer(void);
	virtual void __fastcall AllocFieldsBuffer(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall FreeParamsBuffer(void);
	virtual void __fastcall FreeFieldsBuffer(void);
	virtual void __fastcall SetFieldsBuffer(void);
	virtual void __fastcall DoPrepare(AnsiString ACommandValue) = 0 ;
	virtual void __fastcall DoExecDirect(AnsiString ACommandValue) = 0 ;
	virtual void __fastcall DoExecute(void) = 0 ;
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * Buffer, int BufSize);
	virtual void __fastcall InitParamList(void);
	void __fastcall ClearFieldDescs(void);
	virtual void __fastcall FetchBlobFields(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	TSDFieldDesc* __fastcall FieldDescByName(const AnsiString AFieldName);
	virtual void __fastcall GetFieldDescs(TSDFieldDescList* Descs);
	virtual char * __fastcall GetFieldsBuffer(void);
	virtual int __fastcall GetFieldsBufferSize(void);
	virtual void * __fastcall GetHandle(void);
	virtual int __fastcall GetParamsBufferSize(void);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	int __fastcall NativeParamSize(Db::TParam* Param);
	void __fastcall ParseFieldNames(const AnsiString theSelect, Classes::TStrings* FldInfo);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	void __fastcall SetCommandText(AnsiString Value);
	void __fastcall SetNativeCommand(AnsiString Value);
	__property TSDBufferList* BufList = {read=FBufList};
	__property AnsiString NativeCommand = {read=FNativeCommand};
	__property char * ParamsBuffer = {read=FParamsBuffer};
	__property char * FieldsBuffer = {read=GetFieldsBuffer};
	__property int FieldBufOffs[int Index] = {read=GetFieldBufOffs};
	
public:
	__fastcall virtual TISqlCommand(TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TISqlCommand(void);
	void __fastcall SaveResults(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual void __fastcall InitNewCommand(void);
	virtual void __fastcall ExecDirect(AnsiString ACommandValue);
	virtual void __fastcall Execute(void);
	virtual int __fastcall GetAutoIncValue(void);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall NextResultSet(void);
	virtual void __fastcall Prepare(AnsiString ACommandValue);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual void __fastcall InitFieldDescs(void);
	virtual bool __fastcall GetCnvtFieldData(TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize);
	TBytes __fastcall GetBlobValue(TSDFieldDesc* AFieldDesc);
	virtual void __fastcall GetOutputParams(void);
	void __fastcall PutBlobValue(TSDFieldDesc* AFieldDesc, TBytes sBlobValue);
	virtual int __fastcall ReadBlob(TSDFieldDesc* AFieldDesc, TBytes &BlobData);
	virtual int __fastcall WriteBlob(int FieldNo, const char * Buffer, int Count);
	virtual int __fastcall WriteBlobByName(AnsiString Name, const char * Buffer, int Count);
	bool __fastcall GetFieldAsInt64(Word AFieldNo, __int64 &Value);
	bool __fastcall GetFieldAsInt16(Word AFieldNo, short &Value);
	bool __fastcall GetFieldAsInt32(Word AFieldNo, int &Value);
	bool __fastcall GetFieldAsFloat(Word AFieldNo, double &Value);
	bool __fastcall GetFieldAsString(Word AFieldNo, AnsiString &Value);
	__property int BlobCacheOffs = {read=FBlobCacheOffs, nodefault};
	__property int BlobFieldCount = {read=FBlobFieldCount, nodefault};
	__property TSDCommandType CommandType = {read=FCommandType, write=FCommandType, nodefault};
	__property AnsiString CommandText = {read=FCommandText};
	__property TSDFieldDescList* FieldDescs = {read=FFieldDescs};
	__property void * Handle = {read=GetHandle};
	__property int MaxCharParamSize = {read=FMaxCharParamSize, nodefault};
	__property Db::TParams* Params = {read=FParamsRef, write=SetParamsRef};
	__property bool Prepared = {read=GetPrepared, nodefault};
	__property TISqlDatabase* SqlDatabase = {read=GetSqlDatabase};
	__property TSDReleaseHandleEvent OnReleaseHandle = {read=FReleaseHandle, write=FReleaseHandle};
};


class DELPHICLASS TSDExprParser;
class PASCALIMPLEMENTATION TSDExprParser : public Dbcommon::TExprParser 
{
	typedef Dbcommon::TExprParser inherited;
	
private:
	Db::TDataSet* FDataSet;
	Classes::TStringList* FFilteredFields;
	Word __fastcall GetLiteralStart(int StartPtr);
	Dbcommon::TCANOperator __fastcall GetNodeOperator(int NodePtr);
	Variant __fastcall GetNodeValue(int StartPos, int NodePos);
	Variant __fastcall GetUnaryNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetBinaryNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetCompareNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetConstNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetFieldNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetFuncNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetListNodeValue(int StartPtr, int NodePtr);
	Variant __fastcall GetOpInValue(const Variant &V1, const Variant &V2);
	Variant __fastcall GetOpLikeValue(const Variant &V1, const Variant &V2);
	Db::TField* __fastcall FieldByName(const AnsiString FieldName);
	
public:
	__fastcall TSDExprParser(Db::TDataSet* DataSet, const AnsiString Text, Db::TFilterOptions Options, Dbcommon::TParserOptions ParserOptions, const AnsiString FieldName, Classes::TBits* DepFields, const Byte * FieldMap);
	__fastcall virtual ~TSDExprParser(void);
	bool __fastcall CalcBooleanValue(void);
	Variant __fastcall CalcVariantValue();
	void __fastcall ClearFields(void);
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint MAXFIELDNAMELEN = 0x32;
static const Byte DEFMAXCHARPARAMLEN = 0xff;
static const Byte DEFMAXFIELDSTRINGSIZE = 0xff;
static const Word DEF_BLOB_PIECE_SIZE = 0x7ff0;
static const Shortint MAX_BCDFIELD_PREC = 0x14;
static const Shortint MAX_BCDFIELD_SCALE = 0x4;
static const Shortint MAX_INTFIELD_PREC = 0xa;
static const Shortint MAX_SINTFIELD_PREC = 0x5;
static const Shortint indTRUNC = 0xfffffffe;
static const Shortint indNULL = 0xffffffff;
static const Shortint indVALUE = 0x0;
static const Shortint fldstUNKNOWN = 0x0;
static const Shortint fldstMEMO = 0x10;
static const Shortint fldstBINARY = 0x11;
static const Shortint fldstHMEMO = 0x12;
static const Shortint fldstHBINARY = 0x13;
static const Shortint fldstHCFILE = 0x14;
static const Shortint fldstHBFILE = 0x15;
#define ServerDelimiters ":@"
static const Shortint SizeOfGuidString = 0x26;
static const Shortint SizeOfGuidBinary = 0x10;
extern PACKAGE AnsiString ServerTypeNames[11];
#define CLRHelperDLL "SQLDIRHN.DLL"
extern PACKAGE bool __fastcall IsOldPrefixExists(const AnsiString AParamName, const AnsiString OldPrefix);
extern PACKAGE bool __fastcall IsSelectQuery(const AnsiString SQL);
extern PACKAGE AnsiString __fastcall IsLiveQuery(const AnsiString SQL);
extern PACKAGE void __fastcall MoveString(AnsiString SrcStr, int SrcPos, AnsiString &DestStr, int DestPos, int Count);
extern PACKAGE void __fastcall CreateParamsFromSQL(Db::TParams* List, const AnsiString SQL, char ParamPrefix);
extern PACKAGE AnsiString __fastcall ExtractColumnName(const AnsiString AFieldInfo);
extern PACKAGE AnsiString __fastcall GenerateSQL(Db::TUpdateStatus UpdateStatus, Db::TUpdateMode UpdateMode, const AnsiString TableName, Classes::TStrings* FieldInfo, Db::TFields* Fields, bool QuoteIdent);
extern PACKAGE AnsiString __fastcall RepeatChar(char Ch, AnsiString S);
extern PACKAGE AnsiString __fastcall QuoteIdentifier(AnsiString AName, bool UseQuote);
extern PACKAGE AnsiString __fastcall CreateProcedureCallCommand(AnsiString AProcName, Db::TParams* AParams, bool IsMSSQL);
extern PACKAGE AnsiString __fastcall ReplaceParamMarkers(AnsiString OldStmt, Db::TParams* AParams);
extern PACKAGE void __fastcall StrRTrim(char * S);
extern PACKAGE bool __fastcall IsNameDelimiter(char C);
extern PACKAGE bool __fastcall IsLiteral(char C);
extern PACKAGE AnsiString __fastcall StripLiterals(const AnsiString Str);
extern PACKAGE int __fastcall LocateText(const AnsiString Substr, const AnsiString S);
extern PACKAGE int __fastcall StrFindFromPos(const AnsiString Substr, const AnsiString S, int StartPos);
extern PACKAGE bool __fastcall ReplaceString(bool Once, AnsiString OldStr, AnsiString NewStr, AnsiString &ResultStr);
extern PACKAGE bool __fastcall IsBlobType(Db::TFieldType FieldType);
extern PACKAGE bool __fastcall IsSupportedBlobTypes(Db::TFieldType FieldType);
extern PACKAGE bool __fastcall IsRequiredSizeTypes(Db::TFieldType FieldType);
extern PACKAGE bool __fastcall IsDateTimeType(Db::TFieldType FieldType);
extern PACKAGE bool __fastcall IsNumericType(Db::TFieldType FieldType);
extern PACKAGE AnsiString __fastcall GetAppName();
extern PACKAGE AnsiString __fastcall GetModuleFileNameStr(unsigned hModule);
extern PACKAGE AnsiString __fastcall GetHostName();
extern PACKAGE AnsiString __fastcall GetSQLDirectVersion();
extern PACKAGE AnsiString __fastcall GetSqlLibParamName(int ServerTypeCode);
extern PACKAGE AnsiString __fastcall ExtractLibName(const AnsiString LibNames, char Sep, int &Pos);
extern PACKAGE AnsiString __fastcall ExtractStoredProcName(const AnsiString sFullProcName);
extern PACKAGE AnsiString __fastcall ExtractServerName(const AnsiString sRemoteDatabase);
extern PACKAGE AnsiString __fastcall ExtractDatabaseName(const AnsiString sRemoteDatabase);
extern PACKAGE bool __fastcall ContainsLikeWildcards(const AnsiString s);
extern PACKAGE bool __fastcall ExtractOwnerObjNames(const AnsiString AFullObjName, AnsiString &AOwnerName, AnsiString &AObjName);
extern PACKAGE int __fastcall GetFileVersion(const AnsiString FileName);
extern PACKAGE void __fastcall ReadFileVersInfo(const AnsiString FileName, AnsiString &ProductName, AnsiString &VersStr);
extern PACKAGE int __fastcall HelperCompareStr(const AnsiString S1, const AnsiString S2);
extern PACKAGE int __fastcall HelperCompareText(const AnsiString S1, const AnsiString S2);
extern PACKAGE bool __fastcall VarIsStrType(const Variant &AValue);
extern PACKAGE int __fastcall CompareVar(const Variant &V1, const Variant &V2, bool CaseInsensitive);
extern PACKAGE bool __fastcall VarIsEqual(const Variant &AVar1, const Variant &AVar2, bool CaseInsensitive, bool PartialKey, bool AtStartOnly);
extern PACKAGE int __fastcall MaxIntValue(int A, int B);
extern PACKAGE int __fastcall MinIntValue(int A, int B);
extern PACKAGE Word __fastcall GetMajorVer(int Ver);
extern PACKAGE Word __fastcall GetMinorVer(int Ver);
extern PACKAGE int __fastcall MakeVerValue(Word MajorVer, Word MinorVer);
extern PACKAGE int __fastcall VersionStringToDWORD(const AnsiString VerStr);
extern PACKAGE System::TDateTime __fastcall SqlDateToDateTime(AnsiString Value);
extern PACKAGE System::TDateTime __fastcall SqlTimeToDateTime(AnsiString Value);
extern PACKAGE double __fastcall SqlStrToFloatDef(AnsiString Value, double Default);
extern PACKAGE bool __fastcall SqlStrToBoolean(AnsiString Value);
extern PACKAGE AnsiString __fastcall CnvtVarBytesToHexString(const Variant &Value);
extern PACKAGE void __fastcall GuidToCharBuffer(char * SrcBuf, int SrcBufLen, char * DstBuf, int DstBufLen);
extern PACKAGE void __fastcall ParseTableFieldsFromSQL(const AnsiString theSelect, const Classes::TStrings* FieldList, Classes::TStrings* FldInfo, Classes::TStrings* TblInfo);
extern PACKAGE TSDFieldInfo __fastcall GetFieldInfoStruct(void * Buffer, int Offset);
extern PACKAGE void __fastcall SetFieldInfoStruct(void * Buffer, int Offset, const TSDFieldInfo &Value);
extern PACKAGE int __fastcall GetFieldInfoDataSizeOff(void);
extern PACKAGE int __fastcall GetFieldInfoFetchStatusOff(void);
extern PACKAGE TBytes __fastcall GetFieldBlobData(char * RecBuf, int ABlobCacheOffs, int AFieldOffset);
extern PACKAGE int __fastcall GetFieldBlobDataSize(char * RecBuf, int ABlobCacheOffs, int AFieldOffset);
extern PACKAGE void __fastcall SetFieldBlobData(char * RecBuf, int ABlobCacheOffs, int AFieldOffset, TBytes Value);
extern PACKAGE Byte __fastcall HelperMemReadByte(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWriteByte(const void * Ptr, int Offset, Byte Value);
extern PACKAGE short __fastcall HelperMemReadInt16(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWriteInt16(const void * Ptr, int Offset, short Value);
extern PACKAGE int __fastcall HelperMemReadInt32(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWriteInt32(const void * Ptr, int Offset, int Value);
extern PACKAGE __int64 __fastcall HelperMemReadInt64(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWriteInt64(const void * Ptr, int Offset, __int64 Value);
extern PACKAGE double __fastcall HelperMemReadDouble(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWriteDouble(const void * Ptr, int Offset, double Value);
extern PACKAGE float __fastcall HelperMemReadSingle(const void * Ptr, int Offset);
extern PACKAGE void * __fastcall HelperMemReadPtr(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWritePtr(const void * Ptr, int Offset, void * Value);
extern PACKAGE bool __fastcall HelperCurrToBCD(System::Currency Curr, void * BCDPtr, int Precision = 0x20, int Decimals = 0x4);
extern PACKAGE Db::TDateTimeRec __fastcall HelperMemReadDateTimeRec(const void * Ptr, int Offset);
extern PACKAGE void __fastcall HelperMemWriteDateTimeRec(const void * Ptr, int Offset, const Db::TDateTimeRec &Value);
extern PACKAGE void __fastcall HelperMemWriteGuid(const void * Ptr, int Offset, const GUID &Value);
extern PACKAGE void __fastcall HelperMemWriteString(const void * Ptr, int Offset, AnsiString Value, int Count);
extern PACKAGE AnsiString __fastcall HelperPtrToString(const void * Ptr, int Len = 0xffffffff);
extern PACKAGE void __fastcall HelperAssignParamValue(Db::TParam* AParam, const Db::TDateTimeRec &Value);
extern PACKAGE void * __fastcall IncPtr(const void * ptr, int Delta);
extern PACKAGE void * __fastcall SafeReallocMem(const void * OldPtr, int Size);
extern PACKAGE void __fastcall SafeCopyMem(void * Src, void * Dest, int Count);
extern PACKAGE void __fastcall SafeInitMem(void * Buffer, int Count, Byte InitByte);
extern PACKAGE unsigned __fastcall HelperLoadLibrary(AnsiString ALibFileName);

}	/* namespace Sdcommon */
using namespace Sdcommon;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDCommon
