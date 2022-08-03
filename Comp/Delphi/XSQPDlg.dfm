object XSQueryParamDlg: TXSQueryParamDlg
  Left = 193
  Top = 194
  ActiveControl = lbParamName
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Query Parameters'
  ClientHeight = 161
  ClientWidth = 329
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbxParameters: TGroupBox
    Left = 0
    Top = 0
    Width = 329
    Height = 129
    Align = alTop
    Caption = 'Define Parameters'
    TabOrder = 0
    object lblParamName: TLabel
      Left = 8
      Top = 17
      Width = 80
      Height = 13
      Caption = '&Parameter name:'
      FocusControl = edParamValue
    end
    object lblParamType: TLabel
      Left = 138
      Top = 31
      Width = 49
      Height = 13
      Caption = '&Data type:'
      FocusControl = cbParamType
    end
    object lblParamValue: TLabel
      Left = 138
      Top = 58
      Width = 30
      Height = 13
      Caption = '&Value:'
    end
    object cbParamType: TComboBox
      Left = 195
      Top = 31
      Width = 126
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = ParamTypeChange
      OnExit = ParamTypeExit
    end
    object edParamValue: TEdit
      Left = 195
      Top = 58
      Width = 126
      Height = 21
      TabOrder = 2
      OnExit = ParamValueExit
    end
    object lbParamName: TListBox
      Left = 8
      Top = 32
      Width = 116
      Height = 89
      ItemHeight = 13
      TabOrder = 0
      OnClick = ParamNameClick
    end
    object cbNullValue: TCheckBox
      Left = 138
      Top = 104
      Width = 73
      Height = 17
      Caption = '&Null Value'
      TabOrder = 3
      OnClick = NullValueChanged
    end
  end
  object btOk: TButton
    Left = 48
    Top = 133
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 127
    Top = 133
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btHelp: TButton
    Left = 206
    Top = 133
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
  end
end
