unit CamposProj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, SynEdit, CheckLst, Menus;

type
  TFormCamposProj = class(TForm)
    DatasetsLB: TListBox;
    FieldsLB: TListBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Button1: TButton;
    Button2: TButton;
    FieldsLB_S: TCheckListBox;
    PopupMenu1: TPopupMenu;
    SelecionarTudo1: TMenuItem;
    DesmarcarTudo1: TMenuItem;
    Image5: TImage;
    procedure FormShow(Sender: TObject);
    procedure DatasetsLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FieldsLBClick(Sender: TObject);
    procedure FieldsLBDblClick(Sender: TObject);
    procedure DatasetsLBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SelecionarTudo1Click(Sender: TObject);
    procedure DesmarcarTudo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    not_Ver_Relacionados: Boolean;
    Ver_Extras: Boolean;
    Extras: String;
    Tipo: Integer;
    Escolha: Boolean;
    Retorno, Retorno1: String;
    SQL: Boolean;
    Editor_SQL: Boolean;
    Tab_Alvo: String;
    ListaNrTab: TStringList;
    ListaInstrucoes: TStringList;
  end;

var
  FormCamposProj: TFormCamposProj;

implementation

uses Abertura, Rotinas, BaseD, Tabela;

{$R *.DFM}

procedure TFormCamposProj.FormShow(Sender: TObject);
var
  i: integer;
  qy_Tabela: TTabela;
  lst_tabelas_extra: TStringList;
  ok: boolean;
  Memo1: TSynEdit;
  Ln_Funcao: TStringList;
