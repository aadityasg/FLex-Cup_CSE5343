

CSE 5343, Project 1: simpleC Scanner 

* Complete project description: http://web.cse.ohio-state.edu/~rountev/5343/pdf/project1.pdf
* ANSI C Specification to be followed: http://web.cse.ohio-state.edu/~rountev/5343/pdf/n1336.pdf
* Futher details on project: http://web.cse.ohio-state.edu/~rountev/5343/projects.html


* Steps (sample):
** set JFLEX_HOME env variable and modify the jflex launcher accordingly
** Commands:
```
jflex simpleC.flex
java -jar "C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" simpleC.cup
javac -cp ".;C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" *.java
java -cp ".;C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" Scanner .\TestCases\fft3.c
```

* Sample input file contents:
```
32 456Last chance
0x123
0x123L
0x123uL
```

* Sample Output:
```
C:\Data\Respositories\FLex-Cup_CSE5343\Project1>java -cp ".;C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" MyLexer .\TestCases\fft3.c
Lexing [.\TestCases\fft3.c]
TOKEN: line 1, column 1, sym: INTEGER_LITERAL, value: 32[java.lang.Integer]
TOKEN: line 1, column 4, sym: INTEGER_LITERAL, value: 456[java.lang.Long]
TOKEN: line 1, column 8, sym: IDENTIFIER, value: ast[java.lang.String]
TOKEN: line 1, column 12, sym: IDENTIFIER, value: chance[java.lang.String]
TOKEN: line 2, column 1, sym: INTEGER_LITERAL, value: 291[java.lang.Integer]
TOKEN: line 3, column 1, sym: INTEGER_LITERAL, value: 291[java.lang.Long]
TOKEN: line 4, column 1, sym: INTEGER_LITERAL, value: 291[java.lang.Long]
TOKEN: line 4, column 8, sym: EOF
No errors.
```
