//
//  NSDictionary+JSONSafeGet.m
//  yyfe
//
//  Created by linzhiman on 16/1/26.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import "NSDictionary+JSONSafeGet.h"

#define ATJSONSafeGet_CheckKey(aKey, aReturnValue) \
    if (!aKey) { \
        return aReturnValue; \
    }

@implementation NSDictionary (JSONSafeGet)

- (NSString *)JSONString
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:nil] encoding:NSUTF8StringEncoding];
}

- (NSInteger)integerSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value integerValue];
}

- (uint32_t)unsignedIntSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value unsignedIntValue];
}

- (uint64_t)unsignedLongLongSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value unsignedLongLongValue];
}


- (int)intValueSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value intValue];
}

- (long)longValueSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value longValue];
}

- (long long) longLongValueSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value longLongValue];
}

- (float)floatValueSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value floatValue];
}

- (double)doubleValueSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value doubleValue];
}

- (BOOL)boolValueSafeGet:(id)aKey
{
    NSNumber *value = [self numberSafeGet:aKey];
    return [value boolValue];
}

- (NSNumber *)numberSafeGet:(id)aKey
{
    ATJSONSafeGet_CheckKey(aKey, nil);
    
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSNumber class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (NSString *)stringSafeGet:(id)aKey
{
    ATJSONSafeGet_CheckKey(aKey, nil);
    
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSString class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (NSArray *)arraySafeGet:(id)aKey
{
    ATJSONSafeGet_CheckKey(aKey, nil);
    
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSArray class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (NSDictionary *)dictionarySafeGet:(id)aKey
{
    ATJSONSafeGet_CheckKey(aKey, nil);
    
    id tmp = [self objectForKey:aKey];
    if (![tmp isKindOfClass:[NSDictionary class]] || [tmp isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return tmp;
}

- (id)get:(id)key shouldRetrunNil:(BOOL)flag retrunClass:(Class)class
{
    ATJSONSafeGet_CheckKey(key, (flag ? nil : [class new]));
    
    id tmp = [self objectForKey:key];
    if (![tmp isKindOfClass:class] || [tmp isKindOfClass:[NSNull class]]) {
        return (flag ? nil : [class new]);
    }
    return tmp;

}

- (NSString *)notNilStringGet:(id)key
{
    return (NSString *)[self get:key shouldRetrunNil:NO retrunClass:[NSString class]];
}

- (NSArray *)notNilArrayGet:(id)key
{
    return (NSArray *)[self get:key shouldRetrunNil:NO retrunClass:[NSArray class]];
}

- (NSDictionary *)notNilDictionaryGet:(id)key
{
    return (NSDictionary *)[self get:key shouldRetrunNil:NO retrunClass:[NSDictionary class]];
}

@end


@implementation NSDictionary (JSONSafeGetEx)

- (NSInteger)integerSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return [value integerValue];
    }
    else {
        return [self integerSafeGet:aKey];
    }
}

- (uint32_t)unsignedIntSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return (uint32_t)[value longLongValue];
    }
    else {
        return [self unsignedIntSafeGet:aKey];
    }
}

- (int)intValueSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return [value intValue];
    }
    else {
        return [self intValueSafeGet:aKey];
    }
}

- (long)longValueSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return (long)[value longLongValue];
    }
    else {
        return [self longValueSafeGet:aKey];
    }
}

- (long long)longLongValueSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return [value longLongValue];
    }
    else {
        return [self longLongValueSafeGet:aKey];
    }
}

- (float)floatValueSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return [value floatValue];
    }
    else {
        return [self floatValueSafeGet:aKey];
    }
}

- (double)doubleValueSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return [value doubleValue];
    }
    else {
        return [self doubleValueSafeGet:aKey];
    }
}

- (BOOL)boolValueSafeGetEx:(id)aKey
{
    NSString *value = [self stringSafeGet:aKey];
    if (value) {
        return [value boolValue];
    }
    else {
        return [self boolValueSafeGet:aKey];
    }
}

@end

