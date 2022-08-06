unit AtrL0001;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Validar, Atributo, Estrutur, Controls;

Type
  TDClientes_CLI_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDClientes_CLI_NOME = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDClientes_TIPO_PESSOA = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Valor padrão }
    function ValorPadrao: String; override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
    { Valores válidos }
    procedure IncluiValoresValidos; override;
  end;

Type
  TDClientes_CPF = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
    { Pre-Validação }
    function PreValidacao: Boolean; override;
  end;

Type
  TDClientes_CNPJ = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
    { Pre-Validação }
    function PreValidacao: Boolean; override;
  end;

Type
  TDClientes_CLI_ENDERECO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_CLI_BAIRRO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_CLI_CIDADE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_UF = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDClientes_CEP = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_TELEFONE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_TELEFONE_2 = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_CELULAR = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_EMAIL = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_SITE = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Valor padrão }
    function ValorPadrao: String; override;
  end;

Type
  TDClientes_CLI_OBS = class(TTipoMemo)
  public
    constructor Create(AOwner: TComponent); override;
  end;

Type
  TDClientes_CLI_CADASTRO = class(TTipoData)
  public
    constructor Create(AOwner: TComponent); override;
    { Valor padrão }
    function ValorPadrao: TDateTime; override;
  end;

Type
  TDClientes_ATI_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDClientes_ATI_DESCRICAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

uses Abertura;

constructor TDClientes_CLI_CODIGO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_CODIGO';
  Tipo              := tpInteiro;
  Tamanho           := 6;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Código';
  Mascara           := '999999';
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_CODIGO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_CLI_CODIGO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Código inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDClientes_CLI_NOME.Create(AOwner: TComponent);
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_NOME';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_CLI_NOME.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Nome inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDClientes_TIPO_PESSOA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TIPO_PESSOA';
  Tipo              := tpAlfanumerico;
  Tamanho           := 1;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Tipo de Pessoa';
  Mascara           := 'X';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o tipo de pessoa';
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'TIPO_PESSOA';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_TIPO_PESSOA.ValorPadrao: String;
begin
  Result := 'F';
end;

function TDClientes_TIPO_PESSOA.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VALORNULO(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Tipo de Pessoa inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

procedure TDClientes_TIPO_PESSOA.IncluiValoresValidos;
begin
  inherited IncluiValoresValidos;
  IncluiValorValido('F', 'Física');
  IncluiValorValido('J', 'Jurídica');
  Valor.OnGetText := GetText;
end;

constructor TDClientes_CPF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CPF';
  Tipo              := tpAlfanumerico;
  Tamanho           := 11;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'CPF';
  Mascara           := '999.999.999-99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o número do CPF';
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
  PreValidacao_ativa:= True;
  Acao              := 2;
  LimparCampo       := True;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CPF';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_CPF.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VCPF(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('CPF inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

function TDClientes_CPF.PreValidacao: Boolean;
begin
  Result := TabGlobal.DClientes.TIPO_PESSOA.Conteudo = 'F';
end;

constructor TDClientes_CNPJ.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CNPJ';
  Tipo              := tpAlfanumerico;
  Tamanho           := 14;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'CNPJ';
  Mascara           := '99.999.999/9999-99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o número do CNPJ';
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
  PreValidacao_ativa:= True;
  Acao              := 2;
  LimparCampo       := True;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CNPJ';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_CNPJ.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VCNPJ(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('CNPJ inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

function TDClientes_CNPJ.PreValidacao: Boolean;
begin
  Result := TabGlobal.DClientes.TIPO_PESSOA.Conteudo = 'J';
end;

constructor TDClientes_CLI_ENDERECO.Create(AOwner: TComponent);
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_ENDERECO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_CLI_BAIRRO.Create(AOwner: TComponent);
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_BAIRRO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_CLI_CIDADE.Create(AOwner: TComponent);
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_CIDADE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_UF.Create(AOwner: TComponent);
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'UF';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_UF.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not VUF(ValorString) then
  begin
    Result := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('UF inválido !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDClientes_CEP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CEP';
  Tipo              := tpAlfanumerico;
  Tamanho           := 8;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'CEP';
  Mascara           := '99999-999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o CEP';
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CEP';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_TELEFONE.Create(AOwner: TComponent);
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'TELEFONE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_TELEFONE_2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'TELEFONE_2';
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'TELEFONE_2';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_CELULAR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CELULAR';
  Tipo              := tpAlfanumerico;
  Tamanho           := 12;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Celular';
  Mascara           := '(Z999)Z999-9999';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe o telefone';
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CELULAR';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_EMAIL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'EMAIL';
  Tipo              := tpAlfanumerico;
  Tamanho           := 50;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'E-Mail';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o e-mail';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 14;
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
  Extra             := False;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'EMAIL';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_SITE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'SITE';
  Tipo              := tpAlfanumerico;
  Tamanho           := 60;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Site';
  Mascara           := '';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe o Site';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 15;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 15;
  Index_Default     := 15;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'SITE';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_SITE.ValorPadrao: String;
begin
  Result := 'http://';
end;

constructor TDClientes_CLI_OBS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_OBS';
  Tipo              := tpMemo;
  Tamanho           := 10;
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
  Valor.Index       := 16;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 16;
  Index_Default     := 16;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_OBS';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

constructor TDClientes_CLI_CADASTRO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'CLI_CADASTRO';
  Tipo              := tpData;
  Tamanho           := 8;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Dt.Cadastro';
  Mascara           := '99/99/99';
  CaractereEdicao   := '_';
  Ajuda             := 'Informe a data de cadastro';
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
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'CLI_CADASTRO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_CLI_CADASTRO.ValorPadrao: TDateTime;
begin
  Result := DataAtual;
end;

constructor TDClientes_ATI_CODIGO.Create(AOwner: TComponent);
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
  Valor.Index       := 17;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 17;
  Index_Default     := 17;
  AutoIncremento    := 0;
  Incremento_Auto   := False;
  SempreAtribui     := False;
  PreValidacao_ativa:= False;
  Acao              := 1;
  LimparCampo       := False;
  MensagemErro      := '';
  Extra             := False;
  NomeTabela        := 'Clientes';
  NomeOriginal      := 'ATI_CODIGO';
  TabEstrangeira    := 'Atividades';
  ChaveEstrangeira  := 'ATI_CODIGO';
  CamposVisuais     := 'ATI_DESCRICAO;ATI_CODIGO';
  EstiloPesquisa    := 1;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDClientes_ATI_CODIGO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
begin
  if not TabGlobal.DClientes.PesquisaRelacionados('Atividades') then
  begin
    Result  := False;
    if Trim(MensagemErro) = '' then
      MsgErro := Format('Atividade não encontrado !',[Titulo])
    else
      MsgErro := Format(MensagemErro,[Titulo]);
    exit;
  end;
  Result  := True;
  MsgErro := '';
end;

constructor TDClientes_ATI_DESCRICAO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ATI_DESCRICAO';
  Tipo              := tpAlfanumerico;
  Tamanho           := 40;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'At. Descrição';
  Mascara           := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  CaractereEdicao   := ' ';
  Ajuda             := 'Informe a descrição';
  Calculado         := False;
  Calculado_F       := False;
  Valor.FieldName   := Nome;
  Valor.Size        := TamanhoDado;
  Valor.DisplayLabel:= Titulo;
  Valor.Calculated  := Calculado;
  Valor.Index       := 18;
  Valor.ReadOnly    := True;
  Valor.Visible     := True;
  Visible_Default   := True;
  Chave             := False;
  Index             := 18;
  Index_Default     := 18;
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

end.
