// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SDConsts.pas' rev: 5.00

#ifndef SDConstsHPP
#define SDConstsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdconsts
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
#define SSQLDirectProductName "SQLDirect"
#define SSQLDirectVersion "4.2.8"
#define SLinkSQLDirectHome "http://www.sqldirect-soft.com"
#define SLinkSQLDirectStdOrder "http://www.shareit.com/programs/101656.htm"
#define SLinkSQLDirectProOrder "http://www.shareit.com/programs/101657.htm"
#define SLinkSQLDirectSupport "mailto:support@sqldirect-soft.com"
#define SErrOpenWwwSite "Error opening following address: %s"
#define srSQLDirect "SQLDirect"
#define szUSERNAME "USER NAME"
#define szPASSWORD "PASSWORD"
#define szAPPNAME "APPLICATION NAME"
#define szHOSTNAME "HOST NAME"
#define szMAXCURSORS "MAX CURSORS"
#define szQUOTE_IDENT "QUOTE IDENTIFIER"
#define szQUOTEDIDENT "QUOTED IDENTIFIER"
#define szSINGLECONN "SINGLE CONNECTION"
#define szTDSPACKETSIZE "TDS PACKET SIZE"
#define szRTRIMCHAROUTPUT "RTRIM CHAR OUTPUT"
#define szENABLEINTS "ENABLE INTEGERS"
#define szENABLEBCD "ENABLE BCD"
#define szENABLEMONEY "ENABLE MONEY"
#define szSQLDialect "SQL Dialect"
#define szLOCALCHARSET "LOCAL CHARSET"
#define szROLENAME "ROLE NAME"
#define szAUTOCOMMIT "AUTOCOMMIT"
#define szLOGINTIMEOUT "LOGIN TIMEOUT"
#define szCMDTIMEOUT "COMMAND TIMEOUT"
#define szNEWPASSWORD "NEW PASSWORD"
#define szSERVERPORT "SERVER PORT"
#define szXACONN "XA CONNECTION"
#define szTRANSLOGGING "TRANSACTION LOGGING"
#define szMAXFIELDNAMELEN "MAXFIELDNAMELEN"
#define szMAXCHARPARAMLEN "MAXCHARPARAMLEN"
#define szMAXSTRINGSIZE "MAX STRING SIZE"
#define szFORCEOCI7 "FORCE OCI7"
#define szCOMPRESSEDPROT "COMPRESSED PROTOCOL"
#define szENCRYPTION "ENCRYPTION"
#define szPREFETCHROWS "PREFETCH ROWS"
#define szAPILIBRARY_FMT "%s API LIBRARY"
#define szFIELDREQUIRED "FIELD REQUIRED"
#define szEMPTYSTRASNULL "EMPTY STRING AS NULL"
#define szUSEOLEDB "USE OLEDB"
#define szBLOBPIECESIZE "BLOB PIECE SIZE"
#define szSERVERCURSOR "SERVER CURSOR"
#define szBYTE16ASGUID "BYTE16 AS GUID"
#define szANSINULLS "ANSI NULLS"
#define szTRANSRETAINING "TRANSACTION RETAINING"
#define szMAXBLOBSIZE "MAX BLOB SIZE"
#define szUSEREGISTRYPATH "USE REGISTRY PATH"
#define szSERVERNAME "SERVER NAME"
#define szDATABASENAME "DATABASE NAME"
#define CAT_NAME_FIELD "CATALOG_NAME"
#define SCH_NAME_FIELD "SCHEMA_NAME"
#define TBL_NAME_FIELD "TABLE_NAME"
#define TBL_TYPE_FIELD "TABLE_TYPE"
#define PROC_NAME_FIELD "PROC_NAME"
#define PROC_TYPE_FIELD "PROC_TYPE"
#define PROC_IN_PARAMS "IN_PARAMS"
#define PROC_OUT_PARAMS "OUT_PARAMS"
#define COL_NAME_FIELD "COLUMN_NAME"
#define COL_POS_FIELD "COLUMN_POSITION"
#define COL_TYPE_FIELD "COLUMN_TYPE"
#define COL_DATATYPE_FIELD "COLUMN_DATATYPE"
#define COL_TYPENAME_FIELD "COLUMN_TYPENAME"
#define COL_SUBTYPE_FIELD "COLUMN_SUBTYPE"
#define COL_PREC_FIELD "COLUMN_PRECISION"
#define COL_SCALE_FIELD "COLUMN_SCALE"
#define COL_LENGTH_FIELD "COLUMN_LENGTH"
#define COL_NULLABLE_FIELD "COLUMN_NULLABLE"
#define COL_DEFAULT_FIELD "COLUMN_DEFAULT"
#define PARAM_NAME_FIELD "PARAM_NAME"
#define PARAM_POS_FIELD "PARAM_POSITION"
#define PARAM_TYPE_FIELD "PARAM_TYPE"
#define PARAM_DATATYPE_FIELD "PARAM_DATATYPE"
#define PARAM_TYPENAME_FIELD "PARAM_TYPENAME"
#define PARAM_PREC_FIELD "PARAM_PRECISION"
#define PARAM_SCALE_FIELD "PARAM_SCALE"
#define PARAM_LENGTH_FIELD "PARAM_LENGTH"
#define PARAM_NULLABLE_FIELD "PARAM_NULLABLE"
#define IDX_NAME_FIELD "INDEX_NAME"
#define IDX_COL_NAME_FIELD "COLUMN_NAME"
#define IDX_COL_POS_FIELD "COLUMN_POSITION"
#define IDX_TYPE_FIELD "INDEX_TYPE"
#define IDX_PKEY_NAME_FIELD "PKEY_NAME"
#define IDX_SORT_FIELD "SORT_ORDER"
#define IDX_FILTER_FIELD "INDEX_FILTER"
#define PACKAGE_NAME_FIELD "OBJECT_NAME"
#define OLD_FIELD_PREFIX "OLD_"
static const Shortint ttTable = 0x1;
static const Shortint ttView = 0x2;
static const Shortint ttSysTable = 0x4;
static const Shortint ttSynonym = 0x8;
static const Shortint ttTempTable = 0x10;
static const Shortint ttLocalTable = 0x20;
static const Shortint NonUniqueIndexType = 0x1;
static const Shortint UniqueIndexType = 0x2;
static const Shortint PrimaryIndexType = 0x4;
static const char AscSortOrder = '\x41';
static const char DescSortOrder = '\x44';
static const Shortint ProcedureProcType = 0x1;
static const Shortint FunctionProcType = 0x2;
#define DB2_SelectAutoIncField "VALUES IDENTITY_VAL_LOCAL()"
#define Inf_SelectAutoIncField "select UNIQUE DBINFO (\"sqlca.sqlerrd1\") from SYSTABLES w"\
	"here TABID=1"
