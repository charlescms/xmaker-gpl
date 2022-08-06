unit XSwwData;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  DB, XSEngine, XSConsts,
  wwFilter, wwStr, wwSystem, wwTable, wwTypes;

type
  TXSQLwwQuery = class( TXSQLQuery )
  private
    FControlType    : TStrings;
    FPictureMasks   : TStrings;
    FUsePictureMask : Boolean;
    FOnInvalidValue : TwwInvalidValueEvent;

    function GetControlType: TStrings;
    procedure SetControlType(Value : TStrings );
    function GetPictureMasks: TStrings;
    procedure SetPictureMasks(Value : TStrings );
  protected
    procedure DoBeforePost; override; { For picture support }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ControlType: TStrings read GetControlType write SetControlType;
    property PictureMasks: TStrings read GetPictureMasks write SetPictureMasks;
    property ValidateWithMask: Boolean read FUsePictureMask write FUsePictureMask;
    property OnInvalidValue: TwwInvalidValueEvent read FOnInvalidValue write FOnInvalidValue;
  end;

  TXSQLwwStoredProc = class( TXSQLStoredProc )
  private
    FControlType    : TStrings;
    FPictureMasks   : TStrings;
    FUsePictureMask : Boolean;
    FOnInvalidValue : TwwInvalidValueEvent;

    function GetControlType: TStrings;
    procedure SetControlType(Value : TStrings );
    function GetPictureMasks: TStrings;
    procedure SetPictureMasks(Value : TStrings );
  protected
    procedure DoBeforePost; override; { For picture support }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ControlType: TStrings read GetControlType write SetControlType;
    property PictureMasks: TStrings read GetPictureMasks write SetPictureMasks;
    property ValidateWithMask: Boolean read FUsePictureMask write FUsePictureMask;
    property OnInvalidValue: TwwInvalidValueEvent read FOnInvalidValue write FOnInvalidValue;
  end;

procedure Register;

implementation
uses
  wwCommon,
  dbConsts;

{ TXSQLwwQuery }
constructor TXSQLwwQuery.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  FControlType    := TStringList.Create;
  FPictureMasks   := TStringList.Create;
  FUsePictureMask := True;
end;

destructor TXSQLwwQuery.Destroy;
begin
  FControlType.Free;
  FPictureMasks.Free;
  FPictureMasks:= nil;

  inherited Destroy;
end;

function TXSQLwwQuery.GetControlType: TStrings;
begin
  Result := FControlType;
end;

procedure TXSQLwwQuery.SetControlType(Value: TStrings);
begin
  FControlType.Assign( Value );
end;

function TXSQLwwQuery.GetPictureMasks: TStrings;
begin
  Result:= FPictureMasks;
end;

procedure TXSQLwwQuery.SetPictureMasks(Value: TStrings);
begin
  FPictureMasks.Assign( Value );
end;

Procedure TXSQLwwQuery.DoBeforePost;
begin
  inherited DoBeforePost;

  if FUsePictureMask then
    wwValidatePictureFields( Self, FOnInvalidValue );
end;


{ TXSQLwwStoredProc }
constructor TXSQLwwStoredProc.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  FControlType    := TStringList.Create;
  FPictureMasks   := TStringList.Create;
  FUsePictureMask := True;
end;

destructor TXSQLwwStoredProc.Destroy;
begin
  FControlType.Free;
  FPictureMasks.Free;
  FPictureMasks:= nil;

  inherited Destroy;
end;

function TXSQLwwStoredProc.GetControlType: TStrings;
begin
  Result := FControlType;
end;

procedure TXSQLwwStoredProc.SetControlType(Value: TStrings);
begin
  FControlType.Assign( Value );
end;

function TXSQLwwStoredProc.GetPictureMasks: TStrings;
begin
  Result:= FPictureMasks;
end;

procedure TXSQLwwStoredProc.SetPictureMasks(Value: TStrings);
begin
  FPictureMasks.Assign( Value );
end;

Procedure TXSQLwwStoredProc.DoBeforePost;
begin
  inherited DoBeforePost;

  if FUsePictureMask then
    wwValidatePictureFields( Self, FOnInvalidValue );
end;


procedure Register;
begin
  RegisterComponents(srXSQLConnect, [TXSQLwwQuery, TXSQLwwStoredProc] );
end;

end.
