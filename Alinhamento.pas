unit Alinhamento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  THorizAlign = (hatNo, hatLeft,hatCenter,hatRight,hatEqually,hatWindow);
  TVertAlign = (vatNo, vatTop,vatCenter,vatBottom,vatEqually,vatWindow);
  TFormAlinhamento = class(TForm)
    GroupBox1: TGroupBox;
    hNoChange: TRadioButton;
    hLeftSides: TRadioButton;
    hCenters: TRadioButton;
    hRightSides: TRadioButton;
    hSpaceEqual: TRadioButton;
    hCenterInWindow: TRadioButton;
    GroupBox2: TGroupBox;
    vNoChange: TRadioButton;
    vTops: TRadioButton;
    vCenters: TRadioButton;
    vBottoms: TRadioButton;
    vSpaceEqual: TRadioButton;
    vCenterInWindow: TRadioButton;
    OKButton: TButton;
    CancelButton: TButton;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure HorizAlignControl(Align:THorizAlign);
    procedure VertAlignControl(Align:TVertAlign);
  public
    { Public declarations }
  end;

var
  FormAlinhamento: TFormAlinhamento;

implementation

{$R *.DFM}

uses ObjInsp, Form_Rel, ObjInsp_r, FDesigner;

procedure TFormAlinhamento.HorizAlignControl(Align:THorizAlign);
var
  I,Left,Width,Width1,Center,Left1,Dif,TotalDif:Integer;
begin
  {if FormDesigner_Net <> Nil then
  case FormDesigner_Net.CurrentTipo_Form of
    0: begin
         case Align of
            hatLeft:
              begin
                Left:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Left;
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Left:= Left;
              end;
            hatCenter:
              begin
                Left:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Left;
                Width:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Width;
                Center:= Left + (Width div 2);
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                begin
                  Width1:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Width;
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Left:=
                    Left + ((Width - Width1) div 2);
                end;
              end;
            hatRight:
              begin
                Left:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Left;
                Width:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Width;
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                begin
                  Width1:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Width;
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Left:=
                    Left + ((Width - Width1) );
                end;
              end;
            hatEqually:
              begin
                TotalDif := (TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1]).Left -
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Left) div (FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1);
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 2 do
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Left := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I-1]).Left + TotalDif;
              end;
            hatWindow:
              begin
                Left := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Left;
                Left1 := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1]).Left;
                Width := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1]).Width;
                Left := ((FormDesigner_Net.CurrentForm_DEntrada.DsnRegister.DsnStage.Width - (Left1 + Width - Left)) div 2) - Left;
                for I:=0 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Left := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Left +
                  Left;
              end;
         end;
         FormDesigner_Net.CurrentForm_DEntrada.DsnRegister.DsnStage.UpdateControl;
         if FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count = 1 then
           FormObjInsp.Atribui(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0], True);
       end;
    1: begin
         case Align of
            hatLeft:
              begin
                Left:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Left;
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Left:= Left;
              end;
            hatCenter:
              begin
                Left:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Left;
                Width:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Width;
                Center:= Left + (Width div 2);
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                begin
                  Width1:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Width;
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Left:=
                    Left + ((Width - Width1) div 2);
                end;
              end;
            hatRight:
              begin
                Left:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Left;
                Width:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Width;
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                begin
                  Width1:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Width;
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Left:=
                    Left + ((Width - Width1) );
                end;
              end;
            hatEqually:
              begin
                TotalDif := (TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1]).Left -
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Left) div (FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1);
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 2 do
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Left := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I-1]).Left + TotalDif;
              end;
            hatWindow:
              begin
                Left := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Left;
                Left1 := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1]).Left;
                Width := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1]).Width;
                Left := ((FormDesigner_Net.CurrentForm_Avulso.DsnRegister.DsnStage.Width - (Left1 + Width - Left)) div 2) - Left;
                for I:=0 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Left := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Left +
                  Left;
              end;
         end;
         FormDesigner_Net.CurrentForm_Avulso.DsnRegister.DsnStage.UpdateControl;
         if FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count = 1 then
           FormObjInsp.Atribui(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0], True);
       end;
  end;}
  if FormDialogo_Rel <> Nil then
   begin
     case Align of
        hatLeft:
        begin
           Left:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Left;
           for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 1 do
             TControl(FormDialogo_Rel.ListaSelecionados[I]).Left:= Left;
        end;
        hatCenter:
        begin
           Left:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Left;
           Width:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Width;
           Center:= Left + (Width div 2);
           for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
             Width1:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Width;
             TControl(FormDialogo_Rel.ListaSelecionados[I]).Left:=
                Left + ((Width - Width1) div 2);
           end;
        end;
        hatRight:
        begin
           Left:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Left;
           Width:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Width;
           for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
             Width1:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Width;
             TControl(FormDialogo_Rel.ListaSelecionados[I]).Left:=
                Left + ((Width - Width1) );
           end;
        end;
        hatEqually:
        begin
          TotalDif := (TControl(FormDialogo_Rel.ListaSelecionados[FormDialogo_Rel.ListaSelecionados.Count - 1]).Left -
            TControl(FormDialogo_Rel.ListaSelecionados[0]).Left) div (FormDialogo_Rel.ListaSelecionados.Count - 1);
          for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 2 do
            TControl(FormDialogo_Rel.ListaSelecionados[I]).Left := TControl(FormDialogo_Rel.ListaSelecionados[I-1]).Left + TotalDif;
        end;
        hatWindow:
        begin
          Left := TControl(FormDialogo_Rel.ListaSelecionados[0]).Left;
          Left1 := TControl(FormDialogo_Rel.ListaSelecionados[FormDialogo_Rel.ListaSelecionados.Count - 1]).Left;
          Width := TControl(FormDialogo_Rel.ListaSelecionados[FormDialogo_Rel.ListaSelecionados.Count - 1]).Width;
          Left := ((FormDialogo_Rel.DsnRegister.DsnStage.Width - (Left1 + Width - Left)) div 2) - Left;
          for I:=0 to FormDialogo_Rel.ListaSelecionados.Count - 1 do
            TControl(FormDialogo_Rel.ListaSelecionados[I]).Left := TControl(FormDialogo_Rel.ListaSelecionados[I]).Left +
              Left;
        end;
     end;
     FormDialogo_Rel.DsnRegister.DsnStage.UpdateControl;
     if FormDialogo_Rel.ListaSelecionados.Count = 1 then
       FormObjInsp_rel.Atribui(FormDialogo_Rel.ListaSelecionados[0], True);
   end;
