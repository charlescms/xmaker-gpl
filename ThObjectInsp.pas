unit ThObjectInsp;

interface

uses
  Classes, DEntrada, ObjInsp, ObjInsp_r, Form_Rel;

type
  ThObjInsp = class(TThread)
  private
    { Private declarations }
    procedure Atribui;
  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ThObjInsp.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ ThObjInsp }

procedure ThObjInsp.Execute;
begin
  { Place thread code here }
  Synchronize(Atribui);
end;

procedure ThObjInsp.Atribui;
begin
  {if FormEntradaDados <> Nil then
  begin
    try
      if FormEntradaDados.ListaSelecionados.Count = 1 then
        FormObjInsp.Atribui(FormEntradaDados.ObjetoAtual, True)
      else
        FormObjInsp.Atribui(Nil, True);
    finally
    end;
  end
  else if FormDialogo_Rel <> Nil then
  begin
    try
      if FormDialogo_Rel.ListaSelecionados.Count = 1 then
        FormObjInsp_rel.Atribui(FormDialogo_Rel.ObjetoAtual, True)
      else
        FormObjInsp_rel.Atribui(Nil, True);
    finally
    end;
  end;}
end;

end.
