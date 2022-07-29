program MakeInc;
{$APPTYPE CONSOLE}
uses
  SysUtils;

var
  F, G, H: TextFile;
  FuncName: string;
begin
  // Insert user code here
  AssignFile(F, 'Funcs.txt');
  AssignFile(G, 'AddFunc.inc');
  AssignFile(H, 'Add.inc');
  Reset(F);
  Rewrite(G);
  Rewrite(H);
  while not Eof(F) do
  begin
    ReadLn(F, FuncName);
    if (FuncName <> '') and (FuncName[1] in ['A'..'Z', 'a'..'z', '_']) then
    begin
      WriteLn(G, Format('    AddFunc(''%s'', %0:s);', [FuncName]));
      WriteLn(H, Format('    Add(''%s'');', [FuncName]));
    end;
  end;
  CloseFile(F);
  CloseFile(G);
  CloseFile(H);
end.