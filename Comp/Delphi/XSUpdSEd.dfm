object XSUpdateSQLEditForm: TXSUpdateSQLEditForm
  Left = 252
  Top = 128
  ActiveControl = cbTableName
  BorderStyle = bsDialog
  Caption = 'UpdateSQL Editor'
  ClientHeight = 280
  ClientWidth = 475
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
  object pcUpdateSQL: TPageControl
    Left = 0
    Top = 0
    Width = 475
    Height = 247
    ActivePage = tsOptions
    Align = alClient
    TabOrder = 0
    object tsOptions: TTabSheet
      Caption = 'Options'
      object gbxGenSQL: TGroupBox
        Left = 3
        Top = 0
        Width = 460
        Height = 214
        Caption = 'SQL Generation'
        TabOrder = 0
        object lblTableName: TLabel
          Left = 9
          Top = 18
          Width = 61
          Height = 13
          Caption = 'Table &Name:'
        end
        object lblKeyFields: TLabel
          Left = 149
          Top = 18
          Width = 51
          Height = 13
          Caption = '&Key Fields:'
        end
        object lblUpdateFields: TLabel
          Left = 302
          Top = 18
          Width = 110
          Height = 13
          Caption = 'Refresh/Update &Fields:'
        end
        object cbTableName: TComboBox
          Left = 9
          Top = 33
          Width = 130
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = cbTableNameChange
        end
        object lbKeyFields: TListBox
          Left = 149
          Top = 33
          Width = 150
          Height = 172
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = pmFields
          TabOrder = 5
        end
        object lbUpdateFields: TListBox
          Left = 302
          Top = 33
          Width = 150
          Height = 172
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = pmFields
          TabOrder = 6
        end
        object btDataSetDefaults: TButton
          Left = 15
          Top = 90
          Width = 120
          Height = 25
          Caption = '&DataSet Defaults'
          TabOrder = 2
          OnClick = DataSetDefaultsClick
        end
        object btGenerateSQL: TButton
          Left = 15
          Top = 150
          Width = 120
          Height = 25
          Caption = '&Generate SQL'
          TabOrder = 4
          OnClick = GenerateSQLClick
        end
        object btGetTableFields: TButton
          Left = 15
          Top = 60
          Width = 120
          Height = 25
          Caption = 'Get &Table Fields'
          TabOrder = 1
          OnClick = GetTableFieldsClick
        end
        object cbQuotedFields: TCheckBox
          Left = 15
          Top = 182
          Width = 126
          Height = 17
          Caption = '&Quote Field Names'
          TabOrder = 7
        end
        object btSelectPrimKeys: TButton
          Left = 16
          Top = 120
          Width = 120
          Height = 25
          Caption = 'Select &Primary Keys'
          TabOrder = 3
          OnClick = btSelectPrimKeysClick
        end
      end
    end
    object tsSQL: TTabSheet
      Caption = 'SQL'
      object lblSQLText: TLabel
        Left = 6
        Top = 48
        Width = 48
        Height = 13
        Caption = 'S&QL Text:'
      end
      object meSQLText: TMemo
        Left = 3
        Top = 63
        Width = 460
        Height = 151
        ScrollBars = ssBoth
        TabOrder = 0
        OnExit = SQLTextExit
      end
      object rgrStatementType: TRadioGroup
        Left = 3
        Top = 6
        Width = 460
        Height = 37
        Caption = 'Statement Type'
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          '&Refresh'
          '&Modify'
          '&Insert'
          '&Delete')
        TabOrder = 1
        OnClick = StatementTypeClick
      end
    end
  end
  object pnlButton: TPanel
    Left = 0
    Top = 247
    Width = 475
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btOk: TButton
      Left = 316
      Top = 5
      Width = 75
      Height = 25
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 396
      Top = 5
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pmFields: TPopupMenu
    Left = 214
    Top = 99
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
