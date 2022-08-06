object FormLogProcura: TFormLogProcura
  Left = 224
  Top = 153
  Width = 511
  Height = 430
  Caption = 'Entrada de Dados'
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 0
    Width = 44
    Height = 13
    Caption = 'Tabela(s)'
  end
  object Label2: TLabel
    Left = 256
    Top = 0
    Width = 44
    Height = 13
    Caption = 'Campo(s)'
  end
  object Label3: TLabel
    Left = 8
    Top = 220
    Width = 61
    Height = 13
    Caption = 'Procurar por:'
  end
  object Label4: TLabel
    Left = 8
    Top = 259
    Width = 109
    Height = 13
    Caption = 'Expressões de Procura'
  end
  object Lista1: TListBox
    Left = 8
    Top = 16
    Width = 241
    Height = 201
    ItemHeight = 13
    TabOrder = 0
    OnClick = Lista1Click
  end
  object Lista2: TListBox
    Left = 256
    Top = 16
    Width = 241
    Height = 201
    ItemHeight = 13
    TabOrder = 1
  end
  object EdProcura: TEdit
    Left = 8
    Top = 236
    Width = 241
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 254
    Top = 236
    Width = 75
    Height = 21
    Caption = 'Adicionar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ListaExpressoes: TListBox
    Left = 8
    Top = 274
    Width = 489
    Height = 97
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 339
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 422
    Top = 376
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 6
  end
  object PopupMenu1: TPopupMenu
    Left = 408
    Top = 224
    object Excluirlinhaselecionada1: TMenuItem
      Caption = 'Excluir linha selecionada'
      OnClick = Excluirlinhaselecionada1Click
    end
    object Excluirtodasasexpresses1: TMenuItem
      Caption = 'Excluir todas as expressões'
      OnClick = Excluirtodasasexpresses1Click
    end
  end
end
