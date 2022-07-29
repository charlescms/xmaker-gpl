object FormEditor: TFormEditor
  Left = 241
  Top = 155
  Width = 599
  Height = 443
  BiDiMode = bdLeftToRight
  Caption = 'Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000009990000000000000000000000000999911199999999999999000000
    0009991117071111111111111900099999991177700088888888888819000991
    11117770000F000000000000190009907777000FFF0FFFFFFFFFFFF019000990
    7000FFFFFF0FFFFFFFFFFFF01900099070FFFFFFFF0FFFFFFFFFFFF019000990
    70FFFFF8FF0FFFFFFFFFFFF01900099070FFF8FFFF0FFFFFFFFFFFF019000990
    70F8FFFFFF0FFFFFFFFFFFF01900099070FFFFF8FF0FFFFF00FFFFF019000990
    70FFF8FFFF0FFFF000FFFFF01900099070F8FFFFFF0F8FF0B0FFFFF019000990
    70FFFFF8FF0FFF0BB0FFFFF01900099070FFF8FFFF0F8F0B00F88FF019000990
    F0F8FFFFFF0FF0BB0FFFFFF019000990F0FFFFF8FF00F0B0FFFFFFF000000990
    F0FFF8FFFF000BB00000000000000990F0F8FFFFF0000B000000000000000990
    F0FFFFF00000BB00000000000000000000FF00000000B0000000000000000000
    000000000000B000000000000000000000000000000C00000000000000000000
    0000000000CC0000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFF800003FE000003800000038000
    0003800000038000000380000003800000038000000380000003800000038000
    0003800000038000000380000003800000038000000F8001000F80031FFF8006
    1FFFE01E3FFFF8FC3FFFFFFC7FFFFFF87FFFFFFC7FFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 397
    Width = 591
    Height = 19
    Panels = <
      item
        Width = 110
      end
      item
        Alignment = taCenter
        Width = 80
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object PageEditor: TPageControl
    Left = 0
    Top = 0
    Width = 591
    Height = 368
    Align = alClient
    HotTrack = True
    PopupMenu = PopMenu
    TabOrder = 1
    TabStop = False
    OnChange = PageEditorChange
  end
  object cbxHighlighter: TComboBox
    Left = 64
    Top = 64
    Width = 191
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Visible = False
  end
  object ListaErros: TListBox
    Left = 0
    Top = 368
    Width = 591
    Height = 29
    Align = alBottom
    ItemHeight = 13
    TabOrder = 2
    Visible = False
    OnClick = ListaErrosClick
  end
  object PopMenu: TPopupMenu
    Images = FormPrincipal.ListaImagem
    Left = 272
    Top = 64
    object PopFechar: TMenuItem
      Caption = 'Fechar'
      ShortCut = 16502
      OnClick = PopFecharClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PopRecortar: TMenuItem
      Caption = 'Recortar'
      ImageIndex = 28
      ShortCut = 16472
      OnClick = PopRecortarClick
    end
    object PopCopiar: TMenuItem
      Caption = 'Copiar'
      ImageIndex = 7
      ShortCut = 16451
      OnClick = PopCopiarClick
    end
    object PopColar: TMenuItem
      Caption = 'Colar'
      ImageIndex = 5
      ShortCut = 16470
      OnClick = PopColarClick
    end
    object PopSelecionarTudo: TMenuItem
      Caption = 'Selecionar Tudo'
      ShortCut = 16449
      OnClick = PopSelecionarTudoClick
    end
    object PopImprimir: TMenuItem
      Caption = 'Imprimir'
      ImageIndex = 31
      ShortCut = 16464
      OnClick = PopImprimirClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object PopComentar: TMenuItem
      Caption = 'Comentar'
      ImageIndex = 110
      OnClick = PopComentarClick
    end
    object PopDescomentar: TMenuItem
      Caption = 'Descomentar'
      ImageIndex = 111
      OnClick = PopDescomentarClick
    end
    object Inserir1: TMenuItem
      Caption = 'Inserir'
      object PopDataHora: TMenuItem
        Caption = 'Data e Hora'
        OnClick = PopDataHoraClick
      end
      object BlocodeComentario: TMenuItem
        Caption = 'Bloco de Comentário'
        OnClick = BlocodeComentarioClick
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object PopPropriedades: TMenuItem
      Caption = 'Propriedades'
      OnClick = PopPropriedadesClick
    end
  end
end
