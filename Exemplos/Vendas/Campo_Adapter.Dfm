object FormCampo_Adapter: TFormCampo_Adapter
  Left = 290
  Top = 202
  BorderStyle = bsDialog
  Caption = 'Preenchimento do campo'
  ClientHeight = 319
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitOk: TBitBtn
    Left = 196
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = BitOkClick
  end
  object BitCancela: TBitBtn
    Left = 278
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cancela'
    TabOrder = 2
    OnClick = BitCancelaClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 359
    Height = 281
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 10
      Top = 6
      Width = 33
      Height = 13
      Caption = 'Campo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 4
      Top = 23
      Width = 349
      Height = 36
    end
    object Label1: TLabel
      Left = 10
      Top = 68
      Width = 72
      Height = 13
      Caption = 'Preencher com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 4
      Top = 84
      Width = 349
      Height = 37
    end
    object Label3: TLabel
      Left = 144
      Top = 128
      Width = 126
      Height = 13
      Caption = 'Campos da Tabela "Atual"'
    end
    object Label4: TLabel
      Left = 5
      Top = 128
      Width = 119
      Height = 13
      Caption = 'Funções para Conversão'
    end
    object EdCampo: TEdit
      Left = 10
      Top = 30
      Width = 337
      Height = 21
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object EdExpressao: TEdit
      Left = 10
      Top = 92
      Width = 337
      Height = 21
      TabOrder = 0
    end
    object ListaCampos: TListBox
      Left = 144
      Top = 143
      Width = 209
      Height = 132
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = ListaCamposDblClick
    end
    object ListaFuncoes: TListBox
      Left = 5
      Top = 143
      Width = 132
      Height = 132
      ItemHeight = 13
      Items.Strings = (
        'Converte para maiúsculo'
        'Converte valor para texto'
        'Converte texto para valor'
        'Converte texto para data')
      TabOrder = 1
      OnDblClick = ListaFuncoesDblClick
    end
  end
end
