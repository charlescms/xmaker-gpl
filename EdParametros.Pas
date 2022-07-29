unit EdParametros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Grids, Buttons, ComCtrls;

type
  TFormParametros = class(TForm)
    BtnOk: TButton;
    BtnFechar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    StringGrid: TStringGrid;
    BtnIncluir: TBitBtn;
    BtnExcluir: TBitBtn;
    ComboBox: TComboBox;
    CheckBox: TCheckBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure BtnExcluirClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure AlinharCheck;
    procedure Limparbuffer;
    procedure Atualiza_Lista(Lista_P: TStringList);
  public
    { Public declarations }
    Lista_Parametros: TStringList;
    Tabela: Boolean;
  end;

var
  FormParametros: TFormParametros;

implementation

uses Rotinas;

{$R *.DFM}

procedure TFormParametros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    {Atua como a tecla TAB}
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormParametros.BtnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormParametros.AlinharCheck;
var
  CheckBox_E, CheckBox_S: TCheckBox;
  Rect: TRect;
  i: Integer;
begin
  for i := 1 to StringGrid.RowCount do
    begin
       CheckBox_E := (StringGrid.Objects[1,i] as TCheckBox);
       if CheckBox_E <> nil then
       begin
         Rect := StringGrid.CellRect(1,i);
         CheckBox_E.Left    := StringGrid.Left + Rect.Left+2;
         CheckBox_E.Top     := StringGrid.Top + Rect.Top+2;
         CheckBox_E.Width   := Rect.Right - Rect.Left;
         CheckBox_E.Height  := Rect.Bottom - Rect.Top;
         CheckBox_E.Visible := True;
       end;

       CheckBox_S := (StringGrid.Objects[2,i] as TCheckBox);
       if CheckBox_s <> nil then
       begin
         Rect := StringGrid.CellRect(2,i);
         CheckBox_S.Left    := StringGrid.Left + Rect.Left+2;
         CheckBox_S.Top     := StringGrid.Top + Rect.Top+2;
         CheckBox_S.Width   := Rect.Right - Rect.Left;
         CheckBox_S.Height  := Rect.Bottom - Rect.Top;
         CheckBox_S.Visible := True;
       end;
     end;
end;

procedure TFormParametros.Limparbuffer;
var
  CheckBox_E, CheckBox_S: TCheckBox;
  i: Integer;
begin
  for i := 1 to StringGrid.RowCount do
  begin
    CheckBox_E := (StringGrid.Objects[1,i] as TCheckBox);
    if CheckBox_E <> nil then // o objeto deve existir para poder ser destruído
    begin
      StringGrid.Objects[1,i] := nil;
      CheckBox_E.Free;
    end;

    CheckBox_S := (StringGrid.Objects[2,i] as TCheckBox);
    if CheckBox_S <> nil then // o objeto deve existir para poder ser destruído
    begin
      StringGrid.Objects[2,i] := nil;
      CheckBox_S.Free;
    end;
  end;
end;

procedure TFormParametros.Atualiza_Lista(Lista_P: TStringList);
var
  I, P: Integer;
  Lista: TStringList;
  CheckBox_E, CheckBox_S: TCheckBox;
