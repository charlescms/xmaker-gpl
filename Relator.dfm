object FormRelatorio: TFormRelatorio
  Left = 228
  Top = 150
  HelpContext = 250
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Editor de Relatórios'
  ClientHeight = 430
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000010000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF00000000000
    00000000000000000F33F0000000000000FFFFFFFFFFFFFF0FFFF00000000000
    00FFFFFFFFFFFFFF0F33F0000000000000F0000F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F33F0000000000000F3333F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F33F0000000000000F3333F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F00F0000000000000F3333F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F00F0000000000000F0000F0000000F0FFFF00000000000
    00FFFFFFFFFFFFFF0F00F0000000000000F0000F0000000F0FFFF00000000000
    00FFFFFFFFFFFFFF0FFFF0000000000000FFFFFFFF00000F0000000000000000
    00FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF0000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0003FFFE0003FFFE0003FFE00
    003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00
    003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00007FFC0007FFFC00
    07FFFC000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 417
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      0000100000000100040000000000800000000000000000000000100000000000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF0022222222222222220000000000000002888888888888880287FFFFFFFFFF
      F80287FFFFFFFFFFF80287F8888F8888F80287FFFFFFFFFFF80287F8888F8888
      F80287FFFFFFFFFFF80287F8888F8888F80287FFFFFFFFFFF802878888888888
      8802874C4C4C4F0F080287777777777778028888888888888882222222222222
      2222}
    Visible = False
  end
  object Image2: TImage
    Left = 16
    Top = 417
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
    Left = 32
    Top = 417
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      0000100000000100040000000000800000000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00222222222222222222222222222222222222222222222222222222255555
      552222222229FFFFF52222222229999995222255555222222222229FFFF55555
      5522229F9999FFFFF522229FFFF999999522229F9999F5222222229FFFFFF522
      2222229DDDDD9522222222999999952222222222222222222222222222222222
      2222}
    Visible = False
  end
  object PageControl: TPageControl
    Left = 5
    Top = 0
    Width = 428
    Height = 394
    ActivePage = TabPrincipal
    HotTrack = True
    TabOrder = 0
    object TabPrincipal: TTabSheet
      HelpContext = 260
      Caption = 'Principal ( &1 ) '
      object Bevel1: TBevel
        Left = 6
        Top = 5
        Width = 408
        Height = 92
      end
      object Label1: TLabel
        Left = 16
        Top = 9
        Width = 28
        Height = 13
        Caption = 'Título'
      end
      object Label3: TLabel
        Left = 16
        Top = 49
        Width = 21
        Height = 13
        Caption = 'Tipo'
      end
      object Label4: TLabel
        Left = 111
        Top = 49
        Width = 48
        Height = 13
        Caption = 'Formulário'
      end
      object Label5: TLabel
        Left = 229
        Top = 49
        Width = 76
        Height = 13
        Caption = 'Tabela Principal'
      end
      object Ed_Titulo: TEdit
        Left = 16
        Top = 25
        Width = 387
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Ed_Tipo: TEdit
        Left = 16
        Top = 65
        Width = 91
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object Ed_Formulario: TEdit
        Left = 111
        Top = 65
        Width = 115
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object Ed_TabPrincipal: TEdit
        Left = 229
        Top = 65
        Width = 174
        Height = 21
        HelpContext = 260
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
      object DsnStage0: TDsnStage
        Left = 536
        Top = 38
        Width = 17
        Height = 19
        HelpContext = 220
        BorderStyle = bsNone
        ParentShowHint = False
        ShowHint = False
        TabOrder = 11
        Visible = False
        Rubberband.Color = clGray
        Rubberband.PenWidth = 2
        Rubberband.MoveWidth = 8
        Rubberband.MoveHeight = 8
        FixPosition = False
        FixSize = False
      end
      object TextoDFM: TSynEdit
        Left = 67
        Top = 405
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
        TabOrder = 12
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
      object PnTabelas: TPanel
        Tag = 1
        Left = 6
        Top = 99
        Width = 159
        Height = 19
        BevelOuter = bvLowered
        Caption = 'Tabelas'
        TabOrder = 13
      end
      object GridTabela: TCheckListBox
        Tag = 1
        Left = 6
        Top = 120
        Width = 159
        Height = 213
        OnClickCheck = GridTabelaClickCheck
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 4
        OnClick = GridTabelaClick
        OnDrawItem = GridTabelaDrawItem
      end
      object PnCampos: TPanel
        Tag = 2
        Left = 172
        Top = 99
        Width = 242
        Height = 19
        BevelOuter = bvLowered
        Caption = 'Campos'
        TabOrder = 14
      end
      object GridCampos: TListBox
        Tag = 2
        Left = 172
        Top = 120
        Width = 242
        Height = 213
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 6
        OnDrawItem = GridTabelaDrawItem
      end
      object BtnFiltro: TBitBtn
        Left = 87
        Top = 339
        Width = 78
        Height = 25
        Hint = 'Definir filtragem'
        HelpContext = 300
        Caption = 'Filtragem'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = BtnFiltroClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777707777777777777777007777777777777770777007007777777007770007
          0777777007707000777777700077007007777777007777777777777700777777
          7777777000007777777777777007777777777777700700777777777777000777
          7777777777777777777777777777777777777777777777777777}
      end
      object BtnOrdem: TBitBtn
        Left = 170
        Top = 339
        Width = 78
        Height = 25
        Hint = 'Definir ordenação'
        HelpContext = 300
        Caption = 'Ordenação'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = BtnOrdemClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888811111188888088881188818888707888811888888800088888118888870
          0078888811888800000881888118888808888111111888880888888888888888
          0888844484448888088887488847888808888844444888880888887484788888
          0888888444888888088888874788888808888888488888880888}
      end
      object BtnLayout: TBitBtn
        Left = 253
        Top = 339
        Width = 78
        Height = 25
        Hint = 'Editar layout'
        HelpContext = 300
        Caption = '&Layout'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = BtnLayoutClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777800000
          000077707787777777707707778FFFFFFF707707778FFFFFFF707000778FFFFF
          FF707707778FFFFFFF708000008FFFFFFF708F77778FFFFFFF708F77778FFFFF
          00008F77778FFFFF8F078F77778FFFFF80778F777788888887778FFFFFFFFF07
          7770800000000007707084444444440700078888888888077077}
      end
      object BtnFonte: TBitBtn
        Left = 336
        Top = 339
        Width = 78
        Height = 25
        Hint = 'Diálogo de impressão'
        HelpContext = 310
        Caption = 'Diálogo'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = BtnFonteClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777788888888888888800000000000000000777777777777770077777777777
          77700700770FFFFFFF7007000700000000700777777777777770077777777777
          77700700770FFF777770070077000077777007777777777777700CCCCCCCCCCC
          CCC00CCCCCCCCCCCCCC000000000000000007777777777777777}
      end
      object BitBtn1: TBitBtn
        Left = 5
        Top = 339
        Width = 75
        Height = 25
        Hint = 'Personalizar SQL'
        Caption = 'SQL'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BitBtn1Click
        Glyph.Data = {
          72010000424D7201000000000000760000002800000014000000150000000100
          040000000000FC00000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888800008880008888008088000800008888BBB8808BB8B80BBB00008888
          880B80B80B880B8800008880008B80B80B880B8800008808BBB880B80B880B88
          0000880B888880B80B880B880000888B008888B08B880B8800008888BBB8888B
          B0088B88000088888888888880AA8888000088888800888808A8888800008880
          808AA0008A8888880000888FA8A88AAAA8888888000088888A8888A800888888
          000088888880880A8AA08888000088888880A00AA88AA888000088888888AAAA
          A008888800008888888888808AAA88880000888888888880A80A888800008888
          88888888A08A88880000888888888888888888880000}
      end
    end
  end
  object BtnGravar: TBitBtn
    Left = 198
    Top = 399
    Width = 75
    Height = 25
    Hint = 'Gravar relatório'
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnGravarClick
  end
  object BtnFechar: TBitBtn
    Left = 278
    Top = 399
    Width = 75
    Height = 25
    Hint = 'Fechar definição'
    Caption = '&Fechar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BtnAjuda: TBitBtn
    Left = 358
    Top = 399
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnAjudaClick
    NumGlyphs = 2
  end
  object TextoPAS: TSynEdit
    Left = 3
    Top = 397
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
  object frReport_1: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 300
    Top = 208
    ReportForm = {
      17000000140500001700000000060050444639393500FF09000000340800009A
      0B000000000000000000000000000000000000000000FFFF0000000000000000
      02000000000000000026000000F1020000500000003000020001000000000000
      000000FFFFFF1F00000000090066724461746153657400000000000000FFFF02
      000000000000000096000000F10200001B00000030000E000100000000000000
      0000FFFFFF1F00000000090066724461746153657400000000000000FFFF0200
      00000000000000DD000000F10200001800000030000500010000000000000000
      00FFFFFF1F000000000B00667244424461746153657400000000000000FFFF02
      000000000000000076010000F102000016000000300001000100000000000000
      0000FFFFFF1F00000000090066724461746153657400000000000000FFFF0200
      00000000000000B7010000F10200001200000030000300010000000000000000
      00FFFFFF1F00000000090066724461746153657400000000000000FFFF000000
      00000F00000026000000D50200005000000003000F0001000000000000000000
      FFFFFF1F2C020000000000000000000000FFFF0500417269616C000A00000000
      0000000000020000000000020000000000FFFFFF000000000000000000100000
      002F00000078000000120000000300000001000000000000000000FFFFFF1F2C
      02000000000001000E005B446174655D2C205B54696D655D00000000FFFF0500
      417269616C000A000000000000000000020000000000020000000000FFFFFF00
      0000000000000000170200002F000000CC000000120000000300000001000000
      000000000000FFFFFF1F2C02000000000001000E0050E167696E61205B506167
      65235D00000000FFFF0500417269616C000A0000000000000000000100000000
      00020000000000FFFFFF0000000000000000000F00000047000000D502000012
      0000000300000001000000000000000000FFFFFF1F2C02000000000001002000
      3C20446967697465206F2054ED74756C6F20646F2052656C6174F372696F203E
      00000000FFFF0500417269616C000A0000000200000000000200000000000200
      00000000FFFFFF0000000000000000000F0000005E000000D502000012000000
      0300000001000000000000000000FFFFFF1F2C020000000000010020003C2044
      6967697465206F2054ED74756C6F20646F2052656C6174F372696F203E000000
      00FFFF0500417269616C000A0000000200000000000200000000000200000000
      00FFFFFF0000000000000000000F00000096000000D50200001900000003000F
      0001000000000000000000FFFFFF1F2C020000000000000000000000FFFF0500
      417269616C000A000000000000000000020000000000020000000000FFFFFF00
      00000000000000000F000000DD000000D5020000170000000300020001000000
      000000000000FFFFFF1F2C020000000000000000000000FFFF0500417269616C
      000A000000000000000000020000000000020000000000FFFFFF000000000000
      0000001300000076010000D50200001600000003000000010000000000000000
      00FFFFFF1F2C020000000000000000000000FFFF0500417269616C000A000000
      000000000000020000000000020000000000FFFFFF0000000000000000000F00
      0000B7010000D5020000120000000300080001000000000000000000FFFFFF1F
      2C020000000000000000000000FFFF0500417269616C000A0000000000000000
      00020000000000020000000000FFFFFF00000000FE00000000000000}
  end
  object frOLEObject1: TfrOLEObject
    Left = 267
    Top = 240
  end
  object frRichObject1: TfrRichObject
    Left = 267
    Top = 240
  end
  object frCheckBoxObject1: TfrCheckBoxObject
    Left = 267
    Top = 240
  end
  object frShapeObject1: TfrShapeObject
    Left = 267
    Top = 240
  end
  object frBarCodeObject1: TfrBarCodeObject
    Left = 267
    Top = 240
  end
  object frChartObject1: TfrChartObject
    Left = 266
    Top = 240
  end
  object frRoundRectObject1: TfrRoundRectObject
    Left = 268
    Top = 240
  end
  object frTextExport1: TfrTextExport
    Left = 268
    Top = 240
  end
  object frRTFExport1: TfrRTFExport
    Left = 268
    Top = 240
  end
  object frCSVExport1: TfrCSVExport
    Left = 268
    Top = 240
  end
  object frHTMExport1: TfrHTMExport
    Left = 268
    Top = 240
  end
  object frDesigner: TfrDesigner
    Left = 236
    Top = 208
  end
  object frReport_2: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 300
    Top = 208
    ReportForm = {
      170000004A0500001700000000060050444639393500FF09000000340800009A
      0B000000000000000000000000000000000000000000FFFF0000000000000000
      02000000000000000026000000F1020000500000003000020001000000000000
      000000FFFFFF1F00000000090066724461746153657400000000000000FFFF02
      00000000000000002C010000F1020000F8000000300005000100000000000000
      0000FFFFFF1F0000000001003100000000000000FFFF02000000000000000058
      020000F0020000120000003000030001000000000000000000FFFFFF1F000000
      00090066724461746153657400000000000000FFFF0200050042616E64310000
      00000096000000F10200001B00000030000E0001000000000000000000FFFFFF
      1F00000000090066724461746153657400000000000000FFFF0200050042616E
      64320000000000DD000000F10200001800000030000500010000000000000000
      00FFFFFF1F000000000B00667244424461746153657400000000000000FFFF00
      000000000F00000026000000D50200005000000003000F000100000000000000
      0000FFFFFF1F2C020000000000000000000000FFFF0500417269616C000A0000
      00000000000000020000000000020000000000FFFFFF00000000000000000010
      0000002F00000078000000120000000300000001000000000000000000FFFFFF
      1F2C02000000000001000E005B446174655D2C205B54696D655D00000000FFFF
      0500417269616C000A000000000000000000020000000000020000000000FFFF
      FF000000000000000000170200002F000000CC00000012000000030000000100
      0000000000000000FFFFFF1F2C02000000000001000E0050E167696E61205B50
      616765235D00000000FFFF0500417269616C000A000000000000000000010000
      000000020000000000FFFFFF0000000000000000000F00000047000000D50200
      00120000000300000001000000000000000000FFFFFF1F2C0200000000000100
      20003C20446967697465206F2054ED74756C6F20646F2052656C6174F372696F
      203E00000000FFFF0500417269616C000A000000020000000000020000000000
      020000000000FFFFFF0000000000000000000F0000005E000000D50200001200
      00000300000001000000000000000000FFFFFF1F2C020000000000010020003C
      20446967697465206F2054ED74756C6F20646F2052656C6174F372696F203E00
      000000FFFF0500417269616C000A000000020000000000020000000000020000
      000000FFFFFF0000000000000000000F00000058020000D50200001200000003
      00080001000000000000000000FFFFFF1F2C020000000000000000000000FFFF
      0500417269616C000A000000000000000000020000000000020000000000FFFF
      FF000000000A0C0054667243686172745669657700000600436861727431000F
      0000003401000070020000EA0000000180000001000000000000000000FFFFFF
      002C020000000000000000000000FFFF00050101010001010000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000005004D656D6F31000F00000096000000D5020000
      1900000003000F0001000000000000000000FFFFFF1F2C020000000000000000
      000000FFFF0500417269616C000A000000000000000000020000000000020000
      000000FFFFFF00000000000005004D656D6F32000F000000DD000000D5020000
      170000000300020001000000000000000000FFFFFF1F2C020000000000000000
      000000FFFF0500417269616C000A000000000000000000020000000000020000
      000000FFFFFF00000000FE00000000000000}
  end
  object frDBDataSet: TfrDBDataSet
    Left = 296
    Top = 208
  end
  object frReport_3: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 268
    Top = 208
    ReportForm = {
      17000000810000001700000000060050444639393500FF09000000340800009A
      0B000000000000000000000000000000000000000000FFFF0300000000000000
      02000000000000000096000000F1020000900000003000050001000000000000
      000000FFFFFF1F000000000B00667244424461746153657400000000000000FF
      FFFE00000000000000}
  end
end
