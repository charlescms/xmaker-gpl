object FormOpcAcesso: TFormOpcAcesso
  Left = 191
  Top = 129
  BorderStyle = bsDialog
  Caption = 'Opções de Acesso'
  ClientHeight = 345
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 310
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 3
      Width = 70
      Height = 13
      Caption = '&Menu Principal'
      FocusControl = TreeMenu
    end
    object Label2: TLabel
      Left = 196
      Top = 3
      Width = 68
      Height = 13
      Caption = '&Barra Principal'
      FocusControl = TreeBarra
    end
    object Label3: TLabel
      Left = 384
      Top = 3
      Width = 38
      Height = 13
      Caption = '&Tabelas'
      FocusControl = TreeTabela
    end
    object TreeMenu: TTreeView
      Left = 8
      Top = 18
      Width = 185
      Height = 228
      Ctl3D = True
      Indent = 19
      ParentCtl3D = False
      TabOrder = 0
      OnChange = TreeMenuChange
    end
    object TreeBarra: TTreeView
      Left = 196
      Top = 18
      Width = 185
      Height = 228
      Ctl3D = True
      Images = FormPrincipal.ListaImagem
      Indent = 19
      ParentCtl3D = False
      RightClickSelect = True
      ShowLines = False
      ShowRoot = False
      TabOrder = 2
      OnChange = TreeMenuChange
    end
    object TreeTabela: TTreeView
      Left = 384
      Top = 18
      Width = 185
      Height = 228
      Indent = 19
      TabOrder = 3
    end
    object AcessoTabela: TGroupBox
      Left = 384
      Top = 246
      Width = 185
      Height = 61
      Caption = ' Rotinas Cerceadas '
      TabOrder = 4
      object Modificar: TCheckBox
        Left = 8
        Top = 27
        Width = 66
        Height = 17
        Caption = 'Modificar'
        TabOrder = 1
      end
      object Excluir: TCheckBox
        Left = 8
        Top = 42
        Width = 66
        Height = 17
        Caption = 'Excluir'
        TabOrder = 2
      end
      object Filtrar: TCheckBox
        Left = 99
        Top = 12
        Width = 66
        Height = 17
        Caption = 'Filtrar'
        TabOrder = 3
      end
      object Incluir: TCheckBox
        Left = 8
        Top = 12
        Width = 52
        Height = 17
        Caption = 'Incluir'
        TabOrder = 0
      end
    end
    object BtnAcessoMenu: TBitBtn
      Left = 102
      Top = 251
      Width = 185
      Height = 56
      Caption = 'Acesso Permitido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnAcessoMenuClick
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 310
    Width = 579
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnAjuda: TBitBtn
      Left = 495
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Ajuda'
      Caption = 'A&juda'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Kind = bkHelp
    end
    object BtnOk: TBitBtn
      Left = 414
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Fechar'
      Cancel = True
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
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
        03030303030303030303030303030303030303030303FF030303030303030303
        03030303030303040403030303030303030303030303030303F8F8FF03030303
        03030303030303030303040202040303030303030303030303030303F80303F8
        FF030303030303030303030303040202020204030303030303030303030303F8
        03030303F8FF0303030303030303030304020202020202040303030303030303
        0303F8030303030303F8FF030303030303030304020202FA0202020204030303
        0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
        040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
        03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
        FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
        0303030303030303030303FA0202020403030303030303030303030303F8FF03
        03F8FF03030303030303030303030303FA020202040303030303030303030303
        0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
        03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
        030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
        0202040303030303030303030303030303F8FF03F8FF03030303030303030303
        03030303FA0202030303030303030303030303030303F8FFF803030303030303
        030303030303030303FA0303030303030303030303030303030303F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      NumGlyphs = 2
    end
  end
  object TabOpcao: TTable
    DatabaseName = 'c:\temp'
    TableName = 'SYSOPC.DB'
    Left = 302
    Top = 314
    object TabOpcaoOpcao: TStringField
      FieldName = 'Opcao'
      Size = 70
    end
    object TabOpcaoGrupo: TStringField
      FieldName = 'Grupo'
      Size = 4
    end
    object TabOpcaoPermitido: TBooleanField
      FieldName = 'Permitido'
    end
    object TabOpcaoPorSenha: TBooleanField
      FieldName = 'PorSenha'
    end
  end
  object ArqOpcao: TDataSource
    DataSet = TabOpcao
    Left = 274
    Top = 314
  end
  object ArqTabela: TDataSource
    DataSet = TabTabela
    Left = 334
    Top = 314
  end
  object TabTabela: TTable
    DatabaseName = 'c:\temp'
    TableName = 'SYSTAB.DB'
    Left = 362
    Top = 314
    object TabTabelaTabela: TStringField
      FieldName = 'Tabela'
      Size = 4
    end
    object TabTabelaGrupo: TStringField
      FieldName = 'Grupo'
      Size = 4
    end
    object TabTabelaCerceado: TStringField
      FieldName = 'Cerceado'
      Size = 10
    end
  end
end
