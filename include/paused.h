#ifndef _S_PAUSED
#define _S_PAUSED

#include "globals.h"
#include "ttfonts.h"
#include "gui.h"
#include "mainmenu.h"

struct SPaused {
    SApp *App;
    int Position;
    GLuint texture;
};
typedef struct SPaused SPaused;


/*--- INITIALIZATION ---*/
/* public         */ void SPaused_Init(SApp *);
/* static private */ void SPaused_InitGraphics(void);

/*--- LOGICS ---*/
/* public         */ void SPaused_Loop(SApp *);

/*--- EVENT PROCESSING --- */
/* private        */ void SPaused_OnKeyDown(SApp *, SDLKey);
/* public         */ void SPaused_ProcessEvent(SApp *, SDL_Event *);
/* private        */ void SPaused_ProcessNewState(SApp *);

/*--- GRAPHICS ---*/
/* public         */ void SPaused_Render(SApp *);

/*--- OpenGL Drawing ---*/
/* static         */ void SPaused_Cube(int, int, int);
/* static         */ void SPaused_Grid(void);

/*--- Sound and music! ---*/
/* private         */ void SPaused_InitSound(SApp *);
/* public          */ void SPaused_Cleanup(SApp *);

/* constructor     */ void SPaused_Create(SApp *);
/* destructor      */ void SPaused_Delete(SApp *);

/* switcher        */ void SPaused_Switch(SApp *);

#endif
