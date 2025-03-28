
module Space = struct type t end
module Body = struct type t end
module Shape = struct type t end

module Vect = struct
  type t =
    { x : float
    ; y : float }

  let make ~x ~y = {x; y}
end

external cpSpaceNew : unit -> Space.t = "caml_cpSpaceNew"
external cpSpaceFree : Space.t -> unit = "caml_cpSpaceFree"
external cpSpaceSetGravity : Space.t -> Vect.t -> unit = "caml_cpSpaceSetGravity"
external cpSpaceGetStaticBody : Space.t -> Shape.t = "caml_cpSpaceGetStaticBody"
external cpBodyFree : Body.t -> unit = "caml_cpBodyFree"

