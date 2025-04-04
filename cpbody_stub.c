#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpbody_stub.h"
#include "cpvect_stub.h"


CAMLprim value
caml_cpBodyNew(value mass, value moment)
{
    CAMLparam2(mass, moment);
    cpBody* body = cpBodyNew(Double_val(mass), Double_val(moment));
    if (body == NULL) caml_failwith("cpBodyNew fails");
    CAMLreturn(Val_cpBody(body));
}

CAMLprim value
caml_cpBodyFree(value body)
{
    CAMLparam1(body);
    cpBodyFree(cpBody_Val(body));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpBodySetPosition(value body, value _pos)
{
    CAMLparam2(body, _pos);
    cpVect pos;
    cpVect_Val(&pos, _pos);
    cpBodySetPosition(cpBody_Val(body), pos);
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpBodyGetPosition(value body)
{
    CAMLparam1(body);
    CAMLlocal1(ret);
    cpVect pos = cpBodyGetPosition(cpBody_Val(body));
    Val_cpVect(ret, &pos);
    CAMLreturn(ret);
}

CAMLprim value
caml_cpBodyGetVelocity(value body)
{
    CAMLparam1(body);
    CAMLlocal1(ret);
    cpVect vel = cpBodyGetVelocity(cpBody_Val(body));
    Val_cpVect(ret, &vel);
    CAMLreturn(ret);
}

CAMLprim value
caml_cpBodyGetRotation(value body)
{
    CAMLparam1(body);
    CAMLlocal1(ret);
    cpVect vel = cpBodyGetRotation(cpBody_Val(body));
    Val_cpVect(ret, &vel);
    CAMLreturn(ret);
}

CAMLprim value
caml_cpBodyNewKinematic(value unit)
{
    CAMLparam1(unit);
    cpBody* body = cpBodyNewKinematic();
    if (body == NULL) caml_failwith("cpBodyNewKinematic fails");
    CAMLreturn(Val_cpBody(body));
}

CAMLprim value
caml_cpBodySetAngle(value body, value angle)
{
    CAMLparam2(body, angle);
    cpBodySetAngle(cpBody_Val(body), Double_val(angle));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpBodyGetAngle(value body)
{
    CAMLparam1(body);
    double a = cpBodyGetAngle(cpBody_Val(body));
    return caml_copy_double(a);
}

CAMLprim value
caml_cpBodySetVelocity(value body, value _vel)
{
    CAMLparam2(body, _vel);
    cpVect vel;
    cpVect_Val(&vel, _vel);
    cpBodySetVelocity(cpBody_Val(body), vel);
    CAMLreturn(Val_unit);
}







