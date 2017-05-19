//
//  ATModelManager.m
//  yyfe
//
//  Created by linzhiman on 15/9/22.
//  Copyright (c) 2015年 yy.com. All rights reserved.
//

#import "ATModelManager.h"
#import "ATModelManagerProtocol.h"

static NSMapTable *modelsMap() {
    static NSMapTable *map = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return map;
}

static NSMapTable *modelClassesMap() {
    static NSMapTable *map = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return map;
}

@interface ATModelManager ()<ATModelManagerProtocol>

@end

@implementation ATModelManager

- (id)modelWithProtocol:(Protocol *)protocol
{
    id obj = [modelsMap() objectForKey:protocol];
    if (!obj) {
        Class class = [self classWithProtocol:protocol];
        if (class) {
            obj = [[class alloc] init];
            [self addModel:obj withProtocol:protocol];
        }
    }
    return obj;
}

- (void)addModel:(id)model withProtocol:(Protocol *)protocol
{
    if ([model conformsToProtocol:protocol]) {
        [modelsMap() setObject:model forKey:protocol];
    }
}

- (void)removeModelWithProtocol:(Protocol *)protocol
{
    id obj = [modelsMap() objectForKey:protocol];
    if (obj) {
        [modelsMap() removeObjectForKey:protocol];
    }
}

- (Class)classWithProtocol:(Protocol *)protocol
{
    return [modelClassesMap() objectForKey:protocol];
}

- (void)registerClass:(Class)aClass withProtocol:(Protocol *)protocol
{
    if ([aClass conformsToProtocol:protocol]) {
        [modelClassesMap() setObject:aClass forKey:protocol];
    }
}

- (void)unRegisterClassWithProtocol:(Protocol *)protocol
{
    id obj = [modelClassesMap() objectForKey:protocol];
    if (obj) {
        [modelClassesMap() removeObjectForKey:protocol];
    }
}


@end
