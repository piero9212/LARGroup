//
//  ProyectDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailViewController.h"
#import "ProyectFeaturesViewController.h"
#import "ProyectDetailItemViewController.h"
#import <Haneke/Haneke.h>

static NSString* const FEATURE_MORE_DETAIL_SEGUE = @"FEATURE_MORE_DETAIL_SEGUE";

@interface ProyectDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) UIPopoverController *featuresPopover;
@property (weak, nonatomic) IBOutlet UILabel *proyectTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectSubTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *proyectBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *locateButton;
@property (weak, nonatomic) IBOutlet UIButton *outsideButton;
@property (weak, nonatomic) IBOutlet UIButton *departmentButton;
@end

@implementation ProyectDetailViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupViews];
    [self setupVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupViews
{
    [self.navigationController setNavigationBarHidden:TRUE];
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    self.proyectSubTitleLabel.text = self.proyectTitleLabel.text = [NSString stringWithFormat:@"Proyecto %@",selectedProyect.name];
    [self.proyectBackgroundImageView hnk_setImageFromURL:[NSURL URLWithString:selectedProyect.imageURL]];
}

-(void)setupVars
{
    
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)goBack:(UIButton *)sender {

    self.selectedProyectID =nil;
    self.proyectTitleLabel.text =@"";
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (IBAction)presentFeatures:(id)sender {
    ProyectFeaturesViewController *featureViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProyectFeaturesViewController"];
    featureViewController.selectedProyectID = self.selectedProyectID;
    self.featuresPopover = [[UIPopoverController alloc] initWithContentViewController:featureViewController];
    
    self.featuresPopover.popoverContentSize = CGSizeMake(400, 500);
    [self.featuresPopover presentPopoverFromRect:[sender frame]
                                          inView:self.bottomView
                        permittedArrowDirections:UIPopoverArrowDirectionDown
                                        animated:YES];

}
- (IBAction)presentModalDetailView:(id)sender {
    [self performSegueWithIdentifier:FEATURE_MORE_DETAIL_SEGUE sender:sender];
}


#pragma mark -
#pragma mark - Navigation
#pragma mark -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ProyectDetailItemViewController class]])
    {
        ProyectDetailItemViewController* destinationVC = segue.destinationViewController;
        if([sender isEqual:self.locateButton])
        {
            destinationVC.itemType = ProyectDetailItemTypeLocate;
        }
        else if([sender isEqual:self.outsideButton])
        {
            destinationVC.itemType = ProyectDetailItemTypeOutside;
        }
        else if([sender isEqual:self.departmentButton])
        {
            destinationVC.itemType = ProyectDetailItemTypeDepartaments;
        }
        destinationVC.selectedProyectID = self.selectedProyectID;
    }
}
@end
