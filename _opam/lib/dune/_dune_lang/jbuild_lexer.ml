# 1 "src/dune_lang/jbuild_lexer.mll"
 
  open Lexer_shared

(* The difference between the old and new syntax is that the old
   syntax allows backslash following by any characters other than 'n',
   'x', ... and interpret it as it. The new syntax is stricter in
   order to allow introducing new escape sequence in the future if
   needed. *)
type escape_mode =
  | In_block_comment (* Inside #|...|# comments (old syntax) *)
  | In_quoted_string

# 15 "src/dune_lang/jbuild_lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\247\255\001\000\250\255\251\255\252\255\001\000\006\000\
    \255\255\006\000\248\255\249\255\007\000\010\000\011\000\013\000\
    \015\000\253\255\002\000\004\000\255\255\254\255\020\000\251\255\
    \252\255\253\255\019\000\254\255\255\255\034\000\010\000\252\255\
    \253\255\001\000\255\255\254\255\038\000\248\255\249\255\111\000\
    \048\000\254\255\255\255\021\000\065\000\134\000\144\000\180\000\
    \235\000\002\001";
  Lexing.lex_backtrk =
   "\009\000\255\255\255\255\255\255\255\255\255\255\002\000\001\000\
    \255\255\255\255\255\255\255\255\001\000\255\255\255\255\000\000\
    \003\000\255\255\002\000\002\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\003\000\255\255\255\255\000\000\255\255\255\255\
    \255\255\003\000\255\255\255\255\003\000\255\255\255\255\005\000\
    \003\000\255\255\255\255\006\000\003\000\002\000\003\000\005\000\
    \004\000\005\000";
  Lexing.lex_default =
   "\255\255\000\000\255\255\000\000\000\000\000\000\006\000\255\255\
    \000\000\255\255\000\000\000\000\255\255\255\255\255\255\015\000\
    \017\000\000\000\255\255\255\255\000\000\000\000\024\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\255\255\031\000\000\000\
    \000\000\255\255\000\000\000\000\038\000\000\000\000\000\255\255\
    \255\255\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\007\000\008\000\255\255\007\000\009\000\255\255\007\000\
    \008\000\013\000\007\000\013\000\014\000\013\000\013\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\025\000\025\000\042\000\
    \007\000\026\000\003\000\002\000\035\000\021\000\007\000\019\000\
    \005\000\004\000\013\000\029\000\034\000\000\000\000\000\255\255\
    \042\000\255\255\019\000\043\000\000\000\000\000\028\000\255\255\
    \255\255\000\000\000\000\006\000\010\000\000\000\000\000\000\000\
    \000\000\000\000\029\000\000\000\000\000\015\000\000\000\000\000\
    \041\000\000\000\255\255\000\000\000\000\041\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\040\000\040\000\
    \040\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \044\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\044\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \027\000\045\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \045\000\045\000\045\000\000\000\000\000\011\000\018\000\000\000\
    \020\000\000\000\041\000\000\000\000\000\000\000\033\000\000\000\
    \041\000\000\000\000\000\018\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\041\000\000\000\000\000\000\000\
    \041\000\000\000\041\000\000\000\000\000\000\000\039\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\046\000\046\000\
    \046\000\046\000\046\000\046\000\046\000\046\000\046\000\046\000\
    \046\000\046\000\046\000\046\000\046\000\046\000\046\000\046\000\
    \046\000\046\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\255\255\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\032\000\000\000\000\000\255\255\000\000\255\255\
    \000\000\000\000\000\000\000\000\023\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\049\000\049\000\049\000\000\000\037\000\000\000\
    \000\000\000\000\000\000\000\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\049\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\049\000\049\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\000\000\000\000\000\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\006\000\000\000\000\000\006\000\007\000\
    \009\000\012\000\007\000\013\000\012\000\014\000\013\000\015\000\
    \016\000\016\000\015\000\016\000\016\000\026\000\022\000\043\000\
    \000\000\022\000\000\000\000\000\033\000\018\000\007\000\019\000\
    \000\000\000\000\013\000\029\000\030\000\255\255\255\255\016\000\
    \036\000\016\000\016\000\036\000\255\255\255\255\022\000\016\000\
    \016\000\255\255\255\255\000\000\002\000\255\255\255\255\255\255\
    \255\255\255\255\029\000\255\255\255\255\013\000\255\255\255\255\
    \036\000\255\255\016\000\255\255\255\255\036\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\036\000\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
    \040\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \040\000\040\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \022\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\044\000\044\000\255\255\255\255\002\000\018\000\255\255\
    \019\000\255\255\036\000\255\255\255\255\255\255\030\000\255\255\
    \036\000\255\255\255\255\016\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\036\000\255\255\255\255\255\255\
    \036\000\255\255\036\000\255\255\255\255\255\255\036\000\039\000\
    \039\000\039\000\039\000\039\000\039\000\039\000\039\000\039\000\
    \039\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \039\000\039\000\039\000\039\000\039\000\039\000\045\000\045\000\
    \045\000\045\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \046\000\046\000\046\000\046\000\046\000\046\000\046\000\046\000\
    \046\000\046\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \039\000\039\000\039\000\039\000\039\000\039\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\047\000\047\000\047\000\
    \047\000\047\000\047\000\255\255\255\255\255\255\255\255\255\255\
    \000\000\006\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\030\000\255\255\255\255\015\000\255\255\016\000\
    \255\255\255\255\255\255\255\255\022\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\255\255\036\000\255\255\
    \255\255\255\255\255\255\255\255\048\000\048\000\048\000\048\000\
    \048\000\048\000\049\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\049\000\049\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\049\000\049\000\049\000\049\000\049\000\
    \049\000\255\255\255\255\255\255\048\000\048\000\048\000\048\000\
    \048\000\048\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\049\000\049\000\049\000\049\000\049\000\
    \049\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_base_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000";
  Lexing.lex_backtrk_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000";
  Lexing.lex_default_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000";
  Lexing.lex_trans_code =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000";
  Lexing.lex_check_code =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\013\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255";
  Lexing.lex_code =
   "\255\001\255\255\000\001\255";
}

