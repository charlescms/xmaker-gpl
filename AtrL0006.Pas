unit AtrL0006;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDINDICESTNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDINDICESTSEQUENCIA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDINDICESTCAMPOST = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDINDICESTTITULO_I = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDINDICESTCRESCENTE = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation


constructor TDINDICESTNUMERO.Create(AOwner: TComponent);
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

constructor TDINDICESTSEQUENCIA.Create(AOwner: TComponent);
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

constructor TDINDICESTCAMPOST.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPOST';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campos';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDINDICESTTITULO_I.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TITULO_I';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'Título';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDINDICESTCRESCENTE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CRESCENTE';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Crescente';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

end.
