#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include <chipmunk/chipmunk.h>

#include "cpvect_stub.h"
#include "cpspace_stub.h"

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

static void utils_shape_free_wrap(
              cpSpace *space, cpShape *shape, void *unused) {
  cpSpaceRemoveShape(space, shape);
  cpShapeFree(shape); }
static void utils_post_shape_free(cpShape *shape, cpSpace *space) {
  cpSpaceAddPostStepCallback(space,
    (cpPostStepFunc)utils_shape_free_wrap, shape, NULL);}
static void utils_constraint_free_wrap(
              cpSpace *space, cpConstraint *constraint, void *unused) {
  cpSpaceRemoveConstraint(space, constraint);
  cpConstraintFree(constraint);}
static void utils_post_constraint_free(
              cpConstraint *constraint, cpSpace *space) {
  cpSpaceAddPostStepCallback(space,
    (cpPostStepFunc)utils_constraint_free_wrap, constraint, NULL); }
static void utils_body_free_wrap(
              cpSpace *space, cpBody *body, void *unused) {
  cpSpaceRemoveBody(space, body);
  cpBodyFree(body);}
static void utils_post_body_free(cpBody *body, cpSpace *space) {
  cpSpaceAddPostStepCallback(space,
    (cpPostStepFunc)utils_body_free_wrap, body, NULL);}
CAMLprim value caml_cpFreeAllSpaceChildren(value _space) {
    CAMLparam1(_space);
    cpSpace *space = cpSpace_Val(_space);
    cpSpaceEachShape(space,
      (cpSpaceShapeIteratorFunc)utils_post_shape_free, space);
    cpSpaceEachConstraint(space,
      (cpSpaceConstraintIteratorFunc)utils_post_constraint_free, space);
    cpSpaceEachBody(space,
      (cpSpaceBodyIteratorFunc)utils_post_body_free, space);
    CAMLreturn(Val_unit);
}
