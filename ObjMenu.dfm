object FormMenuObject: TFormMenuObject
  Left = 207
  Top = 126
  HelpContext = 320
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Definição dos Menus e Barra de Ferramentas'
  ClientHeight = 443
  ClientWidth = 455
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000044400000000CCCC046400000000C000044400000000C00
    0000000000000C000000000044400C00000CCCC046400C00000C000044400C00
    0000000000000C000044400000000CCCC046400000000C000044400000000000
    000000000000444000000000000046400000000000004440000000000000FFFF
    FFFFFC7F0000847F0000BC7F1300BFFF1700BFF10000BE113405BEF10000BFFF
    0400BC7F0000847F0000BC7FE0FFFFFFE0FF1FFFE0FF1FFFE0FF1FFFE0FF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object XBanner: TXBanner
    Left = 0
    Top = 0
    Width = 24
    Height = 443
    Align = alLeft
    Alignment = AtaLeftJustify
    Angle = 90
    Caption = '   Definição do Menu de Acesso'
    ColorOf = clWindow
    ColorFor = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Horizontal = True
    ParentFont = False
    ShadeLTSet = False
    Style3D = A3dNormal
  end
  object LbID: TLabel
    Left = 30
    Top = 412
    Width = 26
    Height = 13
    Caption = 'ID.: 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 30
    Top = 8
    Width = 421
    Height = 400
    ActivePage = TabSheet3
    Anchors = [akLeft, akTop, akRight]
    HotTrack = True
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Menu &Lateral'
      object ControlBar: TControlBar
        Left = 0
        Top = 0
        Width = 413
        Height = 26
        Align = alTop
        AutoSize = True
        BevelEdges = []
        TabOrder = 0
        object ToolBar: TToolBar
          Left = 118
          Top = 2
          Width = 35
          Height = 22
          HelpContext = 320
          Align = alClient
          AutoSize = True
          Caption = 'ToolBar'
          EdgeBorders = []
          Flat = True
          Images = FormPrincipal.ListaImagem
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object BtnRedefinir: TToolButton
            Left = 0
            Top = 0
            Hint = 
              'Redefinir Menu Superior & Barra de Ferramentas. '#13#10'Ler diretament' +
              'e do projeto fonte .PAS e .DFM'
            Caption = 'BtnRedefinir'
            ImageIndex = 15
            OnClick = BtnRedefinirClick
          end
        end
        object ToolBar3: TToolBar
          Left = 11
          Top = 2
          Width = 94
          Height = 22
          HelpContext = 320
          Align = alClient
          AutoSize = True
          Caption = 'ToolBar'
          EdgeBorders = []
          Flat = True
          Images = FormPrincipal.ListaImagem
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object BtnNovo: TToolButton
            Left = 0
            Top = 0
            Hint = 'Inserir Novo Item ( Insert )'
            Caption = 'BtnNovo'
            DropdownMenu = PopInserir
            ImageIndex = 57
            Style = tbsDropDown
          end
          object BtnDeletar: TToolButton
            Left = 36
            Top = 0
            Hint = 'Excluir Item Selecionado ( Del )'
            Caption = 'BtnDeletar'
            ImageIndex = 58
            OnClick = BtnDeletarClick
          end
          object BtnModificar: TToolButton
            Left = 59
            Top = 0
            Hint = 'Modificar Propriedades ( F2 )'
            Caption = 'BtnModificar'
            ImageIndex = 43
            OnClick = BtnModificarClick
          end
        end
      end
      object TreeViewMenu: TTreeView
        Left = 4
        Top = 27
        Width = 404
        Height = 342
        HelpContext = 320
        Anchors = [akLeft, akTop, akRight]
        Color = clWhite
        DragCursor = crDefault
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HideSelection = False
        HotTrack = True
        Images = FormPrincipal.ListaImagem
        Indent = 19
        ParentFont = False
        ReadOnly = True
        RightClickSelect = True
        TabOrder = 1
        OnChange = TreeViewMenuChange
        OnDblClick = TreeViewMenuDblClick
        OnKeyUp = TreeViewMenuKeyUp
      end
      object EdImagem: TComboBox
        Left = 176
        Top = 136
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = 'EdImagem'
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Menu &Superior'
      ImageIndex = 1
      object ControlBar1: TControlBar
        Left = 0
        Top = 0
        Width = 413
        Height = 26
        Align = alTop
        AutoSize = True
        BevelEdges = []
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 11
          Top = 2
          Width = 94
          Height = 22
          HelpContext = 320
          Align = alClient
          AutoSize = True
          Caption = 'ToolBar'
          EdgeBorders = []
          Flat = True
          Images = FormPrincipal.ListaImagem
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            Hint = 'Inserir Novo Item ( Insert )'
            Caption = 'BtnNovo'
            DropdownMenu = PopInserir
            ImageIndex = 57
            Style = tbsDropDown
          end
          object ToolButton2: TToolButton
            Left = 36
            Top = 0
            Hint = 'Excluir Item Selecionado ( Del )'
            Caption = 'BtnDeletar'
            ImageIndex = 58
            OnClick = BtnDeletarClick
          end
          object ToolButton3: TToolButton
            Left = 59
            Top = 0
            Hint = 'Modificar Propriedades ( F2 )'
            Caption = 'BtnModificar'
            ImageIndex = 43
            OnClick = BtnModificarClick
          end
        end
        object ToolBar4: TToolBar
          Left = 118
          Top = 2
          Width = 35
          Height = 22
          HelpContext = 320
          Align = alClient
          AutoSize = True
          Caption = 'ToolBar'
          EdgeBorders = []
          Flat = True
          Images = FormPrincipal.ListaImagem
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object ToolButton7: TToolButton
            Left = 0
            Top = 0
            Hint = 
              'Redefinir Menu Superior & Barra de Ferramentas. '#13#10'Ler diretament' +
              'e do projeto fonte .PAS e .DFM'
            Caption = 'BtnRedefinir'
            ImageIndex = 15
            OnClick = BtnRedefinirClick
          end
        end
      end
      object TreeViewMenu_1: TTreeView
        Left = 4
        Top = 27
        Width = 404
        Height = 342
        HelpContext = 320
        Anchors = [akLeft, akTop, akRight]
        Color = clWhite
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HideSelection = False
        HotTrack = True
        Images = FormPrincipal.ListaImagem
        Indent = 19
        ParentFont = False
        ReadOnly = True
        RightClickSelect = True
        TabOrder = 1
        OnChange = TreeViewMenuChange
        OnDblClick = TreeViewMenuDblClick
        OnKeyUp = TreeViewMenuKeyUp
      end
    end
    object TabSheet3: TTabSheet
      Caption = '&Barra de Ferramentas'
      ImageIndex = 2
      object ControlBar2: TControlBar
        Left = 0
        Top = 0
        Width = 413
        Height = 26
        Align = alTop
        AutoSize = True
        BevelEdges = []
        TabOrder = 0
        object ToolBar2: TToolBar
          Left = 11
          Top = 2
          Width = 94
          Height = 22
          HelpContext = 320
          Align = alClient
          AutoSize = True
          Caption = 'ToolBar'
          EdgeBorders = []
          Flat = True
          Images = FormPrincipal.ListaImagem
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton4: TToolButton
            Left = 0
            Top = 0
            Hint = 'Inserir Novo Item ( Insert )'
            Caption = 'BtnNovo'
            DropdownMenu = PopInserir
            ImageIndex = 57
            Style = tbsDropDown
          end
          object ToolButton5: TToolButton
            Left = 36
            Top = 0
            Hint = 'Excluir Item Selecionado ( Del )'
            Caption = 'BtnDeletar'
            ImageIndex = 58
            OnClick = BtnDeletarClick
          end
          object ToolButton6: TToolButton
            Left = 59
            Top = 0
            Hint = 'Modificar Propriedades ( F2 )'
            Caption = 'BtnModificar'
            ImageIndex = 43
            OnClick = BtnModificarClick
          end
        end
        object ToolBar5: TToolBar
          Left = 118
          Top = 2
          Width = 35
          Height = 22
          HelpContext = 320
          Align = alClient
          AutoSize = True
          Caption = 'ToolBar'
          EdgeBorders = []
          Flat = True
          Images = FormPrincipal.ListaImagem
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object ToolButton8: TToolButton
            Left = 0
            Top = 0
            Hint = 
              'Redefinir Menu Superior & Barra de Ferramentas. '#13#10'Ler diretament' +
              'e do projeto fonte .PAS e .DFM'
            Caption = 'BtnRedefinir'
            ImageIndex = 15
            OnClick = BtnRedefinirClick
          end
        end
      end
      object TreeViewMenu_2: TTreeView
        Left = 4
        Top = 27
        Width = 404
        Height = 342
        HelpContext = 320
        Anchors = [akLeft, akTop, akRight]
        Color = clWhite
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HideSelection = False
        HotTrack = True
        Images = FormPrincipal.ListaImagem
        Indent = 19
        ParentFont = False
        ReadOnly = True
        RightClickSelect = True
        TabOrder = 1
        OnChange = TreeViewMenuChange
        OnDblClick = TreeViewMenuDblClick
        OnKeyUp = TreeViewMenuKeyUp
      end
    end
  end
  object BtnGravar: TBitBtn
    Left = 210
    Top = 414
    Width = 75
    Height = 25
    Hint = 'Gravar definição do menu principal'
    HelpContext = 320
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnGravarClick
  end
  object BtnFechar: TBitBtn
    Left = 293
    Top = 414
    Width = 75
    Height = 25
    Hint = 'Fechar definição'
    HelpContext = 320
    Caption = '&Fechar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BtnAjuda: TBitBtn
    Left = 376
    Top = 414
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    HelpContext = 320
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnAjudaClick
    NumGlyphs = 2
  end
  object TextoPAS: TSynEdit
    Left = 131
    Top = 419
    Width = 33
    Height = 17
    Cursor = crIBeam
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 4
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
      'TextoDFM')
  end
  object TextoDFM: TSynEdit
    Left = 171
    Top = 419
    Width = 33
    Height = 17
    Cursor = crIBeam
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 5
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
      'TextoDFM')
  end
  object PopInserir: TPopupMenu
    Left = 108
    Top = 197
    object SubMenu: TMenuItem
      Caption = 'Sub-Menu'
      Hint = 'Inserir Sub-Menu'
      OnClick = SubMenuClick
    end
    object Formulario: TMenuItem
      Caption = 'Formulário/Relatório/Etiqueta/Gráfico'
      Hint = 'Inserir Formulário Definido no Projeto'
      OnClick = FormularioClick
    end
    object RotinaAvulsa: TMenuItem
      Caption = 'Rotina Avulsa'
      Hint = 
        'Inserir Rotina Avulsa ( Editar o Evento Ao Clicar para Codificaç' +
        'ão )'
      OnClick = RotinaAvulsaClick
    end
    object ProgramaExternoEXE: TMenuItem
      Caption = 'Programa Externo (EXE)'
      OnClick = ProgramaExternoEXEClick
    end
  end
  object OpenExe: TOpenDialog
    Filter = 
      'Executáveis ( *.exe; *.com; *.bat )|*.exe; *.com; *.bat|Todos os' +
      ' arquivos ( *.* )|*.*'
    Left = 146
    Top = 197
  end
  object DataSource: TDataSource
    Left = 72
    Top = 193
  end
end
