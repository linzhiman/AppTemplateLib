//
//  ATUserDefaults.m
//  yyfe
//
//  Created by linzhiman on 16/6/14.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import "ATUserDefaults.h"
#import "ATGlobalMacro.h"
#import "ATAppUtils.h"

@interface ATUserDefaults()
@property (nonatomic, strong) NSString *userIdentifier;
@property (nonatomic, strong) NSMutableDictionary *configs;
@end

@implementation ATUserDefaults

IMPLEMENT_SINGLETON(ATUserDefaults)

+ (ATUserDefaultsConfigType)configForKey:(NSString *)defaultName
{
    ATUserDefaultsConfigType type = ATUserDefaultsConfigType_Default;
    if ([ATUserDefaults sharedObject].configs) {
        NSNumber *value = [[ATUserDefaults sharedObject].configs objectForKey:defaultName];
        if (value) {
            type = (ATUserDefaultsConfigType)value.integerValue;
        }
    }
    return type;
}

+ (void)addConfig:(ATUserDefaultsConfigType)type forKey:(NSString *)defaultName
{
    if (![ATUserDefaults sharedObject].configs) {
        [ATUserDefaults sharedObject].configs = [[NSMutableDictionary alloc] init];
    }
    [[ATUserDefaults sharedObject].configs setObject:@(type) forKey:defaultName];
}

+ (void)setUserIdentifier:(NSString *)userIdentifier
{
    [ATUserDefaults sharedObject].userIdentifier = userIdentifier;
}

+ (NSString *)realKeyForKey:(NSString *)defaultName
{
    NSString *realKey = defaultName;
    
    ATUserDefaultsConfigType type = [self configForKey:defaultName];
    if (type & ATUserDefaultsConfigType_WithVersion) {
        NSString *version = [ATAppUtils bundleShortVersion];
        realKey = [NSString stringWithFormat:@"%@-%@", realKey, version];
    }
    if (type & ATUserDefaultsConfigType_WithUserIdentifier) {
        NSString *userIdentifier = [ATUserDefaults sharedObject].userIdentifier;
        NSAssert(userIdentifier != nil, @"Must set [ATUserDefaults sharedObject].userIdentifier");
        if (userIdentifier) {
            realKey = [NSString stringWithFormat:@"%@-%@", realKey, userIdentifier];
        }
    }
    return realKey;
}

+ (BOOL)boolForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    return [[NSUserDefaults standardUserDefaults] boolForKey:realKey];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:realKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)integerForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    return [[NSUserDefaults standardUserDefaults] integerForKey:realKey];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:realKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)stringForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    return [[NSUserDefaults standardUserDefaults] stringForKey:realKey];
}

+ (void)setString:(NSString *)value forKey:(NSString *)defaultName
{
    [self setObject:value forKey:defaultName];
}

+ (NSArray *)arrayForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    return [[NSUserDefaults standardUserDefaults] arrayForKey:realKey];
}

+ (void)setArray:(NSArray *)value forKey:(NSString *)defaultName
{
    [self setObject:value forKey:defaultName];
}

+ (NSDictionary *)dictionaryForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:realKey];
}

+ (void)setDictionary:(NSDictionary *)value forKey:(NSString *)defaultName
{
    [self setObject:value forKey:defaultName];
}

+ (NSObject *)objectForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    return [[NSUserDefaults standardUserDefaults] objectForKey:realKey];
}

+ (void)setObject:(NSObject *)value forKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:realKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeObjectForKey:(NSString *)defaultName
{
    NSString *realKey = [self realKeyForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:realKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
