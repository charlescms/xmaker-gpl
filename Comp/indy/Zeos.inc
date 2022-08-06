// Compilation directives for Delphi4
{$IFDEF VER120}
{$DEFINE VER125BELOW}
{$DEFINE VER130BELOW}
{$DEFINE VER130KBELOW}
{$DEFINE VER140BELOW}
{$ENDIF}

// Compilation directives for C++ Builder 4
{$IFDEF VER125}
{$DEFINE VER125BELOW}
{$DEFINE VER130BELOW}
{$DEFINE VER130KBELOW}
{$ENDIF}

// Compilation directives for Delphi 5
{$IFDEF VER130}
{$DEFINE VER130BELOW}
{$DEFINE VER130KBELOW
{$DEFINE VER140BELOW}
{$ENDIF}

{$IFDEF VER140}
{$DEFINE VER140BELOW}
{$ENDIF}

// Compilation directives for Kylix 1
{$IFDEF LINUX}
{$DEFINE VER130KBELOW}
{$ENDIF}

// Debug/release compiler options
{$D+}

{$IFOPT D-}
{$DEFINE BINARY_RELEASE}
{$ENDIF}

{$IFDEF BINARY_RELEASE}

// Settings for Release mode
{$C-}
{$I-}
{$R-}
{$L-}
{$O+}
{$Q-}
{$W-}

{$ELSE}

// Settings for Debug mode
{$C+}
{$I+}
{$R+}
{$L+}
{$O-}
{$Q+}
{$W+}

{$ENDIF}

// Prevents loading default libmysql.dll and libpq.dll
{$DEFINE STRICT_DLL_LOADING}

//Allows to see SQL exceptions as strings 
{$DEFINE INTERBASE_EXTENDED_MESSAGES}

//Load libcrypt.so before loading Firebird client library.
//It allow solve error "Undefined symbol: crypt".
{$DEFINE INTERBASE_CRYPT}

// Supresses output messages in unit tests
{$DEFINE SUPPRESS_TEST_OUTPUT}

// Supresses memory leaks test
{$DEFINE SUPPRESS_MEMORY_TEST}

// Excludes old ZeosDBO from the performance tests
{$DEFINE EXCLUDE_OLD_ZEOS_TEST}

// Excludes DBExpress from the performance tests
{$DEFINE EXCLUDE_DBX_TEST}

// Excludes IBX from the performance tests
{$DEFINE EXCLUDE_IBX_TEST}

// Excludes BDE from the performance tests
{$DEFINE EXCLUDE_BDE_TEST}

// Registers property editors for the components.
{$DEFINE WITH_PROPERTY_EDITOR}

// Disables checking code.
// Use Range checking option to turn on/off optimization
{$IFOPT R-}
{$DEFINE DISABLE_CHECKING}
{$ENDIF}

// Supported language. Now available languages:
// ENGLISH, RUSSIAN, GERMAN, PORTUGUESE, FRENCH,
// POLISH, CZECH, ITALIAN, SPANISH, HUNGARY 
{$DEFINE ENGLISH}
