#ifndef _CAML_CHIPMUNK_BODY_
#define _CAML_CHIPMUNK_BODY_

#include <chipmunk/chipmunk.h>

static value Val_cpBody(cpBody * p)
{
    return caml_copy_nativeint((intnat) p);
}

static cpBody * cpBody_Val(value v)
{
    return (cpBody *) Nativeint_val(v);
}

#endif /* _CAML_CHIPMUNK_BODY_ */
