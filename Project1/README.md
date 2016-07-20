

CSE 5343, Project 1: simpleC Scanner 

You need to build a scanner for a subset of C, using JFlex. An initial version is available on the course web page under “Projects”. You need to extend this scanner to add all functionality described in TODO comments in simpleC.flex. You should test your implementation by performing lexical analysis on two simple C programs (fft1.c and fft2.c), also available on the course web page). 
Before the deadline, you need to submit new versions of simpleC.flex and simpleC.cup. The project is due by January 26 (Monday), 11:59 pm. 
Some Details • Do your work on stdlinux. Before starting, check “Resources” on the course web page for one-time setup instructions.  • Do not change MyLexer.java (the driver program) or MySymbol.java (a helper class, extension of Symbol). The output from MyLexer will be used for grading.   • The input will always be ASCII – you do not need to worry about Unicode characters (that is, you can ignore universal-character-name defined in Section 6.4.3 of the ANSI C document). • Read simpleC.flex very carefully: there are many important details in this file. • You do not need to handle the following eight punctuators:   #     ##     <:     :>     <%     %>     %:     %:%: • One simplification to make life easier: consider the following input 32 456Last chance. The implementation should generate the following sequence of tokens: INTEGER_LITERAL with int value 32, INTEGER_LITERAL with long value 456, IDENTIFIER with value 'ast', IDENTIFIER with value 'chance', EOF.  Of course, this is not what a real-world C language implementation would do, but for this assignment it makes the scanner a little simpler.     
Project Submission On or before 11:59 pm on the due date, you should submit two files: simpleC.flex and simpleC.cup. On stdlinux do ”cd dir” where dir is the directory containing your files. Submit your project using submit c5343aa lab1 simpleC.flex simpleC.cup If the timestamp on your electronic submission is 12:00 am on the next day or later, you will receive 10% reduction per day, for up to three days. If your submission is later than 3 days after the deadline, it will not be accepted and you will receive zero points for this project. If you resubmit your project, this will override any previous submissions and only the latest submission will be considered – resubmit at your own risk. 

* Complete project description: http://web.cse.ohio-state.edu/~rountev/5343/pdf/project1.pdf
* ANSI C Specification to be followed: http://web.cse.ohio-state.edu/~rountev/5343/pdf/n1336.pdf
* Futher details on project: http://web.cse.ohio-state.edu/~rountev/5343/projects.html


Commands required:

* java JFlex.Main simpleC.flex
* java java_cup.Main -interface < simpleC.cup
* javac MyLexer.java
* java MyLexer 1d-jacobi.c
