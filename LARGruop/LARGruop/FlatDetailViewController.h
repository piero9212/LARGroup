//
//  FlatDetailViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Flat.h"

@interface FlatDetailViewController : BaseViewController

@property (readwrite) CGSize popOverViewSize;
@property (strong,nonatomic) Flat* selectedFlat;
@end
