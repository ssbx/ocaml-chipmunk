#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cppivotjoint_stub.h"
#include "cpconstraint_stub.h"
#include "cpvect_stub.h"
#include "cpbody_stub.h"

CAMLprim value
caml_cpPivotJointNew2(
  value body_a, value body_b, value _anchor_a, value _anchor_b)
{
    CAMLparam4(body_a, body_a, _anchor_a, _anchor_b);
    cpVect anchor_a;
    cpVect anchor_b;
    cpVect_Val(&anchor_a, _anchor_a);
    cpVect_Val(&anchor_b, _anchor_b);
    cpConstraint* c = cpPivotJointNew2(
      cpBody_Val(body_a), cpBody_Val(body_b), anchor_a, anchor_b);
    if (c == NULL) caml_failwith("cpPivotJointNew2");
    CAMLreturn(Val_cpConstraint(c));
}

