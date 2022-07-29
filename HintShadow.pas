unit HintShadow;

{
  HintShadow.pas v1.0 (2001-12-22) by Jordan Russell

  This unit will enable drop shadows on Hints when your program is running on
  Windows XP.
  To use: simply add "HintShadow" to your main form's "uses" clause.
}

interface

uses
  Windows, SysUtils, Controls, Forms;

type
  TShadowedHintWindow = class(THintWindow)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

implementation

{ TShadowedHintWindow }

procedure TShadowedHintWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  { Enable drop shadow effect on Windows XP and later }
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and
     ((Win32MajorVersion > 5) or
      ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

initialization
  HintWindowClass := TShadowedHintWindow;
end.
