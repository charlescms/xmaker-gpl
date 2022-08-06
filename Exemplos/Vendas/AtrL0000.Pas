unit AtrL0000;

interface

uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,
  Rotinas, Validar, Atributo, Estrutur, Controls;

Type
  TDAtividades_ATI_CODIGO = class(TTipoInteiro)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;

Type
  TDAtividades_ATI_DESCRICAO = class(TTipoAlfanumerico)
  public
    constructor Create(AOwner: TComponent); override;
    { Validação }
    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;
  end;


implementation

uses Abertura;

constructor TDAtividades_ATI_CODIGO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Nome              := 'ATI_CODIGO';
  Tipo              := tpInteiro;
  Tamanho           := 3;
  CasasDecimais     := 0;
  TipoEdicao        := tpEdit;
  TipoSQL           := '';
  SQL_Extra         := '';
  Titulo            := 'Código';
  Mascara           := '999';
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
  NomeTabela        := 'Atividades';
  NomeOriginal      := 'ATI_CODIGO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDAtividades_ATI_CODIGO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
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

constructor TDAtividades_ATI_DESCRICAO.Create(AOwner: TComponent);
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
  NomeTabela        := 'Atividades';
  NomeOriginal      := 'ATI_DESCRICAO';
  TabEstrangeira    := '';
  ChaveEstrangeira  := '';
  CamposVisuais     := '';
  EstiloPesquisa    := 0;
  AcaoPesquisa      := 0;
  FiltroFixo.Clear;
end;

function TDAtividades_ATI_DESCRICAO.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;
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

end.
