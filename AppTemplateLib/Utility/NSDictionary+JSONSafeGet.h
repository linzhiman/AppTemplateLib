//
//  NSDictionary+JSONSafeGet.h
//  yyfe
//
//  Created by linzhiman on 16/1/26.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONSafeGet)

- (NSString *)JSONString;

- (NSInteger)integerSafeGet:(id)aKey;
- (uint32_t)unsignedIntSafeGet:(id)aKey;
- (uint64_t)unsignedLongLongSafeGet:(id)aKey;

- (int)intValueSafeGet:(id)aKey;
- (long)longValueSafeGet:(id)aKey;
- (long long)longLongValueSafeGet:(id)aKey;
- (float)floatValueSafeGet:(id)aKey;
- (double)doubleValueSafeGet:(id)aKey;
- (BOOL)boolValueSafeGet:(id)aKey;

- (NSNumber *)numberSafeGet:(id)aKey;

- (NSString *)stringSafeGet:(id)aKey;
- (NSArray *)arraySafeGet:(id)aKey;
- (NSDictionary *)dictionarySafeGet:(id)aKey;

- (NSString *)notNilStringGet:(id)key; //nil -> @""
- (NSArray *)notNilArrayGet:(id)key; //nil -> @[]
- (NSDictionary *)notNilDictionaryGet:(id)key; //nil -> @{};

@end


@interface NSDictionary (JSONSafeGetEx)

- (NSInteger)integerSafeGetEx:(id)aKey;
- (uint32_t)unsignedIntSafeGetEx:(id)aKey;

- (int)intValueSafeGetEx:(id)aKey;
- (long)longValueSafeGetEx:(id)aKey;
- (long long)longLongValueSafeGetEx:(id)aKey;
- (float)floatValueSafeGetEx:(id)aKey;
- (double)doubleValueSafeGetEx:(id)aKey;
- (BOOL)boolValueSafeGetEx:(id)aKey;

@end
