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

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *containerSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
@implementation HomeViewController

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

#pragma mark -
#pragma mark - Top Bar Delegate
#pragma mark -

- (void)showAddCustomerViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AnnouncementDetailViewController *announcementDetailViewController = [storyboard instantiateViewControllerWithIdentifier:ANNOUNCEMENT_DETAIL_CONTROLLER_MODAL_SEGUE_IDENTIFIER];
    announcementDetailViewController.announcement = announcement;
    announcementDetailViewController.delegate = self;
    
    announcementDetailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:announcementDetailViewController animated:YES completion:nil];
    
    CGSize temporalPopoverSize = ANNOUNCEMENT_MODAL_SIZE;
    [announcementDetailViewController setPopOverViewSize:temporalPopoverSize];
}

- (void)showFilterViewController
{
}

- (void)showSearch
{
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}
@end
