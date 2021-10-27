
/* codigo de usuario */
package Analizadores;

import java_cup.runtime.*;
import static jflex_cup.sym.*;
import java.util.Date;


%% //separador de area


 /* opciones y declaraciones de jflex */

 /* opciones y declaraciones de jflex */

%class AnalizadorLexico
%public
%cup
%cupdebug
%line
%column

%state COMENTARIO_BLOQUE

 /* declaracion de regex para los tokens */ 
WhiteSpace = [\r|\n|\r\n] | [ \t\f]
LETRA = [a-zA-Z]
NUMERO = [0-9]
SIGNO_MENOS = "-"
SIGNO_MAS = "+"
SIGNO_POR = "*"
SIGNO_DIVISION = "/"


INICIO_COMENTARIO_BLOQUE = "<!--"
FIN_COMENTARIO_BLOQUE = "-->"

ESCRIBIR = "ESCRIBIR"
FIN = "FIN"

IDD = ({LETRA})({LETRA}|{NUMERO})*


  /* se puede poner el comodin %{   %} para poner codigo java*/
%{
  StringBuilder string = new StringBuilder();
  
  private Symbol symbol(int type) {
    return new Symbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline+1, yycolumn+1, value);
  }


  private void error(String message) {
    System.out.println("Error en linea: "+(yyline+1)+", columna "+(yycolumn+1)+" : "+message);
  }
%}


%% /* separador de areas*/

/* reglas lexicas */
<YYINITIAL> {
{WhiteSpace} 	{/* ignoramos */}
{INICIO_COMENTARIO_BLOQUE} {yybegin(COMENTARIO_BLOQUE);} 
{ESCRIBIR} {return symbol(sym.ESCRIBIR,yytext());}
{FIN} {return symbol(sym.FIN,yytext());}

{SIGNO_MENOS} {return symbol(sym.SIGNO_MENOS,yytext());}
{SIGNO_POR} {return symbol(sym.SIGNO_POR,yytext());}
{SIGNO_DIVISION} {return symbol(sym.SIGNO_DIVISION,yytext());}
{SIGNO_MAS} {return symbol(sym.SIGNO_MAS,yytext());}

{IDD} {return symbol(sym.IDD,yytext());}
}

	/* estado de comentario bloque*/
<COMENTARIO_BLOQUE>{
{FIN_COMENTARIO_BLOQUE} {yybegin(YYINITIAL);}
[^] {;}
}

/* error fallback */
[^]                              {error("Simbolo invalido <"+ yytext()+">");}
<<EOF>>                 { return symbol(sym.EOF); }
