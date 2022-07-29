(*  GREATIS OBJECT INSPECTOR                      *)
(*  unit version 1.55.002                         *)
(*  Copyright (C) 2002-2006 Greatis Software      *)
(*  http://www.greatis.com/delphicb/objinsp/      *)
(*  http://www.greatis.com/delphicb/objinsp/faq/  *)
(*  http://www.greatis.com/bteam.html             *)

unit PropIntf;

interface

uses Classes, PropList;

type

  TCustomPropertyInterface = class(TComponent)
  private
    FPropertyList: TPropertyList;
    procedure SetRoot(const Value: TComponent);
    function GetRoot: TComponent;
    procedure SetInstance(const Value: TComponent);
    function GetInstance: TComponent;
    function GetCount: Integer;
    function GetProperty(Index: Integer): TProperty;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindProperty(const PropName: string): TProperty;
  protected
    function CreatePropertyList: TPropertyList; virtual;
    property Root: TComponent read GetRoot write SetRoot;
    property Instance: TComponent read GetInstance write SetInstance;
    property Count: Integer read GetCount;
    property Properties[Index: Integer]: TProperty read GetProperty; default;
  end;

  TPropertyInterface = class(TCustomPropertyInterface)
  public
    property Count;
    property Properties;
  published
    property Root;
    property Instance;
  end;

procedure Register;

implementation

procedure TCustomPropertyInterface.SetRoot(const Value: TComponent);
begin
  FPropertyList.Root:=Value;
end;

function TCustomPropertyInterface.GetRoot: TComponent;
begin
  Result:=FPropertyList.Root;
end;

procedure TCustomPropertyInterface.SetInstance(const Value: TComponent);
begin
  FPropertyList.Instance:=Value;
end;

function TCustomPropertyInterface.GetInstance: TComponent;
begin
  Result:=FPropertyList.Instance;
end;

function TCustomPropertyInterface.GetCount: Integer;
begin
  Result:=FPropertyList.Count;
end;

function TCustomPropertyInterface.GetProperty(Index: Integer): TProperty;
begin
  Result:=FPropertyList[Index];
end;

constructor TCustomPropertyInterface.Create(AOwner: TComponent);
begin
  inherited;
  FPropertyList:=CreatePropertyList;
  FPropertyList.Root:=AOwner;
  FPropertyList.Instance:=AOwner;
end;

destructor TCustomPropertyInterface.Destroy;
begin
  FPropertyList.Free;
  inherited;
end;

function TCustomPropertyInterface.FindProperty(const PropName: string): TProperty;
begin
  Result:=FPropertyList.FindProperty(PropName);
end;

function TCustomPropertyInterface.CreatePropertyList: TPropertyList;
begin
  Result:=TPropertyList.Create(nil);
end;

procedure Register;
begin
  RegisterComponents('Inspectors',[TPropertyInterface]);
end;

end.
