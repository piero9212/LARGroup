//
//  BaseViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Reachability.h>
#import "ExtendedCategories.h"
#import "ErrorConstants.h"
#import "ApplicationConstants.h"
#import "UIConstants.h"
#import "NotificationConstants.h"
#import "StandardDefaultConstants.h"
#import "AlertViewFactory.h"
#import "AlertViewTags.h"
#import "AlertViewSender.h"
#import <MagicalRecord/MagicalRecord.h>
#import "ErrorCodes.h"

@interface BaseViewController : UIViewController

@property (nonatomic) BOOL isAlertReaded;
@property (nonatomic) NSInteger alertViewSender;

-(void)showHUDOnView:(UIView*)view;
-(void)hideHUDOnView:(UIView*)view;
- (void)showRequestErrorAlertViewWithNotification:(NSNotification *)notification;
-(void)initSetup;

@end
