unit EdFiltro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, SynEditHighlighter, SynHighlighterSQL,
  SynEdit, Mask, ToolEdit, SynCompletionProposal, SynEditTypes, ShellApi,
  ComCtrls;

type
  TFormFiltro = class(TForm)
    Panel1: TPanel;
    LbEspecial: TLabel;
    BtnScript: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    SynSQLSyn1: TSynSQLSyn;
    ListaFuncoes: TSynCompletionProposal;
    ListaParametros: TSynCompletionProposal;
    Label1: TLabel;
    ListaCampos: TListBox;
    ExprMemo: TSynEdit;
    SynSQLSyn2: TSynSQLSyn;
    SynCompletionProposal1: TSynCompletionProposal;
    SynCompletionProposal2: TSynCompletionProposal;
    Panel2: TPanel;
    Operacao: TRadioGroup;
    Label2: TLabel;
    EdExpressao: TComboBox;
    Composicao: TRadioGroup;
    EdNegacao: TCheckBox;
    BtnInserir: TBitBtn;
    BtnLimpar: TBitBtn;
    Image1: TImage;
    Panel3: TPanel;
    BtnOk: TBitBtn;
    BtnCancela: TBitBtn;
    BtnAjuda: TBitBtn;
    procedure ListaCamposDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListaParametrosCancelled(Sender: TObject);
    procedure ListaFuncoesCodeCompletion(var Value: String;
      Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure ExprMemoEnter(Sender: TObject);
    procedure ExprMemoExit(Sender: TObject);
    procedure ExprMemoKeyPress(Sender: TObject; var Key: Char);
    procedure ExprMemoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnScriptClick(Sender: TObject);
    procedure ExprMemoSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
  private
    { Private declarations }
    procedure Atribui_ListaFuncoes(Editor: TCustomSynEdit; Remover: Boolean = False);
  public
    { Public declarations }
    TabFiltro: Integer;
    TabNome: String;
    AceitaScript: Boolean;
  end;

var
  FormFiltro: TFormFiltro;

implementation

uses Abertura, Tabela, Rotinas, Relator;

{$R *.DFM}

procedure TFormFiltro.ListaCamposDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  Image: TImage;
  r: TRect;
begin
  r := ARect;
  r.Right := r.Left + 18;
  r.Bottom := r.Top + 16;
  OffsetRect(r, 2, 0);
  with TListBox(Control) do
  begin
    Canvas.FillRect(ARect);
    Image := Image1;
    Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormFiltro.FormShow(Sender: TObject);
var
  qy_Tabela: TTabela;
  Bloco: Boolean;
  Linha: String;
  I: Integer;
begin
  ListaCampos.Items.Clear;
  EdExpressao.Items.Clear;
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DCAMPOST.DataBase;
    Transaction := TabGlobal_i.DCAMPOST.Transaction;
    Sql.Text := 'Select Numero, Nome, Titulo_C, Sequencia, Tipo, Extra, Tab_Extra, Campo_Extra From CamposT Where Numero = '+IntToStr(TabFiltro)+' Order By Sequencia';
    Abrir;
    First;
    while not Eof do
    begin
      if (Trim(Fields[1].AsString) <> '') and (Fields[4].AsInteger < 5) then
      begin
        if Fields[5].AsInteger = 1 then
          ListaCampos.Items.AddObject(Fields[6].AsString + '.' + Fields[7].AsString,TObject(Fields[4].AsInteger))
        else
          ListaCampos.Items.AddObject(TabNome + '.' + Fields[1].AsString,TObject(Fields[4].AsInteger));
      end;
      Next;
    end;
    Close;
    Free;
  end;
  if FormRelatorio <> Nil then
  begin
    Bloco := False;
    for I := 0 to FormRelatorio.TextoPAS.Lines.Count-1 do
    begin
      Linha := FormRelatorio.TextoPAS.Lines[I];
      if Pos('{01-Início', Linha) > 0 then
        Bloco := True;
      if Pos('{99-Final', Linha) > 0 then
        Bloco := False;
      if Bloco then
      begin
        if (Copy(Trim(Linha),01,12) <> 'frDBDataSet_') and
           (Copy(Trim(Linha),01,10) <> '{01-Início') then
        begin
          Linha := Trim(Linha);
          Linha := Copy(Linha,01,Pos(':',Linha)-1);
          EdExpressao.Items.Add(':'+Linha);
        end;
      end;
    end;
  end;
  EdExpressao.Items.AddStrings(ListaCampos.Items);
  if ListaCampos.Items.Count > 0 then
    ListaCampos.ItemIndex := 0;
  Atribui_ListaFuncoes(ExprMemo);
  ListaCampos.SetFocus;
end;

procedure TFormFiltro.BtnLimparClick(Sender: TObject);
begin
  ExprMemo.Lines.Clear;
end;

procedure TFormFiltro.BtnInserirClick(Sender: TObject);
Var
  Oper, Delimit_E,Delimit_D, Separador_E, Negacao: String;
  FormatoData, Final: string;
  Data: TDateTime;
  Tipo: Integer;
  OutroCampo: Boolean;
begin
  if ListaCampos.ItemIndex < 0 then
  begin
    Mensagem('Campo não selecionado !',modAdvertencia,[modOk]);
    exit;
  end;
  Tipo := Integer(ListaCampos.Items.Objects[ListaCampos.ItemIndex]);
  if (Tipo <> 1) and (Operacao.ItemIndex = 6) then
  begin
    Mensagem('Operação ''Contém'' é somente válida para campos Alfanuméricos !',modErro,[modOk]);
    ListaCampos.SetFocus;
    exit;
  end;
  OutroCampo := EdExpressao.Items.IndexOf(EdExpressao.Text) > -1;
  Delimit_E := '';
  Delimit_D := '';
  Oper      := '';
  Negacao   := '';
  if (not OutroCampo) and ((Tipo = 1) or (Tipo = 4)) then
  begin
    Delimit_E := #39+'+#39+'+#39;//#39;
    if (Operacao.ItemIndex <= 1) and (Tipo = 1) then
    begin
      Oper        := ' LIKE ';
      Delimit_E   := #39+'+#39+'+#39;//#39;
      Delimit_D   := '%'+#39+'+#39+'+#39;//#39;
    end
    else
      Delimit_D := #39+'+#39+'+#39;//#39;
  end;
  if Operacao.ItemIndex = 0 then
  begin
    if Trim(Oper) = '' then
      Oper := ' = ';
  end
  else if Operacao.ItemIndex = 1 then
  begin
    if Trim(Oper) = '' then
      Oper := ' <> '
    else
      Negacao := 'Not ';
  end
  else if Operacao.ItemIndex = 2 then
    Oper := ' < '
  else if Operacao.ItemIndex = 3 then
    Oper := ' <= '
  else if Operacao.ItemIndex = 4 then
    Oper := ' > '
  else if Operacao.ItemIndex = 5 then
    Oper := ' >= '
  else if Operacao.ItemIndex = 6 then
  begin
    Oper        := ' LIKE ';
    Delimit_E   := #39+'+#39+'+#39+'%';//#39+'%';
    Delimit_D   := '%'+#39+'+#39+'+#39;//#39;
  end
  else if Operacao.ItemIndex = 7 then
  begin
    Oper             := ' IS NULL';
    Delimit_E        := '';
    Delimit_D        := '';
    EdExpressao.Text := '';
  end;
  if (not OutroCampo) and (Tipo = 4) and (Operacao.ItemIndex <> 7) then
  begin
    try
      FormatoData     := ShortDateFormat;
      ShortDateFormat := 'd/m/y';
      Data            := StrToDate(EdExpressao.Text);
      ShortDateFormat := FormatoData;
      EdExpressao.Text:= DataSql(Data);
    except
      on EConvertError do
      begin
         ShortDateFormat := FormatoData;
         Mensagem('Data inválida !', modErro, [modOk]);
         EdExpressao.SelectAll;
         EdExpressao.SetFocus;
         exit;
      end;
    end;
  end;
  if EdNegacao.Checked then
    Negacao := 'Not ' + Trim(Negacao);
  Separador_E := Negacao + '(';
  if Trim(ExprMemo.Lines.Text) <> '' then
    if Composicao.ItemIndex = 0 then
      Separador_E := 'AND '+ Negacao + '('
    else
      Separador_E := 'OR '+ Negacao + '(';
  Final := ')';
  //if EdNegacao.Checked then
  //  Final := Final + ')';
  if Trim(ExprMemo.Lines.Text) = '' then
    ExprMemo.Lines.Clear;
  ExprMemo.Lines.Add(Separador_E + ListaCampos.Items[ListaCampos.ItemIndex] + Oper + Delimit_E + EdExpressao.Text + Delimit_D + Final);
  //EdExpressao.Text := '';
  EdNegacao.Checked := false;
  ListaCampos.SetFocus;
end;

procedure TFormFiltro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormFiltro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Atribui_ListaFuncoes(ExprMemo, True);
end;

procedure TFormFiltro.Atribui_ListaFuncoes(Editor: TCustomSynEdit; Remover: Boolean);
var
  Memo1: TSynEdit;
  i: integer;
  Ln_Funcao: TStringList;
  Lista_Aux, Lista_Aux2: TStringList;
  Parametros: String;
begin
  if Remover then
  begin
    ListaFuncoes.CancelCompletion;
    ListaParametros.CancelCompletion;
    ListaFuncoes.InsertList.Clear;
    ListaFuncoes.ItemList.Clear;
    ListaParametros.ItemList.Clear;
    ListaFuncoes.RemoveEditor(Editor);
    ListaParametros.RemoveEditor(Editor);
  end
  else
  begin
    Memo1 := TSynEdit.Create(Self);
    Memo1.Visible := False;
    Memo1.Parent := Self;
    if FileExists(Projeto.PastaGerador + 'SQL.Lst') then
      Memo1.Lines.LoadFromFile(Projeto.PastaGerador + 'SQL.Lst');
    ListaParametros.ItemList.Clear;
    ListaFuncoes.AddEditor(Editor);
    ListaParametros.AddEditor(Editor);
    Lista_Aux := TStringList.Create;
    Lista_Aux2 := TStringList.Create;
    Ln_Funcao := TStringList.Create;
    for i:=0 to Memo1.Lines.Count-1 do
    begin
      Ln_Funcao.Clear;
      StringToArray(Memo1.Lines[i],'|',Ln_Funcao);
      if (Ln_Funcao.Count = 4) then
      begin
        Lista_Aux.Add(Ln_Funcao[1]);
        Parametros := '';
        if Pos('(',Ln_Funcao[2]) > 0 then
        begin
          Parametros := Copy(Ln_Funcao[2],Pos('(',Ln_Funcao[2]),Length(Ln_Funcao[2]));
          Parametros := Copy(Parametros,01,Pos(')',Parametros));
        end;
        if (UpperCase(Trim(Ln_Funcao[0])) <> 'FUNCTION') and
           (UpperCase(Trim(Ln_Funcao[0])) <> 'PROCEDURE') then
        begin
          EdExpressao.Items.Add(Ln_Funcao[1]);
          Parametros := '';
        end;
        Lista_Aux2.Add(Ln_Funcao[0] + ' '#9''+Ln_Funcao[1]+''#9''+Parametros+' - '+Ln_Funcao[3]);
      end;
    end;
    ListaFuncoes.InsertList.AddStrings(Lista_Aux);
    ListaFuncoes.ItemList.AddStrings(Lista_Aux2);
    Lista_Aux.Free;
    Lista_Aux2.Free;
    Ln_Funcao.Free;
    Memo1.Free;
  end;
end;

procedure TFormFiltro.ListaParametrosCancelled(Sender: TObject);
begin
  ListaParametros.ItemList.Text := '';
end;

procedure TFormFiltro.ListaFuncoesCodeCompletion(var Value: String;
  Shift: TShiftState; Index: Integer; EndToken: Char);
var
  Parametros: String;
begin
  Parametros := Copy(ListaFuncoes.ItemList[Index],Pos('(',ListaFuncoes.ItemList[Index])+1,Length(ListaFuncoes.ItemList[Index]));
  Parametros := Copy(Parametros,01,Pos(')',Parametros)-1);
  Parametros := TrocaString(Parametros,',',' ',[rfReplaceAll]);
  Parametros := Parametros + '  ';
  ListaParametros.Form.CurrentIndex := 0;
  if Trim(Parametros) = '' then Parametros := '*Nulo*  ';
  ListaParametros.ItemList.Add(Parametros);
end;

procedure TFormFiltro.ExprMemoEnter(Sender: TObject);
begin
  KeyPreview := False;
  LbEspecial.Visible := True;
  if AceitaScript then
    BtnScript.Visible := True;
end;

procedure TFormFiltro.ExprMemoExit(Sender: TObject);
begin
  KeyPreview := True;
  LbEspecial.Visible := False;
  BtnScript.Visible := False;
end;

procedure TFormFiltro.ExprMemoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = ')') and (ListaParametros.ItemList.Count > 0) then
    ListaParametros.CancelCompletion
  else if (Key = '(') and (ListaParametros.ItemList.Count > 0) then
    ListaParametros.ActivateCompletion
  else if (Key = ',') and (ListaParametros.ItemList.Count > 0) then
    ListaParametros.Form.CurrentIndex := ListaParametros.Form.CurrentIndex + 1
  else if (Key = '.') then
    ListaFuncoes.CancelCompletion;
end;

procedure TFormFiltro.ExprMemoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 74) then  // Ctrl + J
  begin
    if ExprMemo.SelectionMode = smNormal then
      ExprMemo.SelectionMode := smColumn
    else if ExprMemo.SelectionMode = smColumn then
      ExprMemo.SelectionMode := smLine
    else if ExprMemo.SelectionMode = smLine then
      ExprMemo.SelectionMode := smNormal;
  end;