#define MySql_SelectAutoIncField "select LAST_INSERT_ID()"
#define SS_SelectAutoIncField "select CONVERT(int, @@IDENTITY)"
#define SQL_TOKEN_Select "SELECT "
static const char CRChar = '\xd';
static const char LFChar = '\xa';
static const char SPChar = '\x20';
#define CRLFString "\r\n"
static const char FilterWildcard = '\x2a';
static const char DefaultQueryMacroChar = '\x25';
#define DefaultQueryMacroExpr "0=0"
static const char DefaultScriptTermChar = '\x3b';
extern PACKAGE System::ResourceString _SFuncNotImplemented;
#define Sdconsts_SFuncNotImplemented System::LoadResourceString(&Sdconsts::_SFuncNotImplemented)
extern PACKAGE System::ResourceString _SAutoSessionExclusive;
#define Sdconsts_SAutoSessionExclusive System::LoadResourceString(&Sdconsts::_SAutoSessionExclusive)
	
extern PACKAGE System::ResourceString _SAutoSessionExists;
#define Sdconsts_SAutoSessionExists System::LoadResourceString(&Sdconsts::_SAutoSessionExists)
extern PACKAGE System::ResourceString _SAutoSessionActive;
#define Sdconsts_SAutoSessionActive System::LoadResourceString(&Sdconsts::_SAutoSessionActive)
extern PACKAGE System::ResourceString _SDuplicateDatabaseName;
#define Sdconsts_SDuplicateDatabaseName System::LoadResourceString(&Sdconsts::_SDuplicateDatabaseName)
	
