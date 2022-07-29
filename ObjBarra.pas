unit ObjBarra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, ExtCtrls, StdCtrls, Grids, Buttons;

type
  TFormBarraF = class(TForm)
    ControlBar1: TControlBar;
    ToolBar: TToolBar;
    BtnNovo: TToolButton;
    BtnDeletar: TToolButton;
    PageObject: TPageControl;
    TabPropriedades: TTabSheet;
    ListaBotoes: TTreeView;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    Label2: TLabel;
    EdMensagem: TEdit;
    Label3: TLabel;
    ComboImagem: TComboBox;
    Label5: TLabel;
    ComboPrograma: TComboBox;
    BtnAtualizar: TButton;
    BtnCancela: TButton;
    BtnModificar: TToolButton;
    PopInserir: TPopupMenu;
    SubMenu: TMenuItem;
    Formulario: TMenuItem;
    RotinaAvulsa: TMenuItem;
    ProgramaExternoEXE: TMenuItem;
    Separacao: TMenuItem;
    N1: TMenuItem;
    Arquivo: TMenuItem;
    ConfiguraodeSenhas: TMenuItem;
    EmpresaUsuria: TMenuItem;
    CpiadeSegurana: TMenuItem;
    Copiar: TMenuItem;
    Restaurar: TMenuItem;
    ConfiguraImpressora: TMenuItem;
    OutroUsurio: TMenuItem;
    Sair: TMenuItem;
    Exibir: TMenuItem;
    Calendrio: TMenuItem;
    Calculadora: TMenuItem;
    Agenda: TMenuItem;
    Assistente: TMenuItem;
    Janelas: TMenuItem;
    Cascata: TMenuItem;
    Horizontal: TMenuItem;
    Vertical: TMenuItem;
    MinimizaTodas: TMenuItem;
    Organizarcones: TMenuItem;
    Ajuda: TMenuItem;
    Contedo: TMenuItem;
    TpicosdaAjuda: TMenuItem;
    Sobre: TMenuItem;
    Label1: TLabel;
    EdTitulo: TEdit;
    Ambiente1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure ComboImagemDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboImagemMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListaBotoesChange(Sender: TObject; Node: TTreeNode);
    procedure BtnFecharClick(Sender: TObject);
    procedure ListaBotoesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnDeletarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfiguraodeSenhasClick(Sender: TObject);
    procedure BasedeDadosClick(Sender: TObject);
    procedure CopiarClick(Sender: TObject);
    procedure RestaurarClick(Sender: TObject);
    procedure EmpresaUsuriaClick(Sender: TObject);
    procedure ConfiguraImpressoraClick(Sender: TObject);
    procedure OutroUsurioClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure CalendrioClick(Sender: TObject);
    procedure CalculadoraClick(Sender: TObject);
    procedure CascataClick(Sender: TObject);
    procedure HorizontalClick(Sender: TObject);
    procedure VerticalClick(Sender: TObject);
    procedure MinimizaTodasClick(Sender: TObject);
    procedure OrganizarconesClick(Sender: TObject);
    procedure ContedoClick(Sender: TObject);
    procedure TpicosdaAjudaClick(Sender: TObject);
    procedure SobreClick(Sender: TObject);
    procedure FormularioClick(Sender: TObject);
    procedure RotinaAvulsaClick(Sender: TObject);
    procedure ProgramaExternoEXEClick(Sender: TObject);
    procedure SeparacaoClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure ListaBotoesDblClick(Sender: TObject);
    procedure EdMensagemKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure BtnModificarClick(Sender: TObject);
    procedure FormataodeTabelas1Click(Sender: TObject);
    procedure AgendaClick(Sender: TObject);
    procedure AssistenteClick(Sender: TObject);
    procedure Ambiente1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaLista(ComTree:Boolean);
    procedure Inserir(Tipo: Integer);
    procedure PreProgramado(Tipo, Linha: Integer);
    procedure AtualizaTree;
  public
    { Public declarations }
  end;

var
  FormBarraF: TFormBarraF;

implementation

{$R *.DFM}

uses Rotinas, Princ, Gera_01;

procedure TFormBarraF.FormShow(Sender: TObject);
var
  I,QtLinhas: Integer;
