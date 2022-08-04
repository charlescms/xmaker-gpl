// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDPgSQL.pas' rev: 6.00

#ifndef SDPgSQLHPP
#define SDPgSQLHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdpgsql
{
//-- type declarations -------------------------------------------------------
typedef unsigned Oid;

typedef void *TVoid;

typedef void *PPGconn;

typedef int TConnStatusType;

typedef int TPostgresPollingStatusType;

typedef int TExecStatusType;

typedef void *PSSL;

typedef void *PPGresult;

#pragma pack(push, 4)
struct TPGnotify
{
	char szRelName[33];
	int be_pid;
} ;
#pragma pack(pop)

typedef void __cdecl (*TPQnoticeProcessor)(void * arg, char * szMessage);

typedef char TPQBool;

#pragma pack(push, 4)
struct TPQprintOpt
{
	char header;
	char align;
	char standard;
	char html3;
	char expanded;
	char pager;
	char *fieldSep;
	char *tableOpt;
	char *caption;
	char *fieldName[1];
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TPQconninfoOption
{
	char *szKeyword;
	char *szEnvVar;
	char *szCompiled;
	char *szVal;
	char *szLabel;
	char *szDispChar;
	int dispsize;
} ;
#pragma pack(pop)

typedef TPQconninfoOption *PPQconninfoOption;

typedef TPGnotify *PPGnotify;

typedef TPQprintOpt *PPQprintOpt;

#pragma pack(push, 4)
struct TPQArgBlock
{
	int len;
	int isint;
	int IntOrPtr;
} ;
#pragma pack(pop)

class DELPHICLASS ESDPgSQLError;
class PASCALIMPLEMENTATION ESDPgSQLError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDPgSQLError(int AErrorCode, int ANativeError, const AnsiString Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDPgSQLError(int AErrorCode, int ANativeError, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDPgSQLError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDPgSQLError(int Ident)/* overload */ : Sdcommon::ESDEngineError(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDPgSQLError(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDPgSQLError(const AnsiString Msg, int AHelpContext) : Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDPgSQLError(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDPgSQLError(int Ident, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDPgSQLError(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sdcommon::ESDEngineError(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDPgSQLError(void) { }
	#pragma option pop
	
};


#pragma pack(push, 1)
struct TIPgConnInfo
{
	Byte ServerType;
	void *PgConnPtr;
} ;
#pragma pack(pop)

class DELPHICLASS TIPgDatabase;
class PASCALIMPLEMENTATION TIPgDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	void __fastcall Check(void * pgconn);
	void __fastcall CheckRes(void * pgres);
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(void);
	void __fastcall ExecCmd(const AnsiString sStmt, bool CheckRslt);
	void * __fastcall GetPgConnPtr(void);
	
protected:
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	
public:
	__fastcall virtual TIPgDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TIPgDatabase(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString();
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall TestConnected(void);
	__property void * PgConnPtr = {read=GetPgConnPtr};
};


class DELPHICLASS TIPgCommand;
class PASCALIMPLEMENTATION TIPgCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void *FHandle;
	int FRecCount;
	int FCurrRec;
	AnsiString FStmt;
	AnsiString FBindStmt;
	int FRowsAffected;
	bool __fastcall GetIsOpened(void);
	HIDESBASE TIPgDatabase* __fastcall GetSqlDatabase(void);
	AnsiString __fastcall CnvtDateTime2SqlString(System::TDateTime Value);
	AnsiString __fastcall CnvtFloat2SqlString(double Value);
	AnsiString __fastcall CnvtByteString2String(AnsiString Value);
	Sdcommon::TBytes __fastcall CnvtString2ByteString(AnsiString Value);
	AnsiString __fastcall CnvtString2EscapeString(AnsiString Value);
	void __fastcall InternalQBindParams(void);
	bool __fastcall InternalQExecute(void);
	
protected:
	void __fastcall Check(void * pgres);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall SetFieldsBuffer(void);
	__property bool IsOpened = {read=GetIsOpened, nodefault};
	
public:
	__fastcall virtual TIPgCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TIPgCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	__property TIPgDatabase* SqlDatabase = {read=GetSqlDatabase};
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint BOOLOID = 0x10;
static const Shortint BYTEAOID = 0x11;
static const Shortint CHAROID = 0x12;
static const Shortint NAMEOID = 0x13;
static const Shortint INT8OID = 0x14;
static const Shortint INT2OID = 0x15;
static const Shortint INT2VECTOROID = 0x16;
static const Shortint INT4OID = 0x17;
static const Shortint REGPROCOID = 0x18;
static const Shortint TEXTOID = 0x19;
static const Shortint OIDOID = 0x1a;
static const Shortint TIDOID = 0x1b;
static const Shortint XIDOID = 0x1c;
static const Shortint CIDOID = 0x1d;
static const Shortint OIDVECTOROID = 0x1e;
static const Word POINTOID = 0x258;
static const Word LSEGOID = 0x259;
static const Word PATHOID = 0x25a;
static const Word BOXOID = 0x25b;
static const Word POLYGONOID = 0x25c;
static const Word LINEOID = 0x274;
static const Word FLOAT4OID = 0x2bc;
static const Word FLOAT8OID = 0x2bd;
static const Word ABSTIMEOID = 0x2be;
static const Word RELTIMEOID = 0x2bf;
static const Word TINTERVALOID = 0x2c0;
static const Word UNKNOWNOID = 0x2c1;
static const Word CIRCLEOID = 0x2ce;
static const Word CASHOID = 0x316;
static const Word INETOID = 0x365;
static const Word CIDROID = 0x28a;
static const Shortint ACLITEMSIZE = 0x8;
static const Word BPCHAROID = 0x412;
static const Word VARCHAROID = 0x413;
static const Word DATEOID = 0x43a;
static const Word TIMEOID = 0x43b;
static const Word TIMESTAMPOID = 0x4a0;
static const Word INTERVALOID = 0x4a2;
static const Word TIMETZOID = 0x4f2;
static const Word ZPBITOID = 0x618;
static const Word VARBITOID = 0x61a;
static const Word NUMERICOID = 0x6a4;
static const Word TIMESTAMPOID_v72 = 0x45a;
static const Shortint InvalidOid = 0x0;
static const Shortint NAMEDATALEN = 0x20;
static const Shortint CONNECTION_OK = 0x0;
static const Shortint CONNECTION_BAD = 0x1;
static const Shortint CONNECTION_STARTED = 0x2;
static const Shortint CONNECTION_MADE = 0x3;
static const Shortint CONNECTION_AWAITING_RESPONSE = 0x4;
static const Shortint CONNECTION_AUTH_OK = 0x5;
static const Shortint CONNECTION_SETENV = 0x6;
static const Shortint PGRES_POLLING_FAILED = 0x0;
static const Shortint PGRES_POLLING_READING = 0x1;
static const Shortint PGRES_POLLING_WRITING = 0x2;
static const Shortint PGRES_POLLING_OK = 0x3;
static const Shortint PGRES_POLLING_ACTIVE = 0x4;
static const Shortint PGRES_EMPTY_QUERY = 0x0;
static const Shortint PGRES_COMMAND_OK = 0x1;
static const Shortint PGRES_TUPLES_OK = 0x2;
static const Shortint PGRES_COPY_OUT = 0x3;
static const Shortint PGRES_COPY_IN = 0x4;
static const Shortint PGRES_BAD_RESPONSE = 0x5;
static const Shortint PGRES_NONFATAL_ERROR = 0x6;
static const Shortint PGRES_FATAL_ERROR = 0x7;
extern PACKAGE void * __cdecl (*PQconnectStart)(char * szConnInfo);
extern PACKAGE int __cdecl (*PQconnectPoll)(void * conn);
extern PACKAGE void * __cdecl (*PQconnectdb)(char * szConnInfo);
extern PACKAGE void * __cdecl (*PQsetdbLogin)(char * pghost, char * pgport, char * pgoptions, char * pgtty, char * dbName, char * login, char * pwd);
extern PACKAGE void __cdecl (*PQfinish)(void * conn);
extern PACKAGE PPQconninfoOption __cdecl (*PQconndefaults)(void);
extern PACKAGE void __cdecl (*PQconninfoFree)(PPQconninfoOption connOptions);
extern PACKAGE int __cdecl (*PQresetStart)(void * conn);
extern PACKAGE int __cdecl (*PQresetPoll)(void * conn);
extern PACKAGE void __cdecl (*PQreset)(void * conn);
extern PACKAGE int __cdecl (*PQrequestCancel)(void * conn);
extern PACKAGE char * __cdecl (*PQdb)(const void * conn);
extern PACKAGE char * __cdecl (*PQuser)(const void * conn);
extern PACKAGE char * __cdecl (*PQpass)(const void * conn);
extern PACKAGE char * __cdecl (*PQhost)(const void * conn);
extern PACKAGE char * __cdecl (*PQport)(const void * conn);
extern PACKAGE char * __cdecl (*PQtty)(const void * conn);
extern PACKAGE char * __cdecl (*PQoptions)(const void * conn);
extern PACKAGE int __cdecl (*PQstatus)(const void * conn);
extern PACKAGE char * __cdecl (*PQerrorMessage)(const void * conn);
extern PACKAGE int __cdecl (*PQsocket)(const void * conn);
extern PACKAGE int __cdecl (*PQbackendPID)(const void * conn);
extern PACKAGE int __cdecl (*PQclientEncoding)(const void * conn);
extern PACKAGE int __cdecl (*PQsetClientEncoding)(void * conn, const char * encoding);
extern PACKAGE void * __cdecl (*PQgetssl)(void * conn);
extern PACKAGE void __cdecl (*PQtrace)(void * conn, void * debug_port);
extern PACKAGE void __cdecl (*PQuntrace)(void * conn);
extern PACKAGE TPQnoticeProcessor __fastcall (*PQsetNoticeProcessor)(void * conn, TPQnoticeProcessor proc, void * arg);
extern PACKAGE void * __cdecl (*PQexec)(void * conn, const char * query);
extern PACKAGE PPGnotify __cdecl (*PQnotifies)(void * conn);
extern PACKAGE int __cdecl (*PQsendQuery)(void * conn, const char * query);
extern PACKAGE void * __cdecl (*PQgetResult)(void * conn);
extern PACKAGE int __cdecl (*PQisBusy)(void * conn);
extern PACKAGE int __cdecl (*PQconsumeInput)(void * conn);
extern PACKAGE int __cdecl (*PQgetline)(void * conn, char * str, int length);
extern PACKAGE int __cdecl (*PQputline)(void * conn, const char * str);
extern PACKAGE int __cdecl (*PQgetlineAsync)(void * conn, char * buffer, int bufsize);
extern PACKAGE int __cdecl (*PQputnbytes)(void * conn, const char * buffer, int nbytes);
extern PACKAGE int __cdecl (*PQendcopy)(void * conn);
extern PACKAGE int __cdecl (*PQsetnonblocking)(void * conn, int arg);
extern PACKAGE int __cdecl (*PQisnonblocking)(const void * conn);
extern PACKAGE int __cdecl (*PQflush)(void * conn);
extern PACKAGE int __cdecl (*PQresultStatus)(const void * res);
extern PACKAGE char * __cdecl (*PQresStatus)(int status);
extern PACKAGE char * __cdecl (*PQresultErrorMessage)(const void * res);
extern PACKAGE int __cdecl (*PQntuples)(const void * res);
extern PACKAGE int __cdecl (*PQnfields)(const void * res);
extern PACKAGE int __cdecl (*PQbinaryTuples)(const void * res);
extern PACKAGE char * __cdecl (*PQfname)(const void * res, int field_num);
extern PACKAGE int __cdecl (*PQfnumber)(const void * res, const char * field_name);
extern PACKAGE unsigned __cdecl (*PQftype)(const void * res, int field_num);
extern PACKAGE int __cdecl (*PQfsize)(const void * res, int field_num);
extern PACKAGE int __cdecl (*PQfmod)(const void * res, int field_num);
extern PACKAGE char * __cdecl (*PQcmdStatus)(void * res);
extern PACKAGE char * __cdecl (*PQoidStatus)(const void * res);
extern PACKAGE unsigned __cdecl (*PQoidValue)(const void * res);
extern PACKAGE char * __cdecl (*PQcmdTuples)(void * res);
extern PACKAGE char * __cdecl (*PQgetvalue)(const void * res, int tup_num, int field_num);
extern PACKAGE int __cdecl (*PQgetlength)(const void * res, int tup_num, int field_num);
extern PACKAGE int __cdecl (*PQgetisnull)(const void * res, int tup_num, int field_num);
extern PACKAGE void __cdecl (*PQclear)(void * res);
extern PACKAGE void * __cdecl (*PQmakeEmptyPGresult)(void * conn, int status);
extern PACKAGE void __cdecl (*PQprint)(void * fout, const void * res, const PPQprintOpt ps);
extern PACKAGE int __cdecl (*lo_open)(void * conn, unsigned lobjId, int mode);
extern PACKAGE int __cdecl (*lo_close)(void * conn, int fd);
extern PACKAGE int __cdecl (*lo_read)(void * conn, int fd, char * buf, int len);
extern PACKAGE int __cdecl (*lo_write)(void * conn, int fd, char * buf, int len);
extern PACKAGE int __cdecl (*lo_lseek)(void * conn, int fd, int offset, int whence);
extern PACKAGE unsigned __cdecl (*lo_creat)(void * conn, int mode);
extern PACKAGE int __cdecl (*lo_tell)(void * conn, int fd);
extern PACKAGE int __cdecl (*lo_unlink)(void * conn, unsigned lobjId);
extern PACKAGE unsigned __cdecl (*lo_import)(void * conn, const char * filename);
extern PACKAGE int __cdecl (*lo_export)(void * conn, unsigned lobjId, const char * filename);
extern PACKAGE int __cdecl (*PQmblen)(const char * s, int encoding);
extern PACKAGE int __cdecl (*PQenv2encoding)(void);
#define DefSqlApiDLL "libpq.dll"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdpgsql */
using namespace Sdpgsql;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDPgSQL
