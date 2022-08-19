{$I XSqlDir.inc}
unit XSOra {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, Registry, SyncObjs,
{$IFDEF XSQL_VCL6}
  FmtBcd, Variants,
{$ENDIF}
{$IFDEF XSQL_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  XSConsts, XSCommon;

const
	(* 	FETCH RETURN CODES 	*)
  FetRTru = 1;			// data truncated
  FetRSin = 2;			// signed number fetched
  FetRDnn = 3;			// data is not numeric
  FetRNof = 4;			// numeric overflow
  FetRDtn = 5;			// data type not supported
  FetRDnd = 6;			// data is not in date format
  FetRNul = -1;			// data is null

{*******************************************************************************
*	limits.h - implementation dependent values                             *
*Purpose:                                                                      *
*       Contains defines for a number of implementation dependent values       *
*       which are commonly used in C programs.                                 *
*******************************************************************************}
const
  CHAR_BIT	= 8;         	// number of bits in a char
  SCHAR_MIN   	= -128;      	// minimum signed char value
  SCHAR_MAX     = 127;       	// maximum signed char value
  UCHAR_MAX     = $FF;      	// maximum unsigned char value
  CHAR_MIN      = 0;
  CHAR_MAX    	= UCHAR_MAX;

  MB_LEN_MAX    = 2;            	// max. # bytes in multibyte char
  SHRT_MIN     	= -32768;     		// minimum (signed) short value
  SHRT_MAX      = 32767;        	// maximum (signed) short value
  USHRT_MAX     = $FFFF;        	// maximum unsigned short value
  INT_MIN     	= (-2147483647 - 1); 	// minimum (signed) int value
  INT_MAX       = 2147483647;		// maximum (signed) int value
  UINT_MAX      = $FFFFFFFF;     	// maximum unsigned int value
  LONG_MIN    	= (-2147483647 - 1); 	// minimum (signed) long value
  LONG_MAX      = 2147483647;     	// maximum (signed) long value
  ULONG_MAX     = $FFFFFFFF;  		// maximum unsigned long value

{*******************************************************************************
*				OraTypes.h                                     *
*******************************************************************************}
//const
// #define boolean int
//  TRUE	= 1;
//  FALSE = 0;

type
  eword		= Integer;			// use where sign not important
  uword		= Integer;			// use where unsigned important
  sword		= Integer;			// use where   signed important
  size_t	= Integer;
  OraBoolean	= LongBool;			// 4 byte

const
  EWORDMAXVAL  	= INT_MAX;
  EWORDMINVAL  	= 0;
  UWORDMAXVAL  	= UINT_MAX;
  UWORDMINVAL  	= 0;
  SWORDMAXVAL  	= INT_MAX;
  SWORDMINVAL  	= INT_MIN;
  MINEWORDMAXVAL= 32767;
  MAXEWORDMINVAL= 0;
  MINUWORDMAXVAL= 65535;
  MAXUWORDMINVAL= 0;
  MINSWORDMAXVAL= 32767;
  MAXSWORDMINVAL= -32767;

const
  EB1MAXVAL 	= SCHAR_MAX;
  EB1MINVAL 	= 0;
  UB1MAXVAL 	= UCHAR_MAX;
  UB1MINVAL 	= 0;
  SB1MAXVAL 	= SCHAR_MAX;
  SB1MINVAL 	= SCHAR_MIN;
  MINEB1MAXVAL  = 127;
  MAXEB1MINVAL  = 0;
  MINUB1MAXVAL  = 255;
  MAXUB1MINVAL  = 0;
  MINSB1MAXVAL  = 127;
  MAXSB1MINVAL  = -127;
// number of bits in a byte
  UB1BITS       = CHAR_BIT;
  UB1MASK       = $FF;

const
  EB2MAXVAL 	= SHRT_MAX;
  EB2MINVAL 	= 0;
  UB2MAXVAL 	= USHRT_MAX;
  UB2MINVAL 	= 0;
  SB2MAXVAL 	= SHRT_MAX;
  SB2MINVAL 	= SHRT_MIN;
  MINEB2MAXVAL	= 32767;
  MAXEB2MINVAL  = 0;
  MINUB2MAXVAL 	= 65535;
  MAXUB2MINVAL  = 0;
  MINSB2MAXVAL 	= 32767;
  MAXSB2MINVAL	= -32767;

type
// human readable (printable) characters
  PText		= TSDCharPtr;
  PPText	= ^PText;
  POraText	= PText;	// in Oracle9: oratext = text = unsigned char (oratypes.h)

  eb1		= ShortInt;		// use where sign not important
  ub1		= Byte;			// use where unsigned important
  sb1		= ShortInt;		// use where   signed important

  eb2		= SmallInt;		// use where sign not important
  ub2		= Word;			// use where unsigned important
  sb2		= SmallInt;		// use where   signed important

  eb4		= LongInt;		// use where sign not important
  ub4		= LongInt;		// use where unsigned important
  sb4		= LongInt;		// use where   signed important

const
  EB4MAXVAL 	= INT_MAX;
  EB4MINVAL     = 0;
  UB4MAXVAL 	= UINT_MAX;
  UB4MINVAL     = 0;
  SB4MAXVAL  	= INT_MAX;
  SB4MINVAL  	= INT_MIN;
  MINEB4MAXVAL	= 2147483647;
  MAXEB4MINVAL  = 0;
  MINUB4MAXVAL 	= UINT_MAX;
  MAXUB4MINVAL  = 0;
  MINSB4MAXVAL 	= 2147483647;
  MAXSB4MINVAL 	= -2147483647;

type
  ubig_ora	= LongInt;		// use where unsigned important
  sbig_ora	= LongInt;		// use where   signed important
const
  UBIG_ORAMAXVAL 	= ULONG_MAX;
  UBIG_ORAMINVAL        = 0;
  SBIG_ORAMAXVAL  	= LONG_MAX;
  SBIG_ORAMINVAL  	= LONG_MIN;
  MINUBIG_ORAMAXVAL 	= 2147483647;
  MAXUBIG_ORAMINVAL     = 0;
  MINSBIG_ORAMAXVAL  	= 2147483647;
  MAXSBIG_ORAMINVAL 	= -2147483647;

const
  SIZE_TMAXVAL		= UB4MAXVAL;		// This case applies for others
  MINSIZE_TMAXVAL 	= 65535;
  SizeOfPtr		= SizeOf(LongInt);

type
  dvoid 		= TSDPtr;
{$IFDEF XSQL_CLR}
  Pdvoid 		= dvoid;
  PPdvoid		= dvoid;
  eb1p		= dvoid;
  ub1p		= dvoid;
  sb1p		= dvoid;
  eb2p		= dvoid;
  ub2p		= dvoid;
  ub2pp		= dvoid;
  sb2p		= dvoid;
  eb4p		= dvoid;
  ub4p		= dvoid;
  ub4pp		= dvoid;
  sb4p		= dvoid;
{$ELSE}
  Pdvoid 		= ^dvoid;
  PPdvoid		= ^Pdvoid;
  eb1p		= ^eb1;
  ub1p		= ^ub1;
  sb1p		= ^sb1;
  eb2p		= ^eb2;
  ub2p		= ^ub2;
  ub2pp		= ^ub2p;
  sb2p		= ^sb2;
  eb4p		= ^eb4;
  ub4p		= ^ub4;
  ub4pp		= ^ub4p;
  sb4p		= ^sb4;
{$ENDIF}

{*******************************************************************************
*	ocidfn.h
*   Common header file for OCI C sample programs.                              *
*   This header declares the cursor and logon data area structure.             *
*   The types used are defined in <oratypes.h>.                                *
*******************************************************************************}
type
// 	The cda_head struct is strictly PRIVATE.  It is used
//   internally only. Do not use this struct in OCI programs.
  cda_head = record
    v2_rc:	sb2;
    ft:   	ub2;
    rpc:  	ub4;
    peo:  	ub2;
    fc:   	ub1;
    rcs1: 	ub1;
    rc:   	ub2;
    wrn:  	ub1;
    rcs2: 	ub1;
    rcs3:	sword;
    rcs4:	ub4;
    rcs5:   	ub2;
    rcs6:   	ub1;
    rcs7:	ub4;
    rcs8:     	ub2;
    ose:        sword;
    chk:        ub1;
    rcsp:      	dvoid;
  end;

const
  CDA_SIZE 	= 64;
  LDA_SIZE 	= CDA_SIZE;
  HDA_SIZE 	= 256;
  CDA_HEAD_SIZE = {$IFDEF XSQL_CLR} 48 {$ELSE} SizeOf(cda_head) {$ENDIF};

type
	 // rowid structures
  rd = record
    rcs4: ub4;
    rcs5: ub2;
    rcs6: ub1;
  end;
  rid = record
    r: 	  rd;
    rcs7: ub4;
    rcs8: ub2;
  end;

{$IFDEF XSQL_CLR}
  [StructLayout(LayoutKind.Sequential)]
  cda_def = record
    v2_rc:	sb2;         	// V2 return code
    ft:         ub2;      	// SQL function type
    rpc:        ub4;   		// rows processed count
    peo:        ub2;     	// parse error offset
    fc:         ub1;      	// OCI function code
    rcs1:       ub1;            // filler area
    rc:         ub2;         	// V7 return code
    wrn:        ub1;          	// warning flags
    rcs2:       ub1;            // reserved
    rcs3:       sword;      	// reserved
    rowid:	rid;		// rowid structure
    ose:	sword;		// OSD dependent error
    chk:	ub1;
    rcsp:	dvoid;		// pointer to reserved area
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = CDA_SIZE - CDA_HEAD_SIZE)]
    rcs9:	packed array[1..CDA_SIZE - CDA_HEAD_SIZE] of ub1; // filler
  end;
{$ELSE}
// the real CDA, padded to CDA_SIZE bytes in size
  cda_def = record
    v2_rc:	sb2;         	// V2 return code
    ft:         ub2;      	// SQL function type
    rpc:        ub4;   		// rows processed count
    peo:        ub2;     	// parse error offset
    fc:         ub1;      	// OCI function code
    rcs1:       ub1;            // filler area
    rc:         ub2;         	// V7 return code
    wrn:        ub1;          	// warning flags
    rcs2:       ub1;            // reserved
    rcs3:       sword;      	// reserved
    rowid:	rid;		// rowid structure
    ose:	sword;		// OSD dependent error
    chk:	ub1;
    rcsp:	dvoid;		// pointer to reserved area
    rcs9:	array[1..CDA_SIZE - CDA_HEAD_SIZE] of ub1; // filler
  end;
{$ENDIF}

// the logon data area (LDA) is the same shape as the CDA
  TCdaDef	= cda_def;
  Lda_Def	= Cda_Def;
  TLdaDef	= Lda_Def;
  THdaDef	= array[1..HDA_SIZE div 4] of ub4;

{$IFDEF XSQL_CLR}
  PHdaDef	= dvoid;
  PCdaDef	= dvoid;
  PLdaDef	= dvoid;
{$ELSE}
  PHdaDef	= ^THdaDef;
  PCdaDef	= ^TCdaDef;
  PLdaDef	= ^TLdaDef;
{$ENDIF}

const
	// OCI Environment Modes for opinit call
  OCI_EV_DEF 	= 0; 		// default single-threaded environment
  OCI_EV_TSF 	= 1;		// thread-safe environment

	// OCI Logon Modes for olog call
  OCI_LM_DEF 	= 0;  		// default login
  OCI_LM_NBL 	= 1;		// non-blocking logon

// OCI_*_PIECE defines the piece types that are returned or set
  OCI_ONE_PIECE  = 0;		// there or this is the only piece
  OCI_FIRST_PIECE= 1;    	// the first of many pieces
  OCI_NEXT_PIECE = 2;     	// the next of many pieces
  OCI_LAST_PIECE = 3;		// the last piece of this column

	// input data types
  SQLT_CHR	= 1;     	// (ORANET TYPE) character string
  SQLT_NUM	= 2;       	// (ORANET TYPE) oracle numeric
  SQLT_INT	= 3;            // (ORANET TYPE) integer
  SQLT_FLT	= 4;   		// (ORANET TYPE) Floating point number
  SQLT_STR	= 5;            // zero terminated string
  SQLT_VNU	= 6;     	// NUM with preceding length byte
  SQLT_PDN	= 7;  		// (ORANET TYPE) Packed Decimal Numeric
  SQLT_LNG	= 8;            // long
  SQLT_VCS	= 9;          	// Variable character string
  SQLT_NON	= 10;   	// Null/empty PCC Descriptor entry
  SQLT_RID	= 11;           // rowid
  SQLT_DAT	= 12;           // date in oracle format
  SQLT_VBI	= 15;           // binary in VCS format
  SQLT_BIN	= 23;           // binary data(DTYBIN)
  SQLT_LBI	= 24;           // long binary
  SQLT_UIN	= 68;           // unsigned integer
  SQLT_SLS	= 91;     	// Display sign leading separate
  SQLT_LVC	= 94;           // Longer longs (char)
  SQLT_LVB	= 95;           // Longer long binary
  SQLT_AFC	= 96;           // Ansi fixed char
  SQLT_AVC	= 97;           // Ansi Var char
  SQLT_CUR	= 102;          // cursor  type
  SQLT_RDD	= 104;		// rowid descriptor
  SQLT_LAB	= 105;          // label type
  SQLT_OSL	= 106;          // oslabel type

  SQLT_NTY 	= 108;          // named object type
  SQLT_REF 	= 110;          // ref type
  SQLT_CLOB	= 112;          // character lob
  SQLT_BLOB	= 113;          // binary lob
  SQLT_BFILE	= 114;          // binary file lob
  SQLT_CFILE	= 115;          // character file lob
  SQLT_RSET	= 116;          // result set type
  SQLT_NCO 	= 122;          // named collection type (varray or nested table)
  SQLT_VST 	= 155;          // OCIString type
  SQLT_ODT 	= 156;          // OCIDate type

// datetimes and intervals
  SQLT_DATE         	= 184;  // ANSI Date
  SQLT_TIME         	= 185;  // TIME
  SQLT_TIME_TZ      	= 186;  // TIME WITH TIME ZONE
  SQLT_TIMESTAMP    	= 187;  // TIMESTAMP
  SQLT_TIMESTAMP_TZ 	= 188;  // TIMESTAMP WITH TIME ZONE
  SQLT_INTERVAL_YM  	= 189;  // INTERVAL YEAR TO MONTH
  SQLT_INTERVAL_DS  	= 190;  // INTERVAL DAY TO SECOND
  SQLT_TIMESTAMP_LTZ	= 232;  // TIMESTAMP WITH LOCAL TZ

  SQLT_PNTY  		= 241;	// pl/sql representation of named types

// CHAR/NCHAR/VARCHAR2/NVARCHAR2/CLOB/NCLOB char set "form" information
  SQLCS_IMPLICIT= 1;		// for CHAR, VARCHAR2, CLOB w/o a specified set
  SQLCS_NCHAR  	= 2; 		// for NCHAR, NCHAR VARYING, NCLOB
  SQLCS_EXPLICIT= 3; 		// for CHAR, etc, with "CHARACTER SET ..." syntax
  SQLCS_FLEXIBLE= 4; 		// for PL/SQL "flexible" parameters
  SQLCS_LIT_NULL= 5; 		// for typecheck of NULL and empty_clob() lits


{*******************************************************************************
*   Declare the OCI functions.                                                 *
*   Prototype information is included.                                         *
*   Use this header for ANSI C compilers.                                      *
*******************************************************************************}
{$IFNDEF XSQL_CLR}
var
	{ OCI BIND (Piecewise or with Skips) }
  obindps: function(cursor: PCdaDef; opcode: ub1; sqlvar: PText;
	       sqlvl: sb4; pvctx: dvoid; progvl: sb4; ftype, scale: sword;
	       ind, alen, arcode: ub2p;
	       pv_skip, ind_skip, alen_skip, rc_skip: sb4;
	       maxsiz: ub4; cursiz: ub4p;
	       fmt: PText; fmtl: sb4; fmtt: sword): sword; cdecl;
  obreak: function(ldaptr: PCdaDef): sword; cdecl;
  ocan: function(cursor: PCdaDef): sword; cdecl;
  oclose: function(cursor: PCdaDef): sword; cdecl;
  ocof: function(ldaptr: PCdaDef): sword; cdecl;
  ocom: function(ldaptr: PCdaDef): sword; cdecl;
  ocon: function(ldaptr: PCdaDef): sword; cdecl;


	{ OCI DEFINe (Piecewise or with Skips) }
  odefinps: function(cursor: PCdaDef; opcode: ub1; pos: sword; bufctx: PText;
		bufl: sb4; ftype, scale: sword;	indp: sb2p;
                fmt: PText; fmtl: sb4; fmtt: sword; rlen, rcode: ub2p;
		pv_skip, ind_skip, alen_skip, rc_skip: sb4): sword; cdecl;
  odessp: function(cursor: PCdaDef; objnam: PText; onlen: size_t;
              rsv1: ub1p; rsv1ln: size_t; rsv2: ub1p; rsv2ln: size_t;
              ovrld, pos, level: ub2p; text: PText;
              arnlen, dtype: ub2p; defsup, mode: ub1p;
              dtsiz: ub4p; prec, scale: sb2p; radix: ub1p;
              spare: ub4p; var arrsiz: ub4): sword; cdecl;
  odescr: function(cursor: PCdaDef; pos: sword; var dbsize: sb4;
                 var dbtype: sb2; cbuf: PText; var cbufl, dsize: sb4;
                 var prec, scale, nullok: sb2): sword; cdecl;
  oerhms: function(ldaptr: PLdaDef; rcode: sb2; buf: PText;
                 bufsiz: sword): sword; cdecl;
  oermsg: function(rcode: sb2; buf: PText): sword; cdecl;
  oexec : function(cursor: PCdaDef): sword; cdecl;
  oexfet: function(cursor: PCdaDef; nrows: ub4; cancel, exact: sword): sword; cdecl;
  oexn: function(cursor: PCdaDef; iters, rowoff: sword): sword; cdecl;
  ofen: function(cursor: PCdaDef; nrows: sword): sword; cdecl;
  ofetch: function(cursor: PCdaDef): sword; cdecl;
  oflng: function(cursor: PCdaDef; pos: sword; buf: PText;
                 bufl: sb4; dtype: sword; var retl: ub4; offset: sb4): sword; cdecl;
  ogetpi: function(cursor: PCdaDef; var piece: ub1; var ctxp: dvoid;
                 var iter, index: ub4): sword; cdecl;
  oopt: function(cursor: PCdaDef; rbopt, waitopt: sword): sword; cdecl;
  opinit: function(mode: ub4): sword; cdecl;
  olog: function(ldaptr: PLdaDef; hdaptr: PHdaDef;
                 uid: PText; uidl: sword;
                 pswd: PText; pswdl: sword;
                 conn: PText; connl: sword;
                 mode: ub4): sword; cdecl;
  ologof: function(ldaptr: PLdaDef): sword; cdecl;
  oopen: function(cursor: PCdaDef; ldaptr: PCdaDef;
                 dbn: PText; dbnl, arsize: sword;
                 uid: PText; uidl: sword): sword; cdecl;
  oparse: function(cursor: PCdaDef; sqlstm: PText; sqllen: sb4;
            defflg: sword; lngflg: ub4): sword; cdecl;
  orol: function(ldaptr: PCdaDef): sword; cdecl;
  osetpi: function(cursor: PCdaDef; piece: ub1; bufp: dvoid; var len: ub4): sword; cdecl;

	{ non-blocking functions }
  onbset: function(ldaptr: PCdaDef): sword; cdecl;
  onbtst: function(ldaptr: PCdaDef): sword; cdecl;
  onbclr: function(ldaptr: PCdaDef): sword; cdecl;
//  ognfd: function(var lda: TCdaDef; fdp: dvoid): sword; cdecl; Function is not exist in OCI 7.2 and some OCI 7.3

{************************* OBSOLETE CALLS ********************************}

	{ OBSOLETE BIND CALLS }
  obndra: function(cursor: PCdaDef; sqlvar: PText; sqlvl: sword;
  		progv: PText; progvl, ftype, scale: sword;
                indp: sb2p; alen, arcode: ub2p; maxsiz: ub4;
                cursiz: ub4p; fmt: PText; fmtl, fmtt: sword): sword; cdecl;
  obndrn: function(cursor: PCdaDef; sqlvn: sword;
  		progv: PText; progvl, ftype, scale: sword;
                indp: sb2p; fmt: PText; fmtl, fmtt: sword): sword; cdecl;
  obndrv: function(cursor: PCdaDef; sqlvar: PText; sqlvl: sword;
  		progv: PText; progvl, ftype, scale: sword;
                indp: sb2p; fmt: PText; fmtl, fmtt: sword): sword; cdecl;

	{ OBSOLETE DEFINE CALLS }
  odefin: function(cursor: PCdaDef; pos: sword; buf: PText;
  		bufl, ftype, scale: sword; indp: sb2p;
                fmt: PText; fmtl, fmtt: sword; rlen, rcode: ub2p): sword; cdecl;
{$ENDIF}

const
  MAXERRMSG		= 1000;
  DEFERRED_PARSE	= 1;
  ORACLE7_PARSE		= 2;
	// Oracle command type
  ORA_CT_CTB		= 1;	//  CREATE TABLE
  ORA_CT_SRL		= 2;	//  SET ROLE
  ORA_CT_INS		= 3;	//  INSERT
  ORA_CT_SEL		= 4;	//  SELECT
  ORA_CT_UPD		= 5;	//  UPDATE
  ORA_CT_DRL		= 6;	//  DROP ROLE
  ORA_CT_DVW		= 7;	//  DROP VIEW
  ORA_CT_DTB		= 8;	//  DROP TABLE
  ORA_CT_DEL		= 9;	//  DELETE
  ORA_CT_CVW		= 10;	//  CREATE VIEW
  ORA_CT_DUS		= 11;	//  DROP USER
  ORA_CT_CRL		= 12;	//  CREATE ROLE
  ORA_CT_CSQ		= 13;	//  CREATE SEQUENCE
  ORA_CT_ASQ		= 14;	//  ALTER SEQUENCE
//  ORA_CT_		= 15;	  (not used)
  ORA_CT_DSQ		= 16;	//  DROP SEQUENCE
  ORA_CT_CSC		= 17;	//  CREATE SCHEMA
  ORA_CT_CCL		= 18;	//  CREATE CLUSTER
  ORA_CT_CUS		= 19;	//  CREATE USER
  ORA_CT_CIN		= 20;	//  CREATE INDEX
  ORA_CT_DIN		= 21;	//  DROP INDEX
  ORA_CT_DCL		= 22;	//  DROP CLUSTER
  ORA_CT_VIN		= 23;	//  VALIDATE INDEX
  ORA_CT_CPR		= 24;	//  CREATE PROCEDURE
  ORA_CT_APR		= 25;	//  ALTER PROCEDURE
  ORA_CT_ATB		= 26;	//  ALTER TABLE
  ORA_CT_EXP		= 27;	//  EXPLAIN
  ORA_CT_GRT		= 28;	//  GRANT
  ORA_CT_RVK		= 29;	//  REVOKE
  ORA_CT_CSY		= 30;	//  CREATE SYNONYM
  ORA_CT_DSY		= 31;	//  DROP SYNONYM
//  ORA_CT_		= 32;	//  ALTER SYSTEM SWITCH LOG
  ORA_CT_STR		= 33;	//  SET TRANSACTION
  ORA_CT_PEX		= 34;	//  PL/SQL EXECUTE
  ORA_CT_LTB		= 35;	//  LOCK TABLE
//  ORA_CT_		= 36;  (not used)
  ORA_CT_REN		= 37;	//  RENAME
  ORA_CT_COM		= 38;	//  COMMENT
  ORA_CT_AUD		= 39;	//  AUDIT
  ORA_CT_NAU		= 40;	//  NOAUDIT
  ORA_CT_AIN		= 41;	//  ALTER INDEX
//  ORA_CT_		= 42;	//  CREATE EXTERNAL DATABASE
//  ORA_CT_		= 43;	//  DROP EXTERNAL DATABASE
  ORA_CT_CDB		= 44;	//  CREATE DATABASE
  ORA_CT_ADB		= 45;	//  ALTER DATABASE
//  ORA_CT_		= 46;	//  CREATE ROLLBACK SEGMENT
//  ORA_CT_		= 47;	//  ALTER ROLLBACK SEGMENT
//  ORA_CT_		= 48;	//  DROP ROLLBACK SEGMENT
  ORA_CT_CTS		= 49;	//  CREATE TABLESPACE
  ORA_CT_ATS		= 50;	//  ALTER TABLESPACE
  ORA_CT_DTS		= 51;	//  DROP TABLESPACE
  ORA_CT_ASE		= 52;	//  ALTER SESSION
  ORA_CT_AUS		= 53;	//  ALTER USER
  ORA_CT_CMT		= 54;	//  COMMIT
  ORA_CT_RBK		= 55;	//  ROLLBACK
  ORA_CT_SVP		= 56;	//  SAVEPOINT
//  ORA_CT_		= 57;	//  CREATE CONTROL FILE
//  ORA_CT_ATRC		= 58;	//  ALTER TRACING
  ORA_CT_CTR		= 59;	//  CREATE TRIGGER
  ORA_CT_ATR		= 60;	//  ALTER TRIGGER
  ORA_CT_DTR		= 61;	//  DROP TRIGGER
//  ORA_CT_		= 62;	//  ANALYZE TABLE
//  ORA_CT_		= 63;	//  ANALYZE INDEX
//  ORA_CT_		= 64;	//  ANALYZE CLUSTER
  ORA_CT_CPF		= 65;	//  CREATE PROFILE
  ORA_CT_DPF		= 66;	//  DROP PROFILE
  ORA_CT_APF		= 67;	//  ALTER PROFILE
  ORA_CT_DPR		= 68;	//  DROP PROCEDURE
//  ORA_CT_		= 69;	  (not used)
//  ORA_CT_		= 70;	//  ALTER RESOURCE COST
//  ORA_CT_		= 71;	//  CREATE SNAPSHOT LOG
//  ORA_CT_		= 72;	//  ALTER SNAPSHOT LOG
//  ORA_CT_		= 73;	//  DROP SNAPSHOT LOG
  ORA_CT_CSN		= 74;	//  CREATE SNAPSHOT
  ORA_CT_ASN		= 75;	//  ALTER SNAPSHOT
  ORA_CT_DSN		= 76;	//  DROP SNAPSHOT

  	// Oracle Internal Datatypes Sizes
  ORA_DTS_VARCHAR2 	= 2000;	// 2000 bytes
  ORA_DTS_NUMBER 	= 21;	// 21 bytes
  ORA_DTS_LONG 		= 0;	// 2^31-1 bytes
  ORA_DTS_ROWID 	= 6;	// 6 bytes
  ORA_DTS_DATE 		= 7;	// 7 bytes
  ORA_DTS_RAW 		= 255;	// 255 bytes
  ORA_DTS_LONG_RAW 	= 0;	// 2^31-1 bytes
  ORA_DTS_CHAR 		= 255;	// 255 bytes
  ORA_DTS_MLSLABEL 	= 255;	// 255 bytes

const
  ORA_ERR_VarNotInSel	= 1007;	// "variable not in select list" (ORA-01007)
  ORA_ERR_INVALID_OCI_OP= 1010;	// 'Invalid OCI Operation'
  ORA_ERR_PASSWORD_EXPIRED = 28001;	// "the password has expired" (ORA-28001)

  OCI_MORE_INSERT_PIECES= 3129;
  OCI_MORE_FETCH_PIECES	= 3130;
  	//   exit flags
  OCI_EXIT_FAILURE 	= 1;
  OCI_EXIT_SUCCESS	= 0;

  MAX_LONG_COL_SIZE	= SB4MAXVAL;

// OCI8 begin

{*******************************************************************************
*	OCI.h - V8 Oracle Call Interface definitions
*Purpose:
*     This file defines all the constants and structures required by a V8
*     OCI programmer.
*******************************************************************************}
const
//	Modes
  OCI_DEFAULT		= $00;		// the default value for parameters and attributes
  OCI_THREADED		= $01;      	// the application is in threaded environment
  OCI_OBJECT  		= $02;        	// the application is in object environment
  OCI_NON_BLOCKING	= $04;          // non blocking mode of operation
  OCI_ENV_NO_MUTEX	= $08; 		// the environment handle will not be protected by a mutex internally
  OCI_SHARED          	= $10;		// the application is in shared mode   

//	Handle Types (handle types range from 1 - 49)
  OCI_HTYPE_FIRST	= 1;   		// start value of handle type
  OCI_HTYPE_ENV 	= 1;            // environment handle
  OCI_HTYPE_ERROR	= 2;   		// error handle
  OCI_HTYPE_SVCCTX	= 3;   		// service handle
  OCI_HTYPE_STMT	= 4;   		// statement handle
  OCI_HTYPE_BIND	= 5;   		// bind handle
  OCI_HTYPE_DEFINE	= 6;   		// define handle
  OCI_HTYPE_DESCRIBE	= 7;   		// describe handle
  OCI_HTYPE_SERVER	= 8;   		// server handle
  OCI_HTYPE_SESSION	= 9;   		// authentication handle
  OCI_HTYPE_TRANS	= 10;  		// transaction handle
  OCI_HTYPE_COMPLEXOBJECT= 11; 		// complex object retrieval handle
  OCI_HTYPE_SECURITY	= 12;  		// security handle
  OCI_HTYPE_LAST	= 12;  		// last value of a handle type

//	Descriptor Types (descriptor values range from 50 - 255)
  OCI_DTYPE_FIRST	= 50;    	// start value of descriptor type
  OCI_DTYPE_LOB		= 50;           // lob  locator
  OCI_DTYPE_SNAP	= 51;   	// snapshot descriptor
  OCI_DTYPE_RSET	= 52; 		// result set descriptor
  OCI_DTYPE_PARAM	= 53;  		// a parameter descriptor obtained from ocigparm
  OCI_DTYPE_ROWID	= 54;    	// rowid descriptor
  OCI_DTYPE_COMPLEXOBJECTCOMP	= 55; 	// complex object retrieval descriptor
  OCI_DTYPE_FILE	 	= 56;   // File Lob locator
  OCI_DTYPE_AQENQ_OPTIONS	= 57;   // enqueue options
  OCI_DTYPE_AQDEQ_OPTIONS	= 58;   // dequeue options
  OCI_DTYPE_AQMSG_PROPERTIES	= 59;   // message properties
  OCI_DTYPE_AQAGENT	= 60;           // aq agent
  OCI_DTYPE_LOCATOR	= 61;           // LOB locator
  OCI_DTYPE_INTERVAL_YM	= 62;           // Interval year month
  OCI_DTYPE_INTERVAL_DS	= 63;           // Interval day second
  OCI_DTYPE_AQNFY_DESCRIPTOR	= 64;   // AQ notify descriptor
  OCI_DTYPE_DATE	= 65;           // Date
  OCI_DTYPE_TIME	= 66;           // Time
  OCI_DTYPE_TIME_TZ	= 67;           // Time with timezone
  OCI_DTYPE_TIMESTAMP	= 68;           // Timestamp
  OCI_DTYPE_TIMESTAMP_TZ= 69;           // Timestamp with timezone
  OCI_DTYPE_TIMESTAMP_LTZ=70;           // Timestamp with local tz
  OCI_DTYPE_UCB  	= 71;           // user callback descriptor
  OCI_DTYPE_SRVDN	= 72;           // server DN list descriptor
  OCI_DTYPE_SIGNATURE	= 73;           // signature
  OCI_DTYPE_RESERVED_1	= 74;           // reserved for internal use
  OCI_DTYPE_LAST	= 74;    	// last value of a descriptor type

//--------------------------------LOB types ---------------------------------
  OCI_TEMP_BLOB	= 1;                	// LOB type - BLOB
  OCI_TEMP_CLOB	= 2;                	// LOB type - CLOB
//---------------------------------------------------------------------------

//-------------------------Object Ptr Types----------------------------------
  OCI_OTYPE_NAME	= 1;		// object name
  OCI_OTYPE_REF 	= 2; 		// REF to TDO
  OCI_OTYPE_PTR 	= 3;		// PTR to TDO
//---------------------------------------------------------------------------

//============================Attribute Types================================
  OCI_ATTR_FNCODE  		= 1;    // the OCI function code 
  OCI_ATTR_OBJECT   		= 2;	// is the environment initialized in object mode
  OCI_ATTR_NONBLOCKING_MODE 	= 3;    // non blocking mode
  OCI_ATTR_SQLCODE  		= 4;    // the SQL verb
  OCI_ATTR_ENV  		= 5;    // the environment handle
  OCI_ATTR_SERVER 		= 6;    // the server handle
  OCI_ATTR_SESSION 		= 7;    // the user session handle
  OCI_ATTR_TRANS   		= 8;    // the transaction handle
  OCI_ATTR_ROW_COUNT   		= 9;    // the rows processed so far
  OCI_ATTR_SQLFNCODE 		= 10;    // the SQL verb of the statement
  OCI_ATTR_PREFETCH_ROWS	= 11;	// sets the number of rows to prefetch
  OCI_ATTR_NESTED_PREFETCH_ROWS = 12;	// the prefetch rows of nested table
  OCI_ATTR_PREFETCH_MEMORY 	= 13;  	// memory limit for rows fetched
  OCI_ATTR_NESTED_PREFETCH_MEMORY=14;   // memory limit for nested rows
  OCI_ATTR_CHAR_COUNT 		= 15;	// this specifies the bind and define size in characters
  OCI_ATTR_PDSCL    		= 16;	// packed decimal scale
  OCI_ATTR_FSPRECISION		= OCI_ATTR_PDSCL;	// fs prec for datetime data types
  OCI_ATTR_PDPRC    		= 17;			// packed decimal format (or OCI_ATTR_PDFMT in v.8) 
  OCI_ATTR_LFPRECISION		= OCI_ATTR_PDPRC;	// fs prec for datetime data types 
  OCI_ATTR_PARAM_COUNT  	= 18;	// number of column in the select list
  OCI_ATTR_ROWID    		= 19;  	// the rowid
  OCI_ATTR_CHARSET   		= 20;	// the character set value
  OCI_ATTR_NCHAR    		= 21;	// NCHAR type
  OCI_ATTR_USERNAME  		= 22;	// username attribute
  OCI_ATTR_PASSWORD  		= 23;	// password attribute
  OCI_ATTR_STMT_TYPE    	= 24;	// statement type
  OCI_ATTR_INTERNAL_NAME    	= 25;	// user friendly global name
  OCI_ATTR_EXTERNAL_NAME    	= 26;	// the internal name for global txn
  OCI_ATTR_XID      		= 27;	// XOPEN defined global transaction id 
  OCI_ATTR_TRANS_LOCK  		= 28;
  OCI_ATTR_TRANS_NAME       	= 29;	// string to identify a global transaction 
  OCI_ATTR_HEAPALLOC  		= 30;	// memory allocated on the heap
  OCI_ATTR_CHARSET_ID  		= 31;	// Character Set ID
  OCI_ATTR_CHARSET_FORM  	= 32;   // Character Set Form
  OCI_ATTR_MAXDATA_SIZE  	= 33;   // Maximumsize of data on the server
  OCI_ATTR_CACHE_OPT_SIZE	= 34;   // object cache optimal size
  OCI_ATTR_CACHE_MAX_SIZE	= 35;   // object cache maximum size percentage
  OCI_ATTR_PINOPTION  		= 36;   // object cache default pin option
  OCI_ATTR_ALLOC_DURATION	= 37;   // object cache default allocation duration
  OCI_ATTR_PIN_DURATION		= 38;   // object cache default pin duration
  OCI_ATTR_FDO         		= 39;   // Format Descriptor object attribute
  OCI_ATTR_POSTPROCESSING_CALLBACK=40;  // Callback to process outbind data
  OCI_ATTR_POSTPROCESSING_CONTEXT=41;  	// Callback context to process outbind data
  OCI_ATTR_ROWS_RETURNED	= 42;   // Number of rows returned in current iter - for Bind handles
  OCI_ATTR_FOCBK       		= 43;   // Failover Callback attribute
  OCI_ATTR_IN_V8_MODE  		= 44; 	// is the server/service context in V8 mode
  OCI_ATTR_LOBEMPTY    		= 45;
  OCI_ATTR_SESSLANG    		= 46;	// session language handle
  OCI_ATTR_VISIBILITY           = 47;	// visibility
  OCI_ATTR_RELATIVE_MSGID       = 48;	// relative message id
  OCI_ATTR_SEQUENCE_DEVIATION   = 49;	// sequence deviation

  OCI_ATTR_CONSUMER_NAME        = 50;	// consumer name
  OCI_ATTR_DEQ_MODE             = 51;	// dequeue mode
  OCI_ATTR_NAVIGATION           = 52;	// navigation
  OCI_ATTR_WAIT                 = 53;	// wait
  OCI_ATTR_DEQ_MSGID            = 54;	// dequeue message id

  OCI_ATTR_PRIORITY             = 55;	// priority
  OCI_ATTR_DELAY                = 56;	// delay
  OCI_ATTR_EXPIRATION           = 57;	// expiration
  OCI_ATTR_CORRELATION          = 58;	// correlation id
  OCI_ATTR_ATTEMPTS             = 59;	// # of attempts
  OCI_ATTR_RECIPIENT_LIST       = 60;	// recipient list
  OCI_ATTR_EXCEPTION_QUEUE      = 61;	// exception queue name
  OCI_ATTR_ENQ_TIME             = 62;	// enqueue time (only OCIAttrGet)
  OCI_ATTR_MSG_STATE            = 63;	// message state (only OCIAttrGet) NOTE: 64-66 used below
  OCI_ATTR_AGENT_NAME           = 64;	// agent name
  OCI_ATTR_AGENT_ADDRESS        = 65;	// agent address
  OCI_ATTR_AGENT_PROTOCOL       = 66;	// agent protocol

  OCI_ATTR_SENDER_ID            = 68;	// sender id
  OCI_ATTR_ORIGINAL_MSGID       = 69;	// original message id

  OCI_ATTR_QUEUE_NAME           = 70;	// queue name
  OCI_ATTR_NFY_MSGID            = 71;	// message id
  OCI_ATTR_MSG_PROP             = 72;	// message properties

  OCI_ATTR_NUM_DML_ERRORS       = 73;	// num of errs in array DML
  OCI_ATTR_DML_ROW_OFFSET       = 74;	// row offset in the array

  OCI_ATTR_DATEFORMAT           = 75;	// default date format string
  OCI_ATTR_BUF_ADDR             = 76;	// buffer address
  OCI_ATTR_BUF_SIZE             = 77;	// buffer size
  OCI_ATTR_DIRPATH_MODE         = 78;	// mode of direct path operation
  OCI_ATTR_DIRPATH_NOLOG        = 79;	// nologging option
  OCI_ATTR_DIRPATH_PARALLEL     = 80;	// parallel (temp seg) option
  OCI_ATTR_NUM_ROWS             = 81; 	// number of rows in column array
                            		// NOTE that OCI_ATTR_NUM_COLS is a column array attribute too.
  OCI_ATTR_COL_COUNT            = 82;	// columns of column array processed so far
  OCI_ATTR_STREAM_OFFSET        = 83;	// str off of last row processed
  OCI_ATTR_SHARED_HEAPALLOC     = 84;	// Shared Heap Allocation Size

  OCI_ATTR_SERVER_GROUP         = 85;	// server group name

  OCI_ATTR_MIGSESSION           = 86;	// migratable session attribute

  OCI_ATTR_NOCACHE              = 87;	// Temporary LOBs

  OCI_ATTR_MEMPOOL_SIZE         = 88;	// Pool Size
  OCI_ATTR_MEMPOOL_INSTNAME     = 89;	// Instance name
  OCI_ATTR_MEMPOOL_APPNAME      = 90;	// Application name
  OCI_ATTR_MEMPOOL_HOMENAME     = 91;	// Home Directory name
  OCI_ATTR_MEMPOOL_MODEL        = 92;	// Pool Model (proc,thrd,both)
  OCI_ATTR_MODES                = 93;	// Modes

  OCI_ATTR_SUBSCR_NAME          = 94;	// name of subscription
  OCI_ATTR_SUBSCR_CALLBACK      = 95;	// associated callback
  OCI_ATTR_SUBSCR_CTX           = 96;	// associated callback context
  OCI_ATTR_SUBSCR_PAYLOAD       = 97;	// associated payload
  OCI_ATTR_SUBSCR_NAMESPACE     = 98;	// associated namespace

  OCI_ATTR_PROXY_CREDENTIALS    = 99; 	// Proxy user credentials
  OCI_ATTR_INITIAL_CLIENT_ROLES = 100;	// Initial client role list

//	Parameter Attribute Types
  OCI_ATTR_UNK     		= 101;	// unknown attribute
  OCI_ATTR_NUM_COLS    		= 102;  // number of columns
  OCI_ATTR_LIST_COLUMNS		= 103;  // parameter of the column list
  OCI_ATTR_RDBA    		= 104;  // DBA of the segment header
  OCI_ATTR_CLUSTERED   		= 105;  // whether the table is clustered
  OCI_ATTR_PARTITIONED     	= 106;  // whether the table is partitioned
  OCI_ATTR_INDEX_ONLY      	= 107;  // whether the table is index only
  OCI_ATTR_LIST_ARGUMENTS  	= 108;  // parameter of the argument list
  OCI_ATTR_LIST_SUBPROGRAMS	= 109;  // parameter of the subprogram list
  OCI_ATTR_REF_TDO         	= 110;  // REF to the type descriptor
  OCI_ATTR_LINK            	= 111;  // the database link name
  OCI_ATTR_MIN             	= 112;  // minimum value
  OCI_ATTR_MAX             	= 113;  // maximum value
  OCI_ATTR_INCR            	= 114;  // increment value
  OCI_ATTR_CACHE           	= 115;  // number of sequence numbers cached
  OCI_ATTR_ORDER           	= 116;  // whether the sequence is ordered
  OCI_ATTR_HW_MARK         	= 117;  // high-water mark
  OCI_ATTR_TYPE_SCHEMA     	= 118;  // type's schema name
  OCI_ATTR_TIMESTAMP       	= 119;  // timestamp of the object
  OCI_ATTR_NUM_ATTRS       	= 120;  // number of sttributes
  OCI_ATTR_NUM_PARAMS      	= 121;  // number of parameters
  OCI_ATTR_OBJID           	= 122;  // object id for a table or view
  OCI_ATTR_PTYPE           	= 123;  // type of info described by
  OCI_ATTR_PARAM           	= 124;  // parameter descriptor
  OCI_ATTR_OVERLOAD_ID     	= 125;  // overload ID for funcs and procs
  OCI_ATTR_TABLESPACE      	= 126;  // table name space
  OCI_ATTR_TDO                 	= 127;  // TDO of a type
  OCI_ATTR_LTYPE               	= 128;  // list type
  OCI_ATTR_PARSE_ERROR_OFFSET	= 129;  // Parse Error offset
  OCI_ATTR_IS_TEMPORARY     	= 130;  // whether table is temporary
  OCI_ATTR_IS_TYPED        	= 131;  // whether table is typed
  OCI_ATTR_DURATION        	= 132;  // duration of temporary table
  OCI_ATTR_IS_INVOKER_RIGHTS	= 133;  // is invoker rights
  OCI_ATTR_OBJ_NAME       	= 134;	// top level schema obj name
  OCI_ATTR_OBJ_SCHEMA     	= 135;  // schema name
  OCI_ATTR_OBJ_ID         	= 136;  // top level schema object id

  OCI_ATTR_DIRPATH_SORTED_INDEX	= 137; 	// index that data is sorted on

     { direct path index maint method (see oci8dp.h) }
  OCI_ATTR_DIRPATH_INDEX_MAINT_METHOD 	= 138;

    { parallel load: db file, initial and next extent sizes }
  OCI_ATTR_DIRPATH_FILE    		= 139;	// DB file to load into
  OCI_ATTR_DIRPATH_STORAGE_INITIAL 	= 140;	// initial extent size
  OCI_ATTR_DIRPATH_STORAGE_NEXT		= 141;	// next extent size

  OCI_ATTR_TRANS_TIMEOUT	= 142;	// transaction timeout
  OCI_ATTR_SERVER_STATUS	= 143; 	// state of the server handle
  OCI_ATTR_STATEMENT  		= 144; 	// statement txt in stmt hdl, statement should not be executed in cache

  OCI_ATTR_NO_CACHE         	= 145;
  OCI_ATTR_DEQCOND          	= 146;	// dequeue condition
  OCI_ATTR_RESERVED_2       	= 147;	// reserved

  OCI_ATTR_SUBSCR_RECPT     	= 148;	// recepient of subscription
  OCI_ATTR_SUBSCR_RECPTPROTO	= 149;	// protocol for recepient

	// 8.2 dpapi support of ADTs
  OCI_ATTR_DIRPATH_EXPR_TYPE 	= 150;	// expr type of OCI_ATTR_NAME

  OCI_ATTR_DIRPATH_INPUT     	= 151;	// input in text or stream format

  OCI_DIRPATH_INPUT_TEXT    	= $01;
  OCI_DIRPATH_INPUT_STREAM  	= $02;
  OCI_DIRPATH_INPUT_UNKNOWN 	= $04;

  OCI_ATTR_LDAP_HOST      	= 153;	// LDAP host to connect to
  OCI_ATTR_LDAP_PORT      	= 154;	// LDAP port to connect to
  OCI_ATTR_BIND_DN        	= 155;	// bind DN
  OCI_ATTR_LDAP_CRED      	= 156;	// credentials to connect to LDAP
  OCI_ATTR_WALL_LOC       	= 157;	// client wallet location
  OCI_ATTR_LDAP_AUTH      	= 158;	// LDAP authentication method
  OCI_ATTR_LDAP_CTX       	= 159;	// LDAP adminstration context DN
  OCI_ATTR_SERVER_DNS     	= 160;	// list of registration server DNs

  OCI_ATTR_DN_COUNT       	= 161;	// the number of server DNs
  OCI_ATTR_SERVER_DN      	= 162;	// server DN attribute

  OCI_ATTR_MAXCHAR_SIZE   	= 163;	// max char size of data

  OCI_ATTR_CURRENT_POSITION  	= 164;	// for scrollable result sets

// Added to get attributes for ref cursor to statement handle
  OCI_ATTR_RESERVED_3       	= 165;	// reserved
  OCI_ATTR_RESERVED_4       	= 166;	// reserved
  OCI_ATTR_DIRPATH_FN_CTX   	= 167;	// fn ctx ADT attrs or args
  OCI_ATTR_DIGEST_ALGO      	= 168;	// digest algorithm
  OCI_ATTR_CERTIFICATE      	= 169;	// certificate
  OCI_ATTR_SIGNATURE_ALGO   	= 170;	// signature algorithm
  OCI_ATTR_CANONICAL_ALGO   	= 171;	// canonicalization algo.
  OCI_ATTR_PRIVATE_KEY      	= 172;	// private key
  OCI_ATTR_DIGEST_VALUE     	= 173;	// digest value
  OCI_ATTR_SIGNATURE_VAL    	= 174;	// signature value
  OCI_ATTR_SIGNATURE        	= 175;	// signature

// attributes for setting OCI stmt caching specifics in svchp
  OCI_ATTR_STMTCACHESIZE    	= 176;	// size of the stm cache

// --------------------------- Connection Pool Attributes ------------------
  OCI_ATTR_CONN_NOWAIT      	= 178;
  OCI_ATTR_CONN_BUSY_COUNT  	= 179;
  OCI_ATTR_CONN_OPEN_COUNT  	= 180;
  OCI_ATTR_CONN_TIMEOUT     	= 181;
  OCI_ATTR_STMT_STATE       	= 182;
  OCI_ATTR_CONN_MIN         	= 183;
  OCI_ATTR_CONN_MAX         	= 184;
  OCI_ATTR_CONN_INCR        	= 185;

  OCI_ATTR_DIRPATH_OID      	= 187;	// loading into an OID col

  OCI_ATTR_NUM_OPEN_STMTS   	= 188;	// open stmts in session
  OCI_ATTR_DESCRIBE_NATIVE  	= 189;	// get native info via desc

  OCI_ATTR_BIND_COUNT       	= 190;	// number of bind postions
  OCI_ATTR_HANDLE_POSITION  	= 191;	// pos of bind/define handle
  OCI_ATTR_RESERVED_5       	= 192;	// reserverd
  OCI_ATTR_SERVER_BUSY      	= 193;	// call in progress on server

  OCI_ATTR_DIRPATH_SID      	= 194;	// loading into an SID col
// notification presentation for recipient
  OCI_ATTR_SUBSCR_RECPTPRES 	= 195;
  OCI_ATTR_TRANSFORMATION   	= 196;	// AQ message transformation

  OCI_ATTR_ROWS_FETCHED     	= 197;	// rows fetched in last call

// --------------------------- Snapshot attributes -------------------------
  OCI_ATTR_SCN_BASE        	= 198;	// snapshot base
  OCI_ATTR_SCN_WRAP        	= 199;	// snapshot wrap

// --------------------------- Miscellanous attributes ---------------------
  OCI_ATTR_RESERVED_6       	= 200;	// reserved
  OCI_ATTR_READONLY_TXN     	= 201;	// txn is readonly
  OCI_ATTR_RESERVED_7       	= 202;	// reserved
  OCI_ATTR_ERRONEOUS_COLUMN 	= 203;	// position of erroneous col
  OCI_ATTR_RESERVED_8       	= 204;	// reserved

// -------------------- 8.2 dpapi support of ADTs continued ----------------
  OCI_ATTR_DIRPATH_OBJ_CONSTR 	= 206;	// obj type of subst obj tbl

//************************FREE attribute     207      *************************/
//************************FREE attribute     208      *************************/
  OCI_ATTR_ENV_UTF16         	= 209;	// is env in utf16 mode?
  OCI_ATTR_RESERVED_9        	= 210;	// reserved for TMZ
  OCI_ATTR_RESERVED_10       	= 211;	// reserved

// Attr to allow setting of the stream version PRIOR to calling Prepare
  OCI_ATTR_DIRPATH_STREAM_VERSION	= 212;	// version of the stream
  OCI_ATTR_RESERVED_11           	= 213;	// reserved

  OCI_ATTR_RESERVED_12     	= 214;	// reserved
  OCI_ATTR_RESERVED_13     	= 215;	// reserved

//------------- Supported Values for Direct Path Stream Version -------------
  OCI_DIRPATH_STREAM_VERSION_1	= 100;
  OCI_DIRPATH_STREAM_VERSION_2	= 200;

//------------- Supported Values for protocol for recepient -----------------
  OCI_SUBSCR_PROTO_OCI    	= 0;    // oci
  OCI_SUBSCR_PROTO_MAIL   	= 1;    // mail
  OCI_SUBSCR_PROTO_SERVER 	= 2;    // server
  OCI_SUBSCR_PROTO_HTTP   	= 3;    // http
  OCI_SUBSCR_PROTO_MAX    	= 4;	// max current protocols

//------------- Supported Values for presentation for recepient -------------
  OCI_SUBSCR_PRES_DEFAULT	= 0;    // default
  OCI_SUBSCR_PRES_XML    	= 1;    // xml
  OCI_SUBSCR_PRES_MAX    	= 2;	// max current presentations

// ----- Temporary attribute value for UCS2/UTF16 character set ID --------
  OCI_UCS2ID			= 1000;	// UCS2 charset ID
  OCI_UTF16ID          		= 1000;	// UTF16 charset ID

{============================== End OCI Attribute Types ====================}

{---------------- Server Handle Attribute Values ---------------------------}

	// OCI_ATTR_SERVER_STATUS
  OCI_SERVER_NOT_CONNECTED	= $00;
  OCI_SERVER_NORMAL      	= $01;

{---------------------------------------------------------------------------}

{------------------------- Supported Namespaces  ---------------------------}
  OCI_SUBSCR_NAMESPACE_ANONYMOUS= 0;	// Anonymous Namespace 
  OCI_SUBSCR_NAMESPACE_AQ  	= 1;	// Advanced Queues
  OCI_SUBSCR_NAMESPACE_MAX   	= 2;	// Max Name Space Number


//	Credential Types
  OCI_CRED_RDBMS 	= 1;		// database username/password
  OCI_CRED_EXT     	= 2;		// externally provided credentials

//	Error Return Values
  OCI_SUCCESS		= 0;    	// maps to SQL_SUCCESS of SAG CLI
  OCI_SUCCESS_WITH_INFO	= 1;            // maps to SQL_SUCCESS_WITH_INFO
  OCI_RESERVED_FOR_INT_USE=200;		//* reserved for internal use 
  OCI_NO_DATA		= 100;          // maps to SQL_NO_DATA
  OCI_ERROR		= -1;           // maps to SQL_ERROR
  OCI_INVALID_HANDLE	= -2;           // maps to SQL_INVALID_HANDLE
  OCI_NEED_DATA		= 99;           // maps to SQL_NEED_DATA
  OCI_STILL_EXECUTING	= -3123;        // OCI would block error
  OCI_CONTINUE		= -24200;       // Continue with the body of the OCI function

//------------------DateTime and Interval check Error codes------------------

// DateTime Error Codes used by OCIDateTimeCheck()
  OCI_DT_INVALID_DAY        = $1;	// Bad day
  OCI_DT_DAY_BELOW_VALID    = $2;   	// Bad DAy Low/high bit (1=low)
  OCI_DT_INVALID_MONTH      = $4;   	//  Bad MOnth
  OCI_DT_MONTH_BELOW_VALID  = $8;   	// Bad MOnth Low/high bit (1=low)
  OCI_DT_INVALID_YEAR       = $10;  	// Bad YeaR
  OCI_DT_YEAR_BELOW_VALID   = $20;  	//  Bad YeaR Low/high bit (1=low)
  OCI_DT_INVALID_HOUR       = $40;  	//  Bad HouR
  OCI_DT_HOUR_BELOW_VALID   = $80;  	// Bad HouR Low/high bit (1=low)
  OCI_DT_INVALID_MINUTE     = $100; 	// Bad MiNute
  OCI_DT_MINUTE_BELOW_VALID = $200; 	//Bad MiNute Low/high bit (1=low)
  OCI_DT_INVALID_SECOND     = $400; 	//  Bad SeCond
  OCI_DT_SECOND_BELOW_VALID = $800; 	//bad second Low/high bit (1=low)
  OCI_DT_DAY_MISSING_FROM_1582= $1000;	//  Day is one of those "missing" from 1582
  OCI_DT_YEAR_ZERO          = $2000;  	// Year may not equal zero
  OCI_DT_INVALID_TIMEZONE   = $4000;  	//  Bad Timezone
  OCI_DT_INVALID_FORMAT     = $8000;  	// Bad date format input

// Interval Error Codes used by OCIInterCheck()
  OCI_INTER_INVALID_DAY        = $1;  	// Bad day
  OCI_INTER_DAY_BELOW_VALID    = $2;  	// Bad DAy Low/high bit (1=low)
  OCI_INTER_INVALID_MONTH      = $4;  	// Bad MOnth
  OCI_INTER_MONTH_BELOW_VALID  = $8;  	//Bad MOnth Low/high bit (1=low)
  OCI_INTER_INVALID_YEAR       = $10; 	// Bad YeaR
  OCI_INTER_YEAR_BELOW_VALID   = $20; 	//Bad YeaR Low/high bit (1=low)
  OCI_INTER_INVALID_HOUR       = $40; 	// Bad HouR
  OCI_INTER_HOUR_BELOW_VALID   = $80; 	//Bad HouR Low/high bit (1=low)
  OCI_INTER_INVALID_MINUTE     = $100;	// Bad MiNute
  OCI_INTER_MINUTE_BELOW_VALID = $200;	//Bad MiNute Low/high bit(1=low)
  OCI_INTER_INVALID_SECOND     = $400;	// Bad SeCond
  OCI_INTER_SECOND_BELOW_VALID = $800;	//bad second Low/high bit(1=low)
  OCI_INTER_INVALID_FRACSEC    = $1000;      // Bad Fractional second
  OCI_INTER_FRACSEC_BELOW_VALID= $2000;      // Bad fractional second Low/High

//	Parsing Syntax Types
  OCI_V7_SYNTAX		= 2;	// V7 language
  OCI_V8_SYNTAX		= 3;	// V8 language
  OCI_NTV_SYNTAX	= 1;	// Use what so ever is the native lang of server these values must match the values defined in kpul.h

//------------------------Scrollable Cursor Fetch Options-------------------
// For non-scrollable cursor, the only valid (and default) orientation is OCI_FETCH_NEXT
  OCI_FETCH_CURRENT	= $01;          // refetching current position
  OCI_FETCH_NEXT	= $02;  	// next row
  OCI_FETCH_FIRST	= $04;  	// first row of the result set
  OCI_FETCH_LAST	= $08;  	// the last row of the result set
  OCI_FETCH_PRIOR	= $10;  	// the previous row relative to current
  OCI_FETCH_ABSOLUTE	= $20;  	// absolute offset from first
  OCI_FETCH_RELATIVE	= $40;  	// offset relative to current
  OCI_FETCH_RESERVED_1 	= $80;  	// reserved

//	Bind and Define Options
  OCI_SB2_IND_PTR  	= $01;
  OCI_DATA_AT_EXEC 	= $02;
  OCI_DYNAMIC_FETCH	= $02;
  OCI_PIECEWISE    	= $04;

//	Execution Modes
  OCI_BATCH_MODE       	= $01;
  OCI_EXACT_FETCH      	= $02;
  OCI_KEEP_FETCH_STATE 	= $04;
  OCI_SCROLLABLE_CURSOR	= $08;
  OCI_DESCRIBE_ONLY    	= $10;
  OCI_COMMIT_ON_SUCCESS	= $20;

//	Authentication Modes
  OCI_MIGRATE    	= $0001;	// migratable auth context
  OCI_SYSDBA     	= $0002;	// for SYSDBA authorization
  OCI_SYSOPER    	= $0004;	// for SYSOPER authorization
  OCI_PRELIM_AUTH	= $0008;	// for preliminary authorization

//	Piece Information
  OCI_PARAM_IN		= $01;
  OCI_PARAM_OUT		= $02;

//	Transaction Start Flags
  OCI_TRANS_OLD        	= $00000000;
  OCI_TRANS_NEW        	= $00000001;
  OCI_TRANS_JOIN       	= $00000002;
  OCI_TRANS_RESUME     	= $00000004;
  OCI_TRANS_STARTMASK  	= $000000FF;

  OCI_TRANS_READONLY   	= $00000100;
  OCI_TRANS_READWRITE  	= $00000200;
  OCI_TRANS_SERIALIZABLE= $00000400;
  OCI_TRANS_ISOLMASK   	= $0000FF00;

  OCI_TRANS_LOOSE      	= $00010000;
  OCI_TRANS_TIGHT      	= $00020000;
  OCI_TRANS_TYPEMASK   	= $000F0000;

  OCI_TRANS_NOMIGRATE  	= $00100000;

//	Transaction End Flags
  OCI_TRANS_TWOPHASE   	= $01000000;

//	Object Types
  OCI_OTYPE_UNK        	= 0;
  OCI_OTYPE_TABLE      	= 1;
  OCI_OTYPE_VIEW       	= 2;
  OCI_OTYPE_SYN        	= 3;
  OCI_OTYPE_PROC       	= 4;
  OCI_OTYPE_FUNC       	= 5;
  OCI_OTYPE_PKG        	= 6;
  OCI_OTYPE_STMT       	= 7;

//=======================Describe Handle Parameter Attributes ===============

// attributes common to Columns and Stored Procs
  OCI_ATTR_DATA_SIZE   	 	= 1;
  OCI_ATTR_DATA_TYPE   	 	= 2;
  OCI_ATTR_DISP_SIZE   	 	= 3;
  OCI_ATTR_NAME        	 	= 4;
  OCI_ATTR_PRECISION   	 	= 5;
  OCI_ATTR_SCALE       	 	= 6;
  OCI_ATTR_IS_NULL     	 	= 7;
  OCI_ATTR_TYPE_NAME   	 	= 8;
  OCI_ATTR_SCHEMA_NAME 	 	= 9;
  OCI_ATTR_SUB_NAME    	 	= 10;
  OCI_ATTR_POSITION    	 	= 11;

// complex object retrieval parameter attributes
  OCI_ATTR_COMPLEXOBJECTCOMP_TYPE	= 50;
  OCI_ATTR_COMPLEXOBJECTCOMP_TYPE_LEVEL	= 51;
  OCI_ATTR_COMPLEXOBJECT_LEVEL		= 52;
  OCI_ATTR_COMPLEXOBJECT_COLL_OUTOFLINE	= 53;

// only Columns
  OCI_ATTR_DISP_NAME   	 	= 100;	// the display name

// only Stored Procs
  OCI_ATTR_OVERLOAD    	 	= 210;  // is this position overloaded
  OCI_ATTR_LEVEL       	 	= 211;  // level for structured types
  OCI_ATTR_HAS_DEFAULT 	 	= 212;  // has a default value
  OCI_ATTR_IOMODE      	 	= 213;  // in, out inout
  OCI_ATTR_RADIX       	 	= 214;  // returns a radix
  OCI_ATTR_NUM_ARGS    	 	= 215;  // total number of arguments

// only user-defined Type's
  OCI_ATTR_TYPECODE           	= 216;  // object or collection
  OCI_ATTR_COLLECTION_TYPECODE	= 217;  // varray or nested table
  OCI_ATTR_VERSION            	= 218;  // user assigned version
  OCI_ATTR_IS_INCOMPLETE_TYPE 	= 219;  // is this an incomplete type
  OCI_ATTR_IS_SYSTEM_TYPE     	= 220;  // a system type
  OCI_ATTR_IS_PREDEFINED_TYPE 	= 221;  // a predefined type
  OCI_ATTR_IS_TRANSIENT_TYPE  	= 222;  // a transient type
  OCI_ATTR_IS_SYSTEM_GENERATED_TYPE=223;// system generated type
  OCI_ATTR_HAS_NESTED_TABLE   	= 224;  // contains nested table attr
  OCI_ATTR_HAS_LOB             	= 225;  // has a lob attribute
  OCI_ATTR_HAS_FILE            	= 226;  // has a file attribute
  OCI_ATTR_COLLECTION_ELEMENT  	= 227;  // has a collection attribute
  OCI_ATTR_NUM_TYPE_ATTRS      	= 228;  // number of attribute types
  OCI_ATTR_LIST_TYPE_ATTRS     	= 229;  // list of type attributes
  OCI_ATTR_NUM_TYPE_METHODS    	= 230;  // number of type methods
  OCI_ATTR_LIST_TYPE_METHODS   	= 231;  // list of type methods
  OCI_ATTR_MAP_METHOD          	= 232;  // map method of type
  OCI_ATTR_ORDER_METHOD        	= 233;  // order method of type

// only collection element
  OCI_ATTR_NUM_ELEMS           	= 234;  // number of elements

// only type methods
  OCI_ATTR_ENCAPSULATION       	= 235;  // encapsulation level
  OCI_ATTR_IS_SELFISH          	= 236;  // method selfish
  OCI_ATTR_IS_VIRTUAL          	= 237;  // virtual
  OCI_ATTR_IS_INLINE           	= 238;  // inline
  OCI_ATTR_IS_CONSTANT         	= 239;  // constant
  OCI_ATTR_HAS_RESULT          	= 240;  // has result
  OCI_ATTR_IS_CONSTRUCTOR      	= 241;  // constructor
  OCI_ATTR_IS_DESTRUCTOR       	= 242;  // destructor
  OCI_ATTR_IS_OPERATOR         	= 243;  // operator
  OCI_ATTR_IS_MAP              	= 244;  // a map method
  OCI_ATTR_IS_ORDER            	= 245;  // order method
  OCI_ATTR_IS_RNDS             	= 246;  // read no data state method
  OCI_ATTR_IS_RNPS             	= 247;  // read no process state
  OCI_ATTR_IS_WNDS             	= 248;  // write no data state method
  OCI_ATTR_IS_WNPS             	= 249;  // write no process state

  OCI_ATTR_DESC_PUBLIC      	= 250;	// public object

// Object Cache Enhancements : attributes for User Constructed Instances
  OCI_ATTR_CACHE_CLIENT_CONTEXT = 251;
  OCI_ATTR_UCI_CONSTRUCT        = 252;
  OCI_ATTR_UCI_DESTRUCT         = 253;
  OCI_ATTR_UCI_COPY             = 254;
  OCI_ATTR_UCI_PICKLE           = 255;
  OCI_ATTR_UCI_UNPICKLE         = 256;
  OCI_ATTR_UCI_REFRESH          = 257;

// for type inheritance
  OCI_ATTR_IS_SUBTYPE           = 258;
  OCI_ATTR_SUPERTYPE_SCHEMA_NAME= 259;
  OCI_ATTR_SUPERTYPE_NAME       = 260;

// for schemas
  OCI_ATTR_LIST_OBJECTS         = 261;	// list of objects in schema

// for database
  OCI_ATTR_NCHARSET_ID          = 262;	// char set id
  OCI_ATTR_LIST_SCHEMAS         = 263;	// list of schemas
  OCI_ATTR_MAX_PROC_LEN         = 264;	// max procedure length
  OCI_ATTR_MAX_COLUMN_LEN       = 265;	// max column name length
  OCI_ATTR_CURSOR_COMMIT_BEHAVIOR=266;	// cursor commit behavior
  OCI_ATTR_MAX_CATALOG_NAMELEN  = 267;	// catalog namelength
  OCI_ATTR_CATALOG_LOCATION     = 268;	// catalog location
  OCI_ATTR_SAVEPOINT_SUPPORT    = 269;	// savepoint support
  OCI_ATTR_NOWAIT_SUPPORT       = 270;	// nowait support
  OCI_ATTR_AUTOCOMMIT_DDL       = 271;	// autocommit DDL
  OCI_ATTR_LOCKING_MODE         = 272;	// locking mode

// for externally initialized context
  OCI_ATTR_APPCTX_SIZE          = 273;	// count of context to be init
  OCI_ATTR_APPCTX_LIST          = 274;	// count of context to be init
  OCI_ATTR_APPCTX_NAME          = 275;	// name  of context to be init
  OCI_ATTR_APPCTX_ATTR          = 276;	// attr  of context to be init
  OCI_ATTR_APPCTX_VALUE         = 277;	// value of context to be init

// for client id propagation
  OCI_ATTR_CLIENT_IDENTIFIER    = 278;	// value of client id to set

// for inheritance - part 2
  OCI_ATTR_IS_FINAL_TYPE        = 279;	// is final type ?
  OCI_ATTR_IS_INSTANTIABLE_TYPE = 280;	// is instantiable type ?
  OCI_ATTR_IS_FINAL_METHOD      = 281;	// is final method ?
  OCI_ATTR_IS_INSTANTIABLE_METHOD=282;	// is instantiable method ?
  OCI_ATTR_IS_OVERRIDING_METHOD = 283;	// is overriding method ?

// slot 284 available

  OCI_ATTR_CHAR_USED            = 285;	// char length semantics
  OCI_ATTR_CHAR_SIZE            = 286;	// char length

// SQLJ support
  OCI_ATTR_IS_JAVA_TYPE         = 287;	// is java implemented type ?

// N-Tier support
  OCI_ATTR_DISTINGUISHED_NAME   = 300;	// use DN as user name
  OCI_ATTR_KERBEROS_TICKET      = 301;	// Kerberos ticket as cred.

// for multilanguage debugging
  OCI_ATTR_ORA_DEBUG_JDWP       = 302;	// ORA_DEBUG_JDWP attribute

  OCI_ATTR_RESERVED_14          = 303;	// reserved


// -------- client side character and national character set ids -----------
  OCI_ATTR_ENV_CHARSET_ID  	= OCI_ATTR_CHARSET_ID;  // charset id in env
  OCI_ATTR_ENV_NCHARSET_ID 	= OCI_ATTR_NCHARSET_ID;	// ncharset id in env
  
//	ocicpw Modes
  OCI_AUTH	= $08;			// Change the password but donot login

//	Other Constants
  OCI_MAX_FNS		= 100;		// max number of OCI Functions
  OCI_SQLSTATE_SIZE	= 5;
  OCI_ERROR_MAXMSG_SIZE = 1024;
  OCI_LOBMAXSIZE	= MINUB4MAXVAL;
  OCI_ROWID_LEN 	= 23;

//	Fail Over Events
  OCI_FO_END          	= $00000001;
  OCI_FO_ABORT        	= $00000002;
  OCI_FO_REAUTH       	= $00000004;
  OCI_FO_BEGIN        	= $00000008;

//	Fail Over Types
  OCI_FO_NONE          	= $00000001;
  OCI_FO_SESSION       	= $00000002;
  OCI_FO_SELECT        	= $00000004;
  OCI_FO_TXNAL         	= $00000008;

//	Function Codes
  OCI_FNCODE_INITIALIZE 	= 1;
  OCI_FNCODE_HANDLEALLOC	= 2;
  OCI_FNCODE_HANDLEFREE 	= 3;
  OCI_FNCODE_DESCRIPTORALLOC	= 4;
  OCI_FNCODE_DESCRIPTORFREE 	= 5;
  OCI_FNCODE_ENVINIT  		= 6;
  OCI_FNCODE_SERVERATTACH  	= 7;
  OCI_FNCODE_SERVERDETACH  	= 8;
  // unused         9
  OCI_FNCODE_SESSIONBEGIN 	= 10;
  OCI_FNCODE_SESSIONEND  	= 11;
  OCI_FNCODE_PASSWORDCHANGE  	= 12;
  OCI_FNCODE_STMTPREPARE  	= 13;
  OCI_FNCODE_STMTBINDBYPOS 	= 14;
  OCI_FNCODE_STMTBINDBYNAME 	= 15;
  // unused        16
  OCI_FNCODE_BINDDYNAMIC  	= 17;
  OCI_FNCODE_BINDOBJECT 	= 18;
  OCI_FNCODE_BINDARRAYOFSTRUCT 	= 20;
  OCI_FNCODE_STMTEXECUTE 	= 21;
  // unused 22, 23
  OCI_FNCODE_DEFINE 		= 24;
  OCI_FNCODE_DEFINEOBJECT 	= 25;
  OCI_FNCODE_DEFINEDYNAMIC  	= 26;
  OCI_FNCODE_DEFINEARRAYOFSTRUCT= 27;
  OCI_FNCODE_STMTFETCH  	= 28;
  OCI_FNCODE_STMTGETBIND  	= 29;
  // 30, 31 unused
  OCI_FNCODE_DESCRIBEANY 	= 32;
  OCI_FNCODE_TRANSSTART 	= 33;
  OCI_FNCODE_TRANSDETACH 	= 34;
  OCI_FNCODE_TRANSCOMMIT 	= 35;
  // 36 unused
  OCI_FNCODE_ERRORGET  		= 37;
  OCI_FNCODE_LOBOPENFILE 	= 38;
  OCI_FNCODE_LOBCLOSEFILE 	= 39;
  OCI_FNCODE_LOBCREATEFILE 	= 40;
  OCI_FNCODE_LOBDELFILE 	= 41;
  OCI_FNCODE_LOBCOPY 		= 42;
  OCI_FNCODE_LOBAPPEND 		= 43;
  OCI_FNCODE_LOBERASE 		= 44;
  OCI_FNCODE_LOBLENGTH	 	= 45;
  OCI_FNCODE_LOBTRIM 		= 46;
  OCI_FNCODE_LOBREAD 		= 47;
  OCI_FNCODE_LOBWRITE 		= 48;
  // 49 unused
  OCI_FNCODE_SVCCTXBREAK	= 50;
  OCI_FNCODE_SERVERVERSION 	= 51;
  // unused 52, 53
  OCI_FNCODE_ATTRGET		= 54;
  OCI_FNCODE_ATTRSET		= 55;
  OCI_FNCODE_PARAMSET		= 56;
  OCI_FNCODE_PARAMGET		= 57;
  OCI_FNCODE_STMTGETPIECEINFO  	= 58;
  OCI_FNCODE_LDATOSVCCTX	= 59;
  OCI_FNCODE_RESULTSETTOSTMT	= 60;
  OCI_FNCODE_STMTSETPIECEINFO  	= 61;
  OCI_FNCODE_TRANSFORGET	= 62;
  OCI_FNCODE_TRANSPREPARE	= 63;
  OCI_FNCODE_TRANSROLLBACK 	= 64;

  OCI_FNCODE_DEFINEBYPOS	= 65;
  OCI_FNCODE_BINDBYPOS		= 66;
  OCI_FNCODE_BINDBYNAME		= 67;

  OCI_FNCODE_LOBASSIGN 		= 68;
  OCI_FNCODE_LOBISEQUAL 	= 69;
  OCI_FNCODE_LOBISINIT 		= 70;
  OCI_FNCODE_LOBLOCATORSIZE 	= 71;
  OCI_FNCODE_LOBCHARSETID 	= 72;
  OCI_FNCODE_LOBCHARSETFORM 	= 73;
  OCI_FNCODE_LOBFILESETNAME 	= 74;
  OCI_FNCODE_LOBFILEGETNAME 	= 75;

  OCI_FNCODE_LOGON		= 76;
  OCI_FNCODE_LOGOFF		= 77;

type
//	Handle Definitions
  OCIEnv           	= dvoid;	// OCI environment handle
  OCIError         	= dvoid;    	// OCI error handle
  OCISvcCtx        	= dvoid; 	// OCI service handle
  OCIStmt          	= dvoid; 	// OCI statement handle
  OCIBind          	= dvoid;      // OCI bind handle
  OCIDefine        	= dvoid;  	// OCI Define handle
  OCIDescribe      	= dvoid;  	// OCI Describe handle
  OCIServer        	= dvoid;  	// OCI Server handle
  OCISession     	= dvoid;     	// OCI Authentication handle
  OCIComplexObject 	= dvoid; 	// OCI COR handle
  OCITrans         	= dvoid; 	// OCI Transaction handle
  OCISecurity      	= dvoid;	// OCI Security handle

  OCICPool         	= dvoid;      // connection pool handle
  OCISPool         	= dvoid;      // session pool handle
  OCIAuthInfo      	= dvoid;      // auth handle

{$IFDEF XSQL_CLR}
  POCIEnv		= dvoid;
  POCIError		= dvoid;
  POCISvcCtx		= dvoid;
  POCIStmt		= dvoid;
  POCIBind		= dvoid;
  PPOCIBind		= dvoid;
  POCIDefine		= dvoid;
  POCIDescribe		= dvoid;
  POCIServer        	= dvoid;
  POCISession     	= dvoid;

  POCICPool         	= dvoid;
  POCISPool         	= dvoid;
  POCIAuthInfo      	= dvoid;

  POCISnapshot		= dvoid;
  POCILobLocator	= dvoid;
  POCIResult		= dvoid;
  POCIParam		= dvoid;
  POCIComplexObjectComp	= dvoid;
  POCIRowid		= dvoid;

  POCIDateTime		= dvoid;
  POCIInterval		= dvoid;
{$ELSE}
  POCIEnv		= ^OCIEnv;
  POCIError		= ^OCIError;
  POCISvcCtx		= ^OCISvcCtx;
  POCIStmt		= ^OCIStmt;
  POCIBind		= ^OCIBind;
  PPOCIBind		= ^POCIBind;
  POCIDefine		= ^OCIDefine;
  POCIDescribe		= ^OCIDescribe;
  POCIServer        	= ^OCIServer;
  POCISession     	= ^OCISession;

  POCICPool         	= ^OCICPool;
  POCISPool         	= ^OCISPool;
  POCIAuthInfo      	= ^OCIAuthInfo;

  POCISnapshot		= ^OCISnapshot;
  POCILobLocator	= ^OCILobLocator;
  POCIResult		= ^OCIResult;
  POCIParam		= ^OCIParam;
  POCIComplexObjectComp	= ^OCIComplexObjectComp;
  POCIRowid		= ^OCIRowid;

  POCIDateTime		= ^OCIDateTime;
  POCIInterval		= ^OCIInterval;
{$ENDIF}

//	Descriptor Definitions
  OCISnapshot     	= dvoid;      // OCI snapshot descriptor
  OCIResult       	= dvoid;      // OCI Result Set Descriptor
  OCILobLocator   	= dvoid; 	// OCI Lob Locator descriptor
  OCIParam        	= dvoid;      // OCI PARameter descriptor
  OCIComplexObjectComp	= dvoid;	// OCI COR descriptor
  OCIRowid		= dvoid;	// OCI ROWID descriptor

  OCIDateTime 		= dvoid;     	// OCI DateTime descriptor
  OCIInterval 		= dvoid;     	// OCI Interval descriptor

  OCIUcb      		= dvoid;     	// OCI User Callback descriptor
  OCIServerDNs		= dvoid;    	// OCI server DN descriptor

// Lob typedefs for Pro*C
  OCIClobLocator	= OCILobLocator;	// OCI Character LOB Locator
  OCIBlobLocator	= OCILobLocator;       	// OCI Binary LOB Locator
  OCIBFileLocator	= OCILobLocator; 	// OCI Binary LOB File Locator

const
// Undefined value for tz in interval types
  OCI_INTHR_UNK 	= 24;

// These defined adjustment values
  OCI_ADJUST_UNK        = 10;
  OCI_ORACLE_DATE       = 0;
  OCI_ANSI_DATE         = 1;

type
//	Lob-specific Definitions

// ociloff - OCI Lob OFFset
  OCILobOffset 		= ubig_ora;

// ocillen - OCI Lob LENgth (of lob data)
  OCILobLength		= ubig_ora;

// ocilmo - OCI Lob open MOdes
//enum OCILobMode{ OCI_LOBMODE_READONLY = 1 /* read-only */ };
  OCILobMode		= Integer;
const
  OCI_LOBMODE_READONLY 	= 1;

//	FILE open modes
  OCI_FILE_READONLY	= 1;	// readonly mode open for FILE types

//	LOB Buffering Flush Flags
  OCI_LOB_BUFFER_FREE  	= 1;
  OCI_LOB_BUFFER_NOFREE	= 2;

//	OCI Statement Types
  OCI_STMT_SELECT 	= 1;	// select statement
  OCI_STMT_UPDATE 	= 2;	// update statement
  OCI_STMT_DELETE 	= 3;	// delete statement
  OCI_STMT_INSERT 	= 4;	// Insert Statement
  OCI_STMT_CREATE 	= 5;	// create statement
  OCI_STMT_DROP   	= 6;  	// drop statement
  OCI_STMT_ALTER  	= 7; 	// alter statement
  OCI_STMT_BEGIN  	= 8;   	// begin ... (pl/sql statement)
  OCI_STMT_DECLARE	= 9;	// declare .. (pl/sql statement )

//	OCI Parameter Types
  OCI_PTYPE_UNK        	= 0;	// unknown
  OCI_PTYPE_TABLE      	= 1;	// table
  OCI_PTYPE_VIEW       	= 2;	// view
  OCI_PTYPE_PROC       	= 3;	// procedure
  OCI_PTYPE_FUNC       	= 4;	// function
  OCI_PTYPE_PKG	       	= 5;	// package
  OCI_PTYPE_TYPE       	= 6; 	// user-defined type
  OCI_PTYPE_SYN	       	= 7; 	// synonym
  OCI_PTYPE_SEQ	       	= 8; 	// sequence
  OCI_PTYPE_COL	       	= 9; 	// column
  OCI_PTYPE_ARG	       	= 10;	// argument
  OCI_PTYPE_LIST       	= 11;	// list
  OCI_PTYPE_TYPE_ATTR  	= 12; 	// user-defined type's attribute
  OCI_PTYPE_TYPE_COLL  	= 13; 	// collection type's element
  OCI_PTYPE_TYPE_METHOD	= 14;  	// user-defined type's method
  OCI_PTYPE_TYPE_ARG   	= 15;  	// user-defined type method's argument
  OCI_PTYPE_TYPE_RESULT	= 16;   // user-defined type method's result

//	OCI List Types
  OCI_LTYPE_UNK        	= 0;	// unknown   
  OCI_LTYPE_COLUMN     	= 1;	// column list
  OCI_LTYPE_ARG_PROC   	= 2;	// procedure argument list
  OCI_LTYPE_ARG_FUNC   	= 3;	// function argument list
  OCI_LTYPE_SUBPRG     	= 4;	// subprogram list
  OCI_LTYPE_TYPE_ATTR  	= 5;	// type attribute
  OCI_LTYPE_TYPE_METHOD	= 6;	// type method
  OCI_LTYPE_TYPE_ARG_PROC=7;	// type method w/o result argument list
  OCI_LTYPE_TYPE_ARG_FUNC=8;	// type method w/result argument list

{*******************************************************************************
*	ORO.H - ORacle Object Interface for External/Internal/Kernel Clients
*Purpose:
*    This header file contains Oracle object interface definitions which
*    can be included by external user applications, tools, as well as
*    the kernel.  It defines types and constants that are common to all
*    object interface which is being defined in several other header files
*    (e.g., ori.h, ort.h, and orl.h).
*******************************************************************************}
type
// OCIRef - OCI object REFerence
  OCIRef 	= Pointer;
  POCIRef	= ^OCIRef;

// OCIInd -- a variable of this type contains (null) indicator information
  OCIInd	= sb2;
  POCIInd	= ^OCIInd;

const
  OCI_IND_NOTNULL	= OCIInd( 0);	// not NULL
  OCI_IND_NULL		= OCIInd(-1);	// NULL
  OCI_IND_BADNULL	= OCIInd(-2);	// BAD NULL
  OCI_IND_NOTNULLABLE	= OCIInd(-3);	// not NULLable

//	OBJECT CACHE

type

// OCIPinOpt - OCI object Pin Option: enum OCIPinOpt{ /* 0 = uninitialized */ OCI_PIN_DEFAULT = 1, OCI_PIN_ANY = 3, OCI_PIN_RECENT = 4, OCI_PIN_LATEST = 5 };
  OCIPinOpt 	= Integer;
  POCIPinOpt	= ^OCIPinOpt;

const
  OCI_PIN_DEFAULT	= 1;		// default pin option
  OCI_PIN_ANY		= 3;		// pin any copy of the object
  OCI_PIN_RECENT	= 4;		// pin recent copy of the object
  OCI_PIN_LATEST	= 5;		// pin latest copy of the object

type
// OCILockOpt - OCI object LOCK Option: enum OCILockOpt{  /* 0 = uninitialized */ OCI_LOCK_NONE = 1, OCI_LOCK_X = 2 };
  OCILockOpt 	= Integer;
  POCILockOpt	= ^OCILockOpt;

const
  OCI_LOCK_NONE	= 1;			// null (same as no lock)
  OCI_LOCK_X	= 2;			// exclusive lock

type

// OCIMarkOpt - OCI object Mark option: enum OCIMarkOpt{ /* 0 = uninitialized */ OCI_MARK_DEFAULT = 1, OCI_MARK_NONE = OCI_MARK_DEFAULT, OCI_MARK_UPDATE };
  OCIMarkOpt	= Integer;
  POCIMarkOpt	= ^OCIMarkOpt;

const
  OCI_MARK_DEFAULT	= 1;        		// default (the same as OCI_MARK_NONE)
  OCI_MARK_NONE		= OCI_MARK_DEFAULT;	// object has not been modified
  OCI_MARK_UPDATE	= 2;			// object is to be updated

type
// OCIDuration - OCI object duration
  OCIDuration	= ub2;
  POCIDuration	= ^OCIDuration;

const
  OCI_DURATION_BEGIN	= 10;           	// beginning sequence of duration 
  OCI_DURATION_NULL	= OCI_DURATION_BEGIN-1;	// null duration
  OCI_DURATION_DEFAULT	= OCI_DURATION_BEGIN-2;	// default
  OCI_DURATION_NEXT	= OCI_DURATION_BEGIN-3;	// next special duration
  OCI_DURATION_SESSION	= OCI_DURATION_BEGIN;	// the end of user session
  OCI_DURATION_TRANS	= OCI_DURATION_BEGIN+1;	// the end of user transaction

type
// OCIRefreshOpt - OCI cache Refresh Option: enum OCIRefreshOpt{ /* 0 = uninitialized */ OCI_REFRESH_LOADED = 1 };
  OCIRefreshOpt		= Integer;
  POCIRefreshOpt	= ^OCIRefreshOpt;

const
  OCI_REFRESH_LOADED	= 1;		// refresh objects loaded in the transaction

// OCIObjectCopyFlag - Object copy flag
  OCI_OBJECTCOPY_NOREF	= ub1( $01 );

// OCIObjectFreeFlag - Object free flag
  OCI_OBJECTFREE_FORCE	= ub2( $0001 );
  OCI_OBJECTFREE_NONULL	= ub2( $0002 );

// Type manager typecodes
  OCI_TYPECODE_REF     	= SQLT_REF;     // SQL/OTS OBJECT REFERENCE
  OCI_TYPECODE_DATE    	= SQLT_DAT;     // SQL DATE  OTS DATE
  OCI_TYPECODE_SIGNED8 	= 27;     	// SQL SIGNED INTEGER(8)  OTS SINT8
  OCI_TYPECODE_SIGNED16	= 28;    	// SQL SIGNED INTEGER(16)  OTS SINT16
  OCI_TYPECODE_SIGNED32	= 29;    	// SQL SIGNED INTEGER(32)  OTS SINT32
  OCI_TYPECODE_REAL    	= 21;           // SQL REAL  OTS SQL_REAL
  OCI_TYPECODE_DOUBLE  	= 22;  		// SQL DOUBLE PRECISION  OTS SQL_DOUBLE
  OCI_TYPECODE_FLOAT   	= SQLT_FLT;     // SQL FLOAT(P)  OTS FLOAT(P)
  OCI_TYPECODE_NUMBER  	= SQLT_NUM;	// SQL NUMBER(P S)  OTS NUMBER(P S)
  OCI_TYPECODE_DECIMAL 	= SQLT_PDN;	// SQL DECIMAL(P S)  OTS DECIMAL(P S)
  OCI_TYPECODE_UNSIGNED8= SQLT_BIN;	// SQL UNSIGNED INTEGER(8)  OTS UINT8
  OCI_TYPECODE_UNSIGNED16= 25;  	// SQL UNSIGNED INTEGER(16)  OTS UINT16
  OCI_TYPECODE_UNSIGNED32= 26;  	// SQL UNSIGNED INTEGER(32)  OTS UINT32
  OCI_TYPECODE_OCTET   	= 245;          // SQL ???  OTS OCTET
  OCI_TYPECODE_SMALLINT	= 246;          // SQL SMALLINT  OTS SMALLINT
  OCI_TYPECODE_INTEGER 	= SQLT_INT;     // SQL INTEGER  OTS INTEGER
  OCI_TYPECODE_RAW     	= SQLT_LVB;     // SQL RAW(N)  OTS RAW(N)
  OCI_TYPECODE_PTR     	= 32;           // SQL POINTER  OTS POINTER
  OCI_TYPECODE_VARCHAR2	= SQLT_VCS; 	// SQL VARCHAR2(N)  OTS SQL_VARCHAR2(N)
  OCI_TYPECODE_CHAR    	= SQLT_AFC;    	// SQL CHAR(N)  OTS SQL_CHAR(N)
  OCI_TYPECODE_VARCHAR 	= SQLT_CHR; 	// SQL VARCHAR(N)  OTS SQL_VARCHAR(N)
  OCI_TYPECODE_MLSLABEL	= SQLT_LAB;     // OTS MLSLABEL
  OCI_TYPECODE_VARRAY  	= 247;         	// SQL VARRAY  OTS PAGED VARRAY
  OCI_TYPECODE_TABLE   	= 248;          // SQL TABLE  OTS MULTISET
  OCI_TYPECODE_OBJECT  	= SQLT_NTY;  	// SQL/OTS NAMED OBJECT TYPE
  OCI_TYPECODE_NAMEDCOLLECTION= SQLT_NCO;// SQL/OTS NAMED COLLECTION TYPE
  OCI_TYPECODE_BLOB    	= SQLT_BLOB;    // SQL/OTS BINARY LARGE OBJECT
  OCI_TYPECODE_BFILE   	= SQLT_BFILE;   // SQL/OTS BINARY FILE OBJECT
  OCI_TYPECODE_CLOB    	= SQLT_CLOB; 	// SQL/OTS CHARACTER LARGE OBJECT
  OCI_TYPECODE_CFILE   	= SQLT_CFILE; 	// SQL/OTS CHARACTER FILE OBJECT

  // the following are ANSI datetime datatypes added in 8.1
  OCI_TYPECODE_TIME     = SQLT_TIME;            // SQL/OTS TIME
  OCI_TYPECODE_TIME_TZ  = SQLT_TIME_TZ;         // SQL/OTS TIME_TZ
  OCI_TYPECODE_TIMESTAMP= SQLT_TIMESTAMP;       // SQL/OTS TIMESTAMP
  OCI_TYPECODE_TIMESTAMP_TZ = SQLT_TIMESTAMP_TZ;// SQL/OTS TIMESTAMP_TZ

  OCI_TYPECODE_TIMESTAMP_LTZ = SQLT_TIMESTAMP_LTZ;	// TIMESTAMP_LTZ

  OCI_TYPECODE_INTERVAL_YM = SQLT_INTERVAL_YM;	// SQL/OTS INTRVL YR-MON
  OCI_TYPECODE_INTERVAL_DS = SQLT_INTERVAL_DS;	// SQL/OTS INTRVL DAY-SEC

  OCI_TYPECODE_OTMFIRST	= 228;     	// first Open Type Manager typecode
  OCI_TYPECODE_OTMLAST 	= 320;       	// last OTM typecode
  OCI_TYPECODE_SYSFIRST	= 228;     	// first OTM system type (internal)
  OCI_TYPECODE_SYSLAST 	= 235;      	// last OTM system type (internal)

	// the following are PL/SQL-only internal. They should not be used
//  OCI_TYPECODE_ITABLE  	= SQLT_TAB;	// PLSQL indexed table
//  OCI_TYPECODE_RECORD  	= SQLT_REC;     // PLSQL record
//  OCI_TYPECODE_BOOLEAN 	= SQLT_BOL;     // PLSQL boolean

// NOTE : The following NCHAR related codes are just short forms for saying
// OCI_TYPECODE_VARCHAR2 with a charset form of SQLCS_NCHAR. These codes are
// intended for use in the OCIAnyData API only and nowhere else.
  OCI_TYPECODE_NCHAR    = 286;
  OCI_TYPECODE_NVARCHAR2= 287;
  OCI_TYPECODE_NCLOB    = 288;

	// To indicate absence of typecode being specified
  OCI_TYPECODE_NONE     = 0;
	// To indicate error has to be taken from error handle - reserved for sqlplus use
  OCI_TYPECODE_ERRHP    = 283;

type
// The OCITypeCode type is interchangeable with the existing SQLT type which is a ub2
  OCITypeCode	= ub2;

// GET OPTIONS FOR TDO : enum OCITypeGetOpt{ OCI_TYPEGET_HEADER, OCI_TYPEGET_ALL };
  OCITypeGetOpt	= Integer;
  POCITypeGetOpt= ^OCITypeGetOpt;

const
  OCI_TYPEGET_HEADER	= 0;	// load only the header portion of the TDO when getting type
  OCI_TYPEGET_ALL 	= 1;	// load all attribute and method descriptors as well

type
// OCITypeEncap - OCI Encapsulation Level: enum OCITypeEncap{ /* 0 = uninitialized */ OCI_TYPEENCAP_PRIVATE, OCI_TYPEENCAP_PUBLIC };
  OCITypeEncap 	= Integer;
  POCITypeEncap	= ^OCITypeEncap;

const
  OCI_TYPEENCAP_PRIVATE	= 1;	// private: only internally visible
  OCI_TYPEENCAP_PUBLIC	= 2;	// public: visible to both internally and externally

type
// TYPE METHOD FLAGS: enum OCITypeMethodFlag{ ... }
  OCITypeMethodFlag	= Integer;
  POCITypeMethodFlag	= ^OCITypeMethodFlag;

const
  OCI_TYPEMETHOD_INLINE		= $0001;	// inline
  OCI_TYPEMETHOD_CONSTANT	= $0002;	// constant
  OCI_TYPEMETHOD_VIRTUAL	= $0004;       	// virtual
  OCI_TYPEMETHOD_CONSTRUCTOR	= $0008;	// constructor
  OCI_TYPEMETHOD_DESTRUCTOR	= $0010; 	// destructor
  OCI_TYPEMETHOD_OPERATOR 	= $0020;    	// operator
  OCI_TYPEMETHOD_SELFISH	= $0040;    	// selfish method (generic otherwise)
	// OCI_TYPEMETHOD_MAP and OCI_TYPEMETHOD_ORDER are mutually exclusive 
  OCI_TYPEMETHOD_MAP		= $0080;	// map (relative ordering)
  OCI_TYPEMETHOD_ORDER 		= $0100;	// order (relative ordering)

  OCI_TYPEMETHOD_RNDS		= $0200;	// Read no Data State (default)
  OCI_TYPEMETHOD_WNDS		= $0400;	// Write no Data State
  OCI_TYPEMETHOD_RNPS		= $0800;	// Read no Process State
  OCI_TYPEMETHOD_WNPS		= $1000;	// Write no Process State

type
// TYPE PARAMETER MODE: enum OCITypeParamMode{ /* PL/SQL starts this from 0 */ OCI_TYPEPARAM_IN = 0, OCI_TYPEPARAM_OUT, OCI_TYPEPARAM_INOUT, OCI_TYPEPARAM_BYREF };
  OCITypeParamMode	= Integer;
  POCITypeParamMode	= ^OCITypeParamMode;

const
  OCI_TYPEPARAM_IN	= 0;		// in
  OCI_TYPEPARAM_OUT	= 1;		// out
  OCI_TYPEPARAM_INOUT	= 2;		// in-out
  OCI_TYPEPARAM_BYREF	= 3;		// call by reference (implicitly in-out)

//	DEFAULTS

// default binary and decimal precision and scale
  OCI_NUMBER_DEFAULTPREC	= ub1( 0 );            	// no precision specified
  OCI_NUMBER_DEFAULTSCALE	= sb1( MAXSB1MINVAL );	// no binary/decimal scale specified 

// default maximum length for varrays and vstrings (used in sql.bsq)
  OCI_VARRAY_MAXSIZE	= 4000;		// default maximum number of elements for a varray
  OCI_STRING_MAXLEN 	= 4000;		// default maximum length of a vstring

// Special duration for allocating memory only. No instance can be allocated given these durations.
type
  OCICoherency 	= OCIRefreshOpt;
const
  OCI_COHERENCY_NONE 	= OCIRefreshOpt( 2 );
  OCI_COHERENCY_NULL  	= OCIRefreshOpt( 4 );
  OCI_COHERENCY_ALWAYS	= OCIRefreshOpt( 5 );

  
{*******************************************************************************
*	ORT.H - ORacle's external open Type interface to the open type manager (OTM)
*Purpose:
*    The open type manager interface includes dynamic type operations to
*    create, delete, update, and access types.
*******************************************************************************}

type
// OCIType - OCI Type Description Object
  OCIType	= dvoid;
  POCIType	= ^OCIType;

// OCITypeElem - OCI Type Element object
  OCITypeElem	= dvoid;
  POCITypeElem	= ^OCITypeElem;

// OCITypeMethod - OCI Method Description object
  OCITypeMethod	= dvoid;
  POCITypeMethod= ^OCITypeMethod;

{$IFDEF XSQL_CLR}
  PPChar	= dvoid;
{$ELSE}
  PPChar	= ^TSDCharPtr;
{$ENDIF}

var
// OCITypeArrayByName - OCI Get array of TYPes by name.
  OCITypeArrayByName:
  	function (var hEnv: OCIEnv; var hError: OCIError; const phSvc: POCISvcCtx; array_len: ub4;
                const arr_schema_name: PPChar; arr_s_length: ub4p;
                const arr_type_name: PPChar; arr_t_length: ub4p;
                const arr_version_name: PPChar; arr_v_length: ub4p;
                pin_duration: OCIDuration; get_option: OCITypeGetOpt; arr_tdo: POCIType ): sword; cdecl;

// OCITypeArrayByRef - OCI Get array of TYPes by REF.
  OCITypeArrayByRef:
  	function (var hEnv: OCIEnv; var hError: OCIError;
        	array_len: ub4;	const arr_type_ref: POCIRef;
                pin_duration: OCIDuration; get_option: OCITypeGetOpt; arr_tdo: POCIType): sword; cdecl;


{*******************************************************************************
*									       *
*	OCIAP.H - Oracle Call Interface - Ansi Prototypes                      *
*									       *
*******************************************************************************}

//	Dynamic Callback Function Pointers
type
  TOCICallbackInBind =
  	function(ictxp: Pdvoid; phBind: POCIBind; iter, index: ub4;
  		bufpp: PPdvoid; alenp: ub4p; piecep: ub1p; indpp: PPdvoid): sb4; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}

  TOCICallbackOutBind =
  	function(octxp: Pdvoid; phBind: POCIBind; iter, index: ub4;
        	bufpp: PPdvoid; alenpp: ub4pp; piecep: ub1p;
                indpp: PPdvoid; rcodepp: ub2pp): sb4; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}

  TOCICallbackDefine =
  	function(octxp: Pdvoid; phDefn: POCIDefine; iter: ub4;
        	bufpp: PPdvoid; alenpp: ub4pp; piecep: ub1p;
                indpp: PPdvoid; rcodepp: ub2pp): sb4; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}

  TOCICallbackLobRead =
  	function(ctxp: Pdvoid; const bufp: Pdvoid; len: ub4; piece: ub1): sb4; cdecl;

  TOCICallbackLobWrite =
  	function(ctxp: Pdvoid; bufp: Pdvoid; lenp: ub4p; piece: ub1p): sb4; cdecl;

//	Failover Callback Structure
  TOCICallbackFailover =
  	function(svcctx, envctx, fo_ctx: Pdvoid; fo_type, fo_event: ub4): sb4; cdecl;

  TOCIFocbkStruct = record
    callback_function: TOCICallbackFailover;
    fo_ctx: Pdvoid;
  end;

type
  Tmalocfp = function(ctxp: Pdvoid; size: size_t): Pdvoid; cdecl;
  Tralocfp = function(ctxp: Pdvoid; memptr: Pdvoid; newsize: size_t): Pdvoid; cdecl;
  Tmfreefp = procedure(ctxp: Pdvoid; memptr: Pdvoid ); cdecl;
	// callback types for OCILobRead and OCI LobWrite procedure
  TCBLobRead	= function(ctxp: Pdvoid; const bufp: Pdvoid; len: ub4; piece: ub1): sb4; cdecl;
  TCBLobWrite	= function(ctxp: Pdvoid; bufp: Pdvoid; len: ub4p; piece: ub1p): sb4; cdecl;

{$IFNDEF XSQL_CLR}
var
  OCIInitialize:
  	function (mode: ub4; ctxp: Pdvoid;
        	malocfp: Tmalocfp; ralocfp: Tralocfp; mfreefp: Tmfreefp): sword; cdecl;
  OCITerminate:
   	function (mode: ub4): sword; cdecl;

  OCIHandleAlloc:
  	function (const phParenEnv: Pdvoid; var hndlp: Pdvoid; htype: ub4;
        	xtramem_sz: size_t; usrmemp: PPdvoid): sword; cdecl;

  OCIHandleFree:
  	function (hndlp: Pdvoid; htype: ub4): sword; cdecl;

  OCIDescriptorAlloc:
  	function (const phParenEnv: Pdvoid; var descp: Pdvoid; htype: ub4;
        	xtramem_sz: size_t; usrmemp: PPdvoid): sword; cdecl;

  OCIDescriptorFree:
  	function (descp: Pdvoid; htype: ub4): sword; cdecl;

  OCIEnvCreate:
  	function(var phEnv: POCIEnv; mode: ub4; ctxp: Pdvoid;
        	malocfp: Tmalocfp; ralocfp: Tralocfp; mfreefp: Tmfreefp;
                xtramem_sz: size_t; usrmemp: Pdvoid): sword; cdecl;

  OCIEnvInit:
  	function (var phEnv: POCIEnv; mode: ub4;
        	xtramem_sz: size_t; usrmemp: Pdvoid): sword; cdecl;

  OCIServerAttach:
  	function (phSrv: POCIServer; phError: POCIError;
        	const dblink: TSDCharPtr; dblink_len: sb4; mode: ub4): sword; cdecl;

  OCIServerDetach:
  	function (phSrv: POCIServer; phError: POCIError; mode: ub4): sword; cdecl;

  OCISessionBegin:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	phUsr: POCISession; credt, mode: ub4): sword; cdecl;

  OCISessionEnd:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	phUsr: POCISession; mode: ub4): sword; cdecl;

  OCILogon:
  	function (phEnv: POCIEnv; phError: POCIError; var svchp: POCISvcCtx;
        	const username: TSDCharPtr; uname_len: ub4; const password: TSDCharPtr; passwd_len: ub4;
                const dbname: TSDCharPtr; dbname_len: ub4): sword; cdecl;

  OCILogoff:
  	function (phSvc: POCISvcCtx; phError: POCIError): sword; cdecl;

  OCIPasswordChange:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	const user_name: TSDCharPtr; usernm_len: ub4; const opasswd: TSDCharPtr; opasswd_len: ub4;
                const npasswd: TSDCharPtr; npasswd_len, mode: ub4): sword; cdecl;

  OCIStmtPrepare:
  	function (phStmt: POCIStmt; phError: POCIError;
        	const stmt: TSDCharPtr; stmt_len, language, mode: ub4): sword; cdecl;

  OCIBindByPos:
  	function (phStmt: POCIStmt; var phBind: POCIBind; phError: POCIError;
        	position: ub4; valuep: Pdvoid; value_sz: sb4; dty: ub2; indp: Pdvoid;
                alenp, rcodep: ub2p; maxarr_len: ub4; curelep: ub4p; mode: ub4): sword; cdecl;

  OCIBindByName:
  	function (phStmt: POCIStmt; var phBind: POCIBind; phError: POCIError;
        	const placeholder: TSDCharPtr; placeh_len: sb4; valuep: Pdvoid; value_sz: sb4; dty: ub2; indp: Pdvoid;
                alenp, rcodep: ub2p; maxarr_len: ub4; curelep: ub4p; mode: ub4): sword; cdecl;

  OCIBindObject:
  	function (phBind: POCIBind; phError: POCIError; const otype: POCIType;
        	var pgvp: Pdvoid; pvszsp: ub4; var indp: Pdvoid; indszp: ub4p): sword; cdecl;

  OCIBindDynamic:
  	function (phBind: POCIBind; phError: POCIError;
        	ictxp: Pdvoid; icbfp: TOCICallbackInBind;
                octxp: Pdvoid; ocbfp: TOCICallbackOutBind): sword; cdecl;

  OCIBindArrayOfStruct:
  	function (phBind: POCIBind; phError: POCIError;
        	pvskip, indskip, alskip, rcskip: ub4): sword; cdecl;

  OCIStmtGetPieceInfo:
  	function (phStmt: POCIStmt; phError: POCIError; var hndlp: Pdvoid; var htype: ub4;
        	var in_out: ub1; var iter, idx: ub4; var piece: ub1): sword; cdecl;

  OCIStmtSetPieceInfo:
  	function (hndlp: Pdvoid; HandleType: ub4; phError: POCIError;
        	const bufp: dvoid; var alen: ub4; piece: ub1;
                var ind: sb2; rcodep: ub2p): sword; cdecl;

  OCIStmtExecute:
  	function (phSvc: POCISvcCtx; phStmt: POCIStmt; phError: POCIError; iters, rowoff: ub4;
        	const snap_in: POCISnapshot; snap_out: POCISnapshot; mode: ub4): sword; cdecl;

  OCIDefineByPos:
  	function (phStmt: POCIStmt; var phDefine: POCIDefine; phError: POCIError;
  		position: ub4; pValue: dvoid; value_sz: sb4; dty: ub2;
                indp: Pdvoid; rlenp, rcodep: ub2p; mode: ub4): sword; cdecl;

  OCIDefineObject:
  	function (phDefine: POCIDefine; phError: POCIError; const phType: POCIType;
        	var pgvp: Pdvoid; pvszsp: ub4p; var indp: Pdvoid; indszp: ub4p): sword; cdecl;

  OCIDefineDynamic:
  	function (phDefine: POCIDefine; phError: POCIError;
        	octxp: Pdvoid; ocbfp: TOCICallbackDefine): sword; cdecl;

  OCIDefineArrayOfStruct:
  	function (phDefine: POCIDefine; phError: POCIError;
        	pvskip, indskip, rlskip, rcskip: ub4): sword; cdecl;

  OCIStmtFetch:
  	function (phStmt: POCIStmt; phError: POCIError;
        	nrows: ub4; orientation: ub2; mode: ub4): sword; cdecl;

  OCIStmtGetBindInfo:
  	function (phStmt: POCIStmt; phError: POCIError;
        	size, startloc: ub4; found: sb4p; arr_bvn: PPChar; arr_bvnl: ub1p;
                arr_inv: PPChar; arr_inpl, arr_dupl: ub1p; arr_hndl: PPOCIBind): sword; cdecl;

  OCIDescribeAny:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	objptr: Pdvoid;	objnm_len: ub4; objptr_typ, info_level, objtyp: ub1;
                phDsc: POCIDescribe): sword; cdecl;

  OCIParamGet:
  	function (const pHndl: Pdvoid; htype: ub4; phError: POCIError;
        	var pParmd: Pdvoid; pos: ub4): sword; cdecl;

  OCIParamSet:
  	function (pHdl: Pdvoid; htyp: ub4; phError: POCIError;
        	const pDsc: Pdvoid; dtyp, pos: ub4): sword; cdecl;

  OCITransStart:
  	function (phSvc: POCISvcCtx; phError: POCIError; timeout: uword; flags: ub4): sword; cdecl;

  OCITransDetach:
  	function (phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; cdecl;

  OCITransCommit:
  	function (phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; cdecl;

  OCITransRollback:
  	function (phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; cdecl;

  OCITransPrepare:
  	function (phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; cdecl;

  OCITransForget:
  	function (phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; cdecl;

  OCIErrorGet:
  	function (pHndl: Pdvoid; RecordNo: ub4; SqlState: TSDCharPtr;
        	var ErrCode: sb4; buf: TSDCharPtr; bufsiz, typ: ub4): sword; cdecl;

  OCILobAppend:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	dst_locp, src_locp: POCILobLocator): sword; cdecl;

  OCILobAssign:
  	function (phEnv: POCIEnv; phError: POCIError;
        	const src_locp: POCILobLocator; var dst_locp: POCILobLocator): sword; cdecl;

  OCILobCharSetForm:
  	function (phEnv: POCIEnv; phError: POCIError;
        	const locp: POCILobLocator; csfrm: ub1p): sword; cdecl;

  OCILobCharSetId:
  	function (phEnv: POCIEnv; phError: POCIError;
        	const locp: POCILobLocator; csid: ub2p): sword; cdecl;

  OCILobCopy:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	dst_locp, src_locp: OCILobLocator;
                amount, dst_offset, src_offset: ub4): sword; cdecl;

  OCILobCreateTemporary:
        function(phSvc: POCISvcCtx; phError: POCIError;
                locp: POCILobLocator; csid: ub2; csfrm, lobtype: ub1;
                cache: OraBoolean; duration: OCIDuration): sword; cdecl;

  OCILobDisableBuffering:
  	function (phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator): sword; cdecl;

  OCILobEnableBuffering:
  	function (phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator): sword; cdecl;

  OCILobErase:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	locp: POCILobLocator; amount: ub4p; offset: ub4): sword; cdecl;

  OCILobFileClose:
  	function (phSvc: POCISvcCtx; phError: POCIError; filep: POCILobLocator): sword; cdecl;

  OCILobFileCloseAll:
  	function (phSvc: POCISvcCtx; phError: POCIError): sword; cdecl;

  OCILobFileExists:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	filep: POCILobLocator; var flag: OraBoolean): sword; cdecl;

  OCILobFileGetName:
  	function (phEnv: POCIEnv; phError: POCIError;
        	const filep: POCILobLocator; dir_alias: TSDCharPtr; d_length: ub2p;
                filename: TSDCharPtr; f_length: ub2p): sword; cdecl;

  OCILobFileIsOpen:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	filep: POCILobLocator; var flag: OraBoolean): sword; cdecl;

  OCILobFileOpen:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	filep: POCILobLocator; mode: ub1): sword; cdecl;

  OCILobFileSetName:
  	function (phEnv: POCIEnv; phError: POCIError;
        	var filep: POCILobLocator; const dir_alias: TSDCharPtr; d_length: ub2;
                const filename: TSDCharPtr; f_length: ub2): sword; cdecl;

  OCILobFlushBuffer:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	locp: POCILobLocator; flag: ub4): sword; cdecl;

  OCILobFreeTemporary:
        function(phSvc: POCISvcCtx; phError: POCIError;
                locp: POCILobLocator): sword; cdecl;

  OCILobGetLength:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	locp: POCILobLocator; var len: ub4): sword; cdecl;

  OCILobIsEqual:
  	function (phEnv: POCIEnv;
        	const x, y: POCILobLocator; var is_equal: OraBoolean): sword; cdecl;

  OCILobLoadFromFile:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	dst_locp, src_filep: POCILobLocator;
                amount, dst_offset, src_offset: ub4): sword; cdecl;

  OCILobLocatorIsInit:
  	function (phEnv: POCIEnv; phError: POCIError;
        	const locp: POCILobLocator; var is_initialized: OraBoolean): sword; cdecl;

  OCILobRead:
  	function (phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator;
        	var amt: ub4; offset: ub4; bufp: dvoid; bufl: ub4;
                ctxp: Pdvoid; cbfp: TCBLobRead; csid: ub2; csfrm: ub1): sword; cdecl;

  OCILobTrim:
  	function (phSvc: POCISvcCtx; phError: POCIError;
        	locp: POCILobLocator; newlen: ub4): sword; cdecl;

  OCILobWrite:
  	function (phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator;
        	var amt: ub4; offset: ub4; bufp: dvoid; buflen: ub4; piece: ub1;
                ctxp: Pdvoid; cbfp: TCBLobWrite; csid: ub2; csfrm: ub1): sword; cdecl;

  OCIBreak:
  	function (pHndl: Pdvoid; phError: POCIError): sword; cdecl;

  OCIServerVersion:
  	function (pHndl: Pdvoid; phError: POCIError;
        	buf: TSDCharPtr; bufsz: ub4; hndltype: ub1): sword; cdecl;

  OCIAttrGet:
  	function (const trgthndlp: Pdvoid; trghndltyp: ub4;
        	attributep: dvoid; sizep: ub4p; attrtype: ub4; phError: POCIError): sword; cdecl;

  OCIAttrSet:
  	function (trgthndlp: Pdvoid; trghndltyp: ub4;
        	attributep: dvoid; size, attrtype: ub4; phError: POCIError): sword; cdecl;

  OCISvcCtxToLda:
  	function (phSvc: POCISvcCtx; phError: POCIError; ldap: PLdaDef): sword; cdecl;

  OCILdaToSvcCtx:
  	function (var phSvc: POCISvcCtx; phError: POCIError; ldap: PLdaDef): sword; cdecl;

  OCIResultSetToStmt:
  	function (phRset: POCIResult; phError: POCIError): sword; cdecl;

  xaoEnv:
  	function (dbname: TSDCharPtr): POCIEnv; cdecl;

  xaoSvcCtx:
  	function (dbname: TSDCharPtr): POCISvcCtx; cdecl;

	// Oracle9i Extensions to Datetime interfaces
  OCIDateTimeConstruct: function(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
  		year: sb2; month, day, hour, min, sec: ub1; fsec: ub4;
               	timezone: POraText; timezone_length: size_t): sword; cdecl;
  OCIDateTimeGetDate: function(pHndl: Pdvoid; phError: POCIError;  date: POCIDateTime;
	                   var year: sb2; var month, day: ub1): sword; cdecl;
  OCIDateTimeGetTime: function(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
		var hour, minute, sec: ub1; var fsec: ub4): sword; cdecl;
  OCIDateTimeGetTimeZoneName: function(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
                                 buf: ub1p; buflen: ub4p): sword; cdecl;
  OCIDateTimeGetTimeZoneOffset: function(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
                var hour, minute: sb1): sword; cdecl;

  OCIIntervalSetYearMonth: function(pHndl: Pdvoid; phError: POCIError;
                yr, mnth: sb4; result: POCIInterval): sword; cdecl;

  OCIIntervalGetYearMonth: function(pHndl: Pdvoid; phError: POCIError;
                var  yr, mnth: sb4; const result: POCIInterval): sword; cdecl;

  OCIIntervalSetDaySecond: function(pHndl: Pdvoid; phError: POCIError;
                dy, hr, mm, ss, fsec: sb4; result: POCIInterval): sword; cdecl;

  OCIIntervalGetDaySecond: function(pHndl: Pdvoid; phError: POCIError;
                var dy, hr, mm, ss, fsec: sb4; const result: POCIInterval): sword; cdecl;

{$ENDIF}

{------------------------- OCI8 END - V8 Oracle Call Interface definitions ------------------}

type
	// Oracle cursor types for OCI7
//  POraCursor	= PCdaDef;
  ESDOraError = class(ESDEngineError);

{ TIOraDatabase }
  TIOraConnInfo	= packed record
    ServerType: Byte;
    LdaPtr:	PLdaDef;
    HdaPtr:	PHdaDef;
    CdaPtr:	PCdaDef;
  end;

  TIOraDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;
    FIsEnableInts: Boolean;
    procedure Check(Status: TSDEResult);
    procedure AllocHandle;
    procedure FreeHandle;
    function GetCurHandle: PCdaDef;
    function GetLdaPtr: PLdaDef;
    function GetMaxCharParamLen: Integer;
    procedure GetStmtResult(const Stmt: string; List: TStrings); virtual;
    procedure SetDefaultOptions;
  protected
    function GetHandle: TSDPtr; override;
    procedure DoConnect(const ARemoteDatabase, AUserName, APassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;

    procedure SetAutoCommitOption(Value: Boolean); override;
    procedure SetHandle(AHandle: TSDPtr); override;

    property IsEnableInts: Boolean read FIsEnableInts;
    property CurHandle: PCdaDef read GetCurHandle;
    property LdaPtr: PLdaDef read GetLdaPtr;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;
    function CreateSqlCommand: TISqlCommand; override;

    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    function ParamValue(Value: TXSQLDatabaseParam): Integer; override;
    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;    
  end;

{ TIOraCommand }
  TIOraCommand = class(TISqlCommand)
  private
    FHandle: PSDCursor;
    FStmt: string;		// for Oracle deferred mode required save statement between calls 'oparse' and 'oexec'
    FParamHandle: PSDCursor;	// pointer to cursor, returned by PL/SQL procedure
    FBoundParams: Boolean;	// SpBindParams method was called
    FIsCursorParamExists: Boolean;
    FIsGetFieldDescs: Boolean;	// processing GetFieldDescs method
    function GetSqlDatabase: TIOraDatabase;
    procedure Connect;
    procedure CloseParamHandle;
    procedure InternalExecute;
    procedure InternalGetParams;
    procedure QBindParamsBuffer;
    procedure SpBindParamsBuffer;
  protected
    procedure Check(Status: TSDEResult);
    function IsPLSQLBlockExecuted: Boolean;

    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    procedure DoPrepare(Value: string); override;
    procedure DoExecDirect(Value: string); override;
    procedure DoExecute; override;
    procedure BindParamsBuffer; override;
    procedure FreeParamsBuffer; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    function GetHandle: PSDCursor; override;
    procedure InitParamList; override;
    procedure SetFieldsBuffer; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    function GetRowsAffected: Integer; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;
    function WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint; override;
    function WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint; override;
    
    property SqlDatabase: TIOraDatabase read GetSqlDatabase;
  end;

{ TIOra8Database }
  TIOra8ConnInfo = packed record
    ServerType: Byte;
    phEnv: POCIEnv;
    phErr: POCIError;
    phSvc: POCISvcCtx;
    phSrv: POCIServer;
    phUsr: POCISession;		// pointer to an user session (OCI Authentication handle)
  end;

  TIOra8Database = class(TISqlDatabase)
  private
    FHandle: TSDPtr;
    FIsEnableInts,
    FIsXAConn,
    FUseOCIDateTime: Boolean;	// use Oracle9 datetime datatype(TIMESTAMP) for TDateTimeField(ftDateTime), when Oracle9 client and server are present
    FSessTimeZone: string;	// current session's time zone for Oracle9. It means for Oracle9 datetime datatypes(TIMESTAMP)
    FTempLobSupported: Boolean; // temporary LOBs are supported in Oracle8i Release2 (8.1.6)    
    procedure AllocHandle;
    procedure FreeHandle(Force: Boolean);
    function GetConnInfoStruct: TIOra8ConnInfo;
    function GetMaxCharParamLen: Integer;
    function GetEnvPtr: POCIEnv;
    function GetErrPtr: POCIError;
    function GetSvcPtr: POCISvcCtx;
    function GetSrvPtr: POCIServer;
    function GetUsrPtr: POCISession;
    procedure GetStmtResult(const Stmt: string; List: TStrings);
    procedure SetConnInfoStruct(Value: TIOra8ConnInfo);
  protected
    procedure Check(Status: TSDEResult);
    procedure CheckExt(Status: TSDEResult; AStmt: POCIStmt);

    function GetHandle: TSDPtr; override;
    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;
    procedure SetAutoCommitOption(Value: Boolean); override;
    procedure SetHandle(AHandle: TSDPtr); override;

    property IsEnableInts: Boolean read FIsEnableInts;
    property IsXAConn: Boolean read FIsXAConn;
    property SvcPtr: POCISvcCtx  read GetSvcPtr;
    property SrvPtr: POCIServer  read GetSrvPtr;
    property UsrPtr: POCISession read GetUsrPtr;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;
    function CreateSqlCommand: TISqlCommand; override;

    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;

    function IsOra8BlobMode: Boolean;
    function IsOra8BlobType(ADataType: TFieldType): Boolean;
    function IsLocFieldSubType(ASubType: Word): Boolean;
    property EnvPtr: POCIEnv read GetEnvPtr;
    property ErrPtr: POCIError read GetErrPtr;
    property SessTimeZone: string read FSessTimeZone;
    property UseOCIDateTime: Boolean read FUseOCIDateTime;
    property TempLobSupported: Boolean read FTempLobSupported;
  end;

{ TIOra8Command }
  TOra8_get_cbf_get_long = function(cbf_stdcall: TOCICallbackDefine): Integer{TOCICallbackDefine};

  { TIOra8LobParams }
  TBindLobInfo = record
    phBind: POCIBind;
    ParamIdx: Integer;
  end;
  TBindLobArray	= array of TBindLobInfo;
  TBindLobRec = record
    EnvPtr: POCIEnv;
    ErrPtr: POCIError;
    ColCount,
    RowCount: Integer;
    BindInfoPtr: TSDPtr;
    LobLocPtr: TSDPtr;     // array of POCILobLocator
    LobLenPtr: ub4p;       // array of ub4 (this values have to be follow consecutively)
  end;

  TIOra8LobParams = class(TObject)
  private
    FBindLobPtr: TSDPtr;
    FExternalLobPtr: Boolean;
//    function GetAddrLobInfo(iRow, iCol: Integer): TSDPtr;
    function GetBindInfo(Index: Integer): TBindLobInfo;
    function GetEnvPtr: POCIEnv;
    function GetErrPtr: POCIError;
    function GetColCount: Integer;
    function GetRowCount: Integer;
    function GetBindInfoPtr: TSDPtr;
    function GetLobLocArrayPtr: TSDPtr;
    function GetLobLenArrayPtr: TSDPtr;
    procedure SetBindInfo(Index: Integer; Value: TBindLobInfo);
  public
    constructor Create(ASqlDatabase: TIOra8Database); overload;
    constructor Create(ABindLobPtr: TSDPtr); overload;
    destructor Destroy; override;
//    function GetAddrLobInfoLoc(iRow, iCol: Integer): TSDPtr;
    function GetAddrLobLen(iRow, iCol: Integer): TSDPtr;
    function GetLobLocator(iRow, iCol: Integer): POCILobLocator;
    procedure SetLobLocator(iRow, iCol: Integer; Value: POCILobLocator);
    procedure SetLobArraySize(ARows, ACols: Integer);
    property BindInfo[Index: Integer]: TBindLobInfo read GetBindInfo write SetBindInfo;
    property BindLobPtr: TSDPtr read FBindLobPtr;
    property EnvPtr: POCIEnv read GetEnvPtr;
    property ErrPtr: POCIError read GetErrPtr;
    property ColCount: Integer read GetColCount;
    property RowCount: Integer read GetRowCount;
  end;

  TIOra8Command = class(TISqlCommand)
  private
    FHandle: POCIStmt;
    FStmt: string;		// for Oracle8 it's need to save statement untill the statement will be executed or data will be fetched
    FParamHandle: POCIStmt;	// pointer to cursor, returned by PL/SQL procedure
    FBoundParams: Boolean;	// SpBindParams method was called
    FIsGetFieldDescs: Boolean;  // processing GetFieldDescs method
    FIsCursorParamExists: Boolean;
    FBindLobs: TIOra8LobParams;
    function GetErrPtr: POCIError;
    function GetSvcPtr: POCISvcCtx;
    function GetSqlDatabase: TIOra8Database;
    function GetStmtExecuteMode: ub4;
    function GetTempLobSupported: Boolean;
    procedure Connect;
    procedure CloseParamHandle;
    function IsFileLocDataType(ExtDataType: Integer): Boolean;
    function IsOra8BlobDataType(ExtDataType: Integer): Boolean;
    function IsOra8BlobType(ADataType: TFieldType): Boolean;
    function IsPLSQLBlock: Boolean;
    function IsSelectStmt: Boolean;
    procedure ClearFieldsExtraData;
    function IsInterval(FieldDesc: TSDFieldDesc): Boolean;
    function IsOra9DateTime(ExtDataType: Integer): Boolean;
    function GetOCIDateTimeDesc(ExtDataType: Integer): ub4;
    function Ora9CnvtDBDateTime2DateTimeRec(AFieldDesc: TSDFieldDesc; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;
    function Ora9CnvtDBInterval2Currency(AFieldDesc: TSDFieldDesc; Buffer: TSDCharPtr; BufSize: Integer): Currency;
    procedure SetOCIDateTime(FieldType: TFieldType; Value: TDateTime; phDateTime: POCIDateTime);
    procedure WriteLobParams;
    procedure InternalExecute;
    procedure InternalGetParams;
    procedure QBindParamsBuffer;
    procedure SpBindParamsBuffer;
  protected
    procedure Check(Status: TSDEResult);
    procedure CheckStmt(Status: TSDEResult);

    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    procedure DoPrepare(Value: string); override;
    procedure DoExecDirect(Value: string); override;
    procedure DoExecute; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    function GetHandle: PSDCursor; override;
    procedure InitParamList; override;
    procedure BindParamsBuffer; override;
    procedure FreeParamsBuffer; override;
    procedure FreeFieldsBuffer; override;
    procedure SetFieldsBuffer; override;

    function GetLobType(BlobType: TBlobType; IsTempLob: Boolean): Integer;
    function ReadHLobField(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
    function ReadLobData(phLob: POCILobLocator; var BlobData: TSDBlobData): Longint;
    function WriteLobData(phLob: POCILobLocator; const Buffer: TSDValueBuffer; Count: LongInt): Longint;

    property ErrPtr: POCIError read GetErrPtr;
    property SvcPtr: POCISvcCtx read GetSvcPtr;
    property TempLobSupported: Boolean read GetTempLobSupported;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    procedure Execute; override;
    function GetRowsAffected: Integer; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;
    function WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint; override;
    function WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint; override;

    property SqlDatabase: TIOra8Database read GetSqlDatabase;
  end;

const
	// Old library names: Oracle 7.0 - ORANT7.DLL; Oracle 7.1 - ORA7NT.DLL(for Win95), ORANT71.DLL
  DefSqlApiDLL	= 'ORACLIENT10.DLL;ORACLIENT9.DLL;ORACLIENT8.DLL;ORA805.DLL;ORA804.DLL;ORA803.DLL;OCI.DLL;ORA73.DLL;ORA72.DLL;OCIW32.DLL';
  DefOCI7DLL	= 'OCIW32.DLL';
  DefOCI8DLL	= 'OCI.DLL';

var
  SqlApiDLL: string;
{ Global variable for parameter binding to Oracle8 CLOB & BLOB field types.
  Set this to True before executing a query on that uses these types for parameters.
  Assign the data using TParam.AsMemo for CLOB and TParam.AsBlob for BLOB.
  Note you cannot mix CLOB/BLOB and RAW/LONG RAW in the binding of the same query. }
  Oracle8Blobs: Boolean;	// use as database parameter
  UsePiecewiseCalls: Boolean;	// LONG columns are processed by piecewise calls (bindps, definps, ogetpi, osetpi), which are possible in deferred mode and for Oracle Server 7.3 and later


{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
function LoadSqlLib(IsForceOCI7: Boolean): LongInt;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

{$IFDEF XSQL_CLR}

[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'obindps')]
function obindps(cursor: PCdaDef; opcode: ub1; sqlvar: PText;
	       	sqlvl: sb4; pvctx: dvoid; progvl: sb4; ftype, scale: sword;
	       	ind, alen, arcode: ub2p; pv_skip, ind_skip, alen_skip, rc_skip: sb4;
	       	maxsiz: ub4; cursiz: ub4p; fmt: PText; fmtl: sb4; fmtt: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'obreak')]
function obreak(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ocan')]
function ocan(cursor: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oclose')]
function oclose(cursor: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ocof')]
function ocof(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ocom')]
function ocom(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ocon')]
function ocon(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'odefinps')]
function odefinps(cursor: PCdaDef; opcode: ub1; pos: sword; bufctx: PText;
		bufl: sb4; ftype, scale: sword;	indp: sb2p;
              	fmt: PText; fmtl: sb4; fmtt: sword; rlen, rcode: ub2p;
		pv_skip, ind_skip, alen_skip, rc_skip: sb4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'odessp')]
function odessp(cursor: PCdaDef; objnam: PText; onlen: size_t;
            	rsv1: ub1p; rsv1ln: size_t; rsv2: ub1p; rsv2ln: size_t;
            	ovrld, pos, level: ub2p; text: PText;
            	arnlen, dtype: ub2p; defsup, mode: ub1p;
            	dtsiz: ub4p; prec, scale: sb2p; radix: ub1p;
            	spare: ub4p; var arrsiz: ub4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'odescr')]
function odescr(cursor: PCdaDef; pos: sword; var dbsize: sb4;
               	var dbtype: sb2; cbuf: PText; var cbufl, dsize: sb4;
               	var prec, scale, nullok: sb2): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oerhms')]
function oerhms(ldaptr: PLdaDef; rcode: sb2; buf: PText; bufsiz: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oermsg')]
function oermsg(rcode: sb2; buf: PText): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oexec')]
function oexec(cursor: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oexfet')]
function oexfet(cursor: PCdaDef; nrows: ub4; cancel, exact: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oexn')]
function oexn(cursor: PCdaDef; iters, rowoff: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ofen')]
function ofen(cursor: PCdaDef; nrows: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ofetch')]
function ofetch(cursor: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oflng')]
function oflng(cursor: PCdaDef; pos: sword; buf: PText;
               	bufl: sb4; dtype: sword; var retl: ub4; offset: sb4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ogetpi')]
function ogetpi(cursor: PCdaDef; var piece: ub1; var ctxp: dvoid; var iter, index: ub4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oopt')]
function oopt(cursor: PCdaDef; rbopt, waitopt: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'opinit')]
function opinit(mode: ub4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'olog')]
function olog(ldaptr: PLdaDef; hdaptr: PHdaDef; uid: PText; uidl: sword;
               	pswd: PText; pswdl: sword; conn: PText; connl: sword; mode: ub4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ologof')]
function ologof(ldaptr: PLdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oopen')]
function oopen(cursor: PCdaDef; ldaptr: PCdaDef; dbn: PText; dbnl, arsize: sword;
               	uid: PText; uidl: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'oparse')]
function oparse(cursor: PCdaDef; sqlstm: PText; sqllen: sb4; defflg: sword; lngflg: ub4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'orol')]
function orol(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'osetpi')]
function osetpi(cursor: PCdaDef; piece: ub1; bufp: dvoid; var len: ub4): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'onbset')]
function onbset(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'onbtst')]
function onbtst(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'onbclr')]
function onbclr(ldaptr: PCdaDef): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'obndra')]
function obndra(cursor: PCdaDef; sqlvar: PText; sqlvl: sword;
		progv: PText; progvl, ftype, scale: sword;
              	indp: sb2p; alen, arcode: ub2p; maxsiz: ub4;
              	cursiz: ub4p; fmt: PText; fmtl, fmtt: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'obndrn')]
function obndrn(cursor: PCdaDef; sqlvn: sword; progv: PText; progvl, ftype, scale: sword;
              	indp: sb2p; fmt: PText; fmtl, fmtt: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'obndrv')]
function obndrv(cursor: PCdaDef; sqlvar: PText; sqlvl: sword; progv: PText; progvl, ftype, scale: sword;
              	indp: sb2p; fmt: PText; fmtl, fmtt: sword): sword; external;
[DllImport(DefOCI7DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'odefin')]
function odefin(cursor: PCdaDef; pos: sword; buf: PText; bufl, ftype, scale: sword; indp: sb2p;
              	fmt: PText; fmtl, fmtt: sword; rlen, rcode: ub2p): sword; external;

// ================================ OCI8 function =======================================================

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIInitialize')]
function OCIInitialize(mode: ub4; ctxp: Pdvoid;
      	malocfp: Tmalocfp; ralocfp: Tralocfp; mfreefp: Tmfreefp): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITerminate')]
function OCITerminate(mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIHandleAlloc')]
function OCIHandleAlloc(const phParenEnv: Pdvoid; var hndlp: Pdvoid; htype: ub4;
      	xtramem_sz: size_t; usrmemp: PPdvoid): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIHandleFree')]
function OCIHandleFree(hndlp: Pdvoid; htype: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDescriptorAlloc')]
function OCIDescriptorAlloc(const phParenEnv: Pdvoid; var descp: Pdvoid; htype: ub4;
      	xtramem_sz: size_t; usrmemp: PPdvoid): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDescriptorFree')]
function OCIDescriptorFree(descp: Pdvoid; htype: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIEnvCreate')]
function OCIEnvCreate(var phEnv: POCIEnv; mode: ub4; ctxp: Pdvoid;
      	malocfp: Tmalocfp; ralocfp: Tralocfp; mfreefp: Tmfreefp;
              xtramem_sz: size_t; usrmemp: Pdvoid): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIEnvInit')]
function OCIEnvInit(var phEnv: POCIEnv; mode: ub4;
      	xtramem_sz: size_t; usrmemp: Pdvoid): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIServerAttach')]
function OCIServerAttach(phSrv: POCIServer; phError: POCIError;
      	const dblink: TSDCharPtr; dblink_len: sb4; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIServerDetach')]
function OCIServerDetach(phSrv: POCIServer; phError: POCIError; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCISessionBegin')]
function OCISessionBegin(phSvc: POCISvcCtx; phError: POCIError;
      	phUsr: POCISession; credt, mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCISessionEnd')]
function OCISessionEnd(phSvc: POCISvcCtx; phError: POCIError;
      	phUsr: POCISession; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILogon')]
function OCILogon(phEnv: POCIEnv; phError: POCIError; var svchp: POCISvcCtx;
      	const username: TSDCharPtr; uname_len: ub4; const password: TSDCharPtr; passwd_len: ub4;
        const dbname: TSDCharPtr; dbname_len: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILogoff')]
function OCILogoff(phSvc: POCISvcCtx; phError: POCIError): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIPasswordChange')]
function OCIPasswordChange(phSvc: POCISvcCtx; phError: POCIError;
      	const user_name: TSDCharPtr; usernm_len: ub4; const opasswd: TSDCharPtr; opasswd_len: ub4;
        const npasswd: TSDCharPtr; npasswd_len, mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIStmtPrepare')]
function OCIStmtPrepare(phStmt: POCIStmt; phError: POCIError;
      	const stmt: TSDCharPtr; stmt_len, language, mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIBindByPos')]
function OCIBindByPos(phStmt: POCIStmt; var phBind: POCIBind; phError: POCIError;
      	position: ub4; valuep: Pdvoid; value_sz: sb4; dty: ub2; indp: Pdvoid;
        alenp, rcodep: ub2p; maxarr_len: ub4; curelep: ub4p; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIBindByName')]
function OCIBindByName(phStmt: POCIStmt; var phBind: POCIBind; phError: POCIError;
      	const placeholder: TSDCharPtr; placeh_len: sb4; valuep: Pdvoid; value_sz: sb4; dty: ub2; indp: Pdvoid;
        alenp, rcodep: ub2p; maxarr_len: ub4; curelep: ub4p; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIBindDynamic')]
function OCIBindDynamic(phBind: POCIBind; phError: POCIError;
      	ictxp: Pdvoid; icbfp: TOCICallbackInBind;
        octxp: Pdvoid; ocbfp: TOCICallbackOutBind): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIBindArrayOfStruct')]
function OCIBindArrayOfStruct(phBind: POCIBind; phError: POCIError;
      	pvskip, indskip, alskip, rcskip: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIStmtGetPieceInfo')]
function OCIStmtGetPieceInfo(phStmt: POCIStmt; phError: POCIError; var hndlp: Pdvoid; var htype: ub4;
      	var in_out: ub1; var iter, idx: ub4; var piece: ub1): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIStmtSetPieceInfo')]
function OCIStmtSetPieceInfo(hndlp: Pdvoid; HandleType: ub4; phError: POCIError;
      	const bufp: dvoid; var alen: ub4; piece: ub1;
        var ind: sb2; rcodep: ub2p): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIStmtExecute')]
function OCIStmtExecute(phSvc: POCISvcCtx; phStmt: POCIStmt; phError: POCIError; iters, rowoff: ub4;
      	const snap_in: POCISnapshot; snap_out: POCISnapshot; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDefineByPos')]
function OCIDefineByPos(phStmt: POCIStmt; var phDefine: POCIDefine; phError: POCIError;
	position: ub4; pValue: dvoid; value_sz: sb4; dty: ub2;
        indp: Pdvoid; rlenp, rcodep: ub2p; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDefineDynamic')]
function OCIDefineDynamic(phDefine: POCIDefine; phError: POCIError;
      	octxp: Pdvoid; ocbfp: TOCICallbackDefine): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDefineArrayOfStruct')]
function OCIDefineArrayOfStruct(phDefine: POCIDefine; phError: POCIError;
      	pvskip, indskip, rlskip, rcskip: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIStmtFetch')]
function OCIStmtFetch(phStmt: POCIStmt; phError: POCIError;
      	nrows: ub4; orientation: ub2; mode: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIStmtGetBindInfo')]
function OCIStmtGetBindInfo(phStmt: POCIStmt; phError: POCIError;
      	size, startloc: ub4; found: sb4p; arr_bvn: PPChar; arr_bvnl: ub1p;
        arr_inv: PPChar; arr_inpl, arr_dupl: ub1p; arr_hndl: PPOCIBind): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDescribeAny')]
function OCIDescribeAny(phSvc: POCISvcCtx; phError: POCIError;
      	objptr: Pdvoid;	objnm_len: ub4; objptr_typ, info_level, objtyp: ub1;
        phDsc: POCIDescribe): sword; external;

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIParamGet')]
function OCIParamGet(const pHndl: Pdvoid; htype: ub4; phError: POCIError;
      	var pParmd: Pdvoid; pos: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIParamSet')]
function OCIParamSet(pHdl: Pdvoid; htyp: ub4; phError: POCIError;
      	const pDsc: Pdvoid; dtyp, pos: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITransStart')]
function OCITransStart(phSvc: POCISvcCtx; phError: POCIError; timeout: uword; flags: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITransDetach')]
function OCITransDetach(phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITransCommit')]
function OCITransCommit(phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITransRollback')]
function OCITransRollback(phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITransPrepare')]
function OCITransPrepare(phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCITransForget')]
function OCITransForget(phSvc: POCISvcCtx; phError: POCIError; flags: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIErrorGet')]
function OCIErrorGet(pHndl: Pdvoid; RecordNo: ub4; SqlState: TSDCharPtr;
      	var ErrCode: sb4; buf: TSDCharPtr; bufsiz, typ: ub4): sword; external;

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobCreateTemporary')]
function OCILobCreateTemporary(phSvc: POCISvcCtx; phError: POCIError;
                locp: POCILobLocator; csid: ub2; csfrm, lobtype: ub1;
                cache: OraBoolean; duration: OCIDuration): sword; external;

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileClose')]
function OCILobFileClose(phSvc: POCISvcCtx; phError: POCIError; filep: POCILobLocator): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileCloseAll')]
function OCILobFileCloseAll(phSvc: POCISvcCtx; phError: POCIError): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileExists')]
function OCILobFileExists(phSvc: POCISvcCtx; phError: POCIError;
      	filep: POCILobLocator; var flag: OraBoolean): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileGetName')]
function OCILobFileGetName(phEnv: POCIEnv; phError: POCIError;
      	const filep: POCILobLocator; dir_alias: TSDCharPtr; d_length: ub2p;
              filename: TSDCharPtr; f_length: ub2p): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileIsOpen')]
function OCILobFileIsOpen(phSvc: POCISvcCtx; phError: POCIError;
      	filep: POCILobLocator; var flag: OraBoolean): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileOpen')]
function OCILobFileOpen(phSvc: POCISvcCtx; phError: POCIError;
      	filep: POCILobLocator; mode: ub1): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFileSetName')]
function OCILobFileSetName(phEnv: POCIEnv; phError: POCIError;
      	var filep: POCILobLocator; const dir_alias: TSDCharPtr; d_length: ub2;
              const filename: TSDCharPtr; f_length: ub2): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFlushBuffer')]
function OCILobFlushBuffer(phSvc: POCISvcCtx; phError: POCIError;
      	locp: POCILobLocator; flag: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobFreeTemporary')]
function OCILobFreeTemporary(phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobGetLength')]
function OCILobGetLength(phSvc: POCISvcCtx; phError: POCIError;
      	locp: POCILobLocator; var len: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobIsEqual')]
function OCILobIsEqual(phEnv: POCIEnv;
      	const x, y: POCILobLocator; var is_equal: OraBoolean): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobLoadFromFile')]
function OCILobLoadFromFile(phSvc: POCISvcCtx; phError: POCIError;
      	dst_locp, src_filep: POCILobLocator;
              amount, dst_offset, src_offset: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobLocatorIsInit')]
function OCILobLocatorIsInit(phEnv: POCIEnv; phError: POCIError;
      	const locp: POCILobLocator; var is_initialized: OraBoolean): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobRead')]
function OCILobRead(phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator;
      	var amt: ub4; offset: ub4; bufp: dvoid; bufl: ub4;
              ctxp: Pdvoid; cbfp: TCBLobRead; csid: ub2; csfrm: ub1): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobTrim')]
function OCILobTrim(phSvc: POCISvcCtx; phError: POCIError;
      	locp: POCILobLocator; newlen: ub4): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILobWrite')]
function OCILobWrite(phSvc: POCISvcCtx; phError: POCIError; locp: POCILobLocator;
      	var amt: ub4; offset: ub4; bufp: dvoid; buflen: ub4; piece: ub1;
              ctxp: Pdvoid; cbfp: TCBLobWrite; csid: ub2; csfrm: ub1): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIBreak')]
function OCIBreak(pHndl: Pdvoid; phError: POCIError): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIServerVersion')]
function OCIServerVersion(pHndl: Pdvoid; phError: POCIError;
      	buf: TSDCharPtr; bufsz: ub4; hndltype: ub1): sword; external;

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrGet')]
function OCIAttrGet(const trgthndlp: Pdvoid; trghndltyp: ub4;
        	attributep: dvoid; sizep: ub4p; attrtype: ub4; phError: POCIError): sword; external; overload;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrGet')]
function OCIAttrGet(const trgthndlp: Pdvoid; trghndltyp: ub4;
        	var attribute: sb4; sizep: ub4p; attrtype: ub4; phError: POCIError): sword; external; overload;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrGet')]
function OCIAttrGet(const trgthndlp: Pdvoid; trghndltyp: ub4;
        	var attribute: ub2; sizep: ub4p; attrtype: ub4; phError: POCIError): sword; external; overload;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrGet')]
function OCIAttrGet(const trgthndlp: Pdvoid; trghndltyp: ub4;
        	var attribute: ub1; sizep: ub4p; attrtype: ub4; phError: POCIError): sword; external; overload;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrGet')]
function OCIAttrGet(const trgthndlp: Pdvoid; trghndltyp: ub4;
        	var attribute: sb1; sizep: ub4p; attrtype: ub4; phError: POCIError): sword; external; overload;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrGet')]
function OCIAttrGet(const trgthndlp: Pdvoid; trghndltyp: ub4;
        	var attribute: TSDCharPtr; var size: ub4; attrtype: ub4; phError: POCIError): sword; external; overload;

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrSet')]
function OCIAttrSet(trgthndlp: Pdvoid; trghndltyp: ub4;
        	attributep: dvoid; size, attrtype: ub4; phError: POCIError): sword; external; overload;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIAttrSet')]
function OCIAttrSet(trgthndlp: Pdvoid; trghndltyp: ub4;
        	var attribute: ub4; size, attrtype: ub4; phError: POCIError): sword; external; overload;

[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCISvcCtxToLda')]
function OCISvcCtxToLda(phSvc: POCISvcCtx; phError: POCIError; ldap: PLdaDef): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCILdaToSvcCtx')]
function OCILdaToSvcCtx(var phSvc: POCISvcCtx; phError: POCIError; ldap: PLdaDef): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIResultSetToStmt')]
function OCIResultSetToStmt(phRset: POCIResult; phError: POCIError): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'xaoEnv')]
function xaoEnv(dbname: TSDCharPtr): POCIEnv; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'xaoSvcCtx')]
function xaoSvcCtx(dbname: TSDCharPtr): POCISvcCtx; external;
	// Oracle9i functons
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDateTimeConstruct')]
function OCIDateTimeConstruct(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
		year: sb2; month, day, hour, min, sec: ub1; fsec: ub4;
             	timezone: POraText; timezone_length: size_t):sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDateTimeGetDate')]
function OCIDateTimeGetDate(pHndl: Pdvoid; phError: POCIError;  date: POCIDateTime;
	        var year: sb2; var month, day: ub1):sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDateTimeGetTime')]
function OCIDateTimeGetTime(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
	 	var hour, minute, sec: ub1; var fsec: ub4):sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDateTimeGetTimeZoneName')]
function OCIDateTimeGetTimeZoneName(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
                buf: ub1p; buflen: ub4p):sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIDateTimeGetTimeZoneOffset')]
function OCIDateTimeGetTimeZoneOffset(pHndl: Pdvoid; phError: POCIError; datetime: POCIDateTime;
            	var hour, minute: sb1):sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIIntervalSetYearMonth')]
function OCIIntervalSetYearMonth(pHndl: Pdvoid; phError: POCIError;
              yr, mnth: sb4; result: POCIInterval): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIIntervalGetYearMonth')]
function OCIIntervalGetYearMonth(pHndl: Pdvoid; phError: POCIError;
              var  yr, mnth: sb4; const result: POCIInterval): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIIntervalSetDaySecond')]
function OCIIntervalSetDaySecond(pHndl: Pdvoid; phError: POCIError;
              dy, hr, mm, ss, fsec: sb4; result: POCIInterval): sword; external;
[DllImport(DefOCI8DLL, CallingConvention = CallingConvention.cdecl, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'OCIIntervalGetDaySecond')]
function OCIIntervalGetDaySecond(pHndl: Pdvoid; phError: POCIError;
              var dy, hr, mm, ss, fsec: sb4; const result: POCIInterval): sword; external;


        // it is necessary to convert stdcall callback to cdecl callback function, which is not supported by Delphi 8
[DllImport(CLRHelperDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'Ora8HelperBindDynamic')]
function Ora8HelperBindDynamic(const hLib: HModule; phBind: POCIBind; phError: POCIError;
      	ictxp: Pdvoid; icbfp: TOCICallbackInBind;
        octxp: Pdvoid; ocbfp: TOCICallbackOutBind): sword; external;
[DllImport(CLRHelperDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'Ora8HelperDefineDynamic')]
function Ora8HelperDefineDynamic(const hLib: HModule; phDefine: POCIDefine; phError: POCIError;
      	octxp: Pdvoid; ocbfp: TOCICallbackDefine): sword; external;

{$ENDIF}

implementation

const
  SqlApiDLLSep	= ';';	// delimiters of API-library names
  QuoteChar	= '"';	// for surroundings of the parameter's name, which can include, for example, spaces

  SDummySelect = 'select 0 from DUAL';

  UnknownOCI	= 0;	// unknown OCI-version

const
  ParamPrefix	= ':';
  ZS	= #$00;
  CR	= #$0D;
  LF	= #$0A;
  SP	= #$20;

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrFuncNotFound	= 'Function ''%s'' not found in OCI library';
  SErrInvalidHandle	= 'Invalid OCI handle';

const
  SQueryOraServerVersion=
  	'select VERSION from PRODUCT_COMPONENT_VERSION where PRODUCT like ''%Oracle%''';
  SQueryOraVersionString=
    	'select PRODUCT || '' Release '' || VERSION || '' - '' || STATUS '+
    	'from PRODUCT_COMPONENT_VERSION where PRODUCT like ''%Oracle%''';

  SSelectStartCatSchNames =
{$IFNDEF XSQL_VCL5}             // TStringField in Delphi 4 does not support size 0 ('Invalid field size' error hapens)
  	'select '' '' as '+CAT_NAME_FIELD+', OWNER as '+SCH_NAME_FIELD;
{$ELSE}
  	'select '''' as '+CAT_NAME_FIELD+', OWNER as '+SCH_NAME_FIELD;
{$ENDIF}

  SQueryOraStoredProcNamesFmt 	=
  	SSelectStartCatSchNames +
        ', OBJECT_NAME as '+PROC_NAME_FIELD+
	', DECODE(OWNER, ''SYS'', 8, 0) + DECODE(OBJECT_TYPE, ''PROCEDURE'', 1, ''FUNCTION'', 2, 0) as '+PROC_TYPE_FIELD+
        ' from SYS.ALL_OBJECTS ' +
	'where OBJECT_TYPE in (''PROCEDURE'', ''FUNCTION'') %s order by OWNER, OBJECT_NAME';

  SQueryOraTableNamesFmt	=
  	SSelectStartCatSchNames +
        ', OBJECT_NAME as '+TBL_NAME_FIELD+
        ', DECODE(OWNER, ''SYS'', 4, 0) + DECODE(OBJECT_TYPE, ''TABLE'', 1, ''VIEW'', 2, 0) as '+TBL_TYPE_FIELD+
        ' from SYS.ALL_OBJECTS ' +
	'where OBJECT_TYPE in (''TABLE'', ''VIEW'') %s order by OWNER, OBJECT_NAME';

  SQueryOraTableFieldNamesFmt =
  	SSelectStartCatSchNames +
        ', TABLE_NAME as '+TBL_NAME_FIELD+', COLUMN_NAME as '+COL_NAME_FIELD+
        ', COLUMN_ID as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', DATA_TYPE as '+COL_TYPENAME_FIELD+', DATA_LENGTH as '+COL_LENGTH_FIELD+
        ', DATA_PRECISION as '+COL_PREC_FIELD+', DATA_SCALE as '+COL_SCALE_FIELD+
        ', DECODE(NULLABLE, ''Y'', 1, 0) as '+COL_NULLABLE_FIELD+
        ', DATA_DEFAULT'+
        ' from SYS.ALL_TAB_COLUMNS ' +
	'where UPPER(OWNER) like UPPER(''%s'') and UPPER(TABLE_NAME) like UPPER(''%s'') '+
        'order by OWNER, TABLE_NAME, COLUMN_ID';

  SQueryOraIndexNamesFmt =
{$IFNDEF XSQL_VCL5}             // TStringField in Delphi 4 does not support size 0 ('Invalid field size' error hapens)
  	'select '' '' as '+CAT_NAME_FIELD+', IND.OWNER as '+SCH_NAME_FIELD+
{$ELSE}
  	'select '''' as '+CAT_NAME_FIELD+', IND.OWNER as '+SCH_NAME_FIELD+
{$ENDIF}
        ', IND.TABLE_NAME as '+TBL_NAME_FIELD+', IND.INDEX_NAME as '+IDX_NAME_FIELD+
	', COLUMN_NAME as '+IDX_COL_NAME_FIELD+', COLUMN_POSITION as '+IDX_COL_POS_FIELD+
        ', DECODE(IND.UNIQUENESS, ''UNIQUE'', 2, 1) as '+IDX_TYPE_FIELD+
{$IFNDEF XSQL_VCL5}
        ', '' '' as '+IDX_PKEY_NAME_FIELD+', '' '' as '+IDX_SORT_FIELD+', '' '' as '+IDX_FILTER_FIELD+
{$ELSE}
        ', '''' as '+IDX_PKEY_NAME_FIELD+', '''' as '+IDX_SORT_FIELD+', '''' as '+IDX_FILTER_FIELD+
{$ENDIF}
	' from ALL_INDEXES IND, ALL_IND_COLUMNS INDC '+
	'where IND.OWNER = INDC.INDEX_OWNER '+
        '  and IND.INDEX_NAME = INDC.INDEX_NAME '+
        '  and IND.TABLE_NAME = INDC.TABLE_NAME '+
        '  and IND.TABLE_OWNER = INDC.TABLE_OWNER '+
	'  and UPPER(IND.TABLE_OWNER) like UPPER(''%s'') '+
        '  and UPPER(IND.TABLE_NAME) like UPPER(''%s'') '+
{$IFNDEF XSQL_VCL5}
	' union select '' '', CT.OWNER, CT.TABLE_NAME, CT.CONSTRAINT_NAME'+
	', CC.COLUMN_NAME, CC.POSITION, 4, CT.CONSTRAINT_NAME, '' '', '' '' '+
{$ELSE}
	' union select '''', CT.OWNER, CT.TABLE_NAME, CT.CONSTRAINT_NAME'+
	', CC.COLUMN_NAME, CC.POSITION, 4, CT.CONSTRAINT_NAME, '''', '''' '+
{$ENDIF}
	'from ALL_CONSTRAINTS CT, ALL_CONS_COLUMNS CC '+
	'where CT.CONSTRAINT_NAME = CC.CONSTRAINT_NAME '+
        '  and CT.TABLE_NAME        = CC.TABLE_NAME '+
        '  and CT.OWNER             = CC.OWNER '+
        '  and CONSTRAINT_TYPE = ''P'' '+
        '  and UPPER(CT.OWNER) like UPPER(''%s'') '+
        '  and UPPER(CT.TABLE_NAME) like UPPER(''%s'') '+
	'order by 7 desc, 2, 3, 4, 6';

var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;

  dwLoadedOCI: LongInt;		// version of the loaded OCI-library (HiWord-Major, LoWord-Monor)

  bDetectedOCI72: Boolean;
  bDetectedOCI73: Boolean;

procedure InitOCI7; forward;
procedure DoneOCI7; forward;

procedure InitOCI8; forward;
procedure DoneOCI8; forward;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  CliVer: LongInt;
  bForceOCI7: Boolean;
  s: string;
begin
  bForceOCI7 := UpperCase( Trim( ADbParams.Values[szFORCEOCI7] ) ) = STrueString;

  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istOracle) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  CliVer := LoadSqlLib(bForceOCI7);	// it's not necessary to call FreeSqlLib, which called in an unit finalization part
  if (not bForceOCI7) and (GetMajorVer(CliVer) >= 8) then
    Result := TIOra8Database.Create( ADbParams )
  else
    Result := TIOraDatabase.Create( ADbParams );
end;

procedure OraErrorOCI7(LdaPtr: PLdaDef; rcode: sb2; peo: LongInt);
var
  E: ESDOraError;
  szMsg: TSDCharPtr;
  sMsg: string;
begin
  if rcode = 0 then
    Exit;
  szMsg := SafeReallocMem( nil, MAXERRMSG );
  try
    oerhms( LdaPtr, rcode, szMsg, MAXERRMSG);
    sMsg := HelperPtrToString( szMsg );
  finally
    SafeReallocMem( szMsg, 0 );
  end;
  E := ESDOraError.Create(rcode, rcode, sMsg, peo);
  raise E;
end;

procedure OraErrorOCI8( AErrHandle: POCIError; rcode: TSDEResult;  AStmt: POCIStmt );
var
  E: ESDOraError;
  szMsg: TSDCharPtr;
  sMsg: string;
  ErrCode, ErrOffset: Integer;
  peo: sb4;
begin
  case rcode of
    OCI_INVALID_HANDLE:
      begin
        sMsg := SErrInvalidHandle;
        ErrCode := rcode;
      end
{	implement, when it will be necessary
    OCI_STILL_EXECUTE:
    OCI_CONTINUE: 	}
  else
    szMsg := SafeReallocMem( nil, MAXERRMSG );
    try
      if Assigned( AErrHandle ) then
        OCIErrorGet( Pdvoid(AErrHandle), 1, nil, ErrCode, szMsg, MAXERRMSG, OCI_HTYPE_ERROR )
      else
        OCIErrorGet( Pdvoid(AErrHandle), 1, nil, ErrCode, szMsg, MAXERRMSG, OCI_HTYPE_ENV );
      sMsg := HelperPtrToString( szMsg );
    finally
      SafeReallocMem( szMsg, 0 );
    end;
  end;

  ErrOffset := -1;
  peo := 0;
  if (AStmt <> nil) and
     (OCIAttrGet( Pdvoid(AStmt), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}peo, nil, OCI_ATTR_PARSE_ERROR_OFFSET, AErrHandle ) = OCI_SUCCESS)
  then
    ErrOffset := peo;

  E := ESDOraError.Create(ErrCode, ErrCode, sMsg, ErrOffset);
  raise E;
end;

function OCI8ErrorCode( AErrHandle: POCIError; rcode: TSDEResult): Integer;
var
  szMsg: TSDCharPtr;
  ErrCode: Integer;
begin
  case rcode of
    OCI_INVALID_HANDLE:
      begin
        ErrCode := rcode;
      end
{	implement, when it will be necessary
    OCI_STILL_EXECUTE:
    OCI_CONTINUE: 	}
  else
    szMsg := SafeReallocMem( nil, MAXERRMSG );
    try
      if Assigned( AErrHandle ) then
        OCIErrorGet( Pdvoid(AErrHandle), 1, nil, ErrCode, szMsg, MAXERRMSG, OCI_HTYPE_ERROR )
      else
        OCIErrorGet( Pdvoid(AErrHandle), 1, nil, ErrCode, szMsg, MAXERRMSG, OCI_HTYPE_ENV );
    finally
      SafeReallocMem( szMsg, 0 );
    end;
  end;

  Result := ErrCode;
end;

procedure Ora8Check(Status: TSDEResult; AErrPtr: POCIError);
begin
  if (Status = OCI_SUCCESS) or (Status = OCI_SUCCESS_WITH_INFO) then
    Exit;
//  ResetBusyState;

  OraErrorOCI8( AErrPtr, Status, nil );
end;

function IsAvailFunc(AName: string): Boolean;
begin
  Result := Assigned( GetProcAddress(hSqlLibModule, {$IFDEF XSQL_CLR}AName{$ELSE}PChar(AName){$ENDIF}) );
end;

function DetectedOCI72: Boolean;
begin
  Result := bDetectedOCI72;
end;

function DetectedOCI73: Boolean;
begin
  Result := bDetectedOCI73;
end;

{ Check whether procedure pointers are assigned, i.e. InitOCI7/InitOCI8 was called.
In Delphi 8 the vale is not assigned, when a librari is not available  }
function IsLoadedOCI7: Boolean;
begin
  Result := {$IFDEF XSQL_CLR} False {$ELSE} @oexec <> nil {$ENDIF};
end;

function IsLoadedOCI8: Boolean;
begin
  Result := {$IFDEF XSQL_CLR} False {$ELSE} @OCIStmtExecute <> nil {$ENDIF};
end;

// For example:	name/password@service_name, if password is empty, then OS authentication is used (username is ignored)
function CreateConnectString(const sDatabase, sUserName, sPassword: string): string;
begin
  if Length(sPassword) > 0 then begin
    if Length(sUserName) > 0 then
      Result := Trim(sUserName);
    Result := Result + '/' + Trim(sPassword);
  end;
  if Length(sDatabase) > 0 then
    Result := Result + '@' + Trim(sDatabase);
end;

function CreateCursorString(const sDatabase, sUserName, sPassword: string): string;
begin
  if Length(sUserName) > 0 then
    Result := Trim(sUserName);
  if Length(sPassword) > 0 then
    Result := Result + '/' + Trim(sPassword);
end;

{ remove invalid symbols from statement
and change parameter's name from Params[i].Name to number (:i+1), for example :p1 -> :1
to exclude problem with incorrect symbols, for example, quoted cyrilic names }
function MakeValidStatement( AStmt: string; Params: TSDHelperParams ): string;
var
  i, ParamPos: Integer;
  sStmt, sFullParamName: string;
begin
  sStmt := AStmt;
	// remove the symbols #$00, #$0A, #$0D in the end of statement
  for i:=Length(sStmt) downto 1 do
    if AnsiChar( sStmt[i] ) in [ZS, LF, CR]
    then sStmt[i] := ZS
    else Break;
	// remove CR(#$0D). It's necessary for PL/SQL blocks (error: PLS-00103) (for example: begin <CRLF> NULL; <CRLF> end;)
  i := 1;
  while i <= Length(sStmt) do begin
    if AnsiChar( sStmt[i] ) in [CR] then
      Delete(sStmt, i, 1)
    else
      Inc(i);
  end;
	// change parameter's name from Params[i].Name to number (:i+1), for example :p1 -> :1
  if Assigned(Params) then
    for i:=0 to Params.Count-1 do begin
      sFullParamName := ParamPrefix + Params[i].Name;
      ParamPos := LocateText( sFullParamName, sStmt );
      	// if parameter's name is quoted
      if ParamPos = 0 then begin
        sFullParamName := ParamPrefix + QuoteChar + Params[i].Name + QuoteChar;
        ParamPos := LocateText( sFullParamName, sStmt );
        if ParamPos = 0 then
          Continue;
      end;
      	// change, for example, :Param1 -> :1
      Delete( sStmt, ParamPos, Length(sFullParamName) );
      Insert( ParamPrefix + IntToStr(i+1), sStmt, ParamPos );
    end;

  Result := sStmt;
end;

{ Create PL/SQL block for processing of a stored procedure. Parameter's names are used in the call block }
function MakeStoredProcStmt( AProcName: string; Params: TSDHelperParams ): string;
var
  i: Integer;
  sParams, sResult: string;
begin
  sResult := '';
  sParams := '';
    	// add parameters
  if Assigned(Params) then for i:=0 to Params.Count-1 do begin
	// if this stored function
    if Params[i].ParamType = ptResult then begin
      sResult := Format(':%s := ', [Params[i].Name]);
      Continue;
    end;
    if Length(sParams) > 0 then
      sParams := sParams + ', ';
    sParams := sParams + Format('%s => :%0:s', [UpperCase(Params[i].Name)]);
  end;
	// if parameters of stored procedure exists, that adding '('
  if Length(sParams) > 0 then
    sParams := '(' + sParams + ')';

	// for example, 'begin :Result = TESTPROC(P1 => :P1, P2 => :P2); end;'
        // 		or 'begin :Result = TESTPROC(:P1, :P2); end;'
  Result := Format('begin %s%s %s; end;', [sResult, UpperCase(AProcName), sParams]);
end;

{ Returns a real length of string data (GetDataSize includes '\0' symbol)
It is not necessery to include '\0' for long data }
function RealParamDataSize(AParam: TSDHelperParam): Integer;
begin
  Result := AParam.GetDataSize;
  if AParam.DataType in [ftString {$IFDEF XSQL_VCL4}, ftFixedChar {$ENDIF}, ftMemo] then
    Dec(Result);
end;


// for OCI8 callback functions
var
  DummyNullIndPtr: sb2p;
  LongPieceSize: Integer = DEF_BLOB_PIECE_SIZE;

type
{$IFDEF XSQL_CLR}
  PLobInfo	= dvoid;
  PLobArray	= dvoid;
  PBindLobArray	= dvoid;
  POutLocStruct = dvoid;
  PGetLongContext=dvoid;
{$ELSE}
  PBindLobArray	= ^TBindLobArray;
  POutLocStruct = ^TIOra8LobParams;
  PGetLongContext=^TGetLongContext;
{$ENDIF}


	// used in callback function to get LONG data
{$IFDEF XSQL_CLR}
  [StructLayout(LayoutKind.Sequential)]
{$ENDIF}
  TGetLongContext = packed record
    Data: TSDCharPtr;   // TSDBlobData type was used before v.4
    DataSize: Integer;
    PieceSize: Integer;
    Ind: Integer;
  end;

{ IN-bind callback function, which provides nothing }
function cbf_no_data(ictxp: Pdvoid; phBind: POCIBind; iter, index: ub4;
  		bufpp: PPdvoid; alenp: ub4p; piecep: ub1p; indpp: PPdvoid): sb4; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
begin
{$IFDEF XSQL_CLR}
  HelperMemWritePtr( bufpp, 0, nil );
  HelperMemWriteInt32( alenp, 0, 0 );
  HelperMemWriteInt16( DummyNullIndPtr, 0, OCI_IND_NULL );
  HelperMemWritePtr( indpp, 0, DummyNullIndPtr );
  HelperMemWriteByte( piecep, 0, OCI_ONE_PIECE );
{$ELSE}
  bufpp^	:= nil;
  alenp^	:= 0;
  DummyNullIndPtr^:= OCI_IND_NULL;
  sb2p(indpp^)	:= DummyNullIndPtr;
  piecep^ 	:= OCI_ONE_PIECE;
{$ENDIF}
  Result := OCI_CONTINUE;
end;

{ OUT-bind callback function, which provides buffers for LOB locators. Returned
 LOB-locators are used to modify BLOB/CLOB data in TIOra8Command.WriteLobParams.
 It's necessary to bind a DML statement with RETURNING clause }
function cbf_out_lob_loc(octxp: Pdvoid; phBind: POCIBind; iter, index: ub4;
        	bufpp: PPdvoid; alenpp: ub4pp; piecep: ub1p;
                indpp: PPdvoid; rcodepp: ub2pp): sb4; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
var
  RetRows: ub4;
  i, ParamNo: Integer;
  OutLobs: TIOra8LobParams;
  phLoc: POCILobLocator;
begin
  OutLobs := TIOra8LobParams.Create(octxp);
  try
  if index = 0 then begin
    Ora8Check( OCIAttrGet( Pdvoid(phBind), OCI_HTYPE_BIND, {$IFNDEF XSQL_CLR}@{$ENDIF}RetRows, nil,
                        OCI_ATTR_ROWS_RETURNED, OutLobs.ErrPtr), OutLobs.ErrPtr );
        // set number rows in array
    OutLobs.SetLobArraySize( RetRows, OutLobs.ColCount );
  end;

  ParamNo := -1;
  for i:=0 to  OutLobs.ColCount-1 do
    if OutLobs.BindInfo[i].phBind = phBind then begin
      ParamNo := i;
      Break;
    end;
  ASSERT( ParamNo >= 0 );

  phLoc := OutLobs.GetLobLocator(index, ParamNo);
  HelperMemWritePtr( bufpp, 0, dvoid( phLoc ) );
      // Note: alenpp^^ will be set in a value 86($56) for any blob value after the callback will be ended (Oracle 8.x, when temporary LOBs are not used). The reason is unknown.  
  HelperMemWritePtr( alenpp, 0, OutLobs.GetAddrLobLen( index, ParamNo ) );

  HelperMemWriteByte( piecep, 0, OCI_ONE_PIECE );
  Result := OCI_CONTINUE;

  finally
    OutLobs.Free;
  end;
end;

{ Define callback function to get(SELECT) LONG data. octxp is a pointer to TFieldInfo.
 Data is stored in LongCtxPtr^.Data buffer. }
function cbf_get_long(octxp: Pdvoid; phDefn: POCIDefine; iter: ub4;
        	bufpp: PPdvoid; alenpp: ub4pp; piecep: ub1p;
                indpp: PPdvoid; rcodepp: ub2pp): sb4; {$IFNDEF XSQL_CLR}cdecl;{$ENDIF}
var
  FldInfo: TSDFieldInfo;
  LongCtx: TGetLongContext;
  LongCtxPtr: PGetLongContext;
  piece: ub1;
begin
  FldInfo := GetFieldInfoStruct( octxp, 0 );
  LongCtxPtr := TSDPtr( FldInfo.FetchStatus );

  piece := HelperMemReadByte( piecep, 0 );
  ASSERT( piece in [OCI_ONE_PIECE, OCI_FIRST_PIECE, OCI_NEXT_PIECE] );
{$IFDEF XSQL_CLR}
  LongCtx := TGetLongContext( Marshal.PtrToStructure( LongCtxPtr, TypeOf(TGetLongContext) ) );
{$ELSE}
  LongCtx := TGetLongContext( LongCtxPtr^ );
{$ENDIF}
  if piece in [OCI_ONE_PIECE, OCI_FIRST_PIECE] then begin
    LongCtx.Data := nil;
    LongCtx.DataSize  := 0;
    LongCtx.PieceSize := 0;
    LongCtx.Ind := 0;
    HelperMemWriteByte( piecep, 0, OCI_FIRST_PIECE );
  end;
	// how much data was read: alenpp^^ = pCtxLong^.PieceSize
  Inc( LongCtx.DataSize, LongCtx.PieceSize );
  LongCtx.PieceSize := LongPieceSize;
  LongCtx.Data := SafeReallocMem( LongCtx.Data, LongCtx.DataSize + LongCtx.PieceSize );     //  SetLength( LongCtx.Data, LongCtx.DataSize + LongCtx.PieceSize );
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( LongCtx, LongCtxPtr, False );

  HelperMemWritePtr( bufpp, 0, IncPtr( LongCtx.Data, LongCtx.DataSize ) );
  HelperMemWritePtr( alenpp, 0, IncPtr( LongCtxPtr, SizeOf(LongCtx.Data)+SizeOf(LongCtx.DataSize) ) );
  HelperMemWritePtr( indpp,  0, IncPtr( LongCtxPtr, SizeOf(LongCtx.Data)+SizeOf(LongCtx.DataSize)+SizeOf(LongCtx.PieceSize) ) );
{$ELSE}
  TGetLongContext( LongCtxPtr^ ) := LongCtx;

  bufpp^ := IncPtr( LongCtxPtr^.Data, LongCtxPtr^.DataSize );//Pointer( TSDCharPtr(LongCtx.Data) + LongCtx.DataSize );
  alenpp^:= @LongCtxPtr^.PieceSize;
  indpp^ := @LongCtxPtr^.Ind;
{$ENDIF}
  Result := OCI_CONTINUE;
end;

function GetCdaDef_ft(CdaPtr: PCdaDef): Integer;
begin
  ASSERT( Assigned(CdaPtr) );
{$IFDEF XSQL_CLR}
  Result := TCdaDef( Marshal.PtrToStructure( CdaPtr, TypeOf(TCdaDef) ) ).ft;
{$ELSE}
  Result := TCdaDef( CdaPtr^ ).ft;
{$ENDIF}
end;

function GetCdaDef_rc(CdaPtr: PCdaDef): Integer;
begin
  ASSERT( Assigned(CdaPtr) );
{$IFDEF XSQL_CLR}
  Result := TCdaDef( Marshal.PtrToStructure( CdaPtr, TypeOf(TCdaDef) ) ).rc;
{$ELSE}
  Result := TCdaDef( CdaPtr^ ).rc;
{$ENDIF}
end;

function GetCdaDef_rpc(CdaPtr: PCdaDef): Integer;
begin
  ASSERT( Assigned(CdaPtr) );
{$IFDEF XSQL_CLR}
  Result := TCdaDef( Marshal.PtrToStructure( CdaPtr, TypeOf(TCdaDef) ) ).rpc;
{$ELSE}
  Result := TCdaDef( CdaPtr^ ).rpc;
{$ENDIF}
end;

{ Returns True if field type required converting from internal database format }
function Ora7RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in [ftDate, ftTime, ftDateTime, ftCursor, ftBCD];
end;

{ if possible then convert ftFloat(NUMBER) to ftInteger ( Precision <= 9 (10 digits >= 1 billion ) }
function OraExactNumberDataType(FieldType: TFieldType; Precision, Scale: Integer; IsEnableInts, IsEnableBCD: Boolean): TFieldType;
begin
  Result := FieldType;
  if (not IsEnableInts) and (not IsEnableBCD) then
    Exit;

  if (FieldType = ftFloat) and (Precision >= 1) then
    if Scale = 0 then begin
      if Precision <= (MAX_SINTFIELD_PREC) then
        Result := ftSmallInt
      else if Precision <= (MAX_INTFIELD_PREC) then
        Result := ftInteger;
    end else
      if IsEnableBCD and (Precision <= MAX_BCDFIELD_PREC) and
                (Scale > 0) and (Scale <= MAX_BCDFIELD_SCALE)
      then
        Result := ftBCD;
end;

{ Mapping Oracle internal/external datatypes in Delphi types.
Usually, Oracle internal datatype codes are returned in process
of describing of select-list items.
Oracle internal datatypes are subset of external datatypes, determine how Oracle
data will be converted between Oracle and program variables in process of read or write. }
function Ora7FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
    SQLT_CHR:	Result := ftString;	// (ORANET TYPE) character string
    SQLT_NUM:   Result := ftFloat;	// NUMBER
    SQLT_INT:	Result := ftInteger;	// (ORANET TYPE) integer
    SQLT_LNG:   Result := ftMemo;	// LONG
    SQLT_RID:   Result := ftString;	// ROWID
    SQLT_DAT:	Result := ftDateTime;	// DATE (Oracle7 datetime type with time part)
    SQLT_BIN:	Result := ftVarBytes;	// RAW
    SQLT_LBI:	Result := ftBlob;	// LONG RAW
    SQLT_AFC,
    SQLT_AVC:	Result := ftString;	// Ansi fixed and var char
    SQLT_CUR:	Result := ftCursor;	// cursor  type
    SQLT_LAB,
    SQLT_OSL:	Result := ftString;	// label type and oslabel type
  else
    Result := ftUnknown;
  end;
end;

function OraNativeDataSize(FieldType: TFieldType): Word;
const
  { Converting from TFieldType to Program Data Type(Oracle) }
  OraDataSizeMap: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, 	ftWord, 	ftBoolean
	0,	SizeOf(Integer), SizeOf(Integer), SizeOf(Integer), 0,
	// ftFloat, 	ftCurrency, 	ftBCD, 		ftDate, ftTime
        SizeOf(Double),	SizeOf(Double),	SizeOf(Double), ORA_DTS_DATE, 0,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        ORA_DTS_DATE, 	0, 	0, 		0, 	0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,		0,	0,		0,	0,
        // ftTypedBinary, ftCursor
        0,		CDA_SIZE
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        SizeOfPtr{SizeOf(POCILobLocator)}, SizeOfPtr{SizeOf(POCILobLocator)}, 0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
{$IFDEF XSQL_VCL10},
        0,      0,      0,      0
{$ENDIF}
        );
begin
  Result := OraDataSizeMap[FieldType];
end;

// SQLT_AVC can bind parameters and define select buffers for CHAR/VARCHAR column
// with and without trailing spaces (added by user) in contrast to SQLT_STR.
// However SQLT_AVC returns fields with trailing spaces with Oracle7 client always and with Oracle8+ in somtimes. So it's better to use SQLT_STR for select buffers
function OraNativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to Program Data Type(Oracle) }
  OraDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	SQLT_AVC, 	SQLT_INT, SQLT_INT, SQLT_INT, 0,
	// ftFloat, ftCurrency, ftBCD, 		ftDate, ftTime
        SQLT_FLT, 	SQLT_FLT, SQLT_FLT, SQLT_DAT, 0,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SQLT_DAT, 	SQLT_LBI, SQLT_LBI, 	0, 	SQLT_LBI,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SQLT_LNG, 	SQLT_LBI, SQLT_LNG,	0,	0,
        // ftTypedBinary, ftCursor
        0,		SQLT_CUR
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        SQLT_BLOB,	SQLT_CLOB,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	        0,	        0
{$ENDIF}
{$IFDEF XSQL_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
{$IFDEF XSQL_VCL10},
        0,      0,      0,      0
{$ENDIF}
        );
begin
  Result := OraDataTypeMap[FieldType];
end;

{ Converts TDateTime value in an internal Oracle datetime structure (Oracle7 structure) }
function OraCnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDPtr; BufSize: Integer): Integer;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  if BufSize < ORA_DTS_DATE then
    DatabaseError(SInsufficientIDateTimeBufSize);
	// it's necessary for ftDate
  Hour	:= 0;
  Min	:= 0;
  Sec	:= 0;

  if ADataType in [ftTime, ftDateTime] then
    DecodeTime(Value, Hour, Min, Sec, MSec);
  if ADataType in [ftDate, ftDateTime] then
    DecodeDate(Value, Year, Month, Day);

  HelperMemWriteByte( Buffer, 0, Year div 100 + 100 );
  HelperMemWriteByte( Buffer, 1, Year mod 100 + 100 );
  HelperMemWriteByte( Buffer, 2, Month );
  HelperMemWriteByte( Buffer, 3, Day );
	// default time value = midnight = (1, 1, 1)
  HelperMemWriteByte( Buffer, 4, Hour + 1 );
  HelperMemWriteByte( Buffer, 5, Min + 1 );
  HelperMemWriteByte( Buffer, 6, Sec + 1 );

  Result := BufSize;
end;

{ TDateTimeField is selected as TDateTimeRec and converts to TDateTime }
function OraCnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;
var
  Year, Month, Day, Hour, Min, Sec: Word;
  dtDate, dtTime: TDateTime;
begin
//  Year := (Byte( Buffer[0] ) - 100) * 100 + (Byte( Buffer[1] ) - 100);
  Year := (HelperMemReadByte( Buffer, 0 ) - 100) * 100 + (HelperMemReadByte( Buffer, 1 ) - 100);
  Month:= HelperMemReadByte( Buffer, 2 );
  Day  := HelperMemReadByte( Buffer, 3 );

  Hour := HelperMemReadByte( Buffer, 4 ) - 1;
  Min  := HelperMemReadByte( Buffer, 5 ) - 1;
  Sec  := HelperMemReadByte( Buffer, 6 ) - 1;
  dtDate := EncodeDate(Year, Month, Day);
  dtTime := EncodeTime(Hour, Min, Sec, 0);

  case (ADataType) of
    ftTime: 	Result.Time := DateTimeToTimeStamp(dtTime).Time;
    ftDate: 	Result.Date := DateTimeToTimeStamp(dtDate).Date;
    ftDateTime: Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) );
  else
    Result.DateTime := 0.0;
  end;
end;

{  Converts data from database to application format, which is used by Delphi.
InBuf - pointer to TFieldInfo, which is preceded a data buffer;
Buffer - where the converted data is placed (w/o TFieldInfo structure);
Result - is equal True, if data is NOT NULL.
  BufSize is not used for datetime data now. }
function OraCnvtDBData(ADataType: TFieldType; InBuf, Buffer: TSDPtr; BufSize: Integer; IsRTrimChar: Boolean): Boolean;
var
  FieldInfo: TSDFieldInfo;
  dtDateTime: TDateTimeRec;
  InData, OutData: TSDPtr;
  nSize: Integer;
  curr: Currency;
begin
  Result := False;
    	// data of BLOB-fields stored in other place and FetchStatus and DataSize set after fetch(read BLOB column)
  if IsBlobType( ADataType ) then
    Exit;

  FieldInfo := GetFieldInfoStruct(InBuf, 0);
  FieldInfo.FetchStatus := sb2( FieldInfo.FetchStatus );
	// also data can be truncated, overflowed or other
  Result := FieldInfo.FetchStatus <> FetRNul;

  if not Result then
    Exit;

  nSize := FieldInfo.DataSize;
  InData := IncPtr( InBuf, SizeOf(TSDFieldInfo) );
  OutData := Buffer;
  	// DateTime fields: only datetime fields(except blobs) are required to convert
  if IsDateTimeType(ADataType) then begin
    dtDateTime := OraCnvtDBDateTime2DateTimeRec(ADataType, InData, nSize);
    HelperMemWriteDateTimeRec( OutData, 0, dtDateTime );
  end else begin
    if nSize > BufSize then
      nSize := BufSize;         // to exclude overwriting OutData buffer
    if ADataType = ftString then begin
      SafeCopyMem( InData, OutData, nSize );
    	// PSDFieldInfo(InBuf)^.DataSize and nSize must include null-terminator,
        //but Oracle 8.0.5(and 8i) client does not include it.
      if HelperMemReadByte( OutData, nSize-1 ) <> 0 then begin       // if Oracle 8.0.5(or 8i) client
        if nSize < BufSize then
          Inc(nSize);
        // set null-terminator, when it is not here
        if HelperMemReadByte( OutData, nSize-1 ) <> 0 then
          HelperMemWriteByte( OutData, nSize-1, 0 );
      end;
      if IsRTrimChar then
        StrRTrim( OutData );
    end else if ADataType = ftBCD then begin
      curr := HelperMemReadDouble( InData, 0 );
      HelperCurrToBCD( curr, OutData, 32, 4 );
    end else
      SafeCopyMem( InData, OutData, nSize );
  end;
end;

{ Some string datatype does not include zero terminator character in the returned size }
function IsStringSizeIncludesZeroTerm(ExtDataType: Integer): Boolean;
begin
	// VARCHAR2, CHAR (SQLT_CHR, SQLT_AFC), MLSLABEL(SQLT_LAB, SQLT_OSL) and
        //ROWID(SQLT_RID) do not include zero-terminator in size
  Result := (Ora7FieldDataType(ExtDataType) = ftString) and not (ExtDataType in [SQLT_CHR, SQLT_AFC, SQLT_LAB, SQLT_OSL, SQLT_RID]);
end;


(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
function LoadSqlLib(IsForceOCI7: Boolean): LongInt;
  function GetOracleHome: string;
  const
    OraHomeKey	= 'SOFTWARE\ORACLE';
    OraHomeVal	= 'ORACLE_HOME';
  var
    rg: TRegistry;
  begin
    rg := TRegistry.Create;
    try
      rg.RootKey := HKEY_LOCAL_MACHINE;
{$IFDEF XSQL_VCL4}
      if rg.OpenKeyReadOnly(OraHomeKey) then begin
{$ELSE}
      if rg.OpenKey(OraHomeKey, False) then begin
{$ENDIF}
        Result := rg.ReadString(OraHomeVal);
        rg.CloseKey;
      end;
    finally
      rg.Free;
    end;
  end;

  function DetectVersion(const ALibName: string): LongInt;
  begin
    if (ALibName = 'ORA805.DLL') or
       (ALibName = 'ORA804.DLL') or
       (ALibName = 'ORA803.DLL') or
       (ALibName = 'OCI.DLL')		// this library can have different version 8.x-9.x
    then
      Result := MakeVerValue(8,0)
    else if ALibName = 'ORACLIENT10.DLL' then
      Result := MakeVerValue(10, 0)
    else if ALibName = 'ORACLIENT9.DLL' then
      Result := MakeVerValue(9, 0)
    else if ALibName = 'ORACLIENT8.DLL' then
      Result := MakeVerValue(8, 1)
    else if ALibName = 'ORA73.DLL' then
      Result := MakeVerValue(7, 3)
    else if ALibName = 'ORA72.DLL' then
      Result := MakeVerValue(7, 2)
    else if ALibName = 'OCIW32.DLL' then
      Result := MakeVerValue(7, 3)		// or more
    else
      Result := UnknownOCI;
  end;

var
  sLibName, sSqlApiDLL, sOraBinDir: string;
  CurPos: Integer;
begin
  Result := 0;
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      sOraBinDir := GetOracleHome;
{$IFDEF XSQL_CLR}
      sOraBinDir := '';		// OCI library is loaded automatically
      if IsForceOCI7
      then SqlApiDLL := DefOCI7DLL
      else SqlApiDLL := DefOCI8DLL;
{$ENDIF}
      sSqlApiDLL := SqlApiDll;
      if Trim(sOraBinDir) <> '' then
        sOraBinDir := sOraBinDir + '\BIN\';

       	// first it's need to looking in global path, which is set by Oracle Home Selector
      CurPos := 1;
      while (CurPos <= Length(sSqlApiDLL)) and (hSqlLibModule = 0) do begin
        sLibName := ExtractLibName(sSqlApiDLL, SqlApiDLLSep, CurPos);
        hSqlLibModule := HelperLoadLibrary( sLibName );
      end;
       	// then look, for example, in ORANT\BIN or ORA95\BIN directory
      CurPos := 1;
      if Trim(sOraBinDir) <> '' then
        while (CurPos <= Length(sSqlApiDLL)) and (hSqlLibModule = 0) do begin
          sLibName := ExtractLibName(sSqlApiDLL, SqlApiDLLSep, CurPos);
          hSqlLibModule := HelperLoadLibrary( sOraBinDir + sLibName );
        end;

      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [sSqlApiDLL]);
      Inc(SqlLibRefCount);
	// detect OCI-version
      sLibName := ExtractFileName( UpperCase(sLibName) );
      dwLoadedOCI := DetectVersion( sLibName );

    end else
      Inc(SqlLibRefCount);
        // it is necessary when both OCI7 and OCI8 are required
    if (not IsForceOCI7) and (GetMajorVer(dwLoadedOCI) >= 8) then begin
      if not IsLoadedOCI8 then
        InitOCI8;
    end else begin
      if not IsLoadedOCI7 then
        InitOCI7;
    end;

    Result := dwLoadedOCI;
  finally
    SqlLibLock.Release;
  end;
end;

procedure FreeSqlLib;
begin
  if SqlLibRefCount = 0 then
    Exit;

  SqlLibLock.Acquire;
  try
    if SqlLibRefCount = 1 then begin
      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ GetModuleFileNameStr(hSqlLibModule) ]);
      Dec(SqlLibRefCount);

      DoneOCI7;
      DoneOCI8;
      dwLoadedOCI := 0;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

procedure InitOCI7;
begin
{$IFNDEF XSQL_CLR}
  @obindps      := GetProcAddress(hSqlLibModule, 'obindps');	ASSERT( (dwLoadedOCI < MakeVerValue(7, 3)) or (@obindps<>nil),	Format(SErrFuncNotFound, ['obindps<']) );
  @obreak      	:= GetProcAddress(hSqlLibModule, 'obreak');  	ASSERT( @obreak<>nil,	Format(SErrFuncNotFound, ['obreak']) );
  @ocan        	:= GetProcAddress(hSqlLibModule, 'ocan');  	ASSERT( @ocan<>nil,	Format(SErrFuncNotFound, ['ocan']) );
  @oclose	:= GetProcAddress(hSqlLibModule, 'oclose');  	ASSERT( @oclose<>nil,	Format(SErrFuncNotFound, ['oclose']) );
  @ocof		:= GetProcAddress(hSqlLibModule, 'ocof');  	ASSERT( @ocof<>nil,	Format(SErrFuncNotFound, ['ocof']) );
  @ocom		:= GetProcAddress(hSqlLibModule, 'ocom');  	ASSERT( @ocom<>nil,	Format(SErrFuncNotFound, ['ocom']) );
  @ocon 	:= GetProcAddress(hSqlLibModule, 'ocon');  	ASSERT( @ocon<>nil,	Format(SErrFuncNotFound, ['ocon']) );
  @odefinps	:= GetProcAddress(hSqlLibModule, 'odefinps');  	ASSERT( (dwLoadedOCI < MakeVerValue(7, 3)) or (@odefinps<>nil),Format(SErrFuncNotFound, ['odefinps']) );
  @odessp  	:= GetProcAddress(hSqlLibModule, 'odessp');  	ASSERT( @odessp<>nil,	Format(SErrFuncNotFound, ['odessp']) );
  @odescr  	:= GetProcAddress(hSqlLibModule, 'odescr');  	ASSERT( @odescr<>nil,	Format(SErrFuncNotFound, ['odescr']) );
  @oerhms  	:= GetProcAddress(hSqlLibModule, 'oerhms');  	ASSERT( @oerhms<>nil,	Format(SErrFuncNotFound, ['oerhms']) );
  @oermsg  	:= GetProcAddress(hSqlLibModule, 'oermsg');  	ASSERT( @oermsg<>nil,	Format(SErrFuncNotFound, ['oermsg']) );
  @oexec   	:= GetProcAddress(hSqlLibModule, 'oexec');  	ASSERT( @oexec<>nil,	Format(SErrFuncNotFound, ['oexec']) );
  @oexfet  	:= GetProcAddress(hSqlLibModule, 'oexfet');  	ASSERT( @oexfet<>nil,	Format(SErrFuncNotFound, ['oexfet']) );
  @oexn    	:= GetProcAddress(hSqlLibModule, 'oexn');  	ASSERT( @oexn<>nil,	Format(SErrFuncNotFound, ['oexn']) );
  @ofen    	:= GetProcAddress(hSqlLibModule, 'ofen');  	ASSERT( @ofen<>nil,	Format(SErrFuncNotFound, ['ofen']) );
  @ofetch  	:= GetProcAddress(hSqlLibModule, 'ofetch');  	ASSERT( @ofetch<>nil,	Format(SErrFuncNotFound, ['ofetch']) );
  @oflng   	:= GetProcAddress(hSqlLibModule, 'oflng');  	ASSERT( @oflng<>nil,	Format(SErrFuncNotFound, ['oflng']) );
  @ogetpi  	:= GetProcAddress(hSqlLibModule, 'ogetpi');  	ASSERT( (dwLoadedOCI < MakeVerValue(7, 3)) or (@ogetpi<>nil),	Format(SErrFuncNotFound, ['ogetpi']) );
  @oopt    	:= GetProcAddress(hSqlLibModule, 'oopt');  	ASSERT( @oopt<>nil,	Format(SErrFuncNotFound, ['oopt']) );
  @opinit  	:= GetProcAddress(hSqlLibModule, 'opinit');  	ASSERT( (dwLoadedOCI < MakeVerValue(7, 3)) or (@opinit<>nil),	Format(SErrFuncNotFound, ['opinit']) );
  @olog    	:= GetProcAddress(hSqlLibModule, 'olog');  	ASSERT( @olog<>nil,	Format(SErrFuncNotFound, ['olog']) );
  @ologof  	:= GetProcAddress(hSqlLibModule, 'ologof');  	ASSERT( @ologof<>nil,	Format(SErrFuncNotFound, ['ologof']) );
  @oopen   	:= GetProcAddress(hSqlLibModule, 'oopen');  	ASSERT( @oopen<>nil,	Format(SErrFuncNotFound, ['oopen']) );
  @oparse  	:= GetProcAddress(hSqlLibModule, 'oparse');  	ASSERT( @oparse<>nil,	Format(SErrFuncNotFound, ['oparse']) );
  @orol    	:= GetProcAddress(hSqlLibModule, 'orol');  	ASSERT( @orol<>nil,	Format(SErrFuncNotFound, ['orol']) );
  @osetpi  	:= GetProcAddress(hSqlLibModule, 'osetpi');  	ASSERT( (dwLoadedOCI < MakeVerValue(7, 3)) or (@osetpi<>nil),	Format(SErrFuncNotFound, ['osetpi']) );
  @onbset  	:= GetProcAddress(hSqlLibModule, 'onbset');  	ASSERT( @onbset<>nil,	Format(SErrFuncNotFound, ['onbset']) );
  @onbtst  	:= GetProcAddress(hSqlLibModule, 'onbtst');  	ASSERT( @onbtst<>nil,	Format(SErrFuncNotFound, ['onbtst']) );
  @onbclr  	:= GetProcAddress(hSqlLibModule, 'onbclr');  	ASSERT( @onbclr<>nil,	Format(SErrFuncNotFound, ['onbclr']) );
//  @ognfd   	:= GetProcAddress(hSqlLibModule, 'ognfd');  	ASSERT( @ognfd<>nil,	Format(SErrFuncNotFound, ['ognfd']) );
	{ OBSOLETE CALLS }
  @obndra	:= GetProcAddress(hSqlLibModule, 'obndra');  	ASSERT( @obndra<>nil,	Format(SErrFuncNotFound, ['obndra']) );
  @obndrn	:= GetProcAddress(hSqlLibModule, 'obndrn');  	ASSERT( @obndrn<>nil,	Format(SErrFuncNotFound, ['obndrn']) );
  @obndrv	:= GetProcAddress(hSqlLibModule, 'obndrv');  	ASSERT( @obndrv<>nil,	Format(SErrFuncNotFound, ['obndrv']) );
  @odefin	:= GetProcAddress(hSqlLibModule, 'odefin');  	ASSERT( @odefin<>nil,	Format(SErrFuncNotFound, ['odefin']) );
{$ENDIF}
  bDetectedOCI72 := IsAvailFunc( 'onbclr' ) and IsAvailFunc( 'onbset' ) and IsAvailFunc( 'onbtst' );
  bDetectedOCI73 := IsAvailFunc( 'obindps' ) and IsAvailFunc( 'odefinps' ) and
                    IsAvailFunc( 'opinit' ) and IsAvailFunc( 'ogetpi' ) and IsAvailFunc( 'osetpi' );
	// init a threadsafe mode
  if bDetectedOCI73 then
    opinit(OCI_EV_TSF);
end;

procedure DoneOCI7;
begin
{$IFNDEF XSQL_CLR}
  @obindps      := nil;
  @obreak      	:= nil;
  @ocan        	:= nil;
  @oclose	:= nil;
  @ocof		:= nil;
  @ocom		:= nil;
  @ocon 	:= nil;
  @odefinps	:= nil;
  @odessp  	:= nil;
  @odescr  	:= nil;
  @oerhms  	:= nil;
  @oermsg  	:= nil;
  @oexec   	:= nil;
  @oexfet  	:= nil;
  @oexn    	:= nil;
  @ofen    	:= nil;
  @ofetch  	:= nil;
  @oflng   	:= nil;
  @ogetpi  	:= nil;
  @oopt    	:= nil;
  @opinit  	:= nil;
  @olog    	:= nil;
  @ologof  	:= nil;
  @oopen   	:= nil;
  @oparse  	:= nil;
  @orol    	:= nil;
  @osetpi  	:= nil;
  @onbset  	:= nil;
  @onbtst  	:= nil;
  @onbclr  	:= nil;
//  @ognfd   	:= nil;
	{ OBSOLETE CALLS }
  @obndra	:= nil;
  @obndrn	:= nil;
  @obndrv	:= nil;
  @odefin	:= nil;
{$ENDIF}
  bDetectedOCI72 := False;
  bDetectedOCI73 := False;
end;

procedure InitOCI8;
begin
{$IFNDEF XSQL_CLR}
  @OCIInitialize	:= GetProcAddress(hSqlLibModule, 'OCIInitialize');  	ASSERT( @OCIInitialize		<>nil,	Format(SErrFuncNotFound, ['OCIInitialize']) );
  @OCITerminate		:= GetProcAddress(hSqlLibModule, 'OCIInitialize');  	ASSERT( @OCIInitialize		<>nil,	Format(SErrFuncNotFound, ['OCITerminate']) );
  @OCIHandleAlloc	:= GetProcAddress(hSqlLibModule, 'OCIHandleAlloc');  	ASSERT( @OCIHandleAlloc		<>nil,	Format(SErrFuncNotFound, ['OCIHandleAlloc']) );
  @OCIHandleFree	:= GetProcAddress(hSqlLibModule, 'OCIHandleFree');  	ASSERT( @OCIHandleFree		<>nil,	Format(SErrFuncNotFound, ['OCIHandleFree']) );
  @OCIDescriptorAlloc	:= GetProcAddress(hSqlLibModule, 'OCIDescriptorAlloc'); ASSERT( @OCIDescriptorAlloc	<>nil,	Format(SErrFuncNotFound, ['OCIDescriptorAlloc']) );
  @OCIDescriptorFree	:= GetProcAddress(hSqlLibModule, 'OCIDescriptorFree');  ASSERT( @OCIDescriptorFree	<>nil,	Format(SErrFuncNotFound, ['OCIDescriptorFree']) );
	// OCIEnvCreate was implemented at OCI v8.1.5
  @OCIEnvCreate		:= GetProcAddress(hSqlLibModule, 'OCIEnvCreate');
  @OCIEnvInit		:= GetProcAddress(hSqlLibModule, 'OCIEnvInit');  	ASSERT( @OCIEnvInit		<>nil,	Format(SErrFuncNotFound, ['OCIEnvInit']) );
  @OCIServerAttach	:= GetProcAddress(hSqlLibModule, 'OCIServerAttach');  	ASSERT( @OCIServerAttach	<>nil,	Format(SErrFuncNotFound, ['OCIServerAttach']) );
  @OCIServerDetach	:= GetProcAddress(hSqlLibModule, 'OCIServerDetach');  	ASSERT( @OCIServerDetach	<>nil,	Format(SErrFuncNotFound, ['OCIServerDetach']) );
  @OCISessionBegin	:= GetProcAddress(hSqlLibModule, 'OCISessionBegin');  	ASSERT( @OCISessionBegin	<>nil,	Format(SErrFuncNotFound, ['OCISessionBegin']) );
  @OCISessionEnd	:= GetProcAddress(hSqlLibModule, 'OCISessionEnd');	ASSERT( @OCISessionEnd		<>nil,	Format(SErrFuncNotFound, ['OCISessionEnd']) );
  @OCILogon		:= GetProcAddress(hSqlLibModule, 'OCILogon');  		ASSERT( @OCILogon		<>nil,	Format(SErrFuncNotFound, ['OCILogon']) );
  @OCILogoff		:= GetProcAddress(hSqlLibModule, 'OCILogoff');  	ASSERT( @OCILogoff		<>nil,	Format(SErrFuncNotFound, ['OCILogoff']) );
  @OCIPasswordChange	:= GetProcAddress(hSqlLibModule, 'OCIPasswordChange');  ASSERT( @OCIPasswordChange	<>nil,	Format(SErrFuncNotFound, ['OCIPasswordChange']) );
  @OCIStmtPrepare	:= GetProcAddress(hSqlLibModule, 'OCIStmtPrepare');  	ASSERT( @OCIStmtPrepare		<>nil,	Format(SErrFuncNotFound, ['OCIStmtPrepare']) );
  @OCIBindByPos		:= GetProcAddress(hSqlLibModule, 'OCIBindByPos');  	ASSERT( @OCIBindByPos  		<>nil,	Format(SErrFuncNotFound, ['OCIBindByPos']) );
  @OCIBindByName	:= GetProcAddress(hSqlLibModule, 'OCIBindByName');  	ASSERT( @OCIBindByName 		<>nil,	Format(SErrFuncNotFound, ['OCIBindByName']) );
  @OCIBindObject	:= GetProcAddress(hSqlLibModule, 'OCIBindObject');	ASSERT( @OCIBindObject 		<>nil,	Format(SErrFuncNotFound, ['OCIBindObject']) );
  @OCIBindDynamic	:= GetProcAddress(hSqlLibModule, 'OCIBindDynamic');  	ASSERT( @OCIBindDynamic		<>nil,	Format(SErrFuncNotFound, ['OCIBindDynamic']) );
  @OCIBindArrayOfStruct	:= GetProcAddress(hSqlLibModule, 'OCIBindArrayOfStruct');ASSERT( @OCIBindArrayOfStruct	<>nil,	Format(SErrFuncNotFound, ['OCIBindArrayOfStruct']) );
  @OCIStmtGetPieceInfo	:= GetProcAddress(hSqlLibModule, 'OCIStmtGetPieceInfo');ASSERT( @OCIStmtGetPieceInfo	<>nil,	Format(SErrFuncNotFound, ['OCIStmtGetPieceInfo']) );
  @OCIStmtSetPieceInfo	:= GetProcAddress(hSqlLibModule, 'OCIStmtSetPieceInfo');ASSERT( @OCIStmtSetPieceInfo	<>nil,	Format(SErrFuncNotFound, ['OCIStmtSetPieceInfo']) );
  @OCIStmtExecute	:= GetProcAddress(hSqlLibModule, 'OCIStmtExecute');  	ASSERT( @OCIStmtExecute		<>nil,	Format(SErrFuncNotFound, ['OCIStmtExecute']) );
  @OCIDefineByPos	:= GetProcAddress(hSqlLibModule, 'OCIDefineByPos');  	ASSERT( @OCIDefineByPos		<>nil,	Format(SErrFuncNotFound, ['OCIDefineByPos']) );
  @OCIDefineObject	:= GetProcAddress(hSqlLibModule, 'OCIDefineObject');  	ASSERT( @OCIDefineObject	<>nil,	Format(SErrFuncNotFound, ['OCIDefineObject']) );
  @OCIDefineDynamic	:= GetProcAddress(hSqlLibModule, 'OCIDefineDynamic');  	ASSERT( @OCIDefineDynamic	<>nil,	Format(SErrFuncNotFound, ['OCIDefineDynamic']) );
  @OCIDefineArrayOfStruct:=GetProcAddress(hSqlLibModule, 'OCIDefineArrayOfStruct');ASSERT( @OCIDefineArrayOfStruct<>nil,Format(SErrFuncNotFound, ['OCIDefineArrayOfStruct']) );
  @OCIStmtFetch		:= GetProcAddress(hSqlLibModule, 'OCIStmtFetch');  	ASSERT( @OCIStmtFetch		<>nil,	Format(SErrFuncNotFound, ['OCIStmtFetch']) );
  @OCIStmtGetBindInfo	:= GetProcAddress(hSqlLibModule, 'OCIStmtGetBindInfo'); ASSERT( @OCIStmtGetBindInfo	<>nil,	Format(SErrFuncNotFound, ['OCIStmtGetBindInfo']) );
  @OCIDescribeAny	:= GetProcAddress(hSqlLibModule, 'OCIDescribeAny');  	ASSERT( @OCIDescribeAny		<>nil,	Format(SErrFuncNotFound, ['OCIDescribeAny']) );
  @OCIParamGet		:= GetProcAddress(hSqlLibModule, 'OCIParamGet');  	ASSERT( @OCIParamGet		<>nil,	Format(SErrFuncNotFound, ['OCIParamGet']) );
  @OCIParamSet		:= GetProcAddress(hSqlLibModule, 'OCIParamSet');  	ASSERT( @OCIParamSet		<>nil,	Format(SErrFuncNotFound, ['OCIParamSet']) );
  @OCITransStart	:= GetProcAddress(hSqlLibModule, 'OCITransStart');   	ASSERT( @OCITransStart		<>nil,	Format(SErrFuncNotFound, ['OCITransStart']) );
  @OCITransDetach	:= GetProcAddress(hSqlLibModule, 'OCITransDetach');  	ASSERT( @OCITransDetach		<>nil,	Format(SErrFuncNotFound, ['OCITransDetach']) );
  @OCITransCommit	:= GetProcAddress(hSqlLibModule, 'OCITransCommit');  	ASSERT( @OCITransCommit		<>nil,	Format(SErrFuncNotFound, ['OCITransCommit']) );
  @OCITransRollback	:= GetProcAddress(hSqlLibModule, 'OCITransRollback');  	ASSERT( @OCITransRollback	<>nil,	Format(SErrFuncNotFound, ['OCITransRollback']) );
  @OCITransPrepare	:= GetProcAddress(hSqlLibModule, 'OCITransPrepare');  	ASSERT( @OCITransPrepare	<>nil,	Format(SErrFuncNotFound, ['OCITransPrepare']) );
  @OCITransForget	:= GetProcAddress(hSqlLibModule, 'OCITransForget');  	ASSERT( @OCITransForget		<>nil,	Format(SErrFuncNotFound, ['OCITransForget']) );
  @OCIErrorGet		:= GetProcAddress(hSqlLibModule, 'OCIErrorGet');  	ASSERT( @OCIErrorGet		<>nil,	Format(SErrFuncNotFound, ['OCIErrorGet']) );
  @OCILobAppend		:= GetProcAddress(hSqlLibModule, 'OCILobAppend');  	ASSERT( @OCILobAppend		<>nil,	Format(SErrFuncNotFound, ['OCILobAppend']) );
  @OCILobAssign		:= GetProcAddress(hSqlLibModule, 'OCILobAssign');  	ASSERT( @OCILobAssign		<>nil,	Format(SErrFuncNotFound, ['OCILobAssign']) );
  @OCILobCharSetForm	:= GetProcAddress(hSqlLibModule, 'OCILobCharSetForm');  ASSERT( @OCILobCharSetForm	<>nil,	Format(SErrFuncNotFound, ['OCILobCharSetForm']) );
  @OCILobCharSetId	:= GetProcAddress(hSqlLibModule, 'OCILobCharSetId');  	ASSERT( @OCILobCharSetId	<>nil,	Format(SErrFuncNotFound, ['OCILobCharSetId']) );
  @OCILobCopy		:= GetProcAddress(hSqlLibModule, 'OCILobCopy');  	ASSERT( @OCILobCopy		<>nil,	Format(SErrFuncNotFound, ['OCILobCopy']) );
  @OCILobDisableBuffering:=GetProcAddress(hSqlLibModule, 'OCILobDisableBuffering');ASSERT( @OCILobDisableBuffering<>nil,Format(SErrFuncNotFound, ['OCILobDisableBuffering']) );
  @OCILobEnableBuffering:= GetProcAddress(hSqlLibModule, 'OCILobEnableBuffering');ASSERT( @OCILobEnableBuffering<>nil,	Format(SErrFuncNotFound, ['OCILobEnableBuffering']) );
  @OCILobErase		:= GetProcAddress(hSqlLibModule, 'OCILobErase');  	ASSERT( @OCILobErase		<>nil,	Format(SErrFuncNotFound, ['OCILobErase']) );
  @OCILobFileClose	:= GetProcAddress(hSqlLibModule, 'OCILobFileClose');  	ASSERT( @OCILobFileClose	<>nil,	Format(SErrFuncNotFound, ['OCILobFileClose']) );
  @OCILobFileCloseAll	:= GetProcAddress(hSqlLibModule, 'OCILobFileCloseAll'); ASSERT( @OCILobFileCloseAll	<>nil,	Format(SErrFuncNotFound, ['OCILobFileCloseAll']) );
  @OCILobFileExists	:= GetProcAddress(hSqlLibModule, 'OCILobFileExists');  	ASSERT( @OCILobFileExists	<>nil,	Format(SErrFuncNotFound, ['OCILobFileExists']) );
  @OCILobFileGetName	:= GetProcAddress(hSqlLibModule, 'OCILobFileGetName');  ASSERT( @OCILobFileGetName	<>nil,	Format(SErrFuncNotFound, ['OCILobFileGetName']) );
  @OCILobFileIsOpen	:= GetProcAddress(hSqlLibModule, 'OCILobFileIsOpen');  	ASSERT( @OCILobFileIsOpen	<>nil,	Format(SErrFuncNotFound, ['OCILobFileIsOpen']) );
  @OCILobFileOpen	:= GetProcAddress(hSqlLibModule, 'OCILobFileOpen');  	ASSERT( @OCILobFileOpen		<>nil,	Format(SErrFuncNotFound, ['OCILobFileOpen']) );
  @OCILobFileSetName	:= GetProcAddress(hSqlLibModule, 'OCILobFileSetName');  ASSERT( @OCILobFileSetName	<>nil,	Format(SErrFuncNotFound, ['OCILobFileSetName']) );
  @OCILobFlushBuffer	:= GetProcAddress(hSqlLibModule, 'OCILobFlushBuffer');  ASSERT( @OCILobFlushBuffer	<>nil,	Format(SErrFuncNotFound, ['OCILobFlushBuffer']) );
  @OCILobGetLength	:= GetProcAddress(hSqlLibModule, 'OCILobGetLength');  	ASSERT( @OCILobGetLength	<>nil,	Format(SErrFuncNotFound, ['OCILobGetLength']) );
  @OCILobIsEqual       	:= GetProcAddress(hSqlLibModule, 'OCILobIsEqual');  	ASSERT( @OCILobIsEqual		<>nil,	Format(SErrFuncNotFound, ['OCILobIsEqual']) );
  @OCILobLoadFromFile	:= GetProcAddress(hSqlLibModule, 'OCILobLoadFromFile'); ASSERT( @OCILobLoadFromFile	<>nil,	Format(SErrFuncNotFound, ['OCILobLoadFromFile']) );
  @OCILobLocatorIsInit	:= GetProcAddress(hSqlLibModule, 'OCILobLocatorIsInit');ASSERT( @OCILobLocatorIsInit	<>nil,	Format(SErrFuncNotFound, ['OCILobLocatorIsInit']) );
  @OCILobRead		:= GetProcAddress(hSqlLibModule, 'OCILobRead');  	ASSERT( @OCILobRead		<>nil,	Format(SErrFuncNotFound, ['OCILobRead']) );
  @OCILobTrim		:= GetProcAddress(hSqlLibModule, 'OCILobTrim');  	ASSERT( @OCILobTrim		<>nil,	Format(SErrFuncNotFound, ['OCILobTrim']) );
  @OCILobWrite		:= GetProcAddress(hSqlLibModule, 'OCILobWrite');  	ASSERT( @OCILobWrite		<>nil,	Format(SErrFuncNotFound, ['OCILobWrite']) );
  @OCIBreak		:= GetProcAddress(hSqlLibModule, 'OCIBreak');  		ASSERT( @OCIBreak		<>nil,	Format(SErrFuncNotFound, ['OCIBreak']) );
  @OCIServerVersion	:= GetProcAddress(hSqlLibModule, 'OCIServerVersion');  	ASSERT( @OCIServerVersion	<>nil,	Format(SErrFuncNotFound, ['OCIServerVersion']) );
  @OCIAttrGet		:= GetProcAddress(hSqlLibModule, 'OCIAttrGet');  	ASSERT( @OCIAttrGet		<>nil,	Format(SErrFuncNotFound, ['OCIAttrGet']) );
  @OCIAttrSet		:= GetProcAddress(hSqlLibModule, 'OCIAttrSet');  	ASSERT( @OCIAttrSet		<>nil,	Format(SErrFuncNotFound, ['OCIAttrSet']) );
  @OCISvcCtxToLda	:= GetProcAddress(hSqlLibModule, 'OCISvcCtxToLda');  	ASSERT( @OCISvcCtxToLda		<>nil,	Format(SErrFuncNotFound, ['OCISvcCtxToLda']) );
  @OCILdaToSvcCtx	:= GetProcAddress(hSqlLibModule, 'OCILdaToSvcCtx');  	ASSERT( @OCILdaToSvcCtx		<>nil,	Format(SErrFuncNotFound, ['OCILdaToSvcCtx']) );
  @OCIResultSetToStmt	:= GetProcAddress(hSqlLibModule, 'OCIResultSetToStmt'); ASSERT( @OCIResultSetToStmt	<>nil,	Format(SErrFuncNotFound, ['OCIResultSetToStmt']) );
	// XA library support: xaoOCIEnv, xaoSvcCtx were implemented at OCI v8.1
  @xaoEnv		:= GetProcAddress(hSqlLibModule, 'xaoEnv');
  @xaoSvcCtx		:= GetProcAddress(hSqlLibModule, 'xaoSvcCtx');
	// Oracle8i Release 2 (8.1.6)
  @OCILobCreateTemporary:= GetProcAddress(hSqlLibModule, 'OCILobCreateTemporary');
  @OCILobFreeTemporary  := GetProcAddress(hSqlLibModule, 'OCILobFreeTemporary');
	// Oracle9i
  @OCIDateTimeConstruct	:= GetProcAddress(hSqlLibModule, 'OCIDateTimeConstruct');
  @OCIDateTimeGetDate	:= GetProcAddress(hSqlLibModule, 'OCIDateTimeGetDate');
  @OCIDateTimeGetTime	:= GetProcAddress(hSqlLibModule, 'OCIDateTimeGetTime');
  @OCIDateTimeGetTimeZoneName
  			:= GetProcAddress(hSqlLibModule, 'OCIDateTimeGetTimeZoneName');
  @OCIDateTimeGetTimeZoneOffset
  			:= GetProcAddress(hSqlLibModule, 'OCIDateTimeGetTimeZoneOffset');

  @OCIIntervalSetYearMonth:= GetProcAddress(hSqlLibModule, 'OCIIntervalSetYearMonth');
  @OCIIntervalGetYearMonth:= GetProcAddress(hSqlLibModule, 'OCIIntervalGetYearMonth');
  @OCIIntervalSetDaySecond:= GetProcAddress(hSqlLibModule, 'OCIIntervalSetDaySecond');
  @OCIIntervalGetDaySecond:= GetProcAddress(hSqlLibModule, 'OCIIntervalGetDaySecond');
{$ENDIF}
  if not IsAvailFunc( 'OCIEnvCreate' ) and IsAvailFunc( 'OCIInitialize' ) then
    OCIInitialize( OCI_THREADED or OCI_OBJECT, nil, nil, nil, nil );
end;

procedure DoneOCI8;
begin
{$IFNDEF XSQL_CLR}
  @OCIInitialize	:= nil;
  @OCIHandleAlloc	:= nil;
  @OCIHandleFree	:= nil;
  @OCIDescriptorAlloc	:= nil;
  @OCIDescriptorFree	:= nil;
  @OCIEnvCreate		:= nil;
  @OCIEnvInit		:= nil;
  @OCIServerAttach	:= nil;
  @OCIServerDetach	:= nil;
  @OCISessionBegin	:= nil;
  @OCISessionEnd	:= nil;
  @OCILogon		:= nil;
  @OCILogoff		:= nil;
  @OCIPasswordChange	:= nil;
  @OCIStmtPrepare	:= nil;
  @OCIBindByPos		:= nil;
  @OCIBindByName	:= nil;
  @OCIBindObject	:= nil;
  @OCIBindDynamic	:= nil;
  @OCIBindArrayOfStruct	:= nil;
  @OCIStmtGetPieceInfo	:= nil;
  @OCIStmtSetPieceInfo	:= nil;
  @OCIStmtExecute	:= nil;
  @OCIDefineByPos	:= nil;
  @OCIDefineObject	:= nil;
  @OCIDefineDynamic	:= nil;
  @OCIDefineArrayOfStruct:=nil;
  @OCIStmtFetch		:= nil;
  @OCIStmtGetBindInfo	:= nil;
  @OCIDescribeAny	:= nil;
  @OCIParamGet		:= nil;
  @OCIParamSet		:= nil;
  @OCITransStart	:= nil;
  @OCITransDetach	:= nil;
  @OCITransCommit	:= nil;
  @OCITransRollback	:= nil;
  @OCITransPrepare	:= nil;
  @OCITransForget	:= nil;
  @OCIErrorGet		:= nil;
  @OCILobAppend		:= nil;
  @OCILobAssign		:= nil;
  @OCILobCharSetForm	:= nil;
  @OCILobCharSetId	:= nil;
  @OCILobCopy		:= nil;
  @OCILobDisableBuffering:=nil;
  @OCILobEnableBuffering:= nil;
  @OCILobErase		:= nil;
  @OCILobFileClose	:= nil;
  @OCILobFileCloseAll	:= nil;
  @OCILobFileExists	:= nil;
  @OCILobFileGetName	:= nil;
  @OCILobFileIsOpen	:= nil;
  @OCILobFileOpen	:= nil;
  @OCILobFileSetName	:= nil;
  @OCILobFlushBuffer	:= nil;
  @OCILobGetLength	:= nil;
  @OCILobIsEqual       	:= nil;
  @OCILobLoadFromFile	:= nil;
  @OCILobLocatorIsInit	:= nil;
  @OCILobRead		:= nil;
  @OCILobTrim		:= nil;
  @OCILobWrite		:= nil;
  @OCIBreak		:= nil;
  @OCIServerVersion	:= nil;
  @OCIAttrGet		:= nil;
  @OCIAttrSet		:= nil;
  @OCISvcCtxToLda	:= nil;
  @OCILdaToSvcCtx	:= nil;
  @OCIResultSetToStmt	:= nil;

  @xaoEnv		:= nil;
  @xaoSvcCtx		:= nil;

  @OCIDateTimeConstruct	:= nil;
  @OCIDateTimeGetDate	:= nil;
  @OCIDateTimeGetTime	:= nil;
  @OCIDateTimeGetTimeZoneName	:=nil;
  @OCIDateTimeGetTimeZoneOffset	:=nil;

  @OCIIntervalSetYearMonth:= nil;
  @OCIIntervalGetYearMonth:= nil;
  @OCIIntervalSetDaySecond:= nil;
  @OCIIntervalGetDaySecond:= nil;
{$ENDIF}
end;

{-------------------------------------------------------------------------------
 			call Oracle API (OCI)
-------------------------------------------------------------------------------}
constructor TIOraDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle 	:= nil;
  	// procedures can have a cursor parameter
  FProcSupportsCursor := True;
	// by default IsEnableInts = False
  FIsEnableInts := UpperCase( Trim( Params.Values[szENABLEINTS] ) ) = STrueString;
end;

destructor TIOraDatabase.Destroy;
begin
  if AcquiredHandle then
    FreeSqlLib;

  inherited Destroy;
end;

function TIOraDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIOraCommand.Create( Self );
end;

procedure TIOraDatabase.Check(Status: TSDEResult);
var
  pLda: PLdaDef;
  lda: TLdaDef;
begin
  ResetIdleTimeOut;
  if Status = 0 then
    Exit;
  ResetBusyState;
  pLda := LdaPtr;
{$IFDEF XSQL_CLR}
  lda := TLdaDef( Marshal.PtrToStructure( pLda, TypeOf(TLdaDef) ) );
{$ELSE}
  lda := TLdaDef( pLda^ );
{$ENDIF}
  OraErrorOCI7( pLda, lda.rc, -1 );
end;

procedure TIOraDatabase.AllocHandle;
var
  rec: TIOraConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TIOraDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.LdaPtr := SafeReallocMem( nil, CDA_SIZE );
  SafeInitMem( rec.LdaPtr, CDA_SIZE, 0 );
  rec.HdaPtr := SafeReallocMem( nil, HDA_SIZE );
  SafeInitMem( rec.HdaPtr, HDA_SIZE, 0 );
  rec.CdaPtr := SafeReallocMem( nil, CDA_SIZE );
  SafeInitMem( rec.CdaPtr, CDA_SIZE, 0 );

  rec.ServerType := Ord( istOracle );

{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIOraConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TIOraDatabase.FreeHandle;
var
  rec: TIOraConnInfo;
begin
  if not Assigned(FHandle) then
    Exit;

{$IFDEF XSQL_CLR}
  rec := TIOraConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOraConnInfo) ) );
{$ELSE}
  rec := TIOraConnInfo( FHandle^ );
{$ENDIF}
  if Assigned( rec.LdaPtr ) then begin
    SafeReallocMem( rec.LdaPtr, 0 );
{$IFNDEF XSQL_CLR}
    TIOraConnInfo(FHandle^).LdaPtr := nil;
{$ENDIF}
  end;
  if Assigned( rec.HdaPtr ) then begin
    SafeReallocMem( rec.HdaPtr, 0 );
{$IFNDEF XSQL_CLR}
    TIOraConnInfo(FHandle^).HdaPtr := nil;
{$ENDIF}
  end;
  if Assigned( rec.CdaPtr ) then begin
    SafeReallocMem( rec.CdaPtr, 0 );
{$IFNDEF XSQL_CLR}
    TIOraConnInfo(FHandle^).CdaPtr := nil;
{$ENDIF}
  end;
  FHandle := SafeReallocMem( FHandle, 0 );
end;

function TIOraDatabase.GetMaxCharParamLen: Integer;
begin
  Result := StrToIntDef( Trim(Params.Values[szMAXCHARPARAMLEN]), 255 );
end;

{ Returns LDA structure }
function TIOraDatabase.GetLdaPtr: PLdaDef;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOraConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOraConnInfo) ) ).LdaPtr;
{$ELSE}
    Result := TIOraConnInfo(FHandle^).LdaPtr;
{$ENDIF}
end;

{ Returns a pointer to CDA structure }
function TIOraDatabase.GetCurHandle: PCdaDef;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOraConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOraConnInfo) ) ).CdaPtr;
{$ELSE}
    Result := TIOraConnInfo(FHandle^).CdaPtr;
{$ENDIF}
end;

function TIOraDatabase.GetHandle: TSDPtr;
begin
	// pass a ponter to TOraLogon with LDA, HDA structure
  Result := FHandle;
end;

procedure TIOraDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF XSQL_CLR}
var
  r1, r2: TIOraConnInfo;
{$ENDIF}
begin
  if not Assigned(AHandle) then
    Exit;

  LoadSqlLib(True);

  AllocHandle;

{$IFDEF XSQL_CLR}
  r1 := TIOraConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOraConnInfo) ) );
  r2 := TIOraConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIOraConnInfo) ) );
  r1.LdaPtr := r2.LdaPtr;
  r1.HdaPtr := r2.HdaPtr;
  r1.CdaPtr := r2.CdaPtr;
  Marshal.StructureToPtr( r1, FHandle, False );
{$ELSE}
  TIOraConnInfo(FHandle^).LdaPtr := TIOraConnInfo(AHandle^).LdaPtr;
  TIOraConnInfo(FHandle^).HdaPtr := TIOraConnInfo(AHandle^).HdaPtr;
  TIOraConnInfo(FHandle^).CdaPtr := TIOraConnInfo(AHandle^).CdaPtr;
{$ENDIF}
end;

procedure TIOraDatabase.DoConnect(const ARemoteDatabase, AUserName, APassword: string);
var
  rec: TIOraConnInfo;
  szConnect: TSDCharPtr;
  sConnect: string;
begin
 	// OS Authentication, when a password is empty
  sConnect := XSOra.CreateConnectString(ARemoteDatabase, AUserName, APassword);

	// Usually LoadSqlLib is called in InitSqlDatabase
  if hSqlLibModule = 0 then
    LoadSqlLib(True);

  AllocHandle;
  try
{$IFDEF XSQL_CLR}
    rec := TIOraConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOraConnInfo) ) );
    szConnect := Marshal.StringToHGlobalAnsi( sConnect );
{$ELSE}
    rec := TIOraConnInfo( FHandle^ );
    szConnect := TSDCharPtr( sConnect );
{$ENDIF}
    try
	// logon
      Check( XSOra.olog(  rec.LdaPtr, rec.HdaPtr, szConnect, -1, nil, -1, nil, -1, OCI_LM_DEF  ) );
    finally
{$IFDEF XSQL_CLR}
      Marshal.FreeHGlobal( szConnect );
{$ENDIF}
    end;
  except
  	// to exclude OCI calls with disconnected LDA
    FreeHandle;
    FreeSqlLib;
    raise;
  end;
	// open cursor
  Check( XSOra.oopen( rec.CdaPtr, PCdaDef(rec.LdaPtr), nil, -1, -1, nil, 0  ) );

  SetDefaultOptions;
end;

procedure TIOraDatabase.DoDisconnect(Force: Boolean);
var
  rcd: TSDEResult;
begin
  if not Assigned(FHandle) then
    Exit;

  rcd := XSOra.oclose( CurHandle );
  if not Force then
    Check( rcd );

  if InTransaction then
    XSOra.orol( PCdaDef( LdaPtr ) );
	// commit is automatically issued on a successful ologof call
  rcd := XSOra.ologof( LdaPtr );
  if not Force then
    Check( rcd );

  FreeHandle;

  FreeSqlLib;
end;

function TIOraDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;

procedure TIOraDatabase.DoStartTransaction;
begin
  // nothing
end;

procedure TIOraDatabase.DoCommit;
begin
  Check( XSOra.ocom( PCdaDef( LdaPtr ) ) );

  SetTransIsolation(TransIsolation);
end;

procedure TIOraDatabase.DoRollback;
begin
  Check( XSOra.orol( PCdaDef( LdaPtr ) ) );

  SetTransIsolation(TransIsolation);
end;

procedure TIOraDatabase.SetAutoCommitOption(Value: Boolean);
begin
  if Value then
    Check( ocon( PCdaDef( LdaPtr ) ) )	// enable autocommit
  else
    Check( ocof( PCdaDef( LdaPtr ) ) );	// disable autocommit
end;

procedure TIOraDatabase.SetDefaultOptions;
begin
  if not AutoCommitDef then
    SetAutoCommitOption( AutoCommit );

  SetTransIsolation(TransIsolation);
end;

procedure TIOraDatabase.SetTransIsolation(Value: TISqlTransIsolation);
const
  IsolLevel: array[TISqlTransIsolation] of string =
  	('set transaction READ WRITE',
         'set transaction READ WRITE',
         'set transaction READ ONLY'
        );
var
  szCmd: TSDCharPtr;
begin
{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( IsolLevel[Value] );
{$ELSE}
  szCmd := TSDCharPtr( IsolLevel[Value] );
{$ENDIF}
  try
    Check( XSOra.oparse(CurHandle, szCmd, -1, DEFERRED_PARSE, ORACLE7_PARSE) );
    Check( XSOra.oexec(CurHandle) );
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal( szCmd );
{$ENDIF}
  end;
end;

function TIOraDatabase.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  Result := False;
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( SDummySelect );
    if Assigned(cmd) then
      Result := True;
  finally
    cmd.Free;
  end;
end;

function TIOraDatabase.ParamValue(Value: TXSQLDatabaseParam): Integer;
begin
  case Value of
    spMaxFieldName,
    spMaxTableName,
    spMaxSPName:	Result := 30;
    spMaxFullTableName,
    spMaxFullSPName:	Result := 2*30+1;
  else
    Result := 0;
  end;
end;

function TIOraDatabase.GetClientVersion: LongInt;
begin
  Result := dwLoadedOCI;
end;

function TIOraDatabase.GetServerVersion: LongInt;
var
  ResultSet: TStringList;
begin
  Result := 0;
  ResultSet := TStringList.Create;
  try
    GetStmtResult(SQueryOraServerVersion, ResultSet);

    if ResultSet.Count > 0 then
      Result := VersionStringToDWORD( Trim( ResultSet.Strings[0] ) );
  finally
    ResultSet.Free;
  end;
end;

function TIOraDatabase.GetVersionString: string;
var
  ResultSet: TStringList;
begin
  ResultSet := TStringList.Create;
  try
    GetStmtResult(SQueryOraVersionString, ResultSet);

    if ResultSet.Count > 0 then
      Result := ResultSet.Strings[0];
  finally
    ResultSet.Free;
  end;
end;

procedure TIOraDatabase.GetStmtResult(const Stmt: string; List: TStrings);
var
  cmd: TISqlCommand;
  s: string;
begin
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( Stmt );
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(1, s);
      if s <> '' then
        List.Add( s );
    end;
  finally
    cmd.Free;
  end;
end;

function TIOraDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
var
  sStmt, sOwner, sObj: string;
  cmd: TISqlCommand;
begin
  sStmt := '';
  case ASchemaType of
    stTables,
    stSysTables:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        if sObj = '*' then
          sObj := '';
        if sOwner = '*' then
          sOwner := '';
        if sObj <> '' then
          if ContainsLikeWildcards(sObj)
          then sStmt := sStmt + 'and OBJECT_NAME like ''' + sObj + ''' '
          else sStmt := sStmt + 'and OBJECT_NAME = ''' + sObj + ''' ';
        if sOwner <> '' then
          if ContainsLikeWildcards(sOwner)
          then sStmt := sStmt + 'and OWNER like ''' + sOwner + ''' '
          else sStmt := sStmt + 'and OWNER = ''' + sOwner + ''' ';
        if ASchemaType = stSysTables then
          sStmt := sStmt + 'and OWNER = ''SYS'' '
        else
          sStmt := sStmt + 'and OWNER <> ''SYS'' ';
        sStmt := Format(SQueryOraTableNamesFmt, [sStmt]);
      end;
    stColumns:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryOraTableFieldNamesFmt, [sOwner, sObj] );
      end;
    stProcedures:
      begin
        if AObjectName <> '' then
          sStmt := sStmt + 'and OBJECT_NAME like ''' + AObjectName + ''' ';
        sStmt := Format(SQueryOraStoredProcNamesFmt, [sStmt]);
      end;
    stIndexes:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryOraIndexNamesFmt, [sOwner, sObj, sOwner, sObj]);
      end;
  end;

  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( sStmt );
  except
    cmd.Free;
    raise;
  end;

  Result := cmd;
end;


{ TIOraCommand }
constructor TIOraCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FHandle := nil;
  FParamHandle := nil;
  FBoundParams := False;

  FIsCursorParamExists	:= False;
  FIsGetFieldDescs	:= False;
end;

destructor TIOraCommand.Destroy;
begin
  Disconnect(False);

  inherited;
end;

function TIOraCommand.GetHandle: PSDCursor;
begin
  Result := FHandle;
  if FParamHandle <> nil then
    Result := FParamHandle;
end;

function TIOraCommand.GetSqlDatabase: TIOraDatabase;
begin
  Result := (inherited SqlDatabase) as TIOraDatabase;
end;

procedure TIOraCommand.Check(Status: TSDEResult);
var
  peo: Integer;
  cda: TCdaDef;
  lda: TLdaDef;
begin
  SqlDatabase.ResetIdleTimeOut;
  if Status = 0 then
    Exit;
  SqlDatabase.ResetBusyState;
{$IFDEF XSQL_CLR}
  cda := TCdaDef( Marshal.PtrToStructure( Handle, TypeOf(TCdaDef) ) );
{$ELSE}
  cda := TCdaDef( Handle^ );
{$ENDIF}
  if cda.rc <> 0 then begin
    peo := -1;
    	// after oparse call
    if cda.fc = 54 then
      peo := cda.peo;
    OraErrorOCI7( SqlDatabase.LdaPtr, cda.rc, peo )
  end else begin
{$IFDEF XSQL_CLR}
    lda := TLdaDef( Marshal.PtrToStructure( SqlDatabase.LdaPtr, TypeOf(TLdaDef) ) );
{$ELSE}
    lda := TLdaDef( SqlDatabase.LdaPtr^ );
{$ENDIF}
    OraErrorOCI7( SqlDatabase.LdaPtr, lda.rc, -1 );
  end;
end;

procedure TIOraCommand.Connect;
begin
  FHandle := SafeReallocMem( nil, SizeOf(TCdaDef));
  try
    SafeInitMem( FHandle, SizeOf(TCdaDef), 0 );
    Check( XSOra.oopen( PCdaDef(FHandle), PCdaDef( SqlDatabase.LdaPtr ),
    				nil, -1, -1, nil, 0  ) );
  except
    FHandle := SafeReallocMem( FHandle, 0 );
    raise;
  end;
end;

procedure TIOraCommand.Disconnect(Force: Boolean);
begin
  if FieldsBuffer <> nil then
    FreeFieldsBuffer;

  if FHandle = nil then Exit;
  	// In case of hang up returns an error (for example, ORA-00028).
        //However it's a successful disconnect, so the error is not raised
  XSOra.oclose( PCdaDef(FHandle) );

  FHandle := SafeReallocMem( FHandle, 0 );
end;

function TIOraCommand.ResultSetExists: Boolean;
var
  i: Integer;
begin
  Result := GetCdaDef_ft( Handle ) in [ORA_CT_SEL];
  if Result or not Assigned(Params) then
    Exit;

  if CommandType in [ctQuery, ctStoredProc] then begin
    for i:=0 to Params.Count-1 do
    	// if PL/SQL block with a cursor parameter is executed ('begin open_proc(:v_cur); end;')
      if Params[i].DataType = ftCursor then begin
        FIsCursorParamExists := True;
        Break;
      end;
  end;
  Result := FIsCursorParamExists;
end;

function TIOraCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := Ora7RequiredCnvtFieldType(FieldType);
end;

function TIOraCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  Result := Ora7FieldDataType(ExtDataType);
end;

function TIOraCommand.NativeDataSize(FieldType: TFieldType): Word;
begin
  Result := OraNativeDataSize(FieldType);
end;

{ SQLT_AVC can bind CHAR column with and without trailing spaces in contrast to SQLT_STR.
However SQLT_AVC returns trailing spaces with Oracle7 client (not with Oracle8) }
function TIOraCommand.NativeDataType(FieldType: TFieldType): Integer;
begin
  Result := OraNativeDataType(FieldType);
end;

procedure TIOraCommand.GetFieldDescs(Descs: TSDFieldDescList);
var
  rcd, pos: sword;
  dbtype, prec, dscale, nullok: sb2;
  dbsize, dsize: sb4;
  szColHeading: TSDCharPtr;
  ColHeadingL: sb4;
  sColName: string;
  MaxColumnName: Integer;
  ft: TFieldType;
begin
  ASSERT( FHandle <> nil );
        // if Execute was not called before
  if FIsCursorParamExists and not FBoundParams then begin
    FIsGetFieldDescs := True;
    try
      Execute;	// it binds and gets(output) parameters
    finally
      FIsGetFieldDescs := False;
    end;
  end;

  MaxColumnName := SqlDatabase.MaxFieldNameLen;
  szColHeading := SafeReAllocMem( nil, MaxColumnName + 1 );	// +1 - include space for zero-terminator
  try
    pos := 1;
    while True do begin
      ColHeadingL := MaxColumnName;
      rcd := odescr(PCdaDef(Handle), pos, dbsize, dbtype,
     			szColHeading, ColHeadingL, dsize, prec, dscale, nullok);
      if rcd <> 0 then
        if GetCdaDef_rc( Handle ) = ORA_ERR_VarNotInSel
        then Break
        else Check( rcd );
      if ColHeadingL > MaxColumnName then DatabaseError(SInsufficientColumnBufSize);
      sColName := HelperPtrToString( szColHeading, ColHeadingL );

      ft := FieldDataType(dbtype);
      if ft = ftUnknown then
        DatabaseErrorFmt( SBadFieldType, [sColName] );
	// for ROWID use dsize (display size), as since ROWID binds as string
      if dbtype = SQLT_RID then dbsize := dsize;
      ft := OraExactNumberDataType( ft, prec, dscale, SqlDatabase.IsEnableInts, SqlDatabase.IsEnableBCD );

      with Descs.AddFieldDesc do begin
        FieldName	:= sColName;
        FieldNo		:= pos;
        FieldType	:= ft;
        DataType	:= dbtype;
        if IsRequiredSizeTypes(ft) then
          if not IsStringSizeIncludesZeroTerm(dbtype) then	// VARCHAR2, CHAR do not include zero-terminator in size
            DataSize	:= dsize+1
          else
            DataSize	:= dbsize
        else begin
          if ft = ftBCD then	// TBCDField.Size indicates the number digits after the decimal place
            Scale	:= dscale;

          DataSize	:= NativeDataSize(ft);	// it's significant for NUMERIC fields
        end;
        Precision	:= prec;
    	// if NullOk = 0 then null values are not permitted for the column (Required = True)
        Required	:= NullOk = 0;
      end;

      Inc(pos);
    end;

  finally
    SafeReallocMem(szColHeading, 0);
  end;
end;

{ Setting buffers for data, which selected from database }
procedure TIOraCommand.SetFieldsBuffer;
var
  i, nOffset: Integer;
  PrgDataSize: Word;
  PrgDataType: Integer;
  PrgDataBuffer: TSDCharPtr;
begin
  nOffset := 0;		// pointer to the TSDFieldInfo

  for i:=0 to FieldDescs.Count-1 do begin
    PrgDataType := NativeDataType(FieldDescs[i].FieldType);
    if PrgDataType = 0 then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );
	// returns 0 for string fields
    PrgDataSize := FieldDescs[i].DataSize;
    	// to exclude trailing spaces up column size for VARCHAR column with Oracle7 client
    if PrgDataType = SQLT_AVC then
      PrgDataType := SQLT_STR;

    PrgDataBuffer := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );
    if IsSupportedBlobTypes(FieldDescs[i].FieldType)  then begin
      if DetectedOCI73 and UsePiecewiseCalls then
        Check( odefinps(PCdaDef(Handle), 0, FieldDescs[i].FieldNo,
    		nil, MAX_LONG_COL_SIZE, PrgDataType, 0,
    		IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoFetchStatusOff ),
      		nil, 0, 0,
    		IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff ),
      		nil, 0, 0, 0, 0) )
      else
        Check( odefin(PCdaDef(Handle), FieldDescs[i].FieldNo,
        	PrgDataBuffer, 0{MAX_LONG_COL_SIZE}, PrgDataType, 0,
              	IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoFetchStatusOff ),
              	nil, -1, -1,
              	IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff ),
              	nil) );
    end else begin
      if DetectedOCI73 then
        Check( odefinps(PCdaDef(Handle), 1, FieldDescs[i].FieldNo,
    		PrgDataBuffer, PrgDataSize, PrgDataType, 0,
    		IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoFetchStatusOff ),
      		nil, 0, 0,
    		IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff ),
      		nil, 0, 0, 0, 0) )
      else
        Check( odefin(PCdaDef(Handle), FieldDescs[i].FieldNo,
        	PrgDataBuffer, PrgDataSize, PrgDataType, 0,
              	IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoFetchStatusOff ),
              	nil, -1, -1,
              	IncPtr( PrgDataBuffer, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff ),
              	nil) );
    end;	{ if DataType in SupportedBlobFields then }
    Inc(nOffset, SizeOf(TSDFieldInfo) + PrgDataSize);
  end;
end;

procedure TIOraCommand.BindParamsBuffer;
begin
  if CommandType = ctQuery then
    QBindParamsBuffer
  else if CommandType = ctStoredProc then
    SpBindParamsBuffer
  else
    DatabaseError(SNoCapability);
  FBoundParams := True;    
end;

function TIOraCommand.FetchNextRow: Boolean;
var
  rcd: sword;
begin
  rcd := XSOra.ofetch( PCdaDef(Handle) );

  SqlDatabase.ResetIdleTimeOut;

  if rcd <> 0 then
    rcd := GetCdaDef_rc(Handle);
	// get Blob field data
  if BlobFieldCount > 0 then begin
  	// use piecewise fetch for Oracle 7.3, if it's necessary
    if DetectedOCI73 and (rcd = OCI_MORE_FETCH_PIECES) then begin
      FetchBlobFields;
      Result := True;
    end else begin
      if rcd = 0 then
        FetchBlobFields;
      Result := rcd = 0;
    end;
  end else
    Result := rcd = 0;

	// if EOF, then close Cursor, returned by PL/SQL procedure
  if (not Result) and (FParamHandle <> nil) then
    CloseParamHandle;
end;

function TIOraCommand.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
begin
  Result := OraCnvtDateTime2DBDateTime(ADataType, Value, Buffer, BufSize);
end;

function TIOraCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf: TSDValueBuffer;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);
	// right trim only Ansi fixed char (CHAR)
  Result := OraCnvtDBData(AFieldDesc.FieldType ,InBuf, Buffer, BufSize,
  		(AFieldDesc.DataType = SQLT_AFC) and SqlDatabase.IsRTrimChar);
end;

function TIOraCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): LongInt;
var
  Len: ub4;       		// count of really read bytes
  Buf: TSDCharPtr;			// current pointer for read of data
  BlobSize, GrowDelta, nOffset: Integer;	// current buffer size and increment size
  Piece: Byte;
  rcd: sword;
  iter, index: ub4;
  ctxp: TSDPtr;
  dbtype: Integer;
begin
  Result := 0;
  GrowDelta := SqlDatabase.BlobPieceSize;
  BlobSize := 0;
{$IFDEF XSQL_CLR}
  Buf := SafeReallocMem(nil, GrowDelta);
{$ENDIF}
  try
  if DetectedOCI73 and UsePiecewiseCalls then begin
    repeat
      Inc(BlobSize, GrowDelta);
      SetLength(BlobData, BlobSize);
      nOffset := BlobSize-GrowDelta;
{$IFNDEF XSQL_CLR}
      Buf := @TSDCharPtr(BlobData)[nOffset];
{$ENDIF}
      Check( XSOra.ogetpi(PCdaDef(Handle), Piece, ctxp, iter, index) );
	// read from database
      Len := GrowDelta;
      Check( XSOra.osetpi(PCdaDef(Handle), Piece, Buf, Len) );
      rcd := XSOra.ofetch(PCdaDef(Handle));
{$IFDEF XSQL_CLR}
      if (Abs(rcd) = OCI_MORE_FETCH_PIECES) or (rcd = 0) then
        Marshal.Copy( Buf, BlobData, nOffset, Len );
{$ENDIF}
      Inc(Result, Len);
      if (Abs(rcd) <> OCI_MORE_FETCH_PIECES) and (rcd <> 0) then
        Check( rcd );
    until rcd = 0;
  end else begin
    repeat
      Inc(BlobSize, GrowDelta);
      SetLength(BlobData, BlobSize);
      nOffset := BlobSize-GrowDelta;
{$IFNDEF XSQL_CLR}
      Buf := @TSDCharPtr(BlobData)[nOffset];
{$ENDIF}
	// read from database
      Len := GrowDelta;
      dbtype := NativeDataType(AFieldDesc.FieldType);
      	// fetchs up to 64K starting at any offset
      Check( XSOra.oflng(PCdaDef(Handle), AFieldDesc.FieldNo, Buf, Len, dbtype, Len, BlobSize-GrowDelta) );
{$IFDEF XSQL_CLR}
      Marshal.Copy( Buf, BlobData, nOffset, Len );
{$ENDIF}
      Inc(Result, Len);
    until (Len = 0) or (Len < GrowDelta);
  end;
  SetLength(BlobData, Result);
  
  finally
{$IFDEF XSQL_CLR}
    SafeReallocMem( Buf, 0 );
{$ENDIF}
  end;
end;

function TIOraCommand.WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint;
begin
  raise EDatabaseError.CreateFmt(SFuncNotImplemented, ['TIOraCommand.WriteBlob']);
end;

function TIOraCommand.WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint;
var
  Piece: Byte;
  rcd: sword;
  iter, index: ub4;
  ctxp: TSDPtr;
begin
  Result := 0;
  if not DetectedOCI73 then
    Exit;
  while True do begin
    Check( XSOra.ogetpi(PCdaDef(Handle), Piece, ctxp, iter, index) );
	// write a block in the database as one piece
    Piece := OCI_LAST_PIECE;
    	// if bufp will equally @Buffer, and not nil(for empty buffer),
        //then for the following insert of the non-empty buffer the exception "Access violation" will be raised
        //in ORA73.dll in the time of binding of this parameter (obindps)
    if Count = 0 then
      Check( XSOra.osetpi(PCdaDef(Handle), Piece, nil, Count) )
    else
      Check( XSOra.osetpi(PCdaDef(Handle), Piece, Buffer, Count) );
    rcd := XSOra.oexec(PCdaDef(Handle));
    if rcd = 0 then
      Break
    else if rcd <> OCI_MORE_INSERT_PIECES then
      Check( rcd );
  end;
  Result := Count;
end;

		{ Query methods }

procedure TIOraCommand.QBindParamsBuffer;
var
  CurPtr, DataPtr: TSDPtr;
  FieldInfo: TSDFieldInfo;
  szSqlVar: TSDCharPtr;
  i: Integer;
  sqlvar: string;
  DataLen: Word;
begin
  if (ParamsBuffer = nil) or FBoundParams then Exit;
  CurPtr := ParamsBuffer;

  for i:=0 to Params.Count-1 do begin
    FieldInfo := GetFieldInfoStruct(CurPtr, 0);
    if Params[i].IsNull then
      FieldInfo.FetchStatus := -1
    else
      FieldInfo.FetchStatus := 0;
    FieldInfo.DataSize := 0;
    DataLen := NativeParamSize( Params[i] );
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );
	// parameter names are changed in MakeValidStatement
    sqlvar := ':' + IntToStr(i+1);
{$IFDEF XSQL_CLR}
    szSqlVar := BufList.StringToPtr(sqlvar);
{$ELSE}
    szSqlVar := TSDCharPtr( sqlvar );
{$ENDIF}
    case Params[i].DataType of
      ftString:
        if DataLen > 0 then HelperMemWriteString( DataPtr, 0, Params[i].AsString, DataLen);
      ftInteger:
        if DataLen > 0 then HelperMemWriteInt32( DataPtr, 0, Params[i].AsInteger );
      ftSmallInt:
        if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, Params[i].AsInteger );
      ftDate, ftTime, ftDateTime:
        if DataLen > 0 then
          CnvtDateTime2DBDateTime(Params[i].DataType, Params[i].AsDateTime, DataPtr, NativeDataSize(Params[i].DataType));
      ftBCD,
      ftFloat:
        if DataLen > 0 then HelperMemWriteDouble( DataPtr, 0, Params[i].AsFloat );
      ftCursor:
        begin
          FieldInfo.DataSize := 0;
    		// for avoid "invalid cursor" error, because the Oracle server
              //doesn't accept NULL as an input value for a REF Cursor type.
          if Params[i].IsNull then
            FieldInfo.FetchStatus := 0
          else
            Params[i].GetData( DataPtr );	// GetData returns nothing for DataType = ftCursor in D3, C3, D4
        end
      else
        if not IsSupportedBlobTypes(Params[i].DataType) then
          raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
    end;
    SetFieldInfoStruct( CurPtr, 0, FieldInfo );
    if IsBlobType(Params[i].DataType) then begin
      if DetectedOCI73 and UsePiecewiseCalls then
        Check( obindps(PCdaDef(Handle), 0, szSqlVar, -1, nil, MAX_LONG_COL_SIZE,
      			NativeDataType(Params[i].DataType), 0,
                      	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ), nil, nil, 0, 0, 0, 0, 0, nil, nil, 0, 0) )
      else begin
        if VarType(Params[i].Value) <> varString then
          VarAsType(Params[i].Value, varString);
        Check( obndra(PCdaDef(Handle), szSqlVar, -1,
        		{$IFDEF XSQL_CLR}BufList.StringToPtr(Params[i].AsString){$ELSE}TSDCharPtr(TVarData(Params[i].Value).VString){$ENDIF},
                        RealParamDataSize( Params[i] ),
      			NativeDataType(Params[i].DataType), -1,
                      	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ), nil, nil, 0, nil, nil, 0, 0) );
      end;
    end else begin
      if DetectedOCI73 then
        Check( obindps(PCdaDef(Handle), 1, szSqlVar, -1, DataPtr, DataLen,
      			NativeDataType(Params[i].DataType), 0,
                      	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ), nil, nil, 0, 0, 0, 0, 0, nil, nil, 0, 0) )
      else
        Check( obndra(PCdaDef(Handle), szSqlVar, -1, DataPtr, DataLen,
      			NativeDataType(Params[i].DataType), -1,
                      	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ), nil, nil, 0, nil, nil, 0, 0) );
    end;

    CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

procedure TIOraCommand.DoPrepare(Value: string);
var
  szCmd: TSDCharPtr;
begin
  if FHandle = nil then Connect;

  if CommandType = ctQuery then begin
    FStmt := MakeValidStatement( Value, Params );
{$IFDEF XSQL_CLR}
    szCmd := BufList.StringToPtr(FStmt);
{$ELSE}
    szCmd := TSDCharPtr(FStmt);
{$ENDIF}
	// it's not use deferred parse, which does not recognize
        // a statement type(SELECT or other; used in ResultSetExists) and syntax errors
    Check( XSOra.oparse(PCdaDef(Handle), szCmd, -1, 0, ORACLE7_PARSE) );
  end else if CommandType = ctStoredProc then begin
    if Assigned(Params) and (Params.Count = 0) then
      InitParamList;

    FStmt := MakeStoredProcStmt( Value, Params );
{$IFDEF XSQL_CLR}
    szCmd := BufList.StringToPtr(FStmt);
{$ELSE}
    szCmd := TSDCharPtr(FStmt);
{$ENDIF}
    Check( XSOra.oparse(PCdaDef(Handle), szCmd, -1, DEFERRED_PARSE, ORACLE7_PARSE) );
  end else
    DatabaseError(SNoCapability);

  SetNativeCommand(FStmt);
end;

procedure TIOraCommand.DoExecDirect(Value: string);
begin
  DoPrepare(Value);

  AllocParamsBuffer;
  BindParamsBuffer;

  InternalExecute;

  if FieldDescs.Count = 0 then
    InitFieldDescs;
end;

procedure TIOraCommand.DoExecute;
begin
  if CommandType in [ctQuery, ctStoredProc] then begin
    if not Assigned(FParamHandle) then
      InternalExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
    if not FIsGetFieldDescs and (FieldDescs.Count = 0) then begin
      InitFieldDescs;
      AllocFieldsBuffer;
      SetFieldsBuffer;
    end;
  end else
    Check( XSOra.oexec(PCdaDef(Handle)) );
end;

procedure TIOraCommand.InternalExecute;
var
  rcd: sword;
  i: Integer;
  sBlob: string;
begin
  rcd := XSOra.oexec(PCdaDef(Handle));
  if rcd <> 0 then
    rcd := GetCdaDef_rc(Handle);
    	// It's writing of the blob parameter
  if rcd = OCI_MORE_INSERT_PIECES then begin
    if Assigned(Params) then
      for i:=0 to Params.Count-1 do
        if IsSupportedBlobTypes(Params[i].DataType) then begin
          sBlob := Params[i].AsBlob;
          WriteBlobByName(Params[i].Name, {$IFDEF XSQL_CLR}BufList.StringToPtr(sBlob){$ELSE}TSDCharPtr(sBlob){$ENDIF}, Length(sBlob));
        end;
  end else if (rcd = OCI_MORE_FETCH_PIECES) and (CommandType = ctStoredProc) then begin	// It's reading of the blob-parameter
    DatabaseError(SNoCapability);
  end else if rcd <> 0 then
    Check( rcd );

  	// if PL/SQL block is executed
  if IsPLSQLBlockExecuted then
    InternalGetParams;
end;

{ Returns True, if PL/SQL block is executed }
function TIOraCommand.IsPLSQLBlockExecuted: Boolean;
begin
  Result := GetCdaDef_ft(Handle) = ORA_CT_PEX;
end;

function TIOraCommand.GetRowsAffected: Integer;
begin
  Result := GetCdaDef_rpc(Handle);
end;

{ Gets cursor or other output parameters }
procedure TIOraCommand.InternalGetParams;
var
  i: Integer;
  FieldInfo: TSDFieldInfo;
  FldBuf, OutData: TSDCharPtr;
  bIsNull: Boolean;
begin
  if ParamsBuffer = nil then Exit;
	// Alloc buffer for parameter of max size
  OutData := SafeReallocMem( nil, SqlDatabase.GetMaxCharParamLen );

  try
    FldBuf := ParamsBuffer;
    for i := 0 to Params.Count - 1 do begin
      FieldInfo := GetFieldInfoStruct( FldBuf, 0 );
      if ub2( FieldInfo.DataSize ) = 0 then begin
        FieldInfo.DataSize := NativeParamSize( Params[i] );
        SetFieldInfoStruct( FldBuf, 0, FieldInfo );
      end;
      if Params[i].ParamType in [ptResult, ptInputOutput, ptOutput] then begin
        if Params[i].DataType = ftCursor then begin
          if FParamHandle = nil then
            FParamHandle := {$IFDEF XSQL_CLR} IncPtr(FldBuf, SizeOf(TSDFieldInfo)) {$ELSE} PCdaDef( FldBuf + SizeOf(TSDFieldInfo) ) {$ENDIF};
        end else begin
          bIsNull := not OraCnvtDBData(Params[i].DataType, FldBuf, OutData,
                        SqlDatabase.GetMaxCharParamLen, SqlDatabase.IsRTrimChar);
          if bIsNull then
            Params[i].Clear
          else
            Params[i].SetData(OutData);
        end;
      end;
      FldBuf := IncPtr( FldBuf, FieldInfo.DataSize + SizeOf(TSDFieldInfo) );
    end;

  finally
    SafeReallocMem( OutData, 0 );
  end;
end;

	{ StoredProc methods }
procedure TIOraCommand.InitParamList;
const
  MaxSPParamCount = 50;
  MaxSPParamName = 30;
var
  rcd: sword;
  szCmd: TSDCharPtr;
  acArgname:	{$IFDEF XSQL_CLR} TSDCharPtr {$ELSE} array[0..MaxSPParamCount-1, 0..MaxSPParamName-1] of Char {$ENDIF};
  ab2Ovrld, ab2Pos, ab2Level, ab2Arnlen,
  ab2DType, ab2Prec, ab2Scale:	{$IFDEF XSQL_CLR} sb2p {$ELSE}array[0..MaxSPParamCount-1] of sb2 {$ENDIF};
  ab1Defsup, ab1Mode, ab1Radix:	{$IFDEF XSQL_CLR} ub1p {$ELSE}array[0..MaxSPParamCount-1] of ub1 {$ENDIF};
  ab4Dtsize, ab4Spare:	        {$IFDEF XSQL_CLR} ub4p {$ELSE}array[0..MaxSPParamCount-1] of ub4 {$ENDIF};
  arrsize: ub4;
  i: Integer;
  ft: TFieldType;
  pt: TSDHelperParamType;
  sParamName: string;
  function GetArgName(Index: Integer): string;
  begin
    Result := {$IFDEF XSQL_CLR} '' {$ELSE} Copy(acArgname[Index], 0, ab2Arnlen[Index]) {$ENDIF};
  end;
  function GetArgPos(Index: Integer): sb2;
  begin
    Result := {$IFDEF XSQL_CLR} HelperMemReadInt16(ab2Pos, Index*SizeOf(Result)) {$ELSE} ab2Pos[Index] {$ENDIF};
  end;
  function GetArgDType(Index: Integer): sb2;
  begin
    Result := {$IFDEF XSQL_CLR} HelperMemReadInt16(ab2DType, Index*SizeOf(Result)) {$ELSE} ab2DType[Index] {$ENDIF};
  end;
  function GetArgPrec(Index: Integer): sb2;
  begin
    Result := {$IFDEF XSQL_CLR} HelperMemReadInt16(ab2Prec, Index*SizeOf(Result)) {$ELSE} ab2Prec[Index] {$ENDIF};
  end;
  function GetArgScale(Index: Integer): sb2;
  begin
    Result := {$IFDEF XSQL_CLR} HelperMemReadInt16(ab2Scale, Index*SizeOf(Result)) {$ELSE} ab2Scale[Index] {$ENDIF};
  end;
  function GetArgMode(Index: Integer): ub1;
  begin
    Result := {$IFDEF XSQL_CLR} HelperMemReadByte(ab1Mode, Index*SizeOf(Result)) {$ELSE} ab1Mode[Index] {$ENDIF};
  end;

begin
  arrsize := MaxSPParamCount;
{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi( CommandText );
  try
    acArgname:= SafeReallocMem( nil, MaxSPParamCount*MaxSPParamName );
    ab2Ovrld := SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab2Pos   := SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab2Level := SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab2Arnlen:= SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab2DType := SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab2Prec  := SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab2Scale := SafeReallocMem( nil, MaxSPParamCount*SizeOf(sb2) );
    ab1Defsup:= SafeReallocMem( nil, MaxSPParamCount*SizeOf(ub1) );
    ab1Mode  := SafeReallocMem( nil, MaxSPParamCount*SizeOf(ub1) );
    ab1Radix := SafeReallocMem( nil, MaxSPParamCount*SizeOf(ub1) );
    ab4Dtsize:= SafeReallocMem( nil, MaxSPParamCount*SizeOf(ub4) );
    ab4Spare := SafeReallocMem( nil, MaxSPParamCount*SizeOf(ub4) );
    rcd := XSOra.odessp( PCdaDef( SqlDatabase.LdaPtr ), szCmd, -1, nil, 0, nil, 0,
  	        ab2Ovrld, ab2Pos, ab2Level, acArgname, ab2Arnlen,
                ab2Dtype, ab1Defsup, ab1Mode, ab4Dtsize, ab2Prec, ab2Scale,
                ab1Radix, ab4Spare, arrsize );
{$ELSE}
  szCmd := TSDCharPtr( CommandText );
{ ATTENTION !!!
  if parameter of the stored procedure is declared as
	OutField2 out NUMBER, then function parameters dtsize, prec, scale is equal 0(zero)
  if parameter of the stored procedure is declared as
  	OutField2 out TEST_TBL.FSTR%TYPE, then returns actual values of the function parameters
}
  rcd := XSOra.odessp( PCdaDef( SqlDatabase.LdaPtr ), szCmd, -1, nil, 0, nil, 0,
  	@ab2Ovrld[0], @ab2Pos[0], @ab2Level[0], TSDPtr(@acArgname[0]), @ab2Arnlen,
        @ab2Dtype, @ab1Defsup, @ab1Mode, @ab4Dtsize[0], @ab2Prec, @ab2Scale,
        @ab1Radix, @ab4Spare, arrsize );
{$ENDIF}

  if rcd <> 0 then
    Check( GetCdaDef_rc( PCdaDef(SqlDatabase.LdaPtr) ) );
	// In this case procedure has no parameters. It's meaningful for procedures from packages
  if (arrsize = 1) and (GetArgDtype(0) = 0) then
    Exit;

  for i:=0 to arrsize-1 do begin
    sParamName := GetArgName(i);
    ft := FieldDataType( GetArgDtype(i) );
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [sParamName] );
    ft := OraExactNumberDataType(ft, GetArgPrec(i), GetArgScale(i), SqlDatabase.IsEnableInts, SqlDatabase.IsEnableBCD);
    pt := ptUnknown;
    if GetArgPos(i) = 0 then
      pt := ptResult
    else
      case GetArgMode(i) of
        0: pt := ptInput;
        1: pt := ptOutput;
        2: pt := ptInputOutput;
      else
        DatabaseErrorFmt( SBadParameterType, [sParamName] );
      end;

    if (pt = ptResult) and (sParamName = '') then
      sParamName := SResultName;

    AddParam( sParamName, ft, pt );
  end;
  	// move Result in the end of parameters list
  for i:=0 to Params.Count-1 do
    if (Params[i].ParamType = ptResult) and (i < (Params.Count-1)) then begin
{$IFDEF XSQL_VCL4}
      Params.Items[i].Index := Params.Count-1;
{$ELSE}
      //Params.Items.Move(i, Params.Count-1);
{$ENDIF}
      Break;
    end;
  FBoundParams := False;

{$IFDEF XSQL_CLR}
  finally
    Marshal.FreeHGlobal( szCmd );
    if Assigned( acArgname) then SafeReallocMem( acArgname, 0 );
    if Assigned( ab2Ovrld ) then SafeReallocMem( ab2Ovrld , 0 );
    if Assigned( ab2Pos   ) then SafeReallocMem( ab2Pos   , 0 );
    if Assigned( ab2Level ) then SafeReallocMem( ab2Level , 0 );
    if Assigned( ab2Arnlen) then SafeReallocMem( ab2Arnlen, 0 );
    if Assigned( ab2DType ) then SafeReallocMem( ab2DType , 0 );
    if Assigned( ab2Prec  ) then SafeReallocMem( ab2Prec  , 0 );
    if Assigned( ab2Scale ) then SafeReallocMem( ab2Scale , 0 );
    if Assigned( ab1Defsup) then SafeReallocMem( ab1Defsup, 0 );
    if Assigned( ab1Mode  ) then SafeReallocMem( ab1Mode  , 0 );
    if Assigned( ab1Radix ) then SafeReallocMem( ab1Radix , 0 );
    if Assigned( ab4Dtsize) then SafeReallocMem( ab4Dtsize, 0 );
    if Assigned( ab4Spare ) then SafeReallocMem( ab4Spare , 0 );
  end;
{$ENDIF}
end;

procedure TIOraCommand.SpBindParamsBuffer;
var
  FieldInfo: TSDFieldInfo;
  CurPtr, DataPtr: TSDPtr;
  i: Integer;
  sqlvar: string;
  szSqlVar: TSDCharPtr;
  DataLen: Word;
begin
  if (ParamsBuffer = nil) or FBoundParams then Exit;
  CurPtr := ParamsBuffer;

  for i:=0 to Params.Count-1 do begin
    FieldInfo := GetFieldInfoStruct( CurPtr, 0 );
    if Params[i].IsNull then
      FieldInfo.FetchStatus := -1
    else
      FieldInfo.FetchStatus := 0;
    DataLen := NativeParamSize( Params[i] );
    FieldInfo.DataSize := 0;
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );

    sqlvar := ':' + Params[i].Name;
{$IFDEF XSQL_CLR}
    szSqlVar := BufList.StringToPtr(sqlvar);
{$ELSE}
    szSqlVar := TSDCharPtr( sqlvar );
{$ENDIF}

    case Params[i].DataType of
      ftString:
        if not Params[i].IsNull then begin
        	// DataLen is always equal MinStrParamSize+1(with '\0'), but string length may be less or more
          if DataLen > (Length(Params[i].AsString) + 1) then
            HelperMemWriteString( DataPtr, 0, Params[i].AsString, Length(Params[i].AsString)+1 )	// includes '\0'
          else begin
            HelperMemWriteString( DataPtr, 0, Params[i].AsString, DataLen);
            HelperMemWriteByte( DataPtr, DataLen-1, 0 );	// DataLen is buffer size including zero-terminator
          end;
        end;
      ftInteger:
        if not Params[i].IsNull then HelperMemWriteInt32( DataPtr, 0, Params[i].AsInteger );
      ftSmallInt:
        if not Params[i].IsNull then HelperMemWriteInt16( DataPtr, 0, Params[i].AsInteger );
      ftDate, ftTime, ftDateTime:
        if not Params[i].IsNull then
          CnvtDateTime2DBDateTime(Params[i].DataType, Params[i].AsDateTime, DataPtr, NativeDataSize(Params[i].DataType));
      ftBCD,
      ftFloat:
        if not Params[i].IsNull then HelperMemWriteDouble( DataPtr, 0, Params[i].AsFloat );
      ftCursor:
        begin
          FieldInfo.DataSize := 0;
    		// for avoid "invalid cursor" error, because the Oracle server
              //doesn't accept NULL as an input value for a REF Cursor type.
          if Params[i].IsNull then
            FieldInfo.FetchStatus := 0
          else
            Params[i].GetData( DataPtr )	// GetData returns nothing for DataType = ftCursor in D3, C3, D4
        end
      else
        if not IsSupportedBlobTypes(Params[i].DataType) then
          raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
    end;
    SetFieldInfoStruct( CurPtr, 0, FieldInfo );
    if IsBlobType(Params[i].DataType) then begin
    	// if OCI ver. >= 7.3
      if dwLoadedOCI >= MakeVerValue(7, 3) then
        Check( obindps(PCdaDef(Handle), 0, szSqlVar, -1, nil, MAX_LONG_COL_SIZE,
      			NativeDataType(Params[i].DataType), 0,
                      	IncPtr(CurPtr, GetFieldInfoFetchStatusOff), nil, nil, 0, 0, 0, 0, 0, nil, nil, 0, 0) )
      else begin
        if VarType(Params[i].Value) <> varString then
          VarAsType(Params[i].Value, varString);
        Check( obndra(PCdaDef(Handle), szSqlVar, -1,
        		{$IFDEF XSQL_CLR}BufList.StringToPtr(Params[i].AsString){$ELSE}TSDCharPtr(TVarData(Params[i].Value).VString){$ENDIF}, Params[i].GetDataSize,
      			NativeDataType(Params[i].DataType), -1,
                      	IncPtr(CurPtr, GetFieldInfoFetchStatusOff), nil, nil, 0, nil, nil, 0, 0) );
      end;
    end else begin
    	// if OCI ver. >= 7.3
      if dwLoadedOCI >= MakeVerValue(7, 3) then
        Check( obindps(PCdaDef(Handle), 1, szSqlVar, -1, DataPtr, DataLen,
      			NativeDataType(Params[i].DataType), 0,
                      	IncPtr(CurPtr, GetFieldInfoFetchStatusOff),
                        nil, nil, 0, 0, 0, 0, 0, nil, nil, 0, 0) )
      else
        Check( obndra(PCdaDef(Handle), szSqlVar, -1, DataPtr, DataLen,
      			NativeDataType(Params[i].DataType), 0,
                      	IncPtr(CurPtr, GetFieldInfoFetchStatusOff),
                      	nil, nil, 0, nil, nil, 0, 0) );
    end;
    CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

procedure TIOraCommand.GetOutputParams;
begin
  // nothing
end;


{ when a stored procedure with Cursor parameter }
procedure TIOraCommand.CloseParamHandle;
begin
  if FParamHandle = nil then Exit;
	// closing cursor, returned from stored procedure
  Check( XSOra.oclose( PCdaDef(FParamHandle) ) );
  FParamHandle := nil;
end;

procedure TIOraCommand.CloseResultSet;
begin
  FIsCursorParamExists := False;

  CloseParamHandle;
{      ???	// reset FieldDefs for stored procedure, which returns result set (has cursor parameter)
  if (CommandType = ctStoredProc) and (DataSet.FieldDefs.Count > 0) then
    DataSet.FieldDefs.Clear;
  }
end;

procedure TIOraCommand.FreeParamsBuffer;
begin
  if not FIsCursorParamExists then begin
    FBoundParams := False;
    CloseParamHandle;
  end;

  inherited;
end;


{ TIOra8Database }
constructor TIOra8Database.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle 	:= nil;
  	// procedures can have a cursor parameter
  FProcSupportsCursor := True;
	// by default IsEnableInts = False
  FIsEnableInts := UpperCase( Trim( Params.Values[szENABLEINTS] ) ) = STrueString;
	// by default IsXAConn = False
  FIsXAConn := UpperCase( Trim( Params.Values[szXACONN] ) ) = STrueString;

  FUseOCIDateTime := False;
  FTempLobSupported := False;

  // the global variable, which is used in cbf_get_long
  if LongPieceSize <> BlobPieceSize then
    LongPieceSize := BlobPieceSize;  
end;

destructor TIOra8Database.Destroy;
begin
  inherited Destroy;
end;

function TIOra8Database.GetMaxCharParamLen: Integer;
begin
  Result := StrToIntDef( Trim(Params.Values[szMAXCHARPARAMLEN]), 255 );
end;

function TIOra8Database.CreateSqlCommand: TISqlCommand;
begin
  Result := TIOra8Command.Create( Self );
end;

procedure TIOra8Database.Check(Status: TSDEResult);
begin
  CheckExt(Status, nil);
end;

procedure TIOra8Database.CheckExt(Status: TSDEResult; AStmt: POCIStmt);
begin
  ResetIdleTimeOut;

  if (Status = OCI_SUCCESS) or (Status = OCI_SUCCESS_WITH_INFO) then
    Exit;
  ResetBusyState;

  if Assigned( ErrPtr) then
    OraErrorOCI8( ErrPtr, Status, AStmt )
  else
    OraErrorOCI8( POCIError(EnvPtr), Status, AStmt );	// for OCIEnvInit and OCIHandleAlloc calls
end;

// it is important for parameter binding
function TIOra8Database.IsOra8BlobMode: Boolean;
begin
  Result := Oracle8Blobs;
end;

{ If a datatype is accessible through LOB locator }
function TIOra8Database.IsOra8BlobType(ADataType: TFieldType): Boolean;
begin
  Result := (IsBlobType(ADataType) and IsOra8BlobMode)
{$IFDEF XSQL_VCL5} or (ADataType in [ftOraBlob, ftOraClob]) {$ENDIF};
end;

function TIOra8Database.GetEnvPtr: POCIEnv;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) ).phEnv;
{$ELSE}
    Result := TIOra8ConnInfo(FHandle^).phEnv
{$ENDIF}
end;

function TIOra8Database.GetErrPtr: POCIError;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) ).phErr;
{$ELSE}
    Result := TIOra8ConnInfo(FHandle^).phErr
{$ENDIF}
end;

function TIOra8Database.GetSvcPtr:  POCISvcCtx;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) ).phSvc;
{$ELSE}
    Result := TIOra8ConnInfo(FHandle^).phSvc
{$ENDIF}
end;

function TIOra8Database.GetSrvPtr:  POCIServer;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) ).phSrv;
{$ELSE}
    Result := TIOra8ConnInfo(FHandle^).phSrv
{$ENDIF}
end;

function TIOra8Database.GetUsrPtr: POCISession;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF XSQL_CLR}
    Result := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) ).phUsr;
{$ELSE}
    Result := TIOra8ConnInfo(FHandle^).phUsr
{$ENDIF}
end;

procedure TIOra8Database.AllocHandle;
var
  rec: TIOra8ConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TIOra8Database.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.ServerType := Ord( istOracle );

{$IFDEF XSQL_CLR}
  rec.phEnv := nil;
  rec.phErr := nil;
  rec.phSvc := nil;
  rec.phSrv := nil;
  rec.phUsr := nil;

  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIOra8ConnInfo(FHandle^).ServerType := rec.ServerType;
{$ENDIF}
end;

function TIOra8Database.GetConnInfoStruct: TIOra8ConnInfo;
begin
{$IFDEF XSQL_CLR}
    Result := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) )
{$ELSE}
    Result := TIOra8ConnInfo(FHandle^)
{$ENDIF}
end;

procedure TIOra8Database.SetConnInfoStruct(Value: TIOra8ConnInfo);
begin
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( Value, FHandle, False );
{$ELSE}
  TIOra8ConnInfo(FHandle^) := Value;
{$ENDIF}
end;

procedure TIOra8Database.FreeHandle(Force: Boolean);
var
  rcd: TSDEResult;
  rec: TIOra8ConnInfo;
begin
  if not Assigned(FHandle) then
    Exit;

  rec := GetConnInfoStruct;
	// if IsXAConn is True, then phSession and phServer are not assigned
  if UsrPtr <> nil then begin
	// In case of hang up returns an error (for example, ORA-00028).
      //However it's a successful disconnect, so the error is not raised
    rcd := OCISessionEnd( SvcPtr, ErrPtr, UsrPtr, OCI_DEFAULT );
    if not Force then
      Check( rcd );
    Check( OCIHandleFree( Pdvoid(UsrPtr), OCI_HTYPE_SESSION ) );
    rec.phUsr := nil;
    SetConnInfoStruct( rec );
  end;
  if SrvPtr <> nil then begin
    rcd := OCIServerDetach( SrvPtr, ErrPtr, OCI_DEFAULT );
    if not Force then
      Check( rcd );
    Check( OCIHandleFree( Pdvoid(SrvPtr), OCI_HTYPE_SERVER ) );
    rec.phSrv := nil;
    SetConnInfoStruct( rec );
  end;
  if not IsXAConn and Assigned( SvcPtr ) then begin
    Check( OCIHandleFree( Pdvoid(SvcPtr), OCI_HTYPE_SVCCTX ) );
    rec.phSvc := nil;
    SetConnInfoStruct( rec );
  end;
	// OCI will deallocate all child handles (including FErrHandle)
  if not IsXAConn and Assigned( EnvPtr ) then begin
    Check( OCIHandleFree( Pdvoid(EnvPtr), OCI_HTYPE_ENV ) );
    rec.phEnv := nil;
    rec.phErr := nil;
    SetConnInfoStruct( rec );
  end;
  FHandle := SafeReallocMem( FHandle, 0 );
end;

function TIOra8Database.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

procedure TIOra8Database.SetHandle(AHandle: TSDPtr);
{$IFDEF XSQL_CLR}
var
  r1, r2: TIOra8ConnInfo;
{$ENDIF}
begin
  if not Assigned(AHandle) then
    Exit;

  LoadSqlLib(False);

  AllocHandle;

{$IFDEF XSQL_CLR}
  r1 := TIOra8ConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIOra8ConnInfo) ) );
  r2 := TIOra8ConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIOra8ConnInfo) ) );
  r1.phEnv := r2.phEnv;
  r1.phErr := r2.phErr;
  r1.phSvc := r2.phSvc;
  r1.phSrv := r2.phSrv;
  r1.phUsr := r2.phUsr;
  Marshal.StructureToPtr( r1, FHandle, False );
{$ELSE}
  TIOra8ConnInfo(FHandle^).phEnv := TIOra8ConnInfo(AHandle^).phEnv;
  TIOra8ConnInfo(FHandle^).phErr := TIOra8ConnInfo(AHandle^).phErr;
  TIOra8ConnInfo(FHandle^).phSvc := TIOra8ConnInfo(AHandle^).phSvc;
  TIOra8ConnInfo(FHandle^).phSrv := TIOra8ConnInfo(AHandle^).phSrv;
  TIOra8ConnInfo(FHandle^).phUsr := TIOra8ConnInfo(AHandle^).phUsr;
{$ENDIF}
end;

procedure TIOra8Database.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
  rec: TIOra8ConnInfo;
  AuthentType, SessMode: ub4;
  rc: sword;
  sRole, sNewPwd: string;
  szUser, szPwd, szNewPwd, szDb: TSDCharPtr;
  List: TStrings;
begin
	// Usually LoadSqlLib is called in InitSqlDatabase
  if hSqlLibModule = 0 then
    LoadSqlLib(False);

  AllocHandle;
  rec := GetConnInfoStruct;
  try
    if IsXAConn then begin
      if not IsAvailFunc( 'xaoEnv' ) then
        DatabaseErrorFmt( SErrFuncNotFound, ['xaoEnv'] );
      if not IsAvailFunc( 'xaoSvcCtx' ) then
        DatabaseErrorFmt( SErrFuncNotFound, ['xaoSvcCtx'] );
{$IFDEF XSQL_CLR}
      szDb := Marshal.StringToHGlobalAnsi( sRemoteDatabase );
{$ELSE}
      szDb := TSDCharPtr( sRemoteDatabase );
{$ENDIF}
      rec.phEnv := xaoEnv( szDb );
      if rec.phEnv = nil then
        DatabaseErrorFmt( SFuncFailed, ['xaoEnv'] );
      rec.phSvc := xaoSvcCtx( szDb );
      if rec.phSvc = nil then
        DatabaseErrorFmt( SFuncFailed, ['xaoSvcCtx'] );

      Check( OCIHandleAlloc( Pdvoid(EnvPtr), Pdvoid(rec.phErr), OCI_HTYPE_ERROR, 0, nil ) );
      SetConnInfoStruct( rec );
    end else begin
      if not IsAvailFunc( 'OCIEnvCreate' ) then
        Check( OCIEnvInit( rec.phEnv, OCI_DEFAULT, 0, nil ) )
      else
        Check( OCIEnvCreate( rec.phEnv, OCI_THREADED or OCI_OBJECT, nil, nil, nil, nil, 0, nil ) );
      SetConnInfoStruct( rec );
      Check( OCIHandleAlloc( Pdvoid(EnvPtr), Pdvoid(rec.phErr), OCI_HTYPE_ERROR, 0, nil ) );
      Check( OCIHandleAlloc( Pdvoid(EnvPtr), Pdvoid(rec.phSvc), OCI_HTYPE_SVCCTX, 0, nil ) );
      Check( OCIHandleAlloc( Pdvoid(EnvPtr), Pdvoid(rec.phSrv), OCI_HTYPE_SERVER, 0, nil ) );
      SetConnInfoStruct( rec );
{$IFDEF XSQL_CLR}
      szDb  := Marshal.StringToHGlobalAnsi( sRemoteDatabase );
      szUser:= Marshal.StringToHGlobalAnsi( sUserName );
      szPwd := Marshal.StringToHGlobalAnsi( sPassword );
{$ELSE}
      szDb  := TSDCharPtr( sRemoteDatabase );
      szUser:= TSDCharPtr( sUserName );
      szPwd := TSDCharPtr( sPassword );
{$ENDIF}
      Check( OCIServerAttach( SrvPtr, ErrPtr, szDb, Length(sRemoteDatabase), OCI_DEFAULT ) );
      Check( OCIAttrSet( Pdvoid(SvcPtr), OCI_HTYPE_SVCCTX, Pdvoid(SrvPtr), 0, OCI_ATTR_SERVER, ErrPtr) );

      Check( OCIHandleAlloc( Pdvoid(EnvPtr), Pdvoid(rec.phUsr), OCI_HTYPE_SESSION, 0, nil ) );
      SetConnInfoStruct( rec );
      Check( OCIAttrSet( Pdvoid(UsrPtr), OCI_HTYPE_SESSION, Pdvoid( szUser ), Length(sUserName), OCI_ATTR_USERNAME, ErrPtr) );
      Check( OCIAttrSet( Pdvoid(UsrPtr), OCI_HTYPE_SESSION, Pdvoid( szPwd ), Length(sPassword), OCI_ATTR_PASSWORD, ErrPtr) );
    	// OS Authentication, when a password is empty (name of the current OS user is used)
      if Trim(sPassword) = ''
      then AuthentType := OCI_CRED_EXT
      else AuthentType := OCI_CRED_RDBMS;
      sRole := Trim( Params.Values[szROLENAME] );
      if sRole = 'SYSDBA' then
        SessMode := OCI_SYSDBA
      else if sRole = 'SYSOPER' then
        SessMode := OCI_SYSOPER
      else
        SessMode := OCI_DEFAULT;
      Check( OCIAttrSet( Pdvoid(SvcPtr), OCI_HTYPE_SVCCTX, Pdvoid(UsrPtr), 0, OCI_ATTR_SESSION, ErrPtr) );
      rc := OCISessionBegin( SvcPtr, ErrPtr, UsrPtr, AuthentType, SessMode );

      if (rc = OCI_ERROR) and (OCI8ErrorCode(ErrPtr, rc) = ORA_ERR_PASSWORD_EXPIRED) and (Trim( Params.Values[szNEWPASSWORD] ) <> '') then begin
        sNewPwd := Trim( Params.Values[szNEWPASSWORD] );
{$IFDEF XSQL_CLR}
        szNewPwd := Marshal.StringToHGlobalAnsi( sNewPwd );
{$ELSE}
        szNewPwd  := TSDCharPtr( sNewPwd );
{$ENDIF}
        Check( OCIPasswordChange( SvcPtr, ErrPtr, szUser, Length(sUserName),
                szPwd, Length(sPassword), szNewPwd, Length(sNewPwd), OCI_AUTH )
        );
      end else
        Check( rc );
    end;
  finally
{$IFDEF XSQL_CLR}
    if Assigned( szDb ) then Marshal.FreeHGlobal( szDb );
    if Assigned( szUser ) then Marshal.FreeHGlobal( szUser );
    if Assigned( szPwd ) then Marshal.FreeHGlobal( szPwd );
    if Assigned( szNewPwd ) then Marshal.FreeHGlobal( szNewPwd );
{$ENDIF}
  end;

  SetTransIsolation(TransIsolation);
	// if new Oracle9 datetype (TIMESTAMP) is supported, get the currrent session's time zone
  FUseOCIDateTime := (GetMajorVer(GetServerVersion) >= 9) and (GetMajorVer(GetClientVersion) >= 9);
  FTempLobSupported := FUseOCIDateTime;         // to simplify. In really it's supported since v.8.1.6
  if FUseOCIDateTime then begin
    List := TStringList.Create;
    try
      GetStmtResult('select sessiontimezone from dual', List);
      if List.Count > 0 then
        FSessTimeZone := List[0];
    finally
      List.Free;
    end;
  end;
end;

procedure TIOra8Database.DoDisconnect(Force: Boolean);
begin
  if Assigned(FHandle) then begin
    if InTransaction then
      OCITransRollback( SvcPtr, ErrPtr, OCI_DEFAULT );
	// the current transaction is implicitly committed by OCISessionEnd call
    FreeHandle( Force );
  end;

  FreeSqlLib;
end;

function TIOra8Database.IsLocFieldSubType(ASubType: Word): Boolean;
begin
  Result := ASubType in [fldstHMEMO, fldstHBINARY, fldstHCFILE, fldstHBFILE];
end;

procedure TIOra8Database.DoStartTransaction;
begin

end;

procedure TIOra8Database.DoCommit;
begin
  Check( OCITransCommit( SvcPtr, ErrPtr, OCI_DEFAULT ) );
end;

procedure TIOra8Database.DoRollback;
begin
  Check( OCITransRollback( SvcPtr, ErrPtr, OCI_DEFAULT ) );
end;

{ READ COMMITTED is the default Oracle transaction behaviour. For info: SERIALIZABLE: DML command will fail if the resource is locked by other transaction }
procedure TIOra8Database.SetTransIsolation(Value: TISqlTransIsolation);
const
  IsolLevel: array[TISqlTransIsolation] of string =
  	('set transaction READ WRITE',
         'set transaction READ WRITE',
         'set transaction READ ONLY'
        );
var
  cmd: TISqlCommand;
begin
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( IsolLevel[Value] );
  finally
    cmd.Free;
  end;
end;

function TIOra8Database.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  Result := False;
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( SDummySelect );
    if Assigned(cmd) then
      Result := True;
  finally
    cmd.Free;
  end;
end;

procedure TIOra8Database.SetAutoCommitOption(Value: Boolean);
begin
  { nothing }
end;

function TIOra8Database.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;

function TIOra8Database.GetClientVersion: LongInt;
begin
  Result := dwLoadedOCI;
end;

function TIOra8Database.GetServerVersion: LongInt;
var
  ResultSet: TStringList;
begin
  Result := 0;
  ResultSet := TStringList.Create;
  try
    GetStmtResult(SQueryOraServerVersion, ResultSet);

    if ResultSet.Count > 0 then
      Result := VersionStringToDWORD( Trim( ResultSet.Strings[0] ) );
  finally
    ResultSet.Free;
  end;
end;

function TIOra8Database.GetVersionString: string;
var
  ResultSet: TStringList;
begin
  ResultSet := TStringList.Create;
  try
    GetStmtResult(SQueryOraVersionString, ResultSet);

    if ResultSet.Count > 0 then
      Result := ResultSet.Strings[0];
  finally
    ResultSet.Free;
  end;
end;

function TIOra8Database.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
var
  sStmt, sOwner, sObj: string;
  cmd: TISqlCommand;
begin
  sStmt := '';
  case ASchemaType of
    stTables,
    stSysTables:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        if sObj = '*' then
          sObj := '';
        if sOwner = '*' then
          sOwner := '';
        if sObj <> '' then
          if ContainsLikeWildcards(sObj)
          then sStmt := sStmt + 'and OBJECT_NAME like ''' + sObj + ''' '
          else sStmt := sStmt + 'and OBJECT_NAME = ''' + sObj + ''' ';
        if sOwner <> '' then
          if ContainsLikeWildcards(sOwner)
          then sStmt := sStmt + 'and OWNER like ''' + sOwner + ''' '
          else sStmt := sStmt + 'and OWNER = ''' + sOwner + ''' ';
        if ASchemaType = stSysTables then
          sStmt := sStmt + 'and OWNER = ''SYS'' '
        else
          sStmt := sStmt + 'and OWNER <> ''SYS'' ';
        sStmt := Format(SQueryOraTableNamesFmt, [sStmt]);
      end;
    stColumns:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryOraTableFieldNamesFmt, [sOwner, sObj] );
      end;
    stProcedures:
      begin
        if AObjectName <> '' then
          sStmt := sStmt + 'and OBJECT_NAME like ''' + AObjectName + ''' ';
        sStmt := Format(SQueryOraStoredProcNamesFmt, [sStmt]);
      end;
    stIndexes:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryOraIndexNamesFmt, [sOwner, sObj, sOwner, sObj]);
      end;
  end;

  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( sStmt );
  except
    cmd.Free;
    raise;
  end;
  
  Result := cmd;
end;

procedure TIOra8Database.GetStmtResult(const Stmt: string; List: TStrings);
var
  cmd: TISqlCommand;
  s: string;
begin
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect( Stmt );
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(1, s);
      if s <> '' then
        List.Add( s );
    end;
  finally
    cmd.Free;
  end;
end;

{ TIOra8LobParams is used to apply CLOB/BLOB parameters through callback
 (binding, get LOB locators and update CLOB/BLOB column using locators) }
constructor TIOra8LobParams.Create(ASqlDatabase: TIOra8Database);
var
  rec: TBindLobRec;
begin
  inherited Create;

  FExternalLobPtr := False;
  rec.EnvPtr    := ASqlDatabase.EnvPtr;
  rec.ErrPtr    := ASqlDatabase.ErrPtr;
  rec.ColCount  := 0;
  rec.RowCount  := 0;
  rec.BindInfoPtr:=nil;
  rec.LobLocPtr := nil;
  rec.LobLenPtr := nil;
  FBindLobPtr := SafeReallocMem( nil, SizeOf(TBindLobRec) );
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( rec, FBindLobPtr, False );
{$ELSE}
  TBindLobRec( FBindLobPtr^ ) := rec;
{$ENDIF}
end;

constructor TIOra8LobParams.Create(ABindLobPtr: TSDPtr);
begin
  inherited Create;

  FBindLobPtr := ABindLobPtr;
  FExternalLobPtr := True;
end;

destructor TIOra8LobParams.Destroy;
begin
  if not FExternalLobPtr then
    SetLobArraySize(0, 0);

  inherited;
end;

function TIOra8LobParams.GetColCount: Integer;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).ColCount;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).ColCount;
{$ENDIF}
end;

function TIOra8LobParams.GetRowCount: Integer;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).RowCount;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).RowCount;
{$ENDIF}
end;

function TIOra8LobParams.GetEnvPtr: POCIEnv;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).EnvPtr;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).EnvPtr;
{$ENDIF}
end;

function TIOra8LobParams.GetErrPtr: POCIError;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).ErrPtr;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).ErrPtr;
{$ENDIF}
end;

function TIOra8LobParams.GetBindInfoPtr: TSDPtr;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).BindInfoPtr;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).BindInfoPtr;
{$ENDIF}
end;

function TIOra8LobParams.GetLobLenArrayPtr: TSDPtr;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).LobLenPtr;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).LobLenPtr;
{$ENDIF}
end;

function TIOra8LobParams.GetLobLocArrayPtr: TSDPtr;
begin
{$IFDEF XSQL_CLR}
  Result := TBindLobRec( Marshal.PtrToStructure( FBindLobPtr, TypeOf(TBindLobRec) ) ).LobLocPtr;
{$ELSE}
  Result := TBindLobRec( FBindLobPtr^ ).LobLocPtr;
{$ENDIF}
end;

function TIOra8LobParams.GetBindInfo(Index: Integer): TBindLobInfo;
var
  p: dvoid;
begin
  p := IncPtr( GetBindInfoPtr, Index * SizeOf(Result) );
{$IFDEF XSQL_CLR}
  Result := TBindLobInfo( Marshal.PtrToStructure( p, TypeOf(TBindLobInfo) ) );
{$ELSE}
  Result := TBindLobInfo( p^ );
{$ENDIF}
end;

procedure TIOra8LobParams.SetBindInfo(Index: Integer; Value: TBindLobInfo);
var
  p: dvoid;
begin
  p := IncPtr( GetBindInfoPtr, Index * SizeOf(Value) );
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( Value, p, False );
{$ELSE}
  TBindLobInfo( p^ ) := Value;
{$ENDIF}
end;

{
function TIOra8LobParams.GetAddrLobInfo(iRow, iCol: Integer): TSDPtr;
begin
  Result := IncPtr(GetLobLocArrayPtr, iRow*ColCount*SizeOf(Result) + iCol*SizeOf(Result));
end;

function TIOra8LobParams.GetAddrLobInfoLoc(iRow, iCol: Integer): TSDPtr;
begin
  Result := GetAddrLobInfo( iRow, iCol );
end;
 }
function TIOra8LobParams.GetAddrLobLen(iRow, iCol: Integer): TSDPtr;
begin
  Result := IncPtr( GetLobLenArrayPtr, iRow*ColCount*SizeOf(ub4) + iCol*SizeOf(ub4) );
end;

function TIOra8LobParams.GetLobLocator(iRow, iCol: Integer): POCILobLocator;
var
  p: dvoid;
begin
  Result := nil;
  if GetLobLocArrayPtr = nil then
    Exit;
    
  p := IncPtr(GetLobLocArrayPtr, iRow*ColCount*SizeOf(Result) + iCol*SizeOf(Result));
{$IFDEF XSQL_CLR}
  Result := POCILobLocator( Marshal.PtrToStructure( p, TypeOf(POCILobLocator) ) );
{$ELSE}
  Result := POCILobLocator( p^ );
{$ENDIF}
end;

// iRow - row(record) index; iCol - column (LOB parameter) index
procedure TIOra8LobParams.SetLobLocator(iRow, iCol: Integer; Value: POCILobLocator);
var
  p: dvoid;
begin
  p := IncPtr(GetLobLocArrayPtr, iRow*ColCount*SizeOf(Value) + iCol*SizeOf(Value));
{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( Value, p, False );
{$ELSE}
  POCILobLocator( p^ ) := Value;
{$ENDIF}
end;

// ARows - count of modified records; ACols - number of LOB parameter in the statement
procedure TIOra8LobParams.SetLobArraySize(ARows, ACols: Integer);
var
  i, j: Integer;
  bIsColCountChanged, bIsRowCountChanged: Boolean;
  rec: TBindLobRec;
  phLoc: POCILobLocator;
begin
{$IFDEF XSQL_CLR}
  rec := TBindLobRec( Marshal.PtrToStructure(FBindLobPtr, TypeOf(TBindLobRec)) );
{$ELSE}
  rec := TBindLobRec( FBindLobPtr^ );
{$ENDIF}
	// free TIOra8LobParams structure
  if (ARows = 0) and (ACols = 0)  then begin
    	// free arrays
    for j:=0 to rec.RowCount-1 do
      for i:=0 to rec.ColCount-1 do begin
        phLoc := GetLobLocator(j, i);
        if Assigned(phLoc) then
          Ora8Check( OCIDescriptorFree( Pdvoid(phLoc), OCI_DTYPE_LOB ), ErrPtr );
      end;
    rec.LobLenPtr := SafeReallocMem( rec.LobLenPtr, 0 );
    rec.LobLocPtr := SafeReallocMem( rec.LobLocPtr, 0 );
    if Assigned( rec.BindInfoPtr ) then
      rec.BindInfoPtr := SafeReallocMem( rec.BindInfoPtr, 0 );

{$IFDEF XSQL_CLR}
    Marshal.StructureToPtr( rec, FBindLobPtr, False );
{$ELSE}
    TBindLobRec( FBindLobPtr^ ) := rec;
{$ENDIF}
    Exit;
  end;
  	// it's impossible to reside arrays (only alloc or free)
  ASSERT(
  	( (ACols = 0) or ((ACols > 0) and ((rec.ColCount = 0) or (rec.ColCount = ACols))) ) and
    	( (ARows = 0) or ((ARows > 0) and ((rec.RowCount = 0) or (rec.RowCount = ARows))) )
  );

  bIsRowCountChanged := ARows <> rec.RowCount;
  if ARows <> rec.RowCount then
    rec.RowCount := ARows;

  bIsColCountChanged := ACols <> rec.ColCount;
  if ACols <> rec.ColCount then begin
    rec.ColCount := ACols;
    rec.BindInfoPtr := SafeReallocMem( rec.BindInfoPtr, rec.ColCount * SizeOf(TBindLobInfo) );
    	// in case of ColCount = 0
    if Assigned( rec.BindInfoPtr ) then
      SafeInitMem( rec.BindInfoPtr, rec.ColCount * SizeOf(TBindLobInfo), 0 );
{$IFDEF XSQL_CLR}
    Marshal.StructureToPtr( rec, FBindLobPtr, False );
{$ELSE}
    TBindLobRec( FBindLobPtr^ ) := rec;
{$ENDIF}
  end;
	// alloc array for descriptors, if any array size was changed
  if (rec.ColCount > 0) and (rec.RowCount > 0) and
     (bIsColCountChanged or bIsRowCountChanged)
  then begin
        // alloc and init rec.LobLenPtr and rec.LobLocPtr
    rec.LobLenPtr := SafeReallocMem( rec.LobLenPtr, rec.RowCount*rec.ColCount*SizeOf(ub4) );
    SafeInitMem( rec.LobLenPtr, rec.RowCount*rec.ColCount*SizeOf(ub4), 0 );
    rec.LobLocPtr := SafeReallocMem( rec.LobLocPtr, rec.RowCount*rec.ColCount*SizeOf(POCILobLocator) );
    SafeInitMem( rec.LobLocPtr, rec.RowCount*rec.ColCount*SizeOf(POCILobLocator), 0 );
{$IFDEF XSQL_CLR}
    Marshal.StructureToPtr( rec, FBindLobPtr, False );
{$ELSE}
    TBindLobRec( FBindLobPtr^ ) := rec;
{$ENDIF}
    for j:=0 to rec.RowCount-1 do
      for i:=0 to rec.ColCount-1 do begin
        phLoc := GetLobLocator(j, i);
        Ora8Check( OCIDescriptorAlloc( Pdvoid(EnvPtr), Pdvoid(phLoc), OCI_DTYPE_LOB, 0, nil ), ErrPtr );
        SetLobLocator(j, i, phLoc);
        HelperMemWriteInt32(GetAddrLobLen(j, i), 0, SizeOf(POCILobLocator));
      end;
  end;
end;

{ TIOra8Command }
constructor TIOra8Command.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FHandle	:= nil;
  FParamHandle	:= nil;
  FBindLobs     := nil;
  FStmt		:= '';
  FBoundParams	:= False;
  FIsGetFieldDescs	:= False;
  FIsCursorParamExists	:= False;
end;

destructor TIOra8Command.Destroy;
begin
  inherited;
end;

function TIOra8Command.GetHandle: PSDCursor;
begin
  Result := FHandle;
  if FParamHandle <> nil then
    Result := FParamHandle;
end;

function TIOra8Command.GetErrPtr: POCIError;
begin
  Result := SqlDatabase.ErrPtr;
end;

function TIOra8Command.GetSvcPtr: POCISvcCtx;
begin
  Result := SqlDatabase.SvcPtr;
end;

function TIOra8Command.GetSqlDatabase: TIOra8Database;
begin
  Result := (inherited SqlDatabase) as TIOra8Database;
end;

function TIOra8Command.GetTempLobSupported: Boolean;
begin
  Result := SqlDatabase.TempLobSupported;
end;

procedure TIOra8Command.Check(Status: TSDEResult);
begin
  SqlDatabase.Check( Status );
end;

procedure TIOra8Command.CheckStmt(Status: TSDEResult);
begin
  SqlDatabase.CheckExt( Status, Handle );
end;

procedure TIOra8Command.Connect;
begin
  Check( OCIHandleAlloc( Pdvoid(SqlDatabase.EnvPtr), Pdvoid(FHandle), OCI_HTYPE_STMT, 0, nil ) );
end;

procedure TIOra8Command.Disconnect(Force: Boolean);
begin
  if FHandle = nil then
    Exit;

  if Assigned(FBindLobs) then begin
    FBindLobs.Free;
    FBindLobs := nil
  end;
  
  Check( OCIHandleFree( Pdvoid(FHandle), OCI_HTYPE_STMT ) );
  FHandle := nil;
end;

procedure TIOra8Command.CloseParamHandle;
begin
  if FParamHandle = nil then
    Exit;

  Check( OCIHandleFree( Pdvoid(FParamHandle), OCI_HTYPE_STMT ) );
  FParamHandle := nil;
end;

procedure TIOra8Command.CloseResultSet;
begin
  FIsCursorParamExists := False;

  CloseParamHandle;
end;

procedure TIOra8Command.Execute;
begin
  inherited;
        // it is necessary to call right now, while parameter's values are not changed
        //else if parameters will be changed (Value or DataType) NativeParamSize will return invalid values for old buffer
  FreeParamsBuffer;
end;

// it has to be called before changing parameters or after execute
procedure TIOra8Command.FreeParamsBuffer;
var
  CurPtr, DataPtr: TSDValueBuffer;
  i: Integer;
  DataLen: sb4;
  phDateTime: POCIDateTime;
  phLob: POCILobLocator;
begin
  if not FIsCursorParamExists  then begin
    FBoundParams := False;

    CloseParamHandle;
  end;

  if (CommandType in [ctQuery, ctStoredProc]) and Assigned(ParamsBuffer) then begin
    CurPtr := ParamsBuffer;
    for i:=0 to Params.Count-1 do begin
{     28.02.2005:  it seems it is not necessary now
      FieldInfo := GetFieldInfoStruct( CurPtr, 0 );
      FieldInfo.DataSize := 0;
      SetFieldInfoStruct( CurPtr, 0, FieldInfo );
}
        // Note, NativeParamSize will return differen values between Open/Close(Alloc/FreeParamsBuffer), if value or type of parameter will be changed in this period 
      DataLen := NativeParamSize( Params[i] );
      DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );
      if IsOra8BlobType(Params[i].DataType) and TempLobSupported then begin
        phLob := HelperMemReadPtr( DataPtr, 0 );		// POCILobLocator(DataPtr)^;
        if Assigned( phLob ) then begin
          Check( OCIDescriptorFree( Pdvoid(phLob), OCI_DTYPE_LOB ) );// Free the lob locator, which was used to modify LOB
          HelperMemWritePtr( DataPtr, 0, nil );	    		// POCILobLocator(DataPtr^) := nil;
        end;
      end else if (Params[i].DataType = ftDateTime) and SqlDatabase.UseOCIDateTime then begin
        phDateTime := POCIDateTime( HelperMemReadPtr( DataPtr, 0 ) ); 	// POCIDateTime(DataPtr^);
        if Assigned( phDateTime ) then begin
          Check( OCIDescriptorFree( Pdvoid(phDateTime), GetOCIDateTimeDesc(SQLT_TIMESTAMP) ) );
          HelperMemWritePtr( DataPtr, 0, nil );					// POCIDateTime(DataPtr^) := nil;
        end;
      end;

      CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
    end;
  end;

  inherited;
end;

function TIOra8Command.IsOra8BlobDataType(ExtDataType: Integer): Boolean;
begin
  Result := False;
  case ExtDataType of
    SQLT_LNG,	// LONG
    SQLT_LBI:	// LONG RAW
      ;
    SQLT_CLOB, 	// character lob
    SQLT_BLOB, 	// binary lob
    SQLT_CFILE,	// locator to a character file
    SQLT_BFILE:	// locator to a binary file
      Result := True;
  else
    ASSERT(False, 'TIOra8Command.IsOra8BlobDataType');
  end;
end;

{ Is this datatype locator to a file ? }
function TIOra8Command.IsFileLocDataType(ExtDataType: Integer): Boolean;
begin
  case ExtDataType of
    SQLT_CFILE,
    SQLT_BFILE:
      Result := True;
  else
    Result := False;
  end;
end;

{ Is Oracle9i INTERVAL datatypes, which is displayed as TBCDField ? }
function TIOra8Command.IsInterval(FieldDesc: TSDFieldDesc): Boolean;
begin
        //TBCDField has up 4 digits after decimal point. However fraction of seconds could be more then 4 digits (up 6 for Informix).
        //TFloatField can not display numbers, like xxxx*10^8 (up 12 significant digits before decimal place and 6 decimal places).
  Result := (FieldDesc.FieldType = ftBCD) and
        ((FieldDesc.DataType = SQLT_INTERVAL_YM) or (FieldDesc.DataType = SQLT_INTERVAL_DS));
end;

{ Is Oracle9i datetime datatypes ANSI Date, TIME, TIMESTAMP, TIMESTAMP WITH TIME ZONE/LOCAL TZ,
which use OCIDateTime structure ? }
function TIOra8Command.IsOra9DateTime(ExtDataType: Integer): Boolean;
begin
  case ExtDataType of
    SQLT_DATE,
    SQLT_TIME,
    SQLT_TIME_TZ,
    SQLT_TIMESTAMP,
    SQLT_TIMESTAMP_TZ,
    SQLT_TIMESTAMP_LTZ: Result := True
  else
    Result := False;
  end;
end;

{ Returns OCI descriptor types for Oracle9i datetime types }
function TIOra8Command.GetOCIDateTimeDesc(ExtDataType: Integer): ub4;
begin
  case ExtDataType of
    SQLT_DATE:		Result := OCI_DTYPE_DATE;
    SQLT_TIME:		Result := OCI_DTYPE_TIME;
    SQLT_TIME_TZ:	Result := OCI_DTYPE_TIME_TZ;
    SQLT_TIMESTAMP: 	Result := OCI_DTYPE_TIMESTAMP;
    SQLT_TIMESTAMP_TZ: 	Result := OCI_DTYPE_TIMESTAMP_TZ;
    SQLT_TIMESTAMP_LTZ: Result := OCI_DTYPE_TIMESTAMP_LTZ;
    SQLT_INTERVAL_YM:   Result := OCI_DTYPE_INTERVAL_YM;
    SQLT_INTERVAL_DS:   Result := OCI_DTYPE_INTERVAL_DS;
  else
    Result := 0;
  end;
end;

function TIOra8Command.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
  	// Oracle8 ROWID
    SQLT_RDD: Result := ftString;
                // character lob
    SQLT_CLOB,
    SQLT_CFILE:	Result :=
        {$IFDEF XSQL_VCL5}ftOraClob
        {$ELSE}         ftMemo {$ENDIF};
                // binary lob
    SQLT_BLOB,
    SQLT_BFILE:  Result :=
        {$IFDEF XSQL_VCL5}ftOraBlob
        {$ELSE}         ftBlob {$ENDIF};
    SQLT_DATE:	Result := ftDate;			// Oracle9i ANSI DATE
    SQLT_TIMESTAMP,
    SQLT_TIMESTAMP_TZ,
    SQLT_TIMESTAMP_LTZ: Result :=ftDateTime;   		// Oracle9i TIMESTAMP, TIMESTAMP WITH TIME ZONE/LOCAL TZ
    SQLT_INTERVAL_YM,
    SQLT_INTERVAL_DS: Result := ftBCD;
  else
    Result := Ora7FieldDataType( ExtDataType );
  end;
end;

function TIOra8Command.NativeDataSize(FieldType: TFieldType): Word;
begin
  if FieldType = ftCursor then
    Result := SizeOf( POCIStmt )	// REF CURSOR datatype for OCI8
  else if (FieldType = ftDateTime) and SqlDatabase.UseOCIDateTime then
    Result := SizeOf(OCIDateTime)
  else
    Result := OraNativeDataSize(FieldType);
end;

function TIOra8Command.NativeDataType(FieldType: TFieldType): Integer;
begin
  case FieldType of
    ftCursor:
      Result := SQLT_RSET;
    ftBlob:
      if SqlDatabase.IsOra8BlobMode
      then Result := SQLT_BLOB
      else Result := OraNativeDataType(FieldType);
    ftMemo:
      if SqlDatabase.IsOra8BlobMode
      then Result := SQLT_CLOB
      else Result := OraNativeDataType(FieldType);
  else
    if (FieldType = ftDateTime) and SqlDatabase.UseOCIDateTime then
      Result := SQLT_TIMESTAMP
    else
      Result := OraNativeDataType(FieldType);
  end;
end;

function TIOra8Command.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  if IsOra8BlobType(FieldType) then
    Result := True
  else
    Result := Ora7RequiredCnvtFieldType(FieldType);
end;

procedure TIOra8Command.GetFieldDescs(Descs: TSDFieldDescList);
var
  ft: TFieldType;
  FieldDesc: TSDFieldDesc;
  i, NumCols: ub4;
  phCol: POCIParam;
  dtype, dsize: ub2;
  dispsize: sb4;
  dscale: sb1;
  prec, NullOk: ub1;
  szColName: TSDCharPtr;
  sColName: string;
  ColNameLen, MaxColNameLen: ub4;
begin
	// if Execute was not called before, then get describe info only, if it's possible
  if not FBoundParams then
    if IsSelectStmt then
      CheckStmt( OCIStmtExecute( SvcPtr, FHandle, ErrPtr, 0, 0, nil, nil, OCI_DESCRIBE_ONLY ) )
    else if FIsCursorParamExists then begin
      FIsGetFieldDescs	:= True;
      try
        Execute;	// it binds and gets(output) parameters
      finally
        FIsGetFieldDescs	:= False;
      end;
    end;

	// get column number
  Check( OCIAttrGet( Pdvoid(Handle), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}NumCols, nil, OCI_ATTR_PARAM_COUNT, ErrPtr) );
  MaxColNameLen := SqlDatabase.MaxFieldNameLen;

  for i:=1 to NumCols do begin
    Check( OCIParamGet( Pdvoid(Handle), OCI_HTYPE_STMT, ErrPtr, Pdvoid(phCol), i ) );

    szColName := nil;
    Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFDEF XSQL_CLR}szColName, ColNameLen{$ELSE}dvoid(@szColName), @ColNameLen{$ENDIF}, OCI_ATTR_NAME, ErrPtr) );
    Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFNDEF XSQL_CLR}@{$ENDIF}dtype, nil, OCI_ATTR_DATA_TYPE, ErrPtr) );
    Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFNDEF XSQL_CLR}@{$ENDIF}dsize, nil, OCI_ATTR_DATA_SIZE, ErrPtr) );
    Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFNDEF XSQL_CLR}@{$ENDIF}prec, nil, OCI_ATTR_PRECISION, ErrPtr) );
    Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFNDEF XSQL_CLR}@{$ENDIF}dscale, nil, OCI_ATTR_SCALE, ErrPtr) );
    Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFNDEF XSQL_CLR}@{$ENDIF}NullOk, nil, OCI_ATTR_IS_NULL, ErrPtr) );
    sColName := {$IFDEF XSQL_CLR} Marshal.PtrToStringAnsi( szColName, MinIntValue(ColNameLen, MaxColNameLen) ) {$ELSE} Copy( szColName, 1, MinIntValue(ColNameLen, MaxColNameLen) ) {$ENDIF};
    ft := FieldDataType(dtype);
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [sColName] );
    ft := OraExactNumberDataType(ft, prec, dscale, SqlDatabase.IsEnableInts, SqlDatabase.IsEnableBCD);
	// in case of Oracle8 ROWID, is selected as string, get size of character form (which size can be different)
    if dtype = SQLT_RDD then begin
      Check( OCIAttrGet( Pdvoid(phCol), OCI_DTYPE_PARAM,
    			 {$IFNDEF XSQL_CLR}@{$ENDIF}dispsize, nil, OCI_ATTR_DISP_SIZE, ErrPtr) );
      dsize := dispsize;
    end;

    FieldDesc := Descs.AddFieldDesc;
    with FieldDesc do begin
      FieldName		:= sColName;
      FieldNo		:= i;
      FieldType		:= ft;
      DataType		:= dtype;
      if IsRequiredSizeTypes( ft ) then
        if not IsStringSizeIncludesZeroTerm(dtype) then	// VARCHAR2, CHAR do not include zero-terminator in size
          DataSize	:= dsize+1
        else
          DataSize	:= dsize
      else if (FieldType = ftDateTime) and not IsOra9DateTime(DataType) then
        DataSize	:= OraNativeDataSize(ft)	// Oracle7&8 DATE column
      else begin
        if ft = ftBCD then
          Scale	        := dscale;
        DataSize	:= NativeDataSize(ft);
{$IFNDEF XSQL_VCL5}
	// it is need a place for POCILocator pointer. NativeDataSize(ft) returns 0 for blob types in Delphi 4.
        if IsBlobType(FieldDesc.FieldType) and IsOra8BlobDataType(FieldDesc.DataType) then
          DataSize := SizeOf(POCILobLocator);
{$ENDIF}
      end;
      if (FieldType = ftDateTime) and IsOra9DateTime(DataType) then
        Precision	:= scale	// number digits in fraction part of seconds
      else
        Precision	:= prec;
  	// if NullOk = 0 then null values are not permitted for the column (Required = True)
      Required		:= NullOk = 0;
    end;
    if IsInterval( FieldDesc ) then
      FieldDesc.DataSize := SizeOf(OCIInterval);
  end;
end;

procedure TIOra8Command.SetFieldsBuffer;
var
  i, nOffset: Integer;
  PrgDataSize: Word;
  PrgDataType: Integer;
  CurPtr, DataPtr: TSDValueBuffer;
  phDefn: POCIDefine;
  phLob: POCILobLocator;
  phDateTime: POCIDateTime;
  phInterval: POCIInterval;
  LongCtxPtr: PGetLongContext;
begin
  nOffset := 0;		// pointer to the TSDFieldInfo

  for i:=0 to FieldDescs.Count-1 do begin
    PrgDataType := NativeDataType(FieldDescs[i].FieldType);
    if IsInterval( FieldDescs[i] ) then
      PrgDataType := FieldDescs[i].DataType;
    if PrgDataType = 0 then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );
    	// to exclude trailing spaces up column size for VARCHAR column (that happens sometimes).
    if PrgDataType = SQLT_AVC then
      PrgDataType := SQLT_STR;
    PrgDataSize := FieldDescs[i].DataSize;
    CurPtr  := IncPtr( FieldsBuffer, nOffset );
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );

    if IsSupportedBlobTypes( FieldDescs[i].FieldType )  then begin
    		// if LONG/LONG RAW column type
      if not IsOra8BlobDataType( FieldDescs[i].DataType ) then begin
        Check( OCIDefineByPos( Handle, phDefn, ErrPtr, FieldDescs[i].FieldNo,
              	nil, MAX_LONG_COL_SIZE, PrgDataType,
              	nil, IncPtr( CurPtr, GetFieldInfoDataSizeOff ),
              	nil, OCI_DYNAMIC_FETCH ) );
        LongCtxPtr := SafeReallocMem( nil, SizeOf(TGetLongContext) );
        SafeInitMem( LongCtxPtr, SizeOf(TGetLongContext), 0 );
        HelperMemWritePtr( CurPtr, GetFieldInfoFetchStatusOff, LongCtxPtr );
{$IFDEF XSQL_CLR}
        Check( Ora8HelperDefineDynamic(hSqlLibModule, phDefn, ErrPtr, TSDPtr( CurPtr ), cbf_get_long) );
{$ELSE}
        Check( OCIDefineDynamic(phDefn, ErrPtr, TSDPtr( CurPtr ), cbf_get_long) );
{$ENDIF}
      end else begin
        if IsFileLocDataType( FieldDescs[i].DataType ) then
          Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phLob), OCI_DTYPE_FILE, 0, nil) )
        else
          Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phLob), OCI_DTYPE_LOB, 0, nil) );
        HelperMemWritePtr( DataPtr, 0, phLob );		// POCILobLocator(TSDPtr(DataPtr)^) := phLob;
        phLob	:= nil;

        Check( OCIDefineByPos( Handle, phDefn, ErrPtr, FieldDescs[i].FieldNo,
        	DataPtr, PrgDataSize, FieldDescs[i].DataType,
              	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
               	IncPtr( CurPtr, GetFieldInfoDataSizeOff ),
              	nil, OCI_DEFAULT ) )
      end;
    end else begin
      if IsInterval( FieldDescs[i] ) then begin
        Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phInterval), GetOCIDateTimeDesc(FieldDescs[i].DataType), 0, nil) );
        HelperMemWritePtr( DataPtr, 0, phInterval );
        phInterval := nil;
        PrgDataType := FieldDescs[i].DataType;
        PrgDataSize := FieldDescs[i].DataSize;
      end else if IsOra9DateTime(FieldDescs[i].DataType) then begin      // Oracle9 datetime columns is selected as OCIDateTime
        Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phDateTime), GetOCIDateTimeDesc(FieldDescs[i].DataType), 0, nil) );
        HelperMemWritePtr( DataPtr, 0, phDateTime );		// POCIDateTime(Pointer(PrgDataBuffer)^) := phDateTime;
        phDateTime := nil;
        PrgDataType := FieldDescs[i].DataType;
        PrgDataSize := FieldDescs[i].DataSize;
      end else if IsDateTimeType(FieldDescs[i].FieldType) then
        PrgDataType := OraNativeDataType(FieldDescs[i].FieldType);	// Oracle7&8 DATE type is selected in 7-byte structure

      Check( OCIDefineByPos( Handle, phDefn, ErrPtr, FieldDescs[i].FieldNo,
        	DataPtr, PrgDataSize, PrgDataType,
              	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
              	IncPtr( CurPtr, GetFieldInfoDataSizeOff ),
              	nil, OCI_DEFAULT ) )
    end;	{ if DataType in SupportedBlobFields then }

    Inc(nOffset, SizeOf(TSDFieldInfo) + PrgDataSize);
  end;
end;

procedure TIOra8Command.FreeFieldsBuffer;
begin
  ClearFieldsExtraData;

  inherited;
end;

{ Dispose LOB/LONG info, which is used to select LOB/LONG column }
procedure TIOra8Command.ClearFieldsExtraData;
var
  i, nOffset: Integer;
  DataPtr: TSDValueBuffer;
  phLob: POCILobLocator;
  LongCtx: TGetLongContext;
  LongCtxPtr: PGetLongContext;
  phDataDesc: dvoid;    //POCIDateTime, POCIInterval
begin
	// free Lob descriptors in select buffer
  for i:=0 to FieldDescs.Count-1 do begin
    if not (IsSupportedBlobTypes(FieldDescs[i].FieldType) or
            IsOra9DateTime(FieldDescs[i].DataType))
    then
      Continue;

    nOffset := FieldBufOffs[FieldDescs[i].FieldNo-1];
    ASSERT( nOffset >= 0 );
	// if Oracle9i datetime or interval types
    if IsOra9DateTime( FieldDescs[i].DataType ) or IsInterval( FieldDescs[i] ) then begin
      DataPtr := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );
      phDataDesc := HelperMemReadPtr( DataPtr, 0 );	// POCIDateTime(DataPtr)^;
      Check( OCIDescriptorFree( Pdvoid(phDataDesc), GetOCIDateTimeDesc(FieldDescs[i].DataType) ) );
      HelperMemWritePtr( DataPtr, 0, nil );		// POCIDateTime(DataPtr)^ := nil;
    end else if IsOra8BlobDataType(FieldDescs[i].DataType) then begin
	// if Oracle8 LOB datatypes, then dispose LOB locators
      DataPtr := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );
      phLob := HelperMemReadPtr( DataPtr, 0 );		// POCILobLocator(DataPtr)^;
      Check( OCIDescriptorFree( Pdvoid(phLob), OCI_DTYPE_LOB ) );
      HelperMemWritePtr( DataPtr, 0, nil );		// POCILobLocator(DataPtr)^ := nil;
    end else begin
    	// Oracle7 LONG & LONG RAW datatypes
      // dispose data, which was used for callback processing
      LongCtxPtr := HelperMemReadPtr( FieldsBuffer, nOffset + GetFieldInfoFetchStatusOff );	// TSDPtr( PSDFieldInfo(FieldsBuffer + nOffset)^.FetchStatus );
      if Assigned( LongCtxPtr ) then begin
{$IFDEF XSQL_CLR}
        LongCtx := TGetLongContext( Marshal.PtrToStructure(LongCtxPtr, TypeOf(TGetLongContext)) );
{$ELSE}
        LongCtx := TGetLongContext( LongCtxPtr^ );
{$ENDIF}
        SafeReallocMem( LongCtx.Data, 0 );
        SafeReallocMem( LongCtxPtr, 0 );
        HelperMemWritePtr( FieldsBuffer, nOffset + GetFieldInfoFetchStatusOff, nil ); 	// TSDPtr( PSDFieldInfo(FieldsBuffer + nOffset)^.FetchStatus ) := nil;
      end;
    end;
  end;
end;

function TIOra8Command.GetLobType(BlobType: TBlobType; IsTempLob: Boolean): Integer;
var
  ft: TFieldType;
begin
  Result := 0;
  if not IsOra8BlobType(BlobType) then
    Exit;

  ft := BlobType;
{$IFDEF XSQL_VCL5}
  if ft = ftOraBlob then
    ft := ftBlob
  else if ft = ftOraClob then
    ft := ftMemo;
{$ENDIF}
  if ft = ftBlob then begin
    if IsTempLob
    then Result := OCI_TEMP_BLOB
    else Result := SQLT_BLOB;
  end else if ft = ftMemo then
    if IsTempLob
    then Result := OCI_TEMP_CLOB
    else Result := SQLT_CLOB;
end;

{ If a datatype is accessible through LOB locator }
function TIOra8Command.IsOra8BlobType(ADataType: TFieldType): Boolean;
begin
  Result := SqlDatabase.IsOra8BlobType(ADataType);
end;

function TIOra8Command.IsSelectStmt: Boolean;
var
  StmtType: ub2;
begin
  Result := False;
  if not Assigned(FHandle) then
    Exit;
  Check( OCIAttrGet( Pdvoid(FHandle), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}StmtType, nil, OCI_ATTR_STMT_TYPE, ErrPtr) );
  Result := StmtType = OCI_STMT_SELECT;
end;

function TIOra8Command.IsPLSQLBlock: Boolean;
var
  StmtType: ub2;
begin
  Check( OCIAttrGet( Pdvoid(FHandle), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}StmtType, nil, OCI_ATTR_STMT_TYPE, ErrPtr) );
  Result := (StmtType = OCI_STMT_BEGIN) or (StmtType = OCI_STMT_DECLARE);
end;

function TIOra8Command.ResultSetExists: Boolean;
var
  i: Integer;
begin
  Result := IsSelectStmt;
  if Result or not Assigned(Params) then Exit;

  for i:=0 to Params.Count-1 do begin
    	// if PL/SQL block with cursor parameter is executes ('begin open_proc(:v_cur); end;')
    if Params[i].DataType = ftCursor then begin
      FIsCursorParamExists := True;
      Break;
    end;
  end;

  Result := FIsCursorParamExists;
end;

procedure TIOra8Command.BindParamsBuffer;
begin
  if CommandType = ctQuery then
    QBindParamsBuffer
  else if CommandType = ctStoredProc then
    SpBindParamsBuffer
  else
    DatabaseError(SNoCapability);
  FBoundParams := True;
end;

procedure TIOra8Command.DoExecDirect(Value: string);
begin
  DoPrepare(Value);

  AllocParamsBuffer;
  BindParamsBuffer;

  InternalExecute;

  if FieldDescs.Count = 0 then
    InitFieldDescs;
end;

procedure TIOra8Command.DoExecute;
begin
  if CommandType in [ctQuery, ctStoredProc] then begin
    if not Assigned( FParamHandle ) then
      InternalExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
    if not FIsGetFieldDescs and (FieldDescs.Count = 0) then begin
      InitFieldDescs;
      AllocFieldsBuffer;
      SetFieldsBuffer;
    end;
  end else
    Check( OCIStmtExecute( SvcPtr, Handle, ErrPtr, 0, 0, nil, nil, GetStmtExecuteMode ) );
end;

function TIOra8Command.FetchNextRow: Boolean;
var
  rcd: sword;
begin
  rcd := OCIStmtFetch( Handle, ErrPtr, 1, OCI_FETCH_NEXT, OCI_DEFAULT );

  SqlDatabase.ResetIdleTimeOut;

  if (BlobFieldCount > 0) and
     ((rcd = OCI_NEED_DATA) or (rcd = OCI_SUCCESS) or (rcd = OCI_SUCCESS_WITH_INFO))
  then begin
    FetchBlobFields;
    rcd := OCI_SUCCESS;
  end;

  if (rcd <> OCI_SUCCESS) and
     (rcd <> OCI_SUCCESS_WITH_INFO) and
     (rcd <> OCI_NO_DATA)
  then
    Check( rcd );

  Result := (rcd = OCI_SUCCESS) or (rcd = OCI_SUCCESS_WITH_INFO);
	// if EOF, then close Cursor, returned by PL/SQL procedure
  if (not Result) and (FParamHandle <> nil) then
    CloseParamHandle;
end;

function TIOra8Command.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
begin
  Result := OraCnvtDateTime2DBDateTime( ADataType, Value, Buffer, BufSize );
end;

{ TDateTimeField selects as TDateTimeRec and converts to TDateTime }
function TIOra8Command.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  dtDateTime: TDateTimeRec;
  Curr: Currency;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);

  if IsOra9DateTime(AFieldDesc.DataType) then begin
    FieldInfo := GetFieldInfoStruct( InBuf, 0 );
    Result := sb2( FieldInfo.FetchStatus ) <> FetRNul;
    if Result then begin
      dtDateTime := Ora9CnvtDBDateTime2DateTimeRec(AFieldDesc,
                        IncPtr( InBuf, SizeOf(TSDFieldInfo) ),
                        FieldInfo.DataSize);
      HelperMemWriteDateTimeRec( Buffer, 0, dtDateTime );
    end;
  end else if IsInterval(AFieldDesc) then begin
    FieldInfo := GetFieldInfoStruct( InBuf, 0 );
    Result := sb2( FieldInfo.FetchStatus ) <> FetRNul;
    if Result then begin
      Curr := Ora9CnvtDBInterval2Currency(AFieldDesc,
                        IncPtr( InBuf, SizeOf(TSDFieldInfo) ),
                        FieldInfo.DataSize);
      HelperCurrToBCD( curr, Buffer, 32, 4 );
    end;
  end else	// right trim only Ansi fixed char (CHAR).VARCHAR is returned without changes
    Result := OraCnvtDBData(AFieldDesc.FieldType ,InBuf, Buffer, BufSize,
    		(AFieldDesc.DataType = SQLT_AFC) and SqlDatabase.IsRTrimChar);
end;

function TIOra8Command.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  nOffset: Integer;
  FldInfo: TSDFieldInfo;
  LongCtxPtr: PGetLongContext;
  LongCtx: TGetLongContext;
{$IFNDEF XSQL_CLR}
  i: Integer;
{$ENDIF}
begin
  Result := 0;
  if IsOra8BlobDataType( AFieldDesc.DataType ) then begin
    Result := ReadHLobField( AFieldDesc, BlobData );
    Exit;
  end;

  	// LONG data is returned through callback. Piecewise fetch is not used for LONG column through OCI8 (impossibility to read more then one LONG in one statement)
  nOffset := FieldBufOffs[AFieldDesc.FieldNo-1];
  if nOffset < 0 then
    Exit;
  FldInfo := GetFieldInfoStruct( FieldsBuffer, nOffset );
	// get a structure, which was used in callback
  LongCtxPtr := TSDPtr( FldInfo.FetchStatus );
{$IFDEF XSQL_CLR}
  LongCtx := TGetLongContext( Marshal.PtrToStructure(LongCtxPtr, TypeOf(TGetLongContext)) );
{$ELSE}
  LongCtx := TGetLongContext( LongCtxPtr^ );
{$ENDIF}
	//  Data was really read: pCtxLong^.DataSize + pCtxLong^.PieceSize
  Result := LongCtx.DataSize + LongCtx.PieceSize;
        // copy buffer to byte array (TSDBlobData)
  SetLength( BlobData, Result );

{$IFDEF XSQL_CLR}
  Marshal.Copy( LongCtx.Data, BlobData, 0, Result );
  LongCtx.Data := SafeReallocMem( LongCtx.Data, 0 );
  Marshal.StructureToPtr( LongCtx, LongCtxPtr, False );
{$ELSE}
  for i:=0 to Result -1 do
    BlobData[i] := Byte( LongCtx.Data[i] );

  LongCtxPtr^.Data := SafeReallocMem( LongCtxPtr^.Data, 0 );
{$ENDIF}
end;

{ Read field data using a locator(BFILE or LOB) }
function TIOra8Command.ReadHLobField(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  nOffset: Integer;
  FldInfo: TSDFieldInfo;
  DataPtr, BlobPtr: TSDValueBuffer;
  phLob: POCILobLocator;
  LobSize, ReadBytes: ub4;
  bIsFileLoc: Boolean;
begin
  Result := 0;
  nOffset := FieldBufOffs[AFieldDesc.FieldNo-1];
  if nOffset < 0 then
    Exit;

  DataPtr := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );
  FldInfo := GetFieldInfoStruct( DataPtr, -SizeOf(TSDFieldInfo) );
  FldInfo.FetchStatus := sb2( FldInfo.FetchStatus );
  if FldInfo.FetchStatus = OCI_IND_NOTNULL then begin
    phLob := POCILobLocator( HelperMemReadPtr( DataPtr, 0 ) );
	// whether a file locator it
    bIsFileLoc := IsFileLocDataType( AFieldDesc.DataType );
    	// in case of file locator to open a file
    if bIsFileLoc then
      Check( OCILobFileOpen( SvcPtr, ErrPtr, phLob, OCI_FILE_READONLY ) );
    try
      Check( OCILobGetLength( SvcPtr, ErrPtr, phLob, LobSize ) );
      if LobSize > 0 then begin
        SetLength(BlobData, LobSize);
        ReadBytes := LobSize;
{$IFDEF XSQL_CLR}
        BlobPtr := SafeReallocMem(nil, LobSize);
        try
{$ELSE}
        BlobPtr := TSDCharPtr(BlobData);
{$ENDIF}
        Check( OCILobRead( SvcPtr, ErrPtr, phLob, ReadBytes, 1,
    		dvoid(BlobPtr), LobSize, nil, nil, 0, SQLCS_IMPLICIT) );
{$IFDEF XSQL_CLR}
          Marshal.Copy( BlobPtr, BlobData, 0, LobSize );
        finally
          BlobPtr := SafeReallocMem(BlobPtr, LobSize);
        end;
{$ENDIF}
        Result := LobSize;
      end;
    finally
    	// in case of file locator to close a file
      if bIsFileLoc then
        Check( OCILobFileClose( SvcPtr, ErrPtr, phLob ) );
    end;
  end;
end;

{ Get LOB data using a LOB locator, it's used to get LOB parameters from a database }
function TIOra8Command.ReadLobData(phLob: POCILobLocator; var BlobData: TSDBlobData): Longint;
var
  LobSize, ReadBytes: ub4;
  BlobPtr: TSDValueBuffer;
begin
  Result := 0;

  Check( OCILobGetLength( SvcPtr, ErrPtr, phLob, LobSize ) );
  if LobSize > 0 then begin
    SetLength(BlobData, LobSize);
{$IFDEF XSQL_CLR}
    BlobPtr := SafeReallocMem(nil, LobSize);
    try
{$ELSE}
    BlobPtr := TSDCharPtr(BlobData);
{$ENDIF}
    ReadBytes := LobSize;
    Check( OCILobRead( SvcPtr, ErrPtr, phLob, ReadBytes, 1,
		dvoid(BlobPtr), LobSize, nil, nil, 0, SQLCS_IMPLICIT) );
{$IFDEF XSQL_CLR}
      Marshal.Copy( BlobPtr, BlobData, 0, LobSize );
    finally
      BlobPtr := SafeReallocMem(BlobPtr, LobSize);
    end;
{$ENDIF}
    Result := LobSize;
  end;
end;

{ Set LOB data using a LOB locator, it's used to pass LOB data in a database }
function TIOra8Command.WriteLobData(phLob: POCILobLocator; const Buffer: TSDValueBuffer; Count: LongInt): Longint;
var
  RetBytes: Integer;
begin
  RetBytes := Count;
  if Assigned(Buffer) and (Count > 0) then
    Check( OCILobWrite(SvcPtr, ErrPtr, phLob, RetBytes, 1, Buffer, Count, OCI_ONE_PIECE,
  			nil, nil, 0, SQLCS_IMPLICIT) );
  Result := RetBytes;
end;

function TIOra8Command.WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint;
begin
  raise EDatabaseError.CreateFmt(SFuncNotImplemented, ['TIOra8Command.WriteBlob']);
end;

{ Writes LONG/LONG RAW datatype }
function TIOra8Command.WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint;
var
  rcd: sword;
  phBind: POCIBind;
  Piece, in_out: ub1;
  ind: sb2;
  htype, iter, idx: ub4;
begin

	// return: in_out = OCI_PARAM_IN(1)/OCI_PARAM_OUT(2), htype = OCI_HTYPE_BIND(5)
  Check( OCIStmtGetPieceInfo( FHandle, ErrPtr, Pdvoid(phBind), htype,
  		in_out, iter, idx, Piece) );
	// write a block in the database as one piece
  Piece := OCI_LAST_PIECE;
  if Count = 0 then
    Check( OCIStmtSetPieceInfo( Pdvoid(phBind), htype, ErrPtr,
  		nil, Count, Piece, ind, nil ) )
  else
    Check( OCIStmtSetPieceInfo( Pdvoid(phBind), htype, ErrPtr,
  		Buffer, Count, Piece, ind, nil ) );
  rcd := OCIStmtExecute( SvcPtr, FHandle, ErrPtr, 1, 0, nil, nil, OCI_DEFAULT );

  if rcd <> OCI_NEED_DATA then
    Check( rcd );
  Result := Count;
end;

procedure TIOra8Command.WriteLobParams;
var
  i, j: Integer;
  DataPtr: TSDCharPtr;
begin
  ASSERT( FBindLobs <> nil );

  with FBindLobs do begin
    for j:=0 to RowCount-1 do
      for i:=0 to ColCount-1 do begin
{$IFDEF XSQL_CLR}
        DataPtr := Marshal.StringToHGlobalAnsi( Params[BindInfo[i].ParamIdx].AsString );
        try
{$ELSE}
        if TVarData(Params[BindInfo[i].ParamIdx].Value).VType <> varString then
          VarAsType(Params[BindInfo[i].ParamIdx].Value, varString);
        DataPtr := TVarData( Params[BindInfo[i].ParamIdx].Value ).VString;
{$ENDIF}
        if DataPtr <> nil then
          WriteLobData( GetLobLocator(j, i), DataPtr, Params[BindInfo[i].ParamIdx].GetDataSize );
{$IFDEF XSQL_CLR}
        finally
          if Assigned( DataPtr ) then
            Marshal.FreeHGlobal( DataPtr );
        end;
{$ENDIF}
      end;
  end;
end;

{ Encode INTERVAL parts to currency type }
function TIOra8Command.Ora9CnvtDBInterval2Currency(AFieldDesc: TSDFieldDesc; Buffer: TSDCharPtr; BufSize: Integer): Currency;
var
  phInterval: POCIInterval;
  y, m, dy, hr, mm, ss, fsec: sb4;
begin
  phInterval := POCIInterval( HelperMemReadPtr( Buffer, 0 ) );
  if AFieldDesc.DataType = SQLT_INTERVAL_YM then begin
    Check( OCIIntervalGetYearMonth( Pdvoid(SqlDatabase.EnvPtr), ErrPtr, y, m, phInterval ) );
    Result := (m + y * 100);
    Result := Result * 100000000;	// In some case ((Result > 9)*10^8), "Arithmetic verflow" error is raised by Delphi 8, which processes Currency as Longint(32-bit) instead of Int64
  end else begin
    Check( OCIIntervalGetDaySecond( Pdvoid(SqlDatabase.EnvPtr), ErrPtr, dy, hr, mm, ss, fsec, phInterval ) );
    Result := dy*1000000 + hr*10000 + mm*100 + ss;
        // Currency type contains 4 decimal places only. Fraction can contains up 9 digits (default-6)
    Result := Result + fsec / 1000000000;  
  end;
end;

{ TDateTimeField is selected as TDateTimeRec and converts to TDateTime }
function TIOra8Command.Ora9CnvtDBDateTime2DateTimeRec(AFieldDesc: TSDFieldDesc; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;
var
  dtDate, dtTime: TDateTime;
  phDateTime: POCIDateTime;
  Month, Day, Hour, Min, Sec: ub1;
  DeltaHour, DeltaMin: sb1;
  Year: sb2;
  fSec: ub4;
begin
  Hour := 0; Min := 0; Sec := 0;	// other variables are not initialized, because ftTime is not supported for Oracle
  phDateTime := POCIDateTime( HelperMemReadPtr( Buffer, 0 ) );
  if AFieldDesc.FieldType in [ftDate, ftDateTime] then
    Check( OCIDateTimeGetDate(Pdvoid(SqlDatabase.EnvPtr), ErrPtr, phDateTime, Year, Month, Day) );
  if AFieldDesc.FieldType in [ftTime, ftDateTime] then
    Check( OCIDateTimeGetTime(Pdvoid(SqlDatabase.EnvPtr), ErrPtr, phDateTime, Hour, Min, Sec, fSec) );
  if AFieldDesc.DataType = SQLT_TIMESTAMP_LTZ then begin
  	// add time zone offset for TIMESTAMP WITH LOCAL ZONE value
    Check( OCIDateTimeGetTimeZoneOffset(Pdvoid(SqlDatabase.EnvPtr), ErrPtr, phDateTime, DeltaHour, DeltaMin) );
    Hour := Hour + DeltaHour;
    Min := Min + DeltaMin;
  end;
    // convert fSec(fraction(9 digits) of seconds) to milliseconds (3 significant digits): it's need to remove 6 zero from the end of fSec value
  fSec := fSec div 1000000;
  dtDate := EncodeDate(Year, Month, Day);
  dtTime := EncodeTime(Hour, Min, Sec, fSec);

  case (AFieldDesc.FieldType) of
    ftTime: 	Result.Time := DateTimeToTimeStamp(dtTime).Time;
    ftDate: 	Result.Date := DateTimeToTimeStamp(dtDate).Date;
    ftDateTime: Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) );
  else
    Result.DateTime := 0.0;
  end;
end;

{ Sets value for OCIDateTime descriptor }
procedure TIOra8Command.SetOCIDateTime(FieldType: TFieldType; Value: TDateTime; phDateTime: POCIDateTime);
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  fSec: ub4;
  szTimeZone: TSDCharPtr;
begin
  Hour := 0; Min := 0; Sec := 0; MSec := 0;
  if FieldType in [ftDate, ftDateTime] then
    DecodeDate(Value, Year, Month, Day);
  if FieldType in [ftTime, ftDateTime] then
    DecodeTime(Value, Hour, Min, Sec, MSec);
    // convert milliseconds(3 significant digits) to fSec(fraction(9 digits) of seconds): it's need to add 6 zero to the end of fSec value
  fSec := MSec;
  fSec := fSec * 1000000;
{ OCIDateTimeConstruct description(ociap.h): For Types with timezone, the date and time
fields are assumed to be in the local time of the specified timezone.
If timezone is not specified, then session default timezone is assumed. }

{$IFDEF XSQL_CLR}
  szTimeZone := Marshal.StringToHGlobalAnsi(SqlDatabase.SessTimeZone);
  try
{$ELSE}
  szTimeZone := POraText(SqlDatabase.SessTimeZone);
{$ENDIF}
  Check( OCIDateTimeConstruct(Pdvoid(SqlDatabase.EnvPtr), ErrPtr, phDateTime,
  		Year, Month, Day, Hour, Min, Sec, fSec,
                szTimeZone, Length(SqlDatabase.SessTimeZone)) );
{$IFDEF XSQL_CLR}
  finally
    if Assigned(szTimeZone) then Marshal.FreeHGlobal(szTimeZone);
  end;
{$ENDIF}
end;

		{ Query methods }

procedure TIOra8Command.QBindParamsBuffer;
var
  CurPtr, DataPtr: TSDPtr;
  FieldInfo: TSDFieldInfo;
  i, Ora8LobCount: Integer;
  aBindLobs: TBindLobArray; 	// index in Params
  sqlvar: string;
  szSqlVar: TSDCharPtr;
  DataLen: sb4;
  phBind: POCIBind;
  phDateTime: POCIDateTime;
  phLob: POCILobLocator;  
begin
  if (ParamsBuffer = nil) or FBoundParams then Exit;
  CurPtr := ParamsBuffer;
  Ora8LobCount := 0;
  aBindLobs := nil;

  try
    for i:=0 to Params.Count-1 do with Params[i] do begin
      phBind := nil;
      FieldInfo := GetFieldInfoStruct( CurPtr, 0 );
      if IsNull then
        FieldInfo.FetchStatus := OCI_IND_NULL		// = -1
      else
        FieldInfo.FetchStatus := OCI_IND_NOTNULL;	// = 0
      FieldInfo.DataSize := 0;
      DataLen := NativeParamSize( Params[i] );
      DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );
	// parameter names are changed in MakeValidStatement
      sqlvar := IntToStr(i+1);
{$IFDEF XSQL_CLR}
      szSqlVar := BufList.StringToPtr(sqlvar);
{$ELSE}
      szSqlVar := TSDCharPtr( sqlvar );
{$ENDIF}
      case DataType of
        ftString:
          if DataLen > 0 then HelperMemWriteString( DataPtr, 0, AsString, DataLen );
        ftInteger:
          if DataLen > 0 then HelperMemWriteInt32( DataPtr, 0, AsInteger );
        ftSmallInt:
          if DataLen > 0 then HelperMemWriteInt16( DataPtr, 0, AsInteger );
        ftDate, ftTime, ftDateTime:
          if DataLen > 0 then
            if (DataType = ftDateTime) and SqlDatabase.UseOCIDateTime then begin
              phDateTime := nil;
              Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phDateTime), GetOCIDateTimeDesc(SQLT_TIMESTAMP), 0, nil) );
              SetOCIDateTime(DataType, AsDateTime, phDateTime);
              HelperMemWritePtr( DataPtr, 0, phDateTime );	// POCIDateTime(DataPtr^) := phDateTime;
            end else
              CnvtDateTime2DBDateTime(DataType, AsDateTime, DataPtr, NativeDataSize(DataType));
        ftBCD,
        ftFloat:
          if DataLen > 0 then HelperMemWriteDouble( DataPtr, 0, AsFloat );
        ftCursor:
          if FParamHandle = nil then begin
            FieldInfo.FetchStatus := OCI_IND_NOTNULL;
            Check( OCIHandleAlloc( Pdvoid(SqlDatabase.EnvPtr), Pdvoid(FParamHandle), OCI_HTYPE_STMT, 0, nil ) );
            HelperMemWritePtr( DataPtr, 0, FParamHandle );	// POCIStmt(DataPtr^) := FParamHandle;
            FParamHandle	:= nil;
          end;
        else
          if not IsSupportedBlobTypes(DataType) then
            raise EDatabaseError.CreateFmt(SNoParameterDataType, [Name]);
      end;
      SetFieldInfoStruct( CurPtr, 0, FieldInfo );
      if not IsBlobType(DataType) then begin
        Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
        	DataPtr, DataLen, NativeDataType(DataType),
                IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
                nil, nil, 0, nil, OCI_DEFAULT ) )
      end else begin
        if VarType(Value) <> varString then
          VarAsType(Value, varString);
        if IsOra8BlobType(DataType) then begin
          if TempLobSupported then begin
            phLob	:= nil;
            Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phLob), OCI_DTYPE_LOB, 0, nil) );
                // initialize lob
            Check( OCILobCreateTemporary(SvcPtr, ErrPtr, phLob, OCI_DEFAULT, OCI_DEFAULT,
                        GetLobType(DataType, True), False, OCI_DURATION_SESSION)
            );
            WriteLobData(phLob, {$IFDEF XSQL_CLR}BufList.StringToPtr(Params[i].AsString){$ELSE}TSDCharPtr(TVarData(Value).VString){$ENDIF}, RealParamDataSize(Params[i]));
            HelperMemWritePtr( DataPtr, 0, phLob );         // POCILobLocator(DataPtr^) := phLob;
            phLob	:= nil;
            Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
      		DataPtr, DataLen, NativeDataType(DataType),
              	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
              	nil, nil, 0, nil, OCI_DEFAULT ) )
          end else begin
            if not Assigned( FBindLobs ) then
              FBindLobs := TIOra8LobParams.Create( SqlDatabase );
            Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
           	        nil, SizeOf(OCILobLocator), NativeDataType(DataType),
                        nil, nil, nil, 0, nil, OCI_DATA_AT_EXEC ) );
{$IFDEF XSQL_CLR}
            Check( Ora8HelperBindDynamic( hSqlLibModule, phBind, ErrPtr, nil, cbf_no_data, Pdvoid(FBindLobs.BindLobPtr), cbf_out_lob_loc ) );
{$ELSE}
            Check( OCIBindDynamic( phBind, ErrPtr, nil, cbf_no_data, Pdvoid(FBindLobs.BindLobPtr), cbf_out_lob_loc ) );
{$ENDIF}
          	// save Bind Handle and parameter's index for Lob parameter
            if Length(aBindLobs) = 0 then begin
              SetLength( aBindLobs, Params.Count );
//              FillChar( aBindLobs^, Params.Count * SizeOf(TBindLobInfo), 0 );
            end;
            aBindLobs[Ora8LobCount].phBind := phBind;
            aBindLobs[Ora8LobCount].ParamIdx := i;
		// count of Lob parameters
            Inc( Ora8LobCount );
          end;
        end else        // Oracle7 LONG/LONG RAW is bound
          Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
        	{$IFDEF XSQL_CLR}BufList.StringToPtr(Params[i].AsString){$ELSE}dvoid(TSDCharPtr(TVarData(Value).VString)){$ENDIF}, RealParamDataSize(Params[i]),
                NativeDataType(DataType), IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
                nil, nil, 0, nil, OCI_DEFAULT ) )
      end;      // if not IsBlobType

      CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
    end;        // for
	// save info of Lob parameter
    if Ora8LobCount > 0 then begin
      FBindLobs.SetLobArraySize( 0, Ora8LobCount );
      for i:=0 to Ora8LobCount-1 do
        FBindLobs.BindInfo[i]   := aBindLobs[i];
    end;
  finally
    SetLength( aBindLobs, 0 );
  end;
end;

procedure TIOra8Command.DoPrepare(Value: string);
	// S must be INSERT or UPDATE statement
  function IsRequiredStmt(const S: string): Boolean;
  var
    StmtType: ub2;
  begin
    Check( OCIAttrGet( Pdvoid(FHandle), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}StmtType, nil, OCI_ATTR_STMT_TYPE, ErrPtr) );
    Result := (StmtType = OCI_STMT_INSERT) or (StmtType = OCI_STMT_UPDATE);
  end;
	// check RETURNING keyword
  function CheckReturning(const S: string): Boolean;
  const
    sRet = 'RETURNING';
    WordSep = [#$10, #$13, #$20];
  var
    i: Integer;
  begin
    i := Pos( sRet, UpperCase(S) );
    	// if found a separate word, which has a delimiter before and after
    Result := (i > 0) and
    	      (
    		( ((i+Length(sRet)) <= Length(S)) and (AnsiChar(S[i+Length(sRet)]) in WordSep) )
                	or
                ( ((i-1) > 0) and (AnsiChar(S[i-1]) in WordSep) )
    	      );
  end;
	// for example: change 'FCLOB = :FLONG' -> 'FCLOB = empty_clob()' and add 'returning FCLOB into :FLONG'
  function AddReturning(const AStmt: string): string;
  var
    sRetStmt, sFields, sParams, sFullParamName, sEmptyFunc: string;
    i, ParamPos: Integer;
  begin
    sFields := '';
    sRetStmt := AStmt;
    for i:=0 to Params.Count-1 do begin
      if not IsOra8BlobType(Params[i].DataType) then
        Continue;
      sFullParamName := ParamPrefix + IntToStr(i+1);
      ParamPos := Pos( sFullParamName, sRetStmt );
      if ParamPos = 0 then
        Continue;
    	// it's necessary to parse column name for UPDATE and INSERT statement
      if Length(sFields) > 0 then
        sFields := sFields + ', ';
      sFields := sFields + Params[i].Name;

      if Length(sParams) > 0 then
        sParams := sParams + ', ';
      sParams := sParams + sFullParamName;
    	// change, for example, ':FLONG' -> 'empty_blob()' or 'empty_clob()'
      Delete( sRetStmt, ParamPos, Length(sFullParamName) );
      if NativeDataType(Params[i].DataType) = SQLT_BLOB
      then sEmptyFunc := 'empty_blob()'
      else sEmptyFunc := 'empty_clob()';	// else SQLT_CLOB
      Insert( sEmptyFunc, sRetStmt, ParamPos );
    end;

    if Length(sFields) > 0 then
      sRetStmt := sRetStmt + Format(' returning %s into %s', [sFields, sParams]);
    Result := sRetStmt;
  end;
var
  i: Integer;
  szCmd: TSDCharPtr;
begin
  if FHandle = nil then Connect;

  if CommandType = ctQuery then begin
    FStmt := MakeValidStatement( Value, Params );
{$IFDEF XSQL_CLR}
    szCmd := BufList.StringToPtr(FStmt);
{$ELSE}
    szCmd := TSDCharPtr(FStmt);
{$ENDIF}
    CheckStmt( OCIStmtPrepare( FHandle, ErrPtr, szCmd, Length(FStmt), OCI_NTV_SYNTAX, OCI_DEFAULT ) );

    if Assigned(Params) and not TempLobSupported and {$IFDEF XSQL_VCL5} True {$ELSE} SqlDatabase.IsOra8BlobMode {$ENDIF} then begin
      i := 0;
      while i < Params.Count do begin
        if IsOra8BlobType(Params[i].DataType) then
          Break;
        Inc( i );
      end;
      if i = Params.Count then
        Exit;	// Query does not have Oracle8 blob parameters
	// Check UPDATE or INSERT statement
      if not IsRequiredStmt( FStmt ) then
        Exit;
	// Check RETURNING clause in the statament
      if not CheckReturning( FStmt ) then
        FStmt := AddReturning( FStmt );  // add modifucations in the statement. If BLOB is empty, then it's not necessary to bind and add it to returning clause
{$IFDEF XSQL_CLR}
      szCmd := BufList.StringToPtr(FStmt);
{$ELSE}
      szCmd := TSDCharPtr(FStmt);
{$ENDIF}
      CheckStmt( OCIStmtPrepare( FHandle, ErrPtr, szCmd, Length(FStmt), OCI_NTV_SYNTAX, OCI_DEFAULT ) );
    end;
  end else if CommandType = ctStoredProc then begin
    if Assigned(Params) and (Params.Count = 0) then
      InitParamList;

    FStmt := MakeStoredProcStmt( Value, Params );
{$IFDEF XSQL_CLR}
    szCmd := BufList.StringToPtr(FStmt);
{$ELSE}
    szCmd := TSDCharPtr(FStmt);
{$ENDIF}
    Check( OCIStmtPrepare( Handle, ErrPtr, szCmd, Length(FStmt), OCI_NTV_SYNTAX, OCI_DEFAULT ) );
  end else
    DatabaseError(SNoCapability);

  SetNativeCommand(FStmt);
end;

function TIOra8Command.GetStmtExecuteMode: ub4;
begin
  Result := OCI_DEFAULT;
  if SqlDatabase.AutoCommit and not SqlDatabase.InTransaction then
    Result := Result or OCI_COMMIT_ON_SUCCESS;
end;

procedure TIOra8Command.InternalExecute;
var
  iters, PrefetchRows: ub4;
  rcd: sword;
  i: Integer;
  sBlob: string;
  szBlob: TSDCharPtr;
begin
  if IsSelectStmt
  then iters := 0
  else iters := 1;

	// in case of select, it improves fetch perfomance
  if iters = 0 then begin
  	// by default OCI_ATTR_PREFETCH_ROWS is equal 1, big value can decrease perfomance of complex queries
    PrefetchRows := MaxIntValue(3, SqlDatabase.PrefetchRows);
    Check( OCIAttrSet( Pdvoid(Handle), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}PrefetchRows, SizeOf(PrefetchRows), OCI_ATTR_PREFETCH_ROWS, ErrPtr) );
  end;

  rcd := OCIStmtExecute( SvcPtr, Handle, ErrPtr, iters, 0, nil, nil, GetStmtExecuteMode );

    	// piecewise writing of LONG parameters in SpBindParamsBuffer
  if rcd = OCI_NEED_DATA then begin
    if Assigned(Params) then for i:=0 to Params.Count-1 do
      if IsSupportedBlobTypes( Params[i].DataType ) then begin
        sBlob := Params[i].AsBlob;
{$IFDEF XSQL_CLR}
        szBlob := Marshal.StringToHGlobalAnsi(sBlob);
        try
          WriteBlobByName( Params[i].Name, szBlob, Length(sBlob) );
        finally
          if Assigned(szBlob) then Marshal.FreeHGlobal(szBlob);
        end;
{$ELSE}
        szBlob := TSDCharPtr(sBlob);
        WriteBlobByName( Params[i].Name, szBlob, Length(sBlob) );
{$ENDIF}
      end;
  end else
    CheckStmt( rcd );

    {	// in case of update(insert ..) error,
        //it's necessary to prepare and bind a statement anew. It isn't necessary to do for SELECT
  if (rcd = OCI_ERROR) and
     (dsfExecSQL in DSFlags) and (dsfPrepared in DSFlags)
  then
    Query.UnPrepare;
}

	// if Oracle8 Lob parameters are processed
  if Assigned(FBindLobs) then begin
    WriteLobParams;
    FBindLobs.Free;
    FBindLobs := nil;
  end;
	// if PL/SQL block is executed
  if IsPLSQLBlock then
    InternalGetParams;
end;

procedure TIOra8Command.InternalGetParams;
var
  i, iMaxCharParamLen: Integer;
  FldBuf, OutData: TSDCharPtr;
  FieldInfo: TSDFieldInfo;
  bIsNull, bIsRTrimChar: Boolean;
  sBlob: TSDBlobData;
  phLob: POCILobLocator;
  FieldDesc: TSDFieldDesc;
begin
  if ParamsBuffer = nil then Exit;
  FieldDesc := TSDFieldDesc.Create;
	// Alloc buffer for parameter of max size
  OutData := SafeReallocMem( nil, SqlDatabase.GetMaxCharParamLen );

  try
    FldBuf := ParamsBuffer;
    bIsRTrimChar := SqlDatabase.IsRTrimChar;
    iMaxCharParamLen := SqlDatabase.GetMaxCharParamLen;
    for i := 0 to Params.Count - 1 do begin
      FieldInfo := GetFieldInfoStruct( FldBuf, 0 );
      FieldInfo.FetchStatus := sb2( FieldInfo.FetchStatus );
      if FieldInfo.DataSize = 0 then
        FieldInfo.DataSize := NativeParamSize( Params[i] );
      SetFieldInfoStruct( FldBuf, 0, FieldInfo );
      if Params[i].ParamType in [ptResult, ptInputOutput, ptOutput] then begin
	// REF CURSOR processing, if it's need
        if Params[i].DataType = ftCursor then begin
          if FParamHandle = nil then
            FParamHandle := POCIStmt( HelperMemReadPtr( FldBuf, SizeOf(TSDFieldInfo) ) );	// POCIStmt(Pointer(FldBuf + SizeOf(TSDFieldInfo))^);
        end else if IsOra8BlobType(Params[i].DataType) then begin
        	// input/output LOB parameters
          if FieldInfo.FetchStatus = OCI_IND_NOTNULL then begin
            phLob := POCILobLocator( HelperMemReadPtr( FldBuf, SizeOf(TSDFieldInfo) ) );
            if Params[i].ParamType = ptInputOutput then begin
              sBlob := Params[i].Value;
              	// set BLOB/CLOB data using the returned locator
              if Length(sBlob) > 0 then
                WriteLobData(phLob, TSDCharPtr(sBlob), Length(sBlob));
            end else
              if ReadLobData(phLob, sBlob) > 0 then
                Params[i].Value := sBlob;
//            Check( OCIDescriptorFree( Pdvoid(phLob), OCI_DTYPE_LOB ) ); now it is destroyed in FreeParamsBuffer
          end;
        end else begin
          if (Params[i].DataType = ftDateTime) and SqlDatabase.UseOCIDateTime then begin
            bIsNull := FieldInfo.FetchStatus = FetRNul;
            if not bIsNull then begin
              FieldDesc.FieldType := Params[i].DataType;
              FieldDesc.DataType  := NativeDataType( Params[i].DataType );
              HelperMemWriteDateTimeRec( OutData, 0,
                        Ora9CnvtDBDateTime2DateTimeRec(FieldDesc,
                                IncPtr( FldBuf, SizeOf(TSDFieldInfo) ),
                                FieldInfo.DataSize) );
            end;
          end else
        	// if IsRTrimChar = True, it'll trim trailing spaces for all string fields
            bIsNull := not OraCnvtDBData(Params[i].DataType, FldBuf, OutData,
                                        iMaxCharParamLen, bIsRTrimChar);
          if bIsNull then
            Params[i].Clear
          else
            Params[i].SetData(OutData);
        end;
      end;
      FldBuf := IncPtr( FldBuf, FieldInfo.DataSize + SizeOf(TSDFieldInfo) );
    end;

  finally
    SafeReallocMem(OutData, 0);
    FieldDesc.Free;
  end;
end;

function TIOra8Command.GetRowsAffected: Integer;
var
  rows: ub4;
begin
  Result := -1;
  if IsSelectStmt or not Assigned(FHandle) then
    Exit;

  Check( OCIAttrGet( Pdvoid(FHandle), OCI_HTYPE_STMT, {$IFNDEF XSQL_CLR}@{$ENDIF}rows, nil, OCI_ATTR_ROW_COUNT, ErrPtr) );
  Result := rows;
end;

	{ StoredProc methods }

procedure TIOra8Command.InitParamList;
var
  sObjName, sParamName, sPkgName: string;
  ft: TFieldType;
  pt: TSDHelperParamType;
  IsFunc: Boolean;
  i: Integer;
  rcd: sword;
  phDesc: POCIDescribe;
  phParm, phSubLst, phArgLst, phArg: POCIParam;
  NumSubs, NumArgs, dtype: ub2;
  iomode: OCITypeParamMode;
  prec, SubType: ub1;
  scale: sb1;
  szName, szTemp: TSDCharPtr;
  NameLen: ub4;
begin
  IsFunc := False;
  sObjName := CommandText;
  for i:=Length(sObjName) downto 1 do
    if sObjName[i] = '.' then begin
    	// package name can include a owner name, for example: 'owner.package_name'
      sPkgName := Copy( sObjName, 1, i-1 );
      if Pos( '.', sPkgName ) = 0 then
        sPkgName := ''
      else
        sObjName := Copy( sObjName, i+1, Length(sObjName)-i );
      Break;
    end;
  pt := ptInput;
  phDesc := nil;
  	// get the describe handle for the procedure or function
  Check( OCIHandleAlloc( Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phDesc), OCI_HTYPE_DESCRIBE, 0, nil ) );
  try
  	// describe a package and find the required procedure/function in a package list
    if Trim(sPkgName) <> '' then begin
{$IFDEF XSQL_CLR}
      szTemp := Marshal.StringToHGlobalAnsi( sPkgName );
{$ELSE}
      szTemp := TSDCharPtr(sPkgName);
{$ENDIF}
      Check( OCIDescribeAny( SvcPtr, ErrPtr, Pdvoid(szTemp), Length(sPkgName),
  		OCI_OTYPE_NAME, OCI_DEFAULT, OCI_PTYPE_PKG, phDesc ) );
	// Get the parameter for the package
      Check( OCIAttrGet( Pdvoid(phDesc), OCI_HTYPE_DESCRIBE, {$IFNDEF XSQL_CLR}@{$ENDIF}phParm, nil, OCI_ATTR_PARAM, ErrPtr) );
      	// get parameter for list of subprograms
      Check( OCIAttrGet( Pdvoid(phParm), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}phSubLst, nil, OCI_ATTR_LIST_SUBPROGRAMS, ErrPtr) );
	//  How many subroutines are in this package ?
      Check( OCIAttrGet( Pdvoid(phSubLst), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}NumSubs, nil, OCI_ATTR_NUM_PARAMS, ErrPtr) );
      i := 0;
      while i < NumSubs do begin
        Check( OCIParamGet( Pdvoid(phSubLst), OCI_DTYPE_PARAM, ErrPtr, Pdvoid(phParm), i ) );
	// Get the routine type and name...
        Check( OCIAttrGet( Pdvoid(phParm), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}SubType, nil, OCI_ATTR_PTYPE, ErrPtr) );
        IsFunc := SubType = OCI_PTYPE_FUNC;
        szName := nil;
        Check( OCIAttrGet( Pdvoid(phParm), OCI_DTYPE_PARAM, {$IFDEF XSQL_CLR}szName, NameLen{$ELSE}@szName, @NameLen{$ENDIF}, OCI_ATTR_NAME, ErrPtr) );
       	// the routine's found
        if UpperCase(sObjName) = UpperCase( HelperPtrToString(szName, NameLen) ) then
          Break;
        Inc( i );
      end;
      	// the procedure/function is not exist in the package
      if i = NumSubs then begin
        sObjName := CommandText;
{$IFDEF XSQL_CLR}
        if Assigned( szTemp ) then Marshal.FreeHGlobal( szTemp );
        szTemp := Marshal.StringToHGlobalAnsi( sObjName );
{$ELSE}
        szTemp := TSDCharPtr(sObjName);
{$ENDIF}
        Check( OCIDescribeAny( SvcPtr, ErrPtr, Pdvoid(szTemp), Length(sObjName),
  		OCI_OTYPE_NAME, OCI_DEFAULT, OCI_PTYPE_FUNC, phDesc ) );
      end;
    end else begin
{$IFDEF XSQL_CLR}
      szTemp := Marshal.StringToHGlobalAnsi( sObjName );
{$ELSE}
      szTemp := TSDCharPtr(sObjName);
{$ENDIF}
      rcd := OCIDescribeAny( SvcPtr, ErrPtr, Pdvoid(szTemp), Length(sObjName),
  		OCI_OTYPE_NAME, OCI_DEFAULT, OCI_PTYPE_PROC, phDesc );
      	// if the procedure sObjName is not exist, try to get it as function
      if (rcd = OCI_ERROR) then begin
        Check( OCIDescribeAny( SvcPtr, ErrPtr, Pdvoid(szTemp), Length(sObjName),
        	OCI_OTYPE_NAME, OCI_DEFAULT, OCI_PTYPE_FUNC, phDesc ) );
        IsFunc := True;
      end else
        Check( rcd );
	// get the parameter handle
      NameLen := 0;	// it's used to select correctly overloaded function in D8
      Check( OCIAttrGet( Pdvoid(phDesc), OCI_HTYPE_DESCRIBE, {$IFDEF XSQL_CLR}phParm, NameLen{$ELSE}@phParm, nil{$ENDIF}, OCI_ATTR_PARAM, ErrPtr) );
    end;

	// Get the number of arguments and the arg list
    NameLen := 0;
    Check( OCIAttrGet( Pdvoid(phParm), OCI_DTYPE_PARAM, {$IFDEF XSQL_CLR}phArgLst, NameLen{$ELSE}@phArgLst, nil{$ENDIF},
    			OCI_ATTR_LIST_ARGUMENTS, ErrPtr) );
    Check( OCIAttrGet( Pdvoid(phArgLst), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}NumArgs, nil,
    			OCI_ATTR_NUM_PARAMS, ErrPtr) );
	// For a procedure, we begin with i = 1; for a function, we begin with i = 0. NumArgs = Result(1, for function) + Parameters
    if IsFunc then begin
      i := 0;
      Dec( NumArgs );
    end else
      i := 1;

    while i <= NumArgs do begin
      Check( OCIParamGet( Pdvoid(phArgLst), OCI_DTYPE_PARAM, ErrPtr, Pdvoid(phArg), i ) );
      szName := nil;
      Check( OCIAttrGet( Pdvoid(phArg), OCI_DTYPE_PARAM, {$IFDEF XSQL_CLR}szName, NameLen{$ELSE}@szName, @NameLen{$ENDIF},
      				OCI_ATTR_NAME, ErrPtr) );
      Check( OCIAttrGet( Pdvoid(phArg), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}dtype, nil,
      				OCI_ATTR_DATA_TYPE, ErrPtr) );
      Check( OCIAttrGet( Pdvoid(phArg), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}iomode, nil,
      				OCI_ATTR_IOMODE, ErrPtr) );
      Check( OCIAttrGet( Pdvoid(phArg), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}prec, nil,
      				OCI_ATTR_PRECISION, ErrPtr) );
      Check( OCIAttrGet( Pdvoid(phArg), OCI_DTYPE_PARAM, {$IFNDEF XSQL_CLR}@{$ENDIF}scale, nil,
      				OCI_ATTR_SCALE, ErrPtr) );

      if szName <> nil
      then sParamName := HelperPtrToString( szName, NameLen )
      else sParamName := SResultName;

      ft := FieldDataType( dtype );
      if ft = ftUnknown then
        DatabaseErrorFmt( SBadFieldType, [sParamName]);
      ft := OraExactNumberDataType(ft, prec, scale, SqlDatabase.IsEnableInts, SqlDatabase.IsEnableBCD);
      case iomode of
        OCI_TYPEPARAM_IN:	pt := ptInput;
        OCI_TYPEPARAM_OUT:	pt := ptOutput;
        OCI_TYPEPARAM_INOUT:	pt := ptInputOutput;
      else
        DatabaseErrorFmt( SBadParameterType, [sParamName] );
      end;
      if (szName = nil) and (pt in [ptOutput]) then
        pt := ptResult;

      AddParam( sParamName, ft, pt );

      Inc( i );
    end;
    FBoundParams := False;
  finally
{$IFDEF XSQL_CLR}
    if Assigned( szTemp ) then Marshal.FreeHGlobal( szTemp );
{$ENDIF}
    Check( OCIHandleFree( Pdvoid(phDesc), OCI_HTYPE_DESCRIBE ) );
  end;
end;

procedure TIOra8Command.SpBindParamsBuffer;
var
  CurPtr, DataPtr: TSDPtr;
  FieldInfo: TSDFieldInfo;
  i: Integer;
  sqlvar: string;
  szSqlVar: TSDCharPtr;
  DataLen: sb4;
  phBind: POCIBind;
  phLob: POCILobLocator;
  phDateTime: POCIDateTime;
  LobEmpty: ub4;
begin
  if (ParamsBuffer = nil) or FBoundParams then Exit;
  CurPtr := ParamsBuffer;

  for i:=0 to Params.Count-1 do with Params[i] do begin
    FieldInfo := GetFieldInfoStruct( CurPtr, 0 );
    if IsNull then
      FieldInfo.FetchStatus := OCI_IND_NULL
    else
      FieldInfo.FetchStatus := OCI_IND_NOTNULL;
    DataLen := NativeParamSize( Params[i] );
    FieldInfo.DataSize := 0;
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );

    sqlvar := ':' + Name;
{$IFDEF XSQL_CLR}
    szSqlVar := BufList.StringToPtr(sqlvar);
{$ELSE}
    szSqlVar := TSDCharPtr( sqlvar );
{$ENDIF}
    case DataType of
      ftString:
        if not IsNull then begin
        	// DataLen is always equal MinStrParamSize+1(with '\0'), but string length may be less or more
          if DataLen > (Length(AsString) + 1) then
            HelperMemWriteString( DataPtr, 0, AsString, Length(AsString)+1 )	// includes '\0'
          else begin
            HelperMemWriteString( DataPtr, 0, AsString, DataLen );
            HelperMemWriteByte( DataPtr, DataLen-1, 0 );	// DataLen is buffer size including zero-terminator
          end;
        end;
      ftInteger:
        if not IsNull then HelperMemWriteInt32( DataPtr, 0, AsInteger );
      ftSmallInt:
        if not IsNull then HelperMemWriteInt16( DataPtr, 0, AsInteger );
      ftDate, ftTime, ftDateTime:
        if (DataType = ftDateTime) and SqlDatabase.UseOCIDateTime then begin
          phDateTime := nil;
          Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phDateTime), GetOCIDateTimeDesc(SQLT_TIMESTAMP), 0, nil) );
          if not IsNull then
            SetOCIDateTime(DataType, AsDateTime, phDateTime);
          HelperMemWritePtr( DataPtr, 0, phDateTime );          //POCIDateTime(DataPtr^):= phDateTime;
        end else
          if not IsNull then
            CnvtDateTime2DBDateTime(DataType, AsDateTime, DataPtr, NativeDataSize(DataType));
      ftBCD,
      ftFloat:
        if not IsNull then HelperMemWriteDouble( DataPtr, 0, AsFloat );
      ftCursor:
        if FParamHandle = nil then begin
          FieldInfo.FetchStatus := OCI_IND_NOTNULL;
          Check( OCIHandleAlloc( Pdvoid(SqlDatabase.EnvPtr), Pdvoid(FParamHandle), OCI_HTYPE_STMT, 0, nil ) );
          HelperMemWritePtr( DataPtr, 0, FParamHandle );        //POCIStmt(DataPtr^):= FParamHandle;
          FParamHandle	:= nil;
        end;
      else
        if not IsSupportedBlobTypes(DataType) then
          DatabaseErrorFmt(SNoParameterDataType, [Name]);
    end;
    phBind := nil;
    SetFieldInfoStruct( CurPtr, 0, FieldInfo );
    if IsBlobType(DataType) then begin
      if IsOra8BlobType(DataType) then begin
        Check( OCIDescriptorAlloc(Pdvoid(SqlDatabase.EnvPtr), Pdvoid(phLob), OCI_DTYPE_LOB, 0, nil) );
        if ParamType in [ptInput, ptInputOutput] then begin
        	// it will be set BLOB/CLOB field to empty (assign this locator is equal to assign empty_lob() function )
          LobEmpty := 0;
          Check( OCIAttrSet(Pdvoid(phLob), OCI_DTYPE_LOB, {$IFNDEF XSQL_CLR}@{$ENDIF}LobEmpty, SizeOf(LobEmpty), OCI_ATTR_LOBEMPTY, ErrPtr) );
        end;
        HelperMemWritePtr( DataPtr, 0, phLob );         // POCILobLocator(DataPtr^) := phLob;
        phLob	:= nil;
        Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
      		DataPtr, DataLen, NativeDataType(DataType),
              	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
              	nil, nil, 0, nil, OCI_DEFAULT ) )
      end else
        Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
      		nil, MAX_LONG_COL_SIZE, NativeDataType(DataType),
              	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
              	nil, nil, 0, nil, OCI_DATA_AT_EXEC ) )
    end else begin
      Check( OCIBindByName( Handle, phBind, ErrPtr, szSqlVar, Length(sqlvar),
      		DataPtr, DataLen, NativeDataType(DataType),
              	IncPtr( CurPtr, GetFieldInfoFetchStatusOff ),
              	nil, nil, 0, nil, OCI_DEFAULT ) )
    end;
    CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

procedure TIOra8Command.GetOutputParams;
begin
  // nothing
end;


initialization
  Oracle8Blobs	:= False;

  bDetectedOCI72:= False;
  bDetectedOCI73:= False;
  dwLoadedOCI	:= 0;

  UsePiecewiseCalls := False;

  hSqlLibModule := 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;
  DummyNullIndPtr := SafeReallocMem( nil, SizeOf(sb2) );
  HelperMemWriteInt16( DummyNullIndPtr, 0, OCI_IND_NULL );
finalization
  DummyNullIndPtr := SafeReallocMem( DummyNullIndPtr, 0 );
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.

