unit Formularios;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, ImgList, XBanner, FileCtrl, SynEdit, DB,
  Mask, DBCtrls, IBQuery, IBDatabase, Menus, ShellAPI;

type
  TFormForms = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Paginas: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CancelBtn: TButton;
    Imagens: TImageList;
    TreeTipos2: TTreeView;
    Splitter1: TSplitter;
    ListaModelos: TListView;
    TreeTipos1: TTreeView;
    Splitter2: TSplitter;
    XBanner: TXBanner;
    XBanner1: TXBanner;
    Texto_PAS: TSynEdit;
    FileListBox1: TFileListBox;
    Panel3: TPanel;
    ListaExistentes: TListView;
    Panel0: TPanel;
    Label1: TLabel;
    EdTabela: TEdit;
    Label2: TLabel;
    BtnEditar: TSpeedButton;
    BtnSalvar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    EdTitulo: TEdit;
    BtnExcluir: TSpeedButton;
    BtnImportar: TSpeedButton;
    IBDatabase: TIBDatabase;
    IBTransaction: TIBTransaction;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure TreeTipos1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeTipos2Change(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure ListaExistentesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdTituloKeyPress(Sender: TObject; var Key: Char);
    procedure ListaExistentesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnImportarClick(Sender: TObject);
    procedure ListaModelosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    ListaFontes: TStringList;
    procedure EditaForm;
  public
    { Public declarations }
    Definicao_Relatorios: Boolean;
    function ValidaNome(Nome: String; Importacao: Boolean): Boolean;
  end;

var
  FormForms: TFormForms;

implementation

uses Abertura, Rotinas, Gera_01, FDesigner, Relator, Relator_ant, Tabela,
  ImpForm, Princ, NovoForm;

{$R *.DFM}

procedure TFormForms.FormShow(Sender: TObject);
var
  I, Y: Integer;
  NomeF: String;
  Ok, MDI, EntradaDados, Relatorio: Boolean;
  SearchOptionsPd: TSynSearchOptions;
begin
  Paginas.ActivePageIndex := 0;
  TreeTipos1.FullExpand;
  TreeTipos2.FullExpand;

  TreeTipos1.SetFocus;

  ListaFontes := TStringList.Create;

  FileListBox1.ApplyFilePath(Projeto.PastaFontes);
  for I:=0 to FileListBox1.Items.Count-1 do
    if (FileExists(Projeto.PastaFontes + FileListBox1.Items[I])) and
       (FileExists(Projeto.PastaFontes + TrocaString(FileListBox1.Items[I], '.pas', '.dfm',[rfReplaceAll, rfIgnoreCase]))) then
    begin
      NomeF := TrocaString(FileListBox1.Items[I], '.pas', '',[rfReplaceAll, rfIgnoreCase]);
      Ok := True;
      for Y:=1 to 7 do
        if LowerCase(NomeF) = 'modelo'+IntToStr(Y) then
          Ok := False;
      if Ok then
      begin
        Texto_PAS.Lines.Clear;
        Texto_PAS.Lines.LoadFromFile(Projeto.PastaFontes + FileListBox1.Items[I]);
        Texto_PAS.CaretY := 0;
        Texto_PAS.CaretX := 0;
        Texto_PAS.SearchReplace('XMakerModelo','', SearchOptionsPd);
        if Texto_PAS.CaretY > 1 then
        begin
          Ok := True;
          Texto_PAS.Lines.Clear;
          Texto_PAS.Lines.LoadFromFile(Projeto.PastaFontes + TrocaString(FileListBox1.Items[I], '.pas', '.dfm',[rfReplaceAll, rfIgnoreCase]));
          Texto_PAS.CaretY := 0;
          Texto_PAS.CaretX := 0;
          Texto_PAS.SearchReplace('fsMDIChild','', SearchOptionsPd);
          MDI := Texto_PAS.CaretY > 1;

          Texto_PAS.CaretY := 0;
          Texto_PAS.CaretX := 0;
          Texto_PAS.SearchReplace(' NoManutencao:','', SearchOptionsPd);
          EntradaDados := Texto_PAS.CaretY > 1;

          Texto_PAS.CaretY := 0;
          Texto_PAS.CaretX := 0;
          Texto_PAS.SearchReplace(' FrReport:','', SearchOptionsPd);
          Relatorio := Texto_PAS.CaretY > 1;

          ListaFontes.Add(IIF(MDI, '1', '0') + ',' + IIF(EntradaDados, '1', '0') + ',' + IIF(Relatorio, '1', '0') + ',' + TrocaString(FileListBox1.Items[I], '.pas', '',[rfReplaceAll, rfIgnoreCase]));
        end;
        Texto_PAS.Lines.Clear;
      end;
    end;
  if not Definicao_Relatorios then
  begin
    if Trim(Projeto.Formulario_Ult) > '' then
      if (Projeto.Formulario_Ult_ID > -1) and (Projeto.Formulario_Ult_ID <= TreeTipos1.Items.Count-1) then
      begin
        TreeTipos1.Items[Projeto.Formulario_Ult_ID].Selected := True;
        for I:=0 to ListaExistentes.Items.Count-1 do
          if LowerCase(Trim(ListaExistentes.Items[I].Caption)) = LowerCase(Trim(Projeto.Formulario_Ult)) then
          begin
            ListaExistentes.Items[I].Selected := True;
            ListaExistentes.SetFocus;
            break;
          end;
      end;
  end
  else
  begin
    if Trim(Projeto.Relatorio_Ult) > '' then
      if (Projeto.Relatorio_Ult_ID > -1) and (Projeto.Relatorio_Ult_ID <= TreeTipos1.Items.Count-1) then
      begin
        TreeTipos1.Items[Projeto.Relatorio_Ult_ID].Selected := True;
        for I:=0 to ListaExistentes.Items.Count-1 do
          if LowerCase(Trim(ListaExistentes.Items[I].Caption)) = LowerCase(Trim(Projeto.Relatorio_Ult)) then
          begin
            ListaExistentes.Items[I].Selected := True;
            ListaExistentes.SetFocus;
            break;
          end;
      end;
  end;
end;

procedure TFormForms.TreeTipos1Change(Sender: TObject; Node: TTreeNode);

  procedure Montalista1(Filtro: String);
  var
    Item: TListItem;
  begin
     ListaExistentes.Items.Clear;
     TabGlobal_i.DFORMULARIO.ChaveIndice := 'nome';
     TabGlobal_i.DFORMULARIO.Filtro := Filtro;
     TabGlobal_i.DFORMULARIO.AtualizaSql;
     while not TabGlobal_i.DFORMULARIO.Eof do
     begin
       Item := ListaExistentes.Items.Add;
       Item.Data := TabGlobal_i.DFORMULARIO.GetBookmark;
       Item.Caption := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
       case TabGlobal_i.DFORMULARIO.TIPO.Conteudo of
         1: Item.ImageIndex := 0;
         2: Item.ImageIndex := 1;
         3: Item.ImageIndex := 5;
         4: Item.ImageIndex := 6;
         5: Item.ImageIndex := 2;
         6: Item.ImageIndex := 3;
         7: Item.ImageIndex := 7;
       end;
       TabGlobal_i.DFORMULARIO.Next;
     end;
  end;

begin
  EdTitulo.Text := '';
  EdTabela.Text := '';
  BtnImportar.Enabled := True;
  Case Node.AbsoluteIndex of
    0: MontaLista1('(Tipo = 1) or (Tipo = 2)');
    1: MontaLista1('(Tipo = 1)');
    2: MontaLista1('(Tipo = 2)');
    3: MontaLista1('(Tipo = 5) or (Tipo = 6)');
    4: MontaLista1('(Tipo = 5)');
    5: MontaLista1('(Tipo = 6)');
    6: MontaLista1('(Tipo = 3)');
    7: MontaLista1('(Tipo = 4)');
    8: MontaLista1('(Tipo = 7)');
  end;
end;

procedure TFormForms.TreeTipos2Change(Sender: TObject; Node: TTreeNode);
var
  Item: TListItem;
  I: Integer;
  Tipo: Integer; // 0 = Todos, 1 = MDI, 2 = SDI
  Ok, EntradaDados, Relatorio, MDI: Boolean;
begin
  ListaModelos.Items.Clear;
  case Node.AbsoluteIndex of
    0 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo1';
          Item.ImageIndex := 0;

          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo2';
          Item.ImageIndex := 1;
          Tipo := 0;
        end;
    1 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo1';
          Item.ImageIndex := 0;
          Tipo := 1;
        end;
    2 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo2';
          Item.ImageIndex := 1;
          Tipo := 2;
        end;
    3 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo3';
          Item.ImageIndex := 2;

          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo4';
          Item.ImageIndex := 3;
          Tipo := 0;
        end;
    4 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo3';
          Item.ImageIndex := 2;
          Tipo := 1;
        end;
    5 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo4';
          Item.ImageIndex := 3;
          Tipo := 2;
        end;
    6 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo5';
          Item.ImageIndex := 5;
          Tipo := 2;
        end;
    7 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo6';
          Item.ImageIndex := 6;
          Tipo := 2;
        end;
    8 : begin
          Item := ListaModelos.Items.Add;
          Item.Caption    := 'Modelo7';
          Item.ImageIndex := 7;
          Tipo := 2;
        end;
  end;

  for I:=0 to ListaFontes.Count-1 do
  begin
    case Tipo of
      0: Ok := True;
      1: Ok := IIF(Copy(ListaFontes[I], 01, 01) = '1', True, False);
      2: Ok := IIF(Copy(ListaFontes[I], 01, 01) = '1', False, True);
    end;
    MDI          := IIF(Copy(ListaFontes[I], 01, 01) = '1', True, False);
    EntradaDados := IIF(Copy(ListaFontes[I], 03, 01) = '1', True, False);
    Relatorio    := IIF(Copy(ListaFontes[I], 05, 01) = '1', True, False);
    if (Node.AbsoluteIndex <= 2) and (Not EntradaDados) then
      Ok := False;
    if ((Node.AbsoluteIndex >= 3) and (Node.AbsoluteIndex <= 5)) and
       ((EntradaDados) or (Relatorio)) then
      Ok := False;
    if (Node.AbsoluteIndex >= 6) and (Not Relatorio) then
      Ok := False;
    if Ok then
    begin
      Item := ListaModelos.Items.Add;
      Item.Caption := Copy(ListaFontes[I], 07, Length(ListaFontes[I]));
      if MDI and EntradaDados then
        Item.ImageIndex := 0
      else if (not MDI) and EntradaDados then
        Item.ImageIndex := 1
      else if Relatorio then
        Item.ImageIndex := 5
      else if MDI and (Not EntradaDados) and (Not Relatorio) then
        Item.ImageIndex := 2
      else if (not MDI) and (Not EntradaDados) and (Not Relatorio) then
        Item.ImageIndex := 3
      else
        Item.ImageIndex := 4;
    end;
  end;
end;

procedure TFormForms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ListaExistentes.Selected) and
     Assigned(TreeTipos1.Selected) then
  begin
    if not Definicao_Relatorios then
    begin
      if TreeTipos1.Selected.AbsoluteIndex <= 6 then
      begin
        Projeto.Formulario_Ult    := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        Projeto.Formulario_Ult_ID := TreeTipos1.Selected.AbsoluteIndex;
      end
      else
      begin
        Projeto.Formulario_Ult    := '';
        Projeto.Formulario_Ult_ID := -1;
      end;
    end
    else
    begin
      if TreeTipos1.Selected.AbsoluteIndex > 5 then
      begin
        Projeto.Relatorio_Ult    := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        Projeto.Relatorio_Ult_ID := TreeTipos1.Selected.AbsoluteIndex;
      end
      else
      begin
        Projeto.Relatorio_Ult    := '';
        Projeto.Relatorio_Ult_ID := -1;
      end;
    end;
  end
  else
  begin
    if not Definicao_Relatorios then
    begin
      Projeto.Formulario_Ult    := '';
      Projeto.Formulario_Ult_ID := -1;
    end
    else
    begin
      Projeto.Relatorio_Ult     := '';
      Projeto.Relatorio_Ult_ID  := -1;
    end;  
  end;
  ListaFontes.Free;
  TabGlobal_i.DFORMULARIO.Filtro := '';
  TabGlobal_i.DFORMULARIO.ChaveIndice := 'numero';
  TabGlobal_i.DFORMULARIO.AtualizaSql;
  Gera_Dpr(True);
