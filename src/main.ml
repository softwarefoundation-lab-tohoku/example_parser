open Syntax

let string_of_position : Lexing.position -> string = fun pos -> 
  Printf.sprintf "[%s] L: %d, C: %d\n" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let () = 
  let lexbuf = Lexing.from_channel stdin in 
  let _ = Lexing.set_filename lexbuf "<interactive>" in 
  try 
    (* let () = print_string "> " in 
    let () = flush stdout in  *)
    let result = Parser.main Lexer.token lexbuf in
    print_expr result; print_newline ()
  with 
    | Lexer.Error msg  -> 
      Printf.printf "Lexing Error at %s" (string_of_position @@ Lexing.lexeme_start_p lexbuf); 
      print_endline msg 

    | Parsing.Parse_error (* ocamlyacc *) | Parser.Error (* menhir *) -> 
      Printf.printf "Parse Error at %s" (string_of_position @@ Lexing.lexeme_start_p lexbuf); 
      Printf.printf "around `%s'\n" (Lexing.lexeme lexbuf) 