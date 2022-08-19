// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainInterbaseDriver.pas' rev: 5.00

#ifndef ZPlainInterbaseDriverHPP
#define ZPlainInterbaseDriverHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainDriver.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <ZClasses.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplaininterbasedriver
{
//-- type declarations -------------------------------------------------------
typedef unsigned ULong;

typedef char UChar;

typedef short Short;

typedef int ISC_LONG;

typedef unsigned UISC_LONG;

typedef __int64 ISC_INT64;

typedef int ISC_STATUS;

typedef unsigned UISC_STATUS;

typedef int *PISC_LONG;

typedef unsigned *PUISC_LONG;

typedef int *PISC_STATUS;

typedef PISC_STATUS *PPISC_STATUS;

typedef unsigned *PUISC_STATUS;

typedef short *PShort;

typedef char * *PPChar;

typedef Word UShort;

typedef void *PVoid;

struct TCTimeStructure
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

typedef TCTimeStructure *PCTimeStructure;

typedef TCTimeStructure  TM;

typedef TCTimeStructure *PTM;

struct TISC_VARYING
{
	short strlen;
	char str[1];
} ;

typedef TISC_VARYING *PISC_VARYING;

typedef void *TISC_BLOB_HANDLE;

typedef void * *PISC_BLOB_HANDLE;

typedef void *TISC_DB_HANDLE;

typedef void * *PISC_DB_HANDLE;

typedef void *TISC_STMT_HANDLE;

typedef void * *PISC_STMT_HANDLE;

typedef void *TISC_TR_HANDLE;

typedef void * *PISC_TR_HANDLE;

typedef void __fastcall (*TISC_CALLBACK)(void);

typedef int ISC_DATE;

typedef int *PISC_DATE;

typedef unsigned ISC_TIME;

typedef unsigned *PISC_TIME;

struct TISC_TIMESTAMP
{
	unsigned timestamp_time;
	int timestamp_date;
} ;

typedef TISC_TIMESTAMP *PISC_TIMESTAMP;

struct TGDS_QUAD
{
	int gds_quad_high;
	unsigned gds_quad_low;
} ;

typedef TGDS_QUAD *PGDS_QUAD;

typedef TGDS_QUAD  TISC_QUAD;

typedef TGDS_QUAD *PISC_QUAD;

struct TISC_ARRAY_BOUND
{
	short array_bound_lower;
	short array_bound_upper;
} ;

typedef TISC_ARRAY_BOUND *PISC_ARRAY_BOUND;

struct TISC_ARRAY_DESC
{
	char array_desc_dtype;
	char array_desc_scale;
	short array_desc_length;
	char array_desc_field_name[32];
	char array_desc_relation_name[32];
	short array_desc_dimensions;
	short array_desc_flags;
	TISC_ARRAY_BOUND array_desc_bounds[16];
} ;

typedef TISC_ARRAY_DESC *PISC_ARRAY_DESC;

struct TISC_BLOB_DESC
{
	short blob_desc_subtype;
	short blob_desc_charset;
	short blob_desc_segment_size;
	char blob_desc_field_name[32];
	char blob_desc_relation_name[32];
} ;

typedef TISC_BLOB_DESC *PISC_BLOB_DESC;

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

typedef TXSQLVAR *PXSQLVAR;

struct TXSQLDA
{
	short version;
	char sqldaid[8];
	int sqldabc;
	short sqln;
	short sqld;
	TXSQLVAR sqlvar[1];
} ;

typedef TXSQLDA *PXSQLDA;

struct TISC_START_TRANS
{
	void * *db_handle;
	Word tpb_length;
	char *tpb_address;
} ;

struct TISC_TEB
{
	void * *db_handle;
	int tpb_length;
	char *tpb_address;
} ;

typedef TISC_TEB *PISC_TEB;

typedef TISC_TEB TISC_TEB_ARRAY[1];

typedef TISC_TEB *PISC_TEB_ARRAY;

typedef int TARRAY_ISC_STATUS[21];

typedef int *PARRAY_ISC_STATUS;

__interface IZInterbasePlainDriver;
typedef System::DelphiInterface<IZInterbasePlainDriver> _di_IZInterbasePlainDriver;
__interface INTERFACE_UUID("{AE2C4379-4E47-4752-BC01-D405ACC337F5}") IZInterbasePlainDriver  : public IZPlainDriver 
	
{
	
public:
	virtual int __fastcall isc_attach_database(PISC_STATUS status_vector, short db_name_length, char * 
		db_name, PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer) = 0 ;
	virtual int __fastcall isc_detach_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle) = 0 
		;
	virtual int __fastcall isc_drop_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle) = 0 ;
		
	virtual int __fastcall isc_database_info(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, short 
		item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		) = 0 ;
	virtual int __fastcall isc_array_gen_sdl(PISC_STATUS status_vector, PISC_ARRAY_DESC isc_array_desc, 
		PShort isc_arg3, char * isc_arg4, PShort isc_arg5) = 0 ;
	virtual int __fastcall isc_array_get_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * dest_array, int slice_length)
		 = 0 ;
	virtual int __fastcall isc_array_lookup_bounds(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, 
		PISC_TR_HANDLE trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor) = 0 
		;
	virtual int __fastcall isc_array_lookup_desc(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor) = 0 ;
	virtual int __fastcall isc_array_set_desc(PISC_STATUS status_vector, char * table_name, char * column_name
		, PShort sql_dtype, PShort sql_length, PShort sql_dimensions, PISC_ARRAY_DESC descriptor) = 0 ;
	virtual int __fastcall isc_array_put_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * source_array, PISC_LONG slice_length
		) = 0 ;
	virtual int __fastcall isc_free(char * isc_arg1) = 0 ;
	virtual int __fastcall isc_sqlcode(PISC_STATUS status_vector) = 0 ;
	virtual void __fastcall isc_sql_interprete(short sqlcode, char * buffer, short buffer_length) = 0 ;
		
	virtual int __fastcall isc_interprete(char * buffer, PPISC_STATUS status_vector) = 0 ;
	virtual int __fastcall isc_start_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, 
		short db_handle_count, PISC_DB_HANDLE db_handle, Word tpb_length, char * tpb_address) = 0 ;
	virtual int __fastcall isc_start_multiple(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short 
		db_handle_count, PISC_TEB teb_vector_address) = 0 ;
	virtual int __fastcall isc_rollback_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle
		) = 0 ;
	virtual int __fastcall isc_rollback_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle
		) = 0 ;
	virtual int __fastcall isc_commit_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle) = 0 
		;
	virtual int __fastcall isc_commit_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle
		) = 0 ;
	virtual int __fastcall isc_dsql_allocate_statement(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle
		, PISC_STMT_HANDLE stmt_handle) = 0 ;
	virtual int __fastcall isc_dsql_alloc_statement2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle
		, PISC_STMT_HANDLE stmt_handle) = 0 ;
	virtual int __fastcall isc_dsql_describe(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_describe_bind(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle
		, Word dialect, PXSQLDA xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_execute(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_execute2(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_execute_immediate(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle
		, PISC_TR_HANDLE tran_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_fetch(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_free_statement(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle
		, Word options) = 0 ;
	virtual int __fastcall isc_dsql_prepare(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda) = 0 ;
	virtual int __fastcall isc_dsql_set_cursor_name(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle
		, char * cursor_name, Word _type) = 0 ;
	virtual int __fastcall isc_dsql_sql_info(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, short 
		item_length, char * items, short buffer_length, char * buffer) = 0 ;
	virtual int __fastcall isc_open_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_buffer)
		 = 0 ;
	virtual int __fastcall isc_create_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_address
		) = 0 ;
	virtual PISC_STATUS __fastcall isc_blob_info(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle
		, short item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		) = 0 ;
	virtual int __fastcall isc_close_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle) = 0 
		;
	virtual int __fastcall isc_cancel_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle) = 0 
		;
	virtual int __fastcall isc_get_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Zcompatibility::PWord 
		actual_seg_length, Word seg_buffer_length, char * seg_buffer) = 0 ;
	virtual int __fastcall isc_put_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Word 
		seg_buffer_len, char * seg_buffer) = 0 ;
	virtual int __fastcall isc_event_block(PPChar event_buffer, PPChar result_buffer, Word id_count, const 
		char * * event_list, const int event_list_Size) = 0 ;
	virtual void __fastcall isc_event_counts(PISC_STATUS status_vector, short buffer_length, char * event_buffer
		, char * result_buffer) = 0 ;
	virtual int __fastcall isc_cancel_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG 
		event_id) = 0 ;
	virtual int __fastcall isc_que_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG 
		event_id, short length, char * event_buffer, TISC_CALLBACK event_function, void * event_function_arg
		) = 0 ;
	virtual void __fastcall isc_decode_date(PISC_QUAD ib_date, PCTimeStructure tm_date) = 0 ;
	virtual void __fastcall isc_encode_date(PCTimeStructure tm_date, PISC_QUAD ib_date) = 0 ;
	virtual int __fastcall isc_vax_integer(char * buffer, short length) = 0 ;
	virtual void __fastcall isc_decode_sql_date(PISC_DATE ib_date, PCTimeStructure tm_date) = 0 ;
	virtual void __fastcall isc_decode_sql_time(PISC_TIME ib_time, PCTimeStructure tm_date) = 0 ;
	virtual void __fastcall isc_decode_timestamp(PISC_TIMESTAMP ib_timestamp, PCTimeStructure tm_date) = 0 
		;
	virtual void __fastcall isc_encode_sql_date(PCTimeStructure tm_date, PISC_DATE ib_date) = 0 ;
	virtual void __fastcall isc_encode_sql_time(PCTimeStructure tm_date, PISC_TIME ib_time) = 0 ;
	virtual void __fastcall isc_encode_timestamp(PCTimeStructure tm_date, PISC_TIMESTAMP ib_timestamp) = 0 
		;
};

