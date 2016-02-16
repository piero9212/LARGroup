//
//  FlatGroupCollectionViewCell.m
//  LARGruop
//
//  Created by Piero on 15/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatGroupCollectionViewCell.h"
#import "DepartmentCollectionViewCell.h"
#import "Flat.h"
#import "Floor.h"
#import "UIColor+ExtendedMethods.h"

static NSString* const DEPARTAMENT_SQUARE_CELL = @"DEPARTAMENT_SQUARE_CELL";

@implementation FlatGroupCollectionViewCell
{
    BOOL areSolidColor;
    NSString* floorNumber;
    NSInteger maxFlatsPerFloor;
}
- (void)awakeFromNib {
    // Initialization code
}


//-(void)setupCellWithFlats:()

-(void)setupBottomHeaderCellsWithFloorNumber:(NSString*)floor allItemsSolidColor:(BOOL)allAreSolidColor andFlatsArray:(NSArray*)array andMaxFlatsPerFloor:(NSInteger)maxFlats
{
    areSolidColor = allAreSolidColor;
    maxFlatsPerFloor = maxFlats;
    floorNumber = floor;
    self.cubesCollectionView.dataSource =self;
    self.cubesCollectionView.delegate = self;
    self.items = array;
    [self.cubesCollectionView reloadData];
}

#pragma mark -
#pragma mark - Collection View Delegate
#pragma mark -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(!self.items)
        return 0;
    else
    {
        if(areSolidColor)
            return self.items.count+1;
        else
            return maxFlatsPerFloor;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"DepartmentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DEPARTAMENT_SQUARE_CELL];
    DepartmentCollectionViewCell* cell = [self.cubesCollectionView dequeueReusableCellWithReuseIdentifier:DEPARTAMENT_SQUARE_CELL forIndexPath:indexPath];
    BOOL isSolidColor;
    UIColor* color;
    NSInteger item = indexPath.item-1;
    if(!areSolidColor)
    {
        if(item == -1) // empty corner
        {
            [cell setupEmptyCell];
        }
        else
        {
            isSolidColor = false;
            color = [UIColor clearColor];
            floorNumber = [NSString stringWithFormat:@"0%ld",(long)item+1];
            [cell setupCellWithFloorNumber:floorNumber color:color isSolidColor:isSolidColor];
        }
    }
    else
    {
        if(item == -1)
        {
            isSolidColor = false;
            color = [UIColor clearColor];
            floorNumber = [NSString stringWithFormat:@"%ld",(long)item];
        }
        else
        {
            Flat* flat = [self.items objectAtIndex:item];
            isSolidColor = true;
            color = [UIColor colorForDepartmentsStatus:flat.status.intValue];
        }
        [cell setupCellWithFloorNumber:floorNumber color:color isSolidColor:isSolidColor];

    }
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(30,30);
}

@end
