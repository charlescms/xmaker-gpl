// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZTokenizer.pas' rev: 5.00

#ifndef ZTokenizerHPP
#define ZTokenizerHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ZClasses.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
namespace Ztokenizer {class DELPHICLASS TZSymbolNode;}

namespace Ztokenizer
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TZTokenType { ttUnknown, ttEOF, ttFloat, ttInteger, ttHexDecimal, ttNumber, ttSymbol, ttQuoted, 
	ttWord, ttKeyword, ttWhitespace, ttComment, ttSpecial };
#pragma option pop

#pragma option push -b-
enum TZTokenOption { toSkipUnknown, toSkipWhitespaces, toSkipComments, toSkipEOF, toUnifyWhitespaces, 
	toUnifyNumbers, toDecodeStrings };
#pragma option pop

typedef Set<TZTokenOption, toSkipUnknown, toDecodeStrings>  TZTokenOptions;

#pragma pack(push, 1)
struct TZToken
{
	AnsiString Value;
	TZTokenType TokenType;
} ;
#pragma pack(pop)

typedef DynamicArray<TZToken >  TZTokenDynArray;

class DELPHICLASS TZTokenizerState;
class DELPHICLASS TZTokenizer;
class PASCALIMPLEMENTATION TZTokenizerState : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZTokenizerState(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZTokenizerState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZNumberState;
class PASCALIMPLEMENTATION TZNumberState : public TZTokenizerState 
{
	typedef TZTokenizerState inherited;
	
public:
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZNumberState(void) : TZTokenizerState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZNumberState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZQuoteState;
class PASCALIMPLEMENTATION TZQuoteState : public TZTokenizerState 
{
	typedef TZTokenizerState inherited;
	
public:
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
	virtual AnsiString __fastcall EncodeString(AnsiString Value, char QuoteChar);
	virtual AnsiString __fastcall DecodeString(AnsiString Value, char QuoteChar);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZQuoteState(void) : TZTokenizerState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZQuoteState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZCommentState;
class PASCALIMPLEMENTATION TZCommentState : public TZTokenizerState 
{
	typedef TZTokenizerState inherited;
	
public:
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZCommentState(void) : TZTokenizerState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZCppCommentState;
class PASCALIMPLEMENTATION TZCppCommentState : public TZCommentState 
{
	typedef TZCommentState inherited;
	
protected:
	AnsiString __fastcall GetMultiLineComment(Classes::TStream* Stream);
	AnsiString __fastcall GetSingleLineComment(Classes::TStream* Stream);
	
public:
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZCppCommentState(void) : TZCommentState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZCppCommentState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZCCommentState;
class PASCALIMPLEMENTATION TZCCommentState : public TZCppCommentState 
{
	typedef TZCppCommentState inherited;
	
public:
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TZCCommentState(void) : TZCppCommentState() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZCCommentState(void) { }
	#pragma option pop
	
};


typedef DynamicArray<TZSymbolNode* >  TZSymbolNodeArray;

class DELPHICLASS TZSymbolNode;
class PASCALIMPLEMENTATION TZSymbolNode : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	char FCharacter;
	DynamicArray<TZSymbolNode* >  FChildren;
	bool FValid;
	TZSymbolNode* FParent;
	
protected:
	void __fastcall AddDescendantLine(AnsiString Value);
	TZSymbolNode* __fastcall DeepestRead(Classes::TStream* Stream);
	TZSymbolNode* __fastcall EnsureChildWithChar(char Value);
	virtual TZSymbolNode* __fastcall FindChildWithChar(char Value);
	TZSymbolNode* __fastcall FindDescendant(AnsiString Value);
	TZSymbolNode* __fastcall UnreadToValid(Classes::TStream* Stream);
	__property TZSymbolNodeArray Children = {read=FChildren, write=FChildren};
	__property char Character = {read=FCharacter, write=FCharacter, nodefault};
	__property bool Valid = {read=FValid, write=FValid, nodefault};
	__property TZSymbolNode* Parent = {read=FParent, write=FParent};
	
public:
	__fastcall TZSymbolNode(TZSymbolNode* Parent, char Character);
	__fastcall virtual ~TZSymbolNode(void);
	virtual AnsiString __fastcall Ancestry();
};


class DELPHICLASS TZSymbolRootNode;
class PASCALIMPLEMENTATION TZSymbolRootNode : public TZSymbolNode 
{
	typedef TZSymbolNode inherited;
	
protected:
	virtual TZSymbolNode* __fastcall FindChildWithChar(char Value);
	
public:
	__fastcall TZSymbolRootNode(void);
	void __fastcall Add(AnsiString Value);
	virtual AnsiString __fastcall Ancestry();
	AnsiString __fastcall NextSymbol(Classes::TStream* Stream, char FirstChar);
public:
	#pragma option push -w-inl
	/* TZSymbolNode.Destroy */ inline __fastcall virtual ~TZSymbolRootNode(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZSymbolState;
class PASCALIMPLEMENTATION TZSymbolState : public TZTokenizerState 
{
	typedef TZTokenizerState inherited;
	
private:
	TZSymbolRootNode* FSymbols;
	
protected:
	__property TZSymbolRootNode* Symbols = {read=FSymbols, write=FSymbols};
	
public:
	__fastcall TZSymbolState(void);
	__fastcall virtual ~TZSymbolState(void);
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
	virtual void __fastcall Add(AnsiString Value);
};


class DELPHICLASS TZWhitespaceState;
class PASCALIMPLEMENTATION TZWhitespaceState : public TZTokenizerState 
{
	typedef TZTokenizerState inherited;
	
private:
	bool FWhitespaceChars[256];
	
public:
	__fastcall TZWhitespaceState(void);
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
	void __fastcall SetWhitespaceChars(char FromChar, char ToChar, bool Enable);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZWhitespaceState(void) { }
	#pragma option pop
	
};


class DELPHICLASS TZWordState;
class PASCALIMPLEMENTATION TZWordState : public TZTokenizerState 
{
	typedef TZTokenizerState inherited;
	
private:
	bool FWordChars[256];
	
public:
	__fastcall TZWordState(void);
	virtual TZToken __fastcall NextToken(Classes::TStream* Stream, char FirstChar, TZTokenizer* Tokenizer
		);
	void __fastcall SetWordChars(char FromChar, char ToChar, bool Enable);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TZWordState(void) { }
	#pragma option pop
	
};


__interface IZTokenizer;
typedef System::DelphiInterface<IZTokenizer> _di_IZTokenizer;
__interface INTERFACE_UUID("{C7CF190B-C45B-4AB4-A406-5999643DF6A0}") IZTokenizer  : public IUnknown 
	
{
	
public:
	virtual Classes::TStrings* __fastcall TokenizeBufferToList(AnsiString Buffer, TZTokenOptions Options
		) = 0 ;
	virtual Classes::TStrings* __fastcall TokenizeStreamToList(Classes::TStream* Stream, TZTokenOptions 
		Options) = 0 ;
	virtual TZTokenDynArray __fastcall TokenizeBuffer(AnsiString Buffer, TZTokenOptions Options) = 0 ;
	virtual TZTokenDynArray __fastcall TokenizeStream(Classes::TStream* Stream, TZTokenOptions Options)
		 = 0 ;
	virtual TZCommentState* __fastcall GetCommentState(void) = 0 ;
	virtual TZNumberState* __fastcall GetNumberState(void) = 0 ;
	virtual TZQuoteState* __fastcall GetQuoteState(void) = 0 ;
	virtual TZSymbolState* __fastcall GetSymbolState(void) = 0 ;
	virtual TZWhitespaceState* __fastcall GetWhitespaceState(void) = 0 ;
	virtual TZWordState* __fastcall GetWordState(void) = 0 ;
};

class PASCALIMPLEMENTATION TZTokenizer : public Zclasses::TZAbstractObject 
{
	typedef Zclasses::TZAbstractObject inherited;
	
private:
	TZTokenizerState* FCharacterStates[256];
	TZCommentState* FCommentState;
	TZNumberState* FNumberState;
	TZQuoteState* FQuoteState;
	TZSymbolState* FSymbolState;
	TZWhitespaceState* FWhitespaceState;
	TZWordState* FWordState;
	
public:
	__fastcall TZTokenizer(void);
	__fastcall virtual ~TZTokenizer(void);
	Classes::TStrings* __fastcall TokenizeBufferToList(AnsiString Buffer, TZTokenOptions Options);
	Classes::TStrings* __fastcall TokenizeStreamToList(Classes::TStream* Stream, TZTokenOptions Options
		);
	TZTokenDynArray __fastcall TokenizeBuffer(AnsiString Buffer, TZTokenOptions Options);
	TZTokenDynArray __fastcall TokenizeStream(Classes::TStream* Stream, TZTokenOptions Options);
	TZTokenizerState* __fastcall GetCharacterState(char StartChar);
	void __fastcall SetCharacterState(char FromChar, char ToChar, TZTokenizerState* State);
	TZCommentState* __fastcall GetCommentState(void);
	TZNumberState* __fastcall GetNumberState(void);
	TZQuoteState* __fastcall GetQuoteState(void);
	TZSymbolState* __fastcall GetSymbolState(void);
	TZWhitespaceState* __fastcall GetWhitespaceState(void);
	TZWordState* __fastcall GetWordState(void);
	__property TZCommentState* CommentState = {read=FCommentState, write=FCommentState};
	__property TZNumberState* NumberState = {read=FNumberState, write=FNumberState};
	__property TZQuoteState* QuoteState = {read=FQuoteState, write=FQuoteState};
	__property TZSymbolState* SymbolState = {read=FSymbolState, write=FSymbolState};
	__property TZWhitespaceState* WhitespaceState = {read=FWhitespaceState, write=FWhitespaceState};
	__property TZWordState* WordState = {read=FWordState, write=FWordState};
private:
	void *__IZTokenizer;	/* Ztokenizer::IZTokenizer */
	
public:
	operator IZTokenizer*(void) { return (IZTokenizer*)&__IZTokenizer; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ztokenizer */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Ztokenizer;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZTokenizer
