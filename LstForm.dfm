object FormListaForm: TFormListaForm
  Left = 277
  Top = 244
  BorderStyle = bsDialog
  Caption = 'Formulários'
  ClientHeight = 188
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 160
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
  object DatasetsLB: TListBox
    Left = 4
    Top = 4
    Width = 237
    Height = 149
    HelpContext = 10
    ItemHeight = 16
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnDblClick = DatasetsLBDblClick
    OnDrawItem = DatasetsLBDrawItem
  end
  object Button1: TButton
    Left = 86
    Top = 159
    Width = 75
    Height = 25
    HelpContext = 40
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 166
    Top = 159
    Width = 75
    Height = 25
    HelpContext = 50
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
