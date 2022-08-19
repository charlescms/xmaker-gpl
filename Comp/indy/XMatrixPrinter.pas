unit XMatrixPrinter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
	 TXFontType=(ftCondensed, ftExpand, ftMiddle, ftSingle);
   TXPaper=(paBobbin75, paBobbin89, paLetter);
   TXPort=(LPT1, LPT2, USB001);

   
	TXMatrixPrinter = class(TComponent)
  	private
      Arquivo       : TextFile;
      Linha, Coluna : Integer;
      FAdvanceLines:Byte;
      FAlignment:TAlignment;
      FBold:Boolean;
      FFontType:TXFontType;
      FPaper:TXPaper;
      FPort:TXPort;
      FInicializado:Boolean;
      
      procedure Imprimir(Ln : Integer; Cl: Integer; Texto : String);
      procedure IniciaImpressora;
      procedure NegritoOn;
      procedure NegritoOff;
      procedure ExpandidoOn;
      procedure ExpandidoOff;
      procedure CondensadoOn;
      procedure CondensadoOff;
      procedure ItalicoOn;
      procedure ItalicoOff;
      procedure Normaliza;
      procedure Ejetar;
      procedure Reduz12cpi;
      procedure SublinhadoOn;
      procedure SublinhadoOff;
      procedure TamanhoPagina(linhas : integer);
      procedure EspacamentodaLinha(numero: integer);
      procedure SetBold(Estado:Boolean);
      function  TrocaAcentos(texto : string):string;
      procedure SetAdvanceLines(Linhas:Byte);
      procedure SetFontType(_FontType:TXFontType);
      function  PortToStr(_Port:TXPort):String;
  	protected
    { Protected declarations }
  	public
    { Public declarations }
		procedure Start;
      procedure BeginPrintProcess(_Port : String);
      procedure Terminate;
      procedure EndPrintProcess;
      function  PrinterOnLine(_Port:TXPort):Boolean;
      procedure EndBobbinProcess;
      procedure InitializePrinter;
      procedure PutIntoPrinter(Line : Integer; Column : Integer; Text : string);
      procedure Print(Texto : String);
      procedure Line;
      procedure BoldOn;
      procedure BoldOff;
      procedure ExpOn;
      procedure ExpOff;
      procedure CondensedOn;
      procedure CondensedOff;
      procedure ItalicOn;
      procedure ItalicOff;
      procedure Normal;
      procedure Eject;
      procedure R12cpi;
      procedure UnderlineOn;
      procedure UnderlineOff;
      procedure SetLengthPageinLines(lines: integer);
      procedure LineSpacingMode(Mode : integer);
      function  PCol : integer;
      function  PRow : integer;
	published
    { Published declarations }
		property  AdvanceLines:Byte read FAdvanceLines write FAdvanceLines default 5;
      property  Alignment:TAlignment read FAlignment write FAlignment;
      property  Bold:Boolean read FBold write SetBold;
      property  FontType:TXFontType read FFontType write SetFontType;
      property  Paper:TXPaper read FPaper write FPaper;
      property  Port:TXPort read FPort write FPort;
  	end;

procedure Register;

implementation

//Retorna o tipo de porta
function  TXMatrixPrinter.PortToStr(_Port:TXPort):String;
begin
	case _Port of 
   	LPT1:
      begin
      	result:='LPT1';
      end;
   	LPT2:
      begin
      	result:='LPT2';
      end;
   end;
end;

//Seta o tipo de fonte
procedure TXMatrixPrinter.SetFontType(_FontType:TXFontType);
begin
   FFontType:=_FontType;
   case _FontType of
	   ftCondensed:
   	begin
      	CondensadoOn;
	   end;
      ftExpand:
      begin
      	ExpandidoOn;
      end;
      ftMiddle:
      begin
      	R12Cpi;
      end;
      ftSingle:
      begin
      	Normal;
      end;
   end;
end;   

//N˙mero de linhas a imprimir no final do cupom
procedure TXMatrixPrinter.SetAdvanceLines(Linhas:Byte);
begin
   FAdvanceLines:=Linhas;
end;

//Seta o estado do bold na impressora
procedure TXMatrixPrinter.SetBold(Estado:Boolean);
begin
	FBold:=Estado;
   if Estado then
   begin
      BoldOn;
   end
   else
   begin
      BoldOff;
   end;
end;

//***************************************** Troca Acentos
function TXMatrixPrinter.TrocaAcentos(Texto : string):string;
Const
   ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
