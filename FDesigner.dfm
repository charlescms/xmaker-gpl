object FormDesigner_Net: TFormDesigner_Net
  Left = 190
  Top = 176
  Width = 696
  Height = 480
  Caption = 'Layout'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter_L: TSplitter
    Left = 193
    Top = 0
    Width = 3
    Height = 453
    Cursor = crHSplit
    AutoSnap = False
    MinSize = 90
  end
  object PnEsquerdo: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 453
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = PnEsquerdoResize
    object Texto_DFM: TSynEdit
      Left = 24
      Top = 104
      Width = 103
      Height = 49
      Cursor = crIBeam
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Visible = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Terminal'
      Gutter.Font.Style = []
      Keystrokes = <
        item
          Command = ecUp
          ShortCut = 38
        end
        item
          Command = ecSelUp
          ShortCut = 8230
        end
        item
          Command = ecScrollUp
          ShortCut = 16422
        end
        item
          Command = ecDown
          ShortCut = 40
        end
        item
          Command = ecSelDown
          ShortCut = 8232
        end
        item
          Command = ecScrollDown
          ShortCut = 16424
        end
        item
          Command = ecLeft
          ShortCut = 37
        end
        item
          Command = ecSelLeft
          ShortCut = 8229
        end
        item
          Command = ecWordLeft
          ShortCut = 16421
        end
        item
          Command = ecSelWordLeft
          ShortCut = 24613
        end
        item
          Command = ecRight
          ShortCut = 39
        end
        item
          Command = ecSelRight
          ShortCut = 8231
        end
        item
          Command = ecWordRight
          ShortCut = 16423
        end
        item
          Command = ecSelWordRight
          ShortCut = 24615
        end
        item
          Command = ecPageDown
          ShortCut = 34
        end
        item
          Command = ecSelPageDown
          ShortCut = 8226
        end
        item
          Command = ecPageBottom
          ShortCut = 16418
        end
        item
          Command = ecSelPageBottom
          ShortCut = 24610
        end
        item
          Command = ecPageUp
          ShortCut = 33
        end
        item
          Command = ecSelPageUp
          ShortCut = 8225
        end
        item
          Command = ecPageTop
          ShortCut = 16417
        end
        item
          Command = ecSelPageTop
          ShortCut = 24609
        end
        item
          Command = ecLineStart
          ShortCut = 36
        end
        item
          Command = ecSelLineStart
          ShortCut = 8228
        end
        item
          Command = ecEditorTop
          ShortCut = 16420
        end
        item
          Command = ecSelEditorTop
          ShortCut = 24612
        end
        item
          Command = ecLineEnd
          ShortCut = 35
        end
        item
          Command = ecSelLineEnd
          ShortCut = 8227
        end
        item
          Command = ecEditorBottom
          ShortCut = 16419
        end
        item
          Command = ecSelEditorBottom
          ShortCut = 24611
        end
        item
          Command = ecToggleMode
          ShortCut = 45
        end
        item
          Command = ecCopy
          ShortCut = 16429
        end
        item
          Command = ecCut
          ShortCut = 8238
        end
        item
          Command = ecPaste
          ShortCut = 8237
        end
        item
          Command = ecDeleteChar
          ShortCut = 46
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8200
        end
        item
          Command = ecDeleteLastWord
          ShortCut = 16392
        end
        item
          Command = ecUndo
          ShortCut = 32776
        end
        item
          Command = ecRedo
          ShortCut = 40968
        end
        item
          Command = ecLineBreak
          ShortCut = 13
        end
        item
          Command = ecLineBreak
          ShortCut = 8205
        end
        item
          Command = ecTab
          ShortCut = 9
        end
        item
          Command = ecShiftTab
          ShortCut = 8201
        end
        item
          Command = ecContextHelp
          ShortCut = 16496
        end
        item
          Command = ecSelectAll
          ShortCut = 16449
        end
        item
          Command = ecCopy
          ShortCut = 16451
        end
        item
          Command = ecPaste
          ShortCut = 16470
        end
        item
          Command = ecCut
          ShortCut = 16472
        end
        item
          Command = ecBlockIndent
          ShortCut = 24649
        end
        item
          Command = ecBlockUnindent
          ShortCut = 24661
        end
        item
          Command = ecLineBreak
          ShortCut = 16461
        end
        item
          Command = ecInsertLine
          ShortCut = 16462
        end
        item
          Command = ecDeleteWord
          ShortCut = 16468
        end
        item
          Command = ecDeleteLine
          ShortCut = 16473
        end
        item
          Command = ecDeleteEOL
          ShortCut = 24665
        end
        item
          Command = ecUndo
          ShortCut = 16474
        end
        item
          Command = ecRedo
          ShortCut = 24666
        end
        item
          Command = ecGotoMarker0
          ShortCut = 16432
        end
        item
          Command = ecGotoMarker1
          ShortCut = 16433
        end
        item
          Command = ecGotoMarker2
          ShortCut = 16434
        end
        item
          Command = ecGotoMarker3
          ShortCut = 16435
        end
        item
          Command = ecGotoMarker4
          ShortCut = 16436
        end
        item
          Command = ecGotoMarker5
          ShortCut = 16437
        end
        item
          Command = ecGotoMarker6
          ShortCut = 16438
        end
        item
          Command = ecGotoMarker7
          ShortCut = 16439
        end
        item
          Command = ecGotoMarker8
          ShortCut = 16440
        end
        item
          Command = ecGotoMarker9
          ShortCut = 16441
        end
        item
          Command = ecSetMarker0
          ShortCut = 24624
        end
        item
          Command = ecSetMarker1
          ShortCut = 24625
        end
        item
          Command = ecSetMarker2
          ShortCut = 24626
        end
        item
          Command = ecSetMarker3
          ShortCut = 24627
        end
        item
          Command = ecSetMarker4
          ShortCut = 24628
        end
        item
          Command = ecSetMarker5
          ShortCut = 24629
        end
        item
          Command = ecSetMarker6
          ShortCut = 24630
        end
        item
          Command = ecSetMarker7
          ShortCut = 24631
        end
        item
          Command = ecSetMarker8
          ShortCut = 24632
        end
        item
          Command = ecSetMarker9
          ShortCut = 24633
        end
        item
          Command = ecNormalSelect
          ShortCut = 24654
        end
        item
          Command = ecColumnSelect
          ShortCut = 24643
        end
        item
          Command = ecLineSelect
          ShortCut = 24652
        end
        item
          Command = ecMatchBracket
          ShortCut = 24642
        end>
      Lines.Strings = (
        'Texto_DFM')
    end
    object Texto_TXT: TSynEdit
      Left = 32
      Top = 160
      Width = 103
      Height = 49
      Cursor = crIBeam
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      Visible = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Terminal'
      Gutter.Font.Style = []
      Keystrokes = <
        item
          Command = ecUp
          ShortCut = 38
        end
        item
          Command = ecSelUp
          ShortCut = 8230
        end
        item
          Command = ecScrollUp
          ShortCut = 16422
        end
        item
          Command = ecDown
          ShortCut = 40
        end
        item
          Command = ecSelDown
          ShortCut = 8232
        end
        item
          Command = ecScrollDown
          ShortCut = 16424
        end
        item
          Command = ecLeft
          ShortCut = 37
        end
        item
          Command = ecSelLeft
          ShortCut = 8229
        end
        item
          Command = ecWordLeft
          ShortCut = 16421
        end
        item
          Command = ecSelWordLeft
          ShortCut = 24613
        end
        item
          Command = ecRight
          ShortCut = 39
        end
        item
          Command = ecSelRight
          ShortCut = 8231
        end
        item
          Command = ecWordRight
          ShortCut = 16423
        end
        item
          Command = ecSelWordRight
          ShortCut = 24615
        end
        item
          Command = ecPageDown
          ShortCut = 34
        end
        item
          Command = ecSelPageDown
          ShortCut = 8226
        end
        item
          Command = ecPageBottom
          ShortCut = 16418
        end
        item
          Command = ecSelPageBottom
          ShortCut = 24610
        end
        item
          Command = ecPageUp
          ShortCut = 33
        end
        item
          Command = ecSelPageUp
          ShortCut = 8225
        end
        item
          Command = ecPageTop
          ShortCut = 16417
        end
        item
          Command = ecSelPageTop
          ShortCut = 24609
        end
        item
          Command = ecLineStart
          ShortCut = 36
        end
        item
          Command = ecSelLineStart
          ShortCut = 8228
        end
        item
          Command = ecEditorTop
          ShortCut = 16420
        end
        item
          Command = ecSelEditorTop
          ShortCut = 24612
        end
        item
          Command = ecLineEnd
          ShortCut = 35
        end
        item
          Command = ecSelLineEnd
          ShortCut = 8227
        end
        item
          Command = ecEditorBottom
          ShortCut = 16419
        end
        item
          Command = ecSelEditorBottom
          ShortCut = 24611
        end
        item
          Command = ecToggleMode
          ShortCut = 45
        end
        item
          Command = ecCopy
          ShortCut = 16429
        end
        item
          Command = ecCut
          ShortCut = 8238
        end
        item
          Command = ecPaste
          ShortCut = 8237
        end
        item
          Command = ecDeleteChar
          ShortCut = 46
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8200
        end
        item
          Command = ecDeleteLastWord
          ShortCut = 16392
        end
        item
          Command = ecUndo
          ShortCut = 32776
        end
        item
          Command = ecRedo
          ShortCut = 40968
        end
        item
          Command = ecLineBreak
          ShortCut = 13
        end
        item
          Command = ecLineBreak
          ShortCut = 8205
        end
        item
          Command = ecTab
          ShortCut = 9
        end
        item
          Command = ecShiftTab
          ShortCut = 8201
        end
        item
          Command = ecContextHelp
          ShortCut = 16496
        end
        item
          Command = ecSelectAll
          ShortCut = 16449
        end
        item
          Command = ecCopy
          ShortCut = 16451
        end
        item
          Command = ecPaste
          ShortCut = 16470
        end
        item
          Command = ecCut
          ShortCut = 16472
        end
        item
          Command = ecBlockIndent
          ShortCut = 24649
        end
        item
          Command = ecBlockUnindent
          ShortCut = 24661
        end
        item
          Command = ecLineBreak
          ShortCut = 16461
        end
        item
          Command = ecInsertLine
          ShortCut = 16462
        end
        item
          Command = ecDeleteWord
          ShortCut = 16468
        end
        item
          Command = ecDeleteLine
          ShortCut = 16473
        end
        item
          Command = ecDeleteEOL
          ShortCut = 24665
        end
        item
          Command = ecUndo
          ShortCut = 16474
        end
        item
          Command = ecRedo
          ShortCut = 24666
        end
        item
          Command = ecGotoMarker0
          ShortCut = 16432
        end
        item
          Command = ecGotoMarker1
          ShortCut = 16433
        end
        item
          Command = ecGotoMarker2
          ShortCut = 16434
        end
        item
          Command = ecGotoMarker3
          ShortCut = 16435
        end
        item
          Command = ecGotoMarker4
          ShortCut = 16436
        end
        item
          Command = ecGotoMarker5
          ShortCut = 16437
        end
        item
          Command = ecGotoMarker6
          ShortCut = 16438
        end
        item
          Command = ecGotoMarker7
          ShortCut = 16439
        end
        item
          Command = ecGotoMarker8
          ShortCut = 16440
        end
        item
          Command = ecGotoMarker9
          ShortCut = 16441
        end
        item
          Command = ecSetMarker0
          ShortCut = 24624
        end
        item
          Command = ecSetMarker1
          ShortCut = 24625
        end
        item
          Command = ecSetMarker2
          ShortCut = 24626
        end
        item
          Command = ecSetMarker3
          ShortCut = 24627
        end
        item
          Command = ecSetMarker4
          ShortCut = 24628
        end
        item
          Command = ecSetMarker5
          ShortCut = 24629
        end
        item
          Command = ecSetMarker6
          ShortCut = 24630
        end
        item
          Command = ecSetMarker7
          ShortCut = 24631
        end
        item
          Command = ecSetMarker8
          ShortCut = 24632
        end
        item
          Command = ecSetMarker9
          ShortCut = 24633
        end
        item
          Command = ecNormalSelect
          ShortCut = 24654
        end
        item
          Command = ecColumnSelect
          ShortCut = 24643
        end
        item
          Command = ecLineSelect
          ShortCut = 24652
        end
        item
          Command = ecMatchBracket
          ShortCut = 24642
        end>
      Lines.Strings = (
        'Texto_DFM')
    end
    object TreeView_Extra: TTreeView
      Left = 0
      Top = 0
      Width = 193
      Height = 453
      Align = alClient
      Images = ImageList1
      Indent = 19
      TabOrder = 2
      OnClick = TreeView_ExtraClick
      OnDblClick = TreeView_ExtraDblClick
    end
  end
  object PnFundo: TPanel
    Left = 196
    Top = 0
    Width = 492
    Height = 453
    Align = alClient
    TabOrder = 1
    object PnInferior: TPanel
      Left = 1
      Top = 386
      Width = 490
      Height = 66
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object ListView_nao_visuais: TListView
        Left = 4
        Top = 4
        Width = 482
        Height = 60
        Align = alClient
        BorderStyle = bsNone
        Color = clInfoBk
        Columns = <>
        HotTrack = True
        IconOptions.AutoArrange = True
        LargeImages = FormPrincipal.ImageList_Paleta
        ReadOnly = True
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = ListView_nao_visuaisClick
      end
      object Panel1: TPanel
        Left = 0
        Top = 4
        Width = 4
        Height = 60
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 486
        Top = 4
        Width = 4
        Height = 60
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
      end
      object Panel4: TPanel
        Left = 0
        Top = 64
        Width = 490
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 490
        Height = 4
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
      end
    end
    object PageList_Forms: TJvPageList
      Left = 5
      Top = 28
      Width = 482
      Height = 298
      PropagateEnable = False
      Align = alClient
    end
    object TabForms: TJvTabBar
      Left = 1
      Top = 1
      Width = 490
      ShowHint = True
      Tabs = <>
      Painter = JvModernTabBarPainter1
      OnTabClosing = TabFormsTabClosing
      OnTabClosed = TabFormsTabClosed
      OnTabSelecting = TabFormsTabSelecting
      OnTabSelected = TabFormsTabSelected
    end
    object Panel5: TPanel
      Left = 1
      Top = 24
      Width = 490
      Height = 4
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
    end
    object Panel6: TPanel
      Left = 1
      Top = 28
      Width = 4
      Height = 298
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
    end
    object Panel7: TPanel
      Left = 487
      Top = 28
      Width = 4
      Height = 298
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 5
    end
    object PnError: TSMFramePanel
      Left = 1
      Top = 330
      Width = 490
      Height = 56
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 6
      Visible = False
      GrabberPlace = gpLeft
      object ListaErros: TListBox
        Left = 12
        Top = 2
        Width = 476
        Height = 52
        Align = alClient
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnClick = ListaErrosClick
        OnDrawItem = ListaErrosDrawItem
      end
      object PnSetas: TPanel
        Left = 13
        Top = 4
        Width = 18
        Height = 48
        BevelOuter = bvNone
        Color = clWindow
        TabOrder = 1
        object Image_seta_1: TImage
          Left = 1
          Top = 2
          Width = 8
          Height = 11
          AutoSize = True
          Picture.Data = {
            07544269746D6170A2000000424DA20000000000000076000000280000000800
            00000B00000001000400000000002C0000000000000000000000100000000000
            0000000000000000800000800000008080008000000080008000808000008080
            8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00F0FFFFFFF00FFFFFF000FFFFF0000FFFF00000FFF000000FF00000FFF000
            0FFFF000FFFFF00FFFFFF0FFFFFF}
          OnClick = Image_seta_1Click
        end
        object Image_seta_2: TImage
          Tag = 1
          Left = 1
          Top = 18
          Width = 8
          Height = 11
          AutoSize = True
          Picture.Data = {
            07544269746D6170A2000000424DA20000000000000076000000280000000800
            00000B00000001000400000000002C0000000000000000000000100000000000
            0000000000000000800000800000008080008000000080008000808000008080
            8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00F0FFFFFFF00FFFFFF000FFFFF0000FFFF00000FFF000000FF00000FFF000
            0FFFF000FFFFF00FFFFFF0FFFFFF}
          OnClick = Image_seta_1Click
        end
        object Image_seta_3: TImage
          Tag = 2
          Left = 1
          Top = 34
          Width = 8
          Height = 11
          AutoSize = True
          Picture.Data = {
            07544269746D6170A2000000424DA20000000000000076000000280000000800
            00000B00000001000400000000002C0000000000000000000000100000000000
            0000000000000000800000800000008080008000000080008000808000008080
            8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00F0FFFFFFF00FFFFFF000FFFFF0000FFFF00000FFF000000FF00000FFF000
            0FFFF000FFFFF00FFFFFF0FFFFFF}
          OnClick = Image_seta_1Click
        end
      end
    end
    object PnDivError: TPanel
      Left = 1
      Top = 326
      Width = 490
      Height = 4
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 7
      Visible = False
    end
  end
  object JvModernTabBarPainter1: TJvModernTabBarPainter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DisabledFont.Charset = DEFAULT_CHARSET
    DisabledFont.Color = clGrayText
    DisabledFont.Height = -11
    DisabledFont.Name = 'MS Sans Serif'
    DisabledFont.Style = []
    SelectedFont.Charset = DEFAULT_CHARSET
    SelectedFont.Color = clBlue
    SelectedFont.Height = -11
    SelectedFont.Name = 'MS Sans Serif'
    SelectedFont.Style = []
    Left = 65
    Top = 277
  end
  object PopupDesig: TPopupMenu
    Images = FormPrincipal.ListaImagem
    OnPopup = PopupDesigPopup
    Left = 57
    Top = 227
    object EditarRelatorio: TMenuItem
      Caption = 'Editar Relat�rio'
      ImageIndex = 96
      Visible = False
      OnClick = EditarRelatorioClick
    end
    object NovaPagina: TMenuItem
      Caption = 'Nova P�gina'
      ImageIndex = 17
      Visible = False
      OnClick = NovaPaginaClick
    end
    object EditarMenu: TMenuItem
      Caption = 'Editar Menu'
      ImageIndex = 79
      Visible = False
      OnClick = EditarMenuClick
    end
    object Divisao_NvPg: TMenuItem
      Caption = '-'
      Visible = False
    end
    object Enviarparafrente: TMenuItem
      Caption = 'Enviar para frente'
      ImageIndex = 94
      OnClick = EnviarparafrenteClick
    end
    object Enviarparatras: TMenuItem
      Caption = 'Enviar para tr�s'
      ImageIndex = 95
      OnClick = EnviarparatrasClick
    end
    object Dsg_N3: TMenuItem
      Caption = '-'
    end
    object Alinhamento: TMenuItem
      Caption = 'Alinhamento ...'
      ImageIndex = 99
      OnClick = AlinhamentoClick
    end
    object PaletadeAlinhamento: TMenuItem
      Caption = 'Paleta de Alinhamento'
      ImageIndex = 114
      OnClick = PaletadeAlinhamentoClick
    end
    object Alinhar: TMenuItem
      Caption = 'Alinhar'
      ImageIndex = 115
      OnClick = AlinharClick
    end
    object Dimensoes: TMenuItem
      Caption = 'Tamanho ...'
      ImageIndex = 100
      OnClick = DimensoesClick
    end
    object TabOrder: TMenuItem
      Caption = 'Sequ�ncia (Tab Ordem)'
      ImageIndex = 92
      OnClick = TabOrderClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Expresso: TMenuItem
      Caption = 'Express�o'
      Hint = 'Inserir express�o'
      ImageIndex = 119
      OnClick = ExpressoClick
    end
    object Campos: TMenuItem
      Caption = 'Campos'
      Hint = 'Inserir campo'
      ImageIndex = 121
      OnClick = CamposClick
    end
    object Formularios: TMenuItem
      Caption = 'Formul�rios'
      Hint = 'Formul�rios do projeto'
      ImageIndex = 120
      OnClick = FormulariosClick
    end
    object Dsg_N1: TMenuItem
      Caption = '-'
    end
    object Recortar: TMenuItem
      Caption = 'Recortar'
      ImageIndex = 28
      ShortCut = 16472
      OnClick = RecortarClick
    end
    object Copiar: TMenuItem
      Caption = 'Copiar'
      ImageIndex = 7
      ShortCut = 16451
      OnClick = CopiarClick
    end
    object Colar: TMenuItem
      Caption = 'Colar'
      ImageIndex = 5
      ShortCut = 16470
      OnClick = ColarClick
    end
    object SelecionarTodos: TMenuItem
      Caption = 'Selecionar Tudo'
      ImageIndex = 87
      ShortCut = 16449
      OnClick = SelecionarTodosClick
    end
    object Selecionar: TMenuItem
      Caption = 'Selecionar (Especial)'
      ShortCut = 24641
      OnClick = SelecionarClick
    end
    object Comentar: TMenuItem
      Caption = 'Comentar'
      Hint = 'Comentar bloco'
      ImageIndex = 110
      OnClick = ComentarClick
    end
    object Descomentar: TMenuItem
      Caption = 'Descomentar'
      Hint = 'Descomentar bloco'
      ImageIndex = 111
      OnClick = DescomentarClick
    end
    object Dsg_N2: TMenuItem
      Caption = '-'
    end
    object Bloquear: TMenuItem
      Caption = 'Bloquear'
      ImageIndex = 73
      OnClick = BloquearClick
    end
    object Excluir: TMenuItem
      Caption = 'Excluir'
      ImageIndex = 58
      OnClick = ExcluirClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Propriedades: TMenuItem
      Caption = 'Propriedades'
      ImageIndex = 116
      OnClick = PropriedadesClick
    end
  end
  object ImageList1: TImageList
    Left = 88
    Top = 364
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F0000000000000000007F7F7F00007F0000007F0000007F
      0000000000007F7F7F007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      00007F7F7F007F7F7F007F7F7F0000000000007F0000007F0000007F0000007F
      0000007F0000000000007F7F7F00000000007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000007F7F7F007F7F7F00007F0000007F0000007F0000007F0000007F
      0000007F0000000000007F7F7F00000000007F7F7F000000000000FFFF00BFBF
      BF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      0000000000008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000007F000000FF0000007F0000007F0000007F
      0000007F0000007F000000000000000000007F7F7F0000000000BFBFBF0000FF
      FF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF00BFBFBF007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF0000007F0000007F0000007F00007F000000FF000000FF0000007F0000007F
      0000007F0000007F000000000000000000007F7F7F000000000000FFFF00BFBF
      BF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      000000FF000000FF000000800000000000008080800000FF000000FF000000FF
      000000FF00008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      7F0000007F0000007F0000007F00000000007F7F7F0000FF000000FF0000007F
      0000007F00000000000000000000000000007F7F7F0000000000BFBFBF0000FF
      FF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF00BFBFBF007F7F7F00000000000000000000000000000000000000000000FF
      000000FF000000FF00000080000000000000808080000080000000FF000000FF
      000000FF00008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      7F0000007F0000000000000000000000000000000000007F0000007F0000007F
      0000000000000000000000000000000000007F7F7F000000000000FFFF00BFBF
      BF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF007F7F7F000000000000000000000000008080800000FF000000FF
      000000FF0000808080000080000000000000000000000000000000FF000000FF
      000000FF00008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF0000007F000000
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      00007F7F7F007F7F7F0000000000000000007F7F7F0000000000BFBFBF0000FF
      FF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF00BFBFBF007F7F7F00000000000000000000000000000000008080800000FF
      0000808080008080800000800000008000000080000000FF000000FF000000FF
      000000FF00008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F000000FF000000FF000000FF000000FF00
      0000000000007F7F7F0000000000000000007F7F7F000000000000FFFF00BFBF
      BF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF007F7F7F0000000000000000000000000000000000000000008080
      80000000000080808000008000000080000000FF000000FF000000FF00000000
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
      0000000000007F7F7F0000000000000000007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F0000000000000000000000000000000000000000000000
      000000000000808080000080000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF0000007F000000FF00
      0000000000007F7F7F0000000000000000007F7F7F00BFBFBF0000FFFF00BFBF
      BF0000FFFF00BFBFBF0000FFFF00BFBFBF007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      0000000000008080800000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF0000007F000000FF0000007F00
      0000000000007F7F7F000000000000000000000000007F7F7F00BFBFBF0000FF
      FF00BFBFBF0000FFFF00BFBFBF007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F000000FF0000007F0000007F00
      00007F00000000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F0000007F0000007F00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFC7FFFFFFFF0000F783FFFFFFFF0000
      E3018001FFFF000081010001FFFF000080014001F8FF000080034001F0430000
      80034001E003000081074001C0030000878F4001800300009F034001C0030000
      FE034001E8170000FE037FF9F83F0000FE030003F87F0000FE0380FFFCFF0000
      FF07C1FFFFFF0000FF8FFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object ListaParametros: TSynCompletionProposal
    DefaultType = ctParams
    Options = [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer]
    Position = 0
    NbLinesInWindow = 8
    ClSelect = clHighlight
    ClSelectedText = clHighlightText
    ClBackground = clInfoBk
    Width = 262
    BiggestWord = 'constructor'
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Title = 'Par�metros'
    ClTitleBackground = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    ShortCut = 8224
    TimerInterval = 1000
    OnCancelled = ListaParametrosCancelled
    Left = 72
    Top = 128
  end
  object ListaFuncoes: TSynCompletionProposal
    DefaultType = ctCode
    Options = [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer]
    Position = 0
    NbLinesInWindow = 8
    ClSelect = clHighlight
    ClSelectedText = clHighlightText
    ClBackground = clWindow
    Width = 400
    BiggestWord = 'constructor'
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Title = 'Fun��es Especiais'
    ClTitleBackground = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    ShortCut = 16416
    TimerInterval = 1000
    OnCodeCompletion = ListaFuncoesCodeCompletion
    Left = 104
    Top = 128
  end
end