end;

procedure TFormForms.EditaForm;
begin
  TabGlobal_i.DTABELAS.Filtro := 'Numero = ' + IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
  TabGlobal_i.DTABELAS.AtualizaSql;
  if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 1 then
  begin
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo), TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo,TabGlobal_i.DTABELAS.NOME.Conteudo,1,False,TabGlobal_i.DFORMULARIO.MODELO.Conteudo);
    ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
    FormDesigner_Net.Reativa_Definicao := True;
    FormDesigner_Net.AbreForm(TabGlobal_i.DFORMULARIO.NOME.Conteudo, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
    FormDesigner_Net.CurrentForm_Avulso.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
    FormDesigner_Net.CurrentForm_Avulso.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
    FormDesigner_Net.HabilitaBarraExtra;
    Close;
  end
  else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 2 then
  begin
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo),TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo,TabGlobal_i.DTABELAS.NOME.Conteudo,2,False,TabGlobal_i.DFORMULARIO.MODELO.Conteudo);
    ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
    FormDesigner_Net.Reativa_Definicao := True;
    FormDesigner_Net.AbreForm(TabGlobal_i.DFORMULARIO.NOME.Conteudo, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
    FormDesigner_Net.CurrentForm_Avulso.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
    FormDesigner_Net.CurrentForm_Avulso.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
    FormDesigner_Net.HabilitaBarraExtra;
    Close;
  end
  else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) or
          (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) or
          (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
  begin
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.NOME.Conteudo),TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo,TabGlobal_i.DTABELAS.NOME.Conteudo,5,False,TabGlobal_i.DFORMULARIO.MODELO.Conteudo);

    TabGlobal_i.DRELATORIO.Filtro := 'Numero = '+IntToStr(TabGlobal_i.DFORMULARIO.NUMERO.Conteudo)+' and Tipo = 1';
    TabGlobal_i.DRELATORIO.AtualizaSql;
    if TabGlobal_i.DRELATORIO.Eof then
    begin
      FormRelatorio := TFormRelatorio.Create(Application);
      Try
        if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) then
          FormRelatorio.Caption  := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo + ' ( Relatório )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) then
          FormRelatorio.Caption  := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo + ' ( Gráfico )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
          FormRelatorio.Caption  := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo + ' ( Etiqueta )';
        FormRelatorio.NrFormulario := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo;
        FormRelatorio.NomeForm := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        FormRelatorio.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
        FormRelatorio.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
        FormRelatorio.Ed_Titulo.Text := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo;
        if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3 then
        begin
          FormRelatorio.Ed_Tipo.Text := 'Relatório';
          FormRelatorio.TipoRel := 1;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4 then
        begin
          FormRelatorio.Ed_Tipo.Text       := 'Gráfico';
          FormRelatorio.TipoRel := 2;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7 then
        begin
          FormRelatorio.Ed_Tipo.Text       := 'Etiqueta';
          FormRelatorio.TipoRel := 3;
        end;
        FormRelatorio.Ed_Formulario.Text   := 'Form'+TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        FormRelatorio.Ed_TabPrincipal.Text := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' +TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
        FormRelatorio.NrTabela             := IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        FormRelatorio.ShowModal;
      Finally
        FormRelatorio.Free;
      end;
    end
    else
    begin
      FormRelatorio_Ant := TFormRelatorio_Ant.Create(Application);
      Try
        if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3) then
          FormRelatorio_Ant.Caption  := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo + ' ( Relatório )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4) then
          FormRelatorio_Ant.Caption  := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo + ' ( Gráfico )'
        else if (TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7) then
          FormRelatorio_Ant.Caption  := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo + ' ( Etiqueta )';
        FormRelatorio_Ant.NrFormulario := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo;
        FormRelatorio_Ant.NomeForm := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        FormRelatorio_Ant.NomeTab  := TabGlobal_i.DTABELAS.NOME.Conteudo;
        FormRelatorio_Ant.NrTabela := IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
        FormRelatorio_Ant.Ed_Titulo.Text := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo;
        if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 3 then
        begin
          FormRelatorio_Ant.Ed_Tipo.Text := 'Relatório';
          FormRelatorio_Ant.TipoRel := 1;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 4 then
        begin
          FormRelatorio_Ant.Ed_Tipo.Text       := 'Gráfico';
          FormRelatorio_Ant.TipoRel := 2;
        end
        else if TabGlobal_i.DFORMULARIO.TIPO.Conteudo = 7 then
        begin
          FormRelatorio_Ant.Ed_Tipo.Text       := 'Etiqueta';
          FormRelatorio_Ant.TipoRel := 3;
        end;
        FormRelatorio_Ant.Ed_Formulario.Text   := 'Form'+TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        FormRelatorio_Ant.Ed_TabPrincipal.Text := TabGlobal_i.DTABELAS.NOME.Conteudo + ' - ' +TabGlobal_i.DTABELAS.TITULO_T.Conteudo;
        FormRelatorio_Ant.NrTabela             := IntToStr(TabGlobal_i.DTABELAS.NUMERO.Conteudo);
        FormRelatorio_Ant.ShowModal;
      Finally
        FormRelatorio_Ant.Free;
      end;
    end;
  end
  else
  begin
    ExecutaForm(TFormDesigner_Net,TForm(FormDesigner_Net));
    FormDesigner_Net.Reativa_Definicao := True;
    FormDesigner_Net.AbreForm(TabGlobal_i.DFORMULARIO.NOME.Conteudo, TabGlobal_i.DFORMULARIO.TIPO.Conteudo, True);
    Close;
  end;
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
end;

procedure TFormForms.OKBtnClick(Sender: TObject);
var
  I, Tipo: Integer;
  Sequencia: Variant;
begin
  if (Paginas.ActivePageIndex = 0) and Assigned(ListaExistentes.Selected) then
  begin
    TabGlobal_i.DFORMULARIO.GotoBookmark(ListaExistentes.Selected.Data);
    if Trim(TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo) <> '' then
    begin
      EditaForm;
    end
    else
      Mensagem('Formulário não encontrado!', modAdvertencia, [modOk]);
  end
  else if (Paginas.ActivePageIndex = 1) and Assigned(ListaModelos.Selected) then
  begin
    case TreeTipos2.Selected.AbsoluteIndex of
      0: Tipo := IIF(ListaModelos.Selected.ImageIndex = 0, 1, 2);
      1: Tipo := 1;
      2: Tipo := 2;
      3: Tipo := IIF(ListaModelos.Selected.ImageIndex = 0, 5, 6);
      4: Tipo := 5;
      5: Tipo := 6;
      6: Tipo := 3;
      7: Tipo := 4;
      8: Tipo := 7;
    end;
    if FREDT then
    begin
      PTabela(TabGlobal_i.DFORMULARIO, ['Count(NUMERO)'], 'TIPO = '+IntToStr(Tipo), Sequencia);
      if (Sequencia[0] >= 6) then
      begin
        Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente 6 '+^M+'Formulários de cada modelo.',modAdvertencia,[ModOk]);
        exit;
      end;
    end;
    FormNovoForm := TFormNovoForm.Create(Application);
    Try
      FormNovoForm.Tipo := Tipo;
      FormNovoForm.Modelo := ListaModelos.Selected.Caption;
      if FormNovoForm.ShowModal = mrOk then
      begin
        Paginas.ActivePageIndex := 0;
        Projeto.Formulario_Ult    := TabGlobal_i.DFORMULARIO.NOME.Conteudo;
        Projeto.Formulario_Ult_ID := TreeTipos2.Selected.AbsoluteIndex;
        TreeTipos1.Items[Projeto.Formulario_Ult_ID].Selected := True;
        TreeTipos1Change(TreeTipos1, TreeTipos1.Selected);
        for I:=0 to ListaExistentes.Items.Count-1 do
          if LowerCase(Trim(ListaExistentes.Items[I].Caption)) = LowerCase(Trim(Projeto.Formulario_Ult)) then
          begin
            ListaExistentes.Items[I].Selected := True;
            ListaExistentes.SetFocus;
            BtnSalvarClick(Self);
            break;
          end;
      end;
    Finally
      FormNovoForm.Free;
    end;
  end
  else
    Close;
