#ifndef _CAML_CHIPMUNK_PIVOT_JOINT_
#define _CAML_CHIPMUNK_PIVOT_JOINT_

#include <chipmunk/chipmunk.h>

static value
Val_cpPivotJoint(cpPivotJoint * p)
{
    return caml_copy_nativeint((intnat) p);
}

static cpPivotJoint*
cpPivotJoint_Val(value v)
{
    return (cpPivotJoint *) Nativeint_val(v);
}

#endif /* _CAML_CHIPMUNK_PIVOT_JOINT_ */
