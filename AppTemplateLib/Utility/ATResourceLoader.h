//
//  ATResourceLoader.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/12/10.
//  Copyright © 2015年 apptemplate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATResourceLoader : NSObject

//bundleName不带.bundle后缀

+ (NSString *)resourceName:(NSString *)name withBundleName:(NSString *)bundleName;

+ (UIImage *)imageNamed:(NSString *)imageName withBundleName:(NSString *)bundleName;

+ (NSArray *)loadNibNamed:(NSString *)name owner:(id)owner withBundleName:(NSString *)bundleName;

+ (NSBundle *)bundleNamed:(NSString *)bundleName;

@end
