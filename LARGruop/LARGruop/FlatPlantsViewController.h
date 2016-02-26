//
//  FlatPlantsViewController.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ProyectDetailProtocol.h"
#import "FlatContainerProtocol.h"

@interface FlatPlantsViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate,UIGestureRecognizerDelegate,FlatContainerProtocol>

@property (nonatomic,strong) NSString* selectedProyectID;
@property (nonatomic) CGSize containerSize;

@end
