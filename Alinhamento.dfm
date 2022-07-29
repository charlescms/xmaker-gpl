object FormAlinhamento: TFormAlinhamento
  Left = 366
  Top = 192
  BorderStyle = bsDialog
  Caption = 'Alinhamento'
  ClientHeight = 182
  ClientWidth = 320
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
    Width = 148
    Height = 140
    Caption = ' Horizontal '
    TabOrder = 0
    object hNoChange: TRadioButton
      Left = 12
      Top = 16
      Width = 133
      Height = 18
      Caption = 'Manter'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object hLeftSides: TRadioButton
      Left = 12
      Top = 36
      Width = 133
      Height = 18
      Caption = 'A esquerda'
      TabOrder = 1
    end
    object hCenters: TRadioButton
      Left = 12
      Top = 56
      Width = 133
      Height = 18
      Caption = 'Centralizar'
      TabOrder = 2
    end
    object hRightSides: TRadioButton
      Left = 12
      Top = 76
      Width = 133
      Height = 18
      Caption = 'A direita'
      TabOrder = 3
    end
    object hSpaceEqual: TRadioButton
      Left = 12
      Top = 96
      Width = 133
      Height = 18
      Caption = 'Espaços iguais'
      TabOrder = 4
    end
    object hCenterInWindow: TRadioButton
      Left = 12
      Top = 116
      Width = 133
      Height = 18
      Caption = 'Centralizar na janela'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 164
    Top = 8
    Width = 148
    Height = 140
    Caption = ' Vertical '
    TabOrder = 1
    object vNoChange: TRadioButton
      Left = 11
      Top = 16
      Width = 90
      Height = 18
      Caption = 'Manter'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object vTops: TRadioButton
      Left = 11
      Top = 36
      Width = 90
      Height = 18
      Caption = 'Acima'
      TabOrder = 1
    end
    object vCenters: TRadioButton
      Left = 11
      Top = 56
      Width = 90
      Height = 18
      Caption = 'Centralizar'
      TabOrder = 2
    end
    object vBottoms: TRadioButton
      Left = 11
      Top = 76
      Width = 90
      Height = 18
      Caption = 'Abaixo'
      TabOrder = 3
    end
    object vSpaceEqual: TRadioButton
      Left = 11
      Top = 96
      Width = 126
      Height = 18
      Caption = 'Espaços iguais'
      TabOrder = 4
    end
    object vCenterInWindow: TRadioButton
      Left = 11
      Top = 116
      Width = 123
      Height = 18
      Caption = 'Centralizar na janela'
      TabOrder = 5
    end
  end
  object OKButton: TButton
    Left = 157
    Top = 153
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 237
    Top = 153
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
end
