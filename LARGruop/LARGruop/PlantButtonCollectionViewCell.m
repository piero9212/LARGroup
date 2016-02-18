//
//  PlantButtonCollectionViewCell.m
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "PlantButtonCollectionViewCell.h"
#import "UIColor+ExtendedMethods.h"

@implementation PlantButtonCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setupCellWithPlantName:(NSString*)plant isSelected:(BOOL)isSelected
{
    [self.plantButton setTitle:plant forState:UIControlStateNormal];
    self.plantButton.layer.cornerRadius = 10;
    if(isSelected)
    {
        [self.plantButton setBackgroundColor:[UIColor LARSkyBlueColor]];
        [self.plantButton.titleLabel setTextColor:[UIColor whiteColor]];
    }
    else
    {
        [self.plantButton setBackgroundColor:[UIColor clearColor]];
        [self.plantButton.titleLabel setTextColor:[UIColor lightGrayColor]];
    }
}
@end
