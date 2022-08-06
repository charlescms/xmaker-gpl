unit CabSTConsts;

(*
 *  Copyright (c) Ravil Batyrshin, 2001-2002
 *  All Rights Reserved
 *  Version 1.20
 *  Aravil Software
 *  web site: aravilsoft.tripod.com
 *  e-mail: aravilsoft@bigfoot.com, wizeman@mail.ru
 *)

interface

resourcestring
	SFciErrNone = 'No error';
	SFciErrOpenSrc = 'Failure opening file to be stored in cabinet';
	SFciErrReadSrc = 'Failure reading file to be stored in cabinet';
	SFciErrAllocFail = 'Out of memory in FCI';
	SFciErrTempFile = 'Could not create a temporary file';
	SFciErrBadComprType = 'Unknown compression type';
	SFciErrCabFile = 'Could not create cabinet file';
	SFciErrUserAbort = 'Client requested abort';
	SFciErrMciFail = 'Failure compressing data';
	SFciErrUnknown = 'FCI error';

	SFdiErrNone = 'No error';
	SFdiErrCabinetNotFound = 'Cabinet not found';
	SFdiErrNotACabinet = 'Cabinet file does not have the correct format';
	SFdiErrUnknownCabinetVersion = 'Cabinet file has an unknown version number';
	SFdiErrCorruptCabinet = 'Cabinet file is corrupt';
	SFdiErrAllocFail = 'Could not allocate enough memory';
	SFdiErrBadComprType = 'Unknown compression type in a cabinet folder';
	SFdiErrMdiFail = 'Failure decompressing data from a cabinet file';
	SFdiErrTargetFile = 'Failure writing to target file';
	SFdiErrReserveMismatch = 'Cabinets in a set do not have the same RESERVE sizes';
	SFdiErrWrongCabinet = 'Cabinet returned on fdintNEXT_CABINET is incorrect';
	SFdiErrUserAbort = 'FDI aborted';
	SFdiErrUnknown = 'FDI error';

	SCabErrSetPosition = 'Failure setting file stream position';

const
	SDiskLabelTemplateDef = 'Disk*';

implementation

end.

