type t = bool

let compare x y =
  match x, y with
  | true, true
  | false, false -> Ordering.Eq
  | true, false -> Gt
  | false, true -> Lt

let to_string = string_of_bool

let of_string s = Option.try_with (fun () -> bool_of_string s)