end;

procedure TFormForms.ListaExistentesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  Resultado: Variant;
begin
  EdTitulo.Text := '';
  EdTabela.Text := '';
  EdTitulo.ReadOnly   := True;
  EdTitulo.Color      := clBtnFace;
  EdTitulo.Font.Color := ClBlue;
  BtnEditar.Enabled   := False;
  BtnExcluir.Enabled  := False;
  BtnImportar.Enabled := True;
  BtnSalvar.Enabled   := False;
  BtnCancelar.Enabled := False;
  if Item.Selected then
  begin
    TabGlobal_i.DFORMULARIO.GotoBookmark(Item.Data);
    EdTitulo.Text := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo;
    if PTabela(TabGlobal_i.DTABELAS, ['NUMERO'], [TabGlobal_i.DFORMULARIO.TABELA.Conteudo], ['NOME'], Resultado) then
      EdTabela.Text := Resultado[0]
    else
      EdTabela.Text := '';
    BtnEditar.Enabled := True;
    BtnExcluir.Enabled  := True;
  end;
end;

procedure TFormForms.BtnEditarClick(Sender: TObject);
begin
  BtnEditar.Enabled := False;
  BtnExcluir.Enabled := False;
  BtnImportar.Enabled := False;
  BtnSalvar.Enabled := True;
  BtnCancelar.Enabled := True;
  EdTitulo.Color := clWindow;
  EdTitulo.Font.Color := ClBlack;
  EdTitulo.ReadOnly := False;
  EdTitulo.SelectAll;
  EdTitulo.SetFocus;
