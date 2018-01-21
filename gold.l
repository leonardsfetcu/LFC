%{
	#include "gold.tab.h"

	int lineNo = 1;
%}

%%
"program"               { return TOK_PROG;}
"if"		            { return TOK_IF;}
"then"                  { return TOK_THEN;}
"else"		            { return TOK_ELSE;}
"int"                   { return TOK_INT;}
"float"                 { return TOK_FLOAT;}
"boolean"               { return TOK_BOOL;}
"print"                 { return TOK_PRINT;}
"true"|"false"          { (strcmp(yytext,"true")==0)?yylval.u.boolVal=true:yylval.u.boolVal=false; yylval.type=Number::BOOL; return TOK_BOOL_VALUE;}
"repeat"                { return TOK_REPEAT;}
"until"                 { return TOK_UNTIL;}
"begin"                 { return TOK_BEGIN;}
"end"                   { return TOK_END;}
"<"		                { return TOK_LOWER;}
"<="		            { return TOK_LOWER_EQUAL;}
">"                     { return TOK_GREATER;}
">="                    { return TOK_GREATER_EQUAL;}
"=="                    { return TOK_EQUALEQUAL;}
"!="					{ return TOK_UNEQUAL;}
"+"		                { return TOK_PLUS; }
"-"		                { return TOK_MINUS; }
"*"		                { return TOK_MULTIPLY; }
"/"		                { return TOK_DIVIDE; }
"("		                { return TOK_OPEN; }
")"		                { return TOK_CLOSE; }
";"		                { return ';'; }
"="		                { return TOK_EQUAL; }
[0-9]+"."[0-9]+    		{ yylloc.first_line = lineNo; yylval.u.floatVal=atof(yytext); yylval.type=Number::FLOAT; return TOK_NUMBER_FLOAT;}
0|[1-9][0-9]*	        { yylloc.first_line = lineNo; yylval.u.intVal = atoi(yytext); yylval.type=Number::INTEGER; return TOK_NUMBER_INT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylloc.first_line=lineNo; yylval.u.string = new char[strlen(yytext)+1]; strcpy(yylval.u.string,yytext); yylval.type=Number::STRING; return TOK_ID;}
[ ]		                { }
\"(.+)\"				{ yylloc.first_line = lineNo; yylval.u.string = new char[strlen(yytext)+1]; strcpy(yylval.u.string,yytext); yylval.type=Number::STRING; return TOK_STRING;}
\n		                { lineNo++; }
%%
