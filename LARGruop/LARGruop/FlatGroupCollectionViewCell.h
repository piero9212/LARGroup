//
//  FlatGroupCollectionViewCell.h
//  LARGruop
//
//  Created by Piero on 15/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatDetailProtocol.h"

@interface FlatGroupCollectionViewCell : UICollectionViewCell <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cubesCollectionView;
@property (strong,nonatomic) NSArray* items;
-(void)setupBottomHeaderCellsWithFloorNumber:(NSString*)floor allItemsSolidColor:(BOOL)allAreSolidColor andFlatsArray:(NSArray*)array andMaxFlatsPerFloor:(NSInteger)maxFlats;

@property (nonatomic,weak) id<FlatDetailProtocol> flatDelegate;
@end
