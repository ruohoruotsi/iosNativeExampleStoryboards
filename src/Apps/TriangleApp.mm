#include "TriangleApp.h"

//--------------------------------------------------------------
TriangleApp :: TriangleApp () {
    cout << "creating TriangleApp" << endl;
}

//--------------------------------------------------------------
TriangleApp :: ~TriangleApp () {
    cout << "destroying TriangleApp" << endl;
}

//--------------------------------------------------------------
void TriangleApp::setup() {
    
    ofSetVerticalSync(true);
    ofEnableAlphaBlending();
    ofSetCircleResolution(100);
    ofEnableSmoothing();
    
    ofSetFullscreen(true);
}

//--------------------------------------------------------------
void TriangleApp::update(){

    float xorig = ofGetWidth()*0.5;
	float yorig = ofGetHeight()*0.5;
	
	for (int i = 0; i < TOTAL_PARTICLES; i++)
    {
		float radius = 50 + i * 20;
		float angle = ofGetElapsedTimef() * (1 + i / 20.0);
        
		float x = xorig + radius * cos(angle* ofMap(ofGetMouseX(),0,ofGetScreenWidth(),0.0,1.0));
		float y = yorig + radius * -sin(angle* ofMap(ofGetMouseY(),0,ofGetScreenHeight(),0.0,1.0));
		
		particles[i].moveTo(x,y);
	}
    
    ofSetWindowTitle(ofToString(ofGetFrameRate()));
}

//--------------------------------------------------------------
void TriangleApp::draw() {

    ofBackground(0);
    
    float sinSwitcher = abs(sin(ofGetElapsedTimef()*0.1));
    
    if (!ofGetMousePressed()){
        drawParticlesLine((1.0-sinSwitcher)*0.8);
    }
    
    for (int i = 0; i < TOTAL_PARTICLES; i++)
    {
        if (!ofGetMousePressed())
        {
            particles[i].drawTrail(sinSwitcher*0.5);
        }
        
        int closest = 10000;
        for ( int j = 0; j < TOTAL_PARTICLES; j++)
        {
            if (i != j)
            {
                int dist = particles[i].distance(particles[j]);
                
                if (dist < closest){
                    closest = dist;
                }
                
                if ((dist < 100) && ofGetMousePressed()){
                    ofSetColor(255, ofMap(closest,0,100,100,0,true) );
                    ofLine(particles[i], particles[j]);
                }
            }
        }
        
        particles[i].drawDot( ofMap(closest,0,100,1.0,0.0,true) );
    }
}

//--------------------------------------------------------------
void TriangleApp::drawParticlesLine(float _alpha)
{
    ofPolyline macroLine;
    macroLine.addVertex(particles[0]);
    for (int i = 0 ; i < TOTAL_PARTICLES ; i++)
    {
        macroLine.curveTo(particles[i]);
    }
    macroLine.curveTo(particles[TOTAL_PARTICLES-1]);
    macroLine = macroLine.getResampledByCount( 1000 );
    
    ofSetColor(255);
    ofMesh lineMesh;
    lineMesh.setMode(OF_PRIMITIVE_LINE_STRIP);
    for (int i = 0 ; i < macroLine.getVertices().size() ; i++)
    {
        lineMesh.addColor(ofFloatColor(1.0, _alpha));
        lineMesh.addVertex(macroLine.getVertices()[i]);
    }
    ofSetColor(255);
    lineMesh.draw();
}

//--------------------------------------------------------------
void TriangleApp::exit() {
    //
}

//--------------------------------------------------------------
void TriangleApp::touchDown(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void TriangleApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void TriangleApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void TriangleApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void TriangleApp::lostFocus(){

}

//--------------------------------------------------------------
void TriangleApp::gotFocus(){

}

//--------------------------------------------------------------
void TriangleApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void TriangleApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void TriangleApp::touchCancelled(ofTouchEventArgs& args){

}

