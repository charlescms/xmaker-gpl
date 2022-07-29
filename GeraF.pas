unit GeraF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, Buttons, ExtCtrls, ComCtrls, IniFiles, ShellApi;

type
  TFormGerarFontes = class(TForm)
    Panel1: TPanel;
    BtnGerar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnAjuda: TBitBtn;
    BtnTodos: TBitBtn;
    Lista: TCheckListBox;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnTodosClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGerarFontes: TFormGerarFontes;

implementation

{$R *.DFM}
uses Rotinas, Gera_01, Princ;

procedure TFormGerarFontes.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormGerarFontes.BtnGerarClick(Sender: TObject);
Var
  I, Y: Integer;
  ListaFontes: TStringList;
  ExtraiNomes: String;
begin
  if Mensagem('Atenção!,'+^M+^M+'Modificações nos fontes não serão preservados ...'+^M+^M+'Prosseguir Operação ?',ModConfirmacao,[ModSim, ModNao]) = mrNo then
    abort;
  Screen.Cursor := crHourGlass;
  ListaFontes := TStringList.Create;
  for I:=0 to Lista.Items.Count-1 do
    if Lista.Checked[I] then
    begin
      ExtraiNomes := Lista.Items[I];
      ExtraiNomes := Trim(Copy(ExtraiNomes,Pos('(',ExtraiNomes),Length(ExtraiNomes)));
      ExtraiNomes := Copy(ExtraiNomes,01,Pos(')',ExtraiNomes)-1);
      ExtraiNomes := Trim(Copy(ExtraiNomes,02,100));
      StringToArray(ExtraiNomes,';',ListaFontes);
      for Y:=0 to ListaFontes.Count-1 do
        if FileExists(Projeto.Pasta + Trim(ListaFontes[Y])) then
          if not DeleteFile(Projeto.Pasta + Trim(ListaFontes[Y])) then
            Mensagem('Não foi Possível Excluir o Arquivo: '+^M+^M+Projeto.Pasta + Trim(ListaFontes[Y]),ModErro,[ModOk]);
    end;
  ListaFontes.Free;
  FormPrincipal.CopiaFontes;
  Screen.Cursor := crDefault;
  Mensagem('Operação Concluída !',ModInformacao,[ModOk]);
  Close;
end;

procedure TFormGerarFontes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFormGerarFontes.BtnTodosClick(Sender: TObject);
Var
  I: Integer;
begin
  for I:=0 to Lista.Items.Count-1 do
    Lista.Checked[I] := not Lista.Checked[I];
end;

procedure TFormGerarFontes.BtnAjudaClick(Sender: TObject);
begin
  ChamaAjuda;

end;

end.
