object FormCompilar: TFormCompilar
  Left = 285
  Top = 281
  HelpContext = 350
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Compilação / Execução do Projeto'
  ClientHeight = 153
  ClientWidth = 308
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
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000BFBFBFBF00000000FBFBFBFB00000000BFBFBFBF00000000FBF
    BFBFB00000000BFBFBFBF00000000000BFBFB00000000BFB000000000000FFFF
    2C04EDB6F7BDEAAA0000EAAAF7BDEDB60000FFFFF7BDFFF90000FFF0F7BD8079
    F7BD8039F7BD803900008023F7BD803FF7BD803F0000F03FF7BD8FFFF7BD}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object XBanner: TXBanner
    Left = 0
    Top = 0
    Width = 24
    Height = 153
    Align = alLeft
    Alignment = AtaLeftJustify
    Angle = 90
    Caption = '   Compilação'
    ColorOf = clWindow
    ColorFor = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Horizontal = True
    ParentFont = False
    ShadeLTSet = False
    Style3D = A3dNormal
  end
  object Panel2: TPanel
    Left = 30
    Top = 3
    Width = 274
    Height = 113
    TabOrder = 0
    object Bevel1: TBevel
      Left = 9
      Top = 8
      Width = 255
      Height = 95
    end
    object CheckTodos: TCheckBox
      Left = 60
      Top = 32
      Width = 153
      Height = 17
      Caption = 'Compilar &Todos os Módulos'
      TabOrder = 0
    end
    object CheckExecutar: TCheckBox
      Left = 60
      Top = 56
      Width = 153
      Height = 17
      Caption = 'Compilar e &Executar'
      TabOrder = 1
    end
  end
  object BtnCompilar: TBitBtn
    Left = 65
    Top = 122
    Width = 75
    Height = 25
    Hint = 'Gerar Fontes Selecionados'
    Caption = '&Compilar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnCompilarClick
  end
  object BtnExecutar: TBitBtn
    Left = 147
    Top = 122
    Width = 75
    Height = 25
    Hint = 'Executar Projeto'
    Caption = 'E&xecutar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnExecutarClick
  end
  object BtnAdapter: TBitBtn
    Left = 229
    Top = 122
    Width = 75
    Height = 25
    Hint = 
      'Compilar o utilitário "Adapter" '#13#10'Para atualizar uma base de dad' +
      'os já existente ou fazer'#13#10'a importação de registros externos uti' +
      'lize o "Adapter"'
    Caption = 'Ada&pter'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnAdapterClick
  end
end
