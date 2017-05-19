//
//  ATModelConfigProtocol.h
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <UIKit/UIKit.h>

//Log

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

//Protocol

@protocol ATModelConfigProtocol <NSObject>

@required - (void)initCustomModel:(NSDictionary *)launchOptions;
@required - (void)applicationWillTerminate;

@required - (id<ATLogProtocol>)logHandler;

@end
