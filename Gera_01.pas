unit Gera_01;

interface

uses Forms, Classes, WinProcs, Controls, Menus, ExtCtrls, Printers, Mask,
     FileCtrl, StdCtrls, SysUtils, Dialogs, graphics, FrmCompile, Variants;

procedure Gera_Dpr(Completo: Boolean);
procedure Gera_Princ(Completo: Boolean; TipoG: Integer);
procedure Gera_Princ_MenuSuperior;
procedure Gera_Princ_BarraF;
procedure Gera_Princ_TreeMenuSup;
procedure Gera_Princ_Inc;
procedure Gera_Princ_Dfm(Completo: Boolean; TipoG: Integer);
procedure Gera_Princ_Res(Completo: Boolean);
procedure Gera_Splash_Dfm(Completo: Boolean);
procedure Gera_Publicas(Completo: Boolean);
procedure Gera_Cabc(Programa, Titulo: String);
procedure Gera_Bat(Completo: Boolean);
procedure Gera_Bat_Adapter(Completo: Boolean);
procedure Gera_BaseDados;
procedure Gera_CTabelas(Global: Boolean);
procedure Gera_CConsultas(Global: Boolean);
procedure Gera_CScripts(Global: Boolean);
procedure Gera_CProcedures(Global: Boolean);
procedure Gera_CTriggers(Global: Boolean);
procedure Gera_CCalculos;
procedure Gera_Abertura;
procedure Gera_Adapter;
procedure Gera_Modelo(Formulario, Titulo, Tabela: String; TipoFrm: Integer; Atualiza: Boolean; FModelo: String);
Function ConvertFormOrText(FileToConvertFrom : string; Tipo: Integer) : boolean ;
function ComponentToString(Component: TComponent): string;
function StringToComponent(Value: string; Instance: TWinControl): TComponent;
function NomeFisicoCampo: String;
function NomeFisicoTabela: String;
function NomeFisicoObjeto: String;

implementation

uses Rotinas, Princ, Abertura, SynEdit, Tabela, IBQuery;

function NomeFisicoCampo: String;
begin
  NomeFisicoCampo := IIF(Trim(TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo)='',Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo),Trim(TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo));
end;

function NomeFisicoObjeto: String;
begin
//  NomeFisicoObjeto := IIF(Trim(TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo)='',Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo),Trim(TabGlobal_i.DCAMPOST.NOME_FISICO.Conteudo));
  NomeFisicoObjeto := Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo);
end;


function NomeFisicoTabela: String;
begin
  NomeFisicoTabela := iif(Trim(TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo) <> '', TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo, TabGlobal_i.DTABELAS.NOME.Conteudo);
end;

procedure Gera_Dpr(Completo: Boolean);
var
  SearchOptionsPd: TSynSearchOptions;
