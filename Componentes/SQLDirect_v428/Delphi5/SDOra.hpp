// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDOra.pas' rev: 5.00

#ifndef SDOraHPP
#define SDOraHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdora
{
//-- type declarations -------------------------------------------------------
typedef int eword;

typedef int uword;

typedef int sword;

typedef int size_t;

typedef BOOL OraBoolean;

typedef char *PText;

typedef char * *PPText;

typedef char *POraText;

typedef Shortint eb1;

typedef Byte ub1;

typedef Shortint sb1;

typedef short eb2;

typedef Word ub2;

typedef short sb2;

typedef int eb4;

typedef int ub4;

typedef int sb4;

typedef int ubig_ora;

typedef int sbig_ora;

typedef void *dvoid;

typedef void * *Pdvoid;

typedef Pdvoid *PPdvoid;

typedef Shortint *eb1p;

typedef Byte *ub1p;

typedef Shortint *sb1p;

typedef short *eb2p;

typedef Word *ub2p;

typedef ub2p *ub2pp;

typedef short *sb2p;

typedef int *eb4p;

typedef int *ub4p;

typedef ub4p *ub4pp;

typedef int *sb4p;

struct cda_head
{
	short v2_rc;
	Word ft;
	int rpc;
	Word peo;
	Byte fc;
	Byte rcs1;
	Word rc;
	Byte wrn;
	Byte rcs2;
	int rcs3;
	int rcs4;
	Word rcs5;
	Byte rcs6;
	int rcs7;
	Word rcs8;
	int ose;
	Byte chk;
	void *rcsp;
} ;

struct rd
{
	int rcs4;
	Word rcs5;
	Byte rcs6;
} ;

struct rid
{
	rd r;
	int rcs7;
	Word rcs8;
} ;

struct cda_def
{
	short v2_rc;
	Word ft;
	int rpc;
	Word peo;
	Byte fc;
	Byte rcs1;
	Word rc;
	Byte wrn;
	Byte rcs2;
	int rcs3;
	rid rowid;
	int ose;
	Byte chk;
	void *rcsp;
	Byte rcs9[16];
} ;

typedef cda_def  TCdaDef;

typedef cda_def  Lda_Def;

typedef cda_def  TLdaDef;

typedef int THdaDef[64];

typedef int *PHdaDef;

typedef cda_def *PCdaDef;

typedef cda_def *PLdaDef;

typedef void *OCIEnv;

typedef void *OCIError;

typedef void *OCISvcCtx;

typedef void *OCIStmt;

typedef void *OCIBind;

typedef void *OCIDefine;

typedef void *OCIDescribe;

typedef void *OCIServer;

typedef void *OCISession;

typedef void *OCIComplexObject;

typedef void *OCITrans;

typedef void *OCISecurity;

typedef void *OCICPool;

typedef void *OCISPool;

typedef void *OCIAuthInfo;

typedef void * *POCIEnv;

typedef void * *POCIError;

typedef void * *POCISvcCtx;

typedef void * *POCIStmt;

typedef void * *POCIBind;

typedef POCIBind *PPOCIBind;

typedef void * *POCIDefine;

typedef void * *POCIDescribe;

typedef void * *POCIServer;

typedef void * *POCISession;

typedef void * *POCICPool;

typedef void * *POCISPool;

typedef void * *POCIAuthInfo;

typedef void * *POCISnapshot;

typedef void * *POCILobLocator;

typedef void * *POCIResult;

typedef void * *POCIParam;

typedef void * *POCIComplexObjectComp;

typedef void * *POCIRowid;

typedef void * *POCIDateTime;

typedef void * *POCIInterval;

typedef void *OCISnapshot;

typedef void *OCIResult;

typedef void *OCILobLocator;

typedef void *OCIParam;

typedef void *OCIComplexObjectComp;

typedef void *OCIRowid;

typedef void *OCIDateTime;

typedef void *OCIInterval;

typedef void *OCIUcb;

typedef void *OCIServerDNs;

typedef void *OCIClobLocator;

typedef void *OCIBlobLocator;

typedef void *OCIBFileLocator;

typedef int OCILobOffset;

typedef int OCILobLength;

typedef int OCILobMode;

typedef void *OCIRef;

typedef void * *POCIRef;

typedef short OCIInd;

typedef short *POCIInd;

typedef int OCIPinOpt;

typedef int *POCIPinOpt;

typedef int OCILockOpt;

typedef int *POCILockOpt;

typedef int OCIMarkOpt;

typedef int *POCIMarkOpt;

typedef Word OCIDuration;

typedef Word *POCIDuration;

typedef int OCIRefreshOpt;

typedef int *POCIRefreshOpt;

typedef Word OCITypeCode;

typedef int OCITypeGetOpt;

typedef int *POCITypeGetOpt;

typedef int OCITypeEncap;

typedef int *POCITypeEncap;

typedef int OCITypeMethodFlag;

typedef int *POCITypeMethodFlag;

typedef int OCITypeParamMode;

typedef int *POCITypeParamMode;

typedef int OCICoherency;

typedef void *OCIType;

typedef void * *POCIType;

typedef void *OCITypeElem;

typedef void * *POCITypeElem;

typedef void *OCITypeMethod;

typedef void * *POCITypeMethod;

typedef char * *PPChar;

typedef int __cdecl (*TOCICallbackInBind)(Pdvoid ictxp, POCIBind phBind, int iter, int index, PPdvoid 
	bufpp, ub4p alenp, ub1p piecep, PPdvoid indpp);

typedef int __cdecl (*TOCICallbackOutBind)(Pdvoid octxp, POCIBind phBind, int iter, int index, PPdvoid 
	bufpp, ub4pp alenpp, ub1p piecep, PPdvoid indpp, ub2pp rcodepp);

typedef int __cdecl (*TOCICallbackDefine)(Pdvoid octxp, POCIDefine phDefn, int iter, PPdvoid bufpp, 
	ub4pp alenpp, ub1p piecep, PPdvoid indpp, ub2pp rcodepp);

typedef int __cdecl (*TOCICallbackLobRead)(Pdvoid ctxp, const Pdvoid bufp, int len, Byte piece);

typedef int __cdecl (*TOCICallbackLobWrite)(Pdvoid ctxp, Pdvoid bufp, ub4p lenp, ub1p piece);

typedef int __cdecl (*TOCICallbackFailover)(Pdvoid svcctx, Pdvoid envctx, Pdvoid fo_ctx, int fo_type
	, int fo_event);

struct TOCIFocbkStruct
{
	TOCICallbackFailover callback_function;
	void * *fo_ctx;
} ;

typedef Pdvoid __cdecl (*Tmalocfp)(Pdvoid ctxp, int size);

typedef Pdvoid __cdecl (*Tralocfp)(Pdvoid ctxp, Pdvoid memptr, int newsize);

typedef void __cdecl (*Tmfreefp)(Pdvoid ctxp, Pdvoid memptr);

typedef int __cdecl (*TCBLobRead)(Pdvoid ctxp, const Pdvoid bufp, int len, Byte piece);

typedef int __cdecl (*TCBLobWrite)(Pdvoid ctxp, Pdvoid bufp, ub4p len, ub1p piece);

class DELPHICLASS ESDOraError;
class PASCALIMPLEMENTATION ESDOraError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDOraError(int AErrorCode, int ANativeError, const AnsiString 
		Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDOraError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDOraError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDOraError(int Ident)/* overload */ : Sdcommon::ESDEngineError(
		Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDOraError(int Ident, const System::TVarRec * Args, 
		const int Args_Size)/* overload */ : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDOraError(const AnsiString Msg, int AHelpContext) : 
		Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDOraError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDOraError(int Ident, int AHelpContext)/* overload */
		 : Sdcommon::ESDEngineError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDOraError(System::PResStringRec ResStringRec, 
		const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(
		ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDOraError(void) { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TIOraConnInfo
{
	Byte ServerType;
	cda_def *LdaPtr;
	int *HdaPtr;
	cda_def *CdaPtr;
} ;
#pragma pack(pop)

class DELPHICLASS TIOraDatabase;
class PASCALIMPLEMENTATION TIOraDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	bool FIsEnableInts;
	void __fastcall Check(short Status);
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(void);
	PCdaDef __fastcall GetCurHandle(void);
	PLdaDef __fastcall GetLdaPtr(void);
	int __fastcall GetMaxCharParamLen(void);
	virtual void __fastcall GetStmtResult(const AnsiString Stmt, Classes::TStrings* List);
	void __fastcall SetDefaultOptions(void);
	
protected:
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString ARemoteDatabase, const AnsiString AUserName, const 
		AnsiString APassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	__property bool IsEnableInts = {read=FIsEnableInts, nodefault};
	__property PCdaDef CurHandle = {read=GetCurHandle};
	__property PLdaDef LdaPtr = {read=GetLdaPtr};
	
public:
	__fastcall virtual TIOraDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TIOraDatabase(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString(void);
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString 
		AObjectName);
	virtual int __fastcall ParamValue(Sdcommon::TSDDatabaseParam Value);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
};


class DELPHICLASS TIOraCommand;
class PASCALIMPLEMENTATION TIOraCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void *FHandle;
	AnsiString FStmt;
	void *FParamHandle;
	bool FBoundParams;
	bool FIsCursorParamExists;
	bool FIsGetFieldDescs;
	HIDESBASE TIOraDatabase* __fastcall GetSqlDatabase(void);
	void __fastcall Connect(void);
	void __fastcall CloseParamHandle(void);
	void __fastcall InternalExecute(void);
	void __fastcall InternalGetParams(void);
	void __fastcall QBindParamsBuffer(void);
	void __fastcall SpBindParamsBuffer(void);
	
protected:
	void __fastcall Check(short Status);
	bool __fastcall IsPLSQLBlockExecuted(void);
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * 
		Buffer, int BufSize);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall FreeParamsBuffer(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall SetFieldsBuffer(void);
	
public:
	__fastcall virtual TIOraCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TIOraCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize
		);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	virtual int __fastcall WriteBlob(int FieldNo, const char * Buffer, int Count);
	virtual int __fastcall WriteBlobByName(AnsiString Name, const char * Buffer, int Count);
	__property TIOraDatabase* SqlDatabase = {read=GetSqlDatabase};
};


#pragma pack(push, 1)
struct TIOra8ConnInfo
{
	Byte ServerType;
	void * *phEnv;
	void * *phErr;
	void * *phSvc;
	void * *phSrv;
	void * *phUsr;
} ;
#pragma pack(pop)

class DELPHICLASS TIOra8Database;
class PASCALIMPLEMENTATION TIOra8Database : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	bool FIsEnableInts;
	bool FIsXAConn;
	bool FUseOCIDateTime;
	AnsiString FSessTimeZone;
	bool FTempLobSupported;
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(bool Force);
	TIOra8ConnInfo __fastcall GetConnInfoStruct(void);
	int __fastcall GetMaxCharParamLen(void);
	POCIEnv __fastcall GetEnvPtr(void);
	POCIError __fastcall GetErrPtr(void);
	POCISvcCtx __fastcall GetSvcPtr(void);
	POCIServer __fastcall GetSrvPtr(void);
	POCISession __fastcall GetUsrPtr(void);
	void __fastcall GetStmtResult(const AnsiString Stmt, Classes::TStrings* List);
	void __fastcall SetConnInfoStruct(const TIOra8ConnInfo &Value);
	
protected:
	void __fastcall Check(short Status);
	void __fastcall CheckExt(short Status, POCIStmt AStmt);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const 
		AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	__property bool IsEnableInts = {read=FIsEnableInts, nodefault};
	__property bool IsXAConn = {read=FIsXAConn, nodefault};
	__property POCISvcCtx SvcPtr = {read=GetSvcPtr};
	__property POCIServer SrvPtr = {read=GetSrvPtr};
	__property POCISession UsrPtr = {read=GetUsrPtr};
	
public:
	__fastcall virtual TIOra8Database(Classes::TStrings* ADbParams);
	__fastcall virtual ~TIOra8Database(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString(void);
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString 
		AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
	bool __fastcall IsOra8BlobMode(void);
	bool __fastcall IsOra8BlobType(Db::TFieldType ADataType);
	bool __fastcall IsLocFieldSubType(Word ASubType);
	__property POCIEnv EnvPtr = {read=GetEnvPtr};
	__property POCIError ErrPtr = {read=GetErrPtr};
	__property AnsiString SessTimeZone = {read=FSessTimeZone};
	__property bool UseOCIDateTime = {read=FUseOCIDateTime, nodefault};
	__property bool TempLobSupported = {read=FTempLobSupported, nodefault};
};


typedef int __fastcall (*TOra8_get_cbf_get_long)(TOCICallbackDefine cbf_stdcall);

struct TBindLobInfo
{
	void * *phBind;
	int ParamIdx;
} ;

typedef DynamicArray<TBindLobInfo >  TBindLobArray;

struct TBindLobRec
{
	void * *EnvPtr;
	void * *ErrPtr;
	int ColCount;
	int RowCount;
	void *BindInfoPtr;
	void *LobLocPtr;
	int *LobLenPtr;
} ;

class DELPHICLASS TIOra8LobParams;
class PASCALIMPLEMENTATION TIOra8LobParams : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	void *FBindLobPtr;
	bool FExternalLobPtr;
	TBindLobInfo __fastcall GetBindInfo(int Index);
	POCIEnv __fastcall GetEnvPtr(void);
	POCIError __fastcall GetErrPtr(void);
	int __fastcall GetColCount(void);
	int __fastcall GetRowCount(void);
	void * __fastcall GetBindInfoPtr(void);
	void * __fastcall GetLobLocArrayPtr(void);
	void * __fastcall GetLobLenArrayPtr(void);
	void __fastcall SetBindInfo(int Index, const TBindLobInfo &Value);
	
public:
	__fastcall TIOra8LobParams(TIOra8Database* ASqlDatabase)/* overload */;
	__fastcall TIOra8LobParams(void * ABindLobPtr)/* overload */;
	__fastcall virtual ~TIOra8LobParams(void);
	void * __fastcall GetAddrLobLen(int iRow, int iCol);
	POCILobLocator __fastcall GetLobLocator(int iRow, int iCol);
	void __fastcall SetLobLocator(int iRow, int iCol, POCILobLocator Value);
	void __fastcall SetLobArraySize(int ARows, int ACols);
	__property TBindLobInfo BindInfo[int Index] = {read=GetBindInfo, write=SetBindInfo};
	__property void * BindLobPtr = {read=FBindLobPtr};
	__property POCIEnv EnvPtr = {read=GetEnvPtr};
	__property POCIError ErrPtr = {read=GetErrPtr};
	__property int ColCount = {read=GetColCount, nodefault};
	__property int RowCount = {read=GetRowCount, nodefault};
};


class DELPHICLASS TIOra8Command;
class PASCALIMPLEMENTATION TIOra8Command : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void * *FHandle;
	AnsiString FStmt;
	void * *FParamHandle;
	bool FBoundParams;
	bool FIsGetFieldDescs;
	bool FIsCursorParamExists;
	TIOra8LobParams* FBindLobs;
	POCIError __fastcall GetErrPtr(void);
	POCISvcCtx __fastcall GetSvcPtr(void);
	HIDESBASE TIOra8Database* __fastcall GetSqlDatabase(void);
	int __fastcall GetStmtExecuteMode(void);
	bool __fastcall GetTempLobSupported(void);
	void __fastcall Connect(void);
	void __fastcall CloseParamHandle(void);
	bool __fastcall IsFileLocDataType(int ExtDataType);
	bool __fastcall IsOra8BlobDataType(int ExtDataType);
	bool __fastcall IsOra8BlobType(Db::TFieldType ADataType);
	bool __fastcall IsPLSQLBlock(void);
	bool __fastcall IsSelectStmt(void);
	void __fastcall ClearFieldsExtraData(void);
	bool __fastcall IsInterval(Sdcommon::TSDFieldDesc* FieldDesc);
	bool __fastcall IsOra9DateTime(int ExtDataType);
	int __fastcall GetOCIDateTimeDesc(int ExtDataType);
	Db::TDateTimeRec __fastcall Ora9CnvtDBDateTime2DateTimeRec(Sdcommon::TSDFieldDesc* AFieldDesc, char * 
		Buffer, int BufSize);
	System::Currency __fastcall Ora9CnvtDBInterval2Currency(Sdcommon::TSDFieldDesc* AFieldDesc, char * 
		Buffer, int BufSize);
	void __fastcall SetOCIDateTime(Db::TFieldType FieldType, System::TDateTime Value, POCIDateTime phDateTime
		);
	void __fastcall WriteLobParams(void);
	void __fastcall InternalExecute(void);
	void __fastcall InternalGetParams(void);
	void __fastcall QBindParamsBuffer(void);
	void __fastcall SpBindParamsBuffer(void);
	
protected:
	void __fastcall Check(short Status);
	void __fastcall CheckStmt(short Status);
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * 
		Buffer, int BufSize);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall FreeParamsBuffer(void);
	virtual void __fastcall FreeFieldsBuffer(void);
	virtual void __fastcall SetFieldsBuffer(void);
	int __fastcall GetLobType(Db::TBlobType BlobType, bool IsTempLob);
	int __fastcall ReadHLobField(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	int __fastcall ReadLobData(POCILobLocator phLob, Sdcommon::TBytes &BlobData);
	int __fastcall WriteLobData(POCILobLocator phLob, const char * Buffer, int Count);
	__property POCIError ErrPtr = {read=GetErrPtr};
	__property POCISvcCtx SvcPtr = {read=GetSvcPtr};
	__property bool TempLobSupported = {read=GetTempLobSupported, nodefault};
	
public:
	__fastcall virtual TIOra8Command(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TIOra8Command(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual void __fastcall Execute(void);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize
		);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	virtual int __fastcall WriteBlob(int FieldNo, const char * Buffer, int Count);
	virtual int __fastcall WriteBlobByName(AnsiString Name, const char * Buffer, int Count);
	__property TIOra8Database* SqlDatabase = {read=GetSqlDatabase};
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint FetRTru = 0x1;
static const Shortint FetRSin = 0x2;
static const Shortint FetRDnn = 0x3;
static const Shortint FetRNof = 0x4;
static const Shortint FetRDtn = 0x5;
static const Shortint FetRDnd = 0x6;
static const Shortint FetRNul = 0xffffffff;
static const Shortint CHAR_BIT = 0x8;
static const Shortint SCHAR_MIN = 0xffffff80;
static const Shortint SCHAR_MAX = 0x7f;
static const Byte UCHAR_MAX = 0xff;
static const Shortint CHAR_MIN = 0x0;
static const Byte CHAR_MAX = 0xff;
static const Shortint MB_LEN_MAX = 0x2;
static const short SHRT_MIN = 0xffff8000;
static const Word SHRT_MAX = 0x7fff;
static const Word USHRT_MAX = 0xffff;
static const int INT_MIN = 0x80000000;
static const int INT_MAX = 0x7fffffff;
static const unsigned UINT_MAX = 0xffffffff;
static const int LONG_MIN = 0x80000000;
static const int LONG_MAX = 0x7fffffff;
static const unsigned ULONG_MAX = 0xffffffff;
static const int EWORDMAXVAL = 0x7fffffff;
static const Shortint EWORDMINVAL = 0x0;
static const unsigned UWORDMAXVAL = 0xffffffff;
static const Shortint UWORDMINVAL = 0x0;
static const int SWORDMAXVAL = 0x7fffffff;
static const int SWORDMINVAL = 0x80000000;
static const Word MINEWORDMAXVAL = 0x7fff;
static const Shortint MAXEWORDMINVAL = 0x0;
static const Word MINUWORDMAXVAL = 0xffff;
static const Shortint MAXUWORDMINVAL = 0x0;
static const Word MINSWORDMAXVAL = 0x7fff;
static const short MAXSWORDMINVAL = 0xffff8001;
static const Shortint EB1MAXVAL = 0x7f;
static const Shortint EB1MINVAL = 0x0;
static const Byte UB1MAXVAL = 0xff;
static const Shortint UB1MINVAL = 0x0;
static const Shortint SB1MAXVAL = 0x7f;
static const Shortint SB1MINVAL = 0xffffff80;
static const Shortint MINEB1MAXVAL = 0x7f;
static const Shortint MAXEB1MINVAL = 0x0;
static const Byte MINUB1MAXVAL = 0xff;
static const Shortint MAXUB1MINVAL = 0x0;
static const Shortint MINSB1MAXVAL = 0x7f;
static const Shortint MAXSB1MINVAL = 0xffffff81;
static const Shortint UB1BITS = 0x8;
static const Byte UB1MASK = 0xff;
static const Word EB2MAXVAL = 0x7fff;
static const Shortint EB2MINVAL = 0x0;
static const Word UB2MAXVAL = 0xffff;
static const Shortint UB2MINVAL = 0x0;
static const Word SB2MAXVAL = 0x7fff;
static const short SB2MINVAL = 0xffff8000;
static const Word MINEB2MAXVAL = 0x7fff;
static const Shortint MAXEB2MINVAL = 0x0;
static const Word MINUB2MAXVAL = 0xffff;
static const Shortint MAXUB2MINVAL = 0x0;
static const Word MINSB2MAXVAL = 0x7fff;
static const short MAXSB2MINVAL = 0xffff8001;
static const int EB4MAXVAL = 0x7fffffff;
static const Shortint EB4MINVAL = 0x0;
static const unsigned UB4MAXVAL = 0xffffffff;
static const Shortint UB4MINVAL = 0x0;
static const int SB4MAXVAL = 0x7fffffff;
static const int SB4MINVAL = 0x80000000;
static const int MINEB4MAXVAL = 0x7fffffff;
static const Shortint MAXEB4MINVAL = 0x0;
static const unsigned MINUB4MAXVAL = 0xffffffff;
static const Shortint MAXUB4MINVAL = 0x0;
static const int MINSB4MAXVAL = 0x7fffffff;
static const int MAXSB4MINVAL = 0x80000001;
static const unsigned UBIG_ORAMAXVAL = 0xffffffff;
static const Shortint UBIG_ORAMINVAL = 0x0;
static const int SBIG_ORAMAXVAL = 0x7fffffff;
static const int SBIG_ORAMINVAL = 0x80000000;
static const int MINUBIG_ORAMAXVAL = 0x7fffffff;
static const Shortint MAXUBIG_ORAMINVAL = 0x0;
static const int MINSBIG_ORAMAXVAL = 0x7fffffff;
static const int MAXSBIG_ORAMINVAL = 0x80000001;
static const unsigned SIZE_TMAXVAL = 0xffffffff;
static const Word MINSIZE_TMAXVAL = 0xffff;
static const int SizeOfPtr = 0x4;
static const Shortint CDA_SIZE = 0x40;
static const Shortint LDA_SIZE = 0x40;
static const Word HDA_SIZE = 0x100;
static const int CDA_HEAD_SIZE = 0x30;
static const Shortint OCI_EV_DEF = 0x0;
static const Shortint OCI_EV_TSF = 0x1;
static const Shortint OCI_LM_DEF = 0x0;
static const Shortint OCI_LM_NBL = 0x1;
static const Shortint OCI_ONE_PIECE = 0x0;
static const Shortint OCI_FIRST_PIECE = 0x1;
static const Shortint OCI_NEXT_PIECE = 0x2;
static const Shortint OCI_LAST_PIECE = 0x3;
static const Shortint SQLT_CHR = 0x1;
static const Shortint SQLT_NUM = 0x2;
static const Shortint SQLT_INT = 0x3;
static const Shortint SQLT_FLT = 0x4;
static const Shortint SQLT_STR = 0x5;
static const Shortint SQLT_VNU = 0x6;
static const Shortint SQLT_PDN = 0x7;
static const Shortint SQLT_LNG = 0x8;
static const Shortint SQLT_VCS = 0x9;
static const Shortint SQLT_NON = 0xa;
static const Shortint SQLT_RID = 0xb;
static const Shortint SQLT_DAT = 0xc;
static const Shortint SQLT_VBI = 0xf;
static const Shortint SQLT_BIN = 0x17;
static const Shortint SQLT_LBI = 0x18;
static const Shortint SQLT_UIN = 0x44;
static const Shortint SQLT_SLS = 0x5b;
static const Shortint SQLT_LVC = 0x5e;
static const Shortint SQLT_LVB = 0x5f;
static const Shortint SQLT_AFC = 0x60;
static const Shortint SQLT_AVC = 0x61;
static const Shortint SQLT_CUR = 0x66;
static const Shortint SQLT_RDD = 0x68;
static const Shortint SQLT_LAB = 0x69;
static const Shortint SQLT_OSL = 0x6a;
static const Shortint SQLT_NTY = 0x6c;
static const Shortint SQLT_REF = 0x6e;
static const Shortint SQLT_CLOB = 0x70;
static const Shortint SQLT_BLOB = 0x71;
static const Shortint SQLT_BFILE = 0x72;
static const Shortint SQLT_CFILE = 0x73;
static const Shortint SQLT_RSET = 0x74;
static const Shortint SQLT_NCO = 0x7a;
static const Byte SQLT_VST = 0x9b;
static const Byte SQLT_ODT = 0x9c;
static const Byte SQLT_DATE = 0xb8;
static const Byte SQLT_TIME = 0xb9;
static const Byte SQLT_TIME_TZ = 0xba;
static const Byte SQLT_TIMESTAMP = 0xbb;
static const Byte SQLT_TIMESTAMP_TZ = 0xbc;
static const Byte SQLT_INTERVAL_YM = 0xbd;
static const Byte SQLT_INTERVAL_DS = 0xbe;
static const Byte SQLT_TIMESTAMP_LTZ = 0xe8;
static const Byte SQLT_PNTY = 0xf1;
static const Shortint SQLCS_IMPLICIT = 0x1;
static const Shortint SQLCS_NCHAR = 0x2;
static const Shortint SQLCS_EXPLICIT = 0x3;
static const Shortint SQLCS_FLEXIBLE = 0x4;
static const Shortint SQLCS_LIT_NULL = 0x5;
extern PACKAGE int __cdecl (*obindps)(PCdaDef cursor, Byte opcode, char * sqlvar, int sqlvl, void * 
	pvctx, int progvl, int ftype, int scale, ub2p ind, ub2p alen, ub2p arcode, int pv_skip, int ind_skip
	, int alen_skip, int rc_skip, int maxsiz, ub4p cursiz, char * fmt, int fmtl, int fmtt);
extern PACKAGE int __cdecl (*obreak)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*ocan)(PCdaDef cursor);
extern PACKAGE int __cdecl (*oclose)(PCdaDef cursor);
extern PACKAGE int __cdecl (*ocof)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*ocom)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*ocon)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*odefinps)(PCdaDef cursor, Byte opcode, int pos, char * bufctx, int bufl
	, int ftype, int scale, sb2p indp, char * fmt, int fmtl, int fmtt, ub2p rlen, ub2p rcode, int pv_skip
	, int ind_skip, int alen_skip, int rc_skip);
