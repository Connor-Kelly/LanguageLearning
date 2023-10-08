let () = print_endline "Hello, World!";;

type expr =
  | Plus of expr * expr        (* a + b *)
  | Minus of expr * expr       (* a - b *)
  | Times of expr * expr       (* a * b *)
  | Divide of expr * expr      (* a / b *)
  | Var of string              (* "x", "y", etc. *);;

let rec to_string e =
  match e with
  | Plus (left, right) ->
     "(" ^ to_string left ^ " + " ^ to_string right ^ ")"
  | Minus (left, right) ->
     "(" ^ to_string left ^ " - " ^ to_string right ^ ")"
  | Times (left, right) ->
   "(" ^ to_string left ^ " * " ^ to_string right ^ ")"
  | Divide (left, right) ->
   "(" ^ to_string left ^ " / " ^ to_string right ^ ")"
  | Var v -> v;;
(* val to_string : expr -> string = <fun> *)
let print_expr e =
  print_endline (to_string e);;

(* let factorize e = 
  match e with *)


