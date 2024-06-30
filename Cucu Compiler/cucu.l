%{
#include <stdio.h>
#include<stdlib.h>
#include <string.h>
#include<math.h>
#include "cucu.tab.h"
FILE *cuc;
%}
%%
"if"                    {fprintf (cuc,"IF : if\n"); return IF;}
"else"                  {fprintf (cuc,"ELSE : else\n"); return ELSE;}
"while"                 {fprintf (cuc,"WHILE : while\n"); return WHILE;}
"char *"                {fprintf (cuc,"Type : char*\n"); return CHAR;}
"int"                   {fprintf (cuc,"Type : int\n"); return INT;}
"return"                {fprintf (cuc, "RETURN : return\n"); return RETURN;}
[0-9]+                  {fprintf (cuc,"NUM : %d\n", yylval.num=atoi(yytext)); return NUM;}
(\"[a-zA-Z0-9]*\")      {fprintf (cuc, "Type : string"); yylval.str=strdup(yytext); return STRING;}
[a-zA-Z_][a-zA-Z0-9_]*  {fprintf (cuc,"ID : %s\n", yytext); yylval.str=strdup(yytext); return ID;}
"+"                     {fprintf (cuc,"PLUS : +\n"); return PLUS;}
"-"                     {fprintf (cuc,"MINUS : +\n"); return MINUS;}
"*"                     {fprintf (cuc,"MULTIPLICATION : *\n"); return MULTIPLICATION;}
"/"                     {fprintf (cuc,"DIVISION : /\n"); return DIVISION;}
"="                     {fprintf (cuc,"ASSIGN : =\n"); return ASSIGN;}
";"                     {fprintf (cuc,"SEMI : ;\n"); return SEMI_C;}
","                     {fprintf (cuc,"COMMA : ,\n"); return COMMA;}
">"                     {fprintf (cuc,"GREATER_THAN : >\n"); return GREATER_THAN;}
"<"                     {fprintf (cuc,"LESS_THAN : <\n"); return LESS_THAN;}
"=="                    {fprintf (cuc,"COMPARE_EQUAL : ==\n"); return EQUAL;}
"<="                    {fprintf (cuc,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL_TO;}
">="                    {fprintf (cuc,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL_TO;}
"!="                    {fprintf (cuc,"COMPARE_NOT_EQUAL : !=\n"); return COMPARE_NOT_EQUAL_TO;}
[\{]                    {fprintf (cuc,"LEFT_CURLY_BRACKET : {\n"); return LEFT_CURLY_BRACKET;}
[\}]                    {fprintf (cuc,"RIGHT_CURLY_BRACKET : }\n"); return RIGHT_CURLY_BRACKET;}
[\(]                    {fprintf (cuc,"LEFT_BRACKET : (\n"); return LEFT_BRACKET;}
[\)]                    {fprintf (cuc,"RIGHT_BRACKET : )\n"); return RIGHT_BRACKET;}
[\[]                    {fprintf (cuc,"LEFT_SQ_BRACKET : [\n"); return LEFT_SQ_BRACKET;}
[\]]                    {fprintf (cuc,"RIGHT_SQ_BRACKET : ]\n"); return RIGHT_SQ_BRACKET;}
\/\*(.|\n)*\*\/         ;
[ \t\n]+                ;
%%
int yywrap(){
    return 1;
}