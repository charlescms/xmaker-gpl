object FrmPrintPas: TFrmPrintPas
  Left = 283
  Top = 192
  HelpContext = 3150
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Seleção de Impressão'
  ClientHeight = 205
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 329
    Height = 65
    Caption = ' Arquivo para Imprimir : '
    TabOrder = 0
    IsControl = True
    object lbFileName: TLabel
      Left = 8
      Top = 16
      Width = 309
      Height = 17
      AutoSize = False
      Caption = 'Arquivo :'
      IsControl = True
    end
    object cbSelectedText: TCheckBox
      Left = 8
      Top = 36
      Width = 172
      Height = 20
      Caption = '&Imprimir Bloco Selecionado'
      TabOrder = 0
      IsControl = True
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 76
    Width = 329
    Height = 85
    Caption = ' Opções: '
    TabOrder = 1
    IsControl = True
    object Label2: TLabel
      Left = 156
      Top = 60
      Width = 86
      Height = 13
      Caption = '&Margem Esquerda'
      FocusControl = ebMargin
      IsControl = True
    end
    object cbHeader: TCheckBox
      Left = 8
      Top = 16
      Width = 161
      Height = 20
      Caption = '&Nº de Página de Cabeçalho'
      TabOrder = 0
      IsControl = True
    end
    object cbLineNumbers: TCheckBox
      Left = 8
      Top = 36
      Width = 145
      Height = 20
      Caption = 'Número da &Linha'
      TabOrder = 1
      IsControl = True
    end
    object cbSyntaxPrint: TCheckBox
      Left = 8
      Top = 56
      Width = 121
      Height = 20
      Caption = 'Impressão de &Sintaxe'
      TabOrder = 2
      IsControl = True
    end
    object cbColor: TCheckBox
      Left = 180
      Top = 16
      Width = 121
      Height = 20
      Caption = 'Usar &Cor'
      TabOrder = 3
      IsControl = True
    end
    object cbWrapLines: TCheckBox
      Left = 180
      Top = 36
      Width = 141
      Height = 20
      Caption = '&Truncar Linhas Longas'
      TabOrder = 4
      IsControl = True
    end
    object ebMargin: TEdit
      Left = 252
      Top = 58
      Width = 37
      Height = 21
      ImeName = 'ÇÑ±¹¾î(ÇÑ±Û)'
      TabOrder = 5
      Text = '0'
      IsControl = True
    end
  end
  object BtnSetup: TButton
    Left = 8
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Setup ...'
    TabOrder = 2
    OnClick = BtnSetupClick
  end
  object BtnOk: TButton
    Left = 100
    Top = 170
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = BtnOkClick
  end
  object BtnCancelar: TButton
    Left = 180
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = BtnCancelarClick
  end
  object BtnAjuda: TButton
    Left = 260
    Top = 170
    Width = 75
    Height = 25
    Caption = 'Ajuda'
    TabOrder = 5
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 288
    Top = 8
  end
end
