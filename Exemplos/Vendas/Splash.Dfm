object FormSplash: TFormSplash
  Left = 252
  Top = 158
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Inicializando...'
  ClientHeight = 345
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Moldura: TBevel
    Left = 3
    Top = 3
    Width = 374
    Height = 284
  end
  object ImagemApresentacao: TImage
    Left = 8
    Top = 8
    Width = 363
    Height = 274
    AutoSize = False
    Center = True
    Stretch = True
    Transparent = True
  end
  object LbTitulo: TLabel
    Left = 8
    Top = 330
    Width = 75
    Height = 13
    Caption = 'Abrindo Tabela:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object PanelGauge: TPanel
    Left = 8
    Top = 292
    Width = 362
    Height = 33
    TabOrder = 0
  end
  object GaugeProcesso: TProgressBar
    Left = 16
    Top = 300
    Width = 346
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 1
  end
end
