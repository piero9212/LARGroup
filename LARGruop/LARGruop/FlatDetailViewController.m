//
//  FlatDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatDetailViewController.h"

@interface FlatDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flatNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeFlatButton;
@property (weak, nonatomic) IBOutlet UIImageView *flatImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flatStatus;

@end

@implementation FlatDetailViewController


#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupVars
{
    self.flatStatus = self.selectedFlat.status;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, _popOverViewSize.width, _popOverViewSize.height);
    
    self.view.superview.layer.cornerRadius  = 5.0;
    self.view.superview.layer.masksToBounds = YES;
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -
- (IBAction)seeFlatTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:@"" sender:nil];
}

#pragma mark -
#pragma mark - Navigation
#pragma mark -


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
