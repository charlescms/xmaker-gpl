unit AtrL0003;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDBDADOSNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSNOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSARQUIVO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSLOGIN = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSUSUARIO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSSENHA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSPARAMETROS = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOS_HOST_NAME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSBDADOS = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDBDADOSPADRAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation


constructor TDBDADOSNUMERO.Create(AOwner: TComponent);
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

constructor TDBDADOSNOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  TipoEdicao        := tpEdit;
  Titulo            := 'Alias';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSARQUIVO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ARQUIVO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  TipoEdicao        := tpEdit;
  Titulo            := 'Servidor/Database';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSLOGIN.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'LOGIN';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Login';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSUSUARIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'USUARIO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  TipoEdicao        := tpEdit;
  Titulo            := 'Usuário';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSSENHA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SENHA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  TipoEdicao        := tpEdit;
  Titulo            := 'Senha';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSPARAMETROS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PARAMETROS';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Parâmetros';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOS_HOST_NAME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'HOST_NAME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  TipoEdicao        := tpEdit;
  Titulo            := 'HostName/IP';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSBDADOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'BDADOS';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Banco de Dados';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDBDADOSPADRAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PADRAO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Conexão Padrão';
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
