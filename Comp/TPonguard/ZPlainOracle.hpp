// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainOracle.pas' rev: 5.00

#ifndef ZPlainOracleHPP
#define ZPlainOracleHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainLoader.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainoracle
{
//-- type declarations -------------------------------------------------------
typedef int sword;

typedef int eword;

typedef int uword;

typedef int sb4;

typedef int ub4;

typedef short sb2;

typedef Word ub2;

typedef Shortint sb1;

typedef Byte ub1;

typedef void *dvoid;

typedef char *text;

typedef int size_T;

typedef Byte *pub1;

typedef Shortint *psb1;

typedef Word *pub2;

typedef short *psb2;

typedef int *pub4;

typedef int *psb4;

typedef void *POCIHandle;

typedef void * *PPOCIHandle;

typedef void *POCIEnv;

typedef void *POCIServer;

typedef void *POCIError;

typedef void *POCISvcCtx;

typedef void *POCIStmt;

typedef void *POCIDefine;

typedef void *POCISession;

typedef void *POCIBind;

typedef void *POCIDescribe;

typedef void *POCITrans;

typedef void *POCIDescriptor;

typedef void * *PPOCIDescriptor;

typedef void *POCISnapshot;

typedef void *POCILobLocator;

typedef void *POCIParam;

typedef void *POCIRowid;

typedef void *POCIComplexObjectComp;

typedef void *POCIAQEnqOptions;

typedef void *POCIAQDeqOptions;

typedef void *POCIAQMsgProperties;

typedef void *POCIAQAgent;

struct TXID;
typedef TXID *PXID;

struct TXID
{
	int formatID;
	int gtrid_length;
	int bqual_length;
	Byte data[128];
} ;

typedef void * *PPointer;

typedef int __cdecl (*TOCIInitialize)(int mode, void * ctxp, void * malocfp, void * ralocfp, void * 
	mfreefp);

typedef int __cdecl (*TOCIEnvInit)(void * &envhpp, int mode, int xtramemsz, PPointer usrmempp);

typedef int __cdecl (*TOCIEnvCreate)(void * &envhpp, int mode, void * ctxp, void * malocfp, void * ralocfp
	, void * mfreefp, int xtramemsz, PPointer usrmempp);

typedef int __cdecl (*TOCIHandleAlloc)(void * parenth, void * &hndlpp, int atype, int xtramem_sz, PPointer 
	usrmempp);

typedef int __cdecl (*TOCIServerAttach)(void * srvhp, void * errhp, char * dblink, int dblink_len, int 
	mode);

typedef int __cdecl (*TOCIAttrSet)(void * trgthndlp, int trghndltyp, void * attributep, int size, int 
	attrtype, void * errhp);

typedef int __cdecl (*TOCISessionBegin)(void * svchp, void * errhp, void * usrhp, int credt, int mode
	);

typedef int __cdecl (*TOCISessionEnd)(void * svchp, void * errhp, void * usrhp, int mode);

typedef int __cdecl (*TOCIServerDetach)(void * srvhp, void * errhp, int mode);

typedef int __cdecl (*TOCIHandleFree)(void * hndlp, int atype);

typedef int __cdecl (*TOCIErrorGet)(void * hndlp, int recordno, char * sqlstate, int &errcodep, char * 
	bufp, int bufsiz, int atype);

typedef int __cdecl (*TOCIStmtPrepare)(void * stmtp, void * errhp, char * stmt, int stmt_len, int language
	, int mode);

typedef int __cdecl (*TOCIStmtExecute)(void * svchp, void * stmtp, void * errhp, int iters, int rowoff
	, void * snap_in, void * snap_out, int mode);

typedef int __cdecl (*TOCIParamGet)(void * hndlp, int htype, void * errhp, void * &parmdpp, int pos)
	;

typedef int __cdecl (*TOCIAttrGet)(void * trgthndlp, int trghndltyp, void * attributep, void * sizep
	, int attrtype, void * errhp);

typedef int __cdecl (*TOCIStmtFetch)(void * stmtp, void * errhp, int nrows, Word orientation, int mode
	);

typedef int __cdecl (*TOCIDefineByPos)(void * stmtp, void * &defnpp, void * errhp, int position, void * 
	valuep, int value_sz, Word dty, void * indp, void * rlenp, void * rcodep, int mode);

typedef int __cdecl (*TOCIDefineArrayOfStruct)(void * defnpp, void * errhp, int pvskip, int indskip, 
	int rlskip, int rcskip);

typedef int __cdecl (*TOCIBindByPos)(void * stmtp, void * &bindpp, void * errhp, int position, void * 
	valuep, int value_sz, Word dty, void * indp, void * alenp, void * rcodep, int maxarr_len, void * curelep
	, int mode);

typedef int __cdecl (*TOCIBindByName)(void * stmtp, void * &bindpp, void * errhp, char * placeholder
	, int placeh_len, void * valuep, int value_sz, Word dty, void * indp, void * alenp, void * rcodep, 
	int maxarr_len, void * curelep, int mode);

typedef int __cdecl (*TOCIBindDynamic)(void * bindp, void * errhp, void * ictxp, void * icbfp, void * 
	octxp, void * ocbfp);

typedef int __cdecl (*TOCITransStart)(void * svchp, void * errhp, Word timeout, int flags);

typedef int __cdecl (*TOCITransRollback)(void * svchp, void * errhp, int flags);

typedef int __cdecl (*TOCITransCommit)(void * svchp, void * errhp, int flags);

typedef int __cdecl (*TOCITransDetach)(void * svchp, void * errhp, int flags);

typedef int __cdecl (*TOCITransPrepare)(void * svchp, void * errhp, int flags);

typedef int __cdecl (*TOCITransForget)(void * svchp, void * errhp, int flags);

typedef int __cdecl (*TOCIDescribeAny)(void * svchp, void * errhp, void * objptr, int objnm_len, Byte 
	objptr_typ, Byte info_level, Byte objtyp, void * dschp);

typedef int __cdecl (*TOCIBreak)(void * svchp, void * errhp);

typedef int __cdecl (*TOCIReset)(void * svchp, void * errhp);

typedef int __cdecl (*TOCIDescriptorAlloc)(void * parenth, void * &descpp, int htype, int xtramem_sz
	, void * usrmempp);

typedef int __cdecl (*TOCIDescriptorFree)(void * descp, int htype);

typedef int __cdecl (*TOCILobAppend)(void * svchp, void * errhp, void * dst_locp, void * src_locp);

typedef int __cdecl (*TOCILobAssign)(void * svchp, void * errhp, void * src_locp, void * &dst_locpp)
	;

typedef int __cdecl (*TOCILobClose)(void * svchp, void * errhp, void * locp);

typedef int __cdecl (*TOCILobCopy)(void * svchp, void * errhp, void * dst_locp, void * src_locp, int 
	amount, int dst_offset, int src_offset);

typedef int __cdecl (*TOCILobEnableBuffering)(void * svchp, void * errhp, void * locp);

typedef int __cdecl (*TOCILobDisableBuffering)(void * svchp, void * errhp, void * locp);

typedef int __cdecl (*TOCILobErase)(void * svchp, void * errhp, void * locp, int &amount, int offset
	);

typedef int __cdecl (*TOCILobFileExists)(void * svchp, void * errhp, void * filep, bool &flag);

typedef int __cdecl (*TOCILobFileGetName)(void * envhp, void * errhp, void * filep, char * dir_alias
	, Word &d_length, char * filename, Word &f_length);

typedef int __cdecl (*TOCILobFileSetName)(void * envhp, void * errhp, void * &filep, char * dir_alias
	, Word d_length, char * filename, Word f_length);

typedef int __cdecl (*TOCILobFlushBuffer)(void * svchp, void * errhp, void * locp, int flag);

typedef int __cdecl (*TOCILobGetLength)(void * svchp, void * errhp, void * locp, int &lenp);

typedef int __cdecl (*TOCILobIsOpen)(void * svchp, void * errhp, void * locp, BOOL &flag);

typedef int __cdecl (*TOCILobLoadFromFile)(void * svchp, void * errhp, void * dst_locp, void * src_locp
	, int amount, int dst_offset, int src_offset);

typedef int __cdecl (*TOCILobLocatorIsInit)(void * envhp, void * errhp, void * locp, BOOL &is_initialized
	);

typedef int __cdecl (*TOCILobOpen)(void * svchp, void * errhp, void * locp, Byte mode);

typedef int __cdecl (*TOCILobRead)(void * svchp, void * errhp, void * locp, int &amtp, int offset, void * 
	bufp, int bufl, void * ctxp, void * cbfp, Word csid, Byte csfrm);

typedef int __cdecl (*TOCILobTrim)(void * svchp, void * errhp, void * locp, int newlen);

typedef int __cdecl (*TOCILobWrite)(void * svchp, void * errhp, void * locp, int &amtp, int offset, 
	void * bufp, int bufl, Byte piece, void * ctxp, void * cbfp, Word csid, Byte csfrm);

typedef int __cdecl (*TOCIStmtGetPieceInfo)(void * stmtp, void * errhp, void * &hndlpp, int &typep, 
	Byte &in_outp, int &iterp, int &idxp, Byte &piecep);

typedef int __cdecl (*TOCIStmtSetPieceInfo)(void * handle, int typep, void * errhp, void * buf, int 
	&alenp, Byte piece, void * indp, Word &rcodep);

typedef int __cdecl (*TOCIPasswordChange)(void * svchp, void * errhp, char * user_name, int usernm_len
	, char * opasswd, int opasswd_len, char * npasswd, int npasswd_len, int mode);

typedef int __cdecl (*TOCIServerVersion)(void * hndlp, void * errhp, char * bufp, int bufsz, Byte hndltype
	);

typedef int __cdecl (*TOCIResultSetToStmt)(void * rsetdp, void * errhp);

//-- var, const, procedure ---------------------------------------------------
#define DEFAULT_DLL_LOCATION1 "OCI.DLL"
#define DEFAULT_DLL_LOCATION2 "ORA803.DLL"
static const Shortint MAXTXNAMELEN = 0x40;
static const Byte XIDDATASIZE = 0x80;
static const Shortint MAXGTRIDSIZE = 0x40;
static const Shortint MAXBQUALSIZE = 0x40;
static const Shortint NULLXID_ID = 0xffffffff;
static const int MAXUB4 = 0x7fffffff;
static const int MAXSB4 = 0x7fffffff;
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
static const Shortint OCI_HTYPE_SUBSCRIPTION = 0xd;
static const Shortint OCI_HTYPE_DIRPATH_CTX = 0xe;
static const Shortint OCI_HTYPE_DIRPATH_COLUMN_ARRAY = 0xf;
static const Shortint OCI_HTYPE_DIRPATH_STREAM = 0x10;
static const Shortint OCI_HTYPE_PROC = 0x11;
static const Shortint OCI_HTYPE_LAST = 0x11;
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
static const Shortint OCI_DTYPE_DATETIME = 0x3e;
static const Shortint OCI_DTYPE_INTERVAL = 0x3f;
static const Shortint OCI_DTYPE_AQNFY_DESCRIPTOR = 0x40;
static const Shortint OCI_DTYPE_LAST = 0x40;
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
static const Shortint OCI_SUCCESS = 0x0;
static const Shortint OCI_SUCCESS_WITH_INFO = 0x1;
static const Shortint OCI_NO_DATA = 0x64;
static const Shortint OCI_ERROR = 0xffffffff;
static const Shortint OCI_INVALID_HANDLE = 0xfffffffe;
static const Shortint OCI_NEED_DATA = 0x63;
static const short OCI_STILL_EXECUTING = 0xfffff3cd;
static const short OCI_CONTINUE = 0xffffa178;
static const Shortint OCI_DEFAULT = 0x0;
static const Shortint OCI_THREADED = 0x1;
static const Shortint OCI_OBJECT = 0x2;
static const Shortint OCI_EVENTS = 0x4;
static const Shortint OCI_SHARED = 0x10;
static const Shortint OCI_NO_UCB = 0x40;
static const Byte OCI_NO_MUTEX = 0x80;
static const Shortint OCI_CRED_RDBMS = 0x1;
static const Shortint OCI_CRED_EXT = 0x2;
static const Shortint OCI_CRED_PROXY = 0x3;
static const Shortint OCI_MIGRATE = 0x1;
static const Shortint OCI_SYSDBA = 0x2;
static const Shortint OCI_SYSOPER = 0x4;
static const Shortint OCI_PRELIM_AUTH = 0x8;
static const Shortint OCI_AUTH = 0x8;
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
static const Shortint _SQLT_PLI = 0x1d;
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
static const Shortint SQLT_BFILEE = 0x72;
static const Shortint SQLT_CFILEE = 0x73;
static const Shortint SQLT_RSET = 0x74;
static const Shortint SQLT_NCO = 0x7a;
static const Byte SQLT_VST = 0x9b;
static const Byte SQLT_ODT = 0x9c;
static const Byte _SQLT_REC = 0xfa;
static const Byte _SQLT_TAB = 0xfb;
static const Byte _SQLT_BOL = 0xfc;
static const Shortint OCI_STMT_SELECT = 0x1;
static const Shortint OCI_STMT_UPDATE = 0x2;
static const Shortint OCI_STMT_DELETE = 0x3;
static const Shortint OCI_STMT_INSERT = 0x4;
static const Shortint OCI_STMT_CREATE = 0x5;
static const Shortint OCI_STMT_DROP = 0x6;
static const Shortint OCI_STMT_ALTER = 0x7;
static const Shortint OCI_STMT_BEGIN = 0x8;
static const Shortint OCI_STMT_DECLARE = 0x9;
static const Shortint OCI_NTV_SYNTAX = 0x1;
static const Shortint OCI_V7_SYNTAX = 0x2;
static const Shortint OCI_V8_SYNTAX = 0x3;
static const Shortint OCI_BATCH_MODE = 0x1;
static const Shortint OCI_EXACT_FETCH = 0x2;
static const Shortint OCI_SCROLLABLE_CURSOR = 0x8;
static const Shortint OCI_DESCRIBE_ONLY = 0x10;
static const Shortint OCI_COMMIT_ON_SUCCESS = 0x20;
static const Shortint OCI_NON_BLOCKING = 0x40;
static const Byte OCI_BATCH_ERRORS = 0x80;
static const Word OCI_PARSE_ONLY = 0x100;
static const Shortint OCI_DATA_AT_EXEC = 0x2;
static const Shortint OCI_DYNAMIC_FETCH = 0x2;
static const Shortint OCI_PIECEWISE = 0x4;
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
static const Shortint OCI_ONE_PIECE = 0x0;
static const Shortint OCI_FIRST_PIECE = 0x1;
static const Shortint OCI_NEXT_PIECE = 0x2;
static const Shortint OCI_LAST_PIECE = 0x3;
static const Shortint OCI_FETCH_NEXT = 0x2;
static const Shortint OCI_FETCH_FIRST = 0x4;
static const Shortint OCI_FETCH_LAST = 0x8;
static const Shortint OCI_FETCH_PRIOR = 0x10;
static const Shortint OCI_FETCH_ABSOLUTE = 0x20;
static const Shortint OCI_FETCH_RELATIVE = 0x40;
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
static const Shortint OCI_ATTR_CACHE_ARRAYFLUSH = 0x40;
static const Shortint OCI_ATTR_OBJECT_NEWNOTNULL = 0x10;
static const Shortint OCI_ATTR_OBJECT_DETECTCHANGE = 0x20;
static const Shortint OCI_PARAM_IN = 0x1;
static const Shortint OCI_PARAM_OUT = 0x2;
static const Shortint OCI_LOB_BUFFER_FREE = 0x1;
static const Shortint OCI_LOB_BUFFER_NOFREE = 0x2;
static const Shortint OCI_FILE_READONLY = 0x1;
static const Shortint OCI_LOB_READONLY = 0x1;
static const Shortint OCI_LOB_READWRITE = 0x2;
static const Shortint SQLCS_IMPLICIT = 0x1;
static const Shortint SQLCS_NCHAR = 0x2;
static const Shortint SQLCS_EXPLICIT = 0x3;
static const Shortint SQLCS_FLEXIBLE = 0x4;
static const Shortint SQLCS_LIT_NULL = 0x5;
static const Shortint OCI_OTYPE_NAME = 0x1;
static const Shortint OCI_OTYPE_REF = 0x2;
static const Shortint OCI_OTYPE_PTR = 0x3;
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
static const Shortint OCI_TYPEPARAM_IN = 0x0;
static const Shortint OCI_TYPEPARAM_OUT = 0x1;
static const Shortint OCI_TYPEPARAM_INOUT = 0x2;
static const Shortint OCI_NUMBER_UNSIGNED = 0x0;
static const Shortint OCI_NUMBER_SIGNED = 0x2;
#define cvOracle80000 "8.0.0.0.0"
#define cvOracle80400 "8.0.4.0.0"
#define cvOracle80500 "8.0.5.0.0"
#define cvOracle80501 "8.0.5.0.1"
#define cvOracle81000 "8.1.0.0.0"
#define cvOracle81500 "8.1.5.0.0"
extern PACKAGE TOCIPasswordChange OCIPasswordChange;
extern PACKAGE TOCIInitialize OCIInitialize;
extern PACKAGE TOCIEnvInit OCIEnvInit;
extern PACKAGE TOCIEnvCreate OCIEnvCreate;
extern PACKAGE TOCIHandleAlloc OCIHandleAlloc;
extern PACKAGE TOCIServerAttach OCIServerAttach;
extern PACKAGE TOCIAttrSet OCIAttrSet;
extern PACKAGE TOCISessionBegin OCISessionBegin;
extern PACKAGE TOCISessionEnd OCISessionEnd;
extern PACKAGE TOCIServerDetach OCIServerDetach;
extern PACKAGE TOCIHandleFree OCIHandleFree;
extern PACKAGE TOCIErrorGet OCIErrorGet;
extern PACKAGE TOCIStmtPrepare OCIStmtPrepare;
extern PACKAGE TOCIStmtExecute OCIStmtExecute;
extern PACKAGE TOCIParamGet OCIParamGet;
extern PACKAGE TOCIAttrGet OCIAttrGet;
extern PACKAGE TOCIStmtFetch OCIStmtFetch;
extern PACKAGE TOCIDefineByPos OCIDefineByPos;
extern PACKAGE TOCIDefineArrayOfStruct OCIDefineArrayOfStruct;
extern PACKAGE TOCIBindByPos OCIBindByPos;
extern PACKAGE TOCIBindByName OCIBindByName;
extern PACKAGE TOCITransStart OCITransStart;
extern PACKAGE TOCITransCommit OCITransCommit;
extern PACKAGE TOCITransRollback OCITransRollback;
extern PACKAGE TOCITransDetach OCITransDetach;
extern PACKAGE TOCITransPrepare OCITransPrepare;
extern PACKAGE TOCITransForget OCITransForget;
extern PACKAGE TOCIDescribeAny OCIDescribeAny;
extern PACKAGE TOCIBreak OCIBreak;
extern PACKAGE TOCIReset OCIReset;
extern PACKAGE TOCIDescriptorAlloc OCIDescriptorAlloc;
extern PACKAGE TOCIDescriptorFree OCIDescriptorFree;
extern PACKAGE TOCIStmtGetPieceInfo OCIStmtGetPieceInfo;
extern PACKAGE TOCIStmtSetPieceInfo OCIStmtSetPieceInfo;
extern PACKAGE TOCIServerVersion OCIServerVersion;
extern PACKAGE TOCIBindDynamic OCIBindDynamic;
extern PACKAGE TOCILobAppend OCILobAppend;
extern PACKAGE TOCILobAssign OCILobAssign;
extern PACKAGE TOCILobClose OCILobClose;
extern PACKAGE TOCILobCopy OCILobCopy;
extern PACKAGE TOCILobEnableBuffering OCILobEnableBuffering;
extern PACKAGE TOCILobDisableBuffering OCILobDisableBuffering;
extern PACKAGE TOCILobErase OCILobErase;
extern PACKAGE TOCILobFileExists OCILobFileExists;
extern PACKAGE TOCILobFileGetName OCILobFileGetName;
extern PACKAGE TOCILobFileSetName OCILobFileSetName;
extern PACKAGE TOCILobFlushBuffer OCILobFlushBuffer;
extern PACKAGE TOCILobGetLength OCILobGetLength;
extern PACKAGE TOCILobIsOpen OCILobIsOpen;
extern PACKAGE TOCILobLoadFromFile OCILobLoadFromFile;
extern PACKAGE TOCILobLocatorIsInit OCILobLocatorIsInit;
extern PACKAGE TOCILobOpen OCILobOpen;
extern PACKAGE TOCILobRead OCILobRead;
extern PACKAGE TOCILobTrim OCILobTrim;
extern PACKAGE TOCILobWrite OCILobWrite;
extern PACKAGE TOCIResultSetToStmt OCIResultSetToStmt;
extern PACKAGE AnsiString DllLocation;
extern PACKAGE unsigned DllHandle;
extern PACKAGE AnsiString DllVersion;
extern PACKAGE bool DllLoaded;
extern PACKAGE bool __fastcall OracleLoadLibrary(void);

}	/* namespace Zplainoracle */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainoracle;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainOracle
