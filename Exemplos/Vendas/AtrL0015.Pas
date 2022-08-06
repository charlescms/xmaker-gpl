unit AtrL0015;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Validar, Atributo, Estrutur, Controls;

Type
  TDVendas_VEN_NUMERO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDVendas_VEN_DATA = class(TTipoData)
  public
    constructor Create(AOwner: TComponent); override;
    { Valor padrão }
    function ValorPadrao: TDateTime; override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDVendas_CLI_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDVendas_CLI_NOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_CLI_ENDERECO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_CLI_BAIRRO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_CLI_CIDADE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_UF = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_TELEFONE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_ATI_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_ATI_DESCRICAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_VEN_OBS_1 = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_VEN_OBS_2 = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_VEN_TOTAL = class(TTipoFracionario)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDVendas_VEN_QTDE = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

uses Abertura;

constructor TDVendas_VEN_NUMERO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VEN_NUMERO';
  Tipo              := tpInteiro;
  Tamanho           := 7;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Número';
  Mascara           := '9999999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o número da venda';
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
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'VEN_NUMERO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDVendas_VEN_NUMERO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Número inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDVendas_VEN_DATA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VEN_DATA';
  Tipo              := tpData;
  Tamanho           := 8;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Data';
  Mascara           := '99/99/99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe a data';
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
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'VEN_DATA';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDVendas_VEN_DATA.ValorPadrao: TDateTime;
begin
  Result := DataAtual;
end;

function TDVendas_VEN_DATA.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Data inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDVendas_CLI_CODIGO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_CODIGO';
  Tipo              := tpInteiro;
  Tamanho           := 6;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Cliente';
  Mascara           := '999999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o cliente';
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
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'CLI_CODIGO';
  TabEstrangeira    := 'Clientes';
  ChaveEstrangeira  := 'CLI_CODIGO';
  CamposVisuais     := 'CLI_NOME;CLI_CODIGO;ATI_DESCRICAO;ATI_CODIGO';
  EstiloPesquisa    := 1;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDVendas_CLI_CODIGO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not TabGlobal.DVendas.PesquisaRelacionados('Clientes') then
  begin
    Result  := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Cliente não encontrado !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDVendas_CLI_NOME.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_NOME';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Nome';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o nome';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 3;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_NOME';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_CLI_ENDERECO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_ENDERECO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Endereço';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o endereço';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 4;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_ENDERECO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_CLI_BAIRRO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_BAIRRO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 30;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Bairro';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o bairro';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 5;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_BAIRRO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_CLI_CIDADE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_CIDADE';
  Tipo              := tpAlfanumerico;
  Tamanho           := 20;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Cidade';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe a cidade';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 6;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_CIDADE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_UF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'UF';
  Tipo              := tpAlfanumerico;
  Tamanho           := 2;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'UF';
  Mascara           := 'AA';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe a unidade da federação';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 7;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'UF';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_TELEFONE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TELEFONE';
  Tipo              := tpAlfanumerico;
  Tamanho           := 12;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Telefone';
  Mascara           := '(Z999)Z999-9999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o telefone';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 8;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'TELEFONE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_ATI_CODIGO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ATI_CODIGO';
  Tipo              := tpInteiro;
  Tamanho           := 3;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Atividade';
  Mascara           := '999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o código da atividade';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 13;
  Valor.ReadOnly    := True;
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
  Extra             := True;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'ATI_CODIGO';
  TabEstrangeira    := 'Atividades';
  ChaveEstrangeira  := 'ATI_CODIGO';
  CamposVisuais     := 'ATI_DESCRICAO;ATI_CODIGO';
  EstiloPesquisa    := 1;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_ATI_DESCRICAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ATI_DESCRICAO';
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
  NomeTabela        := 'Atividades';
  NomeOriginal      := 'ATI_DESCRICAO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_VEN_OBS_1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VEN_OBS_1';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Obs.';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe as observações';
  Calculado         := False;
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
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'VEN_OBS_1';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_VEN_OBS_2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VEN_OBS_2';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Obs.';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe as observações';
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
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'VEN_OBS_2';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_VEN_TOTAL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VEN_TOTAL';
  Tipo              := tpFracionario;
  Tamanho           := 10;
  CasasDecimais     := 2;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Total';
  Mascara           := '-ZZ.ZZZ.ZZ9,99';
  CaractereEdicao   := '_';
  Ajuda             := '';
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
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'VEN_TOTAL';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDVendas_VEN_QTDE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'VEN_QTDE';
  Tipo              := tpInteiro;
  Tamanho           := 6;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Qtde. Itens';
  Mascara           := 'ZZZZZ9';
  CaractereEdicao   := '_';
  Ajuda             := '';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 12;
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
  Extra             := False;
  NomeTabela        := 'Vendas';
  NomeOriginal      := 'VEN_QTDE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

end.
