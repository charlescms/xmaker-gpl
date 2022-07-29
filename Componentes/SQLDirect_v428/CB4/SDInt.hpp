// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDInt.pas' rev: 4.00

#ifndef SDIntHPP
#define SDIntHPP

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

namespace Sdint
{
//-- type declarations -------------------------------------------------------
typedef int Int;

typedef unsigned UInt;

typedef int Long;

typedef unsigned ULong;

typedef short Short;

typedef Word UShort;

typedef float Float;

typedef Byte UChar;

typedef int ISC_LONG;

typedef unsigned UISC_LONG;

typedef System::Comp ISC_INT64;

typedef Word ISC_USHORT;

typedef int ISC_STATUS;

typedef unsigned UISC_STATUS;

typedef void *Void;

typedef char * *PPChar;

typedef short *PSmallInt;

typedef int *PInt;

typedef int *PInteger;

typedef short *PShort;

typedef Word *PUShort;

typedef int *PLong;

typedef unsigned *PULong;

typedef float *PFloat;

typedef Byte *PUChar;

typedef void *PVoid;

typedef double *PDouble;

typedef int *PISC_LONG;

typedef unsigned *PUISC_LONG;

typedef int *PISC_STATUS;

typedef PISC_STATUS *PPISC_STATUS;

typedef unsigned *PUISC_STATUS;

#pragma pack(push, 4)
struct TTimeDateRec
{
	int tm_sec;
	int tm_min;
	int tm_hour;
	int tm_mday;
	int tm_mon;
	int tm_year;
	int tm_wday;
	int tm_yday;
	int tm_isdst;
} ;
#pragma pack(pop)

typedef TTimeDateRec *PTimeDateRec;

#pragma pack(push, 4)
struct TISC_VARYING
{
	short strlen;
	char str[1];
} ;
#pragma pack(pop)

typedef void *TISC_ATT_HANDLE;

typedef void *TISC_BLOB_HANDLE;

typedef void *TISC_DB_HANDLE;

typedef void *TISC_FORM_HANDLE;

typedef void *TISC_REQ_HANDLE;

typedef void *TISC_STMT_HANDLE;

typedef void *TISC_SVC_HANDLE;

typedef void *TISC_TR_HANDLE;

typedef void *TISC_WIN_HANDLE;

typedef void __cdecl (*TISC_CALLBACK)(void * user_arg, char * str);

typedef int ISC_SVC_HANDLE;

typedef void * *PISC_ATT_HANDLE;

typedef void * *PISC_BLOB_HANDLE;

typedef void * *PISC_DB_HANDLE;

typedef void * *PISC_FORM_HANDLE;

typedef void * *PISC_REQ_HANDLE;

typedef void * *PISC_STMT_HANDLE;

typedef void * *PISC_SVC_HANDLE;

typedef void * *PISC_TR_HANDLE;

typedef void * *PISC_WIN_HANDLE;

typedef int TISC_DATE;

typedef unsigned TISC_TIME;

#pragma pack(push, 4)
struct TISC_TIMESTAMP
{
	int timestamp_date;
	unsigned timestamp_time;
} ;
#pragma pack(pop)

typedef int *PISC_DATE;

typedef unsigned *PISC_TIME;

typedef TISC_TIMESTAMP *PISC_TIMESTAMP;

#pragma pack(push, 4)
struct TGDS_QUAD
{
	int gds_quad_high;
	unsigned gds_quad_low;
} ;
#pragma pack(pop)

typedef TGDS_QUAD  TGDS__QUAD;

typedef TGDS_QUAD  TISC_QUAD;

typedef TGDS_QUAD *PGDS_QUAD;

typedef TGDS_QUAD *PGDS__QUAD;

typedef TGDS_QUAD *PISC_QUAD;

#pragma pack(push, 4)
struct TISC_ARRAY_BOUND
{
	short array_bound_lower;
	short array_bound_upper;
} ;
#pragma pack(pop)

typedef TISC_ARRAY_BOUND *PISC_ARRAY_BOUND;

#pragma pack(push, 4)
struct TISC_ARRAY_DESC
{
	Byte array_desc_dtype;
	char array_desc_scale;
	Word array_desc_length;
	char array_desc_field_name[32];
	char array_desc_relation_name[32];
	short array_desc_dimensions;
	short array_desc_flags;
	TISC_ARRAY_BOUND array_desc_bounds[16];
} ;
#pragma pack(pop)

typedef TISC_ARRAY_DESC *PISC_ARRAY_DESC;

#pragma pack(push, 4)
struct TISC_BLOB_DESC
{
	short blob_desc_subtype;
	short blob_desc_charset;
	short blob_desc_segment_size;
	Byte blob_desc_field_name[32];
	Byte blob_desc_relation_name[32];
} ;
#pragma pack(pop)

typedef TISC_BLOB_DESC *PISC_BLOB_DESC;

typedef int __fastcall (*TISC_BLOB_CTL_SOURCE_FUNCTION)(void);

struct TISC_BLOB_CTL;
typedef TISC_BLOB_CTL *PISC_BLOB_CTL;

#pragma pack(push, 4)
struct TISC_BLOB_CTL
{
	TISC_BLOB_CTL_SOURCE_FUNCTION ctl_source;
	TISC_BLOB_CTL *ctl_source_handle;
	short ctl_to_sub_type;
	short ctl_from_sub_type;
	Word ctl_buffer_length;
	Word ctl_segment_length;
	Word ctl_bpb_length;
	char *ctl_bpb;
	Byte *ctl_buffer;
	int ctl_max_segment;
	int ctl_number_segments;
	int ctl_total_length;
	int *ctl_status;
	int ctl_data[8];
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TBSTREAM
{
	void *bstr_blob;
	char *bstr_buffer;
	char *bstr_ptr;
	short bstr_length;
	short bstr_cnt;
	char bstr_mode;
} ;
#pragma pack(pop)

typedef TBSTREAM *PBSTREAM;

#pragma pack(push, 4)
struct TXSQLVAR
{
	short sqltype;
	short sqlscale;
	short sqlsubtype;
	short sqllen;
	char *sqldata;
	short *sqlind;
	short sqlname_length;
	char sqlname[32];
	short relname_length;
	char relname[32];
	short ownname_length;
	char ownname[32];
	short aliasname_length;
	char aliasname[32];
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TXSQLDA
{
	short version;
	char sqldaid[8];
	int sqldabc;
	short sqln;
	short sqld;
	TXSQLVAR sqlvar[1];
} ;
#pragma pack(pop)

typedef TXSQLVAR *PXSQLVAR;

typedef TXSQLDA *PXSQLDA;

#pragma pack(push, 4)
struct TISC_START_TRANS
{
	void * *db_handle;
	Word tpb_length;
	char *tpb_address;
} ;
#pragma pack(pop)

#pragma pack(push, 4)
struct TISC_TEB
{
	void * *db_handle;
	int tpb_length;
	char *tpb_address;
} ;
#pragma pack(pop)

typedef TISC_TEB *PISC_TEB;

typedef TISC_TEB TISC_TEB_ARRAY[1];

typedef TISC_TEB *PISC_TEB_ARRAY;

#pragma pack(push, 4)
struct TUSER_SEC_DATA
{
	short sec_flags;
	int uid;
	int gid;
	int protocol;
	char *server;
	char *user_name;
	char *password;
	char *group_name;
	char *first_name;
	char *middle_name;
	char *last_name;
	char *dba_user_name;
	char *dba_password;
} ;
#pragma pack(pop)

typedef TUSER_SEC_DATA *PUSER_SEC_DATA;

class DELPHICLASS TIntFunctions;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIntFunctions : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	unsigned FLibHandle;
	
public:
	int __stdcall (*isc_attach_database)(PISC_STATUS status_vector, short db_name_length, char * db_name
		, PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer);
	void __stdcall (*isc_blob_default_desc)(PISC_BLOB_DESC desc, char * table_name, char * column_name)
		;
	int __stdcall (*isc_blob_gen_bpb)(PISC_STATUS status_vector, PISC_BLOB_DESC to_desc, PISC_BLOB_DESC 
		from_desc, Word bpb_buffer_length, char * bpb_buffer, PUShort bpb_length);
	int __stdcall (*isc_blob_info)(PISC_STATUS status_vector, void * &blob_handle, short item_list_buffer_length
		, char * item_list_buffer, short result_buffer_length, char * result_buffer);
	int __stdcall (*isc_blob_lookup_desc)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_BLOB_DESC desc, char * global_column_name
		);
	int __stdcall (*isc_blob_set_desc)(PISC_STATUS status_vector, char * table_name, char * column_name
		, short subtype, short charset, short segment_size, PISC_BLOB_DESC desc);
	int __stdcall (*isc_cancel_blob)(PISC_STATUS status_vector, void * &blob_handle);
	int __stdcall (*isc_cancel_events)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		);
	int __stdcall (*isc_close_blob)(PISC_STATUS status_vector, void * &blob_handle);
	int __stdcall (*isc_commit_retaining)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __stdcall (*isc_commit_transaction)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __stdcall (*isc_create_blob)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, void * &blob_handle, PISC_QUAD blob_id);
	int __stdcall (*isc_create_blob2)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, void * &blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_address);
	int __stdcall (*isc_create_database)(PISC_STATUS status_vector, short db_name_length, char * db_name
		, PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer, short parm_7);
	int __stdcall (*isc_database_info)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, short item_list_buffer_length
		, char * item_list_buffer, short result_buffer_length, char * result_buffer);
	void __stdcall (*isc_decode_date)(PISC_QUAD ib_date, TTimeDateRec &tm_date);
	void __stdcall (*isc_decode_sql_date)(PISC_DATE ib_date, TTimeDateRec &tm_date);
	void __stdcall (*isc_decode_sql_time)(PISC_TIME ib_time, TTimeDateRec &tm_date);
	void __stdcall (*isc_decode_timestamp)(PISC_TIMESTAMP ib_timestamp, TTimeDateRec &tm_date);
	int __stdcall (*isc_detach_database)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __stdcall (*isc_drop_database)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __stdcall (*isc_dsql_allocate_statement)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __stdcall (*isc_dsql_alloc_statement2)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __stdcall (*isc_dsql_describe)(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __stdcall (*isc_dsql_describe_bind)(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda);
	int __stdcall (*isc_dsql_execute)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA xsqlda);
	int __stdcall (*isc_dsql_execute2)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda);
	int __stdcall (*isc_dsql_execute_immediate)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __stdcall (*isc_dsql_exec_immed2)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, Word length, char * statement, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda);
	int __stdcall (*isc_dsql_fetch)(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __stdcall (*isc_dsql_finish)(PISC_DB_HANDLE db_handle);
	int __stdcall (*isc_dsql_free_statement)(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		option);
	int __stdcall (*isc_dsql_prepare)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __stdcall (*isc_dsql_set_cursor_name)(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, 
		char * cursor_name, Word type_reserved);
	int __stdcall (*isc_dsql_sql_info)(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, short item_length
		, char * items, short buffer_length, char * buffer);
	void __stdcall (*isc_encode_date)(TTimeDateRec &tm_date, PISC_QUAD ib_date);
	void __stdcall (*isc_encode_sql_date)(TTimeDateRec &tm_date, PISC_DATE ib_date);
	void __stdcall (*isc_encode_sql_time)(TTimeDateRec &tm_date, PISC_TIME ib_time);
	void __stdcall (*isc_encode_timestamp)(TTimeDateRec &tm_date, PISC_TIMESTAMP ib_timestamp);
	void __stdcall (*isc_event_counts)(PISC_STATUS status_vector, short buffer_length, char * event_buffer
		, char * result_buffer);
	int __stdcall (*isc_get_segment)(PISC_STATUS status_vector, void * &blob_handle, Word &actual_seg_length
		, Word seg_buffer_length, char * seg_buffer);
	int __stdcall (*isc_interprete)(char * buffer, PISC_STATUS &status_vector);
	int __stdcall (*isc_open_blob)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, void * &blob_handle, PISC_QUAD blob_id);
	int __stdcall (*isc_open_blob2)(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, void * &blob_handle, const TGDS_QUAD blob_id, short bpb_length, char * bpb_buffer);
	int __stdcall (*isc_prepare_transaction)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __stdcall (*isc_prepare_transaction2)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short 
		msg_length, char * msg);
	void __stdcall (*isc_print_sqlerror)(short sqlcode, PISC_STATUS status_vector);
	int __stdcall (*isc_print_status)(PISC_STATUS status_vector);
	int __stdcall (*isc_put_segment)(PISC_STATUS status_vector, void * &blob_handle, Word seg_buffer_len
		, char * seg_buffer);
	int __stdcall (*isc_rollback_retaining)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __stdcall (*isc_rollback_transaction)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __stdcall (*isc_start_multiple)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, TISC_TEB &teb_vector_address);
	int __cdecl (*isc_start_transaction)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_DB_HANDLE db_handle, int tpb_length, char * tpb_address);
	int __stdcall (*isc_sqlcode)(PISC_STATUS &status_vector);
	void __stdcall (*isc_sql_interprete)(short sql_code, char * buffer, short buffer_length);
	int __stdcall (*isc_transaction_info)(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short 
		item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		);
	int __stdcall (*isc_vax_integer)(char * buffer, short length);
	int __stdcall (*isc_version)(PISC_DB_HANDLE db_handle, TISC_CALLBACK isc_arg2, void * isc_arg3);
	int __stdcall (*isc_add_user)(PISC_STATUS status_vector, TUSER_SEC_DATA &user_sec_data);
	int __stdcall (*isc_delete_user)(PISC_STATUS status_vector, TUSER_SEC_DATA &user_sec_data);
	int __stdcall (*isc_modify_user)(PISC_STATUS status_vector, TUSER_SEC_DATA &user_sec_data);
	virtual void __fastcall SetApiCalls(unsigned ASqlLibModule);
	virtual void __fastcall ClearApiCalls(void);
	bool __fastcall IsAvailFunc(AnsiString AName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TIntFunctions(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TIntFunctions(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS ESDIntError;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION ESDIntError : public Sdcommon::ESDEngineError 
{
	typedef Sdcommon::ESDEngineError inherited;
	
public:
	#pragma option push -w-inl
	/* ESDEngineError.Create */ inline __fastcall ESDIntError(int AErrorCode, int ANativeError, const AnsiString 
		Msg, int AErrorPos) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg, AErrorPos) { }
	#pragma option pop
	#pragma option push -w-inl
	/* ESDEngineError.CreateDefPos */ inline __fastcall virtual ESDIntError(int AErrorCode, int ANativeError
		, const AnsiString Msg) : Sdcommon::ESDEngineError(AErrorCode, ANativeError, Msg) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESDIntError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sdcommon::ESDEngineError(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESDIntError(int Ident, Extended Dummy) : Sdcommon::ESDEngineError(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESDIntError(int Ident, const System::TVarRec * Args, 
		const int Args_Size) : Sdcommon::ESDEngineError(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESDIntError(const AnsiString Msg, int AHelpContext) : 
		Sdcommon::ESDEngineError(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESDIntError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESDIntError(int Ident, int AHelpContext) : Sdcommon::ESDEngineError(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESDIntError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sdcommon::ESDEngineError(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESDIntError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef TMetaClass*ESDIntErrorClass;

#pragma pack(push, 1)
struct TIIntConnInfo
{
	Byte ServerType;
	void * *DBHandle;
	void * *TRHandle;
} ;
#pragma pack(pop)

class DELPHICLASS TICustomIntDatabase;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TICustomIntDatabase : public Sdcommon::TISqlDatabase 
{
	typedef Sdcommon::TISqlDatabase inherited;
	
private:
	void *FHandle;
	AnsiString FDPBBuffer;
	short FDPBVersionLength;
	short FDPBLength;
	char *FTPBBuffer;
	Word FTPBConstLength;
	Word FTPBLength;
	int *FesvPtr;
	bool FIsEnableInts;
	int FSQLDialect;
	bool FTransActive;
	bool FTransRetaining;
	TIntFunctions* __fastcall GetApiCalls(void);
	PISC_DB_HANDLE __fastcall GetDBHandle(void);
	PISC_TR_HANDLE __fastcall GetTRHandle(void);
	
protected:
	TIntFunctions* FApiCalls;
	virtual void __fastcall AllocHandle(bool DBHandles);
	virtual void __fastcall FreeHandle(bool DBHandles);
	void __fastcall Check(int Status);
	bool __fastcall ConstructTPB(void);
	void __fastcall ConstructDPB(AnsiString sUserName, AnsiString sPassword);
	bool __fastcall IsPreservedOnRollback(void);
	virtual void __fastcall FreeSqlLib(void) = 0 ;
	virtual void __fastcall LoadSqlLib(void) = 0 ;
	virtual TMetaClass* __fastcall GetErrorClass(void) = 0 ;
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
	__fastcall virtual TICustomIntDatabase(Classes::TStrings* ADbParams);
	__fastcall virtual ~TICustomIntDatabase(void);
	virtual int __fastcall GetClientVersion(void);
	virtual int __fastcall GetServerVersion(void);
	virtual AnsiString __fastcall GetVersionString(void);
	virtual Sdcommon::TISqlCommand* __fastcall GetSchemaInfo(Sdcommon::TSDSchemaType ASchemaType, AnsiString 
		AObjectName);
	virtual void __fastcall SetTransIsolation(Sdcommon::TISqlTransIsolation Value);
	virtual bool __fastcall SPDescriptionsAvailable(void);
	virtual bool __fastcall TestConnected(void);
	__property TIntFunctions* ApiCalls = {read=GetApiCalls};
	__property PISC_DB_HANDLE DBHandle = {read=GetDBHandle};
	__property PISC_TR_HANDLE TRHandle = {read=GetTRHandle};
	__property bool IsEnableInts = {read=FIsEnableInts, nodefault};
	__property int SQLDialect = {read=FSQLDialect, nodefault};
};

#pragma pack(pop)

typedef int TLongIntArray[1];

typedef int *PLongIntArray;

class DELPHICLASS TICustomIntCommand;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TICustomIntCommand : public Sdcommon::TISqlCommand 
{
	typedef Sdcommon::TISqlCommand inherited;
	
private:
	void * *FPStmtHandle;
	int *FesvPtr;
	TXSQLDA *FOutXSQLDA;
	TXSQLDA *FInXSQLDA;
	int FStmtType;
	int FBaseSelectBufferSize;
	int FBaseBindBufferSize;
	int FPseudoBlobSelBufOffs;
	bool FExecuted;
	Db::TFieldType __fastcall IBFieldDataType(const TXSQLVAR &SqlVar);
	int __fastcall IBReadBlob(PISC_QUAD BlobIDPtr, Sdcommon::TBytes &BlobData);
	int __fastcall IBWriteBlobParam(PISC_QUAD BlobIDPtr, const char * Buffer, int Count);
	void __fastcall IBAllocOutDescs(void);
	void __fastcall IBFreeOutDescs(void);
	void __fastcall IBAllocInDescs(void);
	void __fastcall IBFreeInDescs(void);
	void __fastcall CnvtCurrencyToDBNumeric(System::Currency Curr, TXSQLVAR &SqlVar);
	System::Currency __fastcall CnvtDBNumericToCurrency(const TXSQLVAR &SqlVar, char * InData);
	double __fastcall CnvtDBNumericToFloat(const TXSQLVAR &SqlVar, char * InData);
	Db::TDateTimeRec __fastcall CnvtDBDateTime2DateTimeRec(Db::TFieldType ADataType, char * Buffer, int 
		BufSize);
	AnsiString __fastcall CreateNativeCommand(AnsiString OldStmt);
	void __fastcall Connect(void);
	void __fastcall InternalGetParams(void);
	TIntFunctions* __fastcall GetApiCalls(void);
	bool __fastcall GetIsProcStmt(void);
	int __fastcall GetStmtType(void);
	HIDESBASE TICustomIntDatabase* __fastcall GetSqlDatabase(void);
	
protected:
	void __fastcall Check(int Status);
	virtual int __fastcall CnvtDateTime2DBDateTime(Db::TFieldType ADataType, System::TDateTime Value, char * 
		Buffer, int BufSize);
	bool __fastcall IsPseudoBlob(Sdcommon::TSDFieldDesc* AFieldDesc);
	Db::TFieldType __fastcall ExactNumberDataType(Db::TFieldType FieldType, int Scale);
	virtual Db::TFieldType __fastcall FieldDataType(int ExtDataType);
	virtual Word __fastcall NativeDataSize(Db::TFieldType FieldType);
	virtual int __fastcall NativeDataType(Db::TFieldType FieldType);
	virtual bool __fastcall RequiredCnvtFieldType(Db::TFieldType FieldType);
	virtual void __fastcall DoPrepare(AnsiString Value);
	virtual void __fastcall DoExecDirect(AnsiString Value);
	virtual void __fastcall DoExecute(void);
	virtual void * __fastcall GetHandle(void);
	virtual void __fastcall GetFieldDescs(Sdcommon::TSDFieldDescList* Descs);
	virtual int __fastcall GetFieldsBufferSize(void);
	virtual int __fastcall GetParamsBufferSize(void);
	virtual void __fastcall InitParamList(void);
	virtual void __fastcall BindParamsBuffer(void);
	virtual void __fastcall FreeFieldsBuffer(void);
	virtual void __fastcall SetFieldsBuffer(void);
	__property bool IsProcStmt = {read=GetIsProcStmt, nodefault};
	__property int StmtType = {read=GetStmtType, nodefault};
	
public:
	__fastcall virtual TICustomIntCommand(Sdcommon::TISqlDatabase* ASqlDatabase);
	__fastcall virtual ~TICustomIntCommand(void);
	virtual void __fastcall CloseResultSet(void);
	virtual void __fastcall Disconnect(bool Force);
	virtual void __fastcall InitNewCommand(void);
	virtual int __fastcall GetRowsAffected(void);
	virtual bool __fastcall ResultSetExists(void);
	virtual bool __fastcall FetchNextRow(void);
	virtual bool __fastcall GetCnvtFieldData(Sdcommon::TSDFieldDesc* AFieldDesc, void * Buffer, int BufSize
		);
	virtual void __fastcall GetOutputParams(void);
	virtual int __fastcall ReadBlob(Sdcommon::TSDFieldDesc* AFieldDesc, Sdcommon::TBytes &BlobData);
	__property TIntFunctions* ApiCalls = {read=GetApiCalls};
	__property TICustomIntDatabase* SqlDatabase = {read=GetSqlDatabase};
};

#pragma pack(pop)

class DELPHICLASS TIIntDatabase;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIIntDatabase : public TICustomIntDatabase 
{
	typedef TICustomIntDatabase inherited;
	
protected:
	virtual void __fastcall FreeSqlLib(void);
	virtual void __fastcall LoadSqlLib(void);
	virtual TMetaClass* __fastcall GetErrorClass(void);
	
public:
	virtual Sdcommon::TISqlCommand* __fastcall CreateSqlCommand(void);
public:
	#pragma option push -w-inl
	/* TICustomIntDatabase.Create */ inline __fastcall virtual TIIntDatabase(Classes::TStrings* ADbParams
		) : TICustomIntDatabase(ADbParams) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomIntDatabase.Destroy */ inline __fastcall virtual ~TIIntDatabase(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TIIntCommand;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TIIntCommand : public TICustomIntCommand 
{
	typedef TICustomIntCommand inherited;
	
public:
	#pragma option push -w-inl
	/* TICustomIntCommand.Create */ inline __fastcall virtual TIIntCommand(Sdcommon::TISqlDatabase* ASqlDatabase
		) : TICustomIntCommand(ASqlDatabase) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TICustomIntCommand.Destroy */ inline __fastcall virtual ~TIIntCommand(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const Shortint METADATALEN = 0x20;
static const int isc_arith_except = 0x14000001;
static const int isc_bad_dbkey = 0x14000002;
static const int isc_bad_db_format = 0x14000003;
static const int isc_bad_db_handle = 0x14000004;
static const int isc_bad_dpb_content = 0x14000005;
static const int isc_bad_dpb_form = 0x14000006;
static const int isc_bad_req_handle = 0x14000007;
static const int isc_bad_segstr_handle = 0x14000008;
static const int isc_bad_segstr_id = 0x14000009;
static const int isc_bad_tpb_content = 0x1400000a;
static const int isc_bad_tpb_form = 0x1400000b;
static const int isc_bad_trans_handle = 0x1400000c;
static const int isc_bug_check = 0x1400000d;
static const int isc_convert_error = 0x1400000e;
static const int isc_db_corrupt = 0x1400000f;
static const int isc_deadlock = 0x14000010;
static const int isc_excess_trans = 0x14000011;
static const int isc_from_no_match = 0x14000012;
static const int isc_infinap = 0x14000013;
static const int isc_infona = 0x14000014;
static const int isc_infunk = 0x14000015;
static const int isc_integ_fail = 0x14000016;
static const int isc_invalid_blr = 0x14000017;
static const int isc_io_error = 0x14000018;
static const int isc_lock_conflict = 0x14000019;
static const int isc_metadata_corrupt = 0x1400001a;
static const int isc_not_valid = 0x1400001b;
static const int isc_no_cur_rec = 0x1400001c;
static const int isc_no_dup = 0x1400001d;
static const int isc_no_finish = 0x1400001e;
static const int isc_no_meta_update = 0x1400001f;
static const int isc_no_priv = 0x14000020;
static const int isc_no_recon = 0x14000021;
static const int isc_no_record = 0x14000022;
static const int isc_no_segstr_close = 0x14000023;
static const int isc_obsolete_metadata = 0x14000024;
static const int isc_open_trans = 0x14000025;
static const int isc_port_len = 0x14000026;
static const int isc_read_only_field = 0x14000027;
static const int isc_read_only_rel = 0x14000028;
static const int isc_read_only_trans = 0x14000029;
static const int isc_read_only_view = 0x1400002a;
static const int isc_req_no_trans = 0x1400002b;
static const int isc_req_sync = 0x1400002c;
static const int isc_req_wrong_db = 0x1400002d;
static const int isc_segment = 0x1400002e;
static const int isc_segstr_eof = 0x1400002f;
static const int isc_segstr_no_op = 0x14000030;
static const int isc_segstr_no_read = 0x14000031;
static const int isc_segstr_no_trans = 0x14000032;
static const int isc_segstr_no_write = 0x14000033;
static const int isc_segstr_wrong_db = 0x14000034;
static const int isc_sys_request = 0x14000035;
static const int isc_stream_eof = 0x14000036;
static const int isc_unavailable = 0x14000037;
static const int isc_unres_rel = 0x14000038;
static const int isc_uns_ext = 0x14000039;
static const int isc_wish_list = 0x1400003a;
static const int isc_wrong_ods = 0x1400003b;
static const int isc_wronumarg = 0x1400003c;
static const int isc_imp_exc = 0x1400003d;
static const int isc_random = 0x1400003e;
static const int isc_fatal_conflict = 0x1400003f;
static const int isc_badblk = 0x14000040;
static const int isc_invpoolcl = 0x14000041;
static const int isc_nopoolids = 0x14000042;
static const int isc_relbadblk = 0x14000043;
static const int isc_blktoobig = 0x14000044;
static const int isc_bufexh = 0x14000045;
static const int isc_syntaxerr = 0x14000046;
static const int isc_bufinuse = 0x14000047;
static const int isc_bdbincon = 0x14000048;
static const int isc_reqinuse = 0x14000049;
static const int isc_badodsver = 0x1400004a;
static const int isc_relnotdef = 0x1400004b;
static const int isc_fldnotdef = 0x1400004c;
static const int isc_dirtypage = 0x1400004d;
static const int isc_waifortra = 0x1400004e;
static const int isc_doubleloc = 0x1400004f;
static const int isc_nodnotfnd = 0x14000050;
static const int isc_dupnodfnd = 0x14000051;
static const int isc_locnotmar = 0x14000052;
static const int isc_badpagtyp = 0x14000053;
static const int isc_corrupt = 0x14000054;
static const int isc_badpage = 0x14000055;
static const int isc_badindex = 0x14000056;
static const int isc_dbbnotzer = 0x14000057;
static const int isc_tranotzer = 0x14000058;
static const int isc_trareqmis = 0x14000059;
static const int isc_badhndcnt = 0x1400005a;
static const int isc_wrotpbver = 0x1400005b;
static const int isc_wroblrver = 0x1400005c;
static const int isc_wrodpbver = 0x1400005d;
static const int isc_blobnotsup = 0x1400005e;
static const int isc_badrelation = 0x1400005f;
static const int isc_nodetach = 0x14000060;
static const int isc_notremote = 0x14000061;
static const int isc_trainlim = 0x14000062;
static const int isc_notinlim = 0x14000063;
static const int isc_traoutsta = 0x14000064;
static const int isc_connect_reject = 0x14000065;
static const int isc_dbfile = 0x14000066;
static const int isc_orphan = 0x14000067;
static const int isc_no_lock_mgr = 0x14000068;
static const int isc_ctxinuse = 0x14000069;
static const int isc_ctxnotdef = 0x1400006a;
static const int isc_datnotsup = 0x1400006b;
static const int isc_badmsgnum = 0x1400006c;
static const int isc_badparnum = 0x1400006d;
static const int isc_virmemexh = 0x1400006e;
static const int isc_blocking_signal = 0x1400006f;
static const int isc_lockmanerr = 0x14000070;
static const int isc_journerr = 0x14000071;
static const int isc_keytoobig = 0x14000072;
static const int isc_nullsegkey = 0x14000073;
static const int isc_sqlerr = 0x14000074;
static const int isc_wrodynver = 0x14000075;
static const int isc_funnotdef = 0x14000076;
static const int isc_funmismat = 0x14000077;
static const int isc_bad_msg_vec = 0x14000078;
static const int isc_bad_detach = 0x14000079;
static const int isc_noargacc_read = 0x1400007a;
static const int isc_noargacc_write = 0x1400007b;
static const int isc_read_only = 0x1400007c;
static const int isc_ext_err = 0x1400007d;
static const int isc_non_updatable = 0x1400007e;
static const int isc_no_rollback = 0x1400007f;
static const int isc_bad_sec_info = 0x14000080;
static const int isc_invalid_sec_info = 0x14000081;
static const int isc_misc_interpreted = 0x14000082;
static const int isc_update_conflict = 0x14000083;
static const int isc_unlicensed = 0x14000084;
static const int isc_obj_in_use = 0x14000085;
static const int isc_nofilter = 0x14000086;
static const int isc_shadow_accessed = 0x14000087;
static const int isc_invalid_sdl = 0x14000088;
static const int isc_out_of_bounds = 0x14000089;
static const int isc_invalid_dimension = 0x1400008a;
static const int isc_rec_in_limbo = 0x1400008b;
static const int isc_shadow_missing = 0x1400008c;
static const int isc_cant_validate = 0x1400008d;
static const int isc_cant_start_journal = 0x1400008e;
static const int isc_gennotdef = 0x1400008f;
static const int isc_cant_start_logging = 0x14000090;
static const int isc_bad_segstr_type = 0x14000091;
static const int isc_foreign_key = 0x14000092;
static const int isc_high_minor = 0x14000093;
static const int isc_tra_state = 0x14000094;
static const int isc_trans_invalid = 0x14000095;
static const int isc_buf_invalid = 0x14000096;
static const int isc_indexnotdefined = 0x14000097;
static const int isc_login = 0x14000098;
static const int isc_invalid_bookmark = 0x14000099;
static const int isc_bad_lock_level = 0x1400009a;
static const int isc_relation_lock = 0x1400009b;
static const int isc_record_lock = 0x1400009c;
static const int isc_max_idx = 0x1400009d;
static const int isc_jrn_enable = 0x1400009e;
static const int isc_old_failure = 0x1400009f;
static const int isc_old_in_progress = 0x140000a0;
static const int isc_old_no_space = 0x140000a1;
static const int isc_no_wal_no_jrn = 0x140000a2;
static const int isc_num_old_files = 0x140000a3;
static const int isc_wal_file_open = 0x140000a4;
static const int isc_bad_stmt_handle = 0x140000a5;
static const int isc_wal_failure = 0x140000a6;
static const int isc_walw_err = 0x140000a7;
static const int isc_logh_small = 0x140000a8;
static const int isc_logh_inv_version = 0x140000a9;
static const int isc_logh_open_flag = 0x140000aa;
static const int isc_logh_open_flag2 = 0x140000ab;
static const int isc_logh_diff_dbname = 0x140000ac;
static const int isc_logf_unexpected_eof = 0x140000ad;
static const int isc_logr_incomplete = 0x140000ae;
static const int isc_logr_header_small = 0x140000af;
static const int isc_logb_small = 0x140000b0;
static const int isc_wal_illegal_attach = 0x140000b1;
static const int isc_wal_invalid_wpb = 0x140000b2;
static const int isc_wal_err_rollover = 0x140000b3;
static const int isc_no_wal = 0x140000b4;
static const int isc_drop_wal = 0x140000b5;
static const int isc_stream_not_defined = 0x140000b6;
static const int isc_wal_subsys_error = 0x140000b7;
static const int isc_wal_subsys_corrupt = 0x140000b8;
static const int isc_no_archive = 0x140000b9;
static const int isc_shutinprog = 0x140000ba;
static const int isc_range_in_use = 0x140000bb;
static const int isc_range_not_found = 0x140000bc;
static const int isc_charset_not_found = 0x140000bd;
static const int isc_lock_timeout = 0x140000be;
static const int isc_prcnotdef = 0x140000bf;
static const int isc_prcmismat = 0x140000c0;
static const int isc_wal_bugcheck = 0x140000c1;
static const int isc_wal_cant_expand = 0x140000c2;
static const int isc_codnotdef = 0x140000c3;
static const int isc_xcpnotdef = 0x140000c4;
static const int isc_except = 0x140000c5;
static const int isc_cache_restart = 0x140000c6;
static const int isc_bad_lock_handle = 0x140000c7;
static const int isc_jrn_present = 0x140000c8;
static const int isc_wal_err_rollover2 = 0x140000c9;
static const int isc_wal_err_logwrite = 0x140000ca;
static const int isc_wal_err_jrn_comm = 0x140000cb;
static const int isc_wal_err_expansion = 0x140000cc;
static const int isc_wal_err_setup = 0x140000cd;
static const int isc_wal_err_ww_sync = 0x140000ce;
static const int isc_wal_err_ww_start = 0x140000cf;
static const int isc_shutdown = 0x140000d0;
static const int isc_existing_priv_mod = 0x140000d1;
static const int isc_primary_key_ref = 0x140000d2;
static const int isc_primary_key_notnull = 0x140000d3;
static const int isc_ref_cnstrnt_notfound = 0x140000d4;
static const int isc_foreign_key_notfound = 0x140000d5;
static const int isc_ref_cnstrnt_update = 0x140000d6;
static const int isc_check_cnstrnt_update = 0x140000d7;
static const int isc_check_cnstrnt_del = 0x140000d8;
static const int isc_integ_index_seg_del = 0x140000d9;
static const int isc_integ_index_seg_mod = 0x140000da;
static const int isc_integ_index_del = 0x140000db;
static const int isc_integ_index_mod = 0x140000dc;
static const int isc_check_trig_del = 0x140000dd;
static const int isc_check_trig_update = 0x140000de;
static const int isc_cnstrnt_fld_del = 0x140000df;
static const int isc_cnstrnt_fld_rename = 0x140000e0;
static const int isc_rel_cnstrnt_update = 0x140000e1;
static const int isc_constaint_on_view = 0x140000e2;
static const int isc_invld_cnstrnt_type = 0x140000e3;
static const int isc_primary_key_exists = 0x140000e4;
static const int isc_systrig_update = 0x140000e5;
static const int isc_not_rel_owner = 0x140000e6;
static const int isc_grant_obj_notfound = 0x140000e7;
static const int isc_grant_fld_notfound = 0x140000e8;
static const int isc_grant_nopriv = 0x140000e9;
static const int isc_nonsql_security_rel = 0x140000ea;
static const int isc_nonsql_security_fld = 0x140000eb;
static const int isc_wal_cache_err = 0x140000ec;
static const int isc_shutfail = 0x140000ed;
static const int isc_check_constraint = 0x140000ee;
static const int isc_bad_svc_handle = 0x140000ef;
static const int isc_shutwarn = 0x140000f0;
static const int isc_wrospbver = 0x140000f1;
static const int isc_bad_spb_form = 0x140000f2;
static const int isc_svcnotdef = 0x140000f3;
static const int isc_no_jrn = 0x140000f4;
static const int isc_transliteration_failed = 0x140000f5;
static const int isc_start_cm_for_wal = 0x140000f6;
static const int isc_wal_ovflow_log_required = 0x140000f7;
static const int isc_text_subtype = 0x140000f8;
static const int isc_dsql_error = 0x140000f9;
static const int isc_dsql_command_err = 0x140000fa;
static const int isc_dsql_constant_err = 0x140000fb;
static const int isc_dsql_cursor_err = 0x140000fc;
static const int isc_dsql_datatype_err = 0x140000fd;
static const int isc_dsql_decl_err = 0x140000fe;
static const int isc_dsql_cursor_update_err = 0x140000ff;
static const int isc_dsql_cursor_open_err = 0x14000100;
static const int isc_dsql_cursor_close_err = 0x14000101;
static const int isc_dsql_field_err = 0x14000102;
static const int isc_dsql_internal_err = 0x14000103;
static const int isc_dsql_relation_err = 0x14000104;
static const int isc_dsql_procedure_err = 0x14000105;
static const int isc_dsql_request_err = 0x14000106;
static const int isc_dsql_sqlda_err = 0x14000107;
static const int isc_dsql_var_count_err = 0x14000108;
static const int isc_dsql_stmt_handle = 0x14000109;
static const int isc_dsql_function_err = 0x1400010a;
static const int isc_dsql_blob_err = 0x1400010b;
static const int isc_collation_not_found = 0x1400010c;
static const int isc_collation_not_for_charset = 0x1400010d;
static const int isc_dsql_dup_option = 0x1400010e;
static const int isc_dsql_tran_err = 0x1400010f;
static const int isc_dsql_invalid_array = 0x14000110;
static const int isc_dsql_max_arr_dim_exceeded = 0x14000111;
static const int isc_dsql_arr_range_error = 0x14000112;
static const int isc_dsql_trigger_err = 0x14000113;
static const int isc_dsql_subselect_err = 0x14000114;
static const int isc_dsql_crdb_prepare_err = 0x14000115;
static const int isc_specify_field_err = 0x14000116;
static const int isc_num_field_err = 0x14000117;
static const int isc_col_name_err = 0x14000118;
static const int isc_where_err = 0x14000119;
static const int isc_table_view_err = 0x1400011a;
static const int isc_distinct_err = 0x1400011b;
static const int isc_key_field_count_err = 0x1400011c;
static const int isc_subquery_err = 0x1400011d;
static const int isc_expression_eval_err = 0x1400011e;
static const int isc_node_err = 0x1400011f;
static const int isc_command_end_err = 0x14000120;
static const int isc_index_name = 0x14000121;
static const int isc_exception_name = 0x14000122;
static const int isc_field_name = 0x14000123;
static const int isc_token_err = 0x14000124;
static const int isc_union_err = 0x14000125;
static const int isc_dsql_construct_err = 0x14000126;
static const int isc_field_aggregate_err = 0x14000127;
static const int isc_field_ref_err = 0x14000128;
static const int isc_order_by_err = 0x14000129;
static const int isc_return_mode_err = 0x1400012a;
static const int isc_extern_func_err = 0x1400012b;
static const int isc_alias_conflict_err = 0x1400012c;
static const int isc_procedure_conflict_error = 0x1400012d;
static const int isc_relation_conflict_err = 0x1400012e;
static const int isc_dsql_domain_err = 0x1400012f;
static const int isc_idx_seg_err = 0x14000130;
static const int isc_node_name_err = 0x14000131;
static const int isc_table_name = 0x14000132;
static const int isc_proc_name = 0x14000133;
static const int isc_idx_create_err = 0x14000134;
static const int isc_wal_shadow_err = 0x14000135;
static const int isc_dependency = 0x14000136;
static const int isc_idx_key_err = 0x14000137;
static const int isc_dsql_file_length_err = 0x14000138;
static const int isc_dsql_shadow_number_err = 0x14000139;
static const int isc_dsql_token_unk_err = 0x1400013a;
static const int isc_dsql_no_relation_alias = 0x1400013b;
static const int isc_indexname = 0x1400013c;
static const int isc_no_stream_plan = 0x1400013d;
static const int isc_stream_twice = 0x1400013e;
static const int isc_stream_not_found = 0x1400013f;
static const int isc_collation_requires_text = 0x14000140;
static const int isc_dsql_domain_not_found = 0x14000141;
static const int isc_index_unused = 0x14000142;
static const int isc_dsql_self_join = 0x14000143;
static const int isc_stream_bof = 0x14000144;
static const int isc_stream_crack = 0x14000145;
static const int isc_db_or_file_exists = 0x14000146;
static const int isc_invalid_operator = 0x14000147;
static const int isc_conn_lost = 0x14000148;
static const int isc_bad_checksum = 0x14000149;
static const int isc_page_type_err = 0x1400014a;
static const int isc_ext_readonly_err = 0x1400014b;
static const int isc_sing_select_err = 0x1400014c;
static const int isc_psw_attach = 0x1400014d;
static const int isc_psw_start_trans = 0x1400014e;
static const int isc_invalid_direction = 0x1400014f;
static const int isc_dsql_var_conflict = 0x14000150;
static const int isc_dsql_no_blob_array = 0x14000151;
static const int isc_dsql_base_table = 0x14000152;
static const int isc_duplicate_base_table = 0x14000153;
static const int isc_view_alias = 0x14000154;
static const int isc_index_root_page_full = 0x14000155;
static const int isc_dsql_blob_type_unknown = 0x14000156;
static const int isc_req_max_clones_exceeded = 0x14000157;
static const int isc_dsql_duplicate_spec = 0x14000158;
static const int isc_unique_key_violation = 0x14000159;
static const int isc_srvr_version_too_old = 0x1400015a;
static const int isc_drdb_completed_with_errs = 0x1400015b;
static const int isc_dsql_procedure_use_err = 0x1400015c;
static const int isc_dsql_count_mismatch = 0x1400015d;
static const int isc_blob_idx_err = 0x1400015e;
static const int isc_array_idx_err = 0x1400015f;
static const int isc_key_field_err = 0x14000160;
static const int isc_no_delete = 0x14000161;
static const int isc_del_last_field = 0x14000162;
static const int isc_sort_err = 0x14000163;
static const int isc_sort_mem_err = 0x14000164;
static const int isc_version_err = 0x14000165;
static const int isc_inval_key_posn = 0x14000166;
static const int isc_no_segments_err = 0x14000167;
static const int isc_crrp_data_err = 0x14000168;
static const int isc_rec_size_err = 0x14000169;
static const int isc_dsql_field_ref = 0x1400016a;
static const int isc_req_depth_exceeded = 0x1400016b;
static const int isc_no_field_access = 0x1400016c;
static const int isc_no_dbkey = 0x1400016d;
static const int isc_jrn_format_err = 0x1400016e;
static const int isc_jrn_file_full = 0x1400016f;
static const int isc_dsql_open_cursor_request = 0x14000170;
static const int isc_ib_error = 0x14000171;
static const int isc_cache_redef = 0x14000172;
static const int isc_cache_too_small = 0x14000173;
static const int isc_log_redef = 0x14000174;
static const int isc_log_too_small = 0x14000175;
static const int isc_partition_too_small = 0x14000176;
static const int isc_partition_not_supp = 0x14000177;
static const int isc_log_length_spec = 0x14000178;
static const int isc_precision_err = 0x14000179;
static const int isc_scale_nogt = 0x1400017a;
static const int isc_expec_short = 0x1400017b;
static const int isc_expec_long = 0x1400017c;
static const int isc_expec_ushort = 0x1400017d;
static const int isc_like_escape_invalid = 0x1400017e;
static const int isc_svcnoexe = 0x1400017f;
static const int isc_net_lookup_err = 0x14000180;
static const int isc_service_unknown = 0x14000181;
static const int isc_host_unknown = 0x14000182;
static const int isc_grant_nopriv_on_base = 0x14000183;
static const int isc_dyn_fld_ambiguous = 0x14000184;
static const int isc_dsql_agg_ref_err = 0x14000185;
static const int isc_complex_view = 0x14000186;
static const int isc_unprepared_stmt = 0x14000187;
static const int isc_expec_positive = 0x14000188;
static const int isc_dsql_sqlda_value_err = 0x14000189;
static const int isc_invalid_array_id = 0x1400018a;
static const int isc_extfile_uns_op = 0x1400018b;
static const int isc_svc_in_use = 0x1400018c;
static const int isc_err_stack_limit = 0x1400018d;
static const int isc_invalid_key = 0x1400018e;
static const int isc_net_init_error = 0x1400018f;
static const int isc_loadlib_failure = 0x14000190;
static const int isc_network_error = 0x14000191;
static const int isc_net_connect_err = 0x14000192;
static const int isc_net_connect_listen_err = 0x14000193;
static const int isc_net_event_connect_err = 0x14000194;
static const int isc_net_event_listen_err = 0x14000195;
static const int isc_net_read_err = 0x14000196;
static const int isc_net_write_err = 0x14000197;
static const int isc_integ_index_deactivate = 0x14000198;
static const int isc_integ_deactivate_primary = 0x14000199;
static const int isc_cse_not_supported = 0x1400019a;
static const int isc_tra_must_sweep = 0x1400019b;
static const int isc_unsupported_network_drive = 0x1400019c;
static const int isc_io_create_err = 0x1400019d;
static const int isc_io_open_err = 0x1400019e;
static const int isc_io_close_err = 0x1400019f;
static const int isc_io_read_err = 0x140001a0;
static const int isc_io_write_err = 0x140001a1;
static const int isc_io_delete_err = 0x140001a2;
static const int isc_io_access_err = 0x140001a3;
static const int isc_udf_exception = 0x140001a4;
static const int isc_lost_db_connection = 0x140001a5;
static const int isc_no_write_user_priv = 0x140001a6;
static const int isc_token_too_long = 0x140001a7;
static const int isc_max_att_exceeded = 0x140001a8;
static const int isc_login_same_as_role_name = 0x140001a9;
static const int isc_reftable_requires_pk = 0x140001aa;
static const int isc_usrname_too_long = 0x140001ab;
static const int isc_password_too_long = 0x140001ac;
static const int isc_usrname_required = 0x140001ad;
static const int isc_password_required = 0x140001ae;
static const int isc_bad_protocol = 0x140001af;
static const int isc_dup_usrname_found = 0x140001b0;
static const int isc_usrname_not_found = 0x140001b1;
static const int isc_error_adding_sec_record = 0x140001b2;
static const int isc_error_modifying_sec_record = 0x140001b3;
static const int isc_error_deleting_sec_record = 0x140001b4;
static const int isc_error_updating_sec_db = 0x140001b5;
static const int isc_sort_rec_size_err = 0x140001b6;
static const int isc_bad_default_value = 0x140001b7;
static const int isc_invalid_clause = 0x140001b8;
static const int isc_too_many_handles = 0x140001b9;
static const int isc_optimizer_blk_exc = 0x140001ba;
static const int isc_invalid_string_constant = 0x140001bb;
static const int isc_transitional_date = 0x140001bc;
static const int isc_read_only_database = 0x140001bd;
static const int isc_must_be_dialect_2_and_up = 0x140001be;
static const int isc_blob_filter_exception = 0x140001bf;
static const int isc_exception_access_violation = 0x140001c0;
static const int isc_exception_datatype_missalignment = 0x140001c1;
static const int isc_exception_array_bounds_exceeded = 0x140001c2;
static const int isc_exception_float_denormal_operand = 0x140001c3;
static const int isc_exception_float_divide_by_zero = 0x140001c4;
static const int isc_exception_float_inexact_result = 0x140001c5;
static const int isc_exception_float_invalid_operand = 0x140001c6;
static const int isc_exception_float_overflow = 0x140001c7;
static const int isc_exception_float_stack_check = 0x140001c8;
static const int isc_exception_float_underflow = 0x140001c9;
static const int isc_exception_integer_divide_by_zero = 0x140001ca;
static const int isc_exception_integer_overflow = 0x140001cb;
static const int isc_exception_unknown = 0x140001cc;
static const int isc_exception_stack_overflow = 0x140001cd;
static const int isc_exception_sigsegv = 0x140001ce;
static const int isc_exception_sigill = 0x140001cf;
static const int isc_exception_sigbus = 0x140001d0;
static const int isc_exception_sigfpe = 0x140001d1;
static const int isc_ext_file_delete = 0x140001d2;
static const int isc_ext_file_modify = 0x140001d3;
static const int isc_adm_task_denied = 0x140001d4;
static const int isc_extract_input_mismatch = 0x140001d5;
static const int isc_insufficient_svc_privileges = 0x140001d6;
static const int isc_file_in_use = 0x140001d7;
static const int isc_service_att_err = 0x140001d8;
static const int isc_ddl_not_allowed_by_db_sql_dial = 0x140001d9;
static const int isc_cancelled = 0x140001da;
static const int isc_unexp_spb_form = 0x140001db;
static const int isc_sql_dialect_datatype_unsupport = 0x140001dc;
static const int isc_svcnouser = 0x140001dd;
static const int isc_depend_on_uncommitted_rel = 0x140001de;
static const int isc_svc_name_missing = 0x140001df;
static const int isc_too_many_contexts = 0x140001e0;
static const int isc_datype_notsup = 0x140001e1;
static const int isc_dialect_reset_warning = 0x140001e2;
static const int isc_dialect_not_changed = 0x140001e3;
static const int isc_database_create_failed = 0x140001e4;
static const int isc_inv_dialect_specified = 0x140001e5;
static const int isc_valid_db_dialects = 0x140001e6;
static const int isc_sqlwarn = 0x140001e7;
static const int isc_dtype_renamed = 0x140001e8;
static const int isc_extern_func_dir_error = 0x140001e9;
static const int isc_date_range_exceeded = 0x140001ea;
static const int isc_inv_client_dialect_specified = 0x140001eb;
static const int isc_valid_client_dialects = 0x140001ec;
static const int isc_optimizer_between_err = 0x140001ed;
static const int isc_service_not_supported = 0x140001ee;
static const int isc_gfix_db_name = 0x14030001;
static const int isc_gfix_invalid_sw = 0x14030002;
static const int isc_gfix_incmp_sw = 0x14030004;
static const int isc_gfix_replay_req = 0x14030005;
static const int isc_gfix_pgbuf_req = 0x14030006;
static const int isc_gfix_val_req = 0x14030007;
static const int isc_gfix_pval_req = 0x14030008;
static const int isc_gfix_trn_req = 0x14030009;
static const int isc_gfix_full_req = 0x1403000c;
static const int isc_gfix_usrname_req = 0x1403000d;
static const int isc_gfix_pass_req = 0x1403000e;
static const int isc_gfix_subs_name = 0x1403000f;
static const int isc_gfix_wal_req = 0x14030010;
static const int isc_gfix_sec_req = 0x14030011;
static const int isc_gfix_nval_req = 0x14030012;
static const int isc_gfix_type_shut = 0x14030013;
static const int isc_gfix_retry = 0x14030014;
static const int isc_gfix_retry_db = 0x14030017;
static const int isc_gfix_exceed_max = 0x1403003f;
static const int isc_gfix_corrupt_pool = 0x14030040;
static const int isc_gfix_mem_exhausted = 0x14030041;
static const int isc_gfix_bad_pool = 0x14030042;
static const int isc_gfix_trn_not_valid = 0x14030043;
static const int isc_gfix_unexp_eoi = 0x14030054;
static const int isc_gfix_recon_fail = 0x1403005a;
static const int isc_gfix_trn_unknown = 0x1403006c;
static const int isc_gfix_mode_req = 0x1403006e;
static const int isc_gfix_opt_SQL_dialect = 0x1403006f;
static const int isc_dsql_dbkey_from_non_table = 0x14070002;
static const int isc_dsql_transitional_numeric = 0x14070003;
static const int isc_dsql_dialect_warning_expr = 0x14070004;
static const int isc_sql_db_dialect_dtype_unsupport = 0x14070005;
static const int isc_isc_sql_dialect_conflict_num = 0x14070007;
static const int isc_dsql_warning_number_ambiguous = 0x14070008;
static const int isc_dsql_warning_number_ambiguous1 = 0x14070009;
static const int isc_dsql_warn_precision_ambiguous = 0x1407000a;
static const int isc_dsql_warn_precision_ambiguous1 = 0x1407000b;
static const int isc_dsql_warn_precision_ambiguous2 = 0x1407000c;
static const int isc_dyn_role_does_not_exist = 0x140800bc;
static const int isc_dyn_no_grant_admin_opt = 0x140800bd;
static const int isc_dyn_user_not_role_member = 0x140800be;
static const int isc_dyn_delete_role_failed = 0x140800bf;
static const int isc_dyn_grant_role_to_user = 0x140800c0;
static const int isc_dyn_inv_sql_role_name = 0x140800c1;
static const int isc_dyn_dup_sql_role = 0x140800c2;
static const int isc_dyn_kywd_spec_for_role = 0x140800c3;
static const int isc_dyn_roles_not_supported = 0x140800c4;
static const int isc_dyn_domain_name_exists = 0x140800cc;
static const int isc_dyn_field_name_exists = 0x140800cd;
static const int isc_dyn_dependency_exists = 0x140800ce;
static const int isc_dyn_dtype_invalid = 0x140800cf;
static const int isc_dyn_char_fld_too_small = 0x140800d0;
static const int isc_dyn_invalid_dtype_conversion = 0x140800d1;
static const int isc_dyn_dtype_conv_invalid = 0x140800d2;
static const int isc_gbak_unknown_switch = 0x140c0001;
static const int isc_gbak_page_size_missing = 0x140c0002;
static const int isc_gbak_page_size_toobig = 0x140c0003;
static const int isc_gbak_redir_ouput_missing = 0x140c0004;
static const int isc_gbak_switches_conflict = 0x140c0005;
static const int isc_gbak_unknown_device = 0x140c0006;
static const int isc_gbak_no_protection = 0x140c0007;
static const int isc_gbak_page_size_not_allowed = 0x140c0008;
static const int isc_gbak_multi_source_dest = 0x140c0009;
static const int isc_gbak_filename_missing = 0x140c000a;
static const int isc_gbak_dup_inout_names = 0x140c000b;
static const int isc_gbak_inv_page_size = 0x140c000c;
static const int isc_gbak_db_specified = 0x140c000d;
static const int isc_gbak_db_exists = 0x140c000e;
static const int isc_gbak_unk_device = 0x140c000f;
static const int isc_gbak_blob_info_failed = 0x140c0014;
static const int isc_gbak_unk_blob_item = 0x140c0015;
static const int isc_gbak_get_seg_failed = 0x140c0016;
static const int isc_gbak_close_blob_failed = 0x140c0017;
static const int isc_gbak_open_blob_failed = 0x140c0018;
static const int isc_gbak_put_blr_gen_id_failed = 0x140c0019;
static const int isc_gbak_unk_type = 0x140c001a;
static const int isc_gbak_comp_req_failed = 0x140c001b;
static const int isc_gbak_start_req_failed = 0x140c001c;
static const int isc_gbak_rec_failed = 0x140c001d;
static const int isc_gbak_rel_req_failed = 0x140c001e;
static const int isc_gbak_db_info_failed = 0x140c001f;
static const int isc_gbak_no_db_desc = 0x140c0020;
static const int isc_gbak_db_create_failed = 0x140c0021;
static const int isc_gbak_decomp_len_error = 0x140c0022;
static const int isc_gbak_tbl_missing = 0x140c0023;
static const int isc_gbak_blob_col_missing = 0x140c0024;
static const int isc_gbak_create_blob_failed = 0x140c0025;
static const int isc_gbak_put_seg_failed = 0x140c0026;
static const int isc_gbak_rec_len_exp = 0x140c0027;
static const int isc_gbak_inv_rec_len = 0x140c0028;
static const int isc_gbak_exp_data_type = 0x140c0029;
static const int isc_gbak_gen_id_failed = 0x140c002a;
static const int isc_gbak_unk_rec_type = 0x140c002b;
static const int isc_gbak_inv_bkup_ver = 0x140c002c;
static const int isc_gbak_missing_bkup_desc = 0x140c002d;
static const int isc_gbak_string_trunc = 0x140c002e;
static const int isc_gbak_cant_rest_record = 0x140c002f;
static const int isc_gbak_send_failed = 0x140c0030;
static const int isc_gbak_no_tbl_name = 0x140c0031;
static const int isc_gbak_unexp_eof = 0x140c0032;
static const int isc_gbak_db_format_too_old = 0x140c0033;
static const int isc_gbak_inv_array_dim = 0x140c0034;
static const int isc_gbak_xdr_len_expected = 0x140c0037;
static const int isc_gbak_open_bkup_error = 0x140c0041;
static const int isc_gbak_open_error = 0x140c0042;
static const int isc_gbak_missing_block_fac = 0x140c00b6;
static const int isc_gbak_inv_block_fac = 0x140c00b7;
static const int isc_gbak_block_fac_specified = 0x140c00b8;
static const int isc_gbak_missing_username = 0x140c00bc;
static const int isc_gbak_missing_password = 0x140c00bd;
static const int isc_gbak_missing_skipped_bytes = 0x140c00c8;
static const int isc_gbak_inv_skipped_bytes = 0x140c00c9;
static const int isc_gbak_err_restore_charset = 0x140c00d5;
static const int isc_gbak_err_restore_collation = 0x140c00d7;
static const int isc_gbak_read_error = 0x140c00dc;
static const int isc_gbak_write_error = 0x140c00dd;
static const int isc_gbak_db_in_use = 0x140c00e9;
static const int isc_gbak_sysmemex = 0x140c00ee;
static const int isc_gbak_restore_role_failed = 0x140c00fa;
static const int isc_gbak_role_op_missing = 0x140c00fd;
static const int isc_gbak_page_buffers_missing = 0x140c0102;
static const int isc_gbak_page_buffers_wrong_param = 0x140c0103;
static const int isc_gbak_page_buffers_restore = 0x140c0104;
static const int isc_gbak_inv_size = 0x140c0106;
static const int isc_gbak_file_outof_sequence = 0x140c0107;
static const int isc_gbak_join_file_missing = 0x140c0108;
static const int isc_gbak_stdin_not_supptd = 0x140c0109;
static const int isc_gbak_stdout_not_supptd = 0x140c010a;
static const int isc_gbak_bkup_corrupt = 0x140c010b;
static const int isc_gbak_unk_db_file_spec = 0x140c010c;
static const int isc_gbak_hdr_write_failed = 0x140c010d;
static const int isc_gbak_disk_space_ex = 0x140c010e;
static const int isc_gbak_size_lt_min = 0x140c010f;
static const int isc_gbak_svc_name_missing = 0x140c0111;
static const int isc_gbak_not_ownr = 0x140c0112;
static const int isc_gbak_mode_req = 0x140c0117;
static const int isc_gsec_cant_open_db = 0x1412000f;
static const int isc_gsec_switches_error = 0x14120010;
static const int isc_gsec_no_op_spec = 0x14120011;
static const int isc_gsec_no_usr_name = 0x14120012;
static const int isc_gsec_err_add = 0x14120013;
static const int isc_gsec_err_modify = 0x14120014;
static const int isc_gsec_err_find_mod = 0x14120015;
static const int isc_gsec_err_rec_not_found = 0x14120016;
static const int isc_gsec_err_delete = 0x14120017;
static const int isc_gsec_err_find_del = 0x14120018;
static const int isc_gsec_err_find_disp = 0x1412001c;
static const int isc_gsec_inv_param = 0x1412001d;
static const int isc_gsec_op_specified = 0x1412001e;
static const int isc_gsec_pw_specified = 0x1412001f;
static const int isc_gsec_uid_specified = 0x14120020;
static const int isc_gsec_gid_specified = 0x14120021;
static const int isc_gsec_proj_specified = 0x14120022;
static const int isc_gsec_org_specified = 0x14120023;
static const int isc_gsec_fname_specified = 0x14120024;
static const int isc_gsec_mname_specified = 0x14120025;
static const int isc_gsec_lname_specified = 0x14120026;
static const int isc_gsec_inv_switch = 0x14120028;
static const int isc_gsec_amb_switch = 0x14120029;
static const int isc_gsec_no_op_specified = 0x1412002a;
static const int isc_gsec_params_not_allowed = 0x1412002b;
static const int isc_gsec_incompat_switch = 0x1412002c;
static const int isc_gsec_inv_username = 0x1412004c;
static const int isc_gsec_inv_pw_length = 0x1412004d;
static const int isc_gsec_db_specified = 0x1412004e;
static const int isc_gsec_db_admin_specified = 0x1412004f;
static const int isc_gsec_db_admin_pw_specified = 0x14120050;
static const int isc_gsec_sql_role_specified = 0x14120051;
static const int isc_license_no_file = 0x14130000;
static const int isc_license_op_specified = 0x14130013;
static const int isc_license_op_missing = 0x14130014;
static const int isc_license_inv_switch = 0x14130015;
static const int isc_license_inv_switch_combo = 0x14130016;
static const int isc_license_inv_op_combo = 0x14130017;
static const int isc_license_amb_switch = 0x14130018;
static const int isc_license_inv_parameter = 0x14130019;
static const int isc_license_param_specified = 0x1413001a;
static const int isc_license_param_req = 0x1413001b;
static const int isc_license_syntx_error = 0x1413001c;
static const int isc_license_dup_id = 0x1413001e;
static const int isc_license_inv_id_key = 0x1413001f;
static const int isc_license_err_remove = 0x14130020;
static const int isc_license_err_update = 0x14130021;
static const int isc_license_err_convert = 0x14130022;
static const int isc_license_err_unk = 0x14130023;
static const int isc_license_svc_err_add = 0x14130024;
static const int isc_license_svc_err_remove = 0x14130025;
static const int isc_license_eval_exists = 0x1413003b;
static const int isc_gstat_unknown_switch = 0x14150001;
static const int isc_gstat_retry = 0x14150002;
static const int isc_gstat_wrong_ods = 0x14150003;
static const int isc_gstat_unexpected_eof = 0x14150004;
static const int isc_gstat_open_err = 0x1415001d;
static const int isc_gstat_read_err = 0x1415001e;
static const int isc_gstat_sysmemex = 0x1415001f;
static const Word isc_err_max = 0x2b1;
static const Shortint ISC_TRUE = 0x1;
static const Shortint ISC_FALSE = 0x0;
static const Shortint DSQL_close = 0x1;
static const Shortint DSQL_drop = 0x2;
static const Shortint SQLDA_VERSION1 = 0x1;
static const Shortint SQLDA_VERSION2 = 0x2;
static const Shortint SQL_DIALECT_V5 = 0x1;
static const Shortint SQL_DIALECT_V6_TRANSITION = 0x2;
static const Shortint SQL_DIALECT_V6 = 0x3;
static const Shortint SQL_DIALECT_CURRENT = 0x3;
static const Word ISC_SECONDS_PRECISION = 0x2710;
static const Shortint ISC_SECONDS_PRECISION_SCALE = 0xfffffffc;
static const Shortint sec_uid_spec = 0x1;
static const Shortint sec_gid_spec = 0x2;
static const Shortint sec_server_spec = 0x4;
static const Shortint sec_password_spec = 0x8;
static const Shortint sec_group_name_spec = 0x10;
static const Shortint sec_first_name_spec = 0x20;
static const Shortint sec_middle_name_spec = 0x40;
static const Byte sec_last_name_spec = 0x80;
static const Word sec_dba_user_name_spec = 0x100;
static const Word sec_dba_password_spec = 0x200;
static const Shortint sec_protocol_tcpip = 0x1;
static const Shortint sec_protocol_netbeui = 0x2;
static const Shortint sec_protocol_spx = 0x3;
static const Shortint sec_protocol_local = 0x4;
static const Shortint isc_blob_filter_open = 0x0;
static const Shortint isc_blob_filter_get_segment = 0x1;
static const Shortint isc_blob_filter_close = 0x2;
static const Shortint isc_blob_filter_create = 0x3;
static const Shortint isc_blob_filter_put_segment = 0x4;
static const Shortint isc_blob_filter_alloc = 0x5;
static const Shortint isc_blob_filter_free = 0x6;
static const Shortint isc_blob_filter_seek = 0x7;
static const Shortint blr_text = 0xe;
static const Shortint blr_text2 = 0xf;
static const Shortint blr_short = 0x7;
static const Shortint blr_long = 0x8;
static const Shortint blr_quad = 0x9;
static const Shortint blr_int64 = 0x10;
static const Shortint blr_float = 0xa;
static const Shortint blr_double = 0x1b;
static const Shortint blr_d_float = 0xb;
static const Shortint blr_timestamp = 0x23;
static const Shortint blr_varying = 0x25;
static const Shortint blr_varying2 = 0x26;
static const Word blr_blob = 0x105;
static const Shortint blr_cstring = 0x28;
static const Shortint blr_cstring2 = 0x29;
static const Shortint blr_blob_id = 0x2d;
static const Shortint blr_sql_date = 0xc;
static const Shortint blr_sql_time = 0xd;
static const Shortint blr_date = 0x23;
static const Shortint blr_inner = 0x0;
static const Shortint blr_left = 0x1;
static const Shortint blr_right = 0x2;
static const Shortint blr_full = 0x3;
static const Shortint blr_gds_code = 0x0;
static const Shortint blr_sql_code = 0x1;
static const Shortint blr_exception = 0x2;
static const Shortint blr_trigger_code = 0x3;
static const Shortint blr_default_code = 0x4;
static const Shortint blr_version4 = 0x4;
static const Shortint blr_version5 = 0x5;
static const Shortint blr_eoc = 0x4c;
static const Shortint blr_end = 0xffffffff;
static const Shortint blr_assignment = 0x1;
static const Shortint blr_begin = 0x2;
static const Shortint blr_dcl_variable = 0x3;
static const Shortint blr_message = 0x4;
static const Shortint blr_erase = 0x5;
static const Shortint blr_fetch = 0x6;
static const Shortint blr_for = 0x7;
static const Shortint blr_if = 0x8;
static const Shortint blr_loop = 0x9;
static const Shortint blr_modify = 0xa;
static const Shortint blr_handler = 0xb;
static const Shortint blr_receive = 0xc;
static const Shortint blr_select = 0xd;
static const Shortint blr_send = 0xe;
static const Shortint blr_store = 0xf;
static const Shortint blr_label = 0x11;
static const Shortint blr_leave = 0x12;
static const Shortint blr_store2 = 0x13;
static const Shortint blr_post = 0x14;
static const Shortint blr_literal = 0x15;
static const Shortint blr_dbkey = 0x16;
static const Shortint blr_field = 0x17;
static const Shortint blr_fid = 0x18;
static const Shortint blr_parameter = 0x19;
static const Shortint blr_variable = 0x1a;
static const Shortint blr_average = 0x1b;
static const Shortint blr_count = 0x1c;
static const Shortint blr_maximum = 0x1d;
static const Shortint blr_minimum = 0x1e;
static const Shortint blr_total = 0x1f;
static const Shortint blr_add = 0x22;
static const Shortint blr_subtract = 0x23;
static const Shortint blr_multiply = 0x24;
static const Shortint blr_divide = 0x25;
static const Shortint blr_negate = 0x26;
static const Shortint blr_concatenate = 0x27;
static const Shortint blr_substring = 0x28;
static const Shortint blr_parameter2 = 0x29;
static const Shortint blr_from = 0x2a;
static const Shortint blr_via = 0x2b;
static const Shortint blr_user_name = 0x2c;
static const Shortint blr_null = 0x2d;
static const Shortint blr_eql = 0x2f;
static const Shortint blr_neq = 0x30;
static const Shortint blr_gtr = 0x31;
static const Shortint blr_geq = 0x32;
static const Shortint blr_lss = 0x33;
static const Shortint blr_leq = 0x34;
static const Shortint blr_containing = 0x35;
static const Shortint blr_matching = 0x36;
static const Shortint blr_starting = 0x37;
static const Shortint blr_between = 0x38;
static const Shortint blr_or = 0x39;
static const Shortint blr_and = 0x3a;
static const Shortint blr_not = 0x3b;
static const Shortint blr_any = 0x3c;
static const Shortint blr_missing = 0x3d;
static const Shortint blr_unique = 0x3e;
static const Shortint blr_like = 0x3f;
static const Shortint blr_stream = 0x41;
static const Shortint blr_set_index = 0x42;
static const Shortint blr_rse = 0x43;
static const Shortint blr_first = 0x44;
static const Shortint blr_project = 0x45;
static const Shortint blr_sort = 0x46;
static const Shortint blr_boolean = 0x47;
static const Shortint blr_ascending = 0x48;
static const Shortint blr_descending = 0x49;
static const Shortint blr_relation = 0x4a;
static const Shortint blr_rid = 0x4b;
static const Shortint blr_union = 0x4c;
static const Shortint blr_map = 0x4d;
static const Shortint blr_group_by = 0x4e;
static const Shortint blr_aggregate = 0x4f;
static const Shortint blr_join_type = 0x50;
static const Shortint blr_agg_count = 0x53;
static const Shortint blr_agg_max = 0x54;
static const Shortint blr_agg_min = 0x55;
static const Shortint blr_agg_total = 0x56;
static const Shortint blr_agg_average = 0x57;
static const Shortint blr_parameter3 = 0x58;
static const Shortint blr_run_count = 0x76;
static const Shortint blr_run_max = 0x59;
static const Shortint blr_run_min = 0x5a;
static const Shortint blr_run_total = 0x5b;
static const Shortint blr_run_average = 0x5c;
static const Shortint blr_agg_count2 = 0x5d;
static const Shortint blr_agg_count_distinct = 0x5e;
static const Shortint blr_agg_total_distinct = 0x5f;
static const Shortint blr_agg_average_distinct = 0x60;
static const Shortint blr_function = 0x64;
static const Shortint blr_gen_id = 0x65;
static const Shortint blr_prot_mask = 0x66;
static const Shortint blr_upcase = 0x67;
static const Shortint blr_lock_state = 0x68;
static const Shortint blr_value_if = 0x69;
static const Shortint blr_matching2 = 0x6a;
static const Shortint blr_index = 0x6b;
static const Shortint blr_ansi_like = 0x6c;
static const Shortint blr_bookmark = 0x6d;
static const Shortint blr_crack = 0x6e;
static const Shortint blr_force_crack = 0x6f;
static const Shortint blr_seek = 0x70;
static const Shortint blr_find = 0x71;
static const Shortint blr_continue = 0x0;
static const Shortint blr_forward = 0x1;
static const Shortint blr_backward = 0x2;
static const Shortint blr_bof_forward = 0x3;
static const Shortint blr_eof_backward = 0x4;
static const Shortint blr_lock_relation = 0x72;
static const Shortint blr_lock_record = 0x73;
static const Shortint blr_set_bookmark = 0x74;
static const Shortint blr_get_bookmark = 0x75;
static const Shortint blr_rs_stream = 0x77;
static const Shortint blr_exec_proc = 0x78;
static const Shortint blr_begin_range = 0x79;
static const Shortint blr_end_range = 0x7a;
static const Shortint blr_delete_range = 0x7b;
static const Shortint blr_procedure = 0x7c;
static const Shortint blr_pid = 0x7d;
static const Shortint blr_exec_pid = 0x7e;
static const Shortint blr_singular = 0x7f;
static const Byte blr_abort = 0x80;
static const Byte blr_block = 0x81;
static const Byte blr_error_handler = 0x82;
static const Byte blr_cast = 0x83;
static const Byte blr_release_lock = 0x84;
static const Byte blr_release_locks = 0x85;
static const Byte blr_start_savepoint = 0x86;
static const Byte blr_end_savepoint = 0x87;
static const Byte blr_find_dbkey = 0x88;
static const Byte blr_range_relation = 0x89;
static const Byte blr_delete_ranges = 0x8a;
static const Byte blr_plan = 0x8b;
static const Byte blr_merge = 0x8c;
static const Byte blr_join = 0x8d;
static const Byte blr_sequential = 0x8e;
static const Byte blr_navigational = 0x8f;
static const Byte blr_indices = 0x90;
static const Byte blr_retrieve = 0x91;
static const Byte blr_relation2 = 0x92;
static const Byte blr_rid2 = 0x93;
static const Byte blr_reset_stream = 0x94;
static const Byte blr_release_bookmark = 0x95;
static const Byte blr_set_generator = 0x96;
static const Byte blr_ansi_any = 0x97;
static const Byte blr_exists = 0x98;
static const Byte blr_cardinality = 0x99;
static const Byte blr_record_version = 0x9a;
static const Byte blr_stall = 0x9b;
static const Byte blr_seek_no_warn = 0x9c;
static const Byte blr_find_dbkey_version = 0x9d;
static const Byte blr_ansi_all = 0x9e;
static const Byte blr_extract = 0x9f;
static const Shortint blr_extract_year = 0x0;
static const Shortint blr_extract_month = 0x1;
static const Shortint blr_extract_day = 0x2;
static const Shortint blr_extract_hour = 0x3;
static const Shortint blr_extract_minute = 0x4;
static const Shortint blr_extract_second = 0x5;
static const Shortint blr_extract_weekday = 0x6;
static const Shortint blr_extract_yearday = 0x7;
static const Byte blr_current_date = 0xa0;
static const Byte blr_current_timestamp = 0xa1;
static const Byte blr_current_time = 0xa2;
static const Byte blr_add2 = 0xa3;
static const Byte blr_subtract2 = 0xa4;
static const Byte blr_multiply2 = 0xa5;
static const Byte blr_divide2 = 0xa6;
static const Byte blr_agg_total2 = 0xa7;
static const Byte blr_agg_total_distinct2 = 0xa8;
static const Byte blr_agg_average2 = 0xa9;
static const Byte blr_agg_average_distinct2 = 0xaa;
static const Byte blr_average2 = 0xab;
static const Byte blr_gen_id2 = 0xac;
static const Byte blr_set_generator2 = 0xad;
static const Shortint isc_dpb_version1 = 0x1;
static const Shortint isc_dpb_cdd_pathname = 0x1;
static const Shortint isc_dpb_allocation = 0x2;
static const Shortint isc_dpb_journal = 0x3;
static const Shortint isc_dpb_page_size = 0x4;
static const Shortint isc_dpb_num_buffers = 0x5;
static const Shortint isc_dpb_buffer_length = 0x6;
static const Shortint isc_dpb_debug = 0x7;
static const Shortint isc_dpb_garbage_collect = 0x8;
static const Shortint isc_dpb_verify = 0x9;
static const Shortint isc_dpb_sweep = 0xa;
static const Shortint isc_dpb_enable_journal = 0xb;
static const Shortint isc_dpb_disable_journal = 0xc;
static const Shortint isc_dpb_dbkey_scope = 0xd;
static const Shortint isc_dpb_number_of_users = 0xe;
static const Shortint isc_dpb_trace = 0xf;
static const Shortint isc_dpb_no_garbage_collect = 0x10;
static const Shortint isc_dpb_damaged = 0x11;
static const Shortint isc_dpb_license = 0x12;
static const Shortint isc_dpb_sys_user_name = 0x13;
static const Shortint isc_dpb_encrypt_key = 0x14;
static const Shortint isc_dpb_activate_shadow = 0x15;
static const Shortint isc_dpb_sweep_interval = 0x16;
static const Shortint isc_dpb_delete_shadow = 0x17;
static const Shortint isc_dpb_force_write = 0x18;
static const Shortint isc_dpb_begin_log = 0x19;
static const Shortint isc_dpb_quit_log = 0x1a;
static const Shortint isc_dpb_no_reserve = 0x1b;
static const Shortint isc_dpb_user_name = 0x1c;
static const Shortint isc_dpb_password = 0x1d;
static const Shortint isc_dpb_password_enc = 0x1e;
static const Shortint isc_dpb_sys_user_name_enc = 0x1f;
static const Shortint isc_dpb_interp = 0x20;
static const Shortint isc_dpb_online_dump = 0x21;
static const Shortint isc_dpb_old_file_size = 0x22;
static const Shortint isc_dpb_old_num_files = 0x23;
static const Shortint isc_dpb_old_file = 0x24;
static const Shortint isc_dpb_old_start_page = 0x25;
static const Shortint isc_dpb_old_start_seqno = 0x26;
static const Shortint isc_dpb_old_start_file = 0x27;
static const Shortint isc_dpb_drop_walfile = 0x28;
static const Shortint isc_dpb_old_dump_id = 0x29;
static const Shortint isc_dpb_wal_backup_dir = 0x2a;
static const Shortint isc_dpb_wal_chkptlen = 0x2b;
static const Shortint isc_dpb_wal_numbufs = 0x2c;
static const Shortint isc_dpb_wal_bufsize = 0x2d;
static const Shortint isc_dpb_wal_grp_cmt_wait = 0x2e;
static const Shortint isc_dpb_lc_messages = 0x2f;
static const Shortint isc_dpb_lc_ctype = 0x30;
static const Shortint isc_dpb_cache_manager = 0x31;
static const Shortint isc_dpb_shutdown = 0x32;
static const Shortint isc_dpb_online = 0x33;
static const Shortint isc_dpb_shutdown_delay = 0x34;
static const Shortint isc_dpb_reserved = 0x35;
static const Shortint isc_dpb_overwrite = 0x36;
static const Shortint isc_dpb_sec_attach = 0x37;
static const Shortint isc_dpb_disable_wal = 0x38;
static const Shortint isc_dpb_connect_timeout = 0x39;
static const Shortint isc_dpb_dummy_packet_interval = 0x3a;
static const Shortint isc_dpb_gbak_attach = 0x3b;
static const Shortint isc_dpb_sql_role_name = 0x3c;
static const Shortint isc_dpb_set_page_buffers = 0x3d;
static const Shortint isc_dpb_working_directory = 0x3e;
static const Shortint isc_dpb_SQL_dialect = 0x3f;
static const Shortint isc_dpb_set_db_readonly = 0x40;
static const Shortint isc_dpb_set_db_SQL_dialect = 0x41;
static const Shortint isc_dpb_gfix_attach = 0x42;
static const Shortint isc_dpb_gstat_attach = 0x43;
static const Shortint isc_dpb_last_dpb_constant = 0x43;
static const Shortint isc_dpb_pages = 0x1;
static const Shortint isc_dpb_records = 0x2;
static const Shortint isc_dpb_indices = 0x4;
static const Shortint isc_dpb_transactions = 0x8;
static const Shortint isc_dpb_no_update = 0x10;
static const Shortint isc_dpb_repair = 0x20;
static const Shortint isc_dpb_ignore = 0x40;
static const Shortint isc_dpb_shut_cache = 0x1;
static const Shortint isc_dpb_shut_attachment = 0x2;
static const Shortint isc_dpb_shut_transaction = 0x4;
static const Shortint isc_dpb_shut_force = 0x8;
static const Shortint RDB_system = 0x1;
static const Shortint RDB_id_assigned = 0x2;
static const Shortint isc_tpb_version1 = 0x1;
static const Shortint isc_tpb_version3 = 0x3;
static const Shortint isc_tpb_consistency = 0x1;
static const Shortint isc_tpb_concurrency = 0x2;
static const Shortint isc_tpb_shared = 0x3;
static const Shortint isc_tpb_protected = 0x4;
static const Shortint isc_tpb_exclusive = 0x5;
static const Shortint isc_tpb_wait = 0x6;
static const Shortint isc_tpb_nowait = 0x7;
static const Shortint isc_tpb_read = 0x8;
static const Shortint isc_tpb_write = 0x9;
static const Shortint isc_tpb_lock_read = 0xa;
static const Shortint isc_tpb_lock_write = 0xb;
static const Shortint isc_tpb_verb_time = 0xc;
static const Shortint isc_tpb_commit_time = 0xd;
static const Shortint isc_tpb_ignore_limbo = 0xe;
static const Shortint isc_tpb_read_committed = 0xf;
static const Shortint isc_tpb_autocommit = 0x10;
static const Shortint isc_tpb_rec_version = 0x11;
static const Shortint isc_tpb_no_rec_version = 0x12;
static const Shortint isc_tpb_restart_requests = 0x13;
static const Shortint isc_tpb_no_auto_undo = 0x14;
static const Shortint isc_tpb_last_tpb_constant = 0x14;
static const Shortint isc_bpb_version1 = 0x1;
static const Shortint isc_bpb_source_type = 0x1;
static const Shortint isc_bpb_target_type = 0x2;
static const Shortint isc_bpb_type = 0x3;
static const Shortint isc_bpb_source_interp = 0x4;
static const Shortint isc_bpb_target_interp = 0x5;
static const Shortint isc_bpb_filter_parameter = 0x6;
static const Shortint isc_bpb_type_segmented = 0x0;
static const Shortint isc_bpb_type_stream = 0x1;
static const Shortint isc_spb_version1 = 0x1;
static const Shortint isc_spb_current_version = 0x2;
static const Shortint isc_spb_version = 0x2;
static const Shortint isc_spb_user_name = 0x1;
static const Shortint isc_spb_sys_user_name = 0x2;
static const Shortint isc_spb_sys_user_name_enc = 0x3;
static const Shortint isc_spb_password = 0x4;
static const Shortint isc_spb_password_enc = 0x5;
static const Shortint isc_spb_command_line = 0x6;
static const Shortint isc_spb_dbname = 0x7;
static const Shortint isc_spb_verbose = 0x8;
static const Shortint isc_spb_options = 0x9;
static const Shortint isc_spb_connect_timeout = 0xa;
static const Shortint isc_spb_dummy_packet_interval = 0xb;
static const Shortint isc_spb_sql_role_name = 0xc;
static const Shortint isc_spb_last_spb_constant = 0xc;
static const Shortint isc_spb_user_name_mapped_to_server = 0x1c;
static const Shortint isc_spb_sys_user_name_mapped_to_server = 0x13;
static const Shortint isc_spb_sys_user_name_enc_mapped_to_server = 0x1f;
static const Shortint isc_spb_password_mapped_to_server = 0x1d;
static const Shortint isc_spb_password_enc_mapped_to_server = 0x1e;
static const Shortint isc_spb_command_line_mapped_to_server = 0x69;
static const Shortint isc_spb_dbname_mapped_to_server = 0x6a;
static const Shortint isc_spb_verbose_mapped_to_server = 0x6b;
static const Shortint isc_spb_options_mapped_to_server = 0x6c;
static const Shortint isc_spb_connect_timeout_mapped_to_server = 0x39;
static const Shortint isc_spb_dummy_packet_interval_mapped_to_server = 0x3a;
static const Shortint isc_spb_sql_role_name_mapped_to_server = 0x3c;
static const Shortint isc_info_end = 0x1;
static const Shortint isc_info_truncated = 0x2;
static const Shortint isc_info_error = 0x3;
static const Shortint isc_info_data_not_ready = 0x4;
static const Shortint isc_info_flag_end = 0x7f;
static const Shortint isc_info_db_id = 0x4;
static const Shortint isc_info_reads = 0x5;
static const Shortint isc_info_writes = 0x6;
static const Shortint isc_info_fetches = 0x7;
static const Shortint isc_info_marks = 0x8;
static const Shortint isc_info_implementation = 0xb;
static const Shortint isc_info_version = 0xc;
static const Shortint isc_info_base_level = 0xd;
static const Shortint isc_info_page_size = 0xe;
static const Shortint isc_info_num_buffers = 0xf;
static const Shortint isc_info_limbo = 0x10;
static const Shortint isc_info_current_memory = 0x11;
static const Shortint isc_info_max_memory = 0x12;
static const Shortint isc_info_window_turns = 0x13;
static const Shortint isc_info_license = 0x14;
static const Shortint isc_info_allocation = 0x15;
static const Shortint isc_info_attachment_id = 0x16;
static const Shortint isc_info_read_seq_count = 0x17;
static const Shortint isc_info_read_idx_count = 0x18;
static const Shortint isc_info_insert_count = 0x19;
static const Shortint isc_info_update_count = 0x1a;
static const Shortint isc_info_delete_count = 0x1b;
static const Shortint isc_info_backout_count = 0x1c;
static const Shortint isc_info_purge_count = 0x1d;
static const Shortint isc_info_expunge_count = 0x1e;
static const Shortint isc_info_sweep_interval = 0x1f;
static const Shortint isc_info_ods_version = 0x20;
static const Shortint isc_info_ods_minor_version = 0x21;
static const Shortint isc_info_no_reserve = 0x22;
static const Shortint isc_info_logfile = 0x23;
static const Shortint isc_info_cur_logfile_name = 0x24;
static const Shortint isc_info_cur_log_part_offset = 0x25;
static const Shortint isc_info_num_wal_buffers = 0x26;
static const Shortint isc_info_wal_buffer_size = 0x27;
static const Shortint isc_info_wal_ckpt_length = 0x28;
static const Shortint isc_info_wal_cur_ckpt_interval = 0x29;
static const Shortint isc_info_wal_prv_ckpt_fname = 0x2a;
static const Shortint isc_info_wal_prv_ckpt_poffset = 0x2b;
static const Shortint isc_info_wal_recv_ckpt_fname = 0x2c;
static const Shortint isc_info_wal_recv_ckpt_poffset = 0x2d;
static const Shortint isc_info_wal_grpc_wait_usecs = 0x2f;
static const Shortint isc_info_wal_num_io = 0x30;
static const Shortint isc_info_wal_avg_io_size = 0x31;
static const Shortint isc_info_wal_num_commits = 0x32;
static const Shortint isc_info_wal_avg_grpc_size = 0x33;
static const Shortint isc_info_forced_writes = 0x34;
static const Shortint isc_info_user_names = 0x35;
static const Shortint isc_info_page_errors = 0x36;
static const Shortint isc_info_record_errors = 0x37;
static const Shortint isc_info_bpage_errors = 0x38;
static const Shortint isc_info_dpage_errors = 0x39;
static const Shortint isc_info_ipage_errors = 0x3a;
static const Shortint isc_info_ppage_errors = 0x3b;
static const Shortint isc_info_tpage_errors = 0x3c;
static const Shortint isc_info_set_page_buffers = 0x3d;
static const Shortint isc_info_db_SQL_dialect = 0x3e;
static const Shortint isc_info_db_read_only = 0x3f;
static const Shortint isc_info_db_size_in_pages = 0x40;
static const Shortint isc_info_db_impl_rdb_vms = 0x1;
static const Shortint isc_info_db_impl_rdb_eln = 0x2;
static const Shortint isc_info_db_impl_rdb_eln_dev = 0x3;
static const Shortint isc_info_db_impl_rdb_vms_y = 0x4;
static const Shortint isc_info_db_impl_rdb_eln_y = 0x5;
static const Shortint isc_info_db_impl_jri = 0x6;
static const Shortint isc_info_db_impl_jsv = 0x7;
static const Shortint isc_info_db_impl_isc_a = 0x19;
static const Shortint isc_info_db_impl_isc_u = 0x1a;
static const Shortint isc_info_db_impl_isc_v = 0x1b;
static const Shortint isc_info_db_impl_isc_s = 0x1c;
static const Shortint isc_info_db_impl_isc_apl_68K = 0x19;
static const Shortint isc_info_db_impl_isc_vax_ultr = 0x1a;
static const Shortint isc_info_db_impl_isc_vms = 0x1b;
static const Shortint isc_info_db_impl_isc_sun_68k = 0x1c;
static const Shortint isc_info_db_impl_isc_os2 = 0x1d;
static const Shortint isc_info_db_impl_isc_sun4 = 0x1e;
static const Shortint isc_info_db_impl_isc_hp_ux = 0x1f;
static const Shortint isc_info_db_impl_isc_sun_386i = 0x20;
static const Shortint isc_info_db_impl_isc_vms_orcl = 0x21;
static const Shortint isc_info_db_impl_isc_mac_aux = 0x22;
static const Shortint isc_info_db_impl_isc_rt_aix = 0x23;
static const Shortint isc_info_db_impl_isc_mips_ult = 0x24;
static const Shortint isc_info_db_impl_isc_xenix = 0x25;
static const Shortint isc_info_db_impl_isc_dg = 0x26;
static const Shortint isc_info_db_impl_isc_hp_mpexl = 0x27;
static const Shortint isc_info_db_impl_isc_hp_ux68K = 0x28;
static const Shortint isc_info_db_impl_isc_sgi = 0x29;
static const Shortint isc_info_db_impl_isc_sco_unix = 0x2a;
static const Shortint isc_info_db_impl_isc_cray = 0x2b;
static const Shortint isc_info_db_impl_isc_imp = 0x2c;
static const Shortint isc_info_db_impl_isc_delta = 0x2d;
static const Shortint isc_info_db_impl_isc_next = 0x2e;
static const Shortint isc_info_db_impl_isc_dos = 0x2f;
static const Shortint isc_info_db_impl_isc_winnt = 0x30;
static const Shortint isc_info_db_impl_isc_epson = 0x31;
static const Shortint isc_info_db_class_access = 0x1;
static const Shortint isc_info_db_class_y_valve = 0x2;
static const Shortint isc_info_db_class_rem_int = 0x3;
static const Shortint isc_info_db_class_rem_srvr = 0x4;
static const Shortint isc_info_db_class_pipe_int = 0x7;
static const Shortint isc_info_db_class_pipe_srvr = 0x8;
static const Shortint isc_info_db_class_sam_int = 0x9;
static const Shortint isc_info_db_class_sam_srvr = 0xa;
static const Shortint isc_info_db_class_gateway = 0xb;
static const Shortint isc_info_db_class_cache = 0xc;
static const Shortint isc_info_number_messages = 0x4;
static const Shortint isc_info_max_message = 0x5;
static const Shortint isc_info_max_send = 0x6;
static const Shortint isc_info_max_receive = 0x7;
static const Shortint isc_info_state = 0x8;
static const Shortint isc_info_message_number = 0x9;
static const Shortint isc_info_message_size = 0xa;
static const Shortint isc_info_request_cost = 0xb;
static const Shortint isc_info_access_path = 0xc;
static const Shortint isc_info_req_select_count = 0xd;
static const Shortint isc_info_req_insert_count = 0xe;
static const Shortint isc_info_req_update_count = 0xf;
static const Shortint isc_info_req_delete_count = 0x10;
static const Shortint isc_info_rsb_end = 0x0;
static const Shortint isc_info_rsb_begin = 0x1;
static const Shortint isc_info_rsb_type = 0x2;
static const Shortint isc_info_rsb_relation = 0x3;
static const Shortint isc_info_rsb_plan = 0x4;
static const Shortint isc_info_rsb_unknown = 0x1;
static const Shortint isc_info_rsb_indexed = 0x2;
static const Shortint isc_info_rsb_navigate = 0x3;
static const Shortint isc_info_rsb_sequential = 0x4;
static const Shortint isc_info_rsb_cross = 0x5;
static const Shortint isc_info_rsb_sort = 0x6;
static const Shortint isc_info_rsb_first = 0x7;
static const Shortint isc_info_rsb_boolean = 0x8;
static const Shortint isc_info_rsb_union = 0x9;
static const Shortint isc_info_rsb_aggregate = 0xa;
static const Shortint isc_info_rsb_merge = 0xb;
static const Shortint isc_info_rsb_ext_sequential = 0xc;
static const Shortint isc_info_rsb_ext_indexed = 0xd;
static const Shortint isc_info_rsb_ext_dbkey = 0xe;
static const Shortint isc_info_rsb_left_cross = 0xf;
static const Shortint isc_info_rsb_select = 0x10;
static const Shortint isc_info_rsb_sql_join = 0x11;
static const Shortint isc_info_rsb_simulate = 0x12;
static const Shortint isc_info_rsb_sim_cross = 0x13;
static const Shortint isc_info_rsb_once = 0x14;
static const Shortint isc_info_rsb_procedure = 0x15;
static const Shortint isc_info_rsb_and = 0x1;
static const Shortint isc_info_rsb_or = 0x2;
static const Shortint isc_info_rsb_dbkey = 0x3;
static const Shortint isc_info_rsb_index = 0x4;
static const Shortint isc_info_req_active = 0x2;
static const Shortint isc_info_req_inactive = 0x3;
static const Shortint isc_info_req_send = 0x4;
static const Shortint isc_info_req_receive = 0x5;
static const Shortint isc_info_req_select = 0x6;
static const Shortint isc_info_req_sql_stall = 0x7;
static const Shortint isc_info_blob_num_segments = 0x4;
static const Shortint isc_info_blob_max_segment = 0x5;
static const Shortint isc_info_blob_total_length = 0x6;
static const Shortint isc_info_blob_type = 0x7;
static const Shortint isc_info_tra_id = 0x4;
static const Shortint isc_action_svc_backup = 0x1;
static const Shortint isc_action_svc_restore = 0x2;
static const Shortint isc_action_svc_repair = 0x3;
static const Shortint isc_action_svc_add_user = 0x4;
static const Shortint isc_action_svc_delete_user = 0x5;
static const Shortint isc_action_svc_modify_user = 0x6;
static const Shortint isc_action_svc_display_user = 0x7;
static const Shortint isc_action_svc_properties = 0x8;
static const Shortint isc_action_svc_add_license = 0x9;
static const Shortint isc_action_svc_remove_license = 0xa;
static const Shortint isc_action_svc_db_stats = 0xb;
static const Shortint isc_action_svc_get_ib_log = 0xc;
static const Shortint isc_info_svc_svr_db_info = 0x32;
static const Shortint isc_info_svc_get_license = 0x33;
static const Shortint isc_info_svc_get_license_mask = 0x34;
static const Shortint isc_info_svc_get_config = 0x35;
static const Shortint isc_info_svc_version = 0x36;
static const Shortint isc_info_svc_server_version = 0x37;
static const Shortint isc_info_svc_implementation = 0x38;
static const Shortint isc_info_svc_capabilities = 0x39;
static const Shortint isc_info_svc_user_dbpath = 0x3a;
static const Shortint isc_info_svc_get_env = 0x3b;
static const Shortint isc_info_svc_get_env_lock = 0x3c;
static const Shortint isc_info_svc_get_env_msg = 0x3d;
static const Shortint isc_info_svc_line = 0x3e;
static const Shortint isc_info_svc_to_eof = 0x3f;
static const Shortint isc_info_svc_timeout = 0x40;
static const Shortint isc_info_svc_get_licensed_users = 0x41;
static const Shortint isc_info_svc_limbo_trans = 0x42;
static const Shortint isc_info_svc_running = 0x43;
static const Shortint isc_info_svc_get_users = 0x44;
static const Shortint isc_spb_sec_userid = 0x5;
static const Shortint isc_spb_sec_groupid = 0x6;
static const Shortint isc_spb_sec_username = 0x7;
static const Shortint isc_spb_sec_password = 0x8;
static const Shortint isc_spb_sec_groupname = 0x9;
static const Shortint isc_spb_sec_firstname = 0xa;
static const Shortint isc_spb_sec_middlename = 0xb;
static const Shortint isc_spb_sec_lastname = 0xc;
static const Shortint isc_spb_lic_key = 0x5;
static const Shortint isc_spb_lic_id = 0x6;
static const Shortint isc_spb_lic_desc = 0x7;
static const Shortint isc_spb_bkp_file = 0x5;
static const Shortint isc_spb_bkp_factor = 0x6;
static const Shortint isc_spb_bkp_length = 0x7;
static const Shortint isc_spb_bkp_ignore_checksums = 0x1;
static const Shortint isc_spb_bkp_ignore_limbo = 0x2;
static const Shortint isc_spb_bkp_metadata_only = 0x4;
static const Shortint isc_spb_bkp_no_garbage_collect = 0x8;
static const Shortint isc_spb_bkp_old_descriptions = 0x10;
static const Shortint isc_spb_bkp_non_transportable = 0x20;
static const Shortint isc_spb_bkp_convert = 0x40;
static const Byte isc_spb_bkp_expand = 0x80;
static const Shortint isc_spb_lck_sample = 0x5;
static const Shortint isc_spb_lck_secs = 0x6;
static const Shortint isc_spb_lck_contents = 0x1;
static const Shortint isc_spb_lck_summary = 0x2;
static const Shortint isc_spb_lck_wait = 0x4;
static const Shortint isc_spb_lck_stats = 0x8;
static const Shortint isc_spb_prp_page_buffers = 0x5;
static const Shortint isc_spb_prp_sweep_interval = 0x6;
static const Shortint isc_spb_prp_shutdown_db = 0x7;
static const Shortint isc_spb_prp_deny_new_attachments = 0x9;
static const Shortint isc_spb_prp_deny_new_transactions = 0xa;
static const Shortint isc_spb_prp_reserve_space = 0xb;
static const Shortint isc_spb_prp_write_mode = 0xc;
static const Shortint isc_spb_prp_access_mode = 0xd;
static const Shortint isc_spb_prp_set_sql_dialect = 0xe;
static const Word isc_spb_prp_activate = 0x100;
static const Word isc_spb_prp_db_online = 0x200;
static const Shortint isc_spb_prp_res_use_full = 0x23;
static const Shortint isc_spb_prp_res = 0x24;
static const Shortint isc_spb_prp_wm_async = 0x25;
static const Shortint isc_spb_prp_wm_sync = 0x26;
static const Shortint isc_spb_prp_am_readonly = 0x27;
static const Shortint isc_spb_prp_am_readwrite = 0x28;
static const Shortint isc_spb_rpr_commit_trans = 0xf;
static const Shortint isc_spb_rpr_rollback_trans = 0x22;
static const Shortint isc_spb_rpr_recover_two_phase = 0x11;
static const Shortint isc_spb_tra_id = 0x12;
static const Shortint isc_spb_single_tra_id = 0x13;
static const Shortint isc_spb_multi_tra_id = 0x14;
static const Shortint isc_spb_tra_state = 0x15;
static const Shortint isc_spb_tra_state_limbo = 0x16;
static const Shortint isc_spb_tra_state_commit = 0x17;
static const Shortint isc_spb_tra_state_rollback = 0x18;
static const Shortint isc_spb_tra_state_unknown = 0x19;
static const Shortint isc_spb_tra_host_site = 0x1a;
static const Shortint isc_spb_tra_remote_site = 0x1b;
static const Shortint isc_spb_tra_db_path = 0x1c;
static const Shortint isc_spb_tra_advise = 0x1d;
static const Shortint isc_spb_tra_advise_commit = 0x1e;
static const Shortint isc_spb_tra_advise_rollback = 0x1f;
static const Shortint isc_spb_tra_advise_unknown = 0x21;
static const Shortint isc_spb_rpr_list_limbo_trans = 0x1;
static const Shortint isc_spb_rpr_check_db = 0x2;
static const Shortint isc_spb_rpr_ignore_checksum = 0x4;
static const Shortint isc_spb_rpr_kill_shadows = 0x8;
static const Shortint isc_spb_rpr_mend_db = 0x10;
static const Shortint isc_spb_rpr_sweep_db = 0x20;
static const Shortint isc_spb_rpr_validate_db = 0x40;
static const Byte isc_spb_rpr_full = 0x80;
static const Shortint isc_spb_res_buffers = 0x9;
static const Shortint isc_spb_res_page_size = 0xa;
static const Shortint isc_spb_res_length = 0xb;
static const Shortint isc_spb_res_access_mode = 0xc;
static const Word isc_spb_res_deactivate_idx = 0x100;
static const Word isc_spb_res_no_shadow = 0x200;
static const Word isc_spb_res_no_validity = 0x400;
static const Word isc_spb_res_one_ata_time = 0x800;
static const Word isc_spb_res_replace = 0x1000;
static const Word isc_spb_res_create = 0x2000;
static const Word isc_spb_res_use_all_space = 0x4000;
static const Shortint isc_spb_res_am_readonly = 0x27;
static const Shortint isc_spb_res_am_readwrite = 0x28;
static const Shortint isc_spb_num_att = 0x5;
static const Shortint isc_spb_num_db = 0x6;
static const Shortint isc_spb_sts_data_pages = 0x1;
static const Shortint isc_spb_sts_db_log = 0x2;
static const Shortint isc_spb_sts_hdr_pages = 0x4;
static const Shortint isc_spb_sts_idx_pages = 0x8;
static const Shortint isc_spb_sts_sys_relations = 0x10;
static const Shortint isc_info_sql_select = 0x4;
static const Shortint isc_info_sql_bind = 0x5;
static const Shortint isc_info_sql_num_variables = 0x6;
static const Shortint isc_info_sql_describe_vars = 0x7;
static const Shortint isc_info_sql_describe_end = 0x8;
static const Shortint isc_info_sql_sqlda_seq = 0x9;
static const Shortint isc_info_sql_message_seq = 0xa;
static const Shortint isc_info_sql_type = 0xb;
static const Shortint isc_info_sql_sub_type = 0xc;
static const Shortint isc_info_sql_scale = 0xd;
static const Shortint isc_info_sql_length = 0xe;
static const Shortint isc_info_sql_null_ind = 0xf;
static const Shortint isc_info_sql_field = 0x10;
static const Shortint isc_info_sql_relation = 0x11;
static const Shortint isc_info_sql_owner = 0x12;
static const Shortint isc_info_sql_alias = 0x13;
static const Shortint isc_info_sql_sqlda_start = 0x14;
static const Shortint isc_info_sql_stmt_type = 0x15;
static const Shortint isc_info_sql_get_plan = 0x16;
static const Shortint isc_info_sql_records = 0x17;
static const Shortint isc_info_sql_batch_fetch = 0x18;
static const Shortint isc_info_sql_stmt_select = 0x1;
static const Shortint isc_info_sql_stmt_insert = 0x2;
static const Shortint isc_info_sql_stmt_update = 0x3;
static const Shortint isc_info_sql_stmt_delete = 0x4;
static const Shortint isc_info_sql_stmt_ddl = 0x5;
static const Shortint isc_info_sql_stmt_get_segment = 0x6;
static const Shortint isc_info_sql_stmt_put_segment = 0x7;
static const Shortint isc_info_sql_stmt_exec_procedure = 0x8;
static const Shortint isc_info_sql_stmt_start_trans = 0x9;
static const Shortint isc_info_sql_stmt_commit = 0xa;
static const Shortint isc_info_sql_stmt_rollback = 0xb;
static const Shortint isc_info_sql_stmt_select_for_upd = 0xc;
static const Shortint isc_info_sql_stmt_set_generator = 0xd;
static const Shortint ISCCFG_LOCKMEM_KEY = 0x0;
static const Shortint ISCCFG_LOCKSEM_KEY = 0x1;
static const Shortint ISCCFG_LOCKSIG_KEY = 0x2;
static const Shortint ISCCFG_EVNTMEM_KEY = 0x3;
static const Shortint ISCCFG_DBCACHE_KEY = 0x4;
static const Shortint ISCCFG_PRIORITY_KEY = 0x5;
static const Shortint ISCCFG_IPCMAP_KEY = 0x6;
static const Shortint ISCCFG_MEMMIN_KEY = 0x7;
static const Shortint ISCCFG_MEMMAX_KEY = 0x8;
static const Shortint ISCCFG_LOCKORDER_KEY = 0x9;
static const Shortint ISCCFG_ANYLOCKMEM_KEY = 0xa;
static const Shortint ISCCFG_ANYLOCKSEM_KEY = 0xb;
static const Shortint ISCCFG_ANYLOCKSIG_KEY = 0xc;
static const Shortint ISCCFG_ANYEVNTMEM_KEY = 0xd;
static const Shortint ISCCFG_LOCKHASH_KEY = 0xe;
static const Shortint ISCCFG_DEADLOCK_KEY = 0xf;
static const Shortint ISCCFG_LOCKSPIN_KEY = 0x10;
static const Shortint ISCCFG_CONN_TIMEOUT_KEY = 0x11;
static const Shortint ISCCFG_DUMMY_INTRVL_KEY = 0x12;
static const Shortint ISCCFG_TRACE_POOLS_KEY = 0x13;
static const Shortint ISCCFG_REMOTE_BUFFER_KEY = 0x14;
static const Shortint isc_facility = 0x14;
static const int isc_err_base = 0x14000000;
static const Shortint isc_err_factor = 0x1;
static const Shortint isc_arg_end = 0x0;
static const Shortint isc_arg_gds = 0x1;
static const Shortint isc_arg_string = 0x2;
static const Shortint isc_arg_cstring = 0x3;
static const Shortint isc_arg_number = 0x4;
static const Shortint isc_arg_interpreted = 0x5;
static const Shortint isc_arg_vms = 0x6;
static const Shortint isc_arg_unix = 0x7;
static const Shortint isc_arg_domain = 0x8;
static const Shortint isc_arg_dos = 0x9;
static const Shortint isc_arg_mpexl = 0xa;
static const Shortint isc_arg_mpexl_ipc = 0xb;
static const Shortint isc_arg_next_mach = 0xf;
static const Shortint isc_arg_netware = 0x10;
static const Shortint isc_arg_win32 = 0x11;
static const Shortint isc_arg_warning = 0x12;
static const Shortint isc_dyn_version_1 = 0x1;
static const Shortint isc_dyn_eoc = 0xffffffff;
static const Shortint isc_dyn_begin = 0x2;
static const Shortint isc_dyn_end = 0x3;
static const Shortint isc_dyn_if = 0x4;
static const Shortint isc_dyn_def_database = 0x5;
static const Shortint isc_dyn_def_global_fld = 0x6;
static const Shortint isc_dyn_def_local_fld = 0x7;
static const Shortint isc_dyn_def_idx = 0x8;
static const Shortint isc_dyn_def_rel = 0x9;
static const Shortint isc_dyn_def_sql_fld = 0xa;
static const Shortint isc_dyn_def_view = 0xc;
static const Shortint isc_dyn_def_trigger = 0xf;
static const Shortint isc_dyn_def_security_class = 0x78;
static const Byte isc_dyn_def_dimension = 0x8c;
static const Shortint isc_dyn_def_generator = 0x18;
static const Shortint isc_dyn_def_function = 0x19;
static const Shortint isc_dyn_def_filter = 0x1a;
static const Shortint isc_dyn_def_function_arg = 0x1b;
static const Shortint isc_dyn_def_shadow = 0x22;
static const Shortint isc_dyn_def_trigger_msg = 0x11;
static const Shortint isc_dyn_def_file = 0x24;
static const Shortint isc_dyn_mod_database = 0x27;
static const Shortint isc_dyn_mod_rel = 0xb;
static const Shortint isc_dyn_mod_global_fld = 0xd;
static const Shortint isc_dyn_mod_idx = 0x66;
static const Shortint isc_dyn_mod_local_fld = 0xe;
static const Byte isc_dyn_mod_sql_fld = 0xd8;
static const Shortint isc_dyn_mod_view = 0x10;
static const Shortint isc_dyn_mod_security_class = 0x7a;
static const Shortint isc_dyn_mod_trigger = 0x71;
static const Shortint isc_dyn_mod_trigger_msg = 0x1c;
static const Shortint isc_dyn_delete_database = 0x12;
static const Shortint isc_dyn_delete_rel = 0x13;
static const Shortint isc_dyn_delete_global_fld = 0x14;
static const Shortint isc_dyn_delete_local_fld = 0x15;
static const Shortint isc_dyn_delete_idx = 0x16;
static const Shortint isc_dyn_delete_security_class = 0x7b;
static const Byte isc_dyn_delete_dimensions = 0x8f;
static const Shortint isc_dyn_delete_trigger = 0x17;
static const Shortint isc_dyn_delete_trigger_msg = 0x1d;
static const Shortint isc_dyn_delete_filter = 0x20;
static const Shortint isc_dyn_delete_function = 0x21;
static const Shortint isc_dyn_delete_shadow = 0x23;
static const Shortint isc_dyn_grant = 0x1e;
static const Shortint isc_dyn_revoke = 0x1f;
static const Shortint isc_dyn_def_primary_key = 0x25;
static const Shortint isc_dyn_def_foreign_key = 0x26;
static const Shortint isc_dyn_def_unique = 0x28;
static const Byte isc_dyn_def_procedure = 0xa4;
static const Byte isc_dyn_delete_procedure = 0xa5;
static const Byte isc_dyn_def_parameter = 0x87;
static const Byte isc_dyn_delete_parameter = 0x88;
static const Byte isc_dyn_mod_procedure = 0xaf;
static const Byte isc_dyn_def_log_file = 0xb0;
static const Byte isc_dyn_def_cache_file = 0xb4;
static const Byte isc_dyn_def_exception = 0xb5;
static const Byte isc_dyn_mod_exception = 0xb6;
static const Byte isc_dyn_del_exception = 0xb7;
static const Byte isc_dyn_drop_log = 0xc2;
static const Byte isc_dyn_drop_cache = 0xc3;
static const Byte isc_dyn_def_default_log = 0xca;
static const Shortint isc_dyn_view_blr = 0x2b;
static const Shortint isc_dyn_view_source = 0x2c;
static const Shortint isc_dyn_view_relation = 0x2d;
static const Shortint isc_dyn_view_context = 0x2e;
static const Shortint isc_dyn_view_context_name = 0x2f;
static const Shortint isc_dyn_rel_name = 0x32;
static const Shortint isc_dyn_fld_name = 0x33;
static const Byte isc_dyn_new_fld_name = 0xd7;
static const Shortint isc_dyn_idx_name = 0x34;
static const Shortint isc_dyn_description = 0x35;
static const Shortint isc_dyn_security_class = 0x36;
static const Shortint isc_dyn_system_flag = 0x37;
static const Shortint isc_dyn_update_flag = 0x38;
static const Byte isc_dyn_prc_name = 0xa6;
static const Byte isc_dyn_prm_name = 0x89;
static const Byte isc_dyn_sql_object = 0xc4;
static const Byte isc_dyn_fld_character_set_name = 0xae;
static const Shortint isc_dyn_rel_dbkey_length = 0x3d;
static const Shortint isc_dyn_rel_store_trig = 0x3e;
static const Shortint isc_dyn_rel_modify_trig = 0x3f;
static const Shortint isc_dyn_rel_erase_trig = 0x40;
static const Shortint isc_dyn_rel_store_trig_source = 0x41;
static const Shortint isc_dyn_rel_modify_trig_source = 0x42;
static const Shortint isc_dyn_rel_erase_trig_source = 0x43;
static const Shortint isc_dyn_rel_ext_file = 0x44;
static const Shortint isc_dyn_rel_sql_protection = 0x45;
static const Byte isc_dyn_rel_constraint = 0xa2;
static const Byte isc_dyn_delete_rel_constraint = 0xa3;
static const Shortint isc_dyn_fld_type = 0x46;
static const Shortint isc_dyn_fld_length = 0x47;
static const Shortint isc_dyn_fld_scale = 0x48;
static const Shortint isc_dyn_fld_sub_type = 0x49;
static const Shortint isc_dyn_fld_segment_length = 0x4a;
static const Shortint isc_dyn_fld_query_header = 0x4b;
static const Shortint isc_dyn_fld_edit_string = 0x4c;
static const Shortint isc_dyn_fld_validation_blr = 0x4d;
static const Shortint isc_dyn_fld_validation_source = 0x4e;
static const Shortint isc_dyn_fld_computed_blr = 0x4f;
static const Shortint isc_dyn_fld_computed_source = 0x50;
static const Shortint isc_dyn_fld_missing_value = 0x51;
static const Shortint isc_dyn_fld_default_value = 0x52;
static const Shortint isc_dyn_fld_query_name = 0x53;
static const Shortint isc_dyn_fld_dimensions = 0x54;
static const Shortint isc_dyn_fld_not_null = 0x55;
static const Shortint isc_dyn_fld_precision = 0x56;
static const Byte isc_dyn_fld_char_length = 0xac;
static const Byte isc_dyn_fld_collation = 0xad;
static const Byte isc_dyn_fld_default_source = 0xc1;
static const Byte isc_dyn_del_default = 0xc5;
static const Byte isc_dyn_del_validation = 0xc6;
static const Byte isc_dyn_single_validation = 0xc7;
static const Byte isc_dyn_fld_character_set = 0xcb;
static const Shortint isc_dyn_fld_source = 0x5a;
static const Shortint isc_dyn_fld_base_fld = 0x5b;
static const Shortint isc_dyn_fld_position = 0x5c;
static const Shortint isc_dyn_fld_update_flag = 0x5d;
static const Shortint isc_dyn_idx_unique = 0x64;
static const Shortint isc_dyn_idx_inactive = 0x65;
static const Shortint isc_dyn_idx_type = 0x67;
static const Shortint isc_dyn_idx_foreign_key = 0x68;
static const Shortint isc_dyn_idx_ref_column = 0x69;
static const Byte isc_dyn_idx_statistic = 0xcc;
static const Shortint isc_dyn_trg_type = 0x6e;
static const Shortint isc_dyn_trg_blr = 0x6f;
static const Shortint isc_dyn_trg_source = 0x70;
static const Shortint isc_dyn_trg_name = 0x72;
static const Shortint isc_dyn_trg_sequence = 0x73;
static const Shortint isc_dyn_trg_inactive = 0x74;
static const Shortint isc_dyn_trg_msg_number = 0x75;
static const Shortint isc_dyn_trg_msg = 0x76;
static const Shortint isc_dyn_scl_acl = 0x79;
static const Byte isc_dyn_grant_user = 0x82;
static const Byte isc_dyn_grant_proc = 0xba;
static const Byte isc_dyn_grant_trig = 0xbb;
static const Byte isc_dyn_grant_view = 0xbc;
static const Byte isc_dyn_grant_options = 0x84;
static const Byte isc_dyn_grant_user_group = 0xcd;
static const Byte isc_dyn_dim_lower = 0x8d;
static const Byte isc_dyn_dim_upper = 0x8e;
static const Shortint isc_dyn_file_name = 0x7d;
static const Shortint isc_dyn_file_start = 0x7e;
static const Shortint isc_dyn_file_length = 0x7f;
static const Byte isc_dyn_shadow_number = 0x80;
static const Byte isc_dyn_shadow_man_auto = 0x81;
static const Byte isc_dyn_shadow_conditional = 0x82;
static const Byte isc_dyn_log_file_sequence = 0xb1;
static const Byte isc_dyn_log_file_partitions = 0xb2;
static const Byte isc_dyn_log_file_serial = 0xb3;
static const Byte isc_dyn_log_file_overflow = 0xc8;
static const Byte isc_dyn_log_file_raw = 0xc9;
static const Byte isc_dyn_log_group_commit_wait = 0xbd;
static const Byte isc_dyn_log_buffer_size = 0xbe;
static const Byte isc_dyn_log_check_point_length = 0xbf;
static const Byte isc_dyn_log_num_of_buffers = 0xc0;
static const Byte isc_dyn_function_name = 0x91;
static const Byte isc_dyn_function_type = 0x92;
static const Byte isc_dyn_func_module_name = 0x93;
static const Byte isc_dyn_func_entry_point = 0x94;
static const Byte isc_dyn_func_return_argument = 0x95;
static const Byte isc_dyn_func_arg_position = 0x96;
static const Byte isc_dyn_func_mechanism = 0x97;
static const Byte isc_dyn_filter_in_subtype = 0x98;
static const Byte isc_dyn_filter_out_subtype = 0x99;
static const Byte isc_dyn_description2 = 0x9a;
static const Byte isc_dyn_fld_computed_source2 = 0x9b;
static const Byte isc_dyn_fld_edit_string2 = 0x9c;
static const Byte isc_dyn_fld_query_header2 = 0x9d;
static const Byte isc_dyn_fld_validation_source2 = 0x9e;
static const Byte isc_dyn_trg_msg2 = 0x9f;
static const Byte isc_dyn_trg_source2 = 0xa0;
static const Byte isc_dyn_view_source2 = 0xa1;
static const Byte isc_dyn_xcp_msg2 = 0xb8;
static const Shortint isc_dyn_generator_name = 0x5f;
static const Shortint isc_dyn_generator_id = 0x60;
static const Byte isc_dyn_prc_inputs = 0xa7;
static const Byte isc_dyn_prc_outputs = 0xa8;
static const Byte isc_dyn_prc_source = 0xa9;
static const Byte isc_dyn_prc_blr = 0xaa;
static const Byte isc_dyn_prc_source2 = 0xab;
static const Byte isc_dyn_prm_number = 0x8a;
static const Byte isc_dyn_prm_type = 0x8b;
static const Byte isc_dyn_xcp_msg = 0xb9;
static const Byte isc_dyn_foreign_key_update = 0xcd;
static const Byte isc_dyn_foreign_key_delete = 0xce;
static const Byte isc_dyn_foreign_key_cascade = 0xcf;
static const Byte isc_dyn_foreign_key_default = 0xd0;
static const Byte isc_dyn_foreign_key_null = 0xd1;
static const Byte isc_dyn_foreign_key_none = 0xd2;
static const Byte isc_dyn_def_sql_role = 0xd3;
static const Byte isc_dyn_sql_role_name = 0xd4;
static const Byte isc_dyn_grant_admin_options = 0xd5;
static const Byte isc_dyn_del_sql_role = 0xd6;
static const Byte isc_dyn_last_dyn_value = 0xd8;
static const Shortint isc_sdl_version1 = 0x1;
static const Shortint isc_sdl_eoc = 0xffffffff;
static const Shortint isc_sdl_relation = 0x2;
static const Shortint isc_sdl_rid = 0x3;
static const Shortint isc_sdl_field = 0x4;
static const Shortint isc_sdl_fid = 0x5;
static const Shortint isc_sdl_struct = 0x6;
static const Shortint isc_sdl_variable = 0x7;
static const Shortint isc_sdl_scalar = 0x8;
static const Shortint isc_sdl_tiny_integer = 0x9;
static const Shortint isc_sdl_short_integer = 0xa;
static const Shortint isc_sdl_long_integer = 0xb;
static const Shortint isc_sdl_literal = 0xc;
static const Shortint isc_sdl_add = 0xd;
static const Shortint isc_sdl_subtract = 0xe;
static const Shortint isc_sdl_multiply = 0xf;
static const Shortint isc_sdl_divide = 0x10;
static const Shortint isc_sdl_negate = 0x11;
static const Shortint isc_sdl_eql = 0x12;
static const Shortint isc_sdl_neq = 0x13;
static const Shortint isc_sdl_gtr = 0x14;
static const Shortint isc_sdl_geq = 0x15;
static const Shortint isc_sdl_lss = 0x16;
static const Shortint isc_sdl_leq = 0x17;
static const Shortint isc_sdl_and = 0x18;
static const Shortint isc_sdl_or = 0x19;
static const Shortint isc_sdl_not = 0x1a;
static const Shortint isc_sdl_while = 0x1b;
static const Shortint isc_sdl_assignment = 0x1c;
static const Shortint isc_sdl_label = 0x1d;
static const Shortint isc_sdl_leave = 0x1e;
static const Shortint isc_sdl_begin = 0x1f;
static const Shortint isc_sdl_end = 0x20;
static const Shortint isc_sdl_do3 = 0x21;
static const Shortint isc_sdl_do2 = 0x22;
static const Shortint isc_sdl_do1 = 0x23;
static const Shortint isc_sdl_element = 0x24;
static const Shortint isc_interp_eng_ascii = 0x0;
static const Shortint isc_interp_jpn_sjis = 0x5;
static const Shortint isc_interp_jpn_euc = 0x6;
static const Shortint isc_fetch_next = 0x0;
static const Shortint isc_fetch_prior = 0x1;
static const Shortint isc_fetch_first = 0x2;
static const Shortint isc_fetch_last = 0x3;
static const Shortint isc_fetch_absolute = 0x4;
static const Shortint isc_fetch_relative = 0x5;
static const Word SQL_VARYING = 0x1c0;
static const Word SQL_TEXT = 0x1c4;
static const Word SQL_DOUBLE = 0x1e0;
static const Word SQL_FLOAT = 0x1e2;
static const Word SQL_LONG = 0x1f0;
static const Word SQL_SHORT = 0x1f4;
static const Word SQL_TIMESTAMP = 0x1fe;
static const Word SQL_BLOB = 0x208;
static const Word SQL_D_FLOAT = 0x212;
static const Word SQL_ARRAY = 0x21c;
static const Word SQL_QUAD = 0x226;
static const Word SQL_TYPE_TIME = 0x230;
static const Word SQL_TYPE_DATE = 0x23a;
static const Word SQL_INT64 = 0x244;
static const Word SQL_DATE = 0x1fe;
static const Shortint isc_blob_untyped = 0x0;
static const Shortint isc_blob_text = 0x1;
static const Shortint isc_blob_blr = 0x2;
static const Shortint isc_blob_acl = 0x3;
static const Shortint isc_blob_ranges = 0x4;
static const Shortint isc_blob_summary = 0x5;
static const Shortint isc_blob_format = 0x6;
static const Shortint isc_blob_tra = 0x7;
static const Shortint isc_blob_extfile = 0x8;
static const Shortint isc_blob_formatted_memo = 0x14;
static const Shortint isc_blob_paradox_ole = 0x15;
static const Shortint isc_blob_graphic = 0x16;
static const Shortint isc_blob_dbase_ole = 0x17;
static const Shortint isc_blob_typed_binary = 0x18;
static const Byte MaxTPBLength = 0xff;
static const Shortint ESVBufferSize = 0x50;
#define DefSqlApiDLL "gds32.dll"
extern PACKAGE AnsiString SqlApiDLL;
extern PACKAGE TIntFunctions* IntCalls;
extern PACKAGE Sdcommon::TISqlDatabase* __fastcall InitSqlDatabase(Classes::TStrings* ADbParams);
extern PACKAGE void __fastcall LoadSqlLib(void);
extern PACKAGE void __fastcall FreeSqlLib(void);
extern PACKAGE void __fastcall IntCheck(int Status, PISC_STATUS &StatusVector, TMetaClass* AErrorClass
	, TIntFunctions* ApiCalls);

}	/* namespace Sdint */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdint;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDInt
