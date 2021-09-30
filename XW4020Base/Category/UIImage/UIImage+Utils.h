//
//  UIImage+Color.h
//  SCZW
//
//  Created by solehe on 2018/10/13.
//  Copyright © 2018年 solehe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utils)

//image
+ (UIImage *)imageNamed:(NSString *)name ofBundle:(NSString *)bundleName;

// 改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;

// 高斯模糊
- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur;

// 修改图片尺寸
- (UIImage *)imageWithSize:(CGSize)size;

// 将图片转位base64字符串
- (NSString *)base64String;

// 生成二维码
+ (UIImage *)imageWithString:(NSString *)string size:(CGSize)size;

// 将UIView转换成图片
+ (UIImage *)imageWithView:(UIView *)view;

// 对指定视图进行截图
+ (UIImage *)screenShotView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
