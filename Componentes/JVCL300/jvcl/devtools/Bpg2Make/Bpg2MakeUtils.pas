{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: Bpg2MakeUtils.pas, released on 2003-09-29.

The Initial Developer of the Original Code is Andreas Hausladen
(Andreas dott Hausladen att gmx dott de)
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: Bpg2MakeUtils.pas,v 1.16 2004/11/28 12:00:48 peter3 Exp $

{$I jvcl.inc}

unit Bpg2MakeUtils;

interface

procedure Run;
function CreateMakeFile(const Filename: string): Boolean;

implementation

uses
  Windows, Classes, SysUtils,
  JvConsts, JvSimpleXml;

const
  DefaultMakeFile =
    '#--------------------------------------------------------------------------------------------------#' + sLineBreak +
    '#                                                                                                  #' + sLineBreak +
    '# autogenerated makefile for Package Groups                                                        #' + sLineBreak +
    '#                                                                                                  #' + sLineBreak +
    '#--------------------------------------------------------------------------------------------------#' + sLineBreak +
    '' + sLineBreak +
    '!ifndef ROOT' + sLineBreak +
    'ROOT = $(MAKEDIR)\..' + sLineBreak +
    '!endif' + sLineBreak +
    '#--------------------------------------------------------------------------------------------------#' + sLineBreak +
    'MAKE = "$(ROOT)\bin\make.exe" -$(MAKEFLAGS) -f$**' + sLineBreak +
    'BRCC = "$(ROOT)\bin\brcc32.exe" $**' + sLineBreak +
    '' + sLineBreak +
    '!ifndef DCCOPT' + sLineBreak +
    'DCCOPT=-Q -M' + sLineBreak +
    '!endif' + sLineBreak +
    '' + sLineBreak +
    '!ifndef DCC' + sLineBreak +
    'DCC  = "$(ROOT)\bin\dcc32.exe" -U"$(DCPDIR)" -LE"$(DCPDIR)" -LN"$(DCPDIR)" $(DCCOPT) -Q -W -H -M $&.dpk' + sLineBreak +
    '!else' + sLineBreak +
    'DCC = "$(ROOT)\bin\dcc32.exe" $(DCCOPT) $&.dpk' + sLineBreak +
    '!endif' + sLineBreak +
    '' + sLineBreak +
    '#--------------------------------------------------------------------------------------------------#' + sLineBreak;

//--------------------------------------------------------------------------------------------------

function StrEqualText(Text: PChar; SearchText: PChar; MaxLen: Integer;
  IgnoreCase: Boolean): Boolean;
var
  i: Integer;
begin
  if IgnoreCase then
    Result := StrLIComp(Text, SearchText, MaxLen) = 0
  else
  begin 
    Result := False;
    for i := 0 to MaxLen - 1 do
      if (Text[i] = #0) or {(SearchText[i] = #0) or}
         (Text[i] <> SearchText[i]) then Exit;
    Result := True;
  end;
end;

function FastStringReplace(const Text, SearchText, ReplaceText: string;
  ReplaceAll, IgnoreCase: Boolean): string;
var
  LenSearchText, LenReplaceText, LenText: Integer;
  Index, Len, StartIndex: Integer;
begin
  LenSearchText := Length(SearchText);
  LenReplaceText := Length(ReplaceText);
  LenText := Length(Text);
  if LenSearchText = 0 then
  begin
    Result := Text;
    Exit;
  end;

  if ReplaceAll then
  begin
    if LenReplaceText - LenSearchText > 0 then
      SetLength(Result, LenText +
        (LenReplaceText - LenSearchText) * (LenText div LenSearchText))
    else
      SetLength(Result, LenText);
  end
  else
    SetLength(Result, LenText + (LenReplaceText - LenSearchText));

  Len := 0;
  StartIndex := 1;
  for Index := 1 to LenText do
  begin
    if StrEqualText(PChar(Pointer(Text)) + Index - 1, Pointer(SearchText),
                   LenSearchText, IgnoreCase) then
    begin
      if Index > StartIndex then
      begin
        Move(Text[StartIndex], Result[Len + 1], Index - StartIndex); 
        Inc(Len, Index - StartIndex); 
      end; 
      StartIndex := Index + LenSearchText; 

      if LenReplaceText > 0 then
      begin 
        Move(ReplaceText[1], Result[Len + 1], LenReplaceText); 
        Inc(Len, LenReplaceText); 
      end; 

      if not ReplaceAll then Break; 
    end;
  end; 

  Index := LenText + 1;
  if Index > StartIndex then
  begin
    Move(Text[StartIndex], Result[Len + 1], Index - StartIndex);
    Inc(Len, Index - StartIndex);
  end;

  SetLength(Result, Len);
end;

procedure ShowHelp;
begin
  writeln('');
  writeln('');
  writeln('Bpg2Make: Creates a MAKEFILE from a bpg/bdsgroup file');
  writeln('');
  writeln('Usage:');
  writeln(ExtractFilename(ParamStr(0)),' <bpgfile>');
  writeln('');
  writeln(#9'<bpgfile> - the Borland Package Group file');
end;

function GetReturnPath(const Dir: string): string;
var
  i: Integer;
begin
  Result := '';
  if Dir <> '' then
  begin
    Result := '..';
    for i := 1 to Length(Dir) do
      if Dir[i] = PathDelim then
        Result := Result + '\..';
  end;
end;

{$IFDEF COMPILER5}
type
  UTF8String = type string;
{$ENDIF COMPILER5}

function LoadUtf8File(const Filename: string): string;
var
  Content: UTF8String;
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(Content, Stream.Size);
    Stream.Read(Content[1], Stream.Size);
  finally
    Stream.Free;
  end;
  Delete(Content, 1, 3); // This a little bit dirty but unless we mix UTF8,
                         // UTF16 and ANSI files there is no problem.
  {$IFDEF COMPILER6_UP}
  Result := Utf8ToAnsi(Content);
  {$ELSE}
    { Delphi 5 (should) never reachs this because the Installer uses the newest
      installed Delphi version and only reads the project groups of installed
      Delphi/BCB/BDN versions. }
  Result := Content;
  {$ENDIF COMPILIER6_UP}
end;

procedure ProcessBdsgroupFile(const Filename: string; MkLines, Targets, Commands: TStrings);
var
  xml: TJvSimpleXML;
  Options, Projects: TJvSimpleXMLElem;
  i, OptIndex, PrjIndex: Integer;
  Personality: string;
  TgName: string;
begin
  xml := TJvSimpleXML.Create(nil);
  try
    xml.LoadFromString(LoadUtf8File(Filename));

    for i := 0 to xml.Root.Items.Count - 1 do
    begin
      if (CompareText(xml.Root.Items[i].Name, 'PersonalityInfo') = 0) and // <PersonalityInfo>
         (xml.Root.Items[i].Items.Count > 0) then
      begin
        // find correct Personality
        Options := xml.Root.Items[i].Items[0];
        if CompareText(Options.Name, 'Option') = 0 then
        begin
          for OptIndex := 0 to Options.Items.Count - 1 do
            if CompareText(Options.Items[OptIndex].Properties.Value('Name'), 'Personality') = 0 then
            begin
              Personality := Options.Items[OptIndex].Value;
              Break;
            end;
        end;
      end
      else
      if (CompareText(xml.Root.Items[i].Name, Personality) = 0) and
         (xml.Root.Items[i].Items.Count > 0) and
         (CompareText(xml.Root.Items[i].Items[0].Name, 'Projects') = 0) then
      begin
         // Read project list
         Projects := xml.Root.Items[i].Items[0];
         for PrjIndex := 0 to Projects.Items.Count - 1 do
         begin
           TgName := Projects.Items[PrjIndex].Properties.Value('Name');
           if CompareText(TgName, 'Targets') <> 0 then
           begin
             // change .bdsproj to .dpk and add the target
             Targets.Add(TgName + '=' + ChangeFileExt(Projects.Items[PrjIndex].Value, '.dpk'));
             Commands.Add(#9'$(DCC)');
           end;
         end;
      end;
    end;

    if Targets.Count > 1 then
    begin
      MkLines.Add('PROJECTS = ' + Targets.Names[0] + ' \');
      for i := 2 to Targets.Count - 2 do
        MkLines.Add(#9 + Targets.Names[i] + ' \');
      MkLines.Add(#9 + Targets.Names[Targets.Count - 1]);
    end
    else if Targets.Count = 1 then
      MkLines.Add('PROJECTS = ' + Targets.Names[0]);
  finally
    xml.Free;
  end;
end;

procedure ProcessBpgFile(const Filename: string; MkLines, Targets, Commands: TStrings);
var
  i, ps: Integer;
  List: TStringlist;
  S: string;
  ProjectCommands: string;
begin
  List := TStringList.Create;
  try
    List.LoadFromFile(Filename);
    i := 0;
    while i < List.Count do
    begin
      S := List[i];
      ps := Pos('bpl: ', S);
      if ps <> 0 then
      begin
        Targets.Add(Trim(Copy(S, 1, ps + 2)) + '=' + Trim(Copy(S, ps + 5, MaxInt)));
        ProjectCommands := '';
        Inc(i);
        while (i < List.Count) and (List[i] <> '') do
        begin
          ProjectCommands := ProjectCommands + #9 + Trim(List[i]) + #13#10;
          Inc(i);
        end;
        SetLength(ProjectCommands, Length(ProjectCommands) - 2);
        Commands.Add(ProjectCommands);
      end;

      if StrLIComp('PROJECTS =', PChar(S), 10) = 0 then
      begin
        s := Trim(S);
        MkLines.Add(S);
        while (i < List.Count) and (S <> '') and (S[Length(S)] = '\') do
        begin
          Inc(i);
          S := Trim(List[i]);
          MkLines.Add(#9 + S);
        end;
      end;
      Inc(i);
    end;
  finally
    List.Free;
  end;
end;


function CreateMakeFile(const Filename: string): Boolean;
var
  MkLines, Targets, Commands: TStrings;
  S, SourceFile, Dir, ProjectCommands: string;
  i, ps: Integer;
begin
  Result := False;
  if not FileExists(Filename) then
  begin
    WriteLn('ERROR: ', Filename, ' not found!');
    Exit;
  end;

  MkLines := TStringList.Create;
  Targets := TStringList.Create;
  Commands := TStringList.Create;
  try
    MkLines.Text := DefaultMakeFile;

    if CompareText(ExtractFileExt(Filename), '.bpg') = 0 then
      ProcessBpgFile(Filename, MkLines, Targets, Commands)
    else
      ProcessBdsgroupFile(Filename, MkLines, Targets, Commands);

    MkLines.Add('');
    MkLines.Add('#---------------------------------------------------------------------------------------------------');
    MkLines.Add('default: $(PROJECTS)');
    MkLines.Add('#---------------------------------------------------------------------------------------------------');
    MkLines.Add('');
    for i := 0 to Targets.Count - 1 do
    begin
      S := Targets[i];
      ps := Pos('=', S);
      SourceFile := Copy(S, ps + 1, MaxInt);
      SetLength(S, ps - 1);
      Dir := ExtractFileDir(SourceFile);
      MkLines.Add(S + ': ' + SourceFile);
      SourceFile := ExtractFileName(SourceFile);
      if Dir <> '' then
        MkLines.Add(#9'@cd ' + Dir);

      ProjectCommands := Commands[i];
      ProjectCommands := FastStringReplace(ProjectCommands, '$**', SourceFile, True, False);
      ProjectCommands := FastStringReplace(ProjectCommands, '$*',
            Copy(SourceFile, 1, Length(SourceFile) - Length(ExtractFileExt(SourceFile))), True, False);
     // long path name support
      ProjectCommands := FastStringReplace(ProjectCommands, '$(ROOT)\bin\bpr2mak', '"$(ROOT)\bin\bpr2mak"', False, True);
      ProjectCommands := FastStringReplace(ProjectCommands, '$(ROOT)\bin\make', '"$(ROOT)\bin\make"', False, True);

      MkLines.Add(#9'@echo [Compiling: ' + S + ']');
      MkLines.Add(ProjectCommands);
      MkLines.Add(#9'@echo.');
      if Dir <> '' then
        MkLines.Add(#9'@cd ' + GetReturnPath(Dir));
      MkLines.Add('');
    end;
    MkLines.SaveToFile(ChangeFileExt(FileName, '.mak'));
  finally
    Commands.Free;
    Targets.Free;
    MkLines.Free;
  end;
  Result := True;
end;

procedure Run;
var
  Ext: string;
begin
  Ext := LowerCase(ExtractFileExt(ParamStr(1)));
  if (ParamCount <> 1) or ((Ext <> '.bpg') and (Ext <> '.bdsgroup')) then
    ShowHelp
  else
  try
    if CreateMakeFile(ExpandUNCFileName(ParamStr(1))) then
      WriteLn(' Makefile created');
  except
    on E: Exception do
      WriteLn('ERROR: ', E.Message);
  end;
end;

end.

