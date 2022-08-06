object FormBackup: TFormBackup
  Left = 220
  Top = 118
  Width = 339
  Height = 289
  HelpContext = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Cópia de Segurança - Backup'
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
    Height = 222
    Align = alClient
    TabOrder = 0
    object Label2: TLabel
      Left = 5
      Top = 5
      Width = 69
      Height = 13
      Caption = 'Pasta - Origem'
    end
    object Label3: TLabel
      Left = 5
      Top = 158
      Width = 72
      Height = 13
      Caption = 'Pasta - Destino'
    end
    object BtnPastaOrigem: TSpeedButton
      Left = 304
      Top = 20
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
        333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
        300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
        333337F373F773333333303330033333333337F3377333333333303333333333
        333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
        333337777F337F33333330330BB00333333337F373F773333333303330033333
        333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
        333377777F77377733330BBB0333333333337F337F33333333330BB003333333
        333373F773333333333330033333333333333773333333333333}
      NumGlyphs = 2
      OnClick = BtnPastaOrigemClick
    end
    object BtnPastaDestino: TSpeedButton
      Left = 303
      Top = 173
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
        333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
        300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
        333337F373F773333333303330033333333337F3377333333333303333333333
        333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
        333337777F337F33333330330BB00333333337F373F773333333303330033333
        333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
        333377777F77377733330BBB0333333333337F337F33333333330BB003333333
        333373F773333333333330033333333333333773333333333333}
      NumGlyphs = 2
      OnClick = BtnPastaDestinoClick
    end
    object LsPastas: TListBox
      Left = 3
      Top = 45
      Width = 324
      Height = 108
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      PopupMenu = PopLista
      Style = lbOwnerDrawFixed
      TabOrder = 1
      OnClick = LsPastasClick
      OnDblClick = LsPastasDblClick
    end
    object EdOrigem: TEdit
      Left = 3
      Top = 20
      Width = 297
      Height = 21
      TabOrder = 0
      OnExit = EdOrigemExit
    end
    object EdDestino: TEdit
      Left = 3
      Top = 173
      Width = 297
      Height = 21
      TabOrder = 2
    end
    object Status: TProgressBar
      Left = 1
      Top = 208
      Width = 329
      Height = 13
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 222
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
      OnClick = BtnCancelaClick
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
      TabOrder = 1
      OnClick = BtnAjudaClick
      NumGlyphs = 2
    end
    object BtnOk: TBitBtn
      Left = 164
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Processar cópia'
      Caption = '&Copiar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnOkClick
      NumGlyphs = 2
    end
  end
  object PopLista: TPopupMenu
    Left = 16
    Top = 230
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
end
