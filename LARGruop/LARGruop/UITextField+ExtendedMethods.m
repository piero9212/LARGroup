//
//  UITextField+ExtendedMethods.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "UITextField+ExtendedMethods.h"

@implementation UITextField (ExtendedMethods)


-(void)makeUnderlineWithBordeWidth:(NSInteger)borderWidth color:(UIColor*)color andAlpha:(float)alpha
{
    CALayer *border = [CALayer layer];
    UIColor* theColor = color;
    theColor = [theColor colorWithAlphaComponent:alpha];
    border.borderColor =theColor.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
}
@end
