unit AtrL0012;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDPROCESSOSNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSSEQUENCIA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSATIVO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSTITULO_I = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSTIPO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSTAB_ALVO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSCAMPO_ALVO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSCONDICAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSFORMULA_DIRETA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSFORMULA_INVERSA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSQUANTIDADE = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSCONDICAO_INCLUSAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSCONDICAO_EXCLUSAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSCAMPOS_ALVO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSCAMPOS_VALOR = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSAVULSO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROCESSOSAVULSO_VAR = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation


constructor TDPROCESSOSNUMERO.Create(AOwner: TComponent);
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

constructor TDPROCESSOSSEQUENCIA.Create(AOwner: TComponent);
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

constructor TDPROCESSOSTIPO.Create(AOwner: TComponent);
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

constructor TDPROCESSOSATIVO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ATIVO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Ativo';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSTITULO_I.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TITULO_I';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
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

constructor TDPROCESSOSTAB_ALVO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TAB_ALVO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tabela Alvo';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSCAMPO_ALVO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPO_ALVO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campo Alvo';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSCONDICAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CONDICAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 500;
  TipoEdicao        := tpEdit;
  Titulo            := 'Condição';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSFORMULA_DIRETA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FORMULA_DIRETA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 500;
  TipoEdicao        := tpEdit;
  Titulo            := 'Formula Direta';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSFORMULA_INVERSA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FORMULA_INVERSA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 500;
  TipoEdicao        := tpEdit;
  Titulo            := 'Formula Inversa';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSQUANTIDADE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'QUANTIDADE';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Quantidade';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSCONDICAO_INCLUSAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CONDICAO_INCLUSAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 500;
  TipoEdicao        := tpEdit;
  Titulo            := 'Condição de Inclusão';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSCONDICAO_EXCLUSAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CONDICAO_EXCLUSAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 500;
  TipoEdicao        := tpEdit;
  Titulo            := 'Condição de Exclusão';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSCAMPOS_ALVO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPOS_ALVO';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campos Alvo';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSCAMPOS_VALOR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPOS_VALOR';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campos Valor';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSAVULSO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'AVULSO';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Avulso';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROCESSOSAVULSO_VAR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'AVULSO_VAR';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Avulso Var';
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

