object FormGridRelac: TFormGridRelac
  Left = 272
  Top = 167
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Grid de Relacionamento'
  ClientHeight = 269
  ClientWidth = 259
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
    00000000000000000000000000000000000000FFFF000000000000F77F000000
    000000FFFF0000000080044444400FFFF008044444400F77F000000000000FFF
    F08000000000444444008000000044444408000FFFF000000000080F77F00000
    0000000FFFF0000000000044444400000000004444440000000000000000FFFF
    C804FF810F00FF810F00FF810F00FF01F7BD000100000081000003FF000001FF
    00000040000002000000FF80EF7BFFC00000FFC00000FFC00F00FFFF0F00}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 3
    Top = 2
    Width = 252
    Height = 231
  end
  object Label6: TLabel
    Left = 11
    Top = 190
    Width = 48
    Height = 13
    Caption = 'Formulário'
  end
  object Image1: TImage
    Left = 56
    Top = 248
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      0000100000000100040000000000800000000000000000000000100000000000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF0022222222222222220000000000000002888888888888880287FFFFFFFFFF
      F80287FFFFFFFFFFF80287F8888F8888F80287FFFFFFFFFFF80287F8888F8888
      F80287FFFFFFFFFFF80287F8888F8888F80287FFFFFFFFFFF802878888888888
      8802874C4C4C4F0F080287777777777778028888888888888882222222222222
      2222}
    Visible = False
  end
  object BtnOk: TButton
    Left = 101
    Top = 241
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object BtnFechar: TButton
    Left = 181
    Top = 241
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object EdFormulario: TComboBox
    Left = 11
    Top = 204
    Width = 236
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object FieldsLB_1: TListBox
    Left = 11
    Top = 9
    Width = 236
    Height = 153
    HelpContext = 23
    DragMode = dmAutomatic
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnClick = FieldsLB_1Click
    OnDrawItem = FieldsLB_1DrawItem
    OnEnter = FieldsLB_1Click
  end
  object EdEdicao: TCheckBox
    Left = 11
    Top = 169
    Width = 97
    Height = 17
    Caption = 'Edição direta'
    TabOrder = 1
  end
end
