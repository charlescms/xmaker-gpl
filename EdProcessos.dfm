object FormProcessos: TFormProcessos
  Left = 302
  Top = 216
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Processo direto & inverso'
  ClientHeight = 213
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnOk: TButton
    Left = 183
    Top = 185
    Width = 75
    Height = 25
    Hint = 'Inserir relacionamento'
    Caption = '&Ok'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object BtnFechar: TButton
    Left = 263
    Top = 185
    Width = 75
    Height = 25
    Hint = 'Fechar'
    Caption = '&Cancelar'
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 5
    Width = 334
    Height = 176
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Processo'
      object Bevel1: TBevel
        Left = 2
        Top = 3
        Width = 321
        Height = 142
      end
      object Label29: TLabel
        Left = 3
        Top = 20
        Width = 86
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Tabela alvo'
      end
      object Label1: TLabel
        Left = 3
        Top = 44
        Width = 86
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Campo alvo'
      end
      object Label2: TLabel
        Left = 3
        Top = 68
        Width = 86
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Condição'
      end
      object Label3: TLabel
        Left = 3
        Top = 92
        Width = 86
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Processo direto'
      end
      object Label4: TLabel
        Left = 3
        Top = 116
        Width = 86
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Processo inverso'
      end
      object PR_EdTab_alvo: TDBComboBox
        Left = 93
        Top = 16
        Width = 224
        Height = 21
        Style = csDropDownList
        DataField = 'tab_alvo'
        DataSource = FormDB_Case.DataSource_Processo
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnExit = PR_EdTab_alvoExit
      end
      object PR_EdCampo_alvo: TDBComboBox
        Left = 93
        Top = 40
        Width = 224
        Height = 21
        Hint = 'Informe o campo alvo da atribuição'
        Style = csDropDownList
        DataField = 'campo_alvo'
        DataSource = FormDB_Case.DataSource_Processo
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object PR_EdCondicao: TRxDBComboEdit
        Left = 93
        Top = 64
        Width = 224
        Height = 21
        Hint = 'Informe uma condição para executar o processo direto e inverso.'
        DataField = 'condicao'
        DataSource = FormDB_Case.DataSource_Processo
        Glyph.Data = {
          96000000424D960000000000000076000000280000000A000000040000000100
          0400000000002000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
          0000800800800800000080080080080000008888888888000000}
        ButtonWidth = 16
        NumGlyphs = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnButtonClick = PR_EdCondicaoButtonClick
      end
      object PR_EdFormula_direta: TRxDBComboEdit
        Left = 93
        Top = 88
        Width = 224
        Height = 21
        Hint = 
          'Informe a expressão do processo direto, esse processo será '#13#10'exe' +
          'cutado quando o registro for gravado.'
        DataField = 'formula_direta'
        DataSource = FormDB_Case.DataSource_Processo
        Glyph.Data = {
          96000000424D960000000000000076000000280000000A000000040000000100
          0400000000002000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
          0000800800800800000080080080080000008888888888000000}
        ButtonWidth = 16
        NumGlyphs = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnButtonClick = PR_EdFormula_diretaButtonClick
      end
      object PR_EdFormula_inversa: TRxDBComboEdit
        Left = 93
        Top = 112
        Width = 224
        Height = 21
        Hint = 
          'Informe a expressão do processo direto, esse processo será '#13#10'exe' +
          'cutado quando o registro for excluído.'
        DataField = 'formula_inversa'
        DataSource = FormDB_Case.DataSource_Processo
        Glyph.Data = {
          96000000424D960000000000000076000000280000000A000000040000000100
          0400000000002000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
          0000800800800800000080080080080000008888888888000000}
        ButtonWidth = 16
        NumGlyphs = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnButtonClick = PR_EdFormula_inversaButtonClick
      end
    end
  end
end
