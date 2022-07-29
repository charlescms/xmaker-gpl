(*  GREATIS BONUS * TIconList                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit ILDesign;

interface

{$IFDEF VER140}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER150}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER170}
{$DEFINE NEWDSGNINTF}
{$ENDIF}
{$IFDEF VER180}
{$DEFINE NEWDSGNINTF}
{$ENDIF}

uses
  {$IFDEF NEWDSGNINTF}
  DesignIntf, DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  Classes, SysUtils, Forms, ComCtrls, IconList, Controls
  {$IFNDEF VER100}
  , ImgList;
  {$ELSE}
  ;
  {$ENDIF}

type

  TIconListEditor=class(TComponentEditor)
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

implementation

function TIconListEditor.GetVerb(Index: Integer): string;
begin
  Result:='View icons...';
end;

function TIconListEditor.GetVerbCount: Integer;
begin
  Result:=1;
end;

procedure TIconListEditor.ExecuteVerb(Index: Integer);
var
  i: Integer;
begin
  with TfrmIconListView.Create(Application) do
  try
    with lsvIcons,Component as TIconList do
    begin
      Caption:=Name+' - '+IntToStr(Count)+' icon(s)';
      if IconType=itLarge then
      begin
        ViewStyle:=vsIcon;
        LargeImages:=TImageList(TIconList);
      end
      else
      begin
        ViewStyle:=vsSmallIcon;
        SmallImages:=TImageList(TIconList);
      end;
      for i:=0 to Pred(Count) do
        with Items.Add do
        begin
          Caption:=IntToStr(i);
          ImageIndex:=i;
        end;
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('Greatis',[TIconList]);
  RegisterComponentEditor(TIconList,TIconListEditor);
end;

end.
