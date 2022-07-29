(*  GREATIS CONTROL DESIGNER             *)
(*  unit version 1.00.001                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/ctrldes.htm   *)
(*  b-team@greatis.com                   *)

unit CDReg;

interface

uses Classes, CtrlDes;

procedure Register;

implementation

{$R CDREG.DCR}

procedure Register;
begin
  RegisterComponents('Designers', [TControlDesigner]);
end;

end.
