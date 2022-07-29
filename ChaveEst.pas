unit ChaveEst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Mask, ToolEdit, DB, ComCtrls, Variants;

type
  TFormChaveEst = class(TForm)
    BtnOk: TButton;
    BtnFechar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnMoveParaCima: TSpeedButton;
    BtnMoveParaBaixo: TSpeedButton;
    Label7: TLabel;
    BtnInserirCmp: TSpeedButton;
    BtnExcluirCmp: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EdTabela: TEdit;
    ComboTab: TComboBox;
    CamposEdTabela: TListBox;
    CamposComboTab: TListBox;
    CamposRelacionados: TListBox;
    BtnInserir: TBitBtn;
    CamposMostrados: TListBox;
    CamposOrigem: TListBox;
    EdEstilo: TComboBox;
    EdFiltroMestre: TComboEdit;
    EdAcao: TComboBox;
    procedure BtnInserirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComboTabExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnMoveParaBaixoClick(Sender: TObject);
    procedure BtnMoveParaCimaClick(Sender: TObject);
    procedure BtnInserirCmpClick(Sender: TObject);
    procedure BtnExcluirCmpClick(Sender: TObject);
    procedure EdFiltroMestreButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdEstiloChange(Sender: TObject);
  private
    { Private declarations }
    ListaNrTab: TStringList;
    IndiceTab: Integer;
  public
    { Public declarations }
    Tab_Estrangeira, Campo_Chave, Campos_Visuais: String;
    Filtro_Mestre: TStringList;
  end;

var
  FormChaveEst: TFormChaveEst;

implementation

uses Princ, Rotinas, Abertura, Tabela, EdFiltro;

{$R *.DFM}

procedure TFormChaveEst.FormShow(Sender: TObject);
var
  qy_Tabela: TTabela;
  Lst_Array: TStringList;
  I, P: Integer;
begin
  ListaNrTab := TStringList.Create;
  ComboTab.Items.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DTABELAS.DataBase;
    Transaction := TabGlobal_i.DTABELAS.Transaction;
    Sql.Text := 'Select Numero, Nome, Titulo_T From Tabelas Order By Nome';
    Abrir;
    First;
    while not Eof do
    begin
      if Trim(Fields[1].AsString) <> '' then
      begin
        ComboTab.Items.AddObject(Fields[1].AsString, TObject(0)); //+ ' - ' + Fields[2].AsString);
        ListaNrTab.AddObject(IntToStr(Fields[0].AsInteger), TObject(0));
      end;
      Next;
    end;
    Close;

    Sql.Text := 'Select Numero, ''CS'' || Nome, Titulo_I From Consulta Order By Nome';
    Abrir;
    First;
    while not Eof do
    begin
      if Trim(Fields[1].AsString) <> '' then
      begin
        ComboTab.Items.AddObject(Fields[1].AsString, TObject(1)); //+ ' - ' + Fields[2].AsString);
        ListaNrTab.AddObject(IntToStr(Fields[0].AsInteger), TObject(1));
      end;
      Next;
    end;
    Close;

    Free;
  end;
  ComboTab.ItemIndex := ComboTab.Items.IndexOf(Tab_Estrangeira);
  IndiceTab := -1;
  if ComboTab.ItemIndex > -1 then
  begin
    ComboTabExit(Self);
    CamposRelacionados.Items.Text := Campo_Chave;
  end;
  IndiceTab := ComboTab.ItemIndex;
  Lst_Array := TStringList.Create;
  StringToArray(Campos_Visuais,',',Lst_Array);
  CamposMostrados.Items.Clear;
  for I:=0 to Lst_Array.Count-1 do
  begin
    CamposMostrados.Items.Add(Lst_Array[I]);
    P := CamposOrigem.Items.IndexOf(Lst_Array[I]);
    if P > -1 then
      CamposOrigem.Items.Delete(P);
  end;
  Lst_Array.Free;
  ComboTab.SetFocus;
end;

procedure TFormChaveEst.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ListaNrTab.Free;
end;

procedure TFormChaveEst.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormChaveEst.BtnInserirClick(Sender: TObject);
begin
  CamposRelacionados.Items.Text := CamposComboTab.Items[CamposComboTab.ItemIndex];
end;

procedure TFormChaveEst.ComboTabExit(Sender: TObject);
Var
  qy_Tabela: TTabela;
  DadoInt, lista: TStringList;
  I: Integer;
