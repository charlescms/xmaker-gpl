object FormRestaura: TFormRestaura
  Left = 209
  Top = 180
  Width = 339
  Height = 172
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Restaurar C�pia de Seguran�a - Backup'
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
    Height = 105
    Align = alClient
    TabOrder = 0
    object Label2: TLabel
      Left = 5
      Top = 12
      Width = 69
      Height = 13
      Caption = 'Pasta - Origem'
    end
    object BtnPastaOrigem: TSpeedButton
      Left = 304
      Top = 27
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
    object Label1: TLabel
      Left = 5
      Top = 57
      Width = 72
      Height = 13
      Caption = 'Pasta - Destino'
    end
    object BtnPastaDestino: TSpeedButton
      Left = 304
      Top = 72
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
    object EdOrigem: TEdit
      Left = 3
      Top = 27
      Width = 297
      Height = 21
      TabOrder = 0
    end
    object EdDestino: TEdit
      Left = 3
      Top = 72
      Width = 297
      Height = 21
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 331
    Height = 40
    Align = alBottom
    TabOrder = 1
    object BtnCancela: TBitBtn
      Left = 251
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Cancela opera��o'
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
      NumGlyphs = 2
    end
    object BtnOk: TBitBtn
      Left = 164
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Restaurar c�pia'
      Caption = '&Restaurar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnOkClick
      NumGlyphs = 2
    end
  end
end
