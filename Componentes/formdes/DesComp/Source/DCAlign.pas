(*  GREATIS FORM DESIGNER COMPONENT PRO  *)
(*  unit version 0.00.001                *)
(*  Copyright (C) 2003 Greatis Software  *)
(*  http://www.greatis.com/formdes.htm   *)
(*  b-team@greatis.com                   *)

unit DCAlign;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmAlign = class(TForm)
    rgrHorizontal: TRadioGroup;
    rgrVertical: TRadioGroup;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
