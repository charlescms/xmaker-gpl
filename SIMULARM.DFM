object FormSimularMenu: TFormSimularMenu
  Left = 192
  Top = 107
  Width = 590
  Height = 411
  Caption = 'Visualização do Menu Principal e Barra de Ferramentas'
  Color = clBtnShadow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00800000000000000087777777700000008FFFFFFF700000008FFFFFFF700000
    008FFFFFFF700000008FFFFFFF708000008FFFFFFF708F77778FFFFFFF708F77
    778FFFFF00008F77778FFFFF8F008F77778FFFFF80008F777788888880008FFF
    FFFFFF000000800000000000000084444444440000078888888888000077FC00
    C804EC000000DC000000DC0000008C00F7BDDC00F7BD000000000000F7BD0000
    00000001EF7B0003FFFF0007FFFF001EFFFF001AFFFF0010FFFF0018FFFF}
  Menu = MenuSimulado
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BarraPrincipal: TToolBar
    Left = 0
    Top = 0
    Width = 582
    Height = 26
    ButtonHeight = 23
    ButtonWidth = 25
    Color = clBtnFace
    Flat = True
    Images = FormPrincipal.ImagensProjeto
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object StatusBarSimulador: TStatusBar
    Left = 0
    Top = 365
    Width = 582
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object MenuSimulado: TMainMenu
    Images = FormPrincipal.ImagensProjeto
    Left = 8
    Top = 56
  end
end
