{$A+}	{+ Aligned record fields }
{$B-}	{- Complete boolean eval }
{$P+}	{- Open string params }
{$R-}	{- Range Checking }
{$Q-}	{- Overflow Checking }
{$V-}	{- Var-String Checking }
{$X+}	{- Extended syntax }
{$IFDEF WIN32}
{$J+}	{- Writeable structured consts }
{$H+}	{- Use long strings by default }
{$ENDIF}

{------- Include it for DEBUGGING --------}
{ $O-}	{ OPTIMIZATION OFF }
{ $W+}	{ STACKFRAMES ON }
{ $R+}	{ RANGECHECKS ON } // could be error with IB
{ $Q+} 	{ OVERFLOWCHECKS ON } 

{ $D+}	{ DEBUGINFO ON }
{ $L+}	{ LOCALSYMBOLS ON }
{ $Y+} 	{ REFERENCEINFO ON }
{-----------------------------------------}

{$MINENUMSIZE 4}        // it is equal Z4 or Z+(in earlier Delphi versions)

{$IFDEF VER100} { Borland Delphi 3.0 }
  {$DEFINE XSQL_D3}
{$ENDIF}

{$IFDEF VER110} { Borland C++Builder 3.0 }
  {$DEFINE XSQL_C3}
  { $ObjExportAll On}
{$ENDIF}

{$IFDEF VER120} { Borland Delphi 4.0 }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
{$ENDIF}

{$IFDEF VER125} { Borland C++Builder 4.0 }
  {$DEFINE XSQL_C4}
  {$DEFINE XSQL_VCL4}
  { $ObjExportAll On}
{$ENDIF}

{$IFDEF VER130} { Borland Delphi 5.0 & Borland C++Builder 5.0 }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
  {$DEFINE XSQL_VCL5}
{$ENDIF}

{$IFDEF VER140} { Borland Delphi 6.0 & Borland C++Builder 6.0 }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
  {$DEFINE XSQL_VCL5}
  {$DEFINE XSQL_VCL6}
{$ENDIF}

{$IFDEF VER150} { Borland Delphi 7.0 }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
  {$DEFINE XSQL_VCL5}
  {$DEFINE XSQL_VCL6}
{$ENDIF}


{$IFDEF VER160}	{ Borland Delphi 8.0 for .NET Framework }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
  {$DEFINE XSQL_VCL5}
  {$DEFINE XSQL_VCL6}
{$ENDIF}

{$IFDEF VER170}	{ Borland Delphi 2005 (9.0) for VCL and .NET }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
  {$DEFINE XSQL_VCL5}
  {$DEFINE XSQL_VCL6}
  {$DEFINE XSQL_VCL9}
{$ENDIF}

{$IFDEF VER180}	{ Borland Delphi 2006 (10.0) for VCL and .NET }
  {$DEFINE XSQL_D4}
  {$DEFINE XSQL_VCL4}
  {$DEFINE XSQL_VCL5}
  {$DEFINE XSQL_VCL6}
  {$DEFINE XSQL_VCL9}
  {$DEFINE XSQL_VCL10}
{$ENDIF}

{$IFDEF CIL}	{ Borland Delphi 8.0 and Delphi 2005 for .NET Framework }
  {$DEFINE XSQL_CLR}	// Common Language Runtime
{$ENDIF}

{$IFDEF XSQL_VCL5}
  {$IFNDEF XSQL_CLR}
    {$DEFINE XSQL_OLEDB}	// it is not supported for Delphi 4, Delphi 8 and Delphi 9 for .NET
  {$ENDIF}
{$ENDIF}

//******************************************************************************
// It is possible to comment some define(supported server) below to minimize executable size.
// By default, all servers are supported.
//******************************************************************************
{$DEFINE stSQLBase}
{$DEFINE stOracle}
{$DEFINE stSQLServer}
{$DEFINE stSybase}
{$DEFINE stDB2}
{$DEFINE stInformix}
{$DEFINE stODBC}
{$DEFINE stInterbase}
{$DEFINE stFirebird}
{$DEFINE stMySQL}
{$DEFINE stPostgreSQL}
{$DEFINE stOLEDB}
//******************************************************************************

//Undefine OLEDB if it is not supported inside the current compiler
{$IFNDEF XSQL_OLEDB}
  {$UNDEF stOLEDB}
{$ENDIF}

//If FireBird is active, so must Interbase
{$IFDEF stFirebird}
  {$DEFINE stInterbase}
{$ENDIF}
