(*  GREATIS OBJECT INSPECTOR EXAMPLES             *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit Image;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls;

type

  TImageForm = class(TForm)
    TopPanel: TPanel;
    BottomPanel: TPanel;
    CloseButton: TButton;
    DBImage: TDBImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImageForm: TImageForm;

implementation

{$R *.DFM}

end.
