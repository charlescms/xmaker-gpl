// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainDbLibMsSql7.pas' rev: 5.00

#ifndef ZPlainDbLibMsSql7HPP
#define ZPlainDbLibMsSql7HPP

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

namespace Zplaindblibmssql7
{
//-- type declarations -------------------------------------------------------
typedef int __cdecl (*DBERRHANDLE_PROC)(void * Proc, int Severity, int DbErr, int OsErr, char * DbErrStr
	, char * OsErrStr);

typedef int __cdecl (*DBMSGHANDLE_PROC)(void * Proc, int MsgNo, int MsgState, int Severity, char * MsgText
	, char * SrvName, char * ProcName, Word Line);

typedef DBERRHANDLE_PROC __cdecl (*Tdberrhandle)(DBERRHANDLE_PROC Handler);

typedef DBMSGHANDLE_PROC __cdecl (*Tdbmsghandle)(DBMSGHANDLE_PROC Handler);

typedef DBERRHANDLE_PROC __cdecl (*Tdbprocerrhandle)(void * DbHandle, DBERRHANDLE_PROC Handler);

typedef DBMSGHANDLE_PROC __cdecl (*Tdbprocmsghandle)(void * DbHandle, DBMSGHANDLE_PROC Handler);

typedef int __cdecl (*Tabort_xact)(void * Proc, int CommId);

typedef void __cdecl (*Tbuild_xact_string)(char * XActName, char * Service, int CommId, char * Result
	);

typedef void __cdecl (*Tclose_commit)(void * Proc);

typedef int __cdecl (*Tcommit_xact)(void * Proc, int CommId);

typedef void * __cdecl (*Topen_commit)(void * Login, char * ServerName);

typedef int __cdecl (*Tremove_xact)(void * Proc, int CommId, int SiteCount);

typedef int __cdecl (*Tscan_xact)(void * Proc, int CommId);

typedef int __cdecl (*Tstart_xact)(void * Proc, char * AppName, char * XActName, int SiteCount);

typedef int __cdecl (*Tstat_xact)(void * Proc, int CommId);

typedef int __cdecl (*Tbcp_batch)(void * Proc);

typedef int __cdecl (*Tbcp_bind)(void * Proc, Zcompatibility::PByte VarAddr, int PrefixLen, int VarLen
	, Zcompatibility::PByte Terminator, int TermLen, int Typ, int TableColumn);

typedef int __cdecl (*Tbcp_colfmt)(void * Proc, int FileColumn, Byte FileType, int FilePrefixLen, int 
	FileColLen, Zcompatibility::PByte FileTerm, int FileTermLen, int TableColumn);

typedef int __cdecl (*Tbcp_collen)(void * Proc, int VarLen, int TableColumn);

typedef int __cdecl (*Tbcp_colptr)(void * Proc, Zcompatibility::PByte ColPtr, int TableColumn);

typedef int __cdecl (*Tbcp_columns)(void * Proc, int FileColCount);

typedef int __cdecl (*Tbcp_control)(void * Proc, int Field, int Value);

typedef int __cdecl (*Tbcp_done)(void * Proc);

typedef int __cdecl (*Tbcp_exec)(void * Proc, Zplaindblibdriver::PDBINT RowsCopied);

typedef int __cdecl (*Tbcp_init)(void * Proc, char * TableName, char * hFile, char * ErrFile, int Direction
	);

typedef int __cdecl (*Tbcp_moretext)(void * Proc, int Size, Zcompatibility::PByte Text);

typedef int __cdecl (*Tbcp_readfmt)(void * Proc, char * FileName);

typedef int __cdecl (*Tbcp_sendrow)(void * Proc);

typedef int __cdecl (*Tbcp_setl)(void * Login, BOOL Enable);

typedef int __cdecl (*Tbcp_writefmt)(void * Proc, char * FileName);

typedef Zcompatibility::PByte __cdecl (*Tdbadata)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbadlen)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbaltbind)(void * Proc, int ComputeId, int Column, int VarType, int VarLen, Zcompatibility::PByte 
	VarAddr);

typedef int __cdecl (*Tdbaltcolid)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbaltlen)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbaltop)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbalttype)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbaltutype)(void * Proc, int ComputeId, int Column);

