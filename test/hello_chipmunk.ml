open Chipmunk

let () =
  let space = Cp.spaceNew () in
  print_endline "cpSpaceNew success";

  let gravity = Cp.Vect.make ~x:0. ~y:(-100.) in

  Unix.sleep 1;
  Cp.spaceSetGravity space gravity;
  print_endline "cpSpaceSetGravity success";

  let body = Cp.spaceGetStaticBody space in
  print_endline "cpSpaceGetStaticBody success";

  let va = Cp.Vect.make ~x:(-20.) ~y:(5.)
  and vb = Cp.Vect.make ~x:(20.) ~y:(-5.) in
  let ground = Cp.segmentShapeNew body va vb 0. in
  print_endline "cpSegmentShapeNew success";

  Cp.shapeSetFriction ground 1.;
  print_endline "cpShapeSetFriction success";

  Cp.spaceAddShape space ground;
  print_endline "cpSpaceAddShape success";

  let radius = 5.
  and mass = 1. in
  let moment = Cp.momentForCircle mass 0. radius Cp.Vect.zero in
  print_endline "cpMomentForCircle success";
  Printf.printf "moment is %f\n" moment;

  let ball_body = Cp.bodyNew mass moment in
  print_endline "cpBodyNew success";

  Cp.spaceAddBody space ball_body;
  print_endline "cpSpaceAddBody success";

  let position = Cp.Vect.make ~x:0. ~y:15. in
  Cp.bodySetPosition ball_body position;
  print_endline "cpBodySetPosition success";

  let ball_shape = Cp.circleShapeNew ball_body radius Cp.Vect.zero  in
  print_endline "cpCircleShapeNew success";

  Cp.spaceAddShape space ball_shape;
  print_endline "cpSpaceAddShape success";

  Cp.shapeSetFriction ball_shape 0.7;
  print_endline "cpShapeSetFriction success";

  let timestep = 1. /. 60. in
  let rec loop time =
    let pos = Cp.bodyGetPosition ball_body
    and vel = Cp.bodyGetVelocity ball_body in
    Printf.printf "Time is %f. ball is at (%f %f) with velocity (%f %f)\n"
      time pos.x pos.y vel.x vel.y;
    Cp.spaceStep space timestep;
    if time < 2. then loop (time +. timestep)
  in

  loop 0.;

  Cp.shapeFree ball_shape;
  print_endline "cpShapeFree success";
  Cp.bodyFree ball_body;
  print_endline "cpBodyFree success";
  Cp.shapeFree ground;
  print_endline "cpShapeFree success";
  Cp.spaceFree space;
  print_endline "cpSpaceFree success"
