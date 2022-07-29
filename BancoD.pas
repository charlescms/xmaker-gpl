unit BancoD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, Grids, DBGrids, DBCtrls, Mask, ToolEdit,
  RXDBCtrl, ShellApi;

type
  TFormBancoDados = class(TForm)
    Panel1: TPanel;
    Bevel3: TBevel;
    Lb_Servidor: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    BtnNovoBanco: TSpeedButton;
    BtnDeletarBanco: TSpeedButton;
    Label20: TLabel;
    BtnAjudaBanco: TBitBtn;
    BtnFechar: TBitBtn;
    OpenGDB: TOpenDialog;
    BtnAtualizar: TBitBtn;
    BtnCancela: TBitBtn;
    BoxPar: TGroupBox;
    GridBase: TDBGrid;
    DataSource: TDataSource;
    EdNome: TDBEdit;
    EdLogin: TDBCheckBox;
    EdUsuario: TDBEdit;
    EdSenha: TDBEdit;
    MemoPar: TDBMemo;
    EdServidor: TRxDBComboEdit;
    LbHost: TLabel;
    EdHostName: TDBEdit;
    EdPadrao: TDBCheckBox;
    Label13: TLabel;
    EdBanco: TDBComboBox;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnDeletarBancoClick(Sender: TObject);
    procedure BtnServidorExit(Sender: TObject);
    procedure EdServidorExit(Sender: TObject);
    procedure MemoParExit(Sender: TObject);
    procedure MemoParEnter(Sender: TObject);
    procedure GridBaseDblClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure BtnNovoBancoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdServidorButtonClick(Sender: TObject);
    procedure EdBancoDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure EdNomeChange(Sender: TObject);
    procedure EdBancoChange(Sender: TObject);
    procedure EdPadraoExit(Sender: TObject);
    procedure GridBaseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAjudaBancoClick(Sender: TObject);
  private
    { Private declarations }
    Cancelar: Boolean;
    procedure HabilitaCampos(Habilitar: Boolean);
  public
    { Public declarations }
  end;

var
  FormBancoDados: TFormBancoDados;

implementation

uses Rotinas, Princ, Selecao, Gera_01, Abertura, Estrutura_Bd, Tabela;

{$R *.DFM}

procedure TFormBancoDados.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormBancoDados.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(13)) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end;
end;

procedure TFormBancoDados.FormShow(Sender: TObject);
begin
  Cancelar := False;
  //Application.HelpFile := Projeto.PastaGerador + 'xMaker.Hlp';
  DataSource.DataSet := TabGlobal_i.DBDADOS;
  EdLogin.ValueChecked   := '1';
  EdLogin.ValueUnchecked := '0';

  EdPadrao.ValueChecked   := '1';
  EdPadrao.ValueUnchecked := '0';

  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Clear;
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('firebird-1.0');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('firebird-1.5');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('interbase-5');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('interbase-6');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('ado');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('sybase');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('mssql');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('mysql');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('mysql-3.20');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('mysql-3.23');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('mysql-4.0');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('postgresql');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('postgresql-6.5');
  TabGlobal_i.DBDADOS.BDADOS.DescValorValido.Add('postgresql-7.2');

  HabilitaCampos(False);
end;

procedure TFormBancoDados.BtnDeletarBancoClick(Sender: TObject);
begin
  if TabGlobal_i.DBDADOS.NUMERO.Conteudo < 1 then
    exit;
  if Mensagem('Excluir Banco de Dados ?'+^M+^M+TabGlobal_i.DBDADOS.NOME.Conteudo,ModConfirmacao,[ModSim, ModNao]) = mrno then
     Abort;

  EdBanco.OnChange := Nil;
  EdNome.OnChange := Nil;

  TabGlobal_i.DBDADOS.Exclui;
  //FormEstruturas.Modificou := True;

  EdBanco.OnChange := EdBancoChange;
  EdNome.OnChange := EdNomeChange;
end;

procedure TFormBancoDados.BtnServidorExit(Sender: TObject);
begin
  EdServidor.SetFocus;
end;

procedure TFormBancoDados.EdServidorExit(Sender: TObject);
begin
  if (ActiveControl = BtnFechar) or
     (ActiveControl = BtnAjudaBanco) then
    Abort;
  if RetiraBrancos(EdServidor.Text) = '' then
  begin
    Mensagem('Arquivo inválido !',ModAdvertencia,[ModOk]);
    EdServidor.SetFocus;
    abort;
  end;
end;

procedure TFormBancoDados.MemoParExit(Sender: TObject);
begin
  KeyPreview := True;
  BtnAtualizar.SetFocus;
end;

