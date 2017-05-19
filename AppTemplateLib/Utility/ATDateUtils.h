//
//  ATDateUtils.h
//  AppTemplateLib
//
//  Created by linzhiman on 2017/4/26.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATDateUtils : NSObject

+ (NSString *)dateToString:(NSDate *)date;//default: yyyy-MM-dd
+ (NSString *)dateToStringEx:(NSDate *)date withFormat:(NSString*)format;

+ (NSDate *)stringToDate:(NSString *)string;//default: yyyy-MM-dd
+ (NSDate *)stringToDateEx:(NSString *)string withFormat:(NSString*)format;

@end