begin
  FormPrincipal.Texto.Lines.Clear;
  if not (FileExists(ArqDefBarra)) then
    CopiaArquivo(Projeto.PastaGerador + 'Delphi\Barra.Tpl',ArqDefBarra);
  FormPrincipal.Texto.Lines.LoadFromFile(ArqDefBarra);
  //if FormPrincipal.Texto.Lines.Count < 05 then
  //begin
  //  FormPrincipal.Texto.Lines.Clear;
  //  FormPrincipal.Texto.Lines.Insert(0,'Nome Btn');
  //  FormPrincipal.Texto.Lines.Insert(1,'  Tipo = INTERNO 108');
  //  FormPrincipal.Texto.Lines.Insert(2,'  Mensagem = Finalizar Sistema');
  //  FormPrincipal.Texto.Lines.Insert(3,'  Imagem = 71');
  //  FormPrincipal.Texto.Lines.Insert(4,'  Programa = INTERNO108');
    {FormPrincipal.Texto.Lines.SaveToFile(ArqDefBarra);}
  //end;
  PageObject.ActivePageIndex := 0;
  ComboImagem.Items.Clear;
  ComboImagem.Items.AddObject('-1', Pointer(0));
  for I := 1 to FormPrincipal.ListaImagem.Count do
    ComboImagem.Items.AddObject(IntToStr(I-1), Pointer(I-1));
  ComboPrograma.Items.Add('');
  for I := 101 to 120 do
    ComboPrograma.Items.Add('INTERNO'+Strzero(I,03));

  FormPrincipal.Texto2.Lines.Clear;
  if FileExists(Projeto.ArquivoForm) then
    FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.ArquivoForm);
  QtLinhas := FormPrincipal.Texto2.Lines.Count-1;
  if QtLinhas < 5 then
  else
  begin
    I := 0;
    for I := 0 to QtLinhas do
    begin
      if Copy(FormPrincipal.Texto2.Lines[I],01,07) = 'Titulo:' then
        ComboPrograma.Items.Add(Copy(FormPrincipal.Texto2.Lines[I],09,08) + ' - ' + Trim(FormPrincipal.Texto2.Lines[I+2]));
    end;
  end;
  AtualizaLista(True);
  ListaBotoes.SetFocus;
end;

procedure TFormBarraF.ComboImagemDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  bitmap : tbitmap;
  offset : integer;
begin
  with (Control as TComboBox).Canvas do begin
    FillRect(Rect);
    Offset := 2;
    Bitmap:=TBitmap.Create;
    if FormPrincipal.ListaImagem <> nil then
       if index = 0 then
         BitMap := nil
       else
         FormPrincipal.ListaImagem.GetBitmap(LongInt((Control as TComboBox).Items.Objects[Index]),Bitmap);
    try
       if Bitmap <> nil then begin
         BrushCopy(Bounds(Rect.Left + 2, Rect.Top, Bitmap.Width, Bitmap.Height),
                   Bitmap,
                   Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                   clSilver); {clNavy}
         Offset := Bitmap.width + 8;
       end;
       TextOut(Rect.Left + Offset, Rect.Top, (Control as TComboBox).Items[Index])
    finally
       Bitmap.Free;
    end;
  end;
end;

procedure TFormBarraF.ComboImagemMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := 20;
end;

procedure TFormBarraF.ListaBotoesChange(Sender: TObject; Node: TTreeNode);
begin
  AtualizaTree;
end;

procedure TFormBarraF.AtualizaTree;
var
  I: Integer;
begin
  I := ListaBotoes.Selected.AbsoluteIndex-1;
  if I+1 > 0 then
  begin
    I := 05 * I +  I;
    EdMensagem.Text := Trim(Copy(FormPrincipal.Texto.Lines[I+02],Pos('=',FormPrincipal.Texto.Lines[I+02])+2,Length(FormPrincipal.Texto.Lines[I+02])));
    EdTitulo.Text   := Trim(Copy(FormPrincipal.Texto.Lines[I+05],Pos('=',FormPrincipal.Texto.Lines[I+05])+2,Length(FormPrincipal.Texto.Lines[I+05])));
    ComboImagem.ItemIndex   := ComboImagem.Items.IndexOf(Trim(Copy(FormPrincipal.Texto.Lines[I+03],Pos('=',FormPrincipal.Texto.Lines[I+03])+2,Length(FormPrincipal.Texto.Lines[I+03]))));
    ComboPrograma.ItemIndex := ComboPrograma.Items.IndexOf(Trim(Copy(FormPrincipal.Texto.Lines[I+04],Pos('=',FormPrincipal.Texto.Lines[I+04])+2,Length(FormPrincipal.Texto.Lines[I+04]))));
  end
  else
  begin
    EdMensagem.Text := '';
    EdTitulo.Text   := '';
    ComboImagem.ItemIndex   := -1;
    ComboPrograma.ItemIndex := -1;
  end;