extern PACKAGE System::ResourceString _SDuplicateSessionName;
#define Sdconsts_SDuplicateSessionName System::LoadResourceString(&Sdconsts::_SDuplicateSessionName)
	
extern PACKAGE System::ResourceString _SInvalidSessionName;
#define Sdconsts_SInvalidSessionName System::LoadResourceString(&Sdconsts::_SInvalidSessionName)
extern PACKAGE System::ResourceString _SDatabaseNameMissing;
#define Sdconsts_SDatabaseNameMissing System::LoadResourceString(&Sdconsts::_SDatabaseNameMissing)
extern PACKAGE System::ResourceString _SRemoteDatabaseNameMissing;
#define Sdconsts_SRemoteDatabaseNameMissing System::LoadResourceString(&Sdconsts::_SRemoteDatabaseNameMissing)
	
extern PACKAGE System::ResourceString _SSessionNameMissing;
#define Sdconsts_SSessionNameMissing System::LoadResourceString(&Sdconsts::_SSessionNameMissing)
extern PACKAGE System::ResourceString _SDatabaseOpen;
#define Sdconsts_SDatabaseOpen System::LoadResourceString(&Sdconsts::_SDatabaseOpen)
extern PACKAGE System::ResourceString _SDatabaseClosed;
#define Sdconsts_SDatabaseClosed System::LoadResourceString(&Sdconsts::_SDatabaseClosed)
extern PACKAGE System::ResourceString _SDatabaseHandleSet;
#define Sdconsts_SDatabaseHandleSet System::LoadResourceString(&Sdconsts::_SDatabaseHandleSet)
extern PACKAGE System::ResourceString _SSessionActive;
#define Sdconsts_SSessionActive System::LoadResourceString(&Sdconsts::_SSessionActive)
extern PACKAGE System::ResourceString _SHandleError;
#define Sdconsts_SHandleError System::LoadResourceString(&Sdconsts::_SHandleError)
extern PACKAGE System::ResourceString _SInvalidFloatField;
#define Sdconsts_SInvalidFloatField System::LoadResourceString(&Sdconsts::_SInvalidFloatField)
extern PACKAGE System::ResourceString _SInvalidIntegerField;
#define Sdconsts_SInvalidIntegerField System::LoadResourceString(&Sdconsts::_SInvalidIntegerField)
extern PACKAGE System::ResourceString _STableMismatch;
#define Sdconsts_STableMismatch System::LoadResourceString(&Sdconsts::_STableMismatch)
extern PACKAGE System::ResourceString _SFieldAssignError;
#define Sdconsts_SFieldAssignError System::LoadResourceString(&Sdconsts::_SFieldAssignError)
extern PACKAGE System::ResourceString _SUnknownFieldType;
#define Sdconsts_SUnknownFieldType System::LoadResourceString(&Sdconsts::_SUnknownFieldType)
extern PACKAGE System::ResourceString _SBadFieldType;
#define Sdconsts_SBadFieldType System::LoadResourceString(&Sdconsts::_SBadFieldType)
extern PACKAGE System::ResourceString _SCompositeIndexError;
#define Sdconsts_SCompositeIndexError System::LoadResourceString(&Sdconsts::_SCompositeIndexError)
extern PACKAGE System::ResourceString _SInvalidBatchMove;
#define Sdconsts_SInvalidBatchMove System::LoadResourceString(&Sdconsts::_SInvalidBatchMove)
extern PACKAGE System::ResourceString _SEmptySQLStatement;
#define Sdconsts_SEmptySQLStatement System::LoadResourceString(&Sdconsts::_SEmptySQLStatement)
extern PACKAGE System::ResourceString _SNoParameterValue;
#define Sdconsts_SNoParameterValue System::LoadResourceString(&Sdconsts::_SNoParameterValue)
extern PACKAGE System::ResourceString _SNoParameterType;
#define Sdconsts_SNoParameterType System::LoadResourceString(&Sdconsts::_SNoParameterType)
extern PACKAGE System::ResourceString _SNoParameterDataType;
#define Sdconsts_SNoParameterDataType System::LoadResourceString(&Sdconsts::_SNoParameterDataType)
extern PACKAGE System::ResourceString _SBadParameterType;
#define Sdconsts_SBadParameterType System::LoadResourceString(&Sdconsts::_SBadParameterType)
extern PACKAGE System::ResourceString _SParameterNotFound;
#define Sdconsts_SParameterNotFound System::LoadResourceString(&Sdconsts::_SParameterNotFound)
extern PACKAGE System::ResourceString _SParamTooBig;
#define Sdconsts_SParamTooBig System::LoadResourceString(&Sdconsts::_SParamTooBig)
extern PACKAGE System::ResourceString _SLoginError;
#define Sdconsts_SLoginError System::LoadResourceString(&Sdconsts::_SLoginError)
extern PACKAGE System::ResourceString _SFKInternalCalc;
#define Sdconsts_SFKInternalCalc System::LoadResourceString(&Sdconsts::_SFKInternalCalc)
extern PACKAGE System::ResourceString _SDatasetDesigner;
#define Sdconsts_SDatasetDesigner System::LoadResourceString(&Sdconsts::_SDatasetDesigner)
extern PACKAGE System::ResourceString _SDatabaseEditor;
#define Sdconsts_SDatabaseEditor System::LoadResourceString(&Sdconsts::_SDatabaseEditor)
extern PACKAGE System::ResourceString _SExplore;
#define Sdconsts_SExplore System::LoadResourceString(&Sdconsts::_SExplore)
extern PACKAGE System::ResourceString _SLinkDesigner;
#define Sdconsts_SLinkDesigner System::LoadResourceString(&Sdconsts::_SLinkDesigner)
extern PACKAGE System::ResourceString _SLinkDetail;
#define Sdconsts_SLinkDetail System::LoadResourceString(&Sdconsts::_SLinkDetail)
extern PACKAGE System::ResourceString _SLinkMasterSource;
#define Sdconsts_SLinkMasterSource System::LoadResourceString(&Sdconsts::_SLinkMasterSource)
extern PACKAGE System::ResourceString _SLinkMaster;
#define Sdconsts_SLinkMaster System::LoadResourceString(&Sdconsts::_SLinkMaster)
extern PACKAGE System::ResourceString _SQBEVerb;
#define Sdconsts_SQBEVerb System::LoadResourceString(&Sdconsts::_SQBEVerb)
extern PACKAGE System::ResourceString _SBindVerb;
#define Sdconsts_SBindVerb System::LoadResourceString(&Sdconsts::_SBindVerb)
extern PACKAGE System::ResourceString _SDisconnectDatabase;
#define Sdconsts_SDisconnectDatabase System::LoadResourceString(&Sdconsts::_SDisconnectDatabase)
extern PACKAGE System::ResourceString _SLookupSourceError;
#define Sdconsts_SLookupSourceError System::LoadResourceString(&Sdconsts::_SLookupSourceError)
extern PACKAGE System::ResourceString _SLookupTableError;
#define Sdconsts_SLookupTableError System::LoadResourceString(&Sdconsts::_SLookupTableError)
extern PACKAGE System::ResourceString _SLookupIndexError;
#define Sdconsts_SLookupIndexError System::LoadResourceString(&Sdconsts::_SLookupIndexError)
extern PACKAGE System::ResourceString _SParameterTypes;
#define Sdconsts_SParameterTypes System::LoadResourceString(&Sdconsts::_SParameterTypes)
extern PACKAGE System::ResourceString _SInvalidParamFieldType;
#define Sdconsts_SInvalidParamFieldType System::LoadResourceString(&Sdconsts::_SInvalidParamFieldType)
	
