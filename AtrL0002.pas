unit AtrL0002;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDMENUNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUNIVEL_M = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUNOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUTIPO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUTITULO_M = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUIMAGEM = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUFORMULARIO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUAVULSO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUPROG_EXE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDMENUIDENTIFICACAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation


constructor TDMENUNUMERO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NUMERO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Número';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDMENUNIVEL_M.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NIVEL_M';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Nível';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDMENUNOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
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

constructor TDMENUTIPO.Create(AOwner: TComponent);
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

constructor TDMENUTITULO_M.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TITULO_M';
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

constructor TDMENUIMAGEM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'IMAGEM';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Imagem';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDMENUFORMULARIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FORMULARIO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Formulário';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDMENUAVULSO.Create(AOwner: TComponent);
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

constructor TDMENUPROG_EXE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PROG_EXE';
  Tipo              := tpAlfanumerico;
  Tamanho           := 200;
  TipoEdicao        := tpEdit;
  Titulo            := 'Programa EXE';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDMENUIDENTIFICACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'IDENTIFICACAO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Identificacao';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

end.
