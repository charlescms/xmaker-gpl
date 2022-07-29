unit ObjProjeto;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, CheckLst, DB;

type
  TFormObjProjeto = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Pagina: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Lista_1: TCheckListBox;
    Lista_2: TCheckListBox;
    Lista_3: TCheckListBox;
    Lista_4: TCheckListBox;
    Habilitado: TCheckBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormObjProjeto: TFormObjProjeto;

implementation

{$R *.DFM}

uses Tabela, Abertura, Rotinas;

procedure TFormObjProjeto.FormShow(Sender: TObject);
var
  BookMark_1: TBookMark;
  BookMark_2: TBookMark;
  BookMark_3: TBookMark;
  BookMark_4: TBookMark;
  Retorno: Integer;
begin
  Pagina.ActivePageIndex := 0;

  BookMark_1 := TabGlobal_i.DPROC_EXTERNA.GetBookmark;
  TabGlobal_i.DPROC_EXTERNA.First;
  while not TabGlobal_i.DPROC_EXTERNA.Eof do
  begin
    Lista_1.Items.AddObject(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo, TObject(TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo));
    Retorno := Localiza_ObjProjeto('ST', TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo, -1, False);
    if Retorno = -1 then
      Lista_1.Checked[Lista_1.Items.Count-1] := TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo = 1
    else
      Lista_1.Checked[Lista_1.Items.Count-1] := Retorno = 1;
    TabGlobal_i.DPROC_EXTERNA.Next;
  end;

  BookMark_2 := TabGlobal_i.DSQL_SCRIPT.GetBookmark;
  TabGlobal_i.DSQL_SCRIPT.First;
  while not TabGlobal_i.DSQL_SCRIPT.Eof do
  begin
    Lista_2.Items.AddObject(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo, TObject(TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo));
    Retorno := Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, -1, False);
    if Retorno = -1 then
      Lista_2.Checked[Lista_2.Items.Count-1] := TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo = 1
    else
      Lista_2.Checked[Lista_2.Items.Count-1] := Retorno = 1;
    TabGlobal_i.DSQL_SCRIPT.Next;
  end;

  BookMark_3 := TabGlobal_i.DCONSULTA.GetBookmark;
  TabGlobal_i.DCONSULTA.First;
  while not TabGlobal_i.DCONSULTA.Eof do
  begin
    Lista_3.Items.AddObject(TabGlobal_i.DCONSULTA.NOME.Conteudo, TObject(TabGlobal_i.DCONSULTA.NUMERO.Conteudo));
    Retorno := Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, -1, False);
    if Retorno = -1 then
      Lista_3.Checked[Lista_3.Items.Count-1] := TabGlobal_i.DCONSULTA.ATIVO.Conteudo = 1
    else
      Lista_3.Checked[Lista_3.Items.Count-1] := Retorno = 1;
    TabGlobal_i.DCONSULTA.Next;
  end;

  BookMark_4 := TabGlobal_i.DTABELAS.GetBookmark;
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    Lista_4.Items.AddObject(TabGlobal_i.DTABELAS.NOME.Conteudo, TObject(TabGlobal_i.DTABELAS.NUMERO.Conteudo));
    Retorno := Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, -1, False);
    if Retorno = -1 then
      Lista_4.Checked[Lista_4.Items.Count-1] := TabGlobal_i.DTABELAS.GLOBAL.Conteudo = 1
    else
      Lista_4.Checked[Lista_4.Items.Count-1] := Retorno = 1;
    TabGlobal_i.DTABELAS.Next;
  end;

  TabGlobal_i.DPROC_EXTERNA.GotoBookmark(BookMark_1);
  TabGlobal_i.DSQL_SCRIPT.GotoBookmark(BookMark_2);
  TabGlobal_i.DCONSULTA.GotoBookmark(BookMark_3);
  TabGlobal_i.DTABELAS.GotoBookmark(BookMark_4);

  if TabGlobal_i.DPROJETO.OBJETOS_PROJETO.Conteudo = 1 then
    Habilitado.Checked := True
  else
    Habilitado.Checked := False;  
end;

end.
