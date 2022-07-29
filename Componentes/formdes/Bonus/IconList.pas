(*  GREATIS BONUS * TIconList                 *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit IconList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellAPI, StdCtrls, ComCtrls, ExtCtrls
  {$IFNDEF VER100}
  , ImgList;
  {$ELSE}
  ;
  {$ENDIF}

type

  TfrmIconListView = class(TForm)
    btnClose: TButton;
    lsvIcons: TListView;
    procedure lsvIconsEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TIconType = (itLarge,itSmall);

  TExtractEvent = procedure(Sender: TObject; FileName: string; var AllowExtract: Boolean) of object;

  TIconList = class(TCustomImageList)
  private
    { Private declarations }
    fIconType: TIconType;
    fFiles: TStrings;
    fOnExtract: TExtractEvent;
    procedure SetIconType(Value: TIconType);
    procedure SetFiles(Value: TStrings);
    procedure LoadIcons;
    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
  protected
    { Protected declarations }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadState(Reader: TReader); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property IconType: TIconType read fIconType write SetIconType;
    property Files: TStrings read fFiles write SetFiles;
    property DrawingStyle;
    property ImageType;
    property OnExtract: TExtractEvent read fOnExtract write fOnExtract;
  end;

implementation

{$R *.DFM}

procedure TfrmIconListView.lsvIconsEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit:=False;
end;

constructor TIconList.Create(AOwner: TComponent);
begin
  inherited;
  fFiles:=TStringList.Create;
  Width:=32;
  Height:=32;
end;

destructor TIconList.Destroy;
begin
  fFiles.Free;
  inherited;
end;

procedure TIconList.ReadLeft(Reader: TReader);
var
  DI: LongRec;
begin
  DI:=LongRec(DesignInfo);
  DI.Lo:=Reader.ReadInteger;
  DesignInfo:=Longint(DI);
end;

procedure TIconList.ReadTop(Reader: TReader);
var
  DI: LongRec;
begin
  DI:=LongRec(DesignInfo);
  DI.Hi:=Reader.ReadInteger;
  DesignInfo:=Longint(DI);
end;

procedure TIconList.WriteLeft(Writer: TWriter);
begin
  Writer.WriteInteger(LongRec(DesignInfo).Lo);
end;

procedure TIconList.WriteTop(Writer: TWriter);
begin
  Writer.WriteInteger(LongRec(DesignInfo).Hi);
end;

procedure TIconList.DefineProperties(Filer: TFiler);
var
  Ancestor: TComponent;
  Info: Longint;
begin
  Info:=0;
  Ancestor:=TComponent(Filer.Ancestor);
  if Ancestor<>nil then Info:=Ancestor.DesignInfo;
  Filer.DefineProperty('Left',ReadLeft,WriteLeft,
    LongRec(DesignInfo).Lo<>LongRec(Info).Lo);
  Filer.DefineProperty('Top',ReadTop,WriteTop,
    LongRec(DesignInfo).Hi<>LongRec(Info).Hi);
end;

procedure TIconList.ReadState(Reader: TReader);
begin
  inherited;
  LoadIcons;
end;

procedure TIconList.SetIconType(Value: TIconType);
begin
  if IconType<>Value then
  begin
    fIconType:=Value;
    if IconType=itLarge then
    begin
      Width:=32;
      Height:=32;
    end
    else
    begin
      Width:=16;
      Height:=16;
    end;
    LoadIcons;
  end;
end;

procedure TIconList.SetFiles(Value: TStrings);
begin
  fFiles.Assign(Value);
  LoadIcons;
end;

procedure TIconList.LoadIcons;
var
  FileIndex,IconIndex: Integer;
  Icon: TIcon;
  Icon16,Icon32: HICON;
  AllowExtract: Boolean;
begin
  if csDesigning in ComponentState then Screen.Cursor:=crHourGlass;
  try
    Clear;
    for FileIndex:=0 to Pred(Files.Count) do
      if Files[FileIndex]<>'' then
      begin
        if Assigned(fOnExtract) then
        begin
          AllowExtract:=True;
          fOnExtract(Self,Files[FileIndex],AllowExtract);
          if not AllowExtract then Continue;
        end;
        if IconType=itLarge then
        begin
          Width:=32;
          Height:=32;
        end
        else
        begin
          Width:=16;
          Height:=16;
        end;
        Icon:=TIcon.Create;
        try
          for IconIndex:=0 to Pred(ExtractIconEx(PChar(Files[FileIndex]),-1,Icon16,Icon32,0)) do
          begin
            ExtractIconEx(PChar(Files[FileIndex]),IconIndex,Icon32,Icon16,1);
            if IconType=itLarge then Icon.Handle:=Icon32
            else Icon.Handle:=Icon16;
            AddIcon(Icon);
          end;
        finally
          Icon.Free;
        end;
      end;
  finally
    if csDesigning in ComponentState then Screen.Cursor:=crDefault;
  end;
end;

end.
