object FormEdGrp: TFormEdGrp
  Left = 265
  Top = 178
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Grupo'
  ClientHeight = 444
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = formclose
  OnKeyPress = formkeypress
  OnShow = formshow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelInf: TPanel
    Left = 0
    Top = 409
    Width = 482
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnCancelar: TBitBtn
      Left = 401
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Cancelar sem gravar'
      Caption = '&Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      NumGlyphs = 2
    end
    object BtnGravar: TBitBtn
      Left = 318
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Gravar e finalizar'
      Cancel = True
      Caption = '&Gravar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BTNGRAVARclick
      NumGlyphs = 2
    end
  end
  object PageUsuario: TPageControl
    Left = 7
    Top = 8
    Width = 469
    Height = 400
    ActivePage = PagUsr
    TabOrder = 0
    object PagUsr: TTabSheet
      Caption = 'Propriedades'
      object Label1: TLabel
        Left = 2
        Top = 10
        Width = 52
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Grupo'
      end
      object Label2: TLabel
        Left = 2
        Top = 34
        Width = 52
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descrição'
      end
      object Label3: TLabel
        Left = 1
        Top = 57
        Width = 224
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Opções de Acesso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7021576
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 235
        Top = 57
        Width = 224
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Tabela de Dados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7021576
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Shape1: TShape
        Left = 234
        Top = 71
        Width = 226
        Height = 211
        Pen.Color = 7021576
      end
      object EdGrupo: TEdit
        Left = 57
        Top = 7
        Width = 48
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 4
        TabOrder = 0
        OnExit = EDGRUPOexit
      end
      object EdDescricao: TEdit
        Left = 57
        Top = 31
        Width = 208
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 1
      end
      object lbTabelas: TListBox
        Left = 235
        Top = 72
        Width = 224
        Height = 209
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 3
        OnClick = LBTABELASclick
      end
      object AcessoTabela: TGroupBox
        Left = 235
        Top = 303
        Width = 224
        Height = 66
        Caption = ' Operações Cerceadas  '
        TabOrder = 4
        object Modificar: TCheckBox
          Left = 8
          Top = 29
          Width = 66
          Height = 17
          Caption = 'Modificar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ModificarClick
        end
        object Excluir: TCheckBox
          Left = 8
          Top = 44
          Width = 66
          Height = 17
          Caption = 'Excluir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ExcluirClick
        end
        object Filtrar: TCheckBox
          Left = 79
          Top = 14
          Width = 61
          Height = 17
          Caption = 'Filtrar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = FiltrarClick
        end
        object Incluir: TCheckBox
          Left = 8
          Top = 14
          Width = 52
          Height = 17
          Caption = 'Incluir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = INCLUIRclick
        end
        object Totalizar: TCheckBox
          Left = 79
          Top = 29
          Width = 66
          Height = 17
          Caption = 'Totalizar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = TotalizarClick
        end
        object Imprimir: TCheckBox
          Left = 79
          Top = 44
          Width = 98
          Height = 17
          Caption = 'Listar (Imprimir)'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = ImprimirClick
        end
      end
      object AcessoMenu: TRadioGroup
        Left = 1
        Top = 303
        Width = 224
        Height = 66
        Caption = ' Acesso '
        Items.Strings = (
          'Livre'
          'Por Senha ( Usuário Master )'
          'Invisível')
        TabOrder = 2
        OnClick = ACESSOMENUclick
      end
      object Notebook1: TNotebook
        Left = 3
        Top = 72
        Width = 224
        Height = 209
        PageIndex = 2
        TabOrder = 5
        object TPage
          Left = 0
          Top = 0
          Caption = 'MenuLateral'
          object ShapeOpcoes: TShape
            Left = 0
            Top = 0
            Width = 224
            Height = 209
            Align = alClient
            Pen.Color = 7021576
          end
          object TreeOpcoes: TTreeView
            Left = 1
            Top = 1
            Width = 222
            Height = 207
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HotTrack = True
            Images = FormPrincipal.ListaImagem
            Indent = 19
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnChange = TREEOPCOESchange
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'MenuSuperior'
          object Shape2: TShape
            Left = 0
            Top = 0
            Width = 224
            Height = 209
            Align = alClient
            Pen.Color = 7021576
          end
          object TreeMenuSup: TTreeView
            Left = 1
            Top = 1
            Width = 222
            Height = 207
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HotTrack = True
            Images = FormPrincipal.ListaImagem
            Indent = 19
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnChange = TreeMenuSupChange
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'BarraFerramentas'
          object Shape3: TShape
            Left = 0
            Top = 0
            Width = 224
            Height = 209
            Align = alClient
            Pen.Color = 7021576
          end
          object TreeBarra: TTreeView
            Left = 1
            Top = 1
            Width = 222
            Height = 207
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HotTrack = True
            Images = FormPrincipal.ListaImagem
            Indent = 19
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnChange = TreeBarraChange
          end
        end
      end
      object TabSet1: TTabSet
        Left = 3
        Top = 282
        Width = 224
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Tabs.Strings = (
          'Menu Lateral'
          'Menu Superior'
          'Barra F.')
        TabIndex = 0
        OnClick = TABSET1click
      end
    end
  end
end
