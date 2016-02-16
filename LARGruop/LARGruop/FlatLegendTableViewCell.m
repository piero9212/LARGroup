//
//  FlatLegendTableViewCell.m
//  LARGruop
//
//  Created by Piero on 15/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "FlatLegendTableViewCell.h"
#import "UIColor+ExtendedMethods.h"

@implementation FlatLegendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithLegendStatus:(NSInteger)status andLegendName:(NSString*)name
{
    [self.legendView setBackgroundColor:[UIColor colorForDepartmentsStatus:status]];
    [self.legendNameLabel setText:name];
}

@end
