(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.001                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit PropEdit;

interface

uses Classes, Graphics, PropList, Dialogs;

type

  TPropertyEditor = class
  private
    FProp: TProperty;
  public
    constructor Create(AProp: TProperty); virtual;
    function Execute: Boolean; virtual; abstract;
    property Prop: TProperty read FProp;
  end;

  TPropertyEditorClass = class of TPropertyEditor;

  TFontPropertyEditor = class(TPropertyEditor)
  public
    function Execute: Boolean; override;
  end;

  TColorPropertyEditor = class(TPropertyEditor)
  public
    function Execute: Boolean; override;
  end;

implementation

constructor TPropertyEditor.Create(AProp: TProperty);
begin
  inherited Create;
  FProp:=AProp;
end;

function TFontPropertyEditor.Execute: Boolean;
begin
  with TFontDialog.Create(nil) do
  try
    Font.Assign(TFont(Prop.AsObject));
    Result:=Execute;
    if Result then TFont(Prop.AsObject).Assign(Font);
  finally
    Free;
  end;
end;

function TColorPropertyEditor.Execute: Boolean;
begin
  with TColorDialog.Create(nil) do
  try
    Color:=Prop.AsInteger;
    Result:=Execute;
    if Result then Prop.AsInteger:=Color;
  finally
    Free;
  end;
end;

end.
