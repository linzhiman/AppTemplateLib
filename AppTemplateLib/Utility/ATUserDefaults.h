//
//  ATUserDefaults.h
//  yyfe
//
//  Created by linzhiman on 16/6/14.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ATUserDefaultsConfigType_Default = 1,
    ATUserDefaultsConfigType_WithVersion = 1 << 1,
    ATUserDefaultsConfigType_WithUserIdentifier = 1 << 2,
} ATUserDefaultsConfigType;

@interface ATUserDefaults : NSObject

+ (void)addConfig:(ATUserDefaultsConfigType)type forKey:(NSString *)defaultName;
+ (void)setUserIdentifier:(NSString *)userIdentifier;

+ (BOOL)boolForKey:(NSString *)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

+ (NSInteger)integerForKey:(NSString *)defaultName;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;

+ (NSString *)stringForKey:(NSString *)defaultName;
+ (void)setString:(NSString *)value forKey:(NSString *)defaultName;

+ (NSArray *)arrayForKey:(NSString *)defaultName;
+ (void)setArray:(NSArray *)value forKey:(NSString *)defaultName;

+ (NSDictionary *)dictionaryForKey:(NSString *)defaultName;
+ (void)setDictionary:(NSDictionary *)value forKey:(NSString *)defaultName;

+ (NSObject *)objectForKey:(NSString *)defaultName;
+ (void)setObject:(NSObject *)value forKey:(NSString *)defaultName;

+ (void)removeObjectForKey:(NSString *)defaultName;

@end
