unit Argumentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit;

type
  TFormArg = class(TForm)
    FuncLabel: TLabel;
    DescrLabel: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    ComboEdit1: TComboEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboEdit2: TComboEdit;
    Label3: TLabel;
    ComboEdit3: TComboEdit;
    Label4: TLabel;
    ComboEdit4: TComboEdit;
    Label5: TLabel;
    ComboEdit5: TComboEdit;
    Label6: TLabel;
    ComboEdit6: TComboEdit;
    procedure ComboEdit1ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormArg: TFormArg;

implementation

uses Expressao;

{$R *.DFM}

procedure TFormArg.ComboEdit1ButtonClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    if FormExpressao.ShowModal = mrOk then
    begin
      TComboEdit(Sender).SelText := FormExpressao.ExprMemo.Text;
      TComboEdit(Sender).SetFocus;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

end.
