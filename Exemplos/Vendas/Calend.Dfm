object FormCalendario: TFormCalendario
  Left = 239
  Top = 177
  Width = 220
  Height = 319
  BorderStyle = bsSizeToolWin
  Caption = 'Calendário'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelDias: TPanel
    Left = 0
    Top = 54
    Width = 212
    Height = 120
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object VCalend: TCalendar
      Left = 1
      Top = 1
      Width = 210
      Height = 118
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      GridLineWidth = 0
      ParentFont = False
      StartOfWeek = 0
      TabOrder = 0
      UseCurrentDate = False
      OnClick = VCalendClick
      OnKeyPress = FormKeyPress
    end
    object AlternaMes: TUpDown
      Left = 181
      Top = 98
      Width = 28
      Height = 18
      Hint = 'Incrementa / Decrementa mês'
      Min = -1000
      Max = 1000
      Orientation = udHorizontal
      ParentShowHint = False
      Position = 1
      ShowHint = True
      TabOrder = 1
      Wrap = False
      OnClick = AlternaMesClick
    end
  end
  object PanelMes: TPanel
    Left = 0
    Top = 28
    Width = 212
    Height = 26
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Janeiro'
    Color = 14548735
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = VCalendClick
    object GetAno: TSpinEdit
      Left = 157
      Top = 2
      Width = 53
      Height = 22
      Hint = 'Define ano'
      Color = 14548735
      Ctl3D = False
      MaxValue = 9000
      MinValue = 1
      ParentCtl3D = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 1
      OnChange = GetAnoChange
      OnClick = VCalendClick
      OnKeyPress = FormKeyPress
    end
  end
  object PanelExtra: TPanel
    Left = 0
    Top = 175
    Width = 212
    Height = 117
    Align = alBottom
    TabOrder = 2
    object LbTitulo: TLabel
      Left = 4
      Top = 4
      Width = 205
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Titulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object LbDias: TLabel
      Left = 4
      Top = 27
      Width = 44
      Height = 13
      Caption = 'Qtd. Dias'
      Transparent = True
    end
    object LbPeriodo: TLabel
      Left = 4
      Top = 28
      Width = 38
      Height = 13
      Caption = 'Período'
      Transparent = True
    end
    object LbTDias: TLabel
      Left = 4
      Top = 51
      Width = 21
      Height = 13
      Caption = 'Dias'
      Transparent = True
    end
    object LbTMeses: TLabel
      Left = 4
      Top = 73
      Width = 31
      Height = 13
      Caption = 'Meses'
      Transparent = True
    end
    object LbTAnos: TLabel
      Left = 4
      Top = 95
      Width = 30
      Height = 13
      Caption = 'Ano(s)'
      Transparent = True
    end
    object EdDias: TEdit
      Left = 54
      Top = 24
      Width = 43
      Height = 21
      MaxLength = 5
      TabOrder = 0
      OnExit = EdDiasExit
    end
    object Dt_i: TMaskEdit
      Left = 54
      Top = 24
      Width = 57
      Height = 21
      EditMask = '!99/99/00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 1
      Text = '  /  /  '
    end
    object Dt_f: TMaskEdit
      Left = 118
      Top = 24
      Width = 57
      Height = 21
      EditMask = '!99/99/00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      Text = '  /  /  '
      OnExit = Dt_fExit
    end
    object EdR_Dias: TEdit
      Left = 54
      Top = 47
      Width = 58
      Height = 21
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object EdR_Meses: TEdit
      Left = 54
      Top = 69
      Width = 58
      Height = 21
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object EdR_Anos: TEdit
      Left = 54
      Top = 91
      Width = 58
      Height = 21
      TabStop = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object BtnOk: TBitBtn
      Left = 133
      Top = 88
      Width = 75
      Height = 25
      Caption = '&Ok'
      TabOrder = 6
      OnClick = VCalendClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888448888888888888888888888888888842248888
        8888888888888888888888842222488888888888888888888888884222222488
        8888888888888888888884222A222248888888888888888888888222A8A22248
        888888888888888888888A2A888A22248888888888888888888888A88888A222
        48888888888888888888888888888A22248888888888888888888888888888A2
        2248888888888888888888888888888A22248888888888888888888888888888
        A22248888888888888888888888888888A224888888888888888888888888888
        88A22888888888888888888888888888888A8888888888888888}
      NumGlyphs = 2
    end
  end
  object PnBotoes: TPanel
    Left = 0
    Top = 0
    Width = 212
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Futura: TSpeedButton
      Left = 3
      Top = 2
      Width = 65
      Height = 22
      Hint = 'Data futura'
      Caption = '&Futura'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = FuturaClick
    end
    object Calculo: TSpeedButton
      Left = 72
      Top = 2
      Width = 65
      Height = 22
      Hint = 'Cálculo entre datas'
      Caption = '&Cálculo'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333FFFFFFFFFFF33330000000000
        03333377777777777F33333003333330033333377FF333377F33333300333333
        0333333377FF33337F3333333003333303333333377FF3337333333333003333
        333333333377FF3333333333333003333333333333377FF33333333333330033
        3333333333337733333333333330033333333333333773333333333333003333
        33333333337733333F3333333003333303333333377333337F33333300333333
        03333333773333337F33333003333330033333377FFFFFF77F33330000000000
        0333337777777777733333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = CalculoClick
    end
  end
end
