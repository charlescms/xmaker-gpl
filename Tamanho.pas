unit Tamanho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFormTamanho = class(TForm)
    GroupBox1: TGroupBox;
    hNoChange: TRadioButton;
    hShrink: TRadioButton;
    hGrow: TRadioButton;
    hAbsolute: TRadioButton;
    hWidth: TEdit;
    GroupBox2: TGroupBox;
    vNoChange: TRadioButton;
    vShrink: TRadioButton;
    vGrow: TRadioButton;
    vAbsolute: TRadioButton;
    vHeight: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure hAbsoluteClick(Sender: TObject);
    procedure vAbsoluteClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResizeControl(Size:Integer;IsWidth:Boolean);
    function  GetMaxValue(IsWidth:Boolean):Integer;
    function  GetMinValue(IsWidth:Boolean):Integer;
  public
    { Public declarations }
  end;

var
  FormTamanho: TFormTamanho;

implementation

uses ObjInsp, Form_Rel, ObjInsp_r, FDesigner;

{$R *.DFM}

procedure TFormTamanho.hAbsoluteClick(Sender: TObject);
begin
  hWidth.Enabled:= True;
  hWidth.SetFocus;
end;

procedure TFormTamanho.vAbsoluteClick(Sender: TObject);
begin
  vHeight.Enabled:= True;
  vHeight.SetFocus;
end;

procedure TFormTamanho.ResizeControl(Size:Integer;IsWidth:Boolean);
var
  I:Integer;
begin
  {if FormDesigner_Net <> Nil then
    case FormDesigner_Net.CurrentTipo_Form of
      0: begin
           for I:=0 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
           begin
             if IsWidth then TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Width:= Size
             else TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Height:= Size;
           end;
           FormDesigner_Net.CurrentForm_DEntrada.DsnRegister.DsnStage.UpdateControl;
           if FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count = 1 then
             FormObjInsp.Atribui(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0], True);
         end;
      1: begin
           for I:=0 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
           begin
             if IsWidth then TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Width:= Size
             else TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Height:= Size;
           end;
           FormDesigner_Net.CurrentForm_Avulso.DsnRegister.DsnStage.UpdateControl;
           if FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count = 1 then
             FormObjInsp.Atribui(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0], True);
         end;
    end;}
   if FormDialogo_Rel <> nil then
   begin
     for I:=0 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
         if IsWidth then TControl(FormDialogo_Rel.ListaSelecionados[I]).Width:= Size
         else TControl(FormDialogo_Rel.ListaSelecionados[I]).Height:= Size;
     end;
     FormDialogo_Rel.DsnRegister.DsnStage.UpdateControl;
     if FormDialogo_Rel.ListaSelecionados.Count = 1 then
       FormObjInsp_Rel.Atribui(FormDialogo_Rel.ListaSelecionados[0], True);
   end;
end;

function TFormTamanho.GetMaxValue(IsWidth:Boolean):Integer;
var
  I,Temp,Max:Integer;
begin
  Max:=0;
  {if FormDesigner_Net <> Nil then
    case FormDesigner_Net.CurrentTipo_Form of
      0: begin
           for I:=0 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do begin
             if IsWidth then Temp:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Width
             else Temp:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Height;
             if Temp > Max then Max:= Temp;
           end;
         end;
      1: begin
           for I:=0 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do begin
             if IsWidth then Temp:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Width
             else Temp:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Height;
             if Temp > Max then Max:= Temp;
           end;
         end;
    end;}
  if FormDialogo_Rel <> Nil then
  begin
    for I:=0 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
       if IsWidth then Temp:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Width
       else Temp:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Height;
       if Temp > Max then Max:= Temp;
    end;
  end;
  Result:= Max;
end;

function TFormTamanho.GetMinValue(IsWidth:Boolean):Integer;
var
  I,Temp,Min:Integer;
begin
  Min:=10000;
  {if FormDesigner_Net <> Nil then
    case FormDesigner_Net.CurrentTipo_Form of
      0: begin
           for I:=0 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do begin
             if IsWidth then Temp:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Width
             else Temp:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Height;
             if Temp < Min then Min:= Temp;
           end;
         end;
      1: begin
           for I:=0 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do begin
             if IsWidth then Temp:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Width
             else Temp:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Height;
             if Temp < Min then Min:= Temp;
           end;
         end;
    end;}
  if FormDialogo_Rel <> Nil then
  begin
    for I:=0 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
      if IsWidth then Temp:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Width
      else Temp:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Height;
      if Temp < Min then Min:= Temp;
    end;
  end;
  Result:= Min;
end;

procedure TFormTamanho.OKButtonClick(Sender: TObject);
begin
   if hAbsolute.Checked then ResizeControl(StrToInt(hWidth.Text), True)
   else if hGrow.Checked then ResizeControl(GetMaxValue(True), True)
   else if hShrink.Checked then ResizeControl(GetMinValue(True), True);
   if vAbsolute.Checked then ResizeControl(StrToInt(vHeight.Text), False)
   else if vGrow.Checked then ResizeControl(GetMaxValue(False), False)
   else if vShrink.Checked then ResizeControl(GetMinValue(False), False);
end;

end.
