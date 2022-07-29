object FormTabOrdem: TFormTabOrdem
  Left = 321
  Top = 216
  BorderStyle = bsDialog
  Caption = '"Tab Order" - Sequência'
  ClientHeight = 248
  ClientWidth = 319
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
  object Bevel1: TBevel
    Left = 8
    Top = 7
    Width = 302
    Height = 205
    Shape = bsFrame
  end
  object LbTitulo: TLabel
    Left = 18
    Top = 14
    Width = 166
    Height = 13
    Caption = 'Ordem dos campos "Enter ou Tab"'
    FocusControl = TabList
  end
  object BtnMoveParaBaixo: TSpeedButton
    Left = 280
    Top = 115
    Width = 23
    Height = 22
    Hint = 'Mover campo para baixo'
    Flat = True
    Glyph.Data = {
      16010000424D1601000000000000760000002800000010000000140000000100
      040000000000A000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888888808888888888888880888888888888880F088888888888880F0888
      8888888880FFF0888888888880FFF088888888880FFFFF08888888880FFFFF08
      888888880FFFFF0888888880FFFFFFF088888880000000008888888888888888
      888888888800088888888888880F088888888888880008888888888888888888
      888888888800088888888888880F088888888888880008888888}
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnMoveParaBaixoClick
  end
  object BtnMoveParaCima: TSpeedButton
    Left = 280
    Top = 93
    Width = 23
    Height = 22
    Hint = 'Mover campo para cima'
    Flat = True
    Glyph.Data = {
      16010000424D1601000000000000760000002800000010000000140000000100
      040000000000A000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      888888888800088888888888880F088888888888880008888888888888888888
      888888888800088888888888880F088888888888880008888888888888888888
      888888800000000088888880FFFFFFF0888888880FFFFF08888888880FFFFF08
      888888880FFFFF088888888880FFF0888888888880FFF08888888888880F0888
      88888888880F0888888888888880888888888888888088888888}
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnMoveParaCimaClick
  end
  object TabList: TListBox
    Left = 18
    Top = 30
    Width = 258
    Height = 173
    ImeName = 'ÇÑ±¹¾î(ÇÑ±Û)'
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 155
    Top = 219
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelButton: TButton
    Left = 235
    Top = 219
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
  object TabList1: TCheckListBox
    Left = 18
    Top = 30
    Width = 258
    Height = 173
    ItemHeight = 13
    PopupMenu = PopupMenu1
    Sorted = True
    TabOrder = 1
    Visible = False
  end
  object PopupMenu1: TPopupMenu
    Left = 72
    Top = 216
    object SelecionarTudo1: TMenuItem
      Tag = 10
      Caption = 'Marcar Todos'
      OnClick = SelecionarTudo1Click
    end
    object DesmarcarTudo1: TMenuItem
      Tag = 20
      Caption = 'Desmarcar Todos'
      OnClick = SelecionarTudo1Click
    end
  end
end
