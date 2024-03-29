{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: LinkDebug.pas, released 2002-01-06.

The Initial Developer of the Original Code is David Polberger <dpol att swipnet dott se>
Portions created by David Polberger are Copyright (C) 2002 David Polberger.
All Rights Reserved.

Contributor(s): ______________________________________.

Current Version: 2.00

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Description:
  LinkDebug.pas provides utility routines designed to aid debugging.
Known Issues:
  Please see the accompanying documentation.
-----------------------------------------------------------------------------}
// $Id: JvLinkLabelDebug.pas,v 1.13 2005/02/17 10:20:42 marquardt Exp $

unit JvLinkLabelDebug;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  TypInfo, SysUtils,
  ComCtrls, Graphics,
  {$IFDEF VisualCLX}
  Types,
  {$ENDIF VisualCLX}
  JvLinkLabelTree, JvLinkLabelTools, JvLinkLabel;

type
  TDebugLinkLabelTools = class(TStaticObject)
  public
    class procedure NodeTreeToTreeNodes(const LinkLabel: TJvLinkLabel;
      const Tree: TTreeNodes);
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvLinkLabelDebug.pas,v $';
    Revision: '$Revision: 1.13 $';
    Date: '$Date: 2005/02/17 10:20:42 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation


type
  TJvLinkLabelAccessProtected = class(TJvLinkLabel);

class procedure TDebugLinkLabelTools.NodeTreeToTreeNodes(const LinkLabel: TJvLinkLabel;
  const Tree: TTreeNodes);

  function GetNodeDescription(const Node: TNode): string;
  begin
    Result := Node.ClassName;
    case Node.GetNodeType of
      ntStyleNode:
        Result := Result + ' (' +
          GetEnumName(TypeInfo(TFontStyle), Integer((Node as TStyleNode).Style)) + ')';
      ntLinkNode:
        Result := Result + ' (' +
          GetEnumName(TypeInfo(TLinkState), Integer((Node as TLinkNode).State)) + ')';
      ntStringNode:
        Result := Result + ' ("' + (Node as TStringNode).Text + '")';
      ntActionNode:
        Result := Result + ' (' +
          GetEnumName(TypeInfo(TActionType), Integer((Node as TActionNode).Action)) + ')';
      // Bianconi
      ntColorNode:
        Result := Result + ' ( ' + ColorToString(TColorNode(Node).Color) + ' )';
      // End of Bianconi
      ntUnknownNode:
        Result := Result + ' ("' + (Node as TUnknownNode).Tag + '")';
    end;

    if Node is TAreaNode then
      Result := Result + ' [X: ' + IntToStr(TAreaNode(Node).StartingPoint.X) +
        ', Y: ' + IntToStr(TAreaNode(Node).StartingPoint.Y) + ']';
  end;

  procedure Recurse(const Parent: TTreeNode; Node: TNode);
  var
    TreeParent: TTreeNode;
    I: Integer;
  begin
    TreeParent := Tree.AddChild(Parent, GetNodeDescription(Node));

    if Node is TParentNode then
      for I := 0 to TParentNode(Node).Children.Count - 1 do
        Recurse(TreeParent, TParentNode(Node).Children[I]);
  end;

begin
  if Assigned(TJvLinkLabelAccessProtected(LinkLabel).FNodeTree) and Assigned(Tree) then
  begin
    Tree.Clear;
    Recurse(nil, TJvLinkLabelAccessProtected(LinkLabel).FNodeTree.Root);
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
