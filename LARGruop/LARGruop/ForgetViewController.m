//
//  ForgetViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ForgetViewController.h"
#import "InitViewController.h"
#import "LoginService.h"

@interface ForgetViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *backTitleLabel;

@end

@implementation ForgetViewController

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
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setupDeallocNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [self.sendButton makeCircleShapeWithBorderWidth:1 borderColor:[UIColor blackColor] andBorderRadius:10];
    [self.emailTextField makeUnderlineWithBordeWidth:1 color:[UIColor grayColor] andAlpha:0.3];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}


-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recoverSucceeded:) name:kNotificationRememberSucces object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recoverError:) name:kNotificationRememberFailed object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationNoInternetConnection object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationUnauthorized object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationNotFound object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationInternalServerError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRequestErrorAlertViewWithNotification:) name:kNotificationUnexpectedError object:nil];
}

-(void)setupDeallocNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationRememberSucces object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationRememberFailed object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNoInternetConnection object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnauthorized object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNotFound object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationInternalServerError object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUnexpectedError object:nil];
}

#pragma mark -
#pragma mark - API & Notifications Actions
#pragma mark -

#pragma mark - Recover Actions

- (void)recoverSucceeded:(NSNotification *)notification
{
    [self hideHUDOnView:self.view];
    [[AlertViewFactory alertViewForPasswordRecovered]show];
}

- (void)recoverError:(NSNotification *)notification
{
    [self hideHUDOnView:self.view];
    [[AlertViewFactory alertViewForPasswordRecoveredFailed]show];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -
- (IBAction)send:(UIButton *)sender {
    if(self.emailTextField.text>0 && ![self.emailTextField.text isEqualToString:@""])
    {
        [self showHUDOnView:self.view];
        [[LoginService sharedService] apiRecoverPasswordWithEmail:self.emailTextField.text];
    }
}

- (IBAction)returnToInit:(UIButton *)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    InitViewController *vc =
    [storyboard instantiateViewControllerWithIdentifier:@"InitViewController"];
    
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

- (IBAction)backToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}
@end
