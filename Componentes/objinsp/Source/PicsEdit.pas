(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.006                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit PicsEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ExtDlgs, StdCtrls, PropEdit, JPEG;

type
  TfrmPicture = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    opdImage: TOpenPictureDialog;
    svdImage: TSavePictureDialog;
    pnlImage: TPanel;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    pntImage: TPaintBox;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pntImagePaint(Sender: TObject);
  private
    { Private declarations }
    FPicture: TPicture;
  public
    { Public declarations }
    property Picture: TPicture read FPicture;
  end;

  TPicturePropertyEditor = class(TPropertyEditor)
    function Execute: Boolean; override;
  end;

implementation

{$R *.DFM}

function TPicturePropertyEditor.Execute: Boolean;
begin
  with TfrmPicture.Create(nil) do
  try
    with Prop do
      if PropType=TypeInfo(TPicture) then FPicture.Assign(TPicture(Prop.AsObject))
      else
        if PropType=TypeInfo(TBitmap) then
        begin
          FPicture.Bitmap:=TBitmap(Prop.AsObject);
          opdImage.Filter:='Bitmaps (*.bmp)|*.bmp';
          svdImage.Filter:=opdImage.Filter;
        end
        else
          if PropType=TypeInfo(TIcon) then
          begin
            FPicture.Icon:=TIcon(Prop.AsObject);
            opdImage.Filter:='Icon files (*.ico)|*.ico';
            svdImage.Filter:=opdImage.Filter;
          end
          else FPicture.Graphic:=TGraphic(Prop.AsObject);
    Result:=ShowModal=mrOk;
    if Result then
      with Prop do
        if PropType=TypeInfo(TPicture) then TPicture(Prop.AsObject).Assign(FPicture)
        else
          Prop.AsObject:=FPicture.Graphic;
  finally
    Free;
  end;
end;

procedure TfrmPicture.btnLoadClick(Sender: TObject);
begin
  with opdImage do
    if Execute then
    begin
      FPicture.LoadFromFile(FileName);
      pntImage.Repaint;
    end;
end;

procedure TfrmPicture.btnSaveClick(Sender: TObject);
begin
  with FPicture,svdImage do
    if not Graphic.Empty and Execute then SaveToFile(FileName);
end;

procedure TfrmPicture.btnClearClick(Sender: TObject);
begin
  FPicture.Graphic:=nil;
  pntImage.Repaint;
end;

procedure TfrmPicture.FormCreate(Sender: TObject);
begin
  FPicture:=TPicture.Create;
end;

procedure TfrmPicture.FormDestroy(Sender: TObject);
begin
  FPicture.Free;
end;

procedure TfrmPicture.pntImagePaint(Sender: TObject);
var
  R: TRect;
begin
  if Assigned(FPicture.Graphic) and not FPicture.Graphic.Empty then
  begin
    with FPicture do R:=Rect(0,0,Width,Height);
    with pntImage,R do
    begin
      if (Right>ClientWidth) or (Bottom>ClientHeight) then
        if Right>Bottom then
        begin
          Right:=ClientWidth;
          Bottom:=Right*FPicture.Height div FPicture.Width;
        end
        else
        begin
          Bottom:=ClientHeight;
          Right:=Bottom*FPicture.Width div FPicture.Height;
        end;
      OffsetRect(R,(ClientWidth-Right) div 2,(ClientHeight-Bottom) div 2);
      Canvas.StretchDraw(R,FPicture.Graphic);
    end;
  end;
end;

end.
