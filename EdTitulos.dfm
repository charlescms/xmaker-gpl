object FormTitulos: TFormTitulos
  Left = 199
  Top = 168
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Títulos'
  ClientHeight = 248
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnOk: TButton
    Left = 423
    Top = 218
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
    Left = 503
    Top = 218
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
    Left = 4
    Top = 4
    Width = 574
    Height = 209
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Títulos'
      object Bevel1: TBevel
        Left = 1
        Top = 2
        Width = 563
        Height = 177
        Anchors = [akLeft, akTop, akRight]
      end
      object StringGrid: TStringGrid
        Left = 9
        Top = 14
        Width = 546
        Height = 129
        Anchors = [akLeft, akTop, akRight]
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnSelectCell = StringGridSelectCell
        OnSetEditText = StringGridSetEditText
        ColWidths = (
          156
          192
          52
          121)
      end
      object BtnIncluir: TBitBtn
        Left = 399
        Top = 149
        Width = 75
        Height = 25
        Caption = 'Incluir'
        TabOrder = 1
        OnClick = BtnIncluirClick
      end
      object BtnExcluir: TBitBtn
        Left = 481
        Top = 149
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 2
        OnClick = BtnExcluirClick
      end
      object ComboBox: TComboBox
        Left = 16
        Top = 8
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        Visible = False
        OnChange = ComboBoxChange
        Items.Strings = (
          'X*'
          'x*'
          'A*'
          'a*'
          '9*'
          '99:99:99'
          '99999-999'
          '999.999.999-99'
          '99.999.999/9999-99'
          'AAA-9999'
          '(Z999)Z999-9999'
          '99/99/99'
          '99/99/9999'
          '9999'
          'ZZZ9'
          'Z.ZZZ.ZZ9,99'
          'Z.ZZZ.ZZ9,999'
          'Z.ZZZ.ZZ9,9999'
          '-Z.ZZZ.ZZ9,99'
          '-Z.ZZZ.ZZ9,999'
          '-Z.ZZZ.ZZ9,9999')
      end
      object BtnAbaixo: TBitBtn
        Left = 235
        Top = 149
        Width = 75
        Height = 25
        Hint = 'Mover para baixo'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = BtnAbaixoClick
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
      end
      object BtnAcima: TBitBtn
        Left = 153
        Top = 149
        Width = 75
        Height = 25
        Hint = 'Mover para cima'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BtnAcimaClick
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
      end
      object BtnAuto: TBitBtn
        Left = 317
        Top = 149
        Width = 75
        Height = 25
        Hint = 'Identificar Colunas na Consulta'
        Caption = 'Identificar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = BtnAutoClick
      end
    end
  end
  object SDDatabase: TSDDatabase
    DatabaseName = 'Base_Tmp'
    IdleTimeOut = 0
    SessionName = 'Default'
    Left = 16
    Top = 77
  end
  object SDQuery: TSDQuery
    DatabaseName = 'base_tmp'
    Left = 56
    Top = 77
  end
end
