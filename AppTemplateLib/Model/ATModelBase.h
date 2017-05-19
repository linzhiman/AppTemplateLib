//
//  ATModelBase.h
//  apptemplate
//
//  Created by linzhiman on 5/7/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATModelProtocol.h"

@interface ATModelBase : NSObject<ATModelProtocol>

- (void)initModel;//call in init
- (void)uninitModel;//call in dealloc

@end
