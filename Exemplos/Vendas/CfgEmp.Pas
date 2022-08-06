{
   Programa.: CfgEmp.PAS
   Copyright: Modular Software 2006
            : Todos os direitos reservados
   Site.....: http://www.xmaker.com.br
}
unit CfgEmp;

interface

{$I Princ.inc}

uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, BaseD, IBDatabase,
  {$IFDEF IBX}
  {$ELSE}
  XSEngine,
  {$ENDIF}
  ExtDlgs, Menus;

type
  TFormConfiguraEmpresa = class(TForm)
    Panel1: TPanel;
    lblBanco: TLabel;
    lbBancos: TListBox;
    lbTabelas: TListBox;
    lblTableas: TLabel;
    Panel2: TPanel;
    BtnCancela: TBitBtn;
    lblServer: TLabel;
    EdLocalizacao: TEdit;
    BtnLocalizar: TBitBtn;
    BtnOk: TBitBtn;
    dlgOpen: TOpenDialog;
    EdEmpresa: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdEndereco: TEdit;
    Label3: TLabel;
    EdBairro: TEdit;
    Label4: TLabel;
    EdCidade: TEdit;
    Label5: TLabel;
    EdUF: TEdit;
    Label6: TLabel;
    EdCEP: TEdit;
    Label7: TLabel;
    EdCNPJ: TEdit;
    Label8: TLabel;
    EdInscricao: TEdit;
    Label9: TLabel;
    EdFones: TEdit;
    Bevel1: TBevel;
    Image1: TImage;
    Image2: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EdNumero: TEdit;
    BtnAplicar: TBitBtn;
    Bevel2: TBevel;
    ImagemLogo: TImage;
    EdImagem: TEdit;
    BtnImagem: TBitBtn;
    OpenPictureImagem: TOpenPictureDialog;
    BtnIndexar: TBitBtn;
    Label13: TLabel;
    EdServidor: TEdit;
    EdBancoDados: TComboBox;
    Label14: TLabel;
    EdUsuario: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    EdSenha: TEdit;
    BtnAutoI: TBitBtn;
    PopupMenu1: TPopupMenu;
    SelecionarTudo1: TMenuItem;
    LbVersao: TLabel;
    procedure BtnLocalizarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lbBancosClick(Sender: TObject);
    procedure lbTabelasDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOkClick(Sender: TObject);
    procedure EdLocalizacaoChange(Sender: TObject);
    procedure BtnAplicarClick(Sender: TObject);
    procedure EdEmpresaChange(Sender: TObject);
    procedure EdImagemExit(Sender: TObject);
    procedure BtnImagemClick(Sender: TObject);
    procedure BtnIndexarClick(Sender: TObject);
    procedure BtnAutoIClick(Sender: TObject);
    procedure SelecionarTudo1Click(Sender: TObject);
  private
    { Private declarations }
    ListaBase: TStringList;
    ListaHost: TStringList;
    ListaTab: TStringList;
    ListaBancoDados: TStringList;
    ListaUsuarios: TStringList;
    ListaSenhas: TStringList;
    ArqIni: TIniFile;
    Criou_BD: Boolean;
    function Aplicar: Boolean;
  public
    { Public declarations }
    NrEmpresa: String;
    NovaEmpresa: Boolean;
  end;

var
  FormConfiguraEmpresa: TFormConfiguraEmpresa;
  Gravou: Boolean;

implementation

uses FileCtrl, Rotinas, Publicas, Tabela, Atributo, Abertura;

{$R *.DFM}
{$R *.RES}

procedure TFormConfiguraEmpresa.FormShow(Sender: TObject);
Var
  I,Y : Integer;
  DataFile, Servidor: String;