end;

procedure TFormForms.BtnSalvarClick(Sender: TObject);
begin
  BtnEditar.Enabled := True;
  BtnExcluir.Enabled := True;
  BtnImportar.Enabled := True;
  BtnSalvar.Enabled := False;
  BtnCancelar.Enabled := False;
  EdTitulo.Color := clBtnFace;
  EdTitulo.Font.Color := ClBlue;
  EdTitulo.ReadOnly := True;
  TabGlobal_i.DFORMULARIO.Modifica;
  TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo := EdTitulo.Text;
  TabGlobal_i.DFORMULARIO.Salva;
  TabGlobal_i.DTABELAS.Filtro := 'Numero = ' + IntToStr(TabGlobal_i.DFORMULARIO.TABELA.Conteudo);
  TabGlobal_i.DTABELAS.AtualizaSql;
  if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 1 then       // Entrada de Dados
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,1,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 2 then  // Entrada de Dados Filho
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,2,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 3 then  // Relatório
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,5,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 4 then  // Gráfico
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,6,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 5 then  // Avulso MDI
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,3,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 6 then  // Avulso Normal
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,4,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo)
  else if TabGlobal_i.DFORMULARIO.Tipo.Conteudo = 7 then  // Etiqueta
    Gera_Modelo(Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo),EdTitulo.Text,TabGlobal_i.DTABELAS.NOME.Conteudo,7,True,TabGlobal_i.DFORMULARIO.Modelo.Conteudo);
  TabGlobal_i.DTABELAS.Filtro := '';
  TabGlobal_i.DTABELAS.AtualizaSql;
  ListaExistentes.SetFocus;
