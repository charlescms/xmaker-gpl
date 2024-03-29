{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvAppAnimatedIcon.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvAppAnimatedIcon.pas,v 1.16 2005/02/17 10:19:58 marquardt Exp $

unit JvAppAnimatedIcon;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes, Controls, ExtCtrls, Graphics, ImgList,
  JvComponent;

type
  TJvAppAnimatedIcon = class(TJvComponent)
  private
    FActive: Boolean;
    FDelay: Cardinal;
    FIcons: TImageList;
    FTimer: TTimer;
    FNumber: Integer;
    procedure SetActive(const Value: Boolean);
    procedure SetDelay(const Value: Cardinal);
    procedure SetIcons(const Value: TImageList);
    procedure Animate(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Delay: Cardinal read FDelay write SetDelay default 100;
    property Icons: TImageList read FIcons write SetIcons;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvAppAnimatedIcon.pas,v $';
    Revision: '$Revision: 1.16 $';
    Date: '$Date: 2005/02/17 10:19:58 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Forms;

constructor TJvAppAnimatedIcon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActive := False;
  FDelay := 100;
  FNumber := 0;
  FTimer := TTimer.Create(Self);
  FTimer.OnTimer := Animate;
  FTimer.Interval := FDelay;
  FTimer.Enabled := FActive;
end;

destructor TJvAppAnimatedIcon.Destroy;
begin
  FTimer.Free;
  inherited Destroy;
end;

procedure TJvAppAnimatedIcon.Animate(Sender: TObject);
{$IFDEF VisualCLX}
var
  TmpBmp: TBitmap;
{$ENDIF VisualCLX}
begin
  if (Icons <> nil) and (Icons.Count <> 0) then
  begin
    FNumber := (FNumber + 1) mod Icons.Count;
    {$IFDEF VCL}
    Icons.GetIcon(FNumber, Application.Icon);
    {$ENDIF VCL}
    {$IFDEF VisualCLX}
    TmpBmp := TBitmap.Create;
    try
      Icons.GetBitmap(FNumber, TmpBmp);
      Application.Icon.Assign(TmpBmp);
    finally
      TmpBmp.Free;
    end;
    {$ENDIF VisualCLX}
  end;
end;

procedure TJvAppAnimatedIcon.SetActive(const Value: Boolean);
begin
  FActive := Value;
  FTimer.Enabled := FActive;
end;

procedure TJvAppAnimatedIcon.SetDelay(const Value: Cardinal);
begin
  FDelay := Value;
  FTimer.Interval := FDelay;
end;

procedure TJvAppAnimatedIcon.SetIcons(const Value: TImageList);
begin
  FIcons := Value;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

