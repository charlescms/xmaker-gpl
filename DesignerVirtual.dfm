object FormDesignerVirtual: TFormDesignerVirtual
  Left = 307
  Top = 153
  Width = 671
  Height = 455
  Caption = 'Layout'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter_L: TSplitter
    Left = 150
    Top = 0
    Width = 2
    Height = 428
    Cursor = crHSplit
  end
  object PnFundo: TPanel
    Left = 152
    Top = 0
    Width = 511
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl_Forms: TPageControl
      Left = 0
      Top = 0
      Width = 511
      Height = 375
      Align = alClient
      HotTrack = True
      Style = tsFlatButtons
      TabOrder = 0
    end
    object PnInferior: TPanel
      Left = 0
      Top = 375
      Width = 511
      Height = 53
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object ListView_nao_visuais: TListView
        Left = 4
        Top = 0
        Width = 503
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
        Left = 507
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
        Width = 511
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
      end
    end
  end
  object PnFundo_L: TPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 428
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter_D_J: TSplitter
      Left = 1
      Top = 168
      Width = 148
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object PageControl_ObjInsp: TPageControl
      Left = 1
      Top = 186
      Width = 148
      Height = 241
      ActivePage = TabSheet_Object
      Align = alClient
      HotTrack = True
      Style = tsButtons
      TabOrder = 0
      OnEnter = PageControl_ObjInspEnter
      OnExit = PageControl_ObjInspExit
      OnResize = PageControl_ObjInspResize
      object TabSheet_Object: TTabSheet
        Caption = 'Object Inspector'
        object Box: TScrollBox
          Left = 0
          Top = 35
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
          Left = 0
          Top = 0
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
    object Pn_Barra_S_00: TPanel
      Left = 1
      Top = 1
      Width = 148
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      OnResize = Pn_Barra_S_00Resize
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
    object Pn_Barra_I_00: TPanel
      Left = 1
      Top = 170
      Width = 148
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      OnResize = Pn_Barra_I_00Resize
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
    object PageControl_Objetos: TPageControl
      Left = 1
      Top = 17
      Width = 148
      Height = 151
      ActivePage = TabSheet_Comp
      Align = alTop
      Style = tsButtons
      TabOrder = 3
      object TabSheet_Comp: TTabSheet
        Caption = 'Objetos Visuais'
        object TreeView_Objetos: TTreeView
          Left = 0
          Top = 0
          Width = 140
          Height = 120
          Align = alClient
          Indent = 19
          TabOrder = 0
        end
      end
    end
  end
  object PopDesigner: TPopupMenu
    Left = 10
    Top = 376
    object MnuPaginas: TMenuItem
      Caption = 'Páginas'
      Checked = True
    end
    object RodapeMnt: TMenuItem
      Caption = 'Rodapé - Manutenção'
    end
    object RodapeCns: TMenuItem
      Caption = 'Rodapé - Consulta'
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 38
    Top = 376
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Left = 68
    Top = 376
  end
  object PopFormStyle: TPopupMenu
    Left = 104
    Top = 376
    object dsg_Normal: TMenuItem
      Caption = 'Normal'
      Checked = True
    end
    object dsg_Maximizada: TMenuItem
      Caption = 'Maximizada'
    end
    object dsg_Minimizada: TMenuItem
      Caption = 'Minimizada'
    end
  end
end
