(*  GREATIS BONUS * TNotifier                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Notifier;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type

  TNotificationEvent = procedure (Sender: TObject; AComponent: TComponent; Operation: TOperation) of object;

  TNotifier = class(TComponent)
  private
    { Private declarations }
    FOnNotification: TNotificationEvent;
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
  published
    { Published declarations }
    property OnNotification: TNotificationEvent read FOnNotification write FOnNotification;
  end;

implementation

procedure TNotifier.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) and not (csDesigning in ComponentState) and
    Assigned(FOnNotification) then FOnNotification(Self,AComponent,Operation);
end;

end.
