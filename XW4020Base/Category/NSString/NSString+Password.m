//
//  NSString+Password.m
//  SCGOV
//
//  Created by solehe on 2019/5/29.
//  Copyright © 2019 Enrising. All rights reserved.
//

#import "NSString+Password.h"
#import "NSString+Format.h"

/** 数字类型*/
static int NUM = 1;
/** 小写字母*/
static int SMALL_LETTER = 2;
/** 大写字母*/
static int CAPITAL_LETTER = 3;
/** 其他字符*/
static int OTHER_CHAR = 4;

@implementation NSString (Password)

//  常用简易密码字典
- (NSArray<NSString *> *)commonUsers {
    return @[];
}

/**
 检查字符的类型，包括数字、大写字母、小写字母等字符。
 
 @param character 字符
 @return 字符类型
 */
NSInteger checkCharacterType (NSString *character) {
    int asciiCode = [character characterAtIndex:0];
    if (asciiCode >= 48 && asciiCode <= 57) {
        return NUM;
    }
    if (asciiCode >= 65 && asciiCode <= 90) {
        return CAPITAL_LETTER;
    }
    if (asciiCode >= 97 && asciiCode <= 122) {
        return SMALL_LETTER;
    }
    return OTHER_CHAR;
}


/**
 按不同类型计算密码
 
 @param password 密码
 @param type 类型
 @return countLetter
 */
NSInteger countLetter (NSString *password, NSInteger type) {
    int count = 0;
    if (password != nil && password.length) {
        for (NSUInteger i = 0; i < password.length; i ++) {
            //  [password characterAtIndex:i] 只适合不包含中文的字符串
            NSString *character = [password substringWithRange:NSMakeRange(i, 1)];
            if (checkCharacterType(character) == type) {
                count ++;
            }
        }
    }
    return count;
}

/**
 检查密码强度
 
 @return 强度
 */
