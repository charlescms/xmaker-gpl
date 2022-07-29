unit AtrL0000;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDPROJETONUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOTITULO_P = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOEMPRESA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOANALISTA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOPROGRAMADOR = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOVERSAO_P = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOINICIO = class(TTipoData)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOICONE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOAPRESENTACAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOAJUSTAR = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOFUNDO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOFORMATODATA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOCONFIRMASAIDA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOMULTIPLASINSTANCIAS = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOHINTBALAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOMENUXP = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETODICIONARIO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOCONTROLEACESSO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOPASTADICIONARIO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOSENHA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOLINGUAGEM = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOBDADOS = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETONSERVIDOR = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOBDCONEXAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOSELECIONAR_EMP = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETODEIXAR_NA_SENHA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOMODELO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOCONTROLE_ACESSO_INTERNO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOTABELAS_UTILIZADAS = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDPROJETOOBJETOS_PROJETO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

constructor TDPROJETONUMERO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NUMERO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Número';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOTITULO_P.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TITULO_P';
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

constructor TDPROJETOEMPRESA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'EMPRESA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'Empresa';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOANALISTA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ANALISTA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'Analista';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOPROGRAMADOR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PROGRAMADOR';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'Programador';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOVERSAO_P.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VERSAO_P';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  TipoEdicao        := tpEdit;
  Titulo            := 'Versão';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOINICIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'INICIO';
  Tipo              := tpData;
  Tamanho           := 8;
  TipoEdicao        := tpEdit;
  Titulo            := 'Início';
  Mascara           := '99/99/99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOICONE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ICONE';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  TipoEdicao        := tpEdit;
  Titulo            := 'Icone';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOAPRESENTACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'APRESENTACAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  TipoEdicao        := tpEdit;
  Titulo            := 'Apresentação';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOAJUSTAR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'AJUSTAR';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Ajustar';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOFUNDO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FUNDO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  TipoEdicao        := tpEdit;
  Titulo            := 'Fundo';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOFORMATODATA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FORMATODATA';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Formato da Data';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOCONFIRMASAIDA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CONFIRMASAIDA';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Confirma Saída';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOMULTIPLASINSTANCIAS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'MULTIPLASINSTANCIAS';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Múltiplas Instâncias';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOHINTBALAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'HINTBALAO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'HintBalão';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOMENUXP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'MENUXP';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Menu XP';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETODICIONARIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'DICIONARIO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Dicionário';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOCONTROLEACESSO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CONTROLEACESSO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Controle Acesso';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOPASTADICIONARIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PASTADICIONARIO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Pata Dicionário';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOSENHA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SENHA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 6;
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

constructor TDPROJETOLINGUAGEM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'LINGUAGEM';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Linguagem';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOBDADOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'BDADOS';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Base de Dados';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETONSERVIDOR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NSERVIDOR';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  TipoEdicao        := tpEdit;
  Titulo            := 'Servidor';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o servidor';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOBDCONEXAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'BDCONEXAO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Conexão';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o componente de conexão';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOSELECIONAR_EMP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SELECIONAR_EMP';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Selecionar Emp.';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETODEIXAR_NA_SENHA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'DEIXAR_NA_SENHA';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Deixar na Senha';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOMODELO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'MODELO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Modelo de Projeto';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOCONTROLE_ACESSO_INTERNO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CONTROLE_ACESSO_INTERNO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Número';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOTABELAS_UTILIZADAS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TABELAS_UTILIZADAS';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tabelas Utilizadas';
  Mascara           := '';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDPROJETOOBJETOS_PROJETO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'OBJETOS_PROJETO';
  Tipo              := tpInteiro;
  Tamanho           := 5;
  TipoEdicao        := tpEdit;
  Titulo            := 'Objetos Projeto';
  Mascara           := '99999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

end.
