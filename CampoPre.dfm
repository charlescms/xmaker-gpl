object FormCamposPredefinidos: TFormCamposPredefinidos
  Left = 215
  Top = 144
  HelpContext = 80
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Definição de Campos Predefinidos'
  ClientHeight = 351
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000FFFF000000000000F00F008000000000FFF
    F000000FFFF00F00F000800F00F00FFFF000000FFFF044444488880F00F04444
    4477770FFFF00087777777444444008788788744444400877777777778000087
    887887887800008777777777780000888888888888000088888888888800FFFF
    240403FF000003FF000000C0FFFF024000000300000003C00000000000000000
    0000C0000000C0000000C0030000C0030000C0030000C0030000C0030000}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GrupoCampos: TGroupBox
    Left = 6
    Top = 0
    Width = 433
    Height = 310
    HelpContext = 80
    Caption = '[ Campos ]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object BtnNovoCampo: TSpeedButton
      Left = 152
      Top = 111
      Width = 23
      Height = 22
      Hint = 'Inserir Novo Campo'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF00000000000000FF0FFFFFFFF00FF0FF0FFFFFFFF08
        0F0FF0F0F0F07F0F800FF0FFFFF00700000FF0FFFFF0B07FFF0FF0FFFFF0B07F
        FF0FF0FFFFF0BB07FF0FF0FFFFF0BB07FF0FF00000000BB0000FFFFFFFFF0BB0
        7FFFFFFFFFFFF00007FFFFFFFFFFF0990FFFFFFFFFFFFF00FFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnNovoCampoClick
    end
    object BtnDeletarCampo: TSpeedButton
      Left = 152
      Top = 143
      Width = 23
      Height = 22
      Hint = 'Excluir Campo Selecionado'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF00000000000000FF0FFFFFFFF00FF0FF0FFFFFFFF0
        80F0F10FFFFFFFF0F800F91FFFF71FF00000FF97FF719FFFFFF0FF917F19FFFF
        FFF0FFF9119FFFFFFFF0FF7919FFFFFFFFF0F799917000000000F99FF917FFFF
        FFFFFFFFFF917FFFFFFFFFFFFFF917FFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnDeletarCampoClick
    end
    object Label5: TLabel
      Left = 222
      Top = 27
      Width = 28
      Height = 13
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 228
      Top = 51
      Width = 21
      Height = 13
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 204
      Top = 75
      Width = 45
      Height = 13
      Caption = 'Tamanho'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 215
      Top = 99
      Width = 33
      Height = 13
      Caption = 'Edição'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 208
      Top = 123
      Width = 41
      Height = 13
      Caption = 'Máscara'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 220
      Top = 147
      Width = 28
      Height = 13
      Caption = 'Título'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 220
      Top = 171
      Width = 27
      Height = 13
      Caption = 'Ajuda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 188
      Top = 195
      Width = 61
      Height = 13
      Caption = 'Valor Padrão'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 201
      Top = 219
      Width = 47
      Height = 13
      Caption = 'Validação'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 177
      Top = 243
      Width = 72
      Height = 13
      Caption = 'Valores Válidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 201
      Top = 267
      Width = 48
      Height = 13
      Caption = 'Descrição'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ListaCampos: TListBox
      Left = 2
      Top = 15
      Width = 143
      Height = 293
      HelpContext = 80
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Style = lbOwnerDrawVariable
      TabOrder = 0
      OnClick = ListaCamposClick
      OnDblClick = ListaCamposDblClick
    end
    object EdNomeCampo: TEdit
      Left = 256
      Top = 24
      Width = 161
      Height = 21
      Hint = 'Informe o nome do campo'
      HelpContext = 80
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyPress = EdNomeCampoKeyPress
    end
    object ComboTipoCampo: TComboBox
      Left = 256
      Top = 48
      Width = 129
      Height = 21
      Hint = 'Informe o tipo do campo'
      HelpContext = 80
      Style = csDropDownList
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnKeyPress = EdNomeCampoKeyPress
      Items.Strings = (
        'Alfanumérico'
        'Número Inteiro'
        'Número Fracionário'
        'Data'
        'Memo'
        'Imagem')
    end
    object EdTamanhoCampo: TMaskEdit
      Left = 256
      Top = 72
      Width = 41
      Height = 21
      Hint = 'Informe o tamanho do campo'
      HelpContext = 80
      Enabled = False
      EditMask = '99999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '     '
      OnKeyPress = EdNomeCampoKeyPress
    end
    object ComboEdicaoCampo: TComboBox
      Left = 256
      Top = 96
      Width = 161
      Height = 21
      Hint = 'Informe o tipo de edição do campo'
      HelpContext = 80
      Style = csDropDownList
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnKeyPress = EdNomeCampoKeyPress
      Items.Strings = (
        'Edição Padrão ( Edit )'
        'Lista Interna ( Combo Drop )'
        'Optativo ( Rádio Buttom )'
        'Conferência ( Check Box )')
    end
    object EdTituloCampo: TEdit
      Left = 256
      Top = 144
      Width = 161
      Height = 21
      Hint = 'Informe o título do campo'
      HelpContext = 80
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 30
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnKeyPress = EdNomeCampoKeyPress
    end
    object EdAjudaCampo: TEdit
      Left = 256
      Top = 168
      Width = 161
      Height = 21
      Hint = 'Informe a mensagem de ajuda padrão do campo'
      HelpContext = 80
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 150
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnKeyPress = EdNomeCampoKeyPress
    end
    object EdValorCampo: TEdit
      Left = 256
      Top = 192
      Width = 161
      Height = 21
      Hint = 'Informe o valor padrão do campo ( Default )'
      HelpContext = 80
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 150
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnKeyPress = EdNomeCampoKeyPress
    end
    object ComboValidacaoCampo: TComboBox
      Left = 256
      Top = 216
      Width = 161
      Height = 21
      Hint = 'Informe a expressão de validação do campo'
      HelpContext = 80
      Style = csDropDownList
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnKeyPress = EdNomeCampoKeyPress
      Items.Strings = (
        ''
        'VCNPJ'
        'VCPF'
        'VPIS'
        'VUF'
        'DATAVALIDA'
        'VALORNULO'
        'VHORA'
        'VHORAMIN'
        'VHORAMINSEG'
        'ANOATUAL'
        'MESATUAL'
        'MESANOATUAL'
        'MESANOVALIDO')
    end
    object EdDescricaoCampo: TEdit
      Left = 256
      Top = 264
      Width = 161
      Height = 21
      Hint = 'Informe a descrição dos valores válidos'
      HelpContext = 80
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 150
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnKeyPress = EdNomeCampoKeyPress
    end
    object BtnGravar: TBitBtn
      Left = 152
      Top = 175
      Width = 23
      Height = 22
      Hint = 'Gravar definições'
      HelpContext = 10
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = BtnGravarClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888880000000000000880330000008803088033000000880308803300000088
        0308803300000000030880333333333333088033000000003308803088888888
        0308803088888888030880308888888803088030888888880308803088888888
        0008803088888888080880000000000000088888888888888888}
    end
    object EdMascaraCampo: TComboEdit
      Left = 256
      Top = 120
      Width = 161
      Height = 21
      Hint = 'Informe a máscara de edição do campo'
      HelpContext = 150
      ButtonHint = 'Tabela de máscaras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        96000000424D960000000000000076000000280000000A000000040000000100
        0400000000002000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777700
        0000700700700700000070070070070000007777777777000000}
      ButtonWidth = 14
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnButtonClick = EdMascaraCampoButtonClick
      OnKeyPress = EdNomeCampoKeyPress
    end
    object EdValoresCampo: TComboEdit
      Left = 256
      Top = 240
      Width = 161
      Height = 21
      Hint = 
        'Informe os valores válidos separados por '#39'; '#39' (ponto e vírgula) ' +
        '  Exemplo: F;M'
      HelpContext = 150
      ButtonHint = 'Tabela de valores válidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        96000000424D960000000000000076000000280000000A000000040000000100
        0400000000002000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777700
        0000700700700700000070070070070000007777777777000000}
      ButtonWidth = 14
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnButtonClick = EdValoresCampoButtonClick
      OnKeyPress = EdNomeCampoKeyPress
    end
  end
  object BtnFechar: TBitBtn
    Left = 284
    Top = 320
    Width = 75
    Height = 25
    Hint = 'Fechar definição'
    HelpContext = 10
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 364
    Top = 320
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    Caption = '&Ajuda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BitBtn3Click
    NumGlyphs = 2
  end
end
