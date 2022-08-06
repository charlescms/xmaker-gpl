object ZUpdateSQLEditForm: TZUpdateSQLEditForm
  Left = 339
  Top = 271
  ActiveControl = UpdateTableName
  BorderStyle = bsDialog
  ClientHeight = 258
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object OkButton: TButton
    Left = 176
    Top = 230
    Width = 65
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 253
    Top = 230
    Width = 65
    Height = 22
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object HelpButton: TButton
    Left = 329
    Top = 230
    Width = 65
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 2
    OnClick = HelpButtonClick
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 398
    Height = 222
    ActivePage = FieldsPage
    Align = alTop
    TabOrder = 3
    OnChanging = PageControlChanging
    object FieldsPage: TTabSheet
      Caption = 'Options'
      object GroupBox1: TGroupBox
        Left = 7
        Top = 3
        Width = 377
        Height = 188
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' SQL Generation '
        TabOrder = 0
        object Label1: TLabel
          Left = 10
          Top = 16
          Width = 61
          Height = 13
          Caption = 'Table &Name:'
          FocusControl = UpdateTableName
        end
        object Label3: TLabel
          Left = 127
          Top = 13
          Width = 51
          Height = 13
          Anchors = [akTop, akRight]
          Caption = '&Key Fields:'
          FocusControl = KeyFieldList
        end
        object Label4: TLabel
          Left = 252
          Top = 13
          Width = 68
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Update &Fields:'
          FocusControl = UpdateFieldList
        end
        object UpdateTableName: TComboBox
          Left = 8
          Top = 30
          Width = 112
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = UpdateTableNameChange
          OnClick = UpdateTableNameClick
        end
        object KeyFieldList: TListBox
          Left = 127
          Top = 30
          Width = 117
          Height = 145
          Anchors = [akTop, akRight, akBottom]
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = FieldListPopup
          TabOrder = 6
          OnClick = SettingsChanged
        end
        object UpdateFieldList: TListBox
          Left = 250
          Top = 30
          Width = 118
          Height = 145
          Anchors = [akTop, akRight, akBottom]
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = FieldListPopup
          TabOrder = 7
          OnClick = SettingsChanged
        end
        object GenerateButton: TButton
          Left = 15
          Top = 133
          Width = 99
          Height = 22
          Caption = '&Generate SQL'
          TabOrder = 4
          OnClick = GenerateButtonClick
        end
        object PrimaryKeyButton: TButton
          Left = 15
          Top = 107
          Width = 99
          Height = 22
          Caption = 'Select &Primary Keys'
          TabOrder = 3
          OnClick = PrimaryKeyButtonClick
        end
        object DefaultButton: TButton
          Left = 15
          Top = 81
          Width = 99
          Height = 21
          Caption = '&Dataset Defaults'
          Enabled = False
          TabOrder = 2
          OnClick = DefaultButtonClick
        end
        object QuoteFields: TCheckBox
          Left = 16
          Top = 159
          Width = 103
          Height = 15
          Caption = '&Quote Field Names'
          TabOrder = 5
          OnClick = SettingsChanged
        end
        object GetTableFieldsButton: TButton
          Left = 15
          Top = 54
          Width = 99
          Height = 21
          Caption = 'Get &Table Fields'
          TabOrder = 1
          OnClick = GetTableFieldsButtonClick
        end
      end
    end
    object SQLPage: TTabSheet
      Caption = 'SQL'
      object Label2: TLabel
        Left = 11
        Top = 46
        Width = 48
        Height = 13
        Caption = 'S&QL Text:'
        FocusControl = SQLMemo
      end
      object SQLMemo: TMemo
        Left = 8
        Top = 60
        Width = 375
        Height = 122
        ScrollBars = ssVertical
        TabOrder = 0
        OnKeyPress = SQLMemoKeyPress
      end
      object StatementType: TRadioGroup
        Left = 9
        Top = 5
        Width = 374
        Height = 35
        Caption = 'Statement Type'
        Columns = 3
        Items.Strings = (
          '&Modify'
          '&Insert'
          '&Delete')
        TabOrder = 1
        OnClick = StatementTypeClick
      end
    end
  end
  object FieldListPopup: TPopupMenu
    Left = 54
    Top = 270
    object miSelectAll: TMenuItem
      Caption = '&Select All'
      OnClick = SelectAllClick
    end
    object miClearAll: TMenuItem
      Caption = '&Clear All'
      OnClick = ClearAllClick
    end
  end
end
