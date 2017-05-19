//
//  ATHttpTask.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATHttpDefines.h"

@class ATHttpTask;

@protocol ATHttpTaskDelegate

- (void)onTaskFinish:(ATHttpTask *)task;

@end

@class ATHttpGet;
@class ATHttpPost;
@class ATHttpMultipartPost;

@interface ATHttpTask : NSObject

@property (atomic, unsafe_unretained) id<ATHttpTaskDelegate> delegate;
@property (atomic, readonly) BOOL isCancelled;

- (id)initWithHttpGet:(ATHttpGet *)httpGet block:(http_get_block_t)getBlock complete:(http_result_block_t)finishBlock;
- (id)initWithHttpPost:(ATHttpPost *)httpPost block:(http_post_block_t)postBlock complete:(http_result_block_t)finishBlock;
- (id)initWithHttpMultipartPost:(ATHttpMultipartPost *)httpMultipartPost block:(http_multipart_post_block_t)multipartPostBlock complete:(http_result_block_t)finishBlock;
- (void)start;
- (void)cancel;

@end
