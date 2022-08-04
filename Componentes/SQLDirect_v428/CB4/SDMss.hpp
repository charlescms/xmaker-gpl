// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDMss.pas' rev: 4.00

#ifndef SDMssHPP
#define SDMssHPP

#pragma delphiheader begin
#pragma option push -w-
#include <SDCommon.hpp>	// Pascal unit
#include <SDConsts.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdmss
{
//-- type declarations -------------------------------------------------------
typedef void *void;

typedef int INT;

typedef int LONG;

typedef Word USHORT;

typedef int BOOL;

typedef int *LPINT;

typedef void * *LPVOID;

typedef char *LPBYTE;

typedef void *PDBPROCESS;

typedef void *PLOGINREC;

typedef void *PDBCURSOR;

typedef void *PDBHANDLE;

typedef int RETCODE;

typedef int STATUS;

typedef char DBCHAR;

typedef Byte DBBINARY;

typedef Byte DBTINYINT;

typedef short DBSMALLINT;

typedef Word DBUSMALLINT;

typedef int DBINT;

typedef double DBFLT8;

typedef Byte DBBIT;

typedef Byte DBBOOL;

typedef float DBFLT4;

typedef int DBMONEY4;

typedef float DBREAL;

typedef unsigned DBUBOOL;

#pragma pack(push, 4)
struct DBDATETIME4
{
	Word numdays;
	Word nummins;
} ;
#pragma pack(pop)

typedef DBDATETIME4  DBDATETIM4;

#pragma pack(push, 4)
struct DBVARYCHAR
{
	short len;
	char str[256];
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct DBVARYBIN
{
	short len;
	Byte arr[256];
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct DBMONEY
{
	int mnyhigh;
	unsigned mnylow;
} ;
#pragma pack(pop)

#pragma pack(push, 1)
struct DBDATETIME
{
	int dtdays;
	unsigned dttime;
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct DBDATEREC
{
	int year;
	int quarter;
	int month;
	int dayofyear;
	int day;
	int week;
	int weekday;
	int hour;
	int minute;
	int second;
	int millisecond;
} ;
#pragma pack(pop)

#pragma pack(push, 1)
struct DBNUMERIC
{
	Byte precision;
	Byte scale;
	Byte sign;
	Byte val[16];
} ;
#pragma pack(pop)

typedef DBNUMERIC  DBDECIMAL;

#pragma pack(push, 4)
struct TDBPROCINFO
{
	int SizeOfStruct;
	Byte ServerType;
	Word ServerMajor;
	Word ServerMinor;
	Word ServerRevision;
	char ServerName[31];
	char NetLibName[256];
	char NetLibConnStr[256];
} ;
#pragma pack(pop)

typedef TDBPROCINFO *LPDBPROCINFO;

#pragma pack(push, 4)
struct TDBCURSORINFO
{
	int SizeOfStruct;
	unsigned TotCols;
	unsigned TotRows;
	unsigned CurRow;
	unsigned TotRowsFetched;
	unsigned CuMssSetErrHandlerrType;
	unsigned Status;
} ;
#pragma pack(pop)

typedef TDBCURSORINFO *LPDBCURSORINFO;

typedef int *LPCINT;

typedef char *LPCBYTE;

typedef Word *LPUSHORT;

typedef Word *LPCUSHORT;

typedef int *LPDBINT;

typedef int *LPCDBINT;

typedef Byte *LPDBBINARY;

typedef Byte *LPCDBBINARY;

typedef DBDATEREC *LPDBDATEREC;

typedef DBDATEREC *LPCDBDATEREC;

typedef DBDATETIME *LPDBDATETIME;

typedef DBDATETIME *LPCDBDATETIME;

typedef int __cdecl (*TDBERRHANDLE_PROC)(void * dbproc, int severity, int dberr, int oserr, char * dberrstr
	, char * oserrstr);

typedef int __cdecl (*TDBMSGHANDLE_PROC)(void * dbproc, int msgno, int msgstate, int severity, char * 
	msgtext, char * srvname, char * procname, Word line);

typedef TDBERRHANDLE_PROC __fastcall (*Tdberrhandle)(TDBERRHANDLE_PROC handler);

typedef TDBMSGHANDLE_PROC __fastcall (*Tdbmsghandle)(TDBMSGHANDLE_PROC handler);

#pragma pack(push, 1)
struct TDBCOL
{
	int SizeOfStruct;
	char Name[31];
	char ActualName[31];
	char TableName[31];
	Byte dummy1;
	short ColType;
	int UserType;
	int MaxLength;
	Byte Precision;
	Byte Scale;
	int VarLength;
	Byte Null;
	Byte CaseSensitive;
	Byte Updatable;
	Byte dummy2;
	int Identity;
} ;
#pragma pack(pop)

typedef TDBCOL *LPDBCOL;

class DELPHICLASS ESDMssError;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION ESDMssError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
private:
	void *FHProcess;
	int FSeverity;
	
public:
	__fastcall ESDMssError(void * DbProc, short AErrorCode, short ANativeError, int ASeverity, const AnsiString 
		Msg, int AErrorPos);
	__property void * HProcess = {read=FHProcess};
	__property int Severity = {read=FSeverity, nodefault};
public:
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDMssError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDMssError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDMssError(int Ident, Extended Dummy) : Sdcommon::ESDEngineError(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDMssError(int Ident, const System::TVarRec * Args, 
		const int Args_Size) : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDMssError(const AnsiString Msg, int AHelpContext) : 
		Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDMssError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDMssError(int Ident, int AHelpContext) : Sdcommon::ESDEngineError(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDMssError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDMssError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma pack(push, 1)
struct TIMssConnInfo
{
	Byte ServerType;
	void *DBProcPtr;
	void *LoginRecPtr;
	AnsiString ServerNameStr;
} ;
#pragma pack(pop)

class DELPHICLASS TIMssDatabase;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIMssDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	Sdcommon::TISqlCommand* FCurSqlCmd;
	bool FByteAsGuid;
	void __fastcall Check(void * dbproc);
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(void);
	void * __fastcall GetDBProcPtr(void);
	void * __fastcall GetLoginRecPtr(void);
	AnsiString __fastcall GetServerName(void);
	void __fastcall GetStmtResult(const AnsiString Stmt, Classes::TStrings* List);
	void __fastcall HandleExecCmd(void * AHandle, const AnsiString Stmt);
	void __fastcall HandleSetAutoCommit(void * AHandle);
	void __fastcall HandleSetDefOptions(void * AHandle);
	void __fastcall HandleSetTransIsolation(void * AHandle, Sdcommon::TISqlTransIsolation Value);
	void __fastcall HandleReset(void * AHandle);
	void __fastcall SetDefaultOptions(void);
	
protected:
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall DoConnect(const AnsiString sRemoteDatabase, const AnsiString sUserName, const 
		AnsiString sPassword);
	virtual void __fastcall DoDisconnect(bool Force);
	virtual void __fastcall DoCommit(void);
	virtual void __fastcall DoRollback(void);
	virtual void __fastcall DoStartTransaction(void);
	virtual void __fastcall SetAutoCommitOption(bool Value);
	virtual void __fastcall SetHandle(void * AHandle);
	
public:
	__fastcall virtual TIMssDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TIMssDatabase(void);
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
	virtual AnsiString __fastcall GetAutoIncSQL(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString(void);
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString 
		AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
	void __fastcall ReleaseDBHandle(Sdcommon::TISqlCommand* ASqlCmd, bool IsFetchAll, bool IsReset);
	__property Sdcommon::TISqlCommand* CurSqlCmd = {read=FCurSqlCmd};
	__property void * DBProcPtr = {read=GetDBProcPtr};
	__property void * LoginRecPtr = {read=GetLoginRecPtr};
	__property AnsiString ServerName = {read=GetServerName};
	__property bool ByteAsGuid = {read=FByteAsGuid, nodefault};
};

#pragma pack(pop)

class DELPHICLASS TIMssCommand;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIMssCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	AnsiString FBindStmt;
	int FRowsAffected;
	void *FHandle;
	bool FIsSingleConn;
	bool FConnected;
	bool FNextResults;
	bool FEndResults;
	void __fastcall Connect(void);
	bool __fastcall CanReturnRows(void);
	AnsiString __fastcall CnvtDateTimeToSQLVarChar(Db::TFieldType ADataType, System::TDateTime Value);
	DBDATETIME __fastcall CnvtDateTimeToSQLDateTime(System::TDateTime Value);
	Db::TDateTimeRec __fastcall CnvtDBDateTime2DateTimeRec(Db::TFieldType ADataType, char * Buffer, int 
		BufSize);
	AnsiString __fastcall CnvtFloatToSQLVarChar(double Value);
	void * __fastcall CreateDBProcess(void);
	void __fastcall HandleCancel(void * AHandle);
	void __fastcall HandleCurReset(void * AHandle);
	void __fastcall HandleReset(void * AHandle);
	void __fastcall HandleSpInit(void * AHandle, AnsiString ARpcName);
	void __fastcall HandleSpExec(void * AHandle);
	bool __fastcall HandleSpResults(void * AHandle);
	bool __fastcall GetExecuted(void);
	HIDESBASE TIMssDatabase* __fastcall GetSqlDatabase(void);
	bool __fastcall GetDBHandleAcquired(void);
	void __fastcall InternalExecute(void);
	void __fastcall InternalQBindParams(void);
	void __fastcall InternalQExecute(void);
	void __fastcall InternalSpBindParams(void);
	void __fastcall InternalSpExecute(void);
	void __fastcall InternalSpGetParams(void);
	void __fastcall FetchDataSize(void);
	
protected:
	void __fastcall Check(void);
	void __fastcall AcquireDBHandle(void);
	void __fastcall ReleaseDBHandle(void);
	void __fastcall ReleaseDBHandleWOReset(void);
	virtual void __fastcall AllocParamsBuffer(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall FreeParamsBuffer(void);
	virtual int __fastcall GetParamsBufferSize(void);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall SetFieldsBuffer(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	
public:
	__fastcall virtual TIMssCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TIMssCommand(void);
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
	void __fastcall ResetExecuted(void);
	__property bool Executed = {read=GetExecuted, nodefault};
	__property bool DBHandleAcquired = {read=GetDBHandleAcquired, nodefault};
	__property TIMssDatabase* SqlDatabase = {read=GetSqlDatabase};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const Word DBMAXCHAR = 0x100;
static const Shortint MAXNUMERICLEN = 0x10;
static const Shortint MAXNUMERICDIG = 0x26;
static const Shortint DEFAULTPRECISION = 0x12;
static const Shortint DEFAULTSCALE = 0x0;
static const Shortint MAXCOLNAMELEN = 0x1e;
static const Shortint MAXTABLENAME = 0x1e;
static const Shortint MAXSERVERNAME = 0x1e;
static const Byte MAXNETLIBNAME = 0xff;
static const Byte MAXNETLIBCONNSTR = 0xff;
static const unsigned INVALID_UROWNUM = 0xffffffff;
static const unsigned TIMEOUT_IGNORE = 0xffffffff;
static const unsigned TIMEOUT_INFINITE = 0x0;
static const unsigned TIMEOUT_MAXIMUM = 0x4b0;
static const Shortint SERVTYPE_UNKNOWN = 0x0;
static const Shortint SERVTYPE_MICROSOFT = 0x1;
static const Shortint CI_REGULAR = 0x1;
static const Shortint CI_ALTERNATE = 0x2;
static const Shortint CI_CURSOR = 0x3;
static const Shortint DB_IN = 0x1;
static const Shortint DB_OUT = 0x2;
static const Shortint BCPMAXERRS = 0x1;
static const Shortint BCPFIRST = 0x2;
static const Shortint BCPLAST = 0x3;
static const Shortint BCPBATCH = 0x4;
static const Shortint BCPKEEPNULLS = 0x5;
static const Shortint BCPABORT = 0x6;
static const Shortint DB_TRUE = 0x1;
static const Shortint DB_FALSE = 0x0;
static const Shortint TINYBIND = 0x1;
static const Shortint SMALLBIND = 0x2;
static const Shortint INTBIND = 0x3;
static const Shortint CHARBIND = 0x4;
static const Shortint BINARYBIND = 0x5;
static const Shortint BITBIND = 0x6;
static const Shortint DATETIMEBIND = 0x7;
static const Shortint MONEYBIND = 0x8;
static const Shortint FLT8BIND = 0x9;
static const Shortint STRINGBIND = 0xa;
static const Shortint NTBSTRINGBIND = 0xb;
static const Shortint VARYCHARBIND = 0xc;
static const Shortint VARYBINBIND = 0xd;
static const Shortint FLT4BIND = 0xe;
static const Shortint SMALLMONEYBIND = 0xf;
static const Shortint SMALLDATETIBIND = 0x10;
static const Shortint DECIMALBIND = 0x11;
static const Shortint NUMERICBIND = 0x12;
static const Shortint SRCDECIMALBIND = 0x13;
static const Shortint SRCNUMERICBIND = 0x14;
static const Shortint MAXBIND = 0x14;
static const Shortint DBSAVE = 0x1;
static const Shortint DBNOSAVE = 0x0;
static const Shortint DBNOERR = 0xffffffff;
static const Shortint DBFINDONE = 0x4;
static const Shortint DBMORE = 0x10;
static const Shortint DBMORE_ROWS = 0x20;
static const Shortint MAXNAME = 0x1f;
static const Shortint DBTXTSLEN = 0x8;
static const Shortint DBTXPLEN = 0x10;
static const Shortint INT_EXIT = 0x0;
static const Shortint INT_CONTINUE = 0x1;
static const Shortint INT_CANCEL = 0x2;
static const Shortint DBBUFFER = 0x0;
static const Shortint DBOFFSET = 0x1;
static const Shortint DBROWCOUNT = 0x2;
static const Shortint DBSTAT = 0x3;
static const Shortint DBTEXTLIMIT = 0x4;
static const Shortint DBTEXTSIZE = 0x5;
static const Shortint DBARITHABORT = 0x6;
static const Shortint DBARITHIGNORE = 0x7;
static const Shortint DBNOAUTOFREE = 0x8;
static const Shortint DBNOCOUNT = 0x9;
static const Shortint DBNOEXEC = 0xa;
static const Shortint DBPARSEONLY = 0xb;
static const Shortint DBSHOWPLAN = 0xc;
static const Shortint DBSTORPROCID = 0xd;
static const Shortint DBANSItoOEM = 0xe;
static const Shortint DBOEMtoANSI = 0xf;
static const Shortint DBCLIENTCURSORS = 0x10;
static const Shortint DBSETTIME_OPT = 0x11;
static const Shortint DBQUOTEDIDENT = 0x12;
static const Shortint SQLVOID = 0x1f;
static const Shortint SQLTEXT = 0x23;
static const Shortint SQLVARBINARY = 0x25;
static const Shortint SQLINTN = 0x26;
static const Shortint SQLVARCHAR = 0x27;
static const Shortint SQLBINARY = 0x2d;
static const Shortint SQLIMAGE = 0x22;
static const Shortint SQLCHAR = 0x2f;
static const Shortint SQLINT1 = 0x30;
static const Shortint SQLBIT = 0x32;
static const Shortint SQLINT2 = 0x34;
static const Shortint SQLINT4 = 0x38;
static const Shortint SQLMONEY = 0x3c;
static const Shortint SQLDATETIME = 0x3d;
static const Shortint SQLFLT8 = 0x3e;
static const Shortint SQLFLTN = 0x6d;
static const Shortint SQLMONEYN = 0x6e;
static const Shortint SQLDATETIMN = 0x6f;
static const Shortint SQLFLT4 = 0x3b;
static const Shortint SQLMONEY4 = 0x7a;
static const Shortint SQLDATETIM4 = 0x3a;
static const Shortint SQLDECIMAL = 0x6a;
static const Shortint SQLNUMERIC = 0x6c;
static const Byte SQLCOLFMT = 0xa1;
static const Shortint OLD_SQLCOLFMT = 0x2a;
static const Shortint SQLPROCID = 0x7c;
static const Byte SQLCOLNAME = 0xa0;
static const Byte SQLTABNAME = 0xa4;
static const Byte SQLCOLINFO = 0xa5;
static const Byte SQLALTNAME = 0xa7;
static const Byte SQLALTFMT = 0xa8;
static const Byte SQLERROR = 0xaa;
static const Byte SQLINFO = 0xab;
static const Byte SQLRETURNVALUE = 0xac;
static const Shortint SQLRETURNSTATUS = 0x79;
static const Byte SQLRETURN = 0xdb;
static const Byte SQLCONTROL = 0xae;
static const Byte SQLALTCONTROL = 0xaf;
static const Byte SQLROW = 0xd1;
static const Byte SQLALTROW = 0xd3;
static const Byte SQLDONE = 0xfd;
static const Byte SQLDONEPROC = 0xfe;
static const Byte SQLDONEINPROC = 0xff;
static const Shortint SQLOFFSET = 0x78;
static const Byte SQLORDER = 0xa9;
static const Byte SQLLOGINACK = 0xad;
static const Shortint SQLAOPCNT = 0x4b;
static const Shortint SQLAOPSUM = 0x4d;
static const Shortint SQLAOPAVG = 0x4f;
static const Shortint SQLAOPMIN = 0x51;
static const Shortint SQLAOPMAX = 0x52;
static const Shortint SQLAOPANY = 0x53;
static const Shortint SQLAOPNOOP = 0x56;
static const Word SQLEMEM = 0x2710;
static const Word SQLENULL = 0x2711;
static const Word SQLENLOG = 0x2712;
static const Word SQLEPWD = 0x2713;
static const Word SQLECONN = 0x2714;
static const Word SQLEDDNE = 0x2715;
static const Word SQLENULLO = 0x2716;
static const Word SQLESMSG = 0x2717;
static const Word SQLEBTOK = 0x2718;
static const Word SQLENSPE = 0x2719;
static const Word SQLEREAD = 0x271a;
static const Word SQLECNOR = 0x271b;
static const Word SQLETSIT = 0x271c;
static const Word SQLEPARM = 0x271d;
static const Word SQLEAUTN = 0x271e;
static const Word SQLECOFL = 0x271f;
static const Word SQLERDCN = 0x2720;
static const Word SQLEICN = 0x2721;
static const Word SQLECLOS = 0x2722;
static const Word SQLENTXT = 0x2723;
static const Word SQLEDNTI = 0x2724;
static const Word SQLETMTD = 0x2725;
static const Word SQLEASEC = 0x2726;
static const Word SQLENTLL = 0x2727;
static const Word SQLETIME = 0x2728;
static const Word SQLEWRIT = 0x2729;
static const Word SQLEMODE = 0x272a;
static const Word SQLEOOB = 0x272b;
static const Word SQLEITIM = 0x272c;
static const Word SQLEDBPS = 0x272d;
static const Word SQLEIOPT = 0x272e;
static const Word SQLEASNL = 0x272f;
static const Word SQLEASUL = 0x2730;
static const Word SQLENPRM = 0x2731;
static const Word SQLEDBOP = 0x2732;
static const Word SQLENSIP = 0x2733;
static const Word SQLECNULL = 0x2734;
static const Word SQLESEOF = 0x2735;
static const Word SQLERPND = 0x2736;
static const Word SQLECSYN = 0x2737;
static const Word SQLENONET = 0x2738;
static const Word SQLEBTYP = 0x2739;
static const Word SQLEABNC = 0x273a;
static const Word SQLEABMT = 0x273b;
static const Word SQLEABNP = 0x273c;
static const Word SQLEBNCR = 0x273d;
static const Word SQLEAAMT = 0x273e;
static const Word SQLENXID = 0x273f;
static const Word SQLEIFNB = 0x2740;
static const Word SQLEKBCO = 0x2741;
static const Word SQLEBBCI = 0x2742;
static const Word SQLEKBCI = 0x2743;
static const Word SQLEBCWE = 0x2744;
static const Word SQLEBCNN = 0x2745;
static const Word SQLEBCOR = 0x2746;
static const Word SQLEBCPI = 0x2747;
static const Word SQLEBCPN = 0x2748;
static const Word SQLEBCPB = 0x2749;
static const Word SQLEVDPT = 0x274a;
static const Word SQLEBIVI = 0x274b;
static const Word SQLEBCBC = 0x274c;
static const Word SQLEBCFO = 0x274d;
static const Word SQLEBCVH = 0x274e;
static const Word SQLEBCUO = 0x274f;
static const Word SQLEBUOE = 0x2750;
static const Word SQLEBWEF = 0x2751;
static const Word SQLEBTMT = 0x2752;
static const Word SQLEBEOF = 0x2753;
static const Word SQLEBCSI = 0x2754;
static const Word SQLEPNUL = 0x2755;
static const Word SQLEBSKERR = 0x2756;
static const Word SQLEBDIO = 0x2757;
static const Word SQLEBCNT = 0x2758;
static const Word SQLEMDBP = 0x2759;
static const Word SQLINIT = 0x275a;
static const Word SQLCRSINV = 0x275b;
static const Word SQLCRSCMD = 0x275c;
static const Word SQLCRSNOIND = 0x275d;
static const Word SQLCRSDIS = 0x275e;
static const Word SQLCRSAGR = 0x275f;
static const Word SQLCRSORD = 0x2760;
static const Word SQLCRSMEM = 0x2761;
static const Word SQLCRSBSKEY = 0x2762;
static const Word SQLCRSNORES = 0x2763;
static const Word SQLCRSVIEW = 0x2764;
static const Word SQLCRSBUFR = 0x2765;
static const Word SQLCRSFROWN = 0x2766;
static const Word SQLCRSBROL = 0x2767;
static const Word SQLCRSFRAND = 0x2768;
static const Word SQLCRSFLAST = 0x2769;
static const Word SQLCRSRO = 0x276a;
static const Word SQLCRSTAB = 0x276b;
static const Word SQLCRSUPDTAB = 0x276c;
static const Word SQLCRSUPDNB = 0x276d;
static const Word SQLCRSVIIND = 0x276e;
static const Word SQLCRSNOUPD = 0x276f;
static const Word SQLCRSOS2 = 0x2770;
static const Word SQLEBCSA = 0x2771;
static const Word SQLEBCRO = 0x2772;
static const Word SQLEBCNE = 0x2773;
static const Word SQLEBCSK = 0x2774;
static const Word SQLEUVBF = 0x2775;
static const Word SQLEBIHC = 0x2776;
static const Word SQLEBWFF = 0x2777;
static const Word SQLNUMVAL = 0x2778;
static const Word SQLEOLDVR = 0x2779;
static const Word SQLEBCPS = 0x277a;
static const Word SQLEDTC = 0x277b;
static const Word SQLENOTIMPL = 0x277c;
static const Word SQLENONFLOAT = 0x277d;
static const Word SQLECONNFB = 0x277e;
static const Shortint EXINFO = 0x1;
static const Shortint EXUSER = 0x2;
static const Shortint EXNONFATAL = 0x3;
static const Shortint EXCONVERSION = 0x4;
static const Shortint EXSERVER = 0x5;
static const Shortint EXTIME = 0x6;
static const Shortint EXPROGRAM = 0x7;
static const Shortint EXRESOURCE = 0x8;
static const Shortint EXCOMM = 0x9;
static const Shortint EXFATAL = 0xa;
static const Shortint EXCONSISTENCY = 0xb;
static const Word OFF_SELECT = 0x16d;
static const Word OFF_FROM = 0x14f;
static const Word OFF_ORDER = 0x165;
static const Word OFF_COMPUTE = 0x139;
static const Word OFF_TABLE = 0x173;
static const Word OFF_PROCEDURE = 0x16a;
static const Word OFF_STATEMENT = 0x1cb;
static const Word OFF_PARAM = 0x1c4;
static const Word OFF_EXEC = 0x12c;
static const Shortint PRINT4 = 0xb;
static const Shortint PRINT2 = 0x6;
static const Shortint PRINT1 = 0x3;
static const Shortint PRFLT8 = 0x14;
static const Shortint PRMONEY = 0x1a;
static const Shortint PRBIT = 0x3;
static const Shortint PRDATETIME = 0x1b;
static const Shortint PRDECIMAL = 0x28;
static const Shortint PRNUMERIC = 0x28;
static const Shortint SUCCEED = 0x1;
static const Shortint FAIL = 0x0;
static const Shortint SUCCEED_ABORT = 0x2;
static const Shortint DBUNKNOWN = 0x2;
static const Shortint MORE_ROWS = 0xffffffff;
static const Shortint NO_MORE_ROWS = 0xfffffffe;
static const Shortint REG_ROW = 0xffffffff;
static const Shortint BUF_FULL = 0xfffffffd;
static const Shortint NO_MORE_RESULTS = 0x2;
static const Shortint NO_MORE_RPC_RESULTS = 0x3;
static const Shortint DBSETHOST = 0x1;
static const Shortint DBSETUSER = 0x2;
static const Shortint DBSETPWD = 0x3;
static const Shortint DBSETAPP = 0x4;
static const Shortint DBSETID = 0x5;
static const Shortint DBSETLANG = 0x6;
static const Shortint DBSETSECURE = 0x7;
static const Shortint DBVER42 = 0x8;
static const Shortint DBVER60 = 0x9;
static const Shortint DBSETLOGINTIME_OPT = 0xa;
static const Shortint DBSETFALLBACK = 0xc;
static const Shortint STDEXIT = 0x0;
static const Shortint ERREXIT = 0xffffffff;
static const Shortint DBRPCRECOMPILE = 0x1;
static const Shortint DBRPCRESET = 0x4;
static const Shortint DBRPCCURSOR = 0x8;
static const Shortint DBRPCRETURN = 0x1;
static const Shortint DBRPCDEFAULT = 0x2;
static const Shortint CUR_READONLY = 0x1;
static const Shortint CUR_LOCKCC = 0x2;
static const Shortint CUR_OPTCC = 0x3;
static const Shortint CUR_OPTCCVAL = 0x4;
static const Shortint CUR_FORWARD = 0x0;
static const Shortint CUR_KEYSET = 0xffffffff;
static const Shortint CUR_DYNAMIC = 0x1;
static const Shortint CUR_INSENSITIVE = 0xfffffffe;
static const Shortint FETCH_FIRST = 0x1;
static const Shortint FETCH_NEXT = 0x2;
static const Shortint FETCH_PREV = 0x3;
static const Shortint FETCH_RANDOM = 0x4;
static const Shortint FETCH_RELATIVE = 0x5;
static const Shortint FETCH_LAST = 0x6;
static const Shortint FTC_EMPTY = 0x0;
static const Shortint FTC_SUCCEED = 0x1;
static const Shortint FTC_MISSING = 0x2;
static const Shortint FTC_ENDOFKEYSET = 0x4;
static const Shortint FTC_ENDOFRESULTS = 0x8;
static const Shortint CRS_UPDATE = 0x1;
static const Shortint CRS_DELETE = 0x2;
static const Shortint CRS_INSERT = 0x3;
static const Shortint CRS_REFRESH = 0x4;
static const Shortint CRS_LOCKCC = 0x5;
static const Shortint NOBIND = 0xfffffffe;
static const Shortint CU_CLIENT = 0x1;
static const Shortint CU_SERVER = 0x2;
static const Shortint CU_KEYSET = 0x4;
static const Shortint CU_MIXED = 0x8;
static const Shortint CU_DYNAMIC = 0x10;
static const Shortint CU_FORWARD = 0x20;
static const Shortint CU_INSENSITIVE = 0x40;
static const Byte CU_READONLY = 0x80;
static const Word CU_LOCKCC = 0x100;
static const Word CU_OPTCC = 0x200;
static const Word CU_OPTCCVAL = 0x400;
static const Shortint CU_FILLING = 0x1;
static const Shortint CU_FILLED = 0x2;
static const Shortint UT_TEXTPTR = 0x1;
static const Shortint UT_TEXT = 0x2;
static const Shortint UT_MORETEXT = 0x4;
static const Shortint UT_DELETEONLY = 0x8;
static const Shortint UT_LOG = 0x10;
static const Shortint NET_SEARCH = 0x1;
static const Shortint LOC_SEARCH = 0x2;
static const Shortint ENUM_SUCCESS = 0x0;
static const Shortint MORE_DATA = 0x1;
static const Shortint NET_NOT_AVAIL = 0x2;
static const Shortint OUT_OF_MEMORY = 0x4;
static const Shortint NOT_SUPPORTED = 0x8;
static const Shortint ENUM_INVALID_PARAM = 0x10;
static const Shortint NE_E_NOMAP = 0x0;
static const Shortint NE_E_NOMEMORY = 0x1;
static const Shortint NE_E_NOACCESS = 0x2;
static const Shortint NE_E_CONNBUSY = 0x3;
static const Shortint NE_E_CONNBROKEN = 0x4;
static const Shortint NE_E_TOOMANYCONN = 0x5;
static const Shortint NE_E_SERVERNOTFOUND = 0x6;
static const Shortint NE_E_NETNOTSTARTED = 0x7;
static const Shortint NE_E_NORESOURCE = 0x8;
static const Shortint NE_E_NETBUSY = 0x9;
static const Shortint NE_E_NONETACCESS = 0xa;
static const Shortint NE_E_GENERAL = 0xb;
static const Shortint NE_E_CONNMODE = 0xc;
static const Shortint NE_E_NAMENOTFOUND = 0xd;
static const Shortint NE_E_INVALIDCONN = 0xe;
static const Shortint NE_E_NETDATAERR = 0xf;
static const Shortint NE_E_TOOMANYFILES = 0x10;
static const Shortint NE_E_CANTCONNECT = 0x11;
static const Shortint NE_MAX_NETERROR = 0x11;
extern PACKAGE int __cdecl (*abort_xact)(void * connect, int CommId);
extern PACKAGE void __cdecl (*build_xact_string)(char * xact_name, char * service_name, int CommId, 
	char * sResult);
extern PACKAGE void __cdecl (*close_commit)(void * connect);
extern PACKAGE int __cdecl (*commit_xact)(void * connect, int commId);
extern PACKAGE void * __cdecl (*open_commit)(void * login, char * servername);
extern PACKAGE int __cdecl (*remove_xact)(void * connect, int commId, int n);
extern PACKAGE int __cdecl (*scan_xact)(void * connect, int commId);
extern PACKAGE int __cdecl (*start_xact)(void * connect, char * application_name, char * xact_name, 
	int site_count);
extern PACKAGE int __cdecl (*stat_xact)(void * connect, int commId);
extern PACKAGE int __cdecl (*bcp_batch)(void * dbproc);
extern PACKAGE int __cdecl (*bcp_bind)(void * dbproc, char * varaddr, int prefixlen, int varlen, char * 
	terminator, int termlen, int datatype, int table_column);
extern PACKAGE int __cdecl (*bcp_colfmt)(void * dbproc, int file_column, Byte file_type, int file_prefixlen
	, int file_collen, char * file_term, int file_termlen, int table_column);
extern PACKAGE int __cdecl (*bcp_collen)(void * dbproc, int varlen, int table_column);
extern PACKAGE int __cdecl (*bcp_colptr)(void * dbproc, char * colptr, int table_column);
extern PACKAGE int __cdecl (*bcp_columns)(void * dbproc, int file_colcount);
extern PACKAGE int __cdecl (*bcp_control)(void * dbproc, int field, int value);
extern PACKAGE int __cdecl (*bcp_done)(void * dbproc);
extern PACKAGE int __cdecl (*bcp_exec)(void * dbproc, LPDBINT rows_copied);
extern PACKAGE int __cdecl (*bcp_init)(void * dbproc, char * tblname, char * hfile, char * errfile, 
	int direction);
extern PACKAGE int __cdecl (*bcp_moretext)(void * dbproc, int size, char * text);
extern PACKAGE int __cdecl (*bcp_readfmt)(void * dbproc, char * filename);
extern PACKAGE int __cdecl (*bcp_sendrow)(void * dbproc);
extern PACKAGE int __cdecl (*bcp_setl)(void * loginrec, int enable);
extern PACKAGE int __cdecl (*bcp_writefmt)(void * dbproc, char * filename);
extern PACKAGE char * __cdecl (*dbadata)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbadlen)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbaltbind)(void * dbproc, int computeId, int column, int vartype, int varlen
	, char * varaddr);
extern PACKAGE int __cdecl (*dbaltcolid)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbaltlen)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbaltop)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbalttype)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbaltutype)(void * dbproc, int computeId, int column);
extern PACKAGE int __cdecl (*dbanullbind)(void * dbproc, int computeId, int column, LPDBINT indicator
	);
extern PACKAGE int __cdecl (*dbbind)(void * dbproc, int column, int vartype, int varlen, char * varaddr
	);
extern PACKAGE char * __cdecl (*dbbylist)(void * dbproc, int computeId, LPINT size);
extern PACKAGE int __cdecl (*dbcancel)(void * dbproc);
extern PACKAGE int __cdecl (*dbcanquery)(void * dbproc);
extern PACKAGE char * __cdecl (*dbchange)(void * dbproc);
extern PACKAGE int __cdecl (*dbclose)(void * dbproc);
extern PACKAGE void __cdecl (*dbclrbuf)(void * dbproc, int n);
extern PACKAGE int __cdecl (*dbclropt)(void * dbproc, int option, char * param);
extern PACKAGE int __cdecl (*dbcmd)(void * dbproc, char * cmdstring);
extern PACKAGE int __cdecl (*dbcmdrow)(void * dbproc);
extern PACKAGE int __cdecl (*dbcolbrowse)(void * dbproc, int colnum);
extern PACKAGE int __cdecl (*dbcolinfo)(void * dbHandle, int colinfo, int column, int computeId, TDBCOL 
	&DbCol);
extern PACKAGE int __cdecl (*dbcollen)(void * dbproc, int column);
extern PACKAGE char * __cdecl (*dbcolname)(void * dbproc, int column);
extern PACKAGE char * __cdecl (*dbcolsource)(void * dbproc, int colnum);
extern PACKAGE int __cdecl (*dbcoltype)(void * dbproc, int column);
extern PACKAGE int __cdecl (*dbcolutype)(void * dbproc, int column);
extern PACKAGE int __cdecl (*dbconvert)(void * dbproc, int srctype, char * src, int srclen, int desttype
	, char * dest, int destlen);
extern PACKAGE int __cdecl (*dbcount)(void * dbproc);
extern PACKAGE int __cdecl (*dbcurcmd)(void * dbproc);
extern PACKAGE int __cdecl (*dbcurrow)(void * dbproc);
extern PACKAGE int __cdecl (*dbcursor)(void * hc, int optype, int row, char * table, char * values);
	
extern PACKAGE int __cdecl (*dbcursorbind)(void * hc, int col, int vartype, int varlen, LPDBINT poutlen
	, char * pvaraddr);
extern PACKAGE int __cdecl (*dbcursorclose)(void * handle);
extern PACKAGE int __cdecl (*dbcursorcolinfo)(void * hcursor, int column, char * colname, LPINT coltype
	, LPDBINT collen, LPINT usertype);
extern PACKAGE int __cdecl (*dbcursorfetch)(void * hc, int fetchtype, int rownum);
extern PACKAGE int __cdecl (*dbcursorfetchex)(void * hc, int fetchtype, int rownum, int nfetchrows, 
	int reserved);
extern PACKAGE int __cdecl (*dbcursorinfo)(void * hcursor, LPINT ncols, LPDBINT nrows);
extern PACKAGE int __cdecl (*dbcursorinfoex)(void * hc, LPDBCURSORINFO pdbcursorinfo);
extern PACKAGE void * __cdecl (*dbcursoropen)(void * dbproc, char * stmt, int scrollopt, int concuropt
	, unsigned nrows, LPDBINT pstatus);
extern PACKAGE char * __cdecl (*dbdata)(void * dbproc, int column);
extern PACKAGE int __cdecl (*dbdataready)(void * dbproc);
extern PACKAGE int __cdecl (*dbdatecrack)(void * dbproc, DBDATEREC &dateinfo, void * datetime);
extern PACKAGE int __cdecl (*dbdatlen)(void * dbproc, int column);
extern PACKAGE int __cdecl (*dbdead)(void * dbproc);
extern PACKAGE void __cdecl (*dbexit)(void);
extern PACKAGE int __cdecl (*dbenlisttrans)(void * dbproc, LPVOID pTransaction);
extern PACKAGE int __cdecl (*dbenlistxatrans)(void * dbproc, int enlisttran);
extern PACKAGE int __cdecl (*dbfirstrow)(void * dbproc);
extern PACKAGE void __cdecl (*dbfreebuf)(void * dbproc);
extern PACKAGE void __cdecl (*dbfreelogin)(void * login);
extern PACKAGE void __cdecl (*dbfreequal)(char * ptr);
extern PACKAGE char * __cdecl (*dbgetchar)(void * dbproc, int n);
extern PACKAGE short __cdecl (*dbgetmaxprocs)(void);
extern PACKAGE int __cdecl (*dbgetoff)(void * dbproc, Word offtype, int startfrom);
extern PACKAGE unsigned __cdecl (*dbgetpacket)(void * dbproc);
extern PACKAGE int __cdecl (*dbgetrow)(void * dbproc, int row);
extern PACKAGE int __cdecl (*dbgettime)(void);
extern PACKAGE LPVOID __cdecl (*dbgetuserdata)(void * dbproc);
extern PACKAGE Byte __cdecl (*dbhasretstat)(void * dbproc);
extern PACKAGE char * __cdecl (*dbinit)(void);
extern PACKAGE int __cdecl (*dbisavail)(void * dbproc);
extern PACKAGE int __cdecl (*dbiscount)(void * dbproc);
extern PACKAGE int __cdecl (*dbisopt)(void * dbproc, int option, char * param);
extern PACKAGE int __cdecl (*dblastrow)(void * dbproc);
extern PACKAGE void * __cdecl (*dblogin)(void);
extern PACKAGE int __cdecl (*dbmorecmds)(void * dbproc);
extern PACKAGE int __cdecl (*dbmoretext)(void * dbproc, int size, char * text);
extern PACKAGE char * __cdecl (*dbname)(void * dbproc);
extern PACKAGE int __cdecl (*dbnextrow)(void * dbproc);
extern PACKAGE int __cdecl (*dbnullbind)(void * dbproc, int column, LPDBINT indicator);
extern PACKAGE int __cdecl (*dbnumalts)(void * dbproc, int computeId);
extern PACKAGE int __cdecl (*dbnumcols)(void * dbproc);
extern PACKAGE int __cdecl (*dbnumcompute)(void * dbproc);
extern PACKAGE int __cdecl (*dbnumorders)(void * dbproc);
extern PACKAGE int __cdecl (*dbnumrets)(void * dbproc);
extern PACKAGE void * __cdecl (*dbopen)(void * login, char * servername);
extern PACKAGE int __cdecl (*dbordercol)(void * dbproc, int order);
extern PACKAGE int __cdecl (*dbprocinfo)(void * dbproc, TDBPROCINFO &dbprcinfo);
extern PACKAGE void __cdecl (*dbprhead)(void * dbproc);
extern PACKAGE int __cdecl (*dbprrow)(void * dbproc);
extern PACKAGE char * __cdecl (*dbprtype)(int token);
extern PACKAGE char * __cdecl (*dbqual)(void * dbproc, int tabnum, char * tabname);
extern PACKAGE int __cdecl (*dbreadtext)(void * dbproc, LPVOID buf, int bufsize);
extern PACKAGE int __cdecl (*dbresults)(void * dbproc);
extern PACKAGE char * __cdecl (*dbretdata)(void * dbproc, int retnum);
extern PACKAGE int __cdecl (*dbretlen)(void * dbproc, int retnum);
extern PACKAGE char * __cdecl (*dbretname)(void * dbproc, int retnum);
extern PACKAGE int __cdecl (*dbretstatus)(void * dbproc);
extern PACKAGE int __cdecl (*dbrettype)(void * dbproc, int retnum);
extern PACKAGE int __cdecl (*dbrows)(void * dbproc);
extern PACKAGE int __cdecl (*dbrowtype)(void * dbproc);
extern PACKAGE int __cdecl (*dbrpcinit)(void * dbproc, char * rpcname, short options);
extern PACKAGE int __cdecl (*dbrpcparam)(void * dbproc, char * paramname, Byte status, int datatype, 
	int maxlen, int datalen, char * value);
extern PACKAGE int __cdecl (*dbrpcsend)(void * dbproc);
extern PACKAGE int __cdecl (*dbrpcexec)(void * dbproc);
extern PACKAGE int __cdecl (*dbserverenum)(Word searchmode, char * servnamebuf, Word sizeservnamebuf
	, LPUSHORT numentries);
extern PACKAGE void __cdecl (*dbsetavail)(void * dbproc);
extern PACKAGE int __cdecl (*dbsetmaxprocs)(short maxprocs);
extern PACKAGE int __cdecl (*dbsetlname)(void * login, char * value, int param);
extern PACKAGE int __cdecl (*dbsetlogintime)(int seconds);
extern PACKAGE int __cdecl (*dbsetlpacket)(void * login, Word packet_size);
extern PACKAGE int __cdecl (*dbsetnull)(void * dbproc, int bindtype, int bindlen, char * bindval);
extern PACKAGE int __cdecl (*dbsetopt)(void * dbproc, int option, char * param);
extern PACKAGE int __cdecl (*dbsettime)(int seconds);
extern PACKAGE void __cdecl (*dbsetuserdata)(void * dbproc, LPVOID ptr);
extern PACKAGE int __cdecl (*dbsqlexec)(void * dbproc);
extern PACKAGE int __cdecl (*dbsqlok)(void * dbproc);
extern PACKAGE int __cdecl (*dbsqlsend)(void * dbproc);
extern PACKAGE int __cdecl (*dbstrcpy)(void * dbproc, int start, int numbytes, char * dest);
extern PACKAGE int __cdecl (*dbstrlen)(void * dbproc);
extern PACKAGE int __cdecl (*dbtabbrowse)(void * dbproc, int tabnum);
extern PACKAGE int __cdecl (*dbtabcount)(void * dbproc);
extern PACKAGE char * __cdecl (*dbtabname)(void * dbproc, int tabnum);
extern PACKAGE char * __cdecl (*dbtabsource)(void * dbproc, int colnum, LPINT tabnum);
extern PACKAGE int __cdecl (*dbtsnewlen)(void * dbproc);
extern PACKAGE LPDBBINARY __cdecl (*dbtsnewval)(void * dbproc);
extern PACKAGE int __cdecl (*dbtsput)(void * dbproc, LPDBBINARY newts, int newtslen, int tabnum, char * 
	tabname);
extern PACKAGE LPDBBINARY __cdecl (*dbtxptr)(void * dbproc, int column);
extern PACKAGE LPDBBINARY __cdecl (*dbtxtimestamp)(void * dbproc, int column);
extern PACKAGE LPDBBINARY __cdecl (*dbtxtsnewval)(void * dbproc);
extern PACKAGE int __cdecl (*dbtxtsput)(void * dbproc, LPDBBINARY newtxts, int colnum);
extern PACKAGE int __cdecl (*dbuse)(void * dbproc, char * dbname);
extern PACKAGE int __cdecl (*dbvarylen)(void * dbproc, int column);
extern PACKAGE int __cdecl (*dbwillconvert)(int srctype, int desttype);
extern PACKAGE int __cdecl (*dbwritetext)(void * dbproc, char * objname, LPDBBINARY textptr, Byte textptrlen
	, LPDBBINARY timestamp, int log, int size, char * text);
extern PACKAGE int __cdecl (*dbupdatetext)(void * dbproc, char * dest_object, LPDBBINARY dest_textptr
	, LPDBBINARY dest_timestamp, int update_type, int insert_offset, int delete_length, char * src_object
	, int src_size, LPDBBINARY src_text);
extern PACKAGE TDBERRHANDLE_PROC __cdecl (*dberrhandle)(TDBERRHANDLE_PROC handler);
extern PACKAGE TDBMSGHANDLE_PROC __cdecl (*dbmsghandle)(TDBMSGHANDLE_PROC handler);
extern PACKAGE TDBERRHANDLE_PROC __cdecl (*dbprocerrhandle)(void * dbproc, TDBERRHANDLE_PROC handler
	);
extern PACKAGE TDBMSGHANDLE_PROC __cdecl (*dbprocmsghandle)(void * dbproc, TDBMSGHANDLE_PROC handler
	);
#define DefSqlApiDLL "NTWDBLIB.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdmss */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdmss;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDMss
