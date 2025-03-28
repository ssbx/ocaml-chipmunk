#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpbody_stub.h"

CAMLprim value
caml_cpBodyFree(value body)
{
    CAMLparam1(body);
    cpBodyFree(cpBody_Val(body));
    CAMLreturn(Val_unit);
}

