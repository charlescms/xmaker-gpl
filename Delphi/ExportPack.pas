(***************************************************************)
(* PACKAGE: EXPORTPACK 1.0                                     *)
(***************************************************************)
(* Autor: Ismael Fernández Bustos (ismafb@terra.es)            *)
(* Notas: Exportadores de informes de quickreport y fastreport *)
(*        a formatos gráficos (JPG, BMP, WMF, EMF y PDF).      *)
(*        La exportación a PDF utiliza el componente TPrintPDF *)
(*        de K. Nishita (thanks) y ZLIB (thanks).              *)
(*                                                             *)
(* Fecha: 09/04/2002                                           *)
(***************************************************************)
unit ExportPack;

{.$DEFINE QUICKREPORT}
{$DEFINE FASTREPORT}
{.$DEFINE SPANISH}
{$DEFINE ENGLISH}

interface

uses
  WinProcs, Windows, Messages, SysUtils, Classes, Graphics, JPEG,
  Dialogs, StdCtrls, ExtCtrls {$IFDEF FASTREPORT}, FR_Class, FR_View {$ENDIF};

const
  {$IFDEF SPANISH}
  Filtro     = 'Archivo PDF (Alta Compresión)|*.PDF|Archivo PDF (Menor Compresión)|*.PDF|Archivos JPG|*.JPG|Archivos BMP|*.BMP|Archivos EMF|*.EMF|Archivos WMF|*.WMF';
  Error      = 'Error exportando informe';
  Guardar    = 'Guardar informe como...';
  Exportando = 'Exportando...';
  Pagina1De  = 'Página... 1 de';
  Pagina     = 'Página... ';
  De         = ' de ';
  {$ENDIF}

  {$IFDEF ENGLISH}
  Filtro     = 'PDF (High Compression)|*.PDF|PDF (Low Compression)|*.PDF|JPG Imagem|*.JPG|BMP Imagem|*.BMP|EMF Imagem|*.EMF|WMF Imagem|*.WMF';
  Error      = 'Erro de Exportação do Relatório';
  Guardar    = 'Salvar como...';
  Exportando = 'Exportando...';
  Pagina1De  = 'Página... 1 de';
  Pagina     = 'Página... ';
  De         = ' de ';
  {$ENDIF}

