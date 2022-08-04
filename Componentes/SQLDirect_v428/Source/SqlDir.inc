
{*******************************************************}
{							}
{       Delphi SQLDirect Component Library		}
{       SQLDirect include file				}
{                                                       }
{       Copyright (c) 1997,2005 by Yuri Sheino		}
{                                                       }
{*******************************************************}

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
  {$DEFINE SD_D3}
{$ENDIF}

{$IFDEF VER110} { Borland C++Builder 3.0 }
  {$DEFINE SD_C3}
  { $ObjExportAll On}
{$ENDIF}

{$IFDEF VER120} { Borland Delphi 4.0 }
  {$DEFINE SD_D4}
  {$DEFINE SD_VCL4}
{$ENDIF}

{$IFDEF VER125} { Borland C++Builder 4.0 }
  {$DEFINE SD_C4}
  {$DEFINE SD_VCL4}
  { $ObjExportAll On}
{$ENDIF}

{$IFDEF VER130} { Borland Delphi 5.0 & Borland C++Builder 5.0 }
  {$DEFINE SD_D4}
  {$DEFINE SD_VCL4}
  {$DEFINE SD_VCL5}
{$ENDIF}

{$IFDEF VER140} { Borland Delphi 6.0 & Borland C++Builder 6.0 }
  {$DEFINE SD_D4}
  {$DEFINE SD_VCL4}
  {$DEFINE SD_VCL5}
  {$DEFINE SD_VCL6}
{$ENDIF}

{$IFDEF VER150} { Borland Delphi 7.0 }
  {$DEFINE SD_D4}
  {$DEFINE SD_VCL4}
  {$DEFINE SD_VCL5}
  {$DEFINE SD_VCL6}
{$ENDIF}


{$IFDEF VER160}	{ Borland Delphi 8.0 for .NET Framework }
  {$DEFINE SD_D4}
  {$DEFINE SD_VCL4}
  {$DEFINE SD_VCL5}
  {$DEFINE SD_VCL6}
{$ENDIF}

{$IFDEF VER170}	{ Borland Delphi 2005 (9.0) for VCL and .NET }
  {$DEFINE SD_D4}
  {$DEFINE SD_VCL4}
  {$DEFINE SD_VCL5}
  {$DEFINE SD_VCL6}
  {$DEFINE SD_VCL9}
{$ENDIF}

{$IFDEF CIL}	{ Borland Delphi 8.0 and Delphi 2005 for .NET Framework }
  {$DEFINE SD_CLR}	// Common Language Runtime
{$ENDIF}

{$IFDEF SD_VCL5}
  {$IFNDEF SD_CLR}
    {$DEFINE SD_OLEDB}	// it is not supported for Delphi 4, Delphi 8 and Delphi 9 for .NET
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
{$IFNDEF SD_OLEDB}
  {$UNDEF stOLEDB}
{$ENDIF}

//If FireBird is active, so must Interbase
{$IFDEF stFirebird}
  {$DEFINE stInterbase}
{$ENDIF}
