{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is DelphiInstall.pas.                                                          }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) of Petr Vones. All Rights Reserved.                                                }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Andreas Hausladen (ahuser)                                                                     }
{   Robert Rossmair (rrossmair) - crossplatform & BCB support                                      }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Routines for getting information about installed versions of Delphi/C++Builder and performing    }
{ basic installation tasks.                                                                        }
{                                                                                                  }
{ Unit owner: Petr Vones                                                                           }
{                                                                                                  }
{**************************************************************************************************}

// Last modified: $Date: 2005/03/22 03:36:09 $

unit JclBorlandTools;

{$I jcl.inc}
{$I crossplatform.inc}

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF MSWINDOWS}
  Classes, SysUtils, IniFiles, Contnrs,
  JclBase, JclSysUtils;

// Various definitions
type
  TJclBorRADToolKind = (brDelphi, brCppBuilder); //, brBorlandDevStudio);
  {$IFDEF KYLIX}
  TJclBorRADToolEdition = (deOPEN, dePRO, deSVR);
  {$ELSE}
  TJclBorRADToolEdition = (deSTD, dePRO, deCSS, deARC);
  {$ENDIF KYLIX}
  TJclBorRADToolPath = string;

const
  SupportedDelphiVersions       = [5, 6, 7, 9];
  SupportedBCBVersions          = [5, 6];

  // Object Repository
  BorRADToolRepositoryPagesSection    = 'Repository Pages';

  BorRADToolRepositoryDialogsPage     = 'Dialogs';
  BorRADToolRepositoryFormsPage       = 'Forms';
  BorRADToolRepositoryProjectsPage    = 'Projects';
  BorRADToolRepositoryDataModulesPage = 'Data Modules';

  BorRADToolRepositoryObjectType      = 'Type';
  BorRADToolRepositoryFormTemplate    = 'FormTemplate';
  BorRADToolRepositoryProjectTemplate = 'ProjectTemplate';
  BorRADToolRepositoryObjectName      = 'Name';
  BorRADToolRepositoryObjectPage      = 'Page';
  BorRADToolRepositoryObjectIcon      = 'Icon';
  BorRADToolRepositoryObjectDescr     = 'Description';
  BorRADToolRepositoryObjectAuthor    = 'Author';
  BorRADToolRepositoryObjectAncestor  = 'Ancestor';
  BorRADToolRepositoryObjectDesigner  = 'Designer'; // Delphi 6+ only
  BorRADToolRepositoryDesignerDfm     = 'dfm';
  BorRADToolRepositoryDesignerXfm     = 'xfm';
  BorRADToolRepositoryObjectNewForm   = 'DefaultNewForm';
  BorRADToolRepositoryObjectMainForm  = 'DefaultMainForm';

  {$IFDEF KYLIX}
  BorRADToolEditionIDs: array [TJclBorRADToolEdition] of PChar =
    ('OPEN', 'PRO', 'SVR');
  {$ELSE ~KYLIX}
  BorRADToolEditionIDs: array [TJclBorRADToolEdition] of PChar =
    ('STD', 'PRO', 'CSS', 'ARC'); // 'ARC' is an assumption
  {$ENDIF ~KYLIX}

