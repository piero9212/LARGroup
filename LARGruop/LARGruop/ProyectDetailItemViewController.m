//
//  ProyectDetailItemViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailItemViewController.h"

@interface ProyectDetailItemViewController ()

@end

@implementation ProyectDetailItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)proyectItemPopToRoot:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


#pragma mark -
#pragma mark - Navigation
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
