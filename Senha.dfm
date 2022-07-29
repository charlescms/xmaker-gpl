object Acesso: TAcesso
  Left = 236
  Top = 210
  BorderStyle = bsDialog
  Caption = 'Acesso'
  ClientHeight = 127
  ClientWidth = 233
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 57
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 36
    Height = 13
    Caption = 'Usuário'
  end
  object EdSenha: TEdit
    Left = 8
    Top = 72
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object OKBtn: TButton
    Left = 70
    Top = 99
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 150
    Top = 99
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object EdUsuario: TEdit
    Left = 8
    Top = 24
    Width = 217
    Height = 21
    TabOrder = 0
  end
end
