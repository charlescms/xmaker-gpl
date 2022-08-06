unit CabIntf;

(*
 *  Copyright (c) Ravil Batyrshin, 2001-2002
 *  All Rights Reserved
 *  Version 1.20
 *  Aravil Software
 *  web site: aravilsoft.tripod.com
 *  e-mail: aravilsoft@bigfoot.com, wizeman@mail.ru
 *)

{$IFDEF VER130}
	{$ALIGN ON}
{$ELSE}
	{$WARN SYMBOL_PLATFORM OFF}
	{$ALIGN 4}
{$ENDIF}
{$MINENUMSIZE 4}
{$RANGECHECKS OFF}
{$BOOLEVAL OFF}

//{$DEFINE CABINET_STATIC_LINK}
{$IFDEF CABINET_STATIC_LINK}
	{$WEAKPACKAGEUNIT ON}
{$ENDIF}

interface

uses
	Windows, SysUtils;

type
	WIN_BOOL = Integer;

const
	WIN_TRUE = 1;
	WIN_FALSE = 0;

type
	UINT1 = Byte;
	UINT2 = Word;
	UINT4 = Longword;

(*
 *  FCI.H -- File Compression Interface
 *
 *  Copyright (C) Microsoft Corporation 1993-1997
 *  All Rights Reserved.
 *)

type
	PVoid = Pointer;
	USHORT = Word;
	PUSHORT = ^USHORT;

	TCHECKSUM = ULONG; { csum }

	TUOFF = ULONG; { uoff - uncompressed offset }
	TCOFF = ULONG; { coff - cabinet file offset }

(***    ERF - Error structure
 *
 *  This structure returns error information from FCI/FDI.  The caller should
 *  not modify this structure.
 *)

type
	TERF = record
		erfOper: Integer;		// FCI/FDI error code -- see FDIERROR_XXX
												//  and FCIERR_XXX equates for details.
		erfType: Integer;		// Optional error value filled in by FCI/FDI.
												// For FCI, this is usually the C run-time
												// *errno* value.
		fError: WIN_BOOL;	  // TRUE => error present
	end; { erf }

	PERF = ^TERF; { perf }

const
	CB_MAX_CHUNK =             32768;
	CB_MAX_DISK =          $7fffffff; //Fixed!
	CB_MAX_FILENAME =            256;
	CB_MAX_CABINET_NAME =        256;
	CB_MAX_CAB_PATH =            256;
	CB_MAX_DISK_NAME =           256;

(***    tcompXXX - Compression types
 *
 *  These are passed to FCIAddFile(), and are also stored in the CFFOLDER
 *  structures in cabinet files.
 *
 *  NOTE: We reserve bits for the TYPE, QUANTUM_LEVEL, and QUANTUM_MEM
 *        to provide room for future expansion.  Since this value is stored
 *        in the CFDATA records in the cabinet file, we don't want to
 *        have to change the format for existing compression configurations
 *        if we add new ones in the future.  This will allows us to read
 *        old cabinet files in the future.
 *)

type
	TCOMP = USHORT; { tcomp }

const
	tcompMASK_TYPE =          $000F;  // Mask for compression type
	tcompTYPE_NONE =          $0000;  // No compression
	tcompTYPE_MSZIP =         $0001;  // MSZIP
	tcompTYPE_QUANTUM =       $0002;  // Quantum
	tcompTYPE_LZX =           $0003;  // LZX
	tcompBAD =                $000F;  // Unspecified compression type

	tcompMASK_LZX_WINDOW =    $1F00;  // Mask for LZX Compression Memory
	tcompLZX_WINDOW_LO =      $0F00;  // Lowest LZX Memory (15)
	tcompLZX_WINDOW_HI =      $1500;  // Highest LZX Memory (21)
	tcompSHIFT_LZX_WINDOW =       8;  // Amount to shift over to get int

	tcompMASK_QUANTUM_LEVEL = $00F0;  // Mask for Quantum Compression Level
	tcompQUANTUM_LEVEL_LO =   $0010;  // Lowest Quantum Level (1)
	tcompQUANTUM_LEVEL_HI =   $0070;  // Highest Quantum Level (7)
	tcompSHIFT_QUANTUM_LEVEL =    4;  // Amount to shift over to get int

	tcompMASK_QUANTUM_MEM =   $1F00;  // Mask for Quantum Compression Memory
	tcompQUANTUM_MEM_LO =     $0A00;  // Lowest Quantum Memory (10)
	tcompQUANTUM_MEM_HI =     $1500;  // Highest Quantum Memory (21)
	tcompSHIFT_QUANTUM_MEM =      8;  // Amount to shift over to get int

	tcompMASK_RESERVED =      $E000;  // Reserved bits (high 3 bits)

(***    FCIERROR - Error codes returned in erf.erfOper field
 *
 *)

type
	TFCIERROR = (
		FCIERR_NONE,                // No error
		FCIERR_OPEN_SRC,            // Failure opening file to be stored in cabinet
																//  erf.erfTyp has C run-time *errno* value
		FCIERR_READ_SRC,            // Failure reading file to be stored in cabinet
																//  erf.erfTyp has C run-time *errno* value
		FCIERR_ALLOC_FAIL,          // Out of memory in FCI
		FCIERR_TEMP_FILE,           // Could not create a temporary file
																//  erf.erfTyp has C run-time *errno* value
		FCIERR_BAD_COMPR_TYPE,      // Unknown compression type
		FCIERR_CAB_FILE,            // Could not create cabinet file
																//  erf.erfTyp has C run-time *errno* value
		FCIERR_USER_ABORT,          // Client requested abort
		FCIERR_MCI_FAIL            // Failure compressing data
	);

(*
 * FAT file attribute flag used by FCI/FDI to indicate that
 * the filename in the CAB is a UTF string
 *)

const
	_A_NAME_IS_UTF = $80;

(*
 * FAT file attribute flag used by FCI/FDI to indicate that
 * the file should be executed after extraction
 *)

const
	_A_EXEC = $40;

(***    HFCI - Handle to an FCI Context
 *
 *)

type
	HFCI = type PVoid;

(***    CCAB - Current Cabinet
 *
 *  This structure is used for passing in the cabinet parameters to FCI,
 *  and is passed back on certain FCI callbacks to provide cabinet
 *  information to the client.
 *)

type
	TCCAB = record
		// longs first
		cb: ULONG;                  // size available for cabinet on this media
		cbFolderThresh: ULONG;      // Thresshold for forcing a new Folder
		// then ints
		cbReserveCFHeader: UINT;    // Space to reserve in CFHEADER
		cbReserveCFFolder: UINT;    // Space to reserve in CFFOLDER
		cbReserveCFData: UINT;      // Space to reserve in CFDATA
		iCab: Integer;              // sequential numbers for cabinets
		iDisk: Integer;             // Disk number
{$IFNDEF REMOVE_CHICAGO_M6_HACK}
		fFailOnIncompressible: Integer;  // TRUE => Fail if a block is incompressible
{$ENDIF}
		//  then shorts
		setID: USHORT;               // Cabinet set ID
		// then chars
		szDisk: array[0..CB_MAX_DISK_NAME - 1] of AnsiChar;    // current disk name
		szCab: array[0..CB_MAX_CABINET_NAME - 1] of AnsiChar;  // current cabinet name
		szCabPath: array[0..CB_MAX_CAB_PATH - 1] of AnsiChar;  // path for creating cabinet
	end; { ccab }

	PCCAB = ^TCCAB; { pccab }

(***    FNFCIALLOC - Memory Allocation
 *      FNFCIFREE  - Memory Free
 *
 *  These are modeled after the C run-time routines malloc() and free()
 *  FCI expects error handling to be identical to these C run-time routines.
 *
 *  As long as you faithfully copy the semantics of malloc() and free(),
 *  you can supply any functions you like!
 *
 *  WARNING: You should never assume anything about the sequence of
 *           FNFCIALLOC and FNFCIFREE calls -- incremental releases of
 *           FCI may have radically different numbers of
 *           FNFCIALLOC calls and allocation sizes!
 *)
//** Memory functions for FCI

type
	TFNFCIALLOC = function(cb: ULONG): PVoid; cdecl;
	PFNFCIALLOC = TFNFCIALLOC; { pfna }

	TFNFCIFREE = procedure(memory: PVoid); cdecl;
	PFNFCIFREE = TFNFCIFREE; { pfnf }

(***    PFNFCIOPEN  - File I/O callbacks for FCI
 *      PFNFCIREAD
 *      PFNFCIWRITE
 *      PFNFCICLOSE
 *      PFNFCISEEK
 *
 *  These are modeled after the C run-time routines _open, _read,
 *  _write, _close, and _lseek.  The values for the PFNFCIOPEN oflag
 *  and pmode calls are those defined for _open.  FCI expects error
 *  handling to be identical to these C run-time routines, except that
 *  the value of errno should be returned via *err.
 *
 *  As long as you faithfully copy these aspects, you can supply
 *  any functions you like!
 *
 *  WARNING: You should never assume you know what file is being
 *           opened at any one point in time!  It is possible
 *           that in a future implementations it may open temporary
 *           files or cabinet files in a different order.
 *)
