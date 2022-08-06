program Adapter;

uses
  WinTypes,
  WinProcs,
  SysUtils,
  Rotinas in 'ROTINAS.PAS',
  Publicas in 'PUBLICAS.PAS',
  Atributo in 'ATRIBUTO.PAS',
  Tabela in 'TABELA.PAS',
  Estrutur in 'ESTRUTUR.PAS',
  Forms,
  Princ_Adapter in 'Princ_Adapter.pas' {FormAdapter},
  Emp_Adapter in 'Emp_Adapter.PAS' {FormEmpresa_Adapter},
  Aguarde in 'Aguarde.PAS' {FormAguarde},
  Campo_Adapter in 'Campo_Adapter.PAS' {FormCampo_Adapter},
  BaseD in 'BaseD.PAS' {BaseDados: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormAdapter, FormAdapter);
  Application.CreateForm(TBaseDados, BaseDados);
  Application.Run;
end.
