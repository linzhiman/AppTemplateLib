//
//  ATModelManagerProtocol.h
//  yyfe
//
//  Created by linzhiman on 15/9/22.
//  Copyright (c) 2015年 yy.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ATModelManagerProtocol <NSObject>

- (id)modelWithProtocol:(Protocol *)protocol;

- (void)addModel:(id)model withProtocol:(Protocol *)protocol;

- (void)removeModelWithProtocol:(Protocol *)protocol;

- (Class)classWithProtocol:(Protocol *)procotol;

- (void)registerClass:(Class)aClass withProtocol:(Protocol *)protocol;

- (void)unRegisterClassWithProtocol:(Protocol *)protocol;

@end
