//
//  DateString.m
//  FootballMatchesDC
//
//  Created by user146165 on 9/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import "DateString.h"

@implementation DateString

- (NSString *)getDateFromTodayPlusOrMinus:(NSInteger)days {
    
    NSDate *today = [NSDate date];
    NSLog(@"ENTROU: %@",today);
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    comps.day = days;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* daySelected = [calendar dateByAddingComponents:comps toDate:today options:0];
    NSLog(@"DIA SELEC: %@",daySelected);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *year = [formatter stringFromDate:daySelected];
    [formatter setDateFormat:@"MM"];
    NSString *month = [formatter stringFromDate:daySelected];
    [formatter setDateFormat:@"dd"];
    NSString *day = [formatter stringFromDate:daySelected];
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    NSLog(@"DATE: %@",date);
    
    return date;
    
}
@end
