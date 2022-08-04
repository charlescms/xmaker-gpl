(*  GREATIS BONUS * TCoolorDialog             *)
(*  Copyright (C) 1998-2003 Greatis Software  *)
(*  http://www.greatis.com/delphibonus.htm    *)

unit Colors;

interface

uses Windows, Graphics, SysUtils;

type
  TRealType = Double;

  TRGB = record Red,Green,Blue: TRealType end;
  TCMY = record Cyan,Magenta,Yellow: TRealType end;
  TCMYK = record Cyan,Magenta,Yellow,Black: TRealType end;
  THSB = record Hue,Saturation,Brightness: TRealType end;
  TRGBColor = record Red,Green,Blue: Integer end;
  TCMYColor = record Cyan,Magenta,Yellow: Integer end;
  TCMYKColor = record Cyan,Magenta,Yellow,Black: Integer end;
  THSBColor = record Hue,Saturation,Brightness: Integer end;
  THTMLColor = string;
  TRGBHex = string;

function MakeHSB(H,S,B: TRealType): THSB;
function MakeRGB(R,G,B: TRealType): TRGB;
function MakeCMY(C,M,Y: TRealType): TCMY;
function MakeCMYK(C,M,Y,K: TRealType): TCMYK;
function MakeGrayRGB(B: TRealType): TRGB;
function MakeGrayColor(B: TRealType): TColor;
function RGBEqual(Color1,Color2: TRGB): Boolean;
function RGBGray(Color: TRGB): Boolean;
function HueToColor(Hue: TRealType): TColor;
function HueToRGB(Hue: TRealType): TRGB;
function RGBToHue(RGB: TRGB): TRealType;
function ColorToRGB(Value: TColor): TRGB;
function RGBToColor(Value: TRGB): TColor;
function RGBToCMY(Value: TRGB): TCMY;
function CMYToRGB(Value: TCMY): TRGB;
function ColorToCMY(Value: TColor): TCMY;
function CMYToColor(Value: TCMY): TColor;
function RGBToCMYK(Value: TRGB): TCMYK;
function CMYKToRGB(Value: TCMYK): TRGB;
function ColorToCMYK(Value: TColor): TCMYK;
function CMYKToColor(Value: TCMYK): TColor;
function RGBToHSB(Value: TRGB): THSB;
function HSBToRGB(Value: THSB): TRGB;
function HSBToColor(Value: THSB): TColor;
function ColorToHSB(Value: TColor): THSB;
function RGBToRGBColor(Value: TRGB): TRGBColor;
function RGBColorToRGB(Value: TRGBColor): TRGB;
function HSBToHSBColor(Value: THSB): THSBColor;
function HSBColorToHSB(Value: THSBColor): THSB;
function CMYToCMYColor(Value: TCMY): TCMYColor;
function CMYColorToCMY(Value: TCMYColor): TCMY;
function CMYKToCMYKColor(Value: TCMYK): TCMYKColor;
function CMYKColorToCMYK(Value: TCMYKColor): TCMYK;
function HTMLToColor(Value: THTMLColor): TColor;
function ColorToHTML(Value: TColor): THTMLColor;
function RGBHexToColor(Value: TRGBHex): TColor;
function ColorToRGBHex(Value: TColor): TRGBHex;

implementation

{$I HUETORGB.INC}

function MakeHSB(H,S,B: TRealType): THSB;
begin
  with Result do
  begin
    Hue:=H-Int(H/360);
    if Hue<0 then Hue:=Hue+360;
    Saturation:=S;
    Brightness:=B;
  end;
end;

function MakeRGB(R,G,B: TRealType): TRGB;
begin
  with Result do
  begin
    Red:=R;
    Green:=G;
    Blue:=B;
  end;
end;

function MakeCMY(C,M,Y: TRealType): TCMY;
begin
  with Result do
  begin
    Cyan:=C;
    Magenta:=M;
    Yellow:=Y;
  end;
end;

function MakeCMYK(C,M,Y,K: TRealType): TCMYK;
begin
  with Result do
  begin
    Cyan:=C;
    Magenta:=M;
    Yellow:=Y;
    Black:=K;
  end;
end;

function MakeGrayRGB(B: TRealType): TRGB;
begin
  with Result do
  begin
    Red:=B;
    Green:=B;
    Blue:=B;
  end;
end;

function MakeGrayColor(B: TRealType): TColor;
begin
  Result:=RGB(Round(B),Round(B),Round(B));
end;

function RGBEqual(Color1,Color2: TRGB): Boolean;
begin
  Result:=
    (Color1.Red=Color2.Red) and
    (Color1.Green=Color2.Green) and
    (Color1.Blue=Color2.Blue);
end;

function RGBGray(Color: TRGB): Boolean;
begin
  with Color do
    Result:=(Red=Green) and (Red=Blue);
end;

function HueToColor(Hue: TRealType): TColor;
begin
  Result:=RGBToColor(HueToRGB(Hue));
end;

function HueToRGB(Hue: TRealType): TRGB;
begin
  Hue:=Hue-360*Int(Hue/360);
  if Hue<0 then Hue:=Hue+360;
  if Hue>=360 then Hue:=Hue-360;
  Result:=HueRGB[Round(Hue)];
end;

function RGBToHue(RGB: TRGB): TRealType;
var
  Hue: Integer;
  Delta,NewDelta: TRealType;

  function GetDelta(RGB1,RGB2: TRGB): TRealType;
  begin
    Result:=Abs(RGB1.Red-RGB2.Red)+Abs(RGB1.Green-RGB2.Green)+Abs(RGB1.Blue-RGB2.Blue);
  end;

begin
  Delta:=255*3;
  Result:=0;
  for Hue:=0 to 359 do
  begin
    NewDelta:=GetDelta(HueRGB[Hue],RGB);
    if NewDelta<Delta then
    begin
      Result:=Hue;
      Delta:=NewDelta;
    end;
  end;
end;

function ColorToRGB(Value: TColor): TRGB;
begin
  with Result do
  begin
    Red:=Value and $FF;
    Green:=Value shr 8 and $FF;
    Blue:=Value shr 16 and $FF;
  end;
end;

function RGBToColor(Value: TRGB): TColor;
begin
  with Value do
    Result:=RGB(Round(Red),Round(Green),Round(Blue));
end;

function RGBToCMY(Value: TRGB): TCMY;
begin
  with Value,Result do
  begin
    Cyan:=255-Red;
    Magenta:=255-Green;
    Yellow:=255-Blue;
  end;
end;

function CMYToRGB(Value: TCMY): TRGB;
begin
  with Value,Result do
  begin
    Red:=255-Cyan;
    Green:=255-Magenta;
    Blue:=255-Yellow;
  end;
end;

function ColorToCMY(Value: TColor): TCMY;
begin
  Result:=RGBToCMY(ColorToRGB(Value));
end;

function CMYToColor(Value: TCMY): TColor;
begin
  Result:=RGBToColor(CMYToRGB(Value));
end;

function RGBToCMYK(Value: TRGB): TCMYK;
begin
  with Value,Result do
  begin
    Cyan:=255-Red;
    Magenta:=255-Green;
    Yellow:=255-Blue;
    Black:=Magenta;
    if Cyan<Black then Black:=Cyan;
    if Yellow<Black then Black:=Yellow;
    Cyan:=100*(Cyan-Black)/255;
    Magenta:=100*(Magenta-Black)/255;
    Yellow:=100*(Yellow-Black)/255;
    Black:=100*Black/255;
  end;
end;

function CMYKToRGB(Value: TCMYK): TRGB;
begin
  with Value,Result do
  begin
    Red:=255-255*(Cyan+Black)/100;
    if Red<0 then Red:=0;
    Green:=255-255*(Magenta+Black)/100;
    if Green<0 then Green:=0;
    Blue:=255-255*(Yellow+Black)/100;
    if Blue<0 then Blue:=0;
  end;
end;

function ColorToCMYK(Value: TColor): TCMYK;
begin
  Result:=RGBToCMYK(ColorToRGB(Value));
end;

function CMYKToColor(Value: TCMYK): TColor;
begin
  Result:=RGBToColor(CMYKToRGB(Value));
end;

function RGBToHSB(Value: TRGB): THSB;

  function GetBrightness: TRealType;
  var
    Max: TRealType;
  begin
    with Value do
    begin
      Max:=Red;
      if Max<Blue then Max:=Blue;
      if Max<Green then Max:=Green;
      if Max>0 then
      begin
        Red:=255*Red/Max;
        Green:=255*Green/Max;
        Blue:=255*Blue/Max;
        Result:=100*Max/255;
      end
      else Result:=0;
    end;
  end;

  function GetSaturation: TRealType;
  var
    Max,Min: TRealType;
  begin
    with Value do
    begin
      Max:=Red;
      if Max<Blue then Max:=Blue;
      if Max<Green then Max:=Green;
      Min:=Red;
      if Min>Blue then Min:=Blue;
      if Min>Green then Min:=Green;
      Result:=100*(Max-Min)/255;
      if Red=Min then Red:=0
      else
        if Red=Max then Red:=255
        else Red:=255/((255-Red)/(Red-Min)+1);
      if Green=Min then Green:=0
      else
        if Green=Max then Green:=255
        else Green:=255/((255-Green)/(Green-Min)+1);
      if Blue=Min then Blue:=0
      else
        if Blue=Max then Blue:=255
        else Blue:=255/((255-Blue)/(Blue-Min)+1);
    end;
  end;

begin
  with Value,Result do
    if (Red=255) and (Green=255) and (Blue=255) then
    begin
      Hue:=0;
      Saturation:=0;
      Brightness:=100;
    end
    else
    begin
      Brightness:=GetBrightness;
      Saturation:=GetSaturation;
      Hue:=RGBToHue(Value);
    end;
end;

function HSBToRGB(Value: THSB): TRGB;
var
  ARGB: TRGB;
begin
  with Value,Result do
    if (Saturation=0) and (Brightness=100) then
    begin
      Red:=255;
      Green:=255;
      Blue:=255;
    end
    else
    begin
      ARGB:=HueToRGB(Hue);
      Red:=Brightness*(ARGB.Red+(100-Saturation)*(255-ARGB.Red)/100)/100;
      Green:=Brightness*(ARGB.Green+(100-Saturation)*(255-ARGB.Green)/100)/100;
      Blue:=Brightness*(ARGB.Blue+(100-Saturation)*(255-ARGB.Blue)/100)/100;
    end;
end;

function HSBToColor(Value: THSB): TColor;
begin
  Result:=RGBToColor(HSBToRGB(Value));
end;

function ColorToHSB(Value: TColor): THSB;
begin
  Result:=RGBToHSB(ColorToRGB(Value));
end;

function RGBToRGBColor(Value: TRGB): TRGBColor;
begin
  Result.Red:=Round(Value.Red);
  Result.Green:=Round(Value.Green);
  Result.Blue:=Round(Value.Blue);
end;

function RGBColorToRGB(Value: TRGBColor): TRGB;
begin
  Result.Red:=Value.Red;
  Result.Green:=Value.Green;
  Result.Blue:=Value.Blue;
end;

function HSBToHSBColor(Value: THSB): THSBColor;
begin
  Result.Hue:=Round(Value.Hue);
  Result.Saturation:=Round(Value.Saturation);
  Result.Brightness:=Round(Value.Brightness);
end;

function HSBColorToHSB(Value: THSBColor): THSB;
begin
  Result.Hue:=Value.Hue;
  Result.Saturation:=Value.Saturation;
  Result.Brightness:=Value.Brightness;
end;

function CMYToCMYColor(Value: TCMY): TCMYColor;
begin
  Result.Cyan:=Round(Value.Cyan);
  Result.Magenta:=Round(Value.Magenta);
  Result.Yellow:=Round(Value.Yellow);
end;

function CMYColorToCMY(Value: TCMYColor): TCMY;
begin
  Result.Cyan:=Value.Cyan;
  Result.Magenta:=Value.Magenta;
  Result.Yellow:=Value.Yellow;
end;

function CMYKToCMYKColor(Value: TCMYK): TCMYKColor;
begin
  Result.Cyan:=Round(Value.Cyan);
  Result.Magenta:=Round(Value.Magenta);
  Result.Yellow:=Round(Value.Yellow);
  Result.Black:=Round(Value.Black);
end;

function CMYKColorToCMYK(Value: TCMYKColor): TCMYK;
begin
  Result.Cyan:=Value.Cyan;
  Result.Magenta:=Value.Magenta;
  Result.Yellow:=Value.Yellow;
  Result.Black:=Value.Black;
end;

function HTMLToColor(Value: THTMLColor): TColor;
begin
  if (Value<>'') and (Value[1]='#') then Delete(Value,1,1);
  Result:=RGBHexToColor(Value);
end;

function ColorToHTML(Value: TColor): THTMLColor;
begin
  Result:='#'+ColorToRGBHex(Value);
end;

function RGBHexToColor(Value: TRGBHex): TColor;
begin
  if Length(Value)=6 then
  begin
    Value:=Copy(Value,5,2)+Copy(Value,3,2)+Copy(Value,1,2);
    Result:=StrToInt('$'+Value);
  end
  else Result:=clBlack;
end;

function ColorToRGBHex(Value: TColor): TRGBHex;
type
  TColorRec = record
    Red,Green,Blue,Index: Byte;
  end;
begin
  with TColorRec(Value) do
    Result:=Format('%2.2x%2.2x%2.2x',[Red,Green,Blue]);
end;

end.
