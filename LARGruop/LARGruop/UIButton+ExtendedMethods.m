//
//  UIButton+ExtendedMethods.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "UIButton+ExtendedMethods.h"

@implementation UIButton (ExtendedMethods)

-(void)makeCircleShapeWithBorderWidth:(NSInteger)borderWidth borderColor:(UIColor*)borderColor andBorderRadius:(NSInteger)borderRadius
{
    self.layer.cornerRadius = borderRadius;
    self.layer.borderColor=borderColor.CGColor;
    self.layer.borderWidth=borderWidth;
}
@end
