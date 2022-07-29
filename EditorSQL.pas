unit EditorSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SynEdit, ImgList, ComCtrls, ToolWin, ExtCtrls, SynEditHighlighter,
  SynHighlighterPas, BaseD, StdCtrls, SynEditTypes, find, Replace,
  SynCompletionProposal, IniFiles, XPMenu, Menus, SynEditPrint, env_opt;

type
  TFormEditorSQL = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    BtnExpressao: TToolButton;
    BtnCampos: TToolButton;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    BtnRecortar: TToolButton;
    BrnCopiar: TToolButton;
    BtnColar: TToolButton;
    ToolBar2: TToolBar;
    BtnCancelar: TToolButton;
    BtnGravar: TToolButton;
    E_Metodo: TSynEdit;
    Divisao: TToolButton;
    Ativo: TCheckBox;
    BtnLocalizar: TToolButton;
    BtnSubstituir: TToolButton;
    BtnProximo: TToolButton;
    BtnEstruturas: TToolButton;
    ListaFuncoes: TSynCompletionProposal;
    ListaParametros: TSynCompletionProposal;
    StatusBar: TStatusBar;
    LbErro: TLabel;
    BtnPosicionar: TToolButton;
    BtnFormularios: TToolButton;
    PopMenu: TPopupMenu;
    PopRecortar: TMenuItem;
    PopCopiar: TMenuItem;
    PopColar: TMenuItem;
    PopSelecionarTudo: TMenuItem;
    PopImprimir: TMenuItem;
    Inserir1: TMenuItem;
    PopDataHora: TMenuItem;
    BlocodeComentario: TMenuItem;
    BtnComentar: TToolButton;
    BtnDescomentar: TToolButton;
    N1: TMenuItem;
    PopComentar: TMenuItem;
    PopDescomentar: TMenuItem;
    procedure BtnExpressaoClick(Sender: TObject);
    procedure BtnCamposClick(Sender: TObject);
    procedure BtnRecortarClick(Sender: TObject);
    procedure BrnCopiarClick(Sender: TObject);
    procedure BtnColarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure E_MetodoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_MetodoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnSubstituirClick(Sender: TObject);
    procedure E_MetodoReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnEstruturasClick(Sender: TObject);
    procedure ListaFuncoesCodeCompletion(var Value: String;
      Shift: TShiftState; Index: Integer; EndToken: Char);
    procedure ListaParametrosCancelled(Sender: TObject);
    procedure E_MetodoStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure ShowHintEditor(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPosicionarClick(Sender: TObject);
    procedure BtnFormulariosClick(Sender: TObject);
    procedure PopSelecionarTudoClick(Sender: TObject);
    procedure PopDataHoraClick(Sender: TObject);
    procedure BlocodeComentarioClick(Sender: TObject);
    procedure PopImprimirClick(Sender: TObject);
    procedure BtnComentarClick(Sender: TObject);
    procedure BtnDescomentarClick(Sender: TObject);
    procedure E_MetodoSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
  private
    { Private declarations }
    FrmFind: TFrmFind;
    FrmReplace: TFrmReplace;
    FrmEnvOpts: TFrmEnvOpts;
    SearchOptions: TSynSearchOptions;
    Salvar: Boolean;
    procedure Atribui_ListaFuncoes(Editor: TCustomSynEdit; Remover: Boolean = False);
    function ValidaBloco: Boolean;
  public
    { Public declarations }
    Posicao_Y, Posicao_X: Integer;
    Validar_Bloco: Boolean;
  end;

var
  FormEditorSQL: TFormEditorSQL;
  MenuXP: TXPMenu;

implementation

uses Expressao, CamposProj, Rotinas, Princ, LstForm, Relator;

{$R *.DFM}

procedure TFormEditorSQL.BtnExpressaoClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    if FormExpressao.ShowModal = mrOk then
    begin
      E_Metodo.SelText := FormExpressao.ExprMemo.Text;
      E_Metodo.SetFocus;
      E_Metodo.Modified := True;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

procedure TFormEditorSQL.BtnCamposClick(Sender: TObject);
var
  Campo: String;
begin
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    FormCamposProj.Tipo := 1;
    FormCamposProj.Editor_SQL  := True;
    if FormCamposProj.ShowModal = mrOk then
    begin
      if Trim(FormCamposProj.Retorno) <> '' then
      begin
        E_Metodo.SelText := FormCamposProj.Retorno;
        E_Metodo.SetFocus;
        E_Metodo.Modified := True;
      end;
    end;
  Finally
    FormCamposProj.Free;
  end;
end;

procedure TFormEditorSQL.BtnRecortarClick(Sender: TObject);
begin
  E_Metodo.CutToClipboard;
end;

procedure TFormEditorSQL.BrnCopiarClick(Sender: TObject);
begin
  E_Metodo.CopyToClipboard;
end;

procedure TFormEditorSQL.BtnColarClick(Sender: TObject);
begin
  E_Metodo.PasteFromClipboard;
end;

procedure TFormEditorSQL.BtnCancelarClick(Sender: TObject);
begin
  Salvar := False;
  ModalResult := mrOk;
  Close;
end;

procedure TFormEditorSQL.BtnGravarClick(Sender: TObject);
begin
  Salvar := True;
  //E_Metodo.Modified := False;
  Close;
end;

function TFormEditorSQL.ValidaBloco: Boolean;
var
  I: Integer;
  Qtd_Begin, Qtd_End: Integer;
  Qtd_I_Coment, Qtd_F_Coment: Integer;
  Pesquisa: String;
begin
  ValidaBloco := True;
  Qtd_Begin := 0;
  Qtd_End := 0;
  Qtd_I_Coment := 0;
  Qtd_F_Coment := 0;
  for I:=0 to E_Metodo.Lines.Count-1 do
  begin
    Pesquisa := Trim(UpperCase(E_Metodo.Lines[I]));
    //Qtd_I_Coment := Qtd_I_Coment + ContaOcorrencia('{',Pesquisa);
    //Qtd_F_Coment := Qtd_F_Coment + ContaOcorrencia('}',Pesquisa);
    if (Qtd_I_Coment = Qtd_F_Coment) then
    begin
      if (((Copy(Pesquisa,01,05) = 'BEGIN') or (Copy(Pesquisa,01,03) = 'TRY') or (Copy(Pesquisa,01,04) = 'CASE'))) and
         ((Pesquisa[6] = ' ') or (Pesquisa[6] = '/') or (Pesquisa[6] = '') or (Pesquisa[6] = '{')) then
        inc(Qtd_Begin);
      if (Copy(Pesquisa,01,03) = 'END') and
         ((Pesquisa[4] = ' ') or (Pesquisa[4] = '/') or (Pesquisa[4] = '') or (Pesquisa[4] = ';') or (Pesquisa[4] = '}')) then
        inc(Qtd_End);
    end;
  end;
  if not ((Qtd_Begin = Qtd_End) and (Qtd_I_Coment = Qtd_F_Coment) and (Qtd_Begin > 0)) then
  begin
    LbErro.Caption := '';
    if (not (Qtd_Begin = Qtd_End) or (Qtd_Begin = 0)) then
      LbErro.Caption := '"Begin" / "End": '+IntToStr(Qtd_Begin)+'/'+IntToStr(Qtd_End);
    if not (Qtd_I_Coment = Qtd_F_Coment) then
    begin
      if LbErro.Caption <> '' then LbErro.Caption := LbErro.Caption +',   ';
      LbErro.Caption := LbErro.Caption + '"{" / "}": '+IntToStr(Qtd_I_Coment)+'/'+IntToStr(Qtd_F_Coment);
    end;
    LbErro.Visible := True;
    ValidaBloco := False;
    Salvar := False;
  end;
end;

procedure TFormEditorSQL.FormShow(Sender: TObject);
begin
  MenuXP  := TXPMenu.Create(Self);
  with MenuXP do
  begin
    DimLevel := 30;
    GrayLevel := 10;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'Tahoma';
    Font.Style := [];
    Color := clBtnFace;
    DrawMenuBar := False;
    IconBackColor := clBtnFace;
    MenuBarColor := clBtnFace;
    SelectColor := clHighlight;
    SelectBorderColor := clHighlight;
    SelectFontColor := clWindowText;
    DisabledColor := clInactiveCaption;
    SeparatorColor := clBtnFace;
    CheckedColor := clHighlight;
    IconWidth := 24;
    DrawSelect := True;
    UseSystemColors := True;
    UseDimColor := False;
    OverrideOwnerDraw := False;
    Gradient := False;
    FlatMenu := False;
    AutoDetect := False;
    XPContainers := [xccToolbar, xccCoolbar, xccControlbar];
    XPControls := [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar];
    Active := True;
  end;
  LbErro.Visible := False;
  ModalResult := mrCancel;
  FrmFind := TFrmFind.Create(Application);
  FrmReplace := TFrmReplace.Create(Application);
  FrmEnvOpts := TFrmEnvOpts.Create(Application);
  Atribui_ListaFuncoes(E_Metodo);
  FrmFind.EmTodos.Visible := False;
  FrmReplace.EmTodos.Visible := False;
  E_MetodoStatusChange(E_Metodo, []);
  Salvar := False;
  if Posicao_Y > 0 then
    E_Metodo.CaretY := Posicao_Y;
  if Posicao_X > 0 then
    E_Metodo.CaretX := Posicao_X;
  E_Metodo.SetFocus;
end;

procedure TFormEditorSQL.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not Salvar then
  begin
    if E_Metodo.Modified then
    begin
      if Mensagem('Salvar modificações ?',modConfirmacao,[modSim, modNao]) = mrYes then
      begin
        if (Ativo.Visible) and (not Ativo.Checked) then
          if Mensagem('Ativar SQL ?', modConfirmacao, [modSim, modNao]) = mrYes then
            Ativo.Checked := True;
        ModalResult := mrOk;
      end
      else
        ModalResult := mrCancel;
    end
    else
      ModalResult := mrCancel;
  end
  else
  begin
    if (Ativo.Visible) and (not Ativo.Checked) then
      if Mensagem('Ativar SQL ?', modConfirmacao, [modSim, modNao]) = mrYes then
        Ativo.Checked := True;
    ModalResult := mrOk;
  end;
  FrmFind.Free;
  FrmReplace.Free;
  FrmEnvOpts.Free;
  MenuXP.Free;
  Atribui_ListaFuncoes(E_Metodo, True);
  Application.OnHint := FormPrincipal.Showhint;
end;

procedure TFormEditorSQL.E_MetodoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 74) then  // Ctrl + J
  begin
    if E_Metodo.SelectionMode = smNormal then
      E_Metodo.SelectionMode := smColumn
    else if E_Metodo.SelectionMode = smColumn then
      E_Metodo.SelectionMode := smLine
    else if E_Metodo.SelectionMode = smLine then
      E_Metodo.SelectionMode := smNormal;
  end
  else if (Shift = [ssCtrl]) and (Key = 70) then  // Ctrl + F
    BtnLocalizarClick(Self)
  else if (Shift = [ssCtrl]) and (Key = 76) then  // Ctrl + L
    BtnProximoClick(Self)
  else if (Shift = [ssCtrl]) and (Key = 82) then  // Ctrl + R
    BtnSubstituirClick(Self)
  else if (Shift = [ssAlt]) and (Key = 71) then  // Alt + G
    BtnPosicionarClick(Self);
