//
//  ATImageUtils.h
//  AppTemplateLib
//
//  Created by linzhiman on 5/19/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATImageUtils : NSObject

+ (UIImage *)grayImage:(UIImage*)source;

+ (NSData *)getJPEGRepresentation:(UIImage *)image;

+ (CGSize)getImageSize:(NSData *)imageData maxAllowedSize:(int)maxAllowedSize;
+ (CGSize)getImageSizeFromFile:(NSString *)imagePath maxAllowedSize:(int)maxAllowedSize;

@end
