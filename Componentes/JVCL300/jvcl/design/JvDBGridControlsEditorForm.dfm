object frmJvDBGridControlsEditor: TfrmJvDBGridControlsEditor
  Left = 201
  Top = 176
  BorderStyle = bsDialog
  Caption = 'Set Grid Edit Controls'
  ClientHeight = 260
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object sbAdd: TSpeedButton
    Left = 176
    Top = 84
    Width = 25
    Height = 25
    Glyph.Data = {
      06020000424D0602000000000000760000002800000028000000140000000100
      0400000000009001000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888888888888888888888888888888888888888888888888888888888888
      8888888888448888888888888888888F88888888888888888846488888888888
      88888878F8888888888888888846648888888888888888788F88888888888888
      88466648888888888888887888F8888888888888884666648888888888888878
      888F8888888888888846666648888888888888788888F8888888888888466666
      648888888888887888888F8888888888884666666648888888888878888888F8
      888888888846666666E88888888888788888887888888888884666666E888888
      88888878888887888888888888466666E8888888888888788888788888888888
      8846666E88888888888888788887888888888888884666E88888888888888878
      887888888888888888466E88888888888888887887888888888888888846E888
      88888888888888787888888888888888888E8888888888888888887788888888
      8888888888888888888888888888888888888888888888888888888888888888
      88888888888888888888}
    NumGlyphs = 2
    OnClick = sbAddClick
  end
  object sbDelete: TSpeedButton
    Left = 176
    Top = 124
    Width = 25
    Height = 25
    Glyph.Data = {
      06020000424D0602000000000000760000002800000028000000140000000100
      0400000000009001000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888888888888888888888888888888888888888888888888888888888888
      888888888888888844888888888888888888FF88888888888888888464888888
      88888888888F8F888888888888888846648888888888888888F88F8888888888
      8888846664888888888888888F888F8888888888888846666488888888888888
      F8888F888888888888846666648888888888888F88888F888888888888466666
      64888888888888F888888F8888888888846666666488888888888F8888888F88
      888888888E666666648888888888878888888F888888888888E6666664888888
      8888887888888F8888888888888E6666648888888888888788888F8888888888
      8888E666648888888888888878888F888888888888888E666488888888888888
      87888F8888888888888888E6648888888888888888788F88888888888888888E
      648888888888888888878F888888888888888888E68888888888888888887888
      8888888888888888888888888888888888888888888888888888888888888888
      88888888888888888888}
    NumGlyphs = 2
    OnClick = sbDeleteClick
  end
  object GroupBoxFields: TGroupBox
    Left = 8
    Top = 5
    Width = 161
    Height = 217
    Caption = ' Current Fields '
    TabOrder = 0
    object lbFields: TListBox
      Left = 8
      Top = 24
      Width = 145
      Height = 185
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBoxSelected: TGroupBox
    Left = 208
    Top = 5
    Width = 313
    Height = 217
    Caption = ' Selected Fields '
    TabOrder = 1
    object LabelControl: TLabel
      Left = 160
      Top = 24
      Width = 60
      Height = 13
      Caption = 'Edit Control :'
    end
    object LabelFillCell: TLabel
      Left = 160
      Top = 76
      Width = 68
      Height = 13
      Caption = 'Runtime Size :'
    end
    object lbSelected: TListBox
      Left = 8
      Top = 24
      Width = 145
      Height = 185
      ItemHeight = 13
      TabOrder = 0
      OnClick = lbSelectedClick
    end
    object cbControl: TComboBox
      Left = 160
      Top = 40
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnClick = cbControlClick
    end
    object cbFillCell: TComboBox
      Left = 160
      Top = 92
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnClick = cbFillCellClick
      Items.Strings = (
        'Cell size'
        'Design size'
        'Design/Cell size (biggest)')
    end
  end
  object btnOK: TButton
    Left = 365
    Top = 230
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 446
    Top = 230
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
