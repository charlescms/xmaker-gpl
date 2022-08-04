{
   Programa.: GridPesquisa.PAS  -  Formulário de Pesquisa
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit GridPesquisa;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI5}{$ELSE}Variants,{$ENDIF}
  StdCtrls, Grids, DBGrids, ExtCtrls, Db, Tabela, Atributo, Buttons, Menus;

type
  TFormGridPesquisa = class(TForm)
    PnSup: TPanel;
    ShapeSup: TShape;
    LbTituloForm: TLabel;
    GridConsulta: TDBGrid;
    PnRodape: TPanel;
    EdPesquisa: TComboBox;
    LbPesquisa: TLabel;
    EdOperador: TComboBox;
    LbOperador: TLabel;
    DataSource: TDataSource;
    LbAcao: TLabel;
    EdEstilo: TComboBox;
    BtnOrdem: TSpeedButton;
    LbTransportar: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdPesquisaChange(Sender: TObject);
    procedure GridConsultaDblClick(Sender: TObject);
    procedure GridConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdEstiloClick(Sender: TObject);
    procedure BtnOrdemClick(Sender: TObject);
    procedure EdOperadorClick(Sender: TObject);
  private
    { Private declarations }
    TabelaPesquisa: TTabela;
    TabelaPrincipal: TTabela;
    Lst_Campos: TList;
    CamposArray: TStringList;
    procedure AtribuiMascara;
    procedure DispararPesquisa;
  public
    { Public declarations }
    Campo: TAtributo;
    AcaoPesquisa: Integer;
    TabEstrangeira: String;
    CamposVisuais: String;
    Filtro_Fixo: String;
    ChaveEstrangeira: String;
    Avulso: Boolean;
    Resultado: Variant;
    Selecionado: Boolean;
    Atalho: TShortCut;
    procedure Inicializa(Tabela, Campos, Filtro, Chave: String; TeclaAtalho: TShortCut = VK_F8; Acao: Integer = 1);
  end;

var
  FormGridPesquisa: TFormGridPesquisa;

implementation

{$R *.DFM}

uses RotinaEd, Rotinas, Publicas;

procedure TFormGridPesquisa.FormShow(Sender: TObject);
var
  I,Y: Integer;
  Pesquisa: String;
begin
  Lst_Campos := TList.Create;
  EdOperador.ItemIndex := 0;
  CamposArray := TSTringList.Create;
  if Assigned(Campo) then
  begin
    EdEstilo.ItemIndex := Campo.AcaoPesquisa;
    TabelaPrincipal := LocalizaTabela(Campo.TabEstrangeira);
    StringToArray(UpperCase(Campo.CamposVisuais),';',CamposArray);
  end
  else
  begin
    EdEstilo.ItemIndex := AcaoPesquisa;
    TabelaPrincipal := LocalizaTabela(TabEstrangeira);
    StringToArray(UpperCase(CamposVisuais),';',CamposArray);
  end;
  LbTituloForm.Caption := TabelaPrincipal.Titulo;
  LbTransportar.Caption := 'Tecle: '+ShortCutToText(Atalho)+' para selecionar ...';
  if TabelaPrincipal.TableType = ttTable then
  begin
    TabelaPesquisa := TTabela.Create(Self);
    with TabelaPesquisa do
    begin
      DataBase    := TabelaPrincipal.DataBase;
      Transaction := TabelaPrincipal.Transaction;
      Conexao;
      SqlPrincipal.Clear;
      SqlPrincipal.Add('Select ');
      for I:=0 to CamposArray.Count-1 do
        for Y:=0 to TabelaPrincipal.SqlPrincipal.Count-1 do
        begin
          Pesquisa := TabelaPrincipal.SqlPrincipal[Y];
          Pesquisa := Copy(Pesquisa,Pos('.',Pesquisa),Length(Pesquisa));
          if (Pos(' '+UpperCase(CamposArray[I]),UpperCase(Pesquisa)) > 0) then
          begin
            SqlPrincipal.Add(TabelaPrincipal.SqlPrincipal[Y]);
            if Copy(SqlPrincipal[SqlPrincipal.Count-1],Length(SqlPrincipal[SqlPrincipal.Count-1]),1) <> ',' then
              SqlPrincipal[SqlPrincipal.Count-1] := SqlPrincipal[SqlPrincipal.Count-1] + ',';
            Break;
          end;
        end;
      if Copy(SqlPrincipal[SqlPrincipal.Count-1],Length(SqlPrincipal[SqlPrincipal.Count-1]),1) = ',' then
        SqlPrincipal[SqlPrincipal.Count-1] := Copy(SqlPrincipal[SqlPrincipal.Count-1],01,Length(SqlPrincipal[SqlPrincipal.Count-1])-1);
      SqlPrincipal.Add('From '+TabelaPrincipal.NomeTabela);
      if Assigned(Campo) then
        FiltroFixo.AddStrings(Campo.FiltroFixo)
      else
        FiltroFixo.Add(Filtro_Fixo);
      FiltroExtra.AddStrings(TabelaPrincipal.FiltroExtra);
      ChaveIndice := Copy(Trim(SqlPrincipal[1]),01,Pos(' ',Trim(SqlPrincipal[1]))-1);
    end;
  end
  else
  begin
    TabelaPesquisa := TabelaPrincipal;
    EdOperador.Visible := False;
    LbOperador.Visible := False;
    BtnOrdem.Visible   := False;
    EdEstilo.Left := BtnOrdem.Left;
    LbAcao.Left   := BtnOrdem.Left;
  end;
  DataSource.DataSet := TabelaPesquisa;
  DispararPesquisa;
