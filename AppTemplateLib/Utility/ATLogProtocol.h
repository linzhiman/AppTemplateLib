//
//  ATLogProtocol.h
//  AppTemplateLib
//
//  Created by linzhiman on 2017/5/27.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ATLogLevel) {
    ATLogLevel_Important,
    ATLogLevel_Error,
    ATLogLevel_Warn,
    ATLogLevel_Info,
    ATLogLevel_Verbose
};

@protocol ATLogProtocol <NSObject>

@required - (void)logWithTag:(NSString *)tag level:(ATLogLevel)level function:(const char *)function file:(const char *)file line:(NSUInteger)line content:(NSString *)content;

@end
