//
//  PlantButtonCollectionViewCell.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlantButtonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *plantButton;
-(void)setupCellWithPlantName:(NSString*)plant isSelected:(BOOL)isSelected;
@end
