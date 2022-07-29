object FormDesigner: TFormDesigner
  Left = 161
  Top = 124
  Width = 771
  Height = 505
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Object Inspector'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poDefault
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter_L: TSplitter
    Left = 189
    Top = 30
    Width = 2
    Height = 448
    Cursor = crHSplit
    AutoSnap = False
    MinSize = 90
    OnMoved = Splitter_LMoved
  end
  object ControlBar2: TControlBar
    Left = 0
    Top = 0
    Width = 763
    Height = 28
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelKind = bkFlat
    TabOrder = 0
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 132
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = FormPrincipal.ListaImagem
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object BtnSalvar: TToolButton
        Left = 0
        Top = 0
        Hint = 'Salvar formulário'
        Caption = 'BtnSalvar'
        ImageIndex = 21
        OnClick = BtnSalvarClick
      end
      object BtnStyle: TToolButton
        Left = 23
        Top = 0
        Hint = 'Estilo da janela'
        Caption = 'BtnStyle'
        DropdownMenu = PopFormStyle
        ImageIndex = 50
        Style = tbsDropDown
        OnClick = BtnStyleClick
      end
      object BtnFormFilho: TToolButton
        Left = 59
        Top = 0
        Hint = 'Grid de relacionamento'
        Caption = 'BtnFormFilho'
        ImageIndex = 25
        OnClick = BtnFormFilhoClick
      end
      object BtnCampo: TToolButton
        Left = 82
        Top = 0
        Hint = 'Inserir campo da tabela'
        Caption = 'BtnCampo'
        ImageIndex = 89
        OnClick = BtnCampoClick
      end
      object BtnFormatar: TToolButton
        Left = 105
        Top = 0
        Hint = 'Auto formatar tela'
        Caption = 'BtnFormatar'
        ImageIndex = 91
        OnClick = BtnFormatarClick
      end
    end
    object ToolBar1: TToolBar
      Left = 156
      Top = 2
      Width = 186
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = FormPrincipal.ListaImagem
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object BtnUnits: TToolButton
        Left = 0
        Top = 0
        Hint = 'Fontes (Unit)'
        Caption = 'BtnUnits'
        ImageIndex = 108
      end
      object BtnForms: TToolButton
        Left = 23
        Top = 0
        Hint = 'Formulários'
        Caption = 'BtnForms'
        ImageIndex = 107
        OnClick = BtnFormsClick
      end
      object BtnFonte: TToolButton
        Left = 46
        Top = 0
        Hint = 'Editar arquivo fonte'
        Caption = 'BtnFonte'
        ImageIndex = 2
        OnClick = BtnFonteClick
      end
      object BtnNewForm: TToolButton
        Left = 69
        Top = 0
        Hint = 'Novo formulário'
        Caption = 'BtnNewForm'
        ImageIndex = 109
      end
      object BtnOrdemTab: TToolButton
        Left = 92
        Top = 0
        Hint = 'Define a ordem dos campos (Enter/Tab)'
        Caption = 'BtnOrdemTab'
        ImageIndex = 92
        OnClick = BtnOrdemTabClick
      end
      object BtnPaginas: TToolButton
        Left = 115
        Top = 0
        Hint = 'Define páginas'
        Caption = 'BtnPaginas'
        ImageIndex = 93
        OnClick = BtnPaginasClick
      end
      object ToolButton3: TToolButton
        Left = 138
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 94
        Style = tbsSeparator
      end
      object BtnDesigner: TToolButton
        Left = 146
        Top = 0
        Hint = 'Área de designer'
        Caption = 'BtnDesigner'
        DropdownMenu = PopDesigner
        ImageIndex = 96
        Style = tbsDropDown
        OnClick = BtnDesignerClick
      end
    end
  end
  object PnFundo_L: TPanel
    Left = 0
    Top = 30
    Width = 189
    Height = 448
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 1
    OnResize = PnFundo_LResize
    object Splitter_D_J: TSplitter
      Left = 1
      Top = 165
      Width = 187
      Height = 2
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      MinSize = 90
      OnMoved = Splitter_LMoved
    end
    object PnFundo_L_I: TPanel
      Left = 1
      Top = 167
      Width = 187
      Height = 280
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Pn_Barra_I_00: TPanel
        Left = 0
        Top = 0
        Width = 187
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Btn_I_F: TSpeedButton
          Left = 136
          Top = 3
          Width = 10
          Height = 10
          Hint = 'Fechar'
          Font.Charset = ANSI_CHARSET
          Font.Color = 4802889
          Font.Height = -7
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            92000000424D9200000000000000760000002800000007000000070000000100
            0400000000001C00000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888808888
            88800888088080808880880888808080888008880880}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = Btn_I_FClick
        end
        object Pn_Barra_I_01: TPanel
          Left = 1
          Top = 4
          Width = 133
          Height = 3
          TabOrder = 0
        end
        object Pn_Barra_I_02: TPanel
          Left = 1
          Top = 8
          Width = 133
          Height = 3
          TabOrder = 1
        end
      end
      object PageControl_ObjInsp: TPageControl
        Left = 0
        Top = 16
        Width = 187
        Height = 264
        ActivePage = TabSheet_Object
        Align = alClient
        HotTrack = True
        Style = tsButtons
        TabOrder = 1
        object TabSheet_Object: TTabSheet
          Caption = 'Propriedades'
          object Box: TScrollBox
            Left = 1
            Top = 28
            Width = 127
            Height = 177
            HorzScrollBar.Visible = False
            Color = clWindow
            ParentColor = False
            TabOrder = 0
            object PaintBox1: TPaintBox
              Left = 0
              Top = 0
              Width = 123
              Height = 173
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
          object CB1: TComboBox
            Left = 1
            Top = 2
            Width = 127
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            Sorted = True
            TabOrder = 1
            OnKeyDown = CB1KeyDown
          end
        end
      end
    end
    object PnFundo_L_S: TPanel
      Left = 1
      Top = 1
      Width = 187
      Height = 164
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Pn_Barra_S_00: TPanel
        Left = 0
        Top = 0
        Width = 187
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Btn_S_F: TSpeedButton
          Left = 136
          Top = 3
          Width = 10
          Height = 10
          Hint = 'Fechar'
          Font.Charset = ANSI_CHARSET
          Font.Color = 4802889
          Font.Height = -7
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            92000000424D9200000000000000760000002800000007000000070000000100
            0400000000001C00000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888808888
            88800888088080808880880888808080888008880880}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = Btn_S_FClick
        end
        object Pn_Barra_S_01: TPanel
          Left = 1
          Top = 4
          Width = 133
          Height = 3
          TabOrder = 0
        end
        object Pn_Barra_S_02: TPanel
          Left = 1
          Top = 8
          Width = 133
          Height = 3
          TabOrder = 1
        end
      end
      object PageControl_Objetos: TPageControl
        Left = 0
        Top = 16
        Width = 187
        Height = 148
        ActivePage = TabSheet_Comp
        Align = alClient
        Style = tsButtons
        TabOrder = 1
        object TabSheet_Comp: TTabSheet
          Caption = 'Objetos Visuais'
          object TreeView_Objetos: TTreeView
            Left = 0
            Top = 0
            Width = 179
            Height = 117
            Align = alClient
            Indent = 19
            TabOrder = 0
          end
        end
      end
    end
  end
  object PnFundo: TPanel
    Left = 191
    Top = 30
    Width = 572
    Height = 448
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object PageControl_Forms: TPageControl
      Left = 0
      Top = 0
      Width = 572
      Height = 395
      Align = alClient
      HotTrack = True
      Style = tsFlatButtons
      TabOrder = 0
    end
    object PnInferior: TPanel
      Left = 0
      Top = 395
      Width = 572
      Height = 53
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object ListView_nao_visuais: TListView
        Left = 4
        Top = 0
        Width = 564
        Height = 51
        Align = alClient
        BorderStyle = bsNone
        Color = clInfoBk
        Columns = <>
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 4
        Height = 51
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 568
        Top = 0
        Width = 4
        Height = 51
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
      end
      object Panel4: TPanel
        Left = 0
        Top = 51
        Width = 572
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
      end
    end
  end
  object PnSuperior: TPanel
    Left = 0
    Top = 28
    Width = 763
    Height = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 40
    Top = 440
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Left = 68
    Top = 440
  end
  object PopDesigner: TPopupMenu
    Left = 12
    Top = 440
    object MnuPaginas: TMenuItem
      Caption = 'Páginas'
      Checked = True
      OnClick = MnuPaginasClick
    end
    object RodapeMnt: TMenuItem
      Caption = 'Rodapé - Manutenção'
      OnClick = RodapeMntClick
    end
    object RodapeCns: TMenuItem
      Caption = 'Rodapé - Consulta'
      OnClick = RodapeCnsClick
    end
  end
  object PopFormStyle: TPopupMenu
    Left = 96
    Top = 440
    object dsg_Normal: TMenuItem
      Caption = 'Normal'
      Checked = True
      OnClick = dsg_NormalClick
    end
    object dsg_Maximizada: TMenuItem
      Caption = 'Maximizada'
      OnClick = dsg_MaximizadaClick
    end
    object dsg_Minimizada: TMenuItem
      Caption = 'Minimizada'
      OnClick = dsg_MinimizadaClick
    end
  end
end
