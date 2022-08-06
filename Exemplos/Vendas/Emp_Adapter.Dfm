object FormEmpresa_Adapter: TFormEmpresa_Adapter
  Left = 252
  Top = 178
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Seleciona Empresa Usuária'
  ClientHeight = 404
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 331
    Height = 364
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 46
      Height = 13
      Caption = 'Empresas'
    end
    object lbEmpresas: TListBox
      Left = 3
      Top = 21
      Width = 324
      Height = 338
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      Style = lbOwnerDrawFixed
      TabOrder = 0
      OnDblClick = BtnOkClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 364
    Width = 331
    Height = 40
    Align = alBottom
    TabOrder = 1
    object BtnCancela: TBitBtn
      Left = 251
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Cancela operação'
      Cancel = True
      Caption = '&Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      NumGlyphs = 2
    end
    object BtnAjuda: TBitBtn
      Left = 77
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Ajuda'
      Caption = 'A&juda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      NumGlyphs = 2
    end
    object BtnOk: TBitBtn
      Left = 164
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Seleciona empresa e finaliza'
      Caption = '&Ok'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnOkClick
      NumGlyphs = 2
    end
  end
end