begin
  //LimparBuffer;
  StringGrid.RowCount   := Lista_P.Count+1;
  if StringGrid.RowCount = 1 then
  begin
    StringGrid.RowCount := 2;
    StringGrid.Options  := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect];
  end
  else
    StringGrid.Options  := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goEditing];
  StringGrid.FixedRows  := 1;

  if Tabela then
  begin
    StringGrid.ColCount   := 2;
    StringGrid.Cells[0,0] := 'Parâmetro';
    StringGrid.Cells[1,0] := 'Tipo';

    StringGrid.ColWidths[1] := 120;

    if Lista_Parametros.Count = 0 then
    begin
      StringGrid.Cells[0,1] := '';
      StringGrid.Cells[1,1] := '';
    end;
  end
  else
  begin
    StringGrid.Cells[0,0] := 'Parâmetro';
    StringGrid.Cells[1,0] := 'Entrada';
    StringGrid.Cells[2,0] := 'Saída';
    StringGrid.Cells[3,0] := 'Tipo';
    StringGrid.Cells[4,0] := 'Tamanho';
    StringGrid.Cells[5,0] := 'Decimais';

    if Lista_Parametros.Count = 0 then
    begin
      StringGrid.Cells[0,1] := '';
      StringGrid.Cells[1,1] := '';
      StringGrid.Cells[2,1] := '';
      StringGrid.Cells[3,1] := '';
      StringGrid.Cells[4,1] := '';
      StringGrid.Cells[5,1] := '';
    end;
  end;
  Lista := TStringList.Create;
  try
    P := 0;
    for I:=0 to Lista_P.Count-1 do
    begin
      StringToArray(Lista_P[I], ';', lista);
      if Lista.Count = 6 then
      begin
        inc(P);
        if not Tabela then
        begin
          CheckBox_E          := TCheckBox.Create(Application);
          CheckBox_E.ParentColor := False;
          CheckBox_E.Width    := 0;
          CheckBox_E.Visible  := false;
          CheckBox_E.Caption  := 'Sim';
          CheckBox_E.Color    := clWindow;
          CheckBox_E.Parent   := Self;
          CheckBox_E.Checked  := IIF(Lista[1]='1', True, False);
          CheckBox_E.Tag      := 100 + P;
          CheckBox_E.OnClick  := CheckBoxClick;

          CheckBox_S          := TCheckBox.Create(Application);
          CheckBox_S.ParentColor := False;
          CheckBox_S.Width    := 0;
          CheckBox_S.Visible  := false;
          CheckBox_S.Caption  := 'Sim';
          CheckBox_S.Color    := clWindow;
          CheckBox_S.Parent   := Self;
          CheckBox_S.Checked  := IIF(Lista[2]='1', True, False);
          CheckBox_S.Tag      := 200 + P;
          CheckBox_S.OnClick  := CheckBoxClick;
        end;

        if Tabela then
        begin
          StringGrid.Cells[0,P]   := Lista[0];
          StringGrid.Cells[1,P]   := Lista[1];
        end
        else
        begin
          StringGrid.Cells[0,P]   := Lista[0];
          StringGrid.Objects[1,P] := CheckBox_E;
          StringGrid.Objects[2,P] := CheckBox_S;
          StringGrid.Cells[1,P]   := Lista[1];
          StringGrid.Cells[2,P]   := Lista[2];
          StringGrid.Cells[3,P]   := Lista[3];
          StringGrid.Cells[4,P]   := Lista[4];
          StringGrid.Cells[5,P]   := Lista[5];
        end;
      end;
    end;
  finally
    Lista.Free;
    //AlinharCheck;
  end;
end;

procedure TFormParametros.FormShow(Sender: TObject);
var
  I: Integer;
begin
  StringGrid.DefaultRowHeight := ComboBox.Height;
  if Tabela then
    for I:=7 to Length(Tipos_Suportados) do
      ComboBox.Items.Add(Tipos_Suportados[I])
  else
    for I:=2 to Length(Tipos_Campo_Suportados) do
      ComboBox.Items.Add(Tipos_Campo_Suportados[I]);
  Atualiza_Lista(Lista_Parametros);
  StringGrid.SetFocus;
end;

procedure TFormParametros.StringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  //if not (gdFixed in State) then
  //  AlinharCheck;
end;

procedure TFormParametros.BtnIncluirClick(Sender: TObject);
begin
  if Tabela then
    Lista_Parametros.Add('Novo_Parametro;ftString;;;;')
  else
    Lista_Parametros.Add('Novo_Parametro;Sim;Não;Integer;0;0');
  Atualiza_Lista(Lista_Parametros);
  StringGrid.Row := StringGrid.RowCount-1;
  StringGrid.Col := 0;
  StringGrid.SetFocus;
end;

procedure TFormParametros.FormDestroy(Sender: TObject);
begin
  Lista_Parametros.Free;
end;

procedure TFormParametros.StringGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var
  I: Integer;
begin
  if Tabela then
    Lista_Parametros[ARow-1] := TrocaString(StringGrid.Cells[0,ARow], ';', '', [rfReplaceAll]) + ';' +
                                TrocaString(StringGrid.Cells[1,ARow], ';', '', [rfReplaceAll]) + ';' +
                                ';' +
                                ';' +
                                ';'
  else
    Lista_Parametros[ARow-1] := TrocaString(StringGrid.Cells[0,ARow], ';', '', [rfReplaceAll]) + ';' +
                                TrocaString(StringGrid.Cells[1,ARow], ';', '', [rfReplaceAll]) + ';' +
                                TrocaString(StringGrid.Cells[2,ARow], ';', '', [rfReplaceAll]) + ';' +
                                TrocaString(StringGrid.Cells[3,ARow], ';', '', [rfReplaceAll]) + ';' +
                                IntToStr(StrToIntDef(StringGrid.Cells[4,ARow], 0)) + ';' +
                                IntToStr(StrToIntDef(StringGrid.Cells[5,ARow], 0));
