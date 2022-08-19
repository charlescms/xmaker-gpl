{$I XSqlDir.inc}
unit XSCSb {$IFDEF XSQL_CLR} platform {$ENDIF};

interface

uses
  Windows, SysUtils, Classes, Db, Dialogs, SyncObjs,
{$IFDEF XSQL_CLR}
  System.Text, System.Runtime.InteropServices,
{$ENDIF}
  XSCommon, XSConsts;

const
  FetchOk	= 0;
  FetchEof	= 1;
  FetchUpd	= 2;
  FetchDel	= 3;
	{ 	FETCH RETURN CODES 	}
  FetRTru = 1;			// data truncated
  FetRSin = 2;			// signed number fetched
  FetRDnn = 3;			// data is not numeric
  FetRNof = 4;			// numeric overflow
  FetRDtn = 5;			// data type not supported
  FetRDnd = 6;			// data is not in date format
  FetRNul = 7;			// data is null
	{ 	DATABASE DATA TYPES 	}
  SqlDChr = 1;			// character data type
  SqlDNum = 2;			// numeric data type
  SqlDDat = 3;			// date-time data type
  SqlDLon = 4;			// long data type
  SqlDDte = 5;			// date (only) data type
  SqlDTim = 6;			// time (only) data type
  SqlDHdl = 7;			// sql handle data type
  SqlDBoo = 8;			// boolean data type
  SqlDDtm = 8;			// maximum data type
	{ 	PROGRAM DATA TYPES 	}
  SqlPBuf = 1;			// buffer
  SqlPStr = 2;			// string (zero terminated)
  SqlPUch = 3;			// unsigned char
  SqlPSch = 4;			// char
  SqlPUin = 5;			// unsigned int
  SqlPSin = 6;			// int
  SqlPUlo = 7;			// unsigned long
  SqlPSlo = 8;			// long
  SqlPFlt = 9;			// float
  SqlPDou = 10;			// double
  SqlPNum = 11;			// SQLBASE internal numeric format
  SqlPDat = 12;			// SQLBASE internal datetime format
  SqlPUpd = 13;			// unsigend packed decimal
  SqlPSpd = 14;			// signed packed decimal
  SqlPDte = 15;			// date only format
  SqlPTim = 16;			// time only format
  SqlPUsh = 17;			// unsigned short
  SqlPSsh = 18;			// short
  SqlPNst = 19;			// numeric string
  SqlPNbu = 20;			// numeric buffer
  SqlPEbc = 21;			// EBCDIC buffer format
  SqlPLon = 22;			// long text string
  SqlPLbi = 23;			// long binary buffer
  SqlPLvr = 24;			// char\long varchar > 254
  SqlPDtm = 24;			// data type maximum

	{ 	EXTERNAL DATA TYPES 	}
  SqlEInt = 1;			// INTEGER
  SqlESma = 2;			// SMALLINT
  SqlEFlo = 3;			// FLOAT
  SqlEChr = 4;			// CHAR
  SqlEVar = 5;			// VARCHAR
  SqlELon = 6;			// LONGVAR
  SqlEDec = 7;			// DECIMAL
  SqlEDat = 8;			// DATE
  SqlETim = 9;			// TIME
  SqlETms = 10;			// TIMESTAMP
  SqlEMon = 11;			// MONEY
  SqlEDou = 12;			// DOUBLE
  SqlEGph = 13;			// GRAPHIC
  SqlEVgp = 14;			// VAR GRAPHIC
  SqlELgp = 15;			// LONG VAR GRAPHIC
  SqlEBin = 16;			// BINARY
  SqlEVbi = 17;			// VAR BINARY
  SqlELbi = 18;			// LONG BINARY
  SqlEBoo = 19;			// BOOLEAN
  SqlELch = 20;			// CHAR > 254
  SqlELvr = 21;			// VARCHAR > 254

	{********* 	SET and GET PARAMETER TYPES ********}

	{	Global parameters     }
	{	------------------    }
  SQLPDDB =  1;			// default database name
  SQLPDUS =  2;			// default user name
  SQLPDPW =  3;			// default password
  SQLPGBC =  4;			// global cursor value
  SQLPLRD =  5;			// local result set directory
  SQLPDBM =  6;			// db mode - see below
  SQLPDBD =  7;			// dbdir
  SQLPCPG =  8;			// code page information
  SQLPNIE =  9;			// null indicator error
  SQLPCPT = 10;			// connect pass thru to backend
  SQLPTPD = 11;			// temp dir
  SQLPDTR = 12;			// distributed transaction mode
  SQLPPSW = 15;			// server password
  SQLPOOJ = 16;			// oracle outer join
  SQLPNPF = 17;			// net prefix
  SQLPNLG = 18;			// net log
  SQLPNCT = 19;			// net check type
  SQLPNCK = 20;			// net check
  SQLPLCK = 22;			// locks
  SQLPINT = 25;			// interrupt
  SQLPERF = 27;			//  error file
  SQLPDIO = 28;			//  direct I/O
  SQLPSWR = 29;			//  default write
  SQLPCTY = 31;			//  country
  SQLPCSD = 32;			//  commit server daemon
  SQLPCSR = 33;			//  commit server
  SQLPCCK = 36;			//  client check
  SQLPCTS = 37;			//  characterset
  SQLPCGR = 38;			//  cache group
  SQLPAIO = 39;			//  asyncio
  SQLPANL = 40;			//  apply net log
  SQLPGRS = 41;			//  get reentracy state
  SQLPSTF = 42;			//  set SQLTrace flags
  SQLPCLG = 43;			//  set commit-order logging

	{	Server specific parameters      }
	{	--------------------------      }
  SQLPHEP = 1001;		// HEAP size for TSR executables
  SQLPCAC = 1002;		// CACHE size in Kbytes
  SQLPBRN = 1003;		// brand of database
  SQLPVER = 1004;		// release version (ex. "4.0.J")
  SQLPPRF = 1005;		// server profiling
  SQLPPDB = 1006;		// partitioned database
  SQLPGCM = 1007;		// group commit count
  SQLPGCD = 1008;		// group commit delay ticks
  SQLPDLK = 1009;		// number of deadlocks
  SQLPCTL = 1010;		// command time limit
  SQLPAPT = 1011;		// process timer activated
  SQLPOSR = 1012;		// OS sample rate
  SQLPAWS = 1013;		// OS Averaging window size
  SQLPWKL = 1014;		// Work Limit
  SQLPWKA = 1015;		// Work Space allocation
  SQLPUSR = 1016;		// Number of users
  SQLPTMO = 1017;		// time out
  SQLPTSS = 1018;		// thread stack size
  SQLPTHM = 1019;		// thread mode
  SQLPSTC = 1020;		// sortcache size in kilobytes
  SQLPSIL = 1021;		// silent mode
  SQLPSPF = 1022;		// server prefix
  SQLPSVN = 1024;		// server name
  SQLPROM = 1025;		// read-only mode (0 or 1)
  SQLPSTA = 1026;		// enable stats gathering
  SQLPCSV = 1027;		// commit server
  SQLPTTP = 1028;		// trace for 2PC

	{	Database specific parameters	}
	{	----------------------------    }
  SQLPDBN = 2001;		// database name
  SQLPDDR = 2002;		// database directory
  SQLPLDR = 2003;		// log directory
  SQLPLFS = 2004;		// log file size in Kbytes
  SQLPCTI = 2005;		// checkpoint time interval in mins
  SQLPLBM = 2006;		// log backup mode? (0 or 1)
  SQLPPLF = 2007;		// Pre-allocate log files? (0 or 1)
  SQLPTSL = 2008;		// transaction span limit
  SQLPROT = 2009;		// read-only transactions (0, 1, 2)
  SQLPHFS = 2010;		// history file size in Kbytes
  SQLPREC = 2011;		// recovery
  SQLPEXE = 2012;		// name of executable
  SQLPNLB = 2013;		// next log to backup
  SQLPROD = 2014;		// read-only database (0 or 1)
  SQLPEXS = 2015;		// database file extension size
  SQLPPAR = 2016;		// partitioned database (0 or 1)
  SQLPNDB = 2017;		// NEWDB
  SQLPLGF = 2018;		// log file offset
  SQLPDTL = 2019;		// command timelimit
  SQLPSMN = 2020;		// show main db
  SQLPCVC = 2021;		// catalog version counter
  SQLPDBS = 2022;		// database block size
  SQLPUED = 2023;		// update external dictionary

	{	Cursor specific parameters     	}
	{	--------------------------      }
  SQLPISO = 3001;		// isolation level (SQLILRR etc..)
  SQLPWTO = 3002;		// lock wait timeout in seconds
  SQLPPCX = 3003;		// preserve context (0 or 1)
  SQLPFRS = 3004;		// front end result sets
  SQLPLDV = 3005;		// load version (ex. "3.6.22")
  SQLPAUT = 3006;		// autocommit
  SQLPRTO = 3007;		// rollback trans on lock timeout
  SQLPSCR = 3008;		// scroll mode (0 or 1)
  SQLPRES = 3009;		// restriction mode (0 or 1)
  SQLPFT  = 3010;		// fetch through
  SQLPNPB = 3011;		// no pre-build in RL mode
  SQLPPWD = 3012;		// current password
  SQLPDB2 = 3013;		// DB2 compatibility mode
  SQLPREF = 3014;		// referential integrity checking
  SQLPBLK = 3015;		// bulk-execute mode
  SQLPOBL = 3016;		// optimized bulk-execute mode
  SQLPLFF = 3017;		// LONG data allowed in FERS
  SQLPDIS = 3018;		// When to return Describe info
  SQLPCMP = 3019;		// Compress messages sent to server
  SQLPCHS = 3020;		// chained cmd has SELECT (0 or 1)
  SQLPOPL = 3021;		// optimizer level
  SQLPRID = 3022;		// ROWID
  SQLPEMT = 3023;		// Error Message Tokens
  SQLPCLN = 3024;		// client name
  SQLPLSS = 3025;		// last compiled SQL statement
  SQLPEXP = 3026;		// explain query plan
  SQLPCXP = 3027;		// cost of execution plan
  SQLPOCL = 3028;		// optimizercostlevel
  SQLPTST = 3029;		// distributed transaction status
  SQLP2PP = 3030;		// 2-phase protocol (SQL2STD, etc.)
	{	defined for Load/Unload parsed parameters - cursor specific	}
  SQLPCLI = 3031;		// ON CLIENT option
  SQLPFNM = 3032;		// load/unload file name
  SQLPOVR = 3033;		// file OVERWRITE flag
  SQLPTFN = 3034;		// A Temporary file name
  SQLPTRC = 3035;		// Trace stored procedures
  SQLPTRF = 3036;		// Tracefile for stored procedures
  SQLPCTF = 3037;		// control file flag

  SQLPMID = 3038;		// mail id
  SQLPAID = 3039;		// adapter id
  SQLPNID = 3040;		// network id
  SQLPUID = 3041;		// user application id
  SQLPCIS = 3042;		// client identification strings
  SQLPIMB = 3043;		// input message buffer size
  SQLPOMB = 3044;		// output message buffer size
  SQLPWFC = 3045;		// which fetchable command
  SQLPRFE = 3046;		// Return on First Error-bulk insert
  SQLPCUN = 3047;		// Current cursor user name
  SQLPOFF = 3048;		// Optimize First Fetch

	{	Static attributes               }
	{	--------------------------      }
  SQLPFAT = 4000;		// first attribute
  SQLPBRS = 4001;		// back end result sets
  SQLPMUL = 4002;		// multi-user
  SQLPDMO = 4003;		// demonstration version
  SQLPLOC = 4004;		// local version of database
  SQLPFPT = 4005;		// 1st participant
  SQLPLAT = 4006;		// last attribute
  SQLPCAP = 4007;		// API capability level
  SQLPSCL = 4008;		// server capability level
  SQLPRUN = 4009;		// runtime version

	{	Server specific parameters      }
	{	----------------------------    }
  SQLPPLV = 5001;		// print level
  SQLPALG = 5002;		// activity log
  SQLPTMS = 5003;		// time stamp
  SQLPPTH = 5004;		// path name seperator
  SQLPTMZ = 5005;		// time zone
  SQLPTCO = 5006;		// time colon only		    


	{ 	defines for database brands 	}
  SQLBSQB =  1;			// SQLBASE
  SQLBDB2 =  2;			// DB2
  SQLBDBM =  3;			// IBM OS/2 Database Manager
  SQLBORA =  4;			// Oracle
  SQLBIGW =  5;			// Informix
  SQLBNTW =  6;			// Netware SQL
  SQLBAS4 =  7;			// IBM AS/400 SQL/400
  SQLBSYB =  8;			// Sybase SQL Server
  SQLBDBC =  9;			// Teradata DBC Machines
  SQLBALB = 10;			// HP Allbase
  SQLBRDB = 11;			// DEC's RDB
  SQLBTDM = 12;			// Tandem's Nonstop SQL
  SQLBSDS = 13;			// IBM SQL/DS
  SQLBSES = 14;			// SNI SESAM
  SQLBING = 15;			// Ingres
  SQLBSQL = 16;			// SQL Access
  SQLBDBA = 17;			// DBase
  SQLBDB4 = 18;			// SNI DDB4
  SQLBFUJ = 19;			// Fujitsu RDBII
  SQLBSUP = 20;			// Cincom SUPRA
  SQLB204 = 21;			// CCA Model 204
  SQLBDAL = 22;			// Apple DAL interface
  SQLBSHR = 23;			// Teradata ShareBase
  SQLBIOL = 24;			// Informix On-Line
  SQLBEDA = 25;			// EDA/SQL
  SQLBUDS = 26;			// SNI UDS
  SQLBMIM = 27;			// Nocom Mimer
  SQLBOR7 = 28;			// Oracle version 7
  SQLBIOS = 29;			// Ingres OpenSQL
  SQLBIOD = 30;			// Ingres OpenSQL with date support
  SQLBODB = 31;			// ODBC Router
  SQLBS10 = 32;			// SYBASE System 10
  SQLBSE6 = 33;			// Informix SE version 6
  SQLBOL6 = 34;			// Informix On-Line version 6
  SQLBNSE = 35;			// Informix SE NLS version 6
  SQLBNOL = 36;			// Informix On-Line NLS version 6
  SQLBAPP = 99;			// SQLHost App Services

	{ 	SIZES 	}
  SqlSNum =  12;		// numeric program buffer size
  SqlSDat = SQLSNUM;		// date-time program buffer size
  SqlSCda =  26;		// character date-time size
  SqlSDte = SQLSDAT;		// date (only) program buffer size
  SqlSCde =  10;		// character date (only) size
  SqlSRid =  40;		// size of ROWID
  SqlSTim = SQLSDAT;		// time (only) program buffer size
  SqlSCti =  15;		// character time (only) size
  SqlSFem = 100;		// file extension size (multi-user)
  SqlSFes =  20; 		// file extension size (single-user)
  SqlSTex =   5;		// table extent size		    


	{ 	NULL POINTER 	}
  SQLNPTR = nil;                //  (ubyte1 PTR)0 - null pointer

	{ 	RESULT COMMAND TYPES 	}
  SqlTSEL = 1;			// select
  SqlTINS = 2;			// insert
  SqlTCTB = 3;			// create table
  SqlTUPD = 4;			// update
  SqlTDEL = 5;			// delete
  SqlTCIN = 6;			// create index
  SqlTDIN = 7;			// drop index
  SqlTDTB = 8;			// drop table
  SqlTCMT = 9;			// commit
  SqlTRBK = 10;			// rollback
  SqlTACO = 11;			// add column
  SqlTDCO = 12;			// drop column
  SqlTRTB = 13;			// rename table
  SqlTRCO = 14;			// rename column
  SqlTMCO = 15;			// modify column
  SqlTGRP = 16;			// grant privilege on table
  SqlTGRD = 17;			// grant dba
  SqlTGRC = 18;			// grant connect
  SqlTGRR = 19;			// grant resource
  SqlTREP = 20;			// revoke privilege on table
  SqlTRED = 21;			// revoke dba
  SqlTREC = 22;			// revoke connect
  SqlTRER = 23;			// revoke resource
  SqlTCOM = 24;			// comment on
  SqlTWAI = 25;			// wait
  SqlTPOS = 26;			// post
  SqlTCSY = 27;			// create synonym
  SqlTDSY = 28;			// drop synonym
  SqlTCVW = 29;			// create view
  SqlTDVW = 30;			// drop view
  SqlTRCT = 31;			// row count
  SqlTAPW = 32;			// alter password
  SqlTLAB = 33;			// label on
  SqlTCHN = 34;			// chained command
  SqlTRPT = 35;			// repair table
  SqlTSVP = 36;			// savepoint
  SqlTRBS = 37;			// rollback to savepoint
  SqlTUDS = 38;			// update statistics
  SqlTCDB = 39;			// check database
  SqlTFRN = 40;			// foreign DBMS commands
  SqlTAPK = 41;			// add primary key
  SqlTAFK = 42;			// add foreign key
  SqlTDPK = 43;			// drop primary key
  SqlTDFK = 44;			// drop foreign key

	{ 	SERVER COMMAND TYPES 		}
  SqlTCDA = 45;			// create dbarea
  SqlTADA = 46;			// alter  dbarea
  SqlTDDA = 47;			// delete dbarea
  SqlTCSG = 48;			// create stogroup
  SqlTASG = 49;			// alter  stogroup
  SqlTDSG = 50;			// delete stogroup
  SqlTCRD = 51;			// create database
  SqlTADB = 52;			// alter  database
  SqlTDDB = 53;			// delete database
  SqlTSDS = 54;			// set default stogroup
  SqlTIND = 55;			// install database
  SqlTDED = 56;			// de-install database
	{ 	END OF SERVER COMMAND TYPES 	}

  SqlTARU = 57;			// add RI user error
  SqlTDRU = 58;			// drop RI user error
  SqlTMRU = 59;			// modify RI user error
  SqlTSCL = 60;			// set client
  SqlTCKT = 61;			// check table
  SqlTCKI = 62;			// check index
  SqlTOPL = 63;			// PL/Sql Stored Procedure
  SqlTBGT = 64;			// BEGIN TRANSACTION
  SqlTPRT = 65;			// PREPARE TRANSACTION
  SqlTCXN = 66;			// COMMIT TRANSACTION
  SqlTRXN = 67;			// ROLLBACK TRANSACTION
  SqlTENT = 68;			// END TRANSACTION

	{ 	COMMIT SERVER COMMAND TYPES 	}
  SqlTCBT = 69;			// begin transaction
  SqlTCCT = 70;			// commit transaction
  SqlTCET = 71;			// end	 transaction
  SqlTCPT = 72;			// prepare transaction
  SqlTCRT = 73;			// rollback transaction
  SqlTCST = 74;			// status transaction
  SqlTCRX = 75;			// reduce transaction
  SqlTCSD = 76;			// start daemon
  SqlTCTD = 77;			// stop daemon
  SqlTCRA = 78;			// resolve all transactions
  SqlTCRO = 79;			// resolve one transaction
  SqlTCOT = 80;			// orphan a transaction
  SqlTCFL = 81;			// CREATE FAILURE
  SqlTDFL = 82;			// DELETE FAILURE
  SqlTSTN = 83;			// SET TRACETWOPC ON
  SqlTSTF = 84;			// SET TRACETWOPC OFF
  SqlTUNL = 85;			// Unload command
  SqlTLDP = 86;			// load command
  SqlTPRO = 87;			// stored procedure
  SqlTGEP = 88;			// grant  execute privilege
  SqlTREE = 89;			// revoke execute privilege
  SqlTTGC = 90;			// create trigger
  SqlTTGD = 91;			// drop trigger
  SqlTVNC = 92;			// create event
  SqlTVND = 93;			// drop event
  SqlTSTR = 94;			// start audit
  SqlTAUD = 95;			// audit message
  SqlTSTP = 96;			// stop audit
  SqlTACM = 97;			// Alter CoMmand
  SqlTXDL = 98;			// lock database
  SqlTXDU = 99;			// unlock database

	{ 	defines for isolation level string 	}
  SQLILRR = 'RR';		// Repeatable Read isolation
  SQLILCS = 'CS';		// Cursor Stability isolation
  SQLILRO = 'RO';		// Read-Only isolation
  SQLILRL = 'RL';		// Release Locks isolation
	{ 	defines for isolation level flags	}
  SQLFIRR = $01;		// Repeatable Read isolation flag
  SQLFICS = $02;		// Cursor Stability isolation flag
  SQLFIRO = $04;		// Read-Only isolation flag
  SQLFIRL = $08;		// Release Locks isolation flag
	{ 	defines for SQLROF rollforward mode parameter		}
  SQLMEOL = 1;			// rollforward to end of log
  SQLMEOB = 2;			// rollforward to end of backup
  SQLMTIM = 3;			// rollforward to specified time
	{	defines for when to collect Describe information	}
  SQLDELY = 0;			// get Describe info after sqlcom
  SQLDDLD = 1;			// get Describe info after sqlexe
  SQLDNVR = 2;			// never get any Describe info
	{	defines for SQLETX() and SQLTEM(): error text type parameters	}
  SQLXMSG = 1;			// retrieve error message text
  SQLXREA = 2;			// retrieve error message reason
  SQLXREM = 4;			// retrieve error message remedy
	{	defines for extended directory open function		}
  SQLANRM = $00;		// normal - no restrictions
  SQLARDO = $01;		// read only
  SQLAHDN = $02;		// hidden file
  SQLASYS = $04;		// system file
  SQLAVOL = $08;		// volume label
  SQLADIR = $10;		// directory
  SQLAARC = $20;		// archive bit
  SQLAFDL = $100;		// files and directories
	{	defines for state of cursor 		}
  SQLCIDL = 0;	 		// idle cursor
  SQLCECM = 1;	 		// executing compile
  SQLCCCM = 2;	 		// completed compile
  SQLCEXE = 3;	 		// executing command
  SQLCCXE = 4;	 		// completed command
  SQLCEFT = 5;	 		// executing fetch
  SQLCCFT = 6;	 		// completed fetch

	{ 	MAXIMUM SIZES 	}
  SQLMBNL = 18;			// bind name length
  SQLMBSL = 32000;		// max length Backend string literal
  SQLMCG1 = 32767;		// cache group pages
  SQLMCKF = 16;			// concatenated key fields
  SQLMCLL = 255; 		// clientlimit
  SQLMCLN = 12;			// maximum client name size
  SQLMCLP = 128; 		// commmand line parameter length
  SQLMCMT = 99;			// max command types
  SQLMCNM = 18;			// max referential constraint name
  SQLMCOH = 255; 		// column heading string
  SQLMCST = 400; 		// max connect string length
  SQLMDBA = 10;			// number of databases accessed
  SQLMDFN = 25;			// database file name
  SQLMPSS = 25;			// process status string
  SQLMDMO = 750; 		// maximum DB size for demos (Kbytes)
  SQLMDNM = 8;			// database name
  SQLMDVL = 254; 		// data value length
  SQLMERR = 255; 		// error message length
  SQLMETX = 3000;		// error text length
  SQLMFNL = 128; 		// filename length
  SQLMFQN = 3;			// number of fields in fully qualified column name
  SQLMFRD = 40;			// maximum size of foreign result set directory
  SQLMGCM = 32767;		// maximum group commit count
  SQLMICO = 255; 		// installed cache page owners
  SQLMICU = 255; 		// installed cursors
  SQLMIDB = 255; 		// installed databases
  SQLMILK = 32767;		// installed locks
  SQLMINL = 2000;		// input length
  SQLMIPG = 32767;		// installed pages
  SQLMIPR = 800; 		// installed processes
  SQLMITR = 800; 		// installed transactions
  SQLMJTB = 17;			// joined tables
  SQLMLID = 32;			// long identifiers
  SQLMNBF = 60000;		// network buffer size
  SQLMNCO = 254; 		// number of columns per row
  SQLMUCO = 253; 		// number of user columns available
  SQLMNPF = 3;			// NETPREFIX size
  SQLMOUL = 1000;		// output length
  SQLMPAL = 255; 		// max path string length
  SQLMPFS = 21;			// max platform string length
  SQLMPRE = 15;			// maximum decimal precision
  SQLMPTL = 4;			// maximum print level
  SQLMPWD = 128; 		// maximum password length
  SQLMCTL = 43200;		// max query timelimit (12 hours)
  SQLMRBB = 8192;		// maximum rollback log buffer
  SQLMRCB = 20480;		// maximum recovery log buffer
  SQLMRET = 1000;		// retry count
  SQLMRFH = 4;			// maximum # remote file handles
  SQLMROB = 8192;		// max size of restore output buffer
  SQLMSES = 16;			// number of sessions
  SQLMSID = 8;			// short identifiers
  SQLMSLI = 255; 		// max number of select list exprs.
  SQLMSNM = 8;			// server name
  SQLMSRL = 32;			// max length of SQL reserved word
  SQLMSVN = 199; 		// maximum server names
  SQLMTFS = 10;			// maximum temporary file size
  SQLMTMO = 200; 		// maximum timeout
  SQLMTSS = 256; 		// text string space size
  SQLMUSR = 128; 		// maximum username length
  SQLMVER = 8;			// max version string (nn.nn.nn)
  SQLMXER = 255; 		// Extended error message length
  SQLMXLF = 4194304;		// max log file size
  SQLMTHM = 2;			// maximum thread mode value
  SQLMPKL = 254; 		// max primary key length
  SQLMGTI = 250; 		// max global transaction-id length
  SQLMAUF = 32;			// max concurrent audit files
  SQLMPNM = 8;			// max protocol name length
  SQLMOSR = 255; 		// max OS sample rate
  SQLMAWS = 255; 		// max OS Averaging window size
  SQLMMID = 32;			// max length identificatin strings

	{ 	MINIMUMS 	}
  SQLMCG0 = 1;			// cache group pages
  SQLMEXS = 1024;		// partitioned file extension size
  SQLMLFE = 100000;		// minimum log file extension size
  SQLMLFS = 100000;		// minimum log file size
  SQLMPAG = 15;			// minimum pages (cache)
  SQLMITM = 1;			// minimum thread mode value


type
  byte1		= ShortInt;
  ubyte1	= Byte;
  byte2		= SmallInt;
  ubyte2	= Word;
  byte4		= LongInt;
  ubyte4	= LongInt;

  ubyte1p	= TSDPtr;

  SqlTApi = Word;
  SqlTPfp = TFarProc;

  SqlTARC = ubyte1;		// remote connection architecture
  SqlTBNL = ubyte1;		// bind name length
  SqlTBNN = ubyte1;		// bind number
  SqlTBNP = ubyte1p;		// bind name pointer
  SqlTNUL = byte2;		// null indicator
  SqlTBOO = ubyte1;		// boolean data type
  SqlTCDL = ubyte1;		// column data length
  SqlTCHL = ubyte1;		// column header length
  SqlTCHO = ubyte1;		// check option
  SqlTCHP = ubyte1p;		// column header pointer
  SqlTCLL = ubyte2;		// column data length(long)
  SqlTCTY = ubyte1;		// command type
  SqlTCUR = ubyte2;		// cursor number
  SqlTDAL = ubyte2;		// data length
  SqlTDAP = ubyte1p;		// data pointer
  SqlTDAY = byte2;		// number of days
  SqlTDDL = ubyte1;		// database data length
  SqlTDDT = ubyte1;		// database data type
  SqlTDEDL = ubyte2;		// database extended data length
  SqlTDPT = ubyte2;		// database parameter type
  SqlTDPV = ubyte4;		// database parameter value ??????
  SqlTEPO = ubyte2;		// error position
  SqlTFAT = ubyte2;		// file attribute
  SqlTFLD = ubyte2;		// SELECT statement field number
  SqlTFLG = ubyte2;		// flag field
  SqlTFLH = ubyte4;		// file handle	UINT32	????????
  SqlTFMD = byte2;		// file mode
  SqlTFNL = ubyte2;		// file name length
  SqlTFNP = ubyte1p;		// file name pointer
  SqlTFSC = ubyte1;		// fetch status code
  SqlTILV = ubyte1p;		// isolation level string
  SqlTLBL = ubyte1;		// label information length
  SqlTLBP = ubyte1p;		// label infromation pointer
  SqlTLNG = byte4;		// long size
  SqlTLSI = ubyte4;		// unsigned long size	????????
  SqlTMSZ = ubyte2;		// message size
  SqlTNBV = ubyte1;		// number of bind variables
  SqlTNCU = ubyte2;		// number of cursors
  SqlTNML = ubyte1;		// number length
  SqlTNMP = ubyte1p;		// number pointer
  SqlTNPG = ubyte2;		// number of pages
  SqlTNSI = ubyte1;		// number of select items
  SqlTPCX = ubyte1;		// preserve context flag
  SqlTPDL = ubyte1;		// program data length
  SqlTPDT = ubyte1;		// program data type
  SqlTPGN = ubyte4;		// page number
  SqlTPNM = ubyte2;		// process number
  SqlTPRE = ubyte1;		// precision
  SqlTPTY = ubyte2;		// set/get parameter type
  SqlTRBF = ubyte1;		// roll back flag
  SqlTRCD = byte2;		// return codes
  SqlTRCF = ubyte1;		// recovery flag
  SqlTRFM = ubyte2;		// rollforward mode
  SqlTROW = byte4;		// number of rows
  SqlTSCA = ubyte1;		// scale
  SqlTSLC = ubyte1;		// select list column
  SqlTSTC = ubyte2;		// statistics counter
  SqlTSVH = ubyte2;		// server handle
  SqlTSVN = ubyte2;		// server number
  SqlTTIV = byte2;		// wait timeout value
  SqlTWNC = byte2;		// whence
  SqlTWSI = ubyte2;		// work size
  SqlTBIR = ubyte2;		// bulk insert error row number
  SqlTDIS = ubyte1p;		// Describe info indicator
  SqlTXER = byte4;		// extended error #
  SqlTPID = ubyte4;		// client process id
  SQLTMOD = ubyte4;		// mode flag		SQLBase 7
  SQLTCON = ubyte4;		// connection handle	SQLBase 7

{
DESCRIPTION:
  This structure is used as a parameter to the SQLGDI function.  After a
  a compile, all relevant information for a given Select column can be
  obtained in this structure.
  Note:
     Please note that, originally, gdichb was the first element of the
     gdidefx structure.  It has been moved further down because a column
     heading can be greater than 31 bytes.  A bug was reported complaining
     that the column heading was not being returned correctly since the
     maximum length of a column heading is 46. This can now be returned
     since the size of the buffer (gdichb) has been changed to 47.
     Also, the length field (gdichl) has also been moved down to go with
     the column heading buffer (gdichb).
     The original gdichb and gdichl fields have been renamed to gdifl1 and
     gdifl2.
}
{$IFNDEF XSQL_CLR}
  TGdiDefx	= record
    gdifl1: array[0..30] of Char;		// filler reserved for future use   */
    gdifl2: ubyte1;				// filler reserved for future use
    gdilbb: array[0..30] of Char;		// label buffer
    gdilbl: SQLTLBL;				// label info length
    gdicol: SQLTSLC;				// select column number
    gdiddt: SQLTDDT;				// database data type
    gdiddl: SQLTDEDL;				// database extended data length
    gdiedt: SQLTDDT;				// external data type
    gdiedl: SQLTDEDL;				// external extended data length
    gdipre: SQLTPRE;				// decimal precision
    gdisca: SQLTSCA;				// decimal scale
    gdinul: byte2;				// null indicator
    gdichb: array[0..46] of Char;		// column heading buffer
    gdichl: SQLTCHL;				// column heading length
    gdifil: array[0..1] of byte1;		// for future use
  end;
  TGdiDef	= TGdiDefx;
  SQLTGDI	= TGdiDefx;
  SQLPGD	= ^TGdiDefx;
{$ENDIF}

type
  SqlTBirPtr	= ^SqlTBir;
  SqlTCdlPtr	= ^SqlTCdl;
  SqlTChlPtr	= ^SqlTChl;
  SqlTCurPtr	= ^SqlTCur;
  SqlTDalPtr	= ^SqlTDal;
  SqlTDdlPtr	= ^SqlTDdl;
  SqlTDdtPtr	= ^SqlTDdt;
  SqlTFlhPtr    = ^SqlTFlh;
  SqlTFscPtr	= ^SqlTFsc;
  SqlTLngPtr	= ^SqlTLng;
  SQLTLSIPtr	= ^SQLTLSI;
  SqlTNbvPtr 	= ^SqlTNbv;
  SqlTNmlPtr	= ^SqlTNml;
  SqlTNsiPtr  	= ^SqlTNsi;
  SqlTPnmPtr	= ^SqlTPnm;
  SqlTPrePtr	= ^SqlTPre;
  SqlTRowPtr	= ^SqlTRow;
  SqlTRbfPtr	= ^SqlTRbf;
  SqlTRcdPtr	= ^SqlTRcd;
  SqlTScaPtr	= ^SqlTSca;
  SqlTXerPtr	= ^SqlTXer;


{*******************************************************************************
  INTERFACE TO SQL SRV EXTENDED INFORMATION from GSIEXT.H

  08/02/95 GTI release 6.1.0
DESCRIPTION
  This file contains structure	definitions  and  defined  constants  used  to
  interface with a SQLBASE SERVER and return extended GSI information.
********************************************************************************}

const
  SQLGLCK = $40;		// lock information
  SQLGOSS = $80;		// OS stats information

  	{	information filter flags            }
  SQLRPNM = $0100;		// process number
  SQLRCLN = $0200;		// client name
  SQLRUSN = $0400;		// user name
  SQLRDBN = $0800;		// database name

  SQLXGSI = $8000;		// extended GSI information flag

type
	{ 	extended cursor information	}
  TCurDefxi = record
    curcst	:ubyte4;		// cost of execution plan
    curctp	:ubyte4;		// time for prepare
    curcte	:ubyte4;		// time for execute
    curctf	:ubyte4;		// time for fetch
    curcur	:ubyte2;		// internal cursor number
    curcln	:array[0..12] of Char;	// client name
    cursta	:ubyte1;		// cursor status
    curcts	:array[0..17] of Char;	// cursor time stamp
    currsv	:array[0..1] of Char;	// reserved
  end;
  TCurDefi = TCurDefxi;
  PCurDefi = ^TCurDefi;

	{	configuration information 	}
  TCfgDefxi = record
    cfgcmt :array[0..59] of ubyte4;	// command type counters
    cfgcon :ubyte4;			// total system connects
    cfgdis :ubyte4;			// total system disconnects
    cfgtps :ubyte4;			// number of transactions
    cfgelp :ubyte4;			// number of exclusive locks
    cfgslp :ubyte4;			// number of shared locks
    cfgulp :ubyte4;			// number of update locks
    cfgdlk :ubyte4;			// number of deadlocks
    cfgsrt :ubyte4;			// number of sorts
    cfghjn :ubyte4;			// number of hashed joins
    cfgctp :ubyte4;			// time for prepare
    cfgcte :ubyte4;			// time for execute
    cfgctf :ubyte4;			// time for fetch
    cfgsbt :array[0..25] of Char; 	// time of SQLBase boot
    cfgpfs :array[0..20] of Char; 	// platform version string
    cfgver :array[0..19] of Char; 	// SQLBase version
    cfgonl :ubyte1;			// online/offline
    cfgszp :ubyte4;			// Database Page size on server
  end;
  TCfgDefi = TCfgDefxi;
  PCfgDefi = ^TCfgDefi;

	{	process information 	}
  TPrcDefxi = record
     prcsel :ubyte4;			// number of selects
     prcins :ubyte4;			// number of inserts
     prcupd :ubyte4;			// number of updates
     prcdel :ubyte4;			// number of deletes
     prctps :ubyte4;			// number of transactions
     prcdlk :ubyte4;			// number of deadlocks
     prcelp :ubyte4;			// number of exclusive locks
     prcslp :ubyte4;			// number of shared locks
     prculp :ubyte4;			// number of update locks
     prcast :ubyte4;			// accumulative system time
     prcptp :ubyte4;			// time for prepare
     prcpte :ubyte4;			// time for execute
     prcptf :ubyte4;			// time for fetch
     prcmtt :ubyte4;			// maximum transaction time
     prcpss :array[0..25] of Char; 	// status string
     prccln :array[0..12] of Char; 	// client name
     prcsta :ubyte1;			// status flag
     prcpts :array[0..19] of Char; 	// process time stamp
     prciso :ubyte1;			// isolation level flags
     prctmo :ubyte4;			// number of timeouts
     prcrsv :array[0..26] of Char; 	// reserved
  end;
  TPrcDefi = TPrcDefxi;
  PPrcDefi = ^TPrcDefi;

	{ 	database information 	}
  TDbsDefxi = record
    dbspnm :array[0..6,0..8] of Char;	// protocol name
    dbsshd :ubyte1;		 	// shutdown
    dbslck :ubyte1;		 	// locked/unlocked
    dbsrsv :array[0..62] of Char;  	// reserved
  end;
  TDbsDefi = TDbsDefxi;
  PDbsDefi = ^TDbsDefi;

	{ 	lock information 	}
  TLckDefx = record
    lckdbs :array[0..8] of Char;	// database file name
    lckpnm :ubyte1;		 	// process number
    lcklpg :ubyte2;		 	// low  page
    lckhpg :ubyte2;		 	// high page
    lckgrp :ubyte4;		 	// lock group
    lckmod :ubyte1;		 	// lock mode
    lckuse :ubyte1;		 	// lock use count
  end;
  TLckDef = TLckDefx;
  PLckDef = ^TLckDef;

	{	filter structure 	}
  TFgiDefx = record
    fgipnm :ubyte1; 		 	// process number
    fgicln :array[0..12] of Char;	// client name
    fgiunb :array[0..18] of Char;	// user name buffer
    fgidbn :array[0..8] of Char;	// database name buffer
  end;
  TFgiDef = TFgiDefx;
  PFgiDef = ^TFgiDef;

	{ 	OS stats information 	}
  TOStDefx = record
    ostsar :ubyte1;			// sample rate
    ostaws :ubyte1;		 	// averaging window size

    ostcpu :ubyte1;		 	// CPU % Utilization
    ostacp :ubyte1;		 	// Average CPU % Utilization
    ostpac :ubyte1;		 	// Peak Average CPU % Utilization

    ostmpa :ubyte4;		 	// Physical memory available
    ostmvt :ubyte4;		 	// Total virtual memory
    ostmst :ubyte4;		 	// Short term memory available
    ostmlt :ubyte4;		 	// Long term memory available

    ostdpr :ubyte4;		 	// disk I/O physical reads
    ostdpw :ubyte4;		 	// disk I/O physical writes
    ostbpr :ubyte4;		 	// disk I/O physical bytes read
    ostbpw :ubyte4;		 	// disk I/O physical bytes write
    ostdvr :ubyte4;		 	// disk I/O virtual  reads
    ostdvw :ubyte4;		 	// disk I/O virtual  writes
    ostbvr :ubyte4;		 	// disk I/O virtual  bytes read
    ostbvw :ubyte4;		 	// disk I/O virtual  bytes write

    ostnpt :ubyte4;		 	// Network I/O packets transmitted
    ostnpr :ubyte4;		 	// Network I/O packets received
    ostprt :ubyte4;		 	// Network I/O packets routed
    ostrsv :array[0..2] of Char; 	// reserved
  end;
  TOStDef = TOStDefx;
  POStDef = ^TOStDef;

{*******************************************************************************
	INTERFACE TO SQL SRV from SQLSRV.H

REVISION HISTORY
  08/02/95 GTI release 6.1.0
DESCRIPTION
  This file contains structure	definitions  and  defined  constants  used  to
  interface with a SQLBASE SERVER.
********************************************************************************}

const
	{ 	server remote procedure call open file flags	}
  SQLORDONLY	= $0000;		// open for reading only
  SQLOWRONLY	= $0001;		// open for writing only
  SQLORDWR	= $0002;		// open for reading and writing
  SQLOAPPEND	= $0008;		// writes done at eof
  SQLOCREAT	= $0100;		// create and open file
  SQLOTRUNC	= $0200;		// open and truncate
  SQLOEXCL	= $0400;		// open if file doesn't exist
  SQLODIRCREA	= $0800;		// create directory if doesn't exist
  SQLOTEXT	= $4000;		// file mode is text
  SQLOBINARY	= $8000;		// file mode is binary

	{ 	server information flags 	}
  SQLGPWD	= $01;		// send password
  SQLGCUR	= $02;		// cursor information
  SQLGDBS  	= $04;		// database information
  SQLGCFG  	= $08;		// configuration information
  SQLGSTT  	= $10;		// statistics
  SQLGPRC  	= $20;		// process information

type
	{ 	message header 		}
  THdrDefx = record
    hdrlen :ubyte2;		// message length (including hdr)
    hdrrsv :ubyte2;		// reserved
  end;
  THdrDef = THdrDefx;
  PHdrDef = ^THdrDef;

	{ 	message section header 	}
  TMshDefx = record
    mshflg :ubyte2;		// section data type
    mshten :ubyte2;		// total # of entries available
    mshnen :ubyte2;		// # of entries contained in msg
    mshlen :ubyte2;		// # of data bytes in msg section
     				// (including this header)
  end;
  TMshDef = TMshDefx;
  PMshDef = ^TMshDef;

	{ 	cursor information	}
  TCurDefx = record
    currow :ubyte4;			// number of rows
    curibl :ubyte2;			// input buffer
    curobl :ubyte2;			// output message buffer length
    curspr :ubyte2;			// stat counter, physical reads
    curspw :ubyte2;			// stat counter, physical writes
    cursvr :ubyte2;			// stat counter, virtual reads
    cursvw :ubyte2;			// stat counter, virtual writes
    curtyp :ubyte1;			// command type
    curpnm :ubyte1;			// process number
    curiso :array[0..2] of Char; 	// locking isolation
    curunb :array[0..18] of Char;	// user name buffer
    curdbn :array[0..8] of Char;	// database name
    currsv :array[0..2] of Char;	// reserved
  end;
  TCurDef = TCurDefx;
  PCurDef = ^TCurDef;

	{ 	database information 	}
  TDbsDefx = record
    dbsbfs :ubyte4;			// before image file size
    dbsbwp :ubyte4;			// before image write page
    dbsdfs :ubyte4;			// database file size
    dbsfrp :ubyte4;			// 1st reader page in circular log
    dbsfup :ubyte4;			// 1st updater page in circular log
    dbslpa :ubyte4;			// last page allocated
    dbslpm :ubyte4;			// log page maximum
    dbslpt :ubyte4;			// log page threshold
    dbslpw :ubyte4;			// last page written
    dbsltp :ubyte4;			// last temporary page accessed
    dbsltw :ubyte4;			// last temporary page written
    dbsuse :ubyte1;			// use count
    dbsnat :ubyte1;			// number of active transactions
    dbsntr :ubyte1;			// number of transactions
    dbsfnm :array[0..8] of Char;	// database file name
  end;
  TDbsDef = TDbsDefx;
  PDbsDef = ^TDbsDef;

	{ 	configuration information 	}
  TCfgDefx = record
    cfgwsa :ubyte4;			// work space allocation size
    cfgwsl :ubyte4;			// work space limit
    cfgnlk :ubyte2;			// number of locks
    cfgnpg :ubyte2;			// number of pages
    cfgcnc :ubyte2;			// connect count
    cfgsvn :array[0..8] of Char;	// server name
    cfgrsv :ubyte1;			// reserved
  end;
  TCfgDef = TCfgDefx;
  PCfgDef = ^TCfgDef;

	{ 	statistics 	}
  TSttDefx = record
    sttspr :ubyte4;		// physical reads
    sttspw :ubyte4;		// physical writes
    sttsvr :ubyte4;		// virtual reads
    sttsvw :ubyte4;		// virtual writes
    sttnps :ubyte4;		// number of process switches
  end;
  TSttDef = TSttDefx;
  PSttDef = ^TSttDef;

	{ 	process information 	}
  TPrcDefx = record
    prccol :ubyte2;		// current output message length
    prcibl :ubyte2;		// input message buffer length
    prcinl :ubyte2;		// input length
    prcobl :ubyte2;		// output message buffer length
    prcoul :ubyte2;		// output length
    prcpnm :ubyte1;		// process number
    prcact :ubyte1;		// active flag
  end;
  TPrcDef = TPrcDefx;
  PPrcDef = ^TPrcDef;