begin
  FormPrincipal.Texto.Lines.Clear;
  Gera_Cabc(ExtractFileName(Projeto.ArquivoProj),'Gerenciador dos Módulos do Projeto');
  FormPrincipal.Texto.Lines.Add('program '+Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-4)+';');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('uses');
  FormPrincipal.Texto.Lines.Add('  {$I LTab.Inc}');
  FormPrincipal.Texto.Lines.Add('  {$I AtrL.Inc}');
  FormPrincipal.Texto.Lines.Add('  WinTypes,');
  FormPrincipal.Texto.Lines.Add('  WinProcs,');
  FormPrincipal.Texto.Lines.Add('  SysUtils,');
  FormPrincipal.Texto.Lines.Add('  Rotinas in ' + #39 + 'ROTINAS.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  RotinaEd in ' + #39 + 'ROTINAED.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Extras in ' + #39 + 'EXTRAS.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Interno in ' + #39 + 'INTERNO.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Validar in ' + #39 + 'VALIDAR.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Publicas in ' + #39 + 'PUBLICAS.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Atributo in ' + #39 + 'ATRIBUTO.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Tabela in ' + #39 + 'TABELA.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Estrutur in ' + #39 + 'ESTRUTUR.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Calculos in ' + #39 + 'CALCULOS.PAS' + #39 + ',');
  //FormPrincipal.Texto.Lines.Add('  RFiltro in ' + #39 + 'RFILTRO.PAS' + #39 + ',');
  FormPrincipal.Texto.Lines.Add('  Forms,');
  FormPrincipal.Texto.Lines.Add('  Splash in '+ #39 + 'Splash.PAS' +#39 + ' {FormSplash},');
  FormPrincipal.Texto.Lines.Add('  Calend in '+ #39 + 'Calend.PAS' +#39 + ' {FormCalendario},');
  FormPrincipal.Texto.Lines.Add('  Calculad in '+ #39 + 'Calculad.PAS' +#39 + ' {FormCalculadora},');
  FormPrincipal.Texto.Lines.Add('  Acesso in '+ #39 + 'Acesso.PAS' +#39 + ' {FormAcesso},');
  FormPrincipal.Texto.Lines.Add('  Senhas in '+ #39 + 'Senhas.PAS' +#39 + ' {FormSenhas},');
  FormPrincipal.Texto.Lines.Add('  Sobre in '+ #39 + 'Sobre.PAS' +#39 + ' {FormSobre},');
  FormPrincipal.Texto.Lines.Add('  Princ in '+ #39 + 'Princ.PAS' +#39 + ' {FormPrincipal},');
  FormPrincipal.Texto.Lines.Add('  CfgEmp in '+ #39 + 'CfgEmp.PAS' +#39 + ' {FormConfiguraEmpresa},');
  FormPrincipal.Texto.Lines.Add('  SelEmp in '+ #39 + 'SelEmp.PAS' +#39 + ' {FormSelecionaEmpresa},');
  FormPrincipal.Texto.Lines.Add('  BatePapo in '+ #39 + 'BatePapo.PAS' +#39 + ' {FormBatePapo},');
  FormPrincipal.Texto.Lines.Add('  Agenda in '+ #39 + 'Agenda.PAS' +#39 + ' {FormAgenda},');
  FormPrincipal.Texto.Lines.Add('  AgEdit in '+ #39 + 'AgEdit.PAS' +#39 + ' {FormAgEdit},');
  FormPrincipal.Texto.Lines.Add('  EdUsr in '+ #39 + 'EdUsr.PAS' +#39 + ' {FormEdUsr},');
  FormPrincipal.Texto.Lines.Add('  EdGrp in '+ #39 + 'EdGrp.PAS' +#39 + ' {FormEdGrp},');
  FormPrincipal.Texto.Lines.Add('  Ambiente in '+ #39 + 'Ambiente.PAS' +#39 + ' {FormAmbiente},');
  FormPrincipal.Texto.Lines.Add('  Backup in '+ #39 + 'Backup.PAS' +#39 + ' {FormBackup},');
  FormPrincipal.Texto.Lines.Add('  Restaura in '+ #39 + 'Restaura.PAS' +#39 + ' {FormRestaura},');
  FormPrincipal.Texto.Lines.Add('  Filtro in '+ #39 + 'Filtro.PAS' +#39 + ' {FormFiltragem},');
  FormPrincipal.Texto.Lines.Add('  GridPesquisa in '+ #39 + 'GridPesquisa.PAS' +#39 + ' {FormGridPesquisa},');
  FormPrincipal.Texto.Lines.Add('  LogOperacoes in '+ #39 + 'LogOperacoes.PAS' +#39 + ' {FormLogOperacoes},');
  FormPrincipal.Texto.Lines.Add('  LogProcura in '+ #39 + 'LogProcura.PAS' +#39 + ' {FormLogProcura},');
  FormPrincipal.Texto.Lines.Add('  Aguarde in '+ #39 + 'Aguarde.PAS' +#39 + ' {FormAguarde},');
  FormPrincipal.Texto.Lines.Add('  Fr_View in '+ #39 + 'Fr_View.PAS' +#39 + ' {frPreviewForm},');
  FormPrincipal.Texto.Lines.Add('  OpcRel in '+ #39 + 'OpcRel.PAS' +#39 + ' {FormOpcRel},');
  TabGlobal_i.DFORMULARIO.First;
  while not TabGlobal_i.DFORMULARIO.Eof do
  begin
    if Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo) <> '' then
    begin
      FormPrincipal.Texto.CaretX := 1;
      FormPrincipal.Texto.CaretY := 1;
      FormPrincipal.Texto.SearchReplace('  '+TabGlobal_i.DFORMULARIO.NOME.Conteudo+' in ', '', SearchOptionsPd );
      if FormPrincipal.Texto.CaretX = 1 then
        FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DFORMULARIO.NOME.Conteudo+' in '+ #39 + TabGlobal_i.DFORMULARIO.NOME.Conteudo+'.PAS' +#39 + ' {Form'+TabGlobal_i.DFORMULARIO.NOME.Conteudo+'},');
    end;
    TabGlobal_i.DFORMULARIO.Next;
  end;
  FormPrincipal.Texto.Lines.Add('  Abertura in '+ #39 + 'Abertura.PAS' +#39 + ' {TabGlobal: TTabGlobal},');
  FormPrincipal.Texto.Lines.Add('  BaseD in '+ #39 + 'BaseD.PAS' +#39 + ' {BaseDados: TDataModule};');
  FormPrincipal.Texto.Lines.Add('');
  if TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo = 0 then
  begin
    FormPrincipal.Texto.Lines.Add('var');
    FormPrincipal.Texto.Lines.Add('  Hwnd : THandle;');
  end;
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('begin');
  if TabGlobal_i.DPROJETO.MULTIPLASINSTANCIAS.Conteudo = 0 then
  begin
    FormPrincipal.Texto.Lines.Add('  Hwnd := FindWindow(' + #39 + 'TApplication' + #39 + ', '+ #39 + TabGlobal_i.DPROJETO.TITULO_P.Conteudo + #39 + ');');
    FormPrincipal.Texto.Lines.Add('  if Hwnd = 0 then');
    FormPrincipal.Texto.Lines.Add('  begin');
    FormPrincipal.Texto.Lines.Add('    Application.Initialize;');
    FormPrincipal.Texto.Lines.Add('    Application.Title := '+ #39 + Projeto.Titulo + #39 + ';');
    FormPrincipal.Texto.Lines.Add('    Application.CreateForm(TFormPrincipal, FormPrincipal);');
    FormPrincipal.Texto.Lines.Add('    Application.CreateForm(TBaseDados, BaseDados);');
    FormPrincipal.Texto.Lines.Add('    Application.CreateForm(TTabGlobal, TabGlobal);');
    FormPrincipal.Texto.Lines.Add('    Application.Run;');
    FormPrincipal.Texto.Lines.Add('  end');
    FormPrincipal.Texto.Lines.Add('  else');
    FormPrincipal.Texto.Lines.Add('    SetForegroundWindow(Hwnd);');
  end
  else
  begin
    FormPrincipal.Texto.Lines.Add('  Application.Initialize;');
    FormPrincipal.Texto.Lines.Add('  Application.CreateForm(TFormPrincipal, FormPrincipal);');
    FormPrincipal.Texto.Lines.Add('  Application.CreateForm(TBaseDados, BaseDados);');
    FormPrincipal.Texto.Lines.Add('  Application.CreateForm(TTabGlobal, TabGlobal);');
    FormPrincipal.Texto.Lines.Add('  Application.Run;');
  end;
  FormPrincipal.Texto.Lines.Add('end.');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.ArquivoProj);
  FormPrincipal.Texto.Lines.Clear;
end;

procedure Gera_Princ_Inc;
var
  Lista_inc: TStringList;
  I: Integer;
  Inicio: Boolean;
begin
  Lista_inc := TStringList.Create;
  if FileExists(Projeto.Pasta + 'Princ.Inc') then
    Lista_inc.LoadFromFile(Projeto.Pasta + 'Princ.Inc');
  FormPrincipal.Texto.Lines.Clear;
  if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
    FormPrincipal.Texto.Lines.Add('{$DEFINE IBX}')
  else
    FormPrincipal.Texto.Lines.Add('{$DEFINE XSQL}');
  //case TabGlobal_i.DPROJETO.BDADOS.Conteudo of
  //  1: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_INTERBASE_FIREBIRD}');
  //  2: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_INTERBASE_FIREBIRD}');
  //  3: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_SQLBASE}');
  //  4: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_ORACLE}');
  //  5: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_SQLSERVER}');
  //  6: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_SYBASE}');
  //  7: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_DB2}');
  //  8: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_INFORMIX}');
  //  9: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_ODBC}');
  // 10: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_MYSQL}');
  // 11: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_POSTGRESQL}');
  // 12: FormPrincipal.Texto.Lines.Add('{$DEFINE DB_OLEDB}');
  //end;
  if TabGlobal_i.DPROJETO.CONTROLE_ACESSO_INTERNO.Conteudo = 1 then
    FormPrincipal.Texto.Lines.Add('{$DEFINE SENHA_DB}   // Controle de Acesso Interno');
  FormPrincipal.Texto.Lines.Add('{$IFDEF VER130}      // Delphi 5.0');
  FormPrincipal.Texto.Lines.Add('  {$DEFINE DELPHI5}');
  FormPrincipal.Texto.Lines.Add('{$ENDIF}');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('{$IFDEF VER140}      // Delphi 6.0');
  FormPrincipal.Texto.Lines.Add('  {$DEFINE DELPHI6}');
  FormPrincipal.Texto.Lines.Add('{$ENDIF}');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('{$IFDEF VER150}      // Delphi 7.0');
  FormPrincipal.Texto.Lines.Add('  {$DEFINE DELPHI7}');
  FormPrincipal.Texto.Lines.Add('{$ENDIF}');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('{$IFDEF VER170}      // Delphi 2005');
  FormPrincipal.Texto.Lines.Add('  {$DEFINE DELPHI9}');
  FormPrincipal.Texto.Lines.Add('{$ENDIF}');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('{$IFDEF VER180}      // Delphi/Turbo 2006');
  FormPrincipal.Texto.Lines.Add('  {$DEFINE DELPHI10}');
  FormPrincipal.Texto.Lines.Add('{$ENDIF}');
  Inicio := False;
  for I:=0 to Lista_inc.Count-1 do
  begin
    if Copy(LowerCase(Trim(Lista_inc[I])), 01, 06)  = '{00-in' then
      Inicio := True;
    if Inicio then
      FormPrincipal.Texto.Lines.Add(Lista_inc[I]);
  end;
  if not Inicio then
    FormPrincipal.Texto.Lines.Add('{00-Início do Bloco Avulso, as codificações abaixo serão preservadas}');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Inc');
  FormPrincipal.Texto.Lines.Clear;
  Lista_inc.Free;
end;

procedure Gera_Princ(Completo: Boolean; TipoG: Integer);
var
  I,Y,J: Integer;
  Bloco, Inicio, Primeira: Boolean;
begin
  Gera_Dpr(False);
  if Completo then
  begin
    CopiaArquivo(Projeto.PastaFontes + 'Princ.Pas', Projeto.Pasta + 'Princ.Pas');
    CopiaArquivo(Projeto.PastaFontes + 'Princ.Dfm', Projeto.Pasta + 'Princ.Dfm');
    CopiaArquivo(Projeto.PastaFontes + 'Princ.Res', Projeto.Pasta + 'Princ.Res');
  end;
  Gera_Princ_Dfm(Completo, TipoG);
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DMENU.Filtro := '';
  TabGlobal_i.DMENU.AtualizaSql;
  TabGlobal_i.DMENU.First;

  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Pas');
  Bloco := False;
  Inicio := True;

  for Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if ((Pos('mnu_',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) and
        (Pos(': tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0)) or
       ((Pos('bar_',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) and
        (Pos(': ttoolbutton;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0)) or
       (Pos('manutencao: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('localizar: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('incluir: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('modificar: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('excluir: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('primeiro: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('anterior: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('proximo: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('ultimo: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('consulta: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('filtrar: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('ordenar: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('ordenarcomposto: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('apagarcoluna: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('quantificar: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('totalizarcoluna: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('calcularmedia: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('imprimir: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('salvarconsulta: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) or
       (Pos('excluirconsulta: tmenuitem;',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0) then
     else
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
  end;
  FormPrincipal.Texto2.Lines.Clear;
  FormPrincipal.Texto2.Lines.AddStrings(FormPrincipal.Texto.Lines);
  FormPrincipal.Texto.Lines.Clear;
  for Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if Pos('%EMPRESA',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Empresa....: '+TabGlobal_i.DPROJETO.EMPRESA.Conteudo;
    if Pos('%MODULO',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Módulo.....: Princ.Pas - Formulário Principal';
    if Pos('%TITULO',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Sistema....: '+Projeto.Titulo;
    if Pos('%DATA',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Data.......: '+DateToStr(Date);
    if Pos('%VERSAOPROJETO',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Versão.....: '+TabGlobal_i.DPROJETO.VERSAO_P.Conteudo;
    if Pos('%ANALISTA',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Analista...: '+TabGlobal_i.DPROJETO.ANALISTA.Conteudo;
    if Pos('%PROGRAMADOR',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Programador: '+TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo;
    if Pos('%VERSAOGERADOR',FormPrincipal.Texto2.Lines[Y]) > 0 then
      FormPrincipal.Texto2.Lines[Y] := ' Criação....: xMaker '+Projeto.VersaoGerador + ' Release: ' + Projeto.ReleaseGerador;
    if Pos('{01-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      Bloco := True;
    end
    else if Pos('tformprincipal = class',LowerCase(FormPrincipal.Texto2.Lines[Y])) > 0 then
    begin
      TabGlobal_i.DMENUSUP.First;
      if not TabGlobal_i.DMENUSUP.Eof then
      begin
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
        while not TabGlobal_i.DMENUSUP.Eof do
        begin
          if Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo) <> '' then
            FormPrincipal.Texto.Lines.Add('    '+Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo)+': TMenuItem;');
          TabGlobal_i.DMENUSUP.Next;
        end;
        TabGlobal_i.DBARRA.First;
        TabGlobal_i.DBARRA.Next;
        while not TabGlobal_i.DBARRA.Eof do
        begin
          if Trim(TabGlobal_i.DBARRA.NOME.Conteudo) <> '' then
            FormPrincipal.Texto.Lines.Add('    '+Trim(TabGlobal_i.DBARRA.NOME.Conteudo)+': TToolButton;');
          TabGlobal_i.DBARRA.Next;
        end;
        Bloco := False;
      end
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      continue;
    end
    else if Pos('{02-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      TabGlobal_i.DMENUSUP.First;
      if not TabGlobal_i.DMENUSUP.Eof then
      begin
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
        while not TabGlobal_i.DMENUSUP.Eof do
        begin
          if (Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo) <> '') and
            (Trim(TabGlobal_i.DMENUSUP.AVULSO.Conteudo.Text) <> '') then
            FormPrincipal.Texto.Lines.Add('    procedure '+Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo)+'Click(Sender: TObject);');
          TabGlobal_i.DMENUSUP.Next;
        end;
        TabGlobal_i.DBARRA.First;
        TabGlobal_i.DBARRA.Next;
        while not TabGlobal_i.DBARRA.Eof do
        begin
          if (Trim(TabGlobal_i.DBARRA.NOME.Conteudo) <> '') and
             (Trim(TabGlobal_i.DBARRA.AVULSO.Conteudo.Text) <> '') then
            FormPrincipal.Texto.Lines.Add('    procedure '+Trim(TabGlobal_i.DBARRA.NOME.Conteudo)+'Click(Sender: TObject);');
          TabGlobal_i.DBARRA.Next;
        end;
        Bloco := True;
      end;
    end
    else if Pos('{10-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      TabGlobal_i.DMENU.First;
      while not TabGlobal_i.DMENU.Eof do
      begin
        if TabGlobal_i.DMENU.TIPO.Conteudo <> 1 then
          FormPrincipal.Texto.Lines.Add('    procedure '+Trim(TabGlobal_i.DMENU.NOME.Conteudo)+'Click(Opcao: Integer);');
        TabGlobal_i.DMENU.Next;
      end;
      Bloco := True;
    end;
    if Pos('{20-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      TabGlobal_i.DFORMULARIO.Filtro := '';
      TabGlobal_i.DFORMULARIO.AtualizaSql;
      TabGlobal_i.DFORMULARIO.First;
      while not TabGlobal_i.DFORMULARIO.Eof do
      begin
        if Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo) <> '' then
          FormPrincipal.Texto.Lines.Add('     '+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+',');
        TabGlobal_i.DFORMULARIO.Next;
      end;
      {TabGlobal_i.DMENU.First;
      while not TabGlobal_i.DMENU.Eof do
      begin
        if TabGlobal_i.DMENU.FORMULARIO.Conteudo > 0 then
        begin
          TabGlobal_i.DFORMULARIO.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DMENU.FORMULARIO.Conteudo);
          TabGlobal_i.DFORMULARIO.AtualizaSql;
          TabGlobal_i.DFORMULARIO.First;
          if not TabGlobal_i.DFORMULARIO.eof then
            FormPrincipal.Texto.Lines.Add('     '+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+',');
        end;
        TabGlobal_i.DMENU.Next;
      end;}
      Bloco := True;
    end;
    if Pos('{30-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Primeira := True;
      I:=0;
      TabGlobal_i.DMENU.First;
      while not TabGlobal_i.DMENU.Eof do
      begin
        if TabGlobal_i.DMENU.TIPO.Conteudo <> 1 then
        begin
          if Primeira then
            FormPrincipal.Texto.Lines.Add('  if TreeOpcoes.Selected.AbsoluteIndex = '+IntToStr(I)+' then')
          else
            FormPrincipal.Texto.Lines.Add('  else if TreeOpcoes.Selected.AbsoluteIndex = '+IntToStr(I)+' then');
          FormPrincipal.Texto.Lines.Add('    '+Trim(TabGlobal_i.DMENU.NOME.Conteudo)+'Click('+IntToStr(TabGlobal_i.DMENU.IDENTIFICACAO.Conteudo)+')');
          //FormPrincipal.Texto.Lines.Add('    '+Trim(TabGlobal_i.DMENU.NOME.Conteudo)+'Click(TreeOpcoes.Selected.AbsoluteIndex)');
          Primeira := False;
        end;
        Inc(I);
        TabGlobal_i.DMENU.Next;
      end;
      if not Primeira then
        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] + ';';
      Bloco := True;
    end;
    if Pos('{40-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      I:=0;
      TabGlobal_i.DMENU.First;
      while not TabGlobal_i.DMENU.Eof do
      begin
        if TabGlobal_i.DMENU.TIPO.Conteudo <> 1 then
        begin
          FormPrincipal.Texto.Lines.Add('procedure TFormPrincipal.'+Trim(TabGlobal_i.DMENU.NOME.Conteudo)+'Click(Opcao: Integer);');
          if TabGlobal_i.DMENU.TIPO.Conteudo = 2 then
          begin
            FormPrincipal.Texto.Lines.Add('begin');
            FormPrincipal.Texto.Lines.Add('  if not LiberaAcesso(Opcao) then');
            FormPrincipal.Texto.Lines.Add('    Abort;');
            TabGlobal_i.DFORMULARIO.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DMENU.FORMULARIO.Conteudo);
            TabGlobal_i.DFORMULARIO.AtualizaSql;
            TabGlobal_i.DFORMULARIO.First;
            if not TabGlobal_i.DFORMULARIO.eof then
            begin
              if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 2) or
                 (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) or
                 (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) or
                 (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 6) or
                 (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
              begin
                FormPrincipal.Texto.Lines.Add('  Form'+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+' := TForm'+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+'.Create(Application);');
                FormPrincipal.Texto.Lines.Add('  Try');
                FormPrincipal.Texto.Lines.Add('    Form'+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+'.ShowModal;');
                FormPrincipal.Texto.Lines.Add('  Finally');
                FormPrincipal.Texto.Lines.Add('    Form'+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+'.Free;');
                FormPrincipal.Texto.Lines.Add('  end;');
              end
              else
                FormPrincipal.Texto.Lines.Add('  ExecutaForm(TForm'+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+',Form'+Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo)+');');
            end
            else
              FormPrincipal.Texto.Lines.Add('');
            FormPrincipal.Texto.Lines.Add('end;');
          end
          else if TabGlobal_i.DMENU.TIPO.Conteudo = 3 then
          begin
            for J:=0 to TabGlobal_i.DMENU.AVULSO.Conteudo.Count-1 do
              FormPrincipal.Texto.Lines.Add(TabGlobal_i.DMENU.AVULSO.Conteudo[J]);
          end
          else if TabGlobal_i.DMENU.TIPO.Conteudo = 4 then
          begin
            FormPrincipal.Texto.Lines.Add('begin');
            FormPrincipal.Texto.Lines.Add('  WinExec('+#39+Trim(TabGlobal_i.DMENU.PROG_EXE.Conteudo)+#39+',SW_MAXIMIZE);');
            FormPrincipal.Texto.Lines.Add('end;');
          end;
          FormPrincipal.Texto.Lines.Add('');
        end;
        Inc(I);
        TabGlobal_i.DMENU.Next;
      end;
      Bloco := True;
    end;
    if Pos('{50-Início',FormPrincipal.Texto2.Lines[Y]) > 0 then
    begin
      TabGlobal_i.DMENUSUP.First;
      if not TabGlobal_i.DMENUSUP.Eof then
      begin
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
        while not TabGlobal_i.DMENUSUP.Eof do
        begin
          if (Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo) <> '') and
             (Trim(TabGlobal_i.DMENUSUP.AVULSO.Conteudo.Text) <> '') then
            begin
              FormPrincipal.Texto.Lines.Add('procedure TFormPrincipal.'+Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo)+'Click(Sender: TObject);');
              for I:=0 to TabGlobal_i.DMENUSUP.AVULSO.Conteudo.Count -1 do
                FormPrincipal.Texto.Lines.Add(TabGlobal_i.DMENUSUP.AVULSO.Conteudo[I]);
            end;
          TabGlobal_i.DMENUSUP.Next;
        end;
        TabGlobal_i.DBARRA.First;
        TabGlobal_i.DBARRA.Next;
        while not TabGlobal_i.DBARRA.Eof do
        begin
          if (Trim(TabGlobal_i.DBARRA.NOME.Conteudo) <> '') and
             (Trim(TabGlobal_i.DBARRA.AVULSO.Conteudo.Text) <> '') then
            begin
              FormPrincipal.Texto.Lines.Add('procedure TFormPrincipal.'+Trim(TabGlobal_i.DBARRA.NOME.Conteudo)+'Click(Sender: TObject);');
              for I:=0 to TabGlobal_i.DBARRA.AVULSO.Conteudo.Count -1 do
               FormPrincipal.Texto.Lines.Add(TabGlobal_i.DBARRA.AVULSO.Conteudo[I]);
            end;
          TabGlobal_i.DBARRA.Next;
        end;
        Bloco := True;
      end;
    end;
    if Pos('{99-Final',FormPrincipal.Texto2.Lines[Y]) > 0 then
      Bloco := False;
    if Not Bloco then
    begin
      if Inicio then
        FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[Y]
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Pas');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Princ_Dfm(Completo: Boolean; TipoG: Integer);
var
  Bloco: Boolean;
  NrBloco: Integer;
  FimBloco1, FimBloco2: Boolean;
  Y,I: Integer;
  IniTree, Inicio : Boolean;
  SomaTree: String;
  I_Img,F_Img: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Dfm');
  Bloco := False;
  FimBloco1 := False;
  FimBloco2 := False;
  Inicio    := True;
  For Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if (Bloco) and (Trim(FormPrincipal.Texto2.Lines[Y]) =
                    'end') then
    begin
      if NrBloco = 01 then
        Bloco := False
      else if NrBloco = 02 then
        Bloco := False;
    end;
    if Trim(FormPrincipal.Texto2.Lines[Y]) =
       'object TreeOpcoes: TTreeView' then
    begin
      if (TipoG = 0) or (TipoG = 2) then
      begin
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
        NrBloco := 01;
        Bloco := True;
      end;
    end;
    if Trim(FormPrincipal.Texto2.Lines[Y]) =
       'object ImagemFundo: TImage' then
    begin
      if (TipoG = 0) or (TipoG = 1) then
      begin
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
        NrBloco := 02;
        Bloco := True;
      end;
    end;
    if (Bloco) and (NrBloco = 01) and (not FimBloco1) then
    begin
      FormPrincipal.Texto.Lines.Add('      Left = 2');
      FormPrincipal.Texto.Lines.Add('      Top = 18');
      FormPrincipal.Texto.Lines.Add('      Width = 138');
      FormPrincipal.Texto.Lines.Add('      Height = 261');
      FormPrincipal.Texto.Lines.Add('      BorderStyle = bsNone');
      FormPrincipal.Texto.Lines.Add('      Font.Charset = DEFAULT_CHARSET');
      FormPrincipal.Texto.Lines.Add('      Font.Color = clBlack');
      FormPrincipal.Texto.Lines.Add('      Font.Height = -11');
      FormPrincipal.Texto.Lines.Add('      Font.Name = '+#39+'MS Sans Serif'+#39);
      FormPrincipal.Texto.Lines.Add('      Font.Style = []');
      FormPrincipal.Texto.Lines.Add('      HotTrack = True');
      FormPrincipal.Texto.Lines.Add('      HideSelection = False');
      FormPrincipal.Texto.Lines.Add('      Images = ListaImagem');
      FormPrincipal.Texto.Lines.Add('      Indent = 19');
      FormPrincipal.Texto.Lines.Add('      ParentFont = False');
      FormPrincipal.Texto.Lines.Add('      ReadOnly = True');
      FormPrincipal.Texto.Lines.Add('      ShowRoot = True');
      FormPrincipal.Texto.Lines.Add('      TabOrder = 1');
      FormPrincipal.Texto.Lines.Add('      OnClick = TreeOpcoesClick');
      FormPrincipal.Texto.Lines.Add('      OnKeyPress = TreeOpcoesKeyPress');
      IniTree  := False;
      SomaTree := '      Items.Data = ';
      if Trim(StrCompTree) <> '' then
      begin
        I_Img := Pos('{',StrCompTree);
        F_Img := Pos('}',StrCompTree);
        if (I_Img > 0) and (I_Img > 0) then
          SomaTree := SomaTree + Copy(StrCompTree,I_Img,(F_Img-I_Img)+1);
        if SomaTree <> '      Items.Data = ' then
          FormPrincipal.Texto.Lines.Add(SomaTree);
      end;
      FimBloco1 := True;
    end;
    if (Bloco) and (NrBloco = 02) and (not FimBloco2) then
    begin
      FormPrincipal.Texto.Lines.Add('      Left = 0');
      FormPrincipal.Texto.Lines.Add('      Top = 0');
      FormPrincipal.Texto.Lines.Add('      Width = 421');
      FormPrincipal.Texto.Lines.Add('      Height = 280');
      FormPrincipal.Texto.Lines.Add('      Align = alClient');
      FormPrincipal.Texto.Lines.Add('      AutoSize = True');
      FormPrincipal.Texto.Lines.Add('      Center = True');
      FormPrincipal.Texto.Lines.Add('      Transparent = True');
      IniTree  := False;
      SomaTree := '      Picture.Data = ';
      if Trim(StrCompImFundo) <> '' then
      begin
        I_Img := Pos('{',StrCompImFundo);
        F_Img := Pos('}',StrCompImFundo);
        if (I_Img > 0) and (I_Img > 0) then
          SomaTree := SomaTree + Copy(StrCompImFundo,I_Img,(F_Img-I_Img)+1);
        if SomaTree <> '      Picture.Data = ' then
          FormPrincipal.Texto.Lines.Add(SomaTree);
      end;
      FimBloco2 := True;
    end;
    if Not Bloco then
    begin
      if Inicio then
        FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[Y]
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  StrCompImFundo := '';
  StrCompTree    := '';
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Dfm');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Princ_MenuSuperior;
var
  Bloco: Boolean;
  NrBloco: Integer;
  FimBloco1, FimBloco2: Boolean;
  Y,I,Z: Integer;
  IniTree, Inicio : Boolean;
  Espaco,Ult_Linha: String;
  I_Img,F_Img, Ult_Nivel: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Dfm');
  Bloco := False;
  FimBloco1 := False;
  FimBloco2 := False;
  Inicio    := True;
  For Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if (Bloco) and (TrimRight(FormPrincipal.Texto2.Lines[Y]) =
                    '  end') then
    begin
      if NrBloco = 01 then
        Bloco := False
      else if NrBloco = 02 then
        Bloco := False;
    end;
    if Trim(FormPrincipal.Texto2.Lines[Y]) =
       'object MenuPrincipal: TMainMenu' then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      NrBloco := 01;
      Bloco := True;
    end;
    if (Bloco) and (NrBloco = 01) and (not FimBloco1) then
    begin
      FormPrincipal.Texto.Lines.Add('    Images = ListaImagem');
      FormPrincipal.Texto.Lines.Add('    Left = 233');
      FormPrincipal.Texto.Lines.Add('    Top = 58');
      TabGlobal_i.DMENUSUP.Filtro := '';
      TabGlobal_i.DMENUSUP.AtualizaSql;
      TabGlobal_i.DMENUSUP.First;
      Ult_Linha := '';
      while not TabGlobal_i.DMENUSUP.Eof do
      begin
        Espaco := '';
        for Z:=0 to TabGlobal_i.DMENUSUP.NIVEL_M.Conteudo * 2 do
          Espaco := Espaco + ' ';
        Espaco := Espaco + Space(20);
        for Z:=0 to 9 do
        begin
          Espaco := Copy(Espaco,01,Length(Espaco)-02);
          if Copy(Ult_Linha,01,Length(Espaco + '     ')) = Espaco + '     ' then
          begin
            FormPrincipal.Texto.Lines.Add(Espaco + '   end');
            Ult_Linha := FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1];
          end;
        end;
        FormPrincipal.Texto.Lines.Add(Espaco + '   object '+Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo)+': TMenuItem');
        FormPrincipal.Texto.Lines.Add(Espaco + '     Tag = '+IntToStr(TabGlobal_i.DMENUSUP.IDENTIFICACAO.Conteudo));
        FormPrincipal.Texto.Lines.Add(Espaco + '     Caption = '+#39+TabGlobal_i.DMENUSUP.TITULO_M.Conteudo+#39);
        FormPrincipal.Texto.Lines.Add(Espaco + '     Hint = '+#39+TabGlobal_i.DMENUSUP.TITULO_M.Conteudo+#39);
        if TabGlobal_i.DMENUSUP.IMAGEM.Conteudo > -1 then
          FormPrincipal.Texto.Lines.Add(Espaco + '     ImageIndex = '+IntToStr(TabGlobal_i.DMENUSUP.IMAGEM.Conteudo));
        if Trim(TabGlobal_i.DMENUSUP.PROG_EXE.Conteudo) <> '' then
          FormPrincipal.Texto.Lines.Add(Espaco + '     ShortCut = '+IntToStr(TextToShortCut(Trim(TabGlobal_i.DMENUSUP.PROG_EXE.Conteudo))));
        if Trim(TabGlobal_i.DMENUSUP.AVULSO.Conteudo.Text) <> '' then
          FormPrincipal.Texto.Lines.Add(Espaco + '     OnClick = '+Trim(TabGlobal_i.DMENUSUP.NOME.Conteudo)+'Click');
        Ult_Nivel := TabGlobal_i.DMENUSUP.NIVEL_M.Conteudo;
        TabGlobal_i.DMENUSUP.Next;
        if TabGlobal_i.DMENUSUP.NIVEL_M.Conteudo <= Ult_Nivel then
          FormPrincipal.Texto.Lines.Add(Espaco + '   end');
        Ult_Linha := FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1];
      end;
      Ult_Linha := FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1];
      Espaco := Space(21);
      for Z:=0 to 9 do
      begin
        Espaco := Copy(Espaco,01,Length(Espaco)-02);
        if Copy(Ult_Linha,01,Length(Espaco + '     ')) = Espaco + '     ' then
        begin
          FormPrincipal.Texto.Lines.Add(Espaco + '   end');
          Ult_Linha := FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1];
        end;
      end;
      //if Ult_Linha <> '    end' then
      //  FormPrincipal.Texto.Lines.Add(Espaco + '    end');
      FimBloco1 := True;
    end;
    if Not Bloco then
    begin
      if Inicio then
        FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[Y]
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  StrCompImFundo := '';
  StrCompTree    := '';
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Dfm');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Princ_BarraF;
var
  Bloco: Boolean;
  NrBloco: Integer;
  FimBloco1, FimBloco2: Boolean;
  Y,I,Z: Integer;
  IniTree, Inicio : Boolean;
  Espaco,Ult_Linha: String;
  I_Img,F_Img, Ult_Nivel: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Dfm');
  Bloco := False;
  FimBloco1 := False;
  FimBloco2 := False;
  Inicio    := True;
  For Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if (Bloco) and (TrimRight(FormPrincipal.Texto2.Lines[Y]) =
                    '  end') then
    begin
      if NrBloco = 01 then
        Bloco := False
      else if NrBloco = 02 then
        Bloco := False;
    end;
    if Trim(FormPrincipal.Texto2.Lines[Y]) =
       'object BarraFerramentas: TToolBar' then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      NrBloco := 01;
      Bloco := True;
    end;
    if (Bloco) and (NrBloco = 01) and (not FimBloco1) then
    begin
      FormPrincipal.Texto.Lines.Add('    Left = 0');
      FormPrincipal.Texto.Lines.Add('    Top = 0');
      FormPrincipal.Texto.Lines.Add('    Width = 569');
      FormPrincipal.Texto.Lines.Add('    Height = 24');
      FormPrincipal.Texto.Lines.Add('    AutoSize = True');
      FormPrincipal.Texto.Lines.Add('    Caption = '+#39+'BarraFerramentas'+#39);
      FormPrincipal.Texto.Lines.Add('    EdgeBorders = [ebTop, ebBottom]');
      FormPrincipal.Texto.Lines.Add('    Flat = True');
      FormPrincipal.Texto.Lines.Add('    Images = ListaImagem');
      FormPrincipal.Texto.Lines.Add('    ParentShowHint = False');
      FormPrincipal.Texto.Lines.Add('    ShowHint = True');
      FormPrincipal.Texto.Lines.Add('    TabOrder = 6');
      TabGlobal_i.DBARRA.Filtro := '';
      TabGlobal_i.DBARRA.AtualizaSql;
      TabGlobal_i.DBARRA.First;
      TabGlobal_i.DBARRA.Next;
      Ult_Nivel := 0;
      while not TabGlobal_i.DBARRA.Eof do
      begin
        FormPrincipal.Texto.Lines.Add('    object '+Trim(TabGlobal_i.DBARRA.NOME.Conteudo)+': TToolButton');
        FormPrincipal.Texto.Lines.Add('      Tag = '+IntToStr(TabGlobal_i.DBARRA.IDENTIFICACAO.Conteudo));
        FormPrincipal.Texto.Lines.Add('      Left = '+IntToStr(Ult_Nivel));
        FormPrincipal.Texto.Lines.Add('      Top = 0');
        FormPrincipal.Texto.Lines.Add('      Hint = '+#39+TabGlobal_i.DBARRA.TITULO_M.Conteudo+#39);
        if Trim(TabGlobal_i.DBARRA.TITULO_M.Conteudo) = '-' then
          FormPrincipal.Texto.Lines.Add('      Width = 8');
        FormPrincipal.Texto.Lines.Add('      Caption = '+#39+TabGlobal_i.DBARRA.TITULO_M.Conteudo+#39);
        if TabGlobal_i.DBARRA.IMAGEM.Conteudo > -1 then
          FormPrincipal.Texto.Lines.Add('      ImageIndex = '+IntToStr(TabGlobal_i.DBARRA.IMAGEM.Conteudo));
        if Trim(TabGlobal_i.DBARRA.TITULO_M.Conteudo) = '-' then
        begin
          FormPrincipal.Texto.Lines.Add('      Style = tbsSeparator');
          Inc(Ult_Nivel,8);
        end
        else
          Inc(Ult_Nivel,23);
        if Trim(TabGlobal_i.DBARRA.AVULSO.Conteudo.Text) <> '' then
          FormPrincipal.Texto.Lines.Add('      OnClick = '+Trim(TabGlobal_i.DBARRA.NOME.Conteudo)+'Click');
        TabGlobal_i.DBARRA.Next;
        FormPrincipal.Texto.Lines.Add('    end');
      end;
      FimBloco1 := True;
    end;
    if Not Bloco then
    begin
      if Inicio then
        FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[Y]
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  StrCompImFundo := '';
  StrCompTree    := '';
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Dfm');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Princ_TreeMenuSup;
var
  Bloco: Boolean;
  NrBloco: Integer;
  FimBloco1, FimBloco2: Boolean;
  Y,I: Integer;
  IniTree, Inicio : Boolean;
  SomaTree: String;
  I_Img,F_Img: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Princ.Dfm');
  Bloco := False;
  FimBloco1 := False;
  FimBloco2 := False;
  Inicio    := True;
  For Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if (Bloco) and (Trim(FormPrincipal.Texto2.Lines[Y]) =
                    'end') then
    begin
      if NrBloco = 01 then
        Bloco := False
      else if NrBloco = 02 then
        Bloco := False;
    end;
    if Trim(FormPrincipal.Texto2.Lines[Y]) =
       'object TreeMenuSup: TTreeView' then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      NrBloco := 01;
      Bloco := True;
    end;
    if (Bloco) and (NrBloco = 01) and (not FimBloco1) then
    begin
      FormPrincipal.Texto.Lines.Add('      Left = 34');
      FormPrincipal.Texto.Lines.Add('      Top = 192');
      FormPrincipal.Texto.Lines.Add('      Width = 71');
      FormPrincipal.Texto.Lines.Add('      Height = 57');
      FormPrincipal.Texto.Lines.Add('      BorderStyle = bsNone');
      FormPrincipal.Texto.Lines.Add('      Font.Charset = DEFAULT_CHARSET');
      FormPrincipal.Texto.Lines.Add('      Font.Color = clBlack');
      FormPrincipal.Texto.Lines.Add('      Font.Height = -11');
      FormPrincipal.Texto.Lines.Add('      Font.Name = '+#39+'MS Sans Serif'+#39);
      FormPrincipal.Texto.Lines.Add('      Font.Style = []');
      FormPrincipal.Texto.Lines.Add('      HotTrack = True');
      FormPrincipal.Texto.Lines.Add('      HideSelection = False');
      FormPrincipal.Texto.Lines.Add('      Images = ListaImagem');
      FormPrincipal.Texto.Lines.Add('      Indent = 19');
      FormPrincipal.Texto.Lines.Add('      ParentFont = False');
      FormPrincipal.Texto.Lines.Add('      ReadOnly = True');
      FormPrincipal.Texto.Lines.Add('      TabOrder = 2');
      FormPrincipal.Texto.Lines.Add('      Visible = False');
      IniTree  := False;
      SomaTree := '      Items.Data = ';
      if Trim(StrCompTree) <> '' then
      begin
        I_Img := Pos('{',StrCompTree);
        F_Img := Pos('}',StrCompTree);
        if (I_Img > 0) and (I_Img > 0) then
          SomaTree := SomaTree + Copy(StrCompTree,I_Img,(F_Img-I_Img)+1);
        if SomaTree <> '      Items.Data = ' then
          FormPrincipal.Texto.Lines.Add(SomaTree);
      end;
      FimBloco1 := True;
    end;
    if Not Bloco then
    begin
      if Inicio then
        FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[Y]
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  StrCompImFundo := '';
  StrCompTree    := '';
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Dfm');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Splash_Dfm(Completo: Boolean);
var
  Bloco: Boolean;
  NrBloco: Integer;
  FimBloco1: Boolean;
  Y,I: Integer;
  IniTree,Inicio : Boolean;
  SomaTree: String;
  I_Img,F_Img: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Splash.Dfm');
  Bloco     := False;
  FimBloco1 := False;
  Inicio    := True;
  For Y:=0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if (Bloco) and (Trim(FormPrincipal.Texto2.Lines[Y]) =
                    'end') then
    begin
      if NrBloco = 01 then
        Bloco := False;
    end;
    if Trim(FormPrincipal.Texto2.Lines[Y]) =
       'object ImagemApresentacao: TImage' then
    begin
      FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      NrBloco := 01;
      Bloco := True;
    end;
    if (Bloco) and (NrBloco = 01) and (not FimBloco1) then
    begin
      FormPrincipal.Texto.Lines.Add('    Left = 8');
      FormPrincipal.Texto.Lines.Add('    Top = 8');
      FormPrincipal.Texto.Lines.Add('    Width = 363');
      FormPrincipal.Texto.Lines.Add('    Height = 274');
      FormPrincipal.Texto.Lines.Add('    AutoSize = False');
      FormPrincipal.Texto.Lines.Add('    Center = True');
      FormPrincipal.Texto.Lines.Add('    Stretch = True');
      FormPrincipal.Texto.Lines.Add('    Transparent = True');
      IniTree  := False;
      SomaTree := '    Picture.Data = ';
      if Trim(StrCompImSplash) <> '' then
      begin
        I_Img := Pos('{',StrCompImSplash);
        F_Img := Pos('}',StrCompImSplash);
        if (I_Img > 0) and (I_Img > 0) then
          SomaTree := SomaTree + Copy(StrCompImSplash,I_Img,(F_Img-I_Img)+1);
        if SomaTree <> '    Picture.Data = ' then
          FormPrincipal.Texto.Lines.Add(SomaTree);
      end;
      FimBloco1 := True;
    end;
    if Not Bloco then
    begin
      if Inicio then
        FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[Y]
      else
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Splash.Dfm');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

function ComponentToString(Component: TComponent): string;
var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Component);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result:= StrStream.DataString;
    finally
      StrStream.Free;
    end;
  finally
    BinStream.Free
  end;
end;

function StringToComponent(Value: string; Instance: TWinControl): TComponent;
var
  StrStream:TStringStream;
  BinStream: TMemoryStream;
  ReadStr, Tmp: String;
  Comp: TComponent;
  I: Integer;
  Soma: Boolean;
begin
  ReadStr := Trim(Copy(Value,Pos(':',Value)+1,100));
  Tmp     := '';
  Soma    := True;
  I       := 1;
  while (I <= Length(ReadStr)) and Soma do
  begin
    if ReadStr[I] > #33 then
      Tmp := Tmp + ReadStr[I]
    else
      Soma := False;
    Inc(I);
  end;
  ReadStr := Tmp;
  if GetClass(ReadStr) <> Nil then
  begin
    Comp    := TComponentClass(FindClass(ReadStr)).Create(Nil);
    ReadStr := Trim(Value);
    ReadStr := Copy(ReadStr,08,100);
    ReadStr := Trim(Copy(ReadStr,01,Pos(':',ReadStr)-1));
    TControl(Comp).Parent := Instance;
    Comp.Name := ReadStr;
    StrStream := TStringStream.Create(Value);
    try
      BinStream := TMemoryStream.Create;
      try
        ObjectTextToBinary(StrStream, BinStream);
        BinStream.Seek(0, soFromBeginning);
        Result := BinStream.ReadComponent(Comp);
      finally
        BinStream.Free;
      end;
    finally
      StrStream.Free;
    end;
  end
  else
  begin
    Mensagem('Classe não encontrada: '+ReadStr+ ' !',modErro,[modOk]);
    Erro_de_Classe := True;
  end;
end;

procedure Gera_Princ_Res(Completo: Boolean);
var
  Comando: String;
  CodErro: Cardinal;
  FCompilacao: TStringList;
  FRetorno: String;
begin
  FormPrincipal.Texto.Lines.Clear;
  if Trim(TabGlobal_i.DPROJETO.Icone.Conteudo) <> '' then
    FormPrincipal.Texto.Lines.Add('ICONESISTEMA' + ' ICON '+Projeto.Pasta+'IMAGENS\'+Trim(TabGlobal_i.DPROJETO.Icone.Conteudo) );
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Princ.Rc');
  Comando := '"' + Projeto.PastaGerador + 'Delphi\Brcc32.Exe" -32 -fo "'+ Projeto.Pasta + 'Princ.Res" "'  + Projeto.Pasta + 'Princ.Rc"';
  CodErro := GetDosOutput(Pchar(Comando), Projeto.Pasta, SW_HIDE, FRetorno, False);
  //if CodErro <> 0 then
  //  Mensagem('Erro na Geração do Arquivo: '+^M + Projeto.Pasta + 'Princ.Res',ModAdvertencia,[ModOk]);
  FCompilacao := TStringList.Create;
  FCompilacao.Add(Comando);
  FCompilacao.Add(FRetorno);
  FCompilacao.SaveToFile(Projeto.Pasta + 'compiler_res.log');

  FCompilacao.Free;
  FormPrincipal.Texto.Lines.Clear;
end;

procedure Gera_Publicas(Completo: Boolean);
var
  I: Integer;
  Comando   : String;
  ExtraiVar : String;
  LinhaVar  : String;
  Bloco,Inicio : Boolean;
  Atr: String;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  if Completo then
    CopiaArquivo(Projeto.PastaFontes + 'Publicas.Pas', Projeto.Pasta + 'Publicas.Pas');
  if FileExists(Projeto.Pasta + 'Publicas.Pas') then
  begin
    Bloco := False;
    FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.Pasta + 'Publicas.Pas');
    Inicio := True;
    for I := 0 to FormPrincipal.Texto2.Lines.Count-1 do
    begin
      if Pos('{10-Início',FormPrincipal.Texto2.Lines[I]) > 0 then
      Begin
        FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[I]);
        FormPrincipal.Texto.Lines.Add('  with Sistema Do');
        FormPrincipal.Texto.Lines.Add('  Begin');
        FormPrincipal.Texto.Lines.Add('    Titulo         := '+#39+TabGlobal_i.DPROJETO.TITULO_P.Conteudo+#39+';');
        FormPrincipal.Texto.Lines.Add('    Versao         := '+#39+TabGlobal_i.DPROJETO.VERSAO_P.Conteudo+#39+';');
        FormPrincipal.Texto.Lines.Add('    Analista       := '+#39+TabGlobal_i.DPROJETO.ANALISTA.Conteudo+#39+';');
        FormPrincipal.Texto.Lines.Add('    Programador    := '+#39+TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo+#39+';');
        FormPrincipal.Texto.Lines.Add('    Projetista     := '+#39+TabGlobal_i.DPROJETO.EMPRESA.Conteudo+#39+';');
        if TabGlobal_i.DPROJETO.FORMATODATA.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('    EstiloData     := '+#39+'dd/mm/yyyy'+#39+';')
        else
          FormPrincipal.Texto.Lines.Add('    EstiloData     := '+#39+'dd/mm/yy'+#39+';');
        if TabGlobal_i.DPROJETO.CONFIRMASAIDA.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('    ConfirmaSaida  := True;')
        else
          FormPrincipal.Texto.Lines.Add('    ConfirmaSaida  := False;');
        if TabGlobal_i.DPROJETO.CONTROLEACESSO.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('    ControleAcesso := True;')
        else
          FormPrincipal.Texto.Lines.Add('    ControleAcesso := False;');
        FormPrincipal.Texto.Lines.Add('    SenhaInicial   := '+#39+TabGlobal_i.DPROJETO.SENHA.Conteudo+#39+';');
        if TabGlobal_i.DPROJETO.HINTBALAO.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('    HintBalao      := True;')
        else
          FormPrincipal.Texto.Lines.Add('    HintBalao      := False;');
        if TabGlobal_i.DPROJETO.MENUXP.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('    MenuXP         := True;')
        else
          FormPrincipal.Texto.Lines.Add('    MenuXP         := False;');
        FormPrincipal.Texto.Lines.Add('    Pasta          := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    Usuario        := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    Senha          := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    Master         := True;');
        FormPrincipal.Texto.Lines.Add('    Grupo          := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    ListaUsuarios  := TStringList.Create;');
        if TabGlobal_i.DPROJETO.SELECIONAR_EMP.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('    SelecionaUsr   := True;')
        else
          FormPrincipal.Texto.Lines.Add('    SelecionaUsr   := False;');
        FormPrincipal.Texto.Lines.Add('    NumeroUsr      := 0;');
        FormPrincipal.Texto.Lines.Add('    EmpresaUsr     := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    EnderecoUsr    := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    BairroUsr      := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    CidadeUsr      := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    UfUsr          := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    CEPUsr         := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    CNPJUsr        := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    IEUsr          := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    FonesUsr       := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    LogoUsr        := '+#39+''+#39+';');
        FormPrincipal.Texto.Lines.Add('    JanelasMDI     := 0;');
        if TabGlobal_i.DPROJETO.BDADOS.Conteudo = 3 then
          FormPrincipal.Texto.Lines.Add('    Sql            := 1;')
        else
          FormPrincipal.Texto.Lines.Add('    Sql            := 3;');
        FormPrincipal.Texto.Lines.Add('    Rede           := True;');
        FormPrincipal.Texto.Lines.Add('    Log            := True;');
        FormPrincipal.Texto.Lines.Add('    Integridade    := True;');
        Atr := StrZero(TabGlobal_i.DPROJETO.DEIXAR_NA_SENHA.Conteudo,03);
        if Atr[1] = '1' then
          FormPrincipal.Texto.Lines.Add('    MenuVertical   := False;')
        else
          FormPrincipal.Texto.Lines.Add('    MenuVertical   := True;');
        if Atr[2] = '1' then
          FormPrincipal.Texto.Lines.Add('    BarraF         := False;')
        else
          FormPrincipal.Texto.Lines.Add('    BarraF         := True;');
        if Atr[3] = '0' then
          FormPrincipal.Texto.Lines.Add('    BannerVertical := False;')
        else
          FormPrincipal.Texto.Lines.Add('    BannerVertical := True;');
        FormPrincipal.Texto.Lines.Add('    ErroFatal      := False;');
        FormPrincipal.Texto.Lines.Add('    OpcoesAcesso   := TStringList.Create;');
        FormPrincipal.Texto.Lines.Add('    OpcoesAcessoMn := TStringList.Create;');
        FormPrincipal.Texto.Lines.Add('    OpcoesAcessoBr := TStringList.Create;');
        FormPrincipal.Texto.Lines.Add('    OpcoesTabela   := TStringList.Create;');
        FormPrincipal.Texto.Lines.Add('    OpcoesAcesso.Clear;');
        FormPrincipal.Texto.Lines.Add('    OpcoesAcessoMn.Clear;');
        FormPrincipal.Texto.Lines.Add('    OpcoesAcessoBr.Clear;');
        FormPrincipal.Texto.Lines.Add('    OpcoesTabela.Clear;');
        FormPrincipal.Texto.Lines.Add('  End;');
        Bloco := True;
      End;
      if Pos('{99-Final',FormPrincipal.Texto2.Lines[I]) > 0 then
        Bloco := False;
      if Not Bloco then
      begin
        if inicio then
          FormPrincipal.Texto.Lines[0] := FormPrincipal.Texto2.Lines[I]
        else
          FormPrincipal.Texto.Lines.Add(FormPrincipal.Texto2.Lines[I]);
        Inicio := False;
      end;
    end;
    FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Publicas.Pas');
  end;
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Cabc(Programa, Titulo: String);
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto.Lines[0] :='{';
  FormPrincipal.Texto.Lines.Add(' Empresa....: '+TabGlobal_i.DPROJETO.EMPRESA.Conteudo);
  FormPrincipal.Texto.Lines.Add(' Programa...: '+Programa+' - '+Titulo);
  FormPrincipal.Texto.Lines.Add(' Sistema....: '+Projeto.Titulo);
  FormPrincipal.Texto.Lines.Add(' Data.......: '+DateToStr(Date));
  FormPrincipal.Texto.Lines.Add(' Versão.....: '+TabGlobal_i.DPROJETO.VERSAO_P.Conteudo);
  FormPrincipal.Texto.Lines.Add(' Analista...: '+TabGlobal_i.DPROJETO.ANALISTA.Conteudo);
  FormPrincipal.Texto.Lines.Add(' Programador: '+TabGlobal_i.DPROJETO.PROGRAMADOR.Conteudo);
  FormPrincipal.Texto.Lines.Add(' Criação....: xMaker '+Projeto.VersaoGerador + ' Release: ' + Projeto.ReleaseGerador);
  FormPrincipal.Texto.Lines.Add(' NºLicença..: '+Projeto.Registro_usr);
  FormPrincipal.Texto.Lines.Add('}');
  FormPrincipal.Texto.Lines.Add('');
end;

Function ConvertFormOrText(FileToConvertFrom : string; Tipo: Integer) : boolean ;
Var
  InputStream, OutputStream : TFileStream;
  FileToConvertTo : string ;
Begin
  Result := True ;
  FileToConvertTo := FileToConvertFrom ;
  if Tipo = 1 then
  Begin
    if Pos('.',FileToConvertFrom) = 0 then
      FileToConvertFrom := ChangeFileext(FileToConvertFrom, '.TXT') ;
    FileToConvertTo := ChangeFileext(FileToConvertFrom, '.DFM') ;
  End
  else if Tipo = 2 then
  Begin
    if Pos('.',FileToConvertFrom) = 0 then
      FileToConvertFrom := ChangeFileext(FileToConvertFrom, '.DFM') ;
    FileToConvertTo := ChangeFileext(FileToConvertFrom, '.TXT') ;
  End
  else if Tipo = 3 then
  Begin
    FileToConvertFrom := ChangeFileext(FileToConvertFrom, '.RC') ;
    FileToConvertTo := ChangeFileext(FileToConvertFrom, '.RES') ;
  End;
  try
    try
      InputStream  := TFileStream.Create(FileToConvertFrom, fmOpenRead);
      OutputStream := TFileStream.Create(FileToConvertTo, fmCreate);
      if (Tipo = 01) or (Tipo = 03) then
        ObjectTextToResource(InputStream, OutputStream)
      else if Tipo = 2 then
        ObjectResourceToText(InputStream, OutputStream);
     Except
          On EStreamError do
             Result := False ;
          End ;
    Finally
          InputStream.Free;
          OutputStream.Free;
    End ;
End;

procedure Gera_Bat(Completo: Boolean);
begin
  FormPrincipal.Texto.Lines.Clear;
  if Completo then
    FormPrincipal.Texto.Lines[0] := '"'+Projeto.Compilador + '" ' + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-4)+ ' -Q -B '+Projeto.Parametro+' > Linker.Txt'
  else
    FormPrincipal.Texto.Lines[0] := '"'+Projeto.Compilador + '" ' + Copy(ExtractFileName(Projeto.ArquivoProj),01,Length(ExtractFileName(Projeto.ArquivoProj))-4)+ ' -Q '+Projeto.Parametro+' > Linker.Txt';
  FormPrincipal.Texto.Lines.Add('Copy Linker.Txt Linker0.Txt');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Compila.Bat');
end;

procedure Gera_Bat_Adapter(Completo: Boolean);
begin
  FormPrincipal.Texto.Lines.Clear;
  if Completo then
    FormPrincipal.Texto.Lines[0] := '"'+Projeto.Compilador + '" ' + 'Adapter' + ' -Q -B '+Projeto.Parametro+' > Linker.Txt'
  else
    FormPrincipal.Texto.Lines[0] := '"'+Projeto.Compilador + '" ' + 'Adapter' + ' -Q '+Projeto.Parametro+' > Linker.Txt';
  FormPrincipal.Texto.Lines.Add('Copy Linker.Txt Linker0.Txt');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'Compila.Bat');
end;

procedure Gera_BaseDados;
var I, Y, T, NrB, NrBase: Integer;
    Bloco, Inicio: Boolean;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  // Based.Dfm
  FormPrincipal.Texto.Lines[0] := 'object BaseDados: TBaseDados';
  FormPrincipal.Texto.Lines.Add('  OldCreateOrder = False');
  FormPrincipal.Texto.Lines.Add('  OnCreate = DataModuleCreate');
  FormPrincipal.Texto.Lines.Add('  OnDestroy = DataModuleDestroy');
  FormPrincipal.Texto.Lines.Add('  Left = 192');
  FormPrincipal.Texto.Lines.Add('  Top = 107');
  FormPrincipal.Texto.Lines.Add('  Height = 375');
  FormPrincipal.Texto.Lines.Add('  Width = 544');
  FormPrincipal.Texto.Lines.Add('  object frTextExport: TfrTextExport');
  FormPrincipal.Texto.Lines.Add('    Left = 24');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frRTFExport: TfrRTFExport');
  FormPrincipal.Texto.Lines.Add('    Left = 96');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frCSVExport: TfrCSVExport');
  FormPrincipal.Texto.Lines.Add('    Left = 168');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frHTMExport: TfrHTMExport');
  FormPrincipal.Texto.Lines.Add('    Left = 240');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frDesigner1: TfrDesigner');
  FormPrincipal.Texto.Lines.Add('    Left = 312');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frBarCodeObject: TfrBarCodeObject');
  FormPrincipal.Texto.Lines.Add('    Left = 572');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frChartObject: TfrChartObject');
  FormPrincipal.Texto.Lines.Add('    Left = 644');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frRoundRectObject: TfrRoundRectObject');
  FormPrincipal.Texto.Lines.Add('    Left = 436');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frCheckBoxObject: TfrCheckBoxObject');
  FormPrincipal.Texto.Lines.Add('    Left = 508');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frOLEObject: TfrOLEObject');
  FormPrincipal.Texto.Lines.Add('    Left = 364');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frRichObject: TfrRichObject');
  FormPrincipal.Texto.Lines.Add('    Left = 220');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  FormPrincipal.Texto.Lines.Add('  object frShapeObject: TfrShapeObject');
  FormPrincipal.Texto.Lines.Add('    Left = 292');
  FormPrincipal.Texto.Lines.Add('    Top = 1');
  FormPrincipal.Texto.Lines.Add('  end');
  Y := 24;
  TabGlobal_i.DBDADOS.First;
  while not TabGlobal_i.DBDADOS.Eof do
  begin
    if Trim(TabGlobal_i.DBDADOS.NOME.Conteudo) <> '' then
    begin
      if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
      begin
        {FormPrincipal.Texto.Lines.Add('  object '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+': TIBDatabase');
        FormPrincipal.Texto.Lines.Add('    DefaultTransaction = TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo));
        FormPrincipal.Texto.Lines.Add('    IdleTimer = 0');
        if TabGlobal_i.DPROJETO.BDADOS.Conteudo = 3 then
          FormPrincipal.Texto.Lines.Add('    SQLDialect = 1')
        else
          FormPrincipal.Texto.Lines.Add('    SQLDialect = 3');
        FormPrincipal.Texto.Lines.Add('    TraceFlags = []');
        FormPrincipal.Texto.Lines.Add('    Left = '+IntToStr(Y));
        FormPrincipal.Texto.Lines.Add('    Top = 48');
        FormPrincipal.Texto.Lines.Add('  end');
        Y := Y + 72;
        FormPrincipal.Texto.Lines.Add('  object TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+': TIBTransaction');
        FormPrincipal.Texto.Lines.Add('    Active = False');
        FormPrincipal.Texto.Lines.Add('    DefaultDatabase = '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo));
        FormPrincipal.Texto.Lines.Add('    Params.Strings = (');
        FormPrincipal.Texto.Lines.Add('      '+#39+'read_committed'+#39);
        FormPrincipal.Texto.Lines.Add('      '+#39+'rec_version'+#39);
        FormPrincipal.Texto.Lines.Add('      '+#39+'nowait'+#39+')');
        FormPrincipal.Texto.Lines.Add('    Left = '+IntToStr(Y));
        FormPrincipal.Texto.Lines.Add('    Top = 48');
        FormPrincipal.Texto.Lines.Add('  end');}
      end
      else
      begin
        {FormPrincipal.Texto.Lines.Add('  object '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+': TZConnection');
        if TabGlobal_i.DBDADOS.PADRAO.Conteudo = 1 then
          NrBase := TabGlobal_i.DPROJETO.BDADOS.Conteudo
        else
          NrBase := TabGlobal_i.DBDADOS.BDADOS.Conteudo;
        case NrBase of
          1: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'firebird-1.0'+#39);
          2: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'firebird-1.5'+#39);
          3: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'interbase-5'+#39);
          4: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'interbase-6'+#39);
          5: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'ado'+#39);
          6: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'sybase'+#39);
          7: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'mssql'+#39);
          8: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'mysql'+#39);
          9: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'mysql-3.20'+#39);
          10: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'mysql-3.23'+#39);
          11: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'mysql-4.0'+#39);
          12: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'postgresql'+#39);
          13: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'postgresql-6.5'+#39);
          14: FormPrincipal.Texto.Lines.Add('    Protocol = '+#39+'postgresql-7.2'+#39);
        end;
        FormPrincipal.Texto.Lines.Add('    Port = 0');
        FormPrincipal.Texto.Lines.Add('    AutoCommit = True');
        FormPrincipal.Texto.Lines.Add('    ReadOnly = True');
        FormPrincipal.Texto.Lines.Add('    TransactIsolationLevel = tiNone');
        FormPrincipal.Texto.Lines.Add('    Connected = False');
        FormPrincipal.Texto.Lines.Add('    SQLHourGlass = False');
        FormPrincipal.Texto.Lines.Add('    Left = '+IntToStr(Y));
        FormPrincipal.Texto.Lines.Add('    Top = 48');
        FormPrincipal.Texto.Lines.Add('  end');}
      end;
      Y := Y + 72;
    end;
    TabGlobal_i.DBDADOS.Next;
  end;
  FormPrincipal.Texto.Lines.Add('end');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta + 'BaseD.Dfm');
  FormPrincipal.Texto.Lines.Clear;

  // Based.Pas
  FormPrincipal.texto2.Lines.LoadFromFile(Projeto.Pasta + 'BaseD.Pas');
  Bloco := False;
  Inicio := True;
  for Y:=0 to FormPrincipal.texto2.Lines.Count-1 do
  begin
    if Pos('{10-Início',FormPrincipal.texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[Y]);
      TabGlobal_i.DBDADOS.First;
      while not TabGlobal_i.DBDADOS.Eof do
      begin
        if Trim(TabGlobal_i.DBDADOS.NOME.Conteudo) <> '' then
        begin
          if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
          begin
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+': TIBDataBase;');
            FormPrincipal.texto.Lines.Add('    TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+': TIBTransaction;');
          end
          else
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+': TXSQLDatabase;');
        end;
        TabGlobal_i.DBDADOS.Next;
      end;
      Bloco := True;
    end;
    if Pos('{20-Início',FormPrincipal.texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[Y]);
      NrB:= -1;
      TabGlobal_i.DBDADOS.First;
      while not TabGlobal_i.DBDADOS.Eof do
      begin
        if Trim(TabGlobal_i.DBDADOS.NOME.Conteudo) <> '' then
        begin
          Inc(NrB);
          if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
          begin
            FormPrincipal.Texto.Lines.Add('    TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+':= TIBTransaction.Create(Self);');
            FormPrincipal.Texto.Lines.Add('    with TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+' do');
            FormPrincipal.texto.Lines.Add('    begin');
            FormPrincipal.Texto.Lines.Add('      Active := False;');
            FormPrincipal.Texto.Lines.Add('      DefaultDatabase := '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
            FormPrincipal.Texto.Lines.Add('      Params.Add('+#39+'read_committed'+#39+');');
            FormPrincipal.Texto.Lines.Add('      Params.Add('+#39+'rec_version'+#39+');');
            FormPrincipal.Texto.Lines.Add('      Params.Add('+#39+'nowait'+#39+');');
            FormPrincipal.Texto.Lines.Add('      Name := '+#39+'TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+#39';');
            FormPrincipal.Texto.Lines.Add('    end;');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+ ' := TIBDatabase.Create(Self);');
            FormPrincipal.texto.Lines.Add('    with '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+ ' do');
            FormPrincipal.texto.Lines.Add('    begin');
            FormPrincipal.Texto.Lines.Add('      DefaultTransaction := TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
            FormPrincipal.Texto.Lines.Add('      IdleTimer := 0;');
            if TabGlobal_i.DPROJETO.BDADOS.Conteudo = 3 then
              FormPrincipal.Texto.Lines.Add('      SQLDialect := 1;')
            else
              FormPrincipal.Texto.Lines.Add('      SQLDialect := 3;');
            FormPrincipal.Texto.Lines.Add('      TraceFlags := [];');
            FormPrincipal.Texto.Lines.Add('      Name := '+#39+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+#39';');
            FormPrincipal.Texto.Lines.Add('    end;');
          end
          else if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 2 then
          begin
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+ ' := TXSQLDatabase.Create(Self);');
            FormPrincipal.Texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+ '.Name           := '+#39+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+#39';');
            FormPrincipal.Texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+ '.SessionName    := '+#39+'Default'+#39';');
            FormPrincipal.Texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+ '.TransIsolation := tiDirtyRead;');
          end;
          FormPrincipal.texto.Lines.Add('    DataFile := ArqIni.ReadString('+#39+'EMPRESA 00'+#39+', '+#39+'Base '+StrZero(NrB,04)+#39+', '+#39+#39+');');
          FormPrincipal.texto.Lines.Add('    Host     := ArqIni.ReadString('+#39+'EMPRESA 00'+#39+', '+#39+'Host '+StrZero(NrB,04)+#39+', '+#39+#39+');');
          FormPrincipal.texto.Lines.Add('    Usuario  := ArqIni.ReadString('+#39+'EMPRESA 00'+#39+', '+#39+'Usuario '+StrZero(NrB,04)+#39+', '+#39+#39+');');
          FormPrincipal.texto.Lines.Add('    Senha    := Decript(ArqIni.ReadString('+#39+'EMPRESA 00'+#39+', '+#39+'Senha '+StrZero(NrB,04)+#39+', '+#39+#39+'));');
          FormPrincipal.texto.Lines.Add('    Servidor := StrToIntDef(ArqIni.ReadString('+#39+'EMPRESA 00'+#39+', '+#39+'Servidor '+StrZero(NrB,04)+#39+', '+#39+#39+'), -1);');

          if TabGlobal_i.DBDADOS.BDADOS.Conteudo < 3 then
          begin
            FormPrincipal.texto.Lines.Add('    if Trim(DataFile) = '+#39+#39+' then');
            if Pos('.',TabGlobal_i.DBDADOS.ARQUIVO.Conteudo) < 1 then
              FormPrincipal.texto.Lines.Add('      DataFile := Sistema.Pasta + '+#39+Trim(TabGlobal_i.DBDADOS.ARQUIVO.Conteudo)+'.GDB'+#39';')
            else
              FormPrincipal.texto.Lines.Add('      DataFile := Sistema.Pasta + '+#39+Trim(TabGlobal_i.DBDADOS.ARQUIVO.Conteudo)+#39';');
            FormPrincipal.texto.Lines.Add('    if Trim(Host) = '+#39+#39+' then');
            FormPrincipal.texto.Lines.Add('      Host := '+#39+Trim(TabGlobal_i.DBDADOS.HOST_NAME.Conteudo)+#39';');
          end
          else
          begin
            FormPrincipal.texto.Lines.Add('    if Trim(DataFile) = '+#39+#39+' then');
            FormPrincipal.texto.Lines.Add('      DataFile := '+#39+Trim(TabGlobal_i.DBDADOS.ARQUIVO.Conteudo)+#39';');
            FormPrincipal.texto.Lines.Add('    if Trim(Host) = '+#39+#39+' then');
            FormPrincipal.texto.Lines.Add('      Host := '+#39+Trim(TabGlobal_i.DBDADOS.HOST_NAME.Conteudo)+#39';');
          end;
          if TabGlobal_i.DBDADOS.LOGIN.Conteudo = 1 then
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.LoginPrompt    := True;')
          else
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.LoginPrompt    := False;');
          if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
          begin
            FormPrincipal.texto.Lines.Add('    if Trim(Host) <> '+#39+#39+' then');
            FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DataBaseName := Host + '+#39+':'+#39+' + DataFile');
            FormPrincipal.texto.Lines.Add('    else');
            FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DataBaseName := DataFile;');
            FormPrincipal.texto.Lines.Add('    if DirectoryExists(ExtractFilePath(DataFile)) then');
            FormPrincipal.texto.Lines.Add('      if not FileExists(DataFile) then');
            FormPrincipal.texto.Lines.Add('      begin');
            FormPrincipal.texto.Lines.Add('        if MessageDlg('+#39+'Base de Dados não encontrada: '+#39+'+^M+^M+DataFile+^M+^M'+#39+'Deseja Criá-la ?'+#39+',mtConfirmation,[mbYes,mbNo],0) = mrYes then');
            FormPrincipal.texto.Lines.Add('        begin');
            FormPrincipal.texto.Lines.Add('          '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Clear;');
            FormPrincipal.texto.Lines.Add('          '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'USER '+#39+'+#39+'+#39+Trim(TabGlobal_i.DBDADOS.USUARIO.Conteudo)+#39+'+#39);');
            FormPrincipal.texto.Lines.Add('          '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'PASSWORD '+#39+'+#39+'+#39+Trim(TabGlobal_i.DBDADOS.SENHA.Conteudo)+#39+'+#39);');
            FormPrincipal.texto.Lines.Add('          DB_LoginConexao(BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params, Usuario, Senha);');
            FormPrincipal.texto.Lines.Add('          '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.CreateDatabase;');
            FormPrincipal.texto.Lines.Add('          Criou_BD := True;');
            FormPrincipal.texto.Lines.Add('          '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Close;');
            FormPrincipal.texto.Lines.Add('        end;');
            FormPrincipal.texto.Lines.Add('      end;');
          end
          else
          begin
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName   := '+#39+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+#39+';');
            FormPrincipal.texto.Lines.Add('    case Servidor of');
            FormPrincipal.texto.Lines.Add('      0: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stInterbase;');
            FormPrincipal.texto.Lines.Add('      1: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stFirebird;');
            FormPrincipal.texto.Lines.Add('      2: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stSQLBase;');
            FormPrincipal.texto.Lines.Add('      3: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stOracle;');
            FormPrincipal.texto.Lines.Add('      4: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stSQLServer;');
            FormPrincipal.texto.Lines.Add('      5: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stSybase;');
            FormPrincipal.texto.Lines.Add('      6: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stDB2;');
            FormPrincipal.texto.Lines.Add('      7: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stInformix;');
            FormPrincipal.texto.Lines.Add('      8: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stODBC;');
            FormPrincipal.texto.Lines.Add('      9: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stMySQL;');
            FormPrincipal.texto.Lines.Add('      10: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stPostgreSQL;');
            FormPrincipal.texto.Lines.Add('      11: BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType := stOLEDB;');
            FormPrincipal.texto.Lines.Add('    else');
            case TabGlobal_i.DPROJETO.BDADOS.Conteudo of
              1: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stInterbase;');
              2: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stFirebird;');
              3: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stSQLBase;');
              4: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stOracle;');
              5: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stSQLServer;');
              6: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stSybase;');
              7: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stDB2;');
              8: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stInformix;');
              9: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stODBC;');
              10: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stMySQL;');
              11: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stPostgreSQL;');
              12: FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType     := stOLEDB;');
            end;
            FormPrincipal.texto.Lines.Add('      Servidor := '+IntToStr(TabGlobal_i.DPROJETO.BDADOS.Conteudo-1)+';');
            FormPrincipal.texto.Lines.Add('    end;');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Clear;');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'USER NAME='+Trim(TabGlobal_i.DBDADOS.USUARIO.Conteudo)+#39+');');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'PASSWORD='+Trim(TabGlobal_i.DBDADOS.SENHA.Conteudo)+#39+');');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'AUTOCOMMIT'+#39+');');
            if TabGlobal_i.DPROJETO.BDADOS.Conteudo < 3 then
              FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'SQL DIALECT=3'+#39+');');
            FormPrincipal.texto.Lines.Add('    DB_LoginConexao(BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params, Usuario, Senha);');
            FormPrincipal.texto.Lines.Add('    if Trim(Host) <> '+#39+#39+' then');
            FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.RemoteDatabase := Host + '+#39+':'+#39+' + DataFile');
            FormPrincipal.texto.Lines.Add('    else');
            FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.RemoteDatabase := DataFile;');
            FormPrincipal.texto.Lines.Add('    if '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.ServerType in [stInterbase, stFirebird] then');
            FormPrincipal.texto.Lines.Add('      if DirectoryExists(ExtractFilePath(DataFile)) then');
            FormPrincipal.texto.Lines.Add('        if not FileExists(DataFile) then');
            FormPrincipal.texto.Lines.Add('        begin');
            FormPrincipal.texto.Lines.Add('          if MessageDlg('+#39+'Base de Dados não encontrada: '+#39+'+^M+^M+DataFile+^M+^M'+#39+'Deseja Criá-la ?'+#39+',mtConfirmation,[mbYes,mbNo],0) = mrYes then');
            FormPrincipal.texto.Lines.Add('          begin');
            FormPrincipal.texto.Lines.Add('            with TIBDatabase.Create(Self) do');
            FormPrincipal.texto.Lines.Add('            begin');
            FormPrincipal.texto.Lines.Add('              DatabaseName := DataFile;');
            FormPrincipal.texto.Lines.Add('              Params.Clear;');
            FormPrincipal.texto.Lines.Add('              Params.Add('+#39+'USER '+#39+'+#39+'+#39+Trim(TabGlobal_i.DBDADOS.USUARIO.Conteudo)+#39+'+#39);');
            FormPrincipal.texto.Lines.Add('              Params.Add('+#39+'PASSWORD '+#39+'+#39+'+#39+Trim(TabGlobal_i.DBDADOS.SENHA.Conteudo)+#39+'+#39);');
            FormPrincipal.texto.Lines.Add('              DB_LoginConexao(Params, Usuario, Senha);');
            FormPrincipal.texto.Lines.Add('              CreateDatabase;');
            FormPrincipal.texto.Lines.Add('              Criou_BD := True;');
            FormPrincipal.texto.Lines.Add('              Free;');
            FormPrincipal.texto.Lines.Add('            end;');
            FormPrincipal.texto.Lines.Add('          end;');
            FormPrincipal.texto.Lines.Add('        end;');
            For T := 0 to TabGlobal_i.DBDADOS.PARAMETROS.Conteudo.Count-1 do
              if Trim(TabGlobal_i.DBDADOS.PARAMETROS.Conteudo[T]) <> '' then
                if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
                  FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+Trim(TabGlobal_i.DBDADOS.PARAMETROS.Conteudo[T])+#39+');')
                else
                  FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+Trim(TabGlobal_i.DBDADOS.PARAMETROS.Conteudo[T])+#39+');');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Connected := True;');
            FormPrincipal.texto.Lines.Add('    Sistema.BancoDados := DB_User(Servidor) + '+#39+': '+#39 +' + BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Version;');
          end;
          //FormPrincipal.texto.Lines.Add('  ListaBaseDadosArq.AddObject(DataFile,TObject(Host));');
          FormPrincipal.texto.Lines.Add('    ListaBaseDadosArq.Add(DataFile);');
          FormPrincipal.texto.Lines.Add('    ListaBaseDadosHost.Add(Host);');
          if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
          begin
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Clear;');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'USER_NAME='+Trim(TabGlobal_i.DBDADOS.USUARIO.Conteudo)+#39+');');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+'PASSWORD='+Trim(TabGlobal_i.DBDADOS.SENHA.Conteudo)+#39+');');
            FormPrincipal.texto.Lines.Add('    DB_LoginConexao(BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params, Usuario, Senha);');
            For T := 0 to TabGlobal_i.DBDADOS.PARAMETROS.Conteudo.Count-1 do
              if Trim(TabGlobal_i.DBDADOS.PARAMETROS.Conteudo[T]) <> '' then
                if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
                  FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+Trim(TabGlobal_i.DBDADOS.PARAMETROS.Conteudo[T])+#39+');')
                else
                  FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Params.Add('+#39+Trim(TabGlobal_i.DBDADOS.PARAMETROS.Conteudo[T])+#39+');');
          end
          else
          begin
            //FormPrincipal.texto.Lines.Add('  '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Properties.Clear;');
            //FormPrincipal.texto.Lines.Add('  '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Properties.Add('+#39+'USER_NAME='+Trim(TabGlobal_i.DBDADOS.USUARIO.Conteudo)+#39+');');
            //FormPrincipal.texto.Lines.Add('  '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Properties.Add('+#39+'PASSWORD='+Trim(TabGlobal_i.DBDADOS.SENHA.Conteudo)+#39+');');
          end;
          if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
          begin
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Open;');
            FormPrincipal.texto.Lines.Add('    TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.StartTransaction;');
            FormPrincipal.texto.Lines.Add('    Sistema.BancoDados := '+#39+'Firebird'+#39+';');
          end;
          FormPrincipal.texto.Lines.Add('');
        end;
        TabGlobal_i.DBDADOS.Next;
      end;
      TabGlobal_i.DBDADOS.First;
      while not TabGlobal_i.DBDADOS.Eof do
      begin
        if Trim(TabGlobal_i.DBDADOS.NOME.Conteudo) <> '' then
          FormPrincipal.texto.Lines.Add('    ListaBaseDados.AddObject('+#39+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+#39+', BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+');');
        TabGlobal_i.DBDADOS.Next;
      end;
      TabGlobal_i.DTABELAS.First;
      while not TabGlobal_i.DTABELAS.Eof do
      begin
        if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    ListaNomeTabelas.Add('+#39+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+');');
        TabGlobal_i.DTABELAS.Next;
      end;
      TabGlobal_i.DCONSULTA.First;
      while not TabGlobal_i.DCONSULTA.Eof do
      begin
        if (Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, TabGlobal_i.DCONSULTA.ATIVO.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    ListaNomeTabelas.Add('+#39+'CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+#39+');');
        TabGlobal_i.DCONSULTA.Next;
      end;
      Bloco := True;
    end;
    if Pos('{30-Início',FormPrincipal.texto2.Lines[Y]) > 0 then
    begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[Y]);
      TabGlobal_i.DBDADOS.First;
      while not TabGlobal_i.DBDADOS.Eof do
      begin
        if Trim(TabGlobal_i.DBDADOS.NOME.Conteudo) <> '' then
        begin
          if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
          begin
            FormPrincipal.texto.Lines.Add('    if '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.TestConnected then');
            FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Connected := False;');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Free;');
            FormPrincipal.texto.Lines.Add('    TRS_'+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Free;');
          end
          else
          begin
            FormPrincipal.texto.Lines.Add('    if '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.TestConnected then');
            FormPrincipal.texto.Lines.Add('      '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Connected := False;');
            FormPrincipal.texto.Lines.Add('    '+'BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.Free;');
          end;
        end;
        TabGlobal_i.DBDADOS.Next;
      end;
      Bloco := True;
    end;
    if Pos('{99-Final',FormPrincipal.texto2.Lines[Y]) > 0 then
      Bloco := False;
    if Not Bloco then
    begin
      if inicio then
        FormPrincipal.texto.Lines[0] := FormPrincipal.texto2.Lines[Y]
      else
        FormPrincipal.texto.Lines.Add(FormPrincipal.Texto2.Lines[Y]);
      Inicio := False;
    end;
  end;
  FormPrincipal.texto.Lines.SaveToFile(Projeto.Pasta + 'BaseD.Pas');
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_CConsultas;
var
  I: Integer;
  Lista: TStringList;
  Mascara: String;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  TabGlobal_i.DCONSULTA.Filtro := '';
  TabGlobal_i.DCONSULTA.AtualizaSql;
  TabGlobal_i.DCONSULTA.First;
  while not TabGlobal_i.DCONSULTA.Eof do
  begin
    if (Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, TabGlobal_i.DCONSULTA.ATIVO.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines[0] := '{';
      FormPrincipal.Texto.Lines.Add(' Classe de consulta: '+TabGlobal_i.DCONSULTA.NOME.Conteudo + ' - ' + TabGlobal_i.DCONSULTA.TITULO_I.Conteudo);
      FormPrincipal.Texto.Lines.Add('}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('unit CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('interface');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('{$I Princ.inc}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,');
      FormPrincipal.Texto.Lines.Add('     {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,');
      FormPrincipal.Texto.Lines.Add('     {$ELSE}');
      FormPrincipal.Texto.Lines.Add('     XSEngine,');
      FormPrincipal.Texto.Lines.Add('     {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('     DB, Dialogs;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('type');
      FormPrincipal.Texto.Lines.Add('  TCS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+' = class(TTabela)');
      FormPrincipal.Texto.Lines.Add('  public');

      TabGlobal_i.DBDADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCONSULTA.BASE.Conteudo);
      TabGlobal_i.DBDADOS.AtualizaSql;
      TabGlobal_i.DBDADOS.First;

      FormPrincipal.Texto.Lines.Add('    constructor Create(AOwner: TComponent); override;');
      FormPrincipal.Texto.Lines.Add('    procedure Parametros(Tabela: TTabela); override;');
      FormPrincipal.Texto.Lines.Add('    procedure ConfiguraMascara_CS; override;');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('implementation');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses Publicas, Validar, Rotinas, Abertura, Calculos, RotinaEd;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('constructor TCS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+'.Create(AOwner: TComponent);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited Create(AOwner);');
      FormPrincipal.Texto.Lines.Add('  NomeTabela       := '+#39+'CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+#39+';');
      FormPrincipal.Texto.Lines.Add('  Titulo           := '+#39+TabGlobal_i.DCONSULTA.TITULO_I.Conteudo+#39+';');
      FormPrincipal.Texto.Lines.Add('  Name             := '+#39+'CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+#39+';');
      FormPrincipal.Texto.Lines.Add('  Database         := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  Transaction      := BaseDados.TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  DatabaseName     := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName;');
      FormPrincipal.Texto.Lines.Add('  CachedUpdates    := True;');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  Local            := False;');
      FormPrincipal.Texto.Lines.Add('  Open_begin       := False;');
      if TabGlobal_i.DPROJETO.BDADOS.Conteudo = 3 then
        FormPrincipal.Texto.Lines.Add('  Versao           := 5;')
      else
        FormPrincipal.Texto.Lines.Add('  Versao           := 6;');
      FormPrincipal.Texto.Lines.Add('  TableType        := ttView;');
      for I:=0 to TabGlobal_i.DCONSULTA.SQL_I.Conteudo.Count-1 do
        FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+TabGlobal_i.DCONSULTA.SQL_I.Conteudo[I]+#39+');');
      FormPrincipal.Texto.Lines.Add('  Sql.AddStrings(SqlPrincipal);');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TCS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+'.Parametros(Tabela: TTabela);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  Parametros_Padrao(Tabela);');
      Lista := TStringList.Create;
      for I:=0 to TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo.Count-1 do
      begin
        StringToArray(TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I], ';', Lista);
        if Lista.Count > 1 then
          FormPrincipal.Texto.Lines.Add('  Parametro_Tipo('+#39+Lista[0]+#39+', '+Lista[1]+');');
      end;
      Lista.Free;
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TCS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+'.ConfiguraMascara_CS;');
      if Trim(TabGlobal_i.DCONSULTA.TITULOS.Conteudo.Text) <> '' then
      begin
        FormPrincipal.Texto.Lines.Add('var');
        FormPrincipal.Texto.Lines.Add('  I: Integer;');
        FormPrincipal.Texto.Lines.Add('  Coluna: TField;');
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited ConfiguraMascara_CS;');
      if Trim(TabGlobal_i.DCONSULTA.TITULOS.Conteudo.Text) <> '' then
      begin
        FormPrincipal.Texto.Lines.Add('  for I:=0 to Fields.Count-1 do');
        FormPrincipal.Texto.Lines.Add('    Fields[I].Visible := False;');
      end;
      Lista := TStringList.Create;
      for I:=0 to TabGlobal_i.DCONSULTA.TITULOS.Conteudo.Count-1 do
      begin
        StringToArray(TabGlobal_i.DCONSULTA.TITULOS.Conteudo[I], ';', Lista);
        if Lista.Count > 1 then
        begin
          Mascara := Lista[1];
          if Trim(Mascara) <> '' then
            if TrimRight(Mascara[Length(TrimRight(Mascara))]) = '*' then
              Mascara := '';
          FormPrincipal.Texto.Lines.Add('  Coluna := FieldByName('+#39+Lista[3]+#39+');');
          FormPrincipal.Texto.Lines.Add('  if Assigned(Coluna) then');
          FormPrincipal.Texto.Lines.Add('    ConfiguraMascaraCampo(Coluna, '+#39+Lista[0]+#39+', '+#39+Mascara+#39+', '+IntToStr(I)+', '+Lista[2]+', True);');
        end;
      end;
      Lista.Free;
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('end.');
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+'.Pas');
      FormPrincipal.Texto.Lines.Clear;
    end;
    TabGlobal_i.DCONSULTA.Next;
  end;
end;

procedure Gera_CScripts;
var
  I: Integer;
  Lista: TStringList;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  TabGlobal_i.DSQL_SCRIPT.Filtro := '';
  TabGlobal_i.DSQL_SCRIPT.AtualizaSql;
  TabGlobal_i.DSQL_SCRIPT.First;
  while not TabGlobal_i.DSQL_SCRIPT.Eof do
  begin
    if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines[0] := '{';
      FormPrincipal.Texto.Lines.Add(' Classe de scripts: '+TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo + ' - ' + TabGlobal_i.DSQL_SCRIPT.DESCRICAO.Conteudo.Text);
      FormPrincipal.Texto.Lines.Add('}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('unit SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('interface');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('{$I Princ.inc}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses Tabela, BaseD, classes, DB;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('type');
      FormPrincipal.Texto.Lines.Add('  TSC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+' = class(TSQLScript)');
      FormPrincipal.Texto.Lines.Add('  public');

      TabGlobal_i.DBDADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DSQL_SCRIPT.BASE.Conteudo);
      TabGlobal_i.DBDADOS.AtualizaSql;
      TabGlobal_i.DBDADOS.First;

      FormPrincipal.Texto.Lines.Add('    constructor Create(AOwner: TComponent); override;');
      FormPrincipal.Texto.Lines.Add('    procedure Parametros; override;');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('implementation');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('constructor TSC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Create(AOwner: TComponent);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited Create(AOwner);');
      FormPrincipal.Texto.Lines.Add('  Name             := '+#39+'SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+#39+';');
      FormPrincipal.Texto.Lines.Add('  Database         := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  Transaction      := BaseDados.TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  DatabaseName     := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName;');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  with Script do');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  with SQL do');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  begin');
      for I:=0 to TabGlobal_i.DSQL_SCRIPT.BLOCO_SQL.Conteudo.Count-1 do
        FormPrincipal.Texto.Lines.Add('    Add('+AtribuiAspas(TabGlobal_i.DSQL_SCRIPT.BLOCO_SQL.Conteudo[I])+');');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TSC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Parametros;');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited Parametros;');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      Lista := TStringList.Create;
      for I:=0 to TabGlobal_i.DSQL_SCRIPT.PARAMETROS.Conteudo.Count-1 do
      begin
        StringToArray(TabGlobal_i.DSQL_SCRIPT.PARAMETROS.Conteudo[I], ';', Lista);
        if Lista.Count > 1 then
        begin
          FormPrincipal.Texto.Lines.Add('  if Params.FindParam('+#39+Lista[0]+#39+') <> nil then');
          FormPrincipal.Texto.Lines.Add('    ParamByName('+#39+Lista[0]+#39+').DataType := '+Lista[1]+';');
        end;
      end;
      Lista.Free;
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('end.');
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Pas');
      FormPrincipal.Texto.Lines.Clear;
    end;
    TabGlobal_i.DSQL_SCRIPT.Next;
  end;
end;

procedure Gera_CProcedures;
var
  I: Integer;
  Lista: TStringList;
  Parametro: String;
  Primeira: Boolean;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  TabGlobal_i.DPROC_EXTERNA.Filtro := '';
  TabGlobal_i.DPROC_EXTERNA.AtualizaSql;
  TabGlobal_i.DPROC_EXTERNA.First;
  while not TabGlobal_i.DPROC_EXTERNA.Eof do
  begin
    if (Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('ST', TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo, TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines[0] := '{';
      FormPrincipal.Texto.Lines.Add(' Classe de stored procedure: '+TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo + ' - ' + TabGlobal_i.DPROC_EXTERNA.DESCRICAO.Conteudo.Text);
      FormPrincipal.Texto.Lines.Add('}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('unit ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('interface');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('{$I Princ.inc}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses Tabela, BaseD, classes,');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  XSEngine,');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  DB;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('type');
      FormPrincipal.Texto.Lines.Add('  TST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+' = class(TSQLProcedure)');
      FormPrincipal.Texto.Lines.Add('  public');

      TabGlobal_i.DBDADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DPROC_EXTERNA.BASE.Conteudo);
      TabGlobal_i.DBDADOS.AtualizaSql;
      TabGlobal_i.DBDADOS.First;

      FormPrincipal.Texto.Lines.Add('    constructor Create(AOwner: TComponent); override;');
      FormPrincipal.Texto.Lines.Add('    procedure Criar; override;');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('implementation');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('constructor TST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+'.Create(AOwner: TComponent);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited Create(AOwner);');
      FormPrincipal.Texto.Lines.Add('  Name             := '+#39+'SC'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+#39+';');
      FormPrincipal.Texto.Lines.Add('  NomeProcedure    := '+#39+UpperCase(Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo))+#39+';');
      FormPrincipal.Texto.Lines.Add('  StoredProcName   := NomeProcedure;');
      FormPrincipal.Texto.Lines.Add('  Database         := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  Transaction      := BaseDados.TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  DatabaseName     := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName;');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      Lista := TStringList.Create;
      for I:=0 to TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo.Count-1 do
      begin
        StringToArray(TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo[I], ';', Lista);
        if Lista.Count > 1 then
        begin
          FormPrincipal.Texto.Lines.Add('  if Params.FindParam('+#39+Lista[0]+#39+') <> nil then');
          FormPrincipal.Texto.Lines.Add('  begin');
          FormPrincipal.Texto.Lines.Add('    ParamByName('+#39+Lista[0]+#39+').DataType := '+DB_DataType(Lista[3])+';');
          if LowerCase(Lista[1]) = 'sim' then
            FormPrincipal.Texto.Lines.Add('    ParamByName('+#39+Lista[0]+#39+').ParamType := ptInput;');
          if LowerCase(Lista[2]) = 'sim' then
            FormPrincipal.Texto.Lines.Add('    ParamByName('+#39+Lista[0]+#39+').ParamType := ptOutPut;');
          FormPrincipal.Texto.Lines.Add('  end;');
        end;
      end;
      Lista.Free;
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+'.Criar;');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  Script: TSQLScript;');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  if FindProcedure(Database, NomeProcedure) then');
      FormPrincipal.Texto.Lines.Add('    exit;');
      FormPrincipal.Texto.Lines.Add('  Try');
      FormPrincipal.Texto.Lines.Add('    Script := TSQLScript.Create(Self);');
      FormPrincipal.Texto.Lines.Add('    Script.Database     := Database;');
      FormPrincipal.Texto.Lines.Add('    {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('    Script.Transaction  := Transaction;');
      FormPrincipal.Texto.Lines.Add('    with Script.Script do');
      FormPrincipal.Texto.Lines.Add('    {$ELSE}');
      FormPrincipal.Texto.Lines.Add('    Script.DatabaseName := DatabaseName;');
      FormPrincipal.Texto.Lines.Add('    Script.TermChar     := #0;');
      FormPrincipal.Texto.Lines.Add('    Script.ParamCheck   := False;');
      FormPrincipal.Texto.Lines.Add('    with Script.SQL do');
      FormPrincipal.Texto.Lines.Add('    {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('    begin');
      FormPrincipal.Texto.Lines.Add('      {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('      Add(''SET TERM ^ ;'');');
      FormPrincipal.Texto.Lines.Add('      {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('      Add('+#39+'CREATE PROCEDURE '+#39+'+NomeProcedure);');
      Primeira := True;
      Lista := TStringList.Create;
      for I:=0 to TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo.Count-1 do
      begin
        StringToArray(TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo[I], ';', Lista);
        if Lista.Count > 1 then
          if LowerCase(Lista[1]) = 'sim' then
          begin
            if Primeira then
            begin
              FormPrincipal.Texto.Lines.Add('      Add('+#39+'                 ('+#39+');');
              Primeira := False;
            end;
            Parametro := Lista[3];
            if (LowerCase(Lista[3]) = 'decimal') or
               (LowerCase(Lista[3]) = 'numeric') then
              Parametro := Parametro + '('+Lista[4]+', '+Lista[5]+')'
            else if (LowerCase(Lista[3]) = 'varchar') or
                    (LowerCase(Lista[3]) = 'char') then
              Parametro := Parametro + '('+Lista[4]+')';
            Parametro := Parametro + ',';
            FormPrincipal.Texto.Lines.Add('      Add('+#39+'                 '+Lista[0]+' '+Parametro+#39+');');
          end;
      end;
      Lista.Free;
      if not Primeira then
      begin
        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := Copy(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1], 01, Length(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1])-4) + #39+');';
        FormPrincipal.Texto.Lines.Add('      Add('+#39+'                 )'+#39+');');
      end;
      Primeira := True;
      Lista := TStringList.Create;
      for I:=0 to TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo.Count-1 do
      begin
        StringToArray(TabGlobal_i.DPROC_EXTERNA.PARAMETROS.Conteudo[I], ';', Lista);
        if Lista.Count > 1 then
          if LowerCase(Lista[2]) = 'sim' then
          begin
            if Primeira then
            begin
              FormPrincipal.Texto.Lines.Add('      Add('+#39+'                 RETURNS ('+#39+');');
              Primeira := False;
            end;
            Parametro := Lista[3];
            if (LowerCase(Lista[3]) = 'decimal') or
               (LowerCase(Lista[3]) = 'numeric') then
              Parametro := Parametro + '('+Lista[4]+', '+Lista[5]+')'
            else if (LowerCase(Lista[3]) = 'varchar') or
                    (LowerCase(Lista[3]) = 'char') then
              Parametro := Parametro + '('+Lista[4]+')';
            Parametro := Parametro + ',';
            FormPrincipal.Texto.Lines.Add('      Add('+#39+'                 '+Lista[0]+' '+Parametro+#39+');');
          end;
      end;
      Lista.Free;
      if not Primeira then
      begin
        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := Copy(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1], 01, Length(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1])-4) + #39+');';
        FormPrincipal.Texto.Lines.Add('      Add('+#39+'                 )'+#39+');');
      end;
      FormPrincipal.Texto.Lines.Add('      Add('+#39+'AS'+#39+');');
      for I:=0 to TabGlobal_i.DPROC_EXTERNA.BLOCO_SQL.Conteudo.Count-1 do
        FormPrincipal.Texto.Lines.Add('      Add('+AtribuiAspas(TabGlobal_i.DPROC_EXTERNA.BLOCO_SQL.Conteudo[I])+');');
      FormPrincipal.Texto.Lines.Add('      {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('      Add(''^'');');
      FormPrincipal.Texto.Lines.Add('      Add(''SET TERM ; ^'');');
      FormPrincipal.Texto.Lines.Add('      {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('    end;');
      FormPrincipal.Texto.Lines.Add('    Script.Executar;');
      FormPrincipal.Texto.Lines.Add('  Finally');
      FormPrincipal.Texto.Lines.Add('    Script.Free;');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('end.');
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+'.Pas');
      FormPrincipal.Texto.Lines.Clear;
    end;
    TabGlobal_i.DPROC_EXTERNA.Next;
  end;
end;

procedure Gera_CTriggers;
var
  I: Integer;
  Lista: TStringList;
  Parametro: String;
  Primeira: Boolean;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  TabGlobal_i.DTRIGGER.Filtro := '';
  TabGlobal_i.DTRIGGER.AtualizaSql;
  TabGlobal_i.DTRIGGER.First;
  while not TabGlobal_i.DTRIGGER.Eof do
  begin
    if (Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TR', TabGlobal_i.DTRIGGER.NUMERO.Conteudo, TabGlobal_i.DTRIGGER.ATIVO.Conteudo) = 1) and
       (PTabela(TabGlobal_i.DTABELAS, ['NUMERO'], [TabGlobal_i.DTRIGGER.NUMERO.Conteudo])) then
    begin
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines[0] := '{';
      FormPrincipal.Texto.Lines.Add(' Classe de trigger: '+TabGlobal_i.DTRIGGER.NOME.Conteudo + ' - ' + TabGlobal_i.DTRIGGER.DESCRICAO.Conteudo.Text);
      FormPrincipal.Texto.Lines.Add('}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('unit TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('interface');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('{$I Princ.inc}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses Tabela, BaseD, classes,');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  XSEngine,');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  DB;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('type');
      FormPrincipal.Texto.Lines.Add('  TTR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+' = class(TSQLScript)');
      FormPrincipal.Texto.Lines.Add('  public');

      TabGlobal_i.DTABELAS.FILTRO := 'NUMERO = '+IntToStr(TabGlobal_i.DTRIGGER.NUMERO.Conteudo);
      TabGlobal_i.DTABELAS.AtualizaSql;

      TabGlobal_i.DBDADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.BASE.Conteudo);
      TabGlobal_i.DBDADOS.AtualizaSql;
      TabGlobal_i.DBDADOS.First;

      FormPrincipal.Texto.Lines.Add('    constructor Create(AOwner: TComponent); override;');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('implementation');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('constructor TTR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+'.Create(AOwner: TComponent);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited Create(AOwner);');
      FormPrincipal.Texto.Lines.Add('  Name             := '+#39+'SC'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+#39+';');
      FormPrincipal.Texto.Lines.Add('  NomeTrigger      := '+#39+UpperCase(Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo))+#39+';');
      FormPrincipal.Texto.Lines.Add('  NomeTabela       := '+#39+NomeFisicoTabela+#39+';');
      FormPrincipal.Texto.Lines.Add('  Database         := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  Transaction      := BaseDados.TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  with Script do');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  DatabaseName     := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName;');
      FormPrincipal.Texto.Lines.Add('  TermChar         := #0;');
      FormPrincipal.Texto.Lines.Add('  ParamCheck       := False;');
      FormPrincipal.Texto.Lines.Add('  with SQL do');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  begin');
      FormPrincipal.Texto.Lines.Add('    {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('    Add(''SET TERM ^ ;'');');
      FormPrincipal.Texto.Lines.Add('    {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('    Add('+#39+'CREATE TRIGGER '+#39+'+NomeTrigger+ '+#39+' FOR '+NomeFisicoTabela+#39+');');
      FormPrincipal.Texto.Lines.Add('    Add('+#39+'  ACTIVE'+#39+');');
      if TabGlobal_i.DTRIGGER.INSTANTE_ATIVACAO.Conteudo = 1 then
        FormPrincipal.Texto.Lines.Add('    Add('+#39+'  BEFORE'+#39+');')
      else
        FormPrincipal.Texto.Lines.Add('    Add('+#39+'  AFTER'+#39+');');
      case TabGlobal_i.DTRIGGER.DISPARAR.Conteudo of
        1: FormPrincipal.Texto.Lines.Add('    Add('+#39+'  INSERT'+#39+');');
        2: FormPrincipal.Texto.Lines.Add('    Add('+#39+'  UPDATE'+#39+');');
        3: FormPrincipal.Texto.Lines.Add('    Add('+#39+'  DELETE'+#39+');');
      end;
      FormPrincipal.Texto.Lines.Add('    Add('+#39+'AS'+#39+');');
      for I:=0 to TabGlobal_i.DTRIGGER.BLOCO_SQL.Conteudo.Count-1 do
        FormPrincipal.Texto.Lines.Add('    Add('+AtribuiAspas(TabGlobal_i.DTRIGGER.BLOCO_SQL.Conteudo[I])+');');
      FormPrincipal.Texto.Lines.Add('    {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('    Add(''^'');');
      FormPrincipal.Texto.Lines.Add('    Add(''SET TERM ; ^'');');
      FormPrincipal.Texto.Lines.Add('    {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('end.');
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+'.Pas');
      FormPrincipal.Texto.Lines.Clear;
    end;
    TabGlobal_i.DTRIGGER.Next;
  end;
end;

procedure Gera_Ctabelas;
Var
  I, Y, T, NrCasas_D: Integer;

  Primeira, TemProcesso, L_view : Boolean;
  ConjChave, ConjChTit, NomeFisico, NomeFisico_2: String;
  NomeTabChave: Variant;
  ConjAtrl: String;
  ContAtrl: Integer;
  Chave, Linha: String;
  ListaConjVl: TStringList;
  ListaChaveTmp,ListaDescTmp,TabelasExtras, Campos_Chave_1, Campos_Chave_2, ListaPesq: TStringList;
  Campos_Pesq, Campos_Valor, Campos_NewOld, Campos_Editados, TituloIndice: String;
  Memo1: TSynEdit;
  Ln_Funcao: TStringList;
  nome_1_chave: String;
  Query: TIBQuery;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  FormPrincipal.Texto.Lines[0] := '{';
  FormPrincipal.Texto.Lines.Add(' Classe de tabelas');
  FormPrincipal.Texto.Lines.Add('}');
  FormPrincipal.Texto.Lines.Add('');
  Y     := 0;
  Linha := '';
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      Linha := Linha + 'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+', ';
      Inc(Y);
      if Y > 8 then
      begin
        FormPrincipal.Texto.Lines.Add(Linha);
        Linha := ''; Y := 1;
      end;
    end;
    TabGlobal_i.DTABELAS.Next;
  end;
  TabGlobal_i.DCONSULTA.First;
  while not TabGlobal_i.DCONSULTA.Eof do
  begin
    if (Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, TabGlobal_i.DCONSULTA.ATIVO.Conteudo) = 1) then
    begin
      Linha := Linha + 'CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+', ';
      Inc(Y);
      if Y > 8 then
      begin
        FormPrincipal.Texto.Lines.Add(Linha);
        Linha := ''; Y := 1;
      end;
    end;
    TabGlobal_i.DCONSULTA.Next;
  end;
  TabGlobal_i.DSQL_SCRIPT.First;
  while not TabGlobal_i.DSQL_SCRIPT.Eof do
  begin
    if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) then
    begin
      Linha := Linha + 'SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+', ';
      Inc(Y);
      if Y > 8 then
      begin
        FormPrincipal.Texto.Lines.Add(Linha);
        Linha := ''; Y := 1;
      end;
    end;
    TabGlobal_i.DSQL_SCRIPT.Next;
  end;
  TabGlobal_i.DPROC_EXTERNA.First;
  while not TabGlobal_i.DPROC_EXTERNA.Eof do
  begin
    if (Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('ST', TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo, TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo) = 1) then
    begin
      Linha := Linha + 'ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+', ';
      Inc(Y);
      if Y > 8 then
      begin
        FormPrincipal.Texto.Lines.Add(Linha);
        Linha := ''; Y := 1;
      end;
    end;
    TabGlobal_i.DPROC_EXTERNA.Next;
  end;
  TabGlobal_i.DTRIGGER.First;
  while not TabGlobal_i.DTRIGGER.Eof do
  begin
    if (Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo) <> '') and
       (TabGlobal_i.DTRIGGER.ATIVO.Conteudo = 1) and
       (PTabela(TabGlobal_i.DTABELAS, ['NUMERO'], [TabGlobal_i.DTRIGGER.NUMERO.Conteudo])) then
    begin
      Linha := Linha + 'TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+', ';
      Inc(Y);
      if Y > 8 then
      begin
        FormPrincipal.Texto.Lines.Add(Linha);
        Linha := ''; Y := 1;
      end;
    end;
    TabGlobal_i.DTRIGGER.Next;
  end;
  if Linha <> '' then
    FormPrincipal.Texto.Lines.Add(Linha);
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'LTab.Pas');
  FormPrincipal.Texto.Lines.Clear;

  FormPrincipal.Texto.Lines[0] := '{';
  FormPrincipal.Texto.Lines.Add(' Arquivos de Classe de tabelas');
  FormPrincipal.Texto.Lines.Add('}');
  FormPrincipal.Texto.Lines.Add('');
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
      FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' in '+#39+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.Pas'+#39+',');
    TabGlobal_i.DTABELAS.Next;
  end;
  TabGlobal_i.DCONSULTA.First;
  while not TabGlobal_i.DCONSULTA.Eof do
  begin
    if (Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, TabGlobal_i.DCONSULTA.ATIVO.Conteudo) = 1) then
      FormPrincipal.Texto.Lines.Add('  CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+' in '+#39+'CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+'.Pas'+#39+',');
    TabGlobal_i.DCONSULTA.Next;
  end;
  TabGlobal_i.DSQL_SCRIPT.First;
  while not TabGlobal_i.DSQL_SCRIPT.Eof do
  begin
    if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) then
      FormPrincipal.Texto.Lines.Add('  SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+' in '+#39+'SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Pas'+#39+',');
    TabGlobal_i.DSQL_SCRIPT.Next;
  end;
  TabGlobal_i.DPROC_EXTERNA.First;
  while not TabGlobal_i.DPROC_EXTERNA.Eof do
  begin
    if (Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('ST', TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo, TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo) = 1) then
      FormPrincipal.Texto.Lines.Add('  ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+' in '+#39+'ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+'.Pas'+#39+',');
    TabGlobal_i.DPROC_EXTERNA.Next;
  end;
  TabGlobal_i.DTRIGGER.First;
  while not TabGlobal_i.DTRIGGER.Eof do
  begin
    if (Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo) <> '') and
       (TabGlobal_i.DTRIGGER.ATIVO.Conteudo = 1) and
       (PTabela(TabGlobal_i.DTABELAS, ['NUMERO'], [TabGlobal_i.DTRIGGER.NUMERO.Conteudo])) then
      FormPrincipal.Texto.Lines.Add('  TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+' in '+#39+'TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+'.Pas'+#39+',');
    TabGlobal_i.DTRIGGER.Next;
  end;
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'LTab.Inc');
  FormPrincipal.Texto.Lines.Clear;

  ConjAtrl:= '';
  ContAtrl:= 0;
  I       := 0;
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      inc(ContAtrl);
      ConjAtrl := ConjAtrl + 'AtrL'+StrZero(I,04)+', ';
      if ContAtrl > 6 then
      begin
        FormPrincipal.Texto.Lines.Add(ConjAtrl);
        ConjAtrl := '';
        ContAtrl := 0;
      end;
      inc(I);
    end;
    TabGlobal_i.DTABELAS.Next;
  end;
  FormPrincipal.Texto.Lines.Add(ConjAtrl);
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'AtrL.Pas');
  FormPrincipal.Texto.Lines.Clear;

  ConjAtrl:= '';
  ContAtrl:= 0;
  I       := 0;
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Add('  AtrL'+StrZero(I,04)+' in '+#39+'AtrL'+StrZero(I,04)+'.PAS'+#39+', ');
      inc(I);
    end;
    TabGlobal_i.DTABELAS.Next;
  end;
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'AtrL.Inc');
  FormPrincipal.Texto.Lines.Clear;

  I := 0;
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines[0] := '{';
      FormPrincipal.Texto.Lines.Add(' Classe da tabela: '+TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' + TabGlobal_i.DTABELAS.TITULO_T.Conteudo);
      FormPrincipal.Texto.Lines.Add('}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('unit D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('interface');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('{$I Princ.inc}');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses SysUtils, StdCtrls, Tabela, BaseD, classes, Atributo, Estrutur,');
      FormPrincipal.Texto.Lines.Add('     AtrL'+StrZero(I,04)+',');
      FormPrincipal.Texto.Lines.Add('     {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('     IBDatabase, IBSQL, IB, IBQuery, IBUpdateSQL,');
      FormPrincipal.Texto.Lines.Add('     {$ELSE}');
      FormPrincipal.Texto.Lines.Add('     XSEngine,');
      FormPrincipal.Texto.Lines.Add('     {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('     DB, Dialogs;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('type');
      FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' = class(TTabela)');
      FormPrincipal.Texto.Lines.Add('  public');

      TabGlobal_i.DBDADOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.BASE.Conteudo);
      TabGlobal_i.DBDADOS.AtualizaSql;
      TabGlobal_i.DBDADOS.First;

      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
          FormPrincipal.Texto.Lines.Add('    '+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+': TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+';');
        TabGlobal_i.DCAMPOST.Next;
      end;
      FormPrincipal.Texto.Lines.Add('    constructor Create(AOwner: TComponent); override;');
      FormPrincipal.Texto.Lines.Add('    procedure CriaForeignKeys; override;');
      FormPrincipal.Texto.Lines.Add('    function PodeExcluir: Boolean; override;');
      FormPrincipal.Texto.Lines.Add('    procedure ExclusaoCascata; override;');
      FormPrincipal.Texto.Lines.Add('    function PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''''): Boolean; overload; override;');
      FormPrincipal.Texto.Lines.Add('    function PesquisaRelacionados(Tabela: String): Boolean; overload; override;');
      FormPrincipal.Texto.Lines.Add('    procedure CalculaCampos; override;');
      FormPrincipal.Texto.Lines.Add('    procedure Parametros(Tabela: TTabela); override;');
      FormPrincipal.Texto.Lines.Add('    procedure AtribuiRelacionamentos(Atribui: Boolean = True); override;');
      FormPrincipal.Texto.Lines.Add('    procedure AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True); override;');
      FormPrincipal.Texto.Lines.Add('    procedure AtribuiMestre(DataSet: TDataSet); override;');
      FormPrincipal.Texto.Lines.Add('    procedure ProcessoDireto1(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('    procedure ProcessoDireto2(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('    procedure AtualizaCalculados(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('    procedure ProcessoInverso1(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('    procedure ProcessoInverso2(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('implementation');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses Publicas, Validar, Rotinas, Abertura, Calculos, RotinaEd;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('constructor TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.Create(AOwner: TComponent);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  inherited Create(AOwner);');
      if Trim(TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo) <> '' then
        NomeFisico := TabGlobal_i.DTABELAS.NOME_INTERNO.Conteudo
      else
        NomeFisico := TabGlobal_i.DTABELAS.NOME.Conteudo;

        
      FormPrincipal.Texto.Lines.Add('  NomeTabela       := '+#39+Trim(NomeFisico)+#39+';');
      FormPrincipal.Texto.Lines.Add('  Titulo           := '+#39+TabGlobal_i.DTABELAS.TITULO_T.Conteudo+#39+';');
      FormPrincipal.Texto.Lines.Add('  Name             := '+#39+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+';');

      // criar view
      l_view := false  ;
      if Trim(NomeFisico) <>  Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) then
         l_view := true ;


      FormPrincipal.Texto.Lines.Add('  Database         := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('  Transaction      := BaseDados.TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('  UpdateSql        := TIBUpdateSQL.Create(AOwner);');
      FormPrincipal.Texto.Lines.Add('  {$ELSE}');
      FormPrincipal.Texto.Lines.Add('  RequestLive      := True;');
      FormPrincipal.Texto.Lines.Add('  AutoRefresh      := True;');
      FormPrincipal.Texto.Lines.Add('  CachedUpdates    := True;');
      FormPrincipal.Texto.Lines.Add('  UpdateSql        := TXSQLUpdateSQL.Create(AOwner);');
      FormPrincipal.Texto.Lines.Add('  DatabaseName     := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName;');
      FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('  Local            := False;');
      if TabGlobal_i.DTABELAS.ABRIR_TABELA.Conteudo = 0 then
        FormPrincipal.Texto.Lines.Add('  Open_begin       := False;')
      else
        FormPrincipal.Texto.Lines.Add('  Open_begin       := True;');
      if TabGlobal_i.DPROJETO.BDADOS.Conteudo = 3 then
        FormPrincipal.Texto.Lines.Add('  Versao           := 5;')
      else
        FormPrincipal.Texto.Lines.Add('  Versao           := 6;');
      if TabGlobal_i.DTABELAS.USE_GENERATOR.Conteudo = 1 then
        FormPrincipal.Texto.Lines.Add('  UsarGenerator    := True;')
      else
        FormPrincipal.Texto.Lines.Add('  UsarGenerator    := False;');
      FormPrincipal.Texto.Lines.Add('  TableType        := ttTable;');
      //if TabGlobal_i.DPROJETO.BDADOS.Conteudo <= 2 then
        FormPrincipal.Texto.Lines.Add('  DataSource.Name  := '+#39+'Ds'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+';');
      TabelasExtras := TStringList.Create;
      //if TabGlobal_i.DPROJETO.BDADOS.Conteudo <= 2 then
      begin
        FormPrincipal.Texto.Lines.Add('  with UpdateSql do');
        FormPrincipal.Texto.Lines.Add('  begin');
        FormPrincipal.Texto.Lines.Add('    Name           := '+#39+'UpdSql_'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+';');
        FormPrincipal.Texto.Lines.Add('    // Exclusão de Registro');
        FormPrincipal.Texto.Lines.Add('    DeleteSQL.Add('+#39+'delete from '+Trim(NomeFisico)+#39+');');
        FormPrincipal.Texto.Lines.Add('    DeleteSQL.Add('+#39+'where'+#39+');');
        Y := 0;
        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          begin
            if Y = 0 then
              FormPrincipal.Texto.Lines.Add('    DeleteSQL.Add('+#39+'  '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
            else
              FormPrincipal.Texto.Lines.Add('    DeleteSQL.Add('+#39+'  and '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
            inc(Y);
          end;
          TabGlobal_i.DCAMPOST.Next;
        end;
        if Y = 0 then
        begin
          TabGlobal_i.DCAMPOST.First;
          while not TabGlobal_i.DCAMPOST.Eof do
          begin
            if (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 5) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 6) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 19) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 20) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 25) then
            begin
              if Y = 0 then
                FormPrincipal.Texto.Lines.Add('    DeleteSQL.Add('+#39+'  '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
              else
                FormPrincipal.Texto.Lines.Add('    DeleteSQL.Add('+#39+'  and '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
              inc(Y);
            end;
            TabGlobal_i.DCAMPOST.Next;
          end;
        end;
        FormPrincipal.Texto.Lines.Add('    // Inserção de Registro');
        FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'insert into '+Trim(NomeFisico)+#39+');');
        FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  ('+#39+');');
        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 0) and
             (TabGlobal_i.DCAMPOST.SEM_INSERT.Conteudo = 0) and
             ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
            FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  '+NomeFisicoCampo+','+#39+');');
          TabGlobal_i.DCAMPOST.Next;
        end;
        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);
        FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  )'+#39+');');
        FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'values'+#39+');');
        FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  ('+#39+');');
        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 0) and
             (TabGlobal_i.DCAMPOST.SEM_INSERT.Conteudo = 0) and
             ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
          begin
            if Trim(TabGlobal_i.DCAMPOST.SQL_EXTRA_INSERT.Conteudo) = '' then
              FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  :'+NomeFisicoCampo+','+#39+');')
            else
              FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  '+TabGlobal_i.DCAMPOST.SQL_EXTRA_INSERT.Conteudo+','+#39+');');
          end;
          TabGlobal_i.DCAMPOST.Next;
        end;
        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);
        FormPrincipal.Texto.Lines.Add('    InsertSQL.Add('+#39+'  )'+#39+');');
        FormPrincipal.Texto.Lines.Add('    // Modificação de Registro');
        FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'update '+Trim(NomeFisico)+#39+');');
        FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'set'+#39+');');
        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 0) and
             (TabGlobal_i.DCAMPOST.SEM_INSERT.Conteudo = 0) and
             ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
            FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'  '+NomeFisicoCampo+' = :'+NomeFisicoCampo+','+#39+');');
          TabGlobal_i.DCAMPOST.Next;
        end;
        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);
        FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'where'+#39+');');
        Y := 0;
        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          begin
            if Y = 0 then
              FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'  '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
            else
              FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'  and '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
            inc(Y);
          end;
          TabGlobal_i.DCAMPOST.Next;
        end;
        if Y = 0 then
        begin
          TabGlobal_i.DCAMPOST.First;
          while not TabGlobal_i.DCAMPOST.Eof do
          begin
            if (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 5) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 6) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 19) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 20) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 25) then
            begin
              if Y = 0 then
                FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'  '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
              else
                FormPrincipal.Texto.Lines.Add('    ModifySQL.Add('+#39+'  and '+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
              inc(Y);
            end;
            TabGlobal_i.DCAMPOST.Next;
          end;
        end;
        //FormPrincipal.Texto.Lines.Add('    {$IFDEF IBX}');


        FormPrincipal.Texto.Lines.Add('    // Refresh de Registro');
        FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'Select'+#39+');');

        //////////////////////////////
        // gerendo o select da tabela
        //////////////////////////////

        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
             ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
            if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then                                                                                                                        // NomeFisicoObjeto
//            FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' AS '+NomeFisicoCampo+','+#39+');')
              FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' AS '+ NomeFisicoObjeto +','+#39+');')
            else  // l_view
              if l_view then
//                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' AS '+NomeFisicoCampo+','+#39+');')
                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' AS '+NomeFisicoObjeto+','+#39+');')
              else
//                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoCampo+','+#39+');');
                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoObjeto+','+#39+');');

          TabGlobal_i.DCAMPOST.Next;
        end;

        FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);

        if l_view then begin
           // criando o sub select
           FormPrincipal.Texto.Lines.Add('    // CRIANDO SUB-SELECT 1 ');
           // INICIO DE SUB-SELECT
           FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'from ( SELECT '+#39+'); // inicio sub-select ');
           // [

           TabGlobal_i.DCAMPOST.First;
           while not TabGlobal_i.DCAMPOST.Eof do
           begin
             if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
                ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
               if NOT ( TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 ) then
                  FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoCampo+','+#39+');');
//                  FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoObjeto+','+#39+');');
             TabGlobal_i.DCAMPOST.Next;
           end;
           // retira a ultima virgula
           FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);
//           FormPrincipal.Texto.Lines.SaveToFile('teste4.txt');

           // ]
           FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'from '+Trim(NomeFisico)+#39+'); // fim sub-select');
           // FIM DE SUB-SELECT
           FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+' ) AS  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+' );');
        end
        else
           FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'from '+Trim(NomeFisico)+#39+');');


        TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND ATIVO = 1';
        //TabGlobal_i.DRELACIONA.ChaveIndice := 'SEQUENCIA DESC';
        TabGlobal_i.DRELACIONA.AtualizaSql;
        TabGlobal_i.DRELACIONA.First;
        while not TabGlobal_i.DRELACIONA.Eof do
        begin
          if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
          begin
            if TabelasExtras.IndexOf(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)) = -1 then
            begin
              NomeFisico_2 := Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
              if PTabela(TabGlobal_i.DTABELAS,['UPPER(NOME)'],[UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))],['NOME_INTERNO'],NomeTabChave) then
                if NomeTabChave[0] <> Null then
                  if Trim(NomeTabChave[0]) <> '' then
                    NomeFisico_2 := Trim(NomeTabChave[0]);

              if NomeFisico_2 <> TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo then
                FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'Left Outer Join '+NomeFisico_2+ ' ' + Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo) + ' on'+#39+');')
              else
                FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'Left Outer Join '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+ ' on'+#39+');');


              Campos_Chave_1 := TStringList.Create;
              Campos_Chave_2 := TStringList.Create;
              StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
              StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
              if Campos_Chave_1.Count = Campos_Chave_2.Count then
                for Y:=0 to Campos_Chave_1.Count-1 do
                begin
                  TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND UPPER(NOME) = '+#39+UpperCase(Trim(Campos_Chave_1[Y]))+#39;
                  TabGlobal_i.DCAMPOST.AtualizaSql;
                  TabGlobal_i.DCAMPOST.First;
                  if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1) then
                  begin
                    if Y > 0 then
                      FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                    else
                      FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');
                  end
                  else
                  begin
                    if Y > 0 then BEGIN
                      if l_view then
                         FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                      ELSE
                         FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(NomeFisico)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');

                    END
                    else
                      if l_view then
                         FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                      ELSE
                         FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');

                  end;
                end;
              Campos_Chave_1.Free;
              Campos_Chave_2.Free;
              TabelasExtras.Add(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo));
            end;
          end;
          TabGlobal_i.DRELACIONA.Next;
        end;
        //TabGlobal_i.DRELACIONA.ChaveIndice := TabGlobal_i.DRELACIONA.ChPrimaria;
        TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        TabGlobal_i.DCAMPOST.AtualizaSql;

        ////////////////////////
        // WHERE
        ////////////////////////

        FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'where'+#39+');');
        Y := 0;
        TabGlobal_i.DCAMPOST.First;
        while not TabGlobal_i.DCAMPOST.Eof do
        begin
          if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
          begin
            if Y = 0 then begin
              if l_view then
                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
              else
                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
            end
            else begin
              if l_view then
                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
              else
                 FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
            end;
            inc(Y);
          end;
          TabGlobal_i.DCAMPOST.Next;
        end;
        if Y = 0 then
        begin
          TabGlobal_i.DCAMPOST.First;
          while not TabGlobal_i.DCAMPOST.Eof do
          begin
            if (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 5) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 6) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 19) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 20) and
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo <> 25) then
            begin
              if Y = 0 then begin
                if l_view then
                   FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
                else
                   FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
              end
              else begin
                if l_view then
                   FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');')
                else
                   FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' = :OLD_'+NomeFisicoCampo+#39+');');
              end;
              inc(Y);
            end;
            TabGlobal_i.DCAMPOST.Next;
          end;
        end;
        {TabGlobal_i.DRELACIONA.First;
        while not TabGlobal_i.DRELACIONA.Eof do
        begin
          if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
          begin
            Campos_Chave_1 := TStringList.Create;
            Campos_Chave_2 := TStringList.Create;
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
            if Campos_Chave_1.Count = Campos_Chave_2.Count then
              for Y:=0 to Campos_Chave_1.Count-1 do
              begin
                TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND UPPER(NOME) = '+#39+UpperCase(Trim(Campos_Chave_1[Y]))+#39;
                TabGlobal_i.DCAMPOST.AtualizaSql;
                TabGlobal_i.DCAMPOST.First;
                if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1) then
                  FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                else
                  FormPrincipal.Texto.Lines.Add('    RefreshSQL.Add('+#39+'  and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');
              end;
            Campos_Chave_1.Free;
            Campos_Chave_2.Free;
          end;
          TabGlobal_i.DRELACIONA.Next;
        end;}
        //FormPrincipal.Texto.Lines.Add('    {$ENDIF}');
        FormPrincipal.Texto.Lines.Add('  end;');
        For Y:=0 to TabelasExtras.Count-1 do
          FormPrincipal.Texto.Lines.Add('  TabelasExtras.Add('+#39+TabelasExtras[Y]+#39+');');
        FormPrincipal.Texto.Lines.Add('  UpdateObject     := UpdateSql;');
      end;
      /////////////////////////////////////////
      /// // Sql Principal
      /////////////////////////////////////////

      FormPrincipal.Texto.Lines.Add('    // Sql Principal');


      FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'Select'+#39+');');
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
           ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
          if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then                                                                                                                     //  NomeFisicoObjeto
//             FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' AS '+NomeFisicoCampo+','+#39+');')
             FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' AS '+NomeFisicoObjeto+','+#39+');')
          else begin
            if l_view then
//               FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' AS '+NomeFisicoCampo+','+#39+');')
               FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo+' AS '+NomeFisicoObjeto+','+#39+');')
            else
//               FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoCampo+','+#39+');');
               FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'  '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoObjeto+','+#39+');');
          end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);
      if l_view then begin
         // inicio bo subselect
         FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'from ( select      '+#39+');  // inicio de sub-select');
         // [

         TabGlobal_i.DCAMPOST.First;
         while not TabGlobal_i.DCAMPOST.Eof do
         begin
           if (Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '') and
              ((TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 0) or (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1)) then
             if not ( TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 ) then
               FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'       '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoCampo+','+#39+');');
//               FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'       '+Trim(NomeFisico)+'.'+NomeFisicoCampo+' AS '+NomeFisicoObjeto+','+#39+');');

           TabGlobal_i.DCAMPOST.Next;
         end;
         FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1] := TrocaString(FormPrincipal.Texto.Lines[FormPrincipal.Texto.Lines.Count-1],',','',[rfReplaceAll]);

         FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'       from  '+Trim(NomeFisico)+#39+'); // fim de sub-select');
         // ]
         FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'     ) as  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+');');
      end
      else
         FormPrincipal.Texto.Lines.Add('  SqlPrincipal.Add('+#39+'from '+Trim(NomeFisico)+#39+');');

      FormPrincipal.Texto.Lines.Add('  Sql.AddStrings(SqlPrincipal);');
      
      //////////////////////////////////
      //// // Foreign Key
      //////////////////////////////////

      FormPrincipal.Texto.Lines.Add('    // Foreign Key');
      TabGlobal_i.DRELACIONA.First;
      Campos_Chave_1 := TStringList.Create;
      Campos_Chave_2 := TStringList.Create;
      while not TabGlobal_i.DRELACIONA.Eof do
      begin
        StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
        StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
        if (TabGlobal_i.DRELACIONA.KEY_SQL.Conteudo = 1) and (TabGlobal_i.DRELACIONA.ATIVO.Conteudo = 1) and
           (Campos_Chave_1.Count = Campos_Chave_2.Count) then
        begin
          PTabela(TabGlobal_i.DTABELAS,['UPPER(NOME)'],[UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))],['NOME_INTERNO'],NomeTabChave);
          NomeFisico_2 := Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
          if NomeTabChave[0] <> Null then
            if Trim(NomeTabChave[0]) <> '' then
              NomeFisico_2 := Trim(NomeTabChave[0]);
          if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
          begin
            FormPrincipal.Texto.Lines.Add('  ForeignKeys.Add('+#39+'Alter Table '+Trim(NomeFisico)+' Add Foreign Key (' + TrocaString(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',',',[rfReplaceAll]) + ')' +#39+');');
            FormPrincipal.Texto.Lines.Add('  ForeignKeys.Add('+#39+'  References '+Trim(NomeFisico_2)+ '(' + TrocaString(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',',',[rfReplaceAll]) + ')' +#39+');');
          end
          else
          begin
            FormPrincipal.Texto.Lines.Add('  ForeignKeys.Add('+#39+'Alter Table '+Trim(NomeFisico_2)+' Add Foreign Key (' + TrocaString(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',',',[rfReplaceAll]) + ')' +#39+');');
            FormPrincipal.Texto.Lines.Add('  ForeignKeys.Add('+#39+'  References '+Trim(NomeFisico)+ '(' + TrocaString(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',',',[rfReplaceAll]) + ')' +#39+');');
            if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 3 then
              FormPrincipal.Texto.Lines.Add('  ForeignKeys.Add('+#39+'  On Delete Cascade' +#39+');');
          end;
          FormPrincipal.Texto.Lines.Add('  ForeignKeys.Add('+#39+';' +#39+');');
        end;
        TabGlobal_i.DRELACIONA.Next;
      end;
      Campos_Chave_1.Free;
      Campos_Chave_2.Free;

      TabGlobal_i.DRELACIONA.First;
      Primeira := True;
      while not TabGlobal_i.DRELACIONA.Eof do
      begin
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
        begin
          Campos_Chave_1 := TStringList.Create;
          Campos_Chave_2 := TStringList.Create;
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
          if Campos_Chave_1.Count = Campos_Chave_2.Count then
            for Y:=0 to Campos_Chave_1.Count-1 do
            begin
              TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND UPPER(NOME) = '+#39+UpperCase(Trim(Campos_Chave_1[Y]))+#39;
              TabGlobal_i.DCAMPOST.AtualizaSql;
              TabGlobal_i.DCAMPOST.First;
              PTabela(TabGlobal_i.DTABELAS,['UPPER(NOME)'],[UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))],['NOME_INTERNO'],NomeTabChave);
              NomeFisico_2 := Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
              if NomeTabChave[0] <> Null then
                if Trim(NomeTabChave[0]) <> '' then
                  NomeFisico_2 := Trim(NomeTabChave[0]);
              if Y = 0 then
              begin
                if NomeFisico_2 <> TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo then
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'Left Outer Join '+NomeFisico_2+ ' ' + Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo) +' on'+#39+');')
                else
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'Left Outer Join '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+' on'+#39+');');
                Primeira := True;
              end;
              if Primeira then
              begin
                if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1) then
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                else begin
                
                  // view
                  if l_view then
                     FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                  else
                     FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  '+Trim(NomeFisico)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');

                end;
                Primeira := False;
              end
              else
              begin
                if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1) then
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  and '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                else begin
                  if l_view then
                     FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                  else
                     FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  and '+Trim(NomeFisico)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');

                end;
              end;
            end;
          Primeira := False;
          Campos_Chave_1.Free;
          Campos_Chave_2.Free;
        end;
        TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        TabGlobal_i.DCAMPOST.AtualizaSql;
        TabGlobal_i.DRELACIONA.Next;
      end;

      {TabGlobal_i.DRELACIONA.First;
      Primeira := True;
      while not TabGlobal_i.DRELACIONA.Eof do
      begin
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
        begin
          Campos_Chave_1 := TStringList.Create;
          Campos_Chave_2 := TStringList.Create;
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
          if Campos_Chave_1.Count = Campos_Chave_2.Count then
            for Y:=0 to Campos_Chave_1.Count-1 do
            begin
              TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND UPPER(NOME) = '+#39+UpperCase(Trim(Campos_Chave_1[Y]))+#39;
              TabGlobal_i.DCAMPOST.AtualizaSql;
              TabGlobal_i.DCAMPOST.First;
              if Primeira then
              begin
                if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1) then
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                else
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');
                Primeira := False;
              end
              else
              begin
                if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1) then
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  and '+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');')
                else
                  FormPrincipal.Texto.Lines.Add('  FiltroExtra.Add('+#39+'  and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_1[Y])+' = '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+#39+');');
              end;
            end;
          Primeira := False;
          Campos_Chave_1.Free;
          Campos_Chave_2.Free;
        end;
        TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        TabGlobal_i.DCAMPOST.AtualizaSql;
        TabGlobal_i.DRELACIONA.Next;
      end;}
      Chave := '';
      TituloIndice := '';
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
        begin
          if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
            Chave := Chave + Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+'.'+TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo + ','
          else begin
            if l_view then
               Chave := Chave + Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+NomeFisicoCampo + ','
            else
               Chave := Chave + Trim(NomeFisico)+'.'+NomeFisicoCampo + ',';
          end;

          if Trim(TituloIndice) = '' then
            TituloIndice := Trim(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo)
          else
            TituloIndice := TituloIndice + ',' + Trim(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo);
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      for Y:=0 to TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo.Count-1 do
        if Trim(TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo[Y]) <> '' then
          FormPrincipal.Texto.Lines.Add('  Filtro.Add('+#39+TabGlobal_i.DTABELAS.FILTRO_INICIAL.Conteudo[Y]+#39+');');
      for Y:=0 to TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo.Count-1 do
        if Trim(TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo[Y]) <> '' then
          FormPrincipal.Texto.Lines.Add('  FiltroFixo.Add('+#39+TabGlobal_i.DTABELAS.FILTRO_MESTRE.Conteudo[Y]+#39+');');
      if Copy(Chave,Length(Chave),1) = ',' then
        Chave := Copy(Chave,1,Length(Chave)-1);
      if Trim(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo) = '' then
        FormPrincipal.Texto.Lines.Add('  Sql.Add('+#39+'order by '+Chave+#39+');')
      else
      begin
        if TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('  Sql.Add('+#39+'order by '+TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo+' DESC'+#39+');')
        else
          FormPrincipal.Texto.Lines.Add('  Sql.Add('+#39+'order by '+TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo+#39+');');
      end;
      TabGlobal_i.DCAMPOST.ChaveIndice := 'INDICE_CONSULTA';
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
        begin
          FormPrincipal.Texto.Lines.Add('  '+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+' := TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'.Create(AOwner);');
          FormPrincipal.Texto.Lines.Add('  '+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'.Valor.DataSet := Self;');
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      TabGlobal_i.DCAMPOST.ChaveIndice := TabGlobal_i.DCAMPOST.ChPrimaria;
      TabGlobal_i.DCAMPOST.AtualizaSql;

      ////////////////////////
      //CRIANDO CHAVE PRIMARIA
      ////////////////////////
      FormPrincipal.Texto.Lines.Add('//CRIANDO CHAVE PRIMARIA ');
      TabGlobal_i.DCAMPOST.First;
      nome_1_chave := '';
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
        begin
          FormPrincipal.Texto.Lines.Add('  ChavePrimaria.Add('+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+');');
          if Trim(nome_1_chave) = '' then
            nome_1_chave := Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo);
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;

      ////////////////////////
      //CRIANDO CAMPOS 
      ////////////////////////


      FormPrincipal.Texto.Lines.Add('//CRIANDO CAMPOS ');
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
          FormPrincipal.Texto.Lines.Add('  Campos.Add('+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+');');
        TabGlobal_i.DCAMPOST.Next;
      end;
      if Trim(Chave) <> '' then
      begin
        FormPrincipal.Texto.Lines.Add('  TituloIndices.Add('+#39+TituloIndice+#39+');');
        FormPrincipal.Texto.Lines.Add('  Indices.Add('+#39+Chave+#39+');');
        FormPrincipal.Texto.Lines.Add('  Crescente.Add('+#39+'S'+#39+');');
      end;
      FormPrincipal.Texto.Lines.Add('  TituloPrimaria := '+#39+TituloIndice+#39+';');
      FormPrincipal.Texto.Lines.Add('  ChPrimaria     := '+#39+chave+#39+';');
      TabGlobal_i.DINDICEST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DINDICEST.AtualizaSql;
      TabGlobal_i.DINDICEST.First;

      FormPrincipal.Texto.Lines.Add('//CRIANDO TituloIndices ');

      while not TabGlobal_i.DINDICEST.Eof do
      begin
         if Trim(Chave) = '' then
         begin
           TituloIndice := TabGlobal_i.DINDICEST.TITULO_I.Conteudo;
           Chave := TrocaString(TabGlobal_i.DINDICEST.CAMPOST.Conteudo, ';', ',', [rfReplaceAll]);
         end;
         FormPrincipal.Texto.Lines.Add('  TituloIndices.Add('+#39+TabGlobal_i.DINDICEST.TITULO_I.Conteudo+#39+');');
         FormPrincipal.Texto.Lines.Add('  Indices.Add('+#39+TabGlobal_i.DINDICEST.CAMPOST.Conteudo+#39+');');
         if TabGlobal_i.DINDICEST.CRESCENTE.Conteudo = 1 then
           FormPrincipal.Texto.Lines.Add('  Crescente.Add('+#39+'S'+#39+');')
         else
           FormPrincipal.Texto.Lines.Add('  Crescente.Add('+#39+'N'+#39+');');
        TabGlobal_i.DINDICEST.Next;
      end;
      if Trim(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo) = '' then
      begin
        FormPrincipal.Texto.Lines.Add('  TituloIndice   := '+#39+TituloIndice+#39+';');
        FormPrincipal.Texto.Lines.Add('  ChaveIndice    := '+#39+chave+#39+';')
      end
      else
      begin
        Campos_Chave_1 := TStringList.Create;
        TituloIndice := TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo;
        TituloIndice := TrocaString(TituloIndice,Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.','',[rfReplaceAll, rfIgnoreCase]);
        for Y:=0 to TabelasExtras.Count-1 do
          TituloIndice := TrocaString(TituloIndice,TabelasExtras[Y]+'.','',[rfReplaceAll, rfIgnoreCase]);
        StringToArray(TituloIndice,',',Campos_Chave_1);
        TituloIndice := '';
        for Y:=0 to Campos_Chave_1.Count-1 do
        begin
          TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND UPPER(NOME) = '+#39+UpperCase(Trim(Campos_Chave_1[Y]))+#39;
          TabGlobal_i.DCAMPOST.AtualizaSql;
          TabGlobal_i.DCAMPOST.First;
          if not TabGlobal_i.DCAMPOST.Eof then
            if Trim(TituloIndice) = '' then
              TituloIndice := Trim(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo)
            else
              TituloIndice := TituloIndice + ',' + Trim(TabGlobal_i.DCAMPOST.TITULO_C.Conteudo);
        end;
        Campos_Chave_1.Free;
        FormPrincipal.Texto.Lines.Add('  TituloIndice   := '+#39+TituloIndice+#39+';');
        if TabGlobal_i.DTABELAS.ORDEM_DECRESCENTE.Conteudo = 1 then
          FormPrincipal.Texto.Lines.Add('  ChaveIndice    := '+#39+Trim(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo)+' DESC'+#39+';')
        else
          FormPrincipal.Texto.Lines.Add('  ChaveIndice    := '+#39+Trim(TabGlobal_i.DTABELAS.ORDEM_INICIAL.Conteudo)+#39+';');
      end;
      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabelasExtras.Free;
      FormPrincipal.Texto.Lines.Add('  AfterInsert    := AtribuiMestre;');
      FormPrincipal.Texto.Lines.Add('  AfterPost      := ProcessoDireto1;');
      FormPrincipal.Texto.Lines.Add('  AfterCancel    := ProcessoDireto2;');
      FormPrincipal.Texto.Lines.Add('  BeforePost     := AtualizaCalculados;');
      FormPrincipal.Texto.Lines.Add('  BeforeEdit     := ProcessoInverso1;');
      FormPrincipal.Texto.Lines.Add('  BeforeDelete   := ProcessoInverso2;');
      //if TabGlobal_i.DPROJETO.BDADOS.Conteudo > 2 then
      //  FormPrincipal.Texto.Lines.Add('  Conexao;');
      FormPrincipal.Texto.Lines.Add('end;');

      TabGlobal_i.DRESTRITAT.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DRESTRITAT.AtualizaSql;
      TabGlobal_i.DRESTRITAT.First;
      Primeira := False;
      if not TabGlobal_i.DRESTRITAT.Eof then
        for Y:=0 to TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo.Count-1 do
          if Trim(TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo[Y]) <> '' then
          begin
            Primeira := True;
            Break;
          end;
      FormPrincipal.Texto.Lines.Add('////////////////////////////////');
      FormPrincipal.Texto.Lines.Add('//   CRIANDO PROCEDIMENTOS    //');
      FormPrincipal.Texto.Lines.Add('////////////////////////////////');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.CriaForeignKeys;');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  Script_ForeignKeys: TSQLScript;');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  if ForeignKeys.Count > 0 then');
      FormPrincipal.Texto.Lines.Add('  begin');
      FormPrincipal.Texto.Lines.Add('    Script_ForeignKeys := TSQLScript.Create(Self);');
      FormPrincipal.Texto.Lines.Add('    with Script_ForeignKeys do');
      FormPrincipal.Texto.Lines.Add('    begin');
      FormPrincipal.Texto.Lines.Add('      Database         := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('      {$IFDEF IBX}');
      FormPrincipal.Texto.Lines.Add('      Transaction      := BaseDados.TRS_BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+';');
      FormPrincipal.Texto.Lines.Add('      with Script do');
      FormPrincipal.Texto.Lines.Add('      {$ELSE}');
      FormPrincipal.Texto.Lines.Add('      DatabaseName     := BaseDados.BD_'+Trim(TabGlobal_i.DBDADOS.NOME.Conteudo)+'.DatabaseName;');
      FormPrincipal.Texto.Lines.Add('      with SQL do');
      FormPrincipal.Texto.Lines.Add('      {$ENDIF}');
      FormPrincipal.Texto.Lines.Add('      AddStrings(ForeignKeys);');
      FormPrincipal.Texto.Lines.Add('      Executar;');
      FormPrincipal.Texto.Lines.Add('      Free;');
      FormPrincipal.Texto.Lines.Add('    end;');
      FormPrincipal.Texto.Lines.Add('  end;');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.PodeExcluir: Boolean;');
      if Primeira then
      begin
        FormPrincipal.Texto.Lines.Add('Var');
        FormPrincipal.Texto.Lines.Add('  QueryP: TTabela;');
        FormPrincipal.Texto.Lines.Add('  Ok: Boolean;');
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  PodeExcluir := True;');
      FormPrincipal.Texto.Lines.Add('  if not Sistema.Integridade then');
      FormPrincipal.Texto.Lines.Add('    exit;');
      if Primeira then
      begin
        FormPrincipal.Texto.Lines.Add('  Ok := True;');
        FormPrincipal.Texto.Lines.Add('  QueryP := TTabela.Create(Self);');
      end;
      if not TabGlobal_i.DRESTRITAT.Eof then
        for Y:=0 to TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo.Count-1 do
          if Trim(TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo[Y]) <> '' then
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DRESTRITAT.CODIFICACAO.Conteudo[Y]);
      if Primeira then
      begin
         FormPrincipal.Texto.Lines.Add('  QueryP.Close;');
         FormPrincipal.Texto.Lines.Add('  QueryP.Free;');
         FormPrincipal.Texto.Lines.Add('  PodeExcluir := Ok;');
      end;
      TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND ATIVO = 1';
      TabGlobal_i.DRELACIONA.AtualizaSql;
      TabGlobal_i.DRELACIONA.First;
      while not TabGlobal_i.DRELACIONA.eof do
      begin
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 2 then
        begin
          Campos_Pesq := '';
          Campos_Valor := '';
          Campos_Chave_1 := TStringList.Create;
          Campos_Chave_2 := TStringList.Create;
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
          if Campos_Chave_1.Count = Campos_Chave_2.Count then
            for Y:=0 to Campos_Chave_1.Count-1 do
            begin
              Campos_Pesq := Campos_Pesq + #39+ Campos_Chave_2[Y] +#39 + ',';
              Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
            end;
          if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
            Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
          if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
            Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
          Campos_Chave_1.Free;
          Campos_Chave_2.Free;
          FormPrincipal.Texto.Lines.Add('  if PTabela(TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+', ['+Campos_Pesq+'], ['+Campos_Valor+']) then');
          FormPrincipal.Texto.Lines.Add('  begin');
          FormPrincipal.Texto.Lines.Add('    MessageDlg('+#39+'Registro está ligado a tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Titulo,mtError,[mbOk],0);');
          FormPrincipal.Texto.Lines.Add('    PodeExcluir := False;');
          FormPrincipal.Texto.Lines.Add('    exit;');
          FormPrincipal.Texto.Lines.Add('  end;');
        end;
        TabGlobal_i.DRELACIONA.Next;
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      TabGlobal_i.DCASCATAT.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DCASCATAT.AtualizaSql;
      TabGlobal_i.DCASCATAT.First;
      Primeira := False;
      if not TabGlobal_i.DCASCATAT.Eof then
        for Y:=0 to TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo.Count-1 do
          if Trim(TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo[Y]) <> '' then
          begin
            Primeira := True;
            Break;
          end;
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.ExclusaoCascata;');
      if Primeira then
      begin
        FormPrincipal.Texto.Lines.Add('Var');
        FormPrincipal.Texto.Lines.Add('  QueryP: TTabela;');
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      if Primeira then
        FormPrincipal.Texto.Lines.Add('  QueryP := TTabela.Create(Self);');
      if Primeira and (not TabGlobal_i.DCASCATAT.Eof) then
        for Y:=0 to TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo.Count-1 do
          FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DCASCATAT.CODIFICACAO.Conteudo[Y]);
      TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND ATIVO = 1';
      TabGlobal_i.DRELACIONA.AtualizaSql;
      TabGlobal_i.DRELACIONA.First;
      while not TabGlobal_i.DRELACIONA.eof do
      begin
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 3 then
        begin
          Campos_Chave_1 := TStringList.Create;
          Campos_Chave_2 := TStringList.Create;
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
          StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);

          FormPrincipal.Texto.Lines.Add('  // Exclusão em Cascata Tabela: D'+TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo);
          //FormPrincipal.Texto.Lines.Add('  with QueryP do');
          //FormPrincipal.Texto.Lines.Add('  begin');
          //FormPrincipal.Texto.Lines.Add('    DataBase := TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.DataBase;');
          //FormPrincipal.Texto.Lines.Add('    Transaction := TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Transaction;');
          //FormPrincipal.Texto.Lines.Add('    Sql.Clear;');
          //FormPrincipal.Texto.Lines.Add('    Sql.Add('+#39+'Delete From '+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+#39+');');
          //FormPrincipal.Texto.Lines.Add('    Sql.Add('+#39+'Where '+#39+');');
          //if Campos_Chave_1.Count = Campos_Chave_2.Count then
          //  for Y:=0 to Campos_Chave_1.Count-1 do
          //    if Y = 0 then
          //      FormPrincipal.Texto.Lines.Add('    Sql.Add('+#39+Trim(Campos_Chave_2[Y])+' = :'+Trim(Campos_Chave_2[Y])+#39+');')
          //    else
          //      FormPrincipal.Texto.Lines.Add('    Sql.Add('+#39+'AND '+Trim(Campos_Chave_2[Y])+' = :'+Trim(Campos_Chave_2[Y])+#39+');');
          //FormPrincipal.Texto.Lines.Add('    Conexao;');
          FormPrincipal.Texto.Lines.Add('  TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Filtro.Clear;');
          if Campos_Chave_1.Count = Campos_Chave_2.Count then
            for Y:=0 to Campos_Chave_1.Count-1 do
            begin
              PTabela(TabGlobal_i.DTABELAS,['UPPER(NOME)'],[UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))],['NOME_INTERNO'],NomeTabChave);
              NomeFisico_2 := TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo;
              if NomeTabChave[0] <> Null then
                if Trim(NomeTabChave[0]) <> '' then
                  NomeFisico_2 := NomeTabChave[0];
              if Y = 0 then
                FormPrincipal.Texto.Lines.Add('  TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Filtro.Add('+#39+Trim(NomeFisico_2)+'.'+Trim(Campos_Chave_2[Y])+' = :'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(Campos_Chave_1[Y])+#39+');')
              else
                FormPrincipal.Texto.Lines.Add('  TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Filtro.Add('+#39+'AND '+Trim(NomeFisico_2)+'.'+Trim(Campos_Chave_2[Y])+' = :'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(Campos_Chave_1[Y])+#39+');');
            end;
          FormPrincipal.Texto.Lines.Add('  TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.AtualizaSql;');
          FormPrincipal.Texto.Lines.Add('  while not TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Eof do');
          FormPrincipal.Texto.Lines.Add('    if not TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Exclui then');
          FormPrincipal.Texto.Lines.Add('      TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.Next;');
          //if Campos_Chave_1.Count = Campos_Chave_2.Count then
          //  for Y:=0 to Campos_Chave_1.Count-1 do
          //    FormPrincipal.Texto.Lines.Add('    ParamByName('+#39+Trim(Campos_Chave_2[Y])+#39+').Value := '+Trim(Campos_Chave_1[Y])+'.Conteudo;');
          //FormPrincipal.Texto.Lines.Add('    ExecSql;');
          //FormPrincipal.Texto.Lines.Add('  end;');
          Campos_Chave_1.Free;
          Campos_Chave_2.Free;
        end;
        TabGlobal_i.DRELACIONA.Next;
      end;
      if Primeira then
      begin
        FormPrincipal.Texto.Lines.Add('  QueryP.Close;');
        FormPrincipal.Texto.Lines.Add('  QueryP.Free;');
      end;
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.PesquisaRelacionados(Tabela, Campo: String; var Retorno: Variant; CampoFoco: String = ''''): Boolean;');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  Result := False;');
      TabGlobal_i.DCAMPOST.First;
      ListaPesq := TStringList.Create;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
        begin
          if ListaPesq.IndexOf(UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo))) = - 1 then
          begin
            TabGlobal_i.DRELACIONA.First;
            while not TabGlobal_i.DRELACIONA.Eof do
            begin
              if (TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1) and
                (UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)) = UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo))) then
              begin
                Campos_Pesq := '';
                Campos_Valor := '';
                Campos_NewOld := '';
                Campos_Editados := '';
                Campos_Chave_1 := TStringList.Create;
                Campos_Chave_2 := TStringList.Create;
                StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
                StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
                if Campos_Chave_1.Count = Campos_Chave_2.Count then
                  for Y:=0 to Campos_Chave_1.Count-1 do
                  begin
                    Campos_Pesq := Campos_Pesq + #39+ Campos_Chave_2[Y] +#39 + ',';
                    Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
                    Campos_NewOld := Campos_NewOld + ' (' + Campos_Chave_1[Y]+'.Valor.NewValue <> ' + Campos_Chave_1[Y]+'.Valor.OldValue) or';
                    Campos_Editados := Campos_Editados + ' (UpperCase(' + #39+ Campos_Chave_1[Y] + #39 +') = UpperCase(CampoFoco)) or';
                  end;
                if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
                  Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
                if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
                  Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
                if Copy(Campos_NewOld,Length(Campos_NewOld)-1,02) = 'or' then
                  Campos_NewOld := Copy(Campos_NewOld,01,Length(Campos_NewOld)-2);
                if Copy(Campos_Editados,Length(Campos_Editados)-1,02) = 'or' then
                  Campos_Editados := Copy(Campos_Editados,01,Length(Campos_Editados)-2);
                Campos_Chave_1.Free;
                Campos_Chave_2.Free;
                Break;
              end;
              TabGlobal_i.DRELACIONA.Next;
            end;
            FormPrincipal.Texto.Lines.Add('  if UpperCase(Tabela) = UpperCase('+#39+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+#39+') then');
            //FormPrincipal.Texto.Lines.Add('    if'+Campos_NewOld+'then');
            if Trim(Campos_Editados) <> '' then
              FormPrincipal.Texto.Lines.Add('    if'+Campos_Editados+'then');
            FormPrincipal.Texto.Lines.Add('      if PTabela(TabGlobal.D'+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+', ['+Campos_Pesq+'], ['+Campos_Valor+'], [Campo], Retorno) then');
            FormPrincipal.Texto.Lines.Add('        Result := True;');
            FormPrincipal.Texto.Lines.Add('');
            ListaPesq.Add(UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)));
          end;
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      ListaPesq.Free;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.PesquisaRelacionados(Tabela: String): Boolean;');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  Result := False;');
      TabGlobal_i.DCAMPOST.First;
      ListaPesq := TStringList.Create;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
        begin
          if ListaPesq.IndexOf(UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo))) = - 1 then
          begin
            TabGlobal_i.DRELACIONA.First;
            while not TabGlobal_i.DRELACIONA.Eof do
            begin
              if (TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1) and
                (UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)) = UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo))) then
              begin
                Campos_Pesq := '';
                Campos_Valor := '';
                Campos_Chave_1 := TStringList.Create;
                Campos_Chave_2 := TStringList.Create;
                StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
                StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
                if Campos_Chave_1.Count = Campos_Chave_2.Count then
                  for Y:=0 to Campos_Chave_1.Count-1 do
                  begin
                    Campos_Pesq := Campos_Pesq + #39+ Campos_Chave_2[Y] +#39 + ',';
                    Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
                  end;
                if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
                  Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
                if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
                  Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
                Campos_Chave_1.Free;
                Campos_Chave_2.Free;
                Break;
              end;
              TabGlobal_i.DRELACIONA.Next;
            end;
            if Trim(Campos_Pesq) <> '' then
            begin
              FormPrincipal.Texto.Lines.Add('  if UpperCase(Tabela) = UpperCase('+#39+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+#39+') then');
              FormPrincipal.Texto.Lines.Add('    if PTabela(TabGlobal.D'+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+', ['+Campos_Pesq+'], ['+Campos_Valor+']) then');
              FormPrincipal.Texto.Lines.Add('      Result := True;');
              FormPrincipal.Texto.Lines.Add('');
            end;  
            ListaPesq.Add(UpperCase(Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)));
          end;
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND ATIVO = 1';
      TabGlobal_i.DRELACIONA.AtualizaSql;
      TabGlobal_i.DRELACIONA.First;
      while not TabGlobal_i.DRELACIONA.Eof do
      begin
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 1 then
          if ListaPesq.IndexOf(UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo))) = - 1 then
          begin
            Campos_Pesq := '';
            Campos_Valor := '';
            Campos_Chave_1 := TStringList.Create;
            Campos_Chave_2 := TStringList.Create;
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
            if Campos_Chave_1.Count = Campos_Chave_2.Count then
              for Y:=0 to Campos_Chave_1.Count-1 do
              begin
                Campos_Pesq := Campos_Pesq + #39+ Campos_Chave_2[Y] +#39 + ',';
                Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
              end;
            if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
              Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
            if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
              Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
            Campos_Chave_1.Free;
            Campos_Chave_2.Free;
            if Trim(Campos_Pesq) <> '' then
            begin
              FormPrincipal.Texto.Lines.Add('  if UpperCase(Tabela) = UpperCase('+#39+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+#39+') then');
              FormPrincipal.Texto.Lines.Add('    if PTabela(TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+', ['+Campos_Pesq+'], ['+Campos_Valor+']) then');
              FormPrincipal.Texto.Lines.Add('      Result := True;');
              FormPrincipal.Texto.Lines.Add('');
            end;
            ListaPesq.Add(UpperCase(Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)));
          end;
        TabGlobal_i.DRELACIONA.Next;
      end;
      ListaPesq.Free;
      Campos_Pesq := ''; Campos_Valor := '';
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
        begin
          Campos_Pesq := Campos_Pesq + #39+ Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) +#39 + ',';
          Campos_Valor := Campos_Valor + Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) +'.Valor.Value,';
        end;
        TabGlobal_i.DCAMPOST.Next
      end;
      if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
        Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
      if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
        Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
      if Trim(Campos_Pesq) <> '' then
      begin
        FormPrincipal.Texto.Lines.Add('  if UpperCase(Tabela) = UpperCase('+#39+Trim(NomeFisico)+#39+') then');
        FormPrincipal.Texto.Lines.Add('    if PTabela(TabGlobal.D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+', ['+Campos_Pesq+'], ['+Campos_Valor+']) then');
        FormPrincipal.Texto.Lines.Add('      Result := True;');
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.CalculaCampos;');
      FormPrincipal.Texto.Lines.Add('begin');

      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DCAMPOST.AtualizaSql;
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1 then
        begin
          if TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1 then
            FormPrincipal.texto.Lines.Add('  '+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'.Conteudo := CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'(Self);');
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;

      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AtribuiRelacionamentos(Atribui: Boolean = True);');
      FormPrincipal.Texto.Lines.Add('begin');
      TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo) + ' AND ATIVO = 1';
      TabGlobal_i.DRELACIONA.AtualizaSql;
      TabGlobal_i.DRELACIONA.First;
      while not TabGlobal_i.DRELACIONA.Eof do
      begin
        if TabGlobal_i.DRELACIONA.TIPO.Conteudo = 3 then
          FormPrincipal.Texto.Lines.Add('  TabGlobal.D'+Trim(TabGlobal_i.DRELACIONA.TAB_ESTRANGEIRA.Conteudo)+'.AtribuiFiltroMestre(Atribui);');
        TabGlobal_i.DRELACIONA.Next;
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      TabGlobal_i.DRELACIONA.Filtro := 'TIPO = 3 AND UPPER(TAB_ESTRANGEIRA) = '+#39+UpperCase(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo))+#39 + ' AND ATIVO = 1';
      TabGlobal_i.DRELACIONA.AtualizaSql;

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AtribuiFiltroMestre(Atribui: Boolean = True; Atualiza: Boolean = True);');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  I: Integer;');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  Filtro.Clear;');
      FormPrincipal.Texto.Lines.Add('  FiltroRelac.Clear;');
      FormPrincipal.Texto.Lines.Add('  if Atribui then');
      FormPrincipal.Texto.Lines.Add('  begin');
      TabGlobal_i.DRELACIONA.First;
      if not TabGlobal_i.DRELACIONA.Eof then
      begin
        Campos_Chave_1 := TStringList.Create;
        Campos_Chave_2 := TStringList.Create;
        StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
        StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
        PTabela(TabGlobal_i.DTABELAS,['NUMERO'],[TabGlobal_i.DRELACIONA.NUMERO.Conteudo],['NOME'],NomeTabChave);
        if (NomeTabChave[0] <> Null) and (Campos_Chave_1.Count = Campos_Chave_2.Count) then
        begin
          for Y:=0 to Campos_Chave_1.Count-1 do
          begin
            // cms modificaocao 16/042012 Trim(TabGlobal_i.DTABELAS.NOME.Conteudo
            //if Y = 0 then
            //  FormPrincipal.Texto.Lines.Add('    FiltroRelac.Add('+#39+Trim(NomeFisico)+'.'+Trim(Campos_Chave_2[Y])+' = :'+NomeTabChave[0]+'_'+Trim(Campos_Chave_1[Y])+#39+');')
            //else
            //  FormPrincipal.Texto.Lines.Add('    FiltroRelac.Add('+#39+' and '+Trim(NomeFisico)+'.'+Trim(Campos_Chave_2[Y])+' = :'+NomeTabChave[0]+'_'+Trim(Campos_Chave_1[Y])+#39+');');

            if Y = 0 then
              if Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '' then
                 FormPrincipal.Texto.Lines.Add('    FiltroRelac.Add('+#39+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+' = :'+NomeTabChave[0]+'_'+Trim(Campos_Chave_1[Y])+#39+');')
              else
                 FormPrincipal.Texto.Lines.Add('    FiltroRelac.Add('+#39+Trim(NomeFisico)+'.'+Trim(Campos_Chave_2[Y])+' = :'+NomeTabChave[0]+'_'+Trim(Campos_Chave_1[Y])+#39+');') 
            else
              if Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '' then
                 FormPrincipal.Texto.Lines.Add('    FiltroRelac.Add('+#39+' and '+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(Campos_Chave_2[Y])+' = :'+NomeTabChave[0]+'_'+Trim(Campos_Chave_1[Y])+#39+');')
              else
                 FormPrincipal.Texto.Lines.Add('    FiltroRelac.Add('+#39+' and '+Trim(NomeFisico)+'.'+Trim(Campos_Chave_2[Y])+' = :'+NomeTabChave[0]+'_'+Trim(Campos_Chave_1[Y])+#39+');');
          end;
          FormPrincipal.Texto.Lines.Add('  end');
          FormPrincipal.Texto.Lines.Add('  else');
          FormPrincipal.Texto.Lines.Add('    for I:=0 to Campos.Count-1 do');
          FormPrincipal.Texto.Lines.Add('      TAtributo(Campos[I]).Valor.OnValidate := nil;');
          for Y:=0 to Campos_Chave_1.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+Trim(Campos_Chave_2[Y])+'.Valor.ReadOnly := Atribui;');
        end;
      end
      else
      begin
        FormPrincipal.Texto.Lines.Add('  end');
        FormPrincipal.Texto.Lines.Add('  else');
        FormPrincipal.Texto.Lines.Add('    for I:=0 to Campos.Count-1 do');
        FormPrincipal.Texto.Lines.Add('      TAtributo(Campos[I]).Valor.OnValidate := nil;');
      end;
      FormPrincipal.Texto.Lines.Add('  if Atualiza then');
      FormPrincipal.Texto.Lines.Add('    AtualizaSql;');
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AtribuiMestre(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('begin');
      TabGlobal_i.DRELACIONA.First;
      if not TabGlobal_i.DRELACIONA.Eof then
      begin
        PTabela(TabGlobal_i.DTABELAS,['NUMERO'],[TabGlobal_i.DRELACIONA.NUMERO.Conteudo],['NOME'],NomeTabChave);
        if (NomeTabChave[0] <> Null) and (Campos_Chave_1.Count = Campos_Chave_2.Count) then
          for Y:=0 to Campos_Chave_1.Count-1 do
          begin
            FormPrincipal.Texto.Lines.Add('  '+Trim(Campos_Chave_2[Y])+'.Valor.Value := TabGlobal.D'+NomeTabChave[0]+'.'+Trim(Campos_Chave_1[Y])+'.Valor.Value;');
            //FormPrincipal.Texto.Lines.Add('  '+Trim(Campos_Chave_2[Y])+'.Valor.ReadOnly := True;');
          end;
        Campos_Chave_1.Free;
        Campos_Chave_2.Free;
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.ProcessoDireto1(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  QueryLc: TTabela;');
      FormPrincipal.Texto.Lines.Add('  EmEdicao: Boolean;');
      TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DPROCESSOS.AtualizaSql;
      TabGlobal_i.DPROCESSOS.First;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 3) or
           (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 5) then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo[Y]);
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      TabGlobal_i.DPROCESSOS.First;
      TemProcesso := True;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 1) and
           (Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo) <> '') then
        begin
          TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND UPPER(TAB_ESTRANGEIRA) = '+#39+UpperCase(Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo))+#39 + ' AND ATIVO = 1';
          TabGlobal_i.DRELACIONA.AtualizaSql;
          TabGlobal_i.DRELACIONA.First;
          if not TabGlobal_i.DRELACIONA.Eof then
          begin
            Campos_Chave_1 := TStringList.Create;
            Campos_Chave_2 := TStringList.Create;
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
            if Campos_Chave_1.Count = Campos_Chave_2.Count then
            begin
              TemProcesso := True;
              Campos_Pesq := '';
              Campos_Valor := '';
              for Y:=0 to Campos_Chave_2.Count-1 do
                Campos_Pesq := Campos_Pesq + #39+Campos_Chave_2[Y]+#39+',';
              for Y:=0 to Campos_Chave_1.Count-1 do
                Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
              if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
                Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
              if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
                Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
              FormPrincipal.Texto.Lines.Add('  EmEdicao := TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modificacao;');
              FormPrincipal.Texto.Lines.Add('  if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('    TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Salva;');
              if Trim(TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo) <> '' then
              begin
                FormPrincipal.Texto.Lines.Add('  if '+TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo+' then');
                FormPrincipal.Texto.Lines.Add('    if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('      MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end
              else
              begin
                FormPrincipal.Texto.Lines.Add('  if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('    MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end;
              FormPrincipal.Texto.Lines.Add('  if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('    TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modifica;');
            end;
            Campos_Chave_1.Free;
            Campos_Chave_2.Free;
          end;
        end
        else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 2 then
        begin
          TemProcesso := True;
          if Trim(TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Conteudo) <> '' then
            FormPrincipal.Texto.Lines.Add('  if (Inclusao) and ('+TabGlobal_i.DPROCESSOS.CONDICAO_INCLUSAO.Conteudo+') then')
          else
            FormPrincipal.Texto.Lines.Add('  if Inclusao then');
          FormPrincipal.Texto.Lines.Add('  begin ');
          FormPrincipal.Texto.Lines.Add('    QueryLc := TTabela.Create(Self);');
          FormPrincipal.Texto.Lines.Add('    try');
          FormPrincipal.Texto.Lines.Add('      with QueryLc do');
          FormPrincipal.Texto.Lines.Add('      begin');
          FormPrincipal.Texto.Lines.Add('        DataBase := TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.DataBase;');
          FormPrincipal.Texto.Lines.Add('        Transaction := TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Transaction;');
          FormPrincipal.Texto.Lines.Add('        Sql.Clear;');
          FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+'Insert into '+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+#39+');');
          FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+' ('+#39+');');
          Primeira := True;
          for Y:=0 to TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo.Count-1 do
            if Trim(TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo[Y]) <> '' then
            begin
              if Primeira then
                FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+' '+TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo[Y]+#39+');')
              else
                FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+','+TabGlobal_i.DPROCESSOS.CAMPOS_ALVO.Conteudo[Y]+#39+');');
              Primeira := False;
            end;
          FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+' )'+#39+');');
          FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+'Values'+#39+');');
          FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+' ('+#39+');');
          Primeira := True;
          for Y:=0 to TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo.Count-1 do
            if Trim(TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo[Y]) <> '' then
            begin
              if Primeira then
                FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+' '+TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo[Y]+#39+');')
              else
                FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+','+TabGlobal_i.DPROCESSOS.CAMPOS_VALOR.Conteudo[Y]+#39+');');
              Primeira := False;
            end;
          FormPrincipal.Texto.Lines.Add('        Sql.Add('+#39+' )'+#39+');');
          FormPrincipal.Texto.Lines.Add('        TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Parametros(QueryLc);');
          FormPrincipal.Texto.Lines.Add('        Conexao;');
          FormPrincipal.Texto.Lines.Add('        ExecSql;');
          FormPrincipal.Texto.Lines.Add('      end;');
          FormPrincipal.Texto.Lines.Add('    finally');
          FormPrincipal.Texto.Lines.Add('      QueryLc.Free;');
          FormPrincipal.Texto.Lines.Add('    end;');
          FormPrincipal.Texto.Lines.Add('  end;');
        end
        else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 3 then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO.Conteudo[Y]);
        end
        else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 5 then
        begin
          FormPrincipal.Texto.Lines.Add('  if Inclusao then');
          FormPrincipal.Texto.Lines.Add('  begin ');
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('    '+TabGlobal_i.DPROCESSOS.AVULSO.Conteudo[Y]);
          FormPrincipal.Texto.Lines.Add('  end;');
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      if TemProcesso then
      begin
        FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
        FormPrincipal.Texto.Lines.Add('  Transaction.CommitRetaining;');
        FormPrincipal.Texto.Lines.Add('  {$ELSE}');
        //FormPrincipal.Texto.Lines.Add('  ApplyUpdates;');
        //FormPrincipal.Texto.Lines.Add('  CommitUpdates;');
        FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
        FormPrincipal.Texto.Lines.Add('  Inclusao    := False;');
        FormPrincipal.Texto.Lines.Add('  Modificacao := False;');
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.ProcessoDireto2(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  EmEdicao: Boolean;');
      TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DPROCESSOS.AtualizaSql;
      TabGlobal_i.DPROCESSOS.First;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 3) then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo[Y]);
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      TabGlobal_i.DPROCESSOS.First;
      TemProcesso := True;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 1) and
           (Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo) <> '') then
        begin
          TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND UPPER(TAB_ESTRANGEIRA) = '+#39+UpperCase(Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo))+#39 + ' AND ATIVO = 1';
          TabGlobal_i.DRELACIONA.AtualizaSql;
          TabGlobal_i.DRELACIONA.First;
          if not TabGlobal_i.DRELACIONA.Eof then
          begin
            Campos_Chave_1 := TStringList.Create;
            Campos_Chave_2 := TStringList.Create;
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
            if Campos_Chave_1.Count = Campos_Chave_2.Count then
            begin
              TemProcesso := True;
              Campos_Pesq := '';
              Campos_Valor := '';
              for Y:=0 to Campos_Chave_2.Count-1 do
                Campos_Pesq := Campos_Pesq + #39+Campos_Chave_2[Y]+#39+',';
              for Y:=0 to Campos_Chave_1.Count-1 do
                Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
              if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
                Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
              if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
                Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
              FormPrincipal.Texto.Lines.Add('  if Modificacao then');
              FormPrincipal.Texto.Lines.Add('  begin');
              FormPrincipal.Texto.Lines.Add('    EmEdicao := TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modificacao;');
              FormPrincipal.Texto.Lines.Add('    if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('      TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Salva;');
              if Trim(TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo) <> '' then
              begin
                FormPrincipal.Texto.Lines.Add('    if '+TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo+' then');
                FormPrincipal.Texto.Lines.Add('      if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('        MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end
              else
              begin
                FormPrincipal.Texto.Lines.Add('    if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('      MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end;
              FormPrincipal.Texto.Lines.Add('    if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('      TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modifica;');
              FormPrincipal.Texto.Lines.Add('  end;');
            end;
            Campos_Chave_1.Free;
            Campos_Chave_2.Free;
          end;
        end
        else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 3 then
        begin
          FormPrincipal.Texto.Lines.Add('  if Modificacao then');
          FormPrincipal.Texto.Lines.Add('  begin');
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('    '+TabGlobal_i.DPROCESSOS.AVULSO.Conteudo[Y]);
          FormPrincipal.Texto.Lines.Add('  end;');
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      if TemProcesso then
      begin
        FormPrincipal.Texto.Lines.Add('  {$IFDEF IBX}');
        FormPrincipal.Texto.Lines.Add('  Transaction.CommitRetaining;');
        FormPrincipal.Texto.Lines.Add('  {$ELSE}');
        //FormPrincipal.Texto.Lines.Add('  ApplyUpdates;');
        //FormPrincipal.Texto.Lines.Add('  CommitUpdates;');
        FormPrincipal.Texto.Lines.Add('  {$ENDIF}');
        FormPrincipal.Texto.Lines.Add('  Inclusao    := False;');
        FormPrincipal.Texto.Lines.Add('  Modificacao := False;');
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AtualizaCalculados(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  CalculaCampos;');
      if Trim(nome_1_chave) <> '' then
      begin
        FormPrincipal.Texto.Lines.Add('  if Inclusao then');
        FormPrincipal.Texto.Lines.Add('    if ('+nome_1_chave+'.SempreAtribui) and ('+nome_1_chave+'.AutoIncremento > 0) then');
        FormPrincipal.Texto.Lines.Add('      AutoIncremento('#39+nome_1_chave+#39+', True, '+nome_1_chave+'.AutoIncremento);');
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.ProcessoInverso1(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  EmEdicao: Boolean;');
      TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DPROCESSOS.AtualizaSql;
      TabGlobal_i.DPROCESSOS.First;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 4) then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo[Y]);
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      TabGlobal_i.DPROCESSOS.First;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 1) and
           (Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo) <> '') then
        begin
          TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND UPPER(TAB_ESTRANGEIRA) = '+#39+UpperCase(Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo))+#39 + ' AND ATIVO = 1';
          TabGlobal_i.DRELACIONA.AtualizaSql;
          TabGlobal_i.DRELACIONA.First;
          if not TabGlobal_i.DRELACIONA.Eof then
          begin
            Campos_Chave_1 := TStringList.Create;
            Campos_Chave_2 := TStringList.Create;
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
            if Campos_Chave_1.Count = Campos_Chave_2.Count then
            begin
              Campos_Pesq := '';
              Campos_Valor := '';
              for Y:=0 to Campos_Chave_2.Count-1 do
                Campos_Pesq := Campos_Pesq + #39+Campos_Chave_2[Y]+#39+',';
              for Y:=0 to Campos_Chave_1.Count-1 do
                Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
              if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
                Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
              if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
                Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
              FormPrincipal.Texto.Lines.Add('  EmEdicao := TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modificacao;');
              FormPrincipal.Texto.Lines.Add('  if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('    TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Salva;');
              if Trim(TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo) <> '' then
              begin
                FormPrincipal.Texto.Lines.Add('  if '+TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo+' then');
                FormPrincipal.Texto.Lines.Add('    if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('      MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end
              else
              begin
                FormPrincipal.Texto.Lines.Add('  if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('    MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end;
              FormPrincipal.Texto.Lines.Add('  if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('    TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modifica;');
            end;
            Campos_Chave_1.Free;
            Campos_Chave_2.Free;
          end;
        end
        else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 4 then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO.Conteudo[Y]);
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.ProcessoInverso2(DataSet: TDataSet);');
      FormPrincipal.Texto.Lines.Add('var');
      FormPrincipal.Texto.Lines.Add('  EmEdicao: Boolean;');
      TabGlobal_i.DPROCESSOS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DPROCESSOS.AtualizaSql;
      TabGlobal_i.DPROCESSOS.First;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 4) then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO_VAR.Conteudo[Y]);
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  if not PodeExcluir then Abort;');
      TabGlobal_i.DPROCESSOS.First;
      while not TabGlobal_i.DPROCESSOS.eof do
      begin
        if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 1) and
           (Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo) <> '') then
        begin
          TabGlobal_i.DRELACIONA.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo)+ ' AND UPPER(TAB_ESTRANGEIRA) = '+#39+UpperCase(Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo))+#39 + ' AND ATIVO = 1';
          TabGlobal_i.DRELACIONA.AtualizaSql;
          TabGlobal_i.DRELACIONA.First;
          if not TabGlobal_i.DRELACIONA.Eof then
          begin
            Campos_Chave_1 := TStringList.Create;
            Campos_Chave_2 := TStringList.Create;
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_1.Conteudo,';',Campos_Chave_1);
            StringToArray(TabGlobal_i.DRELACIONA.CAMPOS_CHAVE_2.Conteudo,';',Campos_Chave_2);
            if Campos_Chave_1.Count = Campos_Chave_2.Count then
            begin
              Campos_Pesq := '';
              Campos_Valor := '';
              for Y:=0 to Campos_Chave_2.Count-1 do
                Campos_Pesq := Campos_Pesq + #39+Campos_Chave_2[Y]+#39+',';
              for Y:=0 to Campos_Chave_1.Count-1 do
                Campos_Valor := Campos_Valor + Campos_Chave_1[Y]+'.Valor.Value,';
              if Copy(Campos_Pesq,Length(Campos_Pesq),01) = ',' then
                Campos_Pesq := Copy(Campos_Pesq,01,Length(Campos_Pesq)-1);
              if Copy(Campos_Valor,Length(Campos_Valor),01) = ',' then
                Campos_Valor := Copy(Campos_Valor,01,Length(Campos_Valor)-1);
              FormPrincipal.Texto.Lines.Add('  EmEdicao := TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modificacao;');
              FormPrincipal.Texto.Lines.Add('  if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('    TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Salva;');
              if Trim(TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo) <> '' then
              begin
                FormPrincipal.Texto.Lines.Add('  if '+TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo+' then');
                FormPrincipal.Texto.Lines.Add('    if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('      MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end
              else
              begin
                FormPrincipal.Texto.Lines.Add('  if not PTabela(TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+', ['+Campos_pesq+'], ['+Campos_Valor+'], '+#39+Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo)+' = '+Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo)+#39+') then');
                FormPrincipal.Texto.Lines.Add('    MessageDlg('+#39+'Falha na atualização da Tabela: '+#39+'+TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Titulo, mtError, [mbOk],  0);');
              end;
              FormPrincipal.Texto.Lines.Add('  if EmEdicao then');
              FormPrincipal.Texto.Lines.Add('    TabGlobal.D'+Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo)+'.Modifica;');
            end;
            Campos_Chave_1.Free;
            Campos_Chave_2.Free;
          end;
        end
        else if TabGlobal_i.DPROCESSOS.TIPO.Conteudo = 4 then
        begin
          for Y:=0 to TabGlobal_i.DPROCESSOS.AVULSO.Conteudo.Count-1 do
            FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DPROCESSOS.AVULSO.Conteudo[Y]);
        end;
        TabGlobal_i.DPROCESSOS.Next;
      end;
      FormPrincipal.Texto.Lines.Add('  ExclusaoCascata;');
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.Parametros(Tabela: TTabela);');
      FormPrincipal.Texto.Lines.Add('begin');
      FormPrincipal.Texto.Lines.Add('  Parametros_Padrao(Tabela);');
      FormPrincipal.Texto.Lines.Add('end;');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('end.');
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.Pas');
      FormPrincipal.Texto.Lines.Clear;
      Inc(I);
    end;
    TabGlobal_i.DTABELAS.Next;
  end;
  I := 0;
  TabGlobal_i.DTABELAS.First;
  while not TabGlobal_i.DTABELAS.Eof do
  begin
    if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      TabGlobal_i.DCAMPOST.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
      TabGlobal_i.DCAMPOST.AtualizaSql;
      FormPrincipal.Texto.Lines.Clear;
      FormPrincipal.Texto.Lines[0] := 'unit AtrL'+StrZero(I,04)+';';
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('interface');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses SysUtils, Classes, Graphics, DB, DBTables, Publicas,');
      FormPrincipal.Texto.Lines.Add('  Rotinas, Validar, Atributo, Estrutur, Controls;');
      FormPrincipal.Texto.Lines.Add('');
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
        begin
          FormPrincipal.Texto.Lines.Add('Type');
          if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipoAlfanumerico)')
          else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipoInteiro)')
          else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3) or (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 12) then
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipoFracionario)')
          else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4) or (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 16) then
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipoData)')
          else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 5) or (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 25) then
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipoMemo)')
          else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 6 then
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipoImagem)')
          else
            FormPrincipal.Texto.Lines.Add('  TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+' = class(TTipo'+Copy(Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo], 03, Length(Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]))+')');
          FormPrincipal.Texto.Lines.Add('  public');
          FormPrincipal.Texto.Lines.Add('    constructor Create(AOwner: TComponent); override;');
          if Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) <> '' then
          begin
            FormPrincipal.Texto.Lines.Add('    { Valor padrão }');
            if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1) or
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 7) or
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 21) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: String; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 8) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 9) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 18) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 22) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: Integer; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 12) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: Double; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 13) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: Currency; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 14) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 16) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: TDateTime; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 10) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: Word; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 11) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: Boolean; override;')
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 17) then
              FormPrincipal.Texto.Lines.Add('    function ValorPadrao: Bytes; override;');
          end;
          if (Trim(TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo) <> '') or
             (Trim(TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) and
             (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo <> 1) then
          begin
            FormPrincipal.Texto.Lines.Add('    { Validação }');
            FormPrincipal.Texto.Lines.Add('    function Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean; override;');
          end;
          if (Trim(TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) and
             (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo <> 1) then
          begin
            FormPrincipal.Texto.Lines.Add('    { Pre-Validação }');
            FormPrincipal.Texto.Lines.Add('    function PreValidacao: Boolean; override;');
          end;
          if Trim(TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text) <> '' then
          begin
            FormPrincipal.Texto.Lines.Add('    { Valores válidos }');
            FormPrincipal.Texto.Lines.Add('    procedure IncluiValoresValidos; override;');
          end;
          FormPrincipal.Texto.Lines.Add('  end;');
          FormPrincipal.Texto.Lines.Add('');
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('implementation');
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('uses Abertura;');
      TabGlobal_i.DCAMPOST.First;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        if Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo) <> '' then
        begin
          FormPrincipal.Texto.Lines.Add('');
          FormPrincipal.Texto.Lines.Add('constructor TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.Create(AOwner: TComponent);');
          FormPrincipal.Texto.Lines.Add('begin');
          FormPrincipal.Texto.Lines.Add('  inherited Create(AOwner);');
          FormPrincipal.Texto.Lines.Add('  Nome              := '+#39+NomeFisicoCampo+#39+';');
          if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
            FormPrincipal.Texto.Lines.Add('  Tipo              := tpAlfanumerico;')
          else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
            FormPrincipal.Texto.Lines.Add('  Tipo              := tpInteiro;')
          else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3 then
            FormPrincipal.Texto.Lines.Add('  Tipo              := tpFracionario;')
          else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
            FormPrincipal.Texto.Lines.Add('  Tipo              := tpData;')
          else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 5) or (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 25) then
            FormPrincipal.Texto.Lines.Add('  Tipo              := tpMemo;')
          else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 6 then
            FormPrincipal.Texto.Lines.Add('  Tipo              := tpImagem;')
          else
            FormPrincipal.Texto.Lines.Add('  Tipo              := tp'+Copy(Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo], 03, Length(Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]))+';');
          NrCasas_D := 0;
          if Pos(',', TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0 then
          begin
            NrCasas_D := Length(Copy(Trim(TabGlobal_i.DCAMPOST.MASCARA.Conteudo), Pos(',', Trim(TabGlobal_i.DCAMPOST.MASCARA.Conteudo)) + 1, Length(Trim(TabGlobal_i.DCAMPOST.MASCARA.Conteudo))));
            if NrCasas_D < 0 then
              NrCasas_D := 0;
          end;
          FormPrincipal.Texto.Lines.Add('  Tamanho           := '+IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+';');
          FormPrincipal.Texto.Lines.Add('  CasasDecimais     := '+IntToStr(NrCasas_D)+';');
          FormPrincipal.Texto.Lines.Add('  TipoEdicao        := tpEdit;');
          case TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo of
            2: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Blob'+#39+';');
            3: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Char'+#39+';');
            4: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Date'+#39+';');
            5: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Decimal('+IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+','+IntToStr(NrCasas_D)+')'+#39+';');
            6: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Double Precision'+#39+';');
            7: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Float'+#39+';');
            8: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Integer'+#39+';');
            9: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Numeric('+IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+','+IntToStr(NrCasas_D)+')'+#39+';');
           10: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Smallint'+#39+';');
           11: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Time'+#39+';');
           12: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Timestamp'+#39+';');
           13: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Varchar('+IntToStr(TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+')'+#39+';');
           14: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Datetime'+#39+';');
           15: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Text'+#39+';');
           16: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Image'+#39+';');
           17: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Bit'+#39+';');
           18: FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+'Money'+#39+';');
          else
            FormPrincipal.Texto.Lines.Add('  TipoSQL           := '+#39+''+#39+';');
          end;
          FormPrincipal.Texto.Lines.Add('  SQL_Extra         := '+#39+Trim(TabGlobal_i.DCAMPOST.SQL_EXTRA.Conteudo)+#39+';');
          FormPrincipal.Texto.Lines.Add('  Titulo            := '+#39+TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+#39+';');
          if Trim(TabGlobal_i.DCAMPOST.MASCARA.Conteudo) <> '' then
          begin
            if TrimRight(TabGlobal_i.DCAMPOST.MASCARA.Conteudo[Length(TrimRight(TabGlobal_i.DCAMPOST.MASCARA.Conteudo))]) = '*' then
              FormPrincipal.Texto.Lines.Add('  Mascara           := '+#39+ConstStr(Copy(TrimRight(TabGlobal_i.DCAMPOST.MASCARA.Conteudo),Length(TrimRight(TabGlobal_i.DCAMPOST.MASCARA.Conteudo))-1,01),TabGlobal_i.DCAMPOST.TAMANHO.Conteudo)+#39+';')
            else
              FormPrincipal.Texto.Lines.Add('  Mascara           := '+#39+TrimRight(TabGlobal_i.DCAMPOST.MASCARA.Conteudo)+#39+';');
          end
          else
            FormPrincipal.Texto.Lines.Add('  Mascara           := '+#39+Trim(TabGlobal_i.DCAMPOST.MASCARA.Conteudo)+#39+';');
          if (Pos('/',TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0) or
             (Pos('-',TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0) or
             (Pos('(',TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0) or
             (Pos(')',TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0) or
             (Pos('_',TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0) or
             (Pos('9',TabGlobal_i.DCAMPOST.MASCARA.Conteudo) > 0) then
            FormPrincipal.Texto.Lines.Add('  CaractereEdicao   := '+#39+'_'+#39+';')
          else
            FormPrincipal.Texto.Lines.Add('  CaractereEdicao   := '+#39+' '+#39+';');
          FormPrincipal.Texto.Lines.Add('  Ajuda             := '+#39+TabGlobal_i.DCAMPOST.AJUDA.Conteudo+#39+';');
          if (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 0) then
            FormPrincipal.Texto.Lines.Add('  Calculado         := True;')
          else
            FormPrincipal.Texto.Lines.Add('  Calculado         := False;');
          if (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 1) then
            FormPrincipal.Texto.Lines.Add('  Calculado_F       := True;')
          else
            FormPrincipal.Texto.Lines.Add('  Calculado_F       := False;');
          //if (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
          //   (TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo = 0) then
          //  FormPrincipal.Texto.Lines.Add('  NaoVirtual        := False;')
          //else
          //  FormPrincipal.Texto.Lines.Add('  NaoVirtual        := True;');
          FormPrincipal.Texto.Lines.Add('  Valor.FieldName   := Nome;');
          FormPrincipal.Texto.Lines.Add('  Valor.Size        := TamanhoDado;');
          FormPrincipal.Texto.Lines.Add('  Valor.DisplayLabel:= Titulo;');
          FormPrincipal.Texto.Lines.Add('  Valor.Calculated  := Calculado;');
          FormPrincipal.Texto.Lines.Add('  Valor.Index       := '+IntToStr(TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo)+';');
          if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
            FormPrincipal.Texto.Lines.Add('  Valor.ReadOnly    := True;');
          if TabGlobal_i.DCAMPOST.INVISIVEL.Conteudo = 1 then
          begin
            FormPrincipal.Texto.Lines.Add('  Valor.Visible     := False;');
            FormPrincipal.Texto.Lines.Add('  Visible_Default   := False;');
          end
          else
          begin
            FormPrincipal.Texto.Lines.Add('  Valor.Visible     := True;');
            FormPrincipal.Texto.Lines.Add('  Visible_Default   := True;');
          end;
          if TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 then
            FormPrincipal.Texto.Lines.Add('  Chave             := True;')
          else
            FormPrincipal.Texto.Lines.Add('  Chave             := False;');
          FormPrincipal.Texto.Lines.Add('  Index             := '+IntToStr(TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo)+';');
          FormPrincipal.Texto.Lines.Add('  Index_Default     := '+IntToStr(TabGlobal_i.DCAMPOST.INDICE_CONSULTA.Conteudo)+';');
          FormPrincipal.Texto.Lines.Add('  AutoIncremento    := '+IntToStr(TabGlobal_i.DCAMPOST.AUTOINCREMENTO.Conteudo)+';');
          if (TabGlobal_i.DCAMPOST.SEM_INSERT.Conteudo = 1) and
             (TabGlobal_i.DCAMPOST.CHAVE.Conteudo = 1 ) then
            FormPrincipal.Texto.Lines.Add('  Incremento_Auto   := True;')
          else
            FormPrincipal.Texto.Lines.Add('  Incremento_Auto   := False;');
          if TabGlobal_i.DCAMPOST.SEMPRE_ATRIBUI.Conteudo = 1 then
            FormPrincipal.Texto.Lines.Add('  SempreAtribui     := True;')
          else
            FormPrincipal.Texto.Lines.Add('  SempreAtribui     := False;');
          if (Trim(TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) and
             (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo <> 1) then
            FormPrincipal.Texto.Lines.Add('  PreValidacao_ativa:= True;')
          else
            FormPrincipal.Texto.Lines.Add('  PreValidacao_ativa:= False;');
          FormPrincipal.Texto.Lines.Add('  Acao              := '+IntToStr(TabGlobal_i.DCAMPOST.TIPO_PRE_VALIDACAO.Conteudo)+';');
          if TabGlobal_i.DCAMPOST.LIMPAR_CAMPO.Conteudo = 1 then
            FormPrincipal.Texto.Lines.Add('  LimparCampo       := True;')
          else
            FormPrincipal.Texto.Lines.Add('  LimparCampo       := False;');
          FormPrincipal.Texto.Lines.Add('  MensagemErro      := '+#39+TabGlobal_i.DCAMPOST.MSG_ERRO.Conteudo+#39+';');
          if TabGlobal_i.DCAMPOST.EXTRA.Conteudo = 1 then
          begin
            FormPrincipal.Texto.Lines.Add('  Extra             := True;');
            FormPrincipal.Texto.Lines.Add('  NomeTabela        := '+#39+Trim(TabGlobal_i.DCAMPOST.TAB_EXTRA.Conteudo)+#39+';');
            FormPrincipal.Texto.Lines.Add('  NomeOriginal      := '+#39+Trim(TabGlobal_i.DCAMPOST.CAMPO_EXTRA.Conteudo)+#39+';');
          end
          else
          begin
            FormPrincipal.Texto.Lines.Add('  Extra             := False;');
            FormPrincipal.Texto.Lines.Add('  NomeTabela        := '+#39+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+';');
            FormPrincipal.Texto.Lines.Add('  NomeOriginal      := '+#39+NomeFisicoCampo+#39+';');
          end;
          if TabGlobal_i.DCAMPOST.EDICAO.Conteudo = 5 then
          begin
            FormPrincipal.Texto.Lines.Add('  TabEstrangeira    := '+#39+Trim(TabGlobal_i.DCAMPOST.TAB_ESTRANGEIRA.Conteudo)+#39+';');
            FormPrincipal.Texto.Lines.Add('  ChaveEstrangeira  := '+#39+TabGlobal_i.DCAMPOST.CAMPO_CHAVE.Conteudo+#39+';');
            FormPrincipal.Texto.Lines.Add('  CamposVisuais     := '+#39+TrocaString(TabGlobal_i.DCAMPOST.CAMPOS_VISUAIS.Conteudo,',',';',[rfReplaceAll])+#39+';');
            FormPrincipal.Texto.Lines.Add('  EstiloPesquisa    := '+IntToStr(TabGlobal_i.DCAMPOST.ESTILO_CHAVE.Conteudo)+';');
            FormPrincipal.Texto.Lines.Add('  AcaoPesquisa      := '+IntToStr(TabGlobal_i.DCAMPOST.ACAO_PESQUISA.Conteudo)+';');
            FormPrincipal.Texto.Lines.Add('  FiltroFixo.Clear;');
            for Y:=0 to TabGlobal_i.DCAMPOST.Filtro_Mestre.Conteudo.Count-1 do
              FormPrincipal.Texto.Lines.Add('  FiltroFixo.Add('+#39+TabGlobal_i.DCAMPOST.Filtro_Mestre.Conteudo[Y]+#39+');');
          end
          else
          begin
            FormPrincipal.Texto.Lines.Add('  TabEstrangeira    := '+#39+#39+';');
            FormPrincipal.Texto.Lines.Add('  ChaveEstrangeira  := '+#39+#39+';');
            FormPrincipal.Texto.Lines.Add('  CamposVisuais     := '+#39+#39+';');
            FormPrincipal.Texto.Lines.Add('  EstiloPesquisa    := 0;');
            FormPrincipal.Texto.Lines.Add('  AcaoPesquisa      := 0;');
            FormPrincipal.Texto.Lines.Add('  FiltroFixo.Clear;');
          end;
          FormPrincipal.Texto.Lines.Add('end;');
          if Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) <> '' then
          begin
            FormPrincipal.Texto.Lines.Add('');
            if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1) or
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 7) or
               (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 21) then
            begin
              FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: String;');
              FormPrincipal.Texto.Lines.Add('begin');
              if (UpperCase(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) = 'HORAATUAL') or
                 ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
              begin
                if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                  FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
                else
                  FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+';');
              end
              else
                FormPrincipal.Texto.Lines.Add('  Result := '+#39+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+#39+';');
              FormPrincipal.Texto.Lines.Add('end;');
            end
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 8) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 9) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 18) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 22) then
            begin
              FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: Integer;');
              FormPrincipal.Texto.Lines.Add('begin');
              if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
              else
                FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+';');
              FormPrincipal.Texto.Lines.Add('end;');
            end
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 12) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 13) then
            begin
              if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 13) then
                FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: Currency;')
              else
                FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: Double;');
              FormPrincipal.Texto.Lines.Add('begin');
              if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
              else
                FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+';');
              FormPrincipal.Texto.Lines.Add('end;');
            end
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 14) or
                    (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 16) then
            begin
              FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: TDateTime;');
              FormPrincipal.Texto.Lines.Add('begin');
              if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
              else
                FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+';');
              FormPrincipal.Texto.Lines.Add('end;');
            end
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 10) then
            begin
              FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: Word;');
              FormPrincipal.Texto.Lines.Add('begin');
              if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
              else
                FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+';');
              FormPrincipal.Texto.Lines.Add('end;');
            end
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 11) then
            begin
              FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: Boolean;');
              FormPrincipal.Texto.Lines.Add('begin');
              if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
              else
              begin
                if (TabGlobal_i.DCAMPOST.PADRAO.Conteudo = '1') or
                   (UpperCase(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) = 'T') or
                   (UpperCase(TabGlobal_i.DCAMPOST.PADRAO.Conteudo) = 'S') then
                  FormPrincipal.Texto.Lines.Add('  Result := True;')
                else
                  FormPrincipal.Texto.Lines.Add('  Result := False;');
              end;
              FormPrincipal.Texto.Lines.Add('end;');
            end
            else if (TabGlobal_i.DCAMPOST.TIPO.Conteudo = 17) then
            begin
              FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.ValorPadrao: Bytes;');
              FormPrincipal.Texto.Lines.Add('begin');
              if ((Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 01, 01) = '%')  and (Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)) > 1)) then
                FormPrincipal.Texto.Lines.Add('  Result := '+Copy(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo), 02, Length(Trim(TabGlobal_i.DCAMPOST.PADRAO.Conteudo)))+';')
              else
                FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PADRAO.Conteudo+';');
              FormPrincipal.Texto.Lines.Add('end;');
            end
          end;

          if (Trim(TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo) <> '') or
             (Trim(TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) and
             (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo <> 1) then
          begin
            FormPrincipal.Texto.Lines.Add('');
            FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.Valido(var MsgErro : String; EmSaida: Boolean = True): Boolean;');
            FormPrincipal.Texto.Lines.Add('begin');
            if TabGlobal_i.DCAMPOST.VALIDA_ONEXIT.Conteudo = 0 then
            begin
              FormPrincipal.Texto.Lines.Add('  if EmSaida then');
              FormPrincipal.Texto.Lines.Add('  begin');
              FormPrincipal.Texto.Lines.Add('    Result := True;');
              FormPrincipal.Texto.Lines.Add('    exit;');
              FormPrincipal.Texto.Lines.Add('  end;');
            end;
            ListaConjVl := TStringList.Create;
            StringToArray(Trim(TabGlobal_i.DCAMPOST.VALIDACAO.Conteudo),';',ListaConjVl);
            for T:=0 to ListaConjVl.Count-1 do
            begin
              if Pos('*', ListaConjVl[T]) > 0 then
              begin
                FormPrincipal.Texto.Lines.Add('  if EmSaida then');
                FormPrincipal.Texto.Lines.Add('    Valor.AsVariant := '+TrocaString(ListaConjVl[T], '*', '', [rfReplaceAll])+'(Valor.AsVariant);');
              end
              else
              begin
                FormPrincipal.Texto.Lines.Add('  if not '+ListaConjVl[T]+'(ValorString) then');
                FormPrincipal.Texto.Lines.Add('  begin');
                FormPrincipal.Texto.Lines.Add('    Result := False;');
                FormPrincipal.Texto.Lines.Add('    if Trim(MensagemErro) = '+#39+#39+' then');
                FormPrincipal.Texto.Lines.Add('      MsgErro := Format('+#39+TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+' inválido !'+#39+',[Titulo])');
                FormPrincipal.Texto.Lines.Add('    else');
                FormPrincipal.Texto.Lines.Add('      MsgErro := Format(MensagemErro,[Titulo]);');
                FormPrincipal.Texto.Lines.Add('    exit;');
                FormPrincipal.Texto.Lines.Add('  end;');
              end;  
            end;
            ListaConjVl.Free;
            if (Trim(TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo) <> '') then
            begin
              FormPrincipal.Texto.Lines.Add('  if not TabGlobal.D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.PesquisaRelacionados('+#39+Trim(TabGlobal_i.DCAMPOST.TAB_PESQUISA.Conteudo)+#39+') then');
              FormPrincipal.Texto.Lines.Add('  begin');
              FormPrincipal.Texto.Lines.Add('    Result  := False;');
              FormPrincipal.Texto.Lines.Add('    if Trim(MensagemErro) = '+#39+#39+' then');
              FormPrincipal.Texto.Lines.Add('      MsgErro := Format('+#39+TabGlobal_i.DCAMPOST.TITULO_C.Conteudo+' não encontrado !'+#39+',[Titulo])');
              FormPrincipal.Texto.Lines.Add('    else');
              FormPrincipal.Texto.Lines.Add('      MsgErro := Format(MensagemErro,[Titulo]);');
              FormPrincipal.Texto.Lines.Add('    exit;');
              FormPrincipal.Texto.Lines.Add('  end;');
            end;
            FormPrincipal.Texto.Lines.Add('  Result  := True;');
            FormPrincipal.Texto.Lines.Add('  MsgErro := '+#39+#39+';');
            FormPrincipal.Texto.Lines.Add('end;');
          end;

          if (Trim(TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo) <> '') and
             (TabGlobal_i.DCAMPOST.EXTRA.Conteudo <> 1) and
             (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo <> 1) then
          begin
            FormPrincipal.Texto.Lines.Add('');
            FormPrincipal.Texto.Lines.Add('function TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.PreValidacao: Boolean;');
            FormPrincipal.Texto.Lines.Add('begin');
            FormPrincipal.Texto.Lines.Add('  Result := '+TabGlobal_i.DCAMPOST.PRE_VALIDACAO.Conteudo+';');
            FormPrincipal.Texto.Lines.Add('end;');
          end;

          if Trim(TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text) <> '' then
          begin
            FormPrincipal.Texto.Lines.Add('');
            FormPrincipal.Texto.Lines.Add('procedure TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'.IncluiValoresValidos;');
            FormPrincipal.Texto.Lines.Add('begin');
            FormPrincipal.Texto.Lines.Add('  inherited IncluiValoresValidos;');
            ListaChaveTmp := TStringList.Create;
            ListaDescTmp := TStringList.Create;
            StringToArray(Trim(TabGlobal_i.DCAMPOST.VALIDOS.Conteudo.Text),';',ListaChaveTmp, True);
            StringToArray(Trim(TabGlobal_i.DCAMPOST.DESCRICAO.Conteudo.Text),';',ListaDescTmp, True);
            for T:=0 to ListaChaveTmp.Count-1 do
              FormPrincipal.Texto.Lines.Add('  IncluiValorValido('+#39+ListaChaveTmp[T]+#39+', '+#39+ListaDescTmp[T]+#39+');');
            ListaChaveTmp.Free;
            ListaDescTmp.Free;
            FormPrincipal.Texto.Lines.Add('  Valor.OnGetText := GetText;');
            FormPrincipal.Texto.Lines.Add('end;');
          end;
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      FormPrincipal.Texto.Lines.Add('');
      FormPrincipal.Texto.Lines.Add('end.');
      FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'AtrL'+StrZero(I,04)+'.Pas');
      FormPrincipal.Texto.Lines.Clear;
      Inc(I);
    end;
    TabGlobal_i.DTABELAS.Next;
  end;
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  Gera_CConsultas(Global);
  Gera_CScripts(Global);
  Gera_CProcedures(Global);
  Gera_CTriggers(Global);
end;

procedure Gera_CCalculos;
Var
  T: Integer;
  PrimeiroVar: Boolean;
  Troca, Pesquisa: String;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  FormPrincipal.Texto.Lines[0] := '{';
  FormPrincipal.Texto.Lines.Add(' Cálculos para Campos');
  FormPrincipal.Texto.Lines.Add('}');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('unit Calculos;');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('interface');
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('uses SysUtils, StdCtrls, BaseD, classes, Atributo, Estrutur, Princ,');
  FormPrincipal.Texto.Lines.Add('     {$I LTab.pas}');
  FormPrincipal.Texto.Lines.Add('     Rotinas, Validar, Controls, Tabela, Abertura, Publicas;');
  FormPrincipal.Texto.Lines.Add('');
  TabGlobal_i.DCAMPOST.FILTRO := '';
  TabGlobal_i.DCAMPOST.AtualizaSql;
  TabGlobal_i.DCAMPOST.First;
  while not TabGlobal_i.DCAMPOST.Eof do
  begin
    TabGlobal_i.DTABELAS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo);
    TabGlobal_i.DTABELAS.AtualizaSql;
    TabGlobal_i.DTABELAS.First;

    if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Add('');
      if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : String;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : Integer;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : Double;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : TDateTime;');

      FormPrincipal.Texto.Lines.Add('');
      if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : String;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : Integer;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : Double;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : TDateTime;');
    end;
    TabGlobal_i.DCAMPOST.Next;
  end;
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('implementation');

  TabGlobal_i.DCAMPOST.First;
  while not TabGlobal_i.DCAMPOST.Eof do
  begin
    TabGlobal_i.DTABELAS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo);
    TabGlobal_i.DTABELAS.AtualizaSql;
    TabGlobal_i.DTABELAS.First;

    if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
       (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
    begin
      FormPrincipal.Texto.Lines.Add('');
      if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : String;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : Integer;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : Double;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'(AOwner: TComponent) : TDateTime;');
      PrimeiroVar := True;
      for T:=0 to TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo.Count-1 do
      begin
        if Trim(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo[T]) <> '' then
        begin
          if (PrimeiroVar) and (Copy(Trim(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo[T]),01,02) <> '//') then
          begin
            FormPrincipal.Texto.Lines.Add('var');
            PrimeiroVar := False;
          end;
          FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo[T]);
        end;
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      for T:=0 to TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Count-1 do
      begin
        if Trim(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T]) <> '' then
          FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T]);
      end;
      FormPrincipal.Texto.Lines.Add('end;');

      FormPrincipal.Texto.Lines.Add('');
      if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 1 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : String;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 2 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : Integer;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 3 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : Double;')
      else if TabGlobal_i.DCAMPOST.TIPO.Conteudo = 4 then
        FormPrincipal.Texto.Lines.Add('function CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.Nome.Conteudo)+'_Rel(AOwner: TComponent) : TDateTime;');
      PrimeiroVar := False;
      for T:=0 to TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Count-1 do
        if Pos('TABGLOBAL.',UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
        begin
          PrimeiroVar := True;
          Break;
        end;
      if PrimeiroVar then
      begin
        FormPrincipal.Texto.Lines.Add('var');
        TabGlobal_i.DTABELAS.Filtro := '';
        TabGlobal_i.DTABELAS.AtualizaSql;
        while not TabGlobal_i.DTABELAS.Eof do
        begin
          if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
             (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
            for T:=0 to TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Count-1 do
            begin
              Pesquisa := UpperCase('TabGlobal.D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo));
              if Pos(Pesquisa+'.',UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
              begin
                FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+': TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
                Break;
              end
              else if Pos(Pesquisa+',',UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
              begin
                FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+': TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
                Break;
              end
              else if Pos(Pesquisa+' ',UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
              begin
                FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+': TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
                Break;
              end;
            end;
          TabGlobal_i.DTABELAS.Next;
        end;
        PrimeiroVar := False;
      end
      else
        PrimeiroVar := True;
      for T:=0 to TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo.Count-1 do
      begin
        if Trim(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo[T]) <> '' then
        begin
          if (PrimeiroVar) and (Copy(Trim(TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo[T]),01,02) <> '//') then
          begin
            FormPrincipal.Texto.Lines.Add('var');
            PrimeiroVar := False;
          end;
          FormPrincipal.Texto.Lines.Add('  '+TabGlobal_i.DCAMPOST.VARIAVEIS.Conteudo[T]);
        end;
      end;
      FormPrincipal.Texto.Lines.Add('begin');
      TabGlobal_i.DTABELAS.Filtro := '';
      TabGlobal_i.DTABELAS.AtualizaSql;
      while not TabGlobal_i.DTABELAS.Eof do
      begin
        if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
          for T:=0 to TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Count-1 do
          begin
            if Pos(UpperCase('TabGlobal.D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'),UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
            begin
              FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' := TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'(LocalizaTabela(AOwner, '+#39+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+'));');
              Break;
            end
            else if Pos(UpperCase('TabGlobal.D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+','),UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
            begin
              FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' := TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'(LocalizaTabela(Nil, '+#39+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+'));');
              Break;
            end
            else if Pos(UpperCase('TabGlobal.D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' '),UpperCase(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T])) > 0 then
            begin
              FormPrincipal.Texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' := TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'(LocalizaTabela(Nil, '+#39+'D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+#39+'));');
              Break;
            end;
          end;
        TabGlobal_i.DTABELAS.Next;
      end;
      for T:=0 to TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Count-1 do
      begin
        if Trim(TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T]) <> '' then
        begin
          Troca := TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo[T];
          Troca := TrocaString(Troca,'TabGlobal.','',[rfReplaceAll,rfIgnoreCase]);
          FormPrincipal.Texto.Lines.Add('  '+Troca);
        end;
      end;
      FormPrincipal.Texto.Lines.Add('end;');
    end;
    TabGlobal_i.DCAMPOST.Next;
  end;
  FormPrincipal.Texto.Lines.Add('');
  FormPrincipal.Texto.Lines.Add('end.');
  FormPrincipal.Texto.Lines.SaveToFile(Projeto.Pasta+'Calculos.Pas');

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Abertura;
Var
  I, Y, NrTab: Integer;
  Bloco,Inicio,Primeira: Boolean;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DTABELAS.ChaveIndice := TabGlobal_i.DTABELAS.ChPrimaria;
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;

  TabGlobal_i.DCAMPOST.Filtro := '';
  TabGlobal_i.DCAMPOST.AtualizaSql;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  Bloco := False;
  Inicio := True;

  FormPrincipal.texto2.Lines.LoadFromFile(Projeto.Pasta + 'Abertura.Pas');
  for I := 0 to FormPrincipal.texto2.Lines.Count-1 do
  begin
    if Pos('{01-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DTABELAS.First;
      while not TabGlobal_i.DTABELAS.Eof do
      begin
        if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' : TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
        TabGlobal_i.DTABELAS.Next;
      end;
      TabGlobal_i.DCONSULTA.First;
      while not TabGlobal_i.DCONSULTA.Eof do
      begin
        if (Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, TabGlobal_i.DCONSULTA.ATIVO.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+' : TCS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+';');
        TabGlobal_i.DCONSULTA.Next;
      end;
      TabGlobal_i.DSQL_SCRIPT.First;
      while not TabGlobal_i.DSQL_SCRIPT.Eof do
      begin
         if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
            (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+' : TSC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+';');
        TabGlobal_i.DSQL_SCRIPT.Next;
      end;
      TabGlobal_i.DPROC_EXTERNA.First;
      while not TabGlobal_i.DPROC_EXTERNA.Eof do
      begin
        if (Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('ST', TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo, TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+' : TST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+';');
        TabGlobal_i.DPROC_EXTERNA.Next;
      end;
      TabGlobal_i.DTRIGGER.First;
      while not TabGlobal_i.DTRIGGER.Eof do
      begin
        if (Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo) <> '') and
           (TabGlobal_i.DTRIGGER.ATIVO.Conteudo = 1) and
           (PTabela(TabGlobal_i.DTABELAS, ['NUMERO'], [TabGlobal_i.DTRIGGER.NUMERO.Conteudo])) then
          FormPrincipal.texto.Lines.Add('    TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+' : TTR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+';');
        TabGlobal_i.DTRIGGER.Next;
      end;
      TabGlobal_i.DCAMPOST.First;
      primeira := True;
      NrTab    := -1;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        TabGlobal_i.DTABELAS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo);
        TabGlobal_i.DTABELAS.AtualizaSql;
        TabGlobal_i.DTABELAS.First;
        if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
        begin
          if TabGlobal_i.DCAMPOST.NUMERO.Conteudo <> NrTab then
          begin
            Primeira := True;
            NrTab    := TabGlobal_i.DCAMPOST.NUMERO.Conteudo;
          end;
          if primeira then
          begin
            FormPrincipal.texto.Lines.Add('    procedure CalculosD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'(DataSet: TDataSet);');
            Primeira := False;
          end;
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      Bloco := True;
    end;
    if Pos('{02-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DTABELAS.Filtro := '';
      TabGlobal_i.DTABELAS.AtualizaSql;
      TabGlobal_i.DTABELAS.First;
      while not TabGlobal_i.DTABELAS.Eof do
      begin
        if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' := TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.Create(Self);');
        TabGlobal_i.DTABELAS.Next;
      end;
      TabGlobal_i.DCONSULTA.First;
      while not TabGlobal_i.DCONSULTA.Eof do
      begin
        if (Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('CS', TabGlobal_i.DCONSULTA.NUMERO.Conteudo, TabGlobal_i.DCONSULTA.ATIVO.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('  CS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+' := TCS'+Trim(TabGlobal_i.DCONSULTA.NOME.Conteudo)+'.Create(Self);');
        TabGlobal_i.DCONSULTA.Next;
      end;
      TabGlobal_i.DSQL_SCRIPT.First;
      while not TabGlobal_i.DSQL_SCRIPT.Eof do
      begin
        if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('  SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+' := TSC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Create(Self);');
        TabGlobal_i.DSQL_SCRIPT.Next;
      end;
      TabGlobal_i.DPROC_EXTERNA.First;
      while not TabGlobal_i.DPROC_EXTERNA.Eof do
      begin
        if (Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('ST', TabGlobal_i.DPROC_EXTERNA.NUMERO.Conteudo, TabGlobal_i.DPROC_EXTERNA.ATIVO.Conteudo) = 1) then
        begin
          FormPrincipal.texto.Lines.Add('  ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+' := TST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+'.Create(Self);');
          FormPrincipal.texto.Lines.Add('  Lst_Procedures.Add(ST'+Trim(TabGlobal_i.DPROC_EXTERNA.NOME.Conteudo)+');');
        end;
        TabGlobal_i.DPROC_EXTERNA.Next;
      end;
      TabGlobal_i.DTRIGGER.First;
      while not TabGlobal_i.DTRIGGER.Eof do
      begin
        if (Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo) <> '') and
           (TabGlobal_i.DTRIGGER.ATIVO.Conteudo = 1) and
           (PTabela(TabGlobal_i.DTABELAS, ['NUMERO'], [TabGlobal_i.DTRIGGER.NUMERO.Conteudo])) then
        begin
          FormPrincipal.texto.Lines.Add('  TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+' := TTR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+'.Create(Self);');
          FormPrincipal.texto.Lines.Add('  Lst_Triggers.Add(TR'+Trim(TabGlobal_i.DTRIGGER.NOME.Conteudo)+');');
        end;
        TabGlobal_i.DTRIGGER.Next;
      end;
      //if TabGlobal_i.DPROJETO.SELECIONAR_EMP.Conteudo = 1 then
      begin
        FormPrincipal.texto.Lines.Add('  I := 0;');
        //FormPrincipal.texto.Lines.Add('  Inicializa;');
        //FormPrincipal.texto.Lines.Add('  InicializaAmbiente;');
        FormPrincipal.texto.Lines.Add('  if Sistema.SelecionaUsr then');
        FormPrincipal.texto.Lines.Add('  begin');
        FormPrincipal.texto.Lines.Add('    Master := Sistema.Master;');
        FormPrincipal.texto.Lines.Add('    Sistema.Master := False;');
        FormPrincipal.texto.Lines.Add('    FormSelecionaEmpresa := TFormSelecionaEmpresa.Create(Application);');
        FormPrincipal.texto.Lines.Add('    Try');
        FormPrincipal.texto.Lines.Add('      if FormSelecionaEmpresa.ShowModal = mrOk then');
        FormPrincipal.texto.Lines.Add('        I:=1');
        FormPrincipal.texto.Lines.Add('      else');
        FormPrincipal.texto.Lines.Add('        FormPrincipal.ErronoSistema := True;');
        FormPrincipal.texto.Lines.Add('    Finally');
        FormPrincipal.texto.Lines.Add('      Sistema.Master := Master;');
        FormPrincipal.texto.Lines.Add('      FormSelecionaEmpresa.Free;');
        FormPrincipal.texto.Lines.Add('    end;');
        FormPrincipal.texto.Lines.Add('  end;');
      end;
      Bloco := True;
    End;
    if Pos('{03-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DCAMPOST.First;
      primeira := True;
      NrTab    := -1;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        TabGlobal_i.DTABELAS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo);
        TabGlobal_i.DTABELAS.AtualizaSql;
        TabGlobal_i.DTABELAS.First;
        if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
        begin
          if TabGlobal_i.DCAMPOST.NUMERO.Conteudo <> NrTab then
          begin
            Primeira := True;
            NrTab    := TabGlobal_i.DCAMPOST.NUMERO.Conteudo;
          end;
          if primeira then
          begin
            FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.OnCalcFields := CalculosD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
            primeira := False;
          end;
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      Bloco := True;
    end;
    if Pos('{04-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DCAMPOST.First;
      primeira := True;
      NrTab    := -1;
      while not TabGlobal_i.DCAMPOST.Eof do
      begin
        TabGlobal_i.DTABELAS.Filtro := 'NUMERO = '+IntToStr(TabGlobal_i.DCAMPOST.NUMERO.Conteudo);
        TabGlobal_i.DTABELAS.AtualizaSql;
        TabGlobal_i.DTABELAS.First;

        if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
          if TabGlobal_i.DCAMPOST.NUMERO.Conteudo <> NrTab then
          begin
            if NrTab <> -1 then
            begin
              FormPrincipal.texto.Lines.Add('end;');
              FormPrincipal.texto.Lines.Add('');
            end;
            NrTab := TabGlobal_i.DCAMPOST.NUMERO.Conteudo;
            Primeira := True;
          end;
        if (not TabGlobal_i.DCAMPOST.Eof) and (TabGlobal_i.DCAMPOST.CALCULADO.Conteudo = 1) and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
        begin
          if primeira then
          begin
            FormPrincipal.texto.Lines.Add('procedure TTabGlobal.CalculosD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'(DataSet: TDataSet);');
            FormPrincipal.texto.Lines.Add('begin');
            primeira := False;
          end;
          if TabGlobal_i.DCAMPOST.NAO_VIRTUAL.Conteudo <> 1 then
            FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'.Conteudo := CalculaD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'_'+Trim(TabGlobal_i.DCAMPOST.NOME.Conteudo)+'(Self);');
        end;
        TabGlobal_i.DCAMPOST.Next;
      end;
      if NrTab <> -1 then
      begin
        FormPrincipal.texto.Lines.Add('end;');
        FormPrincipal.texto.Lines.Add('');
      end;
      Bloco := True;
    End;
    if Pos('{05-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DSQL_SCRIPT.First;
      while not TabGlobal_i.DSQL_SCRIPT.Eof do
      begin
        if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) and
           (TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo = 2) then
          FormPrincipal.texto.Lines.Add('  SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Executar;');
        TabGlobal_i.DSQL_SCRIPT.Next;
      end;
      Bloco := True;
    End;
    if Pos('{06-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DSQL_SCRIPT.First;
      while not TabGlobal_i.DSQL_SCRIPT.Eof do
      begin
        if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) and
           (TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo = 3) then
          FormPrincipal.texto.Lines.Add('  SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Executar;');
        TabGlobal_i.DSQL_SCRIPT.Next;
      end;
      Bloco := True;
    End;
    if Pos('{07-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DSQL_SCRIPT.First;
      while not TabGlobal_i.DSQL_SCRIPT.Eof do
      begin
        if (Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('SC', TabGlobal_i.DSQL_SCRIPT.NUMERO.Conteudo, TabGlobal_i.DSQL_SCRIPT.ATIVO.Conteudo) = 1) and
           (TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo = 4) then
          FormPrincipal.texto.Lines.Add('  SC'+Trim(TabGlobal_i.DSQL_SCRIPT.NOME.Conteudo)+'.Executar;');
        TabGlobal_i.DSQL_SCRIPT.Next;
      end;
      Bloco := True;
    End;
    if Pos('{99-Final',FormPrincipal.texto2.Lines[I]) > 0 then
      Bloco := False;
    if Not Bloco then
    begin
      if inicio then
        FormPrincipal.texto.Lines[0] := FormPrincipal.texto2.Lines[I]
      else
        FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      Inicio := False;
    end;
  end;
  FormPrincipal.texto.Lines.SaveToFile(Projeto.Pasta + 'Abertura.Pas');

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Adapter;
Var
  I, Y, NrTab: Integer;
  Bloco,Inicio,Primeira: Boolean;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;

  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;

  TabGlobal_i.DBDADOS.Filtro := '';
  TabGlobal_i.DBDADOS.AtualizaSql;

  Bloco := False;
  Inicio := True;

  FormPrincipal.texto2.Lines.LoadFromFile(Projeto.Pasta + 'Princ_Adapter.Pas');
  for I := 0 to FormPrincipal.texto2.Lines.Count-1 do
  begin
    if Pos('{01-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DTABELAS.First;
      while not TabGlobal_i.DTABELAS.Eof do
      begin
        if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
          FormPrincipal.texto.Lines.Add('    D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' : TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+';');
        TabGlobal_i.DTABELAS.Next;
      end;
      Bloco := True;
    end;
    if Pos('{02-Início',FormPrincipal.texto2.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      TabGlobal_i.DTABELAS.Filtro := '';
      TabGlobal_i.DTABELAS.AtualizaSql;
      TabGlobal_i.DTABELAS.First;
      while not TabGlobal_i.DTABELAS.Eof do
      begin
        if (Trim(TabGlobal_i.DTABELAS.NOME.Conteudo) <> '') and
           (Localiza_ObjProjeto('TB', TabGlobal_i.DTABELAS.NUMERO.Conteudo, TabGlobal_i.DTABELAS.GLOBAL.Conteudo) = 1) then
        begin
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+' := TD'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.Create(Self);');
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AfterInsert  := Nil;');
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AfterPost    := Nil;');
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.AfterCancel  := Nil;');
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.BeforePost   := Nil;');
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.BeforeEdit   := Nil;');
          FormPrincipal.texto.Lines.Add('  D'+Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)+'.BeforeDelete := Nil;');
        end;
        TabGlobal_i.DTABELAS.Next;
      end;
      Bloco := True;
    End;
    if Pos('{99-Final',FormPrincipal.texto2.Lines[I]) > 0 then
      Bloco := False;
    if Not Bloco then
    begin
      if inicio then
        FormPrincipal.texto.Lines[0] := FormPrincipal.texto2.Lines[I]
      else
        FormPrincipal.texto.Lines.Add(FormPrincipal.texto2.Lines[I]);
      Inicio := False;
    end;
  end;
  FormPrincipal.texto.Lines.SaveToFile(Projeto.Pasta + 'Princ_Adapter.Pas');

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

procedure Gera_Modelo(Formulario, Titulo, Tabela: String; TipoFrm: Integer; Atualiza: Boolean; FModelo: String);
Var
  FilePas,FileDfm: String;
  I: Integer;
  Bloco, Inicio, Gerado: Boolean;
begin
  Gerado  := True;
  FilePas := Projeto.Pasta + Formulario + '.Pas';
  FileDfm := Projeto.Pasta + Formulario + '.Dfm';
  if Trim(FModelo) = '' then
    FModelo := 'Modelo'+IntToStr(TipoFrm);
  if not FileExists(FilePas) then
  begin
    if not CopiaArquivo(Projeto.PastaFontes + FModelo +'.Pas', FilePas) then
    begin
      Mensagem('Fonte não encontrado:' +^M +^M + Projeto.PastaFontes + FModelo +'.Pas',ModErro,[ModOk]);
      exit;
    end;
    Gerado := False;
  end;
  if not FileExists(FileDfm) then
  begin
    if not CopiaArquivo(Projeto.PastaFontes + FModelo +'.Dfm', FileDfm) then
    begin
      Mensagem('Fonte não encontrado:' +^M +^M + Projeto.PastaFontes + FModelo +'.Dfm',ModErro,[ModOk]);
      exit;
    end;
    Gerado := False;
  end;
  if not Atualiza then
    if Gerado then exit;

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto.Lines.LoadFromFile(FileDfm);
  FormPrincipal.Texto.Lines[0] := TrocaString(FormPrincipal.Texto.Lines[0],'XMakerModelo',Formulario,[rfReplaceAll, rfIgnoreCase]);
  FormPrincipal.Texto.Lines.SaveToFile(FileDfm);
  FormPrincipal.Texto.Lines.Clear;

  FormPrincipal.texto.Lines.LoadFromFile(FilePas);
  for I:=0 to FormPrincipal.texto.Lines.Count-1 do
    FormPrincipal.texto.Lines[I] := TrocaString(FormPrincipal.texto.Lines[I],'XMakerModelo',Formulario,[rfReplaceAll, rfIgnoreCase]);
  FormPrincipal.texto.Lines.SaveToFile(FilePas);

  Bloco := False;
  Inicio := True;
  FormPrincipal.Texto2.Lines.Clear;
  for I := 0 to FormPrincipal.texto.Lines.Count-1 do
  begin
    //if Pos('{01-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //End;
    //if Pos('{02-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //End;
    //if Pos('{03-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //End;
    //if Pos('{04-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //end;
    if Pos('{05-Início',FormPrincipal.texto.Lines[I]) > 0 then
    Begin
      FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      if (TipoFrm <> 3) and (TipoFrm <> 4) and (TipoFrm <> 5) and (TipoFrm <> 6) and (TipoFrm <> 7) then
      begin
        FormPrincipal.texto2.Lines.Add('  TabelaPrincipal    := TabGlobal.D'+Tabela+';');
        FormPrincipal.texto2.Lines.Add('  TituloModulo       := '+#39+ Titulo + #39 +';');
        FormPrincipal.texto2.Lines.Add('  Caption            := TituloModulo;');
      end
      else
      begin
        FormPrincipal.texto2.Lines.Add('  Caption := '+#39+ Titulo + #39 +';');
      end;
      Bloco := True;
    End;
    //if Pos('{07-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //end;
    //if Pos('{08-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //end;
    //if Pos('{09-Início',FormPrincipal.texto.Lines[I]) > 0 then
    //Begin
    //  FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
    //  Bloco := True;
    //End;
    if Pos('{99-Final',FormPrincipal.texto.Lines[I]) > 0 then
      Bloco := False;
    if Not Bloco then
    begin
      if inicio then
        FormPrincipal.texto2.Lines[0] := FormPrincipal.texto.Lines[I]
      else
        FormPrincipal.texto2.Lines.Add(FormPrincipal.texto.Lines[I]);
      Inicio := False;
    end;
  end;
  FormPrincipal.texto2.Lines.SaveToFile(FilePas);

  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
end;

end.
