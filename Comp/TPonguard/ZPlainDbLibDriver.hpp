// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainDbLibDriver.pas' rev: 5.00

#ifndef ZPlainDbLibDriverHPP
#define ZPlainDbLibDriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplaindblibdriver
{
//-- type declarations -------------------------------------------------------
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

#pragma pack(push, 1)
struct DBDATETIM4
{
	Word numdays;
	Word nummins;
} ;
#pragma pack(pop)

typedef DBDATETIM4 *PDBDATETIM4;

#pragma pack(push, 1)
struct DBVARYCHAR
{
	short Len;
	char Str[256];
} ;
#pragma pack(pop)

#pragma pack(push, 1)
struct DBVARYBIN
{
	short Len;
	Byte Bytes[256];
} ;
#pragma pack(pop)

#pragma pack(push, 1)
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

typedef DBDATETIME *PDBDATETIME;

#pragma pack(push, 1)
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

typedef DBDATEREC *PDBDATEREC;

#pragma pack(push, 1)
struct DBNUMERIC
{
	Byte Precision;
	Byte Scale;
	Byte Sign;
	Byte Val[16];
} ;
#pragma pack(pop)

typedef DBNUMERIC  DBDECIMAL;

#pragma pack(push, 1)
struct DBCOL
{
	int SizeOfStruct;
	char Name[31];
	char ActualName[31];
	char TableName[31];
	Byte X1;
	short Typ;
	int UserType;
	int MaxLength;
	Byte Precision;
	Byte Scale;
	BOOL VarLength;
	Byte Null;
	Byte CaseSensitive;
	Byte Updatable;
	BOOL Identity;
	Byte X2;
} ;
#pragma pack(pop)

typedef DBCOL *PDBCOL;

#pragma pack(push, 1)
struct DBPROC_INFO
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

typedef DBPROC_INFO *PDBPROCINFO;

#pragma pack(push, 1)
struct DBCURSOR_INFO
{
	int SizeOfStruct;
	unsigned TotCols;
	unsigned TotRows;
	unsigned CurRow;
	unsigned TotRowsFetched;
	unsigned CurType;
	unsigned Status;
} ;
#pragma pack(pop)

typedef DBCURSOR_INFO *PDBCURSORINFO;

typedef int *PDBINT;

typedef Byte *PDBBINARY;

struct TDBLibError;
typedef TDBLibError *PDBLibError;

struct TDBLibError
{
	void *dbProc;
	int Severity;
	int DbErr;
	int OsErr;
	AnsiString DbErrStr;
	AnsiString OsErrStr;
} ;

struct TDBLibMessage;
typedef TDBLibMessage *PDBLibMessage;

struct TDBLibMessage
{
	void *dbProc;
	int MsgNo;
	int MsgState;
	int Severity;
	AnsiString MsgText;
	AnsiString SrvName;
	AnsiString ProcName;
	Word Line;
} ;

__interface IZDBLibPlainDriver;
typedef System::DelphiInterface<IZDBLibPlainDriver> _di_IZDBLibPlainDriver;
__interface INTERFACE_UUID("{7731C3B4-0608-4B6B-B089-240AC43A3463}") IZDBLibPlainDriver  : public IZPlainDriver 
	
{
	
public:
	virtual void __fastcall CheckError(void) = 0 ;
	virtual bool __fastcall dbDead(void * dbProc) = 0 ;
	virtual void * __fastcall dbLogin(void) = 0 ;
	virtual void __fastcall dbLoginFree(void * Login) = 0 ;
	virtual int __fastcall dbSetLoginTime(int Seconds) = 0 ;
	virtual int __fastcall dbsetLName(void * Login, char * Value, int Item) = 0 ;
	virtual int __fastcall dbSetLHost(void * Login, char * HostName) = 0 ;
	virtual int __fastcall dbSetLUser(void * Login, char * UserName) = 0 ;
	virtual int __fastcall dbSetLPwd(void * Login, char * Password) = 0 ;
	virtual int __fastcall dbSetLApp(void * Login, char * AppName) = 0 ;
	virtual int __fastcall dbSetLNatLang(void * Login, char * NatLangName) = 0 ;
	virtual int __fastcall dbSetLCharSet(void * Login, char * CharsetName) = 0 ;
	virtual int __fastcall dbSetLSecure(void * Login) = 0 ;
	virtual int __fastcall dbSetMaxprocs(short MaxProcs) = 0 ;
	virtual void * __fastcall dbOpen(void * Login, char * Host) = 0 ;
	virtual int __fastcall dbCancel(void * dbProc) = 0 ;
	virtual int __fastcall dbCmd(void * dbProc, char * Cmd) = 0 ;
	virtual int __fastcall dbSqlExec(void * dbProc) = 0 ;
	virtual int __fastcall dbResults(void * dbProc) = 0 ;
	virtual int __fastcall dbCanQuery(void * dbProc) = 0 ;
	virtual int __fastcall dbMoreCmds(void * dbProc) = 0 ;
	virtual int __fastcall dbUse(void * dbProc, char * dbName) = 0 ;
	virtual int __fastcall dbSetOpt(void * dbProc, int Option, char * Char_Param, int Int_Param) = 0 ;
	virtual int __fastcall dbClose(void * dbProc) = 0 ;
	virtual char * __fastcall dbName(void * dbProc) = 0 ;
	virtual int __fastcall dbCmdRow(void * dbProc) = 0 ;
	virtual int __fastcall dbNumCols(void * dbProc) = 0 ;
	virtual char * __fastcall dbColName(void * dbProc, int Column) = 0 ;
	virtual int __fastcall dbColType(void * dbProc, int Column) = 0 ;
	virtual int __fastcall dbColLen(void * dbProc, int Column) = 0 ;
	virtual Zcompatibility::PByte __fastcall dbData(void * dbProc, int Column) = 0 ;
	virtual int __fastcall dbDatLen(void * dbProc, int Column) = 0 ;
	virtual int __fastcall dbConvert(void * dbProc, int SrcType, Zcompatibility::PByte Src, int SrcLen, 
		int DestType, Zcompatibility::PByte Dest, int DestLen) = 0 ;
	virtual int __fastcall dbNextRow(void * dbProc) = 0 ;
	virtual int __fastcall dbGetRow(void * dbProc, int Row) = 0 ;
	virtual int __fastcall dbCount(void * dbProc) = 0 ;
	virtual int __fastcall dbRpcInit(void * dbProc, char * RpcName, short Options) = 0 ;
	virtual int __fastcall dbRpcParam(void * dbProc, char * ParamName, Byte Status, int Type_, int MaxLen
		, int DataLen, void * Value) = 0 ;
	virtual int __fastcall dbRpcSend(void * dbProc) = 0 ;
	virtual int __fastcall dbRpcExec(void * dbProc) = 0 ;
	virtual int __fastcall dbRetStatus(void * dbProc) = 0 ;
	virtual bool __fastcall dbHasRetStat(void * dbProc) = 0 ;
	virtual char * __fastcall dbRetName(void * dbProc, int RetNum) = 0 ;
	virtual void * __fastcall dbRetData(void * dbProc, int RetNum) = 0 ;
	virtual int __fastcall dbRetLen(void * dbProc, int RetNum) = 0 ;
	virtual int __fastcall dbRetType(void * dbProc, int RetNum) = 0 ;
};

class DELPHICLASS TZDBLibSybaseASE125PlainDriver;
class PASCALIMPLEMENTATION TZDBLibSybaseASE125PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZDBLibSybaseASE125PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void __fastcall CheckError(void);
	bool __fastcall dbDead(void * dbProc);
	void * __fastcall dbLogin(void);
	void __fastcall dbLoginFree(void * Login);
	int __fastcall dbSetLoginTime(int Seconds);
	int __fastcall dbsetLName(void * Login, char * Value, int Item);
	int __fastcall dbSetLHost(void * Login, char * HostName);
	int __fastcall dbSetLUser(void * Login, char * UserName);
	int __fastcall dbSetLPwd(void * Login, char * Password);
	int __fastcall dbSetLApp(void * Login, char * AppName);
	int __fastcall dbSetLNatLang(void * Login, char * NatLangName);
	int __fastcall dbSetLCharSet(void * Login, char * CharsetName);
	int __fastcall dbSetLSecure(void * Login);
	int __fastcall dbSetMaxprocs(short MaxProcs);
	void * __fastcall dbOpen(void * Login, char * Host);
	int __fastcall dbCancel(void * dbProc);
	int __fastcall dbCmd(void * dbProc, char * Cmd);
	int __fastcall dbSqlExec(void * dbProc);
	int __fastcall dbResults(void * dbProc);
	int __fastcall dbCanQuery(void * dbProc);
	int __fastcall dbMoreCmds(void * dbProc);
	int __fastcall dbUse(void * dbProc, char * dbName);
	int __fastcall dbSetOpt(void * dbProc, int Option, char * Char_Param, int Int_Param);
	int __fastcall dbClose(void * dbProc);
	char * __fastcall dbName(void * dbProc);
	int __fastcall dbCmdRow(void * dbProc);
	int __fastcall dbNumCols(void * dbProc);
	char * __fastcall dbColName(void * dbProc, int Column);
	int __fastcall dbColType(void * dbProc, int Column);
	int __fastcall dbColLen(void * dbProc, int Column);
	Zcompatibility::PByte __fastcall dbData(void * dbProc, int Column);
	int __fastcall dbDatLen(void * dbProc, int Column);
	int __fastcall dbConvert(void * dbProc, int SrcType, Zcompatibility::PByte Src, int SrcLen, int DestType
		, Zcompatibility::PByte Dest, int DestLen);
	int __fastcall dbNextRow(void * dbProc);
	int __fastcall dbGetRow(void * dbProc, int Row);
	int __fastcall dbCount(void * dbProc);
	int __fastcall dbRpcInit(void * dbProc, char * RpcName, short Options);
	int __fastcall dbRpcParam(void * dbProc, char * ParamName, Byte Status, int Type_, int MaxLen, int 
		DataLen, void * Value);
	int __fastcall dbRpcSend(void * dbProc);
	int __fastcall dbRpcExec(void * dbProc);
	int __fastcall dbRetStatus(void * dbProc);
	bool __fastcall dbHasRetStat(void * dbProc);
	char * __fastcall dbRetName(void * dbProc, int RetNum);
	void * __fastcall dbRetData(void * dbProc, int RetNum);
	int __fastcall dbRetLen(void * dbProc, int RetNum);
	int __fastcall dbRetType(void * dbProc, int RetNum);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZDBLibSybaseASE125PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZDBLibPlainDriver;	/* Zplaindblibdriver::IZDBLibPlainDriver */
	
public:
	operator IZDBLibPlainDriver*(void) { return (IZDBLibPlainDriver*)&__IZDBLibPlainDriver; }
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZDBLibPlainDriver; }
	
};


