{
  open Parser

  exception Error of string
}

let digit = ['0'-'9']
let nbsp = ' ' | '\t' 
let break = "\r\n" | '\r' | '\n'
let alpha = ['a'-'z' 'A'-'Z' '_' ] 
let ident = alpha (alpha | digit)* 

rule token = parse
| nbsp+       { token lexbuf }
| break       { Lexing.new_line lexbuf; token lexbuf } 
| "let"       { LET }
| "in"        { IN  }
| "true"      { TRUE } 
| "false"     { FALSE }
| "="         { EQ }
| '+'         { PLUS }
| '('         { LPAR }
| ')'         { RPAR }
| digit+ as n { INT (int_of_string n) }
| ident  as n { ID n }
| eof         { EOF  }
| _           { raise (Error ("Unknown Token: " ^ Lexing.lexeme lexbuf))}