// Installed versions information classes
type
  TJclBorRADToolInstallation = class;

  TJclBorRADToolInstallationObject = class(TInterfacedObject)
  private
    FInstallation: TJclBorRADToolInstallation;
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation);
  public
    property Installation: TJclBorRADToolInstallation read FInstallation;
  end;

  {$IFDEF MSWINDOWS}
  TJclBorlandOpenHelp = class(TJclBorRADToolInstallationObject)
  private
    function GetContentFileName: string;
    function GetIndexFileName: string;
    function GetLinkFileName: string;
    function GetGidFileName: string;
    function GetProjectFileName: string;
    function ReadFileName(const FormatName: string): string;
  public
    function AddHelpFile(const HelpFileName, IndexName: string): Boolean;
    function RemoveHelpFile(const HelpFileName, IndexName: string): Boolean;
    property ContentFileName: string read GetContentFileName;
    property GidFileName: string read GetGidFileName;
    property IndexFileName: string read GetIndexFileName;
    property LinkFileName: string read GetLinkFileName;
    property ProjectFileName: string read GetProjectFileName;
  end;
  {$ENDIF MSWINDOWS}

  TJclBorRADToolIdeTool = class(TJclBorRADToolInstallationObject)
  private
    FKey: string;
    function GetCount: Integer;
    function GetParameters(Index: Integer): string;
    function GetPath(Index: Integer): string;
    function GetTitle(Index: Integer): string;
    function GetWorkingDir(Index: Integer): string;
    procedure SetCount(const Value: Integer);
    procedure SetParameters(Index: Integer; const Value: string);
    procedure SetPath(Index: Integer; const Value: string);
    procedure SetTitle(Index: Integer; const Value: string);
    procedure SetWorkingDir(Index: Integer; const Value: string);
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation);
    procedure CheckIndex(Index: Integer);
  public
    property Count: Integer read GetCount write SetCount;
    function IndexOfPath(const Value: string): Integer;
    function IndexOfTitle(const Value: string): Integer;
    property Key: string read FKey;
    property Title[Index: Integer]: string read GetTitle write SetTitle;
    property Path[Index: Integer]: string read GetPath write SetPath;
    property Parameters[Index: Integer]: string read GetParameters write SetParameters;
    property WorkingDir[Index: Integer]: string read GetWorkingDir write SetWorkingDir;
  end;

  TJclBorRADToolIdePackages = class(TJclBorRADToolInstallationObject)
  private
    FDisabledPackages: TStringList;
    FKnownPackages: TStringList;
    function GetCount: Integer;
    function GetPackageDescriptions(Index: Integer): string;
    function GetPackageDisabled(Index: Integer): Boolean;
    function GetPackageFileNames(Index: Integer): string;
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation);
    function PackageEntryToFileName(const Entry: string): string;
    procedure ReadPackages;
    procedure RemoveDisabled(const FileName: string);
  public
    destructor Destroy; override;
    function AddPackage(const FileName, Description: string): Boolean;
    function RemovePackage(const FileName: string): Boolean;
    property Count: Integer read GetCount;
    property PackageDescriptions[Index: Integer]: string read GetPackageDescriptions;
    property PackageFileNames[Index: Integer]: string read GetPackageFileNames;
    property PackageDisabled[Index: Integer]: Boolean read GetPackageDisabled;
  end;

  IJclCommandLineTool = interface
    ['{A0034B09-A074-D811-847D-0030849E4592}']
    function GetExeName: string;
    function GetOptions: TStrings;
    function GetOutput: string;
    function GetOutputCallback: TTextHandler;
    procedure AddPathOption(const Option, Path: string);
    function Execute(const CommandLine: string): Boolean;
    procedure SetOutputCallback(const CallbackMethod: TTextHandler);
    property ExeName: string read GetExeName;
    property Options: TStrings read GetOptions;
    property OutputCallback: TTextHandler write SetOutputCallback;
    property Output: string read GetOutput;
  end;

  EJclCommandLineToolError = class(EJclError);

  TJclCommandLineTool = class(TInterfacedObject, IJclCommandLineTool)
  private
    FExeName: string;
    FOptions: TStringList;
    FOutput: string;
    FOutputCallback: TTextHandler;
  protected
    function GetExeName: string;
    function GetOutput: string;
    function GetOptions: TStrings;
    function GetOutputCallback: TTextHandler;
    procedure SetOutputCallback(const CallbackMethod: TTextHandler);
    constructor Create(const AExeName: string);
    procedure AddPathOption(const Option, Path: string);
    function Execute(const CommandLine: string): Boolean;
    property ExeName: string read GetExeName;
    property Output: string read GetOutput;
  public
    destructor Destroy; override;
  end;

  TJclBorlandCommandLineTool = class(TJclBorRADToolInstallationObject, IJclCommandLineTool)
  private
    FOptions: TStringList;
    FOutputCallback: TTextHandler;
    FOutput: string;
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation); virtual;
    procedure CheckOutputValid;
    function GetExeName: string; virtual;
    function GetFileName: string;
    function GetOptions: TStrings;
    function GetOutputCallback: TTextHandler;
    procedure SetOutputCallback(const CallbackMethod: TTextHandler);
    function GetOutput: string;
  public
    destructor Destroy; override;
    procedure AddPathOption(const Option, Path: string);
    function Execute(const CommandLine: string): Boolean; virtual;
    property FileName: string read GetFileName;
    property Output: string read GetOutput;
    property OutputCallback: TTextHandler read FOutputCallback write SetOutputCallback;
    property Options: TStrings read GetOptions;
  end;

  TJclDCC = class(TJclBorlandCommandLineTool)
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation); override;
    function GetExeName: string; override;
    procedure SaveOptionsToFile(const ConfigFileName: string);
  public
    function Execute(const CommandLine: string): Boolean; override;
    function MakePackage(const PackageName, BPLPath, DCPPath: string): Boolean;
    procedure SetDefaultOptions;
    function SupportsLibSuffix: Boolean;
  end;

  TJclBpr2Mak = class(TJclBorlandCommandLineTool)
  protected
    function GetExeName: string; override;
  end;

  TJclBorlandMake = class(TJclBorlandCommandLineTool)
  protected
    function GetExeName: string; override;
  end;

  TJclBorRADToolPalette = class(TJclBorRADToolInstallationObject)
  private
    FKey: string;
    FTabNames: TStringList;
    function GetComponentsOnTab(Index: Integer): string;
    function GetHiddenComponentsOnTab(Index: Integer): string;
    function GetTabNameCount: Integer;
    function GetTabNames(Index: Integer): string;
    procedure ReadTabNames;
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation);
  public
    destructor Destroy; override;
    procedure ComponentsOnTabToStrings(Index: Integer; Strings: TStrings; IncludeUnitName: Boolean = False;
      IncludeHiddenComponents: Boolean = True);
    function DeleteTabName(const TabName: string): Boolean;
    function TabNameExists(const TabName: string): Boolean;
    property ComponentsOnTab[Index: Integer]: string read GetComponentsOnTab;
    property HiddenComponentsOnTab[Index: Integer]: string read GetHiddenComponentsOnTab;
    property Key: string read FKey;
    property TabNames[Index: Integer]: string read GetTabNames;
    property TabNameCount: Integer read GetTabNameCount;
  end;

  TJclBorRADToolRepository = class(TJclBorRADToolInstallationObject)
  private
    FIniFile: TIniFile;
    FFileName: string;
    FPages: TStringList;
    function GetIniFile: TIniFile;
    function GetPages: TStrings;
  protected
    constructor Create(AInstallation: TJclBorRADToolInstallation);
  public
    destructor Destroy; override;
    procedure AddObject(const FileName, ObjectType, PageName, ObjectName, IconFileName, Description,
      Author, Designer: string; const Ancestor: string = '');
    procedure CloseIniFile;
    function FindPage(const Name: string; OptionalIndex: Integer): string;
    procedure RemoveObjects(const PartialPath, FileName, ObjectType: string);
    property FileName: string read FFileName;
    property IniFile: TIniFile read GetIniFile;
    property Pages: TStrings read GetPages;
  end;

  TJclBorRADToolInstallationClass = class of TJclBorRADToolInstallation;

  TJclBorRADToolInstallation = class(TObject)
  private
    FConfigData: TCustomIniFile;
    FGlobals: TStringList;
    FRootDir: string;
    FBinFolderName: string;
    FDCC: TJclDCC;
    FMake: IJclCommandLineTool;
    FEditionStr: string;
    FEdition: TJclBorRADToolEdition;
    FEnvironmentVariables: TStringList;
    FIdePackages: TJclBorRADToolIdePackages;
    FIdeTools: TJclBorRADToolIdeTool;
    FInstalledUpdatePack: Integer;
    {$IFDEF MSWINDOWS}
    FOpenHelp: TJclBorlandOpenHelp;
    {$ENDIF MSWINDOWS}
    FPalette: TJclBorRADToolPalette;
    FRepository: TJclBorRADToolRepository;
    FVersionNumber: Integer;
    FVersionNumberStr: string;
    FIDEVersionNumber: Integer; // Delphi 2005: 3   -  Delphi 7: 7
    function GetBPLOutputPath: string;
    function GetDCC: TJclDCC;
    function GetDCPOutputPath: string;
    function GetDebugDCUPath: string;
    function GetDefaultProjectsDir: string;
    function GetDescription: string;
    function GetEditionAsText: string;
    function GetEnvironmentVariables: TStrings;
    function GetIdeExeFileName: string;
    function GetGlobals: TStrings;
    function GetIdeExeBuildNumber: string;
    function GetIdePackages: TJclBorRADToolIdePackages;
    function GetLatestUpdatePack: Integer;
    function GetLibrarySearchPath: TJclBorRADToolPath;
    function GetName: string;
    function GetPalette: TJclBorRADToolPalette;
    function GetRepository: TJclBorRADToolRepository;
    function GetUpdateNeeded: Boolean;
    function GetValid: Boolean;
    procedure SetLibrarySearchPath(const Value: TJclBorRADToolPath);
    function GetLibraryBrowsingPath: TJclBorRADToolPath;
    procedure SetLibraryBrowsingPath(const Value: TJclBorRADToolPath);
    procedure SetDebugDCUPath(const Value: string);
  protected
    constructor Create(const AConfigDataLocation: string); virtual;
    {$IFDEF MSWINDOWS}
    function GetBorlandStudioProjectsDir: string;
    {$ENDIF MSWINDOWS}
    procedure ReadInformation;
    function AddMissingPathItems(var Path: string; const NewPath: string): Boolean;
    function RemoveFromPath(var Path: string; const ItemsToRemove: string): Boolean;
  public
    destructor Destroy; override;
    class procedure ExtractPaths(const Path: TJclBorRADToolPath; List: TStrings);
    class function GetLatestUpdatePackForVersion(Version: Integer): Integer; virtual;
    class function PackageSourceFileExtension: string; virtual;
    class function RadToolKind: TJclBorRadToolKind; virtual;
    class function RadToolName: string; virtual;
    function AnyInstanceRunning: Boolean;
    function AddToDebugDCUPath(const Path: string): Boolean;
    function AddToLibrarySearchPath(const Path: string): Boolean;
    function AddToLibraryBrowsingPath(const Path: string): Boolean;
    {$IFDEF KYLIX}
    function ConfigFileName(const Extension: string): string; virtual;
    {$ENDIF KYLIX}
    function FindFolderInPath(Folder: string; List: TStrings): Integer;
    function InstallPackage(const PackageName, BPLPath, DCPPath: string): Boolean; virtual;
    function IsBDSPersonality: Boolean;
    function LibFolderName: string;
    function RemoveFromDebugDCUPath(const Path: string): Boolean;
    function RemoveFromLibrarySearchPath(const Path: string): Boolean;
    function RemoveFromLibraryBrowsingPath(const Path: string): Boolean;
    function SubstitutePath(const Path: string): string;
    function SupportsVisualCLX: Boolean;
    function UninstallPackage(const PackageName, BPLPath, DCPPath: string): Boolean;
    property BinFolderName: string read FBinFolderName;
    property BPLOutputPath: string read GetBPLOutputPath;
    property DCC: TJclDCC read GetDCC;
    property DebugDCUPath: string read GetDebugDCUPath write SetDebugDCUPath;
    property DCPOutputPath: string read GetDCPOutputPath;
    property DefaultProjectsDir: string read GetDefaultProjectsDir;
    property Description: string read GetDescription;
    property Edition: TJclBorRADToolEdition read FEdition;
    property EditionAsText: string read GetEditionAsText;
    property EnvironmentVariables: TStrings read GetEnvironmentVariables;
    property IdePackages: TJclBorRADToolIdePackages read GetIdePackages;
    property IdeTools: TJclBorRADToolIdeTool read FIdeTools;
    property IdeExeBuildNumber: string read GetIdeExeBuildNumber;
    property IdeExeFileName: string read GetIdeExeFileName;
    property InstalledUpdatePack: Integer read FInstalledUpdatePack;
    property LatestUpdatePack: Integer read GetLatestUpdatePack;
    property LibrarySearchPath: TJclBorRADToolPath read GetLibrarySearchPath write SetLibrarySearchPath;
    property LibraryBrowsingPath: TJclBorRADToolPath read GetLibraryBrowsingPath write SetLibraryBrowsingPath;
    {$IFDEF MSWINDOWS}
    property OpenHelp: TJclBorlandOpenHelp read FOpenHelp;
    {$ENDIF MSWINDOWS}
    property ConfigData: TCustomIniFile read FConfigData;
    property Globals: TStrings read GetGlobals;
    property Make: IJclCommandLineTool read FMake;
    property Name: string read GetName;
    property Palette: TJclBorRADToolPalette read GetPalette;
    property Repository: TJclBorRADToolRepository read GetRepository;
    property RootDir: string read FRootDir;
    property UpdateNeeded: Boolean read GetUpdateNeeded;
    property Valid: Boolean read GetValid;
    property IDEVersionNumber: Integer read FIDEVersionNumber;
    property VersionNumber: Integer read FVersionNumber;
    property VersionNumberStr: string read FVersionNumberStr;
  end;

  TJclBCBInstallation = class(TJclBorRADToolInstallation)
  private
    FBpr2Mak: TJclBpr2Mak;
  protected
    constructor Create(const AConfigDataLocation: string); override;
    function GetVclIncludeDir: string;
  public
    destructor Destroy; override;
    class function PackageSourceFileExtension: string; override;
    class function RadToolName: string; override;
    class function GetLatestUpdatePackForVersion(Version: Integer): Integer; override;
    {$IFDEF KYLIX}
    function ConfigFileName(const Extension: string): string; override;
    {$ENDIF KYLIX}
    function InstallPackage(const PackageName, BPLPath, DCPPath: string): Boolean; override;
    property Bpr2Mak: TJclBpr2Mak read FBpr2Mak;
    property VclIncludeDir: string read GetVclIncludeDir;
  end;

  TJclDelphiInstallation = class(TJclBorRADToolInstallation)
  public
    class function GetLatestUpdatePackForVersion(Version: Integer): Integer; override;
    class function PackageSourceFileExtension: string; override;
    class function RadToolName: string; override;
    {$IFDEF KYLIX}
    function ConfigFileName(const Extension: string): string; override;
    {$ENDIF KYLIX}
  end;

  TTraverseMethod = function (Installation: TJclBorRADToolInstallation): Boolean of object;

  TJclBorRADToolInstallations = class(TObject)
  private
    FList: TObjectList;
    function GetCount: Integer;
    function GetInstallations(Index: Integer): TJclBorRADToolInstallation;
    function GetBCBVersionInstalled(VersionNumber: Integer): Boolean;
    function GetDelphiVersionInstalled(VersionNumber: Integer): Boolean;
    function GetBCBInstallationFromVersion(VersionNumber: Integer): TJclBorRADToolInstallation;
    function GetDelphiInstallationFromVersion(VersionNumber: Integer): TJclBorRADToolInstallation;
  protected
    procedure ReadInstallations;
  public
    constructor Create;
    destructor Destroy; override;
    function AnyInstanceRunning: Boolean;
    function AnyUpdatePackNeeded(var Text: string): Boolean;
    function Iterate(TraverseMethod: TTraverseMethod): Boolean;
    property Count: Integer read GetCount;
    property Installations[Index: Integer]: TJclBorRADToolInstallation read GetInstallations; default;
    property BCBInstallationFromVersion[VersionNumber: Integer]: TJclBorRADToolInstallation read GetBCBInstallationFromVersion;
    property DelphiInstallationFromVersion[VersionNumber: Integer]: TJclBorRADToolInstallation read GetDelphiInstallationFromVersion;
    property BCBVersionInstalled[VersionNumber: Integer]: Boolean read GetBCBVersionInstalled;
    property DelphiVersionInstalled[VersionNumber: Integer]: Boolean read GetDelphiVersionInstalled;
  end;

function BPLFileName(const BPLPath, DPKFileName: string): string;
function IsDelphiPackage(const FileName: string): Boolean;

implementation

uses
  SysConst,
  {$IFDEF MSWINDOWS}
  Registry,
  JclRegistry,
  {$ENDIF MSWINDOWS}
  {$IFDEF HAS_UNIT_LIBC}
  Libc,
  {$ENDIF HAS_UNIT_LIBC}
  JclFileUtils, JclLogic, JclResources, JclStrings, JclSysInfo;

// Internal

type
  TUpdatePack = record
    Version: Byte;
    LatestUpdatePack: Integer;
  end;
  {$IFDEF KYLIX}
  TKylixVersion = 1..3;
  {$ENDIF KYLIX}

  {$IFDEF MSWINDOWS}
  TBDSVersionInfo = record
    Name: string;
    VersionStr: string;
    Version: Integer;
    CoreIdeVersion: string;
    ProjectsDirResId: Integer;
    Supported: Boolean;
  end;
  {$ENDIF MSWINDOWS}

