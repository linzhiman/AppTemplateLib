//
//  ATResourceLoader.m
//  AppTemplateLib
//
//  Created by linzhiman on 15/12/10.
//  Copyright © 2015年 apptemplate. All rights reserved.
//

#import "ATResourceLoader.h"
#import "ATGlobalMacro.h"

@implementation ATResourceLoader

+ (NSString *)resourceName:(NSString *)name withBundleName:(NSString *)bundleName
{
    return [NSString stringWithFormat:@"%@.bundle/%@", bundleName, name];
}

+ (UIImage *)imageNamed:(NSString *)imageName withBundleName:(NSString *)bundleName
{
    NSBundle *bundle = [self bundleNamed:bundleName];
    if (ATSystemLessThan(8.0)) {
        NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    else {
        return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

+ (NSArray *)loadNibNamed:(NSString *)name owner:(id)owner withBundleName:(NSString *)bundleName
{
    NSBundle *bundle = [self bundleNamed:bundleName];
    return [bundle loadNibNamed:name owner:owner options:nil];
}

+ (NSBundle *)bundleNamed:(NSString *)bundleName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

@end