end;

procedure TFormBarraF.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBarraF.ListaBotoesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then { Del }
    BtnDeletarClick(Self)
  else if Key = 45 then { Ins }
    BtnNovo.CheckMenuDropdown
  else if Key = 113 then { F2 }
    ListaBotoesDblClick(Self);
  //else if Key = 27 then { Esc }
  //  Close;
end;

procedure TFormBarraF.BtnDeletarClick(Sender: TObject);
var
   I,Y : Integer;
begin
  if ListaBotoes.Selected = nil then
  begin
    Mensagem('Posição não selecionada !',ModAdvertencia, [ModOk]);
    abort;
  end;
  if ListaBotoes.Selected.AbsoluteIndex = 0 then
    Abort;
  //if ListaBotoes.Items.Count = 2 then
  //begin
  //  Mensagem('A Barra deve possuir pelo menos um Botão !',ModAdvertencia, [ModOk]);
  //  abort;
  //end;
  I := ListaBotoes.Selected.AbsoluteIndex-1;
  if Mensagem('Deletar Botão ?',ModConfirmacao,[ModSim, ModNao]) = mrno then
     Abort;
  I := 05 * I +  I;
  for Y := 1 to 06 do
    FormPrincipal.Texto.Lines.Delete(I);
  {FormPrincipal.Texto.Lines.SaveToFile(ArqDefBarra);}
  {ListaBotoes.Items[ListaBotoes.Selected.AbsoluteIndex].Delete;}
  ListaBotoes.Items.Delete(ListaBotoes.Selected);
  {AtualizaLista;}
end;

procedure TFormBarraF.AtualizaLista(ComTree:Boolean);
var I, NrBtn, Imagem, QtLinhas: Integer;
    Mensagem, Programa: String;
begin
  NrBtn := 0;
  if ComTree then
  begin
    ListaBotoes.Items.Clear;
    //ListaBotoes.Items.Add(nil, 'Início ...');
    ListaBotoes.Items.Add(nil, '');
    ListaBotoes.Items[ListaBotoes.Items.Count-1].ImageIndex := 24;
    ListaBotoes.Items[ListaBotoes.Items.Count-1].SelectedIndex := 24;
  end;
  QtLinhas := FormPrincipal.Texto.Lines.Count-1;
  I := 0;
  while I <= QtLinhas do
  begin
    if Copy(Trim(FormPrincipal.Texto.Lines[I]),01,04) = 'Nome' then
    begin
      Programa := Trim(Copy(FormPrincipal.Texto.Lines[I+4],Pos('=',FormPrincipal.Texto.Lines[I+4])+2,Length(FormPrincipal.Texto.Lines[I+4])));
      if Programa = '' then
      begin
        FormPrincipal.Texto.Lines[I] := 'Nome Btn'+Strzero(NrBtn,03);
        Inc(NrBtn);
      end
      else
        FormPrincipal.Texto.Lines[I] := 'Nome Btn'+Programa;
      if ComTree then
      begin
        if Trim(Copy(FormPrincipal.Texto.Lines[I+3],Pos('=',FormPrincipal.Texto.Lines[I+3])+2,Length(FormPrincipal.Texto.Lines[I+3]))) <> '' then
          Imagem := StrToInt(Trim(Copy(FormPrincipal.Texto.Lines[I+3],Pos('=',FormPrincipal.Texto.Lines[I+3])+2,Length(FormPrincipal.Texto.Lines[I+3]))))
        else
          Imagem := -1;
        Mensagem := Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2])));
        ListaBotoes.Items.Add(nil, Mensagem);
        ListaBotoes.Items[ListaBotoes.Items.Count-1].ImageIndex := Imagem;
        ListaBotoes.Items[ListaBotoes.Items.Count-1].SelectedIndex := Imagem;
      end;
    end;
    I := I + 06;
  end;
