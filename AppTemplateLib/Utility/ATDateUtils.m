//
//  ATDateUtils.m
//  AppTemplateLib
//
//  Created by linzhiman on 2017/4/26.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import "ATDateUtils.h"

static NSMutableDictionary *dateFormatterMap() {
    static NSMutableDictionary *map = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = [NSMutableDictionary new];
    });
    return map;
}

@implementation ATDateUtils

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [dateFormatterMap() objectForKey:format];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = format;
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+08:00"];
        [dateFormatterMap() setObject:formatter forKey:format];
    }
    return formatter;
}

+ (NSString *)dateToString:(NSDate *)date
{
    return [self dateToStringEx:date withFormat:@"yyyy-MM-dd"];
}

+ (NSString *)dateToStringEx:(NSDate *)date withFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [self dateFormatterWithFormat:format];
    NSString *resultString= [dateFormatter stringFromDate:date];
    return resultString;
}

+ (NSDate *)stringToDate:(NSString *)string
{
    return [self stringToDateEx:string withFormat:@"yyyy-MM-dd"];
}

+ (NSDate *)stringToDateEx:(NSString *)string withFormat:(NSString*)format
{
    NSDateFormatter *dateFormatter = [self dateFormatterWithFormat:format];
    NSDate *resultDate= [dateFormatter dateFromString:string];
    return resultDate;
}

@end
