object FormArg: TFormArg
  Left = 293
  Top = 220
  BorderStyle = bsDialog
  Caption = 'Argumentos de funções'
  ClientHeight = 284
  ClientWidth = 326
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
  object FuncLabel: TLabel
    Left = 7
    Top = 7
    Width = 311
    Height = 15
    AutoSize = False
    Caption = 'FuncLabel'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object DescrLabel: TLabel
    Left = 7
    Top = 23
    Width = 311
    Height = 54
    AutoSize = False
    Caption = 'DescrLabel'
    Color = clInfoBk
    ParentColor = False
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 81
    Width = 311
    Height = 168
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 20
      Width = 64
      Height = 13
      Caption = '&1º Argumento'
    end
    object Label2: TLabel
      Left = 6
      Top = 44
      Width = 64
      Height = 13
      Caption = '&2º Argumento'
    end
    object Label3: TLabel
      Left = 6
      Top = 68
      Width = 64
      Height = 13
      Caption = '&3º Argumento'
    end
    object Label4: TLabel
      Left = 6
      Top = 92
      Width = 64
      Height = 13
      Caption = '&4º Argumento'
    end
    object Label5: TLabel
      Left = 6
      Top = 115
      Width = 64
      Height = 13
      Caption = '&5º Argumento'
    end
    object Label6: TLabel
      Left = 6
      Top = 139
      Width = 64
      Height = 13
      Caption = '&6º Argumento'
    end
    object ComboEdit1: TComboEdit
      Left = 75
      Top = 16
      Width = 231
      Height = 21
      Enabled = False
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00808888888888
        0000880888888888000088078008008800008870887008880000887078800088
        0000888078008708000088870888888800008800000888880000888807888888
        0000888800870888000088888000888800008888888888880000}
      NumGlyphs = 1
      TabOrder = 0
      OnButtonClick = ComboEdit1ButtonClick
    end
    object ComboEdit2: TComboEdit
      Left = 75
      Top = 40
      Width = 231
      Height = 21
      Enabled = False
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00808888888888
        0000880888888888000088078008008800008870887008880000887078800088
        0000888078008708000088870888888800008800000888880000888807888888
        0000888800870888000088888000888800008888888888880000}
      NumGlyphs = 1
      TabOrder = 1
      OnButtonClick = ComboEdit1ButtonClick
    end
    object ComboEdit3: TComboEdit
      Left = 75
      Top = 64
      Width = 231
      Height = 21
      Enabled = False
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00808888888888
        0000880888888888000088078008008800008870887008880000887078800088
        0000888078008708000088870888888800008800000888880000888807888888
        0000888800870888000088888000888800008888888888880000}
      NumGlyphs = 1
      TabOrder = 2
      OnButtonClick = ComboEdit1ButtonClick
    end
    object ComboEdit4: TComboEdit
      Left = 75
      Top = 88
      Width = 231
      Height = 21
      Enabled = False
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00808888888888
        0000880888888888000088078008008800008870887008880000887078800088
        0000888078008708000088870888888800008800000888880000888807888888
        0000888800870888000088888000888800008888888888880000}
      NumGlyphs = 1
      TabOrder = 3
      OnButtonClick = ComboEdit1ButtonClick
    end
    object ComboEdit5: TComboEdit
      Left = 75
      Top = 112
      Width = 231
      Height = 21
      Enabled = False
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00808888888888
        0000880888888888000088078008008800008870887008880000887078800088
        0000888078008708000088870888888800008800000888880000888807888888
        0000888800870888000088888000888800008888888888880000}
      NumGlyphs = 1
      TabOrder = 4
      OnButtonClick = ComboEdit1ButtonClick
    end
    object ComboEdit6: TComboEdit
      Left = 75
      Top = 136
      Width = 231
      Height = 21
      Enabled = False
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00808888888888
        0000880888888888000088078008008800008870887008880000887078800088
        0000888078008708000088870888888800008800000888880000888807888888
        0000888800870888000088888000888800008888888888880000}
      NumGlyphs = 1
      TabOrder = 5
      OnButtonClick = ComboEdit1ButtonClick
    end
  end
  object Button1: TButton
    Left = 163
    Top = 256
    Width = 75
    Height = 25
    HelpContext = 40
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 243
    Top = 256
    Width = 75
    Height = 25
    HelpContext = 50
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
