
{
open Parser

exception Error of string

}

let white = [' ' '\t' '\n']+
let digit = ['0'-'9']
let int = digit+
let letter = ['a'-'z' 'A'-'Z']
let id = letter ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule read =
  parse
  | white    { read lexbuf }
  | "in"     { IN }
  | "="      { EQUALS }
  | "let"    { LET }
  | "+"      { PLUS }
  | "-"      { MINUS }
  | "*"      { TIMES }
  | "/"      { DIVIDED }
  | "("      { LPAREN }
  | ")"      { RPAREN }
  | "^"      { POW }
  | id       { ID (Lexing.lexeme lexbuf) }
  | int      { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | eof      { EOF }
  | _
      { raise (Error (Printf.sprintf
                        "At offset %d: unexpected character."
                        (Lexing.lexeme_start lexbuf))) }

