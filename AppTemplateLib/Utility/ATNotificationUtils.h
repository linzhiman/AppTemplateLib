//
//  ATNotificationUtils.h
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATNotificationUtils : NSObject

+ (void)postNotificationName:(NSString *)aName object:(id)anObject;
+ (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end
