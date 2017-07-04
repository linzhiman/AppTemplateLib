//
//  ATContainerViewController.m
//  AppTemplateLib
//
//  Created by linzhiman on 2017/6/19.
//  Copyright © 2017年 zhiniu. All rights reserved.
//

#import "ATContainerViewController.h"
#import "ATGlobalMacro.h"

ATConstStringDefine(ATContainer_Prefix, @"ATContainer+")

@interface ATContainerViewController ()

@property (nonatomic, strong) UIViewController<ATContainerViewControllerProtocol> *subViewController;

@end

@implementation ATContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *restorationIdentifier = self.restorationIdentifier;
    if ([restorationIdentifier hasPrefix:ATContainer_Prefix]) {
        NSString *className = [restorationIdentifier substringFromIndex:ATContainer_Prefix.length];
        Class aClass = NSClassFromString(className);
        if ([aClass conformsToProtocol:@protocol(ATContainerViewControllerProtocol) ]) {
            id instance = [aClass at_createInstance];
            if ([instance isKindOfClass:[UIViewController class]]) {
                _subViewController = instance;
                [self addChildViewController:_subViewController];
                _subViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [self.view addSubview:_subViewController.view];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
