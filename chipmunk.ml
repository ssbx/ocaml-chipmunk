
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

external cpSpaceNew : unit -> (Space.t [@unboxed]) =
  "caml_cpSpaceNew_byte" "caml_cpSpaceNew" [@@noalloc]
external cpSpaceFree : (Space.t [@unboxed]) -> unit =
  "caml_cpSpaceFree_byte" "caml_cpSpaceFree" [@@noalloc]

(* TODO test benefices *)
external cpSpaceSetGravity : Space.t -> Vect.t -> unit =
  "caml_cpSpaceSetGravity"
external cpSpaceSetGravity_unbox :
  (Space.t [@unboxed]) -> (float [@unboxed]) -> (float [@unboxed]) -> unit =
  "caml_cpSpaceSetGravity_byte_unbox" "caml_cpSpaceSetGravity_unbox" [@@noalloc]

let cpSpaceSetGravity2 space (v : Vect.t) =
  cpSpaceSetGravity_unbox space v.x v.y

external cpSpaceGetStaticBody : Space.t -> Body.t =
  "caml_cpSpaceGetStaticBody"
external cpBodyFree : Body.t -> unit =
  "caml_cpBodyFree"
external cpShapeSetFriction : Shape.t -> float -> unit =
  "caml_cpShapeSetFriction"
external cpSegmentShapeNew : Body.t -> Vect.t -> Vect.t -> float -> Shape.t
  = "caml_cpSegmentShapeNew"
external cpShapeFree : Shape.t -> unit =
  "caml_cpShapeFree"

(** differ from the original api *)
external cpSpaceAddShape : Space.t -> Shape.t -> unit =
  "caml_cpSpaceAddShape"

external cpMomentForCircle : float -> float -> float -> Vect.t -> float
  = "caml_cpMomentForCircle"
external cpBodyNew : float -> float -> Body.t
  = "caml_cpBodyNew"

(** differ from the original api *)
external cpSpaceAddBody : Space.t -> Body.t -> unit =
  "caml_cpSpaceAddBody"
external cpBodySetPosition : Body.t -> Vect.t -> unit =
  "caml_cpBodySetPosition"
external cpCircleShapeNew : Body.t -> float -> Vect.t -> Shape.t
  = "caml_cpCircleShapeNew"
external cpBodyGetPosition : Body.t -> Vect.t =
  "caml_cpBodyGetPosition"
external cpBodyGetVelocity : Body.t -> Vect.t =
  "caml_cpBodyGetVelocity"
external cpSpaceStep : Space.t -> float -> unit =
  "caml_cpSpaceStep"

