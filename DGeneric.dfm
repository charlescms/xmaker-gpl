object FormDadosGenericos: TFormDadosGenericos
  Left = 252
  Top = 131
  HelpContext = 120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Propriedades do Projeto'
  ClientHeight = 462
  ClientWidth = 461
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
    000000000000000000000000000000BFBFBF0FBFBF0000FBFBF000FBFB0000BF
    BF00B00FBF0000FBFBFBFB00FB0000BFB0BFBFB00F0000FB000BFBFBFB0000B0
    0F00BFBFBF0000FBFBF00BFBFB0000BFBFBF00BFBF0000FBFBFBFBFBFB000000
    0000BFBFBF0000FBFBFB0000000000000000000000000000000000000000FFFF
    C804800100008001000080010000800100008001000080010000800100008001
    00008001000080010000800100008001000080010000C0FF0000FFFF0000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object XBanner: TXBanner
    Left = 0
    Top = 0
    Width = 24
    Height = 428
    Align = alLeft
    Alignment = AtaLeftJustify
    Angle = 90
    Caption = 'Propriedades do Projeto'
    ColorOf = 14083055
    ColorFor = 2966387
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Horizontal = True
    ParentFont = False
    ShadeLTSet = False
    Style3D = A3dNormal
  end
  object Panel1: TPanel
    Left = 0
    Top = 428
    Width = 461
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object XBanner1: TXBanner
      Left = 0
      Top = 0
      Width = 24
      Height = 34
      Align = alLeft
      Alignment = AtaLeftJustify
      Angle = 90
      Caption = ' >>>'
      ColorOf = 2966387
      ColorFor = 2966387
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Horizontal = True
      ParentFont = False
      ShadeLTSet = False
      Style3D = A3dNormal
    end
    object BtnGravar: TBitBtn
      Left = 221
      Top = 2
      Width = 75
      Height = 25
      HelpContext = 120
      Caption = '&Ok'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnGravarClick
      NumGlyphs = 2
    end
    object BtnFechar: TBitBtn
      Left = 301
      Top = 2
      Width = 75
      Height = 25
      HelpContext = 120
      Caption = '&Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BtnAjuda: TBitBtn
      Left = 381
      Top = 2
      Width = 75
      Height = 25
      HelpContext = 120
      Caption = 'A&juda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BtnAjudaClick
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 24
    Top = 0
    Width = 437
    Height = 428
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PageGenerico: TPageControl
      Left = 5
      Top = 5
      Width = 427
      Height = 418
      HelpContext = 120
      ActivePage = TabPrincipal
      Anchors = [akLeft, akTop, akRight, akBottom]
      HotTrack = True
      TabOrder = 0
      OnChange = PageGenericoChange
      object TabPrincipal: TTabSheet
        HelpContext = 120
        Caption = 'Principal'
        object Label8: TLabel
          Left = 45
          Top = 163
          Width = 27
          Height = 13
          Caption = 'Í&cone'
        end
        object Panel3: TPanel
          Left = 1
          Top = 8
          Width = 417
          Height = 145
          HelpContext = 120
          TabOrder = 0
          object Bevel1: TBevel
            Left = 8
            Top = 8
            Width = 401
            Height = 129
          end
          object Label1: TLabel
            Left = 9
            Top = 19
            Width = 62
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Título'
            FocusControl = EdTitulo
          end
          object Label6: TLabel
            Left = 9
            Top = 44
            Width = 62
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Empresa'
            FocusControl = EdEmpresa
          end
          object Label2: TLabel
            Left = 9
            Top = 67
            Width = 62
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Analista'
            FocusControl = EdAnalista1
          end
          object Label3: TLabel
            Left = 9
            Top = 115
            Width = 62
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Versão'
            FocusControl = EdVersao
          end
          object Label4: TLabel
            Left = 290
            Top = 115
            Width = 27
            Height = 13
            Caption = '&Início'
          end
          object Label12: TLabel
            Left = 9
            Top = 91
            Width = 62
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Programador'
            FocusControl = EdAnalista2
          end
          object EdTitulo: TEdit
            Left = 74
            Top = 16
            Width = 321
            Height = 21
            Hint = 'Informe o Título do Projeto'
            HelpContext = 120
            MaxLength = 60
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object EdEmpresa: TEdit
            Left = 74
            Top = 40
            Width = 321
            Height = 21
            Hint = 'Informe o nome da Empresa Projetista'
            HelpContext = 120
            MaxLength = 50
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
          end
          object EdAnalista1: TEdit
            Left = 74
            Top = 64
            Width = 321
            Height = 21
            Hint = 
              'Informe o nome dos Analistas/Programadores Responsáveis pelo Pro' +
              'jeto'
            HelpContext = 120
            MaxLength = 50
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
          end
          object EdAnalista2: TEdit
            Left = 74
            Top = 88
            Width = 321
            Height = 21
            Hint = 
              'Informe o nome dos Analistas/Programadores Responsáveis pelo Pro' +
              'jeto'
            HelpContext = 120
            MaxLength = 50
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
          end
          object EdVersao: TEdit
            Left = 74
            Top = 112
            Width = 73
            Height = 21
            Hint = 'Informe a versão do Projeto'
            HelpContext = 120
            MaxLength = 8
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
          end
          object EdInicio: TXDateEdit
            Left = 322
            Top = 112
            Width = 74
            Height = 21
            Hint = 'Informe a data de ínicio do Projeto'
            Century = False
            DateText = '00/00/00'
            DateValue = -693594
            Glyph.Data = {
              56060000424D560600000000000036000000280000001C0000000E0000000100
              2000000000002006000000000000000000000000000000000000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000080
              8000008080000080800000808000008080000080800000808000008080000080
              80000080800000808000C0C0C000C0C0C000C0C0C00080808000808080008080
              8000808080008080800080808000808080008080800080808000808080008080
              8000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000000000FFFF
              FF000000000000000000FFFFFF00000000000000000000808000C0C0C000C0C0
              C000C0C0C00080808000FFFFFF008080800080808000FFFFFF00808080008080
              8000FFFFFF00808080008080800080808000C0C0C000C0C0C000C0C0C0008080
              8000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0
              C000C0C0C00000808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00C0C0
              C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C0008080
              8000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000000000FFFF
              FF000000FF000000FF00FFFFFF000000FF000000FF0000808000C0C0C000C0C0
              C000C0C0C00080808000FFFFFF008080800080808000FFFFFF00808080008080
              8000FFFFFF00808080008080800080808000C0C0C000C0C0C000C0C0C0008080
              8000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0
              C000C0C0C00000808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00C0C0
              C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C0008080
              8000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000000000FFFF
              FF000000000000000000FFFFFF00000000000000000000808000C0C0C000C0C0
              C000C0C0C00080808000FFFFFF008080800080808000FFFFFF00808080008080
              8000FFFFFF00808080008080800080808000C0C0C000C0C0C000C0C0C0008080
              8000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0
              C000C0C0C00000808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00C0C0
              C000C0C0C000FFFFFF00C0C0C000C0C0C000FFFFFF00C0C0C000C0C0C0008080
              8000C0C0C000C0C0C000C0C0C00080808000FF000000FF000000FF000000FF00
              0000FF000000FF000000FF000000FF000000FF00000000808000C0C0C000C0C0
              C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C0008080
              8000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FF00000000808000C0C0C000C0C0C000C0C0C00080808000C0C0C000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0008080
              8000C0C0C000C0C0C000C0C0C00080808000FF000000FF000000FF000000FF00
              0000FF000000FF000000FF000000FF000000FF00000000808000C0C0C000C0C0
              C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C0008080
              8000808080008080800080808000808080008080800080808000808080008080
              80008080800000808000C0C0C000C0C0C000C0C0C00080808000808080008080
              8000808080008080800080808000808080008080800080808000808080008080
              8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
              C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
            ParentShowHint = False
            ShowHint = True
            ShowButton = True
            TabOrder = 5
            OnExit = EdInicioExit
          end
        end
        object Panel4: TPanel
          Left = 286
          Top = 154
          Width = 37
          Height = 32
          TabOrder = 2
          object ImagemIcone: TImage
            Left = 1
            Top = 1
            Width = 35
            Height = 30
            Align = alClient
            AutoSize = True
            Center = True
          end
        end
        object EdIcone: TComboEdit
          Left = 76
          Top = 160
          Width = 205
          Height = 21
          Hint = 'Informe o ícone do sistema'
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
          TabOrder = 1
          Text = 'EdIcone'
          OnButtonClick = EdIconeButtonClick
          OnChange = EdTelaApresentacaoChange
        end
        object PageControl: TPageControl
          Left = 1
          Top = 186
          Width = 417
          Height = 204
          ActivePage = TabParametro
          HotTrack = True
          TabOrder = 3
          OnChange = PageControlChange
          object TabParametro: TTabSheet
            Caption = 'Parâmetros'
            object Label10: TLabel
              Left = 219
              Top = 15
              Width = 80
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Usuário'
              FocusControl = EdSenha
            end
            object Label5: TLabel
              Left = 219
              Top = 42
              Width = 80
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Se&nha Inicial'
              FocusControl = EdSenha
            end
            object Label7: TLabel
              Left = 219
              Top = 69
              Width = 80
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = '&Linguagem'
              FocusControl = EdLinguagem
            end
            object Label13: TLabel
              Left = 219
              Top = 96
              Width = 80
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = '&Banco de Dados'
              FocusControl = EdComboDriver
            end
            object Label15: TLabel
              Left = 219
              Top = 123
              Width = 80
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Cone&xão'
              FocusControl = EdConexao
            end
            object Label18: TLabel
              Left = 219
              Top = 150
              Width = 80
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'M&odelo'
              FocusControl = EdModelo
            end
            object EdSeculo: TCheckBox
              Left = 2
              Top = 0
              Width = 137
              Height = 17
              Hint = 'Informe se  o Formato da Data será no Formato Século'
              HelpContext = 120
              Caption = '&Data no Formato Século'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
            end
            object EdSaida: TCheckBox
              Left = 2
              Top = 16
              Width = 97
              Height = 17
              Hint = 'Informe se na finalização do sistema será pedido confirmação '
              HelpContext = 120
              Caption = 'Confirma &Saída'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
            end
            object EdMultiplas: TCheckBox
              Left = 2
              Top = 32
              Width = 121
              Height = 17
              Hint = 
                'Informe se o sistema poderá ser executado  mais de uma vez no me' +
                'smo equipamento'
              HelpContext = 120
              Caption = '&Múltiplas Instâncias'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
            end
            object EdHintBalao: TCheckBox
              Left = 2
              Top = 48
              Width = 113
              Height = 17
              Hint = 
                'Informe se o Hint (Mensagens) serão apresentados na forma de bal' +
                'ão'
              HelpContext = 120
              Caption = '&Hint Estilo Balão'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
            end
            object EdMenuXP: TCheckBox
              Left = 2
              Top = 64
              Width = 113
              Height = 17
              Hint = 'Informe se o Menu será no apresentado no estilo do Windows XP.'
              HelpContext = 120
              Caption = 'Men&u Estilo XP'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
            end
            object EdAcesso: TCheckBox
              Left = 2
              Top = 80
              Width = 113
              Height = 17
              Hint = 'Informe se o sistema terá controle de acesso por senha'
              HelpContext = 120
              Caption = 'C&ontrole de Acesso'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnExit = EdAcessoExit
            end
            object Edit1: TEdit
              Left = 303
              Top = 11
              Width = 102
              Height = 21
              Hint = 
                'Usuário padrão: MASTER'#13#10'para qualquer sistema gerado este é o us' +
                'uário padrão ...'
              HelpContext = 120
              TabStop = False
              CharCase = ecUpperCase
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 6
              ParentFont = False
              ParentShowHint = False
              ReadOnly = True
              ShowHint = True
              TabOrder = 11
              Text = 'MASTER'
            end
            object EdSenha: TEdit
              Left = 303
              Top = 38
              Width = 102
              Height = 21
              Hint = 'Informe a senha inicial para acesso ao sistema'
              HelpContext = 120
              CharCase = ecUpperCase
              MaxLength = 6
              ParentShowHint = False
              ShowHint = True
              TabOrder = 12
            end
            object EdLinguagem: TComboBox
              Left = 303
              Top = 65
              Width = 102
              Height = 21
              Hint = 'Informe a linguagem de programação utilizada'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 13
              ParentShowHint = False
              ShowHint = True
              TabOrder = 13
              Items.Strings = (
                'Delphi 5.0'
                'Delphi 6.0'
                'Delphi 7.0'
                'Delphi 2005'
                'Delphi 2006'
                'Turbo Delphi 2006')
            end
            object EdComboDriver: TComboBox
              Left = 303
              Top = 92
              Width = 102
              Height = 21
              Hint = 'Informe o tipo de banco de dados'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 13
              ParentShowHint = False
              ShowHint = True
              TabOrder = 14
              OnExit = EdComboDriverExit
              Items.Strings = (
                'Interbase'
                'Firebird'
                'SQLBase'
                'Oracle'
                'SQLServer'
                'Sybase'
                'DB2'
                'Informix'
                'ODBC'
                'MySQL'
                'PostgreSQL'
                'OLEDB')
            end
            object EdConexao: TComboBox
              Left = 303
              Top = 119
              Width = 102
              Height = 21
              Hint = 'Informe o componente de conexão.'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 13
              ParentShowHint = False
              ShowHint = True
              TabOrder = 15
              OnEnter = EdComboDriverExit
              Items.Strings = (
                'IBX'
                'XSQL')
            end
            object EdSelecionar: TCheckBox
              Left = 2
              Top = 112
              Width = 113
              Height = 17
              Hint = 
                'Informe se o usuário irá selecionar a Empresa Usuária na'#13#10'inicia' +
                'lização.'
              HelpContext = 120
              Caption = 'Selecionar Empresa'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 7
              OnExit = EdAcessoExit
            end
            object EdMenuLateral: TCheckBox
              Left = 2
              Top = 128
              Width = 135
              Height = 17
              Hint = 'Desativar Menu Lateral.'
              HelpContext = 120
              Caption = 'Desativar Menu Lateral'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 8
              OnExit = EdAcessoExit
            end
            object EdBarraF: TCheckBox
              Left = 2
              Top = 144
              Width = 167
              Height = 17
              Hint = 'Desativar Barra de Ferramentas.'
              HelpContext = 120
              Caption = 'Desativar Barra de Ferramentas'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 9
              OnExit = EdAcessoExit
            end
            object EdBanner: TCheckBox
              Left = 2
              Top = 160
              Width = 151
              Height = 17
              Hint = 
                'Informe se um Banner Vertical será mostrado com o título do proj' +
                'eto.'
              HelpContext = 120
              Caption = 'Banner Vertical'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 10
              OnExit = EdAcessoExit
            end
            object EdModelo: TComboBox
              Left = 303
              Top = 146
              Width = 102
              Height = 21
              Hint = 'Informe o componente de conexão.'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 13
              ParentShowHint = False
              ShowHint = True
              TabOrder = 16
              OnEnter = EdComboDriverExit
              Items.Strings = (
                'IBX'
                'ZeosLib')
            end
            object EdAcessoInterno: TCheckBox
              Left = 2
              Top = 96
              Width = 155
              Height = 17
              Hint = 
                'Informe se as tabelas do controle de acesso serão armazenadas'#13#10'n' +
                'o mesmo banco de dados do projeto ou externamente em arquivos co' +
                'm '#13#10'extensão ".dat".'
              HelpContext = 120
              Caption = 'Controle de Acesso - &Interno'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              OnExit = EdAcessoExit
            end
          end
          object TabRede: TTabSheet
            Caption = 'Compartilhamento'
            ImageIndex = 1
            object GrupoRede: TGroupBox
              Left = 2
              Top = 80
              Width = 403
              Height = 60
              Caption = ' Acesso das Definições do Projeto na Rede  '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object Label16: TLabel
                Left = 234
                Top = 17
                Width = 90
                Height = 13
                Hint = 
                  'Localização do dicionário de dados'#13#10'informa a pasta de compartil' +
                  'harmento de tabelas e campos já definidos '#13#10'em outro projeto.'
                Caption = 'Servidor do P&rojeto'
                FocusControl = EdServidor_Pro
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label14: TLabel
                Left = 10
                Top = 17
                Width = 135
                Height = 13
                Hint = 
                  'Localização do dicionário de dados'#13#10'informa a pasta de compartil' +
                  'harmento de tabelas e campos já definidos '#13#10'em outro projeto.'
                Caption = '&Pasta do Projeto no Servidor'
                FocusControl = Ed_L_Projeto
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object EdServidor_Pro: TEdit
                Left = 234
                Top = 33
                Width = 167
                Height = 21
                Hint = 
                  'Informe o nome do servidor ou Nº do IP'#13#10'Exemplo: Servidor ou 10.' +
                  '0.0.1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
              end
              object Ed_L_Projeto: TComboEdit
                Left = 10
                Top = 33
                Width = 215
                Height = 21
                Hint = 'Informe a pasta de compartilhamento do projeto para uso em rede.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Glyph.Data = {
                  96000000424D960000000000000076000000280000000A000000040000000100
                  0400000000002000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
                  0000800800800800000080080080080000008888888888000000}
                ButtonWidth = 16
                NumGlyphs = 1
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnButtonClick = Ed_L_ProjetoButtonClick
              end
            end
            object GroupBox2: TGroupBox
              Left = 2
              Top = 16
              Width = 403
              Height = 63
              Caption = ' Banco de Dados, Tabelas e Campos '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label17: TLabel
                Left = 231
                Top = 20
                Width = 104
                Height = 13
                Hint = 
                  'Localização do dicionário de dados'#13#10'informa a pasta de compartil' +
                  'harmento de tabelas e campos já definidos '#13#10'em outro projeto.'
                Caption = 'Servidor do &Dicionário'
                FocusControl = EdServidor_Dic
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object EdDicionario: TCheckBox
                Left = 10
                Top = 15
                Width = 121
                Height = 17
                Hint = 
                  'Informe se o projeto usará um dicionário de dados já definido'#13#10'e' +
                  'm outro projeto.'
                HelpContext = 120
                Caption = '&Dicionário de Dados'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnExit = EdDicionarioExit
              end
              object Ed_L_Dicionario: TComboEdit
                Left = 10
                Top = 36
                Width = 215
                Height = 21
                Hint = 
                  'Informe a pasta de compartilhamento do dicionário de dados'#13#10'com ' +
                  'outro projeto já definido.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Glyph.Data = {
                  96000000424D960000000000000076000000280000000A000000040000000100
                  0400000000002000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
                  0000800800800800000080080080080000008888888888000000}
                ButtonWidth = 16
                NumGlyphs = 1
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                OnButtonClick = Ed_L_DicionarioButtonClick
              end
              object EdServidor_Dic: TEdit
                Left = 231
                Top = 36
                Width = 167
                Height = 21
                Hint = 
                  'Informe o nome do servidor ou Nº do IP'#13#10'Exemplo: Servidor ou 10.' +
                  '0.0.1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
              end
            end
          end
        end
      end
      object TabApresentacao: TTabSheet
        HelpContext = 120
        Caption = 'Apresentação'
        ImageIndex = 1
        object Label9: TLabel
          Left = 88
          Top = 322
          Width = 37
          Height = 13
          Caption = '&Imagem'
        end
        object ImagemVazia: TImage
          Left = 336
          Top = 328
          Width = 50
          Height = 26
          Visible = False
        end
        object Panel5: TPanel
          Left = 23
          Top = 24
          Width = 365
          Height = 276
          TabOrder = 1
          object ImageApresentacao: TImage
            Left = 1
            Top = 1
            Width = 363
            Height = 274
            Align = alClient
            Center = True
            Stretch = True
            Transparent = True
          end
        end
        object EdTelaApresentacao: TComboEdit
          Left = 128
          Top = 319
          Width = 177
          Height = 21
          Hint = 'Informe a imagem de apresentação (Splash)'
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
          TabOrder = 0
          OnButtonClick = EdTelaApresentacaoButtonClick
          OnChange = EdTelaApresentacaoChange
        end
      end
      object TabSheet1: TTabSheet
        HelpContext = 120
        Caption = 'Imagem de Fundo'
        ImageIndex = 2
        object Label11: TLabel
          Left = 88
          Top = 322
          Width = 37
          Height = 13
          Caption = '&Imagem'
        end
        object Panel6: TPanel
          Left = 23
          Top = 24
          Width = 365
          Height = 276
          TabOrder = 2
          object ImagemFundo: TImage
            Left = 1
            Top = 1
            Width = 363
            Height = 274
            Align = alClient
            AutoSize = True
            Center = True
            Transparent = True
          end
        end
        object EdAjustar: TCheckBox
          Left = 186
          Top = 343
          Width = 53
          Height = 17
          Hint = 'Exibir imagem ajustada'
          HelpContext = 120
          Caption = 'Aj&ustar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = EdAjustarClick
        end
        object EdImagemFundo: TComboEdit
          Left = 128
          Top = 319
          Width = 176
          Height = 21
          Hint = 'Informe a imagem de fundo'
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
          TabOrder = 0
          OnButtonClick = EdImagemFundoButtonClick
          OnChange = EdTelaApresentacaoChange
        end
      end
    end
  end
  object OpenPictureIcone: TOpenPictureDialog
    Filter = 'Ícone (*.ico)|*.ico'
    Left = 80
    Top = 432
  end
  object OpenPictureImagem: TOpenPictureDialog
    Filter = 
      'Imagens (*.bmp; *.jpg; *.ico)|*.bmp;*.Jpg;*.Ico|Imagens (*.bmp)|' +
      '*.bmp|Imagens (*.jpg)|*.Jpg|Imagens (*.ico)|*.Ico'
    Left = 112
    Top = 432
  end
end
