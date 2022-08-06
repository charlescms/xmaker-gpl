object frExport_email: TfrExport_email
  Left = 286
  Top = 168
  BorderStyle = bsDialog
  Caption = 'Exportar para e-mail'
  ClientHeight = 383
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ReqLB: TLabel
    Left = 8
    Top = 356
    Width = 225
    Height = 13
    AutoSize = False
    Caption = 'Campos requeridos não estão preenchidos!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object OkB: TButton
    Left = 238
    Top = 352
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OkBClick
  end
  object CancelB: TButton
    Left = 318
    Top = 352
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 389
    Height = 341
    ActivePage = ExportSheet
    TabOrder = 2
    object ExportSheet: TTabSheet
      Caption = 'E-mail detalhe'
      object MessageGroup: TGroupBox
        Left = 4
        Top = 4
        Width = 373
        Height = 300
        Caption = ' Mensagem '
        TabOrder = 0
        object AddressLB: TLabel
          Left = 8
          Top = 20
          Width = 56
          Height = 13
          Caption = 'Destinatário'
        end
        object SubjectLB: TLabel
          Left = 8
          Top = 44
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'Assunto'
        end
        object MessageLB: TLabel
          Left = 8
          Top = 68
          Width = 65
          Height = 13
          AutoSize = False
          Caption = 'Texto'
        end
        object MessageM: TMemo
          Left = 80
          Top = 64
          Width = 281
          Height = 227
          TabOrder = 2
        end
        object AddressE: TComboBox
          Left = 80
          Top = 16
          Width = 281
          Height = 21
          ItemHeight = 13
          TabOrder = 0
        end
        object SubjectE: TComboBox
          Left = 80
          Top = 40
          Width = 281
          Height = 21
          ItemHeight = 13
          TabOrder = 1
        end
      end
    end
    object AccountSheet: TTabSheet
      Caption = 'Conta'
      ImageIndex = 1
      object MailGroup: TGroupBox
        Left = 4
        Top = 4
        Width = 373
        Height = 197
        Caption = ' Emitente '
        TabOrder = 0
        object FromNameLB: TLabel
          Left = 8
          Top = 20
          Width = 101
          Height = 13
          AutoSize = False
          Caption = 'Nome'
        end
        object FromAddrLB: TLabel
          Left = 8
          Top = 44
          Width = 101
          Height = 13
          AutoSize = False
          Caption = 'E-mail'
        end
        object OrgLB: TLabel
          Left = 8
          Top = 68
          Width = 101
          Height = 13
          AutoSize = False
          Caption = 'Organização'
        end
        object SignatureLB: TLabel
          Left = 8
          Top = 92
          Width = 101
          Height = 13
          AutoSize = False
          Caption = 'Assinatura'
        end
        object FromNameE: TEdit
          Left = 112
          Top = 16
          Width = 249
          Height = 21
          TabOrder = 0
        end
        object FromAddrE: TEdit
          Left = 112
          Top = 40
          Width = 249
          Height = 21
          TabOrder = 1
        end
        object OrgE: TEdit
          Left = 112
          Top = 64
          Width = 249
          Height = 21
          TabOrder = 2
        end
        object SignatureM: TMemo
          Left = 112
          Top = 88
          Width = 249
          Height = 97
          ScrollBars = ssVertical
          TabOrder = 3
        end
        object SignBuildBtn: TButton
          Left = 8
          Top = 108
          Width = 67
          Height = 21
          Caption = 'Criar'
          TabOrder = 4
          OnClick = SignBuildBtnClick
        end
      end
      object RememberCB: TCheckBox
        Left = 4
        Top = 288
        Width = 133
        Height = 17
        Caption = 'Salvar Propriedades'
        TabOrder = 2
      end
      object AccountGroup: TGroupBox
        Left = 4
        Top = 204
        Width = 373
        Height = 77
        Caption = ' Conexão '
        TabOrder = 1
        object HostLB: TLabel
          Left = 8
          Top = 20
          Width = 53
          Height = 13
          AutoSize = False
          Caption = 'Servidor'
        end
        object PortLB: TLabel
          Left = 272
          Top = 20
          Width = 53
          Height = 13
          AutoSize = False
          Caption = 'Porta'
        end
        object LoginLB: TLabel
          Left = 8
          Top = 48
          Width = 53
          Height = 13
          AutoSize = False
          Caption = 'Usuário'
        end
        object PasswordLB: TLabel
          Left = 216
          Top = 48
          Width = 61
          Height = 13
          AutoSize = False
          Caption = 'Senha'
        end
        object HostE: TEdit
          Left = 64
          Top = 16
          Width = 197
          Height = 21
          TabOrder = 0
        end
        object PortE: TEdit
          Left = 328
          Top = 16
          Width = 33
          Height = 21
          TabOrder = 1
          Text = '25'
          OnKeyPress = PortEKeyPress
        end
        object LoginE: TEdit
          Left = 64
          Top = 44
          Width = 141
          Height = 21
          TabOrder = 2
        end
        object PasswordE: TEdit
          Left = 280
          Top = 44
          Width = 81
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
      end
    end
  end
end
