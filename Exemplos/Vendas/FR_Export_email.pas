unit FR_Export_email;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, FR_Class, inifiles, registry;

type
  TfrExport_email = class(TForm)
    ReqLB: TLabel;
    OkB: TButton;
    CancelB: TButton;
    PageControl1: TPageControl;
    ExportSheet: TTabSheet;
    MessageGroup: TGroupBox;
    AddressLB: TLabel;
    SubjectLB: TLabel;
    MessageLB: TLabel;
    MessageM: TMemo;
    AddressE: TComboBox;
    SubjectE: TComboBox;
    AccountSheet: TTabSheet;
    MailGroup: TGroupBox;
    FromNameLB: TLabel;
    FromAddrLB: TLabel;
    OrgLB: TLabel;
    SignatureLB: TLabel;
    FromNameE: TEdit;
    FromAddrE: TEdit;
    OrgE: TEdit;
    SignatureM: TMemo;
    SignBuildBtn: TButton;
    RememberCB: TCheckBox;
    AccountGroup: TGroupBox;
    HostLB: TLabel;
    PortLB: TLabel;
    LoginLB: TLabel;
    PasswordLB: TLabel;
    HostE: TEdit;
    PortE: TEdit;
    LoginE: TEdit;
    PasswordE: TEdit;
    procedure OkBClick(Sender: TObject);
    procedure SignBuildBtnClick(Sender: TObject);
    procedure PortEKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Report: TfrReport;
  end;

var
  frExport_email: TfrExport_email;

implementation

{$R *.DFM}

uses FR_SMTP, FR_Progress, ExportPack, fr_NetUtils, Publicas;

procedure TfrExport_email.OkBClick(Sender: TObject);
var
  i: Integer;
  FR_Mail: TFR_SMTPClient;
  ExportFr: TExportFr;
  fname: String;
  ini: TCustomIniFile;
  Section: String;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TLabel then
      (Components[i] as TLabel).Font.Style := [];
  if AddressE.Text = '' then
  begin
    ExportSheet.Show;
    AddressLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  if SubjectE.Text = '' then
  begin
    ExportSheet.Show;
    SubjectLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  if FromAddrE.Text = '' then
  begin
    AccountSheet.Show;
    FromAddrLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  if HostE.Text = '' then
  begin
    AccountSheet.Show;
    HostLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  if PortE.Text = '' then
  begin
    AccountSheet.Show;
    PortLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  ReqLB.Visible := ModalResult = mrNone;

  if ModalResult <> mrNone then
  begin
    ini := TRegistryIniFile.Create('\Software\'+Sistema.Titulo);
    try
      Section := 'email_export.Properties';
      if RememberCB.Checked then
      begin
        ini.WriteBool(Section, 'Remember', RememberCB.Checked);
        ini.WriteString(Section, 'FromName', FromNameE.Text);
        ini.WriteString(Section, 'FromAddress', FromAddrE.Text);
        ini.WriteString(Section, 'Organization', OrgE.Text);
        ini.WriteString(Section, 'Signature', SignatureM.Lines.Text);
        ini.WriteString(Section, 'SmtpHost', HostE.Text);
        ini.WriteString(Section, 'SmtpPort', PortE.Text);
        ini.WriteString(Section, 'Login', Base64Encode(LoginE.Text));
        ini.WriteString(Section, 'Password', Base64Encode(PasswordE.Text));
      end;
      ini.WriteString('email_export.RecentAddresses' , AddressE.Text, '');
      ini.WriteString('email_export.RecentSubjects' , SubjectE.Text, '');
    finally
      ini.Free;
    end;
    ExportFr := TExportFr.Create(Self);
    try
      ExportFr.Report := TfrReport(Report);
      ExportFr.ExportFR;
    finally
      fname := ExportFr.f_file;
      ExportFr.Free;
    end;
    if Trim(fname) <> '' then
    begin
      FR_Mail := TFR_SMTPClient.Create(nil);
      try
        FR_Mail.Host        := HostE.Text;
        FR_Mail.Port        := StrToIntDef(PortE.Text, 0);
        FR_Mail.User        := LoginE.Text;
        FR_Mail.Password    := PasswordE.Text;
        FR_Mail.MailFrom    := FromAddrE.Text;
        FR_Mail.MailTo      := AddressE.Text;
        FR_Mail.MailSubject := SubjectE.Text;
        FR_Mail.MailText    := MessageM.Lines.Text + ^M + SignatureM.Lines.Text;
        FR_Mail.MailFile    := fname;
        FR_Mail.AttachName  := '';
        FR_Mail.ShowProgress:= True;
        FR_Mail.LogFile     := Sistema.Pasta + 'email.log';
        FR_Mail.Open;
      finally
        if Trim(FR_Mail.Errors.Text) <> '' then
          MessageDlg(FR_Mail.Errors.Text, mtError, [mbOk], 0);
        FR_Mail.Free;
      end;
    end;
  end;
end;

procedure TfrExport_email.SignBuildBtnClick(Sender: TObject);
begin
  SignatureM.Clear;
  SignatureM.Lines.Add('');
  SignatureM.Lines.Add('--');
  SignatureM.Lines.Add('Atenciosamente' + ',');
  if Length(FromNameE.Text) > 0 then
    SignatureM.Lines.Add('  ' + FromNameE.Text);
  if Length(FromAddrE.Text) > 0 then
    SignatureM.Lines.Add('  e-mail: ' + FromAddrE.Text);
  if Length(OrgE.Text) > 0 then
    SignatureM.Lines.Add('  ' + OrgE.Text);
end;

procedure TfrExport_email.PortEKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9':;
    #8:;
  else
    key := #0;
  end;
end;

procedure TfrExport_email.FormShow(Sender: TObject);
var
  ini: TCustomIniFile;
  Section: String;
begin
  PageControl1.ActivePageIndex := 0;
  ini := TRegistryIniFile.Create('\Software\'+Sistema.Titulo);
  try
    Section := 'email_export.Properties';
    if ini.SectionExists(Section) then
    begin
      RememberCB.Checked    := ini.ReadBool(Section, 'Remember', False);
      FromNameE.Text        := ini.ReadString(Section, 'FromName', '');
      FromAddrE.Text        := ini.ReadString(Section, 'FromAddress', '');
      OrgE.Text             := ini.ReadString(Section, 'Organization', '');
      SignatureM.Lines.Text := ini.ReadString(Section, 'Signature', '');
      HostE.Text            := ini.ReadString(Section, 'SmtpHost', '');
      PortE.Text            := ini.ReadString(Section, 'SmtpPort', '25');
      LoginE.Text           := Base64Decode(ini.ReadString(Section, 'Login', ''));
      PasswordE.Text        := Base64Decode(ini.ReadString(Section, 'Password', ''));
    end
    else
      RememberCB.Enabled := True;
    ini.ReadSection('email_export.RecentAddresses' , AddressE.Items);
    ini.ReadSection('email_export.RecentSubjects' , SubjectE.Items);
  finally
    ini.Free;
  end;
end;

end.
