object FormFiltro: TFormFiltro
  Left = 249
  Top = 137
  Width = 522
  Height = 485
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Construtor de Filtro / Seleção'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 424
    Width = 514
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object LbEspecial: TLabel
      Left = 11
      Top = 8
      Width = 104
      Height = 13
      Caption = 'Especial: Ctrl + Space'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object BtnScript: TSpeedButton
      Left = 124
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Bloco de Codificação'
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888899889988988989889889889898888888988988989888888899898898988
        8888898889988898888889888888888888888898888888888888888888888888
        8888808008808080888880808888888888888080888888888888808008888888
        8888808088888888888888808888888888888088088888888888}
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = BtnScriptClick
    end
    object Panel3: TPanel
      Left = 264
      Top = 0
      Width = 250
      Height = 34
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BtnOk: TBitBtn
        Left = 5
        Top = 4
        Width = 75
        Height = 25
        Hint = 'Atribui filtragem'
        Caption = '&Ok'
        ModalResult = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        NumGlyphs = 2
      end
      object BtnCancela: TBitBtn
        Left = 88
        Top = 4
        Width = 75
        Height = 25
        Hint = 'Cancela operação'
        Caption = '&Cancelar'
        ModalResult = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        NumGlyphs = 2
      end
      object BtnAjuda: TBitBtn
        Left = 171
        Top = 4
        Width = 75
        Height = 25
        Hint = 'Ajuda'
        Caption = 'A&juda'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BtnAjudaClick
        NumGlyphs = 2
      end
    end
  end
  object PageControl1: TPageControl
    Left = 5
    Top = 5
    Width = 505
    Height = 417
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Filtro'
      object Label1: TLabel
        Left = 1
        Top = 2
        Width = 222
        Height = 13
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '&Campos'
        FocusControl = ListaCampos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ListaCampos: TListBox
        Left = 1
        Top = 16
        Width = 222
        Height = 185
        Hint = 'Lista de campos disponíveis para filtragem'
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnDrawItem = ListaCamposDrawItem
      end
      object ExprMemo: TSynEdit
        Left = 0
        Top = 205
        Width = 497
        Height = 184
        Cursor = crIBeam
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        OnEnter = ExprMemoEnter
        OnExit = ExprMemoExit
        OnKeyPress = ExprMemoKeyPress
        OnKeyUp = ExprMemoKeyUp
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Terminal'
        Gutter.Font.Style = []
        Gutter.Visible = False
        Highlighter = SynSQLSyn2
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
        OnSpecialLineColors = ExprMemoSpecialLineColors
      end
      object Panel2: TPanel
        Left = 225
        Top = 0
        Width = 272
        Height = 205
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 4
          Top = 95
          Width = 24
          Height = 13
          Caption = '&Valor'
        end
        object Image1: TImage
          Left = 240
          Top = 181
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
        object Operacao: TRadioGroup
          Left = 4
          Top = 11
          Width = 267
          Height = 79
          Hint = 'Operadores de comparação'
          Caption = ' O&peração '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            '=   Igual'
            '<> Diferente'
            '<   Menor que'
            '<= Menor ou Igual'
            '>   Maior que'
            '>= Maior ou Igual'
            '%  Contém'
            '?   Vazio')
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object EdExpressao: TComboBox
          Left = 4
          Top = 112
          Width = 268
          Height = 21
          Hint = 
            'Informe o valor de atribuição'#13#10'Campo Data: Digite a data com bar' +
            'ras - Exemplo: 01/01/2002'#13#10'Campo Fracionário: Não digite '#39','#39' (Ví' +
            'rgula) para o valor decimal'
          ItemHeight = 13
          TabOrder = 1
        end
        object Composicao: TRadioGroup
          Left = 4
          Top = 136
          Width = 119
          Height = 33
          Hint = 
            'Composição lógica'#13#10'Exemplo I:'#13#10'Filtrar clientes como nome de '#39'JO' +
            'AO'#39' e da cidade de '#39'UBERABA'#39#13#10'(NOME = '#39'JOAO*'#39')'#13#10'AND (CIDADE = '#39'U' +
            'BERABA*'#39')'#13#10'Exemplo II:'#13#10'Filtrar clientes como nome de '#39'JOAO'#39' ou ' +
            #39'MARIA'#39#13#10'(NOME = '#39'JOAO*'#39')'#13#10'OR (NOME = '#39'MARIA*'#39')'
          Caption = ' Composição &Lógica '
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'e'
            'ou')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object EdNegacao: TCheckBox
          Left = 130
          Top = 146
          Width = 102
          Height = 17
          Caption = 'Negar Expressão'
          TabOrder = 3
        end
        object BtnInserir: TBitBtn
          Left = 63
          Top = 176
          Width = 75
          Height = 25
          Hint = 'Inserir expressão de filtro'
          Caption = 'Inserir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = BtnInserirClick
          Glyph.Data = {
            BE060000424DBE06000000000000360400002800000024000000120000000100
            0800000000008802000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C0007D654F00B199
            8300000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000D9CCC100A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
            0303030303030303030303030303030303030303030303030303030303030303
            03030303030303030303030303030303030303030303FF030303030303030303
            03030303030303040403030303030303030303030303030303F8F8FF03030303
            03030303030303030303040202040303030303030303030303030303F80303F8
            FF030303030303030303030303040202020204030303030303030303030303F8
            03030303F8FF0303030303030303030304020202020202040303030303030303
            0303F8030303030303F8FF030303030303030304020202FA0202020204030303
            0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
            040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
            03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
            FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
            0303030303030303030303FA0202020403030303030303030303030303F8FF03
            03F8FF03030303030303030303030303FA020202040303030303030303030303
            0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
            03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
            030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
            0202040303030303030303030303030303F8FF03F8FF03030303030303030303
            03030303FA0202030303030303030303030303030303F8FFF803030303030303
            030303030303030303FA0303030303030303030303030303030303F803030303
            0303030303030303030303030303030303030303030303030303030303030303
            0303}
          NumGlyphs = 2
        end
        object BtnLimpar: TBitBtn
          Left = 146
          Top = 176
          Width = 75
          Height = 25
          Hint = 'Limpar filtro'
          Caption = 'Limpar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = BtnLimparClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333338808833
            3333333338FF88333333333880F00883333333388F3FF883333333800FF0F088
            3333338FF33F3F883333300FFFF0FF0883333FF3333F33F8833330FFFFF0FFFC
            88333F33333F33FF883330FFFFF0FFFCC8833F33333F33F3F88330FFFF0F0FFC
            CC883F3333F3F3F33F8830FF00FFF0FCCCC83F33FF333FF333F83000FFFFFFCC
            CCC83FFF33333F3333F830FFFFFFFFCFCCC83F333333FF3F33F8330FFFFFCCCC
            FCC833F333FF3333F3F83330FFCCCCCCCFC8333F3F3333333FF83333CCCCCCCC
            CCC83333F333333333F833333CCCCCCCCCC333333F33333333F3333333CCCCCC
            CC33333333F33333FF333333333CCCCC33333333333FFFFF3333}
          NumGlyphs = 2
        end
      end
    end
  end
  object SynSQLSyn1: TSynSQLSyn
    DefaultFilter = 'SQL Files (*.sql)|*.sql'
    SQLDialect = sqlSybase
    Left = 352
    Top = 240
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
    Title = 'Funções Especiais'
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
    Left = 384
    Top = 240
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
    Title = 'Parâmetros'
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
    Left = 416
    Top = 240
  end
  object SynSQLSyn2: TSynSQLSyn
    DefaultFilter = 'SQL Files (*.sql)|*.sql'
    SQLDialect = sqlSybase
    Left = 352
    Top = 240
  end
  object SynCompletionProposal1: TSynCompletionProposal
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
    Title = 'Funções Especiais'
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
    Left = 384
    Top = 240
  end
  object SynCompletionProposal2: TSynCompletionProposal
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
    Title = 'Parâmetros'
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
    Left = 416
    Top = 240
  end
end