procedure TFormBancoDados.MemoParEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TFormBancoDados.HabilitaCampos(Habilitar: Boolean);
begin
  if Habilitar then
  begin
    EdNome.Enabled          := True;
    EdServidor.Enabled      := True;
    EdLogin.Enabled         := True;
    EdUsuario.Enabled       := True;
    EdSenha.Enabled         := True;
    MemoPar.Enabled         := True;
    BtnAtualizar.Enabled    := True;
    BtnCancela.Enabled      := True;
    EdHostName.Enabled      := True;
    EdPadrao.Enabled        := True;
    EdBanco.Enabled         := True;
    BtnNovoBanco.Enabled    := False;
    BtnDeletarBanco.Enabled := False;
    GridBase.Enabled        := False;
    EdNomeChange(Self);
    if EdPadrao.Enabled then
      EdPadrao.SetFocus
    else
    begin
      EdNome.SelectAll;
      EdNome.SetFocus;
    end
  end
  else
  begin
    EdNome.Enabled          := False;
    EdServidor.Enabled      := False;
    EdLogin.Enabled         := False;
    EdUsuario.Enabled       := False;
    EdSenha.Enabled         := False;
    MemoPar.Enabled         := False;
    BtnAtualizar.Enabled    := False;
    BtnCancela.Enabled      := False;
    EdHostName.Enabled      := False;
    EdPadrao.Enabled        := False;
    EdBanco.Enabled         := False;
    BtnNovoBanco.Enabled    := True;
    BtnDeletarBanco.Enabled := True;
    GridBase.Enabled        := True;
    GridBase.Refresh;
    GridBase.SetFocus;
  end;
end;

procedure TFormBancoDados.GridBaseDblClick(Sender: TObject);
begin
  if TabGlobal_i.DBDADOS.NUMERO.Conteudo > 0 then
  begin
    TabGlobal_i.DBDADOS.Modifica;
    HabilitaCampos(True);
  end;
end;

procedure TFormBancoDados.BtnAtualizarClick(Sender: TObject);
begin
  if TabGlobal_i.DBDADOS.BDADOS.Conteudo < 1 then
  begin
    Mensagem('Necessário informar Banco de Dados!',ModAdvertencia,[modOk]);
    EdPadrao.SetFocus;
    exit;
  end;
  if Trim(TabGlobal_i.DBDADOS.NOME.Conteudo) = '' then
  begin
    Mensagem('Necessário informar Nome da Base de Dados (Alias)!',ModAdvertencia,[modOk]);
    EdNome.SetFocus;
    exit;
  end;
  if PTabela(TabGlobal_i.DBDADOS, ['<>numero', 'UPPER(nome)'], [TabGlobal_i.DBDADOS.NUMERO.Conteudo, UpperCase(TabGlobal_i.DBDADOS.NOME.Conteudo)]) then
  begin
    Mensagem('Alias já Cadastrado!',ModAdvertencia,[modOk]);
    EdNome.SetFocus;
    exit;
  end;
  TabGlobal_i.DBDADOS.Salva;
  HabilitaCampos(False);
  //FormEstruturas.Modificou := True;
end;

procedure TFormBancoDados.BtnCancelaClick(Sender: TObject);
begin
  Cancelar := True;
  TabGlobal_i.DBDADOS.Cancela;
  HabilitaCampos(False);
  Cancelar := False;
end;

procedure TFormBancoDados.BtnNovoBancoClick(Sender: TObject);
Var
  Seq: Integer;
begin
  TabGlobal_i.DBDADOS.Last;
  Seq := TabGlobal_i.DBDADOS.NUMERO.Conteudo + 1;
  if (FREDT) and (Seq > 1) then
  begin
    Mensagem('Atenção! ,'+^M+^M+'Essa versão tem recurso para criação de somente de um '+^M+'Banco de Dados ...',modInformacao,[ModOk]);
    GridBase.SetFocus;
  end
  else
  begin
    Cancelar := True;
    TabGlobal_i.DBDADOS.Inclui(Nil);
    TabGlobal_i.DBDADOS.NUMERO.Conteudo    := Seq;
    TabGlobal_i.DBDADOS.PADRAO.Conteudo    := 1;
    TabGlobal_i.DBDADOS.BDADOS.Conteudo    := TabGlobal_i.DPROJETO.BDADOS.Conteudo;
    TabGlobal_i.DBDADOS.NOME.Conteudo      := 'Base_Dados';
    TabGlobal_i.DBDADOS.ARQUIVO.Conteudo   := 'BASE';
    TabGlobal_i.DBDADOS.LOGIN.Conteudo     := 0;
    if TabGlobal_i.DPROJETO.BDADOS.Conteudo <= 2 then
    begin
      TabGlobal_i.DBDADOS.USUARIO.Conteudo   := 'SYSDBA';
      TabGlobal_i.DBDADOS.SENHA.Conteudo     := 'masterkey';
    end
    else
    begin
      TabGlobal_i.DBDADOS.USUARIO.Conteudo   := 'root';
      TabGlobal_i.DBDADOS.SENHA.Conteudo     := '';
    end;
    //TabGlobal_i.DBDADOS.HOST_NAME.Conteudo := 'Localhost';
    Cancelar := False;
    HabilitaCampos(True);
  end;
