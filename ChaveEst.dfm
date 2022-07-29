object FormChaveEst: TFormChaveEst
  Left = 232
  Top = 145
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Associa chave estrangeira'
  ClientHeight = 405
  ClientWidth = 550
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
    00000000000000000000000000000000000000FFFF000000000000F77F000000
    000000FFFF0000000080044444400FFFF008044444400F77F000000000000FFF
    F08000000000444444008000000044444408000FFFF000000000080F77F00000
    0000000FFFF0000000000044444400000000004444440000000000000000FFFF
    C804FF810F00FF810F00FF810F00FF01F7BD000100000081000003FF000001FF
    00000040000002000000FF80EF7BFFC00000FFC00000FFC00F00FFFF0F00}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnOk: TButton
    Left = 390
    Top = 375
    Width = 75
    Height = 25
    Hint = 'Inserir relacionamento'
    Caption = '&Ok'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object BtnFechar: TButton
    Left = 470
    Top = 375
    Width = 75
    Height = 25
    Hint = 'Fechar'
    Caption = '&Cancelar'
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 5
    Top = 5
    Width = 540
    Height = 364
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Chave Estrangeira'
      object Bevel1: TBevel
        Left = 3
        Top = 2
        Width = 526
        Height = 331
      end
      object Label1: TLabel
        Left = 9
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Tabela'
      end
      object Label2: TLabel
        Left = 301
        Top = 8
        Width = 86
        Height = 13
        Caption = 'Relacionada com:'
      end
      object Label3: TLabel
        Left = 8
        Top = 45
        Width = 33
        Height = 13
        Caption = 'Campo'
      end
      object Label4: TLabel
        Left = 301
        Top = 45
        Width = 33
        Height = 13
        Caption = 'Campo'
      end
      object Label5: TLabel
        Left = 9
        Top = 112
        Width = 514
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campo(s) de associa'#231#227'o'
      end
      object Label6: TLabel
        Left = 280
        Top = 186
        Width = 216
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos a serem mostrados'
      end
      object BtnMoveParaCima: TSpeedButton
        Left = 499
        Top = 214
        Width = 23
        Height = 22
        Hint = 'Mover campo para cima'
        Flat = True
        Glyph.Data = {
          16010000424D1601000000000000760000002800000010000000140000000100
          040000000000A000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          888888888800088888888888880F088888888888880008888888888888888888
          888888888800088888888888880F088888888888880008888888888888888888
          888888800000000088888880FFFFFFF0888888880FFFFF08888888880FFFFF08
          888888880FFFFF088888888880FFF0888888888880FFF08888888888880F0888
          88888888880F0888888888888880888888888888888088888888}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveParaCimaClick
      end
      object BtnMoveParaBaixo: TSpeedButton
        Left = 499
        Top = 245
        Width = 23
        Height = 22
        Hint = 'Mover campo para baixo'
        Flat = True
        Glyph.Data = {
          16010000424D1601000000000000760000002800000010000000140000000100
          040000000000A000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888808888888888888880888888888888880F088888888888880F0888
          8888888880FFF0888888888880FFF088888888880FFFFF08888888880FFFFF08
          888888880FFFFF0888888880FFFFFFF088888880000000008888888888888888
          888888888800088888888888880F088888888888880008888888888888888888
          888888888800088888888888880F088888888888880008888888}
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnMoveParaBaixoClick
      end
      object Label7: TLabel
        Left = 9
        Top = 186
        Width = 216
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campos da Tabela Relacionada'
      end
      object BtnInserirCmp: TSpeedButton
        Left = 241
        Top = 214
        Width = 23
        Height = 22
        Hint = 'Inserir Campo'
        Flat = True
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
        OnClick = BtnInserirCmpClick
      end
      object BtnExcluirCmp: TSpeedButton
        Left = 241
        Top = 245
        Width = 23
        Height = 22
        Hint = 'Excluir Campo'
        Flat = True
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
        OnClick = BtnExcluirCmpClick
      end
      object Label8: TLabel
        Left = 9
        Top = 284
        Width = 86
        Height = 13
        Caption = 'Estilo de Pesquisa'
      end
      object Label9: TLabel
        Left = 31
        Top = 309
        Width = 64
        Height = 13
        Caption = 'Filtragem Fixa'
      end
      object Label10: TLabel
        Left = 280
        Top = 284
        Width = 72
        Height = 13
        Caption = 'Pesquisar ap'#243's'
      end
      object EdTabela: TEdit
        Left = 9
        Top = 22
        Width = 221
        Height = 21
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
      object ComboTab: TComboBox
        Left = 301
        Top = 22
        Width = 221
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = ComboTabExit
        OnExit = ComboTabExit
      end
      object CamposEdTabela: TListBox
        Left = 9
        Top = 59
        Width = 221
        Height = 48
        TabStop = False
        Color = clBtnFace
        ItemHeight = 13
        TabOrder = 2
      end
      object CamposComboTab: TListBox
        Left = 301
        Top = 59
        Width = 221
        Height = 48
        ItemHeight = 13
        TabOrder = 3
      end
      object CamposRelacionados: TListBox
        Left = 9
        Top = 126
        Width = 514
        Height = 57
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 4
      end
      object BtnInserir: TBitBtn
        Left = 244
        Top = 73
        Width = 45
        Height = 25
        Hint = 'Inserir relacionamento'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BtnInserirClick
        Glyph.Data = {
          1E010000424D1E010000000000007600000028000000170000000E0000000100
          040000000000A800000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888808888888888888888888888808888888888808888888888808888
          8888880B0888888888808888888880BBB08888888880888888880BBBBB088888
          888080000000BBBBBBB0000000808000000BBBBBBBBB0000008080000000BBBB
          BBB000000080888888880BBBBB08888888808888888880BBB088888888808888
          8888880B08888888888088888888888088888888888088888888888888888888
          8880}
      end
      object CamposMostrados: TListBox
        Left = 280
        Top = 201
        Width = 216
        Height = 76
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 6
        OnDblClick = BtnExcluirCmpClick
      end
      object CamposOrigem: TListBox
        Left = 9
        Top = 201
        Width = 216
        Height = 76
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 7
        OnDblClick = BtnInserirCmpClick
      end
      object EdEstilo: TComboBox
        Left = 101
        Top = 280
        Width = 125
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 8
        OnChange = EdEstiloChange
        Items.Strings = (
          'Combo Drop'
          'Formul'#225'rio')
      end
      object EdFiltroMestre: TComboEdit
        Left = 101
        Top = 305
        Width = 125
        Height = 21
        Hint = 
          'Informe a express'#227'o de filtragem/sele'#231#227'o "Fixa",'#13#10'essa express'#227'o' +
          ' ser'#225' permanente.'#13#10'Exemplo: Sistema multiempresa em uma mesma ta' +
          'bela.'
        HelpContext = 150
        Color = clBtnFace
        DirectInput = False
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
        MaxLength = 80
        NumGlyphs = 1
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 9
        OnButtonClick = EdFiltroMestreButtonClick
      end
      object EdAcao: TComboBox
        Left = 358
        Top = 280
        Width = 139
        Height = 21
        Hint = 
          'Informe o como ser'#225' disparado a pesquisa na tabela.'#13#10'"Cada d'#237'git' +
          'o": Dispara a pesquisa a cada d'#237'gito do usu'#225'rio.'#13#10'"Enter": Dispa' +
          'ra a pesquisa quando o usu'#225'rio teclar Enter.'#13#10'Somente para o Est' +
          'ilo de Pesquisa: "Formul'#225'rio".'
        Style = csDropDownList
        Color = clBtnFace
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        Items.Strings = (
          'Cada caractere'
          'Enter')
      end
    end
  end
end
