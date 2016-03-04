//
//  InitViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "InitViewController.h"

static NSString* const LOGIN_SEGUE = @"LOGIN_SEGUE";

@interface InitViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property CLLocationManager *locationManager;

@end

@implementation InitViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupViews{
    [self.navigationController setNavigationBarHidden:TRUE];
    [self.loginButton makeCircleShapeWithBorderWidth:1 borderColor:[UIColor blackColor] andBorderRadius:10];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [super supportedInterfaceOrientations];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)login:(id)sender {
    [self performSegueWithIdentifier:LOGIN_SEGUE sender:self];
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
