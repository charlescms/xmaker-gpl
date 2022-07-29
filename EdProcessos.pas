unit EdProcessos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Mask, ToolEdit, RXDBCtrl, Estrutura_Case,
  ComCtrls;

type
  TFormProcessos = class(TForm)
    BtnOk: TButton;
    BtnFechar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Label29: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PR_EdTab_alvo: TDBComboBox;
    PR_EdCampo_alvo: TDBComboBox;
    PR_EdCondicao: TRxDBComboEdit;
    PR_EdFormula_direta: TRxDBComboEdit;
    PR_EdFormula_inversa: TRxDBComboEdit;
    procedure BtnOkClick(Sender: TObject);
    procedure PR_EdCondicaoButtonClick(Sender: TObject);
    procedure PR_EdFormula_diretaButtonClick(Sender: TObject);
    procedure PR_EdFormula_inversaButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PR_EdTab_alvoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProcessos: TFormProcessos;

implementation

uses Abertura, Rotinas, Tabela, Expressao;

{$R *.DFM}

procedure TFormProcessos.BtnOkClick(Sender: TObject);
begin
  if Trim(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo) = '' then
  begin
    Mensagem('Necessário informar a tabela alvo do processo !',ModAdvertencia,[modOk]);
    PR_EdTab_alvo.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  if Trim(TabGlobal_i.DPROCESSOS.CAMPO_ALVO.Conteudo) = '' then
  begin
    Mensagem('Necessário informar o campo alvo do processo !',ModAdvertencia,[modOk]);
    PR_EdCampo_alvo.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  if (Trim(TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo) = '') and
     (Trim(TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo) = '') then
  begin
    Mensagem('Necessário informar processo direto ou inverso !',ModAdvertencia,[modOk]);
    PR_EdFormula_direta.SetFocus;
    ModalResult := mrNone;
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TFormProcessos.PR_EdCondicaoButtonClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
  I: Integer;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    FormExpressao.ExprMemo.Text := PR_EdCondicao.Text;
    if FormExpressao.ShowModal = mrOk then
    begin
      TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo := '';
      for I:=0 to FormExpressao.ExprMemo.Lines.Count-1 do
        if Trim(FormExpressao.ExprMemo.Lines[I]) <> '' then
          TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo := TabGlobal_i.DPROCESSOS.CONDICAO.Conteudo +
          FormExpressao.ExprMemo.Lines[I];
      PR_EdCondicao.SetFocus;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

procedure TFormProcessos.PR_EdFormula_diretaButtonClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
  I: Integer;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    FormExpressao.InsFuncBtn.Visible := False;
    FormExpressao.SQL := True;
    FormExpressao.Tab_Alvo := TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo;
    FormExpressao.ExprMemo.Text := PR_EdFormula_direta.Text;
    if FormExpressao.ShowModal = mrOk then
    begin
      TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo := '';
      for I:=0 to FormExpressao.ExprMemo.Lines.Count-1 do
        if Trim(FormExpressao.ExprMemo.Lines[I]) <> '' then
          TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo := TabGlobal_i.DPROCESSOS.FORMULA_DIRETA.Conteudo +
          FormExpressao.ExprMemo.Lines[I];
      PR_EdFormula_direta.SetFocus;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

procedure TFormProcessos.PR_EdFormula_inversaButtonClick(Sender: TObject);
var
  FormExpressao: TFormExpressao;
  I: Integer;
begin
  FormExpressao := TFormExpressao.Create(Application);
  Try
    FormExpressao.SQL := True;
    FormExpressao.InsFuncBtn.Visible := False;
    FormExpressao.Tab_Alvo := TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo;
    FormExpressao.ExprMemo.Text := PR_EdFormula_inversa.Text;
    if FormExpressao.ShowModal = mrOk then
    begin
      TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo := '';
      for I:=0 to FormExpressao.ExprMemo.Lines.Count-1 do
        if Trim(FormExpressao.ExprMemo.Lines[I]) <> '' then
          TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo := TabGlobal_i.DPROCESSOS.FORMULA_INVERSA.Conteudo +
          FormExpressao.ExprMemo.Lines[I];
      PR_EdFormula_inversa.SetFocus;
    end;
  Finally
    FormExpressao.Free;
  end;
end;

procedure TFormProcessos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Key := #0;
    {Atua como a tecla TAB}
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormProcessos.PR_EdTab_alvoExit(Sender: TObject);
var
  qy_Tabela: TTabela;
begin
  PR_EdCampo_alvo.DataSource := Nil;
  PR_EdCampo_alvo.Clear;
  PR_EdCampo_alvo.Items.Add('');
  qy_Tabela := TTabela.Create(Self);
  with qy_Tabela do
  begin
    DataBase := TabGlobal_i.DCAMPOST.DataBase;
    Transaction := TabGlobal_i.DCAMPOST.Transaction;

    Sql.Text := 'Select Numero From Tabelas Where UPPER(Nome) = '+#39+Trim(UpperCase(TabGlobal_i.DPROCESSOS.TAB_ALVO.Conteudo))+#39;
    Abrir;
    First;

    if Trim(Fields[0].AsString) <> '' then
    begin
      Sql.Text := 'Select Numero, Nome, Titulo_C, Sequencia, Extra, Calculado From CamposT Where Numero = '+Fields[0].AsString+' Order By Sequencia';
      Close;
      Abrir;
      First;
      while not Eof do
      begin
        if (Trim(Fields[1].AsString) <> '') and
           (Fields[4].AsInteger = 0) and
           (Fields[5].AsInteger = 0) then
          PR_EdCampo_alvo.Items.Add(Trim(Fields[1].AsString));
        Next;
      end;
    end;
    Close;
    Free;
  end;
  PR_EdCampo_alvo.DataSource := FormDB_Case.DataSource_Processo;
end;

procedure TFormProcessos.FormShow(Sender: TObject);
begin
  PR_EdTab_alvo.SetFocus;
end;

end.