begin
  if ComboTab.ItemIndex = IndiceTab then exit;
  CamposComboTab.Items.Clear;
  CamposRelacionados.Items.Clear;
  CamposMostrados.Items.Clear;
  if ComboTab.Text = '' then
    exit;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DCAMPOST.DataBase;
    Transaction := TabGlobal_i.DCAMPOST.Transaction;
    if Integer(ListaNrTab.Objects[ComboTab.ItemIndex]) = 0 then
    begin
      CamposMostrados.Enabled := True;
      CamposOrigem.Enabled    := True;
      BtnInserirCmp.Enabled   := True;
      BtnExcluirCmp.Enabled   := True;
      BtnMoveParaCima.Enabled := True;
      BtnMoveParaBaixo.Enabled:= True;
      EdEstilo.Enabled        := True;
      EdAcao.Enabled          := True;
      EdFiltroMestre.Enabled  := True;
      Sql.Text := 'Select Nome, Nome_Fisico From CamposT Where Numero = '+ListaNrTab[ComboTab.ItemIndex]+' Order By Sequencia';
      Abrir;
      First;
      while not Eof do
      begin
        if Trim(Fields[0].AsString) <> '' then
          CamposComboTab.Items.Add(IIF(Trim(Fields[1].AsString)<>'', Trim(Fields[1].AsString), Trim(Fields[0].AsString)));
        Next;
      end;
    end
    else
    begin
      CamposMostrados.Items.Clear;
      CamposMostrados.Enabled := False;
      CamposOrigem.Enabled    := False;
      BtnInserirCmp.Enabled   := False;
      BtnExcluirCmp.Enabled   := False;
      BtnMoveParaCima.Enabled := False;
      BtnMoveParaBaixo.Enabled:= False;
      EdEstilo.ItemIndex      := 1;
      EdEstilo.Enabled        := False;
      EdAcao.Enabled          := False;
      EdFiltroMestre.Text     := '';
      EdFiltroMestre.Enabled  := False;
      Sql.Text := 'Select Titulos From Consulta Where Numero = '+ListaNrTab[ComboTab.ItemIndex];
      Abrir;
      First;
      Lista := TStringList.Create;
      DadoInt := TStringList.Create;
      DadoInt.Assign(TMemoField(Fields[0]));
      for I:=0 to DadoInt.Count-1 do
      begin
        StringToArray(DadoInt[I], ';', Lista);
        CamposComboTab.Items.Add(Lista[3]);
      end;
      DadoInt.Free;
      Lista.Free;
    end;
    Close;
    Free;
  end;
  CamposEdTabela.ItemIndex := 0;
  CamposComboTab.ItemIndex := 0;
  CamposOrigem.Items.Clear;
  CamposOrigem.Items.AddStrings(CamposComboTab.Items);
  IndiceTab := ComboTab.ItemIndex;
end;

procedure TFormChaveEst.BtnOkClick(Sender: TObject);
Var
  I: Integer;
begin
  if CamposRelacionados.Items.Count < 1 then
  begin
    Mensagem('Campo(s) não associados !',ModAdvertencia,[modOk]);
    CamposComboTab.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  if (CamposMostrados.Enabled) and (CamposMostrados.Items.Count < 1) then
  begin
    Mensagem('Selecione os campos a serem mostrados !',ModAdvertencia,[modOk]);
    CamposMostrados.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  if EdEstilo.ItemIndex < 0 then
  begin
    Mensagem('Selecione o estilo de pesquisa !',ModAdvertencia,[modOk]);
    EdEstilo.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TFormChaveEst.BtnMoveParaBaixoClick(Sender: TObject);
Var Atual,Proximo: String;
begin
  if CamposMostrados.ItemIndex > -1 then
  begin
    Atual := CamposMostrados.Items[CamposMostrados.ItemIndex];
    if CamposMostrados.ItemIndex + 1 <= CamposMostrados.Items.Count-1 then
    begin
      Proximo := CamposMostrados.Items[CamposMostrados.ItemIndex + 1];
      CamposMostrados.Items[CamposMostrados.ItemIndex]   := Proximo;
      CamposMostrados.Items[CamposMostrados.ItemIndex+1] := Atual;
      CamposMostrados.ItemIndex := CamposMostrados.ItemIndex + 1;
      CamposMostrados.Selected[CamposMostrados.ItemIndex] := True;
      CamposMostrados.SetFocus;
    end;
  end;
end;

procedure TFormChaveEst.BtnMoveParaCimaClick(Sender: TObject);
Var Atual,Proximo: String;
begin
  if CamposMostrados.ItemIndex > -1 then
  begin
    Atual := CamposMostrados.Items[CamposMostrados.ItemIndex];
    if CamposMostrados.ItemIndex - 1 >= 0 then
    begin
      Proximo := CamposMostrados.Items[CamposMostrados.ItemIndex - 1];
      CamposMostrados.Items[CamposMostrados.ItemIndex]   := Proximo;
      CamposMostrados.Items[CamposMostrados.ItemIndex-1] := Atual;
      CamposMostrados.ItemIndex := CamposMostrados.ItemIndex - 1;
      CamposMostrados.Selected[CamposMostrados.ItemIndex] := True;
      CamposMostrados.SetFocus;
    end;
  end;