extern PACKAGE int __cdecl (*odessp)(PCdaDef cursor, char * objnam, int onlen, ub1p rsv1, int rsv1ln
	, ub1p rsv2, int rsv2ln, ub2p ovrld, ub2p pos, ub2p level, char * text, ub2p arnlen, ub2p dtype, ub1p 
	defsup, ub1p mode, ub4p dtsiz, sb2p prec, sb2p scale, ub1p radix, ub4p spare, int &arrsiz);
extern PACKAGE int __cdecl (*odescr)(PCdaDef cursor, int pos, int &dbsize, short &dbtype, char * cbuf
	, int &cbufl, int &dsize, short &prec, short &scale, short &nullok);
extern PACKAGE int __cdecl (*oerhms)(PLdaDef ldaptr, short rcode, char * buf, int bufsiz);
extern PACKAGE int __cdecl (*oermsg)(short rcode, char * buf);
extern PACKAGE int __cdecl (*oexec)(PCdaDef cursor);
extern PACKAGE int __cdecl (*oexfet)(PCdaDef cursor, int nrows, int cancel, int exact);
extern PACKAGE int __cdecl (*oexn)(PCdaDef cursor, int iters, int rowoff);
extern PACKAGE int __cdecl (*ofen)(PCdaDef cursor, int nrows);
extern PACKAGE int __cdecl (*ofetch)(PCdaDef cursor);
extern PACKAGE int __cdecl (*oflng)(PCdaDef cursor, int pos, char * buf, int bufl, int dtype, int &retl
	, int offset);
