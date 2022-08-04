program QueryUpd;

uses
  Forms,
  QryTest in 'QryTest.pas' {QueryTestFrm},
  Main in 'Main.pas' {MainFrm},
  UpdTest in 'UpdTest.pas' {UpdateTestFrm},
  DataMod in 'DataMod.pas' {dmData: TDataModule},
  Login in 'Login.pas' {LoginDlg};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
