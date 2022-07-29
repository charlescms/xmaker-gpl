unit SDwwData;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  DB, SDEngine, SDConsts,
  wwFilter, wwStr, wwSystem, wwTable, wwTypes;

type
  TSDwwQuery = class( TSDQuery )
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

  TSDwwStoredProc = class( TSDStoredProc )
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

{ TSDwwQuery }
constructor TSDwwQuery.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  FControlType    := TStringList.Create;
  FPictureMasks   := TStringList.Create;
  FUsePictureMask := True;
end;

destructor TSDwwQuery.Destroy;
begin
  FControlType.Free;
  FPictureMasks.Free;
  FPictureMasks:= nil;

  inherited Destroy;
end;

function TSDwwQuery.GetControlType: TStrings;
begin
  Result := FControlType;
end;

procedure TSDwwQuery.SetControlType(Value: TStrings);
begin
  FControlType.Assign( Value );
end;

function TSDwwQuery.GetPictureMasks: TStrings;
begin
  Result:= FPictureMasks;
end;

procedure TSDwwQuery.SetPictureMasks(Value: TStrings);
begin
  FPictureMasks.Assign( Value );
end;

Procedure TSDwwQuery.DoBeforePost;
begin
  inherited DoBeforePost;

  if FUsePictureMask then
    wwValidatePictureFields( Self, FOnInvalidValue );
end;


{ TSDwwStoredProc }
constructor TSDwwStoredProc.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  FControlType    := TStringList.Create;
  FPictureMasks   := TStringList.Create;
  FUsePictureMask := True;
end;

destructor TSDwwStoredProc.Destroy;
begin
  FControlType.Free;
  FPictureMasks.Free;
  FPictureMasks:= nil;

  inherited Destroy;
end;

function TSDwwStoredProc.GetControlType: TStrings;
begin
  Result := FControlType;
end;

procedure TSDwwStoredProc.SetControlType(Value: TStrings);
begin
  FControlType.Assign( Value );
end;

function TSDwwStoredProc.GetPictureMasks: TStrings;
begin
  Result:= FPictureMasks;
end;

procedure TSDwwStoredProc.SetPictureMasks(Value: TStrings);
begin
  FPictureMasks.Assign( Value );
end;

Procedure TSDwwStoredProc.DoBeforePost;
begin
  inherited DoBeforePost;

  if FUsePictureMask then
    wwValidatePictureFields( Self, FOnInvalidValue );
end;


procedure Register;
begin
  RegisterComponents(srSQLDirect, [TSDwwQuery, TSDwwStoredProc] );
end;

end.
