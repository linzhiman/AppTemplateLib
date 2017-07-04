//
//  ATComponentService.m
//  AppTemplateLib
//
//  Created by linzhiman on 2017/6/21.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import "ATComponentService.h"

static NSMapTable *ComponentMap() {
    static NSMapTable *map = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return map;
}

static NSMapTable *ComponentClassMap() {
    static NSMapTable *map = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return map;
}

@implementation ATComponentService

+ (BOOL)registerComponentWithName:(NSString *)name withClass:(Class)aClass
{
    if ([aClass conformsToProtocol:@protocol(ATComponentProtocol)]) {
        if (![ComponentClassMap() objectForKey:name]) {
            [ComponentClassMap() setObject:aClass forKey:name];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)unRegisterComponentWithName:(NSString *)name withClass:(Class)aClass
{
    Class oldClass = [ComponentClassMap() objectForKey:name];
    if (oldClass == aClass) {
        [ComponentClassMap() removeObjectForKey:name];
        return YES;
    }
    return NO;
}

+ (BOOL)registerComponentWithName:(NSString *)name withObject:(id<ATComponentProtocol>)anObject
{
    if (![ComponentMap() objectForKey:name]) {
        [ComponentMap() setObject:anObject forKey:name];
        return YES;
    }
    return NO;
}

+ (BOOL)unRegisterComponentWithName:(NSString *)name withObject:(id<ATComponentProtocol>)anObject
{
    id<ATComponentProtocol> oldObject = [ComponentMap() objectForKey:name];
    if (oldObject == anObject) {
        [ComponentMap() removeObjectForKey:name];
        return YES;
    }
    return NO;
}

+ (NSDictionary *)callComponentWithName:(NSString *)name command:(NSString *)command argument:(NSDictionary *)argument
{
    id<ATComponentProtocol> anObject = [ComponentMap() objectForKey:name];
    if (!anObject) {
        Class aClass = [ComponentClassMap() objectForKey:name];
        if (aClass) {
            anObject = [aClass at_createComponentInstance];
            [self registerComponentWithName:name withObject:anObject];
        }
    }
    
    NSDictionary *aDictionary = nil;
    
    if (!anObject) {
        aDictionary = @{@"errorCode":@(100),@"errorMessage":[NSString stringWithFormat:@"No component named %@", name]};
    }
    else {
        aDictionary = [anObject at_callComponentWithCommand:command argument:argument];
        if (!aDictionary) {
            aDictionary = @{@"errorCode":@(200),@"errorMessage":[NSString stringWithFormat:@"Unsupported command named %@ in %@", command, name]};
        }
    }
    
    return aDictionary;
}

@end