//
//  ProyectDetailPanoramicViewController.m
//  LARGruop
//
//  Created by piero.sifuentes on 25/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectDetailPanoramicViewController.h"
#import <Haneke/Haneke.h>

@interface ProyectDetailPanoramicViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *proyectPanoramicImageView;

@end
@implementation ProyectDetailPanoramicViewController

#pragma mark -
#pragma mark - View Life Cicle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupVars];
    [self setupViews];
}

-(void)setupViews{
    CGRect frame = self.view.frame;
    frame.size.width = self.containerSize.width;
    frame.size.height = self.containerSize.height;
    self.view.frame = frame;
}

-(void)setupVars
{
    Proyect* selectedProyect = [Proyect MR_findFirstByAttribute:@"uid" withValue:self.selectedProyectID];
    NSURL* url = [NSURL URLWithString:selectedProyect.panoramicImageURL];
    [self.proyectPanoramicImageView hnk_setImageFromURL:url];
}


@end
