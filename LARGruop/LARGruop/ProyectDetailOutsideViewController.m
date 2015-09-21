//
//  ProyectDetailOutsideViewController.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailOutsideViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProyectDetailOutsideViewController ()

@end

@implementation ProyectDetailOutsideViewController


#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outsideImageView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