end;

procedure TFormBarraF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormPrincipal.Texto.Lines.Clear;
end;

procedure TFormBarraF.Inserir(Tipo: Integer);
var
  I, Y: Integer;
  NodeAt: Integer;
  Titulo: String;
  Image: Integer;
  UltItem : Boolean;
begin
  if Listabotoes.Selected = nil then
  begin
    Mensagem('Posição não selecionada !',ModAdvertencia, [ModOk]);
    abort;
  end;
  UltItem := False;
  I := ListaBotoes.Selected.AbsoluteIndex-1;
  I := 05 * I +  I;
  I := I + 6;
  if FormPrincipal.Texto.Lines[I] = '' then
    UltItem := True;
  if Tipo >= 100 then
    PreProgramado(Tipo,I)
  else
  begin
    FormPrincipal.Texto.Lines.Insert(I,'Nome Btn');
    if Tipo = 1 then
      FormPrincipal.Texto.Lines.Insert(I+01,'  Tipo = FORMULARIO')
    else if Tipo = 2 then
      FormPrincipal.Texto.Lines.Insert(I+01,'  Tipo = AVULSO')
    else if Tipo = 3 then
      FormPrincipal.Texto.Lines.Insert(I+01,'  Tipo = EXE')
    else if Tipo = 4 then
      FormPrincipal.Texto.Lines.Insert(I+01,'  Tipo = SEPARACAO');
    FormPrincipal.Texto.Lines.Insert(I+02,'  Mensagem = ');
    FormPrincipal.Texto.Lines.Insert(I+03,'  Imagem = -1');
    FormPrincipal.Texto.Lines.Insert(I+04,'  Programa = ');
    FormPrincipal.Texto.Lines.Insert(I+05,'  Titulo = ');
    {FormPrincipal.Texto.Lines.SaveToFile(ArqDefBarra);}
  end;
  NodeAt := ListaBotoes.Selected.AbsoluteIndex + 1;
  I := ListaBotoes.Selected.AbsoluteIndex-1;
  I := 05 * I +  I;
  I := I + 06;
  {AtualizaLista;}
  Titulo := Trim(Copy(FormPrincipal.Texto.Lines[I+02],Pos('=',FormPrincipal.Texto.Lines[I+02])+2,Length(FormPrincipal.Texto.Lines[I+02])));
  if UltItem then
    ListaBotoes.Items.Add(ListaBotoes.Selected,Titulo)
  else
  begin
    ListaBotoes.Items[NodeAt].Selected := True;
    ListaBotoes.Items.Insert(ListaBotoes.Selected,Titulo);
  end;
  ListaBotoes.Items[NodeAt].Selected := True;
  Image := StrToIntDef(Trim(Copy(FormPrincipal.Texto.Lines[I+03],Pos('=',FormPrincipal.Texto.Lines[I+03])+2,Length(FormPrincipal.Texto.Lines[I+03]))),-1);
  ListaBotoes.Selected.ImageIndex := Image;
  ListaBotoes.Selected.SelectedIndex := Image;
  ListaBotoesDblClick(Self);
end;

procedure TFormBarraF.PreProgramado(Tipo, Linha: Integer);
var I : Integer;
    Tipo_Def : String;
    Posicao: Integer;
