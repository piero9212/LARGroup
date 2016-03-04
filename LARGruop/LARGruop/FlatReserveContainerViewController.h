//
//  FlatReserveContainerViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 26/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatContainerProtocol.h"
#import "FlatDetailViewControllerProtocol.h"
#import "Flat.h"
#import "BaseViewController.h"

@interface FlatReserveContainerViewController : BaseViewController <FlatDetailViewControllerProtocol>

@property (weak, nonatomic) id<FlatContainerProtocol> delegate;
@property (strong,nonatomic) Flat* selectedFlat;

@end
