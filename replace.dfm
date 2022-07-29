object FrmReplace: TFrmReplace
  Left = 182
  Top = 158
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Substituir...'
  ClientHeight = 237
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 381
    Height = 237
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Substituir'
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 62
        Height = 13
        Caption = 'Procurar Por:'
      end
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 65
        Height = 13
        Caption = 'Substituir Por:'
      end
      object cbFindText: TComboBox
        Left = 79
        Top = 9
        Width = 202
        Height = 21
        ImeName = 'ÇÑ±¹¾î(ÇÑ±Û)'
        ItemHeight = 13
        TabOrder = 0
      end
      object cbReplace: TComboBox
        Left = 79
        Top = 40
        Width = 202
        Height = 21
        ImeName = 'ÇÑ±¹¾î(ÇÑ±Û)'
        ItemHeight = 13
        TabOrder = 1
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 72
        Width = 121
        Height = 57
        Caption = ' Opções '
        TabOrder = 2
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
        Left = 8
        Top = 133
        Width = 121
        Height = 57
        Caption = ' Extensão '
        TabOrder = 3
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
        Left = 160
        Top = 72
        Width = 121
        Height = 57
        Caption = ' Direção '
        TabOrder = 4
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
        Left = 160
        Top = 133
        Width = 121
        Height = 57
        Caption = ' Origem '
        TabOrder = 5
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
      object EmTodos: TCheckBox
        Left = 8
        Top = 192
        Width = 153
        Height = 17
        Caption = 'E&m todos arquivos abertos'
        TabOrder = 6
      end
    end
  end
  object btnOK: TButton
    Left = 294
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Subsitituir'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 295
    Top = 65
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnHelp: TButton
    Left = 296
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Ajuda'
    TabOrder = 3
  end
end