class DELPHICLASS TZDBLibMSSQL7PlainDriver;
class PASCALIMPLEMENTATION TZDBLibMSSQL7PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZDBLibMSSQL7PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	void __fastcall CheckError(void);
	bool __fastcall dbDead(void * dbProc);
	void * __fastcall dbLogin(void);
	void __fastcall dbLoginFree(void * Login);
	int __fastcall dbSetLoginTime(int Seconds);
	int __fastcall dbsetLName(void * Login, char * Value, int Item);
	int __fastcall dbSetLHost(void * Login, char * HostName);
	int __fastcall dbSetLUser(void * Login, char * UserName);
	int __fastcall dbSetLPwd(void * Login, char * Password);
	int __fastcall dbSetLApp(void * Login, char * AppName);
	int __fastcall dbSetLNatLang(void * Login, char * NatLangName);
	int __fastcall dbSetLCharSet(void * Login, char * CharsetName);
	int __fastcall dbSetLSecure(void * Login);
	int __fastcall dbSetMaxprocs(short MaxProcs);
	void * __fastcall dbOpen(void * Login, char * Host);
	int __fastcall dbCancel(void * dbProc);
	int __fastcall dbCmd(void * dbProc, char * Cmd);
	int __fastcall dbSqlExec(void * dbProc);
	int __fastcall dbResults(void * dbProc);
	int __fastcall dbCanQuery(void * dbProc);
	int __fastcall dbMoreCmds(void * dbProc);
	int __fastcall dbUse(void * dbProc, char * dbName);
	int __fastcall dbSetOpt(void * dbProc, int Option, char * Char_Param, int Int_Param);
	int __fastcall dbClose(void * dbProc);
	char * __fastcall dbName(void * dbProc);
	int __fastcall dbCmdRow(void * dbProc);
	int __fastcall dbNumCols(void * dbProc);
	char * __fastcall dbColName(void * dbProc, int Column);
	int __fastcall dbColType(void * dbProc, int Column);
	int __fastcall dbColLen(void * dbProc, int Column);
	Zcompatibility::PByte __fastcall dbData(void * dbProc, int Column);
	int __fastcall dbDatLen(void * dbProc, int Column);
	int __fastcall dbConvert(void * dbProc, int SrcType, Zcompatibility::PByte Src, int SrcLen, int DestType
		, Zcompatibility::PByte Dest, int DestLen);
	int __fastcall dbNextRow(void * dbProc);
	int __fastcall dbGetRow(void * dbProc, int Row);
	int __fastcall dbCount(void * dbProc);
	int __fastcall dbRpcInit(void * dbProc, char * RpcName, short Options);
	int __fastcall dbRpcParam(void * dbProc, char * ParamName, Byte Status, int Type_, int MaxLen, int 
		DataLen, void * Value);
	int __fastcall dbRpcSend(void * dbProc);
	int __fastcall dbRpcExec(void * dbProc);
	int __fastcall dbRetStatus(void * dbProc);
	bool __fastcall dbHasRetStat(void * dbProc);
	char * __fastcall dbRetName(void * dbProc, int RetNum);
	void * __fastcall dbRetData(void * dbProc, int RetNum);
	int __fastcall dbRetLen(void * dbProc, int RetNum);
	int __fastcall dbRetType(void * dbProc, int RetNum);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZDBLibMSSQL7PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZDBLibPlainDriver;	/* Zplaindblibdriver::IZDBLibPlainDriver */
	
