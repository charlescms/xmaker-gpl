unit SimularM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, ExtCtrls, StdCtrls, Grids, Buttons;

type
  TFormSimularMenu = class(TForm)
    MenuSimulado: TMainMenu;
    BarraPrincipal: TToolBar;
    StatusBarSimulador: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CriaItemsMenu;
    procedure AdicionaItem(Linha, Ordem: Integer; Destino: TMenuItem);
    procedure ShowHint(Sender: TObject);
    procedure CriaItemsBarra;
  public
    { Public declarations }
  end;

var
  FormSimularMenu: TFormSimularMenu;
  Botao : Array [0..99] of TToolButton;

implementation

{$R *.DFM}

uses Rotinas, Princ, ObjBarra;

procedure TFormSimularMenu.FormShow(Sender: TObject);
var
  I: Integer;
begin
  MenuSimulado.Items.Clear;
  FormPrincipal.Texto.Lines.Clear;
  if fileExists(Projeto.ArquivoMenu) then
  begin
    FormPrincipal.Texto.Lines.LoadFromFile(Projeto.ArquivoMenu);
    CriaItemsMenu;
    FormPrincipal.Texto.Lines.Clear;
  end;
  FormPrincipal.Texto2.Lines.Clear;
  if FileExists(ArqDefBarra) then
  begin
    FormPrincipal.Texto2.Lines.LoadFromFile(ArqDefBarra);
    CriaItemsBarra;
    FormPrincipal.Texto2.Lines.Clear;
  end;
end;

procedure TFormSimularMenu.CriaItemsMenu;
var
  I, Y, QtLinhas: Integer;
  Item: Array[0..999] of TMenuItem;
  Nivel: Integer;
  UltNivel, UltOrdem : Integer;
  Ordem : Array[0..99] of Integer;
begin
  UltNivel := 0;
  for I := 0 to 99 do
    Ordem[I] := -1;
  QtLinhas := FormPrincipal.Texto.Lines.Count-1;
  I := 0;
  while I <= QtLinhas do
  begin
    if Copy(Trim(FormPrincipal.Texto.Lines[I]),01,04) = 'Nome' then
    begin
      Nivel := Pos('N',FormPrincipal.Texto.Lines[I])+1;
      Nivel := StrToInt(FloatToStr(Nivel / 2));
      Nivel := Nivel - 1;
      begin
        if Nivel = 0 then
        begin
          Item[Nivel] := MenuSimulado.Items;
          for Y := 1 to 99 do
            Ordem[Y] := -1;
        end
        else
        begin
          if Nivel > UltNivel then
          begin
            Item[Nivel] := Item[UltNivel].Items[UltOrdem];
            Ordem[Nivel + 1] := -1;
          end
          else if Nivel < UltNivel then
            for Y := Nivel + 1 to UltNivel do
              Ordem[Y] := -1;
        end;
        Ordem[Nivel] := Ordem[Nivel] + 1;
        AdicionaItem(I,Ordem[Nivel],Item[Nivel]);
        UltNivel := Nivel;
        UltOrdem := Ordem[Nivel];
      end;
    end;
    I := I + 12;
  end;
end;

procedure TFormSimularMenu.AdicionaItem(Linha, Ordem: Integer; Destino: TMenuItem);
var
  NovoItem: TMenuItem;
  Tecla,NrMenu: Integer;
begin
  NovoItem := TMenuItem.Create(Destino);
  Destino.add(NovoItem);
  NrMenu := Ordem;
  Destino[NrMenu].Caption     := Trim(Copy(FormPrincipal.Texto.Lines[Linha+2],Pos('=',FormPrincipal.Texto.Lines[Linha+2])+2,Length(FormPrincipal.Texto.Lines[Linha+2])));
  if Trim(Copy(FormPrincipal.Texto.Lines[Linha+9],Pos('=',FormPrincipal.Texto.Lines[Linha+9])+2,Length(FormPrincipal.Texto.Lines[Linha+9]))) <> '' then
    Destino[NrMenu].Caption := Destino[NrMenu].Caption + '     ' + Trim(Copy(FormPrincipal.Texto.Lines[Linha+9],Pos('=',FormPrincipal.Texto.Lines[Linha+9])+2,Length(FormPrincipal.Texto.Lines[Linha+9])));
  if Trim(Copy(FormPrincipal.Texto.Lines[Linha+3],Pos('=',FormPrincipal.Texto.Lines[Linha+3])+2,Length(FormPrincipal.Texto.Lines[Linha+3]))) = 'Sim' then
    Destino[NrMenu].Checked     := True
  else
    Destino[NrMenu].Checked     := False;
  if Trim(Copy(FormPrincipal.Texto.Lines[Linha+4],Pos('=',FormPrincipal.Texto.Lines[Linha+4])+2,Length(FormPrincipal.Texto.Lines[Linha+4]))) = 'Sim' then
    Destino[NrMenu].Enabled     := True
  else
    Destino[NrMenu].Enabled     := False;
  Destino[NrMenu].HelpContext := StrToInt(Trim(Copy(FormPrincipal.Texto.Lines[Linha+5],Pos('=',FormPrincipal.Texto.Lines[Linha+5])+2,Length(FormPrincipal.Texto.Lines[Linha+5]))));
  Destino[NrMenu].Hint        := Trim(Copy(FormPrincipal.Texto.Lines[Linha+6],Pos('=',FormPrincipal.Texto.Lines[Linha+6])+2,Length(FormPrincipal.Texto.Lines[Linha+6])));
  if Projeto.Linguagem <> 'Delphi 3.0' then
    Destino[NrMenu].ImageIndex  := StrToInt(Trim(Copy(FormPrincipal.Texto.Lines[Linha+7],Pos('=',FormPrincipal.Texto.Lines[Linha+7])+2,Length(FormPrincipal.Texto.Lines[Linha+7]))));
  if Trim(Copy(FormPrincipal.Texto.Lines[Linha+8],Pos('=',FormPrincipal.Texto.Lines[Linha+8])+2,Length(FormPrincipal.Texto.Lines[Linha+8]))) = 'Sim' then
    Destino[NrMenu].RadioItem   := True
  else
    Destino[NrMenu].RadioItem   := False;
  if Trim(Copy(FormPrincipal.Texto.Lines[Linha+10],Pos('=',FormPrincipal.Texto.Lines[Linha+10])+2,Length(FormPrincipal.Texto.Lines[Linha+10]))) = 'Sim' then
    Destino[NrMenu].Visible     := True
  else
    Destino[NrMenu].Visible     := False;
  Inc(NrMenu);
