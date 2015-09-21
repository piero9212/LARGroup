//
//  CustomerInterestLevelTableViewCell.h
//  LARGruop
//
//  Created by piero.sifuentes on 21/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EDStarRating/EDStarRating.h>

@interface CustomerInterestLevelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet EDStarRating *startRating;

@end
