module Ck = Chipmunk

let () =
  let space = Ck.cpSpaceNew () in
  print_endline "cpSpaceNew success";
  let gravity = Ck.Vect.make ~x:0. ~y:(-100.) in
  Ck.cpSpaceSetGravity space gravity;
  print_endline "cpSpaceSetGravity success";
  let _shape = Ck.cpSpaceGetStaticBody space in
  print_endline "cpSpaceGetStaticBody success";
(*
  Ck.cpBodyFree body;
  print_endline "cpBodyFree success";*)
  Ck.cpSpaceFree space;
  print_endline "cpSpaceFree success"