end;

procedure TFormChaveEst.BtnInserirCmpClick(Sender: TObject);
var
 I, P, Y: Integer;
begin
  Y := CamposOrigem.ItemIndex;
  for I:=0 to CamposOrigem.Items.Count -1 do
    if CamposOrigem.Selected[I] then
      if CamposMostrados.Items.IndexOf(CamposOrigem.Items[I]) < 0 then
        CamposMostrados.Items.Add(CamposOrigem.Items[I]);
  P := 0;
  while P > -1 do
  begin
    P := -1;
    for I:=0 to CamposOrigem.Items.Count -1 do
      if CamposOrigem.Selected[I] then
      begin
        P := I;
        Break;
      end;
    if P > -1 then
      CamposOrigem.Items.Delete(P);
  end;
  if Y < CamposOrigem.Items.Count then
    CamposOrigem.ItemIndex := Y
  else
    if CamposOrigem.Items.Count > 0 then
      CamposOrigem.ItemIndex := 0
    else
      CamposOrigem.ItemIndex := -1;
  if CamposOrigem.ItemIndex > -1 then
    CamposOrigem.Selected[CamposOrigem.ItemIndex] := True;
end;

procedure TFormChaveEst.BtnExcluirCmpClick(Sender: TObject);
var
 I, P, Y: Integer;
begin
  Y := CamposMostrados.ItemIndex;
  for I:=0 to CamposMostrados.Items.Count -1 do
    if CamposMostrados.Selected[I] then
      if CamposOrigem.Items.IndexOf(CamposMostrados.Items[I]) < 0 then
        CamposOrigem.Items.Add(CamposMostrados.Items[I]);
  P := 0;
  while P > -1 do
  begin
    P := -1;
    for I:=0 to CamposMostrados.Items.Count -1 do
      if CamposMostrados.Selected[I] then
      begin
        P := I;
        Break;
      end;
    if P > -1 then
      CamposMostrados.Items.Delete(P);
  end;
  if Y < CamposMostrados.Items.Count then
    CamposMostrados.ItemIndex := Y
  else
    if CamposMostrados.Items.Count > 0 then
      CamposMostrados.ItemIndex := 0
    else
      CamposMostrados.ItemIndex := -1;  
  if CamposMostrados.ItemIndex > -1 then
    CamposMostrados.Selected[CamposMostrados.ItemIndex] := True;
end;

procedure TFormChaveEst.EdFiltroMestreButtonClick(Sender: TObject);
var
  FormFiltro: TFormFiltro;
  Resultado: Variant;
begin
  if EdFiltroMestre.ReadOnly then exit;
  FormFiltro := TFormFiltro.Create(Application);
  Try
    FormFiltro.ExprMemo.Lines.Clear;
    FormFiltro.ExprMemo.Lines.AddStrings(FILTRO_MESTRE);
    FormFiltro.TabNome := ComboTab.Text;
    PTabela(TabGlobal_i.DTABELAS,['NOME'],[FormFiltro.TabNome],['NUMERO'],Resultado);
    if Resultado[0] <> Null then
      FormFiltro.TabFiltro := Resultado[0];
    if FormFiltro.ShowModal = mrOk then
    begin
      Filtro_Mestre.Clear;
      Filtro_Mestre.AddStrings(FormFiltro.ExprMemo.Lines);
      EdFiltroMestre.SetFocus;
      if Trim(FILTRO_MESTRE.Text) <> '' then
        EdFiltroMestre.Text := Trim(FILTRO_MESTRE.Text)
      else
        EdFiltroMestre.Text := '';
    end;
  Finally
    FormFiltro.Free;
  end;
end;

procedure TFormChaveEst.FormCreate(Sender: TObject);
begin
  Filtro_Mestre := TStringList.Create;
end;

procedure TFormChaveEst.FormDestroy(Sender: TObject);
begin
  Filtro_Mestre.Free;
end;

procedure TFormChaveEst.EdEstiloChange(Sender: TObject);
begin
  if EdEstilo.ItemIndex = 1 then
  begin
    if Trim(FILTRO_MESTRE.Text) <> '' then
      EdFiltroMestre.Text := Trim(FILTRO_MESTRE.Text)
    else
      EdFiltroMestre.Text := '';
    EdFiltroMestre.Color := clWindow;
    EdFiltroMestre.ReadOnly := False;
    EdAcao.Color := clWindow;
    //EdFiltroMestre.SetFocus;
  end
  else
  begin
    EdFiltroMestre.Text := '';
    EdFiltroMestre.Color := clBtnFace;
    EdFiltroMestre.ReadOnly := True;
    EdAcao.Color := clBtnFace;
    //BtnOk.SetFocus;
  end;
end;

end.
