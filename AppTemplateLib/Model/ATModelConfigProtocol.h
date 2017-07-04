//
//  ATModelConfigProtocol.h
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLogProtocol.h"

//Protocol

@protocol ATModelConfigProtocol <NSObject>

@required - (void)initCustomModel:(NSDictionary *)launchOptions;
@required - (void)applicationWillTerminate;

@required - (id<ATLogProtocol>)logHandler;

@end
