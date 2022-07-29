unit AtrL0016;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDTRIGGERNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERSEQUENCIA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERATIVO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERNOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERINSTANTE_ATIVACAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERDISPARAR = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERBLOCO_SQL = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDTRIGGERDESCRICAO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

constructor TDTRIGGERNUMERO.Create(AOwner: TComponent);
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

constructor TDTRIGGERSEQUENCIA.Create(AOwner: TComponent);
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

constructor TDTRIGGERATIVO.Create(AOwner: TComponent);
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

constructor TDTRIGGERNOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
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

constructor TDTRIGGERINSTANTE_ATIVACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'INSTANTE_ATIVACAO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Instante de Ativação';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDTRIGGERDISPARAR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'DISPARAR';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Disparar após';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDTRIGGERBLOCO_SQL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'BLOCO_SQL';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Ação - Instruções SQL';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDTRIGGERDESCRICAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'DESCRICAO';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Descrição';
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
