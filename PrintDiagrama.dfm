object FormPrintDiagrama: TFormPrintDiagrama
  Left = 206
  Top = 151
  Width = 696
  Height = 480
  Caption = 'Diagrama'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PreviewToolbar: TPreviewToolbar
    Left = 0
    Top = 0
    Width = 688
    Height = 26
    Preview = Preview
    Buttons = [btnPrint, btnPrintDialog, btnPrinterSetupDialog, btnFirstPage, btnPrevPage, btnNextPage, btnLastPage, btnZoomOut, btnZoomIn]
    ParentShowHint = False
    ShowHint = True
  end
  object Preview: TPreview
    Left = 0
    Top = 26
    Width = 688
    Height = 407
    PrintJob = ControlPrintJob
    ViewScale = 34
    ScrollTracking = True
    Align = alClient
    TabStop = True
    TabOrder = 1
  end
  object PreviewStatusBar: TPreviewStatusBar
    Left = 0
    Top = 433
    Width = 688
    Height = 20
    Preview = Preview
  end
  object ControlPrintJob: TControlPrintJob
    StretchMode = smOriginalSize
    PageWidth = 2480
    PageHeight = 3508
    Left = 8
    Top = 40
  end
end
