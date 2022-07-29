unit ThFoco;

interface

uses
  Classes, ObjInsp;

type
  ThreadFoco = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ThreadFoco.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ ThreadFoco }

procedure ThreadFoco.Execute;
begin
  { Place thread code here }
  if FormObjInsp.Prop_Value.Visible then
    FormObjInsp.Prop_Value.SetFocus;
end;

end.
