unit XSConsts;

interface

const
  SXSQLConnectProductName = 'XSQLConnect';
  SXSQLConnectVersion     = '1';
  
  SLinkXSQLConnectHome	= '';
  SLinkXSQLConnectStdOrder= '';
  SLinkXSQLConnectProOrder= '';
  SLinkXSQLConnectSupport	= '';
  SErrOpenWwwSite	= 'Error opening following address: %s';
  srXSQLConnect		= 'XSQLConnect';

const
	{ constants for database's parameters }
  szUSERNAME    = 'USER NAME';
  szPASSWORD    = 'PASSWORD';

  szAPPNAME     = 'APPLICATION NAME';
  szHOSTNAME    = 'HOST NAME';
  szMAXCURSORS  = 'MAX CURSORS';
  szQUOTE_IDENT = 'QUOTE IDENTIFIER';           // use quoted (delimited) identifiers for automatically generated statements of a live querys and a table component
  szQUOTEDIDENT	= 'QUOTED IDENTIFIER';		// enable or disable to use of quoted identifiers (for MSSQL and Sybase)
  szSINGLECONN	= 'SINGLE CONNECTION';		// whether to use a single database process/connection (for MSSQL)
  szTDSPACKETSIZE   = 'TDS PACKET SIZE';	// TDS packet size (for OLEDB&MSSQL, Sybase)
  szRTRIMCHAROUTPUT = 'RTRIM CHAR OUTPUT';	// trim trailing spaces in the output of CHAR  datatype for Oracle. VARCHAR is returned without changes
  szENABLEINTS	= 'ENABLE INTEGERS';		// converts NUMERIC database field with no scale into integer field in an application, it has preference before "ENABLE BCD"
  szENABLEBCD	= 'ENABLE BCD';			// converts NUMERIC database field with scale (1-4) into BCD field in an application to exclude the rounding errors
  szENABLEMONEY	= 'ENABLE MONEY';		// converts NUMERIC database field with scale (1-4) into TCurrencyField in an application (for MySQL)
  szSQLDialect	= 'SQL Dialect';		// client SQL Dialect(1,2,3) for Interbase
  szLOCALCHARSET= 'LOCAL CHARSET';		// local charset for Interbase
  szROLENAME	= 'ROLE NAME';			// role name for Interbase and Oracle (connect as SYSDBA, SYSOPER)
  szAUTOCOMMIT	= 'AUTOCOMMIT';			// whether to use autocommit when transaction processing is not used explicitly
  szLOGINTIMEOUT= 'LOGIN TIMEOUT';		// number of seconds to wait for a login request
  szCMDTIMEOUT	= 'COMMAND TIMEOUT';		// number of seconds to wait for any request on the connection to complete
  szNEWPASSWORD	= 'NEW PASSWORD';		// it is used when a server returns 'Password expired' error
  szSERVERPORT	= 'SERVER PORT';		// number of a server port(non-default) for MySQL
  szXACONN	= 'XA CONNECTION';   		// whether to use RemoteDatabase as a service name of transaction monitor
  szTRANSLOGGING= 'TRANSACTION LOGGING';	// if it's equal FALSE, transaction logging is not performed (rollback is impossible) for SQLBase
  szMAXFIELDNAMELEN = 'MAXFIELDNAMELEN'; 	// max length of field names
  szMAXCHARPARAMLEN = 'MAXCHARPARAMLEN'; 	// defines maximum size of a buffer for string parameters, by default, it's equal 255
  szMAXSTRINGSIZE= 'MAX STRING SIZE';		// a limit of a string field size, larger fields will be considered as blob
  szFORCEOCI7 	= 'FORCE OCI7';			// force to use OCI7(SQL*Net 2.x - Oracle7 interface) to access Oracle server
  szCOMPRESSEDPROT = 'COMPRESSED PROTOCOL';	// whether to use the compressed client/server protocol for MySQL, by default it's True
  szENCRYPTION	= 'ENCRYPTION';			// whether to use encrypted password security handshaking (Sybase), by default it's false
  szPREFETCHROWS= 'PREFETCH ROWS';		// sets the number of rows to be prefetched (for Oracle8, DB2, Informmix, ODBC)(prefetching is not in effect if SELECT contains BLOB columns)
  szAPILIBRARY_FMT = '%s API LIBRARY';	 	// interface library
  szFIELDREQUIRED= 'FIELD REQUIRED';            // value of Required property of all TField
  szEMPTYSTRASNULL = 'EMPTY STRING AS NULL';    // empty string ('') is treated as NULL for parameter's values, default is False (for Sybase)
  szUSEOLEDB    = 'USE OLEDB';                  // use OLEDB connection, even ServerType is not equal stOLEDB, default is False (for MSSQL now)
  szBLOBPIECESIZE='BLOB PIECE SIZE';            // size of read/write blob piece (for SQLBase, ODBC, OLEDB, Oracle, Sybase)
  szSERVERCURSOR ='SERVER CURSOR';              // use server cursors, default is False (OLEDB, ODBC)
  szBYTE16ASGUID ='BYTE16 AS GUID';             // binary(16) and GUID columns will be considered as TGuidField (SQLServer). DB-Library returns both datatypes as binary.
  szANSINULLS   = 'ANSI NULLS';                 // set ANSI_NULLS (comparison) setting (MSSQL)
  szTRANSRETAINING = 'TRANSACTION RETAINING';   // when False, then force to set off commit/rollback retaining. Default value is True (Interbase, Firebird)
  szMAXBLOBSIZE = 'MAX BLOB SIZE';              // when it is required to restrict blob size of the selected data (ODBC&DB2 host)
  szUSEREGISTRYPATH= 'USE REGISTRY PATH';       // ??? use registry key to locate API library, when it is possible

  	{ aren't used now }
  szSERVERNAME	= 'SERVER NAME';
  szDATABASENAME= 'DATABASE NAME';

	{ Constans are used in GetSchemaInfo methods }
  CAT_NAME_FIELD 	= 'CATALOG_NAME';	// database, where it's possible
  SCH_NAME_FIELD 	= 'SCHEMA_NAME';	// owner
  TBL_NAME_FIELD 	= 'TABLE_NAME';
  TBL_TYPE_FIELD 	= 'TABLE_TYPE';
  PROC_NAME_FIELD 	= 'PROC_NAME';
  PROC_TYPE_FIELD 	= 'PROC_TYPE';
  PROC_IN_PARAMS	= 'IN_PARAMS';
  PROC_OUT_PARAMS	= 'OUT_PARAMS';

  COL_NAME_FIELD 	= 'COLUMN_NAME';
  COL_POS_FIELD 	= 'COLUMN_POSITION';
  COL_TYPE_FIELD 	= 'COLUMN_TYPE';
  COL_DATATYPE_FIELD 	= 'COLUMN_DATATYPE';
  COL_TYPENAME_FIELD 	= 'COLUMN_TYPENAME';
  COL_SUBTYPE_FIELD 	= 'COLUMN_SUBTYPE';
  COL_PREC_FIELD 	= 'COLUMN_PRECISION';
  COL_SCALE_FIELD 	= 'COLUMN_SCALE';
  COL_LENGTH_FIELD 	= 'COLUMN_LENGTH';
  COL_NULLABLE_FIELD 	= 'COLUMN_NULLABLE';
  COL_DEFAULT_FIELD 	= 'COLUMN_DEFAULT';

  PARAM_NAME_FIELD      = 'PARAM_NAME';
  PARAM_POS_FIELD 	= 'PARAM_POSITION';
  PARAM_TYPE_FIELD      = 'PARAM_TYPE';
  PARAM_DATATYPE_FIELD  = 'PARAM_DATATYPE';
  PARAM_TYPENAME_FIELD  = 'PARAM_TYPENAME';
  PARAM_PREC_FIELD      = 'PARAM_PRECISION';
  PARAM_SCALE_FIELD     = 'PARAM_SCALE';
  PARAM_LENGTH_FIELD    = 'PARAM_LENGTH';
  PARAM_NULLABLE_FIELD  = 'PARAM_NULLABLE';

  IDX_NAME_FIELD 	= 'INDEX_NAME';
  IDX_COL_NAME_FIELD 	= 'COLUMN_NAME';
  IDX_COL_POS_FIELD 	= 'COLUMN_POSITION';
  IDX_TYPE_FIELD 	= 'INDEX_TYPE';
  IDX_PKEY_NAME_FIELD 	= 'PKEY_NAME';
  IDX_SORT_FIELD 	= 'SORT_ORDER';
  IDX_FILTER_FIELD 	= 'INDEX_FILTER';

  PACKAGE_NAME_FIELD 	= 'OBJECT_NAME';

	// it's used to rename fields, which are not possible to remove from schema info result sets 
  OLD_FIELD_PREFIX = 'OLD_';

  	// Table types, which used in TXSQLDatabase.GetSchemaInfo
  ttTable	= $1;
  ttView	= $2;
  ttSysTable	= $4;
  ttSynonym	= $8;
  ttTempTable	= $10;
  ttLocalTable	= $20;

  	// Index types and sort orders, which used in TXSQLDatabase.GetSchemaInfo
  NonUniqueIndexType	= $1;
  UniqueIndexType	= $2;
  PrimaryIndexType	= $4;

  AscSortOrder 		= 'A';
  DescSortOrder 	= 'D';
  
        // procedure types, which used in TXSQLDatabase.GetSchemaInfo
  ProcedureProcType  = 1;
  FunctionProcType   = 2;  

  DB2_SelectAutoIncField= 'VALUES IDENTITY_VAL_LOCAL()';
  Inf_SelectAutoIncField= 'select UNIQUE DBINFO ("sqlca.sqlerrd1") from SYSTABLES where TABID=1';
  MySql_SelectAutoIncField= 'select LAST_INSERT_ID()';
  SS_SelectAutoIncField= 'select CONVERT(int, @@IDENTITY)';	// for MS and Sybase SQL Server and ASA

  SQL_TOKEN_Select    = 'SELECT ';           { do not localize }

  CRChar        = #$0D;
  LFChar        = #$0A;
  SPChar        = #$20;  
  CRLFString = #$0D#$0A;
  FilterWildcard = '*';         // it could be used in Filter property

const
  DefaultQueryMacroChar	= '%';
  DefaultQueryMacroExpr	= '0=0';
  DefaultScriptTermChar	= ';';


resourcestring
  SFuncNotImplemented 	= 'Function %s not implemented';

  SAutoSessionExclusive	= 'Cannot enable AutoSessionName property with more than one session on a form or data-module';
  SAutoSessionExists	= 'Cannot add a session to the form or data-module while session ''%s'' has AutoSessionName enabled';
  SAutoSessionActive	= 'Cannot modify SessionName while AutoSessionName is enabled';

  SDuplicateDatabaseName= 'Duplicate database name ''%s''';
  SDuplicateSessionName = 'Duplicate session name ''%s''';
  SInvalidSessionName 	= 'Invalid session name %s';
  SDatabaseNameMissing 	= 'Database name missing';
  SRemoteDatabaseNameMissing = 'Name of remote database missing';
  SSessionNameMissing 	= 'Session name missing';
  SDatabaseOpen 	= 'Cannot perform this operation on an open database';
  SDatabaseClosed 	= 'Cannot perform this operation on a closed database';
  SDatabaseHandleSet 	= 'Database handle owned by a different session';
  SSessionActive 	= 'Cannot perform this operation on an active session';
  SHandleError 		= 'Error creating cursor handle';
  SInvalidFloatField 	= 'Cannot convert field ''%s'' to a floating point value';
  SInvalidIntegerField 	= 'Cannot convert field ''%s'' to an integer value';
  STableMismatch 	= 'Source and destination tables are incompatible';
  SFieldAssignError 	= 'Fields ''%s'' and ''%s'' are not assignment compatible';
  SUnknownFieldType	= 'Field ''%s'' is of an unknown type';
  SBadFieldType		= 'Field ''%s'' is of an unsupported type';
  SCompositeIndexError 	= 'Cannot use array of Field values with Expression Indices';
  SInvalidBatchMove 	= 'Invalid batch move parameters';
  SEmptySQLStatement 	= 'No SQL statement available';
  SNoParameterValue 	= 'No value for parameter ''%s''';
  SNoParameterType 	= 'No parameter type for parameter ''%s''';
  SNoParameterDataType	= 'Unknown data type for parameter ''%s''';
  SBadParameterType	= 'Unknown parameter type for parameter ''%s''';
  SParameterNotFound 	= 'Parameter ''%s'' not found';
  SParamTooBig 		= 'Parameter ''%s'', cannot save data larger than %d bytes';
  SLoginError 		= 'Cannot connect to database ''%s''';
  SFKInternalCalc 	= '&InternalCalc';
{$IFDEF XSQL_VCL5}        // there is local menu item 'Scal&e' in Delphi 5 IDE
  SDatasetDesigner 	= 'Fields Edi&tor...';
  SDatabaseEditor 	= 'Da&tabase Editor...';
{$ELSE}
  SDatasetDesigner 	= 'Fields &Editor...';
  SDatabaseEditor 	= 'Database &Editor...';
{$ENDIF}  
  SExplore 		= 'E&xplore';
  SLinkDesigner 	= 'Field ''%s'', from the Detail Fields list, must be linked';
  SLinkDetail 		= 'Table ''%s'' cannot be opened';
  SLinkMasterSource 	= 'The MasterSource property of ''%s'' must be linked to a DataSource';
  SLinkMaster 		= 'Unable to open the MasterSource Table';
  SQBEVerb 		= '&Query Builder...';
  SBindVerb 		= 'Define &Parameters...';
  SDisconnectDatabase 	= 'Database is currently connected. Disconnect and continue?';
  SLookupSourceError 	= 'Unable to use duplicate DataSource and LookupSource';
  SLookupTableError 	= 'LookupSource must be connected to TTable component';
  SLookupIndexError 	= '%s must be the lookup table''s active index';
  SParameterTypes 	= ';Input;Output;Input/Output;Result';
  SInvalidParamFieldType= 'Must have a valid field type selected';
  STruncationError 	= 'Parameter ''%s'' truncated on output';
  SInvalidVersion 	= 'Unable to load bind parameters';
  SDataTypes 		= ';String;SmallInt;Integer;Word;Boolean;Float;Currency;BCD;Date;Time;DateTime;;;;Blob;Memo;Graphic;;;;;Cursor;';
  SResultName 		= 'Result';
  SDBCaption 		= '%s.%s Database';
  SParamEditor 		= '%s.%s Parameters';
  SDatasetEditor 	= '%s.%s';
  SIndexFilesEditor 	= '%s.%s Index Files';
  SNoIndexFiles 	= '(None)';
  SIndexDoesNotExist 	= 'Index does not exist. Index: %s';
  SNoTableName 		= 'Missing TableName property';
  SBatchExecute 	= 'Execute';
  SNoCachedUpdates 	= 'Not in cached update mode';
  SInvalidAliasName 	= 'Invalid alias name %s';
  SDBGridColEditor 	= 'Co&lumns Editor...';

  SExprBadVersion	= 'Version %s of expression is not supported';
  SExprTermination 	= 'Filter expression incorrectly terminated';
  SExprNameError 	= 'Unterminated field name';
  SExprStringError 	= 'Unterminated string constant';
  SExprInvalidChar 	= 'Invalid filter expression character: ''%s''';
  SExprNoRParen 	= ''')'' expected but %s found';
  SExprExpected 	= 'Expression expected but %s found';
  SExprBadCompare 	= 'Relational operators require a field and a constant';
  SExprBadField 	= 'Field ''%s'' cannot be used in a filter expression';
  SExprBadNullTest 	= 'NULL only allowed with ''='' and ''<>''';
  SExprRangeError 	= 'Constant out of range';
  SExprNotBoolean 	= 'Field ''%s'' is not of type Boolean';
  SExprIncorrect 	= 'Incorrectly formed filter expression';
  SExprNothing 		= 'nothing';
  SNoFieldAccess 	= 'Cannot access field ''%s'' in a filter';
  SUpdateSQLEditor 	= 'UpdateSQL &Editor...';
  SNoDataSet 		= 'No dataset association';
  SUntitled 		= 'Untitled Application';
  SUpdateWrongDB 	= 'Cannot update, %s is not owned by %s';
  SUpdateFailed 	= 'Update failed';
  SSQLGenSelect 	= 'Must select at least one key field and one update field';
  SSQLNotGenerated 	= 'Update SQL statements not generated, exit anyway?';
  SSQLDataSetOpen 	= 'Unable to determine field names for %s';
  SLocalTransDirty 	= 'The transaction isolation level must be dirty read for local databases';
  SPrimary 		= 'Primary';
  SClientDSAssignData 	= 'Assign &Local Data...';
  SClientDSClearData 	= '&Clear Data';
  SClientDataSetEditor 	= '%s.%s Data';
  SMissingDataSet 	= 'Missing DataSet property';

  SFatalError		= 'Fatal error: %s';
  SMismatchFieldSize 	= 'Mismatch field size for type %s';
  SNoStoredProcName 	= 'Empty stored procedure name';
  SInsufficientColumnBufSize 	= 'Insufficient column buffer size';
  SInsufficientColNameBufSizeFmt= 'Insufficient buffer size for column name ''%s''';  
  SInsufficientIDateTimeBufSize = 'Insufficient buffer size for internal datetime type';
  SUpdateImpossible 	= 'Update impossible (set property UpdateObject or event handler for OnUpdateRecord)';
  SNotInTransaction	= 'Transaction is not active';
  SInTransaction	= 'Transaction is active';

  SServerOpen 		= 'Cannot perform this operation on an open server';
  SServerClosed 	= 'Cannot perform this operation on a closed server';
  SServerNameMissing	= 'Server name missing';
  SServerLoginError	= 'Cannot connect to server ''%s''';
  SNoServerType		= 'SQL-server not supported';
  SServerTypeMismatch	= 'ServerType mismatch, expecting: %s actual: %s';
  SBadServerType	= 'Invalid value for ServerType property';
  SFieldDescNotFound 	= 'Description of field ''%s'' not found';

  SInvalidOperation	= 'Operation not applicable';
  SNoCapability		= 'Capability not supported';
  SFuncFailed		= 'Function "%s" failed';
  SRecordMissingLocally	= 'Record is not available locally';
//  SOwnerTableError 	= 'Unable to resolve owner table for field ''%s''';

  SFalseString		= 'FALSE';
  STrueString		= 'TRUE';
{$IFNDEF XSQL_VCL4}
  STextFalse 		= 'False';
  STextTrue 		= 'True';
{$ENDIF}

  SRecordChanged 	= 'Record changed by another user';
  STableReadOnly	= 'Table is read only';		// in case of open non-updatable requestlive query

  SMonitorActive 	= 'Cannot change database on Active Monitor';
  SFileNameBlank 	= 'FileName property is blank';

  SFieldTypeNotConverted= 'Data conversion is not implemented for datatype ';
  
implementation

end.

