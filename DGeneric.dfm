object FormDadosGenericos: TFormDadosGenericos
  Left = 676
  Top = 68
  HelpContext = 120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Propriedades do Projeto'
  ClientHeight = 569
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
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
  PixelsPerInch = 120
  TextHeight = 16
  object XBanner: TXBanner
    Left = 0
    Top = 0
    Width = 30
    Height = 527
    Align = alLeft
    Alignment = AtaLeftJustify
    Angle = 90
    Caption = 'Propriedades do Projeto'
    ColorOf = 14083055
    ColorFor = 2966387
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Horizontal = True
    ParentFont = False
    ShadeLTSet = False
    Style3D = A3dNormal
  end
  object Panel1: TPanel
    Left = 0
    Top = 527
    Width = 567
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object XBanner1: TXBanner
      Left = 0
      Top = 0
      Width = 30
      Height = 42
      Align = alLeft
      Alignment = AtaLeftJustify
      Angle = 90
      Caption = ' >>>'
      ColorOf = 2966387
      ColorFor = 2966387
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Horizontal = True
      ParentFont = False
      ShadeLTSet = False
      Style3D = A3dNormal
    end
    object BtnGravar: TBitBtn
      Left = 272
      Top = 2
      Width = 92
      Height = 31
      HelpContext = 120
      Caption = '&Ok'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnGravarClick
      NumGlyphs = 2
    end
    object BtnFechar: TBitBtn
      Left = 370
      Top = 2
      Width = 93
      Height = 31
      HelpContext = 120
      Caption = '&Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BtnAjuda: TBitBtn
      Left = 469
      Top = 2
      Width = 92
      Height = 31
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
    Left = 30
    Top = 0
    Width = 537
    Height = 527
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      537
      527)
    object PageGenerico: TPageControl
      Left = 6
      Top = 6
      Width = 526
      Height = 515
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
          Left = 55
          Top = 201
          Width = 33
          Height = 16
          Caption = '�&cone'
        end
        object Panel3: TPanel
          Left = 1
          Top = 10
          Width = 513
          Height = 178
          HelpContext = 120
          TabOrder = 0
          object Bevel1: TBevel
            Left = 10
            Top = 10
            Width = 493
            Height = 159
          end
          object Label1: TLabel
            Left = 11
            Top = 23
            Width = 76
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&T�tulo'
            FocusControl = EdTitulo
          end
          object Label6: TLabel
            Left = 11
            Top = 54
            Width = 76
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Empresa'
            FocusControl = EdEmpresa
          end
          object Label2: TLabel
            Left = 11
            Top = 82
            Width = 76
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Analista'
            FocusControl = EdAnalista1
          end
          object Label3: TLabel
            Left = 11
            Top = 142
            Width = 76
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Vers�o'
            FocusControl = EdVersao
          end
          object Label4: TLabel
            Left = 357
            Top = 142
            Width = 31
            Height = 16
            Caption = '&In�cio'
          end
          object Label12: TLabel
            Left = 15
            Top = 112
            Width = 80
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Programador'
            FocusControl = EdAnalista2
          end
          object EdTitulo: TEdit
            Left = 96
            Top = 20
            Width = 390
            Height = 24
            Hint = 'Informe o T�tulo do Projeto'
            HelpContext = 120
            MaxLength = 60
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object EdEmpresa: TEdit
            Left = 96
            Top = 49
            Width = 390
            Height = 24
            Hint = 'Informe o nome da Empresa Projetista'
            HelpContext = 120
            MaxLength = 50
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
          end
          object EdAnalista1: TEdit
            Left = 96
            Top = 79
            Width = 390
            Height = 24
            Hint = 
              'Informe o nome dos Analistas/Programadores Respons�veis pelo Pro' +
              'jeto'
            HelpContext = 120
            MaxLength = 50
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
          end
          object EdAnalista2: TEdit
            Left = 96
            Top = 108
            Width = 390
            Height = 24
            Hint = 
              'Informe o nome dos Analistas/Programadores Respons�veis pelo Pro' +
              'jeto'
            HelpContext = 120
            MaxLength = 50
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
          end
          object EdVersao: TEdit
            Left = 96
            Top = 138
            Width = 85
            Height = 24
            Hint = 'Informe a vers�o do Projeto'
            HelpContext = 120
            MaxLength = 8
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
          end
          object EdInicio: TXDateEdit
            Left = 396
            Top = 138
            Width = 91
            Height = 24
            Hint = 'Informe a data de �nicio do Projeto'
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
          Left = 352
          Top = 190
          Width = 46
          Height = 39
          TabOrder = 2
          object ImagemIcone: TImage
            Left = 1
            Top = 1
            Width = 44
            Height = 37
            Align = alClient
            AutoSize = True
            Center = True
          end
        end
        object EdIcone: TComboEdit
          Left = 94
          Top = 197
          Width = 252
          Height = 26
          Hint = 'Informe o �cone do sistema'
          Glyph.Data = {
            96000000424D960000000000000076000000280000000A000000040000000100
            0400000000002000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
            0000800800800800000080080080080000008888888888000000}
          ButtonWidth = 20
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
          Top = 229
          Width = 513
          Height = 251
          ActivePage = TabParametro
          HotTrack = True
          TabOrder = 3
          OnChange = PageControlChange
          object TabParametro: TTabSheet
            Caption = 'Par�metros'
            object Label10: TLabel
              Left = 270
              Top = 18
              Width = 98
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Usu�rio'
              FocusControl = EdSenha
            end
            object Label5: TLabel
              Left = 270
              Top = 52
              Width = 98
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Se&nha Inicial'
              FocusControl = EdSenha
            end
            object Label7: TLabel
              Left = 270
              Top = 85
              Width = 98
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '&Linguagem'
              FocusControl = EdLinguagem
            end
            object Label13: TLabel
              Left = 266
              Top = 118
              Width = 102
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = '&Banco de Dados'
              FocusControl = EdComboDriver
            end
            object Label15: TLabel
              Left = 270
              Top = 151
              Width = 98
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Cone&x�o'
              FocusControl = EdConexao
            end
            object Label18: TLabel
              Left = 270
              Top = 185
              Width = 98
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'M&odelo'
              FocusControl = EdModelo
            end
            object EdSeculo: TCheckBox
              Left = 2
              Top = 0
              Width = 169
              Height = 21
              Hint = 'Informe se  o Formato da Data ser� no Formato S�culo'
              HelpContext = 120
              Caption = '&Data no Formato S�culo'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
            end
            object EdSaida: TCheckBox
              Left = 2
              Top = 20
              Width = 120
              Height = 21
              Hint = 'Informe se na finaliza��o do sistema ser� pedido confirma��o '
              HelpContext = 120
              Caption = 'Confirma &Sa�da'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
            end
            object EdMultiplas: TCheckBox
              Left = 2
              Top = 39
              Width = 149
              Height = 21
              Hint = 
                'Informe se o sistema poder� ser executado  mais de uma vez no me' +
                'smo equipamento'
              HelpContext = 120
              Caption = '&M�ltiplas Inst�ncias'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
            end
            object EdHintBalao: TCheckBox
              Left = 2
              Top = 59
              Width = 140
              Height = 21
              Hint = 
                'Informe se o Hint (Mensagens) ser�o apresentados na forma de bal' +
                '�o'
              HelpContext = 120
              Caption = '&Hint Estilo Bal�o'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
            end
            object EdMenuXP: TCheckBox
              Left = 2
              Top = 64
              Width = 113
              Height = 17
              Hint = 'Informe se o Menu ser� no apresentado no estilo do Windows XP.'
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
              Hint = 'Informe se o sistema ter� controle de acesso por senha'
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
                'Usu�rio padr�o: MASTER'#13#10'para qualquer sistema gerado este � o us' +
                'u�rio padr�o ...'
              HelpContext = 120
              TabStop = False
              CharCase = ecUpperCase
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -15
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
              Left = 373
              Top = 47
              Width = 125
              Height = 24
              Hint = 'Informe a senha inicial para acesso ao sistema'
              HelpContext = 120
              CharCase = ecUpperCase
              MaxLength = 6
              ParentShowHint = False
              ShowHint = True
              TabOrder = 12
            end
            object EdLinguagem: TComboBox
              Left = 373
              Top = 80
              Width = 125
              Height = 21
              Hint = 'Informe a linguagem de programa��o utilizada'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 16
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
              Left = 373
              Top = 113
              Width = 125
              Height = 24
              Hint = 'Informe o tipo de banco de dados'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 16
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
              Hint = 'Informe o componente de conex�o.'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 16
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
              Top = 138
              Width = 140
              Height = 21
              Hint = 
                'Informe se o usu�rio ir� selecionar a Empresa Usu�ria na'#13#10'inicia' +
                'liza��o.'
              HelpContext = 120
              Caption = 'Selecionar Empresa'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 7
              OnExit = EdAcessoExit
            end
            object EdMenuLateral: TCheckBox
              Left = 2
              Top = 158
              Width = 167
              Height = 20
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
              Top = 177
              Width = 206
              Height = 21
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
              Top = 197
              Width = 186
              Height = 21
              Hint = 
                'Informe se um Banner Vertical ser� mostrado com o t�tulo do proj' +
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
              Hint = 'Informe o componente de conex�o.'
              HelpContext = 120
              Style = csDropDownList
              ItemHeight = 16
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
              Top = 118
              Width = 191
              Height = 21
              Hint = 
                'Informe se as tabelas do controle de acesso ser�o armazenadas'#13#10'n' +
                'o mesmo banco de dados do projeto ou externamente em arquivos co' +
                'm '#13#10'extens�o ".dat".'
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
              Caption = ' Acesso das Defini��es do Projeto na Rede  '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object Label16: TLabel
                Left = 288
                Top = 21
                Width = 116
                Height = 16
                Hint = 
                  'Localiza��o do dicion�rio de dados'#13#10'informa a pasta de compartil' +
                  'harmento de tabelas e campos j� definidos '#13#10'em outro projeto.'
                Caption = 'Servidor do P&rojeto'
                FocusControl = EdServidor_Pro
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object Label14: TLabel
                Left = 12
                Top = 21
                Width = 172
                Height = 16
                Hint = 
                  'Localiza��o do dicion�rio de dados'#13#10'informa a pasta de compartil' +
                  'harmento de tabelas e campos j� definidos '#13#10'em outro projeto.'
                Caption = '&Pasta do Projeto no Servidor'
                FocusControl = Ed_L_Projeto
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object EdServidor_Pro: TEdit
                Left = 288
                Top = 41
                Width = 206
                Height = 24
                Hint = 
                  'Informe o nome do servidor ou N� do IP'#13#10'Exemplo: Servidor ou 10.' +
                  '0.0.1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
              end
              object Ed_L_Projeto: TComboEdit
                Left = 12
                Top = 41
                Width = 265
                Height = 25
                Hint = 'Informe a pasta de compartilhamento do projeto para uso em rede.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Glyph.Data = {
                  96000000424D960000000000000076000000280000000A000000040000000100
                  0400000000002000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
                  0000800800800800000080080080080000008888888888000000}
                ButtonWidth = 20
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
              Top = 20
              Width = 496
              Height = 77
              Caption = ' Banco de Dados, Tabelas e Campos '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -15
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label17: TLabel
                Left = 284
                Top = 25
                Width = 134
                Height = 16
                Hint = 
                  'Localiza��o do dicion�rio de dados'#13#10'informa a pasta de compartil' +
                  'harmento de tabelas e campos j� definidos '#13#10'em outro projeto.'
                Caption = 'Servidor do &Dicion�rio'
                FocusControl = EdServidor_Dic
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object EdDicionario: TCheckBox
                Left = 12
                Top = 18
                Width = 149
                Height = 21
                Hint = 
                  'Informe se o projeto usar� um dicion�rio de dados j� definido'#13#10'e' +
                  'm outro projeto.'
                HelpContext = 120
                Caption = '&Dicion�rio de Dados'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnExit = EdDicionarioExit
              end
              object Ed_L_Dicionario: TComboEdit
                Left = 12
                Top = 44
                Width = 265
                Height = 26
                Hint = 
                  'Informe a pasta de compartilhamento do dicion�rio de dados'#13#10'com ' +
                  'outro projeto j� definido.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Glyph.Data = {
                  96000000424D960000000000000076000000280000000A000000040000000100
                  0400000000002000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
                  0000800800800800000080080080080000008888888888000000}
                ButtonWidth = 20
                NumGlyphs = 1
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                OnButtonClick = Ed_L_DicionarioButtonClick
              end
              object EdServidor_Dic: TEdit
                Left = 284
                Top = 44
                Width = 206
                Height = 24
                Hint = 
                  'Informe o nome do servidor ou N� do IP'#13#10'Exemplo: Servidor ou 10.' +
                  '0.0.1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -15
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
        Caption = 'Apresenta��o'
        ImageIndex = 1
        object Label9: TLabel
          Left = 108
          Top = 396
          Width = 49
          Height = 16
          Caption = '&Imagem'
        end
        object ImagemVazia: TImage
          Left = 414
          Top = 404
          Width = 61
          Height = 32
          Visible = False
        end
        object Panel5: TPanel
          Left = 28
          Top = 30
          Width = 450
          Height = 339
          TabOrder = 1
          object ImageApresentacao: TImage
            Left = 1
            Top = 1
            Width = 447
            Height = 337
            Align = alClient
            Center = True
            Stretch = True
            Transparent = True
          end
        end
        object EdTelaApresentacao: TComboEdit
          Left = 158
          Top = 393
          Width = 177
          Height = 21
          Hint = 'Informe a imagem de apresenta��o (Splash)'
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
          Left = 108
          Top = 396
          Width = 49
          Height = 16
          Caption = '&Imagem'
        end
        object Panel6: TPanel
          Left = 28
          Top = 30
          Width = 450
          Height = 339
          TabOrder = 2
          object ImagemFundo: TImage
            Left = 1
            Top = 1
            Width = 447
            Height = 337
            Align = alClient
            AutoSize = True
            Center = True
            Transparent = True
          end
        end
        object EdAjustar: TCheckBox
          Left = 229
          Top = 422
          Width = 65
          Height = 21
          Hint = 'Exibir imagem ajustada'
          HelpContext = 120
          Caption = 'Aj&ustar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = EdAjustarClick
        end
        object EdImagemFundo: TComboEdit
          Left = 158
          Top = 393
          Width = 216
          Height = 25
          Hint = 'Informe a imagem de fundo'
          Glyph.Data = {
            96000000424D960000000000000076000000280000000A000000040000000100
            0400000000002000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888800
            0000800800800800000080080080080000008888888888000000}
          ButtonWidth = 20
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
    Filter = '�cone (*.ico)|*.ico'
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
