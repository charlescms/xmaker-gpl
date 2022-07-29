object FormMenuEdit_i: TFormMenuEdit_i
  Left = 228
  Top = 157
  Width = 420
  Height = 350
  ActiveControl = TreeView
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Menu Items Editor'
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 5
    Width = 400
    Height = 312
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' &Items '
    TabOrder = 0
    object New: TButton
      Left = 272
      Top = 20
      Width = 110
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Novo Item'
      Default = True
      TabOrder = 1
      OnClick = NewClick
    end
    object Delete: TButton
      Left = 272
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Excluir'
      TabOrder = 3
      OnClick = DeleteClick
    end
    object NewSub: TButton
      Left = 272
      Top = 55
      Width = 110
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Novo &SubItem'
      TabOrder = 2
      OnClick = NewSubClick
    end
    object TreeView: TTreeView
      Left = 6
      Top = 17
      Width = 252
      Height = 284
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragMode = dmAutomatic
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnChange = TreeViewChange
      OnDragDrop = TreeViewDragDrop
      OnDragOver = TreeViewDragOver
    end
  end
end
