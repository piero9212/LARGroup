//
//  ProyectCollectionViewCell.h
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProyectCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *buildImageView;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *proyectAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *departamentsLeftLabel;
@end
