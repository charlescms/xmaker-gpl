{
   Programa.: EdGrp.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit EdGrp;

interface

{$I Princ.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI5}{$ELSE}Variants,{$ENDIF}
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus, Tabs, Tabela, DB;

type
  TFormEdGrp = class(TForm)
    AcessoMenu: TRadioGroup;
    AcessoTabela: TGroupBox;
    BtnCancelar: TBitBtn;
    BtnGravar: TBitBtn;
    EdDescricao: TEdit;
    EdGrupo: TEdit;
    Excluir: TCheckBox;
    Filtrar: TCheckBox;
    Imprimir: TCheckBox;
    Incluir: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbTabelas: TListBox;
    Modificar: TCheckBox;
    Notebook1: TNotebook;
    PageUsuario: TPageControl;
    PagUsr: TTabSheet;
    PanelInf: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    ShapeOpcoes: TShape;
    TabSet1: TTabSet;
    Totalizar: TCheckBox;
    TreeBarra: TTreeView;
    TreeMenuSup: TTreeView;
    TreeOpcoes: TTreeView;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure TreeOpcoesChange(Sender: TObject; Node: TTreeNode);
    procedure lbTabelasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IncluirClick(Sender: TObject);
    procedure EdGrupoExit(Sender: TObject);
    procedure AcessoMenuClick(Sender: TObject);
    procedure TabSet1Click(Sender: TObject);
    procedure TreeMenuSupChange(Sender: TObject; Node: TTreeNode);
    procedure TreeBarraChange(Sender: TObject; Node: TTreeNode);
    procedure ModificarClick(Sender: TObject);
    procedure ExcluirClick(Sender: TObject);
    procedure FiltrarClick(Sender: TObject);
    procedure TotalizarClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaListas;
  public
    { Public declarations }
    NovoGrupo  : Boolean;
  end;

{$IFNDEF SENHA_DB}
Type
  TGrupo = record                     // Tabela de Grupos
           Grupo      : String[04];
           Descricao  : String[20];
           Ativo      : Boolean;
  end;
Type
  TOpcao = record                     // Tabela de Opções de Acesso
           Opcao      : Integer;
           Grupo      : String[04];
           PorSenha   : Boolean;
           Ativo      : Boolean;
  end;
Type
  TOpcao1= record                     // Tabela de Opções de Acesso
           Opcao      : Integer;
           Grupo      : String[04];
           PorSenha   : Boolean;
           Invisivel  : Boolean;
           Ativo      : Boolean;
  end;
Type
  TTabelaGrp = record                     // Tabela de Acesso a Tabelas
           Tabela     : String[20];
           Grupo      : String[04];
           Cerceado   : String[10];
           Ativo      : Boolean;
  end;
{$ENDIF}

var
  FormEdGrp: TFormEdGrp;
  Posicao    : Integer;
  {$IFNDEF SENHA_DB}
  TabGrupo   : file of TGrupo;
  TabOpcao   : file of TOpcao;
  TabTabela  : file of TTabelaGrp;
  TabMenuSup : file of TOpcao1;
  TabBarra   : file of TOpcao1;
  CmpGrupo   : TGrupo;
  CmpOpcao   : TOpcao;
  CmpTabela  : TTabelaGrp;
  CmpMenuSup : TOpcao1;
  CmpBarra   : TOpcao1;
  {$ENDIF}
  ListaOpTab : TStringList;
  ListaPsTab : TStringList;
  ListaOpMenu: TStringList;
  ListaPsMenu: TStringList;
  ListaOpMenuSup: TStringList;
  ListaPsMenuSup: TStringList;
  ListaOpBarra: TStringList;
  ListaPSBarra: TStringList;
  Gravou     : Boolean;
  AtLista    : Boolean;

implementation

{$R *.DFM}

uses Rotinas, Publicas, Senhas, Abertura, Princ;

procedure TFormEdGrp.FormShow(Sender: TObject);
var
  I: Integer;
  Botao: TToolButton;
begin
  TreeBarra.Items.Clear;
  for I:=0 to FormPrincipal.BarraFerramentas.ButtonCount-1 do
  begin
    Botao := FormPrincipal.BarraFerramentas.Buttons[I];
    TreeBarra.Items.AddObject(Nil, Botao.Caption,TObject(Botao.Tag));
    TreeBarra.Items[TreeBarra.Items.Count-1].ImageIndex := Botao.ImageIndex;
    TreeBarra.Items[TreeBarra.Items.Count-1].SelectedIndex := Botao.ImageIndex;
  end;
  TreeMenuSup.Items := FormPrincipal.TreeMenuSup.Items;
  TreeMenuSup.FullExpand;

  if not Sistema.MenuVertical then
    TabSet1.Tabs.Delete(0);
  if not Sistema.BarraF then
    TabSet1.Tabs.Delete(TabSet1.Tabs.Count-1);
  TabSet1Click(Self);
  TreeOpcoes.Items := Sistema.Menu.Items;
  ListaOpTab       := TStringList.Create;
  ListaPsTab       := TStringList.Create;
  ListaOpMenu      := TStringList.Create;
  ListaPsMenu      := TStringList.Create;
  ListaOpMenuSup   := TStringList.Create;
  ListaPsMenuSup   := TStringList.Create;
  ListaOpBarra     := TStringList.Create;
  ListaPsBarra     := TStringList.Create;
  Gravou           := False;
  AtLista          := False;
  ListaOpTab.Clear;
  ListaPsTab.Clear;
  ListaOpMenu.Clear;
  ListaPsMenu.Clear;
  ListaOpMenuSup.Clear;
  ListaPsMenuSup.Clear;
  ListaOpBarra.Clear;
  ListaPsBarra.Clear;
  lbTabelas.Items.Clear;
  {$IFDEF SENHA_DB}
  EdGrupo.Text      := TabGlobal.DUSER_GRUPOS.Grupo.Conteudo;
  EdDescricao.Text  := TabGlobal.DUSER_GRUPOS.Descricao.Conteudo;
  TabGlobal.DUSER_MENU_LATERAL.Filtro.Clear;
  TabGlobal.DUSER_MENU_SUPERIOR.Filtro.Clear;
  TabGlobal.DUSER_BARRA_F.Filtro.Clear;
  TabGlobal.DUSER_TABELAS.Filtro.Clear;

  TabGlobal.DUSER_MENU_LATERAL.AtualizaSql;
  TabGlobal.DUSER_MENU_SUPERIOR.AtualizaSql;
  TabGlobal.DUSER_BARRA_F.AtualizaSql;
  TabGlobal.DUSER_TABELAS.AtualizaSql;
  {$ELSE}
  {$I-}
  Posicao := StrToInt(FormSenhas.PosicaoGrp[FormSenhas.lbGrupos.ItemIndex]);
  assignFile(TabGrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Usuários
  reset(TabGrupo);
  seek(TabGrupo,Posicao);
  Read(TabGrupo,CmpGrupo);
  EdGrupo.Text      := CmpGrupo.Grupo;
  EdDescricao.Text  := CmpGrupo.Descricao;
  closefile(TabGrupo);
  {$I+}
  {$ENDIF}

  AtualizaListas;
  if Sistema.MenuVertical then
  begin
    TreeOpcoes.FullExpand;
    if TreeOpcoes.Items.Count > 0 then
    begin
      TreeOpcoes.Items[0].Selected := True;
      TreeOpcoesChange(Self,Nil);
    end;
  end;
  if lbTabelas.Items.Count > 0 then
  begin
    lbTabelas.ItemIndex := 0;
    lbTabelasClick(Self);
  end;
  if NovoGrupo then
  begin
    EdGrupo.SelectAll;
    EdGrupo.SetFocus;
  end
  else
  begin
    EdGrupo.Color      := clBtnFace;
    EdGrupo.Font.Color := ClBlue;
    EdGrupo.ReadOnly   := True;
    EdGrupo.TabStop    := False;
    EdDescricao.SelectAll;
    EdDescricao.SetFocus;
  end;
end;

procedure TFormEdGrp.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  I, PosDat: Integer;
begin
  if (NovoGrupo) and (not Gravou) then
  begin
    {$IFDEF SENHA_DB}
    TabGlobal.DUSER_GRUPOS.Modifica;
    TabGlobal.DUSER_GRUPOS.Grupo.Conteudo     := EdGrupo.Text;
    TabGlobal.DUSER_GRUPOS.Descricao.Conteudo := EdDescricao.Text;
    TabGlobal.DUSER_GRUPOS.Salva;
    {if AtLista then
      for I := 0 to lbTabelas.Items.Count-1 do
      begin
        TabGlobal.DUSER_TABELAS.Filtro.Text := 'tabela_obj = '+#39+TTabela(Lst_Tabelas[I]).Name+#39;
        TabGlobal.DUSER_TABELAS.AtualizaSql;
        while not TabGlobal.DUSER_TABELAS.Eof do
        begin
          TabGlobal.DUSER_TABELAS.Modifica;
          TabGlobal.DUSER_TABELAS.Tabela_Obj.Conteudo := TTabela(Lst_Tabelas[I]).Name;
          TabGlobal.DUSER_TABELAS.Grupo.Conteudo      := EdGrupo.Text;
          TabGlobal.DUSER_TABELAS.Cerceado.Conteudo   := ListaOpTab[I];
          TabGlobal.DUSER_TABELAS.Salva;
          TabGlobal.DUSER_TABELAS.Next;
        end;
      end;}
    {$ELSE}
    {$I-}
    assignFile(Tabgrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Grupos
    reset(Tabgrupo);
    seek(Tabgrupo,Posicao);
    Read(Tabgrupo,Cmpgrupo);
    CmpGrupo.Grupo     := EdGrupo.Text;
    CmpGrupo.Descricao := EdDescricao.Text;
    CmpGrupo.Ativo     := False;
    seek(Tabgrupo,Posicao);
    write(Tabgrupo,Cmpgrupo);
    closefile(Tabgrupo);

    if AtLista then
    begin
      assignFile(TabTabela,Sistema.Pasta + 'SYSTAB.DAT'); // Tabelas
      reset(TabTabela);
      for I := 0 to lbTabelas.Items.Count-1 do
      begin
        PosDat := StrToInt(ListaPsTab[I]);
        seek(TabTabela,PosDat);
        Read(TabTabela,CmpTabela);
        CmpTabela.Tabela   := TTabela(Lst_Tabelas[I]).Name;
        CmpTabela.Grupo    := Trim(EdGrupo.Text);
        CmpTabela.Cerceado := ListaOpTab[I];
        CmpTabela.Ativo    := False;
        seek(TabTabela,PosDat);
        write(TabTabela,CmpTabela);
      end;
      closefile(TabTabela);
    end;
    {$I+}
    {$ENDIF}
  end;
  ListaOpTab.Free;
  ListaPsTab.Free;
  ListaOpMenu.Free;
  ListaPsMenu.Free;
  ListaOpMenuSup.Free;
  ListaPsMenuSup.Free;
  ListaOpBarra.Free;
  ListaPsBarra.Free;
end;

procedure TFormEdGrp.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end
  else if Key = Chr(27) then
    Close;
end;

procedure TFormEdGrp.AtualizaListas;
Var
  I,PosDat: Integer;
  Achou: Boolean;
begin
  {$IFDEF SENHA_DB}
  lbTabelas.Items.Clear;
  for I:=0 to Lst_Tabelas.Count-1 do
  begin
    if TTabela(Lst_Tabelas[I]).TableType = ttTable then
    begin
      lbTabelas.Items.Add(TTabela(Lst_Tabelas[I]).Titulo);
      TabGlobal.DUSER_TABELAS.First;
      if TabGlobal.DUSER_TABELAS.Locate('tabela_obj;grupo',VarArrayOf([TTabela(Lst_Tabelas[I]).Name, EdGrupo.Text]), [loCaseInsensitive]) then
        ListaOpTab.Add(TabGlobal.DUSER_TABELAS.Cerceado.Conteudo)
      else
      begin
        TabGlobal.DUSER_TABELAS.Inclui(Nil);
        TabGlobal.DUSER_TABELAS.Tabela_Obj.Conteudo := TTabela(Lst_Tabelas[I]).Name;
        TabGlobal.DUSER_TABELAS.Grupo.Conteudo      := Trim(EdGrupo.Text);
        TabGlobal.DUSER_TABELAS.Cerceado.Conteudo   := '';
        TabGlobal.DUSER_TABELAS.Salva;
        ListaOpTab.Add('');
      end;
    end;
  end;

  for I:=0 to TreeOpcoes.Items.Count-1 do
  begin
    TabGlobal.DUSER_MENU_LATERAL.First;
    if TabGlobal.DUSER_MENU_LATERAL.Locate('opcao;grupo',VarArrayOf([IntToStr(Integer(TreeOpcoes.Items[I].Data)), EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      if TabGlobal.DUSER_MENU_LATERAL.PorSenha.Conteudo = 'S' then
        ListaOpMenu.Add('S'+IntToStr(TabGlobal.DUSER_MENU_LATERAL.Opcao.Conteudo))
      else
        ListaOpMenu.Add('N'+IntToStr(TabGlobal.DUSER_MENU_LATERAL.Opcao.Conteudo));
    end
    else
    begin
      TabGlobal.DUSER_MENU_LATERAL.Inclui(Nil);
      TabGlobal.DUSER_MENU_LATERAL.Opcao.Conteudo    := Integer(TreeOpcoes.Items[I].Data);
      TabGlobal.DUSER_MENU_LATERAL.Grupo.Conteudo    := Trim(EdGrupo.Text);
      TabGlobal.DUSER_MENU_LATERAL.PorSenha.Conteudo := 'N';
      TabGlobal.DUSER_MENU_LATERAL.Salva;
      ListaOpMenu.Add('N'+IntToStr(Integer(TreeOpcoes.Items[I].Data)));
    end;
  end;

  for I:=0 to TreeMenuSup.Items.Count-1 do
  begin
    TabGlobal.DUSER_MENU_SUPERIOR.First;
    if TabGlobal.DUSER_MENU_SUPERIOR.Locate('opcao;grupo',VarArrayOf([IntToStr(Integer(TreeMenuSup.Items[I].Data)), EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      if TabGlobal.DUSER_MENU_SUPERIOR.Invisivel.Conteudo = 'S' then
        ListaOpMenuSup.Add('I'+IntToStr(TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo))
      else
      begin
        if TabGlobal.DUSER_MENU_SUPERIOR.PorSenha.Conteudo = 'S' then
          ListaOpMenuSup.Add('S'+IntToStr(TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo))
        else
          ListaOpMenuSup.Add('N'+IntToStr(TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo));
      end;
    end
    else
    begin
      TabGlobal.DUSER_MENU_SUPERIOR.Inclui(Nil);
      TabGlobal.DUSER_MENU_SUPERIOR.Opcao.Conteudo     := Integer(TreeMenuSup.Items[I].Data);
      TabGlobal.DUSER_MENU_SUPERIOR.Grupo.Conteudo     := Trim(EdGrupo.Text);
      TabGlobal.DUSER_MENU_SUPERIOR.PorSenha.Conteudo  := 'N';
      TabGlobal.DUSER_MENU_SUPERIOR.Invisivel.Conteudo := 'N';
      TabGlobal.DUSER_MENU_SUPERIOR.Salva;
      ListaOpMenuSup.Add('N'+IntToStr(Integer(TreeMenuSup.Items[I].Data)));
    end;
  end;

  for I:=0 to TreeBarra.Items.Count-1 do
  begin
    TabGlobal.DUSER_BARRA_F.First;
    if TabGlobal.DUSER_BARRA_F.Locate('opcao;grupo',VarArrayOf([IntToStr(Integer(TreeBarra.Items[I].Data)), EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      if TabGlobal.DUSER_BARRA_F.Invisivel.Conteudo = 'S' then
        ListaOpBarra.Add('I'+IntToStr(TabGlobal.DUSER_BARRA_F.Opcao.Conteudo))
      else
      begin
        if TabGlobal.DUSER_BARRA_F.PorSenha.Conteudo = 'S' then
          ListaOpBarra.Add('S'+IntToStr(TabGlobal.DUSER_BARRA_F.Opcao.Conteudo))
        else
          ListaOpBarra.Add('N'+IntToStr(TabGlobal.DUSER_BARRA_F.Opcao.Conteudo));
      end;
    end
    else
    begin
      TabGlobal.DUSER_BARRA_F.Inclui(Nil);
      TabGlobal.DUSER_BARRA_F.Opcao.Conteudo     := Integer(TreeBarra.Items[I].Data);
      TabGlobal.DUSER_BARRA_F.Grupo.Conteudo     := Trim(EdGrupo.Text);
      TabGlobal.DUSER_BARRA_F.PorSenha.Conteudo  := 'N';
      TabGlobal.DUSER_BARRA_F.Invisivel.Conteudo := 'N';
      TabGlobal.DUSER_BARRA_F.Salva;
      ListaOpBarra.Add('N'+IntToStr(Integer(TreeBarra.Items[I].Data)));
    end;
  end;
  {$ELSE}
  {$I-}
  assignFile(TabTabela,Sistema.Pasta + 'SYSTAB.DAT'); // Tabelas
  reset(TabTabela);
  lbTabelas.Items.Clear;
  for I:=0 to Lst_Tabelas.Count-1 do
  begin
    if TTabela(Lst_Tabelas[I]).TableType = ttTable then
    begin
      lbTabelas.Items.Add(PadR(TTabela(Lst_Tabelas[I]).Name,08) + ' - ' +TTabela(Lst_Tabelas[I]).Titulo);
      Achou  := False;
      PosDat := 0;
      seek(TabTabela,PosDat);
      while (not Eof(TabTabela)) and (not Achou) do
      Begin
        Read(TabTabela,CmpTabela);
        if (Trim(CmpTabela.Tabela) = TTabela(Lst_Tabelas[I]).Name) and
           (Trim(CmpTabela.Grupo) = Trim(EdGrupo.Text)) and
           (CmpTabela.Ativo) then
        begin
          ListaOpTab.Add(CmpTabela.Cerceado);
          ListaPsTab.Add(IntToStr(PosDat));
          Achou := True;
        end;
        Inc(PosDat);
        seek(TabTabela,PosDat);
     end;   
    end;
    if not Achou then
    begin
      PosDat := FileSize(TabTabela);
      seek(TabTabela,PosDat);
      Read(TabTabela,CmpTabela);
      CmpTabela.Tabela   := TTabela(Lst_Tabelas[I]).Name;
      CmpTabela.Grupo    := Trim(EdGrupo.Text);
      CmpTabela.Cerceado := '';
      CmpTabela.Ativo    := True;
      seek(TabTabela,PosDat);
      write(TabTabela,CmpTabela);
      ListaOpTab.Add('');
      ListaPsTab.Add(IntToStr(PosDat));
    end;
  end;
  closefile(TabTabela);

  assignFile(TabOpcao,Sistema.Pasta + 'SYSOPC.DAT'); // Opções Acesso do Menu Lateral
  reset(TabOpcao);
  for I:=0 to TreeOpcoes.Items.Count-1 do
  begin
    Achou  := False;
    PosDat := 0;
    seek(TabOpcao,PosDat);
    while (not Eof(TabOpcao)) and (not Achou) do
    Begin
      Read(TabOpcao,CmpOpcao);
      if (CmpOpcao.Opcao = Integer(TreeOpcoes.Items[I].Data)) and
         (Trim(CmpOpcao.Grupo) = Trim(EdGrupo.Text)) and
         (CmpOpcao.Ativo) then
      begin
        if CmpOpcao.PorSenha then
          ListaOpMenu.Add('S'+IntToStr(CmpOpcao.Opcao))
        else
          ListaOpMenu.Add('N'+IntToStr(CmpOpcao.Opcao));
        ListaPsMenu.Add(IntToStr(PosDat));
        Achou := True;
      end;
      Inc(PosDat);
      seek(TabOpcao,PosDat);
    end;
    if not Achou then
    begin
      PosDat := FileSize(TabOpcao);
      seek(TabOpcao,PosDat);
      Read(TabOpcao,CmpOpcao);
      CmpOpcao.Opcao     := Integer(TreeOpcoes.Items[I].Data);
      CmpOpcao.Grupo     := Trim(EdGrupo.Text);
      CmpOpcao.PorSenha  := False;
      CmpOpcao.Ativo     := True;
      seek(TabOpcao,PosDat);
      write(TabOpcao,CmpOpcao);
      ListaOpMenu.Add('N'+IntToStr(Integer(TreeOpcoes.Items[I].Data)));
      ListaPsMenu.Add(IntToStr(PosDat));
    end;
  end;
  closefile(TabOpcao);

  assignFile(TabMenuSup,Sistema.Pasta + 'SYSMNU.DAT'); // Opções Acesso do Menu Superior
  reset(TabMenuSup);
  for I:=0 to TreeMenuSup.Items.Count-1 do
  begin
    Achou  := False;
    PosDat := 0;
    seek(TabMenuSup,PosDat);
    while (not Eof(TabMenuSup)) and (not Achou) do
    Begin
      Read(TabMenuSup,CmpMenuSup);
      if (CmpMenuSup.Opcao = Integer(TreeMenuSup.Items[I].Data)) and
         (Trim(CmpMenuSup.Grupo) = Trim(EdGrupo.Text)) and
         (CmpMenuSup.Ativo) then
      begin
        if CmpMenuSup.Invisivel then
          ListaOpMenuSup.Add('I'+IntToStr(CmpMenuSup.Opcao))
        else
          if CmpMenuSup.PorSenha then
            ListaOpMenuSup.Add('S'+IntToStr(CmpMenuSup.Opcao))
          else
            ListaOpMenuSup.Add('N'+IntToStr(CmpMenuSup.Opcao));
        ListaPsMenuSup.Add(IntToStr(PosDat));
        Achou := True;
      end;
      Inc(PosDat);
      seek(TabMenuSup,PosDat);
    end;
    if not Achou then
    begin
      PosDat := FileSize(TabMenuSup);
      seek(TabMenuSup,PosDat);
      Read(TabMenuSup,CmpMenuSup);
      CmpMenuSup.Opcao     := Integer(TreeMenuSup.Items[I].Data);
      CmpMenuSup.Grupo     := Trim(EdGrupo.Text);
      CmpMenuSup.PorSenha  := False;
      CmpMenuSup.Invisivel := False;
      CmpMenuSup.Ativo     := True;
      seek(TabMenuSup,PosDat);
      write(TabMenuSup,CmpMenuSup);
      ListaOpMenuSup.Add('N'+IntToStr(Integer(TreeMenuSup.Items[I].Data)));
      ListaPsMenuSup.Add(IntToStr(PosDat));
    end;
  end;
  closefile(TabMenuSup);

  assignFile(TabBarra,Sistema.Pasta + 'SYSBAR.DAT'); // Opções Acesso da Barra de Ferramentas
  reset(TabBarra);
  for I:=0 to TreeBarra.Items.Count-1 do
  begin
    Achou  := False;
    PosDat := 0;
    seek(TabBarra,PosDat);
    while (not Eof(TabBarra)) and (not Achou) do
    Begin
      Read(TabBarra,CmpBarra);
      if (CmpBarra.Opcao = Integer(TreeBarra.Items[I].Data)) and
         (Trim(CmpBarra.Grupo) = Trim(EdGrupo.Text)) and
         (CmpBarra.Ativo) then
      begin
        if CmpBarra.Invisivel then
          ListaOpBarra.Add('I'+IntToStr(CmpBarra.Opcao))
        else
          if CmpBarra.PorSenha then
            ListaOpBarra.Add('S'+IntToStr(CmpBarra.Opcao))
          else
            ListaOpBarra.Add('N'+IntToStr(CmpBarra.Opcao));
        ListaPsBarra.Add(IntToStr(PosDat));
        Achou := True;
      end;
      Inc(PosDat);
      seek(TabBarra,PosDat);
    end;
    if not Achou then
    begin
      PosDat := FileSize(TabBarra);
      seek(TabBarra,PosDat);
      Read(TabBarra,CmpBarra);
      CmpBarra.Opcao     := Integer(TreeBarra.Items[I].Data);
      CmpBarra.Grupo     := Trim(EdGrupo.Text);
      CmpBarra.PorSenha  := False;
      CmpBarra.Invisivel := False;
      CmpBarra.Ativo     := True;
      seek(TabBarra,PosDat);
      write(TabBarra,CmpBarra);
      ListaOpBarra.Add('N'+IntToStr(Integer(TreeBarra.Items[I].Data)));
      ListaPsBarra.Add(IntToStr(PosDat));
    end;
  end;
  closefile(TabBarra);
  {$I+}
  {$ENDIF}
  AtLista := True;
end;

procedure TFormEdGrp.BtnGravarClick(Sender: TObject);
Var
  I, PosDat: Integer;
begin
  Screen.Cursor := crHourGlass;
  {$IFDEF SENHA_DB}
  TabGlobal.DUSER_GRUPOS.Modifica;
  TabGlobal.DUSER_GRUPOS.Grupo.Conteudo     := EdGrupo.Text;
  TabGlobal.DUSER_GRUPOS.Descricao.Conteudo := EdDescricao.Text;
  TabGlobal.DUSER_GRUPOS.Salva;

  for I := 0 to lbTabelas.Items.Count-1 do
  begin
    TabGlobal.DUSER_TABELAS.First;
    if TabGlobal.DUSER_TABELAS.Locate('tabela_obj;grupo',VarArrayOf([TTabela(Lst_Tabelas[I]).Name, EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      TabGlobal.DUSER_TABELAS.Modifica;
      TabGlobal.DUSER_TABELAS.Cerceado.Conteudo := ListaOpTab[I];
      TabGlobal.DUSER_TABELAS.Salva;
    end;
  end;

  for I := 0 to TreeOpcoes.Items.Count-1 do
  begin
    TabGlobal.DUSER_MENU_LATERAL.First;
    if TabGlobal.DUSER_MENU_LATERAL.Locate('opcao;grupo',VarArrayOf([IntToStr(Integer(TreeOpcoes.Items[I].Data)), EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      TabGlobal.DUSER_MENU_LATERAL.Modifica;
      TabGlobal.DUSER_MENU_LATERAL.PorSenha.Conteudo := Copy(ListaOpMenu[I],01,01);
      TabGlobal.DUSER_MENU_LATERAL.Salva;
    end;
  end;

  for I := 0 to TreeMenuSup.Items.Count-1 do
  begin
    TabGlobal.DUSER_MENU_SUPERIOR.First;
    if TabGlobal.DUSER_MENU_SUPERIOR.Locate('opcao;grupo',VarArrayOf([IntToStr(Integer(TreeMenuSup.Items[I].Data)), EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      TabGlobal.DUSER_MENU_SUPERIOR.Modifica;
      if Copy(ListaOpMenuSup[I],01,01) = 'I' then
      begin
        TabGlobal.DUSER_MENU_SUPERIOR.PorSenha.Conteudo  := 'N';
        TabGlobal.DUSER_MENU_SUPERIOR.Invisivel.Conteudo := 'S'
      end
      else
      begin
        TabGlobal.DUSER_MENU_SUPERIOR.PorSenha.Conteudo := Copy(ListaOpMenuSup[I],01,01);
        TabGlobal.DUSER_MENU_SUPERIOR.Invisivel.Conteudo := 'N';
      end;
      TabGlobal.DUSER_MENU_SUPERIOR.Salva;
    end;
  end;

  for I := 0 to TreeBarra.Items.Count-1 do
  begin
    TabGlobal.DUSER_BARRA_F.First;
    if TabGlobal.DUSER_BARRA_F.Locate('opcao;grupo',VarArrayOf([IntToStr(Integer(TreeBarra.Items[I].Data)), EdGrupo.Text]), [loCaseInsensitive]) then
    begin
      TabGlobal.DUSER_BARRA_F.Modifica;
      if Copy(ListaOpBarra[I],01,01) = 'I' then
      begin
        TabGlobal.DUSER_BARRA_F.PorSenha.Conteudo := 'N';
        TabGlobal.DUSER_BARRA_F.Invisivel.Conteudo := 'S';
      end
      else
      begin
        TabGlobal.DUSER_BARRA_F.PorSenha.Conteudo := Copy(ListaOpBarra[I],01,01);
        TabGlobal.DUSER_BARRA_F.Invisivel.Conteudo := 'N';
      end;
      TabGlobal.DUSER_BARRA_F.Salva;
    end;
  end;
  {$ELSE}
  {$I-}
  assignFile(Tabgrupo,Sistema.Pasta + 'SYSGRP.DAT'); // Grupos
  reset(Tabgrupo);
  seek(Tabgrupo,Posicao);
  Read(Tabgrupo,Cmpgrupo);
  CmpGrupo.Grupo     := EdGrupo.Text;
  CmpGrupo.Descricao := EdDescricao.Text;
  CmpGrupo.Ativo     := True;
  seek(Tabgrupo,Posicao);
  write(Tabgrupo,Cmpgrupo);
  closefile(Tabgrupo);

  assignFile(TabTabela,Sistema.Pasta + 'SYSTAB.DAT'); // Tabelas
  reset(TabTabela);
  for I := 0 to lbTabelas.Items.Count-1 do
  begin
    PosDat := StrToInt(ListaPsTab[I]);
    seek(TabTabela,PosDat);
    Read(TabTabela,CmpTabela);
    CmpTabela.Tabela   := TTabela(Lst_Tabelas[I]).Name;
    CmpTabela.Grupo    := Trim(EdGrupo.Text);
    CmpTabela.Cerceado := ListaOpTab[I];
    CmpTabela.Ativo    := True;
    seek(TabTabela,PosDat);
    write(TabTabela,CmpTabela);
  end;
  closefile(TabTabela);

  assignFile(TabOpcao,Sistema.Pasta + 'SYSOPC.DAT'); // Opções de Acesso do Menu Lateral
  reset(TabOpcao);
  for I := 0 to TreeOpcoes.Items.Count-1 do
  begin
    PosDat := StrToInt(ListaPsMenu[I]);
    seek(TabOpcao,PosDat);
    Read(TabOpcao,CmpOpcao);
    CmpOpcao.Opcao     := Integer(TreeOpcoes.Items[I].Data);
    CmpOpcao.Grupo     := Trim(EdGrupo.Text);
    if Copy(ListaOpMenu[I],01,01) = 'S' then
      CmpOpcao.PorSenha := True
    else
      CmpOpcao.PorSenha := False;
    CmpOpcao.Ativo     := True;
    seek(TabOpcao,PosDat);
    write(TabOpcao,CmpOpcao);
  end;
  closefile(TabOpcao);

  assignFile(TabMenuSup,Sistema.Pasta + 'SYSMNU.DAT'); // Opções de Acesso do Menu Superior
  reset(TabMenuSup);
  for I := 0 to TreeMenuSup.Items.Count-1 do
  begin
    PosDat := StrToInt(ListaPsMenuSup[I]);
    seek(TabMenuSup,PosDat);
    Read(TabMenuSup,CmpMenuSup);
    CmpMenuSup.Opcao := Integer(TreeMenuSup.Items[I].Data);
    CmpMenuSup.Grupo := Trim(EdGrupo.Text);
    if Copy(ListaOpMenuSup[I],01,01) = 'I' then
    begin
      CmpMenuSup.Invisivel := True;
      CmpMenuSup.PorSenha  := False;
    end
    else
    begin
      CmpMenuSup.Invisivel := False;
      if Copy(ListaOpMenuSup[I],01,01) = 'S' then
        CmpMenuSup.PorSenha := True
      else
        CmpMenuSup.PorSenha := False;
    end;
    CmpMenuSup.Ativo     := True;
    seek(TabMenuSup,PosDat);
    write(TabMenuSup,CmpMenuSup);
  end;
  closefile(TabMenuSup);

  assignFile(TabBarra,Sistema.Pasta + 'SYSBAR.DAT'); // Opções de Acesso da Barra de Ferramentas
  reset(TabBarra);
  for I := 0 to TreeBarra.Items.Count-1 do
  begin
    PosDat := StrToInt(ListaPsBarra[I]);
    seek(TabBarra,PosDat);
    Read(TabBarra,CmpBarra);
    CmpBarra.Opcao := Integer(TreeBarra.Items[I].Data);
    CmpBarra.Grupo := Trim(EdGrupo.Text);
    if Copy(ListaOpBarra[I],01,01) = 'I' then
    begin
      CmpBarra.Invisivel := True;
      CmpBarra.PorSenha  := False;
    end
    else
    begin
      CmpBarra.Invisivel := False;
      if Copy(ListaOpBarra[I],01,01) = 'S' then
        CmpBarra.PorSenha := True
      else
        CmpBarra.PorSenha := False;
    end;
    CmpBarra.Ativo     := True;
    seek(TabBarra,PosDat);
    write(TabBarra,CmpBarra);
  end;
  closefile(TabBarra);
  {$I+}
  {$ENDIF}
  Gravou := True;
  Screen.Cursor := crDefault;
  Close;
end;

procedure TFormEdGrp.TreeOpcoesChange(Sender: TObject; Node: TTreeNode);
begin
  case Notebook1.PageIndex of
    0 : begin
          if Copy(ListaOpMenu[TreeOpcoes.Selected.AbsoluteIndex],01,01) = 'S' then
            AcessoMenu.ItemIndex := 1
          else
            AcessoMenu.ItemIndex := 0;
        end;
    1 : begin
          if Copy(ListaOpMenuSup[TreeMenuSup.Selected.AbsoluteIndex],01,01) = 'S' then
            AcessoMenu.ItemIndex := 1
          else if Copy(ListaOpMenuSup[TreeMenuSup.Selected.AbsoluteIndex],01,01) = 'I' then
            AcessoMenu.ItemIndex := 2
          else
            AcessoMenu.ItemIndex := 0;
        end;
    2 : begin
          if Copy(ListaOpBarra[TreeBarra.Selected.AbsoluteIndex],01,01) = 'S' then
            AcessoMenu.ItemIndex := 1
          else if Copy(ListaOpBarra[TreeBarra.Selected.AbsoluteIndex],01,01) = 'I' then
            AcessoMenu.ItemIndex := 2
          else
            AcessoMenu.ItemIndex := 0;
        end;
  end;
end;

procedure TFormEdGrp.lbTabelasClick(Sender: TObject);
begin
  if Pos('I',ListaOpTab[lbTabelas.ItemIndex]) > 0 then
    Incluir.Checked := True
  else
    Incluir.Checked := False;
  if Pos('M',ListaOpTab[lbTabelas.ItemIndex]) > 0 then
    Modificar.Checked := True
  else
    Modificar.Checked := False;
  if Pos('E',ListaOpTab[lbTabelas.ItemIndex]) > 0 then
    Excluir.Checked := True
  else
    Excluir.Checked := False;
  if Pos('F',ListaOpTab[lbTabelas.ItemIndex]) > 0 then
    Filtrar.Checked := True
  else
    Filtrar.Checked := False;
  if Pos('T',ListaOpTab[lbTabelas.ItemIndex]) > 0 then
    Totalizar.Checked := True
  else
    Totalizar.Checked := False;
  if Pos('L',ListaOpTab[lbTabelas.ItemIndex]) > 0 then
    Imprimir.Checked := True
  else
    Imprimir.Checked := False;
end;

procedure TFormEdGrp.IncluirClick(Sender: TObject);
Var
  Letra,Cerceado: String;
  PosLt: Integer;
begin
  if lbTabelas.ItemIndex < 0 then
    exit;
  Letra    := TCheckBox(Sender).Caption[1];
  PosLt    := Pos(Letra,ListaOpTab[lbTabelas.ItemIndex]);
  Cerceado := ListaOpTab[lbTabelas.ItemIndex];
  if TCheckBox(Sender).Checked then
  begin
    if PosLt < 1 then
      ListaOpTab[lbTabelas.ItemIndex] := Trim(Cerceado) + Letra;
  end
  else
    if PosLt > 0 then
      ListaOpTab[lbTabelas.ItemIndex] := Copy(Cerceado,01,PosLt-1) + Copy(Cerceado,PosLt+1,10);
  LbTabelas.SetFocus;
end;

procedure TFormEdGrp.EdGrupoExit(Sender: TObject);
Var
  I: Integer;
  Ok: Boolean;
begin
  if ActiveControl = BtnCancelar then exit;
  if Trim(EdGrupo.Text) = '' then
  begin
    MessageDlg('Necessário informar Grupo !',mtError,[mbOk],0);
    EdGrupo.SelectAll;
    EdGrupo.SetFocus;
    exit;
  end;
  Ok := True;
  For I := 0 to FormSenhas.ListaNomesGrp.Count-1 do
    if I <> FormSenhas.lbgrupos.ItemIndex then
      if EdGrupo.Text = FormSenhas.ListaNomesGrp[I] then
        Ok := False;
  if not Ok then
  begin
    MessageDlg('Grupo já cadastrado !',mtError,[mbOk],0);
    EdGrupo.SelectAll;
    EdGrupo.SetFocus;
    exit;
  end;
  AtualizaListas;
  EdGrupo.Color      := clBtnFace;
  EdGrupo.Font.Color := ClBlue;
  EdGrupo.ReadOnly   := True;
  EdGrupo.TabStop    := False;
  EdDescricao.SelectAll;
  EdDescricao.SetFocus;
end;

procedure TFormEdGrp.AcessoMenuClick(Sender: TObject);
Var
  Posicao,I: Integer;
begin
  case Notebook1.PageIndex of
    0: begin
         Posicao := TreeOpcoes.Selected.AbsoluteIndex;
         I := Integer(TreeOpcoes.Selected.Data);
       end;
    1: begin
         Posicao := TreeMenuSup.Selected.AbsoluteIndex;
         I := Integer(TreeMenuSup.Selected.Data);
       end;
    2: begin
         Posicao := TreeBarra.Selected.AbsoluteIndex;
         I := Integer(TreeBarra.Selected.Data);
       end;
  end;
  if Posicao < 0 then
    exit;
  case Notebook1.PageIndex of
    0 : begin
          if AcessoMenu.ItemIndex = 0 then
            ListaOpMenu[Posicao] := 'N' + IntToStr(I)
          else
            ListaOpMenu[Posicao] := 'S' + IntToStr(I);
          TreeOpcoes.SetFocus;
        end;
    1 : begin
          if AcessoMenu.ItemIndex = 0 then
            ListaOpMenuSup[Posicao] := 'N' + IntToStr(I)
          else if AcessoMenu.ItemIndex = 1 then
            ListaOpMenuSup[Posicao] := 'S' + IntToStr(I)
          else if AcessoMenu.ItemIndex = 2 then
            ListaOpMenuSup[Posicao] := 'I' + IntToStr(I);
          TreeMenuSup.SetFocus;
        end;
    2 : begin
          if AcessoMenu.ItemIndex = 0 then
            ListaOpBarra[Posicao] := 'N' + IntToStr(I)
          else if AcessoMenu.ItemIndex = 1 then
            ListaOpBarra[Posicao] := 'S' + IntToStr(I)
          else if AcessoMenu.ItemIndex = 2 then
            ListaOpBarra[Posicao] := 'I' + IntToStr(I);
          TreeBarra.SetFocus;
        end;
  end;
end;

procedure TFormEdGrp.TabSet1Click(Sender: TObject);
begin
  if TabSet1.Tabs[TabSet1.TabIndex] = 'Menu Lateral' then
    Notebook1.PageIndex := 0
  else if TabSet1.Tabs[TabSet1.TabIndex] = 'Menu Superior' then
    Notebook1.PageIndex := 1
  else if TabSet1.Tabs[TabSet1.TabIndex] = 'Barra F.' then
    Notebook1.PageIndex := 2;
  AcessoMenu.Items.Clear;
  AcessoMenu.Items.Add('Livre');
  AcessoMenu.Items.Add('Por Senha ( Usuário Master )');
  if NoteBook1.PageIndex > 0 then
    AcessoMenu.Items.Add('Invisível');
end;

procedure TFormEdGrp.TreeMenuSupChange(Sender: TObject; Node: TTreeNode);
begin
  TreeOpcoesChange(Sender, Node);
end;

procedure TFormEdGrp.TreeBarraChange(Sender: TObject; Node: TTreeNode);
begin
  TreeOpcoesChange(Sender, Node);
end;

procedure TFormEdGrp.ModificarClick(Sender: TObject);
begin
  IncluirClick(Sender);
end;

procedure TFormEdGrp.ExcluirClick(Sender: TObject);
begin
  IncluirClick(Sender);
end;

procedure TFormEdGrp.FiltrarClick(Sender: TObject);
begin
  IncluirClick(Sender);
end;

procedure TFormEdGrp.TotalizarClick(Sender: TObject);
begin
  IncluirClick(Sender);
end;

procedure TFormEdGrp.ImprimirClick(Sender: TObject);
begin
  IncluirClick(Sender);
end;

end.
