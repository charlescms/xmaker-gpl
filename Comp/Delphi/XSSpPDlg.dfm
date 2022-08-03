object XSStoredProcParamDlg: TXSStoredProcParamDlg
  Left = 282
  Top = 180
  ActiveControl = lbParamName
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'StoredProc Parameters'
  ClientHeight = 211
  ClientWidth = 343
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
    Width = 343
    Height = 172
    Align = alTop
    Caption = 'Define Parameters'
    TabOrder = 0
    object lblParamName: TLabel
      Left = 9
      Top = 18
      Width = 80
      Height = 13
      Caption = '&Parameter name:'
    end
    object lblParamType: TLabel
      Left = 147
      Top = 33
      Width = 74
      Height = 13
      Caption = 'Parameter &type:'
    end
    object lblParamDataType: TLabel
      Left = 147
      Top = 57
      Width = 46
      Height = 13
      Caption = 'Data t&ype'
    end
    object lblParamValue: TLabel
      Left = 147
      Top = 81
      Width = 30
      Height = 13
      Caption = '&Value:'
    end
    object lbParamName: TListBox
      Left = 9
      Top = 33
      Width = 121
      Height = 97
      ItemHeight = 13
      TabOrder = 0
      OnClick = ParamNameClick
    end
    object cbParamType: TComboBox
      Left = 225
      Top = 33
      Width = 110
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = ParamTypeChange
    end
    object cbParamDataType: TComboBox
      Left = 225
      Top = 58
      Width = 110
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = ParamDataTypeChange
      OnExit = ParamDataTypeExit
    end
    object edParamValue: TEdit
      Left = 225
      Top = 83
      Width = 110
      Height = 21
      TabOrder = 3
      OnExit = ParamValueExit
    end
    object cbNullValue: TCheckBox
      Left = 147
      Top = 111
      Width = 97
      Height = 17
      Caption = '&Null Value'
      TabOrder = 4
      OnClick = NullValueChanged
    end
    object btAdd: TButton
      Left = 54
      Top = 138
      Width = 75
      Height = 25
      Caption = '&Add'
      TabOrder = 5
      OnClick = AddParamClick
    end
    object btDelete: TButton
      Left = 135
      Top = 138
      Width = 75
      Height = 25
      Caption = '&Delete'
      TabOrder = 6
      OnClick = DeleteParamClick
    end
    object btClear: TButton
      Left = 216
      Top = 138
      Width = 75
      Height = 25
      Caption = '&Clear'
      TabOrder = 7
      OnClick = ParamsClearClick
    end
  end
  object btOk: TButton
    Left = 54
    Top = 180
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btCancel: TButton
    Left = 135
    Top = 180
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btHelp: TButton
    Left = 216
    Top = 180
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
  end
end
