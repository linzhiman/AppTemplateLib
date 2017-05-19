//
//  ATWebViewJavaScriptBridge.h
//  yyfe
//
//  Created by linzhiman on 16/3/30.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 App与WebView页面交互规范
 1、App在WebView注入一个对象window.appJavaScriptBridge。
 2、页面JavaScript调用Native
 window.appJavaScriptBridge.callNative(command, argument);
 如果需要App回调，需将callback函数挂在window.appJavaScriptBridge，函数名自定义，如callbackName，并在argument中添加字段'callback':'callbackName'；
 其中callback函数定义为 function callbackName(command, argument)；
 注：为了兼容老版本，若没有callback参数，则回调默认的callback，即window.appJavaScriptBridge.callback(command, argument);
 3、Native调用页面JavaScript
 window.appJavaScriptBridge.callbackName(command, argument);
 4、参数说明
 command为 String，标记需要调用的方法；
 argument为 String，内容为JSON对象，调用方法需要的参数；App回调时为JSON对象；
 5、示例
 ATWebViewJavaScriptBridge.html
 6、注：如果command不支持，则回调H5，argument为{'errorCode':100,'errorMessage':'unknown command'};
 */

@class ATWebViewJavaScriptBridge;

@protocol ATWebViewJavaScriptBridgeAction <NSObject>

@property (nonatomic, weak) ATWebViewJavaScriptBridge *bridge;
@property (nonatomic, strong) NSString *customJavaScriptCode;

- (BOOL)actionWithCommand:(NSString *)command argument:(NSDictionary *)argument;

@end

@protocol ATWebViewContainerSupport <NSObject>

- (void)supportShareWithArgument:(NSDictionary *)argument;

@end

@interface ATWebViewJavaScriptBridge : NSObject<UIWebViewDelegate, ATWebViewContainerSupport>

- (void)registerAction:(id<ATWebViewJavaScriptBridgeAction>)action;
- (void)callJavaScriptWithCommand:(NSString *)command args:(NSDictionary *)argument callback:(NSString *)callback;
- (void)evaluateJavaScript:(NSString *)javaScriptCode;

+ (instancetype)bridgeForWebView:(UIWebView*)webView webViewDelegate:(id<UIWebViewDelegate, ATWebViewContainerSupport>)webViewDelegate;

@end

