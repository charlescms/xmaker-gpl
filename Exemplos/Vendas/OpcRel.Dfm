object FormOpcRel: TFormOpcRel
  Left = 239
  Top = 177
  Width = 391
  Height = 262
  BorderStyle = bsSizeToolWin
  Caption = 'Configuração'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 383
    Height = 173
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Página'
      object Label9: TLabel
        Left = 7
        Top = 126
        Width = 28
        Height = 13
        Caption = 'Título'
      end
      object GroupBox2: TGroupBox
        Left = 198
        Top = 8
        Width = 163
        Height = 69
        Caption = ' Orientação '
        TabOrder = 0
        object imgLandScape: TImage
          Left = 121
          Top = 25
          Width = 32
          Height = 26
          AutoSize = True
          Picture.Data = {
            07544269746D617016020000424D160200000000000076000000280000002000
            00001A0000000100040000000000A0010000CE0E0000C40E0000100000000000
            000000000000000080000080000000808000800000008000800080800000C0C0
            C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00000000000000000000000000000000008FFFF77777777777777777777777
            77708FFFFFFFFFFFFFFFFFFFFFFFFFFFFF708FFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF708FFFFFFFFFFFFFFFFFFFFFFFFFFFFF708FFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF708FFFFFFFFFFFFFFFFFFFFFFFFFFFFF708FFFFFFFF8888FFFF888888FFFFF
            FF708FFFFFFFFF78FFFFFF7887FFFFFFFF708FFFFFFFFFF87FFFFF888FFFFFFF
            FF708FFFFFFFFFF787FFF7887FFFFFFFFF708FFFFFFFFFFF88888888FFFFFFFF
            FF708FFFFFFFFFFF87FF7887FFFFFFFFFF708FFFFFFFFFFF78FF888FFFFFFFFF
            FF708FFFFFFFFFFFF87F887FFFFFFFFFFF708FFFFFFFFFFFF78888FFFFFFFFFF
            FF708FFFFFFFFFFFFF8887FFFFFFFFFFFF708FFFFFFFFFFFFF788FFFFFFFFFFF
            FF708FFFFFFFFFFFFFF87FFFFFFFFFFFFF708FFFFFFFFFFFFFFFFFFFFFFFF000
            00088FFFFFFFFFFFFFFFFFFFFFFFF07FFF878FFFFFFFFFFFFFFFFFFFFFFFF07F
            F8778FFFFFFFFFFFFFFFFFFFFFFFF07F87778FFFFFFFFFFFFFFFFFFFFFFFF0F8
            77778FFFFFFFFFFFFFFFFFFFFFFFF08777778888888888888888888888888077
            7777}
        end
        object imgPortrait: TImage
          Left = 124
          Top = 21
          Width = 26
          Height = 32
          AutoSize = True
          Picture.Data = {
            07544269746D617076020000424D760200000000000076000000280000001A00
            000020000000010004000000000000020000CE0E0000C40E0000100000000000
            000000000000000080000080000000808000800000008000800080800000C0C0
            C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00000000000000000000000000000000008777777777777777777777777000
            00008FFFFFFFFFFFFFFFFFFFFFFF700000008FFFFFFFFFFFFFFFFFFFFFFF7000
            00008FFFFFFFFFFFFFFFFFFFFFFF700000008FFFFFFFFFFFFFFFFFFFFFFF7000
            00008FFFFFFFFFFFFFFFFFFFFFFF700000008FFFFFFFFFFFFFFFFFFFFFFF7000
            00008FFFFFFFFFFFFFFFFFFFFFFF700000008FFFFFFFFFFFFFFFFFFFFFFF7000
            00008FFFFF8888FFFF888888FFFF700000008FFFFFF78FFFFFF7887FFFFF7000
            00008FFFFFFF87FFFFF888FFFFFF700000008FFFFFFF787FFF7887FFFFFF7000
            00008FFFFFFFF88888888FFFFFFF700000008FFFFFFFF87FF7887FFFFFFF7000
            00008FFFFFFFF78FF888FFFFFFFF700000008FFFFFFFFF87F887FFFFFFFF7000
            00008FFFFFFFFF78888FFFFFFFFF700000008FFFFFFFFFF8887FFFFFFFFF7000
            00008FFFFFFFFFF788FFFFFFFFFF700000008FFFFFFFFFFF87FFFFFFFFFF7000
            00008FFFFFFFFFFFFFFFFFFFFFFF700000008FFFFFFFFFFFFFFFFFFFFFFF7000
            00008FFFFFFFFFFFFFFFFFFFFFFF700000008FFFFFFFFFFFFFFFFFF800000000
            00008FFFFFFFFFFFFFFFFFF8FF78070000008FFFFFFFFFFFFFFFFFF8F7807700
            00008FFFFFFFFFFFFFFFFFF87807770000008FFFFFFFFFFFFFFFFFF880777700
            00008FFFFFFFFFFFFFFFFFF80777770000008888888888888888888877777700
            0000}
        end
        object RB1: TRadioButton
          Left = 8
          Top = 20
          Width = 85
          Height = 17
          HelpContext = 111
          Caption = 'Retrato'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = RB1Click
        end
        object RB2: TRadioButton
          Left = 8
          Top = 40
          Width = 85
          Height = 17
          HelpContext = 120
          Caption = 'Paisagem'
          TabOrder = 1
          OnClick = RB2Click
        end
      end
      object GroupBox3: TGroupBox
        Left = 4
        Top = 8
        Width = 185
        Height = 109
        Caption = ' Tamanho '
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 56
          Width = 58
          Height = 13
          Caption = 'Largura, mm'
          FocusControl = E1
        end
        object Label2: TLabel
          Left = 8
          Top = 80
          Width = 49
          Height = 13
          Caption = 'Altura, mm'
          FocusControl = E2
        end
        object ComB1: TComboBox
          Left = 8
          Top = 20
          Width = 169
          Height = 21
          HelpContext = 130
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnClick = ComB1Click
        end
        object E1: TEdit
          Left = 80
          Top = 52
          Width = 40
          Height = 21
          HelpContext = 140
          TabOrder = 1
        end
        object E2: TEdit
          Left = 80
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 150
          TabOrder = 2
        end
      end
      object EdTitulo: TEdit
        Left = 39
        Top = 122
        Width = 323
        Height = 21
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Margens'
      object GroupBox4: TGroupBox
        Left = 4
        Top = 8
        Width = 253
        Height = 109
        Caption = ' Margens da Página '
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 56
          Width = 67
          Height = 13
          Caption = 'Esquerdo, mm'
          FocusControl = E3
        end
        object Label4: TLabel
          Left = 8
          Top = 80
          Width = 64
          Height = 13
          Caption = 'Superior,  mm'
          FocusControl = E4
        end
        object Label5: TLabel
          Left = 132
          Top = 56
          Width = 52
          Height = 13
          Caption = 'Direito, mm'
          FocusControl = E5
        end
        object Label6: TLabel
          Left = 132
          Top = 80
          Width = 54
          Height = 13
          Caption = 'Inferior, mm'
          FocusControl = E6
        end
        object CB5: TCheckBox
          Left = 8
          Top = 20
          Width = 117
          Height = 17
          HelpContext = 62
          Caption = 'Não usar'
          TabOrder = 0
          OnClick = CB5Click
        end
        object E3: TEdit
          Left = 80
          Top = 52
          Width = 40
          Height = 21
          HelpContext = 72
          TabOrder = 1
        end
        object E4: TEdit
          Left = 80
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 81
          TabOrder = 2
        end
        object E5: TEdit
          Left = 204
          Top = 52
          Width = 40
          Height = 21
          HelpContext = 91
          TabOrder = 3
        end
        object E6: TEdit
          Left = 204
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 101
          TabOrder = 4
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Colunas'
      object GroupBox5: TGroupBox
        Left = 4
        Top = 8
        Width = 253
        Height = 109
        Caption = ' Colunas '
        TabOrder = 0
        object Label7: TLabel
          Left = 8
          Top = 24
          Width = 37
          Height = 13
          Caption = 'Número'
        end
        object Label8: TLabel
          Left = 8
          Top = 52
          Width = 125
          Height = 13
          Caption = 'Espaço entre colunas, mm'
          FocusControl = E7
        end
        object E7: TEdit
          Left = 8
          Top = 68
          Width = 53
          Height = 21
          HelpContext = 180
          TabOrder = 0
        end
        object Edit1: TEdit
          Tag = 6
          Left = 84
          Top = 21
          Width = 43
          Height = 21
          HelpContext = 170
          TabOrder = 1
          Text = '1'
        end
        object Panel8: TPanel
          Left = 108
          Top = 23
          Width = 17
          Height = 17
          BevelOuter = bvNone
          TabOrder = 2
          object SB1: TSpeedButton
            Left = 0
            Top = 1
            Width = 17
            Height = 8
            Glyph.Data = {
              86000000424D8600000000000000760000002800000007000000040000000100
              0400000000001000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFF0F000
              00F0FF000FF0FFF0FFF0}
            OnClick = SB1Click
          end
          object SB2: TSpeedButton
            Left = 0
            Top = 9
            Width = 17
            Height = 8
            Glyph.Data = {
              86000000424D8600000000000000760000002800000007000000040000000100
              0400000000001000000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFF0FFF0FF00
              0FF0F00000F0FFFFFFF0}
            OnClick = SB2Click
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Extras'
      ImageIndex = 3
      object GrupoTotalizacao: TGroupBox
        Left = 0
        Top = 0
        Width = 361
        Height = 68
        Caption = ' Totalizações '
        TabOrder = 0
        object CTotalizar: TCheckBox
          Left = 4
          Top = 16
          Width = 159
          Height = 17
          Caption = 'Totalizar colunas númericas'
          TabOrder = 0
        end
        object CQuantificar: TCheckBox
          Left = 4
          Top = 32
          Width = 159
          Height = 17
          Caption = 'Quantificar registros'
          TabOrder = 1
        end
        object CSintetizar: TCheckBox
          Left = 4
          Top = 48
          Width = 69
          Height = 17
          Caption = 'Sintetizar'
          TabOrder = 2
        end
      end
      object GrupoQuebra: TGroupBox
        Left = 0
        Top = 68
        Width = 361
        Height = 55
        Caption = ' Quebra '
        TabOrder = 1
        object CQuebra: TCheckBox
          Left = 4
          Top = 17
          Width = 353
          Height = 17
          Caption = 'Quebra por :'
          TabOrder = 0
        end
        object CSubtotalizar: TCheckBox
          Left = 4
          Top = 33
          Width = 181
          Height = 17
          Caption = 'SubTotalizar colunas númericas'
          TabOrder = 1
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 194
    Width = 383
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 220
      Top = 8
      Width = 75
      Height = 25
      HelpContext = 40
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 302
      Top = 8
      Width = 75
      Height = 25
      HelpContext = 50
      Cancel = True
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object CDesigner: TCheckBox
    Left = 4
    Top = 174
    Width = 181
    Height = 17
    Caption = 'Abrir editor de relatórios ( Expert )'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
