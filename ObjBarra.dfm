object FormBarraF: TFormBarraF
  Left = 168
  Top = 108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Definição de Barra de Ferramentas'
  ClientHeight = 376
  ClientWidth = 529
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
    0000000000000000000000000000888888807888800077777780777780008000
    0780780008008FFF0780783338008FFF0780783338008FFF878078B333008FF8
    8780787008008F88778078BB788088877780788888807777778077777780FFFF
    FFF0FFFFFFF8777777777777777888888888888888880000000000000000FFFF
    2C04FFFF00000107000001070000010300000103000001030000010300000103
    0000010100000101000001010000010000000000000000000000FFFF0000}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 248
    Top = 0
    Width = 281
    Height = 30
    AutoSize = True
    TabOrder = 0
    object ToolBar: TToolBar
      Left = 11
      Top = 2
      Width = 264
      Height = 22
      AutoSize = True
      Caption = 'ToolBar'
      EdgeBorders = []
      Flat = True
      Images = FormPrincipal.ListaImagem
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object BtnNovo: TToolButton
        Left = 0
        Top = 0
        Hint = 'Inserir Novo Item ( Insert )'
        Caption = 'BtnNovo'
        DropdownMenu = PopInserir
        ImageIndex = 57
        Style = tbsDropDown
      end
      object BtnDeletar: TToolButton
        Left = 36
        Top = 0
        Hint = 'Deletar Item Selecionado ( Del )'
        Caption = 'BtnDeletar'
        ImageIndex = 58
        OnClick = BtnDeletarClick
      end
      object BtnModificar: TToolButton
        Left = 59
        Top = 0
        Hint = 'Modificar Propriedades ( F2 )'
        ImageIndex = 43
        OnClick = BtnModificarClick
      end
    end
  end
  object PageObject: TPageControl
    Left = 0
    Top = 0
    Width = 241
    Height = 337
    ActivePage = TabPropriedades
    HotTrack = True
    TabOrder = 1
    object TabPropriedades: TTabSheet
      Caption = 'Propriedades'
      object Label2: TLabel
        Left = 2
        Top = 40
        Width = 52
        Height = 13
        Caption = '&Mensagem'
        FocusControl = EdMensagem
      end
      object Label3: TLabel
        Left = 2
        Top = 78
        Width = 37
        Height = 13
        Caption = '&Imagem'
        FocusControl = ComboImagem
      end
      object Label5: TLabel
        Left = 2
        Top = 116
        Width = 45
        Height = 13
        Caption = '&Programa'
        FocusControl = ComboPrograma
      end
      object Label1: TLabel
        Left = 2
        Top = 2
        Width = 28
        Height = 13
        Caption = '&Título'
        FocusControl = EdTitulo
      end
      object EdMensagem: TEdit
        Left = 2
        Top = 54
        Width = 228
        Height = 21
        Enabled = False
        TabOrder = 1
        OnKeyPress = EdMensagemKeyPress
      end
      object ComboImagem: TComboBox
        Left = 2
        Top = 92
        Width = 106
        Height = 19
        Style = csOwnerDrawVariable
        Enabled = False
        ItemHeight = 13
        TabOrder = 2
        OnDrawItem = ComboImagemDrawItem
        OnKeyPress = EdMensagemKeyPress
        OnMeasureItem = ComboImagemMeasureItem
      end
      object ComboPrograma: TComboBox
        Left = 2
        Top = 130
        Width = 228
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        TabOrder = 3
        OnKeyPress = EdMensagemKeyPress
      end
      object BtnAtualizar: TButton
        Left = 72
        Top = 284
        Width = 75
        Height = 25
        Hint = 'Confirma'
        Caption = '&Confirma'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = BtnAtualizarClick
      end
      object BtnCancela: TButton
        Left = 154
        Top = 284
        Width = 75
        Height = 25
        Hint = 'Cancela'
        Caption = 'Ca&ncela'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BtnCancelaClick
      end
      object EdTitulo: TEdit
        Left = 2
        Top = 16
        Width = 228
        Height = 21
        Enabled = False
        TabOrder = 0
        OnKeyPress = EdMensagemKeyPress
      end
    end
  end
  object ListaBotoes: TTreeView
    Left = 248
    Top = 30
    Width = 281
    Height = 307
    Color = clMenu
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HotTrack = True
    Indent = 19
    ParentFont = False
    ReadOnly = True
    RightClickSelect = True
    ShowLines = False
    ShowRoot = False
    TabOrder = 2
    OnChange = ListaBotoesChange
    OnDblClick = ListaBotoesDblClick
    OnKeyUp = ListaBotoesKeyUp
  end
  object BtnGravar: TBitBtn
    Left = 287
    Top = 345
    Width = 75
    Height = 25
    Hint = 'Gravar definição da barra de ferramentas'
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnGravarClick
  end
  object BtnFechar: TBitBtn
    Left = 367
    Top = 345
    Width = 75
    Height = 25
    Hint = 'Fechar definição'
    Caption = '&Fechar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BtnFecharClick
    NumGlyphs = 2
  end
  object BtnAjuda: TBitBtn
    Left = 447
    Top = 345
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object PopInserir: TPopupMenu
    Left = 5
    Top = 303
    object SubMenu: TMenuItem
      Caption = 'Sub-Menu'
      Hint = 'Inserir Sub-Menu'
    end
    object Formulario: TMenuItem
      Caption = 'Formulário'
      Hint = 'Inserir Formulário Definido no Projeto'
      OnClick = FormularioClick
    end
    object RotinaAvulsa: TMenuItem
      Caption = 'Rotina Avulsa'
      Hint = 
        'Inserir Rotina Avulsa ( Editar o Evento Ao Clicar para Codificaç' +
        'ão )'
      OnClick = RotinaAvulsaClick
    end
    object ProgramaExternoEXE: TMenuItem
      Caption = 'Programa Externo (EXE)'
      OnClick = ProgramaExternoEXEClick
    end
    object Separacao: TMenuItem
      Caption = 'Separação'
      Hint = 'Inserir Linha de Separação de Opções'
      OnClick = SeparacaoClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Arquivo: TMenuItem
      Caption = 'Arquivo'
      Hint = 'Opções do Sub-Menu Arquivo'
      object ConfiguraodeSenhas: TMenuItem
        Caption = 'Configuração de Senhas'
        OnClick = ConfiguraodeSenhasClick
      end
      object EmpresaUsuria: TMenuItem
        Caption = 'Empresa Usuária'
        OnClick = EmpresaUsuriaClick
      end
      object CpiadeSegurana: TMenuItem
        Caption = 'Cópia de Segurança'
        object Copiar: TMenuItem
          Caption = 'Copiar'
          OnClick = CopiarClick
        end
        object Restaurar: TMenuItem
          Caption = 'Restaurar'
          OnClick = RestaurarClick
        end
      end
      object ConfiguraImpressora: TMenuItem
        Caption = 'Configura Impressora'
        OnClick = ConfiguraImpressoraClick
      end
      object OutroUsurio: TMenuItem
        Caption = 'Outro Usuário'
        OnClick = OutroUsurioClick
      end
      object Sair: TMenuItem
        Caption = 'Sair'
        OnClick = SairClick
      end
    end
    object Exibir: TMenuItem
      Caption = 'Exibir'
      Hint = 'Opções do Sub-Menu Exibir'
      object Ambiente1: TMenuItem
        Caption = 'Ambiente'
        OnClick = Ambiente1Click
      end
      object Calendrio: TMenuItem
        Caption = 'Calendário'
        OnClick = CalendrioClick
      end
      object Calculadora: TMenuItem
        Caption = 'Calculadora'
        OnClick = CalculadoraClick
      end
      object Agenda: TMenuItem
        Caption = 'Agenda'
        OnClick = AgendaClick
      end
      object Assistente: TMenuItem
        Caption = 'Assistente'
        OnClick = AssistenteClick
      end
    end
    object Janelas: TMenuItem
      Caption = 'Janelas'
      Hint = 'Opções do Sub-Menu Janelas'
      object Cascata: TMenuItem
        Caption = 'Cascata'
        OnClick = CascataClick
      end
      object Horizontal: TMenuItem
        Caption = 'Horizontal'
        OnClick = HorizontalClick
      end
      object Vertical: TMenuItem
        Caption = 'Vertical'
        OnClick = VerticalClick
      end
      object MinimizaTodas: TMenuItem
        Caption = 'Minimiza Todas'
        OnClick = MinimizaTodasClick
      end
      object Organizarcones: TMenuItem
        Caption = 'Organizar Ícones'
        OnClick = OrganizarconesClick
      end
    end
    object Ajuda: TMenuItem
      Caption = 'Ajuda'
      Hint = 'Opções do Sub-Menu Ajuda'
      object Contedo: TMenuItem
        Caption = 'Conteúdo'
        OnClick = ContedoClick
      end
      object TpicosdaAjuda: TMenuItem
        Caption = 'Tópicos da Ajuda'
        OnClick = TpicosdaAjudaClick
      end
      object Sobre: TMenuItem
        Caption = 'Sobre ...'
        OnClick = SobreClick
      end
    end
  end
end
