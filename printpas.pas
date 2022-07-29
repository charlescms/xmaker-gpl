unit PrintPas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFrmPrintPas = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    GroupBox2: TGroupBox;
    lbFileName: TLabel;
    cbSelectedText: TCheckBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    cbHeader: TCheckBox;
    cbLineNumbers: TCheckBox;
    cbSyntaxPrint: TCheckBox;
    cbColor: TCheckBox;
    cbWrapLines: TCheckBox;
    ebMargin: TEdit;
    BtnSetup: TButton;
    BtnOk: TButton;
    BtnCancelar: TButton;
    BtnAjuda: TButton;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSetupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrintPas: TFrmPrintPas;

implementation

uses SynEditPrint, Princ;

{$R *.DFM}

procedure TFrmPrintPas.BtnOkClick(Sender: TObject);
var
  Options: TSynEditPrint;
begin
   {Screen.Cursor:= crHourGlass;
   Options.SelectedOnly:= cbSelectedText.Checked;
   Options.Highlight:= cbSyntaxPrint.Checked;
   Options.PrintRange(0,0);// := Rect(0,0,0,0); // Not using it here.
   //Options.Margins.UnitSystem := muThousandthsOfInches;
   Options.Margins := Rect(500, 500, 500, 500); // 1/2 inch margins
   Options.WrapLongLines:= cbWrapLines.Checked;
   Options.Copies := 1;
   Options.Header := TStringList.Create;
   Options.Footer := TStringList.Create;
   if FormEditor <> nil then
     Options.Title:= FormEditor.CurrentEdit.Filename
   else
     Options.Title:= FormPaleta2.CurrentEdit.Filename;
  try
    Options.Header.AddObject('Título: $title$', TObject(hfaCenter));
    Options.Header.AddObject('Imprimindo Data/Hora: $date$ $time$',TObject(hfaLeft));
    Options.Header.Add('');

    Options.Footer.Add('');
    Options.Footer.AddObject('Número Página: $pagenum$ Imprimindo Data/Hora: $datetime$', TObject(hfaRight));
    if FormEditor <> nil then
      FormEditor.CurrentEdit.Print(nil, Options)
    else
      FormPaleta2.CurrentEdit.Print(nil, Options);
  finally
    Options.Header.Free;
    Options.Footer.Free;
  end;
  Screen.Cursor:= crDefault;}
  Close;
end;

procedure TFrmPrintPas.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrintPas.BtnSetupClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TFrmPrintPas.FormShow(Sender: TObject);
begin
  //if FormEditor <> nil then
  //  lbFileName.Caption := FormEditor.CurrentEdit.Filename;
end;

end.
