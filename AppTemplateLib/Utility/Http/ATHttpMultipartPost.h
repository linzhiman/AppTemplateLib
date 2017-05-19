//
//  ATHttpMultipartPost.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATHttpDefines.h"

@protocol ATHttpMultipartPostDelegate

- (void)onHttpMultipartPostResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *)error;

@end

@interface ATHttpMultipartPost : NSObject

@property (atomic, unsafe_unretained) id<ATHttpMultipartPostDelegate> delegate;

- (void)clearAllParts;
- (void)addPart:(NSString *)value forName:(NSString *)name;
- (void)addFilePart:(NSString *)filePath forName:(NSString *)name fileMIME:(NSString *)fileMIME;
- (void)postToUrl:(NSString *)urlString;

@end
