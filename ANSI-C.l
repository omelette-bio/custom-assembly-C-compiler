D [0-9]
L [a-zA-Z]

%{
  #include "y.tab.h"
  #include <stdio.h>
  #include <stdlib.h>

  extern int yylineno;
%}

%option noyywrap
%option yylineno

%%
"void main() {" return MAINFUNC;
"int" return INT_T;
"for" return LOOP_STMT;

"++" return INCR;

"{" return '{';
"}" return '}';
"(" return '(';
")" return ')';
";" return ';';
"=" return '=';
"<" return '<';
"+" return '+';
{L}({L}|{D})* return VARNAME;
{D}+ return CONSTANT;
[ \t\v\n\f] ;
. { fprintf(stderr, "erreur de symbole\n"); exit(1); }
%%
