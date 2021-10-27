import Analizadores.Flex.AnalizadorLexico;

import java.io.StringReader;
import Analizadores.Cup.parser;
public class Main {

    public static void main(String args[]){

    String mensaje= " <!--  ESCRIBIR 004040404 --> ESCRIBIR + LETRA FIN " +
            "ESCRIBIR * FJFJFJF3333 FIN";
    StringReader e = new StringReader(mensaje);
    AnalizadorLexico lex = new AnalizadorLexico(e);
    parser par = new parser(lex);
    try {
        par.parse();
    }catch (Exception h){

    }

    }
}



/*
*
* Comando Compilacion CUP: java -jar /home/jpmazate/Documentos/10moSemestre/Lenguajes/Herramientas/java-cup-bin-11b-20160615/java-cup-11b.jar sintactico.cup

 * */