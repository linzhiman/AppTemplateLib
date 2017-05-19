//
//  ATHashUtils.m
//  
//
//  Created by Wu Wenqing on 12-9-17.
//  Copyright (c) 2012年 Wu Wenqing. All rights reserved.
//

#import "ATHashUtils.h"
#import <CommonCrypto/CommonDigest.h>

static const int kMd5BufferLength = 16;
static const int kSHa1BufferLength = 20;

@interface NSString(Hash)

- (NSString *)stringForMD5;
- (NSString *)stringForSHA1;

@end

@interface NSData(Hash)

- (NSData *)dataForMD5;
- (NSData *)dataForSHA1;
- (NSString *)hexString;

@end

@interface NSFileHandle(Hash)

- (NSString *)fileMD5HexString;
- (NSString *)fileSHA1HexString;

@end

@implementation ATHashUtils

+ (NSString *)sha1HexString:(NSString *)str
{
    return [str stringForSHA1];
}

+ (NSString *)md5HexString:(NSString *)str
{
    return [str stringForMD5];
}

+ (NSString *)fileMd5HexString:(NSString *)filePath
{
    NSFileHandle* handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (handle == nil)
        return nil;
    return [handle fileMD5HexString];
}

+ (NSString *)fileSha1HexString:(NSString *)filePath
{
    NSFileHandle* handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (handle == nil)
        return nil;
    return [handle fileSHA1HexString];
}

+ (NSString *)dataMd5HexString:(NSData *)data
{
    NSData *md5Data = [data dataForMD5];
    NSString *hexString = [md5Data hexString];
    return hexString;
}

@end

@implementation NSString(Hash)

- (NSString *)stringForMD5
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[data dataForMD5] hexString];
}

- (NSString *)stringForSHA1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[data dataForSHA1] hexString];
}

@end

@implementation NSData(Hash)

- (NSData *)dataForMD5
{
    const char *str = [self bytes];
    unsigned char digest[kMd5BufferLength];
    CC_MD5(str, (CC_LONG)[self length], digest);
    return [NSData dataWithBytes:digest length:kMd5BufferLength];
}

- (NSData *)dataForSHA1
{
    const unsigned char *buffer = [self bytes];
    unsigned char result[kSHa1BufferLength];
    CC_SHA1(buffer, (CC_LONG)[self length], result);
    return [NSData dataWithBytes:result length:kSHa1BufferLength];
}

- (NSString *)hexString
{
    const int length = (CC_LONG)[self length];
    const unsigned char *str = [self bytes];
    NSMutableString *hexStr = [NSMutableString stringWithCapacity:length*2];
    for (int i=0; i<length; i++) {
        [hexStr appendFormat:@"%02x", str[i]];
    }
    return hexStr;
}

@end

static const int kBufferSize = 1024;

@implementation NSFileHandle(Hash)

- (NSString *)fileMD5HexString
{
    assert(self != nil);
    CC_MD5_CTX ctx;
    CC_MD5_Init(&ctx);
    NSData* data = [self readDataOfLength:kBufferSize];
    while (data && [data length] > 0) {
        CC_MD5_Update(&ctx, [data bytes], (CC_LONG)[data length]);
        data = [self readDataOfLength:kBufferSize];
    }
    unsigned char result[kMd5BufferLength];
    CC_MD5_Final(result, &ctx);
    return [[NSData dataWithBytes:result length:kMd5BufferLength] hexString];
}

- (NSString *)fileSHA1HexString
{
    assert(self != nil);
    CC_SHA1_CTX ctx;
    CC_SHA1_Init(&ctx);
    NSData* data = [self readDataOfLength:kBufferSize];
    while (data && [data length] > 0) {
        CC_SHA1_Update(&ctx, [data bytes], (CC_LONG)[data length]);
        data = [self readDataOfLength:kBufferSize];
    }
    unsigned char result[kSHa1BufferLength];
    CC_SHA1_Final(result, &ctx);
    return [[NSData dataWithBytes:result length:kSHa1BufferLength] hexString];
}

@end

