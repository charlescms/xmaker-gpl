object FormConfiguraEmpresa: TFormConfiguraEmpresa
  Left = 233
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dados da Empresa Usuária'
  ClientHeight = 468
  ClientWidth = 534
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 428
    Align = alClient
    TabOrder = 0
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 517
      Height = 152
    end
    object lblBanco: TLabel
      Left = 8
      Top = 162
      Width = 80
      Height = 13
      Caption = '&Banco de Dados'
      FocusControl = lbBancos
    end
    object lblTableas: TLabel
      Left = 272
      Top = 162
      Width = 136
      Height = 13
      Caption = '&Tabelas do Banco de Dados'
      FocusControl = lbTabelas
    end
    object lblServer: TLabel
      Left = 8
      Top = 341
      Width = 119
      Height = 13
      Caption = '&Localização ( DataBase )'
      FocusControl = EdLocalizacao
    end
    object Label1: TLabel
      Left = 14
      Top = 18
      Width = 52
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Empresa'
    end
    object Label2: TLabel
      Left = 14
      Top = 42
      Width = 52
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Endereço'
    end
    object Label3: TLabel
      Left = 14
      Top = 66
      Width = 52
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Bairro'
    end
    object Label4: TLabel
      Left = 14
      Top = 90
      Width = 52
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cidade'
    end
    object Label5: TLabel
      Left = 204
      Top = 90
      Width = 22
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'UF'
    end
    object Label6: TLabel
      Left = 261
      Top = 90
      Width = 23
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CEP'
    end
    object Label7: TLabel
      Left = 14
      Top = 114
      Width = 52
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'CNPJ'
    end
    object Label8: TLabel
      Left = 204
      Top = 114
      Width = 22
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'I.E.'
    end
    object Label9: TLabel
      Left = 14
      Top = 138
      Width = 52
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Fone(s)'
    end
    object Image1: TImage
      Left = 272
      Top = 322
      Width = 18
      Height = 17
      AutoSize = True
      Center = True
      Picture.Data = {
        07544269746D61708A050000424D8A0500000000000036040000280000001200
        0000110000000100080000000000540100000000000000000000000100000001
        0000000000004000000080000000FF000000002000004020000080200000FF20
        0000004000004040000080400000FF400000006000004060000080600000FF60
        0000008000004080000080800000FF80000000A0000040A0000080A00000FFA0
        000000C0000040C0000080C00000FFC0000000FF000040FF000080FF0000FFFF
        0000000020004000200080002000FF002000002020004020200080202000FF20
        2000004020004040200080402000FF402000006020004060200080602000FF60
        2000008020004080200080802000FF80200000A0200040A0200080A02000FFA0
        200000C0200040C0200080C02000FFC0200000FF200040FF200080FF2000FFFF
        2000000040004000400080004000FF004000002040004020400080204000FF20
        4000004040004040400080404000FF404000006040004060400080604000FF60
        4000008040004080400080804000FF80400000A0400040A0400080A04000FFA0
        400000C0400040C0400080C04000FFC0400000FF400040FF400080FF4000FFFF
        4000000060004000600080006000FF006000002060004020600080206000FF20
        6000004060004040600080406000FF406000006060004060600080606000FF60
        6000008060004080600080806000FF80600000A0600040A0600080A06000FFA0
        600000C0600040C0600080C06000FFC0600000FF600040FF600080FF6000FFFF
        6000000080004000800080008000FF008000002080004020800080208000FF20
        8000004080004040800080408000FF408000006080004060800080608000FF60
        8000008080004080800080808000FF80800000A0800040A0800080A08000FFA0
        800000C0800040C0800080C08000FFC0800000FF800040FF800080FF8000FFFF
        80000000A0004000A0008000A000FF00A0000020A0004020A0008020A000FF20
        A0000040A0004040A0008040A000FF40A0000060A0004060A0008060A000FF60
        A0000080A0004080A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0
        A00000C0A00040C0A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFF
        A0000000C0004000C0008000C000FF00C0000020C0004020C0008020C000FF20
        C0000040C0004040C0008040C000FF40C0000060C0004060C0008060C000FF60
        C0000080C0004080C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0
        C00000C0C00040C0C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFF
        C0000000FF004000FF008000FF00FF00FF000020FF004020FF008020FF00FF20
        FF000040FF004040FF008040FF00FF40FF000060FF004060FF008060FF00FF60
        FF000080FF004080FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0
        FF0000C0FF0040C0FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
        0808080808FFFFFF0000FFFFFFFFFFFFFFFFFF0808FF08080808FFFF0000FFFF
        000000000000080808FF0808080808FF0000FFFF00FFFFFF00FF0808FF08FF08
        080808FF0000FFFF00FFFFFF00FF0808FF08FF08080808FF0000FFFF00FFFFFF
        00FF08FF080808FF080808FF0000FFFF00FFFFFF00FF0808080808FF080808FF
        0000FFFF00FFFFFF00FFFF0808080808FF08FFFF0000FFFF00FFFFFF00FF0000
        080808080800FFFF0000FFFF00FFFFFF00FFFFFFFFFF00FFFF00FFFF0000FFFF
        0000000000000000000000000000FFFF0000FFFF001F031F031F031F031F031F
        0300FFFF0000FFFF00031F031F031F031F031F031F00FFFF0000FFFF00000000
        00000000000000000000FFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
    end
    object Image2: TImage
      Left = 401
      Top = 322
      Width = 19
      Height = 18
      AutoSize = True
      Center = True
      Picture.Data = {
        07544269746D61709E050000424D9E0500000000000036040000280000001300
        0000120000000100080000000000680100000000000000000000000100000001
        0000000000004000000080000000FF000000002000004020000080200000FF20
        0000004000004040000080400000FF400000006000004060000080600000FF60
        0000008000004080000080800000FF80000000A0000040A0000080A00000FFA0
        000000C0000040C0000080C00000FFC0000000FF000040FF000080FF0000FFFF
        0000000020004000200080002000FF002000002020004020200080202000FF20
        2000004020004040200080402000FF402000006020004060200080602000FF60
        2000008020004080200080802000FF80200000A0200040A0200080A02000FFA0
        200000C0200040C0200080C02000FFC0200000FF200040FF200080FF2000FFFF
        2000000040004000400080004000FF004000002040004020400080204000FF20
        4000004040004040400080404000FF404000006040004060400080604000FF60
        4000008040004080400080804000FF80400000A0400040A0400080A04000FFA0
        400000C0400040C0400080C04000FFC0400000FF400040FF400080FF4000FFFF
        4000000060004000600080006000FF006000002060004020600080206000FF20
        6000004060004040600080406000FF406000006060004060600080606000FF60
        6000008060004080600080806000FF80600000A0600040A0600080A06000FFA0
        600000C0600040C0600080C06000FFC0600000FF600040FF600080FF6000FFFF
        6000000080004000800080008000FF008000002080004020800080208000FF20
        8000004080004040800080408000FF408000006080004060800080608000FF60
        8000008080004080800080808000FF80800000A0800040A0800080A08000FFA0
        800000C0800040C0800080C08000FFC0800000FF800040FF800080FF8000FFFF
        80000000A0004000A0008000A000FF00A0000020A0004020A0008020A000FF20
        A0000040A0004040A0008040A000FF40A0000060A0004060A0008060A000FF60
        A0000080A0004080A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0
        A00000C0A00040C0A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFF
        A0000000C0004000C0008000C000FF00C0000020C0004020C0008020C000FF20
        C0000040C0004040C0008040C000FF40C0000060C0004060C0008060C000FF60
        C0000080C0004080C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0
        C00000C0C00040C0C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFF
        C0000000FF004000FF008000FF00FF00FF000020FF004020FF008020FF00FF20
        FF000040FF004040FF008040FF00FF40FF000060FF004060FF008060FF00FF60
        FF000080FF004080FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0
        FF0000C0FF0040C0FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFE0E0E0E0FFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFE0E0E0E0E0E0FFFFFF00FFFF00000000000000E0E0FFE0E0
        FFE0E0FFFF00FFFF00FFFFFF00FFFFE0E0E0FFFFE0E0E0FFFF00FFFF00FFFFFF
        00FF00E0E0E0FFFFE0E0E0FFFF00FFFF00FFFFFF00FFFFE0E0FFE0E0FFE0E0FF
        FF00FFFF00FFFFFF00FF0000E0E0E0E0E0E0FFFFFF00FFFF00FFFFFF00FFFFFF
        FFE0E0E0E000FFFFFF00FFFF00FFFFFF00FF000000FF00FFFF00FFFFFF00FFFF
        00FFFFFF00FFFFFFFFFF00FFFF00FFFFFF00FFFF000000000000000000000000
        0000FFFFFF00FFFF001F031F031F031F031F031F0300FFFFFF00FFFF00031F03
        1F031F031F031F031F00FFFFFF00FFFF0000000000000000000000000000FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00}
    end
    object Label10: TLabel
      Left = 292
      Top = 324
      Width = 83
      Height = 13
      Caption = 'Tabela localizada'
    end
    object Label11: TLabel
      Left = 422
      Top = 324
      Width = 104
      Height = 13
      Caption = 'Tabela não localizada'
    end
    object Label12: TLabel
      Left = 383
      Top = 18
      Width = 23
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Nº'
    end
    object Bevel2: TBevel
      Left = 368
      Top = 41
      Width = 117
      Height = 91
    end
    object ImagemLogo: TImage
      Left = 371
      Top = 44
      Width = 110
      Height = 84
      Center = True
      Stretch = True
      Transparent = True
    end
    object Label13: TLabel
      Left = 272
      Top = 341
      Width = 104
      Height = 13
      Caption = '&Servidor ( HostName )'
      FocusControl = EdServidor
    end
    object Label14: TLabel
      Left = 8
      Top = 385
      Width = 80
      Height = 13
      Caption = 'Banco de& Dados'
      FocusControl = EdBancoDados
    end
    object Label15: TLabel
      Left = 272
      Top = 385
      Width = 80
      Height = 13
      Caption = 'Nome de &usuário'
      FocusControl = EdUsuario
    end
    object Label16: TLabel
      Left = 408
      Top = 385
      Width = 83
      Height = 13
      Caption = 'Se&nha de acesso'
      FocusControl = EdSenha
    end
    object LbVersao: TLabel
      Left = 8
      Top = 324
      Width = 256
      Height = 13
      AutoSize = False
      Caption = 'LbVersao'
      ParentShowHint = False
      ShowHint = True
    end
    object lbBancos: TListBox
      Left = 8
      Top = 178
      Width = 256
      Height = 142
      ItemHeight = 17
      Style = lbOwnerDrawFixed
      TabOrder = 12
      OnClick = lbBancosClick
      OnDrawItem = lbTabelasDrawItem
    end
    object lbTabelas: TListBox
      Left = 272
      Top = 178
      Width = 254
      Height = 142
      ItemHeight = 17
      MultiSelect = True
      PopupMenu = PopupMenu1
      Style = lbOwnerDrawFixed
      TabOrder = 13
      OnDrawItem = lbTabelasDrawItem
    end
    object EdLocalizacao: TEdit
      Left = 8
      Top = 358
      Width = 225
      Height = 21
      AutoSize = False
      TabOrder = 14
      OnChange = EdLocalizacaoChange
    end
    object BtnLocalizar: TBitBtn
      Left = 238
      Top = 357
      Width = 26
      Height = 23
      Hint = 'Localiza banco de dados'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      OnClick = BtnLocalizarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333330000000000033333FFFFFFFFFFF33333003333333330
        3333FF333333333F33330B03333333330333FBF333333333F3330FB033333333
        3033F7BF333333333F330BFB033333333303FB7BF333333333F30FBFB0000000
        0003F7B7BFFFFFFFFFF30BFBFBFBFB033333FB7B7B7B7BF333330FBFBFBFBF03
        3333F7B7B7B7B7F333330BFB000000033333FB7BFFFFFFF33333300033333333
        00033FFF33333333FFF333333333333330033333333333333FF3333333330333
        030333333333F333F3F33333333330003333333333333FFF3333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object EdEmpresa: TEdit
      Left = 68
      Top = 14
      Width = 285
      Height = 21
      MaxLength = 50
      TabOrder = 0
      OnChange = EdEmpresaChange
    end
    object EdEndereco: TEdit
      Left = 68
      Top = 38
      Width = 285
      Height = 21
      MaxLength = 50
      TabOrder = 2
      OnChange = EdEmpresaChange
    end
    object EdBairro: TEdit
      Left = 68
      Top = 62
      Width = 133
      Height = 21
      MaxLength = 30
      TabOrder = 3
      OnChange = EdEmpresaChange
    end
    object EdCidade: TEdit
      Left = 68
      Top = 86
      Width = 133
      Height = 21
      MaxLength = 30
      TabOrder = 4
      OnChange = EdEmpresaChange
    end
    object EdUF: TEdit
      Left = 228
      Top = 86
      Width = 32
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 5
      OnChange = EdEmpresaChange
    end
    object EdCEP: TEdit
      Left = 287
      Top = 86
      Width = 66
      Height = 21
      MaxLength = 9
      TabOrder = 6
      OnChange = EdEmpresaChange
    end
    object EdCNPJ: TEdit
      Left = 68
      Top = 110
      Width = 133
      Height = 21
      MaxLength = 20
      TabOrder = 7
      OnChange = EdEmpresaChange
    end
    object EdInscricao: TEdit
      Left = 228
      Top = 110
      Width = 125
      Height = 21
      MaxLength = 20
      TabOrder = 8
      OnChange = EdEmpresaChange
    end
    object EdFones: TEdit
      Left = 68
      Top = 134
      Width = 285
      Height = 21
      MaxLength = 40
      TabOrder = 9
      OnChange = EdEmpresaChange
    end
    object EdNumero: TEdit
      Left = 409
      Top = 14
      Width = 34
      Height = 21
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object EdImagem: TEdit
      Left = 367
      Top = 134
      Width = 118
      Height = 21
      Hint = 'Localização do arquivo de imagem'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnChange = EdEmpresaChange
      OnExit = EdImagemExit
    end
    object BtnImagem: TBitBtn
      Left = 488
      Top = 133
      Width = 26
      Height = 23
      Hint = 'Localizar imagem'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = BtnImagemClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333330000000000033333FFFFFFFFFFF33333003333333330
        3333FF333333333F33330B03333333330333FBF333333333F3330FB033333333
        3033F7BF333333333F330BFB033333333303FB7BF333333333F30FBFB0000000
        0003F7B7BFFFFFFFFFF30BFBFBFBFB033333FB7B7B7B7BF333330FBFBFBFBF03
        3333F7B7B7B7B7F333330BFB000000033333FB7BFFFFFFF33333300033333333
        00033FFF33333333FFF333333333333330033333333333333FF3333333330333
        030333333333F333F3F33333333330003333333333333FFF3333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object EdServidor: TEdit
      Left = 272
      Top = 357
      Width = 252
      Height = 21
      AutoSize = False
      TabOrder = 16
      OnChange = EdLocalizacaoChange
    end
    object EdBancoDados: TComboBox
      Left = 8
      Top = 400
      Width = 124
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 17
      OnChange = EdLocalizacaoChange
      Items.Strings = (
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
    object EdUsuario: TEdit
      Left = 273
      Top = 400
      Width = 131
      Height = 21
      TabOrder = 18
      OnChange = EdLocalizacaoChange
    end
    object EdSenha: TEdit
      Left = 409
      Top = 400
      Width = 114
      Height = 21
      PasswordChar = '*'
      TabOrder = 19
      OnChange = EdLocalizacaoChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 428
    Width = 534
    Height = 40
    Align = alBottom
    TabOrder = 1
    object BtnCancela: TBitBtn
      Left = 363
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Cancelar operação'
      Cancel = True
      Caption = '&Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      NumGlyphs = 2
    end
    object BtnOk: TBitBtn
      Left = 276
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Aplicar configurações e finalizar'
      Caption = '&Ok'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnOkClick
      NumGlyphs = 2
    end
    object BtnAplicar: TBitBtn
      Left = 450
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Aplicar configurações'
      Caption = '&Aplicar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BtnAplicarClick
      NumGlyphs = 2
    end
    object BtnIndexar: TBitBtn
      Left = 189
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Indexa tabela(s) selecionada(s)'
      Caption = '&Indexar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BtnIndexarClick
      NumGlyphs = 2
    end
    object BtnAutoI: TBitBtn
      Left = 101
      Top = 7
      Width = 75
      Height = 25
      Hint = 'Atualizar Autoincremento da(s) tabela(s) selecionada(s)'
      Caption = '&Autoincrem.'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = BtnAutoIClick
      NumGlyphs = 2
    end
  end
  object dlgOpen: TOpenDialog
    Left = 11
    Top = 429
  end
  object OpenPictureImagem: TOpenPictureDialog
    Filter = 'Imagens (*.bmp; *.jpg; *.ico)|*.bmp;*.jpg;*.ico'
    Left = 43
    Top = 430
  end
  object PopupMenu1: TPopupMenu
    Left = 72
    Top = 432
    object SelecionarTudo1: TMenuItem
      Caption = 'Selecionar Tudo'
      OnClick = SelecionarTudo1Click
    end
  end
end
