#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include "cpshape_stub.h"
#include "cpvect_stub.h"
#include "cpbody_stub.h"

CAMLprim value
caml_cpSegmentShapeNew(value body, value _vec_a, value _vec_b, value radius)
{
    CAMLparam4(body, _vec_a, _vec_b, radius);
    cpVect vec_a;
    cpVect vec_b;
    cpVect_Val(&vec_a, _vec_a);
    cpVect_Val(&vec_b, _vec_b);
    cpShape* shape = cpSegmentShapeNew(cpBody_Val(body), vec_a, vec_b, Double_val(radius));
    if (shape == NULL) caml_failwith("cpSegmentShapeNew");
    CAMLreturn(Val_cpShape(shape));
}


CAMLprim value
caml_cpShapeSetFriction(value shape, value friction)
{
    CAMLparam2(shape, friction);
    cpShapeSetFriction(cpShape_Val(shape), Double_val(friction));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpShapeFree(value shape)
{
    CAMLparam1(shape);
    cpShapeFree(cpShape_Val(shape));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpCircleShapeNew(value body, value radius, value _offset)
{
    CAMLparam3(body, radius, _offset);
    cpVect offset;
    cpVect_Val(&offset, _offset);
    cpShape* circle = cpCircleShapeNew(
      cpBody_Val(body), Double_val(radius), offset);

    if (circle == NULL) caml_failwith("cpCircleShapeNew fail");

    CAMLreturn(Val_cpShape(circle));
}

CAMLprim value
caml_cpBoxShapeNew(value body, value s1, value s2, value s3)
{
    CAMLparam4(body, s1, s2, s3);
    cpShape* box = cpBoxShapeNew(
      cpBody_Val(body), Double_val(s1), Double_val(s2), Double_val(s3));

    if (box == NULL) caml_failwith("cpBoxShapeNew fail");

    CAMLreturn(Val_cpShape(box));
}



CAMLprim value
caml_cpShapeSetElasticity(value shape, value elasticity)
{
    CAMLparam2(shape, elasticity);
    cpShapeSetElasticity(cpShape_Val(shape), Double_val(elasticity));
    CAMLreturn(Val_unit);
}

CAMLprim value
caml_cpShapeSetFilter(value shape, value _filter)
{
    CAMLparam2(shape, _filter);
    cpShapeFilter filter;
    cpShapeFilter_Val(&filter, _filter);
    cpShapeSetFilter(cpShape_Val(shape), filter);
    CAMLreturn(Val_unit);
}





