%{
open Ast
%}

%token <int> INT
%token <string> ID
%token IN
%token LET
%token PLUS
%token MINUS
%token TIMES
%token DIVIDED
%token LPAREN
%token RPAREN
%token EQUALS
%token POW
%token EOF


%nonassoc IN EQUALS
%left PLUS MINUS
%left TIMES DIVIDED
%left POW
%start <Ast.expr> prog

%%

prog:
	| e = expr; EOF { e }
	;

expr:
    | i = INT { Int i }
    | x = ID { Var x }
    | e1 = expr; PLUS; e2 = expr { Add(e1,e2) }
    | e1 = expr; MINUS; e2 = expr { Sub(e1,e2) }
    | e1 = expr; TIMES; e2 = expr { Mul(e1,e2) }
    | e1 = expr; DIVIDED; e2 = expr { Div(e1,e2) }
    | e1 = expr; POW; e2 = expr { Pow(e1,e2) }
    | LET; x = ID; EQUALS; e1 = expr; IN; e2 = expr { Let(x,e1,e2) }
    | LPAREN; e = expr; RPAREN {e}
      (*    | MINUS e = expr %prec UMINUS { SubExp(IntExp 0,e) }*)
    | LPAREN; MINUS e = expr; RPAREN  { Sub(Int 0, e) }
    ;
