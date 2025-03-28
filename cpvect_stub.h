#ifndef _OCAML_CHIPMUNK
#define _OCAML_CHIPMUNK

#define cpVect_Val(c, v) \
    (c)->x = Long_val(Field(v,0)); \
    (c)->y = Long_val(Field(v,1))

#define Val_cpVect(ret, c) \
    ret = caml_alloc(2, 0); \
    Store_field(ret, 0, Val_long((c)->x)); \
    Store_field(ret, 1, Val_long((c)->y))

#endif /* _OCAML_CHIPMUNK */
