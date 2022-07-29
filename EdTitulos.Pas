unit EdTitulos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Grids, Buttons, ComCtrls, Db, SDEngine;

type
  TFormTitulos = class(TForm)
    BtnOk: TButton;
    BtnFechar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    StringGrid: TStringGrid;
    BtnIncluir: TBitBtn;
    BtnExcluir: TBitBtn;
    ComboBox: TComboBox;
    BtnAbaixo: TBitBtn;
    BtnAcima: TBitBtn;
    BtnAuto: TBitBtn;
    SDDatabase: TSDDatabase;
    SDQuery: TSDQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure BtnExcluirClick(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAcimaClick(Sender: TObject);
    procedure BtnAbaixoClick(Sender: TObject);
    procedure BtnAutoClick(Sender: TObject);
  private
    { Private declarations }
    procedure Atualiza_Lista(Lista_P: TStringList);
  public
    { Public declarations }
    Lista_Parametros: TStringList;
  end;

var
  FormTitulos: TFormTitulos;

implementation

uses Rotinas, Abertura;

{$R *.DFM}

procedure TFormTitulos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    {Atua como a tecla TAB}
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormTitulos.BtnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormTitulos.Atualiza_Lista(Lista_P: TStringList);
var
  I, P: Integer;
  Lista: TStringList;
begin
  StringGrid.RowCount   := Lista_P.Count+1;
  if StringGrid.RowCount = 1 then
  begin
    StringGrid.RowCount := 2;
    StringGrid.Options  := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect];
  end
  else
    StringGrid.Options  := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
  StringGrid.FixedRows  := 1;

  StringGrid.Cells[0,0] := 'Título';
  StringGrid.Cells[1,0] := 'Máscara';
  StringGrid.Cells[2,0] := 'Tamanho';
  StringGrid.Cells[3,0] := 'Nome da Coluna';

  if Lista_Parametros.Count = 0 then
  begin
    StringGrid.Cells[0,1] := '';
    StringGrid.Cells[1,1] := '';
    StringGrid.Cells[2,1] := '';
    StringGrid.Cells[3,1] := '';
  end;
  Lista := TStringList.Create;
  try
    P := 0;
    for I:=0 to Lista_P.Count-1 do
    begin
      StringToArray(Lista_P[I], ';', lista);
      if Lista.Count = 4 then
      begin
        inc(P);
        StringGrid.Cells[0,P] := Lista[0];
        StringGrid.Cells[1,P] := Lista[1];
        StringGrid.Cells[2,P] := Lista[2];
        StringGrid.Cells[3,P] := Lista[3];
      end;
    end;
  finally
    Lista.Free;
  end;
end;

procedure TFormTitulos.FormShow(Sender: TObject);
var
  I: Integer;
begin
  StringGrid.DefaultRowHeight := ComboBox.Height;
  Atualiza_Lista(Lista_Parametros);
  StringGrid.SetFocus;
end;

procedure TFormTitulos.BtnIncluirClick(Sender: TObject);
begin
  Lista_Parametros.Add('Título...;;;');
  Atualiza_Lista(Lista_Parametros);
  StringGrid.Row := StringGrid.RowCount-1;
  StringGrid.Col := 0;
  StringGrid.SetFocus;
end;

procedure TFormTitulos.FormDestroy(Sender: TObject);
begin
  Lista_Parametros.Free;
end;

procedure TFormTitulos.StringGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var
  I: Integer;
begin
  Lista_Parametros[ARow-1] := TrocaString(StringGrid.Cells[0,ARow], ';', '', [rfReplaceAll]) + ';' +
                              TrocaString(StringGrid.Cells[1,ARow], ';', '', [rfReplaceAll]) + ';' +
                              IntToStr(StrToIntDef(StringGrid.Cells[2,ARow], 0)) + ';' +
                              TrocaString(StringGrid.Cells[3,ARow], ';', '', [rfReplaceAll]);
end;

procedure TFormTitulos.BtnExcluirClick(Sender: TObject);
begin
  if (StringGrid.Row = 0) or (Lista_Parametros.Count = 0) then
  begin
    Mensagem('Selecione o Título para exclusão!', modInformacao, [modOk]);
    StringGrid.SetFocus;
    exit;
  end;
  if Mensagem('Excluir Título?' + ^M + ^M + StringGrid.Cells[0, StringGrid.Row], modConfirmacao, [modSim, modNao]) = mrYes then
  begin
    Lista_Parametros.Delete(StringGrid.Row-1);
    if Lista_Parametros.Count = 0 then
      StringGrid.RowCount := 1;
    Atualiza_Lista(Lista_Parametros);
    StringGrid.SetFocus;
  end;
