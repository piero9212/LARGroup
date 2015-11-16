//
//  LoginViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginService.h"
#import "HomeViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property CLLocationManager *locationManager;

@end

@implementation LoginViewController
{
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
    if([[LoginService sharedService]lastLoggedInUser] && [[LoginService sharedService]lastUsername])
    {
        [self showHUDOnView:self.view];
        self.userTextField.text = [[LoginService sharedService]lastUsername];
        self.passwordTextField.text = @"**********";
        [self performSelector:@selector(doLogin:) withObject:self afterDelay:2.0];
    }
    [self initSetup];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self setupDeallocNotifications];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.navigationController setNavigationBarHidden:TRUE];
    [self.loginButton makeCircleShapeWithBorderWidth:1 borderColor:[UIColor blackColor] andBorderRadius:10];
    [self.userTextField makeUnderlineWithBordeWidth:1 color:[UIColor grayColor] andAlpha:0.3];
    [self.passwordTextField makeUnderlineWithBordeWidth:1 color:[UIColor grayColor] andAlpha:0.3];
}

-(void)initSetup
{
    [super initSetup];
    [self setupViews];
    [self setupNotifications];
}

-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed:) name:kNotificationLoginFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceeded:) name:kNotificationLoginSucceeded object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationNoInternetConnection object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationUnauthorized object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationNotFound object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationInternalServerError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationUnexpectedError object:nil];
}

-(void)setupDeallocNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLoginFailed object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLoginSucceeded object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNoInternetConnection object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnauthorized object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNotFound object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationInternalServerError object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnexpectedError object:nil];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)returnToInit:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)forgetPassword:(id)sender {
    [self performSegueWithIdentifier:FORGET_PASSWORD_SEGUE sender:nil];
}

- (IBAction)login:(id)sender {
    
    [self showHUDOnView:self.view];
    self.view.userInteractionEnabled = NO;
    self.alertViewSender = AlertViewSenderLogin;
    self.isAlertReaded=false;
    if(![self isValidUsername:self.userTextField.text andPassword:self.passwordTextField.text])
        return;
    @try {
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
            
            [[LoginService sharedService] loginWithUsername:self.userTextField.text password:self.passwordTextField.text];
        }
        else {
            [self hideHUDOnView:self.view];
            self.view.userInteractionEnabled = YES;
            self.alertViewSender = AlertViewSenderLogin;
            [[AlertViewFactory alertViewForNoInternetConnectionErrorWithDelegate:self]show];
        }
    }
    @catch (NSException *exception) {
        [self hideHUDOnView:self.view];
        self.view.userInteractionEnabled = YES;
        self.alertViewSender = AlertViewSenderLogin;
        [[AlertViewFactory alertViewForUnexpectedErrorWithDelegate:self]show];
        
    }

    
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

- (BOOL)isValidUsername:(NSString *)username andPassword:(NSString*)password
{
    if(username && password && ![username isEqualToString:@""] && ![password isEqualToString:@""])
        return YES;
    
    return NO;
}

-(void)doLogin:(id)sender
{
    [self performSegueWithIdentifier:HOME_SEGUE sender:self];
}

#pragma mark -
#pragma mark - API & Notifications Actions
#pragma mark -

#pragma mark - Login Actions

- (void)loginFailed:(NSNotification *)notification
{
    [self hideHUDOnView:self.view];
    self.view.userInteractionEnabled = YES;
    [[LoginService sharedService] cancelLoginRequestsWithUsername:self.userTextField.text password:self.passwordTextField.text];
    
    NSDictionary *userInfo = notification.userInfo;
    NSNumber *showAlertView = [userInfo objectForKey:USER_INFO_SHOW_ALERT_VIEW];
    if (showAlertView.boolValue && !self.isAlertReaded) {
        self.isAlertReaded=true;
        self.alertViewSender = AlertViewSenderLoginError;
        [[AlertViewFactory alertViewForLoginErrorWithDelegate:self]show];
    }
}

- (void)loginSucceeded:(NSNotification *)notification
{
    [self hideHUDOnView:self.view];
    [self performSegueWithIdentifier:HOME_SEGUE sender:self];
}

#pragma mark -
#pragma mark - AlertView Delegate
#pragma mark -

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == AlertViewTagNoInternetConnection || alertView.tag == AlertViewTagUnexpectedError || alertView.tag == AlertViewTagNotFound || alertView.tag == AlertViewTagInternalServerError)
    {
        
        
    }
    else if (alertView.tag == AlertViewTagLoginError)
    {
    }

}

#pragma mark -
#pragma mark - TextField Delegate
#pragma mark -

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.userTextField)
    {
        [self.passwordTextField becomeFirstResponder];
        return NO;
    }
    else
    {
        
        [textField resignFirstResponder];
        return YES;
    }
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:HOME_SEGUE])
    {
        HomeViewController* destinationVC = segue.destinationViewController;
    }

}

@end
