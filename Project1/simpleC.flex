import java_cup.runtime.*;
import java.math.*;

%%

%public
%class Scanner
%extends sym

%line
%column

%cup
%cupdebug

%{
  StringBuffer string = new StringBuffer();
  
  private Symbol symbol(int type) {
    return new MySymbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
    return new MySymbol(type, yyline+1, yycolumn+1, value);
  }
  
  private long parseLong(int start, int end, int radix) {
    long result = 0;
    long digit;

    for (int i = start; i < end; i++) {
      digit  = Character.digit(yycharat(i),radix);
      result*= radix;
      result+= digit;
    }

    return result;
  }
  
  private static BigDecimal hexExponentToBigDecimal(String text) {
	BigDecimal resultP1 = new BigDecimal(0);
	int decPointIndex = text.indexOf(".") == -1 ? text.length() : text.indexOf(".");
	int expIndex = text.indexOf("p") == -1 ? (text.indexOf("P") == -1 ? text.length() : text.indexOf("P")) : text.indexOf("p");
	
	for (int i = 0; i < decPointIndex; i++) {
      long digit  = Character.digit(text.charAt(i),16);
	  resultP1 = resultP1.multiply(BigDecimal.valueOf(16));
	  resultP1 = resultP1.add(BigDecimal.valueOf(digit));
    }
	
	if(decPointIndex != text.length()) {
		BigDecimal resultP2 = new BigDecimal(0);
		for (int i = decPointIndex + 1; i < expIndex; i++) {
		  long digit  = Character.digit(text.charAt(i),16);
		  long divisor = 1;
		  for(int index = decPointIndex; index < i; index++) {
			  divisor *= 16;
		  }
		  
		  BigDecimal temp = BigDecimal.valueOf(digit).divide(BigDecimal.valueOf(divisor), 10, RoundingMode.FLOOR);
		  resultP2 = resultP2.add(temp);
		}
		resultP1 = resultP1.add(resultP2);
	}
	
	if(expIndex != text.length()) {
		BigDecimal multiplier = new BigDecimal(1);
		for (int i = 0; i < getHexMultiplier(text); i++) {
			multiplier = multiplier.multiply(BigDecimal.valueOf(2));
		}
		resultP1 = resultP1.multiply(multiplier);
	}
	
	return resultP1;
  }
  
  private static Integer getHexMultiplier(String text) {
	int expIndex = text.indexOf("p") == -1 ? (text.indexOf("P") == -1 ? text.length() : text.indexOf("P")) : text.indexOf("p");
	if(expIndex != text.length()) {
		StringBuilder sb = new StringBuilder();
		for(int index = expIndex + 1; index < text.length(); index++)
			sb.append(text.charAt(index));
		return Integer.parseInt(sb.toString());
	}
	return 1;
  }
%}

/* Token building blocks */
NonZeroDigit = [1-9]
Digit = [0-9]
OctalDigit = [0-7]
HexDigit = [a-fA-F0-9]

NonDigit = [a-zA-Z_]
HexPrefix = 0[xX]
OctalPrefix = 0


/* White spaces */
WhiteSpace = [ \t\f\r\n]

/* Comments in C files: no need to worry about them: assume the C
 * preprocessor was already executed - it strips away comments 
 */

/* Identifiers: TODO - make them general, as described in Section
 * 6.4.2.1 in the ANSI C document. Ignore "universal-character-name"
 * and "other implementation-defined characters" mentioned in Section
 * 6.4.2.1.
 */

/* Replace this placeholder with your own definitions --> DONE*/ 
Identifier = ({NonDigit}+{Digit}*)+

/* Integer literals: TODO - handle integer literals as described in
 * Section 6.4.4.1 of the ANSI C document. For simplicity, do NOT
 * handle the 'long long' cases. But DO handle long, unsigned,
 * hexadecimal, and octal constants.
 */

/* Replace this placeholder with your own definitions --> DONE*/

DecConstant = {NonZeroDigit}+{Digit}*
OctConstant = {OctalPrefix}{OctalDigit}*
HexConstant = {HexPrefix}{HexDigit}+

/* Floating point literals: TODO - handle floating point literals as 
 * described in Section 6.4.4.2 of the ANSI C document. For
 * simplicity, do NOT handle the 'long double' cases. But DO handle
 * hexadecimal floating constants, e/E and p/P notation, and f/F
 * suffixes.
 */        

/* Replace this placeholder with your own definitions  --> DONE */

ExponentPart = [eE][+-]?{Digit}+
BinaryExponentPart = [pP][+-]?{Digit}+

FloatingSuffix = [fF]
LongFloatingSuffix = [lL]
DecFractionalConstant = (({Digit}+\.{Digit}*)|({Digit}*\.{Digit}+))
DecFloatingConstant = (({DecFractionalConstant}{ExponentPart}?)|({Digit}+{ExponentPart}))

