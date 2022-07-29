object FormObjInsp: TFormObjInsp
  Left = 291
  Top = 193
  Width = 186
  Height = 374
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Propriedades'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvTabBar2: TJvTabBar
    Left = 0
    Top = 52
    Width = 178
    CloseButton = False
    Tabs = <
      item
        Caption = 'Propriedades do Objeto'
      end>
  end
  object PnComboObjects: TPanel
    Left = 0
    Top = 79
    Width = 178
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object CB1: TComboBox
      Left = 9
      Top = 0
      Width = 104
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnKeyDown = CB1KeyDown
    end
  end
  object Panel12: TPanel
    Left = 0
    Top = 75
    Width = 178
    Height = 4
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel13: TPanel
    Left = 0
    Top = 105
    Width = 4
    Height = 231
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel14: TPanel
    Left = 174
    Top = 105
    Width = 4
    Height = 231
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
  end
  object Panel15: TPanel
    Left = 0
    Top = 336
    Width = 178
    Height = 4
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
  end
  object PnFormObjInsp: TPanel
    Left = 4
    Top = 105
    Width = 170
    Height = 231
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object Box: TScrollBox
      Left = 0
      Top = 2
      Width = 127
      Height = 177
      HorzScrollBar.Visible = False
      BorderStyle = bsNone
      Color = clWindow
      ParentColor = False
      TabOrder = 0
      object PaintBox1: TPaintBox
        Left = 0
        Top = 0
        Width = 127
        Height = 177
        Align = alClient
        Color = clBtnFace
        ParentColor = False
        OnDblClick = PaintBox1DblClick
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnMouseUp = PaintBox1MouseUp
        OnPaint = PaintBox1Paint
      end
      object Edit1: TEdit
        Left = 12
        Top = 56
        Width = 86
        Height = 14
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'Edit1'
        Visible = False
        OnChange = Edit1Change
        OnDblClick = Edit1DblClick
        OnKeyDown = Edit1KeyDown
        OnKeyPress = Edit1KeyPress
        OnMouseDown = Edit1MouseDown
      end
      object EditPanel: TPanel
        Left = 60
        Top = 88
        Width = 14
        Height = 14
        Caption = 'EditPanel'
        TabOrder = 1
        object EditBtn: TSpeedButton
          Left = 0
          Top = 0
          Width = 14
          Height = 14
          Glyph.Data = {
            96000000424D960000000000000076000000280000000A000000040000000100
            0400000000002000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
            0000800800800800000080080080080000008888888888000000}
          OnClick = EditBtnClick
        end
      end
      object ComboPanel: TPanel
        Left = 84
        Top = 88
        Width = 14
        Height = 14
        Caption = 'ComboPanel'
        TabOrder = 2
        object ComboBtn: TSpeedButton
          Left = 0
          Top = 0
          Width = 14
          Height = 14
          Glyph.Data = {
            C6000000424DC60000000000000076000000280000000A0000000A0000000100
            0400000000005000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
            0000888888888800000088888888880000008888088888000000888000888800
            0000880000088800000080000000880000008888888888000000888888888800
            00008888888888000000}
          OnClick = ComboBtnClick
        end
      end
    end
  end
  object ControlBar2: TControlBar
    Left = 0
    Top = 0
    Width = 178
    Height = 52
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelKind = bkNone
    TabOrder = 7
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 97
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = FormPrincipal.ListaImagem
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object BtnFormFilho: TToolButton
        Left = 0
        Top = 0
        Hint = 'Grid de relacionamento'
        Caption = 'BtnFormFilho'
        ImageIndex = 25
        OnClick = BtnFormFilhoClick
      end
      object BtnCampo: TToolButton
        Left = 23
        Top = 0
        Hint = 'Inserir campo da tabela'
        Caption = 'BtnCampo'
        ImageIndex = 89
        OnClick = BtnCampoClick
      end
      object BtnFormatar: TToolButton
        Left = 46
        Top = 0
        Hint = 'Auto formatar tela'
        Caption = 'BtnFormatar'
        ImageIndex = 91
        OnClick = BtnFormatarClick
      end
      object BtnPropriedades: TToolButton
        Left = 69
        Top = 0
        Hint = 'Propriedades'
        ImageIndex = 116
        OnClick = BtnPropriedadesClick
      end
    end
    object ToolBar1: TToolBar
      Left = 11
      Top = 28
      Width = 159
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = FormPrincipal.ListaImagem
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object BtnOrdemTab: TToolButton
        Left = 0
        Top = 0
        Hint = 'Define a ordem dos campos (Enter/Tab)'
        Caption = 'BtnOrdemTab'
        ImageIndex = 92
        OnClick = BtnOrdemTabClick
      end
      object BtnBloquear: TToolButton
        Left = 23
        Top = 0
        Hint = 'Bloquear componente'
        Caption = 'BtnBloquear'
        ImageIndex = 73
        Style = tbsCheck
        OnClick = BtnBloquearClick
      end
      object BtnPaginas: TToolButton
        Left = 46
        Top = 0
        Hint = 'Define p'#225'ginas'
        Caption = 'BtnPaginas'
        DropdownMenu = PopupPaginas
        ImageIndex = 93
        Style = tbsDropDown
        OnClick = BtnPaginasClick
      end
      object BtnWinState: TToolButton
        Left = 82
        Top = 0
        Hint = 'Estilo do formul'#225'rio (WindowState)'
        Caption = 'BtnWinState'
        DropdownMenu = PopState
        ImageIndex = 117
        Style = tbsDropDown
        OnClick = BtnWinStateClick
      end
      object BtnPosition: TToolButton
        Left = 118
        Top = 0
        Hint = 'Posi'#231#227'o do formul'#225'rio'
        Caption = 'BtnPosition'
        DropdownMenu = PopPosition
        ImageIndex = 118
        Style = tbsDropDown
        OnClick = BtnPositionClick
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 46
    Top = 312
  end
  object ColorDialog: TColorDialog
    Left = 76
    Top = 312
  end
  object JvModernTabBarPainter1: TJvModernTabBarPainter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DisabledFont.Charset = DEFAULT_CHARSET
    DisabledFont.Color = clGrayText
    DisabledFont.Height = -11
    DisabledFont.Name = 'MS Sans Serif'
    DisabledFont.Style = []
    SelectedFont.Charset = DEFAULT_CHARSET
    SelectedFont.Color = clBlue
    SelectedFont.Height = -11
    SelectedFont.Name = 'MS Sans Serif'
    SelectedFont.Style = []
    Left = 121
    Top = 309
  end
  object PopupPaginas: TPopupMenu
    OnPopup = PopupPaginasPopup
    Left = 4
    Top = 286
  end
  object PopState: TPopupMenu
    OnPopup = PopStatePopup
    Left = 140
    Top = 142
    object Normal1: TMenuItem
      Caption = 'Normal'
      OnClick = Normal1Click
    end
    object Maximizado1: TMenuItem
      Tag = 1
      Caption = 'Maximizado'
      OnClick = Normal1Click
    end
    object Minimizado1: TMenuItem
      Tag = 2
      Caption = 'Minimizado'
      OnClick = Normal1Click
    end
  end
  object PopPosition: TPopupMenu
    OnPopup = PopPositionPopup
    Left = 140
    Top = 174
    object Posicao_Padrao: TMenuItem
      Caption = 'Padr'#227'o'
      OnClick = Posicao_PadraoClick
    end
    object Posicao_Centralizado: TMenuItem
      Tag = 1
      Caption = 'Centralizado'
      OnClick = Posicao_PadraoClick
    end
  end
end
