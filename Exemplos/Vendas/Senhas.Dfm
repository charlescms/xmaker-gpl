object FormSenhas: TFormSenhas
  Left = 366
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configuração de Senhas'
  ClientHeight = 370
  ClientWidth = 356
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
    Top = 339
    Width = 356
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Image2: TImage
      Left = 48
      Top = 7
      Width = 17
      Height = 17
      AutoSize = True
      Visible = False
    end
    object BtnOk: TBitBtn
      Left = 274
      Top = 2
      Width = 75
      Height = 25
      Hint = 'Finalizar'
      Cancel = True
      Caption = '&Ok'
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      NumGlyphs = 2
    end
    object BtnLog: TButton
      Left = 168
      Top = 2
      Width = 99
      Height = 25
      Hint = 'Log de Operações em Tabelas'
      Caption = 'Log de Operações'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BtnLogClick
    end
  end
  object PageSenhas: TPageControl
    Left = 7
    Top = 7
    Width = 342
    Height = 328
    ActivePage = PagUsr
    TabOrder = 0
    OnChange = PAGESENHASchange
    object PagUsr: TTabSheet
      Caption = '( &1 ) Usuários'
      object Label1: TLabel
        Left = 22
        Top = 270
        Width = 32
        Height = 13
        Caption = 'Master'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Image1: TImage
        Left = 3
        Top = 268
        Width = 17
        Height = 17
        AutoSize = True
        Picture.Data = {
          07544269746D617042010000424D420100000000000076000000280000001100
          0000110000000100040000000000CC0000000000000000000000100000000000
          0000000000000000800000800000008080008000000080008000808000008080
          8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFFF0000000FFF308FFFF803FFFF0000000FFF7307FF703
          7FFFF0000000FFF8083333808FFFF0000000FFFF0BB33BB0FFFFF0000000FFFF
          73BBBB37FFFFF0000000FFFF73BBBB37FFFFF0000000FFF73BBBBBB37FFFF000
          0000FF73BBBBBBBB37FFF0000000F03BBBBBBBBBB308F0000000F033330BB033
          3307F0000000FFFFFF0BB0FFFFFFF0000000FFFFFF7337FFFFFFF0000000FFFF
          FF8338FFFFFFF0000000FFFFFFF00FFFFFFFF0000000FFFFFFF77FFFFFFFF000
          0000FFFFFFFFFFFFFFFFF0000000}
        Transparent = True
      end
      object lbUsuarios: TListBox
        Left = 3
        Top = 4
        Width = 326
        Height = 262
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 18
        ParentFont = False
        Sorted = True
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnDblClick = lbUsuariosDblClick
        OnDrawItem = lbUsuariosDrawItem
      end
      object BtnIncluir_Usr: TBitBtn
        Left = 81
        Top = 272
        Width = 75
        Height = 25
        Hint = 'Incluir novo usuário'
        Caption = '&Incluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BTNINCLUIR_USRclick
        NumGlyphs = 2
      end
      object BtnEditar_Usr: TBitBtn
        Left = 168
        Top = 272
        Width = 75
        Height = 25
        Hint = 'Editar usuário'
        Caption = '&Editar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BTNEDITAR_USRclick
        NumGlyphs = 2
      end
      object BtnExcluir_Usr: TBitBtn
        Left = 255
        Top = 272
        Width = 75
        Height = 25
        Hint = 'Excluir usuário'
        Cancel = True
        Caption = 'E&xcluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BTNEXCLUIR_USRclick
        NumGlyphs = 2
      end
    end
    object PagGrupo: TTabSheet
      Caption = '( &2 ) Grupos'
      ImageIndex = 1
      object lbGrupos: TListBox
        Left = 3
        Top = 4
        Width = 326
        Height = 262
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 17
        ParentFont = False
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnDblClick = lbGruposDblClick
      end
      object BtnIncluir_Grp: TBitBtn
        Left = 81
        Top = 272
        Width = 75
        Height = 25
        Hint = 'Incluir novo grupo'
        Caption = '&Incluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BTNINCLUIR_GRPclick
        NumGlyphs = 2
      end
      object BtnEditar_Grp: TBitBtn
        Left = 168
        Top = 272
        Width = 75
        Height = 25
        Hint = 'Editar grupo'
        Caption = '&Editar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BTNEDITAR_GRPclick
        NumGlyphs = 2
      end
      object BtnExcluir_Grp: TBitBtn
        Left = 255
        Top = 272
        Width = 75
        Height = 25
        Hint = 'Excluir grupo'
        Cancel = True
        Caption = 'E&xcluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BTNEXCLUIR_GRPclick
        NumGlyphs = 2
      end
    end
  end
end
