object FormsProjeto: TFormsProjeto
  Left = 271
  Top = 202
  BorderStyle = bsDialog
  Caption = 'Formulários do Projeto'
  ClientHeight = 290
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EdPesquisa: TEdit
    Left = 8
    Top = 8
    Width = 257
    Height = 21
    TabOrder = 0
    OnChange = EdPesquisaChange
    OnKeyDown = EdPesquisaKeyDown
  end
  object BtnOk: TButton
    Left = 276
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object BtnCancela: TButton
    Left = 276
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Cancela'
    ModalResult = 2
    TabOrder = 4
  end
  object FileListBox1: TFileListBox
    Left = 272
    Top = 176
    Width = 81
    Height = 105
    ItemHeight = 13
    Mask = '*.dfm'
    TabOrder = 2
    Visible = False
  end
  object Lista: TListBox
    Left = 8
    Top = 32
    Width = 257
    Height = 253
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnClick = ListaClick
    OnDblClick = ListaDblClick
  end
  object BtnLocalizar: TButton
    Left = 276
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Localizar'
    TabOrder = 5
    OnClick = BtnLocalizarClick
  end
  object BtnModelos: TButton
    Tag = 1
    Left = 276
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Modelos'
    TabOrder = 6
    Visible = False
    OnClick = BtnLocalizarClick
  end
  object DialogAbrir: TJvOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Height = 0
    Width = 0
    Left = 79
    Top = 191
  end
end
