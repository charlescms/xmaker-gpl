object frmFind: TfrmFind
  Left = 236
  Top = 219
  BorderStyle = bsDialog
  Caption = 'Localizar...'
  ClientHeight = 196
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 363
    Height = 196
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Localizar'
      object Label1: TLabel
        Left = 13
        Top = 12
        Width = 62
        Height = 13
        Caption = '&Procurar Por:'
        FocusControl = cbFindText
      end
      object cbFindText: TComboBox
        Left = 80
        Top = 8
        Width = 185
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 16
        Top = 32
        Width = 121
        Height = 57
        Caption = ' Opções '
        TabOrder = 1
        object cbMatchCase: TCheckBox
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Caption = 'Di&ferenciar Letras'
          TabOrder = 0
        end
        object cbWholeWord: TCheckBox
          Left = 8
          Top = 32
          Width = 105
          Height = 17
          Caption = 'Palavras &Inteiras'
          TabOrder = 1
        end
      end
      object GroupBox3: TGroupBox
        Left = 16
        Top = 93
        Width = 121
        Height = 57
        Caption = ' Extensão '
        TabOrder = 2
        object rbGlobal: TRadioButton
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Caption = '&Global'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbSelectedOnly: TRadioButton
          Left = 8
          Top = 32
          Width = 105
          Height = 17
          Caption = '&Selecionado'
          TabOrder = 1
        end
      end
      object GroupBox2: TGroupBox
        Left = 144
        Top = 32
        Width = 121
        Height = 57
        Caption = ' Direção '
        TabOrder = 3
        object rbForward: TRadioButton
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Caption = '&Adiante'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbBackward: TRadioButton
          Left = 8
          Top = 32
          Width = 105
          Height = 17
          Caption = '&Reverso'
          TabOrder = 1
        end
      end
      object GroupBox4: TGroupBox
        Left = 144
        Top = 93
        Width = 121
        Height = 57
        Caption = ' Origem '
        TabOrder = 4
        object rbFromCursor: TRadioButton
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Caption = '&Do Cursor'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbEntireScope: TRadioButton
          Left = 8
          Top = 32
          Width = 105
          Height = 17
          Caption = 'D&o Início'
          TabOrder = 1
        end
      end
      object btnFind: TButton
        Left = 272
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Procurar'
        Default = True
        ModalResult = 1
        TabOrder = 6
        OnClick = btnFindClick
      end
      object btnCancel: TButton
        Left = 272
        Top = 40
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancelar'
        ModalResult = 2
        TabOrder = 7
      end
      object btnHelp: TButton
        Left = 272
        Top = 73
        Width = 75
        Height = 25
        Caption = 'Ajuda'
        TabOrder = 8
      end
      object EmTodos: TCheckBox
        Left = 16
        Top = 152
        Width = 153
        Height = 17
        Caption = 'E&m todos arquivos abertos'
        TabOrder = 5
      end
    end
  end
end