extern PACKAGE System::ResourceString _STruncationError;
#define Sdconsts_STruncationError System::LoadResourceString(&Sdconsts::_STruncationError)
extern PACKAGE System::ResourceString _SInvalidVersion;
#define Sdconsts_SInvalidVersion System::LoadResourceString(&Sdconsts::_SInvalidVersion)
extern PACKAGE System::ResourceString _SDataTypes;
#define Sdconsts_SDataTypes System::LoadResourceString(&Sdconsts::_SDataTypes)
extern PACKAGE System::ResourceString _SResultName;
#define Sdconsts_SResultName System::LoadResourceString(&Sdconsts::_SResultName)
extern PACKAGE System::ResourceString _SDBCaption;
#define Sdconsts_SDBCaption System::LoadResourceString(&Sdconsts::_SDBCaption)
extern PACKAGE System::ResourceString _SParamEditor;
#define Sdconsts_SParamEditor System::LoadResourceString(&Sdconsts::_SParamEditor)
extern PACKAGE System::ResourceString _SDatasetEditor;
#define Sdconsts_SDatasetEditor System::LoadResourceString(&Sdconsts::_SDatasetEditor)
extern PACKAGE System::ResourceString _SIndexFilesEditor;
#define Sdconsts_SIndexFilesEditor System::LoadResourceString(&Sdconsts::_SIndexFilesEditor)
extern PACKAGE System::ResourceString _SNoIndexFiles;
#define Sdconsts_SNoIndexFiles System::LoadResourceString(&Sdconsts::_SNoIndexFiles)
extern PACKAGE System::ResourceString _SIndexDoesNotExist;
#define Sdconsts_SIndexDoesNotExist System::LoadResourceString(&Sdconsts::_SIndexDoesNotExist)
extern PACKAGE System::ResourceString _SNoTableName;
#define Sdconsts_SNoTableName System::LoadResourceString(&Sdconsts::_SNoTableName)
extern PACKAGE System::ResourceString _SBatchExecute;
#define Sdconsts_SBatchExecute System::LoadResourceString(&Sdconsts::_SBatchExecute)
extern PACKAGE System::ResourceString _SNoCachedUpdates;
#define Sdconsts_SNoCachedUpdates System::LoadResourceString(&Sdconsts::_SNoCachedUpdates)
extern PACKAGE System::ResourceString _SInvalidAliasName;
#define Sdconsts_SInvalidAliasName System::LoadResourceString(&Sdconsts::_SInvalidAliasName)
extern PACKAGE System::ResourceString _SDBGridColEditor;
#define Sdconsts_SDBGridColEditor System::LoadResourceString(&Sdconsts::_SDBGridColEditor)
extern PACKAGE System::ResourceString _SExprBadVersion;
#define Sdconsts_SExprBadVersion System::LoadResourceString(&Sdconsts::_SExprBadVersion)
extern PACKAGE System::ResourceString _SExprTermination;
#define Sdconsts_SExprTermination System::LoadResourceString(&Sdconsts::_SExprTermination)
extern PACKAGE System::ResourceString _SExprNameError;
#define Sdconsts_SExprNameError System::LoadResourceString(&Sdconsts::_SExprNameError)
extern PACKAGE System::ResourceString _SExprStringError;
#define Sdconsts_SExprStringError System::LoadResourceString(&Sdconsts::_SExprStringError)
extern PACKAGE System::ResourceString _SExprInvalidChar;
#define Sdconsts_SExprInvalidChar System::LoadResourceString(&Sdconsts::_SExprInvalidChar)
extern PACKAGE System::ResourceString _SExprNoRParen;
#define Sdconsts_SExprNoRParen System::LoadResourceString(&Sdconsts::_SExprNoRParen)
extern PACKAGE System::ResourceString _SExprExpected;
#define Sdconsts_SExprExpected System::LoadResourceString(&Sdconsts::_SExprExpected)
extern PACKAGE System::ResourceString _SExprBadCompare;
#define Sdconsts_SExprBadCompare System::LoadResourceString(&Sdconsts::_SExprBadCompare)
extern PACKAGE System::ResourceString _SExprBadField;
#define Sdconsts_SExprBadField System::LoadResourceString(&Sdconsts::_SExprBadField)
extern PACKAGE System::ResourceString _SExprBadNullTest;
#define Sdconsts_SExprBadNullTest System::LoadResourceString(&Sdconsts::_SExprBadNullTest)
extern PACKAGE System::ResourceString _SExprRangeError;
#define Sdconsts_SExprRangeError System::LoadResourceString(&Sdconsts::_SExprRangeError)
extern PACKAGE System::ResourceString _SExprNotBoolean;
#define Sdconsts_SExprNotBoolean System::LoadResourceString(&Sdconsts::_SExprNotBoolean)
extern PACKAGE System::ResourceString _SExprIncorrect;
#define Sdconsts_SExprIncorrect System::LoadResourceString(&Sdconsts::_SExprIncorrect)
extern PACKAGE System::ResourceString _SExprNothing;
#define Sdconsts_SExprNothing System::LoadResourceString(&Sdconsts::_SExprNothing)
extern PACKAGE System::ResourceString _SNoFieldAccess;
#define Sdconsts_SNoFieldAccess System::LoadResourceString(&Sdconsts::_SNoFieldAccess)
extern PACKAGE System::ResourceString _SUpdateSQLEditor;
#define Sdconsts_SUpdateSQLEditor System::LoadResourceString(&Sdconsts::_SUpdateSQLEditor)
extern PACKAGE System::ResourceString _SNoDataSet;
#define Sdconsts_SNoDataSet System::LoadResourceString(&Sdconsts::_SNoDataSet)
extern PACKAGE System::ResourceString _SUntitled;
#define Sdconsts_SUntitled System::LoadResourceString(&Sdconsts::_SUntitled)
extern PACKAGE System::ResourceString _SUpdateWrongDB;
#define Sdconsts_SUpdateWrongDB System::LoadResourceString(&Sdconsts::_SUpdateWrongDB)
extern PACKAGE System::ResourceString _SUpdateFailed;
#define Sdconsts_SUpdateFailed System::LoadResourceString(&Sdconsts::_SUpdateFailed)
extern PACKAGE System::ResourceString _SSQLGenSelect;
#define Sdconsts_SSQLGenSelect System::LoadResourceString(&Sdconsts::_SSQLGenSelect)
extern PACKAGE System::ResourceString _SSQLNotGenerated;
#define Sdconsts_SSQLNotGenerated System::LoadResourceString(&Sdconsts::_SSQLNotGenerated)
extern PACKAGE System::ResourceString _SSQLDataSetOpen;
#define Sdconsts_SSQLDataSetOpen System::LoadResourceString(&Sdconsts::_SSQLDataSetOpen)
extern PACKAGE System::ResourceString _SLocalTransDirty;
#define Sdconsts_SLocalTransDirty System::LoadResourceString(&Sdconsts::_SLocalTransDirty)
extern PACKAGE System::ResourceString _SPrimary;
#define Sdconsts_SPrimary System::LoadResourceString(&Sdconsts::_SPrimary)
extern PACKAGE System::ResourceString _SClientDSAssignData;
#define Sdconsts_SClientDSAssignData System::LoadResourceString(&Sdconsts::_SClientDSAssignData)
extern PACKAGE System::ResourceString _SClientDSClearData;
#define Sdconsts_SClientDSClearData System::LoadResourceString(&Sdconsts::_SClientDSClearData)
extern PACKAGE System::ResourceString _SClientDataSetEditor;
#define Sdconsts_SClientDataSetEditor System::LoadResourceString(&Sdconsts::_SClientDataSetEditor)
extern PACKAGE System::ResourceString _SMissingDataSet;
#define Sdconsts_SMissingDataSet System::LoadResourceString(&Sdconsts::_SMissingDataSet)
extern PACKAGE System::ResourceString _SFatalError;
#define Sdconsts_SFatalError System::LoadResourceString(&Sdconsts::_SFatalError)
extern PACKAGE System::ResourceString _SMismatchFieldSize;
#define Sdconsts_SMismatchFieldSize System::LoadResourceString(&Sdconsts::_SMismatchFieldSize)
extern PACKAGE System::ResourceString _SNoStoredProcName;
#define Sdconsts_SNoStoredProcName System::LoadResourceString(&Sdconsts::_SNoStoredProcName)
extern PACKAGE System::ResourceString _SInsufficientColumnBufSize;
#define Sdconsts_SInsufficientColumnBufSize System::LoadResourceString(&Sdconsts::_SInsufficientColumnBufSize)
	
