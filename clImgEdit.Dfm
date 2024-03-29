object ClImageListEditor: TClImageListEditor
  Left = 328
  Top = 213
  Width = 459
  Height = 280
  VertScrollBar.Increment = 22
  VertScrollBar.Range = 131
  HorzScrollBar.Increment = 37
  ActiveControl = OK
  BorderStyle = fbsDialog
  Caption = 'ImageList Editor'
  Color = clButton
  Constraints.MaxHeight = 32767
  Constraints.MaxWidth = 32767
  Constraints.MinHeight = 280
  Constraints.MinWidth = 430
  KeyPreview = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  object OK: TButton
    Left = 373
    Top = 14
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Cancel: TButton
    Left = 373
    Top = 44
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ImageGroup: TGroupBox
    Left = 10
    Top = 7
    Width = 349
    Height = 123
    Anchors = [akLeft, akTop, akRight]
    Caption = ' &Selected Image '
    TabOrder = 4
    object TransparentLabel: TLabel
      Left = 94
      Top = 15
      Width = 87
      Height = 13
      Caption = '&Transparent Color:'
      FocusControl = TransparentColor
    end
    object FillLabel: TLabel
      Left = 94
      Top = 62
      Width = 42
      Height = 13
      Caption = '&Fill Color:'
      FocusControl = FillColor
    end
    object OptionsGroup: TRadioGroup
      Left = 255
      Top = 14
      Width = 84
      Height = 99
      Items.Strings = (
        'Cr&op'
        'St&retch'
        'C&enter')
      Anchors = [akRight]
      Caption = ' Options '
      TabOrder = 2
      OnClick = OptionsGroupClick
    end
    object MainPanel: TPanel
      Left = 10
      Top = 26
      Width = 74
      Height = 74
      BevelOuter = bvNone
      BorderWidth = 5
      BorderStyle = bsSingle
      Color = clBase
      TabOrder = 5
      object MainImage: TImage
        Left = 5
        Top = 5
        Width = 64
        Height = 64
        Align = alClient
        Stretch = True
        OnMouseDown = MainImageMouseDown
        OnMouseMove = MainImageMouseMove
      end
    end
    object TransparentColor: TComboBox
      Left = 94
      Top = 34
      Width = 152
      Height = 21
      ItemHeight = 15
      TabOrder = 0
      OnChange = TransparentColorChange
      OnExit = TransparentColorExit
    end
    object FillColor: TComboBox
      Left = 94
      Top = 83
      Width = 152
      Height = 21
      ItemHeight = 15
      TabOrder = 1
      OnChange = TransparentColorChange
      OnExit = TransparentColorExit
    end
  end
  object Apply: TButton
    Left = 373
    Top = 75
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'A&pply'
    TabOrder = 2
    OnClick = ApplyClick
  end
  object Help: TButton
    Left = 373
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Help'
    TabOrder = 3
    OnClick = HelpClick
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 133
    Width = 349
    Height = 143
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' &Images '
    TabOrder = 5
    object ImageView: TIconView
      Left = 10
      Top = 18
      Width = 329
      Height = 88
      Anchors = [akLeft, akTop, akRight, akBottom]
      MultiSelect = True
      OwnerDraw = False
      TabOrder = 0
      OnEdited = ImageViewEdited
      OnKeyDown = ImageViewKeyDown
      OnSelectItem = ImageViewSelectItem
    end
    object Add: TButton
      Left = 15
      Top = 112
      Width = 70
      Height = 23
      Anchors = [akBottom]
      Caption = '&Add...'
      TabOrder = 1
      OnClick = AddClick
    end
    object Delete: TButton
      Left = 97
      Top = 112
      Width = 70
      Height = 23
      Anchors = [akBottom]
      Caption = '&Delete'
      Enabled = False
      TabOrder = 2
      OnClick = DeleteClick
    end
    object Clear: TButton
      Left = 179
      Top = 112
      Width = 70
      Height = 23
      Anchors = [akBottom]
      Caption = '&Clear'
      Enabled = False
      TabOrder = 3
      OnClick = ClearClick
    end
    object ExportBtn: TButton
      Left = 261
      Top = 112
      Width = 70
      Height = 23
      Anchors = [akBottom]
      Caption = 'E&xport...'
      Enabled = False
      TabOrder = 4
      OnClick = ExportBtnClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'bmp'
    FilterIndex = 0
    Options = [ofAllowMultiSelect]
    Height = 0
    Title = 'Add Images'
    Width = 0
    Left = 104
    Top = 152
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    FilterIndex = 0
    Options = [ofOverwritePrompt]
    Height = 0
    Title = 'Export Images'
    Width = 0
    Left = 136
    Top = 152
  end
end
