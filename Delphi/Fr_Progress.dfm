object FR_Progress: TFR_Progress
  WindowState = wsNormal
  BorderStyle = bsNone
  Position = poScreenCenter
  FormStyle = fsNormal
  Left = 5
  Top = 5
  Width = 279
  Height = 128
  BorderIcons = [biSystemMenu,biMinimize,biMaximize]
  Caption = 'C:\XMaker4\Delphi\Fr_Progress.Pas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  Visible = False
  PixelsPerInch = 96
  TextHeight = 13
  Oncreate = formcreate
  Ondestroy = formdestroy
  Onhide = formhide
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 271
    Height = 101
    Align = alClient
    BevelWidth = 2
    TabOrder = 0
    object LMessage: TLabel
      Left = 16
      Top = 11
      Width = 237
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'LMessage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bar: TProgressBar
      Left = 16
      Top = 37
      Width = 237
      Height = 17
      Min = 0
      Max = 100
      Position = 30
      Step = 1
      TabOrder = 0
    end
    object CancelB: TButton
      Left = 100
      Top = 64
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      Onclick = CANCELBclick
    end
  end
end