end;

procedure TFormGridPesquisa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Selecionado then
    ModalResult := mrOk;
  CamposArray.Free;
  Lst_Campos.Free;
  if TabelaPrincipal.TableType = ttTable then
    TabelaPesquisa.Free
  else
    TabelaPesquisa.Close;
end;

procedure TFormGridPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TFormGridPesquisa.AtribuiMascara;
var
  I,Y: Integer;
  Atributo: TAtributo;
  CampoQuery: TField;
begin
  Lst_Campos.Clear;
  with TabelaPesquisa do
  begin
    for I:=0 to TabelaPrincipal.Campos.Count-1 do
    begin
      Y := CamposArray.IndexOf(UpperCase(TAtributo(TabelaPrincipal.Campos[I]).Nome));
      if Y > -1 then
      begin
        Atributo := TAtributo(TabelaPrincipal.Campos[I]);
        CampoQuery := FieldByName(CamposArray[Y]);
        with CampoQuery do
        begin
          EditMask := Atributo.Valor.EditMask;
          DisplayLabel := Atributo.Titulo;
          case DataType of
            ftSmallint: TSmallintField(CampoQuery).DisplayFormat := TSmallintField(Atributo.Valor).DisplayFormat;
            ftInteger: TIntegerField(CampoQuery).DisplayFormat := TIntegerField(Atributo.Valor).DisplayFormat;
            ftFloat: TFloatField(CampoQuery).DisplayFormat := TFloatField(Atributo.Valor).DisplayFormat;
          end;
          DisplayWidth := CalculaTamanho(Atributo);
          Index := Y;
          Lst_Campos.Add(Atributo);
        end;
      end;
    end;
  end;
end;

procedure TFormGridPesquisa.DispararPesquisa;
Var
  Oper, Delimit_E,Delimit_D, Separador_E, Negacao: String;
  FormatoData: string;
  CmpF: TAtributo;
  Data: TDateTime;
  I: Integer;

  procedure AtualizaSql(Tabela: TTabela);
  begin
    Screen.Cursor := crHourGlass;
    with Tabela do
    try
      DisableControls;
      Active   := False;
      if SqlPrincipal.Count > 0 then
      begin
        Sql.Clear;
        Sql.AddStrings(SqlPrincipal);
        if Trim(FiltroExtra.Text) <> '' then
          Sql.AddStrings(FiltroExtra);
        if Trim(Filtro.Text) <> '' then
        begin
          Sql.Add('Where ');
          Sql.AddStrings(Filtro);
        end;
        if Trim(FiltroRelac.Text) <> '' then
        begin
          if Trim(Filtro.Text) = '' then
            Sql.Add('Where ')
          else
            Sql.Add('AND ');
          Sql.AddStrings(FiltroRelac);
        end;
        if Trim(FiltroFixo.Text) <> '' then
        begin
          if (Trim(Filtro.Text) = '') and (Trim(FiltroRelac.Text) = '') then
            Sql.Add('Where ')
          else
            Sql.Add('AND ');
          Sql.AddStrings(FiltroFixo);
        end;
        if Trim(ChaveIndice) <> '' then
          Sql.Add('Order By '+ChaveIndice);
      end;
      Prepare;
      TabelaPrincipal.Parametros(TabelaPesquisa);
    finally
      Active := True;
      AtribuiMascara;
      First;
      EnableControls;
      Screen.Cursor := crDefault;
    end;
  end;