extern PACKAGE int __cdecl (*ogetpi)(PCdaDef cursor, Byte &piece, void * &ctxp, int &iter, int &index
	);
extern PACKAGE int __cdecl (*oopt)(PCdaDef cursor, int rbopt, int waitopt);
extern PACKAGE int __cdecl (*opinit)(int mode);
extern PACKAGE int __cdecl (*olog)(PLdaDef ldaptr, PHdaDef hdaptr, char * uid, int uidl, char * pswd
	, int pswdl, char * conn, int connl, int mode);
extern PACKAGE int __cdecl (*ologof)(PLdaDef ldaptr);
extern PACKAGE int __cdecl (*oopen)(PCdaDef cursor, PCdaDef ldaptr, char * dbn, int dbnl, int arsize
	, char * uid, int uidl);
extern PACKAGE int __cdecl (*oparse)(PCdaDef cursor, char * sqlstm, int sqllen, int defflg, int lngflg
	);
extern PACKAGE int __cdecl (*orol)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*osetpi)(PCdaDef cursor, Byte piece, void * bufp, int &len);
extern PACKAGE int __cdecl (*onbset)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*onbtst)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*onbclr)(PCdaDef ldaptr);
extern PACKAGE int __cdecl (*obndra)(PCdaDef cursor, char * sqlvar, int sqlvl, char * progv, int progvl
	, int ftype, int scale, sb2p indp, ub2p alen, ub2p arcode, int maxsiz, ub4p cursiz, char * fmt, int 
	fmtl, int fmtt);
extern PACKAGE int __cdecl (*obndrn)(PCdaDef cursor, int sqlvn, char * progv, int progvl, int ftype, 
	int scale, sb2p indp, char * fmt, int fmtl, int fmtt);
extern PACKAGE int __cdecl (*obndrv)(PCdaDef cursor, char * sqlvar, int sqlvl, char * progv, int progvl
	, int ftype, int scale, sb2p indp, char * fmt, int fmtl, int fmtt);
extern PACKAGE int __cdecl (*odefin)(PCdaDef cursor, int pos, char * buf, int bufl, int ftype, int scale
	, sb2p indp, char * fmt, int fmtl, int fmtt, ub2p rlen, ub2p rcode);
