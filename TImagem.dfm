object FormTabelaImagem: TFormTabelaImagem
  Left = 278
  Top = 120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tabela de Imagens'
  ClientHeight = 344
  ClientWidth = 279
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
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000088
    888888888888000000000000000800B3B33B0B303B08000B30B0B303B00800E0
    B33B303B0E0800EE0B0B03B0EE0800EEE030E00EEE0800EEEE0EEEEEEE0800EE
    EEEEEEEEEE0800EEEEEEEE00EE0800EEEEEEE0BB0E0800EEEEEEE0BB0E0800EE
    EEEEEE00EE0800EEEEEEEEEEEE0800000000000000000000000000000000C000
    C804800000008000EF7B8000F7BD800000008000FF078000FF078000FF078000
    00008000E07B800000008000FF0780000000800000008001FF07FFFFFF07}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnNovaImagem: TSpeedButton
    Left = 216
    Top = 144
    Width = 23
    Height = 22
    Hint = 'Inserir nova imagem'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333FF33333333FF333993333333300033377F3333333777333993333333
      300033F77FFF3333377739999993333333333777777F3333333F399999933333
      33003777777333333377333993333333330033377F3333333377333993333333
      3333333773333333333F333333333333330033333333F33333773333333C3333
      330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
      333333333337733333FF3333333C333330003333333733333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnNovaImagemClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 209
    Height = 305
    TabOrder = 0
    object ListaImagens: TTreeView
      Left = 1
      Top = 1
      Width = 207
      Height = 303
      Align = alClient
      Color = clMenu
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HotTrack = True
      Images = FormPrincipal.ImagensProjeto
      Indent = 19
      ParentFont = False
      ReadOnly = True
      RightClickSelect = True
      TabOrder = 0
    end
  end
  object BtnGravar: TBitBtn
    Left = 32
    Top = 315
    Width = 75
    Height = 25
    Hint = 'Gravar Definições'
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnGravarClick
    NumGlyphs = 2
  end
  object BtnFechar: TBitBtn
    Left = 115
    Top = 315
    Width = 75
    Height = 25
    Hint = 'Fechar definição sem gravar'
    Caption = '&Fechar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BtnAjuda: TBitBtn
    Left = 198
    Top = 315
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object OpenPictureBitmap: TOpenPictureDialog
    Filter = 'BitMap (*.bmp)|*.bmp'
    Left = 240
    Top = 280
  end
end
