//
//  DepartmentCollectionViewCell.h
//  LARGruop
//
//  Created by piero.sifuentes on 24/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *departmentNameLabel;
@property BOOL selected;
@end