//** File I/O functions for FCI

type
	TFNFCIOPEN = function(pszFile: PAnsiChar; oflag: Integer; pmode: Integer;
		err: PInteger; pv: PVoid): Integer; cdecl;
	PFNFCIOPEN = TFNFCIOPEN;

	TFNFCIREAD = function(hf: Integer; memory: PVoid; cb: UINT;
		err: PInteger; pv: PVoid): UINT; cdecl;
	PFNFCIREAD = TFNFCIREAD;

	TFNFCIWRITE = function(hf: Integer; memory: PVoid; cb: UINT;
		err: PInteger; pv: PVoid): UINT; cdecl;
	PFNFCIWRITE = TFNFCIWRITE;

	TFNFCICLOSE = function(hf: Integer; err: PInteger; pv: PVoid): Integer; cdecl;
	PFNFCICLOSE = TFNFCICLOSE;

	TFNFCISEEK = function(hf: Integer; dist: Longint; seektype: Integer;
		err: PInteger; pv: PVoid): Longint; cdecl;
	PFNFCISEEK = TFNFCISEEK;

	TFNFCIDELETE = function(pszFile: PAnsiChar; err: PInteger; pv: PVoid): Integer; cdecl;
	PFNFCIDELETE = TFNFCIDELETE;

(***    FNFCIGETNEXTCABINET - Callback used to request new cabinet info
 *
 *  Entry:
 *      pccab     - Points to copy of old ccab structure to modify
 *      cbPrevCab - Estimate of size of previous cabinet
 *      pv        - Has the caller's context pointer
 *
 *  Exit-Success:
 *      returns TRUE;
 *
 *  Exit-Failure:
 *      returns FALSE;
 *)

type
	TFNFCIGETNEXTCABINET = function(pccab: PCCAB; cbPrevCab: ULONG; pv: PVoid): WIN_BOOL; cdecl;
	PFNFCIGETNEXTCABINET = TFNFCIGETNEXTCABINET; { pfnfcignc }

(***    FNFCIFILEPLACED - Notify FCI client that file was placed
 *
 *  Entry:
 *      pccab         - cabinet structure to fill in, with copy of previous one
 *      pszFile       - name of file, from cabinet
 *      cbFile        - length of file
 *      fContinuation - true if this is a later segment of a continued file
 *      pv            - the context of the client
 *
 *  Exit-Success:
 *      return value anything but -1
 *
 *  Exit-Failure:
 *      return value -1 means to abort
 *)

type
	TFNFCIFILEPLACED = function(pccab: PCCAB; pszFile: PAnsiChar;
		cbFile: Longint; fContinuation: WIN_BOOL; pv: PVoid): Integer; cdecl;
	PFNFCIFILEPLACED = TFNFCIFILEPLACED; { pfnfcifp }

(***    FNCDIGETOPENINFO - Open source file, get date/time/attribs
 *
 *  Entry:
 *      pszName  -- complete path to filename
 *      pdate    -- location to return FAT-style date code
 *      ptime    -- location to return FAT-style time code
 *      pattribs -- location to return FAT-style attributes
 *      pv       -- client's context
 *
 *  Exit-Success:
 *      Return value is file handle of open file to read
 *
 *  Exit-Failure:
 *      Return value is -1
 *)

type
	TFNFCIGETOPENINFO = function(pszName: PAnsiChar; pdate: PUSHORT;
		ptime: PUSHORT; pattribs: PUSHORT; err: PInteger; pv: PVoid): Integer; cdecl;
	PFNFCIGETOPENINFO = TFNFCIGETOPENINFO; { pfnfcigoi }

(***    FNFCISTATUS - Status/Cabinet Size callback
 *
 *  Entry:
 *      typeStatus == statusFile if compressing a block into a folder
 *                      cb1 = Size of compressed block
 *                      cb2 = Size of uncompressed block
 *
 *      typeStatus == statusFolder if adding a folder to a cabinet
 *                      cb1 = Amount of folder copied to cabinet so far
 *                      cb2 = Total size of folder
 *
 *      typeStatus == statusCabinet if writing out a complete cabinet
 *                      cb1 = Estimated cabinet size that was previously
 *                              passed to fnfciGetNextCabinet().
 *                      cb2 = Actual cabinet size
 *                    NOTE: Return value is desired client size for cabinet
 *                          file.  FCI updates the maximum cabinet size
 *                          remaining using this value.  This allows a client
 *                          to generate multiple cabinets per disk, and have
 *                          FCI limit the size correctly -- the client can do
 *                          cluster size rounding on the cabinet size!
 *                          The client should either return cb2, or round cb2
 *                          up to some larger value and return that.
 *  Exit-Success:
 *      Returns anything other than -1;
 *      NOTE: See statusCabinet for special return values!
 *
 *  Exit-Failure:
 *      Returns -1 to signal that FCI should abort;
 *)

const
	statusFile =      0;   // Add File to Folder callback
	statusFolder =    1;   // Add Folder to Cabinet callback
	statusCabinet =   2;   // Write out a completed cabinet callback

type
	TFNFCISTATUS = function(typeStatus: UINT; cb1: ULONG; cb2: ULONG; pv: PVoid): Longint; cdecl;
	PFNFCISTATUS = TFNFCISTATUS; { pfnfcis }

(***    FNFCIGETTEMPFILE - Callback, requests temporary file name
 *
 *  Entry:
 *      pszTempName - Buffer to receive complete tempfile name
 *      cbTempName  - Size of pszTempName buffer
 *
 *  Exit-Success:
 *      return TRUE
 *
 *  Exit-Failure:
 *      return FALSE; could not create tempfile, or buffer too small
 *
 *  Note:
 *      It is conceivable that this function may return a filename
 *      that will already exist by the time it is opened.  For this
 *      reason, the caller should make several attempts to create
 *      temporary files before giving up.
 *)

type
	TFNFCIGETTEMPFILE = function(pszTempName: PAnsiChar; cbTempName: Integer;
		pv: PVoid): WIN_BOOL; cdecl;
	PFNFCIGETTEMPFILE = TFNFCIGETTEMPFILE; { pfnfcigtf }

(***    FCICreate -- create an FCI context (an open CAB, an open FOL)
 *
 *  Entry:
 *      perf      - structure where we return error codes
 *      pfnfcifp  - callback to inform caller of eventual dest of files
 *      pfna      - memory allocation function callback
 *      pfnf      - memory free function callback
 *      pfnfcigtf - temp file name generator callback
 *      pccab     - pointer to cabinet/disk name & size structure
 *
 *  Notes:
 *  (1) The alloc/free callbacks must remain valid throughout
 *      the life of the context, up to and including the call to
 *      FCIDestroy.
 *  (2) The perf pointer is stored in the compression context (HCI),
 *      and any errors from subsequent FCI calls are stored in the
 *      erf that was passed in on *this* call.
 *
 *  Exit-Success:
 *      Returns non-NULL handle to an FCI context.
 *
 *  Exit-Failure:
 *      Returns NULL, perf filled in.
 *)

	function FCICreate(perf: PERF; pfnfcifp: PFNFCIFILEPLACED;
		pfna: PFNFCIALLOC; pfnf: PFNFCIFREE; pfnopen: PFNFCIOPEN;
		pfnread: PFNFCIREAD; pfnwrite: PFNFCIWRITE; pfnclose: PFNFCICLOSE;
		pfnseek: PFNFCISEEK; pfndelete: PFNFCIDELETE;
		pfnfcigtf: PFNFCIGETTEMPFILE; pccab: PCCAB; pv: PVoid): HFCI; cdecl;

type
	TFNFCICreate = function(perf: PERF; pfnfcifp: PFNFCIFILEPLACED;
		pfna: PFNFCIALLOC; pfnf: PFNFCIFREE; pfnopen: PFNFCIOPEN;
		pfnread: PFNFCIREAD; pfnwrite: PFNFCIWRITE; pfnclose: PFNFCICLOSE;
		pfnseek: PFNFCISEEK; pfndelete: PFNFCIDELETE;
		pfnfcigtf: PFNFCIGETTEMPFILE; pccab: PCCAB; pv: PVoid): HFCI; cdecl;

