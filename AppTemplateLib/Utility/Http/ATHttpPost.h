//
//  ATHttpPost.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ATHttpDefines.h"

@protocol ATHttpPostDelegate

- (void)onHttpPostResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error;

@end

@interface ATHttpPost : NSObject

@property (atomic, unsafe_unretained) id<ATHttpPostDelegate> delegate;

- (void)postToUrl:(NSString *)urlString postData:(NSData *)postdata;
- (void)postToUrl:(NSString *)urlString params:(NSDictionary *)params;

@end