const
  {$IFDEF MSWINDOWS}
  {$IFNDEF RTL140_UP}
  PathSep = ';';
  {$ENDIF ~RTL140_UP}

  MSHelpSystemKeyName = 'SOFTWARE\Microsoft\Windows\Help';

  BCBKeyName          = 'SOFTWARE\Borland\C++Builder';
  BDSKeyName          = 'SOFTWARE\Borland\BDS';
  DelphiKeyName       = 'SOFTWARE\Borland\Delphi';

  BDSVersions: array [1..3] of TBDSVersionInfo = (
    (
      Name: 'C#Builder';
      VersionStr: '1.0';
      Version: 1;
      CoreIdeVersion: '71';
      ProjectsDirResId: 64507;
      Supported: False),
    (
      Name: 'Delphi';
      VersionStr: '8';
      Version: 8;
      CoreIdeVersion: '71';
      ProjectsDirResId: 64460;
      Supported: False),
    (
      Name: 'Delphi';
      VersionStr: '2005';
      Version: 9;
      CoreIdeVersion: '90';
      ProjectsDirResId: 64431;
      Supported: True)
  );
  {$ENDIF MSWINDOWS}

  {$IFDEF KYLIX}
  RootDirValueName           = 'DelphiRoot';
  {$ELSE}
  RootDirValueName           = 'RootDir';
  {$ENDIF KYLIX}

  EditionValueName           = 'Edition';
  VersionValueName           = 'Version';

  DebuggingKeyName           = 'Debugging';
  DebugDCUPathValueName      = 'Debug DCUs Path';

  GlobalsKeyName             = 'Globals';

  LibraryKeyName             = 'Library';
  LibrarySearchPathValueName = 'Search Path';
  LibraryBrowsingPathValueName = 'Browsing Path';
  LibraryBPLOutputValueName  = 'Package DPL Output';
  LibraryDCPOutputValueName  = 'Package DCP Output';

  TransferKeyName            = 'Transfer';
  TransferCountValueName     = 'Count';
  TransferPathValueName      = 'Path%d';
  TransferParamsValueName    = 'Params%d';
  TransferTitleValueName     = 'Title%d';
  TransferWorkDirValueName   = 'WorkingDir%d';

  DisabledPackagesKeyName    = 'Disabled Packages';
  EnvVariablesKeyName        = 'Environment Variables';
  KnownPackagesKeyName       = 'Known Packages';

  PaletteKeyName             = 'Palette';
  PaletteHiddenTag           = '.Hidden';

  {$IFDEF MSWINDOWS}
  MakeExeName                = 'make.exe';
  Bpr2MakExeName             = 'bpr2mak.exe';
  DCCExeName                 = 'dcc32.exe';
  DelphiOptionsFileExtension = '.dof';
  BorRADToolRepositoryFileName = 'delphi32.dro';
  HelpContentFileName        = '%s\Help\%s%d.ohc';
  HelpIndexFileName          = '%s\Help\%s%d.ohi';
  HelpLinkFileName           = '%s\Help\%s%d.ohl';
  HelpProjectFileName        = '%s\Help\%s%d.ohp';
  HelpGidFileName            = '%s\Help\%s%d.gid';
  {$ENDIF MSWINDOWS}

  {$IFDEF KYLIX}
  IDs: array [TKylixVersion] of Integer = (60, 65, 69);
  LibSuffixes: array [TKylixVersion] of string[3] = ('6.0', '6.5', '6.9');

  DelphiIdeExeName           = 'delphi';
  BCBIdeExeName              = 'bcblin';
  MakeExeName                = 'make';
  Bpr2MakExeName             = 'bpr2mak';
  DelphiOptionsFileExtension = '.kof';

  DCCExeName                 = 'dcc';
  KylixHelpNamePart          = 'k%d';
  {$ENDIF KYLIX}

procedure GetDPKFileInfo(const DPKFileName: string; out RunOnly: Boolean;
  const LibSuffix: PString = nil; const Description: PString = nil);
const
  DescriptionOption     = '{$DESCRIPTION ''';
  LibSuffixOption       = '{$LIBSUFFIX ''';
  RunOnlyOption         = '{$RUNONLY}';
var
  I: Integer;
  S: string;
  DPKFile: TStringList;
begin
  DPKFile := TStringList.Create;
  try
    DPKFile.LoadFromFile(DPKFileName);
    if Assigned(Description) then
      Description^ := '';
    if Assigned(LibSuffix) then
      LibSuffix^ := '';
    RunOnly := False;
    for I := 0 to DPKFile.Count - 1 do
    begin
      S := TrimRight(DPKFile[I]);
      if Assigned(Description) and (Pos(DescriptionOption, S) = 1) then
        Description^ := Copy(S, Length(DescriptionOption), Length(S) - Length(DescriptionOption))
      else
      if Assigned(LibSuffix) and (Pos(LibSuffixOption, S) = 1) then
        LibSuffix^ := StrTrimQuotes(Copy(S, Length(LibSuffixOption), Length(S) - Length(LibSuffixOption)))
      else
      if Pos(RunOnlyOption, S) = 1 then
        RunOnly := True;
    end;
  finally
    DPKFile.Free;
  end;
end;

function BPLFileName(const BPLPath, DPKFileName: string): string;
var
  LibSuffix: string;
  RunOnly: Boolean;
begin
  GetDPKFileInfo(DPKFileName, RunOnly, @LibSuffix);
  Result := PathAddSeparator(BPLPath) + PathExtractFileNameNoExt(DPKFileName) + LibSuffix + '.bpl';
end;

function IsDelphiPackage(const FileName: string): Boolean;
begin
  Result := SameText(ExtractFileExt(FileName), TJclDelphiInstallation.PackageSourceFileExtension);
  { TODO : Add some plausibility tests }
  { like
  var
    F: TextFile;
    FirstLine: string;

  if FileExists(FileName) then
  begin
    AssignFile(F, FileName);
    Reset(F);
    ReadLn(F, FirstLine);
    Result := Pos('package ', FirstLine) = 1;
    CloseFile(F);
  end;
  }
end;

{$IFDEF MSWINDOWS}
function RegGetValueNamesAndValues(const RootKey: HKEY; const Key: string; const List: TStrings): Boolean;
var
  I: Integer;
  TempList: TStringList;
  Name: string;
  DataType: DWORD;
begin
  TempList := TStringList.Create;
  try
    Result := RegKeyExists(RootKey, Key) and RegGetValueNames(RootKey, Key, TempList);
    if Result then
    begin
      for I := 0 to TempList.Count - 1 do
      begin
        Name := TempList[I];
        if RegGetDataType(RootKey, Key, Name, DataType) and (DataType = REG_SZ) then
          TempList[I] := Name + '=' + RegReadStringDef(RootKey, Key, Name, '');
      end;
      List.AddStrings(TempList);
    end;
  finally
    TempList.Free;
  end;
end;
{$ENDIF MSWINDOWS}

//=== { TJclBorRADToolInstallationObject } ===================================

constructor TJclBorRADToolInstallationObject.Create(AInstallation: TJclBorRADToolInstallation);
begin
  FInstallation := AInstallation;
end;

//=== { TJclBorlandOpenHelp } ================================================

{$IFDEF MSWINDOWS}

function TJclBorlandOpenHelp.AddHelpFile(const HelpFileName, IndexName: string): Boolean;
var
  CntFileName, HelpName, CntName: string;
  List: TStringList;

  procedure AddToList(const FileName, Text: string);
  var
    I, Attr: Integer;
    Found: Boolean;
  begin
    List.LoadFromFile(FileName);
    Found := False;
    for I := 0 to List.Count - 1 do
      if AnsiSameText(Trim(List[I]), Text) then
      begin
        Found := True;
        Break;
      end;
    if not Found then
    begin
      List.Add(Text);
      Attr := FileGetAttr(FileName);
      FileSetAttr(FileName, faArchive);
      List.SaveToFile(FileName);
      FileSetAttr(FileName, Attr);
    end;
  end;

begin
  CntFileName := ChangeFileExt(HelpFileName, '.cnt');
  Result := FileExists(HelpFileName) and FileExists(CntFileName);
  if Result then
  begin
    HelpName := ExtractFileName(HelpFileName);
    CntName := ExtractFileName(CntFileName);
    RegWriteString(HKEY_LOCAL_MACHINE, MSHelpSystemKeyName, HelpName, ExtractFilePath(HelpFileName));
    RegWriteString(HKEY_LOCAL_MACHINE, MSHelpSystemKeyName, CntName, ExtractFilePath(CntFileName));
    List := TStringList.Create;
    try
      AddToList(ContentFileName, Format(':Include %s', [CntName]));
      AddToList(LinkFileName, Format(':Link %s', [HelpName]));
      AddToList(IndexFileName, Format(':Index %s=%s', [IndexName, HelpName]));
      SetFileLastWrite(ProjectFileName, Now);
      DeleteFile(GidFileName);
    finally
      List.Free;
    end;
  end;
end;

function TJclBorlandOpenHelp.GetContentFileName: string;
begin
  Result := ReadFileName(HelpContentFileName);
end;

function TJclBorlandOpenHelp.GetGidFileName: string;
begin
  Result := ReadFileName(HelpGidFileName);
end;

function TJclBorlandOpenHelp.GetIndexFileName: string;
begin
  Result := ReadFileName(HelpIndexFileName);
end;

function TJclBorlandOpenHelp.GetLinkFileName: string;
begin
  Result := ReadFileName(HelpLinkFileName);
end;

function TJclBorlandOpenHelp.GetProjectFileName: string;
begin
  Result := ReadFileName(HelpProjectFileName);
end;

function TJclBorlandOpenHelp.ReadFileName(const FormatName: string): string;
var
  S: string;
begin
  with Installation do
  begin
    if RADToolKind = brDelphi then
    begin
      if VersionNumber <= 6 then
        S := 'delphi'
      else
        S := 'd';
    end
    else
      S := 'bcb';
    Result := Format(FormatName, [RootDir, S, VersionNumber]);
  end;
end;

function TJclBorlandOpenHelp.RemoveHelpFile(const HelpFileName, IndexName: string): Boolean;
var
  CntFileName, HelpName, CntName: string;
  List: TStringList;

  procedure RemoveFromList(const FileName, Text: string);
  var
    I, Attr: Integer;
    Found: Boolean;
  begin
    List.LoadFromFile(FileName);
    Found := False;
    for I := 0 to List.Count - 1 do
      if AnsiSameText(Trim(List[I]), Text) then
      begin
        Found := True;
        List.Delete(I);
        Break;
      end;
    if Found then
    begin
      Attr := FileGetAttr(FileName);
      FileSetAttr(FileName, faArchive);
      List.SaveToFile(FileName);
      FileSetAttr(FileName, Attr);
    end;
  end;

begin
  CntFileName := ChangeFileExt(HelpFileName, '.cnt');
  Result := FileExists(HelpFileName) and FileExists(CntFileName);
  if Result then
  begin
    HelpName := ExtractFileName(HelpFileName);
    CntName := ExtractFileName(CntFileName);
    //RegDeleteEntry(HKEY_LOCAL_MACHINE, MSHelpSystemKeyName, HelpName);
    //RegDeleteEntry(HKEY_LOCAL_MACHINE, MSHelpSystemKeyName, CntName);
    List := TStringList.Create;
    try
      RemoveFromList(ContentFileName, Format(':Include %s', [CntName]));
      RemoveFromList(LinkFileName, Format(':Link %s', [HelpName]));
      RemoveFromList(IndexFileName, Format(':Index %s=%s', [IndexName, HelpName]));
      SetFileLastWrite(ProjectFileName, Now);
      DeleteFile(GidFileName);
    finally
      List.Free;
    end;
  end;
end;

{$ENDIF MSWINDOWS}

//== { TJclBorRADToolIdeTool } ===============================================

constructor TJclBorRADToolIdeTool.Create(AInstallation: TJclBorRADToolInstallation);
begin
  inherited Create(AInstallation);
  FKey := TransferKeyName;
end;

procedure TJclBorRADToolIdeTool.CheckIndex(Index: Integer);
begin
  if (Index < 0) or (Index >= Count) then
    raise EJclError.CreateRes(@RsIndexOufOfRange);
end;

function TJclBorRADToolIdeTool.GetCount: Integer;
begin
  Result := Installation.ConfigData.ReadInteger(Key, TransferCountValueName, 0);
end;

function TJclBorRADToolIdeTool.GetParameters(Index: Integer): string;
begin
  CheckIndex(Index);
  Result := Installation.ConfigData.ReadString(Key, Format(TransferParamsValueName, [Index]), '');
end;

function TJclBorRADToolIdeTool.GetPath(Index: Integer): string;
begin
  CheckIndex(Index);
  Result := Installation.ConfigData.ReadString(Key, Format(TransferPathValueName, [Index]), '');
end;

function TJclBorRADToolIdeTool.GetTitle(Index: Integer): string;
begin
  CheckIndex(Index);
  Result := Installation.ConfigData.ReadString(Key, Format(TransferTitleValueName, [Index]), '');
end;

