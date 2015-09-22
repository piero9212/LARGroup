//
//  CustomerRateDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 21/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "CustomerRateDetailViewController.h"

@interface CustomerRateDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation CustomerRateDetailViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.proyectNameLabel.text = self.rate.proyect.name;
    self.rateNameLabel.text = self.rate.name;
    self.codeLabel.text = self.rate.marketRateID;
}

-(void)dismissAnimated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelChanges:(id)sender {
    [self dismissAnimated];
}

@end