begin
  ListaTab  := TStringList.Create;
  ListaBase := TStringList.Create;
  ListaHost := TStringList.Create;
  ListaBancoDados := TStringList.Create;
  ListaUsuarios   := TStringList.Create;
  ListaSenhas     := TStringList.Create;
  ArqIni    := TInifile.Create(Sistema.Pasta + 'SYSEMP.DAT');
  Gravou    := False;
  lbBancos.Items.Clear;
  lbTabelas.Items.Clear;
  EdNumero.Text    := NrEmpresa;
  EdEmpresa.Text   := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Nome', '');
  EdEndereco.Text  := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Endereco', '');
  EdBairro.Text    := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Bairro', '');
  EdCidade.Text    := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Cidade', '');
  EdUF.Text        := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'UF', '');
  EdCEP.Text       := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'CEP', '');
  EdCNPJ.Text      := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'CNPJ', '');
  EdInscricao.Text := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Inscricao', '');
  EdFones.Text     := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Fones', '');
  EdImagem.Text    := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Logo', '');
  Y := -1;
  for I := 0 to BaseDados.ListaBaseDados.Count-1 do
  begin
    Inc(Y);
    lbBancos.Items.Add(BaseDados.ListaBaseDados[I]);
    DataFile := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Base '+StrZero(Y,04), '');
    Servidor := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Host '+StrZero(Y,04), '');
    if Trim(DataFile) = '' then
      ListaBase.Add(BaseDados.ListaBaseDadosArq[I])
    else
      ListaBase.Add(DataFile);
    if Trim(Servidor) = '' then
      Servidor := BaseDados.ListaBaseDadosHost[I];
    ListaHost.Add(Servidor);
    ListaBancoDados.Add(ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Servidor '+StrZero(Y,04), '-1'));
    if ListaBancoDados[ListaBancoDados.Count-1] = '-1' then
    begin
      {$IFDEF IBX}
      ListaBancoDados[ListaBancoDados.Count-1] := '0';
      {$ELSE}
      with TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]) do
      begin
        if ServerType = stInterbase then
          ListaBancoDados[ListaBancoDados.Count-1] := '0'
        else if ServerType = stFirebird then
          ListaBancoDados[ListaBancoDados.Count-1] := '1'
        else if ServerType = stSQLBase then
          ListaBancoDados[ListaBancoDados.Count-1] := '2'
        else if ServerType = stOracle then
          ListaBancoDados[ListaBancoDados.Count-1] := '3'
        else if ServerType = stSQLServer then
          ListaBancoDados[ListaBancoDados.Count-1] := '4'
        else if ServerType = stSybase then
          ListaBancoDados[ListaBancoDados.Count-1] := '5'
        else if ServerType = stDB2 then
          ListaBancoDados[ListaBancoDados.Count-1] := '6'
        else if ServerType = stInformix then
          ListaBancoDados[ListaBancoDados.Count-1] := '7'
        else if ServerType = stODBC then
          ListaBancoDados[ListaBancoDados.Count-1] := '8'
        else if ServerType = stMySQL then
          ListaBancoDados[ListaBancoDados.Count-1] := '9'
        else if ServerType = stPostgreSQL then
          ListaBancoDados[ListaBancoDados.Count-1] := '10'
        else if ServerType = stOLEDB then
          ListaBancoDados[ListaBancoDados.Count-1] := '11';
      end;
      {$ENDIF}
    end;
    ListaUsuarios.Add(ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Usuario '+StrZero(Y,04), ''));
    ListaSenhas.Add(Decript(ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Senha '+StrZero(Y,04), '')));
  end;
  {$IFDEF IBX}
  EdBancoDados.Items.Clear;
  EdBancoDados.Items.Add('Interbase');
  EdBancoDados.Items.Add('Firebird');
  {$ENDIF}
  EdLocalizacao.OnChange := Nil;
  EdServidor.OnChange    := Nil;
  EdBancoDados.OnChange  := Nil;
  EdUsuario.OnChange     := Nil;
  EdSenha.OnChange       := Nil;
  EdLocalizacao.Text := '';
  BtnAplicar.Enabled := False;
  if lbBancos.Items.Count > 0 then
  begin
    lbBancos.ItemIndex := 0;
    lbBancosClick(Self);
  end;
  EdImagemExit(Self);
  EdLocalizacao.OnChange := EdLocalizacaoChange;
  EdServidor.OnChange    := EdLocalizacaoChange;
  EdBancoDados.OnChange  := EdLocalizacaoChange;
  EdUsuario.OnChange     := EdLocalizacaoChange;
  EdSenha.OnChange       := EdLocalizacaoChange;
  EdEmpresa.SelectAll;
  EdEmpresa.SetFocus;
end;

procedure TFormConfiguraEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (NovaEmpresa) and (not Gravou) then
    ArqIni.EraseSection('EMPRESA '+EdNumero.Text);
  ArqIni.Free;
  ListaTab.Free;
  ListaBase.Free;
  ListaHost.Free;
  ListaBancoDados.Free;
  ListaUsuarios.Free;
  ListaSenhas.Free;
end;

procedure TFormConfiguraEmpresa.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(13) then
  begin
    Perform(WM_NextDlgCtl, 0, 0);
    Key := #0;
  end
  else if Key = Chr(27) then
    Close;
end;

procedure TFormConfiguraEmpresa.BtnLocalizarClick(Sender: TObject);
begin
  with dlgOpen do
  begin
    Filter     := 'Todos arquivos (*.*)|*.*';
    FileName   := EdLocalizacao.Text;
    DefaultExt := 'GDB';
    Filter     := Filter + '|Banco de dados Interbase (*.GDB)|*.GDB';
    FilterIndex:= 2;
    FileName   := '*.GDB';
    if Execute then
      EdLocalizacao.Text := FileName;
  end;
end;

procedure TFormConfiguraEmpresa.lbBancosClick(Sender: TObject);
Var
  I : Integer;
  Tab: TTabela;
begin
  {$IFDEF IBX}
  LbVersao.Caption := '';
  LbVersao.Hint    := '';
  {$ELSE}
  LbVersao.Caption := 'Versão: ' + TXSQLDatabase(BaseDados.ListaBaseDados.Objects[lbBancos.ItemIndex]).Version;
  LbVersao.Hint    := LbVersao.Caption;
  {$ENDIF}
  EdLocalizacao.Text     := ListaBase[lbBancos.ItemIndex];
  EdServidor.Text        := ListaHost[lbBancos.ItemIndex];
  I := StrToIntDef(ListaBancoDados[lbBancos.ItemIndex], 0);
  if (I < 0) or (I > EdBancoDados.Items.Count-1) then
    I := 0;
  EdBancoDados.ItemIndex := I;
  EdUsuario.Text         := ListaUsuarios[lbBancos.ItemIndex];
  EdSenha.Text           := ListaSenhas[lbBancos.ItemIndex];
  lbTabelas.Items.Clear;
  ListaTab.Clear;
  for I := 0 to Lst_Tabelas.Count-1 do
  begin
    Tab := TTabela(Lst_Tabelas[I]);
    if Tab.DataBase.Name = lbBancos.Items[lbBancos.ItemIndex] then
    begin
      lbTabelas.Items.Add(Tab.NomeTabela+ ' - ' +Tab.Titulo);
      if Tab.Existe then
        ListaTab.Add('1')
      else
      begin
        ListaTab.Add('0');
        BtnAplicar.Enabled := True;
      end;
    end;
  end;
end;

procedure TFormConfiguraEmpresa.lbTabelasDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  with (Control as TListBox).Canvas do
  begin
    if Control = lbBancos then
      Bitmap.Handle := LoadBitmap(hInstance, 'Base')
    else
      if ListaTab[Index] = '1' then
        Bitmap.Handle := LoadBitmap(hInstance, 'Ok')
      else
        Bitmap.Handle := LoadBitmap(hInstance, 'NaoExiste');
    FillRect(Rect);
    BrushCopy(Bounds(Rect.Left, Rect.Top, Bitmap.Width, Bitmap.Height), Bitmap,
      Bounds(0, 0, Bitmap.Width, Bitmap.Height), clSilver);
    TextOut(Rect.Left + Bitmap.Width + 4, Rect.Top + 2, (Control as TListBox).Items[Index]);
    DeleteObject(Bitmap.Handle);
  end;
  Bitmap.Free;
end;

function TFormConfiguraEmpresa.Aplicar: Boolean;
Var
   I,Y: Integer;
   Ok: Boolean;
   DataFile, Servidor, Usuario, Senha: String;
   Tab: TTabela;
   SalvaParm: TStringList;
begin
  Ok := True;
  if Trim(EdEmpresa.Text) = '' then
  begin
    MessageDlg('Necessário informar EMPRESA !',mtError,[mbOk],0);
    EdEmpresa.SelectAll;
    EdEmpresa.SetFocus;
    Ok := False;
  end;
  try
    {$IFDEF IBX}
    for I:= 0 to ListaBase.Count-1 do
    begin
      if DirectoryExists(ExtractFilePath(ListaBase[I])) then
        if (not FileExists(ListaBase[I])) and (Trim(ListaBase[I]) <> '') then
        begin
          if MessageDlg('Base de Dados não encontrada: '+^M+^M+ListaBase[I]+^M+^M+'Deseja Criá-la ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
          begin
            SalvaParm := TStringList.Create;
            SalvaParm.Clear;
            SalvaParm.AddStrings(TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params);
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Close;

            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).DataBaseName := ListaBase[I];
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params.Clear;
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params.Add('USER '+#39+'SYSDBA'+#39);
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params.Add('PASSWORD '+#39+'masterkey'+#39);
            DB_LoginConexao(TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params, ListaUsuarios[I], Encript(ListaSenhas[I]));
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).CreateDatabase;
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Close;
            Criou_BD := True;

            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params.Clear;
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params := SalvaParm;
            TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Open;
            SalvaParm.Free;
          end;
        end;
    end;
    {$ELSE}
    for I:= 0 to ListaBase.Count-1 do
      if StrToIntDef(ListaBancoDados[I], 0) < 2 then
        if DirectoryExists(ExtractFilePath(ListaBase[I])) then
          if (not FileExists(ListaBase[I])) and (Trim(ListaBase[I]) <> '') then
            if MessageDlg('Base de Dados não encontrada: '+^M+^M+ListaBase[I]+^M+^M+'Deseja Criá-la ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
            begin
              with TIBDatabase.Create(Self) do
              begin
                DatabaseName := ListaBase[I];
                Params.Clear;
                Params.Add('USER '+#39+'SYSDBA'+#39);
                Params.Add('PASSWORD '+#39+'masterkey'+#39);
                DB_LoginConexao(Params, Usuario, Senha);
                CreateDatabase;
                Criou_BD := True;
                Free;
              end;
            end;
    {$ENDIF}
    if not Ok then
      lbBancos.SetFocus
    else
    begin
      Screen.Cursor := crHourGlass;
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Nome', EdEmpresa.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Endereco', EdEndereco.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Bairro', EdBairro.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Cidade', EdCidade.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'UF', EdUF.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'CEP', EdCEP.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'CNPJ', EdCNPJ.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Inscricao', EdInscricao.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Fones', EdFones.Text);
      ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Logo', EdImagem.Text);
      for I:= 0 to ListaBase.Count-1 do
      begin
        ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Base '+StrZero(I,04), ListaBase[I]);
        ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Host '+StrZero(I,04), ListaHost[I]);
        ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Servidor '+StrZero(I,04), ListaBancoDados[I]);
        ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Usuario '+StrZero(I,04), ListaUsuarios[I]);
        ArqIni.WriteString('EMPRESA '+EdNumero.Text, 'Senha '+StrZero(I,04), Encript(ListaSenhas[I]));
      end;
      Y := -1;
      for I := 0 to BaseDados.ListaBaseDados.Count-1 do
      begin
        {$IFDEF IBX}
        TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Close;
        {$ELSE}
        TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Connected := False;
        {$ENDIF}
        Inc(Y);
        DataFile := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Base '+StrZero(Y,04), '');
        Servidor := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Host '+StrZero(Y,04), '');
        Usuario  := ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Usuario '+StrZero(Y,04), '');
        Senha    := Decript(ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Senha '+StrZero(Y,04), ''));
        {$IFDEF IBX}
        if Trim(Servidor) <> '' then
          DataFile := Servidor + ':' + DataFile;
        DB_LoginConexao(TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Params, Usuario, Senha);
        TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).DataBaseName := DataFile;
        TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).Open;
        TIBDataBase(BaseDados.ListaBaseDados.Objects[I]).DefaultTransaction.StartTransaction;
        {$ELSE}
        case StrToIntDef(ArqIni.ReadString('EMPRESA '+EdNumero.Text, 'Servidor '+StrZero(Y,04), '0'), 0) of
          0: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stInterbase;
          1: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stFirebird;
          2: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stSQLBase;
          3: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stOracle;
          4: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stSQLServer;
          5: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stSybase;
          6: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stDB2;
          7: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stInformix;
          8: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stODBC;
          9: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stMySQL;
          10: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stPostgreSQL;
          11: TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).ServerType := stOLEDB;
        end;
        DB_LoginConexao(TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Params, Usuario, Senha);
        if Trim(Servidor) <> '' then
          TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).RemoteDatabase := Servidor + ':' + DataFile
        else
          TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).RemoteDatabase := DataFile;
        TXSQLDatabase(BaseDados.ListaBaseDados.Objects[I]).Connected := True;
        {$ENDIF}
      end;
      BaseDados.ListaNomeTabelas_DB.Clear;
      for I := 0 to Lst_Tabelas.Count-1 do
      begin
        Tab := TTabela(Lst_Tabelas[I]);
        if not Tab.Existe then
        begin
          Tab.CriaTabela(False);
          Tab.Indexar;
          {$IFDEF IBX}
          Tab.DataBase.Close; // Fecha Base de Dados para Atualizar em Disco
          Tab.DataBase.Open;  // Abre Base de Dados
          Tab.DataBase.DefaultTransaction.StartTransaction;
          {$ENDIF}
        end;
      end;
      if Criou_BD then
      begin
        TabGlobal.Executa_Scripts_Criacao_BD;
        Criou_BD := False;
      end;
      for I := 0 to Lst_Procedures.Count - 1 do
      begin
        with TSQLProcedure(Lst_Procedures[I]) do
          Criar;
      end;
      TabGlobal.Executa_Scripts_Inicializacao;
      Screen.Cursor := crDefault;
      lbBancosClick(Self);
      BtnAplicar.Enabled := False;
    end;
    Gravou := True;
    Result := Ok;
  except
    on Erro: Exception do
      begin
        Screen.Cursor := crDefault;
      MessageDlg('Erro: '+ Erro.Message, mtError, [mbOk], 0);
      Result := False;
    end;
  end;
end;

procedure TFormConfiguraEmpresa.BtnOkClick(Sender: TObject);
begin
  if BtnAplicar.Enabled then
  begin
    if Aplicar then
      Close;
  end
  else
    Close;
end;

procedure TFormConfiguraEmpresa.BtnAplicarClick(Sender: TObject);
begin
  Aplicar;
end;

procedure TFormConfiguraEmpresa.EdLocalizacaoChange(Sender: TObject);
begin
  ListaBase[lbBancos.ItemIndex] := EdLocalizacao.Text;
  ListaHost[lbBancos.ItemIndex] := EdServidor.Text;
  ListaBancoDados[lbBancos.ItemIndex] := IntToStr(EdBancoDados.ItemIndex);
  ListaUsuarios[lbBancos.ItemIndex] := EdUsuario.Text;
  ListaSenhas[lbBancos.ItemIndex] := EdSenha.Text;
  BtnAplicar.Enabled := True;
  BtnAutoI.Enabled := (EdBancoDados.ItemIndex < 2);
end;

procedure TFormConfiguraEmpresa.EdEmpresaChange(Sender: TObject);
begin
  if TEdit(Sender).Modified then
    BtnAplicar.Enabled := True;
end;

procedure TFormConfiguraEmpresa.EdImagemExit(Sender: TObject);
Var
  ImVazia: TPicture;
begin
  if FileExists(EdImagem.Text) then
    ImagemLogo.Picture.LoadFromFile(EdImagem.Text)
  else
  begin
    ImVazia := TPicture.Create;
    ImagemLogo.Picture := ImVazia;
    ImVazia.Free;
  end;
end;

procedure TFormConfiguraEmpresa.BtnImagemClick(Sender: TObject);
begin
  if OpenPictureImagem.Execute then
  begin
    EdImagem.Text := OpenPictureImagem.FileName;
    EdImagemExit(Self);
    BtnAplicar.Enabled := True;
  end;
  EdImagem.SetFocus;
end;

procedure TFormConfiguraEmpresa.BtnIndexarClick(Sender: TObject);
Var
  I, P: Integer;
  Tab: TTabela;
begin
  if lbTabelas.SelCount = 0 then
  begin
    MessageDlg('Nenhuma tabela selecionada!', mtWarning, [mbOk], 0);
    lbTabelas.SetFocus;
    exit;
  end;
  if MessageDlg('Indexar '+IntToStr(lbTabelas.SelCount)+' Tabela(s) selecionada(s) ?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  Screen.Cursor := crHourGlass;
  for I := 0 to Lst_Tabelas.Count-1 do
  begin
    Tab := TTabela(Lst_Tabelas[I]);
    P   := lbTabelas.Items.IndexOf(Tab.NomeTabela+ ' - ' +Tab.Titulo);
    if P <> -1 then
      if lbTabelas.Selected[P] then
         if Tab.Existe then
           Tab.Indexar;
  end;
  Screen.Cursor := crDefault;
  MessageDlg('Indexação Concluída !',mtInformation,[mbOk],0);
end;

procedure TFormConfiguraEmpresa.BtnAutoIClick(Sender: TObject);
Var
  I, P: Integer;
  Tab: TTabela;
begin
  if lbTabelas.SelCount = 0 then
  begin
    MessageDlg('Nenhuma tabela selecionada!', mtWarning, [mbOk], 0);
    lbTabelas.SetFocus;
    exit;
  end;
  if MessageDlg('Atualizar Autoincremento de '+IntToStr(lbTabelas.SelCount)+' Tabela(s) selecionada(s) ?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  Screen.Cursor := crHourGlass;
  for I := 0 to Lst_Tabelas.Count-1 do
  begin
    Tab := TTabela(Lst_Tabelas[I]);
    P   := lbTabelas.Items.IndexOf(Tab.NomeTabela+ ' - ' +Tab.Titulo);
    if P <> -1 then
      if lbTabelas.Selected[P] then
         if Tab.Existe then
         begin
           if Tab.Campos.Count > 0 then
             if (TAtributo(Tab.Campos[0]).AutoIncremento > 0) then
               Tab.AutoIncremento((TAtributo(Tab.Campos[0]).Nome), False, 0, True);
         end;
  end;
  Screen.Cursor := crDefault;
  MessageDlg('Atualização Concluída !',mtInformation,[mbOk],0);
end;

procedure TFormConfiguraEmpresa.SelecionarTudo1Click(Sender: TObject);
var
  I: Integer;
begin
  for I:=0 to lbTabelas.Items.Count-1 do
    lbTabelas.Selected[I] := True;
end;

end.
