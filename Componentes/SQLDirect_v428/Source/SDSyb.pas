
{**********************************************************}
{							   }
{       Delphi SQLDirect Component Library		   }
{	Sybase Open Client/Server API(11.5,12.5) Interface Unit }
{       			                           }
{       Copyright (c) 1997,2005 by Yuri Sheino		   }
{                                                          }
{**********************************************************}
{$I SqlDir.inc}
unit SDSyb {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, SyncObjs,
{$IFDEF SD_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  SDConsts, SDCommon;


{*******************************************************************************
**	csconfig.h (Sybase Open Client/Server Library) from 21.07.1997
**
** This file will try to hide any interface differences found on various
** platform/compiler combinations. Any datatype or define that is
** dependant on a particular platform/compiler should have its definition here.
*******************************************************************************}

{
   Define the scoping rules that will be used in all libraries. These defines
   exist to support different compiler-specific keywords describing the
   calling convention of a C function.
   CS_PUBLIC		Interface define for functions which are called
			outside of a library or DLL.
   CS_INTERNAL		Interface define for functions which are only called
			within a library or DLL.
   CS_VARARGS		Interface define for functions with variable argument
			lists which are called outside of a library or DLL.
   CS_STATIC		Interface define for functions which are only called
			within a C module.


#define CS_PUBLIC	__stdcall
#define CS_INTERNAL     CS_PUBLIC
#define CS_VARARGS      __stdcall
#define CS_STATIC       static
}


{-------------------------------------------------------------------------------
			Datatype definitions.
-------------------------------------------------------------------------------}
//** Certain Sybase C datatypes must be defined as 4 bytes in size.
type
  TCS_INT	= LongInt;
  TCS_RETCODE	= LongInt;
  TCS_BOOL	= LongInt;
  TCS_UINT	= DWORD;	//typedef	unsigned long	CS_UINT;


type
  void 		= TSDPtr;
  TCS_VOID	= void;
  TCS_THRDRES	= void;
  TCS_FLOAT	= Double;	// 8 byte float type
{$IFDEF SD_CLR}
  PCS_VOID	= TCS_VOID;
  PCS_INT	= TCS_VOID;
  PCS_THRDRES	= TCS_VOID;
{$ELSE}
  PCS_VOID	= ^TCS_VOID;
  PCS_INT	= ^TCS_INT;
  PCS_THRDRES	= ^TCS_THRDRES;
{$ENDIF}

const
  CS_BITS_PER_BYTE	= 8;	// Define the number of bits that a CS_BYTE can hold.

{*******************************************************************************
**	cstypes.h (Sybase Open Client/Server Library)
**
** This file defines basic error codes and data types used in all Open
** Client/Server System 10 Products.
*******************************************************************************}

{-------------------------------------------------------------------------------
	Return code defines used in client/server applications.
-------------------------------------------------------------------------------}
const
//** Define the core return codes.
  CS_SUCCEED		= TCS_RETCODE( 1);
  CS_FAIL		= TCS_RETCODE( 0);
  CS_MEM_ERROR		= TCS_RETCODE(-1);
  CS_PENDING		= TCS_RETCODE(-2);
  CS_QUIET		= TCS_RETCODE(-3);
  CS_BUSY		= TCS_RETCODE(-4);
  CS_INTERRUPT		= TCS_RETCODE(-5);
  CS_BLK_HAS_TEXT	= TCS_RETCODE(-6);
  CS_CONTINUE		= TCS_RETCODE(-7);
  CS_FATAL		= TCS_RETCODE(-8);
  CS_RET_HAFAILOVER	= TCS_RETCODE(-9);

//** Define error offsets. All other CS_RETCODE error codes should be
//** based off of these values to avoid define conflicts.
  CS_CONV_ERR		= TCS_RETCODE(-100);
  CS_EXTERNAL_ERR      	= TCS_RETCODE(-200);
  CS_INTERNAL_ERR      	= TCS_RETCODE(-300);

//* common library errors
  CS_COMN_ERR		= TCS_RETCODE(-400);

//** Return code for a routine which was cancelled via ct_cancel().
  CS_CANCELED		= TCS_RETCODE(CS_EXTERNAL_ERR - 2);

//** Special returns for ct_fetch().
  CS_ROW_FAIL		= TCS_RETCODE(CS_EXTERNAL_ERR - 3);
  CS_END_DATA		= TCS_RETCODE(CS_EXTERNAL_ERR - 4);

//** Special return for ct_results().
  CS_END_RESULTS	= TCS_RETCODE(CS_EXTERNAL_ERR - 5);

//** Special return for ct_get_data().
  CS_END_ITEM		= TCS_RETCODE(CS_EXTERNAL_ERR - 6);

//** Special return for ct_diag().
  CS_NOMSG		= TCS_RETCODE(CS_EXTERNAL_ERR - 7);

//** Special return for ct_poll().
  CS_TIMED_OUT		= TCS_RETCODE(CS_EXTERNAL_ERR - 8);

//** Special returns for passthru().
  CS_PASSTHRU_EOM      	= TCS_RETCODE(CS_EXTERNAL_ERR - 10);
  CS_PASSTHRU_MORE	= TCS_RETCODE(CS_EXTERNAL_ERR - 11);

//** Special return for ct_cancel().
  CS_TRYING		= TCS_RETCODE(CS_EXTERNAL_ERR - 13);

//** Errors caused by external events (i.e. bad params supplied by user).
  CS_EBADPARAM		= TCS_RETCODE(CS_EXTERNAL_ERR - 14);
  CS_EBADLEN		= TCS_RETCODE(CS_EXTERNAL_ERR - 15);
  CS_ENOCNVRT		= TCS_RETCODE(CS_EXTERNAL_ERR - 16);

//** Return codes for conversion errors. These should be used in any user-
//** defined conversion routines that are install via cs_set_convert().
  CS_EOVERFLOW		= TCS_RETCODE(CS_CONV_ERR - 1);
  CS_EUNDERFLOW		= TCS_RETCODE(CS_CONV_ERR - 2);
  CS_EPRECISION		= TCS_RETCODE(CS_CONV_ERR - 3);
  CS_ESCALE		= TCS_RETCODE(CS_CONV_ERR - 4);
  CS_ESYNTAX		= TCS_RETCODE(CS_CONV_ERR - 5);
  CS_EFORMAT		= TCS_RETCODE(CS_CONV_ERR - 6);
  CS_EDOMAIN		= TCS_RETCODE(CS_CONV_ERR - 7);
  CS_EDIVZERO		= TCS_RETCODE(CS_CONV_ERR - 8);
  CS_ERESOURCE		= TCS_RETCODE(CS_CONV_ERR - 9);
  CS_ENULLNOIND		= TCS_RETCODE(CS_CONV_ERR - 10);
  CS_ETRUNCNOIND	= TCS_RETCODE(CS_CONV_ERR - 11);
  CS_ENOBIND		= TCS_RETCODE(CS_CONV_ERR - 12);
  CS_TRUNCATED		= TCS_RETCODE(CS_CONV_ERR - 13);
  CS_ESTYLE		= TCS_RETCODE(CS_CONV_ERR - 14);
  CS_EBADXLT      	= TCS_RETCODE(CS_CONV_ERR - 15);
  CS_ENOXLT       	= TCS_RETCODE(CS_CONV_ERR - 16);
  CS_USEREP		= TCS_RETCODE(CS_CONV_ERR - 17);

//** Error Severities.
  CS_SV_INFORM		= TCS_INT(0);
  CS_SV_API_FAIL	= TCS_INT(1);
  CS_SV_RETRY_FAIL	= TCS_INT(2);
  CS_SV_RESOURCE_FAIL	= TCS_INT(3);
  CS_SV_CONFIG_FAIL	= TCS_INT(4);
  CS_SV_COMM_FAIL	= TCS_INT(5);
  CS_SV_INTERNAL_FAIL	= TCS_INT(6);
  CS_SV_FATAL		= TCS_INT(7);

{-------------------------------------------------------------------------------
   Error numbers, and macros for extracting information from a
   Client-Library error number.

   Error numbers are broken down into four components:
      	Layer		- Represents which layer is reporting the error.
        Origin		- Indicates where the error manifested itself.
        Severity	- How bad is the error?
        Number		- The actual layer specific error number being
               		  reported.
-------------------------------------------------------------------------------}

//** The error message number.
type
  TCS_MSGNUM	= LongInt;

{*
** The following macros are used to extract the components from a composite
** error number.
*
#define CS_LAYER(L)	(CS_MSGNUM) (((L) >> 24) & 0xff)
#define CS_ORIGIN(O)	(CS_MSGNUM) (((O) >> 16) & 0xff)
#define CS_SEVERITY(S)	(CS_MSGNUM) (((S) >> 8) & 0xff)
#define CS_NUMBER(N)	(CS_MSGNUM) ((N) & 0xff)
}

const

//** The following are the possible values for cs_status field of
//** CHAR_ATTRIB structure defined in intl_nls.h
  CS_STAT_DEFAULT	= $0000;
  CS_STAT_MULTIBYTE	= $0001;
  CS_STAT_SPACELAST	= $0002;
  CS_STAT_NONASCIISP	= $0004;

{-------------------------------------------------------------------------------
	Defines used in client/server applications.
-------------------------------------------------------------------------------}

//** The maximum localization name allowed. A four byte value is added (instead
//** of 1 byte) to provide space for null termination and remain on a modulo 4
//** byte boundary.
  CS_MAX_LOCALE		= TCS_INT(64 + 4);

//** The maximum column name allowed.
  CS_MAX_NAME		= TCS_INT(128 + 4);

//**
//** The maximum password length allowed.
//**
  CS_MAX_PASS		= TCS_INT(30);
//** The maximum number of characters in arrays. Please note that this define
//** does not correspond to any server definition of lengths (particularly
//** the length of the character data type, which is 255 bytes for the Sybase server).
  CS_MAX_CHAR		= TCS_INT(256);

//** Maximum string in Directory Services
  CS_MAX_DS_STRING	= TCS_INT(512);

//** Maximum data length of numeric/decimal datatypes.
  CS_MAX_NUMLEN		= TCS_INT(33);

//** To be true or not true.
  CS_TRUE		= TCS_BOOL(1);
  CS_FALSE		= TCS_BOOL(0);

//** Define basic default types.
  CS_NULLTERM		= TCS_INT(-9);
  CS_WILDCARD		= TCS_INT(-99);
  CS_NO_LIMIT		= TCS_INT(-9999);
  CS_UNUSED		= TCS_INT(-99999);


//** timeout values
//**	CS_NO_LIMIT		Resource will never expire.
//**	CS_UNEXPIRED		Resource did not expire.
  CS_UNEXPIRED		= TCS_INT(-999999);

//**
//** Enumerate part of usertypes dataserver support.
//**
  USER_UNICHAR_TYPE	= TCS_INT(34);
  USER_UNIVARCHAR_TYPE	= TCS_INT(35);

//** Enumerate what datatypes we support.
  CS_ILLEGAL_TYPE	= TCS_INT(-1);
  CS_CHAR_TYPE		= TCS_INT(0);
  CS_BINARY_TYPE	= TCS_INT(1);
  CS_LONGCHAR_TYPE	= TCS_INT(2);
  CS_LONGBINARY_TYPE	= TCS_INT(3);
  CS_TEXT_TYPE		= TCS_INT(4);
  CS_IMAGE_TYPE		= TCS_INT(5);
  CS_TINYINT_TYPE	= TCS_INT(6);
  CS_SMALLINT_TYPE	= TCS_INT(7);
  CS_INT_TYPE		= TCS_INT(8);
  CS_REAL_TYPE		= TCS_INT(9);
  CS_FLOAT_TYPE		= TCS_INT(10);
  CS_BIT_TYPE		= TCS_INT(11);
  CS_DATETIME_TYPE	= TCS_INT(12);
  CS_DATETIME4_TYPE	= TCS_INT(13);
  CS_MONEY_TYPE		= TCS_INT(14);
  CS_MONEY4_TYPE	= TCS_INT(15);
  CS_NUMERIC_TYPE	= TCS_INT(16);
  CS_DECIMAL_TYPE	= TCS_INT(17);
  CS_VARCHAR_TYPE	= TCS_INT(18);
  CS_VARBINARY_TYPE	= TCS_INT(19);
  CS_LONG_TYPE		= TCS_INT(20);
  CS_SENSITIVITY_TYPE	= TCS_INT(21);
  CS_BOUNDARY_TYPE	= TCS_INT(22);
  CS_VOID_TYPE		= TCS_INT(23);
  CS_USHORT_TYPE	= TCS_INT(24);
  CS_UNICHAR_TYPE	= TCS_INT(25);
  CS_BLOB_TYPE		= TCS_INT(26);

//** Define the minimum and maximum datatype values.
  CS_MIN_SYBTYPE 	= CS_CHAR_TYPE;
  CS_MAX_SYBTYPE 	= CS_UNICHAR_TYPE;

//** Define the number of datatypes that are supported by Sybase.
  CS_MAXSYB_TYPE	= CS_MAX_SYBTYPE + 1;

//** The minumum user-defined data type.
  CS_USER_TYPE		= TCS_INT(100);

//** Define the bit values used in the format element of the CS_DATAFMT
//** structure. The CS_FMT_JUSTIFY_RT flag exists for future use only.
  CS_FMT_UNUSED		= TCS_INT($00);
  CS_FMT_NULLTERM	= TCS_INT($01);
  CS_FMT_PADNULL	= TCS_INT($02);
  CS_FMT_PADBLANK	= TCS_INT($04);
  CS_FMT_JUSTIFY_RT	= TCS_INT($08);
  CS_FMT_STRIPBLANKS	= TCS_INT($10);
  CS_FMT_SAFESTR	= TCS_INT($20);

{*
** The following are bit values for the status field in the CS_DATAFMT
** structure.
**
** CS_HIDDEN		Set if this column would normally be hidden
**			from the user.
**
** CS_KEY		Set if the column is a key column.
**
** CS_VERSION_KEY	Set if the column is part of the version key for
**			the row.
**
** CS_NODATA		Not currently used in Open Client/Server.
**
** CS_UPDATABLE		Set if the column is an updatable cursor column.
**
** CS_CANBENULL		Set if the column can contain NULL values.
**
** CS_DESCIN
** CS_DESCOUT		Open Server-specific values for dynamic SQL.
**
** CS_INPUTVALUE	Set if the parameter is an input parameter value
**			for a Client-Library command.
**
** CS_UPDATECOL		Set if the parameter is the name of a column in
**			the update clause of a cursor declare command.
**
** CS_RETURN		Set if the parameter is a return parameter to
**			an RPC command.
**
** CS_TIMESTAMP		Set if the column is a timestamp column.
**
** CS_NODEFAULT		Open Server-specific status values for RPC parameters.
**
** CS_IDENTITY		Set if the column is an identity column.
**
*}
  CS_HIDDEN		= TCS_INT($0001);
  CS_KEY		= TCS_INT($0002);
  CS_VERSION_KEY	= TCS_INT($0004);
  CS_NODATA		= TCS_INT($0008);
  CS_UPDATABLE		= TCS_INT($0010);
  CS_CANBENULL		= TCS_INT($0020);
  CS_DESCIN		= TCS_INT($0040);
  CS_DESCOUT		= TCS_INT($0080);
  CS_INPUTVALUE		= TCS_INT($0100);
  CS_UPDATECOL		= TCS_INT($0200);
  CS_RETURN 		= TCS_INT($0400);
  CS_RETURN_CANBENULL	= TCS_INT($0420);  
  CS_TIMESTAMP		= TCS_INT($2000);
  CS_NODEFAULT		= TCS_INT($4000);
  CS_IDENTITY		= TCS_INT($8000);

{*
** The following are bit values for the status field in the CS_BROWSEDESC
** structure.
**
** CS_EXPRESSION	Set when the column is the result of an expression.
**
** CS_RENAMED		Set when that the column's heading is not the
**			original name of the column.
*}
  CS_EXPRESSION		= TCS_INT($0800);
  CS_RENAMED		= TCS_INT($1000);

{*
** Define special precision/scale value for using the precision/scale of the
** source element when doing a conversion from a numeric/decimal datatype to a
** numeric/decimal datatype.
*}
  CS_SRC_VALUE		= TCS_INT(-2562);

{*
** Minimum/maximum/default precision and scale values for numeric/decimal
** datatypes.
*}
  CS_MIN_PREC		= TCS_INT( 1);
  CS_MAX_PREC		= TCS_INT(77);
  CS_DEF_PREC		= TCS_INT(18);

  CS_MIN_SCALE		= TCS_INT( 0);
  CS_MAX_SCALE		= TCS_INT(77);
  CS_DEF_SCALE		= TCS_INT( 0);

{*
** The datetime format for converting datetime to char.
*}
  CS_DATES_SHORT	= TCS_INT(  0);	// default
  CS_DATES_MDY1		= TCS_INT(  1);	// mm/dd/yy
  CS_DATES_YMD1		= TCS_INT(  2);	// yy.mm.dd
  CS_DATES_DMY1		= TCS_INT(  3);	// dd/mm/yy
  CS_DATES_DMY2		= TCS_INT(  4);	// dd.mm.yy
  CS_DATES_DMY3		= TCS_INT(  5);	// dd-mm-yy
  CS_DATES_DMY4		= TCS_INT(  6);	// dd mon yy
  CS_DATES_MDY2		= TCS_INT(  7);	// mon dd, yy
  CS_DATES_HMS		= TCS_INT(  8);	// hh:mm:ss
  CS_DATES_LONG		= TCS_INT(  9);	// default with micro secs
  CS_DATES_MDY3		= TCS_INT( 10);	// mm-dd-yy
  CS_DATES_YMD2		= TCS_INT( 11);	// yy/mm/dd
  CS_DATES_YMD3		= TCS_INT( 12);	// yymmdd
  CS_DATES_YDM1		= TCS_INT( 13);	// yy/dd/mm
  CS_DATES_MYD1		= TCS_INT( 14);	// mm/yy/dd
  CS_DATES_DYM1		= TCS_INT( 15);	// dd/yy/mm
  CS_DATES_SHORT_ALT	= TCS_INT(100);	// default
  CS_DATES_MDY1_YYYY	= TCS_INT(101);	// mm/dd/yyyy
  CS_DATES_YMD1_YYYY	= TCS_INT(102);	// yyyy.mm.dd
  CS_DATES_DMY1_YYYY	= TCS_INT(103);	// dd/mm/yyyy
  CS_DATES_DMY2_YYYY	= TCS_INT(104);	// dd.mm.yyyy
  CS_DATES_DMY3_YYYY	= TCS_INT(105);	// dd-mm-yyyy
  CS_DATES_DMY4_YYYY	= TCS_INT(106);	// dd mon yyyy
  CS_DATES_MDY2_YYYY	= TCS_INT(107);	// mon dd, yyyy
  CS_DATES_HMS_ALT	= TCS_INT(108);	// hh:mm:ss
  CS_DATES_LONG_ALT	= TCS_INT(109);	// default with micro secs
  CS_DATES_MDY3_YYYY	= TCS_INT(110);	// mm-dd-yyyy
  CS_DATES_YMD2_YYYY	= TCS_INT(111);	// yyyy/mm/dd
  CS_DATES_YMD3_YYYY	= TCS_INT(112);	// yyyymmdd


{*
** sizeof macro which forces a CS_INT cast for portability.
*
  CS_SIZEOF		= (CS_INT)sizeof
}

{*
** Locale type information. CS_LC_MONETARY and CS_LC_NUMERIC are defined
** for future use.
*}
  CS_LC_COLLATE         = TCS_INT( 1);
  CS_LC_CTYPE           = TCS_INT( 2);
  CS_LC_MESSAGE         = TCS_INT( 3);
  CS_LC_MONETARY        = TCS_INT( 4);
  CS_LC_NUMERIC         = TCS_INT( 5);
  CS_LC_TIME            = TCS_INT( 6);
  CS_LC_ALL    		= TCS_INT( 7);
  CS_SYB_LANG		= TCS_INT( 8);
  CS_SYB_CHARSET	= TCS_INT( 9);
  CS_SYB_SORTORDER	= TCS_INT(10);
  CS_SYB_COLLATE	= CS_SYB_SORTORDER;
  CS_SYB_LANG_CHARSET	= TCS_INT(11);
  CS_SYB_TIME		= TCS_INT(12);
  CS_SYB_MONETARY	= TCS_INT(13);
  CS_SYB_NUMERIC	= TCS_INT(14);

{*
** Object type information for the cs_objects() API.
*}
  CS_CONNECTNAME      	= TCS_INT(  1);
  CS_CURSORNAME		= TCS_INT(  2);
  CS_STATEMENTNAME	= TCS_INT(  3);
  CS_CURRENT_CONNECTION	= TCS_INT(  4);
  CS_MIN_USERDATA	= TCS_INT(100);

{*
** Info type information for the ct_ds_objinfo() API.
*}
  CS_DS_CLASSOID 	= TCS_INT(1);
  CS_DS_DIST_NAME	= TCS_INT(2);
  CS_DS_NUMATTR		= TCS_INT(3);
  CS_DS_ATTRIBUTE	= TCS_INT(4);
  CS_DS_ATTRVALS 	= TCS_INT(5);


{*******************************************************************************
**
** Common datatype typedefs and structures used in client/server applications.
**
*******************************************************************************}

type

{*
** Define client/server datatypes.
**
** CS_FLOAT is defined in csconfig.h
*}
  TCS_TINYINT	= UCHAR;   	// 1 byte integer
  TCS_SMALLINT	= SHORT;       	// 2 byte integer
  TCS_CHAR	= Char;	 	// char type
  TCS_BINARY	= UCHAR;   	// binary type
  TCS_BIT	= UCHAR;   	// bit type
  TCS_REAL	= Single; 	// 4 byte float type
  TCS_BYTE	= UCHAR; 	// 1 byte byte
  TCS_TEXT	= UCHAR; 	// text data
  TCS_IMAGE	= UCHAR; 	// image data
  TCS_LONGCHAR	= UCHAR; 	// long char type
  TCS_LONGBINARY= UCHAR;	// long binary type
  TCS_LONG	= LongInt;	// long integer type
  TCS_VOIDDATA	= TCS_INT; 	// void data
  TCS_UNICHAR	= Word;       	// 2-byte unichar type

  PCS_CHAR	= TSDCharPtr;
  PCS_SMALLINT	= ^TCS_SMALLINT;

{
typedef   struct  cs_ctx_globs	CS_CTX_GLOBS;
typedef   struct  cs_ctx_locglobs	CS_CTX_LOCGLOBS;
}

{*
** The following typedefs are platform specific.
**
**	CS_VOID 	(compiler void differences)
**	CS_THRDRES	(compiler void differences)
**	CS_INT		(need to force it to 4 bytes)
**
** Please see the csconfig.h file for the actual definitions.
*}

//** Unsigned types (CS_UINT can be found in csconfig.h).
  TCS_USHORT		= Word;

{*
** The datetime structures.
*}
  _cs_datetime 	= record
    dtdays:	TCS_INT;		// number of days since 1/1/1900
    dttime:	TCS_INT;		// number 300th second since mid
  end;
  TCS_DATETIME	= _cs_datetime;
  PCS_DATETIME	= ^TCS_DATETIME;

  _cs_datetime4	= record
    days:	TCS_USHORT;	// number of days since 1/1/1900
    minutes:	TCS_USHORT;	// number of minutes since midnight
  end;
  TCS_DATETIME4	= _cs_datetime4;
  PCS_DATETIME4	= ^TCS_DATETIME4;

{*
** The money structures.
*}
  _cs_money	= record
    mnyhigh:	TCS_INT;
    mnylow:	TCS_UINT;
  end;
  TCS_MONEY	= _cs_money;

  _cs_money4	= record
    mny4:	TCS_INT;
  end;
  TCS_MONEY4	= TCS_INT;

{*
** The numeric structures.
*}
  _cs_numeric	= record
    precision:	TCS_BYTE;
    scale:	TCS_BYTE;
    num:	array[0..CS_MAX_NUMLEN-1] of TCS_BYTE;
  end;
  TCS_NUMERIC	= _cs_numeric;

  TCS_DECIMAL	= TCS_NUMERIC;

{*
** The var (pascal like) structures. Please don't confuse these datatypes
** with the Sybase server "varchar" column type.
*}
  _cs_varychar	= record
    len:	TCS_SMALLINT;            		// length of the string
    str:	array[0..CS_MAX_CHAR-1] of TCS_CHAR;	// string, no NULL terminator
  end;
  TCS_VARCHAR	= _cs_varychar;

  _cs_varybin	= record
    len:	TCS_SMALLINT;				// length of the binary array
    arr:	array[0..CS_MAX_CHAR-1] of TCS_BYTE;	// the array itself.
  end;
  TCS_VARBINARY	= _cs_varybin;

{*
** Datetime value information.
*}
  _cs_daterec	= record
    dateyear:	TCS_INT;		// 1900 to the future
    datemonth:	TCS_INT;		// 0 - 11
    datedmonth:	TCS_INT;		// 1 - 31
    datedyear:	TCS_INT;		// 1 - 366
    datedweek:	TCS_INT;		// 0 - 6 (Mon. - Sun.)
    datehour:	TCS_INT;		// 0 - 23
    dateminute:	TCS_INT;		// 0 - 59
    datesecond:	TCS_INT;		// 0 - 59
    datemsecond:TCS_INT;		// 0 - 997
    datetzone:	TCS_INT;		// 0 - 127
  end;
  TCS_DATEREC	= _cs_daterec;
  PCS_DATEREC	= ^TCS_DATEREC;

{*******************************************************************************
**
** Hidden information structures.
**
*******************************************************************************}

type

{*
** If passing code through lint, define the hidden structures as void.
*}

  TCS_CONTEXT	= TCS_VOID;
  TCS_LOCALE	= TCS_VOID;
  TCS_CONNECTION= TCS_VOID;
  TCS_COMMAND	= TCS_VOID;
  TCS_DS_OBJECT	= TCS_VOID;
  TCS_DS_RESULT	= TCS_VOID;

{$IFDEF SD_CLR}
  PCS_CONTEXT	= TCS_VOID;
  PCS_LOCALE	= TCS_VOID;
  PCS_CONNECTION= TCS_VOID;
  PCS_COMMAND	= TCS_VOID;
  PCS_DS_OBJECT	= TCS_VOID;
  PCS_DS_RESULT	= TCS_VOID;
{$ELSE}
  PCS_CONTEXT	= ^TCS_CONTEXT;
  PCS_LOCALE	= ^TCS_LOCALE;
  PCS_CONNECTION= ^TCS_CONNECTION;
  PCS_COMMAND	= ^TCS_COMMAND;
  PCS_DS_OBJECT	= ^TCS_DS_OBJECT;
  PCS_DS_RESULT	= ^TCS_DS_RESULT;
{$ENDIF}

{*
** Use anonymous structure tags to define the hidden structures.
*
typedef struct _cscontext	CS_CONTEXT;
typedef struct _cslocale  	CS_LOCALE;
typedef struct _csconnection	CS_CONNECTION;
typedef struct _cscommand	CS_COMMAND;
typedef struct _csdsobject	CS_DS_OBJECT;
typedef struct _csdsresult	CS_DS_RESULT;
}


{*******************************************************************************
**
** User-accessible information structures.
**
*******************************************************************************}

{*
** The data format structure used by Open Client/Server.
**
** name[CS_MAX_NAME]	The name of the data.
**
** namelen		The actual length of the name.
**
** datatype 		The datatype field indicates what Sybase
**			or user defined datatype is being represented.
**
** format		The format field tells whether or not data
**			should be padded to the full length of the
**			variable. This will only be used if the type
**			of the variable is character or binary. The
** 			format field also tells whether the data
**			should be null-terminated (for char
**			variables, only). This is a bit field in which
**			the format values are or'd together.
**
** maxlength		The max length the data might be.
**
** scale		This is used if dataytype needs it (e.g.
**			CS_NUMERIC)
**
** precision		This is used if dataytype needs it.
**
** status		Additional data status values. This is a bit
**			field in which the status values are or'd
**			together.
**
** count		If binding data, the count field tells how
**			many rows should be bound.
**
** usertype		User-defined datatype code passed back from
**			the Server.
**
** *locale		Pointer to the locale for this data.
*}
{$IFDEF SD_CLR}
  [StructLayout(LayoutKind.Sequential)]
  TCS_DATAFMT	= record
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_MAX_NAME)]
    name:	string;
    namelen:	TCS_INT;
    datatype:	TCS_INT;
    format:	TCS_INT;
    maxlength:	TCS_INT;
    scale:	TCS_INT;
    precision:	TCS_INT;
    status:	TCS_INT;
    count:	TCS_INT;
    usertype:	TCS_INT;
    locale:	PCS_LOCALE;
  end;
{$ELSE}
  _cs_datafmt	= record
    name:	array[0..CS_MAX_NAME-1] of TCS_CHAR;
    namelen:	TCS_INT;
    datatype:	TCS_INT;
    format:	TCS_INT;
    maxlength:	TCS_INT;
    scale:	TCS_INT;
    precision:	TCS_INT;
    status:	TCS_INT;
    count:	TCS_INT;
    usertype:	TCS_INT;
    locale:	PCS_LOCALE;
  end;
  TCS_DATAFMT	= _cs_datafmt;
  PCS_DATAFMT	= ^TCS_DATAFMT;
{$ENDIF}

