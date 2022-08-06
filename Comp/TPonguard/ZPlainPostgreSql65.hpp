// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainPostgreSql65.pas' rev: 5.00

#ifndef ZPlainPostgreSql65HPP
#define ZPlainPostgreSql65HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainLoader.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainpostgresql65
{
//-- type declarations -------------------------------------------------------
typedef int Oid;

#pragma option push -b-
enum ConnStatusType { CONNECTION_OK, CONNECTION_BAD };
#pragma option pop

#pragma option push -b-
enum ExecStatusType { PGRES_EMPTY_QUERY, PGRES_COMMAND_OK, PGRES_TUPLES_OK, PGRES_COPY_OUT, PGRES_COPY_IN, 
	PGRES_BAD_RESPONSE, PGRES_NONFATAL_ERROR, PGRES_FATAL_ERROR };
#pragma option pop

typedef char *pgresStatus[256];

typedef void *PGconn;

typedef void *PPGconn;

typedef void *PGresult;

typedef void *PPGresult;

#pragma pack(push, 1)
struct PGnotify
{
	char relname[32];
	int be_pid;
} ;
#pragma pack(pop)

typedef PGnotify *PPGnotify;

typedef void __cdecl (*PQnoticeProcessor)(void * arg, char * message);

typedef char *PPChar[256];

#pragma pack(push, 1)
struct PQprintOpt
{
	Byte header;
	Byte align;
	Byte standard;
	Byte html3;
	Byte expanded;
	Byte pager;
	char *fieldSep;
	char *tableOpt;
	char *caption;
	char *fieldName[256];
} ;
#pragma pack(pop)

typedef PQprintOpt *PPQprintOpt;

#pragma pack(push, 1)
struct PQconninfoOption
{
	char *keyword;
	char *envvar;
	char *compiled;
	char *val;
	char *lab;
	char *dispchar;
	int dispsize;
} ;
#pragma pack(pop)

typedef PQconninfoOption *PPQConninfoOption;

#pragma pack(push, 1)
struct PQArgBlock
{
	int len;
	int isint;
	bool u;
	union
	{
		struct 
		{
			int _int;
			
		};
		struct 
		{
			int *ptr;
			
		};
		
	};
} ;
#pragma pack(pop)

typedef PQArgBlock *PPQArgBlock;

typedef void * __cdecl (*TPQconnectdb)(char * ConnInfo);

typedef void * __cdecl (*TPQsetdbLogin)(char * Host, char * Port, char * Options, char * Tty, char * 
	Db, char * User, char * Passwd);

typedef PPQConninfoOption __cdecl (*TPQconndefaults)(void);

typedef void __cdecl (*TPQfinish)(void * Handle);

typedef void __cdecl (*TPQreset)(void * Handle);

typedef int __cdecl (*TPQrequestCancel)(void * Handle);

typedef char * __cdecl (*TPQdb)(void * Handle);

typedef char * __cdecl (*TPQuser)(void * Handle);

typedef char * __cdecl (*TPQpass)(void * Handle);

typedef char * __cdecl (*TPQhost)(void * Handle);

typedef char * __cdecl (*TPQport)(void * Handle);

typedef char * __cdecl (*TPQtty)(void * Handle);

typedef char * __cdecl (*TPQoptions)(void * Handle);

typedef ConnStatusType __cdecl (*TPQstatus)(void * Handle);

typedef char * __cdecl (*TPQerrorMessage)(void * Handle);

typedef int __cdecl (*TPQsocket)(void * Handle);

typedef int __cdecl (*TPQbackendPID)(void * Handle);

typedef void __cdecl (*TPQtrace)(void * Handle, void * DebugPort);

typedef void __cdecl (*TPQuntrace)(void * Handle);

typedef void __cdecl (*TPQsetNoticeProcessor)(void * Handle, PQnoticeProcessor Proc, void * Arg);

typedef void * __cdecl (*TPQexec)(void * Handle, char * Query);

typedef PPGnotify __cdecl (*TPQnotifies)(void * Handle);

typedef void __cdecl (*TPQnotifyFree)(PPGnotify Handle);

typedef int __cdecl (*TPQsendQuery)(void * Handle, char * Query);

typedef void * __cdecl (*TPQgetResult)(void * Handle);

typedef int __cdecl (*TPQisBusy)(void * Handle);

typedef int __cdecl (*TPQconsumeInput)(void * Handle);

typedef int __cdecl (*TPQgetline)(void * Handle, char * Str, int length);

typedef int __cdecl (*TPQputline)(void * Handle, char * Str);

typedef int __cdecl (*TPQgetlineAsync)(void * Handle, char * Buffer, int BufSize);

typedef int __cdecl (*TPQputnbytes)(void * Handle, char * Buffer, int NBytes);

typedef int __cdecl (*TPQendcopy)(void * Handle);

typedef void * __cdecl (*TPQfn)(void * Handle, int fnid, Zcompatibility::PInteger result_buf, Zcompatibility::PInteger 
	result_len, int result_is_int, PPQArgBlock args, int nargs);

typedef ExecStatusType __cdecl (*TPQresultStatus)(void * Result);

typedef char * __cdecl (*TPQresultErrorMessage)(void * Result);

typedef int __cdecl (*TPQntuples)(void * Result);

typedef int __cdecl (*TPQnfields)(void * Result);

typedef int __cdecl (*TPQbinaryTuples)(void * Result);

typedef char * __cdecl (*TPQfname)(void * Result, int field_num);

typedef int __cdecl (*TPQfnumber)(void * Result, char * field_name);

typedef int __cdecl (*TPQftype)(void * Result, int field_num);

typedef int __cdecl (*TPQfsize)(void * Result, int field_num);

typedef int __cdecl (*TPQfmod)(void * Result, int field_num);

typedef char * __cdecl (*TPQcmdStatus)(void * Result);

typedef int __cdecl (*TPQoidValue)(void * Result);

typedef char * __cdecl (*TPQoidStatus)(void * Result);

typedef char * __cdecl (*TPQcmdTuples)(void * Result);

typedef char * __cdecl (*TPQgetvalue)(void * Result, int tup_num, int field_num);

typedef int __cdecl (*TPQgetlength)(void * Result, int tup_num, int field_num);

typedef int __cdecl (*TPQgetisnull)(void * Result, int tup_num, int field_num);

typedef void __cdecl (*TPQclear)(void * Result);

typedef void * __cdecl (*TPQmakeEmptyPGresult)(void * Handle, ExecStatusType status);

typedef int __cdecl (*Tlo_open)(void * Handle, int lobjId, int mode);

typedef int __cdecl (*Tlo_close)(void * Handle, int fd);

typedef int __cdecl (*Tlo_read)(void * Handle, int fd, char * buf, int len);

typedef int __cdecl (*Tlo_write)(void * Handle, int fd, char * buf, int len);

typedef int __cdecl (*Tlo_lseek)(void * Handle, int fd, int offset, int whence);

typedef int __cdecl (*Tlo_creat)(void * Handle, int mode);

typedef int __cdecl (*Tlo_tell)(void * Handle, int fd);

typedef int __cdecl (*Tlo_unlink)(void * Handle, int lobjId);

typedef int __cdecl (*Tlo_import)(void * Handle, char * filename);

typedef int __cdecl (*Tlo_export)(void * Handle, int lobjId, char * filename);

//-- var, const, procedure ---------------------------------------------------
#define WINDOWS1_DLL_LOCATION "libpq65.dll"
#define LINUX_DLL_LOCATION "libpq.so"
static const Shortint NAMEDATALEN = 0x20;
static const Shortint OIDNAMELEN = 0x24;
static const int INV_WRITE = 0x20000;
static const int INV_READ = 0x40000;
static const Shortint BLOB_SEEK_SET = 0x0;
static const Shortint BLOB_SEEK_CUR = 0x1;
static const Shortint BLOB_SEEK_END = 0x2;
extern PACKAGE TPQconnectdb PQconnectdb;
extern PACKAGE TPQsetdbLogin PQsetdbLogin;
extern PACKAGE TPQconndefaults PQconndefaults;
extern PACKAGE TPQfinish PQfinish;
extern PACKAGE TPQreset PQreset;
extern PACKAGE TPQrequestCancel PQrequestCancel;
extern PACKAGE TPQdb PQdb;
extern PACKAGE TPQuser PQuser;
extern PACKAGE TPQpass PQpass;
extern PACKAGE TPQhost PQhost;
extern PACKAGE TPQport PQport;
extern PACKAGE TPQtty PQtty;
extern PACKAGE TPQoptions PQoptions;
extern PACKAGE TPQstatus PQstatus;
extern PACKAGE TPQerrorMessage PQerrorMessage;
extern PACKAGE TPQsocket PQsocket;
extern PACKAGE TPQbackendPID PQbackendPID;
extern PACKAGE TPQtrace PQtrace;
extern PACKAGE TPQuntrace PQuntrace;
extern PACKAGE TPQsetNoticeProcessor PQsetNoticeProcessor;
extern PACKAGE TPQexec PQexec;
extern PACKAGE TPQnotifies PQnotifies;
extern PACKAGE TPQnotifyFree PQnotifyFree;
extern PACKAGE TPQsendQuery PQsendQuery;
extern PACKAGE TPQgetResult PQgetResult;
extern PACKAGE TPQisBusy PQisBusy;
extern PACKAGE TPQconsumeInput PQconsumeInput;
extern PACKAGE TPQgetline PQgetline;
extern PACKAGE TPQputline PQputline;
extern PACKAGE TPQgetlineAsync PQgetlineAsync;
extern PACKAGE TPQputnbytes PQputnbytes;
extern PACKAGE TPQendcopy PQendcopy;
extern PACKAGE TPQfn PQfn;
extern PACKAGE TPQresultStatus PQresultStatus;
extern PACKAGE TPQresultErrorMessage PQresultErrorMessage;
extern PACKAGE TPQntuples PQntuples;
extern PACKAGE TPQnfields PQnfields;
extern PACKAGE TPQbinaryTuples PQbinaryTuples;
extern PACKAGE TPQfname PQfname;
extern PACKAGE TPQfnumber PQfnumber;
extern PACKAGE TPQftype PQftype;
extern PACKAGE TPQfsize PQfsize;
extern PACKAGE TPQfmod PQfmod;
extern PACKAGE TPQcmdStatus PQcmdStatus;
extern PACKAGE TPQoidValue PQoidValue;
extern PACKAGE TPQoidStatus PQoidStatus;
extern PACKAGE TPQcmdTuples PQcmdTuples;
extern PACKAGE TPQgetvalue PQgetvalue;
extern PACKAGE TPQgetlength PQgetlength;
extern PACKAGE TPQgetisnull PQgetisnull;
extern PACKAGE TPQclear PQclear;
extern PACKAGE TPQmakeEmptyPGresult PQmakeEmptyPGresult;
extern PACKAGE Tlo_open lo_open;
extern PACKAGE Tlo_close lo_close;
extern PACKAGE Tlo_read lo_read;
extern PACKAGE Tlo_write lo_write;
extern PACKAGE Tlo_lseek lo_lseek;
extern PACKAGE Tlo_creat lo_creat;
extern PACKAGE Tlo_tell lo_tell;
extern PACKAGE Tlo_unlink lo_unlink;
extern PACKAGE Tlo_import lo_import;
extern PACKAGE Tlo_export lo_export;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;

}	/* namespace Zplainpostgresql65 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainpostgresql65;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainPostgreSql65
