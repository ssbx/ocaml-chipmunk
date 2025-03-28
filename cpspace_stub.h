#ifndef _CAML_CHIPMUNK_SPACE_
#define _CAML_CHIPMUNK_SPACE_

#include <chipmunk/chipmunk.h>

static value Val_cpSpace(cpSpace * p)
{
    return caml_copy_nativeint((intnat) p);
}

static cpSpace * cpSpace_Val(value v)
{
    return (cpSpace *) Nativeint_val(v);
}

#endif /* _CAML_CHIPMUNK_SPACE_ */
