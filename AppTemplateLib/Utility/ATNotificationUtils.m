//
//  ATNotificationUtils.m
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATNotificationUtils.h"

@implementation ATNotificationUtils



+ (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
        });
    }
    
}

+ (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    if ([NSThread isMainThread]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
        });
    }
}

@end
