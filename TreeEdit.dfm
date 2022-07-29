object FormTreeEdit: TFormTreeEdit
  Left = 228
  Top = 157
  Width = 549
  Height = 366
  ActiveControl = TreeView
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'TreeView Items Editor'
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 5
    Width = 340
    Height = 292
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' &Items '
    TabOrder = 0
    object New: TButton
      Left = 212
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
      Left = 212
      Top = 89
      Width = 110
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Excluir'
      TabOrder = 3
      OnClick = DeleteClick
    end
    object NewSub: TButton
      Left = 212
      Top = 55
      Width = 110
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Novo &SubItem'
      TabOrder = 2
      OnClick = NewSubClick
    end
    object Load: TButton
      Left = 212
      Top = 124
      Width = 110
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Carregar'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      OnClick = LoadClick
    end
    object TreeView: TTreeView
      Left = 6
      Top = 17
      Width = 192
      Height = 264
      Anchors = [akLeft, akTop, akRight, akBottom]
      DragMode = dmAutomatic
      Indent = 19
      TabOrder = 0
      OnChange = TreeViewChange
      OnDragDrop = TreeViewDragDrop
      OnDragOver = TreeViewDragOver
    end
  end
  object PropGroupBox: TGroupBox
    Left = 349
    Top = 5
    Width = 190
    Height = 292
    Anchors = [akTop, akRight, akBottom]
    Caption = ' Propriedades'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 17
      Width = 31
      Height = 13
      Caption = '&Título:'
      FocusControl = Text
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 8
      Top = 63
      Width = 72
      Height = 13
      Caption = '&Indice Imagem:'
      FocusControl = Image
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 8
      Top = 112
      Width = 91
      Height = 13
      Caption = 'Indice &Selecionado'
      FocusControl = SelectedIndex
      Layout = tlCenter
    end
    object Text: TEdit
      Left = 7
      Top = 35
      Width = 170
      Height = 21
      AutoSelect = False
      MaxLength = 32767
      TabOrder = 0
      OnChange = ValueChange
      OnExit = TextExit
    end
    object Image: TEdit
      Left = 7
      Top = 83
      Width = 74
      Height = 21
      AutoSelect = False
      MaxLength = 32767
      TabOrder = 1
      OnChange = ValueChange
      OnExit = ImageExit
    end
    object SelectedIndex: TEdit
      Left = 7
      Top = 132
      Width = 74
      Height = 21
      AutoSelect = False
      MaxLength = 32767
      TabOrder = 2
      OnChange = ValueChange
      OnExit = SelectedIndexExit
    end
  end
  object Button4: TButton
    Left = 293
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Cancel: TButton
    Left = 378
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
  object Apply: TButton
    Left = 463
    Top = 308
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Aplicar'
    TabOrder = 4
    OnClick = ApplyClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All Files(*)'
    Title = 'Open'
    Left = 13
    Top = 306
  end
end