type
  {$IFDEF QUICKREPORT}
  { TExportQR have ExportQRFromPreview because in one TQuickRep you
    only can view a report and if you make a personal preview you
    can't export }
  TExportQR = class(TComponent)
  private
    { Private declarations }
    FReport : TQuickRep;
    FPreview: TQRPreview;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Report : TQuickRep write FReport;
    property Preview: TQRPreview write FPreview;
    procedure ExportQR; {Only Export Report}
    procedure ExportQRFromPreview;
    procedure ExportQRBMP (FileName : String; FromPreview : boolean = False);
    procedure ExportQRJPG (FileName : String; FromPreview : boolean = False);
    procedure ExportQREMF (FileName : String; FromPreview : boolean = False);
    procedure ExportQRWMF (FileName : String; FromPreview : boolean = False);
    procedure ExportQRPDF (FileName : String; Compresion : boolean; FromPreview : boolean = False);
  published
    { Published declarations }
  end;
  {$ENDIF}

  {$IFDEF FASTREPORT}
  { TExportFR don't have ExportFRFromPreview method because
    in only one TfrReport you can view varios reports }
  TExportFR = class(TComponent)
  private
    { Private declarations }
    FReport : TFRReport;
  protected
    { Protected declarations }
  public
    f_file: String;
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Report : TFRReport write FReport;
    procedure ExportFR; {Only export report}
    procedure ExportFRBMP (FileName : String);
    procedure ExportFRJPG (FileName : String);
    procedure ExportFREMF (FileName : String);
    procedure ExportFRWMF (FileName : String);
    procedure ExportFRPDF (FileName : String; Compresion : boolean);
  published
    { Published declarations }
  end;
  {$ENDIF}

procedure Register;

implementation

uses
  TnPDF, Prgrs, Printers;

procedure Register;
begin
  {$IFDEF QUICKREPORT}
  RegisterComponents('ExportPack', [TExportQR]);
  {$ENDIF}
  {$IFDEF FASTREPORT}
  RegisterComponents('ExportPack', [TExportFR]);
  {$ENDIF}
end;

// Funciones para cadenas
function PadL (Cad : string; Tam : integer; Car : string = '0') : string;
var
  i : integer;
  R : String;
begin
  R := '';
  for i := 1 to (Tam - length (Cad)) do begin
    R := R + Car;
  end;
  R := R + Cad;
  Result := R;
end;

function PadR (Cad : string; Tam : integer; Car : string = '0') : string;
var
  i : integer;
  R : String;
begin
  R := '';
  R := R + Cad;
  for i := 1 to (Tam - length (Cad)) do begin
    R := R + Car;
  end;
  Result := R;
end;

(*****************************)
(*        TEXPORTQR          *)
(*****************************)
{$IFDEF QUICKREPORT}
constructor TExportQR.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TExportQR.Destroy;
begin
  inherited Destroy;
end;

procedure TExportQR.ExportQR;
var
  SD    : TSaveDialog;
  Ruta  : String;
  Fich  : String;
  P     : integer;
begin
  if (not Assigned (FReport)) then
    Exit;
  { Intentamos abrir el dataset del report }
  if Assigned (FReport.DataSet) then begin
    try
      FReport.DataSet.Open;
    except
    end;
  end;
  FReport.Prepare; {Prepare report}
  try
    // Sacamos el cuadro de diálogo para guardar
    SD := TSaveDialog.Create(Self);
    SD.Title := Guardar;
    SD.Filter := Filtro;
    SD.FilterIndex := 0;
    if (SD.Execute) then begin
      Ruta := ExtractFilePath(SD.FileName);
      Fich := ExtractFileName(SD.FileName);
      P := Pos('.', Fich);
      if (P <> 0) then
        Fich := Copy (Fich, 1, P - 1);
      case SD.FilterIndex of
        1 : begin
              ExportQRPDF (Ruta + Fich, True);
            end;
        2 : begin
              ExportQRPDF (Ruta + Fich, False);
            end;
        3 : begin
              ExportQRJPG (Ruta + Fich);
            end;
        4 : begin
              ExportQRBMP (Ruta + Fich);
            end;
        5 : begin
              ExportQREMF (Ruta + Fich);
            end;
        6 : begin
              ExportQRWMF (Ruta + Fich);
            end;
      end;
    end;
    SD.Free;
    FReport.DataSet.Close;
    FReport.QRPrinter.Free;
    FReport.QRPrinter := nil;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportQR.ExportQRFromPreview;
var
  SD    : TSaveDialog;
  Ruta  : String;
  Fich  : String;
  P     : integer;
begin
  if (not Assigned (FPreview)) then
    Exit;
  try
    // Sacamos el cuadro de diálogo para guardar
    SD := TSaveDialog.Create(Self);
    SD.Title := Guardar;
    SD.Filter := Filtro;
    SD.FilterIndex := 0;
    if (SD.Execute) then begin
      Ruta := ExtractFilePath(SD.FileName);
      Fich := ExtractFileName(SD.FileName);
      P := Pos('.', Fich);
      if (P <> 0) then
        Fich := Copy (Fich, 1, P - 1);
      case SD.FilterIndex of
        1 : begin
              ExportQRPDF (Ruta + Fich, True, True);
            end;
        2 : begin
              ExportQRPDF (Ruta + Fich, False, True);
            end;
        3 : begin
              ExportQRJPG (Ruta + Fich, True);
            end;
        4 : begin
              ExportQRBMP (Ruta + Fich, True);
            end;
        5 : begin
              ExportQREMF (Ruta + Fich, True);
            end;
        6 : begin
              ExportQRWMF (Ruta + Fich, True);
            end;
      end;
    end;
    SD.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportQR.ExportQRBMP (FileName : String; FromPreview : boolean = False);
var
  i     : integer;
  MF    : TMetaFile;
  B     : TBitmap;
  Prg   : TFPrgrs;
begin
  if (not FromPreview) then begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FReport.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FReport.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FReport.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FReport.QRPrinter.PageCount);
        Prg.Accion.Update;
        B := TBitmap.Create;
        B.PixelFormat := pf24bit;
        MF := FReport.QRPrinter.GetPage(i);
        B.Width := MF.Width;
        B.Height := MF.Height;
        B.Canvas.Draw(0,0,MF);
        B.PixelFormat := pf8bit;
        B.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.BMP');
        B.Free;
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end
  else begin // Export from preview
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FPreview.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FPreview.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FPreview.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FPreview.QRPrinter.PageCount);
        Prg.Accion.Update;
        B := TBitmap.Create;
        B.PixelFormat := pf24bit;
        MF := FPreview.QRPrinter.GetPage(i);
        B.Width := MF.Width;
        B.Height := MF.Height;
        B.Canvas.Draw(0,0,MF);
        B.PixelFormat := pf8bit;
        B.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.BMP');
        B.Free;
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TExportQR.ExportQRJPG (FileName : String; FromPreview : boolean = False);
var
  i     : integer;
  MF    : TMetaFile;
  B     : TBitmap;
  J     : TJPEGImage;
  Prg   : TFPrgrs;