end;

procedure TFormBancoDados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if BtnAtualizar.Enabled then
  begin
    Mensagem('Confirme a atualização da Base de Dados !',ModAdvertencia,[modOk]);
    Action := caNone;
  end;
end;

procedure TFormBancoDados.EdServidorButtonClick(Sender: TObject);
var
   PathEscolhido : String;
begin
  if TabGlobal_i.DBDADOS.BDADOS.Conteudo > 4 then
    exit;
  OpenGDB.Filter := 'Banco de dados FireBird 6.x (*.GDB *.FDB)|*.GDB;*.FDB';
  OpenGDB.FileName := EdServidor.Text;
  if OpenGDB.Execute then
  begin
    EdServidor.Text := UpperCase(ExtractFileName(OpenGDB.FileName));
    if Pos('.',EdServidor.Text) > 0 then
      EdServidor.Text := Copy(EdServidor.Text,01,Pos('.',EdServidor.Text)-1);
  end;
end;

procedure TFormBancoDados.EdBancoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var Canvas : TCanvas;
begin
  if Control is TDBComboBox then
    Canvas  := (Control as TDBComboBox).Canvas
  else
    Canvas  := (Control as TComboBox).Canvas;
  Canvas.FillRect(Rect);
  if TabGlobal_i.DBDADOS.BDADOS.DescValorValido[Index] = '' then
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DBDADOS.BDADOS.ValorValido[Index]))
  else
    Canvas.TextOut(Rect.Left + 2, Rect.Top, RetiraHK(TabGlobal_i.DBDADOS.BDADOS.DescValorValido[Index]));
end;

procedure TFormBancoDados.EdNomeChange(Sender: TObject);
var
  Edicao: Boolean;
begin
  if Cancelar then exit;
  Edicao := ((TabGlobal_i.DBDADOS.Inclusao) or (TabGlobal_i.DBDADOS.Modificacao));
  if TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 1 then
  begin
    EdPadrao.Enabled := False;
    if not Edicao then
      TabGlobal_i.DBDADOS.Modifica;
    TabGlobal_i.DBDADOS.PADRAO.Conteudo := 1;
    if not Edicao then
      TabGlobal_i.DBDADOS.Salva;
  end
  else
    EdPadrao.Enabled := True;
  if TabGlobal_i.DBDADOS.PADRAO.Conteudo = 1 then
  begin
    if not Edicao then
      TabGlobal_i.DBDADOS.Modifica;
    TabGlobal_i.DBDADOS.BDADOS.Conteudo := TabGlobal_i.DPROJETO.BDADOS.Conteudo;
    if not Edicao then
      TabGlobal_i.DBDADOS.Salva;
    EdBanco.Enabled := False;
  end
  else
    EdBanco.Enabled := True;
  EdBancoChange(Self);
end;

procedure TFormBancoDados.EdBancoChange(Sender: TObject);
begin
  if TabGlobal_i.DBDADOS.BDADOS.Conteudo > 4 then
    EdServidor.ButtonWidth := 0
  else
    EdServidor.ButtonWidth := 16;  
  {if TabGlobal_i.DBDADOS.BDADOS.Conteudo < 5 then
  begin
    LbHost.Visible := False;
    EdHostName.Visible := False;
    Lb_Servidor.Caption := 'Servidor';
    EdServidor.Button.Visible := True;
  end
  else
  begin
    LbHost.Visible := True;
    EdHostName.Visible := True;
    Lb_Servidor.Caption := 'DataBase';
    EdServidor.Button.Visible := False;
  end;}
end;

procedure TFormBancoDados.EdPadraoExit(Sender: TObject);
begin
  if (ActiveControl = BtnAtualizar) or (ActiveControl = BtnCancela) then
    exit;
  if (not EdPadrao.Checked) and (TabGlobal_i.DPROJETO.BDCONEXAO.Conteudo = 2) then
  begin
    EdBanco.Enabled := True;
    EdBanco.SetFocus;
  end
  else
  begin
    EdBanco.Enabled := False;
    EdNome.SelectAll;
    EdNome.SetFocus;
  end;
  EdNomeChange(Self);
end;

procedure TFormBancoDados.GridBaseKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_INSERT then
    if BtnNovoBanco.Enabled then
      BtnNovoBancoClick(Self);
  if Key = VK_DELETE then
    if BtnDeletarBanco.Enabled then
      BtnDeletarBancoClick(Self);
end;

procedure TFormBancoDados.BtnAjudaBancoClick(Sender: TObject);
begin
  ChamaAjuda;

end;

end.
