open Chipmunk

let () =
  let space = Cp.space_new () in
  print_endline "cpSpaceNew success";

  let gravity = Cp.Vect.make ~x:0. ~y:(-100.) in

  Unix.sleep 1;
  Cp.space_set_gravity space gravity;
  print_endline "cpSpaceSetGravity success";

  let body = Cp.space_get_static_body space in
  print_endline "cpSpaceGetStaticBody success";

  let va = Cp.Vect.make ~x:(-20.) ~y:(5.)
  and vb = Cp.Vect.make ~x:(20.) ~y:(-5.) in
  let ground = Cp.segment_shape_new body va vb 0. in
  print_endline "cpSegmentShapeNew success";

  Cp.shape_set_friction ground 1.;
  print_endline "cpShapeSetFriction success";

  Cp.space_add_shape space ground;
  print_endline "cpSpaceAddShape success";

  let radius = 5.
  and mass = 1. in
  let moment = Cp.moment_for_circle mass 0. radius Cp.Vect.zero in
  print_endline "cpMomentForCircle success";
  Printf.printf "moment is %f\n" moment;

  let ball_body = Cp.body_new mass moment in
  print_endline "cpBodyNew success";

  Cp.space_add_body space ball_body;
  print_endline "cpSpaceAddBody success";

  let position = Cp.Vect.make ~x:0. ~y:15. in
  Cp.body_set_position ball_body position;
  print_endline "cpBodySetPosition success";

  let ball_shape = Cp.circle_shape_new ball_body radius Cp.Vect.zero  in
  print_endline "cpCircleShapeNew success";

  Cp.space_add_shape space ball_shape;
  print_endline "cpSpaceAddShape success";

  Cp.shape_set_friction ball_shape 0.7;
  print_endline "cpShapeSetFriction success";

  let timestep = 1. /. 60. in
  let rec loop time =
    let pos = Cp.body_get_position ball_body
    and vel = Cp.body_get_velocity ball_body in
    Printf.printf "Time is %f. ball is at (%f %f) with velocity (%f %f)\n"
      time pos.x pos.y vel.x vel.y;
    Cp.space_step space timestep;
    if time < 2. then loop (time +. timestep)
  in

  loop 0.;

  Cp.shape_free ball_shape;
  print_endline "cpShapeFree success";
  Cp.body_free ball_body;
  print_endline "cpBodyFree success";
  Cp.shape_free ground;
  print_endline "cpShapeFree success";
  Cp.space_free space;
  print_endline "cpSpaceFree success"