begin
  if (not FromPreview) then begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FReport.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FReport.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FReport.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + de + IntToStr(FReport.QRPrinter.PageCount);
        Prg.Accion.Update;
        B := TBitmap.Create;
        J := TJPEGImage.Create;
        B.PixelFormat := pf24bit;
        MF := FReport.QRPrinter.GetPage(i);
        B.Width := MF.Width;
        B.Height:= MF.Height;
        B.Canvas.Draw(0, 0, MF);
        B.PixelFormat := pf8bit;
        J.Assign(B);
        J.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.JPG');
        B.Free;
        J.Free;
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end
  else begin // Export from preview
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FPreview.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FPreview.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FPreview.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + de + IntToStr(FPreview.QRPrinter.PageCount);
        Prg.Accion.Update;
        B := TBitmap.Create;
        J := TJPEGImage.Create;
        B.PixelFormat := pf24bit;
        MF := FPreview.QRPrinter.GetPage(i);
        B.Width := MF.Width;
        B.Height:= MF.Height;
        B.Canvas.Draw(0, 0, MF);
        B.PixelFormat := pf8bit;
        J.Assign(B);
        J.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.JPG');
        B.Free;
        J.Free;
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TExportQR.ExportQREMF (FileName : String; FromPreview : boolean = False);
var
  i     : integer;
  MF    : TMetaFile;
  Prg   : TFPrgrs;
begin
  if (not FromPreview) then begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FReport.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FReport.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FReport.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FReport.QRPrinter.PageCount);
        Prg.Accion.Update;
        MF := FReport.QRPrinter.GetPage(i);
        MF.Enhanced := True;
        MF.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.EMF');
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end
  else begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FPreview.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FPreview.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FPreview.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FPreview.QRPrinter.PageCount);
        Prg.Accion.Update;
        MF := FPreview.QRPrinter.GetPage(i);
        MF.Enhanced := True;
        MF.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.EMF');
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TExportQR.ExportQRWMF (FileName : String; FromPreview : boolean = False);
var
  i     : integer;
  MF    : TMetaFile;
  Prg   : TFPrgrs;
begin
  if (not FromPreview) then begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FReport.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FReport.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FReport.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FReport.QRPrinter.PageCount);
        Prg.Accion.Update;
        MF := FReport.QRPrinter.GetPage(i);
        MF.Enhanced := False;
        MF.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.WMF');
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end
  else begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FPreview.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FPreview.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      for i := 1 to FPreview.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FPreview.QRPrinter.PageCount);
        Prg.Accion.Update;
        MF := FPreview.QRPrinter.GetPage(i);
        MF.Enhanced := False;
        MF.SaveToFile(FileName + PadL(IntToStr(i), 5) + '.WMF');
        Prg.PB.StepIt;
      end;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TExportQR.ExportQRPDF (FileName : String; Compresion : boolean; FromPreview : boolean = False);
var
  PPDF  : TPrintPDF;
  i     : integer;
  MF    : TMetaFile;
  B     : TBitmap;
  Prg   : TFPrgrs;
  // 612 792
begin
  if (not FromPreview) then begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FReport.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FReport.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      PPDF := TPrintPDF.Create(Self);
      PPDF.FileName := FileName + '.PDF';
      PPDF.BeginDoc;
      if FReport.Page.Orientation = poLandscape then begin
        PPDF.PageWidth := 792;
        PPDF.PageHeight:= 612;
      end;
      for i := 1 to FReport.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FReport.QRPrinter.PageCount);
        Prg.Accion.Update;
        B := TBitmap.Create;
        B.PixelFormat := pf24bit;
        MF := FReport.QRPrinter.GetPage(i);
        B.Width := MF.Width;
        B.Height := MF.Height;
        B.Canvas.Draw(0,0,MF);
        B.PixelFormat := pf8bit;
        if (Compresion) then
          PPDF.DrawBitmap(52, 0, B) // ZLIB
        else
          PPDF.DrawJPEG(52,0,B); // JPEG
        if (i <> FReport.QRPrinter.PageCount) then
          PPDF.NewPage;
        Prg.PB.StepIt;
        B.Free;
      end;
      PPDF.EndDoc;
      PPDF.Free;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end
  else begin
    try
      // Vamos a guardar
      Prg := TFPrgrs.Create (Self);
      Prg.Caption := Exportando;
      Prg.PB.Min := 0;
      Prg.PB.Max := FPreview.QRPrinter.PageCount - 1;
      Prg.PB.Position := 0;
      Prg.PB.Update;
      Prg.Accion.Caption := Pagina1De + IntToStr(FPreview.QRPrinter.PageCount);
      Prg.Accion.Update;
      Prg.Show;
      PPDF := TPrintPDF.Create(Self);
      PPDF.FileName := FileName + '.PDF';
      PPDF.BeginDoc;
      for i := 1 to FPreview.QRPrinter.PageCount do begin
        Prg.Accion.Caption := Pagina + IntToStr(i) + De + IntToStr(FPreview.QRPrinter.PageCount);
        Prg.Accion.Update;
        B := TBitmap.Create;
        B.PixelFormat := pf24bit;
        MF := FPreview.QRPrinter.GetPage(i);
        B.Width := MF.Width;
        B.Height := MF.Height;
        B.Canvas.Draw(0,0,MF);
        if (Compresion) then
          PPDF.DrawBitmap(52, 0, B) // ZLIB
        else
          PPDF.DrawJPEG(52,0,B); // JPEG
        if (i <> FPreview.QRPrinter.PageCount) then
          PPDF.NewPage;
        Prg.PB.StepIt;
        B.Free;
      end;
      PPDF.EndDoc;
      PPDF.Free;
      Prg.Free;
    except
      MessageDlg (Error, mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;
{$ENDIF}

(*****************************)
(*        TEXPORTFR          *)
(*****************************)
{$IFDEF FASTREPORT}
constructor TExportFR.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TExportFR.Destroy;
begin
  inherited Destroy;
end;

procedure TExportFR.ExportFR;
var
  SD    : TSaveDialog;
  Ruta  : String;
  Fich  : String;
  P     : integer;
begin
  if (not Assigned (FReport)) then
    Exit;
  FReport.PrepareReport; {Prepare report}
  try
    // Sacamos el cuadro de diálogo para guardar
    SD := TSaveDialog.Create(Self);
    SD.Title := Guardar;
    SD.Filter := Filtro;
    SD.FilterIndex := 0;
    if (SD.Execute) then begin
      Ruta := ExtractFilePath(SD.FileName);
      Fich := ExtractFileName(SD.FileName);
      P := Pos('.', Fich);
      if (P <> 0) then
        Fich := Copy (Fich, 1, P - 1);
      case SD.FilterIndex of
        1 : begin
              ExportFRPDF (Ruta + Fich, True);
            end;
        2 : begin
              ExportFRPDF (Ruta + Fich, False);
            end;
        3 : begin
              ExportFRJPG (Ruta + Fich);
            end;
        4 : begin
              ExportFRBMP (Ruta + Fich);
            end;
        5 : begin
              ExportFREMF (Ruta + Fich);
            end;
        6 : begin
              ExportFRWMF (Ruta + Fich);
            end;
      end;
    end;
    SD.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportFR.ExportFRBMP (FileName : String);
var
  i     : integer;
  B     : TBitmap;
  Prg   : TFPrgrs;
  Ancho, Alto : Longint;
begin
  try
    // Vamos a guardar
    Prg := TFPrgrs.Create (Self);
    Prg.Caption := Exportando;
    Prg.PB.Min := 0;
    Prg.PB.Max := FReport.EMFPages.Count - 1;
    Prg.PB.Position := 0;
    Prg.PB.Update;
    Prg.Accion.Caption := Pagina1De + IntToStr(FReport.EMFPages.Count);
    Prg.Accion.Update;
    Prg.Show;
    f_file := '';
    for i := 0 to FReport.EMFPages.Count - 1 do begin
      Ancho := FReport.EMFPages[i].PrnInfo.Pgw;
      Alto := FReport.EMFPages[i].PrnInfo.Pgh;
      Prg.Accion.Caption := Pagina + IntToStr(i + 1) + De + IntToStr(FReport.EMFPages.Count);
      Prg.Accion.Update;
      B := TBitmap.Create;
      B.PixelFormat := pf24bit;
      B.Width := Ancho;
      B.Height := Alto;
      FReport.EMFPages.Pages[i].Visible := True;
      FReport.EMFPages.Draw(i, B.Canvas, Rect(0, 0, Ancho, Alto));
      B.PixelFormat := pf8bit;
      B.SaveToFile(FileName + PadL(IntToStr(i + 1), 5) + '.BMP');
      f_file := f_file + FileName + PadL(IntToStr(i + 1), 5) + '.BMP;';
      B.Free;
      Prg.PB.StepIt;
    end;
    if Copy(f_file, Length(f_file), 1) = ';' then
      f_file := Copy(f_file, 01, Length(f_file)-1);
    Prg.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportFR.ExportFRJPG (FileName : String);
var
  i     : integer;
  B     : TBitmap;
  J     : TJPEGImage;
  Prg   : TFPrgrs;
  Ancho, Alto : Longint;
begin
  try
    // Vamos a guardar
    Prg := TFPrgrs.Create (Self);
    Prg.Caption := Exportando;
    Prg.PB.Min := 0;
    Prg.PB.Max := FReport.EMFPages.Count - 1;
    Prg.PB.Position := 0;
    Prg.PB.Update;
    Prg.Accion.Caption := Pagina1De + IntToStr(FReport.EMFPages.Count);
    Prg.Accion.Update;
    Prg.Show;
    f_file := '';
    for i := 0 to FReport.EMFPages.Count - 1 do begin
      Ancho := FReport.EMFPages[i].PrnInfo.Pgw;
      Alto := FReport.EMFPages[i].PrnInfo.Pgh;

      Prg.Accion.Caption := Pagina + IntToStr(i + 1) + De + IntToStr(FReport.EMFPages.Count);
      Prg.Accion.Update;
      B := TBitmap.Create;
      J := TJPEGImage.Create;
      B.PixelFormat := pf24bit;
      B.Width := Ancho;
      B.Height := Alto;
      FReport.EMFPages.Pages[i].Visible := True;
      FReport.EMFPages.Draw(i, B.Canvas, Rect(0, 0, Ancho, Alto));
      B.PixelFormat := pf8bit;
      J.Assign(B);
      J.SaveToFile(FileName + PadL(IntToStr(i + 1), 5) + '.JPG');
      f_file := f_file + FileName + PadL(IntToStr(i + 1), 5) + '.JPG;';
      B.Free;
      J.Free;
      Prg.PB.StepIt;
    end;
    if Copy(f_file, Length(f_file), 1) = ';' then
      f_file := Copy(f_file, 01, Length(f_file)-1);
    Prg.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportFR.ExportFREMF (FileName : String);
var
  i     : integer;
  MF    : TMetaFile;
  MFC   : TMetafileCanvas;
  Prg   : TFPrgrs;
  Ancho, Alto : Longint;
begin
  try
    // Vamos a guardar
    Prg := TFPrgrs.Create (Self);
    Prg.Caption := Exportando;
    Prg.PB.Min := 0;
    Prg.PB.Max := FReport.EMFPages.Count;
    Prg.PB.Position := 0;
    Prg.PB.Update;
    Prg.Accion.Caption := Pagina1De + IntToStr(FReport.EMFPages.Count);
    Prg.Accion.Update;
    Prg.Show;
    f_file := '';
    for i := 0 to FReport.EMFPages.Count - 1 do begin
      Ancho := FReport.EMFPages[i].PrnInfo.Pgw;
      Alto := FReport.EMFPages[i].PrnInfo.Pgh;
      MF := TMetafile.Create;
      MF.Width := Ancho;
      MF.Height := Alto;
      MFC := TMetafileCanvas.Create(MF, 0);
      Prg.Accion.Caption := Pagina + IntToStr(i + 1) + De + IntToStr(FReport.EMFPages.Count);
      Prg.Accion.Update;
      FReport.EMFPages.Pages[i].Visible := True;
      FReport.EMFPages.Draw(i, MFC, Rect(0, 0, Ancho, Alto));
      MFC.Free;
      MF.Enhanced := True;
      MF.SaveToFile(FileName + Padl(IntToStr(I + 1), 5) + '.EMF');
      f_file := f_file + FileName + Padl(IntToStr(I + 1), 5) + '.EMF;';
      MF.Free;
      Prg.PB.StepIt;
    end;
    if Copy(f_file, Length(f_file), 1) = ';' then
      f_file := Copy(f_file, 01, Length(f_file)-1);
    Prg.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportFR.ExportFRWMF (FileName : String);
var
  i     : integer;
  MF    : TMetaFile;
  MFC   : TMetafileCanvas;
  Prg   : TFPrgrs;
  Ancho, Alto : Longint;
begin
  try
    // Vamos a guardar
    Prg := TFPrgrs.Create (Self);
    Prg.Caption := Exportando;
    Prg.PB.Min := 0;
    Prg.PB.Max := FReport.EMFPages.Count - 1;
    Prg.PB.Position := 0;
    Prg.PB.Update;
    Prg.Accion.Caption := Pagina1De + IntToStr(FReport.EMFPages.Count);
    Prg.Accion.Update;
    Prg.Show;
    f_file := '';
    for i := 0 to FReport.EMFPages.Count - 1 do begin
      Ancho := FReport.EMFPages[i].PrnInfo.Pgw;
      Alto := FReport.EMFPages[i].PrnInfo.Pgh;
      MF := TMetafile.Create;
      MF.Width := Ancho;
      MF.Height := Alto;
      MFC := TMetafileCanvas.Create(MF, 0);
      Prg.Accion.Caption := Pagina + IntToStr(i + 1) + De + IntToStr(FReport.EMFPages.Count);
      Prg.Accion.Update;
      FReport.EMFPages.Pages[i].Visible := True;
      FReport.EMFPages.Draw(i, MFC, Rect(0, 0, Ancho, Alto));
      MFC.Free;
      MF.Enhanced := False;
      MF.SaveToFile(FileName + Padl(IntToStr(I + 1), 5) + '.WMF');
      f_file := f_file + FileName + Padl(IntToStr(I + 1), 5) + '.WMF;';
      MF.Free;
      Prg.PB.StepIt;
    end;
    if Copy(f_file, Length(f_file), 1) = ';' then
      f_file := Copy(f_file, 01, Length(f_file)-1);
    Prg.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;

procedure TExportFR.ExportFRPDF (FileName : String; Compresion : boolean);
var
  PPDF  : TPrintPDF;
  i     : integer;
  B     : TBitmap;
  Prg   : TFPrgrs;
  Ancho, Alto : Longint;
begin
  try
    // Vamos a guardar
    Prg := TFPrgrs.Create (Self);
    Prg.Caption := Exportando;
    Prg.PB.Min := 0;
    Prg.PB.Max := FReport.EMFPages.Count - 1;
    Prg.PB.Position := 0;
    Prg.PB.Update;
    Prg.Accion.Caption := Pagina1De + IntToStr(FReport.EMFPages.Count);
    Prg.Accion.Update;
    Prg.Show;
    PPDF := TPrintPDF.Create(Self);
    PPDF.FileName := FileName + '.PDF';
    f_file := PPDF.FileName;
    PPDF.BeginDoc;
    for i := 0 to FReport.EMFPages.Count - 1 do begin
      Ancho := FReport.EMFPages[i].PrnInfo.Pgw;
      Alto := FReport.EMFPages[i].PrnInfo.Pgh;
      if (i = 0) and (Ancho > Alto) then begin
        PPDF.PageWidth := 792;
        PPDF.PageHeight:= 612;
      end;
      Prg.Accion.Caption := Pagina + IntToStr(i + 1) + De + IntToStr(FReport.EMFPages.Count);
      Prg.Accion.Update;
      B := TBitmap.Create;
      B.PixelFormat := pf24bit;
      B.Width := Ancho;
      B.Height := Alto;
      FReport.EMFPages.Pages[i].Visible := True;
      FReport.EMFPages.Draw(i, B.Canvas, Rect(0, 0, Ancho, Alto));
      B.PixelFormat := pf8bit;
      if (Compresion) then
        PPDF.DrawBitmap(52, 0, B) // ZLIB
      else
        PPDF.DrawJPEG(52,0,B); // JPEG
      if (i <> FReport.EMFPages.Count - 1) then
        PPDF.NewPage;
      Prg.PB.StepIt;
      B.Free;
    end;
    PPDF.EndDoc;
    PPDF.Free;
    Prg.Free;
  except
    MessageDlg (Error, mtError, [mbOK], 0);
    Exit;
  end;
end;
{$ENDIF}
end.


