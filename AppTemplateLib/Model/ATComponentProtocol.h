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
    - (NSDictionary *)at_callComponentWithCommand:(NSString *)command argument:(NSDictionary *)argument caller:(ATComponentCaller *)caller \
    { \
        NSDictionary *aDictionary = nil; \
        do { \

#define ATComponentBaseImplementationHandlerWithCommandBegin(aCommand) \
            if ([command isEqualToString:aCommand]) {

#define ATComponentBaseImplementationHandlerWithCommandEnd \
                break; \
            }

#define ATComponentBaseImplementationEnd \
        } while(0); \
        return aDictionary; \
    }


#define ATComponentArgument_Caller caller:(ATComponentCaller *)caller
#define ATComponentArgument_Callback callback:(ATComponentCallback)callback

typedef void (^ATComponentCallback)(NSString *command, NSDictionary *argument);

@interface ATComponentCaller : NSObject
@property (nonatomic, assign) NSInteger seqID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *callbackCommand;
+ (ATComponentCaller *)callerWithName:(NSString *)name callbackCommand:(NSString *)callbackCommand;
@end

@protocol ATComponentProtocol <NSObject>

+ (id<ATComponentProtocol>)at_createComponentInstance;
- (NSDictionary *)at_callComponentWithCommand:(NSString *)command argument:(NSDictionary *)argument ATComponentArgument_Caller;
- (NSDictionary *)at_callComponentWithCommand:(NSString *)command argument:(NSDictionary *)argument ATComponentArgument_Callback;

@end
