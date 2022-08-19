object FrmDateEdit: TFrmDateEdit
  Left = 261
  Top = 215
  BorderStyle = bsNone
  Caption = '...'
  ClientHeight = 202
  ClientWidth = 275
  Color = 4194304
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 144
  TextHeight = 20
  object PanBack: TPanel
    Left = 0
    Top = 0
    Width = 275
    Height = 202
    BorderWidth = 1
    TabOrder = 0
    object StrGrid: TStringGrid
      Left = 2
      Top = 27
      Width = 271
      Height = 173
      Align = alClient
      BorderStyle = bsNone
      ColCount = 7
      Ctl3D = False
      DefaultColWidth = 25
      DefaultRowHeight = 15
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 7
      Options = [goFixedHorzLine, goTabs]
      ParentCtl3D = False
      ScrollBars = ssNone
      TabOrder = 0
      OnClick = StrGridClick
      OnDblClick = StrGridDblClick
      OnDrawCell = StrGridDrawCell
      OnKeyPress = StrGridKeyPress
      OnMouseDown = PanMonthMouseDown
      OnMouseMove = PanMonthMouseMove
      ColWidths = (
        25
        25
        25
        25
        25
        25
        25)
    end
    object PanMonth: TPanel
      Left = 2
      Top = 2
      Width = 271
      Height = 25
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      BorderWidth = 3
      Caption = 'Janeiro/2000'
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCaptionText
      Font.Height = -18
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnMouseDown = PanMonthMouseDown
      OnMouseMove = PanMonthMouseMove
      object BtnClose: TSpeedButton
        Left = 246
        Top = 3
        Width = 22
        Height = 20
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777700
          0000777777777700000070077770070000007700770077000000777000077700
          0000777700777700000077700007770000007700770077000000700777700700
          00007777777777000000}
        OnClick = BtnCloseClick
      end
      object UpDownMonth: TUpDown
        Left = 197
        Top = 3
        Width = 46
        Height = 20
        Min = -1000
        Max = 1000
        Orientation = udHorizontal
        TabOrder = 0
        OnClick = UpDownMonthClick
      end
    end
  end
end
