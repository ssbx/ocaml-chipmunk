
module Cp = struct
  module Space = struct type t = nativeint end
  module Body = struct type t = nativeint end
  module Shape = struct type t = nativeint end
  module Constraint = struct type t = nativeint end
  module PivotJoint = struct type t = nativeint end
  module ShapeFilter = struct
    type t =
      { group       : int
      ; categories  : int
      ; mask        : int }
    let const_grabbable_mask_bit      = (Int.shift_left 1 31)
    let const_no_group                = 0
    let const_all_categories          = (Int.lognot 0)
    let const_wildcard_collision_type = (Int.lognot 0)
    let make ~group ~categories ~mask =
      ({ group      = group
       ; categories = categories
       ; mask       = mask } : t)
  end

  module Vect = struct
    type t =
      { x : float
      ; y : float }
    let zero = ({ x = 0.; y = 0. } : t)
    let make ~x ~y = {x; y}
    let length v = Float.sqrt (v.x *. v.x +. v.y *. v.y)
  end

  external spaceNew : unit -> Space.t =
    "caml_cpSpaceNew"
  external spaceFree : Space.t -> unit =
    "caml_cpSpaceFree" [@@noalloc]
  external spaceSetGravity : Space.t -> Vect.t -> unit =
    "caml_cpSpaceSetGravity" [@@noalloc]
  external spaceGetStaticBody : Space.t -> Body.t =
    "caml_cpSpaceGetStaticBody"
  external bodyFree : Body.t -> unit =
    "caml_cpBodyFree" [@@noalloc]
  external shapeSetFriction : Shape.t -> float -> unit =
    "caml_cpShapeSetFriction" [@@noalloc]
  external segmentShapeNew : Body.t -> Vect.t -> Vect.t -> float -> Shape.t
    = "caml_cpSegmentShapeNew"
  external shapeFree : Shape.t -> unit =
    "caml_cpShapeFree" [@@noalloc]

  (** differ from the original api *)
  external spaceAddShape : Space.t -> Shape.t -> unit =
    "caml_cpSpaceAddShape" [@@noalloc]
  external momentForCircle : float -> float -> float -> Vect.t -> float
    = "caml_cpMomentForCircle"
  external bodyNew : float -> float -> Body.t
    = "caml_cpBodyNew"

  (** differ from the original api *)
  external spaceAddBody : Space.t -> Body.t -> unit =
    "caml_cpSpaceAddBody" [@@noalloc]
  external bodySetPosition : Body.t -> Vect.t -> unit =
    "caml_cpBodySetPosition" [@@noalloc]
  external circleShapeNew : Body.t -> float -> Vect.t -> Shape.t
    = "caml_cpCircleShapeNew"
  external bodyGetPosition : Body.t -> Vect.t =
    "caml_cpBodyGetPosition"
  external bodyGetVelocity : Body.t -> Vect.t =
    "caml_cpBodyGetVelocity"
  external spaceStep : Space.t -> float -> unit =
    "caml_cpSpaceStep" [@@noalloc]
  external spaceSetIterations : Space.t -> int -> unit =
    "caml_cpSpaceSetIterations" [@@noalloc]
  external spaceSetSleepTimeThreshold : Space.t -> float -> unit =
    "caml_cpSpaceSetSleepTimeThreshold" [@@noalloc]
  external shapeSetElasticity : Shape.t -> float -> unit =
    "caml_cpShapeSetElasticity" [@@noalloc]
  external shapeSetFilter : Shape.t -> ShapeFilter.t -> unit =
    "caml_cpShapeSetFilter"
  external bodyNewKinematic : unit -> Body.t =
    "caml_cpBodyNewKinematic"
  external momentForBox : float -> float -> float -> float =
    "caml_cpMomentForBox"
  external boxShapeNew : Body.t -> float -> float -> float -> Shape.t =
    "caml_cpBoxShapeNew"
  external pivotJointNew2 : Body.t -> Body.t -> Vect.t -> Vect.t
    -> Constraint.t = "caml_cpPivotJointNew2"
  external constraintSetMaxBias : Constraint.t -> float -> unit =
    "caml_cpConstraintSetMaxBias"
  external constraintSetMaxForce : Constraint.t -> float -> unit =
    "caml_cpConstraintSetMaxForce"
  external gearJointNew : Body.t -> Body.t-> float -> float -> Constraint.t =
    "caml_cpGearJointNew"
  external constraintSetErrorBias : Constraint.t -> float -> unit =
    "caml_cpConstraintSetErrorBias"
  external spaceAddConstraint : Space.t -> Constraint.t -> unit =
    "caml_cpSpaceAddConstraint"
  external bodyGetRotation : Body.t -> Vect.t =
    "caml_cpBodyGetRotation"
  external bodySetAngle : Body.t -> float -> unit =
    "caml_cpBodySetAngle"
  external bodyGetAngle : Body.t -> float =
    "caml_cpBodyGetAngle"
  external bodySetVelocity : Body.t -> Vect.t =
    "caml_cpBodySetVelocity"
  external freeAllSpaceChildren : Space.t -> unit =
    "caml_cpFreeAllSpaceChildren"
end