end;

procedure TFormSimularMenu.FormClose(Sender: TObject; var Action: TCloseAction);
var I : Integer;
  procedure RemoveItemsMenu(Origem: TMenuItem);
  var
    Aux: TMenuItem;
  begin
    while Origem.Count > 0 do
    begin
      if Origem[0].Count > 0 then
        RemoveItemsMenu(Origem.Items[0]);
      Aux := Origem[0];
      Origem.Remove(Origem[0]);
      Aux.Free;
    end;
  end;
begin
  FormPrincipal.Texto.Lines.Clear;
  FormPrincipal.Texto2.Lines.Clear;
  RemoveItemsMenu(MenuSimulado.Items);
  {for I := 0 to 99 do
  begin
    if Botao[I] <> Nil then
      Botao[I].Free;
  end;}
  Application.OnHint := FormPrincipal.Showhint;
end;

procedure TFormSimularMenu.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBarSimulador.SimplePanel := True;
    StatusBarSimulador.SimpleText := Application.Hint;
  end
  else StatusBarSimulador.SimplePanel := False;
end;

procedure TFormSimularMenu.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
end;

procedure TFormSimularMenu.CriaItemsBarra;
var I, NrBtn, Imagem : Integer;
    Mensagem: String;
begin
  NrBtn := 0;
  for I := FormPrincipal.Texto2.Lines.Count-1  downto 0 do
  begin
    if Copy(Trim(FormPrincipal.Texto2.Lines[I]),01,04) = 'Nome' then
    begin
      if Trim(Copy(FormPrincipal.Texto2.Lines[I+4],Pos('=',FormPrincipal.Texto2.Lines[I+4])+2,Length(FormPrincipal.Texto2.Lines[I+4]))) <> '' then
        Imagem := StrToInt(Trim(Copy(FormPrincipal.Texto2.Lines[I+4],Pos('=',FormPrincipal.Texto2.Lines[I+4])+2,Length(FormPrincipal.Texto2.Lines[I+4]))))
      else
        Imagem := -1;
      Mensagem := Trim(Copy(FormPrincipal.Texto2.Lines[I+3],Pos('=',FormPrincipal.Texto2.Lines[I+3])+2,Length(FormPrincipal.Texto2.Lines[I+3])));
      Botao[NrBtn] := TToolButton.Create(Self);
      with Botao[NrBtn] do
      begin
        Parent     := BarraPrincipal;
        ImageIndex := Imagem;
        ShowHint   := True;
        Hint       := Mensagem;
        if Trim(Copy(FormPrincipal.Texto2.Lines[I+1],Pos('=',FormPrincipal.Texto2.Lines[I+1])+2,Length(FormPrincipal.Texto2.Lines[I+1]))) <> 'SEPARACAO' then
          Cursor     := crHandPoint;
        if Trim(Copy(FormPrincipal.Texto2.Lines[I+2],Pos('=',FormPrincipal.Texto2.Lines[I+2])+2,Length(FormPrincipal.Texto2.Lines[I+2]))) = 'Sim' then
          Enabled     := True
        else
          Enabled     := False;
        if Trim(Copy(FormPrincipal.Texto2.Lines[I+5],Pos('=',FormPrincipal.Texto2.Lines[I+5])+2,Length(FormPrincipal.Texto2.Lines[I+5]))) = 'Sim' then
          Visible     := True
        else
          Visible     := False;
        if Trim(Copy(FormPrincipal.Texto2.Lines[I+1],Pos('=',FormPrincipal.Texto2.Lines[I+1])+2,Length(FormPrincipal.Texto2.Lines[I+1]))) = 'SEPARACAO' then
        begin
          Style :=  tbsDivider;
          Width := 19;
        end;
      end;
      Inc(NrBtn);
    end;
  end;
end;

procedure TFormSimularMenu.FormDestroy(Sender: TObject);
var
   QtComp: Integer;
begin
  QtComp := 0;
  while QtComp <= ComponentCount - 1 do
  begin
    if (Components[QtComp] is TToolButton) then
      Components[QtComp].Destroy
    else
      Inc(QtComp);
  end;
end;

end.
