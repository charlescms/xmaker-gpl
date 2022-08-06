object FormAguarde: TFormAguarde
  Left = 203
  Top = 245
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Aguarde !, ...'
  ClientHeight = 65
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LbTitulo: TLabel
    Left = 8
    Top = 48
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
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 345
    Height = 33
    TabOrder = 0
  end
  object GaugeProcesso: TProgressBar
    Left = 16
    Top = 16
    Width = 329
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 1
  end
end