let rec token with_comments lexbuf =
   __ocaml_lex_token_rec with_comments lexbuf 0
and __ocaml_lex_token_rec with_comments lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 27 "src/dune_lang/jbuild_lexer.mll"
    ( Lexing.new_line lexbuf; token with_comments lexbuf )
# 276 "src/dune_lang/jbuild_lexer.ml"

  | 1 ->
# 29 "src/dune_lang/jbuild_lexer.mll"
    ( token with_comments lexbuf )
# 281 "src/dune_lang/jbuild_lexer.ml"

  | 2 ->
# 31 "src/dune_lang/jbuild_lexer.mll"
    ( if with_comments then
        comment_trail [Stdune.String.drop (Lexing.lexeme lexbuf) 1] lexbuf
      else
        token with_comments lexbuf
    )
# 290 "src/dune_lang/jbuild_lexer.ml"

  | 3 ->
# 37 "src/dune_lang/jbuild_lexer.mll"
    ( Token.Lparen )
# 295 "src/dune_lang/jbuild_lexer.ml"

  | 4 ->
# 39 "src/dune_lang/jbuild_lexer.mll"
    ( Rparen )
# 300 "src/dune_lang/jbuild_lexer.ml"

  | 5 ->
# 41 "src/dune_lang/jbuild_lexer.mll"
    ( Buffer.clear escaped_buf;
      let start = Lexing.lexeme_start_p lexbuf in
      let s = quoted_string In_quoted_string lexbuf in
      lexbuf.lex_start_p <- start;
      Quoted_string s
    )
# 310 "src/dune_lang/jbuild_lexer.ml"

  | 6 ->
# 48 "src/dune_lang/jbuild_lexer.mll"
    ( let start = Lexing.lexeme_start_p lexbuf in
      block_comment lexbuf;
      if with_comments then begin
        lexbuf.lex_start_p <- start;
        Comment Legacy
      end else
        token false lexbuf
    )
# 322 "src/dune_lang/jbuild_lexer.ml"

  | 7 ->
# 57 "src/dune_lang/jbuild_lexer.mll"
    ( Sexp_comment )
# 327 "src/dune_lang/jbuild_lexer.ml"

  | 8 ->
# 59 "src/dune_lang/jbuild_lexer.mll"
    ( Eof )
# 332 "src/dune_lang/jbuild_lexer.ml"

  | 9 ->
# 61 "src/dune_lang/jbuild_lexer.mll"
    ( atom "" (Lexing.lexeme_start_p lexbuf) lexbuf )
# 337 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec with_comments lexbuf __ocaml_lex_state

and comment_trail acc lexbuf =
  lexbuf.Lexing.lex_mem <- Array.make 2 (-1); __ocaml_lex_comment_trail_rec acc lexbuf 12
