//
//  ATFluidController.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/12/28.
//  Copyright © 2015年 apptemplate. All rights reserved.
//

#import "ATFluidController.h"
#import "ATGlobalMacro.h"

@interface ATFluidController ()
{
    NSDate *_lastFluid;
    BOOL _hasPerform;
}
@end

@implementation ATFluidController

- (id)init
{
    self = [super init];
    if (self) {
        _delaySeconds = 5;
        _lastFluid = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return self;
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)fluid
{
    NSDate *now = [NSDate date];
    NSTimeInterval time = [now timeIntervalSinceDate:_lastFluid];
    if (time > _delaySeconds) {
        [self callShouldFluid];
    }
    else {
        if (!_hasPerform) {
            _hasPerform = YES;
            [self performSelector:@selector(callShouldFluid) withObject:nil afterDelay:_delaySeconds];
        }
    }
}

- (void)callShouldFluid
{
    _hasPerform = NO;
    _lastFluid = [NSDate date];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    ATSafetyCallblock(self.callback, self)
    
    if ([self.delegate respondsToSelector:@selector(shouldFluid:)]) {
        [self.delegate shouldFluid:self];
    }
}

@end
