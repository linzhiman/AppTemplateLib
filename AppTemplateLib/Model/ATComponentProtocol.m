//
//  ATComponentProtocol.m
//  AppTemplateLib
//
//  Created by linzhiman on 2017/6/21.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import "ATComponentProtocol.h"

@implementation ATComponentCaller

+ (ATComponentCaller *)callerWithName:(NSString *)name callbackCommand:(NSString *)callbackCommand
{
    ATComponentCaller *caller = [ATComponentCaller new];
    caller.name = name;
    caller.callbackCommand = callbackCommand;
    return caller;
}

@end
