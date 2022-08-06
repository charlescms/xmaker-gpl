{
   Programa.: OpAcesso.PAS
   Copyright: X-Maker
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit OpAcesso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, Menus, Db, DBTables;

type
  TFormOpcAcesso = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnAjuda: TBitBtn;
    BtnOk: TBitBtn;
    TabOpcao: TTable;
    ArqOpcao: TDataSource;
    ArqTabela: TDataSource;
    TabTabela: TTable;
    TreeMenu: TTreeView;
    Label1: TLabel;
    TreeBarra: TTreeView;
    Label2: TLabel;
    TreeTabela: TTreeView;
    Label3: TLabel;
    AcessoTabela: TGroupBox;
    Modificar: TCheckBox;
    Excluir: TCheckBox;
    Filtrar: TCheckBox;
    TabOpcaoOpcao: TStringField;
    TabOpcaoGrupo: TStringField;
    TabOpcaoPermitido: TBooleanField;
    TabOpcaoPorSenha: TBooleanField;
    TabTabelaTabela: TStringField;
    TabTabelaGrupo: TStringField;
    TabTabelaCerceado: TStringField;
    Incluir: TCheckBox;
    BtnAcessoMenu: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeMenuChange(Sender: TObject; Node: TTreeNode);
    procedure BtnAcessoMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodGrupo : String;
  end;

var
  FormOpcAcesso: TFormOpcAcesso;
  OpcoesMenu: TStringList;
  OpcoesBarra: TStringList;
  OpcaoSelecionada: Integer;
  PosTree: Integer;
  Opc: String;

implementation

{$R *.DFM}

uses Rotinas, Publicas, Princ;

procedure TFormOpcAcesso.FormShow(Sender: TObject);
  procedure CriaSubItemsMenu(Origem: TMenuItem; Destino: TTreeNode);
  var
    I: integer;
    NovoItem: TTreeNode;
    Titulo: String;
  begin
    for I := 0 to Origem.Count - 1 do
    begin
      OpcoesMenu.Add(Origem[I].Name);
      Titulo := Origem[I].Caption;
      while Pos('&', Titulo) > 0 do
        Delete(Titulo, Pos('&', Titulo), 1);
      NovoItem := TreeMenu.Items.AddChild(Destino,Titulo);
      if Origem[I].Count > 0 then
        CriaSubItemsMenu(Origem.Items[I], NovoItem);
    end;
    Application.ProcessMessages;
  end;

  procedure CriaItemsMenu(Origem: TMenuItem; Destino: TTreeView);
  var
    I: integer;
    NovoItem: TTreeNode;
    Titulo: String;
  begin
    for I := 0 to Origem.Count - 1 do
    begin
      OpcoesMenu.Add(Origem[I].Name);
      Titulo := Origem[I].Caption;
      while Pos('&', Titulo) > 0 do
        Delete(Titulo, Pos('&', Titulo), 1);
      NovoItem := Destino.Items.Add(nil,Titulo);
      if Origem[I].Count > 0 then
        CriaSubItemsMenu(Origem.Items[I], NovoItem);
    end;
    Application.ProcessMessages;
  end;

  procedure CriaItemsBarra(Origem: TToolBar; Destino: TTreeView);
  var
    I, Imagem: integer;
  begin
    for I := 0 to Origem.ControlCount - 1 do
    begin
      if (Origem.Controls[I] is TToolButton) then
      begin
        OpcoesBarra.Add(TControl(Origem.Controls[I]).Name);
        Destino.Items.Add(nil,TControl(Origem.Controls[I]).Hint);
        if TToolButton(Origem.Controls[I]).Style <> tbsButton then
          Imagem := -1
        else
          Imagem := TToolButton(Origem.Controls[I]).ImageIndex;
        Destino.Items[Destino.Items.Count-1].ImageIndex := Imagem;
        Destino.Items[Destino.Items.Count-1].SelectedIndex := Imagem;
      end;
      Application.ProcessMessages;
    end;
  end;

begin
  TabOpcao.DatabaseName  := Sistema.Pasta;
  TabTabela.DatabaseName := Sistema.Pasta;
  TabOpcao.Open;
  TabTabela.Open;
  TabOpcao.IndexDefs.Update;
  TabOpcao.IndexName := TabOpcao.IndexDefs.Items[0].Name;
  OpcoesMenu:= TStringList.Create;
  OpcoesBarra:= TStringList.Create;
  //CriaItemsMenu(Mod_Menu_Principal.Items, TreeMenu);
  OpcaoSelecionada := -1;
  TreeMenu.FullExpand;
  //CriaItemsBarra(Mod_Barra_Principal, TreeBarra);
end;

procedure TFormOpcAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  OpcoesMenu.Free;
  OpcoesBarra.Free;
  TabOpcao.Close;
  TabTabela.Close;
end;

procedure TFormOpcAcesso.TreeMenuChange(Sender: TObject; Node: TTreeNode);
begin
  PosTree := TTreeView(Sender).Selected.AbsoluteIndex;
  if TTreeView(Sender)= TreeMenu then
  begin
    Opc := OpcoesMenu[PosTree];
    OpcaoSelecionada := 0;
  end
  else
  begin
    Opc := OpcoesBarra[PosTree];
    OpcaoSelecionada := 1;
  end;
  if TabOpcao.FindKey([Opc,CodGrupo]) then
  begin
    if TabOpcaoPermitido.Value then
    begin
      BtnAcessoMenu.Font.Color := clBlue;
      BtnAcessoMenu.Caption := 'Acesso Permitido';
    end
    else
    begin
      BtnAcessoMenu.Font.Color := clRed;
      BtnAcessoMenu.Caption := 'Acesso Negado';
    end;
    if TabOpcaoPorSenha.Value then
    begin
      BtnAcessoMenu.Font.Color := clGreen;
      BtnAcessoMenu.Caption := 'Acesso Por Senha (Master)';
    end;
  end
  else
  begin
    TabOpcao.Insert;
    TabOpcaoOpcao.Value     := Opc;
    TabOpcaoGrupo.Value     := CodGrupo;
    TabOpcaoPermitido.Value := True;
    TabOpcaoPorSenha.Value  := False;
    TabOpcao.Post;
    BtnAcessoMenu.Caption := 'Acesso Permitido';
  end;
end;

procedure TFormOpcAcesso.BtnAcessoMenuClick(Sender: TObject);
begin
  if TabOpcao.FindKey([Opc,CodGrupo]) then
    TabOpcao.Edit
  else
  begin
    TabOpcao.Insert;
    TabOpcaoOpcao.Value := Opc;
    TabOpcaoGrupo.Value := CodGrupo;
  end;
  TabOpcaoPorSenha.Value := False;
  if BtnAcessoMenu.Caption = 'Acesso Permitido' then
  begin
    BtnAcessoMenu.Font.Color := clGreen;
    BtnAcessoMenu.Caption := 'Acesso Por Senha (Master)';
  end
  else if BtnAcessoMenu.Caption = 'Acesso Por Senha (Master)' then
  begin
    BtnAcessoMenu.Font.Color := clRed;
    BtnAcessoMenu.Caption := 'Acesso Negado';
  end
  else
  begin
    BtnAcessoMenu.Font.Color := clBlue;
    BtnAcessoMenu.Caption := 'Acesso Permitido';
  end;

  if BtnAcessoMenu.Caption = 'Acesso Permitido' then
    TabOpcaoPermitido.Value := True
  else if BtnAcessoMenu.Caption = 'Acesso Negado' then
    TabOpcaoPermitido.Value := False
  else
    TabOpcaoPorSenha.Value := True;
  TabOpcao.Post;
  if OpcaoSelecionada = 0 then
    TreeMenu.SetFocus
  else
    TreeBarra.SetFocus;
end;

end.
