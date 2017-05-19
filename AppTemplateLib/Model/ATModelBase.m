//
//  ATModelBase.m
//  apptemplate
//
//  Created by linzhiman on 5/7/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATModelBase.h"
#import "ATGlobalMacro.h"

@implementation ATModelBase

- (id)init
{
    self = [super init];
    if (self) {
        [self initModel];
    }
    return self;
}

- (void)dealloc
{
    [self uninitModel];
}

- (void)initModel
{
    
}

- (void)uninitModel
{
    ATUnRegisterAllNotification
}

@end