{*
** The object name structure used by Client-Library cs_object() API.
**
** thinkexists 		indicates whether the application expects
**			this object to exist.
**
** object_type		The type of the object. This field is the
**			first part of a 5-part key.
**
** last_name		The `last name' associated with the object of
**			interest, if any. This field is the second
**			part of a 5-part key.
**
** lnlen		The length, in bytes, of last_name.
**
** first_name		The `first name' associated with the object of
**			interest, if any. This field is the third part
**			of a 5-part key.
**
** fnlen		The length, in bytes, of first_name.
**
** scope		Data that describes the scope of the object.
**			This field is the fourth part of a 5-part key.
**
** scopelen		The length, in bytes, of scope.
**
** thread		Platform-specific data that is used to distinguish
**			threads in a multi-threaded execution environment.
**			This field is the fifth part of a 5-part key.
**
** threadlen		The length, in bytes, of thread.
*}
  _cs_objname	= record
    thinkexists:TCS_BOOL;
    object_type:TCS_INT;
    last_name:	array[0..CS_MAX_NAME-1] of TCS_CHAR;
    lnlen:	TCS_INT;
    first_name:	array[0..CS_MAX_NAME-1] of TCS_CHAR;
    fnlen:	TCS_INT;
    scope:	PCS_VOID;
    scopelen:	TCS_INT;
    thread:	PCS_VOID;
    threadlen:	TCS_INT;
  end;
  TCS_OBJNAME	= _cs_objname;

{*
** The object data structure used by Client-Library cs_object() API.
**
** actuallyexists	Indicates whether this object actually exists.
**			cs_objects sets actuallyexists to CS_TRUE
**			if it finds a matching object.
**			cs_objects sets actuallyexists to CS_FALSE
**			if it does not find a matching object.
**
** connection		A pointer to the CS_CONNECTION structure
**			representing the connection in which the object exists.
**
** command		A pointer to the CS_COMMAND structure representing the
**			command space with which the object is associated,
**			if any.
**
** buffer		A pointer to data space. An application can
**			use buffer to associate data with a saved object.
**
** buflen		The length, in bytes, of *buffer.
**
*}
  _cs_objdata	= record
    actuallyexists:	TCS_BOOL;
    connection:		PCS_CONNECTION;
    command:		PCS_COMMAND;
    buffer:		PCS_VOID;
    buflen:		TCS_INT;
  end;
  TCS_OBJDATA	= _cs_objdata;

{*
** Definition of a pointer to a function for all conversion routines.
*}
type
  TCS_CONV_FUNC	= function (
			context: PCS_CONTEXT;
			var srcfmt: TCS_DATAFMT;
			src: PCS_VOID;
			var destfmt: TCS_DATAFMT;
			dest: PCS_VOID;
			var destlen: TCS_INT
		): TCS_RETCODE; stdcall;

{*
** Pointers to the thread primitive functions used in Open Client.
*}
  TCS_THRDM_FUNC= function (
			var resource: TCS_THRDRES
		): TCS_RETCODE; stdcall;
  TCS_THRDE_FUNC= function (
			var resource: TCS_THRDRES
		): TCS_RETCODE; stdcall;
  TCS_THRDC_FUNC= function (
			var resource: PCS_THRDRES
		): TCS_RETCODE; stdcall;
  TCS_THRDW_FUNC= function (
			var resource: TCS_THRDRES;
			millisecs: TCS_INT
		): TCS_RETCODE; stdcall;
  TCS_THRDID_FUNC= function (
			buffer: PCS_VOID;
			buflen: TCS_INT;
			var outlen: TCS_INT
		): TCS_RETCODE; stdcall;


{*
** Define the thread primitive structure. This structure is used by
** application programs to pass thread primitives into Client-Library.
** These primitives are used internally in Client-Library to run in a
** threaded environment.
**
** create_mutex_fn	Create a recursive mutex.
**
** delete_mutex_fn	Delete a mutex.
**
** take_mutex_fn	Lock a mutex.
**
** release_mutex_fn	Release a mutex.
**
** create_event_fn	Create an event variable.
**
** delete_event_fn	Delete an event variable.
**
** signal_event_fn	Signal event variable.
**
** reset_event_fn	Reset event variable.
**
** waitfor_event_fn	Wait for event to be signaled.
**
** thread_id_fn		Return id of currently executing thread.
*}
  _cs_thread	= record
    create_mutex_fn:	TCS_THRDC_FUNC;
    delete_mutex_fn:	TCS_THRDM_FUNC;
    take_mutex_fn:    	TCS_THRDM_FUNC;
    release_mutex_fn:	TCS_THRDM_FUNC;
    create_event_fn:	TCS_THRDC_FUNC;
    delete_event_fn:	TCS_THRDE_FUNC;
    signal_event_fn:	TCS_THRDE_FUNC;
    reset_event_fn:   	TCS_THRDE_FUNC;
    waitfor_event_fn:	TCS_THRDW_FUNC;
    thread_id_fn:     	TCS_THRDID_FUNC;
  end;
  TCS_THREAD	= _cs_thread;


{*
** Directory Service definitions
*}
const
{*
** Token name for predefined OID strings.
*}
  CS_OID_SYBASE		= '1.3.6.1.4.1.897';
  CS_OID_DIRECTORY	= '1.3.6.1.4.1.897.4';
  CS_OID_OBJCLASS	= '1.3.6.1.4.1.897.4.1';
  CS_OID_ATTRTYPE	= '1.3.6.1.4.1.897.4.2';
  CS_OID_ATTRSYNTAX	= '1.3.6.1.4.1.897.4.3';
  CS_OID_OBJSERVER	= '1.3.6.1.4.1.897.4.1.1';
  CS_OID_ATTRVERSION	= '1.3.6.1.4.1.897.4.2.1';
  CS_OID_ATTRSERVNAME	= '1.3.6.1.4.1.897.4.2.2';
  CS_OID_ATTRSERVICE	= '1.3.6.1.4.1.897.4.2.3';
  CS_OID_ATTRSTATUS	= '1.3.6.1.4.1.897.4.2.4';
  CS_OID_ATTRADDRESS	= '1.3.6.1.4.1.897.4.2.5';
  CS_OID_ATTRSECMECH	= '1.3.6.1.4.1.897.4.2.6';
  CS_OID_ATTRRETRYCOUNT	= '1.3.6.1.4.1.897.4.2.7';
  CS_OID_ATTRLOOPDELAY	= '1.3.6.1.4.1.897.4.2.8';

  CS_OID_ATTRJCPROTOCOL	= '1.3.6.1.4.1.897.4.2.9';
  CS_OID_ATTRJCPROPERTY	= '1.3.6.1.4.1.897.4.2.10';
  CS_OID_ATTRDATABASENAME='1.3.6.1.4.1.897.4.2.11';

  CS_OID_ATTRHAFAILOVER	= '1.3.6.1.4.1.897.4.2.15';
  CS_OID_ATTRRMNAME	= '1.3.6.1.4.1.897.4.2.16';
  CS_OID_ATTRRMTYPE	= '1.3.6.1.4.1.897.4.2.17';
  CS_OID_ATTRJDBCDSI	= '1.3.6.1.4.1.897.4.2.18';
  CS_OID_ATTRSERVERTYPE	= '1.3.6.1.4.1.897.4.2.19';

{*
** Current status of server object.
*}
  CS_STATUS_ACTIVE	= TCS_INT(1);
  CS_STATUS_STOPPED	= TCS_INT(2);
  CS_STATUS_FAILED	= TCS_INT(3);
  CS_STATUS_UNKNOWN	= TCS_INT(4);

{*
** Server object access type
*}
  CS_ACCESS_CLIENT	= TCS_INT(1);
  CS_ACCESS_ADMIN 	= TCS_INT(2);
  CS_ACCESS_MGMTAGENT	= TCS_INT(3);
  CS_ACCESS_CLIENT_QUERY       	= TCS_INT(1);
  CS_ACCESS_CLIENT_MASTER      	= TCS_INT(2);
  CS_ACCESS_ADMIN_QUERY        	= TCS_INT(3);
  CS_ACCESS_ADMIN_MASTER       	= TCS_INT(4);
  CS_ACCESS_MGMTAGENT_QUERY    	= TCS_INT(5);
  CS_ACCESS_MGMTAGENT_MASTER   	= TCS_INT(6);


type
{*
** String Attribute Value
**
**	This structure is used to describe a string attribute
**	value.
**
**	str_length	Length of string.
**	str_buffer	String data.
*}
  _cs_string	= record
    str_length:	TCS_INT;
    str_buffer:	array[0..CS_MAX_DS_STRING-1] of TCS_CHAR;
  end;
  TCS_STRING	= _cs_string;

{*
** Transport Address attribute value
**
**	This structure is used to describe a server address attribute
**	value.
**
**	addr_accesstype		Access type provided on transport
**				address.
**	addr_trantype		Transport address type
**	addr_tranaddress	The address string.
*}
  _cs_tranaddr	= record
    addr_accesstype:	TCS_INT;
    addr_trantype:	TCS_STRING;
    addr_tranaddress:	TCS_STRING;
  end;
  TCS_TRANADDR	= _cs_tranaddr;

{*
** Object Identifier
**
**	This structure is used to represent an Object
**		Identifier.
**
**	oid_length	Length of Object Identifier.
**	oid_buffer	Buffer containing object identifier.
*}
  _cs_oid	= record
  oid_length:	TCS_INT;
  oid_buffer:	array [0..CS_MAX_DS_STRING-1] of TCS_CHAR;
  end;
  TCS_OID	= _cs_oid;
  PCS_OID	= {$IFDEF SD_CLR}TCS_VOID{$ELSE}^TCS_OID{$ENDIF};

{*
** Attribute Value
**
**	This union is used to represent an attribute value.
**
*}
  _cs_attrvalue	= record
    value_string:	TCS_STRING;
    value_boolean:	TCS_BOOL;
    value_enumeration:	TCS_INT;
    value_integer:	TCS_INT;
    value_oid:		TCS_OID;
    value_tranaddr:	TCS_TRANADDR;
  end;
  TCS_ATTRVALUE	= _cs_attrvalue;

{*
** Attribute
**
**	This structure describes an attribute.
**
*}
  _cs_attribute	= record
    attr_type:		TCS_OID;
    attr_syntax:	TCS_INT;
    attr_numvals:	TCS_INT;
  end;
  TCS_ATTRIBUTE	= _cs_attribute;

{*
** Syntax identifier tokens for the CS_ATTRIBUTE union.
*}
const
  CS_ATTR_SYNTAX_NOOP		= TCS_INT(0);
  CS_ATTR_SYNTAX_STRING		= TCS_INT(1);
  CS_ATTR_SYNTAX_INTEGER	= TCS_INT(2);
  CS_ATTR_SYNTAX_BOOLEAN	= TCS_INT(3);
  CS_ATTR_SYNTAX_ENUMERATION	= TCS_INT(4);
  CS_ATTR_SYNTAX_TRANADDR	= TCS_INT(5);
  CS_ATTR_SYNTAX_OID		= TCS_INT(6);

{*
**	Structure for defining directory lookup criteria when using
**	ct_ds_lookup api.
*}
type
  _cs_ds_lookup_info	= record
    objclass:	PCS_OID;
    path:   	PCS_CHAR;
    pathlen:	TCS_INT;
    attrfilter:	PCS_DS_OBJECT;
    attrselect:	PCS_DS_OBJECT;
  end;
  TCS_DS_LOOKUP_INFO	= _cs_ds_lookup_info;

{*
** Predefined signal handlers for client and server signal handler
** libraries.
*}
const
  CS_SIGNAL_IGNORE	= -1;
  CS_SIGNAL_DEFAULT	= -2;
  CS_ASYNC_RESTORE	= -3;
  CS_SIGNAL_BLOCK	= -4;
  CS_SIGNAL_UNBLOCK	= -5;



{*******************************************************************************

**	cspublic.h (Sybase Open Client/Server Library) from 21.07.1997
**
** Include the core header files. These files contain the defines and
** data structures that are shared by all libraries.
*******************************************************************************}


const

{*******************************************************************************
** 	Size defines used in client/server applications.
*******************************************************************************}

{*
** Define the maximum size of a fully qualified table name.
*}
  CS_OBJ_NAME	= TCS_INT((CS_MAX_NAME * 3) + 4);

{*
** The maximum number of bytes in the server message or error message
** stored in the CS_SERVERMSG and CS_CLIENTMSG structures. If the total
** message is longer than this, multiple structures will be passed to the
** application program.
*}
  CS_MAX_MSG	= TCS_INT(1024);

{*
** The maximum number of bytes in a Sybase timestamp.
*}
  CS_TS_SIZE	= TCS_INT(8);

{*
** The maximum number of bytes in Sybase text pointers.
*}
  CS_TP_SIZE	= TCS_INT(16);

{*
** The size of the sqlstate array in the CS_SERVERMSG and CS_CLIENTMSG
** structures. Please note that this size is 2 bytes greater than what the
** standard specifies. Users should look at only the first 6 bytes in
** the array. That last 2 bytes are reserved to insure modulo 4 byte
** structure alignment.
*}
  CS_SQLSTATE_SIZE	= TCS_INT(8);

{*******************************************************************************
**
** Defines passed into Open Client/Server APIs.
**
*******************************************************************************}

{*
** Define all the library versions currently supported.
*}
  CS_VERSION_100	= TCS_INT(  112);
  CS_VERSION_110	= TCS_INT( 1100);
  CS_VERSION_125	= TCS_INT(12500);

{*
** Action flags used.
** 	CS_CACHE currently only used by OMI apis
*}
  CS_GET    		= TCS_INT(33);
  CS_SET    		= TCS_INT(34);
  CS_CLEAR		= TCS_INT(35);
  CS_INIT   		= TCS_INT(36);
  CS_STATUS		= TCS_INT(37);
  CS_MSGLIMIT		= TCS_INT(38);
  CS_SEND     		= TCS_INT(39);
  CS_SUPPORTED		= TCS_INT(40);
  CS_CACHE              = TCS_INT(41);

{*
** Bind indicator values. These are preferred when passing data into
** Client Library or Server Library, since they add the appropriate cast.
*}
  CS_GOODDATA		= TCS_SMALLINT( 0);
  CS_NULLDATA		= TCS_SMALLINT(-1);

{*
** Define ct_debug() operations.
*}
  CS_SET_FLAG		= TCS_INT(1700);
  CS_CLEAR_FLAG		= TCS_INT(1701);
  CS_SET_DBG_FILE    	= TCS_INT(1702);
  CS_SET_PROTOCOL_FILE	= TCS_INT(1703);

{*
** Define ct_debug() types of trace information.
*}
  CS_DBG_ALL		= TCS_INT($0001);
  CS_DBG_ASYNC		= TCS_INT($0002);
  CS_DBG_ERROR		= TCS_INT($0004);
  CS_DBG_MEM		= TCS_INT($0008);
  CS_DBG_PROTOCOL	= TCS_INT($0010);
  CS_DBG_PROTOCOL_STATES= TCS_INT($0020);
  CS_DBG_API_STATES	= TCS_INT($0040);
  CS_DBG_DIAG		= TCS_INT($0080);
  CS_DBG_NETWORK	= TCS_INT($0100);
  CS_DBG_API_LOGCALL	= TCS_INT($0200);

{*
** Cancel types.
*}
  CS_CANCEL_CURRENT	= TCS_INT(6000);
  CS_CANCEL_ALL		= TCS_INT(6001);
  CS_CANCEL_ATTN     	= TCS_INT(6002);
  CS_CANCEL_ABORT_NOTIF	= TCS_INT(6003);

{*
** Cursor fetch options. Currently these are not supported within Open
** Client and Open Server.
*}
  CS_FIRST		= TCS_INT(3000);
  CS_NEXT      		= TCS_INT(3001);
  CS_PREV      		= TCS_INT(3002);
  CS_LAST      		= TCS_INT(3003);
  CS_ABSOLUTE		= TCS_INT(3004);
  CS_RELATIVE		= TCS_INT(3005);

{*
** Op codes used in cs_calc().
*}
  CS_ADD     		= TCS_INT(1);
  CS_SUB     		= TCS_INT(2);
  CS_MULT    		= TCS_INT(3);
  CS_DIV     		= TCS_INT(4);
  CS_ZERO    		= TCS_INT(5);

{*
** The cs_dt_info() types.
*}
  CS_MONTH		= TCS_INT(7340);
  CS_SHORTMONTH		= TCS_INT(7341);
  CS_DAYNAME		= TCS_INT(7342);
  CS_DATEORDER		= TCS_INT(7343);
  CS_12HOUR		= TCS_INT(7344);
  CS_DT_CONVFMT		= TCS_INT(7345);

{*
** The cs_strcmp() options.
*}
  CS_COMPARE		= TCS_INT(7440);
  CS_SORT	  	= TCS_INT(7441);

{*
** Callback types.
*}
  CS_COMPLETION_CB	= TCS_INT(1);
  CS_SERVERMSG_CB	= TCS_INT(2);
  CS_CLIENTMSG_CB	= TCS_INT(3);
  CS_NOTIF_CB		= TCS_INT(4);
  CS_ENCRYPT_CB		= TCS_INT(5);
  CS_CHALLENGE_CB	= TCS_INT(6);
  CS_DS_LOOKUP_CB	= TCS_INT(7);
  CS_SECSESSION_CB	= TCS_INT(8);
  CS_SSLVALIDATE_CB	= TCS_INT(9);  

{*
** To install a signal callback, the type needs to calculated as an
** offset of the operating-system-specific signal number and the
** following define. For example, to install a callback handler for a
** SIGALRM signal, pass (CS_SIGNAL_CB + SIGALRM) to the ct_callback()
** routine.
*}
  CS_SIGNAL_CB		= TCS_INT(100);

{*
** Exit and close flags.
*}
  CS_FORCE_EXIT		= TCS_INT(300);
  CS_FORCE_CLOSE	= TCS_INT(301);

{*
** ct_diag() and cs_diag() type flags.
*}
  CS_CLIENTMSG_TYPE	= TCS_INT(4700);
  CS_SERVERMSG_TYPE	= TCS_INT(4701);
  CS_ALLMSG_TYPE 	= TCS_INT(4702);
  SQLCA_TYPE		= TCS_INT(4703);
  SQLCODE_TYPE		= TCS_INT(4704);
  SQLSTATE_TYPE		= TCS_INT(4705);

{*
** Compute info types.
*}
  CS_COMP_OP		= TCS_INT(5350);
  CS_COMP_ID		= TCS_INT(5351);
  CS_COMP_COLID		= TCS_INT(5352);
  CS_COMP_BYLIST  	= TCS_INT(5353);
  CS_BYLIST_LEN		= TCS_INT(5354);

{*
** Compute info operators.
*}
  CS_OP_SUM		= TCS_INT(5370);
  CS_OP_AVG		= TCS_INT(5371);
  CS_OP_COUNT		= TCS_INT(5372);
  CS_OP_MIN		= TCS_INT(5373);
  CS_OP_MAX		= TCS_INT(5374);

{*
** Browse types.
*}
  CS_ISBROWSE		= TCS_INT(9000);
  CS_TABNUM		= TCS_INT(9001);
  CS_TABNAME		= TCS_INT(9002);

{*
** Result types from ct_results().
*}
  CS_ROW_RESULT		= TCS_INT(4040);
  CS_CURSOR_RESULT	= TCS_INT(4041);
  CS_PARAM_RESULT 	= TCS_INT(4042);
  CS_STATUS_RESULT	= TCS_INT(4043);
  CS_MSG_RESULT		= TCS_INT(4044);
  CS_COMPUTE_RESULT	= TCS_INT(4045);
  CS_CMD_DONE		= TCS_INT(4046);
  CS_CMD_SUCCEED  	= TCS_INT(4047);
  CS_CMD_FAIL		= TCS_INT(4048);
  CS_ROWFMT_RESULT	= TCS_INT(4049);
  CS_COMPUTEFMT_RESULT	= TCS_INT(4050);
  CS_DESCRIBE_RESULT	= TCS_INT(4051);

{*
** Flags for getting result info using ct_res_info().
*}
  CS_ROW_COUNT		= TCS_INT(800);
  CS_CMD_NUMBER		= TCS_INT(801);
  CS_NUM_COMPUTES 	= TCS_INT(802);
  CS_NUMDATA		= TCS_INT(803);
  CS_ORDERBY_COLS 	= TCS_INT(804);
  CS_NUMORDERCOLS 	= TCS_INT(805);
  CS_MSGTYPE		= TCS_INT(806);
  CS_BROWSE_INFO  	= TCS_INT(807);
  CS_TRANS_STATE  	= TCS_INT(808);

{*
** Possible values for CS_TRANS_STATE.
*}
  CS_TRAN_UNDEFINED	= TCS_INT(0);
  CS_TRAN_IN_PROGRESS	= TCS_INT(1);
  CS_TRAN_COMPLETED	= TCS_INT(2);
  CS_TRAN_FAIL		= TCS_INT(3);
  CS_TRAN_STMT_FAIL	= TCS_INT(4);

{*
** Define the invalid count that the application gets when
** ct_res_info() is called at the wrong time.
*}
  CS_NO_COUNT		= TCS_INT(-1);

{*******************************************************************************
**
** Commands in Open Client/Server APIs.
**
*******************************************************************************}

{*
** ct_command() command types.
*}
  CS_LANG_CMD		= TCS_INT(148);
  CS_RPC_CMD		= TCS_INT(149);
  CS_MSG_CMD		= TCS_INT(150);
  CS_SEND_DATA_CMD	= TCS_INT(151);
  CS_PACKAGE_CMD    	= TCS_INT(152);
  CS_SEND_BULK_CMD	= TCS_INT(153);

{*
** ct_cursor() command types.
*}
  CS_CURSOR_DECLARE	= TCS_INT(700);
  CS_CURSOR_OPEN    	= TCS_INT(701);
  CS_CURSOR_ROWS    	= TCS_INT(703);
  CS_CURSOR_UPDATE	= TCS_INT(704);
  CS_CURSOR_DELETE	= TCS_INT(705);
  CS_CURSOR_CLOSE   	= TCS_INT(706);
  CS_CURSOR_DEALLOC	= TCS_INT(707);
  CS_CURSOR_OPTION	= TCS_INT(725);

{*
** Open Server-specific cursor command types.
*}
  CS_CURSOR_FETCH    	= TCS_INT(708);
  CS_CURSOR_INFO     	= TCS_INT(709);

{*
** ct_dyndesc() command types.
*}
  CS_ALLOC		= TCS_INT(710);
  CS_DEALLOC		= TCS_INT(711);
  CS_USE_DESC		= TCS_INT(712);
  CS_GETCNT		= TCS_INT(713);
  CS_SETCNT		= TCS_INT(714);
  CS_GETATTR		= TCS_INT(715);
  CS_SETATTR		= TCS_INT(716);

{*
** ct_dynamic() command types.
*}
  CS_PREPARE		= TCS_INT(717);
  CS_EXECUTE		= TCS_INT(718);
  CS_EXEC_IMMEDIATE	= TCS_INT(719);
  CS_DESCRIBE_INPUT	= TCS_INT(720);
  CS_DESCRIBE_OUTPUT	= TCS_INT(721);
  CS_DYN_CURSOR_DECLARE	= TCS_INT(722);


{*
** ct_dynsqlda() arguments and actions
*}
  CS_SQLDA_SYBASE 	= TCS_INT(729);
  CS_GET_IN		= TCS_INT(730);
  CS_GET_OUT		= TCS_INT(731);
  CS_SQLDA_BIND		= TCS_INT(732);
  CS_SQLDA_PARAM  	= TCS_INT(733);

{*
** Open Server-specific dynamic command types.
*}
  CS_PROCNAME		= TCS_INT(723);
  CS_ACK  		= TCS_INT(724);

{*
** ct_ds_objinfo() objinfo types.
*}
  CS_OBJ_CLASSOID	= TCS_INT(725);
  CS_OBJ_DNAME		= TCS_INT(726);
  CS_OBJ_NUMATTR 	= TCS_INT(727);
  CS_OBJ_ATRRIBUTE	= TCS_INT(728);

{*
** Command options
*}
  CS_RECOMPILE		= TCS_INT(188);
  CS_NO_RECOMPILE	= TCS_INT(189);
  CS_BULK_INIT		= TCS_INT(190);
  CS_BULK_CONT		= TCS_INT(191);
  CS_BULK_DATA		= TCS_INT(192);
  CS_COLUMN_DATA 	= TCS_INT(193);

{*
** Cursor options.
*}
  CS_FOR_UPDATE		= TCS_INT($01);
  CS_READ_ONLY		= TCS_INT($02);
  CS_DYNAMIC		= TCS_INT($04);		// Open Server only
  CS_RESTORE_OPEN	= TCS_INT($08);		// CT-Lib only
  CS_MORE    		= TCS_INT($10);
  CS_END    		= TCS_INT($20);
  CS_IMPLICIT_CURSOR	= TCS_INT($40);		// Added for implicit cursor  

{*
** Sybase-defined message ids for CS_MSG_CMDs.
*}
  CS_MSG_GETLABELS	= TCS_INT(6);
  CS_MSG_LABELS		= TCS_INT(7);
  CS_MSG_TABLENAME	= TCS_INT(8);
  CS_PARSE_TREE		= TCS_INT(8710);

{*
** Minimum and maximum user-defined message id for CS_MSG_CMDs.
*}
  CS_USER_MSGID		= TCS_INT(32768);
  CS_USER_MAX_MSGID	= TCS_INT(65535);

{*
** Defines for sp_regwatch registered procedure
*}
  CS_NOTIFY_ONCE        = $0002; 	// one-time notification request.
  CS_NOTIFY_ALWAYS      = $0004; 	// permanent notification request.
  CS_NOTIFY_WAIT        = $0020; 	// blocking notification request.
  CS_NOTIFY_NOWAIT      = $0040;	// non-blocking notification request.


{*******************************************************************************
** 			Open Client properties.
*******************************************************************************}

{*
** Properties that are used in *_props() functions.
*}
  CS_USERNAME		= TCS_INT(9100);
  CS_PASSWORD		= TCS_INT(9101);
  CS_APPNAME		= TCS_INT(9102);
  CS_HOSTNAME		= TCS_INT(9103);
  CS_LOGIN_STATUS      	= TCS_INT(9104);
  CS_TDS_VERSION       	= TCS_INT(9105);
  CS_CHARSETCNV		= TCS_INT(9106);
  CS_PACKETSIZE		= TCS_INT(9107);
  CS_USERDATA		= TCS_INT(9108);
  CS_COMMBLOCK		= TCS_INT(9109);
  CS_NETIO		= TCS_INT(9110);
  CS_NOINTERRUPT       	= TCS_INT(9111);
  CS_TEXTLIMIT		= TCS_INT(9112);
  CS_HIDDEN_KEYS       	= TCS_INT(9113);
  CS_VERSION		= TCS_INT(9114);
  CS_IFILE		= TCS_INT(9115);
  CS_LOGIN_TIMEOUT	= TCS_INT(9116);
  CS_TIMEOUT		= TCS_INT(9117);
  CS_MAX_CONNECT       	= TCS_INT(9118);
  CS_MESSAGE_CB	        = TCS_INT(9119);
  CS_EXPOSE_FMTS	= TCS_INT(9120);
  CS_EXTRA_INF		= TCS_INT(9121);
  CS_TRANSACTION_NAME	= TCS_INT(9122);
  CS_ANSI_BINDS		= TCS_INT(9123);
  CS_BULK_LOGIN		= TCS_INT(9124);
  CS_LOC_PROP		= TCS_INT(9125);
  CS_CUR_STATUS		= TCS_INT(9126);
  CS_CUR_ID		= TCS_INT(9127);
  CS_CUR_NAME		= TCS_INT(9128);
  CS_CUR_ROWCOUNT	= TCS_INT(9129);
  CS_PARENT_HANDLE	= TCS_INT(9130);
  CS_EED_CMD		= TCS_INT(9131);
  CS_DIAG_TIMEOUT	= TCS_INT(9132);
  CS_DISABLE_POLL	= TCS_INT(9133);
  CS_NOTIF_CMD		= TCS_INT(9134);
  CS_SEC_ENCRYPTION	= TCS_INT(9135);
  CS_SEC_CHALLENGE	= TCS_INT(9136);
  CS_SEC_NEGOTIATE	= TCS_INT(9137);
  CS_MEM_POOL		= TCS_INT(9138);
  CS_USER_ALLOC		= TCS_INT(9139);
  CS_USER_FREE		= TCS_INT(9140);
  CS_ENDPOINT		= TCS_INT(9141);
  CS_NO_TRUNCATE	= TCS_INT(9142);
  CS_CON_STATUS		= TCS_INT(9143);
  CS_VER_STRING		= TCS_INT(9144);
  CS_ASYNC_NOTIFS	= TCS_INT(9145);
  CS_SERVERNAME		= TCS_INT(9146);
  CS_THREAD_RESOURCE	= TCS_INT(9147);
  CS_NOAPI_CHK		= TCS_INT(9148);
  CS_SEC_APPDEFINED	= TCS_INT(9149);
  CS_NOCHARSETCNV_REQD	= TCS_INT(9150);
  CS_STICKY_BINDS	= TCS_INT(9151);
  CS_HAVE_CMD		= TCS_INT(9152);
  CS_HAVE_BINDS		= TCS_INT(9153);
  CS_HAVE_CUROPEN	= TCS_INT(9154);
  CS_EXTERNAL_CONFIG	= TCS_INT(9155);
  CS_CONFIG_FILE	= TCS_INT(9156);
  CS_CONFIG_BY_SERVERNAME=TCS_INT(9157);

