
module Space = struct type t = nativeint end
module Body = struct type t = nativeint end
module Shape = struct type t = nativeint end

module Vect = struct
  type t =
    { x : float
    ; y : float }

  let zero = ({ x = 0.; y = 0. } : t)

  let make ~x ~y = {x; y}
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