extern PACKAGE System::ResourceString _SInsufficientColNameBufSizeFmt;
#define Sdconsts_SInsufficientColNameBufSizeFmt System::LoadResourceString(&Sdconsts::_SInsufficientColNameBufSizeFmt)
	
extern PACKAGE System::ResourceString _SInsufficientIDateTimeBufSize;
#define Sdconsts_SInsufficientIDateTimeBufSize System::LoadResourceString(&Sdconsts::_SInsufficientIDateTimeBufSize)
	
extern PACKAGE System::ResourceString _SUpdateImpossible;
#define Sdconsts_SUpdateImpossible System::LoadResourceString(&Sdconsts::_SUpdateImpossible)
extern PACKAGE System::ResourceString _SNotInTransaction;
#define Sdconsts_SNotInTransaction System::LoadResourceString(&Sdconsts::_SNotInTransaction)
extern PACKAGE System::ResourceString _SInTransaction;
#define Sdconsts_SInTransaction System::LoadResourceString(&Sdconsts::_SInTransaction)
extern PACKAGE System::ResourceString _SServerOpen;
#define Sdconsts_SServerOpen System::LoadResourceString(&Sdconsts::_SServerOpen)
extern PACKAGE System::ResourceString _SServerClosed;
#define Sdconsts_SServerClosed System::LoadResourceString(&Sdconsts::_SServerClosed)
extern PACKAGE System::ResourceString _SServerNameMissing;
#define Sdconsts_SServerNameMissing System::LoadResourceString(&Sdconsts::_SServerNameMissing)
extern PACKAGE System::ResourceString _SServerLoginError;
#define Sdconsts_SServerLoginError System::LoadResourceString(&Sdconsts::_SServerLoginError)
extern PACKAGE System::ResourceString _SNoServerType;
#define Sdconsts_SNoServerType System::LoadResourceString(&Sdconsts::_SNoServerType)
extern PACKAGE System::ResourceString _SServerTypeMismatch;
#define Sdconsts_SServerTypeMismatch System::LoadResourceString(&Sdconsts::_SServerTypeMismatch)
extern PACKAGE System::ResourceString _SBadServerType;
#define Sdconsts_SBadServerType System::LoadResourceString(&Sdconsts::_SBadServerType)
extern PACKAGE System::ResourceString _SFieldDescNotFound;
#define Sdconsts_SFieldDescNotFound System::LoadResourceString(&Sdconsts::_SFieldDescNotFound)
extern PACKAGE System::ResourceString _SInvalidOperation;
#define Sdconsts_SInvalidOperation System::LoadResourceString(&Sdconsts::_SInvalidOperation)
extern PACKAGE System::ResourceString _SNoCapability;
#define Sdconsts_SNoCapability System::LoadResourceString(&Sdconsts::_SNoCapability)
extern PACKAGE System::ResourceString _SFuncFailed;
#define Sdconsts_SFuncFailed System::LoadResourceString(&Sdconsts::_SFuncFailed)
extern PACKAGE System::ResourceString _SRecordMissingLocally;
#define Sdconsts_SRecordMissingLocally System::LoadResourceString(&Sdconsts::_SRecordMissingLocally)
	
