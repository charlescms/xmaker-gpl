object FormTamanho: TFormTamanho
  Left = 332
  Top = 223
  BorderStyle = bsDialog
  Caption = 'Tamanho'
  ClientHeight = 153
  ClientWidth = 327
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 150
    Height = 109
    Caption = ' Largura: '
    TabOrder = 0
    object hNoChange: TRadioButton
      Left = 8
      Top = 16
      Width = 90
      Height = 20
      Caption = 'Manter'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object hShrink: TRadioButton
      Left = 8
      Top = 36
      Width = 130
      Height = 20
      Caption = 'Escolher a menor'
      TabOrder = 1
    end
    object hGrow: TRadioButton
      Left = 8
      Top = 56
      Width = 130
      Height = 20
      Caption = 'Escolher a maior'
      TabOrder = 2
    end
    object hAbsolute: TRadioButton
      Left = 8
      Top = 76
      Width = 62
      Height = 20
      Caption = 'Largura:'
      TabOrder = 3
      OnClick = hAbsoluteClick
    end
    object hWidth: TEdit
      Left = 72
      Top = 77
      Width = 60
      Height = 21
      Enabled = False
      ImeName = '한국어(한글)'
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 168
    Top = 8
    Width = 150
    Height = 109
    Caption = ' Altura: '
    TabOrder = 1
    object vNoChange: TRadioButton
      Left = 8
      Top = 16
      Width = 90
      Height = 20
      Caption = 'Manter'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object vShrink: TRadioButton
      Left = 8
      Top = 36
      Width = 130
      Height = 20
      Caption = 'Escolher a menor'
      TabOrder = 1
    end
    object vGrow: TRadioButton
      Left = 8
      Top = 56
      Width = 118
      Height = 20
      Caption = 'Escolher a maior'
      TabOrder = 2
    end
    object vAbsolute: TRadioButton
      Left = 8
      Top = 76
      Width = 62
      Height = 20
      Caption = 'Altura:'
      TabOrder = 3
      OnClick = vAbsoluteClick
    end
    object vHeight: TEdit
      Left = 72
      Top = 77
      Width = 60
      Height = 21
      Enabled = False
      ImeName = '한국어(한글)'
      TabOrder = 4
    end
  end
  object OKButton: TButton
    Left = 163
    Top = 125
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 243
    Top = 125
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
end
