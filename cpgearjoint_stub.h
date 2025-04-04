#ifndef _CAML_CHIPMUNK_GEAR_JOINT_
#define _CAML_CHIPMUNK_GEAR_JOINT_

#include <chipmunk/chipmunk.h>

static value
Val_cpGearJoint(cpGearJoint * p)
{
    return caml_copy_nativeint((intnat) p);
}

static cpGearJoint*
cpGearJoint_Val(value v)
{
    return (cpGearJoint *) Nativeint_val(v);
}

#endif /* _CAML_CHIPMUNK_GEAR_JOINT_ */
