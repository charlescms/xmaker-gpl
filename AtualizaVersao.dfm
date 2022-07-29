object FormAtualizaVersao: TFormAtualizaVersao
  Left = 295
  Top = 214
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Atualização de Versão'
  ClientHeight = 102
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 9
    Top = 7
    Width = 305
    Height = 89
  end
  object LbModulo: TLabel
    Left = 16
    Top = 15
    Width = 38
    Height = 13
    Caption = 'Módulo:'
  end
  object LbRegistro: TLabel
    Left = 16
    Top = 55
    Width = 42
    Height = 13
    Caption = 'Registro:'
  end
  object Progresso1: TProgressBar
    Left = 16
    Top = 31
    Width = 289
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object Progresso2: TProgressBar
    Left = 16
    Top = 71
    Width = 289
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 1
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 256
    Top = 16
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer2Timer
    Left = 200
    Top = 16
  end
  object Query: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    Left = 128
    Top = 24
  end
end
