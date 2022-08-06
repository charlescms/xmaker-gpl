{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{          Abstract Read/Write Dataset component          }
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

unit ZAbstractDataset;

interface

{$I ZComponent.inc}

uses
  SysUtils, DB, Classes, ZConnection, ZSqlUpdate, ZDbcIntfs,
  ZDbcCache, ZDbcCachedResultSet, ZAbstractRODataset, ZDbcGenericResolver;

type

{$IFDEF VER125BELOW}
  TUpdateAction = (uaFail, uaAbort, uaSkip, uaRetry, uaApplied);
{$ENDIF}

  {** Update Event type. }
  TUpdateRecordEvent = procedure(DataSet: TDataSet; UpdateKind: TUpdateKind;
    var UpdateAction: TUpdateAction) of object;

  {** Defines update modes for the resultsets. }
  TZUpdateMode = (umUpdateChanged, umUpdateAll);

  {** Defines where form types for resultsets. }
  TZWhereMode = (wmWhereKeyOnly, wmWhereAll);

  {**
    Abstract dataset component which supports read/write access and
    cached updates.
  }
  TZAbstractDataset = class(TZAbstractRODataset)
  private
    FCachedUpdates: Boolean;
    FUpdateObject: TZUpdateSQL;
    FCachedResultSet: IZCachedResultSet;
    FCachedResolver: IZCachedResolver;
    FOnApplyUpdateError: TDataSetErrorEvent;
    FOnUpdateRecord: TUpdateRecordEvent;
    FUpdateMode: TZUpdateMode;
    FWhereMode: TZWhereMode;

  private
    function GetUpdatesPending: Boolean;
    procedure SetUpdateObject(Value: TZUpdateSQL);
    procedure SetCachedUpdates(Value: Boolean);
    procedure SetWhereMode(Value: TZWhereMode);
    procedure SetUpdateMode(Value: TZUpdateMode);

  protected
    property CachedResultSet: IZCachedResultSet read FCachedResultSet
      write FCachedResultSet;
    property CachedResolver: IZCachedResolver read FCachedResolver
      write FCachedResolver;
    property UpdateMode: TZUpdateMode read FUpdateMode write SetUpdateMode;
    property WhereMode: TZWhereMode read FWhereMode write SetWhereMode;

  protected
    procedure InternalClose; override;
    procedure InternalEdit; override;
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    procedure InternalPost; override;
    procedure InternalDelete; override;
    procedure InternalUpdate;
    procedure InternalCancel; override;

    function CreateStatement(SQL: string; Properties: TStrings):
      IZPreparedStatement; override;
    function CreateResultSet(SQL: string; MaxRows: Integer):
      IZResultSet; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ApplyUpdates;
    procedure CommitUpdates;
    procedure CancelUpdates;
    procedure RevertRecord;

  public
    property UpdatesPending: Boolean read GetUpdatesPending;

  published
    property RequestLive;
    property UpdateObject: TZUpdateSQL read FUpdateObject write SetUpdateObject;
    property CachedUpdates: Boolean read FCachedUpdates write SetCachedUpdates;

    property OnApplyUpdateError: TDataSetErrorEvent read FOnApplyUpdateError
      write FOnApplyUpdateError;
    property OnUpdateRecord: TUpdateRecordEvent read FOnUpdateRecord
      write FOnUpdateRecord;

  published
//    property Constraints;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property OnDeleteError;
    property OnEditError;
    property OnPostError;
    property OnNewRecord;
  end;

implementation

uses Math, ZMessages, ZDatasetUtils;

{ TZAbstractDataset }

{**
  Constructs this object and assignes the mail properties.
  @param AOwner a component owner.
}
constructor TZAbstractDataset.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FWhereMode := wmWhereKeyOnly;
  FUpdateMode := umUpdateChanged;
end;

{**
  Destroys this object and cleanups the memory.
}
destructor TZAbstractDataset.Destroy;
begin
  inherited Destroy;
end;

{**
  Sets a new UpdateSQL object.
  @param Value a new UpdateSQL object.
}
procedure TZAbstractDataset.SetUpdateObject(Value: TZUpdateSQL);
begin
  if FUpdateObject <> Value then
  begin
{$IFNDEF VER125BELOW}
    if Assigned(FUpdateObject) then
      FUpdateObject.RemoveFreeNotification(Self);
{$ENDIF}
    FUpdateObject := Value;
    if Assigned(FUpdateObject) then
      FUpdateObject.FreeNotification(Self);
    if Assigned(FUpdateObject) then
      FUpdateObject.DataSet := Self;
    if Active and (CachedResultSet <> nil) then
    begin
      if FUpdateObject <> nil then
        CachedResultSet.SetResolver(FUpdateObject)
      else
        CachedResultSet.SetResolver(CachedResolver);
    end;
  end;
end;

{**
  Sets a new CachedUpdates property value.
  @param Value a new CachedUpdates value.
}
procedure TZAbstractDataset.SetCachedUpdates(Value: Boolean);
begin
  if FCachedUpdates <> Value then
  begin
    FCachedUpdates := Value;
    if Active and (CachedResultSet <> nil) then
      CachedResultSet.SetCachedUpdates(Value);
  end;
end;

{**
  Sets a new UpdateMode property value.
  @param Value a new UpdateMode value.
}
procedure TZAbstractDataset.SetUpdateMode(Value: TZUpdateMode);
begin
  if FUpdateMode <> Value then
  begin
    FUpdateMode := Value;
    if Active then Close;
  end;
end;

{**
  Sets a new WhereMode property value.
  @param Value a new WhereMode value.
}
procedure TZAbstractDataset.SetWhereMode(Value: TZWhereMode);
begin
  if FWhereMode <> Value then
  begin
    FWhereMode := Value;
    if Active then Close;
  end;
end;

{**
  Creates a DBC statement for the query.
  @param SQL an SQL query.
  @param Properties a statement specific properties.
  @returns a created DBC statement.
}
function TZAbstractDataset.CreateStatement(
  SQL: string; Properties: TStrings): IZPreparedStatement;
var
  Temp: TStrings;
begin
  Temp := TStringList.Create;
  try
    Temp.AddStrings(Properties);

    { Sets update mode property.}
    case FUpdateMode of
      umUpdateAll: Temp.Values['update'] := 'all';
      umUpdateChanged: Temp.Values['update'] := 'changed';
    end;
    { Sets where mode property. }
    case FWhereMode of
      wmWhereAll: Temp.Values['where'] := 'all';
      wmWhereKeyOnly: Temp.Values['where'] := 'keyonly';
    end;

    Result := inherited CreateStatement(SQL, Temp);
  finally
    Temp.Free;
  end;
end;

{**
  Creates a DBC resultset for the query.
  @param SQL an SQL query.
  @param MaxRows a maximum rows number (-1 for all).
  @returns a created DBC resultset.
}
function TZAbstractDataset.CreateResultSet(SQL: string; MaxRows: Integer):
  IZResultSet;
begin
  Result := inherited CreateResultSet(SQL, MaxRows);

  if Result.QueryInterface(IZCachedResultSet, FCachedResultSet) = 0 then
  begin
    CachedResultSet := Result as IZCachedResultSet;
    CachedResolver := CachedResultSet.GetResolver;
    CachedResultSet.SetCachedUpdates(CachedUpdates);
    if FUpdateObject <> nil then
      CachedResultSet.SetResolver(FUpdateObject);
  end;
end;

{**
  Performs internal query closing.
}
procedure TZAbstractDataset.InternalClose;
begin
  inherited InternalClose;

  if Assigned(CachedResultSet) then
    CachedResultSet.Close;
  CachedResultSet := nil;
  CachedResolver := nil;
end;

{**
  Performs an internal action before switch into edit mode.
}
procedure TZAbstractDataset.InternalEdit;
begin
end;

{**
  Performs an internal record updates.
}
procedure TZAbstractDataset.InternalUpdate;
var
  RowNo: Integer;
  RowBuffer: PZRowBuffer;
begin
  if (CachedResultSet <> nil) and GetActiveBuffer(RowBuffer) then
  begin
    RowNo := Integer(CurrentRows[CurrentRow - 1]);
    CachedResultSet.MoveAbsolute(RowNo);
    RowAccessor.RowBuffer := RowBuffer;
    PostToResultSet(CachedResultSet, FieldsLookupTable, Fields, RowAccessor);
    try
      CachedResultSet.UpdateRow;
    except on E: EZSQLThrowable do
      raise EDatabaseError.Create(E.Message);
    end;

    { Filters the row }
    if not FilterRow(RowNo) then
    begin
      CurrentRows.Delete(CurrentRow - 1);
      CurrentRow := Min(CurrentRows.Count, CurrentRow);
    end;
  end;
end;

{**
  Performs an internal adding a new record.
  @param Buffer a buffer of the new adding record.
  @param Append <code>True</code> if record should be added to the end
    of the result set.
}
procedure TZAbstractDataset.InternalAddRecord(Buffer: Pointer; Append: Boolean);
var
  RowNo: Integer;
  RowBuffer: PZRowBuffer;
begin
  if not GetActiveBuffer(RowBuffer) or (RowBuffer <> Buffer) then
    DatabaseError(SInternalError);

  if Append then FetchRows(0);

  if CachedResultSet <> nil then
  begin
    CachedResultSet.MoveToInsertRow;
    RowAccessor.RowBuffer := RowBuffer;
    PostToResultSet(CachedResultSet, FieldsLookupTable, Fields, RowAccessor);
    try
      CachedResultSet.InsertRow;
    except on E: EZSQLThrowable do
      raise EDatabaseError.Create(E.Message);
    end;
    RowNo := CachedResultSet.GetRow;
    FetchCount := FetchCount + 1;

    { Filters the row }
    if FilterRow(RowNo) then
    begin
      if Append then
      begin
        CurrentRows.Add(Pointer(RowNo));
        CurrentRow := CurrentRows.Count;
      end
      else
      begin
        CurrentRow := Max(CurrentRow, 1);
        CurrentRows.Insert(CurrentRow - 1, Pointer(RowNo));
      end;
    end;
  end;
end;

{**
  Performs an internal post updates.
}
procedure TZAbstractDataset.InternalPost;
var
  RowBuffer: PZRowBuffer;
begin
  if not GetActiveBuffer(RowBuffer) then
    DatabaseError(SInternalError);

  Connection.ShowSqlHourGlass;
  try
    if State = dsInsert then
      InternalAddRecord(RowBuffer, False)
    else InternalUpdate;
  finally
    Connection.HideSqlHourGlass;
  end;
end;

{**
  Performs an internal record removing.
}
procedure TZAbstractDataset.InternalDelete;
var
  RowNo: Integer;
  RowBuffer: PZRowBuffer;
begin
  if (CachedResultSet <> nil) and GetActiveBuffer(RowBuffer) then
  begin
    Connection.ShowSqlHourGlass;
    try
      RowNo := Integer(CurrentRows[CurrentRow - 1]);
      CachedResultSet.MoveAbsolute(RowNo);
      try
        CachedResultSet.DeleteRow;
      except on E: EZSQLThrowable do
        raise EDatabaseError.Create(E.Message);
      end;

      { Filters the row }
      if not FilterRow(RowNo) then
      begin
        CurrentRows.Delete(CurrentRow - 1);
        if not FetchRows(CurrentRow) then
          CurrentRow := Min(CurrentRows.Count, CurrentRow);
      end;
    finally
      Connection.HideSQLHourGlass;
    end;
  end;
end;

{**
  Performs an internal cancel updates.
}
procedure TZAbstractDataset.InternalCancel;
var
  RowNo: Integer;
  RowBuffer: PZRowBuffer;
begin
  if (CachedResultSet <> nil) and GetActiveBuffer(RowBuffer)
    and (CurrentRow > 0) and (State = dsEdit) then
  begin
    RowNo := Integer(CurrentRows[CurrentRow - 1]);
    CachedResultSet.MoveAbsolute(RowNo);
    RowAccessor.RowBuffer := RowBuffer;
    FetchFromResultSet(CachedResultSet, FieldsLookupTable, Fields, RowAccessor);
  end;
end;

{**
  Processes component notifications.
  @param AComponent a changed component object.
  @param Operation a component operation code.
}
procedure TZAbstractDataset.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent = FUpdateObject) then
  begin
    Close;
    FUpdateObject := nil;
  end;