typedef int __cdecl (*Tdbanullbind)(void * Proc, int ComputeId, int Column, Zplaindblibdriver::PDBINT 
	Indicator);

typedef int __cdecl (*Tdbbind)(void * Proc, int Column, int VarType, int VarLen, Zcompatibility::PByte 
	VarAddr);

typedef Zcompatibility::PByte __cdecl (*Tdbbylist)(void * Proc, int ComputeId, Zcompatibility::PInteger 
	Size);

typedef int __cdecl (*Tdbcancel)(void * Proc);

typedef int __cdecl (*Tdbcanquery)(void * Proc);

typedef char * __cdecl (*Tdbchange)(void * Proc);

typedef int __cdecl (*Tdbclose)(void * Proc);

typedef void __cdecl (*Tdbclrbuf)(void * Proc, int N);

typedef int __cdecl (*Tdbclropt)(void * Proc, int Option, char * Param);

typedef int __cdecl (*Tdbcmd)(void * Proc, char * Cmd);

typedef int __cdecl (*Tdbcmdrow)(void * Proc);

typedef BOOL __cdecl (*Tdbcolbrowse)(void * Proc, int Column);

typedef int __cdecl (*Tdbcolinfo)(void * Handle, int Typ, int Column, int ComputeId, Zplaindblibdriver::PDBCOL 
	DbColumn);

typedef int __cdecl (*Tdbcollen)(void * Proc, int Column);

typedef char * __cdecl (*Tdbcolname)(void * Proc, int Column);

typedef char * __cdecl (*Tdbcolsource)(void * Proc, int Column);

typedef int __cdecl (*Tdbcoltype)(void * Proc, int Column);

typedef int __cdecl (*Tdbcolutype)(void * Proc, int Column);

typedef int __cdecl (*Tdbconvert)(void * Proc, int SrcType, Zcompatibility::PByte Src, int SrcLen, int 
	DestType, Zcompatibility::PByte Dest, int DestLen);

typedef int __cdecl (*Tdbcount)(void * Proc);

typedef int __cdecl (*Tdbcurcmd)(void * Proc);

typedef int __cdecl (*Tdbcurrow)(void * Proc);

typedef int __cdecl (*Tdbcursor)(void * hCursor, int OpType, int Row, char * Table, char * Values);

typedef int __cdecl (*Tdbcursorbind)(void * hCursor, int Col, int VarType, int VarLen, Zplaindblibdriver::PDBINT 
	POutLen, Zcompatibility::PByte VarAddr);

typedef int __cdecl (*Tdbcursorclose)(void * DbHandle);

typedef int __cdecl (*Tdbcursorcolinfo)(void * hCursor, int Column, char * ColName, Zcompatibility::PInteger 
	ColType, Zplaindblibdriver::PDBINT ColLen, Zcompatibility::PInteger UserType);

typedef int __cdecl (*Tdbcursorfetch)(void * hCursor, int FetchType, int RowNum);

typedef int __cdecl (*Tdbcursorfetchex)(void * hCursor, int FetchType, int RowNum, int nFetchRows, int 
	Reserved);

typedef int __cdecl (*Tdbcursorinfo)(void * hCursor, Zcompatibility::PInteger nCols, Zplaindblibdriver::PDBINT 
	nRows);

typedef int __cdecl (*Tdbcursorinfoex)(void * hCursor, Zplaindblibdriver::PDBCURSORINFO DbCursorInfo
	);

typedef void * __cdecl (*Tdbcursoropen)(void * Proc, char * Sql, int ScrollOpt, int ConCurOpt, unsigned 
	nRows, Zplaindblibdriver::PDBINT PStatus);

typedef Zcompatibility::PByte __cdecl (*Tdbdata)(void * Proc, int Column);

typedef BOOL __cdecl (*Tdbdataready)(void * Proc);

typedef int __cdecl (*Tdbdatecrack)(void * Proc, Zplaindblibdriver::PDBDATEREC DateInfo, Zplaindblibdriver::PDBDATETIME 
	DateType);

typedef int __cdecl (*Tdbdatlen)(void * Proc, int Column);

typedef BOOL __cdecl (*Tdbdead)(void * Proc);

typedef void __cdecl (*Tdbexit)(void);

typedef void __cdecl (*TdbWinexit)(void);

