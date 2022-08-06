{
 Empresa....: Modular Software
 Programa...: Vendas.Dpr - Gerenciador dos Módulos do Projeto
 Sistema....: 
 Data.......: 22/5/2008
 Versão.....: 1.1
 Analista...: Alberto Henrique
 Programador: 
 Criação....: xMaker 5.0 Release: R03
 NºLicença..: Versão Trial-
}

program Vendas;

uses
  {$I LTab.Inc}
  {$I AtrL.Inc}
  WinTypes,
  WinProcs,
  SysUtils,
  Rotinas in 'ROTINAS.PAS',
  RotinaEd in 'ROTINAED.PAS',
  Extras in 'EXTRAS.PAS',
  Interno in 'INTERNO.PAS',
  Validar in 'VALIDAR.PAS',
  Publicas in 'PUBLICAS.PAS',
  Atributo in 'ATRIBUTO.PAS',
  Tabela in 'TABELA.PAS',
  Estrutur in 'ESTRUTUR.PAS',
  Calculos in 'CALCULOS.PAS',
  Forms,
  Splash in 'Splash.PAS' {FormSplash},
  Calend in 'Calend.PAS' {FormCalendario},
  Calculad in 'Calculad.PAS' {FormCalculadora},
  Acesso in 'Acesso.PAS' {FormAcesso},
  Senhas in 'Senhas.PAS' {FormSenhas},
  Sobre in 'Sobre.PAS' {FormSobre},
  Princ in 'Princ.PAS' {FormPrincipal},
  CfgEmp in 'CfgEmp.PAS' {FormConfiguraEmpresa},
  SelEmp in 'SelEmp.PAS' {FormSelecionaEmpresa},
  BatePapo in 'BatePapo.PAS' {FormBatePapo},
  Agenda in 'Agenda.PAS' {FormAgenda},
  AgEdit in 'AgEdit.PAS' {FormAgEdit},
  EdUsr in 'EdUsr.PAS' {FormEdUsr},
  EdGrp in 'EdGrp.PAS' {FormEdGrp},
  Ambiente in 'Ambiente.PAS' {FormAmbiente},
  Backup in 'Backup.PAS' {FormBackup},
  Restaura in 'Restaura.PAS' {FormRestaura},
  Filtro in 'Filtro.PAS' {FormFiltragem},
  GridPesquisa in 'GridPesquisa.PAS' {FormGridPesquisa},
  LogOperacoes in 'LogOperacoes.PAS' {FormLogOperacoes},
  LogProcura in 'LogProcura.PAS' {FormLogProcura},
  Aguarde in 'Aguarde.PAS' {FormAguarde},
  Fr_View in 'Fr_View.PAS' {frPreviewForm},
  OpcRel in 'OpcRel.PAS' {FormOpcRel},
  Clientes in 'Clientes.PAS' {FormClientes},
  Atividades in 'Atividades.PAS' {FormAtividades},
  Fornecedores in 'Fornecedores.PAS' {FormFornecedores},
  Produtos in 'Produtos.PAS' {FormProdutos},
  LVendas in 'LVendas.PAS' {FormLVendas},
  Consulta_Itens in 'Consulta_Itens.PAS' {FormConsulta_Itens},
  Rel_0001 in 'Rel_0001.PAS' {FormRel_0001},
  Rel_0002 in 'Rel_0002.PAS' {FormRel_0002},
  Rel_0003 in 'Rel_0003.PAS' {FormRel_0003},
  Gra_0001 in 'Gra_0001.PAS' {FormGra_0001},
  Eti_0001 in 'Eti_0001.PAS' {FormEti_0001},
  Rel_0004 in 'Rel_0004.PAS' {FormRel_0004},
  Abertura in 'Abertura.PAS' {TabGlobal: TTabGlobal},
  BaseD in 'BaseD.PAS' {BaseDados: TDataModule};


begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TBaseDados, BaseDados);
  Application.CreateForm(TTabGlobal, TabGlobal);
  Application.Run;
end.
