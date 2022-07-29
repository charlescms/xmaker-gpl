object BaseDados: TBaseDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 198
  Top = 168
  Height = 294
  Width = 551
  object BD_Base_Projeto: TIBDatabase
    DefaultTransaction = TRS_BD_Base_Projeto
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 24
    Top = 2
  end
  object TRS_BD_Base_Projeto: TIBTransaction
    Active = False
    DefaultDatabase = BD_Base_Projeto
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 96
    Top = 2
  end
  object BD_Base_Dicionario: TIBDatabase
    DefaultTransaction = TRS_BD_Base_Dicionario
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 168
    Top = 2
  end
  object TRS_BD_Base_Dicionario: TIBTransaction
    Active = False
    DefaultDatabase = BD_Base_Dicionario
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 240
    Top = 2
  end
  object SynPasSyn1: TSynPasSyn
    AsmAttri.Foreground = clBlack
    CommentAttri.Foreground = clBlue
    DirectiveAttri.Foreground = clMaroon
    DirectiveAttri.Style = [fsBold]
    IdentifierAttri.Foreground = clBlack
    KeyAttri.Foreground = clBlack
    NumberAttri.Foreground = clBlack
    FloatAttri.Foreground = clBlack
    HexAttri.Foreground = clBlack
    StringAttri.Foreground = clBlue
    CharAttri.Foreground = clBlack
    SymbolAttri.Foreground = clBlack
    Left = 104
    Top = 57
  end
  object SynDfmSyn1: TSynDfmSyn
    DefaultFilter = 'Borland Form Files (*.dfm;*.xfm)|*.dfm;*.xfm'
    Left = 144
    Top = 57
  end
  object SynCppSyn1: TSynCppSyn
    DefaultFilter = 'C++ Files (*.c,*.cpp,*.h,*.hpp)|*.c;*.cpp;*.h;*.hpp'
    CommentAttri.Foreground = clBlue
    DirecAttri.Foreground = clMaroon
    DirecAttri.Style = [fsBold]
    Left = 176
    Top = 57
  end
  object SynCACSyn1: TSynCACSyn
    DefaultFilter = 'CA-Clipper Files (*.prg,*.ch,*.inc)|*.prg;*.ch;*.inc'
    CommentAttri.Foreground = clBlue
    DirecAttri.Foreground = clMaroon
    DirecAttri.Style = [fsBold]
    Left = 208
    Top = 57
  end
  object SynSQLSyn1: TSynSQLSyn
    DefaultFilter = 'SQL Files (*.sql)|*.sql'
    CommentAttri.Foreground = clBlue
    SQLDialect = sqlSybase
    Left = 240
    Top = 57
  end
  object SynVBScriptSyn1: TSynVBScriptSyn
    DefaultFilter = 'VBScript Files (*.vbs)|*.vbs'
    Left = 272
    Top = 57
  end
  object SynCssSyn1: TSynCssSyn
    DefaultFilter = 'Cascading Stylesheets (*.css)|*.css'
    Left = 304
    Top = 57
  end
  object SynExporterHTML1: TSynExporterHTML
    Color = clWindow
    DefaultFilter = 'HTML Document (*.htm,*.html)|*.htm;*.html'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    HTMLFontSize = fs03
    Title = 'Untitled'
    UseBackground = False
    Left = 8
    Top = 104
  end
  object SynExporterRTF1: TSynExporterRTF
    Color = clWindow
    DefaultFilter = 'Rich Text Format (*.rtf)|*.rtf'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Title = 'Untitled'
    UseBackground = False
    Left = 40
    Top = 104
  end
  object SynBatSyn1: TSynBatSyn
    DefaultFilter = 'MS-DOS Batch Files (*.bat;*.cmd)|*.bat;*.cmd'
    Left = 72
    Top = 104
  end
  object SynVBSyn1: TSynVBSyn
    DefaultFilter = 'Visual Basic Files (*.bas)|*.bas'
    StringAttri.Foreground = clBlue
    Left = 104
    Top = 104
  end
  object SynIniSyn1: TSynIniSyn
    DefaultFilter = 'INI Files (*.ini)|*.ini'
    Left = 136
    Top = 104
  end
  object SynJavaSyn1: TSynJavaSyn
    DefaultFilter = 'Java Files (*.java)|*.java'
    Left = 168
    Top = 104
  end
  object SynPHPSyn1: TSynPHPSyn
    DefaultFilter = 
      'PHP Files (*.php,*.php3,*.phtml,*.inc)|*.php;*.php3;*.phtml;*.in' +
      'c'
    Left = 208
    Top = 104
  end
  object SynJScriptSyn1: TSynJScriptSyn
    DefaultFilter = 'Javascript Files (*.js)|*.js'
    Left = 240
    Top = 104
  end
  object SynXMLSyn1: TSynXMLSyn
    DefaultFilter = 
      'XML Document (*.xml,*.xsd,*.xsl,*.xslt,*.dtd)|*.xml;*.xsd;*.xsl;' +
      '*.xslt;*.dtd'
    WantBracesParsed = False
    Left = 280
    Top = 104
  end
  object SynHTMLSyn1: TSynHTMLSyn
    DefaultFilter = 'HTML/JSP Document (*.htm,*.html,*.jsp)|*.htm;*.html;*.jsp'
    ASPAttri.Background = clNavy
    ASPAttri.Foreground = clWhite
    ASPAttri.Style = [fsBold]
    Left = 8
    Top = 56
  end
  object SynInnoSyn1: TSynInnoSyn
    DefaultFilter = 'Inno Setup Script files (*.iss)|*.iss'
    ConstantAttri.Foreground = clNone
    ConstantAttri.Style = []
    CommentAttri.Foreground = clGreen
    CommentAttri.Style = []
    KeyAttri.Foreground = clBlue
    KeyAttri.Style = []
    NumberAttri.Foreground = clNone
    ParameterAttri.Foreground = clNone
    ParameterAttri.Style = []
    SectionAttri.Foreground = clNone
    StringAttri.Foreground = clNone
    Left = 40
    Top = 57
  end
  object SynFoxproSyn1: TSynFoxproSyn
    DefaultFilter = 'Foxpro Files (*.prg)|*.prg'
    Left = 72
    Top = 57
  end
end
