//
//  ATLogHelper.m
//  apptemplatelib
//
//  Created by linzhiman on 5/8/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATLogHelper.h"

@implementation ATLogHelper

+ (ATLogHelper *)sharedObject
{
    static dispatch_once_t pre;
    static ATLogHelper *singletonInstance = nil;
    dispatch_once(&pre,^{
        singletonInstance = [[ATLogHelper alloc] init];
    });
    return singletonInstance;
}

- (void)logWithTag:(NSString *)tag level:(ATLogLevel)level function:(const char *)function file:(const char *)file line:(int)line content:(NSString *)format, ... NS_FORMAT_FUNCTION(6,7)
{
    va_list args;
    va_start(args, format);
    
    NSString *content = [[NSString alloc] initWithFormat:format arguments:args];
    
    if ([self.delegate respondsToSelector:@selector(logWithTag:level:function:file:line:content:)]) {
        [self.delegate logWithTag:tag level:level function:function file:file line:line content:content];
    }
    
    va_end(args);
}

- (NSString *)tagFromLevel:(ATLogLevel)level
{
    NSString *tag = @"";
    switch (level) {
        case ATLogLevel_Error:
            tag = @"Error";
            break;
        case ATLogLevel_Warn:
            tag = @"Warn";
            break;
        case ATLogLevel_Info:
            tag = @"Info";
            break;
        case ATLogLevel_Verbose:
            tag = @"Verbose";
            break;
        default:
            break;
    }
    return tag;
}

@end
