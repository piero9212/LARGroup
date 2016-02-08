//
//  DepartmentCollectionViewCell.m
//  LARGruop
//
//  Created by piero.sifuentes on 24/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "DepartmentCollectionViewCell.h"

@implementation DepartmentCollectionViewCell

-(void)setupCellWithFloorNumber:(NSString*)floorNumber color:(UIColor*)color isSolidColor:(BOOL)isSolidColor;
{
    self.color = color;
    self.isSolidColor = isSolidColor;
    self.departmentNameLabel.text = floorNumber;
    if(isSolidColor)
    {
        self.backgroundColor = color;
        self.departmentNameLabel.text = @"";
    }
}

@end
