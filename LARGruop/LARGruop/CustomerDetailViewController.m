//
//  CustomerDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerDetailViewController.h"
#import "CustomerInfoViewController.h"
#import "CustomerMarketRateViewController.h"

@interface CustomerDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *selectedSecondFilterView;
@property (weak, nonatomic) IBOutlet UIView *customerInfoContainerView;
@property (weak, nonatomic) IBOutlet UIButton *todayButton;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (nonatomic) CGRect todayFrame;
@property (nonatomic) CGRect allFrame;

@end

@implementation CustomerDetailViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.todayFrame = self.todayButton.frame;
    self.allFrame = self.allButton.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
    }
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)customerInfoSementedValueChanged:(UISegmentedControl *)sender {
    
    UIViewController* destinationVC;
    UIViewController* currentVC = [self getCurrentViewController];
    switch (sender.selectedSegmentIndex) {
        case 0:
            destinationVC = (CustomerInfoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"CustomerInfoViewController"];
            ((CustomerInfoViewController*)destinationVC).customerSelected =  self.detailItem;
            [self reloadTable];
            break;
        case 1:
            destinationVC = (CustomerMarketRateViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"CustomerMarketRateViewController"];
            ((CustomerMarketRateViewController*)destinationVC).selectedCustomer =  self.detailItem;
            ((CustomerMarketRateViewController*)destinationVC).containerSize = self.customerInfoContainerView.frame.size;
            [self reloadTable];
            break;
            
        default:
            destinationVC = (CustomerInfoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"CustomerInfoViewController"];
            ((CustomerInfoViewController*)destinationVC).customerSelected =  self.detailItem;
            break;
    }
    [self setViewControllerChildWith:destinationVC from:currentVC];
}

- (IBAction)allTouch:(UIButton *)sender {
    [UIView animateWithDuration:0.3 //Time for the animation
                     animations:^{
                         self.selectedSecondFilterView.frame = CGRectMake (sender.frame.origin.x-10,self.selectedSecondFilterView.frame.origin.y,self.selectedSecondFilterView.frame.size.width,self.selectedSecondFilterView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];
}

- (IBAction)todayTouch:(UIButton*)sender {
    [UIView animateWithDuration:0.3 //Time for the animation
                     animations:^{
                         self.selectedSecondFilterView.frame = CGRectMake (0,self.selectedSecondFilterView.frame.origin.y,self.selectedSecondFilterView.frame.size.width,self.selectedSecondFilterView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];
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
        if([vc isKindOfClass:[CustomerMarketRateViewController class]] || [vc isKindOfClass:[CustomerInfoViewController class]])
            fromVC =vc;
        
    }
    return fromVC;
}

-(void)reloadTable
{
     UIViewController* currentVC = [self getCurrentViewController];
    if([currentVC isKindOfClass:[CustomerInfoViewController class]])
    {
        [((CustomerInfoViewController*)currentVC).customerInfoTableView reloadData];
    }
    else if([currentVC isKindOfClass:[CustomerMarketRateViewController class]])
    {
        [((CustomerMarketRateViewController*)currentVC).customerMarketRatesTableView reloadData];
    }
}
#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController* destVC= segue.destinationViewController;
    if([segue.destinationViewController isKindOfClass:[CustomerInfoViewController class]])
    {
        ((CustomerInfoViewController*)destVC).customerSelected=self.detailItem;
    }
}

@end
