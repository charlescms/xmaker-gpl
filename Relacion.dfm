object FormRelacionamento: TFormRelacionamento
  Left = 219
  Top = 149
  HelpContext = 170
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relacionamento'
  ClientHeight = 376
  ClientWidth = 548
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 4
    Top = 5
    Width = 540
    Height = 336
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Relacionamento'
      object Bevel1: TBevel
        Left = 3
        Top = 2
        Width = 526
        Height = 303
      end
      object Label1: TLabel
        Left = 9
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Tabela'
      end
      object Label2: TLabel
        Left = 300
        Top = 8
        Width = 86
        Height = 13
        Caption = 'Relacionada com:'
      end
      object Label3: TLabel
        Left = 8
        Top = 45
        Width = 44
        Height = 13
        Caption = 'Campo(s)'
      end
      object Label4: TLabel
        Left = 299
        Top = 45
        Width = 44
        Height = 13
        Caption = 'Campo(s)'
      end
      object Label5: TLabel
        Left = 9
        Top = 210
        Width = 514
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Campo(s) de associa��o'
      end
      object BtnExcluir: TSpeedButton
        Left = 329
        Top = 206
        Width = 23
        Height = 22
        Hint = 'Excluir associa��o'
        Enabled = False
        Flat = True
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
        ParentShowHint = False
        ShowHint = True
        OnClick = Excluir1Click
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
        Left = 300
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
        Height = 142
        TabStop = False
        Color = clBtnFace
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 2
        OnDrawItem = CamposEdTabelaDrawItem
      end
      object CamposComboTab: TListBox
        Left = 300
        Top = 59
        Width = 221
        Height = 142
        ItemHeight = 16
        Style = lbOwnerDrawFixed
        TabOrder = 3
        OnDrawItem = CamposEdTabelaDrawItem
      end
      object CamposRelacionados: TListBox
        Left = 9
        Top = 229
        Width = 513
        Height = 70
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 4
        OnClick = CamposRelacionadosClick
        OnKeyDown = CamposRelacionadosKeyDown
      end
      object BtnInserir: TBitBtn
        Left = 243
        Top = 117
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
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 343
    Width = 548
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Image2: TImage
      Left = 161
      Top = 5
      Width = 16
      Height = 16
      AutoSize = True
      Picture.Data = {
        07544269746D6170F6000000424DF60000000000000076000000280000001000
        0000100000000100040000000000800000000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00222222222222222222222222222222222222222222222222222222200000
        002222222228FFFFF02222222228888880222200000222222222228FFFF00000
        0022228F8888FFFFF022228FFFF888888022228F8888F0222222228FFFFFF022
        2222228444448022222222888888802222222222222222222222222222222222
        2222}
      Visible = False
    end
    object BtnOk: TButton
      Left = 386
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Inserir relacionamento'
      Caption = '&Ok'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnOkClick
    end
    object BtnFechar: TButton
      Left = 469
      Top = 3
      Width = 75
      Height = 25
      Hint = 'Fechar'
      Caption = '&Cancelar'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 184
    Top = 348
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
end