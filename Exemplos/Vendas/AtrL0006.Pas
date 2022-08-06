unit AtrL0006;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Validar, Atributo, Estrutur, Controls;

Type
  TDProdutos_PRO_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDProdutos_PRO_DESCRICAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDProdutos_PRO_QUANTIDADE = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_PRO_MINIMO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_PRO_MAXIMO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_PRO_CUSTO = class(TTipoFracionario)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_PRO_MARGEM = class(TTipoFracionario)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_PRO_PRECO = class(TTipoFracionario)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_TOTAL_CUSTO = class(TTipoFracionario)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_TOTAL_VENDA = class(TTipoFracionario)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_PRO_FOTO = class(TTipoImagem)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_FOR_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDProdutos_FOR_CODIGO_2 = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDProdutos_FOR_NOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDProdutos_FOR_NOME_2 = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

uses Abertura;

constructor TDProdutos_PRO_CODIGO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_CODIGO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Produto';
  Mascara           := '9999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o código';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 0;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := True;
  Index             := 0;
  Index_Default     := 0;
  AutoIncremento    := 1;
  Incremento_Auto   := False;
  SempreAtribui     := True;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_CODIGO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDProdutos_PRO_CODIGO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Produto inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDProdutos_PRO_DESCRICAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_DESCRICAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Descrição';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe a descrição';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 1;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 1;
  Index_Default     := 1;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_DESCRICAO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDProdutos_PRO_DESCRICAO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Descrição inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDProdutos_PRO_QUANTIDADE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_QUANTIDADE';
  Tipo              := tpInteiro;
  Tamanho           := 5;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Qtde.';
  Mascara           := '-ZZZZ9';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe a quantidade no estoque';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 2;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 2;
  Index_Default     := 2;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_QUANTIDADE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_PRO_MINIMO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_MINIMO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Qtde. Mínima';
  Mascara           := 'ZZZ9';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe a quantidade mínima no estoque';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 3;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 3;
  Index_Default     := 3;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_MINIMO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_PRO_MAXIMO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_MAXIMO';
  Tipo              := tpInteiro;
  Tamanho           := 4;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Qtde. Máxima';
  Mascara           := 'ZZZ9';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe a quantidade máxima no estoque';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 4;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 4;
  Index_Default     := 4;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_MAXIMO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_PRO_CUSTO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_CUSTO';
  Tipo              := tpFracionario;
  Tamanho           := 8;
  CasasDecimais     := 2;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Preço Custo';
  Mascara           := 'ZZZ.ZZ9,99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o preço de custo';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 5;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 5;
  Index_Default     := 5;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_CUSTO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_PRO_MARGEM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_MARGEM';
  Tipo              := tpFracionario;
  Tamanho           := 5;
  CasasDecimais     := 2;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Margem';
  Mascara           := 'ZZ9,99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe a margem de lucro';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 6;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 6;
  Index_Default     := 6;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_MARGEM';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_PRO_PRECO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_PRECO';
  Tipo              := tpFracionario;
  Tamanho           := 8;
  CasasDecimais     := 2;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Preço Venda';
  Mascara           := 'ZZZ.ZZ9,99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o preço de venda';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 7;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 7;
  Index_Default     := 7;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_PRECO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_TOTAL_CUSTO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TOTAL_CUSTO';
  Tipo              := tpFracionario;
  Tamanho           := 10;
  CasasDecimais     := 2;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Total Custo';
  Mascara           := '-ZZ.ZZZ.ZZ9,99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := True;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 8;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 8;
  Index_Default     := 8;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'TOTAL_CUSTO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_TOTAL_VENDA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TOTAL_VENDA';
  Tipo              := tpFracionario;
  Tamanho           := 10;
  CasasDecimais     := 2;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Total Venda';
  Mascara           := '-ZZ.ZZZ.ZZ9,99';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := True;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 9;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 9;
  Index_Default     := 9;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'TOTAL_VENDA';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_PRO_FOTO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'PRO_FOTO';
  Tipo              := tpImagem;
  Tamanho           := 10;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Foto';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe a foto do produto';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 10;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 10;
  Index_Default     := 10;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'PRO_FOTO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_FOR_CODIGO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FOR_CODIGO';
  Tipo              := tpInteiro;
  Tamanho           := 6;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := '1º Fornecedor';
  Mascara           := '999999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o código do fornecedor';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 11;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 11;
  Index_Default     := 11;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'FOR_CODIGO';
  TabEstrangeira    := 'Fornecedores';
  ChaveEstrangeira  := 'FOR_CODIGO';
  CamposVisuais     := 'FOR_NOME;FOR_CODIGO';
  EstiloPesquisa    := 1;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDProdutos_FOR_CODIGO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('1º Fornecedor inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  if not TabGlobal.DProdutos.PesquisaRelacionados('Fornecedores') then
  begin
    Result  := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('1º Fornecedor não encontrado !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDProdutos_FOR_CODIGO_2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FOR_CODIGO_2';
  Tipo              := tpInteiro;
  Tamanho           := 6;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := '2º Fornecedor';
  Mascara           := '999999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o código do fornecedor';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 13;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 13;
  Index_Default     := 13;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Produtos';
  NomeOriginal      := 'FOR_CODIGO_2';
  TabEstrangeira    := 'Fornecedores';
  ChaveEstrangeira  := 'FOR_CODIGO';
  CamposVisuais     := 'FOR_NOME;FOR_CODIGO';
  EstiloPesquisa    := 1;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDProdutos_FOR_CODIGO_2.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('2º Fornecedor inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  if not TabGlobal.DProdutos.PesquisaRelacionados('Fornecedores_2') then
  begin
    Result  := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('2º Fornecedor não encontrado !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDProdutos_FOR_NOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FOR_NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Nome 1º Fornecedor';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o nome';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 12;
  Valor.ReadOnly    := True;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 12;
  Index_Default     := 12;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := True;
  NomeTabela        := 'Fornecedores';
  NomeOriginal      := 'FOR_NOME';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDProdutos_FOR_NOME_2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'FOR_NOME_2';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Nome 2º Fornecedor';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o nome';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 14;
  Valor.ReadOnly    := True;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 14;
  Index_Default     := 14;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := True;
  NomeTabela        := 'Fornecedores_2';
  NomeOriginal      := 'FOR_NOME';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

end.