{*
** Directory Service connection properties
*}
  CS_DS_CHAIN		= TCS_INT(9158);
  CS_DS_EXPANDALIAS	= TCS_INT(9159);
  CS_DS_COPY		= TCS_INT(9160);
  CS_DS_LOCALSCOPE	= TCS_INT(9161);
  CS_DS_PREFERCHAIN	= TCS_INT(9162);
  CS_DS_SCOPE		= TCS_INT(9163);
  CS_DS_SIZELIMIT 	= TCS_INT(9164);
  CS_DS_TIMELIMIT 	= TCS_INT(9165);
  CS_DS_PRINCIPAL 	= TCS_INT(9166);
// For CS_DS_PASSWORD (9198) see below   
  CS_DS_REFERRAL  	= TCS_INT(9167);
  CS_DS_SEARCH		= TCS_INT(9168);
  CS_DS_DITBASE		= TCS_INT(9169);
  CS_DS_FAILOVER  	= TCS_INT(9170);
  CS_NET_TRANADDR 	= TCS_INT(9171);
  CS_DS_PROVIDER  	= TCS_INT(9172);
  CS_RETRY_COUNT  	= TCS_INT(9173);
  CS_LOOP_DELAY   	= TCS_INT(9174);

{*
** Properties for Security services support
*}
  CS_SEC_NETWORKAUTH	= TCS_INT(9175);
  CS_SEC_DELEGATION	= TCS_INT(9176);
  CS_SEC_MUTUALAUTH	= TCS_INT(9177);
  CS_SEC_INTEGRITY	= TCS_INT(9178);
  CS_SEC_CONFIDENTIALITY= TCS_INT(9179);
  CS_SEC_CREDTIMEOUT	= TCS_INT(9180);
  CS_SEC_SESSTIMEOUT	= TCS_INT(9181);
  CS_SEC_DETECTREPLAY	= TCS_INT(9182);
  CS_SEC_DETECTSEQ	= TCS_INT(9183);
  CS_SEC_DATAORIGIN	= TCS_INT(9184);
  CS_SEC_MECHANISM	= TCS_INT(9185);
  CS_SEC_CREDENTIALS	= TCS_INT(9186);
  CS_SEC_CHANBIND	= TCS_INT(9187);
  CS_SEC_SERVERPRINCIPAL= TCS_INT(9188);
  CS_SEC_KEYTAB		= TCS_INT(9189);

{*
** More properties
*}
  CS_ABORTCHK_INTERVAL	= TCS_INT(9190);
  CS_LOGIN_TYPE		= TCS_INT(9191);
  CS_CON_KEEPALIVE	= TCS_INT(9192);
  CS_CON_TCP_NODELAY	= TCS_INT(9193);
  CS_LOGIN_REMOTE_SERVER= TCS_INT(9194);
  CS_LOGIN_REMOTE_PASSWD= TCS_INT(9195);

{*
** Property for reverting to behavior of earlier versions
*}
  CS_BEHAVIOR		= TCS_INT(9197);

{*
** Property for HA failover
*}
  CS_HAFAILOVER  	= TCS_INT(9196);

{*
** Property for Directory services. (belongs with CS_DS_* above)
** Added at LDAP implementation time.
*}
  CS_DS_PASSWORD	= TCS_INT(9198);

{*
** Properties for SSL
*}
  CS_PROP_SSL_PROTOVERSION     = TCS_INT(9200);
  CS_PROP_SSL_CIPHER	       = TCS_INT(9201);
  CS_PROP_SSL_LOCALID	       = TCS_INT(9202);
  CS_PROP_SSL_CA	       = TCS_INT(9203);
  CS_PROP_TLS_KEYREGEN	       = TCS_INT(9205);

{*
** CS_DS_SCOPE Values
*}
  CS_SCOPE_COUNTRY	= TCS_INT(1);
  CS_SCOPE_DMD		= TCS_INT(2);
  CS_SCOPE_WORLD 	= TCS_INT(3);

{*
** CS_DS_SEARCH Values
*}
  CS_SEARCH_OBJECT	= TCS_INT(1);
  CS_SEARCH_ONE_LEVEL	= TCS_INT(2);
  CS_SEARCH_SUBTREE	= TCS_INT(3);

{*
** Possible values for the CS_NETIO property.
*}
  CS_SYNC_IO		= TCS_INT(8111);
  CS_ASYNC_IO		= TCS_INT(8112);
  CS_DEFER_IO		= TCS_INT(8113);

{*
** Possible bit values for the CS_LOGIN_STATUS property.
*}
  CS_CONSTAT_CONNECTED	= TCS_INT($01);
  CS_CONSTAT_DEAD  	= TCS_INT($02);


{*
** Possible bit values for the CS_CUR_STATUS property.
*}
  CS_CURSTAT_NONE   	= TCS_INT($00);
  CS_CURSTAT_DECLARED	= TCS_INT($01);
  CS_CURSTAT_OPEN   	= TCS_INT($02);
  CS_CURSTAT_CLOSED	= TCS_INT($04);
  CS_CURSTAT_RDONLY	= TCS_INT($08);
  CS_CURSTAT_UPDATABLE	= TCS_INT($10);
  CS_CURSTAT_ROWCOUNT	= TCS_INT($20);
  CS_CURSTAT_DEALLOC	= TCS_INT($40);

{*
** Possible bit values for implicit cursor status
*}
  CS_IMPCURSTAT_NONE	       = TCS_INT($00);
  CS_IMPCURSTAT_READROWS       = TCS_INT($01);
  CS_IMPCURSTAT_CLOSED	       = TCS_INT($02);
  CS_IMPCURSTAT_SENDSUCCESS    = TCS_INT($04);
  CS_IMPCURSTAT_SENDDONE       = TCS_INT($08);

{*
** Possible values for the CS_TDS_VERSION property.
*}
  CS_TDS_40		= TCS_INT(7360);
  CS_TDS_42		= TCS_INT(7361);
  CS_TDS_46		= TCS_INT(7362);
  CS_TDS_495		= TCS_INT(7363);
  CS_TDS_50		= TCS_INT(7364);

{*
** Possible values for the CS_BEHAVIOR property.
*}
  CS_BEHAVIOR_100	= TCS_INT(7370);
  CS_BEHAVIOR_110	= TCS_INT(7371);
  CS_BEHAVIOR_120	= TCS_INT(7372);
  CS_BEHAVIOR_125	= TCS_INT(7373);

{*
** Possible values for the CS_PROP_SSL_PROTOVERSION property.
**
** If 2.0 handshake is desired with SSL 3.0 or TLS 1.0, or
** CS_SSLVER_20HAND
*}
  CS_SSLVER_20		= TCS_INT( 1 );
  CS_SSLVER_30		= TCS_INT( 2 );
  CS_SSLVER_TLS1	= TCS_INT( 3 );
  CS_SSLVER_20HAND	= TCS_INT( $80000000);

{*******************************************************************************
**
** Open Client/Server options.
**
*******************************************************************************}

{*
** The following is the list of all valid options:
*}
  CS_OPT_DATEFIRST      = TCS_INT(5001);		// Set first day of week
  CS_OPT_TEXTSIZE       = TCS_INT(5002);    	// Text size
  CS_OPT_STATS_TIME     = TCS_INT(5003);    	// Server time statistics
  CS_OPT_STATS_IO       = TCS_INT(5004);    	// Server I/O statistics
  CS_OPT_ROWCOUNT       = TCS_INT(5005);    	// Maximum row count
  CS_OPT_NATLANG        = TCS_INT(5006);    	// National Language
  CS_OPT_DATEFORMAT     = TCS_INT(5007);    	// Date format
  CS_OPT_ISOLATION      = TCS_INT(5008);    	// Transaction isolation level
  CS_OPT_AUTHON         = TCS_INT(5009);    	// Set authority level on
  CS_OPT_CHARSET        = TCS_INT(5010);    	// Character set
  CS_OPT_SHOWPLAN       = TCS_INT(5013);    	// show execution plan

  CS_OPT_NOEXEC         = TCS_INT(5014);    	// don't execute query
  CS_OPT_ARITHIGNORE    = TCS_INT(5015);    	// ignore arithmetic exceptions

  CS_OPT_TRUNCIGNORE    = TCS_INT(5016);    	// support ANSI null values
  CS_OPT_ARITHABORT     = TCS_INT(5017);    	// abort on arithmetic exceptions

  CS_OPT_PARSEONLY      = TCS_INT(5018);    	// parse only, return error msgs

  CS_OPT_GETDATA        = TCS_INT(5020);    	// return trigger data
  CS_OPT_NOCOUNT        = TCS_INT(5021);    	// don't print done count
  CS_OPT_FORCEPLAN      = TCS_INT(5023);    	// force variable substitute order

  CS_OPT_FORMATONLY     = TCS_INT(5024);    	// send format w/o row
  CS_OPT_CHAINXACTS     = TCS_INT(5025);    	// chained transaction mode
  CS_OPT_CURCLOSEONXACT = TCS_INT(5026);    	// close cursor on end trans
  CS_OPT_FIPSFLAG       = TCS_INT(5027);    	// FIPS flag
  CS_OPT_RESTREES     	= TCS_INT(5028);    	// return resolution trees
  CS_OPT_IDENTITYON     = TCS_INT(5029);    	// turn on explicit identity
  CS_OPT_CURREAD       	= TCS_INT(5030);    	// Set session label @@ curread

  CS_OPT_CURWRITE      	= TCS_INT(5031);    	// Set session label @@curwrite

  CS_OPT_IDENTITYOFF    = TCS_INT(5032);    	// turn off explicit identity
  CS_OPT_AUTHOFF      	= TCS_INT(5033);    	// Set authority level off
  CS_OPT_ANSINULL      	= TCS_INT(5034);    	// ANSI NULLS behavior
  CS_OPT_QUOTED_IDENT  	= TCS_INT(5035);    	// Quoted identifiers
  CS_OPT_ANSIPERM    	= TCS_INT(5036);    	// ANSI permission checking
  CS_OPT_STR_RTRUNC    	= TCS_INT(5037);    	// ANSI right truncation
  CS_OPT_SORTMERGE	= TCS_INT(5038);	// Sort merge join status   

  CS_MIN_OPTION		= CS_OPT_DATEFIRST;
  CS_MAX_OPTION		= CS_OPT_SORTMERGE;

{*
** The supported options are summarized below with their defined values
** for `ArgSize' and `OptionArg'. ArgSize specifies the domain of valid
** values that are allowed.
**
** Option			ArgSize		OptionArg
** ---------------		---------	---------
** CS_OPT_DATEFIRST 		1 byte		Defines below
** CS_OPT_TEXTSIZE 		4 bytes		Size in bytes
** CS_OPT_ROWCOUNT  		4 bytes		Number of rows
** CS_OPT_NATLANG 		OptionArg Len	National Lang (string)
** CS_OPT_DATEFORMAT 		1 byte		Defines below
** CS_OPT_ISOLATION 		1 byte		Defines below
** CS_OPT_AUTHON 		OptionArg Len	Table Name (string)
** CS_OPT_CHARSET 		OptionArg Len	Character set (string)
** CS_OPT_IDENTITYON 		OptionArg Len	Table Name (string)
** CS_OPT_CURREAD 		OptionArg Len	Read Label(string)
** CS_OPT_CURWRITE 		OptionArg Len	Write Label(string)
** CS_OPT_IDENTITYOFF 		OptionArg Len	Table Name (string)
** CS_OPT_AUTHOFF 		OptionArg Len	Table Name (string)
** (All remaining options)	1 byte		Boolean value
**
** All string values must be sent in 7 bit ASCII.
**
*}

{* CS_OPT_DATEFIRST *}
  CS_OPT_MONDAY		= TCS_INT(1);
  CS_OPT_TUESDAY     	= TCS_INT(2);
  CS_OPT_WEDNESDAY	= TCS_INT(3);
  CS_OPT_THURSDAY    	= TCS_INT(4);
  CS_OPT_FRIDAY		= TCS_INT(5);
  CS_OPT_SATURDAY    	= TCS_INT(6);
  CS_OPT_SUNDAY		= TCS_INT(7);

{* CS_OPT_DATEFORMAT *}
  CS_OPT_FMTMDY		= TCS_INT(1);
  CS_OPT_FMTDMY		= TCS_INT(2);
  CS_OPT_FMTYMD		= TCS_INT(3);
  CS_OPT_FMTYDM		= TCS_INT(4);
  CS_OPT_FMTMYD		= TCS_INT(5);
  CS_OPT_FMTDYM		= TCS_INT(6);

{* CS_OPT_ISOLATION *}
  CS_OPT_LEVEL0		= TCS_INT(0);
  CS_OPT_LEVEL1		= TCS_INT(1);
  CS_OPT_LEVEL3		= TCS_INT(3);

{*******************************************************************************
** 		Open Client/Server capabilities.
*******************************************************************************}

{*
** Capability types.
*}
  CS_CAP_REQUEST    	= TCS_INT(1);
  CS_CAP_RESPONSE   	= TCS_INT(2);

{*
** Special capability value to set/get all capability values at once.
*}
  CS_ALL_CAPS		= TCS_INT(2700);

{*
** Capability request values.
*}
  CS_REQ_LANG		= TCS_INT( 1);
  CS_REQ_RPC		= TCS_INT( 2);
  CS_REQ_NOTIF		= TCS_INT( 3);
  CS_REQ_MSTMT		= TCS_INT( 4);
  CS_REQ_BCP		= TCS_INT( 5);
  CS_REQ_CURSOR		= TCS_INT( 6);
  CS_REQ_DYN		= TCS_INT( 7);
  CS_REQ_MSG		= TCS_INT( 8);
  CS_REQ_PARAM		= TCS_INT( 9);
  CS_DATA_INT1		= TCS_INT(10);
  CS_DATA_INT2		= TCS_INT(11);
  CS_DATA_INT4		= TCS_INT(12);
  CS_DATA_BIT		= TCS_INT(13);
  CS_DATA_CHAR		= TCS_INT(14);
  CS_DATA_VCHAR		= TCS_INT(15);
  CS_DATA_BIN		= TCS_INT(16);
  CS_DATA_VBIN		= TCS_INT(17);
  CS_DATA_MNY8		= TCS_INT(18);
  CS_DATA_MNY4		= TCS_INT(19);
  CS_DATA_DATE8		= TCS_INT(20);
  CS_DATA_DATE4		= TCS_INT(21);
  CS_DATA_FLT4		= TCS_INT(22);
  CS_DATA_FLT8		= TCS_INT(23);
  CS_DATA_NUM		= TCS_INT(24);
  CS_DATA_TEXT		= TCS_INT(25);
  CS_DATA_IMAGE		= TCS_INT(26);
  CS_DATA_DEC		= TCS_INT(27);
  CS_DATA_LCHAR		= TCS_INT(28);
  CS_DATA_LBIN		= TCS_INT(29);
  CS_DATA_INTN		= TCS_INT(30);
  CS_DATA_DATETIMEN	= TCS_INT(31);
  CS_DATA_MONEYN    	= TCS_INT(32);
  CS_CSR_PREV		= TCS_INT(33);
  CS_CSR_FIRST		= TCS_INT(34);
  CS_CSR_LAST		= TCS_INT(35);
  CS_CSR_ABS		= TCS_INT(36);
  CS_CSR_REL		= TCS_INT(37);
  CS_CSR_MULTI		= TCS_INT(38);
  CS_CON_OOB		= TCS_INT(39);
  CS_CON_INBAND		= TCS_INT(40);
  CS_CON_LOGICAL    	= TCS_INT(41);
  CS_PROTO_TEXT		= TCS_INT(42);
  CS_PROTO_BULK		= TCS_INT(43);
  CS_REQ_URGNOTIF   	= TCS_INT(44);
  CS_DATA_SENSITIVITY	= TCS_INT(45);
  CS_DATA_BOUNDARY	= TCS_INT(46);
  CS_PROTO_DYNAMIC	= TCS_INT(47);
  CS_PROTO_DYNPROC	= TCS_INT(48);
  CS_DATA_FLTN		= TCS_INT(49);
  CS_DATA_BITN		= TCS_INT(50);
  CS_OPTION_GET		= TCS_INT(51);
  CS_DATA_INT8		= TCS_INT(52);
  CS_DATA_VOID		= TCS_INT(53);
  CS_DOL_BULK		= TCS_INT(54);
  CS_OBJECT_JAVA1   	= TCS_INT(55);
  CS_OBJECT_CHAR    	= TCS_INT(56);
  CS_DATA_COLUMNSTATUS	= TCS_INT(57);
  CS_OBJECT_BINARY	= TCS_INT(58);
  CS_REQ_RESERVED1	= TCS_INT(59);
  CS_WIDETABLES		= TCS_INT(60);
  CS_REQ_RESERVED2	= TCS_INT(61);
  CS_DATA_UINT2		= TCS_INT(62);
  CS_DATA_UINT4		= TCS_INT(63);
  CS_DATA_UINT8		= TCS_INT(64);
  CS_DATA_UINTN		= TCS_INT(65);
  CS_CUR_IMPLICIT	= TCS_INT(66);
  CS_DATA_UCHAR		= TCS_INT(67);

{*
** Minimum and maximum request capability values.
*}
  CS_MIN_REQ_CAP    	= CS_REQ_LANG;
  CS_MAX_REQ_CAP    	= CS_DATA_UCHAR;

{*
** Capability response values.
*}
  CS_RES_NOMSG		= TCS_INT( 1);
  CS_RES_NOEED		= TCS_INT( 2);
  CS_RES_NOPARAM    	= TCS_INT( 3);
  CS_DATA_NOINT1    	= TCS_INT( 4);
  CS_DATA_NOINT2    	= TCS_INT( 5);
  CS_DATA_NOINT4    	= TCS_INT( 6);
  CS_DATA_NOBIT		= TCS_INT( 7);
  CS_DATA_NOCHAR    	= TCS_INT( 8);
  CS_DATA_NOVCHAR   	= TCS_INT( 9);
  CS_DATA_NOBIN		= TCS_INT(10);
  CS_DATA_NOVBIN    	= TCS_INT(11);
  CS_DATA_NOMNY8    	= TCS_INT(12);
  CS_DATA_NOMNY4    	= TCS_INT(13);
  CS_DATA_NODATE8   	= TCS_INT(14);
  CS_DATA_NODATE4   	= TCS_INT(15);
  CS_DATA_NOFLT4    	= TCS_INT(16);
  CS_DATA_NOFLT8    	= TCS_INT(17);
  CS_DATA_NONUM		= TCS_INT(18);
  CS_DATA_NOTEXT    	= TCS_INT(19);
  CS_DATA_NOIMAGE   	= TCS_INT(20);
  CS_DATA_NODEC		= TCS_INT(21);
  CS_DATA_NOLCHAR   	= TCS_INT(22);
  CS_DATA_NOLBIN    	= TCS_INT(23);
  CS_DATA_NOINTN    	= TCS_INT(24);
  CS_DATA_NODATETIMEN	= TCS_INT(25);
  CS_DATA_NOMONEYN	= TCS_INT(26);
  CS_CON_NOOOB		= TCS_INT(27);
  CS_CON_NOINBAND   	= TCS_INT(28);
  CS_PROTO_NOTEXT   	= TCS_INT(29);
  CS_PROTO_NOBULK   	= TCS_INT(30);
  CS_DATA_NOSENSITIVITY	= TCS_INT(31);
  CS_DATA_NOBOUNDARY	= TCS_INT(32);
  CS_RES_NOTDSDEBUG	= TCS_INT(33);
  CS_RES_NOSTRIPBLANKS	= TCS_INT(34);
  CS_DATA_NOINT8	= TCS_INT(35);
  CS_OBJECT_NOJAVA1	= TCS_INT(36);
  CS_OBJECT_NOCHAR	= TCS_INT(37);
  CS_DATA_NOZEROLEN	= TCS_INT(38);
  CS_OBJECT_NOBINARY	= TCS_INT(39);
  CS_RES_RESERVED  	= TCS_INT(40);
  CS_DATA_NOUINT2  	= TCS_INT(41);
  CS_DATA_NOUINT4  	= TCS_INT(42);
  CS_DATA_NOUINT8  	= TCS_INT(43);
  CS_DATA_NOUINTN  	= TCS_INT(44);
  CS_NOWIDETABLES  	= TCS_INT(45);
  CS_DATA_NOUCHAR  	= TCS_INT(46);

{*
** Minimum and maximum response capability values.
*}
  CS_MIN_RES_CAP	= CS_RES_NOMSG;
  CS_MAX_RES_CAP	= CS_DATA_NOUCHAR;

{*
** Minimum and maximum of all capabilities defined above.
*}
  CS_MIN_CAPVALUE	= CS_REQ_LANG;
  CS_MAX_CAPVALUE	= CS_DATA_NOUCHAR;

{*
** Size of area to store capabilities. The array len must be greater than
** ((CS_CAP_MAX / CS_BITS_PER_BYTE) + 1). The current value allows
** additional capabilities to be added.
*}
  CS_CAP_ARRAYLEN	= 16;

{*
** Maximum OID length (bytes)
*}
  CS_MAX_OIDLEN		= 255;

{*
** Index used by access macros so that the first byte in the array will
** contain the high order bit.
*
#define CS_CAP_IDX(B)		((CS_CAP_ARRAYLEN - (B)/ CS_BITS_PER_BYTE) - 1)
}

type
{*
** Data structure defining storage for capabilities.
*}
  _cs_cap_type	= record
    mask:	array[0..CS_CAP_ARRAYLEN-1] of TCS_BYTE;
  end;
  TCS_CAP_TYPE	= _cs_cap_type;

{*
** Access macros for CS_CAP_TYPE structure.
*/
#define	CS_SET_CAPMASK(M, B)	((M)->mask[CS_CAP_IDX(B)] |= \
					(1 << ((B) % CS_BITS_PER_BYTE)))
#define	CS_CLR_CAPMASK(M, B)	((M)->mask[CS_CAP_IDX(B)] &= \
					~(1 << ((B) % CS_BITS_PER_BYTE)))
#define	CS_TST_CAPMASK(M, B)	((M)->mask[CS_CAP_IDX(B)] & \
					(1 << ((B) % CS_BITS_PER_BYTE)))
}

{*******************************************************************************
** 		Defines used in Open Client/Server structures.
*******************************************************************************}

const

{*
** Define I/O types in the CS_IODESC structure.
*}
  CS_IODATA		= TCS_INT(1600);

{*
** Define status values for the status field of the CS_SERVERMSG and
** CS_CLIENTMSG structures.
*}
  CS_HASEED		= TCS_INT($01);
  CS_FIRST_CHUNK   	= TCS_INT($02);
  CS_LAST_CHUNK		= TCS_INT($04);

{*******************************************************************************
** 		Hidden information structures.
*******************************************************************************}
type
{*
** If passing code through lint, define the hidden structures as void.
*}
  TCS_LOGINFO	= TCS_VOID;
  TCS_BLKDESC	= TCS_VOID;
  TCS_BLK_ROW	= TCS_VOID;

  PCS_LOGINFO	= TCS_VOID;  

{*******************************************************************************
** User-accessible information structures.
*******************************************************************************}

{*
** Define the I/O descriptor structure used by Open Client/Server.
**
** iotype		Indicates the type of I/O to perform. For text
**			and image operations, iotype always has the
**			value CS_IODATA.
**
** datatype		The datatype of the data object. The only legal
**			values for datatype are CS_TEXT_TYPE and
**			CS_IMAGE_TYPE.
**
** *locale		A pointer to a CS_LOCALE structure containing
**		 	localization information for the text or image
**			value. Set locale to NULL if localization
**			information is not required.
**
** usertype		The SQL Server user-defined datatype of the data
**			object, if any.
**
** total_txtlen		The total length, in bytes, of the text or image
**			value.
**
** offset		Reserved for future use.
**
** log_on_update	Whether the update for this text object should
**			be logged or not.
**
** name			The name of the text or image column. name is a
**			string of the form table.column.
**
** namelen		The actual length of name
**
** timestamp	 	The text timestamp of the column. A text
**			timestamp marks the time of a text or image
**			column's last modification.
**
** timestamplen		The length, in bytes, of timestamp.
**
** textptr		The text pointer for the column. A text pointer
**			is an internal server pointer that points to the
**			data for a text or image column. textptr identifies
**			the target column in a send-data operation.
**
** textptrlen		The length, in bytes, of textptr.
*}
{$IFNDEF SD_CLR}
  _cs_iodesc	= record
    iotype:		TCS_INT;
    datatype:		TCS_INT;
    locale:		PCS_LOCALE;
    usertype:		TCS_INT;
    total_txtlen:	TCS_INT;
    offset:		TCS_INT;
    log_on_update:	TCS_BOOL;
    name:		array[0..CS_OBJ_NAME-1] of TCS_CHAR;
    namelen:		TCS_INT;
    timestamp:		array[0..CS_TS_SIZE-1] of TCS_BYTE;
    timestamplen:	TCS_INT;
    textptr:		array[0..CS_TP_SIZE-1] of TCS_BYTE;
    textptrlen:		TCS_INT;
  end;
  TCS_IODESC	= _cs_iodesc;
{$ENDIF}

{*
** Define the browse descriptor structure used by Open Client/Server.
**
** status		A bit mask of either CS_EXPRESSION and/or CS_RENAMED.
**
** isbrowse		CS_TRUE the column can be browse-mode updated.
**
** origname		The original name of the column in the database.
**
** orignlen		Length of origname in bytes.
**
** tablenum		The number of the table to which the column
**			belongs. The first table in a select statement's
**			from-list is table number 1, the second number 2,
**			and so forth.
**
** tablename		The name of the table to which the column belongs.
**
** tabnlen		Length of tablename in bytes.
**
*}
  _cs_browsedesc	= record
    status:	TCS_INT;
    isbrowse:	TCS_BOOL;
    origname:	array[0..CS_MAX_NAME-1] of TCS_CHAR;
    orignlen:	TCS_INT;
    tablenum:	TCS_INT;
    tablename:	array[0..CS_OBJ_NAME-1] of TCS_CHAR;
    tabnlen:	TCS_INT;
  end;
  TCS_BROWSEDESC	= _cs_browsedesc;

{*
** Define the server message structure used by Open Client/Server.
**
** msgnumber		The server message number.
**
** state		The server error state.
**
** severity		The severity of the message.
**
** text			The text of the error string. If an application
**			is not sequencing messages, text is guaranteed
**			to be null-terminated, even if it has been
**			truncated. If an application is sequencing
**			messages, text is null-terminated only if it is
**			the last chunk of a sequenced message.
**
** textlen		The length, in bytes, of text.
**
** svrname		The name of the server that generated the message.
**
** svrnlen		The length, in bytes, of svrname.
**
** proc			The name of the stored procedure which caused
**			the message, if any.
**
** proclen		The length, in bytes, of proc.
**
** line			The line number, if any, of the line that caused
**			the message. line can be a line number in a
**			stored procedure or a line number in a command
**			batch.
**
** status		A bitmask used to indicate various types of
**			information, such as whether or not extended
**			error data is included with the message.
**
** sqlstate		SQL state information.
**
** sqlstatelen		The length, in bytes, of sqlstate.
**
*}
{$IFNDEF SD_CLR}
  _cs_servermsg	= record
    msgnumber:	TCS_MSGNUM;
    state:	TCS_INT;
    severity:	TCS_INT;
    text:	array[0..CS_MAX_MSG-1] of TCS_CHAR;
    textlen:	TCS_INT;
    svrname:	array[0..CS_MAX_NAME-1] of TCS_CHAR;
    svrnlen:	TCS_INT;
    proc:	array[0..CS_MAX_NAME-1] of TCS_CHAR;
    proclen:	TCS_INT;
    line:	TCS_INT;
    status:	TCS_INT;
    sqlstate:	array[0..CS_SQLSTATE_SIZE-1] of TCS_BYTE;
    sqlstatelen:TCS_INT;
  end;
  TCS_SERVERMSG	= _cs_servermsg;