end;

{**
   Applies all cached updates stored in the resultset.
}
procedure TZAbstractDataset.ApplyUpdates;
begin
  if not Active then Exit;

  Connection.ShowSQLHourGlass;
  try
    if State in [dsEdit, dsInsert] then Post;

    if CachedResultSet <> nil then
      CachedResultSet.PostUpdates;

    if not (State in [dsInactive]) then
      Resync([]);
  finally
    Connection.HideSqlHourGlass;
  end;
end;

{**
  Clears cached updates buffer.
}
procedure TZAbstractDataset.CommitUpdates;
begin
  CheckBrowseMode;

  if CachedResultSet <> nil then
    CachedResultSet.CancelUpdates;
end;

{**
  Cancels all cached updates and clears the buffer.
}
procedure TZAbstractDataset.CancelUpdates;
begin
  if State in [dsEdit, dsInsert] then Cancel;

  if CachedResultSet <> nil then
    CachedResultSet.CancelUpdates;

  if not (State in [dsInactive]) then
    RereadRows;
end;

{**
  Reverts the previous status for the current row.
}
procedure TZAbstractDataset.RevertRecord;
begin
  if State in [dsInsert] then
  begin
    Cancel;
    Exit;
  end;
  if State in [dsEdit] then Cancel;

  if CachedResultSet <> nil then
    CachedResultSet.RevertRecord;

  if not (State in [dsInactive]) then Resync([]);
end;

{**
  Checks is there cached updates pending in the buffer.
  @return <code>True</code> if there some pending cached updates.
}
function TZAbstractDataset.GetUpdatesPending: Boolean;
begin
  if State = dsInactive then
    Result := False
  else if (CachedResultSet <> nil) and CachedResultSet.IsPendingUpdates then
    Result := True
  else if (State in [dsInsert, dsEdit]) then
    Result := Modified
  else Result := False;
end;

end.
