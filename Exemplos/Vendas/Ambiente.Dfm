object FormAmbiente: TFormAmbiente
  Left = 216
  Top = 163
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ambiente de Trabalho'
  ClientHeight = 263
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelInf: TPanel
    Left = 0
    Top = 228
    Width = 375
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BtnCancelar: TBitBtn
      Left = 297
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
      Left = 210
      Top = 6
      Width = 75
      Height = 25
      Hint = 'Gravar e finalizar'
      Cancel = True
      Caption = '&Gravar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtnGravarClick
      NumGlyphs = 2
    end
  end
  object PageAmbiente: TPageControl
    Left = 0
    Top = 0
    Width = 375
    Height = 228
    ActivePage = PagProp
    Align = alClient
    TabOrder = 0
    object PagProp: TTabSheet
      Caption = 'Propriedades'
      object Label1: TLabel
        Left = 3
        Top = 6
        Width = 84
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Pasta Básica'
      end
      object Label9: TLabel
        Left = 4
        Top = 138
        Width = 174
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Imagem'
      end
      object Bevel1: TBevel
        Left = 214
        Top = 86
        Width = 124
        Height = 102
      end
      object ImagemFundo: TImage
        Left = 217
        Top = 89
        Width = 118
        Height = 96
        Center = True
        Stretch = True
        Transparent = True
      end
      object EdSaida: TCheckBox
        Left = 28
        Top = 59
        Width = 97
        Height = 17
        Hint = 
          'Informe se na finalização do sistema será'#13#10'exibida uma caixa de ' +
          'confirmação'
        Caption = 'Confirma Saída'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object EdBalao: TCheckBox
        Left = 28
        Top = 75
        Width = 149
        Height = 17
        Hint = 
          'Informe se as mensagens apresentadas em botões,'#13#10'caixa de entrad' +
          'as, etc. serão no estilo de balão.'
        Caption = 'Mensagens Estilo de Balão'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object EdPastaBasica: TEdit
        Left = 89
        Top = 3
        Width = 249
        Height = 21
        Hint = 
          'Pasta de localização dos arquivos de'#13#10'configuração do sistema ( ' +
          'Senhas, Agenda, ... )'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object EdPapelParede: TCheckBox
        Left = 28
        Top = 123
        Width = 161
        Height = 17
        Hint = 'Habilita imagem de fundo do sistema'
        Caption = 'Apresentar Imagem de Fundo'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object EdImagem: TEdit
        Left = 2
        Top = 153
        Width = 177
        Height = 21
        Hint = 'Localização do arquivo de imagem'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnExit = EdImagemExit
      end
      object BtnImagem: TBitBtn
        Left = 182
        Top = 151
        Width = 25
        Height = 25
        Hint = 'Localizar imagem'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = BtnImagemClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333300
          3333333333333333FF333333333330EC033333333333333FE7F3330000000ECC
          00333333FFFFFFFE77FF33033330ECC330333333F8888FE7788F330FFF0ECC3F
          30333333F333FE77838F3300003CC3FF30333333FFFF8778338F303E30003FFF
          3033333F8E8FFF83338F0FE3E303FFFF303333F3E8E8F833338F0EFE3E03FFFF
          303333FE3E8EF833338F0FEFE303FFFF303333F3E3E8F833338F30FEF03FFFFF
          3033333F3E3F8333338F330003FFFFFF30333333FFF83333338F330FFFFFFF00
          00333333F3333333FFFF330FFFFFFF3F03333333F333333383F3330FFFFFFF30
          33333333F33333338F3333000000000333333333FFFFFFFFF333}
        NumGlyphs = 2
      end
      object BtnPastaBasica: TBitBtn
        Left = 341
        Top = 1
        Width = 25
        Height = 25
        Hint = 'Lista de Diretórios'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnPastaBasicaClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00303333333333
          333337F3333333333333303333333333333337F33FFFFF3FF3FF303300000300
          300337FF77777F77377330000BBB0333333337777F337F33333330330BB00333
          333337F373F773333333303330033333333337F3377333333333303333333333
          333337F33FFFFF3FF3FF303300000300300337FF77777F77377330000BBB0333
          333337777F337F33333330330BB00333333337F373F773333333303330033333
          333337F3377333333333303333333333333337FFFF3FF3FFF333000003003000
          333377777F77377733330BBB0333333333337F337F33333333330BB003333333
          333373F773333333333330033333333333333773333333333333}
        NumGlyphs = 2
      end
      object EdAjustada: TCheckBox
        Left = 28
        Top = 180
        Width = 161
        Height = 17
        Hint = 'Exibir imagem ajustada'
        Caption = 'Exibir Imagem Ajustada'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
      end
      object EdRede: TCheckBox
        Left = 28
        Top = 27
        Width = 97
        Height = 17
        Hint = 
          'Informe se o sistema será usado em rede'#13#10'Para uso monousuário de' +
          'smarque esta opção'
        Caption = 'Uso em Rede'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object EdIntegridade: TCheckBox
        Left = 28
        Top = 43
        Width = 173
        Height = 17
        Hint = 
          'Informe se integridade referencial das tabelas está ativa,'#13#10'esta' +
          'ndo ativa o sistema irá verificar a cada exclusão se o'#13#10'registro' +
          ' não está vinculado em outra tabela.'#13#10'Exemplo: O registro de um ' +
          'cliente pode estar sendo usado'#13#10'em vendas, contas, compras e etc' +
          '.'
        Caption = 'Integridade Referencial'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object EdMenuXP: TCheckBox
        Left = 28
        Top = 91
        Width = 149
        Height = 17
        Hint = 'Informe se o menu será apresentado no estilo do Windows XP.'
        Caption = 'Menu Estilo Windows XP'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object EdSelecionar: TCheckBox
        Left = 28
        Top = 107
        Width = 149
        Height = 17
        Hint = 
          'Informe se a Empresa Usuária poderá se selecionada na abertura'#13#10 +
          'do sistema.'
        Caption = 'Selecionar Empresa'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
    end
  end
  object OpenPictureImagem: TOpenPictureDialog
    Filter = 'Imagens (*.bmp; *.jpg; *.ico)|*.bmp;*.jpg;*.ico'
    Left = 260
    Top = 120
  end
end
