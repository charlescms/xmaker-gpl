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
      Hint = 'Fechar geração de fontes do projeto'
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
      Hint = 'Marcar todos os módulos'
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
      'Formulário Principal ( Princ.Pas; Princ.Dfm; Princ.Res )'
      'Definição da Base de Dados ( BaseD.Pas; BaseD.Dfm; BaseD.Dti )'
      'Abertura de Tabelas ( Abertura.Pas; Abertura.Dfm )'
      'Atributos de Campos das Tabelas ( Atributo.Pas )'
      'Estrutura de Campos das Tabelas ( Estrutur.Pas )'
      'Classe de Definição das Tabelas ( Tabela.Pas )'
      'Lista de Tabelas ( LTab.Pas; LTab.Inc )'
      'Formulário de Pesquisa ( GridPesquisa.Pas; GridPesquisa.Dfm )'
      'Formulário Adapter ( Princ_Adapter.Pas; Princ_Adapter.Dfm )'
      'Seleciona Empresa - Adapter ( Emp_Adapter.Pas; Emp_Adapter.Dfm )'
      'Campo Adapter ( Campo_Adapter.Pas; Campo_Adapter.Dfm )'
      'Tela de Apresentação ( Splash.Pas; Splash.Dfm )'
      'Rotinas Internas ( Rotinas.Pas )'
      'Rotinas de Edição ( RotinaEd.Pas )'
      'Localização de Registros ( Pesquisa_Ed.Pas;Pesquisa_Ed.Dfm )'
      'Rotinas de Validação de Campos ( Validar.Pas )'
      'Declaração de Variáveis Públicas ( Publicas.Pas )'
      'Componentes Extras ( Extras.Pas )'
      'Chamada de Formulários Interno ( Interno.Pas )'
      'Calendário ( Calend.Pas; Calend.Dfm )'
      'Calculadora ( Calculad.Pas; Calculad.Dfm )'
      'Agenda de Telefones ( Agenda.Pas; Agenda.Dfm )'
      'Edição da Agenda ( AgEdit.Pas; AgEdit.Dfm )'
      'Acesso de Usuários ( Acesso.Pas; Acesso.Dfm )'
      'Configuração de Senhas ( Senhas.Pas; Senhas.Dfm )'
      'Edição de Usuários ( EdUsr.Pas; EdUsr.Dfm )'
      'Edição de Grupos de Usuários ( EdGrp.Pas; EdGrp.Dfm )'
      
        'Configuração de Empresas Usuárias ( CfgEmp.Pas; CfgEmp.Dfm; CfgE' +
        'mp.Res )'
      
        'Log de Operações (LogOperacoes.Pas;LogOperacoes.Dfm;LogProcura.P' +
        'as;LogProcura.Dfm)'
      'Seleção de Empresas Usuárias ( SelEmp.Pas; SelEmp.Dfm )'
      
        'Configuração do Ambiente de Trabalho ( Ambiente.Pas; Ambiente.Df' +
        'm )'
      'Configuração da Filtragem em Tabelas ( Filtro.Pas; Filtro.Dfm )'
      'Bate Papo em Rede ( BatePapo.Pas; BatePapo.Dfm )'
      'Cópia de Segurança ( Backup.Pas; Backup.Dfm )'
      'Restauração de Cópia de Segurança ( Restaura.Pas; Restaura.Dfm )'
      
        'Utilitário de Compactação de Dados ( CabIntF.Pas; CabStComps.Pas' +
        '; CabStConsts.Pas; CabiNet.Dll )'
      'Formulário de Mensagem de Processo ( Aguarde.Pas; Aguarde.Dfm )'
      'Visualizador de Relatórios ( Fr_View.Pas;Fr_View.Dfm;Fr.Inc )'
      
        'Utilitários para SMTP (Fr_NetUtils.Pas;FR_Progress.Pas;FR_Progre' +
        'ss.dfm;FR_Export_email.pas;FR_Export_email.dfm;FR_SMTP.pas)'
      'Configuração de Impressão ( OpcRel.Pas;OpcRel.Dfm )'
      'Sobre ( Sobre.Pas; Sobre.Dfm )')
    ParentFont = False
    TabOrder = 0
  end
end