static const Word MAXERRMSG = 0x3e8;
static const Shortint DEFERRED_PARSE = 0x1;
static const Shortint ORACLE7_PARSE = 0x2;
static const Shortint ORA_CT_CTB = 0x1;
static const Shortint ORA_CT_SRL = 0x2;
static const Shortint ORA_CT_INS = 0x3;
static const Shortint ORA_CT_SEL = 0x4;
static const Shortint ORA_CT_UPD = 0x5;
static const Shortint ORA_CT_DRL = 0x6;
static const Shortint ORA_CT_DVW = 0x7;
static const Shortint ORA_CT_DTB = 0x8;
static const Shortint ORA_CT_DEL = 0x9;
static const Shortint ORA_CT_CVW = 0xa;
static const Shortint ORA_CT_DUS = 0xb;
static const Shortint ORA_CT_CRL = 0xc;
static const Shortint ORA_CT_CSQ = 0xd;
static const Shortint ORA_CT_ASQ = 0xe;
static const Shortint ORA_CT_DSQ = 0x10;
static const Shortint ORA_CT_CSC = 0x11;
static const Shortint ORA_CT_CCL = 0x12;
static const Shortint ORA_CT_CUS = 0x13;
static const Shortint ORA_CT_CIN = 0x14;
static const Shortint ORA_CT_DIN = 0x15;
static const Shortint ORA_CT_DCL = 0x16;
static const Shortint ORA_CT_VIN = 0x17;
static const Shortint ORA_CT_CPR = 0x18;
static const Shortint ORA_CT_APR = 0x19;
static const Shortint ORA_CT_ATB = 0x1a;
static const Shortint ORA_CT_EXP = 0x1b;
static const Shortint ORA_CT_GRT = 0x1c;
static const Shortint ORA_CT_RVK = 0x1d;
static const Shortint ORA_CT_CSY = 0x1e;
static const Shortint ORA_CT_DSY = 0x1f;
static const Shortint ORA_CT_STR = 0x21;
static const Shortint ORA_CT_PEX = 0x22;
static const Shortint ORA_CT_LTB = 0x23;
static const Shortint ORA_CT_REN = 0x25;
static const Shortint ORA_CT_COM = 0x26;
static const Shortint ORA_CT_AUD = 0x27;
static const Shortint ORA_CT_NAU = 0x28;
static const Shortint ORA_CT_AIN = 0x29;
static const Shortint ORA_CT_CDB = 0x2c;
static const Shortint ORA_CT_ADB = 0x2d;
static const Shortint ORA_CT_CTS = 0x31;
static const Shortint ORA_CT_ATS = 0x32;
static const Shortint ORA_CT_DTS = 0x33;
static const Shortint ORA_CT_ASE = 0x34;
static const Shortint ORA_CT_AUS = 0x35;
static const Shortint ORA_CT_CMT = 0x36;
static const Shortint ORA_CT_RBK = 0x37;
static const Shortint ORA_CT_SVP = 0x38;
static const Shortint ORA_CT_CTR = 0x3b;
static const Shortint ORA_CT_ATR = 0x3c;
static const Shortint ORA_CT_DTR = 0x3d;
static const Shortint ORA_CT_CPF = 0x41;
static const Shortint ORA_CT_DPF = 0x42;
static const Shortint ORA_CT_APF = 0x43;
static const Shortint ORA_CT_DPR = 0x44;
static const Shortint ORA_CT_CSN = 0x4a;
static const Shortint ORA_CT_ASN = 0x4b;
static const Shortint ORA_CT_DSN = 0x4c;
static const Word ORA_DTS_VARCHAR2 = 0x7d0;
static const Shortint ORA_DTS_NUMBER = 0x15;
static const Shortint ORA_DTS_LONG = 0x0;
static const Shortint ORA_DTS_ROWID = 0x6;
static const Shortint ORA_DTS_DATE = 0x7;
static const Byte ORA_DTS_RAW = 0xff;
static const Shortint ORA_DTS_LONG_RAW = 0x0;
static const Byte ORA_DTS_CHAR = 0xff;
static const Byte ORA_DTS_MLSLABEL = 0xff;
static const Word ORA_ERR_VarNotInSel = 0x3ef;
static const Word ORA_ERR_INVALID_OCI_OP = 0x3f2;
static const Word ORA_ERR_PASSWORD_EXPIRED = 0x6d61;
static const Word OCI_MORE_INSERT_PIECES = 0xc39;
static const Word OCI_MORE_FETCH_PIECES = 0xc3a;
static const Shortint OCI_EXIT_FAILURE = 0x1;
static const Shortint OCI_EXIT_SUCCESS = 0x0;
static const int MAX_LONG_COL_SIZE = 0x7fffffff;
static const Shortint OCI_DEFAULT = 0x0;
static const Shortint OCI_THREADED = 0x1;
static const Shortint OCI_OBJECT = 0x2;
static const Shortint OCI_NON_BLOCKING = 0x4;
static const Shortint OCI_ENV_NO_MUTEX = 0x8;
static const Shortint OCI_SHARED = 0x10;
static const Shortint OCI_HTYPE_FIRST = 0x1;
static const Shortint OCI_HTYPE_ENV = 0x1;
static const Shortint OCI_HTYPE_ERROR = 0x2;
static const Shortint OCI_HTYPE_SVCCTX = 0x3;
static const Shortint OCI_HTYPE_STMT = 0x4;
static const Shortint OCI_HTYPE_BIND = 0x5;
static const Shortint OCI_HTYPE_DEFINE = 0x6;
static const Shortint OCI_HTYPE_DESCRIBE = 0x7;
static const Shortint OCI_HTYPE_SERVER = 0x8;
static const Shortint OCI_HTYPE_SESSION = 0x9;
static const Shortint OCI_HTYPE_TRANS = 0xa;
static const Shortint OCI_HTYPE_COMPLEXOBJECT = 0xb;
static const Shortint OCI_HTYPE_SECURITY = 0xc;
static const Shortint OCI_HTYPE_LAST = 0xc;
static const Shortint OCI_DTYPE_FIRST = 0x32;
static const Shortint OCI_DTYPE_LOB = 0x32;
static const Shortint OCI_DTYPE_SNAP = 0x33;
static const Shortint OCI_DTYPE_RSET = 0x34;
static const Shortint OCI_DTYPE_PARAM = 0x35;
static const Shortint OCI_DTYPE_ROWID = 0x36;
static const Shortint OCI_DTYPE_COMPLEXOBJECTCOMP = 0x37;
static const Shortint OCI_DTYPE_FILE = 0x38;
static const Shortint OCI_DTYPE_AQENQ_OPTIONS = 0x39;
static const Shortint OCI_DTYPE_AQDEQ_OPTIONS = 0x3a;
static const Shortint OCI_DTYPE_AQMSG_PROPERTIES = 0x3b;
static const Shortint OCI_DTYPE_AQAGENT = 0x3c;
static const Shortint OCI_DTYPE_LOCATOR = 0x3d;
static const Shortint OCI_DTYPE_INTERVAL_YM = 0x3e;
static const Shortint OCI_DTYPE_INTERVAL_DS = 0x3f;
static const Shortint OCI_DTYPE_AQNFY_DESCRIPTOR = 0x40;
static const Shortint OCI_DTYPE_DATE = 0x41;
static const Shortint OCI_DTYPE_TIME = 0x42;
static const Shortint OCI_DTYPE_TIME_TZ = 0x43;
static const Shortint OCI_DTYPE_TIMESTAMP = 0x44;
static const Shortint OCI_DTYPE_TIMESTAMP_TZ = 0x45;
static const Shortint OCI_DTYPE_TIMESTAMP_LTZ = 0x46;
static const Shortint OCI_DTYPE_UCB = 0x47;
static const Shortint OCI_DTYPE_SRVDN = 0x48;
static const Shortint OCI_DTYPE_SIGNATURE = 0x49;
static const Shortint OCI_DTYPE_RESERVED_1 = 0x4a;
static const Shortint OCI_DTYPE_LAST = 0x4a;
static const Shortint OCI_TEMP_BLOB = 0x1;
static const Shortint OCI_TEMP_CLOB = 0x2;
static const Shortint OCI_OTYPE_NAME = 0x1;
static const Shortint OCI_OTYPE_REF = 0x2;
static const Shortint OCI_OTYPE_PTR = 0x3;
static const Shortint OCI_ATTR_FNCODE = 0x1;
static const Shortint OCI_ATTR_OBJECT = 0x2;
static const Shortint OCI_ATTR_NONBLOCKING_MODE = 0x3;
static const Shortint OCI_ATTR_SQLCODE = 0x4;
static const Shortint OCI_ATTR_ENV = 0x5;
static const Shortint OCI_ATTR_SERVER = 0x6;
static const Shortint OCI_ATTR_SESSION = 0x7;
static const Shortint OCI_ATTR_TRANS = 0x8;
static const Shortint OCI_ATTR_ROW_COUNT = 0x9;
static const Shortint OCI_ATTR_SQLFNCODE = 0xa;
static const Shortint OCI_ATTR_PREFETCH_ROWS = 0xb;
static const Shortint OCI_ATTR_NESTED_PREFETCH_ROWS = 0xc;
static const Shortint OCI_ATTR_PREFETCH_MEMORY = 0xd;
static const Shortint OCI_ATTR_NESTED_PREFETCH_MEMORY = 0xe;
static const Shortint OCI_ATTR_CHAR_COUNT = 0xf;
static const Shortint OCI_ATTR_PDSCL = 0x10;
static const Shortint OCI_ATTR_FSPRECISION = 0x10;
static const Shortint OCI_ATTR_PDPRC = 0x11;
static const Shortint OCI_ATTR_LFPRECISION = 0x11;
static const Shortint OCI_ATTR_PARAM_COUNT = 0x12;
static const Shortint OCI_ATTR_ROWID = 0x13;
static const Shortint OCI_ATTR_CHARSET = 0x14;
static const Shortint OCI_ATTR_NCHAR = 0x15;
static const Shortint OCI_ATTR_USERNAME = 0x16;
static const Shortint OCI_ATTR_PASSWORD = 0x17;
static const Shortint OCI_ATTR_STMT_TYPE = 0x18;
static const Shortint OCI_ATTR_INTERNAL_NAME = 0x19;
static const Shortint OCI_ATTR_EXTERNAL_NAME = 0x1a;
static const Shortint OCI_ATTR_XID = 0x1b;
static const Shortint OCI_ATTR_TRANS_LOCK = 0x1c;
static const Shortint OCI_ATTR_TRANS_NAME = 0x1d;
static const Shortint OCI_ATTR_HEAPALLOC = 0x1e;
static const Shortint OCI_ATTR_CHARSET_ID = 0x1f;
static const Shortint OCI_ATTR_CHARSET_FORM = 0x20;
static const Shortint OCI_ATTR_MAXDATA_SIZE = 0x21;
static const Shortint OCI_ATTR_CACHE_OPT_SIZE = 0x22;
static const Shortint OCI_ATTR_CACHE_MAX_SIZE = 0x23;
static const Shortint OCI_ATTR_PINOPTION = 0x24;
static const Shortint OCI_ATTR_ALLOC_DURATION = 0x25;
static const Shortint OCI_ATTR_PIN_DURATION = 0x26;
static const Shortint OCI_ATTR_FDO = 0x27;
static const Shortint OCI_ATTR_POSTPROCESSING_CALLBACK = 0x28;
static const Shortint OCI_ATTR_POSTPROCESSING_CONTEXT = 0x29;
static const Shortint OCI_ATTR_ROWS_RETURNED = 0x2a;
static const Shortint OCI_ATTR_FOCBK = 0x2b;
static const Shortint OCI_ATTR_IN_V8_MODE = 0x2c;
static const Shortint OCI_ATTR_LOBEMPTY = 0x2d;
static const Shortint OCI_ATTR_SESSLANG = 0x2e;
static const Shortint OCI_ATTR_VISIBILITY = 0x2f;
static const Shortint OCI_ATTR_RELATIVE_MSGID = 0x30;
static const Shortint OCI_ATTR_SEQUENCE_DEVIATION = 0x31;
static const Shortint OCI_ATTR_CONSUMER_NAME = 0x32;
static const Shortint OCI_ATTR_DEQ_MODE = 0x33;
static const Shortint OCI_ATTR_NAVIGATION = 0x34;
static const Shortint OCI_ATTR_WAIT = 0x35;
static const Shortint OCI_ATTR_DEQ_MSGID = 0x36;
static const Shortint OCI_ATTR_PRIORITY = 0x37;
static const Shortint OCI_ATTR_DELAY = 0x38;
static const Shortint OCI_ATTR_EXPIRATION = 0x39;
static const Shortint OCI_ATTR_CORRELATION = 0x3a;
static const Shortint OCI_ATTR_ATTEMPTS = 0x3b;
static const Shortint OCI_ATTR_RECIPIENT_LIST = 0x3c;
static const Shortint OCI_ATTR_EXCEPTION_QUEUE = 0x3d;
static const Shortint OCI_ATTR_ENQ_TIME = 0x3e;
static const Shortint OCI_ATTR_MSG_STATE = 0x3f;
static const Shortint OCI_ATTR_AGENT_NAME = 0x40;
static const Shortint OCI_ATTR_AGENT_ADDRESS = 0x41;
static const Shortint OCI_ATTR_AGENT_PROTOCOL = 0x42;
static const Shortint OCI_ATTR_SENDER_ID = 0x44;
static const Shortint OCI_ATTR_ORIGINAL_MSGID = 0x45;
static const Shortint OCI_ATTR_QUEUE_NAME = 0x46;
static const Shortint OCI_ATTR_NFY_MSGID = 0x47;
static const Shortint OCI_ATTR_MSG_PROP = 0x48;
static const Shortint OCI_ATTR_NUM_DML_ERRORS = 0x49;
static const Shortint OCI_ATTR_DML_ROW_OFFSET = 0x4a;
static const Shortint OCI_ATTR_DATEFORMAT = 0x4b;
static const Shortint OCI_ATTR_BUF_ADDR = 0x4c;
static const Shortint OCI_ATTR_BUF_SIZE = 0x4d;
static const Shortint OCI_ATTR_DIRPATH_MODE = 0x4e;
static const Shortint OCI_ATTR_DIRPATH_NOLOG = 0x4f;
static const Shortint OCI_ATTR_DIRPATH_PARALLEL = 0x50;
static const Shortint OCI_ATTR_NUM_ROWS = 0x51;
static const Shortint OCI_ATTR_COL_COUNT = 0x52;
static const Shortint OCI_ATTR_STREAM_OFFSET = 0x53;
static const Shortint OCI_ATTR_SHARED_HEAPALLOC = 0x54;
static const Shortint OCI_ATTR_SERVER_GROUP = 0x55;
static const Shortint OCI_ATTR_MIGSESSION = 0x56;
static const Shortint OCI_ATTR_NOCACHE = 0x57;
static const Shortint OCI_ATTR_MEMPOOL_SIZE = 0x58;
static const Shortint OCI_ATTR_MEMPOOL_INSTNAME = 0x59;
static const Shortint OCI_ATTR_MEMPOOL_APPNAME = 0x5a;
static const Shortint OCI_ATTR_MEMPOOL_HOMENAME = 0x5b;
static const Shortint OCI_ATTR_MEMPOOL_MODEL = 0x5c;
static const Shortint OCI_ATTR_MODES = 0x5d;
static const Shortint OCI_ATTR_SUBSCR_NAME = 0x5e;
static const Shortint OCI_ATTR_SUBSCR_CALLBACK = 0x5f;
static const Shortint OCI_ATTR_SUBSCR_CTX = 0x60;
static const Shortint OCI_ATTR_SUBSCR_PAYLOAD = 0x61;
static const Shortint OCI_ATTR_SUBSCR_NAMESPACE = 0x62;
static const Shortint OCI_ATTR_PROXY_CREDENTIALS = 0x63;
static const Shortint OCI_ATTR_INITIAL_CLIENT_ROLES = 0x64;
static const Shortint OCI_ATTR_UNK = 0x65;
static const Shortint OCI_ATTR_NUM_COLS = 0x66;
static const Shortint OCI_ATTR_LIST_COLUMNS = 0x67;
static const Shortint OCI_ATTR_RDBA = 0x68;
static const Shortint OCI_ATTR_CLUSTERED = 0x69;
static const Shortint OCI_ATTR_PARTITIONED = 0x6a;
static const Shortint OCI_ATTR_INDEX_ONLY = 0x6b;
static const Shortint OCI_ATTR_LIST_ARGUMENTS = 0x6c;
static const Shortint OCI_ATTR_LIST_SUBPROGRAMS = 0x6d;
static const Shortint OCI_ATTR_REF_TDO = 0x6e;
static const Shortint OCI_ATTR_LINK = 0x6f;
static const Shortint OCI_ATTR_MIN = 0x70;
static const Shortint OCI_ATTR_MAX = 0x71;
static const Shortint OCI_ATTR_INCR = 0x72;
static const Shortint OCI_ATTR_CACHE = 0x73;
static const Shortint OCI_ATTR_ORDER = 0x74;
static const Shortint OCI_ATTR_HW_MARK = 0x75;
static const Shortint OCI_ATTR_TYPE_SCHEMA = 0x76;
static const Shortint OCI_ATTR_TIMESTAMP = 0x77;
static const Shortint OCI_ATTR_NUM_ATTRS = 0x78;
static const Shortint OCI_ATTR_NUM_PARAMS = 0x79;
static const Shortint OCI_ATTR_OBJID = 0x7a;
static const Shortint OCI_ATTR_PTYPE = 0x7b;
static const Shortint OCI_ATTR_PARAM = 0x7c;
static const Shortint OCI_ATTR_OVERLOAD_ID = 0x7d;
static const Shortint OCI_ATTR_TABLESPACE = 0x7e;
static const Shortint OCI_ATTR_TDO = 0x7f;
static const Byte OCI_ATTR_LTYPE = 0x80;
static const Byte OCI_ATTR_PARSE_ERROR_OFFSET = 0x81;
static const Byte OCI_ATTR_IS_TEMPORARY = 0x82;
static const Byte OCI_ATTR_IS_TYPED = 0x83;
static const Byte OCI_ATTR_DURATION = 0x84;
static const Byte OCI_ATTR_IS_INVOKER_RIGHTS = 0x85;
static const Byte OCI_ATTR_OBJ_NAME = 0x86;
static const Byte OCI_ATTR_OBJ_SCHEMA = 0x87;
static const Byte OCI_ATTR_OBJ_ID = 0x88;
static const Byte OCI_ATTR_DIRPATH_SORTED_INDEX = 0x89;
static const Byte OCI_ATTR_DIRPATH_INDEX_MAINT_METHOD = 0x8a;
static const Byte OCI_ATTR_DIRPATH_FILE = 0x8b;
static const Byte OCI_ATTR_DIRPATH_STORAGE_INITIAL = 0x8c;
static const Byte OCI_ATTR_DIRPATH_STORAGE_NEXT = 0x8d;
static const Byte OCI_ATTR_TRANS_TIMEOUT = 0x8e;
static const Byte OCI_ATTR_SERVER_STATUS = 0x8f;
static const Byte OCI_ATTR_STATEMENT = 0x90;
static const Byte OCI_ATTR_NO_CACHE = 0x91;
static const Byte OCI_ATTR_DEQCOND = 0x92;
static const Byte OCI_ATTR_RESERVED_2 = 0x93;
static const Byte OCI_ATTR_SUBSCR_RECPT = 0x94;
static const Byte OCI_ATTR_SUBSCR_RECPTPROTO = 0x95;
static const Byte OCI_ATTR_DIRPATH_EXPR_TYPE = 0x96;
static const Byte OCI_ATTR_DIRPATH_INPUT = 0x97;
static const Shortint OCI_DIRPATH_INPUT_TEXT = 0x1;
static const Shortint OCI_DIRPATH_INPUT_STREAM = 0x2;
static const Shortint OCI_DIRPATH_INPUT_UNKNOWN = 0x4;
static const Byte OCI_ATTR_LDAP_HOST = 0x99;
static const Byte OCI_ATTR_LDAP_PORT = 0x9a;
static const Byte OCI_ATTR_BIND_DN = 0x9b;
static const Byte OCI_ATTR_LDAP_CRED = 0x9c;
static const Byte OCI_ATTR_WALL_LOC = 0x9d;
static const Byte OCI_ATTR_LDAP_AUTH = 0x9e;
static const Byte OCI_ATTR_LDAP_CTX = 0x9f;
static const Byte OCI_ATTR_SERVER_DNS = 0xa0;
static const Byte OCI_ATTR_DN_COUNT = 0xa1;
static const Byte OCI_ATTR_SERVER_DN = 0xa2;
static const Byte OCI_ATTR_MAXCHAR_SIZE = 0xa3;
static const Byte OCI_ATTR_CURRENT_POSITION = 0xa4;
static const Byte OCI_ATTR_RESERVED_3 = 0xa5;
static const Byte OCI_ATTR_RESERVED_4 = 0xa6;
static const Byte OCI_ATTR_DIRPATH_FN_CTX = 0xa7;
static const Byte OCI_ATTR_DIGEST_ALGO = 0xa8;
static const Byte OCI_ATTR_CERTIFICATE = 0xa9;
static const Byte OCI_ATTR_SIGNATURE_ALGO = 0xaa;
static const Byte OCI_ATTR_CANONICAL_ALGO = 0xab;
static const Byte OCI_ATTR_PRIVATE_KEY = 0xac;
static const Byte OCI_ATTR_DIGEST_VALUE = 0xad;
static const Byte OCI_ATTR_SIGNATURE_VAL = 0xae;
static const Byte OCI_ATTR_SIGNATURE = 0xaf;
static const Byte OCI_ATTR_STMTCACHESIZE = 0xb0;
static const Byte OCI_ATTR_CONN_NOWAIT = 0xb2;
static const Byte OCI_ATTR_CONN_BUSY_COUNT = 0xb3;
static const Byte OCI_ATTR_CONN_OPEN_COUNT = 0xb4;
static const Byte OCI_ATTR_CONN_TIMEOUT = 0xb5;
static const Byte OCI_ATTR_STMT_STATE = 0xb6;
static const Byte OCI_ATTR_CONN_MIN = 0xb7;
static const Byte OCI_ATTR_CONN_MAX = 0xb8;
static const Byte OCI_ATTR_CONN_INCR = 0xb9;
static const Byte OCI_ATTR_DIRPATH_OID = 0xbb;
static const Byte OCI_ATTR_NUM_OPEN_STMTS = 0xbc;
static const Byte OCI_ATTR_DESCRIBE_NATIVE = 0xbd;
static const Byte OCI_ATTR_BIND_COUNT = 0xbe;
static const Byte OCI_ATTR_HANDLE_POSITION = 0xbf;
static const Byte OCI_ATTR_RESERVED_5 = 0xc0;
static const Byte OCI_ATTR_SERVER_BUSY = 0xc1;
static const Byte OCI_ATTR_DIRPATH_SID = 0xc2;
static const Byte OCI_ATTR_SUBSCR_RECPTPRES = 0xc3;
static const Byte OCI_ATTR_TRANSFORMATION = 0xc4;
static const Byte OCI_ATTR_ROWS_FETCHED = 0xc5;
static const Byte OCI_ATTR_SCN_BASE = 0xc6;
static const Byte OCI_ATTR_SCN_WRAP = 0xc7;
static const Byte OCI_ATTR_RESERVED_6 = 0xc8;
static const Byte OCI_ATTR_READONLY_TXN = 0xc9;
static const Byte OCI_ATTR_RESERVED_7 = 0xca;
static const Byte OCI_ATTR_ERRONEOUS_COLUMN = 0xcb;
static const Byte OCI_ATTR_RESERVED_8 = 0xcc;
static const Byte OCI_ATTR_DIRPATH_OBJ_CONSTR = 0xce;
static const Byte OCI_ATTR_ENV_UTF16 = 0xd1;
static const Byte OCI_ATTR_RESERVED_9 = 0xd2;
static const Byte OCI_ATTR_RESERVED_10 = 0xd3;
static const Byte OCI_ATTR_DIRPATH_STREAM_VERSION = 0xd4;
static const Byte OCI_ATTR_RESERVED_11 = 0xd5;
static const Byte OCI_ATTR_RESERVED_12 = 0xd6;
static const Byte OCI_ATTR_RESERVED_13 = 0xd7;
static const Shortint OCI_DIRPATH_STREAM_VERSION_1 = 0x64;
static const Byte OCI_DIRPATH_STREAM_VERSION_2 = 0xc8;
static const Shortint OCI_SUBSCR_PROTO_OCI = 0x0;
static const Shortint OCI_SUBSCR_PROTO_MAIL = 0x1;
static const Shortint OCI_SUBSCR_PROTO_SERVER = 0x2;
static const Shortint OCI_SUBSCR_PROTO_HTTP = 0x3;
static const Shortint OCI_SUBSCR_PROTO_MAX = 0x4;
static const Shortint OCI_SUBSCR_PRES_DEFAULT = 0x0;
static const Shortint OCI_SUBSCR_PRES_XML = 0x1;
static const Shortint OCI_SUBSCR_PRES_MAX = 0x2;
static const Word OCI_UCS2ID = 0x3e8;
static const Word OCI_UTF16ID = 0x3e8;
static const Shortint OCI_SERVER_NOT_CONNECTED = 0x0;
static const Shortint OCI_SERVER_NORMAL = 0x1;
static const Shortint OCI_SUBSCR_NAMESPACE_ANONYMOUS = 0x0;
static const Shortint OCI_SUBSCR_NAMESPACE_AQ = 0x1;
static const Shortint OCI_SUBSCR_NAMESPACE_MAX = 0x2;
static const Shortint OCI_CRED_RDBMS = 0x1;
static const Shortint OCI_CRED_EXT = 0x2;
static const Shortint OCI_SUCCESS = 0x0;
static const Shortint OCI_SUCCESS_WITH_INFO = 0x1;
static const Byte OCI_RESERVED_FOR_INT_USE = 0xc8;
static const Shortint OCI_NO_DATA = 0x64;
static const Shortint OCI_ERROR = 0xffffffff;
static const Shortint OCI_INVALID_HANDLE = 0xfffffffe;
static const Shortint OCI_NEED_DATA = 0x63;
static const short OCI_STILL_EXECUTING = 0xfffff3cd;
static const short OCI_CONTINUE = 0xffffa178;
static const Shortint OCI_DT_INVALID_DAY = 0x1;
static const Shortint OCI_DT_DAY_BELOW_VALID = 0x2;
static const Shortint OCI_DT_INVALID_MONTH = 0x4;
static const Shortint OCI_DT_MONTH_BELOW_VALID = 0x8;
static const Shortint OCI_DT_INVALID_YEAR = 0x10;
static const Shortint OCI_DT_YEAR_BELOW_VALID = 0x20;
static const Shortint OCI_DT_INVALID_HOUR = 0x40;
static const Byte OCI_DT_HOUR_BELOW_VALID = 0x80;
static const Word OCI_DT_INVALID_MINUTE = 0x100;
static const Word OCI_DT_MINUTE_BELOW_VALID = 0x200;
static const Word OCI_DT_INVALID_SECOND = 0x400;
static const Word OCI_DT_SECOND_BELOW_VALID = 0x800;
static const Word OCI_DT_DAY_MISSING_FROM_1582 = 0x1000;
static const Word OCI_DT_YEAR_ZERO = 0x2000;
static const Word OCI_DT_INVALID_TIMEZONE = 0x4000;
static const Word OCI_DT_INVALID_FORMAT = 0x8000;
static const Shortint OCI_INTER_INVALID_DAY = 0x1;
static const Shortint OCI_INTER_DAY_BELOW_VALID = 0x2;
static const Shortint OCI_INTER_INVALID_MONTH = 0x4;
static const Shortint OCI_INTER_MONTH_BELOW_VALID = 0x8;
static const Shortint OCI_INTER_INVALID_YEAR = 0x10;
static const Shortint OCI_INTER_YEAR_BELOW_VALID = 0x20;
static const Shortint OCI_INTER_INVALID_HOUR = 0x40;
static const Byte OCI_INTER_HOUR_BELOW_VALID = 0x80;
static const Word OCI_INTER_INVALID_MINUTE = 0x100;
static const Word OCI_INTER_MINUTE_BELOW_VALID = 0x200;
static const Word OCI_INTER_INVALID_SECOND = 0x400;
static const Word OCI_INTER_SECOND_BELOW_VALID = 0x800;
static const Word OCI_INTER_INVALID_FRACSEC = 0x1000;
static const Word OCI_INTER_FRACSEC_BELOW_VALID = 0x2000;
static const Shortint OCI_V7_SYNTAX = 0x2;
static const Shortint OCI_V8_SYNTAX = 0x3;
static const Shortint OCI_NTV_SYNTAX = 0x1;
static const Shortint OCI_FETCH_CURRENT = 0x1;
static const Shortint OCI_FETCH_NEXT = 0x2;
static const Shortint OCI_FETCH_FIRST = 0x4;
static const Shortint OCI_FETCH_LAST = 0x8;
static const Shortint OCI_FETCH_PRIOR = 0x10;
static const Shortint OCI_FETCH_ABSOLUTE = 0x20;
static const Shortint OCI_FETCH_RELATIVE = 0x40;
static const Byte OCI_FETCH_RESERVED_1 = 0x80;
static const Shortint OCI_SB2_IND_PTR = 0x1;
static const Shortint OCI_DATA_AT_EXEC = 0x2;
static const Shortint OCI_DYNAMIC_FETCH = 0x2;
static const Shortint OCI_PIECEWISE = 0x4;
static const Shortint OCI_BATCH_MODE = 0x1;
static const Shortint OCI_EXACT_FETCH = 0x2;
static const Shortint OCI_KEEP_FETCH_STATE = 0x4;
static const Shortint OCI_SCROLLABLE_CURSOR = 0x8;
static const Shortint OCI_DESCRIBE_ONLY = 0x10;
static const Shortint OCI_COMMIT_ON_SUCCESS = 0x20;
static const Shortint OCI_MIGRATE = 0x1;
static const Shortint OCI_SYSDBA = 0x2;
static const Shortint OCI_SYSOPER = 0x4;
static const Shortint OCI_PRELIM_AUTH = 0x8;
static const Shortint OCI_PARAM_IN = 0x1;
static const Shortint OCI_PARAM_OUT = 0x2;
static const Shortint OCI_TRANS_OLD = 0x0;
static const Shortint OCI_TRANS_NEW = 0x1;
static const Shortint OCI_TRANS_JOIN = 0x2;
static const Shortint OCI_TRANS_RESUME = 0x4;
static const Byte OCI_TRANS_STARTMASK = 0xff;
static const Word OCI_TRANS_READONLY = 0x100;
static const Word OCI_TRANS_READWRITE = 0x200;
static const Word OCI_TRANS_SERIALIZABLE = 0x400;
static const Word OCI_TRANS_ISOLMASK = 0xff00;
static const int OCI_TRANS_LOOSE = 0x10000;
static const int OCI_TRANS_TIGHT = 0x20000;
static const int OCI_TRANS_TYPEMASK = 0xf0000;
static const int OCI_TRANS_NOMIGRATE = 0x100000;
static const int OCI_TRANS_TWOPHASE = 0x1000000;
static const Shortint OCI_OTYPE_UNK = 0x0;
static const Shortint OCI_OTYPE_TABLE = 0x1;
static const Shortint OCI_OTYPE_VIEW = 0x2;
static const Shortint OCI_OTYPE_SYN = 0x3;
static const Shortint OCI_OTYPE_PROC = 0x4;
static const Shortint OCI_OTYPE_FUNC = 0x5;
static const Shortint OCI_OTYPE_PKG = 0x6;
static const Shortint OCI_OTYPE_STMT = 0x7;
static const Shortint OCI_ATTR_DATA_SIZE = 0x1;
static const Shortint OCI_ATTR_DATA_TYPE = 0x2;
static const Shortint OCI_ATTR_DISP_SIZE = 0x3;
static const Shortint OCI_ATTR_NAME = 0x4;
static const Shortint OCI_ATTR_PRECISION = 0x5;
static const Shortint OCI_ATTR_SCALE = 0x6;
static const Shortint OCI_ATTR_IS_NULL = 0x7;
static const Shortint OCI_ATTR_TYPE_NAME = 0x8;
static const Shortint OCI_ATTR_SCHEMA_NAME = 0x9;
static const Shortint OCI_ATTR_SUB_NAME = 0xa;
static const Shortint OCI_ATTR_POSITION = 0xb;
static const Shortint OCI_ATTR_COMPLEXOBJECTCOMP_TYPE = 0x32;
static const Shortint OCI_ATTR_COMPLEXOBJECTCOMP_TYPE_LEVEL = 0x33;
static const Shortint OCI_ATTR_COMPLEXOBJECT_LEVEL = 0x34;
static const Shortint OCI_ATTR_COMPLEXOBJECT_COLL_OUTOFLINE = 0x35;
static const Shortint OCI_ATTR_DISP_NAME = 0x64;
static const Byte OCI_ATTR_OVERLOAD = 0xd2;
static const Byte OCI_ATTR_LEVEL = 0xd3;
static const Byte OCI_ATTR_HAS_DEFAULT = 0xd4;
static const Byte OCI_ATTR_IOMODE = 0xd5;
static const Byte OCI_ATTR_RADIX = 0xd6;
static const Byte OCI_ATTR_NUM_ARGS = 0xd7;
static const Byte OCI_ATTR_TYPECODE = 0xd8;
static const Byte OCI_ATTR_COLLECTION_TYPECODE = 0xd9;
static const Byte OCI_ATTR_VERSION = 0xda;
static const Byte OCI_ATTR_IS_INCOMPLETE_TYPE = 0xdb;
static const Byte OCI_ATTR_IS_SYSTEM_TYPE = 0xdc;
static const Byte OCI_ATTR_IS_PREDEFINED_TYPE = 0xdd;
static const Byte OCI_ATTR_IS_TRANSIENT_TYPE = 0xde;
static const Byte OCI_ATTR_IS_SYSTEM_GENERATED_TYPE = 0xdf;
static const Byte OCI_ATTR_HAS_NESTED_TABLE = 0xe0;
static const Byte OCI_ATTR_HAS_LOB = 0xe1;
static const Byte OCI_ATTR_HAS_FILE = 0xe2;
static const Byte OCI_ATTR_COLLECTION_ELEMENT = 0xe3;
static const Byte OCI_ATTR_NUM_TYPE_ATTRS = 0xe4;
static const Byte OCI_ATTR_LIST_TYPE_ATTRS = 0xe5;
static const Byte OCI_ATTR_NUM_TYPE_METHODS = 0xe6;
static const Byte OCI_ATTR_LIST_TYPE_METHODS = 0xe7;
static const Byte OCI_ATTR_MAP_METHOD = 0xe8;
static const Byte OCI_ATTR_ORDER_METHOD = 0xe9;
static const Byte OCI_ATTR_NUM_ELEMS = 0xea;
static const Byte OCI_ATTR_ENCAPSULATION = 0xeb;
static const Byte OCI_ATTR_IS_SELFISH = 0xec;
static const Byte OCI_ATTR_IS_VIRTUAL = 0xed;
static const Byte OCI_ATTR_IS_INLINE = 0xee;
static const Byte OCI_ATTR_IS_CONSTANT = 0xef;
static const Byte OCI_ATTR_HAS_RESULT = 0xf0;
static const Byte OCI_ATTR_IS_CONSTRUCTOR = 0xf1;
static const Byte OCI_ATTR_IS_DESTRUCTOR = 0xf2;
static const Byte OCI_ATTR_IS_OPERATOR = 0xf3;
static const Byte OCI_ATTR_IS_MAP = 0xf4;
static const Byte OCI_ATTR_IS_ORDER = 0xf5;
static const Byte OCI_ATTR_IS_RNDS = 0xf6;
static const Byte OCI_ATTR_IS_RNPS = 0xf7;
static const Byte OCI_ATTR_IS_WNDS = 0xf8;
static const Byte OCI_ATTR_IS_WNPS = 0xf9;
static const Byte OCI_ATTR_DESC_PUBLIC = 0xfa;
static const Byte OCI_ATTR_CACHE_CLIENT_CONTEXT = 0xfb;
static const Byte OCI_ATTR_UCI_CONSTRUCT = 0xfc;
static const Byte OCI_ATTR_UCI_DESTRUCT = 0xfd;
static const Byte OCI_ATTR_UCI_COPY = 0xfe;
static const Byte OCI_ATTR_UCI_PICKLE = 0xff;
static const Word OCI_ATTR_UCI_UNPICKLE = 0x100;
static const Word OCI_ATTR_UCI_REFRESH = 0x101;
static const Word OCI_ATTR_IS_SUBTYPE = 0x102;
static const Word OCI_ATTR_SUPERTYPE_SCHEMA_NAME = 0x103;
static const Word OCI_ATTR_SUPERTYPE_NAME = 0x104;
static const Word OCI_ATTR_LIST_OBJECTS = 0x105;
static const Word OCI_ATTR_NCHARSET_ID = 0x106;
static const Word OCI_ATTR_LIST_SCHEMAS = 0x107;
static const Word OCI_ATTR_MAX_PROC_LEN = 0x108;
static const Word OCI_ATTR_MAX_COLUMN_LEN = 0x109;
static const Word OCI_ATTR_CURSOR_COMMIT_BEHAVIOR = 0x10a;
static const Word OCI_ATTR_MAX_CATALOG_NAMELEN = 0x10b;
static const Word OCI_ATTR_CATALOG_LOCATION = 0x10c;
static const Word OCI_ATTR_SAVEPOINT_SUPPORT = 0x10d;
static const Word OCI_ATTR_NOWAIT_SUPPORT = 0x10e;
static const Word OCI_ATTR_AUTOCOMMIT_DDL = 0x10f;
static const Word OCI_ATTR_LOCKING_MODE = 0x110;
static const Word OCI_ATTR_APPCTX_SIZE = 0x111;
static const Word OCI_ATTR_APPCTX_LIST = 0x112;
static const Word OCI_ATTR_APPCTX_NAME = 0x113;
static const Word OCI_ATTR_APPCTX_ATTR = 0x114;
static const Word OCI_ATTR_APPCTX_VALUE = 0x115;
static const Word OCI_ATTR_CLIENT_IDENTIFIER = 0x116;
static const Word OCI_ATTR_IS_FINAL_TYPE = 0x117;
static const Word OCI_ATTR_IS_INSTANTIABLE_TYPE = 0x118;
static const Word OCI_ATTR_IS_FINAL_METHOD = 0x119;
static const Word OCI_ATTR_IS_INSTANTIABLE_METHOD = 0x11a;
static const Word OCI_ATTR_IS_OVERRIDING_METHOD = 0x11b;
static const Word OCI_ATTR_CHAR_USED = 0x11d;
static const Word OCI_ATTR_CHAR_SIZE = 0x11e;
static const Word OCI_ATTR_IS_JAVA_TYPE = 0x11f;
static const Word OCI_ATTR_DISTINGUISHED_NAME = 0x12c;
static const Word OCI_ATTR_KERBEROS_TICKET = 0x12d;
static const Word OCI_ATTR_ORA_DEBUG_JDWP = 0x12e;
static const Word OCI_ATTR_RESERVED_14 = 0x12f;
static const Shortint OCI_ATTR_ENV_CHARSET_ID = 0x1f;
static const Word OCI_ATTR_ENV_NCHARSET_ID = 0x106;
static const Shortint OCI_AUTH = 0x8;
static const Shortint OCI_MAX_FNS = 0x64;
static const Shortint OCI_SQLSTATE_SIZE = 0x5;
static const Word OCI_ERROR_MAXMSG_SIZE = 0x400;
static const unsigned OCI_LOBMAXSIZE = 0xffffffff;
static const Shortint OCI_ROWID_LEN = 0x17;
static const Shortint OCI_FO_END = 0x1;
static const Shortint OCI_FO_ABORT = 0x2;
static const Shortint OCI_FO_REAUTH = 0x4;
static const Shortint OCI_FO_BEGIN = 0x8;
static const Shortint OCI_FO_NONE = 0x1;
static const Shortint OCI_FO_SESSION = 0x2;
static const Shortint OCI_FO_SELECT = 0x4;
static const Shortint OCI_FO_TXNAL = 0x8;
static const Shortint OCI_FNCODE_INITIALIZE = 0x1;
static const Shortint OCI_FNCODE_HANDLEALLOC = 0x2;
static const Shortint OCI_FNCODE_HANDLEFREE = 0x3;
static const Shortint OCI_FNCODE_DESCRIPTORALLOC = 0x4;
static const Shortint OCI_FNCODE_DESCRIPTORFREE = 0x5;
static const Shortint OCI_FNCODE_ENVINIT = 0x6;
static const Shortint OCI_FNCODE_SERVERATTACH = 0x7;
static const Shortint OCI_FNCODE_SERVERDETACH = 0x8;
static const Shortint OCI_FNCODE_SESSIONBEGIN = 0xa;
static const Shortint OCI_FNCODE_SESSIONEND = 0xb;
static const Shortint OCI_FNCODE_PASSWORDCHANGE = 0xc;
static const Shortint OCI_FNCODE_STMTPREPARE = 0xd;
static const Shortint OCI_FNCODE_STMTBINDBYPOS = 0xe;
static const Shortint OCI_FNCODE_STMTBINDBYNAME = 0xf;
static const Shortint OCI_FNCODE_BINDDYNAMIC = 0x11;
static const Shortint OCI_FNCODE_BINDOBJECT = 0x12;
static const Shortint OCI_FNCODE_BINDARRAYOFSTRUCT = 0x14;
static const Shortint OCI_FNCODE_STMTEXECUTE = 0x15;
static const Shortint OCI_FNCODE_DEFINE = 0x18;
static const Shortint OCI_FNCODE_DEFINEOBJECT = 0x19;
static const Shortint OCI_FNCODE_DEFINEDYNAMIC = 0x1a;
static const Shortint OCI_FNCODE_DEFINEARRAYOFSTRUCT = 0x1b;
static const Shortint OCI_FNCODE_STMTFETCH = 0x1c;
static const Shortint OCI_FNCODE_STMTGETBIND = 0x1d;
static const Shortint OCI_FNCODE_DESCRIBEANY = 0x20;
static const Shortint OCI_FNCODE_TRANSSTART = 0x21;
static const Shortint OCI_FNCODE_TRANSDETACH = 0x22;
static const Shortint OCI_FNCODE_TRANSCOMMIT = 0x23;
static const Shortint OCI_FNCODE_ERRORGET = 0x25;
static const Shortint OCI_FNCODE_LOBOPENFILE = 0x26;
static const Shortint OCI_FNCODE_LOBCLOSEFILE = 0x27;
static const Shortint OCI_FNCODE_LOBCREATEFILE = 0x28;
static const Shortint OCI_FNCODE_LOBDELFILE = 0x29;
static const Shortint OCI_FNCODE_LOBCOPY = 0x2a;
static const Shortint OCI_FNCODE_LOBAPPEND = 0x2b;
static const Shortint OCI_FNCODE_LOBERASE = 0x2c;
static const Shortint OCI_FNCODE_LOBLENGTH = 0x2d;
static const Shortint OCI_FNCODE_LOBTRIM = 0x2e;
static const Shortint OCI_FNCODE_LOBREAD = 0x2f;
static const Shortint OCI_FNCODE_LOBWRITE = 0x30;
static const Shortint OCI_FNCODE_SVCCTXBREAK = 0x32;
static const Shortint OCI_FNCODE_SERVERVERSION = 0x33;
static const Shortint OCI_FNCODE_ATTRGET = 0x36;
static const Shortint OCI_FNCODE_ATTRSET = 0x37;
static const Shortint OCI_FNCODE_PARAMSET = 0x38;
static const Shortint OCI_FNCODE_PARAMGET = 0x39;
static const Shortint OCI_FNCODE_STMTGETPIECEINFO = 0x3a;
static const Shortint OCI_FNCODE_LDATOSVCCTX = 0x3b;
static const Shortint OCI_FNCODE_RESULTSETTOSTMT = 0x3c;
static const Shortint OCI_FNCODE_STMTSETPIECEINFO = 0x3d;
static const Shortint OCI_FNCODE_TRANSFORGET = 0x3e;
static const Shortint OCI_FNCODE_TRANSPREPARE = 0x3f;
static const Shortint OCI_FNCODE_TRANSROLLBACK = 0x40;
static const Shortint OCI_FNCODE_DEFINEBYPOS = 0x41;
static const Shortint OCI_FNCODE_BINDBYPOS = 0x42;
static const Shortint OCI_FNCODE_BINDBYNAME = 0x43;
static const Shortint OCI_FNCODE_LOBASSIGN = 0x44;
static const Shortint OCI_FNCODE_LOBISEQUAL = 0x45;
static const Shortint OCI_FNCODE_LOBISINIT = 0x46;
static const Shortint OCI_FNCODE_LOBLOCATORSIZE = 0x47;
static const Shortint OCI_FNCODE_LOBCHARSETID = 0x48;
static const Shortint OCI_FNCODE_LOBCHARSETFORM = 0x49;
static const Shortint OCI_FNCODE_LOBFILESETNAME = 0x4a;
static const Shortint OCI_FNCODE_LOBFILEGETNAME = 0x4b;
static const Shortint OCI_FNCODE_LOGON = 0x4c;
static const Shortint OCI_FNCODE_LOGOFF = 0x4d;
static const Shortint OCI_INTHR_UNK = 0x18;
static const Shortint OCI_ADJUST_UNK = 0xa;
static const Shortint OCI_ORACLE_DATE = 0x0;
static const Shortint OCI_ANSI_DATE = 0x1;
static const Shortint OCI_LOBMODE_READONLY = 0x1;
static const Shortint OCI_FILE_READONLY = 0x1;
static const Shortint OCI_LOB_BUFFER_FREE = 0x1;
static const Shortint OCI_LOB_BUFFER_NOFREE = 0x2;
static const Shortint OCI_STMT_SELECT = 0x1;
static const Shortint OCI_STMT_UPDATE = 0x2;
static const Shortint OCI_STMT_DELETE = 0x3;
static const Shortint OCI_STMT_INSERT = 0x4;
static const Shortint OCI_STMT_CREATE = 0x5;
static const Shortint OCI_STMT_DROP = 0x6;
static const Shortint OCI_STMT_ALTER = 0x7;
static const Shortint OCI_STMT_BEGIN = 0x8;
static const Shortint OCI_STMT_DECLARE = 0x9;
static const Shortint OCI_PTYPE_UNK = 0x0;
static const Shortint OCI_PTYPE_TABLE = 0x1;
static const Shortint OCI_PTYPE_VIEW = 0x2;
static const Shortint OCI_PTYPE_PROC = 0x3;
static const Shortint OCI_PTYPE_FUNC = 0x4;
static const Shortint OCI_PTYPE_PKG = 0x5;
static const Shortint OCI_PTYPE_TYPE = 0x6;
static const Shortint OCI_PTYPE_SYN = 0x7;
static const Shortint OCI_PTYPE_SEQ = 0x8;
static const Shortint OCI_PTYPE_COL = 0x9;
static const Shortint OCI_PTYPE_ARG = 0xa;
static const Shortint OCI_PTYPE_LIST = 0xb;
static const Shortint OCI_PTYPE_TYPE_ATTR = 0xc;
static const Shortint OCI_PTYPE_TYPE_COLL = 0xd;
static const Shortint OCI_PTYPE_TYPE_METHOD = 0xe;
static const Shortint OCI_PTYPE_TYPE_ARG = 0xf;
static const Shortint OCI_PTYPE_TYPE_RESULT = 0x10;
static const Shortint OCI_LTYPE_UNK = 0x0;
static const Shortint OCI_LTYPE_COLUMN = 0x1;
static const Shortint OCI_LTYPE_ARG_PROC = 0x2;
static const Shortint OCI_LTYPE_ARG_FUNC = 0x3;
static const Shortint OCI_LTYPE_SUBPRG = 0x4;
static const Shortint OCI_LTYPE_TYPE_ATTR = 0x5;
static const Shortint OCI_LTYPE_TYPE_METHOD = 0x6;
static const Shortint OCI_LTYPE_TYPE_ARG_PROC = 0x7;
static const Shortint OCI_LTYPE_TYPE_ARG_FUNC = 0x8;
static const short OCI_IND_NOTNULL = 0x0;
static const short OCI_IND_NULL = 0xffffffff;
static const short OCI_IND_BADNULL = 0xfffffffe;
static const short OCI_IND_NOTNULLABLE = 0xfffffffd;
static const Shortint OCI_PIN_DEFAULT = 0x1;
static const Shortint OCI_PIN_ANY = 0x3;
static const Shortint OCI_PIN_RECENT = 0x4;
static const Shortint OCI_PIN_LATEST = 0x5;
static const Shortint OCI_LOCK_NONE = 0x1;
static const Shortint OCI_LOCK_X = 0x2;
static const Shortint OCI_MARK_DEFAULT = 0x1;
static const Shortint OCI_MARK_NONE = 0x1;
static const Shortint OCI_MARK_UPDATE = 0x2;
static const Shortint OCI_DURATION_BEGIN = 0xa;
static const Shortint OCI_DURATION_NULL = 0x9;
static const Shortint OCI_DURATION_DEFAULT = 0x8;
static const Shortint OCI_DURATION_NEXT = 0x7;
static const Shortint OCI_DURATION_SESSION = 0xa;
static const Shortint OCI_DURATION_TRANS = 0xb;
static const Shortint OCI_REFRESH_LOADED = 0x1;
static const Byte OCI_OBJECTCOPY_NOREF = 0x1;
static const Word OCI_OBJECTFREE_FORCE = 0x1;
static const Word OCI_OBJECTFREE_NONULL = 0x2;
static const Shortint OCI_TYPECODE_REF = 0x6e;
static const Shortint OCI_TYPECODE_DATE = 0xc;
static const Shortint OCI_TYPECODE_SIGNED8 = 0x1b;
static const Shortint OCI_TYPECODE_SIGNED16 = 0x1c;
static const Shortint OCI_TYPECODE_SIGNED32 = 0x1d;
static const Shortint OCI_TYPECODE_REAL = 0x15;
static const Shortint OCI_TYPECODE_DOUBLE = 0x16;
static const Shortint OCI_TYPECODE_FLOAT = 0x4;
static const Shortint OCI_TYPECODE_NUMBER = 0x2;
static const Shortint OCI_TYPECODE_DECIMAL = 0x7;
static const Shortint OCI_TYPECODE_UNSIGNED8 = 0x17;
static const Shortint OCI_TYPECODE_UNSIGNED16 = 0x19;
static const Shortint OCI_TYPECODE_UNSIGNED32 = 0x1a;
static const Byte OCI_TYPECODE_OCTET = 0xf5;
static const Byte OCI_TYPECODE_SMALLINT = 0xf6;
static const Shortint OCI_TYPECODE_INTEGER = 0x3;
static const Shortint OCI_TYPECODE_RAW = 0x5f;
static const Shortint OCI_TYPECODE_PTR = 0x20;
static const Shortint OCI_TYPECODE_VARCHAR2 = 0x9;
static const Shortint OCI_TYPECODE_CHAR = 0x60;
static const Shortint OCI_TYPECODE_VARCHAR = 0x1;
static const Shortint OCI_TYPECODE_MLSLABEL = 0x69;
static const Byte OCI_TYPECODE_VARRAY = 0xf7;
static const Byte OCI_TYPECODE_TABLE = 0xf8;
static const Shortint OCI_TYPECODE_OBJECT = 0x6c;
static const Shortint OCI_TYPECODE_NAMEDCOLLECTION = 0x7a;
static const Shortint OCI_TYPECODE_BLOB = 0x71;
static const Shortint OCI_TYPECODE_BFILE = 0x72;
static const Shortint OCI_TYPECODE_CLOB = 0x70;
static const Shortint OCI_TYPECODE_CFILE = 0x73;
static const Byte OCI_TYPECODE_TIME = 0xb9;
static const Byte OCI_TYPECODE_TIME_TZ = 0xba;
static const Byte OCI_TYPECODE_TIMESTAMP = 0xbb;
static const Byte OCI_TYPECODE_TIMESTAMP_TZ = 0xbc;
static const Byte OCI_TYPECODE_TIMESTAMP_LTZ = 0xe8;
static const Byte OCI_TYPECODE_INTERVAL_YM = 0xbd;
static const Byte OCI_TYPECODE_INTERVAL_DS = 0xbe;
static const Byte OCI_TYPECODE_OTMFIRST = 0xe4;
static const Word OCI_TYPECODE_OTMLAST = 0x140;
static const Byte OCI_TYPECODE_SYSFIRST = 0xe4;
static const Byte OCI_TYPECODE_SYSLAST = 0xeb;
static const Word OCI_TYPECODE_NCHAR = 0x11e;
static const Word OCI_TYPECODE_NVARCHAR2 = 0x11f;
static const Word OCI_TYPECODE_NCLOB = 0x120;
static const Shortint OCI_TYPECODE_NONE = 0x0;
static const Word OCI_TYPECODE_ERRHP = 0x11b;
static const Shortint OCI_TYPEGET_HEADER = 0x0;
static const Shortint OCI_TYPEGET_ALL = 0x1;
static const Shortint OCI_TYPEENCAP_PRIVATE = 0x1;
static const Shortint OCI_TYPEENCAP_PUBLIC = 0x2;
static const Shortint OCI_TYPEMETHOD_INLINE = 0x1;
static const Shortint OCI_TYPEMETHOD_CONSTANT = 0x2;
static const Shortint OCI_TYPEMETHOD_VIRTUAL = 0x4;
static const Shortint OCI_TYPEMETHOD_CONSTRUCTOR = 0x8;
static const Shortint OCI_TYPEMETHOD_DESTRUCTOR = 0x10;
static const Shortint OCI_TYPEMETHOD_OPERATOR = 0x20;
static const Shortint OCI_TYPEMETHOD_SELFISH = 0x40;
static const Byte OCI_TYPEMETHOD_MAP = 0x80;
static const Word OCI_TYPEMETHOD_ORDER = 0x100;
static const Word OCI_TYPEMETHOD_RNDS = 0x200;
static const Word OCI_TYPEMETHOD_WNDS = 0x400;
static const Word OCI_TYPEMETHOD_RNPS = 0x800;
static const Word OCI_TYPEMETHOD_WNPS = 0x1000;
static const Shortint OCI_TYPEPARAM_IN = 0x0;
static const Shortint OCI_TYPEPARAM_OUT = 0x1;
static const Shortint OCI_TYPEPARAM_INOUT = 0x2;
static const Shortint OCI_TYPEPARAM_BYREF = 0x3;
static const Byte OCI_NUMBER_DEFAULTPREC = 0x0;
static const Shortint OCI_NUMBER_DEFAULTSCALE = 0xffffff81;
static const Word OCI_VARRAY_MAXSIZE = 0xfa0;
static const Word OCI_STRING_MAXLEN = 0xfa0;
static const int OCI_COHERENCY_NONE = 0x2;
static const int OCI_COHERENCY_NULL = 0x4;
static const int OCI_COHERENCY_ALWAYS = 0x5;
extern PACKAGE int __cdecl (*OCITypeArrayByName)(void * &hEnv, void * &hError, const POCISvcCtx phSvc
	, int array_len, const PPChar arr_schema_name, ub4p arr_s_length, const PPChar arr_type_name, ub4p 
	arr_t_length, const PPChar arr_version_name, ub4p arr_v_length, Word pin_duration, int get_option, 
	POCIType arr_tdo);
