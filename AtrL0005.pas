unit AtrL0005;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Atributo, Estrutur;

Type
  TDCAMPOSTNUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTSEQUENCIA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTNOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTIPO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTAMANHO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTEDICAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTMASCARA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTITULO_C = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTAJUDA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTPADRAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTVALIDACAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTVALIDOS = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTDESCRICAO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCHAVE = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCALCULADO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTAUTOINCREMENTO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTSEMPRE_ATRIBUI = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTINVISIVEL = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTPRE_VALIDACAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTIPO_PRE_VALIDACAO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTLIMPAR_CAMPO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTMSG_ERRO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTAB_ESTRANGEIRA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCAMPO_CHAVE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCAMPOS_VISUAIS = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTESTILO_CHAVE = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTFILTRO_MESTRE = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTACAO_PESQUISA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTINDICE_CONSULTA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTEXTRA = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTAB_EXTRA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCAMPO_EXTRA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTAB_PESQUISA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTNAO_VIRTUAL = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTNOME_FISICO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTTIPO_FISICO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCALCULADO_FORMULA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTSQL_EXTRA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTSEM_INSERT = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTVALIDA_ONEXIT = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTSQL_EXTRA_INSERT = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTVARIAVEIS = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDCAMPOSTCODIFICACAO = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

constructor TDCAMPOSTNUMERO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NUMERO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'NºTab';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTSEQUENCIA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SEQUENCIA';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'NºSeq';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTNOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  TipoEdicao        := tpEdit;
  Titulo            := 'Nome do Objeto';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTIPO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TIPO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tipo de Objeto';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTAMANHO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TAMANHO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tamanho';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTEDICAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'EDICAO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Edição';
  Mascara           := '99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTMASCARA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'MASCARA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 80;
  TipoEdicao        := tpEdit;
  Titulo            := 'Máscara';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTITULO_C.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TITULO_C';
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

constructor TDCAMPOSTAJUDA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'AJUDA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Ajuda';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTPADRAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PADRAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Valor Padrão';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTVALIDACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VALIDACAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Validação';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTVALIDOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VALIDOS';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Valores Válidos';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTDESCRICAO.Create(AOwner: TComponent);
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

constructor TDCAMPOSTCHAVE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CHAVE';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Chave Primária';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTCALCULADO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CALCULADO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Calculado';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTAUTOINCREMENTO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'AUTOINCREMENTO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Autoincremento';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTSEMPRE_ATRIBUI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SEMPRE_ATRIBUI';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  TipoEdicao        := tpEdit;
  Titulo            := 'Sempre Atribui (Autoincremento)';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTINVISIVEL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'INVISIVEL';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Invisível';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTPRE_VALIDACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRE_VALIDACAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 300;
  TipoEdicao        := tpEdit;
  Titulo            := 'Pré-Validação';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTIPO_PRE_VALIDACAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TIPO_PRE_VALIDACAO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Ação da Pré-Validação';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTLIMPAR_CAMPO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'LIMPAR_CAMPO';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Limpar Campo (Pré-Validação)';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTMSG_ERRO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'MSG_ERRO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Mensagem Erro (Validação)';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTAB_ESTRANGEIRA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TAB_ESTRANGEIRA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  TipoEdicao        := tpEdit;
  Titulo            := 'Chave Estrangeira';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTCAMPO_CHAVE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPO_CHAVE';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campo Chave';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTCAMPOS_VISUAIS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPOS_VISUAIS';
  Tipo              := tpAlfanumerico;
  Tamanho           := 300;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campo Chave';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTESTILO_CHAVE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ESTILO_CHAVE';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Estilo Pesquisa';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTFILTRO_MESTRE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FILTRO_MESTRE';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Filtro Mestre';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTACAO_PESQUISA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ACAO_PESQUISA';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Acao Pesquisa';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTINDICE_CONSULTA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'INDICE_CONSULTA';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Ordem (Índice)';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTEXTRA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'EXTRA';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campo Extra';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTAB_EXTRA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TAB_EXTRA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tabela Extra';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTCAMPO_EXTRA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CAMPO_EXTRA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  TipoEdicao        := tpEdit;
  Titulo            := 'Campo Extra';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTAB_PESQUISA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TAB_PESQUISA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  TipoEdicao        := tpEdit;
  Titulo            := 'Procurar em';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTNAO_VIRTUAL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NAO_VIRTUAL';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Não Virtual';
  Mascara           := '9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTNOME_FISICO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'NOME_FISICO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Nome Físico';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTTIPO_FISICO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TIPO_FISICO';
  Tipo              := tpInteiro;
  Tamanho           := 2;
  TipoEdicao        := tpEdit;
  Titulo            := 'Tipo de Campo (SQL)';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTCALCULADO_FORMULA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CALCULADO_FORMULA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'Fórmula de Cálculo';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := True;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTSQL_EXTRA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SQL_EXTRA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'SQL Extra (Create Table)';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTSEM_INSERT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SEM_INSERT';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Sem Insert (SQL)';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTVALIDA_ONEXIT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VALIDA_ONEXIT';
  Tipo              := tpInteiro;
  Tamanho           := 1;
  TipoEdicao        := tpEdit;
  Titulo            := 'Validar em "OnExit"';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTSQL_EXTRA_INSERT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SQL_EXTRA_INSERT';
  Tipo              := tpAlfanumerico;
  Tamanho           := 100;
  TipoEdicao        := tpEdit;
  Titulo            := 'SQL Extra (Insert)';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTVARIAVEIS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VARIAVEIS';
  Tipo              := tpMemo;
  Tamanho           := 10;
  TipoEdicao        := tpEdit;
  Titulo            := 'Variáveis';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := '';
  Calculado         := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
end;

constructor TDCAMPOSTCODIFICACAO.Create(AOwner: TComponent);
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
