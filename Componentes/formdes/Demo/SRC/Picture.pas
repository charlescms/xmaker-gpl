unit Picture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExpertWindow, FormCont, ExtCtrls, StdCtrls, Buttons, ExtDlgs;

type
  TFormPicture = class(TFormExpertWindow)
    OpenPictureDialog: TOpenPictureDialog;
    FormContainerPicture: TFormContainer;
    BitBtnLoad: TBitBtn;
    BitBtnClear: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    CheckBoxPictureVisible: TCheckBox;
    GroupBoxMode: TGroupBox;
    RadioButtonfcpmCenter: TRadioButton;
    RadioButtonfcpmCenterStretch: TRadioButton;
    RadioButtonfcpmStretch: TRadioButton;
    RadioButtonfcpmTile: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnLoadClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButtonfcpmCenterClick(Sender: TObject);
  private
    Backgr: TFCBackgroundOptions;

    procedure UpdateBackGr;
  protected
    procedure Apply; override;
    procedure GoToNext; override;
  public
  end;

var
  FormPicture: TFormPicture;

implementation

uses TransExpert;

{$R *.DFM}

procedure TFormPicture.FormCreate(Sender: TObject);
begin
  inherited;

  Backgr := TFCBackgroundOptions.Create;
  Backgr.Assign(FormTransitionsExpert.FormContainerExpert.BackgroundOptions);
  FormContainerPicture.Picture.Assign(Backgr.Picture);
end;

procedure TFormPicture.Apply;
begin
  UpdateBackGr;
end;

procedure TFormPicture.GoToNext;
begin
  FormTransitionsExpert.GoToEnd(Backgr);
end;

procedure TFormPicture.BitBtnLoadClick(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
    FormContainerPicture.Picture.LoadFromFile(OpenPictureDialog.FileName);
end;

procedure TFormPicture.BitBtnClearClick(Sender: TObject);
begin
  if FormContainerPicture.Picture <> nil then
    FormContainerPicture.Picture.Assign(nil);
end;

procedure TFormPicture.FormDestroy(Sender: TObject);
begin
  Backgr.Free;

  inherited;
end;

procedure TFormPicture.FormShow(Sender: TObject);
begin
  inherited;

  case FormTransitionsExpert.FormContainerExpert.BackgroundOptions.PictureMode of
    fcpmCenter       : RadioButtonfcpmCenter       .Checked := True;
    fcpmCenterStretch: RadioButtonfcpmCenterStretch.Checked := True;
    fcpmStretch      : RadioButtonfcpmStretch      .Checked := True;
    fcpmTile         : RadioButtonfcpmTile         .Checked := True;
  end;
  CheckBoxPictureVisible.Checked :=
    FormTransitionsExpert.FormContainerExpert.BackgroundOptions.PictureVisible;
end;

procedure TFormPicture.RadioButtonfcpmCenterClick(Sender: TObject);
begin
  UpdateBackGr;
end;

procedure TFormPicture.UpdateBackGr;
begin
  Backgr.PictureVisible := CheckBoxPictureVisible.Checked;
  if RadioButtonfcpmCenter.Checked
  then Backgr.PictureMode := fcpmCenter
  else if RadioButtonfcpmCenterStretch.Checked
  then Backgr.PictureMode := fcpmCenterStretch
  else if RadioButtonfcpmStretch.Checked
  then Backgr.PictureMode := fcpmStretch
  else if RadioButtonfcpmTile.Checked
  then Backgr.PictureMode := fcpmTile;
  Backgr.Picture.Assign(FormContainerPicture.Picture);

  FormContainerPicture.BackgroundOptions.Assign(Backgr);
end;

end.