begin
  if Escolha then
  begin
    FieldsLB.Visible := False;
    FieldsLB_S.Visible := True;
  end
  else
  begin
    FieldsLB.Visible := True;
    FieldsLB_S.Visible := False;
  end;
  ListaNrTab := TStringList.Create;
  DatasetsLB.Items.Clear;
  Retorno := '';
  Retorno1 := '';
  if Tipo = 1 then
  begin
    Caption := 'Tabelas & Campos do Projeto';
    qy_Tabela := TTabela.Create(Self);
    with qy_Tabela do
    begin
      lst_tabelas_extra := TStringList.Create;
      if Ver_Extras then
        StringToArray(Extras,';',lst_tabelas_extra);
      DataBase := TabGlobal_i.DTABELAS.DataBase;
      Transaction := TabGlobal_i.DTABELAS.Transaction;
      Sql.Text := 'Select Numero, Nome, Titulo_T From Tabelas Order By Nome';
      Abrir;
      First;
      while not Eof do
      begin
        if Trim(Fields[1].AsString) <> '' then
        begin
          ok := true;
          if ver_extras then
            if lst_tabelas_extra.IndexOf(Trim(Fields[1].AsString)) = -1 then
              ok := False;
          if ok then
          begin
            DatasetsLB.Items.AddObject(Fields[1].AsString + ' - ' +Fields[2].AsString,TObject(2));
            ListaNrTab.Add(IntToStr(Fields[0].AsInteger));
          end;
        end;
        Next;
      end;
      lst_tabelas_extra.Free;
      Close;
      Free;
    end;
    if (Projeto.Posicao_BD > -1) and (Projeto.Posicao_BD < DatasetsLB.Items.Count) then
      DatasetsLB.ItemIndex := Projeto.Posicao_BD;
  end
  else if Tipo = 2 then
  begin
    DatasetsLB.Width := 153;
    FieldsLB.Left := 164;
    FieldsLB.Width := 241;
    Caption := 'Variáveis Públicas do Projeto';
    DatasetsLB.Items.AddObject('Sistema',TObject(1));
    if not SQL then
    begin
      FieldsLB.Items.AddObject('Titulo - (String)',TObject(1));
      FieldsLB.Items.AddObject('Versao - (String)',TObject(1));
      FieldsLB.Items.AddObject('Analista - (String)',TObject(1));
      FieldsLB.Items.AddObject('Programador - (String)',TObject(1));
      FieldsLB.Items.AddObject('Projetista - (String)',TObject(1));
      FieldsLB.Items.AddObject('EstiloData - (String)',TObject(1));
      FieldsLB.Items.AddObject('ConfirmaSaida - (Boolean)',TObject(1));
      FieldsLB.Items.AddObject('ControleAcesso - (Boolean)',TObject(1));
      FieldsLB.Items.AddObject('SenhaInicial - (String)',TObject(1));
      FieldsLB.Items.AddObject('HintBalao - (Boolean)',TObject(1));
      FieldsLB.Items.AddObject('Pasta - (String)',TObject(1));
      FieldsLB.Items.AddObject('Usuario - (String)',TObject(1));
      FieldsLB.Items.AddObject('Senha - (String)',TObject(1));
      FieldsLB.Items.AddObject('Master - (Boolean)',TObject(1));
      FieldsLB.Items.AddObject('Grupo - (String)',TObject(1));
      FieldsLB.Items.AddObject('ListaUsuarios - (TStringList)',TObject(1));
      FieldsLB.Items.AddObject('Menu - (TTreeView)',TObject(1));
      FieldsLB.Items.AddObject('NumeroUsr - (Integer)',TObject(1));
      FieldsLB.Items.AddObject('EmpresaUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('EnderecoUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('BairroUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('CidadeUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('UfUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('CEPUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('CNPJUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('IEUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('FonesUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('LogoUsr - (String)',TObject(1));
      FieldsLB.Items.AddObject('Integridade - (Boolean)',TObject(1));
      FieldsLB.Items.AddObject('Conexao_i - (TDateTime)',TObject(1));
      FieldsLB.Items.AddObject('Conexao_f - (TDateTime)',TObject(1));
      FieldsLB.Items.AddObject('Estacao - (String)',TObject(1));
    end
    else
    begin
      Memo1 := TSynEdit.Create(Self);
      Memo1.Visible := False;
      Memo1.Parent := Self;
      if FileExists(Projeto.PastaGerador + 'SQL.Lst') then
        Memo1.Lines.LoadFromFile(Projeto.PastaGerador + 'SQL.Lst');
      Ln_Funcao := TStringList.Create;
      for i:=0 to Memo1.Lines.Count-1 do
      begin
        Ln_Funcao.Clear;
        StringToArray(Memo1.Lines[i],'|',Ln_Funcao);
        if (Ln_Funcao.Count = 4) then
          if (UpperCase(Trim(Ln_Funcao[0])) <> 'FUNCTION') and
             (UpperCase(Trim(Ln_Funcao[0])) <> 'PROCEDURE') then
            FieldsLB.Items.AddObject(Ln_Funcao[1] + ' - ('+Ln_Funcao[0]+')',TObject(1));
      end;
      Ln_Funcao.Free;
      Memo1.Free;
    end;
    if (Projeto.Posicao_VR > -1) and (Projeto.Posicao_VR < FieldsLB.Items.Count) then
      FieldsLB.ItemIndex := Projeto.Posicao_VR;
  end
  else if Tipo = 3 then
  begin
    DatasetsLB.Width := 153;
    FieldsLB.Left := 164;
    FieldsLB.Width := 241;
    Caption := 'Instruções ...';
    DatasetsLB.Items.AddObject('Instruções',TObject(1));
    for I:=0 to ListaInstrucoes.Count-1 do
      if Copy(ListaInstrucoes[i],01,01) = '[' then
        FieldsLB.Items.AddObject(Copy(ListaInstrucoes[I],02,Pos(']',ListaInstrucoes[I])-2),TObject(1));
    if (Projeto.Posicao_IT > -1) and (Projeto.Posicao_IT < FieldsLB.Items.Count) then
      FieldsLB.ItemIndex := Projeto.Posicao_IT;
  end;
  if (DatasetsLB.ItemIndex < 0) and (DatasetsLB.Items.Count > 0) then
    DatasetsLB.ItemIndex := 0;
  DatasetsLBClick(Self);
  FieldsLBClick(Self);
end;

procedure TFormCamposProj.DatasetsLBDrawItem(Control: TWinControl;
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
    if Control = DatasetsLB then
      if Integer(Items.Objects[Index]) = 1 then
        Image := Image3 else
        Image := Image1
    else if Integer(Items.Objects[Index]) = 1 then
      Image := Image4
    else if Integer(Items.Objects[Index]) = 3 then
      Image := Image5
    else
      Image := Image2;
    Canvas.BrushCopy(r, Image.Picture.Bitmap, Rect(0, 0, 18, 16),
      Image.Picture.Bitmap.TransparentColor);
    Canvas.TextOut(ARect.Left + 20, ARect.Top + 1, Items[Index]);
  end;
end;

procedure TFormCamposProj.FieldsLBClick(Sender: TObject);
  function Nome(S: String): String;
  begin
    Nome := Trim(Copy(S,01,Pos('-',S)-1));
  end;
begin
  if Escolha then
  begin
    if FieldsLB_S.ItemIndex < 0 then
      exit;
  end
  else
  begin
    if FieldsLB.ItemIndex < 0 then
      exit;
  end;
  if Tipo = 1 then
  begin
    if Escolha then
    begin
      Projeto.Posicao_FD := FieldsLB_S.ItemIndex;
      Retorno := ListaNrTab[DatasetsLB.ItemIndex];
      Retorno1 := Nome(DatasetsLB.Items[DatasetsLB.ItemIndex]);
    end
    else
    begin
      Retorno1 := Nome(DatasetsLB.Items[DatasetsLB.ItemIndex]);
      if not SQL then
      begin
        if Editor_SQL then
          Retorno := Nome(DatasetsLB.Items[DatasetsLB.ItemIndex])+'.'+Nome(FieldsLB.Items[FieldsLB.ItemIndex])
        else
          Retorno := 'TabGlobal.D'+Nome(DatasetsLB.Items[DatasetsLB.ItemIndex])+'.'+Nome(FieldsLB.Items[FieldsLB.ItemIndex])+'.Conteudo '
      end
      else
        if UpperCase(Trim(Tab_Alvo)) = Trim(UpperCase(Nome(DatasetsLB.Items[DatasetsLB.ItemIndex]))) then
          Retorno := Nome(FieldsLB.Items[FieldsLB.ItemIndex]) + ' '
        else
          Retorno := ':'+Nome(DatasetsLB.Items[DatasetsLB.ItemIndex])+'_'+Nome(FieldsLB.Items[FieldsLB.ItemIndex]) + ' ';
      Projeto.Posicao_FD := FieldsLB.ItemIndex;
    end;
    Projeto.Posicao_BD := DatasetsLB.ItemIndex;
  end
  else if Tipo = 2 then
  begin
    if not SQL then
    begin
      Retorno := Trim(DatasetsLB.Items[DatasetsLB.ItemIndex])+'.'+Nome(FieldsLB.Items[FieldsLB.ItemIndex])+ ' ';
      Retorno1 := Nome(DatasetsLB.Items[DatasetsLB.ItemIndex]);
    end
    else
    begin
      Retorno := Nome(FieldsLB.Items[FieldsLB.ItemIndex]) + ' ';
      Retorno1 := Nome(DatasetsLB.Items[DatasetsLB.ItemIndex]);
    end;
    Projeto.Posicao_VR := FieldsLB.ItemIndex;
  end
  else if Tipo = 3 then
  begin
    Retorno := Trim(Copy(FieldsLB.Items[FieldsLB.ItemIndex],01,Pos('|',FieldsLB.Items[FieldsLB.ItemIndex])-1));
    Retorno1 := Nome(DatasetsLB.Items[DatasetsLB.ItemIndex]);
    Projeto.Posicao_IT := FieldsLB.ItemIndex;
  end;
end;

procedure TFormCamposProj.FieldsLBDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormCamposProj.DatasetsLBClick(Sender: TObject);
var
  qy_Tabela: TTabela;
begin
  if DataSetsLB.ItemIndex < 0 then
    exit;
  if Tipo = 1 then
  begin
    Retorno := '';
    Retorno1 := '';
    if Escolha then
      FieldsLB_S.Items.Clear
    else
      FieldsLB.Items.Clear;
    qy_Tabela := TTabela.Create(Self);
    with qy_Tabela do
    begin
      DataBase := TabGlobal_i.DCAMPOST.DataBase;
      Transaction := TabGlobal_i.DCAMPOST.Transaction;
      if not_Ver_Relacionados then
        Sql.Text := 'Select Numero, Nome, Titulo_C, Sequencia, Extra From CamposT Where Numero = '+ListaNrTab[DatasetsLB.ItemIndex]+' and Extra = 0 and (Calculado = 0 or nao_virtual = 1) Order By Sequencia'
      else
        Sql.Text := 'Select Numero, Nome, Titulo_C, Sequencia, Extra From CamposT Where Numero = '+ListaNrTab[DatasetsLB.ItemIndex]+' Order By Sequencia';
      Abrir;
      First;
      while not Eof do
      begin
        if (Trim(Fields[1].AsString) <> '') then //and (Fields[4].AsInteger = 0) then
          if Escolha then
            FieldsLB_S.Items.AddObject(Fields[1].AsString + ' - ' +Fields[2].AsString,TObject(Fields[3].AsInteger))
          else
          begin
            if Fields[4].AsInteger = 0 then
              FieldsLB.Items.AddObject(Fields[1].AsString + ' - ' +Fields[2].AsString,TObject(2))
            else
              FieldsLB.Items.AddObject(Fields[1].AsString + ' - ' +Fields[2].AsString,TObject(3));
          end;
        Next;
      end;
      Close;
      Free;
    end;
    if Escolha then
    begin
      if (Projeto.Posicao_FD > -1) and (Projeto.Posicao_FD < FieldsLB_S.Items.Count) then
        FieldsLB_S.ItemIndex := Projeto.Posicao_FD;
    end
    else
    begin
      if (Projeto.Posicao_FD > -1) and (Projeto.Posicao_FD < FieldsLB.Items.Count) then
        FieldsLB.ItemIndex := Projeto.Posicao_FD;
    end;
    FieldsLBClick(Self);
  end;
end;

procedure TFormCamposProj.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ListaNrTab.Free;
  ListaInstrucoes.Free;
end;

procedure TFormCamposProj.FormCreate(Sender: TObject);
begin
  ListaInstrucoes := TStringList.Create;
end;

procedure TFormCamposProj.SelecionarTudo1Click(Sender: TObject);
var
  i: Integer;
begin
  for I:=0 to FieldsLB_S.Items.Count-1 do FieldsLB_S.Checked[I] := True;
end;

procedure TFormCamposProj.DesmarcarTudo1Click(Sender: TObject);
var
  i: Integer;
begin
  for I:=0 to FieldsLB_S.Items.Count-1 do FieldsLB_S.Checked[I] := False;
end;

end.
