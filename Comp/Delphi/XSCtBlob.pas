{$I XSqlDir.inc}
{$WEAKPACKAGEUNIT ON}

unit XSCtBlob;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db
  {$IFNDEF XSQL_C3}, Jpeg {$ENDIF};

type
  { TSDCntrBlobField }
  PInteger	= ^Integer;

  TSDCntrBlobField	= class(TBlobField)
  private
    FHeaderRemove: Boolean;
    procedure LoadFromBitmap(Bitmap: TBitmap);
    procedure SaveToBitmap(Bitmap: TBitmap);
    procedure SaveToPicture(Picture: TPicture);

    function FindHeader(Buffer: PChar; BufSize: Integer): string;
    function SetImagePos(BlobStream: TStream; pSizePos: PInteger): string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromFile(const FileName: string);
  published
    property HeaderRemove: Boolean read FHeaderRemove write FHeaderRemove default True;
  end;

implementation

const
  GswHeader	= 'Gupta:';
  CtdHeader	= 'Centura:';
  EmbHeader	= 'EMBEDDED';

  GswJpegFullHdr 	= 'Gupta:JPEG'#00 + #00#00#00#00 + #$0C#00#00#00;
  GswJpegJpegSizeOff	= $0B;
  GswBmpFullHdr 	= 'Gupta:BMP'#00 + #00#00#00#00 + #$04#00#00#00;
  GswBmpJpegSizeOff	= $0A;


{ TSDCntrBlobField }
constructor TSDCntrBlobField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHeaderRemove := True;
end;

procedure TSDCntrBlobField.Assign(Source: TPersistent);
begin
  if Source is TBitmap then begin
    LoadFromBitmap(TBitmap(Source));
    Exit;
  end;
  if (Source is TPicture) and (TPicture(Source).Graphic is TBitmap) then begin
    LoadFromBitmap(TBitmap(TPicture(Source).Graphic));
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TSDCntrBlobField.AssignTo(Dest: TPersistent);
begin
  if Dest is TBitmap then begin
    SaveToBitmap(TBitmap(Dest));
    Exit;
  end;
  if Dest is TPicture then begin
    SaveToPicture(TPicture(Dest));
    Exit;
  end;
  inherited AssignTo(Dest);
end;

procedure TSDCntrBlobField.LoadFromBitmap(Bitmap: TBitmap);
var
  BlobStream: TStream;
  sOldHdr, sFullHdr: string;
  ImageSize, SizePos, DataPos: Integer;
begin
  DataPos := 0;
  BlobStream := DataSet.CreateBlobStream(Self, bmRead);
  try
    if BlobStream.Size > 0 then begin
	// save old format
      sOldHdr := SetImagePos(BlobStream, @SizePos);
      DataPos := BlobStream.Position;
      	// read old header(info) before real data
      if DataPos > 0 then begin
        SetLength(sFullHdr, DataPos);
        FillChar( PChar(@sFullHdr[1])^, DataPos, $00 );
        BlobStream.Position := 0;
        BlobStream.ReadBuffer(PChar(@sFullHdr[1])^, DataPos);
      end;
      BlobStream.Free;
      BlobStream := nil;
    end;
    BlobStream := DataSet.CreateBlobStream(Self, bmWrite);
    if DataPos > 0 then
      BlobStream.Position := DataPos;

    Bitmap.SaveToStream(BlobStream);

    if DataPos > 0 then begin
      ImageSize := BlobStream.Position - DataPos;
      LongInt( Pointer(@sFullHdr[SizePos+1])^ ) := ImageSize;
      BlobStream.Position := 0;
      BlobStream.WriteBuffer(PChar(@sFullHdr[1])^, DataPos);
    end;
  finally
    if BlobStream <> nil then
      BlobStream.Free;
  end;
end;

