object FormEdUsr: TFormEdUsr
  Left = 300
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Usuário'
  ClientHeight = 198
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = formclose
  OnKeyPress = formkeypress
  OnShow = formshow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelInf: TPanel
    Left = 0
    Top = 163
    Width = 357
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnCancelar: TBitBtn
      Left = 275
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Cancelar sem gravar'
      Caption = '&Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      NumGlyphs = 2
    end
    object BtnGravar: TBitBtn
      Left = 192
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Gravar e finalizar'
      Cancel = True
      Caption = '&Gravar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BTNGRAVARclick
      NumGlyphs = 2
    end
  end
  object PageUsuario: TPageControl
    Left = 8
    Top = 8
    Width = 342
    Height = 156
    ActivePage = PagUsr
    TabOrder = 0
    object PagUsr: TTabSheet
      Caption = 'Propriedades'
      object Label1: TLabel
        Left = 2
        Top = 10
        Width = 52
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Nome'
      end
      object Label2: TLabel
        Left = 2
        Top = 34
        Width = 52
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Senha'
      end
      object Label3: TLabel
        Left = 2
        Top = 58
        Width = 52
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Confirme'
      end
      object Label4: TLabel
        Left = 2
        Top = 102
        Width = 52
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Grupo'
      end
      object EdNome: TEdit
        Left = 57
        Top = 7
        Width = 185
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 0
      end
      object EdSenha: TEdit
        Left = 57
        Top = 31
        Width = 80
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 1
      end
      object EdConfirme: TEdit
        Left = 57
        Top = 55
        Width = 80
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 2
      end
      object EdMaster: TCheckBox
        Left = 57
        Top = 80
        Width = 132
        Height = 17
        Caption = 'Master ( Acesso Total )'
        TabOrder = 3
      end
      object EdGrupo: TComboBox
        Left = 57
        Top = 99
        Width = 185
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
    end
  end
end
