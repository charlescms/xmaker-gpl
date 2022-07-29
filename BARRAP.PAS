unit BarraP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls;

type
  TFormBarraP = class(TForm)
    BarraPrincipal: TToolBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CriaItemsBarra;
  end;

var
  FormBarraP: TFormBarraP;
  Botao : Array [0..99] of TToolButton;

implementation

uses ObjBarra, Princ, Rotinas;

{$R *.DFM}

procedure TFormBarraP.FormClose(Sender: TObject; var Action: TCloseAction);
var I : Integer;
begin
  {for I := 0 to 99 do
  begin
    if Botao[I] <> Nil then
      Botao[I].Free;
  end;}
  FormBarraP := Nil;
  if FormBarraF <> nil then
    FormBarraF.Close;
end;

procedure TFormBarraP.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 122 then
    FormBarraF.SetFocus;
end;

procedure TFormBarraP.CriaItemsBarra;
var I, NrBtn, Imagem : Integer;
    Mensagem: String;
begin
  {for I := 0 to 99 do
  begin
    if Botao[I] <> Nil then
      Botao[I].Free;
  end;}
  NrBtn := 0;
  for I := FormPrincipal.Texto.Lines.Count-1  downto 0 do
  begin
    if Copy(Trim(FormPrincipal.Texto.Lines[I]),01,04) = 'Nome' then
    begin
      if Trim(Copy(FormPrincipal.Texto.Lines[I+4],Pos('=',FormPrincipal.Texto.Lines[I+4])+2,Length(FormPrincipal.Texto.Lines[I+4]))) <> '' then
        Imagem := StrToInt(Trim(Copy(FormPrincipal.Texto.Lines[I+4],Pos('=',FormPrincipal.Texto.Lines[I+4])+2,Length(FormPrincipal.Texto.Lines[I+4]))))
      else
        Imagem := -1;
      Mensagem := Trim(Copy(FormPrincipal.Texto.Lines[I+3],Pos('=',FormPrincipal.Texto.Lines[I+3])+2,Length(FormPrincipal.Texto.Lines[I+3])));
      Botao[NrBtn] := TToolButton.Create(Self);
      with Botao[NrBtn] do
      begin
        Parent     := FormBarraP.BarraPrincipal;
        ImageIndex := Imagem;
        ShowHint   := True;
        Hint       := Mensagem;
        if Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1]))) <> 'SEPARACAO' then
          Cursor     := crHandPoint;
        if Trim(Copy(FormPrincipal.Texto.Lines[I+2],Pos('=',FormPrincipal.Texto.Lines[I+2])+2,Length(FormPrincipal.Texto.Lines[I+2]))) = 'Sim' then
          Enabled     := True
        else
          Enabled     := False;
        if Trim(Copy(FormPrincipal.Texto.Lines[I+5],Pos('=',FormPrincipal.Texto.Lines[I+5])+2,Length(FormPrincipal.Texto.Lines[I+5]))) = 'Sim' then
          Visible     := True
        else
          Visible     := False;
        if Trim(Copy(FormPrincipal.Texto.Lines[I+1],Pos('=',FormPrincipal.Texto.Lines[I+1])+2,Length(FormPrincipal.Texto.Lines[I+1]))) = 'SEPARACAO' then
        begin
          Style :=  tbsDivider;
          Width := 19;
        end;
      end;
      Inc(NrBtn);
    end;
  end;
end;

procedure TFormBarraP.FormShow(Sender: TObject);
begin
 {CriaItemsBarra;}
end;

end.