__interface IZInterbase6PlainDriver;
typedef System::DelphiInterface<IZInterbase6PlainDriver> _di_IZInterbase6PlainDriver;
__interface INTERFACE_UUID("{AFCC45CF-CF6D-499B-8EC2-5C1737A59E30}") IZInterbase6PlainDriver  : public IZInterbasePlainDriver 
	
{
	
};

class DELPHICLASS TZInterbase6PlainDriver;
class PASCALIMPLEMENTATION TZInterbase6PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZInterbase6PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	int __fastcall isc_attach_database(PISC_STATUS status_vector, short db_name_length, char * db_name, 
		PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer);
	int __fastcall isc_detach_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_drop_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_database_info(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, short item_list_buffer_length
		, char * item_list_buffer, short result_buffer_length, char * result_buffer);
	int __fastcall isc_array_gen_sdl(PISC_STATUS status_vector, PISC_ARRAY_DESC isc_array_desc, PShort 
		isc_arg3, char * isc_arg4, PShort isc_arg5);
	int __fastcall isc_array_get_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * dest_array, int slice_length)
		;
	int __fastcall isc_array_lookup_bounds(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_lookup_desc(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_set_desc(PISC_STATUS status_vector, char * table_name, char * column_name, 
		PShort sql_dtype, PShort sql_length, PShort sql_dimensions, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_put_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * source_array, PISC_LONG slice_length
		);
	int __fastcall isc_free(char * isc_arg1);
	int __fastcall isc_sqlcode(PISC_STATUS status_vector);
	void __fastcall isc_sql_interprete(short sqlcode, char * buffer, short buffer_length);
	int __fastcall isc_interprete(char * buffer, PPISC_STATUS status_vector);
	int __fastcall isc_start_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_DB_HANDLE db_handle, Word tpb_length, char * tpb_address);
	int __fastcall isc_start_multiple(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_TEB teb_vector_address);
	int __fastcall isc_rollback_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_rollback_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_dsql_allocate_statement(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_alloc_statement2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_describe(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_describe_bind(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute2(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda);
	int __fastcall isc_dsql_execute_immediate(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_fetch(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_free_statement(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		options);
	int __fastcall isc_dsql_prepare(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_set_cursor_name(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, char * 
		cursor_name, Word _type);
	int __fastcall isc_dsql_sql_info(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, short item_length
		, char * items, short buffer_length, char * buffer);
	int __fastcall isc_open_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE tran_handle
		, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_buffer);
	int __fastcall isc_create_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_address
		);
	PISC_STATUS __fastcall isc_blob_info(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, short 
		item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		);
	int __fastcall isc_close_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_cancel_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_get_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Zcompatibility::PWord 
		actual_seg_length, Word seg_buffer_length, char * seg_buffer);
	int __fastcall isc_put_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Word seg_buffer_len
		, char * seg_buffer);
	int __fastcall isc_event_block(PPChar event_buffer, PPChar result_buffer, Word id_count, const char * 
		* event_list, const int event_list_Size);
	void __fastcall isc_event_counts(PISC_STATUS status_vector, short buffer_length, char * event_buffer
		, char * result_buffer);
	int __fastcall isc_cancel_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		);
	int __fastcall isc_que_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		, short length, char * event_buffer, TISC_CALLBACK event_function, void * event_function_arg);
	void __fastcall isc_decode_date(PISC_QUAD ib_date, PCTimeStructure tm_date);
	void __fastcall isc_encode_date(PCTimeStructure tm_date, PISC_QUAD ib_date);
	void __fastcall isc_decode_sql_date(PISC_DATE ib_date, PCTimeStructure tm_date);
	void __fastcall isc_decode_sql_time(PISC_TIME ib_time, PCTimeStructure tm_date);
	void __fastcall isc_decode_timestamp(PISC_TIMESTAMP ib_timestamp, PCTimeStructure tm_date);
	void __fastcall isc_encode_sql_date(PCTimeStructure tm_date, PISC_DATE ib_date);
	void __fastcall isc_encode_sql_time(PCTimeStructure tm_date, PISC_TIME ib_time);
	void __fastcall isc_encode_timestamp(PCTimeStructure tm_date, PISC_TIMESTAMP ib_timestamp);
	int __fastcall isc_vax_integer(char * buffer, short length);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZInterbase6PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZInterbase6PlainDriver;	/* Zplaininterbasedriver::IZInterbase6PlainDriver */
	
public:
	operator IZInterbase6PlainDriver*(void) { return (IZInterbase6PlainDriver*)&__IZInterbase6PlainDriver; }
		
	operator IZInterbasePlainDriver*(void) { return (IZInterbasePlainDriver*)&__IZInterbase6PlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZInterbase6PlainDriver; }
	
};


__interface IZInterbase5PlainDriver;
typedef System::DelphiInterface<IZInterbase5PlainDriver> _di_IZInterbase5PlainDriver;
__interface INTERFACE_UUID("{0AF9A168-9494-4327-AD35-6A2FA6E811DD}") IZInterbase5PlainDriver  : public IZInterbasePlainDriver 
	
{
	
};

class DELPHICLASS TZInterbase5PlainDriver;
class PASCALIMPLEMENTATION TZInterbase5PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZInterbase5PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	int __fastcall isc_attach_database(PISC_STATUS status_vector, short db_name_length, char * db_name, 
		PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer);
	int __fastcall isc_detach_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_drop_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_database_info(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, short item_list_buffer_length
		, char * item_list_buffer, short result_buffer_length, char * result_buffer);
	int __fastcall isc_array_gen_sdl(PISC_STATUS status_vector, PISC_ARRAY_DESC isc_array_desc, PShort 
		isc_arg3, char * isc_arg4, PShort isc_arg5);
	int __fastcall isc_array_get_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * dest_array, int slice_length)
		;
	int __fastcall isc_array_lookup_bounds(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_lookup_desc(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_set_desc(PISC_STATUS status_vector, char * table_name, char * column_name, 
		PShort sql_dtype, PShort sql_length, PShort sql_dimensions, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_put_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * source_array, PISC_LONG slice_length
		);
	int __fastcall isc_free(char * isc_arg1);
	int __fastcall isc_sqlcode(PISC_STATUS status_vector);
	void __fastcall isc_sql_interprete(short sqlcode, char * buffer, short buffer_length);
	int __fastcall isc_interprete(char * buffer, PPISC_STATUS status_vector);
	int __fastcall isc_start_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_DB_HANDLE db_handle, Word tpb_length, char * tpb_address);
	int __fastcall isc_start_multiple(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_TEB teb_vector_address);
	int __fastcall isc_rollback_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_rollback_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_dsql_allocate_statement(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_alloc_statement2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_describe(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_describe_bind(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute2(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda);
	int __fastcall isc_dsql_execute_immediate(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_fetch(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_free_statement(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		options);
	int __fastcall isc_dsql_prepare(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_set_cursor_name(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, char * 
		cursor_name, Word _type);
	int __fastcall isc_dsql_sql_info(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, short item_length
		, char * items, short buffer_length, char * buffer);
	int __fastcall isc_open_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE tran_handle
		, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_buffer);
	int __fastcall isc_create_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_address
		);
	PISC_STATUS __fastcall isc_blob_info(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, short 
		item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		);
	int __fastcall isc_close_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_cancel_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_get_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Zcompatibility::PWord 
		actual_seg_length, Word seg_buffer_length, char * seg_buffer);
	int __fastcall isc_put_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Word seg_buffer_len
		, char * seg_buffer);
	int __fastcall isc_event_block(PPChar event_buffer, PPChar result_buffer, Word id_count, const char * 
		* event_list, const int event_list_Size);
	void __fastcall isc_event_counts(PISC_STATUS status_vector, short buffer_length, char * event_buffer
		, char * result_buffer);
	int __fastcall isc_cancel_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		);
	int __fastcall isc_que_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		, short length, char * event_buffer, TISC_CALLBACK event_function, void * event_function_arg);
	void __fastcall isc_decode_date(PISC_QUAD ib_date, PCTimeStructure tm_date);
	void __fastcall isc_encode_date(PCTimeStructure tm_date, PISC_QUAD ib_date);
	int __fastcall isc_vax_integer(char * buffer, short length);
	void __fastcall isc_decode_sql_date(PISC_DATE ib_date, PCTimeStructure tm_date);
	void __fastcall isc_decode_sql_time(PISC_TIME ib_time, PCTimeStructure tm_date);
	void __fastcall isc_decode_timestamp(PISC_TIMESTAMP ib_timestamp, PCTimeStructure tm_date);
	void __fastcall isc_encode_sql_date(PCTimeStructure tm_date, PISC_DATE ib_date);
	void __fastcall isc_encode_sql_time(PCTimeStructure tm_date, PISC_TIME ib_time);
	void __fastcall isc_encode_timestamp(PCTimeStructure tm_date, PISC_TIMESTAMP ib_timestamp);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZInterbase5PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZInterbase5PlainDriver;	/* Zplaininterbasedriver::IZInterbase5PlainDriver */
	
public:
	operator IZInterbase5PlainDriver*(void) { return (IZInterbase5PlainDriver*)&__IZInterbase5PlainDriver; }
		
	operator IZInterbasePlainDriver*(void) { return (IZInterbasePlainDriver*)&__IZInterbase5PlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZInterbase5PlainDriver; }
	
};