end;

procedure TFormAlinhamento.VertAlignControl(Align:TVertAlign);
var
  I,Top,Top1,Height,Height1,Center,Left1,Dif,TotalDif:Integer;
begin
  {if FormDesigner_Net <> Nil then
  case FormDesigner_Net.CurrentTipo_Form of
    0: begin
         case Align of
            vatTop:
              begin
                 Top:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Top;
                 for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                   TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Top:= Top;
              end;
            vatCenter:
              begin
                Top:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Top;
                Height:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Height;
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                begin
                  Height1:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Height;
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Top:=
                     Top + ((Height - Height1) div 2);
                end;
              end;
            vatBottom:
              begin
                Top:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Top;
                Height:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Height;
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do begin
                  Height1:= TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Height;
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Top:=
                    Top + ((Height - Height1) );
                end;
              end;
            vatEqually:
              begin
                TotalDif := (TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1]).Top -
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Top) div (FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1);
                for I:=1 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 2 do
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Top := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I-1]).Top + TotalDif;
              end;
          vatWindow:
             begin
               Top := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0]).Top;
               Top1 := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1]).Top;
               Height := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1]).Height;
               Top := ((FormDesigner_Net.CurrentForm_DEntrada.DsnRegister.DsnStage.Height - (Top1 + Height - Top)) div 2) - Top;
                for I:=0 to FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count - 1 do
                  TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Top := TControl(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[I]).Top +
                  Top;
             end;
         end;
         FormDesigner_Net.CurrentForm_DEntrada.DsnRegister.DsnStage.UpdateControl;
         if FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count = 1 then
           FormObjInsp.Atribui(FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados[0], True);
       end;
    1: begin
         case Align of
            vatTop:
              begin
                 Top:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Top;
                 for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                   TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Top:= Top;
              end;
            vatCenter:
              begin
                Top:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Top;
                Height:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Height;
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                begin
                  Height1:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Height;
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Top:=
                     Top + ((Height - Height1) div 2);
                end;
              end;
            vatBottom:
              begin
                Top:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Top;
                Height:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Height;
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do begin
                  Height1:= TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Height;
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Top:=
                    Top + ((Height - Height1) );
                end;
              end;
            vatEqually:
              begin
                TotalDif := (TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1]).Top -
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Top) div (FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1);
                for I:=1 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 2 do
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Top := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I-1]).Top + TotalDif;
              end;
          vatWindow:
             begin
               Top := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0]).Top;
               Top1 := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1]).Top;
               Height := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1]).Height;
               Top := ((FormDesigner_Net.CurrentForm_Avulso.DsnRegister.DsnStage.Height - (Top1 + Height - Top)) div 2) - Top;
                for I:=0 to FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count - 1 do
                  TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Top := TControl(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[I]).Top +
                  Top;
             end;
         end;
         FormDesigner_Net.CurrentForm_Avulso.DsnRegister.DsnStage.UpdateControl;
         if FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count = 1 then
           FormObjInsp.Atribui(FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados[0], True);
       end;
   end;}
   if FormDialogo_Rel <> Nil then
   begin
     case Align of
        vatTop:
        begin
           Top:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Top;
           for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 1 do
             TControl(FormDialogo_Rel.ListaSelecionados[I]).Top:= Top;
        end;
        vatCenter:
        begin
           Top:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Top;
           Height:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Height;
           for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
             Height1:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Height;
             TControl(FormDialogo_Rel.ListaSelecionados[I]).Top:=
                Top + ((Height - Height1) div 2);
           end;
        end;
        vatBottom:
        begin
           Top:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Top;
           Height:= TControl(FormDialogo_Rel.ListaSelecionados[0]).Height;
           for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 1 do begin
             Height1:= TControl(FormDialogo_Rel.ListaSelecionados[I]).Height;
             TControl(FormDialogo_Rel.ListaSelecionados[I]).Top:=
                Top + ((Height - Height1) );
           end;
        end;
        vatEqually:
        begin
          TotalDif := (TControl(FormDialogo_Rel.ListaSelecionados[FormDialogo_Rel.ListaSelecionados.Count - 1]).Top -
            TControl(FormDialogo_Rel.ListaSelecionados[0]).Top) div (FormDialogo_Rel.ListaSelecionados.Count - 1);
          for I:=1 to FormDialogo_Rel.ListaSelecionados.Count - 2 do
            TControl(FormDialogo_Rel.ListaSelecionados[I]).Top := TControl(FormDialogo_Rel.ListaSelecionados[I-1]).Top + TotalDif;
        end;
        vatWindow:
        begin
          Top := TControl(FormDialogo_Rel.ListaSelecionados[0]).Top;
          Top1 := TControl(FormDialogo_Rel.ListaSelecionados[FormDialogo_Rel.ListaSelecionados.Count - 1]).Top;
          Height := TControl(FormDialogo_Rel.ListaSelecionados[FormDialogo_Rel.ListaSelecionados.Count - 1]).Height;
          Top := ((FormDialogo_Rel.DsnRegister.DsnStage.Height - (Top1 + Height - Top)) div 2) - Top;
          for I:=0 to FormDialogo_Rel.ListaSelecionados.Count - 1 do
            TControl(FormDialogo_Rel.ListaSelecionados[I]).Top := TControl(FormDialogo_Rel.ListaSelecionados[I]).Top +
              Top;
        end;
     end;
     FormDialogo_Rel.DsnRegister.DsnStage.UpdateControl;
     if FormDialogo_Rel.ListaSelecionados.Count = 1 then
       FormObjInsp_rel.Atribui(FormDialogo_Rel.ListaSelecionados[0], True);
   end;
end;

procedure TFormAlinhamento.OKButtonClick(Sender: TObject);
begin
  {if FormDesigner_Net <> Nil then
    case FormDesigner_Net.CurrentTipo_Form of
      0: if FormDesigner_Net.CurrentForm_DEntrada.ListaSelecionados.Count = 0 then exit;
      1: if FormDesigner_Net.CurrentForm_Avulso.ListaSelecionados.Count = 0 then exit;
    end;}
  if FormDialogo_Rel <> Nil then
    if FormDialogo_Rel.ListaSelecionados.Count = 0 then exit;

  if hLeftSides.Checked then HorizAlignControl(hatLeft)
  else if hCenters.Checked then HorizAlignControl(hatCenter)
  else if hRightSides.Checked then HorizAlignControl(hatRight)
  else if hSpaceEqual.Checked then HorizAlignControl(hatEqually)
  else if hCenterInWindow.Checked then HorizAlignControl(hatWindow);

  if vTops.Checked then VertAlignControl(vatTop)
  else if vCenters.Checked then VertAlignControl(vatCenter)
  else if vBottoms.Checked then VertAlignControl(vatBottom)
  else if vSpaceEqual.Checked then VertAlignControl(vatEqually)
  else if vCenterInWindow.Checked then VertAlignControl(vatWindow);
end;

end.