{*
** Define the client message structure used by Open Client/Server.
**
** severity		A symbolic value representing the severity of
**			the message.
**
** msgnumber		The message number. For information on how to
**			interpret this number in Client-Library
**			applications, see the Client-Library Messages
**			topics in the Open Client documentation.
**
** msgstring		The message string. If an application is not
**			sequencing messages, msgstring is guaranteed to
**			be null-terminated, even if it has been truncated.
**			If an application is sequencing messages,
**			msgstring is null-terminated only if it is the
**			last chunk of a sequenced message.
**
** msgstringlen		The length, in bytes, of msgstring.
**
** osnumber		An error may have involved interactions the
**			operating system (OS). If so, the OS error
**			number would be stored here. Otherwise,
**			this will be zero.
**
** osstring		The operating system error text (if any).
**
** osstringlen		The length, in bytes, of osstring.
**
** status		A bitmask used to indicate various types of
**			information, such as whether or not this is the
**			first, a middle, or the last chunk of an error
**			message.
**
** sqlstate		SQL state information.
**
** sqlstatelen		The length, in bytes, of sqlstate.
**
*}
  _cs_clientmsg	= record
    severity:		TCS_INT;
    msgnumber:		TCS_MSGNUM;
    msgstring:		array[0..CS_MAX_MSG-1] of TCS_CHAR;
    msgstringlen:	TCS_INT;
    osnumber:		TCS_INT;
    osstring:		array[0..CS_MAX_MSG-1] of TCS_CHAR;
    osstringlen:	TCS_INT;
    status:		TCS_INT;
    sqlstate:		array[0..CS_SQLSTATE_SIZE-1] of TCS_BYTE;
    sqlstatelen:	TCS_INT;
  end;
  TCS_CLIENTMSG	= _cs_clientmsg;
{$ENDIF}

{*******************************************************************************
**
** Define user-accessable functions for Client/Server Library here.
**
*******************************************************************************}
{$IFNDEF SD_CLR}
{*
** Declare all functions.
*}
var

// CS_PUBLIC	= stdcall
//* cscalc.c
  cs_calc:		function(
	context: PCS_CONTEXT;
	op, datatype: TCS_INT;
	var1, var2, dest: PCS_VOID
	): TCS_RETCODE; stdcall;

//* cscmp.c
  cs_cmp:		function(
	context: PCS_CONTEXT;
	datatype: TCS_INT;
	var1, var2: PCS_VOID;
	var result: TCS_INT
	): TCS_RETCODE; stdcall;
