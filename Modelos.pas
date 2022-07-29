unit Modelos;

interface

uses Windows, ImgList, Controls, StdCtrls, ComCtrls, Classes, ExtCtrls, Forms, Sysutils;

type
  TFormModelos = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl: TPageControl;
    PgNovo: TTabSheet;
    OKBtn: TButton;
    CancelBtn: TButton;
    Lista_1: TListView;
    ListaImagens: TImageList;
    LModelos: TListBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormModelos: TFormModelos;

implementation

{$R *.dfm}

uses Princ, Rotinas;

procedure TFormModelos.FormShow(Sender: TObject);
var
  I: Integer;
begin
  LModelos.Clear;
  if FileExists(Projeto.PastaGerador + 'Modelos.def') then
    LModelos.Items.LoadFromFile(Projeto.PastaGerador + 'Modelos.def');
  For I:=0 to LModelos.Items.Count-1 do
    if Pos('~',LModelos.Items[I]) > 0 then
    begin
      Lista_1.Items.Add;
      with Lista_1.Items[Lista_1.Items.Count-1] do
      begin
        Caption    := Copy(LModelos.Items[I],01,Pos('~',LModelos.Items[I])-1);
        ImageIndex := 8;
      end;
    end;
  Lista_1.Items[0].Selected := True;
  Lista_1.SetFocus;
end;

end.

