object FormDefModelos: TFormDefModelos
  Left = 249
  Top = 236
  HelpContext = 360
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Modelos para Projetos'
  ClientHeight = 242
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 205
    Width = 406
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnEditar: TBitBtn
      Left = 166
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Editar Modelo'
      Caption = '&Editar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnEditarClick
    end
    object BtnExcluir: TBitBtn
      Left = 246
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Excluir Modelo'
      Caption = 'E&xcluir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BtnExcluirClick
      NumGlyphs = 2
    end
    object BtnFechar: TBitBtn
      Left = 326
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Fechar'
      Caption = '&Fechar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BtnNovo: TBitBtn
      Left = 85
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Novo Modelo'
      Caption = '&Novo'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnNovoClick
    end
  end
  object Pagina: TPageControl
    Left = 4
    Top = 0
    Width = 397
    Height = 205
    ActivePage = TabFontes
    HotTrack = True
    TabOrder = 0
    OnChange = PaginaChange
    object TabFontes: TTabSheet
      Caption = 'Modelos'
      object Lista: TListBox
        Left = 0
        Top = 0
        Width = 389
        Height = 177
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListaClick
        OnDblClick = ListaDblClick
      end
    end
    object TabForm: TTabSheet
      Caption = 'Formulários'
      ImageIndex = 1
      TabVisible = False
      object Lista_F: TListBox
        Left = 0
        Top = 0
        Width = 389
        Height = 177
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = ListaDblClick
      end
    end
  end
end
