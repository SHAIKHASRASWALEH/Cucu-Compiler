%{
#include <stdio.h>
#include<stdlib.h>
#include <string.h>
#include<math.h>
int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout,*cuc;
%}
%token INT CHAR 
%union{
    int num;
    char *str;
}
%token LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET LEFT_BRACKET RIGHT_BRACKET LEFT_SQ_BRACKET RIGHT_SQ_BRACKET GREATER_THAN LESS_THAN EQUAL LESS_THAN_EQUAL_TO GREATER_THAN_EQUAL_TO COMPARE_NOT_EQUAL_TO
%token WHILE IF ELSE RETURN
%token COMMA SEMI_C
%token ASSIGN PLUS MINUS DIVISION MULTIPLICATION 
%token <str> STRING
%token <str> ID
%token <num> NUM
%left MULTIPLICATION DIVISION
%left PLUS MINUS
%left LEFT_BRACKET RIGHT_BRACKET
%%
Code_begin : Program
;
Program : var_func              {fprintf(yyout,"\n");}
      | Declaring             {fprintf(yyout,"\n");}
      | Program Declaring       {fprintf(yyout,"\n");}
      | Program body        {fprintf(yyout,"\n");}
      | Program var_func        {fprintf(yyout,"\n");}
      | body              {fprintf(yyout,"\n");}
;
var_func : int idf SEMI_C  
         | char idf SEMI_C               
         | char idf ASSIGN string SEMI_C     {fprintf(yyout,"Assignment : =\n");}
         | int idf ASSIGN expressions SEMI_C        {fprintf(yyout,"Assignment : =\n");}
         | int idf LEFT_SQ_BRACKET expressions RIGHT_SQ_BRACKET R SEMI_C
;
R: ASSIGN expressions 
|
;
Declaring : int idf LEFT_BRACKET RIGHT_BRACKET SEMI_C                           {fprintf(yyout,"Declaration of the function above\n\n");}
          |  int idf LEFT_BRACKET Arguments RIGHT_BRACKET SEMI_C           {fprintf(yyout,"Declaration of the function above\n\n");}
          | char idf LEFT_BRACKET RIGHT_BRACKET SEMI_C                          {fprintf(yyout,"Declaration of the function above\n\n");}
          | char idf LEFT_BRACKET Arguments RIGHT_BRACKET SEMI_C                {fprintf(yyout,"Declaration of the function above\n\n");}
;
body : int idf LEFT_BRACKET Arguments RIGHT_BRACKET Function_Body       {fprintf(yyout,"Declaration of the function above\n\n");}
         | int idf LEFT_BRACKET RIGHT_BRACKET Function_Body                      {fprintf(yyout,"Declaration of the function above\n\n");}
         | char idf LEFT_BRACKET RIGHT_BRACKET Function_Body                     {fprintf(yyout,"Declaration of the function above\n\n");}
         | char idf LEFT_BRACKET Arguments RIGHT_BRACKET Function_Body           {fprintf(yyout,"Declaration of the function above\n\n");}
;
Arguments : int idf                   {fprintf(yyout,"Function Arguments above\n\n");}
          | char idf                        {fprintf(yyout,"Function Arguments above\n\n");}
          | int idf COMMA Arguments
          | char idf COMMA Arguments
;

char : CHAR     {fprintf(yyout,"Datatype : char *\n");}
;
int : INT       {fprintf(yyout,"Datatype : int\n");}
;
Function_Body : LEFT_CURLY_BRACKET statement RIGHT_CURLY_BRACKET
          | stmt
;
statement : statement stmt
          | stmt
;
stmt : assignment_stmt
     | function_call SEMI_C            {fprintf(yyout,"body call ends \n\n");}
     | condition             {fprintf(yyout,"If Condition Ends \n\n");}
     | return_stmt           {fprintf(yyout,"Return statement \n\n");}
     | loop                  {fprintf(yyout,"While Loop Ends \n\n");}
     | var_func
;
condition : IF LEFT_BRACKET bool RIGHT_BRACKET Function_Body
          | IF LEFT_BRACKET bool RIGHT_BRACKET Function_Body ELSE Function_Body
;
return_stmt : RETURN SEMI_C
            | RETURN expressions SEMI_C
;
assignment_stmt : expressions ASSIGN expressions SEMI_C
;
loop : WHILE LEFT_BRACKET bool RIGHT_BRACKET Function_Body
;
function_call : idf expressions
              
;
bool : bool LESS_THAN bool              {fprintf(yyout,"Operator : < \n");}
     | bool GREATER_THAN bool            {fprintf(yyout,"Operator : > \n");}
     | bool LESS_THAN_EQUAL_TO bool         {fprintf(yyout,"Operator : <= \n");}
     | bool GREATER_THAN_EQUAL_TO bool      {fprintf(yyout,"Operator : >= \n");}
     | bool COMPARE_NOT_EQUAL_TO bool       {fprintf(yyout,"Operator : != \n");}
     | bool EQUAL bool           {fprintf(yyout,"Operator : == \n");}
     | bool LEFT_SQ_BRACKET express RIGHT_SQ_BRACKET R
     | expressions
;
express: idf
|int
;
expressions : LEFT_BRACKET expressions RIGHT_BRACKET  {fprintf(yyout,"hi : + \n");}
     | expressions PLUS expressions           {fprintf(yyout,"Operator : + \n");}
     | expressions MINUS expressions        {fprintf(yyout,"Operator : - \n");}
     | expressions fact
     | expressions COMMA expressions
     | expressions ASSIGN expressions
     | expressions EQUAL expressions
     | express LEFT_SQ_BRACKET expressed RIGHT_SQ_BRACKET
     | number              
     | idf 
     | string 
     |
;
expressed: NUM
| idf
;
fact: | fact MULTIPLICATION T            {fprintf(yyout,"Operator : * \n");}
     | fact DIVISION T         {fprintf(yyout,"Operator : / \n");}
;
T: | number              
     | idf 
     | string 
idf : ID      {fprintf(yyout,"Varibale : %s \n", $1);}
;
string : STRING {fprintf(yyout,"Value : %s \n", $1);}
;
number : NUM    {fprintf(yyout,"Value : %d \n", $1);}
;
%%

int main()
{
    //For running Sample2.cu change Sample1.cu to Sample2.cu
    yyin=fopen("Sample1.cu","r");
    yyout=fopen("Parser.txt","w");
    cuc=fopen("Lexer.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s){
    printf("Syntax Error\n");
}