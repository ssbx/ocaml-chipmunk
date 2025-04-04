#ifndef _CAML_CHIPMUNK_SHAPE_
#define _CAML_CHIPMUNK_SHAPE_

#include <chipmunk/chipmunk.h>

static value Val_cpShape(cpShape * p)
{
    return caml_copy_nativeint((intnat) p);
}

static cpShape * cpShape_Val(value v)
{
    return (cpShape *) Nativeint_val(v);
}

#define cpShapeFilter_Val(r, v) \
  (r)->group      = Int_val(Field(v, 0)); \
  (r)->categories = Int_val(Field(v, 1)); \
  (r)->mask       = Int_val(Field(v, 2))

#define Val_cpShapeFilter(ret, r) \
  ret = caml_alloc(4,0); \
  Store_field(ret, 0, Val_int((r)->group)); \
  Store_field(ret, 1, Val_int((r)->categories)); \
  Store_field(ret, 2, Val_int((r)->mask))
#endif /* _CAML_CHIPMUNK_SHAPE_ */
