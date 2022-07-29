object PictureEdit: TPictureEdit
  Left = 154
  Top = 145
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Picture Editor'
  ClientHeight = 273
  ClientWidth = 313
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 297
    Height = 225
  end
  object btnOK: TBitBtn
    Left = 77
    Top = 239
    Width = 75
    Height = 31
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 152
    Top = 239
    Width = 75
    Height = 31
    TabOrder = 1
    Kind = bkCancel
  end
  object btnHelp: TBitBtn
    Left = 227
    Top = 239
    Width = 75
    Height = 31
    Caption = 'Help'
    TabOrder = 2
    Kind = bkHelp
  end
  object btnLoad: TButton
    Left = 216
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object btnSave: TButton
    Left = 216
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
  end
  object btnClear: TButton
    Left = 216
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 193
    Height = 209
    TabOrder = 6
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 191
      Height = 207
      Align = alClient
      Center = True
    end
  end
  object OpenDialog1: TOpenPictureDialog
    Filter = 
      'All (*.jpg;*.jpeg;*.gif;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;*.' +
      'gif;*.bmp;*.ico;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|JPEG I' +
      'mage File (*.jpeg)|*.jpeg|Graphics Interchange Format (*.gif)|*.' +
      'gif|Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles' +
      ' (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    Left = 232
    Top = 144
  end
end
