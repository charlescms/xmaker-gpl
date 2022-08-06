// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainFirebird15.pas' rev: 5.00

#ifndef ZPlainFirebird15HPP
#define ZPlainFirebird15HPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZPlainInterbaseDriver.hpp>	// Pascal unit
#include <ZPlainLoader.hpp>	// Pascal unit
#include <ZCompatibility.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainfirebird15
{
//-- type declarations -------------------------------------------------------
typedef int __stdcall (*Tisc_attach_database)(Zplaininterbasedriver::PISC_STATUS status_vector, short 
	db_name_length, char * db_name, Zplaininterbasedriver::PISC_DB_HANDLE db_handle, short parm_buffer_length
	, char * parm_buffer);

typedef int __stdcall (*Tisc_detach_database)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle);

typedef int __stdcall (*Tisc_drop_database)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle);

typedef int __stdcall (*Tisc_database_info)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, short item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * 
	result_buffer);

typedef int __stdcall (*Tisc_array_gen_sdl)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_ARRAY_DESC 
	isc_array_desc, Zplaininterbasedriver::PShort isc_arg3, char * isc_arg4, Zplaininterbasedriver::PShort 
	isc_arg5);

typedef int __stdcall (*Tisc_array_get_slice)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_TR_HANDLE trans_handle, Zplaininterbasedriver::PISC_QUAD array_id
	, Zplaininterbasedriver::PISC_ARRAY_DESC descriptor, void * dest_array, int slice_length);

typedef int __stdcall (*Tisc_array_lookup_bounds)(Zplaininterbasedriver::PISC_STATUS status_vector, 
	Zplaininterbasedriver::PISC_DB_HANDLE db_handle, Zplaininterbasedriver::PISC_TR_HANDLE trans_handle
	, char * table_name, char * column_name, Zplaininterbasedriver::PISC_ARRAY_DESC descriptor);

typedef int __stdcall (*Tisc_array_lookup_desc)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_TR_HANDLE trans_handle, char * table_name, char * column_name
	, Zplaininterbasedriver::PISC_ARRAY_DESC descriptor);

typedef int __stdcall (*Tisc_array_set_desc)(Zplaininterbasedriver::PISC_STATUS status_vector, char * 
	table_name, char * column_name, Zplaininterbasedriver::PShort sql_dtype, Zplaininterbasedriver::PShort 
	sql_length, Zplaininterbasedriver::PShort sql_dimensions, Zplaininterbasedriver::PISC_ARRAY_DESC descriptor
	);

typedef int __stdcall (*Tisc_array_put_slice)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_TR_HANDLE trans_handle, Zplaininterbasedriver::PISC_QUAD array_id
	, Zplaininterbasedriver::PISC_ARRAY_DESC descriptor, void * source_array, Zplaininterbasedriver::PISC_LONG 
	slice_length);

typedef int __stdcall (*Tisc_free)(char * isc_arg1);

typedef int __stdcall (*Tisc_sqlcode)(Zplaininterbasedriver::PISC_STATUS status_vector);

typedef void __stdcall (*Tisc_sql_interprete)(short sqlcode, char * buffer, short buffer_length);

typedef int __stdcall (*Tisc_interprete)(char * buffer, Zplaininterbasedriver::PPISC_STATUS status_vector
	);

typedef int __stdcall (*Tisc_start_transaction)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle, short db_handle_count, Zplaininterbasedriver::PISC_DB_HANDLE db_handle, Word tpb_length
	, char * tpb_address);

typedef int __stdcall (*Tisc_start_multiple)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle, short db_handle_count, Zplaininterbasedriver::PISC_TEB teb_vector_address);

typedef int __stdcall (*Tisc_rollback_transaction)(Zplaininterbasedriver::PISC_STATUS status_vector, 
	Zplaininterbasedriver::PISC_TR_HANDLE tran_handle);

typedef int __stdcall (*Tisc_rollback_retaining)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle);

typedef int __stdcall (*Tisc_commit_retaining)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle);

typedef int __stdcall (*Tisc_commit_transaction)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle);

typedef int __stdcall (*Tisc_dsql_allocate_statement)(Zplaininterbasedriver::PISC_STATUS status_vector
	, Zplaininterbasedriver::PISC_DB_HANDLE db_handle, Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle
	);

typedef int __stdcall (*Tisc_dsql_alloc_statement2)(Zplaininterbasedriver::PISC_STATUS status_vector
	, Zplaininterbasedriver::PISC_DB_HANDLE db_handle, Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle
	);

typedef int __stdcall (*Tisc_dsql_describe)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_STMT_HANDLE 
	stmt_handle, Word dialect, Zplaininterbasedriver::PXSQLDA xsqlda);

typedef int __stdcall (*Tisc_dsql_describe_bind)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_STMT_HANDLE 
	stmt_handle, Word dialect, Zplaininterbasedriver::PXSQLDA xsqlda);

