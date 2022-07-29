object FormCampos: TFormCampos
  Left = 187
  Top = 97
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Definição de Tabelas e Atributos'
  ClientHeight = 437
  ClientWidth = 541
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
    000000000000000000000000000000000F7F7F7F7F70000007F7F70000F00B00
    0F7F7F0FF07008B00700070000F008FB007F7F7F7F70008FB007F70000F00000
    FB007F0FF0708FBBBBB0070000F008FB007F7F7F7F70008FB00444444444008F
    BB00444444440008FBB000000000000080BB000000000000000000000000FFFF
    C804F0000000F000F7BD9000FFFF8000F7BD8000000080000000C00000000000
    00000000FFFF80000000C000F7BDC000EF7BE07FFFFFF43FE0FFFFFF0000}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PagePrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 541
    Height = 437
    Cursor = crDefault
    ActivePage = TabAcesso
    Align = alClient
    HotTrack = True
    TabOrder = 0
    OnChange = PagePrincipalChange
    object TabAcesso: TTabSheet
      Caption = '&1. Tabelas'
      object Bevel1: TBevel
        Left = 24
        Top = 16
        Width = 481
        Height = 353
      end
      object ListaTabelas: TListBox
        Left = 32
        Top = 24
        Width = 465
        Height = 337
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        Style = lbOwnerDrawVariable
        TabOrder = 0
        OnClick = ListaTabelasClick
        OnDblClick = ListaTabelasDblClick
        OnDrawItem = ListaTabelasDrawItem
        OnMeasureItem = ListaTabelasMeasureItem
      end
      object BtnNova: TBitBtn
        Left = 104
        Top = 379
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Criar nova tabela'
        Caption = '&Nova'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnNovaClick
      end
      object BtnImportarTabela: TBitBtn
        Left = 186
        Top = 379
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Importar tabela definida em outro projeto'
        Caption = 'Im&portar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BtnImportarTabelaClick
        NumGlyphs = 2
      end
      object BtnFechar: TBitBtn
        Left = 350
        Top = 379
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Fechar definição'
        Caption = '&Fechar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BtnFecharClick
        NumGlyphs = 2
      end
      object BthAjudaTabela: TBitBtn
        Left = 430
        Top = 379
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Ajuda'
        Caption = '&Ajuda'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object BtnExcluir: TBitBtn
        Left = 268
        Top = 379
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Excluir tabela'
        Caption = 'E&xcluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BtnExcluirClick
        NumGlyphs = 2
      end
      object BtnGravar: TBitBtn
        Left = 22
        Top = 379
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Gravar definições das tabelas'
        Caption = '&Gravar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = BtnGravarClick
      end
    end
    object TabEdicao: TTabSheet
      Caption = '&2. Campos'
      ImageIndex = 1
      object Bevel2: TBevel
        Left = 8
        Top = 8
        Width = 521
        Height = 393
      end
      object Label2: TLabel
        Left = 70
        Top = 21
        Width = 28
        Height = 13
        Caption = 'Nome'
      end
      object Label3: TLabel
        Left = 70
        Top = 44
        Width = 28
        Height = 13
        Caption = 'Título'
      end
      object Label4: TLabel
        Left = 20
        Top = 69
        Width = 80
        Height = 13
        Caption = 'Banco de Dados'
      end
      object EdNome: TEdit
        Left = 104
        Top = 16
        Width = 65
        Height = 21
        Hint = 'Informe o nome da tabela '
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 8
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnExit = EdNomeExit
        OnKeyPress = EdNumeroKeyPress
      end
      object EdTitulo: TEdit
        Left = 104
        Top = 40
        Width = 225
        Height = 21
        Hint = 'Informe o título da tabela'
        Enabled = False
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnExit = EdTituloExit
        OnKeyPress = EdNumeroKeyPress
      end
      object EdBanco: TComboBox
        Left = 104
        Top = 64
        Width = 225
        Height = 21
        Hint = 'Informe o banco de dados a ser utilizado'
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnExit = EdBancoExit
        OnKeyPress = EdNumeroKeyPress
      end
      object EdChave: TCheckBox
        Left = 240
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Chave Primária'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnExit = EdChaveExit
        OnKeyPress = EdNumeroKeyPress
      end
      object GrupoCampos: TGroupBox
        Left = 16
        Top = 88
        Width = 505
        Height = 273
        Caption = '[ Campos ]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object BtnMoveParaBaixo: TSpeedButton
          Left = 152
          Top = 120
          Width = 23
          Height = 22
          Cursor = crDefault
          Hint = 'Mover campo para baixo'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
            333333333337F33333333333333033333333333333373F333333333333090333
            33333333337F7F33333333333309033333333333337373F33333333330999033
            3333333337F337F33333333330999033333333333733373F3333333309999903
            333333337F33337F33333333099999033333333373333373F333333099999990
            33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333300033333333333337773333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnMoveParaBaixoClick
        end
        object BtnMoveParaCima: TSpeedButton
          Left = 152
          Top = 152
          Width = 23
          Height = 22
          Cursor = crDefault
          Hint = 'Mover campo para cima'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
            3333333333777F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
            3333333777737777F333333099999990333333373F3333373333333309999903
            333333337F33337F33333333099999033333333373F333733333333330999033
            3333333337F337F3333333333099903333333333373F37333333333333090333
            33333333337F7F33333333333309033333333333337373333333333333303333
            333333333337F333333333333330333333333333333733333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnMoveParaCimaClick
        end
        object BtnDeletarCampo: TSpeedButton
          Left = 152
          Top = 216
          Width = 23
          Height = 22
          Cursor = crDefault
          Hint = 'Excluir Campo Selecionado'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            300033FFFFFF3333377739999993333333333777777F3333333F399999933333
            3300377777733333337733333333333333003333333333333377333333333333
            3333333333333333333F333333333333330033333F33333333773333C3333333
            330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
            993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
            333333377F33333333FF3333C333333330003333733333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnDeletarCampoClick
        end
        object Label5: TLabel
          Left = 262
          Top = 11
          Width = 28
          Height = 13
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 268
          Top = 35
          Width = 21
          Height = 13
          Caption = 'Tipo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 244
          Top = 59
          Width = 45
          Height = 13
          Caption = 'Tamanho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 255
          Top = 83
          Width = 33
          Height = 13
          Caption = 'Edição'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 248
          Top = 107
          Width = 41
          Height = 13
          Caption = 'Máscara'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 260
          Top = 131
          Width = 28
          Height = 13
          Caption = 'Título'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 260
          Top = 155
          Width = 27
          Height = 13
          Caption = 'Ajuda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 228
          Top = 179
          Width = 61
          Height = 13
          Caption = 'Valor Padrão'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 241
          Top = 203
          Width = 47
          Height = 13
          Caption = 'Validação'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 217
          Top = 227
          Width = 72
          Height = 13
          Caption = 'Valores Válidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 241
          Top = 251
          Width = 48
          Height = 13
          Caption = 'Descrição'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ListaCampos: TListBox
          Left = 2
          Top = 15
          Width = 143
          Height = 256
          Align = alLeft
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnClick = ListaCamposClick
          OnDblClick = ListaCamposDblClick
          OnEnter = ListaCamposClick
        end
        object EdNomeCampo: TEdit
          Left = 296
          Top = 8
          Width = 161
          Height = 21
          Hint = 'Informe o nome do campo'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnExit = EdNomeCampoExit
          OnKeyPress = EdNumeroKeyPress
        end
        object ComboTipoCampo: TComboBox
          Left = 296
          Top = 32
          Width = 129
          Height = 21
          Hint = 'Informe o tipo do campo'
          Style = csDropDownList
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnKeyPress = EdNumeroKeyPress
          Items.Strings = (
            'Alfanumérico'
            'Número Inteiro'
            'Número Fracionário'
            'Data'
            'Memo'
            'Imagem')
        end
        object EdTamanhoCampo: TMaskEdit
          Left = 296
          Top = 56
          Width = 41
          Height = 21
          Hint = 'Informe o tamanho do campo'
          Enabled = False
          EditMask = '99999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Text = '     '
          OnKeyPress = EdNumeroKeyPress
        end
        object ComboEdicaoCampo: TComboBox
          Left = 296
          Top = 80
          Width = 161
          Height = 21
          Hint = 'Informe o tipo de edição do campo'
          Style = csDropDownList
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnKeyPress = EdNumeroKeyPress
          Items.Strings = (
            'Edição Padrão ( Edit )'
            'Rotativo ( Spin Edit )'
            'Lista Interna ( Combo Drop )'
            'Optativo ( Rádio Buttom )'
            'Conferência ( Check Box )')
        end
        object EdMascaraCampo: TEdit
          Left = 296
          Top = 104
          Width = 161
          Height = 21
          Hint = 'Informe a máscara de edição do campo'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnKeyPress = EdNumeroKeyPress
        end
        object EdTituloCampo: TEdit
          Left = 296
          Top = 128
          Width = 161
          Height = 21
          Hint = 'Informe o título do campo'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnKeyPress = EdNumeroKeyPress
        end
        object EdAjudaCampo: TEdit
          Left = 296
          Top = 152
          Width = 161
          Height = 21
          Hint = 'Informe a mensagem de ajuda padrão do campo'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnKeyPress = EdNumeroKeyPress
        end
        object EdValorCampo: TEdit
          Left = 296
          Top = 176
          Width = 161
          Height = 21
          Hint = 'Informe o valor padrão do campo ( Default )'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnKeyPress = EdNumeroKeyPress
        end
        object ComboValidacaoCampo: TComboBox
          Left = 296
          Top = 200
          Width = 161
          Height = 21
          Hint = 'Informe a expressão de validação do campo'
          Style = csDropDownList
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnKeyPress = EdNumeroKeyPress
          Items.Strings = (
            ''
            'VCNPJ'
            'VCPF'
            'VPIS'
            'VUF'
            'DATAVALIDA'
            'VALORNULO'
            'VHORA'
            'VHORAMIN'
            'VHORAMINSEG'
            'ANOATUAL'
            'MESATUAL'
            'MESANOATUAL'
            'MESANOVALIDO')
        end
        object EdValoresCampo: TEdit
          Left = 296
          Top = 224
          Width = 161
          Height = 21
          Hint =
            'Informe os valores válidos separados por '#39'; '#39' (ponto e vírgula) ' +
            '  Exemplo: F;M'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnKeyPress = EdNumeroKeyPress
        end
        object EdDescricaoCampo: TEdit
          Left = 296
          Top = 248
          Width = 161
          Height = 21
          Hint = 'Informe a descrição dos valores válidos'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnKeyPress = EdNumeroKeyPress
        end
        object BtnImportar: TBitBtn
          Left = 464
          Top = 7
          Width = 20
          Height = 21
          Cursor = crDefault
          Hint = 'Importar campo predefinido'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnClick = BtnImportarClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFFFF
            FFFF33333333333FFFFF3FFFFFFFFF00000F333333333377777F33FFFFFFFF09
            990F33333333337F337F333FFFFFFF09990F33333333337F337F3333FFFFFF09
            990F33333333337FFF7F33333FFFFF00000F3333333333777773333333FFFFFF
            FFFF3FFFFF3333333F330000033FFFFF0FFF77777F3333337FF30EEE0333FFF0
            00FF7F337FFF333777FF0EEE00033F00000F7F33777F3777777F0EEE0E033000
            00007FFF7F7FF777777700000E00033000FF777773777F3777F3330EEE0E0330
            00FF337FFF7F7F3777F33300000E033000FF337777737F37773333330EEE0300
            03FF33337FFF77777333333300000333333F3333777773333333}
          NumGlyphs = 2
        end
        object BtnGravarCampo: TBitBtn
          Left = 152
          Top = 56
          Width = 23
          Height = 22
          Cursor = crDefault
          Hint = 'Confirmar a inclusão ou alteração do campo'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          OnClick = BtnGravarCampoClick
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
        object BtnCancelarCampo: TBitBtn
          Left = 152
          Top = 88
          Width = 23
          Height = 22
          Cursor = crDefault
          Hint = 'Cancelar definição do campo'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          OnClick = BtnCancelarCampoClick
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
            0303F8F80303030303030303030303030303030303FF03030303030303030303
            0303030303F90101F80303030303F9F80303030303030303F8F8FF0303030303
            03FF03030303030303F9010101F8030303F90101F8030303030303F8FF03F8FF
            030303FFF8F8FF030303030303F901010101F803F901010101F80303030303F8
            FF0303F8FF03FFF80303F8FF030303030303F901010101F80101010101F80303
            030303F8FF030303F8FFF803030303F8FF030303030303F90101010101010101
            F803030303030303F8FF030303F803030303FFF80303030303030303F9010101
            010101F8030303030303030303F8FF030303030303FFF8030303030303030303
            030101010101F80303030303030303030303F8FF0303030303F8030303030303
            0303030303F901010101F8030303030303030303030303F8FF030303F8030303
            0303030303030303F90101010101F8030303030303030303030303F803030303
            F8FF030303030303030303F9010101F8010101F803030303030303030303F803
            03030303F8FF0303030303030303F9010101F803F9010101F803030303030303
            03F8030303F8FF0303F8FF03030303030303F90101F8030303F9010101F80303
            03030303F8FF0303F803F8FF0303F8FF03030303030303F9010303030303F901
            0101030303030303F8FFFFF8030303F8FF0303F8FF0303030303030303030303
            030303F901F903030303030303F8FC0303030303F8FFFFFFF803030303030303
            03030303030303030303030303030303030303030303030303F8F8F803030303
            0303030303030303030303030303030303030303030303030303030303030303
            0303}
          NumGlyphs = 2
        end
        object BtnNovoCampo: TBitBtn
          Left = 152
          Top = 184
          Width = 23
          Height = 22
          Cursor = crDefault
          Hint = 'Inserir novo campo'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          OnClick = BtnNovoCampoClick
          OnKeyPress = EdNumeroKeyPress
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333FF33333333FF333993333333300033377F3333333777333993333333
            300033F77FFF3333377739999993333333333777777F3333333F399999933333
            33003777777333333377333993333333330033377F3333333377333993333333
            3333333773333333333F333333333333330033333333F33333773333333C3333
            330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
            993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
            333333333337733333FF3333333C333330003333333733333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
        end
      end
      object BtnRetornarTabela: TBitBtn
        Left = 364
        Top = 368
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Retornar'
        Caption = '&Retornar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BtnRetornarTabelaClick
        NumGlyphs = 2
      end
      object BtnAjudaCampos: TBitBtn
        Left = 445
        Top = 368
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Ajuda'
        Caption = 'A&juda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object BtnBancoDados: TBitBtn
        Left = 333
        Top = 65
        Width = 20
        Height = 21
        Cursor = crDefault
        Hint = 'Configurar banco de dados'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = BtnBancoDadosClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          77777780000000000000778F777777777770778F887777778870778F88FFFFFF
          88F07788888888888880778F777777777770778FFFFFFFFFFFF0747888888888
          8888444777800008777747447778888777777774477777777777747744777777
          7777444777777777777747447777777777777774477777777777}
      end
    end
    object TabIndices: TTabSheet
      Caption = '&3. Indices'
      ImageIndex = 2
      object Bevel4: TBevel
        Left = 8
        Top = 8
        Width = 521
        Height = 393
      end
      object BtnMoveIndiceParaBaixo: TSpeedButton
        Left = 480
        Top = 24
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Mover índice para baixo'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337F33333333333333033333333333333373F333333333333090333
          33333333337F7F33333333333309033333333333337373F33333333330999033
          3333333337F337F33333333330999033333333333733373F3333333309999903
          333333337F33337F33333333099999033333333373333373F333333099999990
          33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333300033333333333337773333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveIndiceParaBaixoClick
      end
      object BtnMoveIndiceParaCima: TSpeedButton
        Left = 480
        Top = 56
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Mover índice para cima'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          3333333333777F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
          3333333777737777F333333099999990333333373F3333373333333309999903
          333333337F33337F33333333099999033333333373F333733333333330999033
          3333333337F337F3333333333099903333333333373F37333333333333090333
          33333333337F7F33333333333309033333333333337373333333333333303333
          333333333337F333333333333330333333333333333733333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveIndiceParaCimaClick
      end
      object BtnExcluirIndice: TSpeedButton
        Left = 480
        Top = 120
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Excluir indice selecionado'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnExcluirIndiceClick
      end
      object Label1: TLabel
        Left = 246
        Top = 155
        Width = 28
        Height = 13
        Caption = 'Título'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object BtnInserirChave: TSpeedButton
        Left = 248
        Top = 216
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Inserir campo na chave'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333FF3333333333333003333
          3333333333773FF3333333333309003333333333337F773FF333333333099900
          33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
          99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
          33333333337F3F77333333333309003333333333337F77333333333333003333
          3333333333773333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnInserirChaveClick
      end
      object BtnExcluirChave: TSpeedButton
        Left = 248
        Top = 248
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Remover campo da chave'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333FF3333333333333003333333333333F77F33333333333009033
          333333333F7737F333333333009990333333333F773337FFFFFF330099999000
          00003F773333377777770099999999999990773FF33333FFFFF7330099999000
          000033773FF33777777733330099903333333333773FF7F33333333333009033
          33333333337737F3333333333333003333333333333377333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnExcluirChaveClick
      end
      object BtnMoveChaveParaBaixo: TSpeedButton
        Left = 448
        Top = 240
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Mover campo para baixo'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337F33333333333333033333333333333373F333333333333090333
          33333333337F7F33333333333309033333333333337373F33333333330999033
          3333333337F337F33333333330999033333333333733373F3333333309999903
          333333337F33337F33333333099999033333333373333373F333333099999990
          33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333300033333333333337773333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveChaveParaBaixoClick
      end
      object BtnMoveChaveParaCima: TSpeedButton
        Left = 448
        Top = 272
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Mover campo para cima'
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          3333333333777F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
          3333333777737777F333333099999990333333373F3333373333333309999903
          333333337F33337F33333333099999033333333373F333733333333330999033
          3333333337F337F3333333333099903333333333373F37333333333333090333
          33333333337F7F33333333333309033333333333337373333333333333303333
          333333333337F333333333333330333333333333333733333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveChaveParaCimaClick
      end
      object GroupBox1: TGroupBox
        Left = 40
        Top = 16
        Width = 433
        Height = 129
        Caption = '[ Índices ]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object GridIndices: TStringGrid
          Left = 2
          Top = 15
          Width = 429
          Height = 112
          Align = alClient
          ColCount = 3
          DefaultColWidth = 30
          DefaultRowHeight = 16
          Enabled = False
          RowCount = 1
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = GridIndicesClick
          OnDblClick = GridIndicesDblClick
          OnEnter = GridIndicesClick
          ColWidths = (
            30
            193
            182)
        end
      end
      object BtnNovoIndice: TBitBtn
        Left = 480
        Top = 88
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Inserir novo indice'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnNovoIndiceClick
        OnKeyPress = EdNumeroKeyPress
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object Campos: TGroupBox
        Left = 88
        Top = 152
        Width = 153
        Height = 193
        Caption = '[ Campos ]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object ListaCamposEscolha: TListBox
          Left = 2
          Top = 15
          Width = 149
          Height = 176
          Align = alClient
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnDblClick = BtnInserirChaveClick
        end
      end
      object EdTituloIndice: TEdit
        Left = 280
        Top = 152
        Width = 161
        Height = 21
        Hint = 'Informe o título do índice'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnExit = EdTituloIndiceExit
        OnKeyPress = EdNumeroKeyPress
      end
      object GroupBox2: TGroupBox
        Left = 280
        Top = 176
        Width = 161
        Height = 169
        Caption = '[ Chave ]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object ListaChave: TListBox
          Left = 2
          Top = 15
          Width = 157
          Height = 152
          Align = alClient
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnClick = ListaChaveClick
          OnDblClick = BtnExcluirChaveClick
        end
      end
      object BtnGravarIndice: TBitBtn
        Left = 448
        Top = 151
        Width = 23
        Height = 22
        Cursor = crDefault
        Hint = 'Confirmar a inclusão ou alteração do índice'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BtnGravarIndiceClick
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
      object BtnCancelarIndice: TBitBtn
        Left = 368
        Top = 368
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Retornar'
        Caption = '&Retornar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = BtnRetornarTabelaClick
        NumGlyphs = 2
      end
      object BtnAjudaIndice: TBitBtn
        Left = 448
        Top = 368
        Width = 75
        Height = 25
        Cursor = crDefault
        Hint = 'Ajuda'
        Caption = 'A&juda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
    end
  end
  object OpenGDB: TOpenDialog
    Filter = 'Banco de Dados InterBase ( *.GDB )|*.GDB'
    Left = 502
    Top = 28
  end
end
