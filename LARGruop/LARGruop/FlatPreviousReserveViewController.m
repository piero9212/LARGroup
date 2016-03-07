//
//  FlatPreviousReserveViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatPreviousReserveViewController.h"
#import <Haneke.h>
#import "StatusCode.h"
#import "ReserveViewController.h"

@interface FlatPreviousReserveViewController ()

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIImageView *flatImageView;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@end

@implementation FlatPreviousReserveViewController


#pragma mark -
#pragma mark - View Life Cicle
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
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setupVars];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)setupVars
{
    NSURL* url = [NSURL URLWithString:self.selectedFlat.flatImageURL];
    [self.flatImageView hnk_setImageFromURL:url];
    [self.modelNameLabel setText:[NSString stringWithFormat:@"Modelo %@ ",self.selectedFlat.name]];
    [self.sizeLabel setText:[NSString stringWithFormat:@"%@m2",self.selectedFlat.size]];
    self.reserveButton.layer.cornerRadius = 10;
    self.reserveButton.layer.borderWidth =  2 ;
    self.reserveButton.layer.borderColor = [UIColor orangeLARColor].CGColor;
    UIColor* statusColor = [UIColor colorForDepartmentsStatus:self.selectedFlat.status.integerValue];
    NSString* statusName;
    switch (self.selectedFlat.status.integerValue) {
        case StatusCodeFree:
            statusName = @"Libre";
            break;
        case StatusCodeReserved:
            statusName = @"Separada";
            break;
        case StatusCodeContract:
            statusName = @"Contrato (Minuta)";
            break;
        case StatusCodesWrited:
            statusName = @"Escriturado";
            break;
        case StatusCodeBlocked:
            statusName = @"Bloqueado";
            break;
    }
    [self.statusLabel setText:statusName];
    [self.statusLabel setTextColor:statusColor];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)dismiss:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)reserve:(UIButton *)sender {
    [self performSegueWithIdentifier:FLAT_RESERVE_SEGUE sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[ReserveViewController class]])
    {
        ReserveViewController* destinationVC = segue.destinationViewController;
        destinationVC.selectedFlat = self.selectedFlat;
    }
}

@end
