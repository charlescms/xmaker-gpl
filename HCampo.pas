unit HCampo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, Buttons, ExtCtrls, ComCtrls, IniFiles;

type
  TFormHCampo = class(TForm)
    Panel1: TPanel;
    BtnHerdar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnTodos: TBitBtn;
    Lista: TCheckListBox;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnHerdarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnTodosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NrTab: String;
    NrTabOrigem: Integer;
    Seq: Integer;
    Herdou: Boolean;
  end;

var
  FormHCampo: TFormHCampo;

implementation

{$R *.DFM}

uses Abertura;

procedure TFormHCampo.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormHCampo.BtnHerdarClick(Sender: TObject);
Var
  I: Integer;
  xnome, xmascara, xtitulo_c, xajuda, xpadrao, xvalidacao, xvalidos, xdescricao: String;
  xtipo, xtamanho, xedicao, xchave, xcalculado: integer;
  xnomecmp: string;
begin
  for I:=0 to Lista.Items.Count-1 do
    if Lista.Checked[I] then
    begin
      xnomecmp := Trim(Copy(Lista.Items[I],01,Pos('-',Lista.Items[I])-1));
      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+NrTab + 'AND NOME = '+#39+xnomecmp+#39;
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabGlobal_i.DCAMPOST.First;
      if not TabGlobal_i.DCAMPOST.Eof then
      begin
        xnome      := TabGlobal_i.DCAMPOST.NOME.Conteudo;
        xtipo      := TabGlobal_i.DCAMPOST.TIPO.Conteudo;
        xtamanho   := TabGlobal_i.DCAMPOST.TAMANHO.Conteudo;
        xedicao    := TabGlobal_i.DCAMPOST.EDICAO.Conteudo;
        xmascara   := TabGlobal_i.DCAMPOST.MASCARA.Conteudo;
        xtitulo_c  := TabGlobal_i.DCAMPOST.TITULO_C.Conteudo;
        xajuda     := TabGlobal_i.DCAMPOST.AJUDA.Conteudo;
        xpadrao    := TabGlobal_i.DCAMPOST.PADRAO.Conteudo;
        xvalidacao := TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo;
        xvalidos   := TabGlobal_i.DCAMPOST.VALIDOS.Conteudo;
        xdescricao := TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo;
        xchave     := TabGlobal_i.DCAMPOST.CHAVE.Conteudo;
        xcalculado := TabGlobal_i.DCAMPOST.CALCULADO.Conteudo;
        TabGlobal_i.DCAMPOST.Inclui(Nil);
        TabGlobal_i.DCAMPOST.NUMERO.Conteudo    := NrTabOrigem;
        TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo := Seq;
        TabGlobal_i.DCAMPOST.NOME.Conteudo      := xnome;
        TabGlobal_i.DCAMPOST.TIPO.Conteudo      := xtipo;
        TabGlobal_i.DCAMPOST.TAMANHO.Conteudo   := xtamanho;
        TabGlobal_i.DCAMPOST.EDICAO.Conteudo    := xedicao;
        TabGlobal_i.DCAMPOST.MASCARA.Conteudo   := xmascara;
        TabGlobal_i.DCAMPOST.TITULO_C.Conteudo  := xtitulo_c;
        TabGlobal_i.DCAMPOST.AJUDA.Conteudo     := xajuda;
        TabGlobal_i.DCAMPOST.PADRAO.Conteudo    := xpadrao;
        TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo := xvalidacao;
        TabGlobal_i.DCAMPOST.VALIDOS.Conteudo   := xvalidos;
        TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo := xdescricao;
        TabGlobal_i.DCAMPOST.CHAVE.Conteudo     := xchave;
        TabGlobal_i.DCAMPOST.CALCULADO.Conteudo := xcalculado;
        TabGlobal_i.DCAMPOST.Post; // .Salva;
        Inc(Seq);
        Herdou := True;
      end;
    end;
  Close;
end;

procedure TFormHCampo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormHCampo.BtnTodosClick(Sender: TObject);
Var
  I: Integer;
begin
  for I:=0 to Lista.Items.Count-1 do
    Lista.Checked[I] := not Lista.Checked[I];
end;

end.