begin
  Posicao := 0;
  FormPrincipal.Texto2.Lines.Clear;
  FormPrincipal.Texto2.Lines.LoadFromFile(Projeto.PastaGerador + 'Delphi\Menu.Tpl');
  for I := 0 to FormPrincipal.Texto2.Lines.Count-1 do
  begin
    if Copy(Trim(FormPrincipal.Texto2.Lines[I]),01,04) = 'Nome' then
    begin
      Tipo_Def  := Trim(Copy(FormPrincipal.Texto2.Lines[I+1],Pos('=',FormPrincipal.Texto2.Lines[I+1])+2,Length(FormPrincipal.Texto2.Lines[I+1])));
      if UpperCase(Copy(Tipo_Def,01,07)) = 'INTERNO' then
        if StrToInt(Copy(UpperCase(Tipo_Def),09,03)) = Tipo then
          Posicao := I;
    end;
  end;
  if Posicao > 0 then
  begin
    FormPrincipal.Texto.Lines.Insert(Linha,'Nome Btn');
    FormPrincipal.Texto.Lines.Insert(Linha+01,'  Tipo = INTERNO '+IntToStr(Tipo));
    FormPrincipal.Texto.Lines.Insert(Linha+02,'  Mensagem = '+Trim(Copy(FormPrincipal.Texto2.Lines[Posicao+03],Pos('=',FormPrincipal.Texto2.Lines[Posicao+03])+2,Length(FormPrincipal.Texto2.Lines[Posicao+03]))));
    FormPrincipal.Texto.Lines.Insert(Linha+03,'  Imagem = '+Trim(Copy(FormPrincipal.Texto2.Lines[Posicao+04],Pos('=',FormPrincipal.Texto2.Lines[Posicao+04])+2,Length(FormPrincipal.Texto2.Lines[Posicao+04]))));
    FormPrincipal.Texto.Lines.Insert(Linha+04,'  Programa = '+Trim(Copy(FormPrincipal.Texto2.Lines[Posicao+06],Pos('=',FormPrincipal.Texto2.Lines[Posicao+06])+2,Length(FormPrincipal.Texto2.Lines[Posicao+06]))));
    FormPrincipal.Texto.Lines.Insert(Linha+05,'  Titulo = '+Trim(Copy(FormPrincipal.Texto2.Lines[Posicao+02],Pos('=',FormPrincipal.Texto2.Lines[Posicao+02])+2,Length(FormPrincipal.Texto2.Lines[Posicao+02]))));
    {FormPrincipal.Texto.Lines.SaveToFile(ArqDefBarra);}
  end
  else
  begin
    Mensagem('Rotina Interna não Encontrada !!!',ModAdvertencia,[ModOk]);
  end;
end;

procedure TFormBarraF.ConfiguraodeSenhasClick(Sender: TObject);
begin
 Inserir(101);
end;

procedure TFormBarraF.BasedeDadosClick(Sender: TObject);
begin
 Inserir(102);
end;

procedure TFormBarraF.CopiarClick(Sender: TObject);
begin
 Inserir(103);
end;

procedure TFormBarraF.RestaurarClick(Sender: TObject);
begin
 Inserir(104);
end;

procedure TFormBarraF.EmpresaUsuriaClick(Sender: TObject);
begin
 Inserir(102);
end;

procedure TFormBarraF.ConfiguraImpressoraClick(Sender: TObject);
begin
 Inserir(105);
end;

procedure TFormBarraF.OutroUsurioClick(Sender: TObject);
begin
 Inserir(106);
end;

procedure TFormBarraF.SairClick(Sender: TObject);
begin
 Inserir(107);
end;

procedure TFormBarraF.CalendrioClick(Sender: TObject);
begin
 Inserir(108);
end;

procedure TFormBarraF.CalculadoraClick(Sender: TObject);
begin
 Inserir(109);
end;

procedure TFormBarraF.CascataClick(Sender: TObject);
begin
 Inserir(112);
end;

procedure TFormBarraF.HorizontalClick(Sender: TObject);
begin
 Inserir(113);
end;

procedure TFormBarraF.VerticalClick(Sender: TObject);
begin
 Inserir(114);
end;

procedure TFormBarraF.MinimizaTodasClick(Sender: TObject);
begin
 Inserir(115);
end;

procedure TFormBarraF.OrganizarconesClick(Sender: TObject);
begin
 Inserir(116);
end;

procedure TFormBarraF.ContedoClick(Sender: TObject);
begin
 Inserir(117);
end;

procedure TFormBarraF.TpicosdaAjudaClick(Sender: TObject);
begin
 Inserir(118);
end;

procedure TFormBarraF.SobreClick(Sender: TObject);
begin
 Inserir(119);
end;

procedure TFormBarraF.FormularioClick(Sender: TObject);
begin
 Inserir(1);
end;

procedure TFormBarraF.RotinaAvulsaClick(Sender: TObject);
begin
 Inserir(2);
end;

procedure TFormBarraF.ProgramaExternoEXEClick(Sender: TObject);
begin
 Inserir(3);
end;

procedure TFormBarraF.SeparacaoClick(Sender: TObject);
begin
 Inserir(4);
end;

