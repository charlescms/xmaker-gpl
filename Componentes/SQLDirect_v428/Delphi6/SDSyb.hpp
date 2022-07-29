// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDSyb.pas' rev: 6.00

#ifndef SDSybHPP
#define SDSybHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdsyb
{
//-- type declarations -------------------------------------------------------
typedef int TCS_INT;

typedef int TCS_RETCODE;

typedef int TCS_BOOL;

typedef unsigned TCS_UINT;

typedef void *void;

typedef void *TCS_VOID;

typedef void *TCS_THRDRES;

typedef double TCS_FLOAT;

typedef void * *PCS_VOID;

typedef int *PCS_INT;

typedef void * *PCS_THRDRES;

typedef int TCS_MSGNUM;

typedef Byte TCS_TINYINT;

typedef short TCS_SMALLINT;

typedef char TCS_CHAR;

typedef Byte TCS_BINARY;

typedef Byte TCS_BIT;

typedef float TCS_REAL;

typedef Byte TCS_BYTE;

typedef Byte TCS_TEXT;

typedef Byte TCS_IMAGE;

typedef Byte TCS_LONGCHAR;

typedef Byte TCS_LONGBINARY;

typedef int TCS_LONG;

typedef int TCS_VOIDDATA;

typedef Word TCS_UNICHAR;

typedef char *PCS_CHAR;

typedef short *PCS_SMALLINT;

typedef Word TCS_USHORT;

#pragma pack(push, 4)
struct _cs_datetime
{
	int dtdays;
	int dttime;
} ;
#pragma pack(pop)

typedef _cs_datetime  TCS_DATETIME;

typedef _cs_datetime *PCS_DATETIME;

#pragma pack(push, 2)
struct _cs_datetime4
{
	Word days;
	Word minutes;
} ;
#pragma pack(pop)

typedef _cs_datetime4  TCS_DATETIME4;

typedef _cs_datetime4 *PCS_DATETIME4;

#pragma pack(push, 4)
struct _cs_money
{
	int mnyhigh;
	unsigned mnylow;
} ;
#pragma pack(pop)

typedef _cs_money  TCS_MONEY;

#pragma pack(push, 4)
struct _cs_money4
{
	int mny4;
} ;
#pragma pack(pop)

typedef int TCS_MONEY4;

#pragma pack(push, 1)
struct _cs_numeric
{
	Byte precision;
	Byte scale;
	Byte num[33];
} ;
#pragma pack(pop)

typedef _cs_numeric  TCS_NUMERIC;

typedef _cs_numeric  TCS_DECIMAL;

#pragma pack(push, 2)
struct _cs_varychar
{
	short len;
	char str[256];
} ;
#pragma pack(pop)

typedef _cs_varychar  TCS_VARCHAR;

#pragma pack(push, 2)
struct _cs_varybin
{
	short len;
	Byte arr[256];
} ;
#pragma pack(pop)

typedef _cs_varybin  TCS_VARBINARY;

#pragma pack(push, 4)
struct _cs_daterec
{
	int dateyear;
	int datemonth;
	int datedmonth;
	int datedyear;
	int datedweek;
	int datehour;
	int dateminute;
	int datesecond;
	int datemsecond;
	int datetzone;
} ;
#pragma pack(pop)

typedef _cs_daterec  TCS_DATEREC;

typedef _cs_daterec *PCS_DATEREC;

typedef void *TCS_CONTEXT;

typedef void *TCS_LOCALE;

typedef void *TCS_CONNECTION;

typedef void *TCS_COMMAND;

typedef void *TCS_DS_OBJECT;

typedef void *TCS_DS_RESULT;

typedef void * *PCS_CONTEXT;

typedef void * *PCS_LOCALE;

typedef void * *PCS_CONNECTION;

typedef void * *PCS_COMMAND;

typedef void * *PCS_DS_OBJECT;

typedef void * *PCS_DS_RESULT;

#pragma pack(push, 4)
struct _cs_datafmt
{
	char name[132];
	int namelen;
	int datatype;
	int format;
	int maxlength;
	int scale;
	int precision;
	int status;
	int count;
	int usertype;
	void * *locale;
} ;
#pragma pack(pop)

typedef _cs_datafmt  TCS_DATAFMT;

typedef _cs_datafmt *PCS_DATAFMT;

#pragma pack(push, 4)
struct _cs_objname
{
	int thinkexists;
	int object_type;
	char last_name[132];
	int lnlen;
	char first_name[132];
	int fnlen;
	void * *scope;
	int scopelen;
	void * *thread;
	int threadlen;
} ;
#pragma pack(pop)

typedef _cs_objname  TCS_OBJNAME;

#pragma pack(push, 4)
struct _cs_objdata
{
	int actuallyexists;
	void * *connection;
	void * *command;
	void * *buffer;
	int buflen;
} ;
#pragma pack(pop)

typedef _cs_objdata  TCS_OBJDATA;

typedef int __stdcall (*TCS_CONV_FUNC)(PCS_CONTEXT context, _cs_datafmt &srcfmt, PCS_VOID src, _cs_datafmt &destfmt, PCS_VOID dest, int &destlen);

typedef int __stdcall (*TCS_THRDM_FUNC)(void * &resource);

typedef int __stdcall (*TCS_THRDE_FUNC)(void * &resource);

typedef int __stdcall (*TCS_THRDC_FUNC)(PCS_THRDRES &resource);

typedef int __stdcall (*TCS_THRDW_FUNC)(void * &resource, int millisecs);

typedef int __stdcall (*TCS_THRDID_FUNC)(PCS_VOID buffer, int buflen, int &outlen);

#pragma pack(push, 4)
struct _cs_thread
{
	TCS_THRDC_FUNC create_mutex_fn;
	TCS_THRDM_FUNC delete_mutex_fn;
	TCS_THRDM_FUNC take_mutex_fn;
	TCS_THRDM_FUNC release_mutex_fn;
	TCS_THRDC_FUNC create_event_fn;
	TCS_THRDE_FUNC delete_event_fn;
	TCS_THRDE_FUNC signal_event_fn;
	TCS_THRDE_FUNC reset_event_fn;
	TCS_THRDW_FUNC waitfor_event_fn;
	TCS_THRDID_FUNC thread_id_fn;
} ;
#pragma pack(pop)

typedef _cs_thread  TCS_THREAD;

#pragma pack(push, 4)
struct _cs_string
{
	int str_length;
	char str_buffer[512];
} ;
#pragma pack(pop)

typedef _cs_string  TCS_STRING;

#pragma pack(push, 4)
struct _cs_tranaddr
{
	int addr_accesstype;
	_cs_string addr_trantype;
	_cs_string addr_tranaddress;
} ;
#pragma pack(pop)

typedef _cs_tranaddr  TCS_TRANADDR;

#pragma pack(push, 4)
struct _cs_oid
{
	int oid_length;
	char oid_buffer[512];
} ;
#pragma pack(pop)

typedef _cs_oid  TCS_OID;

typedef _cs_oid *PCS_OID;

#pragma pack(push, 4)
struct _cs_attrvalue
{
	_cs_string value_string;
	int value_boolean;
	int value_enumeration;
	int value_integer;
	_cs_oid value_oid;
	_cs_tranaddr value_tranaddr;
} ;
#pragma pack(pop)

typedef _cs_attrvalue  TCS_ATTRVALUE;

#pragma pack(push, 4)
struct _cs_attribute
{
	_cs_oid attr_type;
	int attr_syntax;
	int attr_numvals;
} ;
#pragma pack(pop)

typedef _cs_attribute  TCS_ATTRIBUTE;

#pragma pack(push, 4)
struct _cs_ds_lookup_info
{
	_cs_oid *objclass;
	char *path;
	int pathlen;
	void * *attrfilter;
	void * *attrselect;
} ;
#pragma pack(pop)

typedef _cs_ds_lookup_info  TCS_DS_LOOKUP_INFO;

#pragma pack(push, 1)
struct _cs_cap_type
{
	Byte mask[16];
} ;
#pragma pack(pop)

typedef _cs_cap_type  TCS_CAP_TYPE;

typedef void *TCS_LOGINFO;

typedef void *TCS_BLKDESC;

typedef void *TCS_BLK_ROW;

typedef void *PCS_LOGINFO;

#pragma pack(push, 4)
struct _cs_iodesc
{
	int iotype;
	int datatype;
	void * *locale;
	int usertype;
	int total_txtlen;
	int offset;
	int log_on_update;
	char name[400];
	int namelen;
	Byte timestamp[8];
	int timestamplen;
	Byte textptr[16];
	int textptrlen;
} ;
#pragma pack(pop)

typedef _cs_iodesc  TCS_IODESC;

#pragma pack(push, 4)
struct _cs_browsedesc
{
	int status;
	int isbrowse;
	char origname[132];
	int orignlen;
	int tablenum;
	char tablename[400];
	int tabnlen;
} ;
#pragma pack(pop)

typedef _cs_browsedesc  TCS_BROWSEDESC;

#pragma pack(push, 4)
struct _cs_servermsg
{
	int msgnumber;
	int state;
	int severity;
	char text[1024];
	int textlen;
	char svrname[132];
	int svrnlen;
	char proc[132];
	int proclen;
	int line;
	int status;
	Byte sqlstate[8];
	int sqlstatelen;
} ;
#pragma pack(pop)

typedef _cs_servermsg  TCS_SERVERMSG;

#pragma pack(push, 4)
struct _cs_clientmsg
{
	int severity;
	int msgnumber;
	char msgstring[1024];
	int msgstringlen;
	int osnumber;
	char osstring[1024];
	int osstringlen;
	int status;
	Byte sqlstate[8];
	int sqlstatelen;
} ;
#pragma pack(pop)

typedef _cs_clientmsg  TCS_CLIENTMSG;

class DELPHICLASS ESDSybError;
class PASCALIMPLEMENTATION ESDSybError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDSybError(int AErrorCode, int ANativeError, const AnsiString Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDSybError(int AErrorCode, int ANativeError, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDSybError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDSybError(int Ident)/* overload */ : Sdcommon::ESDEngineError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDSybError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDSybError(const AnsiString Msg, int AHelpContext) : Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDSybError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDSybError(int Ident, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDSybError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDSybError(void) { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TISybConnInfo
{
	Byte ServerType;
	void * *ConnPtr;
	void * *CmdPtr;
	char *szSrvName;
	char *szDBName;
} ;
#pragma pack(pop)

class DELPHICLASS TISybDatabase;
class PASCALIMPLEMENTATION TISybDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	bool FIsSingleConn;
	Sdcommon::TISqlCommand* FCurSqlCmd;
	bool FIsAnywhere;
	bool FEmptyStrAsNull;
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(void);
	PCS_CONNECTION __fastcall GetConnPtr(void);
	PCS_COMMAND __fastcall GetCmdPtr(void);
	char * __fastcall GetDBNamePtr(void);
	char * __fastcall GetSrvNamePtr(void);
	void __fastcall GetStmtResult(const AnsiString Stmt, int ColNo, Classes::TStrings* List);
	void __fastcall HandleInitCmd(PCS_COMMAND ACmd, AnsiString sCmd);
	void __fastcall HandleExec(PCS_COMMAND ACmd);
	void __fastcall HandleReset(PCS_COMMAND ACmd);
	void __fastcall HandleSetIsolation(PCS_CONNECTION AConn);
	void __fastcall HandleSetDefOpt(PCS_CONNECTION AConn);
	void __fastcall SetDefaultOptions(void);
	void __fastcall SetIsAnywhereProp(void);
	
protected:
	void __fastcall Check(int rcd);
	void __fastcall CheckExt(int rcd, PCS_CONNECTION ConnPtr);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	__property bool IsSingleConn = {read=FIsSingleConn, nodefault};
	
public:
	__fastcall virtual TISybDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TISybDatabase(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual AnsiString __fastcall GetAutoIncSQL();
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString();
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
	void __fastcall ReleaseDBHandle(Sdcommon::TISqlCommand* ASqlCmd, bool IsFetchAll);
	__property Sdcommon::TISqlCommand* CurSqlCmd = {read=FCurSqlCmd};
	__property PCS_CONNECTION ConnPtr = {read=GetConnPtr};
	__property PCS_COMMAND CmdPtr = {read=GetCmdPtr};
	__property char * SrvNamePtr = {read=GetSrvNamePtr};
	__property char * DBNamePtr = {read=GetDBNamePtr};
	__property bool IsAnywhere = {read=FIsAnywhere, nodefault};
	__property bool EmptyStrAsNull = {read=FEmptyStrAsNull, nodefault};
};


class DELPHICLASS TISybCommand;
class PASCALIMPLEMENTATION TISybCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	AnsiString FBindStmt;
	int FRowsAffected;
	void * *FConnPtr;
	void * *FHandle;
	bool FRowResult;
	bool FIsSingleConn;
	bool FEmptyStrAsNull;
	bool FConnected;
	Classes::TStrings* FColInfo;
	bool FNextResults;
	bool FEndResults;
	bool FIsRTrimChar;
	bool FEndOfFetch;
	int FMinBlobFieldNo;
	void __fastcall Check(int rcd);
	void __fastcall Connect(void);
	void __fastcall CreateConnection(void);
	AnsiString __fastcall CnvtDateTimeToSQLVarChar(Db::TFieldType ADataType, System::TDateTime Value);
	_cs_datetime __fastcall CnvtDateTimeToSQLDateTime(System::TDateTime Value);
	Db::TDateTimeRec __fastcall CnvtDBDateTime2DateTimeRec(Db::TFieldType ADataType, char * Buffer, int BufSize);
	AnsiString __fastcall CnvtFloatToSQLVarChar(double Value);
	AnsiString __fastcall CnvtBlobToSQLHexString(AnsiString Value);
	double __fastcall CnvtDBFloatToFloat(const _cs_datafmt &datafmt, void * data);
	void __fastcall HandleInitLangCmd(PCS_COMMAND ACmd, AnsiString sCmd);
	void __fastcall HandleInitRpcCmd(PCS_COMMAND ACmd, AnsiString ARpcName);
	int __fastcall HandleExec(PCS_COMMAND ACmd);
	void __fastcall HandleCurReset(PCS_COMMAND ACmd);
	void __fastcall HandleReset(PCS_COMMAND ACmd);
	void __fastcall HandleSend(PCS_COMMAND ACmd);
	bool __fastcall HandleSpResults(PCS_COMMAND ACmd);
	PCS_COMMAND __fastcall GetCmdPtr(void);
	bool __fastcall GetExecuted(void);
	HIDESBASE TISybDatabase* __fastcall GetSqlDatabase(void);
	void __fastcall InternalExecute(void);
	void __fastcall InternalQBindParams(void);
	void __fastcall InternalQExecute(void);
	void __fastcall InternalSpBindParams(void);
	void __fastcall InternalSpExecute(void);
	void __fastcall InternalSpGetParams(void);
	void __fastcall InternalGetStatus(void);
	void __fastcall ReadNonBindFields(void);
	int __fastcall ReadNonBlobField(Sdcommon::TSDFieldDesc* AFieldDesc, void * SelBuf, int BufLen);
	
protected:
	void __fastcall AcquireDBHandle(void);
	void __fastcall ReleaseDBHandle(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual int __fastcall GetParamsBufferSize(void);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall SetFieldsBuffer(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	
public:
	__fastcall virtual TISybCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TISybCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual void __fastcall Execute(void);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall NextResultSet(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	__property PCS_COMMAND CmdPtr = {read=GetCmdPtr};
	__property bool Executed = {read=GetExecuted, nodefault};
	__property TISybDatabase* SqlDatabase = {read=GetSqlDatabase};
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint CS_BITS_PER_BYTE = 0x8;
static const int CS_SUCCEED = 0x1;
static const int CS_FAIL = 0x0;
static const int CS_MEM_ERROR = 0xffffffff;
static const int CS_PENDING = 0xfffffffe;
static const int CS_QUIET = 0xfffffffd;
static const int CS_BUSY = 0xfffffffc;
static const int CS_INTERRUPT = 0xfffffffb;
static const int CS_BLK_HAS_TEXT = 0xfffffffa;
static const int CS_CONTINUE = 0xfffffff9;
static const int CS_FATAL = 0xfffffff8;
static const int CS_RET_HAFAILOVER = 0xfffffff7;
static const int CS_CONV_ERR = 0xffffff9c;
static const int CS_EXTERNAL_ERR = 0xffffff38;
static const int CS_INTERNAL_ERR = 0xfffffed4;
static const int CS_COMN_ERR = 0xfffffe70;
static const int CS_CANCELED = 0xffffff36;
static const int CS_ROW_FAIL = 0xffffff35;
static const int CS_END_DATA = 0xffffff34;
static const int CS_END_RESULTS = 0xffffff33;
static const int CS_END_ITEM = 0xffffff32;
static const int CS_NOMSG = 0xffffff31;
static const int CS_TIMED_OUT = 0xffffff30;
static const int CS_PASSTHRU_EOM = 0xffffff2e;
static const int CS_PASSTHRU_MORE = 0xffffff2d;
static const int CS_TRYING = 0xffffff2b;
static const int CS_EBADPARAM = 0xffffff2a;
static const int CS_EBADLEN = 0xffffff29;
static const int CS_ENOCNVRT = 0xffffff28;
static const int CS_EOVERFLOW = 0xffffff9b;
static const int CS_EUNDERFLOW = 0xffffff9a;
static const int CS_EPRECISION = 0xffffff99;
static const int CS_ESCALE = 0xffffff98;
static const int CS_ESYNTAX = 0xffffff97;
static const int CS_EFORMAT = 0xffffff96;
static const int CS_EDOMAIN = 0xffffff95;
static const int CS_EDIVZERO = 0xffffff94;
static const int CS_ERESOURCE = 0xffffff93;
static const int CS_ENULLNOIND = 0xffffff92;
static const int CS_ETRUNCNOIND = 0xffffff91;
static const int CS_ENOBIND = 0xffffff90;
static const int CS_TRUNCATED = 0xffffff8f;
static const int CS_ESTYLE = 0xffffff8e;
static const int CS_EBADXLT = 0xffffff8d;
static const int CS_ENOXLT = 0xffffff8c;
static const int CS_USEREP = 0xffffff8b;
static const int CS_SV_INFORM = 0x0;
static const int CS_SV_API_FAIL = 0x1;
static const int CS_SV_RETRY_FAIL = 0x2;
static const int CS_SV_RESOURCE_FAIL = 0x3;
static const int CS_SV_CONFIG_FAIL = 0x4;
static const int CS_SV_COMM_FAIL = 0x5;
static const int CS_SV_INTERNAL_FAIL = 0x6;
static const int CS_SV_FATAL = 0x7;
static const Shortint CS_STAT_DEFAULT = 0x0;
static const Shortint CS_STAT_MULTIBYTE = 0x1;
static const Shortint CS_STAT_SPACELAST = 0x2;
static const Shortint CS_STAT_NONASCIISP = 0x4;
static const int CS_MAX_LOCALE = 0x44;
static const int CS_MAX_NAME = 0x84;
static const int CS_MAX_PASS = 0x1e;
static const int CS_MAX_CHAR = 0x100;
static const int CS_MAX_DS_STRING = 0x200;
static const int CS_MAX_NUMLEN = 0x21;
static const int CS_TRUE = 0x1;
static const int CS_FALSE = 0x0;
static const int CS_NULLTERM = 0xfffffff7;
static const int CS_WILDCARD = 0xffffff9d;
static const int CS_NO_LIMIT = 0xffffd8f1;
static const int CS_UNUSED = 0xfffe7961;
static const int CS_UNEXPIRED = 0xfff0bdc1;
static const int USER_UNICHAR_TYPE = 0x22;
static const int USER_UNIVARCHAR_TYPE = 0x23;
static const int CS_ILLEGAL_TYPE = 0xffffffff;
static const int CS_CHAR_TYPE = 0x0;
static const int CS_BINARY_TYPE = 0x1;
static const int CS_LONGCHAR_TYPE = 0x2;
static const int CS_LONGBINARY_TYPE = 0x3;
static const int CS_TEXT_TYPE = 0x4;
static const int CS_IMAGE_TYPE = 0x5;
static const int CS_TINYINT_TYPE = 0x6;
static const int CS_SMALLINT_TYPE = 0x7;
static const int CS_INT_TYPE = 0x8;
static const int CS_REAL_TYPE = 0x9;
static const int CS_FLOAT_TYPE = 0xa;
static const int CS_BIT_TYPE = 0xb;
static const int CS_DATETIME_TYPE = 0xc;
static const int CS_DATETIME4_TYPE = 0xd;
static const int CS_MONEY_TYPE = 0xe;
static const int CS_MONEY4_TYPE = 0xf;
static const int CS_NUMERIC_TYPE = 0x10;
static const int CS_DECIMAL_TYPE = 0x11;
static const int CS_VARCHAR_TYPE = 0x12;
static const int CS_VARBINARY_TYPE = 0x13;
static const int CS_LONG_TYPE = 0x14;
static const int CS_SENSITIVITY_TYPE = 0x15;
static const int CS_BOUNDARY_TYPE = 0x16;
static const int CS_VOID_TYPE = 0x17;
static const int CS_USHORT_TYPE = 0x18;
static const int CS_UNICHAR_TYPE = 0x19;
static const int CS_BLOB_TYPE = 0x1a;
static const int CS_MIN_SYBTYPE = 0x0;
static const int CS_MAX_SYBTYPE = 0x19;
static const Shortint CS_MAXSYB_TYPE = 0x1a;
static const int CS_USER_TYPE = 0x64;
static const int CS_FMT_UNUSED = 0x0;
static const int CS_FMT_NULLTERM = 0x1;
static const int CS_FMT_PADNULL = 0x2;
static const int CS_FMT_PADBLANK = 0x4;
static const int CS_FMT_JUSTIFY_RT = 0x8;
static const int CS_FMT_STRIPBLANKS = 0x10;
static const int CS_FMT_SAFESTR = 0x20;
static const int CS_HIDDEN = 0x1;
static const int CS_KEY = 0x2;
static const int CS_VERSION_KEY = 0x4;
static const int CS_NODATA = 0x8;
static const int CS_UPDATABLE = 0x10;
static const int CS_CANBENULL = 0x20;
static const int CS_DESCIN = 0x40;
static const int CS_DESCOUT = 0x80;
static const int CS_INPUTVALUE = 0x100;
static const int CS_UPDATECOL = 0x200;
static const int CS_RETURN = 0x400;
static const int CS_RETURN_CANBENULL = 0x420;
static const int CS_TIMESTAMP = 0x2000;
static const int CS_NODEFAULT = 0x4000;
static const int CS_IDENTITY = 0x8000;
static const int CS_EXPRESSION = 0x800;
static const int CS_RENAMED = 0x1000;
static const int CS_SRC_VALUE = 0xfffff5fe;
static const int CS_MIN_PREC = 0x1;
static const int CS_MAX_PREC = 0x4d;
static const int CS_DEF_PREC = 0x12;
static const int CS_MIN_SCALE = 0x0;
static const int CS_MAX_SCALE = 0x4d;
static const int CS_DEF_SCALE = 0x0;
static const int CS_DATES_SHORT = 0x0;
static const int CS_DATES_MDY1 = 0x1;
static const int CS_DATES_YMD1 = 0x2;
static const int CS_DATES_DMY1 = 0x3;
static const int CS_DATES_DMY2 = 0x4;
static const int CS_DATES_DMY3 = 0x5;
static const int CS_DATES_DMY4 = 0x6;
static const int CS_DATES_MDY2 = 0x7;
static const int CS_DATES_HMS = 0x8;
static const int CS_DATES_LONG = 0x9;
static const int CS_DATES_MDY3 = 0xa;
static const int CS_DATES_YMD2 = 0xb;
static const int CS_DATES_YMD3 = 0xc;
static const int CS_DATES_YDM1 = 0xd;
static const int CS_DATES_MYD1 = 0xe;
static const int CS_DATES_DYM1 = 0xf;
static const int CS_DATES_SHORT_ALT = 0x64;
static const int CS_DATES_MDY1_YYYY = 0x65;
static const int CS_DATES_YMD1_YYYY = 0x66;
static const int CS_DATES_DMY1_YYYY = 0x67;
static const int CS_DATES_DMY2_YYYY = 0x68;
static const int CS_DATES_DMY3_YYYY = 0x69;
static const int CS_DATES_DMY4_YYYY = 0x6a;
static const int CS_DATES_MDY2_YYYY = 0x6b;
static const int CS_DATES_HMS_ALT = 0x6c;
static const int CS_DATES_LONG_ALT = 0x6d;
static const int CS_DATES_MDY3_YYYY = 0x6e;
static const int CS_DATES_YMD2_YYYY = 0x6f;
static const int CS_DATES_YMD3_YYYY = 0x70;
static const int CS_LC_COLLATE = 0x1;
static const int CS_LC_CTYPE = 0x2;
static const int CS_LC_MESSAGE = 0x3;
static const int CS_LC_MONETARY = 0x4;
static const int CS_LC_NUMERIC = 0x5;
static const int CS_LC_TIME = 0x6;
static const int CS_LC_ALL = 0x7;
static const int CS_SYB_LANG = 0x8;
static const int CS_SYB_CHARSET = 0x9;
static const int CS_SYB_SORTORDER = 0xa;
static const int CS_SYB_COLLATE = 0xa;
static const int CS_SYB_LANG_CHARSET = 0xb;
static const int CS_SYB_TIME = 0xc;
static const int CS_SYB_MONETARY = 0xd;
static const int CS_SYB_NUMERIC = 0xe;
static const int CS_CONNECTNAME = 0x1;
static const int CS_CURSORNAME = 0x2;
static const int CS_STATEMENTNAME = 0x3;
static const int CS_CURRENT_CONNECTION = 0x4;
static const int CS_MIN_USERDATA = 0x64;
static const int CS_DS_CLASSOID = 0x1;
static const int CS_DS_DIST_NAME = 0x2;
static const int CS_DS_NUMATTR = 0x3;
static const int CS_DS_ATTRIBUTE = 0x4;
static const int CS_DS_ATTRVALS = 0x5;
#define CS_OID_SYBASE "1.3.6.1.4.1.897"
#define CS_OID_DIRECTORY "1.3.6.1.4.1.897.4"
#define CS_OID_OBJCLASS "1.3.6.1.4.1.897.4.1"
#define CS_OID_ATTRTYPE "1.3.6.1.4.1.897.4.2"
#define CS_OID_ATTRSYNTAX "1.3.6.1.4.1.897.4.3"
#define CS_OID_OBJSERVER "1.3.6.1.4.1.897.4.1.1"
#define CS_OID_ATTRVERSION "1.3.6.1.4.1.897.4.2.1"
#define CS_OID_ATTRSERVNAME "1.3.6.1.4.1.897.4.2.2"
#define CS_OID_ATTRSERVICE "1.3.6.1.4.1.897.4.2.3"
#define CS_OID_ATTRSTATUS "1.3.6.1.4.1.897.4.2.4"
#define CS_OID_ATTRADDRESS "1.3.6.1.4.1.897.4.2.5"
#define CS_OID_ATTRSECMECH "1.3.6.1.4.1.897.4.2.6"
#define CS_OID_ATTRRETRYCOUNT "1.3.6.1.4.1.897.4.2.7"
#define CS_OID_ATTRLOOPDELAY "1.3.6.1.4.1.897.4.2.8"
#define CS_OID_ATTRJCPROTOCOL "1.3.6.1.4.1.897.4.2.9"
#define CS_OID_ATTRJCPROPERTY "1.3.6.1.4.1.897.4.2.10"
#define CS_OID_ATTRDATABASENAME "1.3.6.1.4.1.897.4.2.11"
#define CS_OID_ATTRHAFAILOVER "1.3.6.1.4.1.897.4.2.15"
#define CS_OID_ATTRRMNAME "1.3.6.1.4.1.897.4.2.16"
#define CS_OID_ATTRRMTYPE "1.3.6.1.4.1.897.4.2.17"
#define CS_OID_ATTRJDBCDSI "1.3.6.1.4.1.897.4.2.18"
#define CS_OID_ATTRSERVERTYPE "1.3.6.1.4.1.897.4.2.19"
static const int CS_STATUS_ACTIVE = 0x1;
static const int CS_STATUS_STOPPED = 0x2;
static const int CS_STATUS_FAILED = 0x3;
static const int CS_STATUS_UNKNOWN = 0x4;
static const int CS_ACCESS_CLIENT = 0x1;
static const int CS_ACCESS_ADMIN = 0x2;
static const int CS_ACCESS_MGMTAGENT = 0x3;
static const int CS_ACCESS_CLIENT_QUERY = 0x1;
static const int CS_ACCESS_CLIENT_MASTER = 0x2;
static const int CS_ACCESS_ADMIN_QUERY = 0x3;
static const int CS_ACCESS_ADMIN_MASTER = 0x4;
static const int CS_ACCESS_MGMTAGENT_QUERY = 0x5;
static const int CS_ACCESS_MGMTAGENT_MASTER = 0x6;
static const int CS_ATTR_SYNTAX_NOOP = 0x0;
static const int CS_ATTR_SYNTAX_STRING = 0x1;
static const int CS_ATTR_SYNTAX_INTEGER = 0x2;
static const int CS_ATTR_SYNTAX_BOOLEAN = 0x3;
static const int CS_ATTR_SYNTAX_ENUMERATION = 0x4;
static const int CS_ATTR_SYNTAX_TRANADDR = 0x5;
static const int CS_ATTR_SYNTAX_OID = 0x6;
static const Shortint CS_SIGNAL_IGNORE = 0xffffffff;
static const Shortint CS_SIGNAL_DEFAULT = 0xfffffffe;
static const Shortint CS_ASYNC_RESTORE = 0xfffffffd;
static const Shortint CS_SIGNAL_BLOCK = 0xfffffffc;
static const Shortint CS_SIGNAL_UNBLOCK = 0xfffffffb;
static const int CS_OBJ_NAME = 0x190;
static const int CS_MAX_MSG = 0x400;
static const int CS_TS_SIZE = 0x8;
static const int CS_TP_SIZE = 0x10;
static const int CS_SQLSTATE_SIZE = 0x8;
static const int CS_VERSION_100 = 0x70;
static const int CS_VERSION_110 = 0x44c;
static const int CS_VERSION_125 = 0x30d4;
static const int CS_GET = 0x21;
static const int CS_SET = 0x22;
static const int CS_CLEAR = 0x23;
static const int CS_INIT = 0x24;
static const int CS_STATUS = 0x25;
static const int CS_MSGLIMIT = 0x26;
static const int CS_SEND = 0x27;
static const int CS_SUPPORTED = 0x28;
static const int CS_CACHE = 0x29;
static const short CS_GOODDATA = 0x0;
static const short CS_NULLDATA = 0xffffffff;
static const int CS_SET_FLAG = 0x6a4;
static const int CS_CLEAR_FLAG = 0x6a5;
static const int CS_SET_DBG_FILE = 0x6a6;
static const int CS_SET_PROTOCOL_FILE = 0x6a7;
static const int CS_DBG_ALL = 0x1;
static const int CS_DBG_ASYNC = 0x2;
static const int CS_DBG_ERROR = 0x4;
static const int CS_DBG_MEM = 0x8;
static const int CS_DBG_PROTOCOL = 0x10;
static const int CS_DBG_PROTOCOL_STATES = 0x20;
static const int CS_DBG_API_STATES = 0x40;
static const int CS_DBG_DIAG = 0x80;
static const int CS_DBG_NETWORK = 0x100;
static const int CS_DBG_API_LOGCALL = 0x200;
static const int CS_CANCEL_CURRENT = 0x1770;
static const int CS_CANCEL_ALL = 0x1771;
static const int CS_CANCEL_ATTN = 0x1772;
static const int CS_CANCEL_ABORT_NOTIF = 0x1773;
static const int CS_FIRST = 0xbb8;
static const int CS_NEXT = 0xbb9;
static const int CS_PREV = 0xbba;
static const int CS_LAST = 0xbbb;
static const int CS_ABSOLUTE = 0xbbc;
static const int CS_RELATIVE = 0xbbd;
static const int CS_ADD = 0x1;
static const int CS_SUB = 0x2;
static const int CS_MULT = 0x3;
static const int CS_DIV = 0x4;
static const int CS_ZERO = 0x5;
static const int CS_MONTH = 0x1cac;
static const int CS_SHORTMONTH = 0x1cad;
static const int CS_DAYNAME = 0x1cae;
static const int CS_DATEORDER = 0x1caf;
static const int CS_12HOUR = 0x1cb0;
static const int CS_DT_CONVFMT = 0x1cb1;
static const int CS_COMPARE = 0x1d10;
static const int CS_SORT = 0x1d11;
static const int CS_COMPLETION_CB = 0x1;
static const int CS_SERVERMSG_CB = 0x2;
static const int CS_CLIENTMSG_CB = 0x3;
static const int CS_NOTIF_CB = 0x4;
static const int CS_ENCRYPT_CB = 0x5;
static const int CS_CHALLENGE_CB = 0x6;
static const int CS_DS_LOOKUP_CB = 0x7;
static const int CS_SECSESSION_CB = 0x8;
static const int CS_SSLVALIDATE_CB = 0x9;
static const int CS_SIGNAL_CB = 0x64;
static const int CS_FORCE_EXIT = 0x12c;
static const int CS_FORCE_CLOSE = 0x12d;
static const int CS_CLIENTMSG_TYPE = 0x125c;
static const int CS_SERVERMSG_TYPE = 0x125d;
static const int CS_ALLMSG_TYPE = 0x125e;
static const int SQLCA_TYPE = 0x125f;
static const int SQLCODE_TYPE = 0x1260;
static const int SQLSTATE_TYPE = 0x1261;
static const int CS_COMP_OP = 0x14e6;
static const int CS_COMP_ID = 0x14e7;
static const int CS_COMP_COLID = 0x14e8;
static const int CS_COMP_BYLIST = 0x14e9;
static const int CS_BYLIST_LEN = 0x14ea;
static const int CS_OP_SUM = 0x14fa;
static const int CS_OP_AVG = 0x14fb;
static const int CS_OP_COUNT = 0x14fc;
static const int CS_OP_MIN = 0x14fd;
static const int CS_OP_MAX = 0x14fe;
static const int CS_ISBROWSE = 0x2328;
static const int CS_TABNUM = 0x2329;
static const int CS_TABNAME = 0x232a;
static const int CS_ROW_RESULT = 0xfc8;
static const int CS_CURSOR_RESULT = 0xfc9;
static const int CS_PARAM_RESULT = 0xfca;
static const int CS_STATUS_RESULT = 0xfcb;
static const int CS_MSG_RESULT = 0xfcc;
static const int CS_COMPUTE_RESULT = 0xfcd;
static const int CS_CMD_DONE = 0xfce;
static const int CS_CMD_SUCCEED = 0xfcf;
static const int CS_CMD_FAIL = 0xfd0;
static const int CS_ROWFMT_RESULT = 0xfd1;
static const int CS_COMPUTEFMT_RESULT = 0xfd2;
static const int CS_DESCRIBE_RESULT = 0xfd3;
static const int CS_ROW_COUNT = 0x320;
static const int CS_CMD_NUMBER = 0x321;
static const int CS_NUM_COMPUTES = 0x322;
static const int CS_NUMDATA = 0x323;
static const int CS_ORDERBY_COLS = 0x324;
static const int CS_NUMORDERCOLS = 0x325;
static const int CS_MSGTYPE = 0x326;
static const int CS_BROWSE_INFO = 0x327;
static const int CS_TRANS_STATE = 0x328;
static const int CS_TRAN_UNDEFINED = 0x0;
static const int CS_TRAN_IN_PROGRESS = 0x1;
static const int CS_TRAN_COMPLETED = 0x2;
static const int CS_TRAN_FAIL = 0x3;
static const int CS_TRAN_STMT_FAIL = 0x4;
static const int CS_NO_COUNT = 0xffffffff;
static const int CS_LANG_CMD = 0x94;
static const int CS_RPC_CMD = 0x95;
static const int CS_MSG_CMD = 0x96;
static const int CS_SEND_DATA_CMD = 0x97;
static const int CS_PACKAGE_CMD = 0x98;
static const int CS_SEND_BULK_CMD = 0x99;
static const int CS_CURSOR_DECLARE = 0x2bc;
static const int CS_CURSOR_OPEN = 0x2bd;
static const int CS_CURSOR_ROWS = 0x2bf;
static const int CS_CURSOR_UPDATE = 0x2c0;
static const int CS_CURSOR_DELETE = 0x2c1;
static const int CS_CURSOR_CLOSE = 0x2c2;
static const int CS_CURSOR_DEALLOC = 0x2c3;
static const int CS_CURSOR_OPTION = 0x2d5;
static const int CS_CURSOR_FETCH = 0x2c4;
static const int CS_CURSOR_INFO = 0x2c5;
static const int CS_ALLOC = 0x2c6;
static const int CS_DEALLOC = 0x2c7;
static const int CS_USE_DESC = 0x2c8;
static const int CS_GETCNT = 0x2c9;
static const int CS_SETCNT = 0x2ca;
static const int CS_GETATTR = 0x2cb;
static const int CS_SETATTR = 0x2cc;
static const int CS_PREPARE = 0x2cd;
static const int CS_EXECUTE = 0x2ce;
static const int CS_EXEC_IMMEDIATE = 0x2cf;
static const int CS_DESCRIBE_INPUT = 0x2d0;
static const int CS_DESCRIBE_OUTPUT = 0x2d1;
static const int CS_DYN_CURSOR_DECLARE = 0x2d2;
static const int CS_SQLDA_SYBASE = 0x2d9;
static const int CS_GET_IN = 0x2da;
static const int CS_GET_OUT = 0x2db;
static const int CS_SQLDA_BIND = 0x2dc;
static const int CS_SQLDA_PARAM = 0x2dd;
static const int CS_PROCNAME = 0x2d3;
static const int CS_ACK = 0x2d4;
static const int CS_OBJ_CLASSOID = 0x2d5;
static const int CS_OBJ_DNAME = 0x2d6;
static const int CS_OBJ_NUMATTR = 0x2d7;
static const int CS_OBJ_ATRRIBUTE = 0x2d8;
static const int CS_RECOMPILE = 0xbc;
static const int CS_NO_RECOMPILE = 0xbd;
static const int CS_BULK_INIT = 0xbe;
static const int CS_BULK_CONT = 0xbf;
static const int CS_BULK_DATA = 0xc0;
static const int CS_COLUMN_DATA = 0xc1;
static const int CS_FOR_UPDATE = 0x1;
static const int CS_READ_ONLY = 0x2;
static const int CS_DYNAMIC = 0x4;
static const int CS_RESTORE_OPEN = 0x8;
static const int CS_MORE = 0x10;
static const int CS_END = 0x20;
static const int CS_IMPLICIT_CURSOR = 0x40;
static const int CS_MSG_GETLABELS = 0x6;
static const int CS_MSG_LABELS = 0x7;
static const int CS_MSG_TABLENAME = 0x8;
static const int CS_PARSE_TREE = 0x2206;
static const int CS_USER_MSGID = 0x8000;
static const int CS_USER_MAX_MSGID = 0xffff;
static const Shortint CS_NOTIFY_ONCE = 0x2;
static const Shortint CS_NOTIFY_ALWAYS = 0x4;
static const Shortint CS_NOTIFY_WAIT = 0x20;
static const Shortint CS_NOTIFY_NOWAIT = 0x40;
static const int CS_USERNAME = 0x238c;
static const int CS_PASSWORD = 0x238d;
static const int CS_APPNAME = 0x238e;
static const int CS_HOSTNAME = 0x238f;
static const int CS_LOGIN_STATUS = 0x2390;
static const int CS_TDS_VERSION = 0x2391;
static const int CS_CHARSETCNV = 0x2392;
static const int CS_PACKETSIZE = 0x2393;
static const int CS_USERDATA = 0x2394;
static const int CS_COMMBLOCK = 0x2395;
static const int CS_NETIO = 0x2396;
static const int CS_NOINTERRUPT = 0x2397;
static const int CS_TEXTLIMIT = 0x2398;
static const int CS_HIDDEN_KEYS = 0x2399;
static const int CS_VERSION = 0x239a;
static const int CS_IFILE = 0x239b;
static const int CS_LOGIN_TIMEOUT = 0x239c;
static const int CS_TIMEOUT = 0x239d;
static const int CS_MAX_CONNECT = 0x239e;
static const int CS_MESSAGE_CB = 0x239f;
static const int CS_EXPOSE_FMTS = 0x23a0;
static const int CS_EXTRA_INF = 0x23a1;
static const int CS_TRANSACTION_NAME = 0x23a2;
static const int CS_ANSI_BINDS = 0x23a3;
static const int CS_BULK_LOGIN = 0x23a4;
static const int CS_LOC_PROP = 0x23a5;
static const int CS_CUR_STATUS = 0x23a6;
static const int CS_CUR_ID = 0x23a7;
static const int CS_CUR_NAME = 0x23a8;
static const int CS_CUR_ROWCOUNT = 0x23a9;
static const int CS_PARENT_HANDLE = 0x23aa;
static const int CS_EED_CMD = 0x23ab;
static const int CS_DIAG_TIMEOUT = 0x23ac;
static const int CS_DISABLE_POLL = 0x23ad;
static const int CS_NOTIF_CMD = 0x23ae;
static const int CS_SEC_ENCRYPTION = 0x23af;
static const int CS_SEC_CHALLENGE = 0x23b0;
static const int CS_SEC_NEGOTIATE = 0x23b1;
static const int CS_MEM_POOL = 0x23b2;
static const int CS_USER_ALLOC = 0x23b3;
static const int CS_USER_FREE = 0x23b4;
static const int CS_ENDPOINT = 0x23b5;
static const int CS_NO_TRUNCATE = 0x23b6;
static const int CS_CON_STATUS = 0x23b7;
static const int CS_VER_STRING = 0x23b8;
static const int CS_ASYNC_NOTIFS = 0x23b9;
static const int CS_SERVERNAME = 0x23ba;
static const int CS_THREAD_RESOURCE = 0x23bb;
static const int CS_NOAPI_CHK = 0x23bc;
static const int CS_SEC_APPDEFINED = 0x23bd;
static const int CS_NOCHARSETCNV_REQD = 0x23be;
static const int CS_STICKY_BINDS = 0x23bf;
static const int CS_HAVE_CMD = 0x23c0;
static const int CS_HAVE_BINDS = 0x23c1;
static const int CS_HAVE_CUROPEN = 0x23c2;
static const int CS_EXTERNAL_CONFIG = 0x23c3;
static const int CS_CONFIG_FILE = 0x23c4;
static const int CS_CONFIG_BY_SERVERNAME = 0x23c5;
static const int CS_DS_CHAIN = 0x23c6;
static const int CS_DS_EXPANDALIAS = 0x23c7;
static const int CS_DS_COPY = 0x23c8;
static const int CS_DS_LOCALSCOPE = 0x23c9;
static const int CS_DS_PREFERCHAIN = 0x23ca;
static const int CS_DS_SCOPE = 0x23cb;
static const int CS_DS_SIZELIMIT = 0x23cc;
static const int CS_DS_TIMELIMIT = 0x23cd;
static const int CS_DS_PRINCIPAL = 0x23ce;
static const int CS_DS_REFERRAL = 0x23cf;
static const int CS_DS_SEARCH = 0x23d0;
static const int CS_DS_DITBASE = 0x23d1;
static const int CS_DS_FAILOVER = 0x23d2;
static const int CS_NET_TRANADDR = 0x23d3;
static const int CS_DS_PROVIDER = 0x23d4;
static const int CS_RETRY_COUNT = 0x23d5;
static const int CS_LOOP_DELAY = 0x23d6;
static const int CS_SEC_NETWORKAUTH = 0x23d7;
static const int CS_SEC_DELEGATION = 0x23d8;
static const int CS_SEC_MUTUALAUTH = 0x23d9;
static const int CS_SEC_INTEGRITY = 0x23da;
static const int CS_SEC_CONFIDENTIALITY = 0x23db;
static const int CS_SEC_CREDTIMEOUT = 0x23dc;
static const int CS_SEC_SESSTIMEOUT = 0x23dd;
static const int CS_SEC_DETECTREPLAY = 0x23de;
static const int CS_SEC_DETECTSEQ = 0x23df;
static const int CS_SEC_DATAORIGIN = 0x23e0;
static const int CS_SEC_MECHANISM = 0x23e1;
static const int CS_SEC_CREDENTIALS = 0x23e2;
static const int CS_SEC_CHANBIND = 0x23e3;
static const int CS_SEC_SERVERPRINCIPAL = 0x23e4;
static const int CS_SEC_KEYTAB = 0x23e5;
static const int CS_ABORTCHK_INTERVAL = 0x23e6;
static const int CS_LOGIN_TYPE = 0x23e7;
static const int CS_CON_KEEPALIVE = 0x23e8;
static const int CS_CON_TCP_NODELAY = 0x23e9;
static const int CS_LOGIN_REMOTE_SERVER = 0x23ea;
static const int CS_LOGIN_REMOTE_PASSWD = 0x23eb;
static const int CS_BEHAVIOR = 0x23ed;
static const int CS_HAFAILOVER = 0x23ec;
static const int CS_DS_PASSWORD = 0x23ee;
static const int CS_PROP_SSL_PROTOVERSION = 0x23f0;
static const int CS_PROP_SSL_CIPHER = 0x23f1;
static const int CS_PROP_SSL_LOCALID = 0x23f2;
static const int CS_PROP_SSL_CA = 0x23f3;
static const int CS_PROP_TLS_KEYREGEN = 0x23f5;
static const int CS_SCOPE_COUNTRY = 0x1;
static const int CS_SCOPE_DMD = 0x2;
static const int CS_SCOPE_WORLD = 0x3;
static const int CS_SEARCH_OBJECT = 0x1;
static const int CS_SEARCH_ONE_LEVEL = 0x2;
static const int CS_SEARCH_SUBTREE = 0x3;
static const int CS_SYNC_IO = 0x1faf;
static const int CS_ASYNC_IO = 0x1fb0;
static const int CS_DEFER_IO = 0x1fb1;
static const int CS_CONSTAT_CONNECTED = 0x1;
static const int CS_CONSTAT_DEAD = 0x2;
static const int CS_CURSTAT_NONE = 0x0;
static const int CS_CURSTAT_DECLARED = 0x1;
static const int CS_CURSTAT_OPEN = 0x2;
static const int CS_CURSTAT_CLOSED = 0x4;
static const int CS_CURSTAT_RDONLY = 0x8;
static const int CS_CURSTAT_UPDATABLE = 0x10;
static const int CS_CURSTAT_ROWCOUNT = 0x20;
static const int CS_CURSTAT_DEALLOC = 0x40;
static const int CS_IMPCURSTAT_NONE = 0x0;
static const int CS_IMPCURSTAT_READROWS = 0x1;
static const int CS_IMPCURSTAT_CLOSED = 0x2;
static const int CS_IMPCURSTAT_SENDSUCCESS = 0x4;
static const int CS_IMPCURSTAT_SENDDONE = 0x8;
static const int CS_TDS_40 = 0x1cc0;
static const int CS_TDS_42 = 0x1cc1;
static const int CS_TDS_46 = 0x1cc2;
static const int CS_TDS_495 = 0x1cc3;
static const int CS_TDS_50 = 0x1cc4;
static const int CS_BEHAVIOR_100 = 0x1cca;
static const int CS_BEHAVIOR_110 = 0x1ccb;
static const int CS_BEHAVIOR_120 = 0x1ccc;
static const int CS_BEHAVIOR_125 = 0x1ccd;
static const int CS_SSLVER_20 = 0x1;
static const int CS_SSLVER_30 = 0x2;
static const int CS_SSLVER_TLS1 = 0x3;
static const int CS_SSLVER_20HAND = 0x80000000;
static const int CS_OPT_DATEFIRST = 0x1389;
static const int CS_OPT_TEXTSIZE = 0x138a;
static const int CS_OPT_STATS_TIME = 0x138b;
static const int CS_OPT_STATS_IO = 0x138c;
static const int CS_OPT_ROWCOUNT = 0x138d;
static const int CS_OPT_NATLANG = 0x138e;
static const int CS_OPT_DATEFORMAT = 0x138f;
static const int CS_OPT_ISOLATION = 0x1390;
static const int CS_OPT_AUTHON = 0x1391;
static const int CS_OPT_CHARSET = 0x1392;
static const int CS_OPT_SHOWPLAN = 0x1395;
static const int CS_OPT_NOEXEC = 0x1396;
static const int CS_OPT_ARITHIGNORE = 0x1397;
static const int CS_OPT_TRUNCIGNORE = 0x1398;
static const int CS_OPT_ARITHABORT = 0x1399;
static const int CS_OPT_PARSEONLY = 0x139a;
static const int CS_OPT_GETDATA = 0x139c;
static const int CS_OPT_NOCOUNT = 0x139d;
static const int CS_OPT_FORCEPLAN = 0x139f;
static const int CS_OPT_FORMATONLY = 0x13a0;
static const int CS_OPT_CHAINXACTS = 0x13a1;
static const int CS_OPT_CURCLOSEONXACT = 0x13a2;
static const int CS_OPT_FIPSFLAG = 0x13a3;
static const int CS_OPT_RESTREES = 0x13a4;
static const int CS_OPT_IDENTITYON = 0x13a5;
static const int CS_OPT_CURREAD = 0x13a6;
static const int CS_OPT_CURWRITE = 0x13a7;
static const int CS_OPT_IDENTITYOFF = 0x13a8;
static const int CS_OPT_AUTHOFF = 0x13a9;
static const int CS_OPT_ANSINULL = 0x13aa;
static const int CS_OPT_QUOTED_IDENT = 0x13ab;
static const int CS_OPT_ANSIPERM = 0x13ac;
static const int CS_OPT_STR_RTRUNC = 0x13ad;
static const int CS_OPT_SORTMERGE = 0x13ae;
static const int CS_MIN_OPTION = 0x1389;
static const int CS_MAX_OPTION = 0x13ae;
static const int CS_OPT_MONDAY = 0x1;
static const int CS_OPT_TUESDAY = 0x2;
static const int CS_OPT_WEDNESDAY = 0x3;
static const int CS_OPT_THURSDAY = 0x4;
static const int CS_OPT_FRIDAY = 0x5;
static const int CS_OPT_SATURDAY = 0x6;
static const int CS_OPT_SUNDAY = 0x7;
static const int CS_OPT_FMTMDY = 0x1;
static const int CS_OPT_FMTDMY = 0x2;
static const int CS_OPT_FMTYMD = 0x3;
static const int CS_OPT_FMTYDM = 0x4;
static const int CS_OPT_FMTMYD = 0x5;
static const int CS_OPT_FMTDYM = 0x6;
static const int CS_OPT_LEVEL0 = 0x0;
static const int CS_OPT_LEVEL1 = 0x1;
static const int CS_OPT_LEVEL3 = 0x3;
static const int CS_CAP_REQUEST = 0x1;
static const int CS_CAP_RESPONSE = 0x2;
static const int CS_ALL_CAPS = 0xa8c;
static const int CS_REQ_LANG = 0x1;
static const int CS_REQ_RPC = 0x2;
static const int CS_REQ_NOTIF = 0x3;
static const int CS_REQ_MSTMT = 0x4;
static const int CS_REQ_BCP = 0x5;
static const int CS_REQ_CURSOR = 0x6;
static const int CS_REQ_DYN = 0x7;
static const int CS_REQ_MSG = 0x8;
static const int CS_REQ_PARAM = 0x9;
static const int CS_DATA_INT1 = 0xa;
static const int CS_DATA_INT2 = 0xb;
static const int CS_DATA_INT4 = 0xc;
static const int CS_DATA_BIT = 0xd;
static const int CS_DATA_CHAR = 0xe;
static const int CS_DATA_VCHAR = 0xf;
static const int CS_DATA_BIN = 0x10;
static const int CS_DATA_VBIN = 0x11;
static const int CS_DATA_MNY8 = 0x12;
static const int CS_DATA_MNY4 = 0x13;
static const int CS_DATA_DATE8 = 0x14;
static const int CS_DATA_DATE4 = 0x15;
static const int CS_DATA_FLT4 = 0x16;
static const int CS_DATA_FLT8 = 0x17;
static const int CS_DATA_NUM = 0x18;
static const int CS_DATA_TEXT = 0x19;
static const int CS_DATA_IMAGE = 0x1a;
static const int CS_DATA_DEC = 0x1b;
static const int CS_DATA_LCHAR = 0x1c;
static const int CS_DATA_LBIN = 0x1d;
static const int CS_DATA_INTN = 0x1e;
static const int CS_DATA_DATETIMEN = 0x1f;
static const int CS_DATA_MONEYN = 0x20;
static const int CS_CSR_PREV = 0x21;
static const int CS_CSR_FIRST = 0x22;
static const int CS_CSR_LAST = 0x23;
static const int CS_CSR_ABS = 0x24;
static const int CS_CSR_REL = 0x25;
static const int CS_CSR_MULTI = 0x26;
static const int CS_CON_OOB = 0x27;
static const int CS_CON_INBAND = 0x28;
static const int CS_CON_LOGICAL = 0x29;
static const int CS_PROTO_TEXT = 0x2a;
static const int CS_PROTO_BULK = 0x2b;
static const int CS_REQ_URGNOTIF = 0x2c;
static const int CS_DATA_SENSITIVITY = 0x2d;
static const int CS_DATA_BOUNDARY = 0x2e;
static const int CS_PROTO_DYNAMIC = 0x2f;
static const int CS_PROTO_DYNPROC = 0x30;
static const int CS_DATA_FLTN = 0x31;
static const int CS_DATA_BITN = 0x32;
static const int CS_OPTION_GET = 0x33;
static const int CS_DATA_INT8 = 0x34;
static const int CS_DATA_VOID = 0x35;
static const int CS_DOL_BULK = 0x36;
static const int CS_OBJECT_JAVA1 = 0x37;
static const int CS_OBJECT_CHAR = 0x38;
static const int CS_DATA_COLUMNSTATUS = 0x39;
static const int CS_OBJECT_BINARY = 0x3a;
static const int CS_REQ_RESERVED1 = 0x3b;
static const int CS_WIDETABLES = 0x3c;
static const int CS_REQ_RESERVED2 = 0x3d;
static const int CS_DATA_UINT2 = 0x3e;
static const int CS_DATA_UINT4 = 0x3f;
static const int CS_DATA_UINT8 = 0x40;
static const int CS_DATA_UINTN = 0x41;
static const int CS_CUR_IMPLICIT = 0x42;
static const int CS_DATA_UCHAR = 0x43;
static const int CS_MIN_REQ_CAP = 0x1;
static const int CS_MAX_REQ_CAP = 0x43;
static const int CS_RES_NOMSG = 0x1;
static const int CS_RES_NOEED = 0x2;
static const int CS_RES_NOPARAM = 0x3;
static const int CS_DATA_NOINT1 = 0x4;
static const int CS_DATA_NOINT2 = 0x5;
static const int CS_DATA_NOINT4 = 0x6;
static const int CS_DATA_NOBIT = 0x7;
static const int CS_DATA_NOCHAR = 0x8;
static const int CS_DATA_NOVCHAR = 0x9;
static const int CS_DATA_NOBIN = 0xa;
static const int CS_DATA_NOVBIN = 0xb;
static const int CS_DATA_NOMNY8 = 0xc;
static const int CS_DATA_NOMNY4 = 0xd;
static const int CS_DATA_NODATE8 = 0xe;
static const int CS_DATA_NODATE4 = 0xf;
static const int CS_DATA_NOFLT4 = 0x10;
static const int CS_DATA_NOFLT8 = 0x11;
static const int CS_DATA_NONUM = 0x12;
static const int CS_DATA_NOTEXT = 0x13;
static const int CS_DATA_NOIMAGE = 0x14;
static const int CS_DATA_NODEC = 0x15;
static const int CS_DATA_NOLCHAR = 0x16;
static const int CS_DATA_NOLBIN = 0x17;
static const int CS_DATA_NOINTN = 0x18;
static const int CS_DATA_NODATETIMEN = 0x19;
static const int CS_DATA_NOMONEYN = 0x1a;
static const int CS_CON_NOOOB = 0x1b;
static const int CS_CON_NOINBAND = 0x1c;
static const int CS_PROTO_NOTEXT = 0x1d;
static const int CS_PROTO_NOBULK = 0x1e;
static const int CS_DATA_NOSENSITIVITY = 0x1f;
static const int CS_DATA_NOBOUNDARY = 0x20;
static const int CS_RES_NOTDSDEBUG = 0x21;
static const int CS_RES_NOSTRIPBLANKS = 0x22;
static const int CS_DATA_NOINT8 = 0x23;
static const int CS_OBJECT_NOJAVA1 = 0x24;
static const int CS_OBJECT_NOCHAR = 0x25;
static const int CS_DATA_NOZEROLEN = 0x26;
static const int CS_OBJECT_NOBINARY = 0x27;
static const int CS_RES_RESERVED = 0x28;
static const int CS_DATA_NOUINT2 = 0x29;
static const int CS_DATA_NOUINT4 = 0x2a;
static const int CS_DATA_NOUINT8 = 0x2b;
static const int CS_DATA_NOUINTN = 0x2c;
static const int CS_NOWIDETABLES = 0x2d;
static const int CS_DATA_NOUCHAR = 0x2e;
static const int CS_MIN_RES_CAP = 0x1;
static const int CS_MAX_RES_CAP = 0x2e;
static const int CS_MIN_CAPVALUE = 0x1;
static const int CS_MAX_CAPVALUE = 0x2e;
static const Shortint CS_CAP_ARRAYLEN = 0x10;
static const Byte CS_MAX_OIDLEN = 0xff;
static const int CS_IODATA = 0x640;
static const int CS_HASEED = 0x1;
static const int CS_FIRST_CHUNK = 0x2;
static const int CS_LAST_CHUNK = 0x4;
extern PACKAGE int __stdcall (*cs_calc)(PCS_CONTEXT context, int op, int datatype, PCS_VOID var1, PCS_VOID var2, PCS_VOID dest);
extern PACKAGE int __stdcall (*cs_cmp)(PCS_CONTEXT context, int datatype, PCS_VOID var1, PCS_VOID var2, int &result);
extern PACKAGE int __stdcall (*cs_convert)(PCS_CONTEXT context, _cs_datafmt &srcfmt, PCS_VOID srcdata, _cs_datafmt &destfmt, PCS_VOID destdata, int &outlen);
extern PACKAGE int __stdcall (*cs_will_convert)(PCS_CONTEXT context, int srctype, int desttype, int &result);
extern PACKAGE int __stdcall (*cs_set_convert)(PCS_CONTEXT context, int action, int srctype, int desttype, TCS_CONV_FUNC buffer);
extern PACKAGE int __stdcall (*cs_setnull)(PCS_CONTEXT context, _cs_datafmt &datafmt, PCS_VOID buf, int buflen);
extern PACKAGE int __stdcall (*cs_config)(PCS_CONTEXT context, int action, int prop, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*cs_ctx_alloc)(int version, PCS_CONTEXT &outptr);
extern PACKAGE int __stdcall (*cs_ctx_drop)(PCS_CONTEXT context);
extern PACKAGE int __stdcall (*cs_ctx_global)(int version, PCS_CONTEXT &outptr);
extern PACKAGE int __stdcall (*cs_objects)(PCS_CONTEXT context, int action, _cs_objname &objname, _cs_objdata &objdata);
extern PACKAGE int __stdcall (*cs_diag)(PCS_CONTEXT context, int operation, int typ, int idx, PCS_VOID buffer);
extern PACKAGE int __stdcall (*cs_dt_crack)(PCS_CONTEXT context, int datetype, PCS_VOID dateval, _cs_daterec &daterec);
extern PACKAGE int __stdcall (*cs_dt_info)(PCS_CONTEXT context, int action, PCS_LOCALE locale, int typ, int item, PCS_VOID buffer, int buflen, int &outlen);
extern PACKAGE int __stdcall (*cs_locale)(PCS_CONTEXT context, int action, PCS_LOCALE locale, int typ, char * buffer, int buflen, int &outlen);
extern PACKAGE int __stdcall (*cs_loc_alloc)(PCS_CONTEXT context, PCS_LOCALE &loc_pointer);
extern PACKAGE int __stdcall (*cs_loc_drop)(PCS_CONTEXT context, PCS_LOCALE &loc_pointer);
extern PACKAGE int __stdcall (*cs_strcmp)(PCS_CONTEXT context, PCS_LOCALE locale, int typ, char * str1, int len1, char * str2, int len2, int &result);
extern PACKAGE int __stdcall (*cs_time)(PCS_CONTEXT context, PCS_LOCALE locale, PCS_VOID buf, int buflen, int &outlen, _cs_daterec &drec);
extern PACKAGE int __stdcall (*cs_manage_convert)(PCS_CONTEXT context, int action, int srctype, char * srcname, int srcnamelen, int desttype, char * destname, int destnamelen, int &maxmultiplier, TCS_CONV_FUNC func);
extern PACKAGE int __stdcall (*cs_conv_mult)(PCS_CONTEXT context, PCS_LOCALE srcloc, PCS_LOCALE destloc, int &multiplier);
static const int CT_NOTIFICATION = 0x3e8;
static const int CT_USER_FUNC = 0x2710;
extern PACKAGE int __stdcall (*ct_debug)(PCS_CONTEXT context, PCS_CONNECTION connection, int operation, int flag, char * filename, int fnamelen);
extern PACKAGE int __stdcall (*ct_bind)(PCS_COMMAND cmd, int item, _cs_datafmt &datafmt, PCS_VOID buf, PCS_INT outputlen, PCS_SMALLINT indicator);
extern PACKAGE int __stdcall (*ct_br_column)(PCS_COMMAND cmd, int colnum, _cs_browsedesc &browsedesc);
extern PACKAGE int __stdcall (*ct_br_table)(PCS_COMMAND cmd, int tabnum, int typ, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_callback)(PCS_CONTEXT context, PCS_CONNECTION connection, int action, int typ, PCS_VOID func);
extern PACKAGE int __stdcall (*ct_cancel)(PCS_CONNECTION connection, PCS_COMMAND cmd, int typ);
extern PACKAGE int __stdcall (*ct_capability)(PCS_CONNECTION connection, int action, int typ, int capability, PCS_VOID val);
extern PACKAGE int __stdcall (*ct_compute_info)(PCS_COMMAND cmd, int typ, int colnum, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_close)(PCS_CONNECTION connection, int option);
extern PACKAGE int __stdcall (*ct_cmd_alloc)(PCS_CONNECTION connection, PCS_COMMAND &cmdptr);
extern PACKAGE int __stdcall (*ct_cmd_drop)(PCS_COMMAND cmd);
extern PACKAGE int __stdcall (*ct_cmd_props)(PCS_COMMAND cmd, int action, int prop, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_command)(PCS_COMMAND cmd, int typ, char * buf, int buflen, int option);
extern PACKAGE int __stdcall (*ct_con_alloc)(PCS_CONTEXT context, PCS_CONNECTION &connection);
extern PACKAGE int __stdcall (*ct_con_drop)(PCS_CONNECTION connection);
extern PACKAGE int __stdcall (*ct_con_props)(PCS_CONNECTION connection, int action, int prop, PCS_VOID buf, int buflen, PCS_INT outlen);
extern PACKAGE int __stdcall (*ct_connect)(PCS_CONNECTION connection, char * server_name, int snamelen);
extern PACKAGE int __stdcall (*ct_config)(PCS_CONTEXT context, int action, int prop, PCS_VOID buf, int buflen, PCS_INT outlen);
extern PACKAGE int __stdcall (*ct_cursor)(PCS_COMMAND cmd, int typ, char * name, int namelen, char * text, int tlen, int option);
extern PACKAGE int __stdcall (*ct_dyndesc)(PCS_COMMAND cmd, char * descriptor, int desclen, int operation, int idx, _cs_datafmt &datafmt, PCS_VOID buffer, int buflen, int &copied, short &indicator);
extern PACKAGE int __stdcall (*ct_describe)(PCS_COMMAND cmd, int item, _cs_datafmt &datafmt);
extern PACKAGE int __stdcall (*ct_diag)(PCS_CONNECTION connection, int operation, int typ, int idx, PCS_VOID buffer);
extern PACKAGE int __stdcall (*ct_dynamic)(PCS_COMMAND cmd, int typ, char * id, int idlen, char * buf, int buflen);
extern PACKAGE int __stdcall (*ct_exit)(PCS_CONTEXT context, int option);
extern PACKAGE int __stdcall (*ct_fetch)(PCS_COMMAND cmd, int typ, int offset, int option, PCS_INT count);
extern PACKAGE int __stdcall (*ct_getformat)(PCS_COMMAND cmd, int colnum, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_keydata)(PCS_COMMAND cmd, int action, int colnum, PCS_VOID buffer, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_init)(PCS_CONTEXT context, int version);
extern PACKAGE int __stdcall (*ct_options)(PCS_CONNECTION connection, int action, int option, PCS_VOID param, int paramlen, PCS_INT outlen);
extern PACKAGE int __stdcall (*ct_param)(PCS_COMMAND cmd, _cs_datafmt &datafmt, PCS_VOID data, int datalen, int indicator);
extern PACKAGE int __stdcall (*ct_getloginfo)(PCS_CONNECTION connection, void * &logptr);
extern PACKAGE int __stdcall (*ct_setloginfo)(PCS_CONNECTION connection, void * loginfo);
extern PACKAGE int __stdcall (*ct_recvpassthru)(PCS_COMMAND cmd, PCS_VOID &recvptr);
extern PACKAGE int __stdcall (*ct_sendpassthru)(PCS_COMMAND cmd, PCS_VOID send_bufp);
extern PACKAGE int __stdcall (*ct_poll)(PCS_CONTEXT context, PCS_CONNECTION connection, int milliseconds, PCS_CONNECTION &compconn, PCS_COMMAND &compcmd, int &compid, int &compstatus);
extern PACKAGE int __stdcall (*ct_remote_pwd)(PCS_CONNECTION connection, int action, char * server_name, int snamelen, char * password, int pwdlen);
extern PACKAGE int __stdcall (*ct_results)(PCS_COMMAND cmd, int &result_type);
extern PACKAGE int __stdcall (*ct_res_info)(PCS_COMMAND cmd, int operation, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_send)(PCS_COMMAND cmd);
extern PACKAGE int __stdcall (*ct_get_data)(PCS_COMMAND cmd, int colnum, PCS_VOID buf, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_send_data)(PCS_COMMAND cmd, PCS_VOID buf, int buflen);
extern PACKAGE int __stdcall (*ct_data_info)(PCS_COMMAND cmd, int action, int colnum, _cs_iodesc &iodesc);
extern PACKAGE int __stdcall (*ct_wakeup)(PCS_CONNECTION connection, PCS_COMMAND cmd, int func_id, int status);
extern PACKAGE int __stdcall (*ct_labels)(PCS_CONNECTION connection, int action, char * labelname, int namelen, char * labelvalue, int valuelen, int &outlen);
extern PACKAGE int __stdcall (*ct_ds_lookup)(PCS_CONNECTION connection, int action, int &reqidp, _cs_ds_lookup_info &lookupinfo, PCS_VOID userdatap);
extern PACKAGE int __stdcall (*ct_ds_dropobj)(PCS_CONNECTION connection, PCS_DS_OBJECT obj);
extern PACKAGE int __stdcall (*ct_ds_objinfo)(PCS_DS_OBJECT objclass, int action, int objinfo, int number, PCS_VOID buffer, int buflen, int &outlen);
extern PACKAGE int __stdcall (*ct_setparam)(PCS_COMMAND cmd, _cs_datafmt &datafmt, PCS_VOID data, int &datalenp, short &indp);
#define DefSqlApiDLL_CS "LIBCS.DLL"
#define DefSqlApiDLL_CT "LIBCT.DLL"
#define DefSqlApiDLL "LIBCS.DLL,LIBCT.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdsyb */
using namespace Sdsyb;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDSyb
