//
//  MyAppDelegate.h
//  Created by lukasz karluk on 12/12/11.
//

#import "ofxiOSAppDelegate.h"

@class BeamMusicPlayerViewController;
@class BeamMinimalExampleProvider;
@class MMDrawerController;


@interface MyAppDelegate : ofxiOSAppDelegate  <UITabBarControllerDelegate>
{
    //
}

// @property (nonatomic, retain) UINavigationController* navigationController;

@property (strong, nonatomic) MMDrawerController* drawerController;

@property (strong, nonatomic) BeamMinimalExampleProvider *provider;
@property (strong, nonatomic) UINavigationController *topNavViewController;

@property (strong, nonatomic) BeamMusicPlayerViewController* beamAppVC;


@end
