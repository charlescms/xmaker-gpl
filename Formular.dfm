object FormFormularios: TFormFormularios
  Left = 386
  Top = 171
  HelpContext = 200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Definição de Formulários'
  ClientHeight = 457
  ClientWidth = 366
  Color = clBtnFace
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
    0000000000000888888888888888000000000000000007777777777777700777
    7777777777700700770FFFFFFF70070007000000007007777777777777700777
    7777777777700700770FFF777770070077000077777007777777777777700CCC
    CCCCCCCCCCC00CCCCCCCCCCCCCC000000000000000000000000000000000FFFF
    2C05800000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000FFFF0000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object XBanner: TXBanner
    Left = 0
    Top = 0
    Width = 24
    Height = 423
    Align = alLeft
    Alignment = AtaLeftJustify
    Angle = 90
    Caption = 'Definição de Formulários'
    Color = 4806236
    ColorOf = clWindow
    ColorFor = clHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Horizontal = True
    ParentColor = False
    ParentFont = False
    ShadeLTSet = False
    Style3D = A3dNormal
  end
  object Panel1: TPanel
    Left = 0
    Top = 423
    Width = 366
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object XBanner1: TXBanner
      Left = 0
      Top = 0
      Width = 24
      Height = 34
      Align = alLeft
      Alignment = AtaLeftJustify
      Angle = 90
      Caption = ' >>>'
      Color = 4806236
      ColorOf = clHighlight
      ColorFor = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Horizontal = True
      ParentColor = False
      ParentFont = False
      ShadeLTSet = False
      Style3D = A3dNormal
    end
    object BtnFechar: TBitBtn
      Left = 204
      Top = 2
      Width = 75
      Height = 25
      HelpContext = 200
      Caption = '&Fechar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BthAjudaTabela: TBitBtn
      Left = 287
      Top = 2
      Width = 75
      Height = 25
      HelpContext = 200
      Caption = '&Ajuda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BthAjudaTabelaClick
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 24
    Top = 0
    Width = 342
    Height = 423
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 5
      Top = 5
      Width = 332
      Height = 413
      ActivePage = TabSheet1
      Anchors = [akLeft, akTop, akRight, akBottom]
      HotTrack = True
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Formulários'
        object Bevel2: TBevel
          Left = 4
          Top = 147
          Width = 316
          Height = 233
        end
        object Bevel1: TBevel
          Left = 4
          Top = 2
          Width = 316
          Height = 145
        end
        object Label1: TLabel
          Left = 11
          Top = 40
          Width = 37
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Tipo'
        end
        object Label2: TLabel
          Left = 11
          Top = 14
          Width = 37
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Nome'
        end
        object Label3: TLabel
          Left = 11
          Top = 67
          Width = 37
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Títu&lo'
        end
        object LbTabela: TLabel
          Left = 11
          Top = 95
          Width = 37
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Tab&ela'
        end
        object LbForm: TLabel
          Left = 173
          Top = 14
          Width = 28
          Height = 13
          Caption = 'Form'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object BtnNovo: TSpeedButton
          Left = 288
          Top = 156
          Width = 25
          Height = 22
          Hint = 'Novo'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF00000000000000FF0FFFFFFFF00FF0FF0FFFFFFFF08
            0F0FF0F0F0F07F0F800FF0FFFFF00700000FF0FFFFF0B07FFF0FF0FFFFF0B07F
            FF0FF0FFFFF0BB07FF0FF0FFFFF0BB07FF0FF00000000BB0000FFFFFFFFF0BB0
            7FFFFFFFFFFFF00007FFFFFFFFFFF0990FFFFFFFFFFFFF00FFFF}
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnNovoClick
        end
        object BtnExcluir: TSpeedButton
          Left = 288
          Top = 178
          Width = 25
          Height = 22
          Hint = 'Excluir'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF00000000000000FF0FFFFFFFF00FF0FF0FFFFFFFF0
            80F0F10FFFFFFFF0F800F91FFFF71FF00000FF97FF719FFFFFF0FF917F19FFFF
            FFF0FFF9119FFFFFFFF0FF7919FFFFFFFFF0F799917000000000F99FF917FFFF
            FFFFFFFFFF917FFFFFFFFFFFFFF917FFFFFFFFFFFFFFFFFFFFFF}
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnExcluirClick
        end
        object BtnEditar: TSpeedButton
          Left = 288
          Top = 214
          Width = 25
          Height = 22
          Hint = 'Editar'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
            000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
            00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
            F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
            0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
            FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
            FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
            0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
            00333377737FFFFF773333303300000003333337337777777333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnEditarClick
        end
        object BtnDefinir: TSpeedButton
          Left = 288
          Top = 236
          Width = 25
          Height = 22
          Hint = 'Layout'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777800000
            000077707787777777707707778FFFFFFF707707778FFFFFFF707000778FFFFF
            FF707707778FFFFFFF708000008FFFFFFF708F77778FFFFFFF708F77778FFFFF
            00008F77778FFFFF8F078F77778FFFFF80778F777788888887778FFFFFFFFF07
            7770800000000007707084444444440700078888888888077077}
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnDefinirClick
        end
        object Label4: TLabel
          Left = 12
          Top = 340
          Width = 42
          Height = 13
          Caption = 'Localizar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object BtnImportar: TSpeedButton
          Left = 288
          Top = 258
          Width = 25
          Height = 22
          Hint = 'Importar'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888800000
            088888888880FFFF088888888880F88F088888800000FFFF08888880FFF44444
            48888880F884444448888880FFFF088888888884444448888888888444444888
            8888888888888888888888888880888888888888880008888888888880000088
            8888888800000008888888877777777788888888888888888888}
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnImportarClick
        end
        object Label5: TLabel
          Left = 11
          Top = 120
          Width = 37
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Modelo'
        end
        object BtnCancelar: TBitBtn
          Left = 288
          Top = 316
          Width = 25
          Height = 22
          Hint = 'Cancelar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = BtnCancelarClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888778888888
            8888888888888888888888911788888978888888888888888888889111788891
            1788888888888888888888911117891111788888888888888888888911117111
            1178888888888888888888889111111117888888888888888888888889111111
            7888888888888888888888888811111788888888888888888888888888911117
            8888888888888888888888888911111788888888888888888888888891117111
            7888888888888888888888891117891117888888888888888888888911788891
            1178888888888888888888889188888911188888888888888888888888888888
            9198888888888888888888888888888888888888888888888888}
          NumGlyphs = 2
        end
        object EdNome: TDBEdit
          Left = 54
          Top = 10
          Width = 116
          Height = 21
          HelpContext = 200
          DataField = 'nome'
          DataSource = DataSource
          Enabled = False
          MaxLength = 15
          TabOrder = 0
          OnChange = EdNomeChange
          OnExit = EdNomeExit
        end
        object ComboTipo: TDBComboBox
          Left = 54
          Top = 36
          Width = 145
          Height = 22
          HelpContext = 200
          Style = csOwnerDrawFixed
          DataField = 'tipo'
          DataSource = DataSource
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7')
          ParentFont = False
          TabOrder = 1
          OnDrawItem = ComboTipoDrawItem
          OnExit = ComboTipoExit
        end
        object EdTitulo: TDBEdit
          Left = 54
          Top = 63
          Width = 255
          Height = 21
          HelpContext = 200
          DataField = 'titulo_f'
          DataSource = DataSource
          Enabled = False
          TabOrder = 2
          OnExit = EdTituloExit
        end
        object ComboTabela: TXDBLookUp
          Left = 54
          Top = 91
          Width = 257
          Height = 21
          HelpContext = 200
          DataField = 'tabela'
          DataSource = DataSource
          DropDownRows = 14
          Enabled = False
          TabOrder = 3
        end
        object GridForm: TDBGrid
          Left = 12
          Top = 156
          Width = 271
          Height = 182
          HelpContext = 200
          DataSource = DataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          OnDblClick = BtnDefinirClick
          OnKeyDown = GridFormKeyDown
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'titulo_f'
              Visible = True
            end>
        end
        object BtnConfirma: TBitBtn
          Left = 288
          Top = 294
          Width = 25
          Height = 22
          Hint = 'Salvar'
          HelpContext = 200
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = BtnConfirmaClick
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888880000000000000880330000008803088033000000880308803300000088
            0308803300000000030880333333333333088033000000003308803088888888
            0308803088888888030880308888888803088030888888880308803088888888
            0008803088888888080880000000000000088888888888888888}
        end
        object EdLocalizar: TEdit
          Left = 12
          Top = 354
          Width = 271
          Height = 21
          HelpContext = 200
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnChange = EdLocalizarChange
        end
        object EdModelo: TDBComboBox
          Left = 54
          Top = 116
          Width = 257
          Height = 21
          HelpContext = 200
          Style = csSimple
          DataField = 'modelo'
          DataSource = DataSource
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 4
          OnExit = EdModeloExit
        end
        object FileListBox1: TFileListBox
          Left = 139
          Top = 192
          Width = 81
          Height = 105
          ItemHeight = 13
          Mask = '*.pas'
          TabOrder = 9
          Visible = False
        end
        object Texto_PAS: TSynEdit
          Left = 32
          Top = 192
          Width = 81
          Height = 57
          Cursor = crIBeam
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 10
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
            'Texto_PAS')
        end
      end
    end
  end
  object DataSource: TDataSource
    Left = 288
    Top = 8
  end
  object IBDatabase: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 72
    Top = 396
  end
  object IBTransaction: TIBTransaction
    Active = False
    AutoStopAction = saNone
    Left = 104
    Top = 397
  end
end