extern PACKAGE int __cdecl (*OCITypeArrayByRef)(void * &hEnv, void * &hError, int array_len, const POCIRef 
	arr_type_ref, Word pin_duration, int get_option, POCIType arr_tdo);
extern PACKAGE int __cdecl (*OCIInitialize)(int mode, Pdvoid ctxp, Tmalocfp malocfp, Tralocfp ralocfp
	, Tmfreefp mfreefp);
extern PACKAGE int __cdecl (*OCITerminate)(int mode);
extern PACKAGE int __cdecl (*OCIHandleAlloc)(const Pdvoid phParenEnv, Pdvoid &hndlp, int htype, int 
	xtramem_sz, PPdvoid usrmemp);
extern PACKAGE int __cdecl (*OCIHandleFree)(Pdvoid hndlp, int htype);
extern PACKAGE int __cdecl (*OCIDescriptorAlloc)(const Pdvoid phParenEnv, Pdvoid &descp, int htype, 
	int xtramem_sz, PPdvoid usrmemp);
extern PACKAGE int __cdecl (*OCIDescriptorFree)(Pdvoid descp, int htype);
extern PACKAGE int __cdecl (*OCIEnvCreate)(POCIEnv &phEnv, int mode, Pdvoid ctxp, Tmalocfp malocfp, 
	Tralocfp ralocfp, Tmfreefp mfreefp, int xtramem_sz, Pdvoid usrmemp);