function TJclBorRADToolIdeTool.GetWorkingDir(Index: Integer): string;
begin
  CheckIndex(Index);
  Result := Installation.ConfigData.ReadString(Key, Format(TransferWorkDirValueName, [Index]), '');
end;

function TJclBorRADToolIdeTool.IndexOfPath(const Value: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if AnsiSameText(Title[I], Value) then
    begin
      Result := I;
      Break;
    end;
end;

function TJclBorRADToolIdeTool.IndexOfTitle(const Value: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Title[I] = Value then
    begin
      Result := I;
      Break;
    end;
end;

procedure TJclBorRADToolIdeTool.SetCount(const Value: Integer);
begin
  if Value > Count then
    Installation.ConfigData.WriteInteger(Key, TransferCountValueName, Value);
end;

procedure TJclBorRADToolIdeTool.SetParameters(Index: Integer; const Value: string);
begin
  CheckIndex(Index);
  Installation.ConfigData.WriteString(Key, Format(TransferParamsValueName, [Index]), Value);
end;

procedure TJclBorRADToolIdeTool.SetPath(Index: Integer; const Value: string);
begin
  CheckIndex(Index);
  Installation.ConfigData.WriteString(Key, Format(TransferPathValueName, [Index]), Value);
end;

procedure TJclBorRADToolIdeTool.SetTitle(Index: Integer; const Value: string);
begin
  CheckIndex(Index);
  Installation.ConfigData.WriteString(Key, Format(TransferTitleValueName, [Index]), Value);
end;

procedure TJclBorRADToolIdeTool.SetWorkingDir(Index: Integer; const Value: string);
begin
  CheckIndex(Index);
  Installation.ConfigData.WriteString(Key, Format(TransferWorkDirValueName, [Index]), Value);
end;

//=== { TJclBorRADToolIdePackages } ==========================================

constructor TJclBorRADToolIdePackages.Create(AInstallation: TJclBorRADToolInstallation);
begin
  inherited Create(AInstallation);
  FDisabledPackages := TStringList.Create;
  FDisabledPackages.Sorted := True;
  FDisabledPackages.Duplicates := dupIgnore;
  FKnownPackages := TStringList.Create;
  FKnownPackages.Sorted := True;
  FKnownPackages.Duplicates := dupIgnore;
  ReadPackages;
end;

destructor TJclBorRADToolIdePackages.Destroy;
begin
  FreeAndNil(FDisabledPackages);
  FreeAndNil(FKnownPackages);
  inherited Destroy;
end;

function TJclBorRADToolIdePackages.AddPackage(const FileName, Description: string): Boolean;
begin
  Result := True;
  RemoveDisabled(FileName);
  Installation.ConfigData.WriteString(KnownPackagesKeyName, FileName, Description);
  ReadPackages;
end;

function TJclBorRADToolIdePackages.GetCount: Integer;
begin
  Result := FKnownPackages.Count;
end;

function TJclBorRADToolIdePackages.GetPackageDescriptions(Index: Integer): string;
begin
  Result := FKnownPackages.Values[FKnownPackages.Names[Index]];
end;

function TJclBorRADToolIdePackages.GetPackageDisabled(Index: Integer): Boolean;
begin
  Result := Boolean(FKnownPackages.Objects[Index]);
end;

function TJclBorRADToolIdePackages.GetPackageFileNames(Index: Integer): string;
begin
  Result := PackageEntryToFileName(FKnownPackages.Names[Index]);
end;

function TJclBorRADToolIdePackages.PackageEntryToFileName(const Entry: string): string;
begin
  Result := {$IFDEF MSWINDOWS} PathGetLongName {$ENDIF} (Installation.SubstitutePath(Entry));
end;

procedure TJclBorRADToolIdePackages.ReadPackages;

  procedure ReadPackageList(const Name: string; List: TStringList);
  var
    ListIsSorted: Boolean;
  begin
    ListIsSorted := List.Sorted;
    List.Sorted := False;
    List.Clear;
    Installation.ConfigData.ReadSectionValues(Name, List);
    List.Sorted := ListIsSorted;
  end;

var
  I: Integer;
begin
  ReadPackageList(KnownPackagesKeyName, FKnownPackages);
  ReadPackageList(DisabledPackagesKeyName, FDisabledPackages);
  for I := 0 to Count - 1 do
    if FDisabledPackages.IndexOfName(FKnownPackages.Names[I]) <> -1 then
      FKnownPackages.Objects[I] := Pointer(True);
end;

procedure TJclBorRADToolIdePackages.RemoveDisabled(const FileName: string);
var
  I: Integer;
begin
  for I := 0 to FDisabledPackages.Count - 1 do
    if AnsiSameText(FileName, PackageEntryToFileName(FDisabledPackages.Names[I])) then
    begin
      Installation.ConfigData.DeleteKey(DisabledPackagesKeyName, FDisabledPackages.Names[I]);
      ReadPackages;
      Break;
    end;
end;

function TJclBorRADToolIdePackages.RemovePackage(const FileName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FKnownPackages.Count - 1 do
    if AnsiSameText(FileName, PackageEntryToFileName(FKnownPackages.Names[I])) then
    begin
      RemoveDisabled(FileName);
      Installation.ConfigData.DeleteKey(KnownPackagesKeyName, FKnownPackages.Names[I]);
      ReadPackages;
      Result := True;
      Break;
    end;
end;

//=== { TJclBorlandCommandLineTool } =========================================

constructor TJclBorlandCommandLineTool.Create(AInstallation: TJclBorRADToolInstallation);
begin
  inherited Create(AInstallation);
  FOptions := TStringList.Create;
end;

destructor TJclBorlandCommandLineTool.Destroy;
begin
  FreeAndNil(FOptions);
  inherited Destroy;
end;

procedure TJclBorlandCommandLineTool.AddPathOption(const Option, Path: string);
var
  S: string;

  {$IFDEF MSWINDOWS}
  // to avoid the 126 character limit of DCC32 (and eventually other command line tools)
  // which shows up with misleading error messages ("Fatal: System.pas not found") or
  // might even cause AVs
  procedure ConvertToShortPathNames(var Paths: string);
  var
    List: TStringList;
    I: Integer;
  begin
    List := TStringList.Create;
    try
      StrToStrings(Paths, PathSep, List);
      for I := 0 to List.Count - 1 do
        List[I] := PathGetShortName(List[I]);
      Paths := StringsToStr(List, PathSep);
    finally
      List.Free;
    end;
  end;
  {$ENDIF MSWINDOWS}

begin
  S := PathRemoveSeparator(Path);
  {$IFDEF MSWINDOWS}
  S := LowerCase(S); // file names are case insensitive
  ConvertToShortPathNames(S);
  {$ENDIF MSWINDOWS}
  { TODO : If we were sure that options are always case-insensitive
           for Borland tools, we could use UpperCase(Option) below. }
  S := Format('-%s"%s"', [Option, S]);
  // avoid duplicate entries
  if Options.IndexOf(S) = -1 then
    Options.Add(S);
end;

procedure TJclBorlandCommandLineTool.CheckOutputValid;
begin
  if Assigned(FOutputCallback) then
    raise EJclCommandLineToolError.CreateResFmt(@RsCmdLineToolOutputInvalid, [GetExeName]);
end;

function TJclBorlandCommandLineTool.Execute(const CommandLine: string): Boolean;
begin
  if Assigned(FOutputCallback) then
    Result := JclSysUtils.Execute(Format('%s %s', [FileName, CommandLine]), FOutputCallback) = 0
  else
    Result := JclSysUtils.Execute(Format('%s %s', [FileName, CommandLine]), FOutput) = 0;
end;

function TJclBorlandCommandLineTool.GetExeName: string;
begin
  Result := '';
  {$IFDEF MSWINDOWS}
  raise EAbstractError.CreateResFmt(@SAbstractError, ['']); // BCB doesn't support abstract keyword
  {$ENDIF MSWINDOWS}
end;

function TJclBorlandCommandLineTool.GetFileName: string;
begin
  Result := Installation.BinFolderName + GetExeName;
  if Pos(' ', Result) > 0 then
    Result := AnsiQuotedStr(Result, '"');
end;

function TJclBorlandCommandLineTool.GetOptions: TStrings;
begin
  Result := FOptions;
end;

function TJclBorlandCommandLineTool.GetOutput: string;
begin
  CheckOutputValid;
  Result := FOutput;
end;

function TJclBorlandCommandLineTool.GetOutputCallback: TTextHandler;
begin
  Result := FOutputCallback;
end;

procedure TJclBorlandCommandLineTool.SetOutputCallback(const CallbackMethod: TTextHandler);
begin
  FOutputCallback := CallbackMethod;
end;

//=== { TJclDCC } ============================================================

constructor TJclDCC.Create(AInstallation: TJclBorRADToolInstallation);
begin
  inherited Create(AInstallation);
  SetDefaultOptions; // in case $(DELPHI)\bin\dcc32.cfg (replace as appropriate) is invalid
end;

function TJclDCC.Execute(const CommandLine: string): Boolean;
const
  {$IFDEF WIN32}
  ConfFileName = 'DCC32.CFG';
  {$ENDIF WIN32}
  {$IFDEF KYLIX}
  ConfFileName = 'dcc.conf';
  {$ENDIF KYLIX}
begin
  FOutput := '';
  SaveOptionsToFile(ConfFileName);
  Result := inherited Execute(CommandLine);
  DeleteFile(ConfFileName);
end;

procedure TJclDCC.SaveOptionsToFile(const ConfigFileName: string);
{$IFDEF MSWINDOWS}

  function IsPathOption(const S: string; out Len: Integer): Boolean;
  begin
    case UpCase(S[2]) of
      'E', 'I', 'O', 'R', 'U':
        begin
          Result := True;
          Len := 2;
        end;
      'L':
        begin
          Result := UpCase(S[3]) in ['E', 'N'];
          Len := 3;
        end;
      'N':
        begin
          Result := True;
          if S[3] in ['0'..'9'] then
            Len := 3
          else
            Len := 2;
        end;
    else
      Result := False;
    end;
  end;

var
  I, J: Integer;
  List: TStringList;
  S: string;
  F: TextFile;
begin
  AssignFile(F, ConfigFileName);
  Rewrite(F);
  List := TStringList.Create;
  try
    for I := 0 to Options.Count - 1 do
    begin
      S := Options[I];
      if IsPathOption(S, J) then
      begin
        Write(F, Copy(S, 1, J), '"');
        StrToStrings(StrTrimQuotes(PChar(@S[J + 1])), PathSep, List);
        // change to relative paths to avoid DCC32 126 character path limit
        for J := 0 to List.Count - 1 do
          List[J] := PathGetRelativePath(GetCurrentFolder, ExpandFileName(List[J]));
        if List.Count > 0 then
        begin
          for J := 0 to List.Count - 2 do
            Write(F, List[J], PathSep);
          WriteLn(F, List[List.Count - 1], '"');
        end;
      end
      else
        WriteLn(F, S);
    end;
  finally
    List.Free;
  end;
  CloseFile(F);
end;
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
begin
  FOptions.SaveToFile(ConfigFileName);
end;
{$ENDIF UNIX}

function TJclDCC.GetExeName: string;
begin
  Result := DCCExeName;
end;

function TJclDCC.MakePackage(const PackageName, BPLPath, DCPPath: string): Boolean;
const
  DOFDirectoriesSection = 'Directories';
  UnitOutputDirName     = 'UnitOutputDir';
  SearchPathName        = 'SearchPath';
var
  SaveDir, S: string;
  OptionsFile: TIniFile;
begin
  SaveDir := GetCurrentDir;
  SetCurrentDir(ExtractFilePath(PackageName) + '.');
  try
    OptionsFile := TIniFile.Create(ChangeFileExt(PackageName, DelphiOptionsFileExtension));
    try
      Options.Clear;
      S := OptionsFile.ReadString(DOFDirectoriesSection, SearchPathName, '');
      AddPathOption('N', OptionsFile.ReadString(DOFDirectoriesSection, UnitOutputDirName, ''));
      AddPathOption('I', S);
      AddPathOption('R', S);
      AddPathOption('LE', BPLPath);
      AddPathOption('LN', DCPPath);
      AddPathOption('U', StrEnsureSuffix(PathSep, DCPPath) + S);
    finally
      OptionsFile.Free;
    end;
    {$IFDEF MSWINDOWS}
    // quotes not required with short path names
    Result := Execute(PathGetShortName(ExtractFileDir(PackageName)) + PathSeparator + ExtractFileName(PackageName));
    {$ELSE}
    Result := Execute(StrDoubleQuote(StrTrimQuotes(PackageName)));
    {$ENDIF}
  finally
    SetCurrentDir(SaveDir);
  end;
end;

procedure TJclDCC.SetDefaultOptions;
begin
  Options.Clear;
  AddPathOption('U', Installation.LibFolderName);
  if Installation.RadToolKind = brCppBuilder then
  begin
    AddPathOption('U', Installation.LibFolderName + PathAddSeparator('obj'));
    {$IFNDEF KYLIX}
    if Installation.VersionNumber = 5 then
      Options.Add('-LUvcl50')
    else
      Options.Add('-LUrtl');
    {$ENDIF ~KYLIX}
  end;
end;

function TJclDCC.SupportsLibSuffix: Boolean;
begin
  {$IFDEF KYLIX}
  Result := True;
  {$ELSE}
  Result := Installation.VersionNumber >= 6;
  {$ENDIF KYLIX}
end;

//=== { TJclBorlandMake } ====================================================

function TJclBorlandMake.GetExeName: string;
begin
  Result := MakeExeName;
end;

//=== { TJclBpr2Mak } ========================================================

function TJclBpr2Mak.GetExeName: string;
begin
  Result := Bpr2MakExeName;
end;

//=== { TJclBorRADToolPalette } ==============================================

constructor TJclBorRADToolPalette.Create(AInstallation: TJclBorRADToolInstallation);
begin
  inherited Create(AInstallation);
  FKey := PaletteKeyName;
  FTabNames := TStringList.Create;
  FTabNames.Sorted := True;
  ReadTabNames;
end;

destructor TJclBorRADToolPalette.Destroy;
begin
  FreeAndNil(FTabNames);
  inherited Destroy;
end;

procedure TJclBorRADToolPalette.ComponentsOnTabToStrings(Index: Integer; Strings: TStrings;
  IncludeUnitName: Boolean; IncludeHiddenComponents: Boolean);
var
  TempList: TStringList;

  procedure ProcessList(Hidden: Boolean);
  var
    D, I: Integer;
    List, S: string;
  begin
    if Hidden then
      List := HiddenComponentsOnTab[Index]
    else
      List := ComponentsOnTab[Index];
    List := StrEnsureSuffix(';', List);
    while Length(List) > 1 do
    begin
      D := Pos(';', List);
      S := Trim(Copy(List, 1, D - 1));
      if not IncludeUnitName then
        Delete(S, 1, Pos('.', S));
      if Hidden then
      begin
        I := TempList.IndexOf(S);
        if I = -1 then
          TempList.AddObject(S, Pointer(True))
        else
          TempList.Objects[I] := Pointer(True);
      end
      else
        TempList.Add(S);
      Delete(List, 1, D);
    end;
  end;

begin
  TempList := TStringList.Create;
  try
    TempList.Duplicates := dupError;
    ProcessList(False);
    TempList.Sorted := True;
    if IncludeHiddenComponents then
      ProcessList(True);
    Strings.AddStrings(TempList);
  finally
    TempList.Free;
  end;
end;

function TJclBorRADToolPalette.DeleteTabName(const TabName: string): Boolean;
var
  I: Integer;
begin
  I := FTabNames.IndexOf(TabName);
  Result := I >= 0;
  if Result then
  begin
    Installation.ConfigData.DeleteKey(Key, FTabNames[I]);
    Installation.ConfigData.DeleteKey(Key, FTabNames[I] + PaletteHiddenTag);
    FTabNames.Delete(I);
  end;
end;

function TJclBorRADToolPalette.GetComponentsOnTab(Index: Integer): string;
begin
  Result := Installation.ConfigData.ReadString(Key, FTabNames[Index], '');
end;

function TJclBorRADToolPalette.GetHiddenComponentsOnTab(Index: Integer): string;
begin
  Result := Installation.ConfigData.ReadString(Key, FTabNames[Index] + PaletteHiddenTag, '');
end;

function TJclBorRADToolPalette.GetTabNameCount: Integer;
begin
  Result := FTabNames.Count;
end;

function TJclBorRADToolPalette.GetTabNames(Index: Integer): string;
begin
  Result := FTabNames[Index];
end;

procedure TJclBorRADToolPalette.ReadTabNames;
var
  TempList: TStringList;
  I: Integer;
  S: string;
begin
  if Installation.ConfigData.SectionExists(Key) then
  begin
    TempList := TStringList.Create;
    try
      Installation.ConfigData.ReadSection(Key, TempList);
      for I := 0 to TempList.Count - 1 do
      begin
        S := TempList[I];
        if Pos(PaletteHiddenTag, S) = 0 then
          FTabNames.Add(S);
      end;
    finally
      TempList.Free;
    end;
  end;
end;

function TJclBorRADToolPalette.TabNameExists(const TabName: string): Boolean;
begin
  Result := FTabNames.IndexOf(TabName) <> -1;
end;

//=== { TJclBorRADToolRepository } ===========================================

constructor TJclBorRADToolRepository.Create(AInstallation: TJclBorRADToolInstallation);
begin
  inherited Create(AInstallation);
  {$IFDEF KYLIX}
  FFileName := AInstallation.ConfigFileName('dro');
  {$ELSE}
  FFileName := AInstallation.BinFolderName + BorRADToolRepositoryFileName;
  {$ENDIF KYLIX}
  FPages := TStringList.Create;
  IniFile.ReadSection(BorRADToolRepositoryPagesSection, FPages);
  CloseIniFile;
end;

destructor TJclBorRADToolRepository.Destroy;
begin
  FreeAndNil(FPages);
  FreeAndNil(FIniFile);
  inherited Destroy;
end;

procedure TJclBorRADToolRepository.AddObject(const FileName, ObjectType, PageName, ObjectName,
  IconFileName, Description, Author, Designer: string; const Ancestor: string);
var
  SectionName: string;
begin
  GetIniFile;
  SectionName := AnsiUpperCase(PathRemoveExtension(FileName));
  FIniFile.EraseSection(FileName);
  FIniFile.EraseSection(SectionName);
  FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectType, ObjectType);
  FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectName, ObjectName);
  FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectPage, PageName);
  FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectIcon, IconFileName);
  FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectDescr, Description);
  FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectAuthor, Author);
  if Ancestor <> '' then
    FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectAncestor, Ancestor);
  if Installation.VersionNumber >= 6 then
    FIniFile.WriteString(SectionName, BorRADToolRepositoryObjectDesigner, Designer);
  FIniFile.WriteBool(SectionName, BorRADToolRepositoryObjectNewForm, False);
  FIniFile.WriteBool(SectionName, BorRADToolRepositoryObjectMainForm, False);
  CloseIniFile;
