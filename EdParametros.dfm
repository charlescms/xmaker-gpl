object FormParametros: TFormParametros
  Left = 232
  Top = 255
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Parâmetros'
  ClientHeight = 248
  ClientWidth = 448
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
    Left = 288
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
    Left = 368
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
    Width = 439
    Height = 209
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parâmetros'
      object Bevel1: TBevel
        Left = 1
        Top = 2
        Width = 428
        Height = 177
      end
      object StringGrid: TStringGrid
        Left = 9
        Top = 14
        Width = 411
        Height = 129
        ColCount = 6
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnDrawCell = StringGridDrawCell
        OnSelectCell = StringGridSelectCell
        OnSetEditText = StringGridSetEditText
        ColWidths = (
          135
          50
          47
          69
          51
          49)
      end
      object BtnIncluir: TBitBtn
        Left = 264
        Top = 149
        Width = 75
        Height = 25
        Caption = 'Incluir'
        TabOrder = 1
        OnClick = BtnIncluirClick
      end
      object BtnExcluir: TBitBtn
        Left = 346
        Top = 149
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 2
        OnClick = BtnExcluirClick
      end
      object ComboBox: TComboBox
        Left = 16
        Top = 152
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Visible = False
        OnChange = ComboBoxChange
      end
      object CheckBox: TCheckBox
        Left = 168
        Top = 156
        Width = 49
        Height = 17
        Caption = 'Sim'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 4
        Visible = False
        OnClick = CheckBoxClick
      end
    end
  end
end
