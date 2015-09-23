//
//  MapMarkDetailViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 23/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "MapMarkDetailViewController.h"
#import <Haneke/Haneke.h>


@implementation MapMarkDetailViewController

#pragma mark -
#pragma mark - View Life Cycle
#pragma mark -

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self.view setNeedsDisplay];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, _popOverViewSize.width, _popOverViewSize.height);
    
    self.view.superview.layer.cornerRadius  = 5.0;
    self.view.superview.layer.masksToBounds = YES;
}

-(void)setupViews
{
    Proyect* proyect = [Proyect MR_findByAttribute:@"uid" withValue:self.proyectUID].firstObject;
    NSString* name = [NSString stringWithFormat:@"Proyecto %@",proyect.name];
    self.proyectAnnotationTitleLabel.text = name;
    self.proyectAnnotationAddressLabel.text = proyect.address;
    self.mapDesciptionLabel.text = proyect.mapDescription;
    self.proyectAnnotationImageView.layer.cornerRadius = self.proyectAnnotationImageView.frame.size.height /2;
    self.proyectAnnotationImageView.layer.masksToBounds = YES;
    self.proyectAnnotationImageView.layer.borderWidth = 5.0;
    self.proyectAnnotationImageView.layer.borderColor =[UIColor colorForAvaibleDepartmentsCount:proyect.leftDepartaments.integerValue].CGColor;
    [self.proyectAnnotationImageView hnk_setImageFromURL:[NSURL URLWithString:proyect.mapImageURL]];
    [self.mapDesciptionLabel sizeToFit];
}

- (IBAction)goToProyectTouch:(id)sender {
    [self.delegate showProyectDetailControllerWithProyecUID:self.proyectUID];
}
@end
