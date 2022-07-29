object FormCores: TFormCores
  Left = 244
  Top = 190
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Definição de Cores...'
  ClientHeight = 218
  ClientWidth = 320
  Color = clBtnFace
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
    00000000000044460000000000004444600E0000000044000000E00000004400
    0000E0000000460000000E000000640000000EE000004600000000EE00006400
    000000000000660000000000FF00660000000000FF006600000000000FF06600
    000000000FF006000000000000F000000000000000F00000000000000000FFFF
    C804087FF7BD041FF7BD3E0FF7BD3E07F7BD3F03F7BD3F03F7BD3F83F7BD3FC3
    F7BD3FE1F7BD3FE1F7BD3FF0F7BD3FF0F7BDBFF9F7BDFFF9F7BDFFFFF7BD}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TextoDemo: TRichEdit
    Left = 8
    Top = 32
    Width = 177
    Height = 137
    Hint = 'Exemplo do texto com as cores definidas'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 192
    Top = 53
    Width = 121
    Height = 97
    Caption = 'Cores'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 40
      Top = 30
      Width = 36
      Height = 13
      Caption = 'Fundo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 40
      Top = 62
      Width = 30
      Height = 13
      Caption = 'Letra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CorFundo: TPanel
      Left = 8
      Top = 24
      Width = 25
      Height = 25
      Cursor = crDefault
      Hint = 'Tabela de cores'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CorFundoClick
    end
    object CorLetra: TPanel
      Left = 8
      Top = 56
      Width = 25
      Height = 25
      Cursor = crDefault
      Hint = 'Tabela de cores'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CorLetraClick
    end
  end
  object BtnGravar: TBitBtn
    Left = 72
    Top = 186
    Width = 75
    Height = 25
    Cursor = crDefault
    Hint = 'Gravar Definições'
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnGravarClick
    NumGlyphs = 2
  end
  object BtnFechar: TBitBtn
    Left = 154
    Top = 186
    Width = 75
    Height = 25
    Cursor = crDefault
    Hint = 'Fechar definição sem gravar'
    Caption = '&Fechar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BtnAjuda: TBitBtn
    Left = 236
    Top = 186
    Width = 75
    Height = 25
    Cursor = crDefault
    Hint = 'Ajuda'
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BtnAjudaClick
  end
  object TabEscolha: TTabControl
    Left = 0
    Top = 0
    Width = 320
    Height = 25
    Cursor = crDefault
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 5
    Tabs.Strings = (
      'Editor  ( &1 )'
      'Diário  ( &2 )')
    TabIndex = 0
    OnChange = TabEscolhaChange
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Left = 280
    Top = 117
  end
end
