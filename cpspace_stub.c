#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpspace_stub.h"
#include "cpvect_stub.h"
#include "cpbody_stub.h"

CAMLprim value
caml_cpSpaceNew(value unit)
{
    CAMLparam0();
    cpSpace *space = cpSpaceNew();
    if (space == NULL) caml_failwith("cpSpaceNew");

    CAMLreturn(Val_cpSpace(space));
}

CAMLprim value
caml_cpSpaceFree(value space)
{
    CAMLparam1(space);
    cpSpaceFree(cpSpace_Val(space));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceSetGravity(value space, value _vect)
{
    CAMLparam2(space, _vect);
    cpVect gravity;
    cpVect_Val(&gravity, _vect);
    cpSpaceSetGravity(cpSpace_Val(space), gravity);
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceGetStaticBody(value space)
{
    CAMLparam1(space);
    cpBody* body = cpSpaceGetStaticBody(cpSpace_Val(space));
    if (body == NULL) caml_failwith("cpSpaceGetStaticBody");
    CAMLreturn(Val_cpBody(body));
}


