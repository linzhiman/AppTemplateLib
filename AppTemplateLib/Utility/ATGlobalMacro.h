//
//  ATGlobalMacro.h
//  apptemplate
//
//  Created by linzhiman on 4/30/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATNotificationUtils.h"
#import "ATLogHelper.h"

#define ATStringFromObjectName(atName) @#atName

//NSString

#define ATConstStringDefine(atName, atValue) \
    NSString * const atName = atValue;

#define ATConstStringDefineWithDefaultValue(atName) \
    ATConstStringDefine(atName, @#atName)

#define ATConstStringExtern(atName) \
    extern NSString * const atName;

//Log

#define ATLog(atTag, atLevel, atFormat, ...) \
        [[ATLogHelper sharedObject] logWithTag:atTag level:atLevel function:__func__ file:__FILE__ line:__LINE__ content:atFormat, ##__VA_ARGS__];
#define ATLogImportant(atTag, atFormat, ...) \
        ATLog(atTag, ATLogLevel_Important, atFormat, ##__VA_ARGS__)
#define ATLogError(atTag, atFormat, ...) \
        ATLog(atTag, ATLogLevel_Error, atFormat, ##__VA_ARGS__)
#define ATLogWarn(atTag, atFormat, ...) \
        ATLog(atTag, ATLogLevel_Warn, atFormat, ##__VA_ARGS__)
#define ATLogInfo(atTag, atFormat, ...) \
        ATLog(atTag, ATLogLevel_Info, atFormat, ##__VA_ARGS__)
#define ATLogVerbose(atTag, atFormat, ...) \
        ATLog(atTag, ATLogLevel_Verbose, atFormat, ##__VA_ARGS__)

#define ATLogErrorWithClassName(atClassName, atFormat, ...) \
        ATLogError(@#atClassName, atFormat, ##__VA_ARGS__)
#define ATLogWarnWithClassName(atClassName, atFormat, ...) \
        ATLogWarn(@#atClassName, atFormat, ##__VA_ARGS__)
#define ATLogInfoWithClassName(atClassName, atFormat, ...) \
        ATLogInfo(@#atClassName, atFormat, ##__VA_ARGS__)
#define ATLogVerboseWithClassName(atClassName, atFormat, ...) \
        ATLogVerbose(@#atClassName, atFormat, ##__VA_ARGS__)

//Notification

#define ATRegisterNotification(atName, atSelector, atObserver, atObject) \
        [[NSNotificationCenter defaultCenter] addObserver:atObserver selector:@selector(atSelector:) name:atName object:atObject];

#define ATRegisterNotificationDefault(atName, atSelector) \
        ATRegisterNotification(atName, atSelector, self, nil)

#define ATPostNotification(atName, atObject) \
        [ATNotificationUtils postNotificationName:atName object:atObject];

#define ATPostNotificationDefault(atName) \
        ATPostNotification(atName, self)

#define ATPostNotificationWithUserInfo(atName, atObject, atUserInfo) \
        [ATNotificationUtils postNotificationName:atName object:atObject userInfo:atUserInfo];

#define ATPostNotificationDefaultWithUserInfo(atName, atUserInfo) \
        ATPostNotificationWithUserInfo(atName, self, atUserInfo)

#define ATUnRegisterAllNotification \
        [[NSNotificationCenter defaultCenter] removeObserver:self];

#define ATNotificationDefine(atName) \
        ATConstStringDefineWithDefaultValue(atName)

#define ATNotificationExtern(atName) \
        ATConstStringExtern(atName)

#define ATRegisterNotificationWithAutoSelectorName(atName) \
        ATRegisterNotification(atName, on##atName, self, nil)

#define ATNotificationHandlerWithAutoSelectorName(atName) \
        - (void)on##atName:(NSNotification *)notification

//KVO

#define ATRegisterKVOWithParameters(atObject, atPath, atOptions, atContext) \
        [atObject addObserver:self forKeyPath:@#atPath options:atOptions context:atContext]

#define ATRegisterKVODefaultWithObjectAndPath(atObject, atPath) \
        ATRegisterKVOWithParameters(atObject, atPath, NSKeyValueObservingOptionNew, NULL)

#define ATUnRegisterKVOWithObjectAndPath(atObject, atPath) \
        [atObject removeObserver:self forKeyPath:@#atPath];

#define ATKVOHandlerWithParameter_object_keyPath_change_context \
        - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

//Self
#define ATWeakSelf \
        __weak __typeof(self) weakSelf = self;

#define ATStrongSelf \
        __strong __typeof(weakSelf) strongSelf = weakSelf;

#define ATStrongSelfWithEnsureWeakSelf \
        if (!weakSelf) { return; } \
        ATStrongSelf

#define ATWeakify(obj) \
        __weak __typeof__(obj) obj##_weak_ = obj;

#define ATStrongify(obj) \
        __strong __typeof__(obj##_weak_) obj = obj##_weak_;

#define ATStrongifyEnsure(obj) \
        if (!obj##_weak_) { return; } \
        ATStrongify(obj)

//Singleton
#define DECLARE_SINGLETON \
+ (instancetype)sharedObject;

#define IMPLEMENT_SINGLETON(__TYPE__) \
+ (instancetype)sharedObject { \
    static dispatch_once_t __once; \
    static __TYPE__ *__instance = nil; \
    dispatch_once(&__once, ^{ \
        __instance = [[__TYPE__ alloc] init]; \
    }); \
    return __instance; \
}

//Color

#define ATRGBAColor(r, g, b, a) \
        [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define ATRGBColor(r, g, b) \
        ATRGBAColor(r, g, b, 1.0)

#define ATHexCOLOR(colorInHex) \
        [UIColor colorWithRed:((float)((colorInHex & 0xFF0000) >> 16))/255.0 \
                        green:((float)((colorInHex & 0xFF00) >> 8))/255.0 \
                         blue:((float)(colorInHex & 0xFF))/255.0 \
                        alpha:1.0]

#define ATHexACOLOR(colorInHex) \
        [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f \
                        green:((color >> 16) & 0xFF) / 255.0f \
                         blue:((color >> 8) & 0xFF) / 255.0f \
                        alpha:((color) & 0xFF) / 255.0f];

//Screen
#define ATScreenBounds ([UIScreen mainScreen].bounds)
#define ATScreenSize (ATScreenBounds.size)
#define ATScreenHeight (ATScreenSize.height)
#define ATScreenWidth (ATScreenSize.width)

#define ATScreenShort MIN(ATScreenHeight, ATScreenWidth)
#define ATScreenLong MAX(ATScreenHeight, ATScreenWidth)


//System
#define ATSystemAdvanceThan(systemOS) ([[UIDevice currentDevice].systemVersion floatValue] >= systemOS)
#define ATSystemLessThan(systemOS) ([[UIDevice currentDevice].systemVersion floatValue] < systemOS)


//Block
#define ATSafetyCallblock(block, ...) if((block)) { block(__VA_ARGS__); }


//Delay
#define ATDelay(sec, block) \
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), block);