end;

procedure TFormParametros.BtnExcluirClick(Sender: TObject);
begin
  if (StringGrid.Row = 0) or (Lista_Parametros.Count = 0) then
  begin
    Mensagem('Selecione o parâmetro para exclusão!', modInformacao, [modOk]);
    StringGrid.SetFocus;
    exit;
  end;
  if Mensagem('Excluir Parâmetro?' + ^M + ^M + StringGrid.Cells[0, StringGrid.Row], modConfirmacao, [modSim, modNao]) = mrYes then
  begin
    Lista_Parametros.Delete(StringGrid.Row-1);
    if Lista_Parametros.Count = 0 then
      StringGrid.RowCount := 1;
    Atualiza_Lista(Lista_Parametros);
    StringGrid.SetFocus;
  end;
end;

procedure TFormParametros.CheckBoxClick(Sender: TObject);
begin
  if (CheckBox.Caption = 'Sim') and (CheckBox.Checked) then
    StringGrid.Cells[CheckBox.Tag, StringGrid.Row] := 'Sim'
  else if (CheckBox.Caption = 'Sim') and (not CheckBox.Checked) then
    StringGrid.Cells[CheckBox.Tag, StringGrid.Row] := 'Não'
  else if (CheckBox.Caption <> 'Sim') and (CheckBox.Checked) then
    StringGrid.Cells[CheckBox.Tag, StringGrid.Row] := 'Não'
  else if (CheckBox.Caption <> 'Sim') and (not CheckBox.Checked) then
    StringGrid.Cells[CheckBox.Tag, StringGrid.Row] := 'Sim';
  Lista_Parametros[StringGrid.Row-1] := TrocaString(StringGrid.Cells[0,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                        TrocaString(StringGrid.Cells[1,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                        TrocaString(StringGrid.Cells[2,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                        TrocaString(StringGrid.Cells[3,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                        IntToStr(StrToIntDef(StringGrid.Cells[4,StringGrid.Row], 0)) + ';' +
                                        IntToStr(StrToIntDef(StringGrid.Cells[5,StringGrid.Row], 0));
end;

procedure TFormParametros.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  Rect: TRect;
begin
  if ACol = IIF(Tabela, 1, 3) then
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
  if (not Tabela) and ((ACol = 1) or (ACol = 2)) then
  begin
    Rect := StringGrid.CellRect(ACol, ARow);
    CheckBox.OnClick := Nil;
    CheckBox.Color   := clWindow;
    CheckBox.Left    := StringGrid.Left + Rect.Left+2;
    CheckBox.Top     := StringGrid.Top + Rect.Top+2;
    CheckBox.Width   := Rect.Right - Rect.Left;
    CheckBox.Height  := Rect.Bottom - Rect.Top;
    CheckBox.Visible := True;
    CheckBox.Checked := True;
    CheckBox.Tag     := ACol;
    if LowerCase(StringGrid.Cells[ACol, ARow]) = 'sim' then
      CheckBox.Caption := 'Sim'
    else
      CheckBox.Caption := 'Não';
    CheckBox.OnClick := CheckBoxClick;
  end
  else
    CheckBox.Visible := False;
  CanSelect := True;
end;

procedure TFormParametros.ComboBoxChange(Sender: TObject);
begin
  StringGrid.Cells[StringGrid.Col, StringGrid.Row] := ComboBox.Text;
  if Tabela then
    Lista_Parametros[StringGrid.Row-1] := TrocaString(StringGrid.Cells[0,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                          TrocaString(StringGrid.Cells[1,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                          ';' +
                                          ';' +
                                          ';'
  else
    Lista_Parametros[StringGrid.Row-1] := TrocaString(StringGrid.Cells[0,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                          TrocaString(StringGrid.Cells[1,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                          TrocaString(StringGrid.Cells[2,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                          TrocaString(StringGrid.Cells[3,StringGrid.Row], ';', '', [rfReplaceAll]) + ';' +
                                          IntToStr(StrToIntDef(StringGrid.Cells[4,StringGrid.Row], 0)) + ';' +
                                          IntToStr(StrToIntDef(StringGrid.Cells[5,StringGrid.Row], 0));
end;

procedure TFormParametros.FormCreate(Sender: TObject);
begin
  Lista_Parametros := TStringList.Create;
end;

end.

