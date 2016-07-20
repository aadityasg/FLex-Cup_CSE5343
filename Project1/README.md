

CSE 5343, Project 1: simpleC Scanner 

* Complete project description: http://web.cse.ohio-state.edu/~rountev/5343/pdf/project1.pdf
* ANSI C Specification to be followed: http://web.cse.ohio-state.edu/~rountev/5343/pdf/n1336.pdf
* Futher details on project: http://web.cse.ohio-state.edu/~rountev/5343/projects.html


Commands required:

* java JFlex.Main simpleC.flex
* java java_cup.Main -interface < simpleC.cup
* javac MyLexer.java
* java MyLexer 1d-jacobi.c
