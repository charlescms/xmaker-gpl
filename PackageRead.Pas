unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, TypInfo, ExtCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Panel1: TPanel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Pacote: HModule;
  public
    { Public declarations }
  end;

type
  TEnumTypeInfoCallback = function(UserData: Pointer; Info: PTypeInfo): Boolean;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetBaseOfCode(Module: hModule; var CodeStart, CodeEnd: PChar): Boolean;
asm // get Codesegment pointers, check if module is a valid PE
       PUSH  EDI
       PUSH  ESI
       AND   EAX,not 3
       JZ    @@2
       CMP   Word Ptr [EAX],'ZM';
       JNE   @@1
       MOV   ESI,[EAX + 03Ch]
       CMP   Word Ptr [ESI + EAX],'EP'
       JNE   @@1
       MOV   EDI,[EAX + ESI + 014h + 008h]
       ADD   EAX,[EAX + ESI + 014h + 018h]
       ADD   EDI,EAX
       MOV   [EDX],EAX
       MOV   [ECX],EDI
       XOR   EAX,EAX
@@1:   SETE  AL
@@2:   POP   ESI
       POP   EDI
end;

function EnumTypeInfo(Module: hModule; Callback: TEnumTypeInfoCallback; UserData: Pointer): PTypeInfo;
// copyright (c) 1998 Hagen Reddmann
var
  P,E,K,N: PChar;
  L: Integer;
begin
  Result := nil;
  if Assigned(Callback) then
  try
    if GetBaseOfCode(Module, P, E) then
      while P < E do
      begin
        DWord(P) := DWord(P) and not 3;
        K := P + 4;
        if (PDWord(P)^ = DWord(K)) and (PByte(K)^ > 0)
        and (PByte(K)^ <= Integer(High(TTypeKind))) then // Info.Kind in ValidRange.D6
        begin
          L := PByte(K + 1)^;  // length Info.Name
          N := K + 2;          // @Info.Name[1]
          if (L > 0) and (N^ in ['_', 'a'..'z', 'A'..'Z']) then  // valid ident ??
          begin
            repeat
              Inc(N);
              Dec(L);
            until (L = 0) or not (N^ in ['_', 'a'..'z', 'A'..'Z', '0'..'9']);
            if L = 0 then // length and ident valid
              if Callback(UserData, Pointer(K)) then // tell it and if needed abort iteration
              begin
                Result := Pointer(K);
                Exit;
              end else K := N;
          end;
        end;
        P := K;
      end;
  except
  end;
end;

function RegClassesHandler(UserData: Pointer; Info: PTypeInfo): Boolean; register;
var td:PTypeData;
begin
  if Info^.Kind = tkClass then
  begin
    td := GetTypeData(info);
    if td^.ClassType.InheritsFrom(TPersistent) then
    begin
      RegisterClass(TPersistentClass(td^.ClassType));
      Form1.Memo1.Lines.Add('>> Register: '+TPersistentClass(td^.ClassType).ClassName);
    end;
    Form1.Memo1.Lines.Add('Unit:'+td^.UnitName+' - Classe: '+td^.ClassType.ClassName+
      ' = class('+td^.ParentInfo^.Name+')');
  end;
  result := false;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName;
end;

procedure TForm1.Button1Click(Sender: TObject);
//var
//  Pacote: HModule;
begin
  Memo1.Lines.Clear;
  Pacote :=  LoadPackage(Edit1.Text);
  EnumTypeInfo(Pacote, RegClassesHandler, nil);
end;

end.
