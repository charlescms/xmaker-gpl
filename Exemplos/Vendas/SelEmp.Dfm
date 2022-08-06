object FormSelecionaEmpresa: TFormSelecionaEmpresa
  Left = 237
  Top = 140
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Seleciona / Configura Empresa Usuária'
  ClientHeight = 419
  ClientWidth = 375
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
  object Panel2: TPanel
    Left = 0
    Top = 385
    Width = 375
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnCancela: TBitBtn
      Left = 295
      Top = 6
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
      Left = 131
      Top = 6
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
      Left = 213
      Top = 6
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
  object PageControl1: TPageControl
    Left = 5
    Top = 6
    Width = 365
    Height = 379
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Empresas'
      object lbEmpresas: TListBox
        Left = 1
        Top = 2
        Width = 353
        Height = 316
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 17
        ParentFont = False
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnClick = lbEmpresasClick
        OnDblClick = BtnOkClick
      end
      object BtnIncluir: TBitBtn
        Left = 116
        Top = 323
        Width = 75
        Height = 25
        Hint = 'Incluir nova empresa'
        Caption = '&Incluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnIncluirClick
        NumGlyphs = 2
      end
      object BtnEditar: TBitBtn
        Left = 198
        Top = 323
        Width = 75
        Height = 25
        Hint = 'Editar empresa'
        Caption = '&Editar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BtnEditarClick
        NumGlyphs = 2
      end
      object BtnExcluir: TBitBtn
        Left = 280
        Top = 323
        Width = 75
        Height = 25
        Hint = 'Excluir empresa'
        Cancel = True
        Caption = 'E&xcluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BtnExcluirClick
        NumGlyphs = 2
      end
    end
  end
end
