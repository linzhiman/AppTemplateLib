//
//  ATAppUtils.h
//  yyfe
//
//  Created by linzhiman on 16/6/15.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATAppUtils : NSObject

#pragma mark Device

+ (NSString *)deviceSystemVersion;
+ (BOOL)deviceSystemVersionLessThan8;
+ (NSString *)deviceModel;
+ (NSString *)deviceUUID;
+ (NSString *)carrierName;
+ (BOOL)deviceFlat;
+ (BOOL)deviceUpsideDown;
+ (BOOL)deviceLandscape;
+ (BOOL)deviceNotLandscape;
+ (void)changeOrientation2Portrait;
+ (void)changeOrientation2LandscapeRight;

+ (BOOL)deviceIsIphone4S;

#pragma mark Boudle methods

+ (NSBundle *)bundle;
+ (NSString *)bundlePath;
+ (id)bundleInfoForKey:(NSString *)key;
+ (NSString *)bundleIdentifier;
+ (NSString *)bundleName;
+ (NSString *)bundleDisplayName;
+ (NSString *)bundleShortVersion;
+ (NSString *)bundleVersion;
+ (NSString *)bundleSvnBuildVersion;
+ (BOOL)isEnterpriceBuild;

#pragma mark File manager methods

+ (NSFileManager *)fileManager;
+ (BOOL)isPathExist:(NSString *)path;
+ (BOOL)isFileExist:(NSString *)path;
+ (BOOL)isDirectoryExist:(NSString *)path;
+ (BOOL)removePath:(NSString *)path;
+ (BOOL)createPath:(NSString *)path;

#pragma mark User directory methods

+ (NSString *)appDocumentPath;
+ (NSString *)appResourcePath;
+ (NSString *)appCachePath;

#pragma mark lang

+ (NSString *)currentLanguage;

@end
