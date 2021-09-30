//
//  NSDate+Extend.m
//  SmartLock
//
//  Created by Sole on 2017/6/23.
//  Copyright © 2017年 sole. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)

- (BOOL)isAM {
    //获取系统是24小时制或者12小时制
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA =[formatStringForHours rangeOfString:@"a"];
    return containsA.location != NSNotFound;
}

- (NSString *)time {

    NSCalendar       *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *comps    = [[NSDateComponents alloc] init];
    NSInteger        unitFlags = NSCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour
    | kCFCalendarUnitMinute | kCFCalendarUnitSecond | kCFCalendarUnitWeekday;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    NSInteger hour  = [comps hour];
    NSInteger min   = [comps minute];
    
    if ([self isAM]) {
        
        if (hour < 12) {
            return [NSString stringWithFormat:@"%02ld:%02ld AM", hour, min];
        } else {
            return [NSString stringWithFormat:@"%02ld:%02ld PM", hour%12, min];
        }
        
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld", hour, min];
    }
    
}

- (NSString *)date {
 
    NSCalendar       *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *comps    = [[NSDateComponents alloc] init];
    NSInteger        unitFlags = NSCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour
    | kCFCalendarUnitMinute | kCFCalendarUnitSecond | kCFCalendarUnitWeekday;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    NSInteger year  = [comps year]; //取年分时间后两位
    NSInteger month = [comps month];
    NSInteger day   = [comps day];

    return [NSString stringWithFormat:@"%02ld/%02ld/%02ld", day, month, year%2000];
}

- (NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSDate转NSString
    return [dateFormatter stringFromDate:self];
}

- (NSString *)USDateString {
    //日期处理
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = kCFDateFormatterMediumStyle;
    dateFormatter.timeStyle = kCFDateFormatterMediumStyle;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)USShortDateString {
    //日期处理
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = kCFDateFormatterLongStyle;
    dateFormatter.timeStyle = kCFDateFormatterNoStyle;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)USShortTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = kCFDateFormatterNoStyle;
    dateFormatter.timeStyle = kCFDateFormatterShortStyle;
    return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

- (NSInteger)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}
- (NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    return [dayComponents month];
}
- (NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}
- (NSInteger)hour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | kCFCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return (NSInteger)hour;
}
- (NSInteger)min {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | kCFCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components minute];
    return (NSInteger)minute;
}
- (NSInteger)sec {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | kCFCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger second = [components second];
    return (NSInteger)second;
}

- (NSInteger)dayOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    return [weekdayComponents weekday];
}
- (NSInteger)weekOfYear {
    NSInteger i;
    NSInteger year = [self year];
    NSDate *date = [self endWeek];
    for (i = 1; [[date dateAfterDay:-7 * i] year] == year; i++);
    return i;
}
- (NSInteger)weeksOfMonth {
    return [[self endOfMonth] weekOfYear] - [[self beginOfMonth] weekOfYear] + 1;
}

- (NSDate *)dateAfterDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}
- (NSDate *)dateAfterMonth:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMonth;
}

- (NSDate *)endWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return endOfWeek;
}

- (NSDate *)beginOfMonth {
    return [self dateAfterDay:-[self day] + 1];
}

- (NSDate *)endOfMonth {
    return [[[self beginOfMonth] dateAfterMonth:1] dateAfterDay:-1];
}

// 时间字符串必须为yyyy-MM-dd HH:mm:ss
+ (NSDate *)dateWithString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:dateString];
}

// 多少天之前
+ (NSString *)timeWithChina:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [NSDate date];
    NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date];
    return [self timeBeforeInfoWithString:aTimer];
}


// 多少天之前
+ (NSString *)timeBeforeInfoWithString:(NSTimeInterval)timeIntrval{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //获取此时时间戳长度
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    int timeInt = nowTimeinterval - timeIntrval; //时间差
    
    int year = timeInt / (3600 * 24 * 30 *12);
    int month = timeInt / (3600 * 24 * 30);
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;
    int second = timeInt;
    if (year > 0) {
        return [NSString stringWithFormat:@"%d年前",year];
    }else if(month > 0){
        return [NSString stringWithFormat:@"%d个月前",month];
    }else if(day > 0){
        return [NSString stringWithFormat:@"%d天前",day];
    }else if(hour > 0){
        return [NSString stringWithFormat:@"%d小时前",hour];
    }else if(minute > 0){
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }else{
        return [NSString stringWithFormat:@"刚刚"];
    }
}

+ (NSString *)timeFromTimestamp:(NSString *)timString{

    //将对象类型的时间转换为NSDate类型
    double time = [timString doubleValue];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

+ (NSString *)timeYMDFromTimestamp:(NSString *)timString{

    //将对象类型的时间转换为NSDate类型
    double time = [timString doubleValue]/1000.0;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

+ (NSString *)youxiaoqi:(long)timeString
{
    if(timeString == 0){
        return @"——";
    }
    //将对象类型的时间转换为NSDate类型
    double time = timeString/1000.0;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

+ (NSString *)getTimeFromTimestamp:(NSString *)timString{

    //将对象类型的时间转换为NSDate类型

    double time = [timString doubleValue];

    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //将时间转换为字符串

    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}


//获取当前时间日期星期
- (NSString *)getCurrentTimeAndWeekDay {
    
    NSArray * arrWeek= [NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    //ios 8.0 之后 不想看见警告用下面这个
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    /*
     NSInteger unitFlags = NSYearCalendarUnit |
     NSMonthCalendarUnit |
     NSDayCalendarUnit |
     NSWeekdayCalendarUnit |
     NSHourCalendarUnit |
     NSMinuteCalendarUnit |
     NSSecondCalendarUnit;
     */
    //ios 8.0 之后 不想看见警告用下面这个
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    long week = [comps weekday]-1;
//    long year=[comps year];
    long month = [comps month];
    long day = [comps day];
    return   [NSString stringWithFormat:@"%ld-%ld  %@",month,day,[arrWeek objectAtIndex:week]];
//    return   [NSString stringWithFormat:@"%d-%d-%d  %@",year,month,day,[arrWeek objectAtIndex:week]];
}


- (long long)dateToMilliSeconds
{
    NSTimeInterval interval = [self timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
//    return [NSString stringWithFormat:@"%lld",totalMilliseconds];
}


+(NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}

@end
