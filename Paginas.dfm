object FormPaginas: TFormPaginas
  Left = 285
  Top = 192
  BorderStyle = bsDialog
  Caption = 'Páginas'
  ClientHeight = 276
  ClientWidth = 188
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 31
    Top = 248
    Width = 75
    Height = 25
    HelpContext = 40
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 111
    Top = 248
    Width = 75
    Height = 25
    HelpContext = 50
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object ListPg: TListBox
    Left = 0
    Top = 26
    Width = 188
    Height = 212
    Align = alTop
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListPgClick
    OnDblClick = ListPgDblClick
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 188
    Height = 26
    AutoSize = True
    Caption = 'ToolBar1'
    EdgeBorders = [ebTop, ebBottom]
    Flat = True
    Images = FormPrincipal.ListaImagem
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    object BtnIncluir: TToolButton
      Left = 0
      Top = 0
      Hint = 'Nova página'
      Caption = 'BtnIncluir'
      ImageIndex = 17
      OnClick = BtnIncluirClick
    end
    object BtnExcluir: TToolButton
      Left = 23
      Top = 0
      Hint = 'Excluir página'
      Caption = 'BtnExcluir'
      ImageIndex = 32
      OnClick = BtnExcluirClick
    end
    object ToolButton1: TToolButton
      Left = 46
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 33
      Style = tbsSeparator
    end
    object BtnEditar: TToolButton
      Left = 54
      Top = 0
      Hint = 'Título da página'
      Caption = 'BtnEditar'
      ImageIndex = 43
      OnClick = BtnEditarClick
    end
  end
end