begin
  if TabelaPrincipal.TableType = ttTable then
  begin
    TabelaPesquisa.Filtro.Clear;
    for I:=0 to Lst_Campos.Count-1 do
      if UpperCase(TAtributo(Lst_Campos[I]).Nome) = UpperCase(CamposArray[0]) then
      begin
        CmpF := Lst_Campos[I];
        Break;
      end;
    if CmpF = Nil then
    begin
      MessageDlg('Campo não filtrado !',mtError,[mbOk],0);
      EdPesquisa.SetFocus;
      exit;
    end;
    if (Trim(EdPesquisa.Text) <> '') or (EdOperador.ItemIndex = 7) then
    begin
      if (CmpF.Tipo = tpMemo) or (CmpF.Tipo = tpImagem) or
         (CmpF.Tipo = tpBlob) or (CmpF.Tipo = tpGraphic) then
      begin
        MessageDlg('Campo Memo ou Imagem não podem ser filtrados !',mtError,[mbOk],0);
        EdPesquisa.SetFocus;
        exit;
      end;
      if (CmpF.Calculado) then
      begin
        MessageDlg('Campo "Calculado" não pode ser filtrado !',mtError,[mbOk],0);
        EdPesquisa.SetFocus;
        exit;
      end;
      if (CmpF.Tipo = tpInteiro) or (CmpF.Tipo = tpSmallint) or
         (CmpF.Tipo = tpInteger) or (CmpF.Tipo = tpWord) or
         (CmpF.Tipo = tpAutoInc) or (CmpF.Tipo = tpLargeInt) or
         (CmpF.Tipo = tpFracionario) or (CmpF.Tipo = tpFloat) or
         (CmpF.Tipo = tpCurrency) or (CmpF.Tipo = tpBCD) then
        EdPesquisa.Text := IIF(StrNumerica(EdPesquisa.Text), EdPesquisa.Text, '0');
      if ((CmpF.Tipo <> tpAlfanumerico) or
          (CmpF.Tipo <> tpString) or
          (CmpF.Tipo <> tpWideString)) and
          (EdOperador.ItemIndex = 6) then
      begin
        MessageDlg('Operação ''Contém'' é somente válida para campos Alfanuméricos !',mtError,[mbOk],0);
        EdPesquisa.SetFocus;
        exit;
      end;
      Delimit_E := '';
      Delimit_D := '';
      Oper      := '';
      Negacao   := '';
      if (CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpData) or
         (CmpF.Tipo = tpDateTime) or (CmpF.Tipo = tpString) or
         (CmpF.Tipo = tpWideString) then
      begin
        Delimit_E := #39;
        if (EdOperador.ItemIndex <= 1) and ((CmpF.Tipo = tpAlfanumerico) or
           (CmpF.Tipo = tpString) or (CmpF.Tipo = tpWideString)) then
        begin
          Oper        := ' LIKE ';
          Delimit_E   := #39;
          Delimit_D   := '%'+#39;
        end
        else
          Delimit_D := #39;
      end;
      if EdOperador.ItemIndex = 0 then
      begin
       if Trim(Oper) = '' then
         Oper := ' = ';
      end
      else if EdOperador.ItemIndex = 1 then
      begin
        if Trim(Oper) = '' then
          Oper := ' <> '
        else
          Negacao := ' Not ';
      end
      else if EdOperador.ItemIndex = 2 then
        Oper := ' < '
      else if EdOperador.ItemIndex = 3 then
        Oper := ' <= '
      else if EdOperador.ItemIndex = 4 then
        Oper := ' > '
      else if EdOperador.ItemIndex = 5 then
        Oper := ' >= '
      else if EdOperador.ItemIndex = 6 then
      begin
        Oper        := ' LIKE ';
        Delimit_E   := #39+'%';
        Delimit_D   := '%'+#39;
      end
      else if EdOperador.ItemIndex = 7 then
      begin
        EdPesquisa.Text  := '';
        Oper             := ' IS NULL ';
        Delimit_E        := '';
        Delimit_D        := '';
      end;
      if ((CmpF.Tipo = tpData) or (CmpF.Tipo = tpDateTime)) and
          (EdOperador.ItemIndex <> 7) then
      begin
        try
          FormatoData     := ShortDateFormat;
          ShortDateFormat := 'd/m/y';
          Data            := StrToDate(EdPesquisa.Text);
          ShortDateFormat := FormatoData;
          EdPesquisa.Text := DataSql(Data);
        except
          on EConvertError do
          begin
             ShortDateFormat := FormatoData;
             MessageDlg('Data inválida !', mtError, [mbOk], 0);
             EdPesquisa.SelectAll;
             EdPesquisa.SetFocus;
             exit;
          end;
        end;
      end;
      Separador_E := Negacao + '(';
      if (CmpF.Tipo = tpAlfanumerico) or (CmpF.Tipo = tpString) or
         (CmpF.Tipo = tpWideString) then
        TabelaPesquisa.Filtro.Text := Separador_E + 'Upper('+CmpF.NomeTabela + '.' + CmpF.NomeOriginal + ')' + Oper + Delimit_E + UpperCase(EdPesquisa.Text) + Delimit_D + ')'
      else
        TabelaPesquisa.Filtro.Text := Separador_E + CmpF.NomeTabela + '.' + CmpF.NomeOriginal + Oper + Delimit_E + EdPesquisa.Text + Delimit_D + ')';
      EdPesquisa.Items.Add(EdPesquisa.Text);
    end;
    if TabelaPesquisa.Active then
    begin
      LbPesquisa.Caption := 'Pesquisar na coluna: ' + CmpF.Titulo;
      if (CmpF.Tipo = tpData) or (CmpF.Tipo = tpDateTime) then
      begin
        EdEstilo.ItemIndex := 1;
        EdEstiloClick(Self);
      end;
      TabelaPesquisa.ChaveIndice := CmpF.NomeTabela + '.' + CmpF.NomeOriginal;
    end;
    AtualizaSql(TabelaPesquisa);
    AtribuiMascara;
  end
  else
  begin
    if not TabelaPesquisa.Active then
      TabelaPesquisa.AtualizaSql;
    if EdPesquisa.Text <> '' then
      TabelaPesquisa.Locate(GridConsulta.Columns[0].Field.FieldName, EdPesquisa.Text, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TFormGridPesquisa.EdPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if Assigned(Campo) then
    begin
      if Campo.AcaoPesquisa = 1 then
        DispararPesquisa;
    end
    else
    begin
      if AcaoPesquisa = 1 then
        DispararPesquisa;
    end;
    GridConsulta.SetFocus;  
  end;
  if Key = Atalho then
    GridConsultaDblClick(Self);
end;

procedure TFormGridPesquisa.EdPesquisaChange(Sender: TObject);
begin
  if Assigned(Campo) then
  begin
    if Campo.AcaoPesquisa = 0 then
      DispararPesquisa;
  end
  else
  begin
    if AcaoPesquisa = 0 then
      DispararPesquisa;
  end;
end;

procedure TFormGridPesquisa.GridConsultaDblClick(Sender: TObject);
var
  Lista: TStringList;
  I: Integer;
begin
  if Assigned(Campo) then
  begin
    if Avulso then
      Resultado := TabelaPesquisa.FieldByName(Campo.ChaveEstrangeira).Value
    else
      Campo.Valor.Value := TabelaPesquisa.FieldByName(Campo.ChaveEstrangeira).Value;
  end
  else
  begin
    if Avulso then
    begin
      if Pos(';', ChaveEstrangeira) > 0 then
      begin
        Lista := TStringList.Create;
        StringToArray(ChaveEstrangeira, ';', Lista);
        Resultado := VarArrayCreate([0, Lista.Count-1], varVariant);
        for I:=0 to Lista.Count-1 do
          Resultado[I] := TabelaPesquisa.FieldByName(Lista[I]).Value;
      end
      else
        Resultado := TabelaPesquisa.FieldByName(ChaveEstrangeira).Value;
    end
    else
      Campo.Valor.Value := TabelaPesquisa.FieldByName(ChaveEstrangeira).Value;
  end;
  Selecionado := True;
  Close;
end;

procedure TFormGridPesquisa.GridConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = Atalho) or (Key = 13) then
    GridConsultaDblClick(Self);
