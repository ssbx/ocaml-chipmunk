#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpconstraint_stub.h"
#include "cpvect_stub.h"
#include "cpbody_stub.h"

CAMLprim value
caml_cpConstraintSetMaxForce(value constraint, value max_force)
{
    CAMLparam2(constraint, max_force);
    cpConstraintSetMaxForce(cpConstraint_Val(constraint), Double_val(max_force));
    CAMLreturn(Val_unit);
}


CAMLprim value
caml_cpConstraintSetMaxBias(value constraint, value max_bias)
{
    CAMLparam2(constraint, max_bias);
    cpConstraintSetMaxBias(cpConstraint_Val(constraint), Double_val(max_bias));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpConstraintSetErrorBias(value constraint, value error_bias)
{
    CAMLparam2(constraint, error_bias);
    cpConstraintSetErrorBias(cpConstraint_Val(constraint), Double_val(error_bias));
    CAMLreturn(Val_unit);
}


