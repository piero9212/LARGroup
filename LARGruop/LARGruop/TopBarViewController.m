//
//  TopBarViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "TopBarViewController.h"

@implementation TopBarViewController


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
}

-(void)setupVars
{
    
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)doFilter:(id)sender {
}

- (IBAction)search:(id)sender {
}

- (IBAction)addCustomer:(id)sender {
}
@end
