object FormFormRel: TFormFormRel
  Left = 233
  Top = 138
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Formulários Relacionados'
  ClientHeight = 307
  ClientWidth = 337
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
    0000000000000888888888888888000000000000000007777777777777700777
    7777777777700700770FFFFFFF70070007000000007007777777777777700777
    7777777777700700770FFF777770070077000077777007777777777777700CCC
    CCCCCCCCCCC00CCCCCCCCCCCCCC000000000000000000000000000000000FFFF
    2C05800000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000FFFF0000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 261
    Width = 337
    Height = 46
    Align = alBottom
    TabOrder = 1
    object BtnOk: TBitBtn
      Left = 91
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Relacionar Formulários selecionados ...'
      Caption = '&Ok'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnOkClick
    end
    object BtnFechar: TBitBtn
      Left = 171
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Fechar geração de fontes do projeto'
      Caption = '&Fechar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BtnAjuda: TBitBtn
      Left = 251
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Ajuda'
      Caption = 'A&juda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object Lista: TCheckListBox
    Left = 0
    Top = 0
    Width = 337
    Height = 261
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
end
