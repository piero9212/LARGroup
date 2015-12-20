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

static NSString* LOGOUT_SEGUE = @"LOGOUT_SEGUE";

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
