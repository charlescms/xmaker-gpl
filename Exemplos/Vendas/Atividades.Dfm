object FormAtividades: TFormAtividades
  WindowState = wsNormal
  BorderStyle = bsSizeable
  Position = poScreenCenter
  FormStyle = fsNormal
  Left = 5
  Top = 5
  Width = 574
  Height = 393
  BorderIcons = [biSystemMenu,biMinimize,biMaximize]
  Caption = 'Entrada de Dados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Visible = False
  PixelsPerInch = 96
  TextHeight = 13
  Onactivate = formactivate
  Onclose = formclose
  Onclosequery = formclosequery
  Onkeydown = formkeydown
  Onkeypress = formkeypress
  Onkeyup = formkeyup
  Onresize = formresize
  Onshow = formshow
  object PagePrincipal: TPageControl
    Left = 0
    Top = 50
    Width = 566
    Height = 316
    HelpContext = 220
    ActivePage = TabManutencao
    Align = alClient
    HotTrack = True
    TabOrder = 0
    object TabManutencao: TTabSheet
      Caption = '( &1 ) Manutenção'
      object PnSalva: TPanel
        Left = 0
        Top = 257
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
          Onclick = BTNSALVARclick
        end
        object BtnDesistir: TBitBtn
          Left = 98
          Top = 5
          Width = 75
          Height = 25
          Hint = 'Desistir da inclusão/modificação'
          Caption = '&Desistir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
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
          Onclick = BTNDESISTIRclick
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
          Onclick = BTNRELAC_1click
        end
      end
      object TabPaginas: TTabSet
        Left = 0
        Top = 236
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
        Onclick = TABPAGINASclick
      end
      object PgPagina1: TScrollBox
        Left = 0
        Top = 0
        Width = 558
        Height = 236
        Align = alClient
        BorderStyle = bsNone
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object NoManutencao: TNotebook
          Left = 0
          Top = 0
          Width = 558
          Height = 236
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
              Height = 236
              Align = alClient
              AutoScroll = False
              BorderStyle = bsNone
              TabOrder = 0
              object LbcATI_CODIGO: TLabel
                Left = 22
                Top = 16
                Width = 33
                Height = 13
                Alignment = taRightJustify
                Caption = 'Código'
                ParentShowHint = False
                ShowHint = True
              end
              object LbcATI_DESCRICAO: TLabel
                Left = 7
                Top = 41
                Width = 48
                Height = 13
                Alignment = taRightJustify
                Caption = 'Descrição'
                ParentShowHint = False
                ShowHint = True
              end
              object ATI_CODIGO: TXDBNumEdit
                Left = 58
                Top = 12
                Width = 35
                Height = 21
                Cursor = crArrow
                AutoHideCalculator = False
                Glyph.Data = {
                  7E050000424D7E0500000000000036000000280000001A0000000D0000000100
                  2000000000004805000000000000000000000000000000000000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C0008040400080404000804040008040400080404000804040008040
                  4000804040008040400080404000FFC0C000FFC0C000FFC0C000FFFFFF008080
                  8000808080008080800080808000808080008080800080808000808080008080
                  8000FFC0C000FFC0C000FFC0C000FFC00000FF406000FF406000FF406000FF40
                  6000FF406000FF406000FF406000FF40600080404000FFC0C000FFC0C000FFC0
                  C000FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC00000FF406000FFC0
                  0000FFFFFF00FFC00000FFFFFF00FFC00000FFFFFF00FF40600080404000FFC0
                  C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFFFFF0080808000FFFF
                  FF0080808000FFFFFF00FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC0
                  0000FF406000FF406000FF406000FF406000FF406000FF406000FF406000FF40
                  600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0C000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C00080808000FFC0C000FFC0
                  C000FFC0C000FFC00000FF406000FFC00000FFFFFF00FFC00000FFFFFF00FFC0
                  0000FFFFFF00FF40600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0
                  C00080808000FFFFFF0080808000FFFFFF0080808000FFFFFF00FFC0C0008080
                  8000FFC0C000FFC0C000FFC0C000FFC00000FF406000FF406000FF406000FF40
                  6000FF406000FF406000FF406000FF40600080404000FFC0C000FFC0C000FFC0
                  C000FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC00000FF4060004000
                  0000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FF40600080404000FFC0
                  C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFFFFF00FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF00FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC0
                  0000FF40600040000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C000FF40
                  600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0C00080808000FFC0C000FFC0
                  C000FFC0C000FFC00000FF406000400000004000000040000000400000004000
                  000040000000FF40600080404000FFC0C000FFC0C000FFC0C000FFFFFF00FFC0
                  C000808080008080800080808000808080008080800080808000FFC0C0008080
                  8000FFC0C000FFC0C000FFC0C000FFC00000FF406000FF406000FF406000FF40
                  6000FF406000FF406000FF406000FF40600080404000FFC0C000FFC0C000FFC0
                  C000FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C00080808000FFC0C000FFC0C000FFC0C000FFC00000FFC00000FFC0
                  0000FFC00000FFC00000FFC00000FFC00000FFC00000FFC0000080404000FFC0
                  C000FFC0C000FFC0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
                  C000}
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                Onexit = ATI_CODIGOexit
              end
              object ATI_DESCRICAO: TXDBEdit
                Left = 58
                Top = 37
                Width = 294
                Height = 21
                Cursor = crArrow
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                Text = 'ATI_DESCRICAO'
                Glyph.Data = {
                  7E050000424D7E0500000000000036000000280000001A0000000D0000000100
                  2000000000004805000000000000000000000000000000000000008000000080
                  0000008000000080000000800000008000000080000000800000008000000080
                  0000008000000080000000800000008000000080000000800000008000000080
                  0000008000000080000000800000008000000080000000800000008000000080
                  0000000000000000000000000000008000000080000000800000008000000080
                  000000000000000000000000000000800000008000000080000000800000FFFF
                  FF00FFFFFF00FFFFFF000080000000800000008000000080000000800000FFFF
                  FF00FFFFFF00FFFFFF0000000000008000000000000000800000008000000080
                  0000008000000080000000000000008000000000000000800000008000000080
                  000000800000FFFFFF0000800000FFFFFF000080000000800000008000000080
                  000000800000FFFFFF0000800000FFFFFF000000000000000000000000008080
                  8000008000000080000000800000808080000000000000000000000000000080
                  0000008000000080000000800000FFFFFF00FFFFFF00FFFFFF00808080000080
                  0000008000000080000080808000FFFFFF00FFFFFF00FFFFFF00000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  00000000000000800000008000000080000000800000FFFFFF00FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                  FF00000000000080000000000000000000000000000000000000008000000000
                  000000000000000000000000000000800000008000000080000000800000FFFF
                  FF0000800000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000800000FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF0000000000008000000000000000000000000000000000
                  0000008000000000000000000000000000000000000000800000008000000080
                  000000800000FFFFFF0000800000FFFFFF00FFFFFF00FFFFFF00FFFFFF000080
                  0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000080
                  0000008000000080000000800000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
                  0000000000000000000000000000808080000000000000000000000000000000
                  00000000000000800000008000000080000000800000FFFFFF00FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                  FF00008000000080000000000000000000000080000000800000008000000000
                  0000000000000080000000800000008000000080000000800000008000000080
                  000000800000FFFFFF00FFFFFF00008000000080000000800000FFFFFF00FFFF
                  FF00008000000080000000800000008000000000000000000000008000000080
                  0000008000000000000000000000008000000080000000800000008000000080
                  0000008000000080000000800000FFFFFF00FFFFFF0000800000008000000080
                  0000FFFFFF00FFFFFF0000800000008000000080000000800000000000000000
                  0000008000000080000000800000000000000000000000800000008000000080
                  00000080000000800000008000000080000000800000FFFFFF00FFFFFF000080
                  00000080000000800000FFFFFF00FFFFFF000080000000800000008000000080
                  0000008000000080000000800000008000000080000000800000008000000080
                  0000008000000080000000800000008000000080000000800000008000000080
                  0000008000000080000000800000008000000080000000800000008000000080
                  0000}
                Onexit = ATI_DESCRICAOexit
              end
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
              Height = 256
              Align = alClient
              AutoScroll = False
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
        Top = 257
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
        Height = 236
        HelpContext = 220
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
        Ondblclick = GRIDCONSULTAdblclick
      end
      object AbaConsulta: TTabSet
        Left = 0
        Top = 236
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
        Onclick = ABACONSULTAclick
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
      Onclick = BTNAJUDAclick
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
      Onclick = BTNFECHARclick
    end
  end
  object BarraPrincipal: TPanel
    Left = 0
    Top = 20
    Width = 566
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Gradiente: TPaintBox
      Left = 0
      Top = 0
      Width = 566
      Height = 30
      Align = alClient
    end
    object BtnLocalizar: TSpeedButton
      Left = 149
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Localizar registro'
      Caption = 'Localizar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
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
      Margin = 0
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object BtnIncluir: TSpeedButton
      Left = 228
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Incluir registro'
      Caption = 'Incluir'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      Margin = 0
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object BtnModificar: TSpeedButton
      Left = 307
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Modificar registro'
      Caption = 'Modificar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
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
      Margin = 0
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object BtnExcluir: TSpeedButton
      Left = 386
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Excluir registro'
      Caption = 'Excluir'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      Margin = 0
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object BtnPrimeiro: TSpeedButton
      Left = 465
      Top = 3
      Width = 23
      Height = 25
      Hint = 'Primeiro registro'
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
      Visible = False
    end
    object BtnAnterior: TSpeedButton
      Left = 488
      Top = 3
      Width = 23
      Height = 25
      Hint = 'Registro anterior'
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
      Visible = False
    end
    object BtnProximo: TSpeedButton
      Left = 511
      Top = 3
      Width = 23
      Height = 25
      Hint = 'Próximo registro'
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
      Visible = False
    end
    object BtnUltimo: TSpeedButton
      Left = 534
      Top = 3
      Width = 23
      Height = 25
      Hint = 'último registro'
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
      Visible = False
    end
  end
  object DataSource: TDataSource
  end
  object PopConsulta: TPopupMenu
    object mnu_Filtrar: TMenuItem
      Caption = 'Filtrar Registros'
      Hint = 'Filtrar Registros'
      ShortCut = 16454
      Onclick = MNU_FILTRARclick
    end
    object mnu_Ordenar: TMenuItem
      Caption = 'Ordenar Registros'
      Hint = 'Ordena registros, cria uma nova ordem'
      ShortCut = 16463
      Onclick = MNU_ORDENARclick
    end
    object mnu_OrdenarComposto: TMenuItem
      Caption = 'Ordenação Composta'
      Hint = 'Cria ordenação composta, não apaga ordenação já definida'
      ShortCut = 16466
      Onclick = MNU_ORDENARCOMPOSTOclick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnu_ApagarColuna: TMenuItem
      Caption = 'Apagar Coluna Selecionada'
      Hint = 'Apaga coluna selecionada'
      ShortCut = 16449
      Onclick = MNU_APAGARCOLUNAclick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnu_Quantificar: TMenuItem
      Caption = 'Quantificar Registros'
      Hint = 'Quantificar registros apresentados'
      ShortCut = 16465
      Onclick = MNU_QUANTIFICARclick
    end
    object mnu_TotalizarColuna: TMenuItem
      Caption = 'Totalizar Coluna Selecionada'
      Hint = 'Totaliza coluna númerica selecionada'
      ShortCut = 16468
      Onclick = MNU_TOTALIZARCOLUNAclick
    end
    object mnu_CalcularMedia: TMenuItem
      Caption = 'Calcular Média da Coluna'
      Hint = 'Calcula a média da coluna selecionada'
      ShortCut = 16469
      Onclick = MNU_CALCULARMEDIAclick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mnu_Imprimir: TMenuItem
      Caption = 'Imprimir Consulta'
      Hint = 'Imprimir consulta'
      ShortCut = 16464
      Onclick = MNU_IMPRIMIRclick
    end
    object mnu_SalvarConsulta: TMenuItem
      Caption = 'Salvar Consulta'
      Hint = 'Salvar consulta'
      ShortCut = 16467
      Onclick = MNU_SALVARCONSULTAclick
    end
    object mnu_ExcluirConsulta: TMenuItem
      Caption = 'Excluir Consulta'
      Hint = 'Excluir consulta'
      ShortCut = 16472
      Onclick = MNU_EXCLUIRCONSULTAclick
    end
  end
  object MenuImagem: TPopupMenu
    object CortarImagem: TMenuItem
      Caption = 'Cortar'
      ShortCut = 16472
      Onclick = CORTARIMAGEMclick
    end
    object CopiarImagem: TMenuItem
      Caption = 'Copiar'
      ShortCut = 16451
      Onclick = COPIARIMAGEMclick
    end
    object ColarImagem: TMenuItem
      Caption = 'Colar'
      ShortCut = 16470
      Onclick = COLARIMAGEMclick
    end
    object MnSep01: TMenuItem
      Caption = '-'
    end
    object AbrirImagem: TMenuItem
      Caption = 'Abrir...'
      Onclick = ABRIRIMAGEMclick
    end
    object SalvarImagem: TMenuItem
      Caption = 'Salvar como...'
      Onclick = SALVARIMAGEMclick
    end
  end
  object DlgSalvarComoImagem: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap (*.bmp)|*.bmp|ícone (*.ico)|*.ico|Metafile (*.wmf)|*.wmf'
    Title = 'Salvar Imagem Como'
  end
  object DlgAbrirImagem: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 
      'Imagens (*.jpg;*.jpeg;*.bmp;*.emf;*.wmf)|*.jpg;*.jpeg;*.bmp;*.em' +
      'f;*.wmf|JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*' +
      '.jpeg|Bitmaps (*.bmp)|*.bmp|Todos os arquivos (*.*)|*.*'
    Title = 'Abrir Imagem'
  end
  object PopRelacionados: TPopupMenu
  end
end
