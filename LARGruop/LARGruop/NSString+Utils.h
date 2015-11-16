//
//  NSString+Utils.h
//  LARGruop
//
//  Created by Piero on 15/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

+(NSString *)getDateStringFromDate :(NSDate *)date;
+(NSDate *)toDateFromDateString :(NSString *)dateString ;
@end
