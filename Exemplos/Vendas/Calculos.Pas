{
 Cálculos para Campos
}

unit Calculos;

interface

uses SysUtils, StdCtrls, BaseD, classes, Atributo, Estrutur, Princ,
     {$I LTab.pas}
     Rotinas, Validar, Controls, Tabela, Abertura, Publicas;


function CalculaDProdutos_TOTAL_CUSTO(AOwner: TComponent) : Double;

function CalculaDProdutos_TOTAL_CUSTO_Rel(AOwner: TComponent) : Double;

function CalculaDProdutos_TOTAL_VENDA(AOwner: TComponent) : Double;

function CalculaDProdutos_TOTAL_VENDA_Rel(AOwner: TComponent) : Double;

function CalculaDItens_Venda_ITE_TOTAL(AOwner: TComponent) : Double;

function CalculaDItens_Venda_ITE_TOTAL_Rel(AOwner: TComponent) : Double;

function CalculaDConsulta_Itens_Venda_ITE_TOTAL(AOwner: TComponent) : Double;

function CalculaDConsulta_Itens_Venda_ITE_TOTAL_Rel(AOwner: TComponent) : Double;

implementation

function CalculaDProdutos_TOTAL_CUSTO(AOwner: TComponent) : Double;
  // variáveis locais, exemplo: I: Double;
begin
  { a variável "Result" deverá conter o resultado, exemplo:
    I := TabGlobal.DProdutos.TOTAL_CUSTO.Conteudo / 100;
    Result := I; }
    // CalcC = Cálculo Correto com duas casas decimais ...
  Result := CalcC(TabGlobal.DProdutos.PRO_QUANTIDADE.Conteudo,
                  TabGlobal.DProdutos.PRO_CUSTO.Conteudo, '*', 02);
end;

function CalculaDProdutos_TOTAL_CUSTO_Rel(AOwner: TComponent) : Double;
var
  DProdutos: TDProdutos;
  // variáveis locais, exemplo: I: Double;
begin
  DProdutos := TDProdutos(LocalizaTabela(AOwner, 'DProdutos'));
  { a variável "Result" deverá conter o resultado, exemplo:
    I := DProdutos.TOTAL_CUSTO.Conteudo / 100;
    Result := I; }
    // CalcC = Cálculo Correto com duas casas decimais ...
  Result := CalcC(DProdutos.PRO_QUANTIDADE.Conteudo,
                  DProdutos.PRO_CUSTO.Conteudo, '*', 02);
end;

function CalculaDProdutos_TOTAL_VENDA(AOwner: TComponent) : Double;
  // variáveis locais, exemplo: I: Double;
begin
  { a variável "Result" deverá conter o resultado, exemplo:
    I := TabGlobal.DProdutos.TOTAL_VENDA.Conteudo / 100;
    Result := I; }
    // CalcC = Cálculo Correto com duas casas decimais ...
  Result := CalcC(TabGlobal.DProdutos.PRO_QUANTIDADE.Conteudo,
                  TabGlobal.DProdutos.PRO_PRECO.Conteudo, '*', 02);
end;

function CalculaDProdutos_TOTAL_VENDA_Rel(AOwner: TComponent) : Double;
var
  DProdutos: TDProdutos;
  // variáveis locais, exemplo: I: Double;
begin
  DProdutos := TDProdutos(LocalizaTabela(AOwner, 'DProdutos'));
  { a variável "Result" deverá conter o resultado, exemplo:
    I := DProdutos.TOTAL_VENDA.Conteudo / 100;
    Result := I; }
    // CalcC = Cálculo Correto com duas casas decimais ...
  Result := CalcC(DProdutos.PRO_QUANTIDADE.Conteudo,
                  DProdutos.PRO_PRECO.Conteudo, '*', 02);
end;

function CalculaDItens_Venda_ITE_TOTAL(AOwner: TComponent) : Double;
  // variáveis locais, exemplo: I: Double;
begin
  { a variável "Result" deverá conter o resultado, exemplo:
    I := TabGlobal.DItens_Venda.ITE_TOTAL.Conteudo / 100;
    Result := I; }
  Result := CalcC(TabGlobal.DItens_Venda.ITE_QTDE.Conteudo,
                  TabGlobal.DItens_Venda.ITE_PRECO.Conteudo, '*', 02);
end;

function CalculaDItens_Venda_ITE_TOTAL_Rel(AOwner: TComponent) : Double;
var
  DItens_Venda: TDItens_Venda;
  // variáveis locais, exemplo: I: Double;
begin
  DItens_Venda := TDItens_Venda(LocalizaTabela(AOwner, 'DItens_Venda'));
  { a variável "Result" deverá conter o resultado, exemplo:
    I := DItens_Venda.ITE_TOTAL.Conteudo / 100;
    Result := I; }
  Result := CalcC(DItens_Venda.ITE_QTDE.Conteudo,
                  DItens_Venda.ITE_PRECO.Conteudo, '*', 02);
end;

function CalculaDConsulta_Itens_Venda_ITE_TOTAL(AOwner: TComponent) : Double;
  // variáveis locais, exemplo: I: Double;
begin
  { a variável "Result" deverá conter o resultado, exemplo:
    I := TabGlobal.DItens_Venda.ITE_TOTAL.Conteudo / 100;
    Result := I; }
  Result := CalcC(TabGlobal.DConsulta_Itens_Venda.ITE_QTDE.Conteudo,
                  TabGlobal.DConsulta_Itens_Venda.ITE_PRECO.Conteudo, '*', 02);
end;

function CalculaDConsulta_Itens_Venda_ITE_TOTAL_Rel(AOwner: TComponent) : Double;
var
  DConsulta_Itens_Venda: TDConsulta_Itens_Venda;
  DItens_Venda: TDItens_Venda;
  // variáveis locais, exemplo: I: Double;
begin
  DConsulta_Itens_Venda := TDConsulta_Itens_Venda(LocalizaTabela(AOwner, 'DConsulta_Itens_Venda'));
  DItens_Venda := TDItens_Venda(LocalizaTabela(AOwner, 'DItens_Venda'));
  { a variável "Result" deverá conter o resultado, exemplo:
    I := DItens_Venda.ITE_TOTAL.Conteudo / 100;
    Result := I; }
  Result := CalcC(DConsulta_Itens_Venda.ITE_QTDE.Conteudo,
                  DConsulta_Itens_Venda.ITE_PRECO.Conteudo, '*', 02);
end;

end.
