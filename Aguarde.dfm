object FormAguarde: TFormAguarde
  Left = 262
  Top = 245
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Aguarde !, ...'
  ClientHeight = 48
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LbTitulo: TLabel
    Left = 8
    Top = 5
    Width = 13
    Height = 13
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GaugeProcesso: TProgressBar
    Left = 8
    Top = 24
    Width = 345
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 0
  end
end
