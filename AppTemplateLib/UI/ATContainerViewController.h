//
//  ATContainerViewController.h
//  AppTemplateLib
//
//  Created by linzhiman on 2017/6/19.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ATContainerViewControllerProtocol <NSObject>
+ (id)at_createInstance;
@end

/**
 Storyboard中指定UIViewController的ClassName为ATContainerViewController，并设置Restoration Id为ATContainer+目标controller类名，目录类需实现ATContainerViewControllerProtocol，后续将调用at_createInstance方法创建目标实例，并addChildViewController/addSubView。
 */
@interface ATContainerViewController : UIViewController

@end
