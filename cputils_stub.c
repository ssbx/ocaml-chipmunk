#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include <chipmunk/chipmunk.h>

#include "cpvect_stub.h"

CAMLprim value
caml_cpMomentForCircle(value m, value r1, value r2, value _offset)
{
    CAMLparam4(m, r1, r2, _offset);
    cpVect offset;
    cpVect_Val(&offset, _offset);
    cpFloat r = cpMomentForCircle(
      Double_val(m),
      Double_val(r1),
      Double_val(r2),
      offset);

    return caml_copy_double(r);
}

CAMLprim value
caml_cpMomentForBox(value mass, value v1, value v2)
{
    CAMLparam3(mass, v1, v2);
    float r = cpMomentForBox(Double_val(mass), Double_val(v1), Double_val(v2));
    return caml_copy_double(r);
}
