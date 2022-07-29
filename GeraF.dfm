object FormGerarFontes: TFormGerarFontes
  Left = 215
  Top = 102
  HelpContext = 360
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Restaurar Fontes do Projeto'
  ClientHeight = 419
  ClientWidth = 465
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
    00000000000000FFFFFFFFFFFFF000FFFFFFFFFFFFF000FCFFCFF0FF0FF000FC
    FCFCF0F0F0F000FCFFCFF0FF0FF000FFFFFFFFFFFFF000FBFFBFFCFFCFF000FB
    FBFBFCFCFCF000FBFFBFFCFFCFF000FFFFFFFFFFFFF000F0FF0FFFFFFFF000F0
    F0F0FFFF000000F0FF0FFFFF0F0000FFFFFFFFFF000000000000000000008000
    08058000F7BD8000F7BD8000F7BD800000008000FFFF8000FFFF8000FFFF8000
    FFFF8000FFFF8000FFFF8000FFFF8000FFFF8001FFFF8003FFFF80070000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 373
    Width = 465
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnGerar: TBitBtn
      Left = 224
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Gerar Fontes Selecionados'
      Caption = '&Gerar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnGerarClick
    end
    object BtnFechar: TBitBtn
      Left = 304
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Fechar gera��o de fontes do projeto'
      Caption = '&Fechar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BtnFecharClick
      NumGlyphs = 2
    end
    object BtnAjuda: TBitBtn
      Left = 384
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Ajuda'
      Caption = 'A&juda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BtnAjudaClick
      NumGlyphs = 2
    end
    object BtnTodos: TBitBtn
      Left = 143
      Top = 11
      Width = 75
      Height = 25
      Hint = 'Marcar todos os m�dulos'
      Caption = '&Todos'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnTodosClick
    end
  end
  object Lista: TCheckListBox
    Left = 0
    Top = 0
    Width = 465
    Height = 373
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Items.Strings = (
      'Formul�rio Principal ( Princ.Pas; Princ.Dfm; Princ.Res )'
      'Defini��o da Base de Dados ( BaseD.Pas; BaseD.Dfm; BaseD.Dti )'
      'Abertura de Tabelas ( Abertura.Pas; Abertura.Dfm )'
      'Atributos de Campos das Tabelas ( Atributo.Pas )'
      'Estrutura de Campos das Tabelas ( Estrutur.Pas )'
      'Classe de Defini��o das Tabelas ( Tabela.Pas )'
      'Lista de Tabelas ( LTab.Pas; LTab.Inc )'
      'Formul�rio de Pesquisa ( GridPesquisa.Pas; GridPesquisa.Dfm )'
      'Formul�rio Adapter ( Princ_Adapter.Pas; Princ_Adapter.Dfm )'
      'Seleciona Empresa - Adapter ( Emp_Adapter.Pas; Emp_Adapter.Dfm )'
      'Campo Adapter ( Campo_Adapter.Pas; Campo_Adapter.Dfm )'
      'Tela de Apresenta��o ( Splash.Pas; Splash.Dfm )'
      'Rotinas Internas ( Rotinas.Pas )'
      'Rotinas de Edi��o ( RotinaEd.Pas )'
      'Localiza��o de Registros ( Pesquisa_Ed.Pas;Pesquisa_Ed.Dfm )'
      'Rotinas de Valida��o de Campos ( Validar.Pas )'
      'Declara��o de Vari�veis P�blicas ( Publicas.Pas )'
      'Componentes Extras ( Extras.Pas )'
      'Chamada de Formul�rios Interno ( Interno.Pas )'
      'Calend�rio ( Calend.Pas; Calend.Dfm )'
      'Calculadora ( Calculad.Pas; Calculad.Dfm )'
      'Agenda de Telefones ( Agenda.Pas; Agenda.Dfm )'
      'Edi��o da Agenda ( AgEdit.Pas; AgEdit.Dfm )'
      'Acesso de Usu�rios ( Acesso.Pas; Acesso.Dfm )'
      'Configura��o de Senhas ( Senhas.Pas; Senhas.Dfm )'
      'Edi��o de Usu�rios ( EdUsr.Pas; EdUsr.Dfm )'
      'Edi��o de Grupos de Usu�rios ( EdGrp.Pas; EdGrp.Dfm )'
      
        'Configura��o de Empresas Usu�rias ( CfgEmp.Pas; CfgEmp.Dfm; CfgE' +
        'mp.Res )'
      
        'Log de Opera��es (LogOperacoes.Pas;LogOperacoes.Dfm;LogProcura.P' +
        'as;LogProcura.Dfm)'
      'Sele��o de Empresas Usu�rias ( SelEmp.Pas; SelEmp.Dfm )'
      
        'Configura��o do Ambiente de Trabalho ( Ambiente.Pas; Ambiente.Df' +
        'm )'
      'Configura��o da Filtragem em Tabelas ( Filtro.Pas; Filtro.Dfm )'
      'Bate Papo em Rede ( BatePapo.Pas; BatePapo.Dfm )'
      'C�pia de Seguran�a ( Backup.Pas; Backup.Dfm )'
      'Restaura��o de C�pia de Seguran�a ( Restaura.Pas; Restaura.Dfm )'
      
        'Utilit�rio de Compacta��o de Dados ( CabIntF.Pas; CabStComps.Pas' +
        '; CabStConsts.Pas; CabiNet.Dll )'
      'Formul�rio de Mensagem de Processo ( Aguarde.Pas; Aguarde.Dfm )'
      'Visualizador de Relat�rios ( Fr_View.Pas;Fr_View.Dfm;Fr.Inc )'
      
        'Utilit�rios para SMTP (Fr_NetUtils.Pas;FR_Progress.Pas;FR_Progre' +
        'ss.dfm;FR_Export_email.pas;FR_Export_email.dfm;FR_SMTP.pas)'
      'Configura��o de Impress�o ( OpcRel.Pas;OpcRel.Dfm )'
      'Sobre ( Sobre.Pas; Sobre.Dfm )')
    ParentFont = False
    TabOrder = 0
  end
end
