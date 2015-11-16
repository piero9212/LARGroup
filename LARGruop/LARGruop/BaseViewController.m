//
//  BaseViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//
#import "GenericService.h"
#import "BaseViewController.h"
#import "AlertViewFactory.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation BaseViewController

#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initSetup];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initSetup
{
    self.alertViewSender = -1;
    self.isAlertReaded = false;
    [self setupViews];
}

-(void)setupViews
{
    
}

-(void)showHUDOnView:(UIView*)view
{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.opacity = 0;
    self.hud.activityIndicatorColor = [UIColor grayColor];
    [self.hud show:YES];
}

-(void)hideHUDOnView:(UIView*)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
    
}


#pragma mark -
#pragma mark - Request Error Handling
#pragma mark -

- (void)showRequestErrorAlertViewWithNotification:(NSNotification *)notification
{
    [[GenericService sharedService] cancelAllPreviousRequests];
    NSDictionary *userInfo = ((NSDictionary *)notification.object);
    
    NSNumber *showAlertViewNumber = [userInfo objectForKey:ERROR_NOTIFICATION_SHOW_ALERT_VIEW];
    BOOL showAlertView = showAlertViewNumber.boolValue;
    
    if (!showAlertView) {
        return;
    }
    
    NSNumber *statusCodeNumber = [userInfo objectForKey:ERROR_NOTIFICATION_STATUS_CODE];
    NSInteger statusCode = statusCodeNumber.integerValue;
    
    if(!self.isAlertReaded)
    {
        self.isAlertReaded=true;
        UIAlertView *alertView = nil;
        
        switch (statusCode) {
            case StatusCodeNoInternetConnection:
                alertView = [AlertViewFactory alertViewForNoInternetConnectionErrorWithDelegate:self];
                break;
            case StatusCodeNotFound:
                alertView = [AlertViewFactory alertViewForNotFoundErrorWithDelegate:self];
                break;
            case StatusCodeInternalServerError:
                alertView = [AlertViewFactory alertViewForNotInternalServerErrorWithDelegate:self];
                break;
            default:
                alertView = [AlertViewFactory alertViewForUnexpectedErrorWithDelegate:self];
                break;
        }
        
        [alertView show];
    }
    
}
@end
