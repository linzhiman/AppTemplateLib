//
//  ATFluidController.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/12/28.
//  Copyright © 2015年 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATFluidController;

typedef void (^ATShouldFluid)(ATFluidController *controller);

@protocol ATFluidControllerProtocol <NSObject>

- (void)shouldFluid:(ATFluidController *)controller;

@end

@interface ATFluidController : NSObject

@property (nonatomic, assign) NSUInteger delaySeconds;
@property (nonatomic, copy) ATShouldFluid callback;
@property (nonatomic, weak) id<ATFluidControllerProtocol> delegate;

@property (nonatomic, strong) id userInfo;

- (void)fluid;

@end