extern PACKAGE System::ResourceString _SFalseString;
#define Sdconsts_SFalseString System::LoadResourceString(&Sdconsts::_SFalseString)
extern PACKAGE System::ResourceString _STrueString;
#define Sdconsts_STrueString System::LoadResourceString(&Sdconsts::_STrueString)
extern PACKAGE System::ResourceString _STextFalse;
#define Sdconsts_STextFalse System::LoadResourceString(&Sdconsts::_STextFalse)
extern PACKAGE System::ResourceString _STextTrue;
#define Sdconsts_STextTrue System::LoadResourceString(&Sdconsts::_STextTrue)
extern PACKAGE System::ResourceString _SRecordChanged;
#define Sdconsts_SRecordChanged System::LoadResourceString(&Sdconsts::_SRecordChanged)
extern PACKAGE System::ResourceString _STableReadOnly;
#define Sdconsts_STableReadOnly System::LoadResourceString(&Sdconsts::_STableReadOnly)
extern PACKAGE System::ResourceString _SMonitorActive;
#define Sdconsts_SMonitorActive System::LoadResourceString(&Sdconsts::_SMonitorActive)
extern PACKAGE System::ResourceString _SFileNameBlank;
#define Sdconsts_SFileNameBlank System::LoadResourceString(&Sdconsts::_SFileNameBlank)
extern PACKAGE System::ResourceString _SFieldTypeNotConverted;
#define Sdconsts_SFieldTypeNotConverted System::LoadResourceString(&Sdconsts::_SFieldTypeNotConverted)
	

}	/* namespace Sdconsts */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sdconsts;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SDConsts
