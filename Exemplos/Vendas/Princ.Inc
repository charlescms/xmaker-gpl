{$DEFINE IBX}
{$DEFINE SENHA_DB}   // Controle de Acesso Interno
{$IFDEF VER130}      // Delphi 5.0
  {$DEFINE DELPHI5}
{$ENDIF}

{$IFDEF VER140}      // Delphi 6.0
  {$DEFINE DELPHI6}
{$ENDIF}

{$IFDEF VER150}      // Delphi 7.0
  {$DEFINE DELPHI7}
{$ENDIF}

{$IFDEF VER170}      // Delphi 2005
  {$DEFINE DELPHI9}
{$ENDIF}

{$IFDEF VER180}      // Delphi/Turbo 2006
  {$DEFINE DELPHI10}
{$ENDIF}
{00-Início do Bloco Avulso, as codificações abaixo serão preservadas}
