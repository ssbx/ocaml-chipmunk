open Chipmunk

let add_box space size mass =
  let radius = Cp.Vect.make ~x:size ~y:size |> Cp.Vect.length in
  let body = Cp.body_new mass (Cp.moment_for_box mass size size) in
  let rand_pos =
    Cp.Vect.make
      ~x:((Random.float 1. *. (640. -. (2. *. radius))) -. (320. -. radius))
      ~y:((Random.float 1. *. (480. -. (2. *. radius))) -. (240. -. radius))
  in
  Cp.space_add_body space body;
  Cp.body_set_position body rand_pos;
  let shape = Cp.box_shape_new body size size 0. in
  Cp.shape_set_elasticity shape 0.;
  Cp.shape_set_friction shape 0.7;
  body

let () =
  let space = Cp.space_new () in
  print_endline "spaceNew success";
  Cp.space_set_iterations space 10;
  print_endline "spaceSetIterations success";
  Cp.space_set_sleep_time_threshold space 0.5;
  print_endline "spaceSetSleepTimeThreshold success";
  let static_body = Cp.space_get_static_body space in
  print_endline "spaceGetStaticBody success";
  let _const_grabbable_filter =
    Cp.ShapeFilter.make ~group:Cp.ShapeFilter.const_no_group
      ~categories:Cp.ShapeFilter.const_grabbable_mask_bit
      ~mask:Cp.ShapeFilter.const_grabbable_mask_bit
  and const_not_grabbable_filter =
    Cp.ShapeFilter.make ~group:Cp.ShapeFilter.const_no_group
      ~categories:(Int.lognot Cp.ShapeFilter.const_grabbable_mask_bit)
      ~mask:(Int.lognot Cp.ShapeFilter.const_grabbable_mask_bit)
  in
  (* hedges *)
  let va1 = Cp.Vect.make ~x:(-320.) ~y:(-240.)
  and vb1 = Cp.Vect.make ~x:(-320.) ~y:240. in
  let h1 = Cp.segment_shape_new static_body va1 vb1 0. in
  Cp.shape_set_elasticity h1 1.;
  Cp.shape_set_friction h1 1.;
  Cp.shape_set_filter h1 const_not_grabbable_filter;
  let va2 = Cp.Vect.make ~x:320. ~y:(-240.)
  and vb2 = Cp.Vect.make ~x:320. ~y:240. in
  let h2 = Cp.segment_shape_new static_body va2 vb2 0. in
  Cp.shape_set_elasticity h2 1.;
  Cp.shape_set_friction h2 1.;
  Cp.shape_set_filter h2 const_not_grabbable_filter;
  let va3 = Cp.Vect.make ~x:(-320.) ~y:(-240.)
  and vb3 = Cp.Vect.make ~x:320. ~y:(-240.) in
  let h3 = Cp.segment_shape_new static_body va3 vb3 0. in
  Cp.shape_set_elasticity h3 1.;
  Cp.shape_set_friction h3 1.;
  Cp.shape_set_filter h3 const_not_grabbable_filter;
  let va4 = Cp.Vect.make ~x:(-320.) ~y:240.
  and vb4 = Cp.Vect.make ~x:320. ~y:240. in
  let h4 = Cp.segment_shape_new static_body va4 vb4 0. in
  Cp.shape_set_elasticity h4 1.;
  Cp.shape_set_friction h4 1.;
  Cp.shape_set_filter h4 const_not_grabbable_filter;
  print_endline "create hedges success";
  for _ = 1 to 50 do
    let body = add_box space 20. 1. in
    let pivot =
      Cp.pivot_joint_new2 static_body body Cp.Vect.zero Cp.Vect.zero
    in
    Cp.space_add_constraint space pivot;
    Cp.constraint_set_max_bias pivot 0.;
    Cp.constraint_set_max_force pivot 1000.;
    let gear = Cp.gear_joint_new static_body body 0. 0. in
    Cp.space_add_constraint space gear;
    Cp.constraint_set_max_bias gear 0.;
    Cp.constraint_set_max_force gear 5000.
  done;
  let tank_control_body = Cp.body_new_kinematic () in
  Cp.space_add_body space tank_control_body;
  let tank_body = add_box space 30. 10. in
  let pivot =
    Cp.pivot_joint_new2 tank_control_body tank_body Cp.Vect.zero Cp.Vect.zero
  in
  Cp.space_add_constraint space pivot;
  Cp.constraint_set_max_bias pivot 0.;
  Cp.constraint_set_max_force pivot 100000.;
  let gear = Cp.gear_joint_new tank_control_body tank_body 0. 1. in
  Cp.space_add_constraint space gear;
  Cp.constraint_set_error_bias gear 0.;
  Cp.constraint_set_max_bias gear 1.2;
  Cp.constraint_set_max_force gear 50000.;
  Cp.free_all_space_children space;
  Cp.space_free space;
  print_endline "spaceFree success"