and __ocaml_lex_comment_trail_rec acc lexbuf __ocaml_lex_state =
  match Lexing.new_engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 64 "src/dune_lang/jbuild_lexer.mll"
                                        s
# 350 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(0) lexbuf.Lexing.lex_curr_pos in
# 65 "src/dune_lang/jbuild_lexer.mll"
    ( comment_trail (s :: acc) lexbuf )
# 354 "src/dune_lang/jbuild_lexer.ml"

  | 1 ->
# 67 "src/dune_lang/jbuild_lexer.mll"
    ( Token.Comment (Lines (List.rev acc)) )
# 359 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_comment_trail_rec acc lexbuf __ocaml_lex_state

and atom acc start lexbuf =
   __ocaml_lex_atom_rec acc start lexbuf 16
and __ocaml_lex_atom_rec acc start lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 71 "src/dune_lang/jbuild_lexer.mll"
    ( lexbuf.lex_start_p <- start;
      error lexbuf "jbuild atoms cannot contain #|"
    )
# 373 "src/dune_lang/jbuild_lexer.ml"

  | 1 ->
# 75 "src/dune_lang/jbuild_lexer.mll"
    ( lexbuf.lex_start_p <- start;
      error lexbuf "jbuild atoms cannot contain |#"
    )
# 380 "src/dune_lang/jbuild_lexer.ml"

  | 2 ->
let
# 78 "src/dune_lang/jbuild_lexer.mll"
                                               s
# 386 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 79 "src/dune_lang/jbuild_lexer.mll"
    ( atom (if acc = "" then s else acc ^ s) start lexbuf
    )
# 391 "src/dune_lang/jbuild_lexer.ml"

  | 3 ->
# 82 "src/dune_lang/jbuild_lexer.mll"
    ( if acc = "" then
        error lexbuf "Internal error in the S-expression parser, \
                      please report upstream.";
      lexbuf.lex_start_p <- start;
      Token.Atom (Atom.of_string acc)
    )
# 401 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_atom_rec acc start lexbuf __ocaml_lex_state

and quoted_string mode lexbuf =
   __ocaml_lex_quoted_string_rec mode lexbuf 22
and __ocaml_lex_quoted_string_rec mode lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 91 "src/dune_lang/jbuild_lexer.mll"
    ( Buffer.contents escaped_buf )
# 413 "src/dune_lang/jbuild_lexer.ml"

  | 1 ->
# 93 "src/dune_lang/jbuild_lexer.mll"
    ( match escape_sequence mode lexbuf with
      | Newline -> quoted_string_after_escaped_newline mode lexbuf
      | Other   -> quoted_string                       mode lexbuf
    )
# 421 "src/dune_lang/jbuild_lexer.ml"

  | 2 ->
let
# 97 "src/dune_lang/jbuild_lexer.mll"
               s
# 427 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 98 "src/dune_lang/jbuild_lexer.mll"
    ( Lexing.new_line lexbuf;
      Buffer.add_string escaped_buf s;
      quoted_string mode lexbuf
    )
# 434 "src/dune_lang/jbuild_lexer.ml"

  | 3 ->
let
# 102 "src/dune_lang/jbuild_lexer.mll"
         c
# 440 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 103 "src/dune_lang/jbuild_lexer.mll"
    ( Buffer.add_char escaped_buf c;
      quoted_string mode lexbuf
    )
# 446 "src/dune_lang/jbuild_lexer.ml"

  | 4 ->
# 107 "src/dune_lang/jbuild_lexer.mll"
    ( if mode = In_block_comment then
        error lexbuf "unterminated quoted string";
      Buffer.contents escaped_buf
    )
# 454 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_quoted_string_rec mode lexbuf __ocaml_lex_state

and quoted_string_after_escaped_newline mode lexbuf =
   __ocaml_lex_quoted_string_after_escaped_newline_rec mode lexbuf 29
and __ocaml_lex_quoted_string_after_escaped_newline_rec mode lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 114 "src/dune_lang/jbuild_lexer.mll"
    ( quoted_string mode lexbuf )
# 466 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_quoted_string_after_escaped_newline_rec mode lexbuf __ocaml_lex_state

and block_comment lexbuf =
   __ocaml_lex_block_comment_rec lexbuf 30
and __ocaml_lex_block_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 118 "src/dune_lang/jbuild_lexer.mll"
    ( Buffer.clear escaped_buf;
      ignore (quoted_string In_block_comment lexbuf : string);
      block_comment lexbuf
    )
# 481 "src/dune_lang/jbuild_lexer.ml"

  | 1 ->