Var
   x : Integer;
begin
   for x := 1 to Length(ComAcento) do
     if Pos(ComAcento[x],Texto) <> 0 then
        case x of
          1 : Texto[Pos(ComAcento[x],Texto)] := chr(133);
          2 : Texto[Pos(ComAcento[x],Texto)] := chr(131);
          3 : Texto[Pos(ComAcento[x],Texto)] := chr(136);
          4 : Texto[Pos(ComAcento[x],Texto)] := chr(147);
          5 : Texto[Pos(ComAcento[x],Texto)] := chr(150);
          8 : Texto[Pos(ComAcento[x],Texto)] := chr(160);
          9 : Texto[Pos(ComAcento[x],Texto)] := chr(130);
         10 : Texto[Pos(ComAcento[x],Texto)] := chr(161);
         11 : Texto[Pos(ComAcento[x],Texto)] := chr(162);
         12 : Texto[Pos(ComAcento[x],Texto)] := chr(163);
         13 : Texto[Pos(ComAcento[x],Texto)] := chr(135);
         14 : Texto[Pos(ComAcento[x],Texto)] := chr(129);
         23 : Texto[Pos(ComAcento[x],Texto)] := chr(144);
         27 : Texto[Pos(ComAcento[x],Texto)] := chr(128);
         28 : Texto[Pos(ComAcento[x],Texto)] := chr(154);
        end;
Result := Texto;
end;


//***************************************** EspaÁamento da Linha;
// mode 2 È default
procedure TXMatrixPrinter.LineSpacingMode(Mode :Integer);
begin
   EspacamentodaLinha(Mode);
end;

procedure TXMatrixPrinter.EspacamentodaLinha(numero : integer);
begin
  if not ((numero < 0) or (numero > 2)) then
     Write(arquivo,CHR(27)+CHR(45)+ '1' );
end;


//***************************************** Sublinhados;
procedure TXMatrixPrinter.UnderlineOn;
begin
  SublinhadoOn;
end;

procedure TXMatrixPrinter.UnderlineOff;
begin
  SublinhadoOff;
end;

procedure TXMatrixPrinter.SublinhadoOn;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
   Write(arquivo,CHR(27)+CHR(45)+ '1' );
end;

procedure TXMatrixPrinter.SublinhadoOff;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(arquivo,CHR(27)+CHR(45)+ '0' );
end;


//*********************************** Tamanho da pagina em Linhas;
procedure TXMatrixPrinter.SetLengthPageinLines(Lines : Integer);
begin
  TamanhoPagina(Lines);
end;

procedure TXMatrixPrinter.TamanhoPagina(Linhas : integer);
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(arquivo,CHR(27)+CHR(67)+ InttoStr(Linhas) );
end;

//*********************************** Reduz 12 cpi;
procedure TXMatrixPrinter.R12cpi;
begin
	Reduz12cpi;
end;

procedure TXMatrixPrinter.Reduz12cpi;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
	Write(arquivo,CHR(27)+CHR(77));
end;

//*********************************** Eject;
procedure TXMatrixPrinter.Eject;
begin
   Ejetar;
end;

procedure TXMatrixPrinter.Ejetar;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
	Write(arquivo,chr(12));
end;

//*********************************** Normal;
procedure TXMatrixPrinter.Normal;
begin
  Normaliza;
end;

procedure TXMatrixPrinter.Normaliza;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
	Write(Arquivo,CHR(27)+CHR(080));
end;

//************************************* It·licos
procedure TXMatrixPrinter.ItalicOn;
begin
  ItalicoOn;
end;

procedure TXMatrixPrinter.ItalicOff;
begin
  ItalicoOff;
end;

procedure TXMatrixPrinter.ItalicoOn;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
	Write(Arquivo,CHR(27)+CHR(52));
end;

procedure TXMatrixPrinter.ItalicoOff;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
	Write(Arquivo,CHR(27)+CHR(53));
end;

//**************************************  Condensados
procedure TXMatrixPrinter.CondensedOn;
begin
  CondensadoOn;
end;

procedure TXMatrixPrinter.CondensedOff;
begin
  CondensadoOff;
end;

procedure TXMatrixPrinter.CondensadoOn;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,CHR(15));
end;

procedure TXMatrixPrinter.CondensadoOff;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,CHR(18));
end;

//******************************** Expandidos
procedure TXMatrixPrinter.ExpOn;
begin
   ExpandidoOn;
