//
//  CustomerContainerViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 9/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerContainerViewController.h"
#import "NewCustomerViewController.h"
#import "TopBarViewController.h"
#import "ClientService.h"

@interface CustomerContainerViewController ()

@end

@implementation CustomerContainerViewController


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
    [self setupNotifications];
    [self showHUDOnView:self.view];
    self.view.userInteractionEnabled = NO;
    [self apiGetClients];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [[UITabBar appearance] setTintColor:[UIColor orangeLARColor]];
}

-(void)setupVars
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setupDeallocNotifications];
}


-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getClientsFailed:) name:kNotificationAllClientsFailed object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationNoInternetConnection object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationUnauthorized object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationNotFound object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationInternalServerError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationUnexpectedError object:nil];
}

-(void)setupDeallocNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationAllClientsFailed object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNoInternetConnection object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnauthorized object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNotFound object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationInternalServerError object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnexpectedError object:nil];
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
}

- (void)showSearch
{
}

#pragma mark -
#pragma mark - API & Notifications Actions
#pragma mark -

#pragma mark - Clients Actions

-(void)apiGetClients
{
    [[ClientService sharedService] apiGetClientsWithErrorAlertView:YES userInfo:nil andCompletionHandler:^(BOOL succeeded) {
        if(succeeded)
        {
            self.view.userInteractionEnabled=true;
            [self hideHUDOnView:self.view];
        }
    }];
    
}

- (void)getClientsFailed:(NSNotification *)notification
{
    [self hideHUDOnView:self.view];
    self.view.userInteractionEnabled = YES;
    [[ClientService sharedService] cancelAllClientsRequests];
    
    NSDictionary *userInfo = notification.userInfo;
    NSNumber *showAlertView = [userInfo objectForKey:USER_INFO_SHOW_ALERT_VIEW];
    if (showAlertView.boolValue && !self.isAlertReaded) {
        self.isAlertReaded=true;
        self.alertViewSender = AlertViewSenderLoginError;
        [[AlertViewFactory alertViewForLoginError]show];
    }

}


#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[TopBarViewController class]])
    {
        ((TopBarViewController*)segue.destinationViewController).delegate = self;
        ((TopBarViewController*)segue.destinationViewController).currentControllerIndex = 1;
    }
}

@end
