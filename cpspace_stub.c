#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpspace_stub.h"
#include "cpconstraint_stub.h"
#include "cpvect_stub.h"
#include "cpbody_stub.h"
#include "cpshape_stub.h"

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
caml_cpSpaceSetGravity_unbox(cpSpace* space, double x, double y)
{
    cpVect gravity = cpv(x,y);
    cpSpaceSetGravity(space, gravity);
}

CAMLprim value
caml_cpSpaceGetStaticBody(value space)
{
    CAMLparam1(space);
    cpBody* body = cpSpaceGetStaticBody(cpSpace_Val(space));
    CAMLreturn(Val_cpBody(body));
}

CAMLprim value
caml_cpSpaceAddShape(value space, value shape)
{
    CAMLparam2(space, shape);
    cpSpaceAddShape(cpSpace_Val(space), cpShape_Val(shape));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceAddBody(value space, value body)
{
    CAMLparam2(space, body);
    cpSpaceAddBody(cpSpace_Val(space), cpBody_Val(body));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceStep(value space, value dt)
{
    CAMLparam2(space, dt);
    cpSpaceStep(cpSpace_Val(space), Double_val(dt));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceSetIterations(value space, value num)
{
    CAMLparam2(space, num);
    cpSpaceSetIterations(cpSpace_Val(space), Int_val(num));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceSetSleepTimeThreshold(value space, value thresh)
{
    CAMLparam2(space, thresh);
    cpSpaceSetSleepTimeThreshold(cpSpace_Val(space), Double_val(thresh));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceAddConstraint(value space, value constraint)
{
    CAMLparam2(space, constraint);
    cpSpaceAddConstraint(cpSpace_Val(space), cpConstraint_Val(constraint));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpSpaceUseSpatialHash(value space, value dim, value count)
{
    CAMLparam3(space, dim, count);
    cpSpaceUseSpatialHash(cpSpace_Val(space), Double_val(dim), Int_val(count));
    CAMLreturn(Val_unit);
}


