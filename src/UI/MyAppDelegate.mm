//
//  MyAppDelegate.m
//  Created by lukasz karluk on 12/12/11.
//

#import "MyAppDelegate.h"
#import "MyAppViewController.h"

#import <DPMusicControllerStatic/BeamMusicPlayerViewController.h>
#import <DPMusicControllerStatic/BeamMinimalExampleProvider.h>
#import <DPMusicControllerStatic/MMDrawerController.h>
#import <DPMusicControllerStatic/MMDrawerBarButtonItem.h>


@implementation MyAppDelegate

// @synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // [super applicationDidFinishLaunching:application];
    
    /**
     *
     *  Below is where you insert your own UIViewController and take control of the App.
     *  In this example im creating a UINavigationController and adding it as my RootViewController to the window. (this is essential)
     *  UINavigationController is handy for managing the navigation between multiple view controllers, more info here,
     *  http://developer.apple.com/library/ios/#documentation/uikit/reference/UINavigationController_Class/Reference/Reference.html
     *
     *  I then push MyAppViewController onto the UINavigationController stack.
     *  MyAppViewController is a custom view controller with a 3 button menu.
     *
     **/

#if 0  // IOHAVOC -- turn this off since we are using Storyboards .. original comments above from the non-storyboard iosNativeExample
    
    self.navigationController = [[[UINavigationController alloc] init] autorelease];
    [self.window setRootViewController:self.navigationController];
    
    [self.navigationController pushViewController:[[[MyAppViewController alloc] init] autorelease]
                                         animated:YES];
    
    //--- style the UINavigationController
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.topItem.title = @"Home";

#endif
    
    
#if 1
    
    
    _beamAppVC = nil;
    _topNavViewController = (UINavigationController *)self.window.rootViewController;
    _topNavViewController.navigationBar.topItem.title = @"Albums"; // Initial view
    
    // Are there subviews
    if (_topNavViewController.viewControllers) {                                    // top level navigation
        
        // tabbar should be the only element in this top array
        for (UITabBarController *tabBar in _topNavViewController.viewControllers) { // tabbar
            
            tabBar.delegate = self;                                                 // Assign DPMAppDelegate (self) to be the delegate
            
            // Iterate through tabbar sub viewControllers
            for (UINavigationController *vc in tabBar.viewControllers) {
                
                if ([vc isKindOfClass:[BeamMusicPlayerViewController class]])
                    _beamAppVC = (BeamMusicPlayerViewController*) vc;
            }
        }
    }
    
    // if we found the VC, then setup the delegate & datasource
    if (_beamAppVC) {
        
        _provider = [BeamMinimalExampleProvider new];
        
        _beamAppVC.delegate = _provider;
        _beamAppVC.dataSource= _provider;
    }
    
    
    
    MMDrawerController* drawerController = [[MMDrawerController alloc]
                                            initWithCenterViewController:_topNavViewController
                                            leftDrawerViewController:nil    // leftSideDrawerViewController
                                            rightDrawerViewController:nil]; //rightSideDrawerViewController];
    [drawerController setMaximumRightDrawerWidth:200.0];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:drawerController];
    
    
    // Setup Right Button
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [_topNavViewController.navigationBar.topItem setRightBarButtonItem:rightDrawerButton animated:YES];
    
#endif
    
    return YES;
}

- (void) dealloc {
    // self.navigationController = nil;
    [super dealloc];
}

@end
