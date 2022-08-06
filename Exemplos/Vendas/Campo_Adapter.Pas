{
   Programa.: Campo_Adapter.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit Campo_Adapter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, ExtCtrls, StdCtrls, ComCtrls, Buttons;

type
  TFormCampo_Adapter = class(TForm)
    BitOk: TBitBtn;
    BitCancela: TBitBtn;
    Panel1: TPanel;
    Label2: TLabel;
    Bevel2: TBevel;
    EdCampo: TEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    EdExpressao: TEdit;
    ListaCampos: TListBox;
    Label3: TLabel;
    Label4: TLabel;
    ListaFuncoes: TListBox;
    procedure BitOkClick(Sender: TObject);
    procedure BitCancelaClick(Sender: TObject);
    procedure ListaCamposDblClick(Sender: TObject);
    procedure ListaFuncoesDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Tipo: Integer;
  end;

var
  FormCampo_Adapter: TFormCampo_Adapter;

implementation

uses Princ_Adapter;

{$R *.DFM}

procedure TFormCampo_Adapter.FormShow(Sender: TObject);
begin
  ListaFuncoes.items.Clear;
  ListaFuncoes.items.Add('Converte para maiúsculo');
  ListaFuncoes.items.Add('Converte valor para texto');
  ListaFuncoes.items.Add('Converte texto para valor');
  ListaFuncoes.items.Add('Converte texto para data');
  if Tipo = 1 then
  begin
    ListaFuncoes.items.Add('Lógico para texto');
    ListaFuncoes.items.Add('Autoincremento');
  end;
end;

procedure TFormCampo_Adapter.ListaFuncoesDblClick(Sender: TObject);
begin
  if Tipo = 0 then
    case ListaFuncoes.ItemIndex of
      0: EdExpressao.Text := 'Upper('+EdExpressao.Text+')';
      1: EdExpressao.Text := 'Cast('+EdExpressao.Text+' AS CHARACTER)';
      2: EdExpressao.Text := 'Cast('+EdExpressao.Text+' AS NUMERIC)';
      3: EdExpressao.Text := 'Cast('+EdExpressao.Text+' AS DATE)';
    end
  else if Tipo = 1 then
    case ListaFuncoes.ItemIndex of
      0: EdExpressao.Text := 'UpperCase('+EdExpressao.Text+')';
      1: EdExpressao.Text := 'NumToStr('+EdExpressao.Text+')';
      2: EdExpressao.Text := 'StrToNum('+EdExpressao.Text+')';
      3: EdExpressao.Text := 'StrToDate('+EdExpressao.Text+')';
      4: EdExpressao.Text := 'LogToStr('+EdExpressao.Text+',SN)';
      5: EdExpressao.Text := 'Autoincremento()';
    end;
end;

procedure TFormCampo_Adapter.ListaCamposDblClick(Sender: TObject);
begin
  EdExpressao.Text := Copy(ListaCampos.Items[ListaCampos.ItemIndex],01,Pos('(',ListaCampos.Items[ListaCampos.ItemIndex])-3);
  EdExpressao.SelectAll;
  EdExpressao.SetFocus;
end;

procedure TFormCampo_Adapter.BitOkClick(Sender: TObject);
begin
  if Tipo = 0 then
    FormAdapter.TabConversao.Cells[1,FormAdapter.TabConversao.Row] := EdExpressao.Text
  else if Tipo = 1 then
    FormAdapter.TabConversao2.Cells[1,FormAdapter.TabConversao2.Row] := EdExpressao.Text;
  Close;
end;

procedure TFormCampo_Adapter.BitCancelaClick(Sender: TObject);
begin
  Close;
end;

end.