extern PACKAGE int __cdecl (*OCIEnvInit)(POCIEnv &phEnv, int mode, int xtramem_sz, Pdvoid usrmemp);
extern PACKAGE int __cdecl (*OCIServerAttach)(POCIServer phSrv, POCIError phError, const char * dblink
	, int dblink_len, int mode);
extern PACKAGE int __cdecl (*OCIServerDetach)(POCIServer phSrv, POCIError phError, int mode);
extern PACKAGE int __cdecl (*OCISessionBegin)(POCISvcCtx phSvc, POCIError phError, POCISession phUsr
	, int credt, int mode);
extern PACKAGE int __cdecl (*OCISessionEnd)(POCISvcCtx phSvc, POCIError phError, POCISession phUsr, 
	int mode);
extern PACKAGE int __cdecl (*OCILogon)(POCIEnv phEnv, POCIError phError, POCISvcCtx &svchp, const char * 
	username, int uname_len, const char * password, int passwd_len, const char * dbname, int dbname_len
	);
extern PACKAGE int __cdecl (*OCILogoff)(POCISvcCtx phSvc, POCIError phError);
extern PACKAGE int __cdecl (*OCIPasswordChange)(POCISvcCtx phSvc, POCIError phError, const char * user_name
	, int usernm_len, const char * opasswd, int opasswd_len, const char * npasswd, int npasswd_len, int 
	mode);