typedef int __cdecl (*Tdbenlisttrans)(void * Proc, void * Transaction);

typedef int __cdecl (*Tdbenlistxatrans)(void * Proc, BOOL EnlistTran);

typedef int __cdecl (*Tdbfcmd)(void * Proc, char * CmdString, void *Params);

typedef int __cdecl (*Tdbfirstrow)(void * Proc);

typedef void __cdecl (*Tdbfreebuf)(void * Proc);

typedef void __cdecl (*Tdbfreelogin)(void * Login);

typedef void __cdecl (*Tdbfreequal)(char * Ptr);

typedef char * __cdecl (*Tdbgetchar)(void * Proc, int N);

typedef short __cdecl (*Tdbgetmaxprocs)(void);

typedef int __cdecl (*Tdbgetoff)(void * Proc, Word OffType, int StartFrom);

typedef unsigned __cdecl (*Tdbgetpacket)(void * Proc);

typedef int __cdecl (*Tdbgetrow)(void * Proc, int Row);

typedef int __cdecl (*Tdbgettime)(void);

typedef void * __cdecl (*Tdbgetuserdata)(void * Proc);

typedef BOOL __cdecl (*Tdbhasretstat)(void * Proc);

typedef char * __cdecl (*Tdbinit)(void);

typedef BOOL __cdecl (*Tdbisavail)(void * Proc);

typedef BOOL __cdecl (*Tdbiscount)(void * Proc);

typedef BOOL __cdecl (*Tdbisopt)(void * Proc, int Option, char * Param);

typedef int __cdecl (*Tdblastrow)(void * Proc);

typedef void * __cdecl (*Tdblogin)(void);

typedef int __cdecl (*Tdbmorecmds)(void * Proc);

typedef int __cdecl (*Tdbmoretext)(void * Proc, int Size, Zcompatibility::PByte Text);

typedef char * __cdecl (*Tdbname)(void * Proc);

typedef int __cdecl (*Tdbnextrow)(void * Proc);

typedef int __cdecl (*Tdbnullbind)(void * Proc, int Column, Zplaindblibdriver::PDBINT Indicator);

typedef int __cdecl (*Tdbnumalts)(void * Proc, int ComputeId);

typedef int __cdecl (*Tdbnumcols)(void * Proc);

typedef int __cdecl (*Tdbnumcompute)(void * Proc);

typedef int __cdecl (*Tdbnumorders)(void * Proc);

typedef int __cdecl (*Tdbnumrets)(void * Proc);

typedef void * __cdecl (*Tdbopen)(void * Login, char * Host);

typedef int __cdecl (*Tdbordercol)(void * Proc, int Order);

typedef int __cdecl (*Tdbprocinfo)(void * Proc, Zplaindblibdriver::PDBPROCINFO DbProcInfo);

typedef void __cdecl (*Tdbprhead)(void * Proc);

typedef int __cdecl (*Tdbprrow)(void * Proc);

typedef char * __cdecl (*Tdbprtype)(int Token);

typedef char * __cdecl (*Tdbqual)(void * Proc, int TabNum, char * TabName);

typedef int __cdecl (*Tdbreadtext)(void * Proc, void * Buf, int BufSize);

typedef int __cdecl (*Tdbresults)(void * Proc);

typedef Zcompatibility::PByte __cdecl (*Tdbretdata)(void * Proc, int RetNum);

typedef int __cdecl (*Tdbretlen)(void * Proc, int RetNum);

typedef char * __cdecl (*Tdbretname)(void * Proc, int RetNum);

typedef int __cdecl (*Tdbretstatus)(void * Proc);

typedef int __cdecl (*Tdbrettype)(void * Proc, int RetNum);

typedef int __cdecl (*Tdbrows)(void * Proc);

typedef int __cdecl (*Tdbrowtype)(void * Proc);

typedef int __cdecl (*Tdbrpcinit)(void * Proc, char * ProcName, short Options);

typedef int __cdecl (*Tdbrpcparam)(void * Proc, char * ParamName, Byte Status, int Typ, int MaxLen, 
	int DataLen, Zcompatibility::PByte Value);

typedef int __cdecl (*Tdbrpcsend)(void * Proc);

