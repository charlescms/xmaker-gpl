�
 TFORMSIMPLEWIPE 04  TPF0TFormSimpleWipeFormSimpleWipeLeft� Top� BorderStylebsNoneCaptionFormSimpleWipeClientHeight\ClientWidthFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ScaledOnCreate
FormCreatePixelsPerInchx
TextHeight TPageControlPageControlLeft Top WidthHeight\
ActivePageTabSheetCodeAlignalClientTabOrder  	TTabSheetTabSheetCodeCaptionSource code TMemoMemoCodeLeft Top WidthHeight=AlignalClientFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.Stringsunit teSimpleWipe; 	interface =uses Classes, Windows, SysUtils, Graphics, TransEff, teTimed; type7  TSimpleWipeTransition = class(TTimedTransitionEffect)	  private    FDirection: Word; .    procedure SetDirection(const Value: Word);  protected    R: TRect; N    procedure Initialize(Data: TTETransitionData; var Frames: Word); override;X    procedure ExecuteFrame(Data: TTETransitionData; CurrentFrame, Step: Word); override;#    function  DirectionToUse: Word;3    function  RenderWhenClipped: Boolean; override;.    function  NeedSrcImage: Boolean; override;  public!    constructor Create; override; Q    property Direction: Word read FDirection write SetDirection default tedRight;  end; implementation uses  teRender; )constructor TSimpleWipeTransition.Create;begin  inherited Create;   Direction := tedRight;end; 4function TSimpleWipeTransition.DirectionToUse: Word;begin  Result := Direction;   if Reversed then    case Direction of       tedDown : Result := tedUp;"      tedUp   : Result := tedDown;"      tedRight: Result := tedLeft;#      tedLeft : Result := tedRight;    end;end; @procedure TSimpleWipeTransition.SetDirection(const Value: Word);begin  if FDirection <> Value then  begin    if(Value <> tedRight) and      (Value <> tedLeft ) and      (Value <> tedDown ) and      (Value <> tedUp   ) then2      raise Exception.Create(rsTEValueNotAllowed);     FDirection := Value;  end;end; :function TSimpleWipeTransition.RenderWhenClipped: Boolean;begin  Result := False;end; 5function TSimpleWipeTransition.NeedSrcImage: Boolean;begin  Result := False;end; Vprocedure TSimpleWipeTransition.Initialize(Data: TTETransitionData; var Frames: Word);begin  case DirectionToUse of    tedDown:      begin        Frames := Data.Height;'        R := Rect(0, 0, Data.Width, 0);
      end;
    tedUp:      begin        Frames := Data.Height;;        R := Rect(0, Data.Height, Data.Width, Data.Height);
      end;    tedRight:      begin        Frames := Data.Width;(        R := Rect(1, 0, 0, Data.Height);
      end;    tedLeft:      begin        Frames := Data.Width;:        R := Rect(Data.Width, 0, Data.Width, Data.Height);
      end;  end;end; Eprocedure TSimpleWipeTransition.ExecuteFrame(Data: TTETransitionData;  CurrentFrame, Step: Word);begin  case DirectionToUse of    tedDown:      begin        R.Top     := R.Bottom;%        R.Bottom  := R.Bottom + Step;
      end;
    tedUp:      begin        R.Bottom  := R.Top;"        R.Top     := R.Top - Step;
      end;    tedRight:      begin        R.Left   := R.Right;#        R.Right  := R.Right + Step;
      end;    tedLeft:      begin        R.Right  := R.Left;"        R.Left   := R.Left - Step;
      end;  end; ;  BitBlt(Data.Canvas.Handle, R.Left, R.Top, R.Right-R.Left,I    R.Bottom-R.Top, Data.DstBmp.Canvas.Handle, R.Left, R.Top, cmSrcCopy); '  UnionRect(UpdateRect, UpdateRect, R);end; end. 
ParentFontReadOnly	
ScrollBarsssBothTabOrder WordWrap   	TTabSheetTabSheetExecuteCaptionExecute TFormContainerFormContainerLeft Top WidthHeight=AlignalClientTabOrder      