end;

procedure TXMatrixPrinter.ExpOff;
begin
  ExpandidoOff;
end;

procedure TXMatrixPrinter.ExpandidoOn;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,CHR(27)+CHR(87)+CHR(1));
end;

procedure TXMatrixPrinter.ExpandidoOff;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,CHR(27)+CHR(87)+CHR(0));
end;

//*********************************** Negritos
procedure TXMatrixPrinter.BoldOn;
begin
   NegritoOn;
end;

procedure TXMatrixPrinter.BoldOff;
begin
   NegritoOff;
end;

procedure TXMatrixPrinter.NegritoOn;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,CHR(27)+CHR(69));
end;

procedure TXMatrixPrinter.NegritoOff;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,CHR(27)+CHR(70));
end;

//******************************* Retorna coluna
function  TXMatrixPrinter.PCol;
var
  col1 : integer;
begin
   col1 := coluna;
   Result := col1;
end;

//******************************* Retorna Linha
function TXMatrixPrinter.PRow;
var
 ln1 : integer;
begin
  ln1 := linha;
  Result := ln1;
end;

//********************************************* Inicia Impressora
procedure TXMatrixPrinter.InitializePrinter;
begin
    IniciaImpressora;
end;

procedure TXMatrixPrinter.IniciaImpressora;
begin
	if Not FInicializado then
   begin
      exit;
   end;   
  Write(Arquivo,Chr(27) + chr(64));
end;

//*******************************************
// Prepara impressora e arquivo
// de impress„o
//*******************************************
function TXMatrixPrinter.PrinterOnLine(_Port:TXPort):Boolean;
begin
   result:=True;
end;   

procedure TXMatrixPrinter.Start;
begin
   BeginPrintProcess(PortToStr(Port));
end;   

procedure TXMatrixPrinter.BeginPrintProcess(_Port : string);
begin
	try
   	FInicializado:=True;
		AssignFile(Arquivo,_Port);
		Rewrite(Arquivo);
		Write(Arquivo,Chr(27) + chr(64)); // reseta impressora;
		Linha  := 0;
		Coluna := 0;
   except
      On E:Exception do
      begin
         MessageDlg(E.Message,mtError,[mbOk],0);
      end;
   end;
end;

//*******************************************
// Finaliza a impress„o com X Linhas e
// fecha arquivo de impress„o
//*******************************************
procedure TXMatrixPrinter.Terminate;
begin
	EndBobbinProcess;
end;

procedure TXMatrixPrinter.EndBobbinProcess;
var
	x:Byte;
begin
	for x:=0 to FAdvanceLines do
   begin
      Line;
   end;
	try
		//Write(arquivo,chr(12));
		CloseFile(Arquivo);
      FInicializado:=False;
   except
      On E:Exception do
      begin
         MessageDlg(E.Message,mtError,[mbOk],0);
      end;
   end;
end;

//*******************************************
// Finaliza a impress„o com um Eject e
// fecha arquivo de impress„o
//*******************************************
procedure TXMatrixPrinter.EndPrintProcess;
begin
	if Not FInicializado then
   begin
      exit;
   end;   

	try
		Write(arquivo,chr(12));
		CloseFile(Arquivo);
      FInicializado:=False;
   except
      On E:Exception do
      begin
         MessageDlg(E.Message,mtError,[mbOk],0);
      end;
   end;
end;

//*******************************************
// Chama o mÈtodo que imprime
//*******************************************
procedure TXMatrixPrinter.PutIntoPrinter(Line : Integer; Column : Integer; Text : string);
begin
	if Not FInicializado then
   begin
      exit;
   end;   
   Imprimir(Line, Column, Text);
end;

//*********************************************
// MÈtodo que imprime na linha e coluna espe-
// cificada
//*********************************************
procedure TXMatrixPrinter.Imprimir(Ln : Integer; Cl: Integer; Texto : String);
var
  salto    : integer;
  x        : integer;
  diferenca: integer;
begin
   if Not FInicializado then
   begin
      exit;
   end;
     if Ln  < Linha then
        raise exception.Create('Linha informada inv·lida !!! ' + #13 +
                               'n∫ ' + IntToStr(Ln))
     else
         begin
           if Ln > Linha then
              begin
                salto := Ln - Linha;
                Coluna := 0;
                for x := 1 to salto do
                   WriteLn(arquivo,'');
              end;
           Linha := Ln;
         end;

     if Cl < Coluna then
        raise exception.Create('Coluna informada inv·lida !!!' + #13 +
                               'n∫ ' + InttoStr(Cl))
     else
      if cl > 0 then
         diferenca := (cl - coluna);
         for x := 1 to diferenca do
             begin
               Write(Arquivo,' ');
               inc(coluna);
             end;
     if length(Texto)=0 then exit;
     for x:= 0 to length(Texto) do
         begin
           if texto[x] = '¿' then  write(Arquivo,chr(96) + chr(8) + chr(65))
            else
              if texto[x] = ' ' then  write(Arquivo,chr(94) + chr(8) + chr(69))
                else
                  if texto[x] = '‘' then  write(Arquivo,chr(94) + chr(8) + chr(79))
                   else
                     if texto[x] = '€' then  write(Arquivo,chr(94) + chr(8) + chr(85))
                      else
                        if texto[x] = '√' then  write(Arquivo,chr(126) + chr(8) + chr(65))
                          else
                           if texto[x] = '’' then  write(Arquivo,chr(126) + chr(8) + chr(79))
                            else
                             if texto[x] = '¡' then  write(Arquivo,chr(39) + chr(8) + chr(65))
                              else
                               if texto[x] = '…' then  write(Arquivo,chr(39) + chr(8) + chr(69))
                                 else
                                 if texto[x] = '”' then  write(Arquivo,chr(39) + chr(8) + chr(79))
                                  else
                                   if texto[x] = 'Õ' then  write(Arquivo,chr(39) + chr(8) + chr(73))
                                     else
                                     if texto[x] = '⁄' then  write(Arquivo,chr(39) + chr(8) + chr(85))
                                       else
                                         if texto[x] = '„' then write(Arquivo,chr(126) + chr(8) + chr(97))
                                            else
                                              if texto[x] = 'ı' then write(Arquivo, chr(126) + chr(8) + chr(111))
                                                 else

            write(Arquivo,TrocaAcentos(Texto[x]));
            inc(coluna);
         end;
     dec(coluna);
end;

procedure TXMatrixPrinter.Print(Texto : String);
var
  x        : integer;
begin
	if Not FInicializado then
   begin
      exit;
   end;   

	try
		if length(Texto)=0 then
   	begin
   		Write(Arquivo,'');
	   end
   	else
	   begin
   	  for x:= 0 to length(Texto) do
      	   begin
         	  if texto[x] = '¿' then  write(Arquivo,chr(96) + chr(8) + chr(65))
	            else
   	           if texto[x] = ' ' then  write(Arquivo,chr(94) + chr(8) + chr(69))
      	          else
         	         if texto[x] = '‘' then  write(Arquivo,chr(94) + chr(8) + chr(79))
            	       else
               	      if texto[x] = '€' then  write(Arquivo,chr(94) + chr(8) + chr(85))
                  	    else
                     	   if texto[x] = '√' then  write(Arquivo,chr(126) + chr(8) + chr(65))
                        	  else
                           	if texto[x] = '’' then  write(Arquivo,chr(126) + chr(8) + chr(79))
	                            else
   	                          if texto[x] = '¡' then  write(Arquivo,chr(39) + chr(8) + chr(65))
      	                        else
         	                      if texto[x] = '…' then  write(Arquivo,chr(39) + chr(8) + chr(69))
            	                     else
               	                  if texto[x] = '”' then  write(Arquivo,chr(39) + chr(8) + chr(79))
                  	                else
                     	              if texto[x] = 'Õ' then  write(Arquivo,chr(39) + chr(8) + chr(73))
                        	             else
                              	       if texto[x] = '⁄' then  write(Arquivo,chr(39) + chr(8) + chr(85))
                           	   		    else
                                       	 if texto[x] = '„' then write(Arquivo,chr(126) + chr(8) + chr(97))
                                             else
                                             	if texto[x] = 'ı' then write(Arquivo, chr(126) + chr(8) + chr(111))
                                                 else

	            write(Arquivo,TrocaAcentos(Texto[x]));
   	      end;
	   end;
   	write(Arquivo,#13+#10);
	except
      On E:Exception do
      begin
         MessageDlg(E.Message,mtError,[mbOk],0);
      end;
   end;
end;

procedure TXMatrixPrinter.Line;
begin
	Print('');
end;
procedure Register;
begin
  RegisterComponents('X-Maker', [TXMatrixPrinter]);
end;

end.