//* cscnvrt.c
  cs_convert:		function(
	context: PCS_CONTEXT;
	var srcfmt: TCS_DATAFMT;
	srcdata: PCS_VOID;
	var destfmt: TCS_DATAFMT;
	destdata: PCS_VOID;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
  cs_will_convert:	function(
	context: PCS_CONTEXT;
	srctype, desttype: TCS_INT;
	var result: TCS_BOOL
	): TCS_RETCODE; stdcall;
  cs_set_convert:	function(
	context: PCS_CONTEXT;
	action,	srctype, desttype: TCS_INT;
	buffer: TCS_CONV_FUNC
	): TCS_RETCODE; stdcall;
  cs_setnull:		function(
	context: PCS_CONTEXT;
	var datafmt: TCS_DATAFMT;
	buf: PCS_VOID;
	buflen: TCS_INT
	): TCS_RETCODE; stdcall;

//* csconfig.c
  cs_config:		function(
	context: PCS_CONTEXT;
	action,	prop: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;

//* csctxall.c
  cs_ctx_alloc:		function(
	version: TCS_INT;
	var outptr: PCS_CONTEXT
	): TCS_RETCODE; stdcall;

//* csctxdrp.c
  cs_ctx_drop:		function(
	context: PCS_CONTEXT
	): TCS_RETCODE; stdcall;

//* csctxglb.c
  cs_ctx_global:	function(
	version: TCS_INT;
	var outptr: PCS_CONTEXT
	): TCS_RETCODE; stdcall;

//* csobjs.c
  cs_objects:		function(
	context: PCS_CONTEXT;
	action: TCS_INT;
	var objname: TCS_OBJNAME;
	var objdata: TCS_OBJDATA
	): TCS_RETCODE; stdcall;

//* csdiag.c
  cs_diag:		function(
	context: PCS_CONTEXT;
	operation, typ, idx: TCS_INT;
	buffer: PCS_VOID
	): TCS_RETCODE; stdcall;

//* csdtcrak.c
  cs_dt_crack:		function(
	context: PCS_CONTEXT;
	datetype: TCS_INT;
	dateval: PCS_VOID;
	var daterec: TCS_DATEREC
	): TCS_RETCODE; stdcall;

//* csdtinfo.c
  cs_dt_info:		function(
	context: PCS_CONTEXT;
	action: TCS_INT;
	locale: PCS_LOCALE;
	typ, item: TCS_INT;
	buffer: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;

//* csloc.c
  cs_locale:		function(
	context: PCS_CONTEXT;
	action: TCS_INT;
	locale: PCS_LOCALE;
	typ: TCS_INT;
	buffer: PCS_CHAR;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;

//* cslocall.c
  cs_loc_alloc:		function(
	context: PCS_CONTEXT;
	var loc_pointer: PCS_LOCALE
	): TCS_RETCODE; stdcall;

//* cslocdrp.c
  cs_loc_drop:		function(
	context: PCS_CONTEXT;
	var loc_pointer: PCS_LOCALE
	): TCS_RETCODE; stdcall;

{/* csstr.c */
#ifdef CS__INTERNAL_STRUCTS
extern CS_RETCODE CS_VARARGS cs_strbuild PROTOTYPE((
	CS_CONTEXT *context,
	...
	));
#else
extern CS_RETCODE CS_VARARGS cs_strbuild PROTOTYPE((
	CS_CONTEXT *context,
	CS_CHAR *buf,
	TCS_INT buflen,
	TCS_INT *outlen,
	CS_CHAR *text,
	TCS_INT textlen,
	...
	));
#endif /* CS__INTERNAL_STRUCTS */
}

//* csstrcmp.c
  cs_strcmp:		function(
	context: PCS_CONTEXT;
	locale: PCS_LOCALE;
	typ: TCS_INT;
	str1: PCS_CHAR;
	len1: TCS_INT;
	str2: PCS_CHAR;
	len2: TCS_INT;
	var result: TCS_INT
	): TCS_RETCODE; stdcall;

//* cstime.c
  cs_time:		function(
	context: PCS_CONTEXT;
	locale: PCS_LOCALE;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT;
	var drec: TCS_DATEREC
	): TCS_RETCODE; stdcall;

//* csmancnt.c
  cs_manage_convert:	function(
	context: PCS_CONTEXT;
	action,	srctype: TCS_INT;
	srcname: PCS_CHAR;
	srcnamelen, desttype: TCS_INT;
	destname: PCS_CHAR;
	destnamelen: TCS_INT;
	var maxmultiplier: TCS_INT;
	func: TCS_CONV_FUNC
	): TCS_RETCODE; stdcall;

//* csmaxmul.c
  cs_conv_mult:		function(
	context: PCS_CONTEXT;
	srcloc, destloc: PCS_LOCALE;
	var multiplier: TCS_INT
	): TCS_RETCODE; stdcall;
{$ENDIF}

{*******************************************************************************
**	ctpublic.h (Sybase CT-LIBRARY Version 5.0) from 21.07.1997
**
** ctpublic.h - This is the header file for 5.0 CT-Lib.
*******************************************************************************}


{*******************************************************************************
** 		defines used in CT-Lib applications
*******************************************************************************}

const

{*
** define for each CT-Lib API
*
  CT_BIND	       	= TCS_INT(  0 );
  CT_BR_COLUMN		= TCS_INT(  1 );
  CT_BR_TABLE		= TCS_INT(  2 );
  CT_CALLBACK		= TCS_INT(  3 );
  CT_CANCEL		= TCS_INT(  4 );
  CT_CAPABILITY		= TCS_INT(  5 );
  CT_CLOSE		= TCS_INT(  6 );
  CT_CMD_ALLOC		= TCS_INT(  7 );
  CT_CMD_DROP		= TCS_INT(  8 );
  CT_CMD_PROPS		= TCS_INT(  9 );
  CT_COMMAND		= TCS_INT( 10 );
  CT_COMPUTE_INFO      	= TCS_INT( 11 );
  CT_CON_ALLOC		= TCS_INT( 12 );
  CT_CON_DROP		= TCS_INT( 13 );
  CT_CON_PROPS		= TCS_INT( 14 );
  CT_CON_XFER		= TCS_INT( 15 );
  CT_CONFIG		= TCS_INT( 16 );
  CT_CONNECT		= TCS_INT( 17 );
  CT_CURSOR		= TCS_INT( 18 );
  CT_DATA_INFO		= TCS_INT( 19 );
  CT_DEBUG		= TCS_INT( 20 );
  CT_DESCRIBE		= TCS_INT( 21 );
  CT_DIAG		= TCS_INT( 22 );
  CT_DYNAMIC		= TCS_INT( 23 );
  CT_DYNDESC		= TCS_INT( 24 );
  CT_EXIT		= TCS_INT( 25 );
  CT_FETCH		= TCS_INT( 26 );
  CT_GET_DATA		= TCS_INT( 27 );
  CT_GETFORMAT		= TCS_INT( 28 );
  CT_GETLOGINFO		= TCS_INT( 29 );
  CT_INIT		= TCS_INT( 30 );
  CT_KEYDATA		= TCS_INT( 31 );
  CT_OPTIONS		= TCS_INT( 32 );
  CT_PARAM		= TCS_INT( 33 );
  CT_POLL		= TCS_INT( 34 );
  CT_RECVPASSTHRU	= TCS_INT( 35 );
  CT_REMOTE_PWD		= TCS_INT( 36 );
  CT_RES_INFO		= TCS_INT( 37 );
  CT_RESULTS		= TCS_INT( 38 );
  CT_SEND		= TCS_INT( 39 );
  CT_SEND_DATA		= TCS_INT( 40 );
  CT_SENDPASSTHRU	= TCS_INT( 41 );
  CT_SETLOGINFO		= TCS_INT( 42 );
  CT_WAKEUP		= TCS_INT( 43 );
  CT_LABELS		= TCS_INT( 44 );
  CT_DS_LOOKUP		= TCS_INT( 45 );
  CT_DS_DROP		= TCS_INT( 46 );
  CT_DS_OBJINFO		= TCS_INT( 47 );
  CT_SETPARAM		= TCS_INT( 48 );
  CT_DYNSQLDA		= TCS_INT( 49 );}
  CT_NOTIFICATION	= TCS_INT(1000);	// id for event notfication completion

  CT_USER_FUNC		= TCS_INT(10000);// minimum user-defined function id

{$IFNDEF SD_CLR}

{*******************************************************************************
** 		define all user accessable functions here
*******************************************************************************}

{*
** declare all functions
*}
var
//* ctdebug.c
  ct_debug:		function(
	context: PCS_CONTEXT;
	connection: PCS_CONNECTION;
	operation, flag: TCS_INT;
	filename: PCS_CHAR;
	fnamelen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctbind.c
  ct_bind:		function(
	cmd: PCS_COMMAND;
	item: TCS_INT;
	var datafmt: TCS_DATAFMT;
	buf: PCS_VOID;
	outputlen: PCS_INT;
	indicator: PCS_SMALLINT
	): TCS_RETCODE; stdcall;
//* ctbr.c
  ct_br_column:		function(
	cmd: PCS_COMMAND;
	colnum: TCS_INT;
	var browsedesc: TCS_BROWSEDESC
	): TCS_RETCODE; stdcall;
  ct_br_table:		function(
	cmd: PCS_COMMAND;
	tabnum, typ: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctcallbk.c
  ct_callback:		function(
	context: PCS_CONTEXT;
	connection: PCS_CONNECTION;
	action,	typ: TCS_INT;
	func: PCS_VOID
	): TCS_RETCODE; stdcall;
//* ctcancel.c
  ct_cancel:		function(
	connection: PCS_CONNECTION;
	cmd: PCS_COMMAND;
	typ: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctcap.c
  ct_capability:	function(
	connection: PCS_CONNECTION;
	action, typ, capability: TCS_INT;
	val: PCS_VOID
	): TCS_RETCODE; stdcall;
//* ctcinfo.c
  ct_compute_info:	function(
	cmd: PCS_COMMAND;
	typ, colnum: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctclose.c
  ct_close:		function(
	connection: PCS_CONNECTION;
	option: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctcmd.c
  ct_cmd_alloc:		function(
	connection: PCS_CONNECTION;
	var cmdptr: PCS_COMMAND
	): TCS_RETCODE; stdcall;
  ct_cmd_drop:		function(
	cmd: PCS_COMMAND
	): TCS_RETCODE; stdcall;
  ct_cmd_props:		function(
	cmd: PCS_COMMAND;
	action, prop: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
  ct_command:		function(
	cmd: PCS_COMMAND;
	typ: TCS_INT;
	buf: PCS_CHAR;
	buflen, option: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctcon.c
  ct_con_alloc:		function(
	context: PCS_CONTEXT;
	var connection: PCS_CONNECTION
	): TCS_RETCODE; stdcall;
  ct_con_drop:		function(
	connection: PCS_CONNECTION
	): TCS_RETCODE; stdcall;
  ct_con_props:		function(
	connection: PCS_CONNECTION;
	action, prop: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	outlen: PCS_INT
	): TCS_RETCODE; stdcall;
  ct_connect:		function(
	connection: PCS_CONNECTION;
	server_name: PCS_CHAR;
	snamelen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctconfig.c
  ct_config:		function(
	context: PCS_CONTEXT;
	action, prop: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	outlen: PCS_INT
	): TCS_RETCODE; stdcall;
//* ctcursor.c
  ct_cursor:		function(
	cmd: PCS_COMMAND;
	typ: TCS_INT;
	name: PCS_CHAR;
	namelen: TCS_INT;
	text: PCS_CHAR;
	tlen, option: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctddesc.c
  ct_dyndesc:		function(
	cmd: PCS_COMMAND;
	descriptor: PCS_CHAR;
	desclen, operation, idx: TCS_INT;
	var datafmt: TCS_DATAFMT;
	buffer: PCS_VOID;
	buflen: TCS_INT;
	var copied: TCS_INT;
	var indicator: TCS_SMALLINT
	): TCS_RETCODE; stdcall;
//* ctdesc.c
  ct_describe:		function(
	cmd: PCS_COMMAND;
	item: TCS_INT;
	var datafmt: TCS_DATAFMT
	): TCS_RETCODE; stdcall;

//* ctdiag.c
  ct_diag:		function(
	connection: PCS_CONNECTION;
	operation, typ, idx: TCS_INT;
	buffer: PCS_VOID
	): TCS_RETCODE; stdcall;

//* ctdyn.c
  ct_dynamic:		function(
	cmd: PCS_COMMAND;
	typ: TCS_INT;
	id: PCS_CHAR;
	idlen: TCS_INT;
	buf: PCS_CHAR;
	buflen: TCS_INT
	): TCS_RETCODE; stdcall;
{//* ctdynsqd.c
  ct_dynsqlda:		function(
	cmd: PCS_COMMAND;
	typ: TCS_INT;
	dap: SQLDA;
	operation: TCS_INT
	): CS_RETCODE; stdcall;	}
//* ctexit.c
  ct_exit:		function(
	context: PCS_CONTEXT;
	option: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctfetch.c
  ct_fetch:		function(
	cmd: PCS_COMMAND;
	typ, offset, option: TCS_INT;
	count: PCS_INT
	): TCS_RETCODE; stdcall;
//* ctgfmt.c
  ct_getformat:		function(
	cmd: PCS_COMMAND;
	colnum: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctkeydat.c
  ct_keydata:		function(
	cmd: PCS_COMMAND;
	action, colnum: TCS_INT;
	buffer: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctinit.c
  ct_init:		function(
	context: PCS_CONTEXT;
	version: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctopt.c
  ct_options:		function(
	connection: PCS_CONNECTION;
	action, option: TCS_INT;
	param: PCS_VOID;
	paramlen: TCS_INT;
	outlen: PCS_INT
	): TCS_RETCODE; stdcall;
//* ctparam.c
  ct_param:		function(
	cmd: PCS_COMMAND;
	var datafmt: TCS_DATAFMT;
	data: PCS_VOID;
	datalen, indicator: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctpass.c
  ct_getloginfo:	function(
	connection: PCS_CONNECTION;
	var logptr: PCS_LOGINFO
	): TCS_RETCODE; stdcall;
  ct_setloginfo:	function(
	connection: PCS_CONNECTION;
	loginfo: PCS_LOGINFO
	): TCS_RETCODE; stdcall;
  ct_recvpassthru:	function(
	cmd: PCS_COMMAND;
	var recvptr: PCS_VOID
	): TCS_RETCODE; stdcall;
  ct_sendpassthru:	function(
	cmd: PCS_COMMAND;
	send_bufp: PCS_VOID
	): TCS_RETCODE; stdcall;
//* ctpoll.c
  ct_poll:		function(
	context: PCS_CONTEXT;
	connection: PCS_CONNECTION;
	milliseconds: TCS_INT;
	var compconn: PCS_CONNECTION;
	var compcmd: PCS_COMMAND;
	var compid, compstatus: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctrempwd.c
  ct_remote_pwd:	function(
	connection: PCS_CONNECTION;
	action: TCS_INT;
	server_name: PCS_CHAR;
	snamelen: TCS_INT;
	password: PCS_CHAR;
	pwdlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctresult.c
  ct_results:		function(
	cmd: PCS_COMMAND;
	var result_type: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctrinfo.c
  ct_res_info:		function(
	cmd: PCS_COMMAND;
	operation: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctsend.c
  ct_send:		function(
	cmd: PCS_COMMAND
	): TCS_RETCODE; stdcall;
//* ctgtdata.c
  ct_get_data:		function(
	cmd: PCS_COMMAND;
	colnum: TCS_INT;
	buf: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctsndata.c
  ct_send_data:		function(
	cmd: PCS_COMMAND;
	buf: PCS_VOID;
	buflen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctdinfo.c
  ct_data_info:		function(
	cmd: PCS_COMMAND;
	action, colnum: TCS_INT;
	var iodesc: TCS_IODESC
	): TCS_RETCODE; stdcall;
//* ctwakeup.c
  ct_wakeup:		function(
	connection: PCS_CONNECTION;
	cmd: PCS_COMMAND;
	func_id: TCS_INT;
	status: TCS_RETCODE
	): TCS_RETCODE; stdcall;
//* ctsetlab.c
  ct_labels:		function(
	connection: PCS_CONNECTION;
	action: TCS_INT;
	labelname: PCS_CHAR;
	namelen: TCS_INT;
	labelvalue: PCS_CHAR;
	valuelen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctdsbrse.c
  ct_ds_lookup:		function(
	connection: PCS_CONNECTION;
	action: TCS_INT;
	var reqidp: TCS_INT;
	var lookupinfo: TCS_DS_LOOKUP_INFO;
	userdatap: PCS_VOID
	): TCS_RETCODE; stdcall;
//* ctdsdrop.c
  ct_ds_dropobj:	function(
	connection: PCS_CONNECTION;
	obj: PCS_DS_OBJECT
	): TCS_RETCODE; stdcall;
//* ctdsobji.c
  ct_ds_objinfo:	function(
	objclass: PCS_DS_OBJECT;
	action, objinfo, number: TCS_INT;
	buffer: PCS_VOID;
	buflen: TCS_INT;
	var outlen: TCS_INT
	): TCS_RETCODE; stdcall;
//* ctsetpar.c
  ct_setparam:		function(
	cmd: PCS_COMMAND;
	var datafmt: TCS_DATAFMT;
	data: PCS_VOID;
	var datalenp: TCS_INT;
	var indp: TCS_SMALLINT
	): TCS_RETCODE; stdcall;
{$ENDIF}
type
  ESDSybError = class(ESDEngineError);

{ TISybDatabase }
  TISybConnInfo	= packed record
    ServerType: Byte;
    ConnPtr:	PCS_CONNECTION;	// pointer to PCS_CONNECTION structure for individual client/server connection to Open Server
    CmdPtr:	PCS_COMMAND;	// pointer to PCS_COMMAND for managing a client/server operation
    szSrvName,
    szDBName: 	TSDCharPtr;
  end;

  TISybDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;
    FIsSingleConn: Boolean;    		// Whether or not a database FHandle is used for opened TSDQuery
    FCurSqlCmd: TISqlCommand;		// a command, which uses a database handle currently (when FIsSingleConn is True)
    FIsAnywhere: Boolean;
    FEmptyStrAsNull: Boolean;

    procedure AllocHandle;
    procedure FreeHandle;

    function GetConnPtr: PCS_CONNECTION;
    function GetCmdPtr: PCS_COMMAND;
    function GetDBNamePtr: TSDCharPtr;
    function GetSrvNamePtr: TSDCharPtr;
    procedure GetStmtResult(const Stmt: string; ColNo: Integer; List: TStrings);
    procedure HandleInitCmd(ACmd: PCS_COMMAND; sCmd: string);
    procedure HandleExec(ACmd: PCS_COMMAND);
    procedure HandleReset(ACmd: PCS_COMMAND);
    procedure HandleSetIsolation(AConn: PCS_CONNECTION);
    procedure HandleSetDefOpt(AConn: PCS_CONNECTION);
    procedure SetDefaultOptions;
    procedure SetIsAnywhereProp;
  protected
    procedure Check( rcd: TCS_RETCODE );
    procedure CheckExt( rcd: TCS_RETCODE; ConnPtr: PCS_CONNECTION );

    function GetHandle: TSDPtr; override;
    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;
    procedure SetAutoCommitOption(Value: Boolean); override;
    procedure SetHandle(AHandle: TSDPtr); override;

    property IsSingleConn: Boolean read FIsSingleConn;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;
    function CreateSqlCommand: TISqlCommand; override;

    function GetAutoIncSQL: string; override;
    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;

    procedure ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll: Boolean);
    property CurSqlCmd: TISqlCommand read FCurSqlCmd;
    property ConnPtr: PCS_CONNECTION read GetConnPtr;
    property CmdPtr: PCS_COMMAND read GetCmdPtr;
    property SrvNamePtr: TSDCharPtr read GetSrvNamePtr;
    property DBNamePtr: TSDCharPtr read GetDBNamePtr;
    property IsAnywhere: Boolean read FIsAnywhere;
    property EmptyStrAsNull: Boolean read FEmptyStrAsNull;
  end;

{ TISybCommand }
  TISybCommand = class(TISqlCommand)
  private
    FBindStmt: string;		// with bind parameter data
    FRowsAffected: TCS_INT;	// number of rows affected by last a Transact-SQL statement (DML)
    FConnPtr:	PCS_CONNECTION;	// pointer to PCS_CONNECTION structure for individual client/server connection to Open Server
    FHandle: PCS_COMMAND;       // FHandle and FConnPtr are set when SINGLE CONNECTION mode is off, else they are equal nil both
    FRowResult: Boolean;	// True, when a result set is returned (by ct_results)
    FIsSingleConn: Boolean;	// True, if it's required to use a database handle always
    FEmptyStrAsNull: Boolean;
    FConnected: Boolean;	// True, when Connect method was called
    FColInfo: TStrings;
    FNextResults: Boolean;	// if one of multiple result sets processing
    FEndResults: Boolean;	// if all results have been processed
    FIsRTrimChar: Boolean;	// whether to trim trailing spaces in the output of CHAR datatype ?
    FEndOfFetch: Boolean;	// it's used to avoid repeatedly fetch after EOF (in time of ReleaseDBHadnle call)
    FMinBlobFieldNo: Integer;	// FieldNo of the first blob column of a statement, after that all column data are returned using ct_get_data function

    procedure Check( rcd: TCS_RETCODE );
    procedure Connect;
    procedure CreateConnection;
    function CnvtDateTimeToSQLVarChar(ADataType: TFieldType; Value: TDateTime): string;
    function CnvtDateTimeToSQLDateTime(Value: TDateTime): TCS_DATETIME;
    function CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;
    function CnvtFloatToSQLVarChar(Value: Double): string;
    function CnvtBlobToSQLHexString(Value: string): string;
    function CnvtDBFloatToFloat(datafmt: TCS_DATAFMT; data: TCS_VOID): Double;
    procedure HandleInitLangCmd(ACmd: PCS_COMMAND; sCmd: string);
    procedure HandleInitRpcCmd(ACmd: PCS_COMMAND; ARpcName: string);
    function HandleExec(ACmd: PCS_COMMAND): TCS_INT;
    procedure HandleCurReset(ACmd: PCS_COMMAND);
    procedure HandleReset(ACmd: PCS_COMMAND);
    procedure HandleSend(ACmd: PCS_COMMAND);
    function HandleSpResults(ACmd: PCS_COMMAND): Boolean;
    function GetCmdPtr: PCS_COMMAND;
    function GetExecuted: Boolean;
    function GetSqlDatabase: TISybDatabase;
    procedure InternalExecute;
    procedure InternalQBindParams;
    procedure InternalQExecute;
    procedure InternalSpBindParams;
    procedure InternalSpExecute;
    procedure InternalSpGetParams;
    procedure InternalGetStatus;
    procedure ReadNonBindFields;
    function ReadNonBlobField(AFieldDesc: TSDFieldDesc; SelBuf: TSDPtr; BufLen: Integer): Integer;
  protected
    procedure AcquireDBHandle;
    procedure ReleaseDBHandle;

    procedure BindParamsBuffer; override;
    function GetParamsBufferSize: Integer; override;
    procedure DoPrepare(Value: string); override;
    procedure DoExecDirect(Value: string); override;
    procedure DoExecute; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    function GetHandle: PSDCursor; override;
    procedure InitParamList; override;
    procedure SetFieldsBuffer; override;

    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    procedure Execute; override;
    function GetRowsAffected: Integer; override;
    function NextResultSet: Boolean; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;
    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;

    property CmdPtr: PCS_COMMAND read GetCmdPtr;
    property Executed: Boolean read GetExecuted;
    property SqlDatabase: TISybDatabase read GetSqlDatabase;    
  end;

const
  DefSqlApiDLL_CS = 'LIBCS.DLL';
  DefSqlApiDLL_CT = 'LIBCT.DLL';
  DefSqlApiDLL	= 'LIBCS.DLL,LIBCT.DLL';

var
  SqlApiDLL: string;

{$IFDEF SD_CLR}
type
  [StructLayout(LayoutKind.Sequential)]
  TCS_IODESC	= record
    iotype:		TCS_INT;
    datatype:		TCS_INT;
    locale:		PCS_LOCALE;
    usertype:		TCS_INT;
    total_txtlen:	TCS_INT;
    offset:		TCS_INT;
    log_on_update:	TCS_BOOL;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_OBJ_NAME)]
    name:		string;
    namelen:		TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_TS_SIZE)]
    timestamp:		string;
    timestamplen:	TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_TP_SIZE)]
    textptr:		string;
    textptrlen:		TCS_INT;
  end;

  [StructLayout(LayoutKind.Sequential)]
  TCS_SERVERMSG	= record
    msgnumber:	TCS_MSGNUM;
    state:	TCS_INT;
    severity:	TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_MAX_MSG)]
    text:	string;
    textlen:	TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_MAX_NAME)]
    svrname:	string;
    svrnlen:	TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_MAX_NAME)]
    proc:	string;
    proclen:	TCS_INT;
    line:	TCS_INT;
    status:	TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_SQLSTATE_SIZE)]
    sqlstate:	string;
    sqlstatelen:TCS_INT;
  end;

  [StructLayout(LayoutKind.Sequential)]
  TCS_CLIENTMSG	= record
    severity:		TCS_INT;
    msgnumber:		TCS_MSGNUM;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_MAX_MSG)]
    msgstring:		string;
    msgstringlen:	TCS_INT;
    osnumber:		TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_MAX_MSG)]
    osstring:		string;
    osstringlen:	TCS_INT;
    status:		TCS_INT;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CS_SQLSTATE_SIZE)]
    sqlstate:		string;
    sqlstatelen:	TCS_INT;
  end;

[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_convert')]
function cs_convert(context: PCS_CONTEXT; var srcfmt: TCS_DATAFMT; srcdata: PCS_VOID;
		var destfmt: TCS_DATAFMT; destdata: PCS_VOID; var outlen: TCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_convert')]
function cs_convert(context: PCS_CONTEXT; var srcfmt: TCS_DATAFMT; srcdata: PCS_VOID;
		var destfmt: TCS_DATAFMT; var destdata: TCS_FLOAT; var outlen: TCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_will_convert')]
function cs_will_convert(context: PCS_CONTEXT; srctype, desttype: TCS_INT; var result: TCS_BOOL): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_setnull')]
function cs_setnull(context: PCS_CONTEXT; var datafmt: TCS_DATAFMT;
		buf: PCS_VOID; buflen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_config')]
function cs_config(context: PCS_CONTEXT; action, prop: TCS_INT;
	buf: PCS_VOID; buflen: TCS_INT;	var outlen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_ctx_alloc')]
function cs_ctx_alloc(version: TCS_INT; var outptr: PCS_CONTEXT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_ctx_drop')]
function cs_ctx_drop(context: PCS_CONTEXT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_ctx_global')]
function cs_ctx_global(version: TCS_INT; var outptr: PCS_CONTEXT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_diag')]
function cs_diag(context: PCS_CONTEXT; operation, typ, idx: TCS_INT; buffer: PCS_VOID): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_dt_crack')]
function cs_dt_crack(context: PCS_CONTEXT; datetype: TCS_INT;
		dateval: PCS_VOID; var daterec: TCS_DATEREC): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CS, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'cs_dt_info')]
function cs_dt_info(context: PCS_CONTEXT; action: TCS_INT; locale: PCS_LOCALE; typ, item: TCS_INT;
		buffer: PCS_VOID; buflen: TCS_INT; var outlen: TCS_INT): TCS_RETCODE; external;
                
// ------------------- CT-Lib functions ----------------------------------------
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_debug')]
function ct_debug(context: PCS_CONTEXT;	connection: PCS_CONNECTION;
	        operation, flag: TCS_INT; filename: PCS_CHAR; fnamelen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_bind')]
function ct_bind(cmd: PCS_COMMAND; item: TCS_INT; var datafmt: TCS_DATAFMT;
	        buf: PCS_VOID; outputlen: PCS_VOID; indicator: PCS_VOID): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_cancel')]
function ct_cancel(connection: PCS_CONNECTION; cmd: PCS_COMMAND; typ: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_capability')]
function ct_capability(connection: PCS_CONNECTION; action, typ, capability: TCS_INT; val: PCS_VOID): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_close')]
function ct_close(connection: PCS_CONNECTION; option: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_cmd_alloc')]
function ct_cmd_alloc(connection: PCS_CONNECTION; var cmdptr: PCS_COMMAND): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_cmd_drop')]
function ct_cmd_drop(cmd: PCS_COMMAND): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_cmd_props')]
function ct_cmd_props(cmd: PCS_COMMAND;	action, prop: TCS_INT;
        	buf: PCS_VOID; buflen: TCS_INT;	var outlen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_command')]
function ct_command(cmd: PCS_COMMAND; typ: TCS_INT;
	        buf: PCS_CHAR; buflen, option: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_con_alloc')]
function ct_con_alloc(context: PCS_CONTEXT; var connection: PCS_CONNECTION): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_con_drop')]
function ct_con_drop(connection: PCS_CONNECTION): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_con_props')]
function ct_con_props(connection: PCS_CONNECTION; action, prop: TCS_INT;
        	buf: PCS_VOID; buflen: TCS_INT;	outlen: PCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_connect')]
function ct_connect(connection: PCS_CONNECTION;	server_name: PCS_CHAR; snamelen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_config')]
function ct_config(context: PCS_CONTEXT; action, prop: TCS_INT;
		buf: PCS_VOID; buflen: TCS_INT;	outlen: PCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_config')]
function ct_config(context: PCS_CONTEXT; action, prop: TCS_INT;
		var val: TCS_INT; buflen: TCS_INT;	outlen: PCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_describe')]
function ct_describe(cmd: PCS_COMMAND; item: TCS_INT; var datafmt: TCS_DATAFMT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_diag')]
function ct_diag(connection: PCS_CONNECTION; operation, typ, idx: TCS_INT; buffer: PCS_VOID): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_diag')]
function ct_diag(connection: PCS_CONNECTION; operation, typ, idx: TCS_INT; var msgnum: TCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_diag')]
function ct_diag(connection: PCS_CONNECTION; operation, typ, idx: TCS_INT; var cltmsg: TCS_CLIENTMSG): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_diag')]
function ct_diag(connection: PCS_CONNECTION; operation, typ, idx: TCS_INT; var srvmsg: TCS_SERVERMSG): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_dynamic')]
function ct_dynamic(cmd: PCS_COMMAND; typ: TCS_INT; id: PCS_CHAR;
        	idlen: TCS_INT;	buf: PCS_CHAR; buflen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_exit')]
function ct_exit(context: PCS_CONTEXT; option: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_fetch')]
function ct_fetch(cmd: PCS_COMMAND; typ, offset, option: TCS_INT; count: PCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_init')]
function ct_init(context: PCS_CONTEXT; version: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_options')]
function ct_options(connection: PCS_CONNECTION;	action, option: TCS_INT;
		param: PCS_VOID; paramlen: TCS_INT; outlen: PCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_options')]
function ct_options(connection: PCS_CONNECTION;	action, option: TCS_INT;
		var param: TCS_INT; paramlen: TCS_INT; outlen: PCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_param')]
function ct_param(cmd: PCS_COMMAND; var datafmt: TCS_DATAFMT;
        	data: PCS_VOID;	datalen, indicator: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_getloginfo')]
function ct_getloginfo(connection: PCS_CONNECTION; var logptr: PCS_LOGINFO): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_setloginfo')]
function ct_setloginfo(connection: PCS_CONNECTION; loginfo: PCS_LOGINFO): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_results')]
function ct_results(cmd: PCS_COMMAND; var result_type: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_res_info')]
function ct_res_info(cmd: PCS_COMMAND; operation: TCS_INT;
		buf: PCS_VOID; buflen: TCS_INT;	var outlen: TCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_res_info')]
function ct_res_info(cmd: PCS_COMMAND; operation: TCS_INT;
		var val: TCS_INT; buflen: TCS_INT; var outlen: TCS_INT): TCS_RETCODE; overload; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_send')]
function ct_send(cmd: PCS_COMMAND): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_get_data')]
function ct_get_data(cmd: PCS_COMMAND; colnum: TCS_INT;
	        buf: PCS_VOID; buflen: TCS_INT;	var outlen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_send_data')]
function ct_send_data(cmd: PCS_COMMAND;	buf: PCS_VOID; buflen: TCS_INT): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_data_info')]
function ct_data_info(cmd: PCS_COMMAND;	action, colnum: TCS_INT; var iodesc: TCS_IODESC): TCS_RETCODE; external;
[DllImport(DefSqlApiDLL_CT, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'ct_setparam')]
function ct_setparam(cmd: PCS_COMMAND; var datafmt: TCS_DATAFMT;
        	data: PCS_VOID;	var datalenp: TCS_INT; var indp: TCS_SMALLINT): TCS_RETCODE; external;
{$ENDIF}

{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

implementation

const
  APP_CONNECT_MAX	= 100;	// max connections permits

	//  TSDTransIsolation = (tiDirtyRead, tiReadCommitted, tiRepeatableRead)
  IsolLevel: array[TISqlTransIsolation] of TCS_INT =
  	(CS_OPT_LEVEL0,
         CS_OPT_LEVEL1,
         CS_OPT_LEVEL3
        );

  SDummySelect  = 'select 1 from sysobjects where 0=1';        
  QuoteChar	= '"';	// for surroundings of the parameter's name, which can include, for example, spaces        

var
  hCSLibModule, hCTLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;  
  pCSContext: PCS_CONTEXT;

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrLibInit		= 'Error initialization of CT-library';
  SErrLibExit		= 'Error termination of CT-library';
  SErrFuncNotFound	= 'Function ''%s'' not found in Client/Server-library';
//  SErrUnknownError	= 'Unknown error';

  SSybErrSrvMsg		= 'Server message %d, severity %d, state %d: %s';
  SSybErrClntLibMsg	= 'Client-Library error %d: %s';


function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hCSLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istSybase) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TISybDatabase.Create( ADbParams );
end;

procedure SybError( conn: PCS_CONNECTION );
const
// Status or informational(non-error) severity level (in sysmessages table on server)
  SYB_SEVERITY_INFO	= 10;
  CRLF	= #$0D#$0A;
var
  cmsgnum, smsgnum: TCS_INT;
  cmsg: TCS_CLIENTMSG;
  smsg: TCS_SERVERMSG;
  E: ESDSybError;
  errmsg: string;
  errcode: SmallInt;
  erridx: Integer;
begin
  errcode := -1;
  errmsg  := '';
  if (ct_diag( conn, CS_STATUS, CS_SERVERMSG_TYPE, CS_UNUSED, {$IFNDEF SD_CLR}@{$ENDIF}smsgnum ) = CS_SUCCEED)
     and (smsgnum > 0)
  then begin
    for erridx := 1 to smsgnum do begin
      ct_diag( conn, CS_GET, CS_SERVERMSG_TYPE, erridx, {$IFNDEF SD_CLR}@{$ENDIF}smsg );
	// smsg.msgnumber = 0 for PRINT statement(user message) in a command or procedure
      if (smsg.severity > SYB_SEVERITY_INFO) then begin
        if errmsg = '' then
          errcode := smsg.msgnumber
        else
          errmsg := errmsg + CRLF;
        errmsg := errmsg +
        		Format(SSybErrSrvMsg,
        			[smsg.msgnumber, smsg.severity, smsg.state, smsg.text]);
      end;
    end;
  end;
  if (ct_diag( conn, CS_STATUS, CS_CLIENTMSG_TYPE, CS_UNUSED, {$IFNDEF SD_CLR}@{$ENDIF}cmsgnum ) = CS_SUCCEED) and
     (cmsgnum > 0)
  then begin
    for errIdx := 1 to cmsgnum do begin
      ct_diag( conn, CS_GET, CS_CLIENTMSG_TYPE, 1, {$IFNDEF SD_CLR}@{$ENDIF}cmsg );
      if cmsg.severity <> CS_SV_INFORM then begin
        if errcode <> -1 then
          errcode := cmsg.msgnumber;
        errmsg := errmsg + crlf + Format(SSybErrClntLibMsg, [cmsg.msgnumber, cmsg.msgstring]);
      end;
    end;
  end;

  ct_diag( conn, CS_CLEAR, CS_ALLMSG_TYPE, CS_UNUSED, nil );

  if Length(errmsg) > 0 then begin
    E := ESDSybError.CreateDefPos(errcode, errcode, errmsg);
    raise E;
  end;
end;


{*******************************************************************************
			Load/Unload Sql-library
********************************************************************************}
procedure SetProcAddresses;
begin
// Client/Server-Library functions
{$IFNDEF SD_CLR}
  @cs_calc		:= GetProcAddress(hCSLibModule, 'cs_calc');  		ASSERT( @cs_calc	       <>nil, Format(SErrFuncNotFound, ['cs_calc']) );
  @cs_cmp		:= GetProcAddress(hCSLibModule, 'cs_cmp');  		ASSERT( @cs_cmp	       	       <>nil, Format(SErrFuncNotFound, ['cs_cmp']) );
  @cs_convert		:= GetProcAddress(hCSLibModule, 'cs_convert');  	ASSERT( @cs_convert	       <>nil, Format(SErrFuncNotFound, ['cs_convert']) );
  @cs_will_convert	:= GetProcAddress(hCSLibModule, 'cs_will_convert');  	ASSERT( @cs_will_convert       <>nil, Format(SErrFuncNotFound, ['cs_will_convert']) );
  @cs_set_convert	:= GetProcAddress(hCSLibModule, 'cs_set_convert');  	ASSERT( @cs_set_convert        <>nil, Format(SErrFuncNotFound, ['cs_set_convert']) );
  @cs_setnull		:= GetProcAddress(hCSLibModule, 'cs_setnull');  	ASSERT( @cs_setnull	       <>nil, Format(SErrFuncNotFound, ['cs_setnull']) );
  @cs_config		:= GetProcAddress(hCSLibModule, 'cs_config');  		ASSERT( @cs_config	       <>nil, Format(SErrFuncNotFound, ['cs_config']) );
  @cs_ctx_alloc		:= GetProcAddress(hCSLibModule, 'cs_ctx_alloc');  	ASSERT( @cs_ctx_alloc	       <>nil, Format(SErrFuncNotFound, ['cs_ctx_alloc']) );
  @cs_ctx_drop		:= GetProcAddress(hCSLibModule, 'cs_ctx_drop');  	ASSERT( @cs_ctx_drop	       <>nil, Format(SErrFuncNotFound, ['cs_ctx_drop']) );
  @cs_ctx_global	:= GetProcAddress(hCSLibModule, 'cs_ctx_global');  	ASSERT( @cs_ctx_global         <>nil, Format(SErrFuncNotFound, ['cs_ctx_global']) );
  @cs_objects		:= GetProcAddress(hCSLibModule, 'cs_objects');  	ASSERT( @cs_objects	       <>nil, Format(SErrFuncNotFound, ['cs_objects']) );
  @cs_diag		:= GetProcAddress(hCSLibModule, 'cs_diag');  		ASSERT( @cs_diag	       <>nil, Format(SErrFuncNotFound, ['cs_diag']) );
  @cs_dt_crack		:= GetProcAddress(hCSLibModule, 'cs_dt_crack');  	ASSERT( @cs_dt_crack	       <>nil, Format(SErrFuncNotFound, ['cs_dt_crack']) );
  @cs_dt_info		:= GetProcAddress(hCSLibModule, 'cs_dt_info');  	ASSERT( @cs_dt_info	       <>nil, Format(SErrFuncNotFound, ['cs_dt_info']) );
  @cs_locale		:= GetProcAddress(hCSLibModule, 'cs_locale');  		ASSERT( @cs_locale	       <>nil, Format(SErrFuncNotFound, ['cs_locale']) );
  @cs_loc_alloc		:= GetProcAddress(hCSLibModule, 'cs_loc_alloc');  	ASSERT( @cs_loc_alloc	       <>nil, Format(SErrFuncNotFound, ['cs_loc_alloc']) );
  @cs_loc_drop		:= GetProcAddress(hCSLibModule, 'cs_loc_drop');  	ASSERT( @cs_loc_drop	       <>nil, Format(SErrFuncNotFound, ['cs_loc_drop']) );
  @cs_strcmp		:= GetProcAddress(hCSLibModule, 'cs_strcmp');  		ASSERT( @cs_strcmp	       <>nil, Format(SErrFuncNotFound, ['cs_strcmp']) );
  @cs_time		:= GetProcAddress(hCSLibModule, 'cs_time');  		ASSERT( @cs_time	       <>nil, Format(SErrFuncNotFound, ['cs_time']) );
// function is not exist in some Open Clien/Server version (for example, 10, 11.0)  
  @cs_manage_convert	:= GetProcAddress(hCSLibModule, 'cs_manage_convert');  	//ASSERT( @cs_manage_convert     <>nil, Format(SErrFuncNotFound, ['cs_manage_convert']) );
  @cs_conv_mult		:= GetProcAddress(hCSLibModule, 'cs_conv_mult');  	//ASSERT( @cs_conv_mult	       <>nil, Format(SErrFuncNotFound, ['cs_conv_mult']) );

// Client-Library functions
  @ct_debug		:= GetProcAddress(hCTLibModule, 'ct_debug');  		ASSERT( @ct_debug	       <>nil, Format(SErrFuncNotFound, ['ct_debug']) );
  @ct_bind		:= GetProcAddress(hCTLibModule, 'ct_bind');  		ASSERT( @ct_bind	       <>nil, Format(SErrFuncNotFound, ['ct_bind']) );
  @ct_br_column		:= GetProcAddress(hCTLibModule, 'ct_br_column');  	ASSERT( @ct_br_column	       <>nil, Format(SErrFuncNotFound, ['ct_br_column']) );
  @ct_br_table		:= GetProcAddress(hCTLibModule, 'ct_br_table');  	ASSERT( @ct_br_table	       <>nil, Format(SErrFuncNotFound, ['ct_br_table']) );
  @ct_callback		:= GetProcAddress(hCTLibModule, 'ct_callback');  	ASSERT( @ct_callback	       <>nil, Format(SErrFuncNotFound, ['ct_callback']) );
  @ct_cancel		:= GetProcAddress(hCTLibModule, 'ct_cancel');  		ASSERT( @ct_cancel	       <>nil, Format(SErrFuncNotFound, ['ct_cancel']) );
  @ct_capability	:= GetProcAddress(hCTLibModule, 'ct_capability');  	ASSERT( @ct_capability         <>nil, Format(SErrFuncNotFound, ['ct_capability']) );
  @ct_compute_info	:= GetProcAddress(hCTLibModule, 'ct_compute_info');  	ASSERT( @ct_compute_info       <>nil, Format(SErrFuncNotFound, ['ct_compute_info']) );
  @ct_close		:= GetProcAddress(hCTLibModule, 'ct_close');  		ASSERT( @ct_close	       <>nil, Format(SErrFuncNotFound, ['ct_close']) );
  @ct_cmd_alloc		:= GetProcAddress(hCTLibModule, 'ct_cmd_alloc');  	ASSERT( @ct_cmd_alloc	       <>nil, Format(SErrFuncNotFound, ['ct_cmd_alloc']) );
  @ct_cmd_drop		:= GetProcAddress(hCTLibModule, 'ct_cmd_drop');  	ASSERT( @ct_cmd_drop	       <>nil, Format(SErrFuncNotFound, ['ct_cmd_drop']) );
  @ct_cmd_props		:= GetProcAddress(hCTLibModule, 'ct_cmd_props');  	ASSERT( @ct_cmd_props	       <>nil, Format(SErrFuncNotFound, ['ct_cmd_props']) );
  @ct_command		:= GetProcAddress(hCTLibModule, 'ct_command');  	ASSERT( @ct_command	       <>nil, Format(SErrFuncNotFound, ['ct_command']) );
  @ct_con_alloc		:= GetProcAddress(hCTLibModule, 'ct_con_alloc');  	ASSERT( @ct_con_alloc	       <>nil, Format(SErrFuncNotFound, ['ct_con_alloc']) );
  @ct_con_drop		:= GetProcAddress(hCTLibModule, 'ct_con_drop');  	ASSERT( @ct_con_drop	       <>nil, Format(SErrFuncNotFound, ['ct_con_drop']) );
  @ct_con_props		:= GetProcAddress(hCTLibModule, 'ct_con_props');  	ASSERT( @ct_con_props	       <>nil, Format(SErrFuncNotFound, ['ct_con_props']) );
  @ct_connect		:= GetProcAddress(hCTLibModule, 'ct_connect');  	ASSERT( @ct_connect	       <>nil, Format(SErrFuncNotFound, ['ct_connect']) );
  @ct_config		:= GetProcAddress(hCTLibModule, 'ct_config');  		ASSERT( @ct_config	       <>nil, Format(SErrFuncNotFound, ['ct_config']) );
  @ct_cursor		:= GetProcAddress(hCTLibModule, 'ct_cursor');  		ASSERT( @ct_cursor	       <>nil, Format(SErrFuncNotFound, ['ct_cursor']) );
  @ct_dyndesc		:= GetProcAddress(hCTLibModule, 'ct_dyndesc');  	ASSERT( @ct_dyndesc	       <>nil, Format(SErrFuncNotFound, ['ct_dyndesc']) );
  @ct_describe		:= GetProcAddress(hCTLibModule, 'ct_describe');  	ASSERT( @ct_describe	       <>nil, Format(SErrFuncNotFound, ['ct_describe']) );
  @ct_diag		:= GetProcAddress(hCTLibModule, 'ct_diag');  		ASSERT( @ct_diag	       <>nil, Format(SErrFuncNotFound, ['ct_diag']) );
  @ct_dynamic		:= GetProcAddress(hCTLibModule, 'ct_dynamic');  	ASSERT( @ct_dynamic	       <>nil, Format(SErrFuncNotFound, ['ct_dynamic']) );
  @ct_exit		:= GetProcAddress(hCTLibModule, 'ct_exit');  		ASSERT( @ct_exit	       <>nil, Format(SErrFuncNotFound, ['ct_exit']) );
  @ct_fetch		:= GetProcAddress(hCTLibModule, 'ct_fetch');  		ASSERT( @ct_fetch	       <>nil, Format(SErrFuncNotFound, ['ct_fetch']) );
  @ct_getformat		:= GetProcAddress(hCTLibModule, 'ct_getformat');  	ASSERT( @ct_getformat	       <>nil, Format(SErrFuncNotFound, ['ct_getformat']) );
  @ct_keydata		:= GetProcAddress(hCTLibModule, 'ct_keydata');  	ASSERT( @ct_keydata	       <>nil, Format(SErrFuncNotFound, ['ct_keydata']) );
  @ct_init		:= GetProcAddress(hCTLibModule, 'ct_init');  		ASSERT( @ct_init	       <>nil, Format(SErrFuncNotFound, ['ct_init']) );
  @ct_options		:= GetProcAddress(hCTLibModule, 'ct_options');  	ASSERT( @ct_options	       <>nil, Format(SErrFuncNotFound, ['ct_options']) );
  @ct_param		:= GetProcAddress(hCTLibModule, 'ct_param');  		ASSERT( @ct_param	       <>nil, Format(SErrFuncNotFound, ['ct_param']) );
  @ct_getloginfo	:= GetProcAddress(hCTLibModule, 'ct_getloginfo');  	ASSERT( @ct_getloginfo         <>nil, Format(SErrFuncNotFound, ['ct_getloginfo']) );
  @ct_setloginfo	:= GetProcAddress(hCTLibModule, 'ct_setloginfo');  	ASSERT( @ct_setloginfo         <>nil, Format(SErrFuncNotFound, ['ct_setloginfo']) );
  @ct_recvpassthru	:= GetProcAddress(hCTLibModule, 'ct_recvpassthru');  	ASSERT( @ct_recvpassthru       <>nil, Format(SErrFuncNotFound, ['ct_recvpassthru']) );
  @ct_sendpassthru	:= GetProcAddress(hCTLibModule, 'ct_sendpassthru');  	ASSERT( @ct_sendpassthru       <>nil, Format(SErrFuncNotFound, ['ct_sendpassthru']) );
  @ct_poll		:= GetProcAddress(hCTLibModule, 'ct_poll');  		ASSERT( @ct_poll	       <>nil, Format(SErrFuncNotFound, ['ct_poll']) );
  @ct_remote_pwd	:= GetProcAddress(hCTLibModule, 'ct_remote_pwd');  	ASSERT( @ct_remote_pwd         <>nil, Format(SErrFuncNotFound, ['ct_remote_pwd']) );
  @ct_results		:= GetProcAddress(hCTLibModule, 'ct_results');  	ASSERT( @ct_results	       <>nil, Format(SErrFuncNotFound, ['ct_results']) );
  @ct_res_info		:= GetProcAddress(hCTLibModule, 'ct_res_info');  	ASSERT( @ct_res_info	       <>nil, Format(SErrFuncNotFound, ['ct_res_info']) );
  @ct_send		:= GetProcAddress(hCTLibModule, 'ct_send');  		ASSERT( @ct_send	       <>nil, Format(SErrFuncNotFound, ['ct_send']) );
  @ct_get_data		:= GetProcAddress(hCTLibModule, 'ct_get_data');  	ASSERT( @ct_get_data	       <>nil, Format(SErrFuncNotFound, ['ct_get_data']) );
  @ct_send_data		:= GetProcAddress(hCTLibModule, 'ct_send_data');  	ASSERT( @ct_send_data	       <>nil, Format(SErrFuncNotFound, ['ct_send_data']) );
  @ct_data_info		:= GetProcAddress(hCTLibModule, 'ct_data_info');  	ASSERT( @ct_data_info	       <>nil, Format(SErrFuncNotFound, ['ct_data_info']) );
  @ct_wakeup		:= GetProcAddress(hCTLibModule, 'ct_wakeup');  		ASSERT( @ct_wakeup	       <>nil, Format(SErrFuncNotFound, ['ct_wakeup']) );
  @ct_labels		:= GetProcAddress(hCTLibModule, 'ct_labels');  		ASSERT( @ct_labels	       <>nil, Format(SErrFuncNotFound, ['ct_labels']) );
  @ct_ds_lookup		:= GetProcAddress(hCTLibModule, 'ct_ds_lookup');  	//ASSERT( @ct_ds_lookup	       <>nil, Format(SErrFuncNotFound, ['ct_ds_lookup']) );
  @ct_ds_dropobj	:= GetProcAddress(hCTLibModule, 'ct_ds_dropobj');  	//ASSERT( @ct_ds_dropobj         <>nil, Format(SErrFuncNotFound, ['ct_ds_dropobj']) );
  @ct_ds_objinfo	:= GetProcAddress(hCTLibModule, 'ct_ds_objinfo');  	//ASSERT( @ct_ds_objinfo         <>nil, Format(SErrFuncNotFound, ['ct_ds_objinfo']) );
  @ct_setparam		:= GetProcAddress(hCTLibModule, 'ct_setparam');  	//ASSERT( @ct_setparam	       <>nil, Format(SErrFuncNotFound, ['ct_setparam']) );
{$ENDIF}
end;

procedure ResetProcAddresses;
begin
{$IFNDEF SD_CLR}
//  @abort_xact           := nil;
// Client/Server-Library functions
  @cs_calc		:= nil;
  @cs_cmp		:= nil;
  @cs_convert		:= nil;
  @cs_will_convert	:= nil;
  @cs_set_convert	:= nil;
  @cs_setnull		:= nil;
  @cs_config		:= nil;
  @cs_ctx_alloc		:= nil;
  @cs_ctx_drop		:= nil;
  @cs_ctx_global	:= nil;
  @cs_objects		:= nil;
  @cs_diag		:= nil;
  @cs_dt_crack		:= nil;
  @cs_dt_info		:= nil;
  @cs_locale		:= nil;
  @cs_loc_alloc		:= nil;
  @cs_loc_drop		:= nil;
  @cs_strcmp		:= nil;
  @cs_time		:= nil;
  @cs_manage_convert	:= nil;
  @cs_conv_mult		:= nil;

// Client-Library functions
  @ct_debug		:= nil;
  @ct_bind		:= nil;
  @ct_br_column		:= nil;
  @ct_br_table		:= nil;
  @ct_callback		:= nil;
  @ct_cancel		:= nil;
  @ct_capability	:= nil;
  @ct_compute_info	:= nil;
  @ct_close		:= nil;
  @ct_cmd_alloc		:= nil;
  @ct_cmd_drop		:= nil;
  @ct_cmd_props		:= nil;
  @ct_command		:= nil;
  @ct_con_alloc		:= nil;
  @ct_con_drop		:= nil;
  @ct_con_props		:= nil;
  @ct_connect		:= nil;
  @ct_config		:= nil;
  @ct_cursor		:= nil;
  @ct_dyndesc		:= nil;
  @ct_describe		:= nil;
  @ct_diag		:= nil;
  @ct_dynamic		:= nil;
  @ct_exit		:= nil;
  @ct_fetch		:= nil;
  @ct_getformat		:= nil;
  @ct_keydata		:= nil;
  @ct_init		:= nil;
  @ct_options		:= nil;
  @ct_param		:= nil;
  @ct_getloginfo	:= nil;
  @ct_setloginfo	:= nil;
  @ct_recvpassthru	:= nil;
  @ct_sendpassthru	:= nil;
  @ct_poll		:= nil;
  @ct_remote_pwd	:= nil;
  @ct_results		:= nil;
  @ct_res_info		:= nil;
  @ct_send		:= nil;
  @ct_get_data		:= nil;
  @ct_send_data		:= nil;
  @ct_data_info		:= nil;
  @ct_wakeup		:= nil;
  @ct_labels		:= nil;
  @ct_ds_lookup		:= nil;
  @ct_ds_dropobj	:= nil;
  @ct_ds_objinfo	:= nil;
  @ct_setparam		:= nil;
{$ENDIF}
end;

function SybCtxGetPropInt32(ctx: PCS_CONTEXT; prop: TCS_INT): TCS_INT;
begin
  Result := 0;
  ct_config( ctx, CS_GET, prop, {$IFDEF SD_CLR}Result{$ELSE}PCS_VOID(@Result){$ENDIF}, CS_UNUSED, nil );
end;

procedure SybCtxSetPropInt32(ctx: PCS_CONTEXT; prop, Value: TCS_INT);
begin
  ct_config( ctx, CS_SET, prop, {$IFDEF SD_CLR}Value{$ELSE}PCS_VOID(@Value){$ENDIF}, CS_UNUSED, nil );
end;

function SybConGetOptionInt32(con: PCS_CONNECTION; option: TCS_INT; var Value: TCS_INT): TCS_RETCODE;
begin
  Result := ct_options(con, CS_GET, option, {$IFDEF SD_CLR}Value{$ELSE}PCS_VOID(@Value){$ENDIF}, CS_UNUSED, nil);
end;

function SybConSetOptionInt32(con: PCS_CONNECTION; option, Value: TCS_INT): TCS_RETCODE;
begin
  Result := ct_options(con, CS_SET, option, {$IFDEF SD_CLR}Value{$ELSE}PCS_VOID(@Value){$ENDIF}, CS_UNUSED, nil);
end;

procedure InitDataFmtStruct(var colinfo: TCS_DATAFMT);
begin
{$IFDEF SD_CLR}
  with colinfo do begin
    namelen	:= 0;
    datatype	:= 0;
    format	:= 0;
    maxlength	:= 0;
    scale	:= 0;
    precision	:= 0;
    status	:= 0;
    count	:= 0;
    usertype	:= 0;
    locale	:= nil;
  end;
{$ELSE}
    FillChar(colinfo, SizeOf(colinfo), 0);
{$ENDIF}
end;

procedure LoadSqlLib;
const
  LibSep = ',';
var
  sLibs, sLibCS, sLibCT: string;
  CurPos: Integer;
  CSLibVer: Integer;
  rcd: TCS_RETCODE;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      sLibs := SqlApiDLL;

      CurPos := 1;
      sLibCS := ExtractLibName(sLibs, LibSep, CurPos);
      sLibCT := ExtractLibName(sLibs, LibSep, CurPos);

      hCSLibModule := HelperLoadLibrary( sLibCS );
      hCTLibModule := HelperLoadLibrary( sLibCT );

      if (hCSLibModule = 0) or (hCTLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [ SqlApiDLL ]);
      Inc(SqlLibRefCount);
      SetProcAddresses;

    	// if 1-st loading CT-Library
      if SqlLibRefCount = 1 then begin
      		// 12.5 behavior
        CSLibVer := CS_VERSION_125;
        rcd := cs_ctx_alloc( CSLibVer, pCSContext );
        if rcd = CS_FAIL then begin
      		// 11.1 behavior
          CSLibVer := CS_VERSION_110;
          rcd := cs_ctx_alloc( CSLibVer, pCSContext );
         		// if version 11.1 is not supported
          if rcd = CS_FAIL then begin
          	// 10.0 behavior
            CSLibVer := CS_VERSION_100;
            rcd := cs_ctx_alloc( CSLibVer, pCSContext );
          end;
        end;
        if rcd <> CS_SUCCEED then
          if rcd = CS_MEM_ERROR
          then raise ESDSqlLibError.Create(SErrLibInit + ': cs_ctx_alloc() failed because it could not allocate sufficient memory')
          else raise ESDSqlLibError.Create(SErrLibInit + ': cs_ctx_alloc() failed');

        if ct_init( pCSContext, CSLibVer ) <> CS_SUCCEED then
          raise ESDSqlLibError.Create(SErrLibInit + ': ct_init() failed');
      end;
    end else
      Inc(SqlLibRefCount);
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
    if (SqlLibRefCount = 1) then begin
    	// if cs_ctx_alloc failed in the time of initialization, then pCSContext = nil
      if pCSContext <> nil then begin
        if ct_exit( pCSContext, CS_FORCE_EXIT ) <> CS_SUCCEED then
          raise ESDSqlLibError.Create(SErrLibExit + ': ct_exit() failed');
        if cs_ctx_drop( pCSContext ) <> CS_SUCCEED then
          raise ESDSqlLibError.Create(SErrLibExit + ': cs_ctx_drop() failed');
        pCSContext := nil;
      end;

      if FreeLibrary(hCTLibModule) then
        hCTLibModule := 0;
      if FreeLibrary(hCSLibModule) then
        hCSLibModule := 0;

      if (hCSLibModule <> 0) or (hCTLibModule <> 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDLL ]);
      Dec(SqlLibRefCount);
      ResetProcAddresses;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{ TISybDatabase }
constructor TISybDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle	:= nil;
  FCurSqlCmd	:= nil;
  FIsAnywhere := False;
	// a procedure can return one or more result sets
  FProcSupportsCursors := True;
	// by default IsSingleConn = False
  FIsSingleConn := UpperCase( Trim( Params.Values[szSINGLECONN] ) ) = STrueString;
        // by default EmptyStrAsNull = False
  FEmptyStrAsNull := UpperCase( Trim( Params.Values[szEMPTYSTRASNULL] ) ) = STrueString;
end;

destructor TISybDatabase.Destroy;
begin
  FreeHandle;

  if AcquiredHandle then
    FreeSqlLib;
  
  inherited Destroy;
end;

function TISybDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TISybCommand.Create( Self );
end;

function TISybDatabase.GetAutoIncSQL: string;
begin
  Result := SS_SelectAutoIncField; 
end;

procedure TISybDatabase.SetAutoCommitOption(Value: Boolean);
begin
end;

function TISybDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;

procedure TISybDatabase.DoStartTransaction;
begin
  ReleaseDBHandle(nil, True);		// release an acquired handle
  HandleReset( CmdPtr );

  HandleInitCmd( CmdPtr, 'BEGIN TRAN' );
  HandleExec( CmdPtr );
  HandleReset( CmdPtr );
end;

procedure TISybDatabase.DoCommit;
begin
  ReleaseDBHandle(nil, True);		// release an acquired handle
  HandleReset( CmdPtr );

  HandleInitCmd( CmdPtr, 'COMMIT TRAN' );
  HandleExec( CmdPtr );
  HandleReset( CmdPtr );
end;

procedure TISybDatabase.DoRollback;
begin
  ReleaseDBHandle(nil, True);		// release an acquired handle
  HandleReset( CmdPtr );

  HandleInitCmd( CmdPtr, 'ROLLBACK TRAN' );
  HandleExec( CmdPtr );
  HandleReset( CmdPtr );
end;

function TISybDatabase.GetConnPtr: PCS_CONNECTION;
begin
  ASSERT( Assigned(FHandle), 'TISybDatabase.GetConnPtr' );

{$IFDEF SD_CLR}
  Result := TISybConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TISybConnInfo) ) ).ConnPtr;
{$ELSE}
  Result := TISybConnInfo(FHandle^).ConnPtr;
{$ENDIF}
end;

function TISybDatabase.GetCmdPtr: PCS_COMMAND;
begin
  ASSERT( Assigned(FHandle), 'TISybDatabase.GetCmdPtr' );

{$IFDEF SD_CLR}
  Result := TISybConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TISybConnInfo) ) ).CmdPtr;
{$ELSE}
  Result := TISybConnInfo(FHandle^).CmdPtr;
{$ENDIF}
end;

function TISybDatabase.GetDBNamePtr: TSDCharPtr;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF SD_CLR}
    Result := TISybConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TISybConnInfo) ) ).szDBName;
{$ELSE}
    Result := TISybConnInfo(FHandle^).szDBName;
{$ENDIF}
end;

function TISybDatabase.GetSrvNamePtr: TSDCharPtr;
begin
  Result := nil;
  if Assigned(FHandle) then
{$IFDEF SD_CLR}
    Result := TISybConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TISybConnInfo) ) ).szSrvName;
{$ELSE}
    Result := TISybConnInfo(FHandle^).szSrvName;
{$ENDIF}
end;

function TISybDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

procedure TISybDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF SD_CLR}
var
  r1, r2: TISybConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;

{$IFDEF SD_CLR}
  r1 := TISybConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TISybConnInfo) ) );
  r2 := TISybConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TISybConnInfo) ) );
  r1.ConnPtr := r2.ConnPtr;
  r1.CmdPtr  := r2.CmdPtr;
  r1.szSrvName := StrNew( r2.szSrvName );
  r1.szDBName := StrNew( r2.szDBName );
{$ELSE}
  TISybConnInfo(FHandle^).ConnPtr	:= TISybConnInfo(AHandle^).ConnPtr;
  TISybConnInfo(FHandle^).CmdPtr 	:= TISybConnInfo(AHandle^).CmdPtr;
  TISybConnInfo(FHandle^).szSrvName	:= StrNew( TISybConnInfo(AHandle^).szSrvName );
  TISybConnInfo(FHandle^).szDBName	:= StrNew( TISybConnInfo(AHandle^).szDBName );
{$ENDIF}
end;

procedure TISybDatabase.AllocHandle;
var
  r: TISybConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TISybDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(r));
  SafeInitMem( FHandle, SizeOf(r), 0 );

  r.ServerType  := Ord( istSybase );
  r.ConnPtr     := nil;
  r.CmdPtr      := nil;
  r.szSrvName   := nil;
  r.szDBName    := nil;
{$IFDEF SD_CLR}
  Marshal.StructureToPtr( r, FHandle, False );
{$ELSE}
  TISybConnInfo(FHandle^) := r;
{$ENDIF}
end;

procedure TISybDatabase.FreeHandle;
begin
  if Assigned(FHandle) then begin
{$IFDEF SD_CLR}
    SafeReallocMem( SrvNamePtr, 0 );
    SafeReallocMem( DBNamePtr, 0 );
{$ELSE}
    StrDispose( TISybConnInfo(FHandle^).szSrvName );
    StrDispose( TISybConnInfo(FHandle^).szDBName );
{$ENDIF}
    FHandle := SafeReallocMem( FHandle, 0 );
  end;
end;

procedure TISybDatabase.GetStmtResult(const Stmt: string; ColNo: Integer; List: TStrings);
var
  cmd: TISqlCommand;
  sVal: string;
begin
  ReleaseDBHandle(nil, True);	// release an acquired handle
  HandleReset( CmdPtr );

  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect(Stmt);
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(ColNo, sVal);
      if sVal <> '' then
        List.Add( sVal );
    end;
  finally
    cmd.Free;
  end;

  HandleReset( CmdPtr );
end;

function TISybDatabase.GetClientVersion: LongInt;
const
  MaxVerLen = 512;
var
  szVer: TSDCharPtr;
begin
  szVer := SafeReallocMem(nil, MaxVerLen);
  try
    SafeInitMem(szVer, MaxVerLen, 0);
    Check( ct_config( pCSContext, CS_GET, CS_VER_STRING, PCS_VOID(szVer), MaxVerLen, nil) );
	// For example: 'Sybase Client-Library/11.1.1/P/PC Intel/Windows NT 3.5.1/Windows 95 4.0/1/OPT/Tue Aug 12 11:12:48 1997'
    Result := VersionStringToDWORD( HelperPtrToString(szVer) );
  finally
    SafeReallocMem(szVer, 0);
  end;
end;

function TISybDatabase.GetServerVersion: LongInt;
begin
  Result := VersionStringToDWORD( GetVersionString );
end;

procedure TISybDatabase.SetIsAnywhereProp;
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    GetStmtResult('select name from dbo.sysobjects where name=''xp_msver''', 1, List);
    	// Sybase SQL Server does not have xp_msver procedure
    FIsAnywhere := List.Count > 0;
  finally
    List.Free;
  end;
end;

function TISybDatabase.GetVersionString: string;
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
  	// if SQLServer
    if not IsAnywhere then begin
      GetStmtResult( 'dbo.sp_server_info @attribute_id=2', 3, List );
      if List.Count > 0 then
        Result := List.Strings[0];
    end else begin
    	// if Sybase SQLAnywhere
      GetStmtResult('select dbo.xp_msver(''FileDescription'') || '' '' || dbo.xp_msver(''ProductVersion'')', 1, List );
      if List.Count > 0 then
        Result := List.Strings[List.Count-1];	// first row is 'xp_msver'
    end;
  finally
    List.Free;
  end;
end;

function TISybDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
const
        // sc.parm_type = 0 - check only normal parameter (variable), exclude result sets and other types
  SQueryAsaStoredProcNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.user_name as '+SCH_NAME_FIELD+
        ', so.proc_name as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', SUM(CASE parm_mode_in WHEN ''Y'' THEN 1 ELSE 0 END) as '+PROC_IN_PARAMS+
        ', SUM(CASE parm_mode_out WHEN ''Y'' THEN 1 ELSE 0 END) as '+ PROC_OUT_PARAMS+
  	' from sys.sysprocedure so, sys.sysuserperm su, sys.sysprocparm sc ' +
	'where so.creator = su.user_id and so.proc_id *= sc.proc_id and sc.parm_type = 0'+
        '%s group by su.user_name, so.proc_name order by su.user_name, so.proc_name';
  SQueryAsaProcParamsFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.user_name as '+SCH_NAME_FIELD+
        ', so.proc_name as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', sc.parm_name as '+PARAM_NAME_FIELD+', sc.parm_id as '+PARAM_POS_FIELD+
        ', (CASE parm_mode_in WHEN ''Y'' THEN 1 ELSE 0 END) + (CASE parm_mode_out WHEN ''Y'' THEN 2 ELSE 0 END) as '+ PARAM_TYPE_FIELD+
        ', st.domain_id as '+PARAM_DATATYPE_FIELD+', st.domain_name as '+PARAM_TYPENAME_FIELD+
        ', st."precision" as '+PARAM_PREC_FIELD+', sc.scale as '+PARAM_SCALE_FIELD+', sc.width as '+PARAM_LENGTH_FIELD+
        ', NULL as '+PARAM_NULLABLE_FIELD+        
  	' from sys.sysprocedure so, sys.sysuserperm su, sys.sysprocparm sc, sys.sysdomain st ' +
	'where so.creator = su.user_id and so.proc_id = sc.proc_id and sc.parm_type = 0 and sc.domain_id = st.domain_id'+
        '%s order by su.user_name, so.proc_name, sc.parm_id';
  SQueryAsaTableFieldNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.user_name as '+SCH_NAME_FIELD+
        ', so.table_name as '+TBL_NAME_FIELD+', sc.column_name as '+COL_NAME_FIELD+
        ', sc.column_id as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', st.domain_name as '+COL_TYPENAME_FIELD+', sc.width as '+COL_LENGTH_FIELD+
        ', st."precision" as '+COL_PREC_FIELD+', sc.scale as '+COL_SCALE_FIELD+
        ', CASE (sc.nulls) WHEN ''Y'' THEN 1 ELSE 0 END as '+COL_NULLABLE_FIELD+
        ', sc."default" '+
        ' from sys.systable so, sys.sysuserperm su, sys.syscolumn sc, sys.sysdomain st '+
        'where so.creator = su.user_id and so.table_id = sc.table_id and sc.domain_id = st.domain_id and'+
        '  su.user_name like ''%s'' and so.table_name like ''%s'' order by su.user_name, so.table_name, sc.column_id';
  SQueryAsaIndexNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.user_name as '+SCH_NAME_FIELD+
        ', so.table_name as '+TBL_NAME_FIELD+', si.index_name as '+IDX_NAME_FIELD+
        ', sc.column_name as '+IDX_COL_NAME_FIELD+', sk.sequence as '+IDX_COL_POS_FIELD+
        ', CASE si."unique" WHEN ''N'' THEN 1 ELSE 2 END as '+IDX_TYPE_FIELD+
        ', sk."order" as '+IDX_SORT_FIELD+
	', '''' as '+IDX_FILTER_FIELD+
        ' from sys.systable so, sys.sysuserperm su, sys.sysindex si, sys.sysixcol sk, sys.syscolumn sc '+
        'where so.creator = su.user_id and so.table_id = si.table_id and so.table_id = sc.table_id and'+
        '  so.table_id = sk.table_id and si.index_id = sk.index_id and sk.column_id = sc.column_id and'+
        '  su.user_name like ''%s'' and so.table_name like ''%s'' '+
        'order by su.user_name, so.table_name, sc.column_name, sk.sequence';
  SQuerySyb11StoredProcNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name + '';'' + CONVERT(varchar, sp.number) as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', COUNT(sc.id) as '+PROC_IN_PARAMS+
        ', 0 as '+ PROC_OUT_PARAMS+
  	' from dbo.sysobjects so, dbo.sysusers su, dbo.syscomments sp, dbo.syscolumns sc ' +
	'where so.type in (''P'', ''X'') and sp.colid = 1 and so.uid = su.uid and so.id = sp.id and so.id *= sc.id '+
        '%s group by su.name, so.name, sp.number order by su.name, so.name';
  SQuerySyb12StoredProcNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name + '';'' + CONVERT(varchar, sp.number) as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', COUNT(sc.status2) as '+PROC_IN_PARAMS+
        ', SUM((sc.status2 & 2)/2) as '+ PROC_OUT_PARAMS+
  	' from dbo.sysobjects so, dbo.sysusers su, dbo.syscomments sp, dbo.syscolumns sc ' +
	'where so.type in (''P'', ''X'') and sp.colid = 1 and so.uid = su.uid and so.id = sp.id and so.id *= sc.id '+
        '%s group by su.name, so.name, sp.number order by su.name, so.name';
  SQuerySyb12ProcParamsFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name + '';'' + CONVERT(varchar, sp.number) as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', sc.name as '+PARAM_NAME_FIELD+', sc.colid as '+PARAM_POS_FIELD+
        ', (sc.status2 & 1) + CASE (sc.status2 & 2) WHEN 0 THEN 0 ELSE 3 END as '+PARAM_TYPE_FIELD+
        ', st.type as '+PARAM_DATATYPE_FIELD+', st.name as '+PARAM_TYPENAME_FIELD+
        ', sc.prec as '+PARAM_PREC_FIELD+', sc.scale as '+PARAM_SCALE_FIELD+', sc.length as '+PARAM_LENGTH_FIELD+
        ', CONVERT( smallint, CASE sc.status & 8 WHEN 0 THEN 0 ELSE 1 END) as '+PARAM_NULLABLE_FIELD+
  	' from dbo.sysobjects so, dbo.sysusers su, dbo.syscomments sp, dbo.syscolumns sc, dbo.systypes st ' +
	'where so.type in (''P'', ''X'') and sp.colid = 1 and so.uid = su.uid and so.id = sp.id and so.id = sc.id and'+
        ' sc.usertype = st.usertype %s order by su.name, so.name, sc.colid';
  SQuerySybTableNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+
        ', CASE so.type WHEN ''U'' THEN 1 WHEN ''V'' THEN 2 WHEN ''S'' THEN 4 END as '+TBL_TYPE_FIELD+
        ' from dbo.sysobjects so, dbo.sysusers su '+
        'where so.uid = su.uid %s order by su.name, so.name';
  SQuerySybTableFieldNamesFmt =
  	'select DB_NAME() as '+CAT_NAME_FIELD+', su.name as '+SCH_NAME_FIELD+
        ', so.name as '+TBL_NAME_FIELD+', sc.name as '+COL_NAME_FIELD+
        ', sc.colid as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', st.name as '+COL_TYPENAME_FIELD+', sc.length as '+COL_LENGTH_FIELD+
        ', sc.prec as '+COL_PREC_FIELD+', sc.scale as '+COL_SCALE_FIELD+
        ', CASE (sc.status & 0x8) WHEN 0 THEN 0 ELSE 1 END as '+COL_NULLABLE_FIELD+
        ', sc.cdefault'+
        ' from dbo.sysobjects so, dbo.sysusers su, dbo.syscolumns sc, dbo.systypes st '+
        'where so.uid = su.uid and so.id = sc.id and sc.usertype = st.usertype and'+
        '  su.name like ''%s'' and so.name like ''%s'' order by su.name, so.name, sc.colid';
  SQuerySybIndexNamesFmt =
	'declare @objid int '+
	'declare @indid int '+
	'declare @maxindid int '+
	'declare @keycnt int '+
	'declare @keyno int '+
	'select @objid = object_id(''%s'') '+
	'select @indid = 1 '+
	'if @objid is NULL '+
	'begin '+
	'  goto exit_mark '+
	'end '+
	'select @maxindid = max(indid) from sysindexes where id = @objid and indid > 0 and indid < 255 '+
	'if @maxindid is NULL '+
	'begin '+
	'  select @maxindid = 0 '+
	'end '+
	'create table #spindcols( '+
	'  CATALOG_NAME varchar(30), SCHEMA_NAME varchar(30), TABLE_NAME varchar(30),   INDEX_NAME varchar(30),COLUMN_NAME varchar(30), COLUMN_POSITION integer, '+
	'  INDEX_TYPE integer, SORT_ORDER varchar(1), INDEX_FILTER varchar(1)) '+
	'while @indid <= @maxindid '+
	'begin '+
	'  select @keyno = 1, @keycnt = CASE (status & 0x10) WHEN 0 THEN keycnt-1 ELSE keycnt END from sysindexes si '+
	'    where id = @objid and indid = @indid '+
	'  while @keyno <= @keycnt '+
	'  begin '+
	'    insert into #spindcols(CATALOG_NAME, SCHEMA_NAME, TABLE_NAME, INDEX_NAME, '+
	'      COLUMN_NAME, COLUMN_POSITION, INDEX_TYPE, SORT_ORDER, INDEX_FILTER) '+
	'        select DB_NAME() , su.name, so.name, si.name, '+
	'               index_col(object_name(@objid), @indid, @keyno), @keyno, '+
	'               CASE (si.status & 0x2) WHEN 0 THEN 0 ELSE 2 END + CASE (si.status & 0x40) WHEN 0 THEN 0 ELSE 1 END + CASE (si.status & 0x800) WHEN 0 THEN 0 ELSE 4 END, '+
	'               CASE index_colorder(object_name(@objid), @indid, @keyno) WHEN ''DESC'' THEN ''D'' ELSE ''A'' END, '''' '+
	'        from sysobjects so, sysusers su, sysindexes si '+
	'        where so.uid = su.uid and so.id = si.id and si.indid = @indid and so.id = @objid '+
	'    select @keyno = @keyno + 1 '+
	'  end '+
	'  select @indid = @indid + 1 '+
	'end '+
	'select * from #spindcols '+
	'drop table #spindcols '+
	'exit_mark:';

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
          then sStmt := sStmt + Format(' and so.name like ''%s''', [sObj])
          else sStmt := sStmt + Format(' and so.name = ''%s''', [sObj]);
        if sOwner <> '' then
          if ContainsLikeWildcards(sOwner)
          then sStmt := sStmt + Format(' and su.name like ''%s''', [sOwner])
          else sStmt := sStmt + Format(' and su.name = ''%s''', [sOwner]);
        if ASchemaType = stSysTables then
          sStmt := sStmt + ' and so.type in (''S'')'
        else
          sStmt := sStmt + ' and so.type in (''U'', ''V'')';
        sStmt := Format(SQuerySybTableNamesFmt, [sStmt]);
      end;
    stColumns:
      if IsAnywhere then begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryAsaTableFieldNamesFmt, [sOwner, sObj] );
      end else begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQuerySybTableFieldNamesFmt, [sOwner, sObj] );
      end;
    stIndexes:
      if IsAnywhere then begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryAsaIndexNamesFmt, [sOwner, sObj]);
      end else
        sStmt := Format(SQuerySybIndexNamesFmt, [AObjectName]);
    stProcedures:
      if IsAnywhere then begin
        if AObjectName <> '' then
          sStmt := Format(' and so.proc_name like ''%s''', [AObjectName]);
        sStmt := Format(SQueryAsaStoredProcNamesFmt, [sStmt]);
      end else begin
        if AObjectName <> '' then
          sStmt := Format(' and so.name like ''%s''', [AObjectName]);
        if GetMajorVer( GetServerVersion ) >= 12 then
          sStmt := Format(SQuerySyb12StoredProcNamesFmt, [sStmt])
        else
          sStmt := Format(SQuerySyb11StoredProcNamesFmt, [sStmt]);
      end;
    stProcedureParams:
      if IsAnywhere then begin
        if AObjectName <> '' then
          sStmt := Format(' and so.proc_name like ''%s''', [AObjectName]);
        sStmt := Format(SQueryAsaProcParamsFmt, [sStmt]);
      end else begin
        if AObjectName <> '' then
          sStmt := Format(' and so.name like ''%s''', [AObjectName]);
        sStmt := Format(SQuerySyb12ProcParamsFmt, [sStmt])
      end;
  end;

  ReleaseDBHandle(nil, True);	// release an acquired handle
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect(sStmt);
  except
    cmd.Free;
    raise;
  end;

  Result := cmd;
end;

function TISybDatabase.TestConnected: Boolean;
var
  cmd: TISqlCommand;
begin
  cmd := CreateSqlCommand;
  try
    cmd.ExecDirect(SDummySelect);
    Result := True;
  finally
    cmd.Free;
  end;
end;

procedure TISybDatabase.Check( rcd: TCS_RETCODE );
begin
  CheckExt( rcd, ConnPtr );
end;

procedure TISybDatabase.CheckExt( rcd: TCS_RETCODE; ConnPtr: PCS_CONNECTION );
begin
  ResetIdleTimeOut;

  if rcd = CS_SUCCEED then Exit;

  SybError( ConnPtr );
end;

procedure TISybDatabase.ReleaseDBHandle(ASqlCmd: TISqlCommand; IsFetchAll: Boolean);
var
  ds: TISqlCommand;
begin
  if Assigned(FCurSqlCmd) and (ASqlCmd <> FCurSqlCmd) then begin
    ds := FCurSqlCmd;
    FCurSqlCmd := nil;
    try
      if IsFetchAll then
        ds.SaveResults;
    except
      FCurSqlCmd := ds;
      raise;
    end;
  end;
  FCurSqlCmd := ASqlCmd;
end;

procedure TISybDatabase.HandleReset(ACmd: PCS_COMMAND);
begin
  if ACmd <> nil then
    Check( ct_cancel(nil, ACmd, CS_CANCEL_ALL) );
end;

procedure TISybDatabase.HandleInitCmd(ACmd: PCS_COMMAND; sCmd: string);
var
  CmdPtr: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  CmdPtr := Marshal.StringToHGlobalAnsi( sCmd );
  try
{$ELSE}
  CmdPtr := PChar( sCmd );
{$ENDIF}
  Check( ct_command(ACmd, CS_LANG_CMD, CmdPtr, CS_NULLTERM, CS_UNUSED) );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal( CmdPtr );
  end;
{$ENDIF}
end;

procedure TISybDatabase.HandleExec(ACmd: PCS_COMMAND);
var
  rslt: TCS_INT;
begin
  Check( ct_send( ACmd ) );
  repeat
    Check( ct_results( ACmd, rslt ) );
    if rslt = CS_CMD_FAIL then
      Check( CS_FAIL );
  until rslt = CS_CMD_DONE;
end;

procedure TISybDatabase.HandleSetIsolation(AConn: PCS_CONNECTION);
var
  intval: TCS_INT;
begin
  intval := IsolLevel[TransIsolation];

  Check( SybConSetOptionInt32(AConn, CS_OPT_ISOLATION, intval) );
end;

procedure TISybDatabase.HandleSetDefOpt(AConn: PCS_CONNECTION);
var
  bval: TCS_BOOL;
  intval: TCS_INT;
begin
	// Sets unchained transaction behavior.
        //It's need to explicitly execute "BEGIN TRAN" statement
  bval := CS_FALSE;
  Check( SybConSetOptionInt32(AConn, CS_OPT_CHAINXACTS,	bval) );
  intval := High(LongInt);
  Check( SybConSetOptionInt32(AConn, CS_OPT_TEXTSIZE, intval) );
	// SQL Server treats all strings enclosed in double quotes (") as identifiers.
  if UpperCase( Trim( Params.Values[szQUOTEDIDENT] ) ) <> SFalseString then begin
    bval := CS_TRUE;
    Check( SybConSetOptionInt32(AConn, CS_OPT_QUOTED_IDENT, bval) );
  end;
end;

procedure TISybDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
  sSrvName, sDbName, sAppName, sHostName, sValue: string;
  szUser, szPwd, szSrv, szApp, szHost: TSDCharPtr;
  IntValue, PacketSize: TCS_INT;
  bValue: TCS_BOOL;
  rec: TISybConnInfo;
begin
  LoadSqlLib;

  AllocHandle;
  try
{$IFDEF SD_CLR}
  rec := TISybConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TISybConnInfo) ) );
{$ELSE}
  rec := TISybConnInfo( FHandle^ );
{$ENDIF}
  sAppName := Params.Values[szAPPNAME];
  sHostName := Params.Values[szHOSTNAME];

  if Length(Trim( sAppName )) = 0 then
    sAppName := GetAppName;
  if Length(Trim( sHostName )) = 0 then
    sHostName := GetHostName;

	// Sets the maximum number of simultaneously opened connections, which has to be more then current value
  IntValue := StrToIntDef( Params.Values[szMAXCURSORS], 0 );
  if IntValue >   SybCtxGetPropInt32( pCSContext, CS_MAX_CONNECT ) then
    SybCtxSetPropInt32( pCSContext, CS_MAX_CONNECT, IntValue );

  if (ct_con_alloc( pCSContext, rec.ConnPtr ) <> CS_SUCCEED) or
     (ct_diag( rec.ConnPtr, CS_INIT, CS_UNUSED, CS_UNUSED, nil ) <> CS_SUCCEED)
  then
    DatabaseErrorFmt(SFatalError, ['TISybDatabase.DoConnect']);

{$IFDEF SD_CLR}
  szUser:= Marshal.StringToHGlobalAnsi(sUserName);
  szPwd	:= Marshal.StringToHGlobalAnsi(sPassword);
  szApp	:= Marshal.StringToHGlobalAnsi(sAppName);
  szHost:= Marshal.StringToHGlobalAnsi(sHostName);
{$ELSE}
  szUser:= TSDCharPtr(sUserName);
  szPwd	:= TSDCharPtr(sPassword);
  szApp	:= TSDCharPtr(sAppName);
  szHost:= TSDCharPtr(sHostName);
{$ENDIF}
  ct_con_props( rec.ConnPtr, CS_SET, CS_USERNAME, PCS_VOID(szUser), CS_NULLTERM, nil );
  ct_con_props( rec.ConnPtr, CS_SET, CS_PASSWORD, PCS_VOID(szPwd), CS_NULLTERM, nil );
  ct_con_props( rec.ConnPtr, CS_SET, CS_APPNAME,  PCS_VOID(szApp), CS_NULLTERM, nil );
  ct_con_props( rec.ConnPtr, CS_SET, CS_HOSTNAME, PCS_VOID(szHost), CS_NULLTERM, nil );
	// set login timeout before connect
  sValue := Trim( Params.Values[szLOGINTIMEOUT] );
  if sValue <> '' then begin
    IntValue := StrToIntDef( sValue, 0 );
    SybCtxSetPropInt32( pCSContext, CS_LOGIN_TIMEOUT, IntValue );
  end;
	// set command timeout value, if it's set
  sValue := Trim( Params.Values[szCMDTIMEOUT] );
  if sValue <> '' then begin
    IntValue := StrToIntDef( sValue, 0 );
    SybCtxSetPropInt32( pCSContext, CS_TIMEOUT, IntValue );
  end;

	// set TDS packet size, if it's defined
  PacketSize := StrToIntDef( Params.Values[szTDSPACKETSIZE], 0 );
  if PacketSize > 0 then
    SybConSetOptionInt32( rec.ConnPtr, CS_PACKETSIZE, PacketSize );
	// whether to set encrypted password security handshaking
  if UpperCase(Trim( Params.Values[szENCRYPTION] )) = STrueString then begin
    bValue := CS_TRUE;
    Check( SybConSetOptionInt32(rec.ConnPtr, CS_SEC_ENCRYPTION, bValue) );
  end;


  sSrvName := ExtractServerName(sRemoteDatabase);
  sDbName := ExtractDatabaseName(sRemoteDatabase);
{$IFDEF SD_CLR}
  szSrv	:= Marshal.StringToHGlobalAnsi(sSrvName);
{$ELSE}
  szSrv	:= TSDCharPtr(sSrvName);
{$ENDIF}
  Check( ct_connect( rec.ConnPtr, szSrv, CS_NULLTERM ) );
  try
    Check( ct_cmd_alloc( rec.ConnPtr, rec.CmdPtr ) );
  except
    if Assigned(rec.ConnPtr) then
      ct_con_drop( rec.ConnPtr );
    raise;
  end;

{$IFDEF SD_CLR}
  rec.szSrvName := Marshal.StringToHGlobalAnsi( sSrvName );
  rec.szDBName	:= Marshal.StringToHGlobalAnsi( sDbName );
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  rec.szSrvName := StrNew( TSDCharPtr(sSrvName) );
  rec.szDBName	:= StrNew( TSDCharPtr(sDbName) );
  TISybConnInfo(FHandle^) := rec;
{$ENDIF}

  if sDbName <> '' then begin
    HandleInitCmd( rec.CmdPtr, 'use ' + sDbName );
    HandleExec( rec.CmdPtr );
    HandleReset( rec.CmdPtr );
  end;
  SetDefaultOptions;

  finally
{$IFDEF SD_CLR}
  if Assigned(szUser) then
    Marshal.FreeHGlobal(szUser);
  if Assigned(szPwd) then
    Marshal.FreeHGlobal(szPwd);
  if Assigned(szApp) then
    Marshal.FreeHGlobal(szApp);
  if Assigned(szHost) then
    Marshal.FreeHGlobal(szHost);
  if Assigned(szSrv) then
    Marshal.FreeHGlobal(szSrv);
{$ENDIF}
  end;
end;

procedure TISybDatabase.DoDisconnect(Force: Boolean);
var
  rcd: TCS_RETCODE;
  bVal: TCS_BOOL;
begin
  if Assigned(FHandle) then begin
    if Assigned( CmdPtr ) then begin
      ct_cmd_drop( CmdPtr );
{$IFNDEF SD_CLR}
      TISybConnInfo(FHandle^).CmdPtr := nil;
{$ENDIF}
    end;
    if Assigned( ConnPtr ) then begin
      if (SybConGetOptionInt32( ConnPtr, CS_LOGIN_STATUS, bVal ) = CS_SUCCEED) and
         (bVal = CS_TRUE)
      then begin
	// cancels all result for this connection
        rcd := ct_cancel( ConnPtr, nil, CS_CANCEL_ALL);
        if not Force then
          Check( rcd );

        rcd := ct_close( ConnPtr, CS_UNUSED );
        if not Force then
          Check( rcd );
      end;
      ct_con_drop( ConnPtr );
{$IFNDEF SD_CLR}
      TISybConnInfo(FHandle^).ConnPtr := nil;
{$ENDIF}
    end;
    FreeHandle;
  end;

  FIsAnywhere := False;
  FreeSqlLib;
end;

procedure TISybDatabase.SetTransIsolation(Value: TISqlTransIsolation);
begin
  if not Assigned( FHandle ) then
    Exit;

  HandleSetIsolation( ConnPtr );
end;

procedure TISybDatabase.SetDefaultOptions;
begin
  if not Assigned( FHandle ) then
    Exit;

  HandleSetDefOpt( ConnPtr );
  HandleSetIsolation( ConnPtr );

  SetIsAnywhereProp;
end;


{ TISybCommand }
constructor TISybCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FBindStmt	:= '';
  FRowsAffected := -1;
  FRowResult	:= False;
  FConnected	:= False;
  FNextResults	:= False;
  FEndOfFetch	:= False;

  FConnPtr	:= nil;
  FHandle	:= nil;

  FColInfo:= TStringList.Create;

  FEmptyStrAsNull := SqlDatabase.EmptyStrAsNull;
  FIsRTrimChar := SqlDatabase.IsRTrimChar;
  FIsSingleConn:= SqlDatabase.IsSingleConn;
end;

destructor TISybCommand.Destroy;
begin
  if FConnPtr <> nil then
    Disconnect(False);

  FColInfo.Free;
  FColInfo := nil;

  inherited Destroy;
end;

procedure TISybCommand.Connect;

  function IsQuery(const AStmt: string): Boolean;
  var
    SelPos, i: Integer;
  begin
    Result := ctStoredProc = CommandType;
    if Result then
      Exit;
    SelPos := LocateText('select', AStmt);
    if SelPos = 0 then
      Exit;
    Result := SelPos = 1;
    if Result then
      Exit;
    for i:=1 to SelPos-1 do
      if not (AnsiChar(AStmt[i]) in [#$0A, #$0D, #$20]) then
        Exit;

    Result := True;
  end;

begin
  FRowsAffected := -1;
  FRowResult	:= False;
  FColInfo.Clear;

  // if it is not need to use a single process or statement can return rows,
  //else it's using Process of SqlDatabase (without connecting private process)
  if not FConnected and not FIsSingleConn and IsQuery(CommandText) then
    CreateConnection;

  FConnected	:= True;
  FEndResults	:= False;
end;

procedure TISybCommand.CloseResultSet;
begin
  if FNextResults then begin
    ClearFieldDescs;
    Exit;
  end;

  FBindStmt := '';
  FRowResult:= False;

	// to avoid dropping of the current active result set, when other query is closing
  if FIsSingleConn and
     Assigned(SqlDatabase.CurSqlCmd) and
     (SqlDatabase.CurSqlCmd <> Self)
  then
    Exit;

	// for example, in case of empty statement(raise an exception), Handle is not created at all
  if Assigned( CmdPtr ) then
    HandleReset( CmdPtr );
	// it's need in case of close a result set without full fetch
  ReleaseDBHandle;
end;

procedure TISybCommand.Disconnect(Force: Boolean);
begin
  if Assigned(FColInfo) then
    FColInfo.Clear;

  FBindStmt	:= '';
  FConnected	:= False;

  ReleaseDBHandle;

  if FConnPtr = nil then Exit;

  if FHandle <> nil then begin
    Check( ct_cancel(nil, FHandle, CS_CANCEL_ALL) );	// cancels result for this command structure
    Check( ct_cmd_drop( FHandle ) );
  end;
  FHandle	:= nil;

  Check( ct_cancel(FConnPtr, nil, CS_CANCEL_ALL) );		// cancels all result for this connection
  Check( ct_close( FConnPtr, CS_UNUSED ) );
  ct_con_drop( FConnPtr );

  FConnPtr	:= nil;
end;

function TISybCommand.GetExecuted: Boolean;
begin
  Result := Length(FBindStmt) > 0;
end;

function TISybCommand.GetCmdPtr: PCS_COMMAND;
begin
  Result := nil;
  if CommandType = ctStoredProc then begin
    Result := SqlDatabase.CmdPtr;
    Exit;
  end;
  if FConnected then begin
  	// if FHandle = nil then use SqlDatabase.Handle (statement can't return rows)
    if FHandle = nil
    then Result := SqlDatabase.CmdPtr
    else Result := FHandle;
  end;
{  if Assigned(Handle) then
    Result := PSybConnection(Handle)^.cmd;}
end;

function TISybCommand.GetHandle: PSDCursor;
begin
  Result := GetCmdPtr;    // PCS_COMMAND;

{  if CommandType = ctStoredProc then begin
    Result := PSybSrvInfo(SqlDatabase.FHandle^.SrvInfo);
    Exit;
  end;
  if FConnected then begin
  	// if FHandle = nil then use SqlDatabase.Handle (statement can't return rows)
    if FHandle.conn = nil
    then Result := PSybSrvInfo(SqlDatabase.FHandle^.SrvInfo)
    else Result := @FHandle;
  end else
    Result := nil;}
end;

function TISybCommand.GetSqlDatabase: TISybDatabase;
begin
  Result := (inherited SqlDatabase) as TISybDatabase;
end;

{ Marks a database handle as used by the current dataset }
procedure TISybCommand.AcquireDBHandle;
begin
  if FIsSingleConn then
    SqlDatabase.ReleaseDBHandle(Self, True);
end;

{ Releases a database handle, which was used by the current dataset }
procedure TISybCommand.ReleaseDBHandle;
begin
  if SqlDatabase.CurSqlCmd = Self then
    SqlDatabase.ReleaseDBHandle(nil, False);
end;

function TISybCommand.ResultSetExists: Boolean;
begin
  Result := True;
end;

procedure TISybCommand.Check( rcd: TCS_RETCODE );
begin
  if FConnPtr <> nil then
    SqlDatabase.CheckExt( rcd, FConnPtr )
  else
    SqlDatabase.CheckExt( rcd, SqlDatabase.ConnPtr );
end;

// creates a separate connection and set FConnPtr and FHandle
procedure TISybCommand.CreateConnection;
var
  conn: PCS_CONNECTION;
  cmd: PCS_COMMAND;
  login: PCS_LOGINFO;
  rslt: TCS_INT;
  sDbName: string;
  szSrv, szDb: TSDCharPtr;
begin
  conn := nil;
  try	// finally
  try	// except
    if (ct_con_alloc( pCSContext, conn ) <> CS_SUCCEED) or
       (ct_diag( conn, CS_INIT, CS_UNUSED, CS_UNUSED, nil ) <> CS_SUCCEED)
    then
      DatabaseErrorFmt(SFatalError, ['Cannot allocate connection structure in TISybCommand.CreateConnect']);

    if (ct_getloginfo( SqlDatabase.ConnPtr, login ) <> CS_SUCCEED) or
       (ct_setloginfo( conn, login ) <> CS_SUCCEED)
    then
      DatabaseErrorFmt(SFatalError, ['Cannot transfer TDS login information in TISybCommand.CreateConnect']);

    szSrv := SqlDatabase.SrvNamePtr;
    sDbName := HelperPtrToString(SqlDatabase.DBNamePtr);
    if ct_connect( conn, szSrv, CS_NULLTERM ) <> CS_SUCCEED then
      SybError( conn );

    SqlDatabase.HandleSetDefOpt( conn );

    if ct_cmd_alloc( conn, cmd ) <> CS_SUCCEED then
      SybError( conn );
    if sDbName <> '' then begin
      sDbName := 'use ' + sDbName;
{$IFDEF SD_CLR}
      szDb := Marshal.StringToHGlobalAnsi(sDbName);
{$ELSE}
      szDb := TSDCharPtr(sDbName);
{$ENDIF}
      if ct_command( cmd, CS_LANG_CMD, szDb, CS_NULLTERM, CS_UNUSED ) <> CS_SUCCEED then
        SybError( conn );
      if ct_send( cmd ) <> CS_SUCCEED then
        SybError( conn );
      repeat
        if ct_results( cmd, rslt ) <> CS_SUCCEED then
          SybError( conn );
      until rslt = CS_CMD_DONE;
      Check( ct_cancel( nil, cmd, CS_CANCEL_ALL ) );
    end;
    	// set the current isolation level
    SqlDatabase.HandleSetIsolation(conn);

    FConnPtr := conn;
    FHandle := cmd;
  except
    if cmd <> nil then
      ct_cmd_drop( cmd );
    if conn <> nil then
      ct_con_drop( conn );

    raise;
  end;
  finally
{$IFDEF SD_CLR}
    if Assigned(szDb) then
      Marshal.FreeHGlobal(szDb);
{$ENDIF}
  end;
end;

// Cancels current command and discards all result set
procedure TISybCommand.HandleReset(ACmd: PCS_COMMAND);
begin
  if Assigned( ACmd ) then
    Check( ct_cancel(nil, ACmd, CS_CANCEL_ALL) );
end;

{ Discards the current result set }
procedure TISybCommand.HandleCurReset(ACmd: PCS_COMMAND);
begin
  if Assigned( ACmd ) then
    Check( ct_cancel(nil, ACmd, CS_CANCEL_CURRENT) );
end;

procedure TISybCommand.HandleInitLangCmd(ACmd: PCS_COMMAND; sCmd: string);
var
  CmdPtr: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  CmdPtr := Marshal.StringToHGlobalAnsi( sCmd );
  try
{$ELSE}
  CmdPtr := PChar( sCmd );
{$ENDIF}
  Check( ct_command(ACmd, CS_LANG_CMD, CmdPtr, CS_NULLTERM, CS_UNUSED) );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal( CmdPtr );
  end;
{$ENDIF}
end;

procedure TISybCommand.HandleInitRpcCmd(ACmd: PCS_COMMAND; ARpcName: string);
var
  CmdPtr: TSDCharPtr;
begin
{$IFDEF SD_CLR}
  CmdPtr := Marshal.StringToHGlobalAnsi( ARpcName );
  try
{$ELSE}
  CmdPtr := PChar( ARpcName );
{$ENDIF}
  Check( ct_command(ACmd, CS_RPC_CMD, CmdPtr, CS_NULLTERM, CS_NO_RECOMPILE) );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal( CmdPtr );
  end;
{$ENDIF}
end;

function TISybCommand.HandleExec(ACmd: PCS_COMMAND): TCS_INT;
var
  rslt, outlen: TCS_INT;
begin
  Check( ct_send( ACmd ) );
  while ct_results( ACmd, rslt ) = CS_SUCCEED do begin
    case rslt of
      CS_ROW_RESULT:
        Break;
      CS_STATUS_RESULT:
        InternalGetStatus;
      CS_CMD_DONE:      // the result of a logical command have been completely processed
        begin
          Check( ct_res_info( CmdPtr, CS_ROW_COUNT, {$IFNDEF SD_CLR}@{$ENDIF}FRowsAffected, CS_UNUSED, outlen ) );
          Check( CS_FAIL );
        end;
      CS_CMD_SUCCEED:   // the success of a command that returns no data (for example, INSERT command)
        Check( CS_FAIL );	// check and raise an user defined error (RAISEERROR statement)
      CS_CMD_FAIL:
        Check( CS_FAIL );
    end;
  end;

  Result := rslt;
end;

procedure TISybCommand.HandleSend(ACmd: PCS_COMMAND);
begin
  Check( ct_send( ACmd ) );
end;

// returns True, if it's need to process regular row result (CS_ROW_RESULT)
function TISybCommand.HandleSpResults(ACmd: PCS_COMMAND): Boolean;
var
  rcd, rslt: TCS_INT;
begin
  Result := False;
  repeat
    rcd := ct_results( ACmd, rslt );

    FEndResults := rcd = CS_END_RESULTS;
        // When all results of a command or procedure are processed, check: if RAISERROR is called, then raise an exception (it's actual after ExecProc/GetResults)
    if FEndResults then
      Check( rcd );
    case rslt of
      CS_ROW_RESULT:
        begin
          FRowResult := True;
          Result := True;
          Break;
        end;
      CS_PARAM_RESULT:  InternalSpGetParams;
      CS_STATUS_RESULT: InternalGetStatus;
      CS_CMD_DONE,
      CS_CMD_SUCCEED:	Check( rcd );   // check whether RAISERROR is called (it's important for some ASE versions)
      CS_CMD_FAIL:
        Check( CS_FAIL );
    end;
  until rcd <> CS_SUCCEED;
end;

function TISybCommand.FetchNextRow: Boolean;
var
  rcd: TCS_RETCODE;
begin
  rcd := CS_FAIL;

  try
    if FRowResult then
      rcd := ct_fetch( CmdPtr, CS_UNUSED, CS_UNUSED, CS_UNUSED, nil )
    else
      rcd := CS_END_DATA;
    SqlDatabase.ResetIdleTimeOut;
  finally
    Result := (rcd = CS_SUCCEED);
    if (not Result) and (rcd <> CS_END_DATA) then
      Check( rcd );	// if rcd = CS_ROW_FAIL or other invalid code
  end;

  if Result then begin
    if BlobFieldCount > 0 then
      ReadNonBindFields;	// including blobs
  end else
    ReleaseDBHandle;
end;

procedure TISybCommand.InternalExecute;
begin
  AcquireDBHandle;

  if CommandType = ctStoredProc then
    InternalSpExecute
  else
    InternalQExecute;
end;

function TISybCommand.FieldDataType(ExtDataType: Integer): TFieldType;
begin
  case ExtDataType of
    CS_CHAR_TYPE:	//	= TCS_INT(0);
      Result := ftString;
    CS_BINARY_TYPE:	//	= TCS_INT(1);
      Result := ftBytes;
    CS_LONGCHAR_TYPE:	//	= TCS_INT(2);
      Result := ftString;
    CS_LONGBINARY_TYPE:	//	= TCS_INT(3);
      Result := ftBytes;
    CS_TEXT_TYPE:	//	= TCS_INT(4);
      Result := ftMemo;
    CS_IMAGE_TYPE:	//	= TCS_INT(5);
      Result := ftBlob;
    CS_TINYINT_TYPE,	//	= TCS_INT(6);
    CS_SMALLINT_TYPE:	//	= TCS_INT(7);
      Result := ftSmallInt;
    CS_INT_TYPE:	//	= TCS_INT(8);
      Result := ftInteger;
    CS_REAL_TYPE,	//	= TCS_INT(9);
    CS_FLOAT_TYPE:	//	= TCS_INT(10);
      Result := ftFloat;
    CS_BIT_TYPE:	//	= TCS_INT(11);
      Result := ftBoolean;
    CS_DATETIME_TYPE,	//	= TCS_INT(12);
    CS_DATETIME4_TYPE:	//	= TCS_INT(13);
      Result := ftDateTime;
    CS_MONEY_TYPE,	//	= TCS_INT(14);
    CS_MONEY4_TYPE:	//	= TCS_INT(15);
      Result := ftCurrency;
    CS_NUMERIC_TYPE,	//	= TCS_INT(16);
    CS_DECIMAL_TYPE:	//	= TCS_INT(17);
      Result := ftFloat;
    CS_VARCHAR_TYPE:	//	= TCS_INT(18);
      Result := ftString;
//    CS_VARBINARY_TYPE	= TCS_INT(19);
//    CS_LONG_TYPE		= TCS_INT(20);
//    CS_SENSITIVITY_TYPE	= TCS_INT(21);
//    CS_BOUNDARY_TYPE	= TCS_INT(22);
//    CS_VOID_TYPE		= TCS_INT(23);
//    CS_USHORT_TYPE	= TCS_INT(24);
  else
    Result := ftUnknown;
  end;
end;

function TISybCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  { Converting from TFieldType â Program Data Type(Sybase Open-Client) }
  SybDataSizeMap: array[TFieldType] of Word = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	0,	2, 	SizeOf(TCS_INT), 	2, 	2,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        SizeOf(Double), SizeOf(Double), SizeOf(Double), 0, 0,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        0, 	0, 	0, SizeOf(TCS_INT), 	0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
        // ftInterface, ftIDispatch, ftGuid
        0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
	// Delphi 8 do not support: const A = SizeOf( structure );
  case FieldType of
    ftDate,
    ftTime,
    ftDateTime:	Result := SizeOf(TCS_DATETIME);
  else
    Result := SybDataSizeMap[FieldType];
  end;
end;

function TISybCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType â bind Data Type(Sybase Open-Client) }
  SybDataTypeMap: array[TFieldType] of Integer = ( CS_ILLEGAL_TYPE,// ftUnknown
	// ftString, ftSmallint, 	ftInteger, 	ftWord, 	ftBoolean
	CS_CHAR_TYPE, CS_SMALLINT_TYPE, CS_INT_TYPE, CS_INT_TYPE, CS_SMALLINT_TYPE,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        CS_FLOAT_TYPE, CS_FLOAT_TYPE, 	CS_FLOAT_TYPE, CS_DATETIME_TYPE, CS_DATETIME_TYPE,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        CS_DATETIME_TYPE, CS_BINARY_TYPE, CS_BINARY_TYPE, CS_INT_TYPE, CS_IMAGE_TYPE,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        CS_TEXT_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE,
        // ftTypedBinary, ftCursor
        CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE,
        // ftADT, ftArray, ftReference, ftDataSet
        CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob,   ftOraClob,      ftVariant,
        CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE,
        // ftInterface, ftIDispatch,    ftGuid
        CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE, CS_ILLEGAL_TYPE
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  Result := SybDataTypeMap[FieldType];
end;

function TISybCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := FieldType in [ftBoolean, ftDate, ftTime, ftDateTime, ftCurrency, ftFloat, ftBCD];
end;

procedure TISybCommand.GetFieldDescs(Descs: TSDFieldDescList);
var
  ft: TFieldType;
  Col, NumCols, outlen: TCS_INT;
  colinfo: TCS_DATAFMT;
  sColName: string;
begin
  if not Executed then
    InternalExecute;
  if not FRowResult then
    Exit;
	// information is available after ct_results returns CS_ROW_RESULT or other CS_xxx_RESULT value
  Check( ct_res_info( CmdPtr, CS_NUMDATA, {$IFNDEF SD_CLR}@{$ENDIF}NumCols, CS_UNUSED, outlen) );

  for Col:=1 to NumCols do begin
    InitDataFmtStruct(colinfo);
    Check( ct_describe( CmdPtr, Col, colinfo ) );
    if colinfo.namelen > 0 then
      sColName := {$IFDEF SD_CLR}colinfo.name{$ELSE}StrPas(colinfo.name){$ENDIF};
    ft := FieldDataType(colinfo.datatype);
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [sColName] );
      	// check autoincrement property for a number column. Only numeric field with scale 0 can be used for IDENTITY column in Sybase SQL Server.
        // Only NUMERIC(<=10) can be used as TAutoIncField
    if IsNumericType(ft) and ((colinfo.status and CS_IDENTITY) <> 0) and
      (colinfo.precision <= MAX_INTFIELD_PREC) and (colinfo.scale = 0)
    then
      ft := ftAutoInc;
    if (ft = ftFloat) and (colinfo.scale > 0) and (colinfo.scale <= MAX_BCDFIELD_SCALE) and
       (colinfo.precision <= MAX_BCDFIELD_PREC)and SqlDatabase.IsEnableBCD
    then
      ft := ftBCD;
    with Descs.AddFieldDesc do begin
      FieldName	:= sColName;
      FieldNo	:= Col;
      FieldType	:= ft;
      DataType	:= colinfo.datatype;
      if IsRequiredSizeTypes(ft) then begin
        DataSize:= SmallInt( colinfo.maxlength );
     	// increase buffer for null-terminator
        if ft = ftString then
          Inc(DataSize);
      end else if not IsBlobType(ft) then begin
        if ft = ftBCD then begin
          Scale	    := colinfo.scale;
          Precision := MAX_BCDFIELD_PREC;	// depends from Currency type
        end;
        DataSize := NativeDataSize(ft)
      end else
        DataSize:= 0;
      Precision	:= SmallInt( colinfo.precision );
  	// if (colinfo.status & $0020) = 0 then null values are not permitted for the column (Required = True)
      Required	:= (colinfo.status and CS_CANBENULL) = 0;
    end;
  end;
end;

// Binds result column from select list
procedure TISybCommand.SetFieldsBuffer;
var
  i, nOffset: Integer;
  colinfo: TCS_DATAFMT;
  DataPtr: TSDCharPtr;
begin
  if not Executed then
    InternalExecute;

  FMinBlobFieldNo := 0;
  nOffset := 0;		// pointer to the TSDFieldInfo

  for i:=0 to FieldDescs.Count-1 do begin
    colinfo.datatype := NativeDataType(FieldDescs[i].FieldType);
    if colinfo.datatype = CS_ILLEGAL_TYPE then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );

    colinfo.maxlength	:= FieldDescs[i].DataSize;
    colinfo.format	:= CS_FMT_UNUSED;
    colinfo.scale	:= CS_SRC_VALUE;
    colinfo.precision	:= CS_SRC_VALUE;
    colinfo.count	:= 0;
    colinfo.locale	:= nil;

    DataPtr := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );

    if not IsBlobType(FieldDescs[i].FieldType) then begin
      if FMinBlobFieldNo <> 0 then
        Break;		// stop to call ct_bind after a blob column

      Check( ct_bind( CmdPtr, FieldDescs[i].FieldNo, colinfo, PCS_VOID(DataPtr),
                      IncPtr(DataPtr, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff),
                      IncPtr(DataPtr, -SizeOf(TSDFieldInfo) + GetFieldInfoFetchStatusOff) ) )
    end else if (FMinBlobFieldNo = 0) or (FMinBlobFieldNo > FieldDescs[i].FieldNo) then
      FMinBlobFieldNo := FieldDescs[i].FieldNo;

    Inc(nOffset, SizeOf(TSDFieldInfo) + colinfo.maxlength);
  end;

  if Self.BlobFieldCount > 0 then
    ParseFieldNames( FBindStmt, FColInfo );
end;

{ Gets all fields after first blob field in a select-list, including Blobs }
procedure TISybCommand.ReadNonBindFields;
var
  i, nOffset: Integer;
  sBlobData: TSDBlobData;
  DataPtr, InfoPtr: TSDCharPtr;
  FieldInfo: TSDFieldInfo;
begin
  nOffset := 0;
	// field data has to be retrieved by order in select-list
  for i:=0 to FieldDescs.Count-1 do begin
  	// if non-bound field
    if FieldDescs[i].FieldNo >= FMinBlobFieldNo then begin
      if not IsBlobType(FieldDescs[i].FieldType) then begin
        DataPtr := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );
        InfoPtr := IncPtr( DataPtr, -SizeOf(TSDFieldInfo) );
        FieldInfo := GetFieldInfoStruct(InfoPtr, 0);
        FieldInfo.DataSize := ReadNonBlobField(FieldDescs[i], DataPtr, FieldDescs[i].DataSize);
        if FieldInfo.DataSize > 0
        then FieldInfo.FetchStatus := indVALUE
        else FieldInfo.FetchStatus := indNULL;
        SetFieldInfoStruct(InfoPtr, 0, FieldInfo);
      end else begin
        if ReadBlob(FieldDescs[i], sBlobData) > 0 then begin
          PutBlobValue(FieldDescs[i], sBlobData);
        end else
          PutBlobValue(FieldDescs[i], nil);
      end;
    end;
    Inc(nOffset, SizeOf(TSDFieldInfo) + FieldDescs[i].DataSize);
  end;
end;

{ Gets and places field data in a select buffer }
function TISybCommand.ReadNonBlobField(AFieldDesc: TSDFieldDesc; SelBuf: TSDPtr; BufLen: Integer): Integer;
var
  ft: TFieldType;
  outlen, rcd: TCS_INT;
  colinfo: TCS_DATAFMT;
  numdata: TCS_NUMERIC;	// size = 35 byte, max. buffer for float numbers
  NumDataPtr: PCS_VOID;
  dt4: TCS_DATETIME4;
  dt: TCS_DATETIME;
begin
  Result := 0;
  ft := AFieldDesc.FieldType;
  if ft in [ftCurrency, ftFloat, ftDate, ftDateTime, ftTime] then
    Check( ct_describe( CmdPtr, AFieldDesc.FieldNo, colinfo ) )
  else
    colinfo.datatype := CS_INT_TYPE;	// data conversion is not required

	// data is retrieved in TCS_NUMERIC structure
  if (colinfo.datatype = CS_DECIMAL_TYPE) or (colinfo.datatype = CS_NUMERIC_TYPE) or
     (colinfo.datatype = CS_REAL_TYPE) or
     (colinfo.datatype = CS_MONEY_TYPE) or (colinfo.datatype = CS_MONEY4_TYPE)
  then begin
{$IFDEF SD_CLR}
    NumDataPtr := SafeReallocMem(nil, SizeOf(numdata));
    try
{$ELSE}
    NumDataPtr := @numdata;
{$ENDIF};
    rcd := ct_get_data( CmdPtr, AFieldDesc.FieldNo, PCS_VOID(NumDataPtr), SizeOf(numdata), outlen );
  	// if the column data is not retrieved succesfully
    if not(rcd = CS_END_ITEM) and not(rcd = CS_END_DATA) then
      Check( rcd );
       // outlen-2 (2*TCS_BYTE) - exclude size of the first fields in TCS_NUMERIC record
    if (colinfo.datatype = CS_DECIMAL_TYPE) or (colinfo.datatype = CS_NUMERIC_TYPE) then
      outlen := outlen - 2;
       // if not empty
    if outlen > 0 then begin
      HelperMemWriteDouble(SelBuf, 0, CnvtDBFloatToFloat( colinfo, NumDataPtr ));
      Result := SizeOf(Double);
    end else
      HelperMemWriteDouble(SelBuf, 0, 0);
{$IFDEF SD_CLR}
    finally
      SafeReallocMem(NumDataPtr, 0);
    end;
{$ENDIF}
  end else begin
    rcd := ct_get_data( CmdPtr, AFieldDesc.FieldNo, PCS_VOID(SelBuf), BufLen, outlen );
  	// if the column data is not retrieved succesfully
    if not(rcd = CS_END_ITEM) and not(rcd = CS_END_DATA) then
      Check( rcd );
    if colinfo.datatype = CS_DATETIME4_TYPE then begin
  {$IFDEF SD_CLR}
      dt4 := TCS_DATETIME4( Marshal.PtrToStructure(SelBuf, TypeOf(TCS_DATETIME4)) );
  {$ELSE}
      dt4 := TCS_DATETIME4(SelBuf^);
  {$ENDIF}
//      min := PCS_DATETIME4(SelBuf)^.minutes;	// store minutes to prevent override in SelBuf, it's not need now
      dt.dtdays := dt4.days;
	// number 300th second since mid = (number of minutes since mid)*60*300
      dt.dttime := dt4.minutes * 60 * 300;
  {$IFDEF SD_CLR}
      Marshal.StructureToPtr(dt, SelBuf, False);
  {$ELSE}
      TCS_DATETIME(SelBuf^) := dt;
  {$ENDIF}
    end;

    if (ft in [ftBoolean, ftCurrency, ftFloat, ftDate, ftDateTime, ftTime]) and (outlen > 0)
    then Result := NativeDataSize(ft)
    else Result := outlen;
  end;
end;

{ Gets blob field }
function TISybCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  CurPtr: TSDCharPtr;			// pointer to current piece buffer
  GrowDelta: TCS_INT;
  outlen, rcd: TCS_INT;
  iodesc: TCS_IODESC;
begin
  Result := 0;

  SetLength(BlobData, 1);
  CurPtr := TSDCharPtr(BlobData); // ???
  	// buflen = 0 -> it's need to update IO descriptor (data length) for column w/o retrieving the data
  rcd := ct_get_data( CmdPtr, AFieldDesc.FieldNo, PCS_VOID(CurPtr), 0, outlen );
  	// field is NULL
  if (rcd = CS_END_ITEM) or (rcd = CS_END_DATA) then begin
    SetLength(BlobData, Result);  
    Exit
  end else
    Check( rcd );
  	// retrieve IO descriptor (data length) for column
  Check( ct_data_info( CmdPtr, CS_GET, AFieldDesc.FieldNo, iodesc ) );
  SetLength( BlobData, iodesc.total_txtlen );
	// get Blob data through SqlDatabase.Handle
  GrowDelta := SqlDatabase.BlobPieceSize;
{$IFDEF SD_CLR}
  CurPtr := SafeReallocMem(nil, GrowDelta);
  try
{$ENDIF}
  repeat
{$IFNDEF SD_CLR}
    CurPtr := @TSDCharPtr(BlobData)[Result];
{$ENDIF}
    rcd := ct_get_data( CmdPtr, AFieldDesc.FieldNo, PCS_VOID(CurPtr), GrowDelta, outlen );
    if (rcd <> CS_SUCCEED) and (rcd <> CS_END_ITEM) and (rcd <> CS_END_DATA) then
      Check( rcd );

    if outlen > 0 then begin
{$IFDEF SD_CLR}
      Marshal.Copy( CurPtr, BlobData, Result, outlen );
{$ENDIF}
      Inc(Result, outlen);
    end;
  until (rcd = CS_END_ITEM) or (rcd = CS_END_DATA);
{$IFDEF SD_CLR}
  finally
    SafeReallocMem(CurPtr, 0);
  end;
{$ENDIF}
end;

function TISybCommand.GetParamsBufferSize: Integer;
var
  i, NumBytes: Integer;
begin
  Result := 0;
  if not Assigned(Params) then
    Exit;
    
  NumBytes := 0;
  if CommandType = ctQuery then begin
    for i := 0 to Params.Count - 1 do
      with Params[i] do begin
        if DataType = ftUnknown then
          DatabaseErrorFmt(SNoParameterValue, [Name]);
        if ParamType = ptUnknown then
          DatabaseErrorFmt(SNoParameterType, [Name]);
        Inc(NumBytes, SizeOf(TSDFieldInfo) + NativeParamSize(Params[i]));
      end;
  end else if CommandType = ctStoredProc then begin
    for i := 0 to Params.Count - 1 do
      with Params[i] do begin
        if DataType = ftUnknown then
          DatabaseErrorFmt(SNoParameterValue, [Name]);
        Inc(NumBytes, SizeOf(TSDFieldInfo) + NativeParamSize(Params[i]));
      end;
  end else
    DatabaseErrorFmt( SFatalError, ['TISybCommand.GetParamsBufferSize'] );
  Result := NumBytes;
end;

	// Query methods
procedure TISybCommand.BindParamsBuffer;
begin
end;

function TISybCommand.GetRowsAffected: Integer;
begin
  Result := FRowsAffected;
end;

procedure TISybCommand.DoPrepare(Value: string);
begin
  FBindStmt	:= '';
  if CommandType = ctStoredProc then begin
    if Assigned(Params) and (Params.Count = 0) then
      InitParamList;
  end else
    Connect;
end;

procedure TISybCommand.DoExecDirect(Value: string);
begin
  FBindStmt	:= '';
  if CommandType <> ctStoredProc then
    Connect;

  AllocParamsBuffer;
  BindParamsBuffer;

  InternalExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if FieldDescs.Count = 0 then
    InitFieldDescs;

  SetNativeCommand(FBindStmt);
end;

procedure TISybCommand.DoExecute;
begin
	// to process a prepared statement(w/o result set: UPDATE, INSERT..) repeatedly - dsfExecSQL in DSFlags was checked.
	// a statement is executed always for command or procedure w/o result set
  if not Executed or (FieldDescs.Count = 0) then
    InternalExecute;
  	// if field descriptions were not initialized before Execute (for InternalInitFieldDefs)
  if (FieldDescs.Count = 0) and FRowResult then
    InitFieldDescs;

  SetNativeCommand(FBindStmt);
end;

{ Overided, because field descriptions are accessible after executing only }
procedure TISybCommand.Execute;
begin
  AllocParamsBuffer;
  BindParamsBuffer;

  DoExecute;

  if FieldsBuffer = nil then
    AllocFieldsBuffer;
  SetFieldsBuffer;
end;

{ Converts database NUMERIC, MONEY, REAL data to 8-byte double }
function TISybCommand.CnvtDBFloatToFloat(datafmt: TCS_DATAFMT; data: TCS_VOID): Double;
var
  destfmt: TCS_DATAFMT;
  outlen: TCS_INT;
begin
  Result := 0.0;
  InitDataFmtStruct( destfmt );

  destfmt.datatype := CS_FLOAT_TYPE;
  destfmt.maxlength:= SizeOf(Result);
  destfmt.format   := CS_FMT_UNUSED;
  destfmt.scale	   := CS_MAX_SCALE;
  destfmt.precision:= CS_MAX_PREC;
  outlen := SizeOf(Result);

  Check( cs_convert( pCSContext, datafmt, data, destfmt, {$IFNDEF SD_CLR}@{$ENDIF}Result, outlen ) );
end;

// Buffer pointer to TCS_DATETIME
function TISybCommand.CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;
var
  daterec: TCS_DATEREC;
  dtDate, dtTime: TDateTime;
begin
  Check(
  	cs_dt_crack( pCSContext, CS_DATETIME_TYPE,
        	PCS_VOID(Buffer), daterec ) );

  dtDate := EncodeDate(daterec.dateyear, daterec.datemonth+1, daterec.datedmonth);
  dtTime := EncodeTime(daterec.datehour, daterec.dateminute, daterec.datesecond, 0);

  case (ADataType) of
    ftTime:
      Result.Time := DateTimeToTimeStamp(dtTime).Time + daterec.datemsecond;
    ftDate:
      Result.Date := DateTimeToTimeStamp(dtDate).Date;
    ftDateTime:
      Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) ) + daterec.datemsecond;
  else
    Result.DateTime := 0.0;
  end;