typedef int __cdecl (*Tdbrpcexec)(void * Proc);

typedef void __cdecl (*Tdbrpwclr)(void * Login);

typedef int __cdecl (*Tdbserverenum)(Word SearchMode, char * ServNameBuf, Word ServNameBufSize, Zcompatibility::PWord 
	NumEntries);

typedef void __cdecl (*Tdbsetavail)(void * Proc);

typedef int __cdecl (*Tdbsetmaxprocs)(short MaxProcs);

typedef int __cdecl (*Tdbsetlname)(void * Login, char * Value, int Item);

typedef int __cdecl (*Tdbsetlogintime)(int Seconds);

typedef int __cdecl (*Tdbsetlpacket)(void * Login, Word PacketSize);

typedef int __cdecl (*Tdbsetnull)(void * Proc, int BindType, int BindLen, Zcompatibility::PByte BindVal
	);

typedef int __cdecl (*Tdbsetopt)(void * Proc, int Option, char * Param);

typedef int __cdecl (*Tdbsettime)(int Seconds);

typedef void __cdecl (*Tdbsetuserdata)(void * Proc, void * Ptr);

typedef int __cdecl (*Tdbsqlexec)(void * Proc);

typedef int __cdecl (*Tdbsqlok)(void * Proc);

typedef int __cdecl (*Tdbsqlsend)(void * Proc);

typedef int __cdecl (*Tdbstrcpy)(void * Proc, int Start, int NumBytes, char * Dest);

typedef int __cdecl (*Tdbstrlen)(void * Proc);

typedef BOOL __cdecl (*Tdbtabbrowse)(void * Proc, int TabNum);

typedef int __cdecl (*Tdbtabcount)(void * Proc);

typedef char * __cdecl (*Tdbtabname)(void * Proc, int Table);

typedef char * __cdecl (*Tdbtabsource)(void * Proc, int Column, Zcompatibility::PInteger TabNum);

typedef int __cdecl (*Tdbtsnewlen)(void * Proc);

typedef Zplaindblibdriver::PDBBINARY __cdecl (*Tdbtsnewval)(void * Proc);

typedef int __cdecl (*Tdbtsput)(void * Proc, Zplaindblibdriver::PDBBINARY NewTs, int NewTsName, int 
	TabNum, char * TableName);

typedef Zplaindblibdriver::PDBBINARY __cdecl (*Tdbtxptr)(void * Proc, int Column);

typedef Zplaindblibdriver::PDBBINARY __cdecl (*Tdbtxtimestamp)(void * Proc, int Column);

typedef Zplaindblibdriver::PDBBINARY __cdecl (*Tdbtxtsnewval)(void * Proc);

typedef int __cdecl (*Tdbtxtsput)(void * Proc, Zplaindblibdriver::PDBBINARY NewTxts, int Column);

typedef int __cdecl (*Tdbuse)(void * Proc, char * DbName);

typedef BOOL __cdecl (*Tdbvarylen)(void * Proc, int Column);

typedef BOOL __cdecl (*Tdbwillconvert)(int SrcType, int DestType);

typedef int __cdecl (*Tdbwritetext)(void * Proc, char * ObjName, Zplaindblibdriver::PDBBINARY TextPtr
	, Byte TextPtrLen, Zplaindblibdriver::PDBBINARY Timestamp, BOOL Log, int Size, Zcompatibility::PByte 
	Text);

typedef int __cdecl (*Tdbupdatetext)(void * Proc, char * DestObject, Zplaindblibdriver::PDBBINARY DestTextPtr
	, Zplaindblibdriver::PDBBINARY DestTimestamp, int UpdateType, int InsertOffset, int DeleteLength, char * 
	SrcObject, int SrcSize, Zplaindblibdriver::PDBBINARY SrcText);