{*******************************************************************************
			Sql FUNCTION PROTOTYPES
********************************************************************************}
// call convention
//#  define SQLTAPI byte2 __stdcall	/* 32-bit non-OS/2 uses __stdcall   */
{$IFNDEF XSQL_CLR}
var
  SqlArf: function(Cur: SQLTCUR; fnp: SQLTFNP; fnl: SQLTFNL; cho: SQLTCHO): SqlTAPI; stdcall;
  SqlBbr: function(Cur: SQLTCUR; errno: SQLTXERPTR; errbuf: SQLTDAP; buflen: SQLTDALPTR;
	        errrow: SQLTBIRPTR; rbf: SQLTRBFPTR; errseq: SQLTBIR): SqlTAPI; stdcall;
  SqlBdb: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
		bkpdir: SQLTFNP; bkpdirl: SQLTFNL; local: SQLTBOO; over: SQLTBOO): SqlTAPI; stdcall;
  SqlBef: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlBer: function(Cur: SQLTCUR; rcd: SQLTRCDPTR; errrow: SQLTBIRPTR;
		rbf: SQLTRBFPTR; errseq: SQLTBIR): SqlTAPI; stdcall;
  SqlBkp: function(Cur: SQLTCUR; defalt: SQLTBOO; overwrt: SQLTBOO;
		bkfname: SQLTFNP; bkflen: SQLTFNL): SqlTAPI; stdcall;
  SqlBld: function(Cur: SQLTCUR; bnp: SQLTBNP; bnl: SQLTBNL): SqlTAPI; stdcall;
  SqlBlf: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
		bkpdir: SQLTFNP; bkpdirl: SQLTFNL; local: SQLTBOO; over: SQLTBOO): SqlTAPI; stdcall;
  SqlBlk: function(Cur: SQLTCUR; blkflg: SQLTFLG): SqlTAPI; stdcall;
  SqlBln: function(Cur: SQLTCUR; bnn: SQLTBNN): SqlTAPI; stdcall;
  SqlBna: function(Cur: SQLTCUR; bnp: SQLTBNP; bnl: SQLTBNL; dap: SQLTDAP; dal: SQLTDAL;
		sca: SQLTSCA; pdt: SQLTPDT; nli: SQLTNUL): SqlTAPI; stdcall;
  SqlBnd: function(Cur: SQLTCUR; bnp: SQLTBNP; bnl: SQLTBNL; dap: SQLTDAP; dal: SQLTDAL;
		sca: SQLTSCA; pdt: SQLTPDT): SqlTAPI; stdcall;
  SqlBnn: function(Cur: SQLTCUR; bnn: SQLTBNN; dap: SQLTDAP; dal: SQLTDAL;
	        sca: SQLTSCA; pdt: SQLTPDT): SqlTAPI; stdcall;
  SqlBnu: function(Cur: SQLTCUR; bnn: SQLTBNN; dap: SQLTDAP; dal: SQLTDAL;
	        sca: SQLTSCA; pdt: SQLTPDT; nli: SQLTNUL): SqlTAPI; stdcall;
  SqlBss: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
		bkpdir: SQLTFNP; bkpdirl: SQLTFNL; local: SQLTBOO; over: SQLTBOO): SqlTAPI; stdcall;
  SqlCan: function(Cur: SqlTCUR): SqlTAPI; stdcall;
  SqlCbv: function(Cur: SqlTCUR): SqlTAPI; stdcall;
  SqlCdr: function(sHandle: SQLTSVH; Cur: SqlTCUR): SqlTAPI; stdcall;
  SqlCex: function(Cur: SqlTCUR; pData: SqlTDAP; lData: SqlTDAL): SqlTAPI; stdcall;
  SqlClf: function(Cur: SqlTSVH; LogFile: SqlTDAP; StartFlag: SqlTFMD): SqlTAPI; stdcall;
  SqlCmt: function(Cur: SqlTCur): SqlTAPI; stdcall;
  SqlCnc: function(var Cur: SqlTCur{Cur: SqlTCurPtr}; pDbName: SqlTDAP; lDbName: SqlTDAL): SqlTAPI; stdcall;
  SqlCnr: function(var Cur: SqlTCUR; pDbname: SqlTDAP; lDbName: SqlTDAL): SqlTAPI; stdcall;
  SqlCom: function(Cur: SqlTCUR; pCmd: SqlTDAP; lCmd: SqlTDAL): SqlTAPI; stdcall;
  SqlCon: function(var Cur: SqlTCUR; pDbName: SqlTDAP; lDbname: SqlTDAL;
		CurSiz: SqlTWSI; Pages: SqlTNPG; Recovr: SqlTRCF;
	        OutSize: SqlTDAL; InSize: SqlTDAL): SqlTAPI; stdcall;
  SqlCpy: function(fcur: SQLTCUR; selp: SQLTDAP; sell: SQLTDAL;
		tcur: SQLTCUR; isrtp: SQLTDAP; isrtl: SQLTDAL): SqlTAPI; stdcall;
  SqlCre: function(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; stdcall;
  SqlCrf: function(shandle: SQLTSVH; dbnam: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; stdcall;
  SqlCrs: function(cur: SQLTCUR; rsp: SQLTDAP; rsl: SQLTDAL): SqlTAPI; stdcall;
  SqlCsv: function(var shandlep: SQLTSVH; serverid: SQLTDAP; password: SQLTDAP): SqlTAPI; stdcall;
  SqlCty: function(cur: SQLTCUR; var cty: SQLTCTY): SqlTAPI; stdcall;
  SqlDbn: function(serverid: SQLTDAP; buffer: SQLTDAP; length: SQLTDAL): SqlTAPI; stdcall;
  SqlDed: function(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; stdcall;
  SqlDel: function(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; stdcall;
  SqlDes: function(cur: SQLTCUR; slc: SQLTSLC; ddt: SQLTDDTPtr; ddl: SQLTDDLPtr;
	        chp: SQLTCHP; chlp: SQLTCHLPtr;
	        prep: SQLTPREPtr; scap: SQLTSCAPtr): SqlTAPI; stdcall;
  SqlDid: function(dbname: SQLTDAP; dbnamel: SQLTDAL): SqlTAPI; stdcall;
  SqlDii: function(Cur: SQLTCUR; ivn: SQLTSLC; inp: SQLTDAP; inlp: SQLTCHLPtr): SqlTAPI; stdcall;
  SqlDin: function(dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; stdcall;
  SqlDir: function(srvno: SQLTSVN; buffer: SQLTDAP; length: SQLTDAL): SqlTAPI; stdcall;
  SqlDis: function(cur: SQLTCUR): SqlTAPI; stdcall;
  SqlDon: function: SqlTApi; stdcall;
  SqlDox: function(shandle: SQLTSVH; dirnamep: SQLTDAP; fattr: SQLTFAT): SqlTAPI; stdcall;
  SqlDrc: function(cur: SQLTSVH): SqlTAPI; stdcall;
  SqlDro: function(shandle: SQLTSVH; dirname: SQLTDAP): SqlTAPI; stdcall;
  SqlDrr: function(shandle: SQLTSVH; filename: SQLTDAP): SqlTAPI; stdcall;
  SqlDrs: function(cur: SQLTCUR; rsp: SQLTDAP; rsl: SQLTDAL): SqlTAPI; stdcall;
  SqlDsc: function(Cur: SQLTCUR; slc: SQLTSLC; var edt: SQLTDDT; var edl: SQLTDDL;
	        chp: SQLTCHP; var chlp: SQLTCHL;
	        var prep: SQLTPRE; var scap: SQLTSCA): SqlTAPI; stdcall;
  SqlDst: function(cur: SQLTCUR; cnp: SQLTDAP; cnl: SQLTDAL): SqlTAPI; stdcall;
  SqlDsv: function(shandle: SQLTSVH): SqlTAPI; stdcall;
  SqlEbk: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlEfb: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlElo: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlEnr: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL): SqlTAPI; stdcall;
  SqlEpo: function(Cur: SQLTCUR; var epo: SQLTEPO): SqlTAPI; stdcall;
  SqlErf: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlErr: function(error: SQLTRCD; msg: SQLTDAP): SqlTAPI; stdcall;
  SqlErs: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlEtx: function(error: SQLTRCD; msgtyp: SQLTPTY; bfp: SQLTDAP; bfl: SQLTDAL;
	        var txtlen: SQLTDAL): SqlTAPI; stdcall;
  SqlExe: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlExp: function(Cur: SQLTCUR; buffer: SQLTDAP; length: SQLTDAL): SqlTAPI; stdcall;
  SqlFbk: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlFer: function(error: SQLTRCD; msg: SQLTDAP): SqlTAPI; stdcall;
  SqlFet: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlFgt: function(Cur: SQLTSVH; srvfile: SQLTDAP; lcfile: SQLTDAP): SqlTAPI; stdcall;
  SqlFpt: function(Cur: SQLTSVH; srvfile: SQLTDAP; lclfile: SQLTDAP): SqlTAPI; stdcall;
  SqlFqn: function(Cur: SQLTCUR; field: SQLTFLD; nameptr: SQLTDAP; var namelen: SQLTDAL): SqlTApi; stdcall;
  SqlGbi: function(Cur: SQLTCUR; var BackEndCur: SQLTCUR; ppnm: SQLTPNMPtr): SqlTAPI; stdcall;
  SqlGdi: function(Cur: SQLTCUR; var gdi: TGdiDef): SqlTAPI; stdcall;
  SqlGet: function(Cur: SQLTCUR; parm: SQLTPTY; p: SQLTDAP; var l: SQLTDAL): SqlTAPI; stdcall;
  SqlGfi: function(Cur: SQLTCUR; slc: SQLTSLC;
		cvl: SQLTCDLPtr; fsc: SQLTFSCPtr): SqlTAPI; stdcall;
  SqlGls: function(Cur: SQLTCUR; slc: SQLTSLC; var size: SqlTLsi): SqlTAPI; stdcall;
  SqlGnl: function(shandle: SQLTSVH; dbname: SQLTDAP;
	        dbnamel: SQLTDAL; lognum: SQLTLNGPtr): SqlTAPI; stdcall;
  SqlGnr: function(Cur: SQLTCUR; tbnam: SQLTDAP;
	        tbnaml: SQLTDAL; rows: SQLTROWPtr): SqlTAPI; stdcall;
  SqlGsi: function(shandle: SQLTSVH; infoflags: SQLTFLG; buffer: SQLTDAP;
		buflen: SQLTDAL; var rbuflen: SQLTDAL): SqlTAPI; stdcall;
  SqlIdb: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlIms: function(Cur: SQLTCUR; InSize: SQLTDAL): SqlTAPI; stdcall;
  SqlInd: function(sHandle: SQLTSVH; pDbName: SQLTDAP;
	        lDbName: SQLTDAL): SqlTAPI; stdcall;
  SqlIni: function(CallBack: SQLTPFP): SqlTAPI; stdcall;
  SqlIns: function(SrvNo: SQLTSVN; DbName: SQLTDAP; lDbName: SQLTDAL;
		CreateFlag: SQLTFLG; OverWrite: SQLTFLG): SqlTAPI; stdcall;
  SqlLab: function(Cur: SQLTCUR; slc: SQLTSLC; lbp: SQLTCHP; lblp: SQLTCHLPTR): SqlTAPI; stdcall;
  SqlLdp: function(Cur: SQLTCUR; cmdp: SQLTDAP; cmdl: SQLTDAL): SqlTAPI; stdcall;
  SqlLsk: function(Cur: SQLTCUR; slc: SQLTSLC; pos: SQLTLSI): SqlTAPI; stdcall;
  SqlMcl: function(shandle: SQLTSVH; fd: SQLTFLH): SqlTAPI; stdcall;
  SqlMdl: function(shandle: SQLTSVH; filename: SQLTDAP): SqlTAPI; stdcall;
  SqlMop: function(shandle: SQLTSVH; fdp: SQLTFLHPTR; filename: SQLTDAP; openmode: SQLTFMD): SqlTAPI; stdcall;
  SqlMrd: function(shandle: SQLTSVH; fd: SQLTFLH;
                buffer: SQLTDAP; len: SQLTDAL; rlen: SQLTDALPTR): SqlTAPI; stdcall;
  SqlMsk: function(shandle: SQLTSVH; fd: SQLTFLH;
  	        offset: SQLTLNG; whence: SQLTWNC; roffset: SQLTLNGPTR): SqlTAPI; stdcall;
  SqlMwr: function(shandle: SQLTSVH; fd: SQLTFLH;
  	        buffer: SQLTDAP; len: SQLTDAL; rlen: SQLTDALPTR): SqlTAPI; stdcall;
  SqlNbv: function(Cur: SQLTCUR; var nbv: SQLTNBV): SqlTAPI; stdcall;
  SqlNii: function(Cur: SQLTCUR; var nii: SQLTNSI): SqlTAPI; stdcall;
  SqlNrr: function(Cur: SQLTCUR; var rcountp: SQLTROW): SqlTAPI; stdcall;
  SqlNsi: function(Cur: SQLTCUR; var nsi: SQLTNSI): SqlTAPI; stdcall;
  SqlOms: function(Cur: SQLTCUR; outsize: SQLTDAL): SqlTAPI; stdcall;
  SqlPrs: function(Cur: SQLTCUR; row: SQLTROW): SqlTAPI; stdcall;
  SqlRbf: function(Cur: SQLTCUR; var rbf: SQLTRBF): SqlTAPI; stdcall;
  SqlRbk: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlRcd: function(Cur: SQLTCUR; rcd: SQLTRCDPTR): SqlTAPI; stdcall;
  SqlRdb: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL; bkpdir: SQLTFNP;
	        bkpdirl: SQLTFNL; local: SQLTBOO; over: SQLTBOO): SqlTAPI; stdcall;
  SqlRdc: function(Cur: SQLTCUR; bufp: SQLTDAP;
  	        buf: SQLTDAL; readl: SQLTDALPTR): SqlTAPI; stdcall;
  SqlRel: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlRes: function(var Cur: SQLTCUR; bkfname: SQLTFNP; bkfnlen: SQLTFNL;
		bkfserv: SQLTSVN; overwrt: SQLTBOO;
                dbname: SQLTDAP; dbnlen: SQLTDAL; dbserv: SQLTSVN): SqlTAPI; stdcall;
  SqlRet: function(Cur: SQLTCUR; cnp: SQLTDAP; cnl: SQLTDAL): SqlTAPI; stdcall;
  SqlRlf: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
		bkpdir: SQLTFNP; bkpdirl: SQLTFNL;
                local: SQLTBOO; over: SQLTBOO): SqlTAPI; stdcall;
  SqlRlo: function(Cur: SQLTCUR; slc: SQLTSLC;
  	        bufp: SQLTDAP; bufl: SQLTDAL; var readl: SQLTDAL): SqlTAPI; stdcall;
  SqlRof: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
  		mode: SQLTRFM; datetime: SQLTDAP; datetimel: SQLTDAL): SqlTAPI; stdcall;
  SqlRow: function(Cur: SQLTCUR; var row: SQLTROW): SqlTAPI; stdcall;
  SqlRrd: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlRrs: function(Cur: SQLTCUR; rsp: SQLTDAP;rsl: SQLTDAL): SqlTAPI; stdcall;
  SqlRsi: function(shandle: SQLTSVH): SqlTAPI; stdcall;
  SqlRss: function(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
  		bkpdir: SQLTFNP; bkpdirl: SQLTFNL;
                local: SQLTBOO; over: SQLTBOO): SqlTAPI; stdcall;
  SqlSab: function(shandle: SQLTSVH; pnum: SQLTPNM): SqlTAPI; stdcall;
  SqlSap: function(srvno: SQLTSVN; password: SQLTDAP; pnum: SQLTPNM): SqlTAPI; stdcall;
  SqlScl: function(Cur: SQLTCUR; namp: SQLTDAP; naml: SQLTDAL): SqlTAPI; stdcall;
  SqlScn: function(Cur: SQLTCUR; namp: SQLTDAP; naml: SQLTDAL): SqlTAPI; stdcall;
  SqlScp: function(Pages: SQLTNPG): SqlTAPI; stdcall;
  SqlSdn: function(dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; stdcall;
  SqlSds: function(shandle: SQLTSVH; shutdownflg: SQLTFLG): SqlTAPI; stdcall;
  SqlSdx: function(shandle: SQLTSVH; dbnamp: SQLTDAP;
	        dbnaml: SQLTDAL; shutdownflg: SQLTFLG): SqlTAPI; stdcall;
  SqlSet: function(Cur: SQLTCUR; parm: SQLTPTY; p: SQLTDAP; i: SQLTDAL): SqlTAPI; stdcall;
  SqlSil: function(Cur: SQLTCUR; isolation: SQLTILV): SqlTAPI; stdcall;
  SqlSlp: function(Cur: SQLTCUR; lpt: SQLTNPG; lpm: SQLTNPG): SqlTAPI; stdcall;
  SqlSpr: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlSrf: function(Cur: SQLTCUR; fnp: SQLTDAP; fnl: SQLTDAL): SqlTAPI; stdcall;
  SqlSrs: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlSsb: function(Cur: SQLTCUR; slc: SQLTSLC; pdt: SQLTPDT; pbp: TSDPtr;
  	       pdl: SQLTPDL; sca: SQLTSCA; pcv: SqlTCdlPtr; pfc: SqlTFscPtr): SqlTAPI; stdcall;
  SqlSss: function(Cur: SQLTCUR; size: SQLTDAL): SqlTAPI; stdcall;
  SqlSta: function(Cur: SQLTCUR; var srv: SQLTSTC; svw: SQLTSTC;
		var spr: SQLTSTC; var spw: SQLTSTC): SqlTAPI; stdcall;
  SqlStm: function(shandle: SQLTSVH): SqlTAPI; stdcall;
  SqlSto: function(Cur: SQLTCUR; cnp: SQLTDAP; cnl: SQLTDAL;
		ctp: SQLTDAP; ctl: SQLTDAL): SqlTAPI; stdcall;
  SqlStr: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlSxt: function(srvno: SQLTSVN; password: SQLTDAP): SqlTAPI; stdcall;
  SqlTec: function(rcd: SQLTRCD; np: SQLTRCDPTR): SqlTAPI; stdcall;
  SqlTem: function(Cur: SQLTCUR; xer: SQLTXERPTR; msgtyp: SQLTPTY;
                bfp: SQLTDAP; bfl: SQLTDAL; txtlen: SQLTDALPTR): SqlTAPI; stdcall;
  SqlTio: function(Cur: SQLTCUR; timeout: SQLTTIV): SqlTAPI; stdcall;
  SqlUnl: function(Cur: SQLTCUR; cmdp: SQLTDAP; cmdl: SQLTDAL): SqlTAPI; stdcall;
  SqlUrs: function(Cur: SQLTCUR): SqlTAPI; stdcall;
  SqlWdc: function(Cur: SQLTCUR; bufp: SQLTDAP; bufl: SQLTDAL): SqlTAPI; stdcall;
  SqlWlo: function(Cur: SQLTCUR; bufp: SQLTDAP; bufl: SQLTDAL): SqlTAPI; stdcall;
  SqlXad: function(op: SQLTNMP; np1: SQLTNMP; nl1: SQLTNML; np2: SQLTNMP; nl2: SQLTNML): SqlTAPI; stdcall;
  SqlXcn: function(op: SQLTNMP; ip: SQLTDAP; il: SQLTDAL): SqlTAPI; stdcall;
  SqlXda: function(op: SQLTNMP; dp: SQLTNMP; dl: SQLTNML; days: SQLTDAY): SqlTAPI; stdcall;
  SqlXdp: function(op: SQLTDAP; ol: SQLTDAL; ip: SQLTNMP; il: SQLTNML;
  	        pp: SQLTDAP; pl: SQLTDAL): SqlTAPI; stdcall;
  SqlXdv: function(op: SQLTNMP; np1: SQLTNMP; nl1: SQLTNML; np2: SQLTNMP; nl2: SQLTNML): SqlTAPI; stdcall;
  SqlXer: function(Cur: SQLTCUR; ErrNo: SQLTXERPTR; ErrBuf: SQLTDAP; BufLen: SQLTDALPTR): SqlTAPI; stdcall;
  SqlXml: function(op: SQLTNMP; np1: SQLTNMP; nl1: SQLTNML; np2: SQLTNMP; nl2: SQLTNML): SqlTAPI; stdcall;
  SqlXnp: function(Outp: SQLTDAP; OutL: SQLTDAL; isnp: SQLTNMP; isnl: SQLTNML;
	        PicP: SQLTDAP; PicL: SQLTDAL): SqlTAPI; stdcall;
  SqlXpd: function(op: SQLTNMP; var ol: SQLTNML; ip: SQLTDAP; pp: SQLTDAP; pl: SQLTDAL): SqlTAPI; stdcall;
  SqlXsb: function(op: SQLTNMP; np1: SQLTNMP; nl1: SQLTNML; np2: SQLTNMP; nl2: SQLTNML): SqlTAPI; stdcall;

  // SQLBase 7.0
  SqlCch: function(var hCon: SQLTCON; dbnamp: SQLTDAP; dbnaml: SQLTDAL; fType: SQLTMOD): SqlTAPI; stdcall;
  SqlDch: function(hCon: SQLTCON): SqlTAPI; stdcall;
  SqlOpc: function(var Cur: SQLTCUR; hCon: SQLTCON; fType: SQLTMOD): SqlTAPI; stdcall;
{$ENDIF}

type
  TCSBLogon	= SQLTCON;		// SQLBase7 connection handle
  TCSBCursor	= SqlTCur;		// SQLBase Cursor type
  TCSBSrvCursor	= SQLTSVH;
  ESDCSBError = class(ESDEngineError);

{ TICsbDatabase }
  TICsbConnInfo	= packed record
    ServerType: Byte;
    hLogon: TCSBLogon;		// cursor(SQLBase6) or connection(SQLBase7)
    hCursor: TCSBCursor;	// cursor handle
    ConnectStr: string;	        // store connect string
  end;

  TICsbDatabase = class(TISqlDatabase)
  private
    FHandle: TSDPtr;
    FIsTransLogging: Boolean;

    procedure Check(Status: TSDEResult);
    procedure AllocHandle;
    procedure FreeHandle;
    procedure ChangePreservedProps;
    function GetConnectStr: string;
    function GetCurHandle: TCSBCursor;
    function GetLogHandle: TCSBLogon;
    procedure SetNullIndicatorError(Value: Boolean);
    procedure SetDefaultOptions;
  protected
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
    function CreateSqlCommand: TISqlCommand; override;

    function GetClientVersion: LongInt; override;
    function GetServerVersion: LongInt; override;
    function GetVersionString: string; override;
    function GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand; override;

    function ParamValue(Value: TXSQLDatabaseParam): Integer; override;

    procedure SetTransIsolation(Value: TISqlTransIsolation); override;
    function SPDescriptionsAvailable: Boolean; override;
    function TestConnected: Boolean; override;

    function UseConnHandle: Boolean;
    property ConnectStr: string read GetConnectStr;
    property CurHandle: TCSBCursor read GetCurHandle;
    property LogHandle: TCSBLogon read GetLogHandle;
    property IsTransLogging: Boolean read FIsTransLogging;
  end;

{ TICsbCommand }
  TICsbCommand = class(TISqlCommand)
  private
    FHandle: PSDCursor;
    FRowFetched: Boolean;       // if FetchNextRow was called (it's used for get parameter's values)
    FBlobPieceSize: Integer;    // to minimize call SqlDatabase.
    function GetSqlDatabase: TICsbDatabase;
    function GetCurHandle: TCsbCursor;
    procedure Connect;
    procedure ClearBindParams;
    function CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDPtr; BufSize: Integer): TDateTimeRec;
    function DBDateTimeFormat(ADataType: TFieldType): string;
    function DBDateTimeStrLen(ADataType: TFieldType): Integer;
    procedure SetDefaultParams;
    procedure SetPreservation(Value: Boolean);
    procedure QBindParamsBuffer;
    procedure SpBindParamsBuffer;
    procedure SpGetOutputParams;
  protected
    procedure Check(Status: TSDEResult);
    procedure CheckPrepared;

    procedure BindParamsBuffer; override;
    function CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer; override;
    procedure InitParamList; override;
    function FieldDataType(ExtDataType: Integer): TFieldType; override;
    procedure FreeParamsBuffer; override;
    procedure DoExecute; override;
    procedure DoExecDirect(Value: string); override;
    procedure DoPrepare(Value: string); override;
    function GetHandle: PSDCursor; override;
    procedure GetFieldDescs(Descs: TSDFieldDescList); override;
    function NativeDataSize(FieldType: TFieldType): Word; override;
    function NativeDataType(FieldType: TFieldType): Integer; override;
    function RequiredCnvtFieldType(FieldType: TFieldType): Boolean; override;
    procedure SetFieldsBuffer; override;
  public
    constructor Create(ASqlDatabase: TISqlDatabase); override;
    destructor Destroy; override;
	// command interface
    procedure CloseResultSet; override;
    procedure Disconnect(Force: Boolean); override;
    function GetRowsAffected: Integer; override;
	// cursor interface
    function FetchNextRow: Boolean; override;
    function GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean; override;
    procedure GetOutputParams; override;
    function ResultSetExists: Boolean; override;
    function ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint; override;
    function WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint; override;
    function WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint; override;
    property CurHandle: TCSBCursor read GetCurHandle;
    property SqlDatabase: TICsbDatabase read GetSqlDatabase;    
  end;

const
  DefSqlApiDLL	= 'SQLWNTM.DLL';

var
  SqlApiDLL: string;

{$IFDEF XSQL_CLR}
type
  [StructLayout(LayoutKind.Sequential)]
  TGdiDefx	= record
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 31)]
    gdifl1: string;             		// filler reserved for future use   */
    gdifl2: ubyte1;				// filler reserved for future use
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 31)]
    gdilbb: string;             		// label buffer
    gdilbl: SQLTLBL;				// label info length
    gdicol: SQLTSLC;				// select column number
    gdiddt: SQLTDDT;				// database data type
    gdiddl: SQLTDEDL;				// database extended data length
    gdiedt: SQLTDDT;				// external data type
    gdiedl: SQLTDEDL;				// external extended data length
    gdipre: SQLTPRE;				// decimal precision
    gdisca: SQLTSCA;				// decimal scale
    gdinul: byte2;				// null indicator
    [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 47)]
    gdichb: string;             		// column heading buffer
    gdichl: SQLTCHL;				// column heading length
    gdifil: array[0..1] of byte1;		// for future use
  end;
  TGdiDef	= TGdiDefx;

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlbld')]
function SqlBld(Cur: SQLTCUR; bnp: SQLTBNP; bnl: SQLTBNL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlbln')]
function SqlBln(Cur: SQLTCUR; bnn: SQLTBNN): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlbna')]
function SqlBna(Cur: SQLTCUR; bnp: SQLTBNP; bnl: SQLTBNL; dap: SQLTDAP; dal: SQLTDAL;
		 sca: SQLTSCA; pdt: SQLTPDT; nli: SQLTNUL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlbnd')]
function SqlBnd(Cur: SQLTCUR; bnp: SQLTBNP; bnl: SQLTBNL; dap: SQLTDAP; dal: SQLTDAL;
		 sca: SQLTSCA; pdt: SQLTPDT): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlbnu')]
function SqlBnu(Cur: SQLTCUR; bnn: SQLTBNN; dap: SQLTDAP; dal: SQLTDAL;
        	 sca: SQLTSCA; pdt: SQLTPDT; nli: SQLTNUL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlbss')]
function SqlBss(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
		bkpdir: SQLTFNP; bkpdirl: SQLTFNL; local: SQLTBOO; over: SQLTBOO): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcbv')]
function SqlCbv(Cur: SqlTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcdr')]
function SqlCdr(sHandle: SQLTSVH; Cur: SqlTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcex')]
function SqlCex(Cur: SqlTCUR; pData: SqlTDAP; lData: SqlTDAL): SqlTAPI; external;


[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcmt')]
function SqlCmt(Cur: SqlTCur): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcnc')]
function SqlCnc(var Cur: SqlTCur{Cur: SqlTCurPtr}; pDbName: SqlTDAP; lDbName: SqlTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcnr')]
function SqlCnr(var Cur: SqlTCUR; pDbname: SqlTDAP; lDbName: SqlTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcom')]
function SqlCom(Cur: SqlTCUR; pCmd: SqlTDAP; lCmd: SqlTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcon')]
function SqlCon(var Cur: SqlTCUR; pDbName: SqlTDAP; lDbname: SqlTDAL;
		CurSiz: SqlTWSI; Pages: SqlTNPG; Recovr: SqlTRCF;
	        OutSize: SqlTDAL; InSize: SqlTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcpy')]
function SqlCpy(fcur: SQLTCUR; selp: SQLTDAP; sell: SQLTDAL;
		tcur: SQLTCUR; isrtp: SQLTDAP; isrtl: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcre')]
function SqlCre(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; external;

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcsv')]
function SqlCsv(var shandlep: SQLTSVH; serverid: SQLTDAP; password: SQLTDAP): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcty')]
function SqlCty(cur: SQLTCUR; var cty: SQLTCTY): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldbn')]
function SqlDbn(serverid: SQLTDAP; buffer: SQLTDAP; length: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlded')]
function SqlDed(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldel')]
function SqlDel(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldis')]
function SqlDis(cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldon')]
function SqlDon: SqlTApi; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldsc')]
function SqlDsc(Cur: SQLTCUR; slc: SQLTSLC; var edt: SQLTDDT; var edl: SQLTDDL;
        	 chp: SQLTCHP; var chlp: SQLTCHL;
        	 var prep: SQLTPRE; var scap: SQLTSCA): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldst')]
function SqlDst(cur: SQLTCUR; cnp: SQLTDAP; cnl: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldsv')]
function SqlDsv(shandle: SQLTSVH): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlelo')]
function SqlElo(Cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlepo')]
function SqlEpo(Cur: SQLTCUR; var epo: SQLTEPO): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlexe')]
function SqlExe(Cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlfer')]
function SqlFer(error: SQLTRCD; msg: SQLTDAP): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlfet')]
function SqlFet(Cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlgdi')]
function SqlGdi(Cur: SQLTCUR; var gdi: TGdiDef): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlget')]
function SqlGet(Cur: SQLTCUR; parm: SQLTPTY; p: SQLTDAP; var l: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlgls')]
function SqlGls(Cur: SQLTCUR; slc: SQLTSLC; var size: SqlTLsi): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlind')]
function SqlInd(sHandle: SQLTSVH; pDbName: SQLTDAP; lDbName: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlini')]
function SqlIni(CallBack: SQLTPFP): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqllsk')]
function SqlLsk(Cur: SQLTCUR; slc: SQLTSLC; pos: SQLTLSI): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlnbv')]
function SqlNbv(Cur: SQLTCUR; var nbv: SQLTNBV): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlnrr')]
function SqlNrr(Cur: SQLTCUR; var rcountp: SQLTROW): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlnsi')]
function SqlNsi(Cur: SQLTCUR; var nsi: SQLTNSI): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlrbk')]
function SqlRbk(Cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlret')]
function SqlRet(Cur: SQLTCUR; cnp: SQLTDAP; cnl: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlrlf')]
function SqlRlf(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
 		 bkpdir: SQLTFNP; bkpdirl: SQLTFNL;
                local: SQLTBOO; over: SQLTBOO): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlrlo')]
function SqlRlo(Cur: SQLTCUR; slc: SQLTSLC;
         	 bufp: SQLTDAP; bufl: SQLTDAL; var readl: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlrow')]
function SqlRow(Cur: SQLTCUR; var row: SQLTROW): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlrss')]
function SqlRss(shandle: SQLTSVH; dbname: SQLTDAP; dbnamel: SQLTDAL;
  		bkpdir: SQLTFNP; bkpdirl: SQLTFNL;
                local: SQLTBOO; over: SQLTBOO): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsab')]
function SqlSab(shandle: SQLTSVH; pnum: SQLTPNM): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsap')]
function SqlSap(srvno: SQLTSVN; password: SQLTDAP; pnum: SQLTPNM): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlscl')]
function SqlScl(Cur: SQLTCUR; namp: SQLTDAP; naml: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlscn')]
function SqlScn(Cur: SQLTCUR; namp: SQLTDAP; naml: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlscp')]
function SqlScp(Pages: SQLTNPG): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsdn')]
function SqlSdn(dbnamp: SQLTDAP; dbnaml: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsds')]
function SqlSds(shandle: SQLTSVH; shutdownflg: SQLTFLG): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsdx')]
function SqlSdx(shandle: SQLTSVH; dbnamp: SQLTDAP; dbnaml: SQLTDAL; shutdownflg: SQLTFLG): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlset')]
function SqlSet(Cur: SQLTCUR; parm: SQLTPTY; p: SQLTDAP; i: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsil')]
function SqlSil(Cur: SQLTCUR; isolation: SQLTILV): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlspr')]
function SqlSpr(Cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsrs')]
function SqlSrs(Cur: SQLTCUR): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlssb')]
function SqlSsb(Cur: SQLTCUR; slc: SQLTSLC; pdt: SQLTPDT; pbp: TSDPtr;
  	       pdl: SQLTPDL; sca: SQLTSCA; pcv: TSDPtr; pfc: TSDPtr): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsss')]
function SqlSss(Cur: SQLTCUR; size: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlsta')]
function SqlSta(Cur: SQLTCUR; var srv: SQLTSTC; svw: SQLTSTC; var spr: SQLTSTC; var spw: SQLTSTC): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlstm')]
function SqlStm(shandle: SQLTSVH): SqlTAPI; external;

[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlwlo')]
function SqlWlo(Cur: SQLTCUR; bufp: SQLTDAP; bufl: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlxdp')]
function SqlXdp(op: SQLTDAP; ol: SQLTDAL; ip: SQLTNMP; il: SQLTNML;
         	 pp: SQLTDAP; pl: SQLTDAL): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlxpd')]
function SqlXpd(op: SQLTNMP; var ol: SQLTNML; ip: SQLTDAP; pp: SQLTDAP; pl: SQLTDAL): SqlTAPI; external;

  // SQLBase 7.0
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlcch')]
function SqlCch(var hCon: SQLTCON; dbnamp: SQLTDAP; dbnaml: SQLTDAL; fType: SQLTMOD): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqldch')]
function SqlDch(hCon: SQLTCON): SqlTAPI; external;
[DllImport(DefSqlApiDLL, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'sqlopc')]
function SqlOpc(var Cur: SQLTCUR; hCon: SQLTCON; fType: SQLTMOD): SqlTAPI; external;

{$ENDIF}

procedure CsbError(Cur: SQLTCUR; error: SQLTRCD; ErrPos: LongInt);
function APIVersion: Single;

(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure LoadSqlLib;
procedure FreeSqlLib;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;

implementation


resourcestring
  SErrLibLoading 	= 'Error loading library ''%s''';
  SErrLibUnloading	= 'Error unloading library ''%s''';
  SErrLibInit		= 'Error initialization SQLBase Engine';
  SErrFuncNotFound	= 'Function ''%s'' not found in SQLBase Engine library';

const
  SDummySelect = 'select 1 from SYSSQL.SYSTABLES where 0=1';

var
  hSqlLibModule: THandle;
  SqlLibRefCount: Integer;
  SqlLibLock: TCriticalSection;
  dwLoadedFileVer: LongInt;

function InitSqlDatabase(ADbParams: TStrings): TISqlDatabase;
var
  s: string;
begin
  if hSqlLibModule = 0 then begin
    s := Trim( ADbParams.Values[GetSqlLibParamName( Ord(istSQLBase) )] );
    if s <> '' then
      SqlApiDLL := s;
  end;

  Result := TICsbDatabase.Create( ADbParams );
end;

function APIVersion: Single;
begin
  if SqlLibRefCount = 0 then begin
    Result := 0;
    Exit;
  end;

  Result := 6;
//  if (@SqlCch <> nil) and (@SqlDch <> nil) and (@SqlOpc <> nil) then
  if Assigned( GetProcAddress(hSqlLibModule, 'sqlcch') ) and
     Assigned( GetProcAddress(hSqlLibModule, 'sqldch') ) and
     Assigned( GetProcAddress(hSqlLibModule, 'sqlopc') )
  then
    Result := 7;
end;

function IsVersion7: Boolean;
begin
  Result := APIVersion >= 7;
end;

procedure CsbError(Cur: SQLTCUR; error: SQLTRCD; ErrPos: LongInt);
var
  E: ESDCSBError;
  pMsg: TSDPtr;
  sMsg: string;
begin
  pMsg := SafeReallocMem(nil, SqlMErr+1);
  try
    SafeInitMem(pMsg, SqlMErr+1, 0);
    SqlFer(error, pMsg);

    sMsg := HelperPtrToString(pMsg);
    E := ESDCSBError.Create(error, error, sMsg, ErrPos);
    raise E;
  finally
    SafeReallocMem(pMsg, 0);
  end;
end;

function CsbSqlSet(Cur: SQLTCUR; parm: SQLTPTY; Value: SqlTDpv): SqlTApi;
var
  ptr: TSDPtr;
begin
  ptr := SafeReallocMem(nil, SizeOf(Value));
  try
    HelperMemWriteInt32(ptr, 0, Value);
    Result := SqlSet(Cur, parm, ptr, 0);
  finally
    SafeReallocMem(ptr, 0);
  end;
end;
             
// Example:	database/name/password
function CreateConnectString(const sDatabase, sUserName, sPassword: string): string;
begin
  if Length(sDatabase) > 0 then
    Result := Trim(sDatabase);
  if Length(sUserName) > 0 then
    Result := Result + '/' + Trim(sUserName);
  if Length(sPassword) > 0 then
    Result := Result + '/' + Trim(sPassword);
end;

function GetBrandName( ABrand: Integer ): string;
begin
  case ABrand of
    SQLBSQB: Result := 'Centura SQLBase';
    SQLBDB2: Result := 'IBM DB2';
    SQLBDBM: Result := 'IBM OS/2 Database Manager';
    SQLBORA: Result := 'Oracle';
    SQLBIGW: Result := 'Informix';
    SQLBNTW: Result := 'Netware SQL';
    SQLBAS4: Result := 'IBM AS/400 SQL/400';
    SQLBSYB: Result := 'Sybase SQL Server';
    SQLBDBC: Result := 'Teradata DBC Machines';
    SQLBALB: Result := 'HP Allbase';
    SQLBRDB: Result := 'DEC''s RDB';
    SQLBTDM: Result := 'Tandem''s Nonstop SQL';
    SQLBSDS: Result := 'IBM SQL/DS';
    SQLBSES: Result := 'SNI SESAM';
    SQLBING: Result := 'Ingres';
    SQLBSQL: Result := 'SQL Access';
    SQLBDBA: Result := 'DBase';
    SQLBDB4: Result := 'SNI DDB4';
    SQLBFUJ: Result := 'Fujitsu RDBII';
    SQLBSUP: Result := 'Cincom SUPRA';
    SQLB204: Result := 'CCA Model 204';
    SQLBDAL: Result := 'Apple DAL interface';
    SQLBSHR: Result := 'Teradata ShareBase';
    SQLBIOL: Result := 'Informix On-Line';
    SQLBEDA: Result := 'EDA/SQL';
    SQLBUDS: Result := 'SNI UDS';
    SQLBMIM: Result := 'Nocom Mimer';
    SQLBOR7: Result := 'Oracle version 7';
    SQLBIOS: Result := 'Ingres OpenSQL';
    SQLBIOD: Result := 'Ingres OpenSQL with date support';
    SQLBODB: Result := 'ODBC Router';
    SQLBS10: Result := 'SYBASE System 10';
    SQLBSE6: Result := 'Informix SE version 6';
    SQLBOL6: Result := 'Informix On-Line version 6';
    SQLBNSE: Result := 'Informix SE NLS version 6';
    SQLBNOL: Result := 'Informix On-Line NLS version 6';
    SQLBAPP: Result := 'SQLHost App Services';
  end;
end;


(*******************************************************************************
			Load/Unload Sql-library
********************************************************************************)
procedure SetProcAddresses;
begin
{$IFNDEF XSQL_CLR}
//  @SqlArf := GetProcAddress(hSqlLibModule, 'sqlarf');  	ASSERT( @SqlArf<>nil );
  @SqlBbr := GetProcAddress(hSqlLibModule, 'sqlbbr');  	ASSERT( @SqlBbr<>nil, Format(SErrFuncNotFound, ['SqlBbr']) );
  @SqlBdb := GetProcAddress(hSqlLibModule, 'sqlbdb');  	ASSERT( @SqlBdb<>nil, Format(SErrFuncNotFound, ['SqlBdb']) );
  @SqlBef := GetProcAddress(hSqlLibModule, 'sqlbef');  	ASSERT( @SqlBef<>nil, Format(SErrFuncNotFound, ['SqlBef']) );
  @SqlBer := GetProcAddress(hSqlLibModule, 'sqlber');  	ASSERT( @SqlBer<>nil, Format(SErrFuncNotFound, ['SqlBer']) );
  @SqlBkp := GetProcAddress(hSqlLibModule, 'sqlbkp');  	ASSERT( @SqlBkp<>nil, Format(SErrFuncNotFound, ['SqlBkp']) );
  @SqlBld := GetProcAddress(hSqlLibModule, 'sqlbld');  	ASSERT( @SqlBld<>nil, Format(SErrFuncNotFound, ['SqlBld']) );
  @SqlBlf := GetProcAddress(hSqlLibModule, 'sqlblf');  	ASSERT( @SqlBlf<>nil, Format(SErrFuncNotFound, ['SqlBlf']) );
  @SqlBlk := GetProcAddress(hSqlLibModule, 'sqlblk');  	ASSERT( @SqlBlk<>nil, Format(SErrFuncNotFound, ['SqlBlk']) );
  @SqlBln := GetProcAddress(hSqlLibModule, 'sqlbln');  	ASSERT( @SqlBln<>nil, Format(SErrFuncNotFound, ['SqlBln']) );
  @SqlBna := GetProcAddress(hSqlLibModule, 'sqlbna');  	ASSERT( @SqlBna<>nil, Format(SErrFuncNotFound, ['SqlBna']) );
  @SqlBnd := GetProcAddress(hSqlLibModule, 'sqlbnd');  	ASSERT( @SqlBnd<>nil, Format(SErrFuncNotFound, ['SqlBnd']) );
  @SqlBnn := GetProcAddress(hSqlLibModule, 'sqlbnn');  	ASSERT( @SqlBnn<>nil, Format(SErrFuncNotFound, ['SqlBnn']) );
  @SqlBnu := GetProcAddress(hSqlLibModule, 'sqlbnu');  	ASSERT( @SqlBnu<>nil, Format(SErrFuncNotFound, ['SqlBnu']) );
  @SqlBss := GetProcAddress(hSqlLibModule, 'sqlbss');  	ASSERT( @SqlBss<>nil, Format(SErrFuncNotFound, ['SqlBss']) );
  @SqlCan := GetProcAddress(hSqlLibModule, 'sqlcan');  	ASSERT( @SqlCan<>nil, Format(SErrFuncNotFound, ['SqlCan']) );
  @SqlCbv := GetProcAddress(hSqlLibModule, 'sqlcbv');  	ASSERT( @SqlCbv<>nil, Format(SErrFuncNotFound, ['SqlCbv']) );
  @SqlCdr := GetProcAddress(hSqlLibModule, 'sqlcdr');  	ASSERT( @SqlCdr<>nil, Format(SErrFuncNotFound, ['SqlCdr']) );
  @SqlCex := GetProcAddress(hSqlLibModule, 'sqlcex');  	ASSERT( @SqlCex<>nil, Format(SErrFuncNotFound, ['SqlCex']) );
  @SqlClf := GetProcAddress(hSqlLibModule, 'sqlclf');  	ASSERT( @SqlClf<>nil, Format(SErrFuncNotFound, ['SqlClf']) );
  @SqlCmt := GetProcAddress(hSqlLibModule, 'sqlcmt');  	ASSERT( @SqlCmt<>nil, Format(SErrFuncNotFound, ['SqlCmt']) );
  @SqlCnc := GetProcAddress(hSqlLibModule, 'sqlcnc');  	ASSERT( @SqlCnc<>nil, Format(SErrFuncNotFound, ['SqlCnc']) );
  @SqlCnr := GetProcAddress(hSqlLibModule, 'sqlcnr');  	ASSERT( @SqlCnr<>nil, Format(SErrFuncNotFound, ['SqlCnr']) );
  @SqlCom := GetProcAddress(hSqlLibModule, 'sqlcom');  	ASSERT( @SqlCom<>nil, Format(SErrFuncNotFound, ['SqlCom']) );
  @SqlCon := GetProcAddress(hSqlLibModule, 'sqlcon');  	ASSERT( @SqlCon<>nil, Format(SErrFuncNotFound, ['SqlCon']) );
  @SqlCpy := GetProcAddress(hSqlLibModule, 'sqlcpy');  	ASSERT( @SqlCpy<>nil, Format(SErrFuncNotFound, ['SqlCpy']) );
  @SqlCre := GetProcAddress(hSqlLibModule, 'sqlcre');  	ASSERT( @SqlCre<>nil, Format(SErrFuncNotFound, ['SqlCre']) );
  @SqlCrf := GetProcAddress(hSqlLibModule, 'sqlcrf');  	ASSERT( @SqlCrf<>nil, Format(SErrFuncNotFound, ['SqlCrf']) );
  @SqlCrs := GetProcAddress(hSqlLibModule, 'sqlcrs');  	ASSERT( @SqlCrs<>nil, Format(SErrFuncNotFound, ['SqlCrs']) );
  @SqlCsv := GetProcAddress(hSqlLibModule, 'sqlcsv');  	ASSERT( @SqlCsv<>nil, Format(SErrFuncNotFound, ['SqlCsv']) );
  @SqlCty := GetProcAddress(hSqlLibModule, 'sqlcty');  	ASSERT( @SqlCty<>nil, Format(SErrFuncNotFound, ['SqlCty']) );
  @SqlDbn := GetProcAddress(hSqlLibModule, 'sqldbn');  	ASSERT( @SqlDbn<>nil, Format(SErrFuncNotFound, ['SqlDbn']) );
  @SqlDed := GetProcAddress(hSqlLibModule, 'sqlded');  	ASSERT( @SqlDed<>nil, Format(SErrFuncNotFound, ['SqlDed']) );
  @SqlDel := GetProcAddress(hSqlLibModule, 'sqldel');  	ASSERT( @SqlDel<>nil, Format(SErrFuncNotFound, ['SqlDel']) );
  @SqlDes := GetProcAddress(hSqlLibModule, 'sqldes');  	ASSERT( @SqlDes<>nil, Format(SErrFuncNotFound, ['SqlDes']) );
  @SqlDid := GetProcAddress(hSqlLibModule, 'sqldid');  	ASSERT( @SqlDid<>nil, Format(SErrFuncNotFound, ['SqlDid']) );
  @SqlDii := GetProcAddress(hSqlLibModule, 'sqldii');  	ASSERT( @SqlDii<>nil, Format(SErrFuncNotFound, ['SqlDii']) );
  @SqlDin := GetProcAddress(hSqlLibModule, 'sqldin');  	ASSERT( @SqlDin<>nil, Format(SErrFuncNotFound, ['SqlDin']) );
  @SqlDir := GetProcAddress(hSqlLibModule, 'sqldir');  	ASSERT( @SqlDir<>nil, Format(SErrFuncNotFound, ['SqlDir']) );
  @SqlDis := GetProcAddress(hSqlLibModule, 'sqldis');  	ASSERT( @SqlDis<>nil, Format(SErrFuncNotFound, ['SqlDis']) );
  @SqlDon := GetProcAddress(hSqlLibModule, 'sqldon');  	ASSERT( @SqlDon<>nil, Format(SErrFuncNotFound, ['SqlDon']) );
  @SqlDox := GetProcAddress(hSqlLibModule, 'sqldox');  	ASSERT( @SqlDox<>nil, Format(SErrFuncNotFound, ['SqlDox']) );
  @SqlDrc := GetProcAddress(hSqlLibModule, 'sqldrc');  	ASSERT( @SqlDrc<>nil, Format(SErrFuncNotFound, ['SqlDrc']) );
  @SqlDro := GetProcAddress(hSqlLibModule, 'sqldro');  	ASSERT( @SqlDro<>nil, Format(SErrFuncNotFound, ['SqlDro']) );
  @SqlDrr := GetProcAddress(hSqlLibModule, 'sqldrr');  	ASSERT( @SqlDrr<>nil, Format(SErrFuncNotFound, ['SqlDrr']) );
  @SqlDrs := GetProcAddress(hSqlLibModule, 'sqldrs');  	ASSERT( @SqlDrs<>nil, Format(SErrFuncNotFound, ['SqlDrs']) );
  @SqlDsc := GetProcAddress(hSqlLibModule, 'sqldsc');  	ASSERT( @SqlDsc<>nil, Format(SErrFuncNotFound, ['SqlDsc']) );
  @SqlDst := GetProcAddress(hSqlLibModule, 'sqldst');  	ASSERT( @SqlDst<>nil, Format(SErrFuncNotFound, ['SqlDst']) );
  @SqlDsv := GetProcAddress(hSqlLibModule, 'sqldsv');  	ASSERT( @SqlDsv<>nil, Format(SErrFuncNotFound, ['SqlDsv']) );
  @SqlEbk := GetProcAddress(hSqlLibModule, 'sqlebk');  	ASSERT( @SqlEbk<>nil, Format(SErrFuncNotFound, ['SqlEbk']) );
  @SqlEfb := GetProcAddress(hSqlLibModule, 'sqlefb');  	ASSERT( @SqlEfb<>nil, Format(SErrFuncNotFound, ['SqlEfb']) );
  @SqlElo := GetProcAddress(hSqlLibModule, 'sqlelo');  	ASSERT( @SqlElo<>nil, Format(SErrFuncNotFound, ['SqlElo']) );
  @SqlEnr := GetProcAddress(hSqlLibModule, 'sqlenr');  	ASSERT( @SqlEnr<>nil, Format(SErrFuncNotFound, ['SqlEnr']) );
  @SqlEpo := GetProcAddress(hSqlLibModule, 'sqlepo');  	ASSERT( @SqlEpo<>nil, Format(SErrFuncNotFound, ['SqlEpo']) );
  @SqlErf := GetProcAddress(hSqlLibModule, 'sqlerf');  	ASSERT( @SqlErf<>nil, Format(SErrFuncNotFound, ['SqlErf']) );
  @SqlErr := GetProcAddress(hSqlLibModule, 'sqlerr');  	ASSERT( @SqlErr<>nil, Format(SErrFuncNotFound, ['SqlErr']) );
  @SqlErs := GetProcAddress(hSqlLibModule, 'sqlers');  	ASSERT( @SqlErs<>nil, Format(SErrFuncNotFound, ['SqlErs']) );
  @SqlEtx := GetProcAddress(hSqlLibModule, 'sqletx');  	ASSERT( @SqlEtx<>nil, Format(SErrFuncNotFound, ['SqlEtx']) );
  @SqlExe := GetProcAddress(hSqlLibModule, 'sqlexe');  	ASSERT( @SqlExe<>nil, Format(SErrFuncNotFound, ['SqlExe']) );
  @SqlExp := GetProcAddress(hSqlLibModule, 'sqlexp');  	ASSERT( @SqlExp<>nil, Format(SErrFuncNotFound, ['SqlExp']) );
  @SqlFbk := GetProcAddress(hSqlLibModule, 'sqlfbk');  	ASSERT( @SqlFbk<>nil, Format(SErrFuncNotFound, ['SqlFbk']) );
  @SqlFer := GetProcAddress(hSqlLibModule, 'sqlfer');  	ASSERT( @SqlFer<>nil, Format(SErrFuncNotFound, ['SqlFer']) );
  @SqlFet := GetProcAddress(hSqlLibModule, 'sqlfet');  	ASSERT( @SqlFet<>nil, Format(SErrFuncNotFound, ['SqlFet']) );
  @SqlFgt := GetProcAddress(hSqlLibModule, 'sqlfgt');  	ASSERT( @SqlFgt<>nil, Format(SErrFuncNotFound, ['SqlFgt']) );
  @SqlFpt := GetProcAddress(hSqlLibModule, 'sqlfpt');  	ASSERT( @SqlFpt<>nil, Format(SErrFuncNotFound, ['SqlFpt']) );
  @SqlFqn := GetProcAddress(hSqlLibModule, 'sqlfqn');  	ASSERT( @SqlFqn<>nil, Format(SErrFuncNotFound, ['SqlFqn']) );
  @SqlGbi := GetProcAddress(hSqlLibModule, 'sqlgbi');  	ASSERT( @SqlGbi<>nil, Format(SErrFuncNotFound, ['SqlGbi']) );
  @SqlGdi := GetProcAddress(hSqlLibModule, 'sqlgdi');  	ASSERT( @SqlGdi<>nil, Format(SErrFuncNotFound, ['SqlGdi']) );
  @SqlGet := GetProcAddress(hSqlLibModule, 'sqlget');  	ASSERT( @SqlGet<>nil, Format(SErrFuncNotFound, ['SqlGet']) );
  @SqlGfi := GetProcAddress(hSqlLibModule, 'sqlgfi');  	ASSERT( @SqlGfi<>nil, Format(SErrFuncNotFound, ['SqlGfi']) );
  @SqlGls := GetProcAddress(hSqlLibModule, 'sqlgls');  	ASSERT( @SqlGls<>nil, Format(SErrFuncNotFound, ['SqlGls']) );
  @SqlGnl := GetProcAddress(hSqlLibModule, 'sqlgnl');  	ASSERT( @SqlGnl<>nil, Format(SErrFuncNotFound, ['SqlGnl']) );
  @SqlGnr := GetProcAddress(hSqlLibModule, 'sqlgnr');  	ASSERT( @SqlGnr<>nil, Format(SErrFuncNotFound, ['SqlGnr']) );
  @SqlGsi := GetProcAddress(hSqlLibModule, 'sqlgsi');  	ASSERT( @SqlGsi<>nil, Format(SErrFuncNotFound, ['SqlGsi']) );
  @SqlIdb := GetProcAddress(hSqlLibModule, 'sqlidb');  	ASSERT( @SqlIdb<>nil, Format(SErrFuncNotFound, ['SqlIdb']) );
  @SqlIms := GetProcAddress(hSqlLibModule, 'sqlims');  	ASSERT( @SqlIms<>nil, Format(SErrFuncNotFound, ['SqlIms']) );
  @SqlInd := GetProcAddress(hSqlLibModule, 'sqlind');  	ASSERT( @SqlInd<>nil, Format(SErrFuncNotFound, ['SqlInd']) );
  @SqlIni := GetProcAddress(hSqlLibModule, 'sqlini');  	ASSERT( @SqlIni<>nil, Format(SErrFuncNotFound, ['SqlIni']) );
  @SqlIns := GetProcAddress(hSqlLibModule, 'sqlins');  	ASSERT( @SqlIns<>nil, Format(SErrFuncNotFound, ['SqlIns']) );
  @SqlLab := GetProcAddress(hSqlLibModule, 'sqllab');  	ASSERT( @SqlLab<>nil, Format(SErrFuncNotFound, ['SqlLab']) );
  @SqlLdp := GetProcAddress(hSqlLibModule, 'sqlldp');  	ASSERT( @SqlLdp<>nil, Format(SErrFuncNotFound, ['SqlLdp']) );
  @SqlLsk := GetProcAddress(hSqlLibModule, 'sqllsk');  	ASSERT( @SqlLsk<>nil, Format(SErrFuncNotFound, ['SqlLsk']) );
  @SqlMcl := GetProcAddress(hSqlLibModule, 'sqlmcl');  	ASSERT( @SqlMcl<>nil, Format(SErrFuncNotFound, ['SqlMcl']) );
  @SqlMdl := GetProcAddress(hSqlLibModule, 'sqlmdl');  	ASSERT( @SqlMdl<>nil, Format(SErrFuncNotFound, ['SqlMdl']) );
  @SqlMop := GetProcAddress(hSqlLibModule, 'sqlmop');  	ASSERT( @SqlMop<>nil, Format(SErrFuncNotFound, ['SqlMop']) );
  @SqlMrd := GetProcAddress(hSqlLibModule, 'sqlmrd');  	ASSERT( @SqlMrd<>nil, Format(SErrFuncNotFound, ['SqlMrd']) );
  @SqlMsk := GetProcAddress(hSqlLibModule, 'sqlmsk');  	ASSERT( @SqlMsk<>nil, Format(SErrFuncNotFound, ['SqlMsk']) );
  @SqlMwr := GetProcAddress(hSqlLibModule, 'sqlmwr');  	ASSERT( @SqlMwr<>nil, Format(SErrFuncNotFound, ['SqlMwr']) );
  @SqlNbv := GetProcAddress(hSqlLibModule, 'sqlnbv');  	ASSERT( @SqlNbv<>nil, Format(SErrFuncNotFound, ['SqlNbv']) );
  @SqlNii := GetProcAddress(hSqlLibModule, 'sqlnii');  	ASSERT( @SqlNii<>nil, Format(SErrFuncNotFound, ['SqlNii']) );
  @SqlNrr := GetProcAddress(hSqlLibModule, 'sqlnrr');  	ASSERT( @SqlNrr<>nil, Format(SErrFuncNotFound, ['SqlNrr']) );
  @SqlNsi := GetProcAddress(hSqlLibModule, 'sqlnsi');  	ASSERT( @SqlNsi<>nil, Format(SErrFuncNotFound, ['SqlNsi']) );
  @SqlOms := GetProcAddress(hSqlLibModule, 'sqloms');  	ASSERT( @SqlOms<>nil, Format(SErrFuncNotFound, ['SqlOms']) );
  @SqlPrs := GetProcAddress(hSqlLibModule, 'sqlprs');  	ASSERT( @SqlPrs<>nil, Format(SErrFuncNotFound, ['SqlPrs']) );
  @SqlRbf := GetProcAddress(hSqlLibModule, 'sqlrbf');  	ASSERT( @SqlRbf<>nil, Format(SErrFuncNotFound, ['SqlRbf']) );
  @SqlRbk := GetProcAddress(hSqlLibModule, 'sqlrbk');  	ASSERT( @SqlRbk<>nil, Format(SErrFuncNotFound, ['SqlRbk']) );
  @SqlRcd := GetProcAddress(hSqlLibModule, 'sqlrcd');  	ASSERT( @SqlRcd<>nil, Format(SErrFuncNotFound, ['SqlRcd']) );
  @SqlRdb := GetProcAddress(hSqlLibModule, 'sqlrdb');  	ASSERT( @SqlRdb<>nil, Format(SErrFuncNotFound, ['SqlRdb']) );
  @SqlRdc := GetProcAddress(hSqlLibModule, 'sqlrdc');  	ASSERT( @SqlRdc<>nil, Format(SErrFuncNotFound, ['SqlRdc']) );
  @SqlRel := GetProcAddress(hSqlLibModule, 'sqlrel');  	ASSERT( @SqlRel<>nil, Format(SErrFuncNotFound, ['SqlRel']) );
  @SqlRes := GetProcAddress(hSqlLibModule, 'sqlres');  	ASSERT( @SqlRes<>nil, Format(SErrFuncNotFound, ['SqlRes']) );
  @SqlRet := GetProcAddress(hSqlLibModule, 'sqlret');  	ASSERT( @SqlRet<>nil, Format(SErrFuncNotFound, ['SqlRet']) );
  @SqlRlf := GetProcAddress(hSqlLibModule, 'sqlrlf');  	ASSERT( @SqlRlf<>nil, Format(SErrFuncNotFound, ['SqlRlf']) );
  @SqlRlo := GetProcAddress(hSqlLibModule, 'sqlrlo');  	ASSERT( @SqlRlo<>nil, Format(SErrFuncNotFound, ['SqlRlo']) );
  @SqlRof := GetProcAddress(hSqlLibModule, 'sqlrof');  	ASSERT( @SqlRof<>nil, Format(SErrFuncNotFound, ['SqlRof']) );
  @SqlRow := GetProcAddress(hSqlLibModule, 'sqlrow');  	ASSERT( @SqlRow<>nil, Format(SErrFuncNotFound, ['SqlRow']) );
  @SqlRrd := GetProcAddress(hSqlLibModule, 'sqlrrd');  	ASSERT( @SqlRrd<>nil, Format(SErrFuncNotFound, ['SqlRrd']) );
  @SqlRrs := GetProcAddress(hSqlLibModule, 'sqlrrs');  	ASSERT( @SqlRrs<>nil, Format(SErrFuncNotFound, ['SqlRrs']) );
  @SqlRsi := GetProcAddress(hSqlLibModule, 'sqlrsi');  	ASSERT( @SqlRsi<>nil, Format(SErrFuncNotFound, ['SqlRsi']) );
  @SqlRss := GetProcAddress(hSqlLibModule, 'sqlrss');  	ASSERT( @SqlRss<>nil, Format(SErrFuncNotFound, ['SqlRss']) );
  @SqlSab := GetProcAddress(hSqlLibModule, 'sqlsab');  	ASSERT( @SqlSab<>nil, Format(SErrFuncNotFound, ['SqlSab']) );
  @SqlSap := GetProcAddress(hSqlLibModule, 'sqlsap');  	ASSERT( @SqlSap<>nil, Format(SErrFuncNotFound, ['SqlSap']) );
  @SqlScl := GetProcAddress(hSqlLibModule, 'sqlscl');  	ASSERT( @SqlScl<>nil, Format(SErrFuncNotFound, ['SqlScl']) );
  @SqlScn := GetProcAddress(hSqlLibModule, 'sqlscn');  	ASSERT( @SqlScn<>nil, Format(SErrFuncNotFound, ['SqlScn']) );
  @SqlScp := GetProcAddress(hSqlLibModule, 'sqlscp');  	ASSERT( @SqlScp<>nil, Format(SErrFuncNotFound, ['SqlScp']) );
  @SqlSdn := GetProcAddress(hSqlLibModule, 'sqlsdn');  	ASSERT( @SqlSdn<>nil, Format(SErrFuncNotFound, ['SqlSdn']) );
  @SqlSds := GetProcAddress(hSqlLibModule, 'sqlsds');  	ASSERT( @SqlSds<>nil, Format(SErrFuncNotFound, ['SqlSds']) );
  @SqlSdx := GetProcAddress(hSqlLibModule, 'sqlsdx');  	ASSERT( @SqlSdx<>nil, Format(SErrFuncNotFound, ['SqlSdx']) );
  @SqlSet := GetProcAddress(hSqlLibModule, 'sqlset');  	ASSERT( @SqlSet<>nil, Format(SErrFuncNotFound, ['SqlSet']) );
  @SqlSil := GetProcAddress(hSqlLibModule, 'sqlsil');  	ASSERT( @SqlSil<>nil, Format(SErrFuncNotFound, ['SqlSil']) );
  @SqlSlp := GetProcAddress(hSqlLibModule, 'sqlslp');  	ASSERT( @SqlSlp<>nil, Format(SErrFuncNotFound, ['SqlSlp']) );
  @SqlSpr := GetProcAddress(hSqlLibModule, 'sqlspr');  	ASSERT( @SqlSpr<>nil, Format(SErrFuncNotFound, ['SqlSpr']) );
  @SqlSrf := GetProcAddress(hSqlLibModule, 'sqlsrf');  	ASSERT( @SqlSrf<>nil, Format(SErrFuncNotFound, ['SqlSrf']) );
  @SqlSrs := GetProcAddress(hSqlLibModule, 'sqlsrs');  	ASSERT( @SqlSrs<>nil, Format(SErrFuncNotFound, ['SqlSrs']) );
  @SqlSsb := GetProcAddress(hSqlLibModule, 'sqlssb');  	ASSERT( @SqlSsb<>nil, Format(SErrFuncNotFound, ['SqlSsb']) );
  @SqlSss := GetProcAddress(hSqlLibModule, 'sqlsss');  	ASSERT( @SqlSss<>nil, Format(SErrFuncNotFound, ['SqlSss']) );
  @SqlSta := GetProcAddress(hSqlLibModule, 'sqlsta');  	ASSERT( @SqlSta<>nil, Format(SErrFuncNotFound, ['SqlSta']) );
  @SqlStm := GetProcAddress(hSqlLibModule, 'sqlstm');  	ASSERT( @SqlStm<>nil, Format(SErrFuncNotFound, ['SqlStm']) );
  @SqlSto := GetProcAddress(hSqlLibModule, 'sqlsto');  	ASSERT( @SqlSto<>nil, Format(SErrFuncNotFound, ['SqlSto']) );
  @SqlStr := GetProcAddress(hSqlLibModule, 'sqlstr');  	ASSERT( @SqlStr<>nil, Format(SErrFuncNotFound, ['SqlStr']) );
  @SqlSxt := GetProcAddress(hSqlLibModule, 'sqlsxt');  	ASSERT( @SqlSxt<>nil, Format(SErrFuncNotFound, ['SqlSxt']) );
  @SqlTec := GetProcAddress(hSqlLibModule, 'sqltec');  	ASSERT( @SqlTec<>nil, Format(SErrFuncNotFound, ['SqlTec']) );
  @SqlTem := GetProcAddress(hSqlLibModule, 'sqltem');  	ASSERT( @SqlTem<>nil, Format(SErrFuncNotFound, ['SqlTem']) );
  @SqlTio := GetProcAddress(hSqlLibModule, 'sqltio');  	ASSERT( @SqlTio<>nil, Format(SErrFuncNotFound, ['SqlTio']) );
  @SqlUnl := GetProcAddress(hSqlLibModule, 'sqlunl');  	ASSERT( @SqlUnl<>nil, Format(SErrFuncNotFound, ['SqlUnl']) );
  @SqlUrs := GetProcAddress(hSqlLibModule, 'sqlurs');  	ASSERT( @SqlUrs<>nil, Format(SErrFuncNotFound, ['SqlUrs']) );
  @SqlWdc := GetProcAddress(hSqlLibModule, 'sqlwdc');  	ASSERT( @SqlWdc<>nil, Format(SErrFuncNotFound, ['SqlWdc']) );
  @SqlWlo := GetProcAddress(hSqlLibModule, 'sqlwlo');  	ASSERT( @SqlWlo<>nil, Format(SErrFuncNotFound, ['SqlWlo']) );
  @SqlXad := GetProcAddress(hSqlLibModule, 'sqlxad');  	ASSERT( @SqlXad<>nil, Format(SErrFuncNotFound, ['SqlXad']) );
  @SqlXcn := GetProcAddress(hSqlLibModule, 'sqlxcn');  	ASSERT( @SqlXcn<>nil, Format(SErrFuncNotFound, ['SqlXcn']) );
  @SqlXda := GetProcAddress(hSqlLibModule, 'sqlxda');  	ASSERT( @SqlXda<>nil, Format(SErrFuncNotFound, ['SqlXda']) );
  @SqlXdp := GetProcAddress(hSqlLibModule, 'sqlxdp');  	ASSERT( @SqlXdp<>nil, Format(SErrFuncNotFound, ['SqlXdp']) );
  @SqlXdv := GetProcAddress(hSqlLibModule, 'sqlxdv');  	ASSERT( @SqlXdv<>nil, Format(SErrFuncNotFound, ['SqlXdv']) );
  @SqlXer := GetProcAddress(hSqlLibModule, 'sqlxer');  	ASSERT( @SqlXer<>nil, Format(SErrFuncNotFound, ['SqlXer']) );
  @SqlXml := GetProcAddress(hSqlLibModule, 'sqlxml');  	ASSERT( @SqlXml<>nil, Format(SErrFuncNotFound, ['SqlXml']) );
  @SqlXnp := GetProcAddress(hSqlLibModule, 'sqlxnp');  	ASSERT( @SqlXnp<>nil, Format(SErrFuncNotFound, ['SqlXnp']) );
  @SqlXpd := GetProcAddress(hSqlLibModule, 'sqlxpd');  	ASSERT( @SqlXpd<>nil, Format(SErrFuncNotFound, ['SqlXpd']) );
  @SqlXsb := GetProcAddress(hSqlLibModule, 'sqlxsb');  	ASSERT( @SqlXsb<>nil, Format(SErrFuncNotFound, ['SqlXsb']) );
  // for SQLBase 7.0 - ASSERT not neñessary, that may be load SQLBase 6.0 library
  @SqlCch := GetProcAddress(hSqlLibModule, 'sqlcch');
  @SqlDch := GetProcAddress(hSqlLibModule, 'sqldch');
  @SqlOpc := GetProcAddress(hSqlLibModule, 'sqlopc');
{$ENDIF}
end;

procedure ResetProcAddresses;
begin
{$IFNDEF XSQL_CLR}
  @SqlArf := nil;
  @SqlBbr := nil;
  @SqlBdb := nil;
  @SqlBef := nil;
  @SqlBer := nil;
  @SqlBkp := nil;
  @SqlBld := nil;
  @SqlBlf := nil;
  @SqlBlk := nil;
  @SqlBln := nil;
  @SqlBna := nil;
  @SqlBnd := nil;
  @SqlBnn := nil;
  @SqlBnu := nil;
  @SqlBss := nil;
  @SqlCan := nil;
  @SqlCbv := nil;
  @SqlCdr := nil;
  @SqlCex := nil;
  @SqlClf := nil; 
  @SqlCmt := nil; 
  @SqlCnc := nil; 
  @SqlCnr := nil;
  @SqlCom := nil;
  @SqlCon := nil;
  @SqlCpy := nil; 
  @SqlCre := nil;
  @SqlCrf := nil; 
  @SqlCrs := nil;
  @SqlCsv := nil;
  @SqlCty := nil;
  @SqlDbn := nil; 
  @SqlDed := nil; 
  @SqlDel := nil; 
  @SqlDes := nil; 
  @SqlDid := nil; 
  @SqlDii := nil; 
  @SqlDin := nil; 
  @SqlDir := nil; 
  @SqlDis := nil;
  @SqlDon := nil;
  @SqlDox := nil;
  @SqlDrc := nil; 
  @SqlDro := nil; 
  @SqlDrr := nil; 
  @SqlDrs := nil; 
  @SqlDsc := nil; 
  @SqlDst := nil;
  @SqlDsv := nil;
  @SqlEbk := nil; 
  @SqlEfb := nil;
  @SqlElo := nil; 
  @SqlEnr := nil;
  @SqlEpo := nil; 
  @SqlErf := nil;
  @SqlErr := nil;
  @SqlErs := nil;
  @SqlEtx := nil;
  @SqlExe := nil;
  @SqlExp := nil;
  @SqlFbk := nil;
  @SqlFer := nil;
  @SqlFet := nil;
  @SqlFgt := nil;
  @SqlFpt := nil;
  @SqlFqn := nil;
  @SqlGbi := nil;
  @SqlGdi := nil;
  @SqlGet := nil;
  @SqlGfi := nil;
  @SqlGls := nil;
  @SqlGnl := nil;
  @SqlGnr := nil;
  @SqlGsi := nil;
  @SqlIdb := nil;
  @SqlIms := nil;
  @SqlInd := nil;
  @SqlIni := nil;
  @SqlIns := nil;
  @SqlLab := nil; 
  @SqlLdp := nil; 
  @SqlLsk := nil; 
  @SqlMcl := nil; 
  @SqlMdl := nil;
  @SqlMop := nil; 
  @SqlMrd := nil;
  @SqlMsk := nil; 
  @SqlMwr := nil; 
  @SqlNbv := nil;
  @SqlNii := nil; 
  @SqlNrr := nil; 
  @SqlNsi := nil;
  @SqlOms := nil;
  @SqlPrs := nil; 
  @SqlRbf := nil;
  @SqlRbk := nil; 
  @SqlRcd := nil;
  @SqlRdb := nil;
  @SqlRdc := nil; 
  @SqlRel := nil;
  @SqlRes := nil; 
  @SqlRet := nil;
  @SqlRlf := nil;
  @SqlRlo := nil;
  @SqlRof := nil; 
  @SqlRow := nil; 
  @SqlRrd := nil; 
  @SqlRrs := nil; 
  @SqlRsi := nil;
  @SqlRss := nil;
  @SqlSab := nil; 
  @SqlSap := nil; 
  @SqlScl := nil;
  @SqlScn := nil; 
  @SqlScp := nil;
  @SqlSdn := nil; 
  @SqlSds := nil; 
  @SqlSdx := nil; 
  @SqlSet := nil; 
  @SqlSil := nil;
  @SqlSlp := nil; 
  @SqlSpr := nil;
  @SqlSrf := nil; 
  @SqlSrs := nil;
  @SqlSsb := nil; 
  @SqlSss := nil;
  @SqlSta := nil; 
  @SqlStm := nil; 
  @SqlSto := nil; 
  @SqlStr := nil; 
  @SqlSxt := nil;
  @SqlTec := nil; 
  @SqlTem := nil;
  @SqlTio := nil;
  @SqlUnl := nil; 
  @SqlUrs := nil; 
  @SqlWdc := nil; 
  @SqlWlo := nil;
  @SqlXad := nil; 
  @SqlXcn := nil;
  @SqlXda := nil; 
  @SqlXdp := nil;
  @SqlXdv := nil;
  @SqlXer := nil;
  @SqlXml := nil;
  @SqlXnp := nil;
  @SqlXpd := nil;
  @SqlXsb := nil;
  // for SQLBase 7.0
  @SqlCch := nil;
  @SqlDch := nil;
  @SqlOpc := nil;
{$ENDIF}
end;

procedure LoadSqlLib;
var
  sFileName: string;
begin
  SqlLibLock.Acquire;
  try
    if (SqlLibRefCount = 0) then begin
      sFileName := SqlApiDll;
      hSqlLibModule := HelperLoadLibrary( sFileName );
      if (hSqlLibModule = 0) then
        raise ESDSqlLibError.CreateFmt(SErrLibLoading, [ sFileName ]);
      Inc(SqlLibRefCount);
      SetProcAddresses;
    	// if 1-st loading SQL-library and call not from DLL
      if not IsLibrary then
        if SqlIni(nil) <> 0 then
          raise ESDSqlLibError.Create(SErrLibInit);
      dwLoadedFileVer := GetFileVersion( sFileName );
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
      if not IsLibrary then
        SqlDon;

      if FreeLibrary(hSqlLibModule) then
        hSqlLibModule := 0
      else
        raise ESDSqlLibError.CreateFmt(SErrLibUnloading, [ GetModuleFileNameStr(hSqlLibModule) ]);
      Dec(SqlLibRefCount);
      ResetProcAddresses;
      dwLoadedFileVer := 0;
    end else
      Dec(SqlLibRefCount);
  finally
    SqlLibLock.Release;
  end;
end;


{-------------------------------------------------------------------------------
 			call Centura SQLBase API
-------------------------------------------------------------------------------}
constructor TICsbDatabase.Create(ADbParams: TStrings);
begin
  inherited Create(ADbParams);

  FHandle 	:= nil;
  FProcSupportsCursors := False;
  	// by default FTransLogging = True
  FIsTransLogging := UpperCase( Trim( Params.Values[szTRANSLOGGING] ) ) <> SFalseString;
end;

destructor TICsbDatabase.Destroy;
begin
  FreeHandle;

  if AcquiredHandle then
    FreeSqlLib;
  
  inherited Destroy;
end;

function TICsbDatabase.CreateSqlCommand: TISqlCommand;
begin
  Result := TICsbCommand.Create( Self );
end;

procedure TICsbDatabase.Check(Status: TSDEResult);
begin
  ResetIdleTimeOut;
  if Status = 0 then
    Exit;
  ResetBusyState;
  CSBError(0, Status, -1);
end;

function TICsbDatabase.GetHandle: TSDPtr;
begin
  Result := FHandle;
end;

procedure TICsbDatabase.SetHandle(AHandle: TSDPtr);
{$IFDEF XSQL_CLR}
var
  r1, r2: TICsbConnInfo;
{$ENDIF}
begin
  LoadSqlLib;

  AllocHandle;

{$IFDEF XSQL_CLR}
  r1 := TICsbConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TICsbConnInfo) ) );
  r2 := TICsbConnInfo( Marshal.PtrToStructure( AHandle, TypeOf(TICsbConnInfo) ) );
  r1.hLogon	:= r2.hLogon;
  r1.hCursor	:= r2.hCursor;
  r1.ConnectStr := r2.ConnectStr;
  Marshal.StructureToPtr(r1, FHandle, False);
{$ELSE}
  TICsbConnInfo(FHandle^).hLogon	:= TICsbConnInfo(AHandle^).hLogon;
  TICsbConnInfo(FHandle^).hCursor	:= TICsbConnInfo(AHandle^).hCursor;
  TICsbConnInfo(FHandle^).ConnectStr    := TICsbConnInfo(AHandle^).ConnectStr;
{$ENDIF}
end;

function TICsbDatabase.GetConnectStr: string;
begin
  ASSERT( Assigned(FHandle), 'TICsbDatabase.GetConnectStr' );
{$IFDEF XSQL_CLR}
  Result := TICsbConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TICsbConnInfo) ) ).ConnectStr;
{$ELSE}
  Result := TICsbConnInfo(FHandle^).ConnectStr;
{$ENDIF}
end;

function TICsbDatabase.GetCurHandle: TCSBCursor;
begin
  ASSERT( Assigned(FHandle), 'TICsbDatabase.GetCurHandle' );
{$IFDEF XSQL_CLR}
  Result := TICsbConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TICsbConnInfo) ) ).hCursor;
{$ELSE}
  Result := TICsbConnInfo(FHandle^).hCursor;
{$ENDIF}
end;

function TICsbDatabase.GetLogHandle: TCSBLogon;
begin
  ASSERT( Assigned(FHandle), 'TICsbDatabase.GetLogHandle' );
{$IFDEF XSQL_CLR}
  Result := TICsbConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TICsbConnInfo) ) ).hLogon;
{$ELSE}
  Result := TICsbConnInfo(FHandle^).hLogon;
{$ENDIF}
end;

procedure TICsbDatabase.AllocHandle;
var
  rec: TICsbConnInfo;
begin
  ASSERT( not Assigned(FHandle), 'TICsbDatabase.AllocHandles' );

  FHandle := SafeReallocMem(nil, SizeOf(rec));
  SafeInitMem( FHandle, SizeOf(rec), 0 );

  rec.ServerType := Ord( istSQLBase );
  rec.hLogon := 0;
  rec.hCursor:= 0;

{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TICsbConnInfo(FHandle^) := rec;
{$ENDIF}
end;

procedure TICsbDatabase.FreeHandle;
begin
  if Assigned(FHandle) then begin
{$IFNDEF XSQL_CLR}
    TICsbConnInfo(FHandle^).ConnectStr := '';
{$ENDIF}
    FHandle := SafeReallocMem( FHandle, 0 );
  end;
end;

function TICsbDatabase.UseConnHandle: Boolean;
begin
  Result := XSCsb.IsVersion7 and IsTransLogging;
end;

{ if SQLBase6, then FCurHandle = FHandle }
procedure TICsbDatabase.DoConnect(const sRemoteDatabase, sUserName, sPassword: string);
var
  rec: TICsbConnInfo;
  pConnectStr: TSDPtr;
begin
  LoadSqlLib;

  AllocHandle;

{$IFDEF XSQL_CLR}
  rec := TICsbConnInfo( Marshal.PtrToStructure( FHandle, TypeOf(TICsbConnInfo) ) );
  rec.ConnectStr := SDCsb.CreateConnectString(sRemoteDatabase, sUserName, sPassword);
  pConnectStr := Marshal.StringToHGlobalAnsi(rec.ConnectStr);
{$ELSE}
  rec := TICsbConnInfo(FHandle^);
  rec.ConnectStr := XSCsb.CreateConnectString(sRemoteDatabase, sUserName, sPassword);
  pConnectStr := PChar(rec.ConnectStr);
{$ENDIF}
  try
    if UseConnHandle then begin
      Check( SqlCch(rec.hLogon, pConnectStr, 0, 0) );
      Check( SqlOpc(rec.hCursor, rec.hLogon, 0) );
    end else
      if IsTransLogging then
        Check( SqlCnc(rec.hCursor, pConnectStr, 0) )
      else
        Check( SqlCnr(rec.hCursor, pConnectStr, 0) );	// connect with no recovery
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal(pConnectStr);
{$ENDIF}
  end;

{$IFDEF XSQL_CLR}
  Marshal.StructureToPtr( rec, FHandle, False );
{$ELSE}
  TICsbConnInfo(FHandle^) := rec;
{$ENDIF}

  SetDefaultOptions;
end;

procedure TICsbDatabase.DoDisconnect(Force: Boolean);
begin
  if not Assigned(FHandle) then
    Exit;

  if InTransaction then
    Check( SqlRbk(CurHandle) );
	// by default COMMIT is performed before the cursor is disconnected
  SqlDis( CurHandle );
//  TICsbConnInfo(FHandle^).hCursor:= 0;
  if UseConnHandle then begin
    SqlDch( LogHandle );
//    TICsbConnInfo(FHandle^).hLogon := 0;
  end;

  FreeHandle;
  FreeSqlLib;
end;

procedure TICsbDatabase.DoStartTransaction;
begin
  // nothing
end;

procedure TICsbDatabase.DoCommit;
begin
  Check( SqlCmt(CurHandle) );
end;

procedure TICsbDatabase.DoRollback;
begin
  Check( SqlRbk(CurHandle) );
end;

function TICsbDatabase.SPDescriptionsAvailable: Boolean;
begin
  Result := False;
end;

procedure TICsbDatabase.SetAutoCommitOption(Value: Boolean);
{var
  i: Integer;
  V: SqlTDpv;}
begin
{ ??? for i:=0 to Database.DataSetCount-1 do begin
    if Value
    then V := 1
    else V := 0;
    Check( SqlSet(PCSBCursor(Database.DataSets[i].Handle)^, SQLPAUT, SqlTDap(@V), 0) );
  end;
}
end;

procedure TICsbDatabase.SetDefaultOptions;
var
  sTimeout: string;
  V: SqlTDpv;
begin
  SetTransIsolation(TransIsolation);
  SetNullIndicatorError(True);

	// set command (and lock) timeout value, if it's set
  sTimeout := Trim( Params.Values[szCMDTIMEOUT] );
  if sTimeout <> '' then begin
    V := StrToIntDef( sTimeout, 0 );
    	// set lock timeout
    Check( CsbSqlSet(CurHandle, SQLPWTO, V) );
	// it affects on execution time only, i.e. if the command is locked it is not returned
    Check( CsbSqlSet(CurHandle, SQLPCTL, V) );
  end;
end;

{ Set state NULL-indicator after fetch of fields }
procedure TICsbDatabase.SetNullIndicatorError(Value: Boolean);
var
  v: LongInt;
  ptr: TSDPtr;
begin
  if Value
  then v := 1
  else v := 0;
  ptr := SafeReallocMem(nil, SizeOf(v));
  try
    HelperMemWriteInt32(ptr, 0, v);
    Check( SqlSet(0, SqlPNie, ptr, SizeOf(v)) );
  finally
    SafeReallocMem(ptr, 0);
  end;
end;

procedure TICsbDatabase.ChangePreservedProps;
begin
  FCursorPreservedOnCommit	:= True;
  	// tiDirtyRead = RL isolation level of SQLBase
  FCursorPreservedOnRollback 	:= TransIsolation = itiDirtyRead;
end;

procedure TICsbDatabase.SetTransIsolation(Value: TISqlTransIsolation);
const
  IsolLevel: array[TISqlTransIsolation] of string = (SQLILRL, SQLILCS, SQLILRR);
var
  ptr: TSDPtr;
begin
{$IFDEF XSQL_CLR}
  ptr := Marshal.StringToHGlobalAnsi(IsolLevel[Value]);
{$ELSE}
  ptr := PChar(IsolLevel[Value]);
{$ENDIF}
  try
    Check( SqlSil(CurHandle, ptr) );
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal(ptr);
{$ENDIF}
  end;

  ChangePreservedProps;
end;

function TICsbDatabase.GetClientVersion: LongInt;
begin
  Result := dwLoadedFileVer;
end;

function TICsbDatabase.GetServerVersion: LongInt;
var
  szVer: TSDPtr;
  Len: SqlTDal;
begin
  Len := SQLMFNL;
  szVer := SafeReAllocMem( nil, Len );
  try
    SafeInitMem( szVer, Len, 0 );
    Check( SqlGet(CurHandle, SQLPVER, szVer, Len) );
    Result := VersionStringToDWORD( HelperPtrToString(szVer) );
  finally
    SafeReallocMem( szVer, 0 );
  end;
end;

function TICsbDatabase.GetVersionString: string;
var
  ptr: TSDPtr;
  Len: SqlTDal;
  brand: SQLTDPV;
begin
  Len := SQLMFNL;
  ptr := SafeReAllocMem( nil, Len );
  try
    SafeInitMem( ptr, Len, 0 );
    Check( SqlGet(CurHandle, SQLPBRN, ptr, Len) );
    brand := HelperMemReadInt32(ptr, 0);
    Result := GetBrandName( brand );
    if brand = SQLBSQB then begin
      Check( SqlGet(CurHandle, SQLPVER, ptr, Len) );
      Result := Result + ' Release ' + HelperPtrToString(ptr);
    end;
  finally
    SafeReallocMem( ptr, 0 );
  end;
end;

function TICsbDatabase.GetSchemaInfo(ASchemaType: TSDSchemaType; AObjectName: string): TISqlCommand;
const
	// SQLBase has only commands and procedures and do not have functions
  SQueryCsbStoredProcNamesFmt =
	'select '''' as '+CAT_NAME_FIELD+', CREATOR as '+SCH_NAME_FIELD+
        ', NAME as '+PROC_NAME_FIELD+', 1 as '+PROC_TYPE_FIELD+
        ' from SYSSQL.SYSCOMMANDS where SYSTEM <> ''Y'' %s order by CREATOR, NAME';
  SQueryCsbTableNamesFmt =
  	'select '''' as '+CAT_NAME_FIELD+', CREATOR as '+SCH_NAME_FIELD+
        ', NAME as '+TBL_NAME_FIELD+', 1 as '+TBL_TYPE_FIELD+
        ' from SYSSQL.SYSTABLES %s order by CREATOR, NAME';
  SQueryCsbTableFieldNamesFmt =
    	'select '''' as '+CAT_NAME_FIELD+', TBCREATOR as '+SCH_NAME_FIELD+
        ', TBNAME as '+TBL_NAME_FIELD+', NAME as '+COL_NAME_FIELD+
        ', COLNO as '+COL_POS_FIELD+', 0 as '+COL_TYPE_FIELD+
        ', COLTYPE as '+COL_TYPENAME_FIELD+', LENGTH as '+COL_LENGTH_FIELD+
        ', LENGTH as '+COL_PREC_FIELD+', SCALE as '+COL_SCALE_FIELD+
        ', @DECODE(NULLS, ''Y'', 1, 0) as '+COL_NULLABLE_FIELD+
        ' from SYSSQL.SYSCOLUMNS where @UPPER(TBCREATOR) like @UPPER(''%s'') and @UPPER(TBNAME) like @UPPER(''%s'') '+
        'order by TBCREATOR, TBNAME, COLNO';
  SQueryCsbIndexNamesFmt =
	'select '''' as '+CAT_NAME_FIELD+', TBCREATOR as '+SCH_NAME_FIELD+
        ', TBNAME as '+TBL_NAME_FIELD+', IND.NAME as '+IDX_NAME_FIELD+
        ', COLNAME as '+IDX_COL_NAME_FIELD+', COLNO as '+IDX_COL_POS_FIELD+
	', @DECODE(UNIQUERULE, ''U'', 2, 1) as '+IDX_TYPE_FIELD+
        ', ORDERING as '+IDX_SORT_FIELD+', FUNCTION as '+IDX_FILTER_FIELD+
	' from SYSSQL.SYSINDEXES IND, SYSSQL.SYSKEYS INDC '+
        'where IND.NAME = INDC.IXNAME and @UPPER(TBCREATOR) like @UPPER(''%s'') and @UPPER(TBNAME) like @UPPER(''%s'') '+
        'order by TBCREATOR, TBNAME, IND.NAME, COLNO';

  function WhereAnd(const s: string): string;
  begin
    if Trim(s) = '' then
      Result := ' where '
    else
      Result := ' and ';
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
        if AObjectName <> '' then
          sStmt := sStmt + WhereAnd(sStmt) + 'NAME like ''' + AObjectName + ''' ';
        if ASchemaType = stSysTables then
           sStmt := sStmt + WhereAnd(sStmt) + 'SYSTEM = ''Y'' '
        else
          sStmt := sStmt + WhereAnd(sStmt) + 'SYSTEM <> ''Y'' ';
        sStmt := Format(SQueryCsbTableNamesFmt, [sStmt]);
      end;
    stColumns:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryCsbTableFieldNamesFmt, [sOwner, sObj] );
      end;
    stProcedures:
      begin
        if AObjectName <> '' then
          sStmt := sStmt + 'and NAME like ''' + AObjectName + ''' ';
        sStmt := Format(SQueryCsbStoredProcNamesFmt, [sStmt]);
      end;
    stIndexes:
      begin
        ExtractOwnerObjNames(AObjectName, sOwner, sObj);
        sStmt := Format(SQueryCsbIndexNamesFmt, [sOwner, sObj]);
      end;
  end;

  cmd := CreateSqlCommand;
  cmd.ExecDirect( sStmt );

  Result := cmd;
end;

function TICsbDatabase.TestConnected: Boolean;
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

function TICsbDatabase.ParamValue(Value: TXSQLDatabaseParam): Integer;
begin
  case Value of
    spMaxBindName: 	Result := SQLMBNL;
    spMaxClientName:	Result := SQLMCLN;
    spMaxConnectString:	Result := SQLMCST;
    spMaxDatabaseName:	Result := SQLMDNM;
    spMaxErrorMessage:	Result := SQLMERR;
    spMaxErrorText:	Result := SQLMETX;
    spMaxExtErrorMessage:Result := SQLMXER;
    spMaxJoinedTables:	Result := SQLMJTB;
    spLongIdentifiers:	Result := SQLMLID;
    spShortIdentifiers:	Result := SQLMSID;
    spMaxUserName:	Result := SQLMUSR;
    spMaxPasswordString:Result := SQLMPWD;
    spMaxServerName:	Result := SQLMSNM;
    spMaxFieldName,
    spMaxTableName,
    spMaxSPName:	Result := SQLMBNL;
    spMaxFullTableName,
    spMaxFullSPName:	Result := SQLMBNL;
  else
    Result := 0;
  end;
end;


{ TICsbCommand }
constructor TICsbCommand.Create(ASqlDatabase: TISqlDatabase);
begin
  inherited Create(ASqlDatabase);
        // read block must be less < $8000 (32768)
  FBlobPieceSize := ASqlDatabase.BlobPieceSize;
  if FBlobPieceSize > DEF_BLOB_PIECE_SIZE then
    FBlobPieceSize := DEF_BLOB_PIECE_SIZE;
  FRowFetched := False;
  FHandle := nil;
end;

destructor TICsbCommand.Destroy;
begin
  Disconnect(False);

  inherited;
end;

function TICsbCommand.GetHandle: PSDCursor;
begin
  Result := FHandle;
end;

function TICsbCommand.GetSqlDatabase: TICsbDatabase;
begin
  Result := (inherited SqlDatabase) as TICsbDatabase;
end;

procedure TICsbCommand.Check(Status: TSDEResult);
var
  epo: SQLTEPO;
  ErrPos: LongInt;
begin
  SqlDatabase.ResetIdleTimeOut;
  if Status = 0 then
    Exit;
  epo := 0;
  ErrPos := -1;
  if SqlEpo( CurHandle, epo ) = 0 then
    ErrPos := epo;
  SqlDatabase.ResetBusyState;
  CsbError(0, Status, ErrPos);
end;

function TICsbCommand.GetCurHandle: TCSBCursor;
begin
  Result := HelperMemReadInt16(FHandle, 0);
end;

procedure TICsbCommand.Connect;
var
  cur: TCSBCursor;
  pConnectStr: TSDPtr;
begin
  if FHandle <> nil then Exit;

  FHandle := SafeReallocMem( nil, SizeOf(TCSBCursor) );
  SafeInitMem( FHandle, SizeOf(TCSBCursor), 0 );

  try
    if SqlDatabase.UseConnHandle then
      Check( SqlOpc(cur, SqlDatabase.LogHandle, 0) )
    else try
{$IFDEF XSQL_CLR}
      pConnectStr := Marshal.StringToHGlobalAnsi(SqlDatabase.ConnectStr);
{$ELSE}
      pConnectStr := PChar(SqlDatabase.ConnectStr);
{$ENDIF}
      if SqlDatabase.IsTransLogging then
        Check( SqlCnc(cur, pConnectStr, 0) )
      else
        Check( SqlCnr(cur, pConnectStr, 0) );	//  connect with no recovery
    finally
{$IFDEF XSQL_CLR}
      Marshal.FreeHGlobal(pConnectStr);
{$ENDIF}
    end;
    HelperMemWriteInt16(FHandle, 0, Cur);
    SetDefaultParams;
  except
    FHandle := SafeReallocMem(FHandle, 0);
    raise;
  end;
end;

{ Since prepared statements could be destroyed in case of rollback/commit,
it is necessary to restore that.
  It's advisable to call at the begin of the following methods:
GetFieldDescs, Execute, ResultSetExists, QBindParams, SpBindParams }
procedure TICsbCommand.CheckPrepared;
begin
  if Assigned( FHandle ) then
    Exit;
	// The code is running, when Prepared is True, but cursor is destroyed by rollback/commit
    ASSERT( False );
{ ??? Check in TSDDataSet
  if (DataSet is TXSQLQuery) and TXSQLQuery(DataSet).Prepared then
    QPrepareSQL( PChar(TXSQLQuery(DataSet).SQL.Text) )
  else if (DataSet is TXSQLStoredProc) and TXSQLStoredProc(DataSet).Prepared then
    SpPrepareProc;
  }
end;

procedure TICsbCommand.CloseResultSet;
begin
  ClearBindParams;
end;

procedure TICsbCommand.Disconnect(Force: Boolean);
var
  rcd: TSDEResult;
begin
  if FHandle = nil then Exit;

  rcd := SqlDis(CurHandle);
  if not Force then
    Check( rcd );

  if FieldsBuffer <> nil then
    FreeFieldsBuffer;

  FHandle := SafeReallocMem( FHandle, 0 );
end;

procedure TICsbCommand.ClearBindParams;
begin
  if FHandle <> nil then
    Check( SqlCbv(CurHandle) );
end;

function TICsbCommand.ResultSetExists: Boolean;
var
  CmdType: SqlTCty;
begin
  CheckPrepared;

  Check( SqlCty(CurHandle, CmdType) );
  Result := CmdType in [SQLTSEL];
end;

function TICsbCommand.FieldDataType(ExtDataType: Integer): TFieldType;
const
  { Converting from External Data Type (SQLBase) -> TFieldType }
  FieldDataTypeMap: array[0..SqlELVR] of TFieldType = (    ftUnknown,
  	ftInteger, ftSmallInt, ftFloat, ftString, ftString,
        ftBlob, ftFloat, ftDate, ftTime, ftDateTime,
	ftUnknown, ftFloat, ftUnknown, ftUnknown, ftUnknown,
        ftUnknown, ftUnknown, ftBlob, ftBoolean, ftMemo,
        ftMemo  );
begin
  Result := FieldDataTypeMap[ExtDataType];
end;

function TICsbCommand.NativeDataSize(FieldType: TFieldType): Word;
const
  { Converting from TFieldType â Program Data Type(SQLBase) }
  SQLBaseDataSizeMap: array[TFieldType] of SqlTPdt = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	0,	2, 	4, 	2, 	2,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        8, 	8, 	0, 	SqlSDte, SqlSTim,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SqlSDat, 	0, 	0, 	0, 	0,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        0,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
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
  Result := SQLBaseDataSizeMap[FieldType];
end;

function TICsbCommand.NativeDataType(FieldType: TFieldType): Integer;
const
  { Converting from TFieldType â Program Data Type(SQLBase) }
  SQLBaseDataTypeMap: array[TFieldType] of Integer = ( 0,	// ftUnknown
	// ftString, ftSmallint, ftInteger, ftWord, ftBoolean
	SqlPStr, SqlPSsh, SqlPSlo, SqlPUsh, SqlPUsh,
	// ftFloat, ftCurrency, ftBCD, ftDate, ftTime
        SqlPDou, SqlPDou, 0, SqlPDte, SqlPTim,
        // ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftBlob
        SqlPDat, 	0, 	0, 		0, 	SqlPLbi,
        // ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle
        SqlPLon,	0,	0,	0,	0,
        // ftTypedBinary, ftCursor
        0,	0
{$IFDEF XSQL_VCL4},
	// ftFixedChar, ftWideString, ftLargeint,
        0,	0,	0,
        // ftADT, ftArray, ftReference, ftDataSet
        0,	0,	0,	0
{$ENDIF}
{$IFDEF XSQL_VCL5},
        // ftOraBlob, ftOraClob, ftVariant,
        0,	0,	0,
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
  Result := SQLBaseDataTypeMap[FieldType];
end;

procedure TICsbCommand.GetFieldDescs(Descs: TSDFieldDescList);
var
  p: Integer;
  ft: TFieldType;
  Col, FieldNumber: SqlTNsi;
  szColHeading: TSDCharPtr;
  ColHeadingL: SqlTChL;
  ExtDataType: SqlTDdt;		ExtDataTypeL: SqlTDdl;
  Prec: SqlTPre;		Scale: SqlTSca;
  MaxColumnName: Integer;
  gdi: TGdiDef;
  bRequiredAvail: Boolean;
begin
  CheckPrepared;

	// get count of select list item
  Check( SqlNsi(CurHandle, FieldNumber) );
	// a column name may up 255, for example, in case of complex expression with string and functions: select ..RIGHT('...', 1)
  MaxColumnName := SqlDatabase.ParamValue(spMaxFieldName)*3;
  szColHeading := SafeReallocMem( nil, MaxColumnName + 1 );

  try
    for Col:=1 to FieldNumber do begin
      Check( SqlDsc(CurHandle, Col, ExtDataType, ExtDataTypeL, szColHeading, ColHeadingL, Prec, Scale) );
      if MaxColumnName < ColHeadingL then begin
        HelperMemWriteByte(szColHeading, MaxColumnName, 0);
        DatabaseErrorFmt(SInsufficientColNameBufSizeFmt, [HelperPtrToString(szColHeading)]);
      end;
      HelperMemWriteByte(szColHeading, ColHeadingL, 0);
        // SQLBase v7: sqlgdi (it returns Nullable value) raises AV,
        // when a column/alias name (with functions) is more 60 bytes (size of TGdiDef.gdichb is 47 byte )
      bRequiredAvail := ColHeadingL <= SizeOf(gdi.gdichb);
      if bRequiredAvail then begin
        gdi.gdicol := Col;
        // SqlGdi returns an error after sqlcex call (checked with SQLBase7)
        bRequiredAvail := SqlGdi(CurHandle, gdi) = 0;
      end;

      ft := FieldDataType(ExtDataType);
      if ft = ftUnknown then
        DatabaseErrorFmt( SBadFieldType, [szColHeading] );
      	// data size has to include zero-terminator for CHAR/VARCHAR fields
      if ft = ftString then
        Inc(ExtDataTypeL);
        // ExtDataTypeL returns 3-10 byte, what can produce for TIMESTAMP column error "00102: STS Select buffer too small"
      if IsDateTimeType(ft) then
        ExtDataTypeL := SqlSDat;
      with Descs.AddFieldDesc do begin
        FieldName	:= HelperPtrToString(szColHeading);
        	// exclude Alias for table in a FieldName (table alias is returned only by SQLBase)
        p := Pos('.', FieldName);
        if (p > 0) and (p < Length(FieldName)) then
          FieldName := Copy( FieldName, p+1, Length(FieldName)-p);
        FieldType	:= ft;
        DataType	:= ExtDataType;
        if IsRequiredSizeTypes( ft ) then
          DataSize	:= ExtDataTypeL
        else
          DataSize	:= NativeDataSize(ft);
        Precision	:= Prec;
    	// if gdi.gdinul = 0 then null values are not permitted for the column (Required = True)
        if bRequiredAvail then
          Required	:= (gdi.gdinul and $00FF) = 0
        else
          Required      := True;
      end;
    end;
  finally
    SafeReallocMem(szColHeading, 0);
  end;
end;

// Sets buffers for selected data
procedure TICsbCommand.SetFieldsBuffer;
var
  i, nOffset: Integer;
  PrgDataSize: Word;
  PrgDataType: SqlTPdt;
  PrgDataBuffer: TSDValueBuffer;
begin
  nOffset := 0;		// pointer to the TSDFieldInfo

  for i:=0 to FieldDescs.Count-1 do begin
    PrgDataType := NativeDataType(FieldDescs[i].FieldType);
    if PrgDataType = 0 then
      DatabaseErrorFmt( SUnknownFieldType, [FieldDescs[i].FieldName] );

    PrgDataSize := FieldDescs[i].DataSize;
    PrgDataBuffer := TSDValueBuffer( Longint(FieldsBuffer) + nOffset + SizeOf(TSDFieldInfo) );
    if not IsBlobType(FieldDescs[i].FieldType) then
      Check( SqlSsb(CurHandle, FieldDescs[i].FieldNo, PrgDataType, PrgDataBuffer,
      		      PrgDataSize, 0,
                      TSDPtr( Longint(PrgDataBuffer) - SizeOf(TSDFieldInfo) + SizeOf(TSDFieldInfo)div 2 ),   // @TSDFieldInfo.DataSize
                      TSDPtr( Longint(PrgDataBuffer) - SizeOf(TSDFieldInfo) )                             // @TSDFieldInfo.FetchStatus
      ) );
    Inc(nOffset, SizeOf(TSDFieldInfo) + PrgDataSize);
  end;
end;

procedure TICsbCommand.BindParamsBuffer;
begin
  if CommandType = ctQuery then
    QBindParamsBuffer
  else if CommandType = ctStoredProc then
    SpBindParamsBuffer
  else
    DatabaseError(SNoCapability);
end;

procedure TICsbCommand.FreeParamsBuffer;
begin
  if Assigned(BufList) then
    BufList.Clear;

  inherited;
end;

function TICsbCommand.FetchNextRow: Boolean;
var
  rcd: SqlTApi;
begin
  rcd := SqlFet( CurHandle );
  FRowFetched := True;
  SqlDatabase.ResetIdleTimeOut;

  Result := rcd = FetchOk;
  if not Result and (rcd <> FetchEof) then
    Check( rcd );

  if Result and (BlobFieldCount > 0) then
    FetchBlobFields;
end;

{ If field necessary convert from internal database format, then returns True }
function TICsbCommand.RequiredCnvtFieldType(FieldType: TFieldType): Boolean;
begin
  Result := IsDateTimeType( FieldType );
end;

{ Buffer - pointer to TSDFieldInfo structure, after which data buffer follows;
TDateTimeField is selected as TDateTimeRec and converts to TDateTime }
function TICsbCommand.GetCnvtFieldData(AFieldDesc: TSDFieldDesc; Buffer: TSDPtr; BufSize: Integer): Boolean;
var
  dtDateTime: TDateTimeRec;
  InBuf, InData: TSDValueBuffer;
  FieldInfo: TSDFieldInfo;
begin
  Result := False;
  InBuf := GetFieldBuffer(AFieldDesc.FieldNo, FieldsBuffer);

  FieldInfo := GetFieldInfoStruct(InBuf, 0);
  if (FieldInfo.FetchStatus = FetchOk) or (FieldInfo.FetchStatus = FetRTru) then
    Result := True;
	// if returns invalid FetchStatus (for SQLBase 6.5&7), when blob is empty
  if (not IsBlobType(AFieldDesc.FieldType)) and
     (FieldInfo.FetchStatus = FetchOk) and
     (FieldInfo.DataSize = 0)
  then
    Result := False;

  if Result then begin
    InData	:= TSDPtr( LongInt(InBuf) + SizeOf(TSDFieldInfo) );
    	// DateTime fields
    if RequiredCnvtFieldType(AFieldDesc.FieldType) then begin
      dtDateTime := CnvtDBDateTime2DateTimeRec(AFieldDesc.FieldType, InData, FieldInfo.DataSize);
      if (AFieldDesc.FieldType in [ftDate, ftTime]) and (BufSize >= SizeOf(dtDateTime.Date)) or
         (AFieldDesc.FieldType in [ftDateTime]) and (BufSize >= SizeOf(dtDateTime))
      then
        case AFieldDesc.FieldType of
          ftDate: HelperMemWriteInt32(Buffer, 0, dtDateTime.Date);
          ftTime: HelperMemWriteInt32(Buffer, 0, dtDateTime.Time);
        else
          HelperMemWriteDateTimeRec(Buffer, 0, dtDateTime);
        end;
    end else begin
      if AFieldDesc.FieldType = ftString then
        SafeCopyMem( InData, Buffer, MinIntValue(BufSize, FieldInfo.DataSize + 1) )
      else
        SafeCopyMem( InData, Buffer, MinIntValue(BufSize, FieldInfo.DataSize) );
    end;
  end;
end;

function TICsbCommand.DBDateTimeFormat(ADataType: TFieldType): string;
const
  DBTimeFormat 		= 'hh:mi:ss';
  DBDateFormat 		= 'dd.mm.yyyy';
  DBMicroSecsFormat	= '.9999999';	//'hh:mi:ss.9999999' returns 6 digits, but necessary 7 digits
begin
  case (ADataType) of
    ftTime: 	Result := DBTimeFormat + DBMicroSecsFormat;
    ftDate: 	Result := DBDateFormat;
    ftDateTime: Result := DBDateFormat + ' ' + DBTimeFormat + DBMicroSecsFormat;
  else
    Result := '';
  end;
end;

function TICsbCommand.DBDateTimeStrLen(ADataType: TFieldType): Integer;
begin
  case (ADataType) of
    ftTime: 	Result := SqlSCti;
    ftDate: 	Result := SqlSCde;
    ftDateTime: Result := SqlSCda;
  else
    Result := 0;
  end;
end;

function TICsbCommand.CnvtDBDateTime2DateTimeRec(ADataType: TFieldType; Buffer: TSDPtr; BufSize: Integer): TDateTimeRec;
const
	// constants for modification formatting variables,
        //which uses date/time functions (StrToDate, StrToTime, StrToDateTime)
  SqlCnvtShortDateFormat= 'dd.mm.yyyy';
  SqlCnvtDateSeparator	= '.';
  SqlCnvtLongTimeFormat	= 'hh:nn:ss';
  SqlCnvtTimeSeparator	= ':';
  DBDateTimeMSecsSep    = '.';
var
  szDBDateTime, szIntFmt: TSDCharPtr;
  sDBDateTime: string;
  sIntFmt,
  OldDateFmt, OldTimeFmt: string;
  OldDateSep, OldTimeSep:{$IFDEF XSQL_CLR} string {$ELSE} Char {$ENDIF};
  nDBDateTimeLen: SqlTDal;
  sMSecs: string;
  MSecs, MSecsSepPos: Integer;
begin
  Result.DateTime := 0.0;
  MSecs := 0;
  nDBDateTimeLen := DBDateTimeStrLen(ADataType) + 1;
  sIntFmt := DBDateTimeFormat(ADataType);
  szDBDateTime := SafeReallocMem( nil, nDBDateTimeLen );
{$IFDEF XSQL_CLR}
  szIntFmt := Marshal.StringToHGlobalAnsi(sIntFmt);
{$ELSE}
  szIntFmt := PChar(sIntFmt);
{$ENDIF}
  	// save date/time formatting variables
  OldDateFmt	:= ShortDateFormat;
  OldDateSep	:= DateSeparator;
  OldTimeFmt	:= LongTimeFormat;
  OldTimeSep	:= TimeSeparator;
  	// change date/time formatting variables
  ShortDateFormat	:= SqlCnvtShortDateFormat;
  DateSeparator		:= SqlCnvtDateSeparator;
  LongTimeFormat	:= SqlCnvtLongTimeFormat;
  TimeSeparator		:= SqlCnvtTimeSeparator;

  try
    Check( SqlXdp(szDBDateTime, nDBDateTimeLen, Buffer, BufSize, szIntFmt, 0) );
    sDBDateTime := HelperPtrToString(szDBDateTime);
    if ADataType in [ftTime, ftDateTime] then begin
        // search microseconds delimiter from the end of string (date part has the such character too)
      MSecsSepPos := Length( sDBDateTime );
      while (MSecsSepPos > 0) and (sDBDateTime[MSecsSepPos] <> DBDateTimeMSecsSep) do
        Dec(MSecsSepPos);
      if MSecsSepPos > 0 then begin
        sMSecs := Copy(sDBDateTime, MSecsSepPos+1, Length(sDBDateTime) - MSecsSepPos);
        MSecs := StrToInt(sMSecs) div 1000;	// convert to milliseconds
        SetLength(sDBDateTime, MSecsSepPos - 1);// remove milliseconds from string
      end;
    end;
    if Trim(sDBDateTime) <> '' then
      try
        case (ADataType) of
          ftTime: 	Result.Time := DateTimeToTimeStamp( StrToTime(sDBDateTime) ).Time + MSecs;
          ftDate: 	Result.Date := DateTimeToTimeStamp( StrToDate(sDBDateTime) ).Date;
          ftDateTime:   Result.DateTime := TimeStampToMSecs( DateTimeToTimeStamp(StrToDateTime(sDBDateTime)) ) + MSecs;
        else
          Result.DateTime := 0.0;
        end;
      except
        on E: EConvertError do begin
          Result.DateTime := 0.0;
{$IFOPT D+}
          ShowMessage( Format('Test message: %s (%s raised in function ''%s'')',
          		[E.Message, E.ClassName, 'TICsbDatabase.ICsbCnvtDBDateTime2DateTimeRec']) );
{$ENDIF}
          raise;	// exception catch and not raized in TDataSet.GetNextRecords (GetPriorRecords)
        end;
      end;
  finally
  	// restore date/time formatting variables
    ShortDateFormat	:= OldDateFmt;
    DateSeparator	:= OldDateSep;
    LongTimeFormat	:= OldTimeFmt;
    TimeSeparator	:= OldTimeSep;

    SafeReallocMem(szDBDateTime, 0);
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal(szIntFmt);
{$ENDIF}
  end;
end;

function TICsbCommand.CnvtDateTime2DBDateTime(ADataType: TFieldType; Value: TDateTime; Buffer: TSDValueBuffer; BufSize: Integer): Integer;
const
  CSqlDateFormat 	= 'dd"."mm"."yyyy';
  CSqlTimeFormat 	= 'hh":"nn":"ss';
  CSqlDateTimeFormat 	= CSqlDateFormat + ' ' + CSqlTimeFormat;
var
  sDateTime, sIntFmt: string;
  Len: SqlTNml;
  MSecs: Integer;
  p1, p2: TSDPtr;
begin
  sIntFmt := DBDateTimeFormat(ADataType);
  case ADataType of
    ftTime: 	sDateTime := FormatDateTime(CSqlTimeFormat, Value);
    ftDate: 	sDateTime := FormatDateTime(CSqlDateFormat, Value);
    ftDateTime: sDateTime := FormatDateTime(CSqlDateTimeFormat, Value);
  end;

  Len := SqlSDat;

  if Len > BufSize then
    DatabaseError(SInsufficientIDateTimeBufSize);

  if ADataType in [ftTime, ftDateTime] then begin
	// get millisecon part of TDateTime
    MSecs := DateTimeToTimeStamp(Value).Time mod 1000;
    	// add microsecond to datetime string
    sDateTime := Format('%s.%.6d', [sDateTime, MSecs*1000]);
  end;
{$IFDEF XSQL_CLR}
  p1 := Marshal.StringToHGlobalAnsi(sDateTime);
  p2 := Marshal.StringToHGlobalAnsi(sIntFmt);
{$ELSE}
  p1 := PChar(sDateTime);
  p2 := PChar(sIntFmt);
{$ENDIF}
  try
    Check( SqlXpd(Buffer, Len, p1, p2, Length(sIntFmt)) );
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal(p1);
    Marshal.FreeHGlobal(p2);
{$ENDIF}
  end;
	// Len returns the used buffer size
  Result := Len;
end;

procedure TICsbCommand.SetDefaultParams;
var
  V: SqlTDpv;
  sTimeout: string;
begin
	// start restriction mode and result set mode
  Check( SqlSrs(CurHandle) );
  	// turn off restriction mode, but leave result set mode
  Check( SqlSpr(CurHandle) );
{  	parameter Describe Information Control - Early:
 SQLDELY (0) means early and is the default value. The
server sends describe information after a call to sqlcom.
Call sqldes, sqldsc, or sqlgdi after sqlcom and before
sqlexe.	}
  V := SQLDELY;
  Check( CsbSqlSet(CurHandle, SQLPDIS, V) );
	// autocommit option
  if not SqlDatabase.AutoCommitDef then begin
    if SqlDatabase.AutoCommit and not SqlDatabase.InTransaction
    then V := 1
    else V := 0;
    Check( CsbSqlSet(CurHandle, SQLPAUT, V) );
  end;

	// set command timeout value, if it's set
  sTimeout := Trim( SqlDatabase.Params.Values[szCMDTIMEOUT] );
  if sTimeout <> '' then begin
    V := StrToIntDef( sTimeout, 0 );
	// set lock timeout (command timeout parameter changes it's value in sql.ini too)
    Check( CsbSqlSet(CurHandle, SQLPWTO, V) );
  end;
  SetPreservation(True);
end;

procedure TICsbCommand.SetPreservation(Value: Boolean);
var
  V: SqlTDpv;
begin
  if Value
  then V := 1
  else V := 0;
  Check( CsbSqlSet(CurHandle, SqlPPcx, V) );
end;

function TICsbCommand.ReadBlob(AFieldDesc: TSDFieldDesc; var BlobData: TSDBlobData): Longint;
var
  ReadL: SqlTDal;       { Length of the returned data }
  Len: Word;            { Length of the current buffer }
  Buf: TSDValueBuffer;         	{ Pointer to the current buffer }
  BlobSize, Count: Integer;
begin
  Result := 0;

  Check( SqlGls(CurHandle, AFieldDesc.FieldNo, BlobSize) );

  if BlobSize = 0 then
    Exit;

  SetLength(BlobData, BlobSize);
	// set a position of the Blob to begin (start with 1)
  Check( SqlLsk(CurHandle, AFieldDesc.FieldNo, 1) );
  try
{$IFDEF XSQL_CLR}
    Buf := SafeReallocMem(nil, FBlobPieceSize);
{$ELSE}
    Buf := PChar(BlobData);
{$ENDIF}
    Count := BlobSize;
    while Count > 0 do begin
      if Count > FBlobPieceSize	// read block must be less < $8000 (32768)
      then Len := FBlobPieceSize
      else Len := Count;
		// read block from database
      Check( SqlRlo(CurHandle, AFieldDesc.FieldNo, Buf, Len, ReadL) );
{$IFDEF XSQL_CLR}
      Marshal.Copy( Buf, BlobData, Result, ReadL );
{$ELSE}
      Buf := Buf + ReadL;
{$ENDIF}
      Inc(Result, ReadL);
      Dec(Count, ReadL);
    end;
  finally
{$IFDEF XSQL_CLR}
    if Assigned(Buf) then
      SafeReallocMem(Buf, 0);
{$ENDIF}
  	// end of the Blob operation
    Check( SqlElo(CurHandle) );
  end;
end;

function TICsbCommand.WriteBlob(FieldNo: Integer; const Buffer: TSDValueBuffer; Count: Longint): Longint;
var
  Len: Word;
  Buf: TSDValueBuffer;
begin
  Result := 0;
  try
    Check( SqlBln(CurHandle, FieldNo) );
    Buf := Buffer;
    while Count > 0 do begin
      if Count > FBlobPieceSize
      then Len := FBlobPieceSize
      else Len := Count;
      Check( SqlWlo(CurHandle, Buf, Len) );
      Inc(Result, Len);
      Dec(Count, Len);
      Buf := TSDValueBuffer(Longint(Buf) + Len);
    end;
  finally
  	// end of the Blob operation
    Check( SqlElo(CurHandle) );
  end;
end;

function TICsbCommand.WriteBlobByName(Name: string; const Buffer: TSDValueBuffer; Count: Longint): Longint;
var
  Len: Word;
  Buf: TSDValueBuffer;
  ptr: TSDCharPtr;
begin
  Result := 0;
{$IFDEF XSQL_CLR}
  ptr := BufList.StringToPtr(Name);
{$ELSE}
  ptr := PChar(Name);
{$ENDIF}
  try
    Check( SqlBld(CurHandle, ptr, 0) );
    Buf := Buffer;
    while Count > 0 do begin
      if Count > FBlobPieceSize
      then Len := FBlobPieceSize
      else Len := Count;
      Check( SqlWlo(CurHandle, Buf, Len) );
      Inc(Result, Len);
      Dec(Count, Len);
      Buf := TSDValueBuffer(Longint(Buf) + Len);
    end;
  finally
  	// end of the Blob operation
    Check( SqlElo(CurHandle) );
  end;
end;

		{ Query methods }

procedure TICsbCommand.QBindParamsBuffer;
var
  i, DataLen, BindDataLen: Integer;
  nli: SqlTNul;
  bnp: SqlTBnp;
  bnl: SqlTBnl;
  DataPtr: TSDValueBuffer;
  sBlob: string;
begin
  if not Assigned(ParamsBuffer) then Exit;
  DataPtr := ParamsBuffer;

  CheckPrepared;

  for i:=0 to Params.Count-1 do with Params[i] do begin
    if IsNull then begin
      nli := -1;
      DataLen := 0
    end else begin
      nli := 0;
      DataLen := NativeParamSize( Params[i] );
    end;
{$IFDEF XSQL_CLR}
    bnp := BufList.StringToPtr(Name);
{$ELSE}
    bnp := PChar(Name);       // = @Name[1];
{$ENDIF}
    bnl := Length(Name);
    	// BindDataLen can be less than DataLen
    BindDataLen := DataLen;
    case DataType of
      ftString:
        if DataLen > 0 then
          HelperMemWriteString(DataPtr, 0, AsString, DataLen)
        else
          HelperMemWriteByte(DataPtr, 0, 0);	// 1 byte - zero-symbol
      ftInteger:
        if DataLen > 0 then HelperMemWriteInt32(DataPtr, 0, AsInteger);
      ftSmallInt:
        if DataLen > 0 then HelperMemWriteInt16(DataPtr, 0, AsInteger);
      ftDate, ftTime, ftDateTime:
        if DataLen > 0 then
          BindDataLen := CnvtDateTime2DBDateTime(DataType, AsDateTime, DataPtr, BindDataLen);
      ftFloat,
      ftCurrency:
        if DataLen > 0 then HelperMemWriteDouble(DataPtr, 0, AsFloat);
      else
        if not IsSupportedBlobTypes(DataType) then
          raise EDatabaseError.CreateFmt(SNoParameterDataType, [Name]);
    end;
    if IsBlobType(DataType) then begin
      sBlob := AsBlob;
      WriteBlobByName(Name, {$IFDEF XSQL_CLR}BufList.StringToPtr(sBlob){$ELSE}PChar(sBlob){$ENDIF}, Length(sBlob));
    end else
      Check( SqlBna(CurHandle, bnp, bnl, DataPtr, BindDataLen, 0,
  		                NativeDataType(DataType), nli) );

    if (DataType = ftString) and (DataLen = 0) then
      Inc(DataLen);
    DataPtr := TSDValueBuffer( Longint(DataPtr) + DataLen );
  end;
end;

function TICsbCommand.GetRowsAffected: Integer;
begin
  Check( SqlRow(CurHandle, Result) );
end;

procedure TICsbCommand.DoPrepare(Value: string);
var
  szCmd: TSDCharPtr;
begin
  if not Assigned(FHandle) then Connect;

{$IFDEF XSQL_CLR}
  szCmd := Marshal.StringToHGlobalAnsi(Value);
{$ELSE}
  szCmd := PChar(Value);
{$ENDIF}
  try
    if CommandType = ctStoredProc then begin
      Check( SqlRet(CurHandle, szCmd, 0) );

      if Assigned(Params) and (Params.Count = 0) then
        InitParamList;
    end else
      Check( SqlCom(CurHandle, szCmd, 0) );
  finally
{$IFDEF XSQL_CLR}
    Marshal.FreeHGlobal(szCmd);
{$ENDIF}
  end;

  SetNativeCommand(Value);

  InitFieldDescs;
end;

procedure TICsbCommand.DoExecDirect(Value: string);
var
  szCmd: TSDCharPtr;
begin
  if not Assigned(FHandle) then Connect;

  if (Assigned(Params) and (Params.Count > 0)) or (CommandType = ctStoredProc) then begin
    DoPrepare(Value);
    AllocParamsBuffer;
    BindParamsBuffer;
    DoExecute;
  end else begin
{$IFDEF XSQL_CLR}
    szCmd := Marshal.StringToHGlobalAnsi(Value);
{$ELSE}
    szCmd := PChar(Value);
{$ENDIF}
    try
        // it is impossible to bind data with SqlCex call
      Check( SqlCex(CurHandle, szCmd, 0) );
      InitFieldDescs;
    finally
{$IFDEF XSQL_CLR}
      Marshal.FreeHGlobal(szCmd);
{$ENDIF}
    end;
  end;

  SetNativeCommand(Value);

  FRowFetched := False;
end;

procedure TICsbCommand.DoExecute;
begin
  CheckPrepared;

  Check( SqlExe(CurHandle) );
  FRowFetched := False;
end;

	{ StoredProc methods }

procedure TICsbCommand.InitParamList;
var
  Col, BindParam: Word;
  szParamName: TSDCharPtr;
  ParamNameLen: Byte;
  nbv: SqlTNbv;  	nsi: SqlTNsi;
  edt: SqlTDdt;		edl: SqlTDdl;
  prep: SqlTPre;	scap: SqlTSca;
begin
  if CommandType <> ctStoredProc then
    Exit;

  szParamName := SafeReallocMem(nil, SQLMCOH);     // max size of column heading string
  try
    Check( SqlNsi(CurHandle, nsi) );	{ number of output parameters }
    Check( SqlNbv(CurHandle, nbv) );	{ number of input parameters }
    	// Creating in-parameters (without data type !!!)
    for BindParam:=1 to (nbv - nsi) do
      AddParam( IntToStr(BindParam), ftUnknown, ptInput );
	// Creating in-out-parameters
    for Col:=1 to nsi do begin
      Check( SqlDsc(CurHandle, Col, edt, edl, szParamName, ParamNameLen, prep, scap) );
      HelperMemWriteByte(szParamName, ParamNameLen, 0);
      AddParam( HelperPtrToString(szParamName), FieldDataType(edt), ptInputOutput );
    end;
  finally
    SafeReallocMem(szParamName, 0);
  end;
end;

procedure TICsbCommand.SpBindParamsBuffer;
var
  i, DataLen: Integer;
  CurPtr, DataPtr: TSDValueBuffer;
  nli: SqlTNul;
begin
  if ParamsBuffer = nil then Exit;

  CheckPrepared;

  CurPtr := ParamsBuffer;
  for i:=0 to Params.Count-1 do with Params[i] do begin
    DataPtr := TSDValueBuffer(Integer(CurPtr) + SizeOf(TSDFieldInfo));
    if IsNull then begin
      nli := -1;
      DataLen := 0
    end else begin
      nli := 0;
      DataLen := NativeParamSize( Params[i] );
    end;
    case DataType of
      ftString:
        begin
          HelperMemWriteString(DataPtr, 0, AsString, Length(AsString));
          HelperMemWriteByte(DataPtr, Length(AsString), 0);
        end;
      ftInteger:
        HelperMemWriteInt32(DataPtr, 0, AsInteger);
      ftSmallInt:
        HelperMemWriteInt16(DataPtr, 0, AsInteger);
      ftDate, ftTime, ftDateTime:
        CnvtDateTime2DBDateTime(DataType, AsDateTime, DataPtr, DataLen);
      ftFloat,
      ftCurrency:
        HelperMemWriteDouble(DataPtr, 0, AsFloat);
    end;
    Check( SqlBnu(CurHandle, i+1, DataPtr, DataLen, 0,
  		                NativeDataType(DataType), nli) );
    CurPtr := TSDValueBuffer( Longint(CurPtr) + SizeOf(TSDFieldInfo) + DataLen );
  end;
end;

{ Set the parameter's value from the current fields of the result set }
procedure TICsbCommand.GetOutputParams;
begin
  if CommandType = ctStoredProc then
    SpGetOutputParams;
end;

{ Coping from Fields to Params }
procedure TICsbCommand.SpGetOutputParams;
var
  i, BufSize: Integer;
  fd: TSDFieldDesc;
  pData: TSDValueBuffer;
begin
  if (FieldDescs.Count = 0) or (Assigned(Params) and (Params.Count = 0)) then
    Exit;

  if not FRowFetched then
    FetchNextRow;
  BufSize := StrToIntDef(SqlDatabase.Params.Values[szMAXCHARPARAMLEN], DEFMAXCHARPARAMLEN);
  pData := SafeReallocMem( nil, BufSize );
  try
    for i:=0 to Params.Count-1 do
      if Params[i].ParamType in [ptInputOutput, ptOutput] then begin
        fd := FieldDescs.FieldDescByName(Params[i].Name);
        if fd.DataSize > BufSize then begin
          pData := SafeReallocMem(pData, fd.DataSize);
          BufSize := fd.DataSize;
        end;
          // if not empty
        if GetCnvtFieldData(fd, pData, BufSize) then begin
          if Params[i].DataType <> fd.FieldType then
            Params[i].DataType := fd.FieldType;
          Params[i].SetData(pData);
        end;
      end;
  finally
    SafeReallocMem(pData, 0);
  end;
end;


initialization
  hSqlLibModule	:= 0;
  SqlLibRefCount:= 0;
  dwLoadedFileVer:=0;
  SqlApiDLL	:= DefSqlApiDLL;
  SqlLibLock 	:= TCriticalSection.Create;
finalization
  while SqlLibRefCount > 0 do
    FreeSqlLib;
  SqlLibLock.Free;
end.
