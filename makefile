build:
	bison -d parser.y -o y.tab.c
	flex ANSI-C.l 
	gcc y.tab.c lex.yy.c -o comp

clean:
	rm y.tab.*
	rm lex.yy.c 
