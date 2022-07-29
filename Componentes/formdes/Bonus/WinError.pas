(*  GREATIS BONUS * TWindowsError             *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit WinError;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TWindowsError = class(TComponent)
  private
    { Private declarations }
    function GetErrorText: string;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure ShowError(BoxCaption: string);
    property ErrorText: string read GetErrorText;
  end;

implementation

function TWindowsError.GetErrorText: string;
var
  C: array[Byte] of Char;
begin
  FormatMessage(
    FORMAT_MESSAGE_FROM_SYSTEM,
    nil,
    GetLastError,
    LOCALE_USER_DEFAULT,
    C,
    SizeOf(C),
    nil);
  Result:=C;
end;

procedure TWindowsError.ShowError(BoxCaption: string);
begin
  with Application do
    MessageBox(PChar(ErrorText),PChar(BoxCaption),MB_ICONERROR or MB_OK);
end;

end.
