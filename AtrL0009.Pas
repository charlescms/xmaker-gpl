unit AtrL0009;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDRESTRITATNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDRESTRITATSEQUENCIA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDRESTRITATCODIFICACAO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation


constructor TDRESTRITATNUMERO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NUMERO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Nº.Tab.';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDRESTRITATSEQUENCIA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SEQUENCIA';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Nº.Seq.';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDRESTRITATCODIFICACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CODIFICACAO';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Codificação';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

end.
