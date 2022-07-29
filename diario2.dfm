object FormDiario: TFormDiario
  Left = 223
  Top = 172
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Diário do Projeto'
  ClientHeight = 313
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000C0C00000000000CC0F0C000000000C00F0F0C0000000C
    00FFF0F0C0000CC0FFFFFF0F0C00C00F0FFFFFF0F0C000FFF0FFFFFF0F0C0FFF
    FF0FFFFFF0F000FFFFF0FFFFFF00000FFFFF0FFF00000000FFFFF00000000000
    0FFF00000000000000000000000000000000000000000000000000000000FFFF
    2C04FE3FF7BDF81F0000F40FFFFFE00700008003FFFF4001FFFF0000FFFF0000
    FFFF8001FFFFC003FFFFE00F0000F07FFFFFF8FF0000FFFF1F00FFFFF7BD}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageDiario: TPageControl
    Left = 0
    Top = 0
    Width = 329
    Height = 313
    Cursor = crDefault
    ActivePage = TabModificacao
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrack = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Style = tsFlatButtons
    TabOrder = 0
    object TabModificacao: TTabSheet
      Hint = 'Anotação de modificações a serem realizadas no projeto'
      Caption = '&Modificações'
      object TextoModificacao: TRichEdit
        Left = 0
        Top = 25
        Width = 321
        Height = 254
        Align = alClient
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 321
        Height = 25
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 1
          Top = 1
          Width = 319
          Height = 23
          Align = alClient
          Alignment = taCenter
          Caption = 'Modificações'
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
      end
    end
    object TabLembrete: TTabSheet
      Hint = 'Anotação de lembretes'
      Caption = '&Lembretes'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 321
        Height = 25
        Align = alTop
        TabOrder = 0
        object Label2: TLabel
          Left = 1
          Top = 1
          Width = 319
          Height = 23
          Align = alClient
          Alignment = taCenter
          Caption = 'Lembretes'
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
      end
      object TextoLembrete: TRichEdit
        Left = 0
        Top = 25
        Width = 321
        Height = 254
        Align = alClient
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
    end
    object TabDica: TTabSheet
      Hint = 'Anotação de dicas do projeto ou procedimentos'
      Caption = '&Dicas'
      ImageIndex = 2
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 321
        Height = 25
        Align = alTop
        TabOrder = 0
        object Label3: TLabel
          Left = 1
          Top = 1
          Width = 319
          Height = 23
          Align = alClient
          Alignment = taCenter
          Caption = 'Dicas'
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
      end
      object TextoDica: TRichEdit
        Left = 0
        Top = 25
        Width = 321
        Height = 254
        Align = alClient
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
    end
  end
end
