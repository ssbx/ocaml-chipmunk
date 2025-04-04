module Ck = Chipmunk

let add_box space size mass =
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

  for _ = 1 to 50 do (
    let body = add_box space 20. 1. in
    let pivot = Ck.cpPivotJointNew2 static_body body Ck.Vect.zero Ck.Vect.zero in
    Ck.cpSpaceAddConstraint space pivot;
    Ck.cpConstraintSetMaxBias pivot 0.;
    Ck.cpConstraintSetMaxForce pivot 1000.;
    let gear = Ck.cpGearJointNew static_body body 0. 0. in
    Ck.cpSpaceAddConstraint space gear;
    Ck.cpConstraintSetMaxBias gear 0.;
    Ck.cpConstraintSetMaxForce gear 5000.
  ) done;

  let tank_control_body = Ck.cpBodyNewKinematic () in
  Ck.cpSpaceAddBody space tank_control_body;
  let tank_body = add_box space 30. 10. in
  let pivot = Ck.cpPivotJointNew2 tank_control_body tank_body
    Ck.Vect.zero Ck.Vect.zero in
  Ck.cpSpaceAddConstraint space pivot;
  Ck.cpConstraintSetMaxBias pivot 0.;
  Ck.cpConstraintSetMaxForce pivot 100000.;
  let gear = Ck.cpGearJointNew tank_control_body tank_body 0. 1. in
  Ck.cpSpaceAddConstraint space gear;
  Ck.cpConstraintSetErrorBias gear 0.;
  Ck.cpConstraintSetMaxBias gear 1.2;
  Ck.cpConstraintSetMaxForce gear 50000.;


  Ck.cpBodyFree tank_control_body;
  Ck.cpBodyFree tank_body;
  Ck.cpShapeFree h1;
  Ck.cpShapeFree h2;
  Ck.cpShapeFree h3;
  Ck.cpShapeFree h4;
  print_endline "cpShapeFree success";
  Ck.cpSpaceFree space;
  print_endline "cpSpaceFree success"
