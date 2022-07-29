object FormTutorial: TFormTutorial
  Left = 299
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Tutorial do X-Maker ...'
  ClientHeight = 464
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 464
    Align = alClient
    TabOrder = 0
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 385
      Height = 380
    end
    object LbVersao: TLabel
      Left = 16
      Top = 392
      Width = 33
      Height = 13
      Caption = 'Versão'
    end
    object Label3: TLabel
      Left = 16
      Top = 408
      Width = 47
      Height = 13
      Caption = 'Copyright '
    end
    object Label4: TLabel
      Left = 64
      Top = 406
      Width = 8
      Height = 13
      Caption = 'ã'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 79
      Top = 409
      Width = 116
      Height = 13
      Caption = '2003 - Modular Software'
    end
    object Label6: TLabel
      Left = 16
      Top = 443
      Width = 170
      Height = 13
      Cursor = crHandPoint
      Hint = 'Site : http://www.modularsoftware.com.br'
      Caption = 'http://www.modularsoftware.com.br'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Label6Click
    end
    object Label1: TLabel
      Left = 20
      Top = 425
      Width = 160
      Height = 13
      Cursor = crHandPoint
      Hint = 'Email : modular@modularsoftware.com.br'
      Caption = 'modular@modularsoftware.com.br'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = Label1Click
    end
    object LbTopico_1: TLabel
      Tag = 1
      Left = 12
      Top = 48
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Criando Novo Projeto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_2: TLabel
      Tag = 2
      Left = 12
      Top = 76
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tabela de Atividades Comerciais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_3: TLabel
      Tag = 3
      Left = 12
      Top = 96
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tabela de Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_4: TLabel
      Tag = 4
      Left = 12
      Top = 116
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Tabela de Contas a Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object Label7: TLabel
      Tag = 5
      Left = 12
      Top = 144
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Relacionamento - Exclusao Restrita e Cascata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object Label8: TLabel
      Left = 12
      Top = 12
      Width = 377
      Height = 17
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Projeto: Contas a Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LbTopico_5: TLabel
      Tag = 6
      Left = 12
      Top = 172
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Formulário de Atividades Comerciais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_6: TLabel
      Tag = 7
      Left = 12
      Top = 192
      Width = 377
      Height = 14
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Formulário de Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_7: TLabel
      Tag = 8
      Left = 12
      Top = 212
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Formulário de Contas a Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object Label2: TLabel
      Tag = 9
      Left = 12
      Top = 232
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Formulário de Contas a Receber Filho'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_8: TLabel
      Tag = 10
      Left = 12
      Top = 264
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Etiqueta de Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_9: TLabel
      Tag = 11
      Left = 12
      Top = 284
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Gráfico de Contas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_10: TLabel
      Tag = 12
      Left = 12
      Top = 304
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Relatório de Contas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_11: TLabel
      Tag = 13
      Left = 12
      Top = 332
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Menu de Opções'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object LbTopico_12: TLabel
      Tag = 14
      Left = 12
      Top = 360
      Width = 377
      Height = 23
      Cursor = crHandPoint
      Alignment = taCenter
      AutoSize = False
      Caption = 'Compilando'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LbTopico_1Click
    end
    object BtnOk: TButton
      Left = 317
      Top = 432
      Width = 75
      Height = 25
      Caption = '&Ok'
      Default = True
      TabOrder = 0
      OnClick = BtnOkClick
    end
    object Panel2: TPanel
      Left = 13
      Top = 69
      Width = 375
      Height = 2
      TabOrder = 1
    end
    object Panel3: TPanel
      Left = 13
      Top = 139
      Width = 375
      Height = 2
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 13
      Top = 166
      Width = 375
      Height = 2
      TabOrder = 3
    end
    object Panel9: TPanel
      Left = 13
      Top = 39
      Width = 375
      Height = 2
      TabOrder = 4
    end
    object Panel5: TPanel
      Left = 13
      Top = 256
      Width = 375
      Height = 2
      TabOrder = 5
    end
    object Panel6: TPanel
      Left = 13
      Top = 325
      Width = 375
      Height = 2
      TabOrder = 6
    end
    object Panel7: TPanel
      Left = 13
      Top = 354
      Width = 375
      Height = 2
      TabOrder = 7
    end
  end
end
