//
//  ATHttpQueue.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import "ATHttpQueue.h"
#import "ATGlobalMacro.h"

static const uint32_t kDefaultMaxConcurrentTaskCount = 10;

static ATHttpQueue *globalHttpQueue = nil;

@interface ATHttpQueue() <ATHttpTaskDelegate>

@end

@implementation ATHttpQueue
{
    dispatch_queue_t _taskQueue;
    NSMutableArray *_tasks;
    uint32_t _runningTaskCount;
}

+ (ATHttpQueue *)sharedObject
{
    if (globalHttpQueue != nil) {
        return globalHttpQueue;
    }
    @synchronized(self) {
        if (globalHttpQueue == nil) {
            globalHttpQueue = [[ATHttpQueue alloc] init];
        }
        return globalHttpQueue;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        _taskQueue = dispatch_queue_create("com.yy.apptemplate.HttpTaskQueue", DISPATCH_QUEUE_SERIAL);
        _tasks = [NSMutableArray array];
        self.maxConcurrentTaskCount = kDefaultMaxConcurrentTaskCount;
        _runningTaskCount = 0;
    }
    return self;
}

- (ATHttpTask *)addGetTask:(http_get_block_t)block onFinished:(http_result_block_t)completeBlock
{
    ATHttpGet * httpGet = [[ATHttpGet alloc] init];
    ATHttpTask *task = [[ATHttpTask alloc] initWithHttpGet:httpGet block:block complete:completeBlock];
    task.delegate = self;
    
    ATWeakSelf
    dispatch_async(_taskQueue, ^{
        if (weakSelf) {
            ATStrongSelf
            [strongSelf->_tasks addObject:task];
            [strongSelf dispatchTask];
        }
    });
    return task;
}

- (ATHttpTask *)addPostTask:(http_post_block_t)block onFinished:(http_result_block_t)completeBlock
{
    ATHttpPost * httpPost = [[ATHttpPost alloc] init];
    ATHttpTask *task = [[ATHttpTask alloc] initWithHttpPost:httpPost block:block complete:completeBlock];
    task.delegate = self;
    
    ATWeakSelf
    dispatch_async(_taskQueue, ^{
        if (weakSelf) {
            ATStrongSelf
            [strongSelf->_tasks addObject:task];
            [strongSelf dispatchTask];
        }
    });
    return task;
}

- (ATHttpTask *)addMultipartPostTask:(http_multipart_post_block_t)block onFinished:(http_result_block_t)completeBlock
{
    ATHttpMultipartPost * multipartPost = [[ATHttpMultipartPost alloc] init];
    ATHttpTask *task = [[ATHttpTask alloc] initWithHttpMultipartPost:multipartPost block:block complete:completeBlock];
    task.delegate = self;
    
    ATWeakSelf
    dispatch_async(_taskQueue, ^{
        if (weakSelf) {
            ATStrongSelf
            [strongSelf->_tasks addObject:task];
            [strongSelf dispatchTask];
        }
    });
    return task;
}

- (void)dispatchTask
{
    ATWeakSelf
    dispatch_async(_taskQueue, ^{
        if (weakSelf) {
            ATStrongSelf
            if ([strongSelf->_tasks count] <= 0)
                return;
            if (strongSelf->_runningTaskCount >= strongSelf.maxConcurrentTaskCount) {
                ATLogInfoWithClassName(ATHttpQueue, @"running task count is %d, this task will run later.", _runningTaskCount);
                return;
            }
            strongSelf->_runningTaskCount++;
            ATHttpTask *task = [strongSelf->_tasks objectAtIndex:0];
            [strongSelf->_tasks removeObjectAtIndex:0];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                [task start];
            });
        }
    });
}

- (void)onTaskFinish:(ATHttpTask *)task
{
    ATWeakSelf
    dispatch_async(_taskQueue, ^{
        if (weakSelf) {
            ATStrongSelf
            strongSelf->_runningTaskCount--;
            [strongSelf dispatchTask];
        }
    });
}

@end
