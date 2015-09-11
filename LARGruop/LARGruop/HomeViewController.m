//
//  HomeViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "HomeViewController.h"
#import "MapViewController.h"
#import "ProyectsViewController.h"
#import "NewCustomerViewController.h"
#import "TopBarViewController.h"
#import "FilterViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *containerSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *filterContainerView;
@property (weak, nonatomic) IBOutlet UIView *containterSegmentedControlView;
@property (weak, nonatomic) IBOutlet UIView *topbarContainerView;
@property BOOL isShowFilter;
@end
@implementation HomeViewController
{
    UIView *dimBackgroundView;
}
#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self setupViews];
    [self setupVars];
    [self setupNotifications];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    self.containerSegmentedControl.selectedSegmentIndex = 0;
    [[UITabBar appearance] setTintColor:[UIColor orangeLARColor]];
}

-(void)setupVars
{
    self.isShowFilter=false;
}

-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyFilters:)
                                                 name:kNotificationApplyFilters object:nil];
}


#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)tapSelected:(UISegmentedControl *)sender {
    
    UIViewController* destinationVC;
    UIViewController* currentVC = [self getCurrentViewController];
    switch (sender.selectedSegmentIndex) {
        case 0:
            destinationVC = (MapViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
            break;
        case 1:
            destinationVC = (ProyectsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ProyectsViewController"];
            break;
            
        default:
            destinationVC = (MapViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
            break;
    }
    [self setViewControllerChildWith:destinationVC from:currentVC];
}

#pragma mark -
#pragma mark - Actions
#pragma mark - 

-(void)setViewControllerChildWith:(UIViewController*)newChildViewController from:(UIViewController*)fromViewController
{
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:newChildViewController];
    [self transitionFromViewController:fromViewController toViewController:newChildViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^
     {
         [fromViewController removeFromParentViewController];
         [newChildViewController didMoveToParentViewController:self];
     } completion:nil];
}

-(UIViewController*)getCurrentViewController
{
    UIViewController* fromVC;
    for (UIViewController*  vc in self.childViewControllers)
    {
        if([vc isKindOfClass:[MapViewController class]] || [vc isKindOfClass:[ProyectsViewController class]])
            fromVC =vc;
        
    }
    return fromVC;
}

-(void)setupIteractionDisableOnFilterShow
{
    if(!self.isShowFilter)
    {
        self.topbarContainerView.userInteractionEnabled=false;
        self.containerView.userInteractionEnabled=false;
        self.containterSegmentedControlView.userInteractionEnabled=false;
        [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width-self.filterContainerView.bounds.size.width, self.view.bounds.size.height);
        dimBackgroundView = [[UIView alloc] initWithFrame:frame];
        dimBackgroundView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.5f];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDisabledFilterTapBehind:)];
        [recognizer setNumberOfTapsRequired:1];
        recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
        [dimBackgroundView addGestureRecognizer:recognizer];
        recognizer.delegate = self;
        
        [self.view addSubview:dimBackgroundView];

    }
    else
    {
        self.topbarContainerView.userInteractionEnabled=true;
        self.containerView.userInteractionEnabled=true;
        self.containterSegmentedControlView.userInteractionEnabled=true;
        [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        
        [dimBackgroundView removeFromSuperview];
        NSDictionary *userInfo = @{NOTIFICATION_SENDER: HOME_SENDER, FILTER_MODE: @false};
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDismissFilterWithoutApply object:self userInfo:userInfo];

    }
}

- (void)handleDisabledFilterTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded && self.isShowFilter) {
        
        // passing nil gives us coordinates in the window
        CGPoint location = [sender locationInView:nil];
        
        // swap (x,y) on iOS 8 in landscape
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                location = CGPointMake(location.y, location.x);
            }
        }
        
        // convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
        CGPoint convertedLoc = [self.filterContainerView convertPoint:location fromView:self.filterContainerView.window] ;
        if (![self.filterContainerView pointInside:convertedLoc withEvent:nil]) {
            
            // remove the recognizer first so it's view.window is valid
            [dimBackgroundView.window removeGestureRecognizer:sender];
            [self showFilterViewController];
        }
    }
}

-(void)applyFilters:(NSNotification *)notification
{
    [self showFilterViewController];
}

#pragma mark -
#pragma mark - Gesture Recognizer Delegate
#pragma mark -

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

#pragma mark -
#pragma mark - Top Bar Delegate
#pragma mark -

- (void)showAddCustomerViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewCustomerViewController *newCustomerViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewCustomerViewController"];
    
    newCustomerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:newCustomerViewController animated:YES completion:nil];
    
    CGSize temporalPopoverSize = CGSizeMake(450.0f, 540.0f);
    [newCustomerViewController setPopOverViewSize:temporalPopoverSize];
}

- (void)showFilterViewController
{
    if(!self.isShowFilter)
    {
        CGRect frame = self.filterContainerView.frame;
        float x = frame.origin.x;
        if(x==self.view.frame.size.width)
        {
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
             {
                 CGRect frame = self.filterContainerView.frame;
                 frame.origin.x = frame.origin.x+frame.size.width*(-1);
                 self.filterContainerView.frame = frame;
             }
                             completion:^(BOOL finished)
             {
                 [self setupIteractionDisableOnFilterShow];
                 self.isShowFilter = TRUE;
             } ];
            
            self.filterContainerView.translatesAutoresizingMaskIntoConstraints = YES;
        }

    }
    else
    {
        CGRect frame = self.filterContainerView.frame;
        float x = frame.origin.x;
        if(x<self.view.frame.size.width)
        {
            [self setupIteractionDisableOnFilterShow];
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
             {
                 CGRect frame = self.filterContainerView.frame;
                 frame.origin.x = frame.origin.x+frame.size.width;
                 self.filterContainerView.frame = frame;
             }
                             completion:^(BOOL finished)
             {
                 self.isShowFilter = false;
             } ];
            
            self.filterContainerView.translatesAutoresizingMaskIntoConstraints = YES;
        }

    }

    

}

- (void)showSearch
{
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[TopBarViewController class]])
    {
        ((TopBarViewController*)segue.destinationViewController).delegate = self;
        ((TopBarViewController*)segue.destinationViewController).currentControllerIndex = 0;
    }
}
@end
