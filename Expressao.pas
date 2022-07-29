unit Expressao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit;

type
  TFormExpressao = class(TForm)
    GroupBox1: TGroupBox;
    ExprMemo: TMemo;
    GroupBox2: TGroupBox;
    frSpeedButton1: TSpeedButton;
    frSpeedButton2: TSpeedButton;
    frSpeedButton3: TSpeedButton;
    frSpeedButton4: TSpeedButton;
    frSpeedButton5: TSpeedButton;
    frSpeedButton6: TSpeedButton;
    frSpeedButton7: TSpeedButton;
    frSpeedButton8: TSpeedButton;
    frSpeedButton9: TSpeedButton;
    frSpeedButton10: TSpeedButton;
    frSpeedButton11: TSpeedButton;
    frSpeedButton12: TSpeedButton;
    frSpeedButton13: TSpeedButton;
    InsDBBtn: TSpeedButton;
    InsVarBtn: TSpeedButton;
    InsFuncBtn: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    procedure frSpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InsDBBtnClick(Sender: TObject);
    procedure InsVarBtnClick(Sender: TObject);
    procedure InsFuncBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SQL: Boolean;
    Tab_Alvo: String;
  end;

var
  FormExpressao: TFormExpressao;

implementation

uses CamposProj, Funcoes, Argumentos, Rotinas;

{$R *.DFM}

procedure TFormExpressao.frSpeedButton1Click(Sender: TObject);
begin
  ExprMemo.SelText := TSpeedButton(Sender).Caption + ' ';
end;

procedure TFormExpressao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Escape then
    ModalResult := mrCancel;
end;

procedure TFormExpressao.InsDBBtnClick(Sender: TObject);
begin
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    FormCamposProj.Tipo := 1;
    FormCamposProj.SQL  := SQL;
    FormCamposProj.Tab_Alvo := Tab_Alvo;
    if FormCamposProj.ShowModal = mrOk then
      if Trim(FormCamposProj.Retorno) <> '' then
        ExprMemo.SelText := FormCamposProj.Retorno;
  Finally
    FormCamposProj.Free;
  end;
end;

procedure TFormExpressao.InsVarBtnClick(Sender: TObject);
begin
  FormCamposProj := TFormCamposProj.Create(Application);
  Try
    FormCamposProj.Tipo := 2;
    FormCamposProj.SQL  := SQL;
    if FormCamposProj.ShowModal = mrOk then
      if Trim(FormCamposProj.Retorno) <> '' then
        ExprMemo.SelText := FormCamposProj.Retorno;
  Finally
    FormCamposProj.Free;
  end;
end;

procedure TFormExpressao.InsFuncBtnClick(Sender: TObject);
var
  Qt_Arg, I: Integer;
  Func: String;
  FormFuncoes : TFormFuncoes;
  FormArg: TFormArg;
begin
  FormFuncoes := TFormFuncoes.Create(Application);
  Try
    if FormFuncoes.ShowModal = mrOk then
      if Trim(FormFuncoes.Retorno) <> '' then
      begin
        if Pos('(',FormFuncoes.Retorno) > 0 then
        begin
          Qt_Arg := ContaOcorrencia(',',FormFuncoes.Retorno);
          if Qt_Arg > 5 then
          begin
            Mensagem('Ultrapassado o limite máximo de 06 argumentos !'+^M+'Faça a adição manual ...',modErro,[modOk]);
            ExprMemo.SelText := FormFuncoes.Retorno;
          end
          else
          begin
            FormArg := TFormArg.Create(Application);
            Try
              FormArg.FuncLabel.Caption := FormFuncoes.FuncLabel.Caption;
              FormArg.DescrLabel.Caption := FormFuncoes.DescrLabel.Caption;
              for I:=0 to Qt_Arg do
                TComboEdit(FormArg.FindComponent('ComboEdit'+IntToStr(I+1))).Enabled := True;
              if FormArg.ShowModal = mrOk then
              begin
                Func := Copy(FormFuncoes.Retorno,01,Pos('(',FormFuncoes.Retorno));
                for I:=0 to Qt_Arg do
                  if I = Qt_Arg then
                    Func := Func + TComboEdit(FormArg.FindComponent('ComboEdit'+IntToStr(I+1))).Text
                  else
                    Func := Func + TComboEdit(FormArg.FindComponent('ComboEdit'+IntToStr(I+1))).Text + ',';
                Func := Func + ')';
                ExprMemo.SelText := Func;
              end;
            Finally
              FormArg.Free;
            end;
          end;
        end
        else
          ExprMemo.SelText := FormFuncoes.Retorno;
      end;
  Finally
    FormFuncoes.Free;
  end;
end;

end.
