//
//  ATAppModel.m
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATAppModel.h"
#import "ATLogHelper.h"
#import "ATGlobalMacro.h"
#import "ATModelManager.h"

@interface ATAppModel ()
{
    NSMutableDictionary *_models;
    __weak id<ATModelConfigProtocol> _config;
}
@end

@implementation ATAppModel

+ (ATAppModel *)sharedObject
{
    static dispatch_once_t pre;
    static ATAppModel *singletonInstance = nil;
    dispatch_once(&pre,^{
        singletonInstance = [[ATAppModel alloc] init];
    });
    return singletonInstance;
}

- (void)initModel:(NSDictionary *)launchOptions config:(id<ATModelConfigProtocol>)config
{
    [ATLogHelper sharedObject].delegate = [config logHandler];
    
    _modelManager = [[ATModelManager alloc] init];
    
    _config = config;
    [config initCustomModel:launchOptions];
    
    ATLogInfo(@"AppTemplate", @"initModel done");
}

- (void)applicationWillTerminate
{
    if (_config) {
        [_config applicationWillTerminate];
    }
}

- (void)addModel:(id<ATModelProtocol>)model identifier:(NSString *)identifier
{
    if (_models == nil) {
        _models = [[NSMutableDictionary alloc] init];
    }
    
    [_models setObject:model forKey:identifier];
}

- (id<ATModelProtocol>)modelWithIdentifier:(NSString *)identifier
{
    if (_models == nil) {
        return nil;
    }
    
    return [_models objectForKey:identifier];
}

@end
