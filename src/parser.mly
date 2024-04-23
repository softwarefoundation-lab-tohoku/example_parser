%{
  open Syntax
  (* ここに書いたものは，Parser.mliに入らないので注意 *)
%}

%token <int>    INT
%token <string> ID 
%token TRUE FALSE
%token LET IN EQ
%token PLUS 
%token LPAR RPAR 
%token EOF 

%start main 
%type <Syntax.expr> main
%% 

main: 
expr EOF {$1}
;

expr:
  | LET var EQ expr IN expr   { ELet($2,$4,$6) }
  | arith_expr                { $1 } 
;

arith_expr:
  | arith_expr PLUS factor_expr { EBin(OpAdd,$1,$3) }
  | factor_expr                 { $1 }
;

factor_expr: 
  | atomic_expr                 { $1 }
;

atomic_expr:
  | literal        { ELiteral $1 }
  | ID             { EVar   $1 }
  | LPAR expr RPAR { $2 }
;

literal: 
  | INT   { LInt $1 } 
  | TRUE  { LBool true } 
  | FALSE { LBool false } 
;

var:
  | ID  { $1 } 
;
