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

#endif /* _CAML_CHIPMUNK_SHAPE_ */
