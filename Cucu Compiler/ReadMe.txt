There are 7 files: cucu.l, cucu.y, Sample1.cu, Sample2.cu, and README.txt,Lexer.txt,Parser.txt.

Instructions to run the program:
    A. Open the terminal in the directory 2022CSB1121:
        1. flex cucu.l
        2. bison -d cucu.y
        3. g++ cucu.tab.c lex.yy.c -o cucu
        4. ./cucu
        (Run the comand in same order even it is showing WARNING keep on giving command in this sequence,it will give correct output.)

cucu.l

    A. Tokenizes variable names, keywords, special characters, and numbers.
    B. Outputs the tokens to the Lexer.txt file.

cucu.y

    A. Contains BNF grammar rules for the compiler.
    B. Outputs parsing information to the Parser.txt file.
    C. Prints "Syntax Error" in the terminal if there's a syntax error.

Sample1.cu

    A. Contains code with correct syntax.
    B. You can add correct syntax code here for parsing.

Sample2.cu

    A. Contains code with incorrect syntax.
    B. You can add incorrect syntax code here to test parsing and error handling.