extern PACKAGE int __cdecl (*OCIStmtPrepare)(POCIStmt phStmt, POCIError phError, const char * stmt, 
	int stmt_len, int language, int mode);
extern PACKAGE int __cdecl (*OCIBindByPos)(POCIStmt phStmt, POCIBind &phBind, POCIError phError, int 
	position, Pdvoid valuep, int value_sz, Word dty, Pdvoid indp, ub2p alenp, ub2p rcodep, int maxarr_len
	, ub4p curelep, int mode);
extern PACKAGE int __cdecl (*OCIBindByName)(POCIStmt phStmt, POCIBind &phBind, POCIError phError, const 
	char * placeholder, int placeh_len, Pdvoid valuep, int value_sz, Word dty, Pdvoid indp, ub2p alenp, 
	ub2p rcodep, int maxarr_len, ub4p curelep, int mode);
extern PACKAGE int __cdecl (*OCIBindObject)(POCIBind phBind, POCIError phError, const POCIType otype
	, Pdvoid &pgvp, int pvszsp, Pdvoid &indp, ub4p indszp);
extern PACKAGE int __cdecl (*OCIBindDynamic)(POCIBind phBind, POCIError phError, Pdvoid ictxp, TOCICallbackInBind 
	icbfp, Pdvoid octxp, TOCICallbackOutBind ocbfp);