end;

procedure TJclBorRADToolRepository.CloseIniFile;
begin
  FreeAndNil(FIniFile);
end;

function TJclBorRADToolRepository.FindPage(const Name: string; OptionalIndex: Integer): string;
var
  I: Integer;
begin
  I := Pages.IndexOf(Name);
  if I >= 0 then
    Result := Pages[I]
  else
  begin
    if OptionalIndex < Pages.Count then
      Result := Pages[OptionalIndex]
    else
      Result := '';
  end;
end;

function TJclBorRADToolRepository.GetIniFile: TIniFile;
begin
  if not Assigned(FIniFile) then
    FIniFile := TIniFile.Create(FileName);
  Result := FIniFile;
end;

function TJclBorRADToolRepository.GetPages: TStrings;
begin
  Result := FPages;
end;

procedure TJclBorRADToolRepository.RemoveObjects(const PartialPath, FileName, ObjectType: string);
var
  Sections: TStringList;
  I: Integer;
  SectionName, FileNamePart, PathPart, DialogFileName: string;
begin
  Sections := TStringList.Create;
  try
    GetIniFile;
    FIniFile.ReadSections(Sections);
    for I := 0 to Sections.Count - 1 do
    begin
      SectionName := Sections[I];
      if FIniFile.ReadString(SectionName, BorRADToolRepositoryObjectType, '') = ObjectType then
      begin
        FileNamePart := PathExtractFileNameNoExt(SectionName);
        PathPart := StrRight(PathAddSeparator(ExtractFilePath(SectionName)), Length(PartialPath));
        DialogFileName := PathExtractFileNameNoExt(FileName);
        if StrSame(FileNamePart, DialogFileName) and StrSame(PathPart, PartialPath) then
          FIniFile.EraseSection(SectionName);
      end;
    end;
  finally
    Sections.Free;
  end;
end;

//=== { TJclBorRADToolInstallation } =========================================

constructor TJclBorRADToolInstallation.Create;
begin
  inherited Create;
  {$IFDEF KYLIX}
  FConfigData := TMemIniFile.Create(AConfigDataLocation);
  FMake := TJclCommandLineTool.Create('make');
  {$ELSE ~KYLIX}
  FConfigData := TRegistryIniFile.Create(AConfigDataLocation);
  FMake := TJclBorlandMake.Create(Self);
  // Set option "-l+", which enables use of long command lines.  Should be
  // default, but there have been reports indicating that's not always the case.
  FMake.Options.Add('-l+');
  {$ENDIF ~KYLIX}
  FGlobals := TStringList.Create;
  ReadInformation;
  FIdeTools := TJclBorRADToolIdeTool.Create(Self);
  {$IFNDEF KYLIX}
  FOpenHelp := TJclBorlandOpenHelp.Create(Self);
  {$ENDIF ~KYLIX}
end;

destructor TJclBorRADToolInstallation.Destroy;
begin
  FreeAndNil(FRepository);
  FreeAndNil(FDCC);
  FreeAndNil(FIdePackages);
  FreeAndNil(FIdeTools);
  {$IFDEF MSWINDOWS}
  FreeAndNil(FOpenHelp);
  {$ENDIF MSWINDOWS}
  FreeAndNil(FPalette);
  FreeAndNil(FGlobals);
  {$IFDEF KYLIX}
  FConfigData.UpdateFile; // TMemIniFile.Destroy doesn't call UpdateFile
  {$ENDIF KYLIX}
  FreeAndNil(FConfigData);
  inherited Destroy;
end;

function TJclBorRADToolInstallation.AddToDebugDCUPath(const Path: string): Boolean;
var
  TempDebugDCUPath: TJclBorRADToolPath;
begin
  TempDebugDCUPath := DebugDCUPath;
  Result := AddMissingPathItems(TempDebugDCUPath, Path);
  DebugDCUPath := TempDebugDCUPath;
