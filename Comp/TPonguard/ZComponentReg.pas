{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{            Database Components Registration             }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
{            Written by Sergey Seroukhov                  }
{                                                         }
{*********************************************************}

{*********************************************************}
{ License Agreement:                                      }
{                                                         }
{ This library is free software; you can redistribute     }
{ it and/or modify it under the terms of the GNU Lesser   }
{ General Public License as published by the Free         }
{ Software Foundation; either version 2.1 of the License, }
{ or (at your option) any later version.                  }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ You should have received a copy of the GNU Lesser       }
{ General Public License along with this library; if not, }
{ write to the Free Software Foundation, Inc.,            }
{ 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA }
{                                                         }
{ The project web site is located on:                     }
{   http://www.sourceforge.net/projects/zeoslib.          }
{   http://www.zeoslib.sourceforge.net                    }
{                                                         }
{                                 Zeos Development Group. }
{*********************************************************}

unit ZComponentReg;

interface

{$I ZComponent.inc}

{ Zeos palette names }
const
  ZEOS_DB_PALETTE = 'Zeos Access';

procedure Register;

implementation

uses
{$IFDEF WITH_PROPERTY_EDITOR}
  ZPropertyEditor,
{$IFNDEF VER130BELOW}
{$IFNDEF LINUX}
  ZUpdateSqlEditor,
{$ENDIF}
  DesignIntf,
{$ELSE}
  DsgnIntf,
{$ENDIF}
{$ENDIF}
  Classes, ZConnection, ZDataset, ZSqlUpdate, ZSqlProcessor, ZStoredProcedure,
  ZSqlMonitor, ZSqlMetadata;

{**
  Registers components in a component palette.
}
procedure Register;
begin
  RegisterComponents(ZEOS_DB_PALETTE, [TZConnection]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZReadOnlyQuery]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZQuery]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZTable]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZUpdateSQL]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZStoredProc]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZSQLMetadata]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZSQLProcessor]);
  RegisterComponents(ZEOS_DB_PALETTE, [TZSQLMonitor]);

{$IFDEF WITH_PROPERTY_EDITOR}
  RegisterPropertyEditor(TypeInfo(string), TZConnection, 'Protocol',
    TZProtocolPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TZConnection, 'Database',
    TZDatabasePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TZConnection, 'Catalog',
    TZCatalogPropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TZTable, 'TableName',
    TZTableNamePropertyEditor);
  RegisterPropertyEditor(TypeInfo(string), TZStoredProc, 'StoredProcName',
    TZStoredProcNamePropertyEditor);
{$IFNDEF VER130BELOW}
{$IFNDEF LINUX}
  RegisterComponentEditor(TZUpdateSQL, TZUpdateSQLEditor);
{$ENDIF}
{$ENDIF}
{$ENDIF}
end;

end.

