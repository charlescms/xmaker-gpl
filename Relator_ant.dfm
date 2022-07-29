object FormRelatorio_ant: TFormRelatorio_ant
  Left = 198
  Top = 148
  HelpContext = 250
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Editor de Relatórios'
  ClientHeight = 432
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000010000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF00000000000
    00000000000000000F33F0000000000000FFFFFFFFFFFFFF0FFFF00000000000
    00FFFFFFFFFFFFFF0F33F0000000000000F0000F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F33F0000000000000F3333F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F33F0000000000000F3333F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F00F0000000000000F3333F3333333F0FFFF00000000000
    00FFFFFFFFFFFFFF0F00F0000000000000F0000F0000000F0FFFF00000000000
    00FFFFFFFFFFFFFF0F00F0000000000000F0000F0000000F0FFFF00000000000
    00FFFFFFFFFFFFFF0FFFF0000000000000FFFFFFFF00000F0000000000000000
    00FFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF0000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0003FFFE0003FFFE0003FFE00
    003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00
    003FFC00003FFC00003FFC00003FFC00003FFC00003FFC00007FFC0007FFFC00
    07FFFC000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 571
    Height = 399
    ActivePage = TabPrincipal
    Align = alTop
    HotTrack = True
    TabOrder = 0
    object TabPrincipal: TTabSheet
      HelpContext = 260
      Caption = 'Principal ( &1 ) '
      object Bevel1: TBevel
        Left = 10
        Top = 5
        Width = 518
        Height = 89
      end
      object Label1: TLabel
        Left = 22
        Top = 9
        Width = 28
        Height = 13
        Caption = 'Título'
      end
      object Label3: TLabel
        Left = 22
        Top = 49
        Width = 21
        Height = 13
        Caption = 'Tipo'
      end
      object Label4: TLabel
        Left = 142
        Top = 49
        Width = 48
        Height = 13
        Caption = 'Formulário'
      end
      object LbCampos: TLabel
        Left = 288
        Top = 104
        Width = 241
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos do Relatório'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object BtnPBaixoIndice: TSpeedButton
        Left = 534
        Top = 210
        Width = 23
        Height = 22
        Hint = 'Move campo para baixo'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330333333333
          33333373FFF33333333333300033333333333337773FFF333333333099000333
          33333337F37773FFF333333099999000333333373F3337773333333309999903
          333333337F3333733333333309999033333333337F3337F33333333309990033
          3333333373F3773F33333333309009033333333337F77373F333333330033090
          33333333377337373F33333330333309033333333733337F7F33333333333309
          033333333333337F7F3333333333330903333333333333737333333333333090
          3333333333333737333333333333090333333333333373733333333333309033
          333333333337F733333333333300033333333333337773333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnPBaixoIndiceClick
      end
      object BtnPCimaIndice: TSpeedButton
        Left = 534
        Top = 242
        Width = 23
        Height = 22
        Hint = 'Move Campo para Cima'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          33333333337773F33333333333309033333333333337373F3333333333330903
          3333333333337373F33333333333309033333333333337373F33333333333309
          033333333333337F7F333333333333090333333333F3337F7F33333330333309
          0333333337FF33737333333330033090333333333773F7373333333330900903
          3333333337377F733333333309990033333333337F3377F33333333309999033
          333333337F33373F3333333309999903333333337333337FF333333099999000
          33333337F33FF777333333309900033333333337FF7773333333333000333333
          3333333777333333333333033333333333333373333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnPCimaIndiceClick
      end
      object BtnInserirCmp: TSpeedButton
        Left = 259
        Top = 210
        Width = 23
        Height = 22
        Hint = 'Inserir Campo'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333FF3333333333333003333
          3333333333773FF3333333333309003333333333337F773FF333333333099900
          33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
          99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
          33333333337F3F77333333333309003333333333337F77333333333333003333
          3333333333773333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ListaCamposTabDblClick
      end
      object BtnExcluirCmp: TSpeedButton
        Left = 259
        Top = 242
        Width = 23
        Height = 22
        Hint = 'Excluir Campo'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333FF3333333333333003333333333333F77F33333333333009033
          333333333F7737F333333333009990333333333F773337FFFFFF330099999000
          00003F773333377777770099999999999990773FF33333FFFFF7330099999000
          000033773FF33777777733330099903333333333773FF7F33333333333009033
          33333333337737F3333333333333003333333333333377333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ListaCamposRelDblClick
      end
      object Label2: TLabel
        Left = 10
        Top = 104
        Width = 241
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Tabelas e Campos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 262
        Top = 49
        Width = 76
        Height = 13
        Caption = 'Tabela Principal'
      end
      object Ed_Titulo: TEdit
        Left = 22
        Top = 25
        Width = 498
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Ed_Tipo: TEdit
        Left = 22
        Top = 65
        Width = 113
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object Ed_Formulario: TEdit
        Left = 142
        Top = 65
        Width = 115
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object ListaCamposRel: TListBox
        Left = 288
        Top = 120
        Width = 241
        Height = 240
        HelpContext = 260
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 4
        OnDblClick = ListaCamposRelDblClick
      end
      object Ed_TabPrincipal: TEdit
        Left = 262
        Top = 65
        Width = 258
        Height = 21
        HelpContext = 260
        TabStop = False
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object ListaCamposTab: TTreeView
        Left = 10
        Top = 120
        Width = 241
        Height = 240
        HelpContext = 260
        Indent = 19
        ReadOnly = True
        TabOrder = 5
        OnDblClick = ListaCamposTabDblClick
      end
    end
    object TabRelacionamento: TTabSheet
      HelpContext = 270
      Caption = 'Relacionamento ( &2 ) '
      ImageIndex = 1
      object Bevel2: TBevel
        Left = 10
        Top = 5
        Width = 543
        Height = 223
      end
      object Label6: TLabel
        Left = 303
        Top = 17
        Width = 241
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos do Relatório'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 18
        Top = 17
        Width = 241
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Tabelas e Campos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 10
        Top = 234
        Width = 545
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Relacionamentos'
      end
      object ListaCamposRel2: TListBox
        Left = 303
        Top = 33
        Width = 241
        Height = 184
        HelpContext = 270
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = ListaCamposRelDblClick
      end
      object ListaCamposTab2: TTreeView
        Left = 18
        Top = 33
        Width = 241
        Height = 184
        HelpContext = 270
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnDblClick = ListaCamposTabDblClick
      end
      object BtnInserir: TBitBtn
        Left = 270
        Top = 113
        Width = 23
        Height = 22
        Hint = 'Inserir relacionamento'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BtnInserirClick
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
      object ListaRelacionamentos: TListBox
        Left = 10
        Top = 250
        Width = 543
        Height = 90
        HelpContext = 270
        ItemHeight = 13
        TabOrder = 3
      end
      object BtnExcluirR: TBitBtn
        Left = 530
        Top = 344
        Width = 23
        Height = 22
        Hint = 'Excluir relacionamento'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = BtnExcluirRClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
    object TabFiltragem: TTabSheet
      HelpContext = 280
      Caption = 'Filtragem ( &3 )'
      ImageIndex = 2
      object GroupBox2: TGroupBox
        Left = 10
        Top = 5
        Width = 542
        Height = 360
        HelpContext = 280
        Caption = ' Filtragem '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label9: TLabel
          Left = 8
          Top = 19
          Width = 233
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Campos do Relatório'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 265
          Top = 134
          Width = 24
          Height = 13
          Caption = '&Valor'
          FocusControl = EdExpressao
        end
        object Label11: TLabel
          Left = 8
          Top = 236
          Width = 526
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Expressão de Filtro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ListaCamposRel4: TListBox
          Left = 8
          Top = 33
          Width = 233
          Height = 198
          HelpContext = 280
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawVariable
          TabOrder = 0
        end
        object Operacao: TRadioGroup
          Left = 265
          Top = 27
          Width = 254
          Height = 79
          Hint = 'Operadores de comparação'
          HelpContext = 280
          Caption = ' O&peração '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            '=   Igual'
            '<> Diferente'
            '<   Menor que'
            '<= Menor ou Igual'
            '>   Maior que'
            '>= Maior ou Igual'
            '%  Contém'
            '?   Vazio')
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object EdExpressao: TEdit
          Left = 265
          Top = 151
          Width = 254
          Height = 21
          Hint = 
            'Informe o valor de atribuição'#13#10'Campo Data: Digite a data com bar' +
            'ras - Exemplo: 01/01/2002'#13#10'Campo Fracionário: Não digite '#39','#39' (Ví' +
            'rgula) para o valor decimal'
          HelpContext = 280
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object Composicao: TRadioGroup
          Left = 291
          Top = 177
          Width = 119
          Height = 33
          Hint = 
            'Composição lógica'#13#10'Exemplo I:'#13#10'Filtrar clientes como nome de '#39'JO' +
            'AO'#39' e da cidade de '#39'UBERABA'#39#13#10'(NOME = '#39'JOAO*'#39')'#13#10'AND (CIDADE = '#39'U' +
            'BERABA*'#39')'#13#10'Exemplo II:'#13#10'Filtrar clientes como nome de '#39'JOAO'#39' ou ' +
            #39'MARIA'#39#13#10'(NOME = '#39'JOAO*'#39')'#13#10'OR (NOME = '#39'MARIA*'#39')'
          HelpContext = 280
          Caption = ' Composição &Lógica '
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'e'
            'ou')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object BtnInserirFiltro: TBitBtn
          Left = 419
          Top = 184
          Width = 75
          Height = 25
          Hint = 'Inserir expressão de filtro'
          HelpContext = 280
          Caption = 'Inserir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = BtnInserirFiltroClick
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
        object ListaCampoFil: TListBox
          Left = 8
          Top = 250
          Width = 527
          Height = 79
          HelpContext = 280
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawVariable
          TabOrder = 6
        end
        object BtnExcluirFiltro: TBitBtn
          Left = 513
          Top = 333
          Width = 23
          Height = 22
          Hint = 'Excluir Filtro'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = BtnExcluirFiltroClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            300033FFFFFF3333377739999993333333333777777F3333333F399999933333
            3300377777733333337733333333333333003333333333333377333333333333
            3333333333333333333F333333333333330033333F33333333773333C3333333
            330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
            993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
            333333377F33333333FF3333C333333330003333733333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
        end
        object Valorusuario: TCheckBox
          Left = 265
          Top = 112
          Width = 153
          Height = 17
          HelpContext = 280
          Caption = 'Valor informado pelo usuário'
          TabOrder = 2
          OnExit = ValorusuarioExit
        end
        object BtnNegacao: TBitBtn
          Left = 482
          Top = 333
          Width = 23
          Height = 22
          Hint = 'Inverte valor lógico da expressão'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = BtnNegacaoClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333370733333333333333733333333333333000333
            3333333333777333333333333370733333333333333733333333333333333333
            3333333333333333333333333330333333333333333733333333333333707333
            3333333333373333333333333310133333333333337773333333333333000333
            3333333333777333333333333300033333333333337773333333333333000333
            3333333333777333333333333370733333333333333733333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
        end
      end
    end
    object TabOrdenacao: TTabSheet
      HelpContext = 290
      Caption = 'Ordenação ( &4 )'
      ImageIndex = 3
      object GroupBox1: TGroupBox
        Left = 10
        Top = 5
        Width = 544
        Height = 360
        HelpContext = 290
        Caption = ' Ordenação '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label21: TLabel
          Left = 8
          Top = 19
          Width = 233
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Campos do Relatório'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object BtnInserirInd: TSpeedButton
          Left = 248
          Top = 154
          Width = 23
          Height = 22
          Hint = 'Inserir Campo'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333FF3333333333333003333
            3333333333773FF3333333333309003333333333337F773FF333333333099900
            33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
            99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
            33333333337F3F77333333333309003333333333337F77333333333333003333
            3333333333773333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ListaCamposRel3DblClick
        end
        object BtnDeleteInd: TSpeedButton
          Left = 248
          Top = 190
          Width = 23
          Height = 22
          Hint = 'Excluir Campo'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333FF3333333333333003333333333333F77F33333333333009033
            333333333F7737F333333333009990333333333F773337FFFFFF330099999000
            00003F773333377777770099999999999990773FF33333FFFFF7330099999000
            000033773FF33777777733330099903333333333773FF7F33333333333009033
            33333333337737F3333333333333003333333333333377333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ListaCampoIndDblClick
        end
        object Label22: TLabel
          Left = 277
          Top = 19
          Width = 233
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'Campos de Ordenação'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object BtnIndBaixo: TSpeedButton
          Left = 515
          Top = 154
          Width = 23
          Height = 22
          Hint = 'Move campo para baixo'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330333333333
            33333373FFF33333333333300033333333333337773FFF333333333099000333
            33333337F37773FFF333333099999000333333373F3337773333333309999903
            333333337F3333733333333309999033333333337F3337F33333333309990033
            3333333373F3773F33333333309009033333333337F77373F333333330033090
            33333333377337373F33333330333309033333333733337F7F33333333333309
            033333333333337F7F3333333333330903333333333333737333333333333090
            3333333333333737333333333333090333333333333373733333333333309033
            333333333337F733333333333300033333333333337773333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnIndBaixoClick
        end
        object BtnIndCima: TSpeedButton
          Left = 515
          Top = 190
          Width = 23
          Height = 22
          Hint = 'Move Campo para Cima'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
            33333333337773F33333333333309033333333333337373F3333333333330903
            3333333333337373F33333333333309033333333333337373F33333333333309
            033333333333337F7F333333333333090333333333F3337F7F33333330333309
            0333333337FF33737333333330033090333333333773F7373333333330900903
            3333333337377F733333333309990033333333337F3377F33333333309999033
            333333337F33373F3333333309999903333333337333337FF333333099999000
            33333337F33FF777333333309900033333333337FF7773333333333000333333
            3333333777333333333333033333333333333373333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = BtnIndCimaClick
        end
        object ListaCamposRel3: TListBox
          Left = 8
          Top = 33
          Width = 233
          Height = 312
          HelpContext = 290
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawVariable
          TabOrder = 0
          OnDblClick = ListaCamposRel3DblClick
        end
        object ListaCampoInd: TListBox
          Left = 277
          Top = 33
          Width = 233
          Height = 312
          HelpContext = 290
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 16
          ParentFont = False
          Style = lbOwnerDrawVariable
          TabOrder = 1
          OnDblClick = ListaCampoIndDblClick
        end
      end
    end
  end
  object BtnGravar: TBitBtn
    Left = 332
    Top = 403
    Width = 75
    Height = 25
    Hint = 'Gravar relatório'
    Caption = '&Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = BtnGravarClick
  end
  object BtnFechar: TBitBtn
    Left = 412
    Top = 403
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
    Left = 492
    Top = 403
    Width = 75
    Height = 25
    Hint = 'Ajuda'
    Caption = 'A&juda'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BtnAjudaClick
    NumGlyphs = 2
  end
  object BtnLayout: TBitBtn
    Left = 172
    Top = 403
    Width = 75
    Height = 25
    Hint = 'Editar layout'
    HelpContext = 300
    Caption = '&Layout'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnLayoutClick
  end
  object BtnFonte: TBitBtn
    Left = 252
    Top = 403
    Width = 75
    Height = 25
    Hint = 'Editar fonte gerado'
    HelpContext = 310
    Caption = '&Editar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnFonteClick
  end
  object frReport_1: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 396
    ReportForm = {
      17000000210500001700000000130047656E65726963202F2054657874204F6E
      6C7900FF09000000340800009A0B000000000000000000000000000000000000
      000000FFFF000000000000000002000000000000000026000000F00200005000
      00003000020001000000000000000000FFFFFF1F000000000900667244617461
      53657400000000000000FFFF02000000000000000096000000F00200001B0000
      0030000E0001000000000000000000FFFFFF1F00000000090066724461746153
      657400000000000000FFFF020000000000000000DD000000F002000018000000
      3000050001000000000000000000FFFFFF1F000000000B006672444244617461
      53657400000000000000FFFF02000000000000000076010000F0020000160000
      003000010001000000000000000000FFFFFF1F00000000090066724461746153
      657400000000000000FFFF020000000000000000B7010000F002000012000000
      3000030001000000000000000000FFFFFF1F0000000009006672446174615365
      7400000000000000FFFF00000000000F00000026000000D50200005000000003
      000F0001000000000000000000FFFFFF1F2C020000000000000000000000FFFF
      0500417269616C000A000000000000000000020000000000020000000000FFFF
      FF000000000000000000100000002F0000007800000012000000030000000100
      0000000000000000FFFFFF1F2C02000000000001000E005B446174655D2C205B
      54696D655D00000000FFFF0500417269616C000A000000000000000000020000
      000000020000000000FFFFFF000000000000000000170200002F000000CC0000
      00120000000300000001000000000000000000FFFFFF1F2C0200000000000100
      0E0050E167696E61205B50616765235D00000000FFFF0500417269616C000A00
      0000000000000000010000000000020000000000FFFFFF000000000000000000
      0F00000047000000D5020000120000000300000001000000000000000000FFFF
      FF1F2C020000000000010020003C20446967697465206F2054ED74756C6F2064
      6F2052656C6174F372696F203E00000000FFFF0500417269616C000A00000002
      0000000000020000000000020000000000FFFFFF0000000000000000000F0000
      005E000000D5020000120000000300000001000000000000000000FFFFFF1F2C
      020000000000010020003C20446967697465206F2054ED74756C6F20646F2052
      656C6174F372696F203E00000000FFFF0500417269616C000A00000002000000
      0000020000000000020000000000FFFFFF0000000000000000000F0000009600
      0000D50200001900000003000F0001000000000000000000FFFFFF1F2C020000
      000000000000000000FFFF0500417269616C000A000000000000000000020000
      000000020000000000FFFFFF0000000000000000000F000000DD000000D50200
      00170000000300020001000000000000000000FFFFFF1F2C0200000000000000
      00000000FFFF0500417269616C000A0000000000000000000200000000000200
      00000000FFFFFF0000000000000000001300000076010000D502000016000000
      0300000001000000000000000000FFFFFF1F2C020000000000000000000000FF
      FF0500417269616C000A000000000000000000020000000000020000000000FF
      FFFF0000000000000000000F000000B7010000D5020000120000000300080001
      000000000000000000FFFFFF1F2C020000000000000000000000FFFF05004172
      69616C000A000000000000000000020000000000020000000000FFFFFF000000
      00FE00000000000000}
  end
  object frOLEObject1: TfrOLEObject
    Left = 67
    Top = 400
  end
  object frRichObject1: TfrRichObject
    Left = 83
    Top = 400
  end
  object frCheckBoxObject1: TfrCheckBoxObject
    Left = 91
    Top = 400
  end
  object frShapeObject1: TfrShapeObject
    Left = 99
    Top = 400
  end
  object frBarCodeObject1: TfrBarCodeObject
    Left = 115
    Top = 400
  end
  object frChartObject1: TfrChartObject
    Left = 130
    Top = 400
  end
  object frRoundRectObject1: TfrRoundRectObject
    Left = 124
    Top = 400
  end
  object frTextExport1: TfrTextExport
    Left = 108
    Top = 400
  end
  object frRTFExport1: TfrRTFExport
    Left = 76
    Top = 400
  end
  object frCSVExport1: TfrCSVExport
    Left = 36
    Top = 400
  end
  object frHTMExport1: TfrHTMExport
    Left = 4
    Top = 400
  end
  object frDesigner: TfrDesigner
    Left = 364
  end
  object frReport_2: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 428
    ReportForm = {
      17000000570500001700000000130047656E65726963202F2054657874204F6E
      6C7900FF09000000340800009A0B000000000000000000000000000000000000
      000000FFFF000000000000000002000000000000000026000000F00200005000
      00003000020001000000000000000000FFFFFF1F000000000900667244617461
      53657400000000000000FFFF0200000000000000002C010000F0020000F80000
      003000050001000000000000000000FFFFFF1F00000000010031000000000000
      00FFFF02000000000000000058020000F0020000120000003000030001000000
      000000000000FFFFFF1F00000000090066724461746153657400000000000000
      FFFF0200050042616E6431000000000096000000F00200001B00000030000E00
      01000000000000000000FFFFFF1F000000000900667244617461536574000000
      00000000FFFF0200050042616E64320000000000DD000000F002000018000000
      3000050001000000000000000000FFFFFF1F000000000B006672444244617461
      53657400000000000000FFFF00000000000F00000026000000D5020000500000
      0003000F0001000000000000000000FFFFFF1F2C020000000000000000000000
      FFFF0500417269616C000A000000000000000000020000000000020000000000
      FFFFFF000000000000000000100000002F000000780000001200000003000000
      01000000000000000000FFFFFF1F2C02000000000001000E005B446174655D2C
      205B54696D655D00000000FFFF0500417269616C000A00000000000000000002
      0000000000020000000000FFFFFF000000000000000000170200002F000000CC
      000000120000000300000001000000000000000000FFFFFF1F2C020000000000
      01000E0050E167696E61205B50616765235D00000000FFFF0500417269616C00
      0A000000000000000000010000000000020000000000FFFFFF00000000000000
      00000F00000047000000D5020000120000000300000001000000000000000000
      FFFFFF1F2C020000000000010020003C20446967697465206F2054ED74756C6F
      20646F2052656C6174F372696F203E00000000FFFF0500417269616C000A0000
      00020000000000020000000000020000000000FFFFFF0000000000000000000F
      0000005E000000D5020000120000000300000001000000000000000000FFFFFF
      1F2C020000000000010020003C20446967697465206F2054ED74756C6F20646F
      2052656C6174F372696F203E00000000FFFF0500417269616C000A0000000200
      00000000020000000000020000000000FFFFFF0000000000000000000F000000
      58020000D5020000120000000300080001000000000000000000FFFFFF1F2C02
      0000000000000000000000FFFF0500417269616C000A00000000000000000002
      0000000000020000000000FFFFFF000000000A0C005466724368617274566965
      7700000600436861727431000F0000003401000070020000EA00000001800000
      01000000000000000000FFFFFF002C020000000000000000000000FFFF000501
      0101000101000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000005004D656D6F31
      000F00000096000000D50200001900000003000F0001000000000000000000FF
      FFFF1F2C020000000000000000000000FFFF0500417269616C000A0000000000
      00000000020000000000020000000000FFFFFF00000000000005004D656D6F32
      000F000000DD000000D5020000170000000300020001000000000000000000FF
      FFFF1F2C020000000000000000000000FFFF0500417269616C000A0000000000
      00000000020000000000020000000000FFFFFF00000000FE00000000000000}
  end
  object QyRelatorio: TIBQuery
    BufferChunks = 1000
    CachedUpdates = False
    Left = 456
  end
  object frDBDataSet: TfrDBDataSet
    DataSet = QyRelatorio
    Left = 488
  end
  object frReport_3: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    StoreInDFM = True
    Left = 524
    ReportForm = {
      170000008E0000001700000000130047656E65726963202F2054657874204F6E
      6C7900FF09000000340800009A0B000000000000000000000000000000000000
      000000FFFF030000000000000002000000000000000096000000F00200009000
      00003000050001000000000000000000FFFFFF1F000000000B00667244424461
      746153657400000000000000FFFFFE00000000000000}
  end
end