end;

procedure TFormFiltro.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

procedure TFormFiltro.BtnScriptClick(Sender: TObject);
var
  I: Integer;
begin
  I := ExprMemo.CaretY-1;
  if Trim(ExprMemo.Lines[I]) = '' then
    ExprMemo.Lines[I] := '>>'
  else
  begin
    ExprMemo.Lines.Insert(I+1, '>>');
    ExprMemo.CaretY := ExprMemo.CaretY + 1;
  end;
  {I := ExprMemo.CaretY;
  if Trim(ExprMemo.Lines[I-1]) <> '' then
  begin
    ExprMemo.Lines.Insert(I+0,'[s]');
    ExprMemo.Lines.Insert(I+1,'');
    ExprMemo.Lines.Insert(I+2,'[\s]');
    ExprMemo.CaretY := I + 2;
  end
  else
  begin
    ExprMemo.Lines[I-1] := '[s]';
    ExprMemo.Lines.Insert(I+0,'');
    ExprMemo.Lines.Insert(I+1,'[\s]');
    ExprMemo.CaretY := I + 1;
  end;
  ExprMemo.CaretX := 0;}
  ExprMemo.CaretX := 4;
end;

procedure TFormFiltro.ExprMemoSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  if Copy(Trim(ExprMemo.Lines[Line-1]),01, 02) = '>>' then
  begin
    Special := TRUE;
    FG := clBlue;
    //BG := clBlue;
  end;
end;

end.
