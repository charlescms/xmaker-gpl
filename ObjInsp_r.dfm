object FormObjInsp_rel: TFormObjInsp_rel
  Left = 298
  Top = 213
  Width = 289
  Height = 374
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Object Inspector'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
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
  object Box: TScrollBox
    Left = 0
    Top = 52
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
    Top = 28
    Width = 127
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnKeyDown = CB1KeyDown
  end
  object ControlBar2: TControlBar
    Left = 0
    Top = 0
    Width = 273
    Height = 29
    Align = alTop
    BevelInner = bvNone
    BevelKind = bkFlat
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 148
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = FormPrincipal.ListaImagem
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object BtnFonte: TToolButton
        Left = 0
        Top = 0
        Hint = 'Editar arquivo fonte'
        Caption = 'BtnFonte'
        ImageIndex = 2
        OnClick = BtnFonteClick
      end
      object BtnOrdemTab: TToolButton
        Left = 23
        Top = 0
        Hint = 'Define a ordem dos campos (Enter/Tab)'
        Caption = 'BtnOrdemTab'
        ImageIndex = 92
        OnClick = BtnOrdemTabClick
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
end