- (NSInteger)checkPasswordStrength {
    if ([self isNull] || [self isCharEqual]) {
        return 0;
    }
    NSInteger len = self.length;
    __block NSInteger level = 0;
    
    // increase points
    if (countLetter(self, NUM) > 0) {
        level++;
    }
    if (countLetter(self, SMALL_LETTER) > 0) {
        level++;
    }
    if (len > 4 && countLetter(self, CAPITAL_LETTER) > 0) {
        level++;
    }
    if (len > 6 && countLetter(self, OTHER_CHAR) > 0) {
        level++;
    }
    
    if ((len > 4 && countLetter(self, NUM) > 0 && countLetter(self, SMALL_LETTER) > 0)
        || (countLetter(self, NUM) > 0 && countLetter(self, CAPITAL_LETTER) > 0)
        || (countLetter(self, NUM) > 0 && countLetter(self, OTHER_CHAR) > 0)
        || (countLetter(self, SMALL_LETTER) > 0 && countLetter(self, CAPITAL_LETTER) > 0)
        || (countLetter(self, SMALL_LETTER) > 0 && countLetter(self, OTHER_CHAR) > 0)
        || (countLetter(self, CAPITAL_LETTER) > 0 && countLetter(self, OTHER_CHAR) > 0)) {
        level++;
    }
    
    if ((len > 6 && countLetter(self, NUM) > 0 && countLetter(self, SMALL_LETTER) > 0 && countLetter(self, CAPITAL_LETTER) > 0)
        || (countLetter(self, NUM) > 0 && countLetter(self, SMALL_LETTER) > 0 && countLetter(self, OTHER_CHAR) > 0)
        || (countLetter(self, NUM) > 0 && countLetter(self, CAPITAL_LETTER) > 0 && countLetter(self, OTHER_CHAR) > 0)
        || (countLetter(self, SMALL_LETTER) > 0 && countLetter(self, CAPITAL_LETTER) > 0 && countLetter(self, OTHER_CHAR) > 0)) {
        level++;
    }
    
    if (len > 8 && countLetter(self, NUM) > 0 && countLetter(self, SMALL_LETTER) > 0 && countLetter(self, CAPITAL_LETTER) > 0 && countLetter(self, OTHER_CHAR) > 0) {
        level++;
    }
    
    if ((len > 6 && countLetter(self, NUM) >= 3 && countLetter(self, SMALL_LETTER) >= 3)
        || (countLetter(self, NUM) >= 3 && countLetter(self, CAPITAL_LETTER) >= 3)
        || (countLetter(self, NUM) >= 3 && countLetter(self, OTHER_CHAR) >= 2)
        || (countLetter(self, SMALL_LETTER) >= 3 && countLetter(self, CAPITAL_LETTER) >= 3)
        || (countLetter(self, SMALL_LETTER) >= 3 && countLetter(self, OTHER_CHAR) >= 2)
        || (countLetter(self, CAPITAL_LETTER) >= 3 && countLetter(self, OTHER_CHAR) >= 2)) {
        level++;
    }
    
    if ((len > 8 && countLetter(self, NUM) >= 2 && countLetter(self, SMALL_LETTER) >= 2 && countLetter(self, CAPITAL_LETTER) >= 2)
        || (countLetter(self, NUM) >= 2 && countLetter(self, SMALL_LETTER) >= 2 && countLetter(self, OTHER_CHAR) >= 2)
        || (countLetter(self, NUM) >= 2 && countLetter(self, CAPITAL_LETTER) >= 2 && countLetter(self, OTHER_CHAR) >= 2)
        || (countLetter(self, SMALL_LETTER) >= 2 && countLetter(self, CAPITAL_LETTER) >= 2 && countLetter(self, OTHER_CHAR) >= 2)) {
        level++;
    }
    
    if (len > 10 && countLetter(self, NUM) >= 2 && countLetter(self, SMALL_LETTER) >= 2 && countLetter(self, CAPITAL_LETTER) >= 2 && countLetter(self, OTHER_CHAR) >= 2) {
        level++;
    }
    
    if (countLetter(self, OTHER_CHAR) >= 3) {
        level++;
    }
    if (countLetter(self, OTHER_CHAR) >= 6) {
        level++;
    }
    
    if (len > 12) {
        level++;
        if (len >= 16) {
            level++;
        }
    }
    
    // decrease points
    if ([@"abcdefghijklmnopqrstuvwxyz" containsString:self] || [@"ABCDEFGHIJKLMNOPQRSTUVWXYZ" containsString:self]) {
        level --;
    }
    if ([@"qwertyuiop" containsString:self] || [@"asdfghjkl" containsString:self] || [@"zxcvbnm" containsString:self]) {
        level--;
    }
    if (([self isNumeric] && [@"01234567890" containsString:self]) || [@"09876543210" containsString:self]) {
        level--;
    }
    if (countLetter(self, NUM) == len || countLetter(self, SMALL_LETTER) == len || countLetter(self, CAPITAL_LETTER) == len) {
        level--;
    }
    
    if (len % 2 == 0) { // aaabbb
        NSString *part1 = [self substringWithRange:NSMakeRange(0, len / 2)];
        NSString *part2 = [self substringFromIndex:len / 2];
        if ([part1 isEqualToString:part2]) {
            level--;
        }
        if ([part1 isCharEqual] && [part2 isCharEqual]) {
            level--;
        }
    }
    if (len % 3 == 0) { // ababab
        NSString *part1 = [self substringWithRange:NSMakeRange(0, len / 3)];
        NSString *part2 = [self substringWithRange:NSMakeRange(len / 3, len / 3)];
        NSString *part3 = [self substringFromIndex:len / 3];
        if ([part1 isEqualToString:part2] && [part2 isEqualToString:part3]) {
            level--;
        }
    }
    if ([self isNumeric] && len >= 6) { // 19881010 or 881010
        NSInteger year = 0;
        if (len == 8 || len == 6) {
            year = [self substringToIndex:self.length - 4].integerValue;
        }
        NSInteger size = len - 4;
        NSInteger month = [self substringWithRange:NSMakeRange(size, 2)].integerValue;
        NSInteger day = [self substringWithRange:NSMakeRange(size + 2, 2)].integerValue;
        if ((year >= 1950 && year < 2050) && (month >= 1 && month <= 12) && (day >= 1 && day <= 31)) {
            level--;
        }
    }
    [[self commonUsers] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:self] || [obj containsString:self]) {
            level --;
            *stop = YES;
        }
    }];
    
    if (len <= 6) {
        level--;
        if (len <= 4) {
            level--;
            if (len <= 3) {
                level = 0;
            }
        }
    }
    if (level < 0) {
        level = 0;
    }
    return level;
}