end;

function TJclBorRADToolInstallation.AddToLibrarySearchPath(const Path: string): Boolean;
var
  TempLibraryPath: TJclBorRADToolPath;
begin
  TempLibraryPath := LibrarySearchPath;
  Result := AddMissingPathItems(TempLibraryPath, Path);
  LibrarySearchPath := TempLibraryPath;
end;

function TJclBorRADToolInstallation.AddToLibraryBrowsingPath(const Path: string): Boolean;
var
  TempLibraryPath: TJclBorRADToolPath;
begin
  TempLibraryPath := LibraryBrowsingPath;
  Result := AddMissingPathItems(TempLibraryPath, Path);
  LibraryBrowsingPath := TempLibraryPath;
end;

function TJclBorRADToolInstallation.AnyInstanceRunning: Boolean;
var
  Processes: TStringList;
  I: Integer;
begin
  Result := False;
  Processes := TStringList.Create;
  try
    if RunningProcessesList(Processes) then
    begin
      for I := 0 to Processes.Count - 1 do
        if AnsiSameText(IdeExeFileName, Processes[I]) then
        begin
          Result := True;
          Break;
        end;
    end;
  finally
    Processes.Free;
  end;
end;

{$IFDEF KYLIX}
function TJclBorRADToolInstallation.ConfigFileName(const Extension: string): string;
begin
  Result := '';
end;
{$ENDIF KYLIX}

class procedure TJclBorRADToolInstallation.ExtractPaths(const Path: TJclBorRADToolPath; List: TStrings);
begin
  StrToStrings(Path, PathSep, List);
end;

function TJclBorRADToolInstallation.AddMissingPathItems(var Path: string; const NewPath: string): Boolean;
var
  PathItems, NewItems: TStringList;
  Folder: string;
  I: Integer;
  Missing: Boolean;
begin
  Result := False;
  PathItems := nil;
  NewItems := nil;
  try
    PathItems := TStringList.Create;
    NewItems := TStringList.Create;
    ExtractPaths(Path, PathItems);
    ExtractPaths(NewPath, NewItems);
    for I := 0 to NewItems.Count - 1 do
    begin
      Folder := NewItems[I];
      Missing := FindFolderInPath(Folder, PathItems) = -1;
      if Missing then
      begin
        Path := StrEnsureSuffix(PathSep, Path) + Folder;
        Result := True;
      end;
    end;
  finally
    PathItems.Free;
    NewItems.Free;
  end;
end;

function TJclBorRADToolInstallation.RemoveFromPath(var Path: string; const ItemsToRemove: string): Boolean;
var
  PathItems, RemoveItems: TStringList;
  Folder: string;
  I, J: Integer;
begin
  Result := False;
  PathItems := nil;
  RemoveItems := nil;
  try
    PathItems := TStringList.Create;
    RemoveItems := TStringList.Create;
    ExtractPaths(Path, PathItems);
    ExtractPaths(ItemsToRemove, RemoveItems);
    for I := 0 to RemoveItems.Count - 1 do
    begin
      Folder := RemoveItems[I];
      J := FindFolderInPath(Folder, PathItems);
      if J <> -1 then
      begin
        PathItems.Delete(J);
        Result := True;
      end;
    end;
    Path := StringsToStr(PathItems, PathSep, False);
  finally
    PathItems.Free;
    RemoveItems.Free;
  end;
end;

function TJclBorRADToolInstallation.FindFolderInPath(Folder: string; List: TStrings): Integer;
var
  I: Integer;
begin
  Result := -1;
  Folder := PathRemoveSeparator(Folder);
  for I := 0 to List.Count - 1 do
    if AnsiSameText(Folder, PathRemoveSeparator(SubstitutePath(List[I]))) then
    begin
      Result := I;
      Break;
    end;
end;

{ TODO -cHelp : Donator: Adreas Hausladen }
{$IFDEF MSWINDOWS}
function TJclBorRADToolInstallation.GetBorlandStudioProjectsDir: string;
var
  h: HMODULE;
  LocaleName: array[0..4] of Char;
  Filename: string;