extern PACKAGE int __cdecl (*OCIBindArrayOfStruct)(POCIBind phBind, POCIError phError, int pvskip, int 
	indskip, int alskip, int rcskip);
extern PACKAGE int __cdecl (*OCIStmtGetPieceInfo)(POCIStmt phStmt, POCIError phError, Pdvoid &hndlp, 
	int &htype, Byte &in_out, int &iter, int &idx, Byte &piece);
extern PACKAGE int __cdecl (*OCIStmtSetPieceInfo)(Pdvoid hndlp, int HandleType, POCIError phError, const 
	void * bufp, int &alen, Byte piece, short &ind, ub2p rcodep);
extern PACKAGE int __cdecl (*OCIStmtExecute)(POCISvcCtx phSvc, POCIStmt phStmt, POCIError phError, int 
	iters, int rowoff, const POCISnapshot snap_in, POCISnapshot snap_out, int mode);
extern PACKAGE int __cdecl (*OCIDefineByPos)(POCIStmt phStmt, POCIDefine &phDefine, POCIError phError
	, int position, void * pValue, int value_sz, Word dty, Pdvoid indp, ub2p rlenp, ub2p rcodep, int mode
	);
extern PACKAGE int __cdecl (*OCIDefineObject)(POCIDefine phDefine, POCIError phError, const POCIType 
	phType, Pdvoid &pgvp, ub4p pvszsp, Pdvoid &indp, ub4p indszp);
extern PACKAGE int __cdecl (*OCIDefineDynamic)(POCIDefine phDefine, POCIError phError, Pdvoid octxp, 
	TOCICallbackDefine ocbfp);
extern PACKAGE int __cdecl (*OCIDefineArrayOfStruct)(POCIDefine phDefine, POCIError phError, int pvskip
	, int indskip, int rlskip, int rcskip);
extern PACKAGE int __cdecl (*OCIStmtFetch)(POCIStmt phStmt, POCIError phError, int nrows, Word orientation
	, int mode);
extern PACKAGE int __cdecl (*OCIStmtGetBindInfo)(POCIStmt phStmt, POCIError phError, int size, int startloc
	, sb4p found, PPChar arr_bvn, ub1p arr_bvnl, PPChar arr_inv, ub1p arr_inpl, ub1p arr_dupl, PPOCIBind 
	arr_hndl);
extern PACKAGE int __cdecl (*OCIDescribeAny)(POCISvcCtx phSvc, POCIError phError, Pdvoid objptr, int 
	objnm_len, Byte objptr_typ, Byte info_level, Byte objtyp, POCIDescribe phDsc);
extern PACKAGE int __cdecl (*OCIParamGet)(const Pdvoid pHndl, int htype, POCIError phError, Pdvoid &
	pParmd, int pos);
extern PACKAGE int __cdecl (*OCIParamSet)(Pdvoid pHdl, int htyp, POCIError phError, const Pdvoid pDsc
	, int dtyp, int pos);
extern PACKAGE int __cdecl (*OCITransStart)(POCISvcCtx phSvc, POCIError phError, int timeout, int flags
	);
extern PACKAGE int __cdecl (*OCITransDetach)(POCISvcCtx phSvc, POCIError phError, int flags);
extern PACKAGE int __cdecl (*OCITransCommit)(POCISvcCtx phSvc, POCIError phError, int flags);
extern PACKAGE int __cdecl (*OCITransRollback)(POCISvcCtx phSvc, POCIError phError, int flags);
extern PACKAGE int __cdecl (*OCITransPrepare)(POCISvcCtx phSvc, POCIError phError, int flags);
extern PACKAGE int __cdecl (*OCITransForget)(POCISvcCtx phSvc, POCIError phError, int flags);
extern PACKAGE int __cdecl (*OCIErrorGet)(Pdvoid pHndl, int RecordNo, char * SqlState, int &ErrCode, 
	char * buf, int bufsiz, int typ);
extern PACKAGE int __cdecl (*OCILobAppend)(POCISvcCtx phSvc, POCIError phError, POCILobLocator dst_locp
	, POCILobLocator src_locp);
extern PACKAGE int __cdecl (*OCILobAssign)(POCIEnv phEnv, POCIError phError, const POCILobLocator src_locp
	, POCILobLocator &dst_locp);
extern PACKAGE int __cdecl (*OCILobCharSetForm)(POCIEnv phEnv, POCIError phError, const POCILobLocator 
	locp, ub1p csfrm);
extern PACKAGE int __cdecl (*OCILobCharSetId)(POCIEnv phEnv, POCIError phError, const POCILobLocator 
	locp, ub2p csid);
extern PACKAGE int __cdecl (*OCILobCopy)(POCISvcCtx phSvc, POCIError phError, void * dst_locp, void * 
	src_locp, int amount, int dst_offset, int src_offset);
extern PACKAGE int __cdecl (*OCILobCreateTemporary)(POCISvcCtx phSvc, POCIError phError, POCILobLocator 
	locp, Word csid, Byte csfrm, Byte lobtype, BOOL cache, Word duration);
extern PACKAGE int __cdecl (*OCILobDisableBuffering)(POCISvcCtx phSvc, POCIError phError, POCILobLocator 
	locp);
extern PACKAGE int __cdecl (*OCILobEnableBuffering)(POCISvcCtx phSvc, POCIError phError, POCILobLocator 
	locp);
extern PACKAGE int __cdecl (*OCILobErase)(POCISvcCtx phSvc, POCIError phError, POCILobLocator locp, 
	ub4p amount, int offset);
extern PACKAGE int __cdecl (*OCILobFileClose)(POCISvcCtx phSvc, POCIError phError, POCILobLocator filep
	);
extern PACKAGE int __cdecl (*OCILobFileCloseAll)(POCISvcCtx phSvc, POCIError phError);
extern PACKAGE int __cdecl (*OCILobFileExists)(POCISvcCtx phSvc, POCIError phError, POCILobLocator filep
	, BOOL &flag);
extern PACKAGE int __cdecl (*OCILobFileGetName)(POCIEnv phEnv, POCIError phError, const POCILobLocator 
	filep, char * dir_alias, ub2p d_length, char * filename, ub2p f_length);
extern PACKAGE int __cdecl (*OCILobFileIsOpen)(POCISvcCtx phSvc, POCIError phError, POCILobLocator filep
	, BOOL &flag);
extern PACKAGE int __cdecl (*OCILobFileOpen)(POCISvcCtx phSvc, POCIError phError, POCILobLocator filep
	, Byte mode);
extern PACKAGE int __cdecl (*OCILobFileSetName)(POCIEnv phEnv, POCIError phError, POCILobLocator &filep
	, const char * dir_alias, Word d_length, const char * filename, Word f_length);
extern PACKAGE int __cdecl (*OCILobFlushBuffer)(POCISvcCtx phSvc, POCIError phError, POCILobLocator 
	locp, int flag);
extern PACKAGE int __cdecl (*OCILobFreeTemporary)(POCISvcCtx phSvc, POCIError phError, POCILobLocator 
	locp);
extern PACKAGE int __cdecl (*OCILobGetLength)(POCISvcCtx phSvc, POCIError phError, POCILobLocator locp
	, int &len);
extern PACKAGE int __cdecl (*OCILobIsEqual)(POCIEnv phEnv, const POCILobLocator x, const POCILobLocator 
	y, BOOL &is_equal);
extern PACKAGE int __cdecl (*OCILobLoadFromFile)(POCISvcCtx phSvc, POCIError phError, POCILobLocator 
	dst_locp, POCILobLocator src_filep, int amount, int dst_offset, int src_offset);
extern PACKAGE int __cdecl (*OCILobLocatorIsInit)(POCIEnv phEnv, POCIError phError, const POCILobLocator 
	locp, BOOL &is_initialized);
extern PACKAGE int __cdecl (*OCILobRead)(POCISvcCtx phSvc, POCIError phError, POCILobLocator locp, int 
	&amt, int offset, void * bufp, int bufl, Pdvoid ctxp, TCBLobRead cbfp, Word csid, Byte csfrm);
extern PACKAGE int __cdecl (*OCILobTrim)(POCISvcCtx phSvc, POCIError phError, POCILobLocator locp, int 
	newlen);
extern PACKAGE int __cdecl (*OCILobWrite)(POCISvcCtx phSvc, POCIError phError, POCILobLocator locp, 
	int &amt, int offset, void * bufp, int buflen, Byte piece, Pdvoid ctxp, TCBLobWrite cbfp, Word csid
	, Byte csfrm);
extern PACKAGE int __cdecl (*OCIBreak)(Pdvoid pHndl, POCIError phError);
extern PACKAGE int __cdecl (*OCIServerVersion)(Pdvoid pHndl, POCIError phError, char * buf, int bufsz
	, Byte hndltype);
extern PACKAGE int __cdecl (*OCIAttrGet)(const Pdvoid trgthndlp, int trghndltyp, void * attributep, 
	ub4p sizep, int attrtype, POCIError phError);
extern PACKAGE int __cdecl (*OCIAttrSet)(Pdvoid trgthndlp, int trghndltyp, void * attributep, int size
	, int attrtype, POCIError phError);
extern PACKAGE int __cdecl (*OCISvcCtxToLda)(POCISvcCtx phSvc, POCIError phError, PLdaDef ldap);
extern PACKAGE int __cdecl (*OCILdaToSvcCtx)(POCISvcCtx &phSvc, POCIError phError, PLdaDef ldap);
extern PACKAGE int __cdecl (*OCIResultSetToStmt)(POCIResult phRset, POCIError phError);
extern PACKAGE POCIEnv __cdecl (*xaoEnv)(char * dbname);
extern PACKAGE POCISvcCtx __cdecl (*xaoSvcCtx)(char * dbname);
extern PACKAGE int __cdecl (*OCIDateTimeConstruct)(Pdvoid pHndl, POCIError phError, POCIDateTime datetime
	, short year, Byte month, Byte day, Byte hour, Byte min, Byte sec, int fsec, char * timezone, int timezone_length
	);
extern PACKAGE int __cdecl (*OCIDateTimeGetDate)(Pdvoid pHndl, POCIError phError, POCIDateTime date, 
	short &year, Byte &month, Byte &day);
extern PACKAGE int __cdecl (*OCIDateTimeGetTime)(Pdvoid pHndl, POCIError phError, POCIDateTime datetime
	, Byte &hour, Byte &minute, Byte &sec, int &fsec);
extern PACKAGE int __cdecl (*OCIDateTimeGetTimeZoneName)(Pdvoid pHndl, POCIError phError, POCIDateTime 
	datetime, ub1p buf, ub4p buflen);
extern PACKAGE int __cdecl (*OCIDateTimeGetTimeZoneOffset)(Pdvoid pHndl, POCIError phError, POCIDateTime 
	datetime, Shortint &hour, Shortint &minute);
extern PACKAGE int __cdecl (*OCIIntervalSetYearMonth)(Pdvoid pHndl, POCIError phError, int yr, int mnth
	, POCIInterval result);
extern PACKAGE int __cdecl (*OCIIntervalGetYearMonth)(Pdvoid pHndl, POCIError phError, int &yr, int 
	&mnth, const POCIInterval result);
extern PACKAGE int __cdecl (*OCIIntervalSetDaySecond)(Pdvoid pHndl, POCIError phError, int dy, int hr
	, int mm, int ss, int fsec, POCIInterval result);
extern PACKAGE int __cdecl (*OCIIntervalGetDaySecond)(Pdvoid pHndl, POCIError phError, int &dy, int 
	&hr, int &mm, int &ss, int &fsec, const POCIInterval result);
#define DefSqlApiDLL "ORACLIENT10.DLL;ORACLIENT9.DLL;ORACLIENT8.DLL;ORA805.DLL;O"\
	"RA804.DLL;ORA803.DLL;OCI.DLL;ORA73.DLL;ORA72.DLL;OCIW32.DL"\
	"L"
#define DefOCI7DLL "OCIW32.DLL"
#define DefOCI8DLL "OCI.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE bool Oracle8Blobs;
extern PACKAGE bool UsePiecewiseCalls;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE int __fastcall LoadSqlLib(bool IsForceOCI7);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdora */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdora;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDOra
