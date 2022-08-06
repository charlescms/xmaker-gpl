// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainDbLibSybaseAse125.pas' rev: 5.00

#ifndef ZPlainDbLibSybaseAse125HPP
#define ZPlainDbLibSybaseAse125HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDbLibDriver.hpp>	// Pascal unit
#include <ZPlainLoader.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplaindblibsybasease125
{
//-- type declarations -------------------------------------------------------
typedef int __stdcall (*DBERRHANDLE_PROC)(void * Proc, int Severity, int DbErr, int OsErr, char * DbErrStr
	, char * OsErrStr);

typedef int __stdcall (*DBMSGHANDLE_PROC)(void * Proc, int MsgNo, int MsgState, int Severity, char * 
	MsgText, char * SrvName, char * ProcName, Word Line);

typedef Byte __stdcall (*Tdb12hour)(void * Proc, char * Language);

typedef DBERRHANDLE_PROC __stdcall (*Tdberrhandle)(DBERRHANDLE_PROC Handler);

typedef DBMSGHANDLE_PROC __stdcall (*Tdbmsghandle)(DBMSGHANDLE_PROC Handler);

typedef int __stdcall (*Tabort_xact)(void * Proc, int CommId);

typedef void __stdcall (*Tbuild_xact_string)(char * XActName, char * Service, int CommId, char * Result
	);

typedef void __stdcall (*Tclose_commit)(void * Proc);

typedef int __stdcall (*Tcommit_xact)(void * Proc, int CommId);

typedef void * __stdcall (*Topen_commit)(void * Login, char * ServerName);

typedef int __stdcall (*Tremove_xact)(void * Proc, int CommId, int SiteCount);

typedef int __stdcall (*Tscan_xact)(void * Proc, int CommId);

typedef int __stdcall (*Tstart_xact)(void * Proc, char * AppName, char * XActName, int SiteCount);

typedef int __stdcall (*Tstat_xact)(void * Proc, int CommId);

typedef int __stdcall (*Tbcp_batch)(void * Proc);

typedef int __stdcall (*Tbcp_bind)(void * Proc, Zcompatibility::PByte VarAddr, int PrefixLen, int VarLen
	, Zcompatibility::PByte Terminator, int TermLen, int Typ, int TableColumn);

typedef int __stdcall (*Tbcp_colfmt)(void * Proc, int FileColumn, Byte FileType, int FilePrefixLen, 
	int FileColLen, Zcompatibility::PByte FileTerm, int FileTermLen, int TableColumn);

typedef int __stdcall (*Tbcp_collen)(void * Proc, int VarLen, int TableColumn);

typedef int __stdcall (*Tbcp_colptr)(void * Proc, Zcompatibility::PByte ColPtr, int TableColumn);

typedef int __stdcall (*Tbcp_columns)(void * Proc, int FileColCount);

typedef int __stdcall (*Tbcp_control)(void * Proc, int Field, int Value);

typedef int __stdcall (*Tbcp_done)(void * Proc);

typedef int __stdcall (*Tbcp_exec)(void * Proc, Zplaindblibdriver::PDBINT RowsCopied);

typedef int __stdcall (*Tbcp_init)(void * Proc, char * TableName, char * hFile, char * ErrFile, int 
	Direction);

typedef int __stdcall (*Tbcp_moretext)(void * Proc, int Size, Zcompatibility::PByte Text);

typedef int __stdcall (*Tbcp_readfmt)(void * Proc, char * FileName);

typedef int __stdcall (*Tbcp_sendrow)(void * Proc);

typedef int __stdcall (*Tbcp_writefmt)(void * Proc, char * FileName);

typedef Zcompatibility::PByte __stdcall (*Tdbadata)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbadlen)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbaltbind)(void * Proc, int ComputeId, int Column, int VarType, int VarLen, 
	Zcompatibility::PByte VarAddr);

typedef int __stdcall (*Tdbaltcolid)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbaltlen)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbaltop)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbalttype)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbaltutype)(void * Proc, int ComputeId, int Column);

typedef int __stdcall (*Tdbanullbind)(void * Proc, int ComputeId, int Column, Zplaindblibdriver::PDBINT 
	Indicator);

typedef int __stdcall (*Tdbbind)(void * Proc, int Column, int VarType, int VarLen, Zcompatibility::PByte 
	VarAddr);

typedef Zcompatibility::PByte __stdcall (*Tdbbylist)(void * Proc, int ComputeId, Zcompatibility::PInteger 
	Size);

typedef int __stdcall (*Tdbcancel)(void * Proc);

typedef int __stdcall (*Tdbcanquery)(void * Proc);

typedef char * __stdcall (*Tdbchange)(void * Proc);

typedef int __stdcall (*Tdbclose)(void * Proc);

typedef void __stdcall (*Tdbclrbuf)(void * Proc, int N);

typedef int __stdcall (*Tdbclropt)(void * Proc, int Option, char * Param);

typedef int __stdcall (*Tdbcmd)(void * Proc, char * Cmd);

typedef int __stdcall (*Tdbcmdrow)(void * Proc);

typedef BOOL __stdcall (*Tdbcolbrowse)(void * Proc, int Column);

typedef int __stdcall (*Tdbcollen)(void * Proc, int Column);

typedef char * __stdcall (*Tdbcolname)(void * Proc, int Column);

typedef char * __stdcall (*Tdbcolsource)(void * Proc, int Column);

typedef int __stdcall (*Tdbcoltype)(void * Proc, int Column);

typedef int __stdcall (*Tdbcolutype)(void * Proc, int Column);

typedef int __stdcall (*Tdbconvert)(void * Proc, int SrcType, Zcompatibility::PByte Src, int SrcLen, 
	int DestType, Zcompatibility::PByte Dest, int DestLen);

typedef int __stdcall (*Tdbcount)(void * Proc);

typedef int __stdcall (*Tdbcurcmd)(void * Proc);

typedef int __stdcall (*Tdbcurrow)(void * Proc);

typedef int __stdcall (*Tdbcursor)(void * hCursor, int OpType, int Row, char * Table, char * Values)
	;

typedef int __stdcall (*Tdbcursorbind)(void * hCursor, int Col, int VarType, int VarLen, Zplaindblibdriver::PDBINT 
	POutLen, Zcompatibility::PByte VarAddr);

typedef int __stdcall (*Tdbcursorclose)(void * DbHandle);

typedef int __stdcall (*Tdbcursorcolinfo)(void * hCursor, int Column, char * ColName, Zcompatibility::PInteger 
	ColType, Zplaindblibdriver::PDBINT ColLen, Zcompatibility::PInteger UserType);

typedef int __stdcall (*Tdbcursorfetch)(void * hCursor, int FetchType, int RowNum);

typedef int __stdcall (*Tdbcursorinfo)(void * hCursor, Zcompatibility::PInteger nCols, Zplaindblibdriver::PDBINT 
	nRows);

typedef void * __stdcall (*Tdbcursoropen)(void * Proc, char * Sql, int ScrollOpt, int ConCurOpt, unsigned 
	nRows, Zplaindblibdriver::PDBINT PStatus);

typedef Zcompatibility::PByte __stdcall (*Tdbdata)(void * Proc, int Column);

typedef int __stdcall (*Tdbdatecrack)(void * Proc, Zplaindblibdriver::PDBDATEREC DateInfo, Zplaindblibdriver::PDBDATETIME 
	DateType);

typedef int __stdcall (*Tdbdatlen)(void * Proc, int Column);

typedef BOOL __stdcall (*Tdbdead)(void * Proc);

typedef void __stdcall (*Tdbexit)(void);

typedef int __stdcall (*Tdbfcmd)(void * Proc, char * CmdString, void *Params);

typedef int __stdcall (*Tdbfirstrow)(void * Proc);

typedef void __stdcall (*Tdbfreebuf)(void * Proc);

typedef void __stdcall (*Tdbloginfree)(void * Login);

typedef void __stdcall (*Tdbfreequal)(char * Ptr);

typedef char * __stdcall (*Tdbgetchar)(void * Proc, int N);

typedef short __stdcall (*Tdbgetmaxprocs)(void);

typedef int __stdcall (*Tdbgetoff)(void * Proc, Word OffType, int StartFrom);

typedef unsigned __stdcall (*Tdbgetpacket)(void * Proc);

typedef int __stdcall (*Tdbgetrow)(void * Proc, int Row);

typedef void * __stdcall (*Tdbgetuserdata)(void * Proc);

typedef BOOL __stdcall (*Tdbhasretstat)(void * Proc);

typedef int __stdcall (*Tdbinit)(void);

typedef BOOL __stdcall (*Tdbisavail)(void * Proc);

typedef BOOL __stdcall (*Tdbisopt)(void * Proc, int Option, char * Param);

typedef int __stdcall (*Tdblastrow)(void * Proc);

typedef void * __stdcall (*Tdblogin)(void);

typedef int __stdcall (*Tdbmorecmds)(void * Proc);

typedef int __stdcall (*Tdbmoretext)(void * Proc, int Size, Zcompatibility::PByte Text);

typedef char * __stdcall (*Tdbname)(void * Proc);

typedef int __stdcall (*Tdbnextrow)(void * Proc);

typedef int __stdcall (*Tdbnullbind)(void * Proc, int Column, Zplaindblibdriver::PDBINT Indicator);

typedef int __stdcall (*Tdbnumalts)(void * Proc, int ComputeId);

typedef int __stdcall (*Tdbnumcols)(void * Proc);

typedef int __stdcall (*Tdbnumcompute)(void * Proc);

typedef int __stdcall (*Tdbnumorders)(void * Proc);

typedef int __stdcall (*Tdbnumrets)(void * Proc);

typedef void * __stdcall (*Tdbopen)(void * Login, char * Host);

typedef int __stdcall (*Tdbordercol)(void * Proc, int Order);

typedef void __stdcall (*Tdbprhead)(void * Proc);

typedef int __stdcall (*Tdbprrow)(void * Proc);

typedef char * __stdcall (*Tdbprtype)(int Token);

typedef char * __stdcall (*Tdbqual)(void * Proc, int TabNum, char * TabName);

typedef int __stdcall (*Tdbreadtext)(void * Proc, void * Buf, int BufSize);

typedef int __stdcall (*Tdbresults)(void * Proc);

typedef Zcompatibility::PByte __stdcall (*Tdbretdata)(void * Proc, int RetNum);

typedef int __stdcall (*Tdbretlen)(void * Proc, int RetNum);

typedef char * __stdcall (*Tdbretname)(void * Proc, int RetNum);

typedef int __stdcall (*Tdbretstatus)(void * Proc);

typedef int __stdcall (*Tdbrettype)(void * Proc, int RetNum);

typedef int __stdcall (*Tdbrows)(void * Proc);

typedef int __stdcall (*Tdbrowtype)(void * Proc);

typedef int __stdcall (*Tdbrpcinit)(void * Proc, char * ProcName, short Options);

typedef int __stdcall (*Tdbrpcparam)(void * Proc, char * ParamName, Byte Status, int Typ, int MaxLen
	, int DataLen, Zcompatibility::PByte Value);

typedef int __stdcall (*Tdbrpcsend)(void * Proc);

typedef void __stdcall (*Tdbrpwclr)(void * Login);

typedef void __stdcall (*Tdbsetavail)(void * Proc);

typedef int __stdcall (*Tdbsetmaxprocs)(short MaxProcs);

typedef int __stdcall (*Tdbsetlname)(void * Login, char * Value, int Item);

typedef int __stdcall (*Tdbsetlogintime)(int Seconds);

typedef int __stdcall (*Tdbsetnull)(void * Proc, int BindType, int BindLen, Zcompatibility::PByte BindVal
	);

typedef int __stdcall (*Tdbsetopt)(void * Proc, int Option, char * CharParam, int IntParam);

typedef int __stdcall (*Tdbsettime)(int Seconds);

typedef void __stdcall (*Tdbsetuserdata)(void * Proc, void * Ptr);

typedef int __stdcall (*Tdbsqlexec)(void * Proc);

typedef int __stdcall (*Tdbsqlok)(void * Proc);

typedef int __stdcall (*Tdbsqlsend)(void * Proc);

typedef int __stdcall (*Tdbstrcpy)(void * Proc, int Start, int NumBytes, char * Dest);

typedef int __stdcall (*Tdbstrlen)(void * Proc);

typedef BOOL __stdcall (*Tdbtabbrowse)(void * Proc, int TabNum);

typedef int __stdcall (*Tdbtabcount)(void * Proc);

typedef char * __stdcall (*Tdbtabname)(void * Proc, int Table);

typedef char * __stdcall (*Tdbtabsource)(void * Proc, int Column, Zcompatibility::PInteger TabNum);

typedef int __stdcall (*Tdbtsnewlen)(void * Proc);

typedef Zplaindblibdriver::PDBBINARY __stdcall (*Tdbtsnewval)(void * Proc);

typedef int __stdcall (*Tdbtsput)(void * Proc, Zplaindblibdriver::PDBBINARY NewTs, int NewTsName, int 
	TabNum, char * TableName);

typedef Zplaindblibdriver::PDBBINARY __stdcall (*Tdbtxptr)(void * Proc, int Column);

typedef Zplaindblibdriver::PDBBINARY __stdcall (*Tdbtxtimestamp)(void * Proc, int Column);

typedef Zplaindblibdriver::PDBBINARY __stdcall (*Tdbtxtsnewval)(void * Proc);

typedef int __stdcall (*Tdbtxtsput)(void * Proc, Zplaindblibdriver::PDBBINARY NewTxts, int Column);

typedef int __stdcall (*Tdbuse)(void * Proc, char * DbName);

typedef BOOL __stdcall (*Tdbvarylen)(void * Proc, int Column);

typedef BOOL __stdcall (*Tdbwillconvert)(int SrcType, int DestType);

typedef int __stdcall (*Tdbwritetext)(void * Proc, char * ObjName, Zplaindblibdriver::PDBBINARY TextPtr
	, Byte TextPtrLen, Zplaindblibdriver::PDBBINARY Timestamp, BOOL Log, int Size, Zcompatibility::PByte 
	Text);

class DELPHICLASS TZSybaseNativeLibraryLoader;
class PASCALIMPLEMENTATION TZSybaseNativeLibraryLoader : public Zplainloader::TZNativeLibraryLoader 
	