end;

function TISybCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  InBuf, InData, OutData: TSDPtr;
  dtDateTime: TDateTimeRec;
  Curr: Currency;
  nSize: Integer;
  FieldInfo: TSDFieldInfo;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(InBuf, 0);
  Result := TCS_SMALLINT(FieldInfo.FetchStatus) <> CS_NULLDATA;

  if not Result or IsBlobType(AFieldDesc.FieldType) then
    Exit;

  nSize         := FieldInfo.DataSize;
  InData	:= IncPtr( InBuf, SizeOf(TSDFieldInfo) );
  OutData	:= Buffer;
  	// DateTime fields
  if RequiredCnvtFieldType(AFieldDesc.FieldType) then begin
    if IsDateTimeType(AFieldDesc.FieldType) then begin
      dtDateTime := CnvtDBDateTime2DateTimeRec(AFieldDesc.FieldType, InData, FieldInfo.DataSize);
      HelperMemWriteDateTimeRec(OutData, 0, dtDateTime);
    end else begin
    	// for DECIMAL and NUMERIC datatypes (returns as double(8 bytes),
      //but PSDFieldInfo(InBuf)^.DataSize = 19, it's wrong)
      // for SMALLMONEY returns DataSize = 4 (it's need set to 8 byte)
      if (AFieldDesc.FieldType in [ftFloat, ftCurrency, ftBCD]) and
         (nSize <> NativeDataSize(AFieldDesc.FieldType))
      then
        nSize := NativeDataSize(AFieldDesc.FieldType);
      if AFieldDesc.FieldType = ftBCD then begin
        curr := HelperMemReadDouble( InData, 0 );
        HelperCurrToBCD( curr, OutData, 32, 4 );
      end else
        SafeCopyMem( InData, OutData, nSize );
    end;
  end else begin
    if nSize > BufSize then
      nSize := BufSize;
    SafeCopyMem( InData, OutData, nSize );
    if AFieldDesc.FieldType = ftString then begin
      if nSize = BufSize then
        Dec(nSize);
      HelperMemWriteByte(OutData, nSize, 0);
      if FIsRTrimChar then
        StrRTrim( OutData );
    end;
  end;
