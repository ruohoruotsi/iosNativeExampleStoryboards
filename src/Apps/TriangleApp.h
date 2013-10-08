#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "Particle.h"

#define TOTAL_PARTICLES 50


class TriangleApp : public ofxiOSApp {
	
public:
    
     TriangleApp ();
    ~TriangleApp ();
    
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);

    void drawParticlesLine(float _alpha);
    
    ofSoundPlayer       song;
    Particle           particles[TOTAL_PARTICLES];
};


