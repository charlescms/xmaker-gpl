{
    Project: X-Maker 5 Open Source
    Licenses: Open-Souce GPL (readme-gpl-3.0.txt)
    Original author: http://www.xmaker.com.br - Alberto Henrique
}
program xMaker;

uses
  Forms,
  Princ in 'Princ.pas' {FormPrincipal},
  Rotinas in 'Rotinas.pas',
  Tabela in 'Tabela.pas',
  Atributo in 'ATRIBUTO.PAS',
  Estrutur in 'ESTRUTUR.PAS',
  CTabelas in 'CTABELAS.PAS',
  Calculos in 'CALCULOS.PAS',
  Extras in 'EXTRAS.PAS',
  DGeneric in 'DGeneric.pas' {FormDadosGenericos},
  UsrFirebird in 'UsrFirebird.pas' {FormUsrFirebird},
  ObjMenu in 'ObjMenu.pas' {FormMenuObject},
  Gera_01 in 'Gera_01.pas',
  DefModelos in 'DefModelos.pas' {FormDefModelos},
  Compila in 'Compila.pas' {FormCompilar},
  Diario in 'Diario.pas' {FormDiario},
  Splash in 'Splash.pas' {FormSplash},
  Sobre in 'Sobre.pas' {FormSobre},
  Aguarde in 'Aguarde.pas' {FormAguarde},
  CampoPre in 'CampoPre.pas' {FormCamposPredefinidos},
  Selecao in 'Selecao.pas' {FormListaEscolha},
  Relacion in 'Relacion.pas' {FormRelacionamento},
  Formular in 'Formular.pas' {FormFormularios},
  BancoD in 'BancoD.pas' {FormBancoDados},
  find in 'find.pas' {frmFind},
  PrintPas in 'printpas.pas' {FrmPrintPas},
  Replace in 'replace.pas' {FrmReplace},
  VValidos in 'VValidos.pas' {FormVlValidos},
  ChaveEst in 'ChaveEst.pas' {FormChaveEst},
  Mensagem in 'Mensagem.pas' {FormMensagem},
  Calculad in 'Calculad.pas' {FormCalculadora},
  Calend in 'Calend.pas' {FormCalendario},
  Abertura in 'Abertura.PAS' {TabGlobal_i: TTabGlobal},
  FormRel in 'FormRel.Pas' {FormRel},
  Relator in 'Relator.Pas' {FormRelatorio},
  Fr_View in 'Fr_View.Pas' {FrPreviewForm},
  Fr_Desgn in 'Fr_Desgn.Pas' {FrDesignForm},
  BaseD in 'BaseD.PAS' {BaseDados: TDataModule},
  StrEdit in 'stredit.pas' {StrEditDlg},
  ObjInsp in 'ObjInsp.pas' {FormObjInsp},
  PicEdit in 'picedit.pas' {PictureEditorDlg},
  PopupLb in 'PopupLb.Pas' {PopupListBox},
  MiniEditor in 'MiniEditor.pas' {FormMiniEditor},
  Expressao in 'Expressao.pas' {FormExpressao},
  CamposProj in 'CamposProj.pas' {FormCamposProj},
  Funcoes in 'Funcoes.pas' {FormFuncoes},
  Argumentos in 'Argumentos.pas' {FormArg},
  OpFormatacao in 'OpFormatacao.pas' {FormAutoForma},
  Estrutura_Bd in 'Estrutura_Bd.pas' {FormEstruturas},
  EdFiltro in 'EdFiltro.pas' {FormFiltro},
  ImpEstr in 'ImpEstr.pas' {FormImpEstrutura},
  Senha in 'Senha.pas',
  EdProcessos in 'EdProcessos.pas' {FormProcessos},
  EdLanctos in 'EdLanctos.pas' {FormLanctos},
  EdOrdenacao in 'EdOrdenacao.pas' {FormOrdenacao},
  ImpForm in 'ImpForm.pas' {FormImpForm},
  GrRelac in 'GrRelac.Pas' {FormGridRelac},
  LstForm in 'LstForm.pas' {FormListaForm},
  Form_Rel in 'Form_Rel.pas' {FormDialogo_Rel},
  ObjInsp_r in 'ObjInsp_r.pas' {FormObjInsp_rel},
  Relator_ant in 'Relator_ant.Pas' {FormRelatorio_ant},
  FormsProj in 'FormsProj.pas' {FormsProjeto},
  FDesigner in 'FDesigner.pas' {FormDesigner_Net},
  FrmCompile in 'FrmCompile.pas' {FormCompile},
  GeraF in 'GeraF.pas' {FormGerarFontes},
  EdModelo in 'EdModelo.pas' {FormEdModelo},
  FrmXDesigner in 'FrmXDesigner.pas' {FrmXDesig},
  FDSetup in 'FDSetup.pas' {frmFDSetup},
  env_opt in 'env_opt.pas' {frmEnvOpts},
  TabOrdem in 'TabOrdem.pas' {FormTabOrdem},
  AdoConEd in 'adoconed.pas' {ConnEditForm},
  MenuEdit_i in 'MenuEdit_i.Pas' {FormMenuEdit_i},
  TreeEdit in 'TreeEdit.Pas' {FormTreeEdit},
  EditorSQL in 'EditorSQL.pas' {FormEditorSQL},
  Estrutura_Case in 'Estrutura_Case.pas' {FormDB_Case},
  CamposSel in 'CamposSel.pas' {FormCamposSel},
  TpIns_Tabela in 'TpIns_Tabela.pas' {FormTpIns_Tabela},
  EdParametros in 'EdParametros.Pas' {FormParametros},
  EdTitulos in 'EdTitulos.Pas' {FormTitulos},
  ObjProjeto in 'ObjProjeto.pas' {FormObjProjeto},
  BetaTeste in 'BetaTeste.pas' {FormBetaTeste},
  Formularios in 'Formularios.pas' {FormForms},
  PrDelphi in 'PrDelphi.pas' {FormDelphi},
  NovoForm in 'NovoForm.pas' {FormNovoForm},
  Ajuda in 'Ajuda.pas' {FormAjuda},
  EdOpMenu in 'EdOpMenu.pas' {FormEdOpMenu},
  dbGridColunas in 'dbGridColunas.pas' {FormdbGridColunas},
  Abertura_p in 'Abertura_p.pas' {TabGlobal: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '';
  FormSplash := TFormSplash.Create(Application);
  FormSplash.Show;
  FormSplash.Update;
  Try
    Application.HelpFile := '';
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TBaseDados, BaseDados);
  Application.CreateForm(TTabGlobal_i, TabGlobal_i);
  Application.CreateForm(TTabGlobal, TabGlobal);
  finally
    FormSplash.BringToFront;
    FormSplash.FormStyle:=fsStayOnTop;
  end;
  Application.Run;
end.
