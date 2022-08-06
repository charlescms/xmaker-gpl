object FormGridPesquisa: TFormGridPesquisa
  Left = 200
  Top = 209
  Width = 650
  Height = 314
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Pesquisa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnSup: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object ShapeSup: TShape
      Left = 0
      Top = 0
      Width = 642
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
      Width = 642
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
  end
  object GridConsulta: TDBGrid
    Left = 0
    Top = 20
    Width = 642
    Height = 212
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = GridConsultaDblClick
    OnKeyDown = GridConsultaKeyDown
  end
  object PnRodape: TPanel
    Left = 0
    Top = 232
    Width = 642
    Height = 55
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object LbPesquisa: TLabel
      Left = 4
      Top = 16
      Width = 70
      Height = 13
      Caption = 'Pesquisar por: '
    end
    object LbOperador: TLabel
      Left = 397
      Top = 16
      Width = 44
      Height = 13
      Caption = 'Operador'
    end
    object LbAcao: TLabel
      Left = 525
      Top = 16
      Width = 75
      Height = 13
      Caption = 'Pesquisar após:'
    end
    object BtnOrdem: TSpeedButton
      Left = 378
      Top = 31
      Width = 16
      Height = 18
      Hint = 'Alterar ordenação'
      Glyph.Data = {
        96000000424D960000000000000076000000280000000A000000040000000100
        0400000000002000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
        0000800800800800000080080080080000008888888888000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnOrdemClick
    end
    object LbTransportar: TLabel
      Left = 1
      Top = 1
      Width = 640
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Tecle: F8 para selecionar ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object EdPesquisa: TComboBox
      Left = 4
      Top = 30
      Width = 371
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = EdPesquisaChange
      OnKeyDown = EdPesquisaKeyDown
    end
    object EdOperador: TComboBox
      Left = 397
      Top = 30
      Width = 124
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnClick = EdOperadorClick
      OnKeyDown = GridConsultaKeyDown
      Items.Strings = (
        '=   Igual'
        '<> Diferente'
        '<   Menor que'
        '<= Menor ou Igual'
        '>   Maior que'
        '>= Maior ou Igual'
        '%  Contém'
        '?   Vazio')
    end
    object EdEstilo: TComboBox
      Left = 525
      Top = 30
      Width = 116
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnClick = EdEstiloClick
      OnKeyDown = GridConsultaKeyDown
      Items.Strings = (
        'Cada caractere'
        'Enter')
    end
  end
  object DataSource: TDataSource
    Left = 328
    Top = 80
  end
end
