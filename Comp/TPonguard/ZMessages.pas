{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{         Text Messages for Internationalization          }
{                                                         }
{    Copyright (c) 1999-2003 Zeos Development Group       }
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

unit ZMessages;

interface

{$I ZCore.inc}

resourcestring

{$IFDEF RUSSIAN}

{$ELSE}
  SSQLError1 = 'SQL Error: %s';
  SSQLError2 = 'SQL Error: %s Code: %d';
  SSQLError3 = 'SQL Error: %s Code: %d SQL: %s';
  SSQLError4 = 'SQL Error: %s Code: %d Message: %s';

  SListCapacityError = 'List capacity out of bounds (%d)';
  SListCountError = 'List count out of bounds (%d)';
  SListIndexError = 'List index out of bounds (%d)';

  SClonningIsNotSupported = 'Clonning is not supported by this class';
  SImmutableOpIsNotAllowed = 'The operation is not allowed for immutable collection';
  SStackIsEmpty = 'Stack is empty';
  SVariableWasNotFound = 'Variable "%s" was not found';
  SFunctionWasNotFound = 'Function "%s" was not found';
  SInternalError = 'Internal error';
  SSyntaxErrorNear = 'Syntax error near "%s"';
  SSyntaxError = 'Syntax error';
  SUnknownSymbol = 'Unknown symbol "%s"';
  SUnexpectedExprEnd = 'Unexpected end of expression';
  SRightBraceExpected = ') expected';
  SParametersError = 'Expected %d parameters but was found %d';
  SExpectedMoreParams = 'Expected more then 2 parameters';
  SInvalidVarByteArray = 'Invalid VarByte array';
  SVariableAlreadyExists = 'Variable "%s" already exists';
  STypesMismatch = 'Types mismatch';
  SUnsupportedVariantType = 'Unsupported variant type';
  SUnsupportedOperation = 'Unsupported operation';

  STokenizerIsNotDefined = 'Tokenizer is not defined';
  SLibraryNotFound = 'No dynamic library from the list %s found';
  SEncodeDateIsNotSupported = 'This version is not is no supported isc_encode_sql_date';
  SEncodeTimeIsNotSupported = 'This version is not is no supported isc_encode_sql_time';
  SEncodeTimestampIsNotSupported = 'This version is not is no supported isc_encode_sql_timestamp';
  SDecodeDateIsNotSupported = 'This version is not is no supported isc_decode_sql_date';
  SDecodeTimeIsNotSupported = 'This version is not is no supported isc_decode_sql_time';
  SDecodeTimestampIsNotSupported = 'This version is not is no supported isc_decode_sql_timestamp';

  SCanNotRetrieveResultSetData = 'Can not retrieve ResultSet data';
  SRowBufferIsNotAssigned = 'Row buffer is not assigned';
  SColumnIsNotAccessable = 'Column with index %d is not accessable';
  SConvertionIsNotPossible = 'Convertion is not possible for column %d from %s to %s';
  SCanNotAccessBlobRecord = 'Can not access blob record in column %d with type %s';
  SRowDataIsNotAvailable = 'Row data is not available';
  SResolverIsNotSpecified = 'Resolver is not specified for this ResultSet';
  SResultsetIsAlreadyOpened = 'ResultSet is already opened';
  SCanNotUpdateEmptyRow = 'Can not update an empty row';
  SCanNotUpdateDeletedRow = 'Can not update a deleted row';
  SCanNotDeleteEmptyRow = 'Can not delete an empty row';
  SCannotUseCommit = 'You cannot use Commit in autocommit mode';
  SCannotUseRollBack = 'You cannot use Rollback in autocommit mode';
  SCanNotUpdateComplexQuery = 'Can not update a complex query with more then one table';
  SCanNotUpdateThisQueryType = 'Can not update this query type';
  SDriverWasNotFound = 'Requested database driver was not found';
  SCanNotConnectToServer = 'Can not connect to SQL server';
  STableIsNotSpecified = 'Table is not specified';
  SLiveResultSetsAreNotSupported = 'Live query is not supported by this class';
  SInvalidInputParameterCount = 'Input parameter count is less then expected';
  SIsolationIsNotSupported = 'Transact isolation level is not supported';
  SColumnWasNotFound = 'Column with name "%s" was not found';
  SWrongTypeForBlobParameter = 'Wrong type for Blob parameter';
  SIncorrectConnectionURL = 'Incorrect connection URL: %s';
  SUnsupportedProtocol = 'Unsupported protocol: %s';

  SConnectionIsNotAssigned = 'Database connection component is not assigned';
  SQueryIsEmpty = 'SQL Query is empty';
  SCanNotExecuteMoreQueries = 'Cannot execute more then one query';
  SOperationIsNotAllowed1 = 'Operation is not allowed in FORWARD ONLY mode';
  SOperationIsNotAllowed2 = 'Operation is not allowed in READ ONLY mode';
  SOperationIsNotAllowed3 = 'Operation is not allowed in %s mode';
  SOperationIsNotAllowed4 = 'Operation is not allowed for closed dataset';
  SNoMoreRecords = 'No more records in the ResultSet';
  SCanNotOpenResultSet = 'Can not open a ResultSet';
  SCircularLink = 'Datasource makes a circular link';
  SBookmarkWasNotFound = 'Bookmark was not found';
  SIncorrectSearchFieldsNumber = 'Incorrect number of search field values';
  SInvalidOperationInTrans = 'Invalid operation in explicit transaction mode';
  SIncorrectSymbol = 'Incorrect symbol in field list "%s".';
  SIncorrectToken = 'Incorrect token followed by ":"';

  SSelectedTransactionIsolation = 'Selected transaction isolation level is not supported';
  SDriverNotSupported = 'Driver not supported %s';
  SPattern2Long = 'Pattern is too long';
  SDriverNotCapableOutParameters = 'Driver is not capable out parameters';
  SStatementIsNotAllowed = 'Statement is not allowed';
  SStoredProcIsNotAllowed = 'The stored proc is not allowed';
  SCannotPerformOperation = 'Can not perform operation on closed result set';
  SInvalidState = 'Invalid state';
  SErrorConvertion = 'Convertion error';
  SDataTypeDoesNotSupported = 'Data type is not supported';
  SUnsupportedParameterType = 'Unsupported parameter type';
  SUnsupportedDataType = 'Unsupported data type';
  SErrorConvertionField = 'Convertion error for field "%s" to SQLType "%s"';
  SBadOCI = 'Bad OCI version [%s]. It requares 8.0.3 or elder';
  SConnect2AsUser = 'Connect to "%s" as user "%s"';
  SUnknownError = 'Unknown error';
  SFieldNotFound1 = 'Field "%s" was not found';
  SFieldNotFound2 = 'Field %d was not found';

  SLoginPromptFailure = 'Can not find default login prompt dialog.  Please add DBLogDlg to the uses section of your main file.';
{$ENDIF}

implementation

end.
