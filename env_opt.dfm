object frmEnvOpts: TfrmEnvOpts
  Left = 232
  Top = 125
  BorderStyle = bsDialog
  Caption = 'Propriedades do Editor'
  ClientHeight = 237
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 425
    Height = 193
    ActivePage = tsEditor
    HotTrack = True
    TabOrder = 2
    object tsEditor: TTabSheet
      Caption = 'Editor'
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 401
        Height = 73
        Caption = ' Opções do Editor: '
        TabOrder = 0
        object Label12: TLabel
          Left = 232
          Top = 27
          Width = 101
          Height = 13
          Caption = 'Tamanho de um TAB'
        end
        object cbAutoIndent: TCheckBox
          Left = 8
          Top = 16
          Width = 129
          Height = 17
          Caption = 'Auto Identificação'
          TabOrder = 0
        end
        object cbDragDropEditing: TCheckBox
          Left = 8
          Top = 32
          Width = 129
          Height = 17
          Caption = 'Arrastar Selecionado'
          TabOrder = 1
        end
        object cbDropFiles: TCheckBox
          Left = 88
          Top = 64
          Width = 145
          Height = 17
          Caption = 'Permite Drop em Arquivos'
          TabOrder = 6
          Visible = False
        end
        object cbHalfPageScroll: TCheckBox
          Left = 88
          Top = 64
          Width = 129
          Height = 17
          Caption = 'Scroll em Meia Página'
          TabOrder = 5
          Visible = False
        end
        object cbScrollPastEol: TCheckBox
          Left = 232
          Top = 8
          Width = 137
          Height = 17
          Caption = 'Scroll em Final de Linha'
          TabOrder = 3
        end
        object cbTabsToSpaces: TCheckBox
          Left = 8
          Top = 48
          Width = 169
          Height = 17
          Caption = 'Converte Tabs para Espaços'
          TabOrder = 2
        end
        object cbSmartTabs: TCheckBox
          Left = 88
          Top = 64
          Width = 137
          Height = 17
          Caption = 'Tabs Inteligentes'
          TabOrder = 7
          Visible = False
        end
        object T_Tabs: TSpinEdit
          Left = 232
          Top = 43
          Width = 49
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 96
        Width = 401
        Height = 57
        Caption = ' Opções da Barra Lateral : '
        TabOrder = 1
        object cbGutterVisible: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Barra Visível'
          TabOrder = 0
        end
        object cbShowLineNumbers: TCheckBox
          Left = 8
          Top = 32
          Width = 121
          Height = 17
          Caption = 'Mostra Nº de Linhas'
          TabOrder = 1
        end
      end
    end
    object tsCor: TTabSheet
      Caption = 'Cor'
      ImageIndex = 1
      TabVisible = False
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 55
        Height = 13
        Caption = '&Linguagem:'
        FocusControl = lbLanguage
      end
      object Label2: TLabel
        Left = 184
        Top = 8
        Width = 47
        Height = 13
        Caption = '&Elemento:'
        FocusControl = lbElement
      end
      object lbLanguage: TListBox
        Left = 8
        Top = 24
        Width = 169
        Height = 201
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbLanguageClick
      end
      object GroupBox1: TGroupBox
        Left = 184
        Top = 104
        Width = 225
        Height = 121
        Caption = ' Especificação  '
        TabOrder = 1
        object ColorGrid: TColorGrid
          Left = 8
          Top = 16
          Width = 100
          Height = 100
          TabOrder = 0
          OnChange = ElementChange
        end
        object cbBold: TCheckBox
          Left = 120
          Top = 16
          Width = 97
          Height = 17
          Caption = '&Negrito'
          TabOrder = 1
          OnClick = ElementChange
        end
        object cbItalic: TCheckBox
          Left = 120
          Top = 32
          Width = 97
          Height = 17
          Caption = '&Itálico'
          TabOrder = 2
          OnClick = ElementChange
        end
        object cbUnderline: TCheckBox
          Left = 120
          Top = 48
          Width = 97
          Height = 17
          Caption = '&Sublinhado'
          TabOrder = 3
          OnClick = ElementChange
        end
        object cbStrikeOut: TCheckBox
          Left = 120
          Top = 64
          Width = 97
          Height = 17
          Caption = '&Tracejado'
          TabOrder = 4
          OnClick = ElementChange
        end
      end
      object lbElement: TListBox
        Left = 184
        Top = 24
        Width = 225
        Height = 73
        ItemHeight = 13
        TabOrder = 2
        OnClick = lbElementClick
      end
    end
  end
  object btnOk: TButton
    Left = 275
    Top = 208
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 358
    Top = 208
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
end