end;

procedure TFormEditorSQL.E_MetodoKeyPress(Sender: TObject; var Key: Char);
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

procedure TFormEditorSQL.BtnLocalizarClick(Sender: TObject);
var
  OldBlockBegin: TPoint;
  OldBlockEnd: TPoint;
  Achou: Boolean;
begin
  Achou := True;
  with E_Metodo do
  begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd   := BlockEnd;
    SetSelWord;
    frmFind.cbFindText.Text := SelText;
    BlockBegin := OldBlockBegin;
    BlockEnd   := OldBlockEnd;
    if frmFind.ShowModal=mrOk then
    begin
      SearchOptions := [];
      if frmFind.cbMatchCase.Checked then
        include( SearchOptions, ssoMatchCase );
      if frmFind.cbWholeWord.Checked then
        include( SearchOptions, ssoWholeWord );
      if frmFind.rbBackward.Checked then
        include( SearchOptions, ssoBackwards );
      if frmFind.rbSelectedOnly.Checked then
        include( SearchOptions, ssoSelectedOnly );
      if frmFind.rbEntireScope.Checked then
        include( SearchOptions, ssoEntireScope );
      if SearchReplace(frmFind.cbFindText.Text, '', SearchOptions ) = 0 then
        Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
    end;
  end;
  if not Achou then
    Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
