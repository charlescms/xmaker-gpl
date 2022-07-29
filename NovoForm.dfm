object FormNovoForm: TFormNovoForm
  Left = 334
  Top = 179
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Novo Formulário'
  ClientHeight = 196
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnOk: TButton
    Left = 225
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object BtnCancelar: TButton
    Left = 307
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 5
    Top = 6
    Width = 377
    Height = 156
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Atributos'
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 28
        Height = 13
        Caption = 'Nome'
      end
      object Label2: TLabel
        Left = 8
        Top = 40
        Width = 28
        Height = 13
        Caption = 'Título'
      end
      object Label3: TLabel
        Left = 8
        Top = 80
        Width = 33
        Height = 13
        Caption = 'Tabela'
      end
      object LbForm: TLabel
        Left = 129
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Form'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object EdNome: TEdit
        Left = 8
        Top = 16
        Width = 116
        Height = 21
        MaxLength = 15
        TabOrder = 0
        OnChange = EdNomeChange
      end
      object EdTitulo: TEdit
        Left = 8
        Top = 56
        Width = 353
        Height = 21
        MaxLength = 80
        TabOrder = 1
      end
      object EdTabela: TComboBox
        Left = 8
        Top = 99
        Width = 353
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
    end
  end
end
