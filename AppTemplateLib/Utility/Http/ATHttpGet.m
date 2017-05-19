//
//  ATHttpGet.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import "ATHttpGet.h"
#import "ATHttpUtils.h"
#import "ATGlobalMacro.h"

@implementation ATHttpGet

- (NSData *)getForUrl:(NSString *)urlString response:(NSHTTPURLResponse **)response error:(NSError **)error
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:ATHttpRequestTimeout];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:response error:error];
    if (!data) {
        ATLogErrorWithClassName(ATHttpGet, @"[%@]:[%@]", urlString, *error);
    }
    return data;
}

- (void)getForUrl:(NSString *)urlString params:(NSDictionary *)params
{
    NSString *finalUrlString = [self combineUrl:urlString withGetParams:params];
    [self getForUrl:finalUrlString];
}

- (void)getForUrl:(NSString *)urlString
{
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [self getForUrl:urlString response:&response error:&error];
    [self.delegate onHttpGetResponse:response data:data error:error];
}

- (void)getForAnyOneInUrlList:(NSArray *)urlList
{
    for (NSString *urlString in urlList) {
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *data = [self getForUrl:urlString response:&response error:&error];
        if (data) {
            [self.delegate onHttpGetResponse:response data:data error:error];
            return;
        }
    }
}

- (void)getForAnyOneInUrlList:(NSArray *)urlList params:(NSDictionary *)params
{
    for (NSString *urlString in urlList) {
        NSHTTPURLResponse *response;
        NSError *error;
        NSString *finalUrlString = [self combineUrl:urlString withGetParams:params];
        NSData *data = [self getForUrl:finalUrlString response:&response error:&error];
        if (data) {
            [self.delegate onHttpGetResponse:response data:data error:error];
            return;
        }
    }
}

- (NSString *)combineUrl:(NSString *)url withGetParams:(NSDictionary *)dict
{
    if (!url || [url isEqualToString:@""]) {
        ATLogErrorWithClassName(ATHttpGet, @"url is nil");
        return nil;
    }
    if ([url rangeOfString:@"?"].location != NSNotFound) {
        return [NSString stringWithFormat:@"%@%@", url, [self httpGetParamsWithDictionary:dict]];
    } else {
        return [NSString stringWithFormat:@"%@?%@", url, [self httpGetParamsWithDictionary:dict]];
    }
}

- (NSString *)httpGetParamsWithDictionary:(NSDictionary *)dict
{
    NSMutableString *params = [NSMutableString string];
    for (NSString *key in [dict allKeys]) {
        if ([params length] > 0) {
            [params appendString:@"&"];
        }
        NSString *value = dict[key];
        if ([value isKindOfClass:[NSString class]]) {
            [params appendFormat:@"%@=%@", key, [ATHttpUtils urlEncode:value]];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            [params appendFormat:@"%@=%@", key, value];
        } else {
            ATLogErrorWithClassName(ATHttpGet, @"value %@ of %@ is not a NSString object", value, key);
        }
    }
    return params;
}
@end
