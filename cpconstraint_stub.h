#ifndef _CAML_CHIPMUNK_CONSTRAINT_
#define _CAML_CHIPMUNK_CONSTRAINT_

#include <chipmunk/chipmunk.h>

static value
Val_cpConstraint(cpConstraint * p)
{
    return caml_copy_nativeint((intnat) p);
}

static cpConstraint*
cpConstraint_Val(value v)
{
    return (cpConstraint *) Nativeint_val(v);
}

#endif /* _CAML_CHIPMUNK_CONSTRAINT_ */
