{
   Componente.: XEdit.pas
   Copyright..: Modular Software - http://www.modularsoftware.com.br
   Data.......: 01/10/2003
}
unit XEdit;

interface

{$I XMaker.inc}

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, Mask, Dialogs, ComCtrls, Grids, ExtCtrls, Buttons, Math;

type
  TXEdit = class(TCustomMaskEdit)
  private

  protected

  public
    constructor Create(AOwner: TComponent); override;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EditMask;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

constructor TXEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure Register;
begin
  RegisterComponents('X-Maker', [TXEdit]);
end;

end.
