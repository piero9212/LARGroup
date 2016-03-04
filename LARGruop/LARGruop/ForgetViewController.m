//
//  ForgetViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ForgetViewController.h"
#import "InitViewController.h"

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

#pragma mark -
#pragma mark - IBActions
#pragma mark -

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
