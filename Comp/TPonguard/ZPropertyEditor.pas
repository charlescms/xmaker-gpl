{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{               Component Property Editors                }
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

unit ZPropertyEditor;

interface

{$I ZComponent.inc}

{$IFDEF WITH_PROPERTY_EDITOR}

uses
  Classes, ZClasses, ZCompatibility, ZDbcIntfs,
{$IFNDEF VER130BELOW}
  DesignIntf, DesignEditors;
{$ELSE}
  DsgnIntf;
{$ENDIF}

type

  {** Implements a property editor for ZConnection.Protocol property. }
  TZProtocolPropertyEditor = class(TPropertyEditor)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  {** Implements a property editor for ZConnection.Database property. }
  TZDatabasePropertyEditor = class(TPropertyEditor)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure Edit; override;
  end;

  {** Implements a property editor for ZConnection.Catalog property. }
  TZCatalogPropertyEditor = class(TPropertyEditor)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  {** Implements a property editor for ZTable.TableName property. }
  TZTableNamePropertyEditor = class(TPropertyEditor)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  {** Implements a property editor for ZStoredProc.StoredProcName property. }
  TZStoredProcNamePropertyEditor = class(TPropertyEditor)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{$ENDIF}

implementation

{$IFDEF WITH_PROPERTY_EDITOR}

uses SysUtils, Forms, Dialogs, ZConnection, ZDataSet, ZStoredProcedure
{$IFNDEF LINUX}
, ZDbcAdoUtils
{$ENDIF}
;

{ TZProtocolPropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZProtocolPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZProtocolPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZProtocolPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetComponent(0) is TZConnection then
    (GetComponent(0) as TZConnection).Connected := False;
end;

{**
  Processes a list of list items.
  @param Proc a procedure to process the list items.
}
procedure TZProtocolPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I, J: Integer;
  Drivers: IZCollection;
  Protocols: TStringDynArray;
begin
  Drivers := DriverManager.GetDrivers;
  Protocols := nil;
  for I := 0 to Drivers.Count - 1 do
  begin
    Protocols := (Drivers[I] as IZDriver).GetSupportedProtocols;
    for J := Low(Protocols) to High(Protocols) do
    begin
      Proc(Protocols[J]);
    end;
  end;
end;

{ TZDatabasePropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZDatabasePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  if GetComponent(0) is TZConnection then
  begin
    if ((GetComponent(0) as TZConnection).Protocol = 'mssql') or
    ((GetComponent(0) as TZConnection).Protocol = 'sybase') then
      Result := [paValueList, paSortList]
    else
      Result := [paDialog];
  end;
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZDatabasePropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZDatabasePropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetComponent(0) is TZConnection then
    (GetComponent(0) as TZConnection).Connected := False;
end;

{**
  Processes a list of list items.
  @param Proc a procedure to process the list items.
}
procedure TZDatabasePropertyEditor.GetValues(Proc: TGetStrProc);
var
  DbcConnection: IZConnection;
  Url: string;
begin
  if GetComponent(0) is TZConnection then
  try
    if (GetComponent(0) as TZConnection).Port = 0 then
      Url := Format('zdbc:%s://%s/%s?UID=%s;PWD=%s', [
        (GetComponent(0) as TZConnection).Protocol,
        (GetComponent(0) as TZConnection).HostName,
        '',
        (GetComponent(0) as TZConnection).User,
        (GetComponent(0) as TZConnection).Password])
    else
      Url := Format('zdbc:%s://%s:%d/%s?UID=%s;PWD=%s', [
        (GetComponent(0) as TZConnection).Protocol,
        (GetComponent(0) as TZConnection).HostName,
        (GetComponent(0) as TZConnection).Port,
        '',
        (GetComponent(0) as TZConnection).User,
        (GetComponent(0) as TZConnection).Password]);

    (GetComponent(0) as TZConnection).ShowSqlHourGlass;
    try
      DbcConnection := DriverManager.GetConnectionWithParams(Url,
        (GetComponent(0) as TZConnection).Properties);

      with DbcConnection.GetMetadata.GetCatalogs do
      try
        while Next do
          Proc(GetString(1));
      finally
        Close;
      end;

    finally
      (GetComponent(0) as TZConnection).HideSqlHourGlass;
    end;
  except
//    raise;
  end;
end;

{**
  Brings up the proper database property editor dialog.
}
procedure TZDatabasePropertyEditor.Edit;
var
  OD: TOpenDialog;
begin
  if GetComponent(0) is TZConnection then
  begin
    if ((GetComponent(0) as TZConnection).Protocol = 'mssql') or
    ((GetComponent(0) as TZConnection).Protocol = 'sybase') then
      inherited
{$IFNDEF LINUX}
    else
    if ((GetComponent(0) as TZConnection).Protocol = 'ado') then
      (GetComponent(0) as TZConnection).Database := PromptDataSource(Application.Handle,
        (GetComponent(0) as TZConnection).Database)
{$ENDIF}
    else
    begin
      OD := TOpenDialog.Create(nil);
      try
        OD.InitialDir := ExtractFilePath((GetComponent(0) as TZConnection).Database);
        if OD.Execute then
          (GetComponent(0) as TZConnection).Database := OD.FileName;
      finally
        OD.Free;
      end;
    end;
  end
  else
    inherited;
end;

{ TZCatalogPropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZCatalogPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZCatalogPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZCatalogPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

{**
  Processes a list of list items.
  @param Proc a procedure to process the list items.
}
procedure TZCatalogPropertyEditor.GetValues(Proc: TGetStrProc);
var
  DbcConnection: IZConnection;
  Url: string;
begin
  if GetComponent(0) is TZConnection then
  try
    if (GetComponent(0) as TZConnection).Port = 0 then
      Url := Format('zdbc:%s://%s/%s?UID=%s;PWD=%s', [
        (GetComponent(0) as TZConnection).Protocol,
        (GetComponent(0) as TZConnection).HostName,
        '',
        (GetComponent(0) as TZConnection).User,
        (GetComponent(0) as TZConnection).Password])
    else
      Url := Format('zdbc:%s://%s:%d/%s?UID=%s;PWD=%s', [
        (GetComponent(0) as TZConnection).Protocol,
        (GetComponent(0) as TZConnection).HostName,
        (GetComponent(0) as TZConnection).Port,
        '',
        (GetComponent(0) as TZConnection).User,
        (GetComponent(0) as TZConnection).Password]);

    (GetComponent(0) as TZConnection).ShowSqlHourGlass;
    try
      DbcConnection := DriverManager.GetConnectionWithParams(Url,
        (GetComponent(0) as TZConnection).Properties);

      with DbcConnection.GetMetadata.GetCatalogs do
      try
        while Next do
          Proc(GetString(1));
      finally
        Close;
      end;

    finally
      (GetComponent(0) as TZConnection).HideSqlHourGlass;
    end;
  except
//    raise;
  end;
end;

{ TZTableNamePropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZTableNamePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZTableNamePropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZTableNamePropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetComponent(0) is TZTable then
    (GetComponent(0) as TZTable).Active := False;
end;

{**
  Processes a list of list items.
  @param Proc a procedure to process the list items.
}
procedure TZTableNamePropertyEditor.GetValues(Proc: TGetStrProc);
var
  Table: TZTable;
  Metadata: IZDatabaseMetadata;
  TableTypes: TStringDynArray;
begin
  if PropCount = 0 then Exit;
  if GetComponent(0) is TZTable then
  begin
    Table := GetComponent(0) as TZTable;
    if Assigned(Table.Connection) and Table.Connection.Connected then
    begin
      Metadata := Table.Connection.DbcConnection.GetMetadata;
      SetLength(TableTypes, 2);
      TableTypes[0] := 'TABLE';
      TableTypes[1] := 'VIEW';
      with Metadata.GetTables('', '', '', TableTypes) do
      try
        while Next do
          if GetString(2) = '' then
            Proc(GetString(3))
          else
            Proc(GetString(2) + '.' + GetString(3));
      finally
        Close;
      end;
    end;
  end;
end;

{ TZStoredProcNamePropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZStoredProcNamePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZStoredProcNamePropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZStoredProcNamePropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetComponent(0) is TZTable then
    (GetComponent(0) as TZTable).Active := False;
end;

{**
  Processes a list of list items.
  @param Proc a procedure to process the list items.
}
procedure TZStoredProcNamePropertyEditor.GetValues(Proc: TGetStrProc);
var
  SP: TZStoredProc;
  Metadata: IZDatabaseMetadata;
begin
  if PropCount = 0 then Exit;
  if GetComponent(0) is TZStoredProc then
  begin
    SP := GetComponent(0) as TZStoredProc;
    if Assigned(SP.Connection) and SP.Connection.Connected then
    begin
      Metadata := SP.Connection.DbcConnection.GetMetadata;
      with Metadata.GetProcedures('', '', '') do
      try
        while Next do
          if GetString(2) = '' then
            Proc(GetString(3))
          else
            Proc(GetString(2) + '.' + GetString(3));
      finally
        Close;
      end;
    end;
  end;
end;

{$ENDIF}

end.

