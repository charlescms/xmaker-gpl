object FormImpEstrutura: TFormImpEstrutura
  Left = 305
  Top = 179
  BorderStyle = bsDialog
  Caption = 'Importador de Estrutura'
  ClientHeight = 355
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 52
    Width = 105
    Height = 13
    Caption = 'Pasta de Localização:'
  end
  object Label2: TLabel
    Left = 8
    Top = 92
    Width = 44
    Height = 13
    Caption = 'Tabela(s)'
  end
  object Label3: TLabel
    Left = 168
    Top = 92
    Width = 44
    Height = 13
    Caption = 'Campo(s)'
  end
  object BtnExecutar: TSpeedButton
    Left = 433
    Top = 67
    Width = 23
    Height = 22
    Hint = 'Localizar estruturas'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888888888888888888888888888888888888888888888888888800288888
      8888888877F88888888888880A02888888888888787F8888888888880AA02888
      888888887F87F888888888880AAA0288888888887F887F88888888880AAAA028
      888888887F8887F8888888880AAAAA02888888887F88887F888888880AAAAAA0
      888888887F8888F7888888880AAAAA08888888887F888F78888888880AAAA088
      888888887F88F788888888880AAA0888888888887F8F7888888888880AA08888
      888888887FF78888888888880A088888888888887F7888888888888800888888
      8888888877888888888888888888888888888888888888888888}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnExecutarClick
  end
  object BtnLocaliza: TSpeedButton
    Left = 407
    Top = 67
    Width = 23
    Height = 22
    Hint = 'Localizar pasta de destino'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777777777777777777700000777770000070F000777770F00070F000777770
      F0007000000070000000700F000000F00000700F000700F00000700F000700F0
      000077000000000000077770F00070F000777770000070000077777700077700
      077777770F07770F077777770007770007777777777777777777}
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnLocalizaClick
  end
  object Label4: TLabel
    Left = 246
    Top = 52
    Width = 47
    Height = 13
    Caption = 'DataBase'
    Visible = False
  end
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Banco de Dados'
  end
  object Image1: TImage
    Left = 272
    Top = 331
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
  object LstCampos: TStringGrid
    Left = 168
    Top = 108
    Width = 289
    Height = 209
    ColCount = 4
    DefaultRowHeight = 16
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 4
    ColWidths = (
      104
      70
      49
      41)
  end
  object BtnImportar: TBitBtn
    Left = 300
    Top = 325
    Width = 75
    Height = 25
    Caption = '&Importar'
    ModalResult = 1
    TabOrder = 5
    OnClick = BtnImportarClick
  end
  object BtnCancelar: TBitBtn
    Left = 382
    Top = 325
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 6
  end
  object Texto: TSynEdit
    Left = 192
    Top = 237
    Width = 81
    Height = 60
    Cursor = crIBeam
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 7
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
      'Texto')
  end
  object LstTabelas_2: TFileListBox
    Left = 272
    Top = 204
    Width = 65
    Height = 69
    ItemHeight = 13
    Mask = '*.dbf'
    TabOrder = 8
    Visible = False
  end
  object LstTabelas: TCheckListBox
    Left = 8
    Top = 108
    Width = 155
    Height = 209
    ItemHeight = 16
    PopupMenu = PopupMenu1
    Style = lbOwnerDrawFixed
    TabOrder = 3
    OnClick = LstTabelasClick
    OnDrawItem = LstTabelasDrawItem
  end
  object EdLocalizacao: TEdit
    Left = 7
    Top = 67
    Width = 232
    Height = 21
    TabOrder = 1
  end
  object EdBaseName: TEdit
    Left = 243
    Top = 67
    Width = 161
    Height = 21
    TabOrder = 2
    Visible = False
  end
  object BaseDados: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnClick = BaseDadosClick
    Items.Strings = (
      'X-Maker 3.0/4.0/5.0'
      'dBase'
      'Paradox'
      'Interbase'
      'Firebird'
      'SQLBase'
      'Oracle'
      'SQLServer'
      'Sybase'
      'DB2'
      'Informix'
      'ODBC'
      'MySQL'
      'PostgreSQL'
      'OLEDB')
  end
  object Table: TTable
    Left = 8
    Top = 322
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
    Top = 324
  end
  object IBTransaction: TIBTransaction
    Active = False
    AutoStopAction = saNone
    Left = 104
    Top = 325
  end
  object IBQuery: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 142
    Top = 325
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 38
    Top = 325
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 16
    object Marcartodas1: TMenuItem
      Caption = 'Marcar todas'
      OnClick = Marcartodas1Click
    end
    object Desmarcartodas1: TMenuItem
      Caption = 'Desmarcar todas'
      OnClick = Desmarcartodas1Click
    end
  end
  object IBQuery2: TIBQuery
    Database = IBDatabase
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 38
    Top = 293
  end
  object SDDatabase: TSDDatabase
    LoginPrompt = False
    DatabaseName = 'DB_importacao'
    IdleTimeOut = 0
    SessionName = 'Default'
    Left = 40
    Top = 176
  end
  object SDQuery: TSDQuery
    DatabaseName = 'db_importacao'
    Left = 48
    Top = 216
  end
  object OpenDialog: TOpenDialog
    Filter = 'Interbase/Firebird|*.gdb;*.fdb|Todos os arquivos|*.*'
    Left = 352
    Top = 24
  end
end
