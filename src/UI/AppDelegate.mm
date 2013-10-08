//
//  AppDelegate.m
//  Created by lukasz karluk on 12/12/11.
//

#import "AppDelegate.h"

#import "TriangleAppViewController.h"
#import "TriangleApp.h"

#import <DPMusicControllerStatic/BeamMusicPlayerViewController.h>
#import <DPMusicControllerStatic/BeamMinimalExampleProvider.h>
#import <DPMusicControllerStatic/MMDrawerController.h>
#import <DPMusicControllerStatic/MMDrawerBarButtonItem.h>



@implementation AppDelegate

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
    
    
    // Setup OF view controller

    TriangleAppViewController *viewController;
    viewController = [[[TriangleAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                   app:new TriangleApp()] autorelease];
    
    _drawerController = [[MMDrawerController alloc]
                         initWithCenterViewController:_topNavViewController
                         leftDrawerViewController:nil                       // leftSideDrawerViewController
                         rightDrawerViewController:viewController];         // rightSideDrawerViewController
    
    [_drawerController setMaximumRightDrawerWidth:self.window.bounds.size.width]; //200.0;

    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar]; // Pan Nav Bar for OPEN Gesture
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeCustom]; // MMCloseDrawerGestureModePanningDrawerView

    // [_drawerController setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeNavigationBarOnly];
    
    [_drawerController
     setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
         BOOL shouldRecognizeTouch = NO;
         if(drawerController.openSide == MMDrawerSideRight && [gesture isKindOfClass:[UIPanGestureRecognizer class]]){
             
             UIView * customView = drawerController.rightDrawerViewController.view;
             CGPoint location = [touch locationInView:customView];
             printf("(%f, %f)\n", location.x, location.y);
             
             shouldRecognizeTouch = location.y  < 30.0 ? true : false;
             // shouldRecognizeTouch = (CGRectContainsPoint(customView.bounds, location));
         }
         return shouldRecognizeTouch;
     }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:_drawerController];
    
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


#pragma mark - UITabBarController delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSArray *titleArray = @[@"Albums", @"Artists", @"Songs", @"Queue", @"Now Playing", @"Beam"];
    
    if (viewController == [tabBarController.viewControllers objectAtIndex:0] ) {
        
        // DLog(@"Selected 0 \n");
        _topNavViewController.navigationBar.topItem.title = [titleArray objectAtIndex:0];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:1] ) {
        
        // DLog(@"Selected 1 \n");
        _topNavViewController.navigationBar.topItem.title = [titleArray objectAtIndex:1];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:2] ) {
        
        // DLog(@"Selected 2 \n");
        _topNavViewController.navigationBar.topItem.title = [titleArray objectAtIndex:2];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:3] ) {
        
        // DLog(@"Selected 3 \n");
        _topNavViewController.navigationBar.topItem.title = [titleArray objectAtIndex:3];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:4] ) {
        
        // DLog(@"Selected 4 \n");
        _topNavViewController.navigationBar.topItem.title = [titleArray objectAtIndex:4];
    }
    else if (viewController == [tabBarController.viewControllers objectAtIndex:5] ) {
        
        // DLog(@"Selected 5 \n");
        _topNavViewController.navigationBar.topItem.title = [titleArray objectAtIndex:5];
    }
    
    return YES;
}


#pragma mark - MMDrawerController

-(void)rightDrawerButtonPress:(id)sender {
    [_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