end;

procedure TFormGridPesquisa.EdEstiloClick(Sender: TObject);
begin
  if Assigned(Campo) then
    Campo.AcaoPesquisa := EdEstilo.ItemIndex
  else
    AcaoPesquisa := EdEstilo.ItemIndex;
  EdPesquisa.SetFocus;
end;

procedure TFormGridPesquisa.BtnOrdemClick(Sender: TObject);
var
  Atual: String;
  I: Integer;
begin
  EdPesquisa.Clear;
  if TabelaPrincipal.TableType = ttTable then
  begin
    if CamposArray.Count = 1 then
      exit;
    Atual := CamposArray[0];
    for I:=0 to CamposArray.Count-2 do
      CamposArray[I] := CamposArray[I+1];
    CamposArray[CamposArray.Count-1] := Atual;
  end;
  DispararPesquisa;
end;

procedure TFormGridPesquisa.EdOperadorClick(Sender: TObject);
begin
  EdPesquisa.SetFocus;
end;

procedure TFormGridPesquisa.Inicializa(Tabela, Campos, Filtro, Chave: String; TeclaAtalho: TShortCut = VK_F8; Acao: Integer = 1);
begin
  TabEstrangeira   := Tabela;
  CamposVisuais    := Campos;
  Filtro_Fixo      := Filtro;
  ChaveEstrangeira := Chave;
  AcaoPesquisa     := Acao;
  Atalho           := TeclaAtalho;
  Avulso           := True;
end;

end.
