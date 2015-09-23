//
//  LoginViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginViewController.h"

static NSString* const FORGET_PASSWORD_SEGUE = @"FORGET_PASSWORD_SEGUE";
static NSString* const HOME_SEGUE = @"HOME_SEGUE";

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
    BOOL canDoLogin;
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    #ifdef __IPHONE_8_0
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [self.locationManager requestAlwaysAuthorization];
    }
    #endif
    [self.navigationController setNavigationBarHidden:TRUE];
    [self.loginButton makeCircleShapeWithBorderWidth:1 borderColor:[UIColor blackColor] andBorderRadius:10];
    [self.userTextField makeUnderlineWithBordeWidth:1 color:[UIColor grayColor] andAlpha:0.3];
    [self.passwordTextField makeUnderlineWithBordeWidth:1 color:[UIColor grayColor] andAlpha:0.3];
}

-(void)setupVars
{
    canDoLogin = false;
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

//    if(self.userTextField.text && self.passwordTextField.text && ![self.userTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""])
        canDoLogin= true;
    if(canDoLogin)
        [self performSegueWithIdentifier:HOME_SEGUE sender:self];
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
}

@end
