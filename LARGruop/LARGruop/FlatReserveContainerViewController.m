//
//  FlatReserveContainerViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatReserveContainerViewController.h"
#import "FlatDetailViewController.h"
#import "FlatPreviousReserveViewController.h"

static NSString * const FLAT_DETAIL_VIEW_CONTROLLER_EMBED_SEGUE_IDENTIFIER = @"FLAT_DETAIL_VIEW_CONTROLLER_EMBED_SEGUE_IDENTIFIER";
static NSString * const FLAT_PRERESERVE_VIEW_CONTROLLER_SEGUE_IDENTIFIER = @"FLAT_PRERESERVE_VIEW_CONTROLLER_SEGUE_IDENTIFIER";

@interface FlatReserveContainerViewController ()

@property (strong, nonatomic) FlatDetailViewController *flatDetailViewController;
@end

@implementation FlatReserveContainerViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5f animations:^{
        
        if ([self.delegate respondsToSelector:@selector(flatContainerViewControllerupdateToNormalSize:)]) {
            [self.delegate flatContainerViewControllerupdateToNormalSize:self];
        }
    }];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

- (void)viewWillLayoutSubviews
{
    self.navigationController.view.superview.layer.cornerRadius  = 5.0;
    self.navigationController.view.superview.layer.masksToBounds = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:FLAT_DETAIL_VIEW_CONTROLLER_EMBED_SEGUE_IDENTIFIER]) {
        
        self.flatDetailViewController = (FlatDetailViewController *) [segue destinationViewController];
        self.flatDetailViewController.flatDelegate = self;
        self.flatDetailViewController.selectedFlat = self.selectedFlat;
    }
    else if ([segue.identifier isEqualToString:FLAT_PRERESERVE_VIEW_CONTROLLER_SEGUE_IDENTIFIER])
    {
        FlatPreviousReserveViewController* destiantionVC = (FlatPreviousReserveViewController *) [segue destinationViewController];
        destiantionVC.selectedFlat = self.selectedFlat;
    }
}


#pragma mark - FViewControllerDelegate

- (void)flatDetailViewControllerupdateToNormalSize:(FlatDetailViewController *)sender
{
    if ([self.delegate respondsToSelector:@selector(flatContainerViewControllerupdateToNormalSize:)]) {
        [self.delegate flatContainerViewControllerupdateToNormalSize:self];
    }
}

- (void)flatDetailViewControllerupdateToExpandedSize:(FlatDetailViewController *)sender
{
    [self performSegueWithIdentifier:FLAT_PRERESERVE_VIEW_CONTROLLER_SEGUE_IDENTIFIER sender:self];
    
    if ([self.delegate respondsToSelector:@selector(flatContainerViewControllerupdateToExpandedSize:)]) {
        [self.delegate flatContainerViewControllerupdateToExpandedSize:self];
    }
}


@end
