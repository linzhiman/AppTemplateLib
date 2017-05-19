//
//  ATHttpQueue.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATHttpDefines.h"
#import "ATHttpGet.h"
#import "ATHttpPost.h"
#import "ATHttpMultipartPost.h"
#import "ATHttpTask.h"

@interface ATHttpQueue : NSObject

@property (nonatomic, assign) uint32_t maxConcurrentTaskCount;

+ (ATHttpQueue *)sharedObject;

- (ATHttpTask *)addGetTask:(http_get_block_t)block onFinished:(http_result_block_t)completeBlock;
- (ATHttpTask *)addPostTask:(http_post_block_t)block onFinished:(http_result_block_t)completeBlock;
- (ATHttpTask *)addMultipartPostTask:(http_multipart_post_block_t)block onFinished:(http_result_block_t)completeBlock;

@end
