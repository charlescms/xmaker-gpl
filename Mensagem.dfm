object FormMensagem: TFormMensagem
  Left = 200
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Mensagem'
  ClientHeight = 158
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Fundo: TPanel
    Left = 0
    Top = 0
    Width = 367
    Height = 158
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Divisao: TBevel
      Left = 59
      Top = 1
      Width = 2
      Height = 156
      Shape = bsLeftLine
    end
    object Image: TImage
      Left = 2
      Top = 4
      Width = 55
      Height = 57
      Center = True
    end
    object BtnOk: TBitBtn
      Left = 6
      Top = 130
      Width = 75
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object BtnSim: TBitBtn
      Left = 84
      Top = 130
      Width = 75
      Height = 25
      Caption = '&Sim'
      ModalResult = 6
      TabOrder = 1
    end
    object BtnNao: TBitBtn
      Left = 162
      Top = 130
      Width = 75
      Height = 25
      Caption = '&Não'
      ModalResult = 7
      TabOrder = 2
    end
    object BtnCancela: TBitBtn
      Left = 240
      Top = 130
      Width = 75
      Height = 25
      Caption = '&Cancela'
      ModalResult = 2
      TabOrder = 3
    end
    object BtnTodos: TBitBtn
      Left = 318
      Top = 130
      Width = 75
      Height = 25
      Caption = 'Sim p/&Todos'
      ModalResult = 8
      TabOrder = 4
    end
    object LbMensagem: TMemo
      Left = 63
      Top = 9
      Width = 302
      Height = 114
      TabStop = False
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
  end
end