(***   FCIAddFile - Add a disk file to a folder/cabinet
 *
 *  Entry:
 *      hfci          - FCI context handle
 *      pszSourceFile - Name of file to add to folder
 *      pszFileName   - Name to store into folder/cabinet
 *      fExecute      - Flag indicating execute on extract
 *      pfn_progress  - Progress callback
 *      pfnfcignc     - GetNextCabinet callback
 *      pfnfcis       - Status callback
 *      pfnfcigoi     - OpenInfo callback
 *      typeCompress  - Type of compression to use for this file
 *      pv            - pointer to caller's internal context
 *
 *  Exit-Success:
 *      returns TRUE
 *
 *  Exit-Failure:
 *      returns FALSE, error filled in
 *
 *    This is the main function used to add file(s) to a cabinet
 *    or series of cabinets.  If the current file causes the current
 *    folder/cabinet to overflow the disk image currently being built,
 *    the cabinet will be terminated, and a new cabinet/disk name will
 *    be prompted for via a callback.  The pending folder will be trimmed
 *    of the data which has already been generated in the finished cabinet.
 *)

	function FCIAddFile(hfci: HFCI; pszSourceFile: PAnsiChar; pszFileName: PAnsiChar;
		fExecute: WIN_BOOL; pfnfcignc: PFNFCIGETNEXTCABINET; pfnfcis: PFNFCISTATUS;
		pfnfcigoi: PFNFCIGETOPENINFO; typeCompress: TCOMP): WIN_BOOL; cdecl;

type
	TFNFCIAddFile = function(hfci: HFCI; pszSourceFile: PAnsiChar; pszFileName: PAnsiChar;
		fExecute: WIN_BOOL; pfnfcignc: PFNFCIGETNEXTCABINET; pfnfcis: PFNFCISTATUS;
		pfnfcigoi: PFNFCIGETOPENINFO; typeCompress: TCOMP): WIN_BOOL; cdecl;

(***   FCIFlushCabinet - Complete the current cabinet under construction
 *
 *  This will cause the current cabinet (assuming it is not empty) to
 *  be gathered together and written to disk.
 *
 *  Entry:
 *      hfci        - FCI context
 *      fGetNextCab - TRUE  => Call GetNextCab to get continuation info;
 *                    FALSE => Don't call GetNextCab unless this cabinet
 *                             overflows.
 *      pfnfcignc   - callback function to get continuation cabinets
 *      pfnfcis     - callback function for progress reporting
 *      pv          - caller's internal context for callbacks
 *
 *  Exit-Success:
 *      return code TRUE
 *
 *  Exit-Failure:
 *      return code FALSE, error structure filled in
 *)

	function FCIFlushCabinet(hfci: HFCI; fGetNextCab: WIN_BOOL;
		pfnfcignc: PFNFCIGETNEXTCABINET; pfnfcis: PFNFCISTATUS): WIN_BOOL; cdecl;

type
	TFNFCIFlushCabinet = function(hfci: HFCI; fGetNextCab: WIN_BOOL;
		pfnfcignc: PFNFCIGETNEXTCABINET; pfnfcis: PFNFCISTATUS): WIN_BOOL; cdecl;

(***   FCIFlushFolder - Complete the current folder under construction
 *
 *  This will force the termination of the current folder, which may or
 *  may not cause one or more cabinet files to be completed.
 *
 *  Entry:
 *      hfci        - FCI context
 *      GetNextCab  - callback function to get continuation cabinets
 *      pfnProgress - callback function for progress reporting
 *      pv          - caller's internal context for callbacks
 *
 *  Exit-Success:
 *      return code TRUE
 *
 *  Exit-Failure:
 *      return code FALSE, error structure filled in
 *)

	function FCIFlushFolder(hfci: HFCI; pfnfcignc: PFNFCIGETNEXTCABINET;
		pfnfcis: PFNFCISTATUS): WIN_BOOL; cdecl;

type
	TFNFCIFlushFolder = function(hfci: HFCI; pfnfcignc: PFNFCIGETNEXTCABINET;
		pfnfcis: PFNFCISTATUS): WIN_BOOL; cdecl;

(***    FCIDestroy - Destroy a FCI context and delete temp files
 *
 *  Entry:
 *      hfci - FCI context
 *
 *  Exit-Success:
 *      return code TRUE
 *
 *  Exit-Failure:
 *      return code FALSE, error structure filled in
 *)

	function FCIDestroy(hfci: HFCI): WIN_BOOL; cdecl;

type
	TFNFCIDestroy = function(hfci: HFCI): WIN_BOOL; cdecl;


(*
 *  FDI.H -- File Decompression Interface
 *
 *  Copyright (C) Microsoft Corporation 1993-1997
 *  All Rights Reserved.
 *)

