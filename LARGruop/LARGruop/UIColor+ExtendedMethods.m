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

+(UIColor*)LAROrangeColor
{
    return UIColorFromRGB(0xEE6F00);
}
+(UIColor*)LARYellowColor
{
    return UIColorFromRGB(0xDBD52A);
}
+(UIColor*)LARGreenColor
{
    return UIColorFromRGB(0x63F05A);
}
+(UIColor*)LARRedColor
{
    return UIColorFromRGB(0xED5154);
}
+(UIColor *)LARGreyColor
{
    return UIColorFromRGB(0x262626);
}

+(UIColor*)colorForInterestLevel:(NSInteger)interestLevel
{
    UIColor* statusColor;
    if(interestLevel <=0 || interestLevel >3)
        return [UIColor clearColor];
    switch (interestLevel) {
        case 1:
            statusColor = [self LARRedColor];
            break;
        case 2:
            statusColor = [self LARYellowColor];
            break;
        case 3:
            statusColor = [self LARGreenColor];
            break;
        default:
            statusColor = [UIColor LARGreenColor];
            break;
    }
    return statusColor;
}
+(UIColor*)colorForInterestLevel:(NSInteger)interestLevel andColorShape:(UIColor*)color
{
    UIColor* statusColor;
    if(interestLevel <=0 || interestLevel >3)
        return [UIColor clearColor];
    switch (interestLevel) {
        case 1:
            if([color isEqual:[UIColor redColor]])
                statusColor = [self LARRedColor];
            else
                statusColor = [UIColor clearColor];
            break;
        case 2:
            if([color isEqual:[UIColor yellowColor]])
                statusColor = [self LARYellowColor];
            else
                statusColor = [UIColor clearColor];
            break;
        case 3:
            if([color isEqual:[UIColor greenColor]])
                statusColor = [self LARGreenColor];
            else
                statusColor = [UIColor clearColor];
            break;
        default:
            statusColor = [UIColor LARGreenColor];
            break;
    }
    return statusColor;
}
+(UIColor*)colorForAvaibleDepartmentsCount:(NSInteger)leftDepartments
{
    UIColor* statusColor;
    switch (leftDepartments) {
        case 0:
            statusColor = [self LARRedColor];
            break;
        case 1:
        case 2:
        case 3:
            statusColor = [self LARYellowColor];
            break;
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            statusColor = [self LARGreenColor];
            break;
        default:
            statusColor = [self LARGreenColor];
            break;
    }
    return statusColor;
}

@end
