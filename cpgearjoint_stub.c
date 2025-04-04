#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpgearjoint_stub.h"
#include "cpconstraint_stub.h"
#include "cpbody_stub.h"
#include "cpvect_stub.h"

CAMLprim value
caml_cpGearJointNew(
  value body_a, value body_b, value phase, value ratio)
{
    CAMLparam4(body_a, body_a, phase, ratio);
    cpConstraint* c = cpGearJointNew(
      cpBody_Val(body_a), cpBody_Val(body_b), Double_val(phase), Double_val(ratio));
    if (c == NULL) caml_failwith("cpGearJointNew");
    CAMLreturn(Val_cpConstraint(c));
}

