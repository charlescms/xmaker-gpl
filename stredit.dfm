object StrEditDlg: TStrEditDlg
  Left = 226
  Top = 123
  BorderStyle = bsDialog
  Caption = 'Editor de Strings'
  ClientHeight = 279
  ClientWidth = 430
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  PopupMenu = StringEditorMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LineCount: TLabel
    Left = 12
    Top = 12
    Width = 169
    Height = 17
    AutoSize = False
    Caption = '0 linhas'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 413
    Height = 229
    Shape = bsFrame
  end
  object OKButton: TButton
    Left = 265
    Top = 248
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 345
    Top = 248
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object Memo: TRichEdit
    Left = 16
    Top = 31
    Width = 397
    Height = 197
    HideScrollBars = False
    PlainText = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    OnChange = UpdateStatus
    OnKeyDown = Memo1KeyDown
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'TXT'
    Filter = 
      'Text files (*.TXT)|*.TXT|Config files (*.SYS;*.INI)|*.SYS;*.INI|' +
      'Batch files (*.BAT)|*.BAT|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofShowHelp, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load string list'
    Left = 376
  end
  object SaveDialog: TSaveDialog
    Filter = 
      'Text files (*.TXT)|*.TXT|Config files (*.SYS;*.INI)|*.SYS;*.INI|' +
      'Batch files (*.BAT)|*.BAT|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist, ofEnableSizing]
    Title = 'Save string list'
    Left = 404
  end
  object StringEditorMenu: TPopupMenu
    Left = 344
    object LoadItem: TMenuItem
      Caption = '&Load...'
      OnClick = FileOpen
    end
    object SaveItem: TMenuItem
      Caption = '&Save...'
      OnClick = FileSave
    end
    object CodeEditorItem: TMenuItem
      Caption = '&Code Editor...'
      Visible = False
      OnClick = CodeWndBtnClick
    end
  end
end
