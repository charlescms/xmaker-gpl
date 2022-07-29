object FrmXDesig: TFrmXDesig
  Left = 257
  Top = 158
  Width = 607
  Height = 375
  BorderIcons = [biSystemMenu]
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cmpFormDesigner: TFormDesigner
    DisplayGrid = True
    ShowComponentHint = True
    NormalGrabFill = clWhite
    OnMoveSizeControl = cmpFormDesignerMoveSizeControl
    OnSelectControl = cmpFormDesignerSelectControl
    OnAddControl = cmpFormDesignerAddControl
    OnControlDblClick = cmpFormDesignerControlDblClick
    OnKeyDown = cmpFormDesignerKeyDown
    OnReadError = cmpFormDesignerReadError
    OnPlaceComponent = cmpFormDesignerPlaceComponent
    Left = 16
    Top = 8
  end
end