HexFractionalConstant = (({HexDigit}+\.{HexDigit}*)|({HexDigit}*\.{HexDigit}+))
HexFloatingConstant = {HexPrefix}({HexFractionalConstant}|{HexDigit}+){BinaryExponentPart}

%%

<YYINITIAL> {

  /* Keywords: TODO - add all keywords from Section 6.4.1 --> DONE */

  "double"                       { return symbol(DOUBLE); }
  "for"                          { return symbol(FOR); }
  "int"                          { return symbol(INT); }
  "long"			 { return symbol(LONG); }
  "return"                       { return symbol(RETURN); }
  "void"                         { return symbol(VOID); }
  "auto"                         { return symbol(AUTO); }
  "enum"                         { return symbol(ENUM); }
  "restrict"                     { return symbol(RESTRICT); }
  "unsigned"                     { return symbol(UNSIGNED); }
  "break"                        { return symbol(BREAK); }
  "extern"                       { return symbol(EXTERN); }
  "case"                         { return symbol(CASE); }
  "float"                        { return symbol(FLOAT); }
  "short"                        { return symbol(SHORT); }
  "volatile"                     { return symbol(VOLATILE); }
  "char"                         { return symbol(CHAR); }
  "signed"                       { return symbol(SIGNED); }
  "while"                        { return symbol(WHILE); }
  "const"                        { return symbol(CONST); }
  "goto"                         { return symbol(GOTO); }
  "sizeof"                       { return symbol(SIZEOF); }
  "_Bool"                        { return symbol(_BOOL); }
  "continue"                     { return symbol(CONTINUE); }
  "if"                           { return symbol(IF); }
  "static"                       { return symbol(STATIC); }
  "_Complex"                     { return symbol(_COMPLEX); }
  "_Imaginary"                   { return symbol(_IMAGINARY); }
  "default"                      { return symbol(DEFAULT); }
  "inline"                       { return symbol(INLINE); }
  "struct"                       { return symbol(STRUCT); }
  "do"                           { return symbol(DO); }
  "switch"                       { return symbol(SWITCH); }
  "typedef"                      { return symbol(TYPEDEF); }
  "else"                         { return symbol(ELSE); }
  "register"                     { return symbol(REGISTER); }
  "union"                        { return symbol(UNION); }
  
  
  /* Punctuators: TODO - add all punctuators from Section 6.4.6 except
  for the last eight punctuators  --> DONE */

  "("                            { return symbol(LPAREN); }
  ")"                            { return symbol(RPAREN); }
  "{"                            { return symbol(LBRACE); }
  "}"                            { return symbol(RBRACE); }
  "["                            { return symbol(LBRACK); }
  "]"                            { return symbol(RBRACK); }
  ";"                            { return symbol(SEMICOLON); }
  ","                            { return symbol(COMMA); }
  "="                            { return symbol(ASSGN); }
  "<"                            { return symbol(LT); }
  ">"                            { return symbol(GT); }
  "++"                           { return symbol(PLUSPLUS); }
  "+"                            { return symbol(PLUS); }
  "-"                            { return symbol(MINUS); }
  "/"                            { return symbol(DIV); }
  "*"                            { return symbol(STAR); }
  
  "--"                           { return symbol(MINUSMINUS); }
  "."                            { return symbol(DOT); }
  "->"                           { return symbol(LINK); }
  "&"                            { return symbol(AND); }
  "~"                            { return symbol(TILDA); }
  "!"                            { return symbol(NOT); }
  "%"                            { return symbol(MOD); }
  "<<"                           { return symbol(LSHIFT); }
  ">>"                           { return symbol(RSHIFT); }
  "<="                           { return symbol(LE); }
  ">="                           { return symbol(GE); }
  "=="                           { return symbol(EQUALEQUAL); }
  "!="                           { return symbol(NOTEQUAL); }
  "&&"                           { return symbol(ANDAND); }
  "||"                           { return symbol(OROR); }
  "^"                            { return symbol(XOR); }
  "|"                            { return symbol(OR); }
  "?"                            { return symbol(TERNARY); }
  ":"                            { return symbol(COLON); }
  "..."                          { return symbol(VARARGS); }
  "*="                           { return symbol(STAREQUAL); }
  "/="                           { return symbol(DIVEQUAL); }
  "%="                           { return symbol(MODEQUAL); }
  "+="                           { return symbol(PLUSEQUAL); }
  "-="                           { return symbol(MINUSEQUAL); }
  "<<="                          { return symbol(LSHIFTEQUAL); }
  ">>="                          { return symbol(RSHIFTEQUAL); }
  "&="                           { return symbol(ANDEQUAL); }
  "^="                           { return symbol(XOREQUAL); }
  "|="                           { return symbol(OREQUAL); }

  
  /* Integer literals: TODO - for any such literal, the token type
   * should be INTEGER_LITERAL, as shown below. The attribute value
   * should be either a Java Integer object (for values that are not
   * 'long') or a Java Long object (for values that are 'long'). You
   * can assume that the value of the literal is always small enough
   * to fit in a Java Integer or Long, respectively. For example, if
   * the literal is "17", "0x11", or "021", you should create a Java
   * Integer object containing the Java 'int' value 17. 
   */


  /* replace this placeholder with your own definitions --> DONE */
  {DecConstant}             { return symbol(INTEGER_LITERAL, new Integer(yytext())); }
  {DecConstant}[uU]?        { return symbol(INTEGER_LITERAL, new Integer(yytext().substring(0,yylength()-1))); }
  {DecConstant}[lL]?        { return symbol(INTEGER_LITERAL, new Long(yytext().substring(0,yylength()-1))); }
  {DecConstant}([uU][lL])?  { return symbol(INTEGER_LITERAL, new Long(yytext().substring(0,yylength()-2))); }
  {DecConstant}([lL][uU])?  { return symbol(INTEGER_LITERAL, new Long(yytext().substring(0,yylength()-2))); }
    
  {OctConstant}             { return symbol(INTEGER_LITERAL, new Integer((int) parseLong(0, yylength(), 8))); }
  {OctConstant}[uU]?        { return symbol(INTEGER_LITERAL, new Integer((int) parseLong(0, yylength()-1, 8))); }
  {OctConstant}[lL]?        { return symbol(INTEGER_LITERAL, new Long(parseLong(0, yylength()-1, 8))); }
  {OctConstant}([uU][lL])?  { return symbol(INTEGER_LITERAL, new Long(parseLong(0, yylength()-2, 8))); }
  {OctConstant}([lL][uU])?  { return symbol(INTEGER_LITERAL, new Long(parseLong(0, yylength()-2, 8))); }
  
  {HexConstant}             { return symbol(INTEGER_LITERAL, new Integer((int) parseLong(2, yylength(), 16))); }
  {HexConstant}[uU]?        { return symbol(INTEGER_LITERAL, new Integer((int) parseLong(2, yylength()-1, 16))); }
  {HexConstant}[lL]?        { return symbol(INTEGER_LITERAL, new Long(parseLong(2, yylength()-1, 16))); }
  {HexConstant}([uU][lL])?  { return symbol(INTEGER_LITERAL, new Long(parseLong(2, yylength()-2, 16))); }
  {HexConstant}([lL][uU])?  { return symbol(INTEGER_LITERAL, new Long(parseLong(2, yylength()-2, 16))); }
  
 
  
  /* Floating-point literals: TODO - for any such literal, the token
   * type should be FLOATING_POINT_LITERAL, as shown below. The
   * attribute value should be either a Java Float object (for values
   * that are 'float') or a Java Double object (for values that are
   * 'double'). You can assume that the value of the literal is always
   * small enough to fit in a Java Float or Double, respectively. For
   * example, if the literal is ".5625f", "5625e-4f", or "0X1.2p-1f",
   * you should create a Java Float object containing the Java 'float'
   * value 0.5625.
   */

  /* replace this placeholder with your own definitions */
  
  {DecFloatingConstant}                           { return symbol(FLOATING_POINT_LITERAL, new Double(Double.parseDouble(yytext()))); }
  {DecFloatingConstant}{FloatingSuffix}           { return symbol(FLOATING_POINT_LITERAL, new Float(Double.parseDouble(yytext().substring(0,yylength()-1)))); }
  /* TODO -> CHANGE THIS LATER TO BE EQUIVALENT TO LONG DOUBLE*/
  {DecFloatingConstant}{LongFloatingSuffix}       { return symbol(FLOATING_POINT_LITERAL, new BigDecimal(yytext().substring(0,yylength()-1))); }
  
  
  /* TODO -> HEXADECIMAL FRACTIONAL EXPONENT HANDLING*/
  
  {HexFloatingConstant}                           						{ return symbol(FLOATING_POINT_LITERAL, hexExponentToBigDecimal(yytext().substring(2,yylength()))); }
  {HexFloatingConstant}({FloatingSuffix}|{LongFloatingSuffix})          { return symbol(FLOATING_POINT_LITERAL, hexExponentToBigDecimal(yytext().substring(2,yylength()-1))); }
  
  
  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }

  /* identifiers */ 
  {Identifier}                   { return symbol(IDENTIFIER, yytext()); }  
}

/* error fallback */
.|\n                             { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+(yyline+1)+", column "+(yycolumn+1)); }
<<EOF>>                          { return symbol(EOF); }
