//
//  ATHttpMultipartPost.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import "ATHttpMultipartPost.h"

static NSString *const kReuqestMethod = @"POST";
static NSString *const kContentType = @"Content-Type";
static NSString *const kRequestContentTypeFormat = @"multipart/form-data; boundary=%@";
static NSString *const kMultiPartBoundary = @"--boundary_split_20130620";
static NSString *const kMultiStringPartFormat = @"\r\n--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@";
static NSString *const kDefaultMIME = @"application/octet-stream";
static NSString *const kMultiFilePartHeaderFormat = @"\r\n--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n";
static NSString *const kMultiFilePartMIMEFormat = @"Content-Type: %@\r\n\r\n";
static NSString *const kMultipartEndFormat = @"\r\n--%@--\r\n";

@implementation ATHttpMultipartPost
{
    NSMutableDictionary *_stringDict;
    NSMutableDictionary *_fileDict;
    NSMutableDictionary *_fileMIMEDict;
}

- (id)init
{
    self = [super init];
    if (self) {
        _stringDict = [NSMutableDictionary dictionary];
        _fileDict = [NSMutableDictionary dictionary];
        _fileMIMEDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    _fileMIMEDict = nil;
    _fileDict = nil;
    _stringDict = nil;
}

- (void)clearAllParts
{
    [_stringDict removeAllObjects];
    [_fileDict removeAllObjects];
    [_fileMIMEDict removeAllObjects];
}

- (void)addPart:(NSString *)value forName:(NSString *)name
{
    if (!value || !name)
        return;
    [_stringDict setObject:value forKey:name];
}

- (void)addFilePart:(NSString *)filePath forName:(NSString *)name fileMIME:(NSString *)fileMIME
{
    if (!filePath || !name)
        return;
    [_fileDict setObject:filePath forKey:name];
    if (fileMIME != nil) {
        [_fileMIMEDict setObject:fileMIME forKey:name];
    }
}

- (NSString *)getRequestContentType
{
    return [NSString stringWithFormat:kRequestContentTypeFormat, kMultiPartBoundary];
}

- (NSData *)getRequestBodyData
{
    NSMutableData *data = [NSMutableData data];
    for (NSString *name in [_stringDict allKeys]) {
        NSString *value = [_stringDict objectForKey:name];
        NSString *partString = [NSString stringWithFormat:kMultiStringPartFormat, kMultiPartBoundary, name, value];
        [data appendData:[partString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    for (NSString *name in [_fileDict allKeys]) {
        NSString *filePath = [_fileDict objectForKey:name];
        NSString *fileName = [filePath lastPathComponent];
        NSString *mime = [_fileMIMEDict objectForKey:name];
        if (mime == nil) {
            mime = kDefaultMIME;
        }
        NSString *partHeader = [NSString stringWithFormat:kMultiFilePartHeaderFormat, kMultiPartBoundary, name, fileName];
        [data appendData:[partHeader dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *partMIME = [NSString stringWithFormat:kMultiFilePartMIMEFormat, mime];
        [data appendData:[partMIME dataUsingEncoding:NSUTF8StringEncoding]];
        [data appendData:[NSData dataWithContentsOfFile:filePath]];
    }
    NSString *endString = [NSString stringWithFormat:kMultipartEndFormat, kMultiPartBoundary];
    [data appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}

- (void)postToUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:ATHttpRequestTimeout];
    [urlRequest setValue:[self getRequestContentType] forHTTPHeaderField:kContentType];
    [urlRequest setHTTPMethod: kReuqestMethod];
    [urlRequest setHTTPBody:[self getRequestBodyData]];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    NSHTTPURLResponse *response = nil;
    NSError* error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    [self.delegate onHttpMultipartPostResponse:response data:responseData error:error];
}

@end