(*
 *  Concepts:
 *      A *cabinet* file contains one or more *folders*.  A folder contains
 *      one or more (pieces of) *files*.  A folder is by definition a
 *      decompression unit, i.e., to extract a file from a folder, all of
 *      the data from the start of the folder up through and including the
 *      desired file must be read and decompressed.
 *
 *      A folder can span one (or more) cabinet boundaries, and by implication
 *      a file can also span one (or more) cabinet boundaries.  Indeed, more
 *      than one file can span a cabinet boundary, since FCI concatenates
 *      files together into a single data stream before compressing (actually,
 *      at most one file will span any one cabinet boundary, but FCI does
 *      not know which file this is, since the mapping from uncompressed bytes
 *      to compressed bytes is pretty obscure.  Also, since FCI compresses
 *      in blocks of 32K (at present), any files with data in a 32K block that
 *      spans a cabinet boundary require FDI to read both cabinet files
 *      to get the two halves of the compressed block).
 *
 *  Overview:
 *      The File Decompression Interface is used to simplify the reading of
 *      cabinet files.  A setup program will proceed in a manner very
 *      similar to the pseudo code below.  An FDI context is created, the
 *      setup program calls FDICopy() for each cabinet to be processed.  For
 *      each file in the cabinet, FDICopy() calls a notification callback
 *      routine, asking the setup program if the file should be copied.
 *      This call-back approach is great because it allows the cabinet file
 *      to be read and decompressed in an optimal manner, and also makes FDI
 *      independent of the run-time environment -- FDI makes *no* C run-time
 *      calls whatsoever.  All memory allocation and file I/O functions are
 *      passed into FDI by the client.
 *
 *      main(...)
 *      {
 *          // Read INF file to construct list of desired files.   
 *          //  Ideally, these would be sorted in the same order as the
 *          //  files appear in the cabinets, so that you can just walk
 *          //  down the list in response to fdintCOPY_FILE notifications.
 *
 *          // Construct list of required cabinets. 
 *
 *          hfdi = FDICreate(...);          // Create FDI context
 *          For (cabinet in List of Cabinets) {
 *              FDICopy(hfdi,cabinet,fdiNotify,...);  // Process each cabinet
 *          }
 *          FDIDestroy(hfdi);
 *          ...
 *      }
 *
 *      // Notification callback function 
 *      fdiNotify(fdint,...)
 *      {
 *          If (User Aborted)               // Permit cancellation
 *              if (fdint == fdintCLOSE_FILE_INFO)
 *                  close open file
 *              return -1;
 *          switch (fdint) {
 *              case fdintCOPY_FILE:        // File to copy, maybe
 *                  // Check file against list of desired files 
 *                  if want to copy file
 *                      open destination file and return handle
 *                  else
 *                      return NULL;        // Skip file
 *              case fdintCLOSE_FILE_INFO:
 *                  close file
 *                  set date, time, and attributes
 *
 *              case fdintNEXT_CABINET:
 *                  if not an error callback
 *                      Tell FDI to use suggested directory name
 *                  else
 *                      Tell user what the problem was, and prompt
 *                          for a new disk and/or path.
 *                      if user aborts
 *                          Tell FDI to abort
 *                      else
 *                          return to FDI to try another cabinet
 *
 *              default:
 *                  return 0;               // more messages may be defined
 *              ...
 *      }
 *
 *  Error Handling Suggestions:
 *      Since you the client have passed in *all* of the functions that
 *      FDI uses to interact with the "outside" world, you are in prime
 *      position to understand and deal with errors.
 *
 *      The general philosophy of FDI is to pass all errors back up to
 *      the client.  FDI returns fairly generic error codes in the case
 *      where one of the callback functions (PFNOPEN, PFNREAD, etc.) fail,
 *      since it assumes that the callback function will save enough
 *      information in a static/global so that when FDICopy() returns
 *      fail, the client can examine this information and report enough
 *      detail about the problem that the user can take corrective action.
 *
 *      For very specific errors (CORRUPT_CABINET, for example), FDI returns
 *      very specific error codes.
 *
 *      THE BEST POLICY IS FOR YOUR CALLBACK ROUTINES TO AVOID RETURNING
 *      ERRORS TO FDI!
 *
 *      Examples:
 *          (1) If the disk is getting full, instead of returning an error
 *              from your PFNWRITE function, you should -- inside your
 *              PFNWRITE function -- put up a dialog telling the user to free
 *              some disk space.
 *          (2) When you get the fdintNEXT_CABINET notification, you should
 *              verify that the cabinet you return is the correct one (call
 *              FDIIsCabinet(), and make sure the setID matches the one for
 *              the current cabinet specified in the fdintCABINET_INFO, and
 *              that the disk number is one greater.
 *
 *              NOTE: FDI will continue to call fdintNEXT_CABINET until it
 *                    gets the cabinet it wants, or until you return -1
 *                    to abort the FDICopy() call.
 *
 *      The documentation below on the FDI error codes provides explicit
 *      guidance on how to avoid each error.
 *
 *      If you find you must return a failure to FDI from one of your
 *      callback functions, then FDICopy() frees all resources it allocated
 *      and closes all files.  If you can figure out how to overcome the
 *      problem, you can call FDICopy() again on the last cabinet, and
 *      skip any files that you already copied.  But, note that FDI does
 *      *not* maintain any state between FDICopy() calls, other than possibly
 *      memory allocated for the decompressor.
 *
 *      See FDIERROR for details on FDI error codes and recommended actions.
 *
 *
 *  Progress Indicator Suggestions:
 *      As above, all of the file I/O functions are supplied by you.  So,
 *      updating a progress indicator is very simple.  You keep track of
 *      the target files handles you have opened, along with the uncompressed
 *      size of the target file.  When you see writes to the handle of a
 *      target file, you use the write count to update your status!
 *      Since this method is available, there is no separate callback from
 *      FDI just for progess indication.
 *)

(***    FDIERROR - Error codes returned in erf.erfOper field
 *
 *  In general, FDI will only fail if one of the passed in memory or
 *  file I/O functions fails.  Other errors are pretty unlikely, and are
 *  caused by corrupted cabinet files, passing in a file which is not a
 *  cabinet file, or cabinet files out of order.
 *
 *  Description:    Summary of error.
 *  Cause:          List of possible causes of this error.
 *  Response:       How client might respond to this error, or avoid it in
 *                  the first place.
 *)

type
	TFDIERROR = (
    FDIERROR_NONE,
        // Description: No error
        // Cause:       Function was successfull.
        // Response:    Keep going!
		FDIERROR_CABINET_NOT_FOUND,
				// Description: Cabinet not found
				// Cause:       Bad file name or path passed to FDICopy(), or returned
				//              to fdintNEXT_CABINET.
				// Response:    To prevent this error, validate the existence of the
				//              the cabinet *before* passing the path to FDI.
		FDIERROR_NOT_A_CABINET,
				// Description: Cabinet file does not have the correct format
				// Cause:       File passed to to FDICopy(), or returned to
				//              fdintNEXT_CABINET, is too small to be a cabinet file,
				//              or does not have the cabinet signature in its first
				//              four bytes.
				// Response:    To prevent this error, call FDIIsCabinet() to check a
				//              cabinet before calling FDICopy() or returning the
				//              cabinet path to fdintNEXT_CABINET.
		FDIERROR_UNKNOWN_CABINET_VERSION,
				// Description: Cabinet file has an unknown version number.
				// Cause:       File passed to to FDICopy(), or returned to
				//              fdintNEXT_CABINET, has what looks like a cabinet file
				//              header, but the version of the cabinet file format
				//              is not one understood by this version of FDI.  The
				//              erf.erfType field is filled in with the version number
				//              found in the cabinet file.
				// Response:    To prevent this error, call FDIIsCabinet() to check a
				//              cabinet before calling FDICopy() or returning the
				//              cabinet path to fdintNEXT_CABINET.
		FDIERROR_CORRUPT_CABINET,
				// Description: Cabinet file is corrupt
				// Cause:       FDI returns this error any time it finds a problem
				//              with the logical format of a cabinet file, and any
				//              time one of the passed-in file I/O calls fails when
				//              operating on a cabinet (PFNOPEN, PFNSEEK, PFNREAD,
				//              or PFNCLOSE).  The client can distinguish these two
				//              cases based upon whether the last file I/O call
				//              failed or not.
				// Response:    Assuming this is not a real corruption problem in
				//              a cabinet file, the file I/O functions could attempt
				//              to do retries on failure (for example, if there is a
				//              temporary network connection problem).  If this does
				//              not work, and the file I/O call has to fail, then the
				//              FDI client will have to clean up and call the
				//              FDICopy() function again.
		FDIERROR_ALLOC_FAIL,
				// Description: Could not allocate enough memory
				// Cause:       FDI tried to allocate memory with the PFNALLOC
				//              function, but it failed.
				// Response:    If possible, PFNALLOC should take whatever steps
				//              are possible to allocate the memory requested.  If
				//              memory is not immediately available, it might post a
				//              dialog asking the user to free memory, for example.
				//              Note that the bulk of FDI's memory allocations are
				//              made at FDICreate() time and when the first cabinet
				//              file is opened during FDICopy().
		FDIERROR_BAD_COMPR_TYPE,
				// Description: Unknown compression type in a cabinet folder
				// Cause:       [Should never happen.]  A folder in a cabinet has an
				//              unknown compression type.  This is probably caused by
				//              a mismatch between the version of FCI.LIB used to
				//              create the cabinet and the FDI.LIB used to read the
				//              cabinet.
				// Response:    Abort.
		FDIERROR_MDI_FAIL,
				// Description: Failure decompressing data from a cabinet file
				// Cause:       The decompressor found an error in the data coming
				//              from the file cabinet.  The cabinet file was corrupted.
				//              [11-Apr-1994 bens When checksuming is turned on, this
				//              error should never occur.]
				// Response:    Probably should abort; only other choice is to cleanup
				//              and call FDICopy() again, and hope there was some
				//              intermittent data error that will not reoccur.
		FDIERROR_TARGET_FILE,
				// Description: Failure writing to target file
				// Cause:       FDI returns this error any time it gets an error back
				//              from one of the passed-in file I/O calls fails when
				//              writing to a file being extracted from a cabinet.
				// Response:    To avoid or minimize this error, the file I/O functions
				//              could attempt to avoid failing.  A common cause might
				//              be disk full -- in this case, the PFNWRITE function
				//              could have a check for free space, and put up a dialog
				//              asking the user to free some disk space.
		FDIERROR_RESERVE_MISMATCH,
				// Description: Cabinets in a set do not have the same RESERVE sizes
				// Cause:       [Should never happen]. FDI requires that the sizes of
				//              the per-cabinet, per-folder, and per-data block
				//              RESERVE sections be consistent across all the cabinets
				//              in a set.
				// Response:    Abort.
		FDIERROR_WRONG_CABINET,
				// Description: Cabinet returned on fdintNEXT_CABINET is incorrect
				// Cause:       NOTE: THIS ERROR IS NEVER RETURNED BY FDICopy()!
				//              Rather, FDICopy() keeps calling the fdintNEXT_CABINET
				//              callback until either the correct cabinet is specified,
				//              or you return ABORT.
				//              When FDICopy() is extracting a file that crosses a
				//              cabinet boundary, it calls fdintNEXT_CABINET to ask
				//              for the path to the next cabinet.  Not being very
				//              trusting, FDI then checks to make sure that the
				//              correct continuation cabinet was supplied!  It does
				//              this by checking the "setID" and "iCabinet" fields
				//              in the cabinet.  When MAKECAB.EXE creates a set of
				//              cabinets, it constructs the "setID" using the sum
				//              of the bytes of all the destination file names in
				//              the cabinet set.  FDI makes sure that the 16-bit
				//              setID of the continuation cabinet matches the
				//              cabinet file just processed.  FDI then checks that
				//              the cabinet number (iCabinet) is one more than the
				//              cabinet number for the cabinet just processed.
				// Response:    You need code in your fdintNEXT_CABINET (see below)
				//              handler to do retries if you get recalled with this
				//              error.  See the sample code (EXTRACT.C) to see how
				//              this should be handled.
		FDIERROR_USER_ABORT
				// Description: FDI aborted.
				// Cause:       An FDI callback returnd -1 (usually).
				// Response:    Up to client.
	);

(***    HFDI - Handle to an FDI context
 *
 *  FDICreate() creates this, and it must be passed to all other FDI
 *  functions.
 *)

type
	HFDI = type PVoid; { hfdi }

(***    FDICABINETINFO - Information about a cabinet
 *
 *)

type
	TFDICABINETINFO = record
		cbCabinet: Longint;  // Total length of cabinet file
		cFolders: USHORT;    // Count of folders in cabinet
		cFiles: USHORT;      // Count of files in cabinet
		setID: USHORT;       // Cabinet set ID
		iCabinet: USHORT;    // Cabinet number in set (0 based)
		fReserve: WIN_BOOL;  // TRUE => RESERVE present in cabinet
		hasprev: WIN_BOOL;   // TRUE => Cabinet is chained prev
		hasnext: WIN_BOOL;   // TRUE => Cabinet is chained next
	end; { fdici }

	PFDICABINETINFO = ^TFDICABINETINFO; { pfdici }

(***    FDIDECRYPTTYPE - PFNFDIDECRYPT command types
 *
 *)

type
	TFDIDECRYPTTYPE = (
		fdidtNEW_CABINET,                   // New cabinet
		fdidtNEW_FOLDER,                    // New folder
		fdidtDECRYPT                        // Decrypt a data block
	); { fdidt }

(***    FDIDECRYPT - Data for PFNFDIDECRYPT function
 *
 *)

type
	TFDIDECRYPT = record
		fdidt: TFDIDECRYPTTYPE;   // Command type (selects union below)
		pvUser: PVoid;            // Decryption context
		case Integer of
			1: (
				cabinet: record   // fdidtNEW_CABINET
					pHeaderReserve: PVoid;    // RESERVE section from CFHEADER
					cbHeaderReserve: USHORT;  // Size of pHeaderReserve
					setID: USHORT;            // Cabinet set ID
					iCabinet: Integer;        // Cabinet number in set (0 based)
				end;
			);
			2: (
				folder: record   // fdidtNEW_FOLDER
					pFolderReserve: PVoid;    // RESERVE section from CFFOLDER
					cbFolderReserve: USHORT;  // Size of pFolderReserve
					iFolder: USHORT;          // Folder number in cabinet (0 based)
				end;
			);
			3: (
				decrypt: record  // fdidtDECRYPT
					pDataReserve: PVoid;      // RESERVE section from CFDATA
					cbDataReserve: USHORT;    // Size of pDataReserve
					pbData: PVoid;            // Data buffer
					cbData: USHORT;           // Size of data buffer
					fSplit: WIN_BOOL;         // TRUE if this is a split data block
					cbPartial: USHORT;        // 0 if this is not a split block, or
																		//  the first piece of a split block;
																		// Greater than 0 if this is the
																		//  second piece of a split block.
				end;
			);
	end; { fdid }

	PFDIDECRYPT = ^TFDIDECRYPT; { pfdid }

(***    FNALLOC - Memory Allocation
 *      FNFREE  - Memory Free
 *
 *  These are modeled after the C run-time routines malloc() and free()
 *  FDI expects error handling to be identical to these C run-time routines.
 *
 *  As long as you faithfully copy the semantics of malloc() and free(),
 *  you can supply any functions you like!
 *
 *  WARNING: You should never assume anything about the sequence of
 *           PFNALLOC and PFNFREE calls -- incremental releases of
 *           FDI may have radically different numbers of
 *           PFNALLOC calls and allocation sizes!
 *)
//** Memory functions for FDI

type
	TFNALLOC = function(cb: ULONG): PVoid; cdecl;
	PFNALLOC = TFNALLOC; { pfna }

	TFNFREE = procedure(pv: PVoid); cdecl;
	PFNFREE = TFNFREE; { pfnf }

(***    PFNOPEN  - File I/O callbacks for FDI
 *      PFNREAD
 *      PFNWRITE
 *      PFNCLOSE
 *      PFNSEEK
 *
 *  These are modeled after the C run-time routines _open, _read,
 *  _write, _close, and _lseek.  The values for the PFNOPEN oflag
 *  and pmode calls are those defined for _open.  FDI expects error
 *  handling to be identical to these C run-time routines.
 *
 *  As long as you faithfully copy these aspects, you can supply
 *  any functions you like!
 *
 *  WARNING: You should never assume you know what file is being
 *           opened at any one point in time!  FDI will usually
 *           stick to opening cabinet files, but it is possible
 *           that in a future implementation it may open temporary
 *           files or open cabinet files in a different order.
 *
 *  Notes for Memory Mapped File fans:
 *      You can write wrapper routines to allow FDI to work on memory
 *      mapped files.  You'll have to create your own "handle" type so that
 *      you can store the base memory address of the file and the current
 *      seek position, and then you'll allocate and fill in one of these
 *      structures and return a pointer to it in response to the PFNOPEN
 *      call and the fdintCOPY_FILE call.  Your PFNREAD and PFNWRITE
 *      functions will do memcopy(), and update the seek position in your
 *      "handle" structure.  PFNSEEK will just change the seek position
 *      in your "handle" structure.
 *)
//** File I/O functions for FDI

type
	TFNOPEN = function(pszFile: PAnsiChar; oflag: Integer; pmode: Integer): Integer; cdecl;
	PFNOPEN = TFNOPEN;

	TFNREAD = function(hf: Integer; pv: PVoid; cb: UINT): UINT; cdecl;
	PFNREAD = TFNREAD;

	TFNWRITE = function(hf: Integer; pv: PVoid; cb: UINT): UINT; cdecl;
	PFNWRITE = TFNWRITE;

	TFNCLOSE = function(hf: Integer): Integer; cdecl;
	PFNCLOSE = TFNCLOSE;

	TFNSEEK = function(hf: Integer; dist: Longint; seektype: Integer): Longint; cdecl;
	PFNSEEK = TFNSEEK;

(***    PFNFDIDECRYPT - FDI Decryption callback
 *
 *  If this function is passed on the FDICopy() call, then FDI calls it
 *  at various times to update the decryption state and to decrypt FCDATA
 *  blocks.
 *
 *  Common Entry Conditions:
 *      pfdid->fdidt  - Command type
 *      pfdid->pvUser - pvUser value from FDICopy() call
 *
 *  fdidtNEW_CABINET:   //** Notification of a new cabinet
 *      Entry:
 *        pfdid->cabinet.
 *          pHeaderReserve  - RESERVE section from CFHEADER
 *          cbHeaderReserve - Size of pHeaderReserve
 *          setID           - Cabinet set ID
 *          iCabinet        - Cabinet number in set (0 based)
 *      Exit-Success:
 *          returns anything but -1;
 *      Exit-Failure:
 *          returns -1; FDICopy() is aborted.
 *      Notes:
 *      (1) This call allows the decryption code to pick out any information
 *          from the cabinet header reserved area (placed there by DIACRYPT)
 *          needed to perform decryption.  If there is no such information,
 *          this call would presumably be ignored.
 *      (2) This call is made very soon after fdintCABINET_INFO.
 *
 *  fdidtNEW_FOLDER:    //** Notification of a new folder
 *      Entry:
 *        pfdid->folder.
 *          pFolderReserve  - RESERVE section from CFFOLDER
 *          cbFolderReserve - Size of pFolderReserve
 *          iFolder         - Folder number in cabinet (0 based)
 *      Exit-Success:
 *          returns anything but -1;
 *      Exit-Failure:
 *          returns -1; FDICopy() is aborted.
 *      Notes:
 *          This call allows the decryption code to pick out any information
 *          from the folder reserved area (placed there by DIACRYPT) needed
 *          to perform decryption.  If there is no such information, this
 *          call would presumably be ignored.
 *
 *  fdidtDECRYPT:       //** Decrypt a data buffer
 *      Entry:
 *        pfdid->folder.
 *          pDataReserve  - RESERVE section for this CFDATA block
 *          cbDataReserve - Size of pDataReserve
 *          pbData        - Data buffer
 *          cbData        - Size of data buffer
 *          fSplit        - TRUE if this is a split data block
 *          cbPartial     - 0 if this is not a split block, or the first
 *                              piece of a split block; Greater than 0 if
 *                              this is the second piece of a split block.
 *      Exit-Success:
 *          returns TRUE;
 *      Exit-Failure:
 *          returns FALSE; error during decrypt
 *          returns -1; FDICopy() is aborted.
 *      Notes:
 *          FCI will split CFDATA blocks across cabinet boundaries if
 *          necessary.  To provide maximum flexibility, FDI will call the
 *          fdidtDECRYPT function twice on such split blocks, once when
 *          the first portion is read, and again when the second portion
 *          is read.  And, of course, most data blocks will not be split.
 *          So, there are three cases:
 *
 *           1) fSplit == FALSE
 *              You have the entire data block, so decrypt it.
 *
 *           2) fSplit == TRUE, cbPartial == 0
 *              This is the first portion of a split data block, so cbData
 *              is the size of this portion.  You can either choose to decrypt
 *              this piece, or ignore this call and decrypt the full CFDATA
 *              block on the next (second) fdidtDECRYPT call.
 *
 *           3) fSplit == TRUE, cbPartial > 0
 *              This is the second portion of a split data block (indeed,
 *              cbPartial will have the same value as cbData did on the
 *              immediately preceeding fdidtDECRYPT call!).  If you decrypted
 *              the first portion on the first call, then you can decrypt the
 *              second portion now.  If you ignored the first call, then you
 *              can decrypt the entire buffer.
 *              NOTE: pbData points to the second portion of the split data
 *                    block in this case, *not* the entire data block.  If
 *                    you want to wait until the second piece to decrypt the
 *                    *entire* block, pbData-cbPartial is the address of the
 *                    start of the whole block, and cbData+cbPartial is its
 *                    size.
 *)

