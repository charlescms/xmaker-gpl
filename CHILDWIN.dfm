object IEWindow: TIEWindow
  Left = 432
  Top = 279
  Width = 354
  Height = 289
  Caption = 'MDI Child'
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 346
    Height = 243
    Align = alClient
    TabOrder = 0
    OnStatusTextChange = WebBrowser1StatusTextChange
    OnCommandStateChange = WebBrowser1CommandStateChange
    OnTitleChange = WebBrowser1TitleChange
    OnNewWindow2 = WebBrowser1NewWindow2
    OnNavigateComplete2 = WebBrowser1NavigateComplete2
    ControlData = {
      4C000000C32300001D1900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 243
    Width = 346
    Height = 19
    BiDiMode = bdLeftToRight
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ParentBiDiMode = False
    SimplePanel = False
    OnResize = StatusBar1Resize
  end
end
