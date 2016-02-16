//
//  FlatLegendTableViewCell.h
//  LARGruop
//
//  Created by Piero on 15/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlatLegendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *legendNameLabel;
@property (weak, nonatomic) IBOutlet UIView *legendView;

-(void)setupCellWithLegendStatus:(NSInteger)status andLegendName:(NSString*)name;
@end
