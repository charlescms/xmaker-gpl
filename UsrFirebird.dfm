object FormUsrFirebird: TFormUsrFirebird
  Left = 306
  Top = 190
  HelpContext = 60
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Usuário Master Firebird/Interbase'
  ClientHeight = 151
  ClientWidth = 305
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
    Left = 8
    Top = 8
    Width = 289
    Height = 105
    TabOrder = 0
    object Bevel1: TBevel
      Left = 8
      Top = 16
      Width = 273
      Height = 73
    end
    object Label1: TLabel
      Left = 22
      Top = 35
      Width = 36
      Height = 13
      Caption = 'Usuário'
      FocusControl = EdUsuario
    end
    object Label2: TLabel
      Left = 22
      Top = 57
      Width = 31
      Height = 13
      Caption = 'Senha'
      FocusControl = EdSenha
    end
    object EdUsuario: TEdit
      Left = 64
      Top = 31
      Width = 201
      Height = 21
      Hint = 'Informe o usuário Master definido no banco'
      MaxLength = 250
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object EdSenha: TEdit
      Left = 64
      Top = 55
      Width = 201
      Height = 21
      Hint = 'Informe a senha do usuário Master definido no banco'
      MaxLength = 200
      ParentShowHint = False
      PasswordChar = '*'
      ShowHint = True
      TabOrder = 1
    end
  end
  object BtnGravar: TBitBtn
    Left = 62
    Top = 121
    Width = 75
    Height = 25
    Hint = 'Gravar Definições'
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnGravarClick
    NumGlyphs = 2
  end
  object BtnFechar: TBitBtn
    Left = 142
    Top = 121
    Width = 75
    Height = 25
    Hint = 'Fechar definição sem gravar'
    Caption = '&Fechar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BtnAjuda: TBitBtn
    Left = 222
    Top = 121
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnAjudaClick
    NumGlyphs = 2
  end
end
