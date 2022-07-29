object FormEdModelo: TFormEdModelo
  Left = 258
  Top = 224
  BorderStyle = bsDialog
  Caption = 'Modelo'
  ClientHeight = 132
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 5
    Top = 5
    Width = 385
    Height = 92
  end
  object LbTitulo: TLabel
    Left = 13
    Top = 9
    Width = 28
    Height = 13
    Caption = 'Título'
  end
  object LbPasta: TLabel
    Left = 13
    Top = 49
    Width = 102
    Height = 13
    Caption = 'Pasta de Localização'
  end
  object EdTitulo: TEdit
    Left = 13
    Top = 25
    Width = 241
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object EdPasta: TDirectoryEdit
    Left = 13
    Top = 65
    Width = 369
    Height = 21
    DialogKind = dkWin32
    DialogText = 'Pasta de Localização'
    NumGlyphs = 1
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 227
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancela: TButton
    Left = 315
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 4
  end
  object ListaFile: TFileListBox
    Left = 309
    Top = 61
    Width = 44
    Height = 28
    ItemHeight = 13
    Mask = '*.pas'
    TabOrder = 5
    Visible = False
  end
  object EdFile: TComboBox
    Left = 13
    Top = 25
    Width = 369
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
end
