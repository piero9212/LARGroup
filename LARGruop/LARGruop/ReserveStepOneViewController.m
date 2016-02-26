//
//  ReserveStepOneViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "ReserveStepOneViewController.h"

@interface ReserveStepOneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *floorNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorStatusLabel;
@property (weak, nonatomic) IBOutlet UISwitch *printSwitch;

@end

@implementation ReserveStepOneViewController


#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tapFloor:(UITapGestureRecognizer *)sender {
    
    
}


@end