/**
 获取密码强度等级，包括easy, midium, strong, very strong, extremely strong
 
 @return 密码强度
 */
- (PwdStrengthLevel)passwordLevel {
    NSInteger level = [self checkPasswordStrength];
    switch (level) {
        case 0:
        case 1:
        case 2:
        case 3:
            return PwdStrengthLevelEasy;
        case 4:
        case 5:
        case 6:
            return PwdStrengthLevelMidium;
        case 7:
        case 8:
        case 9:
            return PwdStrengthLevelStrong;
        case 10:
        case 11:
        case 12:
            return PwdStrengthLevelVeryStrong;
        default:
            return PwdStrengthLevelExtlyStrong;
    }
}

/**
 判断字符串是 空格、空("")还是null。
 @return 判空
 */
- (BOOL)isNull {
    if (self == nil || self == NULL || !self.length || [self isEqual:NSNull.null]) {
        return YES;
    }
    return NO;
}

/**
 判断字符串中的每个字符是否相等
 
 @return 判断结果
 */
- (BOOL)isCharEqual {
    if (!self.length) {
        return YES;
    }
    NSString *character = [self substringWithRange:NSMakeRange(0, 1)];
    NSString *string = [self stringByReplacingOccurrencesOfString:character withString:@""];
    return !string.length;
}

/**
 确定字符串是否为数字
 
 @return 是不是纯数字
 */
- (BOOL)isNumeric {
    if (!self.length) {
        return NO;
    }
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]*$"];
    return [regex evaluateWithObject:self];
}

/**
 获取密码强度

 @return 密码强度
 */
- (PwdStrengthLevel)pwdlevel {
    if (self.length < 6 || self.length > 16) {
        return PwdStrengthLevelInvalid;
    } else if ([self isNumber] || [self isLetters] || ![self isLawfulPwd]) {
        return PwdStrengthLevelEasy;
    } else if ([self isNumAndLetters] || [self isLettersAndSymbol] ||
               [self isNumAndSymbol] || ([self isContainAll] && self.length <=9)) {
        return PwdStrengthLevelMidium;
    } else {
        return PwdStrengthLevelStrong;
    }
}

// 判断是否全为z数字
- (BOOL)isNumber {
    NSString *str = [self copy];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}

// 判断是否是纯字母
- (BOOL)isLetters {
    for (int i=0; i<self.length; i++){
        unichar c = [self characterAtIndex:i];
        if((c<'A'||c>'Z')&&(c<'a'||c>'z')) {
            return NO;
        }
    }
    return YES;
}

// 判断是否包含字母和数字
- (BOOL)isNumAndLetters {
    NSString *str = [self copy];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}

// 判断是否为字母和特殊字符
- (BOOL)isLettersAndSymbol {
    NSString *str = [self copy];
    str = [str stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
    
}

// 判断是否为数字和特殊字符
- (BOOL)isNumAndSymbol {
    NSString *str = [self copy];
    str = [str stringByTrimmingCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]];
    if(str.length > 0) {
        return NO;
    }
    return YES;
}

// 是否同时包含数字、字母和数字
- (BOOL)isContainAll {
    return [self isNumAndLetters] && [self isNumAndSymbol] && [self isLettersAndSymbol];
}



@end