end;

// to '10-13-1998 14:28:53:880' = 'mm-dd-yyyy hh:mi:ss:nnn'
function TISybCommand.CnvtDateTimeToSQLVarChar(ADataType: TFieldType; Value: TDateTime): string;
const
  sDateFormat = 'yyyymmdd';
  sTimeFormat = 'hh":"nn":"ss';
var
  Hour, Min, Sec, MSec: Word;
begin
  if ADataType in [ftDateTime, ftDate] then
    Result := FormatDateTime(sDateFormat, Value);	// 'yyyymmdd' format does not depend from 'set dateformat' option
  if ADataType in [ftDateTime, ftTime] then begin
    DecodeTime(Value, Hour, Min, Sec, MSec);
    if (Hour > 0) or (Min > 0) or (Sec > 0) or (MSec > 0) then begin
      if Result <> '' then
        Result := Result + ' ';
      Result := Result + FormatDateTime(sTimeFormat, Value);
  	// add millisecond part
      if MSec > 0 then
        Result := Format('%s:%.3d', [Result, MSec]);
    end;
  end;
  Result := Format('''%s''', [Result]);
end;

function TISybCommand.CnvtDateTimeToSQLDateTime(Value: TDateTime): TCS_DATETIME;
var
  tstamp: TTimeStamp;
