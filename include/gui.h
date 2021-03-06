#ifndef _S_GUI
#define _S_GUI

#include "globals.h"
#include "targa.h"
#include "ttfonts.h"

#include <stdio.h>
#include <stdlib.h>

#include <GL/gl.h>

struct STexture {
    int size;
    char bitsPerPixel; 
    GLuint texID;
};
typedef struct STexture STexture;

struct SLabel {
    int x, y, width, height;
    STexture texture;
};
typedef struct SLabel SLabel;

struct SButton {
    SApp *App;
    int x, y, width, height;
    STexture texture;
    int selected;
    struct SButton *next, *prev;
    void (*callback)(SApp *);
    char *text;
};
typedef struct SButton SButton;
    
/*--- Textures! ---*/
int STexture_Load(STexture *, char *filename);
void STexture_Unload(STexture *);

/*--- Widgets! ---*/
SButton * SButton_Create(SApp *);
void SButton_Set(SButton *self, int x, int y, int w, int h);
void SButton_Delete(SButton *self);
void SButton_SetTexture(SButton *self, char *filename);
void SButton_Render(SButton *self);
int SButton_Swap(SButton *self); /* Swaps state and returns new value */
/*static */ void SButton_Link(SButton *prev, SButton *next);
void SButton_SetCallback(SButton *self, void (*pointer)(SApp *));
void SButton_Call(SButton *self, SApp *);
void SButton_DefaultCallback(SApp *);
void SButton_SetText(SButton *self, const char *text);

SLabel * SLabel_Create(void);
void SLabel_Set(SLabel *self, int x, int y, int w, int h);
void SLabel_Delete(SLabel *self);
void SLabel_SetTexture(SLabel *self, char *filename);
void SLabel_Render(SLabel *self);


#endif /* ifndef _S_GUI */