procedure TFormBarraF.BtnGravarClick(Sender: TObject);
begin
  AtualizaLista(False);
  FormPrincipal.Texto.Lines.SaveToFile(ArqDefBarra);
  Gera_Princ(False,2);
  Close;
end;

procedure TFormBarraF.ListaBotoesDblClick(Sender: TObject);
begin
  BtnModificarClick(Self);
end;

procedure TFormBarraF.EdMensagemKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
  {else if Key = #27 then
  begin
    Key := #0;
    Close;
  end;}
end;

procedure TFormBarraF.BtnAtualizarClick(Sender: TObject);
var I,Y: Integer;
    Tipo_p: String;
begin
  Y := ListaBotoes.Selected.AbsoluteIndex-1;
  Y := 05 * Y +  Y;

  Tipo_p := UpperCase(Trim(Copy(FormPrincipal.Texto.Lines[I+01],Pos('=',FormPrincipal.Texto.Lines[I+01])+2,Length(FormPrincipal.Texto.Lines[I+01]))));

  I := Y + 02;
  FormPrincipal.Texto.Lines[I] := Copy(FormPrincipal.Texto.Lines[I],01,Pos('=',FormPrincipal.Texto.Lines[I])) + ' ' + EdMensagem.Text;
  ListaBotoes.Selected.Text := EdMensagem.Text;

  I := Y + 03;
  FormPrincipal.Texto.Lines[I] := Copy(FormPrincipal.Texto.Lines[I],01,Pos('=',FormPrincipal.Texto.Lines[I])) + ' ' + ComboImagem.Text;
  ListaBotoes.Selected.ImageIndex := StrToInt(ComboImagem.Text);
  ListaBotoes.Selected.SelectedIndex := StrToInt(ComboImagem.Text);

  I := Y + 04;
  FormPrincipal.Texto.Lines[I] := Copy(FormPrincipal.Texto.Lines[I],01,Pos('=',FormPrincipal.Texto.Lines[I])) + ' ' + ComboPrograma.Text;

  I := Y + 05;
  FormPrincipal.Texto.Lines[I] := Copy(FormPrincipal.Texto.Lines[I],01,Pos('=',FormPrincipal.Texto.Lines[I])) + ' ' + EdTitulo.Text;

  BtnCancelaClick(Self);
end;

procedure TFormBarraF.BtnCancelaClick(Sender: TObject);
begin
  EdMensagem.Enabled    := False;
  EdTitulo.Enabled      := False;
  ComboImagem.Enabled   := False;
  ComboPrograma.Enabled := False;
  ListaBotoes.Enabled   := True;
  ToolBar.Enabled       := True;
  BtnAtualizar.Enabled  := False;
  BtnCancela.Enabled    := False;
  ListaBotoes.SetFocus;
  AtualizaTree;
end;

procedure TFormBarraF.BtnModificarClick(Sender: TObject);
var I,Y: Integer;
    Tipo_p: String;
begin
  I := ListaBotoes.Selected.AbsoluteIndex-1;
  if I+1 > 0 then
  begin
    I := 05 * I +  I;

    Tipo_p := UpperCase(Trim(Copy(FormPrincipal.Texto.Lines[I+01],Pos('=',FormPrincipal.Texto.Lines[I+01])+2,Length(FormPrincipal.Texto.Lines[I+01]))));
    if (Tipo_p <> 'SEPARACAO') then
    begin
      EdMensagem.Enabled  := True;
      EdTitulo.Enabled    := True;
      ComboImagem.Enabled := True;
      if (Copy(Tipo_p,01,07) = 'INTERNO') then
        ComboPrograma.Enabled := False
      else
        ComboPrograma.Enabled := True;
      ListaBotoes.Enabled := False;
      ToolBar.Enabled      := False;
      BtnAtualizar.Enabled := True;
      BtnCancela.Enabled   := True;
      EdTitulo.SetFocus;
    end;
  end;
end;

procedure TFormBarraF.FormataodeTabelas1Click(Sender: TObject);
begin
 Inserir(119);
end;

procedure TFormBarraF.AgendaClick(Sender: TObject);
begin
 Inserir(110);
end;

procedure TFormBarraF.AssistenteClick(Sender: TObject);
begin
 Inserir(111);
end;

procedure TFormBarraF.Ambiente1Click(Sender: TObject);
begin
 Inserir(120);
end;

end.