begin
	// TDateTime(0,....) = 30.12.1899
  tstamp := DateTimeToTimeStamp(Value);
	// (Days since 12/30/1899) - 2 = Days since Jan 1, 1900
  Result.dtdays := Trunc(Value) - 2;
      	// (Number of milliseconds(100ths of second(1s=1000)) since midnight) *3/10 = 300ths of a second since midnight (1s=300)
  Result.dttime := (tstamp.Time * 3)div 10;
end;

// Converts float value to string (decimal delimiter is decimal point('.') )
//it is used a Delphi function, because Sybase cs_convert works incorrectly with some float value
function TISybCommand.CnvtFloatToSQLVarChar(Value: Double): string;
var
  DecSep: {$IFDEF SD_CLR}string{$ELSE}Char{$ENDIF};
begin
  DecSep := DecimalSeparator;
  try
    DecimalSeparator := '.';
    Result := FloatToStr(Value);
  finally
    DecimalSeparator := DecSep;
  end;
end;

// Converts Blob data to hexadecimal string (for example: '0x012b......')
function TISybCommand.CnvtBlobToSQLHexString(Value: string): string;
const
  HexSym: array[0..15] of Char =
  	('0', '1', '2', '3', '4', '5', '6', '7',
         '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
        );
var
  Len, i: Integer;
  b: Byte;
begin
	// 2*(string length) + Length('0x') + zero
  Len := 2*Length(Value) + 2;
  SetLength(Result, Len);
{$IFDEF SD_CLR}
  for i:=1 to Len do
    Result[i] := #$0;
{$ELSE}
  FillChar( TSDCharPtr(Result)^, Len, #$0 );
{$ENDIF}
  Result[1] := '0';
  Result[2] := 'x';
  for i:=0 to Length(Value)-1 do begin
    b := Ord( Value[i+1] );

    Result[3+2*i]	:= HexSym[b shr 4];
    Result[3+2*i+1]	:= HexSym[b and $0F];
  end;
end;

procedure TISybCommand.InternalQBindParams;
const
  ParamPrefix	= ':';
  SqlNullValue	= 'NULL';
var
  i: Integer;
  sFullParamName, sValue: string;
begin
  FBindStmt := CommandText;

  if not Assigned(Params) then
    Exit;

  for i:=Params.Count-1 downto 0 do begin
    	// set parameter value
    if Params[i].IsNull or
       ( FEmptyStrAsNull and
         (IsBlobType(Params[i].DataType) or (Params[i].DataType = ftString)) and
         (Params[i].AsString = '')
       )
    then
      sValue := SqlNullValue
    else begin
      case Params[i].DataType of
        ftInteger,
        ftSmallint,
        ftWord,
        ftAutoInc:	sValue := Params[i].AsString;
        ftBoolean:
          if Params[i].AsBoolean
          then sValue := '1' else sValue := '0';
        ftBytes, ftVarBytes:
          sValue := CnvtVarBytesToHexString(Params[i].Value);
        ftDate,
        ftDateTime:	sValue := CnvtDateTimeToSQLVarChar(Params[i].DataType, Params[i].AsDateTime);
        ftFloat,
        ftBCD,
        ftCurrency:	sValue := CnvtFloatToSQLVarChar(Params[i].AsFloat);
        ftBlob:	sValue := CnvtBlobToSQLHexString( Params[i].AsString );
      else
        sValue := Params[i].AsString;
        	// exclude zero-terminator from string (and string length), what happens after richedit stores data
        while (Length(sValue) > 0) and (sValue[Length(sValue)] = #0) do
          SetLength(sValue, Length(sValue)-1);

        sValue := Format('''%s''', [RepeatChar('''', sValue)]);
      end;
    end;
	// change a parameter's name on a value of the parameter
    sFullParamName := ParamPrefix + Params[i].Name;
    if not ReplaceString( False, sFullParamName, sValue, FBindStmt ) then begin
    	// if parameter's name is enclosed in double quotation marks
      sFullParamName := Format( '%s%s%s%s', [ParamPrefix, QuoteChar, Params[i].Name, QuoteChar] );;
      ReplaceString( False, sFullParamName, sValue, FBindStmt );
    end;
  end;
end;

procedure TISybCommand.InternalQExecute;
begin
  Connect;

  InternalQBindParams;

  HandleReset( CmdPtr );

  HandleInitLangCmd( CmdPtr, FBindStmt );
  FRowResult := HandleExec( CmdPtr ) = CS_ROW_RESULT;

  FEndResults	:= False;
end;

	// Stored procedure methods
procedure TISybCommand.InitParamList;
	// System table SYSTYPES( USERTYPE, NAME ) (see SQL Server Reference Supplement)
  function SysTypesToFieldType( usertype: Integer ): TFieldType;
  begin
    case usertype of
      1, 2, 18, 24, 25:	// char, varchar, sysname, nchar, nvarchar
        Result := ftString;
      3, 4:		// binary, varbinary
        Result := ftBytes;
      19:		// text
        Result := ftMemo;
      20:		// image
        Result := ftBlob;
      5, 6:		// tinyint, smallint
        Result := ftSmallInt;
      7, 13:		// int, intn
        Result := ftInteger;
      23, 8, 14: 	// real, float, floatn
        Result := ftFloat;
      16:		// bit
        Result := ftBoolean;
      12, 15, 22:	// datetime, datetimn, smalldatetime
        Result := ftDateTime;
      11, 17, 21:	// money, moneyn, smallmoney
        Result := ftCurrency;
      10, 28, 26, 27:	// numeric, numericn, decimal, decimaln
        Result := ftFloat;
    else
      Result := ftUnknown;
    end;
end;

var
  cmd: TISqlCommand;
  sStmt, sName: string;
  DataTyp: Integer;
  ft: TFieldType;
begin
  AddParam( SResultName, ftInteger, ptResult );
	// ASE: number = 1; but for ASA: number = 0
  sStmt := 	'select name, usertype, length, status ' +
		'from dbo.syscolumns ' +
	Format( 'where id = object_id(''%s'') and number in (0, 1)',
        	[ ExtractStoredProcName(CommandText) ]);

  HandleReset( SqlDatabase.CmdPtr );

  cmd := SqlDatabase.CreateSqlCommand;
  try
    cmd.Prepare(sStmt);
    cmd.Execute;
    while cmd.FetchNextRow do begin
      cmd.GetFieldAsString(1, sName);
      cmd.GetFieldAsInt32(2, DataTyp);
      ft := SysTypesToFieldType(DataTyp);
	// ParamType is undefined
      AddParam( sName, ft, ptUnknown );
    end;
  finally
    cmd.Free;
  end;

  HandleReset( SqlDatabase.CmdPtr );
end;

procedure TISybCommand.InternalSpBindParams;
var
  DataPtr: TSDValueBuffer;
  i, DataLen, nOffset: Integer;
  dt: TFieldType;
  datainfo: TCS_DATAFMT;
  ind: TCS_SMALLINT;
  dtval: TCS_DATETIME;
begin
  if not Assigned(Params) then
    Exit;
  if ParamsBuffer = nil then
    AllocParamsBuffer;

  nOffset := 0;

  for i:=0 to Params.Count-1 do
    if Params[i].ParamType = ptUnknown then
      DatabaseErrorFmt(SNoParameterType, [Params[i].Name]);

  for i:=0 to Params.Count-1 do begin
    DataPtr := IncPtr( ParamsBuffer, nOffset );
    if Params[i].IsNull
    then ind := CS_NULLDATA
    else ind := CS_GOODDATA;
    DataLen := NativeParamSize( Params[i] );
    if Params[i].ParamType <> ptResult then begin
      if Params[i].ParamType in [ptInputOutput, ptOutput]
      then datainfo.status := CS_RETURN
      else datainfo.status := CS_INPUTVALUE;

      dt := Params[i].DataType;
      case dt of
        ftString:
          begin
            if DataLen > 0 then begin
              HelperMemWriteString(DataPtr, 0, Params[i].AsString, Length(Params[i].AsString));
              HelperMemWriteByte(DataPtr, Length(Params[i].AsString), 0);
            end;
            if FEmptyStrAsNull and (Params[i].AsString = '') then
              ind := CS_NULLDATA;
          end;
        ftInteger:
          if DataLen > 0 then HelperMemWriteInt32(DataPtr, 0, Params[i].AsInteger);
        ftSmallInt:
          if DataLen > 0 then HelperMemWriteInt16(DataPtr, 0, Params[i].AsSmallInt);
        ftBoolean:
          if DataLen > 0 then
            if Params[i].AsBoolean
            then HelperMemWriteInt16(DataPtr, 0, 1)
            else HelperMemWriteInt16(DataPtr, 0, 0);
        ftDate, ftTime, ftDateTime:
          if DataLen > 0 then begin
            DataLen := SizeOf(TCS_DATETIME);
            dtval := CnvtDateTimeToSQLDateTime( Params[i].AsDateTime );
{$IFDEF SD_CLR}
            Marshal.StructureToPtr(dtval, DataPtr, False);
{$ELSE}
            StrMove( DataPtr, @dtval, DataLen );
{$ENDIF}
          end;
        ftBCD,
        ftCurrency,
        ftFloat:
          if DataLen > 0 then HelperMemWriteDouble(DataPtr, 0, Params[i].AsFloat);
        else
          if not IsSupportedBlobTypes(dt) then
            raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
      end;
{$IFDEF SD_CLR}
      datainfo.name := Params[i].Name;
{$ELSE}
      StrCopy( datainfo.name, TSDCharPtr(Params[i].Name) );
{$ENDIF}
      datainfo.name[Length(Params[i].Name)] := #$0;
      datainfo.namelen	:= CS_NULLTERM;
      datainfo.datatype	:= NativeDataType(dt);
      datainfo.maxlength:= NativeParamSize( Params[i] );
      datainfo.locale	:= nil;

      if dt = ftString then
        Check( ct_param( CmdPtr, datainfo, PCS_VOID(DataPtr), Length(Params[i].AsString){StrLen(DataPtr)}, ind ) )
      else
        Check( ct_param( CmdPtr, datainfo, PCS_VOID(DataPtr), DataLen, ind ) )
    end;
    Inc(nOffset, DataLen);
  end;
end;

procedure TISybCommand.InternalSpExecute;
begin
  FBindStmt := ExtractStoredProcName( CommandText );

  HandleReset( CmdPtr );
  HandleInitRpcCmd( CmdPtr, FBindStmt );

  InternalSpBindParams;

  HandleSend( CmdPtr );

  FEndResults	:= False;

  HandleSpResults( CmdPtr );
end;

procedure TISybCommand.InternalSpGetParams;
var
  BindParamNo, NumCols, outlen: TCS_INT;
  colinfo: TCS_DATAFMT;
  rcd: TCS_RETCODE;
  DataPtr: TSDValueBuffer;
  i, DataLen, nOffset: Integer;
  DataInd: TCS_SMALLINT;
  dtDateTime: TDateTimeRec;
  FieldInfo: TSDFieldInfo;
begin
  if not Assigned(Params) then
    Exit;

  Check( ct_res_info( CmdPtr, CS_NUMDATA, {$IFNDEF SD_CLR}@{$ENDIF}NumCols, CS_UNUSED, outlen ) );

  BindParamNo	:= 1;
  nOffset	:= 0;
  for i:=0 to Params.Count-1 do begin
    DataPtr := IncPtr( ParamsBuffer, SizeOf(TSDFieldInfo) + nOffset );
    DataLen := NativeParamSize( Params[i] );
    if Params[i].ParamType in [ptInputOutput, ptOutput] then begin

      colinfo.datatype := NativeDataType(Params[i].DataType);
      if colinfo.datatype = CS_ILLEGAL_TYPE then
        DatabaseErrorFmt( SNoParameterDataType, [Params[i].Name] );

      colinfo.maxlength	:= DataLen;
      colinfo.format	:= CS_FMT_UNUSED;
      colinfo.scale	:= CS_SRC_VALUE;
      colinfo.precision	:= CS_SRC_VALUE;
      colinfo.count	:= 0;
      colinfo.locale	:= nil;

      if not IsBlobType(Params[i].DataType) then
        Check( ct_bind( CmdPtr, BindParamNo, colinfo, PCS_VOID(DataPtr),
                      IncPtr(DataPtr, -SizeOf(TSDFieldInfo) + GetFieldInfoDataSizeOff),
                      IncPtr(DataPtr, -SizeOf(TSDFieldInfo) + GetFieldInfoFetchStatusOff) ) );

      Inc(BindParamNo);
    end;

    Inc( nOffset, SizeOf(TSDFieldInfo) + NativeParamSize( Params[i] ) );
  end;
  rcd := ct_fetch( CmdPtr, CS_UNUSED, CS_UNUSED, CS_UNUSED, nil );
  	// set fetched parameter data
  if rcd = CS_SUCCEED then begin
    nOffset := 0;
    for i:=0 to Params.Count-1 do begin
      DataPtr := IncPtr( ParamsBuffer, SizeOf(TSDFieldInfo) + nOffset );
      if Params[i].ParamType in [ptInputOutput, ptOutput] then begin
        FieldInfo := GetFieldInfoStruct( IncPtr(DataPtr, -SizeOf(TSDFieldInfo)), 0 );
        DataLen := FieldInfo.DataSize;
        DataInd := FieldInfo.FetchStatus;
        if DataInd = CS_NULLDATA then
          Params[i].Clear
        else begin
          case Params[i].DataType of
            ftString:
              if DataLen > 0 then begin
                HelperMemWriteByte(DataPtr, DataLen, 0);
                Params[i].AsString := HelperPtrToString(DataPtr);
              end;
            ftInteger:
              if DataLen > 0 then Params[i].AsInteger := HelperMemReadInt32(DataPtr, 0);
            ftSmallInt:
              if DataLen > 0 then Params[i].AsSmallInt := HelperMemReadInt16(DataPtr, 0);
            ftBoolean:
              if DataLen > 0 then Params[i].AsBoolean := HelperMemReadInt16(DataPtr, 0) <> 0;
            ftDate, ftTime, ftDateTime:
              if DataLen > 0 then begin
                dtDateTime := CnvtDBDateTime2DateTimeRec( Params[i].DataType, DataPtr, DataLen );
                HelperAssignParamValue(Params[i], dtDateTime);
              end;
            ftCurrency,
            ftFloat:
              begin
                if DataLen > 0 then Params[i].AsFloat := HelperMemReadDouble(DataPtr, 0);
              end;
            else
              raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
          end;
        end;
      end;
      Inc( nOffset, SizeOf(TSDFieldInfo) + NativeParamSize( Params[i] ) );
    end;
  end;
	// fetch until end data in current result set
  while rcd <> CS_END_DATA do
    rcd := ct_fetch( CmdPtr, CS_UNUSED, CS_UNUSED, CS_UNUSED, nil );
end;

procedure TISybCommand.InternalGetStatus;
var
  NumCols, outlen, RpcStatus: TCS_INT;
  ind: TCS_SMALLINT;
  colinfo: TCS_DATAFMT;
  rcd: TCS_RETCODE;
  i: Integer;
  indPtr, outlenPtr, RpcStatusPtr: TSDPtr;
begin
  Check( ct_res_info( CmdPtr, CS_NUMDATA, {$IFNDEF SD_CLR}@{$ENDIF}NumCols, CS_UNUSED, outlen ) );

  if NumCols <= 0 then
    Exit;

  InitDataFmtStruct(colinfo);
  Check( ct_describe( CmdPtr, 1, colinfo ) );

  colinfo.datatype	:= NativeDataType(ftInteger);
  colinfo.format	:= CS_FMT_UNUSED;
  colinfo.scale	        := CS_SRC_VALUE;
  colinfo.precision	:= CS_SRC_VALUE;;
  colinfo.count	        := 0;
  colinfo.locale	:= nil;

{$IFDEF SD_CLR}
  RpcStatusPtr	:= SafeReallocMem(nil, SizeOf(RpcStatusPtr));
  outlenPtr	:= SafeReallocMem(nil, SizeOf(outlenPtr));
  indPtr	:= SafeReallocMem(nil, SizeOf(indPtr));
  try
{$ELSE}
  RpcStatusPtr	:= @RpcStatus;
  outlenPtr	:= @outlen;
  indPtr	:= @ind;
{$ENDIF}
  Check( ct_bind( CmdPtr, 1, colinfo, PCS_VOID(RpcStatusPtr), outlenPtr, indPtr ) );
  rcd := ct_fetch( CmdPtr, CS_UNUSED, CS_UNUSED, CS_UNUSED, nil );

  if rcd = CS_SUCCEED then begin
    for i := 0 to Params.Count-1 do
    	// locate a result parameter by ParamType (Param[i].Name could be changed, for example, at design-time)
      if Params[i].ParamType = ptResult then begin
        ind := HelperMemReadInt16(indPtr, 0);
        outlen := HelperMemReadInt32(outlenPtr, 0);
        if (ind <> CS_NULLDATA) and (outlen > 0) then begin
          RpcStatus := HelperMemReadInt32(RpcStatusPtr, 0);
          Params[i].AsInteger := RpcStatus;
        end else
          Params[i].Clear;
        Break;
      end;
  end;

  while rcd <> CS_END_DATA do
    rcd := ct_fetch( CmdPtr, CS_UNUSED, CS_UNUSED, CS_UNUSED, nil );
{$IFDEF SD_CLR}
  finally
    if Assigned(RpcStatusPtr) then
      SafeReallocMem(RpcStatusPtr, 0);
    if Assigned(outlenPtr) then
      SafeReallocMem(outlenPtr, 0);
    if Assigned(indPtr) then
      SafeReallocMem(indPtr, 0);
  end;
{$ENDIF}
end;

{ return parameters and return status after fetching of all result sets }
procedure TISybCommand.GetOutputParams;
begin
  if FEndResults then
    Exit;
	// fetch all rows for the first result set
  SaveResults;
	// reset(without fetching) the rest result sets
  repeat
    HandleCurReset( CmdPtr )
  until not HandleSpResults( CmdPtr );

  ReleaseDBHandle;
end;

{ If procedure returns multiple result set and one is accessible now,
then returns True and a next result set }
function TISybCommand.NextResultSet: Boolean;
begin
  Result := False;
  if FEndResults then
    Exit;

  HandleCurReset( CmdPtr );
    	// if the next result set exists
  if HandleSpResults( CmdPtr ) then begin

    FNextResults := True;
    Result := True;
    FreeFieldsBuffer;
  end;
end;


initialization
  hCSLibModule := 0;
  hCTLibModule := 0;
  SqlLibRefCount:= 0;
  pCSContext	:= nil;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.




