object FormAutoForma: TFormAutoForma
  Left = 315
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Auto Formata��o'
  ClientHeight = 231
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Image2: TImage
    Left = 176
    Top = 8
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
  object Label1: TLabel
    Left = 4
    Top = 2
    Width = 95
    Height = 13
    Caption = 'Campos dispon�veis'
  end
  object BtnMoveParaBaixo: TSpeedButton
    Left = 166
    Top = 94
    Width = 23
    Height = 22
    Hint = 'Mover campo para baixo'
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330333333333
      33333373FFF33333333333300033333333333337773FFF333333333099000333
      33333337F37773FFF333333099999000333333373F3337773333333309999903
      333333337F3333733333333309999033333333337F3337F33333333309990033
      3333333373F3773F33333333309009033333333337F77373F333333330033090
      33333333377337373F33333330333309033333333733337F7F33333333333309
      033333333333337F7F3333333333330903333333333333737333333333333090
      3333333333333737333333333333090333333333333373733333333333309033
      333333333337F733333333333300033333333333337773333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnMoveParaBaixoClick
  end
  object BtnMoveParaCima: TSpeedButton
    Left = 166
    Top = 126
    Width = 23
    Height = 22
    Hint = 'Mover campo para cima'
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
      33333333337773F33333333333309033333333333337373F3333333333330903
      3333333333337373F33333333333309033333333333337373F33333333333309
      033333333333337F7F333333333333090333333333F3337F7F33333330333309
      0333333337FF33737333333330033090333333333773F7373333333330900903
      3333333337377F733333333309990033333333337F3377F33333333309999033
      333333337F33373F3333333309999903333333337333337FF333333099999000
      33333337F33FF777333333309900033333333337FF7773333333333000333333
      3333333777333333333333033333333333333373333333333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnMoveParaCimaClick
  end
  object Image1: TImage
    Left = 200
    Top = 0
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D617036040000424D360400000000000036000000280000001000
      0000100000000100200000000000000400000000000000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000007B7B00007B7B00007B7B00007B7B0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000007B7B00007B7B00007B7B00007B7B00007B7B000000
      000000000000000000000000000000000000000000000000000000000000FF00
      FF0000000000007B7B00007B7B0000000000007B7B00007B7B00007B7B00007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B000000
      000000000000007B7B0000000000FFFFFF0000000000007B7B00007B7B007B7B
      7B007B7B7B00000000007B7B7B00000000007B7B7B00000000007B7B7B000000
      000000000000007B7B00007B7B0000000000007B7B00007B7B00007B7B000000
      000000000000FF00FF0000000000FF00FF0000000000FF00FF0000000000FF00
      FF00FF00FF0000000000007B7B00007B7B00007B7B00007B7B00007B7B000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000007B7B00007B7B00007B7B00007B7B0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00}
    Visible = False
  end
  object Button1: TButton
    Left = 214
    Top = 203
    Width = 75
    Height = 25
    HelpContext = 40
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 294
    Top = 203
    Width = 75
    Height = 25
    HelpContext = 50
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 5
  end
  object FieldsLB: TListBox
    Left = 4
    Top = 17
    Width = 157
    Height = 208
    HelpContext = 23
    ItemHeight = 16
    MultiSelect = True
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnDrawItem = FieldsLBDrawItem
  end
  object Titulo: TRadioGroup
    Left = 200
    Top = 17
    Width = 169
    Height = 104
    Caption = ' T�tulos '
    ItemIndex = 0
    Items.Strings = (
      'Lateral'
      'Acima - A esquerda'
      'Acima - A direita'
      'Acima - Centralizado'
      'Sem t�tulo')
    TabOrder = 1
  end
  object Distribuicao: TRadioGroup
    Left = 200
    Top = 123
    Width = 169
    Height = 58
    Caption = ' Distribui��o '
    ItemIndex = 0
    Items.Strings = (
      '1 Campo por Linha'
      'N Campos por Linha')
    TabOrder = 2
  end
  object EdRXLib: TCheckBox
    Left = 200
    Top = 183
    Width = 129
    Height = 17
    Caption = 'Componentes RXLib'
    TabOrder = 3
  end
end