# 123 "src/dune_lang/jbuild_lexer.mll"
    ( ()
    )
# 487 "src/dune_lang/jbuild_lexer.ml"

  | 2 ->
# 126 "src/dune_lang/jbuild_lexer.mll"
    ( error lexbuf "unterminated block comment"
    )
# 493 "src/dune_lang/jbuild_lexer.ml"

  | 3 ->
# 129 "src/dune_lang/jbuild_lexer.mll"
    ( block_comment lexbuf
    )
# 499 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_block_comment_rec lexbuf __ocaml_lex_state

and escape_sequence mode lexbuf =
   __ocaml_lex_escape_sequence_rec mode lexbuf 36
and __ocaml_lex_escape_sequence_rec mode lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 134 "src/dune_lang/jbuild_lexer.mll"
    ( Lexing.new_line lexbuf;
      Newline )
# 512 "src/dune_lang/jbuild_lexer.ml"

  | 1 ->
let
# 136 "src/dune_lang/jbuild_lexer.mll"
                                       c
# 518 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 137 "src/dune_lang/jbuild_lexer.mll"
    ( let c =
        match c with
        | 'n' -> '\n'
        | 'r' -> '\r'
        | 'b' -> '\b'
        | 't' -> '\t'
        | _   -> c
      in
      Buffer.add_char escaped_buf c;
      Other
    )
# 532 "src/dune_lang/jbuild_lexer.ml"

  | 2 ->
let
# 148 "src/dune_lang/jbuild_lexer.mll"
              c1
# 538 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos
and
# 148 "src/dune_lang/jbuild_lexer.mll"
                            c2
# 543 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 1)
and
# 148 "src/dune_lang/jbuild_lexer.mll"
                                          c3
# 548 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 2) in
# 149 "src/dune_lang/jbuild_lexer.mll"
    ( let v = eval_decimal_escape c1 c2 c3 in
      if mode = In_quoted_string && v > 255 then
        error lexbuf "escape sequence in quoted string out of range"
          ~delta:(-1);
      Buffer.add_char escaped_buf (Char.chr v);
      Other
    )
# 558 "src/dune_lang/jbuild_lexer.ml"

  | 3 ->
let
# 156 "src/dune_lang/jbuild_lexer.mll"
              s
# 564 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 157 "src/dune_lang/jbuild_lexer.mll"
    ( if mode = In_quoted_string then
        error lexbuf "unterminated decimal escape sequence" ~delta:(-1);
      Buffer.add_char escaped_buf '\\';
      Buffer.add_string escaped_buf s;
      Other
    )
# 573 "src/dune_lang/jbuild_lexer.ml"

  | 4 ->
let
# 163 "src/dune_lang/jbuild_lexer.mll"
                     c1
# 579 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 1)
and
# 163 "src/dune_lang/jbuild_lexer.mll"
                                      c2
# 584 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 2) in
# 164 "src/dune_lang/jbuild_lexer.mll"
    ( let v = eval_hex_escape c1 c2 in
      Buffer.add_char escaped_buf (Char.chr v);
      Other
    )
# 591 "src/dune_lang/jbuild_lexer.ml"

  | 5 ->
let
# 168 "src/dune_lang/jbuild_lexer.mll"
                     s
# 597 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 169 "src/dune_lang/jbuild_lexer.mll"
    ( if mode = In_quoted_string then
        error lexbuf "unterminated hexadecimal escape sequence" ~delta:(-1);
      Buffer.add_char escaped_buf '\\';
      Buffer.add_string escaped_buf s;
      Other
    )
# 606 "src/dune_lang/jbuild_lexer.ml"

  | 6 ->
let
# 175 "src/dune_lang/jbuild_lexer.mll"
         c
# 612 "src/dune_lang/jbuild_lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 176 "src/dune_lang/jbuild_lexer.mll"
    ( Buffer.add_char escaped_buf '\\';
      Buffer.add_char escaped_buf c;
      Other
    )
# 619 "src/dune_lang/jbuild_lexer.ml"

  | 7 ->
# 181 "src/dune_lang/jbuild_lexer.mll"
    ( if mode = In_quoted_string then
        error lexbuf "unterminated escape sequence" ~delta:(-1);
      Other
    )
# 627 "src/dune_lang/jbuild_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_escape_sequence_rec mode lexbuf __ocaml_lex_state

;;

# 186 "src/dune_lang/jbuild_lexer.mll"
 
  let token ~with_comments lexbuf = token with_comments lexbuf

# 638 "src/dune_lang/jbuild_lexer.ml"
