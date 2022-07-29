object FormExpressao: TFormExpressao
  Left = 302
  Top = 190
  BorderStyle = bsDialog
  Caption = 'Expressão'
  ClientHeight = 233
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 8
    Width = 313
    Height = 105
    Caption = ' Expressão '
    TabOrder = 0
    object ExprMemo: TMemo
      Left = 8
      Top = 16
      Width = 297
      Height = 81
      HelpContext = 179
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 4
    Top = 120
    Width = 313
    Height = 73
    Caption = ' Inserir '
    TabOrder = 1
    object frSpeedButton1: TSpeedButton
      Left = 8
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Soma'
      Caption = '+'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton2: TSpeedButton
      Left = 30
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Subtrai'
      Caption = '-'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton3: TSpeedButton
      Left = 52
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Multiplica'
      Caption = '*'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton4: TSpeedButton
      Left = 74
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Divide'
      Caption = '/'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton5: TSpeedButton
      Left = 96
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Igual'
      Caption = '='
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton6: TSpeedButton
      Left = 118
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Diferente'
      Caption = '<>'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton7: TSpeedButton
      Left = 140
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Maior que'
      Caption = '>'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton8: TSpeedButton
      Left = 162
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Menor que'
      Caption = '<'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton9: TSpeedButton
      Left = 184
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Maior ou igual'
      Caption = '>='
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton10: TSpeedButton
      Left = 206
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Menor ou igual'
      Caption = '<='
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton11: TSpeedButton
      Left = 228
      Top = 44
      Width = 28
      Height = 22
      Hint = 'Operador lógico "E"'
      Caption = 'And'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton12: TSpeedButton
      Left = 256
      Top = 44
      Width = 22
      Height = 22
      Hint = 'Operador lógico "Ou"'
      Caption = 'Or'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object frSpeedButton13: TSpeedButton
      Left = 278
      Top = 44
      Width = 27
      Height = 22
      Hint = 'Operador lógico de negação'
      Caption = 'Not'
      ParentShowHint = False
      ShowHint = True
      OnClick = frSpeedButton1Click
    end
    object InsDBBtn: TSpeedButton
      Left = 8
      Top = 16
      Width = 97
      Height = 22
      Caption = '&Campo ...'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00222222222222
        22220000000000000002888888888888880287FFFFFFFFFFF80287FFFFFFFFFF
        F80287F8888F8888F80287FFFFFFFFFFF80287F8888F8888F80287FFFFFFFFFF
        F80287F8888F8888F80287FFFFFFFFFFF8028788888888888802874C4C4C4F0F
        0802877777777777780288888888888888822222222222222222}
      Margin = 4
      OnClick = InsDBBtnClick
    end
    object InsVarBtn: TSpeedButton
      Left = 108
      Top = 16
      Width = 97
      Height = 22
      Caption = '&Variável ...'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333883333333333333008833333338333822
        08333339088822222033333990882A222233333999002AA22233333991113322
        3333333991338888833333391338C6C083333333333366C08333333333333CC0
        83333333333366C4333333333333333333333333333333333333}
      Margin = 2
      Spacing = 2
      OnClick = InsVarBtnClick
    end
    object InsFuncBtn: TSpeedButton
      Left = 208
      Top = 16
      Width = 97
      Height = 22
      Caption = '&Função ...'
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00707777777777
        0000770777777777000077087007007700007780778007770000778087700077
        0000777087007807000077780777777700007700000777770000777708777777
        0000777700780777000077777000777700007777777777770000}
      Margin = 4
      OnClick = InsFuncBtnClick
    end
  end
  object Button1: TButton
    Left = 160
    Top = 204
    Width = 75
    Height = 25
    HelpContext = 40
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 240
    Top = 204
    Width = 75
    Height = 25
    HelpContext = 50
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
end
