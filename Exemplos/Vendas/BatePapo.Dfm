object FormBatePapo: TFormBatePapo
  Left = 196
  Top = 128
  Width = 587
  Height = 413
  Caption = 'Bate Papo ( Rede Local )'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnSup: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object ShapeSup: TShape
      Left = 0
      Top = 0
      Width = 579
      Height = 20
      Align = alClient
      Brush.Color = 14743792
      ParentShowHint = False
      Pen.Color = 7021576
      ShowHint = True
    end
    object LbTituloForm: TLabel
      Left = 0
      Top = 0
      Width = 579
      Height = 20
      Align = alClient
      Alignment = taCenter
      Caption = 'Bate Papo ( Rede Local )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnClick = LbTituloFormClick
    end
    object BtnAjuda: TSpeedButton
      Left = 542
      Top = 2
      Width = 16
      Height = 14
      Hint = 'Ajuda'
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object BtnFechar: TSpeedButton
      Left = 560
      Top = 2
      Width = 16
      Height = 14
      Hint = 'Fechar'
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = BtnFecharClick
    end
  end
  object PnInferior: TPanel
    Left = 0
    Top = 257
    Width = 579
    Height = 129
    Align = alBottom
    BevelOuter = bvNone
    Color = 13608528
    TabOrder = 1
    object Label1: TLabel
      Left = 3
      Top = 86
      Width = 52
      Height = 13
      Caption = 'Mensagem'
    end
    object Label2: TLabel
      Left = 3
      Top = 48
      Width = 47
      Height = 13
      Caption = 'Falar para'
    end
    object Label3: TLabel
      Left = 3
      Top = 9
      Width = 74
      Height = 13
      Caption = 'Nome / Apelido'
    end
    object Label5: TLabel
      Left = 211
      Top = 28
      Width = 87
      Height = 13
      Caption = 'Nome da estação:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LbEstacao: TLabel
      Left = 303
      Top = 28
      Width = 9
      Height = 13
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdTexto: TEdit
      Left = 3
      Top = 100
      Width = 385
      Height = 21
      TabOrder = 2
    end
    object BtnEnviar: TButton
      Left = 392
      Top = 98
      Width = 75
      Height = 25
      Hint = 'Enviar mensagem'
      Caption = 'Enviar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BtnEnviarClick
    end
    object CbDestino: TComboBox
      Left = 3
      Top = 62
      Width = 166
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object EdApelido: TEdit
      Left = 3
      Top = 23
      Width = 166
      Height = 21
      TabOrder = 4
      OnExit = EdApelidoExit
    end
    object CheckTodos: TCheckBox
      Left = 176
      Top = 64
      Width = 58
      Height = 17
      Hint = 'Enviar mensagens para todos usuários'
      Caption = 'TODOS'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object BtnFinalizar: TButton
      Left = 174
      Top = 26
      Width = 27
      Height = 17
      Hint = 'Sair do bate papo'
      Caption = 'Sair'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = BtnFecharClick
    end
  end
  object MemoMensagem: TRichEdit
    Left = 0
    Top = 20
    Width = 579
    Height = 231
    Align = alClient
    BorderStyle = bsNone
    Color = 14671839
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object PnDivisao: TPanel
    Left = 0
    Top = 251
    Width = 579
    Height = 6
    Align = alBottom
    BevelInner = bvRaised
    TabOrder = 3
  end
end
