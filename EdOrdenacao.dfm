object FormOrdenacao: TFormOrdenacao
  Left = 262
  Top = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Ordena��o Inicial'
  ClientHeight = 215
  ClientWidth = 534
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
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 526
    Height = 178
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Ordena��o'
      object Bevel1: TBevel
        Left = 6
        Top = 4
        Width = 506
        Height = 141
      end
      object Label21: TLabel
        Left = 13
        Top = 18
        Width = 216
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos da Tabela'
      end
      object BtnInserirCmp: TSpeedButton
        Left = 234
        Top = 49
        Width = 23
        Height = 22
        Hint = 'Inserir Campo'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333FF3333333333333003333
          3333333333773FF3333333333309003333333333337F773FF333333333099900
          33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
          99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
          33333333337F3F77333333333309003333333333337F77333333333333003333
          3333333333773333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnInserirCmpClick
      end
      object BtnExcluirCmp: TSpeedButton
        Left = 234
        Top = 80
        Width = 23
        Height = 22
        Hint = 'Excluir Campo'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333FF3333333333333003333333333333F77F33333333333009033
          333333333F7737F333333333009990333333333F773337FFFFFF330099999000
          00003F773333377777770099999999999990773FF33333FFFFF7330099999000
          000033773FF33777777733330099903333333333773FF7F33333333333009033
          33333333337737F3333333333333003333333333333377333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnExcluirCmpClick
      end
      object Label22: TLabel
        Left = 261
        Top = 18
        Width = 216
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos do �ndice'
      end
      object BtnMoveParaCima: TSpeedButton
        Left = 480
        Top = 49
        Width = 23
        Height = 22
        Hint = 'Mover campo para cima'
        Flat = True
        Glyph.Data = {
          16010000424D1601000000000000760000002800000010000000140000000100
          040000000000A000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          888888888800088888888888880F088888888888880008888888888888888888
          888888888800088888888888880F088888888888880008888888888888888888
          888888800000000088888880FFFFFFF0888888880FFFFF08888888880FFFFF08
          888888880FFFFF088888888880FFF0888888888880FFF08888888888880F0888
          88888888880F0888888888888880888888888888888088888888}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveParaCimaClick
      end
      object BtnMoveParaBaixo: TSpeedButton
        Left = 480
        Top = 80
        Width = 23
        Height = 22
        Hint = 'Mover campo para baixo'
        Flat = True
        Glyph.Data = {
          16010000424D1601000000000000760000002800000010000000140000000100
          040000000000A000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888808888888888888880888888888888880F088888888888880F0888
          8888888880FFF0888888888880FFF088888888880FFFFF08888888880FFFFF08
          888888880FFFFF0888888880FFFFFFF088888880000000008888888888888888
          888888888800088888888888880F088888888888880008888888888888888888
          888888888800088888888888880F088888888888880008888888}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveParaBaixoClick
      end
      object CamposOrigem: TListBox
        Left = 13
        Top = 33
        Width = 216
        Height = 82
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnDblClick = BtnInserirCmpClick
        OnDrawItem = CamposOrigemDrawItem
      end
      object CamposIndices: TListBox
        Left = 261
        Top = 33
        Width = 216
        Height = 82
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 1
        OnDblClick = BtnExcluirCmpClick
        OnDrawItem = CamposOrigemDrawItem
      end
      object EdDecrescente: TCheckBox
        Left = 262
        Top = 120
        Width = 97
        Height = 17
        Caption = 'Decrescente'
        TabOrder = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 182
    Width = 534
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Image1: TImage
      Left = 160
      Top = 10
      Width = 16
      Height = 16
      AutoSize = True
      Picture.Data = {
        07544269746D6170F6000000424DF60000000000000076000000280000001000
        0000100000000100040000000000800000000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00222222222222222222222222222222222222222222222222222222200000
        002222222228FFFFF02222222228888880222200000222222222228FFFF00000
        0022228F8888FFFFF022228FFFF888888022228F8888F0222222228FFFFFF022
        2222228444448022222222888888802222222222222222222222222222222222
        2222}
      Visible = False
    end
    object Image3: TImage
      Left = 192
      Top = 10
      Width = 16
      Height = 16
      AutoSize = True
      Picture.Data = {
        07544269746D6170F6000000424DF60000000000000076000000280000001000
        0000100000000100040000000000800000000000000000000000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00222222222222222222222222222222222222222222222222224444222222
        222224FFFF422222222224FFFFF4444444424FF4FFFFFFFFFFF44F424FF77474
        74744FF4FFF44242424224FFFFF42222222224FFFF4222222222224444222222
        2222222222222222222222222222222222222222222222222222222222222222
        2222}
      Visible = False
    end
    object BtnOk: TButton
      Left = 372
      Top = 5
      Width = 75
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BtnFechar: TButton
      Left = 455
      Top = 5
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
end