typedef int __stdcall (*Tisc_dsql_execute)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle, Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle, Word dialect, Zplaininterbasedriver::PXSQLDA 
	xsqlda);

typedef int __stdcall (*Tisc_dsql_execute2)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle, Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle, Word dialect, Zplaininterbasedriver::PXSQLDA 
	in_xsqlda, Zplaininterbasedriver::PXSQLDA out_xsqlda);

typedef int __stdcall (*Tisc_dsql_execute_immediate)(Zplaininterbasedriver::PISC_STATUS status_vector
	, Zplaininterbasedriver::PISC_DB_HANDLE db_handle, Zplaininterbasedriver::PISC_TR_HANDLE tran_handle
	, Word length, char * statement, Word dialect, Zplaininterbasedriver::PXSQLDA xsqlda);

typedef int __stdcall (*Tisc_dsql_fetch)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_STMT_HANDLE 
	stmt_handle, Word dialect, Zplaininterbasedriver::PXSQLDA xsqlda);

typedef int __stdcall (*Tisc_dsql_free_statement)(Zplaininterbasedriver::PISC_STATUS status_vector, 
	Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle, Word options);

typedef int __stdcall (*Tisc_dsql_prepare)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_TR_HANDLE 
	tran_handle, Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle, Word length, char * statement, Word 
	dialect, Zplaininterbasedriver::PXSQLDA xsqlda);

typedef int __stdcall (*Tisc_dsql_set_cursor_name)(Zplaininterbasedriver::PISC_STATUS status_vector, 
	Zplaininterbasedriver::PISC_STMT_HANDLE stmt_handle, char * cursor_name, Word _type);

typedef int __stdcall (*Tisc_dsql_sql_info)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_STMT_HANDLE 
	stmt_handle, short item_length, char * items, short buffer_length, char * buffer);

typedef int __stdcall (*Tisc_open_blob2)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_TR_HANDLE tran_handle, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle, Zplaininterbasedriver::PISC_QUAD blob_id, short bpb_length, char * bpb_buffer);

typedef int __stdcall (*Tisc_create_blob2)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_TR_HANDLE tran_handle, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle, Zplaininterbasedriver::PISC_QUAD blob_id, short bpb_length, char * bpb_address);

typedef int __stdcall (*Tisc_blob_info)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle, short item_list_buffer_length, char * item_list_buffer, short result_buffer_length, char * 
	result_buffer);

typedef int __stdcall (*Tisc_close_blob)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle);

typedef int __stdcall (*Tisc_cancel_blob)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle);

typedef int __stdcall (*Tisc_get_segment)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle, Zcompatibility::PWord actual_seg_length, Word seg_buffer_length, char * seg_buffer);

typedef int __stdcall (*Tisc_put_segment)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_BLOB_HANDLE 
	blob_handle, Word seg_buffer_len, char * seg_buffer);

typedef int __stdcall (*Tisc_event_block)(Zplaininterbasedriver::PPChar event_buffer, Zplaininterbasedriver::PPChar 
	result_buffer, Word id_count, const char * * event_list, const int event_list_Size);

typedef void __stdcall (*Tisc_event_counts)(Zplaininterbasedriver::PISC_STATUS status_vector, short 
	buffer_length, char * event_buffer, char * result_buffer);

typedef int __stdcall (*Tisc_cancel_events)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_LONG event_id);

typedef int __stdcall (*Tisc_que_events)(Zplaininterbasedriver::PISC_STATUS status_vector, Zplaininterbasedriver::PISC_DB_HANDLE 
	db_handle, Zplaininterbasedriver::PISC_LONG event_id, short length, char * event_buffer, Zplaininterbasedriver::TISC_CALLBACK 
	event_function, void * event_function_arg);

typedef void __stdcall (*Tisc_decode_date)(Zplaininterbasedriver::PISC_QUAD ib_date, Zplaininterbasedriver::PCTimeStructure 
	tm_date);

typedef void __stdcall (*Tisc_encode_date)(Zplaininterbasedriver::PCTimeStructure tm_date, Zplaininterbasedriver::PISC_QUAD 
	ib_date);

typedef void __stdcall (*Tisc_decode_sql_date)(Zplaininterbasedriver::PISC_DATE ib_date, Zplaininterbasedriver::PCTimeStructure 
	tm_date);

typedef void __stdcall (*Tisc_decode_sql_time)(Zplaininterbasedriver::PISC_TIME ib_time, Zplaininterbasedriver::PCTimeStructure 
	tm_date);

typedef void __stdcall (*Tisc_decode_timestamp)(Zplaininterbasedriver::PISC_TIMESTAMP ib_timestamp, 
	Zplaininterbasedriver::PCTimeStructure tm_date);

typedef void __stdcall (*Tisc_encode_sql_date)(Zplaininterbasedriver::PCTimeStructure tm_date, Zplaininterbasedriver::PISC_DATE 
	ib_date);

typedef void __stdcall (*Tisc_encode_sql_time)(Zplaininterbasedriver::PCTimeStructure tm_date, Zplaininterbasedriver::PISC_TIME 
	ib_time);

typedef void __stdcall (*Tisc_encode_timestamp)(Zplaininterbasedriver::PCTimeStructure tm_date, Zplaininterbasedriver::PISC_TIMESTAMP 
	ib_timestamp);

typedef int __stdcall (*Tisc_vax_integer)(char * buffer, short length);

//-- var, const, procedure ---------------------------------------------------
#define WINDOWS_DLL_LOCATION "fbclient.dll"
#define LINUX_DLL_LOCATION "libfbembed.so"
#define LINUX_IB_CRYPT_LOCATION "libcrypt.so"
extern PACKAGE Tisc_attach_database isc_attach_database;
extern PACKAGE Tisc_detach_database isc_detach_database;
extern PACKAGE Tisc_drop_database isc_drop_database;
extern PACKAGE Tisc_database_info isc_database_info;
extern PACKAGE Tisc_free isc_free;
extern PACKAGE Tisc_sqlcode isc_sqlcode;
extern PACKAGE Tisc_sql_interprete isc_sql_interprete;
extern PACKAGE Tisc_interprete isc_interprete;
extern PACKAGE Tisc_start_transaction isc_start_transaction;
extern PACKAGE Tisc_start_multiple isc_start_multiple;
extern PACKAGE Tisc_rollback_transaction isc_rollback_transaction;
extern PACKAGE Tisc_rollback_retaining isc_rollback_retaining;
extern PACKAGE Tisc_commit_transaction isc_commit_transaction;
extern PACKAGE Tisc_commit_retaining isc_commit_retaining;
extern PACKAGE Tisc_dsql_allocate_statement isc_dsql_allocate_statement;
extern PACKAGE Tisc_dsql_alloc_statement2 isc_dsql_alloc_statement2;
extern PACKAGE Tisc_dsql_describe isc_dsql_describe;
extern PACKAGE Tisc_dsql_describe_bind isc_dsql_describe_bind;
extern PACKAGE Tisc_dsql_execute isc_dsql_execute;
extern PACKAGE Tisc_dsql_execute2 isc_dsql_execute2;
extern PACKAGE Tisc_dsql_execute_immediate isc_dsql_execute_immediate;
extern PACKAGE Tisc_dsql_fetch isc_dsql_fetch;
extern PACKAGE Tisc_dsql_free_statement isc_dsql_free_statement;
extern PACKAGE Tisc_dsql_prepare isc_dsql_prepare;
extern PACKAGE Tisc_dsql_set_cursor_name isc_dsql_set_cursor_name;
extern PACKAGE Tisc_dsql_sql_info isc_dsql_sql_info;
extern PACKAGE Tisc_array_gen_sdl isc_array_gen_sdl;
extern PACKAGE Tisc_array_get_slice isc_array_get_slice;
extern PACKAGE Tisc_array_lookup_bounds isc_array_lookup_bounds;
extern PACKAGE Tisc_array_lookup_desc isc_array_lookup_desc;
extern PACKAGE Tisc_array_set_desc isc_array_set_desc;
extern PACKAGE Tisc_array_put_slice isc_array_put_slice;
extern PACKAGE Tisc_open_blob2 isc_open_blob2;
extern PACKAGE Tisc_create_blob2 isc_create_blob2;
extern PACKAGE Tisc_blob_info isc_blob_info;
extern PACKAGE Tisc_close_blob isc_close_blob;
extern PACKAGE Tisc_cancel_blob isc_cancel_blob;
extern PACKAGE Tisc_get_segment isc_get_segment;
extern PACKAGE Tisc_put_segment isc_put_segment;
extern PACKAGE Tisc_que_events isc_que_events;
extern PACKAGE Tisc_event_counts isc_event_counts;
extern PACKAGE Tisc_event_block isc_event_block;
extern PACKAGE Tisc_cancel_events isc_cancel_events;
extern PACKAGE Tisc_encode_date isc_encode_date;
extern PACKAGE Tisc_decode_date isc_decode_date;
extern PACKAGE Tisc_vax_integer isc_vax_integer;
extern PACKAGE Tisc_encode_sql_date isc_encode_sql_date;
extern PACKAGE Tisc_decode_sql_date isc_decode_sql_date;
extern PACKAGE Tisc_encode_sql_time isc_encode_sql_time;
extern PACKAGE Tisc_decode_sql_time isc_decode_sql_time;
extern PACKAGE Tisc_encode_timestamp isc_encode_timestamp;
extern PACKAGE Tisc_decode_timestamp isc_decode_timestamp;
extern PACKAGE Zplainloader::TZNativeLibraryLoader* LibraryLoader;

}	/* namespace Zplainfirebird15 */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainfirebird15;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainFirebird15
