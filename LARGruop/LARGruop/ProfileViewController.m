//
//  ProfileViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProfileViewController.h"
#import "NewCustomerViewController.h"
#import "TopBarViewController.h"
#import "LoginService.h"
#import "HomeViewController.h"
#import "User.h"

static NSString* LOGOUT_SEGUE = @"LOGOUT_SEGUE";

@interface ProfileViewController()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *changePictureButton;
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;

@end

@implementation ProfileViewController

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    [[UITabBar appearance] setTintColor:[UIColor orangeLARColor]];
    User* user = [[LoginService sharedService]lastLoggedInUser];
    if(user.firstName && user.lastName)
    {
        [self.userFullNameLabel setText:[NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName]];
    }
    else if(user.firstName)
    {
        [self.userFullNameLabel setText:[NSString stringWithFormat:@"%@",user.firstName]];
    }
    else
        [self.userFullNameLabel setText:@"----"];

    if(user.email)
         [self.userEmailLabel setText:user.email];
    else
        [self.userFullNameLabel setText:@"----"];
    
    if(user)//TODO: GET CELPPHONE
        [self.cellPhoneLabel setText:@"----"];
    else
        [self.cellPhoneLabel setText:@"----"];
        
    if(user)//TODO: GET PHONE
        [self.phoneLabel setText:@"----"];
    else
        [self.phoneLabel setText:@"----"];
    
    
    [self.userNameLabel setText:user.username];
    float radius = self.userPictureImageView.frame.size.width/2;
    self.userPictureImageView.layer.cornerRadius =  radius;
    self.logoutButton.layer.cornerRadius= self.changePictureButton.layer.cornerRadius = 10;
    self.logoutButton.layer.borderWidth = self.changePictureButton.layer.borderWidth = 3 ;
    self.logoutButton.layer.borderColor = self.changePictureButton.layer.borderColor = [UIColor orangeLARColor].CGColor;
}

-(void)setupVars
{
    
}

-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess:)
                                                 name:kNotificationLogoutFinished object:nil];
}


#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)logout:(UIButton *)sender {
    [[LoginService sharedService] logoutWithNotification:TRUE];
}
- (IBAction)changePictureTapped:(UIButton *)sender {
}

- (IBAction)editInfoTapped:(UIButton *)sender {
}

#pragma mark -
#pragma mark - Actions
#pragma mark -

-(void)logoutSuccess:(NSNotification*)notification
{
    [self performSegueWithIdentifier:LOGOUT_SEGUE sender:nil];
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
    for(UIViewController* controller in self.navigationController.childViewControllers)
    {
        if([controller isKindOfClass:[UITabBarController class]])
        {
            UITabBarController* tabBarController = (UITabBarController*)controller;
            HomeViewController* home = [tabBarController.viewControllers objectAtIndex:0];
            [home showSearch];
            tabBarController.selectedViewController
            = home;
        }
    }
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[TopBarViewController class]])
    {
        ((TopBarViewController*)segue.destinationViewController).delegate = self;
        ((TopBarViewController*)segue.destinationViewController).currentControllerIndex = 2;
    }
}


@end