//-- var, const, procedure ---------------------------------------------------
#define WINDOWS_DLL_LOCATION "ntwdblib.dll"
static const Shortint DBSETHOST = 0x1;
static const Shortint DBSETUSER = 0x2;
static const Shortint DBSETPWD = 0x3;
static const Shortint DBSETAPP = 0x4;
static const Shortint DBSETID = 0x5;
static const Shortint DBSETLANG = 0x6;
static const Shortint DBSETSECURE = 0x7;
static const Shortint DBVER42 = 0x8;
static const Shortint DBVER60 = 0x9;
static const Shortint DBSET_LOGIN_TIME = 0xa;
static const Shortint DBSETFALLBACK = 0xc;
extern PACKAGE Tdberrhandle dberrhandle;
extern PACKAGE Tdbmsghandle dbmsghandle;
extern PACKAGE Tdbprocerrhandle dbprocerrhandle;
extern PACKAGE Tdbprocmsghandle dbprocmsghandle;
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
extern PACKAGE Tbcp_setl bcp_setl;
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
extern PACKAGE Tdbcolinfo dbcolinfo;
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
extern PACKAGE Tdbcursorfetchex dbcursorfetchex;
extern PACKAGE Tdbcursorinfo dbcursorinfo;
extern PACKAGE Tdbcursorinfoex dbcursorinfoex;
extern PACKAGE Tdbcursoropen dbcursoropen;
extern PACKAGE Tdbdata dbdata;
extern PACKAGE Tdbdataready dbdataready;
extern PACKAGE Tdbdatecrack dbdatecrack;
extern PACKAGE Tdbdatlen dbdatlen;
extern PACKAGE Tdbdead dbdead;
extern PACKAGE Tdbexit dbexit;
extern PACKAGE TdbWinexit dbWinexit;
extern PACKAGE Tdbenlisttrans dbenlisttrans;
extern PACKAGE Tdbenlistxatrans dbenlistxatrans;
extern PACKAGE Tdbfcmd dbfcmd;
extern PACKAGE Tdbfirstrow dbfirstrow;
extern PACKAGE Tdbfreebuf dbfreebuf;
extern PACKAGE Tdbfreelogin dbfreelogin;
extern PACKAGE Tdbfreequal dbfreequal;
extern PACKAGE Tdbgetchar dbgetchar;
extern PACKAGE Tdbgetmaxprocs dbgetmaxprocs;
extern PACKAGE Tdbgetoff dbgetoff;
extern PACKAGE Tdbgetpacket dbgetpacket;
extern PACKAGE Tdbgetrow dbgetrow;
extern PACKAGE Tdbgettime dbgettime;
extern PACKAGE Tdbgetuserdata dbgetuserdata;
extern PACKAGE Tdbhasretstat dbhasretstat;
extern PACKAGE Tdbinit dbinit;
extern PACKAGE Tdbisavail dbisavail;
extern PACKAGE Tdbiscount dbiscount;
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
extern PACKAGE Tdbprocinfo dbprocinfo;
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
extern PACKAGE Tdbrpcexec dbrpcexec;
extern PACKAGE Tdbrpwclr dbrpwclr;
extern PACKAGE Tdbserverenum dbserverenum;
extern PACKAGE Tdbsetavail dbsetavail;
extern PACKAGE Tdbsetmaxprocs dbsetmaxprocs;
extern PACKAGE Tdbsetlname dbsetlname;
extern PACKAGE Tdbsetlogintime dbsetlogintime;
extern PACKAGE Tdbsetlpacket dbsetlpacket;
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
extern PACKAGE Tdbupdatetext dbupdatetext;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;
extern PACKAGE Classes::TList* MSSqlErrors;
extern PACKAGE Classes::TList* MSSqlMessages;
extern PACKAGE int __fastcall DBSETLHOST(void * Login, char * ClientHost);
extern PACKAGE int __fastcall DBSETLUSER(void * Login, char * UserName);
extern PACKAGE int __fastcall DBSETLPWD(void * Login, char * Passwd);
extern PACKAGE int __fastcall DBSETLAPP(void * Login, char * AppName);
extern PACKAGE int __fastcall DBSETLNATLANG(void * Login, char * Lang);
extern PACKAGE int __fastcall DBSETLSECURE(void * Login);
extern PACKAGE int __fastcall DBSETLVERSION(void * Login, Byte Version);
extern PACKAGE int __fastcall DBSETLTIME(void * Login, unsigned Seconds);
extern PACKAGE int __fastcall DBSETLFALLBACK(void * Login, char * Fallback);
extern PACKAGE int __fastcall dbrbuf(void * Proc);

}	/* namespace Zplaindblibmssql7 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaindblibmssql7;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainDbLibMsSql7
