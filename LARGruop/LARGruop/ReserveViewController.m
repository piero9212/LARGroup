//
//  ReserveViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "ReserveViewController.h"
#import "ReserveStepOneViewController.h"
#import "ReserveStepTwoViewController.h"
#import "PromoService.h"

@interface ReserveViewController ()
@property (weak, nonatomic) IBOutlet UIView *stepOneView;

@property (weak, nonatomic) IBOutlet UIView *stepTwoView;
@end

@implementation ReserveViewController
{
    int reserveViewType;
}
#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray* promos= [[PromoService sharedService]getAllPromos];
    self.randomPromo = [promos objectAtIndex: arc4random() % [promos count]];
    reserveViewType= 1;
    [self presentSelectedViewController];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
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
     } completion:^(BOOL finished) {
         [self hideHUDOnView:self.view];
     }];
    
}

-(UIViewController*)getCurrentViewController
{
    UIViewController* fromVC;
    for (UIViewController*  vc in self.childViewControllers)
    {
        if([vc isKindOfClass:[ReserveStepOneViewController class]] || [vc isKindOfClass:[ReserveStepTwoViewController class]] )
            fromVC =vc;
        
    }
    return fromVC;
}

-(void)presentSelectedViewController
{
    UIViewController* destinationVC;
    UIViewController* currentVC = [self getCurrentViewController];
    switch (reserveViewType) {
        case 1:
            self.stepOneView.backgroundColor = [UIColor blackColor];
            self.stepTwoView.backgroundColor = [UIColor clearColor];
            destinationVC = (ReserveStepOneViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ReserveStepOneViewController"];
            ((ReserveStepOneViewController*)destinationVC).selectedFlat = self.selectedFlat;
            ((ReserveStepOneViewController*)destinationVC).delegate = self.self;
            break;
        case 2:
            self.stepOneView.backgroundColor = [UIColor clearColor];
            self.stepTwoView.backgroundColor = [UIColor blackColor];
            destinationVC = (ReserveStepTwoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ReserveStepTwoViewController"];
            ((ReserveStepTwoViewController*)destinationVC).selectedFlat = self.selectedFlat;
            ((ReserveStepTwoViewController*)destinationVC).delegate =self;
            ((ReserveStepTwoViewController*)destinationVC).randomPromo = self.randomPromo;
            break;
    }
    
    [self setViewControllerChildWith:destinationVC from:currentVC];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)stepOneTapped:(id)sender {
    reserveViewType= 1;
    [self presentSelectedViewController];
}
- (IBAction)stepTwoTapped:(id)sender {
//    reserveViewType= 2;
//    [self presentSelectedViewController];
}
- (IBAction)closeTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark -
#pragma mark - Create Quote Protocol
#pragma mark -



-(void)changeReserveViewControllerWithCustomer:(Customer*)selectedCustomer
{
    if(reserveViewType== 1)
    {
        reserveViewType= 2;
        self.stepOneView.backgroundColor = [UIColor clearColor];
        self.stepTwoView.backgroundColor = [UIColor blackColor];
        UIViewController* destinationVC;
        UIViewController* currentVC = [self getCurrentViewController];
        destinationVC = (ReserveStepTwoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ReserveStepTwoViewController"];
        ((ReserveStepTwoViewController*)destinationVC).selectedFlat = self.selectedFlat;
        ((ReserveStepTwoViewController*)destinationVC).delegate = self;
        ((ReserveStepTwoViewController*)destinationVC).selectedCustomer = selectedCustomer;
        ((ReserveStepTwoViewController*)destinationVC).randomPromo = self.randomPromo;
        
    
        [self setViewControllerChildWith:destinationVC from:currentVC];
    }
}

@end
