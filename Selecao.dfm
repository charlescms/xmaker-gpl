object FormListaEscolha: TFormListaEscolha
  Left = 260
  Top = 138
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecionar...'
  ClientHeight = 324
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000F000000000000000000000000
    0000000EFE00000000000000000000000000000FEFEF00000000000000000000
    00000E0EFEFEFE00000000000000000000000F0FEFEFEFEF0000000000000000
    0000FE0EFEFEFEFEFE000000000000000000E00FEFEFEFEFEFEF000000000000
    000EF00EFEFEFEFE0EFEFE0000000000000F0F0FEFEFEFEFEFEFEFEF00000000
    00FE0F0EFEFEFEFE0EFEFEFE0000000000E0FF0FEFEFEFEF0FEFEFEF00000000
    0EF0FF0EFEFEFEFEF0FEFEFE000000000F0FFFF00FEFEFEFEF0FEFEF00000000
    FE0FFFFFF00EFE0EFE0EFEFE00000000EFE00FFFFFF0EF0FE00FEFEF00000000
    0EFEF00FFFFF0EF000FEFEFE000000000FEFEFE00FFF0FEFEFEFEFEF00000000
    0EFEFE0EF00FF00EFEFEFEFE00000000000FE0000FE00FF00FEFEFEF00000000
    00000000000EF00FF00EFEFE000000000000000000000FE00FE00FEF00000000
    000000000000000EFEF0000E0000000000000000000000000F00000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFFC3FFFFFF80FFFFFF803FFFFF00
    0FFFFF0003FFFE0000FFFE00003FFC00000FFC000007F8000007F8000007F000
    0007F0000007E0000007E0000007F0000007F0000007F0000007F8200007FE78
    0007FFFE0007FFFF8087FFFFE1E7FFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 321
    Height = 281
  end
  object BtnOk: TButton
    Left = 175
    Top = 296
    Width = 75
    Height = 25
    Hint = 'Confirmar selecionamento'
    Caption = '&Ok'
    Default = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object BtnCancelar: TButton
    Left = 255
    Top = 296
    Width = 75
    Height = 25
    Hint = 'Cancelar seleção'
    Caption = '&Cancelar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnCancelarClick
  end
  object ListaSelecao: TListBox
    Left = 16
    Top = 16
    Width = 305
    Height = 265
    Color = clSilver
    ItemHeight = 20
    ParentShowHint = False
    ShowHint = True
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnDblClick = BtnOkClick
    OnDrawItem = ListaSelecaoDrawItem
    OnKeyDown = ListaSelecaoKeyDown
    OnMouseDown = ListaSelecaoMouseDown
    OnMouseMove = ListaSelecaoMouseMove
    OnMouseUp = ListaSelecaoMouseUp
  end
  object Extra: TCheckBox
    Left = 9
    Top = 300
    Width = 160
    Height = 17
    Hint = 'Campo de pesquisa em tabela relacionada'
    Caption = 'Chave Estrangeira'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Visible = False
  end
end
