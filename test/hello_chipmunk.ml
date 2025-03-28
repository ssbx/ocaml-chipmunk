module Ck = Chipmunk

let () =
  let space = Ck.cpSpaceNew () in
  print_endline "cpSpaceNew success";

  let gravity = Ck.Vect.make ~x:0. ~y:(-100.) in

  Unix.sleep 1;
  Ck.cpSpaceSetGravity space gravity;
  print_endline "cpSpaceSetGravity success";

  let body = Ck.cpSpaceGetStaticBody space in
  print_endline "cpSpaceGetStaticBody success";

  let va = Ck.Vect.make ~x:(-20.) ~y:(5.)
  and vb = Ck.Vect.make ~x:(20.) ~y:(-5.) in
  let ground = Ck.cpSegmentShapeNew body va vb 0. in
  print_endline "cpSegmentShapeNew success";

  Ck.cpShapeSetFriction ground 1.;
  print_endline "cpShapeSetFriction success";

  Ck.cpSpaceAddShape space ground;
  print_endline "cpSpaceAddShape success";

  let radius = 5.
  and mass = 1. in
  let moment = Ck.cpMomentForCircle mass 0. radius Ck.Vect.zero in
  print_endline "cpMomentForCircle success";
  Printf.printf "moment is %f\n" moment;

  let ball_body = Ck.cpBodyNew mass moment in
  print_endline "cpBodyNew success";

  Ck.cpSpaceAddBody space ball_body;
  print_endline "cpSpaceAddBody success";

  let position = Ck.Vect.make ~x:0. ~y:15. in
  Ck.cpBodySetPosition ball_body position;
  print_endline "cpBodySetPosition success";

  let ball_shape = Ck.cpCircleShapeNew ball_body radius Ck.Vect.zero  in
  print_endline "cpCircleShapeNew success";

  Ck.cpSpaceAddShape space ball_shape;
  print_endline "cpSpaceAddShape success";

  Ck.cpShapeSetFriction ball_shape 0.7;
  print_endline "cpShapeSetFriction success";

  let timestep = 1. /. 60. in
  let rec loop time =
    let pos = Ck.cpBodyGetPosition ball_body
    and vel = Ck.cpBodyGetVelocity ball_body in
    Printf.printf "Time is %f. ball is at (%f %f) with velocity (%f %f)\n"
      time pos.x pos.y vel.x vel.y;
    Ck.cpSpaceStep space timestep;
    if time < 2. then loop (time +. timestep)
  in

  loop 0.;

  Ck.cpShapeFree ball_shape;
  print_endline "cpShapeFree success";
  Ck.cpBodyFree ball_body;
  print_endline "cpBodyFree success";
  Ck.cpShapeFree ground;
  print_endline "cpShapeFree success";
  Ck.cpSpaceFree space;
  print_endline "cpSpaceFree success"
