object FormEntradaDados: TFormEntradaDados
  Left = 266
  Top = 167
  Width = 587
  Height = 413
  HelpContext = 220
  BorderIcons = [biSystemMenu]
  Caption = 'Entrada de Dados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PagePrincipal: TPageControl
    Left = 0
    Top = 50
    Width = 579
    Height = 336
    HelpContext = 220
    ActivePage = TabManutencao
    Align = alClient
    HotTrack = True
    TabOrder = 0
    object TabManutencao: TTabSheet
      Caption = '( &1 ) Manutenção'
      object PnSalva: TPanel
        Left = 0
        Top = 277
        Width = 571
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object DsnStage_Mnt: TDsnStage
          Left = 0
          Top = 0
          Width = 571
          Height = 31
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 0
          OnMouseDown = DsnStage0MouseDown
          Rubberband.Color = clGray
          Rubberband.PenWidth = 2
          Rubberband.MoveWidth = 8
          Rubberband.MoveHeight = 8
          CoverMenu = PopDesigner
          FixPosition = False
          FixSize = False
          OnDeleteQuery = DsnStage0DeleteQuery
          OnSelectQuery = DsnStage0SelectQuery
          OnMoveQuery = DsnStage0MoveQuery
          OnControlCreate = DsnStage0ControlCreate
        end
      end
      object TabPaginas: TTabSet
        Left = 0
        Top = 256
        Width = 571
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        PopupMenu = PopPaginas
        OnClick = TabPaginasClick
      end
      object PgPagina1: TScrollBox
        Left = 0
        Top = 0
        Width = 571
        Height = 256
        Align = alClient
        BorderStyle = bsNone
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object NoManutencao: TNotebook
          Left = 0
          Top = 0
          Width = 571
          Height = 256
          Align = alClient
          TabOrder = 0
          object PgPrincipal: TPage
            Left = 0
            Top = 0
            Caption = 'Principal'
            object Pagina0: TScrollBox
              Left = 0
              Top = 0
              Width = 571
              Height = 256
              Align = alClient
              AutoScroll = False
              BorderStyle = bsNone
              TabOrder = 0
              object DsnStage0: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                HelpContext = 220
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
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
              object DsnStage1: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage2: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage3: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage4: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage5: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage6: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage7: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage8: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage9: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
              object DsnStage10: TDsnStage
                Left = 0
                Top = 0
                Width = 571
                Height = 256
                Align = alClient
                AutoScroll = False
                BorderStyle = bsNone
                TabOrder = 0
                OnMouseDown = DsnStage0MouseDown
                Rubberband.Color = clGray
                Rubberband.PenWidth = 2
                Rubberband.MoveWidth = 8
                Rubberband.MoveHeight = 8
                CoverMenu = PopDesigner
                FixPosition = False
                FixSize = False
                OnDeleteQuery = DsnStage0DeleteQuery
                OnSelectQuery = DsnStage0SelectQuery
                OnMoveQuery = DsnStage0MoveQuery
                OnControlCreate = DsnStage0ControlCreate
              end
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
        Top = 277
        Width = 571
        Height = 31
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object DsnStage_Cnt: TDsnStage
          Left = 0
          Top = 0
          Width = 571
          Height = 31
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 0
          OnMouseDown = DsnStage0MouseDown
          Rubberband.Color = clGray
          Rubberband.PenWidth = 2
          Rubberband.MoveWidth = 8
          Rubberband.MoveHeight = 8
          CoverMenu = PopDesigner
          FixPosition = False
          FixSize = False
          OnDeleteQuery = DsnStage0DeleteQuery
          OnSelectQuery = DsnStage0SelectQuery
          OnMoveQuery = DsnStage0MoveQuery
          OnControlCreate = DsnStage0ControlCreate
        end
      end
      object GridConsulta: TDBGrid
        Left = 0
        Top = 0
        Width = 571
        Height = 256
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
      end
      object AbaConsulta: TTabSet
        Left = 0
        Top = 256
        Width = 571
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
      end
    end
  end
  object PnSup: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object ShapeSup: TShape
      Left = 0
      Top = 0
      Width = 579
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
      Width = 579
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
      Left = 542
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
      Visible = False
    end
    object BtnFechar: TSpeedButton
      Left = 560
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
      Visible = False
    end
  end
  object BarraPrincipal: TPanel
    Left = 0
    Top = 20
    Width = 579
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object GradientePaint: TXBanner
      Left = 0
      Top = 0
      Width = 579
      Height = 30
      Align = alClient
      Angle = 0
      ColorOf = 2966387
      ColorFor = 14083055
      Horizontal = True
      ShadeLTSet = False
      Style3D = A3dNormal
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
  object TextoTXT: TSynEdit
    Left = 489
    Top = 352
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
    TabOrder = 3
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
    Left = 489
    Top = 368
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
  object DsnSelect: TDsnSelect
    DsnRegister = DsnRegister
    OnChangeSelected = DsnSelectChangeSelected
    Left = 328
    Top = 355
  end
  object PopDesigner: TPopupMenu
    Images = FormPrincipal.ListaImagem
    Left = 361
    Top = 355
    object Dsg_NovaPagina: TMenuItem
      Caption = 'Nova Página'
      Visible = False
      OnClick = Dsg_NovaPaginaClick
    end
    object Divisao_NvPg: TMenuItem
      Caption = '-'
      Visible = False
    end
    object Dsg_Enviarparafrente: TMenuItem
      Caption = 'Enviar para frente'
      ImageIndex = 94
      OnClick = Dsg_EnviarparafrenteClick
    end
    object Dsg_Enviarparatras: TMenuItem
      Caption = 'Enviar para trás'
      ImageIndex = 95
      OnClick = Dsg_EnviarparatrasClick
    end
    object Dsg_N3: TMenuItem
      Caption = '-'
    end
    object Dsg_Alinhamento_obj: TMenuItem
      Caption = 'Alinhamento ...'
      OnClick = Dsg_Alinhamento_objClick
    end
    object Dsg_Dimensoes_obj: TMenuItem
      Caption = 'Tamanho ...'
      OnClick = Dsg_Dimensoes_objClick
    end
    object Dsg_SequnciaTabOrder1: TMenuItem
      Caption = 'Sequência '#39'Tab Order'#39
      OnClick = Dsg_SequnciaTabOrder1Click
    end
    object Dsg_N1: TMenuItem
      Caption = '-'
    end
    object Dsg_Recortar1: TMenuItem
      Caption = 'Recortar'
      ImageIndex = 28
      ShortCut = 16472
      OnClick = Dsg_Recortar1Click
    end
    object Dsg_Copiar1: TMenuItem
      Caption = 'Copiar'
      ImageIndex = 7
      ShortCut = 16451
      OnClick = Dsg_Copiar1Click
    end
    object Dsg_Colar1: TMenuItem
      Caption = 'Colar'
      ImageIndex = 5
      ShortCut = 16470
      OnClick = Dsg_Colar1Click
    end
    object Dsg_SelecionarTodos1: TMenuItem
      Caption = 'Selecionar Tudo'
      ImageIndex = 87
      ShortCut = 16449
      OnClick = Dsg_SelecionarTodos1Click
    end
    object Dsg_N2: TMenuItem
      Caption = '-'
    end
    object Dsg_Excluir1: TMenuItem
      Caption = 'Excluir'
      ImageIndex = 58
      ShortCut = 46
      OnClick = Dsg_Excluir1Click
    end
  end
  object PopPaginas: TPopupMenu
    Left = 394
    Top = 355
    object Tabs_NvPg: TMenuItem
      Caption = 'Nova página'
      OnClick = Tabs_NvPgClick
    end
    object Tabs_RnPg: TMenuItem
      Caption = 'Renomear'
      OnClick = Tabs_RnPgClick
    end
    object Tabs_ExPg: TMenuItem
      Caption = 'Excluir página'
      OnClick = Tabs_ExPgClick
    end
  end
  object PopConsulta: TPopupMenu
    Left = 252
    Top = 354
  end
  object DataSource: TDataSource
    Left = 204
    Top = 355
  end
  object DsnRegister: TDsn8Register
    DsnStage = DsnStage0
    Left = 292
    Top = 354
  end
end
