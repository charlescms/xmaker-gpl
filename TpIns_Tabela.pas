unit TpIns_Tabela;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TFormTpIns_Tabela = class(TForm)
    CancelBtn: TButton;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Tipo: Integer;
  end;

var
  FormTpIns_Tabela: TFormTpIns_Tabela;

implementation

{$R *.DFM}

procedure TFormTpIns_Tabela.BitBtn1Click(Sender: TObject);
begin
  Tipo := TBitBtn(Sender).Tag;
  ModalResult := mrOk;
end;

procedure TFormTpIns_Tabela.BitBtn1Enter(Sender: TObject);
begin
  CancelBtn.Font.Style := [];
  BitBtn1.Font.Style   := [];
  BitBtn2.Font.Style   := [];
  BitBtn3.Font.Style   := [];
  BitBtn4.Font.Style   := [];
  BitBtn5.Font.Style   := [];
  BitBtn6.Font.Style   := [];
  BitBtn7.Font.Style   := [];
  BitBtn8.Font.Style   := [];
  BitBtn9.Font.Style   := [];
  BitBtn10.Font.Style  := [];
  TBitBtn(Sender).Font.Style := [fsBold];
end;

end.
