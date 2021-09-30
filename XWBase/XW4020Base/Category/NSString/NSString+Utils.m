//
//  NSString+Trim.m
//  SCZW
//
//  Created by solehe on 2018/10/29.
//  Copyright © 2018 solehe. All rights reserved.
//

#import "NSString+Utils.h"
#import <UIKit/UIKit.h>
#import "XWMacrosDefine.h"
#import "NSString+Format.h"

@implementation NSString (Utils)

// 去除前后空白字符串
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 去除空白字符串
- (NSString *)trimAll {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// 去除字符串中的(null)
- (NSString *)trimNull {
    return [self stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

// url编码
- (NSString *)urlEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

// 身份证号码脱敏
- (NSString *)securetyIdentifityCardNo {
    if ([self isIdentifityCardNo]) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(0, 14) withString:@"********************"];
    }
    return self;
}

// 电话号码脱敏
- (NSString *)securetyTelPhoneNumber {
    if ([self isTelPhoneNumber]) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return self;
}

// 统一社会信用代码脱敏
- (NSString *)securetySetupCode {
    if (self.length > 12) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];;
    }
    return self;
}

// 真实姓名脱敏
- (NSString *)securetyRealName {
    if (self.length > 1) {
        NSMutableString *names = [NSMutableString string];
        for (int i=0; i<self.length-1; i++) {
            [names appendString:@"*"];
        }
        [names appendString:[self substringFromIndex:self.length-1]];
        return [names copy];
    }
    return self;
}

// Json字符串转字典
- (NSDictionary *)josnToDictionary {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
}

// 日期时间(字符串格式需为：MMM d, yyyy h:m:s aa)
- (NSString *)dateTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy h:m:s aa"];
    NSDate *date = [formatter dateFromString:self];
    // 重新格式化
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

- (NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy h:m:s aa"];
    NSDate *date = [formatter dateFromString:self];
    // 重新格式化
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

// 转为base64编码格式字符串
- (NSString *)base64String {
    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [encodeData base64EncodedStringWithOptions:0];
}

// base64编码格式的字符串转为普通字符串
- (NSString *)stringFromBase64 {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

// base64字符串转图片
- (UIImage *)base64ToImage {
    // 将base64字符串转为NSData
    NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:self options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    // 将NSData转为UIImage
    return [UIImage imageWithData: decodeData];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取字符串中的大写字母
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet uppercaseLetterCharacterSet] invertedSet];
    //获取并返回首字母
    return [[pinYin componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

// 获取拼音
- (NSString *)pinyin {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取拼音
    return [pinYin stringByReplacingOccurrencesOfString:@" " withString:@""].uppercaseString;
}

- (NSString *)URLDecodedString
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//产生10位随机字符
+ (NSString *)random10String
{
    //声明并赋值字符串长度变量
    static NSInteger kNumber = 10;
    //随机字符串产生的范围（可自定义）
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    //可变字符串
    NSMutableString *resultString = [NSMutableString string];
    //使用for循环拼接字符串
    for (NSInteger i = 0; i < kNumber; i++) {
        //36是sourceString的长度，也可以写成sourceString.length
        [resultString appendString:[sourceString substringWithRange:NSMakeRange(arc4random() % sourceString.length, 1)]];
    }
    NSLog(@"%@ %ld",resultString,resultString.length);
    return  resultString;
}

//转为16进制
- (NSString *)toHexStr{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++){
    NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

// 十六进制转换为普通字符串的。
- (NSString *)hexStrToString{ //
    char *myBuffer = (char *)malloc((int)[self length] / 2 + 1);
    bzero(myBuffer, [self length] / 2 + 1);
    for (int i = 0; i < [self length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
//    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

//文字宽度
- (CGFloat)widthWithFont:(UIFont *)font
{
    // 获取文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    // 根据文字样式计算文字所占大小
    // 文本最大宽度
    CGSize maxSize = CGSizeMake(kSCREEN_WIDTH, MAXFLOAT);
    // NSStringDrawingUsesLineFragmentOrigin -> 从头开始
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}
@end
