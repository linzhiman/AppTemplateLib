//
//  ATLogHelper.h
//  apptemplatelib
//
//  Created by linzhiman on 5/8/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATLogProtocol.h"

@interface ATLogHelper : NSObject

@property (strong, nonatomic) id<ATLogProtocol> delegate;

+ (ATLogHelper *)sharedObject;

- (void)logWithTag:(NSString *)tag level:(ATLogLevel)level function:(const char *)function file:(const char *)file line:(int)line content:(NSString *)format, ... NS_FORMAT_FUNCTION(6,7);

@end
