unit AtualizaVersao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, IBQuery, Db, IBCustomDataSet, ASGSQLite3;

type
  TFormAtualizaVersao = class(TForm)
    Bevel1: TBevel;
    Progresso1: TProgressBar;
    Progresso2: TProgressBar;
    LbModulo: TLabel;
    LbRegistro: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Query: TIBQuery;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    procedure Processa;
    procedure Processa_Tabela(Nome: String; I: Integer);
  public
    { Public declarations }
    Sucesso: Boolean;
  end;

var
  FormAtualizaVersao: TFormAtualizaVersao;

implementation

uses BaseD, Rotinas, Tabela, Princ, FileCtrl;

{$R *.DFM}

procedure TFormAtualizaVersao.FormShow(Sender: TObject);
begin
  Sucesso := False;
  Timer2.Enabled := True;
end;

procedure TFormAtualizaVersao.Processa_Tabela(Nome: String; I: Integer);
var
  Y, C: Integer;
  Tabela: TTabela;
begin
  Tabela := TTabela(LocalizaTabela(Nil, 'D'+Nome));
  Progresso1.Position := I;
  LbModulo.Caption := 'Módulo: ' + Tabela.Titulo;
  Application.ProcessMessages;
  Query.SQL.Text := 'SELECT * From '+Nome;
  Query.Open;
  Query.Last;
  Progresso2.Position := 0;
  Progresso2.Max := Query.RecordCount-1;
  Progresso2.Min := 0;
  Query.First;
  C := 0;
  while not Query.Eof do
  begin
    Progresso2.Position := C;
    LbRegistro.Caption := 'Registro: ' + IntToStr(C) + '/' + IntToStr(Progresso2.Max);
    Application.ProcessMessages;
    Tabela.Inclui(Nil);
    if Query.Fields[Y].FieldName = 'NOME' then
      Tabela.FieldByName(Query.Fields[Y].FieldName+'_I').AsVariant := Query.Fields[Y].AsVariant
    else
      Tabela.FieldByName(Query.Fields[Y].FieldName).AsVariant := Query.Fields[Y].AsVariant;
    Tabela.Salva;
    Query.Next;
    Inc(C);
  end;
  Query.Close;
end;

procedure TFormAtualizaVersao.Processa;
var
  I: Integer;
Const
  Tabelas_P: Array[0..5] of String = ('PROJETO', 'FORMULARIO', 'RELATORIO', 'MENU', 'BARRA', 'MENUSUP');
  Tabelas_D: Array[0..8] of String = ('BDADOS', 'TABELAS', 'INDICEST', 'CAMPOST', 'CALCULADOS', 'CASCATAT', 'PROCESSOS',
                                      'RELACIONA', 'RESTRITAT');

  procedure AtualizaFonte(Nome: String);
  begin
    if FileExists(Projeto.Pasta + Nome + '.Dcu' ) then
      DeleteFile(Projeto.Pasta + Nome + '.Dcu');
    if FileExists(Projeto.Pasta + Nome + '.Pas' ) then
      DeleteFile(Projeto.Pasta + Nome + '.Pas');
    if FileExists(Projeto.Pasta + Nome + '.Dfm' ) then
      DeleteFile(Projeto.Pasta + Nome + '.Dfm');
  end;

begin
  BaseDados.ConectaBase_Anterior(Projeto.Pasta + 'Projeto.Pro', 0);
  BaseDados.ConectaBase_Anterior(Projeto.Dicionario + 'Dicionar.Dic', 1);
  try
    Progresso1.Position := 0;
    Progresso1.Max := 13;
    Progresso1.Min := 0;

    Query.Database := BaseDados.BD_Base_Projeto;
    Query.Transaction := BaseDados.TRS_BD_Base_Projeto;
    for I:=0 to 5 do
      Processa_Tabela(Tabelas_P[I], I + 5);


    Query.Database := BaseDados.BD_Base_Dicionario;
    Query.Transaction := BaseDados.TRS_BD_Base_Dicionario;
    for I:=0 to 8 do
      Processa_Tabela(Tabelas_D[I], I);

  except
    on Erro: Exception do
    begin
      Mensagem('Erro: ' + Erro.Message, modErro, [modOk]);
      Timer1.Enabled := True;
      BaseDados.FechaBase_Anterior;
      Exit;
    end;
  end;


  ForceDirectories(Projeto.Pasta+'Copia');
  ChDir(Projeto.Pasta);
  AtualizaFonte('Abertura');
  AtualizaFonte('Ambiente');
  AtualizaFonte('Atributo');
  AtualizaFonte('Backup');
  AtualizaFonte('BaseD');
  AtualizaFonte('Campo_Adapter');
  AtualizaFonte('CfgEmp');
  AtualizaFonte('Emp_Adapter');
  AtualizaFonte('Estrutur');
  AtualizaFonte('GridPesquisa');
  AtualizaFonte('Princ_Adapter');
  AtualizaFonte('Publicas');
  AtualizaFonte('Restaura');
  AtualizaFonte('RotinaEd');
  AtualizaFonte('Rotinas');
  AtualizaFonte('SelEmp');
  AtualizaFonte('Tabela');
  AtualizaFonte('Princ');
  AtualizaFonte('Interno');
  AtualizaFonte('EdGrp');
  AtualizaFonte('Acesso');
  FormPrincipal.RegerarModulos := True;
  Sucesso := True;
  Timer1.Enabled := True;
end;


procedure TFormAtualizaVersao.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

procedure TFormAtualizaVersao.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  Processa;
end;

end.
