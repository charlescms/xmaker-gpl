object FormHCampo: TFormHCampo
  Left = 233
  Top = 138
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tabela: '
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
    000000000000000000000000000000000F7F7F7F7F70000007F7F70000F00B00
    0F7F7F0FF07008B00700070000F008FB007F7F7F7F70008FB007F70000F00000
    FB007F0FF0708FBBBBB0070000F008FB007F7F7F7F70008FB00444444444008F
    BB00444444440008FBB000000000000080BB000000000000000000000000FFFF
    C804F0000000F000F7BD9000FFFF8000F7BD8000000080000000C00000000000
    00000000FFFF80000000C000F7BDC000EF7BE07FFFFFF43FE0FFFFFF0000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 261
    Width = 337
    Height = 46
    Align = alBottom
    TabOrder = 1
    object BtnHerdar: TBitBtn
      Left = 91
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Herdar campo(s) selecionado(s)'
      Caption = '&Herdar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnHerdarClick
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
      TabOrder = 2
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
      TabOrder = 3
    end
    object BtnTodos: TBitBtn
      Left = 10
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Marcar todos os módulos'
      Caption = '&Todos'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnTodosClick
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
