{
 Conecta tabelas do sistema
}
unit CTabelas;

interface

uses
  Forms,
  DPROJETO,
  DFORMULARIO,
  DMENU,
  DBDADOS,
  DTABELAS,
  DCAMPOST,
  DINDICEST,
  DCALCULADOS,
  DCASCATAT,
  DRESTRITAT,
  DRELATORIO,
  Classes;

procedure ConectaTabelas(Lista: TList);

var
  ADPROJETO: TDPROJETO;
  ADFORMULARIO: TDFORMULARIO;
  ADMENU: TDMENU;
  ADBDADOS: TDBDADOS;
  ADTABELAS: TDTABELAS;
  ADCAMPOST: TDCAMPOST;
  ADINDICEST: TDINDICEST;
  ADCALCULADOS: TDCALCULADOS;
  ADCASCATAT: TDCASCATAT;
  ADRESTRITAT: TDRESTRITAT;
  ADRELATORIO: TDRELATORIO;

implementation

procedure ConectaTabelas(Lista: TList);
begin
  ADPROJETO := TDPROJETO.Create(Application);
  ADFORMULARIO := TDFORMULARIO.Create(Application);
  ADMENU := TDMENU.Create(Application);
  ADBDADOS := TDBDADOS.Create(Application);
  ADTABELAS := TDTABELAS.Create(Application);
  ADCAMPOST := TDCAMPOST.Create(Application);
  ADINDICEST := TDINDICEST.Create(Application);
  ADCALCULADOS := TDCALCULADOS.Create(Application);
  ADCASCATAT := TDCASCATAT.Create(Application);
  ADRESTRITAT := TDRESTRITAT.Create(Application);
  ADRELATORIO := TDRELATORIO.Create(Application);

  Lista.Add(ADPROJETO);
  Lista.Add(ADFORMULARIO);
  Lista.Add(ADMENU);
  Lista.Add(ADBDADOS);
  Lista.Add(ADTABELAS);
  Lista.Add(ADCAMPOST);
  Lista.Add(ADINDICEST);
  Lista.Add(ADCALCULADOS);
  Lista.Add(ADCASCATAT);
  Lista.Add(ADRESTRITAT);
  Lista.Add(ADRELATORIO);
end;

end.