end;

procedure TFormForms.BtnCancelarClick(Sender: TObject);
begin
  BtnEditar.Enabled := True;
  BtnExcluir.Enabled := True;
  BtnImportar.Enabled := True;
  BtnSalvar.Enabled := False;
  BtnCancelar.Enabled := False;
  EdTitulo.Color := clBtnFace;
  EdTitulo.Font.Color := ClBlue;
  EdTitulo.ReadOnly := True;
  EdTitulo.Text := TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo;
  ListaExistentes.SetFocus;
end;

procedure TFormForms.EdTituloKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
    if BtnSalvar.Enabled then
      BtnSalvarClick(Self);
end;

procedure TFormForms.ListaExistentesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    if BtnEditar.Enabled then
      BtnEditarClick(Self);
  end
  else if Key = VK_DELETE then
  begin
    if BtnExcluir.Enabled then
      BtnExcluirClick(Self);
  end;
end;

procedure TFormForms.BtnExcluirClick(Sender: TObject);
begin
  if not Assigned(TreeTipos1.Selected) then
    exit;
  if not Assigned(ListaExistentes.Selected) then
    exit;
  if not TabGlobal_i.DFORMULARIO.PodeExcluir then
    exit;
  if Mensagem('Excluir Formulário "'+ListaExistentes.Selected.Caption+'"?',ModConfirmacao,[ModSim, ModNao]) = mrno then
    exit;
  if FileExists(Projeto.Pasta + Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo) + '.PAS') then
    DeleteFile(Projeto.Pasta + Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo) + '.PAS');
  if FileExists(Projeto.Pasta + Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo) + '.DFM') then
    DeleteFile(Projeto.Pasta + Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo) + '.DFM');
  if FileExists(Projeto.Pasta + Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo) + '.TPL') then
    DeleteFile(Projeto.Pasta + Trim(TabGlobal_i.DFORMULARIO.Nome.Conteudo) + '.TPL');
  TabGlobal_i.DFORMULARIO.Exclui;

  TreeTipos1Change(TreeTipos1, TreeTipos1.Selected);

  TreeTipos1.SetFocus;
end;

function TFormForms.ValidaNome(Nome: String; Importacao: Boolean): Boolean;
var Caracter,TipoChar : String;
    I: Integer;
    CharInvalido,JaExiste : Boolean;
    QueryP: TIBQuery;
