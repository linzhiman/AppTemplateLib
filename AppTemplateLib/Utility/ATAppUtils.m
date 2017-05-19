//
//  ATAppUtils.m
//  yyfe
//
//  Created by linzhiman on 16/6/15.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import "ATAppUtils.h"

@implementation ATAppUtils

#pragma mark Device

+ (NSString *)deviceSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (BOOL)deviceSystemVersionLessThan8
{
    return [ATAppUtils deviceSystemVersion].floatValue < 8.f;
}

+ (NSString *)deviceModel
{
    return [UIDevice currentDevice].model;
}

+ (NSString *)deviceUUID
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (BOOL)deviceFlat
{
    return [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp
    || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown;
}

+ (BOOL)deviceUpsideDown
{
    return [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown;
}

+ (BOOL)deviceLandscape
{
    return [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft
    || [UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight;
}

+ (BOOL)deviceNotLandscape
{
    return [UIDevice currentDevice].orientation != UIInterfaceOrientationLandscapeLeft
    && [UIDevice currentDevice].orientation != UIInterfaceOrientationLandscapeRight;
}

+ (void)changeOrientation2Portrait
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
         [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationUnknown]
                                     forKey:@"orientation"];
    }
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}

+ (void)changeOrientation2LandscapeRight
{
    if ([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeRight) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationUnknown]
                                    forKey:@"orientation"];
    }
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]
                                forKey:@"orientation"];
}

+ (BOOL)deviceIsIphone4S
{
    return [UIScreen mainScreen].bounds.size.height <= 480;
}

#pragma mark Bundle

+ (NSBundle *)bundle
{
    return [NSBundle mainBundle];
}

+ (NSString *)bundlePath
{
    return [[ATAppUtils bundle] bundlePath];
}

+ (id)bundleInfoForKey:(NSString *)key
{
    return [[ATAppUtils bundle] objectForInfoDictionaryKey:key];
}

+ (NSString *)bundleIdentifier
{
    return [ATAppUtils bundleInfoForKey:@"CFBundleIdentifier"];
}

+ (NSString *)bundleName
{
    return [ATAppUtils bundleInfoForKey:@"CFBundleName"];
}

+ (NSString *)bundleDisplayName
{
    return [ATAppUtils bundleInfoForKey:@"CFBundleDisplayName"];
}

+ (NSString *)bundleShortVersion
{
    return [ATAppUtils bundleInfoForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)bundleVersion
{
    return [NSString stringWithFormat:@"%@.%@", [ATAppUtils bundleInfoForKey:@"CFBundleShortVersionString"], [ATAppUtils bundleInfoForKey:@"CFBundleVersion"]];
}

+ (NSString *)bundleSvnBuildVersion
{
    NSString *version = [ATAppUtils bundleInfoForKey:@"SvnBuildVersion"];
    if ([version hasPrefix:@"r"]) {
        version = [version substringFromIndex:1];
    }
    return version;
}

+ (BOOL)isEnterpriceBuild
{
    NSString *bundleIdentifier = [ATAppUtils bundleIdentifier];
    return [bundleIdentifier rangeOfString:@"com.yy.enterprise."].length > 0;
}

#pragma mark File manager methods

+ (NSFileManager *)fileManager
{
    return [NSFileManager defaultManager];
}

+ (BOOL)isPathExist:(NSString *)path
{
    return [[ATAppUtils fileManager] fileExistsAtPath:path];
}

+ (BOOL)isFileExist:(NSString *)path
{
    BOOL isDirectory;
    return [[ATAppUtils fileManager] fileExistsAtPath:path isDirectory:&isDirectory] && !isDirectory;
}

+ (BOOL)isDirectoryExist:(NSString *)path
{
    BOOL isDirectory;
    return [[ATAppUtils fileManager] fileExistsAtPath:path isDirectory:&isDirectory] && isDirectory;
}

+ (BOOL)removePath:(NSString *)path
{
    return [[ATAppUtils fileManager] removeItemAtPath:path error:nil];
}

+ (BOOL)createPath:(NSString *)path
{
    return [[ATAppUtils fileManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark User directory methods

+ (NSString *)appDocumentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)appResourcePath
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)appCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

#pragma mark lang

+ (NSString *)currentLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* curLang = [languages objectAtIndex:0];
    
    return curLang;
}

@end