end;

procedure TFormEditorSQL.BtnSubstituirClick(Sender: TObject);
var
  ReplaceText:string;
  OldBlockBegin: TPoint;
  OldBlockEnd: TPoint;
  Achou: Boolean;
begin
  Achou := True;
  with E_Metodo do
  begin
    OldBlockBegin := BlockBegin;
    OldBlockEnd   := BlockEnd;
    SetSelWord;
    frmReplace.cbFindText.Text := E_Metodo.SelText;
    BlockBegin := OldBlockBegin;
    BlockEnd   := OldBlockEnd;
    if frmReplace.ShowModal=mrOk then begin
      ReplaceText:= frmReplace.cbReplace.Text;
      SearchOptions := [];
      if frmReplace.cbMatchCase.Checked then
        include( SearchOptions, ssoMatchCase );
      if frmReplace.cbWholeWord.Checked then
        include( SearchOptions, ssoWholeWord );
      if frmReplace.rbBackward.Checked then
        include( SearchOptions, ssoBackwards );
      if frmReplace.rbSelectedOnly.Checked then
        include( SearchOptions, ssoSelectedOnly );
      if frmReplace.rbEntireScope.Checked then
        include( SearchOptions, ssoEntireScope );
      include( SearchOptions, ssoReplaceAll );
      include( SearchOptions, ssoPrompt );
      if SearchReplace(frmReplace.cbFindText.Text, ReplaceText, SearchOptions ) = 0 then
        Mensagem(frmReplace.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
    end;
  end;
  if not Achou then
    Mensagem(frmReplace.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
end;

procedure TFormEditorSQL.E_MetodoReplaceText(Sender: TObject;
  const ASearch, AReplace: String; Line, Column: Integer;
  var Action: TSynReplaceAction);
var
  Resposta : Integer;
begin
  Resposta := Mensagem('Substituir a ocorrência por '+#39+AReplace+#39+' ?',ModConfirmacao,[ModSim,ModNao,ModCancela,ModTodos]);
  if Resposta = mrYes then
    Action := raReplace
  else if Resposta = mrNo then
    Action := raSkip
  else if Resposta = mrCancel then
    Action := raCancel
  else if Resposta = 10 then
    Action := raReplaceAll;
end;

procedure TFormEditorSQL.BtnProximoClick(Sender: TObject);
begin
  exclude( SearchOptions, ssoEntireScope );
  if E_Metodo.SearchReplace(frmFind.cbFindText.Text, '', SearchOptions ) = 0 then
    Mensagem(frmFind.cbFindText.Text + ^M + 'Não encontrado !',ModAdvertencia,[ModOk]);
end;

procedure TFormEditorSQL.BtnEstruturasClick(Sender: TObject);
var
  I: Integer;
begin
  I := E_Metodo.CaretY-1;
  if Trim(E_Metodo.Lines[I]) = '' then
    E_Metodo.Lines[I] := '>>'
  else
  begin
    E_Metodo.Lines.Insert(I+1, '>>');
    E_Metodo.CaretY := E_Metodo.CaretY + 1;
  end;
  {if Trim(E_Metodo.Lines[I-1]) <> '' then
  begin
    E_Metodo.Lines.Insert(I+0,'[s]');
    E_Metodo.Lines.Insert(I+1,'');
    E_Metodo.Lines.Insert(I+2,'[\s]');
    E_Metodo.CaretY := I + 2;
  end
  else
  begin
    E_Metodo.Lines[I-1] := '[s]';
    E_Metodo.Lines.Insert(I+0,'');
    E_Metodo.Lines.Insert(I+1,'[\s]');
    E_Metodo.CaretY := I + 1;
  end;}
  E_Metodo.CaretX := 4;
end;

procedure TFormEditorSQL.ListaFuncoesCodeCompletion(var Value: String;
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

procedure TFormEditorSQL.ListaParametrosCancelled(Sender: TObject);
begin
  ListaParametros.ItemList.Text := '';
end;

procedure TFormEditorSQL.Atribui_ListaFuncoes(Editor: TCustomSynEdit; Remover: Boolean);
var
  Memo1: TSynEdit;
  i: integer;
  Ln_Funcao: TStringList;
  Lista_Aux, Lista_Aux2: TStringList;
  Parametros, Linha: String;
  Bloco: Boolean;
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
            Lista_Aux.Add(':'+Linha);
            Lista_Aux2.Add('Objeto' + ' '#9''+':'+Linha+''#9''+''+' - '+'Caixa de diálogo.');
          end;
        end;
      end;
    end;
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

procedure TFormEditorSQL.E_MetodoStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  with Sender as TSynEdit do begin
    StatusBar.Panels[0].Text := Format('%d:%d', [CaretY, CaretX]);
    if Modified then
      StatusBar.Panels[1].Text := 'Modificado'
    else
      StatusBar.Panels[1].Text := '';
    if InsertMode then
      StatusBar.Panels[2].Text := 'Inserção'
    else
      StatusBar.Panels[2].Text := 'Subscrever'; {OverWrite}
    StatusBar.Panels[3].Text := 'Especial: Ctrl + Space';
  end;
end;

procedure TFormEditorSQL.ShowHintEditor(Sender: TObject);
begin
  if Length(FormEditorSQL.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := FormEditorSQL.Hint;
  end
  else StatusBar.SimplePanel := False;
end;

procedure TFormEditorSQL.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHintEditor;
end;

procedure TFormEditorSQL.BtnPosicionarClick(Sender: TObject);
var
  ret:boolean;
  SLine:string;
  NewLine:integer;
begin
  ret:=InputQuery('Posicionar...','Ir para Linha: ',SLine);
  if ret then
  begin
    E_Metodo.SetFocus;
    NewLine:=StrToIntDef(SLine, 0);
    E_Metodo.CaretY:= NewLine;
  end;
end;

procedure TFormEditorSQL.BtnFormulariosClick(Sender: TObject);
var
  Tipo, I: Integer;
  Nome: String;
begin
  FormListaForm := TFormListaForm.Create(Application);
  Try
    if FormListaForm.ShowModal = mrOk then
      if FormListaForm.DatasetsLB.ItemIndex > -1 then
      begin
        Tipo := Integer(FormListaForm.DatasetsLB.Items.Objects[FormListaForm.DatasetsLB.ItemIndex]);
        Nome := FormListaForm.DatasetsLB.Items[FormListaForm.DatasetsLB.ItemIndex];
        Nome := Trim(Copy(Nome,01,Pos('-',Nome)-1));
        I := E_Metodo.CaretY;
        if (TIPO = 2) or
           (TIPO = 3) or
           (TIPO = 4) or
           (TIPO = 6) or
           (TIPO = 7) then
        begin
          E_Metodo.Lines.Insert(I+0,'  Form'+Nome+' := TForm'+Nome+'.Create(Application);');
          E_Metodo.Lines.Insert(I+1,'  Try');
          E_Metodo.Lines.Insert(I+2,'    Form'+Nome+'.ShowModal;');
          E_Metodo.Lines.Insert(I+3,'  Finally');
          E_Metodo.Lines.Insert(I+4,'    Form'+Nome+'.Free;');
          E_Metodo.Lines.Insert(I+5,'  end;');
        end
        else
          E_Metodo.Lines.Insert(I+0,'  ExecutaForm(TForm'+Nome+',Form'+Nome+');');
        E_Metodo.Modified := True;
      end;
  Finally
    FormListaForm.Free;
  end;
end;

procedure TFormEditorSQL.PopSelecionarTudoClick(Sender: TObject);
begin
  E_Metodo.SelectAll;
end;

procedure TFormEditorSQL.PopDataHoraClick(Sender: TObject);
begin
  E_Metodo.SelText := DateToStr(Date) + ', ' +TimeToStr(Time);
end;

procedure TFormEditorSQL.BlocodeComentarioClick(Sender: TObject);
begin
  E_Metodo.SelText := '{' + ^M + ^M + '}';
  E_Metodo.CaretY  := E_Metodo.CaretY - 1;
end;

procedure TFormEditorSQL.PopImprimirClick(Sender: TObject);
var
  AFont: TFont;
begin
  if FormPrincipal.PrintDialog.Execute then
  begin
    AFont := TFont.Create;
    with FormPrincipal.SynEditPrint.Header do begin
        {First line, default font, left aligned}
      //Add(' ', nil, taLeftJustify, 1);
        {First line, default font, right aligned}
      Add('Página: $PAGENUM$ de $PAGECOUNT$', nil, taRightJustify, 1);
        {Second line, default font, left aligned}
      Add('$TITLE$', nil, taLeftJustify, 1);
      AFont.Assign(DefaultFont);
      AFont.Size := 6;
        {Second line, small font, right aligned - note that lines can have different fonts}
      Add('Data: $DATE$. Hora: $TIME$', AFont, taRightJustify, 2);
    end;
    {with SynEditPrint.Footer do begin
      AFont.Assign(DefaultFont);
      Add('$PAGENUM$/$PAGECOUNT$', nil, taRightJustify, 1);
      AFont.Size := 6;
      Add('Modular Software', AFont, taLeftJustify, 1);
    end;}
    AFont.Free;
    FormPrincipal.SynEditPrint.SynEdit := E_Metodo;
    //SynEditPrint.Title := E_Metodo.Filename;
    FormPrincipal.SynEditPrint.Print;
  end;
end;

procedure TFormEditorSQL.BtnComentarClick(Sender: TObject);
begin
  if Trim(E_Metodo.SelText) <> '' then
    E_Metodo.SelText := '{' + E_Metodo.SelText + '}';
end;

procedure TFormEditorSQL.BtnDescomentarClick(Sender: TObject);
var
  x_sel: String;
  i: Integer;
begin
  with E_Metodo do
    if SelText <> '' then
    begin
      x_sel := Trim(SelText);
      if (x_sel[1] = '{') and (x_sel[Length(x_sel)] = '}' ) then
      begin
        x_sel := TrocaString(SelText,'{','',[]);
        for i:=length(x_sel) downto 1 do
          if x_sel[i] = '}' then
          begin
            x_sel := Copy(x_sel,1,i-1) + Copy(x_sel,i+1,length(x_sel));
            break;
          end;
        SelText := x_sel;
      end;
    end;
end;

procedure TFormEditorSQL.E_MetodoSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
begin
  if Copy(Trim(E_Metodo.Lines[Line-1]),01, 02) = '>>' then
  begin
    Special := TRUE;
    FG := clBlue;
    //BG := clBlue;
  end;
end;

end.
