// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDCSb.pas' rev: 4.00

#ifndef SDCSbHPP
#define SDCSbHPP

#pragma delphiheader begin
#pragma option push -w-
#include <SDConsts.hpp>	// Pascal unit
#include <SDCommon.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdcsb
{
//-- type declarations -------------------------------------------------------
typedef Shortint byte1;

typedef Byte ubyte1;

typedef short byte2;

typedef Word ubyte2;

typedef int byte4;

typedef int ubyte4;

typedef void *ubyte1p;

typedef Word SqlTApi;

typedef void *SqlTPfp;

typedef Byte SqlTARC;

typedef Byte SqlTBNL;

typedef Byte SqlTBNN;

typedef void *SqlTBNP;

typedef short SqlTNUL;

typedef Byte SqlTBOO;

typedef Byte SqlTCDL;

typedef Byte SqlTCHL;

typedef Byte SqlTCHO;

typedef void *SqlTCHP;

typedef Word SqlTCLL;

typedef Byte SqlTCTY;

typedef Word SqlTCUR;

typedef Word SqlTDAL;

typedef void *SqlTDAP;

typedef short SqlTDAY;

typedef Byte SqlTDDL;

typedef Byte SqlTDDT;

typedef Word SqlTDEDL;

typedef Word SqlTDPT;

typedef int SqlTDPV;

typedef Word SqlTEPO;

typedef Word SqlTFAT;

typedef Word SqlTFLD;

typedef Word SqlTFLG;

typedef int SqlTFLH;

typedef short SqlTFMD;

typedef Word SqlTFNL;

typedef void *SqlTFNP;

typedef Byte SqlTFSC;

typedef void *SqlTILV;

typedef Byte SqlTLBL;

typedef void *SqlTLBP;

typedef int SqlTLNG;

typedef int SqlTLSI;

typedef Word SqlTMSZ;

typedef Byte SqlTNBV;

typedef Word SqlTNCU;

typedef Byte SqlTNML;

typedef void *SqlTNMP;

typedef Word SqlTNPG;

typedef Byte SqlTNSI;

typedef Byte SqlTPCX;

typedef Byte SqlTPDL;

typedef Byte SqlTPDT;

typedef int SqlTPGN;

typedef Word SqlTPNM;

typedef Byte SqlTPRE;

typedef Word SqlTPTY;

typedef Byte SqlTRBF;

typedef short SqlTRCD;

typedef Byte SqlTRCF;

typedef Word SqlTRFM;

typedef int SqlTROW;

typedef Byte SqlTSCA;

typedef Byte SqlTSLC;

typedef Word SqlTSTC;

typedef Word SqlTSVH;

typedef Word SqlTSVN;

typedef short SqlTTIV;

typedef short SqlTWNC;

typedef Word SqlTWSI;

typedef Word SqlTBIR;

typedef void *SqlTDIS;

typedef int SqlTXER;

typedef int SqlTPID;

typedef int SQLTMOD;

typedef int SQLTCON;

#pragma pack(push, 4)
struct TGdiDefx
{
	char gdifl1[31];
	Byte gdifl2;
	char gdilbb[31];
	Byte gdilbl;
	Byte gdicol;
	Byte gdiddt;
	Word gdiddl;
	Byte gdiedt;
	Word gdiedl;
	Byte gdipre;
	Byte gdisca;
	short gdinul;
	char gdichb[47];
	Byte gdichl;
	Shortint gdifil[2];
} ;
#pragma pack(pop)

typedef TGdiDefx  TGdiDef;

typedef TGdiDefx  SQLTGDI;

typedef TGdiDefx *SQLPGD;

typedef Word *SqlTBirPtr;

typedef Byte *SqlTCdlPtr;

typedef Byte *SqlTChlPtr;

typedef Word *SqlTCurPtr;

typedef Word *SqlTDalPtr;

typedef Byte *SqlTDdlPtr;

typedef Byte *SqlTDdtPtr;

typedef int *SqlTFlhPtr;

typedef Byte *SqlTFscPtr;

typedef int *SqlTLngPtr;

typedef int *SQLTLSIPtr;

typedef Byte *SqlTNbvPtr;

typedef Byte *SqlTNmlPtr;

typedef Byte *SqlTNsiPtr;

typedef Word *SqlTPnmPtr;

typedef Byte *SqlTPrePtr;

typedef int *SqlTRowPtr;

typedef Byte *SqlTRbfPtr;

typedef short *SqlTRcdPtr;

typedef Byte *SqlTScaPtr;

typedef int *SqlTXerPtr;

#pragma pack(push, 4)
struct TCurDefxi
{
	int curcst;
	int curctp;
	int curcte;
	int curctf;
	Word curcur;
	char curcln[13];
	Byte cursta;
	char curcts[18];
	char currsv[2];
} ;
#pragma pack(pop)

typedef TCurDefxi  TCurDefi;

typedef TCurDefxi *PCurDefi;

#pragma pack(push, 4)
struct TCfgDefxi
{
	int cfgcmt[60];
	int cfgcon;
	int cfgdis;
	int cfgtps;
	int cfgelp;
	int cfgslp;
	int cfgulp;
	int cfgdlk;
	int cfgsrt;
	int cfghjn;
	int cfgctp;
	int cfgcte;
	int cfgctf;
	char cfgsbt[26];
	char cfgpfs[21];
	char cfgver[20];
	Byte cfgonl;
	int cfgszp;
} ;
#pragma pack(pop)

typedef TCfgDefxi  TCfgDefi;

typedef TCfgDefxi *PCfgDefi;

#pragma pack(push, 4)
struct TPrcDefxi
{
	int prcsel;
	int prcins;
	int prcupd;
	int prcdel;
	int prctps;
	int prcdlk;
	int prcelp;
	int prcslp;
	int prculp;
	int prcast;
	int prcptp;
	int prcpte;
	int prcptf;
	int prcmtt;
	char prcpss[26];
	char prccln[13];
	Byte prcsta;
	char prcpts[20];
	Byte prciso;
	int prctmo;
	char prcrsv[27];
} ;
#pragma pack(pop)

typedef TPrcDefxi  TPrcDefi;

typedef TPrcDefxi *PPrcDefi;

#pragma pack(push, 1)
struct TDbsDefxi
{
	char dbspnm[7][9];
	Byte dbsshd;
	Byte dbslck;
	char dbsrsv[63];
} ;
#pragma pack(pop)

typedef TDbsDefxi  TDbsDefi;

typedef TDbsDefxi *PDbsDefi;

#pragma pack(push, 4)
struct TLckDefx
{
	char lckdbs[9];
	Byte lckpnm;
	Word lcklpg;
	Word lckhpg;
	int lckgrp;
	Byte lckmod;
	Byte lckuse;
} ;
#pragma pack(pop)

typedef TLckDefx  TLckDef;

typedef TLckDefx *PLckDef;

#pragma pack(push, 1)
struct TFgiDefx
{
	Byte fgipnm;
	char fgicln[13];
	char fgiunb[19];
	char fgidbn[9];
} ;
#pragma pack(pop)

typedef TFgiDefx  TFgiDef;

typedef TFgiDefx *PFgiDef;

#pragma pack(push, 4)
struct TOStDefx
{
	Byte ostsar;
	Byte ostaws;
	Byte ostcpu;
	Byte ostacp;
	Byte ostpac;
	int ostmpa;
	int ostmvt;
	int ostmst;
	int ostmlt;
	int ostdpr;
	int ostdpw;
	int ostbpr;
	int ostbpw;
	int ostdvr;
	int ostdvw;
	int ostbvr;
	int ostbvw;
	int ostnpt;
	int ostnpr;
	int ostprt;
	char ostrsv[3];
} ;
#pragma pack(pop)

typedef TOStDefx  TOStDef;

typedef TOStDefx *POStDef;

#pragma pack(push, 4)
struct THdrDefx
{
	Word hdrlen;
	Word hdrrsv;
} ;
#pragma pack(pop)

typedef THdrDefx  THdrDef;

typedef THdrDefx *PHdrDef;

#pragma pack(push, 4)
struct TMshDefx
{
	Word mshflg;
	Word mshten;
	Word mshnen;
	Word mshlen;
} ;
#pragma pack(pop)

typedef TMshDefx  TMshDef;

typedef TMshDefx *PMshDef;

#pragma pack(push, 4)
struct TCurDefx
{
	int currow;
	Word curibl;
	Word curobl;
	Word curspr;
	Word curspw;
	Word cursvr;
	Word cursvw;
	Byte curtyp;
	Byte curpnm;
	char curiso[3];
	char curunb[19];
	char curdbn[9];
	char currsv[3];
} ;
#pragma pack(pop)

typedef TCurDefx  TCurDef;

typedef TCurDefx *PCurDef;

#pragma pack(push, 4)
struct TDbsDefx
{
	int dbsbfs;
	int dbsbwp;
	int dbsdfs;
	int dbsfrp;
	int dbsfup;
	int dbslpa;
	int dbslpm;
	int dbslpt;
	int dbslpw;
	int dbsltp;
	int dbsltw;
	Byte dbsuse;
	Byte dbsnat;
	Byte dbsntr;
	char dbsfnm[9];
} ;
#pragma pack(pop)

typedef TDbsDefx  TDbsDef;

typedef TDbsDefx *PDbsDef;

#pragma pack(push, 4)
struct TCfgDefx
{
	int cfgwsa;
	int cfgwsl;
	Word cfgnlk;
	Word cfgnpg;
	Word cfgcnc;
	char cfgsvn[9];
	Byte cfgrsv;
} ;
#pragma pack(pop)

typedef TCfgDefx  TCfgDef;

typedef TCfgDefx *PCfgDef;

#pragma pack(push, 4)
struct TSttDefx
{
	int sttspr;
	int sttspw;
	int sttsvr;
	int sttsvw;
	int sttnps;
} ;
#pragma pack(pop)

typedef TSttDefx  TSttDef;

typedef TSttDefx *PSttDef;

#pragma pack(push, 4)
struct TPrcDefx
{
	Word prccol;
	Word prcibl;
	Word prcinl;
	Word prcobl;
	Word prcoul;
	Byte prcpnm;
	Byte prcact;
} ;
#pragma pack(pop)

typedef TPrcDefx  TPrcDef;

typedef TPrcDefx *PPrcDef;

typedef int TCSBLogon;

typedef Word TCSBCursor;

typedef Word TCSBSrvCursor;

class DELPHICLASS ESDCSBError;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION ESDCSBError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDCSBError(int AErrorCode, int ANativeError, const AnsiString 
		Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDCSBError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDCSBError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDCSBError(int Ident, Extended Dummy) : Sdcommon::ESDEngineError(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDCSBError(int Ident, const System::TVarRec * Args, 
		const int Args_Size) : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDCSBError(const AnsiString Msg, int AHelpContext) : 
		Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDCSBError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDCSBError(int Ident, int AHelpContext) : Sdcommon::ESDEngineError(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDCSBError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDCSBError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

#pragma pack(push, 1)
struct TICsbConnInfo
{
	Byte ServerType;
	int hLogon;
	Word hCursor;
	AnsiString ConnectStr;
} ;
#pragma pack(pop)

class DELPHICLASS TICsbDatabase;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TICsbDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	bool FIsTransLogging;
	void __fastcall Check(short Status);
	void __fastcall AllocHandle(void);
	void __fastcall FreeHandle(void);
	void __fastcall ChangePreservedProps(void);
	AnsiString __fastcall GetConnectStr(void);
	Word __fastcall GetCurHandle(void);
	int __fastcall GetLogHandle(void);
	void __fastcall SetNullIndicatorError(bool Value);
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
	__fastcall virtual TICsbDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TICsbDatabase(void);
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
	bool __fastcall UseConnHandle(void);
	__property AnsiString ConnectStr = {read=GetConnectStr};
	__property Word CurHandle = {read=GetCurHandle, nodefault};
	__property int LogHandle = {read=GetLogHandle, nodefault};
	__property bool IsTransLogging = {read=FIsTransLogging, nodefault};
};

#pragma pack(pop)

class DELPHICLASS TICsbCommand;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TICsbCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void *FHandle;
	bool FRowFetched;
	int FBlobPieceSize;
	HIDESBASE TICsbDatabase* __fastcall GetSqlDatabase(void);
	Word __fastcall GetCurHandle(void);
	void __fastcall Connect(void);
	void __fastcall ClearBindParams(void);
	Db::TDateTimeRec __fastcall CnvtDBDateTime2DateTimeRec(Db::TFieldType ADataType, void * Buffer, int 
		BufSize);
	AnsiString __fastcall DBDateTimeFormat(Db::TFieldType ADataType);
	int __fastcall DBDateTimeStrLen(Db::TFieldType ADataType);
	void __fastcall SetDefaultParams(void);
	void __fastcall SetPreservation(bool Value);
	void __fastcall QBindParamsBuffer(void);
	void __fastcall SpBindParamsBuffer(void);
	void __fastcall SpGetOutputParams(void);
	
protected:
	void __fastcall Check(short Status);
	void __fastcall CheckPrepared(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * 
		Buffer, int BufSize);
	virtual void __fastcall InitParamList(void);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual void __fastcall FreeParamsBuffer(void);
	virtual void __fastcall DoExecute(void);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void __fastcall SetFieldsBuffer(void);
	
public:
	__fastcall virtual TICsbCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TICsbCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize
		);
	virtual void __fastcall GetOutputParams(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	virtual int __fastcall WriteBlob(int FieldNo, const char * Buffer, int Count);
	virtual int __fastcall WriteBlobByName(AnsiString Name, const char * Buffer, int Count);
	__property Word CurHandle = {read=GetCurHandle, nodefault};
	__property TICsbDatabase* SqlDatabase = {read=GetSqlDatabase};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const Shortint FetchOk = 0x0;
static const Shortint FetchEof = 0x1;
static const Shortint FetchUpd = 0x2;
static const Shortint FetchDel = 0x3;
static const Shortint FetRTru = 0x1;
static const Shortint FetRSin = 0x2;
static const Shortint FetRDnn = 0x3;
static const Shortint FetRNof = 0x4;
static const Shortint FetRDtn = 0x5;
static const Shortint FetRDnd = 0x6;
static const Shortint FetRNul = 0x7;
static const Shortint SqlDChr = 0x1;
static const Shortint SqlDNum = 0x2;
static const Shortint SqlDDat = 0x3;
static const Shortint SqlDLon = 0x4;
static const Shortint SqlDDte = 0x5;
static const Shortint SqlDTim = 0x6;
static const Shortint SqlDHdl = 0x7;
static const Shortint SqlDBoo = 0x8;
static const Shortint SqlDDtm = 0x8;
static const Shortint SqlPBuf = 0x1;
static const Shortint SqlPStr = 0x2;
static const Shortint SqlPUch = 0x3;
static const Shortint SqlPSch = 0x4;
static const Shortint SqlPUin = 0x5;
static const Shortint SqlPSin = 0x6;
static const Shortint SqlPUlo = 0x7;
static const Shortint SqlPSlo = 0x8;
static const Shortint SqlPFlt = 0x9;
static const Shortint SqlPDou = 0xa;
static const Shortint SqlPNum = 0xb;
static const Shortint SqlPDat = 0xc;
static const Shortint SqlPUpd = 0xd;
static const Shortint SqlPSpd = 0xe;
static const Shortint SqlPDte = 0xf;
static const Shortint SqlPTim = 0x10;
static const Shortint SqlPUsh = 0x11;
static const Shortint SqlPSsh = 0x12;
static const Shortint SqlPNst = 0x13;
static const Shortint SqlPNbu = 0x14;
static const Shortint SqlPEbc = 0x15;
static const Shortint SqlPLon = 0x16;
static const Shortint SqlPLbi = 0x17;
static const Shortint SqlPLvr = 0x18;
static const Shortint SqlPDtm = 0x18;
static const Shortint SqlEInt = 0x1;
static const Shortint SqlESma = 0x2;
static const Shortint SqlEFlo = 0x3;
static const Shortint SqlEChr = 0x4;
static const Shortint SqlEVar = 0x5;
static const Shortint SqlELon = 0x6;
static const Shortint SqlEDec = 0x7;
static const Shortint SqlEDat = 0x8;
static const Shortint SqlETim = 0x9;
static const Shortint SqlETms = 0xa;
static const Shortint SqlEMon = 0xb;
static const Shortint SqlEDou = 0xc;
static const Shortint SqlEGph = 0xd;
static const Shortint SqlEVgp = 0xe;
static const Shortint SqlELgp = 0xf;
static const Shortint SqlEBin = 0x10;
static const Shortint SqlEVbi = 0x11;
static const Shortint SqlELbi = 0x12;
static const Shortint SqlEBoo = 0x13;
static const Shortint SqlELch = 0x14;
static const Shortint SqlELvr = 0x15;
static const Shortint SQLPDDB = 0x1;
static const Shortint SQLPDUS = 0x2;
static const Shortint SQLPDPW = 0x3;
static const Shortint SQLPGBC = 0x4;
static const Shortint SQLPLRD = 0x5;
static const Shortint SQLPDBM = 0x6;
static const Shortint SQLPDBD = 0x7;
static const Shortint SQLPCPG = 0x8;
static const Shortint SQLPNIE = 0x9;
static const Shortint SQLPCPT = 0xa;
static const Shortint SQLPTPD = 0xb;
static const Shortint SQLPDTR = 0xc;
static const Shortint SQLPPSW = 0xf;
static const Shortint SQLPOOJ = 0x10;
static const Shortint SQLPNPF = 0x11;
static const Shortint SQLPNLG = 0x12;
static const Shortint SQLPNCT = 0x13;
static const Shortint SQLPNCK = 0x14;
static const Shortint SQLPLCK = 0x16;
static const Shortint SQLPINT = 0x19;
static const Shortint SQLPERF = 0x1b;
static const Shortint SQLPDIO = 0x1c;
static const Shortint SQLPSWR = 0x1d;
static const Shortint SQLPCTY = 0x1f;
static const Shortint SQLPCSD = 0x20;
static const Shortint SQLPCSR = 0x21;
static const Shortint SQLPCCK = 0x24;
static const Shortint SQLPCTS = 0x25;
static const Shortint SQLPCGR = 0x26;
static const Shortint SQLPAIO = 0x27;
static const Shortint SQLPANL = 0x28;
static const Shortint SQLPGRS = 0x29;
static const Shortint SQLPSTF = 0x2a;
static const Shortint SQLPCLG = 0x2b;
static const Word SQLPHEP = 0x3e9;
static const Word SQLPCAC = 0x3ea;
static const Word SQLPBRN = 0x3eb;
static const Word SQLPVER = 0x3ec;
static const Word SQLPPRF = 0x3ed;
static const Word SQLPPDB = 0x3ee;
static const Word SQLPGCM = 0x3ef;
static const Word SQLPGCD = 0x3f0;
static const Word SQLPDLK = 0x3f1;
static const Word SQLPCTL = 0x3f2;
static const Word SQLPAPT = 0x3f3;
static const Word SQLPOSR = 0x3f4;
static const Word SQLPAWS = 0x3f5;
static const Word SQLPWKL = 0x3f6;
static const Word SQLPWKA = 0x3f7;
static const Word SQLPUSR = 0x3f8;
static const Word SQLPTMO = 0x3f9;
static const Word SQLPTSS = 0x3fa;
static const Word SQLPTHM = 0x3fb;
static const Word SQLPSTC = 0x3fc;
static const Word SQLPSIL = 0x3fd;
static const Word SQLPSPF = 0x3fe;
static const Word SQLPSVN = 0x400;
static const Word SQLPROM = 0x401;
static const Word SQLPSTA = 0x402;
static const Word SQLPCSV = 0x403;
static const Word SQLPTTP = 0x404;
static const Word SQLPDBN = 0x7d1;
static const Word SQLPDDR = 0x7d2;
static const Word SQLPLDR = 0x7d3;
static const Word SQLPLFS = 0x7d4;
static const Word SQLPCTI = 0x7d5;
static const Word SQLPLBM = 0x7d6;
static const Word SQLPPLF = 0x7d7;
static const Word SQLPTSL = 0x7d8;
static const Word SQLPROT = 0x7d9;
static const Word SQLPHFS = 0x7da;
static const Word SQLPREC = 0x7db;
static const Word SQLPEXE = 0x7dc;
static const Word SQLPNLB = 0x7dd;
static const Word SQLPROD = 0x7de;
static const Word SQLPEXS = 0x7df;
static const Word SQLPPAR = 0x7e0;
static const Word SQLPNDB = 0x7e1;
static const Word SQLPLGF = 0x7e2;
static const Word SQLPDTL = 0x7e3;
static const Word SQLPSMN = 0x7e4;
static const Word SQLPCVC = 0x7e5;
static const Word SQLPDBS = 0x7e6;
static const Word SQLPUED = 0x7e7;
static const Word SQLPISO = 0xbb9;
static const Word SQLPWTO = 0xbba;
static const Word SQLPPCX = 0xbbb;
static const Word SQLPFRS = 0xbbc;
static const Word SQLPLDV = 0xbbd;
static const Word SQLPAUT = 0xbbe;
static const Word SQLPRTO = 0xbbf;
static const Word SQLPSCR = 0xbc0;
static const Word SQLPRES = 0xbc1;
static const Word SQLPFT = 0xbc2;
static const Word SQLPNPB = 0xbc3;
static const Word SQLPPWD = 0xbc4;
static const Word SQLPDB2 = 0xbc5;
static const Word SQLPREF = 0xbc6;
static const Word SQLPBLK = 0xbc7;
static const Word SQLPOBL = 0xbc8;
static const Word SQLPLFF = 0xbc9;
static const Word SQLPDIS = 0xbca;
static const Word SQLPCMP = 0xbcb;
static const Word SQLPCHS = 0xbcc;
static const Word SQLPOPL = 0xbcd;
static const Word SQLPRID = 0xbce;
static const Word SQLPEMT = 0xbcf;
static const Word SQLPCLN = 0xbd0;
static const Word SQLPLSS = 0xbd1;
static const Word SQLPEXP = 0xbd2;
static const Word SQLPCXP = 0xbd3;
static const Word SQLPOCL = 0xbd4;
static const Word SQLPTST = 0xbd5;
static const Word SQLP2PP = 0xbd6;
static const Word SQLPCLI = 0xbd7;
static const Word SQLPFNM = 0xbd8;
static const Word SQLPOVR = 0xbd9;
static const Word SQLPTFN = 0xbda;
static const Word SQLPTRC = 0xbdb;
static const Word SQLPTRF = 0xbdc;
static const Word SQLPCTF = 0xbdd;
static const Word SQLPMID = 0xbde;
static const Word SQLPAID = 0xbdf;
static const Word SQLPNID = 0xbe0;
static const Word SQLPUID = 0xbe1;
static const Word SQLPCIS = 0xbe2;
static const Word SQLPIMB = 0xbe3;
static const Word SQLPOMB = 0xbe4;
static const Word SQLPWFC = 0xbe5;
static const Word SQLPRFE = 0xbe6;
static const Word SQLPCUN = 0xbe7;
static const Word SQLPOFF = 0xbe8;
static const Word SQLPFAT = 0xfa0;
static const Word SQLPBRS = 0xfa1;
static const Word SQLPMUL = 0xfa2;
static const Word SQLPDMO = 0xfa3;
static const Word SQLPLOC = 0xfa4;
static const Word SQLPFPT = 0xfa5;
static const Word SQLPLAT = 0xfa6;
static const Word SQLPCAP = 0xfa7;
static const Word SQLPSCL = 0xfa8;
static const Word SQLPRUN = 0xfa9;
static const Word SQLPPLV = 0x1389;
static const Word SQLPALG = 0x138a;
static const Word SQLPTMS = 0x138b;
static const Word SQLPPTH = 0x138c;
static const Word SQLPTMZ = 0x138d;
static const Word SQLPTCO = 0x138e;
static const Shortint SQLBSQB = 0x1;
static const Shortint SQLBDB2 = 0x2;
static const Shortint SQLBDBM = 0x3;
static const Shortint SQLBORA = 0x4;
static const Shortint SQLBIGW = 0x5;
static const Shortint SQLBNTW = 0x6;
static const Shortint SQLBAS4 = 0x7;
static const Shortint SQLBSYB = 0x8;
static const Shortint SQLBDBC = 0x9;
static const Shortint SQLBALB = 0xa;
static const Shortint SQLBRDB = 0xb;
static const Shortint SQLBTDM = 0xc;
static const Shortint SQLBSDS = 0xd;
static const Shortint SQLBSES = 0xe;
static const Shortint SQLBING = 0xf;
static const Shortint SQLBSQL = 0x10;
static const Shortint SQLBDBA = 0x11;
static const Shortint SQLBDB4 = 0x12;
static const Shortint SQLBFUJ = 0x13;
static const Shortint SQLBSUP = 0x14;
static const Shortint SQLB204 = 0x15;
static const Shortint SQLBDAL = 0x16;
static const Shortint SQLBSHR = 0x17;
static const Shortint SQLBIOL = 0x18;
static const Shortint SQLBEDA = 0x19;
static const Shortint SQLBUDS = 0x1a;
static const Shortint SQLBMIM = 0x1b;
static const Shortint SQLBOR7 = 0x1c;
static const Shortint SQLBIOS = 0x1d;
static const Shortint SQLBIOD = 0x1e;
static const Shortint SQLBODB = 0x1f;
static const Shortint SQLBS10 = 0x20;
static const Shortint SQLBSE6 = 0x21;
static const Shortint SQLBOL6 = 0x22;
static const Shortint SQLBNSE = 0x23;
static const Shortint SQLBNOL = 0x24;
static const Shortint SQLBAPP = 0x63;
static const Shortint SqlSNum = 0xc;
static const Shortint SqlSDat = 0xc;
static const Shortint SqlSCda = 0x1a;
static const Shortint SqlSDte = 0xc;
static const Shortint SqlSCde = 0xa;
static const Shortint SqlSRid = 0x28;
static const Shortint SqlSTim = 0xc;
static const Shortint SqlSCti = 0xf;
static const Shortint SqlSFem = 0x64;
static const Shortint SqlSFes = 0x14;
static const Shortint SqlSTex = 0x5;
#define SQLNPTR (void *)(0x0)
static const Shortint SqlTSEL = 0x1;
static const Shortint SqlTINS = 0x2;
static const Shortint SqlTCTB = 0x3;
static const Shortint SqlTUPD = 0x4;
static const Shortint SqlTDEL = 0x5;
static const Shortint SqlTCIN = 0x6;
static const Shortint SqlTDIN = 0x7;
static const Shortint SqlTDTB = 0x8;
static const Shortint SqlTCMT = 0x9;
static const Shortint SqlTRBK = 0xa;
static const Shortint SqlTACO = 0xb;
static const Shortint SqlTDCO = 0xc;
static const Shortint SqlTRTB = 0xd;
static const Shortint SqlTRCO = 0xe;
static const Shortint SqlTMCO = 0xf;
static const Shortint SqlTGRP = 0x10;
static const Shortint SqlTGRD = 0x11;
static const Shortint SqlTGRC = 0x12;
static const Shortint SqlTGRR = 0x13;
static const Shortint SqlTREP = 0x14;
static const Shortint SqlTRED = 0x15;
static const Shortint SqlTREC = 0x16;
static const Shortint SqlTRER = 0x17;
static const Shortint SqlTCOM = 0x18;
static const Shortint SqlTWAI = 0x19;
static const Shortint SqlTPOS = 0x1a;
static const Shortint SqlTCSY = 0x1b;
static const Shortint SqlTDSY = 0x1c;
static const Shortint SqlTCVW = 0x1d;
static const Shortint SqlTDVW = 0x1e;
static const Shortint SqlTRCT = 0x1f;
static const Shortint SqlTAPW = 0x20;
static const Shortint SqlTLAB = 0x21;
static const Shortint SqlTCHN = 0x22;
static const Shortint SqlTRPT = 0x23;
static const Shortint SqlTSVP = 0x24;
static const Shortint SqlTRBS = 0x25;
static const Shortint SqlTUDS = 0x26;
static const Shortint SqlTCDB = 0x27;
static const Shortint SqlTFRN = 0x28;
static const Shortint SqlTAPK = 0x29;
static const Shortint SqlTAFK = 0x2a;
static const Shortint SqlTDPK = 0x2b;
static const Shortint SqlTDFK = 0x2c;
static const Shortint SqlTCDA = 0x2d;
static const Shortint SqlTADA = 0x2e;
static const Shortint SqlTDDA = 0x2f;
static const Shortint SqlTCSG = 0x30;
static const Shortint SqlTASG = 0x31;
static const Shortint SqlTDSG = 0x32;
static const Shortint SqlTCRD = 0x33;
static const Shortint SqlTADB = 0x34;
static const Shortint SqlTDDB = 0x35;
static const Shortint SqlTSDS = 0x36;
static const Shortint SqlTIND = 0x37;
static const Shortint SqlTDED = 0x38;
static const Shortint SqlTARU = 0x39;
static const Shortint SqlTDRU = 0x3a;
static const Shortint SqlTMRU = 0x3b;
static const Shortint SqlTSCL = 0x3c;
static const Shortint SqlTCKT = 0x3d;
static const Shortint SqlTCKI = 0x3e;
static const Shortint SqlTOPL = 0x3f;
static const Shortint SqlTBGT = 0x40;
static const Shortint SqlTPRT = 0x41;
static const Shortint SqlTCXN = 0x42;
static const Shortint SqlTRXN = 0x43;
static const Shortint SqlTENT = 0x44;
static const Shortint SqlTCBT = 0x45;
static const Shortint SqlTCCT = 0x46;
static const Shortint SqlTCET = 0x47;
static const Shortint SqlTCPT = 0x48;
static const Shortint SqlTCRT = 0x49;
static const Shortint SqlTCST = 0x4a;
static const Shortint SqlTCRX = 0x4b;
static const Shortint SqlTCSD = 0x4c;
static const Shortint SqlTCTD = 0x4d;
static const Shortint SqlTCRA = 0x4e;
static const Shortint SqlTCRO = 0x4f;
static const Shortint SqlTCOT = 0x50;
static const Shortint SqlTCFL = 0x51;
static const Shortint SqlTDFL = 0x52;
static const Shortint SqlTSTN = 0x53;
static const Shortint SqlTSTF = 0x54;
static const Shortint SqlTUNL = 0x55;
static const Shortint SqlTLDP = 0x56;
static const Shortint SqlTPRO = 0x57;
static const Shortint SqlTGEP = 0x58;
static const Shortint SqlTREE = 0x59;
static const Shortint SqlTTGC = 0x5a;
static const Shortint SqlTTGD = 0x5b;
static const Shortint SqlTVNC = 0x5c;
static const Shortint SqlTVND = 0x5d;
static const Shortint SqlTSTR = 0x5e;
static const Shortint SqlTAUD = 0x5f;
static const Shortint SqlTSTP = 0x60;
static const Shortint SqlTACM = 0x61;
static const Shortint SqlTXDL = 0x62;
static const Shortint SqlTXDU = 0x63;
#define SQLILRR "RR"
#define SQLILCS "CS"
#define SQLILRO "RO"
#define SQLILRL "RL"
static const Shortint SQLFIRR = 0x1;
static const Shortint SQLFICS = 0x2;
static const Shortint SQLFIRO = 0x4;
static const Shortint SQLFIRL = 0x8;
static const Shortint SQLMEOL = 0x1;
static const Shortint SQLMEOB = 0x2;
static const Shortint SQLMTIM = 0x3;
static const Shortint SQLDELY = 0x0;
static const Shortint SQLDDLD = 0x1;
static const Shortint SQLDNVR = 0x2;
static const Shortint SQLXMSG = 0x1;
static const Shortint SQLXREA = 0x2;
static const Shortint SQLXREM = 0x4;
static const Shortint SQLANRM = 0x0;
static const Shortint SQLARDO = 0x1;
static const Shortint SQLAHDN = 0x2;
static const Shortint SQLASYS = 0x4;
static const Shortint SQLAVOL = 0x8;
static const Shortint SQLADIR = 0x10;
static const Shortint SQLAARC = 0x20;
static const Word SQLAFDL = 0x100;
static const Shortint SQLCIDL = 0x0;
static const Shortint SQLCECM = 0x1;
static const Shortint SQLCCCM = 0x2;
static const Shortint SQLCEXE = 0x3;
static const Shortint SQLCCXE = 0x4;
static const Shortint SQLCEFT = 0x5;
static const Shortint SQLCCFT = 0x6;
static const Shortint SQLMBNL = 0x12;
static const Word SQLMBSL = 0x7d00;
static const Word SQLMCG1 = 0x7fff;
static const Shortint SQLMCKF = 0x10;
static const Byte SQLMCLL = 0xff;
static const Shortint SQLMCLN = 0xc;
static const Byte SQLMCLP = 0x80;
static const Shortint SQLMCMT = 0x63;
static const Shortint SQLMCNM = 0x12;
static const Byte SQLMCOH = 0xff;
static const Word SQLMCST = 0x190;
static const Shortint SQLMDBA = 0xa;
static const Shortint SQLMDFN = 0x19;
static const Shortint SQLMPSS = 0x19;
static const Word SQLMDMO = 0x2ee;
static const Shortint SQLMDNM = 0x8;
static const Byte SQLMDVL = 0xfe;
static const Byte SQLMERR = 0xff;
static const Word SQLMETX = 0xbb8;
static const Byte SQLMFNL = 0x80;
static const Shortint SQLMFQN = 0x3;
static const Shortint SQLMFRD = 0x28;
static const Word SQLMGCM = 0x7fff;
static const Byte SQLMICO = 0xff;
static const Byte SQLMICU = 0xff;
static const Byte SQLMIDB = 0xff;
static const Word SQLMILK = 0x7fff;
static const Word SQLMINL = 0x7d0;
static const Word SQLMIPG = 0x7fff;
static const Word SQLMIPR = 0x320;
static const Word SQLMITR = 0x320;
static const Shortint SQLMJTB = 0x11;
static const Shortint SQLMLID = 0x20;
static const Word SQLMNBF = 0xea60;
static const Byte SQLMNCO = 0xfe;
static const Byte SQLMUCO = 0xfd;
static const Shortint SQLMNPF = 0x3;
static const Word SQLMOUL = 0x3e8;
static const Byte SQLMPAL = 0xff;
static const Shortint SQLMPFS = 0x15;
static const Shortint SQLMPRE = 0xf;
static const Shortint SQLMPTL = 0x4;
static const Byte SQLMPWD = 0x80;
static const Word SQLMCTL = 0xa8c0;
static const Word SQLMRBB = 0x2000;
static const Word SQLMRCB = 0x5000;
static const Word SQLMRET = 0x3e8;
static const Shortint SQLMRFH = 0x4;
static const Word SQLMROB = 0x2000;
static const Shortint SQLMSES = 0x10;
static const Shortint SQLMSID = 0x8;
static const Byte SQLMSLI = 0xff;
static const Shortint SQLMSNM = 0x8;
static const Shortint SQLMSRL = 0x20;
static const Byte SQLMSVN = 0xc7;
static const Shortint SQLMTFS = 0xa;
static const Byte SQLMTMO = 0xc8;
static const Word SQLMTSS = 0x100;
static const Byte SQLMUSR = 0x80;
static const Shortint SQLMVER = 0x8;
static const Byte SQLMXER = 0xff;
static const int SQLMXLF = 0x400000;
static const Shortint SQLMTHM = 0x2;
static const Byte SQLMPKL = 0xfe;
static const Byte SQLMGTI = 0xfa;
static const Shortint SQLMAUF = 0x20;
static const Shortint SQLMPNM = 0x8;
static const Byte SQLMOSR = 0xff;
static const Byte SQLMAWS = 0xff;
static const Shortint SQLMMID = 0x20;
static const Shortint SQLMCG0 = 0x1;
static const Word SQLMEXS = 0x400;
static const int SQLMLFE = 0x186a0;
static const int SQLMLFS = 0x186a0;
static const Shortint SQLMPAG = 0xf;
static const Shortint SQLMITM = 0x1;
static const Shortint SQLGLCK = 0x40;
static const Byte SQLGOSS = 0x80;
static const Word SQLRPNM = 0x100;
static const Word SQLRCLN = 0x200;
static const Word SQLRUSN = 0x400;
static const Word SQLRDBN = 0x800;
static const Word SQLXGSI = 0x8000;
static const Shortint SQLORDONLY = 0x0;
static const Shortint SQLOWRONLY = 0x1;
static const Shortint SQLORDWR = 0x2;
static const Shortint SQLOAPPEND = 0x8;
static const Word SQLOCREAT = 0x100;
static const Word SQLOTRUNC = 0x200;
static const Word SQLOEXCL = 0x400;
static const Word SQLODIRCREA = 0x800;
static const Word SQLOTEXT = 0x4000;
static const Word SQLOBINARY = 0x8000;
static const Shortint SQLGPWD = 0x1;
static const Shortint SQLGCUR = 0x2;
static const Shortint SQLGDBS = 0x4;
static const Shortint SQLGCFG = 0x8;
static const Shortint SQLGSTT = 0x10;
static const Shortint SQLGPRC = 0x20;
extern PACKAGE Word __stdcall (*SqlArf)(Word Cur, void * fnp, Word fnl, Byte cho);
extern PACKAGE Word __stdcall (*SqlBbr)(Word Cur, SqlTXerPtr errno, void * errbuf, SqlTDalPtr buflen
	, SqlTBirPtr errrow, SqlTRbfPtr rbf, Word errseq);
extern PACKAGE Word __stdcall (*SqlBdb)(Word shandle, void * dbname, Word dbnamel, void * bkpdir, Word 
	bkpdirl, Byte local, Byte over);
extern PACKAGE Word __stdcall (*SqlBef)(Word Cur);
extern PACKAGE Word __stdcall (*SqlBer)(Word Cur, SqlTRcdPtr rcd, SqlTBirPtr errrow, SqlTRbfPtr rbf, 
	Word errseq);
extern PACKAGE Word __stdcall (*SqlBkp)(Word Cur, Byte defalt, Byte overwrt, void * bkfname, Word bkflen
	);
extern PACKAGE Word __stdcall (*SqlBld)(Word Cur, void * bnp, Byte bnl);
extern PACKAGE Word __stdcall (*SqlBlf)(Word shandle, void * dbname, Word dbnamel, void * bkpdir, Word 
	bkpdirl, Byte local, Byte over);
extern PACKAGE Word __stdcall (*SqlBlk)(Word Cur, Word blkflg);
extern PACKAGE Word __stdcall (*SqlBln)(Word Cur, Byte bnn);
extern PACKAGE Word __stdcall (*SqlBna)(Word Cur, void * bnp, Byte bnl, void * dap, Word dal, Byte sca
	, Byte pdt, short nli);
extern PACKAGE Word __stdcall (*SqlBnd)(Word Cur, void * bnp, Byte bnl, void * dap, Word dal, Byte sca
	, Byte pdt);
extern PACKAGE Word __stdcall (*SqlBnn)(Word Cur, Byte bnn, void * dap, Word dal, Byte sca, Byte pdt
	);
extern PACKAGE Word __stdcall (*SqlBnu)(Word Cur, Byte bnn, void * dap, Word dal, Byte sca, Byte pdt
	, short nli);
extern PACKAGE Word __stdcall (*SqlBss)(Word shandle, void * dbname, Word dbnamel, void * bkpdir, Word 
	bkpdirl, Byte local, Byte over);
extern PACKAGE Word __stdcall (*SqlCan)(Word Cur);
extern PACKAGE Word __stdcall (*SqlCbv)(Word Cur);
extern PACKAGE Word __stdcall (*SqlCdr)(Word sHandle, Word Cur);
extern PACKAGE Word __stdcall (*SqlCex)(Word Cur, void * pData, Word lData);
extern PACKAGE Word __stdcall (*SqlClf)(Word Cur, void * LogFile, short StartFlag);
extern PACKAGE Word __stdcall (*SqlCmt)(Word Cur);
extern PACKAGE Word __stdcall (*SqlCnc)(Word &Cur, void * pDbName, Word lDbName);
extern PACKAGE Word __stdcall (*SqlCnr)(Word &Cur, void * pDbname, Word lDbName);
extern PACKAGE Word __stdcall (*SqlCom)(Word Cur, void * pCmd, Word lCmd);
extern PACKAGE Word __stdcall (*SqlCon)(Word &Cur, void * pDbName, Word lDbname, Word CurSiz, Word Pages
	, Byte Recovr, Word OutSize, Word InSize);
extern PACKAGE Word __stdcall (*SqlCpy)(Word fcur, void * selp, Word sell, Word tcur, void * isrtp, 
	Word isrtl);
extern PACKAGE Word __stdcall (*SqlCre)(Word shandle, void * dbnamp, Word dbnaml);
extern PACKAGE Word __stdcall (*SqlCrf)(Word shandle, void * dbnam, Word dbnaml);
extern PACKAGE Word __stdcall (*SqlCrs)(Word cur, void * rsp, Word rsl);
extern PACKAGE Word __stdcall (*SqlCsv)(Word &shandlep, void * serverid, void * password);
extern PACKAGE Word __stdcall (*SqlCty)(Word cur, Byte &cty);
extern PACKAGE Word __stdcall (*SqlDbn)(void * serverid, void * buffer, Word length);
extern PACKAGE Word __stdcall (*SqlDed)(Word shandle, void * dbnamp, Word dbnaml);
extern PACKAGE Word __stdcall (*SqlDel)(Word shandle, void * dbnamp, Word dbnaml);
extern PACKAGE Word __stdcall (*SqlDes)(Word cur, Byte slc, SqlTDdtPtr ddt, SqlTDdlPtr ddl, void * chp
	, SqlTChlPtr chlp, SqlTPrePtr prep, SqlTScaPtr scap);
extern PACKAGE Word __stdcall (*SqlDid)(void * dbname, Word dbnamel);
extern PACKAGE Word __stdcall (*SqlDii)(Word Cur, Byte ivn, void * inp, SqlTChlPtr inlp);
extern PACKAGE Word __stdcall (*SqlDin)(void * dbnamp, Word dbnaml);
extern PACKAGE Word __stdcall (*SqlDir)(Word srvno, void * buffer, Word length);
extern PACKAGE Word __stdcall (*SqlDis)(Word cur);
extern PACKAGE Word __stdcall (*SqlDon)(void);
extern PACKAGE Word __stdcall (*SqlDox)(Word shandle, void * dirnamep, Word fattr);
extern PACKAGE Word __stdcall (*SqlDrc)(Word cur);
extern PACKAGE Word __stdcall (*SqlDro)(Word shandle, void * dirname);
extern PACKAGE Word __stdcall (*SqlDrr)(Word shandle, void * filename);
extern PACKAGE Word __stdcall (*SqlDrs)(Word cur, void * rsp, Word rsl);
extern PACKAGE Word __stdcall (*SqlDsc)(Word Cur, Byte slc, Byte &edt, Byte &edl, void * chp, Byte &
	chlp, Byte &prep, Byte &scap);
extern PACKAGE Word __stdcall (*SqlDst)(Word cur, void * cnp, Word cnl);
extern PACKAGE Word __stdcall (*SqlDsv)(Word shandle);
extern PACKAGE Word __stdcall (*SqlEbk)(Word Cur);
extern PACKAGE Word __stdcall (*SqlEfb)(Word Cur);
extern PACKAGE Word __stdcall (*SqlElo)(Word Cur);
extern PACKAGE Word __stdcall (*SqlEnr)(Word shandle, void * dbname, Word dbnamel);
extern PACKAGE Word __stdcall (*SqlEpo)(Word Cur, Word &epo);
extern PACKAGE Word __stdcall (*SqlErf)(Word Cur);
extern PACKAGE Word __stdcall (*SqlErr)(short error, void * msg);
extern PACKAGE Word __stdcall (*SqlErs)(Word Cur);
extern PACKAGE Word __stdcall (*SqlEtx)(short error, Word msgtyp, void * bfp, Word bfl, Word &txtlen
	);
extern PACKAGE Word __stdcall (*SqlExe)(Word Cur);
extern PACKAGE Word __stdcall (*SqlExp)(Word Cur, void * buffer, Word length);
extern PACKAGE Word __stdcall (*SqlFbk)(Word Cur);
extern PACKAGE Word __stdcall (*SqlFer)(short error, void * msg);
extern PACKAGE Word __stdcall (*SqlFet)(Word Cur);
extern PACKAGE Word __stdcall (*SqlFgt)(Word Cur, void * srvfile, void * lcfile);
extern PACKAGE Word __stdcall (*SqlFpt)(Word Cur, void * srvfile, void * lclfile);
extern PACKAGE Word __stdcall (*SqlFqn)(Word Cur, Word field, void * nameptr, Word &namelen);
extern PACKAGE Word __stdcall (*SqlGbi)(Word Cur, Word &BackEndCur, SqlTPnmPtr ppnm);
extern PACKAGE Word __stdcall (*SqlGdi)(Word Cur, TGdiDefx &gdi);
extern PACKAGE Word __stdcall (*SqlGet)(Word Cur, Word parm, void * p, Word &l);
extern PACKAGE Word __stdcall (*SqlGfi)(Word Cur, Byte slc, SqlTCdlPtr cvl, SqlTFscPtr fsc);
extern PACKAGE Word __stdcall (*SqlGls)(Word Cur, Byte slc, int &size);
extern PACKAGE Word __stdcall (*SqlGnl)(Word shandle, void * dbname, Word dbnamel, SqlTLngPtr lognum
	);
extern PACKAGE Word __stdcall (*SqlGnr)(Word Cur, void * tbnam, Word tbnaml, SqlTRowPtr rows);
extern PACKAGE Word __stdcall (*SqlGsi)(Word shandle, Word infoflags, void * buffer, Word buflen, Word 
	&rbuflen);
extern PACKAGE Word __stdcall (*SqlIdb)(Word Cur);
extern PACKAGE Word __stdcall (*SqlIms)(Word Cur, Word InSize);
extern PACKAGE Word __stdcall (*SqlInd)(Word sHandle, void * pDbName, Word lDbName);
extern PACKAGE Word __stdcall (*SqlIni)(void * CallBack);
extern PACKAGE Word __stdcall (*SqlIns)(Word SrvNo, void * DbName, Word lDbName, Word CreateFlag, Word 
	OverWrite);
extern PACKAGE Word __stdcall (*SqlLab)(Word Cur, Byte slc, void * lbp, SqlTChlPtr lblp);
extern PACKAGE Word __stdcall (*SqlLdp)(Word Cur, void * cmdp, Word cmdl);
extern PACKAGE Word __stdcall (*SqlLsk)(Word Cur, Byte slc, int pos);
extern PACKAGE Word __stdcall (*SqlMcl)(Word shandle, int fd);
extern PACKAGE Word __stdcall (*SqlMdl)(Word shandle, void * filename);
extern PACKAGE Word __stdcall (*SqlMop)(Word shandle, SqlTFlhPtr fdp, void * filename, short openmode
	);
extern PACKAGE Word __stdcall (*SqlMrd)(Word shandle, int fd, void * buffer, Word len, SqlTDalPtr rlen
	);
extern PACKAGE Word __stdcall (*SqlMsk)(Word shandle, int fd, int offset, short whence, SqlTLngPtr roffset
	);
extern PACKAGE Word __stdcall (*SqlMwr)(Word shandle, int fd, void * buffer, Word len, SqlTDalPtr rlen
	);
extern PACKAGE Word __stdcall (*SqlNbv)(Word Cur, Byte &nbv);
extern PACKAGE Word __stdcall (*SqlNii)(Word Cur, Byte &nii);
extern PACKAGE Word __stdcall (*SqlNrr)(Word Cur, int &rcountp);
extern PACKAGE Word __stdcall (*SqlNsi)(Word Cur, Byte &nsi);
extern PACKAGE Word __stdcall (*SqlOms)(Word Cur, Word outsize);
extern PACKAGE Word __stdcall (*SqlPrs)(Word Cur, int row);
extern PACKAGE Word __stdcall (*SqlRbf)(Word Cur, Byte &rbf);
extern PACKAGE Word __stdcall (*SqlRbk)(Word Cur);
extern PACKAGE Word __stdcall (*SqlRcd)(Word Cur, SqlTRcdPtr rcd);
extern PACKAGE Word __stdcall (*SqlRdb)(Word shandle, void * dbname, Word dbnamel, void * bkpdir, Word 
	bkpdirl, Byte local, Byte over);
extern PACKAGE Word __stdcall (*SqlRdc)(Word Cur, void * bufp, Word buf, SqlTDalPtr readl);
extern PACKAGE Word __stdcall (*SqlRel)(Word Cur);
extern PACKAGE Word __stdcall (*SqlRes)(Word &Cur, void * bkfname, Word bkfnlen, Word bkfserv, Byte 
	overwrt, void * dbname, Word dbnlen, Word dbserv);
extern PACKAGE Word __stdcall (*SqlRet)(Word Cur, void * cnp, Word cnl);
extern PACKAGE Word __stdcall (*SqlRlf)(Word shandle, void * dbname, Word dbnamel, void * bkpdir, Word 
	bkpdirl, Byte local, Byte over);
extern PACKAGE Word __stdcall (*SqlRlo)(Word Cur, Byte slc, void * bufp, Word bufl, Word &readl);
extern PACKAGE Word __stdcall (*SqlRof)(Word shandle, void * dbname, Word dbnamel, Word mode, void * 
	datetime, Word datetimel);
extern PACKAGE Word __stdcall (*SqlRow)(Word Cur, int &row);
extern PACKAGE Word __stdcall (*SqlRrd)(Word Cur);
extern PACKAGE Word __stdcall (*SqlRrs)(Word Cur, void * rsp, Word rsl);
extern PACKAGE Word __stdcall (*SqlRsi)(Word shandle);
extern PACKAGE Word __stdcall (*SqlRss)(Word shandle, void * dbname, Word dbnamel, void * bkpdir, Word 
	bkpdirl, Byte local, Byte over);
extern PACKAGE Word __stdcall (*SqlSab)(Word shandle, Word pnum);
extern PACKAGE Word __stdcall (*SqlSap)(Word srvno, void * password, Word pnum);
extern PACKAGE Word __stdcall (*SqlScl)(Word Cur, void * namp, Word naml);
extern PACKAGE Word __stdcall (*SqlScn)(Word Cur, void * namp, Word naml);
extern PACKAGE Word __stdcall (*SqlScp)(Word Pages);
extern PACKAGE Word __stdcall (*SqlSdn)(void * dbnamp, Word dbnaml);
extern PACKAGE Word __stdcall (*SqlSds)(Word shandle, Word shutdownflg);
extern PACKAGE Word __stdcall (*SqlSdx)(Word shandle, void * dbnamp, Word dbnaml, Word shutdownflg);
	
extern PACKAGE Word __stdcall (*SqlSet)(Word Cur, Word parm, void * p, Word i);
extern PACKAGE Word __stdcall (*SqlSil)(Word Cur, void * isolation);
extern PACKAGE Word __stdcall (*SqlSlp)(Word Cur, Word lpt, Word lpm);
extern PACKAGE Word __stdcall (*SqlSpr)(Word Cur);
extern PACKAGE Word __stdcall (*SqlSrf)(Word Cur, void * fnp, Word fnl);
extern PACKAGE Word __stdcall (*SqlSrs)(Word Cur);
extern PACKAGE Word __stdcall (*SqlSsb)(Word Cur, Byte slc, Byte pdt, void * pbp, Byte pdl, Byte sca
	, SqlTCdlPtr pcv, SqlTFscPtr pfc);
extern PACKAGE Word __stdcall (*SqlSss)(Word Cur, Word size);
extern PACKAGE Word __stdcall (*SqlSta)(Word Cur, Word &srv, Word svw, Word &spr, Word &spw);
extern PACKAGE Word __stdcall (*SqlStm)(Word shandle);
extern PACKAGE Word __stdcall (*SqlSto)(Word Cur, void * cnp, Word cnl, void * ctp, Word ctl);
extern PACKAGE Word __stdcall (*SqlStr)(Word Cur);
extern PACKAGE Word __stdcall (*SqlSxt)(Word srvno, void * password);
extern PACKAGE Word __stdcall (*SqlTec)(short rcd, SqlTRcdPtr np);
extern PACKAGE Word __stdcall (*SqlTem)(Word Cur, SqlTXerPtr xer, Word msgtyp, void * bfp, Word bfl, 
	SqlTDalPtr txtlen);
extern PACKAGE Word __stdcall (*SqlTio)(Word Cur, short timeout);
extern PACKAGE Word __stdcall (*SqlUnl)(Word Cur, void * cmdp, Word cmdl);
extern PACKAGE Word __stdcall (*SqlUrs)(Word Cur);
extern PACKAGE Word __stdcall (*SqlWdc)(Word Cur, void * bufp, Word bufl);
extern PACKAGE Word __stdcall (*SqlWlo)(Word Cur, void * bufp, Word bufl);
extern PACKAGE Word __stdcall (*SqlXad)(void * op, void * np1, Byte nl1, void * np2, Byte nl2);
extern PACKAGE Word __stdcall (*SqlXcn)(void * op, void * ip, Word il);
extern PACKAGE Word __stdcall (*SqlXda)(void * op, void * dp, Byte dl, short days);
extern PACKAGE Word __stdcall (*SqlXdp)(void * op, Word ol, void * ip, Byte il, void * pp, Word pl);
	
extern PACKAGE Word __stdcall (*SqlXdv)(void * op, void * np1, Byte nl1, void * np2, Byte nl2);
extern PACKAGE Word __stdcall (*SqlXer)(Word Cur, SqlTXerPtr ErrNo, void * ErrBuf, SqlTDalPtr BufLen
	);
extern PACKAGE Word __stdcall (*SqlXml)(void * op, void * np1, Byte nl1, void * np2, Byte nl2);
extern PACKAGE Word __stdcall (*SqlXnp)(void * Outp, Word OutL, void * isnp, Byte isnl, void * PicP, 
	Word PicL);
extern PACKAGE Word __stdcall (*SqlXpd)(void * op, Byte &ol, void * ip, void * pp, Word pl);
extern PACKAGE Word __stdcall (*SqlXsb)(void * op, void * np1, Byte nl1, void * np2, Byte nl2);
extern PACKAGE Word __stdcall (*SqlCch)(int &hCon, void * dbnamp, Word dbnaml, int fType);
extern PACKAGE Word __stdcall (*SqlDch)(int hCon);
extern PACKAGE Word __stdcall (*SqlOpc)(Word &Cur, int hCon, int fType);
#define DefSqlApiDLL "SQLWNTM.DLL"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE float __fastcall APIVersion(void);
extern PACKAGE void __fastcall CsbError(Word Cur, short error, int ErrPos);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);

}	/* namespace Sdcsb */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdcsb;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDCSb
