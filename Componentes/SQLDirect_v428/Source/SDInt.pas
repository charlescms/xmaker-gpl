
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{	Interbase API(v.5,6) Interface Unit		}
{       		                                }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}
{$I SqlDir.inc}
unit SDInt {$IFDEF SD_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, SyncObjs,
{$IFDEF SD_VCL6}
  FmtBcd,
{$ENDIF}
{$IFDEF SD_CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  SDConsts, SDCommon;

const
  METADATALEN	= 32;	// name length + space for NULL for IB v.5-6

{********************************************************************
**
**	iberror.h - ISC error codes
**
********************************************************************}
const
  isc_arith_except               =  335544321;
  isc_bad_dbkey                  =  335544322;
  isc_bad_db_format              =  335544323;
  isc_bad_db_handle              =  335544324;
  isc_bad_dpb_content            =  335544325;
  isc_bad_dpb_form               =  335544326;
  isc_bad_req_handle             =  335544327;
  isc_bad_segstr_handle          =  335544328;
  isc_bad_segstr_id              =  335544329;
  isc_bad_tpb_content            =  335544330;
  isc_bad_tpb_form               =  335544331;
  isc_bad_trans_handle           =  335544332;
  isc_bug_check                  =  335544333;
  isc_convert_error              =  335544334;
  isc_db_corrupt                 =  335544335;
  isc_deadlock                   =  335544336;
  isc_excess_trans               =  335544337;
  isc_from_no_match              =  335544338;
  isc_infinap                    =  335544339;
  isc_infona                     =  335544340;
  isc_infunk                     =  335544341;
  isc_integ_fail                 =  335544342;
  isc_invalid_blr                =  335544343;
  isc_io_error                   =  335544344;
  isc_lock_conflict              =  335544345;
  isc_metadata_corrupt           =  335544346;
  isc_not_valid                  =  335544347;
  isc_no_cur_rec                 =  335544348;
  isc_no_dup                     =  335544349;
  isc_no_finish                  =  335544350;
  isc_no_meta_update             =  335544351;
  isc_no_priv                    =  335544352;
  isc_no_recon                   =  335544353;
  isc_no_record                  =  335544354;
  isc_no_segstr_close            =  335544355;
  isc_obsolete_metadata          =  335544356;
  isc_open_trans                 =  335544357;
  isc_port_len                   =  335544358;
  isc_read_only_field            =  335544359;
  isc_read_only_rel              =  335544360;
  isc_read_only_trans            =  335544361;
  isc_read_only_view             =  335544362;
  isc_req_no_trans               =  335544363;
  isc_req_sync                   =  335544364;
  isc_req_wrong_db               =  335544365;
  isc_segment                    =  335544366;
  isc_segstr_eof                 =  335544367;
  isc_segstr_no_op               =  335544368;
  isc_segstr_no_read             =  335544369;
  isc_segstr_no_trans            =  335544370;
  isc_segstr_no_write            =  335544371;
  isc_segstr_wrong_db            =  335544372;
  isc_sys_request                =  335544373;
  isc_stream_eof                 =  335544374;
  isc_unavailable                =  335544375;
  isc_unres_rel                  =  335544376;
  isc_uns_ext                    =  335544377;
  isc_wish_list                  =  335544378;
  isc_wrong_ods                  =  335544379;
  isc_wronumarg                  =  335544380;
  isc_imp_exc                    =  335544381;
  isc_random                     =  335544382;
  isc_fatal_conflict             =  335544383;
  isc_badblk                     =  335544384;
  isc_invpoolcl                  =  335544385;
  isc_nopoolids                  =  335544386;
  isc_relbadblk                  =  335544387;
  isc_blktoobig                  =  335544388;
  isc_bufexh                     =  335544389;
  isc_syntaxerr                  =  335544390;
  isc_bufinuse                   =  335544391;
  isc_bdbincon                   =  335544392;
  isc_reqinuse                   =  335544393;
  isc_badodsver                  =  335544394;
  isc_relnotdef                  =  335544395;
  isc_fldnotdef                  =  335544396;
  isc_dirtypage                  =  335544397;
  isc_waifortra                  =  335544398;
  isc_doubleloc                  =  335544399;
  isc_nodnotfnd                  =  335544400;
  isc_dupnodfnd                  =  335544401;
  isc_locnotmar                  =  335544402;
  isc_badpagtyp                  =  335544403;
  isc_corrupt                    =  335544404;
  isc_badpage                    =  335544405;
  isc_badindex                   =  335544406;
  isc_dbbnotzer                  =  335544407;
  isc_tranotzer                  =  335544408;
  isc_trareqmis                  =  335544409;
  isc_badhndcnt                  =  335544410;
  isc_wrotpbver                  =  335544411;
  isc_wroblrver                  =  335544412;
  isc_wrodpbver                  =  335544413;
  isc_blobnotsup                 =  335544414;
  isc_badrelation                =  335544415;
  isc_nodetach                   =  335544416;
  isc_notremote                  =  335544417;
  isc_trainlim                   =  335544418;
  isc_notinlim                   =  335544419;
  isc_traoutsta                  =  335544420;
  isc_connect_reject             =  335544421;
  isc_dbfile                     =  335544422;
  isc_orphan                     =  335544423;
  isc_no_lock_mgr                =  335544424;
  isc_ctxinuse                   =  335544425;
  isc_ctxnotdef                  =  335544426;
  isc_datnotsup                  =  335544427;
  isc_badmsgnum                  =  335544428;
  isc_badparnum                  =  335544429;
  isc_virmemexh                  =  335544430;
  isc_blocking_signal            =  335544431;
  isc_lockmanerr                 =  335544432;
  isc_journerr                   =  335544433;
  isc_keytoobig                  =  335544434;
  isc_nullsegkey                 =  335544435;
  isc_sqlerr                     =  335544436;
  isc_wrodynver                  =  335544437;
  isc_funnotdef                  =  335544438;
  isc_funmismat                  =  335544439;
  isc_bad_msg_vec                =  335544440;
  isc_bad_detach                 =  335544441;
  isc_noargacc_read              =  335544442;
  isc_noargacc_write             =  335544443;
  isc_read_only                  =  335544444;
  isc_ext_err                    =  335544445;
  isc_non_updatable              =  335544446;
  isc_no_rollback                =  335544447;
  isc_bad_sec_info               =  335544448;
  isc_invalid_sec_info           =  335544449;
  isc_misc_interpreted           =  335544450;
  isc_update_conflict            =  335544451;
  isc_unlicensed                 =  335544452;
  isc_obj_in_use                 =  335544453;
  isc_nofilter                   =  335544454;
  isc_shadow_accessed            =  335544455;
  isc_invalid_sdl                =  335544456;
  isc_out_of_bounds              =  335544457;
  isc_invalid_dimension          =  335544458;
  isc_rec_in_limbo               =  335544459;
  isc_shadow_missing             =  335544460;
  isc_cant_validate              =  335544461;
  isc_cant_start_journal         =  335544462;
  isc_gennotdef                  =  335544463;
  isc_cant_start_logging         =  335544464;
  isc_bad_segstr_type            =  335544465;
  isc_foreign_key                =  335544466;
  isc_high_minor                 =  335544467;
  isc_tra_state                  =  335544468;
  isc_trans_invalid              =  335544469;
  isc_buf_invalid                =  335544470;
  isc_indexnotdefined            =  335544471;
  isc_login                      =  335544472;
  isc_invalid_bookmark           =  335544473;
  isc_bad_lock_level             =  335544474;
  isc_relation_lock              =  335544475;
  isc_record_lock                =  335544476;
  isc_max_idx                    =  335544477;
  isc_jrn_enable                 =  335544478;
  isc_old_failure                =  335544479;
  isc_old_in_progress            =  335544480;
  isc_old_no_space               =  335544481;
  isc_no_wal_no_jrn              =  335544482;
  isc_num_old_files              =  335544483;
  isc_wal_file_open              =  335544484;
  isc_bad_stmt_handle            =  335544485;
  isc_wal_failure                =  335544486;
  isc_walw_err                   =  335544487;
  isc_logh_small                 =  335544488;
  isc_logh_inv_version           =  335544489;
  isc_logh_open_flag             =  335544490;
  isc_logh_open_flag2            =  335544491;
  isc_logh_diff_dbname           =  335544492;
  isc_logf_unexpected_eof        =  335544493;
  isc_logr_incomplete            =  335544494;
  isc_logr_header_small          =  335544495;
  isc_logb_small                 =  335544496;
  isc_wal_illegal_attach         =  335544497;
  isc_wal_invalid_wpb            =  335544498;
  isc_wal_err_rollover           =  335544499;
  isc_no_wal                     =  335544500;
  isc_drop_wal                   =  335544501;
  isc_stream_not_defined         =  335544502;
  isc_wal_subsys_error           =  335544503;
  isc_wal_subsys_corrupt         =  335544504;
  isc_no_archive                 =  335544505;
  isc_shutinprog                 =  335544506;
  isc_range_in_use               =  335544507;
  isc_range_not_found            =  335544508;
  isc_charset_not_found          =  335544509;
  isc_lock_timeout               =  335544510;
  isc_prcnotdef                  =  335544511;
  isc_prcmismat                  =  335544512;
  isc_wal_bugcheck               =  335544513;
  isc_wal_cant_expand            =  335544514;
  isc_codnotdef                  =  335544515;
  isc_xcpnotdef                  =  335544516;
  isc_except                     =  335544517;
  isc_cache_restart              =  335544518;
  isc_bad_lock_handle            =  335544519;
  isc_jrn_present                =  335544520;
  isc_wal_err_rollover2          =  335544521;
  isc_wal_err_logwrite           =  335544522;
  isc_wal_err_jrn_comm           =  335544523;
  isc_wal_err_expansion          =  335544524;
  isc_wal_err_setup              =  335544525;
  isc_wal_err_ww_sync            =  335544526;
  isc_wal_err_ww_start           =  335544527;
  isc_shutdown                   =  335544528;
  isc_existing_priv_mod          =  335544529;
  isc_primary_key_ref            =  335544530;
  isc_primary_key_notnull        =  335544531;
  isc_ref_cnstrnt_notfound       =  335544532;
  isc_foreign_key_notfound       =  335544533;
  isc_ref_cnstrnt_update         =  335544534;
  isc_check_cnstrnt_update       =  335544535;
  isc_check_cnstrnt_del          =  335544536;
  isc_integ_index_seg_del        =  335544537;
  isc_integ_index_seg_mod        =  335544538;
  isc_integ_index_del            =  335544539;
  isc_integ_index_mod            =  335544540;
  isc_check_trig_del             =  335544541;
  isc_check_trig_update          =  335544542;
  isc_cnstrnt_fld_del            =  335544543;
  isc_cnstrnt_fld_rename         =  335544544;
  isc_rel_cnstrnt_update         =  335544545;
  isc_constaint_on_view          =  335544546;
  isc_invld_cnstrnt_type         =  335544547;
  isc_primary_key_exists         =  335544548;
  isc_systrig_update             =  335544549;
  isc_not_rel_owner              =  335544550;
  isc_grant_obj_notfound         =  335544551;
  isc_grant_fld_notfound         =  335544552;
  isc_grant_nopriv               =  335544553;
  isc_nonsql_security_rel        =  335544554;
  isc_nonsql_security_fld        =  335544555;
  isc_wal_cache_err              =  335544556;
  isc_shutfail                   =  335544557;
  isc_check_constraint           =  335544558;
  isc_bad_svc_handle             =  335544559;
  isc_shutwarn                   =  335544560;
  isc_wrospbver                  =  335544561;
  isc_bad_spb_form               =  335544562;
  isc_svcnotdef                  =  335544563;
  isc_no_jrn                     =  335544564;
  isc_transliteration_failed     =  335544565;
  isc_start_cm_for_wal           =  335544566;
  isc_wal_ovflow_log_required    =  335544567;
  isc_text_subtype               =  335544568;
  isc_dsql_error                 =  335544569;
  isc_dsql_command_err           =  335544570;
  isc_dsql_constant_err          =  335544571;
  isc_dsql_cursor_err            =  335544572;
  isc_dsql_datatype_err          =  335544573;
  isc_dsql_decl_err              =  335544574;
  isc_dsql_cursor_update_err     =  335544575;
  isc_dsql_cursor_open_err       =  335544576;
  isc_dsql_cursor_close_err      =  335544577;
  isc_dsql_field_err             =  335544578;
  isc_dsql_internal_err          =  335544579;
  isc_dsql_relation_err          =  335544580;
  isc_dsql_procedure_err         =  335544581;
  isc_dsql_request_err           =  335544582;
  isc_dsql_sqlda_err             =  335544583;
  isc_dsql_var_count_err         =  335544584;
  isc_dsql_stmt_handle           =  335544585;
  isc_dsql_function_err          =  335544586;
  isc_dsql_blob_err              =  335544587;
  isc_collation_not_found        =  335544588;
  isc_collation_not_for_charset  =  335544589;
  isc_dsql_dup_option            =  335544590;
  isc_dsql_tran_err              =  335544591;
  isc_dsql_invalid_array         =  335544592;
  isc_dsql_max_arr_dim_exceeded  =  335544593;
  isc_dsql_arr_range_error       =  335544594;
  isc_dsql_trigger_err           =  335544595;
  isc_dsql_subselect_err         =  335544596;
  isc_dsql_crdb_prepare_err      =  335544597;
  isc_specify_field_err          =  335544598;
  isc_num_field_err              =  335544599;
  isc_col_name_err               =  335544600;
  isc_where_err                  =  335544601;
  isc_table_view_err             =  335544602;
  isc_distinct_err               =  335544603;
  isc_key_field_count_err        =  335544604;
  isc_subquery_err               =  335544605;
  isc_expression_eval_err        =  335544606;
  isc_node_err                   =  335544607;
  isc_command_end_err            =  335544608;
  isc_index_name                 =  335544609;
  isc_exception_name             =  335544610;
  isc_field_name                 =  335544611;
  isc_token_err                  =  335544612;
  isc_union_err                  =  335544613;
  isc_dsql_construct_err         =  335544614;
  isc_field_aggregate_err        =  335544615;
  isc_field_ref_err              =  335544616;
  isc_order_by_err               =  335544617;
  isc_return_mode_err            =  335544618;
  isc_extern_func_err            =  335544619;
  isc_alias_conflict_err         =  335544620;
  isc_procedure_conflict_error   =  335544621;
  isc_relation_conflict_err      =  335544622;
  isc_dsql_domain_err            =  335544623;
  isc_idx_seg_err                =  335544624;
  isc_node_name_err              =  335544625;
  isc_table_name                 =  335544626;
  isc_proc_name                  =  335544627;
  isc_idx_create_err             =  335544628;
  isc_wal_shadow_err             =  335544629;
  isc_dependency                 =  335544630;
  isc_idx_key_err                =  335544631;
  isc_dsql_file_length_err       =  335544632;
  isc_dsql_shadow_number_err     =  335544633;
  isc_dsql_token_unk_err         =  335544634;
  isc_dsql_no_relation_alias     =  335544635;
  isc_indexname                  =  335544636;
  isc_no_stream_plan             =  335544637;
  isc_stream_twice               =  335544638;
  isc_stream_not_found           =  335544639;
  isc_collation_requires_text    =  335544640;
  isc_dsql_domain_not_found      =  335544641;
  isc_index_unused               =  335544642;
  isc_dsql_self_join             =  335544643;
  isc_stream_bof                 =  335544644;
  isc_stream_crack               =  335544645;
  isc_db_or_file_exists          =  335544646;
  isc_invalid_operator           =  335544647;
  isc_conn_lost                  =  335544648;
  isc_bad_checksum               =  335544649;
  isc_page_type_err              =  335544650;
  isc_ext_readonly_err           =  335544651;
  isc_sing_select_err            =  335544652;
  isc_psw_attach                 =  335544653;
  isc_psw_start_trans            =  335544654;
  isc_invalid_direction          =  335544655;
  isc_dsql_var_conflict          =  335544656;
  isc_dsql_no_blob_array         =  335544657;
  isc_dsql_base_table            =  335544658;
  isc_duplicate_base_table       =  335544659;
  isc_view_alias                 =  335544660;
  isc_index_root_page_full       =  335544661;
  isc_dsql_blob_type_unknown     =  335544662;
  isc_req_max_clones_exceeded    =  335544663;
  isc_dsql_duplicate_spec        =  335544664;
  isc_unique_key_violation       =  335544665;
  isc_srvr_version_too_old       =  335544666;
  isc_drdb_completed_with_errs   =  335544667;
  isc_dsql_procedure_use_err     =  335544668;
  isc_dsql_count_mismatch        =  335544669;
  isc_blob_idx_err               =  335544670;
  isc_array_idx_err              =  335544671;
  isc_key_field_err              =  335544672;
  isc_no_delete                  =  335544673;
  isc_del_last_field             =  335544674;
  isc_sort_err                   =  335544675;
  isc_sort_mem_err               =  335544676;
  isc_version_err                =  335544677;
  isc_inval_key_posn             =  335544678;
  isc_no_segments_err            =  335544679;
  isc_crrp_data_err              =  335544680;
  isc_rec_size_err               =  335544681;
  isc_dsql_field_ref             =  335544682;
  isc_req_depth_exceeded         =  335544683;
  isc_no_field_access            =  335544684;
  isc_no_dbkey                   =  335544685;
  isc_jrn_format_err             =  335544686;
  isc_jrn_file_full              =  335544687;
  isc_dsql_open_cursor_request   =  335544688;
  isc_ib_error                   =  335544689;
  isc_cache_redef                =  335544690;
  isc_cache_too_small            =  335544691;
  isc_log_redef                  =  335544692;
  isc_log_too_small              =  335544693;
  isc_partition_too_small        =  335544694;
  isc_partition_not_supp         =  335544695;
  isc_log_length_spec            =  335544696;
  isc_precision_err              =  335544697;
  isc_scale_nogt                 =  335544698;
  isc_expec_short                =  335544699;
  isc_expec_long                 =  335544700;
  isc_expec_ushort               =  335544701;
  isc_like_escape_invalid        =  335544702;
  isc_svcnoexe                   =  335544703;
  isc_net_lookup_err             =  335544704;
  isc_service_unknown            =  335544705;
  isc_host_unknown               =  335544706;
  isc_grant_nopriv_on_base       =  335544707;
  isc_dyn_fld_ambiguous          =  335544708;
  isc_dsql_agg_ref_err           =  335544709;
  isc_complex_view               =  335544710;
  isc_unprepared_stmt            =  335544711;
  isc_expec_positive             =  335544712;
  isc_dsql_sqlda_value_err       =  335544713;
  isc_invalid_array_id           =  335544714;
  isc_extfile_uns_op             =  335544715;
  isc_svc_in_use                 =  335544716;
  isc_err_stack_limit            =  335544717;
  isc_invalid_key                =  335544718;
  isc_net_init_error             =  335544719;
  isc_loadlib_failure            =  335544720;
  isc_network_error              =  335544721;
  isc_net_connect_err            =  335544722;
  isc_net_connect_listen_err     =  335544723;
  isc_net_event_connect_err      =  335544724;
  isc_net_event_listen_err       =  335544725;
  isc_net_read_err               =  335544726;
  isc_net_write_err              =  335544727;
  isc_integ_index_deactivate     =  335544728;
  isc_integ_deactivate_primary   =  335544729;
  isc_cse_not_supported          =  335544730;
  isc_tra_must_sweep             =  335544731;
  isc_unsupported_network_drive  =  335544732;
  isc_io_create_err              =  335544733;
  isc_io_open_err                =  335544734;
  isc_io_close_err               =  335544735;
  isc_io_read_err                =  335544736;
  isc_io_write_err               =  335544737;
  isc_io_delete_err              =  335544738;
  isc_io_access_err              =  335544739;
  isc_udf_exception              =  335544740;
  isc_lost_db_connection         =  335544741;
  isc_no_write_user_priv         =  335544742;
  isc_token_too_long             =  335544743;
  isc_max_att_exceeded           =  335544744;
  isc_login_same_as_role_name    =  335544745;
  isc_reftable_requires_pk	 =  335544746;  
  isc_usrname_too_long           =  335544747;
  isc_password_too_long          =  335544748;
  isc_usrname_required           =  335544749;
  isc_password_required          =  335544750;
  isc_bad_protocol               =  335544751;
  isc_dup_usrname_found          =  335544752;
  isc_usrname_not_found          =  335544753;
  isc_error_adding_sec_record    =  335544754;
  isc_error_modifying_sec_record =  335544755;
  isc_error_deleting_sec_record  =  335544756;
  isc_error_updating_sec_db      =  335544757;
  isc_sort_rec_size_err                = 335544758;
  isc_bad_default_value                = 335544759;
  isc_invalid_clause                   = 335544760;
  isc_too_many_handles                 = 335544761;
  isc_optimizer_blk_exc                = 335544762;
  isc_invalid_string_constant          = 335544763;
  isc_transitional_date                = 335544764;
  isc_read_only_database               = 335544765;
  isc_must_be_dialect_2_and_up         = 335544766;
  isc_blob_filter_exception            = 335544767;
  isc_exception_access_violation       = 335544768;
  isc_exception_datatype_missalignment = 335544769;
  isc_exception_array_bounds_exceeded  = 335544770;
  isc_exception_float_denormal_operand = 335544771;
  isc_exception_float_divide_by_zero   = 335544772;
  isc_exception_float_inexact_result   = 335544773;
  isc_exception_float_invalid_operand  = 335544774;
  isc_exception_float_overflow         = 335544775;
  isc_exception_float_stack_check      = 335544776;
  isc_exception_float_underflow        = 335544777;
  isc_exception_integer_divide_by_zero = 335544778;
  isc_exception_integer_overflow       = 335544779;
  isc_exception_unknown                = 335544780;
  isc_exception_stack_overflow         = 335544781;
  isc_exception_sigsegv                = 335544782;
  isc_exception_sigill                 = 335544783;
  isc_exception_sigbus                 = 335544784;
  isc_exception_sigfpe                 = 335544785;
  isc_ext_file_delete                  = 335544786;
  isc_ext_file_modify                  = 335544787;
  isc_adm_task_denied                  = 335544788;
  isc_extract_input_mismatch           = 335544789;
  isc_insufficient_svc_privileges      = 335544790;
  isc_file_in_use                      = 335544791;
  isc_service_att_err                  = 335544792;
  isc_ddl_not_allowed_by_db_sql_dial   = 335544793;
  isc_cancelled                        = 335544794;
  isc_unexp_spb_form                   = 335544795;
  isc_sql_dialect_datatype_unsupport   = 335544796;
  isc_svcnouser                        = 335544797;
  isc_depend_on_uncommitted_rel        = 335544798;
  isc_svc_name_missing                 = 335544799;
  isc_too_many_contexts                = 335544800;
  isc_datype_notsup                    = 335544801;
  isc_dialect_reset_warning            = 335544802;
  isc_dialect_not_changed              = 335544803;
  isc_database_create_failed           = 335544804;
  isc_inv_dialect_specified            = 335544805;
  isc_valid_db_dialects                = 335544806;
  isc_sqlwarn                          = 335544807;
  isc_dtype_renamed                    = 335544808;
  isc_extern_func_dir_error            = 335544809;
  isc_date_range_exceeded              = 335544810;
  isc_inv_client_dialect_specified     = 335544811;
  isc_valid_client_dialects            = 335544812;
  isc_optimizer_between_err            = 335544813;
  isc_service_not_supported            = 335544814;
  
  isc_gfix_db_name                     = 335740929;
  isc_gfix_invalid_sw                  = 335740930;
  isc_gfix_incmp_sw                    = 335740932;
  isc_gfix_replay_req                  = 335740933;
  isc_gfix_pgbuf_req                   = 335740934;
  isc_gfix_val_req                     = 335740935;
  isc_gfix_pval_req                    = 335740936;
  isc_gfix_trn_req                     = 335740937;
  isc_gfix_full_req                    = 335740940;
  isc_gfix_usrname_req                 = 335740941;
  isc_gfix_pass_req                    = 335740942;
  isc_gfix_subs_name                   = 335740943;
  isc_gfix_wal_req                     = 335740944;
  isc_gfix_sec_req                     = 335740945;
  isc_gfix_nval_req                    = 335740946;
  isc_gfix_type_shut                   = 335740947;
  isc_gfix_retry                       = 335740948;

  isc_gfix_retry_db                    = 335740951;
  isc_gfix_exceed_max                  = 335740991;
  isc_gfix_corrupt_pool                = 335740992;
  isc_gfix_mem_exhausted               = 335740993;
  isc_gfix_bad_pool                    = 335740994;
  isc_gfix_trn_not_valid               = 335740995;

  isc_gfix_unexp_eoi                   = 335741012;
  isc_gfix_recon_fail                  = 335741018;
  isc_gfix_trn_unknown                 = 335741036;
  isc_gfix_mode_req                    = 335741038;
  isc_gfix_opt_SQL_dialect             = 335741039;

  isc_dsql_dbkey_from_non_table        = 336003074;
  isc_dsql_transitional_numeric        = 336003075;
  isc_dsql_dialect_warning_expr        = 336003076;
  isc_sql_db_dialect_dtype_unsupport   = 336003077;
  isc_isc_sql_dialect_conflict_num     = 336003079;
  isc_dsql_warning_number_ambiguous    = 336003080;
  isc_dsql_warning_number_ambiguous1   = 336003081;
  isc_dsql_warn_precision_ambiguous    = 336003082;
  isc_dsql_warn_precision_ambiguous1   = 336003083;
  isc_dsql_warn_precision_ambiguous2   = 336003084;

  isc_dyn_role_does_not_exist          = 336068796;
  isc_dyn_no_grant_admin_opt           = 336068797;
  isc_dyn_user_not_role_member         = 336068798;
  isc_dyn_delete_role_failed           = 336068799;
  isc_dyn_grant_role_to_user           = 336068800;
  isc_dyn_inv_sql_role_name            = 336068801;
  isc_dyn_dup_sql_role                 = 336068802;
  isc_dyn_kywd_spec_for_role           = 336068803;
  isc_dyn_roles_not_supported          = 336068804;
  isc_dyn_domain_name_exists           = 336068812;
  isc_dyn_field_name_exists            = 336068813;
  isc_dyn_dependency_exists            = 336068814;
  isc_dyn_dtype_invalid                = 336068815;
  isc_dyn_char_fld_too_small           = 336068816;
  isc_dyn_invalid_dtype_conversion     = 336068817;
  isc_dyn_dtype_conv_invalid           = 336068818;

  isc_gbak_unknown_switch              = 336330753;
  isc_gbak_page_size_missing           = 336330754;
  isc_gbak_page_size_toobig            = 336330755;
  isc_gbak_redir_ouput_missing         = 336330756;
  isc_gbak_switches_conflict           = 336330757;
  isc_gbak_unknown_device              = 336330758;
  isc_gbak_no_protection               = 336330759;
  isc_gbak_page_size_not_allowed       = 336330760;
  isc_gbak_multi_source_dest           = 336330761;
  isc_gbak_filename_missing            = 336330762;
  isc_gbak_dup_inout_names             = 336330763;
  isc_gbak_inv_page_size               = 336330764;
  isc_gbak_db_specified                = 336330765;
  isc_gbak_db_exists                   = 336330766;
  isc_gbak_unk_device                  = 336330767;
  isc_gbak_blob_info_failed            = 336330772;
  isc_gbak_unk_blob_item               = 336330773;
  isc_gbak_get_seg_failed              = 336330774;
  isc_gbak_close_blob_failed           = 336330775;
  isc_gbak_open_blob_failed            = 336330776;
  isc_gbak_put_blr_gen_id_failed       = 336330777;
  isc_gbak_unk_type                    = 336330778;
  isc_gbak_comp_req_failed             = 336330779;
  isc_gbak_start_req_failed            = 336330780;
  isc_gbak_rec_failed                  = 336330781;
  isc_gbak_rel_req_failed              = 336330782;
  isc_gbak_db_info_failed              = 336330783;
  isc_gbak_no_db_desc                  = 336330784;
  isc_gbak_db_create_failed            = 336330785;
  isc_gbak_decomp_len_error            = 336330786;
  isc_gbak_tbl_missing                 = 336330787;
  isc_gbak_blob_col_missing            = 336330788;
  isc_gbak_create_blob_failed          = 336330789;
  isc_gbak_put_seg_failed              = 336330790;
  isc_gbak_rec_len_exp                 = 336330791;
  isc_gbak_inv_rec_len                 = 336330792;
  isc_gbak_exp_data_type               = 336330793;
  isc_gbak_gen_id_failed               = 336330794;
  isc_gbak_unk_rec_type                = 336330795;
  isc_gbak_inv_bkup_ver                = 336330796;
  isc_gbak_missing_bkup_desc           = 336330797;
  isc_gbak_string_trunc                = 336330798;
  isc_gbak_cant_rest_record            = 336330799;
  isc_gbak_send_failed                 = 336330800;
  isc_gbak_no_tbl_name                 = 336330801;
  isc_gbak_unexp_eof                   = 336330802;
  isc_gbak_db_format_too_old           = 336330803;
  isc_gbak_inv_array_dim               = 336330804;
  isc_gbak_xdr_len_expected            = 336330807;
  isc_gbak_open_bkup_error             = 336330817;
  isc_gbak_open_error                  = 336330818;
  isc_gbak_missing_block_fac           = 336330934;
  isc_gbak_inv_block_fac               = 336330935;
  isc_gbak_block_fac_specified         = 336330936;
  isc_gbak_missing_username            = 336330940;
  isc_gbak_missing_password            = 336330941;
  isc_gbak_missing_skipped_bytes       = 336330952;
  isc_gbak_inv_skipped_bytes           = 336330953;
  isc_gbak_err_restore_charset         = 336330965;
  isc_gbak_err_restore_collation       = 336330967;
  isc_gbak_read_error                  = 336330972;
  isc_gbak_write_error                 = 336330973;
  isc_gbak_db_in_use                   = 336330985;
  isc_gbak_sysmemex                    = 336330990;
  isc_gbak_restore_role_failed         = 336331002;
  isc_gbak_role_op_missing             = 336331005;
  isc_gbak_page_buffers_missing        = 336331010;
  isc_gbak_page_buffers_wrong_param    = 336331011;
  isc_gbak_page_buffers_restore        = 336331012;
  isc_gbak_inv_size                    = 336331014;
  isc_gbak_file_outof_sequence         = 336331015;
  isc_gbak_join_file_missing           = 336331016;
  isc_gbak_stdin_not_supptd            = 336331017;
  isc_gbak_stdout_not_supptd           = 336331018;
  isc_gbak_bkup_corrupt                = 336331019;
  isc_gbak_unk_db_file_spec            = 336331020;
  isc_gbak_hdr_write_failed            = 336331021;
  isc_gbak_disk_space_ex               = 336331022;
  isc_gbak_size_lt_min                 = 336331023;
  isc_gbak_svc_name_missing            = 336331025;
  isc_gbak_not_ownr                    = 336331026;
  isc_gbak_mode_req                    = 336331031;
  isc_gsec_cant_open_db                = 336723983;
  isc_gsec_switches_error              = 336723984;
  isc_gsec_no_op_spec                  = 336723985;
  isc_gsec_no_usr_name                 = 336723986;
  isc_gsec_err_add                     = 336723987;
  isc_gsec_err_modify                  = 336723988;
  isc_gsec_err_find_mod                = 336723989;
  isc_gsec_err_rec_not_found           = 336723990;
  isc_gsec_err_delete                  = 336723991;
  isc_gsec_err_find_del                = 336723992;
  isc_gsec_err_find_disp               = 336723996;
  isc_gsec_inv_param                   = 336723997;
  isc_gsec_op_specified                = 336723998;
  isc_gsec_pw_specified                = 336723999;
  isc_gsec_uid_specified               = 336724000;
  isc_gsec_gid_specified               = 336724001;
  isc_gsec_proj_specified              = 336724002;
  isc_gsec_org_specified               = 336724003;
  isc_gsec_fname_specified             = 336724004;
  isc_gsec_mname_specified             = 336724005;
  isc_gsec_lname_specified             = 336724006;
  isc_gsec_inv_switch                  = 336724008;
  isc_gsec_amb_switch                  = 336724009;
  isc_gsec_no_op_specified             = 336724010;
  isc_gsec_params_not_allowed          = 336724011;
  isc_gsec_incompat_switch             = 336724012;
  isc_gsec_inv_username                = 336724044;
  isc_gsec_inv_pw_length               = 336724045;
  isc_gsec_db_specified                = 336724046;
  isc_gsec_db_admin_specified          = 336724047;
  isc_gsec_db_admin_pw_specified       = 336724048;
  isc_gsec_sql_role_specified          = 336724049;
  isc_license_no_file                  = 336789504;
  isc_license_op_specified             = 336789523;
  isc_license_op_missing               = 336789524;
  isc_license_inv_switch               = 336789525;
  isc_license_inv_switch_combo         = 336789526;
  isc_license_inv_op_combo             = 336789527;
  isc_license_amb_switch               = 336789528;
  isc_license_inv_parameter            = 336789529;
  isc_license_param_specified          = 336789530;
  isc_license_param_req                = 336789531;
  isc_license_syntx_error              = 336789532;
  isc_license_dup_id                   = 336789534;
  isc_license_inv_id_key               = 336789535;
  isc_license_err_remove               = 336789536;
  isc_license_err_update               = 336789537;
  isc_license_err_convert              = 336789538;
  isc_license_err_unk                  = 336789539;
  isc_license_svc_err_add              = 336789540;
  isc_license_svc_err_remove           = 336789541;
  isc_license_eval_exists              = 336789563;
  isc_gstat_unknown_switch             = 336920577;
  isc_gstat_retry                      = 336920578;
  isc_gstat_wrong_ods                  = 336920579;
  isc_gstat_unexpected_eof             = 336920580;
  isc_gstat_open_err                   = 336920605;
  isc_gstat_read_err                   = 336920606;
  isc_gstat_sysmemex                   = 336920607;
  isc_err_max                          = 689;

{********************************************************************
**
**	ibbase.h - OSRI entrypoints and defines
**
********************************************************************}

const
  ISC_TRUE	= 1;
  ISC_FALSE	= 0;
  DSQL_close	= 1;
  DSQL_drop	= 2;

type
  Int                  = LongInt; { 32 bit signed }
  UInt                 = DWord;   { 32 bit unsigned }
  Long                 = LongInt; { 32 bit signed }
  ULong                = DWord;   { 32 bit unsigned }
  Short                = SmallInt;{ 16 bit signed }
  UShort               = Word;    { 16 bit unsigned }
  Float                = Single;  { 32 bit }
  UChar                = Byte;    { 8 bit unsigned }

  ISC_LONG             = Long;    { 32 bit signed  }
  UISC_LONG            = ULong;   { 32 bit unsigned }
{$IFDEF SD_D4}
  ISC_INT64            = Int64;   { 64 bit signed  }
{$ELSE}
  ISC_INT64            = Comp;    { 64 bit signed  }
{$ENDIF}
  ISC_USHORT	       = UShort;  { 16 bit unsigned }
  ISC_STATUS           = Long;    { 32 bit signed }
  UISC_STATUS          = ULong;   { 32 bit unsigned}
  Void                 = TSDPtr;
  { Delphi Pointer types }
{$IFDEF SD_CLR}
  PPChar               = Void;
  PSmallInt            = Void;
  PInt                 = Void;
  PInteger             = Void;
  PShort               = Void;
  PUShort              = Void;
  PLong                = Void;
  PULong               = Void;
  PFloat               = Void;
  PUChar               = Void;
  PVoid                = Void;
  PDouble              = Void;
  PISC_LONG            = Void;
  PUISC_LONG           = Void;
  PISC_STATUS          = Void;
  PPISC_STATUS         = Void;
  PUISC_STATUS         = Void;
{$ELSE}
  PPChar               = ^TSDCharPtr;
  PSmallInt            = ^SmallInt;
  PInt                 = ^Int;
  PInteger             = ^Integer;
  PShort               = ^Short;
  PUShort              = ^UShort;
  PLong                = ^Long;
  PULong               = ^ULong;
  PFloat               = ^Float;
  PUChar               = ^UChar;
  PVoid                = Pointer;
  PDouble              = ^Double;
  PISC_LONG            = ^ISC_LONG;
  PUISC_LONG           = ^UISC_LONG;
  PISC_STATUS          = ^ISC_STATUS;
  PPISC_STATUS         = ^PISC_STATUS;
  PUISC_STATUS         = ^UISC_STATUS;
{$ENDIF}

  { C Date/Time Structure }
  TTimeDateRec = record
    tm_sec:	Integer;  { Seconds }
    tm_min: 	Integer;  { Minutes }
    tm_hour: 	Integer;  { Hour (0--23) }
    tm_mday: 	Integer;  { Day of month (1--31) }
    tm_mon: 	Integer;  { Month (0--11) }
    tm_year: 	Integer;  { Year (calendar year minus 1900) }
    tm_wday: 	Integer;  { Weekday (0--6) Sunday = 0) }
    tm_yday: 	Integer;  { Day of year (0--365) }
    tm_isdst: 	Integer;  { 0 if daylight savings time is not in effect) }
  end;
  PTimeDateRec = ^TTimeDateRec;

  TISC_VARYING = record
    strlen: Short;
    str: array[0..0] of Char;
  end;

const
  SQLDA_VERSION1	       = 1; (* pre V6.0 SQLDA *)
  SQLDA_VERSION2	       = 2; (*     V6.0 SQLDA *)
  SQL_DIALECT_V5	       = 1; (* meaning is same as DIALECT_xsqlda *)
  SQL_DIALECT_V6_TRANSITION    = 2; (* flagging anything that is delimited
                                       by double quotes as an error and
                                       flagging keyword DATE as an error *)
  SQL_DIALECT_V6	       = 3; (* supports SQL delimited identifier,
                                       SQLDATE/DATE, TIME, TIMESTAMP,
                                       CURRENT_DATE, CURRENT_TIME,
                                       CURRENT_TIMESTAMP, and 64-bit exact
                                       numeric type *)
  SQL_DIALECT_CURRENT	       = SQL_DIALECT_V6; (* latest IB DIALECT *)

type
  (**********************************)
  (** InterBase Handle Definitions **)
  (**********************************)
  TISC_ATT_HANDLE               = PVoid;
  TISC_BLOB_HANDLE              = PVoid;
  TISC_DB_HANDLE                = PVoid;
  TISC_FORM_HANDLE              = PVoid;
  TISC_REQ_HANDLE               = PVoid;
  TISC_STMT_HANDLE              = PVoid;
  TISC_SVC_HANDLE               = PVoid;
  TISC_TR_HANDLE                = PVoid;
  TISC_WIN_HANDLE               = PVoid;
  TISC_CALLBACK                 = procedure(user_arg: PVoid; str: TSDCharPtr); cdecl;
  ISC_SVC_HANDLE                = ISC_LONG;
{$IFDEF SD_CLR}
  PISC_ATT_HANDLE               = Void;
  PISC_BLOB_HANDLE              = Void;
  PISC_DB_HANDLE                = Void;
  PISC_FORM_HANDLE              = Void;
  PISC_REQ_HANDLE               = Void;
  PISC_STMT_HANDLE              = Void;
  PISC_SVC_HANDLE               = Void;
  PISC_TR_HANDLE                = Void;
  PISC_WIN_HANDLE               = Void;
{$ELSE}
  PISC_ATT_HANDLE               = ^TISC_ATT_HANDLE;
  PISC_BLOB_HANDLE              = ^TISC_BLOB_HANDLE;
  PISC_DB_HANDLE                = ^TISC_DB_HANDLE;
  PISC_FORM_HANDLE              = ^TISC_FORM_HANDLE;
  PISC_REQ_HANDLE               = ^TISC_REQ_HANDLE;
  PISC_STMT_HANDLE              = ^TISC_STMT_HANDLE;
  PISC_SVC_HANDLE               = ^TISC_SVC_HANDLE;
  PISC_TR_HANDLE                = ^TISC_TR_HANDLE;
  PISC_WIN_HANDLE               = ^TISC_WIN_HANDLE;
{$ENDIF}

  (*******************************************************************)
  (* Time & Date Support                                             *)
  (*******************************************************************)
const
  ISC_SECONDS_PRECISION       = 10000;
  ISC_SECONDS_PRECISION_SCALE = -4;

type
  TISC_DATE = Long;
  TISC_TIME = ULong;
  TISC_TIMESTAMP = record
    timestamp_date: TISC_DATE;
    timestamp_time: TISC_TIME;
  end;
{$IFDEF SD_CLR}
  PISC_DATE = Void;
  PISC_TIME = Void;
  PISC_TIMESTAMP = Void;
{$ELSE}
  PISC_DATE = ^TISC_DATE;
  PISC_TIME = ^TISC_TIME;
  PISC_TIMESTAMP = ^TISC_TIMESTAMP;
{$ENDIF}

  (*********************************************************************)
  (** Blob id structure                                               **)
  (*********************************************************************)
  TGDS_QUAD = record
    gds_quad_high      : ISC_LONG;
    gds_quad_low       : UISC_LONG;
  end;
  TGDS__QUAD           = TGDS_QUAD;
  TISC_QUAD            = TGDS_QUAD;
{$IFDEF SD_CLR}
  PGDS_QUAD            = Void;
  PGDS__QUAD           = Void;
  PISC_QUAD            = Void;
{$ELSE}
  PGDS_QUAD            = ^TGDS_QUAD;
  PGDS__QUAD           = ^TGDS__QUAD;
  PISC_QUAD            = ^TISC_QUAD;
{$ENDIF}

  TISC_ARRAY_BOUND = record
    array_bound_lower  : short;
    array_bound_upper  : short;
  end;
  PISC_ARRAY_BOUND     = ^TISC_ARRAY_BOUND;
  TISC_ARRAY_DESC = record
    array_desc_dtype            : UChar;
    array_desc_scale            : Char;
    array_desc_length           : UShort;
    array_desc_field_name       : array[0..31] of Char;
    array_desc_relation_name    : array[0..31] of Char;
    array_desc_dimensions       : Short;
    array_desc_flags            : Short;
    array_desc_bounds           : array[0..15] of TISC_ARRAY_BOUND;
  end; // TISC_ARRAY_DESC
  PISC_ARRAY_DESC = ^TISC_ARRAY_DESC;

  TISC_BLOB_DESC = record
    blob_desc_subtype           : Short;
    blob_desc_charset           : Short;
    blob_desc_segment_size      : Short;
    blob_desc_field_name        : array[0..31] of UChar;
    blob_desc_relation_name     : array[0..31] of UChar;
  end; // TISC_BLOB_DESC
  PISC_BLOB_DESC = {$IFDEF SD_CLR} Void {$ELSE} ^TISC_BLOB_DESC {$ENDIF};

  (*****************************)
  (** Blob control structure  **)
  (*****************************)
  TISC_BLOB_CTL_SOURCE_FUNCTION = function: ISC_STATUS; // ISC_FAR
  PISC_BLOB_CTL                 = {$IFDEF SD_CLR}Void{$ELSE}^TISC_BLOB_CTL{$ENDIF};        // ISC_FAR
  TISC_BLOB_CTL = record
    (** Source filter **)
    ctl_source                  : TISC_BLOB_CTL_SOURCE_FUNCTION;
    (** Argument to pass to source filter **)
    ctl_source_handle           : PISC_BLOB_CTL;
    ctl_to_sub_type             : Short;  	(** Target type **)
    ctl_from_sub_type           : Short;	(** Source type **)
    ctl_buffer_length           : UShort;	(** Length of buffer **)
    ctl_segment_length          : UShort;  	(** Length of current segment **)
    ctl_bpb_length              : UShort;	(** Length of blob parameter **)
					    	(** block **)
    ctl_bpb                     : TSDCharPtr;	(** Address of blob parameter **)
						(** block **)
    ctl_buffer                  : PUChar;	(** Address of segment buffer **)
    ctl_max_segment             : ISC_LONG;	(** Length of longest segment **)
    ctl_number_segments 	: ISC_LONG;     (** Total number of segments **)
    ctl_total_length            : ISC_LONG;  	(** Total length of blob **)
    ctl_status                  : PISC_STATUS;	(** Address of status vector **)
    ctl_data                    : array[0..7] of long; (** Application specific data **)
  end;
  (*****************************)
  (** Blob stream definitions **)
  (*****************************)
  TBSTREAM = record
    bstr_blob                   : PVoid;  	(** Blob handle **)
    bstr_buffer                 : TSDCharPtr;	(** Address of buffer **)
    bstr_ptr                    : TSDCharPtr;	(** Next character **)
    bstr_length                 : Short;	(** Length of buffer **)
    bstr_cnt                    : Short;	(** Characters in buffer **)
    bstr_mode                   : Char;  	(** (mode) ? OUTPUT : INPUT **)
  end;
  PBSTREAM                      = ^TBSTREAM;

type
  (********************************)
  (** Declare the extended SQLDA **)
  (********************************)
{$IFDEF SD_CLR}
  [StructLayout(LayoutKind.Sequential)]
  TXSQLVAR = record
    sqltype                     : Short;     (** datatype of field **)
    sqlscale                    : Short;     (** scale factor **)
    sqlsubtype                  : Short;     (** datatype subtype - BLOBs **)
					     (** & text types only **)
    sqllen                      : Short;     (** length of data area **)
    sqldata                     : TSDCharPtr;     (** address of data **)
    sqlind                      : PShort;    (** address of indicator **)
                                             (** variable **)
    sqlname_length              : Short;     (** length of sqlname field **)
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = METADATALEN)]
    sqlname                     : string;	{ array[0..31] of Char }
    relname_length              : Short;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = METADATALEN)]
    relname                     : string;
    ownname_length              : Short;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = METADATALEN)]
    ownname                     : string;
    aliasname_length            : Short;
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = METADATALEN)]
    aliasname                   : string;
  end;  // TXSQLVAR (SizeOf(TXSQLVAR)=152)

  [StructLayout(LayoutKind.Sequential)]
  TXSQLDA = record
    version                     : Short;     (** version of this XSQLDA **)
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 8)]
    sqldaid                     : string;	{ array[0..7] of Char }
    sqldabc                     : ISC_LONG;  (** length in bytes of SQLDA **)
    sqln                        : Short;     (** number of fields allocated **)
    sqld                        : Short;     (** actual number of fields **)
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 156)]	// 156 ???
    sqlvar                      : string;	// array[0..0] of TXSQLVAR;
  end; // TXSQLDA

  PXSQLVAR                      = Void;
  PXSQLDA                       = Void;
{$ELSE}
  TXSQLVAR = record
    sqltype                     : Short;     (** datatype of field **)
    sqlscale                    : Short;     (** scale factor **)
    sqlsubtype                  : Short;     (** datatype subtype - BLOBs **)
					     (** & text types only **)
    sqllen                      : Short;     (** length of data area **)
    sqldata                     : TSDCharPtr;     (** address of data **)
    sqlind                      : PShort;    (** address of indicator **)
                                             (** variable **)
    sqlname_length              : Short;     (** length of sqlname field **)
    (** name of field, name length + space for NULL **)
    sqlname                     : array[0..31] of Char;
    relname_length              : Short;     (** length of relation name **)
    (** field's relation name + space for NULL **)
    relname                     : array[0..31] of Char;
    ownname_length              : Short;     (** length of owner name **)
    (** relation's owner name + space for NULL **)
    ownname                     : array[0..31] of Char;
    aliasname_length            : Short;     (** length of alias name **)
    (** relation's alias name + space for NULL **)
    aliasname                   : array[0..31] of Char;
  end;  // TXSQLVAR

  TXSQLDA = record
    version                     : Short;     (** version of this XSQLDA **)
    (** XSQLDA name field **)
    sqldaid                     : array[0..7] of Char;
    sqldabc                     : ISC_LONG;  (** length in bytes of SQLDA **)
    sqln                        : Short;     (** number of fields allocated **)
    sqld                        : Short;     (** actual number of fields **)
    (** first field address **)
    sqlvar                      : array[0..0] of TXSQLVAR;
  end; // TXSQLDA

  PXSQLVAR                      = ^TXSQLVAR;
  PXSQLDA                       = ^TXSQLDA;
{$ENDIF}

(********************************************************)
(** This record type is for passing arguments to       **)
(** isc_start_transaction (See docs)                   **)
(********************************************************)
  TISC_START_TRANS = record
    db_handle      : PISC_DB_HANDLE;
    tpb_length     : UShort;
    tpb_address    : TSDCharPtr;
  end;

(********************************************************)
(** This record type is for passing arguments to       **)
(** isc_start_multiple (see docs)                      **)
(********************************************************)
  TISC_TEB = record
    db_handle      : PISC_DB_HANDLE;
    tpb_length     : Long;
    tpb_address    : TSDCharPtr;
  end;
  PISC_TEB = ^TISC_TEB;
  TISC_TEB_ARRAY = array[0..0] of TISC_TEB;
  PISC_TEB_ARRAY = ^TISC_TEB_ARRAY;

(********************************************************)
(** Security Functions and structures                  **)
(********************************************************)
  TUSER_SEC_DATA = record
    sec_flags: Short;		// which fields are specified
    uid: Integer;    		// the user's id
    gid: Integer;    		// the user's group id
    protocol: Integer;		// protocol to use for connection
    server,          		// server to administer
    user_name,       		// the user's name
    password,        		// the user's password
    group_name,      		// the group name
    first_name,	     		// the user's first name
    middle_name,     		// the user's middle name
    last_name,	     		// the user's last name
    dba_user_name,   	    	// the dba user name
    dba_password: TSDCharPtr;    	// the dba password
  end;
  PUSER_SEC_DATA = ^TUSER_SEC_DATA;


(***********************)
(* Security structures *)
(***********************)
const
  sec_uid_spec		= $01;
  sec_gid_spec	       	= $02;
  sec_server_spec      	= $04;
  sec_password_spec    	= $08;
  sec_group_name_spec  	= $10;
  sec_first_name_spec  	= $20;
  sec_middle_name_spec 	= $40;
  sec_last_name_spec   	= $80;
  sec_dba_user_name_spec= $100;
  sec_dba_password_spec	= $200;

  sec_protocol_tcpip   	= 1;
  sec_protocol_netbeui 	= 2;
  sec_protocol_spx     	= 3;
  sec_protocol_local   	= 4;

(** Constants!!! **)
(*****************************************************)
(** Actions to pass to the blob filter (ctl_source) **)
(*****************************************************)

const
  isc_blob_filter_open           =          0;
  isc_blob_filter_get_segment    =          1;
  isc_blob_filter_close          =          2;
  isc_blob_filter_create         =          3;
  isc_blob_filter_put_segment    =          4;
  isc_blob_filter_alloc          =          5;
  isc_blob_filter_free           =          6;
  isc_blob_filter_seek           =          7;

(*********************)
(** Blr definitions **)
(*********************)

  // In pascal, how does one deal with the below "#define"?
  // blr_word(n) ((n) % 256), ((n) / 256)
  blr_text                       =         14;
  blr_text2                      =         15;
  blr_short                      =          7;
  blr_long                       =          8;
  blr_quad                       =          9;
  blr_int64                      =         16;
  blr_float                      =         10;
  blr_double                     =         27;
  blr_d_float                    =         11;
  blr_timestamp                  =         35;
  blr_varying                    =         37;
  blr_varying2                   =         38;
  blr_blob                       =        261;
  blr_cstring                    =         40;
  blr_cstring2                   =         41;
  blr_blob_id                    =         45;
  blr_sql_date                   =         12;
  blr_sql_time                   =         13;

	// Historical alias for pre V6 applications
  blr_date                       =         blr_timestamp;

  blr_inner                      =          0;
  blr_left                       =          1;
  blr_right                      =          2;
  blr_full                       =          3;

  blr_gds_code                   =          0;
  blr_sql_code                   =          1;
  blr_exception                  =          2;
  blr_trigger_code               =          3;
  blr_default_code               =          4;

  blr_version4                   =          4;
  blr_version5                   =          5;
  blr_eoc                        =         76;
  blr_end                        =         -1;

  blr_assignment                 =          1;
  blr_begin                      =          2;
  blr_dcl_variable               =          3;
  blr_message                    =          4;
  blr_erase                      =          5;
  blr_fetch                      =          6;
  blr_for                        =          7;
  blr_if                         =          8;
  blr_loop                       =          9;
  blr_modify                     =         10;
  blr_handler                    =         11;
  blr_receive                    =         12;
  blr_select                     =         13;
  blr_send                       =         14;
  blr_store                      =         15;
  blr_label                      =         17;
  blr_leave                      =         18;
  blr_store2                     =         19;
  blr_post                       =         20;

  blr_literal                    =         21;
  blr_dbkey                      =         22;
  blr_field                      =         23;
  blr_fid                        =         24;
  blr_parameter                  =         25;
  blr_variable                   =         26;
  blr_average                    =         27;
  blr_count                      =         28;
  blr_maximum                    =         29;
  blr_minimum                    =         30;
  blr_total                      =         31;
  blr_add                        =         34;
  blr_subtract                   =         35;
  blr_multiply                   =         36;
  blr_divide                     =         37;
  blr_negate                     =         38;
  blr_concatenate                =         39;
  blr_substring                  =         40;
  blr_parameter2                 =         41;
  blr_from                       =         42;
  blr_via                        =         43;
  blr_user_name                  =         44;
  blr_null                       =         45;

  blr_eql                        =         47;
  blr_neq                        =         48;
  blr_gtr                        =         49;
  blr_geq                        =         50;
  blr_lss                        =         51;
  blr_leq                        =         52;
  blr_containing                 =         53;
  blr_matching                   =         54;
  blr_starting                   =         55;
  blr_between                    =         56;
  blr_or                         =         57;
  blr_and                        =         58;
  blr_not                        =         59;
  blr_any                        =         60;
  blr_missing                    =         61;
  blr_unique                     =         62;
  blr_like                       =         63;

  blr_stream                     =         65;
  blr_set_index                  =         66;
  blr_rse                        =         67;
  blr_first                      =         68;
  blr_project                    =         69;
  blr_sort                       =         70;
  blr_boolean                    =         71;
  blr_ascending                  =         72;
  blr_descending                 =         73;
  blr_relation                   =         74;
  blr_rid                        =         75;
  blr_union                      =         76;
  blr_map                        =         77;
  blr_group_by                   =         78;
  blr_aggregate                  =         79;
  blr_join_type                  =         80;

  blr_agg_count                  =         83;
  blr_agg_max                    =         84;
  blr_agg_min                    =         85;
  blr_agg_total                  =         86;
  blr_agg_average                =         87;
  blr_parameter3                 =         88;
  blr_run_count                  =        118;
  blr_run_max                    =         89;
  blr_run_min                    =         90;
  blr_run_total                  =         91;
  blr_run_average                =         92;
  blr_agg_count2                 =         93;
  blr_agg_count_distinct         =         94;
  blr_agg_total_distinct         =         95;
  blr_agg_average_distinct       =         96;

  blr_function                   =        100;
  blr_gen_id                     =        101;
  blr_prot_mask                  =        102;
  blr_upcase                     =        103;
  blr_lock_state                 =        104;
  blr_value_if                   =        105;
  blr_matching2                  =        106;
  blr_index                      =        107;
  blr_ansi_like                  =        108;
  blr_bookmark                   =        109;
  blr_crack                      =        110;
  blr_force_crack                =        111;
  blr_seek                       =        112;
  blr_find                       =        113;

  blr_continue                   =          0;
  blr_forward                    =          1;
  blr_backward                   =          2;
  blr_bof_forward                =          3;
  blr_eof_backward               =          4;

  blr_lock_relation              =        114;
  blr_lock_record                =        115;
  blr_set_bookmark               =        116;
  blr_get_bookmark               =        117;
  blr_rs_stream                  =        119;
  blr_exec_proc                  =        120;
  blr_begin_range                =        121;
  blr_end_range                  =        122;
  blr_delete_range               =        123;
  blr_procedure                  =        124;
  blr_pid                        =        125;
  blr_exec_pid                   =        126;
  blr_singular                   =        127;
  blr_abort                      =        128;
  blr_block                      =        129;
  blr_error_handler              =        130;
  blr_cast                       =        131;
  blr_release_lock               =        132;
  blr_release_locks              =        133;
  blr_start_savepoint            =        134;
  blr_end_savepoint              =        135;
  blr_find_dbkey                 =        136;
  blr_range_relation             =        137;
  blr_delete_ranges              =        138;

  blr_plan                       =        139;
  blr_merge                      =        140;
  blr_join                       =        141;
  blr_sequential                 =        142;
  blr_navigational               =        143;
  blr_indices                    =        144;
  blr_retrieve                   =        145;

  blr_relation2                  =        146;
  blr_rid2                       =        147;
  blr_reset_stream               =        148;
  blr_release_bookmark           =        149;
  blr_set_generator              =        150;
  blr_ansi_any                   =        151;
  blr_exists                     =        152;
  blr_cardinality                =        153;

  blr_record_version             =        154;		(** get tid of record **)
  blr_stall                      =        155;		(** fake server stall **)
  blr_seek_no_warn               =        156;
  blr_find_dbkey_version         =        157;
  blr_ansi_all                   =        158;

  blr_extract                    = 159;

  (* sub parameters for blr_extract *)

  blr_extract_year               = 0;
  blr_extract_month              = 1;
  blr_extract_day	         = 2;
  blr_extract_hour               = 3;
  blr_extract_minute             = 4;
  blr_extract_second             = 5;
  blr_extract_weekday            = 6;
  blr_extract_yearday            = 7;

  blr_current_date               = 160;
  blr_current_timestamp          = 161;
  blr_current_time               = 162;

  // These verbs were added in 6.0, primarily to support 64-bit integers

  blr_add2	            = 163;
  blr_subtract2	            = 164;
  blr_multiply2             = 165;
  blr_divide2	            = 166;
  blr_agg_total2            = 167;
  blr_agg_total_distinct2   = 168;
  blr_agg_average2          = 169;
  blr_agg_average_distinct2 = 170;
  blr_average2		    = 171;
  blr_gen_id2		    = 172;
  blr_set_generator2        = 173;

(************************************)
(** Database parameter block stuff **)
(************************************)

  isc_dpb_version1               =          1;
  isc_dpb_cdd_pathname           =          1;
  isc_dpb_allocation             =          2;
  isc_dpb_journal                =          3;
  isc_dpb_page_size              =          4;
  isc_dpb_num_buffers            =          5;
  isc_dpb_buffer_length          =          6;
  isc_dpb_debug                  =          7;
  isc_dpb_garbage_collect        =          8;
  isc_dpb_verify                 =          9;
  isc_dpb_sweep                  =         10;
  isc_dpb_enable_journal         =         11;
  isc_dpb_disable_journal        =         12;
  isc_dpb_dbkey_scope            =         13;
  isc_dpb_number_of_users        =         14;
  isc_dpb_trace                  =         15;
  isc_dpb_no_garbage_collect     =         16;
  isc_dpb_damaged                =         17;
  isc_dpb_license                =         18;
  isc_dpb_sys_user_name          =         19;
  isc_dpb_encrypt_key            =         20;
  isc_dpb_activate_shadow        =         21;
  isc_dpb_sweep_interval         =         22;
  isc_dpb_delete_shadow          =         23;
  isc_dpb_force_write            =         24;
  isc_dpb_begin_log              =         25;
  isc_dpb_quit_log               =         26;
  isc_dpb_no_reserve             =         27;
  isc_dpb_user_name              =         28;
  isc_dpb_password               =         29;
  isc_dpb_password_enc           =         30;
  isc_dpb_sys_user_name_enc      =         31;
  isc_dpb_interp                 =         32;
  isc_dpb_online_dump            =         33;
  isc_dpb_old_file_size          =         34;
  isc_dpb_old_num_files          =         35;
  isc_dpb_old_file               =         36;
  isc_dpb_old_start_page         =         37;
  isc_dpb_old_start_seqno        =         38;
  isc_dpb_old_start_file         =         39;
  isc_dpb_drop_walfile           =         40;
  isc_dpb_old_dump_id            =         41;
  isc_dpb_wal_backup_dir         =         42;
  isc_dpb_wal_chkptlen           =         43;
  isc_dpb_wal_numbufs            =         44;
  isc_dpb_wal_bufsize            =         45;
  isc_dpb_wal_grp_cmt_wait       =         46;
  isc_dpb_lc_messages            =         47;
  isc_dpb_lc_ctype               =         48;
  isc_dpb_cache_manager          =         49;
  isc_dpb_shutdown               =         50;
  isc_dpb_online                 =         51;
  isc_dpb_shutdown_delay         =         52;
  isc_dpb_reserved               =         53;
  isc_dpb_overwrite              =         54;
  isc_dpb_sec_attach             =         55;
  isc_dpb_disable_wal            =         56;
  isc_dpb_connect_timeout        =         57;
  isc_dpb_dummy_packet_interval  =         58;
  isc_dpb_gbak_attach            =         59;
  isc_dpb_sql_role_name          =         60;
  isc_dpb_set_page_buffers       =         61;
  isc_dpb_working_directory      =         62;
  isc_dpb_SQL_dialect            =         63;
  isc_dpb_set_db_readonly        =         64;
  isc_dpb_set_db_SQL_dialect     =         65;
  isc_dpb_gfix_attach		 =         66;
  isc_dpb_gstat_attach		 =         67;
  isc_dpb_last_dpb_constant      =         isc_dpb_gstat_attach;


(***********************************)
(** isc_dpb_verify specific flags **)
(***********************************)

  isc_dpb_pages                  =          1;
  isc_dpb_records                =          2;
  isc_dpb_indices                =          4;
  isc_dpb_transactions           =          8;
  isc_dpb_no_update              =         16;
  isc_dpb_repair                 =         32;
  isc_dpb_ignore                 =         64;

(*************************************)
(** isc_dpb_shutdown specific flags **)
(*************************************)

  isc_dpb_shut_cache             =          1;
  isc_dpb_shut_attachment        =          2;
  isc_dpb_shut_transaction       =          4;
  isc_dpb_shut_force             =          8;

(****************************************)
(** Bit assignments in RDB$SYSTEM_FLAG **)
(****************************************)

  RDB_system                     =          1;
  RDB_id_assigned                =          2;


(***************************************)
(** Transaction parameter block stuff **)
(***************************************)

  isc_tpb_version1               =          1;
  isc_tpb_version3               =          3;
  isc_tpb_consistency            =          1;
  isc_tpb_concurrency            =          2;
  isc_tpb_shared                 =          3;
  isc_tpb_protected              =          4;
  isc_tpb_exclusive              =          5;
  isc_tpb_wait                   =          6;
  isc_tpb_nowait                 =          7;
  isc_tpb_read                   =          8;
  isc_tpb_write                  =          9;
  isc_tpb_lock_read              =         10;
  isc_tpb_lock_write             =         11;
  isc_tpb_verb_time              =         12;
  isc_tpb_commit_time            =         13;
  isc_tpb_ignore_limbo           =         14;
  isc_tpb_read_committed         =         15;
  isc_tpb_autocommit             =         16;
  isc_tpb_rec_version            =         17;
  isc_tpb_no_rec_version         =         18;
  isc_tpb_restart_requests       =         19;
  isc_tpb_no_auto_undo           =         20;
  isc_tpb_last_tpb_constant      =         isc_tpb_no_auto_undo;


(**************************)
(** Blob Parameter Block **)
(**************************)

  isc_bpb_version1               =          1;
  isc_bpb_source_type            =          1;
  isc_bpb_target_type            =          2;
  isc_bpb_type                   =          3;
  isc_bpb_source_interp          =          4;
  isc_bpb_target_interp          =          5;
  isc_bpb_filter_parameter       =          6;

  isc_bpb_type_segmented         =          0;
  isc_bpb_type_stream            =          1;


(***********************************)
(** Service parameter block stuff **)
(***********************************)
	// has different values for v.6
  isc_spb_version1               = 1;
  isc_spb_current_version        = 2;
  isc_spb_version                = isc_spb_current_version;
  isc_spb_user_name              =          1;
  isc_spb_sys_user_name          =          2;
  isc_spb_sys_user_name_enc      =          3;
  isc_spb_password               =          4;
  isc_spb_password_enc           =          5;
  isc_spb_command_line           =          6;
  isc_spb_dbname                 =          7;
  isc_spb_verbose                =          8;
  isc_spb_options                =          9;
  isc_spb_connect_timeout        =          10;
  isc_spb_dummy_packet_interval  =          11;
  isc_spb_sql_role_name          =          12;
  isc_spb_last_spb_constant      =          isc_spb_sql_role_name;

	// from v.5
  isc_spb_user_name_mapped_to_server              = isc_dpb_user_name;
  isc_spb_sys_user_name_mapped_to_server          = isc_dpb_sys_user_name;
  isc_spb_sys_user_name_enc_mapped_to_server      = isc_dpb_sys_user_name_enc;
  isc_spb_password_mapped_to_server               = isc_dpb_password;
  isc_spb_password_enc_mapped_to_server           = isc_dpb_password_enc;
  isc_spb_command_line_mapped_to_server           = 105;
  isc_spb_dbname_mapped_to_server                 = 106;
  isc_spb_verbose_mapped_to_server                = 107;
  isc_spb_options_mapped_to_server                = 108;
  isc_spb_connect_timeout_mapped_to_server        = isc_dpb_connect_timeout;
  isc_spb_dummy_packet_interval_mapped_to_server  = isc_dpb_dummy_packet_interval;
  isc_spb_sql_role_name_mapped_to_server          = isc_dpb_sql_role_name;

(***********************************)
(** Information call declarations **)
(***********************************)

(******************************)
(** Common, structural codes **)
(******************************)

  isc_info_end                   =          1;
  isc_info_truncated             =          2;
  isc_info_error                 =          3;
  isc_info_data_not_ready	 =          4;
  isc_info_flag_end		 =          127;

(********************************)
(** Database information items **)
(********************************)

  isc_info_db_id                 =          4;
  isc_info_reads                 =          5;
  isc_info_writes                =          6;
  isc_info_fetches               =          7;
  isc_info_marks                 =          8;
  isc_info_implementation        =         11;
  isc_info_version               =         12;
  isc_info_base_level            =         13;
  isc_info_page_size             =         14;
  isc_info_num_buffers           =         15;
  isc_info_limbo                 =         16;
  isc_info_current_memory        =         17;
  isc_info_max_memory            =         18;
  isc_info_window_turns          =         19;
  isc_info_license               =         20;
  isc_info_allocation            =         21;
  isc_info_attachment_id         =         22;
  isc_info_read_seq_count        =         23;
  isc_info_read_idx_count        =         24;
  isc_info_insert_count          =         25;
  isc_info_update_count          =         26;
  isc_info_delete_count          =         27;
  isc_info_backout_count         =         28;
  isc_info_purge_count           =         29;
  isc_info_expunge_count         =         30;
  isc_info_sweep_interval        =         31;
  isc_info_ods_version           =         32;
  isc_info_ods_minor_version     =         33;
  isc_info_no_reserve            =         34;
  isc_info_logfile               =         35;
  isc_info_cur_logfile_name      =         36;
  isc_info_cur_log_part_offset   =         37;
  isc_info_num_wal_buffers       =         38;
  isc_info_wal_buffer_size       =         39;
  isc_info_wal_ckpt_length       =         40;
  isc_info_wal_cur_ckpt_interval =         41;
  isc_info_wal_prv_ckpt_fname    =         42;
  isc_info_wal_prv_ckpt_poffset  =         43;
  isc_info_wal_recv_ckpt_fname   =         44;
  isc_info_wal_recv_ckpt_poffset =         45;
  isc_info_wal_grpc_wait_usecs   =         47;
  isc_info_wal_num_io            =         48;
  isc_info_wal_avg_io_size       =         49;
  isc_info_wal_num_commits       =         50;
  isc_info_wal_avg_grpc_size     =         51;
  isc_info_forced_writes         =         52;
  isc_info_user_names            =         53;
  isc_info_page_errors           =         54;
  isc_info_record_errors         =         55;
  isc_info_bpage_errors          =         56;
  isc_info_dpage_errors          =         57;
  isc_info_ipage_errors          =         58;
  isc_info_ppage_errors          =         59;
  isc_info_tpage_errors          =         60;
  isc_info_set_page_buffers      =         61;
  isc_info_db_SQL_dialect        =         62;
  isc_info_db_read_only          =         63;
  isc_info_db_size_in_pages      =         64;

(****************************************)
(** Database information return values **)
(****************************************)

  isc_info_db_impl_rdb_vms       =          1;
  isc_info_db_impl_rdb_eln       =          2;
  isc_info_db_impl_rdb_eln_dev   =          3;
  isc_info_db_impl_rdb_vms_y     =          4;
  isc_info_db_impl_rdb_eln_y     =          5;
  isc_info_db_impl_jri           =          6;
  isc_info_db_impl_jsv           =          7;
  isc_info_db_impl_isc_a         =         25;
  isc_info_db_impl_isc_u         =         26;
  isc_info_db_impl_isc_v         =         27;
  isc_info_db_impl_isc_s         =         28;
  isc_info_db_impl_isc_apl_68K   =         25;
  isc_info_db_impl_isc_vax_ultr  =         26;
  isc_info_db_impl_isc_vms       =         27;
  isc_info_db_impl_isc_sun_68k   =         28;
  isc_info_db_impl_isc_os2       =         29;
  isc_info_db_impl_isc_sun4      =         30;
  isc_info_db_impl_isc_hp_ux     =         31;
  isc_info_db_impl_isc_sun_386i  =         32;
  isc_info_db_impl_isc_vms_orcl  =         33;
  isc_info_db_impl_isc_mac_aux   =         34;
  isc_info_db_impl_isc_rt_aix    =         35;
  isc_info_db_impl_isc_mips_ult  =         36;
  isc_info_db_impl_isc_xenix     =         37;
  isc_info_db_impl_isc_dg        =         38;
  isc_info_db_impl_isc_hp_mpexl  =         39;
  isc_info_db_impl_isc_hp_ux68K  =         40;
  isc_info_db_impl_isc_sgi       =         41;
  isc_info_db_impl_isc_sco_unix  =         42;
  isc_info_db_impl_isc_cray      =         43;
  isc_info_db_impl_isc_imp       =         44;
  isc_info_db_impl_isc_delta     =         45;
  isc_info_db_impl_isc_next      =         46;
  isc_info_db_impl_isc_dos       =         47;
  isc_info_db_impl_isc_winnt     =         48;
  isc_info_db_impl_isc_epson     =         49;

  isc_info_db_class_access       =          1;
  isc_info_db_class_y_valve      =          2;
  isc_info_db_class_rem_int      =          3;
  isc_info_db_class_rem_srvr     =          4;
  isc_info_db_class_pipe_int     =          7;
  isc_info_db_class_pipe_srvr    =          8;
  isc_info_db_class_sam_int      =          9;
  isc_info_db_class_sam_srvr     =         10;
  isc_info_db_class_gateway      =         11;
  isc_info_db_class_cache        =         12;

(*******************************)
(** Request information items **)
(*******************************)

  isc_info_number_messages       =          4;
  isc_info_max_message           =          5;
  isc_info_max_send              =          6;
  isc_info_max_receive           =          7;
  isc_info_state                 =          8;
  isc_info_message_number        =          9;
  isc_info_message_size          =         10;
  isc_info_request_cost          =         11;
  isc_info_access_path           =         12;
  isc_info_req_select_count      =         13;
  isc_info_req_insert_count      =         14;
  isc_info_req_update_count      =         15;
  isc_info_req_delete_count      =         16;


(***********************)
(** Access path items **)
(***********************)

  isc_info_rsb_end               =          0;
  isc_info_rsb_begin             =          1;
  isc_info_rsb_type              =          2;
  isc_info_rsb_relation          =          3;
  isc_info_rsb_plan              =          4;

(***************)
(** Rsb types **)
(***************)

  isc_info_rsb_unknown           =          1;
  isc_info_rsb_indexed           =          2;
  isc_info_rsb_navigate          =          3;
  isc_info_rsb_sequential        =          4;
  isc_info_rsb_cross             =          5;
  isc_info_rsb_sort              =          6;
  isc_info_rsb_first             =          7;
  isc_info_rsb_boolean           =          8;
  isc_info_rsb_union             =          9;
  isc_info_rsb_aggregate         =         10;
  isc_info_rsb_merge             =         11;
  isc_info_rsb_ext_sequential    =         12;
  isc_info_rsb_ext_indexed       =         13;
  isc_info_rsb_ext_dbkey         =         14;
  isc_info_rsb_left_cross        =         15;
  isc_info_rsb_select            =         16;
  isc_info_rsb_sql_join          =         17;
  isc_info_rsb_simulate          =         18;
  isc_info_rsb_sim_cross         =         19;
  isc_info_rsb_once              =         20;
  isc_info_rsb_procedure         =         21;

(************************)
(** Bitmap expressions **)
(************************)

  isc_info_rsb_and               =          1;
  isc_info_rsb_or                =          2;
  isc_info_rsb_dbkey             =          3;
  isc_info_rsb_index             =          4;

  isc_info_req_active            =          2;
  isc_info_req_inactive          =          3;
  isc_info_req_send              =          4;
  isc_info_req_receive           =          5;
  isc_info_req_select            =          6;
  isc_info_req_sql_stall         =          7;

(****************************)
(** Blob information items **)
(****************************)

  isc_info_blob_num_segments     =          4;
  isc_info_blob_max_segment      =          5;
  isc_info_blob_total_length     =          6;
  isc_info_blob_type             =          7;

(***********************************)
(** Transaction information items **)
(***********************************)

  isc_info_tra_id                =          4;

(*****************************************)
(* Service action items                 **)
(*****************************************)

  isc_action_svc_backup         = 1; (* Starts database backup process on the server *)
  isc_action_svc_restore        = 2; (* Starts database restore process on the server *)
  isc_action_svc_repair         = 3; (* Starts database repair process on the server *)
  isc_action_svc_add_user       = 4; (* Adds a new user to the security database *)
  isc_action_svc_delete_user    = 5; (* Deletes a user record from the security database *)
  isc_action_svc_modify_user    = 6; (* Modifies a user record in the security database *)
  isc_action_svc_display_user   = 7; (* Displays a user record from the security database *)
  isc_action_svc_properties     = 8; (* Sets database properties *)
  isc_action_svc_add_license    = 9; (* Adds a license to the license file *)
  isc_action_svc_remove_license = 10; (* Removes a license from the license file *)
  isc_action_svc_db_stats	= 11; (* Retrieves database statistics *)
  isc_action_svc_get_ib_log     = 12; (* Retrieves the InterBase log file from the server *)

(*****************************************)
(** Service information items           **)
(*****************************************)

  isc_info_svc_svr_db_info      = 50; (* Retrieves the number of attachments and databases *)
  isc_info_svc_get_license      = 51; (* Retrieves all license keys and IDs from the license file *)
  isc_info_svc_get_license_mask = 52; (* Retrieves a bitmask representing licensed options on the server *)
  isc_info_svc_get_config       = 53; (* Retrieves the parameters and values for IB_CONFIG *)
  isc_info_svc_version          = 54; (* Retrieves the version of the services manager *)
  isc_info_svc_server_version   = 55;(* Retrieves the version of the InterBase server *)
  isc_info_svc_implementation   = 56; (* Retrieves the implementation of the InterBase server *)
  isc_info_svc_capabilities     = 57; (* Retrieves a bitmask representing the server's capabilities *)
  isc_info_svc_user_dbpath      = 58; (* Retrieves the path to the security database in use by the server *)
  isc_info_svc_get_env	        = 59; (* Retrieves the setting of $INTERBASE *)
  isc_info_svc_get_env_lock     = 60; (* Retrieves the setting of $INTERBASE_LCK *)
  isc_info_svc_get_env_msg      = 61; (* Retrieves the setting of $INTERBASE_MSG *)
  isc_info_svc_line             = 62; (* Retrieves 1 line of service output per call *)
  isc_info_svc_to_eof           = 63; (* Retrieves as much of the server output as will fit in the supplied buffer *)
  isc_info_svc_timeout          = 64; (* Sets / signifies a timeout value for reading service information *)
  isc_info_svc_get_licensed_users = 65; (* Retrieves the number of users licensed for accessing the server *)
  isc_info_svc_limbo_trans	= 66; (* Retrieve the limbo transactions *)
  isc_info_svc_running		= 67; (* Checks to see if a service is running on an attachment *)
  isc_info_svc_get_users	= 68; (* Returns the user information from isc_action_svc_display_users *)

(*****************************************)
(* Parameters for isc_action_{add|delete|modify)_user *)
(*****************************************)

  isc_spb_sec_userid            = 5;
  isc_spb_sec_groupid           = 6;
  isc_spb_sec_username          = 7;
  isc_spb_sec_password          = 8;
  isc_spb_sec_groupname         = 9;
  isc_spb_sec_firstname         = 10;
  isc_spb_sec_middlename        = 11;
  isc_spb_sec_lastname          = 12;

(*****************************************)
(* Parameters for isc_action_svc_(add|remove)_license, *)
(* isc_info_svc_get_license                            *)
(*****************************************)

  isc_spb_lic_key               = 5;
  isc_spb_lic_id                = 6;
  isc_spb_lic_desc              = 7;  


(*****************************************)
(* Parameters for isc_action_svc_backup  *)
(*****************************************)

  isc_spb_bkp_file               = 5;
  isc_spb_bkp_factor             = 6;
  isc_spb_bkp_length             = 7;
  isc_spb_bkp_ignore_checksums   = $01;
  isc_spb_bkp_ignore_limbo       = $02;
  isc_spb_bkp_metadata_only      = $04;
  isc_spb_bkp_no_garbage_collect = $08;
  isc_spb_bkp_old_descriptions   = $10;
  isc_spb_bkp_non_transportable  = $20;
  isc_spb_bkp_convert            = $40;
  isc_spb_bkp_expand		 = $80;

(*****************************************)
(* Parameters for isc_action_svc_lock_stats *)
(*****************************************)

  isc_spb_lck_sample	      = 5;
  isc_spb_lck_secs	      = 6;
  isc_spb_lck_contents	      = $01;
  isc_spb_lck_summary	      = $02;
  isc_spb_lck_wait	      = $04;
  isc_spb_lck_stats	      = $08;

(*****************************************)
(* Parameters for isc_action_svc_properties *)
(*****************************************)

  isc_spb_prp_page_buffers	      = 5;
  isc_spb_prp_sweep_interval	      = 6;
  isc_spb_prp_shutdown_db	      =	7;
  isc_spb_prp_deny_new_attachments    = 9;
  isc_spb_prp_deny_new_transactions   = 10;
  isc_spb_prp_reserve_space	      = 11;
  isc_spb_prp_write_mode	      =	12;
  isc_spb_prp_access_mode	      =	13;
  isc_spb_prp_set_sql_dialect	      = 14;
  isc_spb_prp_activate		      = $0100;
  isc_spb_prp_db_online		      = $0200;

(*****************************************)
(* Parameters for isc_spb_prp_reserve_space *)
(*****************************************)

  isc_spb_prp_res_use_full	      = 35;
  isc_spb_prp_res		      =	36;

(*****************************************)
(* Parameters for isc_spb_prp_write_mode  *)
(*****************************************)

  isc_spb_prp_wm_async		= 37;
  isc_spb_prp_wm_sync		= 38;

(*****************************************)
(* Parameters for isc_spb_prp_access_mode *)
(*****************************************)

  isc_spb_prp_am_readonly	= 39;
  isc_spb_prp_am_readwrite	= 40;

(*****************************************)
(* Parameters for isc_action_svc_repair  *)
(*****************************************)

  isc_spb_rpr_commit_trans	       = 15;
  isc_spb_rpr_rollback_trans	       = 34;
  isc_spb_rpr_recover_two_phase	       = 17;
  isc_spb_tra_id                       = 18;
  isc_spb_single_tra_id		       = 19;
  isc_spb_multi_tra_id		       = 20;
  isc_spb_tra_state		       = 21;
  isc_spb_tra_state_limbo	       = 22;
  isc_spb_tra_state_commit	       = 23;
  isc_spb_tra_state_rollback	       = 24;
  isc_spb_tra_state_unknown	       = 25;
  isc_spb_tra_host_site		       = 26;
  isc_spb_tra_remote_site	       = 27;
  isc_spb_tra_db_path		       = 28;
  isc_spb_tra_advise		       = 29;
  isc_spb_tra_advise_commit	       = 30;
  isc_spb_tra_advise_rollback	       = 31;
  isc_spb_tra_advise_unknown	       = 33;

  isc_spb_rpr_list_limbo_trans	       = $01;
  isc_spb_rpr_check_db		       = $02;
  isc_spb_rpr_ignore_checksum	       = $04;
  isc_spb_rpr_kill_shadows	       = $08;
  isc_spb_rpr_mend_db		       = $10;
  isc_spb_rpr_sweep_db		       = $20;
  isc_spb_rpr_validate_db	       = $40;
  isc_spb_rpr_full		       = $80;

(*****************************************)
(* Parameters for isc_action_svc_restore  *)
(*****************************************)

  isc_spb_res_buffers		       = 9;
  isc_spb_res_page_size		       = 10;
  isc_spb_res_length		       = 11;
  isc_spb_res_access_mode	       = 12;
  isc_spb_res_deactivate_idx	       = $0100;
  isc_spb_res_no_shadow		       = $0200;
  isc_spb_res_no_validity	       = $0400;
  isc_spb_res_one_ata_time	       = $0800;
  isc_spb_res_replace		       = $1000;
  isc_spb_res_create		       = $2000;
  isc_spb_res_use_all_space	       = $4000;

(*****************************************)
(* Parameters for isc_spb_res_access_mode  *)
(*****************************************)

  isc_spb_res_am_readonly		= isc_spb_prp_am_readonly;
  isc_spb_res_am_readwrite		= isc_spb_prp_am_readwrite;

(*****************************************)
(* Parameters for isc_info_svc_svr_db_info *)
(*****************************************)

  isc_spb_num_att               = 5;
  isc_spb_num_db                = 6;

(*****************************************)
(* Parameters for isc_info_svc_db_stats  *)
(*****************************************)

  isc_spb_sts_data_pages	= $01;
  isc_spb_sts_db_log		= $02;
  isc_spb_sts_hdr_pages		= $04;
  isc_spb_sts_idx_pages		= $08;
  isc_spb_sts_sys_relations	= $10;


(***************************)
(** SQL information items **)
(***************************)

  isc_info_sql_select            =          4;
  isc_info_sql_bind              =          5;
  isc_info_sql_num_variables     =          6;
  isc_info_sql_describe_vars     =          7;
  isc_info_sql_describe_end      =          8;
  isc_info_sql_sqlda_seq         =          9;
  isc_info_sql_message_seq       =         10;
  isc_info_sql_type              =         11;
  isc_info_sql_sub_type          =         12;
  isc_info_sql_scale             =         13;
  isc_info_sql_length            =         14;
  isc_info_sql_null_ind          =         15;
  isc_info_sql_field             =         16;
  isc_info_sql_relation          =         17;
  isc_info_sql_owner             =         18;
  isc_info_sql_alias             =         19;
  isc_info_sql_sqlda_start       =         20;
  isc_info_sql_stmt_type         =         21;
  isc_info_sql_get_plan          =         22;
  isc_info_sql_records           =         23;
  isc_info_sql_batch_fetch       =         24;

(***********************************)
(** SQL information return values **)
(***********************************)

  isc_info_sql_stmt_select           =          1;
  isc_info_sql_stmt_insert           =          2;
  isc_info_sql_stmt_update           =          3;
  isc_info_sql_stmt_delete           =          4;
  isc_info_sql_stmt_ddl              =          5;
  isc_info_sql_stmt_get_segment      =          6;
  isc_info_sql_stmt_put_segment      =          7;
  isc_info_sql_stmt_exec_procedure   =          8;
  isc_info_sql_stmt_start_trans      =          9;
  isc_info_sql_stmt_commit           =         10;
  isc_info_sql_stmt_rollback         =         11;
  isc_info_sql_stmt_select_for_upd   =         12;
  isc_info_sql_stmt_set_generator    =         13;


(*************************************)
(** Server configuration key values **)
(*************************************)

  ISCCFG_LOCKMEM_KEY             =          0;
  ISCCFG_LOCKSEM_KEY             =          1;
  ISCCFG_LOCKSIG_KEY             =          2;
  ISCCFG_EVNTMEM_KEY             =          3;
  ISCCFG_DBCACHE_KEY             =          4;
  ISCCFG_PRIORITY_KEY            =          5;
  ISCCFG_IPCMAP_KEY              =          6;
  ISCCFG_MEMMIN_KEY              =          7;
  ISCCFG_MEMMAX_KEY              =          8;
  ISCCFG_LOCKORDER_KEY           =          9;
  ISCCFG_ANYLOCKMEM_KEY          =         10;
  ISCCFG_ANYLOCKSEM_KEY          =         11;
  ISCCFG_ANYLOCKSIG_KEY          =         12;
  ISCCFG_ANYEVNTMEM_KEY          =         13;
  ISCCFG_LOCKHASH_KEY            =         14;
  ISCCFG_DEADLOCK_KEY            =         15;
  ISCCFG_LOCKSPIN_KEY            =         16;
  ISCCFG_CONN_TIMEOUT_KEY        =         17;
  ISCCFG_DUMMY_INTRVL_KEY        =         18;
  ISCCFG_TRACE_POOLS_KEY         =         19;   //Internal Use only 
  ISCCFG_REMOTE_BUFFER_KEY	 =         20;


(*****************)
(** Error codes **)
(*****************)

  isc_facility                   =         20;
  isc_err_base                   =  335544320;
  isc_err_factor                 =          1;
  isc_arg_end                    =          0;
  isc_arg_gds                    =          1;
  isc_arg_string                 =          2;
  isc_arg_cstring                =          3;
  isc_arg_number                 =          4;
  isc_arg_interpreted            =          5;
  isc_arg_vms                    =          6;
  isc_arg_unix                   =          7;
  isc_arg_domain                 =          8;
  isc_arg_dos                    =          9;
  isc_arg_mpexl                  =         10;
  isc_arg_mpexl_ipc              =         11;
  isc_arg_next_mach              =         15;
  isc_arg_netware                =         16;
  isc_arg_win32                  =         17;
  isc_arg_warning                =         18;

(************************************************)
(** Dynamic Data Definition Language operators **)
(************************************************)

(********************)
(** Version number **)
(********************)

  isc_dyn_version_1              =          1;
  isc_dyn_eoc                    =         -1; // or 255 ?

(********************************)
(** Operations (may be nested) **)
(********************************)

  isc_dyn_begin                  =          2;
  isc_dyn_end                    =          3;
  isc_dyn_if                     =          4;
  isc_dyn_def_database           =          5;
  isc_dyn_def_global_fld         =          6;
  isc_dyn_def_local_fld          =          7;
  isc_dyn_def_idx                =          8;
  isc_dyn_def_rel                =          9;
  isc_dyn_def_sql_fld            =         10;
  isc_dyn_def_view               =         12;
  isc_dyn_def_trigger            =         15;
  isc_dyn_def_security_class     =        120;
  isc_dyn_def_dimension          =        140;
  isc_dyn_def_generator          =         24;
  isc_dyn_def_function           =         25;
  isc_dyn_def_filter             =         26;
  isc_dyn_def_function_arg       =         27;
  isc_dyn_def_shadow             =         34;
  isc_dyn_def_trigger_msg        =         17;
  isc_dyn_def_file               =         36;
  isc_dyn_mod_database           =         39;
  isc_dyn_mod_rel                =         11;
  isc_dyn_mod_global_fld         =         13;
  isc_dyn_mod_idx                =        102;
  isc_dyn_mod_local_fld          =         14;
  isc_dyn_mod_sql_fld          =          216;
  isc_dyn_mod_view               =         16;
  isc_dyn_mod_security_class     =        122;
  isc_dyn_mod_trigger            =        113;
  isc_dyn_mod_trigger_msg        =         28;
  isc_dyn_delete_database        =         18;
  isc_dyn_delete_rel             =         19;
  isc_dyn_delete_global_fld      =         20;
  isc_dyn_delete_local_fld       =         21;
  isc_dyn_delete_idx             =         22;
  isc_dyn_delete_security_class  =        123;
  isc_dyn_delete_dimensions      =        143;
  isc_dyn_delete_trigger         =         23;
  isc_dyn_delete_trigger_msg     =         29;
  isc_dyn_delete_filter          =         32;
  isc_dyn_delete_function        =         33;
  isc_dyn_delete_shadow          =         35;
  isc_dyn_grant                  =         30;
  isc_dyn_revoke                 =         31;
  isc_dyn_def_primary_key        =         37;
  isc_dyn_def_foreign_key        =         38;
  isc_dyn_def_unique             =         40;
  isc_dyn_def_procedure          =        164;
  isc_dyn_delete_procedure       =        165;
  isc_dyn_def_parameter          =        135;
  isc_dyn_delete_parameter       =        136;
  isc_dyn_mod_procedure          =        175;
  isc_dyn_def_log_file           =        176;
  isc_dyn_def_cache_file         =        180;
  isc_dyn_def_exception          =        181;
  isc_dyn_mod_exception          =        182;
  isc_dyn_del_exception          =        183;
  isc_dyn_drop_log               =        194;
  isc_dyn_drop_cache             =        195;
  isc_dyn_def_default_log        =        202;

(*************************)
(** View specific stuff **)
(*************************)

  isc_dyn_view_blr               =         43;
  isc_dyn_view_source            =         44;
  isc_dyn_view_relation          =         45;
  isc_dyn_view_context           =         46;
  isc_dyn_view_context_name      =         47;

(************************)
(** Generic attributes **)
(************************)

  isc_dyn_rel_name               =         50;
  isc_dyn_fld_name               =         51;
  isc_dyn_new_fld_name           =        215;
  isc_dyn_idx_name               =         52;
  isc_dyn_description            =         53;
  isc_dyn_security_class         =         54;
  isc_dyn_system_flag            =         55;
  isc_dyn_update_flag            =         56;
  isc_dyn_prc_name               =        166;
  isc_dyn_prm_name               =        137;
  isc_dyn_sql_object             =        196;
  isc_dyn_fld_character_set_name =        174;

(**********************************)
(** Relation specific attributes **)
(**********************************)

  isc_dyn_rel_dbkey_length       =         61;
  isc_dyn_rel_store_trig         =         62;
  isc_dyn_rel_modify_trig        =         63;
  isc_dyn_rel_erase_trig         =         64;
  isc_dyn_rel_store_trig_source  =         65;
  isc_dyn_rel_modify_trig_source =         66;
  isc_dyn_rel_erase_trig_source  =         67;
  isc_dyn_rel_ext_file           =         68;
  isc_dyn_rel_sql_protection     =         69;
  isc_dyn_rel_constraint         =        162;
  isc_dyn_delete_rel_constraint  =        163;

(**************************************)
(** Global field specific attributes **)
(**************************************)

  isc_dyn_fld_type               =         70;
  isc_dyn_fld_length             =         71;
  isc_dyn_fld_scale              =         72;
  isc_dyn_fld_sub_type           =         73;
  isc_dyn_fld_segment_length     =         74;
  isc_dyn_fld_query_header       =         75;
  isc_dyn_fld_edit_string        =         76;
  isc_dyn_fld_validation_blr     =         77;
  isc_dyn_fld_validation_source  =         78;
  isc_dyn_fld_computed_blr       =         79;
  isc_dyn_fld_computed_source    =         80;
  isc_dyn_fld_missing_value      =         81;
  isc_dyn_fld_default_value      =         82;
  isc_dyn_fld_query_name         =         83;
  isc_dyn_fld_dimensions         =         84;
  isc_dyn_fld_not_null           =         85;
  isc_dyn_fld_precision          =         86;
  isc_dyn_fld_char_length        =        172;
  isc_dyn_fld_collation          =        173;
  isc_dyn_fld_default_source     =        193;
  isc_dyn_del_default            =        197;
  isc_dyn_del_validation         =        198;
  isc_dyn_single_validation      =        199;
  isc_dyn_fld_character_set      =        203;

(*************************************)
(** Local field specific attributes **)
(*************************************)

  isc_dyn_fld_source             =         90;
  isc_dyn_fld_base_fld           =         91;
  isc_dyn_fld_position           =         92;
  isc_dyn_fld_update_flag        =         93;

(*******************************)
(** Index specific attributes **)
(*******************************)

  isc_dyn_idx_unique             =        100;
  isc_dyn_idx_inactive           =        101;
  isc_dyn_idx_type               =        103;
  isc_dyn_idx_foreign_key        =        104;
  isc_dyn_idx_ref_column         =        105;
  isc_dyn_idx_statistic          =        204;

(*********************************)
(** Trigger specific attributes **)
(*********************************)

  isc_dyn_trg_type               =        110;
  isc_dyn_trg_blr                =        111;
  isc_dyn_trg_source             =        112;
  isc_dyn_trg_name               =        114;
  isc_dyn_trg_sequence           =        115;
  isc_dyn_trg_inactive           =        116;
  isc_dyn_trg_msg_number         =        117;
  isc_dyn_trg_msg                =        118;

(****************************************)
(** Security Class specific attributes **)
(****************************************)

  isc_dyn_scl_acl                =        121;
  isc_dyn_grant_user             =        130;
  isc_dyn_grant_proc             =        186;
  isc_dyn_grant_trig             =        187;
  isc_dyn_grant_view             =        188;
  isc_dyn_grant_options          =        132;
  isc_dyn_grant_user_group       =        205;

(************************************)
(** Dimension specific information **)
(************************************)

  isc_dyn_dim_lower              =        141;
  isc_dyn_dim_upper              =        142;

(******************************)
(** File specific attributes **)
(******************************)

  isc_dyn_file_name              =        125;
  isc_dyn_file_start             =        126;
  isc_dyn_file_length            =        127;
  isc_dyn_shadow_number          =        128;
  isc_dyn_shadow_man_auto        =        129;
  isc_dyn_shadow_conditional     =        130;

(**********************************)
(** Log file specific attributes **)
(**********************************)

  isc_dyn_log_file_sequence      =        177;
  isc_dyn_log_file_partitions    =        178;
  isc_dyn_log_file_serial        =        179;
  isc_dyn_log_file_overflow      =        200;
  isc_dyn_log_file_raw           =        201;

(*****************************)
(** Log specific attributes **)
(*****************************)

  isc_dyn_log_group_commit_wait  =        189;
  isc_dyn_log_buffer_size        =        190;
  isc_dyn_log_check_point_length =        191;
  isc_dyn_log_num_of_buffers     =        192;

(**********************************)
(** Function specific attributes **)
(**********************************)

  isc_dyn_function_name          =        145;
  isc_dyn_function_type          =        146;
  isc_dyn_func_module_name       =        147;
  isc_dyn_func_entry_point       =        148;
  isc_dyn_func_return_argument   =        149;
  isc_dyn_func_arg_position      =        150;
  isc_dyn_func_mechanism         =        151;
  isc_dyn_filter_in_subtype      =        152;
  isc_dyn_filter_out_subtype     =        153;


  isc_dyn_description2           =        154;
  isc_dyn_fld_computed_source2   =        155;
  isc_dyn_fld_edit_string2       =        156;
  isc_dyn_fld_query_header2      =        157;
  isc_dyn_fld_validation_source2 =        158;
  isc_dyn_trg_msg2               =        159;
  isc_dyn_trg_source2            =        160;
  isc_dyn_view_source2           =        161;
  isc_dyn_xcp_msg2               =        184;

(***********************************)
(** Generator specific attributes **)
(***********************************)

  isc_dyn_generator_name         =         95;
  isc_dyn_generator_id           =         96;

(***********************************)
(** Procedure specific attributes **)
(***********************************)

  isc_dyn_prc_inputs             =        167;
  isc_dyn_prc_outputs            =        168;
  isc_dyn_prc_source             =        169;
  isc_dyn_prc_blr                =        170;
  isc_dyn_prc_source2            =        171;

(***********************************)
(** Parameter specific attributes **)
(***********************************)

  isc_dyn_prm_number             =        138;
  isc_dyn_prm_type               =        139;

(**********************************)
(** Relation specific attributes **)
(**********************************)

  isc_dyn_xcp_msg                =        185;

(************************************************)
(** Cascading referential integrity values     **)
(************************************************)
  isc_dyn_foreign_key_update     =        205;
  isc_dyn_foreign_key_delete     =        206;
  isc_dyn_foreign_key_cascade    =        207;
  isc_dyn_foreign_key_default    =        208;
  isc_dyn_foreign_key_null       =        209;
  isc_dyn_foreign_key_none       =        210;

(*************************)
(** SQL role values     **)
(*************************)
  isc_dyn_def_sql_role           =        211;
  isc_dyn_sql_role_name          =        212;
  isc_dyn_grant_admin_options    =        213;
  isc_dyn_del_sql_role           =        214;

(******************************)
(** Last $dyn value assigned **)
(******************************)

  isc_dyn_last_dyn_value         =        216;

(********************************************)
(** Array slice description language (SDL) **)
(********************************************)

  isc_sdl_version1               =          1;
  isc_sdl_eoc                    =         -1;	// or Byte(255)
  isc_sdl_relation               =          2;
  isc_sdl_rid                    =          3;
  isc_sdl_field                  =          4;
  isc_sdl_fid                    =          5;
  isc_sdl_struct                 =          6;
  isc_sdl_variable               =          7;
  isc_sdl_scalar                 =          8;
  isc_sdl_tiny_integer           =          9;
  isc_sdl_short_integer          =         10;
  isc_sdl_long_integer           =         11;
  isc_sdl_literal                =         12;
  isc_sdl_add                    =         13;
  isc_sdl_subtract               =         14;
  isc_sdl_multiply               =         15;
  isc_sdl_divide                 =         16;
  isc_sdl_negate                 =         17;
  isc_sdl_eql                    =         18;
  isc_sdl_neq                    =         19;
  isc_sdl_gtr                    =         20;
  isc_sdl_geq                    =         21;
  isc_sdl_lss                    =         22;
  isc_sdl_leq                    =         23;
  isc_sdl_and                    =         24;
  isc_sdl_or                     =         25;
  isc_sdl_not                    =         26;
  isc_sdl_while                  =         27;
  isc_sdl_assignment             =         28;
  isc_sdl_label                  =         29;
  isc_sdl_leave                  =         30;
  isc_sdl_begin                  =         31;
  isc_sdl_end                    =         32;
  isc_sdl_do3                    =         33;
  isc_sdl_do2                    =         34;
  isc_sdl_do1                    =         35;
  isc_sdl_element                =         36;

(**********************************************)
(** International text interpretation values **)
(**********************************************)

  isc_interp_eng_ascii           =          0;
  isc_interp_jpn_sjis            =          5;
  isc_interp_jpn_euc             =          6;

(******************************************)
(** Scroll direction for isc_dsql_fetch2 **)
(******************************************)

  isc_fetch_next                 =          0;
  isc_fetch_prior                =          1;
  isc_fetch_first                =          2;
  isc_fetch_last                 =          3;
  isc_fetch_absolute             =          4;
  isc_fetch_relative             =          5;

(*********************)
(** SQL definitions **)
(*********************)
  SQL_VARYING                    =        448;
  SQL_TEXT                       =        452;
  SQL_DOUBLE                     =        480;
  SQL_FLOAT                      =        482;
  SQL_LONG                       =        496;
  SQL_SHORT                      =        500;
  SQL_TIMESTAMP                  =        510;
  SQL_BLOB                       =        520;
  SQL_D_FLOAT                    =        530;
  SQL_ARRAY                      =        540;
  SQL_QUAD                       =        550;
  SQL_TYPE_TIME                  =        560;
  SQL_TYPE_DATE                  =        570;
  SQL_INT64                      =        580;
  // Historical alias for pre V6 applications   
  SQL_DATE                       =        SQL_TIMESTAMP;

(*******************)
(** Blob Subtypes **)
(*******************)

(** types less than zero are reserved for customer use **)

  isc_blob_untyped               =          0;

(** internal subtypes **)

  isc_blob_text                  =          1;
  isc_blob_blr                   =          2;
  isc_blob_acl                   =          3;
  isc_blob_ranges                =          4;
  isc_blob_summary               =          5;
  isc_blob_format                =          6;
  isc_blob_tra                   =          7;
  isc_blob_extfile               =          8;

(** the range 20-30 is reserved for dBASE and Paradox types **)

  isc_blob_formatted_memo        =         20;
  isc_blob_paradox_ole           =         21;
  isc_blob_graphic               =         22;
  isc_blob_dbase_ole             =         23;
  isc_blob_typed_binary          =         24;

type
{ TIntFunctions }
  TIntFunctions = class
  protected
    FLibHandle: THandle;
  public
  (***************************)
  (* OSRI database functions *)
  (***************************)
  isc_attach_database : function(
      status_vector            : PISC_STATUS;
      db_name_length           : Short;
      db_name                  : TSDCharPtr;
      db_handle                : PISC_DB_HANDLE;
      parm_buffer_length       : Short;
      parm_buffer              : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_blob_default_desc : procedure(
      desc		       : PISC_BLOB_DESC;
      table_name               : TSDCharPtr;
      column_name              : TSDCharPtr); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_blob_gen_bpb : function(
      status_vector            : PISC_STATUS;
      to_desc                  : PISC_BLOB_DESC;
      from_desc                : PISC_BLOB_DESC;
      bpb_buffer_length        : UShort;
      bpb_buffer               : TSDCharPtr;
      bpb_length               : PUShort): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_blob_info : function(
      status_vector            : PISC_STATUS;
      var blob_handle          : TISC_BLOB_HANDLE;
      item_list_buffer_length  : Short;
      item_list_buffer         : TSDCharPtr;
      result_buffer_length     : Short;
      result_buffer            : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_blob_lookup_desc : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      trans_handle             : PISC_TR_HANDLE;
      table_name               : TSDCharPtr;
      column_name              : TSDCharPtr;
      desc                     : PISC_BLOB_DESC;
      global_column_name       : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_blob_set_desc : function(
      status_vector            : PISC_STATUS;
      table_name               : TSDCharPtr;
      column_name              : TSDCharPtr;
      subtype,
      charset,
      segment_size             : Short;
      desc                     : PISC_BLOB_DESC): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_cancel_blob : function(
      status_vector            : PISC_STATUS;
      var blob_handle          : TISC_BLOB_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_cancel_events : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      event_id                 : PISC_LONG): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_close_blob : function(
      status_vector            : PISC_STATUS;
      var blob_handle          : TISC_BLOB_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_commit_retaining : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_commit_transaction : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_create_blob : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      tran_handle              : PISC_TR_HANDLE;
      var blob_handle          : TISC_BLOB_HANDLE;
      blob_id                  : PISC_QUAD): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_create_blob2 : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      tran_handle              : PISC_TR_HANDLE;
      var blob_handle          : TISC_BLOB_HANDLE;
      blob_id                  : PISC_QUAD;
      bpb_length               : Short;
      bpb_address              : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_create_database  : function(
      status_vector            : PISC_STATUS;
      db_name_length           : Short;
      db_name                  : TSDCharPtr;
      db_handle                : PISC_DB_HANDLE;
      parm_buffer_length       : Short;
      parm_buffer              : TSDCharPtr;
      parm_7                   : Short): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_database_info : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      item_list_buffer_length  : Short;
      item_list_buffer         : TSDCharPtr;
      result_buffer_length     : Short;
      result_buffer            : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_decode_date : procedure(
      ib_date: 		PISC_QUAD;
      var tm_date: 	TTimeDateRec); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_decode_sql_date : procedure(
      ib_date: 	PISC_DATE;
      var tm_date: 	TTimeDateRec); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_decode_sql_time : procedure(
      ib_time: 		PISC_TIME;
      var tm_date: 	TTimeDateRec); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_decode_timestamp : procedure(
      ib_timestamp: 	PISC_TIMESTAMP;
      var tm_date: 	TTimeDateRec); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_detach_database : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_drop_database : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_allocate_statement : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      stmt_handle              : PISC_STMT_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_alloc_statement2 : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      stmt_handle              : PISC_STMT_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_describe : function(
      status_vector            : PISC_STATUS;
      stmt_handle              : PISC_STMT_HANDLE;
      dialect                  : UShort;
      xsqlda                   : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_describe_bind : function(
      status_vector            : PISC_STATUS;
      stmt_handle              : PISC_STMT_HANDLE;
      dialect                  : UShort;
      xsqlda                   : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_execute : function(
      status_vector            : PISC_STATUS;
      tran_handle              : PISC_TR_HANDLE;
      stmt_handle              : PISC_STMT_HANDLE;
      dialect                  : UShort;
      xsqlda                   : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
  isc_dsql_execute2 : function(
      status_vector            : PISC_STATUS;
      tran_handle              : PISC_TR_HANDLE;
      stmt_handle              : PISC_STMT_HANDLE;
      dialect                  : UShort;
      in_xsqlda,
      out_xsqlda               : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_execute_immediate : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      tran_handle              : PISC_TR_HANDLE;
      length                   : UShort;
      statement                : TSDCharPtr;
      dialect                  : UShort;
      xsqlda                   : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_exec_immed2 : function(
      status_vector            : PISC_STATUS;
      db_handle                : PISC_DB_HANDLE;
      tran_handle              : PISC_TR_HANDLE;
      length                   : UShort;
      statement                : TSDCharPtr;
      dialect                  : UShort;
      in_xsqlda, out_xsqlda    : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_fetch : function(
      status_vector            : PISC_STATUS;
      stmt_handle              : PISC_STMT_HANDLE;
      dialect                  : UShort;
      xsqlda                   : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_finish : function(
      db_handle                : PISC_DB_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_free_statement : function(
      status_vector            : PISC_STATUS;
      stmt_handle              : PISC_STMT_HANDLE;
      option                   : UShort): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_prepare : function(
      status_vector            : PISC_STATUS;
      tran_handle              : PISC_TR_HANDLE;
      stmt_handle              : PISC_STMT_HANDLE;
      length                   : UShort;
      statement                : TSDCharPtr;
      dialect                  : UShort;
      xsqlda                   : PXSQLDA): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_set_cursor_name : function(
      status_vector            : PISC_STATUS;
      stmt_handle              : PISC_STMT_HANDLE;
      cursor_name              : TSDCharPtr;
      type_reserved            : UShort): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_dsql_sql_info : function(
      status_vector             : PISC_STATUS;
      stmt_handle               : PISC_STMT_HANDLE;
      item_length               : Short;
      items                     : TSDCharPtr;
      buffer_length             : Short;
      buffer                    : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_encode_date : procedure(
      	var tm_date:	TTimeDateRec;
      	ib_date:	PISC_QUAD); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_encode_sql_date : procedure(
  	var tm_date: 	TTimeDateRec;
        ib_date: 	PISC_DATE); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_encode_sql_time : procedure(
  	var tm_date: 	TTimeDateRec;
        ib_time:	PISC_TIME); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_encode_timestamp : procedure(
  	var tm_date: 	TTimeDateRec;
        ib_timestamp:	PISC_TIMESTAMP); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_event_counts : procedure(
      status_vector             : PISC_STATUS;
      buffer_length             : Short;
      event_buffer              : TSDCharPtr;
      result_buffer             : TSDCharPtr); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_get_segment : function(
      status_vector             : PISC_STATUS;
      var blob_handle           : TISC_BLOB_HANDLE;
      var actual_seg_length     : UShort;
      seg_buffer_length         : UShort;
      seg_buffer                : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_interprete : function(
      buffer                    : TSDCharPtr;
      var status_vector         : PISC_STATUS): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_open_blob : function(
      status_vector             : PISC_STATUS;
      db_handle                 : PISC_DB_HANDLE;
      tran_handle               : PISC_TR_HANDLE;
      var blob_handle           : TISC_BLOB_HANDLE;
      blob_id                   : PISC_QUAD): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_open_blob2 : function(
      status_vector             : PISC_STATUS;
      db_handle                 : PISC_DB_HANDLE;
      tran_handle               : PISC_TR_HANDLE;
      var blob_handle           : TISC_BLOB_HANDLE;
      blob_id                   : TISC_QUAD;
      bpb_length                : Short;
      bpb_buffer                : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_prepare_transaction : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_prepare_transaction2 : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE;
      msg_length		: Short;
      msg			: TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_print_sqlerror : procedure(
      sqlcode                   : Short;
      status_vector             : PISC_STATUS); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_print_status : function(
      status_vector             : PISC_STATUS): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_put_segment : function(
      status_vector             : PISC_STATUS;
      var blob_handle           : TISC_BLOB_HANDLE;
      seg_buffer_len            : UShort;
      seg_buffer                : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_rollback_retaining : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_rollback_transaction : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_start_multiple : function (
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE;
      db_handle_count           : Short;
      var teb_vector_address    : TISC_TEB): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_start_transaction : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE;
      db_handle_count           : Short;
      db_handle                 : PISC_DB_HANDLE;
      tpb_length                : Integer;      // UShort in ...
      tpb_address               : TSDCharPtr): ISC_STATUS; cdecl;

  isc_sqlcode: 		function(
      var status_vector             : PISC_STATUS): ISC_LONG; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_sql_interprete: 	procedure(
      sql_code			: Short;
      buffer                    : TSDCharPtr;
      buffer_length             : Short); {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_transaction_info : function(
      status_vector             : PISC_STATUS;
      tran_handle               : PISC_TR_HANDLE;
      item_list_buffer_length  : Short;
      item_list_buffer         : TSDCharPtr;
      result_buffer_length     : Short;
      result_buffer            : TSDCharPtr): ISC_STATUS; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_vax_integer : function(
      buffer                    : TSDCharPtr;
      length                    : Short): ISC_LONG; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_version : function(
      db_handle                 : PISC_DB_HANDLE;
      isc_arg2                  : TISC_CALLBACK;
      isc_arg3                  : PVoid): Int; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

	// Security Functions

  isc_add_user : function(
      status_vector             : PISC_STATUS;
      var user_sec_data         : TUSER_SEC_DATA): Int; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_delete_user : function(
      status_vector             : PISC_STATUS;
      var user_sec_data         : TUSER_SEC_DATA): Int; {$IFNDEF SD_CLR} stdcall; {$ENDIF}

  isc_modify_user : function(
      status_vector             : PISC_STATUS;
      var user_sec_data         : TUSER_SEC_DATA): Int; {$IFNDEF SD_CLR} stdcall; {$ENDIF}
	// not all function are declared !
  public
    procedure SetApiCalls(ASqlLibModule: THandle); virtual;
    procedure ClearApiCalls; virtual;
    function IsAvailFunc(AName: string): Boolean;
  end;	{ TIntFunctions }

const
  MaxTPBLength = 255;
  ESVBufferSize= 20*SizeOf(ISC_STATUS);		// array[0..19] of ISC_STATUS;	// error status vector

type
{ ESDIntError }
  ESDIntError = class(ESDEngineError);
  ESDIntErrorClass = class of ESDIntError;

{ TICustomIntDatabase }
  TIIntConnInfo	= packed record
    ServerType: Byte;
    DBHandle: PISC_DB_HANDLE;  		// database handle (C type - isc_db_handle, also pointer)
    TRHandle: PISC_TR_HANDLE;
  end;

  TICustomIntDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;

    FDPBBuffer: string;			// Database Parameter Buffer
    FDPBVersionLength: Short;      	// log on/log off independent part of database parameter block
    FDPBLength: Short;
    FTPBBuffer: TSDCharPtr;             // array[0..MaxTPBLength] of Char;
    FTPBConstLength: UShort;      	// log on/log off independent part of transaction parameter block
    FTPBLength: UShort;
    FesvPtr: PISC_STATUS;		// array[0..19] of ISC_STATUS;	// error status vector
    FIsEnableInts: Boolean;
    FSQLDialect: Integer;
    FTransActive: Boolean;		// transaction is active. It's set/reset in StartTransaction/Commit(Rollback)
    FTransRetaining: Boolean;           // when True, then try to use commit/rollback_retaining calls, else do not use these calls

    function GetApiCalls: TIntFunctions;
    function GetDBHandle: PISC_DB_HANDLE;
    function GetTRHandle: PISC_TR_HANDLE;
  protected
    FApiCalls: TIntFunctions;

    procedure AllocHandle(DBHandles: Boolean); virtual;
    procedure FreeHandle(DBHandles: Boolean); virtual;
    procedure Check(Status: ISC_STATUS);
    function ConstructTPB: Boolean;
    procedure ConstructDPB(sUserName, sPassword: string);
    function IsPreservedOnRollback: Boolean;

    procedure FreeSqlLib; virtual; abstract;
    procedure LoadSqlLib; virtual; abstract;
    function GetErrorClass: ESDEngineErrorClass; virtual; abstract;

    function GetHandle: TSDPtr; override;
    procedure DoConnect(const sRemoteDatabase, sUserName, sPassword: string); override;
    procedure DoDisconnect(Force: Boolean); override;
    procedure DoCommit; override;
    procedure DoRollback; override;
    procedure DoStartTransaction; override;
    procedure SetAutoCommitOption(Value: Boolean); override;
    procedure SetHandle(AHandle: TSDPtr); override;
  public
    constructor Create(ADbParams: TStrings); override;
    destructor Destroy; override;

    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;

    property ApiCalls: TIntFunctions read GetApiCalls;
    property DBHandle: PISC_DB_HANDLE read GetDBHandle;
    property TRHandle: PISC_TR_HANDLE read GetTRHandle;

    property IsEnableInts: Boolean read FIsEnableInts;
    property SQLDialect: Integer read FSQLDialect;
  end;

  TLongIntArray	= array[0..0] of LongInt;
  PLongIntArray	= ^TLongIntArray;

{ TICustomIntCommand }
  TICustomIntCommand = class(TISqlCommand)
  private
    FPStmtHandle: PISC_STMT_HANDLE; 	// pointer to statement handle (C type - isc_stmt_handle, also pointer)
    FesvPtr: PISC_STATUS;  	        // error status vector
    FOutXSQLDA: PXSQLDA;		// descriptors for all select-list items (returned columns)
    FInXSQLDA: PXSQLDA;                 // input descriptors for input parameters
    FStmtType: ISC_LONG;
    FBaseSelectBufferSize: Integer;
    FBaseBindBufferSize: Integer;
    FPseudoBlobSelBufOffs: Integer;	// offset in a select buffer to process VARCHAR(>8K size) column
    FExecuted: Boolean;                 // it is used to know that statement was executed

    function IBFieldDataType(SqlVar: TXSQLVAR): TFieldType;
    function IBReadBlob(BlobIDPtr: PISC_QUAD; var BlobData: TSDBlobData): Longint;
    function IBWriteBlobParam(BlobIDPtr: PISC_QUAD; const Buffer: TSDValueBuffer; Count: LongInt): Longint;
    procedure IBAllocOutDescs;
    procedure IBFreeOutDescs;
    procedure IBAllocInDescs;
    procedure IBFreeInDescs;

    procedure CnvtCurrencyToDBNumeric(Curr: Currency; var SqlVar: TXSQLVAR);
    function CnvtDBNumericToCurrency(SqlVar: TXSQLVAR; InData: TSDValueBuffer): Currency;
    function CnvtDBNumericToFloat(SqlVar: TXSQLVAR; InData: TSDValueBuffer): Double;
    function CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;

    function CreateNativeCommand(OldStmt: string): string;
    procedure Connect;
    procedure InternalGetParams;
    function GetApiCalls: TIntFunctions;
    function GetIsProcStmt: Boolean;
    function GetStmtType: ISC_LONG;
    function GetSqlDatabase: TICustomIntDatabase;
  protected
    procedure Check(Status: ISC_STATUS);

    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; override;

    function IsPseudoBlob(AFieldDesc: TSDFieldDesc): Boolean;
    function ExactNumberDataType(FieldType: TFieldType; Scale: Integer): TFieldType;
    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;

    procedure DoPrepare(Value: string); override;
    procedure DoExecDirect(Value: string); override;
    procedure DoExecute; override;

    function GetHandle: PSDCursor; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    function GetFieldsBufferSize: Integer; override;
    function GetParamsBufferSize: Integer; override;
    procedure InitParamList; override;
    procedure BindParamsBuffer; override;
    procedure FreeFieldsBuffer; override;
    procedure SetFieldsBuffer; override;

    property IsProcStmt: Boolean read GetIsProcStmt;
    property StmtType: ISC_LONG read GetStmtType;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    procedure InitNewCommand; override;
    function GetRowsAffected: Integer; override;
    function ResultSetExists: Boolean; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;

    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;
    property ApiCalls: TIntFunctions read GetApiCalls;
    property SqlDatabase: TICustomIntDatabase read GetSqlDatabase;    
  end;


{ TIIntDatabase }
  TIIntDatabase = class(TICustomIntDatabase)
  protected
    procedure FreeSqlLib; override;
    procedure LoadSqlLib; override;
    function GetErrorClass: ESDEngineErrorClass; override;
  public
    function CreateSqlCommand: TISqlCommand; override;
  end;

{ TIIntCommand }
  TIIntCommand = class(TICustomIntCommand)
  end;

const
  // list of client default DLLs from highest to lowest
  // real list of DLLs should be taken from global array
  DefSqlApiDLL	= 'gds32.dll';

var
  SqlApiDLL: string;
  IntCalls: TIntFunctions;

{*******************************************************************************
		Load/Unload Sql-library
*******************************************************************************}
procedure LoadSqlLib;
procedure FreeSqlLib;
procedure IntCheck( Status: ISC_STATUS; var StatusVector: PISC_STATUS;
	AErrorClass: ESDEngineErrorClass; ApiCalls: TIntFunctions);

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

{$IFDEF SD_CLR}

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_attach_database')]
function isc_attach_database(
    status_vector            : PISC_STATUS;
    db_name_length           : Short;
    db_name                  : TSDCharPtr;
    db_handle                : PISC_DB_HANDLE;
    parm_buffer_length       : Short;
    parm_buffer              : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_default_desc')]
procedure isc_blob_default_desc(
    desc		     : PISC_BLOB_DESC;
    table_name               : TSDCharPtr;
    column_name              : TSDCharPtr); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_gen_bpb')]
function isc_blob_gen_bpb(
    status_vector            : PISC_STATUS;
    to_desc                  : PISC_BLOB_DESC;
    from_desc                : PISC_BLOB_DESC;
    bpb_buffer_length        : UShort;
    bpb_buffer               : TSDCharPtr;
    bpb_length               : PUShort): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_info')]
function isc_blob_info (
    status_vector            : PISC_STATUS;
    var blob_handle          : TISC_BLOB_HANDLE;
    item_list_buffer_length  : Short;
    item_list_buffer         : TSDCharPtr;
    result_buffer_length     : Short;
    result_buffer            : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_lookup_desc')]
function isc_blob_lookup_desc(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    trans_handle             : PISC_TR_HANDLE;
    table_name               : TSDCharPtr;
    column_name              : TSDCharPtr;
    desc                     : PISC_BLOB_DESC;
    global_column_name       : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_blob_set_desc')]
function isc_blob_set_desc(
    status_vector            : PISC_STATUS;
    table_name               : TSDCharPtr;
    column_name              : TSDCharPtr;
    subtype,
    charset,
    segment_size             : Short;
    desc                     : PISC_BLOB_DESC): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_cancel_blob')]
function isc_cancel_blob(
    status_vector            : PISC_STATUS;
    var blob_handle          : TISC_BLOB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_cancel_events')]
function isc_cancel_events(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    event_id                 : PISC_LONG): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_close_blob')]
function isc_close_blob(
    status_vector            : PISC_STATUS;
    var blob_handle          : TISC_BLOB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_commit_retaining')]
function isc_commit_retaining(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_commit_transaction')]
function isc_commit_transaction(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_create_blob')]
function isc_create_blob(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    var blob_handle          : TISC_BLOB_HANDLE;
    blob_id                  : PISC_QUAD): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_create_blob2')]
function isc_create_blob2(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    var blob_handle          : TISC_BLOB_HANDLE;
    blob_id                  : PISC_QUAD;
    bpb_length               : Short;
    bpb_address              : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_create_database')]
function isc_create_database(
    status_vector            : PISC_STATUS;
    db_name_length           : Short;
    db_name                  : TSDCharPtr;
    db_handle                : PISC_DB_HANDLE;
    parm_buffer_length       : Short;
    parm_buffer              : TSDCharPtr;
    parm_7                   : Short): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_database_info')]
function isc_database_info(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    item_list_buffer_length  : Short;
    item_list_buffer         : TSDCharPtr;
    result_buffer_length     : Short;
    result_buffer            : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_date')]
procedure isc_decode_date(
    ib_date: 		PISC_QUAD;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_sql_date')]
procedure isc_decode_sql_date(
    ib_date: 	PISC_DATE;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_sql_time')]
procedure isc_decode_sql_time(
    ib_time: 		PISC_TIME;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_decode_timestamp')]
procedure isc_decode_timestamp(
    ib_timestamp: 	PISC_TIMESTAMP;
    var tm_date: 	TTimeDateRec); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_detach_database')]
function isc_detach_database(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_drop_database')]
function isc_drop_database(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_allocate_statement')]
function isc_dsql_allocate_statement(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_alloc_statement2')]
function isc_dsql_alloc_statement2(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_describe')]
function isc_dsql_describe(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_describe_bind')]
function isc_dsql_describe_bind(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_execute')]
function isc_dsql_execute(
    status_vector            : PISC_STATUS;
    tran_handle              : PISC_TR_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_execute2')]
function isc_dsql_execute2(
    status_vector            : PISC_STATUS;
    tran_handle              : PISC_TR_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    in_xsqlda,
    out_xsqlda               : PXSQLDA): ISC_STATUS;
    external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_execute_immediate')]
function isc_dsql_execute_immediate(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    length                   : UShort;
    statement                : TSDCharPtr;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_exec_immed2')]
function isc_dsql_exec_immed2(
    status_vector            : PISC_STATUS;
    db_handle                : PISC_DB_HANDLE;
    tran_handle              : PISC_TR_HANDLE;
    length                   : UShort;
    statement                : TSDCharPtr;
    dialect                  : UShort;
    in_xsqlda, out_xsqlda    : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_fetch')]
function isc_dsql_fetch(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_finish')]
function isc_dsql_finish(
    db_handle                : PISC_DB_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_free_statement')]
function isc_dsql_free_statement(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    option                   : UShort): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_prepare')]
function isc_dsql_prepare(
    status_vector            : PISC_STATUS;
    tran_handle              : PISC_TR_HANDLE;
    stmt_handle              : PISC_STMT_HANDLE;
    length                   : UShort;
    statement                : TSDCharPtr;
    dialect                  : UShort;
    xsqlda                   : PXSQLDA): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_set_cursor_name')]
function isc_dsql_set_cursor_name(
    status_vector            : PISC_STATUS;
    stmt_handle              : PISC_STMT_HANDLE;
    cursor_name              : TSDCharPtr;
    type_reserved            : UShort): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_dsql_sql_info')]
function isc_dsql_sql_info(
    status_vector             : PISC_STATUS;
    stmt_handle               : PISC_STMT_HANDLE;
    item_length               : Short;
    items                     : TSDCharPtr;
    buffer_length             : Short;
    buffer                    : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_date')]
procedure isc_encode_date(
    	var tm_date:	TTimeDateRec;
    	ib_date:	PISC_QUAD); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_sql_date')]
procedure isc_encode_sql_date(
	var tm_date: 	TTimeDateRec;
      ib_date: 	PISC_DATE); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_sql_time')]
procedure isc_encode_sql_time(
	var tm_date: 	TTimeDateRec;
      ib_time:	PISC_TIME); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_encode_timestamp')]
procedure isc_encode_timestamp(
	var tm_date: 	TTimeDateRec;
      ib_timestamp:	PISC_TIMESTAMP); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_event_counts')]
procedure isc_event_counts(
    status_vector             : PISC_STATUS;
    buffer_length             : Short;
    event_buffer              : TSDCharPtr;
    result_buffer             : TSDCharPtr); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_get_segment')]
function isc_get_segment(
    status_vector             : PISC_STATUS;
    var blob_handle           : TISC_BLOB_HANDLE;
    var actual_seg_length     : UShort;
    seg_buffer_length         : UShort;
    seg_buffer                : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_interprete')]
function isc_interprete(
    buffer                    : TSDCharPtr;
    var status_vector         : PISC_STATUS): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_open_blob')]
function isc_open_blob(
    status_vector             : PISC_STATUS;
    db_handle                 : PISC_DB_HANDLE;
    tran_handle               : PISC_TR_HANDLE;
    var blob_handle           : TISC_BLOB_HANDLE;
    blob_id                   : PISC_QUAD): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_open_blob2')]
function isc_open_blob2(
    status_vector             : PISC_STATUS;
    db_handle                 : PISC_DB_HANDLE;
    tran_handle               : PISC_TR_HANDLE;
    var blob_handle           : TISC_BLOB_HANDLE;
    blob_id                   : TISC_QUAD;
    bpb_length                : Short;
    bpb_buffer                : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_prepare_transaction')]
function isc_prepare_transaction(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_prepare_transaction2')]
function isc_prepare_transaction2(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE;
    msg_length		: Short;
    msg			: TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_print_sqlerror')]
procedure isc_print_sqlerror(
    sqlcode                   : Short;
    status_vector             : PISC_STATUS); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_print_status')]
function isc_print_status(
    status_vector             : PISC_STATUS): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_put_segment')]
function isc_put_segment(
    status_vector             : PISC_STATUS;
    var blob_handle           : TISC_BLOB_HANDLE;
    seg_buffer_len            : UShort;
    seg_buffer                : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_rollback_retaining')]
function isc_rollback_retaining(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_rollback_transaction')]
function isc_rollback_transaction(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_start_multiple')]
function isc_start_multiple(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE;
    db_handle_count           : Short;
    var teb_vector_address    : TISC_TEB): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_sqlcode')]
function isc_sqlcode(
    var status_vector             : PISC_STATUS): ISC_LONG; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_sql_interprete')]
procedure isc_sql_interprete(
    sql_code			: Short;
    buffer                    : TSDCharPtr;
    buffer_length             : Short); external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_transaction_info')]
function isc_transaction_info(
    status_vector             : PISC_STATUS;
    tran_handle               : PISC_TR_HANDLE;
    item_list_buffer_length  : Short;
    item_list_buffer         : TSDCharPtr;
    result_buffer_length     : Short;
    result_buffer            : TSDCharPtr): ISC_STATUS; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_vax_integer')]
function isc_vax_integer(
    buffer                    : TSDCharPtr;
    length                    : Short): ISC_LONG; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_version')]
function isc_version(
    db_handle                 : PISC_DB_HANDLE;
    isc_arg2                  : TISC_CALLBACK;
    isc_arg3                  : PVoid): Int; external;
	// Security Functions
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_add_user')]
function isc_add_user(
    status_vector             : PISC_STATUS;
    var user_sec_data         : TUSER_SEC_DATA): Int; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_delete_user')]
function isc_delete_user(
    status_vector             : PISC_STATUS;
    var user_sec_data         : TUSER_SEC_DATA): Int; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'isc_modify_user')]
function isc_modify_user(
    status_vector             : PISC_STATUS;
    var user_sec_data         : TUSER_SEC_DATA): Int; external;
{$ENDIF}

implementation

resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrFuncNotFound	= 'Function ''%s'' not found in Interbase Client library';

const
  ParamPrefix	= ':';
  ParamMarker	= '?';
  QuoteChar	= '"';	// for surroundings of the parameter's name, which can include, for example, spaces

const
  IBResultBufferSize = 1000;    // for isc_database_info call

// Global module variables
var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;
  dwLoadedFileVer: LongInt;     // version of client DLL used

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istInterbase) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TIIntDatabase.Create( ADbParams );
end;


{$IFNDEF SD_CLR}
procedure ExtractServerVersionStringCallback(user_arg: Pointer; str: TSDCharPtr); cdecl;
var
  nPos : Integer;
begin
  nPos := Pos('(access method)', str);
  if(nPos <> 0) then
    string(user_arg^) := str;
  nPos := Pos('(remote server)', str);
  if(nPos <> 0) then
    string(user_arg^) := str;
end;
{$ENDIF}

{ TIntFunctions }
function TIntFunctions.IsAvailFunc(AName: string): Boolean;
begin
  Result := Assigned( GetProcAddress(FLibHandle, {$IFDEF SD_CLR}AName{$ELSE}PChar(AName){$ENDIF}) );
end;

procedure TIntFunctions.SetApiCalls(ASqlLibModule: THandle);
begin
  FLibHandle := ASqlLibModule;
{$IFDEF SD_CLR}
  isc_attach_database 		:= SDInt.isc_attach_database;
  isc_blob_default_desc   	:= SDInt.isc_blob_default_desc;
  isc_blob_gen_bpb        	:= SDInt.isc_blob_gen_bpb;
  isc_blob_info       		:= SDInt.isc_blob_info;

  isc_blob_lookup_desc 		:= SDInt.isc_blob_lookup_desc;
  isc_blob_set_desc    		:= SDInt.isc_blob_set_desc;
  isc_cancel_blob      		:= SDInt.isc_cancel_blob;
  isc_cancel_events    		:= SDInt.isc_cancel_events;

  isc_close_blob      		:= SDInt.isc_close_blob;
  isc_commit_transaction 	:= SDInt.isc_commit_transaction;
  isc_commit_retaining 		:= SDInt.isc_commit_retaining;
  isc_create_blob     		:= SDInt.isc_create_blob;
  isc_create_blob2    		:= SDInt.isc_create_blob2;
  isc_create_database           := SDInt.isc_create_database;  

  isc_database_info    		:= SDInt.isc_database_info;
  isc_detach_database 		:= SDInt.isc_detach_database;
  isc_drop_database    		:= SDInt.isc_drop_database;

  isc_dsql_allocate_statement	:= SDInt.isc_dsql_allocate_statement;
  isc_dsql_alloc_statement2   	:= SDInt.isc_dsql_alloc_statement2;
  isc_dsql_describe 		:= SDInt.isc_dsql_describe;
  isc_dsql_describe_bind 	:= SDInt.isc_dsql_describe_bind;
  isc_dsql_execute 		:= SDInt.isc_dsql_execute;
  isc_dsql_execute2 		:= SDInt.isc_dsql_execute2;
  isc_dsql_execute_immediate  	:= SDInt.isc_dsql_execute_immediate;
  isc_dsql_exec_immed2    	:= SDInt.isc_dsql_exec_immed2;
  isc_dsql_fetch 		:= SDInt.isc_dsql_fetch;
  isc_dsql_finish	    	:= SDInt.isc_dsql_finish;
  isc_dsql_free_statement 	:= SDInt.isc_dsql_free_statement;
  isc_dsql_prepare 		:= SDInt.isc_dsql_prepare;
  isc_dsql_set_cursor_name    	:= SDInt.isc_dsql_set_cursor_name;
  isc_dsql_sql_info 		:= SDInt.isc_dsql_sql_info;

  isc_event_counts	    	:= SDInt.isc_event_counts;
  isc_get_segment     		:= SDInt.isc_get_segment;
  isc_interprete      		:= SDInt.isc_interprete;
  isc_open_blob       		:= SDInt.isc_open_blob;
  isc_open_blob2      		:= SDInt.isc_open_blob2;
  isc_prepare_transaction    	:= SDInt.isc_prepare_transaction;
  isc_prepare_transaction2    	:= SDInt.isc_prepare_transaction2;
  isc_print_sqlerror	    	:= SDInt.isc_print_sqlerror;
  isc_print_status	    	:= SDInt.isc_print_status;
  isc_put_segment     		:= SDInt.isc_put_segment;

  isc_rollback_transaction 	:= SDInt.isc_rollback_transaction;
  isc_rollback_retaining 	:= SDInt.isc_rollback_retaining;
  isc_start_multiple           	:= SDInt.isc_start_multiple;
  isc_start_transaction 	:= nil;
  isc_sqlcode      		:= SDInt.isc_sqlcode;
  isc_sql_interprete		:= SDInt.isc_sql_interprete;
  isc_transaction_info	    	:= SDInt.isc_transaction_info;

  isc_vax_integer     		:= SDInt.isc_vax_integer;
  isc_version	       		:= SDInt.isc_version;

  isc_decode_date     		:= SDInt.isc_decode_date;
  isc_encode_date     		:= SDInt.isc_encode_date;
  	// IB6 date/time functions
  isc_decode_sql_date 		:= SDInt.isc_decode_sql_date;
  isc_decode_sql_time 		:= SDInt.isc_decode_sql_time;
  isc_decode_timestamp		:= SDInt.isc_decode_timestamp;
  isc_encode_sql_date 		:= SDInt.isc_encode_sql_date;
  isc_encode_sql_time 		:= SDInt.isc_encode_sql_time;
  isc_encode_timestamp		:= SDInt.isc_encode_timestamp;
	// Security Functions
  isc_add_user	  	  	:= SDInt.isc_add_user;
  isc_delete_user	    	:= SDInt.isc_delete_user;
  isc_modify_user	    	:= SDInt.isc_modify_user;
{$ELSE}
	// new function of Interbase v.6 and above are loaded without assertions to exclude problems with earlier client libraries
  @isc_attach_database 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_attach_database');  	ASSERT(@isc_attach_database <> nil, Format(SErrFuncNotFound, ['isc_attach_database']));
  @isc_blob_default_desc   	:= Windows.GetProcAddress(ASqlLibModule, 'isc_blob_default_desc');
  @isc_blob_gen_bpb        	:= Windows.GetProcAddress(ASqlLibModule, 'isc_blob_gen_bpb');
  @isc_blob_info       		:= Windows.GetProcAddress(ASqlLibModule, 'isc_blob_info');     		ASSERT(@isc_blob_info <> nil, Format(SErrFuncNotFound, ['isc_blob_info']));

  @isc_blob_lookup_desc 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_blob_lookup_desc');
  @isc_blob_set_desc    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_blob_set_desc');
  @isc_cancel_blob      	:= Windows.GetProcAddress(ASqlLibModule, 'isc_cancel_blob');
  @isc_cancel_events    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_cancel_events');

  @isc_close_blob      		:= Windows.GetProcAddress(ASqlLibModule, 'isc_close_blob');     	ASSERT(@isc_close_blob <> nil, Format(SErrFuncNotFound, ['isc_close_blob']));
  @isc_commit_transaction 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_commit_transaction');   	ASSERT(@isc_commit_transaction <> nil, Format(SErrFuncNotFound, ['isc_commit_transaction']));
  @isc_commit_retaining 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_commit_retaining');    	ASSERT(@isc_commit_retaining <> nil, Format(SErrFuncNotFound, ['isc_commit_retaining']));
  @isc_create_blob     		:= Windows.GetProcAddress(ASqlLibModule, 'isc_create_blob');     	ASSERT(@isc_create_blob <> nil, Format(SErrFuncNotFound, ['isc_create_blob']));
  @isc_create_blob2    		:= Windows.GetProcAddress(ASqlLibModule, 'isc_create_blob2');     	ASSERT(@isc_create_blob2 <> nil, Format(SErrFuncNotFound, ['isc_create_blob2']));
  @isc_create_database 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_create_database');  	ASSERT(@isc_create_database <> nil, Format(SErrFuncNotFound, ['isc_create_database']));

  @isc_database_info    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_database_info');
  @isc_detach_database 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_detach_database');  	ASSERT(@isc_detach_database <> nil, Format(SErrFuncNotFound, ['isc_detach_database']));
  @isc_drop_database    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_drop_database');

  @isc_dsql_allocate_statement	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_allocate_statement');ASSERT(@isc_dsql_allocate_statement <> nil, Format(SErrFuncNotFound, ['isc_dsql_allocate_statement']));
  @isc_dsql_alloc_statement2   	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_alloc_statement2');
  @isc_dsql_describe 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_describe');     	ASSERT(@isc_dsql_describe <> nil, Format(SErrFuncNotFound, ['isc_dsql_describe']));
  @isc_dsql_describe_bind 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_describe_bind');	ASSERT(@isc_dsql_describe_bind <> nil, Format(SErrFuncNotFound, ['isc_dsql_describe_bind']));
  @isc_dsql_execute 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_execute'); 		ASSERT(@isc_dsql_execute <> nil, Format(SErrFuncNotFound, ['isc_dsql_execute']));
  @isc_dsql_execute2 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_execute2'); 		ASSERT(@isc_dsql_execute2 <> nil, Format(SErrFuncNotFound, ['isc_dsql_execute2']));
  @isc_dsql_execute_immediate  	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_execute_immediate');
  @isc_dsql_exec_immed2    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_exec_immed2');
  @isc_dsql_fetch 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_fetch');   		ASSERT(@isc_dsql_fetch <> nil, Format(SErrFuncNotFound, ['isc_dsql_fetch']));
  @isc_dsql_finish	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_finish');
  @isc_dsql_free_statement 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_free_statement');	ASSERT(@isc_dsql_free_statement <> nil, Format(SErrFuncNotFound, ['isc_dsql_free_statement']));
  @isc_dsql_prepare 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_prepare'); 		ASSERT(@isc_dsql_prepare <> nil, Format(SErrFuncNotFound, ['isc_dsql_prepare']));
  @isc_dsql_set_cursor_name    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_set_cursor_name');
  @isc_dsql_sql_info 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_dsql_sql_info');     	ASSERT(@isc_dsql_sql_info <> nil, Format(SErrFuncNotFound, ['isc_dsql_sql_info']));

  @isc_event_counts	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_event_counts');
  @isc_get_segment     		:= Windows.GetProcAddress(ASqlLibModule, 'isc_get_segment');     	ASSERT(@isc_get_segment <> nil, Format(SErrFuncNotFound, ['isc_get_segment']));
  @isc_interprete      		:= Windows.GetProcAddress(ASqlLibModule, 'isc_interprete');  		ASSERT(@isc_interprete <> nil,  Format(SErrFuncNotFound, ['isc_interprete']));
  @isc_open_blob       		:= Windows.GetProcAddress(ASqlLibModule, 'isc_open_blob');     		ASSERT(@isc_open_blob <> nil, Format(SErrFuncNotFound, ['isc_open_blob']));
  @isc_open_blob2      		:= Windows.GetProcAddress(ASqlLibModule, 'isc_open_blob2');     	ASSERT(@isc_open_blob2 <> nil, Format(SErrFuncNotFound, ['isc_open_blob2']));
  @isc_prepare_transaction    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_prepare_transaction');
  @isc_prepare_transaction2    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_prepare_transaction2');
  @isc_print_sqlerror	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_print_sqlerror');
  @isc_print_status	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_print_status');
  @isc_put_segment     		:= Windows.GetProcAddress(ASqlLibModule, 'isc_put_segment');     	ASSERT(@isc_put_segment <> nil, Format(SErrFuncNotFound, ['isc_put_segment']));

  @isc_rollback_transaction 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_rollback_transaction');	ASSERT(@isc_rollback_transaction <> nil, Format(SErrFuncNotFound, ['isc_rollback_transaction']));
  @isc_rollback_retaining 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_rollback_retaining');	// it presents in IB v.6
  @isc_start_multiple           := Windows.GetProcAddress(ASqlLibModule, 'isc_start_multiple');     	ASSERT(@isc_start_multiple <> nil, Format(SErrFuncNotFound, ['isc_start_multiple']));
  @isc_start_transaction 	:= Windows.GetProcAddress(ASqlLibModule, 'isc_start_transaction');     	ASSERT(@isc_start_transaction <> nil, Format(SErrFuncNotFound, ['isc_start_transaction']));
  @isc_sqlcode      		:= Windows.GetProcAddress(ASqlLibModule, 'isc_sqlcode');  		ASSERT(@isc_sqlcode <> nil,     Format(SErrFuncNotFound, ['isc_sqlcode']));
  @isc_sql_interprete		:= Windows.GetProcAddress(ASqlLibModule, 'isc_sql_interprete');  	ASSERT(@isc_sql_interprete <> nil, Format(SErrFuncNotFound, ['isc_sql_interprete']));
  @isc_transaction_info	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_transaction_info');

  @isc_vax_integer     		:= Windows.GetProcAddress(ASqlLibModule, 'isc_vax_integer'); 		ASSERT(@isc_vax_integer <> nil, Format(SErrFuncNotFound, ['isc_vax_integer']));
  @isc_version	       		:= Windows.GetProcAddress(ASqlLibModule, 'isc_version');  		ASSERT(@isc_version <> nil, 	Format(SErrFuncNotFound, ['isc_version']));

  @isc_decode_date     		:= Windows.GetProcAddress(ASqlLibModule, 'isc_decode_date'); 		ASSERT(@isc_decode_date <> nil, Format(SErrFuncNotFound, ['isc_decode_date']));
  @isc_encode_date     		:= Windows.GetProcAddress(ASqlLibModule, 'isc_encode_date'); 		ASSERT(@isc_encode_date <> nil, Format(SErrFuncNotFound, ['isc_encode_date']));
  	// IB6 date/time functions
  @isc_decode_sql_date 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_decode_sql_date');
  @isc_decode_sql_time 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_decode_sql_time');
  @isc_decode_timestamp		:= Windows.GetProcAddress(ASqlLibModule, 'isc_decode_timestamp');
  @isc_encode_sql_date 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_encode_sql_date');
  @isc_encode_sql_time 		:= Windows.GetProcAddress(ASqlLibModule, 'isc_encode_sql_time');
  @isc_encode_timestamp		:= Windows.GetProcAddress(ASqlLibModule, 'isc_encode_timestamp');
	// Security Functions
  @isc_add_user	  	  	:= Windows.GetProcAddress(ASqlLibModule, 'isc_add_user');
  @isc_delete_user	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_delete_user');
  @isc_modify_user	    	:= Windows.GetProcAddress(ASqlLibModule, 'isc_modify_user');
{$ENDIF}
end;

procedure TIntFunctions.ClearApiCalls;
begin
  FLibHandle := 0;

  @isc_attach_database 		:= nil;
  @isc_blob_default_desc   	:= nil;
  @isc_blob_gen_bpb        	:= nil;
  @isc_blob_info       		:= nil;

  @isc_blob_lookup_desc 	:= nil;
  @isc_blob_set_desc    	:= nil;
  @isc_cancel_blob      	:= nil;
  @isc_cancel_events    	:= nil;

  @isc_close_blob      		:= nil;
  @isc_commit_transaction 	:= nil;
  @isc_commit_retaining 	:= nil;
  @isc_create_blob     		:= nil;
  @isc_create_blob2    		:= nil;
  @isc_create_database          := nil;
  
  @isc_database_info    	:= nil;
  @isc_detach_database 		:= nil;
  @isc_drop_database    	:= nil;

  @isc_dsql_allocate_statement	:= nil;
  @isc_dsql_alloc_statement2   	:= nil;
  @isc_dsql_describe 		:= nil;
  @isc_dsql_describe_bind 	:= nil;
  @isc_dsql_execute 		:= nil;
  @isc_dsql_execute2 		:= nil;
  @isc_dsql_execute_immediate  	:= nil;
  @isc_dsql_exec_immed2    	:= nil;
  @isc_dsql_fetch 		:= nil;
  @isc_dsql_finish	    	:= nil;
  @isc_dsql_free_statement 	:= nil;
  @isc_dsql_prepare 		:= nil;
  @isc_dsql_set_cursor_name    	:= nil;
  @isc_dsql_sql_info 		:= nil;

  @isc_event_counts	    	:= nil;
  @isc_get_segment     		:= nil;
  @isc_interprete      		:= nil;
  @isc_open_blob       		:= nil;
  @isc_open_blob2      		:= nil;
  @isc_prepare_transaction    	:= nil;
  @isc_prepare_transaction2    	:= nil;
  @isc_print_sqlerror	    	:= nil;
  @isc_print_status	    	:= nil;
  @isc_put_segment     		:= nil;

  @isc_rollback_transaction 	:= nil;
  @isc_rollback_retaining 	:= nil;
  @isc_start_multiple           := nil;
  @isc_start_transaction 	:= nil;
  @isc_sqlcode      		:= nil;
  @isc_sql_interprete		:= nil;
  @isc_transaction_info	    	:= nil;

  @isc_vax_integer     		:= nil;
  @isc_version	       		:= nil;

  @isc_decode_date     		:= nil;
  @isc_encode_date     		:= nil;
  	// IB6 date/time functions
  @isc_decode_sql_date 		:= nil;
  @isc_decode_sql_time 		:= nil;
  @isc_decode_timestamp		:= nil;
  @isc_encode_sql_date 		:= nil;
  @isc_encode_sql_time 		:= nil;
  @isc_encode_timestamp		:= nil;
	// Security Functions
  @isc_add_user	  	  	:= nil;
  @isc_delete_user	    	:= nil;
  @isc_modify_user	    	:= nil;
end;

procedure LoadSqlLib;
var
  sFileName:string;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      sFileName := SqlApiDLL;
      hSqlLibModule := HelperLoadLibrary(sFileName);
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [sFileName]);
      Inc(SqlLibRefCount);
      IntCalls.SetApiCalls( hSqlLibModule );
      dwLoadedFileVer := GetFileVersion(sFileName);
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
      if Windows.FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ SqlApiDLL ]);
      Dec(SqlLibRefCount);
      IntCalls.ClearApiCalls;
      dwLoadedFileVer := 0;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;

procedure IntCheck( Status: ISC_STATUS; var StatusVector: PISC_STATUS;
	AErrorClass: ESDEngineErrorClass; ApiCalls: TIntFunctions);
const
  SQL_ERROR_INVALID = -999;
  SQL_ERROR_RECLOSE_CURSOR = -501;
  MsgBufSize = 512;
var
  buffer: TSDCharPtr;
  sMsg : string;
  pCurStatus : PISC_STATUS;
  iSQLCode: ISC_LONG;
begin
  if Status = 0 then
    Exit;

  sMsg := '';
  buffer := SafeReallocMem(nil, MsgBufSize);
  try
  	// walk through error vector and constract error string
    pCurStatus := PISC_STATUS( StatusVector );
    while ApiCalls.isc_interprete( buffer, pCurStatus ) <> 0 do
      sMsg := sMsg + Char(13) + Char(10) + HelperPtrToString(buffer);
  finally
    SafeReallocMem(buffer, 0);
  end;

  	// get SQL error code
  iSQLCode := SQL_ERROR_INVALID;
  if ApiCalls.IsAvailFunc( 'isc_sqlcode' ) then
    iSQLCode := ApiCalls.isc_sqlcode( StatusVector );
  	// if no valid SQL error code is found
  if iSQLCode = SQL_ERROR_INVALID then
    iSQLCode := Status;

	// ignore reclose on closed cursor message
  if iSQLCode = SQL_ERROR_RECLOSE_CURSOR then
    Exit;

  raise AErrorClass.CreateDefPos(iSQLCode, iSQLCode, sMsg);
end;

// Interbase helpers
function XSQLDA_LENGTH(n: Long): Long;
(*  The C-macro reads like this:
   XSQLDA_LENGTH(n)	(sizeof (XSQLDA) + (n-1) * sizeof (XSQLVAR)) *)
begin
{$IFDEF SD_CLR}
	// include size of one TXSQLVAR at least to exclude an exception in case of call isc_dsql_describe or SetSQLDAToPtr
  if n = 0 then
    Inc(n);
  Result := Marshal.SizeOf(TypeOf(TXSQLDA)) + ((n - 1) * Marshal.SizeOf(TypeOf(TXSQLVAR)));
{$ELSE}
  Result := SizeOf(TXSQLDA) + ((n - 1) * SizeOf(TXSQLVAR));
{$ENDIF}
end;

// Copy only fields of XSQLDA structure
function GetSQLDA(AXSQLDAPtr: PXSQLDA): TXSQLDA;
begin
  ASSERT( Assigned(AXSQLDAPtr) );
{$IFDEF SD_CLR}
  Result := TXSQLDA( Marshal.PtrToStructure(AXSQLDAPtr, TypeOf(TXSQLDA)) );
{$ELSE}
  Move(AXSQLDAPtr^, Result, SizeOf(TXSQLDA) - SizeOf(TXSQLVAR));
{$ENDIF}
end;

procedure SetSQLDAToPtr(ASqlDA: TXSQLDA; AXSQLDAPtr: PXSQLDA);
begin
  ASSERT( Assigned(AXSQLDAPtr) );
{$IFDEF SD_CLR}
  Marshal.StructureToPtr(ASqlDA, AXSQLDAPtr, False);
{$ELSE}
  Move(ASqlDA, AXSQLDAPtr^, SizeOf(TXSQLDA) - SizeOf(TXSQLVAR));
{$ENDIF}
end;

function GetSQLVAR(DAPtr: PXSQLDA; Index: Integer): TXSQLVAR;
{$IFDEF SD_CLR}
var
  SqlVarPtr: PXSQLVAR;
{$ENDIF}
begin
  ASSERT( Assigned(DAPtr) );
{$IFDEF SD_CLR}
  SqlVarPtr := IncPtr( DAPtr, LongInt( Marshal.OffsetOf(TypeOf(TXSQLDA), 'sqlvar') ) + Marshal.SizeOf(TypeOf(TXSQLVAR))*Index );
  Result := TXSQLVAR( Marshal.PtrToStructure(SqlVarPtr, TypeOf(TXSQLVAR)) );
{$ELSE}
  Result := DAPtr^.sqlvar[Index];       // da.sqlvar[Index] returns invalid result, maybe because array[0..0]
{$ENDIF}
end;

procedure SetSQLVAR(DAPtr: PXSQLDA; Index: Integer; SqlVar: TXSQLVAR);
{$IFDEF SD_CLR}
var
  SqlVarPtr: PXSQLVAR;
{$ENDIF}
begin
  ASSERT( Assigned(DAPtr) );
{$IFDEF SD_CLR}
  SqlVarPtr := IncPtr( DAPtr, LongInt( Marshal.OffsetOf(TypeOf(TXSQLDA), 'sqlvar') ) + Marshal.SizeOf(TypeOf(TXSQLVAR))*Index );
  Marshal.StructureToPtr( SqlVar, SqlVarPtr, True );
{$ELSE}
  DAPtr^.sqlvar[Index] := SqlVar;
{$ENDIF}
end;

function FormatIdentifier(Dialect: Integer; Value: string): string;
begin
  if Dialect = 1 then
    Value := UpperCase(Trim(Value))
  else
{$IFDEF SD_D4}
    Value := '"' + StringReplace(TrimRight(Value), '"', '""', [rfReplaceAll]) + '"';
{$ELSE}
    ASSERT( False, 'StringReplace function is not defined' );
{$ENDIF}
  Result := Value;
end;

function FormatIdentifierValue(Dialect: Integer; Value: string): string;
begin
  if Dialect = 1 then
    Result := UpperCase(Trim(Value))
  else
    Result := Value;
end;

// where the statement text contains CREATE DATABASE command
function IsCreateDbCommand(const s: string): Boolean;
const
  CreateDbCmd = 'CREATE DATABASE';
begin
  Result := False;
  if Length(CreateDbCmd) > Length(s) then
    Exit;
  Result := Pos(CreateDbCmd, UpperCase( Copy(s, 1, Length(CreateDbCmd)) )) = 1;
end;

{ TICustomIntDatabase }
constructor TICustomIntDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle := nil;
  FApiCalls := nil;
        // pointer to error status vector
  FesvPtr := SafeReallocMem(nil, ESVBufferSize);
  SafeInitMem(FesvPtr, ESVBufferSize, 0);

        // database parameter block is not completed, only version
  FDPBVersionLength := 0;
  SetLength(FDPBBuffer, 1);
  FDPBBuffer[1] := Char(isc_dpb_version1);
  Inc(FDPBVersionLength);
  FDPBLength := FDPBVersionLength;

  FTPBBuffer := SafeReallocMem(nil, MaxTPBLength);
        // transaction parameter block is completed (with default values)
  FTPBConstLength := 0;
  HelperMemWriteByte(FTPBBuffer, FTPBConstLength, isc_tpb_version3);
  Inc(FTPBConstLength);
  HelperMemWriteByte(FTPBBuffer, FTPBConstLength, isc_tpb_write);
  Inc(FTPBConstLength);
  HelperMemWriteByte(FTPBBuffer, FTPBConstLength, isc_tpb_wait);
  Inc(FTPBConstLength);
  // const part is over, not variable (isolation level)
  FTPBLength := FTPBConstLength;
  HelperMemWriteByte(FTPBBuffer, FTPBLength, isc_tpb_concurrency);
  Inc(FTPBLength);

	// by default IsEnableInts = False
  FIsEnableInts := UpperCase( Trim( Params.Values[szENABLEINTS] ) ) = STrueString;
  	// by default SQLDialect = 1
  FSQLDialect := StrToIntDef( Trim( Params.Values[szSQLDialect] ), SQL_DIALECT_V5 );
        // default value is True
  FTransRetaining := UpperCase( Trim( Params.Values[szTRANSRETAINING] ) ) <> SFalseString;
end;

destructor TICustomIntDatabase.Destroy;
begin
  FreeHandle(False);
  FTPBBuffer := SafeReallocMem(FTPBBuffer, 0);
  FesvPtr := SafeReallocMem(FesvPtr, 0);
  if AcquiredHandle then
    FreeSqlLib;

  inherited;
end;

function TICustomIntDatabase.GetApiCalls: TIntFunctions;
begin
  Result := FApiCalls;
end;

procedure TICustomIntDatabase.Check(Status: ISC_STATUS);
begin
  ResetIdleTimeOut;
  if Status = 0 then
    Exit;
  ResetBusyState;

  IntCheck( Status, FesvPtr, GetErrorClass, ApiCalls );
end;

procedure TICustomIntDatabase.DoStartTransaction;
begin
{$IFNDEF SD_CLR}
  // always keep transaction open
  ASSERT(TRHandle^ <> nil);
{$ENDIF}

  FTransActive := True;	// TransStarting
  // if isolation level (or other parameters)is changed,
  // then rollback and start new transaction explicitly
  if ConstructTPB then
    Rollback;   // this rollback can destroy active result sets. To fix the problem CursorPreservedOnStartTransaction property can be added for TISqlDatabase

{$IFNDEF SD_CLR}
  ASSERT(TRHandle^ <> nil);
{$ENDIF}
end;

procedure TICustomIntDatabase.DoCommit;
var
  TEB: TISC_TEB;
begin
{$IFNDEF SD_CLR}
  // always keep transaction open
  ASSERT( TRHandle^ <> nil );
{$ENDIF}
  if FTransRetaining then
    Check( ApiCalls.isc_commit_retaining(FesvPtr, TRHandle) )
  else begin
    Check( ApiCalls.isc_commit_transaction(FesvPtr, TRHandle) );

    // reopen
    ConstructTPB();
    TEB.db_handle := DBHandle;
    TEB.tpb_length := FTPBLength;
    TEB.tpb_address := FTPBBuffer;
    Check( ApiCalls.isc_start_multiple(FesvPtr, TRHandle, 1, TEB) );
  end;

  FTransActive := False;
{$IFNDEF SD_CLR}
  ASSERT( TRHandle^ <> nil);
{$ENDIF}
end;

procedure TICustomIntDatabase.DoRollback;
var
  TEB: TISC_TEB;
begin
{$IFNDEF SD_CLR}
  	// always keep transaction open
  ASSERT( TRHandle^ <> nil);
{$ENDIF}
	// for IB v.6. If AutoCommit is set on, it's necessary to recreate a transaction
  if IsPreservedOnRollback then begin
    Check( ApiCalls.isc_rollback_retaining(FesvPtr, TRHandle) );
  end else begin
  	// Preserve active result sets !
        //(explicitly start new transaction will destroy existing result sets)
    Check( ApiCalls.isc_rollback_transaction(FesvPtr, TRHandle) );

    // reopen
    ConstructTPB();
    TEB.db_handle := DBHandle;
    TEB.tpb_length := FTPBLength;
    TEB.tpb_address := FTPBBuffer;
    Check( ApiCalls.isc_start_multiple(FesvPtr, TRHandle, 1, TEB) );
  end;

  FTransActive := False;
{$IFNDEF SD_CLR}
  ASSERT( TRHandle^ <> nil);
{$ENDIF}
end;

function TICustomIntDatabase.IsPreservedOnRollback: Boolean;
begin
  	// for IB v.6+ and AutoCommit is off
	// If AutoCommit is set on, it's necessary to recreate a transaction
        //to turn off inside StartTransaction and turn on back in Commit/Rollback
  Result := FTransRetaining and
            ApiCalls.IsAvailFunc('isc_rollback_retaining') and
            not AutoCommit;
end;

function TICustomIntDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
const
  SQueryIntStoredProcNamesFmt =
	'select '''' as '+CAT_NAME_FIELD+', RDB$OWNER_NAME as '+SCH_NAME_FIELD+
        ', RDB$PROCEDURE_NAME as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
	', RDB$PROCEDURE_INPUTS as '+PROC_IN_PARAMS+', RDB$PROCEDURE_OUTPUTS as '+ PROC_OUT_PARAMS+
        ', RDB$SYSTEM_FLAG'+
        ' from RDB$PROCEDURES where RDB$SYSTEM_FLAG = 0 '+
        '%s order by RDB$OWNER_NAME, RDB$PROCEDURE_NAME';
  SQueryIntProcParamsFmt =
        'select '''' as '+CAT_NAME_FIELD+', RDB$OWNER_NAME as '+SCH_NAME_FIELD+
        ', PP.RDB$PROCEDURE_NAME as '+PROC_NAME_FIELD+', 0 as '+PROC_TYPE_FIELD+
        ', RDB$PARAMETER_NAME as '+PARAM_NAME_FIELD+', RDB$PARAMETER_NUMBER as '+PARAM_POS_FIELD+
        ', RDB$PARAMETER_TYPE as '+PARAM_TYPE_FIELD+', RDB$PROCEDURE_SOURCE, RDB$FIELD_SOURCE'+
        ' from RDB$PROCEDURES PR, RDB$PROCEDURE_PARAMETERS PP ' +
        'where PR.RDB$PROCEDURE_NAME = PP.RDB$PROCEDURE_NAME ' +
        ' %s order by RDB$OWNER_NAME, PP.RDB$PROCEDURE_NAME, RDB$PARAMETER_NUMBER';
  SQueryIntTableNamesFmt =
  	'select '''' as '+CAT_NAME_FIELD+', RDB$OWNER_NAME as '+SCH_NAME_FIELD+
        ', RDB$RELATION_NAME as '+TBL_NAME_FIELD+
        ', RDB$VIEW_SOURCE as '+TBL_TYPE_FIELD+
        ' from RDB$RELATIONS'+
        ' %s order by RDB$OWNER_NAME, RDB$RELATION_NAME';
  SQueryIntTableFieldNamesFmt =
    	'select '''' as '+CAT_NAME_FIELD+', R.RDB$OWNER_NAME as '+SCH_NAME_FIELD+
        ', R.RDB$RELATION_NAME as '+TBL_NAME_FIELD+', RF.RDB$FIELD_NAME as '+COL_NAME_FIELD+
        ', RF.RDB$FIELD_POSITION as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', F.RDB$FIELD_TYPE as '+COL_TYPENAME_FIELD+', F.RDB$FIELD_LENGTH as '+COL_LENGTH_FIELD+
        ', F.RDB$FIELD_PRECISION as '+COL_PREC_FIELD+', F.RDB$FIELD_SCALE as '+COL_SCALE_FIELD+
        ', RF.RDB$NULL_FLAG as '+COL_NULLABLE_FIELD+
        ', F.RDB$DEFAULT_VALUE'+
        ' from RDB$RELATIONS R, RDB$RELATION_FIELDS RF, RDB$FIELDS F '+
        'where (R.RDB$RELATION_NAME = RF.RDB$RELATION_NAME) and (RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME) and'+
        ' (R.RDB$OWNER_NAME %s) and (R.RDB$RELATION_NAME %s) '+
        'order by R.RDB$OWNER_NAME, R.RDB$RELATION_NAME, RF.RDB$FIELD_POSITION';
        	// I.RDB$UNIQUE_FLAG = 0/1 - non-unique/unique index. RDB$RELATION_CONSTRAINTS -> RDB$CONSTRAINT_TYPE = 'PRIMARY KEY'
  SQueryIntIndexNamesFmt =
	'select '''' as '+CAT_NAME_FIELD+', R.RDB$OWNER_NAME as '+SCH_NAME_FIELD+
        ', R.RDB$RELATION_NAME as '+TBL_NAME_FIELD+', I.RDB$INDEX_NAME as '+IDX_NAME_FIELD+
        ', S.RDB$FIELD_NAME as '+IDX_COL_NAME_FIELD+', S.RDB$FIELD_POSITION as '+IDX_COL_POS_FIELD+
	', CAST((I.RDB$UNIQUE_FLAG + 1) as INTEGER) as '+IDX_TYPE_FIELD+
        ', '''' as '+IDX_SORT_FIELD+', '''' as '+IDX_FILTER_FIELD+
	' from RDB$RELATIONS R, RDB$INDICES I, RDB$INDEX_SEGMENTS S '+
        'where (R.RDB$RELATION_NAME = I.RDB$RELATION_NAME) and (I.RDB$INDEX_NAME = S.RDB$INDEX_NAME)'+
        ' and (R.RDB$OWNER_NAME %s) and (R.RDB$RELATION_NAME %s) '+
        'union select '''', R.RDB$OWNER_NAME, I.RDB$RELATION_NAME, I.RDB$INDEX_NAME'+
        ', CAST('''' as CHAR(31)), CAST(-1 as SMALLINT), CAST(4 as INTEGER), '''', '''' '+
        ' from RDB$RELATIONS R, RDB$INDICES I, RDB$RELATION_CONSTRAINTS C '+
        'where (R.RDB$RELATION_NAME = I.RDB$RELATION_NAME) and (C.RDB$RELATION_NAME = I.RDB$RELATION_NAME)'+
        ' and (C.RDB$INDEX_NAME = I.RDB$INDEX_NAME) and C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' '+
        ' and (R.RDB$OWNER_NAME %s) and (R.RDB$RELATION_NAME %s) '+
        'order by 2, 3, 4, 6';


  function WhereAnd(const s: string): string;
  begin
    if Trim(s) = '' then
      Result := ' where '
    else
      Result := ' and ';
  end;
  	// in case of searching with LIKE predicat and string without pattern symbols, IB compares with space padding and could not locate the required row
  function LikeOrEqual(const s: string): string;
  begin
    if ContainsLikeWildcards(s) then
      Result := Format('like UPPER(''%s'')',[s])
    else
      Result := Format('= UPPER(''%s'')',[s]);
  end;

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
          sStmt := sStmt + WhereAnd(sStmt) + 'RDB$RELATION_NAME '+LikeOrEqual( sObj );
        if sOwner <> '' then
          sStmt := sStmt + WhereAnd(sStmt) + 'RDB$OWNER_NAME '+LikeOrEqual( sOwner );
        if ASchemaType = stSysTables then
          sStmt := sStmt + WhereAnd(sStmt) + 'RDB$SYSTEM_FLAG <> 0 '
        else
          sStmt := sStmt + WhereAnd(sStmt) + 'RDB$SYSTEM_FLAG = 0 ';
        sStmt := Format(SQueryIntTableNamesFmt, [sStmt]);
      end;
    stColumns:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryIntTableFieldNamesFmt, [LikeOrEqual(sOwner), LikeOrEqual(sObj)] );
      end;
    stIndexes:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryIntIndexNamesFmt, [LikeOrEqual(sOwner), LikeOrEqual(sObj), LikeOrEqual(sOwner), LikeOrEqual(sObj)]);
      end;
    stProcedures:
      begin
        if AObjectName <> '' then
          sStmt := sStmt + 'and RDB$PROCEDURE_NAME '+LikeOrEqual( AObjectName );
        sStmt := Format(SQueryIntStoredProcNamesFmt, [sStmt]);
      end;
    stProcedureParams:
      begin
        if AObjectName <> '' then
          sStmt := sStmt + 'and PP.RDB$PROCEDURE_NAME '+LikeOrEqual( AObjectName );
        sStmt := Format(SQueryIntProcParamsFmt, [sStmt]);
      end;
  end;

  cmd := CreateSqlCommand;
  cmd.ExecDirect(sStmt);

  Result := cmd;
end;

procedure TICustomIntDatabase.SetTransIsolation(Value: TISqlTransIsolation);
begin
// do nothing
end;

function TICustomIntDatabase.GetClientVersion: LongInt;
begin
  Result := dwLoadedFileVer;
end;

function TICustomIntDatabase.GetServerVersion: LongInt;
{$IFDEF SD_CLR}
begin
  Result := VersionStringToDWORD( GetVersionString );
{$ELSE}
var
  szItemBuf: array[0..0] of Char;
  szRsltBuf: array[0..IBResultBufferSize-1] of Char;
  sVer: string;
begin
  FillChar(szRsltBuf, IBResultBufferSize, 0);
  szItemBuf[0] := Char( isc_info_version );
  Check( ApiCalls.isc_database_info(FesvPtr, DBHandle, 1, szItemBuf, IBResultBufferSize, szRsltBuf));
        // szInfoBuf[4] - length of string
  szRsltBuf[5 + Byte(szRsltBuf[4])] := Char(0);
  sVer := PChar( @szRsltBuf[5] );
  Result := VersionStringToDWORD(sVer);
{$ENDIF}
end;

function TICustomIntDatabase.GetVersionString: string;
{$IFDEF SD_CLR}
const
  IBResultBufferSize = 1000;
var
  szItemBuf, szRsltBuf: TSDCharPtr;
  Len: Integer;
begin
  szItemBuf := SafeReallocMem(nil, IBResultBufferSize+1);
  try
    szRsltBuf := IncPtr(szItemBuf, 1);
    HelperMemWriteByte(szItemBuf, 0, isc_info_version);
    Check( ApiCalls.isc_database_info(FesvPtr, DBHandle, 1, szItemBuf, IBResultBufferSize, szRsltBuf));
    Len := HelperMemReadByte(szRsltBuf, 4);
    Result := Marshal.PtrToStringAnsi( IncPtr(szRsltBuf, 5), Len );
    if Result <> '' then
      if Self.ClassName <> 'TIFibDatabase' then
        Result := 'Interbase ' + Result
      else
        Result := 'Firebird ' + Result;      
  finally
    SafeReallocMem(szItemBuf, 0);
  end;
{$ELSE}
var
  sVerString: string;
  nRet: Int;
begin
  sVerString := '';
  nRet := ApiCalls.isc_version( DBHandle, ExtractServerVersionStringCallback, @sVerString );
  if nRet = 0 then
    Result := sVerString;
{$ENDIF}
end;

function TICustomIntDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

function TICustomIntDatabase.GetDBHandle: PISC_DB_HANDLE;
begin
  ASSERT( Assigned(FHandle), 'TICustomIntDatabase.GetDBHandle' );

{$IFDEF SD_CLR}
  Result := TIIntConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIIntConnInfo) ) ).DBHandle;
{$ELSE}
  Result := TIIntConnInfo(FHandle^).DBHandle;
{$ENDIF}
end;

function TICustomIntDatabase.GetTRHandle: PISC_TR_HANDLE;
begin
  ASSERT( Assigned(FHandle), 'TICustomIntDatabase.GetTRHandle' );

{$IFDEF SD_CLR}
  Result := TIIntConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIIntConnInfo) ) ).TRHandle;
{$ELSE}
  Result := TIIntConnInfo(FHandle^).TRHandle;
{$ENDIF}
end;

procedure TICustomIntDatabase.SetAutoCommitOption(Value: Boolean);
begin
end;

procedure TICustomIntDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF SD_CLR}
var
  r1, r2: TIIntConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle(False);

{$IFDEF SD_CLR}
  r1 := TIIntConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIIntConnInfo) ) );
  r2 := TIIntConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TIIntConnInfo) ) );
  r1.DBHandle := r2.DBHandle;
  r1.TRHandle := r2.TRHandle;
  Marshal.StructureToPtr( r1, FHandle, False );
{$ELSE}
  TIIntConnInfo(FHandle^).DBHandle := TIIntConnInfo(AHandle^).DBHandle;
  TIIntConnInfo(FHandle^).TRHandle := TIIntConnInfo(AHandle^).TRHandle;
{$ENDIF}
end;

{ It is not necessary to alloc/free DBHandle and TRHandle, when a shared handle(SetHandle) is used. }
procedure TICustomIntDatabase.AllocHandle(DBHandles: Boolean);
var
  rec: TIIntConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TICustomIntDatabase.AllocHandle' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.ServerType := Ord( istInterbase );
  if DBHandles then begin
    rec.DBHandle := SafeReallocMem(nil, SizeOf(TISC_DB_HANDLE));
    SafeInitMem(rec.DBHandle, SizeOf(TISC_DB_HANDLE), 0);
    rec.TRHandle := SafeReallocMem(nil, SizeOf(TISC_TR_HANDLE));
    SafeInitMem(rec.TRHandle, SizeOf(TISC_TR_HANDLE), 0);
  end else begin
    rec.DBHandle := nil;  
    rec.TRHandle := nil;
  end;
{$IFDEF SD_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TIIntConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TICustomIntDatabase.FreeHandle(DBHandles: Boolean);
var
  rec: TIIntConnInfo;
begin
  if not Assigned(FHandle) then
    Exit;
{$IFDEF SD_CLR}
  rec := TIIntConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TIIntConnInfo) ) );
{$ELSE}
  rec := TIIntConnInfo(FHandle^);
{$ENDIF}
  if DBHandles then begin
    if Assigned(rec.DBHandle) then
      SafeReallocMem(rec.DBHandle, 0);
    if Assigned(rec.TRHandle) then
      SafeReallocMem(rec.TRHandle, 0);
  end;
  FHandle := SafeReallocMem( FHandle, 0 );
end;

procedure TICustomIntDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
  TEB: TISC_TEB;
  szDbName, szDbParam: TSDCharPtr;
begin
  LoadSqlLib;

  AllocHandle(True);

  ConstructDPB(sUserName, sPassword);
{$IFDEF SD_CLR}
  szDbName  := Marshal.StringToHGlobalAnsi(sRemoteDatabase);
  szDbParam := Marshal.StringToHGlobalAnsi(FDPBBuffer);
  try
{$ELSE}
  szDbName  := TSDCharPtr(sRemoteDatabase);
  szDbParam := TSDCharPtr(FDPBBuffer);
{$ENDIF}
  	// attach to the database
  Check( ApiCalls.isc_attach_database(FesvPtr, 0, szDbName, DBHandle, FDPBLength, szDbParam) );
{$IFDEF SD_CLR}
  finally
    Marshal.FreeHGlobal(szDbName);
    Marshal.FreeHGlobal(szDbParam);
  end;
{$ENDIF}
  	// always keep transaction open
  ConstructTPB;
  TEB.db_handle := DBHandle;
  TEB.tpb_length := FTPBLength;
  TEB.tpb_address := FTPBBuffer;

  Check( ApiCalls.isc_start_multiple(FesvPtr, TRHandle, 1, TEB) );

  FCursorPreservedOnCommit   := FTransRetaining;
  FCursorPreservedOnRollback := IsPreservedOnRollback;
end;

procedure TICustomIntDatabase.DoDisconnect(Force: Boolean);
var
  rcd: ISC_STATUS;
begin
	// it's possible in case of unsuccessful connection
  if not Assigned(FHandle) then
    Exit;

  // first we should close transaction
  if Assigned(TRHandle) {$IFNDEF SD_CLR}and Assigned(TRHandle^){$ENDIF} then begin
    if InTransaction then
      rcd := ApiCalls.isc_rollback_transaction(FesvPtr, TRHandle)
    else
      rcd := ApiCalls.isc_commit_transaction(FesvPtr, TRHandle);
    if not Force then
      Check( rcd );
  end;

  // then we can detach
  if Assigned(DBHandle) {$IFNDEF SD_CLR}and Assigned(DBHandle^){$ENDIF} then begin
    rcd := ApiCalls.isc_detach_database(FesvPtr, DBHandle);
    if not Force then
      Check( rcd );
  end;

  // reset database parameter block
  FDPBBuffer := '';
  FDPBLength := FDPBVersionLength;

  FreeHandle(True);
  FreeSqlLib;
end;

{ create Database Parameter Buffer with user name/password and other parameters }
procedure TICustomIntDatabase.ConstructDPB(sUserName, sPassword: string);
var
  sValue: string;
begin
	// fill Database Parameter Buffer with user name/password
  FDPBBuffer := FDPBBuffer +
             Char(isc_dpb_user_name) +
             Char(Length(sUserName)) +
             sUserName;
  Inc(FDPBLength, 2 + Length(sUserName));

  FDPBBuffer := FDPBBuffer +
             Char(isc_dpb_password) +
             Char(Length(sPassword)) +
             sPassword;
  Inc(FDPBLength, 2 + Length(sPassword));

	// fill database parameter buffer with other parameters
  sValue := Trim( Params.Values[szLOCALCHARSET] );
  if Length(sValue) > 0 then begin
    FDPBBuffer := FDPBBuffer +
             Char(isc_dpb_lc_ctype) +
             Char(Length(sValue)) +
             sValue;
    Inc(FDPBLength, 2 + Length(sValue));
  end;

  sValue := Trim( Params.Values[szROLENAME] );
  if Length(sValue) > 0 then begin
    FDPBBuffer := FDPBBuffer +
             Char(isc_dpb_sql_role_name) +
             Char(Length(sValue)) +
             sValue;
    Inc(FDPBLength, 2 + Length(sValue));
  end;
end;

{ Returns True, if some Transaction Parameters were modified }
function TICustomIntDatabase.ConstructTPB: Boolean;
var
  Ch1, Ch2, oldCh1, oldCh2: Byte;
  i: Short;
  	// is it necessary to change autocommit parameter (inside/outside of StartTransaction/Commit(Rollback)) ?
  function IsAutoCommitChanged: Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i:=0 to FTPBLength-1 do begin
      Result := HelperMemReadByte(FTPBBuffer, i) = isc_tpb_autocommit;
      if Result then
        Break;
    end;
    if Result then
      Result := FTransActive	// set on inside a transaction
    else
      Result := AutoCommit and not FTransActive;
  end;
begin
  ASSERT( FTPBLength > FTPBConstLength );
	// read the current values
  i := FTPBConstLength;
  oldCh1 := HelperMemReadByte(FTPBBuffer, i);
  if FTPBLength > FTPBConstLength + 1 then
    oldCh2 := HelperMemReadByte(FTPBBuffer, i+1)
  else
    oldCh2 := 0;

  case TransIsolation of
    itiDirtyRead:
    begin
      Ch1 := isc_tpb_read_committed;
      Ch2 := isc_tpb_rec_version;
    end;
    itiReadCommitted:
    begin
      Ch1 := isc_tpb_read_committed;
      Ch2 := isc_tpb_no_rec_version;
    end;
    itiRepeatableRead:
    begin
      Ch1 := isc_tpb_concurrency;
      Ch2 := 0;   // not used
    end;
    else begin
      ASSERT( False );
      Result := False;
      Exit;
    end;
  end;
	// if transaction parameters are changing
  if (oldCh1 <> ch1) or (oldCh2 <> ch2) or IsAutoCommitChanged then begin
        // FillChar(FTPBBuffer[FTPBConstLength], MaxTPBLength-FTPBConstLength+1, 0);
    SafeInitMem( IncPtr(FTPBBuffer, FTPBConstLength), MaxTPBLength-FTPBConstLength, 0 );
    FTPBLength := FTPBConstLength;
    HelperMemWriteByte(FTPBBuffer, FTPBLength, Ch1);
    Inc(FTPBLength);
    if Ch2 <> 0 then begin
      HelperMemWriteByte(FTPBBuffer, FTPBLength, Ch2);
      Inc(FTPBLength);
    end;

    // Is it necessary to enable autocommit ?
    if AutoCommit and not FTransActive then begin
      HelperMemWriteByte(FTPBBuffer, FTPBLength, isc_tpb_autocommit);
      Inc(FTPBLength);
    end;

    Result := True;
  end else
    Result := False;
end;

function TICustomIntDatabase.TestConnected: Boolean;
var
  ItemBuf, RsltBuf: TSDPtr;
  rcd: ISC_STATUS;
begin
  ItemBuf := SafeReallocMem(nil, 1);
  RsltBuf := SafeReallocMem(nil, IBResultBufferSize);
  try
    SafeInitMem(RsltBuf, IBResultBufferSize, 0);
    HelperMemWriteByte(ItemBuf, 0, isc_info_version);
    rcd := ApiCalls.isc_database_info(FesvPtr, DBHandle, 1, ItemBuf, IBResultBufferSize, RsltBuf);
    Result := rcd = 0;
  finally
    SafeReallocMem(ItemBuf, 0);
    SafeReallocMem(RsltBuf, 0);
  end;
end;

function TICustomIntDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := True;
end;


{ TICustomIntCommand }
constructor TICustomIntCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);

  FPStmtHandle  := nil;
  FInXSQLDA     := nil;
  FOutXSQLDA    := nil;
  FStmtType     := 0;     // Unknown or unprepared
  FExecuted     := False;
  FesvPtr := SafeReallocMem(nil, ESVBufferSize);	// pointer to error status vector
  SafeInitMem(FesvPtr, ESVBufferSize, 0);
end;

destructor TICustomIntCommand.Destroy;
begin
  FesvPtr := SafeReallocMem(FesvPtr, 0);
  inherited;
end;

function TICustomIntCommand.GetApiCalls: TIntFunctions;
begin
  Result := SqlDatabase.FApiCalls;
end;

function TICustomIntCommand.GetSqlDatabase: TICustomIntDatabase;
begin
  Result := (inherited SqlDatabase) as TICustomIntDatabase;
end;

function TICustomIntCommand.GetHandle: PSDCursor;
begin
  Result := PSDCursor( HelperMemReadInt32(FPStmtHandle, 0) );
end;

function TICustomIntCommand.GetStmtType:ISC_LONG;
const
  ItemBufSize = 1;
  ResBufSize  = 8;
var
  szTypeItem : TSDCharPtr;      //array[0..0] of Char;
  szResBuffer: TSDCharPtr;      //array[0..7] of Char;
  length : ISC_LONG;
begin
  szTypeItem := nil;
  if FStmtType = 0 then try
    szTypeItem := SafeReallocMem(nil, ItemBufSize + ResBufSize);        // includes 2 buffers
    HelperMemWriteByte(szTypeItem, 0, isc_info_sql_stmt_type);  //   type_item[0] := Char( isc_info_sql_stmt_type );
    szResBuffer := IncPtr(szTypeItem, ItemBufSize);
    Check( ApiCalls.isc_dsql_sql_info(FesvPtr, FPStmtHandle, ItemBufSize, szTypeItem, ResBufSize, szResBuffer) );
    ASSERT( HelperMemReadByte(szResBuffer, 0) = isc_info_sql_stmt_type );

    length := ApiCalls.isc_vax_integer( IncPtr(szResBuffer, 1), 2 );
    FStmtType := ApiCalls.isc_vax_integer( IncPtr(szResBuffer, 3), length );
  finally
    if Assigned(szTypeItem) then
      SafeReallocMem(szTypeItem, 0);
  end;
  Result := FStmtType;
end;

function TICustomIntCommand.GetIsProcStmt: Boolean;
begin
  Result := StmtType = isc_info_sql_stmt_exec_procedure;
end;

function TICustomIntCommand.ResultSetExists: Boolean;
begin
  Result := StmtType in [isc_info_sql_stmt_select, isc_info_sql_stmt_select_for_upd];
end;

function TICustomIntCommand.GetFieldsBufferSize: Integer;
begin
  FBaseSelectBufferSize := inherited GetFieldsBufferSize;
  	// BlobFieldCount is equal to sum of real and pseudo blobs, so it's possible empty cells in Blobs and pseudo-Blobs arrays, when both are present
    	// buffers for TISC_QUAD structure to get Blobs
  FPseudoBlobSelBufOffs := FBaseSelectBufferSize + BlobFieldCount * SizeOf(TISC_QUAD);
	// buffers for pseudo-Blobs (255 < VARCHAR < 32K)
  Result 		:= FPseudoBlobSelBufOffs + BlobFieldCount * SizeOf(TSDPtr);
end;

function TICustomIntCommand.GetParamsBufferSize: Integer;
var
  i, nBlobCount: Integer;
begin
  Result := inherited GetParamsBufferSize;
  FBaseBindBufferSize := Result;

  if not Assigned(Params) then
    Exit;

  nBlobCount := 0;
  for i := 0 to Params.Count -1 do
    if IsBlobType(Params[i].DataType) then
      Inc(nBlobCount);
	// buffers to bind Blobs parameters
  Result := FBaseBindBufferSize + nBlobCount * SizeOf(TISC_QUAD);
end;

function TICustomIntCommand.IsPseudoBlob(AFieldDesc: TSDFieldDesc): Boolean;
begin
  Result := ((AFieldDesc.DataType and not 1) <> SQL_BLOB) and IsBlobType( AFieldDesc.FieldType );
end;

function TICustomIntCommand.IBFieldDataType(SqlVar: TXSQLVAR): TFieldType;
var
  sqltype: Short;
begin
  // reset a less significant bit, which is is nullable indicator
  sqltype := SqlVar.sqltype and not 1;
  if sqltype = SQL_BLOB then begin
    case SqlVar.sqlsubtype of
      isc_blob_untyped:         Result := ftBlob;   // 0;
      isc_blob_text:            Result := ftMemo;   // 1;
//      isc_blob_blr                   =          2;
//      isc_blob_acl                   =          3;
//      isc_blob_ranges                =          4;
//      isc_blob_summary               =          5;
//      isc_blob_format                =          6;
//      isc_blob_tra                   =          7;
//      isc_blob_extfile               =          8;
      isc_blob_formatted_memo:  Result := ftFmtMemo;        // 20;
      isc_blob_paradox_ole:     Result := ftParadoxOle;     // 21;
      isc_blob_graphic:         Result := ftGraphic;        // 22;
      isc_blob_dbase_ole:       Result := ftDBaseOle;       // 23;
      isc_blob_typed_binary:    Result := ftTypedBinary;    // 24;
    else
      Result := ftBlob;
    end;
  end else
    if (sqltype = SQL_VARYING) and (SqlVar.sqllen > SqlDatabase.MaxStringSize) then
      Result := ftMemo
    else
      Result := FieldDataType(sqltype);
  Result := ExactNumberDataType( Result, SqlVar.sqlscale );
end;

function TICustomIntCommand.IBReadBlob(BlobIDPtr: PISC_QUAD; var BlobData: TSDBlobData): Longint;
const
  BlobSegSize = 16*1024;
  BlobItemBufSize = 1;
  BlobInfoBufSize = 100;
var
  hBlob: TISC_BLOB_HANDLE;
  actual_seg_length: UShort;
  status, esv1: ISC_STATUS;
  szBlobItems, szBlobInfo, BlobSegPtr: TSDCharPtr;
  i, Idx: Integer;
  item: Byte;
  item_length, nTotalRead, nBlobSize: ISC_LONG;
begin
  BlobSegPtr := nil;
  nBlobSize := 0;
  // open the blob
  hBlob := nil;		// set handle to NULL before using it
  szBlobItems := SafeReallocMem(nil, BlobItemBufSize + BlobInfoBufSize);
  szBlobInfo := IncPtr(szBlobItems, BlobItemBufSize);
  try
    Check( ApiCalls.isc_open_blob(FesvPtr, SqlDatabase.DBHandle, SqlDatabase.TRHandle,
          		hBlob,   	// set by this function to refer to the blob
          		BlobIDPtr) );      // Blob ID put into out_sqlda by isc_fetch()
    // get blob size
    HelperMemWriteByte( szBlobItems, 0, isc_info_blob_total_length );
    Check( ApiCalls.isc_blob_info(FesvPtr, hBlob, BlobItemBufSize, szBlobItems,
                          BlobInfoBufSize, szBlobInfo) );
    i := 0;
    while HelperMemReadByte(szBlobInfo, i) <> isc_info_end do begin
      item := HelperMemReadByte(szBlobInfo, i);
      Inc(i);
      item_length := ApiCalls.isc_vax_integer( IncPtr(szBlobInfo, i), 2 );
      Inc(i, 2);
      if item = isc_info_blob_total_length then begin
        nBlobSize := ApiCalls.isc_vax_integer( IncPtr(szBlobInfo, i), item_length );
        if (nBlobSize > BlobSegSize) and (nBlobSize mod BlobSegSize <> 0) then begin
          nBlobSize := (nBlobSize div BlobSegSize) * BlobSegSize;
          Inc(nBlobSize, BlobSegSize);
        end;
        Break;
      end;
      Inc(i, item_length);
    end;

    if nBlobSize > 0 then begin
      BlobSegPtr := SafeReallocMem(nil, BlobSegSize);
      nTotalRead := 0;
      // read all the BLOB data by calling isc_get_segment() repeatedly to get each BLOB
      // segment and its length
      repeat
        status := ApiCalls.isc_get_segment(FesvPtr, hBlob,
          				actual_seg_length,       // length of segment read
          				BlobSegSize,              // length of segment buffer
          				BlobSegPtr{TSDCharPtr(BlobData) + nTotalRead}); // segment buffer
        esv1 := HelperMemReadInt32( FesvPtr, 1*SizeOf(ISC_STATUS) );
        if esv1 = isc_segstr_eof then
          Break;
        if (status <> 0) and (esv1 <> isc_segment) and (esv1 <> isc_segstr_eof) then
          Check(status);
        if actual_seg_length > 0 then begin
          SetLength(BlobData, Length(BlobData) + actual_seg_length);
          Idx := Length(BlobData) - actual_seg_length;
{$IFDEF SD_CLR}
          Marshal.Copy( BlobSegPtr, BlobData, Idx, actual_seg_length );
{$ELSE}
          SafeCopyMem( BlobSegPtr, TSDPtr(@BlobData[Idx]), actual_seg_length );
{$ENDIF}
        end;
        Inc(nTotalRead, actual_seg_length);
      until esv1 = isc_segstr_eof;
      SetLength(BlobData, nTotalRead);
    end;
    // close the Blob
    Check( ApiCalls.isc_close_blob(FesvPtr, hBlob) );

    Result := Length(BlobData);
  finally
    if Assigned(BlobSegPtr) then
      SafeReallocMem(BlobSegPtr, 0);
    if Assigned(szBlobItems) then
      SafeReallocMem(szBlobItems, 0);
  end;
end;

function TICustomIntCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  nBlobOffset, BlobSize: Integer;
  FldInfo: TSDFieldInfo;
  FldInfoPtr, DataPtr: TSDPtr;
  sqlvar: TXSQLVAR;
begin
  Result	:= 0;  // if null or error
  BlobSize	:= 0;
	// pseudo BLOB handling: for VARCHAR(>8K)
  sqlvar := GetSQLVar(FOutXSQLDA, AFieldDesc.FieldNo-1);
  if (sqlvar.sqltype and not 1) <> SQL_BLOB then begin
{$IFDEF SD_CLR}
    FldInfoPtr := IncPtr( FieldsBuffer, FPseudoBlobSelBufOffs + AFieldDesc.Offset*SizeOf(TSDPtr) );
    FldInfo := TSDFieldInfo( Marshal.PtrToStructure(FldInfoPtr, TypeOf(TSDFieldInfo)) );
{$ELSE}
    FldInfoPtr := TSDCharPtr( PSDBlobDataArray(FieldsBuffer + FPseudoBlobSelBufOffs)[AFieldDesc.Offset] );
    FldInfo := TSDFieldInfo( FldInfoPtr^ );
{$ENDIF}
    if Short( FldInfo.FetchStatus ) <> indNULL then begin
        // just 2 bytes before data defines actual size
      BlobSize := HelperMemReadInt16( FldInfoPtr, SizeOf(TSDFieldInfo) - SizeOf(Short) );
      SetLength( BlobData, BlobSize );
      DataPtr := IncPtr(FldInfoPtr, SizeOf(TSDFieldInfo));
{$IFDEF SD_CLR}
      Marshal.Copy( DataPtr, BlobData, 0, BlobSize );
{$ELSE}
      SafeCopyMem( DataPtr, TSDCharPtr(BlobData), BlobSize );
{$ENDIF}
    end;
    Result := BlobSize;
    Exit;
  end;
	// get PSDFieldInfo pointer
  FldInfoPtr := IncPtr( FieldsBuffer, FieldBufOffs[AFieldDesc.FieldNo-1] );
{$IFDEF SD_CLR}
  FldInfo := TSDFieldInfo( Marshal.PtrToStructure(FldInfoPtr, TypeOf(TSDFieldInfo)) );
{$ELSE}
  FldInfo := TSDFieldInfo( FldInfoPtr^ );
{$ENDIF}
  if Short( FldInfo.FetchStatus ) = indNULL then
    Exit;

  	// get this blob handle
  nBlobOffset 	:= FBaseSelectBufferSize + AFieldDesc.Offset * SizeOf(TISC_QUAD);
  Result := IBReadBlob(IncPtr(FieldsBuffer, nBlobOffset), BlobData);
end;

// FieldNo - from 1
function TICustomIntCommand.IBWriteBlobParam(BlobIDPtr: PISC_QUAD; const Buffer: TSDValueBuffer; Count: LongInt): Longint;
const
  BlobSegSize = 16*1024;
var
  hBlob: TISC_BLOB_HANDLE;
  nActualWrite: Short;
  nTotalWrite: Integer;
  DataPtr: TSDValueBuffer;
begin
  Result := Count;
{$IFDEF SD_CLR}
  SafeInitMem(BlobIDPtr, SizeOf(TISC_QUAD), 0);
{$ELSE}
  BlobIDPtr^.gds_quad_high := 0;
  BlobIDPtr^.gds_quad_low := 0;
{$ENDIF}
  hBlob := nil;   // set handle to NULL before using it
  Check( ApiCalls.isc_create_blob(FesvPtr, SqlDatabase.DBHandle, SqlDatabase.TRHandle,
    			hBlob, BlobIDPtr) );

  nTotalWrite := 0;
  nActualWrite := BlobSegSize;
  DataPtr := Buffer;
  while nTotalWrite < Count do begin
    if(Count - nTotalWrite < nActualWrite) then
      nActualWrite := Count - nTotalWrite;
    Check( ApiCalls.isc_put_segment(FesvPtr, hBlob,
      			nActualWrite, IncPtr(DataPtr, nTotalWrite)) );
    Inc(nTotalWrite, nActualWrite);
  end;

  // Close the Blob
  Check( ApiCalls.isc_close_blob(FesvPtr, hBlob));

  ASSERT( hBlob = nil );
end;

procedure TICustomIntCommand.Check(Status: ISC_STATUS);
begin
  SqlDatabase.ResetIdleTimeOut;

  if (Status <> 0) {and (not ForceClosing)} then
    IntCheck( Status, FesvPtr, SqlDatabase.GetErrorClass, ApiCalls );
end;

procedure TICustomIntCommand.Connect;
begin
  FPStmtHandle := SafeReallocMem(nil, SizeOf(TISC_STMT_HANDLE));
  SafeInitMem(FPStmtHandle, SizeOf(TISC_STMT_HANDLE), 0);  
  Check( ApiCalls.isc_dsql_allocate_statement(FesvPtr, SqlDatabase.DBHandle, FPStmtHandle) );
end;

procedure TICustomIntCommand.Disconnect(Force: Boolean);
var
  rcd: ISC_STATUS;
begin
  if FPStmtHandle = nil then
    Exit;

  rcd := ApiCalls.isc_dsql_free_statement(FesvPtr, FPStmtHandle, DSQL_drop);
  if not Force then
    Check( rcd );
  FPStmtHandle := SafeReallocMem(FPStmtHandle, 0);

  if FieldsBuffer <> nil then
    FreeFieldsBuffer;

  IBFreeInDescs;
end;

procedure TICustomIntCommand.InitNewCommand;
begin
  inherited;

  IBFreeInDescs;
  IBFreeOutDescs;  
end;

{ CREATE DATABASE and SET TRANSACTION can be processed with isc_dsql_execute_immediate (without isc_dsql_prepare)}
procedure TICustomIntCommand.DoExecute;
begin
  if IsProcStmt then begin
    Check( ApiCalls.isc_dsql_execute2( FesvPtr, SqlDatabase.TRHandle, FPStmtHandle,
  	  		SqlDatabase.SQLDialect, FInXSQLDA, FOutXSQLDA)
    );

    InternalGetParams;
  end else
    Check( ApiCalls.isc_dsql_execute(FesvPtr, SqlDatabase.TRHandle, FPStmtHandle,
  			SqlDatabase.SQLDialect, FInXSQLDA) );
  FExecuted := True;
end;

procedure TICustomIntCommand.DoExecDirect(Value: string);
var
  sStmt: string;
  szCmd: TSDCharPtr;
  hDB: PISC_DB_HANDLE;
  hTR: PISC_TR_HANDLE;
begin
  FExecuted := False;
	// dispose old in/out descriptors
  IBFreeOutDescs;
  IBFreeInDescs;

  FStmtType := 0;     // Unknown or unprepared

        // Special case for CREATE DATABASE statement, else the statement is processed with prepare
  if (CommandType = ctQuery) and IsCreateDbCommand(Value) then begin
    sStmt := CreateNativeCommand(Value);
    hDB := SafeReallocMem(nil, SizeOf(TISC_DB_HANDLE));
    SafeInitMem(hDB, SizeOf(TISC_DB_HANDLE), 0);
    hTR := SafeReallocMem(nil, SizeOf(TISC_TR_HANDLE));
    SafeInitMem(hTR, SizeOf(TISC_TR_HANDLE), 0);
    try
{$IFDEF SD_CLR}
      szCmd := Marshal.StringToHGlobalAnsi(sStmt);
{$ELSE}
      szCmd := TSDCharPtr(sStmt);
{$ENDIF}
        // in this case, it is impossible to get a row set(with >1 rows) and number of affected rows
      Check( ApiCalls.isc_dsql_execute_immediate(
                                FesvPtr, hDB, hTR,
    				0, szCmd, SqlDatabase.SQLDialect, FInXSQLDA) );
        // detach handle, which was attached by previous call, when athe database was created
      ApiCalls.isc_detach_database(FesvPtr, hDB);
      FStmtType := isc_info_sql_stmt_ddl;
      FExecuted := True;
    finally
{$IFDEF SD_CLR}
      if Assigned(szCmd) then
        Marshal.FreeHGlobal(szCmd);
{$ENDIF}
      if Assigned(hDB) then
        SafeReallocMem(hDB, 0);
      if Assigned(hTR) then
        SafeReallocMem(hTR, 0);
    end;
  end else begin
    DoPrepare(Value);

    AllocParamsBuffer;
    BindParamsBuffer;

    DoExecute;
  end;

  SetNativeCommand(sStmt);
end;

procedure TICustomIntCommand.DoPrepare(Value: string);
var
  sStmt: string;
  szCmd: TSDCharPtr;
  sqlda: TXSQLDA;
begin
  FExecuted := False;
  if FPStmtHandle = nil then
    Connect;
	// dispose old in/out descriptors
  IBFreeOutDescs;
  IBFreeInDescs;

  FStmtType := 0;     // Unknown or unprepared
  try   // finally ..
  try   // except  ..
    if CommandType = ctQuery then begin
      sStmt := CreateNativeCommand(Value);
{$IFDEF SD_CLR}
      szCmd := Marshal.StringToHGlobalAnsi(sStmt);
{$ELSE}
      szCmd := TSDCharPtr(sStmt);
{$ENDIF}
      Check( ApiCalls.isc_dsql_prepare(FesvPtr, SqlDatabase.TRHandle, FPStmtHandle,
    				0, szCmd, SqlDatabase.SQLDialect, nil) );
    end else if CommandType = ctStoredProc then begin
      if Assigned(Params) and (Params.Count = 0) then
        InitParamList;
        // create statement to execute a procedure and initialize FOutXSQLDA
      sStmt := CreateNativeCommand(Value);
{$IFDEF SD_CLR}
      szCmd := Marshal.StringToHGlobalAnsi(sStmt);
{$ELSE}
      szCmd := TSDCharPtr(sStmt);
{$ENDIF}
      Check( ApiCalls.isc_dsql_prepare(FesvPtr, SqlDatabase.TRHandle, FPStmtHandle,
        				0, szCmd, SqlDatabase.SQLDialect, FOutXSQLDA));
      sqlda := GetSQLDA(FOutXSQLDA);
      ASSERT( sqlda.sqld = sqlda.sqln );
    end else
      DatabaseError(SNoCapability);
  except
    Disconnect(True);
    raise;
  end;
  finally
{$IFDEF SD_CLR}
    if Assigned(szCmd) then
      Marshal.FreeHGlobal(szCmd);
{$ENDIF}
  end;

  SetNativeCommand(sStmt);
  
        // it's necessary to alloc column descriptors, when DoExecDirect is called repeatedly
  if FOutXSQLDA = nil then
    IBAllocOutDescs;
  if FieldDescs.Count = 0 then
    InitFieldDescs;
end;

procedure TICustomIntCommand.CloseResultSet;
var
  rc: ISC_STATUS;
begin
	// statement is closed only. FExecuted is useful, when statement was not execute (for example, FieldDefs.Update)
  if Assigned( FPStmtHandle ) and FExecuted then begin
    rc := ApiCalls.isc_dsql_free_statement(FesvPtr, FPStmtHandle, DSQL_close);
        // to exclude error "Attempt to reclose a closed cursor", when StartTransaction/Commit/Rollback destoys a result set
    if SqlDatabase.CursorPreservedOnCommit and SqlDatabase.CursorPreservedOnRollback then
      Check(rc);
        // to exclude 'error = -501. Attempt to reclose a closed cursor' error
    FExecuted := False;
  end;

  IBFreeInDescs;
end;

{ IB6: input and output procedure parameters can be of any Interbase datatype,
except Blob and arrays of datatypes }
procedure TICustomIntCommand.BindParamsBuffer;
var
  i, nVarIdx, nInParams, nOutParams, nMyBlobsOffset: Integer;
  SqlVar: TXSQLVAR;
  CurDAPtr: PXSQLDA;
  CurPtr, DataPtr: TSDValueBuffer;
  sBlob: string;
  DataLen: Integer;
begin
  if ParamsBuffer = nil then
    Exit;

  CurPtr := ParamsBuffer;  	// points to the start
  nMyBlobsOffset := FBaseBindBufferSize;
	// first time binding after prepare ?
        //Note, FInXSQLDA and FOutXSQLDA could be created with an empty sqlvar(XSQLVAR) array (sqln=0)
  if FInXSQLDA = nil then
    IBAllocInDescs;
  if FOutXSQLDA = nil then
    IBAllocOutDescs;
	// counts of the previous input and output parameters concerning the current parameter (Params[i])
  nInParams := 0;
  nOutParams:= 0;

  for i:=0 to Params.Count-1 do begin
    if Params[i].ParamType = ptInput then begin
    	// check a valid reference in sqlvar array of the input descriptor
      ASSERT( (i-nOutParams) < GetSQLDA(FInXSQLDA).sqln );
      nVarIdx := i-nOutParams;
      CurDAPtr := FInXSQLDA;
      Inc(nInParams);
    end else begin // ptOutput
    	// check a valid reference in sqlvar array of the output descriptor
      ASSERT( (i-nInParams) < GetSQLDA(FOutXSQLDA).sqln );
      nVarIdx := i-nInParams;
      CurDAPtr := FOutXSQLDA;
      Inc(nOutParams);
    end;
    SqlVar := GetSQLVAR( CurDAPtr, nVarIdx );
    SqlVar.sqltype := NativeDataType( Params[i].DataType );
    if SqlVar.sqltype = 0 then
      DatabaseErrorFmt(SNoParameterDataType, [Params[i].Name]);
    DataLen := NativeParamSize( Params[i] );
    DataPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) );
	// set a null indicator
    SqlVar.sqlind := IncPtr( CurPtr, GetFieldInfoFetchStatusOff );
      	// data length for all datatypes, except string and blobs, which will override that, when it is need
    SqlVar.sqllen := DataLen;

	// set buffer for input parameter
    if Params[i].ParamType = ptInput then begin
      SqlVar.sqldata := DataPtr;
	// set a less significant bit, which is nullable indicator: a parameter can have NULL value
      SqlVar.sqltype := SqlVar.sqltype or 1;
      SafeInitMem(CurPtr, SizeOf(TSDFieldInfo), 0);
      if Params[i].IsNull then
        HelperMemWriteInt32(CurPtr, GetFieldInfoFetchStatusOff, indNULL);	// else indVALUE = 0

      case Params[i].DataType of
        ftString:
          begin
          ASSERT( DataLen >= Length(Params[i].AsString) + 1 );
          SqlVar.sqllen := Length(Params[i].AsString);
          HelperMemWriteString(SqlVar.sqldata, 0, Params[i].AsString, SqlVar.sqllen);
          end;
        ftInteger:
          HelperMemWriteInt32(SqlVar.sqldata, 0, Params[i].AsInteger);
        ftSmallint,
        ftWord:
          if Params[i].DataType = ftSmallint then
            HelperMemWriteInt16(SqlVar.sqldata, 0, Params[i].AsSmallInt)
          else
{$IFDEF SD_CLR}
            HelperMemWriteInt16(SqlVar.sqldata, 0, Params[i].AsWord);
{$ELSE}
            PShort(SqlVar.sqldata)^ := Params[i].AsWord;
{$ENDIF}
        ftBCD:
          CnvtCurrencyToDBNumeric(Params[i].AsCurrency, SqlVar);
        ftCurrency,
        ftFloat:
          if Params[i].DataType = ftCurrency then
            HelperMemWriteDouble(SqlVar.sqldata, 0, Params[i].AsCurrency)
          else
            HelperMemWriteDouble(SqlVar.sqldata, 0, Params[i].AsFloat);
        ftLargeInt:
          HelperMemWriteInt64( SqlVar.sqldata, 0, Trunc(Params[i].AsCurrency) );
        ftDateTime,
        ftDate,
        ftTime:
          CnvtDateTime2DBDateTime( Params[i].DataType, Params[i].AsDateTime, SqlVar.sqldata, SqlVar.sqllen )
        else
          if not IsBlobType(Params[i].DataType) then
            raise EDatabaseError.CreateFmt(SNoParameterDataType, [Params[i].Name]);
      end;

      if IsBlobType(Params[i].DataType) then begin
        ASSERT( (SqlVar.sqltype and not 1) = SQL_BLOB );
        ASSERT( DataLen = 0 );

        SqlVar.sqllen := SizeOf( TISC_QUAD );
        SqlVar.sqldata := TSDCharPtr(Integer(ParamsBuffer) + nMyBlobsOffset);
        sBlob := Params[i].AsBlob;
        IBWriteBlobParam( PISC_QUAD(SqlVar.sqldata), {$IFDEF SD_CLR}BufList.StringToPtr(sBlob){$ELSE}PChar(sBlob){$ENDIF}, Length(sBlob) );
        Inc(nMyBlobsOffset, SizeOf(TISC_QUAD));
      end;
    end else begin	// ParamType = ptOutput
      // blobs handles are allocated after all base data
      if SqlVar.sqltype and not 1 = SQL_BLOB then begin
        ASSERT( SqlVar.sqllen = SizeOf(TISC_QUAD) );
        ASSERT( DataLen = 0 );

        HelperMemWriteInt32(CurPtr, GetFieldInfoDataSizeOff, 0);
        SqlVar.sqldata := IncPtr(ParamsBuffer, nMyBlobsOffset);
        Inc(nMyBlobsOffset, SizeOf(TISC_QUAD));
      end else begin
        ASSERT( SqlVar.sqllen <= DataLen );

        SqlVar.sqldata := DataPtr;

        // if this is string then 2 first bytes (string length)
        // should be allocated just before data for SQL_VARYING
        // we do this for SQL_TEXT to make the logic type-independent
        if SqlVar.sqltype and not 1 = SQL_VARYING then begin
          ASSERT( IncPtr(DataPtr, -SizeOf(LongInt)) = IncPtr(CurPtr, GetFieldInfoDataSizeOff) );
          SqlVar.sqldata := IncPtr(SqlVar.sqldata, -SizeOf(Short)); // here Interbase will write actual SQL_VARYING size, just before the data itself
        end else if SqlVar.sqltype and not 1 = SQL_TEXT then begin
          ASSERT( IncPtr(DataPtr, -SizeOf(LongInt)) = IncPtr(CurPtr, GetFieldInfoDataSizeOff) );
          HelperMemWriteInt16(DataPtr, -SizeOf(Short), SqlVar.sqllen);       // here we write (now) the actual size of SQL_TEXT (it is fetch-row independent)
        end else
          HelperMemWriteInt32(CurPtr, GetFieldInfoDataSizeOff, SqlVar.sqllen);
      end;
    end;
    SetSQLVAR(CurDAPtr, nVarIdx, SqlVar);
    CurPtr := IncPtr( CurPtr, SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

function TICustomIntCommand.GetRowsAffected: Integer;
const
  InfoBufSize = 1;
  RsltBufSize = 1049;         // array[0..1048] of Char
var
  szInfo, szRslt: TSDCharPtr;
begin
  Result := 0;
        // if CREATE DATABASE was executed (FPStmtHandle = 0, in this case)
  if FStmtType = isc_info_sql_stmt_ddl then
    Exit;
  szInfo := SafeReallocMem(nil, InfoBufSize+RsltBufSize);
  try
    HelperMemWriteByte(szInfo, 0, isc_info_sql_records);
    szRslt := IncPtr(szInfo, InfoBufSize);
    Check( ApiCalls.isc_dsql_sql_info(FesvPtr, FPStmtHandle, InfoBufSize, szInfo, RsltBufSize, szRslt) );

    Result := -1;
    if HelperMemReadByte(szRslt, 0) = isc_info_sql_records then begin
      case StmtType of
        isc_info_sql_stmt_update:   Result := ApiCalls.isc_vax_integer( IncPtr(szRslt, 6), 4 );
        isc_info_sql_stmt_delete:   Result := ApiCalls.isc_vax_integer( IncPtr(szRslt, 13), 4 );
        isc_info_sql_stmt_insert:   Result := ApiCalls.isc_vax_integer( IncPtr(szRslt, 27), 4 );
      else
        Result := -1;
      end;
    end;
  finally
    if Assigned(szInfo) then
      SafeReallocmem(szInfo, 0);
  end;
end;

{ Gets output descriptors (fields or output parameters) }
procedure TICustomIntCommand.IBAllocOutDescs;
var
  SqlDA: TXSQLDA;
  nFields: Smallint;
begin
  if Assigned(FOutXSQLDA) then
    Exit;
  try
    nFields := 0;
    SqlDA.version       := SQLDA_VERSION1;
    SqlDA.sqln          := nFields;
    FOutXSQLDA          := SafeReallocMem( nil, XSQLDA_LENGTH(nFields) );
    SetSQLDAToPtr(SqlDA, FOutXSQLDA);
	// get field number
    Check( ApiCalls.isc_dsql_describe(FesvPtr, FPStmtHandle, SqlDatabase.SQLDialect, FOutXSQLDA) );
    SqlDA := GetSQLDA(FOutXSQLDA);

    if SqlDA.sqld > SqlDA.sqln then begin
      nFields := SqlDA.sqld;
      FOutXSQLDA        := SafeReallocMem( FOutXSQLDA, 0 );
      FOutXSQLDA        := SafeReallocMem( FOutXSQLDA, XSQLDA_LENGTH(nFields) );
      SafeInitMem(FOutXSQLDA, XSQLDA_LENGTH(nFields), 0);
      SqlDA.version     := SQLDA_VERSION1;
      SqlDA.sqln        := nFields;
      SetSQLDAToPtr(SqlDA, FOutXSQLDA);

      Check( ApiCalls.isc_dsql_describe(FesvPtr, FPStmtHandle, SqlDatabase.SQLDialect, FOutXSQLDA) );
  {$IFNDEF SD_CLR}
      ASSERT( FOutXSQLDA^.sqld = nFields );
  {$ENDIF}
    end;
  except
    IBFreeOutDescs;
    raise;
  end;
end;

procedure TICustomIntCommand.IBFreeOutDescs;
begin
  if Assigned(FOutXSQLDA) then
    FOutXSQLDA := SafeReallocMem( FOutXSQLDA, 0 );
end;

{ Gets input descriptors FInSQLDA (input parameters) }
procedure TICustomIntCommand.IBAllocInDescs;
var
  nFields: Smallint;
  SqlDA: TXSQLDA;
begin
  ASSERT( FInXSQLDA = nil );

  if not Assigned(Params) then
    Exit;

  if IsProcStmt then begin
    nFields := 0;
    while (nFields < Params.Count) and (Params[nFields].ParamType = ptInput) do
      Inc(nFields);
  end else
    nFields := Params.Count;

  SqlDA.version := SQLDA_VERSION1;
  SqlDA.sqln := nFields;
  SqlDA.sqld := nFields;
  FInXSQLDA := SafeReallocMem(nil, XSQLDA_LENGTH(nFields));
  SafeInitMem(FInXSQLDA, XSQLDA_LENGTH(nFields), 0);
  SetSQLDAToPtr(SqlDA, FInXSQLDA);
end;

procedure TICustomIntCommand.IBFreeInDescs;
begin
  if Assigned(FInXSQLDA) then
    FInXSQLDA := SafeReallocMem(FInXSQLDA, 0);
end;

procedure TICustomIntCommand.GetFieldDescs(Descs: TSDFieldDescList);
var
  nCol: Smallint;
  ft: TFieldType;
  SqlVar: TXSQLVAR;
  SqlDA: TXSQLDA;
begin
        // FOutXSQLDA has to be allocated in DoPrepare
  ASSERT( FOutXSQLDA <> nil );

  SqlDA := GetSQLDA(FOutXSQLDA);
  for nCol := 0 to SqlDA.sqld-1 do begin
    SqlVar := GetSQLVAR(FOutXSQLDA, nCol);
    ft := IBFieldDataType( SqlVar );
    if ft = ftUnknown then
      DatabaseErrorFmt( SBadFieldType, [SqlVar.aliasname] );

    with Descs.AddFieldDesc do begin
    	// aliasname is not zero-terminated string, set '\0' end of string
{$IFNDEF SD_CLR}
      SqlVar.aliasname[SqlVar.aliasname_length] := #$0;
{$ENDIF}
      FieldName	:= SqlVar.aliasname;
      FieldNo	:= nCol + 1;
      FieldType	:= ft;
      DataType  := SqlVar.sqltype and not 1;
      Precision	:= 0;   // there is not way to know the exact precision
      if ft = ftBCD then begin
        DataSize  := SqlVar.sqllen;
        Precision := MAX_BCDFIELD_PREC;	        // depends from Currency type
        Scale     := Abs(SqlVar.sqlscale);      // TBCDField.Size indicates the number digits after the decimal place
      end else if IsRequiredSizeTypes( ft ) then begin
        DataSize  := SqlVar.sqllen;
        	// add space for zero termination byte
        if ft = ftString then
          Inc(DataSize);
      end else
        DataSize  := NativeDataSize(ft);
	// less significant bit is a nullable indicator
      Required	:= (SqlVar.sqltype and 1) = 0;
    end;
  end;
end;

procedure TICustomIntCommand.SetFieldsBuffer;
var
  i: Integer;
  SqlDA: TXSQLDA;
  SqlVar: TXSQLVAR;
  nOffset: Integer;
  nMyBlobsOffset: Integer;
  PrgDataSize, PrgDataType: Integer;
  DataPtr: TSDCharPtr;
  FieldInfo: TSDFieldInfo;
  FieldInfoPtr: TSDPtr;
begin
  if not ResultSetExists then
    Exit;

  if FieldDescs.Count = 0 then begin
    InitFieldDescs;	// FOutXSQLDA is created here
    AllocFieldsBuffer;
  end;

  ASSERT( FOutXSQLDA <> nil );

  nOffset := 0;		                        // pointer to the TSDFieldInfo
  nMyBlobsOffset := FBaseSelectBufferSize;      // my blob handles are here, it's calculated after AllocFieldsBuffer
  SqlDA := GetSQLDA(FOutXSQLDA);
  for i:=0 to FieldDescs.Count-1 do begin

    ASSERT( FieldDescs[i].FieldNo-1 < SqlDA.sqld );

    SqlVar := GetSQLVAR(FOutXSQLDA, FieldDescs[i].FieldNo-1);

    if NativeDataType(FieldDescs[i].FieldType) = 0 then
      DatabaseErrorFmt(SUnknownFieldType, [FieldDescs[i].FieldName]);
    PrgDataType := SqlVar.sqltype and not 1;	// clear null flag
    PrgDataSize := FieldDescs[i].DataSize;

    FieldInfoPtr:= IncPtr(FieldsBuffer, nOffset);
    FieldInfo   := GetFieldInfoStruct(FieldInfoPtr, 0);

    // blobs handles are allocated after all base data
    if PrgDataType = SQL_BLOB then begin
      ASSERT( SqlVar.sqllen = SizeOf(TISC_QUAD) );
      ASSERT( PrgDataSize = 0 );

      DataPtr := IncPtr(FieldsBuffer, nMyBlobsOffset);
      FieldInfo.DataSize := 0;
      SqlVar.sqldata := DataPtr;
      Inc(nMyBlobsOffset, SizeOf(TISC_QUAD));
    end else begin
    	// for VARCHAR > 8K
      if IsBlobType( FieldDescs[i].FieldType ) then begin
        FieldInfoPtr := SafeReallocMem(nil, SizeOf(TSDFieldInfo) + SqlVar.sqllen);
        HelperMemWritePtr( FieldsBuffer, FPseudoBlobSelBufOffs + FieldDescs[i].Offset*SizeOf(FieldInfoPtr), FieldInfoPtr );
        DataPtr	        := IncPtr(FieldInfoPtr, SizeOf( TSDFieldInfo ));
        Inc(nMyBlobsOffset, SizeOf(TISC_QUAD));		// dummy for easy to get the required PISC_QUAD by Field.Offset
      end else begin
        ASSERT( SqlVar.sqllen <= PrgDataSize );

        DataPtr := IncPtr( FieldsBuffer, nOffset + SizeOf(TSDFieldInfo) );
      end;

      SqlVar.sqldata := DataPtr;

      // if this is string then 2 first bytes (string length)
      // should be allocated just before data for SQL_VARYING
      // we do this for SQL_TEXT to make the logic type-independent
      if PrgDataType = SQL_VARYING then begin
        ASSERT( IncPtr(DataPtr, -SizeOf(LongInt)) = IncPtr(FieldInfoPtr, GetFieldInfoDataSizeOff) );
        SqlVar.sqldata := IncPtr(SqlVar.sqldata, -SizeOf(Short)); // here Interbase will write actual SQL_VARYING size, just before the data itself
      end else if PrgDataType = SQL_TEXT then begin
        ASSERT( IncPtr(DataPtr, -SizeOf(LongInt)) = IncPtr(FieldInfoPtr, GetFieldInfoDataSizeOff) );
        FieldInfo.DataSize := SqlVar.sqllen shl 16;     // = PShort(Integer(PrgDataBuffer)-SizeOf(Short))^ := pVar^.sqllen;       // here we write (now) the actual size of SQL_TEXT (oit is fetch-row independent)
      end else
        FieldInfo.DataSize := SqlVar.sqllen;
    end;

    SqlVar.sqlind := IncPtr(FieldInfoPtr, GetFieldInfoFetchStatusOff);// null indicator
    SetSQLVAR(FOutXSQLDA, FieldDescs[i].FieldNo-1, SqlVar);
    SetFieldInfoStruct(FieldInfoPtr, 0, FieldInfo);
    Inc(nOffset, SizeOf(TSDFieldInfo) + PrgDataSize);
  end;
end;

procedure TICustomIntCommand.FreeFieldsBuffer;
var
  i: Integer;
  ptr: TSDPtr;
begin
  IBFreeOutDescs;
	// dispose memory, allocated for using with VARCHAR(>8K) column
  if BlobFieldCount > 0 then
    for i:=0 to FieldDescs.Count-1 do
      if IsPseudoBlob(FieldDescs[i]) then begin
        ptr := HelperMemReadPtr( FieldsBuffer, FPseudoBlobSelBufOffs + FieldDescs[i].Offset*SizeOf(ptr) );
        SafeReallocMem( ptr, 0 );
      end;

  inherited;
end;

function TICustomIntCommand.FetchNextRow: Boolean;
var
  Status: ISC_STATUS;
begin
  Status := ApiCalls.isc_dsql_fetch(FesvPtr, FPStmtHandle, SqlDatabase.SQLDialect, FOutXSQLDA);

  SqlDatabase.ResetIdleTimeOut;

  if Status <> 100 then
    Check(Status);
  Result := Status <> 100;

  if Result and (BlobFieldCount > 0) then
    FetchBlobFields;
end;

{ Now BufSize is used for string data setting }
function TICustomIntCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  dtDateTime: TDateTimeRec;
  InBuf, InData, OutData: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
  SqlVar: TXSQLVAR;
  nLen: Short;
  nSize: Integer;
begin
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);
  FieldInfo := GetFieldInfoStruct(InBuf, 0);
	// if it is not null value: Short(PSDFieldInfo(InBuf)^.FetchStatus) <> indNULL
  FieldInfo.FetchStatus := Short( FieldInfo.FetchStatus );
  Result := FieldInfo.FetchStatus <> indNULL;
  if not Result then
    Exit;

  nSize         := FieldInfo.DataSize;
  InData	:= IncPtr(InBuf, SizeOf(TSDFieldInfo));
  OutData	:= Buffer;
  // DateTime fields
  if RequiredCnvtFieldType(AFieldDesc.FieldType) and (AFieldDesc.FieldType <> ftBCD) then begin
    dtDateTime := CnvtDBDateTime2DateTimeRec(AFieldDesc.FieldType, InData, nSize);
    HelperMemWriteDateTimeRec(OutData, 0, dtDateTime);
  end else begin
    case AFieldDesc.FieldType of
    ftString:
     begin
      // just 2 bytes before InData should actual size be written
      nLen := HelperMemReadInt16(InData, -SizeOf(Short));       // PShort( Integer(InData) - SizeOf(Short) )^;
      if nLen > (BufSize - 1) then
        nLen := BufSize -1;
      SafeCopyMem(InData, OutData, nLen);
      HelperMemWriteByte(OutData, nLen, 0);
      if (nLen > 0) and SqlDatabase.IsRTrimChar then
        StrRTrim( OutData );
     end;
    ftBCD:
     begin
      ASSERT( AFieldDesc.FieldNo > 0 );
      SqlVar := GetSQLVAR( FOutXSQLDA, AFieldDesc.FieldNo-1 );
      HelperCurrToBCD( CnvtDBNumericToCurrency( SqlVar, InData ), OutData, 32, AFieldDesc.Scale );
     end;
    ftFloat:
     begin
      ASSERT( AFieldDesc.FieldNo > 0 );
      SqlVar := GetSQLVAR( FOutXSQLDA, AFieldDesc.FieldNo-1 );
      HelperMemWriteDouble(OutData, 0, CnvtDBNumericToFloat( SqlVar, InData ));
     end
    else
      if nSize > BufSize then
        nSize := BufSize;
      SafeCopyMem( InData, OutData, nSize );
    end;
  end;
end;

function TICustomIntCommand.CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDCharPtr; BufSize: Integer): TDateTimeRec;
var
  hire_time: TTimeDateRec;
  dtDate, dtTime: TDateTime;
begin
	// BufSize = 4 for ftDate and ftTime and BufSize = 8 for ftDateTime
  ASSERT( BufSize <= SizeOf(TISC_TIMESTAMP) );
  dtDate := 0;
  dtTime := 0;
	// isc_decode_timestamp, isc_decode_sql_time, isc_decode_sql_date
        //functions exist in IB6+ API
  if (ADataType = ftDateTime) and ApiCalls.IsAvailFunc('isc_decode_timestamp') then
    ApiCalls.isc_decode_timestamp( PISC_TIMESTAMP(Buffer), hire_time )
  else if (ADataType = ftTime) and ApiCalls.IsAvailFunc('isc_decode_sql_time') then
    ApiCalls.isc_decode_sql_time( PISC_TIME(Buffer), hire_time )
  else  //  ftDate:
    if ApiCalls.IsAvailFunc('isc_decode_sql_date')
    then ApiCalls.isc_decode_sql_date( PISC_DATE(Buffer), hire_time)
    else ApiCalls.isc_decode_date( PISC_QUAD(Buffer), hire_time );

  if ADataType in [ftDateTime, ftDate] then
    dtDate := EncodeDate( hire_time.tm_year + 1900, hire_time.tm_mon + 1, hire_time.tm_mday );
  if ADataType in [ftDateTime, ftTime] then
    dtTime := EncodeTime( hire_time.tm_hour, hire_time.tm_min, hire_time.tm_sec, 0);

  case (ADataType) of
    ftTime: 	Result.Time 	:= DateTimeToTimeStamp(dtTime).Time;
    ftDate: 	Result.Date 	:= DateTimeToTimeStamp(dtDate).Date;
    ftDateTime: Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(dtDate + dtTime) );
  else
    ASSERT( False );
  end;
end;

function TICustomIntCommand.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  hire_time: TTimeDateRec;
begin
  if NativeDataSize(ADataType) > BufSize then
    DatabaseError(SInsufficientIDateTimeBufSize);

  Hour	:= 0;
  Min	:= 0;
  Sec	:= 0;
  Year	:= 0;
  Month	:= 0;
  Day	:= 0;
  if ADataType in [ftTime, ftDateTime] then
    DecodeTime(Value, Hour, Min, Sec, MSec);
  if ADataType in [ftDate, ftDateTime] then
    DecodeDate(Value, Year, Month, Day);
  hire_time.tm_sec  := Sec;
  hire_time.tm_min  := Min;
  hire_time.tm_hour := Hour;
  hire_time.tm_mday := Day;
  hire_time.tm_mon  := Month-1;
  hire_time.tm_year := Year-1900;
  hire_time.tm_wday := 0;
  hire_time.tm_yday := 0;
  hire_time.tm_isdst:= 0;
	// isc_encode_timestamp, isc_encode_sql_time, isc_encode_sql_date
        //functions exist in IB6+ API
  if (ADataType = ftDateTime) and ApiCalls.IsAvailFunc('isc_encode_timestamp') then begin
    ApiCalls.isc_encode_timestamp( hire_time, PISC_TIMESTAMP(Buffer) );
    Result := SizeOf(TISC_TIMESTAMP);
  end else if (ADataType = ftTime) and ApiCalls.IsAvailFunc('isc_encode_sql_time') then begin
    ApiCalls.isc_encode_sql_time( hire_time, PISC_TIME(Buffer) );
    Result := SizeOf(TISC_TIME);
  end else  //  ftDate:
    if ApiCalls.IsAvailFunc('isc_encode_sql_date') then begin
      ApiCalls.isc_encode_sql_date(hire_time, PISC_DATE(Buffer));
      Result := SizeOf(TISC_DATE);
    end else begin
      ApiCalls.isc_encode_date(hire_time, PISC_QUAD(Buffer));
      Result := SizeOf(TISC_QUAD);
    end;
end;

procedure TICustomIntCommand.CnvtCurrencyToDBNumeric(Curr: Currency; var SqlVar: TXSQLVAR);
begin
  SqlVar.sqltype := SQL_INT64;
  SqlVar.sqllen := SizeOf(Curr);
  SqlVar.sqlscale := -4;
{$IFDEF SD_CLR}
  Marshal.WriteInt64( SqlVar.sqldata, Curr.ToOACurrency );
{$ELSE}
  Currency(TSDPtr(SqlVar.sqldata)^) := Curr;
{$ENDIF}
end;

{ converts DECIMAL(x,y), where y <= 4, which is stored as SMALLINT, INTEGER or INT64 with scale }
function TICustomIntCommand.CnvtDBNumericToCurrency(SqlVar: TXSQLVAR; InData: TSDValueBuffer): Currency;
var
  sqltype, scale: Integer;
{$IFDEF SD_CLR}
  d: Double;
{$ENDIF}
begin
  sqltype := SqlVar.sqltype and not 1;
  scale := Abs( SqlVar.sqlscale );
    // Currence must have scale 4, but Interbase can return data with scale 0 and more
  case sqltype of
    SQL_SHORT: Result := HelperMemReadInt16(InData, 0);
    SQL_LONG:  Result := HelperMemReadInt32(InData, 0);
  else 	// SQL_INT64
    Result := HelperMemReadInt64(InData, 0);
  end;
{$IFDEF SD_CLR}
  d := Result;		// Delphi8 + UP2 returns incorrecly result, when Currency := Currency / X
  while scale > 0 do begin
    d := d / 10;
    Dec(scale);
  end;
  Result := d;
{$ELSE}
  while scale > 0 do begin
    Result := Result / 10;
    Dec(scale);
  end;
{$ENDIF}
end;

{ converts FLOAT, DOUBLE PRECISION and DECIMAL(x,y), where y > 4,
  which is stored as SMALLINT, INTEGER or INT64 with scale }
function TICustomIntCommand.CnvtDBNumericToFloat(SqlVar: TXSQLVAR; InData: TSDValueBuffer): Double;
var
  sqltype, scale: Integer;
begin
  Result := 0.0;
  sqltype := SqlVar.sqltype and not 1;
  if (sqltype = SQL_INT64) or (sqltype = SQL_LONG) or (sqltype = SQL_SHORT) then begin
    scale := Abs( SqlVar.sqlscale );
    case sqltype of
      SQL_SHORT: Result := HelperMemReadInt16(InData, 0);
      SQL_LONG:  Result := HelperMemReadInt32(InData, 0);
    else 	// SQL_INT64
      Result := HelperMemReadInt64(InData, 0);
    end;
    while scale > 0 do begin
      Result := Result / 10;
      Dec(scale);
    end;
  end else begin
    	// float can be single or double, always convert to double
    if SqlVar.sqllen = SizeOf(Float) then
      Result := HelperMemReadSingle(InData, 0)
    else if SqlVar.sqllen = SizeOf(Double) then
      Result := HelperMemReadDouble(InData, 0)
    else
      ASSERT( False );
  end;
end;

// change <:ParamnName> to <?>
function TICustomIntCommand.CreateNativeCommand(OldStmt: string): string;
var
  i, ParamPos, nOutParamsCount: Integer;
  sFullParamName, sInParams: string;
  sqlda: TXSQLDA;
begin
  if CommandType = ctStoredProc then begin
    nOutParamsCount := 0;
    sInParams := '';
    if Assigned(Params) then for i := 0 to Params.Count - 1 do
      if Params[i].ParamType = ptInput then begin
        if sInParams <> '' then
          sInParams := sInParams + ', ?'
        else
          sInParams := ' ?';
      end else if Params[i].ParamType = ptOutput then
        Inc(nOutParamsCount)
      else
        ASSERT( False );

    Result := 'Execute Procedure ' +
            FormatIdentifier(1, OldStmt) +
            sInParams;
    FOutXSQLDA := SafeReallocMem(nil, XSQLDA_LENGTH(nOutParamsCount));
    sqlda.version := SQLDA_VERSION1;
    sqlda.sqln := nOutParamsCount;
    SetSQLDAToPtr(sqlda, FOutXSQLDA);
  end else begin        // ctQuery
    Result := OldStmt;
    if Assigned(Params) then for i:=0 to Params.Count-1 do begin
      sFullParamName := ParamPrefix + Params[i].Name;
      ParamPos := LocateText( sFullParamName, Result );
    	// if parameter's name is quoted
      if ParamPos = 0 then begin
        sFullParamName := ParamPrefix + QuoteChar + Params[i].Name + QuoteChar;
        ParamPos := LocateText( sFullParamName, Result );
        if ParamPos = 0 then
          Continue;
      end;
    	// remove parameter name with prefix(':')
      Delete( Result, ParamPos, Length(sFullParamName) );
    	// set parameter marker
      Insert( ParamMarker, Result, ParamPos );
    end;
  end
end;

procedure TICustomIntCommand.InitParamList;
const
  nFields: Smallint = 2;
var
  SqlDA: TXSQLDA;
  pSqlDA: PXSQLDA;
  SqlVar: TXSQLVAR;
  sSQL, sInput: string;
  szSql: TSDCharPtr;
  sParamName: string;
  nParamType: Short;
  i: Integer;
  nInParamsCount, nOutParamsCount: Integer;
  ft: TFieldType;
  Cmd: TISqlCommand;
begin
  pSqlDA := nil;
  if FPStmtHandle = nil then
    Connect;

  // read all sp parameters from system tables
  sSQL := 'SELECT RDB$PARAMETER_NAME,  RDB$PARAMETER_TYPE ' + {do not localize}
          'FROM RDB$PROCEDURE_PARAMETERS ' + {do not localize}
          'WHERE RDB$PROCEDURE_NAME = ' + {do not localize}
          '''' + FormatIdentifierValue(SqlDatabase.SQLDialect, CommandText) + '''' +
          ' ORDER BY RDB$PARAMETER_NUMBER'; {do not localize}

  cmd := SqlDatabase.CreateSqlCommand;
  try
    nOutParamsCount := 0;
    nInParamsCount := 0;
    sInput := '';

    cmd.Prepare(sSQL);
    cmd.Execute;
    while cmd.FetchNextRow do begin
      if cmd.GetFieldAsString(1, sParamName) then
        sParamName := Trim(sParamName);
      if cmd.GetFieldAsInt16(2, nParamType) then begin
        if nParamType = 0 then begin	// calculate and create input parameters
          Inc(nInParamsCount);
          AddParam(sParamName, ftUnknown, ptInput);
          if (sInput <> '') then
            sInput := sInput + ', ';
          sInput := sInput + '?';        //:' + FormatIdentifier(1, sParamName); {do not localize}
        end else if nParamType = 1 then // calculate output parameters
          Inc(nOutParamsCount);
      end else
        ASSERT( False );
    end;
        // get descriptions of output parameters
    SqlDA.version := SQLDA_VERSION1;
    SqlDA.sqln := nOutParamsCount;
    pSqlDA := SafeReallocMem(nil, XSQLDA_LENGTH(nOutParamsCount));
    SetSQLDAToPtr(SqlDa, pSqlDA);

    sSQL := 'Execute Procedure ' + {do not localize}
                FormatIdentifier(SqlDatabase.SQLDialect, CommandText) + ' ' + sInput;
{$IFDEF SD_CLR}
    szSql := Marshal.StringToHGlobalAnsi(sSQL);
{$ELSE}
    szSql := PChar(sSQL);
{$ENDIF}
    Check( ApiCalls.isc_dsql_prepare(FesvPtr, SqlDatabase.TRHandle, FPStmtHandle,
      				0, szSQL, SqlDatabase.SQLDialect, pSqlDA));
    SqlDA := GetSqlDA(pSqlDA);
    ASSERT( SqlDA.sqld = SqlDA.sqln );

    // create out parameters
    for i := 0 to SqlDA.sqld - 1 do begin
      SqlVar := GetSQLVAR(pSqlDA, i);
      ft := IBFieldDataType( SqlVar );
      AddParam( SqlVar.sqlname, ft, ptOutput);
    end;
    pSqlDA := SafeReallocMem(pSqlDA, 0);

    // describe and set datatypes for input parameters
    SqlDA.version := SQLDA_VERSION1;
    SqlDA.sqln := nInParamsCount;
    pSqlDA := SafeReallocMem(nil, XSQLDA_LENGTH(nInParamsCount));
    SetSQLDAToPtr(SqlDa, pSqlDA);
    Check( ApiCalls.isc_dsql_describe_bind(FesvPtr, FPStmtHandle, SqlDatabase.SQLDialect, pSqlDA) );
    SqlDA := GetSQLDA(pSqlDA);
    ASSERT( SqlDA.sqld = SqlDA.sqln );

    for i := 0 to SqlDA.sqld -1 do begin
      SqlVar := GetSQLVAR(pSqlDA, i);
      Params[i].DataType := IBFieldDataType( SqlVar );
    end;
  finally
    if Assigned(pSqlDA) then
      SafeReallocMem(pSqlDA, 0);
{$IFDEF SD_CLR}
    if Assigned(szSql) then
      Marshal.FreeHGlobal(szSql);
{$ENDIF}
    cmd.Free;
  end;
end;

procedure TICustomIntCommand.InternalGetParams;
var
  i: Integer;
  SqlVar: TXSQLVAR;
  nSkippedInParams: Integer;
  tempBCD: TBCD;
  tempTime: TDateTimeRec;
  tempBlob: TSDBlobData;
begin
  if not Assigned(Params) then
    Exit;
  nSkippedInParams := 0;
  for i:=0 to Params.Count-1 do begin
    if Params[i].ParamType = ptInput then begin
      Inc(nSkippedInParams);
      Continue;
    end else begin
      ASSERT( Params[i].ParamType = ptOutput );
{$IFNDEF SD_CLR}
      ASSERT( (FInXSQLDA = nil) or (nSkippedInParams = FInXSQLDA^.sqld) );
{$ENDIF}
      SqlVar := GetSQLVAR(FOutXSQLDA, i-nSkippedInParams);
      if Assigned(SqlVar.sqlind) and (HelperMemReadInt16(SqlVar.sqlind, 0) = -1) then begin
        Params[i].Clear;
        Continue;
      end else begin
        case Params[i].DataType of
          ftString:
            begin
              if (SqlVar.sqltype and not 1) = SQL_TEXT then begin
                Params[i].AsString :=
{$IFDEF SD_CLR}	Marshal.PtrToStringAnsi(SqlVar.sqldata, SqlVar.sqllen);
{$ELSE}                	Copy(SqlVar.sqldata, 0, SqlVar.sqllen);
{$ENDIF}
              end else // SQL_VARYING
                Params[i].AsString :=
{$IFDEF SD_CLR}	Marshal.PtrToStringAnsi( IncPtr(SqlVar.sqldata, SizeOf(Short)), HelperMemReadInt16(SqlVar.sqldata, 0) );
{$ELSE}			Copy( SqlVar.sqldata + SizeOf(Short), 0, PShort(SqlVar.sqldata)^);
{$ENDIF}
              if SqlDatabase.IsRTrimChar then
                Params[i].AsString := TrimRight( Params[i].AsString );
            end;
          ftDate,
          ftDateTime,                     
          ftTime:
            begin
              tempTime := CnvtDBDateTime2DateTimeRec( Params[i].DataType, SqlVar.sqldata, SqlVar.sqllen );
              HelperAssignParamValue(Params[i], tempTime);
            end;
          ftCurrency:
            begin
{$IFDEF SD_CLR}
              Params[i].AsFloat := CnvtDBNumericToCurrency( SqlVar, SqlVar.sqldata );
{$ELSE}
              CurrToBCD( CnvtDBNumericToCurrency( SqlVar, SqlVar.sqldata ), tempBCD, 32, Abs(SqlVar.sqlscale) );
              Params[i].SetData( @tempBCD );
{$ENDIF}
            end;
          ftFloat:
            Params[i].AsFloat := CnvtDBNumericToFloat( SqlVar, SqlVar.sqldata );
        else
          if IsBlobType( Params[i].DataType ) then begin
            if IBReadBlob(PISC_QUAD(SqlVar.sqldata), tempBlob) > 0 then
{$IFDEF SD_CLR}
              if Params[i].DataType = ftMemo
              then Params[i].AsMemo := tempBlob
              else Params[i].AsBlob := tempBlob;
{$ELSE}
              Params[i].Value := tempBlob;
{$ENDIF}
          end else
            Params[i].SetData(SqlVar.sqldata);
        end;
      end;
    end;
  end;
end;

{ if possible then convert ftFloat(NUMBER) to ftInteger ( Precision <= 9 (10 digits >= 1 billion ) }
function TICustomIntCommand.ExactNumberDataType(FieldType: TFieldType; Scale: Integer): TFieldType;
begin
  Result := FieldType;
	// SQL_SHORT, SQL_LONG, SQL_INT64 including DECIMAL type with scale
  if not (FieldType in [ftSmallInt, ftInteger, {$IFDEF SD_VCL4}ftLargeInt,{$ENDIF} ftBCD]) then
    Exit;
  Scale := Abs(Scale);
  if Scale > 0 then
  	// TBCDField supports(converting through Currency type) up to 4 decimal places
    if SqlDatabase.IsEnableBCD and (Scale <= MAX_BCDFIELD_SCALE)
    then Result := ftBCD
    else Result := ftFloat
{$IFNDEF SD_VCL4} 	// for Delphi 3 in case of SQL_INT64
  else if (Result = ftBCD) and (scale = 0) then
    Result := ftFloat;
{$ENDIF}
end;

function TICustomIntCommand.FieldDataType(ExtDataType: Integer) : TFieldType;
begin
  ASSERT( (ExtDataType and 1) = 0 );    // less significant bit is nullable indicator
  case ExtDataType of
    SQL_VARYING:        Result := ftString;     // 448
    SQL_TEXT:           Result := ftString;     // 452
    SQL_DOUBLE:         Result := ftFloat;      // 480
    SQL_FLOAT:          Result := ftFloat;      // 482
    SQL_LONG:           Result := ftInteger;    // 496
    SQL_SHORT:          Result := ftSmallint;   // 500
	{ SQL_DATE for IB5 = SQL_TIMESTAMP for IB6 }
    SQL_TIMESTAMP:	Result := ftDateTime;   // 510
    SQL_TYPE_TIME:	Result := ftTime;	// 560
    SQL_TYPE_DATE:	Result := ftDate;	// 570
    SQL_BLOB:                                   // 520
    begin
      ASSERT( False );    // Blobs need subtype to be converted to TFieldType
      Result := ftBlob;
    end;
    SQL_INT64:		Result := {$IFDEF SD_VCL4} ftLargeInt {$ELSE} ftBCD {$ENDIF};	// 580	for DECIMAL(10+, ..)
  else
    Result := ftUnknown;
  end;
end;

function TICustomIntCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  { Converting from TFieldType to Program Data Type(InterBase) }
  IBDataSizeMap: array[TFieldType] of Integer = (0,	// ftUnknown
	// ftString, ftSmallint,    ftInteger,    ftWord,        ftBoolean
	0,           SizeOf(Short), SizeOf(Long), SizeOf(Short), 0,
	// ftFloat,     ftCurrency,	ftBCD, 	ftDate,   ftTime
        SizeOf(Double),	SizeOf(Double), SizeOf(TInt64),     SizeOf(TISC_DATE), SizeOf(TISC_TIME),
        // ftDateTime,     ftBytes,  ftVarBytes, ftAutoInc, ftBlob
        0, 		0,    		0,          0, 	    0,
        // ftMemo,         ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,                 0,         0,	 0,	       0,
        // ftTypedBinary, ftCursor
        0,		  0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	SizeOf(TInt64),
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	      0,	 0,
        // ftInterface, ftIDispatch, ftGuid
        0,	        0,	        0
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  if FieldType = ftDateTime then
    Result := SizeOf(TISC_TIMESTAMP)
  else
    Result := IBDataSizeMap[FieldType];
end;

function TICustomIntCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType to Program Data Type(InterBase) }
  IBDataTypeMap: array[TFieldType] of Integer = (0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord,    ftBoolean
	SQL_TEXT,    SQL_SHORT,  SQL_LONG,  SQL_SHORT, 0,
	// ftFloat, ftCurrency, ftBCD, ftDate,   ftTime
        SQL_DOUBLE, SQL_DOUBLE, SQL_INT64, SQL_TYPE_DATE, SQL_TYPE_TIME,
        // ftDateTime, ftBytes,  ftVarBytes, ftAutoInc, ftBlob
        SQL_TIMESTAMP, 	0,        0,          0, 	SQL_BLOB,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SQL_BLOB,  SQL_BLOB,  SQL_BLOB,	 SQL_BLOB,     SQL_BLOB,
        // ftTypedBinary, ftCursor
        SQL_BLOB,	0
{$IFDEF SD_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	        0,	      SQL_INT64,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	  0,	   0,	        0
{$ENDIF}
{$IFDEF SD_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	      0,	 0,
        // ftInterface, ftIDispatch, ftGuid
        0,	        0,	        0
{$ENDIF}
{$IFDEF SD_VCL6},
        // ftTimeStamp, ftFMTBcd
        0,      0
{$ENDIF}
        );
begin
  Result := IBDataTypeMap[FieldType];
end;

{ If field necessary convert from internal database format, then returns True }
function TICustomIntCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := IsDateTimeType( FieldType ) or (FieldType = ftBCD);
end;

procedure TICustomIntCommand.GetOutputParams;
begin
  // nothing
end;


{ TIIntDatabase }
function TIIntDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TIIntCommand.Create( Self );
end;

procedure TIIntDatabase.FreeSqlLib;
begin
  SDInt.FreeSqlLib;
end;

procedure TIIntDatabase.LoadSqlLib;
begin
  SDInt.LoadSqlLib;

  FApiCalls := IntCalls;
end;

function TIIntDatabase.GetErrorClass: ESDEngineErrorClass;
begin
  Result := ESDIntError;
end;


initialization
  dwLoadedFileVer := 0;
  hSqlLibModule := 0;
  SqlLibRefCount:= 0;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;
  IntCalls 	:= TIntFunctions.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
  IntCalls.Free;
end.


