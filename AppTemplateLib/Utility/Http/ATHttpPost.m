//
//  ATHttpPost.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import "ATHttpPost.h"
#import "ATHttpUtils.h"
#import "ATGlobalMacro.h"

@implementation ATHttpPost

- (NSData *)postToUrl:(NSString *)urlString postData:(NSData *)postData response:(NSHTTPURLResponse **)response error:(NSError **)error
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:ATHttpRequestTimeout];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:response error:error];
    if (!data) {
        ATLogErrorWithClassName(ATHttpPost, @"[%@]:[%@]", urlString, *error);
    }
    return data;
}

- (void)postToUrl:(NSString *)urlString postData:(NSData *)postdata
{
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [self postToUrl:urlString postData:postdata response:&response error:&error];
    [self.delegate onHttpPostResponse:response data:data error:error];
}

- (void)postToUrl:(NSString *)urlString params:(NSDictionary *)params
{
    NSMutableString *postString = [[NSMutableString alloc] init];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([postString length] > 0){
            [postString appendString:@"&"];
        }
        if ([obj isKindOfClass:[NSString class]]) {
            [postString appendFormat:@"%@=%@", key, [ATHttpUtils urlEncode:obj]];
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            [postString appendFormat:@"%@=%@", key, obj];
        } else {
            ATLogErrorWithClassName(ATHttpPost, @"value %@ of %@ is not a NSString object", obj, key);
        }
    }];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [self postToUrl:urlString postData:postData];
}

@end
