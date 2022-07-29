object FormLanctos: TFormLanctos
  Left = 297
  Top = 149
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Lançamentos'
  ClientHeight = 329
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 393
    Height = 284
  end
  object Label29: TLabel
    Left = 10
    Top = 19
    Width = 105
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Tabela alvo'
  end
  object Label3: TLabel
    Left = 10
    Top = 43
    Width = 105
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Condição p/ inclusão'
  end
  object Image2: TImage
    Left = 8
    Top = 305
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      0000100000000100040000000000800000000000000000000000100000000000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00222222222222222222222222222222222222222222222222222222200000
      002222222228FFFFF02222222228888880222200000222222222228FFFF00000
      0022228F8888FFFFF022228FFFF888888022228F8888F0222222228FFFFFF022
      2222228444448022222222888888802222222222222222222222222222222222
      2222}
    Visible = False
  end
  object Image3: TImage
    Left = 40
    Top = 305
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      0000100000000100040000000000800000000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00222222222222222222222222222222222222222222222222224444222222
      222224FFFF422222222224FFFFF4444444424FF4FFFFFFFFFFF44F424FF77474
      74744FF4FFF44242424224FFFFF42222222224FFFF4222222222224444222222
      2222222222222222222222222222222222222222222222222222222222222222
      2222}
    Visible = False
  end
  object BtnOk: TButton
    Left = 247
    Top = 300
    Width = 75
    Height = 25
    Hint = 'Inserir relacionamento'
    Caption = '&Ok'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BtnOkClick
  end
  object BtnFechar: TButton
    Left = 327
    Top = 300
    Width = 75
    Height = 25
    Hint = 'Fechar'
    Caption = '&Cancelar'
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object PR_EdTab_alvo: TDBComboBox
    Left = 120
    Top = 15
    Width = 170
    Height = 21
    Style = csDropDownList
    DataField = 'tab_alvo'
    DataSource = FormDB_Case.DataSource_Processo
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnExit = PR_EdTab_alvoExit
  end
  object PR_EdCondicao_inclusao: TRxDBComboEdit
    Left = 120
    Top = 39
    Width = 170
    Height = 21
    Hint = 
      'Informe a expressão do processo direto, esse processo será '#13#10'exe' +
      'cutado quando o registro for gravado.'
    DataField = 'condicao_inclusao'
    DataSource = FormDB_Case.DataSource_Processo
    Glyph.Data = {
      96000000424D960000000000000076000000280000000A000000040000000100
      0400000000002000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
      0000800800800800000080080080080000008888888888000000}
    ButtonWidth = 16
    NumGlyphs = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnButtonClick = PR_EdCondicao_inclusaoButtonClick
  end
  object PnCampos: TPanel
    Tag = 2
    Left = 13
    Top = 65
    Width = 189
    Height = 19
    BevelOuter = bvLowered
    Caption = 'Campos da Tabela alvo'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object GridCampos: TListBox
    Tag = 2
    Left = 13
    Top = 86
    Width = 189
    Height = 199
    Color = clBtnFace
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    TabOrder = 2
    OnClick = GridCamposClick
    OnDrawItem = GridCamposDrawItem
    OnEnter = GridCamposClick
  end
  object Panel1: TPanel
    Tag = 2
    Left = 206
    Top = 65
    Width = 189
    Height = 19
    BevelOuter = bvLowered
    Caption = 'Preencher com:'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object GridValores: TListBox
    Tag = 2
    Left = 206
    Top = 86
    Width = 189
    Height = 199
    Color = clBtnFace
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    TabOrder = 3
    OnClick = GridValoresClick
    OnDblClick = GridValoresDblClick
    OnEnter = GridValoresClick
    OnKeyDown = GridValoresKeyDown
  end
end
