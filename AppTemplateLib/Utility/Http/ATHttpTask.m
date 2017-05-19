//
//  ATHttpTask.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import "ATHttpTask.h"
#import "ATHttpGet.h"
#import "ATHttpPost.h"
#import "ATHttpMultipartPost.h"

@interface ATHttpTask()<ATHttpGetDelegate, ATHttpPostDelegate, ATHttpMultipartPostDelegate>

@end

@implementation ATHttpTask
{
    ATHttpGet *_httpGet;
    http_get_block_t _getBlock;
    
    ATHttpPost *_httpPost;
    http_post_block_t _postBlock;
    
    ATHttpMultipartPost *_httpMultipartPost;
    http_multipart_post_block_t _multipartPostBlock;
    
    http_result_block_t _finishBlock;
    
    BOOL _isDone;
}

@synthesize isCancelled = _isCancelled;

- (id)initWithHttpGet:(ATHttpGet *)httpGet block:(http_get_block_t)getBlock complete:(http_result_block_t)finishBlock
{
    self = [super init];
    if (self) {
        _httpGet = httpGet;
        _httpGet.delegate = self;
        _getBlock = getBlock;
        _httpPost = nil;
        _httpMultipartPost = nil;
        _finishBlock = finishBlock;
        _isCancelled = NO;
        _isDone = NO;
    }
    return self;
}

- (id)initWithHttpPost:(ATHttpPost *)httpPost block:(http_post_block_t)postBlock complete:(http_result_block_t)finishBlock
{
    self = [super init];
    if (self) {
        _httpGet = nil;
        _httpPost = httpPost;
        _httpPost.delegate = self;
        _postBlock = postBlock;
        _httpMultipartPost = nil;
        _finishBlock = finishBlock;
        _isCancelled = NO;
        _isDone = NO;
    }
    return self;
}

- (id)initWithHttpMultipartPost:(ATHttpMultipartPost *)httpMultipartPost
                          block:(http_multipart_post_block_t)multipartPostBlock
                       complete:(http_result_block_t)finishBlock
{
    self = [super init];
    if (self) {
        _httpGet = nil;
        _httpPost = nil;
        _httpMultipartPost = httpMultipartPost;
        _httpMultipartPost.delegate = self;
        _multipartPostBlock = multipartPostBlock;
        _finishBlock = finishBlock;
        _isCancelled = NO;
        _isDone = NO;
    }
    return self;
}

- (void)dealloc
{
    _httpGet.delegate = nil;
    _httpGet = nil;
    _httpPost.delegate = nil;
    _httpPost = nil;
    _httpMultipartPost.delegate = nil;
    _httpMultipartPost = nil;
}

- (void)onHttpGetResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error
{
    [self notifyHttpQueueAndCaller:response data:data error:error];
}

- (void)onHttpPostResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error
{
    [self notifyHttpQueueAndCaller:response data:data error:error];
}

- (void)onHttpMultipartPostResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error
{
    [self notifyHttpQueueAndCaller:response data:data error:error];
}

- (void)notifyHttpQueueAndCaller:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error
{
    _isDone = YES;
    [self.delegate onTaskFinish:self];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            _finishBlock(response, data, error);
        } else {
            _finishBlock(nil, data, error);
        }
    });
}

- (void)start
{
    if (self.isCancelled) {
        NSError *error = [NSError errorWithDomain:@"http task was cancelled" code:ATHttpErrorTaskWasCancelled userInfo:nil];
        [self notifyHttpQueueAndCaller:nil data:nil error:error];
    } else {
        if (_httpGet != nil) {
            _getBlock(_httpGet);
        } else if (_httpPost != nil) {
            _postBlock(_httpPost);
        } else if (_httpMultipartPost != nil) {
            _multipartPostBlock(_httpMultipartPost);
        }
        //because all requests are processed synchronized, if task is NOT done,
        //means caller forget to call getForUrl/postToUrl
        if (!_isDone) {
            NSError *error = [NSError errorWithDomain:@"forgot to start http request?" code:ATHttpErrorForgetStartHttpRequest userInfo:nil];
            [self notifyHttpQueueAndCaller:nil data:nil error:error];
        }
    }
}

- (void)cancel
{
    _isCancelled = YES;
}

@end