type
	TFNFDIDECRYPT = function(pfdid: PFDIDECRYPT): Integer; cdecl;
	PFNFDIDECRYPT = TFNFDIDECRYPT; { pfnfdid }

(***    FDINOTIFICATION - Notification structure for PFNFDINOTIFY
 *
 *  See the FDINOTIFICATIONTYPE definition for information on usage and
 *  meaning of these fields.
 *)

type
	TFDINOTIFICATION = record
		// long fields
		cb: Longint;
		psz1: PAnsiChar;
		psz2: PAnsiChar;
		psz3: PAnsiChar;                  // Points to a 256 character buffer
		pv: PVoid;                        // Value for client
		// int fields
		hf: Integer;
		// short fields
		date: USHORT;
		time: USHORT;
		attribs: USHORT;

		setID: USHORT;                    // Cabinet set ID
		iCabinet: USHORT;                 // Cabinet number (0-based)
		iFolder: USHORT;                  // Folder number (0-based)

		fdie: TFDIERROR;
	end; { fdin }

	PFDINOTIFICATION = ^TFDINOTIFICATION; { pfdin }

(***    FDINOTIFICATIONTYPE - FDICopy notification types
 *
 *  The notification function for FDICopy can be called with the following
 *  values for the fdint parameter.  In all cases, the pfdin->pv field is
 *  filled in with the value of the pvUser argument passed in to FDICopy().
 *
 *  A typical sequence of calls will be something like this:
 *      fdintCABINET_INFO     // Info about the cabinet
 *      fdintENUMERATE        // Starting enumeration
 *      fdintPARTIAL_FILE     // Only if this is not the first cabinet, and
 *                            // one or more files were continued from the
 *                            // previous cabinet.
 *      ...
 *      fdintPARTIAL_FILE
 *      fdintCOPY_FILE        // The first file that starts in this cabinet
 *      ...
 *      fdintCOPY_FILE        // Now let's assume you want this file...
 *      // PFNWRITE called multiple times to write to this file.
 *      fdintCLOSE_FILE_INFO  // File done, set date/time/attributes
 *
 *      fdintCOPY_FILE        // Now let's assume you want this file...
 *      // PFNWRITE called multiple times to write to this file.
 *      fdintNEXT_CABINET     // File was continued to next cabinet!
 *      fdintCABINET_INFO     // Info about the new cabinet
 *      // PFNWRITE called multiple times to write to this file.
 *      fdintCLOSE_FILE_INFO  // File done, set date/time/attributes
 *      ...
 *      fdintENUMERATE        // Ending enumeration
 *
 *  fdintCABINET_INFO:
 *        Called exactly once for each cabinet opened by FDICopy(), including
 *        continuation cabinets opened due to file(s) spanning cabinet
 *        boundaries. Primarily intended to permit EXTRACT.EXE to
 *        automatically select the next cabinet in a cabinet sequence even if
 *        not copying files that span cabinet boundaries.
 *      Entry:
 *          pfdin->psz1     = name of next cabinet
 *          pfdin->psz2     = name of next disk
 *          pfdin->psz3     = cabinet path name
 *          pfdin->setID    = cabinet set ID (a random 16-bit number)
 *          pfdin->iCabinet = Cabinet number within cabinet set (0-based)
 *      Exit-Success:
 *          Return anything but -1
 *      Exit-Failure:
 *          Returns -1 => Abort FDICopy() call
 *      Notes:
 *          This call is made *every* time a new cabinet is examined by
 *          FDICopy().  So if "foo2.cab" is examined because a file is
 *          continued from "foo1.cab", and then you call FDICopy() again
 *          on "foo2.cab", you will get *two* fdintCABINET_INFO calls all
 *          told.
 *
 *  fdintCOPY_FILE:
 *        Called for each file that *starts* in the current cabinet, giving
 *        the client the opportunity to request that the file be copied or
 *        skipped.
 *      Entry:
 *          pfdin->psz1    = file name in cabinet
 *          pfdin->cb      = uncompressed size of file
 *          pfdin->date    = file date
 *          pfdin->time    = file time
 *          pfdin->attribs = file attributes
 *          pfdin->iFolder = file's folder index
 *      Exit-Success:
 *          Return non-zero file handle for destination file; FDI writes
 *          data to this file use the PFNWRITE function supplied to FDICreate,
 *          and then calls fdintCLOSE_FILE_INFO to close the file and set
 *          the date, time, and attributes.  NOTE: This file handle returned
 *          must also be closeable by the PFNCLOSE function supplied to
 *          FDICreate, since if an error occurs while writing to this handle,
 *          FDI will use the PFNCLOSE function to close the file so that the
 *          client may delete it.
 *      Exit-Failure:
 *          Returns 0  => Skip file, do not copy
 *          Returns -1 => Abort FDICopy() call
 *
 *  fdintCLOSE_FILE_INFO:
 *        Called after all of the data has been written to a target file.
 *        This function must close the file and set the file date, time,
 *        and attributes.
 *      Entry:
 *          pfdin->psz1    = file name in cabinet
 *          pfdin->hf      = file handle
 *          pfdin->date    = file date
 *          pfdin->time    = file time
 *          pfdin->attribs = file attributes
 *          pfdin->iFolder = file's folder index
 *          pfdin->cb      = Run After Extract (0 - don't run, 1 Run)
 *      Exit-Success:
 *          Returns TRUE
 *      Exit-Failure:
 *          Returns FALSE, or -1 to abort;
 *
 *              IMPORTANT NOTE IMPORTANT:
 *                  pfdin->cb is overloaded to no longer be the size of
 *                  the file but to be a binary indicated run or not
 *
 *              IMPORTANT NOTE:
 *                  FDI assumes that the target file was closed, even if this
 *                  callback returns failure.  FDI will NOT attempt to use
 *                  the PFNCLOSE function supplied on FDICreate() to close
 *                  the file!
 *
 *  fdintPARTIAL_FILE:
 *        Called for files at the front of the cabinet that are CONTINUED
 *        from a previous cabinet.  This callback occurs only when FDICopy is
 *        started on second or subsequent cabinet in a series that has files
 *        continued from a previous cabinet.
 *      Entry:
 *          pfdin->psz1 = file name of file CONTINUED from a PREVIOUS cabinet
 *          pfdin->psz2 = name of cabinet where file starts
 *          pfdin->psz3 = name of disk where file starts
 *      Exit-Success:
 *          Return anything other than -1; enumeration continues
 *      Exit-Failure:
 *          Returns -1 => Abort FDICopy() call
 *
 *  fdintENUMERATE:
 *        Called once after a call to FDICopy() starts scanning a CAB's
 *        CFFILE entries, and again when there are no more CFFILE entries.
 *        If CAB spanning occurs, an additional call will occur after the
 *        first spanned file is completed.  If the pfdin->iFolder value is
 *        changed from zero, additional calls will occur next time it reaches
 *        zero.  If iFolder is changed to zero, FDICopy will terminate, as if
 *        there were no more CFFILE entries.  Primarily intended to allow an
 *        application with it's own file list to help FDI advance quickly to
 *        a CFFILE entry of interest.  Can also be used to allow an
 *        application to determine the cb values for each file in the CAB.
 *      Entry:
 *        pfdin->cb        = current CFFILE position
 *        pfdin->iFolder   = number of files remaining
 *        pfdin->setID     = current CAB's setID value
 *      Exit-Don't Care:
 *        Don't change anything.
 *        Return anything but -1.
 *      Exit-Forcing a skip:
 *        pfdin->cb        = desired CFFILE position
 *        pfdin->iFolder   = desired # of files remaining
 *        Return anything but -1.
 *      Exit-Stop:
 *        pfdin->iFolder    = set to 0
 *        Return anything but -1.
 *      Exit-Failure:
 *        Return -1 => Abort FDICopy call ("user aborted".)
 *      Notes:
 *        This call can be ignored by applications which want normal file
 *        searching.  The application can adjust the supplied values to
 *        force FDICopy() to continue it's search at another location, or
 *        to force FDICopy() to terminate the search, by setting iFolder to 0.
 *        (FDICopy() will report no error when terminated this way.)
 *        FDI has no means to verify the supplied cb or iFolder values.
 *        Arbitrary values are likely to cause undesirable results.  An
 *        application should cross-check pfdin->setID to be certain the
 *        external database is in sync with the CAB.  Reverse-skips are OK
 *        (but may be inefficient) unless fdintNEXT_CABINET has been called.
 *
 *  fdintNEXT_CABINET:
 *        This function is *only* called when fdintCOPY_FILE was told to copy
 *        a file in the current cabinet that is continued to a subsequent
 *        cabinet file.  It is important that the cabinet path name (psz3)
 *        be validated before returning!  This function should ensure that
 *        the cabinet exists and is readable before returning.  So, this
 *        is the function that should, for example, issue a disk change
 *        prompt and make sure the cabinet file exists.
 *
 *        When this function returns to FDI, FDI will check that the setID
 *        and iCabinet match the expected values for the next cabinet.
 *        If not, FDI will continue to call this function until the correct
 *        cabinet file is specified, or until this function returns -1 to
 *        abort the FDICopy() function.  pfdin->fdie is set to
 *        FDIERROR_WRONG_CABINET to indicate this case.
 *
 *        If you *haven't* ensured that the cabinet file is present and
 *        readable, or the cabinet file has been damaged, pfdin->fdie will
 *        receive other appropriate error codes:
 *
 *              FDIERROR_CABINET_NOT_FOUND
 *              FDIERROR_NOT_A_CABINET
 *              FDIERROR_UNKNOWN_CABINET_VERSION
 *              FDIERROR_CORRUPT_CABINET
 *              FDIERROR_BAD_COMPR_TYPE
 *              FDIERROR_RESERVE_MISMATCH
 *              FDIERROR_WRONG_CABINET
 *
 *      Entry:
 *          pfdin->psz1 = name of next cabinet where current file is continued
 *          pfdin->psz2 = name of next disk where current file is continued
 *          pfdin->psz3 = cabinet path name; FDI concatenates psz3 with psz1
 *                          to produce the fully-qualified path for the cabinet
 *                          file.  The 256-byte buffer pointed at by psz3 may
 *                          be modified, but psz1 may not!
 *          pfdin->fdie = FDIERROR_WRONG_CABINET if the previous call to
 *                        fdintNEXT_CABINET specified a cabinet file that
 *                        did not match the setID/iCabinet that was expected.
 *      Exit-Success:
 *          Return anything but -1
 *      Exit-Failure:
 *          Returns -1 => Abort FDICopy() call
 *      Notes:
 *          This call is almost always made when a target file is open and
 *          being written to, and the next cabinet is needed to get more
 *          data for the file.
 *)

type
	TFDINOTIFICATIONTYPE = (
    fdintCABINET_INFO,              // General information about cabinet
    fdintPARTIAL_FILE,              // First file in cabinet is continuation
    fdintCOPY_FILE,                 // File to be copied
    fdintCLOSE_FILE_INFO,           // close the file, set relevant info
    fdintNEXT_CABINET,              // File continued to next cabinet
		fdintENUMERATE                  // Enumeration status
	); { fdint }

	TFNFDINOTIFY = function(fdint: TFDINOTIFICATIONTYPE; pfdin: PFDINOTIFICATION): Integer; cdecl;
	PFNFDINOTIFY = TFNFDINOTIFY; { pfnfdin }

(*** cpuType values for FDICreate()
 *
 *  (Ignored by 32-bit FDI.)
 *)

const
	cpuUNKNOWN = -1;
	cpu80286 = 0;
	cpu80386 = 1;

(***    FDICreate - Create an FDI context
 *
 *  Entry:
 *      pfnalloc
 *      pfnfree
 *      pfnopen
 *      pfnread
 *      pfnwrite
 *      pfnclose
 *      pfnlseek
 *      cpuType  - Select CPU type (auto-detect, 286, or 386+)
 *                 NOTE: For the 32-bit FDI.LIB, this parameter is ignored!
 *      perf
 *
 *  Exit-Success:
 *      Returns non-NULL FDI context handle.
 *
 *  Exit-Failure:
 *      Returns NULL; perf filled in with error code
 *
 *)

	function FDICreate(pfnalloc: PFNALLOC; pfnfree: PFNFREE; pfnopen: PFNOPEN;
		pfnread: PFNREAD; pfnwrite: PFNWRITE; pfnclose: PFNCLOSE;
		pfnseek: PFNSEEK; cpuType: Integer; perf: PERF): HFDI; cdecl;

type
	TFNFDICreate = function(pfnalloc: PFNALLOC; pfnfree: PFNFREE; pfnopen: PFNOPEN;
		pfnread: PFNREAD; pfnwrite: PFNWRITE; pfnclose: PFNCLOSE;
		pfnseek: PFNSEEK; cpuType: Integer; perf: PERF): HFDI; cdecl;

(***    FDIIsCabinet - Determines if file is a cabinet, returns info if it is
 *
 *  Entry:
 *      hfdi   - Handle to FDI context (created by FDICreate())
 *      hf     - File handle suitable for PFNREAD/PFNSEEK, positioned
 *               at offset 0 in the file to test.
 *      pfdici - Buffer to receive info about cabinet if it is one.
 *
 *  Exit-Success:
 *      Returns TRUE; file is a cabinet, pfdici filled in.
 *
 *  Exit-Failure:
 *      Returns FALSE, file is not a cabinet;  If an error occurred,
 *          perf (passed on FDICreate call!) filled in with error.
 *)

	function FDIIsCabinet(hfdi: HFDI; hf: Integer; pfdici: PFDICABINETINFO): WIN_BOOL; cdecl;

type
	TFNFDIIsCabinet = function(hfdi: HFDI; hf: Integer; pfdici: PFDICABINETINFO): WIN_BOOL; cdecl;

(***    FDICopy - extracts files from a cabinet
 *
 *  Entry:
 *      hfdi        - handle to FDI context (created by FDICreate())
 *      pszCabinet  - main name of cabinet file
 *      pszCabPath  - Path to cabinet file(s)
 *      flags       - Flags to modify behavior
 *      pfnfdin     - Notification function
 *      pfnfdid     - Decryption function (pass NULL if not used)
 *      pvUser      - User specified value to pass to notification function
 *
 *  Exit-Success:
 *      Returns TRUE;
 *
 *  Exit-Failure:
 *      Returns FALSE, perf (passed on FDICreate call!) filled in with
 *          error.
 *
 *  Notes:
 *  (1) If FDICopy() fails while a target file is being written out, then
 *      FDI will use the PFNCLOSE function to close the file handle for that
 *      target file that was returned from the fdintCOPY_FILE notification.
 *      The client application is then free to delete the target file, since
 *      it will not be in a valid state (since there was an error while
 *      writing it out).
 *)

	function FDICopy(hfdi: HFDI; pszCabinet: PAnsiChar; pszCabPath: PAnsiChar;
		flags: Integer; pfnfdin: PFNFDINOTIFY; pfnfdid: PFNFDIDECRYPT;
		pvUser: PVoid): WIN_BOOL; cdecl;

type
	TFNFDICopy = function(hfdi: HFDI; pszCabinet: PAnsiChar; pszCabPath: PAnsiChar;
		flags: Integer; pfnfdin: PFNFDINOTIFY; pfnfdid: PFNFDIDECRYPT;
		pvUser: PVoid): WIN_BOOL; cdecl;

(***    FDIDestroy - Destroy an FDI context
 *
 *  Entry:
 *      hfdi - handle to FDI context (created by FDICreate())
 *
 *  Exit-Success:
 *      Returns TRUE;
 *
 *  Exit-Failure:
 *      Returns FALSE;
 *)

	function FDIDestroy(hfdi: HFDI): WIN_BOOL; cdecl;

type
	TFNFDIDestroy = function(hfdi: HFDI): WIN_BOOL; cdecl;


	function CompressionTypeFromTCOMP(tc: TCOMP): TCOMP;
	function CompressionLevelFromTCOMP(tc: TCOMP): TCOMP;
	function CompressionMemoryFromTCOMP(tc: TCOMP): TCOMP;
	function TCOMPfromTypeLevelMemory(t, l, m: TCOMP): TCOMP;
	function LZXCompressionWindowFromTCOMP(tc: TCOMP): TCOMP;
	function TCOMPfromLZXWindow(w: TCOMP): TCOMP;

const
	BooleanToWinBool: array[Boolean] of WIN_BOOL = (WIN_FALSE, WIN_TRUE);


type
	// Truncated!
	TCFHEADER = packed record
		signature: UINT4;	// cabinet file signature
		reserved1: UINT4;	// reserved
		cbCabinet: UINT4;	// size of this cabinet file in bytes
		reserved2: UINT4;	// reserved
		coffFiles: UINT4;	// offset of the first CFFILE entry
		reserved3: UINT4;	// reserved
		versionMinor: UINT1;	// cabinet file format version, minor
		versionMajor: UINT1;	// cabinet file format version, major
		cFolders: UINT2;	// number of CFFOLDER entries in this cabinet
		cFiles: UINT2;	// number of CFFILE entries in this cabinet
		flags: UINT2;	// cabinet file option indicators
		setID: UINT2;	// must be the same for all cabinets in a set
		iCabinet: UINT2;	// number of this cabinet file in a set
{		cbCFHeader: UINT2; 	// (optional) size of per-cabinet reserved area
		cbCFFolder: UINT1; 	// (optional) size of per-folder reserved area
		cbCFData: UINT1; 	// (optional) size of per-datablock reserved area
		abReserve: UINT1[];	// (optional) per-cabinet reserved area
		szCabinetPrev: AnsiChar[];	// (optional) name of previous cabinet file
		szDiskPrev: AnsiChar[];	// (optional) name of previous disk
		szCabinetNext: AnsiChar[];	// (optional) name of next cabinet file
		szDiskNext: AnsiChar[];	// (optional) name of next disk   }
	end;

const
	cfhdrSIGNATURE: UINT4 = $4643534D;

	cfhdrPREV_CABINET: UINT2 =    $0001;
	cfhdrNEXT_CABINET: UINT2 =    $0002;
	cfhdrRESERVE_PRESENT: UINT2 = $0004;

type
	// Truncated!
	TCFFOLDER = packed record
		coffCabStart: UINT4;	// offset of the first CFDATA block in this folder
		cCFData: UINT2;	// number of CFDATA blocks in this folder
		typeCompress: UINT2;	// compression type indicator
{		abReserve: UINT1[];	// (optional) per-folder reserved area   }
	end;

	// Truncated!
	TCFFILE = packed record
		cbFile: UINT4;	// uncompressed size of this file in bytes
		uoffFolderStart: UINT4;	// uncompressed offset of this file in the folder
		iFolder: UINT2;	// index into the CFFOLDER area
		date: UINT2;	// date stamp for this file
		time: UINT2;	// time stamp for this file
		attribs: UINT2;	// attribute flags for this file
{		szName: AnsiChar[];	// name of this file   }
	end;

const
	ifoldCONTINUED_FROM_PREV: UINT2 =     $FFFD;
	ifoldCONTINUED_TO_NEXT: UINT2 =       $FFFE;
	ifoldCONTINUED_PREV_AND_NEXT: UINT2 = $FFFF;

type
	// Truncated!
	TCFDATA = packed record
		csum: UINT4;	// checksum of this CFDATA entry
		cbData: UINT2;	// number of compressed bytes in this block
		cbUncomp: UINT2;	// number of uncompressed bytes in this block
{		abReserve: UINT1[];	// (optional) per-datablock reserved area
		ab: UINT1[cbData];	// compressed data bytes   }
	end;

implementation

function CompressionTypeFromTCOMP(tc: TCOMP): TCOMP;
begin
	Result := tc and tcompMASK_TYPE;
end;

function CompressionLevelFromTCOMP(tc: TCOMP): TCOMP;
begin
	Result := (tc and tcompMASK_QUANTUM_LEVEL) shr tcompSHIFT_QUANTUM_LEVEL;
end;

function CompressionMemoryFromTCOMP(tc: TCOMP): TCOMP;
begin
	Result := (tc and tcompMASK_QUANTUM_MEM) shr tcompSHIFT_QUANTUM_MEM;
end;

function TCOMPfromTypeLevelMemory(t, l, m: TCOMP): TCOMP;
begin
	Result := (m shl tcompSHIFT_QUANTUM_MEM) or (l shl tcompSHIFT_QUANTUM_LEVEL) or t;
end;

function LZXCompressionWindowFromTCOMP(tc: TCOMP): TCOMP;
begin
	Result := (tc and tcompMASK_LZX_WINDOW) shr tcompSHIFT_LZX_WINDOW;
end;

function TCOMPfromLZXWindow(w: TCOMP): TCOMP;
begin
	Result := (w shl tcompSHIFT_LZX_WINDOW) or tcompTYPE_LZX;
end;


const
	CabinetDll = 'cabinet.dll';

{$IFDEF CABINET_STATIC_LINK}

function FCICreate; external CabinetDll name 'FCICreate';
function FCIAddFile; external CabinetDll name 'FCIAddFile';
function FCIFlushCabinet; external CabinetDll name 'FCIFlushCabinet';
function FCIFlushFolder; external CabinetDll name 'FCIFlushFolder';
function FCIDestroy; external CabinetDll name 'FCIDestroy';
function FDICreate; external CabinetDll name 'FDICreate';
function FDIIsCabinet; external CabinetDll name 'FDIIsCabinet';
function FDICopy; external CabinetDll name 'FDICopy';
function FDIDestroy; external CabinetDll name 'FDIDestroy';

{$ELSE}

var
	hCabModule: HModule = 0;
	pFCICreate: TFNFCICreate = nil;
	pFCIAddFile: TFNFCIAddFile = nil;
	pFCIFlushCabinet: TFNFCIFlushCabinet = nil;
	pFCIFlushFolder: TFNFCIFlushFolder = nil;
	pFCIDestroy: TFNFCIDestroy = nil;
	pFDICreate: TFNFDICreate = nil;
	pFDIIsCabinet: TFNFDIIsCabinet = nil;
	pFDICopy: TFNFDICopy = nil;
	pFDIDestroy: TFNFDIDestroy = nil;

procedure InitCabinet;
begin
	hCabModule := LoadLibrary(CabinetDll);
	Win32Check(hCabModule <> 0);
	try
		@pFCICreate := GetProcAddress(hCabModule, 'FCICreate');
		Win32Check(@pFCICreate <> nil);
		@pFCIAddFile := GetProcAddress(hCabModule, 'FCIAddFile');
		Win32Check(@pFCIAddFile <> nil);
		@pFCIFlushCabinet := GetProcAddress(hCabModule, 'FCIFlushCabinet');
		Win32Check(@pFCIFlushCabinet <> nil);
		@pFCIFlushFolder := GetProcAddress(hCabModule, 'FCIFlushFolder');
		Win32Check(@pFCIFlushFolder <> nil);
		@pFCIDestroy := GetProcAddress(hCabModule, 'FCIDestroy');
		Win32Check(@pFCIDestroy <> nil);
		@pFDICreate := GetProcAddress(hCabModule, 'FDICreate');
		Win32Check(@pFDICreate <> nil);
		@pFDIIsCabinet := GetProcAddress(hCabModule, 'FDIIsCabinet');
		Win32Check(@pFDIIsCabinet <> nil);
		@pFDICopy := GetProcAddress(hCabModule, 'FDICopy');
		Win32Check(@pFDICopy <> nil);
		@pFDIDestroy := GetProcAddress(hCabModule, 'FDIDestroy');
		Win32Check(@pFDIDestroy <> nil);
	except
		FreeLibrary(hCabModule);
		hCabModule := 0;
		raise;
	end;
end;

function FCICreate(perf: PERF; pfnfcifp: PFNFCIFILEPLACED;
	pfna: PFNFCIALLOC; pfnf: PFNFCIFREE; pfnopen: PFNFCIOPEN;
	pfnread: PFNFCIREAD; pfnwrite: PFNFCIWRITE; pfnclose: PFNFCICLOSE;
	pfnseek: PFNFCISEEK; pfndelete: PFNFCIDELETE;
	pfnfcigtf: PFNFCIGETTEMPFILE; pccab: PCCAB; pv: PVoid): HFCI; cdecl;
begin
	if hCabModule = 0 then
		InitCabinet;
	Result := pFCICreate(perf, pfnfcifp, pfna, pfnf, pfnopen, pfnread, pfnwrite,
		pfnclose, pfnseek, pfndelete, pfnfcigtf, pccab, pv);
end;

function FCIAddFile(hfci: HFCI; pszSourceFile: PAnsiChar; pszFileName: PAnsiChar;
	fExecute: WIN_BOOL; pfnfcignc: PFNFCIGETNEXTCABINET; pfnfcis: PFNFCISTATUS;
	pfnfcigoi: PFNFCIGETOPENINFO; typeCompress: TCOMP): WIN_BOOL; cdecl;
begin
	Result := pFCIAddFile(hfci, pszSourceFile, pszFileName, fExecute,
		pfnfcignc, pfnfcis, pfnfcigoi, typeCompress);
end;

function FCIFlushCabinet(hfci: HFCI; fGetNextCab: WIN_BOOL;
	pfnfcignc: PFNFCIGETNEXTCABINET; pfnfcis: PFNFCISTATUS): WIN_BOOL; cdecl;
begin
	Result := pFCIFlushCabinet(hfci, fGetNextCab, pfnfcignc, pfnfcis);
end;

function FCIFlushFolder(hfci: HFCI; pfnfcignc: PFNFCIGETNEXTCABINET;
	pfnfcis: PFNFCISTATUS): WIN_BOOL; cdecl;
begin
	Result := pFCIFlushFolder(hfci, pfnfcignc, pfnfcis);
end;

function FCIDestroy(hfci: HFCI): WIN_BOOL; cdecl;
begin
	Result := pFCIDestroy(hfci);
end;

function FDICreate(pfnalloc: PFNALLOC; pfnfree: PFNFREE; pfnopen: PFNOPEN;
	pfnread: PFNREAD; pfnwrite: PFNWRITE; pfnclose: PFNCLOSE;
	pfnseek: PFNSEEK; cpuType: Integer; perf: PERF): HFDI; cdecl;
begin
	if hCabModule = 0 then
		InitCabinet;
	Result := pFDICreate(pfnalloc, pfnfree, pfnopen, pfnread, pfnwrite,
		pfnclose, pfnseek, cpuType, perf);
end;

function FDIIsCabinet(hfdi: HFDI; hf: Integer; pfdici: PFDICABINETINFO): WIN_BOOL; cdecl;
begin
	Result := pFDIIsCabinet(hfdi, hf, pfdici);
end;

function FDICopy(hfdi: HFDI; pszCabinet: PAnsiChar; pszCabPath: PAnsiChar;
	flags: Integer; pfnfdin: PFNFDINOTIFY; pfnfdid: PFNFDIDECRYPT;
	pvUser: PVoid): WIN_BOOL; cdecl;
begin
	Result := pFDICopy(hfdi, pszCabinet, pszCabPath, flags, pfnfdin,
		pfnfdid, pvUser);
end;

function FDIDestroy(hfdi: HFDI): WIN_BOOL; cdecl;
begin
	Result := pFDIDestroy(hfdi);
end;

initialization

finalization
	if hCabModule <> 0 then
		FreeLibrary(hCabModule);

{$ENDIF}

end.

