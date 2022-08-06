unit Product;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TFormProduct = class(TForm)
    Panel: TPanel;
    LabelVersion: TLabel;
    Image: TImage;
  private
  public
  end;

var
  FormProduct: TFormProduct;

implementation

{$R *.DFM}

end.