public:
	operator IZDBLibPlainDriver*(void) { return (IZDBLibPlainDriver*)&__IZDBLibPlainDriver; }
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZDBLibPlainDriver; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const unsigned TIMEOUT_IGNORE = 0xffffffff;
static const Shortint TIMEOUT_INFINITE = 0x0;
static const Word TIMEOUT_MAXIMUM = 0x4b0;
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
static const Shortint DBFAIL = 0x0;
static const Shortint DBSUCCEED = 0x1;
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
static const Shortint DBANSITOOEM = 0xe;
static const Shortint DBOEMTOANSI = 0xf;
static const Shortint DBCLIENTCURSORS = 0x10;
static const Shortint DBSET_TIME = 0x11;
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
static const Shortint MAXNUMERICLEN = 0x10;
static const Shortint MAXNUMERICDIG = 0x26;
static const Shortint DEFAULTPRECISION = 0x12;
static const Shortint DEFAULTSCALE = 0x0;
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
static const Word DBMAXCHAR = 0x100;
static const Shortint MAXCOLNAMELEN = 0x1e;
static const Shortint MAXTABLENAME = 0x1e;
static const Shortint MAXSERVERNAME = 0x1e;
static const Byte MAXNETLIBNAME = 0xff;
static const Byte MAXNETLIBCONNSTR = 0xff;
static const unsigned INVALID_UROWNUM = 0xffffffff;

}	/* namespace Zplaindblibdriver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaindblibdriver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainDbLibDriver
