// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZPlainAdo.pas' rev: 5.00

#ifndef ZPlainAdoHPP
#define ZPlainAdoHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ActiveX.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zplainado
{
//-- type declarations -------------------------------------------------------
typedef Activex::TOleEnum CursorTypeEnum;

typedef Activex::TOleEnum CursorOptionEnum;

typedef Activex::TOleEnum LockTypeEnum;

typedef Activex::TOleEnum ExecuteOptionEnum;

typedef Activex::TOleEnum ConnectOptionEnum;

typedef Activex::TOleEnum ObjectStateEnum;

typedef Activex::TOleEnum CursorLocationEnum;

typedef Activex::TOleEnum DataTypeEnum;

typedef Activex::TOleEnum FieldAttributeEnum;

typedef Activex::TOleEnum EditModeEnum;

typedef Activex::TOleEnum RecordStatusEnum;

typedef Activex::TOleEnum GetRowsOptionEnum;

typedef Activex::TOleEnum PositionEnum;

typedef Activex::TOleEnum BookmarkEnum;

typedef Activex::TOleEnum MarshalOptionsEnum;

typedef Activex::TOleEnum AffectEnum;

typedef Activex::TOleEnum ResyncEnum;

typedef Activex::TOleEnum CompareEnum;

typedef Activex::TOleEnum FilterGroupEnum;

typedef Activex::TOleEnum SearchDirectionEnum;

typedef Activex::TOleEnum PersistFormatEnum;

typedef Activex::TOleEnum StringFormatEnum;

typedef Activex::TOleEnum ConnectPromptEnum;

typedef Activex::TOleEnum ConnectModeEnum;

typedef Activex::TOleEnum RecordCreateOptionsEnum;

typedef Activex::TOleEnum RecordOpenOptionsEnum;

typedef Activex::TOleEnum IsolationLevelEnum;

typedef Activex::TOleEnum XactAttributeEnum;

typedef Activex::TOleEnum PropertyAttributesEnum;

typedef Activex::TOleEnum ErrorValueEnum;

typedef Activex::TOleEnum ParameterAttributesEnum;

typedef Activex::TOleEnum ParameterDirectionEnum;

typedef Activex::TOleEnum CommandTypeEnum;

typedef Activex::TOleEnum EventStatusEnum;

typedef Activex::TOleEnum EventReasonEnum;

typedef Activex::TOleEnum SchemaEnum;

typedef Activex::TOleEnum FieldStatusEnum;

typedef Activex::TOleEnum SeekEnum;

typedef Activex::TOleEnum ADCPROP_UPDATECRITERIA_ENUM;

typedef Activex::TOleEnum ADCPROP_ASYNCTHREADPRIORITY_ENUM;

typedef Activex::TOleEnum ADCPROP_AUTORECALC_ENUM;

typedef Activex::TOleEnum ADCPROP_UPDATERESYNC_ENUM;

typedef Activex::TOleEnum MoveRecordOptionsEnum;

typedef Activex::TOleEnum CopyRecordOptionsEnum;

typedef Activex::TOleEnum StreamTypeEnum;

typedef Activex::TOleEnum LineSeparatorEnum;

typedef Activex::TOleEnum StreamOpenOptionsEnum;

typedef Activex::TOleEnum StreamWriteEnum;

typedef Activex::TOleEnum SaveOptionsEnum;

typedef Activex::TOleEnum FieldEnum;

typedef Activex::TOleEnum StreamReadEnum;

typedef Activex::TOleEnum RecordTypeEnum;

typedef OleVariant *POleVariant1;

typedef Activex::TOleEnum PositionEnum_Param;

typedef Activex::TOleEnum SearchDirection;

typedef int ADO_LONGPTR;

__interface _Collection;
typedef System::DelphiInterface<_Collection> _di__Collection;
__interface INTERFACE_UUID("{00000512-0000-0010-8000-00AA006D2EA4}") _Collection  : public IDispatch 
	
{
	
public:
	virtual HRESULT __safecall Get_Count(int &Get_Count_result) = 0 ;
	virtual HRESULT __safecall _NewEnum(_di_IUnknown &_NewEnum_result) = 0 ;
	virtual HRESULT __safecall Refresh(void) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Count() { int r; HRESULT hr = Get_Count(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Count = {read=_scw_Get_Count};
};

__interface _DynaCollection;
typedef System::DelphiInterface<_DynaCollection> _di__DynaCollection;
__interface INTERFACE_UUID("{00000513-0000-0010-8000-00AA006D2EA4}") _DynaCollection  : public _Collection 
	
{
	
public:
	virtual HRESULT __safecall Append(const _di_IDispatch Object_) = 0 ;
	virtual HRESULT __safecall Delete(const OleVariant Index) = 0 ;
};

__interface _ADO;
typedef System::DelphiInterface<_ADO> _di__ADO;
__interface Properties;
typedef System::DelphiInterface<Properties> _di_Properties;
__interface INTERFACE_UUID("{00000534-0000-0010-8000-00AA006D2EA4}") _ADO  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Properties(_di_Properties &Get_Properties_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Properties _scw_Get_Properties() { _di_Properties r; HRESULT hr = Get_Properties(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Properties Properties = {read=_scw_Get_Properties};
};

__interface Property_;
typedef System::DelphiInterface<Property_> _di_Property_;
__interface INTERFACE_UUID("{00000504-0000-0010-8000-00AA006D2EA4}") Properties  : public _Collection 
	
{
	
public:
	virtual HRESULT __safecall Get_Item(const OleVariant Index, _di_Property_ &Get_Item_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Property_ _scw_Get_Item(const OleVariant Index) { _di_Property_ r; HRESULT hr = Get_Item(
		Index, r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Property_ Item[OleVariant Index] = {read=_scw_Get_Item/*, default*/};
};

__interface INTERFACE_UUID("{00000503-0000-0010-8000-00AA006D2EA4}") Property_  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Value(OleVariant &Get_Value_result) = 0 ;
	virtual HRESULT __safecall Set_Value(const OleVariant pval) = 0 ;
	virtual HRESULT __safecall Get_Name(WideString &Get_Name_result) = 0 ;
	virtual HRESULT __safecall Get_Type_(Activex::TOleEnum &Get_Type__result) = 0 ;
	virtual HRESULT __safecall Get_Attributes(int &Get_Attributes_result) = 0 ;
	virtual HRESULT __safecall Set_Attributes(int plAttributes) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Value() { OleVariant r; HRESULT hr = Get_Value(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property OleVariant Value = {read=_scw_Get_Value, write=Set_Value};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Name() { WideString r; HRESULT hr = Get_Name(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Name = {read=_scw_Get_Name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Type_() { Activex::TOleEnum r; HRESULT hr = Get_Type_(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Type_ = {read=_scw_Get_Type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Attributes() { int r; HRESULT hr = Get_Attributes(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Attributes = {read=_scw_Get_Attributes};
};

__interface Error;
typedef System::DelphiInterface<Error> _di_Error;
__interface INTERFACE_UUID("{00000500-0000-0010-8000-00AA006D2EA4}") Error  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Number(int &Get_Number_result) = 0 ;
	virtual HRESULT __safecall Get_Source(WideString &Get_Source_result) = 0 ;
	virtual HRESULT __safecall Get_Description(WideString &Get_Description_result) = 0 ;
	virtual HRESULT __safecall Get_HelpFile(WideString &Get_HelpFile_result) = 0 ;
	virtual HRESULT __safecall Get_HelpContext(int &Get_HelpContext_result) = 0 ;
	virtual HRESULT __safecall Get_SQLState(WideString &Get_SQLState_result) = 0 ;
	virtual HRESULT __safecall Get_NativeError(int &Get_NativeError_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Number() { int r; HRESULT hr = Get_Number(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Number = {read=_scw_Get_Number};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Source() { WideString r; HRESULT hr = Get_Source(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Source = {read=_scw_Get_Source};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Description() { WideString r; HRESULT hr = Get_Description(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Description = {read=_scw_Get_Description};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_HelpFile() { WideString r; HRESULT hr = Get_HelpFile(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString HelpFile = {read=_scw_Get_HelpFile};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_HelpContext() { int r; HRESULT hr = Get_HelpContext(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int HelpContext = {read=_scw_Get_HelpContext};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_SQLState() { WideString r; HRESULT hr = Get_SQLState(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString SQLState = {read=_scw_Get_SQLState};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_NativeError() { int r; HRESULT hr = Get_NativeError(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int NativeError = {read=_scw_Get_NativeError};
};

__interface Errors;
typedef System::DelphiInterface<Errors> _di_Errors;
__interface INTERFACE_UUID("{00000501-0000-0010-8000-00AA006D2EA4}") Errors  : public _Collection 
{
	
public:
	virtual HRESULT __safecall Get_Item(const OleVariant Index, _di_Error &Get_Item_result) = 0 ;
	virtual HRESULT __safecall Clear(void) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Error _scw_Get_Item(const OleVariant Index) { _di_Error r; HRESULT hr = Get_Item(
		Index, r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Error Item[OleVariant Index] = {read=_scw_Get_Item/*, default*/};
};

__interface Command15;
typedef System::DelphiInterface<Command15> _di_Command15;
__interface Connection15;
typedef System::DelphiInterface<Connection15> _di_Connection15;
__interface Recordset15;
typedef System::DelphiInterface<Recordset15> _di_Recordset15;
__interface _Parameter;
typedef System::DelphiInterface<_Parameter> _di__Parameter;
__interface Parameters;
typedef System::DelphiInterface<Parameters> _di_Parameters;
__interface INTERFACE_UUID("{00000508-0000-0010-8000-00AA006D2EA4}") Command15  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_ActiveConnection(_di_Connection15 &Get_ActiveConnection_result) = 0 
		;
	virtual HRESULT __safecall _Set_ActiveConnection(const _di_Connection15 ppvObject) = 0 ;
	virtual HRESULT __safecall Set_ActiveConnection(const OleVariant ppvObject) = 0 ;
	virtual HRESULT __safecall Get_CommandText(WideString &Get_CommandText_result) = 0 ;
	virtual HRESULT __safecall Set_CommandText(const WideString pbstr) = 0 ;
	virtual HRESULT __safecall Get_CommandTimeout(int &Get_CommandTimeout_result) = 0 ;
	virtual HRESULT __safecall Set_CommandTimeout(int pl) = 0 ;
	virtual HRESULT __safecall Get_Prepared(Word &Get_Prepared_result) = 0 ;
	virtual HRESULT __safecall Set_Prepared(Word pfPrepared) = 0 ;
	virtual HRESULT __safecall Execute(/* out */ OleVariant &RecordsAffected, const OleVariant &Parameters
		, int Options, _di_Recordset15 &Execute_result) = 0 ;
	virtual HRESULT __safecall CreateParameter(const WideString Name, Activex::TOleEnum Type_, Activex::TOleEnum 
		Direction, int Size, const OleVariant Value, _di__Parameter &CreateParameter_result) = 0 ;
	virtual HRESULT __safecall Get_Parameters(_di_Parameters &Get_Parameters_result) = 0 ;
	virtual HRESULT __safecall Set_CommandType(Activex::TOleEnum plCmdType) = 0 ;
	virtual HRESULT __safecall Get_CommandType(Activex::TOleEnum &Get_CommandType_result) = 0 ;
	virtual HRESULT __safecall Get_Name(WideString &Get_Name_result) = 0 ;
	virtual HRESULT __safecall Set_Name(const WideString pbstrName) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_CommandText() { WideString r; HRESULT hr = Get_CommandText(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString CommandText = {read=_scw_Get_CommandText, write=Set_CommandText};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_CommandTimeout() { int r; HRESULT hr = Get_CommandTimeout(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int CommandTimeout = {read=_scw_Get_CommandTimeout, write=Set_CommandTimeout};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_Prepared() { Word r; HRESULT hr = Get_Prepared(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Word Prepared = {read=_scw_Get_Prepared, write=Set_Prepared};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Parameters _scw_Get_Parameters() { _di_Parameters r; HRESULT hr = Get_Parameters(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Parameters Parameters = {read=_scw_Get_Parameters};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_CommandType() { Activex::TOleEnum r; HRESULT hr = Get_CommandType(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum CommandType = {read=_scw_Get_CommandType, write=Set_CommandType};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Name() { WideString r; HRESULT hr = Get_Name(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Name = {read=_scw_Get_Name, write=Set_Name};
};

__interface INTERFACE_UUID("{00000515-0000-0010-8000-00AA006D2EA4}") Connection15  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_ConnectionString(WideString &Get_ConnectionString_result) = 0 ;
	virtual HRESULT __safecall Set_ConnectionString(const WideString pbstr) = 0 ;
	virtual HRESULT __safecall Get_CommandTimeout(int &Get_CommandTimeout_result) = 0 ;
	virtual HRESULT __safecall Set_CommandTimeout(int plTimeout) = 0 ;
	virtual HRESULT __safecall Get_ConnectionTimeout(int &Get_ConnectionTimeout_result) = 0 ;
	virtual HRESULT __safecall Set_ConnectionTimeout(int plTimeout) = 0 ;
	virtual HRESULT __safecall Get_Version(WideString &Get_Version_result) = 0 ;
	virtual HRESULT __safecall Close(void) = 0 ;
	virtual HRESULT __safecall Execute(const WideString CommandText, /* out */ OleVariant &RecordsAffected
		, int Options, _di_Recordset15 &Execute_result) = 0 ;
	virtual HRESULT __safecall BeginTrans(int &BeginTrans_result) = 0 ;
	virtual HRESULT __safecall CommitTrans(void) = 0 ;
	virtual HRESULT __safecall RollbackTrans(void) = 0 ;
	virtual HRESULT __safecall Open(const WideString ConnectionString, const WideString UserID, const WideString 
		Password, int Options) = 0 ;
	virtual HRESULT __safecall Get_Errors(_di_Errors &Get_Errors_result) = 0 ;
	virtual HRESULT __safecall Get_DefaultDatabase(WideString &Get_DefaultDatabase_result) = 0 ;
	virtual HRESULT __safecall Set_DefaultDatabase(const WideString pbstr) = 0 ;
	virtual HRESULT __safecall Get_IsolationLevel(Activex::TOleEnum &Get_IsolationLevel_result) = 0 ;
	virtual HRESULT __safecall Set_IsolationLevel(Activex::TOleEnum Level) = 0 ;
	virtual HRESULT __safecall Get_Attributes(int &Get_Attributes_result) = 0 ;
	virtual HRESULT __safecall Set_Attributes(int plAttr) = 0 ;
	virtual HRESULT __safecall Get_CursorLocation(Activex::TOleEnum &Get_CursorLocation_result) = 0 ;
	virtual HRESULT __safecall Set_CursorLocation(Activex::TOleEnum plCursorLoc) = 0 ;
	virtual HRESULT __safecall Get_Mode(Activex::TOleEnum &Get_Mode_result) = 0 ;
	virtual HRESULT __safecall Set_Mode(Activex::TOleEnum plMode) = 0 ;
	virtual HRESULT __safecall Get_Provider(WideString &Get_Provider_result) = 0 ;
	virtual HRESULT __safecall Set_Provider(const WideString pbstr) = 0 ;
	virtual HRESULT __safecall Get_State(int &Get_State_result) = 0 ;
	virtual HRESULT __safecall OpenSchema(Activex::TOleEnum Schema, const OleVariant Restrictions, const 
		OleVariant SchemaID, _di_Recordset15 &OpenSchema_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_ConnectionString() { WideString r; HRESULT hr = Get_ConnectionString(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString ConnectionString = {read=_scw_Get_ConnectionString, write=Set_ConnectionString
		};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_CommandTimeout() { int r; HRESULT hr = Get_CommandTimeout(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int CommandTimeout = {read=_scw_Get_CommandTimeout, write=Set_CommandTimeout};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_ConnectionTimeout() { int r; HRESULT hr = Get_ConnectionTimeout(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property int ConnectionTimeout = {read=_scw_Get_ConnectionTimeout, write=Set_ConnectionTimeout};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Version() { WideString r; HRESULT hr = Get_Version(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Version = {read=_scw_Get_Version};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Errors _scw_Get_Errors() { _di_Errors r; HRESULT hr = Get_Errors(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Errors Errors = {read=_scw_Get_Errors};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_DefaultDatabase() { WideString r; HRESULT hr = Get_DefaultDatabase(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString DefaultDatabase = {read=_scw_Get_DefaultDatabase, write=Set_DefaultDatabase};
		
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_IsolationLevel() { Activex::TOleEnum r; HRESULT hr = Get_IsolationLevel(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum IsolationLevel = {read=_scw_Get_IsolationLevel, write=Set_IsolationLevel
		};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Attributes() { int r; HRESULT hr = Get_Attributes(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Attributes = {read=_scw_Get_Attributes, write=Set_Attributes};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_CursorLocation() { Activex::TOleEnum r; HRESULT hr = Get_CursorLocation(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum CursorLocation = {read=_scw_Get_CursorLocation, write=Set_CursorLocation
		};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Mode() { Activex::TOleEnum r; HRESULT hr = Get_Mode(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Mode = {read=_scw_Get_Mode, write=Set_Mode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Provider() { WideString r; HRESULT hr = Get_Provider(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Provider = {read=_scw_Get_Provider, write=Set_Provider};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_State() { int r; HRESULT hr = Get_State(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int State = {read=_scw_Get_State};
};

__interface _Connection;
typedef System::DelphiInterface<_Connection> _di__Connection;
__interface INTERFACE_UUID("{00000550-0000-0010-8000-00AA006D2EA4}") _Connection  : public Connection15 
	
{
	
public:
	virtual HRESULT __safecall Cancel(void) = 0 ;
};

__interface Fields15;
typedef System::DelphiInterface<Fields15> _di_Fields15;
__interface INTERFACE_UUID("{0000050E-0000-0010-8000-00AA006D2EA4}") Recordset15  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_AbsolutePosition(Activex::TOleEnum &Get_AbsolutePosition_result) = 0 
		;
	virtual HRESULT __safecall Set_AbsolutePosition(Activex::TOleEnum pl) = 0 ;
	virtual HRESULT __safecall _Set_ActiveConnection(const _di_IDispatch pvar) = 0 ;
	virtual HRESULT __safecall Set_ActiveConnection(const OleVariant pvar) = 0 ;
	virtual HRESULT __safecall Get_ActiveConnection(OleVariant &Get_ActiveConnection_result) = 0 ;
	virtual HRESULT __safecall Get_BOF(Word &Get_BOF_result) = 0 ;
	virtual HRESULT __safecall Get_Bookmark(OleVariant &Get_Bookmark_result) = 0 ;
	virtual HRESULT __safecall Set_Bookmark(const OleVariant pvBookmark) = 0 ;
	virtual HRESULT __safecall Get_CacheSize(int &Get_CacheSize_result) = 0 ;
	virtual HRESULT __safecall Set_CacheSize(int pl) = 0 ;
	virtual HRESULT __safecall Get_CursorType(Activex::TOleEnum &Get_CursorType_result) = 0 ;
	virtual HRESULT __safecall Set_CursorType(Activex::TOleEnum plCursorType) = 0 ;
	virtual HRESULT __safecall Get_EOF(Word &Get_EOF_result) = 0 ;
	virtual HRESULT __safecall Get_Fields(_di_Fields15 &Get_Fields_result) = 0 ;
	virtual HRESULT __safecall Get_LockType(Activex::TOleEnum &Get_LockType_result) = 0 ;
	virtual HRESULT __safecall Set_LockType(Activex::TOleEnum plLockType) = 0 ;
	virtual HRESULT __safecall Get_MaxRecords(int &Get_MaxRecords_result) = 0 ;
	virtual HRESULT __safecall Set_MaxRecords(int plMaxRecords) = 0 ;
	virtual HRESULT __safecall Get_RecordCount(int &Get_RecordCount_result) = 0 ;
	virtual HRESULT __safecall _Set_Source(const _di_IDispatch pvSource) = 0 ;
	virtual HRESULT __safecall Set_Source(const WideString pvSource) = 0 ;
	virtual HRESULT __safecall Get_Source(OleVariant &Get_Source_result) = 0 ;
	virtual HRESULT __safecall AddNew(const OleVariant FieldList, const OleVariant Values) = 0 ;
	virtual HRESULT __safecall CancelUpdate(void) = 0 ;
	virtual HRESULT __safecall Close(void) = 0 ;
	virtual HRESULT __safecall Delete(Activex::TOleEnum AffectRecords) = 0 ;
	virtual HRESULT __safecall GetRows(int Rows, const OleVariant Start, const OleVariant Fields, OleVariant &GetRows_result
		) = 0 ;
	virtual HRESULT __safecall Move(int NumRecords, const OleVariant Start) = 0 ;
	virtual HRESULT __safecall MoveNext(void) = 0 ;
	virtual HRESULT __safecall MovePrevious(void) = 0 ;
	virtual HRESULT __safecall MoveFirst(void) = 0 ;
	virtual HRESULT __safecall MoveLast(void) = 0 ;
	virtual HRESULT __safecall Open(const OleVariant Source, const OleVariant ActiveConnection, Activex::TOleEnum 
		CursorType, Activex::TOleEnum LockType, int Options) = 0 ;
	virtual HRESULT __safecall Requery(int Options) = 0 ;
	virtual HRESULT __safecall _xResync(Activex::TOleEnum AffectRecords) = 0 ;
	virtual HRESULT __safecall Update(const OleVariant Fields, const OleVariant Values) = 0 ;
	virtual HRESULT __safecall Get_AbsolutePage(Activex::TOleEnum &Get_AbsolutePage_result) = 0 ;
	virtual HRESULT __safecall Set_AbsolutePage(Activex::TOleEnum pl) = 0 ;
	virtual HRESULT __safecall Get_EditMode(Activex::TOleEnum &Get_EditMode_result) = 0 ;
	virtual HRESULT __safecall Get_Filter(OleVariant &Get_Filter_result) = 0 ;
	virtual HRESULT __safecall Set_Filter(const OleVariant Criteria) = 0 ;
	virtual HRESULT __safecall Get_PageCount(int &Get_PageCount_result) = 0 ;
	virtual HRESULT __safecall Get_PageSize(int &Get_PageSize_result) = 0 ;
	virtual HRESULT __safecall Set_PageSize(int pl) = 0 ;
	virtual HRESULT __safecall Get_Sort(WideString &Get_Sort_result) = 0 ;
	virtual HRESULT __safecall Set_Sort(const WideString Criteria) = 0 ;
	virtual HRESULT __safecall Get_Status(int &Get_Status_result) = 0 ;
	virtual HRESULT __safecall Get_State(int &Get_State_result) = 0 ;
	virtual HRESULT __safecall _xClone(_di_Recordset15 &_xClone_result) = 0 ;
	virtual HRESULT __safecall UpdateBatch(Activex::TOleEnum AffectRecords) = 0 ;
	virtual HRESULT __safecall CancelBatch(Activex::TOleEnum AffectRecords) = 0 ;
	virtual HRESULT __safecall Get_CursorLocation(Activex::TOleEnum &Get_CursorLocation_result) = 0 ;
	virtual HRESULT __safecall Set_CursorLocation(Activex::TOleEnum plCursorLoc) = 0 ;
	virtual HRESULT __safecall NextRecordset(/* out */ OleVariant &RecordsAffected, _di_Recordset15 &NextRecordset_result
		) = 0 ;
	virtual HRESULT __safecall Supports(Activex::TOleEnum CursorOptions, Word &Supports_result) = 0 ;
	virtual HRESULT __safecall Get_Collect(const OleVariant Index, OleVariant &Get_Collect_result) = 0 
		;
	virtual HRESULT __safecall Set_Collect(const OleVariant Index, const OleVariant pvar) = 0 ;
	virtual HRESULT __safecall Get_MarshalOptions(Activex::TOleEnum &Get_MarshalOptions_result) = 0 ;
	virtual HRESULT __safecall Set_MarshalOptions(Activex::TOleEnum peMarshal) = 0 ;
	virtual HRESULT __safecall Find(const WideString Criteria, int SkipRecords, Activex::TOleEnum SearchDirection
		, const OleVariant Start) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_AbsolutePosition() { Activex::TOleEnum r; HRESULT hr = Get_AbsolutePosition(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum AbsolutePosition = {read=_scw_Get_AbsolutePosition, write=Set_AbsolutePosition
		};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_BOF() { Word r; HRESULT hr = Get_BOF(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Word BOF = {read=_scw_Get_BOF};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Bookmark() { OleVariant r; HRESULT hr = Get_Bookmark(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant Bookmark = {read=_scw_Get_Bookmark, write=Set_Bookmark};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_CacheSize() { int r; HRESULT hr = Get_CacheSize(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int CacheSize = {read=_scw_Get_CacheSize, write=Set_CacheSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_CursorType() { Activex::TOleEnum r; HRESULT hr = Get_CursorType(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum CursorType = {read=_scw_Get_CursorType, write=Set_CursorType};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_EOF() { Word r; HRESULT hr = Get_EOF(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Word EOF = {read=_scw_Get_EOF};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Fields15 _scw_Get_Fields() { _di_Fields15 r; HRESULT hr = Get_Fields(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Fields15 Fields = {read=_scw_Get_Fields};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_LockType() { Activex::TOleEnum r; HRESULT hr = Get_LockType(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum LockType = {read=_scw_Get_LockType, write=Set_LockType};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_MaxRecords() { int r; HRESULT hr = Get_MaxRecords(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int MaxRecords = {read=_scw_Get_MaxRecords, write=Set_MaxRecords};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_RecordCount() { int r; HRESULT hr = Get_RecordCount(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int RecordCount = {read=_scw_Get_RecordCount};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_AbsolutePage() { Activex::TOleEnum r; HRESULT hr = Get_AbsolutePage(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum AbsolutePage = {read=_scw_Get_AbsolutePage, write=Set_AbsolutePage};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_EditMode() { Activex::TOleEnum r; HRESULT hr = Get_EditMode(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum EditMode = {read=_scw_Get_EditMode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Filter() { OleVariant r; HRESULT hr = Get_Filter(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant Filter = {read=_scw_Get_Filter, write=Set_Filter};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_PageCount() { int r; HRESULT hr = Get_PageCount(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int PageCount = {read=_scw_Get_PageCount};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_PageSize() { int r; HRESULT hr = Get_PageSize(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int PageSize = {read=_scw_Get_PageSize, write=Set_PageSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Sort() { WideString r; HRESULT hr = Get_Sort(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Sort = {read=_scw_Get_Sort, write=Set_Sort};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Status() { int r; HRESULT hr = Get_Status(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Status = {read=_scw_Get_Status};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_State() { int r; HRESULT hr = Get_State(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int State = {read=_scw_Get_State};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_CursorLocation() { Activex::TOleEnum r; HRESULT hr = Get_CursorLocation(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum CursorLocation = {read=_scw_Get_CursorLocation, write=Set_CursorLocation
		};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Collect(const OleVariant Index) { OleVariant r; HRESULT hr = Get_Collect(
		Index, r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant Collect[OleVariant Index] = {read=_scw_Get_Collect, write=Set_Collect};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_MarshalOptions() { Activex::TOleEnum r; HRESULT hr = Get_MarshalOptions(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum MarshalOptions = {read=_scw_Get_MarshalOptions, write=Set_MarshalOptions
		};
};

__interface Recordset20;
typedef System::DelphiInterface<Recordset20> _di_Recordset20;
__interface INTERFACE_UUID("{0000054F-0000-0010-8000-00AA006D2EA4}") Recordset20  : public Recordset15 
	
{
	
public:
	virtual HRESULT __safecall Cancel(void) = 0 ;
	virtual HRESULT __safecall Get_DataSource(_di_IUnknown &Get_DataSource_result) = 0 ;
	virtual HRESULT __safecall _Set_DataSource(const _di_IUnknown ppunkDataSource) = 0 ;
	virtual HRESULT __safecall _xSave(const WideString FileName, Activex::TOleEnum PersistFormat) = 0 ;
		
	virtual HRESULT __safecall Get_ActiveCommand(_di_IDispatch &Get_ActiveCommand_result) = 0 ;
	virtual HRESULT __safecall Set_StayInSync(Word pbStayInSync) = 0 ;
	virtual HRESULT __safecall Get_StayInSync(Word &Get_StayInSync_result) = 0 ;
	virtual HRESULT __safecall GetString(Activex::TOleEnum StringFormat, int NumRows, const WideString 
		ColumnDelimeter, const WideString RowDelimeter, const WideString NullExpr, WideString &GetString_result
		) = 0 ;
	virtual HRESULT __safecall Get_DataMember(WideString &Get_DataMember_result) = 0 ;
	virtual HRESULT __safecall Set_DataMember(const WideString pbstrDataMember) = 0 ;
	virtual HRESULT __safecall CompareBookmarks(const OleVariant Bookmark1, const OleVariant Bookmark2, Activex::TOleEnum &CompareBookmarks_result
		) = 0 ;
	virtual HRESULT __safecall Clone(Activex::TOleEnum LockType, _di_Recordset15 &Clone_result) = 0 ;
	virtual HRESULT __safecall Resync(Activex::TOleEnum AffectRecords, Activex::TOleEnum ResyncValues) = 0 
		;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IUnknown _scw_Get_DataSource() { _di_IUnknown r; HRESULT hr = Get_DataSource(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IUnknown DataSource = {read=_scw_Get_DataSource, write=_Set_DataSource};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IDispatch _scw_Get_ActiveCommand() { _di_IDispatch r; HRESULT hr = Get_ActiveCommand(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IDispatch ActiveCommand = {read=_scw_Get_ActiveCommand};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_StayInSync() { Word r; HRESULT hr = Get_StayInSync(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Word StayInSync = {read=_scw_Get_StayInSync, write=Set_StayInSync};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_DataMember() { WideString r; HRESULT hr = Get_DataMember(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString DataMember = {read=_scw_Get_DataMember, write=Set_DataMember};
};

__interface Recordset21;
typedef System::DelphiInterface<Recordset21> _di_Recordset21;
__interface INTERFACE_UUID("{00000555-0000-0010-8000-00AA006D2EA4}") Recordset21  : public Recordset20 
	
{
	
public:
	virtual HRESULT __safecall Seek(const OleVariant KeyValues, Activex::TOleEnum SeekOption) = 0 ;
	virtual HRESULT __safecall Set_Index(const WideString pbstrIndex) = 0 ;
	virtual HRESULT __safecall Get_Index(WideString &Get_Index_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Index() { WideString r; HRESULT hr = Get_Index(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Index = {read=_scw_Get_Index, write=Set_Index};
};

__interface _Recordset;
typedef System::DelphiInterface<_Recordset> _di__Recordset;
__interface INTERFACE_UUID("{00000556-0000-0010-8000-00AA006D2EA4}") _Recordset  : public Recordset21 
	
{
	
public:
	virtual HRESULT __safecall Save(const OleVariant Destination, Activex::TOleEnum PersistFormat) = 0 
		;
};

__interface Field20;
typedef System::DelphiInterface<Field20> _di_Field20;
__interface INTERFACE_UUID("{00000506-0000-0010-8000-00AA006D2EA4}") Fields15  : public _Collection 
	
{
	
public:
	virtual HRESULT __safecall Get_Item(const OleVariant Index, _di_Field20 &Get_Item_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Field20 _scw_Get_Item(const OleVariant Index) { _di_Field20 r; HRESULT hr = Get_Item(
		Index, r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Field20 Item[OleVariant Index] = {read=_scw_Get_Item/*, default*/};
};

__interface Fields20;
typedef System::DelphiInterface<Fields20> _di_Fields20;
__interface INTERFACE_UUID("{0000054D-0000-0010-8000-00AA006D2EA4}") Fields20  : public Fields15 
{
	
public:
	virtual HRESULT __safecall _Append(const WideString Name, Activex::TOleEnum Type_, int DefinedSize, 
		Activex::TOleEnum Attrib) = 0 ;
	virtual HRESULT __safecall Delete(const OleVariant Index) = 0 ;
};

__interface Fields;
typedef System::DelphiInterface<Fields> _di_Fields;
__interface INTERFACE_UUID("{00000564-0000-0010-8000-00AA006D2EA4}") Fields  : public Fields20 
{
	
public:
	virtual HRESULT __safecall Append(const WideString Name, Activex::TOleEnum Type_, int DefinedSize, 
		Activex::TOleEnum Attrib, const OleVariant FieldValue) = 0 ;
	virtual HRESULT __safecall Update(void) = 0 ;
	virtual HRESULT __safecall Resync(Activex::TOleEnum ResyncValues) = 0 ;
	virtual HRESULT __safecall CancelUpdate(void) = 0 ;
};

__interface INTERFACE_UUID("{0000054C-0000-0010-8000-00AA006D2EA4}") Field20  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_ActualSize(int &Get_ActualSize_result) = 0 ;
	virtual HRESULT __safecall Get_Attributes(int &Get_Attributes_result) = 0 ;
	virtual HRESULT __safecall Get_DefinedSize(int &Get_DefinedSize_result) = 0 ;
	virtual HRESULT __safecall Get_Name(WideString &Get_Name_result) = 0 ;
	virtual HRESULT __safecall Get_Type_(Activex::TOleEnum &Get_Type__result) = 0 ;
	virtual HRESULT __safecall Get_Value(OleVariant &Get_Value_result) = 0 ;
	virtual HRESULT __safecall Set_Value(const OleVariant pvar) = 0 ;
	virtual HRESULT __safecall Get_Precision(Byte &Get_Precision_result) = 0 ;
	virtual HRESULT __safecall Get_NumericScale(Byte &Get_NumericScale_result) = 0 ;
	virtual HRESULT __safecall AppendChunk(const OleVariant Data) = 0 ;
	virtual HRESULT __safecall GetChunk(int Length, OleVariant &GetChunk_result) = 0 ;
	virtual HRESULT __safecall Get_OriginalValue(OleVariant &Get_OriginalValue_result) = 0 ;
	virtual HRESULT __safecall Get_UnderlyingValue(OleVariant &Get_UnderlyingValue_result) = 0 ;
	virtual HRESULT __safecall Get_DataFormat(_di_IUnknown &Get_DataFormat_result) = 0 ;
	virtual HRESULT __safecall _Set_DataFormat(const _di_IUnknown ppiDF) = 0 ;
	virtual HRESULT __safecall Set_Precision(Byte pbPrecision) = 0 ;
	virtual HRESULT __safecall Set_NumericScale(Byte pbNumericScale) = 0 ;
	virtual HRESULT __safecall Set_Type_(Activex::TOleEnum pDataType) = 0 ;
	virtual HRESULT __safecall Set_DefinedSize(int pl) = 0 ;
	virtual HRESULT __safecall Set_Attributes(int pl) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_ActualSize() { int r; HRESULT hr = Get_ActualSize(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int ActualSize = {read=_scw_Get_ActualSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Attributes() { int r; HRESULT hr = Get_Attributes(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Attributes = {read=_scw_Get_Attributes, write=Set_Attributes};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_DefinedSize() { int r; HRESULT hr = Get_DefinedSize(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int DefinedSize = {read=_scw_Get_DefinedSize, write=Set_DefinedSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Name() { WideString r; HRESULT hr = Get_Name(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Name = {read=_scw_Get_Name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Type_() { Activex::TOleEnum r; HRESULT hr = Get_Type_(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Type_ = {read=_scw_Get_Type_, write=Set_Type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Value() { OleVariant r; HRESULT hr = Get_Value(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property OleVariant Value = {read=_scw_Get_Value, write=Set_Value};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Byte _scw_Get_Precision() { Byte r; HRESULT hr = Get_Precision(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Byte Precision = {read=_scw_Get_Precision, write=Set_Precision};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Byte _scw_Get_NumericScale() { Byte r; HRESULT hr = Get_NumericScale(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Byte NumericScale = {read=_scw_Get_NumericScale, write=Set_NumericScale};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_OriginalValue() { OleVariant r; HRESULT hr = Get_OriginalValue(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant OriginalValue = {read=_scw_Get_OriginalValue};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_UnderlyingValue() { OleVariant r; HRESULT hr = Get_UnderlyingValue(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant UnderlyingValue = {read=_scw_Get_UnderlyingValue};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IUnknown _scw_Get_DataFormat() { _di_IUnknown r; HRESULT hr = Get_DataFormat(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IUnknown DataFormat = {read=_scw_Get_DataFormat, write=_Set_DataFormat};
};

__interface Field;
typedef System::DelphiInterface<Field> _di_Field;
__interface INTERFACE_UUID("{00000569-0000-0010-8000-00AA006D2EA4}") Field  : public Field20 
{
	
public:
	virtual HRESULT __safecall Get_Status(int &Get_Status_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Status() { int r; HRESULT hr = Get_Status(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Status = {read=_scw_Get_Status};
};

__interface INTERFACE_UUID("{0000050C-0000-0010-8000-00AA006D2EA4}") _Parameter  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_Name(WideString &Get_Name_result) = 0 ;
	virtual HRESULT __safecall Set_Name(const WideString pbstr) = 0 ;
	virtual HRESULT __safecall Get_Value(OleVariant &Get_Value_result) = 0 ;
	virtual HRESULT __safecall Set_Value(const OleVariant pvar) = 0 ;
	virtual HRESULT __safecall Get_Type_(Activex::TOleEnum &Get_Type__result) = 0 ;
	virtual HRESULT __safecall Set_Type_(Activex::TOleEnum psDataType) = 0 ;
	virtual HRESULT __safecall Set_Direction(Activex::TOleEnum plParmDirection) = 0 ;
	virtual HRESULT __safecall Get_Direction(Activex::TOleEnum &Get_Direction_result) = 0 ;
	virtual HRESULT __safecall Set_Precision(Byte pbPrecision) = 0 ;
	virtual HRESULT __safecall Get_Precision(Byte &Get_Precision_result) = 0 ;
	virtual HRESULT __safecall Set_NumericScale(Byte pbScale) = 0 ;
	virtual HRESULT __safecall Get_NumericScale(Byte &Get_NumericScale_result) = 0 ;
	virtual HRESULT __safecall Set_Size(int pl) = 0 ;
	virtual HRESULT __safecall Get_Size(int &Get_Size_result) = 0 ;
	virtual HRESULT __safecall AppendChunk(const OleVariant Val) = 0 ;
	virtual HRESULT __safecall Get_Attributes(int &Get_Attributes_result) = 0 ;
	virtual HRESULT __safecall Set_Attributes(int plParmAttribs) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Name() { WideString r; HRESULT hr = Get_Name(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Name = {read=_scw_Get_Name, write=Set_Name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Value() { OleVariant r; HRESULT hr = Get_Value(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property OleVariant Value = {read=_scw_Get_Value, write=Set_Value};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Type_() { Activex::TOleEnum r; HRESULT hr = Get_Type_(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Type_ = {read=_scw_Get_Type_, write=Set_Type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Direction() { Activex::TOleEnum r; HRESULT hr = Get_Direction(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Direction = {read=_scw_Get_Direction, write=Set_Direction};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Byte _scw_Get_Precision() { Byte r; HRESULT hr = Get_Precision(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Byte Precision = {read=_scw_Get_Precision, write=Set_Precision};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Byte _scw_Get_NumericScale() { Byte r; HRESULT hr = Get_NumericScale(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Byte NumericScale = {read=_scw_Get_NumericScale, write=Set_NumericScale};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Size() { int r; HRESULT hr = Get_Size(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Size = {read=_scw_Get_Size, write=Set_Size};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Attributes() { int r; HRESULT hr = Get_Attributes(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Attributes = {read=_scw_Get_Attributes, write=Set_Attributes};
};

__interface INTERFACE_UUID("{0000050D-0000-0010-8000-00AA006D2EA4}") Parameters  : public _DynaCollection 
	
{
	
public:
	virtual HRESULT __safecall Get_Item(const OleVariant Index, _di__Parameter &Get_Item_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di__Parameter _scw_Get_Item(const OleVariant Index) { _di__Parameter r; HRESULT hr = Get_Item(
		Index, r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di__Parameter Item[OleVariant Index] = {read=_scw_Get_Item/*, default*/};
};

__interface Command25;
typedef System::DelphiInterface<Command25> _di_Command25;
__interface INTERFACE_UUID("{0000054E-0000-0010-8000-00AA006D2EA4}") Command25  : public Command15 
{
	
public:
	virtual HRESULT __safecall Get_State(int &Get_State_result) = 0 ;
	virtual HRESULT __safecall Cancel(void) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_State() { int r; HRESULT hr = Get_State(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int State = {read=_scw_Get_State};
};

__interface _Command;
typedef System::DelphiInterface<_Command> _di__Command;
__interface INTERFACE_UUID("{B08400BD-F9D1-4D02-B856-71D5DBA123E9}") _Command  : public Command25 
{
	
public:
	virtual HRESULT __safecall _Set_CommandStream(const _di_IUnknown pvStream) = 0 ;
	virtual HRESULT __safecall Get_CommandStream(OleVariant &Get_CommandStream_result) = 0 ;
	virtual HRESULT __safecall Set_Dialect(const WideString pbstrDialect) = 0 ;
	virtual HRESULT __safecall Get_Dialect(WideString &Get_Dialect_result) = 0 ;
	virtual HRESULT __safecall Set_NamedParameters(Word pfNamedParameters) = 0 ;
	virtual HRESULT __safecall Get_NamedParameters(Word &Get_NamedParameters_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Dialect() { WideString r; HRESULT hr = Get_Dialect(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Dialect = {read=_scw_Get_Dialect, write=Set_Dialect};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_NamedParameters() { Word r; HRESULT hr = Get_NamedParameters(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Word NamedParameters = {read=_scw_Get_NamedParameters, write=Set_NamedParameters};
};

__interface ConnectionEventsVt;
typedef System::DelphiInterface<ConnectionEventsVt> _di_ConnectionEventsVt;
__interface INTERFACE_UUID("{00000402-0000-0010-8000-00AA006D2EA4}") ConnectionEventsVt  : public IUnknown 
	
{
	
public:
	virtual HRESULT __stdcall InfoMessage(const _di_Error pError, Activex::TOleEnum &adStatus, const _di_Connection15 
		pConnection) = 0 ;
	virtual HRESULT __stdcall BeginTransComplete(int TransactionLevel, const _di_Error pError, Activex::TOleEnum 
		&adStatus, const _di_Connection15 pConnection) = 0 ;
	virtual HRESULT __stdcall CommitTransComplete(const _di_Error pError, Activex::TOleEnum &adStatus, 
		const _di_Connection15 pConnection) = 0 ;
	virtual HRESULT __stdcall RollbackTransComplete(const _di_Error pError, Activex::TOleEnum &adStatus
		, const _di_Connection15 pConnection) = 0 ;
	virtual HRESULT __stdcall WillExecute(WideString &Source, Activex::TOleEnum &CursorType, Activex::TOleEnum 
		&LockType, int &Options, Activex::TOleEnum &adStatus, const _di__Command pCommand, const _di_Recordset15 
		pRecordset, const _di_Connection15 pConnection) = 0 ;
	virtual HRESULT __stdcall ExecuteComplete(int RecordsAffected, const _di_Error pError, Activex::TOleEnum 
		&adStatus, const _di__Command pCommand, const _di_Recordset15 pRecordset, const _di_Connection15 pConnection
		) = 0 ;
	virtual HRESULT __stdcall WillConnect(WideString &ConnectionString, WideString &UserID, WideString 
		&Password, int &Options, Activex::TOleEnum &adStatus, const _di_Connection15 pConnection) = 0 ;
	virtual HRESULT __stdcall ConnectComplete(const _di_Error pError, Activex::TOleEnum &adStatus, const 
		_di_Connection15 pConnection) = 0 ;
	virtual HRESULT __stdcall Disconnect(Activex::TOleEnum &adStatus, const _di_Connection15 pConnection
		) = 0 ;
};

__interface RecordsetEventsVt;
typedef System::DelphiInterface<RecordsetEventsVt> _di_RecordsetEventsVt;
__interface INTERFACE_UUID("{00000403-0000-0010-8000-00AA006D2EA4}") RecordsetEventsVt  : public IUnknown 
	
{
	
public:
	virtual HRESULT __stdcall WillChangeField(int cFields, const OleVariant Fields, Activex::TOleEnum &
		adStatus, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall FieldChangeComplete(int cFields, const OleVariant Fields, const _di_Error 
		pError, Activex::TOleEnum &adStatus, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall WillChangeRecord(Activex::TOleEnum adReason, int cRecords, Activex::TOleEnum 
		&adStatus, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall RecordChangeComplete(Activex::TOleEnum adReason, int cRecords, const _di_Error 
		pError, Activex::TOleEnum &adStatus, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall WillChangeRecordset(Activex::TOleEnum adReason, Activex::TOleEnum &adStatus
		, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall RecordsetChangeComplete(Activex::TOleEnum adReason, const _di_Error pError
		, Activex::TOleEnum &adStatus, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall WillMove(Activex::TOleEnum adReason, Activex::TOleEnum &adStatus, const _di_Recordset15 
		pRecordset) = 0 ;
	virtual HRESULT __stdcall MoveComplete(Activex::TOleEnum adReason, const _di_Error pError, Activex::TOleEnum 
		&adStatus, const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall EndOfRecordset(Word &fMoreData, Activex::TOleEnum &adStatus, const _di_Recordset15 
		pRecordset) = 0 ;
	virtual HRESULT __stdcall FetchProgress(int Progress, int MaxProgress, Activex::TOleEnum &adStatus, 
		const _di_Recordset15 pRecordset) = 0 ;
	virtual HRESULT __stdcall FetchComplete(const _di_Error pError, Activex::TOleEnum &adStatus, const 
		_di_Recordset15 pRecordset) = 0 ;
};

__interface ADOConnectionConstruction15;
typedef System::DelphiInterface<ADOConnectionConstruction15> _di_ADOConnectionConstruction15;
__interface INTERFACE_UUID("{00000516-0000-0010-8000-00AA006D2EA4}") ADOConnectionConstruction15  : public IUnknown 
	
{
	
public:
	virtual HRESULT __stdcall Get_DSO(/* out */ _di_IUnknown &ppDSO) = 0 ;
	virtual HRESULT __stdcall Get_Session(/* out */ _di_IUnknown &ppSession) = 0 ;
	virtual HRESULT __stdcall WrapDSOandSession(const _di_IUnknown pDSO, const _di_IUnknown pSession) = 0 
		;
};

__interface ADOConnectionConstruction;
typedef System::DelphiInterface<ADOConnectionConstruction> _di_ADOConnectionConstruction;
__interface INTERFACE_UUID("{00000551-0000-0010-8000-00AA006D2EA4}") ADOConnectionConstruction  : public ADOConnectionConstruction15 
	
{
	
};

__interface _Record;
typedef System::DelphiInterface<_Record> _di__Record;
__interface INTERFACE_UUID("{00000562-0000-0010-8000-00AA006D2EA4}") _Record  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_ActiveConnection(OleVariant &Get_ActiveConnection_result) = 0 ;
	virtual HRESULT __safecall Set_ActiveConnection(const WideString pvar) = 0 ;
	virtual HRESULT __safecall _Set_ActiveConnection(const _di_Connection15 pvar) = 0 ;
	virtual HRESULT __safecall Get_State(Activex::TOleEnum &Get_State_result) = 0 ;
	virtual HRESULT __safecall Get_Source(OleVariant &Get_Source_result) = 0 ;
	virtual HRESULT __safecall Set_Source(const WideString pvar) = 0 ;
	virtual HRESULT __safecall _Set_Source(const _di_IDispatch pvar) = 0 ;
	virtual HRESULT __safecall Get_Mode(Activex::TOleEnum &Get_Mode_result) = 0 ;
	virtual HRESULT __safecall Set_Mode(Activex::TOleEnum pMode) = 0 ;
	virtual HRESULT __safecall Get_ParentURL(WideString &Get_ParentURL_result) = 0 ;
	virtual HRESULT __safecall MoveRecord(const WideString Source, const WideString Destination, const 
		WideString UserName, const WideString Password, Activex::TOleEnum Options, Word Async, WideString &MoveRecord_result
		) = 0 ;
	virtual HRESULT __safecall CopyRecord(const WideString Source, const WideString Destination, const 
		WideString UserName, const WideString Password, Activex::TOleEnum Options, Word Async, WideString &CopyRecord_result
		) = 0 ;
	virtual HRESULT __safecall DeleteRecord(const WideString Source, Word Async) = 0 ;
	virtual HRESULT __safecall Open(const OleVariant Source, const OleVariant ActiveConnection, Activex::TOleEnum 
		Mode, Activex::TOleEnum CreateOptions, Activex::TOleEnum Options, const WideString UserName, const 
		WideString Password) = 0 ;
	virtual HRESULT __safecall Close(void) = 0 ;
	virtual HRESULT __safecall Get_Fields(_di_Fields15 &Get_Fields_result) = 0 ;
	virtual HRESULT __safecall Get_RecordType(Activex::TOleEnum &Get_RecordType_result) = 0 ;
	virtual HRESULT __safecall GetChildren(_di_Recordset15 &GetChildren_result) = 0 ;
	virtual HRESULT __safecall Cancel(void) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_State() { Activex::TOleEnum r; HRESULT hr = Get_State(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum State = {read=_scw_Get_State};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Mode() { Activex::TOleEnum r; HRESULT hr = Get_Mode(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Mode = {read=_scw_Get_Mode, write=Set_Mode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_ParentURL() { WideString r; HRESULT hr = Get_ParentURL(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString ParentURL = {read=_scw_Get_ParentURL};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_Fields15 _scw_Get_Fields() { _di_Fields15 r; HRESULT hr = Get_Fields(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_Fields15 Fields = {read=_scw_Get_Fields};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_RecordType() { Activex::TOleEnum r; HRESULT hr = Get_RecordType(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum RecordType = {read=_scw_Get_RecordType};
};

__interface _Stream;
typedef System::DelphiInterface<_Stream> _di__Stream;
__interface INTERFACE_UUID("{00000565-0000-0010-8000-00AA006D2EA4}") _Stream  : public IDispatch 
{
	
public:
	virtual HRESULT __safecall Get_Size(int &Get_Size_result) = 0 ;
	virtual HRESULT __safecall Get_EOS(Word &Get_EOS_result) = 0 ;
	virtual HRESULT __safecall Get_Position(int &Get_Position_result) = 0 ;
	virtual HRESULT __safecall Set_Position(int pPos) = 0 ;
	virtual HRESULT __safecall Get_Type_(Activex::TOleEnum &Get_Type__result) = 0 ;
	virtual HRESULT __safecall Set_Type_(Activex::TOleEnum ptype) = 0 ;
	virtual HRESULT __safecall Get_LineSeparator(Activex::TOleEnum &Get_LineSeparator_result) = 0 ;
	virtual HRESULT __safecall Set_LineSeparator(Activex::TOleEnum pLS) = 0 ;
	virtual HRESULT __safecall Get_State(Activex::TOleEnum &Get_State_result) = 0 ;
	virtual HRESULT __safecall Get_Mode(Activex::TOleEnum &Get_Mode_result) = 0 ;
	virtual HRESULT __safecall Set_Mode(Activex::TOleEnum pMode) = 0 ;
	virtual HRESULT __safecall Get_Charset(WideString &Get_Charset_result) = 0 ;
	virtual HRESULT __safecall Set_Charset(const WideString pbstrCharset) = 0 ;
	virtual HRESULT __safecall Read(int NumBytes, OleVariant &Read_result) = 0 ;
	virtual HRESULT __safecall Open(const OleVariant Source, Activex::TOleEnum Mode, Activex::TOleEnum 
		Options, const WideString UserName, const WideString Password) = 0 ;
	virtual HRESULT __safecall Close(void) = 0 ;
	virtual HRESULT __safecall SkipLine(void) = 0 ;
	virtual HRESULT __safecall Write(const OleVariant Buffer) = 0 ;
	virtual HRESULT __safecall SetEOS(void) = 0 ;
	virtual HRESULT __safecall CopyTo(const _di__Stream DestStream, int CharNumber) = 0 ;
	virtual HRESULT __safecall Flush(void) = 0 ;
	virtual HRESULT __safecall SaveToFile(const WideString FileName, Activex::TOleEnum Options) = 0 ;
	virtual HRESULT __safecall LoadFromFile(const WideString FileName) = 0 ;
	virtual HRESULT __safecall ReadText(int NumChars, WideString &ReadText_result) = 0 ;
	virtual HRESULT __safecall WriteText(const WideString Data, Activex::TOleEnum Options) = 0 ;
	virtual HRESULT __safecall Cancel(void) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Size() { int r; HRESULT hr = Get_Size(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Size = {read=_scw_Get_Size};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Word _scw_Get_EOS() { Word r; HRESULT hr = Get_EOS(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Word EOS = {read=_scw_Get_EOS};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Position() { int r; HRESULT hr = Get_Position(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Position = {read=_scw_Get_Position, write=Set_Position};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Type_() { Activex::TOleEnum r; HRESULT hr = Get_Type_(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Type_ = {read=_scw_Get_Type_, write=Set_Type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_LineSeparator() { Activex::TOleEnum r; HRESULT hr = Get_LineSeparator(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum LineSeparator = {read=_scw_Get_LineSeparator, write=Set_LineSeparator}
		;
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_State() { Activex::TOleEnum r; HRESULT hr = Get_State(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum State = {read=_scw_Get_State};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Mode() { Activex::TOleEnum r; HRESULT hr = Get_Mode(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Mode = {read=_scw_Get_Mode, write=Set_Mode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Charset() { WideString r; HRESULT hr = Get_Charset(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property WideString Charset = {read=_scw_Get_Charset, write=Set_Charset};
};

__interface ADORecordConstruction;
typedef System::DelphiInterface<ADORecordConstruction> _di_ADORecordConstruction;
__interface INTERFACE_UUID("{00000567-0000-0010-8000-00AA006D2EA4}") ADORecordConstruction  : public IDispatch 
	
{
	
public:
	virtual HRESULT __stdcall Get_Row(/* out */ _di_IUnknown &ppRow) = 0 ;
	virtual HRESULT __stdcall Set_Row(const _di_IUnknown ppRow) = 0 ;
	virtual HRESULT __stdcall Set_ParentRow(const _di_IUnknown Param1) = 0 ;
};

__interface ADOStreamConstruction;
typedef System::DelphiInterface<ADOStreamConstruction> _di_ADOStreamConstruction;
__interface INTERFACE_UUID("{00000568-0000-0010-8000-00AA006D2EA4}") ADOStreamConstruction  : public IDispatch 
	
{
	
public:
	virtual HRESULT __stdcall Get_Stream(/* out */ _di_IUnknown &ppStm) = 0 ;
	virtual HRESULT __stdcall Set_Stream(const _di_IUnknown ppStm) = 0 ;
};

__interface ADOCommandConstruction;
typedef System::DelphiInterface<ADOCommandConstruction> _di_ADOCommandConstruction;
__interface INTERFACE_UUID("{00000517-0000-0010-8000-00AA006D2EA4}") ADOCommandConstruction  : public IUnknown 
	
{
	
public:
	virtual HRESULT __safecall Get_OLEDBCommand(_di_IUnknown &Get_OLEDBCommand_result) = 0 ;
	virtual HRESULT __safecall Set_OLEDBCommand(const _di_IUnknown ppOLEDBCommand) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IUnknown _scw_Get_OLEDBCommand() { _di_IUnknown r; HRESULT hr = Get_OLEDBCommand(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property _di_IUnknown OLEDBCommand = {read=_scw_Get_OLEDBCommand, write=Set_OLEDBCommand};
};

__interface ADORecordsetConstruction;
typedef System::DelphiInterface<ADORecordsetConstruction> _di_ADORecordsetConstruction;
__interface INTERFACE_UUID("{00000283-0000-0010-8000-00AA006D2EA4}") ADORecordsetConstruction  : public IDispatch 
	
{
	
public:
	virtual HRESULT __stdcall Get_Rowset(/* out */ _di_IUnknown &ppRowset) = 0 ;
	virtual HRESULT __stdcall Set_Rowset(const _di_IUnknown ppRowset) = 0 ;
	virtual HRESULT __stdcall Get_Chapter(/* out */ int &plChapter) = 0 ;
	virtual HRESULT __stdcall Set_Chapter(int plChapter) = 0 ;
	virtual HRESULT __stdcall Get_RowPosition(/* out */ _di_IUnknown &ppRowPos) = 0 ;
	virtual HRESULT __stdcall Set_RowPosition(const _di_IUnknown ppRowPos) = 0 ;
};

__interface Field15;
typedef System::DelphiInterface<Field15> _di_Field15;
__interface INTERFACE_UUID("{00000505-0000-0010-8000-00AA006D2EA4}") Field15  : public _ADO 
{
	
public:
	virtual HRESULT __safecall Get_ActualSize(int &Get_ActualSize_result) = 0 ;
	virtual HRESULT __safecall Get_Attributes(int &Get_Attributes_result) = 0 ;
	virtual HRESULT __safecall Get_DefinedSize(int &Get_DefinedSize_result) = 0 ;
	virtual HRESULT __safecall Get_Name(WideString &Get_Name_result) = 0 ;
	virtual HRESULT __safecall Get_Type_(Activex::TOleEnum &Get_Type__result) = 0 ;
	virtual HRESULT __safecall Get_Value(OleVariant &Get_Value_result) = 0 ;
	virtual HRESULT __safecall Set_Value(const OleVariant pvar) = 0 ;
	virtual HRESULT __safecall Get_Precision(Byte &Get_Precision_result) = 0 ;
	virtual HRESULT __safecall Get_NumericScale(Byte &Get_NumericScale_result) = 0 ;
	virtual HRESULT __safecall AppendChunk(const OleVariant Data) = 0 ;
	virtual HRESULT __safecall GetChunk(int Length, OleVariant &GetChunk_result) = 0 ;
	virtual HRESULT __safecall Get_OriginalValue(OleVariant &Get_OriginalValue_result) = 0 ;
	virtual HRESULT __safecall Get_UnderlyingValue(OleVariant &Get_UnderlyingValue_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_ActualSize() { int r; HRESULT hr = Get_ActualSize(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int ActualSize = {read=_scw_Get_ActualSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_Attributes() { int r; HRESULT hr = Get_Attributes(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int Attributes = {read=_scw_Get_Attributes};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_DefinedSize() { int r; HRESULT hr = Get_DefinedSize(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property int DefinedSize = {read=_scw_Get_DefinedSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline WideString _scw_Get_Name() { WideString r; HRESULT hr = Get_Name(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property WideString Name = {read=_scw_Get_Name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Activex::TOleEnum _scw_Get_Type_() { Activex::TOleEnum r; HRESULT hr = Get_Type_(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Activex::TOleEnum Type_ = {read=_scw_Get_Type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_Value() { OleVariant r; HRESULT hr = Get_Value(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property OleVariant Value = {read=_scw_Get_Value, write=Set_Value};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Byte _scw_Get_Precision() { Byte r; HRESULT hr = Get_Precision(r); System::CheckSafecallResult(hr); return r; }
		
	#pragma option pop
	__property Byte Precision = {read=_scw_Get_Precision};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Byte _scw_Get_NumericScale() { Byte r; HRESULT hr = Get_NumericScale(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property Byte NumericScale = {read=_scw_Get_NumericScale};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_OriginalValue() { OleVariant r; HRESULT hr = Get_OriginalValue(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant OriginalValue = {read=_scw_Get_OriginalValue};
	#pragma option push -w-inl
	/* safecall wrapper */ inline OleVariant _scw_Get_UnderlyingValue() { OleVariant r; HRESULT hr = Get_UnderlyingValue(
		r); System::CheckSafecallResult(hr); return r; }
	#pragma option pop
	__property OleVariant UnderlyingValue = {read=_scw_Get_UnderlyingValue};
};

typedef Connection15 Connection;
;

typedef _Record Record_;
;

typedef _Stream Stream;
;

typedef _Command Command;
;

typedef Recordset15 Recordset;
;

typedef _Parameter Parameter;
;

class DELPHICLASS CoConnection;
class PASCALIMPLEMENTATION CoConnection : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_Connection15 __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_Connection15 __fastcall CreateRemote(TMetaClass* vmt, const AnsiString 
		MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoConnection(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoConnection(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoRecord_;
class PASCALIMPLEMENTATION CoRecord_ : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di__Record __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di__Record __fastcall CreateRemote(TMetaClass* vmt, const AnsiString 
		MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoRecord_(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoRecord_(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoStream;
class PASCALIMPLEMENTATION CoStream : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di__Stream __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di__Stream __fastcall CreateRemote(TMetaClass* vmt, const AnsiString 
		MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoStream(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoStream(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoCommand;
class PASCALIMPLEMENTATION CoCommand : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di__Command __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di__Command __fastcall CreateRemote(TMetaClass* vmt, const AnsiString 
		MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoCommand(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoCommand(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoRecordset;
class PASCALIMPLEMENTATION CoRecordset : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di_Recordset15 __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di_Recordset15 __fastcall CreateRemote(TMetaClass* vmt, const AnsiString 
		MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoRecordset(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoRecordset(void) { }
	#pragma option pop
	
};


class DELPHICLASS CoParameter;
class PASCALIMPLEMENTATION CoParameter : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	/*         class method */ static _di__Parameter __fastcall Create(TMetaClass* vmt);
	/*         class method */ static _di__Parameter __fastcall CreateRemote(TMetaClass* vmt, const AnsiString 
		MachineName);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall CoParameter(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~CoParameter(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint ADODBMajorVersion = 0x2;
static const Shortint ADODBMinorVersion = 0x7;
extern PACKAGE GUID LIBID_ADODB;
extern PACKAGE GUID IID__Collection;
extern PACKAGE GUID IID__DynaCollection;
extern PACKAGE GUID IID__ADO;
extern PACKAGE GUID IID_Properties;
extern PACKAGE GUID IID_Property_;
extern PACKAGE GUID IID_Error;
extern PACKAGE GUID IID_Errors;
extern PACKAGE GUID IID_Command15;
extern PACKAGE GUID IID_Connection15;
extern PACKAGE GUID IID__Connection;
extern PACKAGE GUID IID_Recordset15;
extern PACKAGE GUID IID_Recordset20;
extern PACKAGE GUID IID_Recordset21;
extern PACKAGE GUID IID__Recordset;
extern PACKAGE GUID IID_Fields15;
extern PACKAGE GUID IID_Fields20;
extern PACKAGE GUID IID_Fields;
extern PACKAGE GUID IID_Field20;
extern PACKAGE GUID IID_Field;
extern PACKAGE GUID IID__Parameter;
extern PACKAGE GUID IID_Parameters;
extern PACKAGE GUID IID_Command25;
extern PACKAGE GUID IID__Command;
extern PACKAGE GUID IID_ConnectionEventsVt;
extern PACKAGE GUID IID_RecordsetEventsVt;
extern PACKAGE GUID DIID_ConnectionEvents;
extern PACKAGE GUID DIID_RecordsetEvents;
extern PACKAGE GUID IID_ADOConnectionConstruction15;
extern PACKAGE GUID IID_ADOConnectionConstruction;
extern PACKAGE GUID CLASS_Connection;
extern PACKAGE GUID IID__Record;
extern PACKAGE GUID CLASS_Record_;
extern PACKAGE GUID IID__Stream;
extern PACKAGE GUID CLASS_Stream;
extern PACKAGE GUID IID_ADORecordConstruction;
extern PACKAGE GUID IID_ADOStreamConstruction;
extern PACKAGE GUID IID_ADOCommandConstruction;
extern PACKAGE GUID CLASS_Command;
extern PACKAGE GUID CLASS_Recordset;
extern PACKAGE GUID IID_ADORecordsetConstruction;
extern PACKAGE GUID IID_Field15;
extern PACKAGE GUID CLASS_Parameter;
static const unsigned adOpenUnspecified = 0xffffffff;
static const Shortint adOpenForwardOnly = 0x0;
static const Shortint adOpenKeyset = 0x1;
static const Shortint adOpenDynamic = 0x2;
static const Shortint adOpenStatic = 0x3;
static const Word adHoldRecords = 0x100;
static const Word adMovePrevious = 0x200;
static const int adAddNew = 0x1000400;
static const int adDelete = 0x1000800;
static const int adUpdate = 0x1008000;
static const Word adBookmark = 0x2000;
static const Word adApproxPosition = 0x4000;
static const int adUpdateBatch = 0x10000;
static const int adResync = 0x20000;
static const int adNotify = 0x40000;
static const int adFind = 0x80000;
static const int adSeek = 0x400000;
static const int adIndex = 0x800000;
static const unsigned adLockUnspecified = 0xffffffff;
static const Shortint adLockReadOnly = 0x1;
static const Shortint adLockPessimistic = 0x2;
static const Shortint adLockOptimistic = 0x3;
static const Shortint adLockBatchOptimistic = 0x4;
static const unsigned adOptionUnspecified = 0xffffffff;
static const Shortint adAsyncExecute = 0x10;
static const Shortint adAsyncFetch = 0x20;
static const Shortint adAsyncFetchNonBlocking = 0x40;
static const Byte adExecuteNoRecords = 0x80;
static const Word adExecuteStream = 0x400;
static const Word adExecuteRecord = 0x800;
static const unsigned adConnectUnspecified = 0xffffffff;
static const Shortint adAsyncConnect = 0x10;
static const Shortint adStateClosed = 0x0;
static const Shortint adStateOpen = 0x1;
static const Shortint adStateConnecting = 0x2;
static const Shortint adStateExecuting = 0x4;
static const Shortint adStateFetching = 0x8;
static const Shortint adUseNone = 0x1;
static const Shortint adUseServer = 0x2;
static const Shortint adUseClient = 0x3;
static const Shortint adUseClientBatch = 0x3;
static const Shortint adEmpty = 0x0;
static const Shortint adTinyInt = 0x10;
static const Shortint adSmallInt = 0x2;
static const Shortint adInteger = 0x3;
static const Shortint adBigInt = 0x14;
static const Shortint adUnsignedTinyInt = 0x11;
static const Shortint adUnsignedSmallInt = 0x12;
static const Shortint adUnsignedInt = 0x13;
static const Shortint adUnsignedBigInt = 0x15;
static const Shortint adSingle = 0x4;
static const Shortint adDouble = 0x5;
static const Shortint adCurrency = 0x6;
static const Shortint adDecimal = 0xe;
static const Byte adNumeric = 0x83;
static const Shortint adBoolean = 0xb;
static const Shortint adError = 0xa;
static const Byte adUserDefined = 0x84;
static const Shortint adVariant = 0xc;
static const Shortint adIDispatch = 0x9;
static const Shortint adIUnknown = 0xd;
static const Shortint adGUID = 0x48;
static const Shortint adDate = 0x7;
static const Byte adDBDate = 0x85;
static const Byte adDBTime = 0x86;
static const Byte adDBTimeStamp = 0x87;
static const Shortint adBSTR = 0x8;
static const Byte adChar = 0x81;
static const Byte adVarChar = 0xc8;
static const Byte adLongVarChar = 0xc9;
static const Byte adWChar = 0x82;
static const Byte adVarWChar = 0xca;
static const Byte adLongVarWChar = 0xcb;
static const Byte adBinary = 0x80;
static const Byte adVarBinary = 0xcc;
static const Byte adLongVarBinary = 0xcd;
static const Byte adChapter = 0x88;
static const Shortint adFileTime = 0x40;
static const Byte adPropVariant = 0x8a;
static const Byte adVarNumeric = 0x8b;
static const Word adArray = 0x2000;
static const unsigned adFldUnspecified = 0xffffffff;
static const Shortint adFldMayDefer = 0x2;
static const Shortint adFldUpdatable = 0x4;
static const Shortint adFldUnknownUpdatable = 0x8;
static const Shortint adFldFixed = 0x10;
static const Shortint adFldIsNullable = 0x20;
static const Shortint adFldMayBeNull = 0x40;
static const Byte adFldLong = 0x80;
static const Word adFldRowID = 0x100;
static const Word adFldRowVersion = 0x200;
static const Word adFldCacheDeferred = 0x1000;
static const Word adFldIsChapter = 0x2000;
static const Word adFldNegativeScale = 0x4000;
static const Word adFldKeyColumn = 0x8000;
static const int adFldIsRowURL = 0x10000;
static const int adFldIsDefaultStream = 0x20000;
static const int adFldIsCollection = 0x40000;
static const Shortint adEditNone = 0x0;
static const Shortint adEditInProgress = 0x1;
static const Shortint adEditAdd = 0x2;
static const Shortint adEditDelete = 0x4;
static const Shortint adRecOK = 0x0;
static const Shortint adRecNew = 0x1;
static const Shortint adRecModified = 0x2;
static const Shortint adRecDeleted = 0x4;
static const Shortint adRecUnmodified = 0x8;
static const Shortint adRecInvalid = 0x10;
static const Shortint adRecMultipleChanges = 0x40;
static const Byte adRecPendingChanges = 0x80;
static const Word adRecCanceled = 0x100;
static const Word adRecCantRelease = 0x400;
static const Word adRecConcurrencyViolation = 0x800;
static const Word adRecIntegrityViolation = 0x1000;
static const Word adRecMaxChangesExceeded = 0x2000;
static const Word adRecObjectOpen = 0x4000;
static const Word adRecOutOfMemory = 0x8000;
static const int adRecPermissionDenied = 0x10000;
static const int adRecSchemaViolation = 0x20000;
static const int adRecDBDeleted = 0x40000;
static const unsigned adGetRowsRest = 0xffffffff;
static const unsigned adPosUnknown = 0xffffffff;
static const unsigned adPosBOF = 0xfffffffe;
static const unsigned adPosEOF = 0xfffffffd;
static const Shortint adBookmarkCurrent = 0x0;
static const Shortint adBookmarkFirst = 0x1;
static const Shortint adBookmarkLast = 0x2;
static const Shortint adMarshalAll = 0x0;
static const Shortint adMarshalModifiedOnly = 0x1;
static const Shortint adAffectCurrent = 0x1;
static const Shortint adAffectGroup = 0x2;
static const Shortint adAffectAll = 0x3;
static const Shortint adAffectAllChapters = 0x4;
static const Shortint adResyncUnderlyingValues = 0x1;
static const Shortint adResyncAllValues = 0x2;
static const Shortint adCompareLessThan = 0x0;
static const Shortint adCompareEqual = 0x1;
static const Shortint adCompareGreaterThan = 0x2;
static const Shortint adCompareNotEqual = 0x3;
static const Shortint adCompareNotComparable = 0x4;
static const Shortint adFilterNone = 0x0;
static const Shortint adFilterPendingRecords = 0x1;
static const Shortint adFilterAffectedRecords = 0x2;
static const Shortint adFilterFetchedRecords = 0x3;
static const Shortint adFilterPredicate = 0x4;
static const Shortint adFilterConflictingRecords = 0x5;
static const Shortint adSearchForward = 0x1;
static const unsigned adSearchBackward = 0xffffffff;
static const Shortint adPersistADTG = 0x0;
static const Shortint adPersistXML = 0x1;
static const Shortint adClipString = 0x2;
static const Shortint adPromptAlways = 0x1;
static const Shortint adPromptComplete = 0x2;
static const Shortint adPromptCompleteRequired = 0x3;
static const Shortint adPromptNever = 0x4;
static const Shortint adModeUnknown = 0x0;
static const Shortint adModeRead = 0x1;
static const Shortint adModeWrite = 0x2;
static const Shortint adModeReadWrite = 0x3;
static const Shortint adModeShareDenyRead = 0x4;
static const Shortint adModeShareDenyWrite = 0x8;
static const Shortint adModeShareExclusive = 0xc;
static const Shortint adModeShareDenyNone = 0x10;
static const int adModeRecursive = 0x400000;
static const Word adCreateCollection = 0x2000;
static const unsigned adCreateStructDoc = 0x80000000;
static const Shortint adCreateNonCollection = 0x0;
static const int adOpenIfExists = 0x2000000;
static const int adCreateOverwrite = 0x4000000;
static const unsigned adFailIfNotExists = 0xffffffff;
static const unsigned adOpenRecordUnspecified = 0xffffffff;
static const int adOpenSource = 0x800000;
static const int adOpenOutput = 0x800000;
static const Word adOpenAsync = 0x1000;
static const Word adDelayFetchStream = 0x4000;
static const Word adDelayFetchFields = 0x8000;
static const int adOpenExecuteCommand = 0x10000;
static const unsigned adXactUnspecified = 0xffffffff;
static const Shortint adXactChaos = 0x10;
static const Word adXactReadUncommitted = 0x100;
static const Word adXactBrowse = 0x100;
static const Word adXactCursorStability = 0x1000;
static const Word adXactReadCommitted = 0x1000;
static const int adXactRepeatableRead = 0x10000;
static const int adXactSerializable = 0x100000;
static const int adXactIsolated = 0x100000;
static const int adXactCommitRetaining = 0x20000;
static const int adXactAbortRetaining = 0x40000;
static const int adXactAsyncPhaseOne = 0x80000;
static const int adXactSyncPhaseOne = 0x100000;
static const Shortint adPropNotSupported = 0x0;
static const Shortint adPropRequired = 0x1;
static const Shortint adPropOptional = 0x2;
static const Word adPropRead = 0x200;
static const Word adPropWrite = 0x400;
static const Word adErrProviderFailed = 0xbb8;
static const Word adErrInvalidArgument = 0xbb9;
static const Word adErrOpeningFile = 0xbba;
static const Word adErrReadFile = 0xbbb;
static const Word adErrWriteFile = 0xbbc;
static const Word adErrNoCurrentRecord = 0xbcd;
static const Word adErrIllegalOperation = 0xc93;
static const Word adErrCantChangeProvider = 0xc94;
static const Word adErrInTransaction = 0xcae;
static const Word adErrFeatureNotAvailable = 0xcb3;
static const Word adErrItemNotFound = 0xcc1;
static const Word adErrObjectInCollection = 0xd27;
static const Word adErrObjectNotSet = 0xd5c;
static const Word adErrDataConversion = 0xd5d;
static const Word adErrObjectClosed = 0xe78;
static const Word adErrObjectOpen = 0xe79;
static const Word adErrProviderNotFound = 0xe7a;
static const Word adErrBoundToCommand = 0xe7b;
static const Word adErrInvalidParamInfo = 0xe7c;
static const Word adErrInvalidConnection = 0xe7d;
static const Word adErrNotReentrant = 0xe7e;
static const Word adErrStillExecuting = 0xe7f;
static const Word adErrOperationCancelled = 0xe80;
static const Word adErrStillConnecting = 0xe81;
static const Word adErrInvalidTransaction = 0xe82;
static const Word adErrNotExecuting = 0xe83;
static const Word adErrUnsafeOperation = 0xe84;
static const Word adwrnSecurityDialog = 0xe85;
static const Word adwrnSecurityDialogHeader = 0xe86;
static const Word adErrIntegrityViolation = 0xe87;
static const Word adErrPermissionDenied = 0xe88;
static const Word adErrDataOverflow = 0xe89;
static const Word adErrSchemaViolation = 0xe8a;
static const Word adErrSignMismatch = 0xe8b;
static const Word adErrCantConvertvalue = 0xe8c;
static const Word adErrCantCreate = 0xe8d;
static const Word adErrColumnNotOnThisRow = 0xe8e;
static const Word adErrURLDoesNotExist = 0xe8f;
static const Word adErrTreePermissionDenied = 0xe90;
static const Word adErrInvalidURL = 0xe91;
static const Word adErrResourceLocked = 0xe92;
static const Word adErrResourceExists = 0xe93;
static const Word adErrCannotComplete = 0xe94;
static const Word adErrVolumeNotFound = 0xe95;
static const Word adErrOutOfSpace = 0xe96;
static const Word adErrResourceOutOfScope = 0xe97;
static const Word adErrUnavailable = 0xe98;
static const Word adErrURLNamedRowDoesNotExist = 0xe99;
static const Word adErrDelResOutOfScope = 0xe9a;
static const Word adErrPropInvalidColumn = 0xe9b;
static const Word adErrPropInvalidOption = 0xe9c;
static const Word adErrPropInvalidValue = 0xe9d;
static const Word adErrPropConflicting = 0xe9e;
static const Word adErrPropNotAllSettable = 0xe9f;
static const Word adErrPropNotSet = 0xea0;
static const Word adErrPropNotSettable = 0xea1;
static const Word adErrPropNotSupported = 0xea2;
static const Word adErrCatalogNotSet = 0xea3;
static const Word adErrCantChangeConnection = 0xea4;
static const Word adErrFieldsUpdateFailed = 0xea5;
static const Word adErrDenyNotSupported = 0xea6;
static const Word adErrDenyTypeNotSupported = 0xea7;
static const Word adErrProviderNotSpecified = 0xea9;
static const Shortint adParamSigned = 0x10;
static const Shortint adParamNullable = 0x40;
static const Byte adParamLong = 0x80;
static const Shortint adParamUnknown = 0x0;
static const Shortint adParamInput = 0x1;
static const Shortint adParamOutput = 0x2;
static const Shortint adParamInputOutput = 0x3;
static const Shortint adParamReturnValue = 0x4;
static const unsigned adCmdUnspecified = 0xffffffff;
static const Shortint adCmdUnknown = 0x8;
static const Shortint adCmdText = 0x1;
static const Shortint adCmdTable = 0x2;
static const Shortint adCmdStoredProc = 0x4;
static const Word adCmdFile = 0x100;
static const Word adCmdTableDirect = 0x200;
static const Shortint adStatusOK = 0x1;
static const Shortint adStatusErrorsOccurred = 0x2;
static const Shortint adStatusCantDeny = 0x3;
static const Shortint adStatusCancel = 0x4;
static const Shortint adStatusUnwantedEvent = 0x5;
static const Shortint adRsnAddNew = 0x1;
static const Shortint adRsnDelete = 0x2;
static const Shortint adRsnUpdate = 0x3;
static const Shortint adRsnUndoUpdate = 0x4;
static const Shortint adRsnUndoAddNew = 0x5;
static const Shortint adRsnUndoDelete = 0x6;
static const Shortint adRsnRequery = 0x7;
static const Shortint adRsnResynch = 0x8;
static const Shortint adRsnClose = 0x9;
static const Shortint adRsnMove = 0xa;
static const Shortint adRsnFirstChange = 0xb;
static const Shortint adRsnMoveFirst = 0xc;
static const Shortint adRsnMoveNext = 0xd;
static const Shortint adRsnMovePrevious = 0xe;
static const Shortint adRsnMoveLast = 0xf;
static const unsigned adSchemaProviderSpecific = 0xffffffff;
static const Shortint adSchemaAsserts = 0x0;
static const Shortint adSchemaCatalogs = 0x1;
static const Shortint adSchemaCharacterSets = 0x2;
static const Shortint adSchemaCollations = 0x3;
static const Shortint adSchemaColumns = 0x4;
static const Shortint adSchemaCheckConstraints = 0x5;
static const Shortint adSchemaConstraintColumnUsage = 0x6;
static const Shortint adSchemaConstraintTableUsage = 0x7;
static const Shortint adSchemaKeyColumnUsage = 0x8;
static const Shortint adSchemaReferentialContraints = 0x9;
static const Shortint adSchemaReferentialConstraints = 0x9;
static const Shortint adSchemaTableConstraints = 0xa;
static const Shortint adSchemaColumnsDomainUsage = 0xb;
static const Shortint adSchemaIndexes = 0xc;
static const Shortint adSchemaColumnPrivileges = 0xd;
static const Shortint adSchemaTablePrivileges = 0xe;
static const Shortint adSchemaUsagePrivileges = 0xf;
static const Shortint adSchemaProcedures = 0x10;
static const Shortint adSchemaSchemata = 0x11;
static const Shortint adSchemaSQLLanguages = 0x12;
static const Shortint adSchemaStatistics = 0x13;
static const Shortint adSchemaTables = 0x14;
static const Shortint adSchemaTranslations = 0x15;
static const Shortint adSchemaProviderTypes = 0x16;
static const Shortint adSchemaViews = 0x17;
static const Shortint adSchemaViewColumnUsage = 0x18;
static const Shortint adSchemaViewTableUsage = 0x19;
static const Shortint adSchemaProcedureParameters = 0x1a;
static const Shortint adSchemaForeignKeys = 0x1b;
static const Shortint adSchemaPrimaryKeys = 0x1c;
static const Shortint adSchemaProcedureColumns = 0x1d;
static const Shortint adSchemaDBInfoKeywords = 0x1e;
static const Shortint adSchemaDBInfoLiterals = 0x1f;
static const Shortint adSchemaCubes = 0x20;
static const Shortint adSchemaDimensions = 0x21;
static const Shortint adSchemaHierarchies = 0x22;
static const Shortint adSchemaLevels = 0x23;
static const Shortint adSchemaMeasures = 0x24;
static const Shortint adSchemaProperties = 0x25;
static const Shortint adSchemaMembers = 0x26;
static const Shortint adSchemaTrustees = 0x27;
static const Shortint adSchemaFunctions = 0x28;
static const Shortint adSchemaActions = 0x29;
static const Shortint adSchemaCommands = 0x2a;
static const Shortint adSchemaSets = 0x2b;
static const Shortint adFieldOK = 0x0;
static const Shortint adFieldCantConvertValue = 0x2;
static const Shortint adFieldIsNull = 0x3;
static const Shortint adFieldTruncated = 0x4;
static const Shortint adFieldSignMismatch = 0x5;
static const Shortint adFieldDataOverflow = 0x6;
static const Shortint adFieldCantCreate = 0x7;
static const Shortint adFieldUnavailable = 0x8;
static const Shortint adFieldPermissionDenied = 0x9;
static const Shortint adFieldIntegrityViolation = 0xa;
static const Shortint adFieldSchemaViolation = 0xb;
static const Shortint adFieldBadStatus = 0xc;
static const Shortint adFieldDefault = 0xd;
static const Shortint adFieldIgnore = 0xf;
static const Shortint adFieldDoesNotExist = 0x10;
static const Shortint adFieldInvalidURL = 0x11;
static const Shortint adFieldResourceLocked = 0x12;
static const Shortint adFieldResourceExists = 0x13;
static const Shortint adFieldCannotComplete = 0x14;
static const Shortint adFieldVolumeNotFound = 0x15;
static const Shortint adFieldOutOfSpace = 0x16;
static const Shortint adFieldCannotDeleteSource = 0x17;
static const Shortint adFieldReadOnly = 0x18;
static const Shortint adFieldResourceOutOfScope = 0x19;
static const Shortint adFieldAlreadyExists = 0x1a;
static const int adFieldPendingInsert = 0x10000;
static const int adFieldPendingDelete = 0x20000;
static const int adFieldPendingChange = 0x40000;
static const int adFieldPendingUnknown = 0x80000;
static const int adFieldPendingUnknownDelete = 0x100000;
static const Shortint adSeekFirstEQ = 0x1;
static const Shortint adSeekLastEQ = 0x2;
static const Shortint adSeekAfterEQ = 0x4;
static const Shortint adSeekAfter = 0x8;
static const Shortint adSeekBeforeEQ = 0x10;
static const Shortint adSeekBefore = 0x20;
static const Shortint adCriteriaKey = 0x0;
static const Shortint adCriteriaAllCols = 0x1;
static const Shortint adCriteriaUpdCols = 0x2;
static const Shortint adCriteriaTimeStamp = 0x3;
static const Shortint adPriorityLowest = 0x1;
static const Shortint adPriorityBelowNormal = 0x2;
static const Shortint adPriorityNormal = 0x3;
static const Shortint adPriorityAboveNormal = 0x4;
static const Shortint adPriorityHighest = 0x5;
static const Shortint adRecalcUpFront = 0x0;
static const Shortint adRecalcAlways = 0x1;
static const Shortint adResyncNone = 0x0;
static const Shortint adResyncAutoIncrement = 0x1;
static const Shortint adResyncConflicts = 0x2;
static const Shortint adResyncUpdates = 0x4;
static const Shortint adResyncInserts = 0x8;
static const Shortint adResyncAll = 0xf;
static const unsigned adMoveUnspecified = 0xffffffff;
static const Shortint adMoveOverWrite = 0x1;
static const Shortint adMoveDontUpdateLinks = 0x2;
static const Shortint adMoveAllowEmulation = 0x4;
static const unsigned adCopyUnspecified = 0xffffffff;
static const Shortint adCopyOverWrite = 0x1;
static const Shortint adCopyAllowEmulation = 0x4;
static const Shortint adCopyNonRecursive = 0x2;
static const Shortint adTypeBinary = 0x1;
static const Shortint adTypeText = 0x2;
static const Shortint adLF = 0xa;
static const Shortint adCR = 0xd;
static const unsigned adCRLF = 0xffffffff;
static const unsigned adOpenStreamUnspecified = 0xffffffff;
static const Shortint adOpenStreamAsync = 0x1;
static const Shortint adOpenStreamFromRecord = 0x4;
static const Shortint adWriteChar = 0x0;
static const Shortint adWriteLine = 0x1;
static const Shortint stWriteChar = 0x0;
static const Shortint stWriteLine = 0x1;
static const Shortint adSaveCreateNotExist = 0x1;
static const Shortint adSaveCreateOverWrite = 0x2;
static const unsigned adDefaultStream = 0xffffffff;
static const unsigned adRecordURL = 0xfffffffe;
static const unsigned adReadAll = 0xffffffff;
static const unsigned adReadLine = 0xfffffffe;
static const Shortint adSimpleRecord = 0x0;
static const Shortint adCollectionRecord = 0x1;
static const Shortint adStructDoc = 0x2;

}	/* namespace Zplainado */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Zplainado;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZPlainAdo
