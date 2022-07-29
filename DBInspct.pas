(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.007                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit DBInspct;

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, DB, DBCtrls,
  DBTables, InspCtrl, StrsEdit, PicsEdit, Variants;

type

  TCustomDBInspector = class;

  TInspectorDataLink = class(TDataLink)
  private
    FInspector: TCustomDBInspector;
    procedure DataSetBeforePost(ADataSet: TDataSet);
  protected
    procedure CheckBrowseMode; override;
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(AInspector: TCustomDBInspector);
  end;

  TBlobEditorType = (beNone,beText,beImage);

  TGetBlobEditorTypeEvent = procedure(Sender: TObject; Field: TField; var BlobEditorType: TBlobEditorType) of object;

  TCustomDBInspector = class(TCustomInspector)
  private
    FMyself: Boolean;
    FOnGetBlobEditorType: TGetBlobEditorTypeEvent;
    FDataLink: TInspectorDataLink;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetReadOnlyProperty: Boolean;
    procedure SetReadOnlyProperty(Value: Boolean);
    procedure ActiveChanged;
    function ActiveDataSet: Boolean;
    function LinkedDataSet: TDataSet;
    function VisibleCount: Integer;
  protected
    procedure ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetMaxLength(TheIndex: Integer): Integer; override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetIndent: Integer; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
    function GetBlobEditor: TBlobEditorType; virtual;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnlyProperty write SetReadOnlyProperty default False;
    property OnGetBlobEditorType: TGetBlobEditorTypeEvent read FOnGetBlobEditorType write FOnGetBlobEditorType;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function VisibleIndex(TheIndex: Integer): Integer;
  end;

  TDBInspector = class(TCustomDBInspector)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property IntegralHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property PaintStyle;
    property Splitter;
    property DataSource;
    property ReadOnly;
    property OnGetNextValue;
    property OnGetButtonType;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnGetBlobEditorType;
  end;

implementation

uses Tabela, Estrutura_Case, Rotinas, Abertura;

procedure TInspectorDataLink.DataSetBeforePost(ADataSet: TDataSet);
begin
  if Assigned(ADataSet) and Assigned(FInspector) then
    FInspector.ApplyChanges;
end;

procedure TInspectorDataLink.CheckBrowseMode;
begin
  inherited;
  if Assigned(DataSet) and (DataSet.State=dsEdit) then FInspector.ApplyChanges;
end;

procedure TInspectorDataLink.ActiveChanged;
begin
  inherited;
  FInspector.ActiveChanged;
end;

procedure TInspectorDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(DataSet) then DataSet.BeforePost:=DataSetBeforePost;
  FInspector.Update;
end;

procedure TInspectorDataLink.LayoutChanged;
begin
  with FInspector do
  begin
    ItemCount:=VisibleCount;
    Update;
  end;
end;

procedure TInspectorDataLink.RecordChanged(Field: TField);
begin
  inherited;
  with FInspector do
    if not FMyself then Update
    else FMyself:=False;
end;

constructor TInspectorDataLink.Create(AInspector: TCustomDBInspector);
begin
  inherited Create;
  FInspector:=AInspector;
end;

function TCustomDBInspector.GetDataSource: TDataSource;
begin
  Result:=FDataLink.DataSource;
end;

procedure TCustomDBInspector.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource:=Value;
end;

function TCustomDBInspector.GetReadOnlyProperty: Boolean;
begin
  Result:=FDataLink.ReadOnly;
end;

procedure TCustomDBInspector.SetReadOnlyProperty(Value: Boolean);
begin
  FDataLink.ReadOnly:=Value;
end;

procedure TCustomDBInspector.ActiveChanged;
begin
  if ActiveDataSet then ItemCount:=VisibleCount
  else ItemCount:=0;
end;

function TCustomDBInspector.ActiveDataSet: Boolean;
begin
  with FDataLink do
    Result:=Assigned(DataSource) and Assigned(DataSource.DataSet) and DataSource.DataSet.Active;
end;

function TCustomDBInspector.LinkedDataSet: TDataSet;
begin
  Result:=FDataLink.DataSource.DataSet;
end;

function TCustomDBInspector.VisibleCount: Integer;
var
  i: Integer;
begin
  Result:=0;
  if LinkedDataSet<>nil then
    with LinkedDataSet do
      for i:=0 to Pred(FieldCount) do
        if Fields[i].Visible then Inc(Result);
end;

procedure TCustomDBInspector.ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string);
begin
  if (Editing and ActiveDataSet) and (TheIndex > -1) then
    with LinkedDataSet do
      if not (State in [dsEdit,dsInsert]) and not Fields[VisibleIndex(TheIndex)].IsBlob then
      begin
        FMyself:=True;
        Edit;
      end;
  inherited;