end;

procedure TFormTitulos.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  Rect: TRect;
begin
  if ACol = 1 then
  begin
    Rect := StringGrid.CellRect(ACol, ARow);
    ComboBox.Left    := StringGrid.Left + Rect.Left+2;
    ComboBox.Top     := StringGrid.Top + Rect.Top+2;
    ComboBox.Width   := Rect.Right - Rect.Left;
    ComboBox.Height  := Rect.Bottom - Rect.Top;
    ComboBox.Visible := True;
    ComboBox.ItemIndex := ComboBox.Items.IndexOf(StringGrid.Cells[ACol, ARow]);
  end
  else
    ComboBox.Visible := False;
  CanSelect := True;
end;

procedure TFormTitulos.ComboBoxChange(Sender: TObject);
begin
  StringGrid.Cells[StringGrid.Col, StringGrid.Row] := ComboBox.Text;
  Lista_Parametros[StringGrid.Row-1] := TrocaString(StringGrid.Cells[0,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                              TrocaString(StringGrid.Cells[1,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                              IntToStr(StrToIntDef(StringGrid.Cells[2,StringGrid.Row], 0)) + ';' +
                              TrocaString(StringGrid.Cells[3,StringGrid.Row], ';', '', [rfReplaceAll]);
end;

procedure TFormTitulos.FormCreate(Sender: TObject);
begin
  Lista_Parametros := TStringList.Create;
end;

procedure TFormTitulos.BtnAcimaClick(Sender: TObject);
var
  Titulo_i, Mascara_i, Tamanho_i, Coluna_i: String;
begin
  if StringGrid.Row > 1 then
  begin
    Titulo_i  := StringGrid.Cells[0, StringGrid.Row-1];
    Mascara_i := StringGrid.Cells[1, StringGrid.Row-1];
    Tamanho_i := StringGrid.Cells[2, StringGrid.Row-1];
    Coluna_i  := StringGrid.Cells[3, StringGrid.Row-1];

    StringGrid.Cells[0, StringGrid.Row-1] := StringGrid.Cells[0, StringGrid.Row];
    StringGrid.Cells[1, StringGrid.Row-1] := StringGrid.Cells[1, StringGrid.Row];
    StringGrid.Cells[2, StringGrid.Row-1] := StringGrid.Cells[2, StringGrid.Row];
    StringGrid.Cells[3, StringGrid.Row-1] := StringGrid.Cells[3, StringGrid.Row];
    StringGridSetEditText(Sender, 0, StringGrid.Row-1, '');

    StringGrid.Cells[0, StringGrid.Row] := Titulo_i;
    StringGrid.Cells[1, StringGrid.Row] := Mascara_i;
    StringGrid.Cells[2, StringGrid.Row] := Tamanho_i;
    StringGrid.Cells[3, StringGrid.Row] := Coluna_i;
    StringGridSetEditText(Sender, 0, StringGrid.Row, '');

    StringGrid.Row := StringGrid.Row - 1;
  end;
end;

procedure TFormTitulos.BtnAbaixoClick(Sender: TObject);
var
  Titulo_i, Mascara_i, Tamanho_i, Coluna_i: String;
begin
  if StringGrid.Row + 1 <= StringGrid.RowCount-1 then
  begin
    Titulo_i  := StringGrid.Cells[0, StringGrid.Row+1];
    Mascara_i := StringGrid.Cells[1, StringGrid.Row+1];
    Tamanho_i := StringGrid.Cells[2, StringGrid.Row+1];
    Coluna_i  := StringGrid.Cells[3, StringGrid.Row+1];

    StringGrid.Cells[0, StringGrid.Row+1] := StringGrid.Cells[0, StringGrid.Row];
    StringGrid.Cells[1, StringGrid.Row+1] := StringGrid.Cells[1, StringGrid.Row];
    StringGrid.Cells[2, StringGrid.Row+1] := StringGrid.Cells[2, StringGrid.Row];
    StringGrid.Cells[3, StringGrid.Row+1] := StringGrid.Cells[3, StringGrid.Row];
    StringGridSetEditText(Sender, 0, StringGrid.Row+1, '');

    StringGrid.Cells[0, StringGrid.Row] := Titulo_i;
    StringGrid.Cells[1, StringGrid.Row] := Mascara_i;
    StringGrid.Cells[2, StringGrid.Row] := Tamanho_i;
    StringGrid.Cells[3, StringGrid.Row] := Coluna_i;
    StringGridSetEditText(Sender, 0, StringGrid.Row, '');

    StringGrid.Row := StringGrid.Row + 1;
  end;
end;

procedure TFormTitulos.BtnAutoClick(Sender: TObject);
var
  I: Integer;
  Lista: TStringList;
  Valor: String;
begin
  if Mensagem('Executar Consulta e Identificar Colunas?', modConfirmacao, [modSim, modNao]) <> mrYes then
    exit;
  if Trim(TabGlobal_i.DCONSULTA.SQL_I.Conteudo.Text) = '' then
  begin
    Mensagem('Expressão SQL não gerada!', modAdvertencia, [modOk]);
    exit;
  end;
  try
    TabGlobal_i.DBDADOS.First;
    if not TabGlobal_i.DBDADOS.Locate('NUMERO', TabGlobal_i.DCONSULTA.BASE.Conteudo, []) then
    begin
      Mensagem('Banco de dados não definido na consulta!', modAdvertencia, [modOk]);
      exit;
    end
    else
    begin
      SDQuery.Active       := False;
      SDDatabase.Connected := False;
      if Trim(TabGlobal_i.DBDADOS.HOST_NAME.Conteudo) <> '' then
        SDDatabase.RemoteDatabase := TabGlobal_i.DBDADOS.HOST_NAME.Conteudo + ':' + TabGlobal_i.DBDADOS.ARQUIVO.Conteudo
      else
        SDDatabase.RemoteDatabase := TabGlobal_i.DBDADOS.ARQUIVO.Conteudo;
      case TabGlobal_i.DBDADOS.BDADOS.Conteudo of
        1: begin
             SDDatabase.ServerType := stInterbase;
             if Pos('.', SDDatabase.RemoteDatabase) < 1 then
               SDDatabase.RemoteDatabase := SDDatabase.RemoteDatabase + '.gdb';
           end;
        2: begin
             SDDatabase.ServerType := stFirebird;
             if Pos('.', SDDatabase.RemoteDatabase) < 1 then
               SDDatabase.RemoteDatabase := SDDatabase.RemoteDatabase + '.gdb';
           end;
        3: SDDatabase.ServerType := stSQLBase;
        4: SDDatabase.ServerType := stOracle;
        5: SDDatabase.ServerType := stSQLServer;
        6: SDDatabase.ServerType := stSybase;
        7: SDDatabase.ServerType := stDB2;
        8: SDDatabase.ServerType := stInformix;
        9: SDDatabase.ServerType := stODBC;
        10: SDDatabase.ServerType := stMySQL;
        11: SDDatabase.ServerType := stPostgreSQL;
        12: SDDatabase.ServerType := stOLEDB;
      end;
      SDDatabase.Params.Clear;
      SDDatabase.Params.Add('USER NAME='+TabGlobal_i.DBDADOS.USUARIO.Conteudo);
      SDDatabase.Params.Add('PASSWORD='+TabGlobal_i.DBDADOS.SENHA.Conteudo);
      if TabGlobal_i.DBDADOS.BDADOS.Conteudo < 3 then
        SDDatabase.Params.Add('SQL DIALECT=3');
      SDDatabase.LoginPrompt := False;
      SDDatabase.Connected := True;
      if SDDatabase.Connected then
      begin
        SDQuery.SQL.Text := TabGlobal_i.DCONSULTA.SQL_I.Conteudo.Text;
        Lista := TStringList.Create;
        for I:=0 to TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo.Count -1 do
        begin
          if Pos(';', TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I]) > 0 then
          begin
            StringToArray(TabGlobal_i.DCONSULTA.PARAMETROS.Conteudo[I], ';', lista);
            if Trim(Lista[0]) <> '' then
            begin
              if SDQuery.Params.FindParam(Lista[0]) <> Nil then
              begin
                SDQuery.Params.FindParam(Lista[0]).DataType := R_DataType(Lista[1]);
                InputQuery(Lista[0], 'Informe o valor ' + Lista[0], Valor);
                if Trim(Valor) <> '' then
                  SDQuery.Params.FindParam(Lista[0]).Value := Valor;
              end;
            end;
          end;
        end;
        SDQuery.Prepare;
        SDQuery.Open;
        Lista_Parametros.Clear;
        for I:=0 to SDQuery.FieldCount-1 do
          Lista_Parametros.Add(SDQuery.Fields[I].FieldName + ';;' + IntToStr(SDQuery.Fields[I].Size) + ';' + SDQuery.Fields[I].FieldName);
        SDQuery.Close;
        Atualiza_Lista(Lista_Parametros);
        StringGrid.SetFocus;
      end;
    end;
  except
    on Erro: Exception do
    begin
      Screen.Cursor := crDefault;
      Mensagem('Erro de conexão: '+Erro.Message, modErro, [modOk]);
    end;
  end;
end;

end.

