(*  GREATIS FORM DESIGNER COMPONENT PRO  *)
(*  unit version 0.00.001                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm   *)
(*  b-team@greatis.com                   *)

unit DCReg;

interface

uses Classes, DCMain;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Designers', [TDesignerComponent]);
end;

end.
