//
//  ProyectDetailOutsideViewController.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseViewController.h"

@interface ProyectDetailOutsideViewController : BaseViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UIImageView *outsideImageView;
@property (assign, nonatomic) UIImage* image;
@end
