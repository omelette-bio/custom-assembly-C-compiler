%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;

int yylex();
int yyerror();
%}

%union 
{
  char* code;
}

%token VARNAME CONSTANT MAINFUNC INT_T LOOP_STMT INCR

%start program

%%
primary_expression
  : VARNAME
  | CONSTANT

condition
  : primary_expression '<' primary_expression

value
  : primary_expression '+' primary_expression
  | primary_expression
  | VARNAME INCR

expression
  : INT_T VARNAME
  | VARNAME '=' value
  | VARNAME INCR
  | LOOP_STMT '(' expression ';' condition ';' expression ')' expression

expression_list
  : expression ';'
  | expression ';' expression_list

program
  : MAINFUNC expression_list '}'
%%

int yyerror (char *s) {
  fprintf( stderr, "%s. a la ligne %d\n", s, yylineno);
  exit(1);
}

int main( int argc, char** argv ) {
  yyparse();
  return 0;
}