{
	typedef Zplainloader::TZNativeLibraryLoader inherited;
	
public:
	virtual bool __fastcall Load(void);
	virtual void __fastcall FreeNativeLibrary(void);
public:
	#pragma option push -w-inl
	/* TZNativeLibraryLoader.Create */ inline __fastcall TZSybaseNativeLibraryLoader(const AnsiString * 
		Locations, const int Locations_Size) : Zplainloader::TZNativeLibraryLoader(Locations, Locations_Size
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TZNativeLibraryLoader.Destroy */ inline __fastcall virtual ~TZSybaseNativeLibraryLoader(void) { }
		
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#define WINDOWS_DLL_LOCATION "libsybdb.dll"
#define LINUX_DLL_LOCATION "libsybdb.so"
static const Shortint DBSETHOST = 0x1;
static const Shortint DBSETUSER = 0x2;
static const Shortint DBSETPWD = 0x3;
static const Shortint DBSETHID = 0x4;
static const Shortint DBSETAPP = 0x5;
static const Shortint DBSETBCP = 0x6;
static const Shortint DBSETLANG = 0x7;
static const Shortint DBSETNOSHORT = 0x8;
static const Shortint DBSETHIER = 0x9;
static const Shortint DBSETCHARSET = 0xa;
static const Shortint DBSETPACKET = 0xb;
static const Shortint DBSETENCRYPT = 0xc;
static const Shortint DBSETLABELED = 0xd;
extern PACKAGE Tdb12hour db12hour;
extern PACKAGE Tdberrhandle dberrhandle;
extern PACKAGE Tdbmsghandle dbmsghandle;
extern PACKAGE Tabort_xact abort_xact;
extern PACKAGE Tbuild_xact_string build_xact_string;
extern PACKAGE Tclose_commit close_commit;
extern PACKAGE Tcommit_xact commit_xact;
extern PACKAGE Topen_commit open_commit;
extern PACKAGE Tremove_xact remove_xact;
extern PACKAGE Tscan_xact scan_xact;
extern PACKAGE Tstart_xact start_xact;
extern PACKAGE Tstat_xact stat_xact;
extern PACKAGE Tbcp_batch bcp_batch;
extern PACKAGE Tbcp_bind bcp_bind;
extern PACKAGE Tbcp_colfmt bcp_colfmt;
extern PACKAGE Tbcp_collen bcp_collen;
extern PACKAGE Tbcp_colptr bcp_colptr;
extern PACKAGE Tbcp_columns bcp_columns;
extern PACKAGE Tbcp_control bcp_control;
extern PACKAGE Tbcp_done bcp_done;
extern PACKAGE Tbcp_exec bcp_exec;
extern PACKAGE Tbcp_init bcp_init;
extern PACKAGE Tbcp_moretext bcp_moretext;
extern PACKAGE Tbcp_readfmt bcp_readfmt;
extern PACKAGE Tbcp_sendrow bcp_sendrow;
extern PACKAGE Tbcp_writefmt bcp_writefmt;
extern PACKAGE Tdbadata dbadata;
extern PACKAGE Tdbadlen dbadlen;
extern PACKAGE Tdbaltbind dbaltbind;
extern PACKAGE Tdbaltcolid dbaltcolid;
extern PACKAGE Tdbaltlen dbaltlen;
extern PACKAGE Tdbaltop dbaltop;
extern PACKAGE Tdbalttype dbalttype;
extern PACKAGE Tdbaltutype dbaltutype;
extern PACKAGE Tdbanullbind dbanullbind;
extern PACKAGE Tdbbind dbbind;
extern PACKAGE Tdbbylist dbbylist;
extern PACKAGE Tdbcancel dbcancel;
extern PACKAGE Tdbcanquery dbcanquery;
extern PACKAGE Tdbchange dbchange;
extern PACKAGE Tdbclose dbclose;
extern PACKAGE Tdbclrbuf dbclrbuf;
extern PACKAGE Tdbclropt dbclropt;
extern PACKAGE Tdbcmd dbcmd;
extern PACKAGE Tdbcmdrow dbcmdrow;
extern PACKAGE Tdbcolbrowse dbcolbrowse;
extern PACKAGE Tdbcollen dbcollen;
extern PACKAGE Tdbcolname dbcolname;
extern PACKAGE Tdbcolsource dbcolsource;
extern PACKAGE Tdbcoltype dbcoltype;
extern PACKAGE Tdbcolutype dbcolutype;
extern PACKAGE Tdbconvert dbconvert;
extern PACKAGE Tdbcount dbcount;
extern PACKAGE Tdbcurcmd dbcurcmd;
extern PACKAGE Tdbcurrow dbcurrow;
extern PACKAGE Tdbcursor dbcursor;
extern PACKAGE Tdbcursorbind dbcursorbind;
extern PACKAGE Tdbcursorclose dbcursorclose;
extern PACKAGE Tdbcursorcolinfo dbcursorcolinfo;
extern PACKAGE Tdbcursorfetch dbcursorfetch;
extern PACKAGE Tdbcursorinfo dbcursorinfo;
extern PACKAGE Tdbcursoropen dbcursoropen;
extern PACKAGE Tdbdata dbdata;
extern PACKAGE Tdbdatecrack dbdatecrack;
extern PACKAGE Tdbdatlen dbdatlen;
extern PACKAGE Tdbdead dbdead;
extern PACKAGE Tdbexit dbexit;
extern PACKAGE Tdbfcmd dbfcmd;
extern PACKAGE Tdbfirstrow dbfirstrow;
extern PACKAGE Tdbfreebuf dbfreebuf;
extern PACKAGE Tdbloginfree dbloginfree;
extern PACKAGE Tdbfreequal dbfreequal;
extern PACKAGE Tdbgetchar dbgetchar;
extern PACKAGE Tdbgetmaxprocs dbgetmaxprocs;
extern PACKAGE Tdbgetoff dbgetoff;
extern PACKAGE Tdbgetpacket dbgetpacket;
extern PACKAGE Tdbgetrow dbgetrow;
extern PACKAGE Tdbgetuserdata dbgetuserdata;
extern PACKAGE Tdbhasretstat dbhasretstat;
extern PACKAGE Tdbinit dbinit;
extern PACKAGE Tdbisavail dbisavail;
extern PACKAGE Tdbisopt dbisopt;
extern PACKAGE Tdblastrow dblastrow;
extern PACKAGE Tdblogin dblogin;
extern PACKAGE Tdbmorecmds dbmorecmds;
extern PACKAGE Tdbmoretext dbmoretext;
extern PACKAGE Tdbname dbname;
extern PACKAGE Tdbnextrow dbnextrow;
extern PACKAGE Tdbnullbind dbnullbind;
extern PACKAGE Tdbnumalts dbnumalts;
extern PACKAGE Tdbnumcols dbnumcols;
extern PACKAGE Tdbnumcompute dbnumcompute;
extern PACKAGE Tdbnumorders dbnumorders;
extern PACKAGE Tdbnumrets dbnumrets;
extern PACKAGE Tdbopen dbopen;
extern PACKAGE Tdbordercol dbordercol;
extern PACKAGE Tdbprhead dbprhead;
extern PACKAGE Tdbprrow dbprrow;
extern PACKAGE Tdbprtype dbprtype;
extern PACKAGE Tdbqual dbqual;
extern PACKAGE Tdbreadtext dbreadtext;
extern PACKAGE Tdbresults dbresults;
extern PACKAGE Tdbretdata dbretdata;
extern PACKAGE Tdbretlen dbretlen;
extern PACKAGE Tdbretname dbretname;
extern PACKAGE Tdbretstatus dbretstatus;
extern PACKAGE Tdbrettype dbrettype;
extern PACKAGE Tdbrows dbrows;
extern PACKAGE Tdbrowtype dbrowtype;
extern PACKAGE Tdbrpcinit dbrpcinit;
extern PACKAGE Tdbrpcparam dbrpcparam;
extern PACKAGE Tdbrpcsend dbrpcsend;
extern PACKAGE Tdbrpwclr dbrpwclr;
extern PACKAGE Tdbsetavail dbsetavail;
extern PACKAGE Tdbsetmaxprocs dbsetmaxprocs;
extern PACKAGE Tdbsetlname dbsetlname;
extern PACKAGE Tdbsetlogintime dbsetlogintime;
extern PACKAGE Tdbsetnull dbsetnull;
extern PACKAGE Tdbsetopt dbsetopt;
extern PACKAGE Tdbsettime dbsettime;
extern PACKAGE Tdbsetuserdata dbsetuserdata;
extern PACKAGE Tdbsqlexec dbsqlexec;
extern PACKAGE Tdbsqlok dbsqlok;
extern PACKAGE Tdbsqlsend dbsqlsend;
extern PACKAGE Tdbstrcpy dbstrcpy;
extern PACKAGE Tdbstrlen dbstrlen;
extern PACKAGE Tdbtabbrowse dbtabbrowse;
extern PACKAGE Tdbtabcount dbtabcount;
extern PACKAGE Tdbtabname dbtabname;
extern PACKAGE Tdbtabsource dbtabsource;
extern PACKAGE Tdbtsnewlen dbtsnewlen;
extern PACKAGE Tdbtsnewval dbtsnewval;
extern PACKAGE Tdbtsput dbtsput;
extern PACKAGE Tdbtxptr dbtxptr;
extern PACKAGE Tdbtxtimestamp dbtxtimestamp;
extern PACKAGE Tdbtxtsnewval dbtxtsnewval;
extern PACKAGE Tdbtxtsput dbtxtsput;
extern PACKAGE Tdbuse dbuse;
extern PACKAGE Tdbvarylen dbvarylen;
extern PACKAGE Tdbwillconvert dbwillconvert;
extern PACKAGE Tdbwritetext dbwritetext;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;
extern PACKAGE Classes::TList* SybaseErrors;
extern PACKAGE Classes::TList* SybaseMessages;
extern PACKAGE int __fastcall DBSETLHOST(void * Login, char * ClientHost);
extern PACKAGE int __fastcall DBSETLUSER(void * Login, char * UserName);
extern PACKAGE int __fastcall DBSETLPWD(void * Login, char * Passwd);
extern PACKAGE int __fastcall DBSETLAPP(void * Login, char * AppName);
extern PACKAGE int __fastcall DBSETLNATLANG(void * Login, char * Lang);
extern PACKAGE int __fastcall DBSETLCHARSET(void * Login, char * Charset);
extern PACKAGE int __fastcall dbrbuf(void * Proc);

}	/* namespace Zplaindblibsybasease125 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaindblibsybasease125;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainDbLibSybaseAse125
