�
 TFORMSHAKE 0@  TPF0
TFormShake	FormShakeLeft� Top� BorderStylebsNoneCaption	FormShakeClientHeight\ClientWidthFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ScaledOnCreate
FormCreatePixelsPerInchx
TextHeight TPageControlPageControlLeft Top WidthHeight\
ActivePageTabSheetCodeAlignalClientTabOrder  	TTabSheetTabSheetCodeCaptionSource code TMemoMemoCodeLeft Top WidthHeight=AlignalClientFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style Lines.Stringsunit teShake; 	interface 4uses Classes, Windows, SysUtils, Graphics, TransEff; type-  TShakeTransition = class(TTransitionEffect)  protected;    procedure DoExecute(Data: TTETransitionData); override;.    function  NeedDstImage: Boolean; override;  end; implementation uses  teRender, teChrono; 0function TShakeTransition.NeedDstImage: Boolean;begin  Result := False;end; >procedure TShakeTransition.DoExecute(Data: TTETransitionData);var  Chrono: TTEChrono;  PosX,  PosY: Integer;begin  Chrono := TTEChrono.Create;  try    Randomize;    Chrono.Start;/    while Chrono.Milliseconds < Milliseconds do	    begin      PosX := Random(7);      PosY := Random(7); I      BitBlt(Data.Canvas.Handle, PosX-3, PosY-3, Data.Width, Data.Height,4        Data.SrcBmp.Canvas.Handle, 0, 0, cmSrcCopy);       Sleep(35);    end;=    BitBlt(Data.Canvas.Handle, 0, 0, Data.Width, Data.Height,2      Data.SrcBmp.Canvas.Handle, 0, 0, cmSrcCopy);	  finally    Chrono.Free;  end;end; end. 
ParentFontReadOnly	
ScrollBarsssBothTabOrder WordWrap   	TTabSheetTabSheetExecuteCaptionExecute TFormContainerFormContainerLeft Top WidthHeight=AlignalClientTabOrder      