//
//  ATResourceLoader.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/12/10.
//  Copyright © 2015年 apptemplate. All rights reserved.
//

#import "ATResourceLoader.h"

@implementation ATResourceLoader

+ (NSString *)resourceName:(NSString *)name withBundleName:(NSString *)bundleName
{
    return [NSString stringWithFormat:@"%@.bundle/%@", bundleName, name];
}

+ (UIImage *)imageNamed:(NSString *)imageName withBundleName:(NSString *)bundleName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (NSArray *)loadNibNamed:(NSString *)name owner:(id)owner withBundleName:(NSString *)bundleName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return [bundle loadNibNamed:name owner:owner options:nil];
}

@end