end;

function TCustomDBInspector.GetName(TheIndex: Integer): string;
begin
  if ActiveDataSet then
    Result:=LinkedDataSet.Fields[VisibleIndex(TheIndex)].DisplayName
  else Result:='';
end;

function TCustomDBInspector.GetValue(TheIndex: Integer): string;
var
  Pesquisa: Variant;
begin
  if (TheIndex > -1) and (TheIndex <= ItemCount-1) and (ActiveDataSet)  then
  begin
    with LinkedDataSet.Fields[VisibleIndex(TheIndex)] do
    begin
      if IsBlob then
        if (LinkedDataSet.Fields[VisibleIndex(TheIndex)] as TBlobField).BlobSize=0 then Result:=''
        else Result:=(LinkedDataSet.Fields[VisibleIndex(TheIndex)] as TBlobField).Value
      else begin
        if ((LowerCase(TTabela(DataSet).NomeTabela) = 'tabelas') and
           ((LowerCase(FieldName) = 'abrir_tabela') or
            (LowerCase(FieldName) = 'use_generator') or
            (LowerCase(FieldName) = 'global'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'bdados') and
           ((LowerCase(FieldName) = 'padrao') or
            (LowerCase(FieldName) = 'login')))  or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'campost') and
           ((LowerCase(FieldName) = 'chave') or
            (LowerCase(FieldName) = 'calculado') or
            (LowerCase(FieldName) = 'invisivel') or
            (LowerCase(FieldName) = 'sempre_atribui') or
            (LowerCase(FieldName) = 'sem_insert') or
            (LowerCase(FieldName) = 'valida_onexit') or
            (LowerCase(FieldName) = 'limpar_campo'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'indicest') and
           ((LowerCase(FieldName) = 'crescente'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'trigger_i') and
            (LowerCase(FieldName) = 'ativo')) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'processos') and
           ((LowerCase(FieldName) = 'ativo'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'relaciona') and
           ((LowerCase(FieldName) = 'ativo') or
            (LowerCase(FieldName) = 'key_sql'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'proc_externa') and
           ((LowerCase(FieldName) = 'ativo'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'consulta') and
           ((LowerCase(FieldName) = 'ativo'))) or
           ((LowerCase(TTabela(DataSet).NomeTabela) = 'sql_script') and
           ((LowerCase(FieldName) = 'ativo'))) then
          Result := IIF(Value = 1, 'Sim', 'Não')
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'campost') and
           (LowerCase(FieldName) = 'tipo_pre_validacao') then
          Result := IIF(Value = 1, 'Invisível', 'Não Editável')
        else if ((LowerCase(TTabela(DataSet).NomeTabela) = 'tabelas') or
                 (LowerCase(TTabela(DataSet).NomeTabela) = 'proc_externa') or
                 (LowerCase(TTabela(DataSet).NomeTabela) = 'consulta') or
                 (LowerCase(TTabela(DataSet).NomeTabela) = 'sql_script')) and
                (LowerCase(FieldName) = 'base') then
        begin
          if (Trim(AsString) <> '') and (PTabela(TabGlobal_i.DBDADOS, ['numero'], [AsString], ['nome'], pesquisa)) then
          begin
            if Pesquisa[0] <> Null then
              Result:=Pesquisa[0]
            else
              Result:=''
          end
          else
            Result:=''
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'bdados') and
           (LowerCase(FieldName) = 'bdados') then
        begin
          if (TabGlobal_i.DBDADOS.BDADOS.Conteudo > 0) and (TabGlobal_i.DBDADOS.BDADOS.Conteudo <= Length(Bancos_Suportados)) then
            Result:=Bancos_Suportados[TabGlobal_i.DBDADOS.BDADOS.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'campost') and
           (LowerCase(FieldName) = 'tipo') then
        begin
          if (TabGlobal_i.DCAMPOST.TIPO.Conteudo > 0) and (TabGlobal_i.DCAMPOST.TIPO.Conteudo <= Length(Tipos_Suportados)) then
            Result:=Tipos_Suportados[TabGlobal_i.DCAMPOST.TIPO.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'campost') and
           (LowerCase(FieldName) = 'tipo_fisico') then
        begin
          if (TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo > 0) and (TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo <= Length(Tipos_Campo_Suportados)) then
            Result:=Tipos_Campo_Suportados[TabGlobal_i.DCAMPOST.TIPO_FISICO.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'campost') and
           (LowerCase(FieldName) = 'edicao') then
        begin
          if (TabGlobal_i.DCAMPOST.EDICAO.Conteudo > 0) and (TabGlobal_i.DCAMPOST.EDICAO.Conteudo <= Length(Edicoes_Suportados)) then
            Result:=Edicoes_Suportados[TabGlobal_i.DCAMPOST.EDICAO.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'campost') and
           (LowerCase(FieldName) = 'calculado_formula') then
        begin
          Result := TabGlobal_i.DCAMPOST.CODIFICACAO.Conteudo.Text;
          {if PTabela(TabGlobal_i.DCALCULADOS, ['NUMERO', 'SEQUENCIA'], [TabGlobal_i.DCAMPOST.NUMERO.Conteudo, TabGlobal_i.DCAMPOST.SEQUENCIA.Conteudo], ['CODIFICACAO'], Pesquisa) then
            Result:=Pesquisa[0]
          else
            Result:='';}
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'relaciona') and
           (LowerCase(FieldName) = 'tipo') then
        begin
          if (TabGlobal_i.DRELACIONA.TIPO.Conteudo > 0) and (TabGlobal_i.DRELACIONA.TIPO.Conteudo <= Length(Tipos_Relacionamento)) then
            Result:=Tipos_Relacionamento[TabGlobal_i.DRELACIONA.TIPO.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'processos') and
           (LowerCase(FieldName) = 'tipo') then
        begin
          if (TabGlobal_i.DPROCESSOS.TIPO.Conteudo > 0) and (TabGlobal_i.DPROCESSOS.TIPO.Conteudo <= Length(Tipos_Processo)) then
            Result:=Tipos_Processo[TabGlobal_i.DPROCESSOS.TIPO.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'trigger_i') and
           (LowerCase(FieldName) = 'instante_ativacao') then
        begin
          if (TabGlobal_i.DTRIGGER.INSTANTE_ATIVACAO.Conteudo > 0) and (TabGlobal_i.DTRIGGER.INSTANTE_ATIVACAO.Conteudo <= Length(Tipos_Trigger)) then
            Result:=Tipos_Trigger[TabGlobal_i.DTRIGGER.INSTANTE_ATIVACAO.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'trigger_i') and
           (LowerCase(FieldName) = 'disparar') then
        begin
          if (TabGlobal_i.DTRIGGER.DISPARAR.Conteudo > 0) and (TabGlobal_i.DTRIGGER.DISPARAR.Conteudo <= Length(Disparo_Trigger)) then
            Result:=Disparo_Trigger[TabGlobal_i.DTRIGGER.DISPARAR.Conteudo]
          else
            Result:='';
        end
        else if (LowerCase(TTabela(DataSet).NomeTabela) = 'sql_script') and
           (LowerCase(FieldName) = 'execucao') then
        begin
          if (TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo > 0) and (TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo <= Length(Tipos_Script)) then
            Result:=Tipos_Script[TabGlobal_i.DSQL_SCRIPT.EXECUCAO.Conteudo]
          else
            Result:='';
        end
        else
          Result:=AsString
      end;
    end;
  end
  else Result:='';
