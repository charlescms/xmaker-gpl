object XSSrvLoginDlg: TXSSrvLoginDlg
  Left = 200
  Top = 111
  Width = 222
  Height = 145
  ActiveControl = Password
  Caption = 'Server Login'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlInput: TPanel
    Left = 5
    Top = 7
    Width = 203
    Height = 69
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label2: TLabel
      Left = 10
      Top = 36
      Width = 49
      Height = 13
      Caption = '&Password:'
      FocusControl = Password
    end
    object lblServerName: TLabel
      Left = 10
      Top = 6
      Width = 34
      Height = 13
      Caption = 'Server:'
    end
    object ServerName: TLabel
      Left = 91
      Top = 6
      Width = 3
      Height = 13
    end
    object Bevel: TBevel
      Left = 1
      Top = 24
      Width = 200
      Height = 9
      Shape = bsTopLine
    end
    object Password: TEdit
      Left = 88
      Top = 36
      Width = 105
      Height = 21
      MaxLength = 31
      PasswordChar = '*'
      TabOrder = 0
    end
  end
  object btOk: TButton
    Left = 51
    Top = 87
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 132
    Top = 87
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