procedure TSDCntrBlobField.LoadFromFile(const FileName: string);
var
  Stream, mstream: TStream;
  sExt, sHdr: string;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
{$IFNDEF XSQL_C3}
    sHdr := GswJpegFullHdr;
    if FHeaderRemove then begin
      sExt := AnsiUpperCase(ExtractFileExt(FileName));
      if (sExt = '.JPG') or (sExt = '.JPEG') then begin
        Integer( Pointer(@sHdr[GswJpegJpegSizeOff+1])^ ) := Stream.Size;
        mstream := TMemoryStream.Create;
        mstream.Write( PChar(@sHdr[1])^, Length(sHdr) );
        mstream.CopyFrom(Stream, 0);
        Stream.Free;
        Stream := mstream;
      end;
    end;
{$ENDIF}
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TSDCntrBlobField.SaveToBitmap(Bitmap: TBitmap);
var
  BlobStream: TStream;
begin
  BlobStream := DataSet.CreateBlobStream(Self, bmRead);
  try
    if HeaderRemove then
      SetImagePos(BlobStream, nil);

    Bitmap.LoadFromStream(BlobStream);
  finally
    BlobStream.Free;
  end;
end;

procedure TSDCntrBlobField.SaveToPicture(Picture: TPicture);
var
  BlobStream: TStream;
  sHdr: string;
begin
  BlobStream := DataSet.CreateBlobStream(Self, bmRead);
  try
    if HeaderRemove then
      sHdr := SetImagePos(BlobStream, nil);
    if Pos('JPEG', sHdr) > 0 then begin
      if Picture.Graphic = nil then
        Picture.Graphic := TJPEGImage.Create;
      TJPEGImage( Picture.Graphic ).LoadFromStream(BlobStream);
    end else
      Picture.Bitmap.LoadFromStream(BlobStream);
  finally
    BlobStream.Free;
  end;
end;

function TSDCntrBlobField.FindHeader(Buffer: PChar; BufSize: Integer): string;
var
  CurHdr: string;
begin
  Result := '';

  if (BufSize < Length(GswHeader)) or (BufSize < Length(CtdHeader)) then
    Exit;
  CurHdr := Buffer;
  if (Pos(GswHeader, CurHdr) = 1) or (Pos(CtdHeader, CurHdr) = 1) then
    Result := CurHdr;
end;

// returns header number in KnownFormats array
function TSDCntrBlobField.SetImagePos(BlobStream: TStream; pSizePos: PInteger): string;
{
SQLWindows stored OLE Objects as:
0            0D     13  17  1B  1F  23     x     x+9 x+$0D
|            |      |   ||  |   |   |      |     |||||
Gupta:EMBEDDED                      ObjName      sizedata
}
const
  ObjNameOff	= $23;
  ObjRelSizeOff	= $09;
  ObjRelDataOff = $0D;
  PicRelSizeOff	= $01;
  PicRelDataOff = $09;
var
  Size: LongInt;
  BufSize, Off, NewPos: Integer;
  BufPtr: PChar;
  CurHeader: string;
begin
  Result := '';
  Off := 0;
  NewPos := 0;
  BufSize := 500;

  Size := BlobStream.Size;
  if Size = 0 then Exit;

  BufPtr := StrAlloc( BufSize );
  FillChar( BufPtr^, BufSize, $0 );
  try
    BufSize := BlobStream.Read(BufPtr^, BufSize);
	// returns known format header, for example: <Gupta:BMP>
    CurHeader := FindHeader(BufPtr, BufSize);
    if Length(CurHeader) > 0 then begin
	// if embedded object
      if Pos(EmbHeader, CurHeader) > 0 then begin
        Off := ObjNameOff;

	// find end of <ObjName>
        while (PChar(BufPtr+Off)^ <> #0) do
        if Off < BufSize
        then Inc(Off)
        else Break;
        Inc(Off, ObjRelDataOff);
        if Off < BufSize then begin
          if pSizePos <> nil then
            pSizePos^ := Off - (ObjRelDataOff - ObjRelSizeOff);
          NewPos := Off;
          Result := CurHeader;
        end;
      end else begin
        Inc(Off, Length(CurHeader) + PicRelDataOff);
        if Off < BufSize then begin
          if pSizePos <> nil then
            pSizePos^ := Off - (PicRelDataOff - PicRelSizeOff);
          NewPos := Off;
          Result := CurHeader;
        end;
      end;
    end;
  finally
    StrDispose(BufPtr);
  end;
  BlobStream.Position := NewPos;
end;

end.
