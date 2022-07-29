unit PrintDiagrama;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PSJob, PJBitmap, PJControl, PSStatusBar, PSPreview, ExtCtrls, PSToolbar;

type
  TFormPrintDiagrama = class(TForm)
    PreviewToolbar: TPreviewToolbar;
    Preview: TPreview;
    PreviewStatusBar: TPreviewStatusBar;
    ControlPrintJob: TControlPrintJob;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrintDiagrama: TFormPrintDiagrama;

implementation

{$R *.DFM}

end.
