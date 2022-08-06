object FormAgEdit: TFormAgEdit
  Left = 228
  Top = 175
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Inclusão / Alteração'
  ClientHeight = 279
  ClientWidth = 282
  Color = clMenu
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000C0C00000000000CC0F0C000000000C00F0F0C0000000C
    00FFF0F0C0000CC0FFFFFF0F0C00C00F0FFFFFF0F0C000FFF0FFFFFF0F0C0FFF
    FF0FFFFFF0F000FFFFF0FFFFFF00000FFFFF0FFF00000000FFFFF00000000000
    0FFF00000000000000000000000000000000000000000000000000000000FFFF
    2C04FE3FF7BDF81F0000F40FFFFFE00700008003FFFF4001FFFF0000FFFF0000
    FFFF8001FFFFC003FFFFE00F0000F07FFFFFF8FF0000FFFF1F00FFFFF7BD}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelEdit: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 279
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 20
      Width = 67
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Nome'
    end
    object Label2: TLabel
      Left = 4
      Top = 45
      Width = 67
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Telefone'
    end
    object Label3: TLabel
      Left = 4
      Top = 69
      Width = 67
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Complemento'
    end
    object BtnGravar: TBitBtn
      Left = 117
      Top = 247
      Width = 75
      Height = 25
      Hint = 'Salvar registro'
      Caption = '&Salvar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = BtnGravarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        66666666666666666666660000000000000666FFFFFFFFFFFFF6603300000077
        03066F66FFFFFF66F6F660330000007703066F66FFFFFF66F6F6603300000077
        03066F66FFFFFF66F6F660330000000003066F66FFFFFFFFF6F6603333333333
        33066F666666666666F660330000000033066F66FFFFFFFF66F6603077777777
        03066F6F66666666F6F660307777777703066F6F66666666F6F6603077777777
        03066F6F66666666F6F660307777777703066F6F66666666F6F6603077777777
        00066F6F66666666FFF660307777777703066F6F66666666F6F6600000000000
        00066FFFFFFFFFFFFFF666666666666666666666666666666666}
      NumGlyphs = 2
    end
    object BtnDesistir: TBitBtn
      Left = 200
      Top = 247
      Width = 75
      Height = 25
      Hint = 'Desistir inclusão/edição'
      Caption = '&Desistir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = BtnDesistirClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF33339993707399933333773337F3777FF3399933000339
        9933377333777F3377F3399333707333993337733337333337FF993333333333
        399377F33333F333377F993333303333399377F33337FF333373993333707333
        333377F333777F333333993333101333333377F333777F3FFFFF993333000399
        999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
        99933773FF777F3F777F339993707399999333773F373F77777F333999999999
        3393333777333777337333333999993333333333377777333333}
      NumGlyphs = 2
    end
    object DBNome: TDBEdit
      Left = 75
      Top = 17
      Width = 199
      Height = 21
      DataField = 'nome'
      DataSource = DataSource1
      MaxLength = 50
      TabOrder = 0
      OnExit = DBNomeExit
    end
    object DBTelefone: TDBEdit
      Left = 75
      Top = 42
      Width = 199
      Height = 21
      DataField = 'telefone'
      DataSource = DataSource1
      MaxLength = 50
      TabOrder = 1
      OnExit = DBTelefoneExit
    end
    object DBObs: TDBMemo
      Left = 75
      Top = 68
      Width = 199
      Height = 156
      DataField = 'complemento'
      DataSource = DataSource1
      TabOrder = 2
      OnEnter = DBObsEnter
      OnExit = DBObsExit
    end
    object DBCheckBox1: TDBCheckBox
      Left = 75
      Top = 226
      Width = 198
      Height = 17
      Caption = 'Compartilhar com demais usuários'
      DataField = 'compartilhado'
      DataSource = DataSource1
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object DataSource1: TDataSource
    Left = 16
    Top = 112
  end
end