begin
  if IsBDSPersonality then
  begin
    Result := 'Borland Studio Projects'; // do not localize

    FillChar(LocaleName, SizeOf(LocaleName[0]), 0);
    GetLocaleInfo(GetThreadLocale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
    if LocaleName[0] <> #0 then
    begin
      Filename := RootDir + '\Bin\coreide' + BDSVersions[IDEVersionNumber].CoreIdeVersion + '.';
      if FileExists(Filename + LocaleName) then
        Filename := Filename + LocaleName
      else
      begin
        LocaleName[2] := #0;
        if FileExists(Filename + LocaleName) then
          Filename := Filename + LocaleName
        else
          Filename := '';
      end;

      if Filename <> '' then
      begin
        h := LoadLibraryEx(PChar(Filename), 0,
          LOAD_LIBRARY_AS_DATAFILE or DONT_RESOLVE_DLL_REFERENCES);
        if h <> 0 then
        begin
          SetLength(Result, 1024);
          SetLength(Result, LoadString(h, BDSVersions[IDEVersionNumber].ProjectsDirResId, PChar(Result), Length(Result) - 1));
          FreeLibrary(h);
        end;
      end;
    end;

    Result := PathAddSeparator(GetPersonalFolder) + Result;
  end
  else
    Result := '';
end;
{$ENDIF MSWINDOWS}

function TJclBorRADToolInstallation.GetBPLOutputPath: string;
begin
  Result := SubstitutePath(ConfigData.ReadString(LibraryKeyName, LibraryBPLOutputValueName, ''));
end;

function TJclBorRADToolInstallation.GetDCC: TJclDCC;
begin
  if not Assigned(FDCC) then
    FDCC := TJclDCC.Create(Self);
  Result := FDCC;
end;

function TJclBorRADToolInstallation.GetDCPOutputPath: string;
begin
  Result := SubstitutePath(ConfigData.ReadString(LibraryKeyName, LibraryDCPOutputValueName, ''));
end;

function TJclBorRADToolInstallation.GetDebugDCUPath: string;
begin
  Result := ConfigData.ReadString(DebuggingKeyName, DebugDCUPathValueName, '');
end;

function TJclBorRADToolInstallation.GetDefaultProjectsDir: string;
begin
  {$IFDEF KYLIX}
  Result := GetPersonalFolder;
  {$ELSE ~KYLIX}
  Result := Globals.Values['DefaultProjectsDirectory'];
  if Result = '' then
    if IsBDSPersonality then
      Result := GetBorlandStudioProjectsDir
    else
      Result := PathAddSeparator(RootDir) + 'Projects';
  {$ENDIF ~KYLIX}
end;

function TJclBorRADToolInstallation.GetDescription: string;
begin
  Result := Format('%s %s', [Name, EditionAsText]);
  if InstalledUpdatePack > 0 then
    Result := Result + ' ' + Format(RsUpdatePackName, [InstalledUpdatePack]);
end;

function TJclBorRADToolInstallation.GetEditionAsText: string;
begin
  {$IFDEF KYLIX}
  case Edition of
    deOPEN:
      Result := RsOpenEdition;
    dePRO:
      Result := RsProfessional;
    deSVR:
      if VersionNumber >= 2 then
        Result := RsEnterprise
      else
        Result := RsServerDeveloper;
  end;
  {$ELSE}
  Result := FEditionStr;
  if Length(FEditionStr) = 3 then
    case Edition of
      deSTD:
        if VersionNumber >= 6 then
          Result := RsPersonal
        else
          Result := RsStandard;
      dePRO:
        Result := RsProfessional;
      deCSS:
        if VersionNumber >= 5 then
          Result := RsEnterprise
        else
          Result := RsClientServer;
    end;
  {$ENDIF KYLIX}
end;

function TJclBorRADToolInstallation.GetEnvironmentVariables: TStrings;
const
  ToolNames: array[TJclBorRadToolKind] of string = ('DELPHI', 'BCB');
var
  EnvNames: TStringList;
  EnvVarKeyName: string;
  I: Integer;
begin
  if FEnvironmentVariables = nil then
  begin
    FEnvironmentVariables := TStringList.Create;
    if (VersionNumber >= 6) and ConfigData.SectionExists(EnvVariablesKeyName) then
    begin
      EnvNames := TStringList.Create;
      try
        ConfigData.ReadSection(EnvVariablesKeyName, EnvNames);
        for I := 0 to EnvNames.Count - 1 do
        begin
          EnvVarKeyName := EnvNames[I];
          FEnvironmentVariables.Values[EnvVarKeyName] := ConfigData.ReadString(EnvVariablesKeyName, EnvVarKeyName, '');
        end;
      finally
        EnvNames.Free;
      end;
    end;
    if IsBDSPersonality then
    begin
      FEnvironmentVariables.Values['BDS'] := PathRemoveSeparator(RootDir);
      FEnvironmentVariables.Values['BDSPROJECTSDIR'] := DefaultProjectsDir;
    end
    else
      FEnvironmentVariables.Values[ToolNames[RADToolKind]] := PathRemoveSeparator(RootDir);
  end;
  Result := FEnvironmentVariables;
end;

function TJclBorRADToolInstallation.GetGlobals: TStrings;
begin
  Result := FGlobals;
end;

function TJclBorRADToolInstallation.GetIdeExeFileName: string;
{$IFDEF KYLIX}
const
  IdeFileNames: array [TJclBorRADToolKind] of string = (DelphiIdeExeName, BCBIdeExeName);
begin
  Result := FBinFolderName + IdeFileNames[RADToolKind];
end;
{$ENDIF KYLIX}
{$IFDEF MSWINDOWS}
begin
  Result := Globals.Values['App'];
end;
{$ENDIF MSWINDOWS}

function TJclBorRADToolInstallation.GetIdeExeBuildNumber: string;
begin
  {$IFDEF KYLIX}
  { TODO : determine Kylix IDE build # }
  Result := '?';
  {$ELSE}
  Result := VersionFixedFileInfoString(IdeExeFileName, vfFull);
  {$ENDIF KYLIX}
end;

function TJclBorRADToolInstallation.GetIdePackages: TJclBorRADToolIdePackages;
begin
  if not Assigned(FIdePackages) then
    FIdePackages := TJclBorRADToolIdePackages.Create(Self);
  Result := FIdePackages;
end;

function TJclBorRADToolInstallation.GetLatestUpdatePack: Integer;
begin
  Result := GetLatestUpdatePackForVersion(VersionNumber);
end;

class function TJclBorRADToolInstallation.GetLatestUpdatePackForVersion(Version: Integer): Integer;
begin
  // dummy; BCB doesn't like abstract class functions
  Result := 0;
end;

function TJclBorRADToolInstallation.GetLibrarySearchPath: TJclBorRADToolPath;
begin
  Result := ConfigData.ReadString(LibraryKeyName, LibrarySearchPathValueName, '');
end;

function TJclBorRADToolInstallation.GetLibraryBrowsingPath: TJclBorRADToolPath;
begin
  Result := ConfigData.ReadString(LibraryKeyName, LibraryBrowsingPathValueName, '');
end;

function TJclBorRADToolInstallation.GetName: string;
begin
  {$IFDEF KYLIX}
  Result := Format(RsKylixVersionName, [VersionNumber, RADToolName]);
  {$ELSE ~KYLIX}
  Result := Format('%s %d', [RADToolName, VersionNumber]);
  {$ENDIF ~KYLIX}
end;

function TJclBorRADToolInstallation.GetPalette: TJclBorRADToolPalette;
begin
  if not Assigned(FPalette) then
    FPalette := TJclBorRADToolPalette.Create(Self);
  Result := FPalette;
end;

function TJclBorRADToolInstallation.GetRepository: TJclBorRADToolRepository;
begin
  if not Assigned(FRepository) then
    FRepository := TJclBorRADToolRepository.Create(Self);
  Result := FRepository;
end;

function TJclBorRADToolInstallation.GetUpdateNeeded: Boolean;
begin
  Result := InstalledUpdatePack < LatestUpdatePack;
end;

function TJclBorRADToolInstallation.GetValid: Boolean;
begin
  Result := (ConfigData.FileName <> '') and (RootDir <> '') and FileExists(IdeExeFileName);
end;

function TJclBorRADToolInstallation.InstallPackage(const PackageName, BPLPath, DCPPath: string): Boolean;
var
  BPLFileName, Description, LibSuffix: string;
  RunOnly: Boolean;
begin
  Result := DCC.MakePackage(PackageName, BPLPath, DCPPath);
  if Result then
  begin
    GetDPKFileInfo(PackageName, RunOnly, @LibSuffix, @Description);
    if not RunOnly then
    begin
      BPLFileName := PathAddSeparator(BPLPath) + PathExtractFileNameNoExt(PackageName) + LibSuffix + '.bpl';
      Result := IdePackages.AddPackage(BPLFileName, Description);
    end;
  end;
end;

function TJclBorRADToolInstallation.UninstallPackage(const PackageName, BPLPath, DCPPath: string): Boolean;
var
  BPLFileName, DCPFileName: string;
  BaseName, LibSuffix: string;
  RunOnly, Success: Boolean;
begin
  GetDPKFileInfo(PackageName, RunOnly, @LibSuffix);
  BaseName := PathExtractFileNameNoExt(PackageName);
  BPLFileName := PathAddSeparator(BPLPath) + BaseName + LibSuffix + '.bpl';
  DCPFileName := PathAddSeparator(DCPPath) + BaseName + '.dcp';
  Result := FileDelete(BPLFileName) and FileDelete(DCPFileName);
  if not RunOnly then
  begin
    Success := IdePackages.RemovePackage(BPLFileName);
    Result := Result and Success;
  end;
end;

function TJclBorRADToolInstallation.IsBDSPersonality: Boolean;
begin
  {$IFDEF MSWINDOWS}
  Result := Pos('bds.exe', Globals.Values['App']) > 0;
  {$ELSE}
  Result := False;
  {$ENDIF MSWINDOWS}
end;

function TJclBorRADToolInstallation.LibFolderName: string;
begin
  Result := PathAddSeparator(RootDir) + PathAddSeparator('lib');
end;

function TJclBorRADToolInstallation.RemoveFromDebugDCUPath(const Path: string): Boolean;
var
  TempDebugDCUPath: TJclBorRADToolPath;
begin
  TempDebugDCUPath := DebugDCUPath;
  Result := RemoveFromPath(TempDebugDCUPath, Path);
  DebugDCUPath := TempDebugDCUPath;
end;

function TJclBorRADToolInstallation.RemoveFromLibrarySearchPath(const Path: string): Boolean;
var
  TempLibraryPath: TJclBorRADToolPath;
begin
  TempLibraryPath := LibrarySearchPath;
  Result := RemoveFromPath(TempLibraryPath, Path);
  LibrarySearchPath := TempLibraryPath;
end;

function TJclBorRADToolInstallation.RemoveFromLibraryBrowsingPath(const Path: string): Boolean;
var
  TempLibraryPath: TJclBorRADToolPath;
begin
  TempLibraryPath := LibraryBrowsingPath;
  Result := RemoveFromPath(TempLibraryPath, Path);
  LibraryBrowsingPath := TempLibraryPath;
end;

class function TJclBorRADToolInstallation.PackageSourceFileExtension: string;
begin
  Result := '';
  {$IFDEF MSWINDOWS}
  raise EAbstractError.CreateResFmt(@SAbstractError, ['']); // BCB doesn't support abstract keyword
  {$ENDIF MSWINDOWS}
end;

class function TJclBorRADToolInstallation.RADToolKind: TJclBorRADToolKind;
begin
  if InheritsFrom(TJclBCBInstallation) then
    Result := brCppBuilder
  else
    Result := brDelphi;
end;

class function TJclBorRADToolInstallation.RADToolName: string;
begin
  {$IFDEF MSWINDOWS}
  raise EAbstractError.CreateResFmt(@SAbstractError, ['']); // BCB doesn't support abstract keyword
  {$ENDIF MSWINDOWS}
end;

procedure TJclBorRADToolInstallation.ReadInformation;
const
  {$IFDEF KYLIX}
  BinDir = 'bin/';
  {$ELSE ~KYLIX}
  BinDir = 'bin\';
  {$ENDIF ~KYLIX}
  UpdateKeyName = 'Update #';
var
  KeyLen, I: Integer;
  Key: string;
  Ed: TJclBorRADToolEdition;
begin
  Key := ConfigData.FileName;
  {$IFDEF KYLIX}
  ConfigData.ReadSectionValues(GlobalsKeyName, Globals);
  {$ELSE ~KYLIX}
  RegGetValueNamesAndValues(HKEY_LOCAL_MACHINE, Key, Globals);

  KeyLen := Length(Key);
  if (KeyLen > 3) and StrIsDigit(Key[KeyLen - 2]) and (Key[KeyLen - 1] = '.') and (Key[KeyLen] = '0') then
    FIDEVersionNumber := Ord(Key[KeyLen - 2]) - Ord('0')
  else
    FIDEVersionNumber := 0;

  // BDS 3.0 goes as Delphi 9
  if IsBDSPersonality then
    FVersionNumber := FIDEVersionNumber + 6
  else
    FVersionNumber := FIDEVersionNumber;
  {$ENDIF ~KYLIX}

  FRootDir := Globals.Values[RootDirValueName];
  FBinFolderName := PathAddSeparator(RootDir) + BinDir;

  FEditionStr := Globals.Values[EditionValueName];
  if FEditionStr = '' then
    FEditionStr := Globals.Values[VersionValueName];
  for Ed := Low(Ed) to High(Ed) do
    if StrIPos(BorRADToolEditionIDs[Ed], FEditionStr) = 1 then
      FEdition := Ed;

  for I := 0 to Globals.Count - 1 do
  begin
    Key := Globals.Names[I];
    KeyLen := Length(UpdateKeyName);
    if (Pos(UpdateKeyName, Key) = 1) and (Length(Key) > KeyLen) and StrIsDigit(Key[KeyLen + 1]) then
      FInstalledUpdatePack := Max(FInstalledUpdatePack, Integer(Ord(Key[KeyLen + 1]) - 48));
  end;
end;

procedure TJclBorRADToolInstallation.SetDebugDCUPath(const Value: string);
begin
  ConfigData.WriteString(DebuggingKeyName, DebugDCUPathValueName, Value);
end;

procedure TJclBorRADToolInstallation.SetLibrarySearchPath(const Value: TJclBorRADToolPath);
begin
  ConfigData.WriteString(LibraryKeyName, LibrarySearchPathValueName, Value);
end;

procedure TJclBorRADToolInstallation.SetLibraryBrowsingPath(const Value: TJclBorRADToolPath);
begin
  ConfigData.WriteString(LibraryKeyName, LibraryBrowsingPathValueName, Value);
end;

function TJclBorRADToolInstallation.SubstitutePath(const Path: string): string;
var
  I: Integer;
  Name: string;
begin
  Result := Path;
  if Pos('$(', Result) > 0 then
    with EnvironmentVariables do
      for I := 0 to Count - 1 do
      begin
        Name := Names[I];
        Result := StringReplace(Result, Format('$(%s)', [Name]), Values[Name], [rfReplaceAll, rfIgnoreCase]);
      end;
  // remove duplicate path delimiters '\\'
  Result := StringReplace(Result, PathSeparator + PathSeparator, PathSeparator, [rfReplaceAll]);
end;

function TJclBorRADToolInstallation.SupportsVisualCLX: Boolean;
begin
  {$IFDEF KYLIX}
  Result := True;
  {$ELSE}
  Result := (Edition <> deSTD) and (VersionNumber in [6, 7]);
  {$ENDIF KYLIX}
end;

//=== { TJclBCBInstallation } ================================================

constructor TJclBCBInstallation.Create(const AConfigDataLocation: string);
begin
  inherited Create(AConfigDataLocation);
  FBpr2Mak := TJclBpr2Mak.Create(Self);
end;

destructor TJclBCBInstallation.Destroy;
begin
  FBpr2Mak.Free;
  inherited Destroy;
end;

{$IFDEF KYLIX}
function TJclBCBInstallation.ConfigFileName(const Extension: string): string;
begin
  Result := Format('%s/.borland/bcb%d%s', [GetPersonalFolder, IDs[VersionNumber], Extension]);
end;
{$ENDIF KYLIX}

class function TJclBCBInstallation.GetLatestUpdatePackForVersion(Version: Integer): Integer;
begin
  case Version of
    5: Result := 0;
    6: Result := 4;
  else
    Result := 0;
  end;
end;

function TJclBCBInstallation.InstallPackage(const PackageName, BPLPath, DCPPath: string): Boolean;
var
  SaveDir, PackagePath: string;
begin
  if IsDelphiPackage(PackageName) then
    Result := inherited InstallPackage(PackageName, BPLPath, DCPPath)
  else
  begin
    PackagePath := PathRemoveSeparator(ExtractFilePath(PackageName));
    SaveDir := GetCurrentDir;
    SetCurrentDir(PackagePath);
    try
      // Kylix bpr2mak doesn't like full file names
      Result := Bpr2Mak.Execute(StringsToStr(Bpr2Mak.Options, ' ') + ' ' + ExtractFileName(PackageName));
      Result := Result and Make.Execute(Format('%s -f%s', [StringsToStr(Make.Options, ' '), StrDoubleQuote(StrTrimQuotes(ChangeFileExt(PackageName, '.mak')))]));
    finally
      SetCurrentDir(SaveDir);
    end;
  end;
end;

class function TJclBCBInstallation.PackageSourceFileExtension: string;
begin
  Result := '.bpk';
end;

class function TJclBCBInstallation.RADToolName: string;
begin
  Result := RsBCBName;
end;

function TJclBCBInstallation.GetVclIncludeDir: string;
begin
  Result := RootDir + RsVclIncludeDir;
end;

//=== { TJclDelphiInstallation } =============================================

{$IFDEF KYLIX}
function TJclDelphiInstallation.ConfigFileName(const Extension: string): string;
begin
  Result := Format('%s/.borland/delphi%d%s', [GetPersonalFolder, IDs[VersionNumber], Extension]);
end;
{$ENDIF KYLIX}

class function TJclDelphiInstallation.GetLatestUpdatePackForVersion(Version: Integer): Integer;
begin
  case Version of
    5: Result := 1;
    6: Result := 2;
    7: Result := 0;
    9: Result := 0;
  else
    Result := 0;
  end;
end;

class function TJclDelphiInstallation.PackageSourceFileExtension: string;
begin
  Result := '.dpk';
end;

class function TJclDelphiInstallation.RADToolName: string;
begin
  Result := RsDelphiName;
end;

//=== { TJclBorRADToolInstallations } ======================================== 

constructor TJclBorRADToolInstallations.Create;
begin
  FList := TObjectList.Create;
  ReadInstallations;
end;

destructor TJclBorRADToolInstallations.Destroy;
begin
  FreeAndNil(FList);
  inherited Destroy;
end;

function TJclBorRADToolInstallations.AnyInstanceRunning: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Installations[I].AnyInstanceRunning then
    begin
      Result := True;
      Break;
    end;
end;

function TJclBorRADToolInstallations.AnyUpdatePackNeeded(var Text: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Installations[I].UpdateNeeded then
    begin
      Result := True;
      Text := Format(RsNeedUpdate, [Installations[I].LatestUpdatePack, Installations[I].Name]);
      Break;
    end;
end;

function TJclBorRADToolInstallations.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TJclBorRADToolInstallations.GetBCBInstallationFromVersion(VersionNumber: Integer): TJclBorRADToolInstallation;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Installations[I].VersionNumber = VersionNumber then
    begin
      Result := Installations[I];
      Break;
    end;
end;

function TJclBorRADToolInstallations.GetDelphiInstallationFromVersion(VersionNumber: Integer): TJclBorRADToolInstallation;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Installations[I].VersionNumber = VersionNumber then
    begin
      Result := Installations[I];
      Break;
    end;
end;

function TJclBorRADToolInstallations.GetInstallations(Index: Integer): TJclBorRADToolInstallation;
begin
  Result := TJclBorRADToolInstallation(FList[Index]);
end;

function TJclBorRADToolInstallations.GetBCBVersionInstalled(VersionNumber: Integer): Boolean;
begin
  Result := BCBInstallationFromVersion[VersionNumber] <> nil;
end;

function TJclBorRADToolInstallations.GetDelphiVersionInstalled(VersionNumber: Integer): Boolean;
begin
  Result := DelphiInstallationFromVersion[VersionNumber] <> nil;
end;

function TJclBorRADToolInstallations.Iterate(TraverseMethod: TTraverseMethod): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Count - 1 do
    Result := Result and TraverseMethod(Installations[I]);
end;

procedure TJclBorRADToolInstallations.ReadInstallations;
{$IFDEF KYLIX}
var
  I: Integer;

  procedure CheckForInstallation(RADToolKind: TJclBorRADToolKind; VersionNumber: Integer);
  const
    RcBaseFileNames: array [TJclBorRADToolKind] of string = ('delphi', 'bcb');
  var
    Item: TJclBorRADToolInstallation;
    RcFileName: string;
  begin
    RcFileName := Format('%s/.borland/%s%drc', [GetPersonalFolder, RcBaseFileNames[RADToolKind], IDs[VersionNumber]]);
    if FileExists(RcFileName) then
    begin
      if RADToolKind = brCppBuilder then
        Item := TJclBCBInstallation.Create(RcFileName)
      else
        Item := TJclDelphiInstallation.Create(RcFileName);
      Item.FVersionNumber := VersionNumber;
      FList.Add(Item);
    end;
  end;

begin
  FList.Clear;
  for I := Low(TKylixVersion) to High(TKylixVersion) do
    CheckForInstallation(brDelphi, I);
  CheckForInstallation(brCppBuilder, 3); // Kylix 3 only
end;
{$ELSE ~KYLIX}
var
  VersionNumbers: TStringList;

  procedure EnumVersions(const KeyName, Personality: string; CreateClass: TJclBorRADToolInstallationClass);
  var
    I: Integer;
    VersionKeyName: string;
  begin
    if RegKeyExists(HKEY_LOCAL_MACHINE, KeyName) and
      RegGetKeyNames(HKEY_LOCAL_MACHINE, KeyName, VersionNumbers) then
      for I := 0 to VersionNumbers.Count - 1 do
      begin
        VersionKeyName := KeyName + PathSeparator + VersionNumbers[I];
        if RegKeyExists(HKEY_LOCAL_MACHINE, VersionKeyName) then
        begin
          { TODO : Check if that works as assumed }
          if (Personality <> '') and (RegReadStringDef(HKEY_LOCAL_MACHINE, VersionKeyName + '\Personalities', Personality, '') = '') then
            Continue;
          FList.Add(CreateClass.Create(VersionKeyName));
        end;
      end;
  end;

begin
  FList.Clear;
  VersionNumbers := TStringList.Create;
  try
    EnumVersions(DelphiKeyName, '', TJclDelphiInstallation);
    EnumVersions(BDSKeyName, 'Delphi.Win32', TJclDelphiInstallation);
    EnumVersions(BCBKeyName, '', TJclBCBInstallation);
  finally
    VersionNumbers.Free;
  end;
end;
{$ENDIF ~KYLIX}

//=== { TJclCommandLineTool } ================================================

constructor TJclCommandLineTool.Create(const AExeName: string);
begin
  inherited Create;
  FOptions := TStringList.Create;
  FExeName := AExeName;
end;

destructor TJclCommandLineTool.Destroy;
begin
  FreeAndNil(FOptions);
  inherited Destroy;
end;

procedure TJclCommandLineTool.AddPathOption(const Option, Path: string);
var
  S: string;
begin
  S := PathRemoveSeparator(Path);
  {$IFDEF MSWINDOWS}
  S := LowerCase(S); // file names are case insensitive
  {$ENDIF MSWINDOWS}
  S := Format('-%s"%s"', [Option, S]);
  // avoid duplicate entries (note that search is case sensitive)
  if GetOptions.IndexOf(S) = -1 then
    GetOptions.Add(S);
end;

function TJclCommandLineTool.Execute(const CommandLine: string): Boolean;
begin
  if Assigned(FOutputCallback) then
    Result := JclSysUtils.Execute(Format('"%s" %s', [ExeName, CommandLine]), FOutputCallback) = 0
  else
    Result := JclSysUtils.Execute(Format('"%s" %s', [ExeName, CommandLine]), FOutput) = 0;
end;

function TJclCommandLineTool.GetExeName: string;
begin
  Result := FExeName;
end;

function TJclCommandLineTool.GetOptions: TStrings;
begin
  Result := FOptions;
end;

function TJclCommandLineTool.GetOutput: string;
begin
  Result := FOutput;
end;

function TJclCommandLineTool.GetOutputCallback: TTextHandler;
begin
  Result := FOutputCallback;
end;

procedure TJclCommandLineTool.SetOutputCallback(const CallbackMethod: TTextHandler);
begin
  FOutputCallback := CallbackMethod;
end;

// History:

// $Log: JclBorlandTools.pas,v $
// Revision 1.41  2005/03/22 03:36:09  rrossmair
// - fixed PathGetShortName usage for packages
// - TJclDCC.SetDefaultOptions extended for BCB
//
// Revision 1.40  2005/03/21 04:24:34  rrossmair
// - identifier mistake fixed (Kylix)
//
// Revision 1.39  2005/03/21 04:05:31  rrossmair
// - workarounds for DCC32 126 character path limit
//
// Revision 1.38  2005/03/14 04:03:21  rrossmair
// - fixed TJclBorRADToolIdePackages.RemovePackage
//
// Revision 1.37  2005/03/08 08:33:15  marquardt
// overhaul of exceptions and resourcestrings, minor style cleaning
//
// Revision 1.36  2005/02/27 07:27:47  marquardt
// changed interface names from I to IJcl, moved resourcestrings to JclResource.pas
//
// Revision 1.35  2005/02/24 16:34:39  marquardt
// remove divider lines, add section lines (unfinished)
//
// Revision 1.34  2005/02/23 07:53:13  rrossmair
// - added TJclDCC.SetDefaultOptions, which includes the path(s) normally found in $(DELPHI)\bin\dcc32.cfg.
// - AddPathOption() methods enhanced.
//
// Revision 1.33  2005/02/04 05:11:21  rrossmair
// - fixed TJclBorRADToolInstallation.UninstallPackage
//
// Revision 1.32  2005/02/04 04:49:08  rrossmair
// - fixed GetDPKFileInfo
// - more uninstall support
//
// Revision 1.31  2005/02/03 05:17:54  rrossmair
// - some uninstall support added
// - refactoring: TJclDCC.InstallPackage replaced by TJclDCC.MakelPackage, IDE installation part moved to TJclBorRADToolInstallation.InstallPackage
//
// Revision 1.30  2004/12/23 04:31:42  rrossmair
// - check-in for JCL 1.94 RC 1
//
// Revision 1.29  2004/12/20 05:15:48  rrossmair
// - fixed for Kylix ($IFDEFed GetBorlandStudioProjectsDir)
//
// Revision 1.28  2004/12/18 04:03:30  rrossmair
// - more D2005 support
//
// Revision 1.27  2004/12/16 19:56:58  rrossmair
// - fixed for Windows
//
// Revision 1.26  2004/12/15 22:54:04  rrossmair
// - fixed for Kylix
//
// Revision 1.25  2004/12/15 21:46:40  rrossmair
// - D2005 support (incomplete)
//
// Revision 1.24  2004/11/18 00:57:14  rrossmair
// - check-in for release 1.93
//
// Revision 1.23  2004/11/16 06:17:27  marquardt
// style cleaning
//
// Revision 1.22  2004/11/15 20:42:35  rrossmair
// - TJclBorRADToolInstallation.SubstitutePath: remove duplicate path delimiters
//
// Revision 1.21  2004/11/09 07:51:37  rrossmair
// - installer refactoring (incomplete)
//
// Revision 1.20  2004/10/25 06:58:44  rrossmair
// - fixed bug #0002065
// - outsourced JclMiscel.Win32ExecAndRedirectOutput() + JclBorlandTools.ExecAndRedirectOutput() code into JclSysUtils.Execute()
// - refactored this code
// - added overload to supply callback capability per line of output
//
// Revision 1.19  2004/10/17 05:23:06  rrossmair
// replaced PathGetLongName2() by PathGetLongName()
//
// Revision 1.18  2004/08/09 06:38:08  marquardt
// add JvWStrUtils.pas as JclWideStrings.pas
//
// Revision 1.17  2004/08/01 05:52:10  marquardt
// move constructors/destructors
//
// Revision 1.16  2004/07/30 07:20:24  marquardt
// fixing TStringLists, adding BeginUpdate/EndUpdate
//
// Revision 1.15  2004/07/28 18:00:48  marquardt
// various style cleanings, some minor fixes
//
// Revision 1.14  2004/07/14 03:36:20  rrossmair
// fixed bug #1897 ( TJclBorRADToolInstallation.GetEnvironmentVariables failure)
//
// Revision 1.13  2004/06/16 07:30:26  marquardt
// added tilde to all IFNDEF ENDIFs, inherited qualified
//
// Revision 1.12  2004/06/14 06:24:52  marquardt
// style cleaning IFDEF
//
// Revision 1.11  2004/05/13 16:38:45  rrossmair
// fixed for paths w/ spaces
//
// Revision 1.10  2004/05/11 11:55:43  rrossmair
// added TJclBCBInstallation.VclIncludeDir
//
// Revision 1.9  2004/05/08 08:44:17  rrossmair
// introduced & applied symbol HAS_UNIT_LIBC
//
// Revision 1.8  2004/05/05 00:04:10  mthoma
// Updated headers: Added donors as contributors, adjusted the initial authors, added cvs names when they were not obvious. Changed $data to $date where necessary,
//
// Revision 1.7  2004/04/18 05:15:07  rrossmair
// code clean-up
//

end.

