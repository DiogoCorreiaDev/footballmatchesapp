//
//  DateString.h
//  FootballMatchesDC
//
//  Created by user146165 on 9/24/18.
//  Copyright © 2018 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateString : NSObject

- (NSString *)getDateFromTodayPlusOrMinus:(NSInteger)days;

@end

NS_ASSUME_NONNULL_END
