type name = string 

type value =
  | VInt  of int
  | VBool of bool 

type literal = 
  | LInt of int 
  | LBool of bool 

type binOp = 
  | OpAdd 

type expr =
  | ELiteral of literal 
  | EVar   of name 
  | EBin   of binOp * expr * expr 
  | ELet   of name * expr * expr 

let print_name : name -> unit = print_string 

let print_value : value -> unit = function 
  | VInt i -> print_int i 
  | VBool b -> print_string (string_of_bool b) 

let value_of_literal : literal -> value = function 
  | LInt i -> VInt i 
  | LBool b -> VBool b 

let print_literal : literal -> unit = fun lit -> print_value @@ value_of_literal lit 

let print_binOp : binOp -> unit = function 
  | OpAdd -> print_string "OpAdd" 

(*
 小さい式に対しては以下でも問題はないが，
 大きいサイズの式を見やすく表示したければ，Formatモジュール
   http://caml.inria.fr/pub/docs/manual-ocaml/libref/Format.html
 を活用すること
*)
let rec print_expr = function 
  | ELiteral v -> 
    print_literal v 
  | EVar x -> 
    print_name x
  | EBin (op,e1,e2) -> 
    (print_string "EBin (";
     print_binOp op ; 
     print_string ","; 
     print_expr e1;
     print_string ",";
     print_expr e2;
     print_string ")")
  | ELet (n,e1,e2) ->
    (print_string "ELet (";
     print_name   n;
     print_string ","; 
     print_expr   e1;
     print_string ",";
     print_expr   e2;
     print_string ")")
 