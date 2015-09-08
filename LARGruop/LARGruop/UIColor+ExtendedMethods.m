//
//  UIColor+ExtendedMethods.m
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "UIColor+ExtendedMethods.h"

@implementation UIColor (ExtendedMethods)

+(UIColor *)orangeLARColor
{
    return  UIColorFromRGB(0xe64c09);
}
+ (UIColor *)colorWithColor:(UIColor *)color andAlpha:(CGFloat)alpha
{
    const CGFloat* components = CGColorGetComponents(color.CGColor);
    
    return [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
}

@end
