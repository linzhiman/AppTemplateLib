//
//  ATHttpGet.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATHttpDefines.h"

@protocol ATHttpGetDelegate

- (void)onHttpGetResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error;

@end

@interface ATHttpGet : NSObject

@property (atomic, unsafe_unretained) id<ATHttpGetDelegate> delegate;

- (void)getForUrl:(NSString *)urlString;
- (void)getForUrl:(NSString *)urlString params:(NSDictionary *)params;

- (void)getForAnyOneInUrlList:(NSArray *)urlList;
- (void)getForAnyOneInUrlList:(NSArray *)urlList params:(NSDictionary *)params;

@end
