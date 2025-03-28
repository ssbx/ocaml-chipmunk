#ifndef _OCAML_CHIPMUNK
#define _OCAML_CHIPMUNK

#define cpVect_Val(c, v) \
    (c)->x = Double_field(v,0); \
    (c)->y = Double_field(v,1)

#define Val_cpVect(ret, c) \
    ret = caml_alloc(2 * sizeof(double), 0); \
    Store_double_field(ret, 0, ((c)->x)); \
    Store_double_field(ret, 1, ((c)->y))

#endif /* _OCAML_CHIPMUNK */
