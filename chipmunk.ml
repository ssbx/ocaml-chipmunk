
module Space = struct type t = nativeint end
module Body = struct type t = nativeint end
module Shape = struct type t = nativeint end
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


external cpSpaceNew : unit -> Space.t =
  "caml_cpSpaceNew" 
external cpSpaceFree : Space.t -> unit =
  "caml_cpSpaceFree" [@@noalloc]
external cpSpaceSetGravity : Space.t -> Vect.t -> unit =
  "caml_cpSpaceSetGravity" [@@noalloc]
external cpSpaceGetStaticBody : Space.t -> Body.t =
  "caml_cpSpaceGetStaticBody"
external cpBodyFree : Body.t -> unit =
  "caml_cpBodyFree" [@@noalloc]
external cpShapeSetFriction : Shape.t -> float -> unit =
  "caml_cpShapeSetFriction" [@@noalloc]
external cpSegmentShapeNew : Body.t -> Vect.t -> Vect.t -> float -> Shape.t
  = "caml_cpSegmentShapeNew"
external cpShapeFree : Shape.t -> unit =
  "caml_cpShapeFree" [@@noalloc]

(** differ from the original api *)
external cpSpaceAddShape : Space.t -> Shape.t -> unit =
  "caml_cpSpaceAddShape" [@@noalloc]
external cpMomentForCircle : float -> float -> float -> Vect.t -> float
  = "caml_cpMomentForCircle"
external cpBodyNew : float -> float -> Body.t
  = "caml_cpBodyNew"

(** differ from the original api *)
external cpSpaceAddBody : Space.t -> Body.t -> unit =
  "caml_cpSpaceAddBody" [@@noalloc]
external cpBodySetPosition : Body.t -> Vect.t -> unit =
  "caml_cpBodySetPosition" [@@noalloc]
external cpCircleShapeNew : Body.t -> float -> Vect.t -> Shape.t
  = "caml_cpCircleShapeNew"
external cpBodyGetPosition : Body.t -> Vect.t =
  "caml_cpBodyGetPosition"
external cpBodyGetVelocity : Body.t -> Vect.t =
  "caml_cpBodyGetVelocity"
external cpSpaceStep : Space.t -> float -> unit =
  "caml_cpSpaceStep" [@@noalloc]
external cpSpaceSetIterations : Space.t -> int -> unit = 
  "caml_cpSpaceSetIterations" [@@noalloc]
external cpSpaceSetSleepTimeThreshold : Space.t -> float -> unit = 
  "caml_cpSpaceSetSleepTimeThreshold" [@@noalloc]
external cpShapeSetElasticity : Shape.t -> float -> unit = 
  "caml_cpShapeSetElasticity" [@@noalloc]
external cpShapeSetFilter : Shape.t -> ShapeFilter.t -> unit = 
  "caml_cpShapeSetFilter" 
external cpBodyNewKinematic : unit -> Body.t = 
  "caml_cpBodyNewKinematic" 
external cpMomentForBox : float -> float -> float -> float =
  "caml_cpMomentForBox" 
external cpBoxShapeNew : Body.t -> float -> float -> float -> Shape.t =
  "caml_cpBoxShapeNew" 
