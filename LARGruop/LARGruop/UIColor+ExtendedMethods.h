//
//  UIColor+ExtendedMethods.h
//  LARGruop
//
//  Created by piero.sifuentes on 8/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (ExtendedMethods)


+(UIColor *)orangeLARColor;
+ (UIColor *)colorWithColor:(UIColor *)color andAlpha:(CGFloat)alpha;
+(UIColor*)colorForAvaibleDepartmentsCount:(NSInteger)leftDepartments;
+(UIColor*)LARYellowColor;
+(UIColor*)LARGreenColor;
+(UIColor*)LARRedColor;
+(UIColor*)LAROrangeColor;
+(UIColor*)LARGreyColor;
+(UIColor*)colorForInterestLevel:(NSInteger)interestLevel;
+(UIColor*)colorForInterestLevel:(NSInteger)interestLevel andColorShape:(UIColor*)color;
+(UIColor*)LARSkyBlueColor;
+(UIColor*)colorForDepartmentsStatus:(NSInteger)status;
@end
