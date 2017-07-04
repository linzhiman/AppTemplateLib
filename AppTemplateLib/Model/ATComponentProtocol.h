//
//  ATComponentProtocol.h
//  AppTemplateLib
//
//  Created by linzhiman on 2017/6/21.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ATComponentBaseImplementationBegin(atName) \
    + (void)registerComponent \
    { \
        [ATComponentService registerComponentWithName:atName withClass:[self class]]; \
    } \
    \
    + (id<ATComponentProtocol>)at_createComponentInstance \
    { \
        return [[self alloc] init]; \
    } \
    \
    - (NSDictionary *)at_callComponentWithCommand:(NSString *)command argument:(NSDictionary *)argument \
    { \
        NSDictionary *aDictionary = nil; \
        do { \

#define ATComponentBaseImplementationHandlerWithCommand(aCommand) \
            if ([command isEqualToString:aCommand]) {

#define ATComponentBaseImplementationHandlerWithCommandEnd \
                break; \
            }

#define ATComponentBaseImplementationEnd \
        } while(0); \
        return aDictionary; \
    }

@protocol ATComponentProtocol <NSObject>

+ (id<ATComponentProtocol>)at_createComponentInstance;
- (NSDictionary *)at_callComponentWithCommand:(NSString *)command argument:(NSDictionary *)argument;

@end
