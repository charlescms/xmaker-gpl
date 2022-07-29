unit Abertura_p;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TTabGlobal = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    lista_nomes: TStringList;
  public
    { Public declarations }
    procedure Ini_Tabelas_proj;
    procedure Free_Tabelas_Proj;
  end;

var
  TabGlobal: TTabGlobal;

implementation

{$R *.DFM}

uses Rotinas, Abertura, Tabela;

procedure TTabGlobal.Ini_Tabelas_proj;
var
  qy_Tabela, tmp_tabela: TTabela;
begin
  Free_Tabelas_proj;
  Lista_Nomes.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DTABELAS.DataBase;
    Transaction := TabGlobal_i.DTABELAS.Transaction;
    Sql.Text := 'Select Numero, Nome, Titulo_T From Tabelas Order By Nome';
    Abrir;
    First;
    while not Eof do
    begin
      if Trim(Fields[1].AsString) <> '' then
      begin
        tmp_tabela := TTabela.Create(TabGlobal);
        tmp_tabela.Name := 'D' + Trim(Fields[1].AsString);
        Lista_Nomes.Add(tmp_tabela.Name);
      end;
      Next;
    end;
    Close;

    Sql.Text := 'Select Numero, Nome, Titulo_i From Consulta Order By Nome';
    Abrir;
    First;
    while not Eof do
    begin
      if Trim(Fields[1].AsString) <> '' then
      begin
        tmp_tabela := TTabela.Create(TabGlobal);
        tmp_tabela.Name := 'CS' + Trim(Fields[1].AsString);
        Lista_Nomes.Add(tmp_tabela.Name);
      end;
      Next;
    end;
    Close;

    Free;
  end;
end;

procedure TTabGlobal.Free_Tabelas_proj;
var
  I: Integer;
begin
  for I:=0 to Lista_Nomes.Count-1 do
    if Assigned(FindComponent(Lista_Nomes[I])) then
      TTabela(FindComponent(Lista_Nomes[I])).Free;
end;

procedure TTabGlobal.DataModuleCreate(Sender: TObject);
begin
  Lista_Nomes := TStringList.Create;
end;

procedure TTabGlobal.DataModuleDestroy(Sender: TObject);
begin
  Lista_Nomes.Free;
end;

end.
