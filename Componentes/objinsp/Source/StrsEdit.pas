(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.004                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit StrsEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, PropEdit;

type

  TfrmStrings = class(TForm)
    lblCount: TLabel;
    redStrings: TRichEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    function GetStrings: TStrings;
    procedure redStringsChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  public
    { Public declarations }
    property Strings: TStrings read GetStrings;
  end;

  TStringsPropertyEditor = class(TPropertyEditor)
    function Execute: Boolean; override;
  end;

implementation

{$R *.DFM}

function TfrmStrings.GetStrings: TStrings;
begin
  Result:=redStrings.Lines;
end;

procedure TfrmStrings.redStringsChange(Sender: TObject);
var
  S: string;
begin
  with redStrings.Lines do
  begin
    S:=Format('%d line',[Count]);
    if Count<>1 then S:=S+'s';
  end;
  lblCount.Caption:=S;
end;

procedure TfrmStrings.btnClearClick(Sender: TObject);
begin
  redStrings.Lines.Clear;
end;

function TStringsPropertyEditor.Execute: Boolean;
{$IFDEF GOISETPROC}
type
  TSetStringsProc = procedure (NewStrings: TStrings) of object;
var
  SetProc: TSetStringsProc;
{$ENDIF}
begin
  with TfrmStrings.Create(nil) do
  try
    redStrings.Lines.Assign(TStrings(Prop.AsObject));
    Result:=ShowModal=mrOk;
    if Result then
    begin
      {$IFDEF GOISETPROC}
      TMethod(SetProc).Code:=Prop.SetProc;
      TMethod(SetProc).Data:=Pointer(Prop.Instance);
      SetProc(redStrings.Lines);
      {$ELSE}
      TStrings(Prop.AsObject).Assign(redStrings.Lines);
      {$ENDIF}
    end;
  finally
    Free;
  end;
end;

end.
