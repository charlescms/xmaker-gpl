object FormBancoDados: TFormBancoDados
  Left = 301
  Top = 152
  HelpContext = 140
  BorderStyle = bsToolWindow
  Caption = 'Definição de Banco de Dados'
  ClientHeight = 375
  ClientWidth = 520
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 375
    Align = alClient
    TabOrder = 0
    object Bevel3: TBevel
      Left = 12
      Top = 17
      Width = 495
      Height = 315
    end
    object Lb_Servidor: TLabel
      Left = 259
      Top = 96
      Width = 53
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Servidor'
    end
    object Label18: TLabel
      Left = 259
      Top = 144
      Width = 53
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Usuário'
    end
    object Label19: TLabel
      Left = 259
      Top = 166
      Width = 53
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Senha'
    end
    object BtnNovoBanco: TSpeedButton
      Left = 253
      Top = 271
      Width = 23
      Height = 22
      Hint = 'Inserir novo banco de dados'
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
      OnClick = BtnNovoBancoClick
    end
    object BtnDeletarBanco: TSpeedButton
      Left = 253
      Top = 299
      Width = 23
      Height = 22
      Hint = 'Excluir banco de dados selecionado'
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
      OnClick = BtnDeletarBancoClick
    end
    object Label20: TLabel
      Left = 259
      Top = 72
      Width = 53
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Alias'
    end
    object LbHost: TLabel
      Left = 259
      Top = 191
      Width = 53
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'HostName'
    end
    object Label13: TLabel
      Left = 255
      Top = 46
      Width = 57
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Bco. dados'
    end
    object BtnAjudaBanco: TBitBtn
      Left = 432
      Top = 340
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
      TabOrder = 10
      OnClick = BtnAjudaBancoClick
      NumGlyphs = 2
    end
    object BtnFechar: TBitBtn
      Left = 352
      Top = 340
      Width = 75
      Height = 25
      Hint = 'Fechar'
      Caption = '&Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BtnAtualizar: TBitBtn
      Left = 253
      Top = 215
      Width = 23
      Height = 22
      Hint = 'Confirmar a inclusão ou alteração do banco de dados'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      OnClick = BtnAtualizarClick
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
    object BtnCancela: TBitBtn
      Left = 253
      Top = 243
      Width = 23
      Height = 22
      Hint = 'Cancela a inclusão ou alteração do banco de dados'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      OnClick = BtnCancelaClick
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C0007D654F00B199
        8300000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000D9CCC100A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303F8F80303030303030303030303030303030303FF03030303030303030303
        0303030303F90101F80303030303F9F80303030303030303F8F8FF0303030303
        03FF03030303030303F9010101F8030303F90101F8030303030303F8FF03F8FF
        030303FFF8F8FF030303030303F901010101F803F901010101F80303030303F8
        FF0303F8FF03FFF80303F8FF030303030303F901010101F80101010101F80303
        030303F8FF030303F8FFF803030303F8FF030303030303F90101010101010101
        F803030303030303F8FF030303F803030303FFF80303030303030303F9010101
        010101F8030303030303030303F8FF030303030303FFF8030303030303030303
        030101010101F80303030303030303030303F8FF0303030303F8030303030303
        0303030303F901010101F8030303030303030303030303F8FF030303F8030303
        0303030303030303F90101010101F8030303030303030303030303F803030303
        F8FF030303030303030303F9010101F8010101F803030303030303030303F803
        03030303F8FF0303030303030303F9010101F803F9010101F803030303030303
        03F8030303F8FF0303F8FF03030303030303F90101F8030303F9010101F80303
        03030303F8FF0303F803F8FF0303F8FF03030303030303F9010303030303F901
        0101030303030303F8FFFFF8030303F8FF0303F8FF0303030303030303030303
        030303F901F903030303030303F8FC0303030303F8FFFFFFF803030303030303
        03030303030303030303030303030303030303030303030303F8F8F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      NumGlyphs = 2
    end
    object BoxPar: TGroupBox
      Left = 283
      Top = 208
      Width = 221
      Height = 118
      Caption = ' Parâmetros Adicionais de Conexão '
      TabOrder = 8
      object MemoPar: TDBMemo
        Left = 4
        Top = 16
        Width = 213
        Height = 97
        DataField = 'parametros'
        DataSource = DataSource
        Enabled = False
        TabOrder = 0
        OnEnter = MemoParEnter
        OnExit = MemoParExit
      end
    end
    object GridBase: TDBGrid
      Left = 18
      Top = 21
      Width = 230
      Height = 299
      DataSource = DataSource
      Options = [dgTabs, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 9
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = GridBaseDblClick
      OnKeyDown = GridBaseKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'nome'
          Width = 226
          Visible = True
        end>
    end
    object EdNome: TDBEdit
      Left = 315
      Top = 67
      Width = 169
      Height = 21
      DataField = 'nome'
      DataSource = DataSource
      Enabled = False
      TabOrder = 2
      OnChange = EdNomeChange
    end
    object EdLogin: TDBCheckBox
      Left = 315
      Top = 117
      Width = 121
      Height = 17
      Caption = 'Login de Conexão'
      DataField = 'login'
      DataSource = DataSource
      Enabled = False
      TabOrder = 4
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object EdUsuario: TDBEdit
      Left = 315
      Top = 139
      Width = 129
      Height = 21
      DataField = 'Usuario'
      DataSource = DataSource
      Enabled = False
      TabOrder = 5
    end
    object EdSenha: TDBEdit
      Left = 315
      Top = 163
      Width = 97
      Height = 21
      DataField = 'senha'
      DataSource = DataSource
      Enabled = False
      TabOrder = 6
    end
    object EdServidor: TRxDBComboEdit
      Left = 315
      Top = 92
      Width = 169
      Height = 21
      DataField = 'arquivo'
      DataSource = DataSource
      Glyph.Data = {
        96000000424D960000000000000076000000280000000A000000040000000100
        0400000000002000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
        0000800800800800000080080080080000008888888888000000}
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 3
      OnButtonClick = EdServidorButtonClick
    end
    object EdHostName: TDBEdit
      Left = 315
      Top = 187
      Width = 169
      Height = 21
      Hint = 'Informe o nome do servidor ou número do IP de conexão'
      DataField = 'host_name'
      DataSource = DataSource
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object EdPadrao: TDBCheckBox
      Left = 315
      Top = 21
      Width = 121
      Height = 17
      Hint = 
        'Informe se o Banco de Dados irá utilizar a conexão padrão'#13#10'defin' +
        'ido em Propriedades do Projeto.'
      Caption = 'Conexão Padrão'
      DataField = 'padrao'
      DataSource = DataSource
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      OnExit = EdPadraoExit
    end
    object EdBanco: TDBComboBox
      Left = 315
      Top = 42
      Width = 169
      Height = 21
      Hint = 'Informe o tipo do Banco de Dados.'
      Style = csOwnerDrawFixed
      DataField = 'bdados'
      DataSource = DataSource
      ItemHeight = 15
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = EdBancoChange
      OnDrawItem = EdBancoDrawItem
      OnExit = EdBancoChange
    end
  end
  object OpenGDB: TOpenDialog
    Filter = 'Banco de Dados InterBase ( *.GDB )|*.GDB'
    Left = 486
    Top = 108
  end
  object DataSource: TDataSource
    Left = 464
    Top = 136
  end
end
