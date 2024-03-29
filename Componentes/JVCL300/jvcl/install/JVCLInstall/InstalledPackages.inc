{ included in JVCLData.inc (at the bottom) }
// $Id: InstalledPackages.inc,v 1.9 2005/01/30 14:36:17 jfudickar Exp $

function GetSystemDir: string;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, GetSystemDirectory(PChar(Result), Length(Result)));
end;

{------------------------------------------------------------------------------}
{ QuickReport }
function Opt_QuickReport4(Target: TCompileTarget): Boolean;
begin
  Result := FileExists(Target.RootDir + Format('\bin\qr4run%s%d.bpl', [LowerCase(TargetTypes[Target.IsBCB]), Target.Version]));
end;

function Opt_QuickReport(Target: TCompileTarget): Boolean;
begin
  Result := FileExists(Target.RootDir + Target.VersionedDCP('\lib\qrpt.dcp')) or
            FileExists(Target.RootDir + Target.VersionedDCP('\lib\obj\qrpt.dcp')) or
            Opt_QuickReport4(Target);
end;

{------------------------------------------------------------------------------}
{ Internet Components }
function Opt_InternetComponents(Target: TCompileTarget): Boolean;
begin
  Result := (FileExists(Target.RootDir + Target.VersionedDCP('\lib\vclie.dcp')) and
             FileExists(Target.RootDir + Target.VersionedDCP('\lib\inet.dcp')))
            or
            (FileExists(Target.RootDir + Target.VersionedDCP('\lib\obj\vclie.dcp')) and
             FileExists(Target.RootDir + Target.VersionedDCP('\lib\obj\inet.dcp')));
end;

{------------------------------------------------------------------------------}
{ SMExport Components }
function Opt_SMExportComponents(Target: TCompileTarget): Boolean;
begin
  if Target.Version = 9 then
    Result := FileExists(Target.BDSProjectsDir + '\bpl\SMExportd2005.dcp')
  else
    Result := FileExists(Target.RootDir + Format('\Projects\bpl\SMExport%s%d.dcp',[LowerCase(TargetTypes[Target.IsBCB]), Target.Version]));
end;

{------------------------------------------------------------------------------}
{ SMImport Components }
function Opt_SMImportComponents(Target: TCompileTarget): Boolean;
begin
  if Target.Version = 9 then
    Result := FileExists(Target.BDSProjectsDir + '\bpl\SMImportd2005.dcp')
  else
    Result := FileExists(Target.RootDir + Format('\Projects\bpl\SMImport%s%d.dcp',[LowerCase(TargetTypes[Target.IsBCB]), Target.Version]));
end;

{------------------------------------------------------------------------------}
{ Indy Components }
function Opt_IndyComponents(Target: TCompileTarget): Boolean;
begin
  Result := FileExists(Target.RootDir + Target.VersionedDCP('\lib\indy.dcp'));
end;

{------------------------------------------------------------------------------}
{ ICS Components }
function Opt_ICSComponents(Target: TCompileTarget): Boolean;
begin
  if Target.IsBCB then
    Result := False
  else
    if Target.Version = 9 then 
      Result := FileExists(Target.BDSProjectsDir + Format('\bpl\IcsDel%d%d.dcp', [Target.Version,0]))
    else
      Result := FileExists(Target.RootDir + Format('\Projects\bpl\IcsDel%d%d.dcp', [Target.Version,0]));//Target.VersionedDCP('\Projects\bpl\IcsDel.dcp'));  
end;

{------------------------------------------------------------------------------}
{ DevExpress CX-Editors }
function Opt_CXEditorComponents(Target: TCompileTarget): Boolean;
begin
  if Target.Version = 9 then 
    Result := FileExists(GetSystemDir+(Format('\cxEditors%s%d.bpl',[LowerCase(TargetTypes[Target.IsBCB]), Target.Version])))
  else
    Result := FileExists(GetSystemDir+(Format('\cxEditorsVCL%s%d.bpl',[LowerCase(TargetTypes[Target.IsBCB]), Target.Version])));  
end;

{------------------------------------------------------------------------------}
{ DevExpress CX-Grid }
function Opt_CXGridComponents(Target: TCompileTarget): Boolean;
begin
  if Target.Version = 9 then 
    Result := FileExists(GetSystemDir+(Format('\cxGrid%s%d.bpl',[LowerCase(TargetTypes[Target.IsBCB]), Target.Version])))
  else
    Result := FileExists(GetSystemDir+(Format('\cxGridVCL%s%d.bpl',[LowerCase(TargetTypes[Target.IsBCB]), Target.Version])));  
end;


{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

procedure TTargetConfig.UpdateOptions;
begin
  // quickreport configuration
  EnableOption('QREPORT4', Opt_QuickReport4(Target));
  EnableOption('JVCL_UseQuickReport', Opt_QuickReport(Target));

  // internet components
  EnableOption('INTERNET_COMPONENTS', Opt_InternetComponents(Target));
  
  EnableOption('USE_3RDPARTY_INDY', Opt_IndyComponents(Target));
  EnableOption('USE_3RDPARTY_ICS', Opt_ICSComponents(Target));

  EnableOption('USE_3RDPARTY_SMIMPORT', Opt_SMImportComponents(Target));
  EnableOption('USE_3RDPARTY_SMEXPORT', Opt_SMExportComponents(Target));

  EnableOption('USE_3RDPARTY_DEVEXPRESS_CXEDITOR', Opt_CXEditorComponents(Target));
  EnableOption('USE_3RDPARTY_DEVEXPRESS_CXGRID', Opt_CXGridComponents(Target));

end;

