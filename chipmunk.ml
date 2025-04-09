module Cp = struct
  module Space = struct
    type t = nativeint
  end

  module Body = struct
    type t = nativeint
  end

  module Shape = struct
    type t = nativeint
  end

  module Constraint = struct
    type t = nativeint
  end

  module PivotJoint = struct
    type t = nativeint
  end

  module ShapeFilter = struct
    type t =
      { group : int
      ; categories : int
      ; mask : int
      }

    let const_grabbable_mask_bit = Int.shift_left 1 31
    let const_no_group = 0
    let const_all_categories = Int.lognot 0
    let const_wildcard_collision_type = Int.lognot 0
    let make ~group ~categories ~mask = ({ group; categories; mask } : t)
  end

  module Vect = struct
    type t =
      { x : float
      ; y : float
      }

    let zero = ({ x = 0.; y = 0. } : t)
    let make ~x ~y = { x; y }
    let length v = Float.sqrt ((v.x *. v.x) +. (v.y *. v.y))
  end

  external space_new : unit -> Space.t = "caml_cpSpaceNew"
  external space_free : Space.t -> unit = "caml_cpSpaceFree" [@@noalloc]

  external space_set_gravity : Space.t -> Vect.t -> unit = "caml_cpSpaceSetGravity"
  [@@noalloc]

  external space_get_static_body : Space.t -> Body.t = "caml_cpSpaceGetStaticBody"
  external body_free : Body.t -> unit = "caml_cpBodyFree" [@@noalloc]

  external shape_set_friction : Shape.t -> float -> unit = "caml_cpShapeSetFriction"
  [@@noalloc]

  external segment_shape_new
    :  Body.t
    -> Vect.t
    -> Vect.t
    -> float
    -> Shape.t
    = "caml_cpSegmentShapeNew"

  external shape_free : Shape.t -> unit = "caml_cpShapeFree" [@@noalloc]

  (** differ from the original api *)
  external space_add_shape : Space.t -> Shape.t -> unit = "caml_cpSpaceAddShape"
  [@@noalloc]

  external moment_for_circle
    :  float
    -> float
    -> float
    -> Vect.t
    -> float
    = "caml_cpMomentForCircle"

  external body_new : float -> float -> Body.t = "caml_cpBodyNew"

  (** differ from the original api *)
  external space_add_body : Space.t -> Body.t -> unit = "caml_cpSpaceAddBody"
  [@@noalloc]

  external body_set_position : Body.t -> Vect.t -> unit = "caml_cpBodySetPosition"
  [@@noalloc]

  external circle_shape_new
    :  Body.t
    -> float
    -> Vect.t
    -> Shape.t
    = "caml_cpCircleShapeNew"

  external body_get_position : Body.t -> Vect.t = "caml_cpBodyGetPosition"
  external body_get_velocity : Body.t -> Vect.t = "caml_cpBodyGetVelocity"
  external space_step : Space.t -> float -> unit = "caml_cpSpaceStep" [@@noalloc]

  external space_set_iterations : Space.t -> int -> unit = "caml_cpSpaceSetIterations"
  [@@noalloc]

  external space_set_sleep_time_threshold
    :  Space.t
    -> float
    -> unit
    = "caml_cpSpaceSetSleepTimeThreshold"
  [@@noalloc]

  external shape_set_elasticity : Shape.t -> float -> unit = "caml_cpShapeSetElasticity"
  [@@noalloc]

  external shape_set_filter : Shape.t -> ShapeFilter.t -> unit = "caml_cpShapeSetFilter"
  external body_new_kinematic : unit -> Body.t = "caml_cpBodyNewKinematic"
  external moment_for_box : float -> float -> float -> float = "caml_cpMomentForBox"

  external box_shape_new
    :  Body.t
    -> float
    -> float
    -> float
    -> Shape.t
    = "caml_cpBoxShapeNew"

  external pivot_joint_new2
    :  Body.t
    -> Body.t
    -> Vect.t
    -> Vect.t
    -> Constraint.t
    = "caml_cpPivotJointNew2"

  external constraint_set_max_bias
    :  Constraint.t
    -> float
    -> unit
    = "caml_cpConstraintSetMaxBias"

  external constraint_set_max_force
    :  Constraint.t
    -> float
    -> unit
    = "caml_cpConstraintSetMaxForce"

  external gear_joint_new
    :  Body.t
    -> Body.t
    -> float
    -> float
    -> Constraint.t
    = "caml_cpGearJointNew"

  external constraint_set_error_bias
    :  Constraint.t
    -> float
    -> unit
    = "caml_cpConstraintSetErrorBias"

  external space_add_constraint
    :  Space.t
    -> Constraint.t
    -> unit
    = "caml_cpSpaceAddConstraint"

  external body_get_rotation : Body.t -> Vect.t = "caml_cpBodyGetRotation"
  external body_set_angle : Body.t -> float -> unit = "caml_cpBodySetAngle"
  external body_get_angle : Body.t -> float = "caml_cpBodyGetAngle"
  external body_set_velocity : Body.t -> Vect.t = "caml_cpBodySetVelocity"
  external free_all_space_children : Space.t -> unit = "caml_cpFreeAllSpaceChildren"
end
