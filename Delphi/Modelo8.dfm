object FormXMakerModelo: TFormXMakerModelo
  Left = 695
  Top = 252
  Width = 574
  Height = 393
  Caption = 'Entrada de Dados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PagePrincipal: TPageControl
    Left = 0
    Top = 53
    Width = 566
    Height = 312
    ActivePage = TabManutencao
    Align = alClient
    HotTrack = True
    TabOrder = 0
    OnChange = PagePrincipalChange
    object TabManutencao: TTabSheet
      Caption = '( &1 ) Manuten'#231#227'o'
      object PnSalva: TPanel
        Left = 0
        Top = 253
        Width = 558
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object BtnSalvar: TBitBtn
          Left = 8
          Top = 5
          Width = 75
          Height = 25
          Hint = 'Salvar registro'
          Caption = '&Salvar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = BtnSalvarClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
            66666666666666666666660000000000000666FFFFFFFFFFFFF6603300000077
            03066F66FFFFFF66F6F660330000007703066F66FFFFFF66F6F6603300000077
            03066F66FFFFFF66F6F660330000000003066F66FFFFFFFFF6F6603333333333
            33066F666666666666F660330000000033066F66FFFFFFFF66F6603077777777
            03066F6F66666666F6F660307777777703066F6F66666666F6F6603077777777
            03066F6F66666666F6F660307777777703066F6F66666666F6F6603077777777
            00066F6F66666666FFF660307777777703066F6F66666666F6F6600000000000
            00066FFFFFFFFFFFFFF666666666666666666666666666666666}
          NumGlyphs = 2
        end
        object BtnDesistir: TBitBtn
          Left = 98
          Top = 5
          Width = 75
          Height = 25
          Hint = 'Desistir da inclus'#227'o/modifica'#231#227'o'
          Caption = '&Desistir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = BtnDesistirClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF33339993707399933333773337F3777FF3399933000339
            9933377333777F3377F3399333707333993337733337333337FF993333333333
            399377F33333F333377F993333303333399377F33337FF333373993333707333
            333377F333777F333333993333101333333377F333777F3FFFFF993333000399
            999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
            99933773FF777F3F777F339993707399999333773F373F77777F333999999999
            3393333777333777337333333999993333333333377777333333}
          NumGlyphs = 2
        end
        object BtnRelac_1: TBitBtn
          Left = 188
          Top = 5
          Width = 75
          Height = 25
          Hint = 'Tabelas relacionadas ...'
          Caption = '&Tabelas'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Visible = False
          OnClick = BtnRelac_1Click
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777777777777777778888888888888887888888888888888000000000000
            0000FFFFFFFFFFFFFFFF0FFFF0FFFF0FFFF0F7777F7777F7777F0FFFF0FFFF0F
            FFF0F7777F7777F7777F0000000000000000FFFFFFFFFFFFFFFF0FFFF0FFFF0F
            FFF0F7777F7777F7777F0FFFF0FFFF0FFFF0F7777F7777F7777F000000000000
            0000FFFFFFFFFFFFFFFF0FFFF0FFFF0FFFF0F7777F7777F7777F0FFFF0FFFF0F
            FFF0F7777F7777F7777F0000000000000000FFFFFFFFFFFFFFFF0AAAAAAAAAAA
            AAA0FAAAAAAAAAAAAAAF0AAAAAAAAAAAAAA0FAAAAAAAAAAAAAAF000000000000
            0000FFFFFFFFFFFFFFFF77777777777777777777777777777777}
          NumGlyphs = 2
        end
      end
      object TabPaginas: TTabSet
        Left = 0
        Top = 232
        Width = 558
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Tabs.Strings = (
          'Principal')
        TabIndex = 0
        OnClick = TabPaginasClick
      end
      object PgPagina1: TScrollBox
        Left = 0
        Top = 0
        Width = 558
        Height = 232
        Align = alClient
        BorderStyle = bsNone
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object NoManutencao: TNotebook
          Left = 0
          Top = 0
          Width = 558
          Height = 232
          Align = alClient
          TabOrder = 0
          object PgPrincipal: TPage
            Left = 0
            Top = 0
            Caption = 'Principal'
            object Pagina0: TScrollBox
              Left = 0
              Top = 0
              Width = 558
              Height = 232
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento1: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 1'
            object Pagina1: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento2: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 2'
            object Pagina2: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento3: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 3'
            object Pagina3: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento4: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 4'
            object Pagina4: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento5: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 5'
            object Pagina5: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento6: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 6'
            object Pagina6: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento7: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 7'
            object Pagina7: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento8: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 8'
            object Pagina8: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento9: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 9'
            object Pagina9: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
          object PgComplemento10: TPage
            Left = 0
            Top = 0
            Caption = 'Complemento 10'
            object Pagina10: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 286
              Align = alClient
              BorderStyle = bsNone
              TabOrder = 0
            end
          end
        end
      end
    end
    object TabConsulta: TTabSheet
      Caption = '( &2 ) Consulta'
      ImageIndex = 1
      object PnInfConsulta: TPanel
        Left = 0
        Top = 253
        Width = 558
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object BtnRelac_2: TBitBtn
          Left = 8
          Top = 5
          Width = 75
          Height = 25
          Hint = 'Tabelas relacionadas ...'
          Caption = '&Tabelas'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Visible = False
          OnClick = BtnRelac_1Click
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7777777777777777777778888888888888887888888888888888000000000000
            0000FFFFFFFFFFFFFFFF0FFFF0FFFF0FFFF0F7777F7777F7777F0FFFF0FFFF0F
            FFF0F7777F7777F7777F0000000000000000FFFFFFFFFFFFFFFF0FFFF0FFFF0F
            FFF0F7777F7777F7777F0FFFF0FFFF0FFFF0F7777F7777F7777F000000000000
            0000FFFFFFFFFFFFFFFF0FFFF0FFFF0FFFF0F7777F7777F7777F0FFFF0FFFF0F
            FFF0F7777F7777F7777F0000000000000000FFFFFFFFFFFFFFFF0AAAAAAAAAAA
            AAA0FAAAAAAAAAAAAAAF0AAAAAAAAAAAAAA0FAAAAAAAAAAAAAAF000000000000
            0000FFFFFFFFFFFFFFFF77777777777777777777777777777777}
          NumGlyphs = 2
        end
      end
      object GridConsulta: TDBGrid
        Left = 0
        Top = 0
        Width = 558
        Height = 232
        Align = alClient
        BorderStyle = bsNone
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        PopupMenu = PopConsulta
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = GridConsultaDblClick
      end
      object AbaConsulta: TTabSet
        Left = 0
        Top = 232
        Width = 558
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Tabs.Strings = (
          'Principal')
        TabIndex = 0
        OnClick = AbaConsultaClick
      end
    end
  end
  object PnSup: TPanel
    Left = 0
    Top = 0
    Width = 566
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object ShapeSup: TShape
      Left = 0
      Top = 0
      Width = 566
      Height = 20
      Align = alClient
      Brush.Color = 14743792
      ParentShowHint = False
      Pen.Color = 7021576
      ShowHint = True
    end
    object LbTituloForm: TLabel
      Left = 0
      Top = 0
      Width = 566
      Height = 20
      Align = alClient
      Alignment = taCenter
      Caption = 'Entrada de Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
    end
    object BtnAjuda: TSpeedButton
      Left = 529
      Top = 2
      Width = 16
      Height = 14
      Hint = 'Ajuda'
      Caption = '?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = BtnAjudaClick
    end
    object BtnFechar: TSpeedButton
      Left = 547
      Top = 2
      Width = 16
      Height = 14
      Hint = 'Fechar'
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
      OnClick = BtnFecharClick
    end
  end
  object PnSuperior: TPanel
    Left = 0
    Top = 20
    Width = 566
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object BtnIncluir: TSpeedButton
      Left = 4
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Incluir novo registro'
      Caption = '&Incluir'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333300000000000033333FFFFFFFFFFFF3330FFFFFFFFF
        F03333777777777777F3330FFFFFFFFFF033337F3333333337F3330FFFFFFFFF
        F033337F3333333337F3330FFFFFFFFFF033337F3333333337F3330FFFFFFFFF
        F033337F3333333337F3330FFFFFFFFFF033337F3333333337F3330FFFFFFFFF
        F033337F3333333337F3330FFFFFFFFFF033337F3333333337F3330FFFFFF000
        0033337F3333377777F3330FFFFFF0FF0333337F333337FFFFF3330FFFFFF0F0
        3333337F333337F33333330FFFFFF0033333337FFFFFF7F33333330000000033
        3333337777777733333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnIncluirClick
    end
    object BtnModificar: TSpeedButton
      Left = 79
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Modificar registro'
      Caption = '&Modificar'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555775777777
        57705557757777775FF7555555555555000755555555555F777F555555555550
        87075555555555F7577F5555555555088805555555555F755F75555555555033
        805555555555F755F75555555555033B05555555555F755F75555555555033B0
        5555555555F755F75555555555033B05555555555F755F75555555555033B055
        55555555F755F75555555555033B05555555555F755F75555555555033B05555
        555555F75FF75555555555030B05555555555F7F7F75555555555000B0555555
        5555F777F7555555555501900555555555557777755555555555099055555555
        5555777755555555555550055555555555555775555555555555}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnModificarClick
    end
    object BtnExcluir: TSpeedButton
      Left = 154
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Excluir registro'
      Caption = '&Excluir'
      Flat = True
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
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnExcluirClick
    end
    object BtnLocalizar: TSpeedButton
      Left = 229
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Localizar registro(s)'
      Caption = '&Localizar'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333300
        3333333333333333FF333333333330EC033333333333333FE7F3330000000ECC
        00333333FFFFFFFE77FF33033330ECC330333333F8888FE7788F330FFF0ECC3F
        30333333F333FE77838F3300003CC3FF30333333FFFF8778338F303E30003FFF
        3033333F8E8FFF83338F0FE3E303FFFF303333F3E8E8F833338F0EFE3E03FFFF
        303333FE3E8EF833338F0FEFE303FFFF303333F3E3E8F833338F30FEF03FFFFF
        3033333F3E3F8333338F330003FFFFFF30333333FFF83333338F330FFFFFFF00
        00333333F3333333FFFF330FFFFFFF3F03333333F333333383F3330FFFFFFF30
        33333333F33333338F3333000000000333333333FFFFFFFFF333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnLocalizarClick
    end
    object BtnTabela: TSpeedButton
      Left = 304
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Visualizar registros em forma de tabela'
      Caption = 'Tabela'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777778888888888888887888888888888888000000000000
        0000FFFFFFFFFFFFFFFF0FFFF0FFFF0FFFF0F7777F7777F7777F0FFFF0FFFF0F
        FFF0F7777F7777F7777F0000000000000000FFFFFFFFFFFFFFFF0FFFF0FFFF0F
        FFF0F7777F7777F7777F0FFFF0FFFF0FFFF0F7777F7777F7777F000000000000
        0000FFFFFFFFFFFFFFFF0FFFF0FFFF0FFFF0F7777F7777F7777F0FFFF0FFFF0F
        FFF0F7777F7777F7777F0000000000000000FFFFFFFFFFFFFFFF0AAAAAAAAAAA
        AAA0FAAAAAAAAAAAAAAF0AAAAAAAAAAAAAA0FAAAAAAAAAAAAAAF000000000000
        0000FFFFFFFFFFFFFFFF77777777777777777777777777777777}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnTabelaClick
    end
    object BtnPrimeiro: TSpeedButton
      Left = 379
      Top = 3
      Width = 24
      Height = 25
      Hint = 'Posicionar no primeiro registro'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333334433333033
        333333FF33333F333333334433330033333333FF3333FF333333334433307033
        333333FF333F3F333333334433077000003333FF33F33FFFFF33334430777777
        703333FF3F3333333F33334407777777703333FFF33333333F33334430777777
        703333FF3F3333333F33334433077000003333FF33F33FFFFF33334433307033
        333333FF333F3F333333334433330033333333FF3333FF333333334433333033
        333333FF33333F33333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnPrimeiroClick
    end
    object BtnAnterior: TSpeedButton
      Left = 403
      Top = 3
      Width = 24
      Height = 25
      Hint = 'Posicionar no registro anterior'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333330333
        333333333333F333333333333330033333333333333FF3333333333333070333
        3333333333F3F3333333333330770000033333333F33FFFFF333333307777777
        03333333F3333333F3333330777777770333333F33333333F333333307777777
        03333333F3333333F333333330770000033333333F33FFFFF333333333070333
        3333333333F3F333333333333330033333333333333FF3333333333333330333
        333333333333F333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnAnteriorClick
    end
    object BtnProximo: TSpeedButton
      Left = 427
      Top = 3
      Width = 24
      Height = 25
      Hint = 'Posicionar no pr'#243'ximo registro'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333033333
        3333333333F3333333333333330033333333333333FF33333333333333070333
        3333333333F3F3333333330000077033333333FFFFF33F333333330777777703
        333333F3333333F33333330777777770333333F33333333F3333330777777703
        333333F3333333F33333330000077033333333FFFFF33F333333333333070333
        3333333333F3F33333333333330033333333333333FF33333333333333033333
        3333333333F33333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnProximoClick
    end
    object BtnUltimo: TSpeedButton
      Left = 451
      Top = 3
      Width = 24
      Height = 25
      Hint = 'Posicionar no '#250'ltimo registro'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333330333334
        433333333F33333FF333333330033334433333333FF3333FF333333330703334
        433333333F3F333FF33330000077033443333FFFFF33F33FF333307777777034
        43333F3333333F3FF33330777777770443333F33333333FFF333307777777034
        43333F3333333F3FF33330000077033443333FFFFF33F33FF333333330703334
        433333333F3F333FF333333330033334433333333FF3333FF333333330333334
        433333333F33333FF33333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnUltimoClick
    end
    object BtnRefresh: TSpeedButton
      Left = 475
      Top = 3
      Width = 24
      Height = 25
      Hint = 'Atualizar registros'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333444443333333333F77777FFF333333444444444
        3333333777333777FF3333444333334443333377333333777FF3344433333334
        443337733333333377F3344333333333443337733333333337FF443333333333
        344377F333333333377F443333333333344377F3333333333373443333333333
        333377F3333333333333443333333333333377F33333333FFFFF443333333344
        444377FF33333377777F3443333333344443373FF3333337777F344433333333
        44433773FF33333F777F334443333344444333773F333377777F333444444444
        3343333777333777337333333444443333333333377777333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnRefreshClick
    end
    object Divisao_sup: TPanel
      Left = 0
      Top = 31
      Width = 566
      Height = 2
      Align = alBottom
      TabOrder = 0
    end
  end
  object DataSource: TDataSource
    Left = 112
    Top = 21
  end
  object PopConsulta: TPopupMenu
    Left = 92
    Top = 21
    object mnu_Filtrar: TMenuItem
      Caption = 'Filtrar Registros'
      Hint = 'Filtrar Registros'
      OnClick = mnu_FiltrarClick
    end
    object mnu_Ordenar: TMenuItem
      Caption = 'Ordenar Registros'
      Hint = 'Ordena registros, cria uma nova ordem'
      OnClick = mnu_OrdenarClick
    end
    object mnu_OrdenarComposto: TMenuItem
      Caption = 'Ordena'#231#227'o Composta'
      Hint = 'Cria ordena'#231#227'o composta, n'#227'o apaga ordena'#231#227'o j'#225' definida'
      OnClick = mnu_OrdenarCompostoClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnu_ApagarColuna: TMenuItem
      Caption = 'Apagar Coluna Selecionada'
      Hint = 'Apaga coluna selecionada'
      OnClick = mnu_ApagarColunaClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnu_Quantificar: TMenuItem
      Caption = 'Quantificar Registros'
      Hint = 'Quantificar registros apresentados'
      OnClick = mnu_QuantificarClick
    end
    object mnu_TotalizarColuna: TMenuItem
      Caption = 'Totalizar Coluna Selecionada'
      Hint = 'Totaliza coluna n'#250'merica selecionada'
      OnClick = mnu_TotalizarColunaClick
    end
    object mnu_CalcularMedia: TMenuItem
      Caption = 'Calcular M'#233'dia da Coluna'
      Hint = 'Calcula a m'#233'dia da coluna selecionada'
      OnClick = mnu_CalcularMediaClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mnu_Imprimir: TMenuItem
      Caption = 'Imprimir Consulta'
      Hint = 'Imprimir consulta'
      OnClick = mnu_ImprimirClick
    end
    object mnu_SalvarConsulta: TMenuItem
      Caption = 'Salvar Consulta'
      Hint = 'Salvar consulta'
      OnClick = mnu_SalvarConsultaClick
    end
    object mnu_ExcluirConsulta: TMenuItem
      Caption = 'Excluir Consulta'
      Hint = 'Excluir consulta'
      OnClick = mnu_ExcluirConsultaClick
    end
  end
  object MenuImagem: TPopupMenu
    Left = 96
    Top = 21
    object CortarImagem: TMenuItem
      Caption = 'Cortar'
      ShortCut = 16472
      OnClick = CortarImagemClick
    end
    object CopiarImagem: TMenuItem
      Caption = 'Copiar'
      ShortCut = 16451
      OnClick = CopiarImagemClick
    end
    object ColarImagem: TMenuItem
      Caption = 'Colar'
      ShortCut = 16470
      OnClick = ColarImagemClick
    end
    object MnSep01: TMenuItem
      Caption = '-'
    end
    object AbrirImagem: TMenuItem
      Caption = 'Abrir...'
      OnClick = AbrirImagemClick
    end
    object SalvarImagem: TMenuItem
      Caption = 'Salvar como...'
      OnClick = SalvarImagemClick
    end
  end
  object DlgSalvarComoImagem: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap (*.bmp)|*.bmp|'#237'cone (*.ico)|*.ico|Metafile (*.wmf)|*.wmf'
    Title = 'Salvar Imagem Como'
    Left = 308
    Top = 21
  end
  object DlgAbrirImagem: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 
      'Imagens (*.jpg;*.jpeg;*.bmp;*.emf;*.wmf)|*.jpg;*.jpeg;*.bmp;*.em' +
      'f;*.wmf|JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*' +
      '.jpeg|Bitmaps (*.bmp)|*.bmp|Todos os arquivos (*.*)|*.*'
    Title = 'Abrir Imagem'
    Left = 296
    Top = 21
  end
  object PopRelacionados: TPopupMenu
    Left = 204
    Top = 21
  end
end
