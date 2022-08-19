{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{             Unidatabase SQLProcessor component          }
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

unit ZSqlProcessor;

interface

{$I ZComponent.inc}

uses ZCompatibility, Classes, SysUtils, DB, ZDbcIntfs, ZConnection, ZTokenizer,
  ZScriptParser;

type

  {** Forward definition of TZSQLProcessor. }
  TZSQLProcessor = class;

  {** Defines an error handle action. }
  TZErrorHandleAction = (eaFail, eaAbort, eaSkip, eaRetry);

  {** Defines an Processor notification event. }
  TZProcessorNotifyEvent = procedure(Processor: TZSQLProcessor;
    StatementIndex: Integer) of object;

  {** Defines an Processor error handling event. }
  TZProcessorErrorEvent = procedure(Processor: TZSQLProcessor;
    StatementIndex: Integer; E: Exception;
    var ErrorHandleAction: TZErrorHandleAction) of object;

  {**
    Implements a unidatabase component which parses and executes SQL Scripts.
  }
  TZSQLProcessor = class (TComponent)
  private
    FScript: TStrings;
    FScriptParser: TZSQLScriptParser;
    FConnection: TZConnection;
    FBeforeExecute: TZProcessorNotifyEvent;
    FAfterExecute: TZProcessorNotifyEvent;
    FOnError: TZProcessorErrorEvent;

    procedure SetScript(Value: TStrings);
    function GetStatementCount: Integer;
    function GetStatement(Index: Integer): string;
    procedure SetConnection(Value: TZConnection);
    function GetDelimiterType: TZDelimiterType;
    procedure SetDelimiterType(Value: TZDelimiterType);
    function GetDelimiter: string;
    procedure SetDelimiter(Value: string);
  protected
    procedure CheckConnected;
    function DoOnError(StatementIndex: Integer; E: Exception):
      TZErrorHandleAction;
    procedure DoBeforeExecute(StatementIndex: Integer);
    procedure DoAfterExecute(StatementIndex: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromFile(FileName: string);

    procedure Execute;
    procedure Parse;
    procedure Clear;

    property StatementCount: Integer read GetStatementCount;
    property Statements[Index: Integer]: string read GetStatement;
  published
    property Script: TStrings read FScript write SetScript;
    property Connection: TZConnection read FConnection write SetConnection;
    property DelimiterType: TZDelimiterType read GetDelimiterType
      write SetDelimiterType default dtDefault;
    property Delimiter: string read GetDelimiter write SetDelimiter;
    property OnError: TZProcessorErrorEvent read FOnError write FOnError;
    property AfterExecute: TZProcessorNotifyEvent read FAfterExecute write FAfterExecute;
    property BeforeExecute: TZProcessorNotifyEvent read FBeforeExecute write FBeforeExecute;
  end;

implementation

uses ZMessages, ZSysUtils, ZDbcUtils;

{ TZSQLProcessor }

{**
  Creates this Processor component and assignes the main properties.
  @param AOwner an owner component.
}
constructor TZSQLProcessor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FScript := TStringList.Create;
  FScriptParser := TZSQLScriptParser.Create;
  FScriptParser.DelimiterType := dtDefault;
  FScriptParser.Delimiter := ';';
  FScriptParser.CleanupStatements := True;
end;

{**
  Destroys this component and cleanups the memory.
}
destructor TZSQLProcessor.Destroy;
begin
  FScript.Free;
  FScriptParser.Free;
  inherited Destroy;
end;

{**
  Gets a parsed statement by it's index.
  @return a SQL statement.
}
function TZSQLProcessor.GetStatement(Index: Integer): string;
begin
  if (FScriptParser.UncompletedStatement <> '')
    and (Index = FScriptParser.StatementCount) then
    Result := FScriptParser.UncompletedStatement
  else Result := FScriptParser.Statements[Index];
end;

{**
  Gets a statements count.
  @return a number of parsed statements.
}
function TZSQLProcessor.GetStatementCount: Integer;
begin
  Result := FScriptParser.StatementCount;
  if FScriptParser.UncompletedStatement <> '' then
    Inc(Result);
end;

{**
  Sets a new SQL connection component.
  @param Value am SQL connection component.
}
procedure TZSQLProcessor.SetConnection(Value: TZConnection);
begin
  if FConnection <> Value then
  begin
    FConnection := Value;
    FScriptParser.ClearUncompleted;
  end;
end;

{**
  Gets a script delimiter type;
}
function TZSQLProcessor.GetDelimiterType: TZDelimiterType;
begin
  Result := FScriptParser.DelimiterType;
end;

{**
  Sets a new Processor delimiter type.
  @param Value a new Processor delimiter type.
}
procedure TZSQLProcessor.SetDelimiterType(Value: TZDelimiterType);
begin
  if FScriptParser.DelimiterType <> Value then
  begin
    FScriptParser.DelimiterType := Value;
    FScriptParser.ClearUncompleted;
  end;
end;

{**
  Gets a script delimiter;
}
function TZSQLProcessor.GetDelimiter: string;
begin
  Result := FScriptParser.Delimiter;
end;

{**
  Sets a new Processor delimiter.
  @param Value a new Processor delimiter.
}
procedure TZSQLProcessor.SetDelimiter(Value: string);
begin
  if FScriptParser.Delimiter <> Value then
  begin
    FScriptParser.Delimiter := Value;
    FScriptParser.ClearUncompleted;
  end;
end;

{**
  Sets a new SQL script.
  @param Value a new SQL script.
}
procedure TZSQLProcessor.SetScript(Value: TStrings);
begin
  FScript.Assign(Value);
  FScriptParser.ClearUncompleted;
end;

{**
  Checks is the database connection assignes and tries to connect.
}
procedure TZSQLProcessor.CheckConnected;
begin
  if Connection = nil then
    DatabaseError(SConnectionIsNotAssigned);
  Connection.Connect;
end;

{**
  Clears Processor contents and all parsed statements.
}
procedure TZSQLProcessor.Clear;
begin
  FScript.Clear;
  FScriptParser.ClearUncompleted;
end;

{**
  Performs OnError Event and returns an error handle action.
  @param StatementIndex an index of the statement which failt.
  @param E an exception object.
  @return an error handle action.
}
function TZSQLProcessor.DoOnError(StatementIndex: Integer;
  E: Exception): TZErrorHandleAction;
begin
  Result := eaFail;
  if Assigned(FOnError) then
    FOnError(Self, StatementIndex, E, Result);
end;

{**
  Performs an action before execute a statement.
  @param StatementIndex an index of the executing statement.
}
procedure TZSQLProcessor.DoBeforeExecute(StatementIndex: Integer);
begin
  if Assigned(FBeforeExecute) then
    FBeforeExecute(Self, StatementIndex);
end;

{**
  Performs an action action execute a statement.
  @param StatementIndex an index of the executing statement.
}
procedure TZSQLProcessor.DoAfterExecute(StatementIndex: Integer);
begin
  if Assigned(FAfterExecute) then
    FAfterExecute(Self, StatementIndex);
end;

{**
  Loads a SQL Processor from the local file.
  @param FileName a name of the file.
}
procedure TZSQLProcessor.LoadFromFile(FileName: string);
begin
  FScript.LoadFromFile(FileName);
end;

{**
  Loads a SQL Processor from the stream.
  @param Stream a stream object.
}
procedure TZSQLProcessor.LoadFromStream(Stream: TStream);
begin
  FScript.LoadFromStream(Stream);
end;

{**
  Executes a parsed SQL Processor.
}
procedure TZSQLProcessor.Execute;
var
  I: Integer;
  Statement: IZStatement;
  Action: TZErrorHandleAction;
begin
  if Connection = nil then
    DatabaseError(SConnectionIsNotAssigned);

  FConnection.ShowSQLHourGlass;
  try
    Parse;
    Statement := FConnection.DbcConnection.CreateStatement;

    for I := 0 to StatementCount - 1 do
    begin
      Action := eaSkip;
      DoBeforeExecute(I);
      repeat
        try
          Statement.ExecuteUpdate(Statements[I]);
        except
          on E: Exception do
          begin
            Action := DoOnError(I, E);
            if Action = eaFail then
              RaiseSQLException(E)
            else if Action = eaAbort then
              Exit;
          end;
        end;
      until Action <> eaRetry;
      DoAfterExecute(I);
    end;
  finally
    Connection.HideSQLHourGlass;
  end;
end;

{**
  Parses the loaded SQL Processor.
}
procedure TZSQLProcessor.Parse;
begin
  CheckConnected;
  FScriptParser.Tokenizer := Connection.DbcConnection.GetMetadata.GetTokenizer;
  FScriptParser.Clear;
  FScriptParser.ParseText(FScript.Text);
end;

end.