end;

procedure TCustomDBInspector.SetValue(TheIndex: Integer; const Value: string);
var
  Ok: Boolean;
  Pesquisa: Variant;
  I: Integer;
begin
  if (ActiveDataSet) and (TheIndex > -1) then
    with LinkedDataSet do
    begin
      Ok := True;
      if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'tabelas') and
         (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
        Ok := FormDB_Case.ValidaNomeCampo(Value, FieldByName('numero').Value, FieldByName('numero').Value, True)
      else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
         (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
        Ok := FormDB_Case.ValidaNomeCampo(Value, FieldByName('numero').Value, FieldByName('sequencia').Value, False)
      else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'bdados') and
         (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
        Ok := FormDB_Case.ValidaNomeBanco(Value, FieldByName('numero').Value)
      else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'proc_externa') and
         (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
        Ok := FormDB_Case.ValidaNomeStored(Value, FieldByName('numero').Value)
      else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'sql_script') and
         (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
        Ok := FormDB_Case.ValidaNomeScript(Value, FieldByName('numero').Value);
      if Ok then
      begin
        if not (State in [dsEdit,dsInsert]) then Edit;
        if ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'tabelas') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'abrir_tabela') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'use_generator') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'global'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'bdados') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'padrao') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'login'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'chave') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'calculado') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'invisivel') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'sempre_atribui') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'sem_insert') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'valida_onexit') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'limpar_campo'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'indicest') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'crescente'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'trigger_i') and
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'ativo')) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'processos') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'ativo'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'relaciona') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'ativo') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'key_sql'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'proc_externa') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'ativo'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'consulta') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'ativo'))) or
           ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'sql_script') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'ativo'))) then
          Fields[VisibleIndex(TheIndex)].AsString:=IIF(LowerCase(Value)='sim', 1, 0)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tipo_pre_validacao') then
          Fields[VisibleIndex(TheIndex)].AsString:=IIF(LowerCase(Value)='invisível', 1, 2)
        else if ((LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'tabelas') or
                 (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'proc_externa') or
                 (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'consulta') or
                 (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'sql_script')) and
                (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'base') then
        begin
          if PTabela(TabGlobal_i.DBDADOS, ['UPPER(nome)'], [UpperCase(Value)], ['numero'], Pesquisa) then
          begin
            if Pesquisa[0] <> Null then
              Fields[VisibleIndex(TheIndex)].Value:=Pesquisa[0]
            else
              Fields[VisibleIndex(TheIndex)].Value:=0;
          end
          else
            Fields[VisibleIndex(TheIndex)].Value:=0;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'bdados') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'bdados') then
        begin
          for I:=1 to Length(Bancos_Suportados) do
            if LowerCase(Trim(Bancos_Suportados[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tipo') then
        begin
          for I:=1 to Length(Tipos_Suportados) do
            if LowerCase(Trim(Tipos_Suportados[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tipo_fisico') then
        begin
          for I:=1 to Length(Tipos_Campo_Suportados) do
            if LowerCase(Trim(Tipos_Campo_Suportados[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'edicao') then
        begin
          for I:=1 to Length(Edicoes_Suportados) do
            if LowerCase(Trim(Edicoes_Suportados[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              if I <> 5 then
                FieldByName('TAB_ESTRANGEIRA').AsString := '';
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'relaciona') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tipo') then
        begin
          for I:=1 to Length(Tipos_Relacionamento) do
            if LowerCase(Trim(Tipos_Relacionamento[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'processos') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tipo') then
        begin
          for I:=1 to Length(Tipos_Processo) do
            if LowerCase(Trim(Tipos_Processo[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'trigger_i') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'instante_ativacao') then
        begin
          for I:=1 to Length(Tipos_Trigger) do
            if LowerCase(Trim(Tipos_Trigger[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'trigger_i') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'disparar') then
        begin
          for I:=1 to Length(Disparo_Trigger) do
            if LowerCase(Trim(Disparo_Trigger[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'sql_script') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'execucao') then
        begin
          for I:=1 to Length(Tipos_Script) do
            if LowerCase(Trim(Tipos_Script[I])) = LowerCase(Trim(Value)) then
            begin
              Fields[VisibleIndex(TheIndex)].AsInteger:=I;
              break;
            end;
        end
        else
          Fields[VisibleIndex(TheIndex)].AsString:=Value;
        if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'bdados') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
          FormDB_Case.Apos_Valor(0)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'tabelas') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
          FormDB_Case.Apos_Valor(1)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'campost') and
           ((LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tamanho') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'tipo') or
            (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'chave')) then
          FormDB_Case.Apos_Valor(2)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'indicest') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'titulo_i') then
          FormDB_Case.Apos_Valor(3)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'relaciona') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'titulo_i') then
          FormDB_Case.Apos_Valor(4)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'processos') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'titulo_i') then
          FormDB_Case.Apos_Valor(5)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'consulta') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
          FormDB_Case.Apos_Valor(6)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'trigger_i') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
          FormDB_Case.Apos_Valor(7)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'proc_externa') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
          FormDB_Case.Apos_Valor(8)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'sql_script') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'nome') then
          FormDB_Case.Apos_Valor(9)
        else if (LowerCase(TTabela(Fields[VisibleIndex(TheIndex)].DataSet).NomeTabela) = 'diagrama') and
           (LowerCase(Fields[VisibleIndex(TheIndex)].FieldName) = 'titulo_i') then
          FormDB_Case.Apos_Valor(10);
      end;
    end;
end;

function TCustomDBInspector.GetMaxLength(TheIndex: Integer): Integer;
begin
  if (TheIndex > -1) and (TheIndex <= ItemCount-1) and (ActiveDataSet) then
    Result:=LinkedDataSet.Fields[VisibleIndex(TheIndex)].Size
  else Result:=0;
end;

function TCustomDBInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  if (TheIndex > -1) and (TheIndex <= ItemCount-1) then
    Result:=ReadOnly or (ActiveDataSet and LinkedDataSet.Fields[VisibleIndex(TheIndex)].IsBlob)
  else
    Result:=True;  
end;

function TCustomDBInspector.GetIndent: Integer;
begin
  Result:=0;
end;

function TCustomDBInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=True;
end;

function TCustomDBInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  case GetBlobEditor of
    beText,beImage: Result:=btDialog;
  else Result:=inherited GetButtonType(TheIndex);
  end;
end;

function TCustomDBInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  case GetBlobEditor of
    beText,beImage: Result:=True;
  else Result:=inherited GetEnableExternalEditor(TheIndex);
  end;
end;

function TCustomDBInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  {case GetBlobEditor of
    beText:
      if ActiveDataSet then
        with LinkedDataSet,TfrmStrings.Create(Application) do
        try
          Strings.Assign(Fields[VisibleIndex(TheIndex)]);
          if ShowModal=mrOk then
          begin
            if not (State in [dsEdit,dsInsert]) then Edit;
            Fields[VisibleIndex(TheIndex)].Assign(Strings);
          end;
        finally
          Free;
        end;
    beImage:
      if ActiveDataSet then
        with LinkedDataSet,TfrmPicture.Create(Application) do
        try
          Picture.Assign(Fields[VisibleIndex(TheIndex)]);
          if ShowModal=mrOk then
          begin
            if not (State in [dsEdit,dsInsert]) then Edit;
            with Fields[VisibleIndex(TheIndex)] do
              if Picture.Graphic is TBitmap then Assign(Picture)
              else Clear;
          end;
        finally
          Free;
        end;
  else Result:=inherited CallEditor(TheIndex);
  end;}
  Result:=inherited CallEditor(TheIndex);
end;

function TCustomDBInspector.GetBlobEditor: TBlobEditorType;
begin
  Result:=beNone;
  if (ItemIndex<>-1) and ActiveDataSet then
    with LinkedDataSet,Fields[ItemIndex] do
      if IsBlob then
        if Assigned(FOnGetBlobEditorType) then FOnGetBlobEditorType(Self,Fields[ItemIndex],Result);
end;

constructor TCustomDBInspector.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink:=TInspectorDataLink.Create(Self);
end;

destructor TCustomDBInspector.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function TCustomDBInspector.VisibleIndex(TheIndex: Integer): Integer;
var
  i,V: Integer;
begin
  Result:=-1;
  V:=-1;
  if LinkedDataSet<>nil then
    with LinkedDataSet do
      for i:=0 to Pred(FieldCount) do
        if Fields[i].Visible then
        begin
          Inc(V);
          if V=TheIndex then
          begin
            Result:=i;
            Break;
          end;
        end;
end;

end.
