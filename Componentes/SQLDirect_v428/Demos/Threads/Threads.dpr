program Threads;

uses
  Forms,
  Main in 'Main.pas' {MainFrm},
  InsThrd in 'InsThrd.pas',
  Login in 'Login.pas' {LoginDlg},
  DataMod in 'DataMod.pas' {dmMain: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