__interface IZFirebird10PlainDriver;
typedef System::DelphiInterface<IZFirebird10PlainDriver> _di_IZFirebird10PlainDriver;
__interface INTERFACE_UUID("{AFCC45CF-CF6D-499B-8EC2-5C1737A59E30}") IZFirebird10PlainDriver  : public IZInterbasePlainDriver 
	
{
	
};

class DELPHICLASS TZFirebird10PlainDriver;
class PASCALIMPLEMENTATION TZFirebird10PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZFirebird10PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	int __fastcall isc_attach_database(PISC_STATUS status_vector, short db_name_length, char * db_name, 
		PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer);
	int __fastcall isc_detach_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_drop_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_database_info(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, short item_list_buffer_length
		, char * item_list_buffer, short result_buffer_length, char * result_buffer);
	int __fastcall isc_array_gen_sdl(PISC_STATUS status_vector, PISC_ARRAY_DESC isc_array_desc, PShort 
		isc_arg3, char * isc_arg4, PShort isc_arg5);
	int __fastcall isc_array_get_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * dest_array, int slice_length)
		;
	int __fastcall isc_array_lookup_bounds(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_lookup_desc(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_set_desc(PISC_STATUS status_vector, char * table_name, char * column_name, 
		PShort sql_dtype, PShort sql_length, PShort sql_dimensions, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_put_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * source_array, PISC_LONG slice_length
		);
	int __fastcall isc_free(char * isc_arg1);
	int __fastcall isc_sqlcode(PISC_STATUS status_vector);
	void __fastcall isc_sql_interprete(short sqlcode, char * buffer, short buffer_length);
	int __fastcall isc_interprete(char * buffer, PPISC_STATUS status_vector);
	int __fastcall isc_start_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_DB_HANDLE db_handle, Word tpb_length, char * tpb_address);
	int __fastcall isc_start_multiple(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_TEB teb_vector_address);
	int __fastcall isc_rollback_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_rollback_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_dsql_allocate_statement(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_alloc_statement2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_describe(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_describe_bind(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute2(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda);
	int __fastcall isc_dsql_execute_immediate(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_fetch(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_free_statement(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		options);
	int __fastcall isc_dsql_prepare(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_set_cursor_name(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, char * 
		cursor_name, Word _type);
	int __fastcall isc_dsql_sql_info(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, short item_length
		, char * items, short buffer_length, char * buffer);
	int __fastcall isc_open_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE tran_handle
		, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_buffer);
	int __fastcall isc_create_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_address
		);
	PISC_STATUS __fastcall isc_blob_info(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, short 
		item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		);
	int __fastcall isc_close_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_cancel_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_get_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Zcompatibility::PWord 
		actual_seg_length, Word seg_buffer_length, char * seg_buffer);
	int __fastcall isc_put_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Word seg_buffer_len
		, char * seg_buffer);
	int __fastcall isc_event_block(PPChar event_buffer, PPChar result_buffer, Word id_count, const char * 
		* event_list, const int event_list_Size);
	void __fastcall isc_event_counts(PISC_STATUS status_vector, short buffer_length, char * event_buffer
		, char * result_buffer);
	int __fastcall isc_cancel_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		);
	int __fastcall isc_que_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		, short length, char * event_buffer, TISC_CALLBACK event_function, void * event_function_arg);
	void __fastcall isc_decode_date(PISC_QUAD ib_date, PCTimeStructure tm_date);
	void __fastcall isc_encode_date(PCTimeStructure tm_date, PISC_QUAD ib_date);
	void __fastcall isc_decode_sql_date(PISC_DATE ib_date, PCTimeStructure tm_date);
	void __fastcall isc_decode_sql_time(PISC_TIME ib_time, PCTimeStructure tm_date);
	void __fastcall isc_decode_timestamp(PISC_TIMESTAMP ib_timestamp, PCTimeStructure tm_date);
	void __fastcall isc_encode_sql_date(PCTimeStructure tm_date, PISC_DATE ib_date);
	void __fastcall isc_encode_sql_time(PCTimeStructure tm_date, PISC_TIME ib_time);
	void __fastcall isc_encode_timestamp(PCTimeStructure tm_date, PISC_TIMESTAMP ib_timestamp);
	int __fastcall isc_vax_integer(char * buffer, short length);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZFirebird10PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZFirebird10PlainDriver;	/* Zplaininterbasedriver::IZFirebird10PlainDriver */
	
public:
	operator IZFirebird10PlainDriver*(void) { return (IZFirebird10PlainDriver*)&__IZFirebird10PlainDriver; }
		
	operator IZInterbasePlainDriver*(void) { return (IZInterbasePlainDriver*)&__IZFirebird10PlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZFirebird10PlainDriver; }
	
};


__interface IZFirebird15PlainDriver;
typedef System::DelphiInterface<IZFirebird15PlainDriver> _di_IZFirebird15PlainDriver;
__interface INTERFACE_UUID("{AFCC45CF-CF6D-499B-8EC2-5C1737A59E30}") IZFirebird15PlainDriver  : public IZInterbasePlainDriver 
	
{
	
};

class DELPHICLASS TZFirebird15PlainDriver;
class PASCALIMPLEMENTATION TZFirebird15PlainDriver : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
public:
	__fastcall TZFirebird15PlainDriver(void);
	AnsiString __fastcall GetProtocol();
	AnsiString __fastcall GetDescription();
	void __fastcall Initialize(void);
	int __fastcall isc_attach_database(PISC_STATUS status_vector, short db_name_length, char * db_name, 
		PISC_DB_HANDLE db_handle, short parm_buffer_length, char * parm_buffer);
	int __fastcall isc_detach_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_drop_database(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle);
	int __fastcall isc_database_info(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, short item_list_buffer_length
		, char * item_list_buffer, short result_buffer_length, char * result_buffer);
	int __fastcall isc_array_gen_sdl(PISC_STATUS status_vector, PISC_ARRAY_DESC isc_array_desc, PShort 
		isc_arg3, char * isc_arg4, PShort isc_arg5);
	int __fastcall isc_array_get_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * dest_array, int slice_length)
		;
	int __fastcall isc_array_lookup_bounds(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_lookup_desc(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, char * table_name, char * column_name, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_set_desc(PISC_STATUS status_vector, char * table_name, char * column_name, 
		PShort sql_dtype, PShort sql_length, PShort sql_dimensions, PISC_ARRAY_DESC descriptor);
	int __fastcall isc_array_put_slice(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		trans_handle, PISC_QUAD array_id, PISC_ARRAY_DESC descriptor, void * source_array, PISC_LONG slice_length
		);
	int __fastcall isc_free(char * isc_arg1);
	int __fastcall isc_sqlcode(PISC_STATUS status_vector);
	void __fastcall isc_sql_interprete(short sqlcode, char * buffer, short buffer_length);
	int __fastcall isc_interprete(char * buffer, PPISC_STATUS status_vector);
	int __fastcall isc_start_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_DB_HANDLE db_handle, Word tpb_length, char * tpb_address);
	int __fastcall isc_start_multiple(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, short db_handle_count
		, PISC_TEB teb_vector_address);
	int __fastcall isc_rollback_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_rollback_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_retaining(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_commit_transaction(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle);
	int __fastcall isc_dsql_allocate_statement(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_alloc_statement2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_STMT_HANDLE 
		stmt_handle);
	int __fastcall isc_dsql_describe(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_describe_bind(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_execute2(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word dialect, PXSQLDA in_xsqlda, PXSQLDA out_xsqlda);
	int __fastcall isc_dsql_execute_immediate(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_fetch(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word dialect
		, PXSQLDA xsqlda);
	int __fastcall isc_dsql_free_statement(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, Word 
		options);
	int __fastcall isc_dsql_prepare(PISC_STATUS status_vector, PISC_TR_HANDLE tran_handle, PISC_STMT_HANDLE 
		stmt_handle, Word length, char * statement, Word dialect, PXSQLDA xsqlda);
	int __fastcall isc_dsql_set_cursor_name(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, char * 
		cursor_name, Word _type);
	int __fastcall isc_dsql_sql_info(PISC_STATUS status_vector, PISC_STMT_HANDLE stmt_handle, short item_length
		, char * items, short buffer_length, char * buffer);
	int __fastcall isc_open_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE tran_handle
		, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_buffer);
	int __fastcall isc_create_blob2(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_TR_HANDLE 
		tran_handle, PISC_BLOB_HANDLE blob_handle, PISC_QUAD blob_id, short bpb_length, char * bpb_address
		);
	PISC_STATUS __fastcall isc_blob_info(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, short 
		item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * result_buffer
		);
	int __fastcall isc_close_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_cancel_blob(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle);
	int __fastcall isc_get_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Zcompatibility::PWord 
		actual_seg_length, Word seg_buffer_length, char * seg_buffer);
	int __fastcall isc_put_segment(PISC_STATUS status_vector, PISC_BLOB_HANDLE blob_handle, Word seg_buffer_len
		, char * seg_buffer);
	int __fastcall isc_event_block(PPChar event_buffer, PPChar result_buffer, Word id_count, const char * 
		* event_list, const int event_list_Size);
	void __fastcall isc_event_counts(PISC_STATUS status_vector, short buffer_length, char * event_buffer
		, char * result_buffer);
	int __fastcall isc_cancel_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		);
	int __fastcall isc_que_events(PISC_STATUS status_vector, PISC_DB_HANDLE db_handle, PISC_LONG event_id
		, short length, char * event_buffer, TISC_CALLBACK event_function, void * event_function_arg);
	void __fastcall isc_decode_date(PISC_QUAD ib_date, PCTimeStructure tm_date);
	void __fastcall isc_encode_date(PCTimeStructure tm_date, PISC_QUAD ib_date);
	void __fastcall isc_decode_sql_date(PISC_DATE ib_date, PCTimeStructure tm_date);
	void __fastcall isc_decode_sql_time(PISC_TIME ib_time, PCTimeStructure tm_date);
	void __fastcall isc_decode_timestamp(PISC_TIMESTAMP ib_timestamp, PCTimeStructure tm_date);
	void __fastcall isc_encode_sql_date(PCTimeStructure tm_date, PISC_DATE ib_date);
	void __fastcall isc_encode_sql_time(PCTimeStructure tm_date, PISC_TIME ib_time);
	void __fastcall isc_encode_timestamp(PCTimeStructure tm_date, PISC_TIMESTAMP ib_timestamp);
	int __fastcall isc_vax_integer(char * buffer, short length);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZFirebird15PlainDriver(void) { }
	#pragma option pop
	
private:
	void *__IZFirebird15PlainDriver;	/* Zplaininterbasedriver::IZFirebird15PlainDriver */
	
public:
	operator IZFirebird15PlainDriver*(void) { return (IZFirebird15PlainDriver*)&__IZFirebird15PlainDriver; }
		
	operator IZInterbasePlainDriver*(void) { return (IZInterbasePlainDriver*)&__IZFirebird15PlainDriver; }
		
	operator IZPlainDriver*(void) { return (IZPlainDriver*)&__IZFirebird15PlainDriver; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word IBLocalBufferLength = 0x200;
static const Word IBBigLocalBufferLength = 0x400;
static const Word IBHugeLocalBufferLength = 0x5000;
static const Shortint ISC_NULL = 0xffffffff;
static const Shortint ISC_NOTNULL = 0x0;
static const Shortint ISC_TRUE = 0x1;
static const Shortint ISC_FALSE = 0x0;
static const Shortint DSQL_CLOSE = 0x1;
static const Shortint DSQL_DROP = 0x2;
static const Shortint SQLDA_VERSION1 = 0x1;
static const Shortint SQLDA_VERSION2 = 0x2;
static const Shortint SQL_DIALECT_V5 = 0x1;
static const Shortint SQL_DIALECT_V6 = 0x2;
static const Shortint SQL_DIALECT_CURRENT = 0x2;
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
static const Word SQL_BOOLEAN = 0x24e;
static const Word SQL_DATE = 0x1fe;
static const Shortint RDB_VARCHAR = 0x25;
static const Shortint RDB_VARCHAR2 = 0x26;
static const Shortint RDB_CSTRING = 0x28;
static const Shortint RDB_CSTRING2 = 0x29;
static const Shortint RDB_CHAR = 0xe;
static const Shortint RDB_CHAR2 = 0xf;
static const Shortint RDB_D_FLOAT = 0xb;
static const Shortint RDB_DOUBLE = 0x1b;
static const Shortint RDB_FLOAT = 0xa;
static const Shortint RDB_INT64 = 0x10;
static const Shortint RDB_QUAD = 0x9;
static const Shortint RDB_BLOB_ID = 0x2d;
static const Shortint RDB_INTEGER = 0x8;
static const Shortint RDB_SMALLINT = 0x7;
static const Shortint RDB_DATE = 0xc;
static const Shortint RDB_TIME = 0xd;
static const Shortint RDB_TIMESTAMP = 0x23;
static const Shortint RDB_BOOLEAN = 0x11;
static const Word RDB_BLOB = 0x105;
static const Shortint CS_NONE = 0x0;
static const Shortint CS_BINARY = 0x1;
static const Shortint CS_ASCII = 0x2;
static const Shortint CS_UNICODE_FSS = 0x3;
static const Shortint CS_METADATA = 0x3;
static const Shortint RDB_BLOB_NONE = 0x0;
static const Shortint RDB_BLOB_TEXT = 0x1;
static const Shortint RDB_BLOB_BLR = 0x2;
static const Shortint RDB_BLOB_ACL = 0x3;
static const Shortint RDB_BLOB_RESERVED = 0x4;
static const Shortint RDB_BLOB_ENCODED = 0x5;
static const Shortint RDB_BLOB_DESCRIPTION = 0x6;
static const Shortint RDB_NUMBERS_NONE = 0x0;
static const Shortint RDB_NUMBERS_NUMERIC = 0x1;
static const Shortint RDB_NUMBERS_DECIMAL = 0x2;
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
static const Shortint isc_info_blob_num_segments = 0x4;
static const Shortint isc_info_blob_max_segment = 0x5;
static const Shortint isc_info_blob_total_length = 0x6;
static const Shortint isc_info_blob_type = 0x7;
static const int isc_segment = 0x1400002e;
static const int isc_segstr_eof = 0x1400002f;
static const int isc_lock_conflict = 0x14000019;
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
static const Shortint isc_bpb_type_segmented = 0x0;
static const Shortint isc_bpb_type_stream = 0x1;
static const Shortint isc_info_end = 0x1;
static const Shortint isc_info_truncated = 0x2;
static const Shortint isc_info_error = 0x3;
static const Shortint isc_info_data_not_ready = 0x4;
static const Shortint isc_info_flag_end = 0x7f;
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
extern PACKAGE int __fastcall XSQLDA_LENGTH(int Value);

}	/* namespace Zplaininterbasedriver */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplaininterbasedriver;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainInterbaseDriver
