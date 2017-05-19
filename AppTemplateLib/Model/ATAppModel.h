//
//  ATAppModel.h
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATModelConfigProtocol.h"
#import "ATModelProtocol.h"
#import "ATModelManagerProtocol.h"

#define ATAddModel(atModelClass) \
    [[ATAppModel sharedObject] addModel:[[atModelClass alloc] init] identifier:@#atModelClass];

#define ATGetModel(atModelClass) \
    ((atModelClass *)[[ATAppModel sharedObject] modelWithIdentifier:@#atModelClass])

#define ATDefineVariableOfModel(atModelClass) \
    atModelClass *model = (atModelClass *)[[ATAppModel sharedObject] modelWithIdentifier:@#atModelClass];

#define ATAddModelWithProtocol(atModelClass, atProtocol) \
    [[ATAppModel sharedObject].modelManager addModel:[[atModelClass alloc] init] withProtocol:@protocol(atProtocol)];

#define ATGetModelWithProtocol(atProtocol) \
    ((id<atProtocol>)[[ATAppModel sharedObject].modelManager modelWithProtocol:@protocol(atProtocol)])

@interface ATAppModel : NSObject

@property (nonatomic, strong, readonly) id<ATModelManagerProtocol> modelManager;

+ (ATAppModel *)sharedObject;

- (void)initModel:(NSDictionary *)launchOptions config:(id<ATModelConfigProtocol>)config;
- (void)applicationWillTerminate;

- (void)addModel:(id<ATModelProtocol>)model identifier:(NSString *)identifier;
- (id<ATModelProtocol>)modelWithIdentifier:(NSString *)identifier;

@end
