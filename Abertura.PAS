{
 Abri todas as tabelas
}
unit Abertura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IBQuery, IBDatabase, Db, IBCustomDataSet,
  {$I LTab.pas}
  Tabela, Calculos;

type
  TTabGlobal_i = class(TDataModule)
  private
    { Private declarations }
    procedure CamposCalculados;
  public
    { Public declarations }
    {01-Início do Bloco Modular. Modificações não serão preservadas}
    DPROJETO : TDPROJETO;
    DFORMULARIO : TDFORMULARIO;
    DMENU : TDMENU;
    DBDADOS : TDBDADOS;
    DTABELAS : TDTABELAS;
    DCAMPOST : TDCAMPOST;
    DINDICEST : TDINDICEST;
    DCALCULADOS : TDCALCULADOS;
    DCASCATAT : TDCASCATAT;
    DRESTRITAT : TDRESTRITAT;
    DRELATORIO : TDRELATORIO;
    DRELACIONA : TDRELACIONA;
    DPROCESSOS : TDPROCESSOS;
    DMENUSUP : TDMENUSUP;
    DBARRA: TDBARRA;
    DCONSULTA: TDCONSULTA;
    DTRIGGER: TDTRIGGER;
    DPROC_EXTERNA: TDPROC_EXTERNA;
    DSQL_SCRIPT: TDSQL_SCRIPT;
    DDIAGRAMA: TDDIAGRAMA;
    procedure AbrirTabelas;
    procedure FecharTabelas;
    {99-Final do Bloco Modular. Modificações não serão preservadas}
  end;

var
  TabGlobal_i: TTabGlobal_i;

implementation

{$R *.DFM}

uses Aguarde, BaseD;

procedure TTabGlobal_i.AbrirTabelas;
var
  I: Integer;
  Tabela: TTabela;
  Criou: Boolean;
begin
  FormAguarde := TFormAguarde.Create(Application);
  FormAguarde.Caption := 'Aguarde! Abrindo Projeto...';
  FormAguarde.Show;
  {02-Início do Bloco Modular. Modificações não serão preservadas}
  DPROJETO := TDPROJETO.Create(Self);
  DFORMULARIO := TDFORMULARIO.Create(Self);
  DMENU := TDMENU.Create(Self);
  DBDADOS := TDBDADOS.Create(Self);
  DTABELAS := TDTABELAS.Create(Self);
  DCAMPOST := TDCAMPOST.Create(Self);
  DINDICEST := TDINDICEST.Create(Self);
  DCALCULADOS := TDCALCULADOS.Create(Self);
  DCASCATAT := TDCASCATAT.Create(Self);
  DRESTRITAT := TDRESTRITAT.Create(Self);
  DRELATORIO := TDRELATORIO.Create(Self);
  DRELACIONA := TDRELACIONA.Create(Self);
  DPROCESSOS := TDPROCESSOS.Create(Self);
  DMENUSUP := TDMENUSUP.Create(Self);
  DBARRA := TDBARRA.Create(Self);
  DCONSULTA := TDCONSULTA.Create(Self);
  DTRIGGER := TDTRIGGER.Create(Self);
  DPROC_EXTERNA := TDPROC_EXTERNA.Create(Self);
  DSQL_SCRIPT := TDSQL_SCRIPT.Create(Self);
  DDIAGRAMA := TDDIAGRAMA.Create(Self);
  FormAguarde.GaugeProcesso.Min := 0;
  FormAguarde.GaugeProcesso.Max := 10;
  {99-Final do Bloco Modular. Modificações não serão preservadas}
  CamposCalculados;
  Criou := False;
  FormAguarde.GaugeProcesso.Position := 0;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    Application.ProcessMessages;
    if (Tabela.Owner = Self) and (not Tabela.Existe) then
    begin
      Tabela.CriaTabela;
      Criou := True;
    end;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  end;
  if Criou then
  begin
    BaseDados.BD_Base_Projeto.Close;
    BaseDados.BD_Base_Dicionario.Close;

    BaseDados.BD_Base_Projeto.Open;
    BaseDados.TRS_BD_Base_Projeto.StartTransaction;
    BaseDados.BD_Base_Dicionario.Open;
    BaseDados.TRS_BD_Base_Dicionario.StartTransaction;
  end;

  FormAguarde.GaugeProcesso.Position := 0;
  for I := 0 to Lst_Tabelas.Count - 1 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    Application.ProcessMessages;
    if (Tabela.Owner = Self) and (Tabela.Existe) then
      Tabela.Abrir;
    FormAguarde.GaugeProcesso.Position := FormAguarde.GaugeProcesso.Position + 1;
  end;
  FormAguarde.Free;
end;

procedure TTabGlobal_i.FecharTabelas;
var
  I: Integer;
  Tabela: TTabela;
begin
  for I := (Lst_Tabelas.Count - 1) downto 0 do
  begin
    Tabela := TTabela(Lst_Tabelas[I]);
    if Tabela.Owner = Self then
    begin
      if Tabela.Active then
        Tabela.Close;
      Tabela.Free;
      //Lst_Tabelas.Delete(I);
    end;
  end;
  if Lst_Tabelas.Count = 0 then
  begin
    Lst_Tabelas.Free;
    Lst_Tabelas := nil;
  end;
end;

procedure TTabGlobal_i.CamposCalculados;
begin

end;

end.