begin
  Result := True;
  JaExiste := False;
  if Trim(Nome) = '' then
  begin
    Mensagem('Necessário informar NOME !!!',ModAdvertencia,[ModOk]);
    Result := False;
    exit;
  end;
  if (Pos(UpperCase(Nome)+'|',FormPrincipal.LNomesReservados1) > 0) or (UpperCase(Nome)+'.DPR' = UpperCase(ExtractFileName(Projeto.ArquivoProj))) then
  begin
    Mensagem('Nome Inválido !'+^M+^M+Nome+' ( Reservado ) ...',modErro,[modOk]);
    Result := False;
    exit;
  end;
  CharInvalido := False;
  for I := 1 to Length(Nome) do
  begin
    Caracter := UpperCase(Copy(Nome,I,01));
    if not ((Caracter[1] in ['A'..'Z']) or (Caracter[1] in ['0'..'9']) or
            (Caracter = '_')) then
    begin
      CharInvalido := True;
      tipoChar := Caracter;
    end;
  end;
  Caracter := UpperCase(Copy(Nome,1,01));
  if Caracter[1] in ['0'..'9'] then
  begin
    CharInvalido := True;
    tipoChar := Caracter;
  end;
  QueryP := TIBQuery.Create(Self);
  QueryP.DataBase := TabGlobal_i.DFORMULARIO.DataBase;
  QueryP.SQL.Text := 'Select Numero, Nome From Formulario where UPPER(NOME) = '+#39+UpperCase(Nome)+#39;
  QueryP.Open;
  QueryP.First;
  JaExiste := not QueryP.Eof;
  QueryP.Close;
  QueryP.Free;
  if CharInvalido then
  begin
    Mensagem('Caracter Inválido no Nome: '+ #39 + TipoChar + #39,ModAdvertencia,[ModOk]);
    Result := False;
    Exit;
  end;
  if JaExiste then
  begin
    Mensagem('Formulário/Relatório : "'+Nome+'" já cadastrado !',ModAdvertencia,[ModOk]);
    Result := False;
    Exit;
  end;
end;

procedure TFormForms.BtnImportarClick(Sender: TObject);
var
  xpasta, xnome, xtabela: String;
  I,Y, Seq, xnrtab: Integer;
  IBQuery1, IBQuery: TIBQuery;
  Tipo: Integer;
begin
  xpasta := '';
  if not SelectDirectory('Selecione a Pasta', '', xpasta) then
    exit;
  xpasta := DiretorioCombarra(xpasta);
  if not fileexists(xpasta + 'Projeto.Pro') then
  begin
    Mensagem('Projeto não encontrado !',ModAdvertencia,[modOk]);
    exit;
  end;
  if TreeTipos1.Selected.AbsoluteIndex <= 5 then
    Tipo := 1
  else
    Tipo := 2;
  IBDatabase.DatabaseName := xpasta + 'Projeto.Pro';
  IBDatabase.Params.Clear;
  IBDatabase.Params.Add('USER_NAME='+Projeto.usr_firebird);
  IBDatabase.Params.Add('PASSWORD='+Projeto.pwd_firebird);
  IBDatabase.LoginPrompt := False;
  IBDatabase.Connected := True;
  if IBDatabase.TestConnected then
  begin
    IBQuery := TIBQuery.Create(Self);
    IBQuery.Database := IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBQuery.SQL.Text := 'Select * From Formulario order By Nome';
    IBQuery.Open;
    IBQuery.First;
    FormImpForm := TFormImpForm.Create(Application);
    try
      FormImpForm.FieldsLB.Items.Clear;
      while not IBQuery.eof do
      begin
        FormImpForm.FieldsLB.Items.AddObject(IBQuery.FieldByName('NOME').AsString + ' - ' + IBQuery.FieldByName('TITULO_F').AsString,TObject(IBQuery.FieldByName('NUMERO').AsInteger));
        IBQuery.Next;
      end;
      IBQuery.Close;
      FormImpForm.Caption := 'Importação de Formulários/Relatórios';
      if FormImpForm.ShowModal = mrOk then
        for I:=0 to FormImpForm.FieldsLB.Items.Count-1 do
          if FormImpForm.FieldsLB.Checked[I] then
          begin
            IBQuery.SQL.Text := 'Select * From Formulario Where Numero = '+IntToStr(Integer(FormImpForm.FieldsLB.Items.Objects[I]));
            IBQuery.Open;
            if not IBQuery.eof then
            begin
               xnome := IBQuery.FieldByName('NOME').AsString;
               if ValidaNome(xnome, True) then
               begin
                 xnrtab := 0;
                 if (IBQuery.FieldByName('TIPO').AsInteger <> 5) and
                    (IBQuery.FieldByName('TIPO').AsInteger <> 6) then
                 begin
                   if FileExists(xpasta + xnome + '.Pas') then
                     FormPrincipal.Texto.Lines.LoadFromFile(xpasta + xnome + '.Pas');
                   for Y := 0 to FormPrincipal.texto.Lines.Count-1 do
                   begin
                     if Tipo = 1 then
                     begin
                       if Pos('  TabelaPrincipal    := TabGlobal.D',FormPrincipal.texto.Lines[Y]) > 0 then
                       begin
                         xtabela := FormPrincipal.texto.Lines[Y];
                         xtabela := Copy(xtabela,Pos('.',xtabela)+2,Length(xtabela));
                         xtabela := UpperCase(Trim(Copy(xtabela,01,Pos(';',xtabela)-1)));
                         Break;
                       end;
                     end
                     else
                     begin
                       if Pos('    DataBase := TabGlobal.D',FormPrincipal.texto.Lines[Y]) > 0 then
                       begin
                         xtabela := FormPrincipal.texto.Lines[Y];
                         xtabela := Copy(xtabela,Pos('.',xtabela)+2,Length(xtabela));
                         xtabela := UpperCase(Trim(Copy(xtabela,01,Pos('.',xtabela)-1)));
                         Break;
                       end
                       else if Pos('  QyRelatorio := D',FormPrincipal.texto.Lines[Y]) > 0 then
                       begin
                         xtabela := FormPrincipal.texto.Lines[Y];
                         xtabela := Trim(Copy(xtabela,Pos('=',xtabela)+1,Length(xtabela)-1));
                         xtabela := UpperCase(Trim(Copy(xtabela,02,Length(xtabela)-1)));
                         xtabela := Copy(xtabela,01,Length(xtabela)-1);
                         Break;
                       end;
                     end;
                   end;
                   FormPrincipal.Texto.Lines.Clear;
                   TabGlobal_i.DTABELAS.First;
                   xnrtab := -1;
                   while not TabGlobal_i.DTABELAS.Eof do
                   begin
                     if UpperCase(Trim(TabGlobal_i.DTABELAS.NOME.Conteudo)) = xtabela then
                     begin
                       xnrtab := TabGlobal_i.DTABELAS.NUMERO.Conteudo;
                       Break;
                     end;
                     TabGlobal_i.DTABELAS.Next;
                   end;
                 end;
                 if xnrtab <> -1 then
                 begin
                   TabGlobal_i.DTABELAS.Filtro := '';
                   TabGlobal_i.DTABELAS.AtualizaSql;
                   TabGlobal_i.DFORMULARIO.Filtro := '';
                   TabGlobal_i.DFORMULARIO.ChaveIndice := 'numero';
                   TabGlobal_i.DFORMULARIO.AtualizaSql;
                   TabGlobal_i.DFORMULARIO.Last;
                   Seq := TabGlobal_i.DFORMULARIO.NUMERO.Conteudo + 1;
                   TabGlobal_i.DFORMULARIO.ChaveIndice := 'nome';
                   TabGlobal_i.DFORMULARIO.AtualizaSql;
                   TabGlobal_i.DFORMULARIO.Last;
                   TabGlobal_i.DFORMULARIO.Inclui(Nil);
                   TabGlobal_i.DFORMULARIO.NUMERO.Conteudo   := Seq;
                   TabGlobal_i.DFORMULARIO.NOME.Conteudo     := xnome;
                   TabGlobal_i.DFORMULARIO.TIPO.Conteudo     := IBQuery.FieldByName('TIPO').AsInteger;
                   TabGlobal_i.DFORMULARIO.TITULO_F.Conteudo := IBQuery.FieldByName('TITULO_F').AsString;
                   TabGlobal_i.DFORMULARIO.TABELA.Conteudo   := xnrtab;
                   TabGlobal_i.DFORMULARIO.Salva;
                   if FileExists(xpasta + xnome + '.Pas') then
                     CopiaArquivo(xpasta + xnome + '.Pas', Projeto.Pasta + xnome + '.Pas');
                   if FileExists(xpasta + xnome + '.Dfm') then
                     CopiaArquivo(xpasta + xnome + '.Dfm', Projeto.Pasta + xnome + '.Dfm');
                   if Tipo = 2 then
                   begin
                     IBQuery1 := TIBQuery.Create(Self);
                     IBQuery1.Database := IBDatabase;
                     IBQuery1.Transaction := IBTransaction;
                     IBQuery1.SQL.Text := 'Select * From RELATORIO Where Numero = '+IBQuery.FieldByName('NUMERO').AsString;
                     IBQuery1.Open;
                     while not IBQuery1.eof do
                     begin
                       TabGlobal_i.DRELATORIO.Inclui(Nil);
                       TabGlobal_i.DRELATORIO.NUMERO.Conteudo    := Seq;
                       TabGlobal_i.DRELATORIO.TIPO.Conteudo      := IBQuery1.FieldByName('TIPO').AsInteger;
                       TabGlobal_i.DRELATORIO.SEQUENCIA.Conteudo := IBQuery1.FieldByName('SEQUENCIA').AsInteger;
                       TabGlobal_i.DRELATORIO.EXPRESSAO.Conteudo := IBQuery1.FieldByName('EXPRESSAO').AsString;
                       TBlobField(TabGlobal_i.DRELATORIO.FieldByName('ESPELHO_1')).AsString := TBlobField(IBQuery1.FieldByName('ESPELHO_1')).AsString;
                       TBlobField(TabGlobal_i.DRELATORIO.FieldByName('ESPELHO_2')).AsString := TBlobField(IBQuery1.FieldByName('ESPELHO_2')).AsString;
                       TabGlobal_i.DRELATORIO.Salva;
                       IBQuery1.Next;
                     end;
                     IBQuery1.Close;
                     IBQuery1.Free;
                   end;
                 end
                 else
                   Mensagem('Tabela : "'+xtabela+'" não está definida no projeto !',ModAdvertencia,[modOk]);
               end;
            end;
            IBQuery.Close;
            TabGlobal_i.DFORMULARIO.AtualizaSql;
          end;
      IBDatabase.Connected := False;
    finally
      IBQuery.Free;
      FormImpForm.Free;
    end;
  end;
  TreeTipos1.SetFocus;
end;

procedure TFormForms.ListaModelosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_INSERT then
    OKBtnClick(Self);
end;

procedure TFormForms.Button1Click(Sender: TObject);
begin
  ChamaAjuda;

end;

end.

