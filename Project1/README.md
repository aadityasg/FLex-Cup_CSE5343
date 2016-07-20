

CSE 5343, Project 1: simpleC Scanner 

* Complete project description: http://web.cse.ohio-state.edu/~rountev/5343/pdf/project1.pdf
* ANSI C Specification to be followed: http://web.cse.ohio-state.edu/~rountev/5343/pdf/n1336.pdf
* Futher details on project: http://web.cse.ohio-state.edu/~rountev/5343/projects.html


Steps (sample):
* set JFLEX_HOME env variable and modify the jflex launcher accordingly
* jflex simpleC.flex
* java -jar "C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" simpleC.cup
* javac -cp ".;C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" *.java
* java -cp ".;C:\Program Files\Jflex\jflex-1.6.1\lib\java-cup-11a.jar" Scanner .\TestCases\fft3.c
