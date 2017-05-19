//
//  ATImageUtils.m
//  AppTemplateLib
//
//  Created by linzhiman on 5/19/15.
//  Copyright (c) 2015 apptemplate. All rights reserved.
//

#import "ATImageUtils.h"

@implementation ATImageUtils

+ (NSData *)getJPEGRepresentation:(UIImage *)image
{
    return UIImageJPEGRepresentation(image, 1.0);
}

+ (UIImage *)grayImage:(UIImage *)source
{
    UIImage *grayImage;
    
    int width = source.size.width;
    int height = source.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  (CGBitmapInfo)kCGImageAlphaNone);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,  CGRectMake(0, 0, width, height), source.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    grayImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    return grayImage;
}

+ (CGSize)getImageSize:(NSData *)imageData maxAllowedSize:(int)maxAllowedSize
{
    UIImage *image = [UIImage imageWithData:imageData];
    int width = image.size.width;
    int height = image.size.height;
    
    while (width > maxAllowedSize || height > maxAllowedSize ) {
        width >>= 1;
        height >>= 1;
    }
    return CGSizeMake(width, height);
}

+ (CGSize)getImageSizeFromFile:(NSString *)imagePath maxAllowedSize:(int)maxAllowedSize
{
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    return [self getImageSize:imageData maxAllowedSize:maxAllowedSize];
}

@end
