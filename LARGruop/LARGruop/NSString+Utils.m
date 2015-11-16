//
//  NSString+Utils.m
//  LARGruop
//
//  Created by Piero on 15/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

+(NSString *)getDateStringFromDate :(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSDate *)toDateFromDateString :(NSString *)dateString {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
@end
