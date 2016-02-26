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
#import "FlatDetailViewControllerProtocol.h"

@interface FlatDetailViewController : BaseViewController <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>


@property (strong,nonatomic) Flat* selectedFlat;
@property (nonatomic,weak) id<FlatDetailViewControllerProtocol> flatDelegate;
@end
