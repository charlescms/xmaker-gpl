unit AtrL0001;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDFORMULARIONUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDFORMULARIONOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDFORMULARIOTIPO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDFORMULARIOTITULO_F = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDFORMULARIOTABELA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDFORMULARIOMODELO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation


constructor TDFORMULARIONUMERO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NUMERO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'N�mero';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o n�mero';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDFORMULARIONOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 15;
  TipoEdicao        := tpEdit;
  Titulo            := 'Nome';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDFORMULARIOTIPO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TIPO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tipo';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDFORMULARIOTITULO_F.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TITULO_F';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'T�tulo';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDFORMULARIOTABELA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TABELA';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tabela';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDFORMULARIOMODELO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'MODELO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'Modelo';
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
