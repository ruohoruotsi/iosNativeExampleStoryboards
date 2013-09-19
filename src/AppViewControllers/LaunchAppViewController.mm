#import "LaunchAppViewController.h"
// #import "ExampleOFAppViewController.h"
// #import "ExampleOFApp.h"

#import "SquareAppViewController.h"
#import "SquareApp.h"

#import "CircleAppViewController.h"
#import "CircleApp.h"

#import "TriangleAppViewController.h"
#import "TriangleApp.h"

#import "ImageAppViewController.h"
#import "ImageApp.h"


@interface LaunchAppViewController () {}

@end

@implementation LaunchAppViewController

#pragma mark - IB

- (IBAction)launchAppPressed:(id)sender {
    
    // Note we are not creating the ExampleOFAppViewController via storyboards
    // as is requires a custom initilaiser
    
    // create the app
    // ExampleOFApp *exampleOFApp = new ExampleOFApp(); // For the curious, exampleOFApp will be deleted laters

    // create the frame for the app. In this example we create it to
    // be the the same size as the screen and respect this views
    // orientation
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    NSLog(@"IOOoOOOOOOOOOOOOOOOOO HAAAAAAAAAAAAAVOoooooooooooooooc ##########################>>>>>>>");
    // create the app
    // ExampleOFAppViewController *exampleOFAppViewController = [[ExampleOFAppViewController alloc] initWithFrame:frame app:exampleOFApp];
    // add it
    // [self.navigationController pushViewController:exampleOFAppViewController animated:YES];
    
    
    TriangleAppViewController *viewController;
    viewController = [[[TriangleAppViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                   app:new TriangleApp()] autorelease];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationController.navigationBar.topItem.title = @"TriangleApp";
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
