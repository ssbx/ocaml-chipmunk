module Ck = Chipmunk

let add_body space size mass =
  let radius = Ck.Vect.make ~x:size ~y:size |> Ck.Vect.length in
  let body = Ck.cpBodyNew mass (Ck.cpMomentForBox mass size size) in
  let rand_pos = Ck.Vect.make
    ~x:((Random.float 1.) *. (640. -. 2. *. radius) -. (320. -. radius))
    ~y:((Random.float 1.) *. (480. -. 2. *. radius) -. (240. -. radius)) in
  Ck.cpSpaceAddBody space body;
  Ck.cpBodySetPosition body rand_pos;
  let shape = Ck.cpBoxShapeNew body size size 0. in
  Ck.cpShapeSetElasticity shape 0.;
  Ck.cpShapeSetFriction shape 0.7;
  body

let () = 

  let space = Ck.cpSpaceNew () in
  print_endline "cpSpaceNew success";

  Ck.cpSpaceSetIterations space 10;
  print_endline "cpSpaceSetIterations success";

  Ck.cpSpaceSetSleepTimeThreshold space 0.5;
  print_endline "cpSpaceSetSleepTimeThreshold success";

  let static_body = Ck.cpSpaceGetStaticBody space in
  print_endline "cpSpaceGetStaticBody success";

  let _const_grabbable_filter = Ck.ShapeFilter.make 
    ~group:Ck.ShapeFilter.const_no_group
    ~categories:Ck.ShapeFilter.const_grabbable_mask_bit
    ~mask:Ck.ShapeFilter.const_grabbable_mask_bit
  and const_not_grabbable_filter = Ck.ShapeFilter.make 
    ~group:Ck.ShapeFilter.const_no_group
    ~categories:(Int.lognot Ck.ShapeFilter.const_grabbable_mask_bit)
    ~mask:(Int.lognot Ck.ShapeFilter.const_grabbable_mask_bit)
  in

  (* hedges *)
  let va1 = Ck.Vect.make ~x:(-320.) ~y:(-240.)
  and vb1 = Ck.Vect.make ~x:(-320.) ~y:(240.) in
  let h1 = Ck.cpSegmentShapeNew static_body va1 vb1 0. in
  Ck.cpShapeSetElasticity h1 1.;
  Ck.cpShapeSetFriction h1 1.;
  Ck.cpShapeSetFilter h1 const_not_grabbable_filter;

  let va2 = Ck.Vect.make ~x:(320.) ~y:(-240.)
  and vb2 = Ck.Vect.make ~x:(320.) ~y:(240.) in
  let h2 = Ck.cpSegmentShapeNew static_body va2 vb2 0. in
  Ck.cpShapeSetElasticity h2 1.;
  Ck.cpShapeSetFriction h2 1.;
  Ck.cpShapeSetFilter h2 const_not_grabbable_filter;

  let va3 = Ck.Vect.make ~x:(-320.) ~y:(-240.)
  and vb3 = Ck.Vect.make ~x:(320.) ~y:(-240.) in
  let h3 = Ck.cpSegmentShapeNew static_body va3 vb3 0. in
  Ck.cpShapeSetElasticity h3 1.;
  Ck.cpShapeSetFriction h3 1.;
  Ck.cpShapeSetFilter h3 const_not_grabbable_filter;

  let va4 = Ck.Vect.make ~x:(-320.) ~y:(240.)
  and vb4 = Ck.Vect.make ~x:(320.) ~y:(240.) in
  let h4 = Ck.cpSegmentShapeNew static_body va4 vb4 0. in
  Ck.cpShapeSetElasticity h4 1.;
  Ck.cpShapeSetFriction h4 1.;
  Ck.cpShapeSetFilter h4 const_not_grabbable_filter;

  print_endline "create hedges success";

  (* TODO fir i.. add_box *)


  let tank_control_body = Ck.cpBodyNewKinematic () in
  Ck.cpSpaceAddBody space tank_control_body;
  let tank_body = add_body space 30. 10. in

  (*
  let gravity = Ck.Vect.make ~x:0. ~y:(-100.) in

  Unix.sleep 1;
  Ck.cpSpaceSetGravity space gravity;
  print_endline "cpSpaceSetGravity success";

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
  *)

  Ck.cpBodyFree tank_control_body;
  Ck.cpBodyFree tank_body;
  Ck.cpShapeFree h1;
  Ck.cpShapeFree h2;
  Ck.cpShapeFree h3;
  Ck.cpShapeFree h4;
  print_endline "cpShapeFree success";
  Ck.cpSpaceFree space;
  print_endline "cpSpaceFree success"
