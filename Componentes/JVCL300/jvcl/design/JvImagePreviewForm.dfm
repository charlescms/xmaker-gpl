object ImageForm: TImageForm
  Left = 201
  Top = 98
  ActiveControl = FileEdit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Select Image'
  ClientHeight = 265
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00044444444400000000000000000000444F7777777744440000000000000044
    7F7F77777777787844000000000004777F7F7777777778788840000000000477
    7F7F97777777787888400000000004777F7F7977777778788840000000000477
    7F7F79117777787888400000000004777F7F7991177778788840000000000477
    7F7F77F91177787888400000000004777F7F779F917778788840000000000477
    7F7F77799907787888400000000004777F7F7777700078788840000000000477
    7F7F77777700087888400000000004777F7F7777777030788840000000000477
    7F7F77779977030988400000000004777F7F7777977770309840000000000477
    7F7E4444944477030840000000000477444E4444444444403040000000000444
    BB4E44444444444903000000000004B70B4E44444494444940300000000004B7
    0B4E44444994444998030000000004B704499999FFFF44499840300000000447
    011999999999FFF9984003000000048770119999999999998840003000000048
    7081111111999888844000030000000470088888888888444400000030000000
    0704444444444470000000000000000007000000000000000000000000000000
    0070000000000700000000000000000000070000000770000000000000000000
    000000777777000000000000000000000000000000000000000000000000FE00
    FFFFF0000FFFC00003FF800001FF800001FF800001FF800001FF800001FF8000
    01FF800001FF800001FF800001FF800001FF800001FF800001FF800001FF8000
    01FF800001FF800001FF800000FF8000007F8000003F8000011F8000018FC000
    01C7E00003E3F8000FF1F9FFDFFBFCFF9FFFFE7E3FFFFF007FFFFFC0FFFF0000}
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PathLabel: TLabel
    Left = 158
    Top = 27
    Width = 146
    Height = 15
    AutoSize = False
    Caption = 'E:\...\JVCL3\packages\d6'
  end
  object ImageName: TLabel
    Left = 319
    Top = 13
    Width = 57
    Height = 13
    Caption = 'ImageName'
  end
  object Label2: TLabel
    Left = 4
    Top = 224
    Width = 81
    Height = 13
    Caption = 'List files of &type:  '
    FocusControl = FilterCombo
  end
  object Label3: TLabel
    Left = 158
    Top = 224
    Width = 36
    Height = 13
    Caption = 'Dri&ves: '
    FocusControl = DriveCombo
  end
  object Label4: TLabel
    Left = 4
    Top = 8
    Width = 54
    Height = 13
    Caption = 'File &name:  '
    FocusControl = FileEdit
  end
  object Label5: TLabel
    Left = 158
    Top = 8
    Width = 43
    Height = 13
    Caption = '&Folders:  '
    FocusControl = DirectoryList
  end
  object PreviewBtn: TSpeedButton
    Left = 455
    Top = 4
    Width = 24
    Height = 23
    Hint = 'Preview|'
    Enabled = False
    Flat = True
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDD0000DD00DDDDDDDDDDDDDDDD0000D0000DDDDDDDDDDDDDDD0000D0F0
      00DDDDDDDDDDDDDD0000DD0F000DDDDDDDDDDDDD0000DDD0F000DDDDDDDDDDDD
      0000DDDD0F00000008DDDDDD0000DDDDD0F008000800000D0000DDDDDD0080FF
      FE80FE0D0000DDDDDD08D0EF0FE88F0D0000DDDDDD08D0F000FE0E0D0000DDDD
      DD08D880E00F0F0D0000DDDDDD08DFFEFE000E0D0000DDDDDD888FFFEFE88F0D
      0000DDDDDDD08DFEFE80FE0D0000DDDDDDDD0D6D6D00000D0000DDDDDDDDD800
      08F0E0DD0000DDDDDDDDD0EFEFE00DDD0000DDDDDDDDD0000000DDDD0000DDDD
      DDDDDDDDDDDDDDDD0000}
    OnClick = PreviewBtnClick
  end
  object DirectoryList: TDirectoryListBox
    Left = 158
    Top = 51
    Width = 148
    Height = 164
    DirLabel = PathLabel
    FileList = FileListBox
    IntegralHeight = True
    ItemHeight = 16
    TabOrder = 2
    OnChange = FileListBoxClick
  end
  object DriveCombo: TDriveComboBox
    Left = 158
    Top = 241
    Width = 148
    Height = 19
    DirList = DirectoryList
    TabOrder = 4
  end
  object FileEdit: TEdit
    Left = 4
    Top = 24
    Width = 146
    Height = 21
    TabOrder = 0
    Text = '*.bmp;*.ico;*.wmf'
  end
  object ImagePanel: TPanel
    Left = 315
    Top = 32
    Width = 164
    Height = 160
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 5
    object Image: TImage
      Left = 1
      Top = 1
      Width = 162
      Height = 158
      Align = alClient
      Center = True
    end
  end
  object FileListBox: TFileListBox
    Left = 4
    Top = 51
    Width = 146
    Height = 164
    FileEdit = FileEdit
    FileType = [ftReadOnly, ftHidden, ftNormal]
    IntegralHeight = True
    ItemHeight = 16
    Mask = '*.bmp;*.ico;*.wmf'
    ShowGlyphs = True
    TabOrder = 1
    OnChange = FileListBoxChange
    OnClick = FileListBoxClick
    OnDblClick = FileListBoxDblClick
  end
  object FilterCombo: TFilterComboBox
    Left = 4
    Top = 241
    Width = 146
    Height = 21
    FileList = FileListBox
    Filter = 
      'Image Files (*.bmp, *.ico, *.wmf)|*.bmp;*.ico;*.wmf|Bitmap Files' +
      ' (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Metafiles (*.wmf)|*.wmf|All f' +
      'iles (*.*)|*.*'
    TabOrder = 3
    OnChange = FileListBoxClick
  end
  object StretchCheck: TCheckBox
    Left = 318
    Top = 198
    Width = 116
    Height = 15
    Caption = ' &Stretch '
    TabOrder = 6
    OnClick = StretchCheckClick
  end
  object OkBtn: TButton
    Left = 318
    Top = 236
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 7
    OnClick = OkBtnClick
  end
  object CancelBtn: TButton
    Left = 401
    Top = 236
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object FilePics: TJvPicClip
    Cols = 11
    Picture.Data = {
      07544269746D61709E050000424D9E050000000000007600000028000000B000
      00000F0000000100040000000000280500000000000000000000100000000000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD00000000000
      00DDD0000000000000DDD00000000000000DDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDD0DDDDDDDDDDD0000000000
      0000DDD0000000000000DDD0000000000000D8777777777770DDD87777777777
      70DDD87777777777770DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD00000000000
      00DD000000BF30000000DDDDDD0D0DDDDDDDD888888888888880DD8888888888
      8800DD88888888888800D8FFFFFFFFFF70DDD8FFFFFFFFFF70DDD8F111FFFFFF
      F70DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD888888888888880D777777333077
      7777DDDD080D0D0DDDDDD8FB7B7B7B7B7B80DD8FB7B7B7B7B800DD87B8B8B8B8
      B800D8FFFFFFFFFF70DDD8FFFFFFFFFF70DDD8FF991110FFF70DD00000000000
      00DDD0000000000000DD8F77FFFFF777780DDDDDDDD70DDDDDDDDDD070080D0D
      0DDDD8F7B7B7B7B7B780D8FB7B7B7B7B7080D87B8B8B8B8B8080D8FFFFF00FFF
      70DDD8FF0087F70F70DDD8FFFF99870FF70D888888888888880D888888888888
      880D8FA200000000780DDDDDDDD00DDDDDDDDD08F880080D0D0DD8FB7B7B7B7B
      7B80D8F7B7B7B7B78080D878B8B8B8B88080D8FFFF0770FF70DDD8F0F700000F
      70DDD8FF000FF804F70D877777777777788087FFFFFFFFFF78808F7777788777
      000DD0000000000000DDD08F778880080D0DD8F7B7B7B7B7B7808F7B7B7B7B7B
      0880878B8B8B8B8B0880D8FFF8F0880F70DDD8FFCC0C0B0F70DDD8F2AA20FFEC
      470D87777FFFF777788087888888888878808FFFFF87F777AB0D87FFFFFFFFFF
      780D87F777778880080DD8FB7B7B7B7B7B808FFFFFFFFFF80780877777777778
      0780D8FF070F80FF70DDD8FCF700000F70DDD8F2AA2099FCC40D878880000888
      78808777777777777880D88888777F77BEE087888888888878808F7777777788
      8000D8F7B7B7B7B7B7808888888888888B808888888888888B80D8F3B0880FFF
      70DDD8FF9909020F70DDD8F2BA20991FCC4D8777788887797880877777777772
      7880DDDDD8777808E77087777777777778808777777777778880D8FB7B7B7B7B
      7B80D8F7B7B7B7B7B780D878B8B8B8B8B880D8FF0B30FFFF70DDD8F9FFF000FF
      70DDD8FF2209991FFCC48FFFFFFFFFFFF8808FFFFFFFFFFFF880DDDDD877A070
      77708777777777727880DD8F777777777780D8FFFFFFFFFFFF80D8FB7B7B7FFF
      FF80D87B8B8B87777780D8FF330FFFFF70DDD8FFFFFFFFFF70DDD8FFFF99991F
      F7CCD87777777777778DD87777777777778DDDDDD87AA808F7708FFFFFFFFFFF
      F880DDDD8F777777770DD87B7B7B7888888DD8F7B7B7F888888DD878B8B87888
      888DD8FFFFFFFF0000DDD8FFFFFFFF0000DDD8FFFF888810000CDD8888888888
      88DDDD888888888888DDDDDDD8AAEBB77F70D877777777777780DDDDDD8F7777
      70DDDD87B7B78DDDDDDDDD8FFFFF8DDDDDDDDD8777778DDDDDDDD8FFFFFFFF7F
      8DDDD8FFFFFFFF7F8DDDD8FFFFF11117F8DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDD8EEBB7770DDD8888888888888DDDDDDDDD8F770DDDDDD88888DDDD
      DDDDDDD88888DDDDDDDDDDD88888DDDDDDDDD8FFFFFFFF78DDDDD8FFFFFFFF78
      DDDDD8FFFFFFFFF78DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD88BB7
      88DDDDDDDDDDDDDDDDDDDDDDDDDDDD80DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDD8888888888DDDDDD8888888888DDDDDD88888888888
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD888DDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDD}
    Left = 240
  end
  object FormStorage: TJvFormStorage
    AppStorage = AppStorage
    AppStoragePath = 'RX.ImagePreview\'
    StoredProps.Strings = (
      'StretchCheck.Checked')
    StoredValues = <>
    Left = 272
  end
  object AppStorage: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    Root = '%NONE%'
    SubStorages = <>
    Left = 208
  end
end
