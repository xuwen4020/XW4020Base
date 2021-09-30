//
//  UIImage+Color.m
//  SCZW
//
//  Created by solehe on 2018/10/13.
//  Copyright © 2018年 solehe. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)imageNamed:(NSString *)name ofBundle:(NSString *)bundleName {

    UIImage *image = nil;

    NSString *image_name = [NSString stringWithFormat:@"%@.png", name];

    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];

    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];

    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];;

    image = [[UIImage alloc] initWithContentsOfFile:image_path];

    return image;
    
}
/**
 image_path    NSPathStore2 *    @"/private/var/containers/Bundle/Application/062D85EF-A252-41D7-A030-59A6E7C5D214/德阳市民通.app/blue.bundle/mineblue.png"    0x0000000281bf3a00
 */

- (UIImage *)imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    //设置模糊程度
    [filter setValue:@(blur) forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage:result fromRect:ciImage.extent];
    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

- (UIImage *)imageWithSize:(CGSize)size {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)base64String {
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)imageWithString:(NSString *)string size:(CGSize)size {
    
    NSData *stringData = [string dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}


+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 对指定视图进行截图
+ (UIImage *)screenShotView:(UIView *)view
{
    UIImage *imageRet = [[UIImage alloc]init];
    if (view)
    {
        if(UIGraphicsBeginImageContextWithOptions)
        {
            UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
        }else{
            UIGraphicsBeginImageContext(view.frame.size);
        }
        //获取图像
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        imageRet = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
    }
    return imageRet;
}

@end
