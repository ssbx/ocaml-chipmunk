
/* Copyright (c) 2007 Scott Lembcke
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
 
#include "chipmunk/chipmunk.h"
#include "chipmunk/chipmunk_unsafe.h"

// #include "ChipmunkDemo.h" begin
/* Copyright (c) 2007 Scott Lembcke
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "ChipmunkDebugDraw.h"

typedef struct ChipmunkDemo ChipmunkDemo;

typedef cpSpace *(*ChipmunkDemoInitFunc)(void);
typedef void (*ChipmunkDemoUpdateFunc)(cpSpace *space, double dt);
typedef void (*ChipmunkDemoDrawFunc)(cpSpace *space);
typedef void (*ChipmunkDemoDestroyFunc)(cpSpace *space);

struct ChipmunkDemo {
	const char *name;
	double timestep;
 
	ChipmunkDemoInitFunc initFunc;
	ChipmunkDemoUpdateFunc updateFunc;
	ChipmunkDemoDrawFunc drawFunc;
	
	ChipmunkDemoDestroyFunc destroyFunc;
};

static inline cpFloat
frand(void)
{
	return (cpFloat)rand()/(cpFloat)RAND_MAX;
}

static inline cpVect
frand_unit_circle(){
	cpVect v = cpv(frand()*2.0f - 1.0f, frand()*2.0f - 1.0f);
	return (cpvlengthsq(v) < 1.0f ? v : frand_unit_circle());
}

extern int ChipmunkDemoTicks;
extern double ChipmunkDemoTime;
extern cpVect ChipmunkDemoKeyboard;
extern cpVect ChipmunkDemoMouse;
extern cpBool ChipmunkDemoRightClick;
extern cpBool ChipmunkDemoRightDown;

extern char const *ChipmunkDemoMessageString;
void ChipmunkDemoPrintString(char const *fmt, ...);

extern cpShapeFilter GRAB_FILTER;
extern cpShapeFilter NOT_GRABBABLE_FILTER;

void ChipmunkDemoDefaultDrawImpl(cpSpace *space);
void ChipmunkDemoFreeSpaceChildren(cpSpace *space);

// #include "ChipmunkDemo.h" end





static void
update(cpSpace *space, double dt)
{
	cpSpaceStep(space, dt);
}

static cpSpace *
init(void)
{
	cpSpace *space = cpSpaceNew();
	cpSpaceSetIterations(space, 30);
	cpSpaceSetGravity(space, cpv(0, -100));
	cpSpaceSetSleepTimeThreshold(space, 0.5f);
	cpSpaceSetCollisionSlop(space, 0.5f);
	
	cpBody *body, *staticBody = cpSpaceGetStaticBody(space);
	cpShape *shape;
	
	// Create segments around the edge of the screen.
	shape = cpSpaceAddShape(space, 
      cpSegmentShapeNew(staticBody, cpv(-320,-240), cpv(-320,240), 0.0f));
	cpShapeSetElasticity(shape, 1.0f);
	cpShapeSetFriction(shape, 1.0f);
	cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER);

	shape = cpSpaceAddShape(space, 
      cpSegmentShapeNew(staticBody, cpv(320,-240), cpv(320,240), 0.0f));
	cpShapeSetElasticity(shape, 1.0f);
	cpShapeSetFriction(shape, 1.0f);
	cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER);

	shape = cpSpaceAddShape(space, 
      cpSegmentShapeNew(staticBody, cpv(-320,-240), cpv(320,-240), 0.0f));
	cpShapeSetElasticity(shape, 1.0f);
	cpShapeSetFriction(shape, 1.0f);
	cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER);
	
	// Add lots of boxes.
	for(int i=0; i<14; i++){
		for(int j=0; j<=i; j++){
			body = cpSpaceAddBody(space, 
          cpBodyNew(1.0f, cpMomentForBox(1.0f, 30.0f, 30.0f)));
			cpBodySetPosition(body, cpv(j*32 - i*16, 300 - i*32));
			
			shape = cpSpaceAddShape(space, cpBoxShapeNew(body, 30.0f, 30.0f, 0.5f));
			cpShapeSetElasticity(shape, 0.0f);
			cpShapeSetFriction(shape, 0.8f);
		}
	}
	
	// Add a ball to make things more interesting
	cpFloat radius = 15.0f;
	body = cpSpaceAddBody(space, 
      cpBodyNew(10.0f, cpMomentForCircle(10.0f, 0.0f, radius, cpvzero)));
	cpBodySetPosition(body, cpv(0, -240 + radius+5));

	shape = cpSpaceAddShape(space, cpCircleShapeNew(body, radius, cpvzero));
	cpShapeSetElasticity(shape, 0.0f);
	cpShapeSetFriction(shape, 0.9f);
	
	return space;
}

static void
destroy(cpSpace *space)
{
	ChipmunkDemoFreeSpaceChildren(space);
	cpSpaceFree(space);
}

ChipmunkDemo PyramidStack = {
	"Pyramid Stack",
	1.0/180.0,
	init,
	update,
	ChipmunkDemoDefaultDrawImpl,
	destroy,
};

