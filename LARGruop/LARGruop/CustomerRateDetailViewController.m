//
//  CustomerRateDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 21/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerRateDetailViewController.h"

@interface CustomerRateDetailViewController ()

@end

@implementation CustomerRateDetailViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupDismiss];
}

-(void)setupDismiss
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    [recognizer setNumberOfTapsRequired:1];
    recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
    [self.view.window addGestureRecognizer:recognizer];
    recognizer.delegate = self;
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap behind");
    if (sender.state == UIGestureRecognizerStateEnded) {
        UIView *rootView = self.view.window.rootViewController.view;
        CGPoint location = [sender locationInView:rootView];
        if (![self.view pointInside:[self.view convertPoint:location fromView:rootView] withEvent:nil]) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self.view.window removeGestureRecognizer:sender];
            }];
        }
    }
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        
//        // passing nil gives us coordinates in the window
//        CGPoint location = [sender locationInView:nil];
//        
//        // swap (x,y) on iOS 8 in landscape
//        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
//            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
//                location = CGPointMake(location.y, location.x);
//            }
//        }
//        
//        // convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
//        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil]) {
//            
//            // remove the recognizer first so it's view.window is valid
//            [self.view.window removeGestureRecognizer:sender];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
}



@end
