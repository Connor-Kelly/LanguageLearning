open Printf

let read_and_print_all_lines filename = let chan = open_in filename in
  let rec read_line chan = 
    let line = input_line chan in
      printf "%s\n" (line)
    read_line chan ;



let () =
  let filename = "./content/basic.html" in
  (* let str = read_whole_file filename in *)
  read_and_print_all_lines filename